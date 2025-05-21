Return-Path: <linux-ext4+bounces-8125-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A13FABFFFF
	for <lists+linux-ext4@lfdr.de>; Thu, 22 May 2025 00:47:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6013E3A6C2E
	for <lists+linux-ext4@lfdr.de>; Wed, 21 May 2025 22:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26FE91EA65;
	Wed, 21 May 2025 22:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kzolNOZJ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F791A23AA
	for <linux-ext4@vger.kernel.org>; Wed, 21 May 2025 22:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747867617; cv=none; b=ny0yeSC+kMvPVGjznS/eCup05rK+9GgvXpnv4dYSIgXL8Y0GFk72tqOva/MFRstUEwLr0z5INVjfIB+yQFig9SUorLx08pVP9UPDErkg/TDwPznoumy/ldqpwZ9x4xjO9cc+QCS0AR0l7F8L6JX/adNK5X/7m8zAnghWqW6/l/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747867617; c=relaxed/simple;
	bh=xQjsDEhBcRljIAAOpTqteNjGxeSwWK4H9VyYTQXU/zw=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bE3Q4+KLhuu8K7NiS/J36YQSLv7UUEh6Wnm5ETSGZDiH8tHaKOy1kDi0T1T7yz0DV8qff+sRml1a46hRDMGah0F/HrqwWTvdRj/kdiDGBC2Zq4mX2BbU+REYHzzvp/u8Ej+WLSFuBdcyrptzpnTrc+r5/PsfltZKKWCTnAN37fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kzolNOZJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27785C4CEE4;
	Wed, 21 May 2025 22:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747867617;
	bh=xQjsDEhBcRljIAAOpTqteNjGxeSwWK4H9VyYTQXU/zw=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=kzolNOZJ2Q/mOaTbrg1vNO/WgXu5fUYt2oD+su1waGN2JMzlI2VvlZo8NTASrK8Ez
	 hLws6iQCJVHasLaXd3czOWT1n4S2RTUb/mDGTOya+g8BCaus9xSKIP5Wz3C4bJjBxN
	 4SvSwH3cVsAakErqcGrInm9oDAtRygYDE6wjpIv7Xonc6idQLwO5B2D3CBba6oBV8S
	 Tfle/+ghQY0itthhKx04JE01k3l+W7Iz891uJRehtEUDeatuwDvqf/JWXx0GClWuXt
	 DXOZIamD2SlJWsJ29nH/r0Xt1N7u1CMPr3JW3RQ2phcYoudEkfkhiOOwv25Fwm31Rm
	 UF+sd5V2QJv4g==
Date: Wed, 21 May 2025 15:46:56 -0700
Subject: [PATCH 07/10] fuse2fs: recheck support after replaying journal
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <174786678817.1385354.15500841625097960030.stgit@frogsfrogsfrogs>
In-Reply-To: <174786678650.1385354.14994099236248944550.stgit@frogsfrogsfrogs>
References: <174786678650.1385354.14994099236248944550.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

The journal could have contained a new primary superblock, so we need to
recheck feature support after recovering it.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |    4 ++++
 1 file changed, 4 insertions(+)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 7c61c470723a88..2d4b9c8f51264e 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -800,6 +800,10 @@ _("Mounting read-only without recovering journal."));
 			}
 			ext2fs_clear_feature_journal_needs_recovery(fs->super);
 			ext2fs_mark_super_dirty(fs);
+
+			err = check_fs_supported(ff);
+			if (err)
+				return err;
 		}
 	}
 


