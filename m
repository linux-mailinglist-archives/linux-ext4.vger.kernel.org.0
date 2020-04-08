Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8EE351A2B82
	for <lists+linux-ext4@lfdr.de>; Wed,  8 Apr 2020 23:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbgDHVzy (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 8 Apr 2020 17:55:54 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41122 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726701AbgDHVzw (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 8 Apr 2020 17:55:52 -0400
Received: by mail-pf1-f194.google.com with SMTP id b8so1220722pfp.8
        for <linux-ext4@vger.kernel.org>; Wed, 08 Apr 2020 14:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XHjdeKKwUYR4SKjk2mxZ8+XNNI4oSwIR+5A6Xr13goU=;
        b=rqf+kk16lE2RDDxEU6yKqry86totEozyNcHw5quM5ZFEeIiGQ3P/81aNhiXPVmS8ty
         JTUthyVi09hnsPUt9NbdYl3EeRqJC/gWqXauK+5ZQOPME6XanEeIVZhni+Tyk0D644SY
         OJLvg7a4nTxYw/8FEQu5Ah6XtN+OjUPMPFhbu4w7wG9uNODxRcwSuTp/uBG9ghqUC4oA
         LnQ/XVEmeFunbLjdK2ybx3oyONFoetUNhRSWOYTqIdZacmrcEFI7+UVQDDJmHFol4GdF
         M3IVAJzRUIGFGfVejFHaAkjUdn1TDHBdjtVJySuUteOBql6kpIhjHETgOU2SO4peWIPo
         Jplg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XHjdeKKwUYR4SKjk2mxZ8+XNNI4oSwIR+5A6Xr13goU=;
        b=ewkOgGkZYcnxpLTxbxKWeJGkzUhJ08ttOOkT9+yVfBZmjfEqT2Be04J7GKedE3WHLs
         c0OjgLOIVlJyCqLPoNZcTvN2LSK29HSzoS57laehwVTfQKJaOXhBu5k7CTaY+xyrg1sd
         1IwUePfLe2dLt3pMb0PLz/aj3HahcHapJo48u97tOFVdwj8V5pwND1hIMxcteVFICBlO
         aro0Z7V+MT85cvCcU6DOVttx2DTAKBRfiV+NIomFLvUzSR6cWJS3bR0LRMoRM1/95m1k
         J+STLU/L13sq6pzDcDvAESqNEQVzmSGlWkbX5FjP/Vwtr/F6eZ1PN17l2CIMseaoFx37
         jrmQ==
X-Gm-Message-State: AGi0PuZqjNCa1W7sUG3tYyYpMOVUpV3AujElHXGOOuuQXQdjwIeXl78S
        fxEMZtSbZFiFO/5WHDPiN8aTt5GP
X-Google-Smtp-Source: APiQypKd+Q85GL+Yprl1La2nA6rbFxXMaJuguaI5Y7UBFZcNAcgNIwQPDTVi/8Z+TpwTRdgLrBDR1g==
X-Received: by 2002:a63:df42:: with SMTP id h2mr9112346pgj.216.1586382949806;
        Wed, 08 Apr 2020 14:55:49 -0700 (PDT)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:6271:607:aca0:b6f7])
        by smtp.googlemail.com with ESMTPSA id z7sm450929pju.37.2020.04.08.14.55.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2020 14:55:49 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
X-Google-Original-From: Harshad Shirwadkar <harshads@google.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        kbuild test robot <lkp@intel.com>
Subject: [PATCH v6 07/20] ext4: add generic diff tracking routines and range tracking
Date:   Wed,  8 Apr 2020 14:55:17 -0700
Message-Id: <20200408215530.25649-7-harshads@google.com>
X-Mailer: git-send-email 2.26.0.110.g2183baf09c-goog
In-Reply-To: <20200408215530.25649-1-harshads@google.com>
References: <20200408215530.25649-1-harshads@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

In fast commits, we need to track changes that have been made to the
file system since last full commit. Add generic diff tracking
infrastructure. We use those helpers to track logical block ranges
that have been affected for inodes. The diff tracking helpers are used
in following patches to track directory entry updates as well.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Reported-by: kbuild test robot <lkp@intel.com>
---
 fs/ext4/ext4.h              |  32 ++++++++++
 fs/ext4/ext4_jbd2.c         | 121 ++++++++++++++++++++++++++++++++++++
 fs/ext4/ext4_jbd2.h         |   3 +
 fs/ext4/inode.c             |  18 ++++++
 fs/ext4/super.c             |   5 ++
 include/trace/events/ext4.h |  27 ++++++++
 6 files changed, 206 insertions(+)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 57f8fd4fe6ad..c07ab844c335 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -983,6 +983,32 @@ struct ext4_inode_info {
 
 	struct list_head i_orphan;	/* unlinked but open inodes */
 
+	struct list_head i_fc_list;	/*
+					 * inodes that need fast commit
+					 * protected by sbi->s_fc_lock.
+					 */
+	/*
+	 * TID of when this struct was last updated. If fc_tid !=
+	 * running transaction tid, then none of the other fields in this
+	 * struct are valid. Don't directly modify fields in this struct.
+	 * Use wrappers provided in ext4_jbd2.c.
+	 */
+	tid_t i_fc_tid;
+
+	/*
+	 * Start of logical block range that needs to be committed in
+	 * this fast commit.
+	 */
+	ext4_lblk_t i_fc_lblk_start;
+
+	/*
+	 * End of logical block range that needs to be committed in this fast
+	 * commit
+	 */
+	ext4_lblk_t i_fc_lblk_end;
+
+	rwlock_t i_fc_lock;
+
 	/*
 	 * i_disksize keeps track of what the inode size is ON DISK, not
 	 * in memory.  During truncate, i_size is set to the new size by
@@ -1102,6 +1128,7 @@ struct ext4_inode_info {
 #define	EXT4_VALID_FS			0x0001	/* Unmounted cleanly */
 #define	EXT4_ERROR_FS			0x0002	/* Errors detected */
 #define	EXT4_ORPHAN_FS			0x0004	/* Orphans being recovered */
+#define EXT4_FC_REPLAY			0x0008	/* Fast commit replay ongoing */
 
 /*
  * Misc. filesystem flags
@@ -1567,6 +1594,11 @@ struct ext4_sb_info {
 #ifdef CONFIG_EXT4_DEBUG
 	unsigned long s_simulate_fail;
 #endif
+	/* Ext4 fast commit stuff */
+	struct list_head s_fc_q;	/* Inodes staged for fast commit
+					 * that have data changes in them.
+					 */
+	spinlock_t s_fc_lock;
 };
 
 static inline struct ext4_sb_info *EXT4_SB(struct super_block *sb)
diff --git a/fs/ext4/ext4_jbd2.c b/fs/ext4/ext4_jbd2.c
index 91d6437bc9b3..151a4558c338 100644
--- a/fs/ext4/ext4_jbd2.c
+++ b/fs/ext4/ext4_jbd2.c
@@ -367,6 +367,127 @@ int __ext4_handle_dirty_super(const char *where, unsigned int line,
 		mark_buffer_dirty(bh);
 	return err;
 }
+
+static inline
+void ext4_reset_inode_fc_info(struct inode *inode)
+{
+	struct ext4_inode_info *ei = EXT4_I(inode);
+
+	ei->i_fc_tid = 0;
+	ei->i_fc_lblk_start = 0;
+	ei->i_fc_lblk_end = 0;
+}
+
+void ext4_init_inode_fc_info(struct inode *inode)
+{
+	struct ext4_inode_info *ei = EXT4_I(inode);
+
+	ext4_reset_inode_fc_info(inode);
+	INIT_LIST_HEAD(&ei->i_fc_list);
+}
+
+static void ext4_fc_enqueue_inode(struct inode *inode)
+{
+	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
+
+	if (!ext4_should_fast_commit(inode->i_sb) ||
+	    (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY))
+		return;
+
+	spin_lock(&sbi->s_fc_lock);
+	if (list_empty(&EXT4_I(inode)->i_fc_list))
+		list_add_tail(&EXT4_I(inode)->i_fc_list, &sbi->s_fc_q);
+	spin_unlock(&sbi->s_fc_lock);
+}
+
+static inline tid_t get_running_txn_tid(struct super_block *sb)
+{
+	if (EXT4_SB(sb)->s_journal)
+		return EXT4_SB(sb)->s_journal->j_commit_sequence + 1;
+	return 0;
+}
+
+/*
+ * Generic fast commit tracking function. If this is the first
+ * time this we are called after a full commit, we initialize
+ * fast commit fields and then call __fc_track_fn() with
+ * update = 0. If we have already been called after a full commit,
+ * we pass update = 1. Based on that, the track function can
+ * determine if it needs to track a field for the first time
+ * or if it needs to just update the previously tracked value.
+ */
+static int __ext4_fc_track_template(
+	struct inode *inode,
+	int (*__fc_track_fn)(struct inode *, void *, bool),
+	void *args)
+{
+	tid_t running_txn_tid = get_running_txn_tid(inode->i_sb);
+	bool update = false;
+	struct ext4_inode_info *ei = EXT4_I(inode);
+	int ret;
+
+	if (!ext4_should_fast_commit(inode->i_sb) ||
+	    (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY))
+		return -EOPNOTSUPP;
+
+	write_lock(&ei->i_fc_lock);
+	if (running_txn_tid == ei->i_fc_tid) {
+		update = true;
+	} else {
+		ext4_reset_inode_fc_info(inode);
+		ei->i_fc_tid = running_txn_tid;
+	}
+	ret = __fc_track_fn(inode, args, update);
+	write_unlock(&ei->i_fc_lock);
+
+	ext4_fc_enqueue_inode(inode);
+
+	return ret;
+}
+struct __ext4_fc_track_range_args {
+	ext4_lblk_t start, end;
+};
+
+#define MIN(__a, __b)  ((__a) < (__b) ? (__a) : (__b))
+#define MAX(__a, __b)  ((__a) > (__b) ? (__a) : (__b))
+
+int __ext4_fc_track_range(struct inode *inode, void *arg, bool update)
+{
+	struct ext4_inode_info *ei = EXT4_I(inode);
+	struct __ext4_fc_track_range_args *__arg =
+		(struct __ext4_fc_track_range_args *)arg;
+
+	if (inode->i_ino < EXT4_FIRST_INO(inode->i_sb)) {
+		ext4_debug("Special inode %ld being modified\n", inode->i_ino);
+		return -ECANCELED;
+	}
+
+	if (update) {
+		ei->i_fc_lblk_start = MIN(ei->i_fc_lblk_start, __arg->start);
+		ei->i_fc_lblk_end = MAX(ei->i_fc_lblk_end, __arg->end);
+	} else {
+		ei->i_fc_lblk_start = __arg->start;
+		ei->i_fc_lblk_end = __arg->end;
+	}
+
+	return 0;
+}
+
+void ext4_fc_track_range(struct inode *inode, ext4_lblk_t start,
+			 ext4_lblk_t end)
+{
+	struct __ext4_fc_track_range_args args;
+	int ret;
+
+	args.start = start;
+	args.end = end;
+
+	ret = __ext4_fc_track_template(inode,
+					__ext4_fc_track_range, &args);
+
+	trace_ext4_fc_track_range(inode, start, end, ret);
+}
+
 void ext4_init_fast_commit(struct super_block *sb, journal_t *journal)
 {
 	if (!ext4_should_fast_commit(sb))
diff --git a/fs/ext4/ext4_jbd2.h b/fs/ext4/ext4_jbd2.h
index b15cfa89cf1d..06d1e4a885b7 100644
--- a/fs/ext4/ext4_jbd2.h
+++ b/fs/ext4/ext4_jbd2.h
@@ -531,4 +531,7 @@ static inline int ext4_should_dioread_nolock(struct inode *inode)
 
 #define EXT4_NUM_FC_BLKS		128
 void ext4_init_fast_commit(struct super_block *sb, journal_t *journal);
+void ext4_init_inode_fc_info(struct inode *inode);
+void ext4_fc_track_range(struct inode *inode, ext4_lblk_t start,
+			 ext4_lblk_t end);
 #endif	/* _EXT4_JBD2_H */
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index e416096fc081..3bf0ad4d7d32 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -725,6 +725,8 @@ int ext4_map_blocks(handle_t *handle, struct inode *inode,
 			if (ret)
 				return ret;
 		}
+		ext4_fc_track_range(inode, map->m_lblk,
+			    map->m_lblk + map->m_len - 1);
 	}
 	return retval;
 }
@@ -4073,6 +4075,7 @@ int ext4_punch_hole(struct inode *inode, loff_t offset, loff_t length)
 
 		up_write(&EXT4_I(inode)->i_data_sem);
 	}
+	ext4_fc_track_range(inode, first_block, stop_block);
 	if (IS_SYNC(inode))
 		ext4_handle_sync(handle);
 
@@ -4684,6 +4687,7 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
 	for (block = 0; block < EXT4_N_BLOCKS; block++)
 		ei->i_data[block] = raw_inode->i_block[block];
 	INIT_LIST_HEAD(&ei->i_orphan);
+	ext4_init_inode_fc_info(&ei->vfs_inode);
 
 	/*
 	 * Set transaction id's of transactions that have to be committed
@@ -5351,6 +5355,20 @@ int ext4_setattr(struct dentry *dentry, struct iattr *attr)
 				inode->i_mtime = current_time(inode);
 				inode->i_ctime = inode->i_mtime;
 			}
+
+			if (shrink)
+				ext4_fc_track_range(
+					inode, attr->ia_size >>
+					inode->i_sb->s_blocksize_bits,
+					oldsize >>
+					inode->i_sb->s_blocksize_bits);
+			else
+				ext4_fc_track_range(
+					inode, oldsize >>
+					inode->i_sb->s_blocksize_bits,
+					attr->ia_size >>
+					inode->i_sb->s_blocksize_bits);
+
 			down_write(&EXT4_I(inode)->i_data_sem);
 			EXT4_I(inode)->i_disksize = attr->ia_size;
 			rc = ext4_mark_inode_dirty(handle, inode);
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 0bfaf76200d2..99b24156933a 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1151,6 +1151,8 @@ static struct inode *ext4_alloc_inode(struct super_block *sb)
 	ei->i_datasync_tid = 0;
 	atomic_set(&ei->i_unwritten, 0);
 	INIT_WORK(&ei->i_rsv_conversion_work, ext4_end_io_rsv_work);
+	ext4_init_inode_fc_info(&ei->vfs_inode);
+	rwlock_init(&ei->i_fc_lock);
 	return &ei->vfs_inode;
 }
 
@@ -1193,6 +1195,7 @@ static void init_once(void *foo)
 	init_rwsem(&ei->i_data_sem);
 	init_rwsem(&ei->i_mmap_sem);
 	inode_init_once(&ei->vfs_inode);
+	ext4_init_inode_fc_info(&ei->vfs_inode);
 }
 
 static int __init init_inodecache(void)
@@ -4417,6 +4420,8 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 	INIT_LIST_HEAD(&sbi->s_orphan); /* unlinked but open files */
 	mutex_init(&sbi->s_orphan_lock);
 
+	INIT_LIST_HEAD(&sbi->s_fc_q);
+	spin_lock_init(&sbi->s_fc_lock);
 	sb->s_root = NULL;
 
 	needs_recovery = (es->s_last_orphan != 0 ||
diff --git a/include/trace/events/ext4.h b/include/trace/events/ext4.h
index 19c87661eeec..9424ffb2a54b 100644
--- a/include/trace/events/ext4.h
+++ b/include/trace/events/ext4.h
@@ -2723,6 +2723,33 @@ TRACE_EVENT(ext4_error,
 		  __entry->function, __entry->line)
 );
 
+TRACE_EVENT(ext4_fc_track_range,
+	    TP_PROTO(struct inode *inode, long start, long end, int ret),
+
+	    TP_ARGS(inode, start, end, ret),
+
+	    TP_STRUCT__entry(
+		    __field(dev_t, dev)
+		    __field(int, ino)
+		    __field(long, start)
+		    __field(long, end)
+		    __field(int, error)
+		    ),
+
+	    TP_fast_assign(
+		    __entry->dev = inode->i_sb->s_dev;
+		    __entry->ino = inode->i_ino;
+		    __entry->start = start;
+		    __entry->end = end;
+		    __entry->error = ret;
+		    ),
+
+	    TP_printk("dev %d:%d, inode %d, error %d, start %ld, end %ld",
+		      MAJOR(__entry->dev), MINOR(__entry->dev),
+		      __entry->ino, __entry->error, __entry->start,
+		      __entry->end)
+	);
+
 #endif /* _TRACE_EXT4_H */
 
 /* This part must be outside protection */
-- 
2.26.0.110.g2183baf09c-goog

