Return-Path: <linux-ext4+bounces-10058-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E791B587A1
	for <lists+linux-ext4@lfdr.de>; Tue, 16 Sep 2025 00:39:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6ACD204377
	for <lists+linux-ext4@lfdr.de>; Mon, 15 Sep 2025 22:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A24A12C236D;
	Mon, 15 Sep 2025 22:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YrsN3ThO"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432C42D1F44
	for <linux-ext4@vger.kernel.org>; Mon, 15 Sep 2025 22:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757975958; cv=none; b=pgJ2B2UBIqxPlwTdCPPRksuVTKl88T5CP8NIJpSB6KW1Jjjq9N5VfY/UUBOrXfJbW8HSninNTUp+mQjDrONH+aXrgun0GGfFjMwyo9O+GG8soUNuap76tkFPIJmq1Smyn2oMa5dbRjWUjfpnqFBJBq0KxLd0HDk+ikiSnpgV2/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757975958; c=relaxed/simple;
	bh=eVoI1k+x8uhmuk+npqUncMUV8BMI4hP4JU9M+Qu0Z/4=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BT/4sxqkmR+uDwk3vmn/ueZHt9ylKf7zF9FePDOfh2fnkNq81X6olxsv8wY+KmNuzA0E8EUtn9xQIQ/kEX7kLlAcWSxuJCra5PY965oT89868OYpbjgmLYMP1J0q5qAV790iFuWAfUaMIZ70NLhW3O5xflGiefSq0qJt4LD5kdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YrsN3ThO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE04DC4CEF1;
	Mon, 15 Sep 2025 22:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757975957;
	bh=eVoI1k+x8uhmuk+npqUncMUV8BMI4hP4JU9M+Qu0Z/4=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=YrsN3ThOCN9pcZCC4MvsACoVu7bx2qW82zguNPjD9fYDSa4IIwCJGhgZl0yUTmIjp
	 iITMdwYu/qqM0i+gyfg2tEcxNTczRCnS29MVPozWWKHojHh3Inwl1Dvph6ZvhfniwQ
	 dC1ul+GIeinJDhXOyM0zAXIYV4ngJy6R/hav5bHDILnvXD/jWCLw9HXLyNsbMlzbwz
	 oJzMzGprryC2A8pq79DrgTw9T3T7YpQ83vD/2BPA0CNmVjn3hAEowKOc2Cj8yGdvAi
	 WtoVJxXmBKIL234w4nOJS2D5/RVMrxEyomAA8E2BfRwTCabQSs5qOxQ1BYYvyIzoXW
	 XK4tBzPrMZuvg==
Date: Mon, 15 Sep 2025 15:39:17 -0700
Subject: [PATCH 06/12] fuse2fs: fix memory corruption when parsing mount
 options
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org, linux-ext4@vger.kernel.org
Message-ID: <175797569727.245695.9292992844444922508.stgit@frogsfrogsfrogs>
In-Reply-To: <175797569564.245695.4628729304068635201.stgit@frogsfrogsfrogs>
References: <175797569564.245695.4628729304068635201.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

struct fuse_opt has this interesting behavior -- if you set the offset
field to a non-negative value, then it will treat that value as a byte
offset into the data parameter that is passed to fuse_opt_parse.

Unfortnately, process_opt computes a pointer from ((char *)data +
offset), casts that to an int pointer(!), and dereferences the int
pointer to set the value.  Therefore, we cannot have uint8_t fields in
struct fuse2fs because that will lead to subtle memory corruption.

Cc: <linux-ext4@vger.kernel.org> # v1.47.3
Fixes: c7f2688540d95e ("fuse2fs: compact all the boolean flags in struct fuse2fs")
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |   24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 08470a99dc7b4d..4ebc949b53d1fe 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -217,17 +217,19 @@ struct fuse2fs {
 	pthread_mutex_t bfl;
 	char *device;
 	char *shortdev;
-	uint8_t ro;
-	uint8_t debug;
-	uint8_t no_default_opts;
-	uint8_t panic_on_error;
-	uint8_t minixdf;
-	uint8_t fakeroot;
-	uint8_t alloc_all_blocks;
-	uint8_t norecovery;
-	uint8_t kernel;
-	uint8_t directio;
-	uint8_t acl;
+
+	/* options set by fuse_opt_parse must be of type int */
+	int ro;
+	int debug;
+	int no_default_opts;
+	int panic_on_error;
+	int minixdf;
+	int fakeroot;
+	int alloc_all_blocks;
+	int norecovery;
+	int kernel;
+	int directio;
+	int acl;
 
 	int logfd;
 	int blocklog;


