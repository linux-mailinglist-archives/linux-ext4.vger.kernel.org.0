Return-Path: <linux-ext4+bounces-10061-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D688B587A4
	for <lists+linux-ext4@lfdr.de>; Tue, 16 Sep 2025 00:40:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A292E189D1D6
	for <lists+linux-ext4@lfdr.de>; Mon, 15 Sep 2025 22:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9966F2D47E7;
	Mon, 15 Sep 2025 22:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R9mysWO9"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE402D23A4
	for <linux-ext4@vger.kernel.org>; Mon, 15 Sep 2025 22:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757976005; cv=none; b=Fv7jBSxuW4iyFUrAoi7R2UYWQ4TJz3CXA2BtipL2ItRZElAWGDqQKVA/KZE1R1LOt78K/DWTKAB2gxiDsMelqXcSZbf3/TrWrFNtXDKMR1WYke6mKScn9ZU95Sn2oMrxmg9TusTPWPJeP9O9m513DAJvWNq6j+8HmMPfzwvfHRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757976005; c=relaxed/simple;
	bh=qCCZdA9FoQTjhDOSrsYqbdOtMzMRgqv1zKHTGB9CERs=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kT5cDh816IfmLU0C4IrYAdBuI8+IPqUqVtWraOKZEFOGT+lK9Hou+qgPMPguM3lZM2L2iz258lC3CTM+Dkj9RzUkXcqUqPEsSA3HOl572mFUh//jPmS7l19rLvFkeE8FjwWUEgl7uMZEfFcz93pl7sALfziQMH5jv2uK3ZCdHeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R9mysWO9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ACE9C4CEF1;
	Mon, 15 Sep 2025 22:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757976004;
	bh=qCCZdA9FoQTjhDOSrsYqbdOtMzMRgqv1zKHTGB9CERs=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=R9mysWO9WE/l+5zrcy3LsjP00eUGcwC4h/eGTIP2zDIz8AQ/Oxt3oLIl9FjDA4FC6
	 5gOS0t5tRRTaGPJBvvyzBd8JJ97EbbSNyncxOFtp/6Iv9XvYKcZ+KlQnMg5zX3XqYl
	 dFRrQdm5rdpuxnLFuM5QdaDIa0YQNQa97B9Cq7H+gmwtDgX6vjvY4DLXItrY6M9aIm
	 3/Bx5dSvBK6shyQl912jZ+qlR05chM7C4mjLjuuPvHGeYjOXFzS/Sk2lhokGiBcCQ6
	 ChagqeYph8j0Sojd+aYDo2A7D6dvnER173eZa+8wjeEfe4KfXfaug5yMVx6W3KDyMr
	 hxvErJcl/elKQ==
Date: Mon, 15 Sep 2025 15:40:04 -0700
Subject: [PATCH 09/12] fuse2fs: don't update atime when reading executable
 file content
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org, linux-ext4@vger.kernel.org
Message-ID: <175797569781.245695.5266717490613586824.stgit@frogsfrogsfrogs>
In-Reply-To: <175797569564.245695.4628729304068635201.stgit@frogsfrogsfrogs>
References: <175797569564.245695.4628729304068635201.stgit@frogsfrogsfrogs>
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
index b5b860466742d2..a075e3055bd743 100644
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


