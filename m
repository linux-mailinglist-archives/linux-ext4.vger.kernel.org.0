Return-Path: <linux-ext4+bounces-10225-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8EE8B7FB3F
	for <lists+linux-ext4@lfdr.de>; Wed, 17 Sep 2025 16:04:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B3BF1691A5
	for <lists+linux-ext4@lfdr.de>; Wed, 17 Sep 2025 03:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E36E2F616E;
	Wed, 17 Sep 2025 03:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="AgkAfn8e"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D895230D0F
	for <linux-ext4@vger.kernel.org>; Wed, 17 Sep 2025 03:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758079711; cv=none; b=auklpnSCI9lpAXfPoUPixrd48UHJ/Pmi6tsq/qg7LOrGanmHpyjmm32k98U4pjJFM2Dwn7uZbzcp7IN+fclFDTbG3KsIKBGCROnzyvdiqU7ITzAZbKFRWxfewkd8ccLTKHg/ou0m+4HRb3pxobJ23F/ZtoWUNGxjW/w2aOE4hVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758079711; c=relaxed/simple;
	bh=ZRzs2dhSF0eNl8qNM3Mn8AaskNGxuOY21szdfig70oY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kW2NFTx87P/tbJJNnsKZoKltbz8f2kI5iFd5i/mJMdR0b+PwTfKfHM+4yvJpcMwmxaeLmvduikGTKakFZm//NKwjf8F/2miG5WEfQ23d7v5LA9fXcAnqiEZZHL1aDwdEAuifnxL6blquROFr5d1kN3tkgzLpe+7yg8/sGUxS904=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=AgkAfn8e; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-116-225.bstnma.fios.verizon.net [173.48.116.225])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 58H3SJ2L001494
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Sep 2025 23:28:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1758079700; bh=Wg3NJJuZ0pkokI8jvJJBZJpVn+tBfAahhAR6zEwvxvo=;
	h=From:Subject:Date:Message-ID:MIME-Version;
	b=AgkAfn8edSQZfzpYcI96Qv0fT1QB9PPXxD3B2XJ0DJrcLwYxNyjisJe6Nj/+/9SdO
	 FwXyjiEvEzeLrffGDuzlKOC+u5Npq9w49cIe0YhN6UYb7SH06zjFiYLLt6hwoMB736
	 3Sxn8q6hVuwpGhkwpk2XTUHZoY2oRexlkniZbrI/hvTAEEUvm8A9YKpCOBCovi2yDD
	 AeTxjdHz44QqiB3bdIViuRudx44zECgij3L1y6N/uAI5x6uD4IIH5YHI40HCLJYb6R
	 ve8UuyEnlsmY5YBeJDbU3Lk4TaCq+scVYgIpXnxmY7KbBKfqqL1l5rhZE5DjLu+tiC
	 hkTKqIxBSGSCg==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 3A0122E00DB; Tue, 16 Sep 2025 23:28:19 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: Ext4 Developers List <linux-ext4@vger.kernel.org>
Cc: "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH 2/3] tune2fs: rework parse_extended_opts() so it only parses the option string
Date: Tue, 16 Sep 2025 23:28:13 -0400
Message-ID: <20250917032814.395887-3-tytso@mit.edu>
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

The parse_extended_opts() was doing two things: interpreting the
string passed into the command line and modifying the file system's
superblock.  Separate out the file system modification and move it out
from parse_extended_opts().

This allows the user to specify more than one -E command-line option,
and it also allows some of the file system changes to be modified via
an ioctl for a mounted file system.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 misc/tune2fs.c | 211 +++++++++++++++++++++++++++----------------------
 1 file changed, 118 insertions(+), 93 deletions(-)

diff --git a/misc/tune2fs.c b/misc/tune2fs.c
index 1b3716e1..e752c328 100644
--- a/misc/tune2fs.c
+++ b/misc/tune2fs.c
@@ -123,8 +123,19 @@ extern int ask_yn(const char *string, int def);
 #define OPT_JOURNAL_OPTS	18
 #define OPT_MNTOPTS		19
 #define OPT_FEATURES		20
-#define OPT_EXTENDED_CMD	21
-#define MAX_OPTS		22
+#define OPT_CLEAR_MMP		21
+#define OPT_MMP_INTERVAL	22
+#define OPT_FORCE_FSCK		23
+#define OPT_TEST_FS		24
+#define OPT_CLEAR_TEST_FS	25
+#define OPT_RAID_STRIDE		26
+#define OPT_RAID_STRIPE_WIDTH	27
+#define OPT_HASH_ALG		28
+#define OPT_MOUNT_OPTS		29
+#define OPT_ENCODING		30
+#define OPT_ENCODING_FLAGS	31
+#define OPT_ORPHAN_FILE_SIZE	32
+#define MAX_OPTS		33
 static bool opts[MAX_OPTS];
 
 const char *program_name = "tune2fs";
@@ -132,7 +143,6 @@ char *device_name;
 char *new_label, *new_last_mounted, *requested_uuid;
 char *io_options;
 static int force, do_list_super, sparse_value = -1;
-static int clear_mmp;
 static time_t last_check_time;
 static int max_mount_count, mount_count, mount_flags;
 static unsigned long interval;
@@ -140,12 +150,16 @@ static blk64_t reserved_blocks;
 static double reserved_ratio;
 static unsigned long resgid, resuid;
 static unsigned short errors;
+static unsigned long mmp_interval;
+static int hash_alg;
+static char *hash_alg_str;
+static int encoding;
+static __u16 encoding_flags;
+static char *encoding_str, *encoding_flags_str;
 static int open_flag;
 static char *features_cmd;
 static char *mntopts_cmd;
 static int stride, stripe_width;
-static int stride_set, stripe_width_set;
-static char *extended_cmd;
 static unsigned long new_inode_size;
 static char *ext_mount_opts;
 static int quota_enable[MAXQUOTAS];
@@ -153,7 +167,6 @@ static int rewrite_checksums;
 static int feature_64bit;
 static int fsck_requested;
 static char *undo_file;
-int enabling_casefold;
 
 int journal_size, journal_fc_size, journal_flags;
 char *journal_device;
@@ -184,6 +197,8 @@ void do_findfs(int argc, char **argv);
 int journal_enable_debug = -1;
 #endif
 
+static int parse_extended_opts(const char *ext_opts);
+
 static void usage(void)
 {
 	fprintf(stderr,
@@ -1645,7 +1660,6 @@ mmp_error:
 		}
 		fs->super->s_encoding = EXT4_ENC_UTF8_12_1;
 		fs->super->s_encoding_flags = e2p_get_encoding_flags(EXT4_ENC_UTF8_12_1);
-		enabling_casefold = 1;
 	}
 
 	if (FEATURE_OFF(E2P_FEATURE_INCOMPAT, EXT4_FEATURE_INCOMPAT_CASEFOLD)) {
@@ -1661,7 +1675,6 @@ mmp_error:
 		}
 		fs->super->s_encoding = 0;
 		fs->super->s_encoding_flags = 0;
-		enabling_casefold = 0;
 	}
 
 	if (FEATURE_ON(E2P_FEATURE_INCOMPAT,
@@ -2066,8 +2079,8 @@ static void parse_tune2fs_options(int argc, char **argv)
 			}
 			break;
 		case 'E':
-			opts[OPT_EXTENDED_CMD] = true;
-			extended_cmd = optarg;
+			if (parse_extended_opts(optarg))
+				exit(1);
 			break;
 		case 'f': /* Force */
 			force++;
@@ -2259,6 +2272,11 @@ static void parse_tune2fs_options(int argc, char **argv)
 			argv[optind]);
 		exit(1);
 	}
+	if (opts[OPT_ENCODING_FLAGS] && !opts[OPT_ENCODING]) {
+		fprintf(stderr, _("error: An encoding must be explicitly "
+				  "specified when passing encoding-flags\n"));
+		exit(1);
+	}
 }
 
 #ifdef CONFIG_BUILD_FINDFS
@@ -2282,23 +2300,22 @@ void do_findfs(int argc, char **argv)
 }
 #endif
 
-static int parse_extended_opts(ext2_filsys fs, const char *opts)
+#define member_size(type, member) (sizeof( ((type *)0)->member ))
+
+static int parse_extended_opts(const char *ext_opts)
 {
-	struct ext2_super_block *sb = fs->super;
 	char	*buf, *token, *next, *p, *arg;
-	int	len, hash_alg;
+	int	len;
 	int	r_usage = 0;
-	int encoding = 0;
-	char	*encoding_flags = NULL;
 
-	len = strlen(opts);
+	len = strlen(ext_opts);
 	buf = malloc(len+1);
 	if (!buf) {
 		fprintf(stderr, "%s",
 			_("Couldn't allocate memory to parse options!\n"));
 		return 1;
 	}
-	strcpy(buf, opts);
+	strcpy(buf, ext_opts);
 	for (token = buf; token && *token; token = next) {
 		p = strchr(token, ',');
 		next = 0;
@@ -2313,14 +2330,13 @@ static int parse_extended_opts(ext2_filsys fs, const char *opts)
 		}
 		if (strcmp(token, "clear-mmp") == 0 ||
 		    strcmp(token, "clear_mmp") == 0) {
-			clear_mmp = 1;
+			opts[OPT_CLEAR_MMP] = true;
 		} else if (strcmp(token, "mmp_update_interval") == 0) {
-			unsigned long intv;
 			if (!arg) {
 				r_usage++;
 				continue;
 			}
-			intv = strtoul(arg, &p, 0);
+			mmp_interval = strtoul(arg, &p, 0);
 			if (*p) {
 				fprintf(stderr,
 					_("Invalid mmp_update_interval: %s\n"),
@@ -2328,34 +2344,22 @@ static int parse_extended_opts(ext2_filsys fs, const char *opts)
 				r_usage++;
 				continue;
 			}
-			if (intv == 0) {
-				intv = EXT4_MMP_UPDATE_INTERVAL;
-			} else if (intv > EXT4_MMP_MAX_UPDATE_INTERVAL) {
+			if (mmp_interval == 0) {
+				mmp_interval = EXT4_MMP_UPDATE_INTERVAL;
+			} else if (mmp_interval > EXT4_MMP_MAX_UPDATE_INTERVAL) {
 				fprintf(stderr,
 					_("mmp_update_interval too big: %lu\n"),
-					intv);
+					mmp_interval);
 				r_usage++;
 				continue;
 			}
-			printf(P_("Setting multiple mount protection update "
-				  "interval to %lu second\n",
-				  "Setting multiple mount protection update "
-				  "interval to %lu seconds\n", intv),
-			       intv);
-			sb->s_mmp_update_interval = intv;
-			ext2fs_mark_super_dirty(fs);
+			opts[OPT_MMP_INTERVAL] = true;
 		} else if (!strcmp(token, "force_fsck")) {
-			sb->s_state |= EXT2_ERROR_FS;
-			printf(_("Setting filesystem error flag to force fsck.\n"));
-			ext2fs_mark_super_dirty(fs);
+			opts[OPT_FORCE_FSCK] = true;
 		} else if (!strcmp(token, "test_fs")) {
-			sb->s_flags |= EXT2_FLAGS_TEST_FILESYS;
-			printf("Setting test filesystem flag\n");
-			ext2fs_mark_super_dirty(fs);
+			opts[OPT_TEST_FS] = true;
 		} else if (!strcmp(token, "^test_fs")) {
-			sb->s_flags &= ~EXT2_FLAGS_TEST_FILESYS;
-			printf("Clearing test filesystem flag\n");
-			ext2fs_mark_super_dirty(fs);
+			opts[OPT_CLEAR_TEST_FS] = true;
 		} else if (strcmp(token, "stride") == 0) {
 			if (!arg) {
 				r_usage++;
@@ -2369,7 +2373,7 @@ static int parse_extended_opts(ext2_filsys fs, const char *opts)
 				r_usage++;
 				continue;
 			}
-			stride_set = 1;
+			opts[OPT_RAID_STRIDE] = true;
 		} else if (strcmp(token, "stripe-width") == 0 ||
 			   strcmp(token, "stripe_width") == 0) {
 			if (!arg) {
@@ -2384,7 +2388,7 @@ static int parse_extended_opts(ext2_filsys fs, const char *opts)
 				r_usage++;
 				continue;
 			}
-			stripe_width_set = 1;
+			opts[OPT_RAID_STRIPE_WIDTH] = true;
 		} else if (strcmp(token, "hash_alg") == 0 ||
 			   strcmp(token, "hash-alg") == 0) {
 			if (!arg) {
@@ -2399,21 +2403,21 @@ static int parse_extended_opts(ext2_filsys fs, const char *opts)
 				r_usage++;
 				continue;
 			}
-			sb->s_def_hash_version = hash_alg;
-			printf(_("Setting default hash algorithm "
-				 "to %s (%d)\n"),
-			       arg, hash_alg);
-			ext2fs_mark_super_dirty(fs);
+			hash_alg_str = strdup(arg);
+			opts[OPT_HASH_ALG] = true;
 		} else if (!strcmp(token, "mount_opts")) {
 			if (!arg) {
 				r_usage++;
 				continue;
 			}
-			if (strlen(arg) >= sizeof(fs->super->s_mount_opts)) {
+			if (strlen(arg) >=
+			    member_size(struct ext2_super_block,
+					s_mount_opts)) {
 				fprintf(stderr,
 					"Extended mount options too long\n");
 				continue;
 			}
+			opts[OPT_MOUNT_OPTS] = true;
 			ext_mount_opts = strdup(arg);
 		} else if (!strcmp(token, "encoding")) {
 			if (!arg) {
@@ -2426,36 +2430,33 @@ static int parse_extended_opts(ext2_filsys fs, const char *opts)
 				r_usage++;
 				continue;
 			}
-			if (ext2fs_has_feature_casefold(sb) && !enabling_casefold) {
-				fprintf(stderr, _("Cannot alter existing encoding\n"));
-				r_usage++;
-				continue;
-			}
 			encoding = e2p_str2encoding(arg);
 			if (encoding < 0) {
 				fprintf(stderr, _("Invalid encoding: %s\n"), arg);
 				r_usage++;
 				continue;
 			}
-			enabling_casefold = 1;
-			sb->s_encoding = encoding;
-			printf(_("Setting encoding to '%s'\n"), arg);
-			sb->s_encoding_flags =
-				e2p_get_encoding_flags(sb->s_encoding);
+			encoding_str = strdup(arg);
+			opts[OPT_ENCODING] = true;
 		} else if (!strcmp(token, "encoding_flags")) {
 			if (!arg) {
 				r_usage++;
 				continue;
 			}
-			encoding_flags = arg;
+			if (e2p_str2encoding_flags(EXT4_ENC_UTF8_12_1,
+						   arg, &encoding_flags)) {
+				fprintf(stderr,
+		_("error: Invalid encoding flag: %s\n"), arg);
+				r_usage++;
+			}
+			encoding_flags_str = strdup(arg);
+			opts[OPT_ENCODING_FLAGS] = true;
 		} else if (!strcmp(token, "orphan_file_size")) {
 			if (!arg) {
 				r_usage++;
 				continue;
 			}
-			orphan_file_blocks = parse_num_blocks2(arg,
-						 fs->super->s_log_block_size);
-
+			orphan_file_blocks = parse_num_blocks2(arg, 0);
 			if (orphan_file_blocks < 1) {
 				fprintf(stderr,
 					_("Invalid size of orphan file %s\n"),
@@ -2463,30 +2464,10 @@ static int parse_extended_opts(ext2_filsys fs, const char *opts)
 				r_usage++;
 				continue;
 			}
+			opts[OPT_ORPHAN_FILE_SIZE] = true;
 		} else
 			r_usage++;
 	}
-
-	if (encoding > 0 && !r_usage) {
-		sb->s_encoding_flags =
-			e2p_get_encoding_flags(sb->s_encoding);
-
-		if (encoding_flags &&
-		    e2p_str2encoding_flags(sb->s_encoding, encoding_flags,
-					   &sb->s_encoding_flags)) {
-			fprintf(stderr, _("error: Invalid encoding flag: %s\n"),
-					encoding_flags);
-			r_usage++;
-		} else if (encoding_flags)
-			printf(_("Setting encoding_flags to '%s'\n"),
-				 encoding_flags);
-		ext2fs_set_feature_casefold(sb);
-		ext2fs_mark_super_dirty(fs);
-	} else if (encoding_flags && !r_usage) {
-		fprintf(stderr, _("error: An encoding must be explicitly "
-				  "specified when passing encoding-flags\n"));
-		r_usage++;
-	}
 	if (r_usage) {
 		fprintf(stderr, "%s", _("\nBad options specified.\n\n"
 			"Extended options are separated by commas, "
@@ -3518,27 +3499,64 @@ _("Warning: The journal is dirty. You may wish to replay the journal like:\n\n"
 		if (rc)
 			goto closefs;
 	}
+	if (ext2fs_has_feature_casefold(sb) && opts[OPT_ENCODING]) {
+		fprintf(stderr, _("Cannot alter existing encoding\n"));
+		rc = 1;
+		goto closefs;
+	}
 	if (features_cmd) {
 		rc = update_feature_set(fs, features_cmd);
 		if (rc)
 			goto closefs;
 	}
-	if (extended_cmd) {
-		rc = parse_extended_opts(fs, extended_cmd);
-		if (rc)
-			goto closefs;
-		if (clear_mmp && !force) {
+	if (opts[OPT_CLEAR_MMP]) {
+		if (!force) {
 			fputs(_("Error in using clear_mmp. "
 				"It must be used with -f\n"),
 			      stderr);
 			rc = 1;
 			goto closefs;
 		}
-	}
-	if (clear_mmp) {
 		rc = ext2fs_mmp_clear(fs);
 		goto closefs;
 	}
+	if (opts[OPT_MMP_INTERVAL]) {
+		printf(P_("Setting multiple mount protection update "
+			  "interval to %lu second\n",
+			  "Setting multiple mount protection update "
+			  "interval to %lu seconds\n", mmp_interval),
+		       mmp_interval);
+		sb->s_mmp_update_interval = mmp_interval;
+		ext2fs_mark_super_dirty(fs);
+	}
+	if (opts[OPT_FORCE_FSCK]) {
+		sb->s_state |= EXT2_ERROR_FS;
+		printf(_("Setting filesystem error flag to force fsck.\n"));
+		ext2fs_mark_super_dirty(fs);
+	}
+	if (opts[OPT_TEST_FS]) {
+		sb->s_flags |= EXT2_FLAGS_TEST_FILESYS;
+		printf("Setting test filesystem flag\n");
+		ext2fs_mark_super_dirty(fs);
+	}
+	if (opts[OPT_CLEAR_TEST_FS]) {
+		sb->s_flags &= ~EXT2_FLAGS_TEST_FILESYS;
+		printf("Clearing test filesystem flag\n");
+		ext2fs_mark_super_dirty(fs);
+	}
+	if (opts[OPT_ENCODING]) {
+		ext2fs_set_feature_casefold(sb);
+		sb->s_encoding = encoding;
+		printf(_("Setting encoding to '%s'\n"), encoding_str);
+		if (opts[OPT_ENCODING_FLAGS]) {
+			sb->s_encoding_flags = encoding_flags;
+			printf(_("Setting encoding_flags to '%s'\n"),
+			       encoding_flags_str);
+		} else
+			sb->s_encoding_flags =
+				e2p_get_encoding_flags(sb->s_encoding);
+			ext2fs_mark_super_dirty(fs);
+	}
 	if (journal_size || journal_device) {
 		rc = add_journal(fs);
 		if (rc)
@@ -3554,6 +3572,7 @@ _("Warning: The journal is dirty. You may wish to replay the journal like:\n\n"
 			rc = 1;
 			goto closefs;
 		}
+		orphan_file_blocks >>= fs->super->s_log_block_size;
 		err = ext2fs_create_orphan_file(fs, orphan_file_blocks);
 		if (err) {
 			com_err(program_name, err, "%s",
@@ -3764,17 +3783,23 @@ _("Warning: The journal is dirty. You may wish to replay the journal like:\n\n"
 
 	if (do_list_super)
 		list_super(sb);
-	if (stride_set) {
+	if (opts[OPT_RAID_STRIDE]) {
 		sb->s_raid_stride = stride;
 		ext2fs_mark_super_dirty(fs);
 		printf(_("Setting stride size to %d\n"), stride);
 	}
-	if (stripe_width_set) {
+	if (opts[OPT_RAID_STRIPE_WIDTH]) {
 		sb->s_raid_stripe_width = stripe_width;
 		ext2fs_mark_super_dirty(fs);
 		printf(_("Setting stripe width to %d\n"), stripe_width);
 	}
-	if (ext_mount_opts) {
+	if (opts[OPT_HASH_ALG]) {
+		sb->s_def_hash_version = hash_alg;
+		printf(_("Setting default hash algorithm to %s (%d)\n"),
+		       hash_alg_str, hash_alg);
+		ext2fs_mark_super_dirty(fs);
+	}
+	if (opts[OPT_MOUNT_OPTS]) {
 		strncpy((char *)(fs->super->s_mount_opts), ext_mount_opts,
 			sizeof(fs->super->s_mount_opts));
 		fs->super->s_mount_opts[sizeof(fs->super->s_mount_opts)-1] = 0;
-- 
2.51.0


