Return-Path: <linux-ext4+bounces-10907-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C0DABE4516
	for <lists+linux-ext4@lfdr.de>; Thu, 16 Oct 2025 17:45:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9ECB83BAFC4
	for <lists+linux-ext4@lfdr.de>; Thu, 16 Oct 2025 15:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3FD1343D9E;
	Thu, 16 Oct 2025 15:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h8EGq+De"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557A2213254
	for <linux-ext4@vger.kernel.org>; Thu, 16 Oct 2025 15:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760629423; cv=none; b=l5ZYRZk774InsqG4/hrYJvN/DHIuBtpAOhJcqDJGVhduB61j1IpDU5IEC2Emi0xgSCXNydH0wLGPoQ/HFngemp1LSO9ouNcFYPGLPEXaVUlXi6cUby/T1UFSjpPP0x0OeYY3USBStibT1sJzRwDdbPjGLB6jirxbkpjOUHg0UGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760629423; c=relaxed/simple;
	bh=S7WhqfVfg7zlvZD5nc+Y6IqbzIs9s3kU30w9eioMx5E=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=slVtsEa0KLO3pr+5Gly0e+rKm7vuyDet33m9Mf9jmRYxO3M2PGisTpExqbxQA+Qi0GAXvLh6X0vLJchZLhkSMJaFa36KG1At2x6nwEHAUmST80blA9QnCNhod1GNeQeYBO8jeIxSbZCySoB0jxQtear5QR3yOiGO6Pf/JaA+9vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h8EGq+De; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B15AC4CEF1;
	Thu, 16 Oct 2025 15:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760629423;
	bh=S7WhqfVfg7zlvZD5nc+Y6IqbzIs9s3kU30w9eioMx5E=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=h8EGq+DepIfWTmoN89uG2HLD6nC6djM7VdYQraOAqfiu5QCAMMqGJGiNI6FQ2Mkn1
	 KF7S8xQyqJ3POwdNSNIaA5pwsNWKPZcTfntD9rSfbzJSS33DcFSLr9fQURpgGj9zZ5
	 3uRD6dPY2CsmOi0smU/p6rkG0DZxh2P3bi1SMA5STXk16IB2xIexoR2WSSufC39yEY
	 FqPtxiNagR460n++mHHjwaH2Nz4R8QDhSEIxFHaFeiw//ag7wB6spMOjyghKmdUDK5
	 FZJAlRdVzprQGOO3VF0PotWCHfuS6q5Dh4wYsVtZbJyeFUpcW3GlhGn+o7KvTisS0J
	 R93gaugzQpufA==
Date: Thu, 16 Oct 2025 08:43:42 -0700
Subject: [PATCH 15/16] fuse2fs: check free space when creating a symlink
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org, linux-ext4@vger.kernel.org
Message-ID: <176062915737.3343688.12665739412759810345.stgit@frogsfrogsfrogs>
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

Make sure we have enough space to create the symlink and its remote
block.

Cc: <linux-ext4@vger.kernel.org> # v1.43
Fixes: 81cbf1ef4f5dab ("misc: add fuse2fs, a FUSE server for e2fsprogs")
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |    4 ++++
 1 file changed, 4 insertions(+)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 6864466435abfb..210807ea493f51 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -1825,6 +1825,10 @@ static int op_symlink(const char *src, const char *dest)
 	*node_name = 0;
 
 	pthread_mutex_lock(&ff->bfl);
+	if (!fs_can_allocate(ff, 1)) {
+		ret = -ENOSPC;
+		goto out2;
+	}
 	err = ext2fs_namei(fs, EXT2_ROOT_INO, EXT2_ROOT_INO, temp_path,
 			   &parent);
 	*node_name = a;


