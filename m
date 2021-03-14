Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40EB233A286
	for <lists+linux-ext4@lfdr.de>; Sun, 14 Mar 2021 04:59:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231756AbhCNDjH (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 13 Mar 2021 22:39:07 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:32791 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229870AbhCNDii (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 13 Mar 2021 22:38:38 -0500
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 12E3cYlh017886
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 13 Mar 2021 22:38:34 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id D0E5615C3AA2; Sat, 13 Mar 2021 22:38:33 -0500 (EST)
Date:   Sat, 13 Mar 2021 22:38:33 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Shashidhar Patil <shashidhar.patil@gmail.com>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: jbd2 task hung in jbd2_journal_commit_transaction
Message-ID: <YE2FOTpWOaidmT52@mit.edu>
References: <CADve3d51po2wh6rmgrzM8-k9h=JzE9+mC57Y5V2BxfFkKPFMsw@mail.gmail.com>
 <YEtjuGZCfD+7vCFd@mit.edu>
 <CADve3d7bioEAMwQ=i8KZ=hjrBDMk7gJK8kTUu2E5Q=W_KbUMPg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADve3d7bioEAMwQ=i8KZ=hjrBDMk7gJK8kTUu2E5Q=W_KbUMPg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat, Mar 13, 2021 at 01:29:43PM +0530, Shashidhar Patil wrote:
> > From what I can tell zswap is using writepage(), and since the swap
> > file should be *completely* preallocated and initialized, we should
> > never be trying to start a handle from zswap.  This should prevent the
> > deadlock from happening.  If zswap is doing something which is causing
> > ext4 to start a handle when it tries to writeout a swap page, then
> > that would certainly be a problem.  But that really shouldn't be the
> > case.
> 
> Yes. But the the first sys_write() called by the application did
> allocate an journal handle as required and since
> this specific request now is waiting for IO to complete the handle is
> not closed. Elsewhere in jbd2 task the commit_transaction is
> blocked since there is one or more open journalling handles. Is my
> understanding correct ?

Yes, that's correct.  When we start a transaction commit, either
because the 5 second commit interval has been reached, or there isn't
enough room in the journal for a particular handle to start (when we
start a file system mutation, we estimate the worst case number of
blocks that might need to be modified, and hence require space in the
journal), we first (a) stop any new handles from being started, and
then (b) wait for all currently running handles to complete.

If one handle takes a lot longer to complete than all the others,
while we are waiting for that last handle to finish, the commit can
not make forward progress, and no other file system operation which
requires modifying metadata can proceed.  As a result, we try to keep
the time between starting a handle and stopping a handle as short as
possible.  For example, if possible, we will try to read a block that
might be needed by a mutation operation *before* we start the handle.
That's not always possible, but we try to do that whenever possible,
and there are various tracepoints and other debugging facilities so we
can see which types of file system mutations require holding handles
longest, so we can try to optimize them.

> 4,1737846,1121675697013,-; schedule+0x36/0x80
> 4,1737847,1121675697015,-; io_schedule+0x16/0x40
> 4,1737848,1121675697016,-; blk_mq_get_tag+0x161/0x250
> 4,1737849,1121675697018,-; ? wait_woken+0x80/0x80
> 4,1737850,1121675697020,-; blk_mq_get_request+0xdc/0x3b0
> 4,1737851,1121675697021,-; blk_mq_make_request+0x128/0x5b0
> 4,1737852,1121675697023,-; generic_make_request+0x122/0x2f0
> 4,1737853,1121675697024,-; ? bio_alloc_bioset+0xd2/0x1e0
> 4,1737854,1121675697026,-; submit_bio+0x73/0x140
> .....
> So all those IO requests are waiting for response from the raid port,
> is that right ?
> 
> But the megaraid_sas driver( the system has LSI MEGARAID port) in most
> cases handles the unresponsive behavior
> by resetting the device. IN this case the reset did not happen, maybe
> there is some other bug in the megaraid driver.

Yes, it's not necessarily a problem with the storage device or the
host bus adapter; it could also be some kind of bug in the device
driver --- or even the block layer, although that's much, much less
likely (mostly because a lot of people would be complaining if that
were the case).

If you have access to a SCSI/SATA bus snooper which can be inserted in
between the storage device (HDD/SSD) and the LSI Megaraid, that might
be helpful in terms of trying to figure out what is going on.  Failing
that, you'll probably find some way to add/use debugging
hooks/tracepoints in the driver.

Good luck,

					- Ted
