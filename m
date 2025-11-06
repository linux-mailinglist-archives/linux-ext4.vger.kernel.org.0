Return-Path: <linux-ext4+bounces-11565-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 65D28C3D9D1
	for <lists+linux-ext4@lfdr.de>; Thu, 06 Nov 2025 23:32:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5F9F44E5408
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Nov 2025 22:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B17230EF91;
	Thu,  6 Nov 2025 22:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cYYjSjq3"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EFCF3074AC
	for <linux-ext4@vger.kernel.org>; Thu,  6 Nov 2025 22:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762468361; cv=none; b=CloLzY9qMW3jGU+ic9Ww+BYXiLWi0q4XYcdnS/SE94010aqvK48hu/6QM04cNDXXVXWYJFnwHcPowO0WDtVnMNAbp4Om949zQtoh+/sgUPBg7uhHe+1Iy7AAB2pxR8RSi9hhMBxygQVrg0ZtrM2BSPk/MY23FjBcYbIBV7g5h+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762468361; c=relaxed/simple;
	bh=5t9tEEtOv0koSEVHZLbUKm7SIU6GD870YrJjOb1YW2E=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eF21pHznKavDmG0UvscO3jAbFYgUNqcMcXh+A+HPphtvp2D1J1YjurC2tAtx7BCTIVQvmCpCDoAdOKNOgwqnRklLVLppodkHRVQ8j3RU+jm5iD1xFQF4bovCi1D4oXIhjpB/+CgTWPdjXj34p/uUgs5XbL3rUH2YgQrt7+CuF38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cYYjSjq3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0063C4CEFB;
	Thu,  6 Nov 2025 22:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762468361;
	bh=5t9tEEtOv0koSEVHZLbUKm7SIU6GD870YrJjOb1YW2E=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=cYYjSjq3ozLvqlnwaIcR4gCOLQgEIAsUTsmW5j4Bd7O0fFcFIxIKCP13byN/6dezK
	 2ymrJQN0gFgxO1qWEzCnvyuzJVRmIJfmLMG3+JJVMU0nhXTSpaAYPGyz9m6svQu2nC
	 VNoSHf0UqX90TNVXVgV7miimhy3IDFl5GbdCYIgnUCOyCgE3JgGJO7UqDvyODI6FBn
	 eQ3BHYHau9i7lgVk4tpZJHLTRPS0zuDS5k88IGsX15S/wWzI478IfaiGLjRUZd1+ye
	 zW8YFtHjeJ6/tRFrAb+2CUpriiisspxRgoMHNDSKkgJVPb5dTLqFLdIXrEZHhc5AUK
	 UCiBUpksfMmEA==
Date: Thu, 06 Nov 2025 14:32:40 -0800
Subject: [PATCH 06/19] fuse2fs: check root directory while mounting
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <176246793736.2862242.11081924753606751125.stgit@frogsfrogsfrogs>
In-Reply-To: <176246793541.2862242.16879509838698966689.stgit@frogsfrogsfrogs>
References: <176246793541.2862242.16879509838698966689.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

The kernel will fail a mount attempt if the root directory inode isn't
even minimally readable at mount time.  Do the same for fuse2fs so that
we can pass ext4/008.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |   17 +++++++++++++++++
 1 file changed, 17 insertions(+)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 76872d793ea394..3e02eb13ec5488 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -4726,6 +4726,19 @@ static unsigned long long default_cache_size(void)
 	return ret;
 }
 
+/* Make sure the root directory is readable. */
+static errcode_t fuse2fs_check_root_dir(ext2_filsys fs)
+{
+	struct ext2_inode_large inode;
+	errcode_t err;
+
+	err = fuse2fs_read_inode(fs, EXT2_ROOT_INO, &inode);
+	if (err)
+		return translate_error(fs, EXT2_ROOT_INO, err);
+
+	return 0;
+}
+
 int main(int argc, char *argv[])
 {
 	struct fuse_args args = FUSE_ARGS_INIT(argc, argv);
@@ -4978,6 +4991,10 @@ int main(int argc, char *argv[])
 		}
 	}
 
+	ret = fuse2fs_check_root_dir(global_fs);
+	if (ret)
+		goto out;
+
 	if (global_fs->flags & EXT2_FLAG_RW) {
 		if (ext2fs_has_feature_journal(global_fs->super))
 			log_printf(&fctx, "%s",


