Return-Path: <linux-ext4+bounces-9413-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EEF0B2E900
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Aug 2025 01:45:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2CAB47BD0A8
	for <lists+linux-ext4@lfdr.de>; Wed, 20 Aug 2025 23:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C62C2E11CA;
	Wed, 20 Aug 2025 23:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oLp2xlR/"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100E52E0B48
	for <linux-ext4@vger.kernel.org>; Wed, 20 Aug 2025 23:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755733425; cv=none; b=JQZG8KFi7ilnEWUaVi5t9dPIDWPN3dxGkRiZz3y1ZyXY451USYRFYEciORfX/Uw1Pwbdww2pvrsXQ0AmpW7vZrUrmVYts6cYtu6bKjCOsD0C/A7rjuPyjV6RIuZFZyNaPFeBnPkz31O7mWorzfRVByBXQV4xFy6R1q8BB4FEua0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755733425; c=relaxed/simple;
	bh=XjRv1cRNJuNsVluHi6FffR9D3xFoNDJhbL95ocok2pw=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d+pDciAr4LIjbU2mTzc1ygFWU72fhF4NvedhccBcy4VtKpWrH507hSPHkTFilqziFtNwyNOstDfDBF1m9rkdjbFW7K5R3PPGo9gIMS1yrHkRQRkn69f+n6XGuJmDV9PNJVyp25vxIuadD+JuCKpwufaCH2zXqkmIrDZbafxvZeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oLp2xlR/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC093C4CEEB;
	Wed, 20 Aug 2025 23:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755733424;
	bh=XjRv1cRNJuNsVluHi6FffR9D3xFoNDJhbL95ocok2pw=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=oLp2xlR/EjXRv4BOazgv0E9SkNQmTK3iFnABQo+XHivpbCIya6j+Pe9hnLYGc4DD2
	 9zAbtoYDERFCGc7wawsDkkcTKuQ7u9mh6uD0TtfCyjJ/84Ulc9yWON3rXsb/gOKpTA
	 UgQmtRwRLkJc9AD71pc78Qa3hzqs7aZ3DrolEJCcxtUH3bsEqkPpTSY7byeinY92Vj
	 KfLHQQEEF3aB3RmUSu/oM8heXl9HnjvhQVoNcMklJNJU0rh5wIK7msNI4J5KGp2WWI
	 99Tj0Vr7l1W9JXEiAsYznenNuDIWmWYir3m28iOiC3Ljyd5cT2/VYFp55awjMZySC7
	 hpGQUyrAUUxKQ==
Date: Wed, 20 Aug 2025 16:43:44 -0700
Subject: [PATCH 11/12] fuse2fs: disable fallocate/zero range on indirect files
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org, linux-ext4@vger.kernel.org
Message-ID: <175573318801.4130038.5441212769275575364.stgit@frogsfrogsfrogs>
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

Indirect mapped files can't have unwritten extents, so we can't do
unwritten preallocation or zero-range because both depend on unwritten
extents.

Cc: <linux-ext4@vger.kernel.org> # v1.43
Fixes: 81cbf1ef4f5dab ("misc: add fuse2fs, a FUSE server for e2fsprogs")
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 318bfb55345b9b..cb5620c7e2ee33 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -4137,6 +4137,10 @@ static int fallocate_helper(struct fuse_file_info *fp, int mode, off_t offset,
 		return err;
 	fsize = EXT2_I_SIZE(&inode);
 
+	/* Indirect files do not support unwritten extents */
+	if (!(inode.i_flags & EXT4_EXTENTS_FL))
+		return -EOPNOTSUPP;
+
 	/* Allocate a bunch of blocks */
 	flags = (mode & FL_KEEP_SIZE_FLAG ? 0 :
 			EXT2_FALLOCATE_INIT_BEYOND_EOF);
@@ -4279,6 +4283,14 @@ static int punch_helper(struct fuse_file_info *fp, int mode, off_t offset,
 	if (err)
 		return translate_error(fs, fh->ino, err);
 
+	/*
+	 * Indirect files do not support unwritten extents, which means we
+	 * can't support zero range.  Punch goes first in zero-range, which
+	 * is why the check is here.
+	 */
+	if ((mode & FL_ZERO_RANGE_FLAG) && !(inode.i_flags & EXT4_EXTENTS_FL))
+		return -EOPNOTSUPP;
+
 	/* Zero everything before the first block and after the last block */
 	if (FUSE2FS_B_TO_FSBT(ff, offset) == FUSE2FS_B_TO_FSBT(ff, offset + len))
 		err = clean_block_middle(ff, fh->ino, &inode, offset,


