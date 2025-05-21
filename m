Return-Path: <linux-ext4+bounces-8083-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CFEA6ABFF9E
	for <lists+linux-ext4@lfdr.de>; Thu, 22 May 2025 00:36:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28C551B64B30
	for <lists+linux-ext4@lfdr.de>; Wed, 21 May 2025 22:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2C3A239E62;
	Wed, 21 May 2025 22:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SF5fxwMa"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C6F2B9A9
	for <linux-ext4@vger.kernel.org>; Wed, 21 May 2025 22:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747866958; cv=none; b=B/V+83T+rUf0emgWw2mqEjyKz+InKGfDxg1qQ3ZfOIXRt4WoqFHRnhRLSvL214Ov4CwU1v0nklc1RlzaD2p9ApiULVKDwuPpkmtwf2OFPHklI9riSDF0UETfdIByLKzKw5QW3mpU72+mVBmk6EKTjJRTeSwpinh2WlWHmFqPeWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747866958; c=relaxed/simple;
	bh=HtAAArV+msXlDiXMoRb0PxftoYRHxTySPkUItoj2meE=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eFFzS7x4EKTnd8jhon+JLI+/gKemBThHl0VzYOZ2hMfwnws4Zgvc7jYe46ccMWSIf3xMNnoHqeW0GDufARx2d5v14sMwKvv1RD0cCAUShT8M6uxrgHO7dlab437ahJwzDrXs+nH65tUl83w+GHYIqUziczghslHraz4x/cLox20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SF5fxwMa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00E87C4CEE4;
	Wed, 21 May 2025 22:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747866958;
	bh=HtAAArV+msXlDiXMoRb0PxftoYRHxTySPkUItoj2meE=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=SF5fxwMaa46yfa+p0PQZK82WQRv7tmAGMaQPsMDAY2KUPHzjowzFLsdF1a5sa45PX
	 VOeZcvZ+R2+C5CJebRN8NKotqvyPvPFxyYFy+2EJoY7ZMI2QTIZ7jxvGuXHXkM+IIm
	 A6xRdNVhIWTovnoGh7ZpX0AImXK1arDDqgmMEQEhK6IEPXRdbiI4Ik2FSg67Csr3Tl
	 laErRVIiHxgolssqgO7S5H1t1UW8qdnc476W8j2Jg9e8Dnoj9SgXn0qX+/a3KeWgXm
	 cHLJkVYSCBFNNU4g11aVOU+cMkNAWnznMCY5yeOjIBg0uKFzU6tNBvNSHoBTUiKbLl
	 aLrd1BPRpHmfA==
Date: Wed, 21 May 2025 15:35:57 -0700
Subject: [PATCH 04/29] fuse2fs: fix cache size parsing
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <174786677621.1383760.4131011398253369305.stgit@frogsfrogsfrogs>
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

Fix the cache size parsing of "cache_size=%s" -- the "%" is at position
11, not 12.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 8d52e00e3ece48..3e78b6b13fa7bb 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -3809,7 +3809,7 @@ static int fuse2fs_opt_proc(void *data, const char *arg,
 		}
 		return 1;
 	case FUSE2FS_CACHE_SIZE:
-		ff->cache_size = parse_num_blocks2(arg + 12, -1);
+		ff->cache_size = parse_num_blocks2(arg + 11, -1);
 		if (ff->cache_size < 1 || ff->cache_size > INT32_MAX) {
 			fprintf(stderr, "%s: %s\n", arg,
  _("cache size must be between 1 block and 2GB."));


