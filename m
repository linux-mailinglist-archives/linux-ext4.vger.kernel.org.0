Return-Path: <linux-ext4+bounces-8212-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F70AC756C
	for <lists+linux-ext4@lfdr.de>; Thu, 29 May 2025 03:37:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BA941C02AB0
	for <lists+linux-ext4@lfdr.de>; Thu, 29 May 2025 01:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B98241B0F17;
	Thu, 29 May 2025 01:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X6jJjWkO"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE5E2DCC0C
	for <linux-ext4@vger.kernel.org>; Thu, 29 May 2025 01:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748482634; cv=none; b=Pppndwk5DGw63IGgDIsDjrHGY51m9MGg9zOt65FhDzfC4wiZidFGKIN7wJU2hWheBfFB757AIshezmv9sJbObWM7eEwTz/8eHGw7wmxRnJNZb0LFtRZgKYeVm3JdXo7iYvf6JaBdRjwEFrzWBlUzX8hBE0fkx7opPGXjCMD7Cg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748482634; c=relaxed/simple;
	bh=iM7O6f8O6APfpFtC3ADo2vGHy1ey8z5M02ZI1kwJJeo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R0Wl5spq1u+8AaLY9n/QKUOsVgiwL0y28xsnhlwb16xOhKa9ROkf2BNX5L/P1D0/xTlHxtA7lehww8Bk+AoR4XQVQnBp/pKqaCC4U8lxMW5Ed0ctB+jzjDFz/2UlCYHz9HpEJDZZ4skAYdcU2UchI3YCaPw/b7nal3Z748pce5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X6jJjWkO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B74E3C4CEED;
	Thu, 29 May 2025 01:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748482633;
	bh=iM7O6f8O6APfpFtC3ADo2vGHy1ey8z5M02ZI1kwJJeo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X6jJjWkOkno2uPtZLcWGRY5T29Wid0xDJCxQ4A002QRNgh2YcQP+pNJn5Q32BmGoR
	 F7bqYFXZB0MTkXquKTqxSLmkt4kjFCqPtCQrLzjIQmcYqk6evk22k3nWTKHIbg67GD
	 7Lc+UzoTJ7Ga03uE09kYF/RKesJTjjqHF+R/Tzl4kP/2eBGkNBSI3YDa0jAFMD4jyP
	 cfmZZOLTJHhyRxmRmnO45ptqezLPY7kfE/4T+gGLIuRMnZx6YNvIi0RdQsZkDqtHO/
	 f1dea1RvZcBv8abhtr2H+hdeFn/XTHKBy0e2h55v6prGnu4wjVDb7BNsO0O3UUWXdc
	 SgWY+X2KthwRw==
Date: Wed, 28 May 2025 18:37:13 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Theodore Ts'o <tytso@mit.edu>
Cc: linux-ext4@vger.kernel.org
Subject: Re: [PATCHSET 1/6] fuse2fs: even more bug fixes
Message-ID: <20250529013713.GA8282@frogsfrogsfrogs>
References: <174786677421.1383760.15289906755026332870.stgit@frogsfrogsfrogs>
 <20250523140344.GA1414791@mit.edu>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250523140344.GA1414791@mit.edu>

On Fri, May 23, 2025 at 10:03:44AM -0400, Theodore Ts'o wrote:
> On Wed, May 21, 2025 at 03:34:36PM -0700, Darrick J. Wong wrote:
> > Hi all,
> > 
> > This series fixes even more bugs in fuse2fs.
> 
> Thanks, applied.  I found that it didn't compile, because it used
> fuse2fs_{read,write}_inode() which doesn't get defined until PATCHSET
> 2/6.  So I've also applied the second patchset, and then split the
> patch "fuse2fs: simplify reading and writing inodes" into two commits,
> and applied the first half before "fuse2fs: fix removing ea inodes when
> freeing a file" to keep the fuse2fs changes bisectable.
> 
> Also, I cleaned up some patches to keep fuse2fs portable enough to
> work with MacOS.  I've lightly tested fuse2fs with MacFuse (installed
> via MacPorts) on macOS Sequoia and it works without having to pay $$$
> to Apple.  You do need to enable the MacFuse system extension (which
> is signed by Benjamin Fleischer, so I guess Fleischer is the one who
> paid $3000 to Apple) and reboot, but it does work.
> 
> I'll reach out to someone in FreeBSD land to test whether fuse2fs
> works there, since I'd like to maintain cross-OS portability as much
> as possible.

Hrmm.  A question I've been pondering for a couple of weeks is whether
or not fuse2fs-iomap should actually care about cross-OS portability.
The further I wander into the two layers of libfuse, the more I realize
that the low level fuse library is for fuse servers that want to tie
themselves to Linux (e.g. you can implement statx and copy_file_range)
and the high level library, which seems to be maintaining compatibility
with the osx/bsd variants.

At this point I don't know if one can actually /create/ a hybrid fuse
server that talks to both layers (layering violation!!) since the upper
level hides the guts of the low level library.  If you've looked at the
fuse2fs iomap code, you'll notice that I've passed the Linux fuse
driver's nodeid (aka the iget number) all the way up to fuse2fs along
with the ext2 ino number which is basically a u64 cookie that gets
passed along with the nodeid.

If the Linux fuse driver maintainers accept the fuse-iomap code then
maybe it would make sense to fork fuse2fs: one for general compatibility
across filesystems, and second one optimized for Linux.

> It does mean that I'm a bit concerned about the fuseblk
> patchset because I'm pretty sure that's Linux-specific, correct?

That's a good question.  libfuse says that fuse_operations::bmap only
makes sense for filesystems mounted with the "blkdev" option (which is
what turns on fuseblk mode) and doesn't #ifdef it away on any platforms.
libfuse itself seems to be built on freebsd, but then ...

Looking through what I think is the mount option parsing code in
fuse_vfsop_mount, I don't think they support a blkdev= option?
https://raw.githubusercontent.com/freebsd/freebsd-src/refs/heads/main/sys/fs/fuse/fuse_vfsops.c

So maybe it's not supported on !linux.  Unfortunately, it's not easy to
tell from the one other fuseblk server I know of (ntfs-3g) if they even
try to use fuseblk mode on freebsd because of course they vendored
libfuse into their own source code(!)

Will have a closer look tomorrow.  At worst we can always wrap it in
more #ifdef __LINUX__ magic.

--D

> Cheers,
> 
> 						- Ted
> 

