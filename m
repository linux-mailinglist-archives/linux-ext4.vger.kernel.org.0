Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C813164287A
	for <lists+linux-ext4@lfdr.de>; Mon,  5 Dec 2022 13:29:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbiLEM3k (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 5 Dec 2022 07:29:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231443AbiLEM3c (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 5 Dec 2022 07:29:32 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A271817077
        for <linux-ext4@vger.kernel.org>; Mon,  5 Dec 2022 04:29:31 -0800 (PST)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2232421E02;
        Mon,  5 Dec 2022 12:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1670243370; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HYf0IkhECOZNgwrdtQYX1MrqB3mq4jpEBMupUm5ruSY=;
        b=tSYuL0MiXVQuQ7T37NhP5Snrj+uM2qI/lorTlABWOC6lN//bKSFe6jnA+pukoXH91thu+u
        qRQkeERTa6f9dsLWbangruVeOoeDzoQC/QwmeJy1ymBBZsHyak/G+BfKqWi99iNOfvDxQS
        2GaWiTD7KrAyL1V6m9Q9WLaHfqz/kms=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1670243370;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HYf0IkhECOZNgwrdtQYX1MrqB3mq4jpEBMupUm5ruSY=;
        b=1n0tnB3wUSYBz8qsg3qajphvc0Qkaioe2XUFIIxAdVrG+y2Ot3JeWTBgafOF4GOYr8IKeB
        WSZyoT2Vkie2JmAg==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 14BFB13722;
        Mon,  5 Dec 2022 12:29:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id 8rQABSrkjWMaTgAAGKfGzw
        (envelope-from <jack@suse.cz>); Mon, 05 Dec 2022 12:29:30 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 5968EA0731; Mon,  5 Dec 2022 13:29:28 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH v3 05/12] ext4: Add support for writepages calls that cannot map blocks
Date:   Mon,  5 Dec 2022 13:29:19 +0100
Message-Id: <20221205122928.21959-5-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221205122604.25994-1-jack@suse.cz>
References: <20221205122604.25994-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4315; i=jack@suse.cz; h=from:subject; bh=vklnG3keGZI1aQNoUJl4qzV4oTftyblr0jtEzrr4S7M=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBjjeQfDoc29oZyu4a+sEkq/V07JalCSVS+HyXs3J4V 7W+DkSeJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCY43kHwAKCRCcnaoHP2RA2bMeB/ 9yBiSVDGEBNAj/Bg1QNDnaCPUEtbqRslyX7IkeTsOVkxoPmt8emqM7wU4oWlm14SsB2M7GxB+d+8j7 uPEtSH105P8Ace+gQBo4sMPXx+mY0rhxxFEBzEBghwfpI/TFYNw7l3AWsYcS4R5+uQhFBHqtGrMGfq yn8tH36SLuON8b6+gLYGGOxYl4voCcpWh/cXvn7Ouxny+jc/tbGIvQeWHePUo6XhMR4xYDO8Wx7NgB bS4K4kf6Dd8cJjI74chNKIRWXkA1qYmTbi685Ff2edT0RAVLWkA9i0/cPgq2nSpczWs5OK4HYWGEpY 8iF2udq7SFIDAMlYe3aRX81LlhNoEk
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
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

