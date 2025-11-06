Return-Path: <linux-ext4+bounces-11562-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 635E4C3D9C8
	for <lists+linux-ext4@lfdr.de>; Thu, 06 Nov 2025 23:31:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2EB924E426B
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Nov 2025 22:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04A1C2E8E08;
	Thu,  6 Nov 2025 22:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WPI7DzZ7"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3C5273D68
	for <linux-ext4@vger.kernel.org>; Thu,  6 Nov 2025 22:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762468313; cv=none; b=JcE0G0yczS0tnn/UJ80wuIRKYwIPW71nvZ9rfiRhGRrwdanpn5SqgseuzJO4NNBtdPd8xgFDtJ82UIci5ccvyiu603tPcq6/ZzMwVXcCPpgcrQXT1iaHPxWIga0Yh5pGJtXdEhFTLbCd9hMxT6fVCZW5i1SYJtSgVRAqdygzWig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762468313; c=relaxed/simple;
	bh=DNGa5b0hHdMCPnXD5iy4ErZon2GdZdhpue4LpkucRiQ=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h/TSTBbkRDhJ2jX26hSpZJfK8ivJUv7E/MEWrghLwtsHQrwlJEY/jS2Jbk3OmyXBz7jhzW4ayafNjibUO4TLtpxPTcqOj+jxg6HmeCVU2qxjxBeu3AeBJvZs8UeQR9MHrviiw2/8Rua1uMuDFxgCxFsVo2vB1QvuT3u0CrtzPs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WPI7DzZ7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A3C9C116C6;
	Thu,  6 Nov 2025 22:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762468313;
	bh=DNGa5b0hHdMCPnXD5iy4ErZon2GdZdhpue4LpkucRiQ=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=WPI7DzZ78Vb95afR3NsguOCYToHAObquCWZCMWltxLXf7igt44s0XBHeOD65mIaDI
	 sxIj0j4m1D5bhNrPAv5mEaJHZW8MVlc+jzpePqlsPuQPjp2LW4CSp6GMCIDiULq90g
	 OBbxmO+5hcXVT/BlhN41WaaPZkYP5ERG8h8/+FHkU15zjasOfyRORZbaTRtnovgCc4
	 gH6EDZXAFbfzm7A3hgE1I3Yd1boRSDwm6BTT2HQiXWltIiDxCltKf6fqthjDIDUhOv
	 yTFV+lbpUO4xIEyCD0usOqkK6YokctIWojvRiOpkeHRAoA1TGP5kCqcxnyzQ+O/mIf
	 RXYmrilX/DrxQ==
Date: Thu, 06 Nov 2025 14:31:52 -0800
Subject: [PATCH 03/19] libext2fs: fix ext2fs_mmp_update
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org, linux-ext4@vger.kernel.org
Message-ID: <176246793681.2862242.7001143370190940389.stgit@frogsfrogsfrogs>
In-Reply-To: <176246793541.2862242.16879509838698966689.stgit@frogsfrogsfrogs>
References: <176246793541.2862242.16879509838698966689.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

ext2fs_mmp_read has this undocumented behavior that it updates
fs->mmp_cmp and not fs->mmp_buf.  Therefore, ext2fs_mmp_update2 actually
updates a stale version of the MMP buffer and writes that out to disk.
Fortunately the only two fields that get updated regularly mmp_time and
mmp_seq so the behavior was never incorrect, but this confused me for a
while, so let's fix it.

Cc: <linux-ext4@vger.kernel.org> # v1.42
Fixes: 0f5eba7501f467 ("ext2fs: add multi-mount protection (INCOMPAT_MMP)")
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 lib/ext2fs/mmp.c |    6 ++++++
 1 file changed, 6 insertions(+)


diff --git a/lib/ext2fs/mmp.c b/lib/ext2fs/mmp.c
index eb9417020e6d3f..6337852c3f6700 100644
--- a/lib/ext2fs/mmp.c
+++ b/lib/ext2fs/mmp.c
@@ -469,6 +469,12 @@ errcode_t ext2fs_mmp_update2(ext2_filsys fs, int immediately)
 	if (memcmp(mmp, mmp_cmp, sizeof(*mmp_cmp)))
 		return EXT2_ET_MMP_CHANGE_ABORT;
 
+	/*
+	 * Believe it or not, ext2fs_mmp_read actually overwrites fs->mmp_cmp
+	 * and leaves fs->mmp_buf untouched.  Hence we copy mmp_cmp into
+	 * mmp_buf, update mmp_buf, and write mmp_buf out to disk.
+	 */
+	memcpy(mmp, mmp_cmp, sizeof(*mmp_cmp));
 	mmp->mmp_time = tv.tv_sec;
 	mmp->mmp_seq = EXT4_MMP_SEQ_FSCK;
 	retval = ext2fs_mmp_write(fs, fs->super->s_mmp_block, fs->mmp_buf);


