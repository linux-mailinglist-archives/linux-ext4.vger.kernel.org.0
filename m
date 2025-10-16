Return-Path: <linux-ext4+bounces-10895-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE889BE44EF
	for <lists+linux-ext4@lfdr.de>; Thu, 16 Oct 2025 17:43:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1AB33ACA48
	for <lists+linux-ext4@lfdr.de>; Thu, 16 Oct 2025 15:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A55034BA41;
	Thu, 16 Oct 2025 15:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="beYgwqTO"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6D834AB10
	for <linux-ext4@vger.kernel.org>; Thu, 16 Oct 2025 15:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760629235; cv=none; b=kyW1Gm3pafdGR6M1O1YaNpNgfNmBTM3rXZv452eaCsYX7Ge9bMlq7oq8lzfL9SAmLLHgGZyj/amCuNffxwFyr3k5lpfb2kXxoXkTpkAJgLvt0yQhDKdeeO18sJ2Ns6Ya6XrONSy3R/K4PAyzyycG+p2QSVWEhqljownWWec5gGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760629235; c=relaxed/simple;
	bh=MDc9E4MVP6maeBz5e3kcImL0EaRxzQHs4Ru3zcjIvJM=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jwLczUJFORq8ndOFLitLsIJfF9wiR+pO41Y+FD77R5lKYAr/IlCLq8AHao++lg/WlrBQxEaloGdaSoI+TAx4s58LPe2fXeSeVybh71SmUfxRHUsaypcweeGf7IJCC6MVM5O10jx+vZFnD1mQwRFxi49JWm6B9p2Fvd2WJZvsIhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=beYgwqTO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA0F2C4CEF1;
	Thu, 16 Oct 2025 15:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760629234;
	bh=MDc9E4MVP6maeBz5e3kcImL0EaRxzQHs4Ru3zcjIvJM=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=beYgwqTO2Wyk8oeh2DXH+BlAQsV/IlRKC1i1L4QUxPffqQSkkOr2CreM7fgajba6z
	 Zh+LOy/cgXeshjcOSnI5bJIR0ni5B9qId4dwUajO9omD0eEpFd08rm7ts1Mt6wGOjD
	 pVE1Biaiqie1m4gQ/5KUTv+LKCc3oExQ5DknmMeC7vveMj4Yz/CpSb/zdqPwDamdsE
	 PewSbpQrsvkvPMqpiHItFyE6qv1pyLmfk///B4rToglBkMq96tHW77tGReVvE6PnvA
	 BVBQtE/tnVUXIO2ryABLsDOyLtNu8OHTvLKVvkdhXvwD5lvM5H3uz+1t/93/iQRHty
	 ZV20fqgJVnNCw==
Date: Thu, 16 Oct 2025 08:40:34 -0700
Subject: [PATCH 03/16] libext2fs: don't look for O_EXCL in the F_GETFL output
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org, linux-ext4@vger.kernel.org
Message-ID: <176062915519.3343688.10730175723791470201.stgit@frogsfrogsfrogs>
In-Reply-To: <176062915393.3343688.9810444125172113159.stgit@frogsfrogsfrogs>
References: <176062915393.3343688.9810444125172113159.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

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
index adbdd5f6603d74..723a5c2474cdd5 100644
--- a/lib/ext2fs/unix_io.c
+++ b/lib/ext2fs/unix_io.c
@@ -1090,11 +1090,10 @@ static errcode_t unixfd_open(const char *str_fd, int flags,
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


