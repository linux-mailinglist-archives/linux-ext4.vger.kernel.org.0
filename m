Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34643338DA6
	for <lists+linux-ext4@lfdr.de>; Fri, 12 Mar 2021 13:52:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231786AbhCLMvR (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 12 Mar 2021 07:51:17 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:37962 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S232216AbhCLMvH (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 12 Mar 2021 07:51:07 -0500
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 12CCp4x6010195
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 Mar 2021 07:51:05 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 84CB715C3AA0; Fri, 12 Mar 2021 07:51:04 -0500 (EST)
Date:   Fri, 12 Mar 2021 07:51:04 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Shashidhar Patil <shashidhar.patil@gmail.com>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: jbd2 task hung in jbd2_journal_commit_transaction
Message-ID: <YEtjuGZCfD+7vCFd@mit.edu>
References: <CADve3d51po2wh6rmgrzM8-k9h=JzE9+mC57Y5V2BxfFkKPFMsw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADve3d51po2wh6rmgrzM8-k9h=JzE9+mC57Y5V2BxfFkKPFMsw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Mar 12, 2021 at 01:33:26PM +0530, Shashidhar Patil wrote:
> Hi,
>       We are seeing problem with many tasks hung in 'D' state and
> stack output of jbd2 thread is hung at
> jbd2_journal_commit_transaction().
> 
> The stack trace of jdb2 task is:
> 
> [<0>] jbd2_journal_commit_transaction+0x26e/0x1870^M
> [<0>] kjournald2+0xc8/0x250^M
> [<0>] kthread+0x105/0x140^M
> [<0>] ret_from_fork+0x35/0x40^M
> [<0>] 0xffffffffffffffff^M
> 
> The symptoms look similar to
> https://www.spinics.net/lists/linux-ext4/msg53502.html.
> 
> The system has zswap configured with swap backing is an ext4 file.
> There are oom kills recorded in the dmesg.
> 
> As per Theodore in the above link the issue is caused by a leaked
> atomic handle. But one of the backtraces collected (below) points to
> a possile problem of cylic dependency during direct memory reclaim as
> poined here
> https://www.kernel.org/doc/html/latest/core-api/gfp_mask-from-fs-io.html
> 
> This issue is explained in below steps
> 1. sys_write processing allocates atomic handle for journaling and
> handle got allocated
> , journalling started on the handle
> 2. as part of write processing page cache allocation successed and the
> write operation also started
> 3. During the write iteration jbd2_alloc() was called with (GFP_NOFS |
> __GFP_NOFAIL) which imply __GFP_DIRECT_RECLAIM
> 
> 4. zswap backup ram is full so it tries to reclaim memory to free up
> some pages and initiates a swap page disk writeback. In this case the
> swap file is on the same partition on which write() call is done.

From what I can tell zswap is using writepage(), and since the swap
file should be *completely* preallocated and initialized, we should
never be trying to start a handle from zswap.  This should prevent the
deadlock from happening.  If zswap is doing something which is causing
ext4 to start a handle when it tries to writeout a swap page, then
that would certainly be a problem.  But that really shouldn't be the
case.

> 
>  The backtrace which might cause the deadlock
> 
> 4,1736499,1121675690224,-;Call Trace:
> 4,1736500,1121675690231,-; __schedule+0x3d6/0x8b0
> 4,1736501,1121675690237,-; schedule+0x36/0x80
> 4,1736502,1121675690245,-; io_schedule+0x16/0x40
> 4,1736503,1121675690253,-; wbt_wait+0x22f/0x380
> 4,1736504,1121675690261,-; ? trace_event_raw_event_wbt_timer+0x100/0x100
> 4,1736505,1121675690269,-; ? end_swap_bio_read+0xd0/0xd0
> 4,1736506,1121675690275,-; blk_mq_make_request+0x103/0x5b0

We can see that zswap has called _swap_writepage(), and then the I/O
has been submitted... and we're waiting for the I/O to complete ---
see the call io_schedule().  So we're not actually deadlocking on
anything other else than... the storage device not getting back to us
with the I/O completion notification.  And that's not really a cyclic
deadlock, but probably a lost I/O completion interrupt, or the storage
device firmware panicing/crashing/show stopping, or falling off the
SATA bus and then needing to reconnect, etc.

						- Ted


> 4,1736507,1121675690283,-; ? end_swap_bio_read+0xd0/0xd0
> 4,1736508,1121675690288,-; generic_make_request+0x122/0x2f0
> 4,1736509,1121675690295,-; submit_bio+0x73/0x140
> 4,1736510,1121675690302,-; ? submit_bio+0x73/0x140
> 4,1736511,1121675690308,-; ? get_swap_bio+0xcf/0x100
> 4,1736512,1121675690316,-; __swap_writepage+0x33f/0x3b0
> 4,1736513,1121675690322,-; ? lru_cache_add_file+0x37/0x40
> 4,1736514,1121675690329,-; ? lzo_decompress+0x38/0x70
> 4,1736515,1121675690336,-; zswap_writeback_entry+0x249/0x350
> 4,1736516,1121675690343,-; zbud_zpool_evict+0x31/0x40
> 4,1736517,1121675690349,-; zbud_reclaim_page+0x1e9/0x250
> 4,1736518,1121675690356,-; zbud_zpool_shrink+0x3b/0x60
> 4,1736519,1121675690362,-; zpool_shrink+0x1c/0x20
> 4,1736520,1121675690369,-; zswap_frontswap_store+0x274/0x530
> 4,1736521,1121675690376,-; __frontswap_store+0x78/0x100
> 4,1736522,1121675690382,-; swap_writepage+0x3f/0x80
> 4,1736523,1121675690390,-; pageout.isra.53+0x1e6/0x340
> 4,1736524,1121675690397,-; shrink_page_list+0x992/0xbe0
> 4,1736525,1121675690403,-; shrink_inactive_list+0x2af/0x5f0
> 4,1736526,1121675690409,-; ? _find_next_bit+0x40/0x70
> 4,1736527,1121675690416,-; shrink_node_memcg+0x36f/0x7f0
> 4,1736528,1121675690423,-; shrink_node+0xe1/0x310
> 4,1736529,1121675690429,-; ? shrink_node+0xe1/0x310
> 4,1736530,1121675690435,-; do_try_to_free_pages+0xee/0x360
> 4,1736531,1121675690439,-; try_to_free_pages+0xf1/0x1c0
> 4,1736532,1121675690442,-; __alloc_pages_slowpath+0x399/0xe90
> 4,1736533,1121675690446,-; __alloc_pages_nodemask+0x289/0x2d0
> 4,1736534,1121675690449,-; alloc_pages_current+0x6a/0xe0
> 4,1736535,1121675690452,-; __get_free_pages+0xe/0x30
> 4,1736536,1121675690455,-; jbd2_alloc+0x3a/0x60
> 4,1736537,1121675690458,-; do_get_write_access+0x182/0x3e0
> 4,1736538,1121675690461,-; jbd2_journal_get_write_access+0x51/0x80
> 4,1736539,1121675690464,-; __ext4_journal_get_write_access+0x3b/0x80
> 4,1736540,1121675690466,-; ext4_reserve_inode_write+0x95/0xc0
> 4,1736541,1121675690467,-; ? ext4_dirty_inode+0x48/0x70
> 4,1736542,1121675690469,-; ext4_mark_inode_dirty+0x53/0x1d0
> 4,1736543,1121675690470,-; ? __ext4_journal_start_sb+0x6d/0x120
> 4,1736544,1121675690473,-; ext4_dirty_inode+0x48/0x70
> 4,1736545,1121675690475,-; __mark_inode_dirty+0x184/0x3b0
> 4,1736546,1121675690479,-; generic_update_time+0x7b/0xd0
> 4,1736547,1121675690482,-; ? current_time+0x32/0x70
> 4,1736548,1121675690484,-; file_update_time+0xbe/0x110
> 4,1736549,1121675690487,-; __generic_file_write_iter+0x9d/0x1f0
> 4,1736550,1121675690490,-; ext4_file_write_iter+0xc4/0x3b0
> 4,1736551,1121675690492,-; ? sock_sendmsg+0x3e/0x50
> 4,1736552,1121675690495,-; new_sync_write+0xe5/0x140
> 4,1736553,1121675690498,-; __vfs_write+0x29/0x40
> 4,1736554,1121675690501,-; vfs_write+0xb8/0x1b0
> 4,1736555,1121675690503,-; ? syscall_trace_enter+0x1d6/0x2f0
> 4,1736556,1121675690505,-; SyS_write+0x5c/0xe0
> 4,1736557,1121675690508,-; do_syscall_64+0x73/0x130
> 4,1736558,1121675690509,-; entry_SYSCALL_64_after_hwframe+0x3d/0xa2
