Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39BBD131CD7
	for <lists+linux-ext4@lfdr.de>; Tue,  7 Jan 2020 01:43:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727322AbgAGAnu (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 6 Jan 2020 19:43:50 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:58593 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727233AbgAGAnu (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 6 Jan 2020 19:43:50 -0500
Received: from callcc.thunk.org (guestnat-104-133-0-111.corp.google.com [104.133.0.111] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 0070hccC028499
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 6 Jan 2020 19:43:39 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 8D7434200AF; Mon,  6 Jan 2020 19:43:38 -0500 (EST)
Date:   Mon, 6 Jan 2020 19:43:38 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Jan Kara <jack@suse.cz>, joseph.qi@linux.alibaba.com,
        Liu Bo <bo.liu@linux.alibaba.com>
Subject: Re: Discussion: is it time to remove dioread_nolock?
Message-ID: <20200107004338.GB125832@mit.edu>
References: <20191226153118.GA17237@mit.edu>
 <9042a8f4-985a-fc83-c059-241c9440200c@linux.alibaba.com>
 <20200106122457.A10F7AE053@d06av26.portsmouth.uk.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200106122457.A10F7AE053@d06av26.portsmouth.uk.ibm.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Jan 06, 2020 at 05:54:56PM +0530, Ritesh Harjani wrote:
> > The initial reason we use dioread_nolock is that it'll also allocate
> > unwritten extents for buffered write, and normally the corresponding
> > inode won't be added to jbd2 transaction's t_inode_list, so while
> > commiting transaction, it won't flush inodes' dirty pages, then
> > transaction will commit quickly, otherwise in extream case, the time
> 
> I do notice this in ext4_map_blocks(). We add inode to t_inode_list only
> in case if we allocate written blocks. I guess this was done to avoid
> stale data exposure problem. So now due to ordered mode, we may end up
> flushing all dirty data pages in committing transaction before the
> metadata is flushed.
> 
> Do you have any benchmarks or workload where we could see this problem?
> And could this actually be a problem with any real world workload too?

After thinking about this some more, I've changed my mind.

I think this is something which *can* be very noticeable in some real
world workloads.  If the workload is doing a lot of allocating,
buffered writes to an inode, and the writeback thread starts doing the
writeback for that inode right before a commit starts, then the commit
can take a long time.  The problem is that if the storage device is
particularly slow --- for example, a slow USB drive, or a 32 GiB
Standard Persistent Disk in a Google Compute Environment (which has a
max sustained throughput of 3 MiB/s), it doesn't take a lot of queued
writeback I/O to trigger a hung task warning.  Even if hung task panic
isn't enabled, if the commit thread is busied out for a minute or two,
anything that is blocked on a commit completing --- such a fsync(2)
system call, could end up getting blocked for a long time, and that
could easily make a userspace application sad.

> Jan/Ted, your opinion on this pls?
> 
> I do see that there was a proposal by Ted @ [1] which should
> also solve this problem. I do have plans to work on Ted's proposal, but
> meanwhile, should we preserve this mount option for above mentioned use
> case? Or should we make it a no-op now?

> [1] - https://marc.info/?l=linux-ext4&m=157244559501734&w=2

I agree that this was not the original intent of dioread_nolock, but I
until we can implement [1], dioread_nolock is the only workaround real
workaround we have today.  (Well, data=writeback also works, but that
has other problems.)

If dropping dioread_nolock makes it easier to implement [1], we can
certainly make that one of the first patches in a patch series which
changes how we ext4_writepages() works so it writes the data blocks
before it updates the metadata blocks.  But unless there are some real
downsides to keeping the code around in the kernel until then, I'm not
sure it's worth it to take away the diorad_nolock functionality until
we have a good replacement --- even if that wasn't the original
purpose of the code.

What do other folks think?

					- Ted
