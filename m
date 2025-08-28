Return-Path: <linux-ext4+bounces-9748-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55C03B3A2B9
	for <lists+linux-ext4@lfdr.de>; Thu, 28 Aug 2025 16:52:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2269516B6CC
	for <lists+linux-ext4@lfdr.de>; Thu, 28 Aug 2025 14:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2286631579B;
	Thu, 28 Aug 2025 14:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DhhIpFD/"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D5B3148BC
	for <linux-ext4@vger.kernel.org>; Thu, 28 Aug 2025 14:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756392195; cv=none; b=fjHTHd7I6fndoJORU05cm/89v2DVTDN2uTjrSKpQihIA6gKw8BHSvVQPLPfz0I2vvN6EHNzHlSdeaZl4eP1vsvMHoVQxg0md1VcLZ6nSBvplmtI/FJTijieXe76rULynY9arYh6Q5pyoxWZjcbRSx0TNs0KeYX2787+NlBRZWrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756392195; c=relaxed/simple;
	bh=6ICnskp/n84fIKTS6Q8RXDW03z+o5uRNrXM1eqTDFXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=FcsPFGYkGnojEl8EHMEvXMCwdUaEcvn05Upr5ozeUoSI0SwF/VYF8cMMHWqq4Zm1iqeOUxynamh69BHXYOHxsHIjdLndtxO+UHmLMvIQ7WCIrf8ooc9wuNUfJPpkG4YU/MsukXfb9pOxCfdDj4EjYqWc/cxDaYAuujqijqXfJzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DhhIpFD/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CBCAC4CEEB;
	Thu, 28 Aug 2025 14:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756392193;
	bh=6ICnskp/n84fIKTS6Q8RXDW03z+o5uRNrXM1eqTDFXQ=;
	h=Date:From:To:Cc:Subject:From;
	b=DhhIpFD/KXdwY8D6e+8QeBc9hLxBDB0lOhCdprcUjEAlXPJF3IvhfkamYxBMQHMgH
	 RKJER5uLm5NyKC/QihyKgFfdYxoxG0lLNOmA2nW0LZBE0XCDbAzqa2wDM30qYIavmw
	 vN2qtxdQsSIAdJ3PVKj2V9ze+ygV3LhFhvgbEINuwQ5pcq/9ZojT7QjiYDKin4JWRP
	 VuGPv6G2c7QNvvMJ+IFVPT/GfTxwAHlIIk6/EsNjatUP6fLmLvtxVt7AuM2WL51w1W
	 2mjkJRqaL/za8QkXa8HOZlxxITmmujigbvM8flX0OXFWPxetyTKBcIllf0muH7sCC8
	 4a37mWOrllTTA==
Date: Thu, 28 Aug 2025 07:43:12 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Theodore Ts'o <tytso@mit.edu>
Cc: linux-ext4 <linux-ext4@vger.kernel.org>
Subject: [PATCH 1/2] libext2fs: use F_GETFL, not F_GETFD, in unixfd_open
Message-ID: <20250828144312.GA8084@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

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
index 4a841f7f2133d4..e839628aa1b74d 100644
--- a/lib/ext2fs/unix_io.c
+++ b/lib/ext2fs/unix_io.c
@@ -1168,7 +1168,7 @@ static errcode_t unixfd_open(const char *str_fd, int flags,
 
 	fd = atoi(str_fd);
 #if defined(HAVE_FCNTL)
-	fd_flags = fcntl(fd, F_GETFD);
+	fd_flags = fcntl(fd, F_GETFL);
 	if (fd_flags == -1)
 		return EBADF;
 

