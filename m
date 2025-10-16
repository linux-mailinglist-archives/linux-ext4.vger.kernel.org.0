Return-Path: <linux-ext4+bounces-10904-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 98BD5BE44E0
	for <lists+linux-ext4@lfdr.de>; Thu, 16 Oct 2025 17:43:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 888494E7912
	for <lists+linux-ext4@lfdr.de>; Thu, 16 Oct 2025 15:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CACF1343D9E;
	Thu, 16 Oct 2025 15:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HMrI18kP"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCFF2E764B
	for <linux-ext4@vger.kernel.org>; Thu, 16 Oct 2025 15:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760629376; cv=none; b=f0EzKe21fjE7LfyKjPnI3oK+CJlpxPzOPF5EbnDIMXD527hyjk+dxV/hQXaT4vWnWNlgEIPZd4IMwCyczpGQYdzTnbqKwc2IZugqtO6Y9F1bn0a8Wq3nDw8IBJmU3WURJ2gZjx34XCtil9//Bm5sPcDMbflbxKHFKFzN2BLyE2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760629376; c=relaxed/simple;
	bh=fyuVsinQxpCpcN9FMNY19NQVopRsVYRnuQ1Tr8E032c=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j6OX1ExkY0HUIQX33F+nn5P0G9wHo48E1o3PucErPle6xUWNqxPolGN3zH/I66b8jZb61Z2x44DL/8VIF4YYiAkXkzrNpYLEwTIy1wwH+GFOpoHMYpXEduVczS5EDk7s8Wf8yqGVXfhJmW8ObmYkBkAspoDLKcJmIPP8UFOQ+q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HMrI18kP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39745C4CEF1;
	Thu, 16 Oct 2025 15:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760629376;
	bh=fyuVsinQxpCpcN9FMNY19NQVopRsVYRnuQ1Tr8E032c=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=HMrI18kPG77SEwYG03m8l+XU7b7I9YuDPV4EcIQGdEZVr/4h014rIkmeHRo1vqTpa
	 /B4pgpdY+wcDBgM/siHW8kWdxkbDahqIuDwlII2f9FYXfrp5D4k9kUFrkgOXoJjd0Q
	 /J1kRZROzLqvMb/FJAlV+INfCYhQv9a0iNWLYrSEmHW+8/s3jOIMFKhTAlAGazsrZB
	 8P/UeA6bu+Sz1yMKrfF6sqsukiiKI4Ds9Vpbmzgh6uvd87SGVi4RxoB5XNL1zFlx3C
	 C1jC2abhLUbdW5Y/Z1gfZt6cdf9h2WGtWwPm+z/QaBscCSl+jDvt9zO6R8JWm9lfh4
	 cIqA7kRPdl8Cw==
Date: Thu, 16 Oct 2025 08:42:55 -0700
Subject: [PATCH 12/16] fuse2fs: don't update atime when reading executable
 file content
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org, linux-ext4@vger.kernel.org
Message-ID: <176062915683.3343688.12383231887240168348.stgit@frogsfrogsfrogs>
In-Reply-To: <176062915393.3343688.9810444125172113159.stgit@frogsfrogsfrogs>
References: <176062915393.3343688.9810444125172113159.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

The kernel doesn't update the atime of program files when it's paging
their content into memory, so fuse2fs shouldn't either.  Found by
generic/120.

Cc: <linux-ext4@vger.kernel.org> # v1.43
Fixes: 81cbf1ef4f5dab ("misc: add fuse2fs, a FUSE server for e2fsprogs")
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 0f655c41372cc7..0ecdd4f9e93225 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -207,6 +207,7 @@ struct fuse2fs_file_handle {
 	unsigned long magic;
 	ext2_ino_t ino;
 	int open_flags;
+	int check_flags;
 };
 
 /* Main program context */
@@ -2672,6 +2673,7 @@ static int __op_open(struct fuse2fs *ff, const char *path,
 			ret = check_inum_access(ff, file->ino, X_OK);
 			if (ret)
 				goto out;
+			check = X_OK;
 		} else
 			goto out;
 	}
@@ -2682,6 +2684,7 @@ static int __op_open(struct fuse2fs *ff, const char *path,
 			goto out;
 	}
 
+	file->check_flags = check;
 	fp->fh = (uintptr_t)file;
 
 out:
@@ -2750,7 +2753,7 @@ static int op_read(const char *path EXT2FS_ATTR((unused)), char *buf,
 		goto out;
 	}
 
-	if (fs_writeable(fs)) {
+	if (fh->check_flags != X_OK && fs_writeable(fs)) {
 		ret = update_atime(fs, fh->ino);
 		if (ret)
 			goto out;


