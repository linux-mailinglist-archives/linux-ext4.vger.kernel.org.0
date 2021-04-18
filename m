Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23261363687
	for <lists+linux-ext4@lfdr.de>; Sun, 18 Apr 2021 18:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231916AbhDRQGt (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 18 Apr 2021 12:06:49 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:46721 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230038AbhDRQGr (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 18 Apr 2021 12:06:47 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 13IG62gu014659
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 18 Apr 2021 12:06:02 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id D653F15C3B0D; Sun, 18 Apr 2021 12:06:01 -0400 (EDT)
Date:   Sun, 18 Apr 2021 12:06:01 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Wen Yang <wenyang@linux.alibaba.com>
Cc:     Andreas Dilger <adilger.kernel@dilger.ca>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        Baoyou Xie <baoyou.xie@alibaba-inc.com>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/ext4: prevent the CPU from being 100% occupied in
 ext4_mb_discard_group_preallocations
Message-ID: <YHxY6e9l3T4rsCos@mit.edu>
References: <20210418102834.29589-1-wenyang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210418102834.29589-1-wenyang@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sun, Apr 18, 2021 at 06:28:34PM +0800, Wen Yang wrote:
> The kworker has occupied 100% of the CPU for several days:
> PID USER  PR  NI VIRT RES SHR S  %CPU  %MEM TIME+  COMMAND
> 68086 root 20 0  0    0   0   R  100.0 0.0  9718:18 kworker/u64:11
> 
> ....
> 
> The thread that references this pa has been waiting for IO to return:
> PID: 15140  TASK: ffff88004d6dc300  CPU: 16  COMMAND: "kworker/u64:1"
> [ffffc900273e7518] __schedule at ffffffff8173ca3b
> [ffffc900273e75a0] schedule at ffffffff8173cfb6
> [ffffc900273e75b8] io_schedule at ffffffff810bb75a
> [ffffc900273e75e0] bit_wait_io at ffffffff8173d8d1
> [ffffc900273e75f8] __wait_on_bit_lock at ffffffff8173d4e9
> [ffffc900273e7638] out_of_line_wait_on_bit_lock at ffffffff8173d742
> [ffffc900273e76b0] __lock_buffer at ffffffff81288c32
> [ffffc900273e76c8] do_get_write_access at ffffffffa00dd177 [jbd2]
> [ffffc900273e7728] jbd2_journal_get_write_access at ffffffffa00dd3a3 [jbd2]
> [ffffc900273e7750] __ext4_journal_get_write_access at ffffffffa023b37b [ext4]
> [ffffc900273e7788] ext4_mb_mark_diskspace_used at ffffffffa0242a0b [ext4]
> [ffffc900273e77f0] ext4_mb_new_blocks at ffffffffa0244100 [ext4]
> [ffffc900273e7860] ext4_ext_map_blocks at ffffffffa02389ae [ext4]
> [ffffc900273e7950] ext4_map_blocks at ffffffffa0204b52 [ext4]
> [ffffc900273e79d0] ext4_writepages at ffffffffa0208675 [ext4]
> [ffffc900273e7b30] do_writepages at ffffffff811c487e
> [ffffc900273e7b40] __writeback_single_inode at ffffffff81280265
> [ffffc900273e7b90] writeback_sb_inodes at ffffffff81280ab2
> [ffffc900273e7c90] __writeback_inodes_wb at ffffffff81280ed2
> [ffffc900273e7cd8] wb_writeback at ffffffff81281238
> [ffffc900273e7d80] wb_workfn at ffffffff812819f4
> [ffffc900273e7e18] process_one_work at ffffffff810a5dc9
> [ffffc900273e7e60] worker_thread at ffffffff810a60ae
> [ffffc900273e7ec0] kthread at ffffffff810ac696
> [ffffc900273e7f50] ret_from_fork at ffffffff81741dd9
> 
> On the bare metal server, we will use multiple hard disks, the Linux
> kernel will run on the system disk, and business programs will run on
> several hard disks virtualized by the BM hypervisor. The reason why IO
> has not returned here is that the process handling IO in the BM hypervisor
> has failed.

So if the I/O not returning for every days, such that this thread had
been hanging for that long, it also follows that since it was calling
do_get_write_access(), that a handle was open.  And if a handle is
open, then the current jbd2 transaction would never close --- which
means none of the file system operations executed over the past few
days would never commit, and would be undone on the next reboot.
Furthermore, sooner or later the journal would run out of space, at
which point the *entire* system would be locked up waiting for the
transaction to close.

I'm guessing that if the server hadn't come to a full livelock
earlier, it's because there aren't that many metadata operations that
are happening in the server's stable state operation.  But in any
case, this particular server was/is(?) doomed, and all of the patches
that you proposed are not going to help in the long run.  The correct
fix is to fix the hypervisor, which is the root cause of the problem.

I could imagine some kind of retry counter, where we start sleeping
after some number of retries, and give up after some larger number of
retries (at which point the allocation would fail with ENOSPC).  We'd
need to do some testing against our current tests which test how we
handle running close to ENOSPC, and I'm not at all convinced it's
worth the effort in the end.  We're trying to (slightly) improve the
case where (a) the file system is running close to full, (b) the
hypervisor is critically flawed and is the real problem, and (c) the
VM is eventually doomed to fail anyway due to a transaction never
closing due to an I/O never getting acknowledged for days(!).

If you really want to fix things in the guest OS, I perhaps the
virtio_scsi driver (or whatever I/O driver you are using), should
notice when an I/O request hasn't gotten acknowledged after minutes or
hours, and do something such as force a SCSI reset (which will result
in the file system needing to be unmounted and recovered, but due to
the hypervisor bug, that was an inevitable end result anyway).

Cheers,

					- Ted
