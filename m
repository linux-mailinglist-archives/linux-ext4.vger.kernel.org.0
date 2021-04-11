Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 313EC35B765
	for <lists+linux-ext4@lfdr.de>; Mon, 12 Apr 2021 01:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235391AbhDKXNy (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 11 Apr 2021 19:13:54 -0400
Received: from mail109.syd.optusnet.com.au ([211.29.132.80]:55931 "EHLO
        mail109.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235005AbhDKXNy (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Sun, 11 Apr 2021 19:13:54 -0400
Received: from dread.disaster.area (pa49-181-239-12.pa.nsw.optusnet.com.au [49.181.239.12])
        by mail109.syd.optusnet.com.au (Postfix) with ESMTPS id 70D6E64784;
        Mon, 12 Apr 2021 09:13:33 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1lVjGl-003fEz-TP; Mon, 12 Apr 2021 09:13:31 +1000
Date:   Mon, 12 Apr 2021 09:13:31 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Leah Rumancik <leah.rumancik@gmail.com>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH v2 2/2] ext4: add ioctl FS_IOC_CHKPT_JRNL
Message-ID: <20210411231331.GN1990290@dread.disaster.area>
References: <20210407154202.1527941-1-leah.rumancik@gmail.com>
 <20210407154202.1527941-3-leah.rumancik@gmail.com>
 <20210407183547.GG22091@magnolia>
 <20210407211500.GG1990290@dread.disaster.area>
 <20210408012651.GH22091@magnolia>
 <20210408044327.GJ1990290@dread.disaster.area>
 <20210408234909.GI22091@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210408234909.GI22091@magnolia>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=YKPhNiOx c=1 sm=1 tr=0 cx=a_idp_f
        a=gO82wUwQTSpaJfP49aMSow==:117 a=gO82wUwQTSpaJfP49aMSow==:17
        a=kj9zAlcOel0A:10 a=3YhXtTcJ-WEA:10 a=7-415B0cAAAA:8
        a=16xvzstqn_QBtqwZM64A:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Apr 08, 2021 at 04:49:09PM -0700, Darrick J. Wong wrote:
> On Thu, Apr 08, 2021 at 02:43:27PM +1000, Dave Chinner wrote:
> > On Wed, Apr 07, 2021 at 06:26:51PM -0700, Darrick J. Wong wrote:
> > > On Thu, Apr 08, 2021 at 07:15:00AM +1000, Dave Chinner wrote:
> > > > On Wed, Apr 07, 2021 at 11:35:47AM -0700, Darrick J. Wong wrote:
> > > > > On Wed, Apr 07, 2021 at 03:42:02PM +0000, Leah Rumancik wrote:
> > > > > > ioctl FS_IOC_CHKPT_JRNL checkpoints and flushes the journal. With the
> > > > > > CHKPT_JRNL_DISCARD flag set, the journal blocks are also discarded.
> > > > > > With the filename wipeout patch, Ext4 guarantees that all data will be
> > > > > > discarded on deletion. This ioctl allows for periodically discarding
> > > > > > journal contents too.
> > > > > 
> > > > > This needs a documentation update to cover what this new userspace ABI
> > > > > does, and probably linux-api and linux-fsdevel should be cc'd.
> > > > 
> > > > You need to describe the semantics that you are exporting to
> > > > userspace. Exactly what does a "journal checkpoint" mean from the
> > > > point of view of user visible metadata and data integrity?
> > > 
> > > To be clear, my interests are /not/ the same as Leah's here -- I want to
> > > use this "checkpoint" call to provide a way for grub to know that it
> > > will be able to find boot files without needing to recover the log.
> > > 
> > > For the grub use case, the user-visible behaviors that are required are:
> > > 
> > >  1. All dirty file data in memory are flushed;
> > >  2. All committed metadata updates are forced to the ondisk log;
> > >  3. All log contents have been written into the filesystem.
> > > 
> > > (Note confusing terminology here: in my head, #2 means checkpointing the
> > > ondisk log, whereas #3 means checkpointing the filesystem itself; and
> > > "FS_IOC_CHECKPOINT" means checkpointing the whole filesystem, not just
> > > the log.)
> > 
> > So, yeah, you just renamed the ioctl because you are clearly not just
> > talking about a journal checkpoint. A journal checkpoint is what
> > XFS does when it pushes the CIL to disk (i.e. #2). Quiescing the log
> > is what we call #3 - basically bringing it to an empty, idle state.
> > 
> > Which makes me even more concerned about defining the behaviour and
> > semantics needed before we even talk about the API that would be
> > used.
> 
> Ok, let's draft a manpage.  Here's my mockup of a manpage for the ioctl,
> though again, I don't have a strong preference between this and a
> syncfs2 call.

I'd much prefer a syscall as we already have sync() and syncfs()
syscalls to do very similar things.

> NAME
> 
>     ioctl_fs_ioc_checkpoint - Commit all filesystem changes to disk
> 
> SYNOPSYS
> 
>     int ioctl(int fd, FS_IOC_CHECKPOINT, __u64 *flags);
> 
> DESCRIPTION
> 
> Ensure that all previous changes to the filesystem backing the given
> file descriptor are persisted to disk in the same form that they would
> be if the filesystem were to be unmounted cleanly.  Changes made during
> or after this call are not required to be persisted.

What does "unmounted cleanly" actually mean? An application writer
has no idea what this might mean for their application. Also, what
happens with a filesystem that "cleanly unmounts" but still requires
work to be done on/after the next mount? e.g. per-inode journals
might only get replayed when the inode is next referenced, not when
the filesystem mounts.

IMO, if this is going to force a fully consistent on-disk structure,
it needs to be described as providing similar guarantees as a
fsfreeze(8), but only for modifications completed before the
checkpoint is issued. i.e. a read-only mount on a read-only block
device will see all the changes completed before the checkpoint was
taken.

> The motivation of this ioctl are twofold -- first, to provide a way for
> application software to prepare a mounted filesystem for future
> read-only access by primordial external applications (e.g. bootloaders)
> that do not know about crash recovery.

Yup, moving on-disk state to an external read-only access compatible
state is the requirement, not "cleanly unmounted".

/me wonders how we plan to prevent modifications to files and
metadata writeback during the checkpointing process from resulting
in inconsistent read-only state on disk.

e.g. concurrent directory operations that are partialy written back
while the checkpoint is doing it's magic writing back active
metadata in the journal might result in directories being in
inconsistent state on disk, even though all the modifications that
happened prior to the checkpoint were captured.  It's problems like
these that make me ask how the "read-only access" guarantee is going
to work if we haven't actually frozen the filesystem to prevent
concurrent modifications leaking into the on-disk state and making
it inconsistent....

> The second motivation is to
> provide a way to clean out ephemeral areas of the filesystem involved in
> crash recovery for security cleaning purposes.
> 
> FLAGS
> 
> The flags argument should point to a __u64 containing any combination of
> the following flags:
> 
>     FS_IOC_CHECKPOINT_DISCARD_STAGING
> 	Issue a discard command to erase all areas of the filesystem
> 	that are involved in staging and committing updates.

I don't think this should be conflated with a filesystem checkpoint.
It is, fundamentally, a completely different operation, and one that
might be exceedingly complex and slow to implement. e.g. does this
definition imply deleting and discarding all the previous versions
of now unreferenced metadata in a COW filesytem? iWhat does it imply
for log structured filesystems? What about filesystems that can
discard journal/staging areas without checkpointing?

Sure, discarding the journal might require a full journal checkpoint
for filesystems like ext4, but I can see that we don't actually need
to implement "read-only" guarantees for XFS to implement a journal
discard.

For XFS, we'd just need to force the log, push AIL to the required
target LSN, force the log again to update the on-disk tail, take the
CIL checkpoint write lock to prevent the head moving forward, and
now discard all the unused journal between the head and tail. IOWs,
there is -no requirement- for the filesystem to be in a read-only
access compatible state to discard the unused parts of the
journal - we only need to hold off journal writes for a short period
of time to do the discards....

Hence I think "journal discard" needs to be a separate
syscall/ioctl, not get conflated with a filesystem checkpoint
operation.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
