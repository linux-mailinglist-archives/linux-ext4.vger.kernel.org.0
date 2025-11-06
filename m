Return-Path: <linux-ext4+bounces-11588-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id EEBFAC3DA22
	for <lists+linux-ext4@lfdr.de>; Thu, 06 Nov 2025 23:38:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 72AD434DAD6
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Nov 2025 22:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FD1F308F11;
	Thu,  6 Nov 2025 22:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gvHn4pGN"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A942E0934
	for <linux-ext4@vger.kernel.org>; Thu,  6 Nov 2025 22:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762468728; cv=none; b=Wx+V3AcCMH8CYUXkhpZ+l5sbo2usXWYt77XJTmIWlborokkzpcs4r8xCzLdU8Ekd6CJ3hM0x87pe2ctx2TgZrkWY1qe1mtzxBPZUezr44wAdkEz7Id/fyCQi3NEORhULKU0aE3w8fGHl5At74abbGnncTIwmp90TH2DwBAWiX4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762468728; c=relaxed/simple;
	bh=E8ceHZ7Q1JtA5fYz0IEdJOCElYLW4V9pFrfmuAIwaz8=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bQ1TsDqbzLxSfWnE/YcgriWjHnngipK7bHhPRGck0FJ3IsXvRg2QTBsWsKKUmYrMNtUHDS2wWe7tZtTf4OZkJRGl5PhYGGe/A1mJ6DrsXQRTOLBD7YTDDQpBD1CMbtF+s7KxzjyqPaU0taHkzLlY9/iciPQPTJJxJZoUdWkeZPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gvHn4pGN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7471FC4CEF7;
	Thu,  6 Nov 2025 22:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762468728;
	bh=E8ceHZ7Q1JtA5fYz0IEdJOCElYLW4V9pFrfmuAIwaz8=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=gvHn4pGNneFNDZguLgi6hH3TIYoqR4o0+t+c8QqI6xfirE9RuaUjetLXYWZ74pVSV
	 ZpjZWh8Cq8cU69HVx6OiaB/GiSswSFBOzXB87i8lr6qyEUErXCtODdPCG6HfOdYtBM
	 vqblxeyeAuGLg299ewg8VGpZ5t8a8qRewiI7R4SzHiSved4qwKIbW9lpw8LRdm7NJg
	 iO3Q6hxn4LyKl96rH+MHTyLMbDGPA/II0a9gM00POo7HEab11xU5LHBXFK3bHu9rHx
	 vxiW4H31AJGJb9Et/ySeXnYoBSxtDifDtJ8XrwGkJKfpUHa4ZG0EmeWlOrYh32tPdO
	 TVqLwtEPH/66Q==
Date: Thu, 06 Nov 2025 14:38:47 -0800
Subject: [PATCH 1/3] fuse2fs: get rid of the global_fs variable
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <176246794479.2863378.5447111099174164770.stgit@frogsfrogsfrogs>
In-Reply-To: <176246794450.2863378.4457886029233676166.stgit@frogsfrogsfrogs>
References: <176246794450.2863378.4457886029233676166.stgit@frogsfrogsfrogs>
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
 misc/fuse2fs.c |   73 +++++++++++++++++++++++++++-----------------------------
 1 file changed, 35 insertions(+), 38 deletions(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 9db0b17af27438..0020d149949835 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -123,8 +123,6 @@
 #endif
 #endif /* !defined(ENODATA) */
 
-static ext2_filsys global_fs; /* Try not to use this directly */
-
 static inline uint64_t round_up(uint64_t b, unsigned int align)
 {
 	unsigned int m;
@@ -1265,7 +1263,7 @@ static void *op_init(struct fuse_conn_info *conn
 		log_printf(ff, "%s %s.\n", _("mounted filesystem"), uuid);
 	}
 
-	if (global_fs->flags & EXT2_FLAG_RW)
+	if (ff->fs->flags & EXT2_FLAG_RW)
 		fuse2fs_read_bitmaps(ff);
 
 	/*
@@ -5287,7 +5285,7 @@ int main(int argc, char *argv[])
 	deadline = init_deadline(FUSE2FS_OPEN_TIMEOUT);
 	do {
 		err = ext2fs_open2(fctx.device, options, flags, 0, 0,
-				   unix_io_manager, &global_fs);
+				   unix_io_manager, &fctx.fs);
 		if ((err == EPERM || err == EACCES) &&
 		    (!fctx.ro || (flags & EXT2_FLAG_RW))) {
 			/*
@@ -5325,17 +5323,17 @@ int main(int argc, char *argv[])
 	 * uevent and cause weird userspace stalls, and block devices have
 	 * O_EXCL so we don't need this there.
 	 */
-	if (!(global_fs->io->flags & CHANNEL_FLAGS_BLOCK_DEVICE)) {
+	if (!(fctx.fs->io->flags & CHANNEL_FLAGS_BLOCK_DEVICE)) {
 		unsigned int lock_flags = IO_CHANNEL_FLOCK_TRYLOCK;
 
-		if (global_fs->flags & IO_FLAG_RW)
+		if (fctx.fs->flags & IO_FLAG_RW)
 			lock_flags |= IO_CHANNEL_FLOCK_EXCLUSIVE;
 		else
 			lock_flags |= IO_CHANNEL_FLOCK_SHARED;
 
 		deadline = init_deadline(FUSE2FS_OPEN_TIMEOUT);
 		do {
-			err = io_channel_flock(global_fs->io, lock_flags);
+			err = io_channel_flock(fctx.fs->io, lock_flags);
 		} while (err == EWOULDBLOCK && retry_before_deadline(deadline));
 		if (err) {
 			err_printf(&fctx, "%s: %s\n",
@@ -5344,8 +5342,7 @@ int main(int argc, char *argv[])
 		}
 	}
 
-	fctx.fs = global_fs;
-	global_fs->priv_data = &fctx;
+	fctx.fs->priv_data = &fctx;
 	fctx.blocklog = u_log2(fctx.fs->blocksize);
 	fctx.blockmask = fctx.fs->blocksize - 1;
 
@@ -5358,7 +5355,7 @@ int main(int argc, char *argv[])
 
 		snprintf(buf, sizeof(buf), "cache_blocks=%llu",
 			 FUSE2FS_B_TO_FSBT(&fctx, fctx.cache_size));
-		err = io_channel_set_options(global_fs->io, buf);
+		err = io_channel_set_options(fctx.fs->io, buf);
 		if (err) {
 			err_printf(&fctx, "%s %lluk: %s\n",
 				   _("cannot set disk cache size to"),
@@ -5377,23 +5374,23 @@ int main(int argc, char *argv[])
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
-		} else if (!(global_fs->flags & EXT2_FLAG_RW)) {
+			fctx.fs->flags &= ~EXT2_FLAG_RW;
+		} else if (!(fctx.fs->flags & EXT2_FLAG_RW)) {
 			err_printf(&fctx, "%s\n",
  _("Cannot replay journal on read-only device."));
 			ret = 32;
 			goto out;
 		} else {
 			log_printf(&fctx, "%s\n", _("Recovering journal."));
-			err = ext2fs_run_ext3_journal(&global_fs);
+			err = ext2fs_run_ext3_journal(&fctx.fs);
 			if (err) {
 				err_printf(&fctx, "%s.\n", error_message(err));
 				err_printf(&fctx, "%s\n",
@@ -5405,58 +5402,58 @@ int main(int argc, char *argv[])
 			if (err)
 				goto out;
 		}
-	} else if (ext2fs_has_feature_journal(global_fs->super)) {
-		err = ext2fs_check_ext3_journal(global_fs);
+	} else if (ext2fs_has_feature_journal(fctx.fs->super)) {
+		err = ext2fs_check_ext3_journal(fctx.fs);
 		if (err) {
-			translate_error(global_fs, 0, err);
+			translate_error(fctx.fs, 0, err);
 			goto out;
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
@@ -5545,8 +5542,8 @@ int main(int argc, char *argv[])
 		fflush(orig_stderr);
 	}
 	fuse2fs_mmp_destroy(&fctx);
-	if (global_fs) {
-		err = ext2fs_close_free(&global_fs);
+	if (fctx.fs) {
+		err = ext2fs_close_free(&fctx.fs);
 		if (err)
 			com_err(argv[0], err, "while closing fs");
 	}


