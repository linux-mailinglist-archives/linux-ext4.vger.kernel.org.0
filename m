Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 245CC2BB6A1
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Nov 2020 21:25:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730642AbgKTUWk (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 20 Nov 2020 15:22:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729277AbgKTUWj (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 20 Nov 2020 15:22:39 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5421C0613CF
        for <linux-ext4@vger.kernel.org>; Fri, 20 Nov 2020 12:22:39 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id f18so8253497pgi.8
        for <linux-ext4@vger.kernel.org>; Fri, 20 Nov 2020 12:22:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kslKh1rmFWKQlB1G7ipOucC9x/ywRrkhiNBipkE54uQ=;
        b=YAZ6m3CEHLmRlbUYNvh7oEU9bnyAlzikikTVFhb56s2wUb/ASgoLr96TY3fmelBZGw
         +0gAC/Qxi6jnDoz9xCX+OzuT7qfdTs/BJ1JuiEU6MlALDdm1hoE0AWC2oLEe0yvro57f
         exb0XUO1N7zUa0iGTQiiTW+0evKoJCnkU2zEz6gBxNZNwop3SsO3efGyz/6jvtwnGp2G
         OSiStbQpR+NDpOn2gC2fu+Yzb5xBZ1r6HuVfDGQSLKeAwyUaavNI+uPo9YEMY4T7GWfx
         xNj9tIe1ZOr5oOU6PQXjlcPlgGwEUuP36EFE1pYskmvh+ngxSGTdKqiJD5rTco5kCDre
         ClJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kslKh1rmFWKQlB1G7ipOucC9x/ywRrkhiNBipkE54uQ=;
        b=BAtuaibgRBX7rm0lZtFnDbbDffCgDKk0UryKedTE5t4ky4CM5/GKwLPPoyZkzCK/62
         5DV95QjTD2O5NbP/KLQ3A3d/GNBZRzDamPK19q+GlgqdprHWE7XSxvLzUBotlRBC8UXa
         J1lRFeDfhkgCXcoK2XCS+EkAnWkZujmivD2G7w7Gnq2646hWd7OnnTv1RJRU41cU3UjJ
         F3Kk6HXqzs6PczEa4NKVHoQtSMG4dWqE3iOq/cdSlzFR9vqM6q4J56ftlkIwX0Cc4fi8
         vEJh9OY+hGUS3ltglFNGQDz/oDfRO1hD16LfKzlxmfkWMa60gIR87F0+SJ1V69R69ChV
         CFdg==
X-Gm-Message-State: AOAM531qMKZ2AhLf57LEf8EASDWm8KVw2CuC11q02kQo9BV+7KmS5yLH
        e3+lykk9STyEZt6DAYqTnZiQxlBN6DE=
X-Google-Smtp-Source: ABdhPJxwI4fwW1sEUBd1kn6RAuC4LV0GxnbQUP65P4wdzNrRM/yT+kwaSKqD6pngH3YE5Ns1u7NDhA==
X-Received: by 2002:a17:90a:c209:: with SMTP id e9mr12646550pjt.87.1605903758712;
        Fri, 20 Nov 2020 12:22:38 -0800 (PST)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:a6ae:11ff:fe11:86a2])
        by smtp.googlemail.com with ESMTPSA id p4sm4789672pjo.6.2020.11.20.12.22.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 12:22:37 -0800 (PST)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH 1/2] ext4: make fast_commit.h byte identical with e2fsprogs/fast_commit.h
Date:   Fri, 20 Nov 2020 12:22:31 -0800
Message-Id: <20201120202232.2240293-1-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This patch makes fast_commit.h byte by byte identical with
e2fsprogs/fast_commit.h. This will help us ensure that there are no
on-disk format inconsistencies between e2fsck and kernel ext4.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 fs/ext4/fast_commit.c | 38 ---------------------
 fs/ext4/fast_commit.h | 78 +++++++++++++++++++++++++++++++++----------
 2 files changed, 61 insertions(+), 55 deletions(-)

diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index c8e17305af65..72335623d2fa 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -1281,18 +1281,6 @@ static void ext4_fc_cleanup(journal_t *journal, int full)
 
 /* Ext4 Replay Path Routines */
 
-/* Get length of a particular tlv */
-static inline int ext4_fc_tag_len(struct ext4_fc_tl *tl)
-{
-	return le16_to_cpu(tl->fc_len);
-}
-
-/* Get a pointer to "value" of a tlv */
-static inline u8 *ext4_fc_tag_val(struct ext4_fc_tl *tl)
-{
-	return (u8 *)tl + sizeof(*tl);
-}
-
 /* Helper struct for dentry replay routines */
 struct dentry_info_args {
 	int parent_ino, dname_len, ino, inode_len;
@@ -1837,32 +1825,6 @@ ext4_fc_replay_del_range(struct super_block *sb, struct ext4_fc_tl *tl)
 	return 0;
 }
 
-static inline const char *tag2str(u16 tag)
-{
-	switch (tag) {
-	case EXT4_FC_TAG_LINK:
-		return "TAG_ADD_ENTRY";
-	case EXT4_FC_TAG_UNLINK:
-		return "TAG_DEL_ENTRY";
-	case EXT4_FC_TAG_ADD_RANGE:
-		return "TAG_ADD_RANGE";
-	case EXT4_FC_TAG_CREAT:
-		return "TAG_CREAT_DENTRY";
-	case EXT4_FC_TAG_DEL_RANGE:
-		return "TAG_DEL_RANGE";
-	case EXT4_FC_TAG_INODE:
-		return "TAG_INODE";
-	case EXT4_FC_TAG_PAD:
-		return "TAG_PAD";
-	case EXT4_FC_TAG_TAIL:
-		return "TAG_TAIL";
-	case EXT4_FC_TAG_HEAD:
-		return "TAG_HEAD";
-	default:
-		return "TAG_ERROR";
-	}
-}
-
 static void ext4_fc_set_bitmaps_and_counters(struct super_block *sb)
 {
 	struct ext4_fc_replay_state *state;
diff --git a/fs/ext4/fast_commit.h b/fs/ext4/fast_commit.h
index 3a6e5a1fa1b8..b77f70f55a62 100644
--- a/fs/ext4/fast_commit.h
+++ b/fs/ext4/fast_commit.h
@@ -3,6 +3,11 @@
 #ifndef __FAST_COMMIT_H__
 #define __FAST_COMMIT_H__
 
+/*
+ * Note this file is present in e2fsprogs/lib/ext2fs/fast_commit.h and
+ * linux/fs/ext4/fast_commit.h. These file should always be byte identical.
+ */
+
 /* Fast commit tags */
 #define EXT4_FC_TAG_ADD_RANGE		0x0001
 #define EXT4_FC_TAG_DEL_RANGE		0x0002
@@ -50,7 +55,7 @@ struct ext4_fc_del_range {
 struct ext4_fc_dentry_info {
 	__le32 fc_parent_ino;
 	__le32 fc_ino;
-	u8 fc_dname[0];
+	__u8 fc_dname[0];
 };
 
 /* Value structure for EXT4_FC_TAG_INODE and EXT4_FC_TAG_INODE_PARTIAL. */
@@ -65,19 +70,6 @@ struct ext4_fc_tail {
 	__le32 fc_crc;
 };
 
-/*
- * In memory list of dentry updates that are performed on the file
- * system used by fast commit code.
- */
-struct ext4_fc_dentry_update {
-	int fcd_op;		/* Type of update create / unlink / link */
-	int fcd_parent;		/* Parent inode number */
-	int fcd_ino;		/* Inode number */
-	struct qstr fcd_name;	/* Dirent name */
-	unsigned char fcd_iname[DNAME_INLINE_LEN];	/* Dirent name string */
-	struct list_head fcd_list;
-};
-
 /*
  * Fast commit reason codes
  */
@@ -107,6 +99,20 @@ enum {
 	EXT4_FC_REASON_MAX
 };
 
+#ifdef __KERNEL__
+/*
+ * In memory list of dentry updates that are performed on the file
+ * system used by fast commit code.
+ */
+struct ext4_fc_dentry_update {
+	int fcd_op;		/* Type of update create / unlink / link */
+	int fcd_parent;		/* Parent inode number */
+	int fcd_ino;		/* Inode number */
+	struct qstr fcd_name;	/* Dirent name */
+	unsigned char fcd_iname[DNAME_INLINE_LEN];	/* Dirent name string */
+	struct list_head fcd_list;
+};
+
 struct ext4_fc_stats {
 	unsigned int fc_ineligible_reason_count[EXT4_FC_REASON_MAX];
 	unsigned long fc_num_commits;
@@ -145,13 +151,51 @@ struct ext4_fc_replay_state {
 };
 
 #define region_last(__region) (((__region)->lblk) + ((__region)->len) - 1)
+#endif
 
 #define fc_for_each_tl(__start, __end, __tl)				\
-	for (tl = (struct ext4_fc_tl *)start;				\
-		(u8 *)tl < (u8 *)end;					\
-		tl = (struct ext4_fc_tl *)((u8 *)tl +			\
+	for (tl = (struct ext4_fc_tl *)(__start);			\
+	     (__u8 *)tl < (__u8 *)(__end);				\
+		tl = (struct ext4_fc_tl *)((__u8 *)tl +			\
 					sizeof(struct ext4_fc_tl) +	\
 					+ le16_to_cpu(tl->fc_len)))
 
+static inline const char *tag2str(__u16 tag)
+{
+	switch (tag) {
+	case EXT4_FC_TAG_LINK:
+		return "ADD_ENTRY";
+	case EXT4_FC_TAG_UNLINK:
+		return "DEL_ENTRY";
+	case EXT4_FC_TAG_ADD_RANGE:
+		return "ADD_RANGE";
+	case EXT4_FC_TAG_CREAT:
+		return "CREAT_DENTRY";
+	case EXT4_FC_TAG_DEL_RANGE:
+		return "DEL_RANGE";
+	case EXT4_FC_TAG_INODE:
+		return "INODE";
+	case EXT4_FC_TAG_PAD:
+		return "PAD";
+	case EXT4_FC_TAG_TAIL:
+		return "TAIL";
+	case EXT4_FC_TAG_HEAD:
+		return "HEAD";
+	default:
+		return "ERROR";
+	}
+}
+
+/* Get length of a particular tlv */
+static inline int ext4_fc_tag_len(struct ext4_fc_tl *tl)
+{
+	return le16_to_cpu(tl->fc_len);
+}
+
+/* Get a pointer to "value" of a tlv */
+static inline __u8 *ext4_fc_tag_val(struct ext4_fc_tl *tl)
+{
+	return (__u8 *)tl + sizeof(*tl);
+}
 
 #endif /* __FAST_COMMIT_H__ */
-- 
2.29.2.454.gaff20da3a2-goog

