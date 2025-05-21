Return-Path: <linux-ext4+bounces-8077-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F196ABFF98
	for <lists+linux-ext4@lfdr.de>; Thu, 22 May 2025 00:35:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E48853A6BD7
	for <lists+linux-ext4@lfdr.de>; Wed, 21 May 2025 22:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA24A230269;
	Wed, 21 May 2025 22:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rntKaX19"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE83239581
	for <linux-ext4@vger.kernel.org>; Wed, 21 May 2025 22:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747866894; cv=none; b=tqkqiaxqpegloyZ5sOAO3+rm8sVQS5bbFw8h/rryWLBT9E5851cZCSot0OEZrjDxGzPUYIXlCX60PLIbqtHdkhSmDI3QbKu/VhrAUtJuEopc7hA73YNY4MquxyUWOuPdkOkNd4P/zJFB/n/FqIpf2CbcR7LtYrRuu1bdl9hg5bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747866894; c=relaxed/simple;
	bh=8gCLEa5u1uyR1TPZL5Zr3YOiXZzv343U8XFjvPb52hM=;
	h=Date:Subject:From:To:Cc:Message-ID:MIME-Version:Content-Type; b=HC0BiZC4QxRN2D6si01DOwKu5f/i/WDDefaDUi3arhrVV4Yh6GgDktK5H5VNB39nuYmkqTfl00rHZ4QhZRtju6yODfQRdgMghNwngWXf9LbyaTdTJTM5MggZfkmZPGtcdccEpUU+ZGegbTjKk5H+W5oz5j1k51EXjFFtwWmzsio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rntKaX19; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0655EC4CEE4;
	Wed, 21 May 2025 22:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747866894;
	bh=8gCLEa5u1uyR1TPZL5Zr3YOiXZzv343U8XFjvPb52hM=;
	h=Date:Subject:From:To:Cc:From;
	b=rntKaX19OZqavXb/BSP4oT/ll3qQLIhHvSMOEldMb2v25bqTTv10vbVb3+RU16xd3
	 n8xDE/oNMi/j/kDhidytAT6P67byD6Yn/omITROWgB4FX5QUoYxm/WHaifZY7zx4va
	 133JwVy3rgaCwiGw6SBXAyaIAbkaSCxfFKA5VkeB4YU6+AWpAtGSUIBS8ar2JnKq1v
	 ZFflUScjn0tKbupC1VOCCP6jbTT+lrQpM+J5sSgD2v8OI33gHjMELKBuwkgtUg9Jfi
	 m8qedBU+HrOQpKDUdJXOcYCNXLpUk8ftOsK+l2sJdd92X7OwbyoJ8pLYMoX93S0aNM
	 xHhv36dUB294g==
Date: Wed, 21 May 2025 15:34:53 -0700
Subject: [PATCHSET 4/6] fuse2fs: use fuseblk mode
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <174786678650.1385354.14994099236248944550.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi all,

While I was testing pre-iomap fuse2fs, I noticed a strange behavior of
fuse2fs.  When the filesystem is unmounted, the VFS mount goes away and
umount(3) returns before op_destroy is even called in fuse2fs.  As a
result, a subsequent fstest can try to format/mount the block device
even though fuse2fs hasn't even finished flushing dirty data to disk
or closed the block device.

This causes various weird test failures.  More alarmingly, this also
means that the age old advice that it's safe to yank a USB stick after
unmount returns is not actually true for fuse2fs.  This can lead to user
data loss.

There is a solution to this -- fuseblk mode.  In this scheme, fuse2fs
tells the kernel which block device it wants, the kernel opens the block
device, and it upcalls FUSE_DESTROY before releasing the block device
or the in-kernel super_block.  This gives us the desired property that
when unmount completes, it's safe to remove the device.

Unfortunately, this comes at a price.  Because the kernel insists upon
opening the fuseblk device in O_EXCL mode, we have to close the
filesystem before starting up fuse, and reopen it in op_init.  This
creates a largeish TOCTOU race window and increases mount times.  Worse
yet, if CONFIG_BLK_DEV_WRITE_MOUNTED=n, then this won't even work.

The last patch also registers fuse2fs as a process involved in memory
reclamation to prevent memory allocation deadlocks.

If you're going to start using this code, I strongly recommend pulling
from my git trees, which are linked below.

Comments and questions are, as always, welcome.

e2fsprogs git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/e2fsprogs.git/log/?h=fuse2fs-use-fuseblk
---
Commits in this patchset:
 * fuse2fs: rework FUSE2FS_CHECK_CONTEXT not to rely on global_fs
 * fuse2fs: get rid of the global_fs variable
 * fuse2fs: close filesystem from op_destroy
 * fuse2fs: split filesystem mounting into helper functions
 * fuse2fs: make norecovery behavior consistent with the kernel
 * fuse2fs: check for recorded fs errors before touching things
 * fuse2fs: recheck support after replaying journal
 * fuse2fs: improve error handling behaviors
 * libext2fs: make it possible to extract the fd from an IO manager
 * fuse2fs: use fuseblk mode for mounting filesystems
---
 lib/ext2fs/ext2_io.h         |    4 
 debian/libext2fs2t64.symbols |    1 
 lib/ext2fs/io_manager.c      |    8 +
 lib/ext2fs/unix_io.c         |   15 +
 misc/fuse2fs.c               |  491 +++++++++++++++++++++++++++++++-----------
 5 files changed, 387 insertions(+), 132 deletions(-)


