Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F9A127098B
	for <lists+linux-ext4@lfdr.de>; Sat, 19 Sep 2020 02:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbgISAzL (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 18 Sep 2020 20:55:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbgISAzL (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 18 Sep 2020 20:55:11 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1184BC0613CF
        for <linux-ext4@vger.kernel.org>; Fri, 18 Sep 2020 17:55:11 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id y6so3855891plt.9
        for <linux-ext4@vger.kernel.org>; Fri, 18 Sep 2020 17:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3SYsG5TsHYLZX75zbKUXiJnA8ZHuswr2pWw5f/QbPN8=;
        b=HceGI2uRMk40ftxPXyfQo3WJF76jK/ZzJZzQql5OplQIMYTG4OJSh/g3uEmVQJVGES
         YCknKZ24P57P/Kd3TsN6bVw3YtlFU4axKrlgPNU2uH5hAH7Ah5q+t8hr/lRmmtCJb/AO
         RPrqd/osxQyW/BQSPxRfsGZRgCW9USd5OpHyn/Z8zsS5UgghBYMaDlqSubDojsJPPzm5
         b6FKVb2ZvOvMYBRiV49nxaGEcpRdh+9o/XiUdljDDfNU3VwC+L+zYghuOh2vcqlrhOG/
         FRQuofCPH7ZOMhJXw2ihHGutVQP+UC2kpKkADGxHBEEuJT4XXrWQiLfKBx4nLCrDihXN
         hzkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3SYsG5TsHYLZX75zbKUXiJnA8ZHuswr2pWw5f/QbPN8=;
        b=AEf445sVZ7JzpZzzSTQC9y1eDXRnn9lNmby6TfP1v6tQjXqkIZGhWrfN0InxvkZpNT
         l9gK4BUYU0AcqjLSTywQFgX7cKbGm5xZEpPlN5p8M8mrCK9f0OUcxBHcnoxkA2mkUW9F
         j0+x6utzNeyo8o5Orqy+vZKFPP6FDX7U3kE5Iu63mTboTYEiJZaVNZ67+6IOfWfjFD8f
         HmxDepVJX2WPK5CT5sbudQQi//tF5NEmNsM/4clLbda9RkcsenF6WpiQ4LEEHq8fVtx5
         zQQew3aAEWipS0HvuR2FPjkEzKcJwx2e5EjE1lvvWh+Ka++XF75w9Y0T4rqJdqGfWc67
         /RvQ==
X-Gm-Message-State: AOAM532nPQShYSLGeKSol37Dl/TQ6Y7tk7Jeeh/hlYOEszy8n1Btnbfq
        c+ijYV0yeNOxL+7+H2eb/rvC8UlhuVE=
X-Google-Smtp-Source: ABdhPJxX4jbdy5sC2jkAEEOuqbGdRs6SQT/ywZBCGtjrIRjKOh5c7xpnBq+O+ghYC4DC0Q/3Lv+7KQ==
X-Received: by 2002:a17:90b:3c3:: with SMTP id go3mr16454440pjb.64.1600476910179;
        Fri, 18 Sep 2020 17:55:10 -0700 (PDT)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:a6ae:11ff:fe11:86a2])
        by smtp.googlemail.com with ESMTPSA id f28sm4621953pfq.191.2020.09.18.17.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2020 17:55:09 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v9 2/9] ext4: add fast_commit feature and handling for extended mount options
Date:   Fri, 18 Sep 2020 17:54:44 -0700
Message-Id: <20200919005451.3899779-3-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
In-Reply-To: <20200919005451.3899779-1-harshadshirwadkar@gmail.com>
References: <20200919005451.3899779-1-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

We are running out of mount option bits. Add handling for using
s_mount_opt2. Add ext4 and jbd2 fast commit feature flag and also add
ability to turn on / off the fast commit feature in Ext4.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 fs/ext4/ext4.h       |  4 ++++
 fs/ext4/super.c      | 24 +++++++++++++++++++-----
 include/linux/jbd2.h |  5 ++++-
 3 files changed, 27 insertions(+), 6 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 523e00d7b392..82e889d5c2ed 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1214,6 +1214,8 @@ struct ext4_inode_info {
 #define EXT4_MOUNT2_EXPLICIT_JOURNAL_CHECKSUM	0x00000008 /* User explicitly
 						specified journal checksum */
 
+#define EXT4_MOUNT2_JOURNAL_FAST_COMMIT	0x00000010 /* Journal fast commit */
+
 #define clear_opt(sb, opt)		EXT4_SB(sb)->s_mount_opt &= \
 						~EXT4_MOUNT_##opt
 #define set_opt(sb, opt)		EXT4_SB(sb)->s_mount_opt |= \
@@ -1814,6 +1816,7 @@ static inline bool ext4_verity_in_progress(struct inode *inode)
 #define EXT4_FEATURE_COMPAT_RESIZE_INODE	0x0010
 #define EXT4_FEATURE_COMPAT_DIR_INDEX		0x0020
 #define EXT4_FEATURE_COMPAT_SPARSE_SUPER2	0x0200
+#define EXT4_FEATURE_COMPAT_FAST_COMMIT		0x0400
 #define EXT4_FEATURE_COMPAT_STABLE_INODES	0x0800
 
 #define EXT4_FEATURE_RO_COMPAT_SPARSE_SUPER	0x0001
@@ -1916,6 +1919,7 @@ EXT4_FEATURE_COMPAT_FUNCS(xattr,		EXT_ATTR)
 EXT4_FEATURE_COMPAT_FUNCS(resize_inode,		RESIZE_INODE)
 EXT4_FEATURE_COMPAT_FUNCS(dir_index,		DIR_INDEX)
 EXT4_FEATURE_COMPAT_FUNCS(sparse_super2,	SPARSE_SUPER2)
+EXT4_FEATURE_COMPAT_FUNCS(fast_commit,		FAST_COMMIT)
 EXT4_FEATURE_COMPAT_FUNCS(stable_inodes,	STABLE_INODES)
 
 EXT4_FEATURE_RO_COMPAT_FUNCS(sparse_super,	SPARSE_SUPER)
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 13bdddc081e0..b62858ee420b 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1526,7 +1526,7 @@ enum {
 	Opt_dioread_nolock, Opt_dioread_lock,
 	Opt_discard, Opt_nodiscard, Opt_init_itable, Opt_noinit_itable,
 	Opt_max_dir_size_kb, Opt_nojournal_checksum, Opt_nombcache,
-	Opt_prefetch_block_bitmaps,
+	Opt_prefetch_block_bitmaps, Opt_no_fc,
 };
 
 static const match_table_t tokens = {
@@ -1613,6 +1613,7 @@ static const match_table_t tokens = {
 	{Opt_init_itable, "init_itable=%u"},
 	{Opt_init_itable, "init_itable"},
 	{Opt_noinit_itable, "noinit_itable"},
+	{Opt_no_fc, "no_fc"},
 	{Opt_max_dir_size_kb, "max_dir_size_kb=%u"},
 	{Opt_test_dummy_encryption, "test_dummy_encryption=%s"},
 	{Opt_test_dummy_encryption, "test_dummy_encryption"},
@@ -1738,6 +1739,7 @@ static int clear_qf_name(struct super_block *sb, int qtype)
 #define MOPT_EXT4_ONLY	(MOPT_NO_EXT2 | MOPT_NO_EXT3)
 #define MOPT_STRING	0x0400
 #define MOPT_SKIP	0x0800
+#define	MOPT_2		0x1000
 
 static const struct mount_opts {
 	int	token;
@@ -1838,6 +1840,8 @@ static const struct mount_opts {
 	{Opt_nombcache, EXT4_MOUNT_NO_MBCACHE, MOPT_SET},
 	{Opt_prefetch_block_bitmaps, EXT4_MOUNT_PREFETCH_BLOCK_BITMAPS,
 	 MOPT_SET},
+	{Opt_no_fc, EXT4_MOUNT2_JOURNAL_FAST_COMMIT,
+	 MOPT_CLEAR | MOPT_2 | MOPT_EXT4_ONLY},
 	{Opt_err, 0, 0}
 };
 
@@ -2207,10 +2211,17 @@ static int handle_mount_opt(struct super_block *sb, char *opt, int token,
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
@@ -3924,6 +3935,8 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 #ifdef CONFIG_EXT4_FS_POSIX_ACL
 	set_opt(sb, POSIX_ACL);
 #endif
+	if (ext4_has_feature_fast_commit(sb))
+		set_opt2(sb, JOURNAL_FAST_COMMIT);
 	/* don't forget to enable journal_csum when metadata_csum is enabled. */
 	if (ext4_has_metadata_csum(sb))
 		set_opt(sb, JOURNAL_CHECKSUM);
@@ -4576,6 +4589,7 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 		sbi->s_def_mount_opt &= ~EXT4_MOUNT_JOURNAL_CHECKSUM;
 		clear_opt(sb, JOURNAL_CHECKSUM);
 		clear_opt(sb, DATA_FLAGS);
+		clear_opt2(sb, JOURNAL_FAST_COMMIT);
 		sbi->s_journal = NULL;
 		needs_recovery = 0;
 		goto no_journal;
diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index a756a4cdf939..f438257d7f31 100644
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
 
@@ -1239,6 +1241,7 @@ JBD2_FEATURE_INCOMPAT_FUNCS(64bit,		64BIT)
 JBD2_FEATURE_INCOMPAT_FUNCS(async_commit,	ASYNC_COMMIT)
 JBD2_FEATURE_INCOMPAT_FUNCS(csum2,		CSUM_V2)
 JBD2_FEATURE_INCOMPAT_FUNCS(csum3,		CSUM_V3)
+JBD2_FEATURE_INCOMPAT_FUNCS(fast_commit,	FAST_COMMIT)
 
 /*
  * Journal flag definitions
-- 
2.28.0.681.g6f77f65b4e-goog

