Return-Path: <linux-ext4+bounces-8120-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29D3EABFFF0
	for <lists+linux-ext4@lfdr.de>; Thu, 22 May 2025 00:45:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F23E1BC4B3D
	for <lists+linux-ext4@lfdr.de>; Wed, 21 May 2025 22:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF3212192E3;
	Wed, 21 May 2025 22:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N/pv86gX"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8081B0F20
	for <linux-ext4@vger.kernel.org>; Wed, 21 May 2025 22:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747867539; cv=none; b=iZTkThLeyjPo8JVlPCbHJxXIelpS8r9t7cyz9rD+G1I6SPErzSv5035Q9ou0gR1TYFBGSDVtwDkCd91+zIwiIA9Cn6zpEpT7MDhvKLsgzEZ0JI0Usydea6Lu557qctlWqrys06dTEU1swNIkVNZ96yItBfbQ3fgORIbKS5UR3jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747867539; c=relaxed/simple;
	bh=RHdVWNeQj57yW3SaDZYw/H1h4Y/PEbeOaJ48UCIyt8k=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JgdDQEWbaa/lx2CCZzsIwVdJ9mKRtaTYE9oCPCEhzGiury9S6qqHMJHYOgmUOCDBY56ozjdG9VVvb2vh0dKneJ2CYcIhEsLO6/CfBD1GNwlID/SpqQpCLW7wcSEa4/tCjT7q/6PRXxX8wUM4+c70+TJYav4wxrkOUT3mKcDfuf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N/pv86gX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D373BC4CEE4;
	Wed, 21 May 2025 22:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747867538;
	bh=RHdVWNeQj57yW3SaDZYw/H1h4Y/PEbeOaJ48UCIyt8k=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=N/pv86gXMTHLWZ43l3on8yaIHGECv1qAN9+uYWZVYwFOVgYII2mbWoKTSqkW5TGMT
	 o01jIRSR0XC/WYMzGw0jLR6qQdQKBDlzQsxl6MqsuPCyayXNIfDSBCghqpwqk4j6Tx
	 bnGwCAXBkzBubTljynGT0QF+BDaudadOjWJZVOGTPpsmAlm6Cc2oSHo7hagfCy3J8n
	 y6vMK5bn2iGdGzySmSgzQohOQvpGJzuApQysInMoAXJiDyjciB0/5pkByhnQpQulc5
	 RfQHore6affzkzk2um2dPUFS1DDV3sKqCt3Uljco0gzFgmNedF+UIOu6Dn56AyqHx/
	 14kin7eNgcr7g==
Date: Wed, 21 May 2025 15:45:38 -0700
Subject: [PATCH 02/10] fuse2fs: get rid of the global_fs variable
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <174786678727.1385354.12845800532852165237.stgit@frogsfrogsfrogs>
In-Reply-To: <174786678650.1385354.14994099236248944550.stgit@frogsfrogsfrogs>
References: <174786678650.1385354.14994099236248944550.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Get rid of this global variable now that we don't need it anywhere.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |   63 +++++++++++++++++++++++++++-----------------------------
 1 file changed, 30 insertions(+), 33 deletions(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 138e3292b2de09..25d32a69729362 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -78,8 +78,6 @@
 #define P_(singular, plural, n) ((n) == 1 ? (singular) : (plural))
 #endif
 
-static ext2_filsys global_fs; /* Try not to use this directly */
-
 #define dbg_printf(fuse2fs, format, ...) \
 	while ((fuse2fs)->debug) { \
 		printf("FUSE2FS (%s): " format, (fuse2fs)->shortdev, ##__VA_ARGS__); \
@@ -4535,14 +4533,13 @@ int main(int argc, char *argv[])
 	if (fctx.directio)
 		flags |= EXT2_FLAG_DIRECT_IO;
 	err = ext2fs_open2(fctx.device, options, flags, 0, 0, unix_io_manager,
-			   &global_fs);
+			   &fctx.fs);
 	if (err) {
 		err_printf(&fctx, "%s.\n", error_message(err));
 		err_printf(&fctx, "%s\n", _("Please run e2fsck -fy."));
 		goto out;
 	}
-	fctx.fs = global_fs;
-	global_fs->priv_data = &fctx;
+	fctx.fs->priv_data = &fctx;
 	fctx.blocklog = u_log2(fctx.fs->blocksize);
 	fctx.blockmask = fctx.fs->blocksize - 1;
 
@@ -4553,7 +4550,7 @@ int main(int argc, char *argv[])
 
 		snprintf(buf, sizeof(buf), "cache_blocks=%llu",
 			 FUSE2FS_B_TO_FSBT(&fctx, fctx.cache_size));
-		err = io_channel_set_options(global_fs->io, buf);
+		err = io_channel_set_options(fctx.fs->io, buf);
 		if (err) {
 			err_printf(&fctx, "%s %lluk: %s\n",
 				   _("cannot set disk cache size to"),
@@ -4565,81 +4562,81 @@ int main(int argc, char *argv[])
 
 	ret = 3;
 
-	if (ext2fs_has_feature_quota(global_fs->super)) {
+	if (ext2fs_has_feature_quota(fctx.fs->super)) {
 		err_printf(&fctx, "%s", _("quotas not supported."));
 		goto out;
 	}
-	if (ext2fs_has_feature_verity(global_fs->super)) {
+	if (ext2fs_has_feature_verity(fctx.fs->super)) {
 		err_printf(&fctx, "%s", _("verity not supported."));
 		goto out;
 	}
-	if (ext2fs_has_feature_encrypt(global_fs->super)) {
+	if (ext2fs_has_feature_encrypt(fctx.fs->super)) {
 		err_printf(&fctx, "%s", _("encryption not supported."));
 		goto out;
 	}
-	if (ext2fs_has_feature_casefold(global_fs->super)) {
+	if (ext2fs_has_feature_casefold(fctx.fs->super)) {
 		err_printf(&fctx, "%s", _("casefolding not supported."));
 		goto out;
 	}
 
-	if (ext2fs_has_feature_shared_blocks(global_fs->super))
+	if (ext2fs_has_feature_shared_blocks(fctx.fs->super))
 		fctx.ro = 1;
 
-	if (ext2fs_has_feature_journal_needs_recovery(global_fs->super)) {
+	if (ext2fs_has_feature_journal_needs_recovery(fctx.fs->super)) {
 		if (fctx.norecovery) {
 			log_printf(&fctx, "%s\n",
  _("Mounting read-only without recovering journal."));
 			fctx.ro = 1;
-			global_fs->flags &= ~EXT2_FLAG_RW;
+			fctx.fs->flags &= ~EXT2_FLAG_RW;
 		} else {
 			log_printf(&fctx, "%s\n", _("Recovering journal."));
-			err = ext2fs_run_ext3_journal(&global_fs);
+			err = ext2fs_run_ext3_journal(&fctx.fs);
 			if (err) {
 				err_printf(&fctx, "%s.\n", error_message(err));
 				err_printf(&fctx, "%s\n",
 						_("Please run e2fsck -fy."));
 				goto out;
 			}
-			ext2fs_clear_feature_journal_needs_recovery(global_fs->super);
-			ext2fs_mark_super_dirty(global_fs);
+			ext2fs_clear_feature_journal_needs_recovery(fctx.fs->super);
+			ext2fs_mark_super_dirty(fctx.fs);
 		}
 	}
 
-	if (global_fs->flags & EXT2_FLAG_RW) {
-		if (ext2fs_has_feature_journal(global_fs->super))
+	if (fctx.fs->flags & EXT2_FLAG_RW) {
+		if (ext2fs_has_feature_journal(fctx.fs->super))
 			log_printf(&fctx, "%s",
  _("Warning: fuse2fs does not support using the journal.\n"
    "There may be file system corruption or data loss if\n"
    "the file system is not gracefully unmounted.\n"));
-		err = ext2fs_read_inode_bitmap(global_fs);
+		err = ext2fs_read_inode_bitmap(fctx.fs);
 		if (err) {
-			translate_error(global_fs, 0, err);
+			translate_error(fctx.fs, 0, err);
 			goto out;
 		}
-		err = ext2fs_read_block_bitmap(global_fs);
+		err = ext2fs_read_block_bitmap(fctx.fs);
 		if (err) {
-			translate_error(global_fs, 0, err);
+			translate_error(fctx.fs, 0, err);
 			goto out;
 		}
 	}
 
-	if (!(global_fs->super->s_state & EXT2_VALID_FS))
+	if (!(fctx.fs->super->s_state & EXT2_VALID_FS))
 		err_printf(&fctx, "%s\n",
  _("Warning: Mounting unchecked fs, running e2fsck is recommended."));
-	if (global_fs->super->s_max_mnt_count > 0 &&
-	    global_fs->super->s_mnt_count >= global_fs->super->s_max_mnt_count)
+	if (fctx.fs->super->s_max_mnt_count > 0 &&
+	    fctx.fs->super->s_mnt_count >= fctx.fs->super->s_max_mnt_count)
 		err_printf(&fctx, "%s\n",
  _("Warning: Maximal mount count reached, running e2fsck is recommended."));
-	if (global_fs->super->s_checkinterval > 0 &&
-	    (time_t) (global_fs->super->s_lastcheck +
-		      global_fs->super->s_checkinterval) <= time(0))
+	if (fctx.fs->super->s_checkinterval > 0 &&
+	    (time_t) (fctx.fs->super->s_lastcheck +
+		      fctx.fs->super->s_checkinterval) <= time(0))
 		err_printf(&fctx, "%s\n",
  _("Warning: Check time reached; running e2fsck is recommended."));
-	if (global_fs->super->s_last_orphan)
+	if (fctx.fs->super->s_last_orphan)
 		err_printf(&fctx, "%s\n",
  _("Orphans detected; running e2fsck is recommended."));
 
-	if (global_fs->super->s_state & EXT2_ERROR_FS) {
+	if (fctx.fs->super->s_state & EXT2_ERROR_FS) {
 		err_printf(&fctx, "%s\n",
  _("Errors detected; running e2fsck is required."));
 		goto out;
@@ -4726,11 +4723,11 @@ int main(int argc, char *argv[])
  _("Mount failed while opening filesystem.  Check dmesg(1) for details."));
 		fflush(orig_stderr);
 	}
-	if (global_fs) {
-		err = ext2fs_close(global_fs);
+	if (fctx.fs) {
+		err = ext2fs_close(fctx.fs);
 		if (err)
 			com_err(argv[0], err, "while closing fs");
-		global_fs = NULL;
+		fctx.fs = NULL;
 	}
 	if (fctx.device)
 		free(fctx.device);


