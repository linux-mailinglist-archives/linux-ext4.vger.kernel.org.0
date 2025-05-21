Return-Path: <linux-ext4+bounces-8101-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EE2FABFFCC
	for <lists+linux-ext4@lfdr.de>; Thu, 22 May 2025 00:40:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E87077A4DD1
	for <lists+linux-ext4@lfdr.de>; Wed, 21 May 2025 22:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08DC123A562;
	Wed, 21 May 2025 22:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jLa2Hlvr"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB9A239E8B
	for <linux-ext4@vger.kernel.org>; Wed, 21 May 2025 22:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747867240; cv=none; b=UgHLVq/9/ftunmbTXGDL4YhnwDYBPwOpSCL9O9qvxZdfLrZnibfDRYdRnj8daTKw+NctWIe6jYErLtMhOkC4CdxOGsZFhpL9Jy+XG7makMhD6xPlPDbQP62tBLfA+zwsrdwwucpV9xmBfqpfVvBf2PyEuqtBNWtaGeob//XqeT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747867240; c=relaxed/simple;
	bh=fWd2Lvbwp89SXBXjTO/JDn5FESuQK6OPwhmArZ2pu/o=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qV3/B2Pwel2jyOmkhyCsQcwc6r/3ffiOaQcPa0AD68IY9bLSnCjt/0gZLREqbUUoj2Y20m/+4x4Nxnpg2lB6ChMhbMoyZfKCRGrGYYu7x+OXWzq3Byv0dMbZd8eIqh3/ByGJsymmuIPAsx+jvGLhD9laeFzlc13ymbJ4AcYOMkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jLa2Hlvr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5546CC4CEE4;
	Wed, 21 May 2025 22:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747867240;
	bh=fWd2Lvbwp89SXBXjTO/JDn5FESuQK6OPwhmArZ2pu/o=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=jLa2HlvrBk+9t4EAog1RnxqqVVPWBJ61cjsCZUKMA/tPtU9zkYz4+1O3sgVHCqcJP
	 3sQE5Ce3acuv7I9/H93rxc65ueL69GammsXnxCf6ix5EaZn1Venx+JsLxtAdLUcI76
	 A/rVji5IIo3HVmeoWvZT3o6re0/w5JMNXdR/VgUGXvE18xi9D31dy5j/agEaxJA+xz
	 D1TPs2pokkmpVp/3ackNOr3ml9UoQCyZTTi2c/VdtlznxVg1BeLQ6cgdHPyyXjtej/
	 Nq6+S/GvhjkUk2FIhgXUV159PcwUeP8JNH6gzeY68AOjKWUqqksCtUMTTz2d+LkSq7
	 U6c+gI4XTd58A==
Date: Wed, 21 May 2025 15:40:39 -0700
Subject: [PATCH 22/29] fuse2fs: fix fallocate zero range
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <174786677941.1383760.17359353030156900900.stgit@frogsfrogsfrogs>
In-Reply-To: <174786677421.1383760.15289906755026332870.stgit@frogsfrogsfrogs>
References: <174786677421.1383760.15289906755026332870.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Allow this flag when we're checking flags in op_fallocate.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 4d4eaedfc33e1f..74bbe661a417e5 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -3820,7 +3820,7 @@ static int op_fallocate(const char *path EXT2FS_ATTR((unused)), int mode,
 	int ret;
 
 	/* Catch unknown flags */
-	if (mode & ~(FL_PUNCH_HOLE_FLAG | FL_KEEP_SIZE_FLAG))
+	if (mode & ~(FL_ZERO_RANGE_FLAG | FL_PUNCH_HOLE_FLAG | FL_KEEP_SIZE_FLAG))
 		return -EOPNOTSUPP;
 
 	pthread_mutex_lock(&ff->bfl);


