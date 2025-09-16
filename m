Return-Path: <linux-ext4+bounces-10103-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BAC3B588CD
	for <lists+linux-ext4@lfdr.de>; Tue, 16 Sep 2025 02:04:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24E2A1882A5A
	for <lists+linux-ext4@lfdr.de>; Tue, 16 Sep 2025 00:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A3664C9F;
	Tue, 16 Sep 2025 00:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bBBZKWVc"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEBAE645
	for <linux-ext4@vger.kernel.org>; Tue, 16 Sep 2025 00:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757981088; cv=none; b=g/tLL+P6KASgVHcLjqfN6b8nF1rNzmhZQqxGjKVsvIYW4MBXEavKBq2rG1RjsSXR56CHbvI9qgA8hkx4CLCzEmUQqJPSSc0Y/CLeDoE49Alckqk7XbRTzRLFv3k2/etItCBYz8U6PELczYM3wm9vM4S5ytlIn7FCiVudMMY9dHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757981088; c=relaxed/simple;
	bh=3Za6ZlMhubHMo2TZGx6ghLWtkl/bCN2ZmA7IhfXgyY0=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rVmPKr9/KcuFmk8bPArM92xViZfVtrr2i/XKPa/17MZrgmVNQpsImW5N8d2whtgoWTTUo0nq7uYVq9Q3oU/69p7z7QS928eRrpDMTghBRepq4zN2v2x/TKzeRYdYNkFnEI9QcFMwtO3xhHjSD+ZT58zvjCqEWXfdNjHPStX09tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bBBZKWVc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A6D9C4CEF1;
	Tue, 16 Sep 2025 00:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757981088;
	bh=3Za6ZlMhubHMo2TZGx6ghLWtkl/bCN2ZmA7IhfXgyY0=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=bBBZKWVcYKvdXHHJRbP9+nJzFkWxz9Btp5TN7iJxByDFyOAKv86Dnt/N4mnuXOZPr
	 mzF8TF8BRLDBFrjqc/ccF7ysvlvfoaeBFDxMztQ9oDM5t7MOuwDA3sisJwuqJTdEAe
	 6Or3C8tKJSFjK9x713Y0E4x0TiB8YluOPOTdn/hJLQvngcA0/fOs73W2PytLjQosCs
	 ogeDcjBKkDMUymKF5PuoBQDy4tTrjMqWPk1tPJFmiiWIX/VPoaZZ6Yz/k2az/f00Hm
	 WRYH1L7QEeSrCEcIbtAFSA/Uud8xu5T5aFESeyHZHqG/olnAoOKUD1VYRU6Zl7I4zX
	 VPnqwodI1+wpA==
Date: Mon, 15 Sep 2025 17:04:48 -0700
Subject: [PATCH 5/5] fuse2fs: record thread id in debug trace data
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <175798065022.350149.2732961108727368747.stgit@frogsfrogsfrogs>
In-Reply-To: <175798064915.350149.2906646381396770725.stgit@frogsfrogsfrogs>
References: <175798064915.350149.2906646381396770725.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Record the thread ID in the debug trace data so that we can trace
operations going through the fuse server more easily.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index feef9a1709f6cd..6173d6f51892a9 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -148,7 +148,7 @@ static inline uint64_t round_down(uint64_t b, unsigned int align)
 
 #define dbg_printf(fuse2fs, format, ...) \
 	while ((fuse2fs)->debug) { \
-		printf("FUSE2FS (%s): " format, (fuse2fs)->shortdev, ##__VA_ARGS__); \
+		printf("FUSE2FS (%s): tid=%d " format, (fuse2fs)->shortdev, gettid(), ##__VA_ARGS__); \
 		fflush(stdout); \
 		break; \
 	}


