Return-Path: <linux-ext4+bounces-10899-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C4F1DBE44D4
	for <lists+linux-ext4@lfdr.de>; Thu, 16 Oct 2025 17:42:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2F2D64ED3D0
	for <lists+linux-ext4@lfdr.de>; Thu, 16 Oct 2025 15:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACA1134AB10;
	Thu, 16 Oct 2025 15:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YZ42+DuC"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DEF32E764B
	for <linux-ext4@vger.kernel.org>; Thu, 16 Oct 2025 15:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760629298; cv=none; b=PRFIxEWAd+veZ+Vme8g2wXxWK8+KVeSwPKv3+AbwNuGhuHmrp9TwrZvksKNLlvmWQMqa1kP03cU52HSup/+Qpi/paHF+wBHfoWUWquY1YsCUWI87TmMdVW5mMgcete5URKF6/oDibhGDTvSka90hOS8COsKNqopnBnNDEtO4Ly8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760629298; c=relaxed/simple;
	bh=BSjIPdhqaaq4nGxK03Dd8Lrv+DFcvsPfzuGJNFm/vOQ=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=syuxF95gH1ohyBRU4yQom54qw5KABxoFcTpV9dvo4OG2U55J0NzE1L1OkmmeSlBpAtJLUFZg3sF0NrwffgnQywhBYrsf4BHmWYDmM3iSzBXQyoOgYpfEWrgjtSLh/U6cyNhgEwgv5/baBHhZyn7tkP54PqiT9bFPe0/ntpz+FUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YZ42+DuC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9D51C4CEFB;
	Thu, 16 Oct 2025 15:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760629297;
	bh=BSjIPdhqaaq4nGxK03Dd8Lrv+DFcvsPfzuGJNFm/vOQ=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=YZ42+DuCC6Q0jiiG40MWyE1GKmnw9YTZigQPEtiZR2uw2bhnWoYx02jF4wiEG0XLJ
	 fK6FvSOOJmmzk+vn8DPwJD/78qxyGGTpBifLioYX3xCvMil4+l/WbdEwlmLjtpJCYb
	 qFUTFh0a5ZbvnsqR5hG9oyGnh9tucL/wS0KScVJLAjYqIZ84IMrAe7vgPiHE8tIIub
	 XFcbM82jQXoI9dihLQOY9JEG7ZLwpP33W2HBwQihvE2ksqENvDTEb2n7gbbf4lB7HD
	 DOVp1ktTaZ60ruq1hEa3uV3YQngBofyj0J4LA2kMTav391oXOz5B6WgKDWS8pr9TM8
	 0DW1Irf+nCeag==
Date: Thu, 16 Oct 2025 08:41:37 -0700
Subject: [PATCH 07/16] fuse2fs: quiet down EXT2_ET_RO_FILSYS errors
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org, linux-ext4@vger.kernel.org
Message-ID: <176062915591.3343688.7327312266916396070.stgit@frogsfrogsfrogs>
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

If an fs update fails because the ext2_filsys is opened in readonly
mode, just return EROFS and don't log that.  This prevents unnecessary
spew for norecovery mounts.

Cc: <linux-ext4@vger.kernel.org> # v1.43
Fixes: 81cbf1ef4f5dab ("misc: add fuse2fs, a FUSE server for e2fsprogs")
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |    3 +++
 1 file changed, 3 insertions(+)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index cb5620c7e2ee33..4d92e1e818b1c4 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -4983,6 +4983,9 @@ static int __translate_error(ext2_filsys fs, ext2_ino_t ino, errcode_t err,
 	case EXT2_ET_UNIMPLEMENTED:
 		ret = -EOPNOTSUPP;
 		break;
+	case EXT2_ET_RO_FILSYS:
+		ret = -EROFS;
+		break;
 	case EXT2_ET_MAGIC_EXT2FS_FILSYS:
 	case EXT2_ET_MAGIC_BADBLOCKS_LIST:
 	case EXT2_ET_MAGIC_BADBLOCKS_ITERATE:


