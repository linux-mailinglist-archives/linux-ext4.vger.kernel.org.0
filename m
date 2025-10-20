Return-Path: <linux-ext4+bounces-10986-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C28C8BF372D
	for <lists+linux-ext4@lfdr.de>; Mon, 20 Oct 2025 22:28:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C282B4FDB52
	for <lists+linux-ext4@lfdr.de>; Mon, 20 Oct 2025 20:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E052C2E2DDE;
	Mon, 20 Oct 2025 20:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="szXIxzzz"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8350C2E1C6F
	for <linux-ext4@vger.kernel.org>; Mon, 20 Oct 2025 20:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760991978; cv=none; b=XTOfKoCs4sAo/2mTAiskCgw8iTrilfHrzy1JnzumOrPGPAanhrjja3TTWYmVWZzZYjglrmR0sNIGqtokrlaXCrVFZ7WnQTUqRLAhnOy30eJOd/PJuLkYfo+XbdeoxF5gPSPKe+Dc4C3sL46zw46/jKpN+RkbAJiE4j8vtu8894A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760991978; c=relaxed/simple;
	bh=LMM51eIhIp7n/9giiwZgVtM++B+PXbR+p13sjidtJf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IxLA+BccNQ264magsZkv9pkbElLpfYusBXgYLvOqncNpgY4w9+ZP219TaQRPtDnt6WFMKbznri3dpXc4FGw0T0PjHIr+EyT7u0O2p5vWvWJDslKMTyvW61Z7HUzw7J3I9vxQJeUO3YzpVflcimFMr4AlLDHUX/X8AxBgxVBEXy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=szXIxzzz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3CAFC113D0;
	Mon, 20 Oct 2025 20:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760991978;
	bh=LMM51eIhIp7n/9giiwZgVtM++B+PXbR+p13sjidtJf8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=szXIxzzzt+rVX28V2JYGsNwbJcblSONgIHmi/fDQIHrrKbpDzyRTTX+Y2lw9R7Pyc
	 k6Skm+4UcE+ofOwcz7PnB34CIx5Rz9VbBdNwdAUlhW5QvrPFBYfbznS3sIfrgQivES
	 4/bmfz5jy+KGjteMCxCLpM7jWVzndfNdLnGBazbEKy1kapBZkPqMnH38+5IHQVv35o
	 IqFM3MrLzaCqauTihj47fdrPssY3LImRdlqErWAr+r31as50x/5/a+NPB1bX6UKQdF
	 H0xqnjNApiq9i12mT7HkAVvSCJ80O5+hXDCf1fZFMjwjHOkPXpwnIxBAxHrBOrem4x
	 fBKxMso7WWHSQ==
Date: Mon, 20 Oct 2025 13:26:17 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Subject: [PATCH 17/16] fuse2fs: recheck support after replaying journal
Message-ID: <20251020202617.GM6170@frogsfrogsfrogs>
References: <176062915393.3343688.9810444125172113159.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <176062915393.3343688.9810444125172113159.stgit@frogsfrogsfrogs>

From: Darrick J. Wong <djwong@kernel.org>

The journal could have contained a new primary superblock, so we need to
recheck feature support after recovering it, because otherwise fuse2fs
could blow up on an unsupported feature that was enabled by a journal
transaction.

We also don't need to clear needsrecovery or dirty the superblock after
recovering the journal because ext2fs_run_ext3_journal does that for us.
Remove those lines.

Cc: <linux-ext4@vger.kernel.org> # v1.43
Fixes: 81cbf1ef4f5dab ("misc: add fuse2fs, a FUSE server for e2fsprogs")
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |   60 ++++++++++++++++++++++++++++++++++----------------------
 1 file changed, 36 insertions(+), 24 deletions(-)

diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index e33b09de08a11f..931e60f61e85b6 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -744,6 +744,36 @@ static int check_inum_access(struct fuse2fs *ff, ext2_ino_t ino, int mask)
 	return -EACCES;
 }
 
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
 static void op_destroy(void *p EXT2FS_ATTR((unused)))
 {
 	struct fuse_context *ctxt = fuse_get_context();
@@ -4771,29 +4801,9 @@ int main(int argc, char *argv[])
 	}
 
 	ret = 3;
-
-	if (ext2fs_has_feature_quota(global_fs->super)) {
-		err_printf(&fctx, "%s", _("quotas not supported."));
+	err = fuse2fs_check_support(&fctx);
+	if (err)
 		goto out;
-	}
-	if (ext2fs_has_feature_verity(global_fs->super)) {
-		err_printf(&fctx, "%s", _("verity not supported."));
-		goto out;
-	}
-	if (ext2fs_has_feature_encrypt(global_fs->super)) {
-		err_printf(&fctx, "%s", _("encryption not supported."));
-		goto out;
-	}
-	if (ext2fs_has_feature_casefold(global_fs->super)) {
-		err_printf(&fctx, "%s", _("casefolding not supported."));
-		goto out;
-	}
-
-	if (global_fs->super->s_state & EXT2_ERROR_FS) {
-		err_printf(&fctx, "%s\n",
- _("Errors detected; running e2fsck is required."));
-		goto out;
-	}
 
 	/*
 	 * ext4 can't do COW of shared blocks, so if the feature is enabled,
@@ -4817,8 +4827,10 @@ int main(int argc, char *argv[])
 						_("Please run e2fsck -fy."));
 				goto out;
 			}
-			ext2fs_clear_feature_journal_needs_recovery(global_fs->super);
-			ext2fs_mark_super_dirty(global_fs);
+
+			err = fuse2fs_check_support(&fctx);
+			if (err)
+				goto out;
 		}
 	} else if (ext2fs_has_feature_journal(global_fs->super)) {
 		err = ext2fs_check_ext3_journal(global_fs);

