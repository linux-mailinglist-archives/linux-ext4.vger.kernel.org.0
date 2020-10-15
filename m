Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 249AF28FA2E
	for <lists+linux-ext4@lfdr.de>; Thu, 15 Oct 2020 22:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387948AbgJOUiO (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 15 Oct 2020 16:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729735AbgJOUiM (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 15 Oct 2020 16:38:12 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1BD7C061755
        for <linux-ext4@vger.kernel.org>; Thu, 15 Oct 2020 13:38:12 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id y1so8696plp.6
        for <linux-ext4@vger.kernel.org>; Thu, 15 Oct 2020 13:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YZxciC56O0h0poh3C/gwiir1XMwrML4XJ6gRuhDOcbY=;
        b=tcVnz3WtvGaCMv4ymLwKoMPi47TiDPSihlFnecfUxYJyymtCPd7hek8GQEYvJpyXg3
         zoz5byCsrDuGuquZrUM0HGc1JqKoxRf4IeWQNyVnQcCk3FORXIHcDwU3IjuN9wPiBXfk
         l2TfqTAGZDI58OWrbvfP4FNh68gv24AF4faDrap6CCdLRHQp+VV7Cum2d5EA0FkTWN2W
         qr1zDtsOYexdAihBVLq2RX5OvGqDURM6OFr3PnrUX9DKoMrXA/8dlPaqsSFVTr8rs5X8
         HuxQDDs8ouczxPAQB0ZI9VuwPw6Q+kw+0czcH5GOIsr2G6mBDciU6Dciqyb7i1pjkO9l
         BQRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YZxciC56O0h0poh3C/gwiir1XMwrML4XJ6gRuhDOcbY=;
        b=MyEGfml6N+eicEQ0QeE3tWQ+glWcZJjcVb2kl4kToa98celr6lo/KCzlPHqxYBMtYV
         ++hDtKiHROK2Af+HRw58GfZQnVq6qQDgtn3tk3uNdhRkjaURR/jhaZmz4zgxOhhLFC/E
         yP2+i7GpY3+Gij/yzvN/gqWej460Ww9A/SaBrtSiRXfH9TpwpBk58xUALP0F2NPaDTH3
         CthAUmjGtjHeAiUbQzWfW8C9f9QXEynTZdsyq3Vcv7on9aE5kgLQzURZNTAN4lm9B6jA
         Ex6uUykQBN+bJFg7QPJYWtGkst1nohG1JRHijCL2i274jmcvxIzehcjYwVY4yRRluC0V
         yDLw==
X-Gm-Message-State: AOAM533A6+s91tWmjyEnvjZruZUlr1vmv9dnHqcM41BMTVmX50pxpbpe
        X47jTLcDILrTsC0cYWAxXU8bjO0WQMk=
X-Google-Smtp-Source: ABdhPJyFUhzkGk4BQjVCuevqxijUg7gVmSidjHp0kA8UWLTkijWXBZ89Ongl27Pi51IsxsYA7xfXyA==
X-Received: by 2002:a17:90a:65cc:: with SMTP id i12mr454437pjs.193.1602794291909;
        Thu, 15 Oct 2020 13:38:11 -0700 (PDT)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:a6ae:11ff:fe11:86a2])
        by smtp.googlemail.com with ESMTPSA id j8sm136860pfr.121.2020.10.15.13.38.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2020 13:38:11 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v10 2/9] ext4: add fast_commit feature and handling for extended mount options
Date:   Thu, 15 Oct 2020 13:37:54 -0700
Message-Id: <20201015203802.3597742-3-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
In-Reply-To: <20201015203802.3597742-1-harshadshirwadkar@gmail.com>
References: <20201015203802.3597742-1-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

We are running out of mount option bits. Add handling for using
s_mount_opt2. Add ext4 and jbd2 fast commit feature flag and also add
ability to turn off the fast commit feature in Ext4.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 fs/ext4/ext4.h       |  4 ++++
 fs/ext4/super.c      | 27 ++++++++++++++++++++++-----
 include/linux/jbd2.h |  5 ++++-
 3 files changed, 30 insertions(+), 6 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 1879531a119f..02d7dc378505 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1213,6 +1213,8 @@ struct ext4_inode_info {
 #define EXT4_MOUNT2_EXPLICIT_JOURNAL_CHECKSUM	0x00000008 /* User explicitly
 						specified journal checksum */
 
+#define EXT4_MOUNT2_JOURNAL_FAST_COMMIT	0x00000010 /* Journal fast commit */
+
 #define clear_opt(sb, opt)		EXT4_SB(sb)->s_mount_opt &= \
 						~EXT4_MOUNT_##opt
 #define set_opt(sb, opt)		EXT4_SB(sb)->s_mount_opt |= \
@@ -1813,6 +1815,7 @@ static inline bool ext4_verity_in_progress(struct inode *inode)
 #define EXT4_FEATURE_COMPAT_RESIZE_INODE	0x0010
 #define EXT4_FEATURE_COMPAT_DIR_INDEX		0x0020
 #define EXT4_FEATURE_COMPAT_SPARSE_SUPER2	0x0200
+#define EXT4_FEATURE_COMPAT_FAST_COMMIT		0x0400
 #define EXT4_FEATURE_COMPAT_STABLE_INODES	0x0800
 
 #define EXT4_FEATURE_RO_COMPAT_SPARSE_SUPER	0x0001
@@ -1915,6 +1918,7 @@ EXT4_FEATURE_COMPAT_FUNCS(xattr,		EXT_ATTR)
 EXT4_FEATURE_COMPAT_FUNCS(resize_inode,		RESIZE_INODE)
 EXT4_FEATURE_COMPAT_FUNCS(dir_index,		DIR_INDEX)
 EXT4_FEATURE_COMPAT_FUNCS(sparse_super2,	SPARSE_SUPER2)
+EXT4_FEATURE_COMPAT_FUNCS(fast_commit,		FAST_COMMIT)
 EXT4_FEATURE_COMPAT_FUNCS(stable_inodes,	STABLE_INODES)
 
 EXT4_FEATURE_RO_COMPAT_FUNCS(sparse_super,	SPARSE_SUPER)
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 901c1c938276..70256a240442 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1709,7 +1709,7 @@ enum {
 	Opt_dioread_nolock, Opt_dioread_lock,
 	Opt_discard, Opt_nodiscard, Opt_init_itable, Opt_noinit_itable,
 	Opt_max_dir_size_kb, Opt_nojournal_checksum, Opt_nombcache,
-	Opt_prefetch_block_bitmaps,
+	Opt_prefetch_block_bitmaps, Opt_no_fc,
 };
 
 static const match_table_t tokens = {
@@ -1796,6 +1796,7 @@ static const match_table_t tokens = {
 	{Opt_init_itable, "init_itable=%u"},
 	{Opt_init_itable, "init_itable"},
 	{Opt_noinit_itable, "noinit_itable"},
+	{Opt_no_fc, "no_fc"},
 	{Opt_max_dir_size_kb, "max_dir_size_kb=%u"},
 	{Opt_test_dummy_encryption, "test_dummy_encryption=%s"},
 	{Opt_test_dummy_encryption, "test_dummy_encryption"},
@@ -1922,6 +1923,7 @@ static int clear_qf_name(struct super_block *sb, int qtype)
 #define MOPT_EXT4_ONLY	(MOPT_NO_EXT2 | MOPT_NO_EXT3)
 #define MOPT_STRING	0x0400
 #define MOPT_SKIP	0x0800
+#define	MOPT_2		0x1000
 
 static const struct mount_opts {
 	int	token;
@@ -2022,6 +2024,8 @@ static const struct mount_opts {
 	{Opt_nombcache, EXT4_MOUNT_NO_MBCACHE, MOPT_SET},
 	{Opt_prefetch_block_bitmaps, EXT4_MOUNT_PREFETCH_BLOCK_BITMAPS,
 	 MOPT_SET},
+	{Opt_no_fc, EXT4_MOUNT2_JOURNAL_FAST_COMMIT,
+	 MOPT_CLEAR | MOPT_2 | MOPT_EXT4_ONLY},
 	{Opt_err, 0, 0}
 };
 
@@ -2398,10 +2402,17 @@ static int handle_mount_opt(struct super_block *sb, char *opt, int token,
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
@@ -2618,6 +2629,9 @@ static int _ext4_show_options(struct seq_file *seq, struct super_block *sb,
 		SEQ_OPTS_PUTS("dax=inode");
 	}
 
+	if (test_opt2(sb, JOURNAL_FAST_COMMIT))
+		SEQ_OPTS_PUTS("fast_commit");
+
 	ext4_show_quota_options(seq, sb);
 	return 0;
 }
@@ -4121,6 +4135,8 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 #ifdef CONFIG_EXT4_FS_POSIX_ACL
 	set_opt(sb, POSIX_ACL);
 #endif
+	if (ext4_has_feature_fast_commit(sb))
+		set_opt2(sb, JOURNAL_FAST_COMMIT);
 	/* don't forget to enable journal_csum when metadata_csum is enabled. */
 	if (ext4_has_metadata_csum(sb))
 		set_opt(sb, JOURNAL_CHECKSUM);
@@ -4777,6 +4793,7 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 		sbi->s_def_mount_opt &= ~EXT4_MOUNT_JOURNAL_CHECKSUM;
 		clear_opt(sb, JOURNAL_CHECKSUM);
 		clear_opt(sb, DATA_FLAGS);
+		clear_opt2(sb, JOURNAL_FAST_COMMIT);
 		sbi->s_journal = NULL;
 		needs_recovery = 0;
 		goto no_journal;
diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index 04afa6dcd60d..0685cc95e501 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -289,6 +289,7 @@ typedef struct journal_superblock_s
 #define JBD2_FEATURE_INCOMPAT_ASYNC_COMMIT	0x00000004
 #define JBD2_FEATURE_INCOMPAT_CSUM_V2		0x00000008
 #define JBD2_FEATURE_INCOMPAT_CSUM_V3		0x00000010
+#define JBD2_FEATURE_INCOMPAT_FAST_COMMIT	0x00000020
 
 /* See "journal feature predicate functions" below */
 
@@ -299,7 +300,8 @@ typedef struct journal_superblock_s
 					JBD2_FEATURE_INCOMPAT_64BIT | \
 					JBD2_FEATURE_INCOMPAT_ASYNC_COMMIT | \
 					JBD2_FEATURE_INCOMPAT_CSUM_V2 | \
-					JBD2_FEATURE_INCOMPAT_CSUM_V3)
+					JBD2_FEATURE_INCOMPAT_CSUM_V3 | \
+					JBD2_FEATURE_INCOMPAT_FAST_COMMIT)
 
 #ifdef __KERNEL__
 
@@ -1263,6 +1265,7 @@ JBD2_FEATURE_INCOMPAT_FUNCS(64bit,		64BIT)
 JBD2_FEATURE_INCOMPAT_FUNCS(async_commit,	ASYNC_COMMIT)
 JBD2_FEATURE_INCOMPAT_FUNCS(csum2,		CSUM_V2)
 JBD2_FEATURE_INCOMPAT_FUNCS(csum3,		CSUM_V3)
+JBD2_FEATURE_INCOMPAT_FUNCS(fast_commit,	FAST_COMMIT)
 
 /*
  * Journal flag definitions
-- 
2.29.0.rc1.297.gfa9743e501-goog

