Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D430647833D
	for <lists+linux-ext4@lfdr.de>; Fri, 17 Dec 2021 03:39:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231342AbhLQCjU (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 16 Dec 2021 21:39:20 -0500
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:60381 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229471AbhLQCjU (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 16 Dec 2021 21:39:20 -0500
Received: from dread.disaster.area (pa49-181-243-119.pa.nsw.optusnet.com.au [49.181.243.119])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 9AA4610A49D2;
        Fri, 17 Dec 2021 13:39:15 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1my39N-003zki-JJ; Fri, 17 Dec 2021 13:39:13 +1100
Date:   Fri, 17 Dec 2021 13:39:13 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     Roman Anufriev <dotdot@yandex-team.ru>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        linux-ext4 <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>,
        wshilong@ddn.com, Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH] ext4: compare inode's i_projid with EXT4_DEF_PROJID
 rather than check EXT4_INODE_PROJINHERIT flag
Message-ID: <20211217023913.GA945095@dread.disaster.area>
References: <1638883122-8953-1-git-send-email-dotdot@yandex-team.ru>
 <alpine.OSX.2.23.453.2112071702150.70498@dotdot-osx>
 <Ya+3L3gBFCeWZki7@mit.edu>
 <alpine.OSX.2.23.453.2112102232440.94559@dotdot-osx>
 <20211214050636.GE279368@dread.disaster.area>
 <A5DD4B7A-A3AE-4A00-943A-A35D98204764@dilger.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A5DD4B7A-A3AE-4A00-943A-A35D98204764@dilger.ca>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=VuxAv86n c=1 sm=1 tr=0 ts=61bbf856
        a=BEa52nrBdFykVEm6RU8P4g==:117 a=BEa52nrBdFykVEm6RU8P4g==:17
        a=kj9zAlcOel0A:10 a=IOMw9HtfNCkA:10 a=7-415B0cAAAA:8 a=eJfxgxciAAAA:8
        a=lob30jc7ayrNxV22hpgA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
        a=xM9caqqi1sUkTy8OJ5Uh:22
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Dec 16, 2021 at 05:17:28PM -0700, Andreas Dilger wrote:
> On Dec 13, 2021, at 10:06 PM, Dave Chinner <david@fromorbit.com> wrote:
> > On Fri, Dec 10, 2021 at 10:55:10PM +0300, Roman Anufriev wrote:
> >> 
> >> On Tue, 7 Dec 2021, Theodore Y. Ts'o wrote:
> >> 
> >>> On Tue, Dec 07, 2021 at 05:05:19PM +0300, Roman Anufriev wrote:
> >>>>> Commit 7ddf79a10395 ("ext4: only set project inherit bit for directory")
> >>>>> removes EXT4_INODE_PROJINHERIT flag from regular files. This makes
> >>>>> ext4_statfs() output incorrect (function does not apply quota limits
> >>>>> on used/available space, etc) when called on dentry of regular file
> >>>>> with project quota enabled.
> >>> 
> >>> Under what circumstance is userspace trying to call statfs on a file
> >>> descriptor?
> >>> 
> >>> Removing the test for EXT4_INODE_PROJINHERIT will cause
> >>> incorrect/misleading results being returned in the case where we have
> >>> a directory where a directory hierarchy is using project id's, but
> >>> which is *not* using PROJINHERIT.
> >> 
> >> I'm not sure I quite understood what will be wrong in that case, because
> >> as Dave mentioned:
> >> 
> >>> PROJINHERIT just indicates the default projid that an inode is
> >>> created with; ...
> > 
> > Directory inodes can have a project ID set without PROJINHERIT, it
> > just means they are accounted to that specific project and have no
> > special behaviour w.r.t. newly created children in the directory.
> > i.e. without PROJINHERIT, all children will be created with a
> > proj ID of zero rather than the projid of the parent directory.
> > 
> > i.e. I can do `xfs_io -c "chproj -R 42" /mnt/test` and it will set
> > all filesystem and directories to have a projid = 42, but
> > PROJINHERIT is not set on any directory. The tree gets accounted to
> > project 42, but it isn't a directory tree quota - it's just a user
> > controlled aggregation of random files associated with the same
> > project ID.
> > 
> > Hence the statfs behaviour of "report project quota limits for
> > directory tree" should only be triggered if PROJINHERIT is set on
> > the directory, because that's the only viable indicator that
> > directory tree quotas *may* be in use on the filesystem.
> 
> Sure, I think the question is if statfs() is called on a regular
> file in a parent directory with PROJINHERIT set (which is easily
> checked) should it return the project limits in the same way as
> if statfs() is called on the directory itself?

It's more complex than that. If the file and parent projid match,
then maybe it is a directory tree quota, but if they differ then
what?

If the inode has multiple parents (i.e. hard linked) and only some
of them PROJINHERIT and/or matching projids, then what?

IOWs, we're way off into the heuristics realm of guessing what the
user has configured project IDs for and what behaviour they might
want. And given the flexibility of of project quotas, we're going to
lose that guessing game if we start to play it.

However, this guessing game is largely irrelevant because we can't
change the existing user visible behaviour without risking breakage
of existing systems.  The user visible behaviour was defined in the
first commits that introduced directory tree emulation with XFS
project quotas 15 years ago:

commit 932f2c323196c214e645d5a572a1d7b562c0f93f
Author: Nathan Scott <nathans@sgi.com>
Date:   Fri Jun 9 15:29:58 2006 +1000

    [XFS] statvfs component of directory/project quota support, code
    originally by Glen.

    SGI-PV: 932952
    SGI-Modid: xfs-linux-melb:xfs-kern:26105a

    Signed-off-by: Nathan Scott <nathans@sgi.com>

and so it's highly likely that in those 15 years someone now relies
on the behaviour we defined way back then. 

> It seems inconsistent for that statfs("/home/adilger/file") returns
> full-filesystem information, but statfs("/home/adilger") and
> statfs("/home/adilger/dir") would return project information, if
> PROJINHERIT are set on "adilger/" and "dir/".  It kind of ruins
> the "tree" aspect, especially for processes that are in a container
> that has limits on the subdirectory it is mounting.

Yup, but as I keep saying, project quotas are *not* directory tree
quotas. What might "ruin" the tree aspect for you may be the feature
that "makes" it for someone else....

In reality, we had to walk a fine line between the unrestricted
freedom project quotas give users with and the bare minimum
restrictions needed to allow directory tree based propagation and
reporting of space usage that was required at the time.  So while
the behaviour might be less than optimal for specific use cases
we have now, the horse bolted a long, long time ago....


Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
