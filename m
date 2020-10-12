Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56AE028B359
	for <lists+linux-ext4@lfdr.de>; Mon, 12 Oct 2020 13:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387760AbgJLLDt (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 12 Oct 2020 07:03:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:37618 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387693AbgJLLDt (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 12 Oct 2020 07:03:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AAD4FAC24;
        Mon, 12 Oct 2020 11:03:47 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 1A4C51E12F5; Mon, 12 Oct 2020 13:03:47 +0200 (CEST)
Date:   Mon, 12 Oct 2020 13:03:47 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     linux-ext4@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Eric Whitney <enwlinux@gmail.com>,
        Theodore Ts'o <tytso@mit.edu>
Subject: Re: xfstests global-ext4/1k generic/219 failure due to dmesg warning
 of "circular locking dependency detected"
Message-ID: <20201012110347.GB23665@quack2.suse.cz>
References: <2eb09d70-b56e-2c0b-8ef4-0479d7be2bb3@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2eb09d70-b56e-2c0b-8ef4-0479d7be2bb3@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi!

On Fri 09-10-20 22:59:13, Ritesh Harjani wrote:
> While running generic/219 fstests on a 1k blocksize on x86 box, I see
> below dmesg warning msg and generic/219 fails. I haven't yet analyzed
> it, but I remember I have seen such warnings before as well in my testing.
> I was wondering if others have also seen it in their testing or not and
> if this is any known issue?

I don't remember seeing this lately. What mkfs options do you use for your
test? I can see below that mount options are apparently:

acl,user_xattr,block_validity,usrquota,grpquota

> Here it goes, 219.dmesg file.
> 
> [14459.933253] run fstests generic/219 at 2020-10-08 20:03:27
> [14462.947295] EXT4-fs (vdc): mounted filesystem with ordered data mode.
> Opts: acl,user_xattr,block_validity,usrquota,grpquota
> [14462.992869] EXT4-fs (vdc): re-mounted. Opts: (null)
> [14463.017058] EXT4-fs (vdc): re-mounted. Opts: (null)
> [14463.727095] EXT4-fs (vdc): mounted filesystem with ordered data mode.
> Opts: usrquota
> [14463.837130] EXT4-fs (vdc): re-mounted. Opts: (null)
> [14463.874293] EXT4-fs (vdc): re-mounted. Opts: (null)
> 
> [14464.149407] ======================================================
> [14464.149407] WARNING: possible circular locking dependency detected
> [14464.149407] 5.9.0-rc8-next-20201008 #16 Not tainted
> [14464.149407] ------------------------------------------------------
> [14464.149407] chown/23358 is trying to acquire lock:
> [14464.149407] ffff8b9b8ff60be0 (&ei->i_data_sem){++++}-{3:3}, at:
> ext4_map_blocks+0xd1/0x640
> [14464.149407]
>                but task is already holding lock:
> [14464.149407] ffff8b9b8963c208 (&s->s_dquot.dqio_sem){++++}-{3:3}, at:
> v2_write_dquot+0x2d/0xb0
> [14464.149407]
>                which lock already depends on the new lock.

Umm, this seems to show that somehow the lockdep annotation for the
i_data_sem on the quota file didn't get set properly. i_data_sem on the
quota file should have I_DATA_SEM_QUOTA (2) subclass but in this report we
can see that there's no subclass set on ei->i_data_sem. We do set the
subclass in ext4_quota_on() or ext4_enable_quota(). Strange...

								Honza

> [14464.149407]
>                the existing dependency chain (in reverse order) is:
> [14464.149407]
>                -> #2 (&s->s_dquot.dqio_sem){++++}-{3:3}:
> [14464.149407]        down_read+0x41/0x200
> [14464.149407]        v2_read_dquot+0x23/0x60
> [14464.149407]        dquot_acquire+0x4c/0x100
> [14464.149407]        ext4_acquire_dquot+0x72/0xc0
> [14464.149407]        dqget+0x24a/0x4a0
> [14464.149407]        __dquot_initialize+0x1f0/0x330
> [14464.149407]        ext4_create+0x38/0x190
> [14464.149407]        lookup_open+0x4cd/0x630
> [14464.149407]        path_openat+0x2c4/0xa10
> [14464.149407]        do_filp_open+0x91/0x100
> [14464.149407]        do_sys_openat2+0x20d/0x2d0
> [14464.149407]        do_sys_open+0x44/0x80
> [14464.149407]        do_syscall_64+0x33/0x40
> [14464.149407]        entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [14464.149407]
>                -> #1 (&dquot->dq_lock){+.+.}-{3:3}:
> [14464.149407]        __mutex_lock+0xaa/0x9c0
> [14464.149407]        dquot_commit+0x23/0xf0
> [14464.149407]        ext4_write_dquot+0x78/0xb0
> [14464.149407]        __dquot_alloc_space+0x151/0x310
> [14464.149407]        ext4_mb_new_blocks+0x1f6/0x12e0
> [14464.149407]        ext4_ext_map_blocks+0x9c3/0x1470
> [14464.149407]        ext4_map_blocks+0xf4/0x640
> [14464.149407]        _ext4_get_block+0x90/0x110
> [14464.149407]        ext4_block_write_begin+0x15f/0x5a0
> [14464.149407]        ext4_write_begin+0x267/0x5b0
> [14464.149407]        generic_perform_write+0xc2/0x1e0
> [14464.149407]        ext4_buffered_write_iter+0x8b/0x130
> [14464.149407]        ext4_file_write_iter+0x6c/0x6d0
> [14464.149407]        new_sync_write+0x122/0x1b0
> [14464.149407]        vfs_write+0x1ca/0x230
> [14464.149407]        ksys_pwrite64+0x68/0xa0
> [14464.149407]        do_syscall_64+0x33/0x40
> [14464.149407]        entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [14464.149407]
>                -> #0 (&ei->i_data_sem){++++}-{3:3}:
> [14464.149407]        __lock_acquire+0x147b/0x2830
> [14464.149407]        lock_acquire+0xc6/0x3a0
> [14464.149407]        down_write+0x40/0x110
> [14464.149407]        ext4_map_blocks+0xd1/0x640
> [14464.149407]        ext4_getblk+0x54/0x1c0
> [14464.149407]        ext4_bread+0x1f/0xd0
> [14464.149407]        ext4_quota_write+0xbf/0x280
> [14464.149407]        write_blk+0x35/0x70
> [14464.149407]        get_free_dqblk+0x42/0xa0
> [14464.149407]        do_insert_tree+0x1d6/0x480
> [14464.149407]        do_insert_tree+0x464/0x480
> [14464.149407]        do_insert_tree+0x218/0x480
> [14464.149407]        do_insert_tree+0x218/0x480
> [14464.149407]        qtree_write_dquot+0x79/0x1b0
> [14464.149407]        v2_write_dquot+0x52/0xb0
> [14464.149407]        dquot_acquire+0x8e/0x100
> [14464.149407]        ext4_acquire_dquot+0x72/0xc0
> [14464.149407]        dqget+0x24a/0x4a0
> [14464.149407]        dquot_transfer+0xfe/0x140
> [14464.149407]        ext4_setattr+0x134/0x9c0
> [14464.149407]        notify_change+0x34b/0x490
> [14464.149407]        chown_common+0x96/0x150
> [14464.149407]        do_fchownat+0x8d/0xe0
> [14464.149407]        __x64_sys_fchownat+0x21/0x30
> [14464.149407]        do_syscall_64+0x33/0x40
> [14464.149407]        entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [14464.149407]
>                other info that might help us debug this:
> 
> [14464.149407] Chain exists of:
>                  &ei->i_data_sem --> &dquot->dq_lock -->
> &s->s_dquot.dqio_sem
> 
> [14464.149407]  Possible unsafe locking scenario:
> 
> [14464.149407]        CPU0                    CPU1
> [14464.149407]        ----                    ----
> [14464.149407]   lock(&s->s_dquot.dqio_sem);
> [14464.149407]                                lock(&dquot->dq_lock);
> [14464.149407]                                lock(&s->s_dquot.dqio_sem);
> [14464.149407]   lock(&ei->i_data_sem);
> [14464.149407]
>                 *** DEADLOCK ***
> 
> [14464.149407] 6 locks held by chown/23358:
> [14464.149407]  #0: ffff8b9b8963c480 (sb_writers#3){++++}-{0:0}, at:
> mnt_want_write+0x20/0x50
> [14464.149407]  #1: ffff8b9b8ff64bc8
> (&sb->s_type->i_mutex_key#9){++++}-{3:3}, at: chown_common+0x85/0x150
> [14464.149407]  #2: ffff8b9b670c48d8 (jbd2_handle){++++}-{0:0}, at:
> start_this_handle+0x1ad/0x690
> [14464.149407]  #3: ffff8b9b8ff648d0 (&ei->xattr_sem){++++}-{3:3}, at:
> ext4_setattr+0x129/0x9c0
> [14464.149407]  #4: ffff8b9b1313f5f0 (&dquot->dq_lock){+.+.}-{3:3}, at:
> dquot_acquire+0x23/0x100
> [14464.149407]  #5: ffff8b9b8963c208 (&s->s_dquot.dqio_sem){++++}-{3:3}, at:
> v2_write_dquot+0x2d/0xb0
> [14464.149407]
>                stack backtrace:
> [14464.149407] CPU: 5 PID: 23358 Comm: chown Not tainted
> 5.9.0-rc8-next-20201008 #16
> [14464.149407] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> 1.13.0-1ubuntu1 04/01/2014
> [14464.149407] Call Trace:
> [14464.149407]  dump_stack+0x77/0x97
> [14464.149407]  check_noncircular+0x132/0x150
> [14464.149407]  ? sched_clock_local+0x12/0x80
> [14464.149407]  __lock_acquire+0x147b/0x2830
> [14464.149407]  lock_acquire+0xc6/0x3a0
> [14464.149407]  ? ext4_map_blocks+0xd1/0x640
> [14464.149407]  down_write+0x40/0x110
> [14464.149407]  ? ext4_map_blocks+0xd1/0x640
> [14464.149407]  ext4_map_blocks+0xd1/0x640
> [14464.149407]  ? sched_clock_local+0x12/0x80
> [14464.149407]  ext4_getblk+0x54/0x1c0
> [14464.149407]  ext4_bread+0x1f/0xd0
> [14464.149407]  ext4_quota_write+0xbf/0x280
> [14464.149407]  write_blk+0x35/0x70
> [14464.149407]  get_free_dqblk+0x42/0xa0
> [14464.149407]  do_insert_tree+0x1d6/0x480
> [14464.149407]  ? ext4_quota_read+0x9d/0x110
> [14464.149407]  do_insert_tree+0x464/0x480
> [14464.149407]  ? ext4_quota_read+0x9d/0x110
> [14464.149407]  do_insert_tree+0x218/0x480
> [14464.149407]  ? ext4_quota_read+0x9d/0x110
> [14464.149407]  do_insert_tree+0x218/0x480
> [14464.149407]  ? __kmalloc+0x319/0x350
> [14464.149407]  qtree_write_dquot+0x79/0x1b0
> [14464.149407]  v2_write_dquot+0x52/0xb0
> [14464.149407]  dquot_acquire+0x8e/0x100
> [14464.149407]  ext4_acquire_dquot+0x72/0xc0
> [14464.149407]  dqget+0x24a/0x4a0
> [14464.149407]  dquot_transfer+0xfe/0x140
> [14464.149407]  ext4_setattr+0x134/0x9c0
> [14464.149407]  notify_change+0x34b/0x490
> [14464.149407]  ? chown_common+0x96/0x150
> [14464.149407]  chown_common+0x96/0x150
> [14464.149407]  ? preempt_count_add+0x49/0xa0
> [14464.149407]  do_fchownat+0x8d/0xe0
> [14464.149407]  __x64_sys_fchownat+0x21/0x30
> [14464.149407]  do_syscall_64+0x33/0x40
> [14464.149407]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [14464.149407] RIP: 0033:0x7efd3d2666ca
> [14464.149407] Code: 48 8b 0d c9 f7 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 66
> 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 49 89 ca b8 04 01 00 00 0f 05 <48>
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 96 f7 0c 00 f7 d8 64 89 01 48
> [14464.149407] RSP: 002b:00007ffdbe6ae418 EFLAGS: 00000206 ORIG_RAX:
> 0000000000000104
> [14464.149407] RAX: ffffffffffffffda RBX: 00007ffdbe6ae650 RCX:
> 00007efd3d2666ca
> [14464.149407] RDX: 0000000000007ab7 RSI: 00005598d654ef60 RDI:
> 00000000ffffff9c
> [14464.149407] RBP: 00000000ffffff9c R08: 0000000000000000 R09:
> 00000000ffffffff
> [14464.149407] R10: 00000000ffffffff R11: 0000000000000206 R12:
> 00005598d654e1f0
> [14464.149407] R13: 00005598d654e268 R14: 0000000000007ab7 R15:
> 00000000ffffffff
> [14465.070206] EXT4-fs (vdc): mounted filesystem with ordered data mode.
> Opts: grpquota
> [14465.165678] EXT4-fs (vdc): re-mounted. Opts: (null)
> [14465.201132] EXT4-fs (vdc): re-mounted. Opts: (null)
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
