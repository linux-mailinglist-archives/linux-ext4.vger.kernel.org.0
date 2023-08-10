Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10414777C88
	for <lists+linux-ext4@lfdr.de>; Thu, 10 Aug 2023 17:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbjHJPpC (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 10 Aug 2023 11:45:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232779AbjHJPpB (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 10 Aug 2023 11:45:01 -0400
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50DA926A9;
        Thu, 10 Aug 2023 08:44:59 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R621e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=liusong@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VpUBrS-_1691682213;
Received: from localhost(mailfrom:liusong@linux.alibaba.com fp:SMTPD_---0VpUBrS-_1691682213)
          by smtp.aliyun-inc.com;
          Thu, 10 Aug 2023 23:44:55 +0800
From:   Liu Song <liusong@linux.alibaba.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        joseph.qi@linux.alibaba.com, liusong@linux.alibaba.com
Subject: [PATCH v2] ext4: do not mark inode dirty every time in delalloc append write scenario
Date:   Thu, 10 Aug 2023 23:43:33 +0800
Message-Id: <20230810154333.84921-1-liusong@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

In the delalloc append write scenario, if inode's i_size is extended due
to buffer write, there are delalloc writes pending in the range up to
i_size, and no need to touch i_disksize since writeback will push
i_disksize up to i_size eventually. Offers significant performance
improvement in high-frequency append write scenarios.

I conducted tests in my 32-core environment by launching 32 concurrent
threads to append write to the same file. Each write operation had a
length of 1024 bytes and was repeated 100000 times. Without using this
patch, the test was completed in 7705 ms. However, with this patch, the
test was completed in 5066 ms, resulting in a performance improvement of
34%.

Moreover, in test scenarios of Kafka version 2.6.2, using packet size of
2K, with this patch resulted in a 10% performance improvement.

Signed-off-by: Liu Song <liusong@linux.alibaba.com>
Suggested-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/inode.c | 88 ++++++++++++++++++++++++++++++++++---------------
 1 file changed, 62 insertions(+), 26 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 89737d5a1614..830b8e7e68cb 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -2937,14 +2937,73 @@ static int ext4_da_should_update_i_disksize(struct folio *folio,
 	return 1;
 }
 
+static int ext4_da_do_write_end(struct address_space *mapping,
+			loff_t pos, unsigned len, unsigned copied,
+			struct page *page)
+{
+	struct inode *inode = mapping->host;
+	loff_t old_size = inode->i_size;
+	bool disksize_changed = false;
+	loff_t new_i_size;
+
+	/*
+	 * block_write_end() will mark the inode as dirty with I_DIRTY_PAGES
+	 * flag, which all that's needed to trigger page writeback.
+	 */
+	copied = block_write_end(NULL, mapping, pos, len, copied, page, NULL);
+	new_i_size = pos + copied;
+
+	/*
+	 * It's important to update i_size while still holding page lock,
+	 * because page writeout could otherwise come in and zero beyond
+	 * i_size.
+	 *
+	 * Since we are holding inode lock, we are sure i_disksize <=
+	 * i_size. We also know that if i_disksize < i_size, there are
+	 * delalloc writes pending in the range up to i_size. If the end of
+	 * the current write is <= i_size, there's no need to touch
+	 * i_disksize since writeback will push i_disksize up to i_size
+	 * eventually. If the end of the current write is > i_size and
+	 * inside an allocated block which ext4_da_should_update_i_disksize()
+	 * checked, we need to update i_disksize here as certain
+	 * ext4_writepages() paths not allocating blocks and update i_disksize.
+	 */
+	if (new_i_size > inode->i_size) {
+		unsigned long end;
+
+		i_size_write(inode, new_i_size);
+		end = (new_i_size - 1) & (PAGE_SIZE - 1);
+		if (copied && ext4_da_should_update_i_disksize(page_folio(page), end)) {
+			ext4_update_i_disksize(inode, new_i_size);
+			disksize_changed = true;
+		}
+	}
+
+	unlock_page(page);
+	put_page(page);
+
+	if (old_size < pos)
+		pagecache_isize_extended(inode, old_size, pos);
+
+	if (disksize_changed) {
+		handle_t *handle;
+
+		handle = ext4_journal_start(inode, EXT4_HT_INODE, 2);
+		if (IS_ERR(handle))
+			return PTR_ERR(handle);
+		ext4_mark_inode_dirty(handle, inode);
+		ext4_journal_stop(handle);
+	}
+
+	return copied;
+}
+
 static int ext4_da_write_end(struct file *file,
 			     struct address_space *mapping,
 			     loff_t pos, unsigned len, unsigned copied,
 			     struct page *page, void *fsdata)
 {
 	struct inode *inode = mapping->host;
-	loff_t new_i_size;
-	unsigned long start, end;
 	int write_mode = (int)(unsigned long)fsdata;
 	struct folio *folio = page_folio(page);
 
@@ -2963,30 +3022,7 @@ static int ext4_da_write_end(struct file *file,
 	if (unlikely(copied < len) && !PageUptodate(page))
 		copied = 0;
 
-	start = pos & (PAGE_SIZE - 1);
-	end = start + copied - 1;
-
-	/*
-	 * Since we are holding inode lock, we are sure i_disksize <=
-	 * i_size. We also know that if i_disksize < i_size, there are
-	 * delalloc writes pending in the range upto i_size. If the end of
-	 * the current write is <= i_size, there's no need to touch
-	 * i_disksize since writeback will push i_disksize upto i_size
-	 * eventually. If the end of the current write is > i_size and
-	 * inside an allocated block (ext4_da_should_update_i_disksize()
-	 * check), we need to update i_disksize here as certain
-	 * ext4_writepages() paths not allocating blocks update i_disksize.
-	 *
-	 * Note that we defer inode dirtying to generic_write_end() /
-	 * ext4_da_write_inline_data_end().
-	 */
-	new_i_size = pos + copied;
-	if (copied && new_i_size > inode->i_size &&
-	    ext4_da_should_update_i_disksize(folio, end))
-		ext4_update_i_disksize(inode, new_i_size);
-
-	return generic_write_end(file, mapping, pos, len, copied, &folio->page,
-				 fsdata);
+	return ext4_da_do_write_end(mapping, pos, len, copied, &folio->page);
 }
 
 /*
-- 
2.19.1.6.gb485710b

