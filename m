Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E78DC2E52
	for <lists+linux-ext4@lfdr.de>; Tue,  1 Oct 2019 09:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728926AbfJAHmD (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 1 Oct 2019 03:42:03 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44478 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728249AbfJAHmD (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 1 Oct 2019 03:42:03 -0400
Received: by mail-pf1-f196.google.com with SMTP id q21so7287321pfn.11
        for <linux-ext4@vger.kernel.org>; Tue, 01 Oct 2019 00:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OURPjTRTXuglZULKxoZ5ncYc60pHs4vLUxcp1tLNHN0=;
        b=gV14bNcsprFFBpLd/QTHUYWCcZsRupt2vO3cwEORjMQGdPSyWyEJE4mHPZK1JJ5QQ6
         V0CYxZjp0yGrd35EFL9o1cKHcvl1qkkII/L08h2YkF2fmpSiGRTEtdf3YXrSnohqsPJ6
         +nVmnrkWv8hsB/dHIMpYuR3ydRWPtEDQribRB1CZdKISCXCk/Oz0HtyykwosBjRMHgYW
         XJvoku+P8lZEo/CBu2ydAfvsXVTjEVKXSy/SVEh0utDrRX8JlByZ68/Hs1jgI6+3rTd8
         TUTMtfTBdZefMsAMiF+gQ4Yx1y2dMI6LPHASXkVvWRGD4WftnfaNpr9U7KA8R5WOS5Ph
         Fk6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OURPjTRTXuglZULKxoZ5ncYc60pHs4vLUxcp1tLNHN0=;
        b=V9sKgiNdlIb9rco4wOnmEFmmBfCCUr7pV3KP5tLtqn70gYKp58HVeqW87NGniGkJKj
         AlH50foHD+wHXRKUtUjMRNqdZ+KTQooNdtZBojcpcozDshZQO2BuJ7P5ee4TuvVcEIFa
         3xb+LBlZTv2rf1AdrLkX/lRRbKsubihVTi4hhnS77K1kZH9xf1LCm4VNpTRM7S4knrDm
         xfV7LwdrSJadQRr4c8/93tyBytn5S1OHlV8ydJZ4RIoOA9b4myNAJswSTlHqGYGYluG3
         eJB1TiYsMXMcdULyx3HFGw63iE6RUhSpniND2dMfy6V8B3AxqVPZSnjEQ4RAMGG93M8B
         tfOg==
X-Gm-Message-State: APjAAAVwwWn3dPwjg6ZH3ZiAUV8COJlBBxeh6UQXp1VJnM64jxL2QiBc
        cZ6fW83WBAlM1iIJlo1ZKebBuRhJYrk=
X-Google-Smtp-Source: APXvYqySgwa9yveskwbdNaN1pdtM+37UA/mkuM4tNXGuKzQilOyQQmjISnZAVKT5IPAx67GLaZPfQw==
X-Received: by 2002:a62:19c7:: with SMTP id 190mr26555009pfz.105.1569915722234;
        Tue, 01 Oct 2019 00:42:02 -0700 (PDT)
Received: from harshads0.svl.corp.google.com ([2620:15c:2cd:202:ec1e:207a:e951:9a5b])
        by smtp.googlemail.com with ESMTPSA id q13sm2287668pjq.0.2019.10.01.00.42.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2019 00:42:01 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Andreas Dilger <adilger@dilger.ca>,
        Theodore Ts'o <tytso@mit.edu>
Subject: [PATCH v3 01/13] ext4: add handling for extended mount options
Date:   Tue,  1 Oct 2019 00:40:50 -0700
Message-Id: <20191001074101.256523-2-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.23.0.444.g18eeb5a265-goog
In-Reply-To: <20191001074101.256523-1-harshadshirwadkar@gmail.com>
References: <20191001074101.256523-1-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

We are running out of mount option bits. This patch adds handling for
using s_mount_opt2 and also adds ability to turn on / off the fast
commit feature. In order to use fast commits, new version e2fsprogs
needs to set the fast feature commit flag. This also makes sure that
we have fast commit compatible e2fsprogs before starting to use the
feature. Mount flag "no_fastcommit", introuced in this patch, can be
passed to disable the feature at mount time.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Reviewed-by: Andreas Dilger <adilger@dilger.ca>
Reviewed-by: Theodore Ts'o <tytso@mit.edu>
---
 fs/ext4/ext4.h       |  4 ++++
 fs/ext4/super.c      | 27 ++++++++++++++++++++++-----
 include/linux/jbd2.h |  5 ++++-
 3 files changed, 30 insertions(+), 6 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index bf660aa7a9e0..becbda38b7db 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1146,6 +1146,8 @@ struct ext4_inode_info {
 #define EXT4_MOUNT2_EXPLICIT_JOURNAL_CHECKSUM	0x00000008 /* User explicitly
 						specified journal checksum */
 
+#define EXT4_MOUNT2_JOURNAL_FAST_COMMIT	0x00000010 /* Journal fast commit */
+
 #define clear_opt(sb, opt)		EXT4_SB(sb)->s_mount_opt &= \
 						~EXT4_MOUNT_##opt
 #define set_opt(sb, opt)		EXT4_SB(sb)->s_mount_opt |= \
@@ -1643,6 +1645,7 @@ static inline void ext4_clear_state_flags(struct ext4_inode_info *ei)
 #define EXT4_FEATURE_COMPAT_RESIZE_INODE	0x0010
 #define EXT4_FEATURE_COMPAT_DIR_INDEX		0x0020
 #define EXT4_FEATURE_COMPAT_SPARSE_SUPER2	0x0200
+#define EXT4_FEATURE_COMPAT_FAST_COMMIT		0x0400
 
 #define EXT4_FEATURE_RO_COMPAT_SPARSE_SUPER	0x0001
 #define EXT4_FEATURE_RO_COMPAT_LARGE_FILE	0x0002
@@ -1743,6 +1746,7 @@ EXT4_FEATURE_COMPAT_FUNCS(xattr,		EXT_ATTR)
 EXT4_FEATURE_COMPAT_FUNCS(resize_inode,		RESIZE_INODE)
 EXT4_FEATURE_COMPAT_FUNCS(dir_index,		DIR_INDEX)
 EXT4_FEATURE_COMPAT_FUNCS(sparse_super2,	SPARSE_SUPER2)
+EXT4_FEATURE_COMPAT_FUNCS(fast_commit,		FAST_COMMIT)
 
 EXT4_FEATURE_RO_COMPAT_FUNCS(sparse_super,	SPARSE_SUPER)
 EXT4_FEATURE_RO_COMPAT_FUNCS(large_file,	LARGE_FILE)
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 4079605d437a..e376ac040cce 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1455,6 +1455,7 @@ enum {
 	Opt_dioread_nolock, Opt_dioread_lock,
 	Opt_discard, Opt_nodiscard, Opt_init_itable, Opt_noinit_itable,
 	Opt_max_dir_size_kb, Opt_nojournal_checksum, Opt_nombcache,
+	Opt_no_fastcommit
 };
 
 static const match_table_t tokens = {
@@ -1537,6 +1538,7 @@ static const match_table_t tokens = {
 	{Opt_init_itable, "init_itable=%u"},
 	{Opt_init_itable, "init_itable"},
 	{Opt_noinit_itable, "noinit_itable"},
+	{Opt_no_fastcommit, "no_fastcommit"},
 	{Opt_max_dir_size_kb, "max_dir_size_kb=%u"},
 	{Opt_test_dummy_encryption, "test_dummy_encryption"},
 	{Opt_nombcache, "nombcache"},
@@ -1659,6 +1661,7 @@ static int clear_qf_name(struct super_block *sb, int qtype)
 #define MOPT_NO_EXT3	0x0200
 #define MOPT_EXT4_ONLY	(MOPT_NO_EXT2 | MOPT_NO_EXT3)
 #define MOPT_STRING	0x0400
+#define MOPT_2		0x0800
 
 static const struct mount_opts {
 	int	token;
@@ -1751,6 +1754,8 @@ static const struct mount_opts {
 	{Opt_max_dir_size_kb, 0, MOPT_GTE0},
 	{Opt_test_dummy_encryption, 0, MOPT_GTE0},
 	{Opt_nombcache, EXT4_MOUNT_NO_MBCACHE, MOPT_SET},
+	{Opt_no_fastcommit, EXT4_MOUNT2_JOURNAL_FAST_COMMIT,
+	 MOPT_CLEAR | MOPT_2 | MOPT_EXT4_ONLY},
 	{Opt_err, 0, 0}
 };
 
@@ -1858,8 +1863,9 @@ static int handle_mount_opt(struct super_block *sb, char *opt, int token,
 			set_opt2(sb, EXPLICIT_DELALLOC);
 		} else if (m->mount_opt & EXT4_MOUNT_JOURNAL_CHECKSUM) {
 			set_opt2(sb, EXPLICIT_JOURNAL_CHECKSUM);
-		} else
+		} else if (m->mount_opt) {
 			return -1;
+		}
 	}
 	if (m->flags & MOPT_CLEAR_ERR)
 		clear_opt(sb, ERRORS_MASK);
@@ -2027,10 +2033,17 @@ static int handle_mount_opt(struct super_block *sb, char *opt, int token,
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
@@ -3733,6 +3746,9 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 #ifdef CONFIG_EXT4_FS_POSIX_ACL
 	set_opt(sb, POSIX_ACL);
 #endif
+	if (ext4_has_feature_fast_commit(sb))
+		set_opt2(sb, JOURNAL_FAST_COMMIT);
+
 	/* don't forget to enable journal_csum when metadata_csum is enabled. */
 	if (ext4_has_metadata_csum(sb))
 		set_opt(sb, JOURNAL_CHECKSUM);
@@ -4334,6 +4350,7 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 		sbi->s_def_mount_opt &= ~EXT4_MOUNT_JOURNAL_CHECKSUM;
 		clear_opt(sb, JOURNAL_CHECKSUM);
 		clear_opt(sb, DATA_FLAGS);
+		clear_opt2(sb, JOURNAL_FAST_COMMIT);
 		sbi->s_journal = NULL;
 		needs_recovery = 0;
 		goto no_journal;
diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index df03825ad1a1..b7eed49b8ecd 100644
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
 
@@ -1235,6 +1237,7 @@ JBD2_FEATURE_INCOMPAT_FUNCS(64bit,		64BIT)
 JBD2_FEATURE_INCOMPAT_FUNCS(async_commit,	ASYNC_COMMIT)
 JBD2_FEATURE_INCOMPAT_FUNCS(csum2,		CSUM_V2)
 JBD2_FEATURE_INCOMPAT_FUNCS(csum3,		CSUM_V3)
+JBD2_FEATURE_INCOMPAT_FUNCS(fast_commit,	FAST_COMMIT)
 
 /*
  * Journal flag definitions
-- 
2.23.0.444.g18eeb5a265-goog

