Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBF3217D98B
	for <lists+linux-ext4@lfdr.de>; Mon,  9 Mar 2020 08:06:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbgCIHGG (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 9 Mar 2020 03:06:06 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:32879 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbgCIHGF (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 9 Mar 2020 03:06:05 -0400
Received: by mail-pf1-f195.google.com with SMTP id n7so4415589pfn.0
        for <linux-ext4@vger.kernel.org>; Mon, 09 Mar 2020 00:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mCK+8kMAiMl3y5/RSFwJWGdAEt/upl0CADmdFG20PT8=;
        b=oNGezf+AmD23fTVzyN4GvyITlTs6qVSO94U4Q4mEv7LTKZPLIgvKaEuOxm1Hw8eYvV
         ErVJrbcqd6r/Q013fT9fVWC85gNZ0ZvEEBjzETs8QAXNxK/PaWM8Th58HO+oF+fQCMyW
         ZesbfjCcBEwzR+2Czj3lE59bhvCrv3Ge0aBY23SGAggkRLsc3DdVC5tleJBymyssqw3D
         RKPRyfnYXj6/xN2Ij6A+vl1Gpcx6KQy5hTQ8NjSdDZYaX+kF9YzX5ChM4kEpQIFZgWXm
         2gtirpc2KeEZtvE5MaTWhZCJrTnIitH20ltJqJ75SokrLbv0yNM262NWN3pLI2v4h77K
         F/0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mCK+8kMAiMl3y5/RSFwJWGdAEt/upl0CADmdFG20PT8=;
        b=FSJSXpozqC8ulnMYPk7uGZIRVPUsRbagk+VJ+a1PspM1XHbFJH+udbqC1DMyX/D8zD
         R6IE84lxjUBfVeOy2fKzRwVSOj1zkRU7WFXkGMv6vYWLTTugnrXFiGzCrQ2090bUZSqu
         zSlBxLFWwWdn1qqmk0feoZEgQaWayhVuTFTfQSVq3EC/KpcJty7SCrsq5Qn0D957yw2O
         Wkci7s1qPiBMQz8yOsR3HaDiX41SOJ8xSmPv9gwamYLRi6gYm3OFHjSLFhvz6b9FBiEp
         coq4N2CHR3FCgpCJfdPuy/fNHdKQw2dSSVnDo99c499Y8zI8RCxa8sVwC/Sfh8ct9Q0i
         4yCA==
X-Gm-Message-State: ANhLgQ1yYS7Rex82MR1vVpAmlOfLvmMDo0jsWafdrwIxVFBJ4BoJQzKW
        LUz28UgERZJzZWg+suTeXicU4p23
X-Google-Smtp-Source: ADFU+vtDudWViD3lC2vk7Qlgt3xCHGSr/QO3AWSjPTxN/7G11+Muu2k2E0Gwvq/FM8iC52DODhHuug==
X-Received: by 2002:a63:7551:: with SMTP id f17mr11726529pgn.282.1583737562516;
        Mon, 09 Mar 2020 00:06:02 -0700 (PDT)
Received: from harshads0.svl.corp.google.com ([2620:15c:2cd:202:ec1e:207a:e951:9a5b])
        by smtp.googlemail.com with ESMTPSA id 8sm3692593pfp.67.2020.03.09.00.06.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 00:06:02 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v5 09/20] ext4: add inode tracking and ineligible marking routines
Date:   Mon,  9 Mar 2020 00:05:15 -0700
Message-Id: <20200309070526.218202-9-harshadshirwadkar@gmail.com>
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

Under certain situations, such as zeroing a range, there are only data
updates and no metadata updates. We need to track such inodes for fast
commits. Also, under some situations, we need to fall back to full
commits because remembering the delta is either not yet supported or
fast commits won't be "fast" enough. In such cases, we need to mark
inodes as ineligible for fast commits. Add routines that allow
tracking just the inodes and marking inodes as well as entire file
system as fast commit ineligible.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 fs/ext4/ext4.h              |  2 ++
 fs/ext4/ext4_jbd2.c         | 57 +++++++++++++++++++++++++++++++++++++
 fs/ext4/ext4_jbd2.h         |  4 +++
 fs/ext4/super.c             |  1 +
 include/trace/events/ext4.h | 22 ++++++++++++++
 5 files changed, 86 insertions(+)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 1d4fb7b949a5..5cb7f923dbee 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1155,6 +1155,7 @@ struct ext4_inode_info {
 #define	EXT4_ERROR_FS			0x0002	/* Errors detected */
 #define	EXT4_ORPHAN_FS			0x0004	/* Orphans being recovered */
 #define EXT4_FC_REPLAY			0x0008	/* Fast commit replay ongoing */
+#define EXT4_FC_INELIGIBLE		0x0010	/* Fast commit ineligible */
 
 /*
  * Misc. filesystem flags
@@ -1736,6 +1737,7 @@ enum {
 	EXT4_STATE_EXT_PRECACHED,	/* extents have been precached */
 	EXT4_STATE_LUSTRE_EA_INODE,	/* Lustre-style ea_inode */
 	EXT4_STATE_VERITY_IN_PROGRESS,	/* building fs-verity Merkle tree */
+	EXT4_STATE_FC_ELIGIBLE,		/* File is Fast commit eligible */
 };
 
 #define EXT4_INODE_BIT_FNS(name, field, offset)				\
diff --git a/fs/ext4/ext4_jbd2.c b/fs/ext4/ext4_jbd2.c
index 85ba3dc7a3b6..793b6c0fc2fa 100644
--- a/fs/ext4/ext4_jbd2.c
+++ b/fs/ext4/ext4_jbd2.c
@@ -383,6 +383,7 @@ void ext4_reset_inode_fc_info(struct inode *inode)
 	ei->i_fc_lblk_start = 0;
 	ei->i_fc_lblk_end = 0;
 	ei->i_fc_mdata_update = NULL;
+	ext4_clear_inode_state(inode, EXT4_STATE_FC_ELIGIBLE);
 }
 
 void ext4_init_inode_fc_info(struct inode *inode)
@@ -414,6 +415,36 @@ static inline tid_t get_running_txn_tid(struct super_block *sb)
 	return 0;
 }
 
+bool ext4_is_inode_fc_ineligible(struct inode *inode)
+{
+	if (get_running_txn_tid(inode->i_sb) == EXT4_I(inode)->i_fc_tid)
+		return !ext4_test_inode_state(inode, EXT4_STATE_FC_ELIGIBLE);
+	return false;
+}
+
+void ext4_fc_mark_ineligible(struct inode *inode, int reason)
+{
+	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
+	struct ext4_inode_info *ei = EXT4_I(inode);
+
+	if (!ext4_should_fast_commit(inode->i_sb) ||
+	    (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY))
+		return;
+
+	if (sbi->s_journal)
+		ei->i_fc_tid = get_running_txn_tid(inode->i_sb);
+	ext4_clear_inode_state(inode, EXT4_STATE_FC_ELIGIBLE);
+
+	ext4_fc_enqueue_inode(inode);
+}
+
+void ext4_fc_disable(struct super_block *sb, int reason)
+{
+	struct ext4_sb_info *sbi = EXT4_SB(sb);
+
+	sbi->s_mount_state |= EXT4_FC_INELIGIBLE;
+}
+
 /*
  * Generic fast commit tracking function. If this is the first
  * time this we are called after a full commit, we initialize
@@ -439,10 +470,15 @@ static int __ext4_fc_track_template(
 
 	write_lock(&ei->i_fc_lock);
 	if (running_txn_tid == ei->i_fc_tid) {
+		if (!ext4_test_inode_state(inode, EXT4_STATE_FC_ELIGIBLE)) {
+			write_unlock(&ei->i_fc_lock);
+			return -EINVAL;
+		}
 		update = true;
 	} else {
 		ext4_reset_inode_fc_info(inode);
 		ei->i_fc_tid = running_txn_tid;
+		ext4_set_inode_state(inode, EXT4_STATE_FC_ELIGIBLE);
 	}
 	ret = __fc_track_fn(inode, args, update);
 	write_unlock(&ei->i_fc_lock);
@@ -539,6 +575,27 @@ void ext4_fc_track_create(struct inode *inode, struct dentry *dentry)
 	trace_ext4_fc_track_create(inode, dentry, ret);
 }
 
+static int __ext4_fc_add_inode(struct inode *inode, void *arg, bool update)
+{
+	struct ext4_inode_info *ei = EXT4_I(inode);
+
+	if (update)
+		return -EEXIST;
+
+	ei->i_fc_lblk_start = (i_size_read(inode) - 1) >> inode->i_blkbits;
+	ei->i_fc_lblk_end = (i_size_read(inode) - 1) >> inode->i_blkbits;
+
+	return 0;
+}
+
+void ext4_fc_track_inode(struct inode *inode)
+{
+	int ret;
+
+	ret = __ext4_fc_track_template(inode, __ext4_fc_add_inode, NULL);
+	trace_ext4_fc_track_inode(inode, ret);
+}
+
 struct __ext4_fc_track_range_args {
 	ext4_lblk_t start, end;
 };
diff --git a/fs/ext4/ext4_jbd2.h b/fs/ext4/ext4_jbd2.h
index 883f715df71d..401f142172e4 100644
--- a/fs/ext4/ext4_jbd2.h
+++ b/fs/ext4/ext4_jbd2.h
@@ -535,4 +535,8 @@ void ext4_fc_track_unlink(struct inode *inode, struct dentry *dentry);
 void ext4_fc_track_link(struct inode *inode, struct dentry *dentry);
 void ext4_fc_track_create(struct inode *inode, struct dentry *dentry);
 int __init ext4_init_fc_dentry_cache(void);
+void ext4_fc_track_inode(struct inode *inode);
+void ext4_fc_mark_ineligible(struct inode *inode, int reason);
+void ext4_fc_disable(struct super_block *sb, int reason);
+
 #endif	/* _EXT4_JBD2_H */
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 24f975aa5967..7b30f90ec2b7 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -4413,6 +4413,7 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 
 	INIT_LIST_HEAD(&sbi->s_fc_q);
 	INIT_LIST_HEAD(&sbi->s_fc_dentry_q);
+	sbi->s_mount_state &= ~EXT4_FC_INELIGIBLE;
 	spin_lock_init(&sbi->s_fc_lock);
 	sb->s_root = NULL;
 
diff --git a/include/trace/events/ext4.h b/include/trace/events/ext4.h
index 577c6230b23a..5d278a8082a7 100644
--- a/include/trace/events/ext4.h
+++ b/include/trace/events/ext4.h
@@ -2751,6 +2751,28 @@ DEFINE_TRACE_DENTRY_EVENT(create);
 DEFINE_TRACE_DENTRY_EVENT(link);
 DEFINE_TRACE_DENTRY_EVENT(unlink);
 
+TRACE_EVENT(ext4_fc_track_inode,
+	    TP_PROTO(struct inode *inode, int ret),
+
+	    TP_ARGS(inode, ret),
+
+	    TP_STRUCT__entry(
+		    __field(dev_t, dev)
+		    __field(int, ino)
+		    __field(int, error)
+		    ),
+
+	    TP_fast_assign(
+		    __entry->dev = inode->i_sb->s_dev;
+		    __entry->ino = inode->i_ino;
+		    __entry->error = ret;
+		    ),
+
+	    TP_printk("dev %d:%d, inode %d, error %d",
+		      MAJOR(__entry->dev), MINOR(__entry->dev),
+		      __entry->ino, __entry->error)
+	);
+
 TRACE_EVENT(ext4_fc_track_range,
 	    TP_PROTO(struct inode *inode, long start, long end, int ret),
 
-- 
2.25.1.481.gfbce0eb801-goog

