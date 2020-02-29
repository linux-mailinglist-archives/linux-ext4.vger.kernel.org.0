Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE3D71748BB
	for <lists+linux-ext4@lfdr.de>; Sat, 29 Feb 2020 19:40:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727304AbgB2Sko (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 29 Feb 2020 13:40:44 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:53000 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727194AbgB2Skn (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 29 Feb 2020 13:40:43 -0500
Received: from callcc.thunk.org (75-104-88-164.mobility.exede.net [75.104.88.164] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 01TIeOgp027765
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 29 Feb 2020 13:40:31 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 7F1D242045B; Sat, 29 Feb 2020 13:40:23 -0500 (EST)
Date:   Sat, 29 Feb 2020 13:40:23 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     Qian Cai <cai@lca.pw>, jack@suse.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/jbd2: fix data races at struct journal_head
Message-ID: <20200229184023.GE7378@mit.edu>
References: <20200222043111.2227-1-cai@lca.pw>
 <20200224091051.GC27857@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200224091051.GC27857@quack2.suse.cz>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Feb 24, 2020 at 10:10:51AM +0100, Jan Kara wrote:
> On Fri 21-02-20 23:31:11, Qian Cai wrote:
> > journal_head::b_transaction and journal_head::b_next_transaction could
> > be accessed concurrently as noticed by KCSAN,
> > 
> >  LTP: starting fsync04
> >  /dev/zero: Can't open blockdev
> >  EXT4-fs (loop0): mounting ext3 file system using the ext4 subsystem
> >  EXT4-fs (loop0): mounted filesystem with ordered data mode. Opts: (null)
> >  ==================================================================
> >  BUG: KCSAN: data-race in __jbd2_journal_refile_buffer [jbd2] / jbd2_write_access_granted [jbd2]
> > 
> >  write to 0xffff99f9b1bd0e30 of 8 bytes by task 25721 on cpu 70:
> >   __jbd2_journal_refile_buffer+0xdd/0x210 [jbd2]
> >   __jbd2_journal_refile_buffer at fs/jbd2/transaction.c:2569
> >   jbd2_journal_commit_transaction+0x2d15/0x3f20 [jbd2]
> >   (inlined by) jbd2_journal_commit_transaction at fs/jbd2/commit.c:1034
> >   kjournald2+0x13b/0x450 [jbd2]
> >   kthread+0x1cd/0x1f0
> >   ret_from_fork+0x27/0x50
> > 
> >  read to 0xffff99f9b1bd0e30 of 8 bytes by task 25724 on cpu 68:
> >   jbd2_write_access_granted+0x1b2/0x250 [jbd2]
> >   jbd2_write_access_granted at fs/jbd2/transaction.c:1155
> >   jbd2_journal_get_write_access+0x2c/0x60 [jbd2]
> >   __ext4_journal_get_write_access+0x50/0x90 [ext4]
> >   ext4_mb_mark_diskspace_used+0x158/0x620 [ext4]
> >   ext4_mb_new_blocks+0x54f/0xca0 [ext4]
> >   ext4_ind_map_blocks+0xc79/0x1b40 [ext4]
> >   ext4_map_blocks+0x3b4/0x950 [ext4]
> >   _ext4_get_block+0xfc/0x270 [ext4]
> >   ext4_get_block+0x3b/0x50 [ext4]
> >   __block_write_begin_int+0x22e/0xae0
> >   __block_write_begin+0x39/0x50
> >   ext4_write_begin+0x388/0xb50 [ext4]
> >   generic_perform_write+0x15d/0x290
> >   ext4_buffered_write_iter+0x11f/0x210 [ext4]
> >   ext4_file_write_iter+0xce/0x9e0 [ext4]
> >   new_sync_write+0x29c/0x3b0
> >   __vfs_write+0x92/0xa0
> >   vfs_write+0x103/0x260
> >   ksys_write+0x9d/0x130
> >   __x64_sys_write+0x4c/0x60
> >   do_syscall_64+0x91/0xb05
> >   entry_SYSCALL_64_after_hwframe+0x49/0xbe
> > 
> >  5 locks held by fsync04/25724:
> >   #0: ffff99f9911093f8 (sb_writers#13){.+.+}, at: vfs_write+0x21c/0x260
> >   #1: ffff99f9db4c0348 (&sb->s_type->i_mutex_key#15){+.+.}, at: ext4_buffered_write_iter+0x65/0x210 [ext4]
> >   #2: ffff99f5e7dfcf58 (jbd2_handle){++++}, at: start_this_handle+0x1c1/0x9d0 [jbd2]
> >   #3: ffff99f9db4c0168 (&ei->i_data_sem){++++}, at: ext4_map_blocks+0x176/0x950 [ext4]
> >   #4: ffffffff99086b40 (rcu_read_lock){....}, at: jbd2_write_access_granted+0x4e/0x250 [jbd2]
> >  irq event stamp: 1407125
> >  hardirqs last  enabled at (1407125): [<ffffffff980da9b7>] __find_get_block+0x107/0x790
> >  hardirqs last disabled at (1407124): [<ffffffff980da8f9>] __find_get_block+0x49/0x790
> >  softirqs last  enabled at (1405528): [<ffffffff98a0034c>] __do_softirq+0x34c/0x57c
> >  softirqs last disabled at (1405521): [<ffffffff97cc67a2>] irq_exit+0xa2/0xc0
> > 
> >  Reported by Kernel Concurrency Sanitizer on:
> >  CPU: 68 PID: 25724 Comm: fsync04 Tainted: G L 5.6.0-rc2-next-20200221+ #7
> >  Hardware name: HPE ProLiant DL385 Gen10/ProLiant DL385 Gen10, BIOS A40 07/10/2019
> > 
> > The plain reads are outside of jh->b_state_lock critical section which result
> > in data races. Fix them by adding pairs of READ|WRITE_ONCE().
> > 
> > Signed-off-by: Qian Cai <cai@lca.pw>
> 
> Yeah, makes sense. You can add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>

Thanks, applied.

				- Ted
