Return-Path: <linux-ext4+bounces-9043-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 290ECB08FFE
	for <lists+linux-ext4@lfdr.de>; Thu, 17 Jul 2025 16:59:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD9A87B099D
	for <lists+linux-ext4@lfdr.de>; Thu, 17 Jul 2025 14:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD6332F85FE;
	Thu, 17 Jul 2025 14:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ULpPqFQO"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5187B2F85F5
	for <linux-ext4@vger.kernel.org>; Thu, 17 Jul 2025 14:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752764351; cv=none; b=Jy1W0QozmL/hMNdx2kX+Eq2l9q3ZzGUiQWrg6gNRszgG1srlNEzPH6cxjtet88oD/3OSvNYCfHgKhYoEh6Ld8J13jCp7lCVeehthWMEgjxO90TYh0EqpjMFdf13RCWp10fe6DeiVA1IOaaGaYyaBGh8WqHL8OYa3iQXfTopasFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752764351; c=relaxed/simple;
	bh=OfzTrJTtk+f1afIPiDTibw1iI8rq39tTSIlR8/zWvI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pLqUJDW9/4oQZl1nEPqLWnUsl9hQK4AeP5oKYZ5SdaiKx/lsmciQPQLGQmfVMU7mXkAyaNp7pSRHmHIDaelsUc+UdlL7u0A3pWbqTJsk/ys1f8rxBKheO0g6mhv8KlEiY+9TkgvwyHUwej3+UR+9YaelxkLWzEiAXLjtYYuhaiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ULpPqFQO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29B2CC4CEF7;
	Thu, 17 Jul 2025 14:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752764351;
	bh=OfzTrJTtk+f1afIPiDTibw1iI8rq39tTSIlR8/zWvI8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ULpPqFQOxV7EAAptYjRI3yeR1ad9f6Xsfj7olgXLJ09/J0bAWZ0iwpTeCjXI5pNK/
	 N8a4G2lJ5u6HsPECJ0N4eNWKSWOPuZJa6K008dgFEayHlbOzA7bloKQEcWbYM7hhqh
	 7JqnPzMIbJNHH7pe29/ZXhtRwYeXKI8+s8KS9QDVsTZpsZG91/ZiwEudFcSbw9q+7k
	 OnBDtSRzvuFEfnDgIPJozHDCnUC6ThpbTOHu0Z6bQBe7JNQioOswn6Q9b1x5jp7RFH
	 tubz5o5OuSrzwBDIcudPMwh/huwAVdESKj8xDFpXMisIgUNH2tRex5mWcL7e/jdkIN
	 EsVdWSI4dQGqQ==
Date: Thu, 17 Jul 2025 07:59:10 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Subject: [PATCH 13/8] fuse2fs: fix ST_RDONLY setting
Message-ID: <20250717145910.GH2672022@frogsfrogsfrogs>
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

Only set ST_RDONLY if the filesystem isn't writable.

Cc: <linux-ext4@vger.kernel.org> # v1.43
Fixes: 81cbf1ef4f5dab ("misc: add fuse2fs, a FUSE server for e2fsprogs")
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index bc9fed6f4a8525..bff303a10e7186 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -2775,7 +2775,7 @@ static int op_statfs(const char *path EXT2FS_ATTR((unused)),
 	fsid ^= *f;
 	buf->f_fsid = fsid;
 	buf->f_flag = 0;
-	if (fs->flags & EXT2_FLAG_RW)
+	if (!(fs->flags & EXT2_FLAG_RW))
 		buf->f_flag |= ST_RDONLY;
 	buf->f_namemax = EXT2_NAME_LEN;
 	pthread_mutex_unlock(&ff->bfl);

