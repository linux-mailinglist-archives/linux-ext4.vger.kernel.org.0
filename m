Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57E8D1AFEB0
	for <lists+linux-ext4@lfdr.de>; Mon, 20 Apr 2020 00:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725947AbgDSWhC (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 19 Apr 2020 18:37:02 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:51636 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725848AbgDSWhB (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Sun, 19 Apr 2020 18:37:01 -0400
Received: from dread.disaster.area (pa49-180-0-232.pa.nsw.optusnet.com.au [49.180.0.232])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id DCF9E3A354F;
        Mon, 20 Apr 2020 08:36:47 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1jQIYQ-0006ON-43; Mon, 20 Apr 2020 08:36:46 +1000
Date:   Mon, 20 Apr 2020 08:36:46 +1000
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
Message-ID: <20200419223646.GB9765@dread.disaster.area>
References: <20200329174714.32416-1-chaitanya.kulkarni@wdc.com>
 <20200402224124.GK10737@dread.disaster.area>
 <yq1imih4aj0.fsf@oracle.com>
 <20200403025757.GL10737@dread.disaster.area>
 <yq1a73t44h1.fsf@oracle.com>
 <20200407022705.GA24067@dread.disaster.area>
 <yq1sghe1uu3.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq1sghe1uu3.fsf@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=W5xGqiek c=1 sm=1 tr=0
        a=XYjVcjsg+1UI/cdbgX7I7g==:117 a=XYjVcjsg+1UI/cdbgX7I7g==:17
        a=kj9zAlcOel0A:10 a=cl8xLZFz6L8A:10 a=7-415B0cAAAA:8
        a=9_JA7O5G14uhOetSDJ0A:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Apr 08, 2020 at 12:10:12AM -0400, Martin K. Petersen wrote:
> 
> Hi Dave!
> 
> >> In the standards space, the allocation concept was mainly aimed at
> >> protecting filesystem internals against out-of-space conditions on
> >> devices that dedup identical blocks and where simply zeroing the blocks
> >> therefore is ineffective.
> 
> > Um, so we're supposed to use space allocation before overwriting
> > existing metadata in the filesystem?
> 
> Not before overwriting, no. Once you have allocated an LBA it remains
> allocated until you discard it.

That is not a consistent argument. If the data has been deduped and
we overwrite, the storage array has to allocate new physical space
for an overwrite to an existing LBA. i.e. deduped data has multiple
LBAs pointing to the same physical storage. Any overwrite of an LBA
that maps to mulitply referenced physical storage requires the
storage array to allocate new physical space for that overwrite.

i.e. allocation is not determined by whether the LBA has been
written to, "pinned" or not - it's whether the act of writing to
that LBA requires the storage to allocate new space to allow the
write to proceed.

That's my point here - one particular shared data overwrite case is
being special cased by preallocation (avoiding dedupe of zero filled
data) to prevent ENOSPC, ignoring all the other cases where we
overwrite shared non-zero data and will also require new physical
space for the new data. In all those cases, the storage has to take
the same action - allocation on overwrite - and so all of them are
susceptible to ENOSPC.

> > So that the underlying storage can reserve space for it before we
> > write it? Which would mean we have to issue a space allocation before
> > we dirty the metadata, which means before we dirty any metadata in a
> > transaction. Which means we'll basically have to redesign the
> > filesystems from the ground up, yes?
> 
> My understanding is that this facility was aimed at filesystems that do
> not dynamically allocate metadata. The intent was that mkfs would
> preallocate the metadata LBA ranges, not the filesystem. For filesystems
> that allocate metadata dynamically, then yes, an additional step is
> required if you want to pin the LBAs.

Ok, so you are confirming what I thought: it's almost completely
useless to us.

i.e. this requires issuing IO to "reserve" space whilst preserving
data before every metadata object goes from clean to dirty in
memory.  But the problem with that is we don't know how much
metadata we are going to dirty in any specific operation. Worse is
that we don't know exactly *what* metadata we will modify until we
walk structures and do lookups, which often happen after we've
dirtied other structures. An ENOSPC from a space reservation at that
point is fatal to the filesystem anyway, so there's no point in even
trying to do this.  Like I said, functionality like this cannot be
retrofitted to existing filesysetms.

IOWs, this is pretty much useless functionality for the filesystem
layer, and if the only use is for some mythical filesystem with
completely static metadata then the standards space really jumped
the shark on this one....

> > You might be talking about filesystem metadata and block devices,
> > but this patchset ends up connecting ext4's user data fallocate() to
> > the block device, thereby allowing users to reserve space directly
> > in the underlying block device and directly exposing this issue to
> > userspace.
> 
> I missed that Chaitanya's repost of this series included the ext4 patch.
> Sorry!
> 
> >> How XFS decides to enforce space allocation policy and potentially
> >> leverage this plumbing is entirely up to you.
> >
> > Do I understand this correctly? i.e. that it is the filesystem's
> > responsibility to prevent users from preallocating more space than
> > exists in an underlying storage pool that has been intentionally
> > hidden from the filesystem so it can be underprovisioned?
> 
> No. But as an administrative policy it is useful to prevent runaway
> applications from writing a petabyte of random garbage to media. My
> point was that it is up to you and the other filesystem developers to
> decide how you want to leverage the low-level allocation capability and
> how you want to provide it to processes. And whether CAP_SYS_ADMIN,
> ulimit, or something else is the appropriate policy interface for this.

My cynical translation: the storage standards space haven't given
any thought to how it can be used and/or administered in the real
world. Pass the buck - let the filesystem people work that out.

What I'm hearing is that this wasn't designed for typical filesystem
use, it wasn't designed for typical user application use, and how to
prevent abuse wasn't thought about at all.

That sounds like a big fat NACK to me....

> In terms of thin provisioning and space management there are various
> thresholds that may be reported by the device. In past discussions there
> haven't been much interest in getting these exposed. It is also unclear
> to me whether it is actually beneficial to send low space warnings to
> hundreds or thousands of hosts attached to an array. In many cases the
> individual server admins are not even the right audience. The most
> common notification mechanism is a message to the storage array admin
> saying "click here to buy more disk".

Notifications are not relevant to preallocation functionality at all.

-Dave.
-- 
Dave Chinner
david@fromorbit.com
