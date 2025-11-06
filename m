Return-Path: <linux-ext4+bounces-11558-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 057D9C3D9BC
	for <lists+linux-ext4@lfdr.de>; Thu, 06 Nov 2025 23:31:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D578C4E2E14
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Nov 2025 22:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B93802FBDFA;
	Thu,  6 Nov 2025 22:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NRNs5uOc"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB352E8E08
	for <linux-ext4@vger.kernel.org>; Thu,  6 Nov 2025 22:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762468249; cv=none; b=EMRTYzpPY8HhfTm3eVuyF+hpGcWZ97CqHgao6HNOW90gJnzaw3K+x+8dVRdcl/GENrzAElIZ3YYsBysBx9C9V4itwLNznVZ/h94WXzArq1E8M3x2npsWm88Dj9qmxycOdDMvaGpj0ER2twymBqC8kSFiV8NGBovEioQR6sXjhXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762468249; c=relaxed/simple;
	bh=gKb8n8v2HzhBSLPJDaKDeBvwXs8lT3x/U96ja8y6bAY=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zjfnn2MlCT6Ng/faFOGP5nSem38cBihCpyNAqbAr+Eo0ogwY6Jwaab2UJiQZdoI/5oJHg8u7tOC5AmwEtnk9AZltjo86LyYJUcgr/jXOTQqQWkz7eEBrJBfBBLE1yTxMKKwuCp5LndtaPxotb3ulI3I99BLXe8m6h6TAVRbIRas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NRNs5uOc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27231C116C6;
	Thu,  6 Nov 2025 22:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762468249;
	bh=gKb8n8v2HzhBSLPJDaKDeBvwXs8lT3x/U96ja8y6bAY=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=NRNs5uOc/OCoDtf90OwAEc7kO3RAHl4PMD3PYji8IWyoOiICdb6K8fKjG1j2dEnXt
	 LOve5DY9UCoUB6ZqSewMYH/ywPZZJYO0RH6SrxHin/lvmB9AfpZPl5Hg0rdVFtJ3Ot
	 z/68hb5kspWwfevfF/fgesVSXyV2VxeZfGaIWvcRV0M8o8hftCUnCIYYJKYlfLOFLP
	 72okGHtGaZgDTkcqvq7pBg5H0Jfsqle0jVZTejngyU1ysKyUP4GTjUUGlSJixJ3zS/
	 nOdGY4LSgEyTFlDrXZTagjOJj4gc7D38nkdZlER+lFNwCIluXgzb4ZrZkl4beCMvTu
	 G1cIiLMdrgQqw==
Date: Thu, 06 Nov 2025 14:30:48 -0800
Subject: [PATCH 3/4] fuse2fs: quiet down write-protect warning
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <176246793384.2862036.18356083276939037519.stgit@frogsfrogsfrogs>
In-Reply-To: <176246793314.2862036.15869840216751367735.stgit@frogsfrogsfrogs>
References: <176246793314.2862036.15869840216751367735.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

No need to retry the mount with write protection if we already set ro
and cleared EXT2_FLAG_RO.

Fixes: e352b2ad174573 ("fuse2fs: mount norecovery if main block device is readonly")
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 7b94f0df1688a1..bbd79d6c09f4bc 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -4823,7 +4823,8 @@ int main(int argc, char *argv[])
 		flags |= EXT2_FLAG_DIRECT_IO;
 	err = ext2fs_open2(fctx.device, options, flags, 0, 0, unix_io_manager,
 			   &global_fs);
-	if (err == EPERM || err == EACCES) {
+	if ((err == EPERM || err == EACCES) &&
+	    (!fctx.ro || (flags & EXT2_FLAG_RW))) {
 		/*
 		 * Source device cannot be opened for write.  Under these
 		 * circumstances, mount(8) will try again with a ro mount,


