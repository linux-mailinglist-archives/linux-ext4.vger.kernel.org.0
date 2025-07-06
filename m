Return-Path: <linux-ext4+bounces-8832-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06A24AFA72E
	for <lists+linux-ext4@lfdr.de>; Sun,  6 Jul 2025 20:31:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FAD617617E
	for <lists+linux-ext4@lfdr.de>; Sun,  6 Jul 2025 18:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 956F712C544;
	Sun,  6 Jul 2025 18:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N0rslNid"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B88249F9
	for <linux-ext4@vger.kernel.org>; Sun,  6 Jul 2025 18:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751826678; cv=none; b=NznqLOct2Ur8L9MqltQ2EF7DgwXb5dnoCYJlWXo7uDeR4OOfMhaknG5t3nPhnmdjmzvEQ3aQz19zy8ie2pIh/WINOx1zpG/gOxvwx+pDpiRQx+aaoSvi4R2xYKSTCUHHuNzFg3Dhh5rftXYDYZGoDryo/0NGgrSQrWS68L1yf5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751826678; c=relaxed/simple;
	bh=CcY4muxyvWXuMKsAdjiegM/L5iqTlKwCpBulTZZodZs=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rlm7eu5hvebD5Cgf69xa4O53VLRKssLA9YRn3fv6OtDOItXo4S52zNeNWT5OncilborT6t0ebM6UoiN4YPCZH073WS2Fol1wqXin/DCoXqUm4ZxXMLyRm7XGX0c5ThmUvx4F7yZ3dcU41FKF48n93NVF7K0Yw5C9tpvmkc0qg8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N0rslNid; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7F5AC4CEED;
	Sun,  6 Jul 2025 18:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751826676;
	bh=CcY4muxyvWXuMKsAdjiegM/L5iqTlKwCpBulTZZodZs=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=N0rslNid8JzYZm43sCPhH+gc3JG1zvjunAZJKrMtX6VGZFMS2yQAiH7qEfZhgdn/D
	 wMVI9+yOUoCnCVmEn4dmfQYH/USDc8/cMqnqhRe2EWGeJH0uqeInUobbEfJ591BxXn
	 +uNTbDIUD8CpU3jLWEnjYAYARqzmKpf/eldKohX0Q8/vzV96sDkwJIoAxZzzLAg2pA
	 cG0naOjHm5Sv0rRUd1LZfoichxniXh9T1jnJxWzaFaMDQ6QAGKh6CNjAEvNtuVPTam
	 ApxZg6IghHchna8AqSVH6sAjYXiSQrm8C+57UPrgvqclkcUhZ2MfU/aDlVbIJn3lKF
	 Ob/NK/woJzxIw==
Date: Sun, 06 Jul 2025 11:31:16 -0700
Subject: [PATCH 2/8] libext2fs: fix arguments passed to
 ->block_alloc_stats_range
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org, linux-ext4@vger.kernel.org
Message-ID: <175182663005.1984706.2711154041137486922.stgit@frogsfrogsfrogs>
In-Reply-To: <175182662934.1984706.3737778061161342509.stgit@frogsfrogsfrogs>
References: <175182662934.1984706.3737778061161342509.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

In ext2fs_block_alloc_stats_range, we use @num as the loop counter but
then pass it to the callback and @blk as the loop cursor.  This means
that the range passed to e2fsck_block_alloc_stats_range starts beyond
the range that was actually freed and has a length of zero, which is not
at all correct.

Fix this by saving the original values and passing those instead.

Cc: <linux-ext4@vger.kernel.org> # v1.43
Fixes: 647e8786156061 ("libext2fs: add new hooks to support large allocations")
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 lib/ext2fs/alloc_stats.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)


diff --git a/lib/ext2fs/alloc_stats.c b/lib/ext2fs/alloc_stats.c
index 6f98bcc7cbd5f3..95a6438f252e0f 100644
--- a/lib/ext2fs/alloc_stats.c
+++ b/lib/ext2fs/alloc_stats.c
@@ -110,6 +110,9 @@ void ext2fs_set_block_alloc_stats_callback(ext2_filsys fs,
 void ext2fs_block_alloc_stats_range(ext2_filsys fs, blk64_t blk,
 				    blk_t num, int inuse)
 {
+	const blk64_t orig_blk = blk;
+	const blk_t orig_num = num;
+
 #ifndef OMIT_COM_ERR
 	if (blk + num > ext2fs_blocks_count(fs->super)) {
 		com_err("ext2fs_block_alloc_stats_range", 0,
@@ -147,7 +150,7 @@ void ext2fs_block_alloc_stats_range(ext2_filsys fs, blk64_t blk,
 	ext2fs_mark_super_dirty(fs);
 	ext2fs_mark_bb_dirty(fs);
 	if (fs->block_alloc_stats_range)
-		(fs->block_alloc_stats_range)(fs, blk, num, inuse);
+		(fs->block_alloc_stats_range)(fs, orig_blk, orig_num, inuse);
 }
 
 void ext2fs_set_block_alloc_stats_range_callback(ext2_filsys fs,


