Return-Path: <linux-ext4+bounces-9749-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C482B3A2AE
	for <lists+linux-ext4@lfdr.de>; Thu, 28 Aug 2025 16:51:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C895A3ADFFC
	for <lists+linux-ext4@lfdr.de>; Thu, 28 Aug 2025 14:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC20E31986D;
	Thu, 28 Aug 2025 14:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GDyyIRhl"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6501F5825
	for <linux-ext4@vger.kernel.org>; Thu, 28 Aug 2025 14:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756392362; cv=none; b=BQr0ZmAXOOBIXDl3441ymXMg/0fzRDS5IpDy8Hcaf9cCo0BdpBc5XeFl3bsxdHakAqwMUvBIVyvJZ82d0wCZnfaH11EXIAWRULHjcomXGQqMUkRuiaAXVzoUGgkepi/0QSpNbU5zocvJ+fI6sRtbhaMZMFvLdcKX0OfZryX58hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756392362; c=relaxed/simple;
	bh=ffmcU6X8uDUj4Xi1A5zImH/edBo75xt/wn+V8S/sPWc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=guq7STrpYtCXw9awwiszVh2xMQnW4GGWs3FPEWWm7RX+23fG/wh92qItKtPImEY9EztkxgbhhYCcfdwkM4AwmGjYZpSPO7v/fVS+PAp2eYYPaUQKWR5wT9QGJ01bKDKzoVtJlFuFcHIYPZZt4jY2rm+6MFR3eETpFExwKBerYF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GDyyIRhl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17AD7C4CEEB;
	Thu, 28 Aug 2025 14:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756392361;
	bh=ffmcU6X8uDUj4Xi1A5zImH/edBo75xt/wn+V8S/sPWc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=GDyyIRhliK+JKlgLav8ShcUb+Q+NlcpFazkzuxsq5mG7BH7K5s6WvP3Pn95RSMh+m
	 LXUH+IariouERHYxRz21plAHEeUAsWCbzgimS1M5GYLtm86OR+0QxYNWMaQAeaM3nC
	 rdOKTYlL5WgTjEZRA9Lns7Xv+a9Oo279T7uF8i9CXvppV56q0+t86CdtzNeyZvh0H4
	 W0lhJh3/vNPHgSjYlfJ1IMOwtSmkiJbpEYstS16AcYresXUVitZvZHRpqLZuuhOS7M
	 O6vQkX8dNGdJ+AMvPZKW9PLeqUThw1QA+Ax0CjvTRNhWW73Jz1bet1DIxauhe4Tkms
	 2XwfyHPfFqU1g==
Date: Thu, 28 Aug 2025 07:46:00 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Theodore Ts'o <tytso@mit.edu>
Cc: linux-ext4 <linux-ext4@vger.kernel.org>
Subject: [PATCH 2/2] libext2fs: don't look for O_EXCL in the F_GETFL output
Message-ID: <20250828144600.GB8084@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250828144312.GA8084@frogsfrogsfrogs>

From: Darrick J. Wong <djwong@kernel.org>

For decades, Linux has never propagated O_EXCL into the user-visible
file flags in do_dentry_open:

	f->f_flags &= ~(O_CREAT | O_EXCL | O_NOCTTY | O_TRUNC);

Therefore, one cannot use F_GETFL to determine if the file was opened
with O_EXCL.  The unixfd IO manager will have to trust that the caller
opened the file in O_EXCL mode.  Without this patch, the upcoming flock
patch will not work correctly in determining the lock mode to keep other
copies of fuse4fs and/or systemd from touching a fuse4fs mounted
filesystem.

Cc: <linux-ext4@vger.kernel.org> # v1.43.2
Fixes: 4ccf9e4fe165cf ("libext2fs: add unixfd_io_manager")
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 lib/ext2fs/unix_io.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/lib/ext2fs/unix_io.c b/lib/ext2fs/unix_io.c
index e839628aa1b74d..55007ad7d2ae15 100644
--- a/lib/ext2fs/unix_io.c
+++ b/lib/ext2fs/unix_io.c
@@ -1172,11 +1172,10 @@ static errcode_t unixfd_open(const char *str_fd, int flags,
 	if (fd_flags == -1)
 		return EBADF;
 
-	flags = 0;
+	/* O_EXCL is cleared by Linux at open and not returned by F_GETFL */
+	flags &= IO_FLAG_EXCLUSIVE;
 	if (fd_flags & O_RDWR)
 		flags |= IO_FLAG_RW;
-	if (fd_flags & O_EXCL)
-		flags |= IO_FLAG_EXCLUSIVE;
 #if defined(O_DIRECT)
 	if (fd_flags & O_DIRECT)
 		flags |= IO_FLAG_DIRECT_IO;

