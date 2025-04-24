Return-Path: <linux-ext4+bounces-7468-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D6FEA9BA06
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Apr 2025 23:41:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0CB53BD22A
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Apr 2025 21:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4108B21E087;
	Thu, 24 Apr 2025 21:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TNA1yZ0T"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA432199949
	for <linux-ext4@vger.kernel.org>; Thu, 24 Apr 2025 21:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745530863; cv=none; b=gFmlhGwmihk5OKKCuruzYI2umUb7ch03zY6BKKoFJ9PVXEyC1sQERHDCt49PXUMOJ3DAfVaXnvier4TXxFtCRUFJsgx9RX4xmX+t2WNgitRTBkQyOMAQ5jEj7FVv8Bjks2417DSgzSxSqVMjLgjJGrhh26jKNrrgioGutYrzrUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745530863; c=relaxed/simple;
	bh=aGNVkF9Gwp5vxHu1+fKNEWQdyG9neVlz9EZ8RDACgaA=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eo6/G/t4VuG1FFeHGek92551Wu+oxLqIM5zoXTHg7MUDsIm4Db9eRgg2kE0FjSq6FVitN2X0gYLCpuAbsr4ylIRMJiO1Z8I18BJvXqnFG/HCsuFz4UCxfHGLEkwWayCNK93RW3AUISqMTDAozqXPLbmP6ukmqcqIaSi+5pFsGwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TNA1yZ0T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4735DC4CEE3;
	Thu, 24 Apr 2025 21:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745530863;
	bh=aGNVkF9Gwp5vxHu1+fKNEWQdyG9neVlz9EZ8RDACgaA=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=TNA1yZ0TUE5QRVj5YQzU0CWpfE0W2JqaoxopTnULm3gQq1mSgOf2czFqJzmcmzDZc
	 rWeufncMrKeT31/i1/1SlzQ08Qu1XMx5yrJHV/P0A3JdAGKwwh2JOwYV9NjRsSL6UG
	 3GH6yn+askkc9Uu64Xmn+ICb4VmNjYi6md2+gqiyEmiQeV+RJnZgnjk/QGSy8NLEDz
	 ahJMPpxRT9CR7X8QY3sfh2CuvE+ukxfLMOPn3r+6TGuq28c/dsyJyVoD+CDltxwKxU
	 JRiFeGgra+j4Jp0NzlRAuVsUCwepq3CxAsPdY2fVD1nBKw+v3r04kkqud9NV6YSJ3R
	 K1eQMutKo9+pA==
Date: Thu, 24 Apr 2025 14:41:02 -0700
Subject: [PATCH 01/16] fuse2fs: refuse unsupported features
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <174553064943.1160461.14810321477577468832.stgit@frogsfrogsfrogs>
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

Don't mount a filesystem with superblock features that we don't actually
know how to support.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |   20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index f974171d3e726d..5a92e54031a8b7 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -3902,6 +3902,26 @@ int main(int argc, char *argv[])
 
 	ret = 3;
 
+	if (ext2fs_has_feature_quota(global_fs->super)) {
+		err_printf(&fctx, "%s", _("quotas not supported."));
+		goto out;
+	}
+	if (ext2fs_has_feature_verity(global_fs->super)) {
+		err_printf(&fctx, "%s", _("verity not supported."));
+		goto out;
+	}
+	if (ext2fs_has_feature_encrypt(global_fs->super)) {
+		err_printf(&fctx, "%s", _("encryption not supported."));
+		goto out;
+	}
+	if (ext2fs_has_feature_casefold(global_fs->super)) {
+		err_printf(&fctx, "%s", _("casefolding not supported."));
+		goto out;
+	}
+
+	if (ext2fs_has_feature_shared_blocks(global_fs->super))
+		fctx.ro = 1;
+
 	if (ext2fs_has_feature_journal_needs_recovery(global_fs->super)) {
 		if (fctx.norecovery) {
 			log_printf(&fctx, "%s\n",


