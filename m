Return-Path: <linux-ext4+bounces-10094-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B6D9B588C2
	for <lists+linux-ext4@lfdr.de>; Tue, 16 Sep 2025 02:02:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F16E16F531
	for <lists+linux-ext4@lfdr.de>; Tue, 16 Sep 2025 00:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C42F345C0B;
	Tue, 16 Sep 2025 00:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QBy7UD/A"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E9D1F94A
	for <linux-ext4@vger.kernel.org>; Tue, 16 Sep 2025 00:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757980947; cv=none; b=JzKkMB7ks9jlUpmQw2F1cSa8IDM6MQrB/NA4/CNqKaQHPmGdDYULpo2dWgzdBZdDDB57MIBAA+KfYecuvFWnCWoJM+aPG+wGuBgLuvAIhcWCd8ZA3WV65clNSAcRkbYvGI8Rb/dKygGElBb8LgqndAV51P0KEpTBNenTUvnSPb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757980947; c=relaxed/simple;
	bh=n7glb6Yttq6Ou9znk5xQm1xLYYYQ6C9HVFDW440G9Xc=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hQk0YnZtFy6JegwUQhdMV+G8OswAgIaD7CccB/KGfiRrDP3bpZga2x4sHu7h4uV1VZ3jkZIzonlO2p5feJ6kC5tJk0jDjMIXVtw/V+XV6VWzpyfQNzGSan9NHGfL8thw5CTaL5egCl6auwFn0m6wdLesN8zLcYDrS7mhPZiI/Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QBy7UD/A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E35A0C4CEF1;
	Tue, 16 Sep 2025 00:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757980947;
	bh=n7glb6Yttq6Ou9znk5xQm1xLYYYQ6C9HVFDW440G9Xc=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=QBy7UD/Acyr2HM6suGHL56XxYuwIpUHOhp20Ny3x3IwjVO+O+cFxjLM/QuDnz0dIS
	 QNXo+rEpeHkC8EHBJY06HIRRi1jXhDtaKgmrHTTynpiuCOz9CmBthMur0v4RWgZ3lI
	 3ZsaPbk8JGREzV/SY0wmpozhdoMHWUSbBJFXTRvt3s/+iUpkhr6spgDOl2loHIkNCY
	 S2AGMU8f8FG5MpVJSShOUxC6SK1u5HY17f2UmdtEAp1P6mChJ+veJiQG322WY45sZd
	 +UcfwYTZ8aJQfqx8G9DzyGpBjx/rrT1/eMaWq4OjAUiE8k5OPwxpGuykydLMnWxFiF
	 iceI/dCVa73Sw==
Date: Mon, 15 Sep 2025 17:02:26 -0700
Subject: [PATCH 1/3] fuse2fs: split filesystem mounting into helper functions
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <175798064597.349841.13113367506205034632.stgit@frogsfrogsfrogs>
In-Reply-To: <175798064569.349841.5710112269701643406.stgit@frogsfrogsfrogs>
References: <175798064569.349841.5710112269701643406.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Break up main() by moving the filesystem mounting logic into separate
helper functions.  This will make it easier to move that part around for
fuseblk support in the next patches.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |  289 ++++++++++++++++++++++++++++++++------------------------
 1 file changed, 163 insertions(+), 126 deletions(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 23a1cd8d5d5d0a..a84bd2245d82df 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -926,6 +926,159 @@ static void fuse2fs_unmount(struct fuse2fs *ff)
 		fuse2fs_release_lockfile(ff);
 }
 
+static errcode_t fuse2fs_open(struct fuse2fs *ff, int libext2_flags)
+{
+	char options[128];
+	int flags = EXT2_FLAG_64BITS | EXT2_FLAG_THREADS | libext2_flags;
+	errcode_t err;
+
+	if (ff->lockfile) {
+		err = fuse2fs_acquire_lockfile(ff);
+		if (err)
+			return err;
+	}
+
+	snprintf(options, sizeof(options) - 1, "offset=%lu", ff->offset);
+
+	if (!ff->norecovery)
+		flags |= EXT2_FLAG_RW;
+	if (ff->directio)
+		flags |= EXT2_FLAG_DIRECT_IO;
+
+	err = ext2fs_open2(ff->device, options, flags, 0, 0, unix_io_manager,
+			   &ff->fs);
+	if (err) {
+		err_printf(ff, "%s.\n", error_message(err));
+		err_printf(ff, "%s\n", _("Please run e2fsck -fy."));
+		return err;
+	}
+
+	ff->fs->priv_data = ff;
+	ff->blocklog = u_log2(ff->fs->blocksize);
+	ff->blockmask = ff->fs->blocksize - 1;
+	return 0;
+}
+
+static errcode_t fuse2fs_config_cache(struct fuse2fs *ff)
+{
+	char buf[128];
+	errcode_t err;
+
+	snprintf(buf, sizeof(buf), "cache_blocks=%llu",
+		 FUSE2FS_B_TO_FSBT(ff, ff->cache_size));
+	err = io_channel_set_options(ff->fs->io, buf);
+	if (err) {
+		err_printf(ff, "%s %lluk: %s\n",
+			   _("cannot set disk cache size to"),
+			   ff->cache_size >> 10,
+			   error_message(err));
+		return err;
+	}
+
+	return 0;
+}
+
+static errcode_t fuse2fs_check_support(struct fuse2fs *ff)
+{
+	ext2_filsys fs = ff->fs;
+
+	if (ext2fs_has_feature_quota(fs->super)) {
+		err_printf(ff, "%s\n", _("quotas not supported."));
+		return EXT2_ET_UNSUPP_FEATURE;
+	}
+	if (ext2fs_has_feature_verity(fs->super)) {
+		err_printf(ff, "%s\n", _("verity not supported."));
+		return EXT2_ET_UNSUPP_FEATURE;
+	}
+	if (ext2fs_has_feature_encrypt(fs->super)) {
+		err_printf(ff, "%s\n", _("encryption not supported."));
+		return EXT2_ET_UNSUPP_FEATURE;
+	}
+	if (ext2fs_has_feature_casefold(fs->super)) {
+		err_printf(ff, "%s\n", _("casefolding not supported."));
+		return EXT2_ET_UNSUPP_FEATURE;
+	}
+
+	if (fs->super->s_state & EXT2_ERROR_FS) {
+		err_printf(ff, "%s\n",
+ _("Errors detected; running e2fsck is required."));
+		return EXT2_ET_FILESYSTEM_CORRUPTED;
+	}
+
+	return 0;
+}
+
+static int fuse2fs_mount(struct fuse2fs *ff)
+{
+	struct ext2_inode_large inode;
+	ext2_filsys fs = ff->fs;
+	errcode_t err;
+
+	if (ext2fs_has_feature_journal_needs_recovery(fs->super)) {
+		if (ff->norecovery) {
+			log_printf(ff, "%s\n",
+ _("Mounting read-only without recovering journal."));
+		} else {
+			log_printf(ff, "%s\n", _("Recovering journal."));
+			err = ext2fs_run_ext3_journal(&ff->fs);
+			if (err) {
+				err_printf(ff, "%s.\n", error_message(err));
+				err_printf(ff, "%s\n",
+						_("Please run e2fsck -fy."));
+				return translate_error(fs, 0, err);
+			}
+			fs = ff->fs;
+			ext2fs_clear_feature_journal_needs_recovery(fs->super);
+			ext2fs_mark_super_dirty(fs);
+		}
+	}
+
+	/* Make sure the root directory is readable. */
+	err = fuse2fs_read_inode(fs, EXT2_ROOT_INO, &inode);
+	if (err)
+		return translate_error(fs, EXT2_ROOT_INO, err);
+
+	if (fs->flags & EXT2_FLAG_RW) {
+		if (ext2fs_has_feature_journal(fs->super))
+			log_printf(ff, "%s",
+ _("Warning: fuse2fs does not support using the journal.\n"
+   "There may be file system corruption or data loss if\n"
+   "the file system is not gracefully unmounted.\n"));
+	}
+
+	if (!(fs->super->s_state & EXT2_VALID_FS))
+		err_printf(ff, "%s\n",
+ _("Warning: Mounting unchecked fs, running e2fsck is recommended."));
+	if (fs->super->s_max_mnt_count > 0 &&
+	    fs->super->s_mnt_count >= fs->super->s_max_mnt_count)
+		err_printf(ff, "%s\n",
+ _("Warning: Maximal mount count reached, running e2fsck is recommended."));
+	if (fs->super->s_checkinterval > 0 &&
+	    (time_t) (fs->super->s_lastcheck +
+		      fs->super->s_checkinterval) <= time(0))
+		err_printf(ff, "%s\n",
+ _("Warning: Check time reached; running e2fsck is recommended."));
+	if (fs->super->s_last_orphan)
+		err_printf(ff, "%s\n",
+ _("Orphans detected; running e2fsck is recommended."));
+
+	if (!ff->errors_behavior)
+		ff->errors_behavior = fs->super->s_errors;
+
+	/* Clear the valid flag so that an unclean shutdown forces a fsck */
+	if (fs->flags & EXT2_FLAG_RW) {
+		fs->super->s_mnt_count++;
+		ext2fs_set_tstamp(fs->super, s_mtime, time(NULL));
+		fs->super->s_state &= ~EXT2_VALID_FS;
+		ext2fs_mark_super_dirty(fs);
+		err = ext2fs_flush2(fs, 0);
+		if (err)
+			return translate_error(fs, 0, err);
+	}
+
+	return 0;
+}
+
 static void op_destroy(void *p EXT2FS_ATTR((unused)))
 {
 	struct fuse2fs *ff = fuse2fs_get();
@@ -4962,19 +5115,6 @@ static unsigned long long default_cache_size(void)
 	return ret;
 }
 
-/* Make sure the root directory is readable. */
-static errcode_t fuse2fs_check_root_dir(ext2_filsys fs)
-{
-	struct ext2_inode_large inode;
-	errcode_t err;
-
-	err = fuse2fs_read_inode(fs, EXT2_ROOT_INO, &inode);
-	if (err)
-		return translate_error(fs, EXT2_ROOT_INO, err);
-
-	return 0;
-}
-
 int main(int argc, char *argv[])
 {
 	struct fuse_args args = FUSE_ARGS_INIT(argc, argv);
@@ -4983,8 +5123,6 @@ int main(int argc, char *argv[])
 	FILE *orig_stderr = stderr;
 	char extra_args[BUFSIZ];
 	int ret;
-	int flags = EXT2_FLAG_64BITS | EXT2_FLAG_THREADS | EXT2_FLAG_EXCLUSIVE |
-		    EXT2_FLAG_RW;
 
 	memset(&fctx, 0, sizeof(fctx));
 	fctx.magic = FUSE2FS_MAGIC;
@@ -5029,67 +5167,25 @@ int main(int argc, char *argv[])
 		fctx.alloc_all_blocks = 1;
 	}
 
-	if (fctx.lockfile && fuse2fs_acquire_lockfile(&fctx)) {
-		ret |= 32;
-		goto out;
-	}
-
-	/* Start up the fs (while we still can use stdout) */
-	ret = 2;
-	char options[50];
-	sprintf(options, "offset=%lu", fctx.offset);
-	if (fctx.directio)
-		flags |= EXT2_FLAG_DIRECT_IO;
-	err = ext2fs_open2(fctx.device, options, flags, 0, 0, unix_io_manager,
-			   &fctx.fs);
+	err = fuse2fs_open(&fctx, EXT2_FLAG_EXCLUSIVE);
 	if (err) {
-		err_printf(&fctx, "%s.\n", error_message(err));
-		err_printf(&fctx, "%s\n", _("Please run e2fsck -fy."));
+		ret = 32;
 		goto out;
 	}
-	fctx.fs->priv_data = &fctx;
-	fctx.blocklog = u_log2(fctx.fs->blocksize);
-	fctx.blockmask = fctx.fs->blocksize - 1;
 
 	if (!fctx.cache_size)
 		fctx.cache_size = default_cache_size();
 	if (fctx.cache_size) {
-		char buf[55];
-
-		snprintf(buf, sizeof(buf), "cache_blocks=%llu",
-			 FUSE2FS_B_TO_FSBT(&fctx, fctx.cache_size));
-		err = io_channel_set_options(fctx.fs->io, buf);
+		err = fuse2fs_config_cache(&fctx);
 		if (err) {
-			err_printf(&fctx, "%s %lluk: %s\n",
-				   _("cannot set disk cache size to"),
-				   fctx.cache_size >> 10,
-				   error_message(err));
+			ret = 32;
 			goto out;
 		}
 	}
 
-	ret = 3;
-
-	if (ext2fs_has_feature_quota(fctx.fs->super)) {
-		err_printf(&fctx, "%s", _("quotas not supported."));
-		goto out;
-	}
-	if (ext2fs_has_feature_verity(fctx.fs->super)) {
-		err_printf(&fctx, "%s", _("verity not supported."));
-		goto out;
-	}
-	if (ext2fs_has_feature_encrypt(fctx.fs->super)) {
-		err_printf(&fctx, "%s", _("encryption not supported."));
-		goto out;
-	}
-	if (ext2fs_has_feature_casefold(fctx.fs->super)) {
-		err_printf(&fctx, "%s", _("casefolding not supported."));
-		goto out;
-	}
-
-	if (fctx.fs->super->s_state & EXT2_ERROR_FS) {
-		err_printf(&fctx, "%s\n",
- _("Errors detected; running e2fsck is required."));
+	err = fuse2fs_check_support(&fctx);
+	if (err) {
+		ret = 32;
 		goto out;
 	}
 
@@ -5100,71 +5196,12 @@ int main(int argc, char *argv[])
 	if (ext2fs_has_feature_shared_blocks(fctx.fs->super))
 		fctx.ro = 1;
 
-	if (ext2fs_has_feature_journal_needs_recovery(fctx.fs->super)) {
-		if (fctx.norecovery) {
-			log_printf(&fctx, "%s\n",
- _("Mounting read-only without recovering journal."));
-			fctx.ro = 1;
-			fctx.fs->flags &= ~EXT2_FLAG_RW;
-		} else {
-			log_printf(&fctx, "%s\n", _("Recovering journal."));
-			err = ext2fs_run_ext3_journal(&fctx.fs);
-			if (err) {
-				err_printf(&fctx, "%s.\n", error_message(err));
-				err_printf(&fctx, "%s\n",
-						_("Please run e2fsck -fy."));
-				goto out;
-			}
-			ext2fs_clear_feature_journal_needs_recovery(fctx.fs->super);
-			ext2fs_mark_super_dirty(fctx.fs);
-		}
-	}
-
-	ret = fuse2fs_check_root_dir(fctx.fs);
-	if (ret)
+	err = fuse2fs_mount(&fctx);
+	if (err) {
+		ret = 32;
 		goto out;
-
-	if (fctx.fs->flags & EXT2_FLAG_RW) {
-		if (ext2fs_has_feature_journal(fctx.fs->super))
-			log_printf(&fctx, "%s",
- _("Warning: fuse2fs does not support using the journal.\n"
-   "There may be file system corruption or data loss if\n"
-   "the file system is not gracefully unmounted.\n"));
 	}
 
-	if (!(fctx.fs->super->s_state & EXT2_VALID_FS))
-		err_printf(&fctx, "%s\n",
- _("Warning: Mounting unchecked fs, running e2fsck is recommended."));
-	if (fctx.fs->super->s_max_mnt_count > 0 &&
-	    fctx.fs->super->s_mnt_count >= fctx.fs->super->s_max_mnt_count)
-		err_printf(&fctx, "%s\n",
- _("Warning: Maximal mount count reached, running e2fsck is recommended."));
-	if (fctx.fs->super->s_checkinterval > 0 &&
-	    (time_t) (fctx.fs->super->s_lastcheck +
-		      fctx.fs->super->s_checkinterval) <= time(0))
-		err_printf(&fctx, "%s\n",
- _("Warning: Check time reached; running e2fsck is recommended."));
-	if (fctx.fs->super->s_last_orphan)
-		err_printf(&fctx, "%s\n",
- _("Orphans detected; running e2fsck is recommended."));
-
-	/* Clear the valid flag so that an unclean shutdown forces a fsck */
-	if (fctx.fs->flags & EXT2_FLAG_RW) {
-		fctx.fs->super->s_mnt_count++;
-		ext2fs_set_tstamp(fctx.fs->super, s_mtime, time(NULL));
-		fctx.fs->super->s_state &= ~EXT2_VALID_FS;
-		ext2fs_mark_super_dirty(fctx.fs);
-		err = ext2fs_flush2(fctx.fs, 0);
-		if (err) {
-			translate_error(fctx.fs, 0, err);
-			ret |= 32;
-			goto out;
-		}
-	}
-
-	if (!fctx.errors_behavior)
-		fctx.errors_behavior = fctx.fs->super->s_errors;
-
 	/* Initialize generation counter */
 	get_random_bytes(&fctx.next_generation, sizeof(unsigned int));
 


