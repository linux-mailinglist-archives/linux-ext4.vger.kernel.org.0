Return-Path: <linux-ext4+bounces-11573-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C8CDC3D9EF
	for <lists+linux-ext4@lfdr.de>; Thu, 06 Nov 2025 23:34:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 420B8188C64F
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Nov 2025 22:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 450B730EF91;
	Thu,  6 Nov 2025 22:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k4vJCee1"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7C72C3252
	for <linux-ext4@vger.kernel.org>; Thu,  6 Nov 2025 22:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762468488; cv=none; b=p6gtRNL0b0BqBwX/Yo7F5jffTTCCszUjYlRn0JwONB27WYzcbZhXn89jLv4o6VOGZDev3zEicIh7QUOeR41PwHLSU3X9J2PS1F7/L9ea8o3+yImN1ndW5pIGpEjxDVzH7/LCum8E/k9JZs9ugmayl9Bm/FAukuFXIXCYa1b2KlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762468488; c=relaxed/simple;
	bh=cU8s6nSqdTRKmtLAeRO8xCV6PytkQq0Et0AzL9iqimQ=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eUNjUfmjtr/cdt1pTDs4sSDyOuV7U504VeNbAImxMSMJQHksQfgc6F6OQYaSvLWLMry4FordBRyU7eVPojFlou1DMVLTHRCcX3suLIPUnsheyqajagkELD05LxyWD2+Zc5nPRGix24DnLKK95G2YHcpDOsgeEuq128wBnaK+b6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k4vJCee1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A43CBC4CEF7;
	Thu,  6 Nov 2025 22:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762468488;
	bh=cU8s6nSqdTRKmtLAeRO8xCV6PytkQq0Et0AzL9iqimQ=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=k4vJCee1PCgC4czTZbPaUj1OsPeR5hf30s3vb01jB4NzDxlgjCOUsqWPd14fiUrmK
	 ajGetH3w2dFcQRfufHJ+VQqJWkG/bvsUyUUsDG5+dIWNcQjC2MdNP7je9VeobHy40F
	 x0/1TXgL055dNRQQR0KIVw72M0Ah5K4DZTLw3kS9c2zR535Q062I74ptSJjjoNlFrN
	 jFft3UD5iPFgPehtR+sc4OZRKfRCcs+VMHZF2vrwvTfKnJlf41YKM5+xjeaRh0Jq6O
	 DHWhF/rMYc/ZXDUDFzg20Y4K96NbMBd766PmiQlBtPOu7yxKgrcB9D5vicSRZO4ggh
	 lKVmTe5zMQYFQ==
Date: Thu, 06 Nov 2025 14:34:48 -0800
Subject: [PATCH 14/19] fuse2fs: cache symlink targets in the kernel
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <176246793882.2862242.10188686900712408135.stgit@frogsfrogsfrogs>
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

Speed up symlinks by allowing the kernel to cache them.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |    3 +++
 1 file changed, 3 insertions(+)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index f1fb7227f1d077..c1bd76ba449370 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -1031,6 +1031,9 @@ static void *op_init(struct fuse_conn_info *conn
 	if (ff->acl)
 		conn->want |= FUSE_CAP_POSIX_ACL;
 #endif
+#ifdef FUSE_CAP_CACHE_SYMLINKS
+	conn->want |= FUSE_CAP_CACHE_SYMLINKS;
+#endif
 #if FUSE_VERSION >= FUSE_MAKE_VERSION(3, 0)
 	conn->time_gran = 1;
 	cfg->use_ino = 1;


