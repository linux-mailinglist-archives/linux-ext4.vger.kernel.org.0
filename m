Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5CC035798B
	for <lists+linux-ext4@lfdr.de>; Thu,  8 Apr 2021 03:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbhDHB1D (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 7 Apr 2021 21:27:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:49506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229497AbhDHB1C (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 7 Apr 2021 21:27:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 573BF610F9;
        Thu,  8 Apr 2021 01:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617845212;
        bh=fNd28s1Qqp1usArIJT7goTRTd850zBGBfsGsPKVaEZM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M8b+hOSRR1vsyT7xK/6tH98oeJQkOIZAqMELpdrwaO2gxQqKEV64+ITpcHnHLgpYY
         LQq8piUqLS1iSNFh0wOjiYi9kbjLZS9/D78izBtD0gaforhWa2w7+T7V4euqRqRnlT
         yQWUUqWLJ8dsduJl+ApWp5fMtlDl/475tW/HwYbyqeOrdN+z4AAy/OLXjFITkUfF1D
         JdEclNsRHgLyOvHi9HM8XvrQDjIbzEhYCuL77p8lHVW6GQQftlK3WfuXr4WCQpRszK
         pAYGq2K+F1Yi4C/zHs/4C52tZFRDSeej9LhDFx/GfKLatmQHKS78oOt4iD4SW946dN
         ApMqEwhE6wDew==
Date:   Wed, 7 Apr 2021 18:26:51 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Leah Rumancik <leah.rumancik@gmail.com>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH v2 2/2] ext4: add ioctl FS_IOC_CHKPT_JRNL
Message-ID: <20210408012651.GH22091@magnolia>
References: <20210407154202.1527941-1-leah.rumancik@gmail.com>
 <20210407154202.1527941-3-leah.rumancik@gmail.com>
 <20210407183547.GG22091@magnolia>
 <20210407211500.GG1990290@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210407211500.GG1990290@dread.disaster.area>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Apr 08, 2021 at 07:15:00AM +1000, Dave Chinner wrote:
> On Wed, Apr 07, 2021 at 11:35:47AM -0700, Darrick J. Wong wrote:
> > On Wed, Apr 07, 2021 at 03:42:02PM +0000, Leah Rumancik wrote:
> > > ioctl FS_IOC_CHKPT_JRNL checkpoints and flushes the journal. With the
> > > CHKPT_JRNL_DISCARD flag set, the journal blocks are also discarded.
> > > With the filename wipeout patch, Ext4 guarantees that all data will be
> > > discarded on deletion. This ioctl allows for periodically discarding
> > > journal contents too.
> > 
> > This needs a documentation update to cover what this new userspace ABI
> > does, and probably linux-api and linux-fsdevel should be cc'd.
> 
> You need to describe the semantics that you are exporting to
> userspace. Exactly what does a "journal checkpoint" mean from the
> point of view of user visible metadata and data integrity?

To be clear, my interests are /not/ the same as Leah's here -- I want to
use this "checkpoint" call to provide a way for grub to know that it
will be able to find boot files without needing to recover the log.

For the grub use case, the user-visible behaviors that are required are:

 1. All dirty file data in memory are flushed;
 2. All committed metadata updates are forced to the ondisk log;
 3. All log contents have been written into the filesystem.

(Note confusing terminology here: in my head, #2 means checkpointing the
ondisk log, whereas #3 means checkpointing the filesystem itself; and
"FS_IOC_CHECKPOINT" means checkpointing the whole filesystem, not just
the log.)

((For Leah's use case, I think you'd add "4. If the DISCARD flag is set,
the journal storage will be zeroed." or something like that...))

> How is it different to running fsync() on a directory, syncfs() or
> freeze on a filesystem, or any of the other methods we already have
> for guaranteeing completed changes are committed to stable storage?

This differs from fsync and syncfs in that it's sufficient to checkpoint
the log (#2), whereas this new call would require also checkpointing the
filesystem (#3).

It's different from FIFREEZE in that it's not necessary to freeze
ongoing modifications from running programs.  The guarantees only apply
to changes made before the call.

A second difference is that if we made grub initiate a FIFREEZE/FITHAW
cycle, the FITHAW call will unfreeze the filesystem even if another
racing program had frozen the fs after grub wrote its files.

> All of these methods imply a journal checkpoint of some kind is done
> in ext4, so why do we need a specific ioctl to do this?

For XFS, we don't have any kind of system call that will checkpoint the
fs without the unwanted behaviors of FIFREEZE and FITHAW.  AFAICT
there's no explicit way to force a fs checkpoint in ext4 aside from
contorted insanity with data=journal files and bmap().  Weird things
like NOVA would have to figure out a way to checkpoint the whole fs
(flush all the journals?).

btrfs can probably get away with flushing the disk cache since it has
COW btrees for metadata (fsync log notwithstanding); and I'd imagine
stupid things like FAT would just return EOPNOTSUPP.

To solve my stupid grub problem, this could easily be:

	ret = syncfs2(fd, SYNCFS_CHECKPOINT_FS);

Though you'd have to add that new syncfs2 syscall.  Probably a good way
to get yourself invited to LSFMM. ;)

Anyway, I'll let Leah lead the secure deletion aspects of this
discussion.

--D

> But, really, if this is for secure deletion, then why isn't
> "fsync(dirfd)" sufficient to force the unlinks into the journal and
> onto stable storage? Why does this functionality need some special
> new CAP_SYS_ADMIN only ioctl to checkpoint the journal when, by
> definition, fsync() should already be doing that?  Indeed, users can't
> actually use this new ioctl for secure deletion because it is root
> only, so how do users and their applications actually ensure that
> secure deletion of their files has actually occurred?
> 
> I'm also curious as to what "journal checkpoint" means for
> filesystems that don't have journals? Or that have multiple and/or
> partial state journals (e.g. iper-inode journals in NOVA, fsync
> journals in brtfs, etc)? What does it mean for filesystems that use
> COW instead of journals?
> 
> > > Also, add journal discard (if discard supported) during journal load
> > > after recovery. This provides a potential solution to
> > > https://lore.kernel.org/linux-ext4/YDZoaacIYStFQT8g@mit.edu/ for
> > > disks that support discard. After a successful journal recovery, e2fsck
> > > can call this ioctl to discard the journal as well.
> 
> If you need discard after recovery for secure remove, then you also
> really need discard on every extent being freed, too.  Which then
> implies that the -o discard mount option needs to be used in
> conjunction with this functionality. Perhaps, then, journal discard
> at mount should be tied in to the -o discard mount option, and then
> the need for an ioctl to trigger this goes away completely.
> 
> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
