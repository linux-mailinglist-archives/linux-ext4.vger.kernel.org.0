Return-Path: <linux-ext4+bounces-11597-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 920FDC3DA49
	for <lists+linux-ext4@lfdr.de>; Thu, 06 Nov 2025 23:41:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3E2FD34ECAF
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Nov 2025 22:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF9732AAD4;
	Thu,  6 Nov 2025 22:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BCIaCJTB"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D722DBF4B
	for <linux-ext4@vger.kernel.org>; Thu,  6 Nov 2025 22:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762468872; cv=none; b=rAn5qV2MOzqisL+mxpaml6A9ure2hxR/Jo5NkYZLUUfna9SQhQo+lfEskRwgTftFh4WrLlBosSFVxgWjzZOkZGlfY0I9RnmbQb1prhrMdnGLVelMTIdTm3WxHEBbyOm0XemC+GncuVaLckd45HOuGmrYqD510UIOtlvGzGYOJCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762468872; c=relaxed/simple;
	bh=ubngRMjiaUCx1zePDLHAt8rpbYoDWLnJt4J/IBYiJDE=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uD5oSXgbJLkKND6A4ixZOYvVeEA0cd2vhZuUQ1m1s+DQPUpThGEP+yLuBO9OjMnTNqP8RCPk714ytIuGPlncWkHPVy3KzOuYsTKTcx+mwxU3X73BINLVBM7s+tu6HI6CzlCUObzIcMG3S3k9quGWBhK5OSfqY0UfRJTf+XlEHvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BCIaCJTB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 234A8C116C6;
	Thu,  6 Nov 2025 22:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762468872;
	bh=ubngRMjiaUCx1zePDLHAt8rpbYoDWLnJt4J/IBYiJDE=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=BCIaCJTBA0VnC8qAPoTmIWaflu8Hqg3mi9l9LakSyCsZrbxdaP9lM6svcbU2bDg89
	 H74752IU2wCfBYxRLOL3r3ao2bv0f3e23kvq/s11LFf+dfLB/QVQXwbk7cx2FutgpF
	 YIOJg9xr/eyJjaybsErljJwhSGQ6hOoTOEaMbSCfEGTXsijzSdTXigfpeZAuB60uM8
	 j6ealpcTcu7V7TIexlzLTASdAxyGm1vc9PZcB6qDqcIL69Qt7cj1Hw5p7xjKO1tQIy
	 rqV/Y6HewoDrwN8VCgQ63Ws4DGm7cGpKvu9fh7tAfByiYWS6xZTn82juLzl/ZEnmkf
	 LmiQ1vbpcr06Q==
Date: Thu, 06 Nov 2025 14:41:11 -0800
Subject: [PATCH 4/4] fuse2fs: record thread id in debug trace data
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <176246794918.2863722.14330206470480139465.stgit@frogsfrogsfrogs>
In-Reply-To: <176246794829.2863722.7643052073534781800.stgit@frogsfrogsfrogs>
References: <176246794829.2863722.7643052073534781800.stgit@frogsfrogsfrogs>
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
index 9927a5d14c8fd2..33e456aa0a964c 100644
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


