Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8769264F0C
	for <lists+linux-ext4@lfdr.de>; Thu, 10 Sep 2020 21:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbgIJTdl (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 10 Sep 2020 15:33:41 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:43016 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727984AbgIJTbn (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 10 Sep 2020 15:31:43 -0400
Received: from mail-qv1-f71.google.com ([209.85.219.71])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <mfo@canonical.com>)
        id 1kGSIF-0000jj-VZ
        for linux-ext4@vger.kernel.org; Thu, 10 Sep 2020 19:31:40 +0000
Received: by mail-qv1-f71.google.com with SMTP id p20so3952061qvl.4
        for <linux-ext4@vger.kernel.org>; Thu, 10 Sep 2020 12:31:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G0YwzWk/54GR5D0aP15u02c0dC9pXHYaZ/gVMt6Bajs=;
        b=qAiDA6qzZh2k2GZsoGYC5o0rdu5odR5mgOS8FV0dj44giuE0oFugvrYi2nCmGHzWoT
         BkAg19pj8JHDTm20usjxpFOG++iCCpT4q13wKZJklqP7U5m5Ur5XEGr9/ety1lxDw4xa
         71z2Kslstw3jilAdvzOPd2r0+G3g1Zod+ATPg68PY7mmNVzY2/VHRDQZWJuKreyumNEo
         v/dN8/KK8ND9o40HDphbXlnmVMK4CFSxFyn5lVG9J8b2CYnk39Yyn8VcLTc+Vfeox4lt
         dsZGNzGqgDIAXqTdeOWAeDSsbFsI4yMDRj0HWlyIUY+YsgEgqp+iZlNzdWt6heHF8b6u
         +t3Q==
X-Gm-Message-State: AOAM5328BO2s6LRvyZRGR9ccgMAZTpjCNEVsWD7he5fYNR6orAU6WZaU
        gU9j/TldmFBR7Cf0vSvRNyLqKPm3omiTPOw1WOw7Bt/mH9iXzqtgYKJ895YeVkvvzLPB8W89TK1
        fPJA8nc6ZWGHCKJgubYGDVXGqz/cV99YFZfXgAdI=
X-Received: by 2002:ad4:53a8:: with SMTP id j8mr10118812qvv.26.1599766299000;
        Thu, 10 Sep 2020 12:31:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxHgPpvGaGtGfZRsHpdxexUIT7C7s17E87NK/R+hdim871YxH7FgycxfLMP7o77rhCv9WNZ6Q==
X-Received: by 2002:ad4:53a8:: with SMTP id j8mr10118793qvv.26.1599766298756;
        Thu, 10 Sep 2020 12:31:38 -0700 (PDT)
Received: from localhost.localdomain ([201.82.49.101])
        by smtp.gmail.com with ESMTPSA id u4sm6410391qkk.68.2020.09.10.12.31.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 12:31:38 -0700 (PDT)
From:   Mauricio Faria de Oliveira <mfo@canonical.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org,
        dann frazier <dann.frazier@canonical.com>,
        Mauricio Faria de Oliveira <mauricio.foliveira@gmail.com>
Subject: [RFC PATCH v3 3/3] ext4: data=journal: write-protect pages on j_submit_inode_data_buffers()
Date:   Thu, 10 Sep 2020 16:31:27 -0300
Message-Id: <20200910193127.276214-4-mfo@canonical.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200910193127.276214-1-mfo@canonical.com>
References: <20200910193127.276214-1-mfo@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This implements journal callbacks j_submit|finish_inode_data_buffers()
with different behavior for data=journal: to write-protect pages under
commit, preventing changes to buffers writeably mapped to userspace.

If a buffer's content changes between commit's checksum calculation
and write-out to disk, it can cause journal recovery/mount failures
upon a kernel crash or power loss.

    [   27.334874] EXT4-fs: Warning: mounting with data=journal disables delayed allocation, dioread_nolock, and O_DIRECT support!
    [   27.339492] JBD2: Invalid checksum recovering data block 8705 in log
    [   27.342716] JBD2: recovery failed
    [   27.343316] EXT4-fs (loop0): error loading journal
    mount: /ext4: can't read superblock on /dev/loop0.

In j_submit_inode_data_buffers() we write-protect the inode's pages
with write_cache_pages() and redirty w/ writepage callback if needed.

In j_finish_inode_data_buffers() there is nothing do to.

And in order to use the callbacks, inodes are added to the inode list
in transaction in __ext4_journalled_writepage() and ext4_page_mkwrite().

In ext4_page_mkwrite() we must make sure that:

1) the inode is always added to the list;
   thus we skip the 'all buffers mapped' optimization on data=journal;

2) the buffers are attached to transaction as dirty;
   as already done in __ext4_journalled_writepage().

Signed-off-by: Mauricio Faria de Oliveira <mfo@canonical.com>
Suggested-by: Jan Kara <jack@suse.cz>
Reported-by: Dann Frazier <dann.frazier@canonical.com>
---
 fs/ext4/inode.c | 29 ++++++++++++++------
 fs/ext4/super.c | 72 +++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 91 insertions(+), 10 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index bf596467c234..fa4109da056c 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1910,6 +1910,9 @@ static int __ext4_journalled_writepage(struct page *page,
 		err = ext4_walk_page_buffers(handle, page_bufs, 0, len, NULL,
 					     write_end_fn);
 	}
+	if (ret == 0)
+		ret = err;
+	err = ext4_jbd2_inode_add_write(handle, inode, 0, len);
 	if (ret == 0)
 		ret = err;
 	EXT4_I(inode)->i_datasync_tid = handle->h_transaction->t_tid;
@@ -6004,9 +6007,12 @@ vm_fault_t ext4_page_mkwrite(struct vm_fault *vmf)
 		len = PAGE_SIZE;
 	/*
 	 * Return if we have all the buffers mapped. This avoids the need to do
-	 * journal_start/journal_stop which can block and take a long time
+	 * journal_start/journal_stop which can block and take a long time.
+	 *
+	 * This cannot be done for data journalling, as we have to add the
+	 * inode to the transaction's list to writeprotect pages on commit.
 	 */
-	if (page_has_buffers(page)) {
+	if (page_has_buffers(page) && !ext4_should_journal_data(inode)) {
 		if (!ext4_walk_page_buffers(NULL, page_buffers(page),
 					    0, len, NULL,
 					    ext4_bh_unmapped)) {
@@ -6032,12 +6038,14 @@ vm_fault_t ext4_page_mkwrite(struct vm_fault *vmf)
 	err = block_page_mkwrite(vma, vmf, get_block);
 	if (!err && ext4_should_journal_data(inode)) {
 		if (ext4_walk_page_buffers(handle, page_buffers(page), 0,
-			  PAGE_SIZE, NULL, do_journal_get_write_access)) {
-			unlock_page(page);
-			ret = VM_FAULT_SIGBUS;
-			ext4_journal_stop(handle);
-			goto out;
-		}
+			PAGE_SIZE, NULL, do_journal_get_write_access))
+			goto out_err;
+		/* Make sure buffers are attached to the transaction as dirty */
+		if (ext4_walk_page_buffers(handle, page_buffers(page), 0,
+			PAGE_SIZE, NULL, write_end_fn))
+			goto out_err;
+		if (ext4_jbd2_inode_add_write(handle, inode, 0, PAGE_SIZE))
+			goto out_err;
 		ext4_set_inode_state(inode, EXT4_STATE_JDATA);
 	}
 	ext4_journal_stop(handle);
@@ -6049,6 +6057,11 @@ vm_fault_t ext4_page_mkwrite(struct vm_fault *vmf)
 	up_read(&EXT4_I(inode)->i_mmap_sem);
 	sb_end_pagefault(inode->i_sb);
 	return ret;
+out_err:
+	unlock_page(page);
+	ret = VM_FAULT_SIGBUS;
+	ext4_journal_stop(handle);
+	goto out;
 }
 
 vm_fault_t ext4_filemap_fault(struct vm_fault *vmf)
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 7303839d7ad9..528b5e20b71c 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -472,14 +472,82 @@ static void ext4_journal_commit_callback(journal_t *journal, transaction_t *txn)
 	spin_unlock(&sbi->s_md_lock);
 }
 
+/*
+ * This writepage callback for write_cache_pages()
+ * takes care of a few cases after page cleaning.
+ *
+ * write_cache_pages() already checks for dirty pages
+ * and calls clear_page_dirty_for_io(), which we want,
+ * to write protect the pages.
+ *
+ * However, we have to redirty a page in these cases:
+ * 1) some buffer is dirty (needs checkpointing)
+ * 2) some buffer is not part of the committing transaction
+ * 3) some buffer already has b_next_transaction set
+ */
+
+static int ext4_journalled_writepage_callback(struct page *page,
+					      struct writeback_control *wbc,
+					      void *data)
+{
+	transaction_t *transaction = (transaction_t *) data;
+	struct buffer_head *bh, *head;
+	struct journal_head *jh;
+
+	bh = head = page_buffers(page);
+	do {
+		jh = bh2jh(bh);
+		if (buffer_dirty(bh) ||
+			(jh && (jh->b_transaction != transaction ||
+				jh->b_next_transaction))) {
+			redirty_page_for_writepage(wbc, page);
+			goto out;
+		}
+	} while ((bh = bh->b_this_page) != head);
+
+out:
+	return AOP_WRITEPAGE_ACTIVATE;
+}
+
+static int ext4_journalled_submit_inode_data_buffers(struct jbd2_inode *jinode)
+{
+	struct address_space *mapping = jinode->i_vfs_inode->i_mapping;
+	transaction_t *transaction = jinode->i_transaction;
+	loff_t dirty_start = jinode->i_dirty_start;
+	loff_t dirty_end = jinode->i_dirty_end;
+
+	struct writeback_control wbc = {
+		.sync_mode =  WB_SYNC_ALL,
+		.nr_to_write = ~0ULL,
+		.range_start = dirty_start,
+		.range_end = dirty_end,
+        };
+
+	return write_cache_pages(mapping, &wbc,
+				 ext4_journalled_writepage_callback,
+				 transaction);
+}
+
 static int ext4_journal_submit_inode_data_buffers(struct jbd2_inode *jinode)
 {
-	return jbd2_journal_submit_inode_data_buffers(jinode);
+	int ret;
+
+	if (ext4_should_journal_data(jinode->i_vfs_inode))
+		ret = ext4_journalled_submit_inode_data_buffers(jinode);
+	else
+		ret = jbd2_journal_submit_inode_data_buffers(jinode);
+
+	return ret;
 }
 
 static int ext4_journal_finish_inode_data_buffers(struct jbd2_inode *jinode)
 {
-	return jbd2_journal_finish_inode_data_buffers(jinode);
+	int ret = 0;
+
+	if (!ext4_should_journal_data(jinode->i_vfs_inode))
+		ret = jbd2_journal_finish_inode_data_buffers(jinode);
+
+	return ret;
 }
 
 static bool system_going_down(void)
-- 
2.17.1

