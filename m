Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04EA51A2B84
	for <lists+linux-ext4@lfdr.de>; Wed,  8 Apr 2020 23:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbgDHVz4 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 8 Apr 2020 17:55:56 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44009 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726714AbgDHVzw (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 8 Apr 2020 17:55:52 -0400
Received: by mail-pf1-f196.google.com with SMTP id l1so1138404pff.10
        for <linux-ext4@vger.kernel.org>; Wed, 08 Apr 2020 14:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=19DeMtAJ5UALfeyWX0r6JzF4fe5obfUieLCkFbjvJxM=;
        b=Eax6pzoKsmm4EhZc8TNzVXJjW1X7I8KTxREsc1fosAFATQO1KhZvlykKSpLtqZR2EU
         GUDtxw23CYGG9SDDLgK68PZvETCTa42Sfr2BV64lbiVw9LnOx18Cu4Lt26iOvA0rNQ6e
         X5vrcdDsX+kTXPaYe4Hou0H/kvs/Ut9lfdWssAIgYxVVHWQIUTUtudAy6+ZpFxsGh651
         rmp+qivqIMaqXFKBX8u/+ggeYzo7akEXCQ+Hf3j/LbaOLxIDxYeGKYIkuF/ZNC4z1/0D
         ti+lPcMQsi+ZEcvu6Nc7TYHpy/pej08F/y5cnrXVyIfCzEjJf/gimzDquah/dmuHER98
         Focg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=19DeMtAJ5UALfeyWX0r6JzF4fe5obfUieLCkFbjvJxM=;
        b=Jg+TfTjWU0sjrwAn6xxk9qVus6mSmQJPQALlj3x8aBfv2akb6UB2IjB95ES+CwpS+A
         wlDi00W421ys27EuYMZUvhFS3YUsOiSLjty3Q0AaiaMpFi5V3E56tpwZ3yNHZGBZkUYc
         tbWe5p1p/LKpvd+yoMwuC34mbJS7IGiQ9qtoPA7Ml6xIgL0kKgTdvF5LsjDGfdT1w4O8
         11g61RN8sMUKCjJuYlFc/8oJ55c92qr1wIWfmUmGWalDXq6FHAIsv5Tp9bPVpyr0BAu4
         lKHiXMCFHXfMjQa9dmezCJYmlICqlYAjO2HGVnSxf0GM6ge1ZW2wgiQehK4JaNtkiaQO
         BVow==
X-Gm-Message-State: AGi0PuZIhMOC/dxsicovUJwOrj470X8cfp1l27JEbxXsjyYyfS1OBNK6
        EL8BiJZYd4TRINe6gzecZwPmA6iq
X-Google-Smtp-Source: APiQypIX5PsRO8wjJgalg/tIczZ9PeY7b49HZXMmJeZQ+v9tcJvl5a1/DwLwnSLUtg+ObQYbZCVq1g==
X-Received: by 2002:a63:5053:: with SMTP id q19mr8865830pgl.66.1586382951121;
        Wed, 08 Apr 2020 14:55:51 -0700 (PDT)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:6271:607:aca0:b6f7])
        by smtp.googlemail.com with ESMTPSA id z7sm450929pju.37.2020.04.08.14.55.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2020 14:55:50 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
X-Google-Original-From: Harshad Shirwadkar <harshads@google.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v6 09/20] ext4: add inode tracking and ineligible marking routines
Date:   Wed,  8 Apr 2020 14:55:19 -0700
Message-Id: <20200408215530.25649-9-harshads@google.com>
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
index 669ecf12d392..e9c82f555b6d 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1154,6 +1154,7 @@ struct ext4_inode_info {
 #define	EXT4_ERROR_FS			0x0002	/* Errors detected */
 #define	EXT4_ORPHAN_FS			0x0004	/* Orphans being recovered */
 #define EXT4_FC_REPLAY			0x0008	/* Fast commit replay ongoing */
+#define EXT4_FC_INELIGIBLE		0x0010	/* Fast commit ineligible */
 
 /*
  * Misc. filesystem flags
@@ -1735,6 +1736,7 @@ enum {
 	EXT4_STATE_EXT_PRECACHED,	/* extents have been precached */
 	EXT4_STATE_LUSTRE_EA_INODE,	/* Lustre-style ea_inode */
 	EXT4_STATE_VERITY_IN_PROGRESS,	/* building fs-verity Merkle tree */
+	EXT4_STATE_FC_ELIGIBLE,		/* File is Fast commit eligible */
 };
 
 #define EXT4_INODE_BIT_FNS(name, field, offset)				\
diff --git a/fs/ext4/ext4_jbd2.c b/fs/ext4/ext4_jbd2.c
index ccaaf1c09ba6..9f12ae2fb3ab 100644
--- a/fs/ext4/ext4_jbd2.c
+++ b/fs/ext4/ext4_jbd2.c
@@ -379,6 +379,7 @@ void ext4_reset_inode_fc_info(struct inode *inode)
 	ei->i_fc_lblk_start = 0;
 	ei->i_fc_lblk_end = 0;
 	ei->i_fc_mdata_update = NULL;
+	ext4_clear_inode_state(inode, EXT4_STATE_FC_ELIGIBLE);
 }
 
 void ext4_init_inode_fc_info(struct inode *inode)
@@ -410,6 +411,36 @@ static inline tid_t get_running_txn_tid(struct super_block *sb)
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
@@ -435,10 +466,15 @@ static int __ext4_fc_track_template(
 
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
@@ -535,6 +571,27 @@ void ext4_fc_track_create(struct inode *inode, struct dentry *dentry)
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
index 8fbd09dbfeca..b1239d6be713 100644
--- a/fs/ext4/ext4_jbd2.h
+++ b/fs/ext4/ext4_jbd2.h
@@ -538,4 +538,8 @@ void ext4_fc_track_unlink(struct inode *inode, struct dentry *dentry);
 void ext4_fc_track_link(struct inode *inode, struct dentry *dentry);
 void ext4_fc_track_create(struct inode *inode, struct dentry *dentry);
 int __init ext4_init_fc_dentry_cache(void);
+void ext4_fc_track_inode(struct inode *inode);
+void ext4_fc_mark_ineligible(struct inode *inode, int reason);
+void ext4_fc_disable(struct super_block *sb, int reason);
+
 #endif	/* _EXT4_JBD2_H */
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index a93dada07623..695bc43d5916 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -4422,6 +4422,7 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 
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
2.26.0.110.g2183baf09c-goog

