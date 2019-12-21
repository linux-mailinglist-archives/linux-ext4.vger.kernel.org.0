Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20DC2128B82
	for <lists+linux-ext4@lfdr.de>; Sat, 21 Dec 2019 21:27:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727382AbfLUU1H (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 21 Dec 2019 15:27:07 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:49903 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726593AbfLUU1H (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 21 Dec 2019 15:27:07 -0500
Received: from mail-pf1-f199.google.com ([209.85.210.199])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <mfo@canonical.com>)
        id 1iilL6-0007Nh-As
        for linux-ext4@vger.kernel.org; Sat, 21 Dec 2019 20:27:04 +0000
Received: by mail-pf1-f199.google.com with SMTP id x21so4621726pfp.12
        for <linux-ext4@vger.kernel.org>; Sat, 21 Dec 2019 12:27:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oVjD4c0NDVnsp7B7kS7VtzD9g7iYUeEkZjiXHdxL4DE=;
        b=jQrbzdiUS6czHUtIGOF1S/ETQZd+3bBVV1ADjSkp9DeaUh5XYSmhklk/CvHe9bAnuw
         Xs3RtqBMtqy1RDJS32SouJ1ZIti1pgDfCbBjvrhirN2I621JWh+AG2jWZzHCxYRIAoOu
         O6HrHOvkdByROEoqoSrcxfUfRVsDjPyTHlOiQh3r9zLMj431NOLIxMzJ3tZvEe9VOFUM
         rl/Xfo3wnV50tVAImcT53NgTeIIluhTeJfmgbCwm5PLkAt2lAg9NRA9hrthLdvmmL8I0
         GQUk+U4jYkYe/fBDHDvWb0K4C/16QzZDkWth8N/CsBYMso0GZJZEKB5Q1TDjFr0Vj0e7
         BJtA==
X-Gm-Message-State: APjAAAWtEbD0nqyG09UGPDrzuaNpmMLnBB/vfSDIG94sAPn6xiyV0tij
        w1RNa1x3ijPDI9k2u8D+SUQz0BnbjIs+TO1C3HiYuAFIuBJA2TagJygmi2uiBBDS9u9xxnoTbG4
        WXeNHU55g9zFVve9j2vjdUo3Rg8/RsFK/nAZDLHk=
X-Received: by 2002:a63:cb48:: with SMTP id m8mr23366716pgi.128.1576960022864;
        Sat, 21 Dec 2019 12:27:02 -0800 (PST)
X-Google-Smtp-Source: APXvYqzrcHrxlJVTXy9EZ8jjHdJA4X/21iFqa6O3uNGyjUcgUNRtmj6bG+UIa8kjFGYAppIKgSQ2SQ==
X-Received: by 2002:a63:cb48:: with SMTP id m8mr23366692pgi.128.1576960022468;
        Sat, 21 Dec 2019 12:27:02 -0800 (PST)
Received: from localhost.localdomain ([170.81.134.253])
        by smtp.gmail.com with ESMTPSA id r7sm18554467pfg.34.2019.12.21.12.26.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Dec 2019 12:27:02 -0800 (PST)
From:   mfo@canonical.com
To:     tytso@mit.edu
Cc:     dann.frazier@canonical.com, linux-ext4@vger.kernel.org,
        mauricio.foliveira@gmail.com
Subject: [RFC 1/1] ext4: set page writeback on journalled writepage
Date:   Sat, 21 Dec 2019 17:26:30 -0300
Message-Id: <20191221202630.30718-2-mfo@canonical.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191221202630.30718-1-mfo@canonical.com>
References: <20190830012236.GC10779@mit.edu>
 <20191221202630.30718-1-mfo@canonical.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Mauricio Faria de Oliveira <mfo@canonical.com>

Work in progress / request for comments to fix issue with
journal consistency errors on unclean shutdown with mmap()
on ext4 data=journal,journal_checksum mode.

Reference:
  https://lore.kernel.org/linux-ext4/20190830012236.GC10779@mit.edu/
---
 fs/ext4/ext4_jbd2.h | 11 ++++++
 fs/ext4/inline.c    | 13 +++++++
 fs/ext4/inode.c     | 82 ++++++++++++++++++++++++++++++++++++++++++---
 3 files changed, 102 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/ext4_jbd2.h b/fs/ext4/ext4_jbd2.h
index a6b9b66dbfad..8b51ca8231b7 100644
--- a/fs/ext4/ext4_jbd2.h
+++ b/fs/ext4/ext4_jbd2.h
@@ -144,6 +144,17 @@ struct ext4_journal_cb_entry {
 	/* user data goes here */
 };
 
+/**
+ * struct ext4_journal_cb_entry_simple - Simple structure for callback information.
+ *
+ * This struct is a 'simple' structure on top of the base/seed structure,
+ * which adds a private data pointer to be used by the callback function.
+ */
+struct ext4_journal_cb_entry_simple {
+	struct ext4_journal_cb_entry jce;
+	void *jce_private;
+};
+
 /**
  * ext4_journal_callback_add: add a function to call after transaction commit
  * @handle: active journal transaction handle to register callback on
diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index 2fec62d764fa..a168fe497d5d 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -565,6 +565,9 @@ static int ext4_convert_inline_data_to_extent(struct address_space *mapping,
 		ret = -ENOMEM;
 		goto out;
 	}
+	/* XXX(mfo): deadlock with journal? */
+	if (ext4_should_journal_data(inode))
+		wait_on_page_writeback(page);
 
 	ext4_write_lock_xattr(inode, &no_expand);
 	sem_held = 1;
@@ -693,6 +696,9 @@ int ext4_try_to_write_inline_data(struct address_space *mapping,
 		ret = -ENOMEM;
 		goto out;
 	}
+	/* XXX(mfo): deadlock with journal? */
+	if (ext4_should_journal_data(inode))
+		wait_on_page_writeback(page);
 
 	*pagep = page;
 	down_read(&EXT4_I(inode)->xattr_sem);
@@ -808,6 +814,10 @@ static int ext4_da_convert_inline_data_to_extent(struct address_space *mapping,
 	page = grab_cache_page_write_begin(mapping, 0, flags);
 	if (!page)
 		return -ENOMEM;
+	/* XXX(mfo): should not deadlock with journal;
+	 * this is only called after ext4_journal_stop(). */
+	if (ext4_should_journal_data(inode))
+		wait_on_page_writeback(page);
 
 	down_read(&EXT4_I(inode)->xattr_sem);
 	if (!ext4_has_inline_data(inode)) {
@@ -911,6 +921,9 @@ int ext4_da_write_inline_data_begin(struct address_space *mapping,
 		ret = -ENOMEM;
 		goto out_journal;
 	}
+	/* XXX(mfo): deadlock with journal? */
+	if (ext4_should_journal_data(inode))
+		wait_on_page_writeback(page);
 
 	down_read(&EXT4_I(inode)->xattr_sem);
 	if (!ext4_has_inline_data(inode)) {
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 28f28de0c1b6..ca31db5f81f0 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -139,7 +139,7 @@ static inline int ext4_begin_ordered_truncate(struct inode *inode,
 
 static void ext4_invalidatepage(struct page *page, unsigned int offset,
 				unsigned int length);
-static int __ext4_journalled_writepage(struct page *page, unsigned int len);
+static int __ext4_journalled_writepage(struct page *page, unsigned int len, bool sync);
 static int ext4_bh_delay_or_unwritten(handle_t *handle, struct buffer_head *bh);
 static int ext4_meta_trans_blocks(struct inode *inode, int lblocks,
 				  int pextents);
@@ -1155,6 +1155,15 @@ static int ext4_write_begin(struct file *file, struct address_space *mapping,
 	unlock_page(page);
 
 retry_journal:
+
+	/* XXX(mfo): deadlock with journal: fix attempt.
+	 * does just wait_on_page_writeback() need (un)lock_page() ? */
+	if (ext4_should_journal_data(inode)) {
+		lock_page(page);
+		wait_on_page_writeback(page);
+		unlock_page(page);
+	}
+
 	handle = ext4_journal_start(inode, EXT4_HT_WRITE_PAGE, needed_blocks);
 	if (IS_ERR(handle)) {
 		put_page(page);
@@ -1170,6 +1179,7 @@ static int ext4_write_begin(struct file *file, struct address_space *mapping,
 		goto retry_grab;
 	}
 	/* In case writeback began while the page was unlocked */
+	/* XXX(mfo): this may call wait_on_page_writeback() and deadlock. */
 	wait_for_stable_page(page);
 
 #ifdef CONFIG_FS_ENCRYPTION
@@ -1841,8 +1851,21 @@ static int bput_one(handle_t *handle, struct buffer_head *bh)
 	return 0;
 }
 
+static void __ext4_jce_finish_page_writeback(struct super_block *sb,
+					     struct ext4_journal_cb_entry *jce,
+					     int error)
+{
+	struct ext4_journal_cb_entry_simple *jce_simple =
+		(struct ext4_journal_cb_entry_simple *) jce;
+	struct page *page = (struct page *) jce_simple->jce_private;
+
+	end_page_writeback(page);
+	kfree(jce);
+}
+
 static int __ext4_journalled_writepage(struct page *page,
-				       unsigned int len)
+				       unsigned int len,
+				       bool sync)
 {
 	struct address_space *mapping = page->mapping;
 	struct inode *inode = mapping->host;
@@ -1851,6 +1874,7 @@ static int __ext4_journalled_writepage(struct page *page,
 	int ret = 0, err = 0;
 	int inline_data = ext4_has_inline_data(inode);
 	struct buffer_head *inode_bh = NULL;
+	struct ext4_journal_cb_entry_simple *jce = NULL;
 
 	ClearPageChecked(page);
 
@@ -1875,13 +1899,25 @@ static int __ext4_journalled_writepage(struct page *page,
 	 * out from under us.
 	 */
 	get_page(page);
+	/* XXX(mfo): do NOT set_page_writeback() here; as the next lock_page()
+	 * could deadlock with write_cache_pages() (since it calls lock_page()
+	 * and then wait_on_page_writeback()).
+	 */
+	//set_page_writeback(page);
 	unlock_page(page);
 
+	if (!sync) {
+		jce = kzalloc(sizeof(*jce), GFP_NOFS);
+		if (!jce) {
+			ret = -ENOMEM;
+			goto out_no_pagelock;
+		}
+	}
+
 	handle = ext4_journal_start(inode, EXT4_HT_WRITE_PAGE,
 				    ext4_writepage_trans_blocks(inode));
 	if (IS_ERR(handle)) {
 		ret = PTR_ERR(handle);
-		put_page(page);
 		goto out_no_pagelock;
 	}
 	BUG_ON(!ext4_handle_valid(handle));
@@ -1906,7 +1942,25 @@ static int __ext4_journalled_writepage(struct page *page,
 	}
 	if (ret == 0)
 		ret = err;
+
 	EXT4_I(inode)->i_datasync_tid = handle->h_transaction->t_tid;
+
+	/* XXX(mfo): only call set_page_writeback() and add callback to end_page_writeback()
+	 * on journal commit on the *a*sync case;  otherwise msync() blocks until periodic
+	 * journal commit happens, waiting on page writeback.
+	 * msync() -> ext4_sync_file() -> __filemap_fdatawait_range() -> wait_on_page_writeback()
+	 *
+	 * Confirm wether the *sync* case does *not* need ext4_handle_sync() ?
+	 * as msync() -> ext4_sync_file() already calls ext4_force_commit() for data=journal.
+	 */
+	if (!sync) {
+		/* Add journal callback entry to finish page writeback and free itself */
+		set_page_writeback(page);
+		jce->jce_private = page;
+		ext4_journal_callback_add(handle, __ext4_jce_finish_page_writeback,
+					  (struct ext4_journal_cb_entry *) jce);
+	}
+
 	err = ext4_journal_stop(handle);
 	if (!ret)
 		ret = err;
@@ -1918,6 +1972,15 @@ static int __ext4_journalled_writepage(struct page *page,
 out:
 	unlock_page(page);
 out_no_pagelock:
+	/*
+	 * Error leg for handle not yet initialized (jce allocation error)
+	 * or failed to. Either way kfree(jce) is ok (it's NULL or valid.)
+	 */
+	if (IS_ERR_OR_NULL(handle)) {
+		put_page(page);
+		kfree(jce);
+	}
+
 	brelse(inode_bh);
 	return ret;
 }
@@ -2029,7 +2092,8 @@ static int ext4_writepage(struct page *page,
 		 * It's mmapped pagecache.  Add buffers and journal it.  There
 		 * doesn't seem much point in redirtying the page here.
 		 */
-		return __ext4_journalled_writepage(page, len);
+		return __ext4_journalled_writepage(page, len,
+						   (wbc->sync_mode == WB_SYNC_ALL));
 
 	ext4_io_submit_init(&io_submit, wbc);
 	io_submit.io_end = ext4_init_io_end(inode, GFP_NOFS);
@@ -2974,6 +3038,14 @@ static int ext4_da_write_begin(struct file *file, struct address_space *mapping,
 	 * of file which has an already mapped buffer.
 	 */
 retry_journal:
+
+	/* XXX(mfo): see comment in non-da ext4_write_begin(). */
+	if (ext4_should_journal_data(inode)) {
+		lock_page(page);
+		wait_on_page_writeback(page);
+		unlock_page(page);
+	}
+
 	handle = ext4_journal_start(inode, EXT4_HT_WRITE_PAGE,
 				ext4_da_write_credits(inode, pos, len));
 	if (IS_ERR(handle)) {
@@ -5929,6 +6001,8 @@ vm_fault_t ext4_page_mkwrite(struct vm_fault *vmf)
 					    ext4_bh_unmapped)) {
 			/* Wait so that we don't change page under IO */
 			wait_for_stable_page(page);
+			if (ext4_should_journal_data(inode))
+				wait_on_page_writeback(page);
 			ret = VM_FAULT_LOCKED;
 			goto out;
 		}
-- 
2.17.1

