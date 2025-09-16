Return-Path: <linux-ext4+bounces-10091-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45455B588BC
	for <lists+linux-ext4@lfdr.de>; Tue, 16 Sep 2025 02:01:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED9CA3A789A
	for <lists+linux-ext4@lfdr.de>; Tue, 16 Sep 2025 00:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B023D2B2D7;
	Tue, 16 Sep 2025 00:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="crEMmVTX"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5448AE571
	for <linux-ext4@vger.kernel.org>; Tue, 16 Sep 2025 00:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757980900; cv=none; b=hzDL9icfH59EvBZEbvTUthJBfBHsulWWOSTPGG9UKhDwBdAGQkBD9G35Ib/Iwe9mwTloMYxYrSm91kEmC+Xk2UBNLihKB2iUiVBHCcfDvYj98MV+bVyedQGDzwA/HX1cVNyqCGkyXh0kmRWsU1FWWMWHPXmmPG046aDBat+qaXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757980900; c=relaxed/simple;
	bh=F+2F3Av9j0T1uIQi46cF4BjCMhlEKqhmdoLcgBU1cJs=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b2AoKyd3Ce6v3zK/atUooXyaO+EhsxsKYXxrvPObM+vh+ZGgIhwYflfF9F+mBgocQEf5S5D9050lOnEkOjeY6LTOy2+p5SmAxRfzj/feUjNVbEEAgJXG+lrjnxPtLgnSw7WDIbbM7ksYrg7tLDurV6dVVzMxHWAr2R1oqNlo2YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=crEMmVTX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE685C4CEF1;
	Tue, 16 Sep 2025 00:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757980899;
	bh=F+2F3Av9j0T1uIQi46cF4BjCMhlEKqhmdoLcgBU1cJs=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=crEMmVTX0mffHTCb3M2A9/a3399WKeQ/swGImrleAHQtoDm656dNGq0zCsLrlXwvH
	 FyoezpNOgK9vo5+/fC2oqa/D+/2BEPpm148zYiTgLJKYQFNb0+pbbiFgIF2/u9t5Mr
	 d29Ba7XhPIhNLZLL1vEsJQX45y6ungdsWcNiTppMOrfHlXLBOFtBPiAvWWCyJrbiXL
	 RtuwX8EiZf6f0aXM6rNM3t90Us9YG0MxccdzYSzeXxE2CO53MLi5XGfKSDOiv8LBiq
	 ewGWdv69xe9gxF+ik6ot/7qU3OsMqZ6Ahm3EOFPHXyRz0y3nT8zXLa/kZxMubvkkKm
	 C6oOpAMiA/w+w==
Date: Mon, 15 Sep 2025 17:01:39 -0700
Subject: [PATCH 1/3] fuse2fs: get rid of the global_fs variable
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <175798064410.349669.5991489057648250473.stgit@frogsfrogsfrogs>
In-Reply-To: <175798064383.349669.5686318690824770898.stgit@frogsfrogsfrogs>
References: <175798064383.349669.5686318690824770898.stgit@frogsfrogsfrogs>
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
 misc/fuse2fs.c |   77 +++++++++++++++++++++++++++-----------------------------
 1 file changed, 37 insertions(+), 40 deletions(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 6255d960bd802f..948a12c2812b65 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -122,8 +122,6 @@
 #endif
 #endif /* !defined(ENODATA) */
 
-static ext2_filsys global_fs; /* Try not to use this directly */
-
 static inline uint64_t round_up(uint64_t b, unsigned int align)
 {
 	unsigned int m;
@@ -1077,7 +1075,7 @@ static void *op_init(struct fuse_conn_info *conn
 		log_printf(ff, "%s %s.\n", _("mounted filesystem"), uuid);
 	}
 
-	if (global_fs->flags & EXT2_FLAG_RW)
+	if (ff->fs->flags & EXT2_FLAG_RW)
 		fuse2fs_read_bitmaps(ff);
 
 	return ff;
@@ -5005,14 +5003,13 @@ int main(int argc, char *argv[])
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
 
@@ -5023,7 +5020,7 @@ int main(int argc, char *argv[])
 
 		snprintf(buf, sizeof(buf), "cache_blocks=%llu",
 			 FUSE2FS_B_TO_FSBT(&fctx, fctx.cache_size));
-		err = io_channel_set_options(global_fs->io, buf);
+		err = io_channel_set_options(fctx.fs->io, buf);
 		if (err) {
 			err_printf(&fctx, "%s %lluk: %s\n",
 				   _("cannot set disk cache size to"),
@@ -5035,24 +5032,24 @@ int main(int argc, char *argv[])
 
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
 
-	if (global_fs->super->s_state & EXT2_ERROR_FS) {
+	if (fctx.fs->super->s_state & EXT2_ERROR_FS) {
 		err_printf(&fctx, "%s\n",
  _("Errors detected; running e2fsck is required."));
 		goto out;
@@ -5062,73 +5059,73 @@ int main(int argc, char *argv[])
 	 * ext4 can't do COW of shared blocks, so if the feature is enabled,
 	 * we must force ro mode.
 	 */
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
 
-	ret = fuse2fs_check_root_dir(global_fs);
+	ret = fuse2fs_check_root_dir(fctx.fs);
 	if (ret)
 		goto out;
 
-	if (global_fs->flags & EXT2_FLAG_RW) {
-		if (ext2fs_has_feature_journal(global_fs->super))
+	if (fctx.fs->flags & EXT2_FLAG_RW) {
+		if (ext2fs_has_feature_journal(fctx.fs->super))
 			log_printf(&fctx, "%s",
  _("Warning: fuse2fs does not support using the journal.\n"
    "There may be file system corruption or data loss if\n"
    "the file system is not gracefully unmounted.\n"));
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
 
 	/* Clear the valid flag so that an unclean shutdown forces a fsck */
-	if (global_fs->flags & EXT2_FLAG_RW) {
-		global_fs->super->s_mnt_count++;
-		ext2fs_set_tstamp(global_fs->super, s_mtime, time(NULL));
-		global_fs->super->s_state &= ~EXT2_VALID_FS;
-		ext2fs_mark_super_dirty(global_fs);
-		err = ext2fs_flush2(global_fs, 0);
+	if (fctx.fs->flags & EXT2_FLAG_RW) {
+		fctx.fs->super->s_mnt_count++;
+		ext2fs_set_tstamp(fctx.fs->super, s_mtime, time(NULL));
+		fctx.fs->super->s_state &= ~EXT2_VALID_FS;
+		ext2fs_mark_super_dirty(fctx.fs);
+		err = ext2fs_flush2(fctx.fs, 0);
 		if (err) {
-			translate_error(global_fs, 0, err);
+			translate_error(fctx.fs, 0, err);
 			ret |= 32;
 			goto out;
 		}
 	}
 
 	if (!fctx.errors_behavior)
-		fctx.errors_behavior = global_fs->super->s_errors;
+		fctx.errors_behavior = fctx.fs->super->s_errors;
 
 	/* Initialize generation counter */
 	get_random_bytes(&fctx.next_generation, sizeof(unsigned int));
@@ -5219,13 +5216,13 @@ int main(int argc, char *argv[])
  _("Mount failed while opening filesystem.  Check dmesg(1) for details."));
 		fflush(orig_stderr);
 	}
-	if (global_fs) {
-		err = ext2fs_close(global_fs);
+	if (fctx.fs) {
+		err = ext2fs_close(fctx.fs);
 		if (err) {
 			com_err(argv[0], err, "while closing fs");
-			ext2fs_free(global_fs);
+			ext2fs_free(fctx.fs);
 		}
-		global_fs = NULL;
+		fctx.fs = NULL;
 	}
 	if (fctx.lockfile) {
 		if (unlink(fctx.lockfile)) {


