Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A677628435D
	for <lists+linux-ext4@lfdr.de>; Tue,  6 Oct 2020 02:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725931AbgJFAcY (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 5 Oct 2020 20:32:24 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:51279 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbgJFAcY (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 5 Oct 2020 20:32:24 -0400
X-Originating-IP: 50.39.163.217
Received: from localhost (50-39-163-217.bvtn.or.frontiernet.net [50.39.163.217])
        (Authenticated sender: josh@joshtriplett.org)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id EFCD620006;
        Tue,  6 Oct 2020 00:32:18 +0000 (UTC)
Date:   Mon, 5 Oct 2020 17:32:16 -0700
From:   Josh Triplett <josh@joshtriplett.org>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-ext4@vger.kernel.org
Subject: Re: ext4 regression in v5.9-rc2 from e7bfb5c9bb3d on ro fs with
 overlapped bitmaps
Message-ID: <20201006003216.GB6553@localhost>
References: <CAHk-=wj-H5BYCU_kKiOK=B9sN3BtRzL4pnne2AJPyf54nQ+d=w@mail.gmail.com>
 <20201005081454.GA493107@localhost>
 <20201005173639.GA2311765@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201005173639.GA2311765@magnolia>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Oct 05, 2020 at 10:36:39AM -0700, Darrick J. Wong wrote:
> On Mon, Oct 05, 2020 at 01:14:54AM -0700, Josh Triplett wrote:
> > Ran into an ext4 regression when testing upgrades to 5.9-rc kernels:
> > 
> > Commit e7bfb5c9bb3d ("ext4: handle add_system_zone() failure in
> > ext4_setup_system_zone()") breaks mounting of read-only ext4 filesystems
> > with intentionally overlapping bitmap blocks.
> > 
> > On an always-read-only filesystem explicitly marked with
> > EXT4_FEATURE_RO_COMPAT_SHARED_BLOCKS, prior to that commit, it's safe to
> > point all the block and inode bitmaps to a single block
> 
> LOL, WHAT?
> 
> I didn't know shared blocks applied to fs metadata.  I thought that
> "shared" only applied to file extent maps being able to share physical
> blocks.

The flag isn't documented very well yet, but since it specifically
forces the filesystem to always be mounted read-only, the bitmaps really
shouldn't matter at all. (In an ideal world, a permanently read-only
filesystem should be able to omit all the bitmaps entirely. Pointing
them all to a single disk block is the next best thing.)

> Could /somebody/ please document the ondisk format changes that are
> associated with this feature?

I pretty much had to sort it out by looking at a combination of
e2fsprogs and the kernel, and a lot of experimentation, until I ended up
with something that the kernel was completely happy with without a
single complaint.

I'd be happy to write up a summary of the format.

I'd still really like to see this patch applied for 5.9, to avoid having
filesystems that an old kernel can mount but a new one can't. This still
seems like a regression to me.

> > of all 1s,
> > because a read-only filesystem will never allocate or free any blocks or
> > inodes.
> 
> All 1s?  So the inode bitmap says that every inode table slot is in use,
> even if the inode record itself says it isn't?

Yes.

> What does e2fsck -n
> think about that kind of metadata inconsistency?

If you set up the rest of the metadata consistently with it (for
instance, 0 free blocks and 0 free inodes), you'll only get a single
complaint, from the e2fsck equivalent of block_validity. See
https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=956509 for details on
that; with that fixed, e2fsck wouldn't complain at all. The kernel,
prior to 5.9-rc2, doesn't have a single complaint, whether at mount,
unmount, or read of every file and directory on the filesystem.

The errors you got in your e2fsck run came because you just overrode the
bitmaps, but didn't make the rest of the metadata consistent with that.
I can provide a sample filesystem if that would help.

- Josh
