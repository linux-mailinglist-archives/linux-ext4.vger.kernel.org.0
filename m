Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C34D017D989
	for <lists+linux-ext4@lfdr.de>; Mon,  9 Mar 2020 08:06:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbgCIHGE (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 9 Mar 2020 03:06:04 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34630 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726428AbgCIHGD (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 9 Mar 2020 03:06:03 -0400
Received: by mail-pf1-f195.google.com with SMTP id 23so2608976pfj.1
        for <linux-ext4@vger.kernel.org>; Mon, 09 Mar 2020 00:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JJJD1m9uFPKHwwWMMMYuJNKZFkz14bdu3VYFXPWZGfw=;
        b=mi+eW+WfduWPNAFnnCJ9M/7R8F7spAYEyYNp/Gl8uHUu/bTX1vSp7KX+6QJUkVl/y/
         6I9Lraf8A9WgxdIInBNmUwYDeKnOOTn92ehQRw1rj/B7EZvIE8Ve6tyaQ/P19AD5BeOw
         6oGM0EFFc2EtW9rjD29PdUpSpidIM4GC1R4p5gWvBGN3QdDwkVU09WQ97Ce2EHUSHYbV
         p0+w+FKGBtWbq2BuG6sv0W9un9AaI5FwQ4eF8lzQ3v9IygDUqQYq3uGHV2zk8qxQCt/A
         hWEQBb3LyGm1kA0MtztqEcZodWJyJPVIx0Bl4A6qurg/a6BsluvnT/iwzmJdG5pgBuQc
         +eXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JJJD1m9uFPKHwwWMMMYuJNKZFkz14bdu3VYFXPWZGfw=;
        b=eNxg2Q+rxu117kZtwRLTdoGzFOp/GN0jnuy9M8xtjl9YgghhB/Evliy7+dgJJnVCrf
         iNZi39/B8OAph9oaX3RqlvGQBtWAb3dtJdaZ935lCyA8bv13h9Ro8hlbMyRQcrYy9MDQ
         CoxU4kOFoTc8joOfRUNHPnM44/HBYGao8tTpjcBn22kEx7N9v3W/8LxXtDhuFZY4AGj3
         zCkB6zVeI/KRIVlGXvAafPScGRTimJjEUB11Zx0dftGHnaemgjNUIxHvkle953WzeIiV
         NhPVOWrCfZ2kmnpSPppICRXfYs/GUiUrJGVum9cDO6fmFhC4XbS4KQZUEk75qs/U/C/z
         n+3w==
X-Gm-Message-State: ANhLgQ1lsqhlWmNDe4c9TMlBQBsHeL+Vav8w3ASPUgB72WgmNGz/P2Vs
        PTUbRiOzQyl8iJFDbVAUgsgEMDWP
X-Google-Smtp-Source: ADFU+vs2z4RptF0Y2DxOv/DM1r0qw1rOb16/9dFWPEjIFnANzb3iN+fARLvLKrInrEhgpjajx3XvCA==
X-Received: by 2002:a63:7c1d:: with SMTP id x29mr14421323pgc.197.1583737561147;
        Mon, 09 Mar 2020 00:06:01 -0700 (PDT)
Received: from harshads0.svl.corp.google.com ([2620:15c:2cd:202:ec1e:207a:e951:9a5b])
        by smtp.googlemail.com with ESMTPSA id 8sm3692593pfp.67.2020.03.09.00.06.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 00:06:00 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        kbuild test robot <lkp@intel.com>
Subject: [PATCH v5 07/20] ext4: add generic diff tracking routines and range tracking
Date:   Mon,  9 Mar 2020 00:05:13 -0700
Message-Id: <20200309070526.218202-7-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
In-Reply-To: <20200309070526.218202-1-harshadshirwadkar@gmail.com>
References: <tytso@mit.edu>
 <20200309070526.218202-1-harshadshirwadkar@gmail.com>
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
index 7a69235ea7b2..286d031a8635 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -984,6 +984,32 @@ struct ext4_inode_info {
 
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
@@ -1103,6 +1129,7 @@ struct ext4_inode_info {
 #define	EXT4_VALID_FS			0x0001	/* Unmounted cleanly */
 #define	EXT4_ERROR_FS			0x0002	/* Errors detected */
 #define	EXT4_ORPHAN_FS			0x0004	/* Orphans being recovered */
+#define EXT4_FC_REPLAY			0x0008	/* Fast commit replay ongoing */
 
 /*
  * Misc. filesystem flags
@@ -1568,6 +1595,11 @@ struct ext4_sb_info {
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
index fd9d138b19c8..57905ff75545 100644
--- a/fs/ext4/ext4_jbd2.c
+++ b/fs/ext4/ext4_jbd2.c
@@ -371,6 +371,127 @@ int __ext4_handle_dirty_super(const char *where, unsigned int line,
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
index 9813efec4b37..940a04a71637 100644
--- a/fs/ext4/ext4_jbd2.h
+++ b/fs/ext4/ext4_jbd2.h
@@ -528,4 +528,7 @@ static inline int ext4_should_dioread_nolock(struct inode *inode)
 
 #define EXT4_NUM_FC_BLKS		128
 void ext4_init_fast_commit(struct super_block *sb, journal_t *journal);
+void ext4_init_inode_fc_info(struct inode *inode);
+void ext4_fc_track_range(struct inode *inode, ext4_lblk_t start,
+			 ext4_lblk_t end);
 #endif	/* _EXT4_JBD2_H */
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index fa0ff78dc033..531aac4ec540 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -726,6 +726,8 @@ int ext4_map_blocks(handle_t *handle, struct inode *inode,
 			if (ret)
 				return ret;
 		}
+		ext4_fc_track_range(inode, map->m_lblk,
+			    map->m_lblk + map->m_len - 1);
 	}
 	return retval;
 }
@@ -4055,6 +4057,7 @@ int ext4_punch_hole(struct inode *inode, loff_t offset, loff_t length)
 
 		up_write(&EXT4_I(inode)->i_data_sem);
 	}
+	ext4_fc_track_range(inode, first_block, stop_block);
 	if (IS_SYNC(inode))
 		ext4_handle_sync(handle);
 
@@ -4670,6 +4673,7 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
 	for (block = 0; block < EXT4_N_BLOCKS; block++)
 		ei->i_data[block] = raw_inode->i_block[block];
 	INIT_LIST_HEAD(&ei->i_orphan);
+	ext4_init_inode_fc_info(&ei->vfs_inode);
 
 	/*
 	 * Set transaction id's of transactions that have to be committed
@@ -5338,6 +5342,20 @@ int ext4_setattr(struct dentry *dentry, struct iattr *attr)
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
index 67ea93532af4..86ec800baadf 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1154,6 +1154,8 @@ static struct inode *ext4_alloc_inode(struct super_block *sb)
 	ei->i_datasync_tid = 0;
 	atomic_set(&ei->i_unwritten, 0);
 	INIT_WORK(&ei->i_rsv_conversion_work, ext4_end_io_rsv_work);
+	ext4_init_inode_fc_info(&ei->vfs_inode);
+	rwlock_init(&ei->i_fc_lock);
 	return &ei->vfs_inode;
 }
 
@@ -1196,6 +1198,7 @@ static void init_once(void *foo)
 	init_rwsem(&ei->i_data_sem);
 	init_rwsem(&ei->i_mmap_sem);
 	inode_init_once(&ei->vfs_inode);
+	ext4_init_inode_fc_info(&ei->vfs_inode);
 }
 
 static int __init init_inodecache(void)
@@ -4408,6 +4411,8 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
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
2.25.1.481.gfbce0eb801-goog

