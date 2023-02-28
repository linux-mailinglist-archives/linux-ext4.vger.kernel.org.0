Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 403FD6A5295
	for <lists+linux-ext4@lfdr.de>; Tue, 28 Feb 2023 06:13:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbjB1FNm (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 28 Feb 2023 00:13:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbjB1FNe (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 28 Feb 2023 00:13:34 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F8CC661
        for <linux-ext4@vger.kernel.org>; Mon, 27 Feb 2023 21:13:31 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 31S5DQT4002567
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Feb 2023 00:13:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1677561207; bh=ciKp1m4oFyIKWp9IJGxyuSDT5Xq94Mo4yG/QrvdOlmc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=CYF5ZvTo6fyOiU3D5t69dZCLTQQFCJfyAm8//MDwKqhcGxOIc6fMpHvngItmhF0eM
         dWuoBQu3wxKrfDaAvfQIYkzE3Y3O2ziI4sr9gpFMLxts3G+AfPERMAPzOMaXB9YqSq
         HgMtotaUrMA7tABdL+JN5zNL/FTHWokLD3GpVbiirbq9UdscfCx/d4bM0i5jZkfVbH
         yBQYCpOx+Csk4Y64OjOOt717U6hywflItMCsOcHShQBjOJJd7t6HJMm7wAhT6Z4St5
         F1eUQ0Sw3lZHS0Iy5p+9ORHNORWGhZpGZ8lOJHD6AJRdb3tRx1pJJgOWF6HNrQikVu
         Qm6oISP1GhQDA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 37D7F15C582A; Tue, 28 Feb 2023 00:13:24 -0500 (EST)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Cc:     Jan Kara <jack@suse.cz>, "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH 7/7] ext4: Convert data=journal writeback to use ext4_writepages()
Date:   Tue, 28 Feb 2023 00:13:19 -0500
Message-Id: <20230228051319.4085470-8-tytso@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20230228051319.4085470-1-tytso@mit.edu>
References: <20230228051319.4085470-1-tytso@mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Jan Kara <jack@suse.cz>

Add support for writeback of journalled data directly into
ext4_writepages() instead of offloading it to write_cache_pages(). This
actually significantly simplifies the code and reduces code duplication.
For checkpointing of committed data we can use ext4_writepages()
rightaway the same way as writeback of ordered data uses it on
transaction commit. For journalling of dirty mapped pages, we need to
add a special case to mpage_prepare_extent_to_map() to add all page
buffers to the journal.

Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 fs/ext4/inode.c             | 341 ++++++++++--------------------------
 include/trace/events/ext4.h |   7 -
 2 files changed, 91 insertions(+), 257 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index e6c453bf953e..4a45d320fda8 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -136,7 +136,6 @@ static inline int ext4_begin_ordered_truncate(struct inode *inode,
 						   new_size);
 }
 
-static int __ext4_journalled_writepage(struct page *page, unsigned int len);
 static int ext4_meta_trans_blocks(struct inode *inode, int lblocks,
 				  int pextents);
 
@@ -1632,12 +1631,6 @@ static void ext4_print_free_blocks(struct inode *inode)
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
@@ -1870,219 +1863,6 @@ int ext4_da_get_block_prep(struct inode *inode, sector_t iblock,
 	return 0;
 }
 
-static int __ext4_journalled_writepage(struct page *page,
-				       unsigned int len)
-{
-	struct address_space *mapping = page->mapping;
-	struct inode *inode = mapping->host;
-	handle_t *handle = NULL;
-	int ret = 0, err = 0;
-	int inline_data = ext4_has_inline_data(inode);
-	struct buffer_head *inode_bh = NULL;
-	loff_t size;
-
-	ClearPageChecked(page);
-
-	if (inline_data) {
-		BUG_ON(page->index != 0);
-		BUG_ON(len > ext4_get_max_inline_size(inode));
-		inode_bh = ext4_journalled_write_inline_data(inode, len, page);
-		if (inode_bh == NULL)
-			goto out;
-	}
-	/*
-	 * We need to release the page lock before we start the
-	 * journal, so grab a reference so the page won't disappear
-	 * out from under us.
-	 */
-	get_page(page);
-	unlock_page(page);
-
-	handle = ext4_journal_start(inode, EXT4_HT_WRITE_PAGE,
-				    ext4_writepage_trans_blocks(inode));
-	if (IS_ERR(handle)) {
-		ret = PTR_ERR(handle);
-		put_page(page);
-		goto out_no_pagelock;
-	}
-	BUG_ON(!ext4_handle_valid(handle));
-
-	lock_page(page);
-	put_page(page);
-	size = i_size_read(inode);
-	if (page->mapping != mapping || page_offset(page) > size) {
-		/* The page got truncated from under us */
-		ext4_journal_stop(handle);
-		ret = 0;
-		goto out;
-	}
-
-	if (inline_data) {
-		ret = ext4_mark_inode_dirty(handle, inode);
-	} else {
-		struct buffer_head *page_bufs = page_buffers(page);
-
-		if (page->index == size >> PAGE_SHIFT)
-			len = size & ~PAGE_MASK;
-		else
-			len = PAGE_SIZE;
-
-		ret = ext4_walk_page_buffers(handle, inode, page_bufs, 0, len,
-					     NULL, do_journal_get_write_access);
-
-		err = ext4_walk_page_buffers(handle, inode, page_bufs, 0, len,
-					     NULL, write_end_fn);
-	}
-	if (ret == 0)
-		ret = err;
-	err = ext4_jbd2_inode_add_write(handle, inode, page_offset(page), len);
-	if (ret == 0)
-		ret = err;
-	EXT4_I(inode)->i_datasync_tid = handle->h_transaction->t_tid;
-	err = ext4_journal_stop(handle);
-	if (!ret)
-		ret = err;
-
-	ext4_set_inode_state(inode, EXT4_STATE_JDATA);
-out:
-	unlock_page(page);
-out_no_pagelock:
-	brelse(inode_bh);
-	return ret;
-}
-
-/*
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
- */
-static int ext4_writepage(struct page *page,
-			  struct writeback_control *wbc)
-{
-	struct folio *folio = page_folio(page);
-	int ret = 0;
-	loff_t size;
-	unsigned int len;
-	struct buffer_head *page_bufs = NULL;
-	struct inode *inode = page->mapping->host;
-	struct ext4_io_submit io_submit;
-
-	if (unlikely(ext4_forced_shutdown(EXT4_SB(inode->i_sb)))) {
-		folio_invalidate(folio, 0, folio_size(folio));
-		folio_unlock(folio);
-		return -EIO;
-	}
-
-	trace_ext4_writepage(page);
-	size = i_size_read(inode);
-	if (page->index == size >> PAGE_SHIFT &&
-	    !ext4_verity_in_progress(inode))
-		len = size & ~PAGE_MASK;
-	else
-		len = PAGE_SIZE;
-
-	/* Should never happen but for bugs in other kernel subsystems */
-	if (!page_has_buffers(page)) {
-		ext4_warning_inode(inode,
-		   "page %lu does not have buffers attached", page->index);
-		ClearPageDirty(page);
-		unlock_page(page);
-		return 0;
-	}
-
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
-		unlock_page(page);
-		return -ENOMEM;
-	}
-	ret = ext4_bio_write_page(&io_submit, page, len);
-	unlock_page(page);
-	ext4_io_submit(&io_submit);
-	/* Drop io_end reference we got from init */
-	ext4_put_io_end_defer(io_submit.io_end);
-	return ret;
-}
-
 static void mpage_page_done(struct mpage_da_data *mpd, struct page *page)
 {
 	mpd->first_page++;
@@ -2563,6 +2343,50 @@ static bool ext4_page_nomap_can_writeout(struct page *page)
 	return false;
 }
 
+static int ext4_journal_page_buffers(handle_t *handle, struct page *page,
+				     int len)
+{
+	struct buffer_head *page_bufs = page_buffers(page);
+	struct inode *inode = page->mapping->host;
+	int ret, err;
+
+	ret = ext4_walk_page_buffers(handle, inode, page_bufs, 0, len,
+				     NULL, do_journal_get_write_access);
+	err = ext4_walk_page_buffers(handle, inode, page_bufs, 0, len,
+				     NULL, write_end_fn);
+	if (ret == 0)
+		ret = err;
+	err = ext4_jbd2_inode_add_write(handle, inode, page_offset(page), len);
+	if (ret == 0)
+		ret = err;
+	EXT4_I(inode)->i_datasync_tid = handle->h_transaction->t_tid;
+
+	ext4_set_inode_state(inode, EXT4_STATE_JDATA);
+
+	return ret;
+}
+
+static int mpage_journal_page_buffers(handle_t *handle,
+				      struct mpage_da_data *mpd,
+				      struct page *page)
+{
+	struct inode *inode = mpd->inode;
+	loff_t size = i_size_read(inode);
+	int len;
+
+	ClearPageChecked(page);
+	clear_page_dirty_for_io(page);
+	mpd->wbc->nr_to_write--;
+
+	if (page->index == size >> PAGE_SHIFT &&
+	    !ext4_verity_in_progress(inode))
+		len = size & ~PAGE_MASK;
+	else
+		len = PAGE_SIZE;
+
+	return ext4_journal_page_buffers(handle, page, len);
+}
+
 /*
  * mpage_prepare_extent_to_map - find & lock contiguous range of dirty pages
  * 				 needing mapping, submit mapped pages
@@ -2595,11 +2419,20 @@ static int mpage_prepare_extent_to_map(struct mpage_da_data *mpd)
 	int blkbits = mpd->inode->i_blkbits;
 	ext4_lblk_t lblk;
 	struct buffer_head *head;
+	handle_t *handle = NULL;
+	int bpp = ext4_journal_blocks_per_page(mpd->inode);
 
 	if (mpd->wbc->sync_mode == WB_SYNC_ALL || mpd->wbc->tagged_writepages)
 		tag = PAGECACHE_TAG_TOWRITE;
 	else
 		tag = PAGECACHE_TAG_DIRTY;
+
+	if (ext4_should_journal_data(mpd->inode)) {
+		handle = ext4_journal_start(mpd->inode, EXT4_HT_WRITE_PAGE,
+					    bpp);
+		if (IS_ERR(handle))
+			return PTR_ERR(handle);
+	}
 	folio_batch_init(&fbatch);
 	mpd->map.m_len = 0;
 	mpd->next_page = index;
@@ -2629,6 +2462,13 @@ static int mpage_prepare_extent_to_map(struct mpage_da_data *mpd)
 			if (mpd->map.m_len > 0 && mpd->next_page != folio->index)
 				goto out;
 
+			if (handle) {
+				err = ext4_journal_ensure_credits(handle, bpp,
+								  0);
+				if (err < 0)
+					goto out;
+			}
+
 			folio_lock(folio);
 			/*
 			 * If the page is no longer dirty, or its mapping no
@@ -2668,8 +2508,15 @@ static int mpage_prepare_extent_to_map(struct mpage_da_data *mpd)
 				mpd->first_page = folio->index;
 			mpd->next_page = folio->index + folio_nr_pages(folio);
 			/*
-			 * Writeout for transaction commit where we cannot
-			 * modify metadata is simple. Just submit the page.
+			 * Writeout when we cannot modify metadata is simple.
+			 * Just submit the page. For data=journal mode we
+			 * first handle writeout of the page for checkpoint and
+			 * only after that handle delayed page dirtying. This
+			 * is crutial so that forcing a transaction commit and
+			 * then calling filemap_write_and_wait() guarantees
+			 * current state of data is in its final location. Such
+			 * sequence is used for example by insert/collapse
+			 * range operations before discarding the page cache.
 			 */
 			if (!mpd->can_map) {
 				if (ext4_page_nomap_can_writeout(&folio->page)) {
@@ -2677,6 +2524,13 @@ static int mpage_prepare_extent_to_map(struct mpage_da_data *mpd)
 					if (err < 0)
 						goto out;
 				}
+				/* Pending dirtying of journalled data? */
+				if (PageChecked(&folio->page)) {
+					err = mpage_journal_page_buffers(handle,
+						mpd, &folio->page);
+					if (err < 0)
+						goto out;
+				}
 				mpage_page_done(mpd, &folio->page);
 			} else {
 				/* Add all dirty buffers to mpd */
@@ -2694,18 +2548,16 @@ static int mpage_prepare_extent_to_map(struct mpage_da_data *mpd)
 		cond_resched();
 	}
 	mpd->scanned_until_end = 1;
+	if (handle)
+		ext4_journal_stop(handle);
 	return 0;
 out:
 	folio_batch_release(&fbatch);
+	if (handle)
+		ext4_journal_stop(handle);
 	return err;
 }
 
-static int ext4_writepage_cb(struct folio *folio, struct writeback_control *wbc,
-			     void *data)
-{
-	return ext4_writepage(&folio->page, wbc);
-}
-
 static int ext4_do_writepages(struct mpage_da_data *mpd)
 {
 	struct writeback_control *wbc = mpd->wbc;
@@ -2731,13 +2583,6 @@ static int ext4_do_writepages(struct mpage_da_data *mpd)
 	if (!mapping->nrpages || !mapping_tagged(mapping, PAGECACHE_TAG_DIRTY))
 		goto out_writepages;
 
-	if (ext4_should_journal_data(inode)) {
-		blk_start_plug(&plug);
-		ret = write_cache_pages(mapping, wbc, ext4_writepage_cb, NULL);
-		blk_finish_plug(&plug);
-		goto out_writepages;
-	}
-
 	/*
 	 * If the filesystem has aborted, it is read-only, so return
 	 * right away instead of dumping stack traces later on that
@@ -2772,6 +2617,13 @@ static int ext4_do_writepages(struct mpage_da_data *mpd)
 		ext4_journal_stop(handle);
 	}
 
+	/*
+	 * data=journal mode does not do delalloc so we just need to writeout /
+	 * journal already mapped buffers
+	 */
+	if (ext4_should_journal_data(inode))
+		mpd->can_map = 0;
+
 	if (ext4_should_dioread_nolock(inode)) {
 		/*
 		 * We may need to convert up to one extent per block in
@@ -3148,9 +3000,8 @@ static int ext4_da_write_end(struct file *file,
 	 * i_disksize since writeback will push i_disksize upto i_size
 	 * eventually. If the end of the current write is > i_size and
 	 * inside an allocated block (ext4_da_should_update_i_disksize()
-	 * check), we need to update i_disksize here as neither
-	 * ext4_writepage() nor certain ext4_writepages() paths not
-	 * allocating blocks update i_disksize.
+	 * check), we need to update i_disksize here as certain
+	 * ext4_writepages() paths not allocating blocks update i_disksize.
 	 *
 	 * Note that we defer inode dirtying to generic_write_end() /
 	 * ext4_da_write_inline_data_end().
@@ -5371,7 +5222,7 @@ static void ext4_wait_for_tail_page_commit(struct inode *inode)
 	 * If the folio is fully truncated, we don't need to wait for any commit
 	 * (and we even should not as __ext4_journalled_invalidate_folio() may
 	 * strip all buffers from the folio but keep the folio dirty which can then
-	 * confuse e.g. concurrent ext4_writepage() seeing dirty folio without
+	 * confuse e.g. concurrent ext4_writepages() seeing dirty folio without
 	 * buffers). Also we don't need to wait for any commit if all buffers in
 	 * the folio remain valid. This is most beneficial for the common case of
 	 * blocksize == PAGESIZE.
@@ -6309,18 +6160,8 @@ vm_fault_t ext4_page_mkwrite(struct vm_fault *vmf)
 		err = __block_write_begin(page, 0, len, ext4_get_block);
 		if (!err) {
 			ret = VM_FAULT_SIGBUS;
-			if (ext4_walk_page_buffers(handle, inode,
-					page_buffers(page), 0, len, NULL,
-					do_journal_get_write_access))
-				goto out_error;
-			if (ext4_walk_page_buffers(handle, inode,
-					page_buffers(page), 0, len, NULL,
-					write_end_fn))
-				goto out_error;
-			if (ext4_jbd2_inode_add_write(handle, inode,
-						      page_offset(page), len))
+			if (ext4_journal_page_buffers(handle, page, len))
 				goto out_error;
-			ext4_set_inode_state(inode, EXT4_STATE_JDATA);
 		} else {
 			unlock_page(page);
 		}
diff --git a/include/trace/events/ext4.h b/include/trace/events/ext4.h
index 77b426ae0064..ebccf6a6aa1b 100644
--- a/include/trace/events/ext4.h
+++ b/include/trace/events/ext4.h
@@ -584,13 +584,6 @@ DECLARE_EVENT_CLASS(ext4__page_op,
 		  (unsigned long) __entry->index)
 );
 
-DEFINE_EVENT(ext4__page_op, ext4_writepage,
-
-	TP_PROTO(struct page *page),
-
-	TP_ARGS(page)
-);
-
 DEFINE_EVENT(ext4__page_op, ext4_readpage,
 
 	TP_PROTO(struct page *page),
-- 
2.31.0

