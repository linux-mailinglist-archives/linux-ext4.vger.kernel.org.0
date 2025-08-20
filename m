Return-Path: <linux-ext4+bounces-9409-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3403CB2E8FF
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Aug 2025 01:45:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCF4D7262C6
	for <lists+linux-ext4@lfdr.de>; Wed, 20 Aug 2025 23:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 433FF2E229D;
	Wed, 20 Aug 2025 23:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lcoKRQ1R"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBFEC2E0B48
	for <linux-ext4@vger.kernel.org>; Wed, 20 Aug 2025 23:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755733362; cv=none; b=jNQc9+L0i7zuot8TOFHPCK4D6Oa87H4UnVDtGwsbyuNwnE6yjA/t0I3Dqs5OSQemZPSdWrgmRQYyvnJB2dIXq/ILh5IXQS7WRXwBNUgIroEBuFabtMjDrgr9eugC2VLs6PEz2MNvqmMZQIT4+f7N+AmbBZc4R5L0hcjLjSThTO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755733362; c=relaxed/simple;
	bh=cS9/Z7EKvW/UGVl3Vo5nKGOLRZ2/D2fdo/kka2ci4Xs=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fqwvhC9zJnG+N948TiiIUPIrIiW6tigPhpqpxRJA1h129eLtK/Rtb1s8hbhVaTOUXY3lq1kaEhaJNGbGUXhAyu4U0Dj2DkGjCDdF3Vnfm+kFfnSec/pJfDjwvzIUKxiwWJsYZn0tLQucaANH1yRu0j5eCulJrovsDfg9afwxIm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lcoKRQ1R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 647B1C4CEE7;
	Wed, 20 Aug 2025 23:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755733362;
	bh=cS9/Z7EKvW/UGVl3Vo5nKGOLRZ2/D2fdo/kka2ci4Xs=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=lcoKRQ1Rw9GsrpLxed8wZnXmgRGKz0coZ4btUoAdO0kXN+jZXiMyX3ciqErsaFIdW
	 SJNZ++WKqH+u/J16fDdzv5d5X22/lT8v7t+jfrv0QvSzlkiE2+CBMhsGbj9EoGW3Tm
	 9dLMJBIzqo3e4UqIsW2KJZqNnVWa0W8eKKciPjYHqzWFKYqFLl7Vd71AzY/tVI+qCg
	 Hl1pAtbcJQWJrOXx3bGRHdWosP8Hzka1EvmYo/fePpjTFsyLs6yjVf56vUb2wmTtu3
	 xoSPLG0EblbFTHoQx4NbKZlNkpECpLtk8zOEy3tBHjwDmMrRJComOYkCNiU5hOpxe2
	 1Nl3KrFqeLIDw==
Date: Wed, 20 Aug 2025 16:42:42 -0700
Subject: [PATCH 07/12] fuse2fs: check for recorded fs errors before touching
 things
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org, linux-ext4@vger.kernel.org
Message-ID: <175573318728.4130038.7753543107737909252.stgit@frogsfrogsfrogs>
In-Reply-To: <175573318553.4130038.2069350865263085609.stgit@frogsfrogsfrogs>
References: <175573318553.4130038.2069350865263085609.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Refuse the mount if there are errors recorded in the superblock.  We
should not be trying to replay the journal on damaged filesystems.

Cc: <linux-ext4@vger.kernel.org> # v1.43
Fixes: 81cbf1ef4f5dab ("misc: add fuse2fs, a FUSE server for e2fsprogs")
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index c201f95e771b85..415f174875922f 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -4723,6 +4723,12 @@ int main(int argc, char *argv[])
 		goto out;
 	}
 
+	if (global_fs->super->s_state & EXT2_ERROR_FS) {
+		err_printf(&fctx, "%s\n",
+ _("Errors detected; running e2fsck is required."));
+		goto out;
+	}
+
 	/*
 	 * ext4 can't do COW of shared blocks, so if the feature is enabled,
 	 * we must force ro mode.
@@ -4784,12 +4790,6 @@ int main(int argc, char *argv[])
 		err_printf(&fctx, "%s\n",
  _("Orphans detected; running e2fsck is recommended."));
 
-	if (global_fs->super->s_state & EXT2_ERROR_FS) {
-		err_printf(&fctx, "%s\n",
- _("Errors detected; running e2fsck is required."));
-		goto out;
-	}
-
 	/* Clear the valid flag so that an unclean shutdown forces a fsck */
 	if (global_fs->flags & EXT2_FLAG_RW) {
 		global_fs->super->s_mnt_count++;


