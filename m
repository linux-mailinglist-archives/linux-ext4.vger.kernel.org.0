Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44E4263DAC9
	for <lists+linux-ext4@lfdr.de>; Wed, 30 Nov 2022 17:36:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbiK3QgZ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 30 Nov 2022 11:36:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbiK3QgN (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 30 Nov 2022 11:36:13 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D53026DFEA
        for <linux-ext4@vger.kernel.org>; Wed, 30 Nov 2022 08:36:12 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D4A4821B14;
        Wed, 30 Nov 2022 16:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1669826169; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B0gTnsY4nTT6wh4dtPbXpE1nzLlHD8AcSrhjlLFNSpw=;
        b=2SxRg8ZCtzkBkTms6vCeMAEdxr7PJMUzKlQaBI30HKHwaWt8VEzlwzhVeytSxuvrR3bzHH
        Mh6xeFDqpfQKaKF4r7m6D0aHIhCTjMBnBKa2ScB4zmtO3dZapNwkvmwvu4N9wqNQ7qawwL
        vdIpAkLhpM4Gv2kZbP7gmMoe8KScbrA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1669826169;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B0gTnsY4nTT6wh4dtPbXpE1nzLlHD8AcSrhjlLFNSpw=;
        b=dC+jMyqln5NDXVd7QpGxYDFmZWo0SlMTLxWVjBqMEEjUkcN7Q63I4vO6KEkiDmlPVixl4d
        jreQ2/Mgtgt5qUBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C2C3F13AFB;
        Wed, 30 Nov 2022 16:36:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 7FCAL3mGh2NmQgAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 30 Nov 2022 16:36:09 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id D599BA071E; Wed, 30 Nov 2022 17:36:08 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 9/9] ext4: Remove ordered data support from ext4_writepage()
Date:   Wed, 30 Nov 2022 17:36:00 +0100
Message-Id: <20221130163608.29034-9-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221130162435.2324-1-jack@suse.cz>
References: <20221130162435.2324-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6961; i=jack@suse.cz; h=from:subject; bh=B6Hm8+X6gHqS2o9OLk2WmhBw+YJETgo4MSHJSjEiGeM=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBjh4Zv3U7mHOoX8gFIR+qqYNRvSIYGSbrJRtqS+mja 2DTmJB+JATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCY4eGbwAKCRCcnaoHP2RA2SV1CA CthsSjRxI5MjxjxUTOiFH6/GWk2DSAl3SM6o2Yjyd6vOhsnTVe+UDgyDf4Fvc0r9/PkEyeylQ7eavG Qzst47yCkQnbTxvl+dy85H8BGpZybq26Q8qRsIsuyun0faMGHVmlnJ+0xrRmtQ0Cn3WsI3T2Dm2/oN clndl7GSj5C8kZ7zsBv0ljmy7nVJ+JnFQvAam7oHDHGuY103deIxhveI0ZDinpfNAa0ete5rKZLNzV Kg0NW5Tlqkc7B14UvMpIT5fk7mlZ1qXaZVr5fzf0r9tPX3tcMeTTrlrRoXTN6uejnwU0U6WJjtjWap fm/KNC7H/N5ef03XPbg8EK0HUe6FJH
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

ext4_writepage() should not be called for ordered data anymore. Remove
support for it from the function.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/inode.c | 116 ++++++------------------------------------------
 1 file changed, 13 insertions(+), 103 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index c131b611dabf..0c8e700265f1 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1642,12 +1642,6 @@ static void ext4_print_free_blocks(struct inode *inode)
 	return;
 }
 
-static int ext4_bh_delay_or_unwritten(handle_t *handle, struct inode *inode,
-				      struct buffer_head *bh)
-{
-	return (buffer_delay(bh) || buffer_unwritten(bh)) && buffer_dirty(bh);
-}
-
 /*
  * ext4_insert_delayed_block - adds a delayed block to the extents status
  *                             tree, incrementing the reserved cluster/block
@@ -1962,56 +1956,17 @@ static int __ext4_journalled_writepage(struct page *page,
 }
 
 /*
- * Note that we don't need to start a transaction unless we're journaling data
- * because we should have holes filled from ext4_page_mkwrite(). We even don't
- * need to file the inode to the transaction's list in ordered mode because if
- * we are writing back data added by write(), the inode is already there and if
- * we are writing back data modified via mmap(), no one guarantees in which
- * transaction the data will hit the disk. In case we are journaling data, we
- * cannot start transaction directly because transaction start ranks above page
- * lock so we have to do some magic.
- *
- * This function can get called via...
- *   - ext4_writepages after taking page lock (have journal handle)
- *   - journal_submit_inode_data_buffers (no journal handle)
- *   - shrink_page_list via the kswapd/direct reclaim (no journal handle)
- *   - grab_page_cache when doing write_begin (have journal handle)
- *
- * We don't do any block allocation in this function. If we have page with
- * multiple blocks we need to write those buffer_heads that are mapped. This
- * is important for mmaped based write. So if we do with blocksize 1K
- * truncate(f, 1024);
- * a = mmap(f, 0, 4096);
- * a[0] = 'a';
- * truncate(f, 4096);
- * we have in the page first buffer_head mapped via page_mkwrite call back
- * but other buffer_heads would be unmapped but dirty (dirty done via the
- * do_wp_page). So writepage should write the first block. If we modify
- * the mmap area beyond 1024 we will again get a page_fault and the
- * page_mkwrite callback will do the block allocation and mark the
- * buffer_heads mapped.
- *
- * We redirty the page if we have any buffer_heads that is either delay or
- * unwritten in the page.
- *
- * We can get recursively called as show below.
- *
- *	ext4_writepage() -> kmalloc() -> __alloc_pages() -> page_launder() ->
- *		ext4_writepage()
- *
- * But since we don't do any block allocation we should not deadlock.
- * Page also have the dirty flag cleared so we don't get recurive page_lock.
+ * This function is now used only when journaling data. We cannot start
+ * transaction directly because transaction start ranks above page lock so we
+ * have to do some magic.
  */
 static int ext4_writepage(struct page *page,
 			  struct writeback_control *wbc)
 {
 	struct folio *folio = page_folio(page);
-	int ret = 0;
 	loff_t size;
 	unsigned int len;
-	struct buffer_head *page_bufs = NULL;
 	struct inode *inode = page->mapping->host;
-	struct ext4_io_submit io_submit;
 
 	if (unlikely(ext4_forced_shutdown(EXT4_SB(inode->i_sb)))) {
 		folio_invalidate(folio, 0, folio_size(folio));
@@ -2036,60 +1991,16 @@ static int ext4_writepage(struct page *page,
 		return 0;
 	}
 
-	page_bufs = page_buffers(page);
-	/*
-	 * We cannot do block allocation or other extent handling in this
-	 * function. If there are buffers needing that, we have to redirty
-	 * the page. But we may reach here when we do a journal commit via
-	 * journal_submit_inode_data_buffers() and in that case we must write
-	 * allocated buffers to achieve data=ordered mode guarantees.
-	 *
-	 * Also, if there is only one buffer per page (the fs block
-	 * size == the page size), if one buffer needs block
-	 * allocation or needs to modify the extent tree to clear the
-	 * unwritten flag, we know that the page can't be written at
-	 * all, so we might as well refuse the write immediately.
-	 * Unfortunately if the block size != page size, we can't as
-	 * easily detect this case using ext4_walk_page_buffers(), but
-	 * for the extremely common case, this is an optimization that
-	 * skips a useless round trip through ext4_bio_write_page().
-	 */
-	if (ext4_walk_page_buffers(NULL, inode, page_bufs, 0, len, NULL,
-				   ext4_bh_delay_or_unwritten)) {
-		redirty_page_for_writepage(wbc, page);
-		if ((current->flags & PF_MEMALLOC) ||
-		    (inode->i_sb->s_blocksize == PAGE_SIZE)) {
-			/*
-			 * For memory cleaning there's no point in writing only
-			 * some buffers. So just bail out. Warn if we came here
-			 * from direct reclaim.
-			 */
-			WARN_ON_ONCE((current->flags & (PF_MEMALLOC|PF_KSWAPD))
-							== PF_MEMALLOC);
-			unlock_page(page);
-			return 0;
-		}
-	}
-
-	if (PageChecked(page) && ext4_should_journal_data(inode))
-		/*
-		 * It's mmapped pagecache.  Add buffers and journal it.  There
-		 * doesn't seem much point in redirtying the page here.
-		 */
-		return __ext4_journalled_writepage(page, len);
-
-	ext4_io_submit_init(&io_submit, wbc);
-	io_submit.io_end = ext4_init_io_end(inode, GFP_NOFS);
-	if (!io_submit.io_end) {
-		redirty_page_for_writepage(wbc, page);
+	WARN_ON_ONCE(!ext4_should_journal_data(inode));
+	if (!PageChecked(page)) {
 		unlock_page(page);
-		return -ENOMEM;
+		return 0;
 	}
-	ret = ext4_bio_write_page(&io_submit, page, len);
-	ext4_io_submit(&io_submit);
-	/* Drop io_end reference we got from init */
-	ext4_put_io_end_defer(io_submit.io_end);
-	return ret;
+	/*
+	 * It's mmapped pagecache.  Add buffers and journal it.  There
+	 * doesn't seem much point in redirtying the page here.
+	 */
+	return __ext4_journalled_writepage(page, len);
 }
 
 static int mpage_submit_page(struct mpage_da_data *mpd, struct page *page)
@@ -3142,9 +3053,8 @@ static int ext4_da_write_end(struct file *file,
 	 * i_disksize since writeback will push i_disksize upto i_size
 	 * eventually. If the end of the current write is > i_size and
 	 * inside an allocated block (ext4_da_should_update_i_disksize()
-	 * check), we need to update i_disksize here as neither
-	 * ext4_writepage() nor certain ext4_writepages() paths not
-	 * allocating blocks update i_disksize.
+	 * check), we need to update i_disksize here as ext4_writepages() need
+	 * not do it in this case.
 	 *
 	 * Note that we defer inode dirtying to generic_write_end() /
 	 * ext4_da_write_inline_data_end().
-- 
2.35.3

