Return-Path: <linux-ext4+bounces-7478-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E22AA9BA10
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Apr 2025 23:43:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 868137A8E5D
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Apr 2025 21:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F301C21E087;
	Thu, 24 Apr 2025 21:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ugNcQWpT"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9727E1F4297
	for <linux-ext4@vger.kernel.org>; Thu, 24 Apr 2025 21:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745531019; cv=none; b=MRnDwSZv77sjeb7M4OSgTjlX++ykLTMpuHm+7Hkk9SK/hju3QO8H4ZyHvqKiln4FDh3xbi8nuIy11A0qjoW/b81FGcPlIAbAVBRNaiXvfrh2uaoq83+WPjkyInqb+5SrfBy280WNEEY9Rb8flDsBnlx1XFRzGIaPa6XFLFT3bgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745531019; c=relaxed/simple;
	bh=yYJKuhBHMX43MXvKWwAin9TiUnd5UIlZ651Ti87vW3s=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HFkaKrxOcXOUEWR+qwHY8kTnAcdbWxoyfvL2N8KMOUyAq6MgWEjyaYj12YCiKQrtGD7SF9LWESSv5z6XMXeVz5bep2zk0SsqcnD2rELnOzFxD6WKSev/eTc20wEcC3EQMk//4mqmvnrYcDlg6TkUihlihfWBtlhb+9hNc1e58aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ugNcQWpT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C301C4CEE3;
	Thu, 24 Apr 2025 21:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745531019;
	bh=yYJKuhBHMX43MXvKWwAin9TiUnd5UIlZ651Ti87vW3s=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=ugNcQWpTfl9RG0iVgNtyYOX7/XxCRft0BPo/ETEUDqrNMsYD+gSfQLjBj4+GuNWC5
	 d41yUZFy2UyYuN8vy3vAqSx9gfEjVkzvd6w91OTFQ29p9OFciU27rXQHoRPiXG2jca
	 Ae84fCxerkLGvcLY3GOFNflOEFB0yqToqHls4C0288IoX8uKtj/0jjAe20xrRMwQ+h
	 ETZ2jwM0evcQPA/VxxeHPtyr4FzmYRjWqd9G0/MKC6IHh8zSCxqV6x6JgHFnzpBVbd
	 LRVA2b1tnoZpxBgMBJ4MYugLkvLGCZyCZz/Sof/cUF6CR019pVR3Ppjk25Ag/NgZOE
	 rhvvG7a4qOefw==
Date: Thu, 24 Apr 2025 14:43:39 -0700
Subject: [PATCH 11/16] fuse2fs: support changing newer iflags
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <174553065123.1160461.3149004980436873980.stgit@frogsfrogsfrogs>
In-Reply-To: <174553064857.1160461.865616278603382583.stgit@frogsfrogsfrogs>
References: <174553064857.1160461.865616278603382583.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Redefine FUSE2FS_MODIFIABLE_IFLAGS so that userspace can modify any
flags that the kernel can, except for the ones that fuse2fs lacks the
ability to change.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 6066984fa7f6e0..2220da4c3e8f64 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -2954,9 +2954,8 @@ static int op_utimens(const char *path, const struct timespec ctv[2]
 }
 
 #define FUSE2FS_MODIFIABLE_IFLAGS \
-	(EXT2_IMMUTABLE_FL | EXT2_APPEND_FL | EXT2_NODUMP_FL | \
-	 EXT2_NOATIME_FL | EXT3_JOURNAL_DATA_FL | EXT2_DIRSYNC_FL | \
-	 EXT2_TOPDIR_FL)
+	(EXT2_FL_USER_MODIFIABLE & ~(EXT4_EXTENTS_FL | EXT4_CASEFOLD_FL | \
+				     EXT3_JOURNAL_DATA_FL))
 
 static inline int set_iflags(struct ext2_inode_large *inode, __u32 iflags)
 {


