Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50188129EDA
	for <lists+linux-ext4@lfdr.de>; Tue, 24 Dec 2019 09:15:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726088AbfLXIO6 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 24 Dec 2019 03:14:58 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:32972 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbfLXIO4 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 24 Dec 2019 03:14:56 -0500
Received: by mail-pl1-f193.google.com with SMTP id c13so8207518pls.0
        for <linux-ext4@vger.kernel.org>; Tue, 24 Dec 2019 00:14:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9n8R7cXB4BXyO3pA+EsT4xJRmVjymE+BUX/w3cV9hVM=;
        b=V2uFAwaxt9m4/gV5M9Fl6QCYSiiKwagpXRzXn/NO8kxnLDRcz0EK7TC7risIX2feUp
         /0micyfLNz0TIi86S9sh/k8irZcOgmzqyV8qiZelZWVzJ64wQ9VT7PmJhgw2P6A6Go0Q
         Lg/Gxfe44xryyHdxxEcgKoj7Ze+iIQ5b2O4bPEhgBczbokz1/crtZgRMaPVuI53m0nVe
         WYQ2jQ6r/9EJxMoX3Jl0J+NBx3sVXxY/36yZ1+CIXfLn9ITOxT2WT8Qqyra53KSp3EQ5
         cCdl7vOSEi60wNaXAFWUbw28cxSe0T4mFKOV3VmTo9yRwSGObDf+vLLwsYfpqPMSZjww
         +PYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9n8R7cXB4BXyO3pA+EsT4xJRmVjymE+BUX/w3cV9hVM=;
        b=hEslI5yLujV5FZXksYTr28Tf1xSo8LirLoQFwczvcBMFb/UwxL5VgDWA+jmoUfWdw3
         XSOgcCxLC95ZsfSj7zz+Xtg5apquwfLR6x3E7rgxtZlvKmeKprb9kG5+BqLNt8ah7tKW
         SHZPWPEKhJOD5QC3Xn9r5ON9mcJyjcYa8v9J3r3UL6r7VQM1MvtK0I6PqsSWZ13Kz9uB
         tbzWFFvWTDu3Ye7tjVsIhpctkLCUFu11LkZqZdm1lpvyi1et5pFSvp92zXconK5eMsVg
         JTnkAz0EUCRxdEZ/Sj/IJwGvpt/y9J3RPoH4iC+D/89p2JuPPonG9mNZ57lfHVv8I7bU
         6Ejw==
X-Gm-Message-State: APjAAAUheghIo6BYb7Vgr5oKA4OTjD9cY7EwtMEl8ryMYpH48uiWy3aK
        h8Q4XKppIv0TWP8EXFsM7BUVJKqs
X-Google-Smtp-Source: APXvYqy6oxVU1W1r0GgKIHZU6NN9ki++NfqQ7G8EoGktaQ3+qT+86P2RAiOEDOoVZNr2roAqvpEv/Q==
X-Received: by 2002:a17:90a:bd10:: with SMTP id y16mr4391292pjr.108.1577175295857;
        Tue, 24 Dec 2019 00:14:55 -0800 (PST)
Received: from harshads0.svl.corp.google.com ([2620:15c:2cd:202:ec1e:207a:e951:9a5b])
        by smtp.googlemail.com with ESMTPSA id f8sm27370781pfn.2.2019.12.24.00.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Dec 2019 00:14:55 -0800 (PST)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v4 09/20] ext4: add inode tracking and ineligible marking routines
Date:   Tue, 24 Dec 2019 00:13:13 -0800
Message-Id: <20191224081324.95807-9-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
In-Reply-To: <20191224081324.95807-1-harshadshirwadkar@gmail.com>
References: <20191224081324.95807-1-harshadshirwadkar@gmail.com>
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
index 6b08c4e2a08c..b4c32f02071f 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1152,6 +1152,7 @@ struct ext4_inode_info {
 #define	EXT4_ERROR_FS			0x0002	/* Errors detected */
 #define	EXT4_ORPHAN_FS			0x0004	/* Orphans being recovered */
 #define EXT4_FC_REPLAY			0x0008	/* Fast commit replay ongoing */
+#define EXT4_FC_INELIGIBLE		0x0010	/* Fast commit ineligible */
 
 /*
  * Misc. filesystem flags
@@ -1651,6 +1652,7 @@ enum {
 	EXT4_STATE_EXT_PRECACHED,	/* extents have been precached */
 	EXT4_STATE_LUSTRE_EA_INODE,	/* Lustre-style ea_inode */
 	EXT4_STATE_VERITY_IN_PROGRESS,	/* building fs-verity Merkle tree */
+	EXT4_STATE_FC_ELIGIBLE,		/* File is Fast commit eligible */
 };
 
 #define EXT4_INODE_BIT_FNS(name, field, offset)				\
diff --git a/fs/ext4/ext4_jbd2.c b/fs/ext4/ext4_jbd2.c
index f3daa941cba5..7c27f9284064 100644
--- a/fs/ext4/ext4_jbd2.c
+++ b/fs/ext4/ext4_jbd2.c
@@ -342,6 +342,7 @@ void ext4_reset_inode_fc_info(struct inode *inode)
 	ei->i_fc_lblk_start = 0;
 	ei->i_fc_lblk_end = 0;
 	ei->i_fc_mdata_update = NULL;
+	ext4_clear_inode_state(inode, EXT4_STATE_FC_ELIGIBLE);
 }
 
 void ext4_init_inode_fc_info(struct inode *inode)
@@ -373,6 +374,36 @@ static inline tid_t get_running_txn_tid(struct super_block *sb)
 	return 0;
 }
 
+static bool ext4_is_inode_fc_ineligible(struct inode *inode)
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
@@ -398,10 +429,15 @@ static int __ext4_fc_track_template(
 
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
@@ -498,6 +534,27 @@ void ext4_fc_track_create(struct inode *inode, struct dentry *dentry)
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
index 1539e672aec6..60f484377c2e 100644
--- a/fs/ext4/ext4_jbd2.h
+++ b/fs/ext4/ext4_jbd2.h
@@ -479,4 +479,8 @@ void ext4_fc_track_unlink(struct inode *inode, struct dentry *dentry);
 void ext4_fc_track_link(struct inode *inode, struct dentry *dentry);
 void ext4_fc_track_create(struct inode *inode, struct dentry *dentry);
 int __init ext4_init_fc_dentry_cache(void);
+void ext4_fc_track_inode(struct inode *inode);
+void ext4_fc_mark_ineligible(struct inode *inode, int reason);
+void ext4_fc_disable(struct super_block *sb, int reason);
+
 #endif	/* _EXT4_JBD2_H */
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 71ecca296fe4..538ee986d7f7 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -4335,6 +4335,7 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 
 	INIT_LIST_HEAD(&sbi->s_fc_q);
 	INIT_LIST_HEAD(&sbi->s_fc_dentry_q);
+	sbi->s_mount_state &= ~EXT4_FC_INELIGIBLE;
 	spin_lock_init(&sbi->s_fc_lock);
 	sb->s_root = NULL;
 
diff --git a/include/trace/events/ext4.h b/include/trace/events/ext4.h
index 02f9fd718d37..0808b62ac108 100644
--- a/include/trace/events/ext4.h
+++ b/include/trace/events/ext4.h
@@ -2731,6 +2731,28 @@ DEFINE_TRACE_DENTRY_EVENT(create);
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
2.24.1.735.g03f4e72817-goog

