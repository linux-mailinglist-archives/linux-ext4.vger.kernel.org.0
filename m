Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E11A164287D
	for <lists+linux-ext4@lfdr.de>; Mon,  5 Dec 2022 13:29:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231836AbiLEM3p (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 5 Dec 2022 07:29:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231814AbiLEM3e (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 5 Dec 2022 07:29:34 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27F92101E6
        for <linux-ext4@vger.kernel.org>; Mon,  5 Dec 2022 04:29:33 -0800 (PST)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 29AA51FEDC;
        Mon,  5 Dec 2022 12:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1670243370; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2kayUqgJ35z0vajr9YkfzmXm72KaEjwV4oKf8bXqics=;
        b=wuPml2NdaEhQgKxdxwz4LcnquzEy2HA18j8ZrtgqWCatkJaJGzxZi8FZHTj5++6ZjANh34
        7IrVxh6Pj2Fnr1lxlAkyCValHj0tTYiZUiUl6ch+bHfVWOKPu6yM3VRIWslhj5/Qwa1rSy
        1qWF/aMd2jyhW1tHnghaFACgC8nO+y0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1670243370;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2kayUqgJ35z0vajr9YkfzmXm72KaEjwV4oKf8bXqics=;
        b=/EGcSvl0e7t9FGhzwPeGwroaV/A9xlmmrQXi5S9vTj8opf5+0DYhpmhvq//xKyFmZEF0S5
        QH4dfriNaix2e6Dg==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 0B7B71369C;
        Mon,  5 Dec 2022 12:29:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id HKDnAirkjWMcTgAAGKfGzw
        (envelope-from <jack@suse.cz>); Mon, 05 Dec 2022 12:29:30 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 844CBA073E; Mon,  5 Dec 2022 13:29:28 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>
Subject: [PATCH v3 12/12] ext4: Remove ordered data support from ext4_writepage()
Date:   Mon,  5 Dec 2022 13:29:26 +0100
Message-Id: <20221205122928.21959-12-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221205122604.25994-1-jack@suse.cz>
References: <20221205122604.25994-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9844; i=jack@suse.cz; h=from:subject; bh=nnYfQ0jdra1N+5U4dvVX1jQrw4g9MhS9mTBLa3rneNY=; b=owGbwMvMwME4Z+4qdvsUh5uMp9WSGJJ7n6hqyzuZ1Gjcmla6gvOTqMizO5duHl73pStQXfPP1oaa 3sy+TkZjFgZGDgZZMUWW1ZEXta/NM+raGqohAzOIlQlkCgMXpwBMREiN/Z9W9eTty7Z/t5EW9PebZp T2qUl/39bvVg2pf9KiDRgbps53YmONjehittmYkNFgMOFS0ydNU12LE5Oe7nP9yDs7XKHLsqNGdKZY yye/+3bG+5wc53nXWWV9L1/j9XGjwsbk0kh71s74Er2kZt9D3hsVv37OviIwdemrax2N0l+Laue9+n 3zp8mVaA/J9MCdEqp8K386f2Xsyeevu2xmcTlG54PtwQPTnLS9Dq47/tPZbVur654/HcxOp7cXX+yw Z6q328OacH5FT9ijaPWuMBmxvqdxRXcCvxVt29endkhyxaWDr7kbH3L8C6hwDud+4LDldJ6tN8uEri mzylVWNfw3FmV+Lhd4xS1cu1oYAA==
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

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/inode.c | 150 +++++++++---------------------------------------
 1 file changed, 26 insertions(+), 124 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index acf9d23c1cfb..c62614f6eacf 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1006,11 +1006,6 @@ int ext4_walk_page_buffers(handle_t *handle, struct inode *inode,
  * and the commit_write().  So doing the jbd2_journal_start at the start of
  * prepare_write() is the right place.
  *
- * Also, this function can nest inside ext4_writepage().  In that case, we
- * *know* that ext4_writepage() has generated enough buffer credits to do the
- * whole page.  So we won't block on the journal in that case, which is good,
- * because the caller may be PF_MEMALLOC.
- *
  * By accident, ext4 can be reentered when a transaction is open via
  * quota file writes.  If we were to commit the transaction while thus
  * reentered, there can be a deadlock - we would be holding a quota
@@ -1642,12 +1637,6 @@ static void ext4_print_free_blocks(struct inode *inode)
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
@@ -1962,56 +1951,18 @@ static int __ext4_journalled_writepage(struct page *page,
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
-static int ext4_writepage(struct page *page,
-			  struct writeback_control *wbc)
+static int ext4_journalled_writepage(struct page *page,
+				     struct writeback_control *wbc,
+				     void *data)
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
@@ -2036,60 +1987,16 @@ static int ext4_writepage(struct page *page,
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
@@ -2705,12 +2612,6 @@ static int mpage_prepare_extent_to_map(struct mpage_da_data *mpd)
 	return err;
 }
 
-static int ext4_writepage_cb(struct page *page, struct writeback_control *wbc,
-			     void *data)
-{
-	return ext4_writepage(page, wbc);
-}
-
 static int ext4_do_writepages(struct mpage_da_data *mpd)
 {
 	struct writeback_control *wbc = mpd->wbc;
@@ -2738,7 +2639,8 @@ static int ext4_do_writepages(struct mpage_da_data *mpd)
 
 	if (ext4_should_journal_data(inode)) {
 		blk_start_plug(&plug);
-		ret = write_cache_pages(mapping, wbc, ext4_writepage_cb, NULL);
+		ret = write_cache_pages(mapping, wbc, ext4_journalled_writepage,
+					NULL);
 		blk_finish_plug(&plug);
 		goto out_writepages;
 	}
@@ -3153,9 +3055,8 @@ static int ext4_da_write_end(struct file *file,
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
@@ -5357,13 +5258,14 @@ static void ext4_wait_for_tail_page_commit(struct inode *inode)
 
 	offset = inode->i_size & (PAGE_SIZE - 1);
 	/*
-	 * If the folio is fully truncated, we don't need to wait for any commit
-	 * (and we even should not as __ext4_journalled_invalidate_folio() may
-	 * strip all buffers from the folio but keep the folio dirty which can then
-	 * confuse e.g. concurrent ext4_writepage() seeing dirty folio without
-	 * buffers). Also we don't need to wait for any commit if all buffers in
-	 * the folio remain valid. This is most beneficial for the common case of
-	 * blocksize == PAGESIZE.
+	 * If the folio is fully truncated, we don't need to wait for any
+	 * commit (and we even should not as
+	 * __ext4_journalled_invalidate_folio() may strip all buffers from the
+	 * folio but keep the folio dirty which can then confuse e.g.
+	 * concurrent ext4_journalled_writepage() seeing dirty folio without
+	 * buffers). Also we don't need to wait for any commit if all buffers
+	 * in the folio remain valid. This is most beneficial for the common
+	 * case of blocksize == PAGESIZE.
 	 */
 	if (!offset || offset > (PAGE_SIZE - i_blocksize(inode)))
 		return;
-- 
2.35.3

