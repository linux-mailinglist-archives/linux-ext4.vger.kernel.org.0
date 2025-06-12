Return-Path: <linux-ext4+bounces-8402-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16BF3AD7E4E
	for <lists+linux-ext4@lfdr.de>; Fri, 13 Jun 2025 00:18:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C22ED3B6841
	for <lists+linux-ext4@lfdr.de>; Thu, 12 Jun 2025 22:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E84C1224893;
	Thu, 12 Jun 2025 22:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SoRaeo4q"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D4F522F
	for <linux-ext4@vger.kernel.org>; Thu, 12 Jun 2025 22:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749766707; cv=none; b=OrJaOYKpFizzBubrVlJPIROLA+JQVuXo0WsPT5X+AUBrP6wADXvsqa4imXb2vy2pC7c/rAK4xLa/3x9KJuM+aGNfLaA0FWBgTG2ciesY3FjMOZs3uDs1VAQYKqSStu+O6bRiVyfd2CKPvs97Y8RwBorKRQ4CV5c8O3DJ+YeyF9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749766707; c=relaxed/simple;
	bh=mhUafVeTRUpDGpEKzKlzEXAnptTasYHajjtV07K0ELM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gtO+oYVr5gLG5EAvDRicGqQXDjOAVMpIGxhG/kbfGRXorLxfpqWggxPzg9tEPRiPZIWLI4RKsRZs59tMYnN2Qvat+8Xpl2/d7rqxrDmOng0BVAgJ77lKE1tP1y9C0mD0O78C8MQpp8yRPXCWp8SCzamprFPGrRKcRKhqPd6iQGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SoRaeo4q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02E22C4CEEA;
	Thu, 12 Jun 2025 22:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749766707;
	bh=mhUafVeTRUpDGpEKzKlzEXAnptTasYHajjtV07K0ELM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SoRaeo4qK/+/6BRLHTnoYMQ0Ue7yduZ6Vl82Jm1Ec0BKF3wJNdZ7XNoiPtU+94YiG
	 7PWs5upuoz9fxAFkKdw5mTo9Cw++AVRHgWL7LwsTLyewT5sp5bBo1AUwKxkx/Cgz7B
	 vF4+ZJxuHxlPVu723aWUmJ0/RGxZ9hGseMDjCz8pgRBQra4spg7z9PsKWmFGm+uCZe
	 3EosAJw5BrykAr3eiZttvw5PoVvR3BP9wTlPPmASmonezESVczMlvBIfTrld9LeQWQ
	 xzFZjh4lL9IDkAPSGNNKzivFLtKuSz/l55bifHj1cwDFKrQZLg+xuJQOU4J8Tli8f2
	 kKcIAjMVejTxg==
Date: Thu, 12 Jun 2025 15:18:26 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Subject: [PATCH 4/3] libext2fs: fix bounding error in the extent fallocate
 code
Message-ID: <20250612221826.GE6134@frogsfrogsfrogs>
References: <174966018041.3972888.391896904012834159.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <174966018041.3972888.391896904012834159.stgit@frogsfrogsfrogs>

From: Darrick J. Wong <djwong@kernel.org>

generic/361 popped up this weird error:

generic/361       [failed, exit status 1]- output mismatch (see /var/tmp/fstests/generic/361.out.bad)
    --- tests/generic/361.out   2025-04-30 16:20:44.563589363 -0700
    +++ /var/tmp/fstests/generic/361.out.bad    2025-06-11 10:40:07.475036412 -0700
    @@ -1,2 +1,2 @@
     QA output created by 361
    -Silence is golden
    +mkfs.fuse.ext4: Input/output error while writing out and closing file system
    ...
    (Run 'diff -u /run/fstests/bin/tests/generic/361.out /var/tmp/fstests/generic/361.out.bad'  to see the entire diff)

The test formats a small filesystem, creates a larger sparse file, loop
mounts it, and tries to format an ext4 filesystem on the loopdev.  The
loop driver sends fallocate zero_range requests to fuse2fs, but stumbles
over this extent tree layout when fallocating 16 blocks at offset 145:

EXTENTS:
(262128-262143[u]):2127-2142

fallocate goes to offset 145, and sees the right-extent at 262128.
Oddly, it then tries to allocate 262128-145 blocks instead of the 16
that were asked for, so it tries to allocate a huge number of blocks
but then crashes and burns when it runs out of space.

Fix this by constraining the len parameter to ext_falloc_helper to the
correct value.

Cc: <linux-ext4@vger.kernel.org> # v1.43
Fixes: 5aad5b8e0e3cfa ("libext2fs: implement fallocate")
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 lib/ext2fs/fallocate.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/ext2fs/fallocate.c b/lib/ext2fs/fallocate.c
index 063242c5fa4e6b..1ef989cd38214d 100644
--- a/lib/ext2fs/fallocate.c
+++ b/lib/ext2fs/fallocate.c
@@ -718,7 +718,8 @@ static errcode_t extent_fallocate(ext2_filsys fs, int flags, ext2_ino_t ino,
 		goal = left_extent.e_pblk - (left_extent.e_lblk - start);
 		err = ext_falloc_helper(fs, flags, ino, inode, handle, NULL,
 					&left_extent, start,
-					left_extent.e_lblk - start, goal);
+					min(len, left_extent.e_lblk - start),
+					goal);
 		if (err)
 			goto errout;
 

