Return-Path: <linux-ext4+bounces-10079-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AD5F2B588A9
	for <lists+linux-ext4@lfdr.de>; Tue, 16 Sep 2025 01:59:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7FA6E4E1DD0
	for <lists+linux-ext4@lfdr.de>; Mon, 15 Sep 2025 23:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5D242DAFD2;
	Mon, 15 Sep 2025 23:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pmc80OBJ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D3E5C96
	for <linux-ext4@vger.kernel.org>; Mon, 15 Sep 2025 23:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757980742; cv=none; b=Pxnb3PqtY7RmmqXZLssPaiYgwb83pZl6DlKaJZnAM9taUJtMlzzZGe27VoBvc3u2hFrEsIzSylnevDTxo2PaDafTsMjscRz9MjP59OH8nhuuIt0AQCL1KV2nmLzNn5u5ZwKdC2YUbJq5ELCFeVjTBYLTpnn32SESapOxen5D5Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757980742; c=relaxed/simple;
	bh=XevjADMZsHWlONEo6KxM13vna1xW7l9bSzRRkga3ZLQ=;
	h=Date:Subject:From:To:Cc:Message-ID:MIME-Version:Content-Type; b=A5PWDR9jefBoy9qjvPhPCkAYF5OeLb9/RU4mm+H5Xdd6Cad4Z1zzEjNHxXGLvRocQQd4TVHYjec6D3aE6LDauV2xB8jd1EYBP72TUBYzSh/Gi++pRSTETGjT19A0Q9HsbIQ4HNLegcV4BO9ydEilIOzjRlQEF3xoAqC0XQJB6eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pmc80OBJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29682C4CEF1;
	Mon, 15 Sep 2025 23:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757980742;
	bh=XevjADMZsHWlONEo6KxM13vna1xW7l9bSzRRkga3ZLQ=;
	h=Date:Subject:From:To:Cc:From;
	b=pmc80OBJCqxh6BDYxhVil2/gxtsckJpvvhm2i1xpJQy0Irz2qoC4SZQNrY+g+1F5U
	 xymmUAqOEwnoA8vw5Axk+v6M7PRs+89TfQeEP4Y1fjLeeBe8XAAT8gg2ftO4SOIAEP
	 q0v6VbQ8x74QHr4zSkNJGzSia7AJjsER6kJo1kM9brTXRId9CtpsxOcqH+t2L6PdsX
	 p1+DfM5qStcLBIS9BlYiIvqRAU+L7TI/zo6ph7S6o6uKiTm+gKa5klgKPkYfmOC5sl
	 cF4/hRiG0hs8u+eeZIKoBlpBcRN8ShqUsMvjt6GRVDKVtQMN+VAeEZ3V30V2rHjij6
	 fGPz9156Q1scA==
Date: Mon, 15 Sep 2025 16:59:01 -0700
Subject: [PATCHSET 4/6] fuse2fs: use fuseblk mode
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <175798064753.350013.16579522589765092470.stgit@frogsfrogsfrogs>
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
 * fuse2fs: mount norecovery if main block device is readonly
 * fuse2fs: use fuseblk mode for mounting filesystems
---
 misc/fuse2fs.c |   55 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)


