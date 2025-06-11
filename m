Return-Path: <linux-ext4+bounces-8364-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B164CAD5C87
	for <lists+linux-ext4@lfdr.de>; Wed, 11 Jun 2025 18:44:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7AA73A2CCF
	for <lists+linux-ext4@lfdr.de>; Wed, 11 Jun 2025 16:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 271CA2139B6;
	Wed, 11 Jun 2025 16:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="je3GpWA1"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C101F202C5A
	for <linux-ext4@vger.kernel.org>; Wed, 11 Jun 2025 16:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749660227; cv=none; b=HV+iBshxbNJfP7tS/x5+02XDkGI2PP4K24h/csLUkUokg7zqxwh2EAbdpDifGl53WwT2awwMMGJVurFTLpoA8i+pBO+j4IZuV4Hl8F01Ji8bGns7sq+kMYPwYMmY/OjhPMYkrsspdG0FY4exz+5HezFUpfSA5vAM+pcNXzrHv9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749660227; c=relaxed/simple;
	bh=rXzGlDsTr8SM4ootJzMbmqN8NxVeG2Yn99gO44SFhKY=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pr3Uof4uC+lFJaIzV8Cg29MUWtKIRwYDrX0RaoTg083OEEcQjr4SxsRrJw9Qd81vQ2WO6hh7/rZRDudHtqX7kE83Tw/qEnFplJH5kmTfaWujPYADVw+7UgetHC945fGkYzaQZAuZTBVrnp7I3pGJo+MzhUiRTcF1mxgZFk86kBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=je3GpWA1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33038C4CEE3;
	Wed, 11 Jun 2025 16:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749660226;
	bh=rXzGlDsTr8SM4ootJzMbmqN8NxVeG2Yn99gO44SFhKY=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=je3GpWA1qG1h5fIZItchiJDRGIHNlej1O9zZ4upSHOkDkVqZ3yt2/o4dGovEpds5O
	 5bA/C2RqRJq//vmb0L/R6dcu78k66XcXSQrWg768eJlqKOZeqtqR3WJ9MaR9Ndi1Ns
	 DgdfRsAd571OL63/LCQb6Y97tdLVoQwrS9gU1wfrtTl6UAB/7/FC938k8REUWx+r2X
	 gZi9JbslyTZRF4E0LjjwZKyOQNdeJ/PdtKFyt2YHacSvYVX5ine+m1livuw8moLIId
	 qkdg6hlY/e36qSl9XQvcNHsop0qyzl5i9D5v4SMn+UFlsZ+JjO3bA28T0HECeEcoWp
	 3k1oG33m0ojDg==
Date: Wed, 11 Jun 2025 09:43:45 -0700
Subject: [PATCH 1/3] libext2fs: fix spurious warnings from fallocate
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org, linux-ext4@vger.kernel.org
Message-ID: <174966018070.3972888.9575426474425493201.stgit@frogsfrogsfrogs>
In-Reply-To: <174966018041.3972888.391896904012834159.stgit@frogsfrogsfrogs>
References: <174966018041.3972888.391896904012834159.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

generic/522 routinely produces error messages from fuse2fs like this:

FUSE2FS (sde): Illegal block number passed to ext2fs_test_block_bitmap #9321 for block bitmap for /dev/sde

Curiously, these don't actually result in errors being thrown up to the
kernel.  Digging into the program (which was more difficult than it
needed to be because of the weird bitmap base + errcode weirdness)
produced a left record:

e_lblk = 16
e_pblk = 9293
e_len = 6
e_flags = 0

and a right record:

e_lblk = 45
e_pblk = 9321
e_len = 6
e_flags = 0

Thus we end up in the "Merge both extents together, perhaps?" section of
ext_falloc_helper.  Unfortunately, the merge selection code isn't smart
enough to notice that the two mappings aren't actually physically
contiguous, so it scans the bitmap with a negative length, which is why
the assertion trips.

The simple fix here is not to try to merge the adjacent extents if
they're not actually physically contiguous.

Cc: <linux-ext4@vger.kernel.org> # v1.43
Fixes: 5aad5b8e0e3cfa ("libext2fs: implement fallocate")
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 lib/ext2fs/fallocate.c |    5 +++++
 1 file changed, 5 insertions(+)


diff --git a/lib/ext2fs/fallocate.c b/lib/ext2fs/fallocate.c
index 5cde7d5c2dc28b..063242c5fa4e6b 100644
--- a/lib/ext2fs/fallocate.c
+++ b/lib/ext2fs/fallocate.c
@@ -276,6 +276,11 @@ static errcode_t ext_falloc_helper(ext2_filsys fs,
 				max_uninit_len : max_init_len))
 			goto try_left;
 
+		/* Would they even be physically contiguous if merged? */
+		if (left_ext->e_pblk + left_ext->e_len + range_len !=
+				right_ext->e_pblk)
+			goto try_left;
+
 		err = ext2fs_extent_goto(handle, left_ext->e_lblk);
 		if (err)
 			goto try_left;


