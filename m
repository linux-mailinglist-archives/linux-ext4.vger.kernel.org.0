Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B66ED6458FB
	for <lists+linux-ext4@lfdr.de>; Wed,  7 Dec 2022 12:27:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbiLGL1s (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 7 Dec 2022 06:27:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbiLGL10 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 7 Dec 2022 06:27:26 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A3C6167FC
        for <linux-ext4@vger.kernel.org>; Wed,  7 Dec 2022 03:27:25 -0800 (PST)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id BCA0E21CA2;
        Wed,  7 Dec 2022 11:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1670412443; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HYf0IkhECOZNgwrdtQYX1MrqB3mq4jpEBMupUm5ruSY=;
        b=JT4j9D9OrapF3VONhUdcBv3L4360wR0NZ1lHWjkRUCjNPkGUWdXkEWZvaLbQnX7dIIwM6w
        j3VrhvyRimZNiLdTebcPdYzu4RoAyQ8KiV02eBQDL0YzC13pN45dRccikk5Enr+TF+ymwE
        p3pyE2MSghIZ8KUWfnRg+fkXV/g3qzk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1670412443;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HYf0IkhECOZNgwrdtQYX1MrqB3mq4jpEBMupUm5ruSY=;
        b=drg5lzTtRif9dJKI4wd/JsjCFpf01H5GhvwzXuwd4pIs0cTTxDIKbieT+uPicV6zTb8Tyi
        T5qPL01gSoIx3BAQ==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id AE77113732;
        Wed,  7 Dec 2022 11:27:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id UdqUKpt4kGM/LAAAGKfGzw
        (envelope-from <jack@suse.cz>); Wed, 07 Dec 2022 11:27:23 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id E367AA072C; Wed,  7 Dec 2022 12:27:22 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH v4 05/13] ext4: Add support for writepages calls that cannot map blocks
Date:   Wed,  7 Dec 2022 12:27:08 +0100
Message-Id: <20221207112722.22220-5-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221207112259.8143-1-jack@suse.cz>
References: <20221207112259.8143-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4315; i=jack@suse.cz; h=from:subject; bh=vklnG3keGZI1aQNoUJl4qzV4oTftyblr0jtEzrr4S7M=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBjkHiMDoc29oZyu4a+sEkq/V07JalCSVS+HyXs3J4V 7W+DkSeJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCY5B4jAAKCRCcnaoHP2RA2diNB/ 9guPd8Uut9eMX4Zp4rg6jp7cvfPNtB8hIbhN6oqBUMh4V5D/whs83uEUUuxr9U4gqxmuTwyI+FIhlm 0IRwX1+71gMidb0kaE4OV/yEG0eUQdCcw3bU6yIBTLffT4THI2mvupe2Ki0VzF/gpn0L+eYrGullvn T2LZ1otDAP3+3/7wJ9gY6DOMRHne40NjArTePizOV6DaEF4INcgRw1pR/83pYL4t+/L7ovckj/3C6y FCPqb18j5lKmN46tnrI8DZ28pqm91KUfGo7bDtqEx0W3y4YAH/vw+Ttcti/8A4bYWv+qPHEqI5R7Cm wmKbqya+fx2PDZIRQF3Y4kt26c9AGX
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Add support for calls to ext4_writepages() than cannot map blocks. These
will be issued from jbd2 transaction commit code.

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/inode.c | 62 ++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 48 insertions(+), 14 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 43eb175d0c1c..9ba843b7a92c 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1557,6 +1557,7 @@ struct mpage_da_data {
 	struct ext4_map_blocks map;
 	struct ext4_io_submit io_submit;	/* IO submission data */
 	unsigned int do_map:1;
+	unsigned int can_map:1;	/* Can writepages call map blocks? */
 	unsigned int scanned_until_end:1;
 };
 
@@ -2549,18 +2550,33 @@ static int ext4_da_writepages_trans_blocks(struct inode *inode)
 				MAX_WRITEPAGES_EXTENT_LEN + bpp - 1, bpp);
 }
 
+/* Return true if the page needs to be written as part of transaction commit */
+static bool ext4_page_nomap_can_writeout(struct page *page)
+{
+	struct buffer_head *bh, *head;
+
+	bh = head = page_buffers(page);
+	do {
+		if (buffer_dirty(bh) && buffer_mapped(bh) && !buffer_delay(bh))
+			return true;
+	} while ((bh = bh->b_this_page) != head);
+	return false;
+}
+
 /*
  * mpage_prepare_extent_to_map - find & lock contiguous range of dirty pages
- * 				 and underlying extent to map
+ * 				 needing mapping, submit mapped pages
  *
  * @mpd - where to look for pages
  *
  * Walk dirty pages in the mapping. If they are fully mapped, submit them for
- * IO immediately. When we find a page which isn't mapped we start accumulating
- * extent of buffers underlying these pages that needs mapping (formed by
- * either delayed or unwritten buffers). We also lock the pages containing
- * these buffers. The extent found is returned in @mpd structure (starting at
- * mpd->lblk with length mpd->len blocks).
+ * IO immediately. If we cannot map blocks, we submit just already mapped
+ * buffers in the page for IO and keep page dirty. When we can map blocks and
+ * we find a page which isn't mapped we start accumulating extent of buffers
+ * underlying these pages that needs mapping (formed by either delayed or
+ * unwritten buffers). We also lock the pages containing these buffers. The
+ * extent found is returned in @mpd structure (starting at mpd->lblk with
+ * length mpd->len blocks).
  *
  * Note that this function can attach bios to one io_end structure which are
  * neither logically nor physically contiguous. Although it may seem as an
@@ -2651,14 +2667,30 @@ static int mpage_prepare_extent_to_map(struct mpage_da_data *mpd)
 			if (mpd->map.m_len == 0)
 				mpd->first_page = page->index;
 			mpd->next_page = page->index + 1;
-			/* Add all dirty buffers to mpd */
-			lblk = ((ext4_lblk_t)page->index) <<
-				(PAGE_SHIFT - blkbits);
-			head = page_buffers(page);
-			err = mpage_process_page_bufs(mpd, head, head, lblk);
-			if (err <= 0)
-				goto out;
-			err = 0;
+			/*
+			 * Writeout for transaction commit where we cannot
+			 * modify metadata is simple. Just submit the page.
+			 */
+			if (!mpd->can_map) {
+				if (ext4_page_nomap_can_writeout(page)) {
+					err = mpage_submit_page(mpd, page);
+					if (err < 0)
+						goto out;
+				} else {
+					unlock_page(page);
+					mpd->first_page++;
+				}
+			} else {
+				/* Add all dirty buffers to mpd */
+				lblk = ((ext4_lblk_t)page->index) <<
+					(PAGE_SHIFT - blkbits);
+				head = page_buffers(page);
+				err = mpage_process_page_bufs(mpd, head, head,
+							      lblk);
+				if (err <= 0)
+					goto out;
+				err = 0;
+			}
 			left--;
 		}
 		pagevec_release(&pvec);
@@ -2778,6 +2810,7 @@ static int ext4_writepages(struct address_space *mapping,
 	 */
 	mpd.do_map = 0;
 	mpd.scanned_until_end = 0;
+	mpd.can_map = 1;
 	mpd.io_submit.io_end = ext4_init_io_end(inode, GFP_KERNEL);
 	if (!mpd.io_submit.io_end) {
 		ret = -ENOMEM;
@@ -2801,6 +2834,7 @@ static int ext4_writepages(struct address_space *mapping,
 			break;
 		}
 
+		WARN_ON_ONCE(!mpd->can_map);
 		/*
 		 * We have two constraints: We find one extent to map and we
 		 * must always write out whole page (makes a difference when
-- 
2.35.3

