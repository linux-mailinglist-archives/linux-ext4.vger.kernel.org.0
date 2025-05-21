Return-Path: <linux-ext4+bounces-8084-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6A43ABFFA1
	for <lists+linux-ext4@lfdr.de>; Thu, 22 May 2025 00:36:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D3254E363F
	for <lists+linux-ext4@lfdr.de>; Wed, 21 May 2025 22:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B20E2239E94;
	Wed, 21 May 2025 22:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gtIrqP/v"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4317A230269
	for <linux-ext4@vger.kernel.org>; Wed, 21 May 2025 22:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747866974; cv=none; b=KUDU3IXz+msQ6IHLc1k4sBsRq43gnUBD0iq4oC9lar5tSEJRVqynJLSfKQX7Zj6b1iaX9iEKcsUTLsnrqqRDMW9kkEu14tEfLGmq7+AdbJ3l515xMIWxRXg8ECeyKiJYrt+57b0exdNHorNOv0JNIzr9olQ6RxlodBWsz3yXLDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747866974; c=relaxed/simple;
	bh=d14hSDUa0wKXJ/YWNQmPfWCii1oWF3DH03YzNAnJEJw=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nd0SPk7UQ9vSSh5qJbJAPyX3d0/jzqXjDearUaUHcjaew7PnIc6ycKHo1O8PsuUD9z8S8765ngisRFahIqreTWjCJ45/HZkOcQnVX1M/WncqcmuVwnXMiRj0RS0LaZSrLempk53INuCINTvxqlA4m2nRnW2R2nLwdMKM12sRRYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gtIrqP/v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF7D1C4CEEA;
	Wed, 21 May 2025 22:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747866973;
	bh=d14hSDUa0wKXJ/YWNQmPfWCii1oWF3DH03YzNAnJEJw=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=gtIrqP/vseJq75JC1WTocMJUED9y3IE9EO5Q/H9kd7HyQKKUjjkXzT2C1abx3z9xd
	 OfhYfKfZGmk4DVLqyJP82JVnuPt/cEjOro2I2bbfRm1DL8XIj3WjFs9SEIes3DnjVJ
	 l4717c5dEg10v6gkfDEBofMruS7uMdXdYIzngWkCz+NNG6yVcRx004JiJAq4e0ClIN
	 Kd+mgEJKOgl28MPRTVSKWI33qso0YCBlnVRP9NwytHG3aGu7tDdq1auInJBwFbVizm
	 kn+U9170De3gXfImR1v1YPG61bU3LrZ5HzrZUqI4vi/GUKHqkdWtA/NC3yxLYktYon
	 4zTrtVW18iq3w==
Date: Wed, 21 May 2025 15:36:13 -0700
Subject: [PATCH 05/29] fuse2fs: compact all the boolean flags in struct
 fuse2fs
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <174786677639.1383760.16546264802006958473.stgit@frogsfrogsfrogs>
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

Compact all the booleans into u8 fields.  I'd go further and turn them
into bitfields but that breaks the fuse argument parsing macros, which
compute the offset of the structure fields, and gcc won't let us do that
to bit fields.  Still, 136 -> 112 bytes isn't bad.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |   20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 3e78b6b13fa7bb..40bb223d50c4fe 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -150,16 +150,16 @@ struct fuse2fs {
 	pthread_mutex_t bfl;
 	char *device;
 	char *shortdev;
-	int ro;
-	int debug;
-	int no_default_opts;
-	int panic_on_error;
-	int minixdf;
-	int fakeroot;
-	int alloc_all_blocks;
-	int norecovery;
-	int kernel;
-	int directio;
+	uint8_t ro;
+	uint8_t debug;
+	uint8_t no_default_opts;
+	uint8_t panic_on_error;
+	uint8_t minixdf;
+	uint8_t fakeroot;
+	uint8_t alloc_all_blocks;
+	uint8_t norecovery;
+	uint8_t kernel;
+	uint8_t directio;
 	unsigned long offset;
 	unsigned int next_generation;
 	unsigned long long cache_size;


