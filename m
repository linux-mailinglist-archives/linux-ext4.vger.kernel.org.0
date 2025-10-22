Return-Path: <linux-ext4+bounces-11012-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B59BF99B1
	for <lists+linux-ext4@lfdr.de>; Wed, 22 Oct 2025 03:26:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 661E73B3A93
	for <lists+linux-ext4@lfdr.de>; Wed, 22 Oct 2025 01:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2090156C6A;
	Wed, 22 Oct 2025 01:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mr/8UiKC"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842CB153BED
	for <linux-ext4@vger.kernel.org>; Wed, 22 Oct 2025 01:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761096351; cv=none; b=pWq9R+feVf3syvf48hgrA+V6Q9eXjBz/n453z8G5Z4ROHyt8nPZqyMCSQGM9kISZ2SQcIaJm3FwqewlPG9MJ+EyJENbphvkqf0/Lkru3afQpoutGLC++C/Az/Ds8VtjPr5IP+ssaZKNc+XcEbnizNVKGagkVj3pJUuy/3w36zmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761096351; c=relaxed/simple;
	bh=v9jAzS7HJfjfS1Etg35zXzZUYCzlIBvvx3NK1LQoZ5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CNKk8a46qsHZbR2dTJxNwSf6ec0FY7pokW0Rwz5bV1R37Nnw59vtyLM3wy4AfgypDrRk5s54vnx3NvPN5kWpJ2HlS9nOdSXIODlCLg+90wjOp159px8OJrAinKSsBGw89e1Q/JguaHZs3h3YUCE+1a7gVls6oz6L6I7yXM3B6/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mr/8UiKC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8D12C4CEF1;
	Wed, 22 Oct 2025 01:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761096351;
	bh=v9jAzS7HJfjfS1Etg35zXzZUYCzlIBvvx3NK1LQoZ5g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Mr/8UiKC37M5pX25Q0zc5yFIDvkJc77ryNqgSSyUbREH6iX96uxBz9kChbji0U3lP
	 /Ky7mknkXE0ELt/ETFup4I+/aAh6/mOCHzgq6OL27kgGvnuTSjGmSUvM4uv9GPysaR
	 tuQEuzifnFuApazfgYsh2cnbJgtACwe0RzWR5t2gFJVBGCk7jJLAqRQK2qL+i5RKnz
	 wqNyb8KouUd9fcBBnFlGQyqVeaGe19OOoThfhjS5nOym7cOOJUF9yy2atQHhzFHEHe
	 yHtzDhNHn53FnyG/NDrRg1VCdLN99vK0J7a4QiosWtVtthr1JMyXpKBPUMXow9Dx0B
	 a/9/2PJeEcSpg==
Date: Tue, 21 Oct 2025 18:25:50 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Dave Dykstra <dwd@cern.ch>
Cc: linux-ext4@vger.kernel.org
Subject: Re: [PATCH] fuse2fs: updates for message reporting journal is not
 supported
Message-ID: <20251022012550.GP6170@frogsfrogsfrogs>
References: <20251016200903.3508-1-dave.dykstra@cern.ch>
 <20251017191800.GF6170@frogsfrogsfrogs>
 <aPKilSNCQRW9c6rl@cern.ch>
 <20251017232521.GI6170@frogsfrogsfrogs>
 <aPgKP-wUhhfwqKke@cern.ch>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPgKP-wUhhfwqKke@cern.ch>

On Tue, Oct 21, 2025 at 05:33:35PM -0500, Dave Dykstra wrote:
> On Fri, Oct 17, 2025 at 04:25:21PM -0700, Darrick J. Wong wrote:
> > On Fri, Oct 17, 2025 at 03:09:57PM -0500, Dave Dykstra wrote:
> > > On Fri, Oct 17, 2025 at 12:18:00PM -0700, Darrick J. Wong wrote:
> ...
> > > > > -	if (global_fs->flags & EXT2_FLAG_RW) {
> > > > > +	if (!fctx.ro) {
> > > > 
> > > > Again, rw != EXT2_FLAG_RW.
> > > > 
> > > > The ro and rw mount options specify if the filesystem mount is writable.
> > > > You can mount a filesystem in multiple places, and some of the mounts
> > > > can be ro and some can be rw.
> > > > 
> > > > EXT2_FLAG_RW specifies that the filesystem driver can write to the block
> > > > device.  fuse2fs should warn about incomplete journal support any time
> > > > the **filesystem** is writable, independent of the write state of the
> > > > mount.
> > > 
> > > Are you saying that is indeed possible for a read-only mount to cause
> > > file corruption or data loss if there's not a graceful unmount?  If so,
> > 
> > No, I'm saying that filesystem drivers can *themselves* write metadata
> > to a filesystem mounted ro.  ro means that user programs can't write to
> > the files under a particular mountpoint.  This has long been the case
> > for the kernel implementations of ext*, XFS, btrfs, etc.
> 
> I understood that, but does the filesystem actually write metadata after
> the journal is recovered, such that if the fuse2fs process dies without
> a clean unmount there might be file corruption or data loss?

Yes.  If the vfs mount becomes rw, then fuse2fs will start receiving
requests to change files on the filesystem after a journal recovery.
Notice how there's no code in fuse2fs to receive notifications of ro->rw
or rw->ro transitions?  That's because the fuse driver doesn't send any.

>                                                               That is,
> in the case of ro when there is write access, does the warning message
> really apply?

Yes.  util-linux has done that for a long time, because MS_RDONLY (aka
the flag that gets passed in when a mount fails with EACCES) both sets
the mountpoint to ro and also allows read-only block devices.  It's a
strange artifact of 1990s Linux.

> > I've said this three times now, and this is the last time I'm going to
> > say it.
> 
> I understood what you said but I'm asking about the implications.
> 
> ...
> > Are you running fstests QA on these patches before you send them out?
> 
> I had not heard of them, and do not see them documented anywhere in
> e2fsprogs, so I don't know how I was supposed to have known they were

You could ask Ted, since you were clearly in communication with him on
github.

"Hi.  I would like to send a patch.  What are the community norms for
generating patch submissions?  Who else should I be asking questions of?
How is QA done on filesystem driver code?"

> needed.  Ideally there would be an automated CI test suite.  The patches
> have passed the github CI checks (which don't show up in the standard
> pull request place, but I found them in my own repo's Actions tab).

https://git.kernel.org/pub/scm/fs/ext2/xfstests-bld.git/

> Are you talking about the tests at https://github.com/btrfs/fstests?
> If so, it looks like there are a ton of options.  Is there a standard
> way to run them with fuse2fs?

https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git/

Or, since fstests has never been ported to fuse2fs you'll need my
patched version:

https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfstests-dev.git/log/?h=fuse2fs_2025-10-21

--D

> Dave
> 
> 

