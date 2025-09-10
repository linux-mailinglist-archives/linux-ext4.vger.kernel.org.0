Return-Path: <linux-ext4+bounces-9903-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE5CBB51B15
	for <lists+linux-ext4@lfdr.de>; Wed, 10 Sep 2025 17:12:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 185F8A07173
	for <lists+linux-ext4@lfdr.de>; Wed, 10 Sep 2025 15:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D49FC289358;
	Wed, 10 Sep 2025 15:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="Hj5xnGQ7"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3CA823E355
	for <linux-ext4@vger.kernel.org>; Wed, 10 Sep 2025 15:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757516440; cv=none; b=HqU/1ujr9QFGoQ9VBhjxzBBxsXuWoy/8ERBaIzoIBQg6dkOzT1WajTDD5JR/hiENAHIEStPdPp2xgQtBq+agW+OJPID/1u7oaFoI4CmkzzD9J/mytBTFydH6pOhA7FBEEtpnsnxqsdiFQetnceRy+GERHxAmhUwibe1Y3oItPQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757516440; c=relaxed/simple;
	bh=IOqWuGHHemvSh52rr+KssYMBVLPQkGGWpxLg+ZLwDHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fJht5seqhXlRv9VYH9gGRx43Z7txnTXv86N1PFUoOe9LhVEjPeNEVwvr1MS/JIHONauhjnrmx7DwzdG3UuYT5DzyQ762QWHGezeC1qu+0O9MMGnNl9r2Lr79hFr3ceLtZ6qTS+6gkJ6Pd44gDvBmFt8AEcT9NENbStSAan5+I3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=Hj5xnGQ7; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-111-2.bstnma.fios.verizon.net [173.48.111.2])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 58AF0StL020223
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Sep 2025 11:00:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1757516430; bh=3wk16UUe9/ZZQNNKaYtkqHG3OapzlAvhhsKtpg4zBhQ=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=Hj5xnGQ7eR2FhTHmm6yuA7Ojx24SW7KGfeIuzhL81L6ow3/fj4xSaUIL0DXntL4kF
	 Mb76buE28Qi+yPbwQwr9Hi3ftPnR9Fv/vmPdcD1DOtzUmYIPSDAaNO4sFHfR699LxW
	 XdyzRTkmrwUjoo1zQUn3e/o+PJFM7Ae+szz262m7Tzqw9ckdtdCHbOzu6iPC0Z+bM8
	 DJTJaND4Hhyzbx0XxyF5+7cy/NT/ceipiFRWIamCEmFIasSenmfHrvRlKwHTV648Nm
	 jU5JOjvjZehMGjGSQgTYZW39QTh/nQN2wDmTfYnskqIhq3lkHoS7R+TcpQh1Fv65Ca
	 Dyxvnhyc2jpmg==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 788502E00D9; Wed, 10 Sep 2025 11:00:28 -0400 (EDT)
Date: Wed, 10 Sep 2025 11:00:28 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Ralph Siemsen <ralph.siemsen@linaro.org>
Cc: Andreas Dilger <adilger@dilger.ca>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH RFC 2/3] mke2fs.c: fail on multiple '-E' options
Message-ID: <20250910150028.GB3662537@mit.edu>
References: <20250909-mke2fs-small-fixes-v1-2-c6ba28528af2@linaro.org>
 <17EED9B4-41D4-4D1C-9838-1ECF5B39C00D@dilger.ca>
 <CANp-EDZF3sVLQWdL4+a1aQLa5uqt5R_trzOp3Hh+Kw21hRn0ZQ@mail.gmail.com>
 <20250910145241.GA3662537@mit.edu>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="Rvf/IN6En+Zc/tN0"
Content-Disposition: inline
In-Reply-To: <20250910145241.GA3662537@mit.edu>


--Rvf/IN6En+Zc/tN0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 10, 2025 at 10:52:41AM -0400, Theodore Ts'o wrote:
> What I would suggest that you do is to move code which mutates the
> file system from parse_extended_opts() so it is only interpreting the
> options, and move that code to tuine2fs_main().
> 
> That way we can call parse_extended_opts() multiple times.  In fact,
> that had been on my todo list, since I need to do this to support
> changing the superblock using ioctl's while it is mounted, so we can
> deny read/write access to the block device while the file system is
> mounted.  See [1].
> 
> [1] https://lore.kernel.org/all/20250908-tune2fs-v1-0-e3a6929f3355@mit.edu/

In fact, if you want to see the direction which I'm headed, here is a
purely in-progress patch set for tune2fs.  The first patch is
incomplete because it doesn't handle parse_extended_opts() yet.

Since I want to have two code paths for setting the file system
parameters (one when the file system is mounted, one when it is
unmounted), it's why I want to separate out the functionality in
parse_extended_opts().

      	      	       	       		     - Ted

--Rvf/IN6En+Zc/tN0
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-tune2fs-reorganize-command-line-flag-handling.patch"

From 198cba8bec884bbd51901ceae45fc4384acb113c Mon Sep 17 00:00:00 2001
From: Theodore Ts'o <tytso@mit.edu>
Date: Mon, 8 Sep 2025 14:16:32 -0400
Subject: [PATCH 1/2] tune2fs: reorganize command-line flag handling

Instead of using individual ad-hoc variables indicating whether a
particular superblock value has been requested to be changed (e.g.,
c_flag, C_flag, et.al) use an array of booleans with indexes that are
defined with more human-readable #define's (e.g., OPT_MAX_MOUNTCOUNT).

There should be no behavioral changes from this code restructuring.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 misc/tune2fs.c | 206 +++++++++++++++++++++++++++----------------------
 1 file changed, 114 insertions(+), 92 deletions(-)

diff --git a/misc/tune2fs.c b/misc/tune2fs.c
index 3db57632..b4c63da4 100644
--- a/misc/tune2fs.c
+++ b/misc/tune2fs.c
@@ -103,13 +103,34 @@ struct fsuuid {
 
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
+#define OPT_UUID		12
+#define OPT_LAST_MOUNTED	13
+#define OPT_SPARSE_SUPER	14
+#define OPT_QUOTA		15
+#define OPT_JOURNAL_SIZE	16
+#define OPT_JOURNAL_OPTS	17
+#define OPT_MNTOPTS		18
+#define OPT_FEATURES		19
+#define OPT_EXTENDED_CMD	20
+#define MAX_OPTS		21
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
 static int print_label;
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
@@ -1940,7 +1974,7 @@ static void parse_e2label_options(int argc, char ** argv)
 	open_flag = EXT2_FLAG_JOURNAL_DEV_OK | EXT2_FLAG_SUPER_ONLY;
 	if (argc == 3) {
 		open_flag |= EXT2_FLAG_RW;
-		L_flag = 1;
+		opts[OPT_LABEL] = true;
 		new_label = argv[2];
 	} else
 		print_label++;
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
+	if (opts[OPT_LABEL] || print_label) {
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


--Rvf/IN6En+Zc/tN0
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0002-DO-NOT-SUBMIT-tune2fs-initial-support-for-EXT4_IOC_G.patch"

From b3ad517ba41f8dc2129564ecfefcac45062076d5 Mon Sep 17 00:00:00 2001
From: Theodore Ts'o <tytso@mit.edu>
Date: Wed, 10 Sep 2025 10:56:37 -0400
Subject: [PATCH 2/2] DO NOT SUBMIT: tune2fs: initial support for
 EXT4_IOC_GET_TUNE_SB_PARAM

Not-Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 misc/tune2fs.c | 198 ++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 188 insertions(+), 10 deletions(-)

diff --git a/misc/tune2fs.c b/misc/tune2fs.c
index b4c63da4..b76fba8c 100644
--- a/misc/tune2fs.c
+++ b/misc/tune2fs.c
@@ -101,6 +101,59 @@ struct fsuuid {
 #define EXT4_IOC_SETFSUUID	_IOW('f', 44, struct fsuuid)
 #endif
 
+#if (!defined(EXT4_IOC_GET_TUNE_SB_PARAM) && defined(__linux__))
+
+struct ext4_tune_sb_params {
+	__u32 set_flags;
+	__u32 checkinterval;
+	__u16 errors_behavior;
+	__u16 mnt_count;
+	__u16 max_mnt_count;
+	__u16 raid_stride;
+	__u64 last_check_time;
+	__u64 reserved_blocks;
+	__u64 blocks_count;
+	__u32 default_mnt_opts;
+	__u32 reserved_uid;
+	__u32 reserved_gid;
+	__u32 raid_stripe_width;
+	__u8  def_hash_alg;
+	__u8  pad_1;
+	__u16 pad_2;
+	__u32 feature_compat;
+	__u32 feature_incompat;
+	__u32 feature_ro_compat;
+	__u32 set_feature_compat_mask;
+	__u32 set_feature_incompat_mask;
+	__u32 set_feature_ro_compat_mask;
+	__u32 clear_feature_compat_mask;
+	__u32 clear_feature_incompat_mask;
+	__u32 clear_feature_ro_compat_mask;
+	__u8  mount_opts[64];
+	__u8  pad[64];
+};
+
+#define EXT4_TUNE_FL_ERRORS_BEHAVIOR	0x00000001
+#define EXT4_TUNE_FL_MNT_COUNT		0x00000002
+#define EXT4_TUNE_FL_MAX_MNT_COUNT	0x00000004
+#define EXT4_TUNE_FL_CHECKINTRVAL	0x00000008
+#define EXT4_TUNE_FL_LAST_CHECK_TIME	0x00000010
+#define EXT4_TUNE_FL_RESERVED_BLOCKS	0x00000020
+#define EXT4_TUNE_FL_RESERVED_UID	0x00000040
+#define EXT4_TUNE_FL_RESERVED_GID	0x00000080
+#define EXT4_TUNE_FL_DEFAULT_MNT_OPTS	0x00000100
+#define EXT4_TUNE_FL_DEF_HASH_ALG	0x00000200
+#define EXT4_TUNE_FL_RAID_STRIDE	0x00000400
+#define EXT4_TUNE_FL_RAID_STRIPE_WIDTH	0x00000800
+#define EXT4_TUNE_FL_MOUNT_OPTS		0x00001000
+#define EXT4_TUNE_FL_FEATURES		0x00002000
+#define EXT4_TUNE_FL_EDIT_FEATURES	0x00002000
+
+#define EXT4_IOC_GET_TUNE_SB_PARAM	_IOR('f', 45, struct ext4_tune_sb_params)
+#define EXT4_IOC_SET_TUNE_SB_PARAM	_IOW('f', 46, struct ext4_tune_sb_params)
+
+#endif
+
 extern int ask_yn(const char *string, int def);
 
 #define OPT_MAX_MOUNTCOUNT	 1
@@ -160,6 +213,10 @@ char *journal_device;
 static blk64_t journal_location = ~0LL;
 static e2_blkcnt_t orphan_file_blocks;
 
+static int fs_fd = -1;
+static int fs_mnt_flags = 0;
+static int fs_set_ops = 0;
+
 static struct list_head blk_move_list;
 
 struct blk_move {
@@ -2039,6 +2096,10 @@ static void parse_tune2fs_options(int argc, char **argv)
 			}
 			if (max_mount_count == 0)
 				max_mount_count = -1;
+			else if (max_mount_count == 65536) {
+				max_mount_count = EXT2_DFL_MAX_MNT_COUNT +
+					(random() % EXT2_DFL_MAX_MNT_COUNT);
+			}
 			break;
 		case 'C':
 			opts[OPT_MOUNTCOUNT] = true;
@@ -2121,6 +2182,12 @@ static void parse_tune2fs_options(int argc, char **argv)
 					_("bad interval - %s"), optarg);
 				usage();
 			}
+			if ((unsigned long long)interval >= (1ULL << 32)) {
+				com_err(program_name, 0,
+					_("interval between checks is too big (%lu)"),
+					interval);
+				exit(1);
+			}
 			break;
 		case 'j':
 			opts[OPT_JOURNAL_SIZE] = true;
@@ -3124,6 +3191,121 @@ fs_update_journal_user(struct ext2_super_block *sb, __u8 old_uuid[UUID_SIZE])
 	return 0;
 }
 
+static void try_mounted_access()
+{
+#ifdef __linux__
+	errcode_t ret;
+	char mntpt[PATH_MAX + 1];
+	struct ext4_tune_sb_params params;
+	__u64 fs_blocks_count;
+	__u32 fs_feature_array[3];
+	int opts_success = 0;
+
+	fs_fd = -1;
+	fs_mnt_flags = 0;
+	ret = ext2fs_check_mount_point(device_name, &fs_mnt_flags,
+					  mntpt, sizeof(
+						  mntpt));
+	if (ret)
+		return;
+
+	if (!(fs_mnt_flags & EXT2_MF_MOUNTED))
+		return;
+
+	if (!mntpt[0])
+		return;
+
+	fs_fd = open(mntpt, O_RDONLY);
+	if (fs_fd < 0)
+		return;
+
+	if (ioctl(fs_fd, EXT4_IOC_GET_TUNE_SB_PARAM, &params))
+		return;
+
+	fs_set_ops = params.set_flags;
+	fs_blocks_count = params.blocks_count;
+	fs_feature_array[0] = params.feature_compat;
+	fs_feature_array[1] = params.feature_incompat;
+	fs_feature_array[2] = params.feature_ro_compat;
+
+	memset(&params, 0, sizeof(params));
+
+	if (opts[OPT_ERROR_BEHAVIOR] &&
+	    (fs_set_ops & EXT4_TUNE_FL_ERRORS_BEHAVIOR)) {
+		params.set_flags |= EXT4_TUNE_FL_ERRORS_BEHAVIOR;
+		params.errors_behavior = errors;
+	}
+	if (opts[OPT_MOUNTCOUNT] &&
+	    (fs_set_ops & EXT4_TUNE_FL_MNT_COUNT)) {
+		params.set_flags |= EXT4_TUNE_FL_MNT_COUNT;
+		params.mnt_count = mount_count;
+	}
+	if (opts[OPT_MAX_MOUNTCOUNT] &&
+	    (fs_set_ops & EXT4_TUNE_FL_MAX_MNT_COUNT)) {
+		params.set_flags |= EXT4_TUNE_FL_MAX_MNT_COUNT;
+		params.max_mnt_count = max_mount_count;
+	}
+	if (opts[OPT_CHECKINTERVAL] &&
+	    (fs_set_ops & EXT4_TUNE_FL_CHECKINTRVAL)) {
+		params.set_flags |= EXT4_TUNE_FL_CHECKINTRVAL;
+		params.checkinterval = interval;
+	}
+	if (opts[OPT_CHECKTIME] &&
+	    (fs_set_ops & EXT4_TUNE_FL_LAST_CHECK_TIME)) {
+		params.set_flags |= EXT4_TUNE_FL_LAST_CHECK_TIME;
+		params.last_check_time = last_check_time;
+	}
+	if (opts[OPT_RESUID] &&
+	    (fs_set_ops & EXT4_TUNE_FL_RESERVED_UID)) {
+		params.set_flags |= EXT4_TUNE_FL_RESERVED_UID;
+		params.reserved_uid = resuid;
+	}
+	if (opts[OPT_RESGID] &&
+	    (fs_set_ops & EXT4_TUNE_FL_RESERVED_GID)) {
+		params.set_flags |= EXT4_TUNE_FL_RESERVED_GID;
+		params.reserved_uid = resgid;
+	}
+	if (opts[OPT_RESERVED_RATIO) && !opts[OPT_RESERVED_BLOCKS]) {
+		reserved_blocks = reserved_ratio * fs_blocks_count / 100.0;
+		opts[OPT_RESERVED_BLOCKS] = true;
+	}
+	if (opts[OPT_RESERVED_BLOCKS] &&
+	    (fs_set_ops & EXT4_TUNE_FL_RESERVED_BLOCKS)) {
+		params.set_flags |= EXT4_TUNE_FL_RESERVED_BLOCKS;
+		params.reserved_blocks = reserved_blocks;
+	}
+
+/* TODO:
+ * EXT4_TUNE_FL_DEFAULT_MNT_OPTS
+ * EXT4_TUNE_FL_DEF_HASH_ALG
+ * EXT4_TUNE_FL_RAID_STRIDE
+ * EXT4_TUNE_FL_RAID_STRIPE_WIDTH
+ * EXT4_TUNE_FL_MOUNT_OPTS
+ * EXT4_TUNE_FL_FEATURES
+ */
+
+	if (ioctl(fs_fd, EXT4_IOC_SET_TUNE_SB_PARAM, &params) == 0) {
+		opts[OPT_ERROR_BEHAVIOR] = opts[OPT_MOUNTCOUNT] =
+			opts[OPT_MAX_MOUNTCOUNT] = opts[OPT_CHECKINTERVAL] =
+			opts[OPT_CHECKTIME] = opts[OPT_RESUID] =
+			opts[OPT_RESGID] = opts[OPT_RESERVED_RATIO] =
+			opts[OPT_RESERVED_BLOCKS] = false;
+		printf("ioctl EXT4_IOC_SET_TUNE_SB_PARAM succeeded\n");
+	} else {
+		perror("ioctl EXT4_IOC_SET_TUNE_SB_PARAM");
+		exit(1);
+	}
+	close(fs_fd);
+
+#else
+	fs_fd = -1;
+	fs_mnt_flags = 0;
+#endif
+	printf("fs_fd %d, mnt_flags %08x, set_ops %08x\n", fs_fd,
+	       fs_mnt_flags, fs_set_ops);
+}
+
+
 /*
  * Use FS_IOC_SETFSLABEL or FS_IOC_GETFSLABEL to set/get file system label
  * Return:	0 on success
@@ -3239,6 +3421,12 @@ int tune2fs_main(int argc, char **argv)
 #endif
 		io_ptr = unix_io_manager;
 
+	try_mounted_access();
+	if (!tune_opts_requested()) {
+		printf("No further tune opts left\n");
+		exit(0);
+	}
+
 	/*
 	 * Try the get/set fs label using ioctls before we even attempt
 	 * to open the file system.
@@ -3401,9 +3589,6 @@ _("Warning: The journal is dirty. You may wish to replay the journal like:\n\n"
 	fs->flags |= EXT2_FLAG_SUPER_ONLY;
 
 	if (opts[OPT_MAX_MOUNTCOUNT]) {
-		if (max_mount_count == 65536)
-			max_mount_count = EXT2_DFL_MAX_MNT_COUNT +
-				(random() % EXT2_DFL_MAX_MNT_COUNT);
 		sb->s_max_mnt_count = max_mount_count;
 		ext2fs_mark_super_dirty(fs);
 		printf(_("Setting maximal mount count to %d\n"),
@@ -3429,13 +3614,6 @@ _("Warning: The journal is dirty. You may wish to replay the journal like:\n\n"
 		}
 	}
 	if (opts[OPT_CHECKINTERVAL]) {
-		if ((unsigned long long)interval >= (1ULL << 32)) {
-			com_err(program_name, 0,
-				_("interval between checks is too big (%lu)"),
-				interval);
-			rc = 1;
-			goto closefs;
-		}
 		sb->s_checkinterval = interval;
 		ext2fs_mark_super_dirty(fs);
 		printf(_("Setting interval between checks to %lu seconds\n"),
-- 
2.51.0


--Rvf/IN6En+Zc/tN0--

