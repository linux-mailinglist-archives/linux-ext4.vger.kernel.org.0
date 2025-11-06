Return-Path: <linux-ext4+bounces-11548-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3340BC3D977
	for <lists+linux-ext4@lfdr.de>; Thu, 06 Nov 2025 23:28:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1313F4E36C2
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Nov 2025 22:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3743932D0E6;
	Thu,  6 Nov 2025 22:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f8O+YiLa"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3E130EF91
	for <linux-ext4@vger.kernel.org>; Thu,  6 Nov 2025 22:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762468089; cv=none; b=ixlc1I8Nb+0HpzlDBNKJn5CHe9G1XDHNdt2jccyOd/hRqEbE4dqVAFoXmuipSvKor0kPm2karGFPlWdZy83fKip6jS5GOv9YJmwFtcnvcT2HKPH/N7AEMBvbVlwiRYoQy5510yLJ+p/LzlDd7Fm/I0Y1WRDwanDES+dOExOmPNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762468089; c=relaxed/simple;
	bh=ezTyr/+NZ4VbG+5Iiv0eMMeqZ3NwlkiqulxF2S0wUJo=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UG0ATrQe/U2hcwD/qdsuO7c6u5TiiL16P+A08gj27O6oBnKZNn1ZzXrQpv3hGpWP1Pq3rDOVyJLlzh6ahWRLiIrnvy0WWUPA7RHqhs43pzUiO2IvtZiybj1sL+h6Egared6SZy5vblAsZFO/F2mGatCizLF25C3cCCi6ENHo/eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f8O+YiLa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E389C116D0;
	Thu,  6 Nov 2025 22:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762468089;
	bh=ezTyr/+NZ4VbG+5Iiv0eMMeqZ3NwlkiqulxF2S0wUJo=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=f8O+YiLa8t4HYrGiTCcmg8FswQFUFJagBK6I/+F1K0TNp/S+hRsWpGhZK/hQc+57O
	 L35Kqa+q+V4Kx0TCw94680pCkH4WlakH4pz6dhMOklIavkHwg+NuT/bQ7xKf5/Gklt
	 lbYuy8ScfLUMEYJc/S3IofvFFu9glZXa1TM/OEjZqcqvch1v+UImxYuGt5LccjKNsW
	 dKOkyi3o77v+E0ILwboH5oR79SmUcKv73kO4QYzPgAe8GoDm9vLaSgUfvVrIWQRItG
	 5F0B0BbG6dbUtIfnSl8JK4fgtgyCUbGgEqaWp0OHpQyJZSwZmdBJdin26y58Djr0pM
	 yAjdbTPqd9fOg==
Date: Thu, 06 Nov 2025 14:28:08 -0800
Subject: [PATCHSET 2/9] fuse2fs: add some easy new features
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org, linux-ext4@vger.kernel.org
Message-ID: <176246793541.2862242.16879509838698966689.stgit@frogsfrogsfrogs>
In-Reply-To: <20251106221440.GJ196358@frogsfrogsfrogs>
References: <20251106221440.GJ196358@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi all,

As of 2025, libfuse is a lot more capable than it was in 2013.
Implement some new features such as readdirplus and directory seeking
for better directory performance, and reduce the amount of filesystem
flushing so that it only happens when userspace explicitly asks for it.
Now we also can add htree indices to large directories, support MMP in
fuse2fs, and link count overflows are handled correctly.

If you're going to start using this code, I strongly recommend pulling
from my git trees, which are linked below.

Comments and questions are, as always, welcome.

e2fsprogs git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/e2fsprogs.git/log/?h=fuse2fs-new-features
---
Commits in this patchset:
 * libext2fs: initialize htree when expanding directory
 * libext2fs: create link count adjustment helpers for dir_nlink
 * libext2fs: fix ext2fs_mmp_update
 * libext2fs: refactor aligned MMP buffer allocation
 * libext2fs: always use ext2fs_mmp_get_mem to allocate fs->mmp_buf
 * fuse2fs: check root directory while mounting
 * fuse2fs: read bitmaps asynchronously during initialization
 * fuse2fs: use file handles when possible
 * fuse2fs: implement dir seeking
 * fuse2fs: implement readdirplus
 * fuse2fs: implement dirsync mode
 * fuse2fs: only flush O_SYNC files on close
 * fuse2fs: improve want_extra_isize handling
 * fuse2fs: cache symlink targets in the kernel
 * fuse2fs: constrain worker thread count
 * fuse2fs: improve error handling behaviors
 * fuse2fs: fix link count overflows on dir_nlink filesystems
 * libsupport: add background thread manager
 * fuse2fs: implement MMP updates
---
 lib/ext2fs/ext2fs.h          |    6 
 lib/support/bthread.h        |   27 ++
 debian/libext2fs2t64.symbols |    6 
 e2fsck/unix.c                |    2 
 lib/ext2fs/dupfs.c           |    7 
 lib/ext2fs/link.c            |  290 ++++++++++++++++++++
 lib/ext2fs/mkdir.c           |    2 
 lib/ext2fs/mmp.c             |   24 +-
 lib/support/Makefile.in      |    6 
 lib/support/bthread.c        |  201 ++++++++++++++
 misc/dumpe2fs.c              |    2 
 misc/fuse2fs.1.in            |    9 +
 misc/fuse2fs.c               |  617 ++++++++++++++++++++++++++++++++++++------
 13 files changed, 1094 insertions(+), 105 deletions(-)
 create mode 100644 lib/support/bthread.h
 create mode 100644 lib/support/bthread.c


