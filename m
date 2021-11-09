Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 269C944A5E8
	for <lists+linux-ext4@lfdr.de>; Tue,  9 Nov 2021 05:50:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242859AbhKIEw7 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 8 Nov 2021 23:52:59 -0500
Received: from mail109.syd.optusnet.com.au ([211.29.132.80]:49766 "EHLO
        mail109.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229832AbhKIEw6 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 8 Nov 2021 23:52:58 -0500
Received: from dread.disaster.area (pa49-195-103-97.pa.nsw.optusnet.com.au [49.195.103.97])
        by mail109.syd.optusnet.com.au (Postfix) with ESMTPS id 9E3CCA0C45;
        Tue,  9 Nov 2021 15:50:11 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1mkJ5G-006ce5-GH; Tue, 09 Nov 2021 15:50:10 +1100
Date:   Tue, 9 Nov 2021 15:50:10 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Zhongwei Cai <sunrise_l@sjtu.edu.cn>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, mingkaidong@gmail.com
Subject: Re: [PATCH] ext4: remove unnecessary ext4_inode_datasync_dirty in
 read path
Message-ID: <20211109045010.GG418105@dread.disaster.area>
References: <20211102024258.210439-1-sunrise_l@sjtu.edu.cn>
 <20211103002843.GC418105@dread.disaster.area>
 <ffb199dc-f7ae-ba03-db57-bf7acc3d0636@sjtu.edu.cn>
 <20211104232226.GD418105@dread.disaster.area>
 <01e6abf4-3ae5-ecab-3b7f-876c8a3fcbb4@sjtu.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01e6abf4-3ae5-ecab-3b7f-876c8a3fcbb4@sjtu.edu.cn>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=epq8cqlX c=1 sm=1 tr=0 ts=6189fe04
        a=fP9RlOTWD4uZJjPSFnn6Ew==:117 a=fP9RlOTWD4uZJjPSFnn6Ew==:17
        a=kj9zAlcOel0A:10 a=vIxV3rELxO4A:10 a=7-415B0cAAAA:8
        a=6VncYBqVuDewgahjr6AA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Nov 05, 2021 at 01:28:10PM +0800, Zhongwei Cai wrote:
> 
> 
> On 11/5/21 7:22 AM, Dave Chinner wrote:
> > 
> > No. Some filesystems don't track inode metadata dirty status using
> > the VFS inode; instead they track it more efficiently in internal
> > inode and/or journal based structures. Hence the only way to get
> > "inode needs journal flush for data stability" information to
> > generic IO code is to have a specific per-IO mapping flag for it.
> > 
> 
> Could we add IOMAP_REPORT_DIRTY flag in the flags field of
> struct iomap_iter to indicate whether the IOMAP_F_DIRTY flag
> needs to be set or not?

You can try. It might turn out OK, but you're also going to have to
modify all the iomap code that current needs IOMAP_F_DIRTY to first
set that flag, then change all the code that currently sets
IOMAP_F_DIRTY to look at IOMAP_REPORT_DIRTY. i.e you now have to
change iomap, ext4 and XFS to do this.

> Currently the IOMAP_F_DIRTY flag is only checked in
> iomap_swapfile_activate(), dax_iomap_fault() and iomap_dio_rw()
> (To be more specific, only the write path in dax_iomap_fault() and
> iomap_dio_rw()). So it would be unnecessary to set the IOMAP_F_DIRTY
> flag in dax_iomap_rw() called in the previous tests.

I think you're trying to optimise the wrong thing - the API is not
the problem, the problem is that the journal->j_state_lock is
contended and the ext4 dirty inode check needs to take it. Fix the
dirty check not to need the journal state lock and the ext4 problem
goes away and there is no need to change the iomap infrastructure.

> Other file systems that set the IOMAP_F_DIRTY flag efficiently
> could ignore the IOMAP_REPORT_DIRTY flag.

No, that's just bad API design. If we are adding IOMAP_REPORT_DIRTY
then the iomap infrastructure should only use that control flag when
it needs to know if the inode is dirty. At this point, it really
becomes mandatory for all filesystems using iomap to support it
because the absence of IOMAP_F_DIRTY because a filesystem doesn't
support it is not the same as "filesystem didn't set it because the
inode is clean".

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
