Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B389443A65
	for <lists+linux-ext4@lfdr.de>; Wed,  3 Nov 2021 01:28:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231931AbhKCAbY (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 2 Nov 2021 20:31:24 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:34014 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229804AbhKCAbX (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 2 Nov 2021 20:31:23 -0400
Received: from dread.disaster.area (pa49-180-20-157.pa.nsw.optusnet.com.au [49.180.20.157])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 6494E105AF48;
        Wed,  3 Nov 2021 11:28:45 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1mi48x-004Bdt-U8; Wed, 03 Nov 2021 11:28:43 +1100
Date:   Wed, 3 Nov 2021 11:28:43 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Zhongwei Cai <sunrise_l@sjtu.edu.cn>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, mingkaidong@gmail.com
Subject: Re: [PATCH] ext4: remove unnecessary ext4_inode_datasync_dirty in
 read path
Message-ID: <20211103002843.GC418105@dread.disaster.area>
References: <20211102024258.210439-1-sunrise_l@sjtu.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211102024258.210439-1-sunrise_l@sjtu.edu.cn>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=epq8cqlX c=1 sm=1 tr=0 ts=6181d7be
        a=t5ERiztT/VoIE8AqcczM6g==:117 a=t5ERiztT/VoIE8AqcczM6g==:17
        a=kj9zAlcOel0A:10 a=vIxV3rELxO4A:10 a=7-415B0cAAAA:8
        a=YA9poQYvTuHJZr3_SNYA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Nov 02, 2021 at 10:42:58AM +0800, Zhongwei Cai wrote:
> ext4_inode_datasync_dirty will call read_lock(&journal->j_state_lock) in
> journal mode, which is unnecessary in read path (As far as I know, the
> IOMAP_F_DIRTY flag set in the if branch is only used in write path,
> making it unnecessary in read path. Please correct me if I'm wrong).

IOMAP_F_DIRTY isn't conditional on the type of lookup being done. If
the inode is dirty in a way that O_DSYNC would require it to be
flushed to make the data stable, iomap should be told that it is
dirty, even on read lookups...

e.g. iomap_swapfile_activate() uses IOMAP_REPORT as the flags for
extent mapping iteration passed to iomap_swapfile_iter(). THis then
checks:

	/* No uncommitted metadata or shared blocks. */
	if (iomap->flags & IOMAP_F_DIRTY)
		return iomap_swapfile_fail(isi, "is not committed");

IOWs, we expect the IOMAP_F_DIRTY flag to be set on all types of
iomap mapping calls if the inode is dirty, not just IOMAP_WRITE
calls.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
