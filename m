Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87F62C2E57
	for <lists+linux-ext4@lfdr.de>; Tue,  1 Oct 2019 09:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733117AbfJAHmH (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 1 Oct 2019 03:42:07 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45944 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733115AbfJAHmG (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 1 Oct 2019 03:42:06 -0400
Received: by mail-pg1-f194.google.com with SMTP id q7so8981568pgi.12
        for <linux-ext4@vger.kernel.org>; Tue, 01 Oct 2019 00:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AZIwIIKhkPHpe75S3MVPOuZ40TBL+PpfgqOpwQ3TVG0=;
        b=vhPn11glkQ31XZQfS0gIMaRpFvNgKNXjpsJX5Qx/FulBl/cGB+g1W41vkoUdPDOSQf
         1FJXf8ICI3Z5rkAVX5pVesp/3VbghvyLd/4gBCxmvar1LFrJnorrENH2J9obWu5bo23y
         vIh4KpPSGLuzjHPoaz45YHiN2O0D0PpCxBBKS2AkWZNmPBTBLjBdNzy51+I0K5J4KSxS
         OXyuYPsAy0oj6/hr+Ksb6p0lF7bh9R+QTsip42Tt6hmkp58HilYgYdXFzzd+ka5fJxez
         UijDzW5IzEsz4Jzn+uHze1rdjqKR6gKntknNalAiZ8dUzKjyaT3dOzaRHK6s7OHQHMtn
         XsGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AZIwIIKhkPHpe75S3MVPOuZ40TBL+PpfgqOpwQ3TVG0=;
        b=EGOiiOjokuC65QR/r5tsiI7ZSfed3jpTTT/7jb/hDSVGtp2SaapfedmvJ5kz4/Z18Z
         MDGje2DXJLioQ3CkPa9OICklZ1jc/RrxvYx33fB/3ycJlh/P+M5uhVUi8TjrUZ54Z4gL
         HLymufTSonrKdp85Y76EODs7P9XrS3s0Y356rPAisOo6taW08wgpIwgtDYbvv9HKnm5h
         rA84bvUlidWURq5MlL0DyDeJiekG6FuUAWifW0YEEXc6iAORzWmEijz4v7guIzCy7KUH
         8gGgldpy1/nec1/DOdwy8RLjqU2OyH70Fl4no5Ox0XTUn3V54hrdPQ7joJ7RYlddY89A
         wCNg==
X-Gm-Message-State: APjAAAX9XI+qKSKjsc/uwtDGK5VMDab9aw0jiRoA0rnO9KYGMn7P29jB
        TzQJpXmlqDJxGYcQfkXDNs6Hpy4UGXQ=
X-Google-Smtp-Source: APXvYqy9Ub2B37yVl69lpT2oPGljLXjfuGtQ3qljtkwgOzqN7+reYYQ3Q6Cbzn/ih8RBDXR82z2B4Q==
X-Received: by 2002:a62:1d12:: with SMTP id d18mr26467934pfd.53.1569915725536;
        Tue, 01 Oct 2019 00:42:05 -0700 (PDT)
Received: from harshads0.svl.corp.google.com ([2620:15c:2cd:202:ec1e:207a:e951:9a5b])
        by smtp.googlemail.com with ESMTPSA id q13sm2287668pjq.0.2019.10.01.00.42.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2019 00:42:05 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v3 06/13] ext4: add fields that are needed to track changed files
Date:   Tue,  1 Oct 2019 00:40:55 -0700
Message-Id: <20191001074101.256523-7-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.23.0.444.g18eeb5a265-goog
In-Reply-To: <20191001074101.256523-1-harshadshirwadkar@gmail.com>
References: <20191001074101.256523-1-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Ext4's fast commit feature tracks changed files and maintains them in
a queue. We also remember for each file the logical block range that
needs to be committed. This patch adds these fields to ext4_inode_info
and ext4_sb_info and also adds initialization calls.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 fs/ext4/ext4.h      | 60 +++++++++++++++++++++++++++++++++++++++++++++
 fs/ext4/ext4_jbd2.c | 20 +++++++++++++++
 fs/ext4/ext4_jbd2.h |  2 ++
 fs/ext4/ialloc.c    |  1 +
 fs/ext4/inode.c     |  1 +
 fs/ext4/super.c     |  7 ++++++
 6 files changed, 91 insertions(+)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index becbda38b7db..c36ec23046f3 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -921,6 +921,48 @@ enum {
 	I_DATA_SEM_QUOTA,
 };
 
+/*
+ * Ext4 fast commit inode specific information
+ */
+struct ext4_fast_commit_inode_info {
+	/*
+	 * TID of when this struct was last updated. If fc_tid !=
+	 * running transaction tid, then none of the other fields in this struct
+	 * are valid. Don't directly modify fields in this struct. Use wrappers
+	 * provided in ext4_jbd2.c.
+	 */
+	tid_t fc_tid;
+	/*
+	 * Start of logical block range that needs to be committed in this fast
+	 * commit
+	 */
+	ext4_lblk_t fc_lblk_start;
+
+	/*
+	 * End of logical block range that needs to be committed in this fast
+	 * commit
+	 */
+	ext4_lblk_t fc_lblk_end;
+
+	/*
+	 * Inode number of the directory that contains this inode. This field
+	 * is onlt valid if fc_new is set.
+	 */
+	u32 fc_parent_ino;
+
+	/*
+	 * Flag indicating whether this inode is eligible for fast commits or
+	 * not.
+	 */
+	bool fc_eligible;
+
+	/*
+	 * Flag indicating whether this inode is newly created during this
+	 * tid:subtid.
+	 */
+	bool fc_new;
+	rwlock_t fc_lock;
+};
 
 /*
  * fourth extended file system inode data in memory
@@ -955,6 +997,12 @@ struct ext4_inode_info {
 
 	struct list_head i_orphan;	/* unlinked but open inodes */
 
+	struct list_head i_fc_list;	/*
+					 * inodes that need fast commit
+					 * protected by sbi->s_fc_lock.
+					 */
+	struct ext4_fast_commit_inode_info i_fc;
+
 	/*
 	 * i_disksize keeps track of what the inode size is ON DISK, not
 	 * in memory.  During truncate, i_size is set to the new size by
@@ -1058,7 +1106,9 @@ struct ext4_inode_info {
 	 * fsync and fdatasync, respectively.
 	 */
 	tid_t i_sync_tid;
+	tid_t i_sync_subtid;
 	tid_t i_datasync_tid;
+	tid_t i_datasync_subtid;
 
 #ifdef CONFIG_QUOTA
 	struct dquot *i_dquot[MAXQUOTAS];
@@ -1529,6 +1579,16 @@ struct ext4_sb_info {
 	/* Barrier between changing inodes' journal flags and writepages ops. */
 	struct percpu_rw_semaphore s_journal_flag_rwsem;
 	struct dax_device *s_daxdev;
+
+	/* Ext4 fast commit stuff */
+	bool s_fc_replay;		/* Fast commit replay in progress */
+	struct list_head s_fc_q;	/* Inodes that need fast commit. */
+	__u32 s_fc_q_cnt;		/* Number of inodes in the fc queue */
+	bool s_fc_eligible;		/*
+					 * Are changes after the last commit
+					 * eligible for fast commit?
+					 */
+	spinlock_t s_fc_lock;
 };
 
 static inline struct ext4_sb_info *EXT4_SB(struct super_block *sb)
diff --git a/fs/ext4/ext4_jbd2.c b/fs/ext4/ext4_jbd2.c
index 7c70b08d104c..9066bcfbee29 100644
--- a/fs/ext4/ext4_jbd2.c
+++ b/fs/ext4/ext4_jbd2.c
@@ -330,3 +330,23 @@ int __ext4_handle_dirty_super(const char *where, unsigned int line,
 		mark_buffer_dirty(bh);
 	return err;
 }
+
+static inline
+void ext4_reset_inode_fc_info(struct ext4_fast_commit_inode_info *i_fc)
+{
+	i_fc->fc_tid = 0;
+	i_fc->fc_lblk_start = 0;
+	i_fc->fc_lblk_end = 0;
+	i_fc->fc_parent_ino = 0;
+	i_fc->fc_eligible = false;
+	i_fc->fc_new = false;
+}
+
+void ext4_init_inode_fc_info(struct inode *inode)
+{
+	struct ext4_inode_info *ei = EXT4_I(inode);
+
+	ext4_reset_inode_fc_info(&ei->i_fc);
+	INIT_LIST_HEAD(&ei->i_fc_list);
+	rwlock_init(&ei->i_fc.fc_lock);
+}
diff --git a/fs/ext4/ext4_jbd2.h b/fs/ext4/ext4_jbd2.h
index ef8fcf7d0d3b..2305c1acd415 100644
--- a/fs/ext4/ext4_jbd2.h
+++ b/fs/ext4/ext4_jbd2.h
@@ -459,4 +459,6 @@ static inline int ext4_should_dioread_nolock(struct inode *inode)
 	return 1;
 }
 
+void ext4_init_inode_fc_info(struct inode *inode);
+
 #endif	/* _EXT4_JBD2_H */
diff --git a/fs/ext4/ialloc.c b/fs/ext4/ialloc.c
index 764ff4c56233..ff30f3015551 100644
--- a/fs/ext4/ialloc.c
+++ b/fs/ext4/ialloc.c
@@ -1131,6 +1131,7 @@ struct inode *__ext4_new_inode(handle_t *handle, struct inode *dir,
 
 	ext4_clear_state_flags(ei); /* Only relevant on 32-bit archs */
 	ext4_set_inode_state(inode, EXT4_STATE_NEW);
+	ext4_init_inode_fc_info(inode);
 
 	ei->i_extra_isize = sbi->s_want_extra_isize;
 	ei->i_inline_off = 0;
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 420fe3deed39..f230a888eddd 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -4996,6 +4996,7 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
 	for (block = 0; block < EXT4_N_BLOCKS; block++)
 		ei->i_data[block] = raw_inode->i_block[block];
 	INIT_LIST_HEAD(&ei->i_orphan);
+	ext4_init_inode_fc_info(&ei->vfs_inode);
 
 	/*
 	 * Set transaction id's of transactions that have to be committed
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 7725eb2105f4..c90337fc98c1 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1100,6 +1100,7 @@ static struct inode *ext4_alloc_inode(struct super_block *sb)
 	ei->i_datasync_tid = 0;
 	atomic_set(&ei->i_unwritten, 0);
 	INIT_WORK(&ei->i_rsv_conversion_work, ext4_end_io_rsv_work);
+	ext4_init_inode_fc_info(&ei->vfs_inode);
 	return &ei->vfs_inode;
 }
 
@@ -1139,6 +1140,7 @@ static void init_once(void *foo)
 	init_rwsem(&ei->i_data_sem);
 	init_rwsem(&ei->i_mmap_sem);
 	inode_init_once(&ei->vfs_inode);
+	ext4_init_inode_fc_info(&ei->vfs_inode);
 }
 
 static int __init init_inodecache(void)
@@ -4301,6 +4303,11 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 	INIT_LIST_HEAD(&sbi->s_orphan); /* unlinked but open files */
 	mutex_init(&sbi->s_orphan_lock);
 
+	INIT_LIST_HEAD(&sbi->s_fc_q);
+	sbi->s_fc_q_cnt = 0;
+	sbi->s_fc_eligible = true;
+	spin_lock_init(&sbi->s_fc_lock);
+
 	sb->s_root = NULL;
 
 	needs_recovery = (es->s_last_orphan != 0 ||
-- 
2.23.0.444.g18eeb5a265-goog

