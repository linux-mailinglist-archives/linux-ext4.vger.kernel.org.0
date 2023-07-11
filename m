Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7F9B74E56F
	for <lists+linux-ext4@lfdr.de>; Tue, 11 Jul 2023 05:43:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbjGKDnl (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 10 Jul 2023 23:43:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjGKDnl (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 10 Jul 2023 23:43:41 -0400
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FED7E5;
        Mon, 10 Jul 2023 20:43:39 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=liusong@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0Vn6pkIv_1689046976;
Received: from localhost(mailfrom:liusong@linux.alibaba.com fp:SMTPD_---0Vn6pkIv_1689046976)
          by smtp.aliyun-inc.com;
          Tue, 11 Jul 2023 11:43:36 +0800
From:   Liu Song <liusong@linux.alibaba.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        liusong@linux.alibaba.com
Subject: [PATCH] ext4: do not mark inode dirty which is already dirtied under append-write scenario
Date:   Tue, 11 Jul 2023 11:42:56 +0800
Message-Id: <20230711034256.72651-1-liusong@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

In the append-write scenario, after ensuring that the dirty inode can be
seen by the writeback process, there is no need to execute
"mark_inode_dirty" for every write. Instead, we can rely on
"ext4_mark_inode_dirty" executed when updating i_disksize in
"mpage_map_and_submit_extent" to ensure data consistency, which can
significantly improve performance in high-frequency append-write
scenarios.

In test scenarios of Kafka version 2.6.2, using packet size of 2K
resulted in a 10% performance improvement.

Signed-off-by: Liu Song <liusong@linux.alibaba.com>
---
 fs/ext4/inode.c | 58 +++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 56 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 9d9f414f99fe..d1aa775c9936 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3128,6 +3128,57 @@ static int ext4_da_should_update_i_disksize(struct page *page,
 	return 1;
 }
 
+/*
+ * Copy from generic_write_end, add conditions to execute mark_inode_dirty
+ * to avoid additional overhead caused by frequent dirty inode operations
+ */
+static int ext4_da_generic_write_end(struct file *file, struct address_space *mapping,
+			loff_t pos, unsigned len, unsigned copied, bool need_dirty,
+			struct page *page, void *fsdata)
+{
+	struct inode *inode = mapping->host;
+	loff_t old_size = inode->i_size;
+	bool i_size_changed = false;
+	int was_dirty;
+
+	copied = block_write_end(file, mapping, pos, len, copied, page, fsdata);
+
+	/*
+	 * No need to use i_size_read() here, the i_size cannot change under us
+	 * because we hold i_rwsem.
+	 *
+	 * But it's important to update i_size while still holding page lock:
+	 * page writeout could otherwise come in and zero beyond i_size.
+	 */
+	if (pos + copied > inode->i_size) {
+		i_size_write(inode, pos + copied);
+		i_size_changed = true;
+	}
+
+	unlock_page(page);
+	put_page(page);
+
+	if (old_size < pos)
+		pagecache_isize_extended(inode, old_size, pos);
+
+	/*
+	 * In the append-write scenario, if the inode is marked as dirty,
+	 * it is ensured that the inode will be seen by the writeback process.
+	 * In the ext4_writepages process, when updating i_disksize,
+	 * corresponding metadata updates are also performed.
+	 * Therefore, it is unnecessary to repeatedly execute mark_inode_dirty
+	 * to improve performance.
+	 */
+	if (i_size_changed) {
+		spin_lock(&inode->i_lock);
+		was_dirty = inode->i_state & I_DIRTY;
+		spin_unlock(&inode->i_lock);
+		if (!was_dirty || need_dirty)
+			mark_inode_dirty(inode);
+	}
+	return copied;
+}
+
 static int ext4_da_write_end(struct file *file,
 			     struct address_space *mapping,
 			     loff_t pos, unsigned len, unsigned copied,
@@ -3137,6 +3188,7 @@ static int ext4_da_write_end(struct file *file,
 	loff_t new_i_size;
 	unsigned long start, end;
 	int write_mode = (int)(unsigned long)fsdata;
+	bool need_dirty = false;
 
 	if (write_mode == FALL_BACK_TO_NONDELALLOC)
 		return ext4_write_end(file, mapping, pos,
@@ -3169,10 +3221,12 @@ static int ext4_da_write_end(struct file *file,
 	 */
 	new_i_size = pos + copied;
 	if (copied && new_i_size > inode->i_size &&
-	    ext4_da_should_update_i_disksize(page, end))
+	    ext4_da_should_update_i_disksize(page, end)) {
 		ext4_update_i_disksize(inode, new_i_size);
+		need_dirty = true;
+	}
 
-	return generic_write_end(file, mapping, pos, len, copied, page, fsdata);
+	return ext4_da_generic_write_end(file, mapping, pos, len, copied, need_dirty, page, fsdata);
 }
 
 /*
-- 
2.19.1.6.gb485710b

