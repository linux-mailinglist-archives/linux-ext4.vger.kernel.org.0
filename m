Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA2F35909C
	for <lists+linux-ext4@lfdr.de>; Fri,  9 Apr 2021 01:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232793AbhDHXtX (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 8 Apr 2021 19:49:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:33970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232426AbhDHXtX (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 8 Apr 2021 19:49:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 226FB610F8;
        Thu,  8 Apr 2021 23:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617925751;
        bh=v2gneGpqlXr5igRRyItDUvevsFRmwjUjT95uB3YufvU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IM/nysNCKThO4Je5LgjQWGAmtlk5AGZv0z8wXkfQSQ2ApeNcrzNWKKqXdHPdrKsVC
         WF6zlYYmxoUUS+3VxVVWm1/3GWNm7leHZz1KiZWkyorhPsVy/OZrxBpRc/ypxZjCin
         DE7LTD8hJs+etVg/xHsov5K5uMeBTbcqsUiQDdb7F6dJPxPjREQTzYdTzcIoD7pd/V
         6irt769CI6mUnhYu/x5HbtvzJml9VcykZwzy3ohUK0oC60OEshDsfTrDDyyXdJeTN6
         yfyx68AiSQ/FM2xhmJooMDi/AYRWFbhJ2a6VshXWmzNrKkzqiksZqtEalVa6RoaEur
         BMhj2lDkcVl2w==
Date:   Thu, 8 Apr 2021 16:49:09 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Leah Rumancik <leah.rumancik@gmail.com>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH v2 2/2] ext4: add ioctl FS_IOC_CHKPT_JRNL
Message-ID: <20210408234909.GI22091@magnolia>
References: <20210407154202.1527941-1-leah.rumancik@gmail.com>
 <20210407154202.1527941-3-leah.rumancik@gmail.com>
 <20210407183547.GG22091@magnolia>
 <20210407211500.GG1990290@dread.disaster.area>
 <20210408012651.GH22091@magnolia>
 <20210408044327.GJ1990290@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210408044327.GJ1990290@dread.disaster.area>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Apr 08, 2021 at 02:43:27PM +1000, Dave Chinner wrote:
> On Wed, Apr 07, 2021 at 06:26:51PM -0700, Darrick J. Wong wrote:
> > On Thu, Apr 08, 2021 at 07:15:00AM +1000, Dave Chinner wrote:
> > > On Wed, Apr 07, 2021 at 11:35:47AM -0700, Darrick J. Wong wrote:
> > > > On Wed, Apr 07, 2021 at 03:42:02PM +0000, Leah Rumancik wrote:
> > > > > ioctl FS_IOC_CHKPT_JRNL checkpoints and flushes the journal. With the
> > > > > CHKPT_JRNL_DISCARD flag set, the journal blocks are also discarded.
> > > > > With the filename wipeout patch, Ext4 guarantees that all data will be
> > > > > discarded on deletion. This ioctl allows for periodically discarding
> > > > > journal contents too.
> > > > 
> > > > This needs a documentation update to cover what this new userspace ABI
> > > > does, and probably linux-api and linux-fsdevel should be cc'd.
> > > 
> > > You need to describe the semantics that you are exporting to
> > > userspace. Exactly what does a "journal checkpoint" mean from the
> > > point of view of user visible metadata and data integrity?
> > 
> > To be clear, my interests are /not/ the same as Leah's here -- I want to
> > use this "checkpoint" call to provide a way for grub to know that it
> > will be able to find boot files without needing to recover the log.
> > 
> > For the grub use case, the user-visible behaviors that are required are:
> > 
> >  1. All dirty file data in memory are flushed;
> >  2. All committed metadata updates are forced to the ondisk log;
> >  3. All log contents have been written into the filesystem.
> > 
> > (Note confusing terminology here: in my head, #2 means checkpointing the
> > ondisk log, whereas #3 means checkpointing the filesystem itself; and
> > "FS_IOC_CHECKPOINT" means checkpointing the whole filesystem, not just
> > the log.)
> 
> So, yeah, you just renamed the ioctl because you are clearly not just
> talking about a journal checkpoint. A journal checkpoint is what
> XFS does when it pushes the CIL to disk (i.e. #2). Quiescing the log
> is what we call #3 - basically bringing it to an empty, idle state.
> 
> Which makes me even more concerned about defining the behaviour and
> semantics needed before we even talk about the API that would be
> used.

Ok, let's draft a manpage.  Here's my mockup of a manpage for the ioctl,
though again, I don't have a strong preference between this and a
syncfs2 call.

NAME

    ioctl_fs_ioc_checkpoint - Commit all filesystem changes to disk

SYNOPSYS

    int ioctl(int fd, FS_IOC_CHECKPOINT, __u64 *flags);

DESCRIPTION

Ensure that all previous changes to the filesystem backing the given
file descriptor are persisted to disk in the same form that they would
be if the filesystem were to be unmounted cleanly.  Changes made during
or after this call are not required to be persisted.

The motivation of this ioctl are twofold -- first, to provide a way for
application software to prepare a mounted filesystem for future
read-only access by primordial external applications (e.g. bootloaders)
that do not know about crash recovery.  The second motivation is to
provide a way to clean out ephemeral areas of the filesystem involved in
crash recovery for security cleaning purposes.

FLAGS

The flags argument should point to a __u64 containing any combination of
the following flags:

    FS_IOC_CHECKPOINT_DISCARD_STAGING
	Issue a discard command to erase all areas of the filesystem
	that are involved in staging and committing updates.

ERRORS

Error codes can be one of, but are not limited to, the following:

	EFSCORRUPTED	Filesystem corruption was detected.
	EINVAL		One of the arguments is not valid.
	ENOMEM		Not enough memory.
	ENOSPC		Not enough space.
	<etc>

> 
> > > All of these methods imply a journal checkpoint of some kind is done
> > > in ext4, so why do we need a specific ioctl to do this?
> > 
> > For XFS, we don't have any kind of system call that will checkpoint the
> > fs without the unwanted behaviors of FIFREEZE and FITHAW.  AFAICT
> > there's no explicit way to force a fs checkpoint in ext4 aside from
> > contorted insanity with data=journal files and bmap().  Weird things
> > like NOVA would have to figure out a way to checkpoint the whole fs
> > (flush all the journals?).
> 
> So, yeah, you're not talking about a journal checkpoint. You're
> describing a completely different set of requirements.... :/

Yes, I'm talking about making sure that we've written changes back into
the whole fs, not just the journal.

> > btrfs can probably get away with flushing the disk cache since it has
> > COW btrees for metadata (fsync log notwithstanding); and I'd imagine
> > stupid things like FAT would just return EOPNOTSUPP.
> > 
> > To solve my stupid grub problem, this could easily be:
> > 
> > 	ret = syncfs2(fd, SYNCFS_CHECKPOINT_FS);
> 
> Sure, but is that the same thing that Leah needs? Checkpoints don't
> imply discards (let alone journal discards) in any way, and adding
> (optional) discard support for random parts of filesysetms to
> syncfs() semantics doesn't seem like a very good fit...

Yes.  I think Leah and Ted are more inclined to go with an ioctl
since this is something that's peculiar to journalled filesystems.

--D

> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
