Return-Path: <linux-ext4+bounces-9407-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B015B2E8F0
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Aug 2025 01:42:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 310B75E6525
	for <lists+linux-ext4@lfdr.de>; Wed, 20 Aug 2025 23:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A02E2E1C4E;
	Wed, 20 Aug 2025 23:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e6g97AaT"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11D62E174C
	for <linux-ext4@vger.kernel.org>; Wed, 20 Aug 2025 23:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755733331; cv=none; b=NqSpFaAfkSqyZmCgxyvqkRnRcJikUo4yJNYLfTiFpxVtull+C4I3lUeFFPdWZ8voXYEc7HohY31+rWMDkON5iWjVd6MFPSHKfO8D3shZt+SLeJfpYU1vmD7/C8QSqhrOeEA9TMtcXTv+ixsJvIZMCvZkxZ0PMdF7eQ6XKm0U1rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755733331; c=relaxed/simple;
	bh=B6j6Hss54g6jl0YMQIlc7gr3BjhqIakcBn9g1uoAbEA=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b3byzcwQD5G5+/A/jvn9ALYvW0jYhFMY0XSSB3BwjQs68rfZiNPohUC/3w+W6fzEpsZRxOgC3LfPlx6Aq9WdtkV5YNT6E4qkBpID90egn1bM0XUGAfI5lZDUXYns/hrG7Re+IIQxr/bU7ttrRQmgymdOti0yjsAltvbqACrgRwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e6g97AaT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A4D8C4CEE7;
	Wed, 20 Aug 2025 23:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755733331;
	bh=B6j6Hss54g6jl0YMQIlc7gr3BjhqIakcBn9g1uoAbEA=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=e6g97AaTzf/Xd/H6l5LTANI1yxsgz61Mdvxh0sp4jLGgF6vgu9N3XRyBsCgnbUfun
	 ty5ZpxazclJkOtSNiOu6ejsdwAlTpcMSJgjoA7qBDFEe6lGUnjPlBsnxlhO+iAVpcU
	 xSqiXeg2qpl10gAzVZCafyPalH6gNy37PXhw+PsSl8L9WRUPLVaclowr0tUK+CzUZR
	 MPOII5aVP+jJWbRG6oFn7lVAesXGNiwEEoKW7XEti/jKOHYLbSMMC2tdOfrnyd6MXK
	 E2l6TJrHA3wEjOS5ATllqrmlepQIvTDXiIrZvBWLEGKVLr0sZCfwLjFWvq8nHjYs9l
	 XaAPLqVMjgeWw==
Date: Wed, 20 Aug 2025 16:42:10 -0700
Subject: [PATCH 05/12] fuse2fs: don't let ENOENT escape from ioctl_fitrim
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org, linux-ext4@vger.kernel.org
Message-ID: <175573318694.4130038.15048413607125742231.stgit@frogsfrogsfrogs>
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

If ext2fs_find_first_set_block_bitmap2 returns ENOENT to indicate
that there are no bits set between start and b, then the entire region
is free space and we can discard it.  In that case, zero out err so that
it won't get returned as an error.

Cc: <linux-ext4@vger.kernel.org> # v1.43
Fixes: 81cbf1ef4f5dab ("misc: add fuse2fs, a FUSE server for e2fsprogs")
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |   14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 1debbd3355ec8f..d670c5db1206f2 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -3991,8 +3991,20 @@ static int ioctl_fitrim(struct fuse2fs *ff, struct fuse2fs_file_handle *fh,
 		b = start + max_blocks < end ? start + max_blocks : end;
 		err =  ext2fs_find_first_set_block_bitmap2(fs->block_map,
 							   start, b, &b);
-		if (err && err != ENOENT)
+		switch (err) {
+		case 0:
+			break;
+		case ENOENT:
+			/*
+			 * No free blocks found between start and b; discard
+			 * the entire range.
+			 */
+			err = 0;
+			break;
+		default:
 			return translate_error(fs, fh->ino, err);
+		}
+
 		if (b - start >= minlen) {
 			err = io_channel_discard(fs->io, start, b - start);
 			if (err)


