Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEB7A2AF594
	for <lists+linux-ext4@lfdr.de>; Wed, 11 Nov 2020 16:57:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727369AbgKKP5p (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 11 Nov 2020 10:57:45 -0500
Received: from mx2.suse.de ([195.135.220.15]:56842 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726830AbgKKP5p (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 11 Nov 2020 10:57:45 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9A164ABD6;
        Wed, 11 Nov 2020 15:57:43 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 2D2891E130B; Wed, 11 Nov 2020 16:57:43 +0100 (CET)
Date:   Wed, 11 Nov 2020 16:57:43 +0100
From:   Jan Kara <jack@suse.cz>
To:     Chris Friesen <chris.friesen@windriver.com>
Cc:     Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org
Subject: Re: looking for assistance with jbd2 (and other processes) hung
 trying to write to disk
Message-ID: <20201111155743.GG28132@quack2.suse.cz>
References: <17a059de-6e95-ef97-6e0a-5e52af1b9a04@windriver.com>
 <20201110114202.GF20780@quack2.suse.cz>
 <7fa5a43f-bdd6-9cf1-172a-b2af47239e96@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7fa5a43f-bdd6-9cf1-172a-b2af47239e96@windriver.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue 10-11-20 09:57:39, Chris Friesen wrote:
> On 11/10/2020 5:42 AM, Jan Kara wrote:
> > On Mon 09-11-20 15:11:58, Chris Friesen wrote:
> 
> > > Can anyone give some suggestions on how to track down what's causing the
> > > delay here?  I suspect there's a race condition somewhere similar to what
> > > happened with https://access.redhat.com/solutions/3226391, although that one
> > > was specific to device-mapper and the root filesystem here is directly on
> > > the nvme device.
> > 
> > Sadly I don't have access to RH portal to be able to check what that hang
> > was about...
> 
> They had exactly the same stack trace (different addresses) with
> "jbd2/dm-16-8" trying to commit a journal transaction.  In their case it was
> apparently due to two problems, "the RAID1 code leaking the r1bio", and
> "dm-raid not handling a needed retry scenario".  They fixed it by
> backporting upstream commits.  The kernel we're running should have those
> fixes, and in our case we're operating directly on an nvme device.

I see. Thanks for explanation.

> > > crash> ps -m 930
> > > [0 00:09:11.694] [UN]  PID: 930    TASK: ffffa14b5f9032c0  CPU: 1 COMMAND:
> > > "jbd2/nvme2n1p4-"
> > > 
> > 
> > Are the tasks below the only ones hanging in D state (UN state in crash)?
> > Because I can see processes are waiting for the locked buffer but it is
> > unclear who is holding the buffer lock...
> 
> No, there are quite a few of them.  I've included them below.  I agree, it's
> not clear who's holding the lock.  Is there a way to find that out?
> 
> Just to be sure, I'm looking for whoever has the BH_Lock bit set on the
> buffer_head "b_state" field, right?  I don't see any ownership field the way
> we have for mutexes.  Is there some way to find out who would have locked
> the buffer?

Buffer lock is a bitlock so there's no owner field. If you can reproduce
the problem at will and can use debug kernels, then it's easiest to add
code to lock_buffer() (and fields to struct buffer_head) to track lock
owner and then see who locked the buffer. Without this, the only way is to
check stack traces of all UN processes and see whether some stacktrace
looks suspicious like it could hold the buffer locked (e.g. recursing into
memory allocation and reclaim while holding buffer locked or something like
that)...

As Ted wrote the buffer is indeed usually locked because the IO is running
and that would be the expected situation with the jdb2 stacktrace you
posted. So it could also be the IO got stuck somewhere in the block layer
or NVME (frankly, AFAIR NVME was pretty rudimentary with 3.10). To see
whether that's the case, you need to find 'bio' pointing to the buffer_head
(through bi_private field), possibly also struct request for that bio and see
what state they are in... Again, if you can run debug kernels, you can
write code to simplify this search for you...

> Do you think it would help at all to enable CONFIG_JBD_DEBUG?

I don't think so.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
