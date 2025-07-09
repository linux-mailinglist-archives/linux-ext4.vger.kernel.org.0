Return-Path: <linux-ext4+bounces-8906-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B8BAFEF38
	for <lists+linux-ext4@lfdr.de>; Wed,  9 Jul 2025 18:53:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C37CA3A9A98
	for <lists+linux-ext4@lfdr.de>; Wed,  9 Jul 2025 16:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DE15221FAE;
	Wed,  9 Jul 2025 16:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H0MWE4uH"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024332206B1
	for <linux-ext4@vger.kernel.org>; Wed,  9 Jul 2025 16:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752079961; cv=none; b=hDpKn3loA5/RsCrNIl/e7Bztp4KFZuZP4VlMhRNm1dEN0EI0nyVqycodbFkoQbhakrEONdTeXV0OxWNnPG3nhVRweNsMxYiov122oIYV12W2ojeDb6+kBjo1hRfOU+ABJnfET9D/3iux2phci+5574iLJsxHEb+a4KDxSAuevbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752079961; c=relaxed/simple;
	bh=uhhp3u1zgjKArW9Cv5gpb4Vczs7GU8TaBbynePpdUWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IrT/G1easiIox+uBHmVtZPDkGYRuUYm5rf8drJQDuBsUloc2zthNIXmjt4KcBArs0NKqoIuGBSdwThIElyzD4MxhAua1AvP/JGGIOEWvBoIc7gfYJN5j0JRmPNp9vAbl2mVHIn6Ne3xieODLQKPFGvgFQBLemFuGW/3DyLW9OMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H0MWE4uH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3DC3C4CEEF;
	Wed,  9 Jul 2025 16:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752079960;
	bh=uhhp3u1zgjKArW9Cv5gpb4Vczs7GU8TaBbynePpdUWU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H0MWE4uHAP7QTn9iX0or79fF34UQjacH51Zxmcy8WjZ9yqoZu0QXQqZaRE8aXKNnr
	 lyIZBVsevP5XfC9km+uzBFmSzh1v0I00g9lRxD2jJaWgy2xzVVNvmmSCcZLPLjyfEq
	 UmpZ525VF5AS7l5Iw7gt9LB6AsfBRqk7XglEf7xao+JNHcvseYN3YodPOoyFfyUtLu
	 ldYBj4vtKHQ4SxJ7s+iK2RXssZiaxHzE+6wYOIJQ9pDfSe9DGRMkopBiwvQtMAyRA2
	 iLYusBH/ujPnJ+4v37a1SILnqXP8kNEPcOQmo5mpjCRF/g255jliemgIbIcyh0Yrfr
	 rz0eSy7R+6eYQ==
Date: Wed, 9 Jul 2025 09:52:40 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Subject: [PATCH 12/8] fuse2fs: fix races in statfs
Message-ID: <20250709165240.GF2672022@frogsfrogsfrogs>
References: <175182662934.1984706.3737778061161342509.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <175182662934.1984706.3737778061161342509.stgit@frogsfrogsfrogs>

From: Darrick J. Wong <djwong@kernel.org>

Take the BFL in statfs so that we don't expose a torn access to
userspace.  Found via code inspection.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index f0250bd1cec2ec..bc9fed6f4a8525 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -2743,8 +2743,9 @@ static int op_statfs(const char *path EXT2FS_ATTR((unused)),
 	blk64_t overhead, reserved, free;
 
 	FUSE2FS_CHECK_CONTEXT(ff);
-	fs = ff->fs;
 	dbg_printf(ff, "%s: path=%s\n", __func__, path);
+	fs = ff->fs;
+	pthread_mutex_lock(&ff->bfl);
 	buf->f_bsize = fs->blocksize;
 	buf->f_frsize = 0;
 
@@ -2777,6 +2778,7 @@ static int op_statfs(const char *path EXT2FS_ATTR((unused)),
 	if (fs->flags & EXT2_FLAG_RW)
 		buf->f_flag |= ST_RDONLY;
 	buf->f_namemax = EXT2_NAME_LEN;
+	pthread_mutex_unlock(&ff->bfl);
 
 	return 0;
 }

