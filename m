Return-Path: <linux-ext4+bounces-10051-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3B04B58797
	for <lists+linux-ext4@lfdr.de>; Tue, 16 Sep 2025 00:37:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6FD12036D1
	for <lists+linux-ext4@lfdr.de>; Mon, 15 Sep 2025 22:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D4702D1F7C;
	Mon, 15 Sep 2025 22:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a3Aea+2H"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F1B2D052
	for <linux-ext4@vger.kernel.org>; Mon, 15 Sep 2025 22:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757975867; cv=none; b=l/ffJvJBZ6nWyMzcw9PaIzP19vHO4FTbP174uls15Vvh1bUs04zOO08/nTZzxe0qYUHH24XL+Gd43ihcNTwEEgjCoU8GzHwpcvwXIxlkbQ9uOpse02PFgwW1d/23y/hJhgOogUoj6he0x2G4IX5ZoEQ9wkG0i85Ll7RtQGGOvN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757975867; c=relaxed/simple;
	bh=OJ7l6H/+mGtvJngvn/qIoBi6TQQ3JgdoR8ceTb6ww+o=;
	h=Date:Subject:From:To:Cc:Message-ID:MIME-Version:Content-Type; b=WdA/JRwASIh4iopXcNG7K3LKEtm9LU5/uBoZt/v0Bz75YCNJ7aH1Aefs0MNQxSaFEnPL6UbdvaxCPGzYrsCePOJka5C3fE6R8NqA9bQrC5RLn1ENvsagL1P+RY2iM4M5sRh8K3ZTYlPzG2NUthhVDPCal79ZC7NYCADMRRuRj7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a3Aea+2H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D1CAC4CEF1;
	Mon, 15 Sep 2025 22:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757975867;
	bh=OJ7l6H/+mGtvJngvn/qIoBi6TQQ3JgdoR8ceTb6ww+o=;
	h=Date:Subject:From:To:Cc:From;
	b=a3Aea+2HkDbIrqrBwT9sz2XR+IFj7luLXiBHIdDwmx1Obb6stnaXRRxxLXryAhCGU
	 yPYNgB9qNUAQI5e0Y4xIIj5Fsj+tJm2kON+tDfBHTsNGG8f3vfnR82ZShX8Mu0D+he
	 4LjFCE8pXdoMG/UmbvEEWmCR04Hw+pgTfrI1U4jOYwOZdhdoBj3s4TQKFP9RIV/UMx
	 x4Jb6gsM/+SpbnnqeWJhoo0aa/MDMB2lckCsGtvX4+KXT3ZzZQ3SSnfZk1WUmH90mM
	 b62Mv6T7KqlpcdMgEJFKLhs/jKiSVYeBF9rgb2Hk+iqX8KRc9jDKgVhs3o7wAZ6BmG
	 fS27xjJG8SOjg==
Date: Mon, 15 Sep 2025 15:37:46 -0700
Subject: [PATCHSET 1/2] fuse2fs: round 5 bug fixes
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org, linux-ext4@vger.kernel.org
Message-ID: <175797569564.245695.4628729304068635201.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi all,

This series fixes more bugs in fuse2fs.

If you're going to start using this code, I strongly recommend pulling
from my git trees, which are linked below.

Comments and questions are, as always, welcome.

e2fsprogs git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/e2fsprogs.git/log/?h=fuse2fs-fixes
---
Commits in this patchset:
 * libext2fs: use F_GETFL, not F_GETFD, in unixfd_open
 * libext2fs: don't look for O_EXCL in the F_GETFL output
 * fuse2fs: update manpage
 * fuse2fs: quiet down EXT2_ET_RO_FILSYS errors
 * fuse2fs: free global_fs after a failed ext2fs_close call
 * fuse2fs: fix memory corruption when parsing mount options
 * fuse2fs: fix fssetxattr flags updates
 * fuse2fs: fix default acls propagating to non-dir children
 * fuse2fs: don't update atime when reading executable file content
 * fuse2fs: fix in_file_group missing the primary process gid
 * fuse2fs: work around EBUSY discard returns from dm-thinp
 * fuse2fs: check free space when creating a symlink
---
 lib/ext2fs/unix_io.c |    7 ++--
 misc/fuse2fs.1.in    |   42 ++++++++++++++--------
 misc/fuse2fs.c       |   94 +++++++++++++++++++++++++++++++++++++++-----------
 3 files changed, 103 insertions(+), 40 deletions(-)


