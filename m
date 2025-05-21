Return-Path: <linux-ext4+bounces-8122-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DEBEABFFFC
	for <lists+linux-ext4@lfdr.de>; Thu, 22 May 2025 00:46:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2ED089E48BA
	for <lists+linux-ext4@lfdr.de>; Wed, 21 May 2025 22:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B67E2239E6E;
	Wed, 21 May 2025 22:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vo518oNa"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE711EA65
	for <linux-ext4@vger.kernel.org>; Wed, 21 May 2025 22:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747867570; cv=none; b=ossgUKe3jn5VWNeAsMxh0Yce58trANc3vKyL1Hni3YauoxGiVnay4lXV7MFU29Jg0udxzxjDwAbRahwiF505s4DIPkswtHVTXM6U6OmfIXNynGGMwVMtsKvuiW+8a9Z5q/+z8HKxWAoZHVWInIh7Vn3XxNdHSLWFzKsI1tccXJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747867570; c=relaxed/simple;
	bh=QYga+ig98ymSBlQcIaw5xCsZA6MOHaFalNcTRB27l8Q=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AeRWJ9zCLHdK6gZK2UiAhnILAi+jArjSes8w0S4xYODPVwQRjfoXsTMyvPT2MsDtAeI+EqUV9nOigeELj9ab6IHvgBoWPPrcAzmcMbG/69Sn54Zm77/QMD+WQUqrq40n15v8hi6JkwsFeZLFLAGPpJAPhDKMkekR6ISszQG36oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vo518oNa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D4ACC4CEEA;
	Wed, 21 May 2025 22:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747867570;
	bh=QYga+ig98ymSBlQcIaw5xCsZA6MOHaFalNcTRB27l8Q=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=Vo518oNaA2VbwGKY0WJzP9MPS6SnRZVCqU87OfgP9Q++k2LoR6PL0On37ybZX0MT/
	 RMuFF1AXGDi2xtNHv/S11cZpeupnYb2DJ1gAM45BxYVbTyAVrqDL5GObzdModiAK+7
	 6AKcs0k7ZeLZ596rqJXlfMi+6DiG+VeTQ54DULAn4D0ZTMWo+3uBC0oKMlexO+Dx2W
	 VgxK/6V5XH/QlYJRHf/iqgcXLYlma67IM/YXt2NcaPHTbXU0xkgTgErbMZpF4TAsQr
	 P49NytbwklhRB3YlZJ4Jd3yZx9uHwC1NhjipOGHCMm4GZH1ueORzqIw/IoJA+Zg6HW
	 U4ams6JJ1NvzA==
Date: Wed, 21 May 2025 15:46:09 -0700
Subject: [PATCH 04/10] fuse2fs: split filesystem mounting into helper
 functions
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <174786678763.1385354.2192764222512179630.stgit@frogsfrogsfrogs>
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

Break up main() by moving the filesystem mounting logic into separate
helper functions.  This will make it easier to move that part around for
fuseblk support in the next patches.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |  243 ++++++++++++++++++++++++++++++++++----------------------
 1 file changed, 146 insertions(+), 97 deletions(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index ec3d684085d975..e1202fe6ce4a46 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -689,6 +689,142 @@ static void close_fs(struct fuse2fs *ff)
 	ff->fs = NULL;
 }
 
+static errcode_t open_fs(struct fuse2fs *ff, int libext2_flags)
+{
+	char options[128];
+	int flags = EXT2_FLAG_64BITS | EXT2_FLAG_THREADS | libext2_flags;
+	errcode_t err;
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
+static errcode_t config_fs_cache(struct fuse2fs *ff)
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
+static errcode_t check_fs_supported(struct fuse2fs *ff)
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
+	return 0;
+}
+
+static errcode_t mount_fs(struct fuse2fs *ff)
+{
+	ext2_filsys fs = ff->fs;
+	errcode_t err;
+
+	if (ext2fs_has_feature_journal_needs_recovery(fs->super)) {
+		if (ff->norecovery) {
+			log_printf(ff, "%s\n",
+_("Mounting read-only without recovering journal."));
+		} else {
+			log_printf(ff, "%s\n", _("Recovering journal."));
+			err = ext2fs_run_ext3_journal(&fs);
+			if (err) {
+				err_printf(ff, "%s.\n", error_message(err));
+				err_printf(ff, "%s\n",
+						_("Please run e2fsck -fy."));
+				return err;
+			}
+			ext2fs_clear_feature_journal_needs_recovery(fs->super);
+			ext2fs_mark_super_dirty(fs);
+		}
+	}
+
+	if (fs->flags & EXT2_FLAG_RW) {
+		if (ext2fs_has_feature_journal(fs->super))
+			log_printf(ff, "%s",
+ _("Warning: fuse2fs does not support using the journal.\n"
+   "There may be file system corruption or data loss if\n"
+   "the file system is not gracefully unmounted.\n"));
+		err = ext2fs_read_inode_bitmap(fs);
+		if (err) {
+			translate_error(fs, 0, err);
+			return err;
+		}
+		err = ext2fs_read_block_bitmap(fs);
+		if (err) {
+			translate_error(fs, 0, err);
+			return err;
+		}
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
+	if (fs->super->s_state & EXT2_ERROR_FS) {
+		err_printf(ff, "%s\n",
+ _("Errors detected; running e2fsck is required."));
+		return EXT2_ET_FILESYSTEM_CORRUPTED;
+	}
+
+	return 0;
+}
+
 static void op_destroy(void *p EXT2FS_ATTR((unused)))
 {
 	struct fuse_context *ctxt = fuse_get_context();
@@ -4488,8 +4624,6 @@ int main(int argc, char *argv[])
 	char *logfile;
 	char extra_args[BUFSIZ];
 	int ret = 0;
-	int flags = EXT2_FLAG_64BITS | EXT2_FLAG_THREADS | EXT2_FLAG_EXCLUSIVE |
-		    EXT2_FLAG_RW;
 
 	memset(&fctx, 0, sizeof(fctx));
 	fctx.magic = FUSE2FS_MAGIC;
@@ -4543,119 +4677,34 @@ int main(int argc, char *argv[])
 		fctx.alloc_all_blocks = 1;
 	}
 
-	/* Start up the fs (while we still can use stdout) */
-	ret = 2;
-	char options[50];
-	sprintf(options, "offset=%lu", fctx.offset);
-	if (fctx.directio)
-		flags |= EXT2_FLAG_DIRECT_IO;
-	err = ext2fs_open2(fctx.device, options, flags, 0, 0, unix_io_manager,
-			   &fctx.fs);
+	err = open_fs(&fctx, EXT2_FLAG_EXCLUSIVE);
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
+		err = config_fs_cache(&fctx);
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
+	err = check_fs_supported(&fctx);
+	if (err) {
+		ret = 32;
 		goto out;
 	}
 
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
-	if (fctx.fs->flags & EXT2_FLAG_RW) {
-		if (ext2fs_has_feature_journal(fctx.fs->super))
-			log_printf(&fctx, "%s",
- _("Warning: fuse2fs does not support using the journal.\n"
-   "There may be file system corruption or data loss if\n"
-   "the file system is not gracefully unmounted.\n"));
-		err = ext2fs_read_inode_bitmap(fctx.fs);
-		if (err) {
-			translate_error(fctx.fs, 0, err);
-			goto out;
-		}
-		err = ext2fs_read_block_bitmap(fctx.fs);
-		if (err) {
-			translate_error(fctx.fs, 0, err);
-			goto out;
-		}
-	}
-
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
-	if (fctx.fs->super->s_state & EXT2_ERROR_FS) {
-		err_printf(&fctx, "%s\n",
- _("Errors detected; running e2fsck is required."));
+	err = mount_fs(&fctx);
+	if (err) {
+		ret = 32;
 		goto out;
 	}
 


