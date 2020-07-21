Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3923122887D
	for <lists+linux-ext4@lfdr.de>; Tue, 21 Jul 2020 20:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729259AbgGUSpU (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 21 Jul 2020 14:45:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726602AbgGUSpT (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 21 Jul 2020 14:45:19 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92FDDC061794
        for <linux-ext4@vger.kernel.org>; Tue, 21 Jul 2020 11:45:19 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id mn17so1986516pjb.4
        for <linux-ext4@vger.kernel.org>; Tue, 21 Jul 2020 11:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3vXBdG5zlHq7bsFKln3FZFB9KzPhDpae2gCLfs2AXtY=;
        b=liemjAAA+bLDDjhLJyevMsGUbZXFmvi2dv/Ck2Ah1lA8iplfceRIzcPbenCUsa/qfr
         A3a3ZLpz25jxUxcSyLmY8vzewvLL6KT2hNpwJ9DQioYia1oDPSZg2onO/12dvX3WJpZz
         5hTP3HP/DTwiSiBbUejDllw67FFqbnGyq6EAoq4aGPUEXIQ2bZeQiWYUNZ28j3lj9I6M
         yTIosmJkdGQQnxN2hD3nE4gVdw4+u3h4iw02w+tKdBhvEnQrTAOGAiQBd4ftXvf55gMi
         vJLiAF1WpNdVFd/8CsIawtmOTrEE9BV+Nv4VPq6ObIGPvTjfI4okONUvBNtAxY6XVi9Y
         BhhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3vXBdG5zlHq7bsFKln3FZFB9KzPhDpae2gCLfs2AXtY=;
        b=OUvDVir9D+hpLlcYXsdN7XNv0C3AJ08RnyaTcd5XZzimMP37xQqE6dI/QsRRoIJ63Q
         IKTWEk0Cw/4UAEhnNDL4pNIVBMQ2wKI6YPniIV5aO3VexZvRPuzZuoYFN9L4srKhK0lJ
         U33hakNt2Rxu8TAdu5oqMN5VoxLdSzofSRa1cKh8oYC10tUKRZc0nCWPeCAOVI/quZQz
         YCPzcQEuXc5vkYx/BW24bdHI0DZVMRlRHp7CGgh9vwAZ2ykwBabucicnyBkEK7ATp+b5
         OohfeS/BpsJPzqOybmXI8RcFAXNG4rirDQyOFkHyDOLyjeiOPVOcEHebbt9byN7Z003Y
         Pfsw==
X-Gm-Message-State: AOAM531gCJplqB/YhKbz5uEGDGPJUzhwLa+7fxa7Xn+8bwh73YdSY6x9
        7AHK+H/e7aGPzVqCJmXUqxUV1jJr
X-Google-Smtp-Source: ABdhPJwwa2uVcuVKTeWPxKjuMD1EWu8PxNuJuAyko04e5n8LJ7kiyu/NH3nB7GijVs5s0VZEoEMqbQ==
X-Received: by 2002:a17:902:9f96:: with SMTP id g22mr23061358plq.306.1595357118676;
        Tue, 21 Jul 2020 11:45:18 -0700 (PDT)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:a6ae:11ff:fe11:86a2])
        by smtp.googlemail.com with ESMTPSA id b13sm4179890pjl.7.2020.07.21.11.45.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 11:45:18 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v8 2/7] ext4: add fast_commit feature and handling for extended mount options
Date:   Tue, 21 Jul 2020 11:43:50 -0700
Message-Id: <20200721184355.1616986-3-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.28.0.rc0.105.gf9edc3c819-goog
In-Reply-To: <20200721184355.1616986-1-harshadshirwadkar@gmail.com>
References: <20200721184355.1616986-1-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

We are running out of mount option bits. Add handling for using
s_mount_opt2. Add ext4 and jbd2 fast commit feature flag and also add
ability to turn on / off the fast commit feature in Ext4.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 fs/ext4/ext4.h       |  4 ++++
 fs/ext4/super.c      | 23 +++++++++++++++++++----
 include/linux/jbd2.h |  5 ++++-
 3 files changed, 27 insertions(+), 5 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index ad2dbf6e4924..67419a045748 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1172,6 +1172,8 @@ struct ext4_inode_info {
 #define EXT4_MOUNT2_EXPLICIT_JOURNAL_CHECKSUM	0x00000008 /* User explicitly
 						specified journal checksum */
 
+#define EXT4_MOUNT2_JOURNAL_FAST_COMMIT	0x00000010 /* Journal fast commit */
+
 #define clear_opt(sb, opt)		EXT4_SB(sb)->s_mount_opt &= \
 						~EXT4_MOUNT_##opt
 #define set_opt(sb, opt)		EXT4_SB(sb)->s_mount_opt |= \
@@ -1763,6 +1765,7 @@ static inline bool ext4_verity_in_progress(struct inode *inode)
 #define EXT4_FEATURE_COMPAT_RESIZE_INODE	0x0010
 #define EXT4_FEATURE_COMPAT_DIR_INDEX		0x0020
 #define EXT4_FEATURE_COMPAT_SPARSE_SUPER2	0x0200
+#define EXT4_FEATURE_COMPAT_FAST_COMMIT		0x0400
 #define EXT4_FEATURE_COMPAT_STABLE_INODES	0x0800
 
 #define EXT4_FEATURE_RO_COMPAT_SPARSE_SUPER	0x0001
@@ -1865,6 +1868,7 @@ EXT4_FEATURE_COMPAT_FUNCS(xattr,		EXT_ATTR)
 EXT4_FEATURE_COMPAT_FUNCS(resize_inode,		RESIZE_INODE)
 EXT4_FEATURE_COMPAT_FUNCS(dir_index,		DIR_INDEX)
 EXT4_FEATURE_COMPAT_FUNCS(sparse_super2,	SPARSE_SUPER2)
+EXT4_FEATURE_COMPAT_FUNCS(fast_commit,		FAST_COMMIT)
 EXT4_FEATURE_COMPAT_FUNCS(stable_inodes,	STABLE_INODES)
 
 EXT4_FEATURE_RO_COMPAT_FUNCS(sparse_super,	SPARSE_SUPER)
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index bf5fcb477f66..37450c3a4b23 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1521,6 +1521,7 @@ enum {
 	Opt_dioread_nolock, Opt_dioread_lock,
 	Opt_discard, Opt_nodiscard, Opt_init_itable, Opt_noinit_itable,
 	Opt_max_dir_size_kb, Opt_nojournal_checksum, Opt_nombcache,
+	Opt_no_fc,
 };
 
 static const match_table_t tokens = {
@@ -1604,6 +1605,7 @@ static const match_table_t tokens = {
 	{Opt_init_itable, "init_itable=%u"},
 	{Opt_init_itable, "init_itable"},
 	{Opt_noinit_itable, "noinit_itable"},
+	{Opt_no_fc, "no_fc"},
 	{Opt_max_dir_size_kb, "max_dir_size_kb=%u"},
 	{Opt_test_dummy_encryption, "test_dummy_encryption"},
 	{Opt_nombcache, "nombcache"},
@@ -1726,6 +1728,7 @@ static int clear_qf_name(struct super_block *sb, int qtype)
 #define MOPT_NO_EXT3	0x0200
 #define MOPT_EXT4_ONLY	(MOPT_NO_EXT2 | MOPT_NO_EXT3)
 #define MOPT_STRING	0x0400
+#define MOPT_2		0x0800
 
 static const struct mount_opts {
 	int	token;
@@ -1818,6 +1821,8 @@ static const struct mount_opts {
 	{Opt_max_dir_size_kb, 0, MOPT_GTE0},
 	{Opt_test_dummy_encryption, 0, MOPT_GTE0},
 	{Opt_nombcache, EXT4_MOUNT_NO_MBCACHE, MOPT_SET},
+	{Opt_no_fc, EXT4_MOUNT2_JOURNAL_FAST_COMMIT,
+	 MOPT_CLEAR | MOPT_2 | MOPT_EXT4_ONLY},
 	{Opt_err, 0, 0}
 };
 
@@ -2108,10 +2113,17 @@ static int handle_mount_opt(struct super_block *sb, char *opt, int token,
 			WARN_ON(1);
 			return -1;
 		}
-		if (arg != 0)
-			sbi->s_mount_opt |= m->mount_opt;
-		else
-			sbi->s_mount_opt &= ~m->mount_opt;
+		if (m->flags & MOPT_2) {
+			if (arg != 0)
+				sbi->s_mount_opt2 |= m->mount_opt;
+			else
+				sbi->s_mount_opt2 &= ~m->mount_opt;
+		} else {
+			if (arg != 0)
+				sbi->s_mount_opt |= m->mount_opt;
+			else
+				sbi->s_mount_opt &= ~m->mount_opt;
+		}
 	}
 	return 1;
 }
@@ -3792,6 +3804,8 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 #ifdef CONFIG_EXT4_FS_POSIX_ACL
 	set_opt(sb, POSIX_ACL);
 #endif
+	if (ext4_has_feature_fast_commit(sb))
+		set_opt2(sb, JOURNAL_FAST_COMMIT);
 	/* don't forget to enable journal_csum when metadata_csum is enabled. */
 	if (ext4_has_metadata_csum(sb))
 		set_opt(sb, JOURNAL_CHECKSUM);
@@ -4446,6 +4460,7 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 		sbi->s_def_mount_opt &= ~EXT4_MOUNT_JOURNAL_CHECKSUM;
 		clear_opt(sb, JOURNAL_CHECKSUM);
 		clear_opt(sb, DATA_FLAGS);
+		clear_opt2(sb, JOURNAL_FAST_COMMIT);
 		sbi->s_journal = NULL;
 		needs_recovery = 0;
 		goto no_journal;
diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index f613d8529863..e86d1e6e274a 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -288,6 +288,7 @@ typedef struct journal_superblock_s
 #define JBD2_FEATURE_INCOMPAT_ASYNC_COMMIT	0x00000004
 #define JBD2_FEATURE_INCOMPAT_CSUM_V2		0x00000008
 #define JBD2_FEATURE_INCOMPAT_CSUM_V3		0x00000010
+#define JBD2_FEATURE_INCOMPAT_FAST_COMMIT	0x00000020
 
 /* See "journal feature predicate functions" below */
 
@@ -298,7 +299,8 @@ typedef struct journal_superblock_s
 					JBD2_FEATURE_INCOMPAT_64BIT | \
 					JBD2_FEATURE_INCOMPAT_ASYNC_COMMIT | \
 					JBD2_FEATURE_INCOMPAT_CSUM_V2 | \
-					JBD2_FEATURE_INCOMPAT_CSUM_V3)
+					JBD2_FEATURE_INCOMPAT_CSUM_V3 | \
+					JBD2_FEATURE_INCOMPAT_FAST_COMMIT)
 
 #ifdef __KERNEL__
 
@@ -1234,6 +1236,7 @@ JBD2_FEATURE_INCOMPAT_FUNCS(64bit,		64BIT)
 JBD2_FEATURE_INCOMPAT_FUNCS(async_commit,	ASYNC_COMMIT)
 JBD2_FEATURE_INCOMPAT_FUNCS(csum2,		CSUM_V2)
 JBD2_FEATURE_INCOMPAT_FUNCS(csum3,		CSUM_V3)
+JBD2_FEATURE_INCOMPAT_FUNCS(fast_commit,	FAST_COMMIT)
 
 /*
  * Journal flag definitions
-- 
2.28.0.rc0.105.gf9edc3c819-goog

