Return-Path: <linux-ext4+bounces-10227-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C29C3B7EB52
	for <lists+linux-ext4@lfdr.de>; Wed, 17 Sep 2025 14:58:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37B8C1C01E29
	for <lists+linux-ext4@lfdr.de>; Wed, 17 Sep 2025 03:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 379132F7461;
	Wed, 17 Sep 2025 03:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="Tiw0dVdR"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D98C2C15AA
	for <linux-ext4@vger.kernel.org>; Wed, 17 Sep 2025 03:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758079711; cv=none; b=mpTFTQooT7Y8fDaRjmp1wtgQFqPCgJQlN0KrXBtGcWC4NYHvHmsHzhNoznlYdbjOjHLH2jPh8IfkYzWnbEgiqLEd4auUceuhTVd7cjIV6CQsbLBBb7WvkFZbqSG6CjmkoiIcDyTEv8KAlao/BarCkhbQIkAuGq8nj3NJVuGuvpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758079711; c=relaxed/simple;
	bh=V32rewVT6gBBhnr2dLeZ7xkK1pvAgMDrtdaMdynH30c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fouGuJdsrcJUyNzEOybXf3QWHxVXj8AzOc7pcFshVMVSHzXCZqhBU7zAgI+nsQtGqJd1EgRj24xYvLdL9GfHVOvgrKAXjmOYiz9gSSQmOVxnLSUrSD6wCJbBHBSoZ0NydvbBPqSIgh2pSZ4bflHuE4JpLMWyK5TFkgS6m1z7eN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=Tiw0dVdR; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-116-225.bstnma.fios.verizon.net [173.48.116.225])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 58H3SJ9E001496
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Sep 2025 23:28:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1758079700; bh=x+VekIH1pN1AN+GLDBaGjaZJIaAc9vMGqMwO+yEcTzE=;
	h=From:Subject:Date:Message-ID:MIME-Version;
	b=Tiw0dVdRKFiVI40ZS1IiHqnm3ye7RAddVPrZtqyJkTkBnO9e9mpDkNW9r9+0KpfQ3
	 2jPKeSR0lbpmzoqn/OJa15UkBnFv4cA8c63WUjJhgPj0pSnYZhBj4rRskTawdjdqy9
	 jYZeMUl7D52mU/0h9I8pwI5e2FsGWbTbosxpaJ9sD/C8fEIQqSXxMecIfsLCz6nmeD
	 J+RC+KNpyF0ri7gkwH6wTZw6w/slcd9dHhy9rbGgk183Wp87A8qnfJ2Q2fHuNZS1tf
	 T4JebDhLBRN6h5xKajBzZeckeuxbb56Qf6eiVWAbrSueMXSO7vS8u5NVXZcg5xuyFM
	 sMIzWD2jfIJLQ==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 3C77D2E00DC; Tue, 16 Sep 2025 23:28:19 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: Ext4 Developers List <linux-ext4@vger.kernel.org>
Cc: "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH 3/3] tune2fs: try to use the SET_TUNE_SB_PARAM ioctl on mounted file systems
Date: Tue, 16 Sep 2025 23:28:14 -0400
Message-ID: <20250917032814.395887-4-tytso@mit.edu>
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

Try to uuse the new EXT4_IOC_GET_TUNE_SB_PARAM ioctl to update the
superblock if the file system is mounted.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 misc/tune2fs.c | 352 +++++++++++++++++++++++++++++++++++++------------
 1 file changed, 267 insertions(+), 85 deletions(-)

diff --git a/misc/tune2fs.c b/misc/tune2fs.c
index e752c328..b1ec3991 100644
--- a/misc/tune2fs.c
+++ b/misc/tune2fs.c
@@ -101,6 +101,64 @@ struct fsuuid {
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
+	__u16 encoding;
+	__u16 encoding_flags;
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
+#define EXT4_TUNE_FL_EDIT_FEATURES	0x00004000
+#define EXT4_TUNE_FL_FORCE_FSCK		0x00008000
+#define EXT4_TUNE_FL_ENCODING		0x00010000
+#define EXT4_TUNE_FL_ENCODING_FLAGS	0x00020000
+
+#define EXT4_IOC_GET_TUNE_SB_PARAM	_IOR('f', 45, struct ext4_tune_sb_params)
+#define EXT4_IOC_SET_TUNE_SB_PARAM	_IOW('f', 46, struct ext4_tune_sb_params)
+
+#endif
+
 extern int ask_yn(const char *string, int def);
 
 #define OPT_MAX_MOUNTCOUNT	 1
@@ -145,6 +203,8 @@ char *io_options;
 static int force, do_list_super, sparse_value = -1;
 static time_t last_check_time;
 static int max_mount_count, mount_count, mount_flags;
+static int fs_fd = -1;
+static char mntpt[PATH_MAX + 1];
 static unsigned long interval;
 static blk64_t reserved_blocks;
 static double reserved_ratio;
@@ -2052,6 +2112,10 @@ static void parse_tune2fs_options(int argc, char **argv)
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
@@ -2134,6 +2198,12 @@ static void parse_tune2fs_options(int argc, char **argv)
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
@@ -3105,73 +3175,204 @@ fs_update_journal_user(struct ext2_super_block *sb, __u8 old_uuid[UUID_SIZE])
 	return 0;
 }
 
-/*
- * Use FS_IOC_SETFSLABEL or FS_IOC_GETFSLABEL to set/get file system label
- * Return:	0 on success
- *		1 on error
- *		-1 when the old method should be used
- */
-static int handle_fslabel(int setlabel)
+static int get_mount_flags()
+{
+	errcode_t	ret;
+
+	ret = ext2fs_check_mount_point(device_name, &mount_flags,
+				       mntpt, sizeof(mntpt));
+	if (ret) {
+		com_err("ext2fs_check_mount_point", ret,
+			_("while determining whether %s is mounted."),
+			device_name);
+		return -1;
+	}
+
+#ifdef __linux__
+	if ((ret == 0) &&
+	    (mount_flags & EXT2_MF_MOUNTED) &&
+	    mntpt[0])
+		fs_fd = open(mntpt, O_RDONLY);
+#endif
+	return 0;
+}
+
+static int try_mounted_tune2fs()
 {
 #ifdef __linux__
 	errcode_t ret;
-	int mnt_flags, fd;
 	char label[FSLABEL_MAX];
-	unsigned int maxlen = FSLABEL_MAX - 1;
-	char mntpt[PATH_MAX + 1];
+	struct ext4_tune_sb_params params;
+	__u64 fs_blocks_count;
+	__u32 fs_feature_array[3], kernel_set_mask[3], kernel_clear_mask[3];
+	__u32 default_mnt_opts;
+	int fs_set_ops = 0;
 
-	ret = ext2fs_check_mount_point(device_name, &mnt_flags,
-					  mntpt, sizeof(mntpt));
-	if (ret)
-		return -1;
+	if (fs_fd < 0)
+		return 0;
 
-	if (!(mnt_flags & EXT2_MF_MOUNTED) ||
-	    (setlabel && (mnt_flags & EXT2_MF_READONLY)))
-		return -1;
+	if (opts[OPT_PRINT_LABEL] &&
+	    !ioctl(fs_fd, FS_IOC_GETFSLABEL, &label)) {
+		printf("%.*s\n", EXT2_LEN_STR(label));
+		opts[OPT_PRINT_LABEL] = false;
+	}
 
-	if (!mntpt[0])
-		return -1;
+	if (mount_flags & EXT2_MF_READONLY)
+		return 0;
 
-	fd = open(mntpt, O_RDONLY);
-	if (fd < 0)
-		return -1;
+	if (opts[OPT_LABEL]) {
+		unsigned int maxlen = FSLABEL_MAX - 1;
 
-	/* Get fs label */
-	if (!setlabel) {
-		if (ioctl(fd, FS_IOC_GETFSLABEL, &label)) {
-			close(fd);
-			if (errno == ENOTTY)
-				return -1;
-			com_err(mntpt, errno, _("while trying to get fs label"));
-			return 1;
+		/* If it's extN file system, truncate the label
+		   to appropriate size */
+		if (mount_flags & EXT2_MF_EXTFS)
+			maxlen = EXT2_LABEL_LEN;
+		if (strlen(new_label) > maxlen) {
+			fputs(_("Warning: label too long, truncating.\n"),
+			      stderr);
+			new_label[maxlen] = '\0';
 		}
-		close(fd);
-		printf("%.*s\n", EXT2_LEN_STR(label));
-		return 0;
+		if (ioctl(fs_fd, FS_IOC_SETFSLABEL, new_label) == 0)
+			opts[OPT_LABEL] = false;
 	}
 
-	/* If it's extN file system, truncate the label to appropriate size */
-	if (mnt_flags & EXT2_MF_EXTFS)
-		maxlen = EXT2_LABEL_LEN;
-	if (strlen(new_label) > maxlen) {
-		fputs(_("Warning: label too long, truncating.\n"),
-		      stderr);
-		new_label[maxlen] = '\0';
-	}
+	if (ioctl(fs_fd, EXT4_IOC_GET_TUNE_SB_PARAM, &params))
+		return 0;
 
-	/* Set fs label */
-	if (ioctl(fd, FS_IOC_SETFSLABEL, new_label)) {
-		close(fd);
-		if (errno == ENOTTY)
+	fs_set_ops = params.set_flags;
+	fs_blocks_count = params.blocks_count;
+	fs_feature_array[0] = params.feature_compat;
+	fs_feature_array[1] = params.feature_incompat;
+	fs_feature_array[2] = params.feature_ro_compat;
+	kernel_set_mask[0] = params.set_feature_compat_mask;
+	kernel_set_mask[1] = params.set_feature_incompat_mask;
+	kernel_set_mask[2] = params.set_feature_ro_compat_mask;
+	kernel_clear_mask[0] = params.clear_feature_compat_mask;
+	kernel_clear_mask[1] = params.clear_feature_incompat_mask;
+	kernel_clear_mask[2] = params.clear_feature_ro_compat_mask;
+	default_mnt_opts = params.default_mnt_opts;
+
+	memset(&params, 0, sizeof(params));
+
+#define SIMPLE_SET_PARAM(OPT, FLAG, PARAM_FIELD, VALUE) \
+	if (opts[OPT] && (fs_set_ops & FLAG)) { 	\
+		params.set_flags |= FLAG; 		\
+		params.PARAM_FIELD = VALUE;		\
+	}
+	SIMPLE_SET_PARAM(OPT_ERROR_BEHAVIOR, EXT4_TUNE_FL_ERRORS_BEHAVIOR,
+			 errors_behavior, errors);
+	SIMPLE_SET_PARAM(OPT_MOUNTCOUNT, EXT4_TUNE_FL_MNT_COUNT,
+			 set_flags, mount_count);
+	SIMPLE_SET_PARAM(OPT_MAX_MOUNTCOUNT, EXT4_TUNE_FL_MAX_MNT_COUNT,
+			 set_flags, max_mount_count);
+	SIMPLE_SET_PARAM(OPT_CHECKINTERVAL, EXT4_TUNE_FL_CHECKINTRVAL,
+			 set_flags, interval);
+	SIMPLE_SET_PARAM(OPT_CHECKTIME, EXT4_TUNE_FL_LAST_CHECK_TIME,
+			 last_check_time, last_check_time);
+	SIMPLE_SET_PARAM(OPT_RESUID, EXT4_TUNE_FL_RESERVED_UID,
+			 reserved_uid, resuid);
+	SIMPLE_SET_PARAM(OPT_RESGID, EXT4_TUNE_FL_RESERVED_GID,
+			 reserved_gid, resgid);
+	if (opts[OPT_RESERVED_RATIO] && !opts[OPT_RESERVED_BLOCKS]) {
+		reserved_blocks = reserved_ratio * fs_blocks_count / 100.0;
+		opts[OPT_RESERVED_BLOCKS] = true;
+	}
+	SIMPLE_SET_PARAM(OPT_RESERVED_BLOCKS, EXT4_TUNE_FL_RESERVED_BLOCKS,
+			 reserved_blocks, reserved_blocks);
+	SIMPLE_SET_PARAM(OPT_RAID_STRIDE, EXT4_TUNE_FL_RAID_STRIDE,
+			 raid_stride, stride);
+	SIMPLE_SET_PARAM(OPT_RAID_STRIPE_WIDTH, EXT4_TUNE_FL_RAID_STRIPE_WIDTH,
+			 raid_stripe_width, stripe_width);
+	SIMPLE_SET_PARAM(OPT_ENCODING, EXT4_TUNE_FL_ENCODING,
+			encoding, encoding);
+	SIMPLE_SET_PARAM(OPT_ENCODING_FLAGS, EXT4_TUNE_FL_ENCODING_FLAGS,
+			encoding_flags, encoding_flags);
+	if (opts[OPT_MNTOPTS] &&
+	    (fs_set_ops & EXT4_TUNE_FL_DEFAULT_MNT_OPTS)) {
+		if (e2p_edit_mntopts(mntopts_cmd, &default_mnt_opts, ~0)) {
+			fprintf(stderr, _("Invalid mount option set: %s\n"),
+				mntopts_cmd);
 			return -1;
-		com_err(mntpt, errno, _("while trying to set fs label"));
-		return 1;
+		}
+		params.set_flags |= EXT4_TUNE_FL_DEFAULT_MNT_OPTS;
+		params.default_mnt_opts = default_mnt_opts;
+	}
+	if (opts[OPT_MOUNT_OPTS] &&
+	    (fs_set_ops & EXT4_TUNE_FL_MOUNT_OPTS)) {
+		params.set_flags |= EXT4_TUNE_FL_MOUNT_OPTS;
+		strncpy(params.mount_opts, ext_mount_opts,
+			sizeof(params.mount_opts));
+		params.mount_opts[sizeof(params.mount_opts) - 1] = 0;
+	}
+	if (opts[OPT_FEATURES] &&
+	    (fs_set_ops & EXT4_TUNE_FL_FEATURES) &&
+	    !e2p_edit_feature2(features_cmd, fs_feature_array,
+			       kernel_set_mask, kernel_clear_mask,
+			       NULL, NULL)) {
+		params.set_flags |= EXT4_TUNE_FL_FEATURES;
+		params.feature_compat = fs_feature_array[0];
+		params.feature_incompat = fs_feature_array[1];
+		params.feature_ro_compat = fs_feature_array[2];
+	}
+	if (opts[OPT_FORCE_FSCK] &&
+	    (fs_set_ops & EXT4_TUNE_FL_FORCE_FSCK))
+		params.set_flags |= EXT4_TUNE_FL_FORCE_FSCK;
+
+	if (ioctl(fs_fd, EXT4_IOC_SET_TUNE_SB_PARAM, &params) == 0) {
+		if (opts[OPT_ERROR_BEHAVIOR])
+			printf(_("Setting error behavior to %d\n"), errors);
+		if (opts[OPT_MOUNTCOUNT])
+			printf(_("Setting current mount count to %d\n"),
+			       mount_count);
+		if (opts[OPT_MAX_MOUNTCOUNT])
+			printf(_("Setting maximal mount count to %d\n"),
+			       max_mount_count);
+		if (opts[OPT_CHECKINTERVAL])
+			printf(_("Setting interval between checks to %lu seconds\n"),
+			       interval);
+		if (opts[OPT_CHECKTIME])
+			printf(_("Setting time filesystem last checked to %s\n"),
+			       ctime(&last_check_time));
+		if (opts[OPT_RESUID])
+			printf(_("Setting reserved blocks uid to %lu\n"),
+			       resuid);
+		if (opts[OPT_RESGID])
+			printf(_("Setting reserved blocks gid to %lu\n"),
+			       resgid);
+		if (opts[OPT_RESERVED_BLOCKS])
+			printf(_("Setting reserved blocks count to %llu\n"),
+			       (unsigned long long) reserved_blocks);
+		if (opts[OPT_RAID_STRIDE])
+			printf(_("Setting stride size to %d\n"), stride);
+		if (opts[OPT_RAID_STRIPE_WIDTH])
+			printf(_("Setting stripe width to %d\n"),
+			       stripe_width);
+		if (opts[OPT_MOUNT_OPTS])
+			printf(_("Setting extended default mount options to '%s'\n"),
+			       ext_mount_opts);
+		if (opts[OPT_ENCODING])
+			printf(_("Setting encoding to '%s'\n"), encoding_str);
+		if (opts[OPT_ENCODING_FLAGS])
+			printf(_("Setting encoding_flags to '%s'\n"),
+			       encoding_flags_str);
+		if (opts[OPT_FORCE_FSCK])
+			printf(_("Setting filesystem error flag to force fsck.\n"));
+		opts[OPT_ERROR_BEHAVIOR] = opts[OPT_MOUNTCOUNT] =
+			opts[OPT_MAX_MOUNTCOUNT] = opts[OPT_CHECKINTERVAL] =
+			opts[OPT_CHECKTIME] = opts[OPT_RESUID] =
+			opts[OPT_RESGID] = opts[OPT_RESERVED_RATIO] =
+			opts[OPT_RESERVED_BLOCKS] = opts[OPT_MNTOPTS] =
+			opts[OPT_RAID_STRIDE] = opts[OPT_RAID_STRIPE_WIDTH] =
+			opts[OPT_MOUNT_OPTS] = opts[OPT_FEATURES] =
+			opts[OPT_FORCE_FSCK] = opts[OPT_ENCODING] =
+			opts[OPT_ENCODING_FLAGS] = false;
+		printf("online tune superblock succeeded\n");
+	} else {
+		perror("ioctl EXT4_IOC_SET_TUNE_SB_PARAM");
+		return -1;
 	}
-	close(fd);
-	return 0;
-#else
-	return -1;
 #endif
+	return 0;
 }
 
 #ifndef BUILD_AS_LIB
@@ -3186,7 +3387,6 @@ int tune2fs_main(int argc, char **argv)
 	io_manager io_ptr, io_ptr_orig = NULL;
 	int rc = 0;
 	char default_undo_file[1] = { 0 };
-	char mntpt[PATH_MAX + 1] = { 0 };
 	int fd = -1;
 	struct fsuuid *fsuuid = NULL;
 
@@ -3220,19 +3420,21 @@ int tune2fs_main(int argc, char **argv)
 #endif
 		io_ptr = unix_io_manager;
 
-	/*
-	 * Try the get/set fs label using ioctls before we even attempt
-	 * to open the file system.
-	 */
-	if (opts[OPT_LABEL] || opts[OPT_PRINT_LABEL]) {
-		rc = handle_fslabel(opts[OPT_LABEL]);
-		if (rc != -1) {
-#ifndef BUILD_AS_LIB
-			exit(rc);
+	if (get_mount_flags() < 0 || try_mounted_tune2fs() << 0) {
+#ifdef BUILD_AS_LIB
+		return -1;
+#else
+		exit(1);
+#endif
+	}
+
+	if (!tune_opts_requested()) {
+		/* printf("No further tune opts left\n"); */
+#ifdef BUILD_AS_LIB
+		return 0;
+#else
+		exit(0);
 #endif
-			return rc;
-		}
-		rc = 0;
 	}
 
 retry_open:
@@ -3338,16 +3540,6 @@ retry_open:
 		goto closefs;
 	}
 
-	retval = ext2fs_check_mount_point(device_name, &mount_flags,
-					mntpt, sizeof(mntpt));
-	if (retval) {
-		com_err("ext2fs_check_mount_point", retval,
-			_("while determining whether %s is mounted."),
-			device_name);
-		rc = 1;
-		goto closefs;
-	}
-
 #ifdef NO_RECOVERY
 	/* Warn if file system needs recovery and it is opened for writing. */
 	if ((open_flag & EXT2_FLAG_RW) && !(mount_flags & EXT2_MF_MOUNTED) &&
@@ -3382,9 +3574,6 @@ _("Warning: The journal is dirty. You may wish to replay the journal like:\n\n"
 	fs->flags |= EXT2_FLAG_SUPER_ONLY;
 
 	if (opts[OPT_MAX_MOUNTCOUNT]) {
-		if (max_mount_count == 65536)
-			max_mount_count = EXT2_DFL_MAX_MNT_COUNT +
-				(random() % EXT2_DFL_MAX_MNT_COUNT);
 		sb->s_max_mnt_count = max_mount_count;
 		ext2fs_mark_super_dirty(fs);
 		printf(_("Setting maximal mount count to %d\n"),
@@ -3410,13 +3599,6 @@ _("Warning: The journal is dirty. You may wish to replay the journal like:\n\n"
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
@@ -3494,7 +3676,7 @@ _("Warning: The journal is dirty. You may wish to replay the journal like:\n\n"
 			sizeof(sb->s_last_mounted));
 		ext2fs_mark_super_dirty(fs);
 	}
-	if (mntopts_cmd) {
+	if (opts[OPT_MNTOPTS]) {
 		rc = update_mntopts(fs, mntopts_cmd);
 		if (rc)
 			goto closefs;
-- 
2.51.0


