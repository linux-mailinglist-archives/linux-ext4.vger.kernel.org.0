Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11485129ED8
	for <lists+linux-ext4@lfdr.de>; Tue, 24 Dec 2019 09:15:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbfLXIO7 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 24 Dec 2019 03:14:59 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43767 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbfLXIO4 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 24 Dec 2019 03:14:56 -0500
Received: by mail-pf1-f194.google.com with SMTP id x6so9328426pfo.10
        for <linux-ext4@vger.kernel.org>; Tue, 24 Dec 2019 00:14:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Yf9LFCAT24bPO568JcviO/5A6ILpwNe6xdRQ8Y15agI=;
        b=WBAKoyBl4c0NS5KXPHGDwfsUgXGpVL4BrOraDxgED6KcE1aaW31lyAK7S4xsAAQJPO
         6d2qPY6VolK6EgPdh7YLOoa0InBA6VEr3tZdCI6Ro0Xcp013K7baPRcKJEeQVJUA3bJP
         MDCuwaOi+ahHIG6s9dztr4puT1SpGNyJomcjl+s9DAYrVpUv1kneMviPMPLEpIHl+pfh
         Dt3dCSEujV7y0ro5vHT4isRKEovlJoCCgdi36cRZE6nQC8O3jCbG8K2iPjmgdBV+QQCG
         cbkNMz/qLiYy9VIKyKBri7C5oLgTDbSN/Pl/4BmReY7P5kzcy9orE8bB6Hiugkvlz8fC
         1ohQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Yf9LFCAT24bPO568JcviO/5A6ILpwNe6xdRQ8Y15agI=;
        b=RBIwU5I4cX/pttLXPNfeDu387uKZsW9ozWkuGZImfWwTuxfNPChBhXfPlJNlyVzYqU
         dTX03UhcGysULntOeuBGj2O/REYt6UCdxaJ2q9iLjGSdz3c0Rs4mZaVk+l9pq1C5ILrP
         3PYupWe7lGDna0NKg5QVuCRCpkc+9o+XhfoYm63NhncrxsM9L5Im8XdEMOZkmuFtKKf1
         iUBY6qBFoaPRQwO7VMa68h+XQw4RKMUSmEIy2EIdmIM2qoNtczkfWQw/quSYhO01Im4K
         9CiUjJfNsy8fmnjKiln4IEmzWOhtT04fUUFfn5h4lajxiR1KcPJ2LUhHjweHxOBLKV33
         kSRg==
X-Gm-Message-State: APjAAAWvydzRm05ML/ekEFfXKmGAzibT9Yy4oB+ioph22GvMED3UMJdL
        5pF0yhMFHBFJg77md2GRFXLjK3bM
X-Google-Smtp-Source: APXvYqwIFWRzJf9Lc0FUjVWlYvYPSfsdOfnW8Gg2RdvoLN8WVnZmmb9K7oiab55H3mOKfsEMzENPmg==
X-Received: by 2002:a62:cdcb:: with SMTP id o194mr36020861pfg.117.1577175294685;
        Tue, 24 Dec 2019 00:14:54 -0800 (PST)
Received: from harshads0.svl.corp.google.com ([2620:15c:2cd:202:ec1e:207a:e951:9a5b])
        by smtp.googlemail.com with ESMTPSA id f8sm27370781pfn.2.2019.12.24.00.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Dec 2019 00:14:54 -0800 (PST)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v4 07/20] ext4: add generic diff tracking routines and range tracking
Date:   Tue, 24 Dec 2019 00:13:11 -0800
Message-Id: <20191224081324.95807-7-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
In-Reply-To: <20191224081324.95807-1-harshadshirwadkar@gmail.com>
References: <20191224081324.95807-1-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

In fast commits, we need to track changes that have been made to the
file system since last full commit. Add generic diff tracking
infrastructure. We use those helpers to track logical block ranges
that have been affected for inodes. The diff tracking helpers are used
in following patches to track directory entry updates as well.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 fs/ext4/ext4.h              |  33 ++++++++++
 fs/ext4/ext4_jbd2.c         | 121 ++++++++++++++++++++++++++++++++++++
 fs/ext4/ext4_jbd2.h         |   3 +
 fs/ext4/inode.c             |  18 ++++++
 fs/ext4/super.c             |   5 ++
 include/trace/events/ext4.h |  27 ++++++++
 6 files changed, 207 insertions(+)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 16ffe6ed9e74..5c40fa4b593c 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -979,6 +979,32 @@ struct ext4_inode_info {
 
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
@@ -1100,6 +1126,7 @@ struct ext4_inode_info {
 #define	EXT4_VALID_FS			0x0001	/* Unmounted cleanly */
 #define	EXT4_ERROR_FS			0x0002	/* Errors detected */
 #define	EXT4_ORPHAN_FS			0x0004	/* Orphans being recovered */
+#define EXT4_FC_REPLAY			0x0008	/* Fast commit replay ongoing */
 
 /*
  * Misc. filesystem flags
@@ -1558,6 +1585,12 @@ struct ext4_sb_info {
 	/* Barrier between changing inodes' journal flags and writepages ops. */
 	struct percpu_rw_semaphore s_journal_flag_rwsem;
 	struct dax_device *s_daxdev;
+
+	/* Ext4 fast commit stuff */
+	struct list_head s_fc_q;	/* Inodes staged for fast commit
+					 * that have data changes in them.
+					 */
+	spinlock_t s_fc_lock;
 };
 
 static inline struct ext4_sb_info *EXT4_SB(struct super_block *sb)
diff --git a/fs/ext4/ext4_jbd2.c b/fs/ext4/ext4_jbd2.c
index c2ae21f5049b..0907b1b91301 100644
--- a/fs/ext4/ext4_jbd2.c
+++ b/fs/ext4/ext4_jbd2.c
@@ -330,6 +330,127 @@ int __ext4_handle_dirty_super(const char *where, unsigned int line,
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
index e5bd95a088e8..d7eca4b9a935 100644
--- a/fs/ext4/ext4_jbd2.h
+++ b/fs/ext4/ext4_jbd2.h
@@ -472,4 +472,7 @@ static inline int ext4_should_dioread_nolock(struct inode *inode)
 
 #define EXT4_NUM_FC_BLKS		128
 void ext4_init_fast_commit(struct super_block *sb, journal_t *journal);
+void ext4_init_inode_fc_info(struct inode *inode);
+void ext4_fc_track_range(struct inode *inode, ext4_lblk_t start,
+			 ext4_lblk_t end);
 #endif	/* _EXT4_JBD2_H */
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 516faa280ced..07c8da778368 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -744,6 +744,8 @@ int ext4_map_blocks(handle_t *handle, struct inode *inode,
 			if (ret)
 				return ret;
 		}
+		ext4_fc_track_range(inode, map->m_lblk,
+			    map->m_lblk + map->m_len - 1);
 	}
 	return retval;
 }
@@ -4368,6 +4370,7 @@ int ext4_punch_hole(struct inode *inode, loff_t offset, loff_t length)
 
 		up_write(&EXT4_I(inode)->i_data_sem);
 	}
+	ext4_fc_track_range(inode, first_block, stop_block);
 	if (IS_SYNC(inode))
 		ext4_handle_sync(handle);
 
@@ -4965,6 +4968,7 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
 	for (block = 0; block < EXT4_N_BLOCKS; block++)
 		ei->i_data[block] = raw_inode->i_block[block];
 	INIT_LIST_HEAD(&ei->i_orphan);
+	ext4_init_inode_fc_info(&ei->vfs_inode);
 
 	/*
 	 * Set transaction id's of transactions that have to be committed
@@ -5628,6 +5632,20 @@ int ext4_setattr(struct dentry *dentry, struct iattr *attr)
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
index 28675cd78813..2f922ef522a3 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1100,6 +1100,8 @@ static struct inode *ext4_alloc_inode(struct super_block *sb)
 	ei->i_datasync_tid = 0;
 	atomic_set(&ei->i_unwritten, 0);
 	INIT_WORK(&ei->i_rsv_conversion_work, ext4_end_io_rsv_work);
+	ext4_init_inode_fc_info(&ei->vfs_inode);
+	rwlock_init(&ei->i_fc_lock);
 	return &ei->vfs_inode;
 }
 
@@ -1142,6 +1144,7 @@ static void init_once(void *foo)
 	init_rwsem(&ei->i_data_sem);
 	init_rwsem(&ei->i_mmap_sem);
 	inode_init_once(&ei->vfs_inode);
+	ext4_init_inode_fc_info(&ei->vfs_inode);
 }
 
 static int __init init_inodecache(void)
@@ -4330,6 +4333,8 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 	INIT_LIST_HEAD(&sbi->s_orphan); /* unlinked but open files */
 	mutex_init(&sbi->s_orphan_lock);
 
+	INIT_LIST_HEAD(&sbi->s_fc_q);
+	spin_lock_init(&sbi->s_fc_lock);
 	sb->s_root = NULL;
 
 	needs_recovery = (es->s_last_orphan != 0 ||
diff --git a/include/trace/events/ext4.h b/include/trace/events/ext4.h
index d68e9e536814..0f6d43dfd4b2 100644
--- a/include/trace/events/ext4.h
+++ b/include/trace/events/ext4.h
@@ -2703,6 +2703,33 @@ TRACE_EVENT(ext4_error,
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
2.24.1.735.g03f4e72817-goog

