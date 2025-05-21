Return-Path: <linux-ext4+bounces-8090-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49F41ABFFAD
	for <lists+linux-ext4@lfdr.de>; Thu, 22 May 2025 00:37:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF11C4E4BFC
	for <lists+linux-ext4@lfdr.de>; Wed, 21 May 2025 22:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A0BE230269;
	Wed, 21 May 2025 22:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hasylHoF"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E147B136351
	for <linux-ext4@vger.kernel.org>; Wed, 21 May 2025 22:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747867068; cv=none; b=got4FrRK1Abp6i7ymK/hkYQ2YVyKwFmnq8KlX63nbRp82XAm+AuuoYP9y52zk3uwIASqOnL7B7YuEYjIpKx1xvnk12J+9bqBgJiAoezMKPMzkAk3CY+Yxqi9S/gTJuJXLV0hxhnCBA3AXvclaO4Z1NNq1p1mXgXfiNSHK7pCVb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747867068; c=relaxed/simple;
	bh=RFVNJ+fG8qEGR5vWc0BptR9KJxGlAXiSmwvKKnYt44s=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hu5BLiKlh+nyRUyOgT2flke4Rfmd9vsENyBFj5llz2Mjb45x+LmoBRQzUIpNO2B87Okq38+vef4kbgYDbMEXpPsw91HGfh5EM4X5pwMUCL2jBY5eaib1uSomhTUOTsVjbvWSqFSo90evC8IisT7WJyQZ6hIACw6tHTwg1FGAeKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hasylHoF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC14AC4CEE4;
	Wed, 21 May 2025 22:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747867067;
	bh=RFVNJ+fG8qEGR5vWc0BptR9KJxGlAXiSmwvKKnYt44s=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=hasylHoFCnan4ghymUPbuIP3sU+aa1sCYzZxMaOrd0UMyC8fK/MMjKvPQIdrRG2+H
	 17odQdV+n7bxc6+tCnXaUw+/rgui5AoZ8O5tv37MSUpJnth2hEi/JcXJFxQW2XLINQ
	 ylIwc3EYtoZ37FYLrgS8w3CjNznjD6ddEMdSlBc29Y4p9EglXEE9e4p62IZ+8zp2mv
	 qcur/Kli1kU4GuBdnk90OLUYUkHS4fl6g70bmKb2+cDbg1hxb0MIvtY8uDlXAtJhFK
	 qT6obuz40/5LdSSDEcMDz0l81bNKPXtvLAku0irJFu4AsS5EFXD/ckOH+FMOFT13am
	 nWVI1k7eQUIDg==
Date: Wed, 21 May 2025 15:37:47 -0700
Subject: [PATCH 11/29] fuse2fs: enable processing of acls in the kernel
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <174786677747.1383760.17294624757826456720.stgit@frogsfrogsfrogs>
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

Let the kernel process ACLs.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index a0e5d601e55877..ce5314fa439090 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -4141,9 +4141,15 @@ int main(int argc, char *argv[])
 #endif
 	}
 
-	if (fctx.kernel)
+	if (fctx.kernel) {
+		/*
+		 * ACLs are always enforced when kernel mode is enabled, to
+		 * match the kernel ext4 driver which always enables ACLs.
+		 */
+		fctx.acl = 1;
 		fuse_opt_insert_arg(&args, 1,
  "-oallow_other,default_permissions,suid,dev");
+	}
 
 	if (fctx.debug) {
 		int	i;


