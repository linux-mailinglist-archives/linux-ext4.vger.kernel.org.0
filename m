Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB7D1357B73
	for <lists+linux-ext4@lfdr.de>; Thu,  8 Apr 2021 06:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbhDHEnm (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 8 Apr 2021 00:43:42 -0400
Received: from mail106.syd.optusnet.com.au ([211.29.132.42]:54679 "EHLO
        mail106.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229512AbhDHEnl (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 8 Apr 2021 00:43:41 -0400
Received: from dread.disaster.area (pa49-181-239-12.pa.nsw.optusnet.com.au [49.181.239.12])
        by mail106.syd.optusnet.com.au (Postfix) with ESMTPS id A24865EC999;
        Thu,  8 Apr 2021 14:43:27 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1lUMVr-00FQkU-2P; Thu, 08 Apr 2021 14:43:27 +1000
Date:   Thu, 8 Apr 2021 14:43:27 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Leah Rumancik <leah.rumancik@gmail.com>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH v2 2/2] ext4: add ioctl FS_IOC_CHKPT_JRNL
Message-ID: <20210408044327.GJ1990290@dread.disaster.area>
References: <20210407154202.1527941-1-leah.rumancik@gmail.com>
 <20210407154202.1527941-3-leah.rumancik@gmail.com>
 <20210407183547.GG22091@magnolia>
 <20210407211500.GG1990290@dread.disaster.area>
 <20210408012651.GH22091@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210408012651.GH22091@magnolia>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=Tu+Yewfh c=1 sm=1 tr=0 cx=a_idp_f
        a=gO82wUwQTSpaJfP49aMSow==:117 a=gO82wUwQTSpaJfP49aMSow==:17
        a=kj9zAlcOel0A:10 a=3YhXtTcJ-WEA:10 a=7-415B0cAAAA:8
        a=jUQIXtlEuOsnFmh6BwwA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Apr 07, 2021 at 06:26:51PM -0700, Darrick J. Wong wrote:
> On Thu, Apr 08, 2021 at 07:15:00AM +1000, Dave Chinner wrote:
> > On Wed, Apr 07, 2021 at 11:35:47AM -0700, Darrick J. Wong wrote:
> > > On Wed, Apr 07, 2021 at 03:42:02PM +0000, Leah Rumancik wrote:
> > > > ioctl FS_IOC_CHKPT_JRNL checkpoints and flushes the journal. With the
> > > > CHKPT_JRNL_DISCARD flag set, the journal blocks are also discarded.
> > > > With the filename wipeout patch, Ext4 guarantees that all data will be
> > > > discarded on deletion. This ioctl allows for periodically discarding
> > > > journal contents too.
> > > 
> > > This needs a documentation update to cover what this new userspace ABI
> > > does, and probably linux-api and linux-fsdevel should be cc'd.
> > 
> > You need to describe the semantics that you are exporting to
> > userspace. Exactly what does a "journal checkpoint" mean from the
> > point of view of user visible metadata and data integrity?
> 
> To be clear, my interests are /not/ the same as Leah's here -- I want to
> use this "checkpoint" call to provide a way for grub to know that it
> will be able to find boot files without needing to recover the log.
> 
> For the grub use case, the user-visible behaviors that are required are:
> 
>  1. All dirty file data in memory are flushed;
>  2. All committed metadata updates are forced to the ondisk log;
>  3. All log contents have been written into the filesystem.
> 
> (Note confusing terminology here: in my head, #2 means checkpointing the
> ondisk log, whereas #3 means checkpointing the filesystem itself; and
> "FS_IOC_CHECKPOINT" means checkpointing the whole filesystem, not just
> the log.)

So, yeah, you just renamed the ioctl because you are clearly not just
talking about a journal checkpoint. A journal checkpoint is what
XFS does when it pushes the CIL to disk (i.e. #2). Quiescing the log
is what we call #3 - basically bringing it to an empty, idle state.

Which makes me even more concerned about defining the behaviour and
semantics needed before we even talk about the API that would be
used.

> > All of these methods imply a journal checkpoint of some kind is done
> > in ext4, so why do we need a specific ioctl to do this?
> 
> For XFS, we don't have any kind of system call that will checkpoint the
> fs without the unwanted behaviors of FIFREEZE and FITHAW.  AFAICT
> there's no explicit way to force a fs checkpoint in ext4 aside from
> contorted insanity with data=journal files and bmap().  Weird things
> like NOVA would have to figure out a way to checkpoint the whole fs
> (flush all the journals?).

So, yeah, you're not talking about a journal checkpoint. You're
describing a completely different set of requirements.... :/

> btrfs can probably get away with flushing the disk cache since it has
> COW btrees for metadata (fsync log notwithstanding); and I'd imagine
> stupid things like FAT would just return EOPNOTSUPP.
> 
> To solve my stupid grub problem, this could easily be:
> 
> 	ret = syncfs2(fd, SYNCFS_CHECKPOINT_FS);

Sure, but is that the same thing that Leah needs? Checkpoints don't
imply discards (let alone journal discards) in any way, and adding
(optional) discard support for random parts of filesysetms to
syncfs() semantics doesn't seem like a very good fit...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
