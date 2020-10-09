Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9F1E288FFE
	for <lists+linux-ext4@lfdr.de>; Fri,  9 Oct 2020 19:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732152AbgJIR3z (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 9 Oct 2020 13:29:55 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:28922 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731996AbgJIR31 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 9 Oct 2020 13:29:27 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 099H1kAB105028;
        Fri, 9 Oct 2020 13:29:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=to : cc : from : subject
 : message-id : date : mime-version : content-type :
 content-transfer-encoding; s=pp1;
 bh=vR8EY0Sqz+XxE9v+PvH0iVTvWSXmGHsJNblzjPinpi8=;
 b=STKvYthk42qZ/LL+Aav7LmFf5aq+w7ub3DRyvHVdk/XVlcDYh4xsUmfMgcwUP1Tffdrx
 qWEFWVKB+M+WRKIjh18cosXDVe5CxdPl7uBYTjRHLCAknt5/HfX9UObYMrJk/9dSynb0
 9eyhsaXnWO6CJLhR8W4hQ5NvUChxLugrB26WJSWwwQXu+PaSDsEgsCOQaAHQ0NeIChfA
 Hh2s9Dmt5sqF3j9JX00WhyGhecwR34ChSUNGTfmFXsSJ6RNkSXunKpzx/obBnGHP6mYS
 P5h4x4L3185lCYQ+Z7ZvRL44/p1PdA1sjLhNDYp3lBUbSyKOphj0+wCMjuc2gWpTN3Q/ IQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 342uf29kru-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Oct 2020 13:29:20 -0400
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 099H2Hsg107016;
        Fri, 9 Oct 2020 13:29:20 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 342uf29krb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Oct 2020 13:29:20 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 099HBvpd000793;
        Fri, 9 Oct 2020 17:29:17 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04fra.de.ibm.com with ESMTP id 3429hs0edc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Oct 2020 17:29:17 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 099HTFJt19726790
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 9 Oct 2020 17:29:15 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 84B6342045;
        Fri,  9 Oct 2020 17:29:15 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8BE9B42041;
        Fri,  9 Oct 2020 17:29:14 +0000 (GMT)
Received: from [9.199.46.138] (unknown [9.199.46.138])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  9 Oct 2020 17:29:14 +0000 (GMT)
To:     linux-ext4@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>, Eric Whitney <enwlinux@gmail.com>,
        "Theodore Ts'o" <tytso@mit.edu>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Subject: xfstests global-ext4/1k generic/219 failure due to dmesg warning of
 "circular locking dependency detected"
Message-ID: <2eb09d70-b56e-2c0b-8ef4-0479d7be2bb3@linux.ibm.com>
Date:   Fri, 9 Oct 2020 22:59:13 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-09_08:2020-10-09,2020-10-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 clxscore=1015 mlxscore=0 mlxlogscore=999 suspectscore=3 malwarescore=0
 adultscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010090125
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello All,

While running generic/219 fstests on a 1k blocksize on x86 box, I see
below dmesg warning msg and generic/219 fails. I haven't yet analyzed
it, but I remember I have seen such warnings before as well in my testing.
I was wondering if others have also seen it in their testing or not and
if this is any known issue?


Here it goes, 219.dmesg file.


[14459.933253] run fstests generic/219 at 2020-10-08 20:03:27
[14462.947295] EXT4-fs (vdc): mounted filesystem with ordered data mode. 
Opts: acl,user_xattr,block_validity,usrquota,grpquota
[14462.992869] EXT4-fs (vdc): re-mounted. Opts: (null)
[14463.017058] EXT4-fs (vdc): re-mounted. Opts: (null)
[14463.727095] EXT4-fs (vdc): mounted filesystem with ordered data mode. 
Opts: usrquota
[14463.837130] EXT4-fs (vdc): re-mounted. Opts: (null)
[14463.874293] EXT4-fs (vdc): re-mounted. Opts: (null)

[14464.149407] ======================================================
[14464.149407] WARNING: possible circular locking dependency detected
[14464.149407] 5.9.0-rc8-next-20201008 #16 Not tainted
[14464.149407] ------------------------------------------------------
[14464.149407] chown/23358 is trying to acquire lock:
[14464.149407] ffff8b9b8ff60be0 (&ei->i_data_sem){++++}-{3:3}, at: 
ext4_map_blocks+0xd1/0x640
[14464.149407]
                but task is already holding lock:
[14464.149407] ffff8b9b8963c208 (&s->s_dquot.dqio_sem){++++}-{3:3}, at: 
v2_write_dquot+0x2d/0xb0
[14464.149407]
                which lock already depends on the new lock.

[14464.149407]
                the existing dependency chain (in reverse order) is:
[14464.149407]
                -> #2 (&s->s_dquot.dqio_sem){++++}-{3:3}:
[14464.149407]        down_read+0x41/0x200
[14464.149407]        v2_read_dquot+0x23/0x60
[14464.149407]        dquot_acquire+0x4c/0x100
[14464.149407]        ext4_acquire_dquot+0x72/0xc0
[14464.149407]        dqget+0x24a/0x4a0
[14464.149407]        __dquot_initialize+0x1f0/0x330
[14464.149407]        ext4_create+0x38/0x190
[14464.149407]        lookup_open+0x4cd/0x630
[14464.149407]        path_openat+0x2c4/0xa10
[14464.149407]        do_filp_open+0x91/0x100
[14464.149407]        do_sys_openat2+0x20d/0x2d0
[14464.149407]        do_sys_open+0x44/0x80
[14464.149407]        do_syscall_64+0x33/0x40
[14464.149407]        entry_SYSCALL_64_after_hwframe+0x44/0xa9
[14464.149407]
                -> #1 (&dquot->dq_lock){+.+.}-{3:3}:
[14464.149407]        __mutex_lock+0xaa/0x9c0
[14464.149407]        dquot_commit+0x23/0xf0
[14464.149407]        ext4_write_dquot+0x78/0xb0
[14464.149407]        __dquot_alloc_space+0x151/0x310
[14464.149407]        ext4_mb_new_blocks+0x1f6/0x12e0
[14464.149407]        ext4_ext_map_blocks+0x9c3/0x1470
[14464.149407]        ext4_map_blocks+0xf4/0x640
[14464.149407]        _ext4_get_block+0x90/0x110
[14464.149407]        ext4_block_write_begin+0x15f/0x5a0
[14464.149407]        ext4_write_begin+0x267/0x5b0
[14464.149407]        generic_perform_write+0xc2/0x1e0
[14464.149407]        ext4_buffered_write_iter+0x8b/0x130
[14464.149407]        ext4_file_write_iter+0x6c/0x6d0
[14464.149407]        new_sync_write+0x122/0x1b0
[14464.149407]        vfs_write+0x1ca/0x230
[14464.149407]        ksys_pwrite64+0x68/0xa0
[14464.149407]        do_syscall_64+0x33/0x40
[14464.149407]        entry_SYSCALL_64_after_hwframe+0x44/0xa9
[14464.149407]
                -> #0 (&ei->i_data_sem){++++}-{3:3}:
[14464.149407]        __lock_acquire+0x147b/0x2830
[14464.149407]        lock_acquire+0xc6/0x3a0
[14464.149407]        down_write+0x40/0x110
[14464.149407]        ext4_map_blocks+0xd1/0x640
[14464.149407]        ext4_getblk+0x54/0x1c0
[14464.149407]        ext4_bread+0x1f/0xd0
[14464.149407]        ext4_quota_write+0xbf/0x280
[14464.149407]        write_blk+0x35/0x70
[14464.149407]        get_free_dqblk+0x42/0xa0
[14464.149407]        do_insert_tree+0x1d6/0x480
[14464.149407]        do_insert_tree+0x464/0x480
[14464.149407]        do_insert_tree+0x218/0x480
[14464.149407]        do_insert_tree+0x218/0x480
[14464.149407]        qtree_write_dquot+0x79/0x1b0
[14464.149407]        v2_write_dquot+0x52/0xb0
[14464.149407]        dquot_acquire+0x8e/0x100
[14464.149407]        ext4_acquire_dquot+0x72/0xc0
[14464.149407]        dqget+0x24a/0x4a0
[14464.149407]        dquot_transfer+0xfe/0x140
[14464.149407]        ext4_setattr+0x134/0x9c0
[14464.149407]        notify_change+0x34b/0x490
[14464.149407]        chown_common+0x96/0x150
[14464.149407]        do_fchownat+0x8d/0xe0
[14464.149407]        __x64_sys_fchownat+0x21/0x30
[14464.149407]        do_syscall_64+0x33/0x40
[14464.149407]        entry_SYSCALL_64_after_hwframe+0x44/0xa9
[14464.149407]
                other info that might help us debug this:

[14464.149407] Chain exists of:
                  &ei->i_data_sem --> &dquot->dq_lock --> 
&s->s_dquot.dqio_sem

[14464.149407]  Possible unsafe locking scenario:

[14464.149407]        CPU0                    CPU1
[14464.149407]        ----                    ----
[14464.149407]   lock(&s->s_dquot.dqio_sem);
[14464.149407]                                lock(&dquot->dq_lock);
[14464.149407]                                lock(&s->s_dquot.dqio_sem);
[14464.149407]   lock(&ei->i_data_sem);
[14464.149407]
                 *** DEADLOCK ***

[14464.149407] 6 locks held by chown/23358:
[14464.149407]  #0: ffff8b9b8963c480 (sb_writers#3){++++}-{0:0}, at: 
mnt_want_write+0x20/0x50
[14464.149407]  #1: ffff8b9b8ff64bc8 
(&sb->s_type->i_mutex_key#9){++++}-{3:3}, at: chown_common+0x85/0x150
[14464.149407]  #2: ffff8b9b670c48d8 (jbd2_handle){++++}-{0:0}, at: 
start_this_handle+0x1ad/0x690
[14464.149407]  #3: ffff8b9b8ff648d0 (&ei->xattr_sem){++++}-{3:3}, at: 
ext4_setattr+0x129/0x9c0
[14464.149407]  #4: ffff8b9b1313f5f0 (&dquot->dq_lock){+.+.}-{3:3}, at: 
dquot_acquire+0x23/0x100
[14464.149407]  #5: ffff8b9b8963c208 (&s->s_dquot.dqio_sem){++++}-{3:3}, 
at: v2_write_dquot+0x2d/0xb0
[14464.149407]
                stack backtrace:
[14464.149407] CPU: 5 PID: 23358 Comm: chown Not tainted 
5.9.0-rc8-next-20201008 #16
[14464.149407] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), 
BIOS 1.13.0-1ubuntu1 04/01/2014
[14464.149407] Call Trace:
[14464.149407]  dump_stack+0x77/0x97
[14464.149407]  check_noncircular+0x132/0x150
[14464.149407]  ? sched_clock_local+0x12/0x80
[14464.149407]  __lock_acquire+0x147b/0x2830
[14464.149407]  lock_acquire+0xc6/0x3a0
[14464.149407]  ? ext4_map_blocks+0xd1/0x640
[14464.149407]  down_write+0x40/0x110
[14464.149407]  ? ext4_map_blocks+0xd1/0x640
[14464.149407]  ext4_map_blocks+0xd1/0x640
[14464.149407]  ? sched_clock_local+0x12/0x80
[14464.149407]  ext4_getblk+0x54/0x1c0
[14464.149407]  ext4_bread+0x1f/0xd0
[14464.149407]  ext4_quota_write+0xbf/0x280
[14464.149407]  write_blk+0x35/0x70
[14464.149407]  get_free_dqblk+0x42/0xa0
[14464.149407]  do_insert_tree+0x1d6/0x480
[14464.149407]  ? ext4_quota_read+0x9d/0x110
[14464.149407]  do_insert_tree+0x464/0x480
[14464.149407]  ? ext4_quota_read+0x9d/0x110
[14464.149407]  do_insert_tree+0x218/0x480
[14464.149407]  ? ext4_quota_read+0x9d/0x110
[14464.149407]  do_insert_tree+0x218/0x480
[14464.149407]  ? __kmalloc+0x319/0x350
[14464.149407]  qtree_write_dquot+0x79/0x1b0
[14464.149407]  v2_write_dquot+0x52/0xb0
[14464.149407]  dquot_acquire+0x8e/0x100
[14464.149407]  ext4_acquire_dquot+0x72/0xc0
[14464.149407]  dqget+0x24a/0x4a0
[14464.149407]  dquot_transfer+0xfe/0x140
[14464.149407]  ext4_setattr+0x134/0x9c0
[14464.149407]  notify_change+0x34b/0x490
[14464.149407]  ? chown_common+0x96/0x150
[14464.149407]  chown_common+0x96/0x150
[14464.149407]  ? preempt_count_add+0x49/0xa0
[14464.149407]  do_fchownat+0x8d/0xe0
[14464.149407]  __x64_sys_fchownat+0x21/0x30
[14464.149407]  do_syscall_64+0x33/0x40
[14464.149407]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[14464.149407] RIP: 0033:0x7efd3d2666ca
[14464.149407] Code: 48 8b 0d c9 f7 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 
66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 49 89 ca b8 04 01 00 00 0f 
05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 96 f7 0c 00 f7 d8 64 89 01 48
[14464.149407] RSP: 002b:00007ffdbe6ae418 EFLAGS: 00000206 ORIG_RAX: 
0000000000000104
[14464.149407] RAX: ffffffffffffffda RBX: 00007ffdbe6ae650 RCX: 
00007efd3d2666ca
[14464.149407] RDX: 0000000000007ab7 RSI: 00005598d654ef60 RDI: 
00000000ffffff9c
[14464.149407] RBP: 00000000ffffff9c R08: 0000000000000000 R09: 
00000000ffffffff
[14464.149407] R10: 00000000ffffffff R11: 0000000000000206 R12: 
00005598d654e1f0
[14464.149407] R13: 00005598d654e268 R14: 0000000000007ab7 R15: 
00000000ffffffff
[14465.070206] EXT4-fs (vdc): mounted filesystem with ordered data mode. 
Opts: grpquota
[14465.165678] EXT4-fs (vdc): re-mounted. Opts: (null)
[14465.201132] EXT4-fs (vdc): re-mounted. Opts: (null)
