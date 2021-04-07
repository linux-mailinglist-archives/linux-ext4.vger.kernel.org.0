Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FF353576E2
	for <lists+linux-ext4@lfdr.de>; Wed,  7 Apr 2021 23:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233440AbhDGVeT (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 7 Apr 2021 17:34:19 -0400
Received: from mail110.syd.optusnet.com.au ([211.29.132.97]:42700 "EHLO
        mail110.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229734AbhDGVeT (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 7 Apr 2021 17:34:19 -0400
X-Greylist: delayed 1145 seconds by postgrey-1.27 at vger.kernel.org; Wed, 07 Apr 2021 17:34:19 EDT
Received: from dread.disaster.area (pa49-181-239-12.pa.nsw.optusnet.com.au [49.181.239.12])
        by mail110.syd.optusnet.com.au (Postfix) with ESMTPS id E8C5A107D20;
        Thu,  8 Apr 2021 07:15:01 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1lUFVs-00Ewzg-JA; Thu, 08 Apr 2021 07:15:00 +1000
Date:   Thu, 8 Apr 2021 07:15:00 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Leah Rumancik <leah.rumancik@gmail.com>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH v2 2/2] ext4: add ioctl FS_IOC_CHKPT_JRNL
Message-ID: <20210407211500.GG1990290@dread.disaster.area>
References: <20210407154202.1527941-1-leah.rumancik@gmail.com>
 <20210407154202.1527941-3-leah.rumancik@gmail.com>
 <20210407183547.GG22091@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210407183547.GG22091@magnolia>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=F8MpiZpN c=1 sm=1 tr=0 cx=a_idp_f
        a=gO82wUwQTSpaJfP49aMSow==:117 a=gO82wUwQTSpaJfP49aMSow==:17
        a=kj9zAlcOel0A:10 a=3YhXtTcJ-WEA:10 a=VwQbUJbxAAAA:8 a=7-415B0cAAAA:8
        a=iqqe2MBXZ9lWna0kc54A:9 a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22
        a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Apr 07, 2021 at 11:35:47AM -0700, Darrick J. Wong wrote:
> On Wed, Apr 07, 2021 at 03:42:02PM +0000, Leah Rumancik wrote:
> > ioctl FS_IOC_CHKPT_JRNL checkpoints and flushes the journal. With the
> > CHKPT_JRNL_DISCARD flag set, the journal blocks are also discarded.
> > With the filename wipeout patch, Ext4 guarantees that all data will be
> > discarded on deletion. This ioctl allows for periodically discarding
> > journal contents too.
> 
> This needs a documentation update to cover what this new userspace ABI
> does, and probably linux-api and linux-fsdevel should be cc'd.

You need to describe the semantics that you are exporting to
userspace. Exactly what does a "journal checkpoint" mean from the
point of view of user visible metadata and data integrity? How is it
different to running fsync() on a directory, syncfs() or freeze on a
filesystem, or any of the other methods we already have for
guaranteeing completed changes are committed to stable storage? All
of these methods imply a journal checkpoint of some kind is done in
ext4, so why do we need a specific ioctl to do this?

But, really, if this is for secure deletion, then why isn't
"fsync(dirfd)" sufficient to force the unlinks into the journal and
onto stable storage? Why does this functionality need some special
new CAP_SYS_ADMIN only ioctl to checkpoint the journal when, by
definition, fsync() should already be doing that?  Indeed, users can't
actually use this new ioctl for secure deletion because it is root
only, so how do users and their applications actually ensure that
secure deletion of their files has actually occurred?

I'm also curious as to what "journal checkpoint" means for
filesystems that don't have journals? Or that have multiple and/or
partial state journals (e.g. iper-inode journals in NOVA, fsync
journals in brtfs, etc)? What does it mean for filesystems that use
COW instead of journals?

> > Also, add journal discard (if discard supported) during journal load
> > after recovery. This provides a potential solution to
> > https://lore.kernel.org/linux-ext4/YDZoaacIYStFQT8g@mit.edu/ for
> > disks that support discard. After a successful journal recovery, e2fsck
> > can call this ioctl to discard the journal as well.

If you need discard after recovery for secure remove, then you also
really need discard on every extent being freed, too.  Which then
implies that the -o discard mount option needs to be used in
conjunction with this functionality. Perhaps, then, journal discard
at mount should be tied in to the -o discard mount option, and then
the need for an ioctl to trigger this goes away completely.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
