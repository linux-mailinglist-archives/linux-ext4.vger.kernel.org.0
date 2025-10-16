Return-Path: <linux-ext4+bounces-10896-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9F24BE44F2
	for <lists+linux-ext4@lfdr.de>; Thu, 16 Oct 2025 17:43:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2259E3ADACA
	for <lists+linux-ext4@lfdr.de>; Thu, 16 Oct 2025 15:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3399934AB10;
	Thu, 16 Oct 2025 15:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NBO5mxGE"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA596259CAF
	for <linux-ext4@vger.kernel.org>; Thu, 16 Oct 2025 15:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760629250; cv=none; b=aGufIhllI+ZyS0H5CDfsiZnB9etbiulRsBxVPCTGWaOUHzRqj+sUM0tgQ+h3wCz5zLSvyW0Q22udIZx1wvnc98lRYOyxItZKRfWJjFt2rb3IcXVl2lQRnMTLEIDiQ2urW48YPIi4fdFbo8TS0aKHOWfMuvS9d9kGuNyj58AlD+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760629250; c=relaxed/simple;
	bh=P+ttcvCMkFz41NE0QWbyyZdMOdsVGFww2jri4CTWp8Y=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UviVEkPvE/Bv9/s8z3QPShxNcgGpOid0VaRMlUaRiQINN/U8ZR+M3joKN0XZoi6wWo67UwKuWDjb9lucV1+06gURcyf1qk86Wi/nZG1mfuZveQ1D+YHhrRLa0SkIi4T1EoShmckoZ/xQWDsEYnHv9cHIJrkODl+duD7+zJw/mJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NBO5mxGE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F0B4C4CEF1;
	Thu, 16 Oct 2025 15:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760629250;
	bh=P+ttcvCMkFz41NE0QWbyyZdMOdsVGFww2jri4CTWp8Y=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=NBO5mxGERP6xePIqwdJHcPdGNMOQq6kutsIz554VLxDo/ydRyZwGT5YEVicwwLAl3
	 goVHr12ZGmbP40bY1Ew4S9yH7bvaIbEkNFYyuaJ3dz8QHJ0b92NNlQdK2TG7g+B+08
	 VWFtdOclQRmGDKvhLtC9kPzLHRH7xUB1MwSNYK6QgU9EGo09rfKteVHd5gxLYZNzx4
	 H4dSWeICYc8zSMMe+bVMNNSGbOjK1em7KrpSAjmjhDZFjLa+slXfd44Z9Yfvazn6Vd
	 uSabCqgR1G6jY34N8sAbY+DKWRqFfXfPqiiAw1ooV/tRNBsyyrZtaz/mfTQs33oDq2
	 dYizXURkl2K8A==
Date: Thu, 16 Oct 2025 08:40:49 -0700
Subject: [PATCH 04/16] libext2fs: fix ind_punch recursive block computation
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org, linux-ext4@vger.kernel.org
Message-ID: <176062915537.3343688.2245819523975318264.stgit@frogsfrogsfrogs>
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

generic/742 writes a large file and calls punch-alternating to punch out
every other block in the file.  Unfortunately, there's a bug in
ind_punch that causes it to turn a request to punch out file block 2060
into punching out every file block *starting* at block 2060.  The
emptying out of the block mapping causes a FIEMAP call in that test to
loop forever, which causes fuse4fs testing of ext3 to halt.

ext2fs_punch_ind recursively calls ind_punch on each level of the
indirect map to unmap file blocks.  The start and count parameters to
ind_punch are (I think) the file range to punch given a particular block
and level within the indirect map, but shifted down by the start of the
logical file range mapped by that level in the indirect tree.  To call
ind_punch for the next level down, we need to compute the new range.
But first, a diversion back to the failing testcase:

Note that file block 2060 is the first block mapped by the second
double-indirect block in the file:

(0-11):935-946, (IND):947, (12-1035):948-1971, (DIND):1972, (IND):1973,
(1036-2059):1974-2997, (IND):2998, (2060-3083):2999-4022, (IND):4023,
(3084-4107):4024-5047, (IND):5048, (4108-5131):5049-6072, (IND):6073,
(5132-6155):6074-7097, (IND):7098, (6156-7179):7099-8122, (IND):8123,
(7180-8203):8124-9147, (IND):9148, (8204-9227):9149-10172, (IND):10173,
(9228-9999):10174-10945 TOTAL: 10011

At this point, enabling PUNCH_DEBUG produces the following:

FUSE4FS (sda): tid=72529 fuse4fs_punch_range: ino=53 mode=0x3 offset=0x80c000 len=0x1000 start=0x80c end=0x80d
Main loop level 0, start 2060 count 1 max 12 num 12
Main loop level 1, start 2048 count 1 max 1024 num 1
Main loop level 2, start 1024 count 1 max 1048576 num 1
Entering ind_punch, level 2, start 1024, count 1, max 1
Reading indirect block 1972
start 1024 offset 0 start2 1024 count 1 count2 1
Entering ind_punch, level 1, start 1024, count 1, max 1024
Reading indirect block 2998
start 1024 offset 1024 start2 0 count 1 count2 1
Entering ind_punch, level 0, start 0, count 18446744073709550593, max 1024

This is wrong, because we want to punch *one* block, not some gigantic
number of blocks!  This huge value is actually -1023, which is the
result of the expression (count - offset).  Ooops, that's why we unmap
every block in this indirect block!

Note the suspicious 7th argument to the nested ind_punch call:

	count - offset

This doesn't smell right, because we're subtracting a position from a
length.  The end of the range for the next level down should be the
difference between the end and the start of the range in the current
level after accounting for our current position within that level.  In
other words, the smaller of end - start and end - offset.

Cc: <linux-ext4@vger.kernel.org> # v1.42
Fixes: 3adb9374fb9273 ("libext2fs: Add new function ext2fs_punch()")
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 lib/ext2fs/punch.c |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)


diff --git a/lib/ext2fs/punch.c b/lib/ext2fs/punch.c
index 19b6a37824c589..c48e74ef799a82 100644
--- a/lib/ext2fs/punch.c
+++ b/lib/ext2fs/punch.c
@@ -54,6 +54,7 @@ static errcode_t ind_punch(ext2_filsys fs, struct ext2_inode *inode,
 	blk_t		b;
 	int		i;
 	blk64_t		offset, incr;
+	const blk64_t	end = start + count;
 	int		freed = 0;
 
 #ifdef PUNCH_DEBUG
@@ -62,13 +63,14 @@ static errcode_t ind_punch(ext2_filsys fs, struct ext2_inode *inode,
 #endif
 	incr = 1ULL << ((EXT2_BLOCK_SIZE_BITS(fs->super) - 2) * level);
 	for (i = 0, offset = 0; i < max; i++, p++, offset += incr) {
-		if (offset >= start + count)
+		if (offset >= end)
 			break;
 		if (*p == 0 || (offset+incr) <= start)
 			continue;
 		b = *p;
 		if (level > 0) {
 			blk_t start2;
+			blk_t count2;
 #ifdef PUNCH_DEBUG
 			printf("Reading indirect block %u\n", b);
 #endif
@@ -76,9 +78,15 @@ static errcode_t ind_punch(ext2_filsys fs, struct ext2_inode *inode,
 			if (retval)
 				return retval;
 			start2 = (start > offset) ? start - offset : 0;
+			count2 = end - ((start > offset) ? start : offset);
+#ifdef PUNCH_DEBUG
+			printf("start %llu offset %llu count %llu end %llu "
+			       "incr %llu start2 %u count2 %u\n", start,
+			       offset, count, end, incr, start2, count2);
+#endif
 			retval = ind_punch(fs, inode, block_buf + fs->blocksize,
 					   (blk_t *) block_buf, level - 1,
-					   start2, count - offset,
+					   start2, count2,
 					   fs->blocksize >> 2);
 			if (retval)
 				return retval;


