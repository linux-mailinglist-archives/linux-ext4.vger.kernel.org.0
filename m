Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 026912400A3
	for <lists+linux-ext4@lfdr.de>; Mon, 10 Aug 2020 03:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbgHJBCd (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 9 Aug 2020 21:02:33 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:36794 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbgHJBCc (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 9 Aug 2020 21:02:32 -0400
Received: from mail-qv1-f71.google.com ([209.85.219.71])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <mfo@canonical.com>)
        id 1k4wCr-00071j-6M
        for linux-ext4@vger.kernel.org; Mon, 10 Aug 2020 01:02:29 +0000
Received: by mail-qv1-f71.google.com with SMTP id x4so6265075qvu.18
        for <linux-ext4@vger.kernel.org>; Sun, 09 Aug 2020 18:02:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ry5kClhVeJEU90WeiwwQYOS4C7MpG/trNSO+Ys37KEI=;
        b=Fa/nPOo8rfWoq1fwLQ4IfQaWnjZyFDR/PIb+i96rKf+oR3WUzjafa1+arZflTjDmZZ
         QTiM7SWYXwPpFxQ0AIDcXBrqBAL7qtlKZ/KefWxas0dbudr0adbxwrvKkSA/IzQ6FQbc
         qDK+IurQSiSuZ8gAqRKnLK+ulb3xC/AoztVC9k+OzuJlIyqhbSwYw+nFvtPa2YlCWdTJ
         tRGlh4GB5F32lPOTI61vvs6viVq/Qm7yYfezJZWEUQGlRSTSsJ4eJ6YxFk8qZZWZ+41L
         F2/pHraqAovmAuruiz3yzdiehbryegpzOSuiIs7fMqFkS8SoBOuQFg8hCXhlg1HiyuZt
         a+Dg==
X-Gm-Message-State: AOAM533MMzXVpAy5A1Sij1dPRO9YbHe7DYOA06cuc5dVnA87dGRBxNL6
        /CzUUapAYmk0lbXvaT11nTgxmTP+gdBxCW/dSYnv4TM0xr93X8hJ57bXgE1kIRTzBA5aJm8rDiv
        HYd7WGvIi4qhpi44YcJjn1P13V0af1wF05k7DQJM=
X-Received: by 2002:a37:4048:: with SMTP id n69mr22876463qka.421.1597021347727;
        Sun, 09 Aug 2020 18:02:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyS5u+W/NYbVnEM0a/20Emez2vFGKGTGv0zXgDoOLBOVIpKfbijCYwOtQci6BJOwLwF69D7WA==
X-Received: by 2002:a37:4048:: with SMTP id n69mr22876438qka.421.1597021347420;
        Sun, 09 Aug 2020 18:02:27 -0700 (PDT)
Received: from localhost.localdomain ([201.82.49.101])
        by smtp.gmail.com with ESMTPSA id 95sm44815qtc.29.2020.08.09.18.02.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2020 18:02:26 -0700 (PDT)
From:   Mauricio Faria de Oliveira <mfo@canonical.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org,
        dann frazier <dann.frazier@canonical.com>,
        Mauricio Faria de Oliveira <mauricio.foliveira@gmail.com>,
        Jan Kara <jack@suse.com>
Subject: [RFC PATCH v2 5/5] ext4/jbd2: debugging messages
Date:   Sun,  9 Aug 2020 22:02:08 -0300
Message-Id: <20200810010210.3305322-6-mfo@canonical.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200810010210.3305322-1-mfo@canonical.com>
References: <20200810010210.3305322-1-mfo@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

For code tracking and deubgging purposes; some used in cover letter.

---
 fs/ext4/inode.c       | 27 +++++++++++++++++++++++++++
 fs/ext4/super.c       | 10 ++++++++++
 fs/jbd2/commit.c      |  5 +++++
 fs/jbd2/journal.c     |  5 +++++
 fs/jbd2/transaction.c |  4 ++++
 5 files changed, 51 insertions(+)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index ce5464f92a7e..cd01aec87303 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -48,6 +48,17 @@
 
 #include <trace/events/ext4.h>
 
+#include "ext4_jbd2_dbg.h"
+
+static int ext4_bh_tdbg(handle_t *handle, struct buffer_head *bh)
+{
+	struct super_block *sb = bh->b_page->mapping->host->i_sb;
+	tdbg_ext4(sb, "bh: %px, data offset: %04llx, page: %px, inode: %px\n",
+		  bh, (u64) bh->b_data & ((u64)PAGE_SIZE - 1),
+		  bh->b_page, bh->b_page->mapping->host);
+	return 0;
+}
+
 static __u32 ext4_inode_csum(struct inode *inode, struct ext4_inode *raw,
 			      struct ext4_inode_info *ei)
 {
@@ -1193,6 +1204,7 @@ static int ext4_write_begin(struct file *file, struct address_space *mapping,
 		ret = __block_write_begin(page, pos, len, ext4_get_block);
 #endif
 	if (!ret && ext4_should_journal_data(inode)) {
+		tdbg_ext4(inode->i_sb, "journal started: inode %px, txn %px", inode, handle->h_transaction);
 		ret = ext4_walk_page_buffers(handle, page_buffers(page),
 					     from, to, NULL,
 					     do_journal_get_write_access);
@@ -1446,6 +1458,7 @@ static int ext4_journalled_write_end(struct file *file,
 			ext4_orphan_del(NULL, inode);
 	}
 
+	tdbg_ext4(inode->i_sb, "journal stopped: inode %px", inode);
 	return ret ? ret : copied;
 }
 
@@ -1917,6 +1930,10 @@ static int __ext4_journalled_writepage(struct page *page,
 	err = ext4_jbd2_inode_add_write(handle, inode, 0, len);
 	if (ret == 0)
 		ret = err;
+	{
+		struct super_block *sb = handle->h_transaction->t_journal->j_private;
+		tdbg_ext4(sb, "Added inode to txn list: inode %px, txn = %px, err = %d", inode, handle->h_transaction, err);
+	}
 	EXT4_I(inode)->i_datasync_tid = handle->h_transaction->t_tid;
 	err = ext4_journal_stop(handle);
 	if (!ret)
@@ -2035,6 +2052,7 @@ static int ext4_writepage(struct page *page,
 		keep_towrite = true;
 	}
 
+	tdbg_ext4(inode->i_sb, "called for inode %px by comm %s", inode, current->comm);
 	if (PageChecked(page) && ext4_should_journal_data(inode))
 		/*
 		 * It's mmapped pagecache.  Add buffers and journal it.  There
@@ -5969,6 +5987,8 @@ vm_fault_t ext4_page_mkwrite(struct vm_fault *vmf)
 	get_block_t *get_block;
 	int retries = 0;
 
+	tdbg_ext4(inode->i_sb, "entry for inode %px", inode);
+
 	if (unlikely(IS_IMMUTABLE(inode)))
 		return VM_FAULT_SIGBUS;
 
@@ -6006,6 +6026,9 @@ vm_fault_t ext4_page_mkwrite(struct vm_fault *vmf)
 		len = size & ~PAGE_MASK;
 	else
 		len = PAGE_SIZE;
+
+	ext4_walk_page_buffers(NULL, page_buffers(page), 0, len, NULL, ext4_bh_tdbg);
+
 	/*
 	 * Return if we have all the buffers mapped. This avoids the need to do
 	 * journal_start/journal_stop which can block and take a long time. But
@@ -6018,6 +6041,7 @@ vm_fault_t ext4_page_mkwrite(struct vm_fault *vmf)
 			/* Wait so that we don't change page under IO */
 			wait_for_stable_page(page);
 			ret = VM_FAULT_LOCKED;
+			tdbg_ext4(inode->i_sb, "returning; all buffers mapped for inode %px", inode);
 			goto out;
 		}
 	}
@@ -6036,6 +6060,7 @@ vm_fault_t ext4_page_mkwrite(struct vm_fault *vmf)
 	}
 	err = block_page_mkwrite(vma, vmf, get_block);
 	if (!err && ext4_should_journal_data(inode)) {
+		tdbg_ext4(inode->i_sb, "before djgwa(), for inode %px", inode);
 		if (ext4_walk_page_buffers(handle, page_buffers(page), 0,
 			  PAGE_SIZE, NULL, do_journal_get_write_access)) {
 			unlock_page(page);
@@ -6043,6 +6068,7 @@ vm_fault_t ext4_page_mkwrite(struct vm_fault *vmf)
 			ext4_journal_stop(handle);
 			goto out;
 		}
+		tdbg_ext4(inode->i_sb, "after  djgwa(), for inode %px", inode);
 		ext4_set_inode_state(inode, EXT4_STATE_JDATA);
 		if (ext4_jbd2_inode_add_write(handle, inode, 0, PAGE_SIZE)) {
 			unlock_page(page);
@@ -6050,6 +6076,7 @@ vm_fault_t ext4_page_mkwrite(struct vm_fault *vmf)
 			ext4_journal_stop(handle);
 			goto out;
 		}
+		tdbg_ext4(inode->i_sb, "Added inode to txn list: inode %px, txn = %px, err = 0", inode, handle->h_transaction);
 	}
 	ext4_journal_stop(handle);
 	if (err == -ENOSPC && ext4_should_retry_alloc(inode->i_sb, &retries))
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 38aaac6572ea..7167fcf60b5c 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -58,6 +58,8 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/ext4.h>
 
+#include "ext4_jbd2_dbg.h"
+
 static struct ext4_lazy_init *ext4_li_info;
 static struct mutex ext4_li_mtx;
 static struct ratelimit_state ext4_mount_msg_ratelimit;
@@ -492,14 +494,20 @@ static int ext4_journalled_writepage_callback(struct page *page,
 	transaction_t *transaction = (transaction_t *) data;
 	struct buffer_head *bh, *head;
 	struct journal_head *jh;
+	struct super_block *sb = page->mapping->host->i_sb;
 
 	// XXX: any chance of !bh here?
 	bh = head = page_buffers(page);
+	tdbg_ext4(sb, "entry for bh %px, page %px, inode: %px", bh, page, page->mapping->host);
 	do {
 		jh = bh2jh(bh);
 		if (!jh || jh->b_transaction != transaction ||
 		    jh->b_next_transaction) {
 			redirty_page_for_writepage(wbc, page);
+			tdbg_ext4(sb, "redirty for bh %px, jh, %px, txn %px, next_txn %px",
+				  bh, jh,
+				  jh ? jh->b_transaction : NULL,
+				  jh ? jh->b_next_transaction : NULL);
 			goto out;
 		}
 	} while ((bh = bh->b_this_page) != head);
@@ -522,6 +530,7 @@ static int ext4_journalled_submit_inode_data_buffers(struct jbd2_inode *jinode)
 		.range_end = dirty_end,
         };
 
+	tdbg_ext4(jinode->i_vfs_inode->i_sb, "entry for inode: %px", jinode->i_vfs_inode);
 	return write_cache_pages(mapping, &wbc,
 				 ext4_journalled_writepage_callback,
 				 transaction);
@@ -529,6 +538,7 @@ static int ext4_journalled_submit_inode_data_buffers(struct jbd2_inode *jinode)
 
 static int ext4_journalled_finish_inode_data_buffers(struct jbd2_inode *jinode)
 {
+	tdbg_ext4(jinode->i_vfs_inode->i_sb, "entry for inode: %px", jinode->i_vfs_inode);
 	return 0;
 }
 
diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
index b98d227b50d8..96f0d81eadf9 100644
--- a/fs/jbd2/commit.c
+++ b/fs/jbd2/commit.c
@@ -29,6 +29,8 @@
 #include <linux/printk.h>
 #include <linux/delay.h>
 
+#include "../ext4/ext4_jbd2_dbg.h"
+
 static journal_t *force_panic;
 
 /*
@@ -222,11 +224,14 @@ static int journal_submit_data_buffers(journal_t *journal,
 	int err, ret = 0;
 	struct address_space *mapping;
 
+	tdbg_jbd2(journal, "entry for transaction: 0x%px\n", commit_transaction);
 	spin_lock(&journal->j_list_lock);
 	list_for_each_entry(jinode, &commit_transaction->t_inode_list, i_list) {
 		loff_t dirty_start = jinode->i_dirty_start;
 		loff_t dirty_end = jinode->i_dirty_end;
 
+		tdbg_jbd2(journal, "txn list has inode %px (write data flag: 0x%lx)\n", jinode->i_vfs_inode, (jinode->i_flags & JI_WRITE_DATA));
+
 		if (!(jinode->i_flags & JI_WRITE_DATA))
 			continue;
 		mapping = jinode->i_vfs_inode->i_mapping;
diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index e4944436e733..b86b871ee823 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -48,6 +48,8 @@
 #include <linux/uaccess.h>
 #include <asm/page.h>
 
+#include "../ext4/ext4_jbd2_dbg.h"
+
 #ifdef CONFIG_JBD2_DEBUG
 ushort jbd2_journal_enable_debug __read_mostly;
 EXPORT_SYMBOL(jbd2_journal_enable_debug);
@@ -453,6 +455,9 @@ int jbd2_journal_write_metadata_buffer(transaction_t *transaction,
 
 	*bh_out = new_bh;
 
+	tdbg_jbd2(transaction->t_journal, "copy out: done/need %d/%d, bh: %px, offset: %04x, page: %px, inode: %px\n",
+	     done_copy_out, need_copy_out, jh2bh(jh_in), new_offset, new_page, new_page->mapping ? new_page->mapping->host : NULL);
+
 	/*
 	 * The to-be-written buffer needs to get moved to the io queue,
 	 * and the original buffer whose contents we are shadowing or
diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
index e91aad3637a2..93a55a228e08 100644
--- a/fs/jbd2/transaction.c
+++ b/fs/jbd2/transaction.c
@@ -30,6 +30,8 @@
 
 #include <trace/events/jbd2.h>
 
+#include "../ext4/ext4_jbd2_dbg.h"
+
 static void __jbd2_journal_temp_unlink_buffer(struct journal_head *jh);
 static void __jbd2_journal_unfile_buffer(struct journal_head *jh);
 
@@ -952,6 +954,8 @@ do_get_write_access(handle_t *handle, struct journal_head *jh,
 repeat:
 	bh = jh2bh(jh);
 
+	tdbg_jbd2(journal, "entry for bh: %px, offset: %04lx, page %px, inode: %px",
+		  bh, offset_in_page(bh->b_data), bh->b_page, bh->b_page->mapping->host);
 	/* @@@ Need to check for errors here at some point. */
 
  	start_lock = jiffies;
-- 
2.17.1

