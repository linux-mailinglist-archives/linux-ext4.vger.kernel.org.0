Return-Path: <linux-ext4+bounces-10226-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83B23B7F922
	for <lists+linux-ext4@lfdr.de>; Wed, 17 Sep 2025 15:51:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6ED52A2EE6
	for <lists+linux-ext4@lfdr.de>; Wed, 17 Sep 2025 03:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1C2D2F6598;
	Wed, 17 Sep 2025 03:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="lSFTwld9"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9FB2F39B1
	for <linux-ext4@vger.kernel.org>; Wed, 17 Sep 2025 03:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758079711; cv=none; b=J2IgAo4ypITQH2HFZRBfL7Cy2QYkECMg7Sg5yflJl4BhHoKRLVT4O+PJffycVsKkAdsTsx9WnGEdZwAvnwelFvorB4/aC/X5jText+YI4G7b66s7XWXrEaP1ZbQFhypnzDxe2vCy8q23GirNm8gIVjBLvn/rSzlladDHNJGx55A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758079711; c=relaxed/simple;
	bh=RPTd0ERlNiIc95UXZ2z73x4/FDQRflu2+rBPdht4ERA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=leb9sTBg7tQGlzqzWlzGNCTpFH5WXZa9l4luKpc9CsUwdcKW1JI9YpoHatSWKadG38l6zwFghbXrTRNgkM2fKJ0RkadfJU1pfwyzwM7CFpsHwzYJgx9os3h03qeej+5k4JGXAHTc1Gy/LNIapLjrur5jX47EGYuNLcJtQ6GEIFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=lSFTwld9; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-116-225.bstnma.fios.verizon.net [173.48.116.225])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 58H3SJ0q001497
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Sep 2025 23:28:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1758079700; bh=LbCxAZQM/Q4ypQNQiBtXRh7xRPsBr0yTMkAZAVm0DZ0=;
	h=From:Subject:Date:Message-ID:MIME-Version;
	b=lSFTwld9V4ZpEeDVx+PRA2hfehWZY94xyT55QTNJqiWoYTiAjgD1TgzndYi02HlFW
	 mdnJ656bBVTDjFcf2Xkw7wn33bUsNOr8W2kJdQrhM11bny2lLROh63psomWG5jth+t
	 8SORkOHk6viSSBkAGaKNTKizEzXOnhT1Cy4hNppFvhBZkPpqd1W6P//u4LHD3p7Z/X
	 i2DiOiyIBm0QaQuQLMskxMYi+rtS1H9aFTSuuXsx80Ia3YLQWmgXk2K3x1sYmihbp3
	 aBg+j25vG/VZZxXwjYOho7E0y2bw5sQip8CoKmgcIYJyboHn9Icyj0F9lEMnLtUPA7
	 A+nQYGcXTgl4w==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 368F12E00D7; Tue, 16 Sep 2025 23:28:19 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: Ext4 Developers List <linux-ext4@vger.kernel.org>
Cc: "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH 1/3] tune2fs: reorganize command-line flag handling
Date: Tue, 16 Sep 2025 23:28:12 -0400
Message-ID: <20250917032814.395887-2-tytso@mit.edu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250917032814.395887-1-tytso@mit.edu>
References: <20250917032814.395887-1-tytso@mit.edu>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of using individual ad-hoc variables indicating whether a
particular superblock value has been requested to be changed (e.g.,
c_flag, C_flag, et.al) use an array of booleans with indexes that are
defined with more human-readable #define's (e.g., OPT_MAX_MOUNTCOUNT).

There should be no behavioral changes from this code restructuring.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 misc/tune2fs.c | 212 +++++++++++++++++++++++++++----------------------
 1 file changed, 117 insertions(+), 95 deletions(-)

diff --git a/misc/tune2fs.c b/misc/tune2fs.c
index 3db57632..1b3716e1 100644
--- a/misc/tune2fs.c
+++ b/misc/tune2fs.c
@@ -103,16 +103,37 @@ struct fsuuid {
 
 extern int ask_yn(const char *string, int def);
 
+#define OPT_MAX_MOUNTCOUNT	 1
+#define OPT_MOUNTCOUNT		 2
+#define OPT_CHECKINTERVAL	 3
+#define OPT_CHECKTIME		 4
+#define OPT_ERROR_BEHAVIOR	 5
+#define OPT_RESUID		 6
+#define OPT_RESGID		 7
+#define OPT_RESERVED_BLOCKS	 8
+#define OPT_RESERVED_RATIO	 9
+#define OPT_INODE_SIZE	 	10
+#define OPT_LABEL		11
+#define OPT_PRINT_LABEL		12
+#define OPT_UUID		13
+#define OPT_LAST_MOUNTED	14
+#define OPT_SPARSE_SUPER	15
+#define OPT_QUOTA		16
+#define OPT_JOURNAL_SIZE	17
+#define OPT_JOURNAL_OPTS	18
+#define OPT_MNTOPTS		19
+#define OPT_FEATURES		20
+#define OPT_EXTENDED_CMD	21
+#define MAX_OPTS		22
+static bool opts[MAX_OPTS];
+
 const char *program_name = "tune2fs";
 char *device_name;
 char *new_label, *new_last_mounted, *requested_uuid;
 char *io_options;
-static int c_flag, C_flag, e_flag, f_flag, g_flag, i_flag, l_flag, L_flag;
-static int m_flag, M_flag, Q_flag, r_flag, s_flag = -1, u_flag, U_flag, T_flag;
-static int I_flag;
+static int force, do_list_super, sparse_value = -1;
 static int clear_mmp;
 static time_t last_check_time;
-static int print_label;
 static int max_mount_count, mount_count, mount_flags;
 static unsigned long interval;
 static blk64_t reserved_blocks;
@@ -237,6 +258,19 @@ static __u32 clear_ok_features[3] = {
 		EXT4_FEATURE_RO_COMPAT_READONLY
 };
 
+/**
+ * Return true if there is at least one superblock change requested
+ */
+static bool tune_opts_requested()
+{
+	int	i;
+
+	for (i = 0; i < MAX_OPTS; i++)
+		if (opts[i])
+			return true;
+	return false;
+}
+
 /**
  * Try to get journal super block if any
  */
@@ -293,7 +327,7 @@ static int remove_journal_device(ext2_filsys fs)
 	int		commit_remove_journal = 0;
 	io_manager	io_ptr;
 
-	if (f_flag)
+	if (force)
 		commit_remove_journal = 1; /* force removal even if error */
 
 	uuid_unparse(fs->super->s_journal_uuid, buf);
@@ -1204,7 +1238,7 @@ static int update_feature_set(ext2_filsys fs, char *features)
 			return 1;
 		}
 		if (ext2fs_has_feature_journal_needs_recovery(sb) &&
-		    f_flag < 2) {
+		    force < 2) {
 			fputs(_("The needs_recovery flag is set.  "
 				"Please run e2fsck before clearing\n"
 				"the has_journal flag.\n"), stderr);
@@ -1228,7 +1262,7 @@ static int update_feature_set(ext2_filsys fs, char *features)
 				"when the filesystem is unmounted.\n"), stderr);
 			return 1;
 		}
-		if (ext2fs_has_feature_orphan_present(sb) && f_flag < 2) {
+		if (ext2fs_has_feature_orphan_present(sb) && force < 2) {
 			fputs(_("The orphan_present feature is set. Please "
 				"run e2fsck before clearing orphan_file "
 				"feature.\n"),
@@ -1551,8 +1585,8 @@ mmp_error:
 		 * Set the Q_flag here and handle the quota options in the code
 		 * below.
 		 */
-		if (!Q_flag) {
-			Q_flag = 1;
+		if (!opts[OPT_QUOTA]) {
+			opts[OPT_QUOTA] = 1;
 			/* Enable usr/grp quota by default */
 			for (qtype = 0; qtype < MAXQUOTAS; qtype++) {
 				if (qtype != PRJQUOTA)
@@ -1571,26 +1605,26 @@ mmp_error:
 					  "inode size too small.\n"));
 			return 1;
 		}
-		Q_flag = 1;
+		opts[OPT_QUOTA] = true;
 		quota_enable[PRJQUOTA] = QOPT_ENABLE;
 	}
 
 	if (FEATURE_OFF(E2P_FEATURE_RO_INCOMPAT,
 			EXT4_FEATURE_RO_COMPAT_PROJECT)) {
-		Q_flag = 1;
+		opts[OPT_QUOTA] = true;
 		quota_enable[PRJQUOTA] = QOPT_DISABLE;
 	}
 
 	if (FEATURE_OFF(E2P_FEATURE_RO_INCOMPAT,
 				EXT4_FEATURE_RO_COMPAT_QUOTA)) {
 		/*
-		 * Set the Q_flag here and handle the quota options in the code
-		 * below.
+		 * Set the quota flag here and handle the quota
+		 * options in the code below.
 		 */
-		if (Q_flag)
+		if (opts[OPT_QUOTA])
 			fputs(_("\nWarning: '^quota' option overrides '-Q'"
 				"arguments.\n"), stderr);
-		Q_flag = 1;
+	        opts[OPT_QUOTA] = true;
 		/* Disable all quota by default */
 		for (qtype = 0; qtype < MAXQUOTAS; qtype++)
 			quota_enable[qtype] = QOPT_DISABLE;
@@ -1940,10 +1974,10 @@ static void parse_e2label_options(int argc, char ** argv)
 	open_flag = EXT2_FLAG_JOURNAL_DEV_OK | EXT2_FLAG_SUPER_ONLY;
 	if (argc == 3) {
 		open_flag |= EXT2_FLAG_RW;
-		L_flag = 1;
+		opts[OPT_LABEL] = true;
 		new_label = argv[2];
 	} else
-		print_label++;
+		opts[OPT_PRINT_LABEL] = true;
 }
 
 static time_t parse_time(char *str)
@@ -1990,8 +2024,7 @@ static void parse_tune2fs_options(int argc, char **argv)
 	while ((c = getopt(argc, argv, optstring)) != EOF)
 		switch (c) {
 		case 'c':
-			open_flag = EXT2_FLAG_RW;
-			c_flag = 1;
+			opts[OPT_MAX_MOUNTCOUNT] = true;
 			if (strcmp(optarg, "random") == 0) {
 				max_mount_count = 65536;
 				break;
@@ -2008,6 +2041,7 @@ static void parse_tune2fs_options(int argc, char **argv)
 				max_mount_count = -1;
 			break;
 		case 'C':
+			opts[OPT_MOUNTCOUNT] = true;
 			mount_count = strtoul(optarg, &tmp, 0);
 			if (*tmp || mount_count > 16000) {
 				com_err(program_name, 0,
@@ -2015,10 +2049,9 @@ static void parse_tune2fs_options(int argc, char **argv)
 					optarg);
 				usage();
 			}
-			C_flag = 1;
-			open_flag = EXT2_FLAG_RW;
 			break;
 		case 'e':
+			opts[OPT_ERROR_BEHAVIOR] = true;
 			if (strcmp(optarg, "continue") == 0)
 				errors = EXT2_ERRORS_CONTINUE;
 			else if (strcmp(optarg, "remount-ro") == 0)
@@ -2031,17 +2064,16 @@ static void parse_tune2fs_options(int argc, char **argv)
 					optarg);
 				usage();
 			}
-			e_flag = 1;
-			open_flag = EXT2_FLAG_RW;
 			break;
 		case 'E':
+			opts[OPT_EXTENDED_CMD] = true;
 			extended_cmd = optarg;
-			open_flag |= EXT2_FLAG_RW;
 			break;
 		case 'f': /* Force */
-			f_flag++;
+			force++;
 			break;
 		case 'g':
+			opts[OPT_RESGID] = true;
 			resgid = strtoul(optarg, &tmp, 0);
 			if (*tmp) {
 				gr = getgrnam(optarg);
@@ -2058,10 +2090,9 @@ static void parse_tune2fs_options(int argc, char **argv)
 					optarg);
 				usage();
 			}
-			g_flag = 1;
-			open_flag = EXT2_FLAG_RW;
 			break;
 		case 'i':
+			opts[OPT_CHECKINTERVAL] = 1;
 			interval = strtoul(optarg, &tmp, 0);
 			switch (*tmp) {
 			case 's':
@@ -2090,28 +2121,25 @@ static void parse_tune2fs_options(int argc, char **argv)
 					_("bad interval - %s"), optarg);
 				usage();
 			}
-			i_flag = 1;
-			open_flag = EXT2_FLAG_RW;
 			break;
 		case 'j':
+			opts[OPT_JOURNAL_SIZE] = true;
 			if (!journal_size)
 				journal_size = -1;
-			open_flag = EXT2_FLAG_RW;
 			break;
 		case 'J':
+			opts[OPT_JOURNAL_OPTS] = true;
 			parse_journal_opts(optarg);
-			open_flag = EXT2_FLAG_RW;
 			break;
 		case 'l':
-			l_flag = 1;
+			do_list_super = 1;
 			break;
 		case 'L':
+			opts[OPT_LABEL] = true;
 			new_label = optarg;
-			L_flag = 1;
-			open_flag |= EXT2_FLAG_RW |
-				EXT2_FLAG_JOURNAL_DEV_OK;
 			break;
 		case 'm':
+			opts[OPT_RESERVED_RATIO] = true;
 			reserved_ratio = strtod(optarg, &tmp);
 			if (*tmp || reserved_ratio > 50 ||
 			    reserved_ratio < 0) {
@@ -2120,40 +2148,37 @@ static void parse_tune2fs_options(int argc, char **argv)
 					optarg);
 				usage();
 			}
-			m_flag = 1;
-			open_flag = EXT2_FLAG_RW;
 			break;
 		case 'M':
+			opts[OPT_LAST_MOUNTED] = true;
 			new_last_mounted = optarg;
-			M_flag = 1;
-			open_flag = EXT2_FLAG_RW;
 			break;
 		case 'o':
+			opts[OPT_MNTOPTS] = true;
 			if (mntopts_cmd) {
 				com_err(program_name, 0, "%s",
 					_("-o may only be specified once"));
 				usage();
 			}
 			mntopts_cmd = optarg;
-			open_flag = EXT2_FLAG_RW;
 			break;
 		case 'O':
+			opts[OPT_FEATURES] = true;
 			if (features_cmd) {
 				com_err(program_name, 0, "%s",
 					_("-O may only be specified once"));
 				usage();
 			}
 			features_cmd = optarg;
-			open_flag = EXT2_FLAG_RW;
 			break;
 		case 'Q':
-			Q_flag = 1;
+			opts[OPT_QUOTA] = true;
 			ret = parse_quota_opts(optarg, option_handle_function);
 			if (ret)
 				exit(1);
-			open_flag = EXT2_FLAG_RW;
 			break;
 		case 'r':
+			opts[OPT_RESERVED_BLOCKS] = true;
 			reserved_blocks = strtoul(optarg, &tmp, 0);
 			if (*tmp) {
 				com_err(program_name, 0,
@@ -2161,45 +2186,39 @@ static void parse_tune2fs_options(int argc, char **argv)
 					optarg);
 				usage();
 			}
-			r_flag = 1;
-			open_flag = EXT2_FLAG_RW;
 			break;
 		case 's': /* Deprecated */
-			s_flag = atoi(optarg);
-			open_flag = EXT2_FLAG_RW;
+			opts[OPT_SPARSE_SUPER] = true;
+			sparse_value = atoi(optarg);
 			break;
 		case 'T':
-			T_flag = 1;
+			opts[OPT_CHECKTIME] = true;
 			last_check_time = parse_time(optarg);
-			open_flag = EXT2_FLAG_RW;
 			break;
 		case 'u':
-				resuid = strtoul(optarg, &tmp, 0);
-				if (*tmp) {
-					pw = getpwnam(optarg);
-					if (pw == NULL)
-						tmp = optarg;
-					else {
-						resuid = pw->pw_uid;
-						*tmp = 0;
-					}
+			opts[OPT_RESUID] = true;
+			resuid = strtoul(optarg, &tmp, 0);
+			if (*tmp) {
+				pw = getpwnam(optarg);
+				if (pw == NULL)
+					tmp = optarg;
+				else {
+					resuid = pw->pw_uid;
+					*tmp = 0;
 				}
-				if (*tmp) {
-					com_err(program_name, 0,
-						_("bad uid/user name - %s"),
-						optarg);
+			}
+			if (*tmp) {
+				com_err(program_name, 0,
+					_("bad uid/user name - %s"), optarg);
 					usage();
-				}
-				u_flag = 1;
-				open_flag = EXT2_FLAG_RW;
-				break;
+			}
+			break;
 		case 'U':
+			opts[OPT_UUID] = true;
 			requested_uuid = optarg;
-			U_flag = 1;
-			open_flag = EXT2_FLAG_RW |
-				EXT2_FLAG_JOURNAL_DEV_OK;
 			break;
 		case 'I':
+			opts[OPT_INODE_SIZE] = true;
 			new_inode_size = strtoul(optarg, &tmp, 0);
 			if (*tmp) {
 				com_err(program_name, 0,
@@ -2215,8 +2234,6 @@ static void parse_tune2fs_options(int argc, char **argv)
 					optarg);
 				usage();
 			}
-			open_flag = EXT2_FLAG_RW;
-			I_flag = 1;
 			break;
 		case 'z':
 			undo_file = optarg;
@@ -2226,8 +2243,13 @@ static void parse_tune2fs_options(int argc, char **argv)
 		}
 	if (optind < argc - 1 || optind == argc)
 		usage();
-	if (!open_flag && !l_flag)
+	if (tune_opts_requested()) {
+		open_flag = EXT2_FLAG_RW;
+		if (opts[OPT_LABEL] || opts[OPT_UUID])
+			open_flag |= EXT2_FLAG_JOURNAL_DEV_OK;
+	} else {
 		usage();
+	}
 	io_options = strchr(argv[optind], '?');
 	if (io_options)
 		*io_options++ = 0;
@@ -3221,8 +3243,8 @@ int tune2fs_main(int argc, char **argv)
 	 * Try the get/set fs label using ioctls before we even attempt
 	 * to open the file system.
 	 */
-	if (L_flag || print_label) {
-		rc = handle_fslabel(L_flag);
+	if (opts[OPT_LABEL] || opts[OPT_PRINT_LABEL]) {
+		rc = handle_fslabel(opts[OPT_LABEL]);
 		if (rc != -1) {
 #ifndef BUILD_AS_LIB
 			exit(rc);
@@ -3233,7 +3255,7 @@ int tune2fs_main(int argc, char **argv)
 	}
 
 retry_open:
-	if ((open_flag & EXT2_FLAG_RW) == 0 || f_flag)
+	if ((open_flag & EXT2_FLAG_RW) == 0 || force)
 		open_flag |= EXT2_FLAG_SKIP_MMP;
 
 	open_flag |= EXT2_FLAG_64BITS | EXT2_FLAG_THREADS |
@@ -3276,7 +3298,7 @@ retry_open:
 	}
 	fs->default_bitmap_type = EXT2FS_BMAP64_RBTREE;
 
-	if (I_flag) {
+	if (opts[OPT_INODE_SIZE]) {
 		/*
 		 * Check the inode size is right so we can issue an
 		 * error message and bail before setting up the tdb
@@ -3328,7 +3350,7 @@ retry_open:
 	sb = fs->super;
 	fs->flags &= ~EXT2_FLAG_MASTER_SB_ONLY;
 
-	if (print_label) {
+	if (opts[OPT_PRINT_LABEL]) {
 		/* For e2label emulation */
 		printf("%.*s\n", EXT2_LEN_STR(sb->s_volume_name));
 		remove_error_table(&et_ext2_error_table);
@@ -3378,7 +3400,7 @@ _("Warning: The journal is dirty. You may wish to replay the journal like:\n\n"
 	/* Normally we only need to write out the superblock */
 	fs->flags |= EXT2_FLAG_SUPER_ONLY;
 
-	if (c_flag) {
+	if (opts[OPT_MAX_MOUNTCOUNT]) {
 		if (max_mount_count == 65536)
 			max_mount_count = EXT2_DFL_MAX_MNT_COUNT +
 				(random() % EXT2_DFL_MAX_MNT_COUNT);
@@ -3387,17 +3409,17 @@ _("Warning: The journal is dirty. You may wish to replay the journal like:\n\n"
 		printf(_("Setting maximal mount count to %d\n"),
 		       max_mount_count);
 	}
-	if (C_flag) {
+	if (opts[OPT_MOUNTCOUNT]) {
 		sb->s_mnt_count = mount_count;
 		ext2fs_mark_super_dirty(fs);
 		printf(_("Setting current mount count to %d\n"), mount_count);
 	}
-	if (e_flag) {
+	if (opts[OPT_ERROR_BEHAVIOR]) {
 		sb->s_errors = errors;
 		ext2fs_mark_super_dirty(fs);
 		printf(_("Setting error behavior to %d\n"), errors);
 	}
-	if (g_flag) {
+	if (opts[OPT_RESGID]) {
 		if (sb->s_def_resgid != resgid) {
 			sb->s_def_resgid = resgid;
 			ext2fs_mark_super_dirty(fs);
@@ -3406,7 +3428,7 @@ _("Warning: The journal is dirty. You may wish to replay the journal like:\n\n"
 			printf(_("Reserved blocks gid already set to %lu\n"), resgid);
 		}
 	}
-	if (i_flag) {
+	if (opts[OPT_CHECKINTERVAL]) {
 		if ((unsigned long long)interval >= (1ULL << 32)) {
 			com_err(program_name, 0,
 				_("interval between checks is too big (%lu)"),
@@ -3419,7 +3441,7 @@ _("Warning: The journal is dirty. You may wish to replay the journal like:\n\n"
 		printf(_("Setting interval between checks to %lu seconds\n"),
 		       interval);
 	}
-	if (m_flag) {
+	if (opts[OPT_RESERVED_RATIO]) {
 		ext2fs_r_blocks_count_set(sb, reserved_ratio *
 					  ext2fs_blocks_count(sb) / 100.0);
 		ext2fs_mark_super_dirty(fs);
@@ -3427,7 +3449,7 @@ _("Warning: The journal is dirty. You may wish to replay the journal like:\n\n"
 			reserved_ratio,
 			(unsigned long long) ext2fs_r_blocks_count(sb));
 	}
-	if (r_flag) {
+	if (opts[OPT_RESERVED_BLOCKS]) {
 		if (reserved_blocks > ext2fs_blocks_count(sb)/2) {
 			com_err(program_name, 0,
 				_("reserved blocks count is too big (%llu)"),
@@ -3440,7 +3462,7 @@ _("Warning: The journal is dirty. You may wish to replay the journal like:\n\n"
 		printf(_("Setting reserved blocks count to %llu\n"),
 		       (unsigned long long) reserved_blocks);
 	}
-	if (s_flag == 1) {
+	if (sparse_value == 1) {
 		if (ext2fs_has_feature_sparse_super(sb)) {
 			fputs(_("\nThe filesystem already has sparse "
 				"superblocks.\n"), stderr);
@@ -3459,24 +3481,24 @@ _("Warning: The journal is dirty. You may wish to replay the journal like:\n\n"
 			       _(please_fsck));
 		}
 	}
-	if (s_flag == 0) {
+	if (sparse_value == 0) {
 		fputs(_("\nClearing the sparse superblock flag not supported.\n"),
 		      stderr);
 		rc = 1;
 		goto closefs;
 	}
-	if (T_flag) {
+	if (opts[OPT_CHECKTIME]) {
 		ext2fs_set_tstamp(sb, s_lastcheck, last_check_time);
 		ext2fs_mark_super_dirty(fs);
 		printf(_("Setting time filesystem last checked to %s\n"),
 		       ctime(&last_check_time));
 	}
-	if (u_flag) {
+	if (opts[OPT_RESUID]) {
 		sb->s_def_resuid = resuid;
 		ext2fs_mark_super_dirty(fs);
 		printf(_("Setting reserved blocks uid to %lu\n"), resuid);
 	}
-	if (L_flag) {
+	if (opts[OPT_LABEL]) {
 		if (strlen(new_label) > sizeof(sb->s_volume_name))
 			fputs(_("Warning: label too long, truncating.\n"),
 			      stderr);
@@ -3485,7 +3507,7 @@ _("Warning: The journal is dirty. You may wish to replay the journal like:\n\n"
 			sizeof(sb->s_volume_name));
 		ext2fs_mark_super_dirty(fs);
 	}
-	if (M_flag) {
+	if (opts[OPT_LAST_MOUNTED]) {
 		memset(sb->s_last_mounted, 0, sizeof(sb->s_last_mounted));
 		strncpy((char *)sb->s_last_mounted, new_last_mounted,
 			sizeof(sb->s_last_mounted));
@@ -3505,7 +3527,7 @@ _("Warning: The journal is dirty. You may wish to replay the journal like:\n\n"
 		rc = parse_extended_opts(fs, extended_cmd);
 		if (rc)
 			goto closefs;
-		if (clear_mmp && !f_flag) {
+		if (clear_mmp && !force) {
 			fputs(_("Error in using clear_mmp. "
 				"It must be used with -f\n"),
 			      stderr);
@@ -3541,7 +3563,7 @@ _("Warning: The journal is dirty. You may wish to replay the journal like:\n\n"
 		}
 	}
 
-	if (Q_flag) {
+	if (opts[OPT_QUOTA]) {
 		if (mount_flags & (EXT2_MF_BUSY | EXT2_MF_MOUNTED)) {
 			fputs(_("The quota feature may only be changed when "
 				"the filesystem is unmounted and not in use.\n"), stderr);
@@ -3553,7 +3575,7 @@ _("Warning: The journal is dirty. You may wish to replay the journal like:\n\n"
 			goto closefs;
 	}
 
-	if (U_flag) {
+	if (opts[OPT_UUID]) {
 		int set_csum = 0;
 		dgrp_t i;
 		char buf[SUPERBLOCK_SIZE] __attribute__ ((aligned(8)));
@@ -3694,7 +3716,7 @@ _("Warning: The journal is dirty. You may wish to replay the journal like:\n\n"
 		}
 	}
 
-	if (I_flag) {
+	if (opts[OPT_INODE_SIZE]) {
 		if (mount_flags & (EXT2_MF_BUSY | EXT2_MF_MOUNTED)) {
 			fputs(_("The inode size may only be "
 				"changed when the filesystem is "
@@ -3740,7 +3762,7 @@ _("Warning: The journal is dirty. You may wish to replay the journal like:\n\n"
 		}
 	}
 
-	if (l_flag)
+	if (do_list_super)
 		list_super(sb);
 	if (stride_set) {
 		sb->s_raid_stride = stride;
-- 
2.51.0


