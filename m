Return-Path: <linux-ext4+bounces-10053-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97702B58799
	for <lists+linux-ext4@lfdr.de>; Tue, 16 Sep 2025 00:38:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 577344C2EB6
	for <lists+linux-ext4@lfdr.de>; Mon, 15 Sep 2025 22:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4A322D1F7C;
	Mon, 15 Sep 2025 22:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s9v9ItpO"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557BD2D052
	for <linux-ext4@vger.kernel.org>; Mon, 15 Sep 2025 22:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757975879; cv=none; b=iDdCbtAQltlUpG1BcgpXBKLmapzWPA7tHERP7FHHyPEtzxL+QSXJGFORJfj2uFs1Yb0X/r+32qT3yq3trGN1BhQI3bwvivQUPQMqVy/TIrpjsyUUiC8IIltzUk1HbVSVxTaDiP501cb92RLRi3B2uszpQSca38bfF79mv9EIk+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757975879; c=relaxed/simple;
	bh=r+YysSLmhZgbQU1W61N7rL0NvHp5qXjJGT+qPwNJ2pE=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R5Yusl8EAcx7OCEnsQfyGu7wWGglZVH0/GVyDOETVG5TmBFN40ztP2FRA0r5qqjUcExEArKMnr0as9vXb2Cb8/P9j50LeG+xj5gUfHW1kgLQorhEPc5B9+5HtGSpEedHLxMjhAoIkhO0WJpmUbnOW8pFvtSW7EVyUlm5fyp/oxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s9v9ItpO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB071C4CEF1;
	Mon, 15 Sep 2025 22:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757975878;
	bh=r+YysSLmhZgbQU1W61N7rL0NvHp5qXjJGT+qPwNJ2pE=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=s9v9ItpOEHOIptT7fd0WRL8LD/UVNLMgWSS+O+gUafN0mV3GkPxJo9o37dY4X4gfg
	 YL55gN9jdCXKblPVOvbAx6Hypdybq6rDmHVoX2nx81lj5jlESxwrvdcTmi9vSSPUys
	 gzd3MytiBHLcv/p0581g33DwpZth06ynwCwsZNjY/wW4tmyvZCYkjisUrbxhCHy6L2
	 KjO1UAbvW/D6CuKlch2gYbBGwSjxgdvMStU32dF0107FppRPV6COjmWnOnFug055b2
	 YimI1byoD+Kt1SbzFpaDsnlw6ShX322OBpwW7W8V1fDBkEVJ0g+Ym+WzRPgiACm6ee
	 8niTpgpTErOlg==
Date: Mon, 15 Sep 2025 15:37:58 -0700
Subject: [PATCH 01/12] libext2fs: use F_GETFL, not F_GETFD, in unixfd_open
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org, linux-ext4@vger.kernel.org
Message-ID: <175797569637.245695.9797418204966811004.stgit@frogsfrogsfrogs>
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

F_GETFD is the fcntl command that returns FD_* flags, but the callsite
wants to look at the O_* flags.  F_GETFL is the fcntl command that
returns the O_* flags, so change the subcommand to be correct.

Cc: <linux-ext4@vger.kernel.org> # v1.43.2
Fixes: 4ccf9e4fe165cf ("libext2fs: add unixfd_io_manager")
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 lib/ext2fs/unix_io.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)


diff --git a/lib/ext2fs/unix_io.c b/lib/ext2fs/unix_io.c
index cb408f51779aa7..adbdd5f6603d74 100644
--- a/lib/ext2fs/unix_io.c
+++ b/lib/ext2fs/unix_io.c
@@ -1086,7 +1086,7 @@ static errcode_t unixfd_open(const char *str_fd, int flags,
 
 	fd = atoi(str_fd);
 #if defined(HAVE_FCNTL)
-	fd_flags = fcntl(fd, F_GETFD);
+	fd_flags = fcntl(fd, F_GETFL);
 	if (fd_flags == -1)
 		return EBADF;
 


