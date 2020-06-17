Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A511B1FCCCA
	for <lists+linux-ext4@lfdr.de>; Wed, 17 Jun 2020 13:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbgFQLtE (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 17 Jun 2020 07:49:04 -0400
Received: from smtp-out-so.shaw.ca ([64.59.136.138]:56274 "EHLO
        smtp-out-so.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbgFQLtD (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 17 Jun 2020 07:49:03 -0400
X-Greylist: delayed 490 seconds by postgrey-1.27 at vger.kernel.org; Wed, 17 Jun 2020 07:49:02 EDT
Received: from cabot.adilger.int ([70.77.221.9])
        by shaw.ca with ESMTP
        id lWR0jTV8PYYpxlWR1jxsvd; Wed, 17 Jun 2020 05:40:51 -0600
X-Authority-Analysis: v=2.3 cv=OubUNx3t c=1 sm=1 tr=0
 a=2Y6h5+ypAxmHcsumz2f7Og==:117 a=2Y6h5+ypAxmHcsumz2f7Og==:17 a=ySfo2T4IAAAA:8
 a=zyRY2L8Ozvl1flCerP0A:9 a=ZUkhVnNHqyo2at-WnAgH:22
From:   Andreas Dilger <adilger@dilger.ca>
To:     tytso@mit.edu
Cc:     linux-ext4@vger.kernel.org, Andreas Dilger <adilger@whamcloud.com>
Subject: [PATCH] tune2fs: reset MMP state on error exit
Date:   Wed, 17 Jun 2020 05:40:49 -0600
Message-Id: <20200617114049.93821-1-adilger@dilger.ca>
X-Mailer: git-send-email 2.14.3 (Apple Git-98)
X-CMAE-Envelope: MS4wfKl7I065uLMiHZNtscdSxRxflF+TNzvPlTdAeO3Tm7wd0WGXT7gF42KAakkyknnlDNInU/dKcVq0mUI5SsoPe1B3APFCwN1jsHN8E5eoVohN2Yue0YZq
 OHayBmNfV7YqSBoX70z5ThftKNlzfnIi9JAYdWMRNDJlfoFemM56Go+zX5YME0xwcK31CfBrNbR2V836DnC87PfeYrm+tzwrECLUhTasecS02PbY3drRB78a
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Andreas Dilger <adilger@whamcloud.com>

If tune2fs cannot perform the requested change, ensure that the MMP
block is reset to the unused state before exiting.  Otherwise, the
filesystem will be left with mmp_seq = EXT4_MMP_SEQ_FSCK set, which
prevents it from being mounted afterward:

    EXT4-fs warning (device dm-9): ext4_multi_mount_protect:311:
        fsck is running on the filesystem

Add a test to try some failed tune2fs operations and verify that the
MMP block is left in a clean state afterward.

Lustre-bug-id: https://jira.whamcloud.com/browse/LU-13672
Signed-off-by: Andreas Dilger <adilger@whamcloud.com>
---
 misc/tune2fs.c                | 84 ++++++++++++++++++++++++-------------------
 tests/t_mmp_2off/script       |  4 +--
 tests/t_mmp_fail/is_slow_test |  0
 tests/t_mmp_fail/name         |  1 +
 tests/t_mmp_fail/script       | 44 +++++++++++++++++++++++
 5 files changed, 95 insertions(+), 38 deletions(-)
 create mode 100644 tests/t_mmp_fail/is_slow_test
 create mode 100644 tests/t_mmp_fail/name
 create mode 100644 tests/t_mmp_fail/script

diff --git a/misc/tune2fs.c b/misc/tune2fs.c
index 39cf85877b28..a481d8f31270 100644
--- a/misc/tune2fs.c
+++ b/misc/tune2fs.c
@@ -423,7 +423,7 @@ static int update_mntopts(ext2_filsys fs, char *mntopts)
 	return 0;
 }
 
-static void check_fsck_needed(ext2_filsys fs, const char *prompt)
+static int check_fsck_needed(ext2_filsys fs, const char *prompt)
 {
 	/* Refuse to modify anything but a freshly checked valid filesystem. */
 	if (!(fs->super->s_state & EXT2_VALID_FS) ||
@@ -433,15 +433,17 @@ static void check_fsck_needed(ext2_filsys fs, const char *prompt)
 		puts(_(please_fsck));
 		if (mount_flags & EXT2_MF_READONLY)
 			printf("%s", _("(and reboot afterwards!)\n"));
-		exit(1);
+		return 1;
 	}
 
 	/* Give the admin a few seconds to bail out of a dangerous op. */
 	if (!getenv("TUNE2FS_FORCE_PROMPT") && (!isatty(0) || !isatty(1)))
-		return;
+		return 0;
 
 	puts(prompt);
 	proceed_question(5);
+
+	return 0;
 }
 
 static void request_dir_fsck_afterwards(ext2_filsys fs)
@@ -1224,12 +1226,13 @@ mmp_error:
 
 	if (FEATURE_ON(E2P_FEATURE_RO_INCOMPAT,
 		       EXT4_FEATURE_RO_COMPAT_METADATA_CSUM)) {
-		check_fsck_needed(fs,
-			_("Enabling checksums could take some time."));
+		if (check_fsck_needed(fs,
+			_("Enabling checksums could take some time.")))
+			return 1;
 		if (mount_flags & EXT2_MF_MOUNTED) {
 			fputs(_("Cannot enable metadata_csum on a mounted "
 				"filesystem!\n"), stderr);
-			exit(1);
+			return 1;
 		}
 		if (!ext2fs_has_feature_extents(fs->super))
 			printf("%s",
@@ -1265,12 +1268,13 @@ mmp_error:
 			EXT4_FEATURE_RO_COMPAT_METADATA_CSUM)) {
 		__u32	test_features[3];
 
-		check_fsck_needed(fs,
-			_("Disabling checksums could take some time."));
+		if (check_fsck_needed(fs,
+			_("Disabling checksums could take some time.")))
+			return 1;
 		if (mount_flags & EXT2_MF_MOUNTED) {
 			fputs(_("Cannot disable metadata_csum on a mounted "
 				"filesystem!\n"), stderr);
-			exit(1);
+			return 1;
 		}
 		rewrite_checksums = 1;
 
@@ -1311,7 +1315,7 @@ mmp_error:
 		if (mount_flags & EXT2_MF_MOUNTED) {
 			fputs(_("Cannot enable uninit_bg on a mounted "
 				"filesystem!\n"), stderr);
-			exit(1);
+			return 1;
 		}
 
 		/* Do not enable uninit_bg when metadata_csum enabled */
@@ -1326,7 +1330,7 @@ mmp_error:
 		if (mount_flags & EXT2_MF_MOUNTED) {
 			fputs(_("Cannot disable uninit_bg on a mounted "
 				"filesystem!\n"), stderr);
-			exit(1);
+			return 1;
 		}
 
 		err = disable_uninit_bg(fs,
@@ -1345,7 +1349,7 @@ mmp_error:
 		if (mount_flags & EXT2_MF_MOUNTED) {
 			fprintf(stderr, _("Cannot enable 64-bit mode "
 					  "while mounted!\n"));
-			exit(1);
+			return 1;
 		}
 		ext2fs_clear_feature_64bit(sb);
 		feature_64bit = 1;
@@ -1355,7 +1359,7 @@ mmp_error:
 		if (mount_flags & EXT2_MF_MOUNTED) {
 			fprintf(stderr, _("Cannot disable 64-bit mode "
 					  "while mounted!\n"));
-			exit(1);
+			return 1;
 		}
 		ext2fs_set_feature_64bit(sb);
 		feature_64bit = -1;
@@ -1385,7 +1389,7 @@ mmp_error:
 		if (fs->super->s_inode_size == EXT2_GOOD_OLD_INODE_SIZE) {
 			fprintf(stderr, _("Cannot enable project feature; "
 					  "inode size too small.\n"));
-			exit(1);
+			return 1;
 		}
 		Q_flag = 1;
 		quota_enable[PRJQUOTA] = QOPT_ENABLE;
@@ -1452,8 +1456,9 @@ mmp_error:
 				      stderr);
 				return 1;
 			}
-			check_fsck_needed(fs, _("Recalculating checksums "
-						"could take some time."));
+			if (check_fsck_needed(fs, _("Recalculating checksums "
+						     "could take some time.")))
+				return 1;
 			rewrite_checksums = 1;
 		}
 	}
@@ -1566,7 +1571,7 @@ err:
 	return 1;
 }
 
-static void handle_quota_options(ext2_filsys fs)
+static int handle_quota_options(ext2_filsys fs)
 {
 	errcode_t retval;
 	quota_ctx_t qctx;
@@ -1580,13 +1585,13 @@ static void handle_quota_options(ext2_filsys fs)
 			break;
 	if (qtype == MAXQUOTAS)
 		/* Nothing to do. */
-		return;
+		return 0;
 
 	if (quota_enable[PRJQUOTA] == QOPT_ENABLE &&
 	    fs->super->s_inode_size == EXT2_GOOD_OLD_INODE_SIZE) {
 		fprintf(stderr, _("Cannot enable project quota; "
 				  "inode size too small.\n"));
-		exit(1);
+		return 1;
 	}
 
 	for (qtype = 0; qtype < MAXQUOTAS; qtype++) {
@@ -1598,7 +1603,7 @@ static void handle_quota_options(ext2_filsys fs)
 	if (retval) {
 		com_err(program_name, retval,
 			_("while initializing quota context in support library"));
-		exit(1);
+		return 1;
 	}
 
 	if (qtype_bits)
@@ -1614,7 +1619,7 @@ static void handle_quota_options(ext2_filsys fs)
 					com_err(program_name, retval,
 						_("while updating quota limits (%d)"),
 						qtype);
-					exit(1);
+					return 1;
 				}
 			}
 			retval = quota_write_inode(qctx, 1 << qtype);
@@ -1622,7 +1627,7 @@ static void handle_quota_options(ext2_filsys fs)
 				com_err(program_name, retval,
 					_("while writing quota file (%d)"),
 					qtype);
-				exit(1);
+				return 1;
 			}
 			/* Enable Quota feature if one of quota enabled */
 			if (!ext2fs_has_feature_quota(fs->super)) {
@@ -1640,7 +1645,7 @@ static void handle_quota_options(ext2_filsys fs)
 				com_err(program_name, retval,
 					_("while removing quota file (%d)"),
 					qtype);
-				exit(1);
+				return 1;
 			}
 			if (qtype == PRJQUOTA) {
 				ext2fs_clear_feature_project(fs->super);
@@ -1663,7 +1668,7 @@ static void handle_quota_options(ext2_filsys fs)
 	}
 	if (need_dirty)
 		ext2fs_mark_super_dirty(fs);
-	return;
+	return 0;
 }
 
 static int option_handle_function(char *token)
@@ -2958,8 +2963,10 @@ retry_open:
 			rc = 1;
 			goto closefs;
 		}
-		check_fsck_needed(fs,
+		rc = check_fsck_needed(fs,
 			_("Resizing inodes could take some time."));
+		if (rc)
+			goto closefs;
 		/*
 		 * If inode resize is requested use the
 		 * Undo I/O manager
@@ -3015,16 +3022,16 @@ _("Warning: The journal is dirty. You may wish to replay the journal like:\n\n"
 	/* Recover the journal if possible. */
 	if ((open_flag & EXT2_FLAG_RW) && !(mount_flags & (EXT2_MF_BUSY | EXT2_MF_MOUNTED)) &&
 	    ext2fs_has_feature_journal_needs_recovery(fs->super)) {
-		errcode_t err;
-
 		printf(_("Recovering journal.\n"));
-		err = ext2fs_run_ext3_journal(&fs);
-		if (err) {
-			com_err("tune2fs", err, "while recovering journal.\n");
+		retval = ext2fs_run_ext3_journal(&fs);
+		if (retval) {
+			com_err("tune2fs", retval,
+				"while recovering journal.\n");
 			printf(_("Please run e2fsck -fy %s.\n"), argv[1]);
 			if (fs)
 				ext2fs_close_free(&fs);
-			exit(1);
+			rc = 1;
+			goto closefs;
 		}
 		sb = fs->super;
 	}
@@ -3128,13 +3135,13 @@ _("Warning: The journal is dirty. You may wish to replay the journal like:\n\n"
 			fputs(_("Warning: label too long, truncating.\n"),
 			      stderr);
 		memset(sb->s_volume_name, 0, sizeof(sb->s_volume_name));
-		strncpy(sb->s_volume_name, new_label,
+		strncpy((char *)sb->s_volume_name, new_label,
 			sizeof(sb->s_volume_name));
 		ext2fs_mark_super_dirty(fs);
 	}
 	if (M_flag) {
 		memset(sb->s_last_mounted, 0, sizeof(sb->s_last_mounted));
-		strncpy(sb->s_last_mounted, new_last_mounted,
+		strncpy((char *)sb->s_last_mounted, new_last_mounted,
 			sizeof(sb->s_last_mounted));
 		ext2fs_mark_super_dirty(fs);
 	}
@@ -3176,7 +3183,9 @@ _("Warning: The journal is dirty. You may wish to replay the journal like:\n\n"
 			rc = 1;
 			goto closefs;
 		}
-		handle_quota_options(fs);
+		rc = handle_quota_options(fs);
+		if (rc)
+			goto closefs;
 	}
 
 	if (U_flag) {
@@ -3188,9 +3197,11 @@ _("Warning: The journal is dirty. You may wish to replay the journal like:\n\n"
 		if (!ext2fs_has_feature_csum_seed(fs->super) &&
 		    (ext2fs_has_feature_metadata_csum(fs->super) ||
 		     ext2fs_has_feature_ea_inode(fs->super))) {
-			check_fsck_needed(fs,
+			rc = check_fsck_needed(fs,
 				_("Setting the UUID on this "
 				  "filesystem could take some time."));
+			if (rc)
+				goto closefs;
 			rewrite_checksums = 1;
 		}
 
@@ -3212,7 +3223,8 @@ _("Warning: The journal is dirty. You may wish to replay the journal like:\n\n"
 					"metadata_csum_seed' and re-run this "
 					"command.\n"), stderr);
 				try_confirm_csum_seed_support();
-				exit(1);
+				rc = 1;
+				goto closefs;
 			}
 
 			/*
diff --git a/tests/t_mmp_2off/script b/tests/t_mmp_2off/script
index ccd859b2f41c..1cd0719197e0 100644
--- a/tests/t_mmp_2off/script
+++ b/tests/t_mmp_2off/script
@@ -8,7 +8,7 @@ if [ "$status" != 0 ] ; then
 	return $status
 fi
 
-$TUNE2FS -O ^mmp $TMPFILE > $test_name.log 2>&1
+$TUNE2FS -O ^mmp $TMPFILE >> $test_name.log 2>&1
 status=$?
 if [ "$status" != 0 ] ; then
 	echo "tune2fs -O ^mmp failed" > $test_name.failed
@@ -16,7 +16,7 @@ if [ "$status" != 0 ] ; then
 	return $status
 fi
 
-$FSCK $FSCK_OPT $TMPFILE > $test_name.log 2>&1
+$FSCK $FSCK_OPT $TMPFILE >> $test_name.log 2>&1
 status=$?
 if [ "$status" = 0 ] ; then
 	echo "$test_name: $test_description: ok"
diff --git a/tests/t_mmp_fail/is_slow_test b/tests/t_mmp_fail/is_slow_test
new file mode 100644
index 000000000000..e69de29bb2d1
diff --git a/tests/t_mmp_fail/name b/tests/t_mmp_fail/name
new file mode 100644
index 000000000000..e872ddaaa30c
--- /dev/null
+++ b/tests/t_mmp_fail/name
@@ -0,0 +1 @@
+error running tune2fs with MMP
diff --git a/tests/t_mmp_fail/script b/tests/t_mmp_fail/script
new file mode 100644
index 000000000000..5fa6a846b70e
--- /dev/null
+++ b/tests/t_mmp_fail/script
@@ -0,0 +1,44 @@
+FSCK_OPT=-yf
+
+$MKE2FS -q -F -o Linux -I 128 -b 1024 -O mmp $TMPFILE 100 > $test_name.log 2>&1
+status=$?
+if [ "$status" != 0 ] ; then
+	echo "mke2fs -O mmp failed" > $test_name.failed
+	echo "$test_name: $test_description: failed"
+	return $status
+fi
+
+$TUNE2FS -O project $TMPFILE >> $test_name.log 2>&1
+status=$?
+if [ "$status" == 0 ] ; then
+	echo "'tune2fs -O project' succeeded on small inode" > $test_name.failed
+	echo "$test_name: $test_description: failed"
+	return 1
+fi
+$TUNE2FS -o bad_option $TMPFILE >> $test_name.log 2>&1
+status=$?
+if [ "$status" == 0 ] ; then
+	echo "'tune2fs -o bad_option' succeeded" > $test_name.failed
+	echo "$test_name: $test_description: failed"
+	return 1
+fi
+$E2MMPSTATUS -i $TMPFILE >> $test_name.log 2>&1
+$E2MMPSTATUS $TMPFILE >> $test_name.log 2>&1
+status=$?
+if [ "$status" != 0 ] ; then
+	echo "$TUNE2FS left MMP block in bad state" > $test_name.failed
+	echo "$test_name: $test_description: failed"
+	return $status
+fi
+
+$FSCK $FSCK_OPT $TMPFILE >> $test_name.log 2>&1
+status=$?
+if [ "$status" = 0 ] ; then
+	echo "$test_name: $test_description: ok"
+	touch $test_name.ok
+else
+	echo "e2fsck after MMP disable failed" > $test_name.failed
+	echo "$test_name: $test_description: failed"
+	return $status
+fi
+rm -f $TMPFILE
-- 
2.14.3 (Apple Git-98)

