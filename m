Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5034F1A04E0
	for <lists+linux-ext4@lfdr.de>; Tue,  7 Apr 2020 04:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726353AbgDGC1W (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 6 Apr 2020 22:27:22 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:50364 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726287AbgDGC1W (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 6 Apr 2020 22:27:22 -0400
Received: from dread.disaster.area (pa49-180-164-3.pa.nsw.optusnet.com.au [49.180.164.3])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 423317EBFF2;
        Tue,  7 Apr 2020 12:27:06 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1jLdxB-0006Xf-Eb; Tue, 07 Apr 2020 12:27:05 +1000
Date:   Tue, 7 Apr 2020 12:27:05 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, hch@lst.de,
        darrick.wong@oracle.com, axboe@kernel.dk, tytso@mit.edu,
        adilger.kernel@dilger.ca, ming.lei@redhat.com, jthumshirn@suse.de,
        minwoo.im.dev@gmail.com, damien.lemoal@wdc.com,
        andrea.parri@amarulasolutions.com, hare@suse.com, tj@kernel.org,
        hannes@cmpxchg.org, khlebnikov@yandex-team.ru, ajay.joshi@wdc.com,
        bvanassche@acm.org, arnd@arndb.de, houtao1@huawei.com,
        asml.silence@gmail.com, linux-block@vger.kernel.org,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH 0/4] block: Add support for REQ_OP_ASSIGN_RANGE
Message-ID: <20200407022705.GA24067@dread.disaster.area>
References: <20200329174714.32416-1-chaitanya.kulkarni@wdc.com>
 <20200402224124.GK10737@dread.disaster.area>
 <yq1imih4aj0.fsf@oracle.com>
 <20200403025757.GL10737@dread.disaster.area>
 <yq1a73t44h1.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq1a73t44h1.fsf@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=LYdCFQXi c=1 sm=1 tr=0
        a=K0+o7W9luyMo1Ua2eXjR1w==:117 a=K0+o7W9luyMo1Ua2eXjR1w==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=cl8xLZFz6L8A:10
        a=7-415B0cAAAA:8 a=HsR5391j3YDOVBnZw_AA:9 a=CjuIK1q_8ugA:10
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Apr 02, 2020 at 08:45:30PM -0700, Martin K. Petersen wrote:
> 
> Dave,
> 
> > .... because when backed by thinp storage, plumbing user level
> > fallocate() straight through from the filesystem introduces a
> > trivial, user level storage DOS vector....
> >
> > i.e. a user can just fallocate a bunch of files and, because the
> > filesystem can do that instantly, can also run the back end array
> > out of space almost instantly. Storage admins are going to love
> > this!
> 
> In the standards space, the allocation concept was mainly aimed at
> protecting filesystem internals against out-of-space conditions on
> devices that dedup identical blocks and where simply zeroing the blocks
> therefore is ineffective.

Um, so we're supposed to use space allocation before overwriting
existing metadata in the filesystem? So that the underlying storage
can reserve space for it before we write it? Which would mean we
have to issue a space allocation before we dirty the metadata, which
means before we dirty any metadata in a transaction. Which means
we'll basically have to redesign the filesystems from the ground up,
yes?

> So far we have mainly been talking about fallocate on block devices.

You might be talking about filesystem metadata and block devices,
but this patchset ends up connecting ext4's user data fallocate() to
the block device, thereby allowing users to reserve space directly
in the underlying block device and directly exposing this issue to
userspace.

I can only go on what is presented to me in patches - this patchset
nothing to do with filesystem metadata nor preventing ENOSPC issues
with internal filesystem updates.

XFS is no different to ext4 or btrfs here - the filesystem doesn't
matter because all of them can fallocate() terabytes of space in
a second or two these days....

> How XFS decides to enforce space allocation policy and potentially
> leverage this plumbing is entirely up to you.

Do I understand this correctly? i.e. that it is the filesystem's
responsibility to prevent users from preallocating more space than
exists in an underlying storage pool that has been intentionally
hidden from the filesystem so it can be underprovisioned?

IOWs, I'm struggling to understand exactly how the "standards space"
think filesystems are supposed to be using this feature whilst also
preventing unprivileged exhaustion of a underprovisioned storage
pool they know nothing about.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
