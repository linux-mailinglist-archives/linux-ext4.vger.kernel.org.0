Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4216A445C9B
	for <lists+linux-ext4@lfdr.de>; Fri,  5 Nov 2021 00:22:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbhKDXZI (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 4 Nov 2021 19:25:08 -0400
Received: from mail109.syd.optusnet.com.au ([211.29.132.80]:39187 "EHLO
        mail109.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229596AbhKDXZI (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 4 Nov 2021 19:25:08 -0400
Received: from dread.disaster.area (pa49-180-20-157.pa.nsw.optusnet.com.au [49.180.20.157])
        by mail109.syd.optusnet.com.au (Postfix) with ESMTPS id DA071FCC7D1;
        Fri,  5 Nov 2021 10:22:27 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1mim3u-004xLG-Tl; Fri, 05 Nov 2021 10:22:26 +1100
Date:   Fri, 5 Nov 2021 10:22:26 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Zhongwei Cai <sunrise_l@sjtu.edu.cn>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, mingkaidong@gmail.com
Subject: Re: [PATCH] ext4: remove unnecessary ext4_inode_datasync_dirty in
 read path
Message-ID: <20211104232226.GD418105@dread.disaster.area>
References: <20211102024258.210439-1-sunrise_l@sjtu.edu.cn>
 <20211103002843.GC418105@dread.disaster.area>
 <ffb199dc-f7ae-ba03-db57-bf7acc3d0636@sjtu.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ffb199dc-f7ae-ba03-db57-bf7acc3d0636@sjtu.edu.cn>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=e9dl9Yl/ c=1 sm=1 tr=0 ts=61846b34
        a=t5ERiztT/VoIE8AqcczM6g==:117 a=t5ERiztT/VoIE8AqcczM6g==:17
        a=kj9zAlcOel0A:10 a=vIxV3rELxO4A:10 a=7-415B0cAAAA:8
        a=oJhNe6YRw-8L-_QBslAA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Nov 04, 2021 at 05:29:59PM +0800, Zhongwei Cai wrote:
> On 11/3/21 8:28 AM, Dave Chinner wrote:
> > IOWs, we expect the IOMAP_F_DIRTY flag to be set on all types of
> > iomap mapping calls if the inode is dirty, not just IOMAP_WRITE
> > calls.
> 
> Thanks for correction!
> 
> > /*
> >  * Flags reported by the file system from iomap_begin:
> >  *
> >  * IOMAP_F_NEW indicates that the blocks have been newly allocated
> >  * and need zeroing for areas that no data is copied to.
> >  *
> >  * IOMAP_F_DIRTY indicates the inode has uncommitted metadata needed
> >  * to access written data and requires fdatasync to commit them to
> >  * persistent  storage. This needs to take into account metadata
> >  * changes that  *may* be made at IO completion, such as file size
> >  * updates from direct IO.
> >  *
> >  * IOMAP_F_SHARED indicates that the blocks are shared, and will
> >  * need to be unshared as part a write.
> >  *
> >  * IOMAP_F_MERGED indicates that the iomap contains the merge of
> >  * multiple block mappings.
> >  *
> >  * IOMAP_F_BUFFER_HEAD indicates that the file system requires the
> >  * use of buffer heads for this mapping.
> >  */
> 
> According to the comments in include/linux/iomap.h, it seems other
> flags in the iomap indicates the iomap-related status, but the
> IOMAP_F_DIRTY flag only indicates the status of the inode. So can
> I_DIRTY_INODE or I_DIRTY_PAGES flags in the inode replace it?

No. Some filesystems don't track inode metadata dirty status using
the VFS inode; instead they track it more efficiently in internal
inode and/or journal based structures. Hence the only way to get
"inode needs journal flush for data stability" information to
generic IO code is to have a specific per-IO mapping flag for it.

> And for ext4 at least we can do
> 
>    /*
>     * Writes that span EOF might trigger an I/O size update on completion,
>     * so consider them to be dirty for the purpose of O_DSYNC, even if
>     * there is no other metadata changes being made or are pending.
>     */
>     if (ext4_inode_datasync_dirty(inode) ||
> -       offset + length > i_size_read(inode))
> +       ((flags & IOMAP_WRITE) && offset + length > i_size_read(inode)))
>         iomap->flags |= IOMAP_F_DIRTY;
> 
> , since only writes that span EOF might trigger an update. How
> do you feel about it?

ext4 can do what it likes here, but given that the problem that was
being addressed was avoiding lock contention in
ext4_inode_datasync_dirty(), this appears to be a completely
unnecessary change as it doesn't address the problem being reported.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
