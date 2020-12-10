Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7CBC2D6432
	for <lists+linux-ext4@lfdr.de>; Thu, 10 Dec 2020 18:58:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393000AbgLJR5x (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 10 Dec 2020 12:57:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392993AbgLJR53 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 10 Dec 2020 12:57:29 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8124C061793
        for <linux-ext4@vger.kernel.org>; Thu, 10 Dec 2020 09:56:43 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id c12so4428554pgm.4
        for <linux-ext4@vger.kernel.org>; Thu, 10 Dec 2020 09:56:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2GmmxsOZ9jmCjpAwXCPH8boxgLJISw/wKtQFVlshFPw=;
        b=vNLrZFFhdaLoy9Q3O6eo5pOHOeLrIFrECLtus2tbqik+rTYxRyAvxEcMaPWlI4+HId
         GmSOwSUfRMaPtmsdANwbEaomHd0lRR+KE54an413a/vAeKLUQ9mdn4NFdnbR72vxNhYi
         UjRKl95oGLzSoKNJfJE5w1n2TfnPF+JjjwRqMEavDkONGEWXx67zZ7Uscwl6q0oQChF0
         Al9cT5z/SvSLwL5rTTO1IzsTWhF0uJYC33JNBdynFsH7Lwzq7zoPSUAzcH7oyyUHJ8yy
         2NpMAhtaEyyJrVa3aL3qbYfoLz+0WSZomX3I+v0cSX/JUUZ4UhYwjhIFRcDFMvCKfUj9
         vcjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2GmmxsOZ9jmCjpAwXCPH8boxgLJISw/wKtQFVlshFPw=;
        b=dKeHEVVGtpKNv2XUKaudwiP4BlR/psRwoP/imnZxIj1e21vuwxdREbylHrBAdUVjau
         +s3aMN/auJeigRaQSqpdZZZgfwoyONQyj98dyv7e70u2dQ9rTc8mYhISvQ4Ol9nDKSpJ
         BU92sntv0dZA6E0RLxZ6JIPFuAMGtsUvhxQL9JtpQBdLQoMybQwn0IYv2DBJHjAUOCf0
         DcwYvYJm7cyuR+JgGVH0EY3s9sm0s33VP1zoscLMyu7ANWKrzz9P/V4KkdrWKA2s18nC
         Rr7l/GcMaNURVKkJxJ/+3utmZjlRXNPmr4ekVGhk+WgUS7hx+jAnm1E5hOAF1wavvPnb
         4PBg==
X-Gm-Message-State: AOAM532DWV79TTgf01ot7bO5PziDBfS6l05wMbyfcXD/y2MAyS3fqtlh
        UppxzII3W7l3LYTX2VVjZeXqOJ37AuY=
X-Google-Smtp-Source: ABdhPJzxBXI/N2TvCzYAa7h5VPQ1ejvZV6c1vZY2dzaAwunI1717pSul2mjeq1YRZVDgiZTOHSDH0A==
X-Received: by 2002:a62:5a44:0:b029:19e:1324:c878 with SMTP id o65-20020a625a440000b029019e1324c878mr7752270pfb.65.1607623002704;
        Thu, 10 Dec 2020 09:56:42 -0800 (PST)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:a6ae:11ff:fe11:86a2])
        by smtp.googlemail.com with ESMTPSA id u24sm7433517pfm.81.2020.12.10.09.56.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 09:56:41 -0800 (PST)
From:   harshadshirwadkar@gmail.com
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v2 05/15] e2fsprogs: make userspace tools number of fast commits blocks aware
Date:   Thu, 10 Dec 2020 09:55:58 -0800
Message-Id: <20201210175608.3265541-6-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
In-Reply-To: <20201210175608.3265541-1-harshadshirwadkar@gmail.com>
References: <20201210175608.3265541-1-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

This patch makes number of fast commit blocks configurable. Also, the
number of fast commit blocks can now be seen in dumpe2fs output.

$ ./misc/mke2fs -O fast_commit -t ext4 image
mke2fs 1.46-WIP (20-Mar-2020)
Discarding device blocks: done
Creating filesystem with 5120 1k blocks and 1280 inodes
Allocating group tables: done
Writing inode tables: done
Creating journal (1040 blocks): done
Writing superblocks and filesystem accounting information: done

$ ./misc/dumpe2fs image
dumpe2fs 1.46-WIP (20-Mar-2020)
...
Journal features:         (none)
Total journal size:       1040k
Total journal blocks:     1040
Max transaction length:   1024
Fast commit length:       16
Journal sequence:         0x00000001
Journal start:            0

$ ./misc/mke2fs -O fast_commit -t ext4 image -J fast_commit_size=256,size=1
mke2fs 1.46-WIP (20-Mar-2020)
Creating filesystem with 5120 1k blocks and 1280 inodes
Allocating group tables: done
Writing inode tables: done
Creating journal (1280 blocks): done
Writing superblocks and filesystem accounting information: done

$ ./misc/dumpe2fs image
dumpe2fs 1.46-WIP (20-Mar-2020)
...
Journal features:         (none)
Total journal size:       1280k
Total journal blocks:     1280
Max transaction length:   1024
Fast commit length:       256
Journal sequence:         0x00000001
Journal start:            0

This patch also adds information about fast commit feature in mke2fs
and tune2fs man pages.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 e2fsck/unix.c     | 26 +++++++++++++-------
 misc/dumpe2fs.c   | 10 ++++++--
 misc/mke2fs.8.in  | 21 ++++++++++++++++
 misc/mke2fs.c     | 26 +++++++++++++-------
 misc/tune2fs.8.in | 25 +++++++++++++++++++
 misc/tune2fs.c    |  8 +++----
 misc/util.c       | 61 ++++++++++++++++++++++++++++++++++-------------
 misc/util.h       |  4 +++-
 8 files changed, 142 insertions(+), 39 deletions(-)

diff --git a/e2fsck/unix.c b/e2fsck/unix.c
index 1cb51672..bf66605a 100644
--- a/e2fsck/unix.c
+++ b/e2fsck/unix.c
@@ -1394,6 +1394,7 @@ int main (int argc, char *argv[])
 	__u32 features[3];
 	char *cp;
 	enum quota_type qtype;
+	struct ext2fs_journal_params jparams;
 
 	clear_problem_context(&pctx);
 	sigcatcher_setup();
@@ -1887,9 +1888,15 @@ print_unsupp_features:
 	/*
 	 * Save the journal size in megabytes.
 	 * Try and use the journal size from the backup else let e2fsck
-	 * find the default journal size.
+	 * find the default journal size. If fast commit feature is enabled,
+	 * it is not clear how many of the journal blocks were fast commit
+	 * blocks. So, ignore the size of journal found in backup.
+	 *
+	 * TODO: Add a new backup type that captures fast commit info as
+	 * well.
 	 */
-	if (sb->s_jnl_backup_type == EXT3_JNL_BACKUP_BLOCKS)
+	if (sb->s_jnl_backup_type == EXT3_JNL_BACKUP_BLOCKS &&
+		!ext2fs_has_feature_fast_commit(sb))
 		journal_size = (sb->s_jnl_blocks[15] << (32 - 20)) |
 			       (sb->s_jnl_blocks[16] >> 20);
 	else
@@ -1911,9 +1918,13 @@ print_unsupp_features:
 	if (!ctx->invalid_bitmaps &&
 	    (ctx->flags & E2F_FLAG_JOURNAL_INODE)) {
 		if (fix_problem(ctx, PR_6_RECREATE_JOURNAL, &pctx)) {
-			if (journal_size < 1024)
-				journal_size = ext2fs_default_journal_size(ext2fs_blocks_count(fs->super));
-			if (journal_size < 0) {
+			if (journal_size < 1024) {
+				ext2fs_get_journal_params(&jparams, fs);
+			} else {
+				jparams.num_journal_blocks = journal_size;
+				jparams.num_fc_blocks = 0;
+			}
+			if (jparams.num_journal_blocks < 0) {
 				ext2fs_clear_feature_journal(fs->super);
 				fs->flags &= ~EXT2_FLAG_MASTER_SB_ONLY;
 				log_out(ctx, "%s: Couldn't determine "
@@ -1921,10 +1932,9 @@ print_unsupp_features:
 				goto no_journal;
 			}
 			log_out(ctx, _("Creating journal (%d blocks): "),
-			       journal_size);
+			       jparams.num_journal_blocks);
 			fflush(stdout);
-			retval = ext2fs_add_journal_inode(fs,
-							  journal_size, 0);
+			retval = ext2fs_add_journal_inode3(fs, &jparams, ~0ULL, 0);
 			if (retval) {
 				log_out(ctx, "%s: while trying to create "
 					"journal\n", error_message(retval));
diff --git a/misc/dumpe2fs.c b/misc/dumpe2fs.c
index d295ba4d..e24dc4e6 100644
--- a/misc/dumpe2fs.c
+++ b/misc/dumpe2fs.c
@@ -364,6 +364,7 @@ static void print_inline_journal_information(ext2_filsys fs)
 	errcode_t		retval;
 	ext2_ino_t		ino = fs->super->s_journal_inum;
 	char			buf[1024];
+	int			flags;
 
 	if (fs->flags & EXT2_FLAG_IMAGE_FILE)
 		return;
@@ -392,7 +393,9 @@ static void print_inline_journal_information(ext2_filsys fs)
 			_("Journal superblock magic number invalid!\n"));
 		exit(1);
 	}
-	e2p_list_journal_super(stdout, buf, fs->blocksize, 0);
+	flags = ext2fs_has_feature_fast_commit(fs->super) ?
+			E2P_LIST_JOURNAL_FLAG_FC : 0;
+	e2p_list_journal_super(stdout, buf, fs->blocksize, flags);
 }
 
 static void print_journal_information(ext2_filsys fs)
@@ -400,6 +403,7 @@ static void print_journal_information(ext2_filsys fs)
 	errcode_t	retval;
 	char		buf[1024];
 	journal_superblock_t	*jsb;
+	int		flags;
 
 	/* Get the journal superblock */
 	if ((retval = io_channel_read_blk64(fs->io,
@@ -417,7 +421,9 @@ static void print_journal_information(ext2_filsys fs)
 			_("Couldn't find journal superblock magic numbers"));
 		exit(1);
 	}
-	e2p_list_journal_super(stdout, buf, fs->blocksize, 0);
+	flags = ext2fs_has_feature_fast_commit(fs->super) ?
+			E2P_LIST_JOURNAL_FLAG_FC : 0;
+	e2p_list_journal_super(stdout, buf, fs->blocksize, flags);
 }
 
 static int check_mmp(ext2_filsys fs)
diff --git a/misc/mke2fs.8.in b/misc/mke2fs.8.in
index e6bfc6d6..2833b408 100644
--- a/misc/mke2fs.8.in
+++ b/misc/mke2fs.8.in
@@ -521,6 +521,27 @@ The size of the journal must be at least 1024 filesystem blocks
 and may be no more than 10,240,000 filesystem blocks or half the total
 file system size (whichever is smaller)
 .TP
+.BI fast_commit_size= fast-commit-size
+Create an additional fast commit journal area of size
+.I fast-commit-size
+kilobytes.
+This option is only valid if
+.B fast_commit
+feature is enabled
+on the file system. If this option is not specified and if
+.B fast_commit
+feature is turned on, fast commit area size defaults to
+.I journal-size
+/ 64 megabytes. The total size of the journal with
+.B fast_commit
+feature set is
+.I journal-size
++ (
+.I fast-commit-size
+* 1024) megabytes. The total journal size may be no more than
+10,240,000 filesystem blocks or half the total file system size
+(whichever is smaller).
+.TP
 .BI location =journal-location
 Specify the location of the journal.  The argument
 .I journal-location
diff --git a/misc/mke2fs.c b/misc/mke2fs.c
index 8c8f5ea4..d7ce7c9d 100644
--- a/misc/mke2fs.c
+++ b/misc/mke2fs.c
@@ -93,6 +93,7 @@ static uid_t	root_uid;
 static gid_t	root_gid;
 int	journal_size;
 int	journal_flags;
+int	journal_fc_size;
 static int	lazy_itable_init;
 static int	packed_meta_blocks;
 int		no_copy_xattrs;
@@ -604,9 +605,16 @@ static void create_journal_dev(ext2_filsys fs)
 	char			*buf;
 	blk64_t			blk, err_blk;
 	int			c, count, err_count;
+	struct ext2fs_journal_params	jparams;
 
-	retval = ext2fs_create_journal_superblock(fs,
-				  ext2fs_blocks_count(fs->super), 0, &buf);
+	retval = ext2fs_get_journal_params(&jparams, fs);
+	if (retval) {
+		com_err("create_journal_dev", retval, "%s",
+			_("while splitting the journal size"));
+		exit(1);
+	}
+
+	retval = ext2fs_create_journal_superblock2(fs, &jparams, 0, &buf);
 	if (retval) {
 		com_err("create_journal_dev", retval, "%s",
 			_("while initializing journal superblock"));
@@ -1753,6 +1761,8 @@ profile_error:
 		case 'j':
 			if (!journal_size)
 				journal_size = -1;
+			if (!journal_fc_size)
+				journal_fc_size = -1;
 			break;
 		case 'J':
 			parse_journal_opts(optarg);
@@ -2937,7 +2947,7 @@ int main (int argc, char *argv[])
 	badblocks_list	bb_list = 0;
 	badblocks_iterate	bb_iter;
 	blk_t		blk;
-	unsigned int	journal_blocks = 0;
+	struct ext2fs_journal_params	jparams = {0};
 	unsigned int	i, checkinterval;
 	int		max_mnt_count;
 	int		val, hash_alg;
@@ -3047,7 +3057,7 @@ int main (int argc, char *argv[])
 	/* Calculate journal blocks */
 	if (!journal_device && ((journal_size) ||
 	    ext2fs_has_feature_journal(&fs_param)))
-		journal_blocks = figure_journal_size(journal_size, fs);
+		figure_journal_size(&jparams, journal_size, journal_fc_size, fs);
 
 	sprintf(opt_string, "tdb_data_size=%d", fs->blocksize <= 4096 ?
 		32768 : fs->blocksize * 8);
@@ -3382,23 +3392,23 @@ int main (int argc, char *argv[])
 		free(journal_device);
 	} else if ((journal_size) ||
 		   ext2fs_has_feature_journal(&fs_param)) {
-		overhead += EXT2FS_NUM_B2C(fs, journal_blocks);
+		overhead += EXT2FS_NUM_B2C(fs, jparams.num_journal_blocks + jparams.num_fc_blocks);
 		if (super_only) {
 			printf("%s", _("Skipping journal creation in super-only mode\n"));
 			fs->super->s_journal_inum = EXT2_JOURNAL_INO;
 			goto no_journal;
 		}
 
-		if (!journal_blocks) {
+		if (!jparams.num_journal_blocks) {
 			ext2fs_clear_feature_journal(fs->super);
 			goto no_journal;
 		}
 		if (!quiet) {
 			printf(_("Creating journal (%u blocks): "),
-			       journal_blocks);
+			       jparams.num_journal_blocks + jparams.num_fc_blocks);
 			fflush(stdout);
 		}
-		retval = ext2fs_add_journal_inode2(fs, journal_blocks,
+		retval = ext2fs_add_journal_inode3(fs, &jparams,
 						   journal_location,
 						   journal_flags);
 		if (retval) {
diff --git a/misc/tune2fs.8.in b/misc/tune2fs.8.in
index 582d1da5..2114c623 100644
--- a/misc/tune2fs.8.in
+++ b/misc/tune2fs.8.in
@@ -357,6 +357,27 @@ and may be no more than 10,240,000 filesystem blocks.
 There must be enough free space in the filesystem to create a journal of
 that size.
 .TP
+.BI fast_commit_size= fast-commit-size
+Create an additional fast commit journal area of size
+.I fast-commit-size
+kilobytes.
+This option is only valid if
+.B fast_commit
+feature is enabled
+on the file system. If this option is not specified and if
+.B fast_commit
+feature is turned on, fast commit area size defaults to
+.I journal-size
+/ 64 megabytes. The total size of the journal with
+.B fast_commit
+feature set is
+.I journal-size
++ (
+.I fast-commit-size
+* 1024) megabytes. The total journal size may be no more than
+10,240,000 filesystem blocks or half the total file system size
+(whichever is smaller).
+.TP
 .BI location =journal-location
 Specify the location of the journal.  The argument
 .I journal-location
@@ -586,6 +607,10 @@ Setting the filesystem feature is equivalent to using the
 .B \-j
 option.
 .TP
+.TP
+.B fast_commit
+Enable fast commit journaling feature to improve fsync latency.
+.TP
 .B large_dir
 Increase the limit on the number of files per directory.
 .B Tune2fs
diff --git a/misc/tune2fs.c b/misc/tune2fs.c
index 670ed9e0..2307f18a 100644
--- a/misc/tune2fs.c
+++ b/misc/tune2fs.c
@@ -102,7 +102,7 @@ static int feature_64bit;
 static int fsck_requested;
 static char *undo_file;
 
-int journal_size, journal_flags;
+int journal_size, journal_fc_size, journal_flags;
 char *journal_device;
 static blk64_t journal_location = ~0LL;
 
@@ -1543,7 +1543,7 @@ mmp_error:
  */
 static int add_journal(ext2_filsys fs)
 {
-	unsigned long journal_blocks;
+	struct ext2fs_journal_params	jparams;
 	errcode_t	retval;
 	ext2_filsys	jfs;
 	io_manager	io_ptr;
@@ -1589,13 +1589,13 @@ static int add_journal(ext2_filsys fs)
 	} else if (journal_size) {
 		fputs(_("Creating journal inode: "), stdout);
 		fflush(stdout);
-		journal_blocks = figure_journal_size(journal_size, fs);
+		figure_journal_size(&jparams, journal_size, journal_fc_size, fs);
 
 		if (journal_location_string)
 			journal_location =
 				parse_num_blocks2(journal_location_string,
 						  fs->super->s_log_block_size);
-		retval = ext2fs_add_journal_inode2(fs, journal_blocks,
+		retval = ext2fs_add_journal_inode3(fs, &jparams,
 						   journal_location,
 						   journal_flags);
 		if (retval) {
diff --git a/misc/util.c b/misc/util.c
index dcd2f0a7..48e623dc 100644
--- a/misc/util.c
+++ b/misc/util.c
@@ -200,6 +200,14 @@ void parse_journal_opts(const char *opts)
 			journal_size = strtoul(arg, &p, 0);
 			if (*p)
 				journal_usage++;
+		} else if (strcmp(token, "fast_commit_size") == 0) {
+			if (!arg) {
+				journal_usage++;
+				continue;
+			}
+			journal_fc_size = strtoul(arg, &p, 0);
+			if (*p)
+				journal_usage++;
 		} else if (!strcmp(token, "location")) {
 			if (!arg) {
 				journal_usage++;
@@ -229,42 +237,63 @@ void parse_journal_opts(const char *opts)
 	free(buf);
 }
 
+static inline int jsize_to_blks(ext2_filsys fs, int size)
+{
+	return (size * 1024) / (fs->blocksize / 1024);
+}
+
+/* Fast commit size is in KBs */
+static inline int fcsize_to_blks(ext2_filsys fs, int size)
+{
+	return (size * 1024) / (fs->blocksize);
+}
+
 /*
  * Determine the number of journal blocks to use, either via
  * user-specified # of megabytes, or via some intelligently selected
  * defaults.
  *
- * Find a reasonable journal file size (in blocks) given the number of blocks
- * in the filesystem.  For very small filesystems, it is not reasonable to
- * have a journal that fills more than half of the filesystem.
+ * Find a reasonable journal file size (in blocks) given the number of blocks in
+ * the filesystem. For very small filesystems, it is not reasonable to have a
+ * journal that fills more than half of the filesystem.
  */
-unsigned int figure_journal_size(int size, ext2_filsys fs)
+void figure_journal_size(struct ext2fs_journal_params *jparams,
+		int requested_j_size, int requested_fc_size, ext2_filsys fs)
 {
-	int j_blocks;
+	int total_blocks, ret;
 
-	j_blocks = ext2fs_default_journal_size(ext2fs_blocks_count(fs->super));
-	if (j_blocks < 0) {
+	ret = ext2fs_get_journal_params(jparams, fs);
+	if (ret) {
 		fputs(_("\nFilesystem too small for a journal\n"), stderr);
-		return 0;
+		return;
 	}
 
-	if (size > 0) {
-		j_blocks = size * 1024 / (fs->blocksize	/ 1024);
-		if (j_blocks < 1024 || j_blocks > 10240000) {
-			fprintf(stderr, _("\nThe requested journal "
+	if (requested_j_size > 0 ||
+		(ext2fs_has_feature_fast_commit(fs->super) && requested_fc_size > 0)) {
+		if (requested_j_size > 0)
+			jparams->num_journal_blocks =
+				jsize_to_blks(fs, requested_j_size);
+		if (ext2fs_has_feature_fast_commit(fs->super) &&
+			requested_fc_size > 0)
+			jparams->num_fc_blocks =
+				fcsize_to_blks(fs, requested_fc_size);
+		else if (!ext2fs_has_feature_fast_commit(fs->super))
+			jparams->num_fc_blocks = 0;
+		total_blocks = jparams->num_journal_blocks + jparams->num_fc_blocks;
+		if (total_blocks < 1024 || total_blocks > 10240000) {
+			fprintf(stderr, _("\nThe total requested journal "
 				"size is %d blocks; it must be\n"
 				"between 1024 and 10240000 blocks.  "
 				"Aborting.\n"),
-				j_blocks);
+				total_blocks);
 			exit(1);
 		}
-		if ((unsigned) j_blocks > ext2fs_free_blocks_count(fs->super) / 2) {
-			fputs(_("\nJournal size too big for filesystem.\n"),
+		if ((unsigned int) total_blocks > ext2fs_free_blocks_count(fs->super) / 2) {
+			fputs(_("\nTotal journal size too big for filesystem.\n"),
 			      stderr);
 			exit(1);
 		}
 	}
-	return j_blocks;
 }
 
 void print_check_message(int mnt, unsigned int check)
diff --git a/misc/util.h b/misc/util.h
index 49b4b9c1..ccdc7fbc 100644
--- a/misc/util.h
+++ b/misc/util.h
@@ -11,6 +11,7 @@
  */
 
 extern int	 journal_size;
+extern int	 journal_fc_size;
 extern int	 journal_flags;
 extern char	*journal_device;
 extern char	*journal_location_string;
@@ -22,6 +23,7 @@ extern char *get_progname(char *argv_zero);
 extern void proceed_question(int delay);
 extern void parse_journal_opts(const char *opts);
 extern void check_mount(const char *device, int force, const char *type);
-extern unsigned int figure_journal_size(int size, ext2_filsys fs);
+extern void figure_journal_size(struct ext2fs_journal_params *jparams,
+		int requested_j_size, int requested_fc_size, ext2_filsys fs);
 extern void print_check_message(int, unsigned int);
 extern void dump_mmp_msg(struct mmp_struct *mmp, const char *msg);
-- 
2.29.2.576.ga3fc446d84-goog

