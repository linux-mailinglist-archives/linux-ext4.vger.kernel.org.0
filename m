Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E23312899B8
	for <lists+linux-ext4@lfdr.de>; Fri,  9 Oct 2020 22:26:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388178AbgJIU0U (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 9 Oct 2020 16:26:20 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:47156 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387846AbgJIU0U (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 9 Oct 2020 16:26:20 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 099KJkZL192526;
        Fri, 9 Oct 2020 20:26:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=uNylvxQ4u5x73yTzr7+C7ydpkb3No7lg2feofof0TSg=;
 b=QwZxM2hmmImkI5orL0ZpCSGZ2pJw75WLXqWquCUT4hRTwx1d6jSa7whF1DJ7iBFqzjDX
 N4tthCupPk0LJYpgCbThwpIWYS+Osbb253DZtWFtt0taGjEmAVD9gVDXLyRNah17ouCY
 bqFEEmtZ20a4e4lUF5e7u5m/HoP66We4Cy/yBUeL6/wOyqudetMKVNJWhHBNvOYrenoD
 dfUZMwG5lQ1Z9JpcBAhqACBPgf9gyyc/ckLiC4jx8s0/p+jSomcVqDQlGbiLynLpU5Le
 whwxM4yU3VvJyTzOt23pfcvap3T7EGxxA5XsK8rd8MqEvM11W3tl7Msrj/liuyf3VRT5 4Q== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 3429jmne92-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 09 Oct 2020 20:26:11 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 099KLI8t077637;
        Fri, 9 Oct 2020 20:24:11 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 3429kjsrxu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Oct 2020 20:24:11 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 099KOA4h029650;
        Fri, 9 Oct 2020 20:24:10 GMT
Received: from localhost (/10.159.132.239)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 09 Oct 2020 13:24:09 -0700
Date:   Fri, 9 Oct 2020 13:24:08 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Eric Whitney <enwlinux@gmail.com>
Cc:     Ritesh Harjani <riteshh@linux.ibm.com>, linux-ext4@vger.kernel.org,
        Jan Kara <jack@suse.cz>, "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: xfstests global-ext4/1k generic/219 failure due to dmesg warning
 of "circular locking dependency detected"
Message-ID: <20201009202408.GC6532@magnolia>
References: <2eb09d70-b56e-2c0b-8ef4-0479d7be2bb3@linux.ibm.com>
 <20201009201238.GA3444@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201009201238.GA3444@localhost.localdomain>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9769 signatures=668681
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=5 mlxscore=0 adultscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010090147
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9769 signatures=668681
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 suspectscore=5
 clxscore=1011 phishscore=0 lowpriorityscore=0 impostorscore=0
 malwarescore=0 mlxlogscore=999 priorityscore=1501 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010090147
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Oct 09, 2020 at 04:12:38PM -0400, Eric Whitney wrote:
> * Ritesh Harjani <riteshh@linux.ibm.com>:
> > Hello All,
> > 
> > While running generic/219 fstests on a 1k blocksize on x86 box, I see
> > below dmesg warning msg and generic/219 fails. I haven't yet analyzed
> > it, but I remember I have seen such warnings before as well in my testing.
> > I was wondering if others have also seen it in their testing or not and
> > if this is any known issue?
> > 
> > 
> > Here it goes, 219.dmesg file.
> > 
> > 
> > [14459.933253] run fstests generic/219 at 2020-10-08 20:03:27
> > [14462.947295] EXT4-fs (vdc): mounted filesystem with ordered data mode.
> > Opts: acl,user_xattr,block_validity,usrquota,grpquota
> > [14462.992869] EXT4-fs (vdc): re-mounted. Opts: (null)
> > [14463.017058] EXT4-fs (vdc): re-mounted. Opts: (null)
> > [14463.727095] EXT4-fs (vdc): mounted filesystem with ordered data mode.
> > Opts: usrquota
> > [14463.837130] EXT4-fs (vdc): re-mounted. Opts: (null)
> > [14463.874293] EXT4-fs (vdc): re-mounted. Opts: (null)
> > 
> > [14464.149407] ======================================================
> > [14464.149407] WARNING: possible circular locking dependency detected
> > [14464.149407] 5.9.0-rc8-next-20201008 #16 Not tainted
> > [14464.149407] ------------------------------------------------------
> > [14464.149407] chown/23358 is trying to acquire lock:
> > [14464.149407] ffff8b9b8ff60be0 (&ei->i_data_sem){++++}-{3:3}, at:
> > ext4_map_blocks+0xd1/0x640
> > [14464.149407]
> >                but task is already holding lock:
> > [14464.149407] ffff8b9b8963c208 (&s->s_dquot.dqio_sem){++++}-{3:3}, at:
> > v2_write_dquot+0x2d/0xb0
> > [14464.149407]
> >                which lock already depends on the new lock.
> > 
> > [14464.149407]
> >                the existing dependency chain (in reverse order) is:
> > [14464.149407]
> >                -> #2 (&s->s_dquot.dqio_sem){++++}-{3:3}:
> > [14464.149407]        down_read+0x41/0x200
> > [14464.149407]        v2_read_dquot+0x23/0x60
> > [14464.149407]        dquot_acquire+0x4c/0x100
> > [14464.149407]        ext4_acquire_dquot+0x72/0xc0
> > [14464.149407]        dqget+0x24a/0x4a0
> > [14464.149407]        __dquot_initialize+0x1f0/0x330
> > [14464.149407]        ext4_create+0x38/0x190
> > [14464.149407]        lookup_open+0x4cd/0x630
> > [14464.149407]        path_openat+0x2c4/0xa10
> > [14464.149407]        do_filp_open+0x91/0x100
> > [14464.149407]        do_sys_openat2+0x20d/0x2d0
> > [14464.149407]        do_sys_open+0x44/0x80
> > [14464.149407]        do_syscall_64+0x33/0x40
> > [14464.149407]        entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > [14464.149407]
> >                -> #1 (&dquot->dq_lock){+.+.}-{3:3}:
> > [14464.149407]        __mutex_lock+0xaa/0x9c0
> > [14464.149407]        dquot_commit+0x23/0xf0
> > [14464.149407]        ext4_write_dquot+0x78/0xb0
> > [14464.149407]        __dquot_alloc_space+0x151/0x310
> > [14464.149407]        ext4_mb_new_blocks+0x1f6/0x12e0
> > [14464.149407]        ext4_ext_map_blocks+0x9c3/0x1470
> > [14464.149407]        ext4_map_blocks+0xf4/0x640
> > [14464.149407]        _ext4_get_block+0x90/0x110
> > [14464.149407]        ext4_block_write_begin+0x15f/0x5a0
> > [14464.149407]        ext4_write_begin+0x267/0x5b0
> > [14464.149407]        generic_perform_write+0xc2/0x1e0
> > [14464.149407]        ext4_buffered_write_iter+0x8b/0x130
> > [14464.149407]        ext4_file_write_iter+0x6c/0x6d0
> > [14464.149407]        new_sync_write+0x122/0x1b0
> > [14464.149407]        vfs_write+0x1ca/0x230
> > [14464.149407]        ksys_pwrite64+0x68/0xa0
> > [14464.149407]        do_syscall_64+0x33/0x40
> > [14464.149407]        entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > [14464.149407]
> >                -> #0 (&ei->i_data_sem){++++}-{3:3}:
> > [14464.149407]        __lock_acquire+0x147b/0x2830
> > [14464.149407]        lock_acquire+0xc6/0x3a0
> > [14464.149407]        down_write+0x40/0x110
> > [14464.149407]        ext4_map_blocks+0xd1/0x640
> > [14464.149407]        ext4_getblk+0x54/0x1c0
> > [14464.149407]        ext4_bread+0x1f/0xd0
> > [14464.149407]        ext4_quota_write+0xbf/0x280
> > [14464.149407]        write_blk+0x35/0x70
> > [14464.149407]        get_free_dqblk+0x42/0xa0
> > [14464.149407]        do_insert_tree+0x1d6/0x480
> > [14464.149407]        do_insert_tree+0x464/0x480
> > [14464.149407]        do_insert_tree+0x218/0x480
> > [14464.149407]        do_insert_tree+0x218/0x480
> > [14464.149407]        qtree_write_dquot+0x79/0x1b0
> > [14464.149407]        v2_write_dquot+0x52/0xb0
> > [14464.149407]        dquot_acquire+0x8e/0x100
> > [14464.149407]        ext4_acquire_dquot+0x72/0xc0
> > [14464.149407]        dqget+0x24a/0x4a0
> > [14464.149407]        dquot_transfer+0xfe/0x140
> > [14464.149407]        ext4_setattr+0x134/0x9c0
> > [14464.149407]        notify_change+0x34b/0x490
> > [14464.149407]        chown_common+0x96/0x150
> > [14464.149407]        do_fchownat+0x8d/0xe0
> > [14464.149407]        __x64_sys_fchownat+0x21/0x30
> > [14464.149407]        do_syscall_64+0x33/0x40
> > [14464.149407]        entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > [14464.149407]
> >                other info that might help us debug this:
> > 
> > [14464.149407] Chain exists of:
> >                  &ei->i_data_sem --> &dquot->dq_lock -->
> > &s->s_dquot.dqio_sem
> > 
> > [14464.149407]  Possible unsafe locking scenario:
> > 
> > [14464.149407]        CPU0                    CPU1
> > [14464.149407]        ----                    ----
> > [14464.149407]   lock(&s->s_dquot.dqio_sem);
> > [14464.149407]                                lock(&dquot->dq_lock);
> > [14464.149407]                                lock(&s->s_dquot.dqio_sem);
> > [14464.149407]   lock(&ei->i_data_sem);

It's complaining that chown on a regular file takes i_data_sem, then
takes dq_lock to update the quotas, and then takes the i_data_sem of the
quota file.  This /should/ be harmless as long as quota files themselves
are not accounted for in the quota file, but you could also shut up
lockdep by doing something like:

	static struct lock_class_key ext4_dquot_lock_class;

and then when initializing the incore quota inodes:

	lockdep_set_class(&inode->i_data_sem, &ext4_dquot_lock_class);

That way lockdep always knows that the quota inodes are "special".  Even
better, I think this also means that lockdep actually /will/ call this
out specifically if someone screws up and tries to start a regular write
after taking the quota lock.

The downside is that now you have special inodes that are not like the
others.

--D

> > [14464.149407]
> >                 *** DEADLOCK ***
> > 
> > [14464.149407] 6 locks held by chown/23358:
> > [14464.149407]  #0: ffff8b9b8963c480 (sb_writers#3){++++}-{0:0}, at:
> > mnt_want_write+0x20/0x50
> > [14464.149407]  #1: ffff8b9b8ff64bc8
> > (&sb->s_type->i_mutex_key#9){++++}-{3:3}, at: chown_common+0x85/0x150
> > [14464.149407]  #2: ffff8b9b670c48d8 (jbd2_handle){++++}-{0:0}, at:
> > start_this_handle+0x1ad/0x690
> > [14464.149407]  #3: ffff8b9b8ff648d0 (&ei->xattr_sem){++++}-{3:3}, at:
> > ext4_setattr+0x129/0x9c0
> > [14464.149407]  #4: ffff8b9b1313f5f0 (&dquot->dq_lock){+.+.}-{3:3}, at:
> > dquot_acquire+0x23/0x100
> > [14464.149407]  #5: ffff8b9b8963c208 (&s->s_dquot.dqio_sem){++++}-{3:3}, at:
> > v2_write_dquot+0x2d/0xb0
> > [14464.149407]
> >                stack backtrace:
> > [14464.149407] CPU: 5 PID: 23358 Comm: chown Not tainted
> > 5.9.0-rc8-next-20201008 #16
> > [14464.149407] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> > 1.13.0-1ubuntu1 04/01/2014
> > [14464.149407] Call Trace:
> > [14464.149407]  dump_stack+0x77/0x97
> > [14464.149407]  check_noncircular+0x132/0x150
> > [14464.149407]  ? sched_clock_local+0x12/0x80
> > [14464.149407]  __lock_acquire+0x147b/0x2830
> > [14464.149407]  lock_acquire+0xc6/0x3a0
> > [14464.149407]  ? ext4_map_blocks+0xd1/0x640
> > [14464.149407]  down_write+0x40/0x110
> > [14464.149407]  ? ext4_map_blocks+0xd1/0x640
> > [14464.149407]  ext4_map_blocks+0xd1/0x640
> > [14464.149407]  ? sched_clock_local+0x12/0x80
> > [14464.149407]  ext4_getblk+0x54/0x1c0
> > [14464.149407]  ext4_bread+0x1f/0xd0
> > [14464.149407]  ext4_quota_write+0xbf/0x280
> > [14464.149407]  write_blk+0x35/0x70
> > [14464.149407]  get_free_dqblk+0x42/0xa0
> > [14464.149407]  do_insert_tree+0x1d6/0x480
> > [14464.149407]  ? ext4_quota_read+0x9d/0x110
> > [14464.149407]  do_insert_tree+0x464/0x480
> > [14464.149407]  ? ext4_quota_read+0x9d/0x110
> > [14464.149407]  do_insert_tree+0x218/0x480
> > [14464.149407]  ? ext4_quota_read+0x9d/0x110
> > [14464.149407]  do_insert_tree+0x218/0x480
> > [14464.149407]  ? __kmalloc+0x319/0x350
> > [14464.149407]  qtree_write_dquot+0x79/0x1b0
> > [14464.149407]  v2_write_dquot+0x52/0xb0
> > [14464.149407]  dquot_acquire+0x8e/0x100
> > [14464.149407]  ext4_acquire_dquot+0x72/0xc0
> > [14464.149407]  dqget+0x24a/0x4a0
> > [14464.149407]  dquot_transfer+0xfe/0x140
> > [14464.149407]  ext4_setattr+0x134/0x9c0
> > [14464.149407]  notify_change+0x34b/0x490
> > [14464.149407]  ? chown_common+0x96/0x150
> > [14464.149407]  chown_common+0x96/0x150
> > [14464.149407]  ? preempt_count_add+0x49/0xa0
> > [14464.149407]  do_fchownat+0x8d/0xe0
> > [14464.149407]  __x64_sys_fchownat+0x21/0x30
> > [14464.149407]  do_syscall_64+0x33/0x40
> > [14464.149407]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > [14464.149407] RIP: 0033:0x7efd3d2666ca
> > [14464.149407] Code: 48 8b 0d c9 f7 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 66
> > 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 49 89 ca b8 04 01 00 00 0f 05 <48>
> > 3d 01 f0 ff ff 73 01 c3 48 8b 0d 96 f7 0c 00 f7 d8 64 89 01 48
> > [14464.149407] RSP: 002b:00007ffdbe6ae418 EFLAGS: 00000206 ORIG_RAX:
> > 0000000000000104
> > [14464.149407] RAX: ffffffffffffffda RBX: 00007ffdbe6ae650 RCX:
> > 00007efd3d2666ca
> > [14464.149407] RDX: 0000000000007ab7 RSI: 00005598d654ef60 RDI:
> > 00000000ffffff9c
> > [14464.149407] RBP: 00000000ffffff9c R08: 0000000000000000 R09:
> > 00000000ffffffff
> > [14464.149407] R10: 00000000ffffffff R11: 0000000000000206 R12:
> > 00005598d654e1f0
> > [14464.149407] R13: 00005598d654e268 R14: 0000000000007ab7 R15:
> > 00000000ffffffff
> > [14465.070206] EXT4-fs (vdc): mounted filesystem with ordered data mode.
> > Opts: grpquota
> > [14465.165678] EXT4-fs (vdc): re-mounted. Opts: (null)
> > [14465.201132] EXT4-fs (vdc): re-mounted. Opts: (null)
> 
> Hi Ritesh:
> 
> I've seen that exact failure on 1k at least as far back as 5.0.  It fails
> on every 1k run for me using the test appliance.  I've been treating this
> as a "known problem, likely harmless, no fix likely anytime soon" for so long
> I unfortunately don't remember what the original analysis was.  IIRC,
> Jan Kara took a look at this one back when I first encountered it.
> 
> Eric
