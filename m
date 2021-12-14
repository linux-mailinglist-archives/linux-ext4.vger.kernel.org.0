Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3231473C4E
	for <lists+linux-ext4@lfdr.de>; Tue, 14 Dec 2021 06:06:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbhLNFGo (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 14 Dec 2021 00:06:44 -0500
Received: from mail108.syd.optusnet.com.au ([211.29.132.59]:47134 "EHLO
        mail108.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229757AbhLNFGn (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 14 Dec 2021 00:06:43 -0500
Received: from dread.disaster.area (pa49-181-243-119.pa.nsw.optusnet.com.au [49.181.243.119])
        by mail108.syd.optusnet.com.au (Postfix) with ESMTPS id 07F636097A1;
        Tue, 14 Dec 2021 16:06:38 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1mx01M-002qeB-Vb; Tue, 14 Dec 2021 16:06:37 +1100
Date:   Tue, 14 Dec 2021 16:06:36 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Roman Anufriev <dotdot@yandex-team.ru>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>, adilger@dilger.ca,
        linux-ext4@vger.kernel.org, jack@suse.cz, wshilong@ddn.com,
        dmtrmonakhov@yandex-team.ru, darrick.wong@oracle.com
Subject: Re: [PATCH] ext4: compare inode's i_projid with EXT4_DEF_PROJID
 rather than check EXT4_INODE_PROJINHERIT flag
Message-ID: <20211214050636.GE279368@dread.disaster.area>
References: <1638883122-8953-1-git-send-email-dotdot@yandex-team.ru>
 <alpine.OSX.2.23.453.2112071702150.70498@dotdot-osx>
 <Ya+3L3gBFCeWZki7@mit.edu>
 <alpine.OSX.2.23.453.2112102232440.94559@dotdot-osx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.OSX.2.23.453.2112102232440.94559@dotdot-osx>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=e9dl9Yl/ c=1 sm=1 tr=0 ts=61b82662
        a=BEa52nrBdFykVEm6RU8P4g==:117 a=BEa52nrBdFykVEm6RU8P4g==:17
        a=kj9zAlcOel0A:10 a=IOMw9HtfNCkA:10 a=7-415B0cAAAA:8
        a=dT9thTAEASw-ACgVbVwA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Dec 10, 2021 at 10:55:10PM +0300, Roman Anufriev wrote:
> 
> On Tue, 7 Dec 2021, Theodore Y. Ts'o wrote:
> 
> > On Tue, Dec 07, 2021 at 05:05:19PM +0300, Roman Anufriev wrote:
> > > > Commit 7ddf79a10395 ("ext4: only set project inherit bit for directory")
> > > > removes EXT4_INODE_PROJINHERIT flag from regular files. This makes
> > > > ext4_statfs() output incorrect (function does not apply quota limits
> > > > on used/available space, etc) when called on dentry of regular file
> > > > with project quota enabled.
> > 
> > Under what circumstance is userspace trying to call statfs on a file
> > descriptor?
> > 
> > Removing the test for EXT4_INODE_PROJINHERIT will cause
> > incorrect/misleading results being returned in the case where we have
> > a directory where a directory hierarchy is using project id's, but
> > which is *not* using PROJINHERIT.
> 
> I'm not sure I quite understood what will be wrong in that case, because
> as Dave mentioned:
> 
> > PROJINHERIT just indicates the default projid that an inode is
> > created with; ...

Directory inodes can have a project ID set without PROJINHERIT, it
just means they are accounted to that specific project and have no
special behaviour w.r.t. newly created children in the directory.
i.e. without PROJINHERIT, all children will be created with a
proj ID of zero rather than the projid of the parent directory.

i.e. I can do `xfs_io -c "chproj -R 42" /mnt/test` and it will set
all filesystem and directories to have a projid = 42, but
PROJINHERIT is not set on any directory. The tree gets accounted to
project 42, but it isn't a directory tree quota - it's just a user
controlled aggregation of random files associated with the same
project ID.

Hence the statfs behaviour of "report project quota limits for
directory tree" should only be triggered if PROJINHERIT is set on
the directory, because that's the only viable indicator that
directory tree quotas *may* be in use on the filesystem.

Cheers,

Dave.

-- 
Dave Chinner
david@fromorbit.com
