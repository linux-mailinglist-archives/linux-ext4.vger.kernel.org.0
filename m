Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26C256F82F
	for <lists+linux-ext4@lfdr.de>; Mon, 22 Jul 2019 06:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726120AbfGVECV (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 22 Jul 2019 00:02:21 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43793 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbfGVECU (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 22 Jul 2019 00:02:20 -0400
Received: by mail-pl1-f195.google.com with SMTP id 4so11559351pld.10
        for <linux-ext4@vger.kernel.org>; Sun, 21 Jul 2019 21:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cENVT+VERANVRyFLldAFyfzk9vYfNv2Vc3nfheJf4gk=;
        b=nmFlmQsksTuIFqUAf++zMFbLHXgJr1Rwobkfhhr2LlTks/P1HJt7s8zUDvlIrF77iS
         Wy0ErXDgLdFsDIMTEJAqmJ0GVApMsbIvASNxJkRiuKhfVCCB9VwYFEAfsrbZQhd4nxni
         td6y4TBkoud3DzWRHI6de5dGj1rH++kzClxZxxMCDYtBj1qJ7SBXDeoTL66+qGKQCzpO
         i+V1wLhzdJ62QtDtQOnSPT6IU+7DTEBWKsecXlBNRlERtpKlbRamQMVkXaIARbVw7QBY
         2BO93mLRCwCgId//gdI3myj0G+mzeJWUrQWiIfUgTZtpf5ryOZKJ+135rHrWy/WBk0nv
         bbbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cENVT+VERANVRyFLldAFyfzk9vYfNv2Vc3nfheJf4gk=;
        b=H778zwX+p+mlHfjDIWqwgEXqcrCHbtShImrHZGRLzzvrZVcab90p5Ecwz5zFgUA0+c
         GBvby8zn8QVi++5/sb5stESOMBigMBucjuNEkSW1tp8fp4eBr+hXLGGS4yIJCQQ4jugB
         DJgDjRvC0V+dx/oxfbB8Zo+lB5knhoME2BixbS06e8ldi2itSWmeJMuCewyecNEB51hK
         3rho6Y9fcfQrUyLOFTPz4D0U+IvywH9m/sjmVxqpykWweyMoannsTqibhvE/DtTyPm7Q
         w/mWSvpn/qwD2eL6ucyeNYhNMHgueBNwYfXP5IR1R7RNLQKeWKYR6U2QgNf3AOh4BrjR
         NSHQ==
X-Gm-Message-State: APjAAAXHultZJG8VXfO8MjHx+DO/oxMPlnmAcqgI6fBHtB8gZYlN61jT
        bDiLiE3K1l2mkDIkkCvy/vt/0qv0
X-Google-Smtp-Source: APXvYqwr3+/tqfqrPUYRD3uAU5l7v34HnOUpIeDFGp5PFpGkkJzGPVqiItzNnQk69OZWo85FiHjgEg==
X-Received: by 2002:a17:902:24c:: with SMTP id 70mr72497048plc.2.1563768139586;
        Sun, 21 Jul 2019 21:02:19 -0700 (PDT)
Received: from harshads0.svl.corp.google.com ([2620:15c:2cd:202:ec1e:207a:e951:9a5b])
        by smtp.googlemail.com with ESMTPSA id f14sm37420625pfn.53.2019.07.21.21.02.19
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 21 Jul 2019 21:02:19 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH 07/11] ext4: add fields that are needed to track changed files
Date:   Sun, 21 Jul 2019 21:00:07 -0700
Message-Id: <20190722040011.18892-7-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.22.0.657.g960e92d24f-goog
In-Reply-To: <20190722040011.18892-1-harshadshirwadkar@gmail.com>
References: <20190722040011.18892-1-harshadshirwadkar@gmail.com>
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
 fs/ext4/ext4.h      | 34 ++++++++++++++++++++++++++++++++++
 fs/ext4/ext4_jbd2.c | 13 +++++++++++++
 fs/ext4/ext4_jbd2.h |  2 ++
 fs/ext4/inode.c     |  1 +
 fs/ext4/super.c     |  7 +++++++
 5 files changed, 57 insertions(+)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index becbda38b7db..92dc4432c7ed 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -921,6 +921,27 @@ enum {
 	I_DATA_SEM_QUOTA,
 };
 
+/*
+ * Ext4 fast commit inode specific information
+ */
+struct ext4_fast_commit_inode_info {
+	/* TID / SUB-TID when old_i_size and i_size were recorded */
+	tid_t fc_tid;
+	tid_t fc_subtid;
+
+	/*
+	 * Start of logical block range that needs to be committed in this fast
+	 * commit
+	 */
+	loff_t fc_lblk_start;
+
+	/*
+	 * End of logical block range that needs to be committed in this fast
+	 * commit
+	 */
+	loff_t fc_lblk_end;
+};
+
 
 /*
  * fourth extended file system inode data in memory
@@ -955,6 +976,9 @@ struct ext4_inode_info {
 
 	struct list_head i_orphan;	/* unlinked but open inodes */
 
+	struct list_head i_fc_list;	/* inodes that need fast commit */
+	struct ext4_fast_commit_inode_info i_fc;
+
 	/*
 	 * i_disksize keeps track of what the inode size is ON DISK, not
 	 * in memory.  During truncate, i_size is set to the new size by
@@ -1529,6 +1553,16 @@ struct ext4_sb_info {
 	/* Barrier between changing inodes' journal flags and writepages ops. */
 	struct percpu_rw_semaphore s_journal_flag_rwsem;
 	struct dax_device *s_daxdev;
+
+	/* Ext4 fast commit stuff */
+	bool fc_replay;			/* Fast commit replay in progress */
+	struct list_head s_fc_q;	/* Inodes that need fast commit. */
+	__u32 s_fc_q_cnt;		/* Number of inodes in the fc queue */
+	bool s_fc_eligible;		/*
+					 * Are changes after the last commit
+					 * eligible for fast commit?
+					 */
+	struct mutex s_fc_lock;
 };
 
 static inline struct ext4_sb_info *EXT4_SB(struct super_block *sb)
diff --git a/fs/ext4/ext4_jbd2.c b/fs/ext4/ext4_jbd2.c
index 7c70b08d104c..75b6db808837 100644
--- a/fs/ext4/ext4_jbd2.c
+++ b/fs/ext4/ext4_jbd2.c
@@ -330,3 +330,16 @@ int __ext4_handle_dirty_super(const char *where, unsigned int line,
 		mark_buffer_dirty(bh);
 	return err;
 }
+
+void ext4_init_inode_fc_info(struct inode *inode)
+{
+	handle_t *handle = ext4_journal_current_handle();
+	struct ext4_inode_info *ei = EXT4_I(inode);
+
+	memset(&ei->i_fc, 0, sizeof(ei->i_fc));
+	if (ext4_handle_valid(handle)) {
+		ei->i_fc.fc_tid = handle->h_transaction->t_tid;
+		ei->i_fc.fc_subtid = handle->h_transaction->t_journal->j_subtid;
+	}
+	INIT_LIST_HEAD(&ei->i_fc_list);
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
index 6bab59ae81f7..7b4b35e940a1 100644
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
+	mutex_init(&sbi->s_fc_lock);
+
 	sb->s_root = NULL;
 
 	needs_recovery = (es->s_last_orphan != 0 ||
-- 
2.22.0.657.g960e92d24f-goog

