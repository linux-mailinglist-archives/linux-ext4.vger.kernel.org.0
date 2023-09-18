Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07CC57A4C57
	for <lists+linux-ext4@lfdr.de>; Mon, 18 Sep 2023 17:32:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbjIRPcG (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 18 Sep 2023 11:32:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjIRPbi (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 18 Sep 2023 11:31:38 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DB791994
        for <linux-ext4@vger.kernel.org>; Mon, 18 Sep 2023 08:27:21 -0700 (PDT)
Received: from [IPV6:2405:201:0:21ea:c864:4cd9:1f5b:db3a] (unknown [IPv6:2405:201:0:21ea:c864:4cd9:1f5b:db3a])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: shreeya)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 9036C66072AC;
        Mon, 18 Sep 2023 15:43:34 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1695048216;
        bh=XJWXS1HiqrcE3E4O2h3/WZVihjNmqlDKeII8m48mxtc=;
        h=Date:From:Subject:To:Cc:From;
        b=ZTTu79CRBpGBrZBtKuruLU4vV5YBdedj6E6HfHDqVI7+1flnXj1DRAxf9vaJnbScS
         pBlVPcO1VpEZUL/uptZnkDuQefboZvNa3M6EIBzVJni5hPjTxXJiaWeNDx5YJOBZz1
         WqB5Mqen3vjrmomYBkDjdlYv8e6UjIu+Hg52Na2gbOg4XIVPPbQ5D/QKBk2na9bfyC
         xjgtotwRLzYXm1jlYCn6ivvEx2yXd1QfI4AexXDC6F69iH3uIDa1sTUaAIYhER6gVi
         3hhR8UHASCyDh2Bx2l4ErBjkcDPg/hr3nDbJhKWVq572BE7HVw4IMe3idlZ3qp2iwz
         LAsxneM23O7fg==
Content-Type: multipart/mixed; boundary="------------0jeaIqpEGzlzS2PBRHSLwsZn"
Message-ID: <d89989ef-e53b-050e-2916-a4f06433798b@collabora.com>
Date:   Mon, 18 Sep 2023 20:13:30 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Content-Language: en-US
From:   Shreeya Patel <shreeya.patel@collabora.com>
Subject: [syzbot] INFO: task hung in ext4_fallocate
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu,
        =?UTF-8?Q?Ricardo_Ca=c3=b1uelo?= <ricardo.canuelo@collabora.com>,
        "gustavo.padovan@collabora.com" <gustavo.padovan@collabora.com>,
        groeck@google.com, zsm@google.com, garrick@google.com,
        Linux regressions mailing list <regressions@lists.linux.dev>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This is a multi-part message in MIME format.
--------------0jeaIqpEGzlzS2PBRHSLwsZn
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Everyone,

syzbot has reported a task hung issue in ext4_fallocate, crash report 
can be seen at the bottom of the email.

When I tried to reproduce this issue on mainline linux kernel using the 
reproducer provided by syzbot, I see an endless loop of following errors :-

[   89.689751][ T3922] loop1: detected capacity change from 0 to 512
[   89.690514][ T3916] EXT4-fs error (device loop4): 
ext4_map_blocks:577: inode #3: block 9: comm poc: lblock 0 mapped to 
illegal pblock 9 (length 1)
[   89.694709][ T3890] EXT4-fs error (device loop0): 
ext4_map_blocks:577: inode #3: block 9: comm poc: lblock 0 mapped to 
illegal pblock 9 (length 1)
[   89.697306][ T3896] EXT4-fs (loop5): 1 orphan inode deleted
[   89.700797][ T3890] EXT4-fs error (device loop0) in 
ext4_reserve_inode_write:5752: Out of memory
[   89.703072][ T3916] EXT4-fs error (device loop4) in 
ext4_reserve_inode_write:5752: Out of memory
[   89.704703][ T3913] loop3: detected capacity change from 0 to 512
[   89.706535][ T3896] ext4 filesystem being mounted at 
/root/syzkaller.eGkqPu/22/file1 supports timestamps until 2038-01-19 
(0x7fffffff)
[   89.712664][ T3890] EXT4-fs error (device loop0): 
ext4_dirty_inode:5956: inode #16: comm poc: mark_inode_dirty error
[   89.717990][ T3916] EXT4-fs error (device loop4): 
ext4_dirty_inode:5956: inode #16: comm poc: mark_inode_dirty error
[   89.720967][ T3890] EXT4-fs error (device loop0) in 
ext4_reserve_inode_write:5752: Out of memory
[   89.725410][ T3916] EXT4-fs error (device loop4): 
ext4_map_blocks:577: inode #3: block 9: comm poc: lblock 0 mapped to 
illegal pblock 9 (length 1)
[   89.732045][ T3896] EXT4-fs error (device loop5): 
ext4_map_blocks:577: inode #3: block 9: comm poc: lblock 0 mapped to 
illegal pblock 9 (length 1)
[   89.752554][ T3890] EXT4-fs error (device loop0): 
ext4_alloc_file_blocks:4468: inode #16: comm poc: mark_inode_dirty error

Same is seen with the LTS and chromeOS 5.10, 5.15 kernel. In case I add 
some debugging statements in the ext4_fallocate function, they are all 
printed endlessly too.
I am not sure if an infinite loop is also termed as task hung but it 
would be great if someone expert in fixing filesystem issues take a look 
into this.
I am attaching the reproducer and config file in case anyone wants to 
test it locally.

Please reach out in case you need any additional details to reproduce this.

Thanks,
Shreeya Patel

#regzbot introduced: v6.6-rc1..

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
syzbot report :-

(A) The crash report from June 15, 2023:

INFO: task syz-executor319:5195 blocked for more than 143 seconds.
Not tainted 5.10.184-syzkaller-22756-g4d841d608c1b #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor319 state:D stack: 0 pid: 5195 ppid: 2015 flags:0x00000004
Call Trace:
context_switch kernel/sched/core.c:4197 [inline]
__schedule+0x210d/0x21ae kernel/sched/core.c:5408
schedule+0x168/0x1cc kernel/sched/core.c:5486
rwsem_down_write_slowpath+0x4e3/0x867 kernel/locking/rwsem.c:1235
__down_write+0x99/0xd0 kernel/locking/rwsem.c:1401
inode_lock include/linux/fs.h:776 [inline]
ext4_fallocate+0x181/0x255e fs/ext4/extents.c:4697
vfs_fallocate+0x5a6/0x687 fs/open.c:312
ksys_fallocate+0x5a/0x8c fs/open.c:335
__do_sys_fallocate fs/open.c:343 [inline]
__se_sys_fallocate fs/open.c:341 [inline]
__x64_sys_fallocate+0xa7/0xb0 fs/open.c:341
do_syscall_64+0x33/0x40 arch/x86/entry/common.c:51
entry_SYSCALL_64_after_hwframe+0x61/0xc6
RIP: 0033:0x7fb2b203f0c9
RSP: 002b:00007fb2a9c092f8 EFLAGS: 00000246 ORIG_RAX: 000000000000011d
RAX: ffffffffffffffda RBX: 00007fb2b20c67b0 RCX: 00007fb2b203f0c9
RDX: 0000000000008947 RSI: 0000000000000000 RDI: 0000000000000004
RBP: 00007fb2b20927bc R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000007 R11: 0000000000000246 R12: 00007fb2b20917b8
R13: 0031656c69662f2e R14: 6f6f6c2f7665642f R15: 00007fb2b20c67b8

Showing all locks held in the system:
1 lock held by khungtaskd/839:
#0: ffffffff86cc1720 (rcu_read_lock){....}-{1:2}, at: rcu_lock_release 
include/linux/rcupdate.h:271 [inline]
#0: ffffffff86cc1720 (rcu_read_lock){....}-{1:2}, at: 
rcu_lock_acquire.constprop.0+0x0/0x22 include/linux/rcupdate.h:720
2 locks held by getty/1961:
#0: ffff88810ec85098 (&tty->ldisc_sem){++++}-{0:0}, at: 
tty_ldisc_ref_wait+0x22/0x6a drivers/tty/tty_ldisc.c:267
#1: ffffc900000532e8 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: 
n_tty_read+0x599/0xed7 drivers/tty/n_tty.c:2209
1 lock held by syz-executor319/2018:
1 lock held by syz-executor319/2019:
1 lock held by udevd/2036:
2 locks held by kworker/u4:4/3020:
#0: ffff888100071138 ((wq_completion)events_unbound){+.+.}-{0:0}, at: 
process_one_work+0x4fe/0xad5 kernel/workqueue.c:2250
#1: ffff8881f6b27908 (&per_cpu_ptr(group->pcpu, cpu)->seq){-.-.}-{0:0}, 
at: write_seqcount_t_begin include/linux/seqlock.h:541 [inline]
#1: ffff8881f6b27908 (&per_cpu_ptr(group->pcpu, cpu)->seq){-.-.}-{0:0}, 
at: psi_group_change+0xa6/0x676 kernel/sched/psi.c:711
3 locks held by kworker/1:5/4866:
#0: ffff888100052938 ((wq_completion)events){+.+.}-{0:0}, at: 
process_one_work+0x4fe/0xad5 kernel/workqueue.c:2250
#1: ffffc90006ec7df0 
((work_completion)(&pwq->unbound_release_work)){+.+.}-{0:0}, at: 
process_one_work+0x544/0xad5 kernel/workqueue.c:2254
#2: ffffffff86cc9ae8 (rcu_state.exp_mutex){+.+.}-{3:3}, at: 
exp_funnel_lock kernel/rcu/tree_exp.h:290 [inline]
#2: ffffffff86cc9ae8 (rcu_state.exp_mutex){+.+.}-{3:3}, at: 
synchronize_rcu_expedited+0x238/0x4fd kernel/rcu/tree_exp.h:841
7 locks held by syz-executor319/5177:
2 locks held by syz-executor319/5195:
#0: ffff888119b6c450 (sb_writers#5){.+.+}-{0:0}, at: __sb_start_write 
include/linux/fs.h:1651 [inline]
#0: ffff888119b6c450 (sb_writers#5){.+.+}-{0:0}, at: sb_start_write 
include/linux/fs.h:1721 [inline]
#0: ffff888119b6c450 (sb_writers#5){.+.+}-{0:0}, at: file_start_write 
include/linux/fs.h:2855 [inline]
#0: ffff888119b6c450 (sb_writers#5){.+.+}-{0:0}, at: 
vfs_fallocate+0x547/0x687 fs/open.c:311
#1:
ffff88811f7cc058
(
&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: inode_lock 
include/linux/fs.h:776 [inline]
&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: ext4_fallocate+0x181/0x255e 
fs/ext4/extents.c:4697
4 locks held by syz-executor319/8626:
#0:
ffff88810e02e450
(
sb_writers
#5
){.+.+}-{0:0}
, at: __sb_start_write include/linux/fs.h:1651 [inline]
, at: sb_start_write include/linux/fs.h:1721 [inline]
, at: mnt_want_write+0x3e/0x97 fs/namespace.c:355
#1: ffff88811f8cf230 (&sb->s_type->i_mutex_key#8
){++++}-{3:3}, at: inode_lock include/linux/fs.h:776 [inline]
){++++}-{3:3}, at: do_truncate+0x13d/0x1c9 fs/open.c:65
#2: ffff88811f8cf0b8 (
&ei->i_mmap_sem){++++}-{3:3}, at: ext4_setattr+0xcc3/0x1752 
fs/ext4/inode.c:5561
#3:
ffff88811f8cf020 (&ei->i_data_sem){++++}-{3:3}, at: 
ext4_truncate+0x761/0xb6a fs/ext4/inode.c:4353
2 locks held by syz-executor319/8633:
#0: ffff88810e02e450 (sb_writers#5){.+.+}-{0:0}, at: __sb_start_write 
include/linux/fs.h:1651 [inline]
#0: ffff88810e02e450 (sb_writers#5){.+.+}-{0:0}, at: sb_start_write 
include/linux/fs.h:1721 [inline]
#0: ffff88810e02e450 (sb_writers#5){.+.+}-{0:0}, at: file_start_write 
include/linux/fs.h:2855 [inline]
#0: ffff88810e02e450 (sb_writers#5){.+.+}-{0:0}, at: 
vfs_fallocate+0x547/0x687 fs/open.c:311
#1: ffff88811f8cf230 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: 
inode_lock include/linux/fs.h:776 [inline]
#1: ffff88811f8cf230 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: 
ext4_fallocate+0x181/0x255e fs/ext4/extents.c:4697
4 locks held by syz-executor319/8677:
#0: ffff88810ec98450 (sb_writers#5){.+.+}-{0:0}, at: __sb_start_write 
include/linux/fs.h:1651 [inline]
#0: ffff88810ec98450 (sb_writers#5){.+.+}-{0:0}, at: sb_start_write 
include/linux/fs.h:1721 [inline]
#0: ffff88810ec98450 (sb_writers#5){.+.+}-{0:0}, at: 
mnt_want_write+0x3e/0x97 fs/namespace.c:355
#1: ffff88811f9f8e80 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: 
inode_lock include/linux/fs.h:776 [inline]
#1: ffff88811f9f8e80 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: 
do_truncate+0x13d/0x1c9 fs/open.c:65
#2: ffff88811f9f8d08 (&ei->i_mmap_sem){++++}-{3:3}, at: 
ext4_setattr+0xcc3/0x1752 fs/ext4/inode.c:5561
#3: ffff88811f9f8c70 (&ei->i_data_sem){++++}-{3:3}, at: 
ext4_truncate+0x761/0xb6a fs/ext4/inode.c:4353
2 locks held by syz-executor319/8687:
#0: ffff88810ec98450 (sb_writers#5){.+.+}-{0:0}, at: __sb_start_write 
include/linux/fs.h:1651 [inline]
#0: ffff88810ec98450 (sb_writers#5){.+.+}-{0:0}, at: sb_start_write 
include/linux/fs.h:1721 [inline]
#0: ffff88810ec98450 (sb_writers#5){.+.+}-{0:0}, at: file_start_write 
include/linux/fs.h:2855 [inline]
#0: ffff88810ec98450 (sb_writers#5){.+.+}-{0:0}, at: 
vfs_fallocate+0x547/0x687 fs/open.c:311
#1: ffff88811f9f8e80 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: 
inode_lock include/linux/fs.h:776 [inline]
#1: ffff88811f9f8e80 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: 
ext4_fallocate+0x181/0x255e fs/ext4/extents.c:4697
2 locks held by udevd/8902:
#0: ffff888106438080 (&bdev->bd_mutex){+.+.}-{3:3}, at: 
__blkdev_put+0x101/0x500 fs/block_dev.c:1793
#1: ffffffff8740b8a8 (loop_ctl_mutex){+.+.}-{3:3}, at: 
__loop_clr_fd+0x8d/0x913 drivers/block/loop.c:1207
4 locks held by syz-executor319/11374:
#0: ffff888105f16450 (sb_writers#5){.+.+}-{0:0}, at: __sb_start_write 
include/linux/fs.h:1651 [inline]
#0: ffff888105f16450 (sb_writers#5){.+.+}-{0:0}, at: sb_start_write 
include/linux/fs.h:1721 [inline]
#0: ffff888105f16450 (sb_writers#5){.+.+}-{0:0}, at: 
mnt_want_write+0x3e/0x97 fs/namespace.c:355
#1: ffff88811facde40 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: 
inode_lock include/linux/fs.h:776 [inline]
#1: ffff88811facde40 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: 
do_truncate+0x13d/0x1c9 fs/open.c:65
#2: ffff88811facdcc8 (&ei->i_mmap_sem){++++}-{3:3}, at: 
ext4_setattr+0xcc3/0x1752 fs/ext4/inode.c:5561
#3: ffff88811facdc30 (&ei->i_data_sem){++++}-{3:3}, at: 
ext4_truncate+0x761/0xb6a fs/ext4/inode.c:4353
2 locks held by syz-executor319/11384:
#0: ffff888105f16450 (sb_writers#5){.+.+}-{0:0}, at: __sb_start_write 
include/linux/fs.h:1651 [inline]
#0: ffff888105f16450 (sb_writers#5){.+.+}-{0:0}, at: sb_start_write 
include/linux/fs.h:1721 [inline]
#0: ffff888105f16450 (sb_writers#5){.+.+}-{0:0}, at: file_start_write 
include/linux/fs.h:2855 [inline]
#0: ffff888105f16450 (sb_writers#5){.+.+}-{0:0}, at: 
vfs_fallocate+0x547/0x687 fs/open.c:311
#1: ffff88811facde40 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: 
inode_lock include/linux/fs.h:776 [inline]
#1: ffff88811facde40 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: 
ext4_fallocate+0x181/0x255e fs/ext4/extents.c:4697
2 locks held by syz-executor319/12502:
#0: ffff88810643ef00 (&bdev->bd_mutex){+.+.}-{3:3}, at: 
__blkdev_get+0x21f/0xd64 fs/block_dev.c:1503
#1: ffffffff8740b8a8 (loop_ctl_mutex){+.+.}-{3:3}, at: lo_open+0x19/0xc6 
drivers/block/loop.c:1890
1 lock held by syz-executor319/12503:
#0: ffff888106438080 (&bdev->bd_mutex){+.+.}-{3:3}, at: 
__blkdev_get+0x21f/0xd64 fs/block_dev.c:1503

=============================================

NMI backtrace for cpu 0
CPU: 0 PID: 839 Comm: khungtaskd Not tainted 
5.10.184-syzkaller-22756-g4d841d608c1b #0 
809c46235bb373ae9b9e9418415172972c181155
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS 
Google 05/27/2023
Call Trace:
__dump_stack lib/dump_stack.c:86 [inline]
dump_stack+0x107/0x163 lib/dump_stack.c:127
nmi_cpu_backtrace+0x11f/0x13d lib/nmi_backtrace.c:105
nmi_trigger_cpumask_backtrace+0xd1/0x1b4 lib/nmi_backtrace.c:62
trigger_all_cpu_backtrace include/linux/nmi.h:159 [inline]
check_hung_uninterruptible_tasks kernel/hung_task.c:209 [inline]
watchdog+0xa64/0xaef kernel/hung_task.c:296
kthread+0x346/0x35a kernel/kthread.c:313
ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:299
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 PID: 11374 Comm: syz-executor319 Not tainted 
5.10.184-syzkaller-22756-g4d841d608c1b #0 
809c46235bb373ae9b9e9418415172972c181155
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS 
Google 05/27/2023
RIP: 0010:test_bit+0x28/0x2e 
include/asm-generic/bitops/instrumented-non-atomic.h:136
Code: 5d c3 48 89 f8 b9 40 00 00 00 55 48 89 f5 48 99 53 48 89 fb 48 f7 
f9 48 8d 3c c6 be 08 00 00 00 e8 b1 c8 3a 00 48 0f a3 5d 00 <5b> 0f 92 
c0 5d c3 41 57 41 56 41 89 d6 41 55 49 89 f5 41 54 55 8d
RSP: 0018:ffffc900057a6990 EFLAGS: 00000047
RAX: fffffbfff0fa9701 RBX: 0000000000000001 RCX: fffffbfff0fa9800
RDX: fffffbfff0fa9800 RSI: 0000000000000008 RDI: ffffffff87d4bff8
RBP: ffffffff87d4bff8 R08: fffffbfff0fa9800 R09: ffffffff87d4bfff
R10: 0000000000000000 R11: ffffffff813918e5 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
FS: 00007fb2b1fea700(0000) GS:ffff8881f6b00000(0000) knlGS:0000000000000000
CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fb2a9c09000 CR3: 00000001198fd000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
<NMI>
</NMI>
cpumask_test_cpu.constprop.0+0x15/0x19 include/linux/cpumask.h:367
trace_lock_acquire include/trace/events/lock.h:13 [inline]
lock_acquire+0x11e/0x3b7 kernel/locking/lockdep.c:5537
write_seqcount_t_begin_nested.constprop.0+0x42/0x45 
include/linux/seqlock.h:515
write_seqcount_t_begin include/linux/seqlock.h:541 [inline]
psi_group_change+0xa6/0x676 kernel/sched/psi.c:711
psi_task_change+0x143/0x17a kernel/sched/psi.c:812
psi_enqueue kernel/sched/stats.h:82 [inline]
enqueue_task+0x1c4/0x242 kernel/sched/core.c:1942
activate_task+0x50/0x81 kernel/sched/core.c:1974
ttwu_do_activate+0x161/0x17c kernel/sched/core.c:2892
ttwu_queue kernel/sched/core.c:3089 [inline]
try_to_wake_up+0x5a7/0x9e6 kernel/sched/core.c:3367
wake_up_worker+0x70/0x77 kernel/workqueue.c:838
insert_work+0xc7/0xd4 kernel/workqueue.c:1353
__queue_work+0x99e/0x9e1 kernel/workqueue.c:1504
__queue_delayed_work+0xf7/0x1ef kernel/workqueue.c:1651
mod_delayed_work_on+0xb9/0x138 kernel/workqueue.c:1725
kblockd_mod_delayed_work_on+0x2a/0x33 block/blk-core.c:1660
blk_mq_add_to_requeue_list+0x14c/0x15f block/blk-mq.c:844
blk_flush_queue_rq block/blk-flush.c:137 [inline]
blk_flush_complete_seq+0x184/0x851 block/blk-flush.c:192
blk_insert_flush+0x3c7/0x3dc block/blk-flush.c:443
blk_mq_submit_bio+0xa78/0xfb7 block/blk-mq.c:2207
__submit_bio_noacct_mq block/blk-core.c:1017 [inline]
submit_bio_noacct+0x2a3/0x6fe block/blk-core.c:1050
submit_bio+0x457/0x4a8 block/blk-core.c:1120
submit_bh_wbc+0x604/0x615 fs/buffer.c:3054
__sync_dirty_buffer+0x110/0x189 fs/buffer.c:3155
ext4_commit_super+0x8f1/0x98d fs/ext4/super.c:5569
save_error_info+0x93/0x9e fs/ext4/super.c:628
__ext4_std_error+0x1f9/0x242 fs/ext4/super.c:841
ext4_reserve_inode_write+0x188/0x19b fs/ext4/inode.c:5889
__ext4_mark_inode_dirty+0x251/0x5b6 fs/ext4/inode.c:6055
__ext4_ext_dirty+0x160/0x177 fs/ext4/extents.c:182
ext4_ext_remove_space+0x2984/0x2a32 fs/ext4/extents.c:3056
ext4_ext_truncate+0x1ab/0x1f7 fs/ext4/extents.c:4413
ext4_truncate+0x7a2/0xb6a fs/ext4/inode.c:4358
ext4_setattr+0x15c1/0x1752 fs/ext4/inode.c:5638
notify_change+0xb57/0xdf2 fs/attr.c:394
do_truncate+0x14c/0x1c9 fs/open.c:67
handle_truncate fs/namei.c:3066 [inline]
do_open fs/namei.c:3407 [inline]
path_openat+0x1933/0x197a fs/namei.c:3521
do_filp_open+0xc2/0x156 fs/namei.c:3548
do_sys_openat2+0x113/0x36a fs/open.c:1189
do_sys_open+0x8d/0xc1 fs/open.c:1206
do_syscall_64+0x33/0x40 arch/x86/entry/common.c:51
entry_SYSCALL_64_after_hwframe+0x61/0xc6
RIP: 0033:0x7fb2b203f0c9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 b1 15 00 00 90 48 89 f8 48 89 
f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 
f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fb2b1fea2f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 00007fb2b20c67a0 RCX: 00007fb2b203f0c9
RDX: 0000000000000000 RSI: 000000000014d27e RDI: 0000000020000180
RBP: 00007fb2b20927bc R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fb2b20917b8
R13: 0031656c69662f2e R14: 6f6f6c2f7665642f R15: 00007fb2b20c67a8
INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 
3.489 msecs
task:udevd state:D stack: 0 pid: 2036 ppid: 1881 flags:0x00000002
Call Trace:
context_switch kernel/sched/core.c:4197 [inline]
__schedule+0x210d/0x21ae kernel/sched/core.c:5408
schedule+0x168/0x1cc kernel/sched/core.c:5486
schedule_preempt_disabled+0xf/0x1a kernel/sched/core.c:5545
__mutex_lock_common kernel/locking/mutex.c:1047 [inline]
__mutex_lock+0x37c/0x690 kernel/locking/mutex.c:1109
__blkdev_get+0x21f/0xd64 fs/block_dev.c:1503
blkdev_get+0xcc/0x1eb fs/block_dev.c:1658
blkdev_open+0x22e/0x247 fs/block_dev.c:1775
do_dentry_open+0x6e5/0xbe3 fs/open.c:820
do_open fs/namei.c:3403 [inline]
path_openat+0x1689/0x197a fs/namei.c:3521
do_filp_open+0xc2/0x156 fs/namei.c:3548
do_sys_openat2+0x113/0x36a fs/open.c:1189
do_sys_open+0x8d/0xc1 fs/open.c:1206
do_syscall_64+0x33/0x40 arch/x86/entry/common.c:51
entry_SYSCALL_64_after_hwframe+0x61/0xc6
RIP: 0033:0x795ff25609a4
RSP: 002b:00007ffe1ab3aa50 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00005a7b436ff460 RCX: 0000795ff25609a4
RDX: 00000000000a0800 RSI: 00005a7b436f7c90 RDI: 00000000ffffff9c
RBP: 00005a7b436f7c90 R08: 00000000ffffffff R09: 00007ffe1ab55080
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000000a0800
R13: 00005a7b436f3a30 R14: 0000000000000001 R15: 00005a7b436ca2c0
task:syz-executor319 state:D stack: 0 pid: 5177 ppid: 2015 flags:0x00004004
Call Trace:
context_switch kernel/sched/core.c:4197 [inline]
__schedule+0x210d/0x21ae kernel/sched/core.c:5408
schedule+0x168/0x1cc kernel/sched/core.c:5486
schedule_timeout+0x16a/0x1fc kernel/time/timer.c:2148
io_schedule_timeout+0x25/0x70 kernel/sched/core.c:7147
congestion_wait+0x108/0x2e3 mm/backing-dev.c:978
ext4_ext_truncate+0x1e4/0x1f7 fs/ext4/extents.c:4416
ext4_truncate+0x7a2/0xb6a fs/ext4/inode.c:4358
ext4_setattr+0x15c1/0x1752 fs/ext4/inode.c:5638
notify_change+0xb57/0xdf2 fs/attr.c:394
do_truncate+0x14c/0x1c9 fs/open.c:67
handle_truncate fs/namei.c:3066 [inline]
do_open fs/namei.c:3407 [inline]
path_openat+0x1933/0x197a fs/namei.c:3521
do_filp_open+0xc2/0x156 fs/namei.c:3548
do_sys_openat2+0x113/0x36a fs/open.c:1189
do_sys_open+0x8d/0xc1 fs/open.c:1206
do_syscall_64+0x33/0x40 arch/x86/entry/common.c:51
entry_SYSCALL_64_after_hwframe+0x61/0xc6
RIP: 0033:0x7fb2b203f0c9
RSP: 002b:00007fb2b1fea2f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 00007fb2b20c67a0 RCX: 00007fb2b203f0c9
RDX: 0000000000000000 RSI: 000000000014d27e RDI: 0000000020000180
RBP: 00007fb2b20927bc R08: 0000000000000000 R09: 0000000000000000
R10: 00000000000004ae R11: 0000000000000246 R12: 00007fb2b20917b8
R13: 0031656c69662f2e R14: 6f6f6c2f7665642f R15: 00007fb2b20c67a8
task:syz-executor319 state:D stack: 0 pid: 5195 ppid: 2015 flags:0x00000004
Call Trace:
context_switch kernel/sched/core.c:4197 [inline]
__schedule+0x210d/0x21ae kernel/sched/core.c:5408
schedule+0x168/0x1cc kernel/sched/core.c:5486
rwsem_down_write_slowpath+0x4e3/0x867 kernel/locking/rwsem.c:1235
__down_write+0x99/0xd0 kernel/locking/rwsem.c:1401
inode_lock include/linux/fs.h:776 [inline]
ext4_fallocate+0x181/0x255e fs/ext4/extents.c:4697
vfs_fallocate+0x5a6/0x687 fs/open.c:312
ksys_fallocate+0x5a/0x8c fs/open.c:335
__do_sys_fallocate fs/open.c:343 [inline]
__se_sys_fallocate fs/open.c:341 [inline]
__x64_sys_fallocate+0xa7/0xb0 fs/open.c:341
do_syscall_64+0x33/0x40 arch/x86/entry/common.c:51
entry_SYSCALL_64_after_hwframe+0x61/0xc6
RIP: 0033:0x7fb2b203f0c9
RSP: 002b:00007fb2a9c092f8 EFLAGS: 00000246 ORIG_RAX: 000000000000011d
RAX: ffffffffffffffda RBX: 00007fb2b20c67b0 RCX: 00007fb2b203f0c9
RDX: 0000000000008947 RSI: 0000000000000000 RDI: 0000000000000004
RBP: 00007fb2b20927bc R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000007 R11: 0000000000000246 R12: 00007fb2b20917b8
R13: 0031656c69662f2e R14: 6f6f6c2f7665642f R15: 00007fb2b20c67b8
task:syz-executor319 state:D stack: 0 pid: 8626 ppid: 2021 flags:0x00004004
Call Trace:
context_switch kernel/sched/core.c:4197 [inline]
__schedule+0x210d/0x21ae kernel/sched/core.c:5408
__raw_spin_unlock_irq include/linux/spinlock_api_smp.h:169 [inline]
_raw_spin_unlock_irq+0x3a/0x3c kernel/locking/spinlock.c:199
task:syz-executor319 state:D stack: 0 pid: 8633 ppid: 2021 flags:0x00000004
Call Trace:
context_switch kernel/sched/core.c:4197 [inline]
__schedule+0x210d/0x21ae kernel/sched/core.c:5408
schedule+0x168/0x1cc kernel/sched/core.c:5486
rwsem_down_write_slowpath+0x4e3/0x867 kernel/locking/rwsem.c:1235
__down_write+0x99/0xd0 kernel/locking/rwsem.c:1401
inode_lock include/linux/fs.h:776 [inline]
ext4_fallocate+0x181/0x255e fs/ext4/extents.c:4697
vfs_fallocate+0x5a6/0x687 fs/open.c:312
ksys_fallocate+0x5a/0x8c fs/open.c:335
__do_sys_fallocate fs/open.c:343 [inline]
__se_sys_fallocate fs/open.c:341 [inline]
__x64_sys_fallocate+0xa7/0xb0 fs/open.c:341
do_syscall_64+0x33/0x40 arch/x86/entry/common.c:51
entry_SYSCALL_64_after_hwframe+0x61/0xc6
RIP: 0033:0x7fb2b203f0c9
RSP: 002b:00007fb2a9c092f8 EFLAGS: 00000246 ORIG_RAX: 000000000000011d
RAX: ffffffffffffffda RBX: 00007fb2b20c67b0 RCX: 00007fb2b203f0c9
RDX: 0000000000008947 RSI: 0000000000000000 RDI: 0000000000000004
RBP: 00007fb2b20927bc R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000007 R11: 0000000000000246 R12: 00007fb2b20917b8
R13: 0031656c69662f2e R14: 6f6f6c2f7665642f R15: 00007fb2b20c67b8
task:syz-executor319 state:D stack: 0 pid: 8677 ppid: 2020 flags:0x00004004
Call Trace:
context_switch kernel/sched/core.c:4197 [inline]
__schedule+0x210d/0x21ae kernel/sched/core.c:5408
schedule+0x168/0x1cc kernel/sched/core.c:5486
schedule_timeout+0x16a/0x1fc kernel/time/timer.c:2148
io_schedule_timeout+0x25/0x70 kernel/sched/core.c:7147
congestion_wait+0x108/0x2e3 mm/backing-dev.c:978
ext4_ext_truncate+0x1e4/0x1f7 fs/ext4/extents.c:4416
ext4_truncate+0x7a2/0xb6a fs/ext4/inode.c:4358
ext4_setattr+0x15c1/0x1752 fs/ext4/inode.c:5638
notify_change+0xb57/0xdf2 fs/attr.c:394
do_truncate+0x14c/0x1c9 fs/open.c:67
handle_truncate fs/namei.c:3066 [inline]
do_open fs/namei.c:3407 [inline]
path_openat+0x1933/0x197a fs/namei.c:3521
do_filp_open+0xc2/0x156 fs/namei.c:3548
do_sys_openat2+0x113/0x36a fs/open.c:1189
do_sys_open+0x8d/0xc1 fs/open.c:1206
do_syscall_64+0x33/0x40 arch/x86/entry/common.c:51
entry_SYSCALL_64_after_hwframe+0x61/0xc6
RIP: 0033:0x7fb2b203f0c9
RSP: 002b:00007fb2b1fea2f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 00007fb2b20c67a0 RCX: 00007fb2b203f0c9
RDX: 0000000000000000 RSI: 000000000014d27e RDI: 0000000020000180
RBP: 00007fb2b20927bc R08: 0000000000000000 R09: 0000000000000000
R10: 00000000000004ae R11: 0000000000000246 R12: 00007fb2b20917b8
R13: 0031656c69662f2e R14: 6f6f6c2f7665642f R15: 00007fb2b20c67a8
task:syz-executor319 state:D stack: 0 pid: 8687 ppid: 2020 flags:0x00000004
Call Trace:
context_switch kernel/sched/core.c:4197 [inline]
__schedule+0x210d/0x21ae kernel/sched/core.c:5408
schedule+0x168/0x1cc kernel/sched/core.c:5486
rwsem_down_write_slowpath+0x4e3/0x867 kernel/locking/rwsem.c:1235
__down_write+0x99/0xd0 kernel/locking/rwsem.c:1401
inode_lock include/linux/fs.h:776 [inline]
ext4_fallocate+0x181/0x255e fs/ext4/extents.c:4697
vfs_fallocate+0x5a6/0x687 fs/open.c:312
ksys_fallocate+0x5a/0x8c fs/open.c:335
__do_sys_fallocate fs/open.c:343 [inline]
__se_sys_fallocate fs/open.c:341 [inline]
__x64_sys_fallocate+0xa7/0xb0 fs/open.c:341
do_syscall_64+0x33/0x40 arch/x86/entry/common.c:51
entry_SYSCALL_64_after_hwframe+0x61/0xc6
RIP: 0033:0x7fb2b203f0c9
RSP: 002b:00007fb2a9c092f8 EFLAGS: 00000246 ORIG_RAX: 000000000000011d
RAX: ffffffffffffffda RBX: 00007fb2b20c67b0 RCX: 00007fb2b203f0c9
RDX: 0000000000008947 RSI: 0000000000000000 RDI: 0000000000000004
RBP: 00007fb2b20927bc R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000007 R11: 0000000000000246 R12: 00007fb2b20917b8
R13: 0031656c69662f2e R14: 6f6f6c2f7665642f R15: 00007fb2b20c67b8
task:udevd state:D stack: 0 pid: 8902 ppid: 1881 flags:0x00000002
Call Trace:
context_switch kernel/sched/core.c:4197 [inline]
__schedule+0x210d/0x21ae kernel/sched/core.c:5408
schedule+0x168/0x1cc kernel/sched/core.c:5486
schedule_preempt_disabled+0xf/0x1a kernel/sched/core.c:5545
__mutex_lock_common kernel/locking/mutex.c:1047 [inline]
__mutex_lock+0x37c/0x690 kernel/locking/mutex.c:1109
__blkdev_get+0x21f/0xd64 fs/block_dev.c:1503
blkdev_get+0xcc/0x1eb fs/block_dev.c:1658
blkdev_open+0x22e/0x247 fs/block_dev.c:1775
do_dentry_open+0x6e5/0xbe3 fs/open.c:820
do_open fs/namei.c:3403 [inline]
path_openat+0x1689/0x197a fs/namei.c:3521
do_filp_open+0xc2/0x156 fs/namei.c:3548
do_sys_openat2+0x113/0x36a fs/open.c:1189
do_sys_open+0x8d/0xc1 fs/open.c:1206
do_syscall_64+0x33/0x40 arch/x86/entry/common.c:51
entry_SYSCALL_64_after_hwframe+0x61/0xc6
RIP: 0033:0x795ff25609a4
RSP: 002b:00007ffe1ab35650 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000795ff25609a4
RDX: 0000000000080000 RSI: 00005a7b436f4250 RDI: 00000000ffffff9c
RBP: 00005a7b436f4250 R08: 00005a7b43703070 R09: 0000795ff263bc10
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000080000
R13: 00005a7b43703070 R14: 0000000000000000 R15: 0000000000000001
task:syz-executor319 state:D stack: 0 pid:11374 ppid: 2017 flags:0x00004004
Call Trace:
context_switch kernel/sched/core.c:4197 [inline]
__schedule+0x210d/0x21ae kernel/sched/core.c:5408
schedule+0x168/0x1cc kernel/sched/core.c:5486
schedule_timeout+0x16a/0x1fc kernel/time/timer.c:2148
io_schedule_timeout+0x25/0x70 kernel/sched/core.c:7147
congestion_wait+0x108/0x2e3 mm/backing-dev.c:978
ext4_ext_truncate+0x1e4/0x1f7 fs/ext4/extents.c:4416
ext4_truncate+0x7a2/0xb6a fs/ext4/inode.c:4358
ext4_setattr+0x15c1/0x1752 fs/ext4/inode.c:5638
notify_change+0xb57/0xdf2 fs/attr.c:394
do_truncate+0x14c/0x1c9 fs/open.c:67
handle_truncate fs/namei.c:3066 [inline]
do_open fs/namei.c:3407 [inline]
path_openat+0x1933/0x197a fs/namei.c:3521
do_filp_open+0xc2/0x156 fs/namei.c:3548
do_sys_openat2+0x113/0x36a fs/open.c:1189
do_sys_open+0x8d/0xc1 fs/open.c:1206
do_syscall_64+0x33/0x40 arch/x86/entry/common.c:51
entry_SYSCALL_64_after_hwframe+0x61/0xc6
RIP: 0033:0x7fb2b203f0c9
RSP: 002b:00007fb2b1fea2f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 00007fb2b20c67a0 RCX: 00007fb2b203f0c9
RDX: 0000000000000000 RSI: 000000000014d27e RDI: 0000000020000180
RBP: 00007fb2b20927bc R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fb2b20917b8
R13: 0031656c69662f2e R14: 6f6f6c2f7665642f R15: 00007fb2b20c67a8
task:syz-executor319 state:D
stack: 0 pid:11384 ppid: 2017 flags:0x00000004
Call Trace:
context_switch kernel/sched/core.c:4197 [inline]
__schedule+0x210d/0x21ae kernel/sched/core.c:5408
schedule+0x168/0x1cc kernel/sched/core.c:5486
rwsem_down_write_slowpath+0x4e3/0x867 kernel/locking/rwsem.c:1235
__down_write+0x99/0xd0 kernel/locking/rwsem.c:1401
inode_lock include/linux/fs.h:776 [inline]
ext4_fallocate+0x181/0x255e fs/ext4/extents.c:4697
vfs_fallocate+0x5a6/0x687 fs/open.c:312
ksys_fallocate+0x5a/0x8c fs/open.c:335
__do_sys_fallocate fs/open.c:343 [inline]
__se_sys_fallocate fs/open.c:341 [inline]
__x64_sys_fallocate+0xa7/0xb0 fs/open.c:341
do_syscall_64+0x33/0x40 arch/x86/entry/common.c:51
entry_SYSCALL_64_after_hwframe+0x61/0xc6
RIP: 0033:0x7fb2b203f0c9
RSP: 002b:00007fb2a9c092f8 EFLAGS: 00000246 ORIG_RAX: 000000000000011d
RAX: ffffffffffffffda RBX: 00007fb2b20c67b0 RCX: 00007fb2b203f0c9
RDX: 0000000000008947 RSI: 0000000000000000 RDI: 0000000000000004
RBP: 00007fb2b20927bc R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000007 R11: 0000000000000246 R12: 00007fb2b20917b8
R13: 0031656c69662f2e R14: 6f6f6c2f7665642f R15: 00007fb2b20c67b8
task:syz-executor319 state:D stack: 0 pid:12502 ppid: 2018 flags:0x00000004
Call Trace:
context_switch kernel/sched/core.c:4197 [inline]
__schedule+0x210d/0x21ae kernel/sched/core.c:5408
schedule+0x168/0x1cc kernel/sched/core.c:5486
blk_mq_freeze_queue_wait+0xf7/0x14e block/blk-mq.c:150
__loop_clr_fd+0x224/0x913 drivers/block/loop.c:1223
lo_release+0x11b/0x1af drivers/block/loop.c:1923
__blkdev_put+0x38a/0x500 fs/block_dev.c:1806
blkdev_close+0x9a/0x9f fs/block_dev.c:1875
__fput+0x418/0x729 fs/file_table.c:281
task_work_run+0x12b/0x15b kernel/task_work.c:161
tracehook_notify_resume include/linux/tracehook.h:188 [inline]
exit_to_user_mode_loop kernel/entry/common.c:173 [inline]
exit_to_user_mode_prepare+0xbf/0x160 kernel/entry/common.c:200
syscall_exit_to_user_mode+0x128/0x168 kernel/entry/common.c:276
entry_SYSCALL_64_after_hwframe+0x61/0xc6
RIP: 0033:0x7fb2b1ffb4eb
RSP: 002b:00007fb2b1fea150 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 0000000000000003 RCX: 00007fb2b1ffb4eb
RDX: 0000000000000010 RSI: 0000000000004c00 RDI: 0000000000000004
RBP: 0000000000000004 R08: 0000000000000000 R09: 00000000000004ae
R10: 0000000000000000 R11: 0000000000000293 R12: 00007fb2b1fea6b8
R13: 00007fb2b1fea180 R14: 00007fb2b1fea1c0 R15: 0000000000004500
task:syz-executor319 state:D stack: 0 pid:12504 ppid: 2018 flags:0x00000004
Call Trace:
context_switch kernel/sched/core.c:4197 [inline]
__schedule+0x210d/0x21ae kernel/sched/core.c:5408
schedule+0x168/0x1cc kernel/sched/core.c:5486
schedule_preempt_disabled+0xf/0x1a kernel/sched/core.c:5545
__mutex_lock_common kernel/locking/mutex.c:1047 [inline]
__mutex_lock+0x37c/0x690 kernel/locking/mutex.c:1109
__blkdev_get+0x21f/0xd64 fs/block_dev.c:1503
blkdev_get+0xcc/0x1eb fs/block_dev.c:1658
blkdev_open+0x22e/0x247 fs/block_dev.c:1775
do_dentry_open+0x6e5/0xbe3 fs/open.c:820
do_open fs/namei.c:3403 [inline]
path_openat+0x1689/0x197a fs/namei.c:3521
do_filp_open+0xc2/0x156 fs/namei.c:3548
do_sys_openat2+0x113/0x36a fs/open.c:1189
do_sys_open+0x8d/0xc1 fs/open.c:1206
do_syscall_64+0x33/0x40 arch/x86/entry/common.c:51
entry_SYSCALL_64_after_hwframe+0x61/0xc6
RIP: 0033:0x7fb2b203f0c9
RSP: 002b:00007fb2a9c092f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 00007fb2b20c67b0 RCX: 00007fb2b203f0c9
RDX: 0000000000000000 RSI: 000000000014113e RDI: 00000000200000c0
RBP: 00007fb2b20927bc R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fb2b20917b8
R13: 0031656c69662f2e R14: 6f6f6c2f7665642f R15: 00007fb2b20c67b8
task:syz-executor319 state:D stack: 0 pid:12508 ppid: 2019 flags:0x00000004
Call Trace:
context_switch kernel/sched/core.c:4197 [inline]
__schedule+0x210d/0x21ae kernel/sched/core.c:5408
schedule+0x168/0x1cc kernel/sched/core.c:5486
schedule_preempt_disabled+0xf/0x1a kernel/sched/core.c:5545
__mutex_lock_common kernel/locking/mutex.c:1047 [inline]
__mutex_lock+0x37c/0x690 kernel/locking/mutex.c:1109
__blkdev_get+0x21f/0xd64 fs/block_dev.c:1503
blkdev_get+0xcc/0x1eb fs/block_dev.c:1658
blkdev_open+0x22e/0x247 fs/block_dev.c:1775
do_dentry_open+0x6e5/0xbe3 fs/open.c:820
do_open fs/namei.c:3403 [inline]
path_openat+0x1689/0x197a fs/namei.c:3521
do_filp_open+0xc2/0x156 fs/namei.c:3548
do_sys_openat2+0x113/0x36a fs/open.c:1189
do_sys_open+0x8d/0xc1 fs/open.c:1206
do_syscall_64+0x33/0x40 arch/x86/entry/common.c:51
entry_SYSCALL_64_after_hwframe+0x61/0xc6
RIP: 0033:0x7fb2b203f0c9
RSP: 002b:00007fb2a9be82f8 EFLAGS: 00000246
ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 00007fb2b20c67c0 RCX: 00007fb2b203f0c9
RDX: 0000000000000000 RSI: 000000000014113e RDI: 00000000200000c0
RBP: 00007fb2b20927bc R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fb2b20917b8
R13: 0031656c69662f2e R14: 6f6f6c2f7665642f R15: 00007fb2b20c67c8





--------------0jeaIqpEGzlzS2PBRHSLwsZn
Content-Type: text/x-csrc; charset=UTF-8; name="reproducer.c"
Content-Disposition: attachment; filename="reproducer.c"
Content-Transfer-Encoding: base64

Ly8gYXV0b2dlbmVyYXRlZCBieSBzeXprYWxsZXIgKGh0dHBzOi8vZ2l0aHViLmNvbS9nb29n
bGUvc3l6a2FsbGVyKQoKI2RlZmluZSBfR05VX1NPVVJDRQoKI2luY2x1ZGUgPGRpcmVudC5o
PgojaW5jbHVkZSA8ZW5kaWFuLmg+CiNpbmNsdWRlIDxlcnJuby5oPgojaW5jbHVkZSA8ZmNu
dGwuaD4KI2luY2x1ZGUgPHB0aHJlYWQuaD4KI2luY2x1ZGUgPHNjaGVkLmg+CiNpbmNsdWRl
IDxzZXRqbXAuaD4KI2luY2x1ZGUgPHNpZ25hbC5oPgojaW5jbHVkZSA8c3RkYXJnLmg+CiNp
bmNsdWRlIDxzdGRib29sLmg+CiNpbmNsdWRlIDxzdGRkZWYuaD4KI2luY2x1ZGUgPHN0ZGlu
dC5oPgojaW5jbHVkZSA8c3RkaW8uaD4KI2luY2x1ZGUgPHN0ZGxpYi5oPgojaW5jbHVkZSA8
c3RyaW5nLmg+CiNpbmNsdWRlIDxzeXMvaW9jdGwuaD4KI2luY2x1ZGUgPHN5cy9tbWFuLmg+
CiNpbmNsdWRlIDxzeXMvbW91bnQuaD4KI2luY2x1ZGUgPHN5cy9wcmN0bC5oPgojaW5jbHVk
ZSA8c3lzL3Jlc291cmNlLmg+CiNpbmNsdWRlIDxzeXMvc3RhdC5oPgojaW5jbHVkZSA8c3lz
L3N5c2NhbGwuaD4KI2luY2x1ZGUgPHN5cy90aW1lLmg+CiNpbmNsdWRlIDxzeXMvdHlwZXMu
aD4KI2luY2x1ZGUgPHN5cy93YWl0Lmg+CiNpbmNsdWRlIDx0aW1lLmg+CiNpbmNsdWRlIDx1
bmlzdGQuaD4KCiNpbmNsdWRlIDxsaW51eC9jYXBhYmlsaXR5Lmg+CiNpbmNsdWRlIDxsaW51
eC9mdXRleC5oPgojaW5jbHVkZSA8bGludXgvbG9vcC5oPgoKI2lmbmRlZiBfX05SX21lbWZk
X2NyZWF0ZQojZGVmaW5lIF9fTlJfbWVtZmRfY3JlYXRlIDMxOQojZW5kaWYKCnN0YXRpYyB1
bnNpZ25lZCBsb25nIGxvbmcgcHJvY2lkOwoKc3RhdGljIHZvaWQgc2xlZXBfbXModWludDY0
X3QgbXMpCnsKICB1c2xlZXAobXMgKiAxMDAwKTsKfQoKc3RhdGljIHVpbnQ2NF90IGN1cnJl
bnRfdGltZV9tcyh2b2lkKQp7CiAgc3RydWN0IHRpbWVzcGVjIHRzOwogIGlmIChjbG9ja19n
ZXR0aW1lKENMT0NLX01PTk9UT05JQywgJnRzKSkKICAgIGV4aXQoMSk7CiAgcmV0dXJuICh1
aW50NjRfdCl0cy50dl9zZWMgKiAxMDAwICsgKHVpbnQ2NF90KXRzLnR2X25zZWMgLyAxMDAw
MDAwOwp9CgpzdGF0aWMgdm9pZCB1c2VfdGVtcG9yYXJ5X2Rpcih2b2lkKQp7CiAgY2hhciB0
bXBkaXJfdGVtcGxhdGVbXSA9ICIuL3N5emthbGxlci5YWFhYWFgiOwogIGNoYXIqIHRtcGRp
ciA9IG1rZHRlbXAodG1wZGlyX3RlbXBsYXRlKTsKICBpZiAoIXRtcGRpcikKICAgIGV4aXQo
MSk7CiAgaWYgKGNobW9kKHRtcGRpciwgMDc3NykpCiAgICBleGl0KDEpOwogIGlmIChjaGRp
cih0bXBkaXIpKQogICAgZXhpdCgxKTsKfQoKc3RhdGljIHZvaWQgdGhyZWFkX3N0YXJ0KHZv
aWQqICgqZm4pKHZvaWQqKSwgdm9pZCogYXJnKQp7CiAgcHRocmVhZF90IHRoOwogIHB0aHJl
YWRfYXR0cl90IGF0dHI7CiAgcHRocmVhZF9hdHRyX2luaXQoJmF0dHIpOwogIHB0aHJlYWRf
YXR0cl9zZXRzdGFja3NpemUoJmF0dHIsIDEyOCA8PCAxMCk7CiAgaW50IGkgPSAwOwogIGZv
ciAoOyBpIDwgMTAwOyBpKyspIHsKICAgIGlmIChwdGhyZWFkX2NyZWF0ZSgmdGgsICZhdHRy
LCBmbiwgYXJnKSA9PSAwKSB7CiAgICAgIHB0aHJlYWRfYXR0cl9kZXN0cm95KCZhdHRyKTsK
ICAgICAgcmV0dXJuOwogICAgfQogICAgaWYgKGVycm5vID09IEVBR0FJTikgewogICAgICB1
c2xlZXAoNTApOwogICAgICBjb250aW51ZTsKICAgIH0KICAgIGJyZWFrOwogIH0KICBleGl0
KDEpOwp9Cgp0eXBlZGVmIHN0cnVjdCB7CiAgaW50IHN0YXRlOwp9IGV2ZW50X3Q7CgpzdGF0
aWMgdm9pZCBldmVudF9pbml0KGV2ZW50X3QqIGV2KQp7CiAgZXYtPnN0YXRlID0gMDsKfQoK
c3RhdGljIHZvaWQgZXZlbnRfcmVzZXQoZXZlbnRfdCogZXYpCnsKICBldi0+c3RhdGUgPSAw
Owp9CgpzdGF0aWMgdm9pZCBldmVudF9zZXQoZXZlbnRfdCogZXYpCnsKICBpZiAoZXYtPnN0
YXRlKQogICAgZXhpdCgxKTsKICBfX2F0b21pY19zdG9yZV9uKCZldi0+c3RhdGUsIDEsIF9f
QVRPTUlDX1JFTEVBU0UpOwogIHN5c2NhbGwoU1lTX2Z1dGV4LCAmZXYtPnN0YXRlLCBGVVRF
WF9XQUtFIHwgRlVURVhfUFJJVkFURV9GTEFHLCAxMDAwMDAwKTsKfQoKc3RhdGljIHZvaWQg
ZXZlbnRfd2FpdChldmVudF90KiBldikKewogIHdoaWxlICghX19hdG9taWNfbG9hZF9uKCZl
di0+c3RhdGUsIF9fQVRPTUlDX0FDUVVJUkUpKQogICAgc3lzY2FsbChTWVNfZnV0ZXgsICZl
di0+c3RhdGUsIEZVVEVYX1dBSVQgfCBGVVRFWF9QUklWQVRFX0ZMQUcsIDAsIDApOwp9Cgpz
dGF0aWMgaW50IGV2ZW50X2lzc2V0KGV2ZW50X3QqIGV2KQp7CiAgcmV0dXJuIF9fYXRvbWlj
X2xvYWRfbigmZXYtPnN0YXRlLCBfX0FUT01JQ19BQ1FVSVJFKTsKfQoKc3RhdGljIGludCBl
dmVudF90aW1lZHdhaXQoZXZlbnRfdCogZXYsIHVpbnQ2NF90IHRpbWVvdXQpCnsKICB1aW50
NjRfdCBzdGFydCA9IGN1cnJlbnRfdGltZV9tcygpOwogIHVpbnQ2NF90IG5vdyA9IHN0YXJ0
OwogIGZvciAoOzspIHsKICAgIHVpbnQ2NF90IHJlbWFpbiA9IHRpbWVvdXQgLSAobm93IC0g
c3RhcnQpOwogICAgc3RydWN0IHRpbWVzcGVjIHRzOwogICAgdHMudHZfc2VjID0gcmVtYWlu
IC8gMTAwMDsKICAgIHRzLnR2X25zZWMgPSAocmVtYWluICUgMTAwMCkgKiAxMDAwICogMTAw
MDsKICAgIHN5c2NhbGwoU1lTX2Z1dGV4LCAmZXYtPnN0YXRlLCBGVVRFWF9XQUlUIHwgRlVU
RVhfUFJJVkFURV9GTEFHLCAwLCAmdHMpOwogICAgaWYgKF9fYXRvbWljX2xvYWRfbigmZXYt
PnN0YXRlLCBfX0FUT01JQ19BQ1FVSVJFKSkKICAgICAgcmV0dXJuIDE7CiAgICBub3cgPSBj
dXJyZW50X3RpbWVfbXMoKTsKICAgIGlmIChub3cgLSBzdGFydCA+IHRpbWVvdXQpCiAgICAg
IHJldHVybiAwOwogIH0KfQoKc3RhdGljIGJvb2wgd3JpdGVfZmlsZShjb25zdCBjaGFyKiBm
aWxlLCBjb25zdCBjaGFyKiB3aGF0LCAuLi4pCnsKICBjaGFyIGJ1ZlsxMDI0XTsKICB2YV9s
aXN0IGFyZ3M7CiAgdmFfc3RhcnQoYXJncywgd2hhdCk7CiAgdnNucHJpbnRmKGJ1Ziwgc2l6
ZW9mKGJ1ZiksIHdoYXQsIGFyZ3MpOwogIHZhX2VuZChhcmdzKTsKICBidWZbc2l6ZW9mKGJ1
ZikgLSAxXSA9IDA7CiAgaW50IGxlbiA9IHN0cmxlbihidWYpOwogIGludCBmZCA9IG9wZW4o
ZmlsZSwgT19XUk9OTFkgfCBPX0NMT0VYRUMpOwogIGlmIChmZCA9PSAtMSkKICAgIHJldHVy
biBmYWxzZTsKICBpZiAod3JpdGUoZmQsIGJ1ZiwgbGVuKSAhPSBsZW4pIHsKICAgIGludCBl
cnIgPSBlcnJubzsKICAgIGNsb3NlKGZkKTsKICAgIGVycm5vID0gZXJyOwogICAgcmV0dXJu
IGZhbHNlOwogIH0KICBjbG9zZShmZCk7CiAgcmV0dXJuIHRydWU7Cn0KCiNkZWZpbmUgTUFY
X0ZEUyAzMAoKLy8lIFRoaXMgY29kZSBpcyBkZXJpdmVkIGZyb20gcHVmZi57YyxofSwgZm91
bmQgaW4gdGhlIHpsaWIgZGV2ZWxvcG1lbnQuIFRoZQovLyUgb3JpZ2luYWwgZmlsZXMgY29t
ZSB3aXRoIHRoZSBmb2xsb3dpbmcgY29weXJpZ2h0IG5vdGljZToKCi8vJSBDb3B5cmlnaHQg
KEMpIDIwMDItMjAxMyBNYXJrIEFkbGVyLCBhbGwgcmlnaHRzIHJlc2VydmVkCi8vJSB2ZXJz
aW9uIDIuMywgMjEgSmFuIDIwMTMKLy8lIFRoaXMgc29mdHdhcmUgaXMgcHJvdmlkZWQgJ2Fz
LWlzJywgd2l0aG91dCBhbnkgZXhwcmVzcyBvciBpbXBsaWVkCi8vJSB3YXJyYW50eS4gIElu
IG5vIGV2ZW50IHdpbGwgdGhlIGF1dGhvciBiZSBoZWxkIGxpYWJsZSBmb3IgYW55IGRhbWFn
ZXMKLy8lIGFyaXNpbmcgZnJvbSB0aGUgdXNlIG9mIHRoaXMgc29mdHdhcmUuCi8vJSBQZXJt
aXNzaW9uIGlzIGdyYW50ZWQgdG8gYW55b25lIHRvIHVzZSB0aGlzIHNvZnR3YXJlIGZvciBh
bnkgcHVycG9zZSwKLy8lIGluY2x1ZGluZyBjb21tZXJjaWFsIGFwcGxpY2F0aW9ucywgYW5k
IHRvIGFsdGVyIGl0IGFuZCByZWRpc3RyaWJ1dGUgaXQKLy8lIGZyZWVseSwgc3ViamVjdCB0
byB0aGUgZm9sbG93aW5nIHJlc3RyaWN0aW9uczoKLy8lIDEuIFRoZSBvcmlnaW4gb2YgdGhp
cyBzb2Z0d2FyZSBtdXN0IG5vdCBiZSBtaXNyZXByZXNlbnRlZDsgeW91IG11c3Qgbm90Ci8v
JSAgICBjbGFpbSB0aGF0IHlvdSB3cm90ZSB0aGUgb3JpZ2luYWwgc29mdHdhcmUuIElmIHlv
dSB1c2UgdGhpcyBzb2Z0d2FyZQovLyUgICAgaW4gYSBwcm9kdWN0LCBhbiBhY2tub3dsZWRn
bWVudCBpbiB0aGUgcHJvZHVjdCBkb2N1bWVudGF0aW9uIHdvdWxkIGJlCi8vJSAgICBhcHBy
ZWNpYXRlZCBidXQgaXMgbm90IHJlcXVpcmVkLgovLyUgMi4gQWx0ZXJlZCBzb3VyY2UgdmVy
c2lvbnMgbXVzdCBiZSBwbGFpbmx5IG1hcmtlZCBhcyBzdWNoLCBhbmQgbXVzdCBub3QgYmUK
Ly8lICAgIG1pc3JlcHJlc2VudGVkIGFzIGJlaW5nIHRoZSBvcmlnaW5hbCBzb2Z0d2FyZS4K
Ly8lIDMuIFRoaXMgbm90aWNlIG1heSBub3QgYmUgcmVtb3ZlZCBvciBhbHRlcmVkIGZyb20g
YW55IHNvdXJjZSBkaXN0cmlidXRpb24uCi8vJSBNYXJrIEFkbGVyICAgIG1hZGxlckBhbHVt
bmkuY2FsdGVjaC5lZHUKCi8vJSBCRUdJTiBDT0RFIERFUklWRUQgRlJPTSBwdWZmLntjLGh9
CgojZGVmaW5lIE1BWEJJVFMgMTUKI2RlZmluZSBNQVhMQ09ERVMgMjg2CiNkZWZpbmUgTUFY
RENPREVTIDMwCiNkZWZpbmUgTUFYQ09ERVMgKE1BWExDT0RFUyArIE1BWERDT0RFUykKI2Rl
ZmluZSBGSVhMQ09ERVMgMjg4CgpzdHJ1Y3QgcHVmZl9zdGF0ZSB7CiAgdW5zaWduZWQgY2hh
ciogb3V0OwogIHVuc2lnbmVkIGxvbmcgb3V0bGVuOwogIHVuc2lnbmVkIGxvbmcgb3V0Y250
OwogIGNvbnN0IHVuc2lnbmVkIGNoYXIqIGluOwogIHVuc2lnbmVkIGxvbmcgaW5sZW47CiAg
dW5zaWduZWQgbG9uZyBpbmNudDsKICBpbnQgYml0YnVmOwogIGludCBiaXRjbnQ7CiAgam1w
X2J1ZiBlbnY7Cn07CnN0YXRpYyBpbnQgcHVmZl9iaXRzKHN0cnVjdCBwdWZmX3N0YXRlKiBz
LCBpbnQgbmVlZCkKewogIGxvbmcgdmFsID0gcy0+Yml0YnVmOwogIHdoaWxlIChzLT5iaXRj
bnQgPCBuZWVkKSB7CiAgICBpZiAocy0+aW5jbnQgPT0gcy0+aW5sZW4pCiAgICAgIGxvbmdq
bXAocy0+ZW52LCAxKTsKICAgIHZhbCB8PSAobG9uZykocy0+aW5bcy0+aW5jbnQrK10pIDw8
IHMtPmJpdGNudDsKICAgIHMtPmJpdGNudCArPSA4OwogIH0KICBzLT5iaXRidWYgPSAoaW50
KSh2YWwgPj4gbmVlZCk7CiAgcy0+Yml0Y250IC09IG5lZWQ7CiAgcmV0dXJuIChpbnQpKHZh
bCAmICgoMUwgPDwgbmVlZCkgLSAxKSk7Cn0Kc3RhdGljIGludCBwdWZmX3N0b3JlZChzdHJ1
Y3QgcHVmZl9zdGF0ZSogcykKewogIHMtPmJpdGJ1ZiA9IDA7CiAgcy0+Yml0Y250ID0gMDsK
ICBpZiAocy0+aW5jbnQgKyA0ID4gcy0+aW5sZW4pCiAgICByZXR1cm4gMjsKICB1bnNpZ25l
ZCBsZW4gPSBzLT5pbltzLT5pbmNudCsrXTsKICBsZW4gfD0gcy0+aW5bcy0+aW5jbnQrK10g
PDwgODsKICBpZiAocy0+aW5bcy0+aW5jbnQrK10gIT0gKH5sZW4gJiAweGZmKSB8fAogICAg
ICBzLT5pbltzLT5pbmNudCsrXSAhPSAoKH5sZW4gPj4gOCkgJiAweGZmKSkKICAgIHJldHVy
biAtMjsKICBpZiAocy0+aW5jbnQgKyBsZW4gPiBzLT5pbmxlbikKICAgIHJldHVybiAyOwog
IGlmIChzLT5vdXRjbnQgKyBsZW4gPiBzLT5vdXRsZW4pCiAgICByZXR1cm4gMTsKICBmb3Ig
KDsgbGVuLS07IHMtPm91dGNudCsrLCBzLT5pbmNudCsrKSB7CiAgICBpZiAocy0+aW5bcy0+
aW5jbnRdKQogICAgICBzLT5vdXRbcy0+b3V0Y250XSA9IHMtPmluW3MtPmluY250XTsKICB9
CiAgcmV0dXJuIDA7Cn0Kc3RydWN0IHB1ZmZfaHVmZm1hbiB7CiAgc2hvcnQqIGNvdW50Owog
IHNob3J0KiBzeW1ib2w7Cn07CnN0YXRpYyBpbnQgcHVmZl9kZWNvZGUoc3RydWN0IHB1ZmZf
c3RhdGUqIHMsIGNvbnN0IHN0cnVjdCBwdWZmX2h1ZmZtYW4qIGgpCnsKICBpbnQgZmlyc3Qg
PSAwOwogIGludCBpbmRleCA9IDA7CiAgaW50IGJpdGJ1ZiA9IHMtPmJpdGJ1ZjsKICBpbnQg
bGVmdCA9IHMtPmJpdGNudDsKICBpbnQgY29kZSA9IGZpcnN0ID0gaW5kZXggPSAwOwogIGlu
dCBsZW4gPSAxOwogIHNob3J0KiBuZXh0ID0gaC0+Y291bnQgKyAxOwogIHdoaWxlICgxKSB7
CiAgICB3aGlsZSAobGVmdC0tKSB7CiAgICAgIGNvZGUgfD0gYml0YnVmICYgMTsKICAgICAg
Yml0YnVmID4+PSAxOwogICAgICBpbnQgY291bnQgPSAqbmV4dCsrOwogICAgICBpZiAoY29k
ZSAtIGNvdW50IDwgZmlyc3QpIHsKICAgICAgICBzLT5iaXRidWYgPSBiaXRidWY7CiAgICAg
ICAgcy0+Yml0Y250ID0gKHMtPmJpdGNudCAtIGxlbikgJiA3OwogICAgICAgIHJldHVybiBo
LT5zeW1ib2xbaW5kZXggKyAoY29kZSAtIGZpcnN0KV07CiAgICAgIH0KICAgICAgaW5kZXgg
Kz0gY291bnQ7CiAgICAgIGZpcnN0ICs9IGNvdW50OwogICAgICBmaXJzdCA8PD0gMTsKICAg
ICAgY29kZSA8PD0gMTsKICAgICAgbGVuKys7CiAgICB9CiAgICBsZWZ0ID0gKE1BWEJJVFMg
KyAxKSAtIGxlbjsKICAgIGlmIChsZWZ0ID09IDApCiAgICAgIGJyZWFrOwogICAgaWYgKHMt
PmluY250ID09IHMtPmlubGVuKQogICAgICBsb25nam1wKHMtPmVudiwgMSk7CiAgICBiaXRi
dWYgPSBzLT5pbltzLT5pbmNudCsrXTsKICAgIGlmIChsZWZ0ID4gOCkKICAgICAgbGVmdCA9
IDg7CiAgfQogIHJldHVybiAtMTA7Cn0Kc3RhdGljIGludCBwdWZmX2NvbnN0cnVjdChzdHJ1
Y3QgcHVmZl9odWZmbWFuKiBoLCBjb25zdCBzaG9ydCogbGVuZ3RoLCBpbnQgbikKewogIGlu
dCBsZW47CiAgZm9yIChsZW4gPSAwOyBsZW4gPD0gTUFYQklUUzsgbGVuKyspCiAgICBoLT5j
b3VudFtsZW5dID0gMDsKICBpbnQgc3ltYm9sOwogIGZvciAoc3ltYm9sID0gMDsgc3ltYm9s
IDwgbjsgc3ltYm9sKyspCiAgICAoaC0+Y291bnRbbGVuZ3RoW3N5bWJvbF1dKSsrOwogIGlm
IChoLT5jb3VudFswXSA9PSBuKQogICAgcmV0dXJuIDA7CiAgaW50IGxlZnQgPSAxOwogIGZv
ciAobGVuID0gMTsgbGVuIDw9IE1BWEJJVFM7IGxlbisrKSB7CiAgICBsZWZ0IDw8PSAxOwog
ICAgbGVmdCAtPSBoLT5jb3VudFtsZW5dOwogICAgaWYgKGxlZnQgPCAwKQogICAgICByZXR1
cm4gbGVmdDsKICB9CiAgc2hvcnQgb2Zmc1tNQVhCSVRTICsgMV07CiAgb2Zmc1sxXSA9IDA7
CiAgZm9yIChsZW4gPSAxOyBsZW4gPCBNQVhCSVRTOyBsZW4rKykKICAgIG9mZnNbbGVuICsg
MV0gPSBvZmZzW2xlbl0gKyBoLT5jb3VudFtsZW5dOwogIGZvciAoc3ltYm9sID0gMDsgc3lt
Ym9sIDwgbjsgc3ltYm9sKyspCiAgICBpZiAobGVuZ3RoW3N5bWJvbF0gIT0gMCkKICAgICAg
aC0+c3ltYm9sW29mZnNbbGVuZ3RoW3N5bWJvbF1dKytdID0gc3ltYm9sOwogIHJldHVybiBs
ZWZ0Owp9CnN0YXRpYyBpbnQgcHVmZl9jb2RlcyhzdHJ1Y3QgcHVmZl9zdGF0ZSogcywgY29u
c3Qgc3RydWN0IHB1ZmZfaHVmZm1hbiogbGVuY29kZSwKICAgICAgICAgICAgICAgICAgICAg
IGNvbnN0IHN0cnVjdCBwdWZmX2h1ZmZtYW4qIGRpc3Rjb2RlKQp7CiAgc3RhdGljIGNvbnN0
IHNob3J0IGxlbnNbMjldID0gezMsICA0LCAgNSwgIDYsICAgNywgICA4LCAgIDksICAgMTAs
ICAxMSwgMTMsCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDE1LCAxNywgMTks
IDIzLCAgMjcsICAzMSwgIDM1LCAgNDMsICA1MSwgNTksCiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIDY3LCA4MywgOTksIDExNSwgMTMxLCAxNjMsIDE5NSwgMjI3LCAyNTh9
OwogIHN0YXRpYyBjb25zdCBzaG9ydCBsZXh0WzI5XSA9IHswLCAwLCAwLCAwLCAwLCAwLCAw
LCAwLCAxLCAxLCAxLCAxLCAyLCAyLCAyLAogICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAyLCAzLCAzLCAzLCAzLCA0LCA0LCA0LCA0LCA1LCA1LCA1LCA1LCAwfTsKICBzdGF0
aWMgY29uc3Qgc2hvcnQgZGlzdHNbMzBdID0gewogICAgICAxLCAgICAyLCAgICAzLCAgICA0
LCAgICA1LCAgICA3LCAgICA5LCAgICAxMywgICAgMTcsICAgIDI1LAogICAgICAzMywgICA0
OSwgICA2NSwgICA5NywgICAxMjksICAxOTMsICAyNTcsICAzODUsICAgNTEzLCAgIDc2OSwK
ICAgICAgMTAyNSwgMTUzNywgMjA0OSwgMzA3MywgNDA5NywgNjE0NSwgODE5MywgMTIyODks
IDE2Mzg1LCAyNDU3N307CiAgc3RhdGljIGNvbnN0IHNob3J0IGRleHRbMzBdID0gezAsIDAs
IDAsICAwLCAgMSwgIDEsICAyLCAgMiwgIDMsICAzLAogICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICA0LCA0LCA1LCAgNSwgIDYsICA2LCAgNywgIDcsICA4LCAgOCwKICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgOSwgOSwgMTAsIDEwLCAxMSwgMTEsIDEyLCAx
MiwgMTMsIDEzfTsKICBpbnQgc3ltYm9sOwogIGRvIHsKICAgIHN5bWJvbCA9IHB1ZmZfZGVj
b2RlKHMsIGxlbmNvZGUpOwogICAgaWYgKHN5bWJvbCA8IDApCiAgICAgIHJldHVybiBzeW1i
b2w7CiAgICBpZiAoc3ltYm9sIDwgMjU2KSB7CiAgICAgIGlmIChzLT5vdXRjbnQgPT0gcy0+
b3V0bGVuKQogICAgICAgIHJldHVybiAxOwogICAgICBpZiAoc3ltYm9sKQogICAgICAgIHMt
Pm91dFtzLT5vdXRjbnRdID0gc3ltYm9sOwogICAgICBzLT5vdXRjbnQrKzsKICAgIH0gZWxz
ZSBpZiAoc3ltYm9sID4gMjU2KSB7CiAgICAgIHN5bWJvbCAtPSAyNTc7CiAgICAgIGlmIChz
eW1ib2wgPj0gMjkpCiAgICAgICAgcmV0dXJuIC0xMDsKICAgICAgaW50IGxlbiA9IGxlbnNb
c3ltYm9sXSArIHB1ZmZfYml0cyhzLCBsZXh0W3N5bWJvbF0pOwogICAgICBzeW1ib2wgPSBw
dWZmX2RlY29kZShzLCBkaXN0Y29kZSk7CiAgICAgIGlmIChzeW1ib2wgPCAwKQogICAgICAg
IHJldHVybiBzeW1ib2w7CiAgICAgIHVuc2lnbmVkIGRpc3QgPSBkaXN0c1tzeW1ib2xdICsg
cHVmZl9iaXRzKHMsIGRleHRbc3ltYm9sXSk7CiAgICAgIGlmIChkaXN0ID4gcy0+b3V0Y250
KQogICAgICAgIHJldHVybiAtMTE7CiAgICAgIGlmIChzLT5vdXRjbnQgKyBsZW4gPiBzLT5v
dXRsZW4pCiAgICAgICAgcmV0dXJuIDE7CiAgICAgIHdoaWxlIChsZW4tLSkgewogICAgICAg
IGlmIChkaXN0IDw9IHMtPm91dGNudCAmJiBzLT5vdXRbcy0+b3V0Y250IC0gZGlzdF0pCiAg
ICAgICAgICBzLT5vdXRbcy0+b3V0Y250XSA9IHMtPm91dFtzLT5vdXRjbnQgLSBkaXN0XTsK
ICAgICAgICBzLT5vdXRjbnQrKzsKICAgICAgfQogICAgfQogIH0gd2hpbGUgKHN5bWJvbCAh
PSAyNTYpOwogIHJldHVybiAwOwp9CnN0YXRpYyBpbnQgcHVmZl9maXhlZChzdHJ1Y3QgcHVm
Zl9zdGF0ZSogcykKewogIHN0YXRpYyBpbnQgdmlyZ2luID0gMTsKICBzdGF0aWMgc2hvcnQg
bGVuY250W01BWEJJVFMgKyAxXSwgbGVuc3ltW0ZJWExDT0RFU107CiAgc3RhdGljIHNob3J0
IGRpc3RjbnRbTUFYQklUUyArIDFdLCBkaXN0c3ltW01BWERDT0RFU107CiAgc3RhdGljIHN0
cnVjdCBwdWZmX2h1ZmZtYW4gbGVuY29kZSwgZGlzdGNvZGU7CiAgaWYgKHZpcmdpbikgewog
ICAgbGVuY29kZS5jb3VudCA9IGxlbmNudDsKICAgIGxlbmNvZGUuc3ltYm9sID0gbGVuc3lt
OwogICAgZGlzdGNvZGUuY291bnQgPSBkaXN0Y250OwogICAgZGlzdGNvZGUuc3ltYm9sID0g
ZGlzdHN5bTsKICAgIHNob3J0IGxlbmd0aHNbRklYTENPREVTXTsKICAgIGludCBzeW1ib2w7
CiAgICBmb3IgKHN5bWJvbCA9IDA7IHN5bWJvbCA8IDE0NDsgc3ltYm9sKyspCiAgICAgIGxl
bmd0aHNbc3ltYm9sXSA9IDg7CiAgICBmb3IgKDsgc3ltYm9sIDwgMjU2OyBzeW1ib2wrKykK
ICAgICAgbGVuZ3Roc1tzeW1ib2xdID0gOTsKICAgIGZvciAoOyBzeW1ib2wgPCAyODA7IHN5
bWJvbCsrKQogICAgICBsZW5ndGhzW3N5bWJvbF0gPSA3OwogICAgZm9yICg7IHN5bWJvbCA8
IEZJWExDT0RFUzsgc3ltYm9sKyspCiAgICAgIGxlbmd0aHNbc3ltYm9sXSA9IDg7CiAgICBw
dWZmX2NvbnN0cnVjdCgmbGVuY29kZSwgbGVuZ3RocywgRklYTENPREVTKTsKICAgIGZvciAo
c3ltYm9sID0gMDsgc3ltYm9sIDwgTUFYRENPREVTOyBzeW1ib2wrKykKICAgICAgbGVuZ3Ro
c1tzeW1ib2xdID0gNTsKICAgIHB1ZmZfY29uc3RydWN0KCZkaXN0Y29kZSwgbGVuZ3Rocywg
TUFYRENPREVTKTsKICAgIHZpcmdpbiA9IDA7CiAgfQogIHJldHVybiBwdWZmX2NvZGVzKHMs
ICZsZW5jb2RlLCAmZGlzdGNvZGUpOwp9CnN0YXRpYyBpbnQgcHVmZl9keW5hbWljKHN0cnVj
dCBwdWZmX3N0YXRlKiBzKQp7CiAgc3RhdGljIGNvbnN0IHNob3J0IG9yZGVyWzE5XSA9IHsx
NiwgMTcsIDE4LCAwLCA4LCAgNywgOSwgIDYsIDEwLCA1LAogICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgMTEsIDQsICAxMiwgMywgMTMsIDIsIDE0LCAxLCAxNX07CiAgaW50
IG5sZW4gPSBwdWZmX2JpdHMocywgNSkgKyAyNTc7CiAgaW50IG5kaXN0ID0gcHVmZl9iaXRz
KHMsIDUpICsgMTsKICBpbnQgbmNvZGUgPSBwdWZmX2JpdHMocywgNCkgKyA0OwogIGlmIChu
bGVuID4gTUFYTENPREVTIHx8IG5kaXN0ID4gTUFYRENPREVTKQogICAgcmV0dXJuIC0zOwog
IHNob3J0IGxlbmd0aHNbTUFYQ09ERVNdOwogIGludCBpbmRleDsKICBmb3IgKGluZGV4ID0g
MDsgaW5kZXggPCBuY29kZTsgaW5kZXgrKykKICAgIGxlbmd0aHNbb3JkZXJbaW5kZXhdXSA9
IHB1ZmZfYml0cyhzLCAzKTsKICBmb3IgKDsgaW5kZXggPCAxOTsgaW5kZXgrKykKICAgIGxl
bmd0aHNbb3JkZXJbaW5kZXhdXSA9IDA7CiAgc2hvcnQgbGVuY250W01BWEJJVFMgKyAxXSwg
bGVuc3ltW01BWExDT0RFU107CiAgc3RydWN0IHB1ZmZfaHVmZm1hbiBsZW5jb2RlID0ge2xl
bmNudCwgbGVuc3ltfTsKICBpbnQgZXJyID0gcHVmZl9jb25zdHJ1Y3QoJmxlbmNvZGUsIGxl
bmd0aHMsIDE5KTsKICBpZiAoZXJyICE9IDApCiAgICByZXR1cm4gLTQ7CiAgaW5kZXggPSAw
OwogIHdoaWxlIChpbmRleCA8IG5sZW4gKyBuZGlzdCkgewogICAgaW50IHN5bWJvbDsKICAg
IGludCBsZW47CiAgICBzeW1ib2wgPSBwdWZmX2RlY29kZShzLCAmbGVuY29kZSk7CiAgICBp
ZiAoc3ltYm9sIDwgMCkKICAgICAgcmV0dXJuIHN5bWJvbDsKICAgIGlmIChzeW1ib2wgPCAx
NikKICAgICAgbGVuZ3Roc1tpbmRleCsrXSA9IHN5bWJvbDsKICAgIGVsc2UgewogICAgICBs
ZW4gPSAwOwogICAgICBpZiAoc3ltYm9sID09IDE2KSB7CiAgICAgICAgaWYgKGluZGV4ID09
IDApCiAgICAgICAgICByZXR1cm4gLTU7CiAgICAgICAgbGVuID0gbGVuZ3Roc1tpbmRleCAt
IDFdOwogICAgICAgIHN5bWJvbCA9IDMgKyBwdWZmX2JpdHMocywgMik7CiAgICAgIH0gZWxz
ZSBpZiAoc3ltYm9sID09IDE3KQogICAgICAgIHN5bWJvbCA9IDMgKyBwdWZmX2JpdHMocywg
Myk7CiAgICAgIGVsc2UKICAgICAgICBzeW1ib2wgPSAxMSArIHB1ZmZfYml0cyhzLCA3KTsK
ICAgICAgaWYgKGluZGV4ICsgc3ltYm9sID4gbmxlbiArIG5kaXN0KQogICAgICAgIHJldHVy
biAtNjsKICAgICAgd2hpbGUgKHN5bWJvbC0tKQogICAgICAgIGxlbmd0aHNbaW5kZXgrK10g
PSBsZW47CiAgICB9CiAgfQogIGlmIChsZW5ndGhzWzI1Nl0gPT0gMCkKICAgIHJldHVybiAt
OTsKICBlcnIgPSBwdWZmX2NvbnN0cnVjdCgmbGVuY29kZSwgbGVuZ3Rocywgbmxlbik7CiAg
aWYgKGVyciAmJiAoZXJyIDwgMCB8fCBubGVuICE9IGxlbmNvZGUuY291bnRbMF0gKyBsZW5j
b2RlLmNvdW50WzFdKSkKICAgIHJldHVybiAtNzsKICBzaG9ydCBkaXN0Y250W01BWEJJVFMg
KyAxXSwgZGlzdHN5bVtNQVhEQ09ERVNdOwogIHN0cnVjdCBwdWZmX2h1ZmZtYW4gZGlzdGNv
ZGUgPSB7ZGlzdGNudCwgZGlzdHN5bX07CiAgZXJyID0gcHVmZl9jb25zdHJ1Y3QoJmRpc3Rj
b2RlLCBsZW5ndGhzICsgbmxlbiwgbmRpc3QpOwogIGlmIChlcnIgJiYgKGVyciA8IDAgfHwg
bmRpc3QgIT0gZGlzdGNvZGUuY291bnRbMF0gKyBkaXN0Y29kZS5jb3VudFsxXSkpCiAgICBy
ZXR1cm4gLTg7CiAgcmV0dXJuIHB1ZmZfY29kZXMocywgJmxlbmNvZGUsICZkaXN0Y29kZSk7
Cn0Kc3RhdGljIGludCBwdWZmKHVuc2lnbmVkIGNoYXIqIGRlc3QsIHVuc2lnbmVkIGxvbmcq
IGRlc3RsZW4sCiAgICAgICAgICAgICAgICBjb25zdCB1bnNpZ25lZCBjaGFyKiBzb3VyY2Us
IHVuc2lnbmVkIGxvbmcgc291cmNlbGVuKQp7CiAgc3RydWN0IHB1ZmZfc3RhdGUgcyA9IHsK
ICAgICAgLm91dCA9IGRlc3QsCiAgICAgIC5vdXRsZW4gPSAqZGVzdGxlbiwKICAgICAgLm91
dGNudCA9IDAsCiAgICAgIC5pbiA9IHNvdXJjZSwKICAgICAgLmlubGVuID0gc291cmNlbGVu
LAogICAgICAuaW5jbnQgPSAwLAogICAgICAuYml0YnVmID0gMCwKICAgICAgLmJpdGNudCA9
IDAsCiAgfTsKICBpbnQgZXJyOwogIGlmIChzZXRqbXAocy5lbnYpICE9IDApCiAgICBlcnIg
PSAyOwogIGVsc2UgewogICAgaW50IGxhc3Q7CiAgICBkbyB7CiAgICAgIGxhc3QgPSBwdWZm
X2JpdHMoJnMsIDEpOwogICAgICBpbnQgdHlwZSA9IHB1ZmZfYml0cygmcywgMik7CiAgICAg
IGVyciA9IHR5cGUgPT0gMCA/IHB1ZmZfc3RvcmVkKCZzKQogICAgICAgICAgICAgICAgICAg
ICAgOiAodHlwZSA9PSAxID8gcHVmZl9maXhlZCgmcykKICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICA6ICh0eXBlID09IDIgPyBwdWZmX2R5bmFtaWMoJnMpIDogLTEpKTsK
ICAgICAgaWYgKGVyciAhPSAwKQogICAgICAgIGJyZWFrOwogICAgfSB3aGlsZSAoIWxhc3Qp
OwogIH0KICAqZGVzdGxlbiA9IHMub3V0Y250OwogIHJldHVybiBlcnI7Cn0KCi8vJSBFTkQg
Q09ERSBERVJJVkVEIEZST00gcHVmZi57YyxofQoKI2RlZmluZSBaTElCX0hFQURFUl9XSURU
SCAyCgpzdGF0aWMgaW50IHB1ZmZfemxpYl90b19maWxlKGNvbnN0IHVuc2lnbmVkIGNoYXIq
IHNvdXJjZSwKICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1bnNpZ25lZCBsb25nIHNv
dXJjZWxlbiwgaW50IGRlc3RfZmQpCnsKICBpZiAoc291cmNlbGVuIDwgWkxJQl9IRUFERVJf
V0lEVEgpCiAgICByZXR1cm4gMDsKICBzb3VyY2UgKz0gWkxJQl9IRUFERVJfV0lEVEg7CiAg
c291cmNlbGVuIC09IFpMSUJfSEVBREVSX1dJRFRIOwogIGNvbnN0IHVuc2lnbmVkIGxvbmcg
bWF4X2Rlc3RsZW4gPSAxMzIgPDwgMjA7CiAgdm9pZCogcmV0ID0gbW1hcCgwLCBtYXhfZGVz
dGxlbiwgUFJPVF9XUklURSB8IFBST1RfUkVBRCwKICAgICAgICAgICAgICAgICAgIE1BUF9Q
UklWQVRFIHwgTUFQX0FOT04sIC0xLCAwKTsKICBpZiAocmV0ID09IE1BUF9GQUlMRUQpCiAg
ICByZXR1cm4gLTE7CiAgdW5zaWduZWQgY2hhciogZGVzdCA9ICh1bnNpZ25lZCBjaGFyKily
ZXQ7CiAgdW5zaWduZWQgbG9uZyBkZXN0bGVuID0gbWF4X2Rlc3RsZW47CiAgaW50IGVyciA9
IHB1ZmYoZGVzdCwgJmRlc3RsZW4sIHNvdXJjZSwgc291cmNlbGVuKTsKICBpZiAoZXJyKSB7
CiAgICBtdW5tYXAoZGVzdCwgbWF4X2Rlc3RsZW4pOwogICAgZXJybm8gPSAtZXJyOwogICAg
cmV0dXJuIC0xOwogIH0KICBpZiAod3JpdGUoZGVzdF9mZCwgZGVzdCwgZGVzdGxlbikgIT0g
KHNzaXplX3QpZGVzdGxlbikgewogICAgbXVubWFwKGRlc3QsIG1heF9kZXN0bGVuKTsKICAg
IHJldHVybiAtMTsKICB9CiAgcmV0dXJuIG11bm1hcChkZXN0LCBkZXN0bGVuKTsKfQoKc3Rh
dGljIGludCBzZXR1cF9sb29wX2RldmljZSh1bnNpZ25lZCBjaGFyKiBkYXRhLCB1bnNpZ25l
ZCBsb25nIHNpemUsCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY29uc3QgY2hhciog
bG9vcG5hbWUsIGludCogbG9vcGZkX3ApCnsKICBpbnQgZXJyID0gMCwgbG9vcGZkID0gLTE7
CiAgaW50IG1lbWZkID0gc3lzY2FsbChfX05SX21lbWZkX2NyZWF0ZSwgInN5emthbGxlciIs
IDApOwogIGlmIChtZW1mZCA9PSAtMSkgewogICAgZXJyID0gZXJybm87CiAgICBnb3RvIGVy
cm9yOwogIH0KICBpZiAocHVmZl96bGliX3RvX2ZpbGUoZGF0YSwgc2l6ZSwgbWVtZmQpKSB7
CiAgICBlcnIgPSBlcnJubzsKICAgIGdvdG8gZXJyb3JfY2xvc2VfbWVtZmQ7CiAgfQogIGxv
b3BmZCA9IG9wZW4obG9vcG5hbWUsIE9fUkRXUik7CiAgaWYgKGxvb3BmZCA9PSAtMSkgewog
ICAgZXJyID0gZXJybm87CiAgICBnb3RvIGVycm9yX2Nsb3NlX21lbWZkOwogIH0KICBpZiAo
aW9jdGwobG9vcGZkLCBMT09QX1NFVF9GRCwgbWVtZmQpKSB7CiAgICBpZiAoZXJybm8gIT0g
RUJVU1kpIHsKICAgICAgZXJyID0gZXJybm87CiAgICAgIGdvdG8gZXJyb3JfY2xvc2VfbG9v
cDsKICAgIH0KICAgIGlvY3RsKGxvb3BmZCwgTE9PUF9DTFJfRkQsIDApOwogICAgdXNsZWVw
KDEwMDApOwogICAgaWYgKGlvY3RsKGxvb3BmZCwgTE9PUF9TRVRfRkQsIG1lbWZkKSkgewog
ICAgICBlcnIgPSBlcnJubzsKICAgICAgZ290byBlcnJvcl9jbG9zZV9sb29wOwogICAgfQog
IH0KICBjbG9zZShtZW1mZCk7CiAgKmxvb3BmZF9wID0gbG9vcGZkOwogIHJldHVybiAwOwoK
ZXJyb3JfY2xvc2VfbG9vcDoKICBjbG9zZShsb29wZmQpOwplcnJvcl9jbG9zZV9tZW1mZDoK
ICBjbG9zZShtZW1mZCk7CmVycm9yOgogIGVycm5vID0gZXJyOwogIHJldHVybiAtMTsKfQoK
c3RhdGljIGxvbmcgc3l6X21vdW50X2ltYWdlKHZvbGF0aWxlIGxvbmcgZnNhcmcsIHZvbGF0
aWxlIGxvbmcgZGlyLAogICAgICAgICAgICAgICAgICAgICAgICAgICAgdm9sYXRpbGUgbG9u
ZyBmbGFncywgdm9sYXRpbGUgbG9uZyBvcHRzYXJnLAogICAgICAgICAgICAgICAgICAgICAg
ICAgICAgdm9sYXRpbGUgbG9uZyBjaGFuZ2VfZGlyLAogICAgICAgICAgICAgICAgICAgICAg
ICAgICAgdm9sYXRpbGUgdW5zaWduZWQgbG9uZyBzaXplLCB2b2xhdGlsZSBsb25nIGltYWdl
KQp7CiAgdW5zaWduZWQgY2hhciogZGF0YSA9ICh1bnNpZ25lZCBjaGFyKilpbWFnZTsKICBp
bnQgcmVzID0gLTEsIGVyciA9IDAsIGxvb3BmZCA9IC0xLCBuZWVkX2xvb3BfZGV2aWNlID0g
ISFzaXplOwogIGNoYXIqIG1vdW50X29wdHMgPSAoY2hhciopb3B0c2FyZzsKICBjaGFyKiB0
YXJnZXQgPSAoY2hhciopZGlyOwogIGNoYXIqIGZzID0gKGNoYXIqKWZzYXJnOwogIGNoYXIq
IHNvdXJjZSA9IE5VTEw7CiAgY2hhciBsb29wbmFtZVs2NF07CiAgaWYgKG5lZWRfbG9vcF9k
ZXZpY2UpIHsKICAgIG1lbXNldChsb29wbmFtZSwgMCwgc2l6ZW9mKGxvb3BuYW1lKSk7CiAg
ICBzbnByaW50Zihsb29wbmFtZSwgc2l6ZW9mKGxvb3BuYW1lKSwgIi9kZXYvbG9vcCVsbHUi
LCBwcm9jaWQpOwogICAgaWYgKHNldHVwX2xvb3BfZGV2aWNlKGRhdGEsIHNpemUsIGxvb3Bu
YW1lLCAmbG9vcGZkKSA9PSAtMSkKICAgICAgcmV0dXJuIC0xOwogICAgc291cmNlID0gbG9v
cG5hbWU7CiAgfQogIG1rZGlyKHRhcmdldCwgMDc3Nyk7CiAgY2hhciBvcHRzWzI1Nl07CiAg
bWVtc2V0KG9wdHMsIDAsIHNpemVvZihvcHRzKSk7CiAgaWYgKHN0cmxlbihtb3VudF9vcHRz
KSA+IChzaXplb2Yob3B0cykgLSAzMikpIHsKICB9CiAgc3RybmNweShvcHRzLCBtb3VudF9v
cHRzLCBzaXplb2Yob3B0cykgLSAzMik7CiAgaWYgKHN0cmNtcChmcywgImlzbzk2NjAiKSA9
PSAwKSB7CiAgICBmbGFncyB8PSBNU19SRE9OTFk7CiAgfSBlbHNlIGlmIChzdHJuY21wKGZz
LCAiZXh0IiwgMykgPT0gMCkgewogICAgYm9vbCBoYXNfcmVtb3VudF9ybyA9IGZhbHNlOwog
ICAgY2hhciogcmVtb3VudF9yb19zdGFydCA9IHN0cnN0cihvcHRzLCAiZXJyb3JzPXJlbW91
bnQtcm8iKTsKICAgIGlmIChyZW1vdW50X3JvX3N0YXJ0ICE9IE5VTEwpIHsKICAgICAgY2hh
ciBhZnRlciA9ICoocmVtb3VudF9yb19zdGFydCArIHN0cmxlbigiZXJyb3JzPXJlbW91bnQt
cm8iKSk7CiAgICAgIGNoYXIgYmVmb3JlID0gcmVtb3VudF9yb19zdGFydCA9PSBvcHRzID8g
J1wwJyA6ICoocmVtb3VudF9yb19zdGFydCAtIDEpOwogICAgICBoYXNfcmVtb3VudF9ybyA9
ICgoYmVmb3JlID09ICdcMCcgfHwgYmVmb3JlID09ICcsJykgJiYKICAgICAgICAgICAgICAg
ICAgICAgICAgKGFmdGVyID09ICdcMCcgfHwgYWZ0ZXIgPT0gJywnKSk7CiAgICB9CiAgICBp
ZiAoc3Ryc3RyKG9wdHMsICJlcnJvcnM9cGFuaWMiKSB8fCAhaGFzX3JlbW91bnRfcm8pCiAg
ICAgIHN0cmNhdChvcHRzLCAiLGVycm9ycz1jb250aW51ZSIpOwogIH0gZWxzZSBpZiAoc3Ry
Y21wKGZzLCAieGZzIikgPT0gMCkgewogICAgc3RyY2F0KG9wdHMsICIsbm91dWlkIik7CiAg
fQogIHJlcyA9IG1vdW50KHNvdXJjZSwgdGFyZ2V0LCBmcywgZmxhZ3MsIG9wdHMpOwogIGlm
IChyZXMgPT0gLTEpIHsKICAgIGVyciA9IGVycm5vOwogICAgZ290byBlcnJvcl9jbGVhcl9s
b29wOwogIH0KICByZXMgPSBvcGVuKHRhcmdldCwgT19SRE9OTFkgfCBPX0RJUkVDVE9SWSk7
CiAgaWYgKHJlcyA9PSAtMSkgewogICAgZXJyID0gZXJybm87CiAgICBnb3RvIGVycm9yX2Ns
ZWFyX2xvb3A7CiAgfQogIGlmIChjaGFuZ2VfZGlyKSB7CiAgICByZXMgPSBjaGRpcih0YXJn
ZXQpOwogICAgaWYgKHJlcyA9PSAtMSkgewogICAgICBlcnIgPSBlcnJubzsKICAgIH0KICB9
CgplcnJvcl9jbGVhcl9sb29wOgogIGlmIChuZWVkX2xvb3BfZGV2aWNlKSB7CiAgICBpb2N0
bChsb29wZmQsIExPT1BfQ0xSX0ZELCAwKTsKICAgIGNsb3NlKGxvb3BmZCk7CiAgfQogIGVy
cm5vID0gZXJyOwogIHJldHVybiByZXM7Cn0KCnN0YXRpYyB2b2lkIG1vdW50X2Nncm91cHMo
Y29uc3QgY2hhciogZGlyLCBjb25zdCBjaGFyKiogY29udHJvbGxlcnMsIGludCBjb3VudCkK
ewogIGlmIChta2RpcihkaXIsIDA3NzcpKSB7CiAgICByZXR1cm47CiAgfQogIGNoYXIgZW5h
YmxlZFsxMjhdID0gezB9OwogIGludCBpID0gMDsKICBmb3IgKDsgaSA8IGNvdW50OyBpKysp
IHsKICAgIGlmIChtb3VudCgibm9uZSIsIGRpciwgImNncm91cCIsIDAsIGNvbnRyb2xsZXJz
W2ldKSkgewogICAgICBjb250aW51ZTsKICAgIH0KICAgIHVtb3VudChkaXIpOwogICAgc3Ry
Y2F0KGVuYWJsZWQsICIsIik7CiAgICBzdHJjYXQoZW5hYmxlZCwgY29udHJvbGxlcnNbaV0p
OwogIH0KICBpZiAoZW5hYmxlZFswXSA9PSAwKSB7CiAgICBpZiAocm1kaXIoZGlyKSAmJiBl
cnJubyAhPSBFQlVTWSkKICAgICAgZXhpdCgxKTsKICAgIHJldHVybjsKICB9CiAgaWYgKG1v
dW50KCJub25lIiwgZGlyLCAiY2dyb3VwIiwgMCwgZW5hYmxlZCArIDEpKSB7CiAgICBpZiAo
cm1kaXIoZGlyKSAmJiBlcnJubyAhPSBFQlVTWSkKICAgICAgZXhpdCgxKTsKICB9CiAgaWYg
KGNobW9kKGRpciwgMDc3NykpIHsKICB9Cn0KCnN0YXRpYyB2b2lkIG1vdW50X2Nncm91cHMy
KGNvbnN0IGNoYXIqKiBjb250cm9sbGVycywgaW50IGNvdW50KQp7CiAgaWYgKG1rZGlyKCIv
c3l6Y2dyb3VwL3VuaWZpZWQiLCAwNzc3KSkgewogICAgcmV0dXJuOwogIH0KICBpZiAobW91
bnQoIm5vbmUiLCAiL3N5emNncm91cC91bmlmaWVkIiwgImNncm91cDIiLCAwLCBOVUxMKSkg
ewogICAgaWYgKHJtZGlyKCIvc3l6Y2dyb3VwL3VuaWZpZWQiKSAmJiBlcnJubyAhPSBFQlVT
WSkKICAgICAgZXhpdCgxKTsKICAgIHJldHVybjsKICB9CiAgaWYgKGNobW9kKCIvc3l6Y2dy
b3VwL3VuaWZpZWQiLCAwNzc3KSkgewogIH0KICBpbnQgY29udHJvbCA9IG9wZW4oIi9zeXpj
Z3JvdXAvdW5pZmllZC9jZ3JvdXAuc3VidHJlZV9jb250cm9sIiwgT19XUk9OTFkpOwogIGlm
IChjb250cm9sID09IC0xKQogICAgcmV0dXJuOwogIGludCBpOwogIGZvciAoaSA9IDA7IGkg
PCBjb3VudDsgaSsrKQogICAgaWYgKHdyaXRlKGNvbnRyb2wsIGNvbnRyb2xsZXJzW2ldLCBz
dHJsZW4oY29udHJvbGxlcnNbaV0pKSA8IDApIHsKICAgIH0KICBjbG9zZShjb250cm9sKTsK
fQoKc3RhdGljIHZvaWQgc2V0dXBfY2dyb3VwcygpCnsKICBjb25zdCBjaGFyKiB1bmlmaWVk
X2NvbnRyb2xsZXJzW10gPSB7IitjcHUiLCAiK2lvIiwgIitwaWRzIn07CiAgY29uc3QgY2hh
ciogbmV0X2NvbnRyb2xsZXJzW10gPSB7Im5ldCIsICJuZXRfcHJpbyIsICJkZXZpY2VzIiwg
ImJsa2lvIiwKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAiZnJlZXplciJ9
OwogIGNvbnN0IGNoYXIqIGNwdV9jb250cm9sbGVyc1tdID0geyJjcHVzZXQiLCAiY3B1YWNj
dCIsICJodWdldGxiIiwgInJsaW1pdCIsCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIm1lbW9yeSJ9OwogIGlmIChta2RpcigiL3N5emNncm91cCIsIDA3NzcpKSB7CiAg
ICByZXR1cm47CiAgfQogIG1vdW50X2Nncm91cHMyKHVuaWZpZWRfY29udHJvbGxlcnMsCiAg
ICAgICAgICAgICAgICAgc2l6ZW9mKHVuaWZpZWRfY29udHJvbGxlcnMpIC8gc2l6ZW9mKHVu
aWZpZWRfY29udHJvbGxlcnNbMF0pKTsKICBtb3VudF9jZ3JvdXBzKCIvc3l6Y2dyb3VwL25l
dCIsIG5ldF9jb250cm9sbGVycywKICAgICAgICAgICAgICAgIHNpemVvZihuZXRfY29udHJv
bGxlcnMpIC8gc2l6ZW9mKG5ldF9jb250cm9sbGVyc1swXSkpOwogIG1vdW50X2Nncm91cHMo
Ii9zeXpjZ3JvdXAvY3B1IiwgY3B1X2NvbnRyb2xsZXJzLAogICAgICAgICAgICAgICAgc2l6
ZW9mKGNwdV9jb250cm9sbGVycykgLyBzaXplb2YoY3B1X2NvbnRyb2xsZXJzWzBdKSk7CiAg
d3JpdGVfZmlsZSgiL3N5emNncm91cC9jcHUvY2dyb3VwLmNsb25lX2NoaWxkcmVuIiwgIjEi
KTsKICB3cml0ZV9maWxlKCIvc3l6Y2dyb3VwL2NwdS9jcHVzZXQubWVtb3J5X3ByZXNzdXJl
X2VuYWJsZWQiLCAiMSIpOwp9CgpzdGF0aWMgdm9pZCBzZXR1cF9jZ3JvdXBzX2xvb3AoKQp7
CiAgaW50IHBpZCA9IGdldHBpZCgpOwogIGNoYXIgZmlsZVsxMjhdOwogIGNoYXIgY2dyb3Vw
ZGlyWzY0XTsKICBzbnByaW50ZihjZ3JvdXBkaXIsIHNpemVvZihjZ3JvdXBkaXIpLCAiL3N5
emNncm91cC91bmlmaWVkL3N5eiVsbHUiLCBwcm9jaWQpOwogIGlmIChta2RpcihjZ3JvdXBk
aXIsIDA3NzcpKSB7CiAgfQogIHNucHJpbnRmKGZpbGUsIHNpemVvZihmaWxlKSwgIiVzL3Bp
ZHMubWF4IiwgY2dyb3VwZGlyKTsKICB3cml0ZV9maWxlKGZpbGUsICIzMiIpOwogIHNucHJp
bnRmKGZpbGUsIHNpemVvZihmaWxlKSwgIiVzL2Nncm91cC5wcm9jcyIsIGNncm91cGRpcik7
CiAgd3JpdGVfZmlsZShmaWxlLCAiJWQiLCBwaWQpOwogIHNucHJpbnRmKGNncm91cGRpciwg
c2l6ZW9mKGNncm91cGRpciksICIvc3l6Y2dyb3VwL2NwdS9zeXolbGx1IiwgcHJvY2lkKTsK
ICBpZiAobWtkaXIoY2dyb3VwZGlyLCAwNzc3KSkgewogIH0KICBzbnByaW50ZihmaWxlLCBz
aXplb2YoZmlsZSksICIlcy9jZ3JvdXAucHJvY3MiLCBjZ3JvdXBkaXIpOwogIHdyaXRlX2Zp
bGUoZmlsZSwgIiVkIiwgcGlkKTsKICBzbnByaW50ZihmaWxlLCBzaXplb2YoZmlsZSksICIl
cy9tZW1vcnkuc29mdF9saW1pdF9pbl9ieXRlcyIsIGNncm91cGRpcik7CiAgd3JpdGVfZmls
ZShmaWxlLCAiJWQiLCAyOTkgPDwgMjApOwogIHNucHJpbnRmKGZpbGUsIHNpemVvZihmaWxl
KSwgIiVzL21lbW9yeS5saW1pdF9pbl9ieXRlcyIsIGNncm91cGRpcik7CiAgd3JpdGVfZmls
ZShmaWxlLCAiJWQiLCAzMDAgPDwgMjApOwogIHNucHJpbnRmKGNncm91cGRpciwgc2l6ZW9m
KGNncm91cGRpciksICIvc3l6Y2dyb3VwL25ldC9zeXolbGx1IiwgcHJvY2lkKTsKICBpZiAo
bWtkaXIoY2dyb3VwZGlyLCAwNzc3KSkgewogIH0KICBzbnByaW50ZihmaWxlLCBzaXplb2Yo
ZmlsZSksICIlcy9jZ3JvdXAucHJvY3MiLCBjZ3JvdXBkaXIpOwogIHdyaXRlX2ZpbGUoZmls
ZSwgIiVkIiwgcGlkKTsKfQoKc3RhdGljIHZvaWQgc2V0dXBfY2dyb3Vwc190ZXN0KCkKewog
IGNoYXIgY2dyb3VwZGlyWzY0XTsKICBzbnByaW50ZihjZ3JvdXBkaXIsIHNpemVvZihjZ3Jv
dXBkaXIpLCAiL3N5emNncm91cC91bmlmaWVkL3N5eiVsbHUiLCBwcm9jaWQpOwogIGlmIChz
eW1saW5rKGNncm91cGRpciwgIi4vY2dyb3VwIikpIHsKICB9CiAgc25wcmludGYoY2dyb3Vw
ZGlyLCBzaXplb2YoY2dyb3VwZGlyKSwgIi9zeXpjZ3JvdXAvY3B1L3N5eiVsbHUiLCBwcm9j
aWQpOwogIGlmIChzeW1saW5rKGNncm91cGRpciwgIi4vY2dyb3VwLmNwdSIpKSB7CiAgfQog
IHNucHJpbnRmKGNncm91cGRpciwgc2l6ZW9mKGNncm91cGRpciksICIvc3l6Y2dyb3VwL25l
dC9zeXolbGx1IiwgcHJvY2lkKTsKICBpZiAoc3ltbGluayhjZ3JvdXBkaXIsICIuL2Nncm91
cC5uZXQiKSkgewogIH0KfQoKc3RhdGljIHZvaWQgc2V0dXBfY29tbW9uKCkKewogIGlmICht
b3VudCgwLCAiL3N5cy9mcy9mdXNlL2Nvbm5lY3Rpb25zIiwgImZ1c2VjdGwiLCAwLCAwKSkg
ewogIH0KfQoKc3RhdGljIHZvaWQgc2V0dXBfYmluZGVyZnMoKQp7CiAgaWYgKG1rZGlyKCIv
ZGV2L2JpbmRlcmZzIiwgMDc3NykpIHsKICB9CiAgaWYgKG1vdW50KCJiaW5kZXIiLCAiL2Rl
di9iaW5kZXJmcyIsICJiaW5kZXIiLCAwLCBOVUxMKSkgewogIH0KfQoKc3RhdGljIHZvaWQg
bG9vcCgpOwoKc3RhdGljIHZvaWQgc2FuZGJveF9jb21tb24oKQp7CiAgcHJjdGwoUFJfU0VU
X1BERUFUSFNJRywgU0lHS0lMTCwgMCwgMCwgMCk7CiAgc2V0c2lkKCk7CiAgc3RydWN0IHJs
aW1pdCBybGltOwogIHJsaW0ucmxpbV9jdXIgPSBybGltLnJsaW1fbWF4ID0gKDIwMCA8PCAy
MCk7CiAgc2V0cmxpbWl0KFJMSU1JVF9BUywgJnJsaW0pOwogIHJsaW0ucmxpbV9jdXIgPSBy
bGltLnJsaW1fbWF4ID0gMzIgPDwgMjA7CiAgc2V0cmxpbWl0KFJMSU1JVF9NRU1MT0NLLCAm
cmxpbSk7CiAgcmxpbS5ybGltX2N1ciA9IHJsaW0ucmxpbV9tYXggPSAxMzYgPDwgMjA7CiAg
c2V0cmxpbWl0KFJMSU1JVF9GU0laRSwgJnJsaW0pOwogIHJsaW0ucmxpbV9jdXIgPSBybGlt
LnJsaW1fbWF4ID0gMSA8PCAyMDsKICBzZXRybGltaXQoUkxJTUlUX1NUQUNLLCAmcmxpbSk7
CiAgcmxpbS5ybGltX2N1ciA9IHJsaW0ucmxpbV9tYXggPSAxMjggPDwgMjA7CiAgc2V0cmxp
bWl0KFJMSU1JVF9DT1JFLCAmcmxpbSk7CiAgcmxpbS5ybGltX2N1ciA9IHJsaW0ucmxpbV9t
YXggPSAyNTY7CiAgc2V0cmxpbWl0KFJMSU1JVF9OT0ZJTEUsICZybGltKTsKICBpZiAodW5z
aGFyZShDTE9ORV9ORVdOUykpIHsKICB9CiAgaWYgKG1vdW50KE5VTEwsICIvIiwgTlVMTCwg
TVNfUkVDIHwgTVNfUFJJVkFURSwgTlVMTCkpIHsKICB9CiAgaWYgKHVuc2hhcmUoQ0xPTkVf
TkVXSVBDKSkgewogIH0KICBpZiAodW5zaGFyZSgweDAyMDAwMDAwKSkgewogIH0KICBpZiAo
dW5zaGFyZShDTE9ORV9ORVdVVFMpKSB7CiAgfQogIGlmICh1bnNoYXJlKENMT05FX1NZU1ZT
RU0pKSB7CiAgfQogIHR5cGVkZWYgc3RydWN0IHsKICAgIGNvbnN0IGNoYXIqIG5hbWU7CiAg
ICBjb25zdCBjaGFyKiB2YWx1ZTsKICB9IHN5c2N0bF90OwogIHN0YXRpYyBjb25zdCBzeXNj
dGxfdCBzeXNjdGxzW10gPSB7CiAgICAgIHsiL3Byb2Mvc3lzL2tlcm5lbC9zaG1tYXgiLCAi
MTY3NzcyMTYifSwKICAgICAgeyIvcHJvYy9zeXMva2VybmVsL3NobWFsbCIsICI1MzY4NzA5
MTIifSwKICAgICAgeyIvcHJvYy9zeXMva2VybmVsL3NobW1uaSIsICIxMDI0In0sCiAgICAg
IHsiL3Byb2Mvc3lzL2tlcm5lbC9tc2dtYXgiLCAiODE5MiJ9LAogICAgICB7Ii9wcm9jL3N5
cy9rZXJuZWwvbXNnbW5pIiwgIjEwMjQifSwKICAgICAgeyIvcHJvYy9zeXMva2VybmVsL21z
Z21uYiIsICIxMDI0In0sCiAgICAgIHsiL3Byb2Mvc3lzL2tlcm5lbC9zZW0iLCAiMTAyNCAx
MDQ4NTc2IDUwMCAxMDI0In0sCiAgfTsKICB1bnNpZ25lZCBpOwogIGZvciAoaSA9IDA7IGkg
PCBzaXplb2Yoc3lzY3RscykgLyBzaXplb2Yoc3lzY3Rsc1swXSk7IGkrKykKICAgIHdyaXRl
X2ZpbGUoc3lzY3Rsc1tpXS5uYW1lLCBzeXNjdGxzW2ldLnZhbHVlKTsKfQoKc3RhdGljIGlu
dCB3YWl0X2Zvcl9sb29wKGludCBwaWQpCnsKICBpZiAocGlkIDwgMCkKICAgIGV4aXQoMSk7
CiAgaW50IHN0YXR1cyA9IDA7CiAgd2hpbGUgKHdhaXRwaWQoLTEsICZzdGF0dXMsIF9fV0FM
TCkgIT0gcGlkKSB7CiAgfQogIHJldHVybiBXRVhJVFNUQVRVUyhzdGF0dXMpOwp9CgpzdGF0
aWMgdm9pZCBkcm9wX2NhcHModm9pZCkKewogIHN0cnVjdCBfX3VzZXJfY2FwX2hlYWRlcl9z
dHJ1Y3QgY2FwX2hkciA9IHt9OwogIHN0cnVjdCBfX3VzZXJfY2FwX2RhdGFfc3RydWN0IGNh
cF9kYXRhWzJdID0ge307CiAgY2FwX2hkci52ZXJzaW9uID0gX0xJTlVYX0NBUEFCSUxJVFlf
VkVSU0lPTl8zOwogIGNhcF9oZHIucGlkID0gZ2V0cGlkKCk7CiAgaWYgKHN5c2NhbGwoU1lT
X2NhcGdldCwgJmNhcF9oZHIsICZjYXBfZGF0YSkpCiAgICBleGl0KDEpOwogIGNvbnN0IGlu
dCBkcm9wID0gKDEgPDwgQ0FQX1NZU19QVFJBQ0UpIHwgKDEgPDwgQ0FQX1NZU19OSUNFKTsK
ICBjYXBfZGF0YVswXS5lZmZlY3RpdmUgJj0gfmRyb3A7CiAgY2FwX2RhdGFbMF0ucGVybWl0
dGVkICY9IH5kcm9wOwogIGNhcF9kYXRhWzBdLmluaGVyaXRhYmxlICY9IH5kcm9wOwogIGlm
IChzeXNjYWxsKFNZU19jYXBzZXQsICZjYXBfaGRyLCAmY2FwX2RhdGEpKQogICAgZXhpdCgx
KTsKfQoKc3RhdGljIGludCBkb19zYW5kYm94X25vbmUodm9pZCkKewogIGlmICh1bnNoYXJl
KENMT05FX05FV1BJRCkpIHsKICB9CiAgaW50IHBpZCA9IGZvcmsoKTsKICBpZiAocGlkICE9
IDApCiAgICByZXR1cm4gd2FpdF9mb3JfbG9vcChwaWQpOwogIHNldHVwX2NvbW1vbigpOwog
IHNhbmRib3hfY29tbW9uKCk7CiAgZHJvcF9jYXBzKCk7CiAgaWYgKHVuc2hhcmUoQ0xPTkVf
TkVXTkVUKSkgewogIH0KICB3cml0ZV9maWxlKCIvcHJvYy9zeXMvbmV0L2lwdjQvcGluZ19n
cm91cF9yYW5nZSIsICIwIDY1NTM1Iik7CiAgc2V0dXBfYmluZGVyZnMoKTsKICBsb29wKCk7
CiAgZXhpdCgxKTsKfQoKI2RlZmluZSBGU19JT0NfU0VURkxBR1MgX0lPVygnZicsIDIsIGxv
bmcpCnN0YXRpYyB2b2lkIHJlbW92ZV9kaXIoY29uc3QgY2hhciogZGlyKQp7CiAgaW50IGl0
ZXIgPSAwOwogIERJUiogZHAgPSAwOwpyZXRyeToKICB3aGlsZSAodW1vdW50MihkaXIsIE1O
VF9ERVRBQ0ggfCBVTU9VTlRfTk9GT0xMT1cpID09IDApIHsKICB9CiAgZHAgPSBvcGVuZGly
KGRpcik7CiAgaWYgKGRwID09IE5VTEwpIHsKICAgIGlmIChlcnJubyA9PSBFTUZJTEUpIHsK
ICAgICAgZXhpdCgxKTsKICAgIH0KICAgIGV4aXQoMSk7CiAgfQogIHN0cnVjdCBkaXJlbnQq
IGVwID0gMDsKICB3aGlsZSAoKGVwID0gcmVhZGRpcihkcCkpKSB7CiAgICBpZiAoc3RyY21w
KGVwLT5kX25hbWUsICIuIikgPT0gMCB8fCBzdHJjbXAoZXAtPmRfbmFtZSwgIi4uIikgPT0g
MCkKICAgICAgY29udGludWU7CiAgICBjaGFyIGZpbGVuYW1lW0ZJTEVOQU1FX01BWF07CiAg
ICBzbnByaW50ZihmaWxlbmFtZSwgc2l6ZW9mKGZpbGVuYW1lKSwgIiVzLyVzIiwgZGlyLCBl
cC0+ZF9uYW1lKTsKICAgIHdoaWxlICh1bW91bnQyKGZpbGVuYW1lLCBNTlRfREVUQUNIIHwg
VU1PVU5UX05PRk9MTE9XKSA9PSAwKSB7CiAgICB9CiAgICBzdHJ1Y3Qgc3RhdCBzdDsKICAg
IGlmIChsc3RhdChmaWxlbmFtZSwgJnN0KSkKICAgICAgZXhpdCgxKTsKICAgIGlmIChTX0lT
RElSKHN0LnN0X21vZGUpKSB7CiAgICAgIHJlbW92ZV9kaXIoZmlsZW5hbWUpOwogICAgICBj
b250aW51ZTsKICAgIH0KICAgIGludCBpOwogICAgZm9yIChpID0gMDs7IGkrKykgewogICAg
ICBpZiAodW5saW5rKGZpbGVuYW1lKSA9PSAwKQogICAgICAgIGJyZWFrOwogICAgICBpZiAo
ZXJybm8gPT0gRVBFUk0pIHsKICAgICAgICBpbnQgZmQgPSBvcGVuKGZpbGVuYW1lLCBPX1JE
T05MWSk7CiAgICAgICAgaWYgKGZkICE9IC0xKSB7CiAgICAgICAgICBsb25nIGZsYWdzID0g
MDsKICAgICAgICAgIGlmIChpb2N0bChmZCwgRlNfSU9DX1NFVEZMQUdTLCAmZmxhZ3MpID09
IDApIHsKICAgICAgICAgIH0KICAgICAgICAgIGNsb3NlKGZkKTsKICAgICAgICAgIGNvbnRp
bnVlOwogICAgICAgIH0KICAgICAgfQogICAgICBpZiAoZXJybm8gPT0gRVJPRlMpIHsKICAg
ICAgICBicmVhazsKICAgICAgfQogICAgICBpZiAoZXJybm8gIT0gRUJVU1kgfHwgaSA+IDEw
MCkKICAgICAgICBleGl0KDEpOwogICAgICBpZiAodW1vdW50MihmaWxlbmFtZSwgTU5UX0RF
VEFDSCB8IFVNT1VOVF9OT0ZPTExPVykpCiAgICAgICAgZXhpdCgxKTsKICAgIH0KICB9CiAg
Y2xvc2VkaXIoZHApOwogIGZvciAoaW50IGkgPSAwOzsgaSsrKSB7CiAgICBpZiAocm1kaXIo
ZGlyKSA9PSAwKQogICAgICBicmVhazsKICAgIGlmIChpIDwgMTAwKSB7CiAgICAgIGlmIChl
cnJubyA9PSBFUEVSTSkgewogICAgICAgIGludCBmZCA9IG9wZW4oZGlyLCBPX1JET05MWSk7
CiAgICAgICAgaWYgKGZkICE9IC0xKSB7CiAgICAgICAgICBsb25nIGZsYWdzID0gMDsKICAg
ICAgICAgIGlmIChpb2N0bChmZCwgRlNfSU9DX1NFVEZMQUdTLCAmZmxhZ3MpID09IDApIHsK
ICAgICAgICAgIH0KICAgICAgICAgIGNsb3NlKGZkKTsKICAgICAgICAgIGNvbnRpbnVlOwog
ICAgICAgIH0KICAgICAgfQogICAgICBpZiAoZXJybm8gPT0gRVJPRlMpIHsKICAgICAgICBi
cmVhazsKICAgICAgfQogICAgICBpZiAoZXJybm8gPT0gRUJVU1kpIHsKICAgICAgICBpZiAo
dW1vdW50MihkaXIsIE1OVF9ERVRBQ0ggfCBVTU9VTlRfTk9GT0xMT1cpKQogICAgICAgICAg
ZXhpdCgxKTsKICAgICAgICBjb250aW51ZTsKICAgICAgfQogICAgICBpZiAoZXJybm8gPT0g
RU5PVEVNUFRZKSB7CiAgICAgICAgaWYgKGl0ZXIgPCAxMDApIHsKICAgICAgICAgIGl0ZXIr
KzsKICAgICAgICAgIGdvdG8gcmV0cnk7CiAgICAgICAgfQogICAgICB9CiAgICB9CiAgICBl
eGl0KDEpOwogIH0KfQoKc3RhdGljIHZvaWQga2lsbF9hbmRfd2FpdChpbnQgcGlkLCBpbnQq
IHN0YXR1cykKewogIGtpbGwoLXBpZCwgU0lHS0lMTCk7CiAga2lsbChwaWQsIFNJR0tJTEwp
OwogIGZvciAoaW50IGkgPSAwOyBpIDwgMTAwOyBpKyspIHsKICAgIGlmICh3YWl0cGlkKC0x
LCBzdGF0dXMsIFdOT0hBTkcgfCBfX1dBTEwpID09IHBpZCkKICAgICAgcmV0dXJuOwogICAg
dXNsZWVwKDEwMDApOwogIH0KICBESVIqIGRpciA9IG9wZW5kaXIoIi9zeXMvZnMvZnVzZS9j
b25uZWN0aW9ucyIpOwogIGlmIChkaXIpIHsKICAgIGZvciAoOzspIHsKICAgICAgc3RydWN0
IGRpcmVudCogZW50ID0gcmVhZGRpcihkaXIpOwogICAgICBpZiAoIWVudCkKICAgICAgICBi
cmVhazsKICAgICAgaWYgKHN0cmNtcChlbnQtPmRfbmFtZSwgIi4iKSA9PSAwIHx8IHN0cmNt
cChlbnQtPmRfbmFtZSwgIi4uIikgPT0gMCkKICAgICAgICBjb250aW51ZTsKICAgICAgY2hh
ciBhYm9ydFszMDBdOwogICAgICBzbnByaW50ZihhYm9ydCwgc2l6ZW9mKGFib3J0KSwgIi9z
eXMvZnMvZnVzZS9jb25uZWN0aW9ucy8lcy9hYm9ydCIsCiAgICAgICAgICAgICAgIGVudC0+
ZF9uYW1lKTsKICAgICAgaW50IGZkID0gb3BlbihhYm9ydCwgT19XUk9OTFkpOwogICAgICBp
ZiAoZmQgPT0gLTEpIHsKICAgICAgICBjb250aW51ZTsKICAgICAgfQogICAgICBpZiAod3Jp
dGUoZmQsIGFib3J0LCAxKSA8IDApIHsKICAgICAgfQogICAgICBjbG9zZShmZCk7CiAgICB9
CiAgICBjbG9zZWRpcihkaXIpOwogIH0gZWxzZSB7CiAgfQogIHdoaWxlICh3YWl0cGlkKC0x
LCBzdGF0dXMsIF9fV0FMTCkgIT0gcGlkKSB7CiAgfQp9CgpzdGF0aWMgdm9pZCBzZXR1cF9s
b29wKCkKewogIHNldHVwX2Nncm91cHNfbG9vcCgpOwp9CgpzdGF0aWMgdm9pZCByZXNldF9s
b29wKCkKewogIGNoYXIgYnVmWzY0XTsKICBzbnByaW50ZihidWYsIHNpemVvZihidWYpLCAi
L2Rldi9sb29wJWxsdSIsIHByb2NpZCk7CiAgaW50IGxvb3BmZCA9IG9wZW4oYnVmLCBPX1JE
V1IpOwogIGlmIChsb29wZmQgIT0gLTEpIHsKICAgIGlvY3RsKGxvb3BmZCwgTE9PUF9DTFJf
RkQsIDApOwogICAgY2xvc2UobG9vcGZkKTsKICB9Cn0KCnN0YXRpYyB2b2lkIHNldHVwX3Rl
c3QoKQp7CiAgcHJjdGwoUFJfU0VUX1BERUFUSFNJRywgU0lHS0lMTCwgMCwgMCwgMCk7CiAg
c2V0cGdycCgpOwogIHNldHVwX2Nncm91cHNfdGVzdCgpOwogIHdyaXRlX2ZpbGUoIi9wcm9j
L3NlbGYvb29tX3Njb3JlX2FkaiIsICIxMDAwIik7CiAgaWYgKHN5bWxpbmsoIi9kZXYvYmlu
ZGVyZnMiLCAiLi9iaW5kZXJmcyIpKSB7CiAgfQp9CgpzdGF0aWMgdm9pZCBjbG9zZV9mZHMo
KQp7CiAgZm9yIChpbnQgZmQgPSAzOyBmZCA8IE1BWF9GRFM7IGZkKyspCiAgICBjbG9zZShm
ZCk7Cn0KCnN0cnVjdCB0aHJlYWRfdCB7CiAgaW50IGNyZWF0ZWQsIGNhbGw7CiAgZXZlbnRf
dCByZWFkeSwgZG9uZTsKfTsKCnN0YXRpYyBzdHJ1Y3QgdGhyZWFkX3QgdGhyZWFkc1sxNl07
CnN0YXRpYyB2b2lkIGV4ZWN1dGVfY2FsbChpbnQgY2FsbCk7CnN0YXRpYyBpbnQgcnVubmlu
ZzsKCnN0YXRpYyB2b2lkKiB0aHIodm9pZCogYXJnKQp7CiAgc3RydWN0IHRocmVhZF90KiB0
aCA9IChzdHJ1Y3QgdGhyZWFkX3QqKWFyZzsKICBmb3IgKDs7KSB7CiAgICBldmVudF93YWl0
KCZ0aC0+cmVhZHkpOwogICAgZXZlbnRfcmVzZXQoJnRoLT5yZWFkeSk7CiAgICBleGVjdXRl
X2NhbGwodGgtPmNhbGwpOwogICAgX19hdG9taWNfZmV0Y2hfc3ViKCZydW5uaW5nLCAxLCBf
X0FUT01JQ19SRUxBWEVEKTsKICAgIGV2ZW50X3NldCgmdGgtPmRvbmUpOwogIH0KICByZXR1
cm4gMDsKfQoKc3RhdGljIHZvaWQgZXhlY3V0ZV9vbmUodm9pZCkKewogIGludCBpLCBjYWxs
LCB0aHJlYWQ7CiAgZm9yIChjYWxsID0gMDsgY2FsbCA8IDg7IGNhbGwrKykgewogICAgZm9y
ICh0aHJlYWQgPSAwOyB0aHJlYWQgPCAoaW50KShzaXplb2YodGhyZWFkcykgLyBzaXplb2Yo
dGhyZWFkc1swXSkpOwogICAgICAgICB0aHJlYWQrKykgewogICAgICBzdHJ1Y3QgdGhyZWFk
X3QqIHRoID0gJnRocmVhZHNbdGhyZWFkXTsKICAgICAgaWYgKCF0aC0+Y3JlYXRlZCkgewog
ICAgICAgIHRoLT5jcmVhdGVkID0gMTsKICAgICAgICBldmVudF9pbml0KCZ0aC0+cmVhZHkp
OwogICAgICAgIGV2ZW50X2luaXQoJnRoLT5kb25lKTsKICAgICAgICBldmVudF9zZXQoJnRo
LT5kb25lKTsKICAgICAgICB0aHJlYWRfc3RhcnQodGhyLCB0aCk7CiAgICAgIH0KICAgICAg
aWYgKCFldmVudF9pc3NldCgmdGgtPmRvbmUpKQogICAgICAgIGNvbnRpbnVlOwogICAgICBl
dmVudF9yZXNldCgmdGgtPmRvbmUpOwogICAgICB0aC0+Y2FsbCA9IGNhbGw7CiAgICAgIF9f
YXRvbWljX2ZldGNoX2FkZCgmcnVubmluZywgMSwgX19BVE9NSUNfUkVMQVhFRCk7CiAgICAg
IGV2ZW50X3NldCgmdGgtPnJlYWR5KTsKICAgICAgaWYgKGNhbGwgPT0gMSB8fCBjYWxsID09
IDMpCiAgICAgICAgYnJlYWs7CiAgICAgIGV2ZW50X3RpbWVkd2FpdCgmdGgtPmRvbmUsIDUw
ICsgKGNhbGwgPT0gMCA/IDQwMDAgOiAwKSk7CiAgICAgIGJyZWFrOwogICAgfQogIH0KICBm
b3IgKGkgPSAwOyBpIDwgMTAwICYmIF9fYXRvbWljX2xvYWRfbigmcnVubmluZywgX19BVE9N
SUNfUkVMQVhFRCk7IGkrKykKICAgIHNsZWVwX21zKDEpOwogIGNsb3NlX2ZkcygpOwp9Cgpz
dGF0aWMgdm9pZCBleGVjdXRlX29uZSh2b2lkKTsKCiNkZWZpbmUgV0FJVF9GTEFHUyBfX1dB
TEwKCnN0YXRpYyB2b2lkIGxvb3Aodm9pZCkKewogIHNldHVwX2xvb3AoKTsKICBpbnQgaXRl
ciA9IDA7CiAgZm9yICg7OyBpdGVyKyspIHsKICAgIGNoYXIgY3dkYnVmWzMyXTsKICAgIHNw
cmludGYoY3dkYnVmLCAiLi8lZCIsIGl0ZXIpOwogICAgaWYgKG1rZGlyKGN3ZGJ1ZiwgMDc3
NykpCiAgICAgIGV4aXQoMSk7CiAgICByZXNldF9sb29wKCk7CiAgICBpbnQgcGlkID0gZm9y
aygpOwogICAgaWYgKHBpZCA8IDApCiAgICAgIGV4aXQoMSk7CiAgICBpZiAocGlkID09IDAp
IHsKICAgICAgaWYgKGNoZGlyKGN3ZGJ1ZikpCiAgICAgICAgZXhpdCgxKTsKICAgICAgc2V0
dXBfdGVzdCgpOwogICAgICBleGVjdXRlX29uZSgpOwogICAgICBleGl0KDApOwogICAgfQog
ICAgaW50IHN0YXR1cyA9IDA7CiAgICB1aW50NjRfdCBzdGFydCA9IGN1cnJlbnRfdGltZV9t
cygpOwogICAgZm9yICg7OykgewogICAgICBpZiAod2FpdHBpZCgtMSwgJnN0YXR1cywgV05P
SEFORyB8IFdBSVRfRkxBR1MpID09IHBpZCkKICAgICAgICBicmVhazsKICAgICAgc2xlZXBf
bXMoMSk7CiAgICAgIGlmIChjdXJyZW50X3RpbWVfbXMoKSAtIHN0YXJ0IDwgNTAwMCkKICAg
ICAgICBjb250aW51ZTsKICAgICAga2lsbF9hbmRfd2FpdChwaWQsICZzdGF0dXMpOwogICAg
ICBicmVhazsKICAgIH0KICAgIHJlbW92ZV9kaXIoY3dkYnVmKTsKICB9Cn0KCnVpbnQ2NF90
IHJbM10gPSB7MHhmZmZmZmZmZmZmZmZmZmZmLCAweGZmZmZmZmZmZmZmZmZmZmYsIDB4ZmZm
ZmZmZmZmZmZmZmZmZn07Cgp2b2lkIGV4ZWN1dGVfY2FsbChpbnQgY2FsbCkKewogIGludHB0
cl90IHJlcyA9IDA7CiAgc3dpdGNoIChjYWxsKSB7CiAgY2FzZSAwOgogICAgbWVtY3B5KCh2
b2lkKikweDIwMDAwMDQwLCAiZXh0NFwwMDAiLCA1KTsKICAgIG1lbWNweSgodm9pZCopMHgy
MDAwMDUwMCwgIi4vZmlsZTFcMDAwIiwgOCk7CiAgICBtZW1jcHkoCiAgICAgICAgKHZvaWQq
KTB4MjAwMDNlODAsCiAgICAgICAgIlx4MDBceGJmXHg2MFx4NDJceGFhXHhhNVx4YzhceDlm
XHgxYVx4YTFceGZjXHhiY1x4YmJceGFhXHg5Y1x4YWNceDMxIgogICAgICAgICJceGIyXHg3
NVx4MDNceGRmXHg1MFx4MDdceDE0XHhkN1x4OTRceDYzXHg0OFx4NjJceGMxXHhlNlx4MGNc
eDZlXHgyMiIKICAgICAgICAiXHhmOVx4MjVceDU2XHg3MVx4M2NceDBmXHhlM1x4ZjRceGUx
XHgzZlx4YTNceDYxXHg4NFx4YTFceDYxXHg0NFx4NzciCiAgICAgICAgIlx4NTZceGRkXHgw
Y1x4ZjhceGRjXHg3ZFx4NWNceGVhXHgwOVx4ODhceGJhXHhmMFx4M2VceGZlXHhiYlx4NjNc
eGJkIgogICAgICAgICJceDdhXHg1OVx4ODNceGYwXHg4MVx4ZjhceDExXHhmMVx4OTdceGI3
XHg4YVx4NWZceDVlXHg5NVx4ODNceDhjXHhjOSIKICAgICAgICAiXHgwZVx4NjRceDQ2XHhk
OFx4MThceDljXHg5MVx4MjFceGIzXHhjY1x4ZjVceGIyXHg0ZFx4NDZceDg0XHgyNFx4MmIi
CiAgICAgICAgIlx4NGZceDg1XHhmNlx4ZDRceDMyXHgzMVx4YjdceGI5XHgyNFx4MGZceDc0
XHhiZFx4YWNceGYzXHg0Y1x4YjhceDYwIgogICAgICAgICJceDRiXHgyMVx4NzlceDY1XHhj
MFx4MmJceDdiXHhlNFx4MTlceDMyXHg2YVx4MzFceDY4XHhjN1x4ZGZceDRlXHhiOCIKICAg
ICAgICAiXHhkY1x4MmVceDdjXHhjMFx4ZDFceGM3XHgwOFx4YTFceDUwXHgyOFx4NzhceDYz
XHgzZVx4Y2FceDQ5XHhmM1x4NTgiCiAgICAgICAgIlx4ZTVceGI4XHg1NVx4NTFceGZmXHg2
ZVx4NDlceDc3XHg2NVx4MDhceGJmXHg0NVx4YjNceGM3XHgxYVx4ZjRceDE1IgogICAgICAg
ICJceDQ4XHg5M1x4NjVceDY0XHhhYlx4ZDlceDliXHhiM1x4NGRceDFjXHgyM1x4MDNceGI1
XHgxY1x4MjlceGQwXHgyZiIKICAgICAgICAiXHhhZVx4MmNceDdmXHgwM1x4N2JceGU0XHhi
NFx4YmNceDYzXHhlYVx4YTZceDhhXHgxZVx4MDhceGUzXHhmYlx4YzAiCiAgICAgICAgIlx4
NzdceDQ0XHhhNVx4ZGRceDEzXHg1NVx4NTNceGRiXHgwMFx4NmZceDFlXHgwYVx4OTBceDcw
XHhiZVx4MDhceDVhIgogICAgICAgICJceDcxXHg4ZFx4NzlceDA2XHhhNlx4OGRceGMyXHg2
ZVx4YzFceGYzXHgxOSIsCiAgICAgICAgMjMyKTsKICAgIG1lbWNweSgKICAgICAgICAodm9p
ZCopMHgyMDAwMDU0MCwKICAgICAgICAiXHg3OFx4OWNceGVjXHhkZFx4ZGZceDZiXHg1Ylx4
ZDdceDFkXHgwMFx4ZjBceGVmXHhiZFx4YjZceGIyXHhmY1x4NzAiCiAgICAgICAgIlx4NjZc
eDY3XHhkYlx4NDNceDE2XHg1OFx4MTZceDk2XHgwY1x4MjdceDZjXHg5MVx4ZWNceDc4XHg0
OVx4Y2NceDFlIgogICAgICAgICJceGIyXHgwY1x4YzZceGYyXHgxNFx4ZDhceDk2XHhiZFx4
NjdceDllXHgyZFx4MWJceDYzXHhkOVx4MzJceDk2XHg5YyIKICAgICAgICAiXHhjNFx4MjZc
eDBjXHg4N1x4ZmRceDAxXHg4M1x4MzFceGQ2XHg0Mlx4OWZceGZhXHhkNFx4OTdceDQyXHhm
Zlx4ODAiCiAgICAgICAgIlx4NDJceGM5XHg5Zlx4NTBceDBhXHg4MVx4ZjZceGJkXHhiNFx4
YTVceGE1XHhiNFx4NDlceGZiXHhkMFx4ODdceGI2IgogICAgICAgICJceDJhXHg5Mlx4YWVc
eGQyXHhjNFx4OTVceDYyXHg4N1x4YzhceGJlXHg2MFx4N2ZceDNlXHg3MFx4N2NceGNmXHhi
OSIKICAgICAgICAiXHg1N1x4ZDJceGY3XHg3Ylx4NmNceDc0XHg3NVx4Y2ZceGJkXHhjN1x4
YmFceDAxXHhlY1x4NWJceGE3XHgyMlx4ZTIiCiAgICAgICAgIlx4NmFceDQ0XHgwY1x4NDRc
eGM0XHhiOVx4ODhceDE4XHhjZVx4ZDZceGE3XHg1OVx4YjlceGQ2XHg2Y1x4NmNceGI0Igog
ICAgICAgICJceDFmXHhmN1x4ZThceGUxXHhkZFx4ZTlceDY2XHg0OVx4YTJceGQxXHhiOFx4
ZjFceDU5XHgxMlx4NDlceGI2XHhhZSIKICAgICAgICAiXHhmM1x4NWFceDQ5XHhiNlx4M2Nc
eGQyXHg3ZVx4NGFceDFjXHg4Y1x4ODhceGJmXHg1ZFx4OGJceGY4XHg2N1x4ZjIiCiAgICAg
ICAgIlx4YzNceGI4XHhiNVx4YjVceGY1XHg4NVx4YTlceDRhXHhhNVx4YmNceDkyXHhiNVx4
NGJceGY1XHhjNVx4ZTVceDUyIgogICAgICAgICJceDZkXHg2ZFx4ZmRceGZjXHhmY1x4ZTJc
eGQ0XHg1Y1x4NzlceGFlXHhiY1x4MzRceDMxXHgzMVx4N2VceDY5XHhmMiIKICAgICAgICAi
XHhmMlx4ZTRceGM1XHhjOVx4YjFceGJlXHhmNFx4NzNceDI0XHgyMlx4YWVceGZjXHhlOVx4
YTNceGZmXHhmZlx4ZTciCiAgICAgICAgIlx4YjVceDNmXHg1Zlx4NzlceGViXHhiN1x4Yjdc
eGRmXHhiZlx4ZjlceGM5XHhkOVx4N2ZceDM1XHhkM1x4MWFceGNhIgogICAgICAgICJceGI2
XHgzZlx4ZDlceDhmXHg3ZVx4NmFceDc3XHhiZFx4ZDBceGZhXHg1ZFx4NzRceDBjXHg0Nlx4
YzRceGNhXHg0ZSIKICAgICAgICAiXHgwNFx4Y2JceGMxXHg0MFx4YjZceDJjXHhlNFx4OWNc
eDA3XHgwMFx4MDBceGRiXHhkM1x4M2NceGM2XHhmZlx4NDkiCiAgICAgICAgIlx4NDRceGZj
XHhhYVx4NzVceGZjXHgzZlx4MWNceDAzXHhhZFx4YTNceDUzXHgwMFx4MDBceDAwXHg2MFx4
MmZceDY5IgogICAgICAgICJceGZjXHg2MVx4MjhceGJlXHg0ZVx4MjJceDFhXHgwMFx4MDBc
eDAwXHhjMFx4OWVceDk1XHhiNlx4ZTZceGMwXHgyNiIKICAgICAgICAiXHg2OVx4MzFceDli
XHgwYlx4MzBceDE0XHg2OVx4NWFceDJjXHhiNlx4ZTdceGYwXHhmZVx4MmNceDBlXHhhN1x4
OTUiCiAgICAgICAgIlx4NmFceGFkXHhmZVx4OWJceGQ5XHhlYVx4ZWFceGQyXHg0Y1x4N2Jc
eGFlXHhlY1x4NDhceDE0XHhkMlx4ZDlceGY5IgogICAgICAgICJceDRhXHg3OVx4MmNceDli
XHgyYlx4M2NceDEyXHg4NVx4YTRceGQ5XHgxZVx4Y2ZceGU2XHhkOFx4NzZceGRhXHgxNyIK
ICAgICAgICAiXHgzNlx4YjVceDI3XHgyMlx4ZTJceDU4XHg0NFx4ZmNceDZmXHhmOFx4NTBc
eGFiXHg1ZFx4OWNceGFlXHg1Nlx4NjYiCiAgICAgICAgIlx4ZjJceDNlXHhmOVx4MDFceDAw
XHgwMFx4MDBceGZiXHhjNFx4OTFceDRkXHhlM1x4ZmZceDJmXHg4N1x4ZGJceGUzIgogICAg
ICAgICJceDdmXHgwMFx4MDBceDAwXHg2MFx4OGZceDE5XHhjOVx4M2JceDAxXHgwMFx4MDBc
eDAwXHg2MFx4YzdceDE5XHhmZiIKICAgICAgICAiXHgwM1x4MDBceDAwXHhjMFx4ZGVceDY3
XHhmY1x4MGZceDAwXHgwMFx4MDBceDdiXHhkYVx4NWZceGFlXHg1Zlx4NmYiCiAgICAgICAg
Ilx4OTZceDQ2XHhlN1x4ZmVceGQ3XHgzM1x4YjdceGQ2XHg1Nlx4MTdceGFhXHhiN1x4Y2Vc
eGNmXHg5NFx4NmJceDBiIgogICAgICAgICJceGM1XHhjNVx4ZDVceGU5XHhlMlx4NzRceDc1
XHg2NVx4YjlceDM4XHg1N1x4YWRceGNlXHhiNVx4YmVceGIzXHg2ZiIKICAgICAgICAiXHg3
MVx4YWJceGQ3XHhhYlx4NTRceGFiXHhjYlx4YmZceDhiXHhhNVx4ZDVceDNiXHhhNVx4N2Fc
eGI5XHg1Nlx4MmYiCiAgICAgICAgIlx4ZDVceGQ2XHhkNlx4NmZceDJlXHg1Nlx4NTdceDk3
XHhlYVx4MzdceGU3XHg5Zlx4YmFceDA1XHgzNlx4MDBceDAwIgogICAgICAgICJceDAwXHhi
MFx4OGJceDhlXHhmZFx4ZjJceGZlXHg3Ylx4NDlceDQ0XHg2Y1x4ZmNceGZlXHg1MFx4YWJc
eDM0XHgxZCIKICAgICAgICAiXHhjOFx4M2JceDI5XHg2MFx4NTdceDI0XHhjZlx4ZjNceGUw
XHgwZlx4NzdceDJlXHgwZlx4NjBceGY3XHgwZFx4ZTQiCiAgICAgICAgIlx4OWRceDAwXHg5
MFx4OWJceGMxXHhiY1x4MTNceDAwXHg3Mlx4NTNceGM4XHgzYlx4MDFceDIwXHg3N1x4NWJc
eDlkIgogICAgICAgICJceDA3XHhlOFx4MzlceDc5XHhlN1x4ZWRceGZlXHhlN1x4MDJceDAw
XHgwMFx4ZWNceDhjXHhkMVx4OWZceGY3XHhiZSIKICAgICAgICAiXHhmZVx4ZWZceGRjXHgw
MFx4ZWNceDZkXHg2OVx4ZGVceDA5XHgwMFx4MDBceGJiXHhjZVx4ZjVceDdmXHhkOFx4YmYi
CiAgICAgICAgIlx4MGFceDY2XHgwMFx4YzJceGJlXHhmN1x4ZTNceDJkXHhiNlx4YmZceGY4
XHhmNVx4ZmZceDQ2XHhlM1x4YjlceDEyIgogICAgICAgICJceDAyXHgwMFx4MDBceGZhXHg2
ZVx4YThceDU1XHg5Mlx4YjRceDk4XHg1ZFx4MGJceDFjXHg4YVx4MzRceDJkXHgxNiIKICAg
ICAgICAiXHgyM1x4OGVceGI2XHg2ZVx4MGJceDUwXHg0OFx4NjZceGU3XHgyYlx4ZTVceGIx
XHg2Y1x4N2NceGYwXHhlZVx4NzAiCiAgICAgICAgIlx4ZTFceDQ3XHhjZFx4ZjZceDc4XHhl
Ylx4OTlceGM5XHhmM1x4ZmRceGVmXHgzMFx4MDBceDAwXHgwMFx4MDBceDAwIgogICAgICAg
ICJceDAwXHgwMFx4MDBceDAwXHgwMFx4MDBceDAwXHgwMFx4MDBceDAwXHgwMFx4MDBceDAw
XHgwMFx4ZWNceDYzXHg4ZCIKICAgICAgICAiXHg0Nlx4MTJceDBkXHgwMFx4MDBceDAwXHg2
MFx4NGZceDhiXHg0OFx4M2ZceDRlXHg1YVx4ZGZceGU2XHgxZlx4MzEiCiAgICAgICAgIlx4
M2FceDdjXHg2Nlx4NjhceGYzXHhmOVx4ODFceDAzXHhjOVx4NTdceGMzXHhhZFx4NjVceDQ0
XHhkY1x4N2VceGU1IgogICAgICAgICJceGM2XHg0Ylx4NzdceGE2XHhlYVx4ZjVceDk1XHhm
MVx4ZTZceGZhXHhjZlx4MWZceGFmXHhhZlx4YmZceDljXHhhZCIKICAgICAgICAiXHhiZlx4
OTBceGM3XHgxOVx4MGNceDAwXHgwMFx4MDBceDYwXHhiM1x4Y2VceDM4XHhiZFx4MzNceDhl
XHgwN1x4MDAiCiAgICAgICAgIlx4MDBceDAwXHgwMFx4MDBceDAwXHgwMFx4MDBceDAwXHgw
MFx4MDBceDAwXHgwMFx4MDBceDAwXHgwMFx4MDBceDAwIgogICAgICAgICJceDAwXHgwMFx4
MDBceDAwXHgwMFx4MDBceDAwXHgwMFx4MDBceDAwXHgwMFx4MDBceDAwXHgwMFx4MDBceDAw
XHgwMCIKICAgICAgICAiXHgwMFx4MDBceDAwXHgwMFx4MDBceDAwXHgwMFx4MDBceDAwXHgw
MFx4MDBceDAwXHgwMFx4MDBceDAwXHgwMFx4MDAiCiAgICAgICAgIlx4MDBceDAwXHg4MFx4
N2VceDdhXHhmNFx4ZjBceGVlXHg3NFx4YTdceGVjXHg2Nlx4ZGNceDRmXHhmZlx4MThceDEx
IgogICAgICAgICJceDIzXHhkZFx4ZTJceDBmXHhjNlx4YzFceGQ2XHhmMlx4NjBceDE0XHgy
Mlx4ZTJceGYwXHgxN1x4NDlceDBjXHgzZSIKICAgICAgICAiXHhmMVx4YmNceDI0XHgyMlx4
MDZceGZhXHgxMFx4N2ZceGUzXHg1ZVx4NDRceDFjXHhlZlx4MTZceDNmXHg2OVx4YTYiCiAg
ICAgICAgIlx4MTVceDIzXHg1OVx4MTZceGRkXHhlMlx4MWZceGNhXHgzMVx4N2VceDFhXHgx
MVx4NDdceGZhXHgxMFx4MWZceGY2IgogICAgICAgICJceGIzXHhmYlx4Y2RceGZkXHhjZlx4
ZDVceDZlXHhlZlx4YmZceDM0XHg0ZVx4YjVceDk2XHhkZFx4ZGZceDdmXHg4MyIKICAgICAg
ICAiXHg1OVx4NzlceDUxXHhiZFx4ZjdceDdmXHhlOVx4ZTNceGZkXHhkZlx4NDBceDhmXHhm
ZFx4Y2ZceGQxXHg2ZFx4YzYiCiAgICAgICAgIlx4MzhceGYxXHhlMFx4OGRceDUyXHhjZlx4
ZjhceGY3XHgyMlx4NGVceDBjXHg3Nlx4ZGZceGZmXHg3NFx4ZTJceDI3IgogICAgICAgICJc
eDNkXHhlMlx4OWZceGRlXHg2Nlx4ZmNceDdmXHhmY1x4N2RceDdkXHhiZFx4ZDdceGI2XHhj
Nlx4YWJceDExXHhhMyIKICAgICAgICAiXHg1ZFx4M2ZceDdmXHg5Mlx4YTdceDYyXHg5NVx4
ZWFceDhiXHhjYlx4YTVceGRhXHhkYVx4ZmFceGY5XHhmOVx4YzUiCiAgICAgICAgIlx4YTlc
eGI5XHhmMlx4NWNceDc5XHg2OVx4NjJceDYyXHhmY1x4ZDJceGU0XHhlNVx4YzlceDhiXHg5
M1x4NjNceGE1IgogICAgICAgICJceGQ5XHhmOVx4NGFceDM5XHhmYlx4ZDlceDM1XHhjNlx4
N2ZceDdmXHhmMVx4ZTZceGI3XHhjZlx4ZWFceGZmXHhlMSIKICAgICAgICAiXHgxZVx4ZjFc
eDQ3XHhiNlx4ZThceGZmXHg5OVx4NmRceGY2XHhmZlx4OWJceDA3XHg3N1x4MWVceGZlXHhi
NFx4NWQiCiAgICAgICAgIlx4MmRceDc0XHg4Ylx4N2ZceGY2XHg3NFx4ZjdceGNmXHhkZlx4
ZTNceDNkXHhlMlx4YTdceGQ5XHg2N1x4ZGZceGFmIgogICAgICAgICJceGIzXHg3YVx4NzNc
eGZiXHg2OFx4YTdceGJlXHhkMVx4YWVceDNmXHhlOVx4ZTRceGViXHhlZlx4OWNceDdjXHg1
NiIKICAgICAgICAiXHhmZlx4NjdceDdhXHhmNFx4N2ZceGFiXHhiZlx4ZmZceGQ5XHg2ZFx4
ZjZceGZmXHhkY1x4NWZceGZmXHhmZFx4YzEiCiAgICAgICAgIlx4MzZceDFmXHgwYVx4MDBc
eGVjXHg4Mlx4ZGFceGRhXHhmYVx4YzJceDU0XHhhNVx4NTJceDVlXHg1MVx4NTFceDUxIgog
ICAgICAgICJceDUxXHg3OVx4NWNceGM5XHg3Ylx4Y2ZceDA0XHgwMFx4MDBceGY0XHhkYlx4
ZjdceDA3XHhmZFx4NzlceDY3XHgwMiIKICAgICAgICAiXHgwMFx4MDBceDAwXHgwMFx4MDBc
eDAwXHgwMFx4MDBceDAwXHgwMFx4MDBceDAwXHgwMFx4MDBceDAwXHhmYlx4ZDciCiAgICAg
ICAgIlx4NmVceDdjXHg5ZFx4ZDhceGU2XHg5OFx4MWJceGY5XHg3NFx4MTVceDAwXHgwMFx4
MDBceDAwXHgwMFx4MDBceDAwIgogICAgICAgICJceDAwXHgwMFx4MDBceDAwXHgwMFx4MDBc
eDAwXHgwMFx4MDBceDAwXHgwMFx4MDBceDAwXHgwMFx4MDBceDAwXHgwMCIKICAgICAgICAi
XHgwMFx4MDBceDAwXHgwMFx4MDBceDAwXHgwMFx4MDBceDAwXHgwMFx4MDBceDAwXHgwMFx4
MDBceDAwXHgwMFx4MDAiCiAgICAgICAgIlx4MDBceDAwXHgwMFx4MDBceDAwXHgwMFx4MDBc
eDAwXHgwMFx4MDBceDAwXHgwMFx4MDBceDAwXHgwMFx4MDBceDAwIgogICAgICAgICJceDAw
XHgwMFx4MDBceDAwXHgwMFx4MDBceDAwXHgwMFx4MDBceDAwXHgwMFx4MDBceDAwXHgwMFx4
MDBceDAwXHgwMCIKICAgICAgICAiXHgwMFx4MDBceDAwXHgwMFx4MDBceDAwXHgwMFx4MDBc
eDAwXHgwMFx4MDBceDAwXHgwMFx4MDBceDAwXHgwMFx4MDAiCiAgICAgICAgIlx4MDBceDAw
XHhlMFx4OTlceGJlXHgwYlx4MDBceDAwXHhmZlx4ZmZceGY3XHhhMFx4ZDRceGVkIiwKICAg
ICAgICAxMjA0KTsKICAgIHJlcyA9IC0xOwogICAgcmVzID0gc3l6X21vdW50X2ltYWdlKC8q
ZnM9Ki8weDIwMDAwMDQwLCAvKmRpcj0qLzB4MjAwMDA1MDAsCiAgICAgICAgICAgICAgICAg
ICAgICAgICAgLypmbGFncz0qLzB4NDUwMCwgLypvcHRzPSovMHgyMDAwM2U4MCwgLypjaGRp
cj0qLzB4MTIsCiAgICAgICAgICAgICAgICAgICAgICAgICAgLypzaXplPSovMHg0YjQsIC8q
aW1nPSovMHgyMDAwMDU0MCk7CiAgICBpZiAocmVzICE9IC0xKQogICAgICByWzBdID0gcmVz
OwogICAgYnJlYWs7CiAgY2FzZSAxOgogICAgbWVtY3B5KCh2b2lkKikweDIwMDAwMTgwLCAi
Li9idXNcMDAwIiwgNik7CiAgICBzeXNjYWxsKF9fTlJfb3BlbiwgLypmaWxlPSovMHgyMDAw
MDE4MHVsLCAvKmZsYWdzPSovMHgxNGQyN2V1bCwKICAgICAgICAgICAgLyptb2RlPSovMHVs
KTsKICAgIGJyZWFrOwogIGNhc2UgMjoKICAgIG1lbWNweSgodm9pZCopMHgyMDAwMDE4MCwg
Ii4vYnVzXDAwMCIsIDYpOwogICAgcmVzID0gc3lzY2FsbChfX05SX29wZW4sIC8qZmlsZT0q
LzB4MjAwMDAxODB1bCwgLypmbGFncz0qLzB4MTRkMjdldWwsCiAgICAgICAgICAgICAgICAg
IC8qbW9kZT0qLzB1bCk7CiAgICBpZiAocmVzICE9IC0xKQogICAgICByWzFdID0gcmVzOwog
ICAgYnJlYWs7CiAgY2FzZSAzOgogICAgc3lzY2FsbChfX05SX2ZhbGxvY2F0ZSwgLypmZD0q
L3JbMV0sIC8qbW9kZT0qLzB1bCwgLypvZmY9Ki8weDg5NDd1bCwKICAgICAgICAgICAgLyps
ZW49Ki83dWwpOwogICAgYnJlYWs7CiAgY2FzZSA0OgogICAgbWVtY3B5KCh2b2lkKikweDIw
MDAwMzgwLCAiL2Rldi9sb29wIiwgOSk7CiAgICAqKHVpbnQ4X3QqKTB4MjAwMDAzODkgPSAw
eDMwICsgcHJvY2lkICogMTsKICAgICoodWludDhfdCopMHgyMDAwMDM4YSA9IDA7CiAgICBt
ZW1jcHkoKHZvaWQqKTB4MjAwMDAxNDAsICIuL2J1c1wwMDAiLCA2KTsKICAgIHN5c2NhbGwo
X19OUl9tb3VudCwgLypzcmM9Ki8weDIwMDAwMzgwdWwsIC8qZHN0PSovMHgyMDAwMDE0MHVs
LAogICAgICAgICAgICAvKnR5cGU9Ki8wdWwsIC8qZmxhZ3M9Ki8weDEwMDB1bCwgLypkYXRh
PSovMHVsKTsKICAgIGJyZWFrOwogIGNhc2UgNToKICAgIG1lbWNweSgodm9pZCopMHgyMDAw
MDBjMCwgIi4vYnVzXDAwMCIsIDYpOwogICAgcmVzID0gc3lzY2FsbChfX05SX29wZW4sIC8q
ZmlsZT0qLzB4MjAwMDAwYzB1bCwgLypmbGFncz0qLzB4MTQxMTNldWwsCiAgICAgICAgICAg
ICAgICAgIC8qbW9kZT0qLzB1bCk7CiAgICBpZiAocmVzICE9IC0xKQogICAgICByWzJdID0g
cmVzOwogICAgYnJlYWs7CiAgY2FzZSA2OgogICAgbWVtY3B5KAogICAgICAgICh2b2lkKikw
eDIwMDAyYTgwLAogICAgICAgICJceDVkXHgwZlx4MWJceGM3XHgxM1x4NjNceGNlXHg0Nlx4
ZDdceGQ2XHg4YVx4OWFceDA4XHgwOVx4OTRceGRlXHg0ZiIKICAgICAgICAiXHg1Nlx4Yjhc
eDc1XHg3OVx4YjZceDRjXHg1MVx4MWFceGFlXHgyMVx4YTlceDFlXHhiMlx4ZGJceDNhXHgw
NFx4MzciCiAgICAgICAgIlx4ZjhceDQ4XHhiN1x4NzFceGIzXHhjM1x4YjhceDA2XHg2MFx4
MWRceDRiXHg3YVx4NWZceDFlXHg3Y1x4YjZceDBhIgogICAgICAgICJceDM0XHhkYVx4MTJc
eGIyXHg2Zlx4YWRceGM5XHg0Nlx4Y2NceGQyXHgzYlx4NmFceGZiXHgxMlx4YzFceGNlXHhl
NiIKICAgICAgICAiXHgyMFx4OGJceGI4XHhhZVx4MmVceDJiXHgzMlx4MjhceGU3XHhlYlx4
NzhceDRjXHg2MFx4OGJceDlhXHgwN1x4YWQiCiAgICAgICAgIlx4NzRceDdiXHg5NFx4M2Fc
eDc3XHgwM1x4ZDhceGNhXHhjYlx4MjZceGFkXHgxZVx4MDJceGNhXHg4N1x4ZDZceDBjIgog
ICAgICAgICJceDVhXHg1ZFx4ZTJceGVjXHg0MFx4MzBceGZjXHgyN1x4YWVceDk4XHhjN1x4
ZjNceDIzXHg3Zlx4ZDNceDY4XHhhOCIKICAgICAgICAiXHgxNlx4NjRceGFjXHgyM1x4NmFc
eDhlXHhkNlx4ZGFceGJiXHg2Nlx4OThceDliXHhlY1x4OTJceDhiXHg2MFx4MjQiCiAgICAg
ICAgIlx4NWFceGZjXHg4MVx4NDdceDk2XHg0ZVx4OTRceDM1XHg0MFx4NTBceDI2XHgzM1x4
NWZceDU2XHhmZlx4OTlceDY2IgogICAgICAgICJceDFiXHhjMVx4ZjNceDNlXHg1M1x4NDhc
eGQ4XHgwOVx4YzhceDk4XHhkYlx4NDZceDRjXHgwN1x4MzBceDIwXHhiNSIKICAgICAgICAi
XHhkMVx4MTBceDIxXHhlOVx4YmRceGQ4XHgzN1x4NmFceGY2XHgzOVx4YzdceDY5XHhhMVx4
ZWVceDNhXHg5NFx4NjAiCiAgICAgICAgIlx4M2FceGU0XHgwM1x4ZTlceDM1XHgxMFx4ZjRc
eGNlXHhmMFx4NmJceGQ0XHhkZVx4ZDNceGI3XHhmZlx4MjJceGQ2IgogICAgICAgICJceGRm
XHgwY1x4YmRceDc0XHg3N1x4N2JceDQwXHhhNFx4YmRceDlmXHg1OVx4YTdceDFjXHg0ZFx4
MDdceDQwXHhiMSIKICAgICAgICAiXHhhY1x4ZmVceDlmXHhlNFx4YzJceDFiXHhhZVx4NWFc
eDU5XHhmZVx4MTVceDFjXHgyM1x4MjdceGZlXHhkNVx4YTMiCiAgICAgICAgIlx4MTlceGY5
XHg5M1x4YmJceDYxXHhiM1x4MDBceDNjXHg5N1x4NzRceGYwXHgzZVx4ZWJceGYwXHg1Ylx4
YTRceDI5IgogICAgICAgICJceDg1XHgwN1x4N2JceDQ1XHgxZVx4MzFceGZiXHgwMVx4OTVc
eGFhXHhjMFx4MTFceGI3XHgwYVx4Y2NceDEzXHhiNSIKICAgICAgICAiXHg0MVx4MzVceDRk
XHgxY1x4ZDlceDA5XHgzZVx4MzVceGI4XHg5MVx4NTJceGVjXHg0M1x4NWVceDA1XHhkNlx4
MjIiCiAgICAgICAgIlx4MTBceGMyXHg4Ylx4MzZceGUxXHgwYVx4YmNceGRlXHg1YVx4ODFc
eGJiXHhmMVx4OWVceGU1XHgzM1x4ZmFceGY2IgogICAgICAgICJceGViXHhhZVx4MTBceGMz
XHhhNlx4ZjhceGRkXHhkOVx4NDhceGE2XHgyN1x4ZDdceGIwXHgxN1x4ZDVceGY1XHg5ZCIK
ICAgICAgICAiXHg2Mlx4Y2RceGYzXHhlZlx4NzZceDIwXHhlZlx4OWNceDE2XHgxNFx4MjZc
eDE2XHgwM1x4YWVceDkzXHg5NFx4MTEiCiAgICAgICAgIlx4ZjhceGMzXHgzYlx4ZGRceGVl
XHg4Zlx4NzRceDkzXHhkMlx4ZmJceDhkXHgwOFx4ZGJceDA0XHg5OVx4NmZceDE4IgogICAg
ICAgICJceDYxXHhmZVx4NWNceGZmXHhiMVx4MGZceDgxXHg3YVx4MzZceGQxXHgxN1x4MDFc
eDYwXHgyZVx4NDRceDJlXHg2ZCIKICAgICAgICAiXHhjOFx4MzhceDk1XHgzZFx4ZmVceGQ0
XHhjN1x4NDJceDZjXHhlZFx4NDVceGU0XHhmMFx4MzJceDdlXHhlM1x4NjkiCiAgICAgICAg
Ilx4YTdceDdjXHhjY1x4ZWZceDUxXHhhZlx4MmRceDg1XHgyMFx4NTRceDAwXHgyNlx4NDdc
eGI0XHg2Nlx4MTNceGE4IgogICAgICAgICJceGU1XHhkMFx4ZjFceGQxXHg2M1x4MmRceGEw
XHhlM1x4NWFceDVlXHg2ZVx4OGNceGI4XHhkMlx4NWRceGU3XHg1YyIKICAgICAgICAiXHhh
Ylx4ZDRceDFkXHhjNFx4NGFceDUzXHgzM1x4MzlceGNhXHgyZFx4ZTVceGM0XHhhN1x4MzRc
eDU0XHhjOVx4MzAiCiAgICAgICAgIlx4ZDRceDFjXHg2NFx4M2ZceGQ0XHgxZVx4MmVceDkz
XHg5NFx4ZGNceDJlXHgxN1x4NDlceDUwXHgyZlx4MDRceDBjIgogICAgICAgICJceDQxXHhk
YVx4MmFceDJkXHg5N1x4ODJceGJhXHgxN1x4NDlceGJkXHgwOFx4MzNceDJmXHhjN1x4N2Nc
eDViXHhmNiIKICAgICAgICAiXHg2NFx4Y2JceDI3XHhjMFx4YjBceDRjXHgwZVx4MGVceDI5
XHgyZFx4N2FceGEwXHhjOFx4NDhceDNjXHg0Mlx4ZjgiCiAgICAgICAgIlx4NmZceGYyXHhk
YVx4ZWVceDY5XHhlYVx4MmFceGIzXHg4Zlx4ZjZceDM1XHg1ZVx4NmNceDIzXHg2N1x4Yzdc
eGI5IgogICAgICAgICJceGRlXHhkN1x4MDhceDE3XHgzOFx4OTZceGI2XHg3NFx4YTBceDNj
XHhkZVx4MGRceDExXHg1NVx4NWZceDZmXHgzNiIKICAgICAgICAiXHgzY1x4MTFceGNiXHhh
Nlx4ZDBceDI3XHg0Zlx4YzlceGM2XHhkMVx4M2FceDcxXHg1ZFx4MGJceDBkXHgzY1x4OWEi
CiAgICAgICAgIlx4NGJceDhlXHhhZFx4OTFceDM1XHgzMVx4ZTNceDM5XHg4Ylx4Y2ZceGU2
XHhlMlx4YmNceDJmXHhlOVx4NGRceDNhIgogICAgICAgICJceGFlXHhhZVx4ZTFceDYwXHhi
Zlx4ODlceGJkXHgyMFx4YjRceDY1XHg2NFx4YzdceDY5XHhiN1x4NWNceDI0XHg0ZCIKICAg
ICAgICAiXHhhMFx4MzZceDU4XHgyYlx4ZjhceGFjXHg4YVx4MWFceGNiXHg3MFx4NGRceDcw
XHg5ZVx4ZjhceDhhXHhiM1x4ZmUiCiAgICAgICAgIlx4YWRceGYzXHgyMFx4YTlceDJkXHg3
OVx4MGJceDA4XHgzZlx4ZmFceDZjXHg5OVx4NzNceDEyXHhjOVx4NWJceGE4IgogICAgICAg
ICJceDc1XHhjN1x4MGFceDEzXHhiM1x4NzlceDI5XHg3ZFx4OWRceDY2XHhkOVx4ZGNceDVm
XHg5NFx4NzlceDEzXHgyNSIKICAgICAgICAiXHg2NFx4YjJceDE5XHgwYlx4MjFceDViXHgy
ZVx4MzNceDU2XHg3MVx4ZDZceDRlXHhmYVx4YThceGU2XHhiNlx4ZTEiCiAgICAgICAgIlx4
MzBceDgxXHgzZlx4ZjVceDVhXHg0OVx4NGZceDI2XHg2MFx4ZThceGE0XHg0Zlx4MThceGNh
XHg0NFx4MzBceDUzIgogICAgICAgICJceDE2XHg3MFx4YzNceDk5XHhjMVx4OGNceDE5XHgy
OVx4OTdceGUyXHgyMlx4ZTZceDQ3XHhkMlx4NmNceDE0XHg0MSIKICAgICAgICAiXHhkNFx4
MThceGY5XHhkOFx4YmNceGRjXHg3YVx4MDFceDZlXHhmNFx4NjVceDFjXHgwMVx4MzRceDY2
XHg5N1x4NWYiCiAgICAgICAgIlx4NjBceDgzXHg5Zlx4ZTlceGVhXHhmOFx4NzJceDM2XHgw
M1x4NTJceDA0XHhmMVx4MWZceDA1XHgxNlx4NDFceDBhIgogICAgICAgICJceDYxXHhkMVx4
NDRceDEzXHhkN1x4OWJceDExXHg1MVx4MTNceDY4XHg0NFx4ZDdceDJkXHhhZFx4ZmRceDUy
XHg2ZSIKICAgICAgICAiXHg5Ylx4MThceGI0XHhlNVx4OTRceDJmXHgxZVx4YTdceGE5XHhk
NVx4MWRceDJjXHg4ZVx4MmJceDQ4XHhjNFx4ZjEiCiAgICAgICAgIlx4NDRceGY4XHgwMVx4
NjdceDEwXHhkNlx4ODBceDZkXHg2NFx4MjlceGM2XHhlMVx4YmJceDhhXHgzY1x4N2JceDk1
IgogICAgICAgICJceDQwXHg0N1x4ZmNceGEyXHg4Nlx4NDVceDMxXHg3Nlx4YmJceGMwXHgx
Nlx4ZWJceDJmXHg3ZFx4NDRceDUxXHg4NSIKICAgICAgICAiXHg5Mlx4MTZceDQxXHhmZVx4
NTBceGZmXHgwMFx4NThceDYyXHhkYlx4ZDFceDNlXHg0N1x4ZjVceDU5XHg0OFx4YTUiCiAg
ICAgICAgIlx4NDdceDMxXHhlMFx4YmJceDExXHhhNVx4MDVceDIzXHg4MFx4YzVceGYzXHgx
MFx4NTFceDY5XHhjOFx4ODJceGI0IgogICAgICAgICJceDE1XHg4Ylx4MzNceDZiXHgzMVx4
OGVceGQ5XHgwMFx4ODZceDkzXHgwZlx4OThceDhlXHhiYlx4Y2ZceGNlXHgwZiIKICAgICAg
ICAiXHg1Nlx4NWNceDA4XHgzYlx4NWVceGQ0XHhhNVx4ZTBceDQ4XHhiMlx4M2FceDA4XHhl
MVx4NjJceDRhXHgxOFx4ODUiCiAgICAgICAgIlx4MDFceGExXHg3Mlx4ZWZceDlmXHhlOFx4
ZWJceDc2XHgwYVx4MjdceDE1XHg3N1x4ZjVceGE1XHg3NFx4Y2ZceGQyIgogICAgICAgICJc
eDMwXHhhOFx4ZjVceGI1XHg1M1x4ZWRceDhiXHhjMlx4MTJceDBjXHgwZFx4MjJceGRhXHhh
OVx4NWZceGU2XHgzNCIKICAgICAgICAiXHhiMVx4YjNceGZkXHhjMlx4YTVceDA1XHg2NVx4
NmNceGRjXHhhM1x4M2RceGZjXHhlZFx4MjFceDFmXHhiMFx4ZjUiCiAgICAgICAgIlx4MzBc
eDIwXHg5MVx4NzNceDhjXHhkY1x4NGNceGNjXHgxOFx4ODlceDZiXHhjZFx4M2FceGE5XHhi
OFx4YTlceDVjIgogICAgICAgICJceGRhXHgwZFx4NWJceDg4XHg5Y1x4ODJceDIxXHgwMFx4
M2RceDM1XHhkZVx4NDFceGIyXHhlNlx4YmRceDM0XHhhNyIKICAgICAgICAiXHg3M1x4MDZc
eDBjXHhkOVx4YWRceGU4XHhhMlx4MWNceGQ3XHgyYlx4NzdceDM0XHhkZlx4MGJceDBlXHg0
OVx4MDMiCiAgICAgICAgIlx4ZDBceDQ4XHhhY1x4Y2JceGQzXHg0YVx4ZTRceDU2XHgwNVx4
MDhceDYzXHg3ZFx4N2RceGZmXHg5MFx4NjVceDQ5IgogICAgICAgICJceDZmXHhlMVx4ZmVc
eGQ1XHhiYlx4MDFceGY5XHhkMlx4NjRceDQ4XHg4MFx4NzFceGJhXHg1OFx4OWFceDU0XHgz
ZiIKICAgICAgICAiXHhkZlx4MjhceDEzXHhiMFx4MDBceDFkXHg3Zlx4MDFceDg0XHg5MVx4
NGNceGFlXHg3ZVx4YWFceDdhXHhlY1x4YTQiCiAgICAgICAgIlx4MWRceGM4XHg5ZFx4ZDVc
eDNhXHg5NVx4NTZceDY1XHg1Ylx4MTBceGU4XHhjNlx4MTFceDVmXHgxZFx4MWFceDI3Igog
ICAgICAgICJceDFmXHhlNVx4ZGNceDVjXHhjNVx4N2ZceDYzXHgzOFx4M2ZceGMxXHgxMVx4
MjNceDhjXHg5MFx4YThceDAwXHhjNiIKICAgICAgICAiXHhlOVx4NzNceDgwXHhjNlx4ZDBc
eDZiXHgwOVx4ZDhceGFiXHgwZlx4ODlceDQ3XHhiZlx4NGNceGUxXHg4NFx4MjYiCiAgICAg
ICAgIlx4YTNceGMxXHhhOVx4ZDZceGRiXHg3Zlx4MTZceDQ5XHhhOFx4OTFceGRmXHhkZFx4
ODBceDIxXHgyMFx4ODdceGUwIgogICAgICAgICJceDI3XHgwMVx4NDhceDI5XHg3OFx4MTlc
eGQ5XHgzNFx4ZWFceGZkXHgyMFx4ZWFceDc0XHgxZFx4OTBceDg4XHgzMiIKICAgICAgICAi
XHgwMFx4MjRceDlhXHg1Y1x4OThceGFjXHgyZlx4YTFceDQ5XHhjM1x4ZDVceDA3XHgwN1x4
ODFceDk1XHhiZFx4MzgiCiAgICAgICAgIlx4ZmFceDgxXHgxMFx4OTdceDMxXHg5NFx4MzNc
eDEyXHgwM1x4YjBceDdhXHhmM1x4ZTdceGI4XHg2YVx4NjJceDUwIgogICAgICAgICJceDFj
XHhiOFx4MTZceDEzXHgyY1x4N2VceGY2XHhmY1x4Y2JceDZhXHg5N1x4NGNceGIzXHgwNlx4
NzBceDFhXHg5ZiIKICAgICAgICAiXHhmOVx4ODBceDcxXHhiYlx4ODdceDhlXHg1ZVx4ZThc
eGNkXHgyMFx4NDhceGE3XHg2ZFx4NjlceDU3XHhmMVx4MWMiCiAgICAgICAgIlx4NjZceDk1
XHhlY1x4ODlceDkxXHg4Ylx4ZThceDIyXHg5Y1x4YzVceGYwXHg3OFx4YWFceDliXHgwM1x4
N2ZceDZmIgogICAgICAgICJceDdmXHhlZFx4NDFceDQ1XHhkOFx4ZjFceGEzXHhiNlx4ODNc
eDc1XHhhZVx4YjlceDZlXHg3MFx4MDFceGU0XHhhMSIKICAgICAgICAiXHgwOFx4NjRceDI4
XHgyN1x4ZjhceGVhXHhmMlx4YmZceGY4XHhjOFx4ZTlceGRkXHhlZVx4YTVceDA2XHg2N1x4
NjIiCiAgICAgICAgIlx4MjFceDdlXHgwZVx4NGNceGQzXHgxYVx4ODFceDE2XHgyZVx4YTFc
eDg2XHgxZlx4YTlceGE2XHgxNVx4MjFceGZkIgogICAgICAgICJceDdjXHhmOVx4YzZceDQ5
XHgzMlx4YWRceDI3XHg0M1x4ZWFceDdmXHgxY1x4ODlceGUyXHgzMFx4MThceDljXHg4NiIK
ICAgICAgICAiXHhhNFx4OWRceDE0XHg1NVx4NDZceDkxXHg1MFx4ZjNceDdhXHg0Ylx4ZmZc
eDYyXHhhMlx4M2NceDk3XHg5MFx4YWUiCiAgICAgICAgIlx4ODhceDJlXHg0ZVx4NzRceDk4
XHhhNFx4NmNceDk4XHhjY1x4YzlceGMyXHhhMFx4YzVceGVlXHg2ZFx4MTNceGFlIgogICAg
ICAgICJceDMwXHgzN1x4ZjFceDM1XHhiOFx4NWRceDdjXHg5ZFx4MzhceGM3XHgyNFx4MmFc
eDliXHgyYVx4NThceGY1XHhkNiIKICAgICAgICAiXHgwM1x4OWFceGU2XHg0Ylx4NTBceDJi
XHg5Ylx4NjRceDZjXHhhNlx4NTlceDcwXHg4M1x4MTBceDJmXHg5MVx4ZWIiCiAgICAgICAg
Ilx4YmVceDViXHhhYVx4ODRceDE4XHhkNFx4NWRceDI5XHhkZFx4YzFceDUwXHg5NFx4YTlc
eDkwXHg5MFx4ZjRceDVjIgogICAgICAgICJceGMxXHhiNVx4MTNceGJjXHgzZVx4MjBceDU2
XHg0NFx4ZjdceGE2XHhlNFx4NGVceDc4XHg5OVx4ZDZceDA2XHgxYiIKICAgICAgICAiXHgx
MFx4NDZceGE5XHhmMlx4ZmVceDk2XHg0Nlx4NjdceDYwXHgzM1x4YzFceDEyXHgyZVx4NmRc
eDFlXHhmOFx4OTkiCiAgICAgICAgIlx4MDlceDgwXHg5Mlx4ZmZceDg2XHg1Zlx4OGRceGVh
XHgyY1x4ODVceDNmXHg2Ylx4NDhceDRlXHg3ZFx4MzhceDQzIgogICAgICAgICJceDdkXHgy
Ylx4ZjhceGNiXHg1N1x4NDhceDdmXHg2M1x4OGZceDQ4XHgwMVx4MDBceDg1XHhmZFx4Zjlc
eDY5XHhiMiIKICAgICAgICAiXHg0Zlx4MWNceDEwXHg3OFx4ZWZceGZkXHhiY1x4M2RceGYy
XHgyNFx4YjNceDNjXHg5M1x4ZTRceGU2XHgyYlx4MmMiCiAgICAgICAgIlx4NDVceGZlXHhh
M1x4ZjJceDgxXHg3YVx4OWVceGIwXHg1MVx4OTVceGEyXHhmZFx4YmRceGY5XHg5Y1x4YzNc
eDIyIgogICAgICAgICJceGFhXHgzZlx4OTVceDczXHgxY1x4YTFceDIzXHg3Nlx4ZGRceDZi
XHg5NFx4ZmZceGNmXHgwN1x4YTNceDNlXHhkZSIKICAgICAgICAiXHg0NFx4MjRceGNkXHg4
OVx4ZjhceDEzXHhmOVx4ODVceDE4XHhjZVx4OGRceDMzXHhiYVx4MTBceGUzXHhmMVx4ODQi
CiAgICAgICAgIlx4OGFceGY0XHhkYVx4MzNceDRlXHgwZVx4NjFceGU3XHg2NVx4NmRceDk3
XHhiYlx4MGRceDk2XHg5Ylx4YmJceGJhIgogICAgICAgICJceDRmXHhhY1x4NDFceDIxXHg1
OFx4ZTFceDNjXHg1Y1x4YmZceDhlXHg4OFx4YmJceGQxXHg1Y1x4YTRceGQ4XHhjNyIKICAg
ICAgICAiXHgwM1x4ZTJceDY2XHhhMlx4ZWNceDcwXHhhYVx4MTRceDY1XHgwYVx4MmZceDEy
XHhiYVx4MDJceGMxXHg4Y1x4MjgiCiAgICAgICAgIlx4NjNceGYxXHg2YVx4MmRceGRlXHhi
Mlx4NWVceDhhXHg5Y1x4MzNceGY1XHg1Ylx4M2NceGIwXHg5OFx4MWZceDJkIgogICAgICAg
ICJceDMxXHhhYVx4MmZceDhjXHhhYVx4NzdceGU2XHgxZlx4N2VceDhhXHhmZVx4NmFceDEz
XHhjYlx4ZmJceDQ2XHhjMSIKICAgICAgICAiXHg5Nlx4ZDNceDUzXHhjOVx4NjFceDJmXHg5
Mlx4NWJceGE5XHg0Nlx4MTFceDI4XHhmYVx4ZTNceGQ2XHgyNFx4YzkiCiAgICAgICAgIlx4
MjFceGU4XHhmMVx4ZWNceDU0XHhiM1x4YTlceDE5XHg2NFx4ZmRceDBiXHhhMlx4ZTBceDY1
XHgwZVx4MDRceDRkIgogICAgICAgICJceGVjXHhiOFx4MmRceDBmXHhjZFx4OTlceDQ2XHgx
OFx4ODFceDc4XHgxNVx4OGZceDczXHhkMVx4YTRceDQwXHhmNSIKICAgICAgICAiXHg3OVx4
NDFceGI3XHg5N1x4NGVceDhiXHhjZVx4ZDRceGVmXHg3Mlx4OTJceDg4XHg2Y1x4NDFceDM2
XHhhY1x4NDEiCiAgICAgICAgIlx4YjBceDY2XHhhYlx4MDRceDAyXHhlN1x4NWRceDU4XHhj
Nlx4N2RceDRkXHhlOFx4MzJceDEzXHg0YVx4N2FceGJlIgogICAgICAgICJceDE5XHg2Y1x4
YjlceGQxXHhjMFx4OThceDgyXHgxYVx4N2JceGQ0XHg4Nlx4MDVceDU0XHhiY1x4Y2ZceDQ0
XHgwOCIKICAgICAgICAiXHhhZlx4ODdceDA0XHhhM1x4ZGFceGUxXHg4Zlx4M2VceGFmXHg3
MFx4Y2RceDI4XHhhNFx4NDdceGE2XHhjZlx4NDQiCiAgICAgICAgIlx4MzJceDY2XHg2Nlx4
YjhceDA5XHhjZlx4ZGJceDNkXHg1Zlx4MTNceGFiXHg5M1x4NjRceDk0XHgyY1x4MTBceGE0
IgogICAgICAgICJceDQ2XHgxZVx4MzNceDhlXHhlZlx4YTJceDY1XHgxM1x4Y2RceGUyXHgx
ZVx4ZDRceGZkXHhlMlx4OTNceGY5XHg1YiIKICAgICAgICAiXHhjZlx4ZDlceGUxXHhkZVx4
MzZceGYxXHhhOVx4MmFceGY4XHg3M1x4MjlceGNjXHhmYVx4NTFceDE3XHgzYlx4NmYiCiAg
ICAgICAgIlx4NzJceDc3XHgzNlx4ZDFceDM5XHg3M1x4MDZceGUwXHgzZFx4ODNceDMxXHhk
ZFx4NTBceDcyXHgyNlx4ZjdceDFlIgogICAgICAgICJceDAyXHg4MFx4ZjFceGE2XHg5ZFx4
ZTVceDVhXHgxNFx4ZWVceGQ1XHg4N1x4MzdceGI0XHg4ZVx4MDhceDU3XHg0MyIKICAgICAg
ICAiXHg0OVx4YWVceDk1XHgwZVx4NDFceGExXHg4OVx4YWFceGM2XHgxN1x4N2ZceGE0XHgy
MVx4NjZceDQ4XHgyZFx4NmEiCiAgICAgICAgIlx4NTJceGViXHgwNVx4MDNceDY3XHhkZFx4
ZTlceDU1XHhhZlx4NjhceDg5XHg5Zlx4OTFceGE3XHg0NFx4MDdceDY1IgogICAgICAgICJc
eDE5XHgwN1x4YTdceGVkXHhhM1x4OGNceDZiXHhjZFx4ZmJceDllXHgxOFx4OTdceDY0XHhh
MVx4ZDlceGJmXHgxOCIKICAgICAgICAiXHgxN1x4MjRceDY5XHgyN1x4NTRceDkzXHg1NFx4
ZDVceGM0XHg4NFx4ZjFceDYwXHg4Y1x4OTJceGRhXHg0OFx4MWEiCiAgICAgICAgIlx4ZGNc
eDE4XHhlOVx4ODFceDZhXHhlN1x4NGZceDNiXHgwMlx4YmVceDY4XHgwZVx4YTRceGY0XHhh
OVx4MWZceDU2IgogICAgICAgICJceDc3XHg0OFx4MmNceGRiXHg2Ylx4NzBceDNkXHg4Ylx4
NGFceDdkXHg5OVx4OTJceDQ3XHg3ZFx4NzlceDYzXHg0YiIKICAgICAgICAiXHhkZVx4M2Nc
eGFiXHhhOFx4NWFceGNjXHhmY1x4ZTlceDU0XHgxOVx4MDlceGM0XHgxOFx4YTJceDIwXHgx
OVx4ZDkiCiAgICAgICAgIlx4OWFceGU2XHhkOVx4ODRceDYxXHgxMVx4MmJceDkzXHhjM1x4
NWNceDg2XHg0MFx4YjlceGEzXHgzM1x4NmNceDY0IgogICAgICAgICJceDlmXHgyZFx4MDRc
eGUzXHhjY1x4MjdceDExXHhmOFx4ODJceDFmXHg3M1x4MjRceGVjXHhjY1x4ZmFceDk2XHhj
YiIKICAgICAgICAiXHhlYVx4YjRceGQwXHgyNVx4NzdceDE5XHgwOVx4MDVceDJiXHhhYVx4
NjZceDcxXHhjM1x4YWZceDY2XHg1NFx4NWQiCiAgICAgICAgIlx4ZGRceDBjXHhiMFx4ZTJc
eDY1XHgyYlx4NzZceDM5XHhjZlx4NDBceDY1XHgyOVx4ZWFceDU5XHg1YVx4NjNceDBlIgog
ICAgICAgICJceDY0XHg4OFx4YWJceDVlXHg1Zlx4ZWVceDFlXHg1NFx4ZDZceDM2XHgxOVx4
YzdceGEzXHhhYVx4M2VceDFlXHgwZSIKICAgICAgICAiXHgzYlx4OGNceDg2XHg5M1x4YzJc
eGIxXHhiNVx4OTNceDgwXHhlY1x4ZGJceGI4XHhkZVx4N2VceDc0XHg5M1x4ODAiCiAgICAg
ICAgIlx4YmFceDVjXHhjNFx4MGRceDY0XHg3NVx4NWRceGYxXHg3OVx4NzZceGFiXHg2ZFx4
NDlceDI2XHg0OVx4ZTJceDkzIgogICAgICAgICJceGI4XHhmMlx4ZGJceGM1XHgxYVx4M2Jc
eDczXHg4Y1x4ZGRceDM3XHhlZFx4ZTRceDJkXHg2ZFx4ODJceDllXHhlNyIKICAgICAgICAi
XHgxYlx4YmVceGJlXHhlNFx4Y2JceDUxXHgyMVx4ZWRceGY5XHhkNVx4MDFceGIzXHg3Y1x4
YjNceDMxXHhmYVx4ZDgiCiAgICAgICAgIlx4YmVceGU3XHg1ZVx4ZTZceGE0XHhlM1x4OWZc
eDQ2XHhhNFx4NjJceGRhXHhhMlx4NGVceDYwXHhmYlx4YmNceDQ5IgogICAgICAgICJceDBi
XHg3Nlx4NjFceGUzXHg2Zlx4ZmNceGRkXHhiOFx4NWNceDUzXHhhNlx4NjhceGUzXHhiNVx4
NzVceGNkXHhmZiIKICAgICAgICAiXHg3OFx4MTJceDhjXHhjMFx4YmNceDMwXHhjMFx4MjZc
eGRkXHhkZVx4OTBceDljXHgyMlx4NThceDdiXHgwY1x4MGQiCiAgICAgICAgIlx4MjZceDc5
XHgwY1x4Y2VceDk1XHhlY1x4NGZceDYyXHg2Ylx4NjBceDQwXHhhY1x4YjBceDM5XHhkNFx4
ZmJceGExIgogICAgICAgICJceGZiXHgxOVx4NzRceGE5XHgxMFx4ZjJceGEzXHgyMVx4OTdc
eGE2XHg5N1x4MmZceDExXHg4N1x4NWFceDRjXHgwYyIKICAgICAgICAiXHhjN1x4MjJceDVj
XHg5MVx4ZTVceDliXHg4Mlx4ZjdceDhlXHgwY1x4MDlceGMxXHhmNVx4MzhceGU3XHhhN1x4
NDIiCiAgICAgICAgIlx4ZmRceDNkXHhjN1x4NDhceGRjXHg0Zlx4MjdceDM4XHg5YVx4ZWNc
eDM4XHgzNlx4ZjZceGMyXHhkMVx4YWRceGMzIgogICAgICAgICJceDUwXHg4MVx4MDVceDU4
XHgwZVx4NjBceDdiXHgzZlx4NWZceGJlXHhhM1x4NDdceGQ3XHg4Y1x4ZjdceGZjXHhjZCIK
ICAgICAgICAiXHg5NFx4MzFceDg4XHhhZFx4MmFceGRlXHg0Zlx4MGJceGRjXHg1OFx4NDNc
eDNkXHg0Nlx4ZDVceGJkXHhlN1x4ZWEiCiAgICAgICAgIlx4N2ZceDkzXHhjZVx4MzVceDIz
XHg4M1x4YmNceGU5XHg2Ylx4M2FceGFmXHhiM1x4NWVceDdjXHhkZFx4NzVceDIxIgogICAg
ICAgICJceGY2XHgyNFx4MjRceDMyXHg1YVx4N2JceGJhXHhlOVx4MGFceDc0XHg4MVx4NWJc
eGEzXHgyYlx4MTFceGYyXHhiMiIKICAgICAgICAiXHg5YVx4MzNceDVjXHg5YVx4ZDBceGYx
XHg3Nlx4OGFceDk2XHgwY1x4ZTJceDViXHg3OFx4MGFceDU1XHg0M1x4MjEiCiAgICAgICAg
Ilx4ZjVceDk4XHhlNFx4NGRceDExXHgxMFx4OTlceGU3XHhhN1x4Y2JceDY3XHg5YVx4ZDFc
eDRhXHgzN1x4NDZceDUzIgogICAgICAgICJceDE4XHgzY1x4NzdceDNmXHhlMlx4ZWFceDdi
XHhiMVx4YWVceDQ4XHhiYVx4YjRceDFjXHhkMFx4MmFceGVkXHhiZCIKICAgICAgICAiXHg3
NFx4NDhceDMwXHg4YVx4MzZceGU3XHg2NFx4MTdceGQzXHg4NFx4MDdceDMyXHgxNlx4OTNc
eGQzXHgzYlx4YTgiCiAgICAgICAgIlx4YjZceGY3XHhmY1x4MWVceGY3XHg3N1x4ZTRceDg2
XHg4Mlx4MjVceGU1XHhhNlx4ZjlceDliXHhlNlx4YzBceGVhIgogICAgICAgICJceDdiXHgy
M1x4ZmFceDJjXHhjOVx4YzNceGI4XHg5ZFx4MjlceDM4XHg1Y1x4MzVceDcxXHgyOFx4NDFc
eGRhXHhmMiIKICAgICAgICAiXHgzYlx4YjRceGExXHg1YVx4NTZceDk4XHhjOFx4ZDdceDBh
XHg3M1x4OGZceDE2XHhkYlx4NWJceGVjXHg0N1x4MDciCiAgICAgICAgIlx4NzJceDdmXHhm
M1x4Y2FceDQ0XHhlZFx4MGVceDExXHg5OFx4MDNceGQ2XHhhZVx4OWVceGEzXHg0OVx4MjFc
eGFhIgogICAgICAgICJceGYzXHg4MFx4OGVceGZhXHhhNFx4MWNceDIzXHgwNFx4ZjBceDc0
XHhiN1x4ODNceGY1XHg1Zlx4Y2VceGUzXHgzZCIKICAgICAgICAiXHg0Mlx4ODRceGMzXHgz
YVx4YzBceDhmXHg5Nlx4YzRceDg3XHhlMFx4ZDNceDAxXHg4Mlx4ZmNceDhjXHg1ZVx4YjMi
CiAgICAgICAgIlx4ZTlceGIwXHg3N1x4MGNceGY5XHg2Zlx4M2FceDE0XHg5Zlx4ZDJceDEz
XHg2Zlx4ZGJceGZjXHhlMFx4ZDVceDRhIgogICAgICAgICJceGNmXHg2OVx4MGFceGMyXHhl
N1x4ZjRceGU2XHg4Y1x4ZDlceDczXHhhYlx4NTFceDRlXHgxYVx4MmNceGY5XHgwMSIKICAg
ICAgICAiXHg1N1x4YTVceDU2XHhjYVx4ZGNceDAwXHhjMFx4MDhceGQyXHgzOVx4MDdceGJk
XHgyM1x4ZWZceDc2XHg3OFx4NjciCiAgICAgICAgIlx4YjVceGU0XHg2Y1x4OGJceDZjXHg5
M1x4ZWNceGY0XHgwMFx4ODZceDc3XHg5YVx4YjVceDhlXHgwMVx4OTlceDUzIgogICAgICAg
ICJceDViXHhiY1x4MWZceDE4XHhiMlx4YmNceDE2XHgwM1x4NjZceGU1XHg5ZVx4ZmFceDky
XHg5Ylx4MjdceDg2XHhkMCIKICAgICAgICAiXHhlZVx4ZjNceDBlXHg3OVx4NGJceDY0XHg0
MFx4ZDNceDhjXHgyYlx4OGRceDVhXHhmNVx4OGFceDA1XHg5NVx4NTMiCiAgICAgICAgIlx4
YzNceGM1XHhjNlx4MjBceGY2XHg1Nlx4MzJceDMwXHgyZVx4YzlceDc5XHg0Nlx4ZmFceGE1
XHgwZlx4MzlceDBmIgogICAgICAgICJceDQ5XHgwN1x4OTFceDY3XHg2Y1x4ODVceDM0XHg4
Nlx4YjNceGEyXHg2MVx4MzJceDg0XHg4Nlx4MWJceDVkXHhiZSIKICAgICAgICAiXHg2ZFx4
MjFceDQyXHhhMlx4ZWFceDQ4XHg1Y1x4M2ZceDYxXHgxNFx4OWNceDE4XHg5Mlx4MjlceDgw
XHgwY1x4NTIiCiAgICAgICAgIlx4ZThceGViXHg4MVx4MDBceGNiXHg5Ylx4MTFceDRlXHg3
MVx4MmVceGU4XHgxNVx4OTdceDllXHgzZVx4MzFceDlhIgogICAgICAgICJceDk2XHhkNFx4
NGNceGQyXHg1NFx4MTFceDNlXHg4OFx4MzBceGMwXHg0NFx4ZjRceGUxXHg4Nlx4MjFceDdh
XHg4MyIKICAgICAgICAiXHg5Ylx4MzBceGI3XHg3Ylx4MThceGE1XHg3Ylx4OTZceDFiXHg5
ZFx4Y2JceGRjXHhmMFx4Y2VceGVkXHg0Zlx4M2UiCiAgICAgICAgIlx4NjhceDk4XHhhNlx4
MWFceGQwXHgwMlx4MDVceDExXHhmZFx4NTNceDU2XHgyMlx4Y2VceGNkXHgzNlx4YjFceDYx
IgogICAgICAgICJceDQzXHhlNlx4MGNceGQwXHgwMVx4MzFceGQxXHgzY1x4N2VceDFiXHhh
MVx4YmRceGNhXHg1ZFx4NjFceDJkXHhlZCIKICAgICAgICAiXHhmYlx4MTRceDZlXHg4N1x4
Y2ZceGE1XHhkMFx4YTBceGI3XHgyMlx4NmZceDkwXHg0MVx4ZGNceGJkXHhiNVx4ODciCiAg
ICAgICAgIlx4MjBceGUyXHhjYlx4NjdceDlkXHg5YVx4MzJceGU1XHgyNFx4ODNceDljXHgx
ZFx4MGNceGY5XHg1ZVx4NmZceGNkIgogICAgICAgICJceGIwXHhjNlx4NjlceGQ0XHg2MFx4
YTBceGQ4XHgxZVx4YzlceDE0XHhhMFx4MTNceGU3XHhlZVx4ODlceGExXHg5MSIKICAgICAg
ICAiXHg3Ylx4OTBceDhmXHhlN1x4YTFceDc4XHg5MVx4MDhceGU1XHg1NVx4ODBceGI5XHg3
N1x4YzdceDI3XHhmYVx4OGUiCiAgICAgICAgIlx4ZWRceGE2XHgwN1x4YzJceDJhXHgxZFx4
YWNceDcxXHg0MVx4YTZceDM1XHhhOFx4YjlceDNjXHg2NFx4MWZceDg5IgogICAgICAgICJc
eDVhXHg1OFx4MDVceDA0XHgzMVx4MDNceGMzXHhmZVx4N2JceDViXHhkMlx4ODRceDYyXHhk
N1x4ZWJceDkyXHg3ZiIKICAgICAgICAiXHhlZVx4ZGRceGI0XHhhZVx4MjVceGJiXHg3ZVx4
MGJceDNjXHg0ZVx4OGNceGUwXHhmOFx4ZDBceDYyXHg3MFx4NjMiCiAgICAgICAgIlx4MWZc
eDE2XHgyYlx4YThceDY1XHg4NFx4OWFceDM2XHg5NVx4NWVceGQ4XHg1MVx4YWJceDc2XHg4
Zlx4NWRceGE0IgogICAgICAgICJceGIzXHgzZlx4MDVceDI1XHhkZVx4OWFceDllXHgwOVx4
YmRceDI1XHhjNlx4NDZceGRiXHgyYlx4MmVceGJkXHg2NCIKICAgICAgICAiXHhlZVx4OThc
eDEyXHg2ZFx4YmZceGIwXHhjMlx4N2JceDViXHg3MFx4OGFceDRiXHhiMVx4MThceDU0XHg1
MFx4ODAiCiAgICAgICAgIlx4NDJceDJhXHgwYVx4YWVceGRjXHg5OVx4ZmNceGJhXHhiYlx4
M2VceDhhXHhiZVx4MGZceGI3XHg0ZFx4YjJceDY3IgogICAgICAgICJceGNkXHhhM1x4ZDRc
eDhjXHg3NVx4NGNceGY2XHhiNVx4NzlceDgyXHgyMFx4OWFceGFmXHhjYVx4ZmJceGQ5XHgw
MiIKICAgICAgICAiXHg4Y1x4MGNceDVmXHhlMlx4ZGZceDM2XHg2Y1x4YjdceDkzXHg4Nlx4
MDNceDY2XHhlYVx4NzlceDZiXHg2ZVx4OGMiCiAgICAgICAgIlx4OTNceDM1XHgxN1x4NWZc
eDQ2XHg3Zlx4M2ZceDRjXHhlMVx4NTNceGUzXHgxZlx4ZjRceDJkXHg0Nlx4MmRceDMxIgog
ICAgICAgICJceDI5XHhlNFx4NDlceDU0XHg2M1x4OGJceGI3XHgyMlx4ZTJceDI4XHg0MFx4
MTNceDk3XHgxN1x4ZmVceGMxXHhlOCIKICAgICAgICAiXHg0OVx4YTdceGZkXHhlMFx4NTVc
eDA4XHg2M1x4ZTdceGNmXHg1Mlx4NTZceDQ5XHg3M1x4YzJceDU5XHg3Zlx4MjUiCiAgICAg
ICAgIlx4NjRceGUwXHg5Ylx4ZjBceGFkXHhiNVx4NGJceGNhXHgzY1x4OWRceGUzXHg1OVx4
MGJceDY1XHhkN1x4ZWFceDdmIgogICAgICAgICJceDRiXHhkOVx4N2ZceGY0XHg5Zlx4Zjlc
eGQwXHhhM1x4MGVceDY2XHg1ZFx4OGZceDU4XHhjMFx4OWFceGI5XHhjNiIKICAgICAgICAi
XHg2NVx4NzhceDllXHg3M1x4NDhceGYwXHhiNlx4YjNceDc5XHhiNVx4NWNceGE4XHg4Nlx4
NjdceGUxXHg1M1x4ZTUiCiAgICAgICAgIlx4N2ZceDhhXHhhMVx4MjdceGViXHg3OFx4Mjdc
eDJmXHhhY1x4MmZceDc3XHgyYVx4YWNceGY4XHg1NVx4MjJceDlmIgogICAgICAgICJceGFi
XHgxMVx4YWFceGY4XHgzNlx4ZTJceGEwXHhhMlx4ZDBceDEwXHg4OVx4NzJceGViXHgzZVx4
MDBceDlmXHhlMCIKICAgICAgICAiXHgxOFx4ZjBceDFjXHg4Y1x4ZTVceDA1XHgwNVx4NDVc
eGZiXHgwOFx4YjlceDg2XHg2ZFx4MTJceDRlXHhmOFx4OGMiCiAgICAgICAgIlx4ZWVceDI5
XHhmMVx4NTNceDgxXHgzOVx4MmFceDU5XHgwOFx4MWNceDIzXHhkNlx4YjBceDYxXHhkYVx4
MjVceDU4IgogICAgICAgICJceDU3XHgwNlx4YTJceDA1XHgxYlx4MTFceGQ1XHhlOVx4NTFc
eGMxXHg1N1x4ZGFceGE4XHg1MFx4Y2NceDVhXHgzYSIKICAgICAgICAiXHhhNFx4NzRceDQ3
XHhkN1x4NWZceGU1XHg1N1x4YzJceGY5XHgzM1x4OWVceDJkXHhmYlx4YmZceDk4XHhiYVx4
MmEiCiAgICAgICAgIlx4ZjdceGRiXHg4ZFx4MTJceGYzXHgzN1x4NGFceDc3XHgwOVx4NWRc
eDBhXHhkZFx4YTZceDZlXHgzN1x4NmRceDAyIgogICAgICAgICJceDNjXHg1OFx4MmRceDcx
XHg5M1x4N2FceDkzXHg4ZVx4NTVceGUzXHhjNVx4NWFceGFjXHgwMlx4YzVceGM2XHhmZSIK
ICAgICAgICAiXHhjY1x4MGRceDc2XHg2MVx4YjhceDAyXHhhNlx4ZWNceDNmXHg3Zlx4MThc
eDc0XHg1ZFx4NzVceDkxXHgxYlx4Y2YiCiAgICAgICAgIlx4NThceGJlXHgzY1x4OGVceGFi
XHg1OFx4N2RceDY3XHg1ZFx4YTNceGMwXHgxM1x4YWZceGYxXHgwYVx4ZDJceGRiIgogICAg
ICAgICJceDExXHhjOFx4YmNceGNiXHgwMVx4YThceGIxXHhjM1x4ZDJceGZkXHhiMFx4YTFc
eDhjXHgxNlx4NzBceGU4XHgxNyIKICAgICAgICAiXHg3YVx4ODVceDIzXHhhYlx4NjhceDAw
XHhhM1x4NGFceDRiXHg2Mlx4MzVceDkyXHhmY1x4ODJceDk4XHhmZVx4OGMiCiAgICAgICAg
Ilx4ODNceDVhXHhmNVx4NmVceDBlXHgzZFx4MWVceGZhXHg4Nlx4MGVceDg0XHhmMVx4ZGZc
eDQ4XHgwZVx4MmJceGQzIgogICAgICAgICJceDM2XHhhM1x4NjhceGNiXHhiMFx4ZjFceGE5
XHgyZFx4NTFceDVkXHgxOFx4NjZceGY1XHgzY1x4MWNceDUyXHgwMiIKICAgICAgICAiXHgy
NFx4YzZceDcwXHg5YVx4OTJceDZhXHhkNVx4YzBceDcyXHhmY1x4YjVceDljXHhmOFx4ZjBc
eDY3XHhiNVx4ODkiCiAgICAgICAgIlx4YzhceDZiXHg4YVx4OWJceGM3XHg5ZVx4MTJceDg1
XHg4MVx4YjBceDY3XHhiZVx4ZWJceDZjXHg3M1x4YjJceDU1IgogICAgICAgICJceDE2XHg1
MVx4YzZceDIwXHg0M1x4OGNceDM1XHhmMVx4OGNceDBkXHg1ZFx4NjRceDI1XHhjMVx4NjZc
eGRkXHhmMSIKICAgICAgICAiXHg0NVx4N2NceGIyXHg2MVx4MWFceGE1XHg3Mlx4ZTJceDdl
XHg4ZVx4YzZceDExXHg5M1x4Y2RceDBhXHg2OFx4M2MiCiAgICAgICAgIlx4N2FceDRhXHhk
Nlx4NDFceDBmXHg4Mlx4MjJceDExXHgzZVx4NWFceDc4XHg4Nlx4MzZceDM0XHg3Y1x4MjNc
eDU5IgogICAgICAgICJceDJjXHhjN1x4NDdceGJiXHg2N1x4MjFceDRjXHgxMlx4NDdceDkx
XHhiZVx4YjVceDUyXHg0MFx4ZjBceGMyXHhjNyIKICAgICAgICAiXHhkMFx4ZThceDBmXHg4
N1x4NWJceDliXHhjYlx4NGRceGIwXHg3OFx4YmNceGU2XHhjOFx4NGVceDU4XHg4Zlx4ODUi
CiAgICAgICAgIlx4NTdceDUxXHhlNVx4ODlceDdkXHg5NFx4OGVceDExXHhmZVx4NWRceDUz
XHgyN1x4ODdceDU0XHhjNVx4OWNceGVjIgogICAgICAgICJceDJlXHhiYVx4ZDlceDA5XHg2
ZVx4YzZceGJiXHhhY1x4NGVceGY1XHhmMFx4ODlceGNjXHg4NFx4MjJceGU2XHg5MiIKICAg
ICAgICAiXHhiZVx4YmJceDY0XHg2OVx4YzBceDFmXHg1Ylx4OGNceDVmXHhiN1x4NTNceDI4
XHg3OVx4YzNceDJlXHg2ZFx4MmMiCiAgICAgICAgIlx4ODJceDY2XHg0NFx4MGNceGJmXHg5
MVx4NTRceDUyXHg2M1x4Y2ZceGRkXHhiY1x4MjhceDljXHg3YVx4YjZceGZhIgogICAgICAg
ICJceDY5XHhmNlx4YzhceGZhXHhiNFx4NzJceDllXHg1OFx4OTJceDhjXHg2MFx4MjRceDAx
XHg0OFx4MDRceDc4XHg5MiIKICAgICAgICAiXHg4Ylx4ZDRceDQzXHgxOFx4M2NceDhjXHhm
NFx4NjNceGRiXHgyN1x4NGRceDMwXHhlM1x4YjdceDIxXHgxZVx4YzUiCiAgICAgICAgIlx4
YjBceDc2XHgzZlx4ZGZceGU5XHhmMlx4YmVceGIzXHgwMVx4OTlceDE1XHg5ZFx4NjBceDlm
XHg1N1x4MjRceDczIgogICAgICAgICJceGQ4XHg3YVx4MGZceDZmXHhmMVx4MmZceGQ3XHhj
ZFx4YzRceDgxXHhlN1x4ODZceDdlXHhlY1x4YThceGYwXHgwYiIKICAgICAgICAiXHgwYVx4
YTNceDVhXHhmY1x4NTJceGIzXHg1OFx4OTNceGE2XHhiY1x4Y2NceGE0XHhmOVx4MmJceDU0
XHg3Ylx4OTkiCiAgICAgICAgIlx4ODFceDYzXHgxM1x4NTFceGVkXHg3NVx4ODlceGNhXHhl
ZVx4YjhceDI5XHhlN1x4YzZceGRkXHgzYVx4YmJceDE5IgogICAgICAgICJceDE1XHg3Zlx4
OGRceDZjXHhjNFx4MDdceGIyXHhhYVx4OWNceDdmXHg3MVx4NGZceDA3XHg5M1x4NjlceDUz
XHgwNyIKICAgICAgICAiXHg1ZFx4N2FceDM5XHg5Nlx4NzJceDlhXHhkNlx4YTlceGI0XHhl
Nlx4OGRceDgyXHhjOFx4MDZceDVjXHg1Nlx4OGEiCiAgICAgICAgIlx4YTdceDkxXHg0N1x4
ZWVceGZmXHhmZVx4ZmZceDdlXHg0N1x4NTZceDc4XHg0NVx4NWNceDZjXHg0Y1x4ZmVceDA3
IgogICAgICAgICJceDM2XHg0YVx4ZWVceGU1XHhhOFx4NmRceDEyXHg3YVx4ZDJceGQ5XHgx
M1x4M2VceGViXHhhZVx4ZDJceGVmXHg2YiIKICAgICAgICAiXHg0OVx4ZTNceDdiXHhjMVx4
NzFceGM0XHhjYVx4ZDJceDc5XHgyOVx4ZTVceGEzXHgzNVx4ZGNceGUyXHgxOFx4YWQiCiAg
ICAgICAgIlx4M2ZceGY3XHgxOFx4YmJceGI2XHhkMlx4YzVceDc4XHg0NVx4MDZceDlhXHg1
Ylx4OTJceGRhXHhmOFx4NTBceGM1IgogICAgICAgICJceDY3XHhmOFx4ZjNceGI1XHg5YVx4
MDZceDA3XHg3OVx4NGZceGZmXHhmZFx4MzNceDQwXHg3OFx4NzBceDUxXHg4MiIKICAgICAg
ICAiXHhmMVx4MzNceDAwXHhkNVx4MTFceDI3XHg0Y1x4MjlceGJmXHg5ZFx4ZWRceDdjXHg3
OFx4ZjZceDc2XHg3NVx4NjciCiAgICAgICAgIlx4Y2NceGU5XHgxNVx4NmNceDg2XHhlNFx4
ZjZceDBiXHhlZFx4M2FceGRkXHhhY1x4ODBceDgwXHg2NVx4MzNceDg4IgogICAgICAgICJc
eDNlXHg1N1x4NTBceDk1XHhjZVx4MTdceDZiXHhmY1x4YTNceDMwXHgyOVx4MTdceDYxXHg5
Y1x4ZTRceDUyXHgxNiIKICAgICAgICAiXHhlMFx4YzFceGI5XHhjMlx4MmRceDUzXHhhMFx4
OWFceDE4XHgyYlx4NDZceDhiXHgxY1x4ZGNceGQ1XHgxN1x4NmMiCiAgICAgICAgIlx4Y2Fc
eGQ2XHg0Ylx4NGNceDc1XHg0Nlx4NmFceDliXHhkMlx4MTNceDk0XHg1MFx4NmRceDNjXHhl
NFx4OTJceGIxIgogICAgICAgICJceDQwXHg0NFx4MDVceDk1XHhjMlx4YWZceDRkXHg2Ylx4
YjVceGM2XHg1Zlx4MTRceDY5XHg2ZFx4MTZceGI4XHhkYyIKICAgICAgICAiXHg3Nlx4N2Zc
eDY2XHg0Zlx4ZWVceDA5XHhhM1x4MzVceDQzXHg1NVx4OWRceGI3XHhkZlx4M2RceDI5XHgz
Nlx4OWMiCiAgICAgICAgIlx4NjNceDg4XHgwYVx4YjhceDlmXHgxMlx4YzZceDA3XHg4NVx4
YjFceDhmXHhhN1x4YjZceGMxXHhlN1x4MWZceDdkIgogICAgICAgICJceDQxXHgzM1x4Mjdc
eGU1XHg0ZVx4OWVceDE3XHgxNlx4ZTBceDVlXHhhMVx4NDFceDYxXHg0Ylx4MDBceGU1XHgy
MyIKICAgICAgICAiXHgxOVx4YjlceGNhXHhkOVx4Y2ZceGY5XHg5YVx4YWVceDJkXHgzNFx4
N2VceGZkXHhkM1x4NjJceDg4XHhkOFx4NjIiCiAgICAgICAgIlx4NDVceDdiXHg3NFx4YmZc
eGE0XHhmNlx4OGJceGI2XHhmMlx4YzJceDEyXHg2MVx4YjlceDZjXHg2ZVx4MjhceDA3Igog
ICAgICAgICJceDdjXHg1MFx4YmVceDk4XHg0Y1x4MTdceDY0XHhmNVx4YmJceDY0XHhhOVx4
N2FceDY5XHgyMlx4ZGNceGU2XHg5MCIKICAgICAgICAiXHg3Mlx4MGNceDBiXHg2MFx4ZTFc
eDVlXHgwYVx4MGJceDZiXHgzOVx4OGZceDlkXHgwNlx4NTdceDM5XHg2ZVx4YjYiCiAgICAg
ICAgIlx4MGFceDVjXHg2OFx4ZmNceDcxXHhkOVx4ODJceGI1XHgzZVx4ZWNceGRiXHgzYVx4
YmFceDg2XHhhMlx4MDNceDVjIgogICAgICAgICJceDNhXHg3NVx4ZTlceGE1XHhjOVx4MTRc
eDM3XHhlYlx4MzlceGFjXHhlM1x4OGNceGEwXHgwZVx4OGRceDVhXHg2YiIKICAgICAgICAi
XHg2Ylx4ZGFceGRiXHg3Mlx4NDRceDYwXHgxN1x4OWFceDQ2XHg1OVx4NjdceDNhXHhhZVx4
OGJceDRmXHhiMlx4NjEiCiAgICAgICAgIlx4MDRceDE0XHg0NVx4M2ZceDJmXHg4OVx4YWRc
eDgyXHg1ZFx4M2JceGMwXHg0N1x4YTlceDNmXHgzZFx4MzJceGRkIgogICAgICAgICJceDg5
XHgxOFx4ZmJceDVjXHhmZVx4NDRceDk5XHg0OFx4NGNceGRlXHhmY1x4YTVceDdjXHg2OVx4
OGZceGVkXHg4ZSIKICAgICAgICAiXHgyNFx4MDlceGE1XHgwMVx4MGVceDhiXHhmZVx4MzRc
eDRiXHhmYlx4YmZceGFlXHg2Zlx4YjJceDgyXHg2ZFx4Y2YiCiAgICAgICAgIlx4YWJceDZl
XHhkMlx4YjhceDIwXHg4MVx4N2JceDI4XHhlZVx4ZGRceGM3XHgzMlx4YjlceGQ3XHhiNlx4
ZGZceDg1IgogICAgICAgICJceDMyXHg4Nlx4ODNceDlhXHg0Mlx4NjVceGNmXHgzNlx4MWZc
eGY1XHhmOVx4MjdceDBmXHgyOVx4YTBceDRlXHg1MyIKICAgICAgICAiXHhkMVx4OWJceGQw
XHg2NFx4NGRceDE2XHhkOFx4YzdceDJlXHhlM1x4MzRceDhjXHg5Nlx4ZDBceGIxXHgyMlx4
NzgiCiAgICAgICAgIlx4NmVceGNhXHhkMVx4YzlceDFlXHhjY1x4YzZceGNiXHhkMVx4YmVc
eDBjXHg5N1x4MjFceGQ2XHgwNlx4MjNceGViIgogICAgICAgICJceDBlXHgwMlx4ZTFceDlk
XHg0NFx4ZmZceDM2XHhjOFx4NGZceDg5XHgyYVx4MjFceDMyXHg4YVx4MDRceGZmXHg1YiIK
ICAgICAgICAiXHgwOVx4MzZceDk3XHgwM1x4MGNceDljXHhjZlx4ZmJceGNkXHgwMlx4N2Rc
eDY2XHhmMVx4ZDhceDhiXHhkZlx4Y2YiCiAgICAgICAgIlx4MTZceGQ4XHg2Y1x4Y2JceDcy
XHhlNVx4OTZceGZhXHg0ZVx4ODVceDU5XHhmMlx4ZDVceDRkXHg3Mlx4ZjhceGNhIgogICAg
ICAgICJceDkxXHgxZFx4NDlceDM5XHg0MVx4OGNceDdjXHgwYVx4YTJceDlhXHhiM1x4MWRc
eDZjXHg1Y1x4YzdceDZhXHg3YSIKICAgICAgICAiXHhiYlx4ZDRceGU0XHg2NVx4NTRceDE4
XHhiY1x4NWRceDIwXHgwZlx4ZGZceDQyXHhmY1x4Y2RceDM1XHgyZVx4ZDQiCiAgICAgICAg
Ilx4MDZceGZjXHhkNlx4ZmFceDE5XHgwYVx4NDVceGQwXHhlOFx4YTVceGY0XHhhOFx4YjNc
eDg2XHhlNVx4YTVceDMyIgogICAgICAgICJceGJlXHhiY1x4MDdceDA0XHg3Y1x4ZTJceDI5
XHg4YVx4NDhceGE4XHg0MFx4ZTNceDk3XHgzNVx4YmZceDM4IiwKICAgICAgICA0MDk2KTsK
ICAgIHN5c2NhbGwoX19OUl93cml0ZSwgLypmZD0qL3JbMF0sIC8qYnVmPSovMHgyMDAwMmE4
MHVsLCAvKmNvdW50PSovMHgxMDAwdWwpOwogICAgYnJlYWs7CiAgY2FzZSA3OgogICAgc3lz
Y2FsbChfX05SX3dyaXRlLCAvKmZkPSovclsyXSwgLypkYXRhPSovMHgyMDAwMmE0MHVsLAog
ICAgICAgICAgICAvKmxlbj0qLzB4MTU2YTM5NnVsKTsKICAgIGJyZWFrOwogIH0KfQppbnQg
bWFpbih2b2lkKQp7CiAgc3lzY2FsbChfX05SX21tYXAsIC8qYWRkcj0qLzB4MWZmZmYwMDB1
bCwgLypsZW49Ki8weDEwMDB1bCwgLypwcm90PSovMHVsLAogICAgICAgICAgLypmbGFncz0q
LzB4MzJ1bCwgLypmZD0qLy0xLCAvKm9mZnNldD0qLzB1bCk7CiAgc3lzY2FsbChfX05SX21t
YXAsIC8qYWRkcj0qLzB4MjAwMDAwMDB1bCwgLypsZW49Ki8weDEwMDAwMDB1bCwgLypwcm90
PSovN3VsLAogICAgICAgICAgLypmbGFncz0qLzB4MzJ1bCwgLypmZD0qLy0xLCAvKm9mZnNl
dD0qLzB1bCk7CiAgc3lzY2FsbChfX05SX21tYXAsIC8qYWRkcj0qLzB4MjEwMDAwMDB1bCwg
LypsZW49Ki8weDEwMDB1bCwgLypwcm90PSovMHVsLAogICAgICAgICAgLypmbGFncz0qLzB4
MzJ1bCwgLypmZD0qLy0xLCAvKm9mZnNldD0qLzB1bCk7CiAgc2V0dXBfY2dyb3VwcygpOwog
IGZvciAocHJvY2lkID0gMDsgcHJvY2lkIDwgNjsgcHJvY2lkKyspIHsKICAgIGlmIChmb3Jr
KCkgPT0gMCkgewogICAgICB1c2VfdGVtcG9yYXJ5X2RpcigpOwogICAgICBkb19zYW5kYm94
X25vbmUoKTsKICAgIH0KICB9CiAgc2xlZXAoMTAwMDAwMCk7CiAgcmV0dXJuIDA7Cn0K
--------------0jeaIqpEGzlzS2PBRHSLwsZn
Content-Type: text/plain; charset=UTF-8; name="config"
Content-Disposition: attachment; filename="config"
Content-Transfer-Encoding: base64

IwojIEF1dG9tYXRpY2FsbHkgZ2VuZXJhdGVkIGZpbGU7IERPIE5PVCBFRElULgojIExpbnV4
L3g4Nl82NCA1LjEwLjE4NCBLZXJuZWwgQ29uZmlndXJhdGlvbgojCkNPTkZJR19DQ19WRVJT
SU9OX1RFWFQ9ImdjYyAoRGViaWFuIDEwLjIuMS02KSAxMC4yLjEgMjAyMTAxMTAiCkNPTkZJ
R19DQ19JU19HQ0M9eQpDT05GSUdfR0NDX1ZFUlNJT049MTAwMjAxCkNPTkZJR19MRF9WRVJT
SU9OPTIzNTAyMDAwMApDT05GSUdfQ0xBTkdfVkVSU0lPTj0wCkNPTkZJR19BU19JU19HTlU9
eQpDT05GSUdfQVNfVkVSU0lPTj0yMzUwMgpDT05GSUdfTExEX1ZFUlNJT049MApDT05GSUdf
Q0NfQ0FOX0xJTks9eQpDT05GSUdfQ0NfQ0FOX0xJTktfU1RBVElDPXkKQ09ORklHX0NDX0hB
U19BU01fR09UTz15CkNPTkZJR19DQ19IQVNfQVNNX0lOTElORT15CkNPTkZJR19DT05TVFJV
Q1RPUlM9eQpDT05GSUdfSVJRX1dPUks9eQpDT05GSUdfQlVJTERUSU1FX1RBQkxFX1NPUlQ9
eQpDT05GSUdfVEhSRUFEX0lORk9fSU5fVEFTSz15CgojCiMgR2VuZXJhbCBzZXR1cAojCkNP
TkZJR19JTklUX0VOVl9BUkdfTElNSVQ9MzIKIyBDT05GSUdfQ09NUElMRV9URVNUIGlzIG5v
dCBzZXQKIyBDT05GSUdfV0VSUk9SIGlzIG5vdCBzZXQKQ09ORklHX0xPQ0FMVkVSU0lPTj0i
IgpDT05GSUdfTE9DQUxWRVJTSU9OX0FVVE89eQpDT05GSUdfQlVJTERfU0FMVD0iIgpDT05G
SUdfSEFWRV9LRVJORUxfR1pJUD15CkNPTkZJR19IQVZFX0tFUk5FTF9CWklQMj15CkNPTkZJ
R19IQVZFX0tFUk5FTF9MWk1BPXkKQ09ORklHX0hBVkVfS0VSTkVMX1haPXkKQ09ORklHX0hB
VkVfS0VSTkVMX0xaTz15CkNPTkZJR19IQVZFX0tFUk5FTF9MWjQ9eQpDT05GSUdfSEFWRV9L
RVJORUxfWlNURD15CkNPTkZJR19LRVJORUxfR1pJUD15CiMgQ09ORklHX0tFUk5FTF9CWklQ
MiBpcyBub3Qgc2V0CiMgQ09ORklHX0tFUk5FTF9MWk1BIGlzIG5vdCBzZXQKIyBDT05GSUdf
S0VSTkVMX1haIGlzIG5vdCBzZXQKIyBDT05GSUdfS0VSTkVMX0xaTyBpcyBub3Qgc2V0CiMg
Q09ORklHX0tFUk5FTF9MWjQgaXMgbm90IHNldAojIENPTkZJR19LRVJORUxfWlNURCBpcyBu
b3Qgc2V0CkNPTkZJR19ERUZBVUxUX0lOSVQ9IiIKQ09ORklHX0RFRkFVTFRfSE9TVE5BTUU9
ImxvY2FsaG9zdCIKQ09ORklHX1NXQVA9eQojIENPTkZJR19ESVNLX0JBU0VEX1NXQVAgaXMg
bm90IHNldApDT05GSUdfU1lTVklQQz15CkNPTkZJR19TWVNWSVBDX1NZU0NUTD15CiMgQ09O
RklHX1BPU0lYX01RVUVVRSBpcyBub3Qgc2V0CiMgQ09ORklHX1dBVENIX1FVRVVFIGlzIG5v
dCBzZXQKQ09ORklHX0NST1NTX01FTU9SWV9BVFRBQ0g9eQojIENPTkZJR19VU0VMSUIgaXMg
bm90IHNldApDT05GSUdfQVVESVQ9eQpDT05GSUdfSEFWRV9BUkNIX0FVRElUU1lTQ0FMTD15
CkNPTkZJR19BVURJVFNZU0NBTEw9eQoKIwojIElSUSBzdWJzeXN0ZW0KIwpDT05GSUdfR0VO
RVJJQ19JUlFfUFJPQkU9eQpDT05GSUdfR0VORVJJQ19JUlFfU0hPVz15CkNPTkZJR19HRU5F
UklDX0lSUV9FRkZFQ1RJVkVfQUZGX01BU0s9eQpDT05GSUdfR0VORVJJQ19QRU5ESU5HX0lS
UT15CkNPTkZJR19HRU5FUklDX0lSUV9NSUdSQVRJT049eQpDT05GSUdfSEFSRElSUVNfU1df
UkVTRU5EPXkKQ09ORklHX0lSUV9ET01BSU49eQpDT05GSUdfSVJRX0RPTUFJTl9ISUVSQVJD
SFk9eQpDT05GSUdfR0VORVJJQ19NU0lfSVJRPXkKQ09ORklHX0dFTkVSSUNfTVNJX0lSUV9E
T01BSU49eQpDT05GSUdfR0VORVJJQ19JUlFfTUFUUklYX0FMTE9DQVRPUj15CkNPTkZJR19H
RU5FUklDX0lSUV9SRVNFUlZBVElPTl9NT0RFPXkKQ09ORklHX0lSUV9GT1JDRURfVEhSRUFE
SU5HPXkKQ09ORklHX1NQQVJTRV9JUlE9eQojIENPTkZJR19HRU5FUklDX0lSUV9ERUJVR0ZT
IGlzIG5vdCBzZXQKIyBlbmQgb2YgSVJRIHN1YnN5c3RlbQoKQ09ORklHX0NMT0NLU09VUkNF
X1dBVENIRE9HPXkKQ09ORklHX0FSQ0hfQ0xPQ0tTT1VSQ0VfSU5JVD15CkNPTkZJR19DTE9D
S1NPVVJDRV9WQUxJREFURV9MQVNUX0NZQ0xFPXkKQ09ORklHX0dFTkVSSUNfVElNRV9WU1lT
Q0FMTD15CkNPTkZJR19HRU5FUklDX0NMT0NLRVZFTlRTPXkKQ09ORklHX0dFTkVSSUNfQ0xP
Q0tFVkVOVFNfQlJPQURDQVNUPXkKQ09ORklHX0dFTkVSSUNfQ0xPQ0tFVkVOVFNfTUlOX0FE
SlVTVD15CkNPTkZJR19HRU5FUklDX0NNT1NfVVBEQVRFPXkKQ09ORklHX0hBVkVfUE9TSVhf
Q1BVX1RJTUVSU19UQVNLX1dPUks9eQpDT05GSUdfUE9TSVhfQ1BVX1RJTUVSU19UQVNLX1dP
Uks9eQoKIwojIFRpbWVycyBzdWJzeXN0ZW0KIwpDT05GSUdfVElDS19PTkVTSE9UPXkKQ09O
RklHX05PX0haX0NPTU1PTj15CiMgQ09ORklHX0haX1BFUklPRElDIGlzIG5vdCBzZXQKQ09O
RklHX05PX0haX0lETEU9eQojIENPTkZJR19OT19IWl9GVUxMIGlzIG5vdCBzZXQKQ09ORklH
X0NPTlRFWFRfVFJBQ0tJTkc9eQpDT05GSUdfQ09OVEVYVF9UUkFDS0lOR19GT1JDRT15CkNP
TkZJR19OT19IWj15CkNPTkZJR19ISUdIX1JFU19USU1FUlM9eQojIGVuZCBvZiBUaW1lcnMg
c3Vic3lzdGVtCgojIENPTkZJR19QUkVFTVBUX05PTkUgaXMgbm90IHNldAojIENPTkZJR19Q
UkVFTVBUX1ZPTFVOVEFSWSBpcyBub3Qgc2V0CkNPTkZJR19QUkVFTVBUPXkKQ09ORklHX1BS
RUVNUFRfQ09VTlQ9eQpDT05GSUdfUFJFRU1QVElPTj15CkNPTkZJR19TQ0hFRF9DT1JFPXkK
CiMKIyBDUFUvVGFzayB0aW1lIGFuZCBzdGF0cyBhY2NvdW50aW5nCiMKQ09ORklHX1ZJUlRf
Q1BVX0FDQ09VTlRJTkc9eQojIENPTkZJR19USUNLX0NQVV9BQ0NPVU5USU5HIGlzIG5vdCBz
ZXQKQ09ORklHX1ZJUlRfQ1BVX0FDQ09VTlRJTkdfR0VOPXkKIyBDT05GSUdfSVJRX1RJTUVf
QUNDT1VOVElORyBpcyBub3Qgc2V0CiMgQ09ORklHX0JTRF9QUk9DRVNTX0FDQ1QgaXMgbm90
IHNldApDT05GSUdfVEFTS1NUQVRTPXkKQ09ORklHX1RBU0tfREVMQVlfQUNDVD15CkNPTkZJ
R19UQVNLX1hBQ0NUPXkKQ09ORklHX1RBU0tfSU9fQUNDT1VOVElORz15CkNPTkZJR19QU0k9
eQojIENPTkZJR19QU0lfREVGQVVMVF9ESVNBQkxFRCBpcyBub3Qgc2V0CiMgZW5kIG9mIENQ
VS9UYXNrIHRpbWUgYW5kIHN0YXRzIGFjY291bnRpbmcKCkNPTkZJR19DUFVfSVNPTEFUSU9O
PXkKCiMKIyBSQ1UgU3Vic3lzdGVtCiMKQ09ORklHX1RSRUVfUkNVPXkKQ09ORklHX1BSRUVN
UFRfUkNVPXkKIyBDT05GSUdfUkNVX0VYUEVSVCBpcyBub3Qgc2V0CkNPTkZJR19TUkNVPXkK
Q09ORklHX1RSRUVfU1JDVT15CkNPTkZJR19UQVNLU19SQ1VfR0VORVJJQz15CkNPTkZJR19U
QVNLU19SQ1U9eQpDT05GSUdfVEFTS1NfVFJBQ0VfUkNVPXkKQ09ORklHX1JDVV9TVEFMTF9D
T01NT049eQpDT05GSUdfUkNVX05FRURfU0VHQ0JMSVNUPXkKQ09ORklHX1JDVV9CT09UX0VO
RF9ERUxBWT0yMDAwMAojIGVuZCBvZiBSQ1UgU3Vic3lzdGVtCgpDT05GSUdfSUtDT05GSUc9
eQpDT05GSUdfSUtDT05GSUdfUFJPQz15CiMgQ09ORklHX0lLSEVBREVSUyBpcyBub3Qgc2V0
CkNPTkZJR19MT0dfQlVGX1NISUZUPTE4CkNPTkZJR19MT0dfQ1BVX01BWF9CVUZfU0hJRlQ9
MTIKQ09ORklHX1BSSU5US19TQUZFX0xPR19CVUZfU0hJRlQ9MTYKQ09ORklHX0hBVkVfVU5T
VEFCTEVfU0NIRURfQ0xPQ0s9eQoKIwojIFNjaGVkdWxlciBmZWF0dXJlcwojCiMgQ09ORklH
X1VDTEFNUF9UQVNLIGlzIG5vdCBzZXQKIyBlbmQgb2YgU2NoZWR1bGVyIGZlYXR1cmVzCgpD
T05GSUdfQVJDSF9TVVBQT1JUU19OVU1BX0JBTEFOQ0lORz15CkNPTkZJR19BUkNIX1dBTlRf
QkFUQ0hFRF9VTk1BUF9UTEJfRkxVU0g9eQpDT05GSUdfQ0NfSEFTX0lOVDEyOD15CkNPTkZJ
R19BUkNIX1NVUFBPUlRTX0lOVDEyOD15CkNPTkZJR19DR1JPVVBTPXkKQ09ORklHX1BBR0Vf
Q09VTlRFUj15CkNPTkZJR19NRU1DRz15CkNPTkZJR19NRU1DR19TV0FQPXkKQ09ORklHX01F
TUNHX0tNRU09eQpDT05GSUdfQkxLX0NHUk9VUD15CkNPTkZJR19DR1JPVVBfV1JJVEVCQUNL
PXkKQ09ORklHX0NHUk9VUF9TQ0hFRD15CkNPTkZJR19GQUlSX0dST1VQX1NDSEVEPXkKQ09O
RklHX0NGU19CQU5EV0lEVEg9eQpDT05GSUdfUlRfR1JPVVBfU0NIRUQ9eQpDT05GSUdfQ0dS
T1VQX1BJRFM9eQojIENPTkZJR19DR1JPVVBfUkRNQSBpcyBub3Qgc2V0CkNPTkZJR19DR1JP
VVBfRlJFRVpFUj15CkNPTkZJR19DUFVTRVRTPXkKQ09ORklHX1BST0NfUElEX0NQVVNFVD15
CkNPTkZJR19DR1JPVVBfREVWSUNFPXkKQ09ORklHX0NHUk9VUF9DUFVBQ0NUPXkKIyBDT05G
SUdfQ0dST1VQX1BFUkYgaXMgbm90IHNldApDT05GSUdfQ0dST1VQX0JQRj15CiMgQ09ORklH
X0NHUk9VUF9ERUJVRyBpcyBub3Qgc2V0CkNPTkZJR19TT0NLX0NHUk9VUF9EQVRBPXkKQ09O
RklHX05BTUVTUEFDRVM9eQpDT05GSUdfVVRTX05TPXkKQ09ORklHX1RJTUVfTlM9eQpDT05G
SUdfSVBDX05TPXkKQ09ORklHX1VTRVJfTlM9eQpDT05GSUdfUElEX05TPXkKQ09ORklHX05F
VF9OUz15CiMgQ09ORklHX0NIRUNLUE9JTlRfUkVTVE9SRSBpcyBub3Qgc2V0CiMgQ09ORklH
X1NDSEVEX0FVVE9HUk9VUCBpcyBub3Qgc2V0CiMgQ09ORklHX1NZU0ZTX0RFUFJFQ0FURUQg
aXMgbm90IHNldApDT05GSUdfUkVMQVk9eQpDT05GSUdfQkxLX0RFVl9JTklUUkQ9eQpDT05G
SUdfSU5JVFJBTUZTX1NPVVJDRT0iIgpDT05GSUdfUkRfR1pJUD15CiMgQ09ORklHX1JEX0Ja
SVAyIGlzIG5vdCBzZXQKIyBDT05GSUdfUkRfTFpNQSBpcyBub3Qgc2V0CkNPTkZJR19SRF9Y
Wj15CiMgQ09ORklHX1JEX0xaTyBpcyBub3Qgc2V0CiMgQ09ORklHX1JEX0xaNCBpcyBub3Qg
c2V0CiMgQ09ORklHX1JEX1pTVEQgaXMgbm90IHNldAojIENPTkZJR19CT09UX0NPTkZJRyBp
cyBub3Qgc2V0CiMgQ09ORklHX0NDX09QVElNSVpFX0ZPUl9QRVJGT1JNQU5DRSBpcyBub3Qg
c2V0CkNPTkZJR19DQ19PUFRJTUlaRV9GT1JfU0laRT15CkNPTkZJR19MRF9PUlBIQU5fV0FS
Tj15CkNPTkZJR19TWVNDVEw9eQpDT05GSUdfSEFWRV9VSUQxNj15CkNPTkZJR19TWVNDVExf
RVhDRVBUSU9OX1RSQUNFPXkKQ09ORklHX0hBVkVfUENTUEtSX1BMQVRGT1JNPXkKQ09ORklH
X0JQRj15CkNPTkZJR19FWFBFUlQ9eQpDT05GSUdfVUlEMTY9eQpDT05GSUdfTVVMVElVU0VS
PXkKQ09ORklHX1NHRVRNQVNLX1NZU0NBTEw9eQpDT05GSUdfU1lTRlNfU1lTQ0FMTD15CkNP
TkZJR19GSEFORExFPXkKQ09ORklHX1BPU0lYX1RJTUVSUz15CkNPTkZJR19QUklOVEs9eQpD
T05GSUdfUFJJTlRLX05NST15CkNPTkZJR19CVUc9eQpDT05GSUdfRUxGX0NPUkU9eQojIENP
TkZJR19QQ1NQS1JfUExBVEZPUk0gaXMgbm90IHNldApDT05GSUdfQkFTRV9GVUxMPXkKQ09O
RklHX0ZVVEVYPXkKQ09ORklHX0ZVVEVYX1BJPXkKQ09ORklHX0VQT0xMPXkKQ09ORklHX1NJ
R05BTEZEPXkKQ09ORklHX1RJTUVSRkQ9eQpDT05GSUdfRVZFTlRGRD15CkNPTkZJR19TSE1F
TT15CkNPTkZJR19BSU89eQojIENPTkZJR19JT19VUklORyBpcyBub3Qgc2V0CkNPTkZJR19B
RFZJU0VfU1lTQ0FMTFM9eQpDT05GSUdfSEFWRV9BUkNIX1VTRVJGQVVMVEZEX1dQPXkKQ09O
RklHX01FTUJBUlJJRVI9eQpDT05GSUdfS0FMTFNZTVM9eQpDT05GSUdfS0FMTFNZTVNfQUxM
PXkKQ09ORklHX0tBTExTWU1TX0FCU09MVVRFX1BFUkNQVT15CkNPTkZJR19LQUxMU1lNU19C
QVNFX1JFTEFUSVZFPXkKIyBDT05GSUdfQlBGX0xTTSBpcyBub3Qgc2V0CkNPTkZJR19CUEZf
U1lTQ0FMTD15CkNPTkZJR19BUkNIX1dBTlRfREVGQVVMVF9CUEZfSklUPXkKQ09ORklHX0JQ
Rl9KSVRfQUxXQVlTX09OPXkKQ09ORklHX0JQRl9KSVRfREVGQVVMVF9PTj15CkNPTkZJR19C
UEZfVU5QUklWX0RFRkFVTFRfT0ZGPXkKIyBDT05GSUdfQlBGX1BSRUxPQUQgaXMgbm90IHNl
dApDT05GSUdfVVNFUkZBVUxURkQ9eQpDT05GSUdfQVJDSF9IQVNfTUVNQkFSUklFUl9TWU5D
X0NPUkU9eQpDT05GSUdfS0NNUD15CkNPTkZJR19SU0VRPXkKIyBDT05GSUdfREVCVUdfUlNF
USBpcyBub3Qgc2V0CkNPTkZJR19FTUJFRERFRD15CkNPTkZJR19IQVZFX1BFUkZfRVZFTlRT
PXkKIyBDT05GSUdfUEMxMDQgaXMgbm90IHNldAoKIwojIEtlcm5lbCBQZXJmb3JtYW5jZSBF
dmVudHMgQW5kIENvdW50ZXJzCiMKQ09ORklHX1BFUkZfRVZFTlRTPXkKIyBDT05GSUdfREVC
VUdfUEVSRl9VU0VfVk1BTExPQyBpcyBub3Qgc2V0CiMgZW5kIG9mIEtlcm5lbCBQZXJmb3Jt
YW5jZSBFdmVudHMgQW5kIENvdW50ZXJzCgpDT05GSUdfVk1fRVZFTlRfQ09VTlRFUlM9eQpD
T05GSUdfU0xVQl9ERUJVRz15CiMgQ09ORklHX1NMVUJfTUVNQ0dfU1lTRlNfT04gaXMgbm90
IHNldAojIENPTkZJR19DT01QQVRfQlJLIGlzIG5vdCBzZXQKIyBDT05GSUdfU0xBQiBpcyBu
b3Qgc2V0CkNPTkZJR19TTFVCPXkKIyBDT05GSUdfU0xPQiBpcyBub3Qgc2V0CkNPTkZJR19T
TEFCX01FUkdFX0RFRkFVTFQ9eQpDT05GSUdfU0xBQl9GUkVFTElTVF9SQU5ET009eQpDT05G
SUdfU0xBQl9GUkVFTElTVF9IQVJERU5FRD15CiMgQ09ORklHX1NIVUZGTEVfUEFHRV9BTExP
Q0FUT1IgaXMgbm90IHNldApDT05GSUdfU0xVQl9DUFVfUEFSVElBTD15CkNPTkZJR19TWVNU
RU1fREFUQV9WRVJJRklDQVRJT049eQpDT05GSUdfUFJPRklMSU5HPXkKQ09ORklHX1RSQUNF
UE9JTlRTPXkKIyBlbmQgb2YgR2VuZXJhbCBzZXR1cAoKQ09ORklHXzY0QklUPXkKQ09ORklH
X1g4Nl82ND15CkNPTkZJR19YODY9eQpDT05GSUdfSU5TVFJVQ1RJT05fREVDT0RFUj15CkNP
TkZJR19PVVRQVVRfRk9STUFUPSJlbGY2NC14ODYtNjQiCkNPTkZJR19MT0NLREVQX1NVUFBP
UlQ9eQpDT05GSUdfU1RBQ0tUUkFDRV9TVVBQT1JUPXkKQ09ORklHX01NVT15CkNPTkZJR19B
UkNIX01NQVBfUk5EX0JJVFNfTUlOPTI4CkNPTkZJR19BUkNIX01NQVBfUk5EX0JJVFNfTUFY
PTMyCkNPTkZJR19BUkNIX01NQVBfUk5EX0NPTVBBVF9CSVRTX01JTj04CkNPTkZJR19BUkNI
X01NQVBfUk5EX0NPTVBBVF9CSVRTX01BWD0xNgpDT05GSUdfR0VORVJJQ19JU0FfRE1BPXkK
Q09ORklHX0dFTkVSSUNfQlVHPXkKQ09ORklHX0dFTkVSSUNfQlVHX1JFTEFUSVZFX1BPSU5U
RVJTPXkKQ09ORklHX0FSQ0hfTUFZX0hBVkVfUENfRkRDPXkKQ09ORklHX0dFTkVSSUNfQ0FM
SUJSQVRFX0RFTEFZPXkKQ09ORklHX0FSQ0hfSEFTX0NQVV9SRUxBWD15CkNPTkZJR19BUkNI
X0hBU19DQUNIRV9MSU5FX1NJWkU9eQpDT05GSUdfQVJDSF9IQVNfRklMVEVSX1BHUFJPVD15
CkNPTkZJR19IQVZFX1NFVFVQX1BFUl9DUFVfQVJFQT15CkNPTkZJR19ORUVEX1BFUl9DUFVf
RU1CRURfRklSU1RfQ0hVTks9eQpDT05GSUdfTkVFRF9QRVJfQ1BVX1BBR0VfRklSU1RfQ0hV
Tks9eQpDT05GSUdfQVJDSF9ISUJFUk5BVElPTl9QT1NTSUJMRT15CkNPTkZJR19BUkNIX1NV
U1BFTkRfUE9TU0lCTEU9eQpDT05GSUdfQVJDSF9XQU5UX0dFTkVSQUxfSFVHRVRMQj15CkNP
TkZJR19aT05FX0RNQTMyPXkKQ09ORklHX0FVRElUX0FSQ0g9eQpDT05GSUdfQVJDSF9TVVBQ
T1JUU19ERUJVR19QQUdFQUxMT0M9eQpDT05GSUdfS0FTQU5fU0hBRE9XX09GRlNFVD0weGRm
ZmZmYzAwMDAwMDAwMDAKQ09ORklHX1g4Nl82NF9TTVA9eQpDT05GSUdfQVJDSF9TVVBQT1JU
U19VUFJPQkVTPXkKQ09ORklHX0ZJWF9FQVJMWUNPTl9NRU09eQpDT05GSUdfUEdUQUJMRV9M
RVZFTFM9NApDT05GSUdfQ0NfSEFTX1NBTkVfU1RBQ0tQUk9URUNUT1I9eQoKIwojIFByb2Nl
c3NvciB0eXBlIGFuZCBmZWF0dXJlcwojCkNPTkZJR19aT05FX0RNQT15CkNPTkZJR19TTVA9
eQpDT05GSUdfWDg2X0ZFQVRVUkVfTkFNRVM9eQojIENPTkZJR19YODZfWDJBUElDIGlzIG5v
dCBzZXQKQ09ORklHX1g4Nl9NUFBBUlNFPXkKIyBDT05GSUdfR09MREZJU0ggaXMgbm90IHNl
dAojIENPTkZJR19YODZfQ1BVX1JFU0NUUkwgaXMgbm90IHNldApDT05GSUdfWDg2X0VYVEVO
REVEX1BMQVRGT1JNPXkKIyBDT05GSUdfWDg2X1ZTTVAgaXMgbm90IHNldAojIENPTkZJR19Y
ODZfR09MREZJU0ggaXMgbm90IHNldAojIENPTkZJR19YODZfSU5URUxfTUlEIGlzIG5vdCBz
ZXQKQ09ORklHX1g4Nl9JTlRFTF9MUFNTPXkKQ09ORklHX1g4Nl9BTURfUExBVEZPUk1fREVW
SUNFPXkKQ09ORklHX0lPU0ZfTUJJPXkKIyBDT05GSUdfSU9TRl9NQklfREVCVUcgaXMgbm90
IHNldApDT05GSUdfWDg2X1NVUFBPUlRTX01FTU9SWV9GQUlMVVJFPXkKQ09ORklHX1NDSEVE
X09NSVRfRlJBTUVfUE9JTlRFUj15CkNPTkZJR19IWVBFUlZJU09SX0dVRVNUPXkKQ09ORklH
X1BBUkFWSVJUPXkKQ09ORklHX1BBUkFWSVJUX0RFQlVHPXkKQ09ORklHX1BBUkFWSVJUX1NQ
SU5MT0NLUz15CkNPTkZJR19YODZfSFZfQ0FMTEJBQ0tfVkVDVE9SPXkKIyBDT05GSUdfWEVO
IGlzIG5vdCBzZXQKQ09ORklHX0tWTV9HVUVTVD15CkNPTkZJR19BUkNIX0NQVUlETEVfSEFM
VFBPTEw9eQojIENPTkZJR19QVkggaXMgbm90IHNldAojIENPTkZJR19QQVJBVklSVF9USU1F
X0FDQ09VTlRJTkcgaXMgbm90IHNldApDT05GSUdfUEFSQVZJUlRfQ0xPQ0s9eQojIENPTkZJ
R19KQUlMSE9VU0VfR1VFU1QgaXMgbm90IHNldAojIENPTkZJR19BQ1JOX0dVRVNUIGlzIG5v
dCBzZXQKIyBDT05GSUdfTUs4IGlzIG5vdCBzZXQKIyBDT05GSUdfTVBTQyBpcyBub3Qgc2V0
CkNPTkZJR19NQ09SRTI9eQojIENPTkZJR19NQVRPTSBpcyBub3Qgc2V0CiMgQ09ORklHX0dF
TkVSSUNfQ1BVIGlzIG5vdCBzZXQKQ09ORklHX1g4Nl9JTlRFUk5PREVfQ0FDSEVfU0hJRlQ9
NgpDT05GSUdfWDg2X0wxX0NBQ0hFX1NISUZUPTYKQ09ORklHX1g4Nl9JTlRFTF9VU0VSQ09Q
WT15CkNPTkZJR19YODZfVVNFX1BQUk9fQ0hFQ0tTVU09eQpDT05GSUdfWDg2X1A2X05PUD15
CkNPTkZJR19YODZfVFNDPXkKQ09ORklHX1g4Nl9DTVBYQ0hHNjQ9eQpDT05GSUdfWDg2X0NN
T1Y9eQpDT05GSUdfWDg2X01JTklNVU1fQ1BVX0ZBTUlMWT02NApDT05GSUdfWDg2X0RFQlVH
Q1RMTVNSPXkKQ09ORklHX0lBMzJfRkVBVF9DVEw9eQpDT05GSUdfWDg2X1ZNWF9GRUFUVVJF
X05BTUVTPXkKQ09ORklHX1BST0NFU1NPUl9TRUxFQ1Q9eQpDT05GSUdfQ1BVX1NVUF9JTlRF
TD15CkNPTkZJR19DUFVfU1VQX0FNRD15CiMgQ09ORklHX0NQVV9TVVBfSFlHT04gaXMgbm90
IHNldAojIENPTkZJR19DUFVfU1VQX0NFTlRBVVIgaXMgbm90IHNldAojIENPTkZJR19DUFVf
U1VQX1pIQU9YSU4gaXMgbm90IHNldApDT05GSUdfSFBFVF9USU1FUj15CkNPTkZJR19IUEVU
X0VNVUxBVEVfUlRDPXkKQ09ORklHX0RNST15CkNPTkZJR19HQVJUX0lPTU1VPXkKIyBDT05G
SUdfTUFYU01QIGlzIG5vdCBzZXQKQ09ORklHX05SX0NQVVNfUkFOR0VfQkVHSU49MgpDT05G
SUdfTlJfQ1BVU19SQU5HRV9FTkQ9NTEyCkNPTkZJR19OUl9DUFVTX0RFRkFVTFQ9NjQKQ09O
RklHX05SX0NQVVM9OApDT05GSUdfU0NIRURfU01UPXkKQ09ORklHX1NDSEVEX01DPXkKQ09O
RklHX1NDSEVEX01DX1BSSU89eQpDT05GSUdfWDg2X0xPQ0FMX0FQSUM9eQpDT05GSUdfWDg2
X0lPX0FQSUM9eQpDT05GSUdfWDg2X1JFUk9VVEVfRk9SX0JST0tFTl9CT09UX0lSUVM9eQpD
T05GSUdfWDg2X01DRT15CiMgQ09ORklHX1g4Nl9NQ0VMT0dfTEVHQUNZIGlzIG5vdCBzZXQK
Q09ORklHX1g4Nl9NQ0VfSU5URUw9eQojIENPTkZJR19YODZfTUNFX0FNRCBpcyBub3Qgc2V0
CkNPTkZJR19YODZfTUNFX1RIUkVTSE9MRD15CiMgQ09ORklHX1g4Nl9NQ0VfSU5KRUNUIGlz
IG5vdCBzZXQKCiMKIyBQZXJmb3JtYW5jZSBtb25pdG9yaW5nCiMKQ09ORklHX1BFUkZfRVZF
TlRTX0lOVEVMX1VOQ09SRT15CkNPTkZJR19QRVJGX0VWRU5UU19JTlRFTF9SQVBMPXkKQ09O
RklHX1BFUkZfRVZFTlRTX0lOVEVMX0NTVEFURT15CiMgQ09ORklHX1BFUkZfRVZFTlRTX0FN
RF9QT1dFUiBpcyBub3Qgc2V0CiMgZW5kIG9mIFBlcmZvcm1hbmNlIG1vbml0b3JpbmcKCkNP
TkZJR19YODZfMTZCSVQ9eQpDT05GSUdfWDg2X0VTUEZJWDY0PXkKQ09ORklHX1g4Nl9WU1lT
Q0FMTF9FTVVMQVRJT049eQpDT05GSUdfWDg2X0lPUExfSU9QRVJNPXkKIyBDT05GSUdfSThL
IGlzIG5vdCBzZXQKQ09ORklHX01JQ1JPQ09ERT15CkNPTkZJR19NSUNST0NPREVfSU5URUw9
eQpDT05GSUdfTUlDUk9DT0RFX0FNRD15CiMgQ09ORklHX01JQ1JPQ09ERV9MQVRFX0xPQURJ
TkcgaXMgbm90IHNldApDT05GSUdfWDg2X01TUj15CkNPTkZJR19YODZfQ1BVSUQ9eQojIENP
TkZJR19YODZfNUxFVkVMIGlzIG5vdCBzZXQKQ09ORklHX1g4Nl9ESVJFQ1RfR0JQQUdFUz15
CiMgQ09ORklHX1g4Nl9DUEFfU1RBVElTVElDUyBpcyBub3Qgc2V0CiMgQ09ORklHX0FNRF9N
RU1fRU5DUllQVCBpcyBub3Qgc2V0CiMgQ09ORklHX05VTUEgaXMgbm90IHNldApDT05GSUdf
QVJDSF9TUEFSU0VNRU1fRU5BQkxFPXkKQ09ORklHX0FSQ0hfU1BBUlNFTUVNX0RFRkFVTFQ9
eQpDT05GSUdfQVJDSF9TRUxFQ1RfTUVNT1JZX01PREVMPXkKQ09ORklHX0FSQ0hfUFJPQ19L
Q09SRV9URVhUPXkKQ09ORklHX0lMTEVHQUxfUE9JTlRFUl9WQUxVRT0weGRlYWQwMDAwMDAw
MDAwMDAKIyBDT05GSUdfWDg2X1BNRU1fTEVHQUNZIGlzIG5vdCBzZXQKIyBDT05GSUdfWDg2
X0NIRUNLX0JJT1NfQ09SUlVQVElPTiBpcyBub3Qgc2V0CkNPTkZJR19YODZfUkVTRVJWRV9M
T1c9NjQKQ09ORklHX01UUlI9eQojIENPTkZJR19NVFJSX1NBTklUSVpFUiBpcyBub3Qgc2V0
CkNPTkZJR19YODZfUEFUPXkKQ09ORklHX0FSQ0hfVVNFU19QR19VTkNBQ0hFRD15CkNPTkZJ
R19BUkNIX1JBTkRPTT15CkNPTkZJR19YODZfU01BUD15CkNPTkZJR19YODZfVU1JUD15CkNP
TkZJR19YODZfSU5URUxfTUVNT1JZX1BST1RFQ1RJT05fS0VZUz15CiMgQ09ORklHX1g4Nl9J
TlRFTF9UU1hfTU9ERV9PRkYgaXMgbm90IHNldApDT05GSUdfWDg2X0lOVEVMX1RTWF9NT0RF
X09OPXkKIyBDT05GSUdfWDg2X0lOVEVMX1RTWF9NT0RFX0FVVE8gaXMgbm90IHNldAojIENP
TkZJR19FRkkgaXMgbm90IHNldApDT05GSUdfSFpfMTAwPXkKIyBDT05GSUdfSFpfMjUwIGlz
IG5vdCBzZXQKIyBDT05GSUdfSFpfMzAwIGlzIG5vdCBzZXQKIyBDT05GSUdfSFpfMTAwMCBp
cyBub3Qgc2V0CkNPTkZJR19IWj0xMDAKQ09ORklHX1NDSEVEX0hSVElDSz15CiMgQ09ORklH
X0tFWEVDIGlzIG5vdCBzZXQKIyBDT05GSUdfS0VYRUNfRklMRSBpcyBub3Qgc2V0CiMgQ09O
RklHX0NSQVNIX0RVTVAgaXMgbm90IHNldApDT05GSUdfUEhZU0lDQUxfU1RBUlQ9MHgxMDAw
MDAwCiMgQ09ORklHX1JFTE9DQVRBQkxFIGlzIG5vdCBzZXQKQ09ORklHX1BIWVNJQ0FMX0FM
SUdOPTB4MjAwMDAwCkNPTkZJR19IT1RQTFVHX0NQVT15CiMgQ09ORklHX0JPT1RQQVJBTV9I
T1RQTFVHX0NQVTAgaXMgbm90IHNldAojIENPTkZJR19ERUJVR19IT1RQTFVHX0NQVTAgaXMg
bm90IHNldAojIENPTkZJR19DT01QQVRfVkRTTyBpcyBub3Qgc2V0CkNPTkZJR19MRUdBQ1lf
VlNZU0NBTExfRU1VTEFURT15CiMgQ09ORklHX0xFR0FDWV9WU1lTQ0FMTF9YT05MWSBpcyBu
b3Qgc2V0CiMgQ09ORklHX0xFR0FDWV9WU1lTQ0FMTF9OT05FIGlzIG5vdCBzZXQKQ09ORklH
X0NNRExJTkVfQk9PTD15CkNPTkZJR19DTURMSU5FPSJlYXJseXByaW50az1zZXJpYWwgbmV0
LmlmbmFtZXM9MCBzeXNjdGwua2VybmVsLmh1bmdfdGFza19hbGxfY3B1X2JhY2t0cmFjZT0x
IGltYV9wb2xpY3k9dGNiIG5mLWNvbm50cmFjay1mdHAucG9ydHM9MjAwMDAgbmYtY29ubnRy
YWNrLXRmdHAucG9ydHM9MjAwMDAgbmYtY29ubnRyYWNrLXNpcC5wb3J0cz0yMDAwMCBuZi1j
b25udHJhY2staXJjLnBvcnRzPTIwMDAwIG5mLWNvbm50cmFjay1zYW5lLnBvcnRzPTIwMDAw
IGJpbmRlci5kZWJ1Z19tYXNrPTAgcmN1cGRhdGUucmN1X2V4cGVkaXRlZD0xIHJjdXBkYXRl
LnJjdV9jcHVfc3RhbGxfY3B1dGltZT0xIG5vX2hhc2hfcG9pbnRlcnMgcGFnZV9vd25lcj1v
biBzeXNjdGwudm0ubnJfaHVnZXBhZ2VzPTQgc3lzY3RsLnZtLm5yX292ZXJjb21taXRfaHVn
ZXBhZ2VzPTQgc2VjcmV0bWVtLmVuYWJsZT0xIHN5c2N0bC5tYXhfcmN1X3N0YWxsX3RvX3Bh
bmljPTEgbXNyLmFsbG93X3dyaXRlcz1vZmYgY29yZWR1bXBfZmlsdGVyPTB4ZmZmZiByb290
PS9kZXYvc2RhIGNvbnNvbGU9dHR5UzAgdnN5c2NhbGw9bmF0aXZlIG51bWE9ZmFrZT0yIGt2
bS1pbnRlbC5uZXN0ZWQ9MSBzcGVjX3N0b3JlX2J5cGFzc19kaXNhYmxlPXByY3RsIG5vcGNp
ZCB2aXZpZC5uX2RldnM9MTYgdml2aWQubXVsdGlwbGFuYXI9MSwyLDEsMiwxLDIsMSwyLDEs
MiwxLDIsMSwyLDEsMiBuZXRyb20ubnJfbmRldnM9MTYgcm9zZS5yb3NlX25kZXZzPTE2IHNt
cC5jc2RfbG9ja190aW1lb3V0PTEwMDAwMCB3YXRjaGRvZ190aHJlc2g9NTUgd29ya3F1ZXVl
LndhdGNoZG9nX3RocmVzaD0xNDAgc3lzY3RsLm5ldC5jb3JlLm5ldGRldl91bnJlZ2lzdGVy
X3RpbWVvdXRfc2Vjcz0xNDAgZHVtbXlfaGNkLm51bT04IHBhbmljX29uX3dhcm49MSBub3Jl
c3VtZSBub3N3YXAgZG1fdmVyaXR5LmVycm9yX2JlaGF2aW9yPTMgZG1fdmVyaXR5Lm1heF9i
aW9zPS0xIGRtX3Zlcml0eS5kZXZfd2FpdD0xIGk5MTUubW9kZXNldD0xIGNyb3NfZWZpIgoj
IENPTkZJR19DTURMSU5FX09WRVJSSURFIGlzIG5vdCBzZXQKQ09ORklHX01PRElGWV9MRFRf
U1lTQ0FMTD15CkNPTkZJR19IQVZFX0xJVkVQQVRDSD15CiMgZW5kIG9mIFByb2Nlc3NvciB0
eXBlIGFuZCBmZWF0dXJlcwoKQ09ORklHX0NDX0hBU19SRVRVUk5fVEhVTks9eQpDT05GSUdf
U1BFQ1VMQVRJT05fTUlUSUdBVElPTlM9eQojIENPTkZJR19QQUdFX1RBQkxFX0lTT0xBVElP
TiBpcyBub3Qgc2V0CiMgQ09ORklHX1JFVFBPTElORSBpcyBub3Qgc2V0CkNPTkZJR19DUFVf
SUJQQl9FTlRSWT15CkNPTkZJR19DUFVfSUJSU19FTlRSWT15CkNPTkZJR19BUkNIX0hBU19B
RERfUEFHRVM9eQpDT05GSUdfQVJDSF9FTkFCTEVfTUVNT1JZX0hPVFBMVUc9eQpDT05GSUdf
QVJDSF9FTkFCTEVfU1BMSVRfUE1EX1BUTE9DSz15CgojCiMgUG93ZXIgbWFuYWdlbWVudCBh
bmQgQUNQSSBvcHRpb25zCiMKQ09ORklHX1NVU1BFTkQ9eQpDT05GSUdfU1VTUEVORF9GUkVF
WkVSPXkKIyBDT05GSUdfU1VTUEVORF9TS0lQX1NZTkMgaXMgbm90IHNldAojIENPTkZJR19I
SUJFUk5BVElPTiBpcyBub3Qgc2V0CkNPTkZJR19QTV9TTEVFUD15CkNPTkZJR19QTV9TTEVF
UF9TTVA9eQojIENPTkZJR19QTV9BVVRPU0xFRVAgaXMgbm90IHNldApDT05GSUdfUE1fV0FL
RUxPQ0tTPXkKQ09ORklHX1BNX1dBS0VMT0NLU19MSU1JVD0xMDAKQ09ORklHX1BNX1dBS0VM
T0NLU19HQz15CkNPTkZJR19QTT15CkNPTkZJR19QTV9ERUJVRz15CkNPTkZJR19QTV9BRFZB
TkNFRF9ERUJVRz15CiMgQ09ORklHX1BNX1RFU1RfU1VTUEVORCBpcyBub3Qgc2V0CkNPTkZJ
R19QTV9TTEVFUF9ERUJVRz15CiMgQ09ORklHX0RQTV9XQVRDSERPRyBpcyBub3Qgc2V0CkNP
TkZJR19QTV9UUkFDRT15CkNPTkZJR19QTV9UUkFDRV9SVEM9eQpDT05GSUdfUE1fQ0xLPXkK
IyBDT05GSUdfV1FfUE9XRVJfRUZGSUNJRU5UX0RFRkFVTFQgaXMgbm90IHNldAojIENPTkZJ
R19FTkVSR1lfTU9ERUwgaXMgbm90IHNldApDT05GSUdfQVJDSF9TVVBQT1JUU19BQ1BJPXkK
Q09ORklHX0FDUEk9eQpDT05GSUdfQUNQSV9MRUdBQ1lfVEFCTEVTX0xPT0tVUD15CkNPTkZJ
R19BUkNIX01JR0hUX0hBVkVfQUNQSV9QREM9eQpDT05GSUdfQUNQSV9TWVNURU1fUE9XRVJf
U1RBVEVTX1NVUFBPUlQ9eQojIENPTkZJR19BQ1BJX0RFQlVHR0VSIGlzIG5vdCBzZXQKQ09O
RklHX0FDUElfU1BDUl9UQUJMRT15CkNPTkZJR19BQ1BJX0xQSVQ9eQpDT05GSUdfQUNQSV9T
TEVFUD15CkNPTkZJR19BQ1BJX1JFVl9PVkVSUklERV9QT1NTSUJMRT15CiMgQ09ORklHX0FD
UElfRUNfREVCVUdGUyBpcyBub3Qgc2V0CkNPTkZJR19BQ1BJX0FDPXkKQ09ORklHX0FDUElf
QkFUVEVSWT15CkNPTkZJR19BQ1BJX0JVVFRPTj15CkNPTkZJR19BQ1BJX1ZJREVPPXkKQ09O
RklHX0FDUElfRkFOPXkKIyBDT05GSUdfQUNQSV9UQUQgaXMgbm90IHNldApDT05GSUdfQUNQ
SV9ET0NLPXkKQ09ORklHX0FDUElfQ1BVX0ZSRVFfUFNTPXkKQ09ORklHX0FDUElfUFJPQ0VT
U09SX0NTVEFURT15CkNPTkZJR19BQ1BJX1BST0NFU1NPUl9JRExFPXkKQ09ORklHX0FDUElf
Q1BQQ19MSUI9eQpDT05GSUdfQUNQSV9QUk9DRVNTT1I9eQpDT05GSUdfQUNQSV9IT1RQTFVH
X0NQVT15CiMgQ09ORklHX0FDUElfUFJPQ0VTU09SX0FHR1JFR0FUT1IgaXMgbm90IHNldApD
T05GSUdfQUNQSV9USEVSTUFMPXkKQ09ORklHX0FSQ0hfSEFTX0FDUElfVEFCTEVfVVBHUkFE
RT15CkNPTkZJR19BQ1BJX1RBQkxFX1VQR1JBREU9eQojIENPTkZJR19BQ1BJX0RFQlVHIGlz
IG5vdCBzZXQKIyBDT05GSUdfQUNQSV9QQ0lfU0xPVCBpcyBub3Qgc2V0CkNPTkZJR19BQ1BJ
X0NPTlRBSU5FUj15CkNPTkZJR19BQ1BJX0hPVFBMVUdfSU9BUElDPXkKIyBDT05GSUdfQUNQ
SV9TQlMgaXMgbm90IHNldAojIENPTkZJR19BQ1BJX0hFRCBpcyBub3Qgc2V0CiMgQ09ORklH
X0FDUElfQ1VTVE9NX01FVEhPRCBpcyBub3Qgc2V0CiMgQ09ORklHX0FDUElfUkVEVUNFRF9I
QVJEV0FSRV9PTkxZIGlzIG5vdCBzZXQKIyBDT05GSUdfQUNQSV9ORklUIGlzIG5vdCBzZXQK
Q09ORklHX0hBVkVfQUNQSV9BUEVJPXkKQ09ORklHX0hBVkVfQUNQSV9BUEVJX05NST15CkNP
TkZJR19BQ1BJX0FQRUk9eQojIENPTkZJR19BQ1BJX0FQRUlfR0hFUyBpcyBub3Qgc2V0CiMg
Q09ORklHX0FDUElfQVBFSV9QQ0lFQUVSIGlzIG5vdCBzZXQKIyBDT05GSUdfQUNQSV9BUEVJ
X0VJTkogaXMgbm90IHNldAojIENPTkZJR19BQ1BJX0FQRUlfRVJTVF9ERUJVRyBpcyBub3Qg
c2V0CiMgQ09ORklHX0FDUElfRFBURiBpcyBub3Qgc2V0CiMgQ09ORklHX0FDUElfQ09ORklH
RlMgaXMgbm90IHNldAojIENPTkZJR19QTUlDX09QUkVHSU9OIGlzIG5vdCBzZXQKQ09ORklH
X1g4Nl9QTV9USU1FUj15CiMgQ09ORklHX1NGSSBpcyBub3Qgc2V0CgojCiMgQ1BVIEZyZXF1
ZW5jeSBzY2FsaW5nCiMKQ09ORklHX0NQVV9GUkVRPXkKQ09ORklHX0NQVV9GUkVRX0dPVl9B
VFRSX1NFVD15CkNPTkZJR19DUFVfRlJFUV9HT1ZfQ09NTU9OPXkKQ09ORklHX0NQVV9GUkVR
X1NUQVQ9eQojIENPTkZJR19DUFVfRlJFUV9USU1FUyBpcyBub3Qgc2V0CiMgQ09ORklHX0NQ
VV9GUkVRX0RFRkFVTFRfR09WX1BFUkZPUk1BTkNFIGlzIG5vdCBzZXQKIyBDT05GSUdfQ1BV
X0ZSRVFfREVGQVVMVF9HT1ZfUE9XRVJTQVZFIGlzIG5vdCBzZXQKIyBDT05GSUdfQ1BVX0ZS
RVFfREVGQVVMVF9HT1ZfVVNFUlNQQUNFIGlzIG5vdCBzZXQKQ09ORklHX0NQVV9GUkVRX0RF
RkFVTFRfR09WX1NDSEVEVVRJTD15CkNPTkZJR19DUFVfRlJFUV9HT1ZfUEVSRk9STUFOQ0U9
eQpDT05GSUdfQ1BVX0ZSRVFfR09WX1BPV0VSU0FWRT15CkNPTkZJR19DUFVfRlJFUV9HT1Zf
VVNFUlNQQUNFPXkKIyBDT05GSUdfQ1BVX0ZSRVFfR09WX09OREVNQU5EIGlzIG5vdCBzZXQK
Q09ORklHX0NQVV9GUkVRX0dPVl9DT05TRVJWQVRJVkU9eQpDT05GSUdfQ1BVX0ZSRVFfR09W
X1NDSEVEVVRJTD15CiMgQ09ORklHX0NQVV9CT09TVCBpcyBub3Qgc2V0CgojCiMgQ1BVIGZy
ZXF1ZW5jeSBzY2FsaW5nIGRyaXZlcnMKIwojIENPTkZJR19DUFVGUkVRX0RUIGlzIG5vdCBz
ZXQKIyBDT05GSUdfQ1BVRlJFUV9EVU1NWSBpcyBub3Qgc2V0CkNPTkZJR19YODZfSU5URUxf
UFNUQVRFPXkKIyBDT05GSUdfWDg2X1BDQ19DUFVGUkVRIGlzIG5vdCBzZXQKQ09ORklHX1g4
Nl9BQ1BJX0NQVUZSRVE9eQpDT05GSUdfWDg2X0FDUElfQ1BVRlJFUV9DUEI9eQojIENPTkZJ
R19YODZfUE9XRVJOT1dfSzggaXMgbm90IHNldAojIENPTkZJR19YODZfU1BFRURTVEVQX0NF
TlRSSU5PIGlzIG5vdCBzZXQKIyBDT05GSUdfWDg2X1A0X0NMT0NLTU9EIGlzIG5vdCBzZXQK
CiMKIyBzaGFyZWQgb3B0aW9ucwojCiMgZW5kIG9mIENQVSBGcmVxdWVuY3kgc2NhbGluZwoK
IwojIENQVSBJZGxlCiMKQ09ORklHX0NQVV9JRExFPXkKQ09ORklHX0NQVV9JRExFX0dPVl9M
QURERVI9eQpDT05GSUdfQ1BVX0lETEVfR09WX01FTlU9eQpDT05GSUdfQ1BVX0lETEVfR09W
X1RFTz15CkNPTkZJR19DUFVfSURMRV9HT1ZfSEFMVFBPTEw9eQpDT05GSUdfSEFMVFBPTExf
Q1BVSURMRT15CiMgZW5kIG9mIENQVSBJZGxlCgpDT05GSUdfSU5URUxfSURMRT15CiMgZW5k
IG9mIFBvd2VyIG1hbmFnZW1lbnQgYW5kIEFDUEkgb3B0aW9ucwoKIwojIEJ1cyBvcHRpb25z
IChQQ0kgZXRjLikKIwpDT05GSUdfUENJX0RJUkVDVD15CkNPTkZJR19QQ0lfTU1DT05GSUc9
eQpDT05GSUdfTU1DT05GX0ZBTTEwSD15CiMgQ09ORklHX1BDSV9DTkIyMExFX1FVSVJLIGlz
IG5vdCBzZXQKIyBDT05GSUdfSVNBX0JVUyBpcyBub3Qgc2V0CkNPTkZJR19JU0FfRE1BX0FQ
ST15CkNPTkZJR19BTURfTkI9eQojIENPTkZJR19YODZfU1lTRkIgaXMgbm90IHNldAojIGVu
ZCBvZiBCdXMgb3B0aW9ucyAoUENJIGV0Yy4pCgojCiMgQmluYXJ5IEVtdWxhdGlvbnMKIwpD
T05GSUdfSUEzMl9FTVVMQVRJT049eQpDT05GSUdfWDg2X1gzMj15CkNPTkZJR19DT01QQVRf
MzI9eQpDT05GSUdfQ09NUEFUPXkKQ09ORklHX0NPTVBBVF9GT1JfVTY0X0FMSUdOTUVOVD15
CkNPTkZJR19TWVNWSVBDX0NPTVBBVD15CiMgZW5kIG9mIEJpbmFyeSBFbXVsYXRpb25zCgpD
T05GSUdfSEFWRV9LVk09eQpDT05GSUdfSEFWRV9LVk1fSVJRQ0hJUD15CkNPTkZJR19IQVZF
X0tWTV9JUlFGRD15CkNPTkZJR19IQVZFX0tWTV9JUlFfUk9VVElORz15CkNPTkZJR19IQVZF
X0tWTV9FVkVOVEZEPXkKQ09ORklHX0tWTV9NTUlPPXkKQ09ORklHX0tWTV9BU1lOQ19QRj15
CkNPTkZJR19IQVZFX0tWTV9NU0k9eQpDT05GSUdfSEFWRV9LVk1fQ1BVX1JFTEFYX0lOVEVS
Q0VQVD15CkNPTkZJR19LVk1fVkZJTz15CkNPTkZJR19LVk1fR0VORVJJQ19ESVJUWUxPR19S
RUFEX1BST1RFQ1Q9eQpDT05GSUdfS1ZNX0NPTVBBVD15CkNPTkZJR19IQVZFX0tWTV9JUlFf
QllQQVNTPXkKQ09ORklHX0hBVkVfS1ZNX05PX1BPTEw9eQpDT05GSUdfS1ZNX1hGRVJfVE9f
R1VFU1RfV09SSz15CkNPTkZJR19IQVZFX0tWTV9QTV9OT1RJRklFUj15CkNPTkZJR19WSVJU
VUFMSVpBVElPTj15CkNPTkZJR19LVk09eQojIENPTkZJR19LVk1fV0VSUk9SIGlzIG5vdCBz
ZXQKQ09ORklHX0tWTV9JTlRFTD15CkNPTkZJR19LVk1fQU1EPXkKIyBDT05GSUdfS1ZNX01N
VV9BVURJVCBpcyBub3Qgc2V0CiMgQ09ORklHX0tWTV9WSVJUX1NVU1BFTkRfVElNSU5HIGlz
IG5vdCBzZXQKQ09ORklHX0FTX0FWWDUxMj15CkNPTkZJR19BU19TSEExX05JPXkKQ09ORklH
X0FTX1NIQTI1Nl9OST15CkNPTkZJR19BU19UUEFVU0U9eQoKIwojIEdlbmVyYWwgYXJjaGl0
ZWN0dXJlLWRlcGVuZGVudCBvcHRpb25zCiMKQ09ORklHX0NSQVNIX0NPUkU9eQpDT05GSUdf
SE9UUExVR19TTVQ9eQpDT05GSUdfR0VORVJJQ19FTlRSWT15CiMgQ09ORklHX09QUk9GSUxF
IGlzIG5vdCBzZXQKQ09ORklHX0hBVkVfT1BST0ZJTEU9eQpDT05GSUdfT1BST0ZJTEVfTk1J
X1RJTUVSPXkKIyBDT05GSUdfS1BST0JFUyBpcyBub3Qgc2V0CiMgQ09ORklHX0pVTVBfTEFC
RUwgaXMgbm90IHNldAojIENPTkZJR19TVEFUSUNfQ0FMTF9TRUxGVEVTVCBpcyBub3Qgc2V0
CkNPTkZJR19VUFJPQkVTPXkKQ09ORklHX0hBVkVfRUZGSUNJRU5UX1VOQUxJR05FRF9BQ0NF
U1M9eQpDT05GSUdfQVJDSF9VU0VfQlVJTFRJTl9CU1dBUD15CkNPTkZJR19VU0VSX1JFVFVS
Tl9OT1RJRklFUj15CkNPTkZJR19IQVZFX0lPUkVNQVBfUFJPVD15CkNPTkZJR19IQVZFX0tQ
Uk9CRVM9eQpDT05GSUdfSEFWRV9LUkVUUFJPQkVTPXkKQ09ORklHX0hBVkVfT1BUUFJPQkVT
PXkKQ09ORklHX0hBVkVfS1BST0JFU19PTl9GVFJBQ0U9eQpDT05GSUdfSEFWRV9GVU5DVElP
Tl9FUlJPUl9JTkpFQ1RJT049eQpDT05GSUdfSEFWRV9OTUk9eQpDT05GSUdfSEFWRV9BUkNI
X1RSQUNFSE9PSz15CkNPTkZJR19IQVZFX0RNQV9DT05USUdVT1VTPXkKQ09ORklHX0dFTkVS
SUNfU01QX0lETEVfVEhSRUFEPXkKQ09ORklHX0FSQ0hfSEFTX0ZPUlRJRllfU09VUkNFPXkK
Q09ORklHX0FSQ0hfSEFTX1NFVF9NRU1PUlk9eQpDT05GSUdfQVJDSF9IQVNfU0VUX0RJUkVD
VF9NQVA9eQpDT05GSUdfSEFWRV9BUkNIX1RIUkVBRF9TVFJVQ1RfV0hJVEVMSVNUPXkKQ09O
RklHX0FSQ0hfV0FOVFNfRFlOQU1JQ19UQVNLX1NUUlVDVD15CkNPTkZJR19IQVZFX0FTTV9N
T0RWRVJTSU9OUz15CkNPTkZJR19IQVZFX1JFR1NfQU5EX1NUQUNLX0FDQ0VTU19BUEk9eQpD
T05GSUdfSEFWRV9SU0VRPXkKQ09ORklHX0hBVkVfRlVOQ1RJT05fQVJHX0FDQ0VTU19BUEk9
eQpDT05GSUdfSEFWRV9IV19CUkVBS1BPSU5UPXkKQ09ORklHX0hBVkVfTUlYRURfQlJFQUtQ
T0lOVFNfUkVHUz15CkNPTkZJR19IQVZFX1VTRVJfUkVUVVJOX05PVElGSUVSPXkKQ09ORklH
X0hBVkVfUEVSRl9FVkVOVFNfTk1JPXkKQ09ORklHX0hBVkVfSEFSRExPQ0tVUF9ERVRFQ1RP
Ul9QRVJGPXkKQ09ORklHX0hBVkVfUEVSRl9SRUdTPXkKQ09ORklHX0hBVkVfUEVSRl9VU0VS
X1NUQUNLX0RVTVA9eQpDT05GSUdfSEFWRV9BUkNIX0pVTVBfTEFCRUw9eQpDT05GSUdfSEFW
RV9BUkNIX0pVTVBfTEFCRUxfUkVMQVRJVkU9eQpDT05GSUdfTU1VX0dBVEhFUl9UQUJMRV9G
UkVFPXkKQ09ORklHX01NVV9HQVRIRVJfUkNVX1RBQkxFX0ZSRUU9eQpDT05GSUdfQVJDSF9I
QVZFX05NSV9TQUZFX0NNUFhDSEc9eQpDT05GSUdfSEFWRV9BTElHTkVEX1NUUlVDVF9QQUdF
PXkKQ09ORklHX0hBVkVfQ01QWENIR19MT0NBTD15CkNPTkZJR19IQVZFX0NNUFhDSEdfRE9V
QkxFPXkKQ09ORklHX0FSQ0hfV0FOVF9DT01QQVRfSVBDX1BBUlNFX1ZFUlNJT049eQpDT05G
SUdfQVJDSF9XQU5UX09MRF9DT01QQVRfSVBDPXkKQ09ORklHX0hBVkVfQVJDSF9TRUNDT01Q
PXkKQ09ORklHX0hBVkVfQVJDSF9TRUNDT01QX0ZJTFRFUj15CkNPTkZJR19TRUNDT01QPXkK
Q09ORklHX1NFQ0NPTVBfRklMVEVSPXkKQ09ORklHX0hBVkVfQVJDSF9TVEFDS0xFQUs9eQpD
T05GSUdfSEFWRV9TVEFDS1BST1RFQ1RPUj15CkNPTkZJR19TVEFDS1BST1RFQ1RPUj15CkNP
TkZJR19TVEFDS1BST1RFQ1RPUl9TVFJPTkc9eQpDT05GSUdfSEFWRV9BUkNIX1dJVEhJTl9T
VEFDS19GUkFNRVM9eQpDT05GSUdfSEFWRV9DT05URVhUX1RSQUNLSU5HPXkKQ09ORklHX0hB
VkVfVklSVF9DUFVfQUNDT1VOVElOR19HRU49eQpDT05GSUdfSEFWRV9JUlFfVElNRV9BQ0NP
VU5USU5HPXkKQ09ORklHX0hBVkVfTU9WRV9QTUQ9eQpDT05GSUdfSEFWRV9BUkNIX1RSQU5T
UEFSRU5UX0hVR0VQQUdFPXkKQ09ORklHX0hBVkVfQVJDSF9UUkFOU1BBUkVOVF9IVUdFUEFH
RV9QVUQ9eQpDT05GSUdfSEFWRV9BUkNIX0hVR0VfVk1BUD15CkNPTkZJR19BUkNIX1dBTlRf
SFVHRV9QTURfU0hBUkU9eQpDT05GSUdfSEFWRV9BUkNIX1NPRlRfRElSVFk9eQpDT05GSUdf
SEFWRV9NT0RfQVJDSF9TUEVDSUZJQz15CkNPTkZJR19NT0RVTEVTX1VTRV9FTEZfUkVMQT15
CkNPTkZJR19BUkNIX0hBU19FTEZfUkFORE9NSVpFPXkKQ09ORklHX0hBVkVfQVJDSF9NTUFQ
X1JORF9CSVRTPXkKQ09ORklHX0hBVkVfRVhJVF9USFJFQUQ9eQpDT05GSUdfQVJDSF9NTUFQ
X1JORF9CSVRTPTMxCkNPTkZJR19IQVZFX0FSQ0hfTU1BUF9STkRfQ09NUEFUX0JJVFM9eQpD
T05GSUdfQVJDSF9NTUFQX1JORF9DT01QQVRfQklUUz0xNgpDT05GSUdfSEFWRV9BUkNIX0NP
TVBBVF9NTUFQX0JBU0VTPXkKQ09ORklHX0hBVkVfU1RBQ0tfVkFMSURBVElPTj15CkNPTkZJ
R19IQVZFX1JFTElBQkxFX1NUQUNLVFJBQ0U9eQpDT05GSUdfT0xEX1NJR1NVU1BFTkQzPXkK
Q09ORklHX0NPTVBBVF9PTERfU0lHQUNUSU9OPXkKQ09ORklHX0NPTVBBVF8zMkJJVF9USU1F
PXkKQ09ORklHX0hBVkVfQVJDSF9WTUFQX1NUQUNLPXkKQ09ORklHX1ZNQVBfU1RBQ0s9eQpD
T05GSUdfQVJDSF9IQVNfU1RSSUNUX0tFUk5FTF9SV1g9eQpDT05GSUdfU1RSSUNUX0tFUk5F
TF9SV1g9eQpDT05GSUdfQVJDSF9IQVNfU1RSSUNUX01PRFVMRV9SV1g9eQpDT05GSUdfU1RS
SUNUX01PRFVMRV9SV1g9eQpDT05GSUdfSEFWRV9BUkNIX1BSRUwzMl9SRUxPQ0FUSU9OUz15
CiMgQ09ORklHX0xPQ0tfRVZFTlRfQ09VTlRTIGlzIG5vdCBzZXQKQ09ORklHX0FSQ0hfSEFT
X01FTV9FTkNSWVBUPXkKQ09ORklHX0hBVkVfU1RBVElDX0NBTEw9eQpDT05GSUdfSEFWRV9T
VEFUSUNfQ0FMTF9JTkxJTkU9eQpDT05GSUdfQVJDSF9XQU5UX0xEX09SUEhBTl9XQVJOPXkK
Q09ORklHX0FSQ0hfSEFTX05PTkxFQUZfUE1EX1lPVU5HPXkKCiMKIyBHQ09WLWJhc2VkIGtl
cm5lbCBwcm9maWxpbmcKIwojIENPTkZJR19HQ09WX0tFUk5FTCBpcyBub3Qgc2V0CkNPTkZJ
R19BUkNIX0hBU19HQ09WX1BST0ZJTEVfQUxMPXkKIyBlbmQgb2YgR0NPVi1iYXNlZCBrZXJu
ZWwgcHJvZmlsaW5nCgpDT05GSUdfSEFWRV9HQ0NfUExVR0lOUz15CiMgZW5kIG9mIEdlbmVy
YWwgYXJjaGl0ZWN0dXJlLWRlcGVuZGVudCBvcHRpb25zCgpDT05GSUdfUlRfTVVURVhFUz15
CkNPTkZJR19CQVNFX1NNQUxMPTAKQ09ORklHX01PRFVMRVM9eQojIENPTkZJR19NT0RVTEVf
Rk9SQ0VfTE9BRCBpcyBub3Qgc2V0CkNPTkZJR19NT0RVTEVfVU5MT0FEPXkKQ09ORklHX01P
RFVMRV9GT1JDRV9VTkxPQUQ9eQojIENPTkZJR19NT0RWRVJTSU9OUyBpcyBub3Qgc2V0CiMg
Q09ORklHX01PRFVMRV9TUkNWRVJTSU9OX0FMTCBpcyBub3Qgc2V0CiMgQ09ORklHX01PRFVM
RV9TSUcgaXMgbm90IHNldApDT05GSUdfTU9EVUxFX0NPTVBSRVNTPXkKQ09ORklHX01PRFVM
RV9DT01QUkVTU19HWklQPXkKIyBDT05GSUdfTU9EVUxFX0NPTVBSRVNTX1haIGlzIG5vdCBz
ZXQKQ09ORklHX01PRFVMRV9ERUNPTVBSRVNTPXkKIyBDT05GSUdfTU9EVUxFX0FMTE9XX01J
U1NJTkdfTkFNRVNQQUNFX0lNUE9SVFMgaXMgbm90IHNldAojIENPTkZJR19VTlVTRURfU1lN
Qk9MUyBpcyBub3Qgc2V0CiMgQ09ORklHX1RSSU1fVU5VU0VEX0tTWU1TIGlzIG5vdCBzZXQK
Q09ORklHX01PRFVMRVNfVFJFRV9MT09LVVA9eQpDT05GSUdfQkxPQ0s9eQpDT05GSUdfQkxL
X1NDU0lfUkVRVUVTVD15CkNPTkZJR19CTEtfQ0dST1VQX1JXU1RBVD15CkNPTkZJR19CTEtf
REVWX0JTRz15CiMgQ09ORklHX0JMS19ERVZfQlNHTElCIGlzIG5vdCBzZXQKQ09ORklHX0JM
S19ERVZfSU5URUdSSVRZPXkKQ09ORklHX0JMS19ERVZfSU5URUdSSVRZX1QxMD15CiMgQ09O
RklHX0JMS19ERVZfWk9ORUQgaXMgbm90IHNldAojIENPTkZJR19CTEtfREVWX1RIUk9UVExJ
TkcgaXMgbm90IHNldAojIENPTkZJR19CTEtfQ01ETElORV9QQVJTRVIgaXMgbm90IHNldAoj
IENPTkZJR19CTEtfV0JUIGlzIG5vdCBzZXQKIyBDT05GSUdfQkxLX0NHUk9VUF9JT0xBVEVO
Q1kgaXMgbm90IHNldAojIENPTkZJR19CTEtfQ0dST1VQX0lPQ09TVCBpcyBub3Qgc2V0CiMg
Q09ORklHX0JMS19ERUJVR19GUyBpcyBub3Qgc2V0CiMgQ09ORklHX0JMS19TRURfT1BBTCBp
cyBub3Qgc2V0CiMgQ09ORklHX0JMS19JTkxJTkVfRU5DUllQVElPTiBpcyBub3Qgc2V0Cgoj
CiMgUGFydGl0aW9uIFR5cGVzCiMKQ09ORklHX1BBUlRJVElPTl9BRFZBTkNFRD15CiMgQ09O
RklHX0FDT1JOX1BBUlRJVElPTiBpcyBub3Qgc2V0CiMgQ09ORklHX0FJWF9QQVJUSVRJT04g
aXMgbm90IHNldAojIENPTkZJR19PU0ZfUEFSVElUSU9OIGlzIG5vdCBzZXQKIyBDT05GSUdf
QU1JR0FfUEFSVElUSU9OIGlzIG5vdCBzZXQKIyBDT05GSUdfQVRBUklfUEFSVElUSU9OIGlz
IG5vdCBzZXQKQ09ORklHX01BQ19QQVJUSVRJT049eQpDT05GSUdfTVNET1NfUEFSVElUSU9O
PXkKIyBDT05GSUdfQlNEX0RJU0tMQUJFTCBpcyBub3Qgc2V0CiMgQ09ORklHX01JTklYX1NV
QlBBUlRJVElPTiBpcyBub3Qgc2V0CiMgQ09ORklHX1NPTEFSSVNfWDg2X1BBUlRJVElPTiBp
cyBub3Qgc2V0CiMgQ09ORklHX1VOSVhXQVJFX0RJU0tMQUJFTCBpcyBub3Qgc2V0CiMgQ09O
RklHX0xETV9QQVJUSVRJT04gaXMgbm90IHNldAojIENPTkZJR19TR0lfUEFSVElUSU9OIGlz
IG5vdCBzZXQKIyBDT05GSUdfVUxUUklYX1BBUlRJVElPTiBpcyBub3Qgc2V0CiMgQ09ORklH
X1NVTl9QQVJUSVRJT04gaXMgbm90IHNldAojIENPTkZJR19LQVJNQV9QQVJUSVRJT04gaXMg
bm90IHNldApDT05GSUdfRUZJX1BBUlRJVElPTj15CiMgQ09ORklHX1NZU1Y2OF9QQVJUSVRJ
T04gaXMgbm90IHNldAojIENPTkZJR19DTURMSU5FX1BBUlRJVElPTiBpcyBub3Qgc2V0CiMg
ZW5kIG9mIFBhcnRpdGlvbiBUeXBlcwoKQ09ORklHX0JMT0NLX0NPTVBBVD15CkNPTkZJR19C
TEtfTVFfUENJPXkKQ09ORklHX0JMS19NUV9WSVJUSU89eQpDT05GSUdfQkxLX1BNPXkKCiMK
IyBJTyBTY2hlZHVsZXJzCiMKQ09ORklHX01RX0lPU0NIRURfREVBRExJTkU9eQpDT05GSUdf
TVFfSU9TQ0hFRF9LWUJFUj15CkNPTkZJR19JT1NDSEVEX0JGUT15CkNPTkZJR19CRlFfR1JP
VVBfSU9TQ0hFRD15CiMgQ09ORklHX0JGUV9DR1JPVVBfREVCVUcgaXMgbm90IHNldAojIGVu
ZCBvZiBJTyBTY2hlZHVsZXJzCgpDT05GSUdfUFJFRU1QVF9OT1RJRklFUlM9eQpDT05GSUdf
QVNOMT15CkNPTkZJR19VTklOTElORV9TUElOX1VOTE9DSz15CkNPTkZJR19BUkNIX1NVUFBP
UlRTX0FUT01JQ19STVc9eQpDT05GSUdfTVVURVhfU1BJTl9PTl9PV05FUj15CkNPTkZJR19S
V1NFTV9TUElOX09OX09XTkVSPXkKQ09ORklHX0xPQ0tfU1BJTl9PTl9PV05FUj15CkNPTkZJ
R19BUkNIX1VTRV9RVUVVRURfU1BJTkxPQ0tTPXkKQ09ORklHX1FVRVVFRF9TUElOTE9DS1M9
eQpDT05GSUdfQVJDSF9VU0VfUVVFVUVEX1JXTE9DS1M9eQpDT05GSUdfUVVFVUVEX1JXTE9D
S1M9eQpDT05GSUdfQVJDSF9IQVNfTk9OX09WRVJMQVBQSU5HX0FERFJFU1NfU1BBQ0U9eQpD
T05GSUdfQVJDSF9IQVNfU1lOQ19DT1JFX0JFRk9SRV9VU0VSTU9ERT15CkNPTkZJR19BUkNI
X0hBU19TWVNDQUxMX1dSQVBQRVI9eQpDT05GSUdfRlJFRVpFUj15CgojCiMgRXhlY3V0YWJs
ZSBmaWxlIGZvcm1hdHMKIwpDT05GSUdfQklORk1UX0VMRj15CkNPTkZJR19DT01QQVRfQklO
Rk1UX0VMRj15CkNPTkZJR19FTEZDT1JFPXkKQ09ORklHX0NPUkVfRFVNUF9ERUZBVUxUX0VM
Rl9IRUFERVJTPXkKQ09ORklHX0JJTkZNVF9TQ1JJUFQ9eQpDT05GSUdfQklORk1UX01JU0M9
eQpDT05GSUdfQ09SRURVTVA9eQojIGVuZCBvZiBFeGVjdXRhYmxlIGZpbGUgZm9ybWF0cwoK
IwojIE1lbW9yeSBNYW5hZ2VtZW50IG9wdGlvbnMKIwpDT05GSUdfU0VMRUNUX01FTU9SWV9N
T0RFTD15CkNPTkZJR19TUEFSU0VNRU1fTUFOVUFMPXkKQ09ORklHX1NQQVJTRU1FTT15CkNP
TkZJR19TUEFSU0VNRU1fRVhUUkVNRT15CkNPTkZJR19TUEFSU0VNRU1fVk1FTU1BUF9FTkFC
TEU9eQpDT05GSUdfU1BBUlNFTUVNX1ZNRU1NQVA9eQpDT05GSUdfSEFWRV9GQVNUX0dVUD15
CiMgQ09ORklHX01FTU9SWV9IT1RQTFVHIGlzIG5vdCBzZXQKQ09ORklHX1NQTElUX1BUTE9D
S19DUFVTPTQKQ09ORklHX0NPTVBBQ1RJT049eQojIENPTkZJR19QQUdFX1JFUE9SVElORyBp
cyBub3Qgc2V0CkNPTkZJR19QUk9DRVNTX1JFQ0xBSU09eQpDT05GSUdfTUlHUkFUSU9OPXkK
Q09ORklHX1BIWVNfQUREUl9UXzY0QklUPXkKQ09ORklHX0JPVU5DRT15CkNPTkZJR19WSVJU
X1RPX0JVUz15CkNPTkZJR19NTVVfTk9USUZJRVI9eQojIENPTkZJR19LU00gaXMgbm90IHNl
dApDT05GSUdfREVGQVVMVF9NTUFQX01JTl9BRERSPTMyNzY4CkNPTkZJR19NTUFQX05PRVhF
Q19UQUlOVD0wCkNPTkZJR19BUkNIX1NVUFBPUlRTX01FTU9SWV9GQUlMVVJFPXkKIyBDT05G
SUdfTUVNT1JZX0ZBSUxVUkUgaXMgbm90IHNldAojIENPTkZJR19UUkFOU1BBUkVOVF9IVUdF
UEFHRSBpcyBub3Qgc2V0CkNPTkZJR19BUkNIX1dBTlRTX1RIUF9TV0FQPXkKIyBDT05GSUdf
Q0xFQU5DQUNIRSBpcyBub3Qgc2V0CiMgQ09ORklHX0ZST05UU1dBUCBpcyBub3Qgc2V0CiMg
Q09ORklHX0NNQSBpcyBub3Qgc2V0CiMgQ09ORklHX1pQT09MIGlzIG5vdCBzZXQKIyBDT05G
SUdfWkJVRCBpcyBub3Qgc2V0CkNPTkZJR19aU01BTExPQz15CiMgQ09ORklHX1pTTUFMTE9D
X1NUQVQgaXMgbm90IHNldApDT05GSUdfR0VORVJJQ19FQVJMWV9JT1JFTUFQPXkKIyBDT05G
SUdfREVGRVJSRURfU1RSVUNUX1BBR0VfSU5JVCBpcyBub3Qgc2V0CiMgQ09ORklHX0lETEVf
UEFHRV9UUkFDS0lORyBpcyBub3Qgc2V0CkNPTkZJR19BUkNIX0hBU19QVEVfREVWTUFQPXkK
Q09ORklHX1ZNQVBfUEZOPXkKQ09ORklHX0ZSQU1FX1ZFQ1RPUj15CkNPTkZJR19BUkNIX1VT
RVNfSElHSF9WTUFfRkxBR1M9eQpDT05GSUdfQVJDSF9IQVNfUEtFWVM9eQojIENPTkZJR19Q
RVJDUFVfU1RBVFMgaXMgbm90IHNldAojIENPTkZJR19HVVBfQkVOQ0hNQVJLIGlzIG5vdCBz
ZXQKQ09ORklHX0FSQ0hfSEFTX1BURV9TUEVDSUFMPXkKQ09ORklHX0xPV19NRU1fTk9USUZZ
PXkKQ09ORklHX0xSVV9HRU49eQpDT05GSUdfTFJVX0dFTl9FTkFCTEVEPXkKIyBDT05GSUdf
TFJVX0dFTl9TVEFUUyBpcyBub3Qgc2V0CiMgZW5kIG9mIE1lbW9yeSBNYW5hZ2VtZW50IG9w
dGlvbnMKCkNPTkZJR19ORVQ9eQpDT05GSUdfQ09NUEFUX05FVExJTktfTUVTU0FHRVM9eQpD
T05GSUdfTkVUX0lOR1JFU1M9eQpDT05GSUdfTkVUX0VHUkVTUz15CkNPTkZJR19TS0JfRVhU
RU5TSU9OUz15CgojCiMgTmV0d29ya2luZyBvcHRpb25zCiMKQ09ORklHX1BBQ0tFVD15CiMg
Q09ORklHX1BBQ0tFVF9ESUFHIGlzIG5vdCBzZXQKQ09ORklHX1VOSVg9eQpDT05GSUdfVU5J
WF9TQ009eQojIENPTkZJR19VTklYX0RJQUcgaXMgbm90IHNldAojIENPTkZJR19UTFMgaXMg
bm90IHNldApDT05GSUdfWEZSTT15CkNPTkZJR19YRlJNX0FMR089eQpDT05GSUdfWEZSTV9V
U0VSPXkKIyBDT05GSUdfWEZSTV9VU0VSX0NPTVBBVCBpcyBub3Qgc2V0CkNPTkZJR19YRlJN
X0lOVEVSRkFDRT15CiMgQ09ORklHX1hGUk1fU1VCX1BPTElDWSBpcyBub3Qgc2V0CiMgQ09O
RklHX1hGUk1fTUlHUkFURSBpcyBub3Qgc2V0CiMgQ09ORklHX1hGUk1fU1RBVElTVElDUyBp
cyBub3Qgc2V0CkNPTkZJR19YRlJNX0FIPXkKQ09ORklHX1hGUk1fRVNQPXkKQ09ORklHX1hG
Uk1fSVBDT01QPXkKQ09ORklHX05FVF9LRVk9eQojIENPTkZJR19ORVRfS0VZX01JR1JBVEUg
aXMgbm90IHNldAojIENPTkZJR19YRFBfU09DS0VUUyBpcyBub3Qgc2V0CkNPTkZJR19JTkVU
PXkKQ09ORklHX0lQX01VTFRJQ0FTVD15CkNPTkZJR19JUF9BRFZBTkNFRF9ST1VURVI9eQoj
IENPTkZJR19JUF9GSUJfVFJJRV9TVEFUUyBpcyBub3Qgc2V0CkNPTkZJR19JUF9NVUxUSVBM
RV9UQUJMRVM9eQpDT05GSUdfSVBfUk9VVEVfTVVMVElQQVRIPXkKQ09ORklHX0lQX1JPVVRF
X1ZFUkJPU0U9eQpDT05GSUdfSVBfUE5QPXkKQ09ORklHX0lQX1BOUF9ESENQPXkKIyBDT05G
SUdfSVBfUE5QX0JPT1RQIGlzIG5vdCBzZXQKIyBDT05GSUdfSVBfUE5QX1JBUlAgaXMgbm90
IHNldAojIENPTkZJR19ORVRfSVBJUCBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9JUEdSRV9E
RU1VWCBpcyBub3Qgc2V0CkNPTkZJR19ORVRfSVBfVFVOTkVMPXkKQ09ORklHX0lQX01ST1VU
RV9DT01NT049eQpDT05GSUdfSVBfTVJPVVRFPXkKIyBDT05GSUdfSVBfTVJPVVRFX01VTFRJ
UExFX1RBQkxFUyBpcyBub3Qgc2V0CkNPTkZJR19JUF9QSU1TTV9WMT15CkNPTkZJR19JUF9Q
SU1TTV9WMj15CkNPTkZJR19TWU5fQ09PS0lFUz15CiMgQ09ORklHX05FVF9JUFZUSSBpcyBu
b3Qgc2V0CkNPTkZJR19ORVRfVURQX1RVTk5FTD15CiMgQ09ORklHX05FVF9GT1UgaXMgbm90
IHNldAojIENPTkZJR19ORVRfRk9VX0lQX1RVTk5FTFMgaXMgbm90IHNldApDT05GSUdfSU5F
VF9BSD15CkNPTkZJR19JTkVUX0VTUD15CiMgQ09ORklHX0lORVRfRVNQX09GRkxPQUQgaXMg
bm90IHNldAojIENPTkZJR19JTkVUX0VTUElOVENQIGlzIG5vdCBzZXQKQ09ORklHX0lORVRf
SVBDT01QPXkKQ09ORklHX0lORVRfVEFCTEVfUEVSVFVSQl9PUkRFUj0xNgpDT05GSUdfSU5F
VF9YRlJNX1RVTk5FTD15CkNPTkZJR19JTkVUX1RVTk5FTD15CkNPTkZJR19JTkVUX0RJQUc9
eQpDT05GSUdfSU5FVF9UQ1BfRElBRz15CkNPTkZJR19JTkVUX1VEUF9ESUFHPXkKIyBDT05G
SUdfSU5FVF9SQVdfRElBRyBpcyBub3Qgc2V0CkNPTkZJR19JTkVUX0RJQUdfREVTVFJPWT15
CkNPTkZJR19UQ1BfQ09OR19BRFZBTkNFRD15CiMgQ09ORklHX1RDUF9DT05HX0JJQyBpcyBu
b3Qgc2V0CkNPTkZJR19UQ1BfQ09OR19DVUJJQz15CiMgQ09ORklHX1RDUF9DT05HX1dFU1RX
T09EIGlzIG5vdCBzZXQKIyBDT05GSUdfVENQX0NPTkdfSFRDUCBpcyBub3Qgc2V0CiMgQ09O
RklHX1RDUF9DT05HX0hTVENQIGlzIG5vdCBzZXQKIyBDT05GSUdfVENQX0NPTkdfSFlCTEEg
aXMgbm90IHNldAojIENPTkZJR19UQ1BfQ09OR19WRUdBUyBpcyBub3Qgc2V0CiMgQ09ORklH
X1RDUF9DT05HX05WIGlzIG5vdCBzZXQKIyBDT05GSUdfVENQX0NPTkdfU0NBTEFCTEUgaXMg
bm90IHNldApDT05GSUdfVENQX0NPTkdfTFA9eQojIENPTkZJR19UQ1BfQ09OR19WRU5PIGlz
IG5vdCBzZXQKIyBDT05GSUdfVENQX0NPTkdfWUVBSCBpcyBub3Qgc2V0CiMgQ09ORklHX1RD
UF9DT05HX0lMTElOT0lTIGlzIG5vdCBzZXQKIyBDT05GSUdfVENQX0NPTkdfRENUQ1AgaXMg
bm90IHNldAojIENPTkZJR19UQ1BfQ09OR19DREcgaXMgbm90IHNldAojIENPTkZJR19UQ1Bf
Q09OR19CQlIgaXMgbm90IHNldApDT05GSUdfREVGQVVMVF9DVUJJQz15CiMgQ09ORklHX0RF
RkFVTFRfUkVOTyBpcyBub3Qgc2V0CkNPTkZJR19ERUZBVUxUX1RDUF9DT05HPSJjdWJpYyIK
Q09ORklHX1RDUF9NRDVTSUc9eQpDT05GSUdfSVBWNj15CkNPTkZJR19JUFY2X1JPVVRFUl9Q
UkVGPXkKQ09ORklHX0lQVjZfUk9VVEVfSU5GTz15CiMgQ09ORklHX0lQVjZfT1BUSU1JU1RJ
Q19EQUQgaXMgbm90IHNldApDT05GSUdfSU5FVDZfQUg9eQpDT05GSUdfSU5FVDZfRVNQPXkK
IyBDT05GSUdfSU5FVDZfRVNQX09GRkxPQUQgaXMgbm90IHNldAojIENPTkZJR19JTkVUNl9F
U1BJTlRDUCBpcyBub3Qgc2V0CiMgQ09ORklHX0lORVQ2X0lQQ09NUCBpcyBub3Qgc2V0CiMg
Q09ORklHX0lQVjZfTUlQNiBpcyBub3Qgc2V0CiMgQ09ORklHX0lQVjZfSUxBIGlzIG5vdCBz
ZXQKIyBDT05GSUdfSVBWNl9WVEkgaXMgbm90IHNldApDT05GSUdfSVBWNl9TSVQ9eQojIENP
TkZJR19JUFY2X1NJVF82UkQgaXMgbm90IHNldApDT05GSUdfSVBWNl9ORElTQ19OT0RFVFlQ
RT15CiMgQ09ORklHX0lQVjZfVFVOTkVMIGlzIG5vdCBzZXQKQ09ORklHX0lQVjZfTVVMVElQ
TEVfVEFCTEVTPXkKIyBDT05GSUdfSVBWNl9TVUJUUkVFUyBpcyBub3Qgc2V0CiMgQ09ORklH
X0lQVjZfTVJPVVRFIGlzIG5vdCBzZXQKIyBDT05GSUdfSVBWNl9TRUc2X0xXVFVOTkVMIGlz
IG5vdCBzZXQKIyBDT05GSUdfSVBWNl9TRUc2X0hNQUMgaXMgbm90IHNldAojIENPTkZJR19J
UFY2X1JQTF9MV1RVTk5FTCBpcyBub3Qgc2V0CiMgQ09ORklHX05FVExBQkVMIGlzIG5vdCBz
ZXQKIyBDT05GSUdfTVBUQ1AgaXMgbm90IHNldApDT05GSUdfTkVUV09SS19TRUNNQVJLPXkK
Q09ORklHX05FVF9QVFBfQ0xBU1NJRlk9eQojIENPTkZJR19ORVRXT1JLX1BIWV9USU1FU1RB
TVBJTkcgaXMgbm90IHNldApDT05GSUdfTkVURklMVEVSPXkKQ09ORklHX05FVEZJTFRFUl9B
RFZBTkNFRD15CiMgQ09ORklHX0JSSURHRV9ORVRGSUxURVIgaXMgbm90IHNldAoKIwojIENv
cmUgTmV0ZmlsdGVyIENvbmZpZ3VyYXRpb24KIwpDT05GSUdfTkVURklMVEVSX0lOR1JFU1M9
eQpDT05GSUdfTkVURklMVEVSX05FVExJTks9eQojIENPTkZJR19ORVRGSUxURVJfTkVUTElO
S19BQ0NUIGlzIG5vdCBzZXQKQ09ORklHX05FVEZJTFRFUl9ORVRMSU5LX1FVRVVFPXkKQ09O
RklHX05FVEZJTFRFUl9ORVRMSU5LX0xPRz15CiMgQ09ORklHX05FVEZJTFRFUl9ORVRMSU5L
X09TRiBpcyBub3Qgc2V0CkNPTkZJR19ORl9DT05OVFJBQ0s9eQojIENPTkZJR19ORl9MT0df
TkVUREVWIGlzIG5vdCBzZXQKQ09ORklHX05FVEZJTFRFUl9DT05OQ09VTlQ9eQpDT05GSUdf
TkZfQ09OTlRSQUNLX01BUks9eQpDT05GSUdfTkZfQ09OTlRSQUNLX1NFQ01BUks9eQojIENP
TkZJR19ORl9DT05OVFJBQ0tfWk9ORVMgaXMgbm90IHNldApDT05GSUdfTkZfQ09OTlRSQUNL
X1BST0NGUz15CkNPTkZJR19ORl9DT05OVFJBQ0tfRVZFTlRTPXkKQ09ORklHX05GX0NPTk5U
UkFDS19USU1FT1VUPXkKIyBDT05GSUdfTkZfQ09OTlRSQUNLX1RJTUVTVEFNUCBpcyBub3Qg
c2V0CiMgQ09ORklHX05GX0NPTk5UUkFDS19MQUJFTFMgaXMgbm90IHNldAojIENPTkZJR19O
Rl9DVF9QUk9UT19EQ0NQIGlzIG5vdCBzZXQKQ09ORklHX05GX0NUX1BST1RPX0dSRT15CiMg
Q09ORklHX05GX0NUX1BST1RPX1NDVFAgaXMgbm90IHNldAojIENPTkZJR19ORl9DVF9QUk9U
T19VRFBMSVRFIGlzIG5vdCBzZXQKIyBDT05GSUdfTkZfQ09OTlRSQUNLX0FNQU5EQSBpcyBu
b3Qgc2V0CkNPTkZJR19ORl9DT05OVFJBQ0tfRlRQPXkKIyBDT05GSUdfTkZfQ09OTlRSQUNL
X0gzMjMgaXMgbm90IHNldAojIENPTkZJR19ORl9DT05OVFJBQ0tfSVJDIGlzIG5vdCBzZXQK
IyBDT05GSUdfTkZfQ09OTlRSQUNLX05FVEJJT1NfTlMgaXMgbm90IHNldAojIENPTkZJR19O
Rl9DT05OVFJBQ0tfU05NUCBpcyBub3Qgc2V0CkNPTkZJR19ORl9DT05OVFJBQ0tfUFBUUD15
CiMgQ09ORklHX05GX0NPTk5UUkFDS19TQU5FIGlzIG5vdCBzZXQKIyBDT05GSUdfTkZfQ09O
TlRSQUNLX1NJUCBpcyBub3Qgc2V0CkNPTkZJR19ORl9DT05OVFJBQ0tfVEZUUD15CkNPTkZJ
R19ORl9DVF9ORVRMSU5LPXkKQ09ORklHX05GX0NUX05FVExJTktfVElNRU9VVD15CkNPTkZJ
R19ORl9DVF9ORVRMSU5LX0hFTFBFUj15CkNPTkZJR19ORVRGSUxURVJfTkVUTElOS19HTFVF
X0NUPXkKQ09ORklHX05GX05BVD15CkNPTkZJR19ORl9OQVRfRlRQPXkKQ09ORklHX05GX05B
VF9URlRQPXkKQ09ORklHX05GX05BVF9SRURJUkVDVD15CkNPTkZJR19ORl9OQVRfTUFTUVVF
UkFERT15CiMgQ09ORklHX05GX1RBQkxFUyBpcyBub3Qgc2V0CkNPTkZJR19ORVRGSUxURVJf
WFRBQkxFUz15CgojCiMgWHRhYmxlcyBjb21iaW5lZCBtb2R1bGVzCiMKQ09ORklHX05FVEZJ
TFRFUl9YVF9NQVJLPXkKQ09ORklHX05FVEZJTFRFUl9YVF9DT05OTUFSSz15CgojCiMgWHRh
YmxlcyB0YXJnZXRzCiMKIyBDT05GSUdfTkVURklMVEVSX1hUX1RBUkdFVF9BVURJVCBpcyBu
b3Qgc2V0CiMgQ09ORklHX05FVEZJTFRFUl9YVF9UQVJHRVRfQ0hFQ0tTVU0gaXMgbm90IHNl
dApDT05GSUdfTkVURklMVEVSX1hUX1RBUkdFVF9DTEFTU0lGWT15CkNPTkZJR19ORVRGSUxU
RVJfWFRfVEFSR0VUX0NPTk5NQVJLPXkKQ09ORklHX05FVEZJTFRFUl9YVF9UQVJHRVRfQ09O
TlNFQ01BUks9eQpDT05GSUdfTkVURklMVEVSX1hUX1RBUkdFVF9DVD15CkNPTkZJR19ORVRG
SUxURVJfWFRfVEFSR0VUX0RTQ1A9eQojIENPTkZJR19ORVRGSUxURVJfWFRfVEFSR0VUX0hM
IGlzIG5vdCBzZXQKIyBDT05GSUdfTkVURklMVEVSX1hUX1RBUkdFVF9ITUFSSyBpcyBub3Qg
c2V0CkNPTkZJR19ORVRGSUxURVJfWFRfVEFSR0VUX0lETEVUSU1FUj15CiMgQ09ORklHX05F
VEZJTFRFUl9YVF9UQVJHRVRfTEVEIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVURklMVEVSX1hU
X1RBUkdFVF9MT0cgaXMgbm90IHNldApDT05GSUdfTkVURklMVEVSX1hUX1RBUkdFVF9NQVJL
PXkKQ09ORklHX05FVEZJTFRFUl9YVF9OQVQ9eQojIENPTkZJR19ORVRGSUxURVJfWFRfVEFS
R0VUX05FVE1BUCBpcyBub3Qgc2V0CkNPTkZJR19ORVRGSUxURVJfWFRfVEFSR0VUX05GTE9H
PXkKQ09ORklHX05FVEZJTFRFUl9YVF9UQVJHRVRfTkZRVUVVRT15CiMgQ09ORklHX05FVEZJ
TFRFUl9YVF9UQVJHRVRfTk9UUkFDSyBpcyBub3Qgc2V0CiMgQ09ORklHX05FVEZJTFRFUl9Y
VF9UQVJHRVRfUkFURUVTVCBpcyBub3Qgc2V0CkNPTkZJR19ORVRGSUxURVJfWFRfVEFSR0VU
X1JFRElSRUNUPXkKQ09ORklHX05FVEZJTFRFUl9YVF9UQVJHRVRfTUFTUVVFUkFERT15CiMg
Q09ORklHX05FVEZJTFRFUl9YVF9UQVJHRVRfVEVFIGlzIG5vdCBzZXQKQ09ORklHX05FVEZJ
TFRFUl9YVF9UQVJHRVRfVFBST1hZPXkKQ09ORklHX05FVEZJTFRFUl9YVF9UQVJHRVRfVFJB
Q0U9eQpDT05GSUdfTkVURklMVEVSX1hUX1RBUkdFVF9TRUNNQVJLPXkKQ09ORklHX05FVEZJ
TFRFUl9YVF9UQVJHRVRfVENQTVNTPXkKIyBDT05GSUdfTkVURklMVEVSX1hUX1RBUkdFVF9U
Q1BPUFRTVFJJUCBpcyBub3Qgc2V0CgojCiMgWHRhYmxlcyBtYXRjaGVzCiMKQ09ORklHX05F
VEZJTFRFUl9YVF9NQVRDSF9BRERSVFlQRT15CkNPTkZJR19ORVRGSUxURVJfWFRfTUFUQ0hf
QlBGPXkKQ09ORklHX05FVEZJTFRFUl9YVF9NQVRDSF9DR1JPVVA9eQojIENPTkZJR19ORVRG
SUxURVJfWFRfTUFUQ0hfQ0xVU1RFUiBpcyBub3Qgc2V0CkNPTkZJR19ORVRGSUxURVJfWFRf
TUFUQ0hfQ09NTUVOVD15CiMgQ09ORklHX05FVEZJTFRFUl9YVF9NQVRDSF9DT05OQllURVMg
aXMgbm90IHNldAojIENPTkZJR19ORVRGSUxURVJfWFRfTUFUQ0hfQ09OTkxBQkVMIGlzIG5v
dCBzZXQKQ09ORklHX05FVEZJTFRFUl9YVF9NQVRDSF9DT05OTElNSVQ9eQpDT05GSUdfTkVU
RklMVEVSX1hUX01BVENIX0NPTk5NQVJLPXkKQ09ORklHX05FVEZJTFRFUl9YVF9NQVRDSF9D
T05OVFJBQ0s9eQojIENPTkZJR19ORVRGSUxURVJfWFRfTUFUQ0hfQ1BVIGlzIG5vdCBzZXQK
IyBDT05GSUdfTkVURklMVEVSX1hUX01BVENIX0RDQ1AgaXMgbm90IHNldAojIENPTkZJR19O
RVRGSUxURVJfWFRfTUFUQ0hfREVWR1JPVVAgaXMgbm90IHNldApDT05GSUdfTkVURklMVEVS
X1hUX01BVENIX0RTQ1A9eQojIENPTkZJR19ORVRGSUxURVJfWFRfTUFUQ0hfRUNOIGlzIG5v
dCBzZXQKIyBDT05GSUdfTkVURklMVEVSX1hUX01BVENIX0VTUCBpcyBub3Qgc2V0CkNPTkZJ
R19ORVRGSUxURVJfWFRfTUFUQ0hfSEFTSExJTUlUPXkKQ09ORklHX05FVEZJTFRFUl9YVF9N
QVRDSF9IRUxQRVI9eQojIENPTkZJR19ORVRGSUxURVJfWFRfTUFUQ0hfSEwgaXMgbm90IHNl
dAojIENPTkZJR19ORVRGSUxURVJfWFRfTUFUQ0hfSVBDT01QIGlzIG5vdCBzZXQKQ09ORklH
X05FVEZJTFRFUl9YVF9NQVRDSF9JUFJBTkdFPXkKIyBDT05GSUdfTkVURklMVEVSX1hUX01B
VENIX0wyVFAgaXMgbm90IHNldApDT05GSUdfTkVURklMVEVSX1hUX01BVENIX0xFTkdUSD15
CkNPTkZJR19ORVRGSUxURVJfWFRfTUFUQ0hfTElNSVQ9eQpDT05GSUdfTkVURklMVEVSX1hU
X01BVENIX01BQz15CkNPTkZJR19ORVRGSUxURVJfWFRfTUFUQ0hfTUFSSz15CiMgQ09ORklH
X05FVEZJTFRFUl9YVF9NQVRDSF9NVUxUSVBPUlQgaXMgbm90IHNldAojIENPTkZJR19ORVRG
SUxURVJfWFRfTUFUQ0hfTkZBQ0NUIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVURklMVEVSX1hU
X01BVENIX09TRiBpcyBub3Qgc2V0CiMgQ09ORklHX05FVEZJTFRFUl9YVF9NQVRDSF9PV05F
UiBpcyBub3Qgc2V0CkNPTkZJR19ORVRGSUxURVJfWFRfTUFUQ0hfUE9MSUNZPXkKQ09ORklH
X05FVEZJTFRFUl9YVF9NQVRDSF9QS1RUWVBFPXkKQ09ORklHX05FVEZJTFRFUl9YVF9NQVRD
SF9RVEFHVUlEPXkKQ09ORklHX05FVEZJTFRFUl9YVF9NQVRDSF9RVU9UQT15CkNPTkZJR19O
RVRGSUxURVJfWFRfTUFUQ0hfUVVPVEEyPXkKQ09ORklHX05FVEZJTFRFUl9YVF9NQVRDSF9R
VU9UQTJfTE9HPXkKIyBDT05GSUdfTkVURklMVEVSX1hUX01BVENIX1JBVEVFU1QgaXMgbm90
IHNldAojIENPTkZJR19ORVRGSUxURVJfWFRfTUFUQ0hfUkVBTE0gaXMgbm90IHNldAojIENP
TkZJR19ORVRGSUxURVJfWFRfTUFUQ0hfUkVDRU5UIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVU
RklMVEVSX1hUX01BVENIX1NDVFAgaXMgbm90IHNldApDT05GSUdfTkVURklMVEVSX1hUX01B
VENIX1NPQ0tFVD15CkNPTkZJR19ORVRGSUxURVJfWFRfTUFUQ0hfU1RBVEU9eQpDT05GSUdf
TkVURklMVEVSX1hUX01BVENIX1NUQVRJU1RJQz15CkNPTkZJR19ORVRGSUxURVJfWFRfTUFU
Q0hfU1RSSU5HPXkKIyBDT05GSUdfTkVURklMVEVSX1hUX01BVENIX1RDUE1TUyBpcyBub3Qg
c2V0CkNPTkZJR19ORVRGSUxURVJfWFRfTUFUQ0hfVElNRT15CkNPTkZJR19ORVRGSUxURVJf
WFRfTUFUQ0hfVTMyPXkKIyBlbmQgb2YgQ29yZSBOZXRmaWx0ZXIgQ29uZmlndXJhdGlvbgoK
IyBDT05GSUdfSVBfU0VUIGlzIG5vdCBzZXQKIyBDT05GSUdfSVBfVlMgaXMgbm90IHNldAoK
IwojIElQOiBOZXRmaWx0ZXIgQ29uZmlndXJhdGlvbgojCkNPTkZJR19ORl9ERUZSQUdfSVBW
ND15CkNPTkZJR19ORl9TT0NLRVRfSVBWND15CkNPTkZJR19ORl9UUFJPWFlfSVBWND15CiMg
Q09ORklHX05GX0RVUF9JUFY0IGlzIG5vdCBzZXQKIyBDT05GSUdfTkZfTE9HX0FSUCBpcyBu
b3Qgc2V0CiMgQ09ORklHX05GX0xPR19JUFY0IGlzIG5vdCBzZXQKQ09ORklHX05GX1JFSkVD
VF9JUFY0PXkKQ09ORklHX05GX05BVF9QUFRQPXkKQ09ORklHX0lQX05GX0lQVEFCTEVTPXkK
IyBDT05GSUdfSVBfTkZfTUFUQ0hfQUggaXMgbm90IHNldAojIENPTkZJR19JUF9ORl9NQVRD
SF9FQ04gaXMgbm90IHNldAojIENPTkZJR19JUF9ORl9NQVRDSF9SUEZJTFRFUiBpcyBub3Qg
c2V0CiMgQ09ORklHX0lQX05GX01BVENIX1RUTCBpcyBub3Qgc2V0CkNPTkZJR19JUF9ORl9G
SUxURVI9eQpDT05GSUdfSVBfTkZfVEFSR0VUX1JFSkVDVD15CiMgQ09ORklHX0lQX05GX1RB
UkdFVF9TWU5QUk9YWSBpcyBub3Qgc2V0CkNPTkZJR19JUF9ORl9OQVQ9eQpDT05GSUdfSVBf
TkZfVEFSR0VUX01BU1FVRVJBREU9eQojIENPTkZJR19JUF9ORl9UQVJHRVRfTkVUTUFQIGlz
IG5vdCBzZXQKQ09ORklHX0lQX05GX1RBUkdFVF9SRURJUkVDVD15CkNPTkZJR19JUF9ORl9N
QU5HTEU9eQojIENPTkZJR19JUF9ORl9UQVJHRVRfQ0xVU1RFUklQIGlzIG5vdCBzZXQKIyBD
T05GSUdfSVBfTkZfVEFSR0VUX0VDTiBpcyBub3Qgc2V0CiMgQ09ORklHX0lQX05GX1RBUkdF
VF9UVEwgaXMgbm90IHNldApDT05GSUdfSVBfTkZfUkFXPXkKQ09ORklHX0lQX05GX1NFQ1VS
SVRZPXkKIyBDT05GSUdfSVBfTkZfQVJQVEFCTEVTIGlzIG5vdCBzZXQKIyBlbmQgb2YgSVA6
IE5ldGZpbHRlciBDb25maWd1cmF0aW9uCgojCiMgSVB2NjogTmV0ZmlsdGVyIENvbmZpZ3Vy
YXRpb24KIwpDT05GSUdfTkZfU09DS0VUX0lQVjY9eQpDT05GSUdfTkZfVFBST1hZX0lQVjY9
eQojIENPTkZJR19ORl9EVVBfSVBWNiBpcyBub3Qgc2V0CkNPTkZJR19ORl9SRUpFQ1RfSVBW
Nj15CiMgQ09ORklHX05GX0xPR19JUFY2IGlzIG5vdCBzZXQKQ09ORklHX0lQNl9ORl9JUFRB
QkxFUz15CiMgQ09ORklHX0lQNl9ORl9NQVRDSF9BSCBpcyBub3Qgc2V0CiMgQ09ORklHX0lQ
Nl9ORl9NQVRDSF9FVUk2NCBpcyBub3Qgc2V0CiMgQ09ORklHX0lQNl9ORl9NQVRDSF9GUkFH
IGlzIG5vdCBzZXQKIyBDT05GSUdfSVA2X05GX01BVENIX09QVFMgaXMgbm90IHNldAojIENP
TkZJR19JUDZfTkZfTUFUQ0hfSEwgaXMgbm90IHNldApDT05GSUdfSVA2X05GX01BVENIX0lQ
VjZIRUFERVI9eQojIENPTkZJR19JUDZfTkZfTUFUQ0hfTUggaXMgbm90IHNldApDT05GSUdf
SVA2X05GX01BVENIX1JQRklMVEVSPXkKIyBDT05GSUdfSVA2X05GX01BVENIX1JUIGlzIG5v
dCBzZXQKIyBDT05GSUdfSVA2X05GX01BVENIX1NSSCBpcyBub3Qgc2V0CiMgQ09ORklHX0lQ
Nl9ORl9UQVJHRVRfSEwgaXMgbm90IHNldApDT05GSUdfSVA2X05GX0ZJTFRFUj15CkNPTkZJ
R19JUDZfTkZfVEFSR0VUX1JFSkVDVD15CiMgQ09ORklHX0lQNl9ORl9UQVJHRVRfU1lOUFJP
WFkgaXMgbm90IHNldApDT05GSUdfSVA2X05GX01BTkdMRT15CkNPTkZJR19JUDZfTkZfUkFX
PXkKIyBDT05GSUdfSVA2X05GX1NFQ1VSSVRZIGlzIG5vdCBzZXQKQ09ORklHX0lQNl9ORl9O
QVQ9eQpDT05GSUdfSVA2X05GX1RBUkdFVF9NQVNRVUVSQURFPXkKIyBDT05GSUdfSVA2X05G
X1RBUkdFVF9OUFQgaXMgbm90IHNldAojIGVuZCBvZiBJUHY2OiBOZXRmaWx0ZXIgQ29uZmln
dXJhdGlvbgoKQ09ORklHX05GX0RFRlJBR19JUFY2PXkKIyBDT05GSUdfTkZfQ09OTlRSQUNL
X0JSSURHRSBpcyBub3Qgc2V0CiMgQ09ORklHX0JSSURHRV9ORl9FQlRBQkxFUyBpcyBub3Qg
c2V0CiMgQ09ORklHX0JQRklMVEVSIGlzIG5vdCBzZXQKIyBDT05GSUdfSVBfRENDUCBpcyBu
b3Qgc2V0CiMgQ09ORklHX0lQX1NDVFAgaXMgbm90IHNldAojIENPTkZJR19SRFMgaXMgbm90
IHNldAojIENPTkZJR19USVBDIGlzIG5vdCBzZXQKIyBDT05GSUdfQVRNIGlzIG5vdCBzZXQK
IyBDT05GSUdfTDJUUCBpcyBub3Qgc2V0CkNPTkZJR19TVFA9eQpDT05GSUdfQlJJREdFPXkK
Q09ORklHX0JSSURHRV9JR01QX1NOT09QSU5HPXkKIyBDT05GSUdfQlJJREdFX01SUCBpcyBu
b3Qgc2V0CkNPTkZJR19IQVZFX05FVF9EU0E9eQojIENPTkZJR19ORVRfRFNBIGlzIG5vdCBz
ZXQKIyBDT05GSUdfVkxBTl84MDIxUSBpcyBub3Qgc2V0CiMgQ09ORklHX0RFQ05FVCBpcyBu
b3Qgc2V0CkNPTkZJR19MTEM9eQojIENPTkZJR19MTEMyIGlzIG5vdCBzZXQKIyBDT05GSUdf
QVRBTEsgaXMgbm90IHNldAojIENPTkZJR19YMjUgaXMgbm90IHNldAojIENPTkZJR19MQVBC
IGlzIG5vdCBzZXQKIyBDT05GSUdfUEhPTkVUIGlzIG5vdCBzZXQKIyBDT05GSUdfNkxPV1BB
TiBpcyBub3Qgc2V0CiMgQ09ORklHX0lFRUU4MDIxNTQgaXMgbm90IHNldApDT05GSUdfTkVU
X1NDSEVEPXkKCiMKIyBRdWV1ZWluZy9TY2hlZHVsaW5nCiMKIyBDT05GSUdfTkVUX1NDSF9D
QlEgaXMgbm90IHNldApDT05GSUdfTkVUX1NDSF9IVEI9eQojIENPTkZJR19ORVRfU0NIX0hG
U0MgaXMgbm90IHNldAojIENPTkZJR19ORVRfU0NIX1BSSU8gaXMgbm90IHNldAojIENPTkZJ
R19ORVRfU0NIX01VTFRJUSBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9TQ0hfUkVEIGlzIG5v
dCBzZXQKIyBDT05GSUdfTkVUX1NDSF9TRkIgaXMgbm90IHNldAojIENPTkZJR19ORVRfU0NI
X1NGUSBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9TQ0hfVEVRTCBpcyBub3Qgc2V0CkNPTkZJ
R19ORVRfU0NIX1RCRj15CiMgQ09ORklHX05FVF9TQ0hfQ0JTIGlzIG5vdCBzZXQKIyBDT05G
SUdfTkVUX1NDSF9FVEYgaXMgbm90IHNldAojIENPTkZJR19ORVRfU0NIX1RBUFJJTyBpcyBu
b3Qgc2V0CiMgQ09ORklHX05FVF9TQ0hfR1JFRCBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9T
Q0hfRFNNQVJLIGlzIG5vdCBzZXQKQ09ORklHX05FVF9TQ0hfTkVURU09eQojIENPTkZJR19O
RVRfU0NIX0RSUiBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9TQ0hfTVFQUklPIGlzIG5vdCBz
ZXQKIyBDT05GSUdfTkVUX1NDSF9TS0JQUklPIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX1ND
SF9DSE9LRSBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9TQ0hfUUZRIGlzIG5vdCBzZXQKQ09O
RklHX05FVF9TQ0hfQ09ERUw9eQpDT05GSUdfTkVUX1NDSF9GUV9DT0RFTD15CiMgQ09ORklH
X05FVF9TQ0hfQ0FLRSBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9TQ0hfRlEgaXMgbm90IHNl
dAojIENPTkZJR19ORVRfU0NIX0hIRiBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9TQ0hfUElF
IGlzIG5vdCBzZXQKQ09ORklHX05FVF9TQ0hfSU5HUkVTUz15CiMgQ09ORklHX05FVF9TQ0hf
UExVRyBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9TQ0hfRVRTIGlzIG5vdCBzZXQKIyBDT05G
SUdfTkVUX1NDSF9ERUZBVUxUIGlzIG5vdCBzZXQKCiMKIyBDbGFzc2lmaWNhdGlvbgojCkNP
TkZJR19ORVRfQ0xTPXkKIyBDT05GSUdfTkVUX0NMU19CQVNJQyBpcyBub3Qgc2V0CiMgQ09O
RklHX05FVF9DTFNfUk9VVEU0IGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX0NMU19GVyBpcyBu
b3Qgc2V0CkNPTkZJR19ORVRfQ0xTX1UzMj15CiMgQ09ORklHX0NMU19VMzJfUEVSRiBpcyBu
b3Qgc2V0CkNPTkZJR19DTFNfVTMyX01BUks9eQojIENPTkZJR19ORVRfQ0xTX1JTVlAgaXMg
bm90IHNldAojIENPTkZJR19ORVRfQ0xTX1JTVlA2IGlzIG5vdCBzZXQKIyBDT05GSUdfTkVU
X0NMU19GTE9XIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX0NMU19DR1JPVVAgaXMgbm90IHNl
dAojIENPTkZJR19ORVRfQ0xTX0JQRiBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9DTFNfRkxP
V0VSIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX0NMU19NQVRDSEFMTCBpcyBub3Qgc2V0CiMg
Q09ORklHX05FVF9FTUFUQ0ggaXMgbm90IHNldApDT05GSUdfTkVUX0NMU19BQ1Q9eQpDT05G
SUdfTkVUX0FDVF9QT0xJQ0U9eQpDT05GSUdfTkVUX0FDVF9HQUNUPXkKIyBDT05GSUdfR0FD
VF9QUk9CIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX0FDVF9NSVJSRUQgaXMgbm90IHNldAoj
IENPTkZJR19ORVRfQUNUX1NBTVBMRSBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9BQ1RfSVBU
IGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX0FDVF9OQVQgaXMgbm90IHNldAojIENPTkZJR19O
RVRfQUNUX1BFRElUIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX0FDVF9TSU1QIGlzIG5vdCBz
ZXQKIyBDT05GSUdfTkVUX0FDVF9TS0JFRElUIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX0FD
VF9DU1VNIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX0FDVF9NUExTIGlzIG5vdCBzZXQKIyBD
T05GSUdfTkVUX0FDVF9WTEFOIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX0FDVF9CUEYgaXMg
bm90IHNldAojIENPTkZJR19ORVRfQUNUX0NPTk5NQVJLIGlzIG5vdCBzZXQKIyBDT05GSUdf
TkVUX0FDVF9DVElORk8gaXMgbm90IHNldAojIENPTkZJR19ORVRfQUNUX1NLQk1PRCBpcyBu
b3Qgc2V0CiMgQ09ORklHX05FVF9BQ1RfSUZFIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX0FD
VF9UVU5ORUxfS0VZIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX0FDVF9HQVRFIGlzIG5vdCBz
ZXQKIyBDT05GSUdfTkVUX1RDX1NLQl9FWFQgaXMgbm90IHNldApDT05GSUdfTkVUX1NDSF9G
SUZPPXkKIyBDT05GSUdfRENCIGlzIG5vdCBzZXQKQ09ORklHX0ROU19SRVNPTFZFUj15CiMg
Q09ORklHX0JBVE1BTl9BRFYgaXMgbm90IHNldAojIENPTkZJR19PUEVOVlNXSVRDSCBpcyBu
b3Qgc2V0CkNPTkZJR19WU09DS0VUUz15CiMgQ09ORklHX1ZTT0NLRVRTX0RJQUcgaXMgbm90
IHNldAojIENPTkZJR19WU09DS0VUU19MT09QQkFDSyBpcyBub3Qgc2V0CiMgQ09ORklHX1ZJ
UlRJT19WU09DS0VUUyBpcyBub3Qgc2V0CkNPTkZJR19WSVJUSU9fVlNPQ0tFVFNfQ09NTU9O
PXkKIyBDT05GSUdfTkVUTElOS19ESUFHIGlzIG5vdCBzZXQKIyBDT05GSUdfTVBMUyBpcyBu
b3Qgc2V0CiMgQ09ORklHX05FVF9OU0ggaXMgbm90IHNldAojIENPTkZJR19IU1IgaXMgbm90
IHNldAojIENPTkZJR19ORVRfU1dJVENIREVWIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX0wz
X01BU1RFUl9ERVYgaXMgbm90IHNldAojIENPTkZJR19RUlRSIGlzIG5vdCBzZXQKIyBDT05G
SUdfTkVUX05DU0kgaXMgbm90IHNldApDT05GSUdfUlBTPXkKQ09ORklHX1JGU19BQ0NFTD15
CkNPTkZJR19YUFM9eQojIENPTkZJR19DR1JPVVBfTkVUX1BSSU8gaXMgbm90IHNldApDT05G
SUdfQ0dST1VQX05FVF9DTEFTU0lEPXkKQ09ORklHX05FVF9SWF9CVVNZX1BPTEw9eQpDT05G
SUdfQlFMPXkKQ09ORklHX0JQRl9KSVQ9eQojIENPTkZJR19CUEZfU1RSRUFNX1BBUlNFUiBp
cyBub3Qgc2V0CkNPTkZJR19ORVRfRkxPV19MSU1JVD15CgojCiMgTmV0d29yayB0ZXN0aW5n
CiMKIyBDT05GSUdfTkVUX1BLVEdFTiBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9EUk9QX01P
TklUT1IgaXMgbm90IHNldAojIGVuZCBvZiBOZXR3b3JrIHRlc3RpbmcKIyBlbmQgb2YgTmV0
d29ya2luZyBvcHRpb25zCgojIENPTkZJR19IQU1SQURJTyBpcyBub3Qgc2V0CiMgQ09ORklH
X0NBTiBpcyBub3Qgc2V0CkNPTkZJR19CVD15CkNPTkZJR19CVF9CUkVEUj15CkNPTkZJR19C
VF9SRkNPTU09eQojIENPTkZJR19CVF9SRkNPTU1fVFRZIGlzIG5vdCBzZXQKIyBDT05GSUdf
QlRfQk5FUCBpcyBub3Qgc2V0CkNPTkZJR19CVF9ISURQPXkKIyBDT05GSUdfQlRfSFMgaXMg
bm90IHNldApDT05GSUdfQlRfTEU9eQojIENPTkZJR19CVF9MRURTIGlzIG5vdCBzZXQKQ09O
RklHX0JUX01TRlRFWFQ9eQpDT05GSUdfQlRfREVCVUdGUz15CiMgQ09ORklHX0JUX0FPU1BF
WFQgaXMgbm90IHNldAojIENPTkZJR19CVF9TRUxGVEVTVCBpcyBub3Qgc2V0CgojCiMgQmx1
ZXRvb3RoIGRldmljZSBkcml2ZXJzCiMKQ09ORklHX0JUX0lOVEVMPXkKQ09ORklHX0JUX0JD
TT15CkNPTkZJR19CVF9SVEw9eQpDT05GSUdfQlRfSENJQlRVU0I9eQpDT05GSUdfQlRfSENJ
QlRVU0JfQVVUT1NVU1BFTkQ9eQpDT05GSUdfQlRfSENJQlRVU0JfSU5URVJWQUw9eQpDT05G
SUdfQlRfSENJQlRVU0JfQkNNPXkKIyBDT05GSUdfQlRfSENJQlRVU0JfTVRLIGlzIG5vdCBz
ZXQKQ09ORklHX0JUX0hDSUJUVVNCX1JUTD15CiMgQ09ORklHX0JUX0hDSUJUU0RJTyBpcyBu
b3Qgc2V0CiMgQ09ORklHX0JUX0hDSVVBUlQgaXMgbm90IHNldApDT05GSUdfQlRfSENJQkNN
MjAzWD15CiMgQ09ORklHX0JUX0hDSUJQQTEwWCBpcyBub3Qgc2V0CkNPTkZJR19CVF9IQ0lC
RlVTQj15CkNPTkZJR19CVF9IQ0lWSENJPXkKIyBDT05GSUdfQlRfTVJWTCBpcyBub3Qgc2V0
CkNPTkZJR19CVF9BVEgzSz15CiMgQ09ORklHX0JUX01US1NESU8gaXMgbm90IHNldAojIGVu
ZCBvZiBCbHVldG9vdGggZGV2aWNlIGRyaXZlcnMKCiMgQ09ORklHX0FGX1JYUlBDIGlzIG5v
dCBzZXQKIyBDT05GSUdfQUZfS0NNIGlzIG5vdCBzZXQKQ09ORklHX0ZJQl9SVUxFUz15CkNP
TkZJR19XSVJFTEVTUz15CkNPTkZJR19XRVhUX0NPUkU9eQpDT05GSUdfV0VYVF9QUk9DPXkK
Q09ORklHX0NGRzgwMjExPXkKQ09ORklHX05MODAyMTFfVEVTVE1PREU9eQojIENPTkZJR19D
Rkc4MDIxMV9ERVZFTE9QRVJfV0FSTklOR1MgaXMgbm90IHNldApDT05GSUdfQ0ZHODAyMTFf
Q0VSVElGSUNBVElPTl9PTlVTPXkKIyBDT05GSUdfQ0ZHODAyMTFfUkVRVUlSRV9TSUdORURf
UkVHREIgaXMgbm90IHNldAojIENPTkZJR19DRkc4MDIxMV9SRUdfQ0VMTFVMQVJfSElOVFMg
aXMgbm90IHNldAojIENPTkZJR19DRkc4MDIxMV9SRUdfUkVMQVhfTk9fSVIgaXMgbm90IHNl
dApDT05GSUdfQ0ZHODAyMTFfREVGQVVMVF9QUz15CkNPTkZJR19DRkc4MDIxMV9ERUJVR0ZT
PXkKQ09ORklHX0NGRzgwMjExX0NSREFfU1VQUE9SVD15CkNPTkZJR19DRkc4MDIxMV9XRVhU
PXkKQ09ORklHX01BQzgwMjExPXkKQ09ORklHX01BQzgwMjExX0hBU19SQz15CkNPTkZJR19N
QUM4MDIxMV9SQ19NSU5TVFJFTD15CkNPTkZJR19NQUM4MDIxMV9SQ19ERUZBVUxUX01JTlNU
UkVMPXkKQ09ORklHX01BQzgwMjExX1JDX0RFRkFVTFQ9Im1pbnN0cmVsX2h0IgojIENPTkZJ
R19NQUM4MDIxMV9NRVNIIGlzIG5vdCBzZXQKQ09ORklHX01BQzgwMjExX0xFRFM9eQpDT05G
SUdfTUFDODAyMTFfREVCVUdGUz15CiMgQ09ORklHX01BQzgwMjExX01FU1NBR0VfVFJBQ0lO
RyBpcyBub3Qgc2V0CkNPTkZJR19NQUM4MDIxMV9ERUJVR19NRU5VPXkKIyBDT05GSUdfTUFD
ODAyMTFfTk9JTkxJTkUgaXMgbm90IHNldApDT05GSUdfTUFDODAyMTFfVkVSQk9TRV9ERUJV
Rz15CiMgQ09ORklHX01BQzgwMjExX01MTUVfREVCVUcgaXMgbm90IHNldAojIENPTkZJR19N
QUM4MDIxMV9TVEFfREVCVUcgaXMgbm90IHNldAojIENPTkZJR19NQUM4MDIxMV9IVF9ERUJV
RyBpcyBub3Qgc2V0CiMgQ09ORklHX01BQzgwMjExX09DQl9ERUJVRyBpcyBub3Qgc2V0CiMg
Q09ORklHX01BQzgwMjExX0lCU1NfREVCVUcgaXMgbm90IHNldAojIENPTkZJR19NQUM4MDIx
MV9QU19ERUJVRyBpcyBub3Qgc2V0CiMgQ09ORklHX01BQzgwMjExX1RETFNfREVCVUcgaXMg
bm90IHNldAojIENPTkZJR19NQUM4MDIxMV9ERUJVR19DT1VOVEVSUyBpcyBub3Qgc2V0CkNP
TkZJR19NQUM4MDIxMV9TVEFfSEFTSF9NQVhfU0laRT0wCiMgQ09ORklHX1dJTUFYIGlzIG5v
dCBzZXQKQ09ORklHX1JGS0lMTD15CkNPTkZJR19SRktJTExfTEVEUz15CiMgQ09ORklHX1JG
S0lMTF9JTlBVVCBpcyBub3Qgc2V0CiMgQ09ORklHX1JGS0lMTF9HUElPIGlzIG5vdCBzZXQK
Q09ORklHX05FVF85UD15CkNPTkZJR19ORVRfOVBfVklSVElPPXkKIyBDT05GSUdfTkVUXzlQ
X0RFQlVHIGlzIG5vdCBzZXQKIyBDT05GSUdfQ0FJRiBpcyBub3Qgc2V0CiMgQ09ORklHX0NF
UEhfTElCIGlzIG5vdCBzZXQKIyBDT05GSUdfTkZDIGlzIG5vdCBzZXQKIyBDT05GSUdfUFNB
TVBMRSBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9JRkUgaXMgbm90IHNldAojIENPTkZJR19M
V1RVTk5FTCBpcyBub3Qgc2V0CkNPTkZJR19EU1RfQ0FDSEU9eQpDT05GSUdfR1JPX0NFTExT
PXkKQ09ORklHX0ZBSUxPVkVSPXkKQ09ORklHX0VUSFRPT0xfTkVUTElOSz15CkNPTkZJR19I
QVZFX0VCUEZfSklUPXkKCiMKIyBEZXZpY2UgRHJpdmVycwojCkNPTkZJR19IQVZFX0VJU0E9
eQojIENPTkZJR19FSVNBIGlzIG5vdCBzZXQKQ09ORklHX0hBVkVfUENJPXkKQ09ORklHX1BD
ST15CkNPTkZJR19QQ0lfRE9NQUlOUz15CkNPTkZJR19QQ0lFUE9SVEJVUz15CkNPTkZJR19I
T1RQTFVHX1BDSV9QQ0lFPXkKQ09ORklHX1BDSUVBRVI9eQojIENPTkZJR19QQ0lFQUVSX0lO
SkVDVCBpcyBub3Qgc2V0CiMgQ09ORklHX1BDSUVfRUNSQyBpcyBub3Qgc2V0CkNPTkZJR19Q
Q0lFQVNQTT15CkNPTkZJR19QQ0lFQVNQTV9ERUZBVUxUPXkKIyBDT05GSUdfUENJRUFTUE1f
UE9XRVJTQVZFIGlzIG5vdCBzZXQKIyBDT05GSUdfUENJRUFTUE1fUE9XRVJfU1VQRVJTQVZF
IGlzIG5vdCBzZXQKIyBDT05GSUdfUENJRUFTUE1fUEVSRk9STUFOQ0UgaXMgbm90IHNldApD
T05GSUdfUENJRV9QTUU9eQojIENPTkZJR19QQ0lFX0RQQyBpcyBub3Qgc2V0CiMgQ09ORklH
X1BDSUVfUFRNIGlzIG5vdCBzZXQKQ09ORklHX1BDSV9NU0k9eQpDT05GSUdfUENJX01TSV9J
UlFfRE9NQUlOPXkKQ09ORklHX1BDSV9RVUlSS1M9eQojIENPTkZJR19QQ0lfREVCVUcgaXMg
bm90IHNldAojIENPTkZJR19QQ0lfU1RVQiBpcyBub3Qgc2V0CkNPTkZJR19QQ0lfRUNBTT15
CkNPTkZJR19QQ0lfTE9DS0xFU1NfQ09ORklHPXkKIyBDT05GSUdfUENJX0lPViBpcyBub3Qg
c2V0CiMgQ09ORklHX1BDSV9QUkkgaXMgbm90IHNldAojIENPTkZJR19QQ0lfUEFTSUQgaXMg
bm90IHNldApDT05GSUdfUENJX0xBQkVMPXkKIyBDT05GSUdfUENJRV9CVVNfVFVORV9PRkYg
aXMgbm90IHNldApDT05GSUdfUENJRV9CVVNfREVGQVVMVD15CiMgQ09ORklHX1BDSUVfQlVT
X1NBRkUgaXMgbm90IHNldAojIENPTkZJR19QQ0lFX0JVU19QRVJGT1JNQU5DRSBpcyBub3Qg
c2V0CiMgQ09ORklHX1BDSUVfQlVTX1BFRVIyUEVFUiBpcyBub3Qgc2V0CkNPTkZJR19IT1RQ
TFVHX1BDST15CkNPTkZJR19IT1RQTFVHX1BDSV9BQ1BJPXkKIyBDT05GSUdfSE9UUExVR19Q
Q0lfQUNQSV9JQk0gaXMgbm90IHNldAojIENPTkZJR19IT1RQTFVHX1BDSV9DUENJIGlzIG5v
dCBzZXQKIyBDT05GSUdfSE9UUExVR19QQ0lfU0hQQyBpcyBub3Qgc2V0CgojCiMgUENJIGNv
bnRyb2xsZXIgZHJpdmVycwojCiMgQ09ORklHX1BDSV9GVFBDSTEwMCBpcyBub3Qgc2V0CkNP
TkZJR19QQ0lfSE9TVF9DT01NT049eQpDT05GSUdfUENJX0hPU1RfR0VORVJJQz15CiMgQ09O
RklHX1BDSUVfWElMSU5YIGlzIG5vdCBzZXQKIyBDT05GSUdfVk1EIGlzIG5vdCBzZXQKIyBD
T05GSUdfUENJRV9NSUNST0NISVBfSE9TVCBpcyBub3Qgc2V0CgojCiMgRGVzaWduV2FyZSBQ
Q0kgQ29yZSBTdXBwb3J0CiMKIyBDT05GSUdfUENJRV9EV19QTEFUX0hPU1QgaXMgbm90IHNl
dAojIENPTkZJR19QQ0lFX0lOVEVMX0dXIGlzIG5vdCBzZXQKIyBDT05GSUdfUENJX01FU09O
IGlzIG5vdCBzZXQKIyBlbmQgb2YgRGVzaWduV2FyZSBQQ0kgQ29yZSBTdXBwb3J0CgojCiMg
TW9iaXZlaWwgUENJZSBDb3JlIFN1cHBvcnQKIwojIGVuZCBvZiBNb2JpdmVpbCBQQ0llIENv
cmUgU3VwcG9ydAoKIwojIENhZGVuY2UgUENJZSBjb250cm9sbGVycyBzdXBwb3J0CiMKIyBD
T05GSUdfUENJRV9DQURFTkNFX1BMQVRfSE9TVCBpcyBub3Qgc2V0CiMgQ09ORklHX1BDSV9K
NzIxRV9IT1NUIGlzIG5vdCBzZXQKIyBlbmQgb2YgQ2FkZW5jZSBQQ0llIGNvbnRyb2xsZXJz
IHN1cHBvcnQKIyBlbmQgb2YgUENJIGNvbnRyb2xsZXIgZHJpdmVycwoKIwojIFBDSSBFbmRw
b2ludAojCiMgQ09ORklHX1BDSV9FTkRQT0lOVCBpcyBub3Qgc2V0CiMgZW5kIG9mIFBDSSBF
bmRwb2ludAoKIwojIFBDSSBzd2l0Y2ggY29udHJvbGxlciBkcml2ZXJzCiMKIyBDT05GSUdf
UENJX1NXX1NXSVRDSFRFQyBpcyBub3Qgc2V0CiMgZW5kIG9mIFBDSSBzd2l0Y2ggY29udHJv
bGxlciBkcml2ZXJzCgojIENPTkZJR19QQ0NBUkQgaXMgbm90IHNldAojIENPTkZJR19SQVBJ
RElPIGlzIG5vdCBzZXQKCiMKIyBHZW5lcmljIERyaXZlciBPcHRpb25zCiMKQ09ORklHX0FV
WElMSUFSWV9CVVM9eQpDT05GSUdfVUVWRU5UX0hFTFBFUj15CkNPTkZJR19VRVZFTlRfSEVM
UEVSX1BBVEg9Ii9zYmluL2hvdHBsdWciCkNPTkZJR19ERVZUTVBGUz15CkNPTkZJR19ERVZU
TVBGU19NT1VOVD15CkNPTkZJR19ERVZUTVBGU19TQUZFPXkKQ09ORklHX1NUQU5EQUxPTkU9
eQpDT05GSUdfUFJFVkVOVF9GSVJNV0FSRV9CVUlMRD15CgojCiMgRmlybXdhcmUgbG9hZGVy
CiMKQ09ORklHX0ZXX0xPQURFUj15CkNPTkZJR19FWFRSQV9GSVJNV0FSRT0iIgojIENPTkZJ
R19GV19MT0FERVJfVVNFUl9IRUxQRVIgaXMgbm90IHNldAojIENPTkZJR19GV19MT0FERVJf
Q09NUFJFU1MgaXMgbm90IHNldApDT05GSUdfRldfQ0FDSEU9eQojIGVuZCBvZiBGaXJtd2Fy
ZSBsb2FkZXIKCkNPTkZJR19XQU5UX0RFVl9DT1JFRFVNUD15CkNPTkZJR19BTExPV19ERVZf
Q09SRURVTVA9eQpDT05GSUdfREVWX0NPUkVEVU1QPXkKIyBDT05GSUdfREVCVUdfRFJJVkVS
IGlzIG5vdCBzZXQKQ09ORklHX0RFQlVHX0RFVlJFUz15CiMgQ09ORklHX0RFQlVHX1RFU1Rf
RFJJVkVSX1JFTU9WRSBpcyBub3Qgc2V0CiMgQ09ORklHX1RFU1RfQVNZTkNfRFJJVkVSX1BS
T0JFIGlzIG5vdCBzZXQKQ09ORklHX0dFTkVSSUNfQ1BVX0FVVE9QUk9CRT15CkNPTkZJR19H
RU5FUklDX0NQVV9WVUxORVJBQklMSVRJRVM9eQpDT05GSUdfUkVHTUFQPXkKQ09ORklHX1JF
R01BUF9JMkM9eQpDT05GSUdfUkVHTUFQX1NQST15CkNPTkZJR19ETUFfU0hBUkVEX0JVRkZF
Uj15CiMgQ09ORklHX0RNQV9GRU5DRV9UUkFDRSBpcyBub3Qgc2V0CiMgZW5kIG9mIEdlbmVy
aWMgRHJpdmVyIE9wdGlvbnMKCiMKIyBCdXMgZGV2aWNlcwojCiMgQ09ORklHX01PWFRFVCBp
cyBub3Qgc2V0CiMgQ09ORklHX1NJTVBMRV9QTV9CVVMgaXMgbm90IHNldAojIENPTkZJR19N
SElfQlVTIGlzIG5vdCBzZXQKIyBlbmQgb2YgQnVzIGRldmljZXMKCkNPTkZJR19DT05ORUNU
T1I9eQpDT05GSUdfUFJPQ19FVkVOVFM9eQoKIwojIEZpcm13YXJlIERyaXZlcnMKIwojIENP
TkZJR19FREQgaXMgbm90IHNldApDT05GSUdfRklSTVdBUkVfTUVNTUFQPXkKQ09ORklHX0RN
SUlEPXkKQ09ORklHX0RNSV9TWVNGUz15CkNPTkZJR19ETUlfU0NBTl9NQUNISU5FX05PTl9F
RklfRkFMTEJBQ0s9eQojIENPTkZJR19JU0NTSV9JQkZUIGlzIG5vdCBzZXQKIyBDT05GSUdf
RldfQ0ZHX1NZU0ZTIGlzIG5vdCBzZXQKQ09ORklHX0dPT0dMRV9GSVJNV0FSRT15CkNPTkZJ
R19HT09HTEVfU01JPXkKQ09ORklHX0dPT0dMRV9DT1JFQk9PVF9UQUJMRT15CkNPTkZJR19H
T09HTEVfTUVNQ09OU09MRT15CiMgQ09ORklHX0dPT0dMRV9NRU1DT05TT0xFX1g4Nl9MRUdB
Q1kgaXMgbm90IHNldApDT05GSUdfR09PR0xFX01FTUNPTlNPTEVfQ09SRUJPT1Q9eQpDT05G
SUdfR09PR0xFX1ZQRD15CkNPTkZJR19VRUZJX0NQRVI9eQpDT05GSUdfVUVGSV9DUEVSX1g4
Nj15CgojCiMgVGVncmEgZmlybXdhcmUgZHJpdmVyCiMKIyBlbmQgb2YgVGVncmEgZmlybXdh
cmUgZHJpdmVyCiMgZW5kIG9mIEZpcm13YXJlIERyaXZlcnMKCiMgQ09ORklHX0dOU1MgaXMg
bm90IHNldAojIENPTkZJR19NVEQgaXMgbm90IHNldApDT05GSUdfT0Y9eQojIENPTkZJR19P
Rl9VTklUVEVTVCBpcyBub3Qgc2V0CkNPTkZJR19PRl9LT0JKPXkKQ09ORklHX09GX0FERFJF
U1M9eQpDT05GSUdfT0ZfSVJRPXkKQ09ORklHX09GX05FVD15CiMgQ09ORklHX09GX09WRVJM
QVkgaXMgbm90IHNldApDT05GSUdfQVJDSF9NSUdIVF9IQVZFX1BDX1BBUlBPUlQ9eQojIENP
TkZJR19QQVJQT1JUIGlzIG5vdCBzZXQKQ09ORklHX1BOUD15CkNPTkZJR19QTlBfREVCVUdf
TUVTU0FHRVM9eQoKIwojIFByb3RvY29scwojCkNPTkZJR19QTlBBQ1BJPXkKQ09ORklHX0JM
S19ERVY9eQojIENPTkZJR19CTEtfREVWX05VTExfQkxLIGlzIG5vdCBzZXQKIyBDT05GSUdf
QkxLX0RFVl9GRCBpcyBub3Qgc2V0CkNPTkZJR19DRFJPTT15CiMgQ09ORklHX0JMS19ERVZf
UENJRVNTRF9NVElQMzJYWCBpcyBub3Qgc2V0CkNPTkZJR19aUkFNPXkKIyBDT05GSUdfWlJB
TV9XUklURUJBQ0sgaXMgbm90IHNldAojIENPTkZJR19aUkFNX01FTU9SWV9UUkFDS0lORyBp
cyBub3Qgc2V0CiMgQ09ORklHX0JMS19ERVZfVU1FTSBpcyBub3Qgc2V0CkNPTkZJR19CTEtf
REVWX0xPT1A9eQpDT05GSUdfQkxLX0RFVl9MT09QX01JTl9DT1VOVD04CiMgQ09ORklHX0JM
S19ERVZfQ1JZUFRPTE9PUCBpcyBub3Qgc2V0CiMgQ09ORklHX0JMS19ERVZfRFJCRCBpcyBu
b3Qgc2V0CiMgQ09ORklHX0JMS19ERVZfTkJEIGlzIG5vdCBzZXQKIyBDT05GSUdfQkxLX0RF
Vl9TS0QgaXMgbm90IHNldAojIENPTkZJR19CTEtfREVWX1JBTSBpcyBub3Qgc2V0CiMgQ09O
RklHX0NEUk9NX1BLVENEVkQgaXMgbm90IHNldAojIENPTkZJR19BVEFfT1ZFUl9FVEggaXMg
bm90IHNldApDT05GSUdfVklSVElPX0JMSz15CiMgQ09ORklHX0JMS19ERVZfUkJEIGlzIG5v
dCBzZXQKIyBDT05GSUdfQkxLX0RFVl9SU1hYIGlzIG5vdCBzZXQKCiMKIyBOVk1FIFN1cHBv
cnQKIwpDT05GSUdfTlZNRV9DT1JFPXkKQ09ORklHX0JMS19ERVZfTlZNRT15CiMgQ09ORklH
X05WTUVfTVVMVElQQVRIIGlzIG5vdCBzZXQKIyBDT05GSUdfTlZNRV9IV01PTiBpcyBub3Qg
c2V0CiMgQ09ORklHX05WTUVfRkMgaXMgbm90IHNldAojIENPTkZJR19OVk1FX1RDUCBpcyBu
b3Qgc2V0CiMgQ09ORklHX05WTUVfVEFSR0VUIGlzIG5vdCBzZXQKIyBlbmQgb2YgTlZNRSBT
dXBwb3J0CgojCiMgTWlzYyBkZXZpY2VzCiMKIyBDT05GSUdfQUQ1MjVYX0RQT1QgaXMgbm90
IHNldAojIENPTkZJR19EVU1NWV9JUlEgaXMgbm90IHNldAojIENPTkZJR19JQk1fQVNNIGlz
IG5vdCBzZXQKIyBDT05GSUdfUEhBTlRPTSBpcyBub3Qgc2V0CiMgQ09ORklHX1RJRk1fQ09S
RSBpcyBub3Qgc2V0CiMgQ09ORklHX0lDUzkzMlM0MDEgaXMgbm90IHNldAojIENPTkZJR19F
TkNMT1NVUkVfU0VSVklDRVMgaXMgbm90IHNldAojIENPTkZJR19IUF9JTE8gaXMgbm90IHNl
dAojIENPTkZJR19BUERTOTgwMkFMUyBpcyBub3Qgc2V0CiMgQ09ORklHX0lTTDI5MDAzIGlz
IG5vdCBzZXQKIyBDT05GSUdfSVNMMjkwMjAgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JT
X1RTTDI1NTAgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX0JIMTc3MCBpcyBub3Qgc2V0
CiMgQ09ORklHX1NFTlNPUlNfQVBEUzk5MFggaXMgbm90IHNldAojIENPTkZJR19ITUM2MzUy
IGlzIG5vdCBzZXQKIyBDT05GSUdfRFMxNjgyIGlzIG5vdCBzZXQKIyBDT05GSUdfTEFUVElD
RV9FQ1AzX0NPTkZJRyBpcyBub3Qgc2V0CiMgQ09ORklHX1NSQU0gaXMgbm90IHNldAojIENP
TkZJR19QQ0lfRU5EUE9JTlRfVEVTVCBpcyBub3Qgc2V0CiMgQ09ORklHX1hJTElOWF9TREZF
QyBpcyBub3Qgc2V0CkNPTkZJR19VSURfU1lTX1NUQVRTPXkKIyBDT05GSUdfVUlEX1NZU19T
VEFUU19ERUJVRyBpcyBub3Qgc2V0CiMgQ09ORklHX0MyUE9SVCBpcyBub3Qgc2V0CgojCiMg
RUVQUk9NIHN1cHBvcnQKIwojIENPTkZJR19FRVBST01fQVQyNCBpcyBub3Qgc2V0CiMgQ09O
RklHX0VFUFJPTV9BVDI1IGlzIG5vdCBzZXQKIyBDT05GSUdfRUVQUk9NX0xFR0FDWSBpcyBu
b3Qgc2V0CiMgQ09ORklHX0VFUFJPTV9NQVg2ODc1IGlzIG5vdCBzZXQKQ09ORklHX0VFUFJP
TV85M0NYNj15CiMgQ09ORklHX0VFUFJPTV85M1hYNDYgaXMgbm90IHNldAojIENPTkZJR19F
RVBST01fSURUXzg5SFBFU1ggaXMgbm90IHNldAojIENPTkZJR19FRVBST01fRUUxMDA0IGlz
IG5vdCBzZXQKIyBlbmQgb2YgRUVQUk9NIHN1cHBvcnQKCiMgQ09ORklHX0NCNzEwX0NPUkUg
aXMgbm90IHNldAoKIwojIFRleGFzIEluc3RydW1lbnRzIHNoYXJlZCB0cmFuc3BvcnQgbGlu
ZSBkaXNjaXBsaW5lCiMKIyBDT05GSUdfVElfU1QgaXMgbm90IHNldAojIGVuZCBvZiBUZXhh
cyBJbnN0cnVtZW50cyBzaGFyZWQgdHJhbnNwb3J0IGxpbmUgZGlzY2lwbGluZQoKIyBDT05G
SUdfU0VOU09SU19MSVMzX0kyQyBpcyBub3Qgc2V0CiMgQ09ORklHX0FMVEVSQV9TVEFQTCBp
cyBub3Qgc2V0CiMgQ09ORklHX0lOVEVMX01FSSBpcyBub3Qgc2V0CiMgQ09ORklHX0lOVEVM
X01FSV9NRSBpcyBub3Qgc2V0CiMgQ09ORklHX0lOVEVMX01FSV9UWEUgaXMgbm90IHNldAoj
IENPTkZJR19JTlRFTF9NRUlfSERDUCBpcyBub3Qgc2V0CiMgQ09ORklHX0lOVEVMX01FSV9Q
WFAgaXMgbm90IHNldAojIENPTkZJR19WTVdBUkVfVk1DSSBpcyBub3Qgc2V0CiMgQ09ORklH
X0dFTldRRSBpcyBub3Qgc2V0CiMgQ09ORklHX0VDSE8gaXMgbm90IHNldAojIENPTkZJR19N
SVNDX0FMQ09SX1BDSSBpcyBub3Qgc2V0CiMgQ09ORklHX01JU0NfUlRTWF9QQ0kgaXMgbm90
IHNldAojIENPTkZJR19NSVNDX1JUU1hfVVNCIGlzIG5vdCBzZXQKIyBDT05GSUdfSEFCQU5B
X0FJIGlzIG5vdCBzZXQKIyBDT05GSUdfVUFDQ0UgaXMgbm90IHNldAojIENPTkZJR19QVlBB
TklDIGlzIG5vdCBzZXQKIyBlbmQgb2YgTWlzYyBkZXZpY2VzCgpDT05GSUdfSEFWRV9JREU9
eQojIENPTkZJR19JREUgaXMgbm90IHNldAoKIwojIFNDU0kgZGV2aWNlIHN1cHBvcnQKIwpD
T05GSUdfU0NTSV9NT0Q9eQojIENPTkZJR19SQUlEX0FUVFJTIGlzIG5vdCBzZXQKQ09ORklH
X1NDU0k9eQpDT05GSUdfU0NTSV9ETUE9eQpDT05GSUdfU0NTSV9QUk9DX0ZTPXkKCiMKIyBT
Q1NJIHN1cHBvcnQgdHlwZSAoZGlzaywgdGFwZSwgQ0QtUk9NKQojCkNPTkZJR19CTEtfREVW
X1NEPXkKIyBDT05GSUdfQ0hSX0RFVl9TVCBpcyBub3Qgc2V0CkNPTkZJR19CTEtfREVWX1NS
PXkKIyBDT05GSUdfQ0hSX0RFVl9TRyBpcyBub3Qgc2V0CiMgQ09ORklHX0NIUl9ERVZfU0NI
IGlzIG5vdCBzZXQKQ09ORklHX1NDU0lfQ09OU1RBTlRTPXkKIyBDT05GSUdfU0NTSV9MT0dH
SU5HIGlzIG5vdCBzZXQKQ09ORklHX1NDU0lfU0NBTl9BU1lOQz15CgojCiMgU0NTSSBUcmFu
c3BvcnRzCiMKQ09ORklHX1NDU0lfU1BJX0FUVFJTPXkKIyBDT05GSUdfU0NTSV9GQ19BVFRS
UyBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfSVNDU0lfQVRUUlMgaXMgbm90IHNldAojIENP
TkZJR19TQ1NJX1NBU19BVFRSUyBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfU0FTX0xJQlNB
UyBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfU1JQX0FUVFJTIGlzIG5vdCBzZXQKIyBlbmQg
b2YgU0NTSSBUcmFuc3BvcnRzCgpDT05GSUdfU0NTSV9MT1dMRVZFTD15CiMgQ09ORklHX0lT
Q1NJX1RDUCBpcyBub3Qgc2V0CiMgQ09ORklHX0lTQ1NJX0JPT1RfU1lTRlMgaXMgbm90IHNl
dAojIENPTkZJR19TQ1NJX0NYR0IzX0lTQ1NJIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9D
WEdCNF9JU0NTSSBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfQk5YMl9JU0NTSSBpcyBub3Qg
c2V0CiMgQ09ORklHX0JFMklTQ1NJIGlzIG5vdCBzZXQKIyBDT05GSUdfQkxLX0RFVl8zV19Y
WFhYX1JBSUQgaXMgbm90IHNldAojIENPTkZJR19TQ1NJX0hQU0EgaXMgbm90IHNldAojIENP
TkZJR19TQ1NJXzNXXzlYWFggaXMgbm90IHNldAojIENPTkZJR19TQ1NJXzNXX1NBUyBpcyBu
b3Qgc2V0CiMgQ09ORklHX1NDU0lfQUNBUkQgaXMgbm90IHNldAojIENPTkZJR19TQ1NJX0FB
Q1JBSUQgaXMgbm90IHNldAojIENPTkZJR19TQ1NJX0FJQzdYWFggaXMgbm90IHNldAojIENP
TkZJR19TQ1NJX0FJQzc5WFggaXMgbm90IHNldAojIENPTkZJR19TQ1NJX0FJQzk0WFggaXMg
bm90IHNldAojIENPTkZJR19TQ1NJX01WU0FTIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9N
VlVNSSBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfRFBUX0kyTyBpcyBub3Qgc2V0CiMgQ09O
RklHX1NDU0lfQURWQU5TWVMgaXMgbm90IHNldAojIENPTkZJR19TQ1NJX0FSQ01TUiBpcyBu
b3Qgc2V0CiMgQ09ORklHX1NDU0lfRVNBUzJSIGlzIG5vdCBzZXQKIyBDT05GSUdfTUVHQVJB
SURfTkVXR0VOIGlzIG5vdCBzZXQKIyBDT05GSUdfTUVHQVJBSURfTEVHQUNZIGlzIG5vdCBz
ZXQKIyBDT05GSUdfTUVHQVJBSURfU0FTIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9NUFQz
U0FTIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9NUFQyU0FTIGlzIG5vdCBzZXQKIyBDT05G
SUdfU0NTSV9TTUFSVFBRSSBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfVUZTSENEIGlzIG5v
dCBzZXQKIyBDT05GSUdfU0NTSV9IUFRJT1AgaXMgbm90IHNldAojIENPTkZJR19TQ1NJX0JV
U0xPR0lDIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9NWVJCIGlzIG5vdCBzZXQKIyBDT05G
SUdfU0NTSV9NWVJTIGlzIG5vdCBzZXQKIyBDT05GSUdfVk1XQVJFX1BWU0NTSSBpcyBub3Qg
c2V0CiMgQ09ORklHX1NDU0lfU05JQyBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfRE1YMzE5
MUQgaXMgbm90IHNldAojIENPTkZJR19TQ1NJX0ZET01BSU5fUENJIGlzIG5vdCBzZXQKIyBD
T05GSUdfU0NTSV9HRFRIIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9JU0NJIGlzIG5vdCBz
ZXQKIyBDT05GSUdfU0NTSV9JUFMgaXMgbm90IHNldAojIENPTkZJR19TQ1NJX0lOSVRJTyBp
cyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfSU5JQTEwMCBpcyBub3Qgc2V0CiMgQ09ORklHX1ND
U0lfU1RFWCBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfU1lNNTNDOFhYXzIgaXMgbm90IHNl
dAojIENPTkZJR19TQ1NJX0lQUiBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfUUxPR0lDXzEy
ODAgaXMgbm90IHNldAojIENPTkZJR19TQ1NJX1FMQV9JU0NTSSBpcyBub3Qgc2V0CiMgQ09O
RklHX1NDU0lfREMzOTV4IGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9BTTUzQzk3NCBpcyBu
b3Qgc2V0CiMgQ09ORklHX1NDU0lfV0Q3MTlYIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9E
RUJVRyBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfUE1DUkFJRCBpcyBub3Qgc2V0CiMgQ09O
RklHX1NDU0lfUE04MDAxIGlzIG5vdCBzZXQKQ09ORklHX1NDU0lfVklSVElPPXkKIyBDT05G
SUdfU0NTSV9ESCBpcyBub3Qgc2V0CiMgZW5kIG9mIFNDU0kgZGV2aWNlIHN1cHBvcnQKCkNP
TkZJR19BVEE9eQpDT05GSUdfU0FUQV9IT1NUPXkKQ09ORklHX1BBVEFfVElNSU5HUz15CkNP
TkZJR19BVEFfVkVSQk9TRV9FUlJPUj15CkNPTkZJR19BVEFfRk9SQ0U9eQpDT05GSUdfQVRB
X0FDUEk9eQojIENPTkZJR19TQVRBX1pQT0REIGlzIG5vdCBzZXQKIyBDT05GSUdfU0FUQV9Q
TVAgaXMgbm90IHNldAoKIwojIENvbnRyb2xsZXJzIHdpdGggbm9uLVNGRiBuYXRpdmUgaW50
ZXJmYWNlCiMKQ09ORklHX1NBVEFfQUhDST15CkNPTkZJR19TQVRBX01PQklMRV9MUE1fUE9M
SUNZPTMKIyBDT05GSUdfU0FUQV9BSENJX1BMQVRGT1JNIGlzIG5vdCBzZXQKIyBDT05GSUdf
QUhDSV9DRVZBIGlzIG5vdCBzZXQKIyBDT05GSUdfQUhDSV9RT1JJUSBpcyBub3Qgc2V0CiMg
Q09ORklHX1NBVEFfSU5JQzE2MlggaXMgbm90IHNldAojIENPTkZJR19TQVRBX0FDQVJEX0FI
Q0kgaXMgbm90IHNldAojIENPTkZJR19TQVRBX1NJTDI0IGlzIG5vdCBzZXQKQ09ORklHX0FU
QV9TRkY9eQoKIwojIFNGRiBjb250cm9sbGVycyB3aXRoIGN1c3RvbSBETUEgaW50ZXJmYWNl
CiMKIyBDT05GSUdfUERDX0FETUEgaXMgbm90IHNldAojIENPTkZJR19TQVRBX1FTVE9SIGlz
IG5vdCBzZXQKIyBDT05GSUdfU0FUQV9TWDQgaXMgbm90IHNldApDT05GSUdfQVRBX0JNRE1B
PXkKCiMKIyBTQVRBIFNGRiBjb250cm9sbGVycyB3aXRoIEJNRE1BCiMKQ09ORklHX0FUQV9Q
SUlYPXkKIyBDT05GSUdfU0FUQV9EV0MgaXMgbm90IHNldAojIENPTkZJR19TQVRBX01WIGlz
IG5vdCBzZXQKIyBDT05GSUdfU0FUQV9OViBpcyBub3Qgc2V0CiMgQ09ORklHX1NBVEFfUFJP
TUlTRSBpcyBub3Qgc2V0CiMgQ09ORklHX1NBVEFfU0lMIGlzIG5vdCBzZXQKIyBDT05GSUdf
U0FUQV9TSVMgaXMgbm90IHNldAojIENPTkZJR19TQVRBX1NWVyBpcyBub3Qgc2V0CiMgQ09O
RklHX1NBVEFfVUxJIGlzIG5vdCBzZXQKIyBDT05GSUdfU0FUQV9WSUEgaXMgbm90IHNldAoj
IENPTkZJR19TQVRBX1ZJVEVTU0UgaXMgbm90IHNldAoKIwojIFBBVEEgU0ZGIGNvbnRyb2xs
ZXJzIHdpdGggQk1ETUEKIwojIENPTkZJR19QQVRBX0FMSSBpcyBub3Qgc2V0CiMgQ09ORklH
X1BBVEFfQU1EIGlzIG5vdCBzZXQKIyBDT05GSUdfUEFUQV9BUlRPUCBpcyBub3Qgc2V0CiMg
Q09ORklHX1BBVEFfQVRJSVhQIGlzIG5vdCBzZXQKIyBDT05GSUdfUEFUQV9BVFA4NjdYIGlz
IG5vdCBzZXQKIyBDT05GSUdfUEFUQV9DTUQ2NFggaXMgbm90IHNldAojIENPTkZJR19QQVRB
X0NZUFJFU1MgaXMgbm90IHNldAojIENPTkZJR19QQVRBX0VGQVIgaXMgbm90IHNldAojIENP
TkZJR19QQVRBX0hQVDM2NiBpcyBub3Qgc2V0CiMgQ09ORklHX1BBVEFfSFBUMzdYIGlzIG5v
dCBzZXQKIyBDT05GSUdfUEFUQV9IUFQzWDJOIGlzIG5vdCBzZXQKIyBDT05GSUdfUEFUQV9I
UFQzWDMgaXMgbm90IHNldAojIENPTkZJR19QQVRBX0lUODIxMyBpcyBub3Qgc2V0CiMgQ09O
RklHX1BBVEFfSVQ4MjFYIGlzIG5vdCBzZXQKIyBDT05GSUdfUEFUQV9KTUlDUk9OIGlzIG5v
dCBzZXQKIyBDT05GSUdfUEFUQV9NQVJWRUxMIGlzIG5vdCBzZXQKIyBDT05GSUdfUEFUQV9O
RVRDRUxMIGlzIG5vdCBzZXQKIyBDT05GSUdfUEFUQV9OSU5KQTMyIGlzIG5vdCBzZXQKIyBD
T05GSUdfUEFUQV9OUzg3NDE1IGlzIG5vdCBzZXQKIyBDT05GSUdfUEFUQV9PTERQSUlYIGlz
IG5vdCBzZXQKIyBDT05GSUdfUEFUQV9PUFRJRE1BIGlzIG5vdCBzZXQKIyBDT05GSUdfUEFU
QV9QREMyMDI3WCBpcyBub3Qgc2V0CiMgQ09ORklHX1BBVEFfUERDX09MRCBpcyBub3Qgc2V0
CiMgQ09ORklHX1BBVEFfUkFESVNZUyBpcyBub3Qgc2V0CiMgQ09ORklHX1BBVEFfUkRDIGlz
IG5vdCBzZXQKIyBDT05GSUdfUEFUQV9TQ0ggaXMgbm90IHNldAojIENPTkZJR19QQVRBX1NF
UlZFUldPUktTIGlzIG5vdCBzZXQKIyBDT05GSUdfUEFUQV9TSUw2ODAgaXMgbm90IHNldAoj
IENPTkZJR19QQVRBX1NJUyBpcyBub3Qgc2V0CiMgQ09ORklHX1BBVEFfVE9TSElCQSBpcyBu
b3Qgc2V0CiMgQ09ORklHX1BBVEFfVFJJRkxFWCBpcyBub3Qgc2V0CiMgQ09ORklHX1BBVEFf
VklBIGlzIG5vdCBzZXQKIyBDT05GSUdfUEFUQV9XSU5CT05EIGlzIG5vdCBzZXQKCiMKIyBQ
SU8tb25seSBTRkYgY29udHJvbGxlcnMKIwojIENPTkZJR19QQVRBX0NNRDY0MF9QQ0kgaXMg
bm90IHNldAojIENPTkZJR19QQVRBX01QSUlYIGlzIG5vdCBzZXQKIyBDT05GSUdfUEFUQV9O
Uzg3NDEwIGlzIG5vdCBzZXQKIyBDT05GSUdfUEFUQV9PUFRJIGlzIG5vdCBzZXQKIyBDT05G
SUdfUEFUQV9QTEFURk9STSBpcyBub3Qgc2V0CiMgQ09ORklHX1BBVEFfUloxMDAwIGlzIG5v
dCBzZXQKCiMKIyBHZW5lcmljIGZhbGxiYWNrIC8gbGVnYWN5IGRyaXZlcnMKIwojIENPTkZJ
R19QQVRBX0FDUEkgaXMgbm90IHNldApDT05GSUdfQVRBX0dFTkVSSUM9eQojIENPTkZJR19Q
QVRBX0xFR0FDWSBpcyBub3Qgc2V0CkNPTkZJR19NRD15CiMgQ09ORklHX0JMS19ERVZfTUQg
aXMgbm90IHNldAojIENPTkZJR19CQ0FDSEUgaXMgbm90IHNldApDT05GSUdfQkxLX0RFVl9E
TV9CVUlMVElOPXkKQ09ORklHX0JMS19ERVZfRE09eQojIENPTkZJR19ETV9ERUJVRyBpcyBu
b3Qgc2V0CkNPTkZJR19ETV9CVUZJTz15CiMgQ09ORklHX0RNX0RFQlVHX0JMT0NLX01BTkFH
RVJfTE9DS0lORyBpcyBub3Qgc2V0CkNPTkZJR19ETV9CSU9fUFJJU09OPXkKQ09ORklHX0RN
X1BFUlNJU1RFTlRfREFUQT15CiMgQ09ORklHX0RNX1VOU1RSSVBFRCBpcyBub3Qgc2V0CkNP
TkZJR19ETV9DUllQVD15CkNPTkZJR19ETV9WRVJJVFlfQ0hST01FT1M9eQojIENPTkZJR19E
TV9TTkFQU0hPVCBpcyBub3Qgc2V0CkNPTkZJR19ETV9USElOX1BST1ZJU0lPTklORz15CiMg
Q09ORklHX0RNX0NBQ0hFIGlzIG5vdCBzZXQKIyBDT05GSUdfRE1fV1JJVEVDQUNIRSBpcyBu
b3Qgc2V0CiMgQ09ORklHX0RNX0VCUyBpcyBub3Qgc2V0CiMgQ09ORklHX0RNX0VSQSBpcyBu
b3Qgc2V0CiMgQ09ORklHX0RNX0NMT05FIGlzIG5vdCBzZXQKIyBDT05GSUdfRE1fTUlSUk9S
IGlzIG5vdCBzZXQKIyBDT05GSUdfRE1fUkFJRCBpcyBub3Qgc2V0CiMgQ09ORklHX0RNX1pF
Uk8gaXMgbm90IHNldAojIENPTkZJR19ETV9NVUxUSVBBVEggaXMgbm90IHNldAojIENPTkZJ
R19ETV9ERUxBWSBpcyBub3Qgc2V0CiMgQ09ORklHX0RNX0RVU1QgaXMgbm90IHNldApDT05G
SUdfRE1fSU5JVD15CiMgQ09ORklHX0RNX1VFVkVOVCBpcyBub3Qgc2V0CkNPTkZJR19ETV9G
TEFLRVk9eQpDT05GSUdfRE1fVkVSSVRZPXkKIyBDT05GSUdfRE1fVkVSSVRZX1ZFUklGWV9S
T09USEFTSF9TSUcgaXMgbm90IHNldAojIENPTkZJR19ETV9WRVJJVFlfQVZCIGlzIG5vdCBz
ZXQKIyBDT05GSUdfRE1fVkVSSVRZX0ZFQyBpcyBub3Qgc2V0CiMgQ09ORklHX0RNX1NXSVRD
SCBpcyBub3Qgc2V0CiMgQ09ORklHX0RNX0xPR19XUklURVMgaXMgbm90IHNldApDT05GSUdf
RE1fSU5URUdSSVRZPXkKIyBDT05GSUdfRE1fQk9XIGlzIG5vdCBzZXQKIyBDT05GSUdfVEFS
R0VUX0NPUkUgaXMgbm90IHNldAojIENPTkZJR19GVVNJT04gaXMgbm90IHNldAoKIwojIElF
RUUgMTM5NCAoRmlyZVdpcmUpIHN1cHBvcnQKIwojIENPTkZJR19GSVJFV0lSRSBpcyBub3Qg
c2V0CiMgQ09ORklHX0ZJUkVXSVJFX05PU1kgaXMgbm90IHNldAojIGVuZCBvZiBJRUVFIDEz
OTQgKEZpcmVXaXJlKSBzdXBwb3J0CgojIENPTkZJR19NQUNJTlRPU0hfRFJJVkVSUyBpcyBu
b3Qgc2V0CkNPTkZJR19ORVRERVZJQ0VTPXkKQ09ORklHX01JST15CkNPTkZJR19ORVRfQ09S
RT15CiMgQ09ORklHX0JPTkRJTkcgaXMgbm90IHNldAojIENPTkZJR19EVU1NWSBpcyBub3Qg
c2V0CkNPTkZJR19XSVJFR1VBUkQ9eQojIENPTkZJR19XSVJFR1VBUkRfREVCVUcgaXMgbm90
IHNldAojIENPTkZJR19FUVVBTElaRVIgaXMgbm90IHNldAojIENPTkZJR19ORVRfRkMgaXMg
bm90IHNldAojIENPTkZJR19ORVRfVEVBTSBpcyBub3Qgc2V0CiMgQ09ORklHX01BQ1ZMQU4g
aXMgbm90IHNldAojIENPTkZJR19JUFZMQU4gaXMgbm90IHNldAojIENPTkZJR19WWExBTiBp
cyBub3Qgc2V0CiMgQ09ORklHX0dFTkVWRSBpcyBub3Qgc2V0CiMgQ09ORklHX0JBUkVVRFAg
aXMgbm90IHNldAojIENPTkZJR19HVFAgaXMgbm90IHNldAojIENPTkZJR19NQUNTRUMgaXMg
bm90IHNldAojIENPTkZJR19ORVRDT05TT0xFIGlzIG5vdCBzZXQKQ09ORklHX1RVTj15CiMg
Q09ORklHX1RVTl9WTkVUX0NST1NTX0xFIGlzIG5vdCBzZXQKQ09ORklHX1ZFVEg9eQpDT05G
SUdfVklSVElPX05FVD15CiMgQ09ORklHX05MTU9OIGlzIG5vdCBzZXQKIyBDT05GSUdfVlNP
Q0tNT04gaXMgbm90IHNldAojIENPTkZJR19BUkNORVQgaXMgbm90IHNldAoKIwojIERpc3Ry
aWJ1dGVkIFN3aXRjaCBBcmNoaXRlY3R1cmUgZHJpdmVycwojCiMgZW5kIG9mIERpc3RyaWJ1
dGVkIFN3aXRjaCBBcmNoaXRlY3R1cmUgZHJpdmVycwoKQ09ORklHX0VUSEVSTkVUPXkKQ09O
RklHX01ESU89eQpDT05GSUdfTkVUX1ZFTkRPUl8zQ09NPXkKIyBDT05GSUdfVk9SVEVYIGlz
IG5vdCBzZXQKIyBDT05GSUdfVFlQSE9PTiBpcyBub3Qgc2V0CkNPTkZJR19ORVRfVkVORE9S
X0FEQVBURUM9eQojIENPTkZJR19BREFQVEVDX1NUQVJGSVJFIGlzIG5vdCBzZXQKQ09ORklH
X05FVF9WRU5ET1JfQUdFUkU9eQojIENPTkZJR19FVDEzMVggaXMgbm90IHNldApDT05GSUdf
TkVUX1ZFTkRPUl9BTEFDUklURUNIPXkKIyBDT05GSUdfU0xJQ09TUyBpcyBub3Qgc2V0CkNP
TkZJR19ORVRfVkVORE9SX0FMVEVPTj15CiMgQ09ORklHX0FDRU5JQyBpcyBub3Qgc2V0CiMg
Q09ORklHX0FMVEVSQV9UU0UgaXMgbm90IHNldApDT05GSUdfTkVUX1ZFTkRPUl9BTUFaT049
eQojIENPTkZJR19FTkFfRVRIRVJORVQgaXMgbm90IHNldApDT05GSUdfTkVUX1ZFTkRPUl9B
TUQ9eQojIENPTkZJR19BTUQ4MTExX0VUSCBpcyBub3Qgc2V0CiMgQ09ORklHX1BDTkVUMzIg
aXMgbm90IHNldAojIENPTkZJR19BTURfWEdCRSBpcyBub3Qgc2V0CkNPTkZJR19ORVRfVkVO
RE9SX0FRVUFOVElBPXkKIyBDT05GSUdfQVFUSU9OIGlzIG5vdCBzZXQKQ09ORklHX05FVF9W
RU5ET1JfQVJDPXkKQ09ORklHX05FVF9WRU5ET1JfQVRIRVJPUz15CiMgQ09ORklHX0FUTDIg
aXMgbm90IHNldAojIENPTkZJR19BVEwxIGlzIG5vdCBzZXQKIyBDT05GSUdfQVRMMUUgaXMg
bm90IHNldAojIENPTkZJR19BVEwxQyBpcyBub3Qgc2V0CkNPTkZJR19BTFg9eQpDT05GSUdf
TkVUX1ZFTkRPUl9BVVJPUkE9eQojIENPTkZJR19BVVJPUkFfTkI4ODAwIGlzIG5vdCBzZXQK
Q09ORklHX05FVF9WRU5ET1JfQlJPQURDT009eQojIENPTkZJR19CNDQgaXMgbm90IHNldAoj
IENPTkZJR19CQ01HRU5FVCBpcyBub3Qgc2V0CiMgQ09ORklHX0JOWDIgaXMgbm90IHNldAoj
IENPTkZJR19DTklDIGlzIG5vdCBzZXQKIyBDT05GSUdfVElHT04zIGlzIG5vdCBzZXQKIyBD
T05GSUdfQk5YMlggaXMgbm90IHNldAojIENPTkZJR19TWVNURU1QT1JUIGlzIG5vdCBzZXQK
IyBDT05GSUdfQk5YVCBpcyBub3Qgc2V0CkNPTkZJR19ORVRfVkVORE9SX0JST0NBREU9eQoj
IENPTkZJR19CTkEgaXMgbm90IHNldApDT05GSUdfTkVUX1ZFTkRPUl9DQURFTkNFPXkKIyBD
T05GSUdfTUFDQiBpcyBub3Qgc2V0CkNPTkZJR19ORVRfVkVORE9SX0NBVklVTT15CiMgQ09O
RklHX1RIVU5ERVJfTklDX1BGIGlzIG5vdCBzZXQKIyBDT05GSUdfVEhVTkRFUl9OSUNfVkYg
aXMgbm90IHNldAojIENPTkZJR19USFVOREVSX05JQ19CR1ggaXMgbm90IHNldAojIENPTkZJ
R19USFVOREVSX05JQ19SR1ggaXMgbm90IHNldAojIENPTkZJR19DQVZJVU1fUFRQIGlzIG5v
dCBzZXQKIyBDT05GSUdfTElRVUlESU8gaXMgbm90IHNldAojIENPTkZJR19MSVFVSURJT19W
RiBpcyBub3Qgc2V0CkNPTkZJR19ORVRfVkVORE9SX0NIRUxTSU89eQojIENPTkZJR19DSEVM
U0lPX1QxIGlzIG5vdCBzZXQKIyBDT05GSUdfQ0hFTFNJT19UMyBpcyBub3Qgc2V0CiMgQ09O
RklHX0NIRUxTSU9fVDQgaXMgbm90IHNldAojIENPTkZJR19DSEVMU0lPX1Q0VkYgaXMgbm90
IHNldApDT05GSUdfTkVUX1ZFTkRPUl9DSVNDTz15CiMgQ09ORklHX0VOSUMgaXMgbm90IHNl
dApDT05GSUdfTkVUX1ZFTkRPUl9DT1JUSU5BPXkKIyBDT05GSUdfR0VNSU5JX0VUSEVSTkVU
IGlzIG5vdCBzZXQKIyBDT05GSUdfQ1hfRUNBVCBpcyBub3Qgc2V0CiMgQ09ORklHX0RORVQg
aXMgbm90IHNldApDT05GSUdfTkVUX1ZFTkRPUl9ERUM9eQojIENPTkZJR19ORVRfVFVMSVAg
aXMgbm90IHNldApDT05GSUdfTkVUX1ZFTkRPUl9ETElOSz15CiMgQ09ORklHX0RMMksgaXMg
bm90IHNldAojIENPTkZJR19TVU5EQU5DRSBpcyBub3Qgc2V0CkNPTkZJR19ORVRfVkVORE9S
X0VNVUxFWD15CiMgQ09ORklHX0JFMk5FVCBpcyBub3Qgc2V0CkNPTkZJR19ORVRfVkVORE9S
X0VaQ0hJUD15CiMgQ09ORklHX0VaQ0hJUF9OUFNfTUFOQUdFTUVOVF9FTkVUIGlzIG5vdCBz
ZXQKQ09ORklHX05FVF9WRU5ET1JfR09PR0xFPXkKIyBDT05GSUdfR1ZFIGlzIG5vdCBzZXQK
Q09ORklHX05FVF9WRU5ET1JfSFVBV0VJPXkKIyBDT05GSUdfSElOSUMgaXMgbm90IHNldApD
T05GSUdfTkVUX1ZFTkRPUl9JODI1WFg9eQpDT05GSUdfTkVUX1ZFTkRPUl9JTlRFTD15CkNP
TkZJR19FMTAwPXkKQ09ORklHX0UxMDAwPXkKQ09ORklHX0UxMDAwRT15CkNPTkZJR19FMTAw
MEVfSFdUUz15CiMgQ09ORklHX0lHQiBpcyBub3Qgc2V0CkNPTkZJR19JR0JWRj15CiMgQ09O
RklHX0lYR0IgaXMgbm90IHNldAojIENPTkZJR19JWEdCRSBpcyBub3Qgc2V0CiMgQ09ORklH
X0lYR0JFVkYgaXMgbm90IHNldAojIENPTkZJR19JNDBFIGlzIG5vdCBzZXQKIyBDT05GSUdf
STQwRVZGIGlzIG5vdCBzZXQKIyBDT05GSUdfSUNFIGlzIG5vdCBzZXQKIyBDT05GSUdfRk0x
MEsgaXMgbm90IHNldAojIENPTkZJR19JR0MgaXMgbm90IHNldApDT05GSUdfSk1FPXkKQ09O
RklHX05FVF9WRU5ET1JfTUFSVkVMTD15CiMgQ09ORklHX01WTURJTyBpcyBub3Qgc2V0CkNP
TkZJR19TS0dFPXkKIyBDT05GSUdfU0tHRV9ERUJVRyBpcyBub3Qgc2V0CiMgQ09ORklHX1NL
R0VfR0VORVNJUyBpcyBub3Qgc2V0CkNPTkZJR19TS1kyPXkKIyBDT05GSUdfU0tZMl9ERUJV
RyBpcyBub3Qgc2V0CkNPTkZJR19ORVRfVkVORE9SX01FTExBTk9YPXkKIyBDT05GSUdfTUxY
NF9FTiBpcyBub3Qgc2V0CiMgQ09ORklHX01MWDVfQ09SRSBpcyBub3Qgc2V0CiMgQ09ORklH
X01MWFNXX0NPUkUgaXMgbm90IHNldAojIENPTkZJR19NTFhGVyBpcyBub3Qgc2V0CkNPTkZJ
R19ORVRfVkVORE9SX01JQ1JFTD15CiMgQ09ORklHX0tTODg0MiBpcyBub3Qgc2V0CiMgQ09O
RklHX0tTODg1MSBpcyBub3Qgc2V0CiMgQ09ORklHX0tTODg1MV9NTEwgaXMgbm90IHNldAoj
IENPTkZJR19LU1o4ODRYX1BDSSBpcyBub3Qgc2V0CkNPTkZJR19ORVRfVkVORE9SX01JQ1JP
Q0hJUD15CiMgQ09ORklHX0VOQzI4SjYwIGlzIG5vdCBzZXQKIyBDT05GSUdfRU5DWDI0SjYw
MCBpcyBub3Qgc2V0CiMgQ09ORklHX0xBTjc0M1ggaXMgbm90IHNldApDT05GSUdfTkVUX1ZF
TkRPUl9NSUNST1NFTUk9eQpDT05GSUdfTkVUX1ZFTkRPUl9NWVJJPXkKIyBDT05GSUdfTVlS
STEwR0UgaXMgbm90IHNldAojIENPTkZJR19GRUFMTlggaXMgbm90IHNldApDT05GSUdfTkVU
X1ZFTkRPUl9OQVRTRU1JPXkKIyBDT05GSUdfTkFUU0VNSSBpcyBub3Qgc2V0CiMgQ09ORklH
X05TODM4MjAgaXMgbm90IHNldApDT05GSUdfTkVUX1ZFTkRPUl9ORVRFUklPTj15CiMgQ09O
RklHX1MySU8gaXMgbm90IHNldAojIENPTkZJR19WWEdFIGlzIG5vdCBzZXQKQ09ORklHX05F
VF9WRU5ET1JfTkVUUk9OT01FPXkKIyBDT05GSUdfTkZQIGlzIG5vdCBzZXQKQ09ORklHX05F
VF9WRU5ET1JfTkk9eQojIENPTkZJR19OSV9YR0VfTUFOQUdFTUVOVF9FTkVUIGlzIG5vdCBz
ZXQKQ09ORklHX05FVF9WRU5ET1JfODM5MD15CiMgQ09ORklHX05FMktfUENJIGlzIG5vdCBz
ZXQKQ09ORklHX05FVF9WRU5ET1JfTlZJRElBPXkKIyBDT05GSUdfRk9SQ0VERVRIIGlzIG5v
dCBzZXQKQ09ORklHX05FVF9WRU5ET1JfT0tJPXkKIyBDT05GSUdfRVRIT0MgaXMgbm90IHNl
dApDT05GSUdfTkVUX1ZFTkRPUl9QQUNLRVRfRU5HSU5FUz15CiMgQ09ORklHX0hBTUFDSEkg
aXMgbm90IHNldAojIENPTkZJR19ZRUxMT1dGSU4gaXMgbm90IHNldApDT05GSUdfTkVUX1ZF
TkRPUl9QRU5TQU5ETz15CiMgQ09ORklHX0lPTklDIGlzIG5vdCBzZXQKQ09ORklHX05FVF9W
RU5ET1JfUUxPR0lDPXkKIyBDT05GSUdfUUxBM1hYWCBpcyBub3Qgc2V0CiMgQ09ORklHX1FM
Q05JQyBpcyBub3Qgc2V0CiMgQ09ORklHX05FVFhFTl9OSUMgaXMgbm90IHNldAojIENPTkZJ
R19RRUQgaXMgbm90IHNldApDT05GSUdfTkVUX1ZFTkRPUl9RVUFMQ09NTT15CiMgQ09ORklH
X1FDQTcwMDBfU1BJIGlzIG5vdCBzZXQKIyBDT05GSUdfUUNPTV9FTUFDIGlzIG5vdCBzZXQK
IyBDT05GSUdfUk1ORVQgaXMgbm90IHNldApDT05GSUdfTkVUX1ZFTkRPUl9SREM9eQojIENP
TkZJR19SNjA0MCBpcyBub3Qgc2V0CkNPTkZJR19ORVRfVkVORE9SX1JFQUxURUs9eQojIENP
TkZJR184MTM5Q1AgaXMgbm90IHNldAojIENPTkZJR184MTM5VE9PIGlzIG5vdCBzZXQKQ09O
RklHX1I4MTY5PXkKQ09ORklHX05FVF9WRU5ET1JfUkVORVNBUz15CkNPTkZJR19ORVRfVkVO
RE9SX1JPQ0tFUj15CkNPTkZJR19ORVRfVkVORE9SX1NBTVNVTkc9eQojIENPTkZJR19TWEdC
RV9FVEggaXMgbm90IHNldApDT05GSUdfTkVUX1ZFTkRPUl9TRUVRPXkKQ09ORklHX05FVF9W
RU5ET1JfU09MQVJGTEFSRT15CiMgQ09ORklHX1NGQyBpcyBub3Qgc2V0CiMgQ09ORklHX1NG
Q19GQUxDT04gaXMgbm90IHNldApDT05GSUdfTkVUX1ZFTkRPUl9TSUxBTj15CiMgQ09ORklH
X1NDOTIwMzEgaXMgbm90IHNldApDT05GSUdfTkVUX1ZFTkRPUl9TSVM9eQojIENPTkZJR19T
SVM5MDAgaXMgbm90IHNldAojIENPTkZJR19TSVMxOTAgaXMgbm90IHNldApDT05GSUdfTkVU
X1ZFTkRPUl9TTVNDPXkKIyBDT05GSUdfRVBJQzEwMCBpcyBub3Qgc2V0CiMgQ09ORklHX1NN
U0M5MTFYIGlzIG5vdCBzZXQKIyBDT05GSUdfU01TQzk0MjAgaXMgbm90IHNldApDT05GSUdf
TkVUX1ZFTkRPUl9TT0NJT05FWFQ9eQpDT05GSUdfTkVUX1ZFTkRPUl9TVE1JQ1JPPXkKIyBD
T05GSUdfU1RNTUFDX0VUSCBpcyBub3Qgc2V0CkNPTkZJR19ORVRfVkVORE9SX1NVTj15CiMg
Q09ORklHX0hBUFBZTUVBTCBpcyBub3Qgc2V0CiMgQ09ORklHX1NVTkdFTSBpcyBub3Qgc2V0
CiMgQ09ORklHX0NBU1NJTkkgaXMgbm90IHNldAojIENPTkZJR19OSVUgaXMgbm90IHNldApD
T05GSUdfTkVUX1ZFTkRPUl9TWU5PUFNZUz15CiMgQ09ORklHX0RXQ19YTEdNQUMgaXMgbm90
IHNldApDT05GSUdfTkVUX1ZFTkRPUl9URUhVVEk9eQojIENPTkZJR19URUhVVEkgaXMgbm90
IHNldApDT05GSUdfTkVUX1ZFTkRPUl9UST15CiMgQ09ORklHX1RJX0NQU1dfUEhZX1NFTCBp
cyBub3Qgc2V0CiMgQ09ORklHX1RMQU4gaXMgbm90IHNldApDT05GSUdfTkVUX1ZFTkRPUl9W
SUE9eQojIENPTkZJR19WSUFfUkhJTkUgaXMgbm90IHNldAojIENPTkZJR19WSUFfVkVMT0NJ
VFkgaXMgbm90IHNldApDT05GSUdfTkVUX1ZFTkRPUl9XSVpORVQ9eQojIENPTkZJR19XSVpO
RVRfVzUxMDAgaXMgbm90IHNldAojIENPTkZJR19XSVpORVRfVzUzMDAgaXMgbm90IHNldApD
T05GSUdfTkVUX1ZFTkRPUl9YSUxJTlg9eQojIENPTkZJR19YSUxJTlhfQVhJX0VNQUMgaXMg
bm90IHNldAojIENPTkZJR19YSUxJTlhfTExfVEVNQUMgaXMgbm90IHNldAojIENPTkZJR19G
RERJIGlzIG5vdCBzZXQKIyBDT05GSUdfSElQUEkgaXMgbm90IHNldAojIENPTkZJR19ORVRf
U0IxMDAwIGlzIG5vdCBzZXQKQ09ORklHX1BIWUxJQj15CkNPTkZJR19TV1BIWT15CiMgQ09O
RklHX0xFRF9UUklHR0VSX1BIWSBpcyBub3Qgc2V0CkNPTkZJR19GSVhFRF9QSFk9eQoKIwoj
IE1JSSBQSFkgZGV2aWNlIGRyaXZlcnMKIwojIENPTkZJR19BTURfUEhZIGlzIG5vdCBzZXQK
IyBDT05GSUdfQURJTl9QSFkgaXMgbm90IHNldAojIENPTkZJR19BUVVBTlRJQV9QSFkgaXMg
bm90IHNldAojIENPTkZJR19BWDg4Nzk2Ql9QSFkgaXMgbm90IHNldAojIENPTkZJR19CUk9B
RENPTV9QSFkgaXMgbm90IHNldAojIENPTkZJR19CQ001NDE0MF9QSFkgaXMgbm90IHNldAoj
IENPTkZJR19CQ003WFhYX1BIWSBpcyBub3Qgc2V0CiMgQ09ORklHX0JDTTg0ODgxX1BIWSBp
cyBub3Qgc2V0CiMgQ09ORklHX0JDTTg3WFhfUEhZIGlzIG5vdCBzZXQKIyBDT05GSUdfQ0lD
QURBX1BIWSBpcyBub3Qgc2V0CiMgQ09ORklHX0NPUlRJTkFfUEhZIGlzIG5vdCBzZXQKIyBD
T05GSUdfREFWSUNPTV9QSFkgaXMgbm90IHNldAojIENPTkZJR19JQ1BMVVNfUEhZIGlzIG5v
dCBzZXQKIyBDT05GSUdfTFhUX1BIWSBpcyBub3Qgc2V0CiMgQ09ORklHX0lOVEVMX1hXQVlf
UEhZIGlzIG5vdCBzZXQKIyBDT05GSUdfTFNJX0VUMTAxMUNfUEhZIGlzIG5vdCBzZXQKIyBD
T05GSUdfTUFSVkVMTF9QSFkgaXMgbm90IHNldAojIENPTkZJR19NQVJWRUxMXzEwR19QSFkg
aXMgbm90IHNldAojIENPTkZJR19NSUNSRUxfUEhZIGlzIG5vdCBzZXQKIyBDT05GSUdfTUlD
Uk9DSElQX1BIWSBpcyBub3Qgc2V0CiMgQ09ORklHX01JQ1JPQ0hJUF9UMV9QSFkgaXMgbm90
IHNldAojIENPTkZJR19NSUNST1NFTUlfUEhZIGlzIG5vdCBzZXQKIyBDT05GSUdfTkFUSU9O
QUxfUEhZIGlzIG5vdCBzZXQKIyBDT05GSUdfTlhQX1RKQTExWFhfUEhZIGlzIG5vdCBzZXQK
IyBDT05GSUdfUVNFTUlfUEhZIGlzIG5vdCBzZXQKQ09ORklHX1JFQUxURUtfUEhZPXkKIyBD
T05GSUdfUkVORVNBU19QSFkgaXMgbm90IHNldAojIENPTkZJR19ST0NLQ0hJUF9QSFkgaXMg
bm90IHNldApDT05GSUdfU01TQ19QSFk9eQojIENPTkZJR19TVEUxMFhQIGlzIG5vdCBzZXQK
IyBDT05GSUdfVEVSQU5FVElDU19QSFkgaXMgbm90IHNldAojIENPTkZJR19EUDgzODIyX1BI
WSBpcyBub3Qgc2V0CiMgQ09ORklHX0RQODNUQzgxMV9QSFkgaXMgbm90IHNldAojIENPTkZJ
R19EUDgzODQ4X1BIWSBpcyBub3Qgc2V0CiMgQ09ORklHX0RQODM4NjdfUEhZIGlzIG5vdCBz
ZXQKIyBDT05GSUdfRFA4Mzg2OV9QSFkgaXMgbm90IHNldAojIENPTkZJR19WSVRFU1NFX1BI
WSBpcyBub3Qgc2V0CiMgQ09ORklHX1hJTElOWF9HTUlJMlJHTUlJIGlzIG5vdCBzZXQKIyBD
T05GSUdfTUlDUkVMX0tTODk5NU1BIGlzIG5vdCBzZXQKQ09ORklHX01ESU9fREVWSUNFPXkK
Q09ORklHX01ESU9fQlVTPXkKQ09ORklHX09GX01ESU89eQpDT05GSUdfTURJT19ERVZSRVM9
eQojIENPTkZJR19NRElPX0JJVEJBTkcgaXMgbm90IHNldAojIENPTkZJR19NRElPX0JDTV9V
TklNQUMgaXMgbm90IHNldAojIENPTkZJR19NRElPX0hJU0lfRkVNQUMgaXMgbm90IHNldAoj
IENPTkZJR19NRElPX01WVVNCIGlzIG5vdCBzZXQKIyBDT05GSUdfTURJT19NU0NDX01JSU0g
aXMgbm90IHNldAojIENPTkZJR19NRElPX09DVEVPTiBpcyBub3Qgc2V0CiMgQ09ORklHX01E
SU9fSVBRNDAxOSBpcyBub3Qgc2V0CiMgQ09ORklHX01ESU9fVEhVTkRFUiBpcyBub3Qgc2V0
CgojCiMgTURJTyBNdWx0aXBsZXhlcnMKIwojIENPTkZJR19NRElPX0JVU19NVVhfR1BJTyBp
cyBub3Qgc2V0CiMgQ09ORklHX01ESU9fQlVTX01VWF9NVUxUSVBMRVhFUiBpcyBub3Qgc2V0
CiMgQ09ORklHX01ESU9fQlVTX01VWF9NTUlPUkVHIGlzIG5vdCBzZXQKCiMKIyBQQ1MgZGV2
aWNlIGRyaXZlcnMKIwojIENPTkZJR19QQ1NfWFBDUyBpcyBub3Qgc2V0CiMgZW5kIG9mIFBD
UyBkZXZpY2UgZHJpdmVycwoKQ09ORklHX1BQUD15CiMgQ09ORklHX1BQUF9CU0RDT01QIGlz
IG5vdCBzZXQKIyBDT05GSUdfUFBQX0RFRkxBVEUgaXMgbm90IHNldAojIENPTkZJR19QUFBf
RklMVEVSIGlzIG5vdCBzZXQKQ09ORklHX1BQUF9NUFBFPXkKIyBDT05GSUdfUFBQX01VTFRJ
TElOSyBpcyBub3Qgc2V0CiMgQ09ORklHX1BQUE9FIGlzIG5vdCBzZXQKQ09ORklHX1BQUF9B
U1lOQz15CiMgQ09ORklHX1BQUF9TWU5DX1RUWSBpcyBub3Qgc2V0CiMgQ09ORklHX1NMSVAg
aXMgbm90IHNldApDT05GSUdfU0xIQz15CkNPTkZJR19VU0JfTkVUX0RSSVZFUlM9eQojIENP
TkZJR19VU0JfQ0FUQyBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9LQVdFVEggaXMgbm90IHNl
dApDT05GSUdfVVNCX1BFR0FTVVM9eQpDT05GSUdfVVNCX1JUTDgxNTA9eQpDT05GSUdfVVNC
X1JUTDgxNTI9eQojIENPTkZJR19VU0JfTEFONzhYWCBpcyBub3Qgc2V0CkNPTkZJR19VU0Jf
VVNCTkVUPXkKQ09ORklHX1VTQl9ORVRfQVg4ODE3WD15CkNPTkZJR19VU0JfTkVUX0FYODgx
NzlfMTc4QT15CkNPTkZJR19VU0JfTkVUX0NEQ0VUSEVSPXkKIyBDT05GSUdfVVNCX05FVF9D
RENfRUVNIGlzIG5vdCBzZXQKQ09ORklHX1VTQl9ORVRfQ0RDX05DTT15CiMgQ09ORklHX1VT
Ql9ORVRfSFVBV0VJX0NEQ19OQ00gaXMgbm90IHNldAojIENPTkZJR19VU0JfTkVUX0NEQ19N
QklNIGlzIG5vdCBzZXQKQ09ORklHX1VTQl9ORVRfRE05NjAxPXkKIyBDT05GSUdfVVNCX05F
VF9TUjk3MDAgaXMgbm90IHNldAojIENPTkZJR19VU0JfTkVUX1NSOTgwMCBpcyBub3Qgc2V0
CkNPTkZJR19VU0JfTkVUX1NNU0M3NVhYPXkKQ09ORklHX1VTQl9ORVRfU01TQzk1WFg9eQoj
IENPTkZJR19VU0JfTkVUX0dMNjIwQSBpcyBub3Qgc2V0CkNPTkZJR19VU0JfTkVUX05FVDEw
ODA9eQojIENPTkZJR19VU0JfTkVUX1BMVVNCIGlzIG5vdCBzZXQKQ09ORklHX1VTQl9ORVRf
TUNTNzgzMD15CkNPTkZJR19VU0JfTkVUX1JORElTX0hPU1Q9eQojIENPTkZJR19VU0JfTkVU
X0NEQ19TVUJTRVQgaXMgbm90IHNldAojIENPTkZJR19VU0JfTkVUX1pBVVJVUyBpcyBub3Qg
c2V0CiMgQ09ORklHX1VTQl9ORVRfQ1g4MjMxMF9FVEggaXMgbm90IHNldAojIENPTkZJR19V
U0JfTkVUX0tBTE1JQSBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9ORVRfUU1JX1dXQU4gaXMg
bm90IHNldAojIENPTkZJR19VU0JfSFNPIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX05FVF9J
TlQ1MVgxIGlzIG5vdCBzZXQKQ09ORklHX1VTQl9JUEhFVEg9eQojIENPTkZJR19VU0JfU0lF
UlJBX05FVCBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9WTDYwMCBpcyBub3Qgc2V0CiMgQ09O
RklHX1VTQl9ORVRfQ0g5MjAwIGlzIG5vdCBzZXQKQ09ORklHX1VTQl9ORVRfQVFDMTExPXkK
IyBDT05GSUdfVVNCX1JUTDgxNTNfRUNNIGlzIG5vdCBzZXQKQ09ORklHX1dMQU49eQojIENP
TkZJR19XSVJFTEVTU19XRFMgaXMgbm90IHNldApDT05GSUdfV0xBTl9WRU5ET1JfQURNVEVL
PXkKIyBDT05GSUdfQURNODIxMSBpcyBub3Qgc2V0CkNPTkZJR19BVEhfQ09NTU9OPXkKQ09O
RklHX1dMQU5fVkVORE9SX0FUSD15CkNPTkZJR19BVEhfREVCVUc9eQojIENPTkZJR19BVEhf
VFJBQ0VQT0lOVFMgaXMgbm90IHNldAojIENPTkZJR19BVEhfUkVHX0RZTkFNSUNfVVNFUl9S
RUdfSElOVFMgaXMgbm90IHNldAojIENPTkZJR19BVEg1SyBpcyBub3Qgc2V0CiMgQ09ORklH
X0FUSDVLX1BDSSBpcyBub3Qgc2V0CkNPTkZJR19BVEg5S19IVz15CkNPTkZJR19BVEg5S19D
T01NT049eQpDT05GSUdfQVRIOUtfQ09NTU9OX0RFQlVHPXkKQ09ORklHX0FUSDlLX0JUQ09F
WF9TVVBQT1JUPXkKQ09ORklHX0FUSDlLPXkKQ09ORklHX0FUSDlLX1BDST15CiMgQ09ORklH
X0FUSDlLX0FIQiBpcyBub3Qgc2V0CkNPTkZJR19BVEg5S19ERUJVR0ZTPXkKIyBDT05GSUdf
QVRIOUtfU1RBVElPTl9TVEFUSVNUSUNTIGlzIG5vdCBzZXQKIyBDT05GSUdfQVRIOUtfVFg5
OSBpcyBub3Qgc2V0CiMgQ09ORklHX0FUSDlLX0RGU19DRVJUSUZJRUQgaXMgbm90IHNldAoj
IENPTkZJR19BVEg5S19EWU5BQ0sgaXMgbm90IHNldAojIENPTkZJR19BVEg5S19XT1cgaXMg
bm90IHNldAojIENPTkZJR19BVEg5S19SRktJTEwgaXMgbm90IHNldAojIENPTkZJR19BVEg5
S19DSEFOTkVMX0NPTlRFWFQgaXMgbm90IHNldApDT05GSUdfQVRIOUtfUENPRU09eQojIENP
TkZJR19BVEg5S19QQ0lfTk9fRUVQUk9NIGlzIG5vdCBzZXQKIyBDT05GSUdfQVRIOUtfSFRD
IGlzIG5vdCBzZXQKIyBDT05GSUdfQVRIOUtfSFdSTkcgaXMgbm90IHNldAojIENPTkZJR19B
VEg5S19DT01NT05fU1BFQ1RSQUwgaXMgbm90IHNldAojIENPTkZJR19DQVJMOTE3MCBpcyBu
b3Qgc2V0CiMgQ09ORklHX0FUSDZLTCBpcyBub3Qgc2V0CiMgQ09ORklHX0FSNTUyMyBpcyBu
b3Qgc2V0CiMgQ09ORklHX1dJTDYyMTAgaXMgbm90IHNldAojIENPTkZJR19BVEgxMEsgaXMg
bm90IHNldAojIENPTkZJR19XQ04zNlhYIGlzIG5vdCBzZXQKQ09ORklHX1dMQU5fVkVORE9S
X0FUTUVMPXkKIyBDT05GSUdfQVRNRUwgaXMgbm90IHNldAojIENPTkZJR19BVDc2QzUwWF9V
U0IgaXMgbm90IHNldApDT05GSUdfV0xBTl9WRU5ET1JfQlJPQURDT009eQpDT05GSUdfQjQz
PXkKQ09ORklHX0I0M19CQ01BPXkKQ09ORklHX0I0M19TU0I9eQpDT05GSUdfQjQzX0JVU0VT
X0JDTUFfQU5EX1NTQj15CiMgQ09ORklHX0I0M19CVVNFU19CQ01BIGlzIG5vdCBzZXQKIyBD
T05GSUdfQjQzX0JVU0VTX1NTQiBpcyBub3Qgc2V0CkNPTkZJR19CNDNfUENJX0FVVE9TRUxF
Q1Q9eQpDT05GSUdfQjQzX1BDSUNPUkVfQVVUT1NFTEVDVD15CkNPTkZJR19CNDNfU0RJTz15
CkNPTkZJR19CNDNfQkNNQV9QSU89eQpDT05GSUdfQjQzX1BJTz15CkNPTkZJR19CNDNfUEhZ
X0c9eQpDT05GSUdfQjQzX1BIWV9OPXkKQ09ORklHX0I0M19QSFlfTFA9eQpDT05GSUdfQjQz
X1BIWV9IVD15CkNPTkZJR19CNDNfTEVEUz15CkNPTkZJR19CNDNfSFdSTkc9eQojIENPTkZJ
R19CNDNfREVCVUcgaXMgbm90IHNldAojIENPTkZJR19CNDNMRUdBQ1kgaXMgbm90IHNldApD
T05GSUdfQlJDTVVUSUw9eQojIENPTkZJR19CUkNNU01BQyBpcyBub3Qgc2V0CkNPTkZJR19C
UkNNRk1BQz15CkNPTkZJR19CUkNNRk1BQ19QUk9UT19CQ0RDPXkKQ09ORklHX0JSQ01GTUFD
X1BST1RPX01TR0JVRj15CkNPTkZJR19CUkNNRk1BQ19TRElPPXkKQ09ORklHX0JSQ01GTUFD
X1VTQj15CkNPTkZJR19CUkNNRk1BQ19QQ0lFPXkKIyBDT05GSUdfQlJDTV9UUkFDSU5HIGlz
IG5vdCBzZXQKIyBDT05GSUdfQlJDTURCRyBpcyBub3Qgc2V0CkNPTkZJR19XTEFOX1ZFTkRP
Ul9DSVNDTz15CiMgQ09ORklHX0FJUk8gaXMgbm90IHNldApDT05GSUdfV0xBTl9WRU5ET1Jf
SU5URUw9eQojIENPTkZJR19JUFcyMTAwIGlzIG5vdCBzZXQKIyBDT05GSUdfSVBXMjIwMCBp
cyBub3Qgc2V0CiMgQ09ORklHX0lXTDQ5NjUgaXMgbm90IHNldAojIENPTkZJR19JV0wzOTQ1
IGlzIG5vdCBzZXQKIyBDT05GSUdfSVdMV0lGSSBpcyBub3Qgc2V0CkNPTkZJR19XTEFOX1ZF
TkRPUl9JTlRFUlNJTD15CiMgQ09ORklHX0hPU1RBUCBpcyBub3Qgc2V0CiMgQ09ORklHX0hF
Uk1FUyBpcyBub3Qgc2V0CiMgQ09ORklHX1A1NF9DT01NT04gaXMgbm90IHNldAojIENPTkZJ
R19QUklTTTU0IGlzIG5vdCBzZXQKQ09ORklHX1dMQU5fVkVORE9SX01BUlZFTEw9eQojIENP
TkZJR19MSUJFUlRBUyBpcyBub3Qgc2V0CiMgQ09ORklHX0xJQkVSVEFTX1RISU5GSVJNIGlz
IG5vdCBzZXQKQ09ORklHX01XSUZJRVg9eQojIENPTkZJR19NV0lGSUVYX1NESU8gaXMgbm90
IHNldApDT05GSUdfTVdJRklFWF9QQ0lFPXkKIyBDT05GSUdfTVdJRklFWF9VU0IgaXMgbm90
IHNldAojIENPTkZJR19NV0w4SyBpcyBub3Qgc2V0CkNPTkZJR19XTEFOX1ZFTkRPUl9NRURJ
QVRFSz15CiMgQ09ORklHX01UNzYwMVUgaXMgbm90IHNldAojIENPTkZJR19NVDc2eDBVIGlz
IG5vdCBzZXQKIyBDT05GSUdfTVQ3NngwRSBpcyBub3Qgc2V0CiMgQ09ORklHX01UNzZ4MkUg
aXMgbm90IHNldAojIENPTkZJR19NVDc2eDJVIGlzIG5vdCBzZXQKIyBDT05GSUdfTVQ3NjAz
RSBpcyBub3Qgc2V0CiMgQ09ORklHX01UNzYxNUUgaXMgbm90IHNldAojIENPTkZJR19NVDc2
NjNVIGlzIG5vdCBzZXQKIyBDT05GSUdfTVQ3NjYzUyBpcyBub3Qgc2V0CiMgQ09ORklHX01U
NzkxNUUgaXMgbm90IHNldAojIENPTkZJR19NVDc5MjFFIGlzIG5vdCBzZXQKIyBDT05GSUdf
TVQ3OTIxUyBpcyBub3Qgc2V0CkNPTkZJR19XTEFOX1ZFTkRPUl9NSUNST0NISVA9eQojIENP
TkZJR19XSUxDMTAwMF9TRElPIGlzIG5vdCBzZXQKIyBDT05GSUdfV0lMQzEwMDBfU1BJIGlz
IG5vdCBzZXQKQ09ORklHX1dMQU5fVkVORE9SX1JBTElOSz15CkNPTkZJR19SVDJYMDA9eQoj
IENPTkZJR19SVDI0MDBQQ0kgaXMgbm90IHNldAojIENPTkZJR19SVDI1MDBQQ0kgaXMgbm90
IHNldAojIENPTkZJR19SVDYxUENJIGlzIG5vdCBzZXQKQ09ORklHX1JUMjgwMFBDST15CkNP
TkZJR19SVDI4MDBQQ0lfUlQzM1hYPXkKQ09ORklHX1JUMjgwMFBDSV9SVDM1WFg9eQpDT05G
SUdfUlQyODAwUENJX1JUNTNYWD15CkNPTkZJR19SVDI4MDBQQ0lfUlQzMjkwPXkKIyBDT05G
SUdfUlQyNTAwVVNCIGlzIG5vdCBzZXQKIyBDT05GSUdfUlQ3M1VTQiBpcyBub3Qgc2V0CkNP
TkZJR19SVDI4MDBVU0I9eQpDT05GSUdfUlQyODAwVVNCX1JUMzNYWD15CkNPTkZJR19SVDI4
MDBVU0JfUlQzNVhYPXkKQ09ORklHX1JUMjgwMFVTQl9SVDM1NzM9eQpDT05GSUdfUlQyODAw
VVNCX1JUNTNYWD15CkNPTkZJR19SVDI4MDBVU0JfUlQ1NVhYPXkKQ09ORklHX1JUMjgwMFVT
Ql9VTktOT1dOPXkKQ09ORklHX1JUMjgwMF9MSUI9eQpDT05GSUdfUlQyODAwX0xJQl9NTUlP
PXkKQ09ORklHX1JUMlgwMF9MSUJfTU1JTz15CkNPTkZJR19SVDJYMDBfTElCX1BDST15CkNP
TkZJR19SVDJYMDBfTElCX1VTQj15CkNPTkZJR19SVDJYMDBfTElCPXkKQ09ORklHX1JUMlgw
MF9MSUJfRklSTVdBUkU9eQpDT05GSUdfUlQyWDAwX0xJQl9DUllQVE89eQpDT05GSUdfUlQy
WDAwX0xJQl9MRURTPXkKIyBDT05GSUdfUlQyWDAwX0xJQl9ERUJVR0ZTIGlzIG5vdCBzZXQK
IyBDT05GSUdfUlQyWDAwX0RFQlVHIGlzIG5vdCBzZXQKQ09ORklHX1dMQU5fVkVORE9SX1JF
QUxURUs9eQojIENPTkZJR19SVEw4MTgwIGlzIG5vdCBzZXQKQ09ORklHX1JUTDgxODc9eQpD
T05GSUdfUlRMODE4N19MRURTPXkKQ09ORklHX1JUTF9DQVJEUz15CiMgQ09ORklHX1JUTDgx
OTJDRSBpcyBub3Qgc2V0CiMgQ09ORklHX1JUTDgxOTJTRSBpcyBub3Qgc2V0CiMgQ09ORklH
X1JUTDgxOTJERSBpcyBub3Qgc2V0CiMgQ09ORklHX1JUTDg3MjNBRSBpcyBub3Qgc2V0CiMg
Q09ORklHX1JUTDg3MjNCRSBpcyBub3Qgc2V0CiMgQ09ORklHX1JUTDgxODhFRSBpcyBub3Qg
c2V0CiMgQ09ORklHX1JUTDgxOTJFRSBpcyBub3Qgc2V0CiMgQ09ORklHX1JUTDg4MjFBRSBp
cyBub3Qgc2V0CkNPTkZJR19SVEw4MTkyQ1U9eQpDT05GSUdfUlRMV0lGST15CkNPTkZJR19S
VExXSUZJX1VTQj15CiMgQ09ORklHX1JUTFdJRklfREVCVUcgaXMgbm90IHNldApDT05GSUdf
UlRMODE5MkNfQ09NTU9OPXkKIyBDT05GSUdfUlRMOFhYWFUgaXMgbm90IHNldApDT05GSUdf
UlRXODg9eQpDT05GSUdfUlRXODhfQ09SRT15CkNPTkZJR19SVFc4OF9QQ0k9eQpDT05GSUdf
UlRXODhfODgyMkI9eQpDT05GSUdfUlRXODhfODgyMkM9eQpDT05GSUdfUlRXODhfODgyMkJF
PXkKQ09ORklHX1JUVzg4Xzg4MjJDRT15CiMgQ09ORklHX1JUVzg4Xzg3MjNERSBpcyBub3Qg
c2V0CiMgQ09ORklHX1JUVzg4Xzg4MjFDRSBpcyBub3Qgc2V0CkNPTkZJR19SVFc4OF9ERUJV
Rz15CkNPTkZJR19SVFc4OF9ERUJVR0ZTPXkKQ09ORklHX1JUVzg5PXkKQ09ORklHX1JUVzg5
X0NPUkU9eQpDT05GSUdfUlRXODlfUENJPXkKQ09ORklHX1JUVzg5Xzg4NTJBPXkKQ09ORklH
X1JUVzg5Xzg4NTJBRT15CiMgQ09ORklHX1JUVzg5Xzg4NTJCRSBpcyBub3Qgc2V0CiMgQ09O
RklHX1JUVzg5Xzg4NTJDRSBpcyBub3Qgc2V0CkNPTkZJR19SVFc4OV9ERUJVRz15CkNPTkZJ
R19SVFc4OV9ERUJVR01TRz15CkNPTkZJR19SVFc4OV9ERUJVR0ZTPXkKQ09ORklHX1dMQU5f
VkVORE9SX1JTST15CiMgQ09ORklHX1JTSV85MVggaXMgbm90IHNldApDT05GSUdfV0xBTl9W
RU5ET1JfU1Q9eQojIENPTkZJR19DVzEyMDAgaXMgbm90IHNldApDT05GSUdfV0xBTl9WRU5E
T1JfVEk9eQojIENPTkZJR19XTDEyNTEgaXMgbm90IHNldAojIENPTkZJR19XTDEyWFggaXMg
bm90IHNldAojIENPTkZJR19XTDE4WFggaXMgbm90IHNldAojIENPTkZJR19XTENPUkUgaXMg
bm90IHNldApDT05GSUdfV0xBTl9WRU5ET1JfWllEQVM9eQojIENPTkZJR19VU0JfWkQxMjAx
IGlzIG5vdCBzZXQKIyBDT05GSUdfWkQxMjExUlcgaXMgbm90IHNldApDT05GSUdfV0xBTl9W
RU5ET1JfUVVBTlRFTk5BPXkKIyBDT05GSUdfUVRORk1BQ19QQ0lFIGlzIG5vdCBzZXQKIyBD
T05GSUdfSVdMNzAwMCBpcyBub3Qgc2V0CkNPTkZJR19NQUM4MDIxMV9IV1NJTT15CkNPTkZJ
R19VU0JfTkVUX1JORElTX1dMQU49eQojIENPTkZJR19WSVJUX1dJRkkgaXMgbm90IHNldAoK
IwojIEVuYWJsZSBXaU1BWCAoTmV0d29ya2luZyBvcHRpb25zKSB0byBzZWUgdGhlIFdpTUFY
IGRyaXZlcnMKIwojIENPTkZJR19XQU4gaXMgbm90IHNldAoKIwojIFdpcmVsZXNzIFdBTgoj
CiMgQ09ORklHX1dXQU4gaXMgbm90IHNldAojIGVuZCBvZiBXaXJlbGVzcyBXQU4KCiMgQ09O
RklHX1ZNWE5FVDMgaXMgbm90IHNldAojIENPTkZJR19GVUpJVFNVX0VTIGlzIG5vdCBzZXQK
IyBDT05GSUdfTkVUREVWU0lNIGlzIG5vdCBzZXQKQ09ORklHX05FVF9GQUlMT1ZFUj15CiMg
Q09ORklHX0lTRE4gaXMgbm90IHNldAoKIwojIElucHV0IGRldmljZSBzdXBwb3J0CiMKQ09O
RklHX0lOUFVUPXkKQ09ORklHX0lOUFVUX0xFRFM9eQpDT05GSUdfSU5QVVRfRkZfTUVNTEVT
Uz15CiMgQ09ORklHX0lOUFVUX1BPTExERVYgaXMgbm90IHNldApDT05GSUdfSU5QVVRfU1BB
UlNFS01BUD15CkNPTkZJR19JTlBVVF9NQVRSSVhLTUFQPXkKCiMKIyBVc2VybGFuZCBpbnRl
cmZhY2VzCiMKIyBDT05GSUdfSU5QVVRfTU9VU0VERVYgaXMgbm90IHNldApDT05GSUdfSU5Q
VVRfSk9ZREVWPXkKQ09ORklHX0lOUFVUX0VWREVWPXkKIyBDT05GSUdfSU5QVVRfRVZCVUcg
aXMgbm90IHNldAoKIwojIElucHV0IERldmljZSBEcml2ZXJzCiMKQ09ORklHX0lOUFVUX0tF
WUJPQVJEPXkKIyBDT05GSUdfS0VZQk9BUkRfQURDIGlzIG5vdCBzZXQKIyBDT05GSUdfS0VZ
Qk9BUkRfQURQNTU4OCBpcyBub3Qgc2V0CiMgQ09ORklHX0tFWUJPQVJEX0FEUDU1ODkgaXMg
bm90IHNldApDT05GSUdfS0VZQk9BUkRfQVRLQkQ9eQojIENPTkZJR19LRVlCT0FSRF9RVDEw
NTAgaXMgbm90IHNldAojIENPTkZJR19LRVlCT0FSRF9RVDEwNzAgaXMgbm90IHNldAojIENP
TkZJR19LRVlCT0FSRF9RVDIxNjAgaXMgbm90IHNldAojIENPTkZJR19LRVlCT0FSRF9ETElO
S19ESVI2ODUgaXMgbm90IHNldAojIENPTkZJR19LRVlCT0FSRF9MS0tCRCBpcyBub3Qgc2V0
CkNPTkZJR19LRVlCT0FSRF9HUElPPXkKIyBDT05GSUdfS0VZQk9BUkRfR1BJT19QT0xMRUQg
aXMgbm90IHNldAojIENPTkZJR19LRVlCT0FSRF9UQ0E2NDE2IGlzIG5vdCBzZXQKIyBDT05G
SUdfS0VZQk9BUkRfVENBODQxOCBpcyBub3Qgc2V0CiMgQ09ORklHX0tFWUJPQVJEX01BVFJJ
WCBpcyBub3Qgc2V0CiMgQ09ORklHX0tFWUJPQVJEX0xNODMyMyBpcyBub3Qgc2V0CiMgQ09O
RklHX0tFWUJPQVJEX0xNODMzMyBpcyBub3Qgc2V0CiMgQ09ORklHX0tFWUJPQVJEX01BWDcz
NTkgaXMgbm90IHNldAojIENPTkZJR19LRVlCT0FSRF9NQ1MgaXMgbm90IHNldAojIENPTkZJ
R19LRVlCT0FSRF9NUFIxMjEgaXMgbm90IHNldAojIENPTkZJR19LRVlCT0FSRF9ORVdUT04g
aXMgbm90IHNldAojIENPTkZJR19LRVlCT0FSRF9PUEVOQ09SRVMgaXMgbm90IHNldAojIENP
TkZJR19LRVlCT0FSRF9TQU1TVU5HIGlzIG5vdCBzZXQKIyBDT05GSUdfS0VZQk9BUkRfU1RP
V0FXQVkgaXMgbm90IHNldAojIENPTkZJR19LRVlCT0FSRF9TVU5LQkQgaXMgbm90IHNldAoj
IENPTkZJR19LRVlCT0FSRF9PTUFQNCBpcyBub3Qgc2V0CiMgQ09ORklHX0tFWUJPQVJEX1RN
Ml9UT1VDSEtFWSBpcyBub3Qgc2V0CiMgQ09ORklHX0tFWUJPQVJEX1hUS0JEIGlzIG5vdCBz
ZXQKQ09ORklHX0tFWUJPQVJEX0NST1NfRUM9eQojIENPTkZJR19LRVlCT0FSRF9DQVAxMVhY
IGlzIG5vdCBzZXQKIyBDT05GSUdfS0VZQk9BUkRfQkNNIGlzIG5vdCBzZXQKQ09ORklHX0lO
UFVUX01PVVNFPXkKQ09ORklHX01PVVNFX1BTMj15CiMgQ09ORklHX01PVVNFX1BTMl9BTFBT
IGlzIG5vdCBzZXQKQ09ORklHX01PVVNFX1BTMl9CWUQ9eQojIENPTkZJR19NT1VTRV9QUzJf
TE9HSVBTMlBQIGlzIG5vdCBzZXQKIyBDT05GSUdfTU9VU0VfUFMyX1NZTkFQVElDUyBpcyBu
b3Qgc2V0CkNPTkZJR19NT1VTRV9QUzJfU1lOQVBUSUNTX1NNQlVTPXkKIyBDT05GSUdfTU9V
U0VfUFMyX0NZUFJFU1MgaXMgbm90IHNldAojIENPTkZJR19NT1VTRV9QUzJfTElGRUJPT0sg
aXMgbm90IHNldApDT05GSUdfTU9VU0VfUFMyX1RSQUNLUE9JTlQ9eQojIENPTkZJR19NT1VT
RV9QUzJfRUxBTlRFQ0ggaXMgbm90IHNldAojIENPTkZJR19NT1VTRV9QUzJfU0VOVEVMSUMg
aXMgbm90IHNldAojIENPTkZJR19NT1VTRV9QUzJfVE9VQ0hLSVQgaXMgbm90IHNldAojIENP
TkZJR19NT1VTRV9QUzJfRk9DQUxURUNIIGlzIG5vdCBzZXQKIyBDT05GSUdfTU9VU0VfUFMy
X1ZNTU9VU0UgaXMgbm90IHNldApDT05GSUdfTU9VU0VfUFMyX1NNQlVTPXkKIyBDT05GSUdf
TU9VU0VfU0VSSUFMIGlzIG5vdCBzZXQKQ09ORklHX01PVVNFX0FQUExFVE9VQ0g9eQpDT05G
SUdfTU9VU0VfQkNNNTk3ND15CkNPTkZJR19NT1VTRV9DWUFQQT15CkNPTkZJR19NT1VTRV9F
TEFOX0kyQz15CkNPTkZJR19NT1VTRV9FTEFOX0kyQ19JMkM9eQojIENPTkZJR19NT1VTRV9F
TEFOX0kyQ19TTUJVUyBpcyBub3Qgc2V0CiMgQ09ORklHX01PVVNFX1ZTWFhYQUEgaXMgbm90
IHNldAojIENPTkZJR19NT1VTRV9HUElPIGlzIG5vdCBzZXQKIyBDT05GSUdfTU9VU0VfU1lO
QVBUSUNTX0kyQyBpcyBub3Qgc2V0CkNPTkZJR19NT1VTRV9TWU5BUFRJQ1NfVVNCPXkKQ09O
RklHX0lOUFVUX0pPWVNUSUNLPXkKIyBDT05GSUdfSk9ZU1RJQ0tfQU5BTE9HIGlzIG5vdCBz
ZXQKIyBDT05GSUdfSk9ZU1RJQ0tfQTNEIGlzIG5vdCBzZXQKIyBDT05GSUdfSk9ZU1RJQ0tf
QURDIGlzIG5vdCBzZXQKIyBDT05GSUdfSk9ZU1RJQ0tfQURJIGlzIG5vdCBzZXQKIyBDT05G
SUdfSk9ZU1RJQ0tfQ09CUkEgaXMgbm90IHNldAojIENPTkZJR19KT1lTVElDS19HRjJLIGlz
IG5vdCBzZXQKIyBDT05GSUdfSk9ZU1RJQ0tfR1JJUCBpcyBub3Qgc2V0CiMgQ09ORklHX0pP
WVNUSUNLX0dSSVBfTVAgaXMgbm90IHNldAojIENPTkZJR19KT1lTVElDS19HVUlMTEVNT1Qg
aXMgbm90IHNldAojIENPTkZJR19KT1lTVElDS19JTlRFUkFDVCBpcyBub3Qgc2V0CiMgQ09O
RklHX0pPWVNUSUNLX1NJREVXSU5ERVIgaXMgbm90IHNldAojIENPTkZJR19KT1lTVElDS19U
TURDIGlzIG5vdCBzZXQKQ09ORklHX0pPWVNUSUNLX0lGT1JDRT15CkNPTkZJR19KT1lTVElD
S19JRk9SQ0VfVVNCPXkKIyBDT05GSUdfSk9ZU1RJQ0tfSUZPUkNFXzIzMiBpcyBub3Qgc2V0
CiMgQ09ORklHX0pPWVNUSUNLX1dBUlJJT1IgaXMgbm90IHNldAojIENPTkZJR19KT1lTVElD
S19NQUdFTExBTiBpcyBub3Qgc2V0CiMgQ09ORklHX0pPWVNUSUNLX1NQQUNFT1JCIGlzIG5v
dCBzZXQKIyBDT05GSUdfSk9ZU1RJQ0tfU1BBQ0VCQUxMIGlzIG5vdCBzZXQKIyBDT05GSUdf
Sk9ZU1RJQ0tfU1RJTkdFUiBpcyBub3Qgc2V0CiMgQ09ORklHX0pPWVNUSUNLX1RXSURKT1kg
aXMgbm90IHNldAojIENPTkZJR19KT1lTVElDS19aSEVOSFVBIGlzIG5vdCBzZXQKIyBDT05G
SUdfSk9ZU1RJQ0tfQVM1MDExIGlzIG5vdCBzZXQKIyBDT05GSUdfSk9ZU1RJQ0tfSk9ZRFVN
UCBpcyBub3Qgc2V0CkNPTkZJR19KT1lTVElDS19YUEFEPXkKQ09ORklHX0pPWVNUSUNLX1hQ
QURfRkY9eQpDT05GSUdfSk9ZU1RJQ0tfWFBBRF9MRURTPXkKIyBDT05GSUdfSk9ZU1RJQ0tf
UFNYUEFEX1NQSSBpcyBub3Qgc2V0CiMgQ09ORklHX0pPWVNUSUNLX1BYUkMgaXMgbm90IHNl
dAojIENPTkZJR19KT1lTVElDS19GU0lBNkIgaXMgbm90IHNldApDT05GSUdfSU5QVVRfVEFC
TEVUPXkKIyBDT05GSUdfVEFCTEVUX1VTQl9BQ0VDQUQgaXMgbm90IHNldAojIENPTkZJR19U
QUJMRVRfVVNCX0FJUFRFSyBpcyBub3Qgc2V0CiMgQ09ORklHX1RBQkxFVF9VU0JfR1RDTyBp
cyBub3Qgc2V0CiMgQ09ORklHX1RBQkxFVF9VU0JfSEFOV0FORyBpcyBub3Qgc2V0CiMgQ09O
RklHX1RBQkxFVF9VU0JfS0JUQUIgaXMgbm90IHNldAojIENPTkZJR19UQUJMRVRfVVNCX1BF
R0FTVVMgaXMgbm90IHNldAojIENPTkZJR19UQUJMRVRfU0VSSUFMX1dBQ09NNCBpcyBub3Qg
c2V0CkNPTkZJR19JTlBVVF9UT1VDSFNDUkVFTj15CkNPTkZJR19UT1VDSFNDUkVFTl9QUk9Q
RVJUSUVTPXkKIyBDT05GSUdfVE9VQ0hTQ1JFRU5fQURTNzg0NiBpcyBub3Qgc2V0CiMgQ09O
RklHX1RPVUNIU0NSRUVOX0FENzg3NyBpcyBub3Qgc2V0CiMgQ09ORklHX1RPVUNIU0NSRUVO
X0FENzg3OSBpcyBub3Qgc2V0CiMgQ09ORklHX1RPVUNIU0NSRUVOX0FEQyBpcyBub3Qgc2V0
CiMgQ09ORklHX1RPVUNIU0NSRUVOX0FSMTAyMV9JMkMgaXMgbm90IHNldApDT05GSUdfVE9V
Q0hTQ1JFRU5fQVRNRUxfTVhUPXkKIyBDT05GSUdfVE9VQ0hTQ1JFRU5fQVRNRUxfTVhUX1Qz
NyBpcyBub3Qgc2V0CiMgQ09ORklHX1RPVUNIU0NSRUVOX0FVT19QSVhDSVIgaXMgbm90IHNl
dAojIENPTkZJR19UT1VDSFNDUkVFTl9CVTIxMDEzIGlzIG5vdCBzZXQKIyBDT05GSUdfVE9V
Q0hTQ1JFRU5fQlUyMTAyOSBpcyBub3Qgc2V0CiMgQ09ORklHX1RPVUNIU0NSRUVOX0NISVBP
TkVfSUNOODMxOCBpcyBub3Qgc2V0CiMgQ09ORklHX1RPVUNIU0NSRUVOX0NISVBPTkVfSUNO
ODUwNSBpcyBub3Qgc2V0CiMgQ09ORklHX1RPVUNIU0NSRUVOX0NZOENUTUExNDAgaXMgbm90
IHNldAojIENPTkZJR19UT1VDSFNDUkVFTl9DWThDVE1HMTEwIGlzIG5vdCBzZXQKIyBDT05G
SUdfVE9VQ0hTQ1JFRU5fQ1lUVFNQX0NPUkUgaXMgbm90IHNldAojIENPTkZJR19UT1VDSFND
UkVFTl9DWVRUU1A0X0NPUkUgaXMgbm90IHNldAojIENPTkZJR19UT1VDSFNDUkVFTl9EWU5B
UFJPIGlzIG5vdCBzZXQKIyBDT05GSUdfVE9VQ0hTQ1JFRU5fSEFNUFNISVJFIGlzIG5vdCBz
ZXQKIyBDT05GSUdfVE9VQ0hTQ1JFRU5fRUVUSSBpcyBub3Qgc2V0CiMgQ09ORklHX1RPVUNI
U0NSRUVOX0VHQUxBWCBpcyBub3Qgc2V0CiMgQ09ORklHX1RPVUNIU0NSRUVOX0VHQUxBWF9T
RVJJQUwgaXMgbm90IHNldAojIENPTkZJR19UT1VDSFNDUkVFTl9FWEMzMDAwIGlzIG5vdCBz
ZXQKIyBDT05GSUdfVE9VQ0hTQ1JFRU5fRlVKSVRTVSBpcyBub3Qgc2V0CiMgQ09ORklHX1RP
VUNIU0NSRUVOX0dPT0RJWCBpcyBub3Qgc2V0CiMgQ09ORklHX1RPVUNIU0NSRUVOX0hJREVF
UCBpcyBub3Qgc2V0CiMgQ09ORklHX1RPVUNIU0NSRUVOX0lMSTIxMFggaXMgbm90IHNldAoj
IENPTkZJR19UT1VDSFNDUkVFTl9TNlNZNzYxIGlzIG5vdCBzZXQKIyBDT05GSUdfVE9VQ0hT
Q1JFRU5fR1VOWkUgaXMgbm90IHNldAojIENPTkZJR19UT1VDSFNDUkVFTl9FS1RGMjEyNyBp
cyBub3Qgc2V0CkNPTkZJR19UT1VDSFNDUkVFTl9FTEFOPXkKIyBDT05GSUdfVE9VQ0hTQ1JF
RU5fRUxPIGlzIG5vdCBzZXQKIyBDT05GSUdfVE9VQ0hTQ1JFRU5fV0FDT01fVzgwMDEgaXMg
bm90IHNldAojIENPTkZJR19UT1VDSFNDUkVFTl9XQUNPTV9JMkMgaXMgbm90IHNldAojIENP
TkZJR19UT1VDSFNDUkVFTl9NQVgxMTgwMSBpcyBub3Qgc2V0CiMgQ09ORklHX1RPVUNIU0NS
RUVOX01DUzUwMDAgaXMgbm90IHNldAojIENPTkZJR19UT1VDSFNDUkVFTl9NTVMxMTQgaXMg
bm90IHNldApDT05GSUdfVE9VQ0hTQ1JFRU5fTUVMRkFTX01JUDQ9eQojIENPTkZJR19UT1VD
SFNDUkVFTl9NVE9VQ0ggaXMgbm90IHNldAojIENPTkZJR19UT1VDSFNDUkVFTl9JTVg2VUxf
VFNDIGlzIG5vdCBzZXQKIyBDT05GSUdfVE9VQ0hTQ1JFRU5fSU5FWElPIGlzIG5vdCBzZXQK
IyBDT05GSUdfVE9VQ0hTQ1JFRU5fTUs3MTIgaXMgbm90IHNldAojIENPTkZJR19UT1VDSFND
UkVFTl9QRU5NT1VOVCBpcyBub3Qgc2V0CiMgQ09ORklHX1RPVUNIU0NSRUVOX0VEVF9GVDVY
MDYgaXMgbm90IHNldAojIENPTkZJR19UT1VDSFNDUkVFTl9UT1VDSFJJR0hUIGlzIG5vdCBz
ZXQKIyBDT05GSUdfVE9VQ0hTQ1JFRU5fVE9VQ0hXSU4gaXMgbm90IHNldAojIENPTkZJR19U
T1VDSFNDUkVFTl9QSVhDSVIgaXMgbm90IHNldApDT05GSUdfVE9VQ0hTQ1JFRU5fV0RUODdY
WF9JMkM9eQpDT05GSUdfVE9VQ0hTQ1JFRU5fVVNCX0NPTVBPU0lURT15CkNPTkZJR19UT1VD
SFNDUkVFTl9VU0JfRUdBTEFYPXkKQ09ORklHX1RPVUNIU0NSRUVOX1VTQl9QQU5KSVQ9eQpD
T05GSUdfVE9VQ0hTQ1JFRU5fVVNCXzNNPXkKQ09ORklHX1RPVUNIU0NSRUVOX1VTQl9JVE09
eQpDT05GSUdfVE9VQ0hTQ1JFRU5fVVNCX0VUVVJCTz15CkNPTkZJR19UT1VDSFNDUkVFTl9V
U0JfR1VOWkU9eQpDT05GSUdfVE9VQ0hTQ1JFRU5fVVNCX0RNQ19UU0MxMD15CkNPTkZJR19U
T1VDSFNDUkVFTl9VU0JfSVJUT1VDSD15CkNPTkZJR19UT1VDSFNDUkVFTl9VU0JfSURFQUxU
RUs9eQpDT05GSUdfVE9VQ0hTQ1JFRU5fVVNCX0dFTkVSQUxfVE9VQ0g9eQpDT05GSUdfVE9V
Q0hTQ1JFRU5fVVNCX0dPVE9QPXkKQ09ORklHX1RPVUNIU0NSRUVOX1VTQl9KQVNURUM9eQpD
T05GSUdfVE9VQ0hTQ1JFRU5fVVNCX0VMTz15CkNPTkZJR19UT1VDSFNDUkVFTl9VU0JfRTJJ
PXkKQ09ORklHX1RPVUNIU0NSRUVOX1VTQl9aWVRST05JQz15CkNPTkZJR19UT1VDSFNDUkVF
Tl9VU0JfRVRUX1RDNDVVU0I9eQpDT05GSUdfVE9VQ0hTQ1JFRU5fVVNCX05FWElPPXkKQ09O
RklHX1RPVUNIU0NSRUVOX1VTQl9FQVNZVE9VQ0g9eQojIENPTkZJR19UT1VDSFNDUkVFTl9U
T1VDSElUMjEzIGlzIG5vdCBzZXQKIyBDT05GSUdfVE9VQ0hTQ1JFRU5fVFNDX1NFUklPIGlz
IG5vdCBzZXQKIyBDT05GSUdfVE9VQ0hTQ1JFRU5fVFNDMjAwNCBpcyBub3Qgc2V0CiMgQ09O
RklHX1RPVUNIU0NSRUVOX1RTQzIwMDUgaXMgbm90IHNldAojIENPTkZJR19UT1VDSFNDUkVF
Tl9UU0MyMDA3IGlzIG5vdCBzZXQKQ09ORklHX1RPVUNIU0NSRUVOX1JNX1RTPXkKIyBDT05G
SUdfVE9VQ0hTQ1JFRU5fU0lMRUFEIGlzIG5vdCBzZXQKIyBDT05GSUdfVE9VQ0hTQ1JFRU5f
U0lTX0kyQyBpcyBub3Qgc2V0CiMgQ09ORklHX1RPVUNIU0NSRUVOX1NUMTIzMiBpcyBub3Qg
c2V0CiMgQ09ORklHX1RPVUNIU0NSRUVOX1NUTUZUUyBpcyBub3Qgc2V0CiMgQ09ORklHX1RP
VUNIU0NSRUVOX1NVUjQwIGlzIG5vdCBzZXQKIyBDT05GSUdfVE9VQ0hTQ1JFRU5fU1VSRkFD
RTNfU1BJIGlzIG5vdCBzZXQKIyBDT05GSUdfVE9VQ0hTQ1JFRU5fU1g4NjU0IGlzIG5vdCBz
ZXQKIyBDT05GSUdfVE9VQ0hTQ1JFRU5fVFBTNjUwN1ggaXMgbm90IHNldAojIENPTkZJR19U
T1VDSFNDUkVFTl9aRVQ2MjIzIGlzIG5vdCBzZXQKIyBDT05GSUdfVE9VQ0hTQ1JFRU5fWkZP
UkNFIGlzIG5vdCBzZXQKIyBDT05GSUdfVE9VQ0hTQ1JFRU5fUk9ITV9CVTIxMDIzIGlzIG5v
dCBzZXQKIyBDT05GSUdfVE9VQ0hTQ1JFRU5fSVFTNVhYIGlzIG5vdCBzZXQKIyBDT05GSUdf
VE9VQ0hTQ1JFRU5fWklOSVRJWCBpcyBub3Qgc2V0CkNPTkZJR19JTlBVVF9NSVNDPXkKIyBD
T05GSUdfSU5QVVRfQUQ3MTRYIGlzIG5vdCBzZXQKIyBDT05GSUdfSU5QVVRfQVRNRUxfQ0FQ
VE9VQ0ggaXMgbm90IHNldAojIENPTkZJR19JTlBVVF9CTUExNTAgaXMgbm90IHNldAojIENP
TkZJR19JTlBVVF9FM1gwX0JVVFRPTiBpcyBub3Qgc2V0CiMgQ09ORklHX0lOUFVUX01NQTg0
NTAgaXMgbm90IHNldAojIENPTkZJR19JTlBVVF9BUEFORUwgaXMgbm90IHNldAojIENPTkZJ
R19JTlBVVF9HUElPX0JFRVBFUiBpcyBub3Qgc2V0CiMgQ09ORklHX0lOUFVUX0dQSU9fREVD
T0RFUiBpcyBub3Qgc2V0CiMgQ09ORklHX0lOUFVUX0dQSU9fVklCUkEgaXMgbm90IHNldAoj
IENPTkZJR19JTlBVVF9BVExBU19CVE5TIGlzIG5vdCBzZXQKIyBDT05GSUdfSU5QVVRfQVRJ
X1JFTU9URTIgaXMgbm90IHNldAojIENPTkZJR19JTlBVVF9LRVlTUEFOX1JFTU9URSBpcyBu
b3Qgc2V0CiMgQ09ORklHX0lOUFVUX0tYVEo5IGlzIG5vdCBzZXQKIyBDT05GSUdfSU5QVVRf
UE9XRVJNQVRFIGlzIG5vdCBzZXQKIyBDT05GSUdfSU5QVVRfWUVBTElOSyBpcyBub3Qgc2V0
CiMgQ09ORklHX0lOUFVUX0NNMTA5IGlzIG5vdCBzZXQKQ09ORklHX0lOUFVUX1VJTlBVVD15
CiMgQ09ORklHX0lOUFVUX1BDRjg1NzQgaXMgbm90IHNldAojIENPTkZJR19JTlBVVF9HUElP
X1JPVEFSWV9FTkNPREVSIGlzIG5vdCBzZXQKIyBDT05GSUdfSU5QVVRfQURYTDM0WCBpcyBu
b3Qgc2V0CiMgQ09ORklHX0lOUFVUX0lNU19QQ1UgaXMgbm90IHNldAojIENPTkZJR19JTlBV
VF9JUVMyNjlBIGlzIG5vdCBzZXQKIyBDT05GSUdfSU5QVVRfQ01BMzAwMCBpcyBub3Qgc2V0
CiMgQ09ORklHX0lOUFVUX0lERUFQQURfU0xJREVCQVIgaXMgbm90IHNldAojIENPTkZJR19J
TlBVVF9TT0NfQlVUVE9OX0FSUkFZIGlzIG5vdCBzZXQKIyBDT05GSUdfSU5QVVRfRFJWMjYw
WF9IQVBUSUNTIGlzIG5vdCBzZXQKIyBDT05GSUdfSU5QVVRfRFJWMjY2NV9IQVBUSUNTIGlz
IG5vdCBzZXQKIyBDT05GSUdfSU5QVVRfRFJWMjY2N19IQVBUSUNTIGlzIG5vdCBzZXQKQ09O
RklHX1JNSTRfQ09SRT15CiMgQ09ORklHX1JNSTRfSTJDIGlzIG5vdCBzZXQKIyBDT05GSUdf
Uk1JNF9TUEkgaXMgbm90IHNldAojIENPTkZJR19STUk0X1NNQiBpcyBub3Qgc2V0CkNPTkZJ
R19STUk0X0YwMz15CkNPTkZJR19STUk0X0YwM19TRVJJTz15CkNPTkZJR19STUk0XzJEX1NF
TlNPUj15CkNPTkZJR19STUk0X0YxMT15CkNPTkZJR19STUk0X0YxMj15CkNPTkZJR19STUk0
X0YzMD15CiMgQ09ORklHX1JNSTRfRjM0IGlzIG5vdCBzZXQKIyBDT05GSUdfUk1JNF9GM0Eg
aXMgbm90IHNldAojIENPTkZJR19STUk0X0Y1NCBpcyBub3Qgc2V0CiMgQ09ORklHX1JNSTRf
RjU1IGlzIG5vdCBzZXQKCiMKIyBIYXJkd2FyZSBJL08gcG9ydHMKIwpDT05GSUdfU0VSSU89
eQpDT05GSUdfQVJDSF9NSUdIVF9IQVZFX1BDX1NFUklPPXkKQ09ORklHX1NFUklPX0k4MDQy
PXkKIyBDT05GSUdfU0VSSU9fU0VSUE9SVCBpcyBub3Qgc2V0CiMgQ09ORklHX1NFUklPX0NU
ODJDNzEwIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VSSU9fUENJUFMyIGlzIG5vdCBzZXQKQ09O
RklHX1NFUklPX0xJQlBTMj15CiMgQ09ORklHX1NFUklPX1JBVyBpcyBub3Qgc2V0CiMgQ09O
RklHX1NFUklPX0FMVEVSQV9QUzIgaXMgbm90IHNldAojIENPTkZJR19TRVJJT19QUzJNVUxU
IGlzIG5vdCBzZXQKIyBDT05GSUdfU0VSSU9fQVJDX1BTMiBpcyBub3Qgc2V0CiMgQ09ORklH
X1NFUklPX0FQQlBTMiBpcyBub3Qgc2V0CiMgQ09ORklHX1NFUklPX0dQSU9fUFMyIGlzIG5v
dCBzZXQKIyBDT05GSUdfVVNFUklPIGlzIG5vdCBzZXQKIyBDT05GSUdfR0FNRVBPUlQgaXMg
bm90IHNldAojIGVuZCBvZiBIYXJkd2FyZSBJL08gcG9ydHMKIyBlbmQgb2YgSW5wdXQgZGV2
aWNlIHN1cHBvcnQKCiMKIyBDaGFyYWN0ZXIgZGV2aWNlcwojCkNPTkZJR19UVFk9eQpDT05G
SUdfVlQ9eQpDT05GSUdfQ09OU09MRV9UUkFOU0xBVElPTlM9eQpDT05GSUdfVlRfQ09OU09M
RT15CkNPTkZJR19WVF9DT05TT0xFX1NMRUVQPXkKQ09ORklHX0hXX0NPTlNPTEU9eQpDT05G
SUdfVlRfSFdfQ09OU09MRV9CSU5ESU5HPXkKQ09ORklHX1VOSVg5OF9QVFlTPXkKIyBDT05G
SUdfTEVHQUNZX1BUWVMgaXMgbm90IHNldApDT05GSUdfTERJU0NfQVVUT0xPQUQ9eQoKIwoj
IFNlcmlhbCBkcml2ZXJzCiMKQ09ORklHX1NFUklBTF9FQVJMWUNPTj15CkNPTkZJR19TRVJJ
QUxfODI1MD15CkNPTkZJR19TRVJJQUxfODI1MF9ERVBSRUNBVEVEX09QVElPTlM9eQpDT05G
SUdfU0VSSUFMXzgyNTBfUE5QPXkKIyBDT05GSUdfU0VSSUFMXzgyNTBfMTY1NTBBX1ZBUklB
TlRTIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VSSUFMXzgyNTBfRklOVEVLIGlzIG5vdCBzZXQK
Q09ORklHX1NFUklBTF84MjUwX0NPTlNPTEU9eQpDT05GSUdfU0VSSUFMXzgyNTBfRE1BPXkK
Q09ORklHX1NFUklBTF84MjUwX1BDST15CkNPTkZJR19TRVJJQUxfODI1MF9FWEFSPXkKQ09O
RklHX1NFUklBTF84MjUwX05SX1VBUlRTPTQKQ09ORklHX1NFUklBTF84MjUwX1JVTlRJTUVf
VUFSVFM9NAojIENPTkZJR19TRVJJQUxfODI1MF9FWFRFTkRFRCBpcyBub3Qgc2V0CkNPTkZJ
R19TRVJJQUxfODI1MF9EV0xJQj15CiMgQ09ORklHX1NFUklBTF84MjUwX0RXIGlzIG5vdCBz
ZXQKIyBDT05GSUdfU0VSSUFMXzgyNTBfUlQyODhYIGlzIG5vdCBzZXQKQ09ORklHX1NFUklB
TF84MjUwX0xQU1M9eQpDT05GSUdfU0VSSUFMXzgyNTBfTUlEPXkKIyBDT05GSUdfU0VSSUFM
X09GX1BMQVRGT1JNIGlzIG5vdCBzZXQKCiMKIyBOb24tODI1MCBzZXJpYWwgcG9ydCBzdXBw
b3J0CiMKIyBDT05GSUdfU0VSSUFMX01BWDMxMDAgaXMgbm90IHNldAojIENPTkZJR19TRVJJ
QUxfTUFYMzEwWCBpcyBub3Qgc2V0CiMgQ09ORklHX1NFUklBTF9VQVJUTElURSBpcyBub3Qg
c2V0CkNPTkZJR19TRVJJQUxfQ09SRT15CkNPTkZJR19TRVJJQUxfQ09SRV9DT05TT0xFPXkK
IyBDT05GSUdfU0VSSUFMX0pTTSBpcyBub3Qgc2V0CiMgQ09ORklHX1NFUklBTF9TSUZJVkUg
aXMgbm90IHNldAojIENPTkZJR19TRVJJQUxfTEFOVElRIGlzIG5vdCBzZXQKIyBDT05GSUdf
U0VSSUFMX1NDQ05YUCBpcyBub3Qgc2V0CiMgQ09ORklHX1NFUklBTF9TQzE2SVM3WFggaXMg
bm90IHNldAojIENPTkZJR19TRVJJQUxfQUxURVJBX0pUQUdVQVJUIGlzIG5vdCBzZXQKIyBD
T05GSUdfU0VSSUFMX0FMVEVSQV9VQVJUIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VSSUFMX0lG
WDZYNjAgaXMgbm90IHNldAojIENPTkZJR19TRVJJQUxfWElMSU5YX1BTX1VBUlQgaXMgbm90
IHNldAojIENPTkZJR19TRVJJQUxfQVJDIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VSSUFMX1JQ
MiBpcyBub3Qgc2V0CiMgQ09ORklHX1NFUklBTF9GU0xfTFBVQVJUIGlzIG5vdCBzZXQKIyBD
T05GSUdfU0VSSUFMX0ZTTF9MSU5GTEVYVUFSVCBpcyBub3Qgc2V0CiMgQ09ORklHX1NFUklB
TF9DT05FWEFOVF9ESUdJQ09MT1IgaXMgbm90IHNldAojIENPTkZJR19TRVJJQUxfU1BSRCBp
cyBub3Qgc2V0CiMgZW5kIG9mIFNlcmlhbCBkcml2ZXJzCgpDT05GSUdfU0VSSUFMX01DVFJM
X0dQSU89eQojIENPTkZJR19TRVJJQUxfTk9OU1RBTkRBUkQgaXMgbm90IHNldAojIENPTkZJ
R19OX0dTTSBpcyBub3Qgc2V0CiMgQ09ORklHX05PWk9NSSBpcyBub3Qgc2V0CiMgQ09ORklH
X1RSQUNFX1NJTksgaXMgbm90IHNldApDT05GSUdfSFZDX0RSSVZFUj15CiMgQ09ORklHX1NF
UklBTF9ERVZfQlVTIGlzIG5vdCBzZXQKIyBDT05GSUdfVFRZX1BSSU5USyBpcyBub3Qgc2V0
CkNPTkZJR19WSVJUSU9fQ09OU09MRT15CiMgQ09ORklHX0lQTUlfSEFORExFUiBpcyBub3Qg
c2V0CkNPTkZJR19IV19SQU5ET009eQojIENPTkZJR19IV19SQU5ET01fVElNRVJJT01FTSBp
cyBub3Qgc2V0CiMgQ09ORklHX0hXX1JBTkRPTV9JTlRFTCBpcyBub3Qgc2V0CiMgQ09ORklH
X0hXX1JBTkRPTV9BTUQgaXMgbm90IHNldAojIENPTkZJR19IV19SQU5ET01fQkE0MzEgaXMg
bm90IHNldAojIENPTkZJR19IV19SQU5ET01fVklBIGlzIG5vdCBzZXQKQ09ORklHX0hXX1JB
TkRPTV9WSVJUSU89eQojIENPTkZJR19IV19SQU5ET01fQ0NUUk5HIGlzIG5vdCBzZXQKIyBD
T05GSUdfSFdfUkFORE9NX1hJUEhFUkEgaXMgbm90IHNldAojIENPTkZJR19BUFBMSUNPTSBp
cyBub3Qgc2V0CiMgQ09ORklHX01XQVZFIGlzIG5vdCBzZXQKIyBDT05GSUdfREVWTUVNIGlz
IG5vdCBzZXQKIyBDT05GSUdfREVWS01FTSBpcyBub3Qgc2V0CkNPTkZJR19OVlJBTT15CiMg
Q09ORklHX1JBV19EUklWRVIgaXMgbm90IHNldAojIENPTkZJR19ERVZQT1JUIGlzIG5vdCBz
ZXQKQ09ORklHX0hQRVQ9eQojIENPTkZJR19IUEVUX01NQVAgaXMgbm90IHNldAojIENPTkZJ
R19IQU5HQ0hFQ0tfVElNRVIgaXMgbm90IHNldApDT05GSUdfVENHX1RQTT15CkNPTkZJR19I
V19SQU5ET01fVFBNPXkKQ09ORklHX1RDR19USVNfQ09SRT15CkNPTkZJR19UQ0dfVElTPXkK
Q09ORklHX1RDR19USVNfU1BJPXkKQ09ORklHX1RDR19USVNfU1BJX0NSNTA9eQojIENPTkZJ
R19UQ0dfVElTX0kyQ19BVE1FTCBpcyBub3Qgc2V0CiMgQ09ORklHX1RDR19USVNfSTJDX0lO
RklORU9OIGlzIG5vdCBzZXQKIyBDT05GSUdfVENHX1RJU19JMkNfTlVWT1RPTiBpcyBub3Qg
c2V0CiMgQ09ORklHX1RDR19OU0MgaXMgbm90IHNldAojIENPTkZJR19UQ0dfQVRNRUwgaXMg
bm90IHNldAojIENPTkZJR19UQ0dfQ1I1MF9JMkMgaXMgbm90IHNldAojIENPTkZJR19UQ0df
SU5GSU5FT04gaXMgbm90IHNldAojIENPTkZJR19UQ0dfQ1JCIGlzIG5vdCBzZXQKIyBDT05G
SUdfVENHX1ZUUE1fUFJPWFkgaXMgbm90IHNldAojIENPTkZJR19UQ0dfVklSVElPX1ZUUE0g
aXMgbm90IHNldAojIENPTkZJR19UQ0dfVElTX1NUMzNaUDI0X0kyQyBpcyBub3Qgc2V0CiMg
Q09ORklHX1RDR19USVNfU1QzM1pQMjRfU1BJIGlzIG5vdCBzZXQKIyBDT05GSUdfVEVMQ0xP
Q0sgaXMgbm90IHNldAojIENPTkZJR19YSUxMWUJVUyBpcyBub3Qgc2V0CkNPTkZJR19SQU5E
T01fVFJVU1RfQ1BVPXkKQ09ORklHX1JBTkRPTV9UUlVTVF9CT09UTE9BREVSPXkKIyBlbmQg
b2YgQ2hhcmFjdGVyIGRldmljZXMKCiMKIyBJMkMgc3VwcG9ydAojCkNPTkZJR19JMkM9eQpD
T05GSUdfQUNQSV9JMkNfT1BSRUdJT049eQpDT05GSUdfSTJDX0JPQVJESU5GTz15CkNPTkZJ
R19JMkNfQ09NUEFUPXkKQ09ORklHX0kyQ19DSEFSREVWPXkKQ09ORklHX0kyQ19NVVg9eQoK
IwojIE11bHRpcGxleGVyIEkyQyBDaGlwIHN1cHBvcnQKIwojIENPTkZJR19JMkNfQVJCX0dQ
SU9fQ0hBTExFTkdFIGlzIG5vdCBzZXQKIyBDT05GSUdfSTJDX01VWF9HUElPIGlzIG5vdCBz
ZXQKIyBDT05GSUdfSTJDX01VWF9HUE1VWCBpcyBub3Qgc2V0CiMgQ09ORklHX0kyQ19NVVhf
TFRDNDMwNiBpcyBub3Qgc2V0CiMgQ09ORklHX0kyQ19NVVhfUENBOTU0MSBpcyBub3Qgc2V0
CiMgQ09ORklHX0kyQ19NVVhfUENBOTU0eCBpcyBub3Qgc2V0CiMgQ09ORklHX0kyQ19NVVhf
UElOQ1RSTCBpcyBub3Qgc2V0CiMgQ09ORklHX0kyQ19NVVhfUkVHIGlzIG5vdCBzZXQKIyBD
T05GSUdfSTJDX0RFTVVYX1BJTkNUUkwgaXMgbm90IHNldAojIENPTkZJR19JMkNfTVVYX01M
WENQTEQgaXMgbm90IHNldAojIGVuZCBvZiBNdWx0aXBsZXhlciBJMkMgQ2hpcCBzdXBwb3J0
CgpDT05GSUdfSTJDX0hFTFBFUl9BVVRPPXkKQ09ORklHX0kyQ19TTUJVUz15CkNPTkZJR19J
MkNfQUxHT0JJVD15CgojCiMgSTJDIEhhcmR3YXJlIEJ1cyBzdXBwb3J0CiMKCiMKIyBQQyBT
TUJ1cyBob3N0IGNvbnRyb2xsZXIgZHJpdmVycwojCiMgQ09ORklHX0kyQ19BTEkxNTM1IGlz
IG5vdCBzZXQKIyBDT05GSUdfSTJDX0FMSTE1NjMgaXMgbm90IHNldAojIENPTkZJR19JMkNf
QUxJMTVYMyBpcyBub3Qgc2V0CiMgQ09ORklHX0kyQ19BTUQ3NTYgaXMgbm90IHNldAojIENP
TkZJR19JMkNfQU1EODExMSBpcyBub3Qgc2V0CiMgQ09ORklHX0kyQ19BTURfTVAyIGlzIG5v
dCBzZXQKQ09ORklHX0kyQ19JODAxPXkKIyBDT05GSUdfSTJDX0lTQ0ggaXMgbm90IHNldAoj
IENPTkZJR19JMkNfSVNNVCBpcyBub3Qgc2V0CkNPTkZJR19JMkNfUElJWDQ9eQojIENPTkZJ
R19JMkNfTkZPUkNFMiBpcyBub3Qgc2V0CiMgQ09ORklHX0kyQ19OVklESUFfR1BVIGlzIG5v
dCBzZXQKIyBDT05GSUdfSTJDX1NJUzU1OTUgaXMgbm90IHNldAojIENPTkZJR19JMkNfU0lT
NjMwIGlzIG5vdCBzZXQKIyBDT05GSUdfSTJDX1NJUzk2WCBpcyBub3Qgc2V0CiMgQ09ORklH
X0kyQ19WSUEgaXMgbm90IHNldAojIENPTkZJR19JMkNfVklBUFJPIGlzIG5vdCBzZXQKCiMK
IyBBQ1BJIGRyaXZlcnMKIwojIENPTkZJR19JMkNfU0NNSSBpcyBub3Qgc2V0CgojCiMgSTJD
IHN5c3RlbSBidXMgZHJpdmVycyAobW9zdGx5IGVtYmVkZGVkIC8gc3lzdGVtLW9uLWNoaXAp
CiMKIyBDT05GSUdfSTJDX0NCVVNfR1BJTyBpcyBub3Qgc2V0CkNPTkZJR19JMkNfREVTSUdO
V0FSRV9DT1JFPXkKIyBDT05GSUdfSTJDX0RFU0lHTldBUkVfU0xBVkUgaXMgbm90IHNldApD
T05GSUdfSTJDX0RFU0lHTldBUkVfUExBVEZPUk09eQojIENPTkZJR19JMkNfREVTSUdOV0FS
RV9BTURQU1AgaXMgbm90IHNldAojIENPTkZJR19JMkNfREVTSUdOV0FSRV9CQVlUUkFJTCBp
cyBub3Qgc2V0CkNPTkZJR19JMkNfREVTSUdOV0FSRV9QQ0k9eQojIENPTkZJR19JMkNfRU1F
VjIgaXMgbm90IHNldAojIENPTkZJR19JMkNfR1BJTyBpcyBub3Qgc2V0CiMgQ09ORklHX0ky
Q19PQ09SRVMgaXMgbm90IHNldAojIENPTkZJR19JMkNfUENBX1BMQVRGT1JNIGlzIG5vdCBz
ZXQKIyBDT05GSUdfSTJDX1JLM1ggaXMgbm90IHNldAojIENPTkZJR19JMkNfU0lNVEVDIGlz
IG5vdCBzZXQKIyBDT05GSUdfSTJDX1hJTElOWCBpcyBub3Qgc2V0CgojCiMgRXh0ZXJuYWwg
STJDL1NNQnVzIGFkYXB0ZXIgZHJpdmVycwojCiMgQ09ORklHX0kyQ19ESU9MQU5fVTJDIGlz
IG5vdCBzZXQKIyBDT05GSUdfSTJDX1JPQk9URlVaWl9PU0lGIGlzIG5vdCBzZXQKIyBDT05G
SUdfSTJDX1RBT1NfRVZNIGlzIG5vdCBzZXQKIyBDT05GSUdfSTJDX1RJTllfVVNCIGlzIG5v
dCBzZXQKCiMKIyBPdGhlciBJMkMvU01CdXMgYnVzIGRyaXZlcnMKIwojIENPTkZJR19JMkNf
TUxYQ1BMRCBpcyBub3Qgc2V0CkNPTkZJR19JMkNfQ1JPU19FQ19UVU5ORUw9eQojIGVuZCBv
ZiBJMkMgSGFyZHdhcmUgQnVzIHN1cHBvcnQKCiMgQ09ORklHX0kyQ19TVFVCIGlzIG5vdCBz
ZXQKIyBDT05GSUdfSTJDX1NMQVZFIGlzIG5vdCBzZXQKIyBDT05GSUdfSTJDX0RFQlVHX0NP
UkUgaXMgbm90IHNldAojIENPTkZJR19JMkNfREVCVUdfQUxHTyBpcyBub3Qgc2V0CiMgQ09O
RklHX0kyQ19ERUJVR19CVVMgaXMgbm90IHNldAojIGVuZCBvZiBJMkMgc3VwcG9ydAoKIyBD
T05GSUdfSTNDIGlzIG5vdCBzZXQKQ09ORklHX1NQST15CiMgQ09ORklHX1NQSV9ERUJVRyBp
cyBub3Qgc2V0CkNPTkZJR19TUElfTUFTVEVSPXkKIyBDT05GSUdfU1BJX01FTSBpcyBub3Qg
c2V0CgojCiMgU1BJIE1hc3RlciBDb250cm9sbGVyIERyaXZlcnMKIwojIENPTkZJR19TUElf
QUxURVJBIGlzIG5vdCBzZXQKIyBDT05GSUdfU1BJX0FYSV9TUElfRU5HSU5FIGlzIG5vdCBz
ZXQKQ09ORklHX1NQSV9CSVRCQU5HPXkKIyBDT05GSUdfU1BJX0NBREVOQ0UgaXMgbm90IHNl
dAojIENPTkZJR19TUElfREVTSUdOV0FSRSBpcyBub3Qgc2V0CiMgQ09ORklHX1NQSV9OWFBf
RkxFWFNQSSBpcyBub3Qgc2V0CiMgQ09ORklHX1NQSV9HUElPIGlzIG5vdCBzZXQKIyBDT05G
SUdfU1BJX0ZTTF9TUEkgaXMgbm90IHNldAojIENPTkZJR19TUElfTEFOVElRX1NTQyBpcyBu
b3Qgc2V0CiMgQ09ORklHX1NQSV9PQ19USU5ZIGlzIG5vdCBzZXQKQ09ORklHX1NQSV9QWEEy
WFg9eQpDT05GSUdfU1BJX1BYQTJYWF9QQ0k9eQojIENPTkZJR19TUElfUk9DS0NISVAgaXMg
bm90IHNldAojIENPTkZJR19TUElfU0MxOElTNjAyIGlzIG5vdCBzZXQKIyBDT05GSUdfU1BJ
X1NJRklWRSBpcyBub3Qgc2V0CiMgQ09ORklHX1NQSV9NWElDIGlzIG5vdCBzZXQKIyBDT05G
SUdfU1BJX1hDT01NIGlzIG5vdCBzZXQKIyBDT05GSUdfU1BJX1hJTElOWCBpcyBub3Qgc2V0
CiMgQ09ORklHX1NQSV9aWU5RTVBfR1FTUEkgaXMgbm90IHNldAojIENPTkZJR19TUElfQU1E
IGlzIG5vdCBzZXQKCiMKIyBTUEkgTXVsdGlwbGV4ZXIgc3VwcG9ydAojCiMgQ09ORklHX1NQ
SV9NVVggaXMgbm90IHNldAoKIwojIFNQSSBQcm90b2NvbCBNYXN0ZXJzCiMKQ09ORklHX1NQ
SV9TUElERVY9eQojIENPTkZJR19TUElfTE9PUEJBQ0tfVEVTVCBpcyBub3Qgc2V0CiMgQ09O
RklHX1NQSV9UTEU2MlgwIGlzIG5vdCBzZXQKIyBDT05GSUdfU1BJX1NMQVZFIGlzIG5vdCBz
ZXQKQ09ORklHX1NQSV9EWU5BTUlDPXkKIyBDT05GSUdfU1BNSSBpcyBub3Qgc2V0CiMgQ09O
RklHX0hTSSBpcyBub3Qgc2V0CkNPTkZJR19QUFM9eQojIENPTkZJR19QUFNfREVCVUcgaXMg
bm90IHNldAoKIwojIFBQUyBjbGllbnRzIHN1cHBvcnQKIwojIENPTkZJR19QUFNfQ0xJRU5U
X0tUSU1FUiBpcyBub3Qgc2V0CiMgQ09ORklHX1BQU19DTElFTlRfTERJU0MgaXMgbm90IHNl
dAojIENPTkZJR19QUFNfQ0xJRU5UX0dQSU8gaXMgbm90IHNldAoKIwojIFBQUyBnZW5lcmF0
b3JzIHN1cHBvcnQKIwoKIwojIFBUUCBjbG9jayBzdXBwb3J0CiMKQ09ORklHX1BUUF8xNTg4
X0NMT0NLPXkKCiMKIyBFbmFibGUgUEhZTElCIGFuZCBORVRXT1JLX1BIWV9USU1FU1RBTVBJ
TkcgdG8gc2VlIHRoZSBhZGRpdGlvbmFsIGNsb2Nrcy4KIwpDT05GSUdfUFRQXzE1ODhfQ0xP
Q0tfS1ZNPXkKIyBDT05GSUdfUFRQXzE1ODhfQ0xPQ0tfSURUODJQMzMgaXMgbm90IHNldAoj
IENPTkZJR19QVFBfMTU4OF9DTE9DS19JRFRDTSBpcyBub3Qgc2V0CiMgQ09ORklHX1BUUF8x
NTg4X0NMT0NLX1ZNVyBpcyBub3Qgc2V0CiMgZW5kIG9mIFBUUCBjbG9jayBzdXBwb3J0CgpD
T05GSUdfUElOQ1RSTD15CkNPTkZJR19QSU5NVVg9eQpDT05GSUdfUElOQ09ORj15CkNPTkZJ
R19HRU5FUklDX1BJTkNPTkY9eQojIENPTkZJR19ERUJVR19QSU5DVFJMIGlzIG5vdCBzZXQK
Q09ORklHX1BJTkNUUkxfQU1EPXkKIyBDT05GSUdfUElOQ1RSTF9NQ1AyM1MwOCBpcyBub3Qg
c2V0CiMgQ09ORklHX1BJTkNUUkxfU0lOR0xFIGlzIG5vdCBzZXQKIyBDT05GSUdfUElOQ1RS
TF9TWDE1MFggaXMgbm90IHNldAojIENPTkZJR19QSU5DVFJMX1NUTUZYIGlzIG5vdCBzZXQK
IyBDT05GSUdfUElOQ1RSTF9PQ0VMT1QgaXMgbm90IHNldApDT05GSUdfUElOQ1RSTF9CQVlU
UkFJTD15CkNPTkZJR19QSU5DVFJMX0NIRVJSWVZJRVc9eQojIENPTkZJR19QSU5DVFJMX0xZ
TlhQT0lOVCBpcyBub3Qgc2V0CkNPTkZJR19QSU5DVFJMX0lOVEVMPXkKIyBDT05GSUdfUElO
Q1RSTF9BTERFUkxBS0UgaXMgbm90IHNldApDT05GSUdfUElOQ1RSTF9CUk9YVE9OPXkKQ09O
RklHX1BJTkNUUkxfQ0FOTk9OTEFLRT15CiMgQ09ORklHX1BJTkNUUkxfQ0VEQVJGT1JLIGlz
IG5vdCBzZXQKIyBDT05GSUdfUElOQ1RSTF9ERU5WRVJUT04gaXMgbm90IHNldAojIENPTkZJ
R19QSU5DVFJMX0VNTUlUU0JVUkcgaXMgbm90IHNldApDT05GSUdfUElOQ1RSTF9HRU1JTklM
QUtFPXkKQ09ORklHX1BJTkNUUkxfSUNFTEFLRT15CiMgQ09ORklHX1BJTkNUUkxfSkFTUEVS
TEFLRSBpcyBub3Qgc2V0CiMgQ09ORklHX1BJTkNUUkxfTEVXSVNCVVJHIGlzIG5vdCBzZXQK
Q09ORklHX1BJTkNUUkxfU1VOUklTRVBPSU5UPXkKQ09ORklHX1BJTkNUUkxfVElHRVJMQUtF
PXkKCiMKIyBSZW5lc2FzIHBpbmN0cmwgZHJpdmVycwojCiMgZW5kIG9mIFJlbmVzYXMgcGlu
Y3RybCBkcml2ZXJzCgojIENPTkZJR19QSU5DVFJMX0VRVUlMSUJSSVVNIGlzIG5vdCBzZXQK
Q09ORklHX0dQSU9MSUI9eQpDT05GSUdfR1BJT0xJQl9GQVNUUEFUSF9MSU1JVD01MTIKQ09O
RklHX09GX0dQSU89eQpDT05GSUdfR1BJT19BQ1BJPXkKQ09ORklHX0dQSU9MSUJfSVJRQ0hJ
UD15CkNPTkZJR19ERUJVR19HUElPPXkKQ09ORklHX0dQSU9fU1lTRlM9eQpDT05GSUdfR1BJ
T19DREVWPXkKQ09ORklHX0dQSU9fQ0RFVl9WMT15CgojCiMgTWVtb3J5IG1hcHBlZCBHUElP
IGRyaXZlcnMKIwojIENPTkZJR19HUElPXzc0WFhfTU1JTyBpcyBub3Qgc2V0CiMgQ09ORklH
X0dQSU9fQUxURVJBIGlzIG5vdCBzZXQKIyBDT05GSUdfR1BJT19BTURQVCBpcyBub3Qgc2V0
CiMgQ09ORklHX0dQSU9fQ0FERU5DRSBpcyBub3Qgc2V0CiMgQ09ORklHX0dQSU9fRFdBUEIg
aXMgbm90IHNldAojIENPTkZJR19HUElPX0VYQVIgaXMgbm90IHNldAojIENPTkZJR19HUElP
X0ZUR1BJTzAxMCBpcyBub3Qgc2V0CiMgQ09ORklHX0dQSU9fR0VORVJJQ19QTEFURk9STSBp
cyBub3Qgc2V0CiMgQ09ORklHX0dQSU9fR1JHUElPIGlzIG5vdCBzZXQKIyBDT05GSUdfR1BJ
T19ITFdEIGlzIG5vdCBzZXQKIyBDT05GSUdfR1BJT19JQ0ggaXMgbm90IHNldAojIENPTkZJ
R19HUElPX01CODZTN1ggaXMgbm90IHNldAojIENPTkZJR19HUElPX1NJRklWRSBpcyBub3Qg
c2V0CiMgQ09ORklHX0dQSU9fVlg4NTUgaXMgbm90IHNldAojIENPTkZJR19HUElPX1hJTElO
WCBpcyBub3Qgc2V0CiMgQ09ORklHX0dQSU9fQU1EX0ZDSCBpcyBub3Qgc2V0CiMgZW5kIG9m
IE1lbW9yeSBtYXBwZWQgR1BJTyBkcml2ZXJzCgojCiMgUG9ydC1tYXBwZWQgSS9PIEdQSU8g
ZHJpdmVycwojCiMgQ09ORklHX0dQSU9fRjcxODhYIGlzIG5vdCBzZXQKIyBDT05GSUdfR1BJ
T19JVDg3IGlzIG5vdCBzZXQKIyBDT05GSUdfR1BJT19TQ0ggaXMgbm90IHNldAojIENPTkZJ
R19HUElPX1NDSDMxMVggaXMgbm90IHNldAojIENPTkZJR19HUElPX1dJTkJPTkQgaXMgbm90
IHNldAojIENPTkZJR19HUElPX1dTMTZDNDggaXMgbm90IHNldAojIGVuZCBvZiBQb3J0LW1h
cHBlZCBJL08gR1BJTyBkcml2ZXJzCgojCiMgSTJDIEdQSU8gZXhwYW5kZXJzCiMKIyBDT05G
SUdfR1BJT19BRFA1NTg4IGlzIG5vdCBzZXQKIyBDT05GSUdfR1BJT19BRE5QIGlzIG5vdCBz
ZXQKIyBDT05GSUdfR1BJT19HV19QTEQgaXMgbm90IHNldAojIENPTkZJR19HUElPX01BWDcz
MDAgaXMgbm90IHNldAojIENPTkZJR19HUElPX01BWDczMlggaXMgbm90IHNldAojIENPTkZJ
R19HUElPX1BDQTk1M1ggaXMgbm90IHNldAojIENPTkZJR19HUElPX1BDQTk1NzAgaXMgbm90
IHNldAojIENPTkZJR19HUElPX1BDRjg1N1ggaXMgbm90IHNldAojIENPTkZJR19HUElPX1RQ
SUMyODEwIGlzIG5vdCBzZXQKIyBlbmQgb2YgSTJDIEdQSU8gZXhwYW5kZXJzCgojCiMgTUZE
IEdQSU8gZXhwYW5kZXJzCiMKIyBlbmQgb2YgTUZEIEdQSU8gZXhwYW5kZXJzCgojCiMgUENJ
IEdQSU8gZXhwYW5kZXJzCiMKIyBDT05GSUdfR1BJT19BTUQ4MTExIGlzIG5vdCBzZXQKIyBD
T05GSUdfR1BJT19CVDhYWCBpcyBub3Qgc2V0CiMgQ09ORklHX0dQSU9fTUxfSU9IIGlzIG5v
dCBzZXQKIyBDT05GSUdfR1BJT19QQ0lfSURJT18xNiBpcyBub3Qgc2V0CiMgQ09ORklHX0dQ
SU9fUENJRV9JRElPXzI0IGlzIG5vdCBzZXQKIyBDT05GSUdfR1BJT19SREMzMjFYIGlzIG5v
dCBzZXQKIyBDT05GSUdfR1BJT19TT0RBVklMTEUgaXMgbm90IHNldAojIGVuZCBvZiBQQ0kg
R1BJTyBleHBhbmRlcnMKCiMKIyBTUEkgR1BJTyBleHBhbmRlcnMKIwojIENPTkZJR19HUElP
Xzc0WDE2NCBpcyBub3Qgc2V0CiMgQ09ORklHX0dQSU9fTUFYMzE5MVggaXMgbm90IHNldAoj
IENPTkZJR19HUElPX01BWDczMDEgaXMgbm90IHNldAojIENPTkZJR19HUElPX01DMzM4ODAg
aXMgbm90IHNldAojIENPTkZJR19HUElPX1BJU09TUiBpcyBub3Qgc2V0CiMgQ09ORklHX0dQ
SU9fWFJBMTQwMyBpcyBub3Qgc2V0CiMgZW5kIG9mIFNQSSBHUElPIGV4cGFuZGVycwoKIwoj
IFVTQiBHUElPIGV4cGFuZGVycwojCiMgZW5kIG9mIFVTQiBHUElPIGV4cGFuZGVycwoKIyBD
T05GSUdfR1BJT19BR0dSRUdBVE9SIGlzIG5vdCBzZXQKIyBDT05GSUdfR1BJT19NT0NLVVAg
aXMgbm90IHNldAojIENPTkZJR19XMSBpcyBub3Qgc2V0CiMgQ09ORklHX1BPV0VSX1JFU0VU
IGlzIG5vdCBzZXQKQ09ORklHX1BPV0VSX1NVUFBMWT15CiMgQ09ORklHX1BPV0VSX1NVUFBM
WV9ERUJVRyBpcyBub3Qgc2V0CkNPTkZJR19QT1dFUl9TVVBQTFlfSFdNT049eQojIENPTkZJ
R19QREFfUE9XRVIgaXMgbm90IHNldAojIENPTkZJR19HRU5FUklDX0FEQ19CQVRURVJZIGlz
IG5vdCBzZXQKIyBDT05GSUdfVEVTVF9QT1dFUiBpcyBub3Qgc2V0CiMgQ09ORklHX0NIQVJH
RVJfQURQNTA2MSBpcyBub3Qgc2V0CiMgQ09ORklHX0JBVFRFUllfQ1cyMDE1IGlzIG5vdCBz
ZXQKIyBDT05GSUdfQkFUVEVSWV9EUzI3ODAgaXMgbm90IHNldAojIENPTkZJR19CQVRURVJZ
X0RTMjc4MSBpcyBub3Qgc2V0CiMgQ09ORklHX0JBVFRFUllfRFMyNzgyIGlzIG5vdCBzZXQK
Q09ORklHX0JBVFRFUllfU0JTPXkKIyBDT05GSUdfQ0hBUkdFUl9TQlMgaXMgbm90IHNldAoj
IENPTkZJR19NQU5BR0VSX1NCUyBpcyBub3Qgc2V0CiMgQ09ORklHX0JBVFRFUllfQlEyN1hY
WCBpcyBub3Qgc2V0CiMgQ09ORklHX0JBVFRFUllfTUFYMTcwNDAgaXMgbm90IHNldAojIENP
TkZJR19CQVRURVJZX01BWDE3MDQyIGlzIG5vdCBzZXQKIyBDT05GSUdfQ0hBUkdFUl9NQVg4
OTAzIGlzIG5vdCBzZXQKIyBDT05GSUdfQ0hBUkdFUl9MUDg3MjcgaXMgbm90IHNldAojIENP
TkZJR19DSEFSR0VSX0dQSU8gaXMgbm90IHNldAojIENPTkZJR19DSEFSR0VSX0xUMzY1MSBp
cyBub3Qgc2V0CiMgQ09ORklHX0NIQVJHRVJfREVURUNUT1JfTUFYMTQ2NTYgaXMgbm90IHNl
dAojIENPTkZJR19DSEFSR0VSX0JRMjQxNVggaXMgbm90IHNldAojIENPTkZJR19DSEFSR0VS
X0JRMjQyNTcgaXMgbm90IHNldAojIENPTkZJR19DSEFSR0VSX0JRMjQ3MzUgaXMgbm90IHNl
dAojIENPTkZJR19DSEFSR0VSX0JRMjUxNVggaXMgbm90IHNldAojIENPTkZJR19DSEFSR0VS
X0JRMjU4OTAgaXMgbm90IHNldAojIENPTkZJR19DSEFSR0VSX0JRMjU5ODAgaXMgbm90IHNl
dAojIENPTkZJR19DSEFSR0VSX1NNQjM0NyBpcyBub3Qgc2V0CiMgQ09ORklHX0JBVFRFUllf
R0FVR0VfTFRDMjk0MSBpcyBub3Qgc2V0CiMgQ09ORklHX0JBVFRFUllfUlQ1MDMzIGlzIG5v
dCBzZXQKIyBDT05GSUdfQ0hBUkdFUl9SVDk0NTUgaXMgbm90IHNldApDT05GSUdfQ0hBUkdF
Ul9DUk9TX1VTQlBEPXkKQ09ORklHX0NIQVJHRVJfQ1JPU19QQ0hHPXkKIyBDT05GSUdfQ0hB
UkdFUl9CRDk5OTU0IGlzIG5vdCBzZXQKQ09ORklHX0hXTU9OPXkKIyBDT05GSUdfSFdNT05f
REVCVUdfQ0hJUCBpcyBub3Qgc2V0CgojCiMgTmF0aXZlIGRyaXZlcnMKIwojIENPTkZJR19T
RU5TT1JTX0FCSVRVR1VSVSBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfQUJJVFVHVVJV
MyBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfQUQ3MzE0IGlzIG5vdCBzZXQKIyBDT05G
SUdfU0VOU09SU19BRDc0MTQgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX0FENzQxOCBp
cyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfQURNMTAyMSBpcyBub3Qgc2V0CiMgQ09ORklH
X1NFTlNPUlNfQURNMTAyNSBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfQURNMTAyNiBp
cyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfQURNMTAyOSBpcyBub3Qgc2V0CiMgQ09ORklH
X1NFTlNPUlNfQURNMTAzMSBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfQURNMTE3NyBp
cyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfQURNOTI0MCBpcyBub3Qgc2V0CiMgQ09ORklH
X1NFTlNPUlNfQURUNzMxMCBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfQURUNzQxMCBp
cyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfQURUNzQxMSBpcyBub3Qgc2V0CiMgQ09ORklH
X1NFTlNPUlNfQURUNzQ2MiBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfQURUNzQ3MCBp
cyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfQURUNzQ3NSBpcyBub3Qgc2V0CiMgQ09ORklH
X1NFTlNPUlNfQVMzNzAgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX0FTQzc2MjEgaXMg
bm90IHNldAojIENPTkZJR19TRU5TT1JTX0FYSV9GQU5fQ09OVFJPTCBpcyBub3Qgc2V0CiMg
Q09ORklHX1NFTlNPUlNfSzhURU1QIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19LMTBU
RU1QIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19GQU0xNUhfUE9XRVIgaXMgbm90IHNl
dAojIENPTkZJR19TRU5TT1JTX0FNRF9FTkVSR1kgaXMgbm90IHNldAojIENPTkZJR19TRU5T
T1JTX0FQUExFU01DIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19BU0IxMDAgaXMgbm90
IHNldAojIENPTkZJR19TRU5TT1JTX0FTUEVFRCBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNP
UlNfQVRYUDEgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX0NPUlNBSVJfQ1BSTyBpcyBu
b3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfRFJJVkVURU1QIGlzIG5vdCBzZXQKIyBDT05GSUdf
U0VOU09SU19EUzYyMCBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfRFMxNjIxIGlzIG5v
dCBzZXQKIyBDT05GSUdfU0VOU09SU19ERUxMX1NNTSBpcyBub3Qgc2V0CiMgQ09ORklHX1NF
TlNPUlNfSTVLX0FNQiBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfRjcxODA1RiBpcyBu
b3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfRjcxODgyRkcgaXMgbm90IHNldAojIENPTkZJR19T
RU5TT1JTX0Y3NTM3NVMgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX0ZTQ0hNRCBpcyBu
b3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfRlRTVEVVVEFURVMgaXMgbm90IHNldAojIENPTkZJ
R19TRU5TT1JTX0dMNTE4U00gaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX0dMNTIwU00g
aXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX0c3NjBBIGlzIG5vdCBzZXQKIyBDT05GSUdf
U0VOU09SU19HNzYyIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19HUElPX0ZBTiBpcyBu
b3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfSElINjEzMCBpcyBub3Qgc2V0CiMgQ09ORklHX1NF
TlNPUlNfSUlPX0hXTU9OIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19JNTUwMCBpcyBu
b3Qgc2V0CkNPTkZJR19TRU5TT1JTX0NPUkVURU1QPXkKIyBDT05GSUdfU0VOU09SU19JVDg3
IGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19KQzQyIGlzIG5vdCBzZXQKIyBDT05GSUdf
U0VOU09SU19QT1dSMTIyMCBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfTElORUFHRSBp
cyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfTFRDMjk0NSBpcyBub3Qgc2V0CiMgQ09ORklH
X1NFTlNPUlNfTFRDMjk0N19JMkMgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX0xUQzI5
NDdfU1BJIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19MVEMyOTkwIGlzIG5vdCBzZXQK
IyBDT05GSUdfU0VOU09SU19MVEM0MTUxIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19M
VEM0MjE1IGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19MVEM0MjIyIGlzIG5vdCBzZXQK
IyBDT05GSUdfU0VOU09SU19MVEM0MjQ1IGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19M
VEM0MjYwIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19MVEM0MjYxIGlzIG5vdCBzZXQK
IyBDT05GSUdfU0VOU09SU19NQVgxMTExIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19N
QVgxNjA2NSBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfTUFYMTYxOSBpcyBub3Qgc2V0
CiMgQ09ORklHX1NFTlNPUlNfTUFYMTY2OCBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNf
TUFYMTk3IGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19NQVgzMTcyMiBpcyBub3Qgc2V0
CiMgQ09ORklHX1NFTlNPUlNfTUFYMzE3MzAgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JT
X01BWDY2MjEgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX01BWDY2MzkgaXMgbm90IHNl
dAojIENPTkZJR19TRU5TT1JTX01BWDY2NDIgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JT
X01BWDY2NTAgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX01BWDY2OTcgaXMgbm90IHNl
dAojIENPTkZJR19TRU5TT1JTX01BWDMxNzkwIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09S
U19NQ1AzMDIxIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19UQzY1NCBpcyBub3Qgc2V0
CiMgQ09ORklHX1NFTlNPUlNfTVI3NTIwMyBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNf
QURDWFggaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX0xNNjMgaXMgbm90IHNldAojIENP
TkZJR19TRU5TT1JTX0xNNzAgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX0xNNzMgaXMg
bm90IHNldAojIENPTkZJR19TRU5TT1JTX0xNNzUgaXMgbm90IHNldAojIENPTkZJR19TRU5T
T1JTX0xNNzcgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX0xNNzggaXMgbm90IHNldAoj
IENPTkZJR19TRU5TT1JTX0xNODAgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX0xNODMg
aXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX0xNODUgaXMgbm90IHNldAojIENPTkZJR19T
RU5TT1JTX0xNODcgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX0xNOTAgaXMgbm90IHNl
dAojIENPTkZJR19TRU5TT1JTX0xNOTIgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX0xN
OTMgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX0xNOTUyMzQgaXMgbm90IHNldAojIENP
TkZJR19TRU5TT1JTX0xNOTUyNDEgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX0xNOTUy
NDUgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX1BDODczNjAgaXMgbm90IHNldAojIENP
TkZJR19TRU5TT1JTX1BDODc0MjcgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX05UQ19U
SEVSTUlTVE9SIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19OQ1Q2NjgzIGlzIG5vdCBz
ZXQKIyBDT05GSUdfU0VOU09SU19OQ1Q2Nzc1IGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09S
U19OQ1Q3ODAyIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19OQ1Q3OTA0IGlzIG5vdCBz
ZXQKIyBDT05GSUdfU0VOU09SU19OUENNN1hYIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09S
U19QQ0Y4NTkxIGlzIG5vdCBzZXQKIyBDT05GSUdfUE1CVVMgaXMgbm90IHNldAojIENPTkZJ
R19TRU5TT1JTX1NIVDE1IGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19TSFQyMSBpcyBu
b3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfU0hUM3ggaXMgbm90IHNldAojIENPTkZJR19TRU5T
T1JTX1NIVEMxIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19TSVM1NTk1IGlzIG5vdCBz
ZXQKIyBDT05GSUdfU0VOU09SU19ETUUxNzM3IGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09S
U19FTUMxNDAzIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19FTUMyMTAzIGlzIG5vdCBz
ZXQKIyBDT05GSUdfU0VOU09SU19FTUM2VzIwMSBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNP
UlNfU01TQzQ3TTEgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX1NNU0M0N00xOTIgaXMg
bm90IHNldAojIENPTkZJR19TRU5TT1JTX1NNU0M0N0IzOTcgaXMgbm90IHNldAojIENPTkZJ
R19TRU5TT1JTX1NDSDU2MjcgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX1NDSDU2MzYg
aXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX1NUVFM3NTEgaXMgbm90IHNldAojIENPTkZJ
R19TRU5TT1JTX1NNTTY2NSBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfQURDMTI4RDgx
OCBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfQURTNzgyOCBpcyBub3Qgc2V0CiMgQ09O
RklHX1NFTlNPUlNfQURTNzg3MSBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfQU1DNjgy
MSBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfSU5BMjA5IGlzIG5vdCBzZXQKIyBDT05G
SUdfU0VOU09SU19JTkEyWFggaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX0lOQTMyMjEg
aXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX1RDNzQgaXMgbm90IHNldAojIENPTkZJR19T
RU5TT1JTX1RITUM1MCBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfVE1QMTAyIGlzIG5v
dCBzZXQKIyBDT05GSUdfU0VOU09SU19UTVAxMDMgaXMgbm90IHNldAojIENPTkZJR19TRU5T
T1JTX1RNUDEwOCBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfVE1QNDAxIGlzIG5vdCBz
ZXQKIyBDT05GSUdfU0VOU09SU19UTVA0MjEgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JT
X1RNUDUxMyBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfVklBX0NQVVRFTVAgaXMgbm90
IHNldAojIENPTkZJR19TRU5TT1JTX1ZJQTY4NkEgaXMgbm90IHNldAojIENPTkZJR19TRU5T
T1JTX1ZUMTIxMSBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfVlQ4MjMxIGlzIG5vdCBz
ZXQKIyBDT05GSUdfU0VOU09SU19XODM3NzNHIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09S
U19XODM3ODFEIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19XODM3OTFEIGlzIG5vdCBz
ZXQKIyBDT05GSUdfU0VOU09SU19XODM3OTJEIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09S
U19XODM3OTMgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX1c4Mzc5NSBpcyBub3Qgc2V0
CiMgQ09ORklHX1NFTlNPUlNfVzgzTDc4NVRTIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09S
U19XODNMNzg2TkcgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX1c4MzYyN0hGIGlzIG5v
dCBzZXQKIyBDT05GSUdfU0VOU09SU19XODM2MjdFSEYgaXMgbm90IHNldAojIENPTkZJR19T
RU5TT1JTX1hHRU5FIGlzIG5vdCBzZXQKCiMKIyBBQ1BJIGRyaXZlcnMKIwojIENPTkZJR19T
RU5TT1JTX0FDUElfUE9XRVIgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX0FUSzAxMTAg
aXMgbm90IHNldApDT05GSUdfVEhFUk1BTD15CiMgQ09ORklHX1RIRVJNQUxfTkVUTElOSyBp
cyBub3Qgc2V0CiMgQ09ORklHX1RIRVJNQUxfU1RBVElTVElDUyBpcyBub3Qgc2V0CkNPTkZJ
R19USEVSTUFMX0VNRVJHRU5DWV9QT1dFUk9GRl9ERUxBWV9NUz0wCkNPTkZJR19USEVSTUFM
X0hXTU9OPXkKIyBDT05GSUdfVEhFUk1BTF9PRiBpcyBub3Qgc2V0CkNPTkZJR19USEVSTUFM
X1dSSVRBQkxFX1RSSVBTPXkKQ09ORklHX1RIRVJNQUxfREVGQVVMVF9HT1ZfU1RFUF9XSVNF
PXkKIyBDT05GSUdfVEhFUk1BTF9ERUZBVUxUX0dPVl9GQUlSX1NIQVJFIGlzIG5vdCBzZXQK
IyBDT05GSUdfVEhFUk1BTF9ERUZBVUxUX0dPVl9VU0VSX1NQQUNFIGlzIG5vdCBzZXQKIyBD
T05GSUdfVEhFUk1BTF9HT1ZfRkFJUl9TSEFSRSBpcyBub3Qgc2V0CkNPTkZJR19USEVSTUFM
X0dPVl9TVEVQX1dJU0U9eQpDT05GSUdfVEhFUk1BTF9HT1ZfQkFOR19CQU5HPXkKQ09ORklH
X1RIRVJNQUxfR09WX1VTRVJfU1BBQ0U9eQojIENPTkZJR19USEVSTUFMX0VNVUxBVElPTiBp
cyBub3Qgc2V0CiMgQ09ORklHX1RIRVJNQUxfTU1JTyBpcyBub3Qgc2V0CgojCiMgSW50ZWwg
dGhlcm1hbCBkcml2ZXJzCiMKIyBDT05GSUdfSU5URUxfUE9XRVJDTEFNUCBpcyBub3Qgc2V0
CkNPTkZJR19YODZfVEhFUk1BTF9WRUNUT1I9eQpDT05GSUdfWDg2X1BLR19URU1QX1RIRVJN
QUw9eQpDT05GSUdfSU5URUxfU09DX0RUU19JT1NGX0NPUkU9eQpDT05GSUdfSU5URUxfU09D
X0RUU19USEVSTUFMPXkKCiMKIyBBQ1BJIElOVDM0MFggdGhlcm1hbCBkcml2ZXJzCiMKIyBD
T05GSUdfSU5UMzQwWF9USEVSTUFMIGlzIG5vdCBzZXQKIyBlbmQgb2YgQUNQSSBJTlQzNDBY
IHRoZXJtYWwgZHJpdmVycwoKIyBDT05GSUdfSU5URUxfUENIX1RIRVJNQUwgaXMgbm90IHNl
dAojIGVuZCBvZiBJbnRlbCB0aGVybWFsIGRyaXZlcnMKCiMgQ09ORklHX0dFTkVSSUNfQURD
X1RIRVJNQUwgaXMgbm90IHNldApDT05GSUdfV0FUQ0hET0c9eQpDT05GSUdfV0FUQ0hET0df
Q09SRT15CiMgQ09ORklHX1dBVENIRE9HX05PV0FZT1VUIGlzIG5vdCBzZXQKQ09ORklHX1dB
VENIRE9HX0hBTkRMRV9CT09UX0VOQUJMRUQ9eQpDT05GSUdfV0FUQ0hET0dfT1BFTl9USU1F
T1VUPTAKIyBDT05GSUdfV0FUQ0hET0dfU1lTRlMgaXMgbm90IHNldAoKIwojIFdhdGNoZG9n
IFByZXRpbWVvdXQgR292ZXJub3JzCiMKIyBDT05GSUdfV0FUQ0hET0dfUFJFVElNRU9VVF9H
T1YgaXMgbm90IHNldAoKIwojIFdhdGNoZG9nIERldmljZSBEcml2ZXJzCiMKQ09ORklHX1NP
RlRfV0FUQ0hET0c9eQojIENPTkZJR19HUElPX1dBVENIRE9HIGlzIG5vdCBzZXQKIyBDT05G
SUdfV0RBVF9XRFQgaXMgbm90IHNldAojIENPTkZJR19YSUxJTlhfV0FUQ0hET0cgaXMgbm90
IHNldAojIENPTkZJR19aSUlSQVZFX1dBVENIRE9HIGlzIG5vdCBzZXQKIyBDT05GSUdfQ0FE
RU5DRV9XQVRDSERPRyBpcyBub3Qgc2V0CiMgQ09ORklHX0RXX1dBVENIRE9HIGlzIG5vdCBz
ZXQKIyBDT05GSUdfTUFYNjNYWF9XQVRDSERPRyBpcyBub3Qgc2V0CiMgQ09ORklHX0FDUVVJ
UkVfV0RUIGlzIG5vdCBzZXQKIyBDT05GSUdfQURWQU5URUNIX1dEVCBpcyBub3Qgc2V0CiMg
Q09ORklHX0FMSU0xNTM1X1dEVCBpcyBub3Qgc2V0CiMgQ09ORklHX0FMSU03MTAxX1dEVCBp
cyBub3Qgc2V0CiMgQ09ORklHX0VCQ19DMzg0X1dEVCBpcyBub3Qgc2V0CiMgQ09ORklHX0Y3
MTgwOEVfV0RUIGlzIG5vdCBzZXQKIyBDT05GSUdfU1A1MTAwX1RDTyBpcyBub3Qgc2V0CiMg
Q09ORklHX1NCQ19GSVRQQzJfV0FUQ0hET0cgaXMgbm90IHNldAojIENPTkZJR19FVVJPVEVD
SF9XRFQgaXMgbm90IHNldAojIENPTkZJR19JQjcwMF9XRFQgaXMgbm90IHNldAojIENPTkZJ
R19JQk1BU1IgaXMgbm90IHNldAojIENPTkZJR19XQUZFUl9XRFQgaXMgbm90IHNldAojIENP
TkZJR19JNjMwMEVTQl9XRFQgaXMgbm90IHNldAojIENPTkZJR19JRTZYWF9XRFQgaXMgbm90
IHNldAojIENPTkZJR19JVENPX1dEVCBpcyBub3Qgc2V0CiMgQ09ORklHX0lUODcxMkZfV0RU
IGlzIG5vdCBzZXQKIyBDT05GSUdfSVQ4N19XRFQgaXMgbm90IHNldAojIENPTkZJR19IUF9X
QVRDSERPRyBpcyBub3Qgc2V0CiMgQ09ORklHX1NDMTIwMF9XRFQgaXMgbm90IHNldAojIENP
TkZJR19QQzg3NDEzX1dEVCBpcyBub3Qgc2V0CiMgQ09ORklHX05WX1RDTyBpcyBub3Qgc2V0
CiMgQ09ORklHXzYwWFhfV0RUIGlzIG5vdCBzZXQKIyBDT05GSUdfQ1BVNV9XRFQgaXMgbm90
IHNldAojIENPTkZJR19TTVNDX1NDSDMxMVhfV0RUIGlzIG5vdCBzZXQKIyBDT05GSUdfU01T
QzM3Qjc4N19XRFQgaXMgbm90IHNldAojIENPTkZJR19UUU1YODZfV0RUIGlzIG5vdCBzZXQK
IyBDT05GSUdfVklBX1dEVCBpcyBub3Qgc2V0CiMgQ09ORklHX1c4MzYyN0hGX1dEVCBpcyBu
b3Qgc2V0CiMgQ09ORklHX1c4Mzg3N0ZfV0RUIGlzIG5vdCBzZXQKIyBDT05GSUdfVzgzOTc3
Rl9XRFQgaXMgbm90IHNldAojIENPTkZJR19NQUNIWl9XRFQgaXMgbm90IHNldAojIENPTkZJ
R19TQkNfRVBYX0MzX1dBVENIRE9HIGlzIG5vdCBzZXQKIyBDT05GSUdfTkk5MDNYX1dEVCBp
cyBub3Qgc2V0CiMgQ09ORklHX05JQzcwMThfV0RUIGlzIG5vdCBzZXQKIyBDT05GSUdfTUVO
X0EyMV9XRFQgaXMgbm90IHNldAoKIwojIFBDSS1iYXNlZCBXYXRjaGRvZyBDYXJkcwojCiMg
Q09ORklHX1BDSVBDV0FUQ0hET0cgaXMgbm90IHNldAojIENPTkZJR19XRFRQQ0kgaXMgbm90
IHNldAoKIwojIFVTQi1iYXNlZCBXYXRjaGRvZyBDYXJkcwojCiMgQ09ORklHX1VTQlBDV0FU
Q0hET0cgaXMgbm90IHNldApDT05GSUdfU1NCX1BPU1NJQkxFPXkKQ09ORklHX1NTQj15CkNP
TkZJR19TU0JfU1BST009eQpDT05GSUdfU1NCX0JMT0NLSU89eQpDT05GSUdfU1NCX1BDSUhP
U1RfUE9TU0lCTEU9eQpDT05GSUdfU1NCX1BDSUhPU1Q9eQpDT05GSUdfU1NCX0I0M19QQ0lf
QlJJREdFPXkKQ09ORklHX1NTQl9TRElPSE9TVF9QT1NTSUJMRT15CkNPTkZJR19TU0JfU0RJ
T0hPU1Q9eQpDT05GSUdfU1NCX0RSSVZFUl9QQ0lDT1JFX1BPU1NJQkxFPXkKQ09ORklHX1NT
Ql9EUklWRVJfUENJQ09SRT15CiMgQ09ORklHX1NTQl9EUklWRVJfR1BJTyBpcyBub3Qgc2V0
CkNPTkZJR19CQ01BX1BPU1NJQkxFPXkKQ09ORklHX0JDTUE9eQpDT05GSUdfQkNNQV9CTE9D
S0lPPXkKQ09ORklHX0JDTUFfSE9TVF9QQ0lfUE9TU0lCTEU9eQpDT05GSUdfQkNNQV9IT1NU
X1BDST15CiMgQ09ORklHX0JDTUFfSE9TVF9TT0MgaXMgbm90IHNldApDT05GSUdfQkNNQV9E
UklWRVJfUENJPXkKIyBDT05GSUdfQkNNQV9EUklWRVJfR01BQ19DTU4gaXMgbm90IHNldAoj
IENPTkZJR19CQ01BX0RSSVZFUl9HUElPIGlzIG5vdCBzZXQKIyBDT05GSUdfQkNNQV9ERUJV
RyBpcyBub3Qgc2V0CgojCiMgTXVsdGlmdW5jdGlvbiBkZXZpY2UgZHJpdmVycwojCkNPTkZJ
R19NRkRfQ09SRT15CiMgQ09ORklHX01GRF9BQ1Q4OTQ1QSBpcyBub3Qgc2V0CiMgQ09ORklH
X01GRF9BUzM3MTEgaXMgbm90IHNldAojIENPTkZJR19NRkRfQVMzNzIyIGlzIG5vdCBzZXQK
IyBDT05GSUdfUE1JQ19BRFA1NTIwIGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEX0FBVDI4NzBf
Q09SRSBpcyBub3Qgc2V0CiMgQ09ORklHX01GRF9BVE1FTF9GTEVYQ09NIGlzIG5vdCBzZXQK
IyBDT05GSUdfTUZEX0FUTUVMX0hMQ0RDIGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEX0JDTTU5
MFhYIGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEX0JEOTU3MU1XViBpcyBub3Qgc2V0CiMgQ09O
RklHX01GRF9BWFAyMFhfSTJDIGlzIG5vdCBzZXQKQ09ORklHX01GRF9DUk9TX0VDX0RFVj15
CiMgQ09ORklHX01GRF9NQURFUkEgaXMgbm90IHNldAojIENPTkZJR19QTUlDX0RBOTAzWCBp
cyBub3Qgc2V0CiMgQ09ORklHX01GRF9EQTkwNTJfU1BJIGlzIG5vdCBzZXQKIyBDT05GSUdf
TUZEX0RBOTA1Ml9JMkMgaXMgbm90IHNldAojIENPTkZJR19NRkRfREE5MDU1IGlzIG5vdCBz
ZXQKIyBDT05GSUdfTUZEX0RBOTA2MiBpcyBub3Qgc2V0CiMgQ09ORklHX01GRF9EQTkwNjMg
aXMgbm90IHNldAojIENPTkZJR19NRkRfREE5MTUwIGlzIG5vdCBzZXQKIyBDT05GSUdfTUZE
X0RMTjIgaXMgbm90IHNldAojIENPTkZJR19NRkRfR0FURVdPUktTX0dTQyBpcyBub3Qgc2V0
CiMgQ09ORklHX01GRF9NQzEzWFhYX1NQSSBpcyBub3Qgc2V0CiMgQ09ORklHX01GRF9NQzEz
WFhYX0kyQyBpcyBub3Qgc2V0CiMgQ09ORklHX01GRF9NUDI2MjkgaXMgbm90IHNldAojIENP
TkZJR19NRkRfSEk2NDIxX1BNSUMgaXMgbm90IHNldAojIENPTkZJR19IVENfUEFTSUMzIGlz
IG5vdCBzZXQKIyBDT05GSUdfSFRDX0kyQ1BMRCBpcyBub3Qgc2V0CiMgQ09ORklHX01GRF9J
TlRFTF9RVUFSS19JMkNfR1BJTyBpcyBub3Qgc2V0CkNPTkZJR19MUENfSUNIPXkKQ09ORklH
X0xQQ19TQ0g9eQojIENPTkZJR19JTlRFTF9TT0NfUE1JQyBpcyBub3Qgc2V0CiMgQ09ORklH
X0lOVEVMX1NPQ19QTUlDX0NIVFdDIGlzIG5vdCBzZXQKIyBDT05GSUdfSU5URUxfU09DX1BN
SUNfQ0hURENfVEkgaXMgbm90IHNldAojIENPTkZJR19JTlRFTF9TT0NfUE1JQ19NUkZMRCBp
cyBub3Qgc2V0CkNPTkZJR19NRkRfSU5URUxfTFBTUz15CkNPTkZJR19NRkRfSU5URUxfTFBT
U19BQ1BJPXkKQ09ORklHX01GRF9JTlRFTF9MUFNTX1BDST15CiMgQ09ORklHX01GRF9JTlRF
TF9NU0lDIGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEX0lOVEVMX1BNQ19CWFQgaXMgbm90IHNl
dAojIENPTkZJR19NRkRfSVFTNjJYIGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEX0pBTlpfQ01P
RElPIGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEX0tFTVBMRCBpcyBub3Qgc2V0CiMgQ09ORklH
X01GRF84OFBNODAwIGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEXzg4UE04MDUgaXMgbm90IHNl
dAojIENPTkZJR19NRkRfODhQTTg2MFggaXMgbm90IHNldAojIENPTkZJR19NRkRfTUFYMTQ1
NzcgaXMgbm90IHNldAojIENPTkZJR19NRkRfTUFYNzc2MjAgaXMgbm90IHNldAojIENPTkZJ
R19NRkRfTUFYNzc2NTAgaXMgbm90IHNldAojIENPTkZJR19NRkRfTUFYNzc2ODYgaXMgbm90
IHNldAojIENPTkZJR19NRkRfTUFYNzc2OTMgaXMgbm90IHNldAojIENPTkZJR19NRkRfTUFY
Nzc4NDMgaXMgbm90IHNldAojIENPTkZJR19NRkRfTUFYODkwNyBpcyBub3Qgc2V0CiMgQ09O
RklHX01GRF9NQVg4OTI1IGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEX01BWDg5OTcgaXMgbm90
IHNldAojIENPTkZJR19NRkRfTUFYODk5OCBpcyBub3Qgc2V0CiMgQ09ORklHX01GRF9NVDYz
NjAgaXMgbm90IHNldAojIENPTkZJR19NRkRfTVQ2Mzk3IGlzIG5vdCBzZXQKIyBDT05GSUdf
TUZEX01FTkYyMUJNQyBpcyBub3Qgc2V0CiMgQ09ORklHX0VaWF9QQ0FQIGlzIG5vdCBzZXQK
IyBDT05GSUdfTUZEX0NQQ0FQIGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEX1ZJUEVSQk9BUkQg
aXMgbm90IHNldAojIENPTkZJR19NRkRfUkVUVSBpcyBub3Qgc2V0CiMgQ09ORklHX01GRF9Q
Q0Y1MDYzMyBpcyBub3Qgc2V0CiMgQ09ORklHX01GRF9SREMzMjFYIGlzIG5vdCBzZXQKIyBD
T05GSUdfTUZEX1JUNTAzMyBpcyBub3Qgc2V0CiMgQ09ORklHX01GRF9SQzVUNTgzIGlzIG5v
dCBzZXQKIyBDT05GSUdfTUZEX1JLODA4IGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEX1JONVQ2
MTggaXMgbm90IHNldAojIENPTkZJR19NRkRfU0VDX0NPUkUgaXMgbm90IHNldAojIENPTkZJ
R19NRkRfU0k0NzZYX0NPUkUgaXMgbm90IHNldAojIENPTkZJR19NRkRfU001MDEgaXMgbm90
IHNldAojIENPTkZJR19NRkRfU0tZODE0NTIgaXMgbm90IHNldAojIENPTkZJR19BQlg1MDBf
Q09SRSBpcyBub3Qgc2V0CiMgQ09ORklHX01GRF9TVE1QRSBpcyBub3Qgc2V0CiMgQ09ORklH
X01GRF9TWVNDT04gaXMgbm90IHNldAojIENPTkZJR19NRkRfVElfQU0zMzVYX1RTQ0FEQyBp
cyBub3Qgc2V0CiMgQ09ORklHX01GRF9MUDM5NDMgaXMgbm90IHNldAojIENPTkZJR19NRkRf
TFA4Nzg4IGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEX1RJX0xNVSBpcyBub3Qgc2V0CiMgQ09O
RklHX01GRF9QQUxNQVMgaXMgbm90IHNldAojIENPTkZJR19UUFM2MTA1WCBpcyBub3Qgc2V0
CiMgQ09ORklHX1RQUzY1MDEwIGlzIG5vdCBzZXQKIyBDT05GSUdfVFBTNjUwN1ggaXMgbm90
IHNldAojIENPTkZJR19NRkRfVFBTNjUwODYgaXMgbm90IHNldAojIENPTkZJR19NRkRfVFBT
NjUwOTAgaXMgbm90IHNldAojIENPTkZJR19NRkRfVFBTNjUyMTcgaXMgbm90IHNldAojIENP
TkZJR19NRkRfVFBTNjg0NzAgaXMgbm90IHNldAojIENPTkZJR19NRkRfVElfTFA4NzNYIGlz
IG5vdCBzZXQKIyBDT05GSUdfTUZEX1RJX0xQODc1NjUgaXMgbm90IHNldAojIENPTkZJR19N
RkRfVFBTNjUyMTggaXMgbm90IHNldAojIENPTkZJR19NRkRfVFBTNjU4NlggaXMgbm90IHNl
dAojIENPTkZJR19NRkRfVFBTNjU5MTAgaXMgbm90IHNldAojIENPTkZJR19NRkRfVFBTNjU5
MTJfSTJDIGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEX1RQUzY1OTEyX1NQSSBpcyBub3Qgc2V0
CiMgQ09ORklHX01GRF9UUFM4MDAzMSBpcyBub3Qgc2V0CiMgQ09ORklHX1RXTDQwMzBfQ09S
RSBpcyBub3Qgc2V0CiMgQ09ORklHX1RXTDYwNDBfQ09SRSBpcyBub3Qgc2V0CiMgQ09ORklH
X01GRF9XTDEyNzNfQ09SRSBpcyBub3Qgc2V0CiMgQ09ORklHX01GRF9MTTM1MzMgaXMgbm90
IHNldAojIENPTkZJR19NRkRfVEMzNTg5WCBpcyBub3Qgc2V0CiMgQ09ORklHX01GRF9UUU1Y
ODYgaXMgbm90IHNldAojIENPTkZJR19NRkRfVlg4NTUgaXMgbm90IHNldAojIENPTkZJR19N
RkRfTE9DSE5BR0FSIGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEX0FSSVpPTkFfSTJDIGlzIG5v
dCBzZXQKIyBDT05GSUdfTUZEX0FSSVpPTkFfU1BJIGlzIG5vdCBzZXQKIyBDT05GSUdfTUZE
X1dNODQwMCBpcyBub3Qgc2V0CiMgQ09ORklHX01GRF9XTTgzMVhfSTJDIGlzIG5vdCBzZXQK
IyBDT05GSUdfTUZEX1dNODMxWF9TUEkgaXMgbm90IHNldAojIENPTkZJR19NRkRfV004MzUw
X0kyQyBpcyBub3Qgc2V0CiMgQ09ORklHX01GRF9XTTg5OTQgaXMgbm90IHNldAojIENPTkZJ
R19NRkRfUk9ITV9CRDcxOFhYIGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEX1JPSE1fQkQ3MDUy
OCBpcyBub3Qgc2V0CiMgQ09ORklHX01GRF9ST0hNX0JENzE4MjggaXMgbm90IHNldAojIENP
TkZJR19NRkRfU1RQTUlDMSBpcyBub3Qgc2V0CiMgQ09ORklHX01GRF9TVE1GWCBpcyBub3Qg
c2V0CiMgQ09ORklHX01GRF9RQ09NX1BNODAwOCBpcyBub3Qgc2V0CiMgQ09ORklHX01GRF9J
TlRFTF9NMTBfQk1DIGlzIG5vdCBzZXQKIyBlbmQgb2YgTXVsdGlmdW5jdGlvbiBkZXZpY2Ug
ZHJpdmVycwoKIyBDT05GSUdfUkVHVUxBVE9SIGlzIG5vdCBzZXQKIyBDT05GSUdfUkNfQ09S
RSBpcyBub3Qgc2V0CiMgQ09ORklHX01FRElBX0NFQ19TVVBQT1JUIGlzIG5vdCBzZXQKQ09O
RklHX01FRElBX1NVUFBPUlQ9eQpDT05GSUdfTUVESUFfU1VQUE9SVF9GSUxURVI9eQpDT05G
SUdfTUVESUFfU1VCRFJWX0FVVE9TRUxFQ1Q9eQoKIwojIE1lZGlhIGRldmljZSB0eXBlcwoj
CkNPTkZJR19NRURJQV9DQU1FUkFfU1VQUE9SVD15CiMgQ09ORklHX01FRElBX0FOQUxPR19U
Vl9TVVBQT1JUIGlzIG5vdCBzZXQKIyBDT05GSUdfTUVESUFfRElHSVRBTF9UVl9TVVBQT1JU
IGlzIG5vdCBzZXQKIyBDT05GSUdfTUVESUFfUkFESU9fU1VQUE9SVCBpcyBub3Qgc2V0CiMg
Q09ORklHX01FRElBX1NEUl9TVVBQT1JUIGlzIG5vdCBzZXQKQ09ORklHX01FRElBX1BMQVRG
T1JNX1NVUFBPUlQ9eQojIENPTkZJR19NRURJQV9URVNUX1NVUFBPUlQgaXMgbm90IHNldAoj
IGVuZCBvZiBNZWRpYSBkZXZpY2UgdHlwZXMKCkNPTkZJR19WSURFT19ERVY9eQpDT05GSUdf
TUVESUFfQ09OVFJPTExFUj15CgojCiMgVmlkZW80TGludXggb3B0aW9ucwojCkNPTkZJR19W
SURFT19WNEwyPXkKQ09ORklHX1ZJREVPX1Y0TDJfSTJDPXkKIyBDT05GSUdfVklERU9fVjRM
Ml9TVUJERVZfQVBJIGlzIG5vdCBzZXQKIyBDT05GSUdfVklERU9fQURWX0RFQlVHIGlzIG5v
dCBzZXQKIyBDT05GSUdfVklERU9fRklYRURfTUlOT1JfUkFOR0VTIGlzIG5vdCBzZXQKIyBl
bmQgb2YgVmlkZW80TGludXggb3B0aW9ucwoKIwojIE1lZGlhIGNvbnRyb2xsZXIgb3B0aW9u
cwojCiMgZW5kIG9mIE1lZGlhIGNvbnRyb2xsZXIgb3B0aW9ucwoKIwojIE1lZGlhIGRyaXZl
cnMKIwoKIwojIERyaXZlcnMgZmlsdGVyZWQgYXMgc2VsZWN0ZWQgYXQgJ0ZpbHRlciBtZWRp
YSBkcml2ZXJzJwojCkNPTkZJR19NRURJQV9VU0JfU1VQUE9SVD15CgojCiMgV2ViY2FtIGRl
dmljZXMKIwpDT05GSUdfVVNCX1ZJREVPX0NMQVNTPXkKIyBDT05GSUdfVVNCX1ZJREVPX0NM
QVNTX0lOUFVUX0VWREVWIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX0dTUENBIGlzIG5vdCBz
ZXQKIyBDT05GSUdfVVNCX1BXQyBpcyBub3Qgc2V0CiMgQ09ORklHX1ZJREVPX0NQSUEyIGlz
IG5vdCBzZXQKIyBDT05GSUdfVVNCX1pSMzY0WFggaXMgbm90IHNldAojIENPTkZJR19VU0Jf
U1RLV0VCQ0FNIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1MyMjU1IGlzIG5vdCBzZXQKIyBD
T05GSUdfVklERU9fVVNCVFYgaXMgbm90IHNldAoKIwojIFdlYmNhbSwgVFYgKGFuYWxvZy9k
aWdpdGFsKSBVU0IgZGV2aWNlcwojCiMgQ09ORklHX1ZJREVPX0VNMjhYWCBpcyBub3Qgc2V0
CkNPTkZJR19NRURJQV9QQ0lfU1VQUE9SVD15CgojCiMgTWVkaWEgY2FwdHVyZSBzdXBwb3J0
CiMKIyBDT05GSUdfVklERU9fU09MTzZYMTAgaXMgbm90IHNldAojIENPTkZJR19WSURFT19U
VzU4NjQgaXMgbm90IHNldAojIENPTkZJR19WSURFT19UVzY4IGlzIG5vdCBzZXQKIyBDT05G
SUdfVklERU9fVFc2ODZYIGlzIG5vdCBzZXQKIyBDT05GSUdfVklERU9fSU5URUxfSVBVNiBp
cyBub3Qgc2V0CiMgQ09ORklHX1ZJREVPX0lQVTNfQ0lPMiBpcyBub3Qgc2V0CiMgQ09ORklH
X1ZJUlRJT19WSURFTyBpcyBub3Qgc2V0CkNPTkZJR19WSURFT0JVRjJfQ09SRT15CkNPTkZJ
R19WSURFT0JVRjJfVjRMMj15CkNPTkZJR19WSURFT0JVRjJfTUVNT1BTPXkKQ09ORklHX1ZJ
REVPQlVGMl9WTUFMTE9DPXkKIyBDT05GSUdfVjRMX1BMQVRGT1JNX0RSSVZFUlMgaXMgbm90
IHNldAojIENPTkZJR19WNExfTUVNMk1FTV9EUklWRVJTIGlzIG5vdCBzZXQKIyBlbmQgb2Yg
TWVkaWEgZHJpdmVycwoKIwojIE1lZGlhIGFuY2lsbGFyeSBkcml2ZXJzCiMKCiMKIyBBdWRp
byBkZWNvZGVycywgcHJvY2Vzc29ycyBhbmQgbWl4ZXJzCiMKIyBDT05GSUdfVklERU9fVFZB
VURJTyBpcyBub3Qgc2V0CiMgQ09ORklHX1ZJREVPX1REQTc0MzIgaXMgbm90IHNldAojIENP
TkZJR19WSURFT19UREE5ODQwIGlzIG5vdCBzZXQKIyBDT05GSUdfVklERU9fVERBMTk5N1gg
aXMgbm90IHNldAojIENPTkZJR19WSURFT19URUE2NDE1QyBpcyBub3Qgc2V0CiMgQ09ORklH
X1ZJREVPX1RFQTY0MjAgaXMgbm90IHNldAojIENPTkZJR19WSURFT19NU1AzNDAwIGlzIG5v
dCBzZXQKIyBDT05GSUdfVklERU9fQ1MzMzA4IGlzIG5vdCBzZXQKIyBDT05GSUdfVklERU9f
Q1M1MzQ1IGlzIG5vdCBzZXQKIyBDT05GSUdfVklERU9fQ1M1M0wzMkEgaXMgbm90IHNldAoj
IENPTkZJR19WSURFT19UTFYzMjBBSUMyM0IgaXMgbm90IHNldAojIENPTkZJR19WSURFT19V
REExMzQyIGlzIG5vdCBzZXQKIyBDT05GSUdfVklERU9fV004Nzc1IGlzIG5vdCBzZXQKIyBD
T05GSUdfVklERU9fV004NzM5IGlzIG5vdCBzZXQKIyBDT05GSUdfVklERU9fVlAyN1NNUFgg
aXMgbm90IHNldAojIENPTkZJR19WSURFT19TT05ZX0JURl9NUFggaXMgbm90IHNldAojIGVu
ZCBvZiBBdWRpbyBkZWNvZGVycywgcHJvY2Vzc29ycyBhbmQgbWl4ZXJzCgojCiMgUkRTIGRl
Y29kZXJzCiMKIyBDT05GSUdfVklERU9fU0FBNjU4OCBpcyBub3Qgc2V0CiMgZW5kIG9mIFJE
UyBkZWNvZGVycwoKIwojIFZpZGVvIGRlY29kZXJzCiMKIyBDT05GSUdfVklERU9fQURWNzE4
MCBpcyBub3Qgc2V0CiMgQ09ORklHX1ZJREVPX0FEVjcxODMgaXMgbm90IHNldAojIENPTkZJ
R19WSURFT19BRFY3NDhYIGlzIG5vdCBzZXQKIyBDT05GSUdfVklERU9fQURWNzYwNCBpcyBu
b3Qgc2V0CiMgQ09ORklHX1ZJREVPX0FEVjc4NDIgaXMgbm90IHNldAojIENPTkZJR19WSURF
T19CVDgxOSBpcyBub3Qgc2V0CiMgQ09ORklHX1ZJREVPX0JUODU2IGlzIG5vdCBzZXQKIyBD
T05GSUdfVklERU9fQlQ4NjYgaXMgbm90IHNldAojIENPTkZJR19WSURFT19LUzAxMjcgaXMg
bm90IHNldAojIENPTkZJR19WSURFT19NTDg2Vjc2NjcgaXMgbm90IHNldAojIENPTkZJR19W
SURFT19TQUE3MTEwIGlzIG5vdCBzZXQKIyBDT05GSUdfVklERU9fU0FBNzExWCBpcyBub3Qg
c2V0CiMgQ09ORklHX1ZJREVPX1RDMzU4NzQzIGlzIG5vdCBzZXQKIyBDT05GSUdfVklERU9f
VFZQNTE0WCBpcyBub3Qgc2V0CiMgQ09ORklHX1ZJREVPX1RWUDUxNTAgaXMgbm90IHNldAoj
IENPTkZJR19WSURFT19UVlA3MDAyIGlzIG5vdCBzZXQKIyBDT05GSUdfVklERU9fVFcyODA0
IGlzIG5vdCBzZXQKIyBDT05GSUdfVklERU9fVFc5OTAzIGlzIG5vdCBzZXQKIyBDT05GSUdf
VklERU9fVFc5OTA2IGlzIG5vdCBzZXQKIyBDT05GSUdfVklERU9fVFc5OTEwIGlzIG5vdCBz
ZXQKIyBDT05GSUdfVklERU9fVlBYMzIyMCBpcyBub3Qgc2V0CiMgQ09ORklHX1ZJREVPX01B
WDkyODYgaXMgbm90IHNldAoKIwojIFZpZGVvIGFuZCBhdWRpbyBkZWNvZGVycwojCiMgQ09O
RklHX1ZJREVPX1NBQTcxN1ggaXMgbm90IHNldAojIENPTkZJR19WSURFT19DWDI1ODQwIGlz
IG5vdCBzZXQKIyBlbmQgb2YgVmlkZW8gZGVjb2RlcnMKCiMKIyBWaWRlbyBlbmNvZGVycwoj
CiMgQ09ORklHX1ZJREVPX1NBQTcxMjcgaXMgbm90IHNldAojIENPTkZJR19WSURFT19TQUE3
MTg1IGlzIG5vdCBzZXQKIyBDT05GSUdfVklERU9fQURWNzE3MCBpcyBub3Qgc2V0CiMgQ09O
RklHX1ZJREVPX0FEVjcxNzUgaXMgbm90IHNldAojIENPTkZJR19WSURFT19BRFY3MzQzIGlz
IG5vdCBzZXQKIyBDT05GSUdfVklERU9fQURWNzM5MyBpcyBub3Qgc2V0CiMgQ09ORklHX1ZJ
REVPX0FEVjc1MTEgaXMgbm90IHNldAojIENPTkZJR19WSURFT19BRDkzODlCIGlzIG5vdCBz
ZXQKIyBDT05GSUdfVklERU9fQUs4ODFYIGlzIG5vdCBzZXQKIyBDT05GSUdfVklERU9fVEhT
ODIwMCBpcyBub3Qgc2V0CiMgZW5kIG9mIFZpZGVvIGVuY29kZXJzCgojCiMgVmlkZW8gaW1w
cm92ZW1lbnQgY2hpcHMKIwojIENPTkZJR19WSURFT19VUEQ2NDAzMUEgaXMgbm90IHNldAoj
IENPTkZJR19WSURFT19VUEQ2NDA4MyBpcyBub3Qgc2V0CiMgQ09ORklHX1ZJREVPX0dDNTAz
NSBpcyBub3Qgc2V0CiMgZW5kIG9mIFZpZGVvIGltcHJvdmVtZW50IGNoaXBzCgojCiMgQXVk
aW8vVmlkZW8gY29tcHJlc3Npb24gY2hpcHMKIwojIENPTkZJR19WSURFT19TQUE2NzUySFMg
aXMgbm90IHNldAojIGVuZCBvZiBBdWRpby9WaWRlbyBjb21wcmVzc2lvbiBjaGlwcwoKIwoj
IFNEUiB0dW5lciBjaGlwcwojCiMgZW5kIG9mIFNEUiB0dW5lciBjaGlwcwoKIwojIE1pc2Nl
bGxhbmVvdXMgaGVscGVyIGNoaXBzCiMKIyBDT05GSUdfVklERU9fVEhTNzMwMyBpcyBub3Qg
c2V0CiMgQ09ORklHX1ZJREVPX001Mjc5MCBpcyBub3Qgc2V0CiMgQ09ORklHX1ZJREVPX0ky
QyBpcyBub3Qgc2V0CiMgQ09ORklHX1ZJREVPX1NUX01JUElEMDIgaXMgbm90IHNldAojIGVu
ZCBvZiBNaXNjZWxsYW5lb3VzIGhlbHBlciBjaGlwcwoKIwojIENhbWVyYSBzZW5zb3IgZGV2
aWNlcwojCiMgQ09ORklHX1ZJREVPX0hJNTU2IGlzIG5vdCBzZXQKIyBDT05GSUdfVklERU9f
SU1YMjE0IGlzIG5vdCBzZXQKIyBDT05GSUdfVklERU9fSU1YMjE5IGlzIG5vdCBzZXQKIyBD
T05GSUdfVklERU9fSU1YMjU4IGlzIG5vdCBzZXQKIyBDT05GSUdfVklERU9fSU1YMjc0IGlz
IG5vdCBzZXQKIyBDT05GSUdfVklERU9fSU1YMjkwIGlzIG5vdCBzZXQKIyBDT05GSUdfVklE
RU9fSU1YMzE5IGlzIG5vdCBzZXQKIyBDT05GSUdfVklERU9fSU1YMzU1IGlzIG5vdCBzZXQK
IyBDT05GSUdfVklERU9fT1YwMkExMCBpcyBub3Qgc2V0CiMgQ09ORklHX1ZJREVPX09WMjY0
MCBpcyBub3Qgc2V0CiMgQ09ORklHX1ZJREVPX09WMjY1OSBpcyBub3Qgc2V0CiMgQ09ORklH
X1ZJREVPX09WMjY4MCBpcyBub3Qgc2V0CiMgQ09ORklHX1ZJREVPX09WMjY4NSBpcyBub3Qg
c2V0CiMgQ09ORklHX1ZJREVPX09WMjc0MCBpcyBub3Qgc2V0CiMgQ09ORklHX1ZJREVPX09W
NTY0MCBpcyBub3Qgc2V0CiMgQ09ORklHX1ZJREVPX09WNTY0NSBpcyBub3Qgc2V0CiMgQ09O
RklHX1ZJREVPX09WNTY0NyBpcyBub3Qgc2V0CiMgQ09ORklHX1ZJREVPX09WNjY1MCBpcyBu
b3Qgc2V0CiMgQ09ORklHX1ZJREVPX09WNTY3MCBpcyBub3Qgc2V0CiMgQ09ORklHX1ZJREVP
X09WNTY3NSBpcyBub3Qgc2V0CiMgQ09ORklHX1ZJREVPX09WNTY5NSBpcyBub3Qgc2V0CiMg
Q09ORklHX1ZJREVPX09WNzI1MSBpcyBub3Qgc2V0CiMgQ09ORklHX1ZJREVPX09WNzcyWCBp
cyBub3Qgc2V0CiMgQ09ORklHX1ZJREVPX09WNzY0MCBpcyBub3Qgc2V0CiMgQ09ORklHX1ZJ
REVPX09WNzY3MCBpcyBub3Qgc2V0CiMgQ09ORklHX1ZJREVPX09WNzc0MCBpcyBub3Qgc2V0
CiMgQ09ORklHX1ZJREVPX09WODg1NiBpcyBub3Qgc2V0CiMgQ09ORklHX1ZJREVPX09WOTY0
MCBpcyBub3Qgc2V0CiMgQ09ORklHX1ZJREVPX09WOTY1MCBpcyBub3Qgc2V0CiMgQ09ORklH
X1ZJREVPX09WOTczNCBpcyBub3Qgc2V0CiMgQ09ORklHX1ZJREVPX09WMTM4NTggaXMgbm90
IHNldAojIENPTkZJR19WSURFT19WUzY2MjQgaXMgbm90IHNldAojIENPTkZJR19WSURFT19N
VDlNMDAxIGlzIG5vdCBzZXQKIyBDT05GSUdfVklERU9fTVQ5TTAzMiBpcyBub3Qgc2V0CiMg
Q09ORklHX1ZJREVPX01UOU0xMTEgaXMgbm90IHNldAojIENPTkZJR19WSURFT19NVDlQMDMx
IGlzIG5vdCBzZXQKIyBDT05GSUdfVklERU9fTVQ5VDAwMSBpcyBub3Qgc2V0CiMgQ09ORklH
X1ZJREVPX01UOVQxMTIgaXMgbm90IHNldAojIENPTkZJR19WSURFT19NVDlWMDExIGlzIG5v
dCBzZXQKIyBDT05GSUdfVklERU9fTVQ5VjAzMiBpcyBub3Qgc2V0CiMgQ09ORklHX1ZJREVP
X01UOVYxMTEgaXMgbm90IHNldAojIENPTkZJR19WSURFT19TUjAzMFBDMzAgaXMgbm90IHNl
dAojIENPTkZJR19WSURFT19OT09OMDEwUEMzMCBpcyBub3Qgc2V0CiMgQ09ORklHX1ZJREVP
X001TU9MUyBpcyBub3Qgc2V0CiMgQ09ORklHX1ZJREVPX1JEQUNNMjAgaXMgbm90IHNldAoj
IENPTkZJR19WSURFT19SSjU0TjEgaXMgbm90IHNldAojIENPTkZJR19WSURFT19TNUs2QUEg
aXMgbm90IHNldAojIENPTkZJR19WSURFT19TNUs2QTMgaXMgbm90IHNldAojIENPTkZJR19W
SURFT19TNUs0RUNHWCBpcyBub3Qgc2V0CiMgQ09ORklHX1ZJREVPX1M1SzVCQUYgaXMgbm90
IHNldAojIENPTkZJR19WSURFT19TTUlBUFAgaXMgbm90IHNldAojIENPTkZJR19WSURFT19F
VDhFSzggaXMgbm90IHNldAojIENPTkZJR19WSURFT19TNUM3M00zIGlzIG5vdCBzZXQKIyBl
bmQgb2YgQ2FtZXJhIHNlbnNvciBkZXZpY2VzCgojCiMgTGVucyBkcml2ZXJzCiMKIyBDT05G
SUdfVklERU9fQUQ1ODIwIGlzIG5vdCBzZXQKIyBDT05GSUdfVklERU9fQUs3Mzc1IGlzIG5v
dCBzZXQKIyBDT05GSUdfVklERU9fRFc5NzE0IGlzIG5vdCBzZXQKIyBDT05GSUdfVklERU9f
RFc5NzY4IGlzIG5vdCBzZXQKIyBDT05GSUdfVklERU9fRFc5ODA3X1ZDTSBpcyBub3Qgc2V0
CiMgZW5kIG9mIExlbnMgZHJpdmVycwoKIwojIEZsYXNoIGRldmljZXMKIwojIENPTkZJR19W
SURFT19BRFAxNjUzIGlzIG5vdCBzZXQKIyBDT05GSUdfVklERU9fTE0zNTYwIGlzIG5vdCBz
ZXQKIyBDT05GSUdfVklERU9fTE0zNjQ2IGlzIG5vdCBzZXQKIyBlbmQgb2YgRmxhc2ggZGV2
aWNlcwoKIwojIFNQSSBoZWxwZXIgY2hpcHMKIwojIENPTkZJR19WSURFT19HUzE2NjIgaXMg
bm90IHNldAojIGVuZCBvZiBTUEkgaGVscGVyIGNoaXBzCgojCiMgTWVkaWEgU1BJIEFkYXB0
ZXJzCiMKIyBlbmQgb2YgTWVkaWEgU1BJIEFkYXB0ZXJzCiMgZW5kIG9mIE1lZGlhIGFuY2ls
bGFyeSBkcml2ZXJzCgojCiMgR3JhcGhpY3Mgc3VwcG9ydAojCiMgQ09ORklHX0FHUCBpcyBu
b3Qgc2V0CkNPTkZJR19JTlRFTF9HVFQ9eQojIENPTkZJR19WR0FfQVJCIGlzIG5vdCBzZXQK
IyBDT05GSUdfVkdBX1NXSVRDSEVST08gaXMgbm90IHNldApDT05GSUdfRFJNPXkKQ09ORklH
X0RSTV9NSVBJX0RTST15CkNPTkZJR19EUk1fRFBfQVVYX0NIQVJERVY9eQojIENPTkZJR19E
Uk1fREVCVUdfTU0gaXMgbm90IHNldAojIENPTkZJR19EUk1fREVCVUdfU0VMRlRFU1QgaXMg
bm90IHNldApDT05GSUdfRFJNX0lOUFVUX0hFTFBFUj15CkNPTkZJR19EUk1fU0VMRl9SRUZS
RVNIX0lOUFVUX0JPT1NUX0RFRkFVTFQ9eQpDT05GSUdfRFJNX0tNU19IRUxQRVI9eQojIENP
TkZJR19EUk1fREVCVUdfRFBfTVNUX1RPUE9MT0dZX1JFRlMgaXMgbm90IHNldAojIENPTkZJ
R19EUk1fRkJERVZfRU1VTEFUSU9OIGlzIG5vdCBzZXQKIyBDT05GSUdfRFJNX0xPQURfRURJ
RF9GSVJNV0FSRSBpcyBub3Qgc2V0CiMgQ09ORklHX0RSTV9EUF9DRUMgaXMgbm90IHNldApD
T05GSUdfRFJNX1RUTT15CkNPTkZJR19EUk1fVFRNX0hFTFBFUj15CkNPTkZJR19EUk1fVFRN
X0JPX1dBSVRfVElNRU9VVD0xNQpDT05GSUdfRFJNX0dFTV9TSE1FTV9IRUxQRVI9eQoKIwoj
IEkyQyBlbmNvZGVyIG9yIGhlbHBlciBjaGlwcwojCiMgQ09ORklHX0RSTV9JMkNfQ0g3MDA2
IGlzIG5vdCBzZXQKIyBDT05GSUdfRFJNX0kyQ19TSUwxNjQgaXMgbm90IHNldAojIENPTkZJ
R19EUk1fSTJDX05YUF9UREE5OThYIGlzIG5vdCBzZXQKIyBDT05GSUdfRFJNX0kyQ19OWFBf
VERBOTk1MCBpcyBub3Qgc2V0CiMgZW5kIG9mIEkyQyBlbmNvZGVyIG9yIGhlbHBlciBjaGlw
cwoKIwojIEFSTSBkZXZpY2VzCiMKIyBDT05GSUdfRFJNX0tPTUVEQSBpcyBub3Qgc2V0CiMg
ZW5kIG9mIEFSTSBkZXZpY2VzCgpDT05GSUdfRFJNX1JBREVPTj15CiMgQ09ORklHX0RSTV9S
QURFT05fVVNFUlBUUiBpcyBub3Qgc2V0CiMgQ09ORklHX0RSTV9BTURHUFUgaXMgbm90IHNl
dApDT05GSUdfRFJNX05PVVZFQVU9eQpDT05GSUdfTk9VVkVBVV9MRUdBQ1lfQ1RYX1NVUFBP
UlQ9eQpDT05GSUdfTk9VVkVBVV9ERUJVRz01CkNPTkZJR19OT1VWRUFVX0RFQlVHX0RFRkFV
TFQ9MwojIENPTkZJR19OT1VWRUFVX0RFQlVHX01NVSBpcyBub3Qgc2V0CiMgQ09ORklHX05P
VVZFQVVfREVCVUdfUFVTSCBpcyBub3Qgc2V0CkNPTkZJR19EUk1fTk9VVkVBVV9CQUNLTElH
SFQ9eQpDT05GSUdfRFJNX0k5MTU9eQpDT05GSUdfRFJNX0k5MTVfRk9SQ0VfUFJPQkU9Iioi
CkNPTkZJR19EUk1fSTkxNV9DQVBUVVJFX0VSUk9SPXkKQ09ORklHX0RSTV9JOTE1X0NPTVBS
RVNTX0VSUk9SPXkKQ09ORklHX0RSTV9JOTE1X1VTRVJQVFI9eQojIENPTkZJR19EUk1fSTkx
NV9HVlQgaXMgbm90IHNldAoKIwojIGRybS9pOTE1IERlYnVnZ2luZwojCiMgQ09ORklHX0RS
TV9JOTE1X1dFUlJPUiBpcyBub3Qgc2V0CiMgQ09ORklHX0RSTV9JOTE1X0RFQlVHIGlzIG5v
dCBzZXQKIyBDT05GSUdfRFJNX0k5MTVfREVCVUdfTU1JTyBpcyBub3Qgc2V0CiMgQ09ORklH
X0RSTV9JOTE1X1NXX0ZFTkNFX0RFQlVHX09CSkVDVFMgaXMgbm90IHNldAojIENPTkZJR19E
Uk1fSTkxNV9TV19GRU5DRV9DSEVDS19EQUcgaXMgbm90IHNldAojIENPTkZJR19EUk1fSTkx
NV9ERUJVR19HVUMgaXMgbm90IHNldAojIENPTkZJR19EUk1fSTkxNV9TRUxGVEVTVCBpcyBu
b3Qgc2V0CiMgQ09ORklHX0RSTV9JOTE1X0xPV19MRVZFTF9UUkFDRVBPSU5UUyBpcyBub3Qg
c2V0CiMgQ09ORklHX0RSTV9JOTE1X0RFQlVHX1ZCTEFOS19FVkFERSBpcyBub3Qgc2V0CiMg
Q09ORklHX0RSTV9JOTE1X0RFQlVHX1JVTlRJTUVfUE0gaXMgbm90IHNldAojIGVuZCBvZiBk
cm0vaTkxNSBEZWJ1Z2dpbmcKCiMKIyBkcm0vaTkxNSBQcm9maWxlIEd1aWRlZCBPcHRpbWlz
YXRpb24KIwpDT05GSUdfRFJNX0k5MTVfUkVRVUVTVF9USU1FT1VUPTIwMDAwCkNPTkZJR19E
Uk1fSTkxNV9GRU5DRV9USU1FT1VUPTEwMDAwCkNPTkZJR19EUk1fSTkxNV9VU0VSRkFVTFRf
QVVUT1NVU1BFTkQ9MjUwCkNPTkZJR19EUk1fSTkxNV9IRUFSVEJFQVRfSU5URVJWQUw9MjUw
MApDT05GSUdfRFJNX0k5MTVfUFJFRU1QVF9USU1FT1VUPTY0MApDT05GSUdfRFJNX0k5MTVf
TUFYX1JFUVVFU1RfQlVTWVdBSVQ9ODAwMApDT05GSUdfRFJNX0k5MTVfU1RPUF9USU1FT1VU
PTEwMApDT05GSUdfRFJNX0k5MTVfVElNRVNMSUNFX0RVUkFUSU9OPTEKIyBlbmQgb2YgZHJt
L2k5MTUgUHJvZmlsZSBHdWlkZWQgT3B0aW1pc2F0aW9uCgpDT05GSUdfRFJNX1ZHRU09eQoj
IENPTkZJR19EUk1fVktNUyBpcyBub3Qgc2V0CkNPTkZJR19EUk1fRVZEST15CiMgQ09ORklH
X0RSTV9WTVdHRlggaXMgbm90IHNldApDT05GSUdfRFJNX0dNQTUwMD15CkNPTkZJR19EUk1f
VURMPXkKIyBDT05GSUdfRFJNX0FTVCBpcyBub3Qgc2V0CiMgQ09ORklHX0RSTV9NR0FHMjAw
IGlzIG5vdCBzZXQKIyBDT05GSUdfRFJNX1JDQVJfRFdfSERNSSBpcyBub3Qgc2V0CiMgQ09O
RklHX0RSTV9SQ0FSX1VTRV9MVkRTIGlzIG5vdCBzZXQKIyBDT05GSUdfRFJNX1FYTCBpcyBu
b3Qgc2V0CkNPTkZJR19EUk1fVklSVElPX0dQVT15CkNPTkZJR19EUk1fUEFORUw9eQoKIwoj
IERpc3BsYXkgUGFuZWxzCiMKIyBDT05GSUdfRFJNX1BBTkVMX0FCVF9ZMDMwWFgwNjdBIGlz
IG5vdCBzZXQKIyBDT05GSUdfRFJNX1BBTkVMX0FTVVNfWjAwVF9UTTVQNV9OVDM1NTk2IGlz
IG5vdCBzZXQKIyBDT05GSUdfRFJNX1BBTkVMX0JPRV9ISU1BWDgyNzlEIGlzIG5vdCBzZXQK
IyBDT05GSUdfRFJNX1BBTkVMX0JPRV9UVjEwMVdVTV9OTDYgaXMgbm90IHNldAojIENPTkZJ
R19EUk1fUEFORUxfRFNJX0NNIGlzIG5vdCBzZXQKIyBDT05GSUdfRFJNX1BBTkVMX0xWRFMg
aXMgbm90IHNldAojIENPTkZJR19EUk1fUEFORUxfU0lNUExFIGlzIG5vdCBzZXQKIyBDT05G
SUdfRFJNX1BBTkVMX0VEUCBpcyBub3Qgc2V0CiMgQ09ORklHX0RSTV9QQU5FTF9FTElEQV9L
RDM1VDEzMyBpcyBub3Qgc2V0CiMgQ09ORklHX0RSTV9QQU5FTF9GRUlYSU5fSzEwMV9JTTJC
QTAyIGlzIG5vdCBzZXQKIyBDT05GSUdfRFJNX1BBTkVMX0ZFSVlBTkdfRlkwNzAyNERJMjZB
MzBEIGlzIG5vdCBzZXQKIyBDT05GSUdfRFJNX1BBTkVMX0lMSVRFS19JTDkzMjIgaXMgbm90
IHNldAojIENPTkZJR19EUk1fUEFORUxfSUxJVEVLX0lMSTk4ODFDIGlzIG5vdCBzZXQKIyBD
T05GSUdfRFJNX1BBTkVMX0lOTk9MVVhfRUowMzBOQSBpcyBub3Qgc2V0CiMgQ09ORklHX0RS
TV9QQU5FTF9JTk5PTFVYX0hJTUFYODI3OUQgaXMgbm90IHNldAojIENPTkZJR19EUk1fUEFO
RUxfSU5OT0xVWF9QMDc5WkNBIGlzIG5vdCBzZXQKIyBDT05GSUdfRFJNX1BBTkVMX0pESV9M
VDA3ME1FMDUwMDAgaXMgbm90IHNldAojIENPTkZJR19EUk1fUEFORUxfS0hBREFTX1RTMDUw
IGlzIG5vdCBzZXQKIyBDT05GSUdfRFJNX1BBTkVMX0tJTkdESVNQTEFZX0tEMDk3RDA0IGlz
IG5vdCBzZXQKIyBDT05GSUdfRFJNX1BBTkVMX0xFQURURUtfTFRLMDUwSDMxNDZXIGlzIG5v
dCBzZXQKIyBDT05GSUdfRFJNX1BBTkVMX0xFQURURUtfTFRLNTAwSEQxODI5IGlzIG5vdCBz
ZXQKIyBDT05GSUdfRFJNX1BBTkVMX1NBTVNVTkdfTEQ5MDQwIGlzIG5vdCBzZXQKIyBDT05G
SUdfRFJNX1BBTkVMX0xHX0xCMDM1UTAyIGlzIG5vdCBzZXQKIyBDT05GSUdfRFJNX1BBTkVM
X0xHX0xHNDU3MyBpcyBub3Qgc2V0CiMgQ09ORklHX0RSTV9QQU5FTF9ORUNfTkw4MDQ4SEwx
MSBpcyBub3Qgc2V0CiMgQ09ORklHX0RSTV9QQU5FTF9OT1ZBVEVLX05UMzU1MTAgaXMgbm90
IHNldAojIENPTkZJR19EUk1fUEFORUxfTk9WQVRFS19OVDM2NjcyQSBpcyBub3Qgc2V0CiMg
Q09ORklHX0RSTV9QQU5FTF9OT1ZBVEVLX05UMzkwMTYgaXMgbm90IHNldAojIENPTkZJR19E
Uk1fUEFORUxfTUFOVElYX01MQUYwNTdXRTUxIGlzIG5vdCBzZXQKIyBDT05GSUdfRFJNX1BB
TkVMX09MSU1FWF9MQ0RfT0xJTlVYSU5PIGlzIG5vdCBzZXQKIyBDT05GSUdfRFJNX1BBTkVM
X09SSVNFVEVDSF9PVE04MDA5QSBpcyBub3Qgc2V0CiMgQ09ORklHX0RSTV9QQU5FTF9PU0Rf
T1NEMTAxVDI1ODdfNTNUUyBpcyBub3Qgc2V0CiMgQ09ORklHX0RSTV9QQU5FTF9QQU5BU09O
SUNfVlZYMTBGMDM0TjAwIGlzIG5vdCBzZXQKIyBDT05GSUdfRFJNX1BBTkVMX1JBU1BCRVJS
WVBJX1RPVUNIU0NSRUVOIGlzIG5vdCBzZXQKIyBDT05GSUdfRFJNX1BBTkVMX1JBWURJVU1f
Uk02NzE5MSBpcyBub3Qgc2V0CiMgQ09ORklHX0RSTV9QQU5FTF9SQVlESVVNX1JNNjgyMDAg
aXMgbm90IHNldAojIENPTkZJR19EUk1fUEFORUxfUk9OQk9fUkIwNzBEMzAgaXMgbm90IHNl
dAojIENPTkZJR19EUk1fUEFORUxfU0FNU1VOR19BVE5BMzNYQzIwIGlzIG5vdCBzZXQKIyBD
T05GSUdfRFJNX1BBTkVMX1NBTVNVTkdfREI3NDMwIGlzIG5vdCBzZXQKIyBDT05GSUdfRFJN
X1BBTkVMX1NBTVNVTkdfUzZEMTZEMCBpcyBub3Qgc2V0CiMgQ09ORklHX0RSTV9QQU5FTF9T
QU1TVU5HX1M2RTNIQTIgaXMgbm90IHNldAojIENPTkZJR19EUk1fUEFORUxfU0FNU1VOR19T
NkU2M0owWDAzIGlzIG5vdCBzZXQKIyBDT05GSUdfRFJNX1BBTkVMX1NBTVNVTkdfUzZFNjNN
MCBpcyBub3Qgc2V0CiMgQ09ORklHX0RSTV9QQU5FTF9TQU1TVU5HX1M2RTg4QTBfQU1TNDUy
RUYwMSBpcyBub3Qgc2V0CiMgQ09ORklHX0RSTV9QQU5FTF9TQU1TVU5HX1M2RThBQTAgaXMg
bm90IHNldAojIENPTkZJR19EUk1fUEFORUxfU0FNU1VOR19TT0ZFRjAwIGlzIG5vdCBzZXQK
IyBDT05GSUdfRFJNX1BBTkVMX1NFSUtPXzQzV1ZGMUcgaXMgbm90IHNldAojIENPTkZJR19E
Uk1fUEFORUxfU0hBUlBfTFExMDFSMVNYMDEgaXMgbm90IHNldAojIENPTkZJR19EUk1fUEFO
RUxfU0hBUlBfTFMwNDNUMUxFMDEgaXMgbm90IHNldAojIENPTkZJR19EUk1fUEFORUxfU0lU
Uk9OSVhfU1Q3NzAxIGlzIG5vdCBzZXQKIyBDT05GSUdfRFJNX1BBTkVMX1NJVFJPTklYX1NU
NzcwMyBpcyBub3Qgc2V0CiMgQ09ORklHX0RSTV9QQU5FTF9TSVRST05JWF9TVDc3ODlWIGlz
IG5vdCBzZXQKIyBDT05GSUdfRFJNX1BBTkVMX1NPTllfQUNYNDI0QUtQIGlzIG5vdCBzZXQK
IyBDT05GSUdfRFJNX1BBTkVMX1NPTllfQUNYNTY1QUtNIGlzIG5vdCBzZXQKIyBDT05GSUdf
RFJNX1BBTkVMX1RET19UTDA3MFdTSDMwIGlzIG5vdCBzZXQKIyBDT05GSUdfRFJNX1BBTkVM
X1RQT19URDAyOFRURUMxIGlzIG5vdCBzZXQKIyBDT05GSUdfRFJNX1BBTkVMX1RQT19UUEcx
MTAgaXMgbm90IHNldAojIENPTkZJR19EUk1fUEFORUxfVFJVTFlfTlQzNTU5N19XUVhHQSBp
cyBub3Qgc2V0CiMgQ09ORklHX0RSTV9QQU5FTF9WSVNJT05PWF9STTY5Mjk5IGlzIG5vdCBz
ZXQKIyBDT05GSUdfRFJNX1BBTkVMX1dJREVDSElQU19XUzI0MDEgaXMgbm90IHNldAojIENP
TkZJR19EUk1fUEFORUxfWElOUEVOR19YUFAwNTVDMjcyIGlzIG5vdCBzZXQKIyBlbmQgb2Yg
RGlzcGxheSBQYW5lbHMKCkNPTkZJR19EUk1fQlJJREdFPXkKQ09ORklHX0RSTV9QQU5FTF9C
UklER0U9eQoKIwojIERpc3BsYXkgSW50ZXJmYWNlIEJyaWRnZXMKIwojIENPTkZJR19EUk1f
Q0ROU19EU0kgaXMgbm90IHNldAojIENPTkZJR19EUk1fQ0hJUE9ORV9JQ042MjExIGlzIG5v
dCBzZXQKIyBDT05GSUdfRFJNX0NIUk9OVEVMX0NINzAzMyBpcyBub3Qgc2V0CiMgQ09ORklH
X0RSTV9DUk9TX0VDX0FOWDc2ODggaXMgbm90IHNldAojIENPTkZJR19EUk1fRElTUExBWV9D
T05ORUNUT1IgaXMgbm90IHNldAojIENPTkZJR19EUk1fTE9OVElVTV9MVDg5MTJCIGlzIG5v
dCBzZXQKIyBDT05GSUdfRFJNX0xPTlRJVU1fTFQ5NjExIGlzIG5vdCBzZXQKIyBDT05GSUdf
RFJNX0xPTlRJVU1fTFQ5NjExVVhDIGlzIG5vdCBzZXQKIyBDT05GSUdfRFJNX0lURV9JVDY2
MTIxIGlzIG5vdCBzZXQKIyBDT05GSUdfRFJNX0xWRFNfQ09ERUMgaXMgbm90IHNldAojIENP
TkZJR19EUk1fTUVHQUNISVBTX1NURFBYWFhYX0dFX0I4NTBWM19GVyBpcyBub3Qgc2V0CiMg
Q09ORklHX0RSTV9OV0xfTUlQSV9EU0kgaXMgbm90IHNldAojIENPTkZJR19EUk1fTlhQX1BU
TjM0NjAgaXMgbm90IHNldAojIENPTkZJR19EUk1fUEFSQURFX1BTODYyMiBpcyBub3Qgc2V0
CiMgQ09ORklHX0RSTV9QQVJBREVfUFM4NjQwIGlzIG5vdCBzZXQKIyBDT05GSUdfRFJNX1NJ
TF9TSUk4NjIwIGlzIG5vdCBzZXQKIyBDT05GSUdfRFJNX1NJSTkwMlggaXMgbm90IHNldAoj
IENPTkZJR19EUk1fU0lJOTIzNCBpcyBub3Qgc2V0CiMgQ09ORklHX0RSTV9TSU1QTEVfQlJJ
REdFIGlzIG5vdCBzZXQKIyBDT05GSUdfRFJNX1RISU5FX1RIQzYzTFZEMTAyNCBpcyBub3Qg
c2V0CiMgQ09ORklHX0RSTV9UT1NISUJBX1RDMzU4NzYyIGlzIG5vdCBzZXQKIyBDT05GSUdf
RFJNX1RPU0hJQkFfVEMzNTg3NjQgaXMgbm90IHNldAojIENPTkZJR19EUk1fVE9TSElCQV9U
QzM1ODc2NyBpcyBub3Qgc2V0CiMgQ09ORklHX0RSTV9UT1NISUJBX1RDMzU4NzY4IGlzIG5v
dCBzZXQKIyBDT05GSUdfRFJNX1RPU0hJQkFfVEMzNTg3NzUgaXMgbm90IHNldAojIENPTkZJ
R19EUk1fVElfVEZQNDEwIGlzIG5vdCBzZXQKIyBDT05GSUdfRFJNX1RJX1NONjVEU0k4MyBp
cyBub3Qgc2V0CiMgQ09ORklHX0RSTV9USV9TTjY1RFNJODYgaXMgbm90IHNldAojIENPTkZJ
R19EUk1fVElfVFBEMTJTMDE1IGlzIG5vdCBzZXQKIyBDT05GSUdfRFJNX0FOQUxPR0lYX0FO
WDYzNDUgaXMgbm90IHNldAojIENPTkZJR19EUk1fQU5BTE9HSVhfQU5YNzhYWCBpcyBub3Qg
c2V0CiMgQ09ORklHX0RSTV9BTkFMT0dJWF9BTlg3NjI1IGlzIG5vdCBzZXQKIyBDT05GSUdf
RFJNX0kyQ19BRFY3NTExIGlzIG5vdCBzZXQKIyBDT05GSUdfRFJNX0NETlNfTUhEUDg1NDYg
aXMgbm90IHNldAojIGVuZCBvZiBEaXNwbGF5IEludGVyZmFjZSBCcmlkZ2VzCgojIENPTkZJ
R19EUk1fRVROQVZJViBpcyBub3Qgc2V0CiMgQ09ORklHX0RSTV9BUkNQR1UgaXMgbm90IHNl
dAojIENPTkZJR19EUk1fQk9DSFMgaXMgbm90IHNldAojIENPTkZJR19EUk1fQ0lSUlVTX1FF
TVUgaXMgbm90IHNldAojIENPTkZJR19EUk1fR00xMlUzMjAgaXMgbm90IHNldAojIENPTkZJ
R19EUk1fU0lNUExFRFJNIGlzIG5vdCBzZXQKIyBDT05GSUdfVElOWURSTV9IWDgzNTdEIGlz
IG5vdCBzZXQKIyBDT05GSUdfVElOWURSTV9JTEk5MjI1IGlzIG5vdCBzZXQKIyBDT05GSUdf
VElOWURSTV9JTEk5MzQxIGlzIG5vdCBzZXQKIyBDT05GSUdfVElOWURSTV9JTEk5NDg2IGlz
IG5vdCBzZXQKIyBDT05GSUdfVElOWURSTV9NSTAyODNRVCBpcyBub3Qgc2V0CiMgQ09ORklH
X1RJTllEUk1fUkVQQVBFUiBpcyBub3Qgc2V0CiMgQ09ORklHX1RJTllEUk1fU1Q3NTg2IGlz
IG5vdCBzZXQKIyBDT05GSUdfVElOWURSTV9TVDc3MzVSIGlzIG5vdCBzZXQKIyBDT05GSUdf
RFJNX1ZCT1hWSURFTyBpcyBub3Qgc2V0CiMgQ09ORklHX0RSTV9HVUQgaXMgbm90IHNldApD
T05GSUdfRFJNX0xFR0FDWT15CiMgQ09ORklHX0RSTV9UREZYIGlzIG5vdCBzZXQKIyBDT05G
SUdfRFJNX1IxMjggaXMgbm90IHNldAojIENPTkZJR19EUk1fTUdBIGlzIG5vdCBzZXQKIyBD
T05GSUdfRFJNX1ZJQSBpcyBub3Qgc2V0CiMgQ09ORklHX0RSTV9TQVZBR0UgaXMgbm90IHNl
dApDT05GSUdfRFJNX1BBTkVMX09SSUVOVEFUSU9OX1FVSVJLUz15CgojCiMgQVJNIEdQVSBD
b25maWd1cmF0aW9uCiMKIyBlbmQgb2YgQVJNIEdQVSBDb25maWd1cmF0aW9uCgojCiMgRnJh
bWUgYnVmZmVyIERldmljZXMKIwpDT05GSUdfRkJfQ01ETElORT15CkNPTkZJR19GQl9OT1RJ
Rlk9eQpDT05GSUdfRkI9eQojIENPTkZJR19GSVJNV0FSRV9FRElEIGlzIG5vdCBzZXQKIyBD
T05GSUdfRkJfRk9SRUlHTl9FTkRJQU4gaXMgbm90IHNldApDT05GSUdfRkJfTU9ERV9IRUxQ
RVJTPXkKIyBDT05GSUdfRkJfVElMRUJMSVRUSU5HIGlzIG5vdCBzZXQKCiMKIyBGcmFtZSBi
dWZmZXIgaGFyZHdhcmUgZHJpdmVycwojCiMgQ09ORklHX0ZCX0NJUlJVUyBpcyBub3Qgc2V0
CiMgQ09ORklHX0ZCX1BNMiBpcyBub3Qgc2V0CiMgQ09ORklHX0ZCX0NZQkVSMjAwMCBpcyBu
b3Qgc2V0CiMgQ09ORklHX0ZCX0FSQyBpcyBub3Qgc2V0CiMgQ09ORklHX0ZCX0FTSUxJQU5U
IGlzIG5vdCBzZXQKIyBDT05GSUdfRkJfSU1TVFQgaXMgbm90IHNldAojIENPTkZJR19GQl9W
R0ExNiBpcyBub3Qgc2V0CiMgQ09ORklHX0ZCX1VWRVNBIGlzIG5vdCBzZXQKIyBDT05GSUdf
RkJfVkVTQSBpcyBub3Qgc2V0CiMgQ09ORklHX0ZCX040MTEgaXMgbm90IHNldAojIENPTkZJ
R19GQl9IR0EgaXMgbm90IHNldAojIENPTkZJR19GQl9PUEVOQ09SRVMgaXMgbm90IHNldAoj
IENPTkZJR19GQl9TMUQxM1hYWCBpcyBub3Qgc2V0CiMgQ09ORklHX0ZCX05WSURJQSBpcyBu
b3Qgc2V0CiMgQ09ORklHX0ZCX1JJVkEgaXMgbm90IHNldAojIENPTkZJR19GQl9JNzQwIGlz
IG5vdCBzZXQKIyBDT05GSUdfRkJfTEU4MDU3OCBpcyBub3Qgc2V0CiMgQ09ORklHX0ZCX01B
VFJPWCBpcyBub3Qgc2V0CiMgQ09ORklHX0ZCX1JBREVPTiBpcyBub3Qgc2V0CiMgQ09ORklH
X0ZCX0FUWTEyOCBpcyBub3Qgc2V0CiMgQ09ORklHX0ZCX0FUWSBpcyBub3Qgc2V0CiMgQ09O
RklHX0ZCX1MzIGlzIG5vdCBzZXQKIyBDT05GSUdfRkJfU0FWQUdFIGlzIG5vdCBzZXQKIyBD
T05GSUdfRkJfU0lTIGlzIG5vdCBzZXQKIyBDT05GSUdfRkJfVklBIGlzIG5vdCBzZXQKIyBD
T05GSUdfRkJfTkVPTUFHSUMgaXMgbm90IHNldAojIENPTkZJR19GQl9LWVJPIGlzIG5vdCBz
ZXQKIyBDT05GSUdfRkJfM0RGWCBpcyBub3Qgc2V0CiMgQ09ORklHX0ZCX1ZPT0RPTzEgaXMg
bm90IHNldAojIENPTkZJR19GQl9WVDg2MjMgaXMgbm90IHNldAojIENPTkZJR19GQl9UUklE
RU5UIGlzIG5vdCBzZXQKIyBDT05GSUdfRkJfQVJLIGlzIG5vdCBzZXQKIyBDT05GSUdfRkJf
UE0zIGlzIG5vdCBzZXQKIyBDT05GSUdfRkJfQ0FSTUlORSBpcyBub3Qgc2V0CiMgQ09ORklH
X0ZCX1NNU0NVRlggaXMgbm90IHNldAojIENPTkZJR19GQl9VREwgaXMgbm90IHNldAojIENP
TkZJR19GQl9JQk1fR1hUNDUwMCBpcyBub3Qgc2V0CiMgQ09ORklHX0ZCX1ZJUlRVQUwgaXMg
bm90IHNldAojIENPTkZJR19GQl9NRVRST05PTUUgaXMgbm90IHNldAojIENPTkZJR19GQl9N
Qjg2MlhYIGlzIG5vdCBzZXQKIyBDT05GSUdfRkJfU0lNUExFIGlzIG5vdCBzZXQKIyBDT05G
SUdfRkJfU1NEMTMwNyBpcyBub3Qgc2V0CiMgQ09ORklHX0ZCX1NNNzEyIGlzIG5vdCBzZXQK
IyBlbmQgb2YgRnJhbWUgYnVmZmVyIERldmljZXMKCiMKIyBCYWNrbGlnaHQgJiBMQ0QgZGV2
aWNlIHN1cHBvcnQKIwojIENPTkZJR19MQ0RfQ0xBU1NfREVWSUNFIGlzIG5vdCBzZXQKQ09O
RklHX0JBQ0tMSUdIVF9DTEFTU19ERVZJQ0U9eQojIENPTkZJR19CQUNLTElHSFRfS1REMjUz
IGlzIG5vdCBzZXQKIyBDT05GSUdfQkFDS0xJR0hUX0FQUExFIGlzIG5vdCBzZXQKIyBDT05G
SUdfQkFDS0xJR0hUX1FDT01fV0xFRCBpcyBub3Qgc2V0CiMgQ09ORklHX0JBQ0tMSUdIVF9T
QUhBUkEgaXMgbm90IHNldAojIENPTkZJR19CQUNLTElHSFRfQURQODg2MCBpcyBub3Qgc2V0
CiMgQ09ORklHX0JBQ0tMSUdIVF9BRFA4ODcwIGlzIG5vdCBzZXQKIyBDT05GSUdfQkFDS0xJ
R0hUX0xNMzYzOSBpcyBub3Qgc2V0CiMgQ09ORklHX0JBQ0tMSUdIVF9HUElPIGlzIG5vdCBz
ZXQKIyBDT05GSUdfQkFDS0xJR0hUX0xWNTIwN0xQIGlzIG5vdCBzZXQKIyBDT05GSUdfQkFD
S0xJR0hUX0JENjEwNyBpcyBub3Qgc2V0CiMgQ09ORklHX0JBQ0tMSUdIVF9BUkNYQ05OIGlz
IG5vdCBzZXQKIyBDT05GSUdfQkFDS0xJR0hUX0xFRCBpcyBub3Qgc2V0CiMgZW5kIG9mIEJh
Y2tsaWdodCAmIExDRCBkZXZpY2Ugc3VwcG9ydAoKQ09ORklHX0hETUk9eQoKIwojIENvbnNv
bGUgZGlzcGxheSBkcml2ZXIgc3VwcG9ydAojCkNPTkZJR19WR0FfQ09OU09MRT15CkNPTkZJ
R19EVU1NWV9DT05TT0xFPXkKQ09ORklHX0RVTU1ZX0NPTlNPTEVfQ09MVU1OUz04MApDT05G
SUdfRFVNTVlfQ09OU09MRV9ST1dTPTI1CkNPTkZJR19GUkFNRUJVRkZFUl9DT05TT0xFPXkK
IyBDT05GSUdfRlJBTUVCVUZGRVJfQ09OU09MRV9MRUdBQ1lfQUNDRUxFUkFUSU9OIGlzIG5v
dCBzZXQKQ09ORklHX0ZSQU1FQlVGRkVSX0NPTlNPTEVfREVURUNUX1BSSU1BUlk9eQojIENP
TkZJR19GUkFNRUJVRkZFUl9DT05TT0xFX1JPVEFUSU9OIGlzIG5vdCBzZXQKIyBDT05GSUdf
RlJBTUVCVUZGRVJfQ09OU09MRV9ERUZFUlJFRF9UQUtFT1ZFUiBpcyBub3Qgc2V0CiMgZW5k
IG9mIENvbnNvbGUgZGlzcGxheSBkcml2ZXIgc3VwcG9ydAoKIyBDT05GSUdfTE9HTyBpcyBu
b3Qgc2V0CiMgZW5kIG9mIEdyYXBoaWNzIHN1cHBvcnQKCkNPTkZJR19TT1VORD15CkNPTkZJ
R19TTkQ9eQpDT05GSUdfU05EX1RJTUVSPXkKQ09ORklHX1NORF9QQ009eQpDT05GSUdfU05E
X1BDTV9FTEQ9eQpDT05GSUdfU05EX0hXREVQPXkKQ09ORklHX1NORF9TRVFfREVWSUNFPXkK
Q09ORklHX1NORF9SQVdNSURJPXkKQ09ORklHX1NORF9DT01QUkVTU19PRkZMT0FEPXkKQ09O
RklHX1NORF9KQUNLPXkKQ09ORklHX1NORF9KQUNLX0lOUFVUX0RFVj15CiMgQ09ORklHX1NO
RF9PU1NFTVVMIGlzIG5vdCBzZXQKQ09ORklHX1NORF9QQ01fVElNRVI9eQpDT05GSUdfU05E
X0hSVElNRVI9eQpDT05GSUdfU05EX0RZTkFNSUNfTUlOT1JTPXkKQ09ORklHX1NORF9NQVhf
Q0FSRFM9MzIKQ09ORklHX1NORF9TVVBQT1JUX09MRF9BUEk9eQpDT05GSUdfU05EX1BST0Nf
RlM9eQpDT05GSUdfU05EX1ZFUkJPU0VfUFJPQ0ZTPXkKIyBDT05GSUdfU05EX1ZFUkJPU0Vf
UFJJTlRLIGlzIG5vdCBzZXQKQ09ORklHX1NORF9ERUJVRz15CiMgQ09ORklHX1NORF9ERUJV
R19WRVJCT1NFIGlzIG5vdCBzZXQKQ09ORklHX1NORF9QQ01fWFJVTl9ERUJVRz15CkNPTkZJ
R19TTkRfQ1RMX1ZBTElEQVRJT049eQpDT05GSUdfU05EX1ZNQVNURVI9eQpDT05GSUdfU05E
X0RNQV9TR0JVRj15CkNPTkZJR19TTkRfQ1RMX0xFRD15CkNPTkZJR19TTkRfU0VRVUVOQ0VS
PXkKQ09ORklHX1NORF9TRVFfRFVNTVk9eQpDT05GSUdfU05EX1NFUV9IUlRJTUVSX0RFRkFV
TFQ9eQpDT05GSUdfU05EX1NFUV9NSURJX0VWRU5UPXkKQ09ORklHX1NORF9TRVFfTUlEST15
CkNPTkZJR19TTkRfRFJJVkVSUz15CiMgQ09ORklHX1NORF9EVU1NWSBpcyBub3Qgc2V0CkNP
TkZJR19TTkRfQUxPT1A9eQojIENPTkZJR19TTkRfVklSTUlESSBpcyBub3Qgc2V0CiMgQ09O
RklHX1NORF9NVFBBViBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9TRVJJQUxfVTE2NTUwIGlz
IG5vdCBzZXQKIyBDT05GSUdfU05EX01QVTQwMSBpcyBub3Qgc2V0CkNPTkZJR19TTkRfUENJ
PXkKIyBDT05GSUdfU05EX0FEMTg4OSBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9BTFMzMDAg
aXMgbm90IHNldAojIENPTkZJR19TTkRfQUxTNDAwMCBpcyBub3Qgc2V0CiMgQ09ORklHX1NO
RF9BTEk1NDUxIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX0FTSUhQSSBpcyBub3Qgc2V0CiMg
Q09ORklHX1NORF9BVElJWFAgaXMgbm90IHNldAojIENPTkZJR19TTkRfQVRJSVhQX01PREVN
IGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX0FVODgxMCBpcyBub3Qgc2V0CiMgQ09ORklHX1NO
RF9BVTg4MjAgaXMgbm90IHNldAojIENPTkZJR19TTkRfQVU4ODMwIGlzIG5vdCBzZXQKIyBD
T05GSUdfU05EX0FXMiBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9BWlQzMzI4IGlzIG5vdCBz
ZXQKIyBDT05GSUdfU05EX0JUODdYIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX0NBMDEwNiBp
cyBub3Qgc2V0CiMgQ09ORklHX1NORF9DTUlQQ0kgaXMgbm90IHNldAojIENPTkZJR19TTkRf
T1hZR0VOIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX0NTNDI4MSBpcyBub3Qgc2V0CiMgQ09O
RklHX1NORF9DUzQ2WFggaXMgbm90IHNldAojIENPTkZJR19TTkRfQ1RYRkkgaXMgbm90IHNl
dAojIENPTkZJR19TTkRfREFSTEEyMCBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9HSU5BMjAg
aXMgbm90IHNldAojIENPTkZJR19TTkRfTEFZTEEyMCBpcyBub3Qgc2V0CiMgQ09ORklHX1NO
RF9EQVJMQTI0IGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX0dJTkEyNCBpcyBub3Qgc2V0CiMg
Q09ORklHX1NORF9MQVlMQTI0IGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX01PTkEgaXMgbm90
IHNldAojIENPTkZJR19TTkRfTUlBIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX0VDSE8zRyBp
cyBub3Qgc2V0CiMgQ09ORklHX1NORF9JTkRJR08gaXMgbm90IHNldAojIENPTkZJR19TTkRf
SU5ESUdPSU8gaXMgbm90IHNldAojIENPTkZJR19TTkRfSU5ESUdPREogaXMgbm90IHNldAoj
IENPTkZJR19TTkRfSU5ESUdPSU9YIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX0lORElHT0RK
WCBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9FTVUxMEsxIGlzIG5vdCBzZXQKIyBDT05GSUdf
U05EX0VNVTEwSzFYIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX0VOUzEzNzAgaXMgbm90IHNl
dAojIENPTkZJR19TTkRfRU5TMTM3MSBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9FUzE5Mzgg
aXMgbm90IHNldAojIENPTkZJR19TTkRfRVMxOTY4IGlzIG5vdCBzZXQKIyBDT05GSUdfU05E
X0ZNODAxIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX0hEU1AgaXMgbm90IHNldAojIENPTkZJ
R19TTkRfSERTUE0gaXMgbm90IHNldAojIENPTkZJR19TTkRfSUNFMTcxMiBpcyBub3Qgc2V0
CiMgQ09ORklHX1NORF9JQ0UxNzI0IGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX0lOVEVMOFgw
IGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX0lOVEVMOFgwTSBpcyBub3Qgc2V0CiMgQ09ORklH
X1NORF9LT1JHMTIxMiBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9MT0xBIGlzIG5vdCBzZXQK
IyBDT05GSUdfU05EX0xYNjQ2NEVTIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX01BRVNUUk8z
IGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX01JWEFSVCBpcyBub3Qgc2V0CiMgQ09ORklHX1NO
RF9OTTI1NiBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9QQ1hIUiBpcyBub3Qgc2V0CiMgQ09O
RklHX1NORF9SSVBUSURFIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX1JNRTMyIGlzIG5vdCBz
ZXQKIyBDT05GSUdfU05EX1JNRTk2IGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX1JNRTk2NTIg
aXMgbm90IHNldAojIENPTkZJR19TTkRfU0U2WCBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9T
T05JQ1ZJQkVTIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX1RSSURFTlQgaXMgbm90IHNldAoj
IENPTkZJR19TTkRfVklBODJYWCBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9WSUE4MlhYX01P
REVNIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX1ZJUlRVT1NPIGlzIG5vdCBzZXQKIyBDT05G
SUdfU05EX1ZYMjIyIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX1lNRlBDSSBpcyBub3Qgc2V0
CgojCiMgSEQtQXVkaW8KIwpDT05GSUdfU05EX0hEQT15CkNPTkZJR19TTkRfSERBX0dFTkVS
SUNfTEVEUz15CkNPTkZJR19TTkRfSERBX0lOVEVMPXkKQ09ORklHX1NORF9IREFfSFdERVA9
eQpDT05GSUdfU05EX0hEQV9SRUNPTkZJRz15CiMgQ09ORklHX1NORF9IREFfSU5QVVRfQkVF
UCBpcyBub3Qgc2V0CkNPTkZJR19TTkRfSERBX1BBVENIX0xPQURFUj15CiMgQ09ORklHX1NO
RF9IREFfU0NPREVDX0NTMzVMNDFfSTJDIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX0hEQV9T
Q09ERUNfQ1MzNUw0MV9TUEkgaXMgbm90IHNldApDT05GSUdfU05EX0hEQV9DT0RFQ19SRUFM
VEVLPXkKQ09ORklHX1NORF9IREFfQ09ERUNfQU5BTE9HPXkKQ09ORklHX1NORF9IREFfQ09E
RUNfU0lHTUFURUw9eQpDT05GSUdfU05EX0hEQV9DT0RFQ19WSUE9eQpDT05GSUdfU05EX0hE
QV9DT0RFQ19IRE1JPXkKQ09ORklHX1NORF9IREFfQ09ERUNfQ0lSUlVTPXkKIyBDT05GSUdf
U05EX0hEQV9DT0RFQ19DUzg0MDkgaXMgbm90IHNldApDT05GSUdfU05EX0hEQV9DT0RFQ19D
T05FWEFOVD15CkNPTkZJR19TTkRfSERBX0NPREVDX0NBMDExMD15CkNPTkZJR19TTkRfSERB
X0NPREVDX0NBMDEzMj15CkNPTkZJR19TTkRfSERBX0NPREVDX0NBMDEzMl9EU1A9eQpDT05G
SUdfU05EX0hEQV9DT0RFQ19DTUVESUE9eQpDT05GSUdfU05EX0hEQV9DT0RFQ19TSTMwNTQ9
eQpDT05GSUdfU05EX0hEQV9HRU5FUklDPXkKQ09ORklHX1NORF9IREFfUE9XRVJfU0FWRV9E
RUZBVUxUPTE1CiMgQ09ORklHX1NORF9IREFfSU5URUxfSERNSV9TSUxFTlRfU1RSRUFNIGlz
IG5vdCBzZXQKIyBlbmQgb2YgSEQtQXVkaW8KCkNPTkZJR19TTkRfSERBX0NPUkU9eQpDT05G
SUdfU05EX0hEQV9EU1BfTE9BREVSPXkKQ09ORklHX1NORF9IREFfQ09NUE9ORU5UPXkKQ09O
RklHX1NORF9IREFfSTkxNT15CkNPTkZJR19TTkRfSERBX0VYVF9DT1JFPXkKQ09ORklHX1NO
RF9IREFfUFJFQUxMT0NfU0laRT0wCkNPTkZJR19TTkRfSU5URUxfTkhMVD15CkNPTkZJR19T
TkRfSU5URUxfRFNQX0NPTkZJRz15CkNPTkZJR19TTkRfSU5URUxfU09VTkRXSVJFX0FDUEk9
eQojIENPTkZJR19TTkRfSU5URUxfQllUX1BSRUZFUl9TT0YgaXMgbm90IHNldAojIENPTkZJ
R19TTkRfU1BJIGlzIG5vdCBzZXQKQ09ORklHX1NORF9VU0I9eQpDT05GSUdfU05EX1VTQl9B
VURJTz15CkNPTkZJR19TTkRfVVNCX0FVRElPX1VTRV9NRURJQV9DT05UUk9MTEVSPXkKIyBD
T05GSUdfU05EX1VTQl9VQTEwMSBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9VU0JfVVNYMlkg
aXMgbm90IHNldAojIENPTkZJR19TTkRfVVNCX0NBSUFRIGlzIG5vdCBzZXQKIyBDT05GSUdf
U05EX1VTQl9VUzEyMkwgaXMgbm90IHNldAojIENPTkZJR19TTkRfVVNCXzZGSVJFIGlzIG5v
dCBzZXQKIyBDT05GSUdfU05EX1VTQl9ISUZBQ0UgaXMgbm90IHNldAojIENPTkZJR19TTkRf
QkNEMjAwMCBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9VU0JfUE9EIGlzIG5vdCBzZXQKIyBD
T05GSUdfU05EX1VTQl9QT0RIRCBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9VU0JfVE9ORVBP
UlQgaXMgbm90IHNldAojIENPTkZJR19TTkRfVVNCX1ZBUklBWCBpcyBub3Qgc2V0CkNPTkZJ
R19TTkRfU09DPXkKQ09ORklHX1NORF9TT0NfQ09NUFJFU1M9eQpDT05GSUdfU05EX1NPQ19U
T1BPTE9HWT15CkNPTkZJR19TTkRfU09DX0FDUEk9eQojIENPTkZJR19TTkRfU09DX0FNRF9B
Q1AgaXMgbm90IHNldAojIENPTkZJR19TTkRfU09DX0FNRF9BQ1AzeCBpcyBub3Qgc2V0CiMg
Q09ORklHX1NORF9TT0NfQU1EX1JFTk9JUiBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9BTURf
QUNQX0NPTkZJRyBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9TT0NfQU1EX0FDUF9DT01NT04g
aXMgbm90IHNldAojIENPTkZJR19TTkRfQVRNRUxfU09DIGlzIG5vdCBzZXQKIyBDT05GSUdf
U05EX0JDTTYzWFhfSTJTX1dISVNUTEVSIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX0RFU0lH
TldBUkVfSTJTIGlzIG5vdCBzZXQKCiMKIyBTb0MgQXVkaW8gZm9yIEZyZWVzY2FsZSBDUFVz
CiMKCiMKIyBDb21tb24gU29DIEF1ZGlvIG9wdGlvbnMgZm9yIEZyZWVzY2FsZSBDUFVzOgoj
CiMgQ09ORklHX1NORF9TT0NfRlNMX0FTUkMgaXMgbm90IHNldAojIENPTkZJR19TTkRfU09D
X0ZTTF9TQUkgaXMgbm90IHNldAojIENPTkZJR19TTkRfU09DX0ZTTF9BVURNSVggaXMgbm90
IHNldAojIENPTkZJR19TTkRfU09DX0ZTTF9TU0kgaXMgbm90IHNldAojIENPTkZJR19TTkRf
U09DX0ZTTF9TUERJRiBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9TT0NfRlNMX0VTQUkgaXMg
bm90IHNldAojIENPTkZJR19TTkRfU09DX0ZTTF9NSUNGSUwgaXMgbm90IHNldAojIENPTkZJ
R19TTkRfU09DX0lNWF9BVURNVVggaXMgbm90IHNldAojIGVuZCBvZiBTb0MgQXVkaW8gZm9y
IEZyZWVzY2FsZSBDUFVzCgojIENPTkZJR19TTkRfSTJTX0hJNjIxMF9JMlMgaXMgbm90IHNl
dAojIENPTkZJR19TTkRfU09DX0lNRyBpcyBub3Qgc2V0CkNPTkZJR19TTkRfU09DX0lOVEVM
X1NTVF9UT1BMRVZFTD15CkNPTkZJR19TTkRfU09DX0lOVEVMX1NTVD15CiMgQ09ORklHX1NO
RF9TT0NfSU5URUxfQ0FUUFQgaXMgbm90IHNldApDT05GSUdfU05EX1NTVF9BVE9NX0hJRkky
X1BMQVRGT1JNPXkKIyBDT05GSUdfU05EX1NTVF9BVE9NX0hJRkkyX1BMQVRGT1JNX1BDSSBp
cyBub3Qgc2V0CkNPTkZJR19TTkRfU1NUX0FUT01fSElGSTJfUExBVEZPUk1fQUNQST15CkNP
TkZJR19TTkRfU09DX0lOVEVMX1NLWUxBS0U9eQpDT05GSUdfU05EX1NPQ19JTlRFTF9TS0w9
eQpDT05GSUdfU05EX1NPQ19JTlRFTF9BUEw9eQpDT05GSUdfU05EX1NPQ19JTlRFTF9LQkw9
eQpDT05GSUdfU05EX1NPQ19JTlRFTF9HTEs9eQpDT05GSUdfU05EX1NPQ19JTlRFTF9DTkw9
eQpDT05GSUdfU05EX1NPQ19JTlRFTF9DRkw9eQpDT05GSUdfU05EX1NPQ19JTlRFTF9DTUxf
SD15CkNPTkZJR19TTkRfU09DX0lOVEVMX0NNTF9MUD15CkNPTkZJR19TTkRfU09DX0lOVEVM
X1NLWUxBS0VfRkFNSUxZPXkKIyBDT05GSUdfU05EX1NPQ19JTlRFTF9TS1lMQUtFX0hEQVVE
SU9fQ09ERUMgaXMgbm90IHNldApDT05GSUdfU05EX1NPQ19JTlRFTF9TS1lMQUtFX0NPTU1P
Tj15CkNPTkZJR19TTkRfU09DX0FDUElfSU5URUxfTUFUQ0g9eQojIENPTkZJR19TTkRfU09D
X0lOVEVMX0FWUyBpcyBub3Qgc2V0CkNPTkZJR19TTkRfU09DX0lOVEVMX01BQ0g9eQojIENP
TkZJR19TTkRfU09DX0lOVEVMX1VTRVJfRlJJRU5ETFlfTE9OR19OQU1FUyBpcyBub3Qgc2V0
CkNPTkZJR19TTkRfU09DX0lOVEVMX0hEQV9EU1BfQ09NTU9OPXkKIyBDT05GSUdfU05EX1NP
Q19JTlRFTF9CRFdfUlQ1NjUwX01BQ0ggaXMgbm90IHNldAojIENPTkZJR19TTkRfU09DX0lO
VEVMX0JEV19SVDU2NzdfTUFDSCBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9TT0NfSU5URUxf
QlJPQURXRUxMX01BQ0ggaXMgbm90IHNldAojIENPTkZJR19TTkRfU09DX0lOVEVMX0JZVENS
X1JUNTY0MF9NQUNIIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX1NPQ19JTlRFTF9CWVRDUl9S
VDU2NTFfTUFDSCBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9TT0NfSU5URUxfQ0hUX0JTV19S
VDU2NzJfTUFDSCBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9TT0NfSU5URUxfQ0hUX0JTV19S
VDU2NDVfTUFDSCBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9TT0NfSU5URUxfQ0hUX0JTV19N
QVg5ODA5MF9USV9NQUNIIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX1NPQ19JTlRFTF9DSFRf
QlNXX05BVTg4MjRfTUFDSCBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9TT0NfSU5URUxfQllU
X0NIVF9DWDIwNzJYX01BQ0ggaXMgbm90IHNldAojIENPTkZJR19TTkRfU09DX0lOVEVMX0JZ
VF9DSFRfREE3MjEzX01BQ0ggaXMgbm90IHNldAojIENPTkZJR19TTkRfU09DX0lOVEVMX0JZ
VF9DSFRfRVM4MzE2X01BQ0ggaXMgbm90IHNldAojIENPTkZJR19TTkRfU09DX0lOVEVMX0JZ
VF9DSFRfTk9DT0RFQ19NQUNIIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX1NPQ19JTlRFTF9T
S0xfUlQyODZfTUFDSCBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9TT0NfSU5URUxfU0tMX05B
VTg4TDI1X1NTTTQ1NjdfTUFDSCBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9TT0NfSU5URUxf
U0tMX05BVTg4TDI1X01BWDk4MzU3QV9NQUNIIGlzIG5vdCBzZXQKQ09ORklHX1NORF9TT0Nf
SU5URUxfREE3MjE5X01BWDk4MzU3QV9HRU5FUklDPXkKQ09ORklHX1NORF9TT0NfSU5URUxf
QlhUX0RBNzIxOV9NQVg5ODM1N0FfQ09NTU9OPXkKQ09ORklHX1NORF9TT0NfSU5URUxfQlhU
X0RBNzIxOV9NQVg5ODM1N0FfTUFDSD15CiMgQ09ORklHX1NORF9TT0NfSU5URUxfQlhUX1JU
Mjk4X01BQ0ggaXMgbm90IHNldAojIENPTkZJR19TTkRfU09DX0lOVEVMX1NPRl9XTTg4MDRf
TUFDSCBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9TT0NfSU5URUxfS0JMX1JUNTY2M19NQVg5
ODkyN19NQUNIIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX1NPQ19JTlRFTF9LQkxfUlQ1NjYz
X1JUNTUxNF9NQVg5ODkyN19NQUNIIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX1NPQ19JTlRF
TF9LQkxfREE3MjE5X01BWDk4MzU3QV9NQUNIIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX1NP
Q19JTlRFTF9LQkxfREE3MjE5X01BWDk4OTI3X01BQ0ggaXMgbm90IHNldAojIENPTkZJR19T
TkRfU09DX0lOVEVMX0tCTF9SVDU2NjBfTUFDSCBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9T
T0NfSU5URUxfU09GX1JUNTY4Ml9NQUNIIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX1NPQ19J
TlRFTF9TT0ZfUENNNTEyeF9NQUNIIGlzIG5vdCBzZXQKQ09ORklHX1NORF9TT0NfSU5URUxf
Q01MX0xQX0RBNzIxOV9NQVg5ODM1N0FfTUFDSD15CiMgQ09ORklHX1NORF9TT0NfSU5URUxf
U09GX1NTUF9BTVBfTUFDSCBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9TT0NfTVRLX0JUQ1ZT
RCBpcyBub3Qgc2V0CkNPTkZJR19TTkRfU09DX1NPRl9UT1BMRVZFTD15CkNPTkZJR19TTkRf
U09DX1NPRl9QQ0lfREVWPXkKQ09ORklHX1NORF9TT0NfU09GX1BDST15CkNPTkZJR19TTkRf
U09DX1NPRl9BQ1BJPXkKQ09ORklHX1NORF9TT0NfU09GX0FDUElfREVWPXkKIyBDT05GSUdf
U05EX1NPQ19TT0ZfT0YgaXMgbm90IHNldApDT05GSUdfU05EX1NPQ19TT0ZfREVCVUdfUFJP
QkVTPXkKQ09ORklHX1NORF9TT0NfU09GX0NMSUVOVD15CiMgQ09ORklHX1NORF9TT0NfU09G
X0RFVkVMT1BFUl9TVVBQT1JUIGlzIG5vdCBzZXQKQ09ORklHX1NORF9TT0NfU09GPXkKQ09O
RklHX1NORF9TT0NfU09GX1BST0JFX1dPUktfUVVFVUU9eQojIENPTkZJR19TTkRfU09DX1NP
Rl9BTURfVE9QTEVWRUwgaXMgbm90IHNldApDT05GSUdfU05EX1NPQ19TT0ZfSU5URUxfVE9Q
TEVWRUw9eQpDT05GSUdfU05EX1NPQ19TT0ZfSU5URUxfSElGSV9FUF9JUEM9eQpDT05GSUdf
U05EX1NPQ19TT0ZfSU5URUxfQVRPTV9ISUZJX0VQPXkKQ09ORklHX1NORF9TT0NfU09GX0lO
VEVMX0NPTU1PTj15CkNPTkZJR19TTkRfU09DX1NPRl9CQVlUUkFJTD15CkNPTkZJR19TTkRf
U09DX1NPRl9CUk9BRFdFTEw9eQpDT05GSUdfU05EX1NPQ19TT0ZfTUVSUklGSUVMRD15CkNP
TkZJR19TTkRfU09DX1NPRl9JTlRFTF9BUEw9eQpDT05GSUdfU05EX1NPQ19TT0ZfQVBPTExP
TEFLRT15CkNPTkZJR19TTkRfU09DX1NPRl9HRU1JTklMQUtFPXkKQ09ORklHX1NORF9TT0Nf
U09GX0lOVEVMX0NOTD15CkNPTkZJR19TTkRfU09DX1NPRl9DQU5OT05MQUtFPXkKQ09ORklH
X1NORF9TT0NfU09GX0NPRkZFRUxBS0U9eQpDT05GSUdfU05EX1NPQ19TT0ZfQ09NRVRMQUtF
PXkKQ09ORklHX1NORF9TT0NfU09GX0lOVEVMX0lDTD15CkNPTkZJR19TTkRfU09DX1NPRl9J
Q0VMQUtFPXkKQ09ORklHX1NORF9TT0NfU09GX0pBU1BFUkxBS0U9eQpDT05GSUdfU05EX1NP
Q19TT0ZfSU5URUxfVEdMPXkKQ09ORklHX1NORF9TT0NfU09GX1RJR0VSTEFLRT15CkNPTkZJ
R19TTkRfU09DX1NPRl9FTEtIQVJUTEFLRT15CkNPTkZJR19TTkRfU09DX1NPRl9BTERFUkxB
S0U9eQpDT05GSUdfU05EX1NPQ19TT0ZfSERBX0NPTU1PTj15CkNPTkZJR19TTkRfU09DX1NP
Rl9IREFfTElOSz15CiMgQ09ORklHX1NORF9TT0NfU09GX0hEQV9BVURJT19DT0RFQyBpcyBu
b3Qgc2V0CkNPTkZJR19TTkRfU09DX1NPRl9IREFfTElOS19CQVNFTElORT15CkNPTkZJR19T
TkRfU09DX1NPRl9IREE9eQpDT05GSUdfU05EX1NPQ19TT0ZfSERBX1BST0JFUz15CkNPTkZJ
R19TTkRfU09DX1NPRl9JTlRFTF9TT1VORFdJUkVfTElOS19CQVNFTElORT15CkNPTkZJR19T
TkRfU09DX1NPRl9JTlRFTF9TT1VORFdJUkU9eQpDT05GSUdfU05EX1NPQ19TT0ZfWFRFTlNB
PXkKCiMKIyBTVE1pY3JvZWxlY3Ryb25pY3MgU1RNMzIgU09DIGF1ZGlvIHN1cHBvcnQKIwoj
IGVuZCBvZiBTVE1pY3JvZWxlY3Ryb25pY3MgU1RNMzIgU09DIGF1ZGlvIHN1cHBvcnQKCiMg
Q09ORklHX1NORF9TT0NfWElMSU5YX0kyUyBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9TT0Nf
WElMSU5YX0FVRElPX0ZPUk1BVFRFUiBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9TT0NfWElM
SU5YX1NQRElGIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX1NPQ19YVEZQR0FfSTJTIGlzIG5v
dCBzZXQKIyBDT05GSUdfWlhfVERNIGlzIG5vdCBzZXQKQ09ORklHX1NORF9TT0NfSTJDX0FO
RF9TUEk9eQoKIwojIENPREVDIGRyaXZlcnMKIwojIENPTkZJR19TTkRfU09DX0FDOTdfQ09E
RUMgaXMgbm90IHNldAojIENPTkZJR19TTkRfU09DX0FEQVUxMzcyX0kyQyBpcyBub3Qgc2V0
CiMgQ09ORklHX1NORF9TT0NfQURBVTEzNzJfU1BJIGlzIG5vdCBzZXQKIyBDT05GSUdfU05E
X1NPQ19BREFVMTcwMSBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9TT0NfQURBVTE3NjFfSTJD
IGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX1NPQ19BREFVMTc2MV9TUEkgaXMgbm90IHNldApD
T05GSUdfU05EX1NPQ19BREFVNzAwMj15CiMgQ09ORklHX1NORF9TT0NfQURBVTcxMThfSFcg
aXMgbm90IHNldAojIENPTkZJR19TTkRfU09DX0FEQVU3MTE4X0kyQyBpcyBub3Qgc2V0CiMg
Q09ORklHX1NORF9TT0NfQUs0MTA0IGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX1NPQ19BSzQx
MTggaXMgbm90IHNldAojIENPTkZJR19TTkRfU09DX0FLNDQ1OCBpcyBub3Qgc2V0CiMgQ09O
RklHX1NORF9TT0NfQUs0NTU0IGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX1NPQ19BSzQ2MTMg
aXMgbm90IHNldAojIENPTkZJR19TTkRfU09DX0FLNDY0MiBpcyBub3Qgc2V0CiMgQ09ORklH
X1NORF9TT0NfQUs1Mzg2IGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX1NPQ19BSzU1NTggaXMg
bm90IHNldAojIENPTkZJR19TTkRfU09DX0FMQzU2MjMgaXMgbm90IHNldAojIENPTkZJR19T
TkRfU09DX0JEMjg2MjMgaXMgbm90IHNldAojIENPTkZJR19TTkRfU09DX0JUX1NDTyBpcyBu
b3Qgc2V0CiMgQ09ORklHX1NORF9TT0NfQ1JPU19FQ19DT0RFQyBpcyBub3Qgc2V0CiMgQ09O
RklHX1NORF9TT0NfQ1MzNUwzMiBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9TT0NfQ1MzNUwz
MyBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9TT0NfQ1MzNUwzNCBpcyBub3Qgc2V0CiMgQ09O
RklHX1NORF9TT0NfQ1MzNUwzNSBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9TT0NfQ1MzNUwz
NiBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9TT0NfQ1MzNUw0MV9TUEkgaXMgbm90IHNldAoj
IENPTkZJR19TTkRfU09DX0NTMzVMNDFfSTJDIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX1NP
Q19DUzQyTDQyIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX1NPQ19DUzQyTDUxX0kyQyBpcyBu
b3Qgc2V0CiMgQ09ORklHX1NORF9TT0NfQ1M0Mkw1MiBpcyBub3Qgc2V0CiMgQ09ORklHX1NO
RF9TT0NfQ1M0Mkw1NiBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9TT0NfQ1M0Mkw3MyBpcyBu
b3Qgc2V0CiMgQ09ORklHX1NORF9TT0NfQ1M0MjM0IGlzIG5vdCBzZXQKIyBDT05GSUdfU05E
X1NPQ19DUzQyNjUgaXMgbm90IHNldAojIENPTkZJR19TTkRfU09DX0NTNDI3MCBpcyBub3Qg
c2V0CiMgQ09ORklHX1NORF9TT0NfQ1M0MjcxX0kyQyBpcyBub3Qgc2V0CiMgQ09ORklHX1NO
RF9TT0NfQ1M0MjcxX1NQSSBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9TT0NfQ1M0MlhYOF9J
MkMgaXMgbm90IHNldAojIENPTkZJR19TTkRfU09DX0NTNDMxMzAgaXMgbm90IHNldAojIENP
TkZJR19TTkRfU09DX0NTNDM0MSBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9TT0NfQ1M0MzQ5
IGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX1NPQ19DUzUzTDMwIGlzIG5vdCBzZXQKIyBDT05G
SUdfU05EX1NPQ19DWDIwNzJYIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX1NPQ19EQTcyMTMg
aXMgbm90IHNldApDT05GSUdfU05EX1NPQ19EQTcyMTk9eQpDT05GSUdfU05EX1NPQ19ETUlD
PXkKIyBDT05GSUdfU05EX1NPQ19FUzcxMzQgaXMgbm90IHNldAojIENPTkZJR19TTkRfU09D
X0VTNzI0MSBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9TT0NfRVM4MzE2IGlzIG5vdCBzZXQK
IyBDT05GSUdfU05EX1NPQ19FUzgzMjhfSTJDIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX1NP
Q19FUzgzMjhfU1BJIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX1NPQ19HVE02MDEgaXMgbm90
IHNldApDT05GSUdfU05EX1NPQ19IREFDX0hETUk9eQojIENPTkZJR19TTkRfU09DX0hEQSBp
cyBub3Qgc2V0CiMgQ09ORklHX1NORF9TT0NfSU5OT19SSzMwMzYgaXMgbm90IHNldAojIENP
TkZJR19TTkRfU09DX01BWDk4MDg4IGlzIG5vdCBzZXQKQ09ORklHX1NORF9TT0NfTUFYOTgz
NTdBPXkKIyBDT05GSUdfU05EX1NPQ19NQVg5ODUwNCBpcyBub3Qgc2V0CiMgQ09ORklHX1NO
RF9TT0NfTUFYOTg2NyBpcyBub3Qgc2V0CkNPTkZJR19TTkRfU09DX01BWDk4OTI3PXkKIyBD
T05GSUdfU05EX1NPQ19NQVg5ODM3M19JMkMgaXMgbm90IHNldAojIENPTkZJR19TTkRfU09D
X01BWDk4MzczX1NEVyBpcyBub3Qgc2V0CkNPTkZJR19TTkRfU09DX01BWDk4MzkwPXkKIyBD
T05GSUdfU05EX1NPQ19NQVg5ODM5NiBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9TT0NfTUFY
OTg2MCBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9TT0NfTVNNODkxNl9XQ0RfRElHSVRBTCBp
cyBub3Qgc2V0CiMgQ09ORklHX1NORF9TT0NfUENNMTY4MSBpcyBub3Qgc2V0CiMgQ09ORklH
X1NORF9TT0NfUENNMTc4OV9JMkMgaXMgbm90IHNldAojIENPTkZJR19TTkRfU09DX1BDTTE3
OVhfSTJDIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX1NPQ19QQ00xNzlYX1NQSSBpcyBub3Qg
c2V0CiMgQ09ORklHX1NORF9TT0NfUENNMTg2WF9JMkMgaXMgbm90IHNldAojIENPTkZJR19T
TkRfU09DX1BDTTE4NlhfU1BJIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX1NPQ19QQ00zMDYw
X0kyQyBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9TT0NfUENNMzA2MF9TUEkgaXMgbm90IHNl
dAojIENPTkZJR19TTkRfU09DX1BDTTMxNjhBX0kyQyBpcyBub3Qgc2V0CiMgQ09ORklHX1NO
RF9TT0NfUENNMzE2OEFfU1BJIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX1NPQ19QQ001MTJ4
X0kyQyBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9TT0NfUENNNTEyeF9TUEkgaXMgbm90IHNl
dAojIENPTkZJR19TTkRfU09DX1JLMzMyOCBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9TT0Nf
UlQxMzA4X1NEVyBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9TT0NfUlQ1NjE2IGlzIG5vdCBz
ZXQKIyBDT05GSUdfU05EX1NPQ19SVDU2MzEgaXMgbm90IHNldAojIENPTkZJR19TTkRfU09D
X1JUNTY4Ml9TRFcgaXMgbm90IHNldAojIENPTkZJR19TTkRfU09DX1JUNzAwX1NEVyBpcyBu
b3Qgc2V0CiMgQ09ORklHX1NORF9TT0NfUlQ3MTFfU0RXIGlzIG5vdCBzZXQKIyBDT05GSUdf
U05EX1NPQ19SVDcxNV9TRFcgaXMgbm90IHNldAojIENPTkZJR19TTkRfU09DX1NHVEw1MDAw
IGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX1NPQ19TSU1QTEVfQU1QTElGSUVSIGlzIG5vdCBz
ZXQKIyBDT05GSUdfU05EX1NPQ19TSU1QTEVfTVVYIGlzIG5vdCBzZXQKIyBDT05GSUdfU05E
X1NPQ19TSVJGX0FVRElPX0NPREVDIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX1NPQ19TUERJ
RiBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9TT0NfU1NNMjMwNSBpcyBub3Qgc2V0CiMgQ09O
RklHX1NORF9TT0NfU1NNMjYwMl9TUEkgaXMgbm90IHNldAojIENPTkZJR19TTkRfU09DX1NT
TTI2MDJfSTJDIGlzIG5vdCBzZXQKQ09ORklHX1NORF9TT0NfU1NNNDU2Nz15CiMgQ09ORklH
X1NORF9TT0NfU1RBMzJYIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX1NPQ19TVEEzNTAgaXMg
bm90IHNldAojIENPTkZJR19TTkRfU09DX1NUSV9TQVMgaXMgbm90IHNldAojIENPTkZJR19T
TkRfU09DX1RBUzI1NTIgaXMgbm90IHNldAojIENPTkZJR19TTkRfU09DX1RBUzI1NjIgaXMg
bm90IHNldAojIENPTkZJR19TTkRfU09DX1RBUzI3NjQgaXMgbm90IHNldAojIENPTkZJR19T
TkRfU09DX1RBUzI3NzAgaXMgbm90IHNldAojIENPTkZJR19TTkRfU09DX1RBUzUwODYgaXMg
bm90IHNldAojIENPTkZJR19TTkRfU09DX1RBUzU3MVggaXMgbm90IHNldAojIENPTkZJR19T
TkRfU09DX1RBUzU3MjAgaXMgbm90IHNldAojIENPTkZJR19TTkRfU09DX1RBUzY0MjQgaXMg
bm90IHNldAojIENPTkZJR19TTkRfU09DX1REQTc0MTkgaXMgbm90IHNldAojIENPTkZJR19T
TkRfU09DX1RGQTk4NzkgaXMgbm90IHNldAojIENPTkZJR19TTkRfU09DX1RMVjMyMEFJQzIz
X0kyQyBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9TT0NfVExWMzIwQUlDMjNfU1BJIGlzIG5v
dCBzZXQKIyBDT05GSUdfU05EX1NPQ19UTFYzMjBBSUMzMVhYIGlzIG5vdCBzZXQKIyBDT05G
SUdfU05EX1NPQ19UTFYzMjBBSUMzMlg0X0kyQyBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9T
T0NfVExWMzIwQUlDMzJYNF9TUEkgaXMgbm90IHNldAojIENPTkZJR19TTkRfU09DX1RMVjMy
MEFJQzNYIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX1NPQ19UTFYzMjBBRENYMTQwIGlzIG5v
dCBzZXQKQ09ORklHX1NORF9TT0NfVFMzQTIyN0U9eQojIENPTkZJR19TTkRfU09DX1RTQ1M0
MlhYIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX1NPQ19UU0NTNDU0IGlzIG5vdCBzZXQKIyBD
T05GSUdfU05EX1NPQ19VREExMzM0IGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX1NPQ19XQ0Q5
MzhYX1NEVyBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9TT0NfV004NTEwIGlzIG5vdCBzZXQK
IyBDT05GSUdfU05EX1NPQ19XTTg1MjMgaXMgbm90IHNldAojIENPTkZJR19TTkRfU09DX1dN
ODUyNCBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9TT0NfV004NTgwIGlzIG5vdCBzZXQKIyBD
T05GSUdfU05EX1NPQ19XTTg3MTEgaXMgbm90IHNldAojIENPTkZJR19TTkRfU09DX1dNODcy
OCBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9TT0NfV004NzMxIGlzIG5vdCBzZXQKIyBDT05G
SUdfU05EX1NPQ19XTTg3MzcgaXMgbm90IHNldAojIENPTkZJR19TTkRfU09DX1dNODc0MSBp
cyBub3Qgc2V0CiMgQ09ORklHX1NORF9TT0NfV004NzUwIGlzIG5vdCBzZXQKIyBDT05GSUdf
U05EX1NPQ19XTTg3NTMgaXMgbm90IHNldAojIENPTkZJR19TTkRfU09DX1dNODc3MCBpcyBu
b3Qgc2V0CiMgQ09ORklHX1NORF9TT0NfV004Nzc2IGlzIG5vdCBzZXQKIyBDT05GSUdfU05E
X1NPQ19XTTg3ODIgaXMgbm90IHNldAojIENPTkZJR19TTkRfU09DX1dNODgwNF9JMkMgaXMg
bm90IHNldAojIENPTkZJR19TTkRfU09DX1dNODgwNF9TUEkgaXMgbm90IHNldAojIENPTkZJ
R19TTkRfU09DX1dNODkwMyBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9TT0NfV004OTA0IGlz
IG5vdCBzZXQKIyBDT05GSUdfU05EX1NPQ19XTTg5NjAgaXMgbm90IHNldAojIENPTkZJR19T
TkRfU09DX1dNODk2MiBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9TT0NfV004OTc0IGlzIG5v
dCBzZXQKIyBDT05GSUdfU05EX1NPQ19XTTg5NzggaXMgbm90IHNldAojIENPTkZJR19TTkRf
U09DX1dNODk4NSBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9TT0NfV1NBODgxWCBpcyBub3Qg
c2V0CiMgQ09ORklHX1NORF9TT0NfWkwzODA2MCBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9T
T0NfWlhfQVVEOTZQMjIgaXMgbm90IHNldAojIENPTkZJR19TTkRfU09DX01BWDk3NTkgaXMg
bm90IHNldAojIENPTkZJR19TTkRfU09DX01UNjM1MSBpcyBub3Qgc2V0CiMgQ09ORklHX1NO
RF9TT0NfTVQ2MzU4IGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX1NPQ19NVDY2NjAgaXMgbm90
IHNldAojIENPTkZJR19TTkRfU09DX05BVTgzMTUgaXMgbm90IHNldAojIENPTkZJR19TTkRf
U09DX05BVTg1NDAgaXMgbm90IHNldAojIENPTkZJR19TTkRfU09DX05BVTg4MTAgaXMgbm90
IHNldAojIENPTkZJR19TTkRfU09DX05BVTg4MjIgaXMgbm90IHNldAojIENPTkZJR19TTkRf
U09DX05BVTg4MjQgaXMgbm90IHNldAojIENPTkZJR19TTkRfU09DX1RQQTYxMzBBMiBpcyBu
b3Qgc2V0CiMgQ09ORklHX1NORF9TT0NfTFBBU1NfV1NBX01BQ1JPIGlzIG5vdCBzZXQKIyBD
T05GSUdfU05EX1NPQ19MUEFTU19WQV9NQUNSTyBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9T
T0NfTFBBU1NfUlhfTUFDUk8gaXMgbm90IHNldAojIENPTkZJR19TTkRfU09DX0xQQVNTX1RY
X01BQ1JPIGlzIG5vdCBzZXQKIyBlbmQgb2YgQ09ERUMgZHJpdmVycwoKIyBDT05GSUdfU05E
X1NJTVBMRV9DQVJEIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX0FVRElPX0dSQVBIX0NBUkQg
aXMgbm90IHNldAojIENPTkZJR19TTkRfQVVESU9fR1JBUEhfQ0FSRDIgaXMgbm90IHNldAoj
IENPTkZJR19TTkRfVEVTVF9DT01QT05FTlQgaXMgbm90IHNldApDT05GSUdfU05EX1g4Nj15
CiMgQ09ORklHX0hETUlfTFBFX0FVRElPIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX1ZJUlRJ
TyBpcyBub3Qgc2V0CgojCiMgSElEIHN1cHBvcnQKIwpDT05GSUdfSElEPXkKQ09ORklHX0hJ
RF9CQVRURVJZX1NUUkVOR1RIPXkKQ09ORklHX0hJRFJBVz15CkNPTkZJR19VSElEPXkKQ09O
RklHX0hJRF9HRU5FUklDPXkKQ09ORklHX0hJRF9IQVBUSUM9eQoKIwojIFNwZWNpYWwgSElE
IGRyaXZlcnMKIwojIENPTkZJR19ISURfQTRURUNIIGlzIG5vdCBzZXQKIyBDT05GSUdfSElE
X0FDQ1VUT1VDSCBpcyBub3Qgc2V0CiMgQ09ORklHX0hJRF9BQ1JVWCBpcyBub3Qgc2V0CkNP
TkZJR19ISURfQVBQTEU9eQojIENPTkZJR19ISURfQVBQTEVJUiBpcyBub3Qgc2V0CiMgQ09O
RklHX0hJRF9BU1VTIGlzIG5vdCBzZXQKIyBDT05GSUdfSElEX0FVUkVBTCBpcyBub3Qgc2V0
CiMgQ09ORklHX0hJRF9CRUxLSU4gaXMgbm90IHNldAojIENPTkZJR19ISURfQkVUT1BfRkYg
aXMgbm90IHNldAojIENPTkZJR19ISURfQklHQkVOX0ZGIGlzIG5vdCBzZXQKQ09ORklHX0hJ
RF9DSEVSUlk9eQpDT05GSUdfSElEX0NISUNPTlk9eQojIENPTkZJR19ISURfQ09SU0FJUiBp
cyBub3Qgc2V0CiMgQ09ORklHX0hJRF9DT1VHQVIgaXMgbm90IHNldAojIENPTkZJR19ISURf
TUFDQUxMWSBpcyBub3Qgc2V0CiMgQ09ORklHX0hJRF9QUk9ESUtFWVMgaXMgbm90IHNldAoj
IENPTkZJR19ISURfQ01FRElBIGlzIG5vdCBzZXQKIyBDT05GSUdfSElEX0NQMjExMiBpcyBu
b3Qgc2V0CiMgQ09ORklHX0hJRF9DUkVBVElWRV9TQjA1NDAgaXMgbm90IHNldAojIENPTkZJ
R19ISURfQ1lQUkVTUyBpcyBub3Qgc2V0CiMgQ09ORklHX0hJRF9EUkFHT05SSVNFIGlzIG5v
dCBzZXQKIyBDT05GSUdfSElEX0VNU19GRiBpcyBub3Qgc2V0CiMgQ09ORklHX0hJRF9FTEFO
IGlzIG5vdCBzZXQKIyBDT05GSUdfSElEX0VMRUNPTSBpcyBub3Qgc2V0CiMgQ09ORklHX0hJ
RF9FTE8gaXMgbm90IHNldAojIENPTkZJR19ISURfRVpLRVkgaXMgbm90IHNldAojIENPTkZJ
R19ISURfR0VNQklSRCBpcyBub3Qgc2V0CiMgQ09ORklHX0hJRF9HRlJNIGlzIG5vdCBzZXQK
IyBDT05GSUdfSElEX0dMT1JJT1VTIGlzIG5vdCBzZXQKQ09ORklHX0hJRF9IT0xURUs9eQoj
IENPTkZJR19IT0xURUtfRkYgaXMgbm90IHNldApDT05GSUdfSElEX0dPT0dMRV9IQU1NRVI9
eQpDT05GSUdfSElEX1ZJVkFMREk9eQojIENPTkZJR19ISURfR1Q2ODNSIGlzIG5vdCBzZXQK
IyBDT05GSUdfSElEX0tFWVRPVUNIIGlzIG5vdCBzZXQKIyBDT05GSUdfSElEX0tZRSBpcyBu
b3Qgc2V0CiMgQ09ORklHX0hJRF9VQ0xPR0lDIGlzIG5vdCBzZXQKIyBDT05GSUdfSElEX1dB
TFRPUCBpcyBub3Qgc2V0CiMgQ09ORklHX0hJRF9WSUVXU09OSUMgaXMgbm90IHNldAojIENP
TkZJR19ISURfR1lSQVRJT04gaXMgbm90IHNldAojIENPTkZJR19ISURfSUNBREUgaXMgbm90
IHNldAojIENPTkZJR19ISURfSVRFIGlzIG5vdCBzZXQKIyBDT05GSUdfSElEX0pBQlJBIGlz
IG5vdCBzZXQKIyBDT05GSUdfSElEX1RXSU5IQU4gaXMgbm90IHNldApDT05GSUdfSElEX0tF
TlNJTkdUT049eQojIENPTkZJR19ISURfTENQT1dFUiBpcyBub3Qgc2V0CkNPTkZJR19ISURf
TEVEPXkKIyBDT05GSUdfSElEX0xFTk9WTyBpcyBub3Qgc2V0CkNPTkZJR19ISURfTE9HSVRF
Q0g9eQpDT05GSUdfSElEX0xPR0lURUNIX0RKPXkKQ09ORklHX0hJRF9MT0dJVEVDSF9ISURQ
UD15CiMgQ09ORklHX0xPR0lURUNIX0ZGIGlzIG5vdCBzZXQKIyBDT05GSUdfTE9HSVJVTUJM
RVBBRDJfRkYgaXMgbm90IHNldAojIENPTkZJR19MT0dJRzk0MF9GRiBpcyBub3Qgc2V0CiMg
Q09ORklHX0xPR0lXSEVFTFNfRkYgaXMgbm90IHNldApDT05GSUdfSElEX01BR0lDTU9VU0U9
eQojIENPTkZJR19ISURfTUFMVFJPTiBpcyBub3Qgc2V0CiMgQ09ORklHX0hJRF9NQVlGTEFT
SCBpcyBub3Qgc2V0CiMgQ09ORklHX0hJRF9SRURSQUdPTiBpcyBub3Qgc2V0CkNPTkZJR19I
SURfTUlDUk9TT0ZUPXkKIyBDT05GSUdfSElEX01PTlRFUkVZIGlzIG5vdCBzZXQKQ09ORklH
X0hJRF9NVUxUSVRPVUNIPXkKQ09ORklHX01VTFRJVE9VQ0hfSEFQVElDPXkKIyBDT05GSUdf
SElEX05JTlRFTkRPIGlzIG5vdCBzZXQKIyBDT05GSUdfSElEX05USSBpcyBub3Qgc2V0CiMg
Q09ORklHX0hJRF9OVFJJRyBpcyBub3Qgc2V0CiMgQ09ORklHX0hJRF9PUlRFSyBpcyBub3Qg
c2V0CiMgQ09ORklHX0hJRF9QQU5USEVSTE9SRCBpcyBub3Qgc2V0CiMgQ09ORklHX0hJRF9Q
RU5NT1VOVCBpcyBub3Qgc2V0CiMgQ09ORklHX0hJRF9QRVRBTFlOWCBpcyBub3Qgc2V0CiMg
Q09ORklHX0hJRF9QSUNPTENEIGlzIG5vdCBzZXQKQ09ORklHX0hJRF9QTEFOVFJPTklDUz15
CkNPTkZJR19ISURfUFJJTUFYPXkKQ09ORklHX0hJRF9RVUlDS1NURVA9eQojIENPTkZJR19I
SURfUkVUUk9ERSBpcyBub3Qgc2V0CiMgQ09ORklHX0hJRF9ST0NDQVQgaXMgbm90IHNldAoj
IENPTkZJR19ISURfU0FJVEVLIGlzIG5vdCBzZXQKIyBDT05GSUdfSElEX1NBTVNVTkcgaXMg
bm90IHNldApDT05GSUdfSElEX1NPTlk9eQojIENPTkZJR19TT05ZX0ZGIGlzIG5vdCBzZXQK
IyBDT05GSUdfSElEX1NQRUVETElOSyBpcyBub3Qgc2V0CiMgQ09ORklHX0hJRF9TVEVBTSBp
cyBub3Qgc2V0CiMgQ09ORklHX0hJRF9TVEVFTFNFUklFUyBpcyBub3Qgc2V0CiMgQ09ORklH
X0hJRF9TVU5QTFVTIGlzIG5vdCBzZXQKQ09ORklHX0hJRF9STUk9eQojIENPTkZJR19ISURf
R1JFRU5BU0lBIGlzIG5vdCBzZXQKIyBDT05GSUdfSElEX1NNQVJUSk9ZUExVUyBpcyBub3Qg
c2V0CiMgQ09ORklHX0hJRF9USVZPIGlzIG5vdCBzZXQKIyBDT05GSUdfSElEX1RPUFNFRUQg
aXMgbm90IHNldApDT05GSUdfSElEX1RISU5HTT15CiMgQ09ORklHX0hJRF9USFJVU1RNQVNU
RVIgaXMgbm90IHNldAojIENPTkZJR19ISURfVURSQVdfUFMzIGlzIG5vdCBzZXQKIyBDT05G
SUdfSElEX1UyRlpFUk8gaXMgbm90IHNldApDT05GSUdfSElEX1dBQ09NPXkKQ09ORklHX0hJ
RF9XSUlNT1RFPXkKIyBDT05GSUdfSElEX1hJTk1PIGlzIG5vdCBzZXQKIyBDT05GSUdfSElE
X1pFUk9QTFVTIGlzIG5vdCBzZXQKIyBDT05GSUdfSElEX1pZREFDUk9OIGlzIG5vdCBzZXQK
IyBDT05GSUdfSElEX1NFTlNPUl9IVUIgaXMgbm90IHNldAojIENPTkZJR19ISURfQUxQUyBp
cyBub3Qgc2V0CiMgQ09ORklHX0hJRF9NQ1AyMjIxIGlzIG5vdCBzZXQKIyBlbmQgb2YgU3Bl
Y2lhbCBISUQgZHJpdmVycwoKIwojIFVTQiBISUQgc3VwcG9ydAojCkNPTkZJR19VU0JfSElE
PXkKQ09ORklHX0hJRF9QSUQ9eQpDT05GSUdfVVNCX0hJRERFVj15CiMgZW5kIG9mIFVTQiBI
SUQgc3VwcG9ydAoKIwojIEkyQyBISUQgc3VwcG9ydAojCkNPTkZJR19JMkNfSElEX0FDUEk9
eQojIENPTkZJR19JMkNfSElEX09GIGlzIG5vdCBzZXQKIyBDT05GSUdfSTJDX0hJRF9PRl9H
T09ESVggaXMgbm90IHNldAojIGVuZCBvZiBJMkMgSElEIHN1cHBvcnQKCkNPTkZJR19JMkNf
SElEX0NPUkU9eQoKIwojIEludGVsIElTSCBISUQgc3VwcG9ydAojCiMgQ09ORklHX0lOVEVM
X0lTSF9ISUQgaXMgbm90IHNldAojIGVuZCBvZiBJbnRlbCBJU0ggSElEIHN1cHBvcnQKIyBl
bmQgb2YgSElEIHN1cHBvcnQKCkNPTkZJR19VU0JfT0hDSV9MSVRUTEVfRU5ESUFOPXkKQ09O
RklHX1VTQl9TVVBQT1JUPXkKQ09ORklHX1VTQl9DT01NT049eQojIENPTkZJR19VU0JfTEVE
X1RSSUcgaXMgbm90IHNldAojIENPTkZJR19VU0JfVUxQSV9CVVMgaXMgbm90IHNldAojIENP
TkZJR19VU0JfQ09OTl9HUElPIGlzIG5vdCBzZXQKQ09ORklHX1VTQl9BUkNIX0hBU19IQ0Q9
eQpDT05GSUdfVVNCPXkKQ09ORklHX1VTQl9QQ0k9eQpDT05GSUdfVVNCX0FOTk9VTkNFX05F
V19ERVZJQ0VTPXkKCiMKIyBNaXNjZWxsYW5lb3VzIFVTQiBvcHRpb25zCiMKQ09ORklHX1VT
Ql9ERUZBVUxUX1BFUlNJU1Q9eQojIENPTkZJR19VU0JfRkVXX0lOSVRfUkVUUklFUyBpcyBu
b3Qgc2V0CiMgQ09ORklHX1VTQl9EWU5BTUlDX01JTk9SUyBpcyBub3Qgc2V0CiMgQ09ORklH
X1VTQl9PVEcgaXMgbm90IHNldAojIENPTkZJR19VU0JfT1RHX1BST0RVQ1RMSVNUIGlzIG5v
dCBzZXQKIyBDT05GSUdfVVNCX09UR19ESVNBQkxFX0VYVEVSTkFMX0hVQiBpcyBub3Qgc2V0
CiMgQ09ORklHX1VTQl9MRURTX1RSSUdHRVJfVVNCUE9SVCBpcyBub3Qgc2V0CkNPTkZJR19V
U0JfQVVUT1NVU1BFTkRfREVMQVk9MgojIENPTkZJR19VU0JfSFVCX0VSUk9SX1JFUE9SVElO
RyBpcyBub3Qgc2V0CkNPTkZJR19VU0JfTU9OPXkKCiMKIyBVU0IgSG9zdCBDb250cm9sbGVy
IERyaXZlcnMKIwojIENPTkZJR19VU0JfQzY3WDAwX0hDRCBpcyBub3Qgc2V0CkNPTkZJR19V
U0JfWEhDSV9IQ0Q9eQojIENPTkZJR19VU0JfWEhDSV9EQkdDQVAgaXMgbm90IHNldApDT05G
SUdfVVNCX1hIQ0lfUENJPXkKIyBDT05GSUdfVVNCX1hIQ0lfUENJX1JFTkVTQVMgaXMgbm90
IHNldApDT05GSUdfVVNCX1hIQ0lfUExBVEZPUk09eQojIENPTkZJR19VU0JfWEhDSV9FUlJP
Ul9SRVBPUlRJTkcgaXMgbm90IHNldApDT05GSUdfVVNCX0VIQ0lfSENEPXkKQ09ORklHX1VT
Ql9FSENJX1JPT1RfSFVCX1RUPXkKQ09ORklHX1VTQl9FSENJX1RUX05FV1NDSEVEPXkKQ09O
RklHX1VTQl9FSENJX1BDST15CiMgQ09ORklHX1VTQl9FSENJX0ZTTCBpcyBub3Qgc2V0CiMg
Q09ORklHX1VTQl9FSENJX0hDRF9QTEFURk9STSBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9P
WFUyMTBIUF9IQ0QgaXMgbm90IHNldAojIENPTkZJR19VU0JfSVNQMTE2WF9IQ0QgaXMgbm90
IHNldAojIENPTkZJR19VU0JfRk9URzIxMF9IQ0QgaXMgbm90IHNldAojIENPTkZJR19VU0Jf
TUFYMzQyMV9IQ0QgaXMgbm90IHNldAojIENPTkZJR19VU0JfT0hDSV9IQ0QgaXMgbm90IHNl
dApDT05GSUdfVVNCX1VIQ0lfSENEPXkKIyBDT05GSUdfVVNCX1NMODExX0hDRCBpcyBub3Qg
c2V0CiMgQ09ORklHX1VTQl9SOEE2NjU5N19IQ0QgaXMgbm90IHNldAojIENPTkZJR19VU0Jf
SENEX0JDTUEgaXMgbm90IHNldAojIENPTkZJR19VU0JfSENEX1NTQiBpcyBub3Qgc2V0CiMg
Q09ORklHX1VTQl9IQ0RfVEVTVF9NT0RFIGlzIG5vdCBzZXQKCiMKIyBVU0IgRGV2aWNlIENs
YXNzIGRyaXZlcnMKIwpDT05GSUdfVVNCX0FDTT15CiMgQ09ORklHX1VTQl9QUklOVEVSIGlz
IG5vdCBzZXQKIyBDT05GSUdfVVNCX1dETSBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9UTUMg
aXMgbm90IHNldAoKIwojIE5PVEU6IFVTQl9TVE9SQUdFIGRlcGVuZHMgb24gU0NTSSBidXQg
QkxLX0RFVl9TRCBtYXkKIwoKIwojIGFsc28gYmUgbmVlZGVkOyBzZWUgVVNCX1NUT1JBR0Ug
SGVscCBmb3IgbW9yZSBpbmZvCiMKQ09ORklHX1VTQl9TVE9SQUdFPXkKIyBDT05GSUdfVVNC
X1NUT1JBR0VfREVCVUcgaXMgbm90IHNldApDT05GSUdfVVNCX1NUT1JBR0VfUkVBTFRFSz15
CkNPTkZJR19SRUFMVEVLX0FVVE9QTT15CiMgQ09ORklHX1VTQl9TVE9SQUdFX0RBVEFGQUIg
aXMgbm90IHNldAojIENPTkZJR19VU0JfU1RPUkFHRV9GUkVFQ09NIGlzIG5vdCBzZXQKIyBD
T05GSUdfVVNCX1NUT1JBR0VfSVNEMjAwIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1NUT1JB
R0VfVVNCQVQgaXMgbm90IHNldAojIENPTkZJR19VU0JfU1RPUkFHRV9TRERSMDkgaXMgbm90
IHNldAojIENPTkZJR19VU0JfU1RPUkFHRV9TRERSNTUgaXMgbm90IHNldAojIENPTkZJR19V
U0JfU1RPUkFHRV9KVU1QU0hPVCBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9TVE9SQUdFX0FM
QVVEQSBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9TVE9SQUdFX09ORVRPVUNIIGlzIG5vdCBz
ZXQKIyBDT05GSUdfVVNCX1NUT1JBR0VfS0FSTUEgaXMgbm90IHNldAojIENPTkZJR19VU0Jf
U1RPUkFHRV9DWVBSRVNTX0FUQUNCIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1NUT1JBR0Vf
RU5FX1VCNjI1MCBpcyBub3Qgc2V0CkNPTkZJR19VU0JfVUFTPXkKCiMKIyBVU0IgSW1hZ2lu
ZyBkZXZpY2VzCiMKIyBDT05GSUdfVVNCX01EQzgwMCBpcyBub3Qgc2V0CiMgQ09ORklHX1VT
Ql9NSUNST1RFSyBpcyBub3Qgc2V0CkNPTkZJR19VU0JJUF9DT1JFPXkKQ09ORklHX1VTQklQ
X1ZIQ0lfSENEPXkKQ09ORklHX1VTQklQX1ZIQ0lfSENfUE9SVFM9OApDT05GSUdfVVNCSVBf
VkhDSV9OUl9IQ1M9MQojIENPTkZJR19VU0JJUF9IT1NUIGlzIG5vdCBzZXQKIyBDT05GSUdf
VVNCSVBfVlVEQyBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQklQX0RFQlVHIGlzIG5vdCBzZXQK
IyBDT05GSUdfVVNCX0NETlMzIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX01VU0JfSERSQyBp
cyBub3Qgc2V0CkNPTkZJR19VU0JfRFdDMz15CiMgQ09ORklHX1VTQl9EV0MzX0hPU1QgaXMg
bm90IHNldApDT05GSUdfVVNCX0RXQzNfR0FER0VUPXkKCiMKIyBQbGF0Zm9ybSBHbHVlIERy
aXZlciBTdXBwb3J0CiMKQ09ORklHX1VTQl9EV0MzX1BDST15CkNPTkZJR19VU0JfRFdDM19I
QVBTPXkKIyBDT05GSUdfVVNCX0RXQzNfT0ZfU0lNUExFIGlzIG5vdCBzZXQKIyBDT05GSUdf
VVNCX0RXQzIgaXMgbm90IHNldAojIENPTkZJR19VU0JfQ0hJUElERUEgaXMgbm90IHNldAoj
IENPTkZJR19VU0JfSVNQMTc2MCBpcyBub3Qgc2V0CgojCiMgVVNCIHBvcnQgZHJpdmVycwoj
CkNPTkZJR19VU0JfU0VSSUFMPXkKQ09ORklHX1VTQl9TRVJJQUxfQ09OU09MRT15CkNPTkZJ
R19VU0JfU0VSSUFMX0dFTkVSSUM9eQpDT05GSUdfVVNCX1NFUklBTF9TSU1QTEU9eQojIENP
TkZJR19VU0JfU0VSSUFMX0FJUkNBQkxFIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1NFUklB
TF9BUkszMTE2IGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1NFUklBTF9CRUxLSU4gaXMgbm90
IHNldApDT05GSUdfVVNCX1NFUklBTF9DSDM0MT15CiMgQ09ORklHX1VTQl9TRVJJQUxfV0hJ
VEVIRUFUIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1NFUklBTF9ESUdJX0FDQ0VMRVBPUlQg
aXMgbm90IHNldApDT05GSUdfVVNCX1NFUklBTF9DUDIxMFg9eQojIENPTkZJR19VU0JfU0VS
SUFMX0NZUFJFU1NfTTggaXMgbm90IHNldAojIENPTkZJR19VU0JfU0VSSUFMX0VNUEVHIGlz
IG5vdCBzZXQKQ09ORklHX1VTQl9TRVJJQUxfRlRESV9TSU89eQojIENPTkZJR19VU0JfU0VS
SUFMX1ZJU09SIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1NFUklBTF9JUEFRIGlzIG5vdCBz
ZXQKIyBDT05GSUdfVVNCX1NFUklBTF9JUiBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9TRVJJ
QUxfRURHRVBPUlQgaXMgbm90IHNldAojIENPTkZJR19VU0JfU0VSSUFMX0VER0VQT1JUX1RJ
IGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1NFUklBTF9GODEyMzIgaXMgbm90IHNldAojIENP
TkZJR19VU0JfU0VSSUFMX0Y4MTUzWCBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9TRVJJQUxf
R0FSTUlOIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1NFUklBTF9JUFcgaXMgbm90IHNldAoj
IENPTkZJR19VU0JfU0VSSUFMX0lVVSBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9TRVJJQUxf
S0VZU1BBTl9QREEgaXMgbm90IHNldApDT05GSUdfVVNCX1NFUklBTF9LRVlTUEFOPXkKIyBD
T05GSUdfVVNCX1NFUklBTF9LTFNJIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1NFUklBTF9L
T0JJTF9TQ1QgaXMgbm90IHNldAojIENPTkZJR19VU0JfU0VSSUFMX01DVF9VMjMyIGlzIG5v
dCBzZXQKIyBDT05GSUdfVVNCX1NFUklBTF9NRVRSTyBpcyBub3Qgc2V0CiMgQ09ORklHX1VT
Ql9TRVJJQUxfTU9TNzcyMCBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9TRVJJQUxfTU9TNzg0
MCBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9TRVJJQUxfTVhVUE9SVCBpcyBub3Qgc2V0CiMg
Q09ORklHX1VTQl9TRVJJQUxfTkFWTUFOIGlzIG5vdCBzZXQKQ09ORklHX1VTQl9TRVJJQUxf
UEwyMzAzPXkKQ09ORklHX1VTQl9TRVJJQUxfT1RJNjg1OD15CiMgQ09ORklHX1VTQl9TRVJJ
QUxfUUNBVVggaXMgbm90IHNldApDT05GSUdfVVNCX1NFUklBTF9RVUFMQ09NTT15CiMgQ09O
RklHX1VTQl9TRVJJQUxfU1BDUDhYNSBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9TRVJJQUxf
U0FGRSBpcyBub3Qgc2V0CkNPTkZJR19VU0JfU0VSSUFMX1NJRVJSQVdJUkVMRVNTPXkKIyBD
T05GSUdfVVNCX1NFUklBTF9TWU1CT0wgaXMgbm90IHNldAojIENPTkZJR19VU0JfU0VSSUFM
X1RJIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1NFUklBTF9DWUJFUkpBQ0sgaXMgbm90IHNl
dAojIENPTkZJR19VU0JfU0VSSUFMX1hJUkNPTSBpcyBub3Qgc2V0CkNPTkZJR19VU0JfU0VS
SUFMX1dXQU49eQpDT05GSUdfVVNCX1NFUklBTF9PUFRJT049eQojIENPTkZJR19VU0JfU0VS
SUFMX09NTklORVQgaXMgbm90IHNldAojIENPTkZJR19VU0JfU0VSSUFMX09QVElDT04gaXMg
bm90IHNldAojIENPTkZJR19VU0JfU0VSSUFMX1hTRU5TX01UIGlzIG5vdCBzZXQKIyBDT05G
SUdfVVNCX1NFUklBTF9XSVNIQk9ORSBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9TRVJJQUxf
U1NVMTAwIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1NFUklBTF9RVDIgaXMgbm90IHNldAoj
IENPTkZJR19VU0JfU0VSSUFMX1VQRDc4RjA3MzAgaXMgbm90IHNldAojIENPTkZJR19VU0Jf
U0VSSUFMX0RFQlVHIGlzIG5vdCBzZXQKCiMKIyBVU0IgTWlzY2VsbGFuZW91cyBkcml2ZXJz
CiMKIyBDT05GSUdfVVNCX0VNSTYyIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX0VNSTI2IGlz
IG5vdCBzZXQKIyBDT05GSUdfVVNCX0FEVVRVWCBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9T
RVZTRUcgaXMgbm90IHNldAojIENPTkZJR19VU0JfTEVHT1RPV0VSIGlzIG5vdCBzZXQKIyBD
T05GSUdfVVNCX0xDRCBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9DWVBSRVNTX0NZN0M2MyBp
cyBub3Qgc2V0CiMgQ09ORklHX1VTQl9DWVRIRVJNIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNC
X0lETU9VU0UgaXMgbm90IHNldAojIENPTkZJR19VU0JfRlRESV9FTEFOIGlzIG5vdCBzZXQK
IyBDT05GSUdfVVNCX0FQUExFRElTUExBWSBpcyBub3Qgc2V0CiMgQ09ORklHX0FQUExFX01G
SV9GQVNUQ0hBUkdFIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1NJU1VTQlZHQSBpcyBub3Qg
c2V0CiMgQ09ORklHX1VTQl9MRCBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9UUkFOQ0VWSUJS
QVRPUiBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9JT1dBUlJJT1IgaXMgbm90IHNldAojIENP
TkZJR19VU0JfVEVTVCBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9FSFNFVF9URVNUX0ZJWFRV
UkUgaXMgbm90IHNldAojIENPTkZJR19VU0JfSVNJR0hURlcgaXMgbm90IHNldAojIENPTkZJ
R19VU0JfWVVSRVggaXMgbm90IHNldApDT05GSUdfVVNCX0VaVVNCX0ZYMj15CiMgQ09ORklH
X1VTQl9IVUJfVVNCMjUxWEIgaXMgbm90IHNldAojIENPTkZJR19VU0JfSFNJQ19VU0IzNTAz
IGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX0hTSUNfVVNCNDYwNCBpcyBub3Qgc2V0CiMgQ09O
RklHX1VTQl9MSU5LX0xBWUVSX1RFU1QgaXMgbm90IHNldAojIENPTkZJR19VU0JfQ0hBT1NL
RVkgaXMgbm90IHNldAojIENPTkZJR19VU0JfT05CT0FSRF9IVUIgaXMgbm90IHNldAoKIwoj
IFVTQiBQaHlzaWNhbCBMYXllciBkcml2ZXJzCiMKIyBDT05GSUdfTk9QX1VTQl9YQ0VJViBp
cyBub3Qgc2V0CiMgQ09ORklHX1VTQl9HUElPX1ZCVVMgaXMgbm90IHNldAojIENPTkZJR19V
U0JfSVNQMTMwMSBpcyBub3Qgc2V0CiMgZW5kIG9mIFVTQiBQaHlzaWNhbCBMYXllciBkcml2
ZXJzCgpDT05GSUdfVVNCX0dBREdFVD15CiMgQ09ORklHX1VTQl9HQURHRVRfREVCVUcgaXMg
bm90IHNldAojIENPTkZJR19VU0JfR0FER0VUX0RFQlVHX0ZJTEVTIGlzIG5vdCBzZXQKIyBD
T05GSUdfVVNCX0dBREdFVF9ERUJVR19GUyBpcyBub3Qgc2V0CkNPTkZJR19VU0JfR0FER0VU
X1ZCVVNfRFJBVz0yCkNPTkZJR19VU0JfR0FER0VUX1NUT1JBR0VfTlVNX0JVRkZFUlM9Mgoj
IENPTkZJR19VX1NFUklBTF9DT05TT0xFIGlzIG5vdCBzZXQKCiMKIyBVU0IgUGVyaXBoZXJh
bCBDb250cm9sbGVyCiMKIyBDT05GSUdfVVNCX0ZPVEcyMTBfVURDIGlzIG5vdCBzZXQKIyBD
T05GSUdfVVNCX0dSX1VEQyBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9SOEE2NjU5NyBpcyBu
b3Qgc2V0CiMgQ09ORklHX1VTQl9QWEEyN1ggaXMgbm90IHNldAojIENPTkZJR19VU0JfTVZf
VURDIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX01WX1UzRCBpcyBub3Qgc2V0CiMgQ09ORklH
X1VTQl9TTlBfVURDX1BMQVQgaXMgbm90IHNldAojIENPTkZJR19VU0JfTTY2NTkyIGlzIG5v
dCBzZXQKIyBDT05GSUdfVVNCX0JEQ19VREMgaXMgbm90IHNldAojIENPTkZJR19VU0JfQU1E
NTUzNlVEQyBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9ORVQyMjcyIGlzIG5vdCBzZXQKIyBD
T05GSUdfVVNCX05FVDIyODAgaXMgbm90IHNldAojIENPTkZJR19VU0JfR09LVSBpcyBub3Qg
c2V0CiMgQ09ORklHX1VTQl9FRzIwVCBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9HQURHRVRf
WElMSU5YIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX01BWDM0MjBfVURDIGlzIG5vdCBzZXQK
Q09ORklHX1VTQl9EVU1NWV9IQ0Q9eQojIGVuZCBvZiBVU0IgUGVyaXBoZXJhbCBDb250cm9s
bGVyCgpDT05GSUdfVVNCX0xJQkNPTVBPU0lURT15CkNPTkZJR19VU0JfRl9BQ009eQpDT05G
SUdfVVNCX0ZfU1NfTEI9eQpDT05GSUdfVVNCX1VfU0VSSUFMPXkKQ09ORklHX1VTQl9VX0VU
SEVSPXkKQ09ORklHX1VTQl9VX0FVRElPPXkKQ09ORklHX1VTQl9GX1NFUklBTD15CkNPTkZJ
R19VU0JfRl9PQkVYPXkKQ09ORklHX1VTQl9GX05DTT15CkNPTkZJR19VU0JfRl9FQ009eQpD
T05GSUdfVVNCX0ZfRUVNPXkKQ09ORklHX1VTQl9GX1NVQlNFVD15CkNPTkZJR19VU0JfRl9S
TkRJUz15CkNPTkZJR19VU0JfRl9NQVNTX1NUT1JBR0U9eQpDT05GSUdfVVNCX0ZfRlM9eQpD
T05GSUdfVVNCX0ZfVUFDMT15CkNPTkZJR19VU0JfRl9VQUMxX0xFR0FDWT15CkNPTkZJR19V
U0JfRl9VQUMyPXkKQ09ORklHX1VTQl9GX1VWQz15CkNPTkZJR19VU0JfRl9NSURJPXkKQ09O
RklHX1VTQl9GX0hJRD15CkNPTkZJR19VU0JfRl9QUklOVEVSPXkKQ09ORklHX1VTQl9GX0FD
Qz15CkNPTkZJR19VU0JfRl9BVURJT19TUkM9eQpDT05GSUdfVVNCX0NPTkZJR0ZTPXkKQ09O
RklHX1VTQl9DT05GSUdGU19VRVZFTlQ9eQpDT05GSUdfVVNCX0NPTkZJR0ZTX1NFUklBTD15
CkNPTkZJR19VU0JfQ09ORklHRlNfQUNNPXkKQ09ORklHX1VTQl9DT05GSUdGU19PQkVYPXkK
Q09ORklHX1VTQl9DT05GSUdGU19OQ009eQpDT05GSUdfVVNCX0NPTkZJR0ZTX0VDTT15CkNP
TkZJR19VU0JfQ09ORklHRlNfRUNNX1NVQlNFVD15CkNPTkZJR19VU0JfQ09ORklHRlNfUk5E
SVM9eQpDT05GSUdfVVNCX0NPTkZJR0ZTX0VFTT15CkNPTkZJR19VU0JfQ09ORklHRlNfTUFT
U19TVE9SQUdFPXkKQ09ORklHX1VTQl9DT05GSUdGU19GX0xCX1NTPXkKQ09ORklHX1VTQl9D
T05GSUdGU19GX0ZTPXkKQ09ORklHX1VTQl9DT05GSUdGU19GX0FDQz15CkNPTkZJR19VU0Jf
Q09ORklHRlNfRl9BVURJT19TUkM9eQpDT05GSUdfVVNCX0NPTkZJR0ZTX0ZfVUFDMT15CkNP
TkZJR19VU0JfQ09ORklHRlNfRl9VQUMxX0xFR0FDWT15CkNPTkZJR19VU0JfQ09ORklHRlNf
Rl9VQUMyPXkKQ09ORklHX1VTQl9DT05GSUdGU19GX01JREk9eQpDT05GSUdfVVNCX0NPTkZJ
R0ZTX0ZfSElEPXkKQ09ORklHX1VTQl9DT05GSUdGU19GX1VWQz15CkNPTkZJR19VU0JfQ09O
RklHRlNfRl9QUklOVEVSPXkKCiMKIyBVU0IgR2FkZ2V0IHByZWNvbXBvc2VkIGNvbmZpZ3Vy
YXRpb25zCiMKIyBDT05GSUdfVVNCX1pFUk8gaXMgbm90IHNldAojIENPTkZJR19VU0JfQVVE
SU8gaXMgbm90IHNldAojIENPTkZJR19VU0JfRVRIIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNC
X0dfTkNNIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX0dBREdFVEZTIGlzIG5vdCBzZXQKIyBD
T05GSUdfVVNCX0ZVTkNUSU9ORlMgaXMgbm90IHNldAojIENPTkZJR19VU0JfTUFTU19TVE9S
QUdFIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX0dfU0VSSUFMIGlzIG5vdCBzZXQKIyBDT05G
SUdfVVNCX01JRElfR0FER0VUIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX0dfUFJJTlRFUiBp
cyBub3Qgc2V0CiMgQ09ORklHX1VTQl9DRENfQ09NUE9TSVRFIGlzIG5vdCBzZXQKIyBDT05G
SUdfVVNCX0dfQUNNX01TIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX0dfTVVMVEkgaXMgbm90
IHNldAojIENPTkZJR19VU0JfR19ISUQgaXMgbm90IHNldAojIENPTkZJR19VU0JfR19EQkdQ
IGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX0dfV0VCQ0FNIGlzIG5vdCBzZXQKQ09ORklHX1VT
Ql9SQVdfR0FER0VUPXkKIyBlbmQgb2YgVVNCIEdhZGdldCBwcmVjb21wb3NlZCBjb25maWd1
cmF0aW9ucwoKQ09ORklHX1RZUEVDPXkKIyBDT05GSUdfVFlQRUNfVENQTSBpcyBub3Qgc2V0
CkNPTkZJR19UWVBFQ19VQ1NJPXkKIyBDT05GSUdfVUNTSV9DQ0cgaXMgbm90IHNldApDT05G
SUdfVUNTSV9BQ1BJPXkKIyBDT05GSUdfVFlQRUNfVFBTNjU5OFggaXMgbm90IHNldAojIENP
TkZJR19UWVBFQ19TVFVTQjE2MFggaXMgbm90IHNldAoKIwojIFVTQiBUeXBlLUMgTXVsdGlw
bGV4ZXIvRGVNdWx0aXBsZXhlciBTd2l0Y2ggc3VwcG9ydAojCiMgQ09ORklHX1RZUEVDX01V
WF9QSTNVU0IzMDUzMiBpcyBub3Qgc2V0CiMgQ09ORklHX1RZUEVDX01VWF9JTlRFTF9QTUMg
aXMgbm90IHNldAojIGVuZCBvZiBVU0IgVHlwZS1DIE11bHRpcGxleGVyL0RlTXVsdGlwbGV4
ZXIgU3dpdGNoIHN1cHBvcnQKCiMKIyBVU0IgVHlwZS1DIEFsdGVybmF0ZSBNb2RlIGRyaXZl
cnMKIwojIENPTkZJR19UWVBFQ19EUF9BTFRNT0RFIGlzIG5vdCBzZXQKIyBlbmQgb2YgVVNC
IFR5cGUtQyBBbHRlcm5hdGUgTW9kZSBkcml2ZXJzCgojIENPTkZJR19VU0JfUk9MRV9TV0lU
Q0ggaXMgbm90IHNldApDT05GSUdfTU1DPXkKIyBDT05GSUdfUFdSU0VRX0VNTUMgaXMgbm90
IHNldAojIENPTkZJR19QV1JTRVFfU0Q4Nzg3IGlzIG5vdCBzZXQKIyBDT05GSUdfUFdSU0VR
X1NJTVBMRSBpcyBub3Qgc2V0CkNPTkZJR19NTUNfQkxPQ0s9eQpDT05GSUdfTU1DX0JMT0NL
X01JTk9SUz0xNgojIENPTkZJR19TRElPX1VBUlQgaXMgbm90IHNldApDT05GSUdfTU1DX1RF
U1Q9eQoKIwojIE1NQy9TRC9TRElPIEhvc3QgQ29udHJvbGxlciBEcml2ZXJzCiMKIyBDT05G
SUdfTU1DX0RFQlVHIGlzIG5vdCBzZXQKQ09ORklHX01NQ19TREhDST15CkNPTkZJR19NTUNf
U0RIQ0lfSU9fQUNDRVNTT1JTPXkKQ09ORklHX01NQ19TREhDSV9QQ0k9eQojIENPTkZJR19N
TUNfUklDT0hfTU1DIGlzIG5vdCBzZXQKQ09ORklHX01NQ19TREhDSV9BQ1BJPXkKIyBDT05G
SUdfTU1DX1NESENJX1BMVEZNIGlzIG5vdCBzZXQKIyBDT05GSUdfTU1DX1dCU0QgaXMgbm90
IHNldAojIENPTkZJR19NTUNfVElGTV9TRCBpcyBub3Qgc2V0CiMgQ09ORklHX01NQ19TUEkg
aXMgbm90IHNldAojIENPTkZJR19NTUNfQ0I3MTAgaXMgbm90IHNldAojIENPTkZJR19NTUNf
VklBX1NETU1DIGlzIG5vdCBzZXQKIyBDT05GSUdfTU1DX1ZVQjMwMCBpcyBub3Qgc2V0CiMg
Q09ORklHX01NQ19VU0hDIGlzIG5vdCBzZXQKIyBDT05GSUdfTU1DX1VTREhJNlJPTDAgaXMg
bm90IHNldApDT05GSUdfTU1DX0NRSENJPXkKIyBDT05GSUdfTU1DX0hTUSBpcyBub3Qgc2V0
CiMgQ09ORklHX01NQ19UT1NISUJBX1BDSSBpcyBub3Qgc2V0CiMgQ09ORklHX01NQ19NVEsg
aXMgbm90IHNldAojIENPTkZJR19NRU1TVElDSyBpcyBub3Qgc2V0CkNPTkZJR19ORVdfTEVE
Uz15CkNPTkZJR19MRURTX0NMQVNTPXkKIyBDT05GSUdfTEVEU19DTEFTU19GTEFTSCBpcyBu
b3Qgc2V0CiMgQ09ORklHX0xFRFNfQ0xBU1NfTVVMVElDT0xPUiBpcyBub3Qgc2V0CiMgQ09O
RklHX0xFRFNfQlJJR0hUTkVTU19IV19DSEFOR0VEIGlzIG5vdCBzZXQKCiMKIyBMRUQgZHJp
dmVycwojCiMgQ09ORklHX0xFRFNfQU4zMDI1OUEgaXMgbm90IHNldAojIENPTkZJR19MRURT
X0FQVSBpcyBub3Qgc2V0CiMgQ09ORklHX0xFRFNfQVcyMDEzIGlzIG5vdCBzZXQKIyBDT05G
SUdfTEVEU19CQ002MzI4IGlzIG5vdCBzZXQKIyBDT05GSUdfTEVEU19CQ002MzU4IGlzIG5v
dCBzZXQKIyBDT05GSUdfTEVEU19DUjAwMTQxMTQgaXMgbm90IHNldAojIENPTkZJR19MRURT
X0VMMTUyMDMwMDAgaXMgbm90IHNldAojIENPTkZJR19MRURTX0xNMzUzMCBpcyBub3Qgc2V0
CiMgQ09ORklHX0xFRFNfTE0zNTMyIGlzIG5vdCBzZXQKIyBDT05GSUdfTEVEU19MTTM2NDIg
aXMgbm90IHNldAojIENPTkZJR19MRURTX0xNMzY5MlggaXMgbm90IHNldAojIENPTkZJR19M
RURTX1BDQTk1MzIgaXMgbm90IHNldAojIENPTkZJR19MRURTX0dQSU8gaXMgbm90IHNldAoj
IENPTkZJR19MRURTX0xQMzk0NCBpcyBub3Qgc2V0CiMgQ09ORklHX0xFRFNfTFAzOTUyIGlz
IG5vdCBzZXQKIyBDT05GSUdfTEVEU19MUDUwWFggaXMgbm90IHNldAojIENPTkZJR19MRURT
X0xQNTVYWF9DT01NT04gaXMgbm90IHNldAojIENPTkZJR19MRURTX0xQODg2MCBpcyBub3Qg
c2V0CiMgQ09ORklHX0xFRFNfQ0xFVk9fTUFJTCBpcyBub3Qgc2V0CiMgQ09ORklHX0xFRFNf
UENBOTU1WCBpcyBub3Qgc2V0CiMgQ09ORklHX0xFRFNfUENBOTYzWCBpcyBub3Qgc2V0CiMg
Q09ORklHX0xFRFNfREFDMTI0UzA4NSBpcyBub3Qgc2V0CiMgQ09ORklHX0xFRFNfQkQyODAy
IGlzIG5vdCBzZXQKIyBDT05GSUdfTEVEU19JTlRFTF9TUzQyMDAgaXMgbm90IHNldAojIENP
TkZJR19MRURTX0xUMzU5MyBpcyBub3Qgc2V0CiMgQ09ORklHX0xFRFNfVENBNjUwNyBpcyBu
b3Qgc2V0CiMgQ09ORklHX0xFRFNfVExDNTkxWFggaXMgbm90IHNldAojIENPTkZJR19MRURT
X0xNMzU1eCBpcyBub3Qgc2V0CiMgQ09ORklHX0xFRFNfSVMzMUZMMzE5WCBpcyBub3Qgc2V0
CiMgQ09ORklHX0xFRFNfSVMzMUZMMzJYWCBpcyBub3Qgc2V0CgojCiMgTEVEIGRyaXZlciBm
b3IgYmxpbmsoMSkgVVNCIFJHQiBMRUQgaXMgdW5kZXIgU3BlY2lhbCBISUQgZHJpdmVycyAo
SElEX1RISU5HTSkKIwojIENPTkZJR19MRURTX0JMSU5LTSBpcyBub3Qgc2V0CiMgQ09ORklH
X0xFRFNfTUxYQ1BMRCBpcyBub3Qgc2V0CiMgQ09ORklHX0xFRFNfTUxYUkVHIGlzIG5vdCBz
ZXQKIyBDT05GSUdfTEVEU19VU0VSIGlzIG5vdCBzZXQKIyBDT05GSUdfTEVEU19OSUM3OEJY
IGlzIG5vdCBzZXQKIyBDT05GSUdfTEVEU19TUElfQllURSBpcyBub3Qgc2V0CiMgQ09ORklH
X0xFRFNfVElfTE1VX0NPTU1PTiBpcyBub3Qgc2V0CgojCiMgTEVEIFRyaWdnZXJzCiMKQ09O
RklHX0xFRFNfVFJJR0dFUlM9eQojIENPTkZJR19MRURTX1RSSUdHRVJfVElNRVIgaXMgbm90
IHNldAojIENPTkZJR19MRURTX1RSSUdHRVJfT05FU0hPVCBpcyBub3Qgc2V0CiMgQ09ORklH
X0xFRFNfVFJJR0dFUl9ESVNLIGlzIG5vdCBzZXQKIyBDT05GSUdfTEVEU19UUklHR0VSX0hF
QVJUQkVBVCBpcyBub3Qgc2V0CiMgQ09ORklHX0xFRFNfVFJJR0dFUl9CQUNLTElHSFQgaXMg
bm90IHNldAojIENPTkZJR19MRURTX1RSSUdHRVJfQ1BVIGlzIG5vdCBzZXQKIyBDT05GSUdf
TEVEU19UUklHR0VSX0FDVElWSVRZIGlzIG5vdCBzZXQKIyBDT05GSUdfTEVEU19UUklHR0VS
X0dQSU8gaXMgbm90IHNldAojIENPTkZJR19MRURTX1RSSUdHRVJfREVGQVVMVF9PTiBpcyBu
b3Qgc2V0CgojCiMgaXB0YWJsZXMgdHJpZ2dlciBpcyB1bmRlciBOZXRmaWx0ZXIgY29uZmln
IChMRUQgdGFyZ2V0KQojCiMgQ09ORklHX0xFRFNfVFJJR0dFUl9UUkFOU0lFTlQgaXMgbm90
IHNldAojIENPTkZJR19MRURTX1RSSUdHRVJfQ0FNRVJBIGlzIG5vdCBzZXQKIyBDT05GSUdf
TEVEU19UUklHR0VSX1BBTklDIGlzIG5vdCBzZXQKIyBDT05GSUdfTEVEU19UUklHR0VSX05F
VERFViBpcyBub3Qgc2V0CiMgQ09ORklHX0xFRFNfVFJJR0dFUl9QQVRURVJOIGlzIG5vdCBz
ZXQKQ09ORklHX0xFRFNfVFJJR0dFUl9BVURJTz15CiMgQ09ORklHX0FDQ0VTU0lCSUxJVFkg
aXMgbm90IHNldAojIENPTkZJR19JTkZJTklCQU5EIGlzIG5vdCBzZXQKQ09ORklHX0VEQUNf
QVRPTUlDX1NDUlVCPXkKQ09ORklHX0VEQUNfU1VQUE9SVD15CiMgQ09ORklHX0VEQUMgaXMg
bm90IHNldApDT05GSUdfUlRDX0xJQj15CkNPTkZJR19SVENfTUMxNDY4MThfTElCPXkKQ09O
RklHX1JUQ19DTEFTUz15CiMgQ09ORklHX1JUQ19IQ1RPU1lTIGlzIG5vdCBzZXQKIyBDT05G
SUdfUlRDX1NZU1RPSEMgaXMgbm90IHNldAojIENPTkZJR19SVENfREVCVUcgaXMgbm90IHNl
dApDT05GSUdfUlRDX05WTUVNPXkKCiMKIyBSVEMgaW50ZXJmYWNlcwojCkNPTkZJR19SVENf
SU5URl9TWVNGUz15CkNPTkZJR19SVENfSU5URl9QUk9DPXkKQ09ORklHX1JUQ19JTlRGX0RF
Vj15CiMgQ09ORklHX1JUQ19JTlRGX0RFVl9VSUVfRU1VTCBpcyBub3Qgc2V0CiMgQ09ORklH
X1JUQ19EUlZfVEVTVCBpcyBub3Qgc2V0CgojCiMgSTJDIFJUQyBkcml2ZXJzCiMKIyBDT05G
SUdfUlRDX0RSVl9BQkI1WkVTMyBpcyBub3Qgc2V0CiMgQ09ORklHX1JUQ19EUlZfQUJFT1o5
IGlzIG5vdCBzZXQKIyBDT05GSUdfUlRDX0RSVl9BQlg4MFggaXMgbm90IHNldAojIENPTkZJ
R19SVENfRFJWX0RTMTMwNyBpcyBub3Qgc2V0CiMgQ09ORklHX1JUQ19EUlZfRFMxMzc0IGlz
IG5vdCBzZXQKIyBDT05GSUdfUlRDX0RSVl9EUzE2NzIgaXMgbm90IHNldAojIENPTkZJR19S
VENfRFJWX0hZTTg1NjMgaXMgbm90IHNldAojIENPTkZJR19SVENfRFJWX01BWDY5MDAgaXMg
bm90IHNldAojIENPTkZJR19SVENfRFJWX1JTNUMzNzIgaXMgbm90IHNldAojIENPTkZJR19S
VENfRFJWX0lTTDEyMDggaXMgbm90IHNldAojIENPTkZJR19SVENfRFJWX0lTTDEyMDIyIGlz
IG5vdCBzZXQKIyBDT05GSUdfUlRDX0RSVl9JU0wxMjAyNiBpcyBub3Qgc2V0CiMgQ09ORklH
X1JUQ19EUlZfWDEyMDUgaXMgbm90IHNldAojIENPTkZJR19SVENfRFJWX1BDRjg1MjMgaXMg
bm90IHNldAojIENPTkZJR19SVENfRFJWX1BDRjg1MDYzIGlzIG5vdCBzZXQKIyBDT05GSUdf
UlRDX0RSVl9QQ0Y4NTM2MyBpcyBub3Qgc2V0CiMgQ09ORklHX1JUQ19EUlZfUENGODU2MyBp
cyBub3Qgc2V0CiMgQ09ORklHX1JUQ19EUlZfUENGODU4MyBpcyBub3Qgc2V0CiMgQ09ORklH
X1JUQ19EUlZfTTQxVDgwIGlzIG5vdCBzZXQKIyBDT05GSUdfUlRDX0RSVl9CUTMySyBpcyBu
b3Qgc2V0CiMgQ09ORklHX1JUQ19EUlZfUzM1MzkwQSBpcyBub3Qgc2V0CiMgQ09ORklHX1JU
Q19EUlZfRk0zMTMwIGlzIG5vdCBzZXQKIyBDT05GSUdfUlRDX0RSVl9SWDgwMTAgaXMgbm90
IHNldAojIENPTkZJR19SVENfRFJWX1JYODU4MSBpcyBub3Qgc2V0CiMgQ09ORklHX1JUQ19E
UlZfUlg4MDI1IGlzIG5vdCBzZXQKIyBDT05GSUdfUlRDX0RSVl9FTTMwMjcgaXMgbm90IHNl
dAojIENPTkZJR19SVENfRFJWX1JWMzAyOCBpcyBub3Qgc2V0CiMgQ09ORklHX1JUQ19EUlZf
UlYzMDMyIGlzIG5vdCBzZXQKIyBDT05GSUdfUlRDX0RSVl9SVjg4MDMgaXMgbm90IHNldAoj
IENPTkZJR19SVENfRFJWX1NEMzA3OCBpcyBub3Qgc2V0CgojCiMgU1BJIFJUQyBkcml2ZXJz
CiMKIyBDT05GSUdfUlRDX0RSVl9NNDFUOTMgaXMgbm90IHNldAojIENPTkZJR19SVENfRFJW
X000MVQ5NCBpcyBub3Qgc2V0CiMgQ09ORklHX1JUQ19EUlZfRFMxMzAyIGlzIG5vdCBzZXQK
IyBDT05GSUdfUlRDX0RSVl9EUzEzMDUgaXMgbm90IHNldAojIENPTkZJR19SVENfRFJWX0RT
MTM0MyBpcyBub3Qgc2V0CiMgQ09ORklHX1JUQ19EUlZfRFMxMzQ3IGlzIG5vdCBzZXQKIyBD
T05GSUdfUlRDX0RSVl9EUzEzOTAgaXMgbm90IHNldAojIENPTkZJR19SVENfRFJWX01BWDY5
MTYgaXMgbm90IHNldAojIENPTkZJR19SVENfRFJWX1I5NzAxIGlzIG5vdCBzZXQKIyBDT05G
SUdfUlRDX0RSVl9SWDQ1ODEgaXMgbm90IHNldAojIENPTkZJR19SVENfRFJWX1JYNjExMCBp
cyBub3Qgc2V0CiMgQ09ORklHX1JUQ19EUlZfUlM1QzM0OCBpcyBub3Qgc2V0CiMgQ09ORklH
X1JUQ19EUlZfTUFYNjkwMiBpcyBub3Qgc2V0CiMgQ09ORklHX1JUQ19EUlZfUENGMjEyMyBp
cyBub3Qgc2V0CiMgQ09ORklHX1JUQ19EUlZfTUNQNzk1IGlzIG5vdCBzZXQKQ09ORklHX1JU
Q19JMkNfQU5EX1NQST15CgojCiMgU1BJIGFuZCBJMkMgUlRDIGRyaXZlcnMKIwojIENPTkZJ
R19SVENfRFJWX0RTMzIzMiBpcyBub3Qgc2V0CiMgQ09ORklHX1JUQ19EUlZfUENGMjEyNyBp
cyBub3Qgc2V0CiMgQ09ORklHX1JUQ19EUlZfUlYzMDI5QzIgaXMgbm90IHNldAoKIwojIFBs
YXRmb3JtIFJUQyBkcml2ZXJzCiMKQ09ORklHX1JUQ19EUlZfQ01PUz15CiMgQ09ORklHX1JU
Q19EUlZfRFMxMjg2IGlzIG5vdCBzZXQKIyBDT05GSUdfUlRDX0RSVl9EUzE1MTEgaXMgbm90
IHNldAojIENPTkZJR19SVENfRFJWX0RTMTU1MyBpcyBub3Qgc2V0CiMgQ09ORklHX1JUQ19E
UlZfRFMxNjg1X0ZBTUlMWSBpcyBub3Qgc2V0CiMgQ09ORklHX1JUQ19EUlZfRFMxNzQyIGlz
IG5vdCBzZXQKIyBDT05GSUdfUlRDX0RSVl9EUzI0MDQgaXMgbm90IHNldAojIENPTkZJR19S
VENfRFJWX1NUSzE3VEE4IGlzIG5vdCBzZXQKIyBDT05GSUdfUlRDX0RSVl9NNDhUODYgaXMg
bm90IHNldAojIENPTkZJR19SVENfRFJWX000OFQzNSBpcyBub3Qgc2V0CiMgQ09ORklHX1JU
Q19EUlZfTTQ4VDU5IGlzIG5vdCBzZXQKIyBDT05GSUdfUlRDX0RSVl9NU002MjQyIGlzIG5v
dCBzZXQKIyBDT05GSUdfUlRDX0RSVl9CUTQ4MDIgaXMgbm90IHNldAojIENPTkZJR19SVENf
RFJWX1JQNUMwMSBpcyBub3Qgc2V0CiMgQ09ORklHX1JUQ19EUlZfVjMwMjAgaXMgbm90IHNl
dAojIENPTkZJR19SVENfRFJWX1pZTlFNUCBpcyBub3Qgc2V0CiMgQ09ORklHX1JUQ19EUlZf
Q1JPU19FQyBpcyBub3Qgc2V0CgojCiMgb24tQ1BVIFJUQyBkcml2ZXJzCiMKIyBDT05GSUdf
UlRDX0RSVl9DQURFTkNFIGlzIG5vdCBzZXQKIyBDT05GSUdfUlRDX0RSVl9GVFJUQzAxMCBp
cyBub3Qgc2V0CiMgQ09ORklHX1JUQ19EUlZfUjczMDEgaXMgbm90IHNldAoKIwojIEhJRCBT
ZW5zb3IgUlRDIGRyaXZlcnMKIwpDT05GSUdfRE1BREVWSUNFUz15CiMgQ09ORklHX0RNQURF
VklDRVNfREVCVUcgaXMgbm90IHNldAoKIwojIERNQSBEZXZpY2VzCiMKQ09ORklHX0RNQV9F
TkdJTkU9eQpDT05GSUdfRE1BX1ZJUlRVQUxfQ0hBTk5FTFM9eQpDT05GSUdfRE1BX0FDUEk9
eQpDT05GSUdfRE1BX09GPXkKIyBDT05GSUdfQUxURVJBX01TR0RNQSBpcyBub3Qgc2V0CiMg
Q09ORklHX0RXX0FYSV9ETUFDIGlzIG5vdCBzZXQKIyBDT05GSUdfRlNMX0VETUEgaXMgbm90
IHNldApDT05GSUdfSU5URUxfSURNQTY0PXkKIyBDT05GSUdfSU5URUxfSURYRCBpcyBub3Qg
c2V0CiMgQ09ORklHX0lOVEVMX0lPQVRETUEgaXMgbm90IHNldAojIENPTkZJR19QQ0lfQ09J
T01NVSBpcyBub3Qgc2V0CiMgQ09ORklHX1BMWF9ETUEgaXMgbm90IHNldAojIENPTkZJR19Y
SUxJTlhfWllOUU1QX0RQRE1BIGlzIG5vdCBzZXQKIyBDT05GSUdfUUNPTV9ISURNQV9NR01U
IGlzIG5vdCBzZXQKIyBDT05GSUdfUUNPTV9ISURNQSBpcyBub3Qgc2V0CkNPTkZJR19EV19E
TUFDX0NPUkU9eQpDT05GSUdfRFdfRE1BQz15CkNPTkZJR19EV19ETUFDX1BDST15CiMgQ09O
RklHX0RXX0VETUEgaXMgbm90IHNldAojIENPTkZJR19EV19FRE1BX1BDSUUgaXMgbm90IHNl
dApDT05GSUdfSFNVX0RNQT15CiMgQ09ORklHX1NGX1BETUEgaXMgbm90IHNldAoKIwojIERN
QSBDbGllbnRzCiMKIyBDT05GSUdfQVNZTkNfVFhfRE1BIGlzIG5vdCBzZXQKIyBDT05GSUdf
RE1BVEVTVCBpcyBub3Qgc2V0CgojCiMgRE1BQlVGIG9wdGlvbnMKIwpDT05GSUdfU1lOQ19G
SUxFPXkKQ09ORklHX1NXX1NZTkM9eQpDT05GSUdfVURNQUJVRj15CiMgQ09ORklHX0RNQUJV
Rl9NT1ZFX05PVElGWSBpcyBub3Qgc2V0CiMgQ09ORklHX0RNQUJVRl9ERUJVRyBpcyBub3Qg
c2V0CiMgQ09ORklHX0RNQUJVRl9TRUxGVEVTVFMgaXMgbm90IHNldAojIENPTkZJR19ETUFC
VUZfSEVBUFMgaXMgbm90IHNldAojIENPTkZJR19ETUFCVUZfU1lTRlNfU1RBVFMgaXMgbm90
IHNldAojIGVuZCBvZiBETUFCVUYgb3B0aW9ucwoKIyBDT05GSUdfQVVYRElTUExBWSBpcyBu
b3Qgc2V0CiMgQ09ORklHX1VJTyBpcyBub3Qgc2V0CiMgQ09ORklHX1ZGSU8gaXMgbm90IHNl
dApDT05GSUdfSVJRX0JZUEFTU19NQU5BR0VSPXkKIyBDT05GSUdfVklSVF9EUklWRVJTIGlz
IG5vdCBzZXQKQ09ORklHX1ZJUlRJTz15CkNPTkZJR19WSVJUSU9fTUVOVT15CkNPTkZJR19W
SVJUSU9fUENJPXkKQ09ORklHX1ZJUlRJT19QQ0lfTEVHQUNZPXkKIyBDT05GSUdfVklSVElP
X0JBTExPT04gaXMgbm90IHNldApDT05GSUdfVklSVElPX0lOUFVUPXkKIyBDT05GSUdfVklS
VElPX01NSU8gaXMgbm90IHNldApDT05GSUdfVklSVElPX0RNQV9TSEFSRURfQlVGRkVSPXkK
Q09ORklHX1ZJUlRJT19XTD15CiMgQ09ORklHX1ZEUEEgaXMgbm90IHNldApDT05GSUdfVkhP
U1RfSU9UTEI9eQpDT05GSUdfVkhPU1Q9eQpDT05GSUdfVkhPU1RfTUVOVT15CiMgQ09ORklH
X1ZIT1NUX05FVCBpcyBub3Qgc2V0CkNPTkZJR19WSE9TVF9WU09DSz15CiMgQ09ORklHX1ZI
T1NUX0NST1NTX0VORElBTl9MRUdBQ1kgaXMgbm90IHNldAoKIwojIE1pY3Jvc29mdCBIeXBl
ci1WIGd1ZXN0IHN1cHBvcnQKIwojIENPTkZJR19IWVBFUlYgaXMgbm90IHNldAojIGVuZCBv
ZiBNaWNyb3NvZnQgSHlwZXItViBndWVzdCBzdXBwb3J0CgojIENPTkZJR19HUkVZQlVTIGlz
IG5vdCBzZXQKQ09ORklHX1NUQUdJTkc9eQojIENPTkZJR19QUklTTTJfVVNCIGlzIG5vdCBz
ZXQKIyBDT05GSUdfQ09NRURJIGlzIG5vdCBzZXQKIyBDT05GSUdfUlRMODE5MlUgaXMgbm90
IHNldAojIENPTkZJR19SVExMSUIgaXMgbm90IHNldAojIENPTkZJR19SVEw4NzIzQlMgaXMg
bm90IHNldAojIENPTkZJR19SODcxMlUgaXMgbm90IHNldAojIENPTkZJR19SODE4OEVVIGlz
IG5vdCBzZXQKIyBDT05GSUdfUlRTNTIwOCBpcyBub3Qgc2V0CiMgQ09ORklHX1ZUNjY1NSBp
cyBub3Qgc2V0CiMgQ09ORklHX1ZUNjY1NiBpcyBub3Qgc2V0CgojCiMgSUlPIHN0YWdpbmcg
ZHJpdmVycwojCgojCiMgQWNjZWxlcm9tZXRlcnMKIwojIENPTkZJR19BRElTMTYyMDMgaXMg
bm90IHNldAojIENPTkZJR19BRElTMTYyNDAgaXMgbm90IHNldAojIGVuZCBvZiBBY2NlbGVy
b21ldGVycwoKIwojIEFuYWxvZyB0byBkaWdpdGFsIGNvbnZlcnRlcnMKIwojIENPTkZJR19B
RDc4MTYgaXMgbm90IHNldAojIENPTkZJR19BRDcyODAgaXMgbm90IHNldAojIGVuZCBvZiBB
bmFsb2cgdG8gZGlnaXRhbCBjb252ZXJ0ZXJzCgojCiMgQW5hbG9nIGRpZ2l0YWwgYmktZGly
ZWN0aW9uIGNvbnZlcnRlcnMKIwojIENPTkZJR19BRFQ3MzE2IGlzIG5vdCBzZXQKIyBlbmQg
b2YgQW5hbG9nIGRpZ2l0YWwgYmktZGlyZWN0aW9uIGNvbnZlcnRlcnMKCiMKIyBDYXBhY2l0
YW5jZSB0byBkaWdpdGFsIGNvbnZlcnRlcnMKIwojIENPTkZJR19BRDcxNTAgaXMgbm90IHNl
dAojIENPTkZJR19BRDc3NDYgaXMgbm90IHNldAojIGVuZCBvZiBDYXBhY2l0YW5jZSB0byBk
aWdpdGFsIGNvbnZlcnRlcnMKCiMKIyBEaXJlY3QgRGlnaXRhbCBTeW50aGVzaXMKIwojIENP
TkZJR19BRDk4MzIgaXMgbm90IHNldAojIENPTkZJR19BRDk4MzQgaXMgbm90IHNldAojIGVu
ZCBvZiBEaXJlY3QgRGlnaXRhbCBTeW50aGVzaXMKCiMKIyBOZXR3b3JrIEFuYWx5emVyLCBJ
bXBlZGFuY2UgQ29udmVydGVycwojCiMgQ09ORklHX0FENTkzMyBpcyBub3Qgc2V0CiMgZW5k
IG9mIE5ldHdvcmsgQW5hbHl6ZXIsIEltcGVkYW5jZSBDb252ZXJ0ZXJzCgojCiMgQWN0aXZl
IGVuZXJneSBtZXRlcmluZyBJQwojCiMgQ09ORklHX0FERTc4NTQgaXMgbm90IHNldAojIGVu
ZCBvZiBBY3RpdmUgZW5lcmd5IG1ldGVyaW5nIElDCgojCiMgUmVzb2x2ZXIgdG8gZGlnaXRh
bCBjb252ZXJ0ZXJzCiMKIyBDT05GSUdfQUQyUzEyMTAgaXMgbm90IHNldAojIGVuZCBvZiBS
ZXNvbHZlciB0byBkaWdpdGFsIGNvbnZlcnRlcnMKIyBlbmQgb2YgSUlPIHN0YWdpbmcgZHJp
dmVycwoKIyBDT05GSUdfRkJfU003NTAgaXMgbm90IHNldAojIENPTkZJR19TVEFHSU5HX01F
RElBIGlzIG5vdCBzZXQKCiMKIyBBbmRyb2lkCiMKQ09ORklHX0FTSE1FTT15CiMgQ09ORklH
X0lPTiBpcyBub3Qgc2V0CiMgZW5kIG9mIEFuZHJvaWQKCiMgQ09ORklHX1NUQUdJTkdfQk9B
UkQgaXMgbm90IHNldAojIENPTkZJR19MVEVfR0RNNzI0WCBpcyBub3Qgc2V0CiMgQ09ORklH
X0dTX0ZQR0FCT09UIGlzIG5vdCBzZXQKIyBDT05GSUdfVU5JU1lTU1BBUiBpcyBub3Qgc2V0
CiMgQ09ORklHX0NPTU1PTl9DTEtfWExOWF9DTEtXWlJEIGlzIG5vdCBzZXQKIyBDT05GSUdf
RkJfVEZUIGlzIG5vdCBzZXQKIyBDT05GSUdfS1M3MDEwIGlzIG5vdCBzZXQKIyBDT05GSUdf
UEk0MzMgaXMgbm90IHNldAoKIwojIEdhc2tldCBkZXZpY2VzCiMKIyBDT05GSUdfU1RBR0lO
R19HQVNLRVRfRlJBTUVXT1JLIGlzIG5vdCBzZXQKIyBlbmQgb2YgR2Fza2V0IGRldmljZXMK
CiMgQ09ORklHX1hJTF9BWElTX0ZJRk8gaXMgbm90IHNldAojIENPTkZJR19GSUVMREJVU19E
RVYgaXMgbm90IHNldAojIENPTkZJR19RTEdFIGlzIG5vdCBzZXQKIyBDT05GSUdfV0ZYIGlz
IG5vdCBzZXQKQ09ORklHX1g4Nl9QTEFURk9STV9ERVZJQ0VTPXkKQ09ORklHX0FDUElfV01J
PXkKQ09ORklHX1dNSV9CTU9GPXkKIyBDT05GSUdfQUxJRU5XQVJFX1dNSSBpcyBub3Qgc2V0
CiMgQ09ORklHX0hVQVdFSV9XTUkgaXMgbm90IHNldAojIENPTkZJR19JTlRFTF9XTUlfU0JM
X0ZXX1VQREFURSBpcyBub3Qgc2V0CiMgQ09ORklHX0lOVEVMX1dNSV9USFVOREVSQk9MVCBp
cyBub3Qgc2V0CkNPTkZJR19NWE1fV01JPXkKIyBDT05GSUdfUEVBUV9XTUkgaXMgbm90IHNl
dAojIENPTkZJR19YSUFPTUlfV01JIGlzIG5vdCBzZXQKQ09ORklHX0FDRVJIREY9eQojIENP
TkZJR19BQ0VSX1dJUkVMRVNTIGlzIG5vdCBzZXQKIyBDT05GSUdfQUNFUl9XTUkgaXMgbm90
IHNldAojIENPTkZJR19BTURfUE1DIGlzIG5vdCBzZXQKIyBDT05GSUdfQVBQTEVfR01VWCBp
cyBub3Qgc2V0CiMgQ09ORklHX0FTVVNfTEFQVE9QIGlzIG5vdCBzZXQKIyBDT05GSUdfQVNV
U19XSVJFTEVTUyBpcyBub3Qgc2V0CiMgQ09ORklHX0FTVVNfV01JIGlzIG5vdCBzZXQKIyBD
T05GSUdfRUVFUENfTEFQVE9QIGlzIG5vdCBzZXQKIyBDT05GSUdfRENEQkFTIGlzIG5vdCBz
ZXQKIyBDT05GSUdfREVMTF9TTUJJT1MgaXMgbm90IHNldAojIENPTkZJR19ERUxMX1JCVE4g
aXMgbm90IHNldAojIENPTkZJR19ERUxMX1JCVSBpcyBub3Qgc2V0CiMgQ09ORklHX0RFTExf
U01PODgwMCBpcyBub3Qgc2V0CiMgQ09ORklHX0RFTExfV01JX0FJTyBpcyBub3Qgc2V0CiMg
Q09ORklHX0RFTExfV01JX0xFRCBpcyBub3Qgc2V0CiMgQ09ORklHX0FNSUxPX1JGS0lMTCBp
cyBub3Qgc2V0CiMgQ09ORklHX0ZVSklUU1VfTEFQVE9QIGlzIG5vdCBzZXQKIyBDT05GSUdf
RlVKSVRTVV9UQUJMRVQgaXMgbm90IHNldAojIENPTkZJR19HUERfUE9DS0VUX0ZBTiBpcyBu
b3Qgc2V0CiMgQ09ORklHX0hQX0FDQ0VMIGlzIG5vdCBzZXQKIyBDT05GSUdfSFBfV0lSRUxF
U1MgaXMgbm90IHNldApDT05GSUdfSFBfV01JPXkKIyBDT05GSUdfSUJNX1JUTCBpcyBub3Qg
c2V0CiMgQ09ORklHX0lERUFQQURfTEFQVE9QIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09S
U19IREFQUyBpcyBub3Qgc2V0CiMgQ09ORklHX1RISU5LUEFEX0FDUEkgaXMgbm90IHNldAoj
IENPTkZJR19USElOS1BBRF9MTUkgaXMgbm90IHNldAojIENPTkZJR19JTlRFTF9TQVJfSU5U
MTA5MiBpcyBub3Qgc2V0CkNPTkZJR19JTlRFTF9QTUNfQ09SRT15CiMgQ09ORklHX0lOVEVM
X1BVTklUX0lQQyBpcyBub3Qgc2V0CiMgQ09ORklHX0lOVEVMX1JTVCBpcyBub3Qgc2V0CiMg
Q09ORklHX0lOVEVMX1NNQVJUQ09OTkVDVCBpcyBub3Qgc2V0CiMgQ09ORklHX0lOVEVMX1RV
UkJPX01BWF8zIGlzIG5vdCBzZXQKIyBDT05GSUdfSU5URUxfVU5DT1JFX0ZSRVFfQ09OVFJP
TCBpcyBub3Qgc2V0CiMgQ09ORklHX0lOVEVMX1ZTRUMgaXMgbm90IHNldAojIENPTkZJR19J
TlRFTF9BVE9NSVNQMl9QTSBpcyBub3Qgc2V0CiMgQ09ORklHX0lOVEVMX0hJRF9FVkVOVCBp
cyBub3Qgc2V0CiMgQ09ORklHX0lOVEVMX0lOVDAwMDJfVkdQSU8gaXMgbm90IHNldApDT05G
SUdfSU5URUxfTUVOTE9XPXkKIyBDT05GSUdfSU5URUxfT0FLVFJBSUwgaXMgbm90IHNldApD
T05GSUdfSU5URUxfVkJUTj15CiMgQ09ORklHX01TSV9MQVBUT1AgaXMgbm90IHNldAojIENP
TkZJR19NU0lfV01JIGlzIG5vdCBzZXQKIyBDT05GSUdfUENFTkdJTkVTX0FQVTIgaXMgbm90
IHNldAojIENPTkZJR19TQU1TVU5HX0xBUFRPUCBpcyBub3Qgc2V0CiMgQ09ORklHX1NBTVNV
TkdfUTEwIGlzIG5vdCBzZXQKIyBDT05GSUdfQUNQSV9UT1NISUJBIGlzIG5vdCBzZXQKIyBD
T05GSUdfVE9TSElCQV9CVF9SRktJTEwgaXMgbm90IHNldAojIENPTkZJR19UT1NISUJBX0hB
UFMgaXMgbm90IHNldAojIENPTkZJR19UT1NISUJBX1dNSSBpcyBub3Qgc2V0CiMgQ09ORklH
X0FDUElfQ01QQyBpcyBub3Qgc2V0CiMgQ09ORklHX0NPTVBBTF9MQVBUT1AgaXMgbm90IHNl
dAojIENPTkZJR19MR19MQVBUT1AgaXMgbm90IHNldAojIENPTkZJR19QQU5BU09OSUNfTEFQ
VE9QIGlzIG5vdCBzZXQKIyBDT05GSUdfU09OWV9MQVBUT1AgaXMgbm90IHNldAojIENPTkZJ
R19TWVNURU03Nl9BQ1BJIGlzIG5vdCBzZXQKIyBDT05GSUdfVE9QU1RBUl9MQVBUT1AgaXMg
bm90IHNldAojIENPTkZJR19JMkNfTVVMVElfSU5TVEFOVElBVEUgaXMgbm90IHNldAojIENP
TkZJR19NTFhfUExBVEZPUk0gaXMgbm90IHNldApDT05GSUdfQUNQSV9DSFJPTUVPUz15CiMg
Q09ORklHX0lOVEVMX0lQUyBpcyBub3Qgc2V0CgojCiMgSW50ZWwgU3BlZWQgU2VsZWN0IFRl
Y2hub2xvZ3kgaW50ZXJmYWNlIHN1cHBvcnQKIwojIENPTkZJR19JTlRFTF9TUEVFRF9TRUxF
Q1RfSU5URVJGQUNFIGlzIG5vdCBzZXQKIyBlbmQgb2YgSW50ZWwgU3BlZWQgU2VsZWN0IFRl
Y2hub2xvZ3kgaW50ZXJmYWNlIHN1cHBvcnQKCkNPTkZJR19JTlRFTF9TQ1VfSVBDPXkKQ09O
RklHX0lOVEVMX1NDVT15CiMgQ09ORklHX0lOVEVMX1NDVV9QQ0kgaXMgbm90IHNldApDT05G
SUdfSU5URUxfU0NVX1BMQVRGT1JNPXkKIyBDT05GSUdfSU5URUxfU0NVX0lQQ19VVElMIGlz
IG5vdCBzZXQKQ09ORklHX1BNQ19BVE9NPXkKQ09ORklHX0NIUk9NRV9QTEFURk9STVM9eQpD
T05GSUdfQ0hST01FT1NfTEFQVE9QPXkKQ09ORklHX0NIUk9NRU9TX1BTVE9SRT15CkNPTkZJ
R19DSFJPTUVPU19UQk1DPXkKQ09ORklHX0NST1NfRUM9eQpDT05GSUdfQ1JPU19FQ19JMkM9
eQpDT05GSUdfQ1JPU19FQ19TUEk9eQpDT05GSUdfQ1JPU19FQ19MUEM9eQpDT05GSUdfQ1JP
U19FQ19QUk9UTz15CkNPTkZJR19DUk9TX0tCRF9MRURfQkFDS0xJR0hUPXkKQ09ORklHX0NS
T1NfRUNfQ0hBUkRFVj15CkNPTkZJR19DUk9TX0VDX0xJR0hUQkFSPXkKIyBDT05GSUdfQ1JP
U19FQ19WQkMgaXMgbm90IHNldApDT05GSUdfQ1JPU19FQ19ERUJVR0ZTPXkKQ09ORklHX0NS
T1NfRUNfU0VOU09SSFVCPXkKQ09ORklHX0NST1NfRUNfU1lTRlM9eQpDT05GSUdfQ1JPU19F
Q19QRF9VUERBVEU9eQojIENPTkZJR19DUk9TX0hQU19JMkMgaXMgbm90IHNldApDT05GSUdf
Q1JPU19VU0JQRF9MT0dHRVI9eQpDT05GSUdfQ1JPU19VU0JQRF9OT1RJRlk9eQojIENPTkZJ
R19DSFJPTUVPU19QUklWQUNZX1NDUkVFTiBpcyBub3Qgc2V0CkNPTkZJR19DUk9TX1RZUEVD
X1NXSVRDSD15CiMgQ09ORklHX1dJTENPX0VDIGlzIG5vdCBzZXQKIyBDT05GSUdfTUVMTEFO
T1hfUExBVEZPUk0gaXMgbm90IHNldApDT05GSUdfU1VSRkFDRV9QTEFURk9STVM9eQojIENP
TkZJR19TVVJGQUNFM19XTUkgaXMgbm90IHNldAojIENPTkZJR19TVVJGQUNFXzNfQlVUVE9O
IGlzIG5vdCBzZXQKIyBDT05GSUdfU1VSRkFDRV8zX1BPV0VSX09QUkVHSU9OIGlzIG5vdCBz
ZXQKIyBDT05GSUdfU1VSRkFDRV9HUEUgaXMgbm90IHNldAojIENPTkZJR19TVVJGQUNFX1BS
TzNfQlVUVE9OIGlzIG5vdCBzZXQKQ09ORklHX0hBVkVfQ0xLPXkKQ09ORklHX0NMS0RFVl9M
T09LVVA9eQpDT05GSUdfSEFWRV9DTEtfUFJFUEFSRT15CkNPTkZJR19DT01NT05fQ0xLPXkK
IyBDT05GSUdfQ09NTU9OX0NMS19NQVg5NDg1IGlzIG5vdCBzZXQKIyBDT05GSUdfQ09NTU9O
X0NMS19TSTUzNDEgaXMgbm90IHNldAojIENPTkZJR19DT01NT05fQ0xLX1NJNTM1MSBpcyBu
b3Qgc2V0CiMgQ09ORklHX0NPTU1PTl9DTEtfU0k1MTQgaXMgbm90IHNldAojIENPTkZJR19D
T01NT05fQ0xLX1NJNTQ0IGlzIG5vdCBzZXQKIyBDT05GSUdfQ09NTU9OX0NMS19TSTU3MCBp
cyBub3Qgc2V0CiMgQ09ORklHX0NPTU1PTl9DTEtfQ0RDRTcwNiBpcyBub3Qgc2V0CiMgQ09O
RklHX0NPTU1PTl9DTEtfQ0RDRTkyNSBpcyBub3Qgc2V0CiMgQ09ORklHX0NPTU1PTl9DTEtf
Q1MyMDAwX0NQIGlzIG5vdCBzZXQKIyBDT05GSUdfQ09NTU9OX0NMS19WQzUgaXMgbm90IHNl
dAojIENPTkZJR19DT01NT05fQ0xLX0ZJWEVEX01NSU8gaXMgbm90IHNldAojIENPTkZJR19D
TEtfTEdNX0NHVSBpcyBub3Qgc2V0CiMgQ09ORklHX0hXU1BJTkxPQ0sgaXMgbm90IHNldAoK
IwojIENsb2NrIFNvdXJjZSBkcml2ZXJzCiMKQ09ORklHX0NMS0VWVF9JODI1Mz15CkNPTkZJ
R19DTEtCTERfSTgyNTM9eQojIENPTkZJR19NSUNST0NISVBfUElUNjRCIGlzIG5vdCBzZXQK
IyBlbmQgb2YgQ2xvY2sgU291cmNlIGRyaXZlcnMKCkNPTkZJR19NQUlMQk9YPXkKIyBDT05G
SUdfUExBVEZPUk1fTUhVIGlzIG5vdCBzZXQKQ09ORklHX1BDQz15CiMgQ09ORklHX0FMVEVS
QV9NQk9YIGlzIG5vdCBzZXQKIyBDT05GSUdfTUFJTEJPWF9URVNUIGlzIG5vdCBzZXQKQ09O
RklHX0lPTU1VX0FQST15CkNPTkZJR19JT01NVV9TVVBQT1JUPXkKCiMKIyBHZW5lcmljIElP
TU1VIFBhZ2V0YWJsZSBTdXBwb3J0CiMKIyBlbmQgb2YgR2VuZXJpYyBJT01NVSBQYWdldGFi
bGUgU3VwcG9ydAoKIyBDT05GSUdfSU9NTVVfREVCVUdGUyBpcyBub3Qgc2V0CiMgQ09ORklH
X0lPTU1VX0RFRkFVTFRfUEFTU1RIUk9VR0ggaXMgbm90IHNldApDT05GSUdfT0ZfSU9NTVU9
eQojIENPTkZJR19BTURfSU9NTVUgaXMgbm90IHNldAojIENPTkZJR19JTlRFTF9JT01NVSBp
cyBub3Qgc2V0CiMgQ09ORklHX0lSUV9SRU1BUCBpcyBub3Qgc2V0CiMgQ09ORklHX1ZJUlRJ
T19JT01NVSBpcyBub3Qgc2V0CgojCiMgUmVtb3RlcHJvYyBkcml2ZXJzCiMKIyBDT05GSUdf
UkVNT1RFUFJPQyBpcyBub3Qgc2V0CiMgZW5kIG9mIFJlbW90ZXByb2MgZHJpdmVycwoKIwoj
IFJwbXNnIGRyaXZlcnMKIwojIENPTkZJR19SUE1TR19RQ09NX0dMSU5LX1JQTSBpcyBub3Qg
c2V0CiMgQ09ORklHX1JQTVNHX1ZJUlRJTyBpcyBub3Qgc2V0CiMgZW5kIG9mIFJwbXNnIGRy
aXZlcnMKCkNPTkZJR19TT1VORFdJUkU9eQoKIwojIFNvdW5kV2lyZSBEZXZpY2VzCiMKQ09O
RklHX1NPVU5EV0lSRV9DQURFTkNFPXkKQ09ORklHX1NPVU5EV0lSRV9JTlRFTD15CiMgQ09O
RklHX1NPVU5EV0lSRV9RQ09NIGlzIG5vdCBzZXQKQ09ORklHX1NPVU5EV0lSRV9HRU5FUklD
X0FMTE9DQVRJT049eQoKIwojIFNPQyAoU3lzdGVtIE9uIENoaXApIHNwZWNpZmljIERyaXZl
cnMKIwoKIwojIEFtbG9naWMgU29DIGRyaXZlcnMKIwojIGVuZCBvZiBBbWxvZ2ljIFNvQyBk
cml2ZXJzCgojCiMgQXNwZWVkIFNvQyBkcml2ZXJzCiMKIyBlbmQgb2YgQXNwZWVkIFNvQyBk
cml2ZXJzCgojCiMgQnJvYWRjb20gU29DIGRyaXZlcnMKIwojIGVuZCBvZiBCcm9hZGNvbSBT
b0MgZHJpdmVycwoKIwojIE5YUC9GcmVlc2NhbGUgUW9ySVEgU29DIGRyaXZlcnMKIwojIGVu
ZCBvZiBOWFAvRnJlZXNjYWxlIFFvcklRIFNvQyBkcml2ZXJzCgojCiMgaS5NWCBTb0MgZHJp
dmVycwojCiMgZW5kIG9mIGkuTVggU29DIGRyaXZlcnMKCiMKIyBRdWFsY29tbSBTb0MgZHJp
dmVycwojCiMgZW5kIG9mIFF1YWxjb21tIFNvQyBkcml2ZXJzCgojIENPTkZJR19TT0NfVEkg
aXMgbm90IHNldAoKIwojIFhpbGlueCBTb0MgZHJpdmVycwojCiMgQ09ORklHX1hJTElOWF9W
Q1UgaXMgbm90IHNldAojIGVuZCBvZiBYaWxpbnggU29DIGRyaXZlcnMKIyBlbmQgb2YgU09D
IChTeXN0ZW0gT24gQ2hpcCkgc3BlY2lmaWMgRHJpdmVycwoKIyBDT05GSUdfUE1fREVWRlJF
USBpcyBub3Qgc2V0CiMgQ09ORklHX0VYVENPTiBpcyBub3Qgc2V0CiMgQ09ORklHX01FTU9S
WSBpcyBub3Qgc2V0CkNPTkZJR19JSU89eQpDT05GSUdfSUlPX0JVRkZFUj15CiMgQ09ORklH
X0lJT19CVUZGRVJfQ0IgaXMgbm90IHNldAojIENPTkZJR19JSU9fQlVGRkVSX0RNQSBpcyBu
b3Qgc2V0CiMgQ09ORklHX0lJT19CVUZGRVJfRE1BRU5HSU5FIGlzIG5vdCBzZXQKIyBDT05G
SUdfSUlPX0JVRkZFUl9IV19DT05TVU1FUiBpcyBub3Qgc2V0CkNPTkZJR19JSU9fS0ZJRk9f
QlVGPXkKQ09ORklHX0lJT19UUklHR0VSRURfQlVGRkVSPXkKQ09ORklHX0lJT19DT05GSUdG
Uz15CkNPTkZJR19JSU9fVFJJR0dFUj15CkNPTkZJR19JSU9fQ09OU1VNRVJTX1BFUl9UUklH
R0VSPTIKIyBDT05GSUdfSUlPX1NXX0RFVklDRSBpcyBub3Qgc2V0CkNPTkZJR19JSU9fU1df
VFJJR0dFUj15CiMgQ09ORklHX0lJT19UUklHR0VSRURfRVZFTlQgaXMgbm90IHNldAoKIwoj
IEFjY2VsZXJvbWV0ZXJzCiMKIyBDT05GSUdfQURJUzE2MjAxIGlzIG5vdCBzZXQKIyBDT05G
SUdfQURJUzE2MjA5IGlzIG5vdCBzZXQKIyBDT05GSUdfQURYTDM0NV9JMkMgaXMgbm90IHNl
dAojIENPTkZJR19BRFhMMzQ1X1NQSSBpcyBub3Qgc2V0CiMgQ09ORklHX0FEWEwzNzJfU1BJ
IGlzIG5vdCBzZXQKIyBDT05GSUdfQURYTDM3Ml9JMkMgaXMgbm90IHNldAojIENPTkZJR19C
TUExODAgaXMgbm90IHNldAojIENPTkZJR19CTUEyMjAgaXMgbm90IHNldAojIENPTkZJR19C
TUE0MDAgaXMgbm90IHNldAojIENPTkZJR19CTUMxNTBfQUNDRUwgaXMgbm90IHNldAojIENP
TkZJR19EQTI4MCBpcyBub3Qgc2V0CiMgQ09ORklHX0RBMzExIGlzIG5vdCBzZXQKIyBDT05G
SUdfRE1BUkQwNiBpcyBub3Qgc2V0CiMgQ09ORklHX0RNQVJEMDkgaXMgbm90IHNldAojIENP
TkZJR19ETUFSRDEwIGlzIG5vdCBzZXQKIyBDT05GSUdfSUlPX1NUX0FDQ0VMXzNBWElTIGlz
IG5vdCBzZXQKIyBDT05GSUdfS1hTRDkgaXMgbm90IHNldAojIENPTkZJR19LWENKSzEwMTMg
aXMgbm90IHNldAojIENPTkZJR19NQzMyMzAgaXMgbm90IHNldAojIENPTkZJR19NTUE3NDU1
X0kyQyBpcyBub3Qgc2V0CiMgQ09ORklHX01NQTc0NTVfU1BJIGlzIG5vdCBzZXQKIyBDT05G
SUdfTU1BNzY2MCBpcyBub3Qgc2V0CiMgQ09ORklHX01NQTg0NTIgaXMgbm90IHNldAojIENP
TkZJR19NTUE5NTUxIGlzIG5vdCBzZXQKIyBDT05GSUdfTU1BOTU1MyBpcyBub3Qgc2V0CiMg
Q09ORklHX01YQzQwMDUgaXMgbm90IHNldAojIENPTkZJR19NWEM2MjU1IGlzIG5vdCBzZXQK
IyBDT05GSUdfU0NBMzAwMCBpcyBub3Qgc2V0CiMgQ09ORklHX1NUSzgzMTIgaXMgbm90IHNl
dAojIENPTkZJR19TVEs4QkE1MCBpcyBub3Qgc2V0CiMgZW5kIG9mIEFjY2VsZXJvbWV0ZXJz
CgojCiMgQW5hbG9nIHRvIGRpZ2l0YWwgY29udmVydGVycwojCiMgQ09ORklHX0FENzA5MVI1
IGlzIG5vdCBzZXQKIyBDT05GSUdfQUQ3MTI0IGlzIG5vdCBzZXQKIyBDT05GSUdfQUQ3MTky
IGlzIG5vdCBzZXQKIyBDT05GSUdfQUQ3MjY2IGlzIG5vdCBzZXQKIyBDT05GSUdfQUQ3Mjkx
IGlzIG5vdCBzZXQKIyBDT05GSUdfQUQ3MjkyIGlzIG5vdCBzZXQKIyBDT05GSUdfQUQ3Mjk4
IGlzIG5vdCBzZXQKIyBDT05GSUdfQUQ3NDc2IGlzIG5vdCBzZXQKIyBDT05GSUdfQUQ3NjA2
X0lGQUNFX1BBUkFMTEVMIGlzIG5vdCBzZXQKIyBDT05GSUdfQUQ3NjA2X0lGQUNFX1NQSSBp
cyBub3Qgc2V0CiMgQ09ORklHX0FENzc2NiBpcyBub3Qgc2V0CiMgQ09ORklHX0FENzc2OF8x
IGlzIG5vdCBzZXQKIyBDT05GSUdfQUQ3NzgwIGlzIG5vdCBzZXQKIyBDT05GSUdfQUQ3Nzkx
IGlzIG5vdCBzZXQKIyBDT05GSUdfQUQ3NzkzIGlzIG5vdCBzZXQKIyBDT05GSUdfQUQ3ODg3
IGlzIG5vdCBzZXQKIyBDT05GSUdfQUQ3OTIzIGlzIG5vdCBzZXQKIyBDT05GSUdfQUQ3OTQ5
IGlzIG5vdCBzZXQKIyBDT05GSUdfQUQ3OTlYIGlzIG5vdCBzZXQKIyBDT05GSUdfQURJX0FY
SV9BREMgaXMgbm90IHNldAojIENPTkZJR19FTlZFTE9QRV9ERVRFQ1RPUiBpcyBub3Qgc2V0
CiMgQ09ORklHX0hJODQzNSBpcyBub3Qgc2V0CiMgQ09ORklHX0hYNzExIGlzIG5vdCBzZXQK
IyBDT05GSUdfSU5BMlhYX0FEQyBpcyBub3Qgc2V0CiMgQ09ORklHX0xUQzI0NzEgaXMgbm90
IHNldAojIENPTkZJR19MVEMyNDg1IGlzIG5vdCBzZXQKIyBDT05GSUdfTFRDMjQ5NiBpcyBu
b3Qgc2V0CiMgQ09ORklHX0xUQzI0OTcgaXMgbm90IHNldAojIENPTkZJR19NQVgxMDI3IGlz
IG5vdCBzZXQKIyBDT05GSUdfTUFYMTExMDAgaXMgbm90IHNldAojIENPTkZJR19NQVgxMTE4
IGlzIG5vdCBzZXQKIyBDT05GSUdfTUFYMTI0MSBpcyBub3Qgc2V0CiMgQ09ORklHX01BWDEz
NjMgaXMgbm90IHNldAojIENPTkZJR19NQVg5NjExIGlzIG5vdCBzZXQKIyBDT05GSUdfTUNQ
MzIwWCBpcyBub3Qgc2V0CiMgQ09ORklHX01DUDM0MjIgaXMgbm90IHNldAojIENPTkZJR19N
Q1AzOTExIGlzIG5vdCBzZXQKIyBDT05GSUdfTkFVNzgwMiBpcyBub3Qgc2V0CiMgQ09ORklH
X1NEX0FEQ19NT0RVTEFUT1IgaXMgbm90IHNldAojIENPTkZJR19USV9BREMwODFDIGlzIG5v
dCBzZXQKIyBDT05GSUdfVElfQURDMDgzMiBpcyBub3Qgc2V0CiMgQ09ORklHX1RJX0FEQzA4
NFMwMjEgaXMgbm90IHNldAojIENPTkZJR19USV9BREMxMjEzOCBpcyBub3Qgc2V0CiMgQ09O
RklHX1RJX0FEQzEwOFMxMDIgaXMgbm90IHNldAojIENPTkZJR19USV9BREMxMjhTMDUyIGlz
IG5vdCBzZXQKIyBDT05GSUdfVElfQURDMTYxUzYyNiBpcyBub3Qgc2V0CiMgQ09ORklHX1RJ
X0FEUzEwMTUgaXMgbm90IHNldAojIENPTkZJR19USV9BRFM3OTUwIGlzIG5vdCBzZXQKIyBD
T05GSUdfVElfQURTODM0NCBpcyBub3Qgc2V0CiMgQ09ORklHX1RJX0FEUzg2ODggaXMgbm90
IHNldAojIENPTkZJR19USV9BRFMxMjRTMDggaXMgbm90IHNldAojIENPTkZJR19USV9UTEM0
NTQxIGlzIG5vdCBzZXQKIyBDT05GSUdfVkY2MTBfQURDIGlzIG5vdCBzZXQKIyBDT05GSUdf
WElMSU5YX1hBREMgaXMgbm90IHNldAojIGVuZCBvZiBBbmFsb2cgdG8gZGlnaXRhbCBjb252
ZXJ0ZXJzCgojCiMgQW5hbG9nIEZyb250IEVuZHMKIwojIENPTkZJR19JSU9fUkVTQ0FMRSBp
cyBub3Qgc2V0CiMgZW5kIG9mIEFuYWxvZyBGcm9udCBFbmRzCgojCiMgQW1wbGlmaWVycwoj
CiMgQ09ORklHX0FEODM2NiBpcyBub3Qgc2V0CiMgQ09ORklHX0hNQzQyNSBpcyBub3Qgc2V0
CiMgZW5kIG9mIEFtcGxpZmllcnMKCiMKIyBDaGVtaWNhbCBTZW5zb3JzCiMKIyBDT05GSUdf
QVRMQVNfUEhfU0VOU09SIGlzIG5vdCBzZXQKIyBDT05GSUdfQVRMQVNfRVpPX1NFTlNPUiBp
cyBub3Qgc2V0CiMgQ09ORklHX0JNRTY4MCBpcyBub3Qgc2V0CiMgQ09ORklHX0NDUzgxMSBp
cyBub3Qgc2V0CiMgQ09ORklHX0lBUUNPUkUgaXMgbm90IHNldAojIENPTkZJR19TQ0QzMF9D
T1JFIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU0lSSU9OX1NHUDMwIGlzIG5vdCBzZXQKIyBD
T05GSUdfU1BTMzAgaXMgbm90IHNldAojIENPTkZJR19WWjg5WCBpcyBub3Qgc2V0CiMgZW5k
IG9mIENoZW1pY2FsIFNlbnNvcnMKCiMgQ09ORklHX0lJT19DUk9TX0VDX1NFTlNPUlNfQ09S
RSBpcyBub3Qgc2V0CgojCiMgSGlkIFNlbnNvciBJSU8gQ29tbW9uCiMKIyBlbmQgb2YgSGlk
IFNlbnNvciBJSU8gQ29tbW9uCgojCiMgU1NQIFNlbnNvciBDb21tb24KIwojIENPTkZJR19J
SU9fU1NQX1NFTlNPUkhVQiBpcyBub3Qgc2V0CiMgZW5kIG9mIFNTUCBTZW5zb3IgQ29tbW9u
CgojCiMgRGlnaXRhbCB0byBhbmFsb2cgY29udmVydGVycwojCiMgQ09ORklHX0FENTA2NCBp
cyBub3Qgc2V0CiMgQ09ORklHX0FENTM2MCBpcyBub3Qgc2V0CiMgQ09ORklHX0FENTM4MCBp
cyBub3Qgc2V0CiMgQ09ORklHX0FENTQyMSBpcyBub3Qgc2V0CiMgQ09ORklHX0FENTQ0NiBp
cyBub3Qgc2V0CiMgQ09ORklHX0FENTQ0OSBpcyBub3Qgc2V0CiMgQ09ORklHX0FENTU5MlIg
aXMgbm90IHNldAojIENPTkZJR19BRDU1OTNSIGlzIG5vdCBzZXQKIyBDT05GSUdfQUQ1NTA0
IGlzIG5vdCBzZXQKIyBDT05GSUdfQUQ1NjI0Ul9TUEkgaXMgbm90IHNldAojIENPTkZJR19B
RDU2ODZfU1BJIGlzIG5vdCBzZXQKIyBDT05GSUdfQUQ1Njk2X0kyQyBpcyBub3Qgc2V0CiMg
Q09ORklHX0FENTc1NSBpcyBub3Qgc2V0CiMgQ09ORklHX0FENTc1OCBpcyBub3Qgc2V0CiMg
Q09ORklHX0FENTc2MSBpcyBub3Qgc2V0CiMgQ09ORklHX0FENTc2NCBpcyBub3Qgc2V0CiMg
Q09ORklHX0FENTc3MFIgaXMgbm90IHNldAojIENPTkZJR19BRDU3OTEgaXMgbm90IHNldAoj
IENPTkZJR19BRDczMDMgaXMgbm90IHNldAojIENPTkZJR19BRDg4MDEgaXMgbm90IHNldAoj
IENPTkZJR19EUE9UX0RBQyBpcyBub3Qgc2V0CiMgQ09ORklHX0RTNDQyNCBpcyBub3Qgc2V0
CiMgQ09ORklHX0xUQzE2NjAgaXMgbm90IHNldAojIENPTkZJR19MVEMyNjMyIGlzIG5vdCBz
ZXQKIyBDT05GSUdfTTYyMzMyIGlzIG5vdCBzZXQKIyBDT05GSUdfTUFYNTE3IGlzIG5vdCBz
ZXQKIyBDT05GSUdfTUFYNTgyMSBpcyBub3Qgc2V0CiMgQ09ORklHX01DUDQ3MjUgaXMgbm90
IHNldAojIENPTkZJR19NQ1A0OTIyIGlzIG5vdCBzZXQKIyBDT05GSUdfVElfREFDMDgyUzA4
NSBpcyBub3Qgc2V0CiMgQ09ORklHX1RJX0RBQzU1NzEgaXMgbm90IHNldAojIENPTkZJR19U
SV9EQUM3MzExIGlzIG5vdCBzZXQKIyBDT05GSUdfVElfREFDNzYxMiBpcyBub3Qgc2V0CiMg
Q09ORklHX1ZGNjEwX0RBQyBpcyBub3Qgc2V0CiMgZW5kIG9mIERpZ2l0YWwgdG8gYW5hbG9n
IGNvbnZlcnRlcnMKCiMKIyBJSU8gZHVtbXkgZHJpdmVyCiMKIyBlbmQgb2YgSUlPIGR1bW15
IGRyaXZlcgoKIwojIEZyZXF1ZW5jeSBTeW50aGVzaXplcnMgRERTL1BMTAojCgojCiMgQ2xv
Y2sgR2VuZXJhdG9yL0Rpc3RyaWJ1dGlvbgojCiMgQ09ORklHX0FEOTUyMyBpcyBub3Qgc2V0
CiMgZW5kIG9mIENsb2NrIEdlbmVyYXRvci9EaXN0cmlidXRpb24KCiMKIyBQaGFzZS1Mb2Nr
ZWQgTG9vcCAoUExMKSBmcmVxdWVuY3kgc3ludGhlc2l6ZXJzCiMKIyBDT05GSUdfQURGNDM1
MCBpcyBub3Qgc2V0CiMgQ09ORklHX0FERjQzNzEgaXMgbm90IHNldAojIGVuZCBvZiBQaGFz
ZS1Mb2NrZWQgTG9vcCAoUExMKSBmcmVxdWVuY3kgc3ludGhlc2l6ZXJzCiMgZW5kIG9mIEZy
ZXF1ZW5jeSBTeW50aGVzaXplcnMgRERTL1BMTAoKIwojIERpZ2l0YWwgZ3lyb3Njb3BlIHNl
bnNvcnMKIwojIENPTkZJR19BRElTMTYwODAgaXMgbm90IHNldAojIENPTkZJR19BRElTMTYx
MzAgaXMgbm90IHNldAojIENPTkZJR19BRElTMTYxMzYgaXMgbm90IHNldAojIENPTkZJR19B
RElTMTYyNjAgaXMgbm90IHNldAojIENPTkZJR19BRFhSUzI5MCBpcyBub3Qgc2V0CiMgQ09O
RklHX0FEWFJTNDUwIGlzIG5vdCBzZXQKIyBDT05GSUdfQk1HMTYwIGlzIG5vdCBzZXQKIyBD
T05GSUdfRlhBUzIxMDAyQyBpcyBub3Qgc2V0CiMgQ09ORklHX01QVTMwNTBfSTJDIGlzIG5v
dCBzZXQKIyBDT05GSUdfSUlPX1NUX0dZUk9fM0FYSVMgaXMgbm90IHNldAojIENPTkZJR19J
VEczMjAwIGlzIG5vdCBzZXQKIyBlbmQgb2YgRGlnaXRhbCBneXJvc2NvcGUgc2Vuc29ycwoK
IwojIEhlYWx0aCBTZW5zb3JzCiMKCiMKIyBIZWFydCBSYXRlIE1vbml0b3JzCiMKIyBDT05G
SUdfQUZFNDQwMyBpcyBub3Qgc2V0CiMgQ09ORklHX0FGRTQ0MDQgaXMgbm90IHNldAojIENP
TkZJR19NQVgzMDEwMCBpcyBub3Qgc2V0CiMgQ09ORklHX01BWDMwMTAyIGlzIG5vdCBzZXQK
IyBlbmQgb2YgSGVhcnQgUmF0ZSBNb25pdG9ycwojIGVuZCBvZiBIZWFsdGggU2Vuc29ycwoK
IwojIEh1bWlkaXR5IHNlbnNvcnMKIwojIENPTkZJR19BTTIzMTUgaXMgbm90IHNldAojIENP
TkZJR19ESFQxMSBpcyBub3Qgc2V0CiMgQ09ORklHX0hEQzEwMFggaXMgbm90IHNldAojIENP
TkZJR19IREMyMDEwIGlzIG5vdCBzZXQKIyBDT05GSUdfSFRTMjIxIGlzIG5vdCBzZXQKIyBD
T05GSUdfSFRVMjEgaXMgbm90IHNldAojIENPTkZJR19TSTcwMDUgaXMgbm90IHNldAojIENP
TkZJR19TSTcwMjAgaXMgbm90IHNldAojIGVuZCBvZiBIdW1pZGl0eSBzZW5zb3JzCgojCiMg
SW5lcnRpYWwgbWVhc3VyZW1lbnQgdW5pdHMKIwojIENPTkZJR19BRElTMTY0MDAgaXMgbm90
IHNldAojIENPTkZJR19BRElTMTY0NjAgaXMgbm90IHNldAojIENPTkZJR19BRElTMTY0NzUg
aXMgbm90IHNldAojIENPTkZJR19BRElTMTY0ODAgaXMgbm90IHNldAojIENPTkZJR19CTUkx
NjBfSTJDIGlzIG5vdCBzZXQKIyBDT05GSUdfQk1JMTYwX1NQSSBpcyBub3Qgc2V0CiMgQ09O
RklHX0ZYT1M4NzAwX0kyQyBpcyBub3Qgc2V0CiMgQ09ORklHX0ZYT1M4NzAwX1NQSSBpcyBu
b3Qgc2V0CiMgQ09ORklHX0tNWDYxIGlzIG5vdCBzZXQKIyBDT05GSUdfSU5WX0lDTTQyNjAw
X0kyQyBpcyBub3Qgc2V0CiMgQ09ORklHX0lOVl9JQ000MjYwMF9TUEkgaXMgbm90IHNldAoj
IENPTkZJR19JTlZfTVBVNjA1MF9JMkMgaXMgbm90IHNldAojIENPTkZJR19JTlZfTVBVNjA1
MF9TUEkgaXMgbm90IHNldAojIENPTkZJR19JSU9fU1RfTFNNNkRTWCBpcyBub3Qgc2V0CiMg
ZW5kIG9mIEluZXJ0aWFsIG1lYXN1cmVtZW50IHVuaXRzCgojCiMgTGlnaHQgc2Vuc29ycwoj
CkNPTkZJR19BQ1BJX0FMUz15CiMgQ09ORklHX0FESkRfUzMxMSBpcyBub3Qgc2V0CiMgQ09O
RklHX0FEVVgxMDIwIGlzIG5vdCBzZXQKIyBDT05GSUdfQUwzMDEwIGlzIG5vdCBzZXQKIyBD
T05GSUdfQUwzMzIwQSBpcyBub3Qgc2V0CiMgQ09ORklHX0FQRFM5MzAwIGlzIG5vdCBzZXQK
IyBDT05GSUdfQVBEUzk5NjAgaXMgbm90IHNldAojIENPTkZJR19BUzczMjExIGlzIG5vdCBz
ZXQKIyBDT05GSUdfQkgxNzUwIGlzIG5vdCBzZXQKIyBDT05GSUdfQkgxNzgwIGlzIG5vdCBz
ZXQKIyBDT05GSUdfQ00zMjE4MSBpcyBub3Qgc2V0CiMgQ09ORklHX0NNMzIzMiBpcyBub3Qg
c2V0CiMgQ09ORklHX0NNMzMyMyBpcyBub3Qgc2V0CiMgQ09ORklHX0NNMzYwNSBpcyBub3Qg
c2V0CiMgQ09ORklHX0NNMzY2NTEgaXMgbm90IHNldAojIENPTkZJR19HUDJBUDAwMiBpcyBu
b3Qgc2V0CiMgQ09ORklHX0dQMkFQMDIwQTAwRiBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNP
UlNfSVNMMjkwMTggaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX0lTTDI5MDI4IGlzIG5v
dCBzZXQKIyBDT05GSUdfSVNMMjkxMjUgaXMgbm90IHNldAojIENPTkZJR19KU0ExMjEyIGlz
IG5vdCBzZXQKIyBDT05GSUdfUlBSMDUyMSBpcyBub3Qgc2V0CiMgQ09ORklHX0xUUjUwMSBp
cyBub3Qgc2V0CiMgQ09ORklHX0xWMDEwNENTIGlzIG5vdCBzZXQKIyBDT05GSUdfTUFYNDQw
MDAgaXMgbm90IHNldAojIENPTkZJR19NQVg0NDAwOSBpcyBub3Qgc2V0CiMgQ09ORklHX05P
QTEzMDUgaXMgbm90IHNldAojIENPTkZJR19PUFQzMDAxIGlzIG5vdCBzZXQKIyBDT05GSUdf
UEExMjIwMzAwMSBpcyBub3Qgc2V0CiMgQ09ORklHX1NJMTEzMyBpcyBub3Qgc2V0CiMgQ09O
RklHX1NJMTE0NSBpcyBub3Qgc2V0CiMgQ09ORklHX1NUSzMzMTAgaXMgbm90IHNldAojIENP
TkZJR19TVF9VVklTMjUgaXMgbm90IHNldAojIENPTkZJR19UQ1MzNDE0IGlzIG5vdCBzZXQK
IyBDT05GSUdfVENTMzQ3MiBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfVFNMMjU2MyBp
cyBub3Qgc2V0CiMgQ09ORklHX1RTTDI1ODMgaXMgbm90IHNldAojIENPTkZJR19UU0wyNzcy
IGlzIG5vdCBzZXQKIyBDT05GSUdfVFNMNDUzMSBpcyBub3Qgc2V0CiMgQ09ORklHX1VTNTE4
MkQgaXMgbm90IHNldAojIENPTkZJR19WQ05MNDAwMCBpcyBub3Qgc2V0CiMgQ09ORklHX1ZD
Tkw0MDM1IGlzIG5vdCBzZXQKIyBDT05GSUdfVkVNTDYwMzAgaXMgbm90IHNldAojIENPTkZJ
R19WRU1MNjA3MCBpcyBub3Qgc2V0CiMgQ09ORklHX1ZMNjE4MCBpcyBub3Qgc2V0CiMgQ09O
RklHX1pPUFQyMjAxIGlzIG5vdCBzZXQKIyBlbmQgb2YgTGlnaHQgc2Vuc29ycwoKIwojIE1h
Z25ldG9tZXRlciBzZW5zb3JzCiMKIyBDT05GSUdfQUs4OTc0IGlzIG5vdCBzZXQKIyBDT05G
SUdfQUs4OTc1IGlzIG5vdCBzZXQKIyBDT05GSUdfQUswOTkxMSBpcyBub3Qgc2V0CiMgQ09O
RklHX0JNQzE1MF9NQUdOX0kyQyBpcyBub3Qgc2V0CiMgQ09ORklHX0JNQzE1MF9NQUdOX1NQ
SSBpcyBub3Qgc2V0CiMgQ09ORklHX01BRzMxMTAgaXMgbm90IHNldAojIENPTkZJR19NTUMz
NTI0MCBpcyBub3Qgc2V0CiMgQ09ORklHX0lJT19TVF9NQUdOXzNBWElTIGlzIG5vdCBzZXQK
IyBDT05GSUdfU0VOU09SU19ITUM1ODQzX0kyQyBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNP
UlNfSE1DNTg0M19TUEkgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX1JNMzEwMF9JMkMg
aXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX1JNMzEwMF9TUEkgaXMgbm90IHNldAojIGVu
ZCBvZiBNYWduZXRvbWV0ZXIgc2Vuc29ycwoKIwojIE11bHRpcGxleGVycwojCiMgQ09ORklH
X0lJT19NVVggaXMgbm90IHNldAojIGVuZCBvZiBNdWx0aXBsZXhlcnMKCiMKIyBJbmNsaW5v
bWV0ZXIgc2Vuc29ycwojCiMgZW5kIG9mIEluY2xpbm9tZXRlciBzZW5zb3JzCgojCiMgVHJp
Z2dlcnMgLSBzdGFuZGFsb25lCiMKQ09ORklHX0lJT19IUlRJTUVSX1RSSUdHRVI9eQojIENP
TkZJR19JSU9fSU5URVJSVVBUX1RSSUdHRVIgaXMgbm90IHNldAojIENPTkZJR19JSU9fVElH
SFRMT09QX1RSSUdHRVIgaXMgbm90IHNldApDT05GSUdfSUlPX1NZU0ZTX1RSSUdHRVI9eQoj
IGVuZCBvZiBUcmlnZ2VycyAtIHN0YW5kYWxvbmUKCiMKIyBMaW5lYXIgYW5kIGFuZ3VsYXIg
cG9zaXRpb24gc2Vuc29ycwojCiMgZW5kIG9mIExpbmVhciBhbmQgYW5ndWxhciBwb3NpdGlv
biBzZW5zb3JzCgojCiMgRGlnaXRhbCBwb3RlbnRpb21ldGVycwojCiMgQ09ORklHX0FENTI3
MiBpcyBub3Qgc2V0CiMgQ09ORklHX0RTMTgwMyBpcyBub3Qgc2V0CiMgQ09ORklHX01BWDU0
MzIgaXMgbm90IHNldAojIENPTkZJR19NQVg1NDgxIGlzIG5vdCBzZXQKIyBDT05GSUdfTUFY
NTQ4NyBpcyBub3Qgc2V0CiMgQ09ORklHX01DUDQwMTggaXMgbm90IHNldAojIENPTkZJR19N
Q1A0MTMxIGlzIG5vdCBzZXQKIyBDT05GSUdfTUNQNDUzMSBpcyBub3Qgc2V0CiMgQ09ORklH
X01DUDQxMDEwIGlzIG5vdCBzZXQKIyBDT05GSUdfVFBMMDEwMiBpcyBub3Qgc2V0CiMgZW5k
IG9mIERpZ2l0YWwgcG90ZW50aW9tZXRlcnMKCiMKIyBEaWdpdGFsIHBvdGVudGlvc3RhdHMK
IwojIENPTkZJR19MTVA5MTAwMCBpcyBub3Qgc2V0CiMgZW5kIG9mIERpZ2l0YWwgcG90ZW50
aW9zdGF0cwoKIwojIFByZXNzdXJlIHNlbnNvcnMKIwojIENPTkZJR19BQlAwNjBNRyBpcyBu
b3Qgc2V0CiMgQ09ORklHX0JNUDI4MCBpcyBub3Qgc2V0CiMgQ09ORklHX0RMSEw2MEQgaXMg
bm90IHNldAojIENPTkZJR19EUFMzMTAgaXMgbm90IHNldAojIENPTkZJR19IUDAzIGlzIG5v
dCBzZXQKIyBDT05GSUdfSUNQMTAxMDAgaXMgbm90IHNldAojIENPTkZJR19NUEwxMTVfSTJD
IGlzIG5vdCBzZXQKIyBDT05GSUdfTVBMMTE1X1NQSSBpcyBub3Qgc2V0CiMgQ09ORklHX01Q
TDMxMTUgaXMgbm90IHNldAojIENPTkZJR19NUzU2MTEgaXMgbm90IHNldAojIENPTkZJR19N
UzU2MzcgaXMgbm90IHNldAojIENPTkZJR19JSU9fU1RfUFJFU1MgaXMgbm90IHNldAojIENP
TkZJR19UNTQwMyBpcyBub3Qgc2V0CiMgQ09ORklHX0hQMjA2QyBpcyBub3Qgc2V0CiMgQ09O
RklHX1pQQTIzMjYgaXMgbm90IHNldAojIGVuZCBvZiBQcmVzc3VyZSBzZW5zb3JzCgojCiMg
TGlnaHRuaW5nIHNlbnNvcnMKIwojIENPTkZJR19BUzM5MzUgaXMgbm90IHNldAojIGVuZCBv
ZiBMaWdodG5pbmcgc2Vuc29ycwoKIwojIFByb3hpbWl0eSBhbmQgZGlzdGFuY2Ugc2Vuc29y
cwojCiMgQ09ORklHX0NST1NfRUNfTUtCUF9QUk9YSU1JVFkgaXMgbm90IHNldAojIENPTkZJ
R19JU0wyOTUwMSBpcyBub3Qgc2V0CiMgQ09ORklHX0xJREFSX0xJVEVfVjIgaXMgbm90IHNl
dAojIENPTkZJR19NQjEyMzIgaXMgbm90IHNldAojIENPTkZJR19QSU5HIGlzIG5vdCBzZXQK
IyBDT05GSUdfUkZENzc0MDIgaXMgbm90IHNldAojIENPTkZJR19TUkYwNCBpcyBub3Qgc2V0
CkNPTkZJR19TWF9DT01NT049eQpDT05GSUdfU1g5MzEwPXkKQ09ORklHX1NYOTMyND15CiMg
Q09ORklHX1NYOTUwMCBpcyBub3Qgc2V0CiMgQ09ORklHX1NSRjA4IGlzIG5vdCBzZXQKIyBD
T05GSUdfVkNOTDMwMjAgaXMgbm90IHNldAojIENPTkZJR19WTDUzTDBYX0kyQyBpcyBub3Qg
c2V0CiMgZW5kIG9mIFByb3hpbWl0eSBhbmQgZGlzdGFuY2Ugc2Vuc29ycwoKIwojIFJlc29s
dmVyIHRvIGRpZ2l0YWwgY29udmVydGVycwojCiMgQ09ORklHX0FEMlM5MCBpcyBub3Qgc2V0
CiMgQ09ORklHX0FEMlMxMjAwIGlzIG5vdCBzZXQKIyBlbmQgb2YgUmVzb2x2ZXIgdG8gZGln
aXRhbCBjb252ZXJ0ZXJzCgojCiMgVGVtcGVyYXR1cmUgc2Vuc29ycwojCiMgQ09ORklHX0xU
QzI5ODMgaXMgbm90IHNldAojIENPTkZJR19NQVhJTV9USEVSTU9DT1VQTEUgaXMgbm90IHNl
dAojIENPTkZJR19NTFg5MDYxNCBpcyBub3Qgc2V0CiMgQ09ORklHX01MWDkwNjMyIGlzIG5v
dCBzZXQKIyBDT05GSUdfVE1QMDA2IGlzIG5vdCBzZXQKIyBDT05GSUdfVE1QMDA3IGlzIG5v
dCBzZXQKIyBDT05GSUdfVFNZUzAxIGlzIG5vdCBzZXQKIyBDT05GSUdfVFNZUzAyRCBpcyBu
b3Qgc2V0CiMgQ09ORklHX01BWDMxODU2IGlzIG5vdCBzZXQKIyBlbmQgb2YgVGVtcGVyYXR1
cmUgc2Vuc29ycwoKIyBDT05GSUdfTlRCIGlzIG5vdCBzZXQKIyBDT05GSUdfVk1FX0JVUyBp
cyBub3Qgc2V0CiMgQ09ORklHX1BXTSBpcyBub3Qgc2V0CgojCiMgSVJRIGNoaXAgc3VwcG9y
dAojCkNPTkZJR19JUlFDSElQPXkKIyBDT05GSUdfQUxfRklDIGlzIG5vdCBzZXQKIyBlbmQg
b2YgSVJRIGNoaXAgc3VwcG9ydAoKIyBDT05GSUdfSVBBQ0tfQlVTIGlzIG5vdCBzZXQKIyBD
T05GSUdfUkVTRVRfQ09OVFJPTExFUiBpcyBub3Qgc2V0CgojCiMgUEhZIFN1YnN5c3RlbQoj
CiMgQ09ORklHX0dFTkVSSUNfUEhZIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX0xHTV9QSFkg
aXMgbm90IHNldAojIENPTkZJR19CQ01fS09OQV9VU0IyX1BIWSBpcyBub3Qgc2V0CiMgQ09O
RklHX1BIWV9DQURFTkNFX1RPUlJFTlQgaXMgbm90IHNldAojIENPTkZJR19QSFlfQ0FERU5D
RV9EUEhZIGlzIG5vdCBzZXQKIyBDT05GSUdfUEhZX0NBREVOQ0VfU0FMVk8gaXMgbm90IHNl
dAojIENPTkZJR19QSFlfRlNMX0lNWDhNUV9VU0IgaXMgbm90IHNldAojIENPTkZJR19QSFlf
TUlYRUxfTUlQSV9EUEhZIGlzIG5vdCBzZXQKIyBDT05GSUdfUEhZX1BYQV8yOE5NX0hTSUMg
aXMgbm90IHNldAojIENPTkZJR19QSFlfUFhBXzI4Tk1fVVNCMiBpcyBub3Qgc2V0CiMgQ09O
RklHX1BIWV9DUENBUF9VU0IgaXMgbm90IHNldAojIENPTkZJR19QSFlfTUFQUEhPTkVfTURN
NjYwMCBpcyBub3Qgc2V0CiMgQ09ORklHX1BIWV9JTlRFTF9MR01fQ09NQk8gaXMgbm90IHNl
dAojIENPTkZJR19QSFlfSU5URUxfTEdNX0VNTUMgaXMgbm90IHNldAojIGVuZCBvZiBQSFkg
U3Vic3lzdGVtCgpDT05GSUdfUE9XRVJDQVA9eQpDT05GSUdfSU5URUxfUkFQTF9DT1JFPXkK
Q09ORklHX0lOVEVMX1JBUEw9eQojIENPTkZJR19JRExFX0lOSkVDVCBpcyBub3Qgc2V0CiMg
Q09ORklHX01DQiBpcyBub3Qgc2V0CgojCiMgUGVyZm9ybWFuY2UgbW9uaXRvciBzdXBwb3J0
CiMKIyBlbmQgb2YgUGVyZm9ybWFuY2UgbW9uaXRvciBzdXBwb3J0CgpDT05GSUdfUkFTPXkK
IyBDT05GSUdfVVNCNCBpcyBub3Qgc2V0CgojCiMgQW5kcm9pZAojCkNPTkZJR19BTkRST0lE
PXkKQ09ORklHX0FORFJPSURfQklOREVSX0lQQz15CkNPTkZJR19BTkRST0lEX0JJTkRFUkZT
PXkKQ09ORklHX0FORFJPSURfQklOREVSX0RFVklDRVM9ImJpbmRlcjAsYmluZGVyMSIKIyBD
T05GSUdfQU5EUk9JRF9CSU5ERVJfSVBDX1NFTEZURVNUIGlzIG5vdCBzZXQKIyBlbmQgb2Yg
QW5kcm9pZAoKIyBDT05GSUdfTElCTlZESU1NIGlzIG5vdCBzZXQKQ09ORklHX0RBWD15CkNP
TkZJR19OVk1FTT15CkNPTkZJR19OVk1FTV9TWVNGUz15CgojCiMgSFcgdHJhY2luZyBzdXBw
b3J0CiMKIyBDT05GSUdfU1RNIGlzIG5vdCBzZXQKIyBDT05GSUdfSU5URUxfVEggaXMgbm90
IHNldAojIGVuZCBvZiBIVyB0cmFjaW5nIHN1cHBvcnQKCiMgQ09ORklHX0ZQR0EgaXMgbm90
IHNldAojIENPTkZJR19GU0kgaXMgbm90IHNldAojIENPTkZJR19URUUgaXMgbm90IHNldAoj
IENPTkZJR19VTklTWVNfVklTT1JCVVMgaXMgbm90IHNldAojIENPTkZJR19TSU9YIGlzIG5v
dCBzZXQKIyBDT05GSUdfU0xJTUJVUyBpcyBub3Qgc2V0CiMgQ09ORklHX0lOVEVSQ09OTkVD
VCBpcyBub3Qgc2V0CiMgQ09ORklHX0NPVU5URVIgaXMgbm90IHNldAojIENPTkZJR19NT1NU
IGlzIG5vdCBzZXQKQ09ORklHX1BLR0xJU1Q9eQpDT05GSUdfUEtHTElTVF9VU0VfQ09ORklH
RlM9eQojIENPTkZJR19QS0dMSVNUX05PX0NPTkZJRyBpcyBub3Qgc2V0CiMgZW5kIG9mIERl
dmljZSBEcml2ZXJzCgojCiMgRmlsZSBzeXN0ZW1zCiMKQ09ORklHX0RDQUNIRV9XT1JEX0FD
Q0VTUz15CiMgQ09ORklHX1ZBTElEQVRFX0ZTX1BBUlNFUiBpcyBub3Qgc2V0CkNPTkZJR19G
U19JT01BUD15CiMgQ09ORklHX0VYVDJfRlMgaXMgbm90IHNldAojIENPTkZJR19FWFQzX0ZT
IGlzIG5vdCBzZXQKQ09ORklHX0VYVDRfRlM9eQpDT05GSUdfRVhUNF9VU0VfRk9SX0VYVDI9
eQpDT05GSUdfRVhUNF9GU19QT1NJWF9BQ0w9eQpDT05GSUdfRVhUNF9GU19TRUNVUklUWT15
CiMgQ09ORklHX0VYVDRfREVCVUcgaXMgbm90IHNldApDT05GSUdfSkJEMj15CiMgQ09ORklH
X0pCRDJfREVCVUcgaXMgbm90IHNldApDT05GSUdfRlNfTUJDQUNIRT15CiMgQ09ORklHX1JF
SVNFUkZTX0ZTIGlzIG5vdCBzZXQKIyBDT05GSUdfSkZTX0ZTIGlzIG5vdCBzZXQKIyBDT05G
SUdfWEZTX0ZTIGlzIG5vdCBzZXQKIyBDT05GSUdfR0ZTMl9GUyBpcyBub3Qgc2V0CiMgQ09O
RklHX09DRlMyX0ZTIGlzIG5vdCBzZXQKIyBDT05GSUdfQlRSRlNfRlMgaXMgbm90IHNldAoj
IENPTkZJR19OSUxGUzJfRlMgaXMgbm90IHNldAojIENPTkZJR19GMkZTX0ZTIGlzIG5vdCBz
ZXQKIyBDT05GSUdfRlNfREFYIGlzIG5vdCBzZXQKQ09ORklHX0ZTX1BPU0lYX0FDTD15CkNP
TkZJR19FWFBPUlRGUz15CiMgQ09ORklHX0VYUE9SVEZTX0JMT0NLX09QUyBpcyBub3Qgc2V0
CkNPTkZJR19GSUxFX0xPQ0tJTkc9eQpDT05GSUdfTUFOREFUT1JZX0ZJTEVfTE9DS0lORz15
CkNPTkZJR19GU19FTkNSWVBUSU9OPXkKQ09ORklHX0ZTX0VOQ1JZUFRJT05fQUxHUz15CkNP
TkZJR19GU19WRVJJVFk9eQojIENPTkZJR19GU19WRVJJVFlfREVCVUcgaXMgbm90IHNldApD
T05GSUdfRlNfVkVSSVRZX0JVSUxUSU5fU0lHTkFUVVJFUz15CkNPTkZJR19GU05PVElGWT15
CiMgQ09ORklHX0ROT1RJRlkgaXMgbm90IHNldApDT05GSUdfSU5PVElGWV9VU0VSPXkKQ09O
RklHX0ZBTk9USUZZPXkKQ09ORklHX0ZBTk9USUZZX0FDQ0VTU19QRVJNSVNTSU9OUz15CkNP
TkZJR19RVU9UQT15CiMgQ09ORklHX1FVT1RBX05FVExJTktfSU5URVJGQUNFIGlzIG5vdCBz
ZXQKQ09ORklHX1BSSU5UX1FVT1RBX1dBUk5JTkc9eQojIENPTkZJR19RVU9UQV9ERUJVRyBp
cyBub3Qgc2V0CkNPTkZJR19RVU9UQV9UUkVFPXkKIyBDT05GSUdfUUZNVF9WMSBpcyBub3Qg
c2V0CkNPTkZJR19RRk1UX1YyPXkKQ09ORklHX1FVT1RBQ1RMPXkKIyBDT05GSUdfQVVUT0ZT
NF9GUyBpcyBub3Qgc2V0CiMgQ09ORklHX0FVVE9GU19GUyBpcyBub3Qgc2V0CkNPTkZJR19G
VVNFX0ZTPXkKIyBDT05GSUdfQ1VTRSBpcyBub3Qgc2V0CkNPTkZJR19WSVJUSU9fRlM9eQoj
IENPTkZJR19PVkVSTEFZX0ZTIGlzIG5vdCBzZXQKQ09ORklHX0lOQ1JFTUVOVEFMX0ZTPXkK
CiMKIyBDYWNoZXMKIwojIENPTkZJR19GU0NBQ0hFIGlzIG5vdCBzZXQKIyBlbmQgb2YgQ2Fj
aGVzCgojCiMgQ0QtUk9NL0RWRCBGaWxlc3lzdGVtcwojCkNPTkZJR19JU085NjYwX0ZTPXkK
Q09ORklHX0pPTElFVD15CkNPTkZJR19aSVNPRlM9eQpDT05GSUdfVURGX0ZTPXkKIyBlbmQg
b2YgQ0QtUk9NL0RWRCBGaWxlc3lzdGVtcwoKIwojIERPUy9GQVQvRVhGQVQvTlQgRmlsZXN5
c3RlbXMKIwpDT05GSUdfRkFUX0ZTPXkKIyBDT05GSUdfTVNET1NfRlMgaXMgbm90IHNldApD
T05GSUdfVkZBVF9GUz15CkNPTkZJR19GQVRfREVGQVVMVF9DT0RFUEFHRT00MzcKQ09ORklH
X0ZBVF9ERUZBVUxUX0lPQ0hBUlNFVD0iaXNvODg1OS0xIgojIENPTkZJR19GQVRfREVGQVVM
VF9VVEY4IGlzIG5vdCBzZXQKIyBDT05GSUdfRVhGQVRfRlMgaXMgbm90IHNldAojIENPTkZJ
R19OVEZTX0ZTIGlzIG5vdCBzZXQKIyBlbmQgb2YgRE9TL0ZBVC9FWEZBVC9OVCBGaWxlc3lz
dGVtcwoKIwojIFBzZXVkbyBmaWxlc3lzdGVtcwojCkNPTkZJR19QUk9DX0ZTPXkKQ09ORklH
X1BST0NfS0NPUkU9eQpDT05GSUdfUFJPQ19TWVNDVEw9eQpDT05GSUdfUFJPQ19QQUdFX01P
TklUT1I9eQpDT05GSUdfUFJPQ19DSElMRFJFTj15CkNPTkZJR19QUk9DX1BJRF9BUkNIX1NU
QVRVUz15CkNPTkZJR19LRVJORlM9eQpDT05GSUdfU1lTRlM9eQpDT05GSUdfVE1QRlM9eQpD
T05GSUdfVE1QRlNfUE9TSVhfQUNMPXkKQ09ORklHX1RNUEZTX1hBVFRSPXkKIyBDT05GSUdf
VE1QRlNfSU5PREU2NCBpcyBub3Qgc2V0CiMgQ09ORklHX0hVR0VUTEJGUyBpcyBub3Qgc2V0
CkNPTkZJR19NRU1GRF9DUkVBVEU9eQpDT05GSUdfQVJDSF9IQVNfR0lHQU5USUNfUEFHRT15
CkNPTkZJR19DT05GSUdGU19GUz15CiMgZW5kIG9mIFBzZXVkbyBmaWxlc3lzdGVtcwoKQ09O
RklHX01JU0NfRklMRVNZU1RFTVM9eQojIENPTkZJR19PUkFOR0VGU19GUyBpcyBub3Qgc2V0
CiMgQ09ORklHX0FERlNfRlMgaXMgbm90IHNldAojIENPTkZJR19BRkZTX0ZTIGlzIG5vdCBz
ZXQKQ09ORklHX0VDUllQVF9GUz15CiMgQ09ORklHX0VDUllQVF9GU19NRVNTQUdJTkcgaXMg
bm90IHNldApDT05GSUdfRVNEX0ZTPXkKIyBDT05GSUdfSEZTX0ZTIGlzIG5vdCBzZXQKQ09O
RklHX0hGU1BMVVNfRlM9eQojIENPTkZJR19CRUZTX0ZTIGlzIG5vdCBzZXQKIyBDT05GSUdf
QkZTX0ZTIGlzIG5vdCBzZXQKIyBDT05GSUdfRUZTX0ZTIGlzIG5vdCBzZXQKIyBDT05GSUdf
Q1JBTUZTIGlzIG5vdCBzZXQKQ09ORklHX1NRVUFTSEZTPXkKIyBDT05GSUdfU1FVQVNIRlNf
RklMRV9DQUNIRSBpcyBub3Qgc2V0CkNPTkZJR19TUVVBU0hGU19GSUxFX0RJUkVDVD15CiMg
Q09ORklHX1NRVUFTSEZTX0RFQ09NUF9TSU5HTEUgaXMgbm90IHNldAojIENPTkZJR19TUVVB
U0hGU19ERUNPTVBfTVVMVEkgaXMgbm90IHNldApDT05GSUdfU1FVQVNIRlNfREVDT01QX01V
TFRJX1BFUkNQVT15CkNPTkZJR19TUVVBU0hGU19YQVRUUj15CkNPTkZJR19TUVVBU0hGU19a
TElCPXkKQ09ORklHX1NRVUFTSEZTX0xaND15CkNPTkZJR19TUVVBU0hGU19MWk89eQojIENP
TkZJR19TUVVBU0hGU19YWiBpcyBub3Qgc2V0CkNPTkZJR19TUVVBU0hGU19aU1REPXkKQ09O
RklHX1NRVUFTSEZTXzRLX0RFVkJMS19TSVpFPXkKIyBDT05GSUdfU1FVQVNIRlNfRU1CRURE
RUQgaXMgbm90IHNldApDT05GSUdfU1FVQVNIRlNfRlJBR01FTlRfQ0FDSEVfU0laRT0zCiMg
Q09ORklHX1ZYRlNfRlMgaXMgbm90IHNldAojIENPTkZJR19NSU5JWF9GUyBpcyBub3Qgc2V0
CiMgQ09ORklHX09NRlNfRlMgaXMgbm90IHNldAojIENPTkZJR19IUEZTX0ZTIGlzIG5vdCBz
ZXQKIyBDT05GSUdfUU5YNEZTX0ZTIGlzIG5vdCBzZXQKIyBDT05GSUdfUU5YNkZTX0ZTIGlz
IG5vdCBzZXQKIyBDT05GSUdfUk9NRlNfRlMgaXMgbm90IHNldApDT05GSUdfUFNUT1JFPXkK
Q09ORklHX1BTVE9SRV9ERUZMQVRFX0NPTVBSRVNTPXkKIyBDT05GSUdfUFNUT1JFX0xaT19D
T01QUkVTUyBpcyBub3Qgc2V0CiMgQ09ORklHX1BTVE9SRV9MWjRfQ09NUFJFU1MgaXMgbm90
IHNldAojIENPTkZJR19QU1RPUkVfTFo0SENfQ09NUFJFU1MgaXMgbm90IHNldAojIENPTkZJ
R19QU1RPUkVfODQyX0NPTVBSRVNTIGlzIG5vdCBzZXQKIyBDT05GSUdfUFNUT1JFX1pTVERf
Q09NUFJFU1MgaXMgbm90IHNldApDT05GSUdfUFNUT1JFX0NPTVBSRVNTPXkKQ09ORklHX1BT
VE9SRV9ERUZMQVRFX0NPTVBSRVNTX0RFRkFVTFQ9eQpDT05GSUdfUFNUT1JFX0NPTVBSRVNT
X0RFRkFVTFQ9ImRlZmxhdGUiCkNPTkZJR19QU1RPUkVfQ09OU09MRT15CkNPTkZJR19QU1RP
UkVfUE1TRz15CkNPTkZJR19QU1RPUkVfUkFNPXkKIyBDT05GSUdfU1lTVl9GUyBpcyBub3Qg
c2V0CiMgQ09ORklHX1VGU19GUyBpcyBub3Qgc2V0CiMgQ09ORklHX0VST0ZTX0ZTIGlzIG5v
dCBzZXQKQ09ORklHX05FVFdPUktfRklMRVNZU1RFTVM9eQpDT05GSUdfTkZTX0ZTPXkKQ09O
RklHX05GU19WMj15CkNPTkZJR19ORlNfVjM9eQojIENPTkZJR19ORlNfVjNfQUNMIGlzIG5v
dCBzZXQKQ09ORklHX05GU19WND15CiMgQ09ORklHX05GU19TV0FQIGlzIG5vdCBzZXQKIyBD
T05GSUdfTkZTX1Y0XzEgaXMgbm90IHNldAojIENPTkZJR19ST09UX05GUyBpcyBub3Qgc2V0
CiMgQ09ORklHX05GU19VU0VfTEVHQUNZX0ROUyBpcyBub3Qgc2V0CkNPTkZJR19ORlNfVVNF
X0tFUk5FTF9ETlM9eQpDT05GSUdfTkZTX0RJU0FCTEVfVURQX1NVUFBPUlQ9eQojIENPTkZJ
R19ORlNEIGlzIG5vdCBzZXQKQ09ORklHX0dSQUNFX1BFUklPRD15CkNPTkZJR19MT0NLRD15
CkNPTkZJR19MT0NLRF9WND15CkNPTkZJR19ORlNfQ09NTU9OPXkKQ09ORklHX1NVTlJQQz15
CkNPTkZJR19TVU5SUENfR1NTPXkKIyBDT05GSUdfUlBDU0VDX0dTU19LUkI1IGlzIG5vdCBz
ZXQKIyBDT05GSUdfU1VOUlBDX0RFQlVHIGlzIG5vdCBzZXQKIyBDT05GSUdfQ0VQSF9GUyBp
cyBub3Qgc2V0CiMgQ09ORklHX0NJRlMgaXMgbm90IHNldAojIENPTkZJR19DT0RBX0ZTIGlz
IG5vdCBzZXQKIyBDT05GSUdfQUZTX0ZTIGlzIG5vdCBzZXQKQ09ORklHXzlQX0ZTPXkKIyBD
T05GSUdfOVBfRlNfUE9TSVhfQUNMIGlzIG5vdCBzZXQKIyBDT05GSUdfOVBfRlNfU0VDVVJJ
VFkgaXMgbm90IHNldApDT05GSUdfTkxTPXkKQ09ORklHX05MU19ERUZBVUxUPSJ1dGY4IgpD
T05GSUdfTkxTX0NPREVQQUdFXzQzNz15CiMgQ09ORklHX05MU19DT0RFUEFHRV83MzcgaXMg
bm90IHNldAojIENPTkZJR19OTFNfQ09ERVBBR0VfNzc1IGlzIG5vdCBzZXQKIyBDT05GSUdf
TkxTX0NPREVQQUdFXzg1MCBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19DT0RFUEFHRV84NTIg
aXMgbm90IHNldAojIENPTkZJR19OTFNfQ09ERVBBR0VfODU1IGlzIG5vdCBzZXQKIyBDT05G
SUdfTkxTX0NPREVQQUdFXzg1NyBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19DT0RFUEFHRV84
NjAgaXMgbm90IHNldAojIENPTkZJR19OTFNfQ09ERVBBR0VfODYxIGlzIG5vdCBzZXQKIyBD
T05GSUdfTkxTX0NPREVQQUdFXzg2MiBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19DT0RFUEFH
RV84NjMgaXMgbm90IHNldAojIENPTkZJR19OTFNfQ09ERVBBR0VfODY0IGlzIG5vdCBzZXQK
IyBDT05GSUdfTkxTX0NPREVQQUdFXzg2NSBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19DT0RF
UEFHRV84NjYgaXMgbm90IHNldAojIENPTkZJR19OTFNfQ09ERVBBR0VfODY5IGlzIG5vdCBz
ZXQKIyBDT05GSUdfTkxTX0NPREVQQUdFXzkzNiBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19D
T0RFUEFHRV85NTAgaXMgbm90IHNldAojIENPTkZJR19OTFNfQ09ERVBBR0VfOTMyIGlzIG5v
dCBzZXQKIyBDT05GSUdfTkxTX0NPREVQQUdFXzk0OSBpcyBub3Qgc2V0CiMgQ09ORklHX05M
U19DT0RFUEFHRV84NzQgaXMgbm90IHNldAojIENPTkZJR19OTFNfSVNPODg1OV84IGlzIG5v
dCBzZXQKIyBDT05GSUdfTkxTX0NPREVQQUdFXzEyNTAgaXMgbm90IHNldAojIENPTkZJR19O
TFNfQ09ERVBBR0VfMTI1MSBpcyBub3Qgc2V0CkNPTkZJR19OTFNfQVNDSUk9eQpDT05GSUdf
TkxTX0lTTzg4NTlfMT15CiMgQ09ORklHX05MU19JU084ODU5XzIgaXMgbm90IHNldAojIENP
TkZJR19OTFNfSVNPODg1OV8zIGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX0lTTzg4NTlfNCBp
cyBub3Qgc2V0CiMgQ09ORklHX05MU19JU084ODU5XzUgaXMgbm90IHNldAojIENPTkZJR19O
TFNfSVNPODg1OV82IGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX0lTTzg4NTlfNyBpcyBub3Qg
c2V0CiMgQ09ORklHX05MU19JU084ODU5XzkgaXMgbm90IHNldAojIENPTkZJR19OTFNfSVNP
ODg1OV8xMyBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19JU084ODU5XzE0IGlzIG5vdCBzZXQK
IyBDT05GSUdfTkxTX0lTTzg4NTlfMTUgaXMgbm90IHNldAojIENPTkZJR19OTFNfS09JOF9S
IGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX0tPSThfVSBpcyBub3Qgc2V0CiMgQ09ORklHX05M
U19NQUNfUk9NQU4gaXMgbm90IHNldAojIENPTkZJR19OTFNfTUFDX0NFTFRJQyBpcyBub3Qg
c2V0CiMgQ09ORklHX05MU19NQUNfQ0VOVEVVUk8gaXMgbm90IHNldAojIENPTkZJR19OTFNf
TUFDX0NST0FUSUFOIGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX01BQ19DWVJJTExJQyBpcyBu
b3Qgc2V0CiMgQ09ORklHX05MU19NQUNfR0FFTElDIGlzIG5vdCBzZXQKIyBDT05GSUdfTkxT
X01BQ19HUkVFSyBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19NQUNfSUNFTEFORCBpcyBub3Qg
c2V0CiMgQ09ORklHX05MU19NQUNfSU5VSVQgaXMgbm90IHNldAojIENPTkZJR19OTFNfTUFD
X1JPTUFOSUFOIGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX01BQ19UVVJLSVNIIGlzIG5vdCBz
ZXQKQ09ORklHX05MU19VVEY4PXkKIyBDT05GSUdfRExNIGlzIG5vdCBzZXQKIyBDT05GSUdf
VU5JQ09ERSBpcyBub3Qgc2V0CiMgZW5kIG9mIEZpbGUgc3lzdGVtcwoKIwojIFNlY3VyaXR5
IG9wdGlvbnMKIwpDT05GSUdfS0VZUz15CiMgQ09ORklHX0tFWVNfUkVRVUVTVF9DQUNIRSBp
cyBub3Qgc2V0CiMgQ09ORklHX1BFUlNJU1RFTlRfS0VZUklOR1MgaXMgbm90IHNldAojIENP
TkZJR19CSUdfS0VZUyBpcyBub3Qgc2V0CiMgQ09ORklHX1RSVVNURURfS0VZUyBpcyBub3Qg
c2V0CkNPTkZJR19FTkNSWVBURURfS0VZUz15CiMgQ09ORklHX0tFWV9ESF9PUEVSQVRJT05T
IGlzIG5vdCBzZXQKQ09ORklHX1NFQ1VSSVRZX0RNRVNHX1JFU1RSSUNUPXkKQ09ORklHX1NF
Q1VSSVRZPXkKQ09ORklHX1NFQ1VSSVRZRlM9eQpDT05GSUdfU0VDVVJJVFlfTkVUV09SSz15
CiMgQ09ORklHX1NFQ1VSSVRZX05FVFdPUktfWEZSTSBpcyBub3Qgc2V0CkNPTkZJR19TRUNV
UklUWV9QQVRIPXkKQ09ORklHX0xTTV9NTUFQX01JTl9BRERSPTMyNzY4CkNPTkZJR19IQVZF
X0hBUkRFTkVEX1VTRVJDT1BZX0FMTE9DQVRPUj15CkNPTkZJR19IQVJERU5FRF9VU0VSQ09Q
WT15CkNPTkZJR19IQVJERU5FRF9VU0VSQ09QWV9GQUxMQkFDSz15CiMgQ09ORklHX0hBUkRF
TkVEX1VTRVJDT1BZX1BBR0VTUEFOIGlzIG5vdCBzZXQKQ09ORklHX0ZPUlRJRllfU09VUkNF
PXkKQ09ORklHX1NUQVRJQ19VU0VSTU9ERUhFTFBFUj15CkNPTkZJR19TVEFUSUNfVVNFUk1P
REVIRUxQRVJfUEFUSD0iL3NiaW4vdXNlcm1vZGUtaGVscGVyIgpDT05GSUdfU0VDVVJJVFlf
U0VMSU5VWD15CkNPTkZJR19TRUNVUklUWV9TRUxJTlVYX0JPT1RQQVJBTT15CiMgQ09ORklH
X1NFQ1VSSVRZX1NFTElOVVhfRElTQUJMRSBpcyBub3Qgc2V0CkNPTkZJR19TRUNVUklUWV9T
RUxJTlVYX0RFVkVMT1A9eQojIENPTkZJR19TRUNVUklUWV9TRUxJTlVYX1BFUk1JU1NJVkVf
RE9OVEFVRElUIGlzIG5vdCBzZXQKQ09ORklHX1NFQ1VSSVRZX1NFTElOVVhfQVZDX1NUQVRT
PXkKQ09ORklHX1NFQ1VSSVRZX1NFTElOVVhfQ0hFQ0tSRVFQUk9UX1ZBTFVFPTAKQ09ORklH
X1NFQ1VSSVRZX1NFTElOVVhfU0lEVEFCX0hBU0hfQklUUz05CkNPTkZJR19TRUNVUklUWV9T
RUxJTlVYX1NJRDJTVFJfQ0FDSEVfU0laRT0yNTYKIyBDT05GSUdfU0VDVVJJVFlfU01BQ0sg
aXMgbm90IHNldAojIENPTkZJR19TRUNVUklUWV9UT01PWU8gaXMgbm90IHNldAojIENPTkZJ
R19TRUNVUklUWV9BUFBBUk1PUiBpcyBub3Qgc2V0CkNPTkZJR19TRUNVUklUWV9MT0FEUElO
PXkKQ09ORklHX1NFQ1VSSVRZX0xPQURQSU5fRU5GT1JDRT15CiMgQ09ORklHX1NFQ1VSSVRZ
X0xPQURQSU5fVkVSSVRZIGlzIG5vdCBzZXQKQ09ORklHX1NFQ1VSSVRZX1lBTUE9eQpDT05G
SUdfU0VDVVJJVFlfU0FGRVNFVElEPXkKIyBDT05GSUdfU0VDVVJJVFlfTE9DS0RPV05fTFNN
IGlzIG5vdCBzZXQKQ09ORklHX1NFQ1VSSVRZX0NIUk9NSVVNT1M9eQpDT05GSUdfU0VDVVJJ
VFlfQ0hST01JVU1PU19OT19TWU1MSU5LX01PVU5UPXkKIyBDT05GSUdfU0VDVVJJVFlfQ0hS
T01JVU1PU19OT19VTlBSSVZJTEVHRURfVU5TQUZFX01PVU5UUyBpcyBub3Qgc2V0CkNPTkZJ
R19BTFRfU1lTQ0FMTF9DSFJPTUlVTU9TPXkKQ09ORklHX1NFQ1VSSVRZX0NIUk9NSVVNT1Nf
UkVBRE9OTFlfUFJPQ19TRUxGX01FTT15CiMgQ09ORklHX1NFQ1VSSVRZX0xBTkRMT0NLIGlz
IG5vdCBzZXQKQ09ORklHX0lOVEVHUklUWT15CiMgQ09ORklHX0lOVEVHUklUWV9TSUdOQVRV
UkUgaXMgbm90IHNldApDT05GSUdfSU5URUdSSVRZX0FVRElUPXkKIyBDT05GSUdfSU1BIGlz
IG5vdCBzZXQKIyBDT05GSUdfRVZNIGlzIG5vdCBzZXQKQ09ORklHX0RFRkFVTFRfU0VDVVJJ
VFlfQ0hST01JVU1PUz15CiMgQ09ORklHX0RFRkFVTFRfU0VDVVJJVFlfU0VMSU5VWCBpcyBu
b3Qgc2V0CiMgQ09ORklHX0RFRkFVTFRfU0VDVVJJVFlfREFDIGlzIG5vdCBzZXQKQ09ORklH
X0xTTT0ibG9ja2Rvd24seWFtYSxsb2FkcGluLHNhZmVzZXRpZCxpbnRlZ3JpdHksY2hyb21p
dW1vcyxzZWxpbnV4LGJwZiIKCiMKIyBLZXJuZWwgaGFyZGVuaW5nIG9wdGlvbnMKIwoKIwoj
IE1lbW9yeSBpbml0aWFsaXphdGlvbgojCkNPTkZJR19JTklUX1NUQUNLX05PTkU9eQpDT05G
SUdfSU5JVF9PTl9BTExPQ19ERUZBVUxUX09OPXkKIyBDT05GSUdfSU5JVF9PTl9GUkVFX0RF
RkFVTFRfT04gaXMgbm90IHNldAojIGVuZCBvZiBNZW1vcnkgaW5pdGlhbGl6YXRpb24KIyBl
bmQgb2YgS2VybmVsIGhhcmRlbmluZyBvcHRpb25zCgpDT05GSUdfQVJDSF9IQVNfQUxUX1NZ
U0NBTEw9eQpDT05GSUdfQUxUX1NZU0NBTEw9eQojIGVuZCBvZiBTZWN1cml0eSBvcHRpb25z
CgpDT05GSUdfWE9SX0JMT0NLUz15CkNPTkZJR19BU1lOQ19DT1JFPXkKQ09ORklHX0FTWU5D
X1hPUj15CkNPTkZJR19DUllQVE89eQoKIwojIENyeXB0byBjb3JlIG9yIGhlbHBlcgojCkNP
TkZJR19DUllQVE9fQUxHQVBJPXkKQ09ORklHX0NSWVBUT19BTEdBUEkyPXkKQ09ORklHX0NS
WVBUT19BRUFEPXkKQ09ORklHX0NSWVBUT19BRUFEMj15CkNPTkZJR19DUllQVE9fU0tDSVBI
RVI9eQpDT05GSUdfQ1JZUFRPX1NLQ0lQSEVSMj15CkNPTkZJR19DUllQVE9fSEFTSD15CkNP
TkZJR19DUllQVE9fSEFTSDI9eQpDT05GSUdfQ1JZUFRPX1JORz15CkNPTkZJR19DUllQVE9f
Uk5HMj15CkNPTkZJR19DUllQVE9fUk5HX0RFRkFVTFQ9eQpDT05GSUdfQ1JZUFRPX0FLQ0lQ
SEVSMj15CkNPTkZJR19DUllQVE9fQUtDSVBIRVI9eQpDT05GSUdfQ1JZUFRPX0tQUDI9eQpD
T05GSUdfQ1JZUFRPX0tQUD15CkNPTkZJR19DUllQVE9fQUNPTVAyPXkKQ09ORklHX0NSWVBU
T19NQU5BR0VSPXkKQ09ORklHX0NSWVBUT19NQU5BR0VSMj15CiMgQ09ORklHX0NSWVBUT19V
U0VSIGlzIG5vdCBzZXQKQ09ORklHX0NSWVBUT19NQU5BR0VSX0RJU0FCTEVfVEVTVFM9eQpD
T05GSUdfQ1JZUFRPX0dGMTI4TVVMPXkKQ09ORklHX0NSWVBUT19OVUxMPXkKQ09ORklHX0NS
WVBUT19OVUxMMj15CiMgQ09ORklHX0NSWVBUT19QQ1JZUFQgaXMgbm90IHNldApDT05GSUdf
Q1JZUFRPX0NSWVBURD15CkNPTkZJR19DUllQVE9fQVVUSEVOQz15CiMgQ09ORklHX0NSWVBU
T19URVNUIGlzIG5vdCBzZXQKQ09ORklHX0NSWVBUT19TSU1EPXkKQ09ORklHX0NSWVBUT19F
TkdJTkU9eQoKIwojIFB1YmxpYy1rZXkgY3J5cHRvZ3JhcGh5CiMKQ09ORklHX0NSWVBUT19S
U0E9eQojIENPTkZJR19DUllQVE9fREggaXMgbm90IHNldApDT05GSUdfQ1JZUFRPX0VDQz15
CkNPTkZJR19DUllQVE9fRUNESD15CiMgQ09ORklHX0NSWVBUT19FQ1JEU0EgaXMgbm90IHNl
dAojIENPTkZJR19DUllQVE9fU00yIGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX0NVUlZF
MjU1MTkgaXMgbm90IHNldApDT05GSUdfQ1JZUFRPX0NVUlZFMjU1MTlfWDg2PXkKCiMKIyBB
dXRoZW50aWNhdGVkIEVuY3J5cHRpb24gd2l0aCBBc3NvY2lhdGVkIERhdGEKIwpDT05GSUdf
Q1JZUFRPX0NDTT15CkNPTkZJR19DUllQVE9fR0NNPXkKIyBDT05GSUdfQ1JZUFRPX0NIQUNI
QTIwUE9MWTEzMDUgaXMgbm90IHNldAojIENPTkZJR19DUllQVE9fQUVHSVMxMjggaXMgbm90
IHNldAojIENPTkZJR19DUllQVE9fQUVHSVMxMjhfQUVTTklfU1NFMiBpcyBub3Qgc2V0CkNP
TkZJR19DUllQVE9fU0VRSVY9eQpDT05GSUdfQ1JZUFRPX0VDSEFJTklWPXkKCiMKIyBCbG9j
ayBtb2RlcwojCkNPTkZJR19DUllQVE9fQ0JDPXkKIyBDT05GSUdfQ1JZUFRPX0NGQiBpcyBu
b3Qgc2V0CkNPTkZJR19DUllQVE9fQ1RSPXkKQ09ORklHX0NSWVBUT19DVFM9eQpDT05GSUdf
Q1JZUFRPX0VDQj15CkNPTkZJR19DUllQVE9fTFJXPXkKIyBDT05GSUdfQ1JZUFRPX09GQiBp
cyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19QQ0JDIGlzIG5vdCBzZXQKQ09ORklHX0NSWVBU
T19YVFM9eQojIENPTkZJR19DUllQVE9fS0VZV1JBUCBpcyBub3Qgc2V0CiMgQ09ORklHX0NS
WVBUT19OSFBPTFkxMzA1X1NTRTIgaXMgbm90IHNldAojIENPTkZJR19DUllQVE9fTkhQT0xZ
MTMwNV9BVlgyIGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX0FESUFOVFVNIGlzIG5vdCBz
ZXQKQ09ORklHX0NSWVBUT19FU1NJVj15CgojCiMgSGFzaCBtb2RlcwojCkNPTkZJR19DUllQ
VE9fQ01BQz15CkNPTkZJR19DUllQVE9fSE1BQz15CiMgQ09ORklHX0NSWVBUT19YQ0JDIGlz
IG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX1ZNQUMgaXMgbm90IHNldAoKIwojIERpZ2VzdAoj
CkNPTkZJR19DUllQVE9fQ1JDMzJDPXkKIyBDT05GSUdfQ1JZUFRPX0NSQzMyQ19JTlRFTCBp
cyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19DUkMzMiBpcyBub3Qgc2V0CiMgQ09ORklHX0NS
WVBUT19DUkMzMl9QQ0xNVUwgaXMgbm90IHNldAojIENPTkZJR19DUllQVE9fWFhIQVNIIGlz
IG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX0JMQUtFMkIgaXMgbm90IHNldAojIENPTkZJR19D
UllQVE9fQkxBS0UyUyBpcyBub3Qgc2V0CkNPTkZJR19DUllQVE9fQkxBS0UyU19YODY9eQpD
T05GSUdfQ1JZUFRPX0NSQ1QxMERJRj15CiMgQ09ORklHX0NSWVBUT19DUkNUMTBESUZfUENM
TVVMIGlzIG5vdCBzZXQKQ09ORklHX0NSWVBUT19HSEFTSD15CiMgQ09ORklHX0NSWVBUT19Q
T0xZMTMwNSBpcyBub3Qgc2V0CkNPTkZJR19DUllQVE9fUE9MWTEzMDVfWDg2XzY0PXkKIyBD
T05GSUdfQ1JZUFRPX01ENCBpcyBub3Qgc2V0CkNPTkZJR19DUllQVE9fTUQ1PXkKIyBDT05G
SUdfQ1JZUFRPX01JQ0hBRUxfTUlDIGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX1JNRDEy
OCBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19STUQxNjAgaXMgbm90IHNldAojIENPTkZJ
R19DUllQVE9fUk1EMjU2IGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX1JNRDMyMCBpcyBu
b3Qgc2V0CkNPTkZJR19DUllQVE9fU0hBMT15CiMgQ09ORklHX0NSWVBUT19TSEExX1NTU0Uz
IGlzIG5vdCBzZXQKQ09ORklHX0NSWVBUT19TSEEyNTZfU1NTRTM9eQojIENPTkZJR19DUllQ
VE9fU0hBNTEyX1NTU0UzIGlzIG5vdCBzZXQKQ09ORklHX0NSWVBUT19TSEEyNTY9eQpDT05G
SUdfQ1JZUFRPX1NIQTUxMj15CiMgQ09ORklHX0NSWVBUT19TSEEzIGlzIG5vdCBzZXQKIyBD
T05GSUdfQ1JZUFRPX1NNMyBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19TVFJFRUJPRyBp
cyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19UR1IxOTIgaXMgbm90IHNldAojIENPTkZJR19D
UllQVE9fV1A1MTIgaXMgbm90IHNldAojIENPTkZJR19DUllQVE9fR0hBU0hfQ0xNVUxfTklf
SU5URUwgaXMgbm90IHNldAoKIwojIENpcGhlcnMKIwpDT05GSUdfQ1JZUFRPX0FFUz15CiMg
Q09ORklHX0NSWVBUT19BRVNfVEkgaXMgbm90IHNldApDT05GSUdfQ1JZUFRPX0FFU19OSV9J
TlRFTD15CiMgQ09ORklHX0NSWVBUT19BTlVCSVMgaXMgbm90IHNldApDT05GSUdfQ1JZUFRP
X0FSQzQ9eQojIENPTkZJR19DUllQVE9fQkxPV0ZJU0ggaXMgbm90IHNldAojIENPTkZJR19D
UllQVE9fQkxPV0ZJU0hfWDg2XzY0IGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX0NBTUVM
TElBIGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX0NBTUVMTElBX1g4Nl82NCBpcyBub3Qg
c2V0CiMgQ09ORklHX0NSWVBUT19DQU1FTExJQV9BRVNOSV9BVlhfWDg2XzY0IGlzIG5vdCBz
ZXQKIyBDT05GSUdfQ1JZUFRPX0NBTUVMTElBX0FFU05JX0FWWDJfWDg2XzY0IGlzIG5vdCBz
ZXQKIyBDT05GSUdfQ1JZUFRPX0NBU1Q1IGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX0NB
U1Q1X0FWWF9YODZfNjQgaXMgbm90IHNldAojIENPTkZJR19DUllQVE9fQ0FTVDYgaXMgbm90
IHNldAojIENPTkZJR19DUllQVE9fQ0FTVDZfQVZYX1g4Nl82NCBpcyBub3Qgc2V0CkNPTkZJ
R19DUllQVE9fREVTPXkKIyBDT05GSUdfQ1JZUFRPX0RFUzNfRURFX1g4Nl82NCBpcyBub3Qg
c2V0CiMgQ09ORklHX0NSWVBUT19GQ1JZUFQgaXMgbm90IHNldAojIENPTkZJR19DUllQVE9f
S0hBWkFEIGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX1NBTFNBMjAgaXMgbm90IHNldAoj
IENPTkZJR19DUllQVE9fQ0hBQ0hBMjAgaXMgbm90IHNldApDT05GSUdfQ1JZUFRPX0NIQUNI
QTIwX1g4Nl82ND15CiMgQ09ORklHX0NSWVBUT19TRUVEIGlzIG5vdCBzZXQKIyBDT05GSUdf
Q1JZUFRPX1NFUlBFTlQgaXMgbm90IHNldAojIENPTkZJR19DUllQVE9fU0VSUEVOVF9TU0Uy
X1g4Nl82NCBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19TRVJQRU5UX0FWWF9YODZfNjQg
aXMgbm90IHNldAojIENPTkZJR19DUllQVE9fU0VSUEVOVF9BVlgyX1g4Nl82NCBpcyBub3Qg
c2V0CiMgQ09ORklHX0NSWVBUT19TTTQgaXMgbm90IHNldAojIENPTkZJR19DUllQVE9fVEVB
IGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX1RXT0ZJU0ggaXMgbm90IHNldAojIENPTkZJ
R19DUllQVE9fVFdPRklTSF9YODZfNjQgaXMgbm90IHNldAojIENPTkZJR19DUllQVE9fVFdP
RklTSF9YODZfNjRfM1dBWSBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19UV09GSVNIX0FW
WF9YODZfNjQgaXMgbm90IHNldAoKIwojIENvbXByZXNzaW9uCiMKQ09ORklHX0NSWVBUT19E
RUZMQVRFPXkKQ09ORklHX0NSWVBUT19MWk89eQojIENPTkZJR19DUllQVE9fODQyIGlzIG5v
dCBzZXQKIyBDT05GSUdfQ1JZUFRPX0xaNCBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19M
WjRIQyBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19aU1REIGlzIG5vdCBzZXQKCiMKIyBS
YW5kb20gTnVtYmVyIEdlbmVyYXRpb24KIwojIENPTkZJR19DUllQVE9fQU5TSV9DUFJORyBp
cyBub3Qgc2V0CkNPTkZJR19DUllQVE9fRFJCR19NRU5VPXkKQ09ORklHX0NSWVBUT19EUkJH
X0hNQUM9eQojIENPTkZJR19DUllQVE9fRFJCR19IQVNIIGlzIG5vdCBzZXQKIyBDT05GSUdf
Q1JZUFRPX0RSQkdfQ1RSIGlzIG5vdCBzZXQKQ09ORklHX0NSWVBUT19EUkJHPXkKQ09ORklH
X0NSWVBUT19KSVRURVJFTlRST1BZPXkKQ09ORklHX0NSWVBUT19VU0VSX0FQST15CkNPTkZJ
R19DUllQVE9fVVNFUl9BUElfSEFTSD15CkNPTkZJR19DUllQVE9fVVNFUl9BUElfU0tDSVBI
RVI9eQojIENPTkZJR19DUllQVE9fVVNFUl9BUElfUk5HIGlzIG5vdCBzZXQKIyBDT05GSUdf
Q1JZUFRPX1VTRVJfQVBJX0FFQUQgaXMgbm90IHNldApDT05GSUdfQ1JZUFRPX1VTRVJfQVBJ
X0VOQUJMRV9PQlNPTEVURT15CkNPTkZJR19DUllQVE9fSEFTSF9JTkZPPXkKQ09ORklHX0NS
WVBUT19IVz15CiMgQ09ORklHX0NSWVBUT19ERVZfUEFETE9DSyBpcyBub3Qgc2V0CiMgQ09O
RklHX0NSWVBUT19ERVZfQVRNRUxfRUNDIGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX0RF
Vl9BVE1FTF9TSEEyMDRBIGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX0RFVl9DQ1AgaXMg
bm90IHNldAojIENPTkZJR19DUllQVE9fREVWX1FBVF9ESDg5NXhDQyBpcyBub3Qgc2V0CiMg
Q09ORklHX0NSWVBUT19ERVZfUUFUX0MzWFhYIGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRP
X0RFVl9RQVRfQzYyWCBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19ERVZfUUFUX0RIODk1
eENDVkYgaXMgbm90IHNldAojIENPTkZJR19DUllQVE9fREVWX1FBVF9DM1hYWFZGIGlzIG5v
dCBzZXQKIyBDT05GSUdfQ1JZUFRPX0RFVl9RQVRfQzYyWFZGIGlzIG5vdCBzZXQKIyBDT05G
SUdfQ1JZUFRPX0RFVl9OSVRST1hfQ05ONTVYWCBpcyBub3Qgc2V0CkNPTkZJR19DUllQVE9f
REVWX1ZJUlRJTz15CiMgQ09ORklHX0NSWVBUT19ERVZfU0FGRVhDRUwgaXMgbm90IHNldAoj
IENPTkZJR19DUllQVE9fREVWX0NDUkVFIGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX0RF
Vl9BTUxPR0lDX0dYTCBpcyBub3Qgc2V0CkNPTkZJR19BU1lNTUVUUklDX0tFWV9UWVBFPXkK
Q09ORklHX0FTWU1NRVRSSUNfUFVCTElDX0tFWV9TVUJUWVBFPXkKQ09ORklHX1g1MDlfQ0VS
VElGSUNBVEVfUEFSU0VSPXkKIyBDT05GSUdfUEtDUzhfUFJJVkFURV9LRVlfUEFSU0VSIGlz
IG5vdCBzZXQKQ09ORklHX1BLQ1M3X01FU1NBR0VfUEFSU0VSPXkKIyBDT05GSUdfUEtDUzdf
VEVTVF9LRVkgaXMgbm90IHNldAojIENPTkZJR19TSUdORURfUEVfRklMRV9WRVJJRklDQVRJ
T04gaXMgbm90IHNldAoKIwojIENlcnRpZmljYXRlcyBmb3Igc2lnbmF0dXJlIGNoZWNraW5n
CiMKQ09ORklHX1NZU1RFTV9UUlVTVEVEX0tFWVJJTkc9eQpDT05GSUdfU1lTVEVNX1RSVVNU
RURfS0VZUz0iIgojIENPTkZJR19TWVNURU1fRVhUUkFfQ0VSVElGSUNBVEUgaXMgbm90IHNl
dAojIENPTkZJR19TRUNPTkRBUllfVFJVU1RFRF9LRVlSSU5HIGlzIG5vdCBzZXQKIyBDT05G
SUdfU1lTVEVNX0JMQUNLTElTVF9LRVlSSU5HIGlzIG5vdCBzZXQKIyBlbmQgb2YgQ2VydGlm
aWNhdGVzIGZvciBzaWduYXR1cmUgY2hlY2tpbmcKCkNPTkZJR19CSU5BUllfUFJJTlRGPXkK
CiMKIyBMaWJyYXJ5IHJvdXRpbmVzCiMKIyBDT05GSUdfUEFDS0lORyBpcyBub3Qgc2V0CkNP
TkZJR19CSVRSRVZFUlNFPXkKQ09ORklHX0dFTkVSSUNfU1RSTkNQWV9GUk9NX1VTRVI9eQpD
T05GSUdfR0VORVJJQ19TVFJOTEVOX1VTRVI9eQpDT05GSUdfR0VORVJJQ19ORVRfVVRJTFM9
eQpDT05GSUdfR0VORVJJQ19GSU5EX0ZJUlNUX0JJVD15CkNPTkZJR19DT1JESUM9eQojIENP
TkZJR19QUklNRV9OVU1CRVJTIGlzIG5vdCBzZXQKQ09ORklHX1JBVElPTkFMPXkKQ09ORklH
X0dFTkVSSUNfUENJX0lPTUFQPXkKQ09ORklHX0dFTkVSSUNfSU9NQVA9eQpDT05GSUdfQVJD
SF9VU0VfQ01QWENIR19MT0NLUkVGPXkKQ09ORklHX0FSQ0hfSEFTX0ZBU1RfTVVMVElQTElF
Uj15CkNPTkZJR19BUkNIX1VTRV9TWU1fQU5OT1RBVElPTlM9eQoKIwojIENyeXB0byBsaWJy
YXJ5IHJvdXRpbmVzCiMKQ09ORklHX0NSWVBUT19MSUJfQUVTPXkKQ09ORklHX0NSWVBUT19M
SUJfQVJDND15CkNPTkZJR19DUllQVE9fQVJDSF9IQVZFX0xJQl9CTEFLRTJTPXkKQ09ORklH
X0NSWVBUT19MSUJfQkxBS0UyU19HRU5FUklDPXkKQ09ORklHX0NSWVBUT19BUkNIX0hBVkVf
TElCX0NIQUNIQT15CkNPTkZJR19DUllQVE9fTElCX0NIQUNIQV9HRU5FUklDPXkKQ09ORklH
X0NSWVBUT19MSUJfQ0hBQ0hBPXkKQ09ORklHX0NSWVBUT19BUkNIX0hBVkVfTElCX0NVUlZF
MjU1MTk9eQpDT05GSUdfQ1JZUFRPX0xJQl9DVVJWRTI1NTE5X0dFTkVSSUM9eQpDT05GSUdf
Q1JZUFRPX0xJQl9DVVJWRTI1NTE5PXkKQ09ORklHX0NSWVBUT19MSUJfREVTPXkKQ09ORklH
X0NSWVBUT19MSUJfUE9MWTEzMDVfUlNJWkU9MTEKQ09ORklHX0NSWVBUT19BUkNIX0hBVkVf
TElCX1BPTFkxMzA1PXkKQ09ORklHX0NSWVBUT19MSUJfUE9MWTEzMDVfR0VORVJJQz15CkNP
TkZJR19DUllQVE9fTElCX1BPTFkxMzA1PXkKQ09ORklHX0NSWVBUT19MSUJfQ0hBQ0hBMjBQ
T0xZMTMwNT15CkNPTkZJR19DUllQVE9fTElCX1NIQTI1Nj15CiMgZW5kIG9mIENyeXB0byBs
aWJyYXJ5IHJvdXRpbmVzCgpDT05GSUdfTElCX01FTU5FUT15CkNPTkZJR19DUkNfQ0NJVFQ9
eQpDT05GSUdfQ1JDMTY9eQpDT05GSUdfQ1JDX1QxMERJRj15CkNPTkZJR19DUkNfSVRVX1Q9
eQpDT05GSUdfQ1JDMzI9eQojIENPTkZJR19DUkMzMl9TRUxGVEVTVCBpcyBub3Qgc2V0CkNP
TkZJR19DUkMzMl9TTElDRUJZOD15CiMgQ09ORklHX0NSQzMyX1NMSUNFQlk0IGlzIG5vdCBz
ZXQKIyBDT05GSUdfQ1JDMzJfU0FSV0FURSBpcyBub3Qgc2V0CiMgQ09ORklHX0NSQzMyX0JJ
VCBpcyBub3Qgc2V0CiMgQ09ORklHX0NSQzY0IGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JDNCBp
cyBub3Qgc2V0CkNPTkZJR19DUkM3PXkKQ09ORklHX0xJQkNSQzMyQz15CiMgQ09ORklHX0NS
QzggaXMgbm90IHNldApDT05GSUdfWFhIQVNIPXkKIyBDT05GSUdfUkFORE9NMzJfU0VMRlRF
U1QgaXMgbm90IHNldApDT05GSUdfWkxJQl9JTkZMQVRFPXkKQ09ORklHX1pMSUJfREVGTEFU
RT15CkNPTkZJR19MWk9fQ09NUFJFU1M9eQpDT05GSUdfTFpPX0RFQ09NUFJFU1M9eQpDT05G
SUdfTFo0X0RFQ09NUFJFU1M9eQpDT05GSUdfWlNURF9ERUNPTVBSRVNTPXkKQ09ORklHX1ha
X0RFQz15CkNPTkZJR19YWl9ERUNfWDg2PXkKIyBDT05GSUdfWFpfREVDX1BPV0VSUEMgaXMg
bm90IHNldAojIENPTkZJR19YWl9ERUNfSUE2NCBpcyBub3Qgc2V0CiMgQ09ORklHX1haX0RF
Q19BUk0gaXMgbm90IHNldAojIENPTkZJR19YWl9ERUNfQVJNVEhVTUIgaXMgbm90IHNldAoj
IENPTkZJR19YWl9ERUNfU1BBUkMgaXMgbm90IHNldApDT05GSUdfWFpfREVDX0JDSj15CiMg
Q09ORklHX1haX0RFQ19URVNUIGlzIG5vdCBzZXQKQ09ORklHX0RFQ09NUFJFU1NfR1pJUD15
CkNPTkZJR19ERUNPTVBSRVNTX1haPXkKQ09ORklHX0RFQ09NUFJFU1NfTFo0PXkKQ09ORklH
X0RFQ09NUFJFU1NfWlNURD15CkNPTkZJR19HRU5FUklDX0FMTE9DQVRPUj15CkNPTkZJR19S
RUVEX1NPTE9NT049eQpDT05GSUdfUkVFRF9TT0xPTU9OX0VOQzg9eQpDT05GSUdfUkVFRF9T
T0xPTU9OX0RFQzg9eQpDT05GSUdfVEVYVFNFQVJDSD15CkNPTkZJR19URVhUU0VBUkNIX0tN
UD15CkNPTkZJR19URVhUU0VBUkNIX0JNPXkKQ09ORklHX1RFWFRTRUFSQ0hfRlNNPXkKQ09O
RklHX0lOVEVSVkFMX1RSRUU9eQpDT05GSUdfQVNTT0NJQVRJVkVfQVJSQVk9eQpDT05GSUdf
SEFTX0lPTUVNPXkKQ09ORklHX0hBU19JT1BPUlRfTUFQPXkKQ09ORklHX0hBU19ETUE9eQpD
T05GSUdfRE1BX09QUz15CkNPTkZJR19ORUVEX1NHX0RNQV9MRU5HVEg9eQpDT05GSUdfTkVF
RF9ETUFfTUFQX1NUQVRFPXkKQ09ORklHX0FSQ0hfRE1BX0FERFJfVF82NEJJVD15CkNPTkZJ
R19TV0lPVExCPXkKIyBDT05GSUdfRE1BX0FQSV9ERUJVRyBpcyBub3Qgc2V0CkNPTkZJR19T
R0xfQUxMT0M9eQpDT05GSUdfSU9NTVVfSEVMUEVSPXkKQ09ORklHX0NIRUNLX1NJR05BVFVS
RT15CiMgQ09ORklHX0NQVU1BU0tfT0ZGU1RBQ0sgaXMgbm90IHNldApDT05GSUdfQ1BVX1JN
QVA9eQpDT05GSUdfRFFMPXkKQ09ORklHX0dMT0I9eQojIENPTkZJR19HTE9CX1NFTEZURVNU
IGlzIG5vdCBzZXQKQ09ORklHX05MQVRUUj15CkNPTkZJR19DTFpfVEFCPXkKIyBDT05GSUdf
SVJRX1BPTEwgaXMgbm90IHNldApDT05GSUdfTVBJTElCPXkKQ09ORklHX09JRF9SRUdJU1RS
WT15CkNPTkZJR19IQVZFX0dFTkVSSUNfVkRTTz15CkNPTkZJR19HRU5FUklDX0dFVFRJTUVP
RkRBWT15CkNPTkZJR19HRU5FUklDX1ZEU09fVElNRV9OUz15CkNPTkZJR19GT05UX1NVUFBP
UlQ9eQojIENPTkZJR19GT05UUyBpcyBub3Qgc2V0CkNPTkZJR19GT05UXzh4OD15CkNPTkZJ
R19GT05UXzh4MTY9eQpDT05GSUdfU0dfUE9PTD15CkNPTkZJR19BUkNIX0hBU19QTUVNX0FQ
ST15CkNPTkZJR19BUkNIX0hBU19VQUNDRVNTX0ZMVVNIQ0FDSEU9eQpDT05GSUdfQVJDSF9I
QVNfQ09QWV9NQz15CkNPTkZJR19BUkNIX1NUQUNLV0FMSz15CkNPTkZJR19TVEFDS0RFUE9U
PXkKQ09ORklHX1NCSVRNQVA9eQojIENPTkZJR19TVFJJTkdfU0VMRlRFU1QgaXMgbm90IHNl
dAojIGVuZCBvZiBMaWJyYXJ5IHJvdXRpbmVzCgojCiMgS2VybmVsIGhhY2tpbmcKIwoKIwoj
IHByaW50ayBhbmQgZG1lc2cgb3B0aW9ucwojCkNPTkZJR19QUklOVEtfVElNRT15CkNPTkZJ
R19QUklOVEtfQ0FMTEVSPXkKQ09ORklHX1NUQUNLVFJBQ0VfQlVJTERfSUQ9eQpDT05GSUdf
Q09OU09MRV9MT0dMRVZFTF9ERUZBVUxUPTcKQ09ORklHX0NPTlNPTEVfTE9HTEVWRUxfUVVJ
RVQ9NApDT05GSUdfTUVTU0FHRV9MT0dMRVZFTF9ERUZBVUxUPTQKIyBDT05GSUdfQk9PVF9Q
UklOVEtfREVMQVkgaXMgbm90IHNldApDT05GSUdfRFlOQU1JQ19ERUJVRz15CkNPTkZJR19E
WU5BTUlDX0RFQlVHX0NPUkU9eQpDT05GSUdfU1lNQk9MSUNfRVJSTkFNRT15CkNPTkZJR19E
RUJVR19CVUdWRVJCT1NFPXkKIyBlbmQgb2YgcHJpbnRrIGFuZCBkbWVzZyBvcHRpb25zCgoj
CiMgQ29tcGlsZS10aW1lIGNoZWNrcyBhbmQgY29tcGlsZXIgb3B0aW9ucwojCkNPTkZJR19E
RUJVR19JTkZPPXkKIyBDT05GSUdfREVCVUdfSU5GT19SRURVQ0VEIGlzIG5vdCBzZXQKIyBD
T05GSUdfREVCVUdfSU5GT19DT01QUkVTU0VEIGlzIG5vdCBzZXQKIyBDT05GSUdfREVCVUdf
SU5GT19TUExJVCBpcyBub3Qgc2V0CkNPTkZJR19ERUJVR19JTkZPX0RXQVJGND15CkNPTkZJ
R19ERUJVR19JTkZPX0JURj15CiMgQ09ORklHX0dEQl9TQ1JJUFRTIGlzIG5vdCBzZXQKQ09O
RklHX0VOQUJMRV9NVVNUX0NIRUNLPXkKQ09ORklHX0ZSQU1FX1dBUk49MjA0OAojIENPTkZJ
R19TVFJJUF9BU01fU1lNUyBpcyBub3Qgc2V0CiMgQ09ORklHX1JFQURBQkxFX0FTTSBpcyBu
b3Qgc2V0CiMgQ09ORklHX0hFQURFUlNfSU5TVEFMTCBpcyBub3Qgc2V0CiMgQ09ORklHX0RF
QlVHX1NFQ1RJT05fTUlTTUFUQ0ggaXMgbm90IHNldAojIENPTkZJR19TRUNUSU9OX01JU01B
VENIX1dBUk5fT05MWSBpcyBub3Qgc2V0CiMgQ09ORklHX0RFQlVHX0ZPUkNFX0ZVTkNUSU9O
X0FMSUdOXzMyQiBpcyBub3Qgc2V0CkNPTkZJR19TVEFDS19WQUxJREFUSU9OPXkKIyBDT05G
SUdfREVCVUdfRk9SQ0VfV0VBS19QRVJfQ1BVIGlzIG5vdCBzZXQKIyBlbmQgb2YgQ29tcGls
ZS10aW1lIGNoZWNrcyBhbmQgY29tcGlsZXIgb3B0aW9ucwoKIwojIEdlbmVyaWMgS2VybmVs
IERlYnVnZ2luZyBJbnN0cnVtZW50cwojCiMgQ09ORklHX01BR0lDX1NZU1JRIGlzIG5vdCBz
ZXQKQ09ORklHX0RFQlVHX0ZTPXkKQ09ORklHX0RFQlVHX0ZTX0FMTE9XX0FMTD15CiMgQ09O
RklHX0RFQlVHX0ZTX0RJU0FMTE9XX01PVU5UIGlzIG5vdCBzZXQKIyBDT05GSUdfREVCVUdf
RlNfQUxMT1dfTk9ORSBpcyBub3Qgc2V0CkNPTkZJR19IQVZFX0FSQ0hfS0dEQj15CiMgQ09O
RklHX0tHREIgaXMgbm90IHNldApDT05GSUdfQVJDSF9IQVNfVUJTQU5fU0FOSVRJWkVfQUxM
PXkKQ09ORklHX1VCU0FOPXkKIyBDT05GSUdfVUJTQU5fVFJBUCBpcyBub3Qgc2V0CkNPTkZJ
R19VQlNBTl9CT1VORFM9eQojIENPTkZJR19VQlNBTl9NSVNDIGlzIG5vdCBzZXQKQ09ORklH
X1VCU0FOX1NBTklUSVpFX0FMTD15CiMgQ09ORklHX1VCU0FOX0FMSUdOTUVOVCBpcyBub3Qg
c2V0CiMgQ09ORklHX1RFU1RfVUJTQU4gaXMgbm90IHNldApDT05GSUdfSEFWRV9BUkNIX0tD
U0FOPXkKIyBlbmQgb2YgR2VuZXJpYyBLZXJuZWwgRGVidWdnaW5nIEluc3RydW1lbnRzCgpD
T05GSUdfREVCVUdfS0VSTkVMPXkKQ09ORklHX0RFQlVHX01JU0M9eQoKIwojIE1lbW9yeSBE
ZWJ1Z2dpbmcKIwpDT05GSUdfUEFHRV9FWFRFTlNJT049eQojIENPTkZJR19ERUJVR19QQUdF
QUxMT0MgaXMgbm90IHNldApDT05GSUdfUEFHRV9PV05FUj15CkNPTkZJR19QQUdFX1BPSVNP
TklORz15CiMgQ09ORklHX1BBR0VfUE9JU09OSU5HX05PX1NBTklUWSBpcyBub3Qgc2V0CiMg
Q09ORklHX1BBR0VfUE9JU09OSU5HX1pFUk8gaXMgbm90IHNldAojIENPTkZJR19ERUJVR19Q
QUdFX1JFRiBpcyBub3Qgc2V0CiMgQ09ORklHX0RFQlVHX1JPREFUQV9URVNUIGlzIG5vdCBz
ZXQKQ09ORklHX0FSQ0hfSEFTX0RFQlVHX1dYPXkKIyBDT05GSUdfREVCVUdfV1ggaXMgbm90
IHNldApDT05GSUdfR0VORVJJQ19QVERVTVA9eQpDT05GSUdfUFREVU1QX0NPUkU9eQpDT05G
SUdfUFREVU1QX0RFQlVHRlM9eQpDT05GSUdfREVCVUdfT0JKRUNUUz15CiMgQ09ORklHX0RF
QlVHX09CSkVDVFNfU0VMRlRFU1QgaXMgbm90IHNldApDT05GSUdfREVCVUdfT0JKRUNUU19G
UkVFPXkKQ09ORklHX0RFQlVHX09CSkVDVFNfVElNRVJTPXkKQ09ORklHX0RFQlVHX09CSkVD
VFNfV09SSz15CkNPTkZJR19ERUJVR19PQkpFQ1RTX1JDVV9IRUFEPXkKQ09ORklHX0RFQlVH
X09CSkVDVFNfUEVSQ1BVX0NPVU5URVI9eQpDT05GSUdfREVCVUdfT0JKRUNUU19FTkFCTEVf
REVGQVVMVD0xCiMgQ09ORklHX1NMVUJfREVCVUdfT04gaXMgbm90IHNldAojIENPTkZJR19T
TFVCX1NUQVRTIGlzIG5vdCBzZXQKQ09ORklHX0hBVkVfREVCVUdfS01FTUxFQUs9eQojIENP
TkZJR19ERUJVR19LTUVNTEVBSyBpcyBub3Qgc2V0CiMgQ09ORklHX0RFQlVHX1NUQUNLX1VT
QUdFIGlzIG5vdCBzZXQKQ09ORklHX1NDSEVEX1NUQUNLX0VORF9DSEVDSz15CkNPTkZJR19B
UkNIX0hBU19ERUJVR19WTV9QR1RBQkxFPXkKQ09ORklHX0RFQlVHX1ZNPXkKQ09ORklHX0RF
QlVHX1ZNX1ZNQUNBQ0hFPXkKQ09ORklHX0RFQlVHX1ZNX1JCPXkKQ09ORklHX0RFQlVHX1ZN
X1BHRkxBR1M9eQpDT05GSUdfREVCVUdfVk1fUEdUQUJMRT15CkNPTkZJR19BUkNIX0hBU19E
RUJVR19WSVJUVUFMPXkKQ09ORklHX0RFQlVHX1ZJUlRVQUw9eQpDT05GSUdfREVCVUdfTUVN
T1JZX0lOSVQ9eQpDT05GSUdfREVCVUdfUEVSX0NQVV9NQVBTPXkKQ09ORklHX0FSQ0hfU1VQ
UE9SVFNfS01BUF9MT0NBTF9GT1JDRV9NQVA9eQojIENPTkZJR19ERUJVR19LTUFQX0xPQ0FM
X0ZPUkNFX01BUCBpcyBub3Qgc2V0CkNPTkZJR19IQVZFX0FSQ0hfS0FTQU49eQpDT05GSUdf
SEFWRV9BUkNIX0tBU0FOX1ZNQUxMT0M9eQpDT05GSUdfQ0NfSEFTX0tBU0FOX0dFTkVSSUM9
eQpDT05GSUdfQ0NfSEFTX1dPUktJTkdfTk9TQU5JVElaRV9BRERSRVNTPXkKQ09ORklHX0tB
U0FOPXkKQ09ORklHX0tBU0FOX0dFTkVSSUM9eQojIENPTkZJR19LQVNBTl9PVVRMSU5FIGlz
IG5vdCBzZXQKQ09ORklHX0tBU0FOX0lOTElORT15CkNPTkZJR19LQVNBTl9TVEFDSz0xCkNP
TkZJR19LQVNBTl9WTUFMTE9DPXkKIyBDT05GSUdfVEVTVF9LQVNBTl9NT0RVTEUgaXMgbm90
IHNldApDT05GSUdfSEFWRV9BUkNIX0tGRU5DRT15CiMgZW5kIG9mIE1lbW9yeSBEZWJ1Z2dp
bmcKCiMgQ09ORklHX0RFQlVHX1NISVJRIGlzIG5vdCBzZXQKCiMKIyBEZWJ1ZyBPb3BzLCBM
b2NrdXBzIGFuZCBIYW5ncwojCkNPTkZJR19QQU5JQ19PTl9PT1BTPXkKQ09ORklHX1BBTklD
X09OX09PUFNfVkFMVUU9MQpDT05GSUdfUEFOSUNfVElNRU9VVD04NjQwMApDT05GSUdfTE9D
S1VQX0RFVEVDVE9SPXkKQ09ORklHX1NPRlRMT0NLVVBfREVURUNUT1I9eQpDT05GSUdfQk9P
VFBBUkFNX1NPRlRMT0NLVVBfUEFOSUM9eQpDT05GSUdfQk9PVFBBUkFNX1NPRlRMT0NLVVBf
UEFOSUNfVkFMVUU9MQpDT05GSUdfSEFSRExPQ0tVUF9ERVRFQ1RPUl9QRVJGPXkKQ09ORklH
X0hBUkRMT0NLVVBfQ0hFQ0tfVElNRVNUQU1QPXkKQ09ORklHX0hBUkRMT0NLVVBfREVURUNU
T1JfQ09SRT15CkNPTkZJR19IQVJETE9DS1VQX0RFVEVDVE9SPXkKQ09ORklHX0JPT1RQQVJB
TV9IQVJETE9DS1VQX1BBTklDPXkKQ09ORklHX0JPT1RQQVJBTV9IQVJETE9DS1VQX1BBTklD
X1ZBTFVFPTEKQ09ORklHX0RFVEVDVF9IVU5HX1RBU0s9eQpDT05GSUdfREVGQVVMVF9IVU5H
X1RBU0tfVElNRU9VVD0xNDAKQ09ORklHX0JPT1RQQVJBTV9IVU5HX1RBU0tfUEFOSUM9eQpD
T05GSUdfQk9PVFBBUkFNX0hVTkdfVEFTS19QQU5JQ19WQUxVRT0xCkNPTkZJR19XUV9XQVRD
SERPRz15CiMgQ09ORklHX1RFU1RfTE9DS1VQIGlzIG5vdCBzZXQKIyBlbmQgb2YgRGVidWcg
T29wcywgTG9ja3VwcyBhbmQgSGFuZ3MKCiMKIyBTY2hlZHVsZXIgRGVidWdnaW5nCiMKIyBD
T05GSUdfU0NIRURfREVCVUcgaXMgbm90IHNldApDT05GSUdfU0NIRURfSU5GTz15CkNPTkZJ
R19TQ0hFRFNUQVRTPXkKIyBlbmQgb2YgU2NoZWR1bGVyIERlYnVnZ2luZwoKQ09ORklHX0RF
QlVHX1RJTUVLRUVQSU5HPXkKQ09ORklHX0RFQlVHX1BSRUVNUFQ9eQoKIwojIExvY2sgRGVi
dWdnaW5nIChzcGlubG9ja3MsIG11dGV4ZXMsIGV0Yy4uLikKIwpDT05GSUdfTE9DS19ERUJV
R0dJTkdfU1VQUE9SVD15CkNPTkZJR19QUk9WRV9MT0NLSU5HPXkKIyBDT05GSUdfUFJPVkVf
UkFXX0xPQ0tfTkVTVElORyBpcyBub3Qgc2V0CiMgQ09ORklHX0xPQ0tfU1RBVCBpcyBub3Qg
c2V0CkNPTkZJR19ERUJVR19SVF9NVVRFWEVTPXkKQ09ORklHX0RFQlVHX1NQSU5MT0NLPXkK
Q09ORklHX0RFQlVHX01VVEVYRVM9eQpDT05GSUdfREVCVUdfV1dfTVVURVhfU0xPV1BBVEg9
eQpDT05GSUdfREVCVUdfUldTRU1TPXkKQ09ORklHX0RFQlVHX0xPQ0tfQUxMT0M9eQpDT05G
SUdfTE9DS0RFUD15CkNPTkZJR19MT0NLREVQX0JJVFM9MTUKQ09ORklHX0xPQ0tERVBfQ0hB
SU5TX0JJVFM9MTYKQ09ORklHX0xPQ0tERVBfU1RBQ0tfVFJBQ0VfQklUUz0xOQpDT05GSUdf
TE9DS0RFUF9TVEFDS19UUkFDRV9IQVNIX0JJVFM9MTQKQ09ORklHX0xPQ0tERVBfQ0lSQ1VM
QVJfUVVFVUVfQklUUz0xMgojIENPTkZJR19ERUJVR19MT0NLREVQIGlzIG5vdCBzZXQKQ09O
RklHX0RFQlVHX0FUT01JQ19TTEVFUD15CiMgQ09ORklHX0RFQlVHX0xPQ0tJTkdfQVBJX1NF
TEZURVNUUyBpcyBub3Qgc2V0CiMgQ09ORklHX0xPQ0tfVE9SVFVSRV9URVNUIGlzIG5vdCBz
ZXQKIyBDT05GSUdfV1dfTVVURVhfU0VMRlRFU1QgaXMgbm90IHNldAojIENPTkZJR19TQ0Zf
VE9SVFVSRV9URVNUIGlzIG5vdCBzZXQKIyBDT05GSUdfQ1NEX0xPQ0tfV0FJVF9ERUJVRyBp
cyBub3Qgc2V0CiMgZW5kIG9mIExvY2sgRGVidWdnaW5nIChzcGlubG9ja3MsIG11dGV4ZXMs
IGV0Yy4uLikKCkNPTkZJR19UUkFDRV9JUlFGTEFHUz15CkNPTkZJR19UUkFDRV9JUlFGTEFH
U19OTUk9eQpDT05GSUdfU1RBQ0tUUkFDRT15CiMgQ09ORklHX1dBUk5fQUxMX1VOU0VFREVE
X1JBTkRPTSBpcyBub3Qgc2V0CiMgQ09ORklHX0RFQlVHX0tPQkpFQ1QgaXMgbm90IHNldAoj
IENPTkZJR19ERUJVR19LT0JKRUNUX1JFTEVBU0UgaXMgbm90IHNldAoKIwojIERlYnVnIGtl
cm5lbCBkYXRhIHN0cnVjdHVyZXMKIwpDT05GSUdfREVCVUdfTElTVD15CkNPTkZJR19ERUJV
R19QTElTVD15CkNPTkZJR19ERUJVR19TRz15CkNPTkZJR19ERUJVR19OT1RJRklFUlM9eQpD
T05GSUdfQlVHX09OX0RBVEFfQ09SUlVQVElPTj15CiMgZW5kIG9mIERlYnVnIGtlcm5lbCBk
YXRhIHN0cnVjdHVyZXMKCkNPTkZJR19ERUJVR19DUkVERU5USUFMUz15CgojCiMgUkNVIERl
YnVnZ2luZwojCkNPTkZJR19QUk9WRV9SQ1U9eQojIENPTkZJR19SQ1VfU0NBTEVfVEVTVCBp
cyBub3Qgc2V0CiMgQ09ORklHX1JDVV9UT1JUVVJFX1RFU1QgaXMgbm90IHNldAojIENPTkZJ
R19SQ1VfUkVGX1NDQUxFX1RFU1QgaXMgbm90IHNldApDT05GSUdfUkNVX0NQVV9TVEFMTF9U
SU1FT1VUPTEwMAojIENPTkZJR19SQ1VfVFJBQ0UgaXMgbm90IHNldApDT05GSUdfUkNVX0VR
U19ERUJVRz15CiMgZW5kIG9mIFJDVSBEZWJ1Z2dpbmcKCiMgQ09ORklHX0RFQlVHX1dRX0ZP
UkNFX1JSX0NQVSBpcyBub3Qgc2V0CiMgQ09ORklHX0RFQlVHX0JMT0NLX0VYVF9ERVZUIGlz
IG5vdCBzZXQKIyBDT05GSUdfQ1BVX0hPVFBMVUdfU1RBVEVfQ09OVFJPTCBpcyBub3Qgc2V0
CiMgQ09ORklHX0xBVEVOQ1lUT1AgaXMgbm90IHNldApDT05GSUdfVVNFUl9TVEFDS1RSQUNF
X1NVUFBPUlQ9eQpDT05GSUdfTk9QX1RSQUNFUj15CkNPTkZJR19IQVZFX0ZVTkNUSU9OX1RS
QUNFUj15CkNPTkZJR19IQVZFX0ZVTkNUSU9OX0dSQVBIX1RSQUNFUj15CkNPTkZJR19IQVZF
X0RZTkFNSUNfRlRSQUNFPXkKQ09ORklHX0hBVkVfRFlOQU1JQ19GVFJBQ0VfV0lUSF9SRUdT
PXkKQ09ORklHX0hBVkVfRFlOQU1JQ19GVFJBQ0VfV0lUSF9ESVJFQ1RfQ0FMTFM9eQpDT05G
SUdfSEFWRV9GVFJBQ0VfTUNPVU5UX1JFQ09SRD15CkNPTkZJR19IQVZFX1NZU0NBTExfVFJB
Q0VQT0lOVFM9eQpDT05GSUdfSEFWRV9GRU5UUlk9eQpDT05GSUdfSEFWRV9DX1JFQ09SRE1D
T1VOVD15CkNPTkZJR19UUkFDRV9DTE9DSz15CkNPTkZJR19SSU5HX0JVRkZFUj15CkNPTkZJ
R19FVkVOVF9UUkFDSU5HPXkKQ09ORklHX0NPTlRFWFRfU1dJVENIX1RSQUNFUj15CkNPTkZJ
R19QUkVFTVBUSVJRX1RSQUNFUE9JTlRTPXkKQ09ORklHX1RSQUNJTkc9eQpDT05GSUdfR0VO
RVJJQ19UUkFDRVI9eQpDT05GSUdfVFJBQ0lOR19TVVBQT1JUPXkKQ09ORklHX0ZUUkFDRT15
CiMgQ09ORklHX0JPT1RUSU1FX1RSQUNJTkcgaXMgbm90IHNldAojIENPTkZJR19GVU5DVElP
Tl9UUkFDRVIgaXMgbm90IHNldAojIENPTkZJR19TVEFDS19UUkFDRVIgaXMgbm90IHNldAoj
IENPTkZJR19JUlFTT0ZGX1RSQUNFUiBpcyBub3Qgc2V0CiMgQ09ORklHX1BSRUVNUFRfVFJB
Q0VSIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NIRURfVFJBQ0VSIGlzIG5vdCBzZXQKIyBDT05G
SUdfSFdMQVRfVFJBQ0VSIGlzIG5vdCBzZXQKIyBDT05GSUdfTU1JT1RSQUNFIGlzIG5vdCBz
ZXQKQ09ORklHX0ZUUkFDRV9TWVNDQUxMUz15CiMgQ09ORklHX1RSQUNFUl9TTkFQU0hPVCBp
cyBub3Qgc2V0CkNPTkZJR19CUkFOQ0hfUFJPRklMRV9OT05FPXkKIyBDT05GSUdfUFJPRklM
RV9BTk5PVEFURURfQlJBTkNIRVMgaXMgbm90IHNldApDT05GSUdfQkxLX0RFVl9JT19UUkFD
RT15CkNPTkZJR19VUFJPQkVfRVZFTlRTPXkKQ09ORklHX0JQRl9FVkVOVFM9eQpDT05GSUdf
RFlOQU1JQ19FVkVOVFM9eQpDT05GSUdfUFJPQkVfRVZFTlRTPXkKIyBDT05GSUdfU1lOVEhf
RVZFTlRTIGlzIG5vdCBzZXQKIyBDT05GSUdfSElTVF9UUklHR0VSUyBpcyBub3Qgc2V0CkNP
TkZJR19UUkFDRV9FVkVOVF9JTkpFQ1Q9eQojIENPTkZJR19UUkFDRVBPSU5UX0JFTkNITUFS
SyBpcyBub3Qgc2V0CiMgQ09ORklHX1JJTkdfQlVGRkVSX0JFTkNITUFSSyBpcyBub3Qgc2V0
CiMgQ09ORklHX1RSQUNFX0VWQUxfTUFQX0ZJTEUgaXMgbm90IHNldAojIENPTkZJR19GVFJB
Q0VfU1RBUlRVUF9URVNUIGlzIG5vdCBzZXQKIyBDT05GSUdfUklOR19CVUZGRVJfU1RBUlRV
UF9URVNUIGlzIG5vdCBzZXQKIyBDT05GSUdfUFJFRU1QVElSUV9ERUxBWV9URVNUIGlzIG5v
dCBzZXQKIyBDT05GSUdfUFJPVklERV9PSENJMTM5NF9ETUFfSU5JVCBpcyBub3Qgc2V0CiMg
Q09ORklHX1NBTVBMRVMgaXMgbm90IHNldApDT05GSUdfQVJDSF9IQVNfREVWTUVNX0lTX0FM
TE9XRUQ9eQojIENPTkZJR19TVFJJQ1RfREVWTUVNIGlzIG5vdCBzZXQKCiMKIyB4ODYgRGVi
dWdnaW5nCiMKQ09ORklHX1RSQUNFX0lSUUZMQUdTX1NVUFBPUlQ9eQpDT05GSUdfVFJBQ0Vf
SVJRRkxBR1NfTk1JX1NVUFBPUlQ9eQpDT05GSUdfRUFSTFlfUFJJTlRLX1VTQj15CkNPTkZJ
R19YODZfVkVSQk9TRV9CT09UVVA9eQpDT05GSUdfRUFSTFlfUFJJTlRLPXkKQ09ORklHX0VB
UkxZX1BSSU5US19EQkdQPXkKIyBDT05GSUdfRUFSTFlfUFJJTlRLX1VTQl9YREJDIGlzIG5v
dCBzZXQKIyBDT05GSUdfREVCVUdfVExCRkxVU0ggaXMgbm90IHNldAojIENPTkZJR19JT01N
VV9ERUJVRyBpcyBub3Qgc2V0CkNPTkZJR19IQVZFX01NSU9UUkFDRV9TVVBQT1JUPXkKIyBD
T05GSUdfWDg2X0RFQ09ERVJfU0VMRlRFU1QgaXMgbm90IHNldAojIENPTkZJR19JT19ERUxB
WV8wWDgwIGlzIG5vdCBzZXQKQ09ORklHX0lPX0RFTEFZXzBYRUQ9eQojIENPTkZJR19JT19E
RUxBWV9VREVMQVkgaXMgbm90IHNldAojIENPTkZJR19JT19ERUxBWV9OT05FIGlzIG5vdCBz
ZXQKQ09ORklHX0RFQlVHX0JPT1RfUEFSQU1TPXkKIyBDT05GSUdfQ1BBX0RFQlVHIGlzIG5v
dCBzZXQKIyBDT05GSUdfREVCVUdfRU5UUlkgaXMgbm90IHNldAojIENPTkZJR19ERUJVR19O
TUlfU0VMRlRFU1QgaXMgbm90IHNldApDT05GSUdfWDg2X0RFQlVHX0ZQVT15CiMgQ09ORklH
X1BVTklUX0FUT01fREVCVUcgaXMgbm90IHNldApDT05GSUdfVU5XSU5ERVJfT1JDPXkKIyBD
T05GSUdfVU5XSU5ERVJfRlJBTUVfUE9JTlRFUiBpcyBub3Qgc2V0CiMgZW5kIG9mIHg4NiBE
ZWJ1Z2dpbmcKCiMKIyBLZXJuZWwgVGVzdGluZyBhbmQgQ292ZXJhZ2UKIwojIENPTkZJR19L
VU5JVCBpcyBub3Qgc2V0CiMgQ09ORklHX05PVElGSUVSX0VSUk9SX0lOSkVDVElPTiBpcyBu
b3Qgc2V0CkNPTkZJR19GQVVMVF9JTkpFQ1RJT049eQpDT05GSUdfRkFJTFNMQUI9eQpDT05G
SUdfRkFJTF9QQUdFX0FMTE9DPXkKQ09ORklHX0ZBVUxUX0lOSkVDVElPTl9VU0VSQ09QWT15
CkNPTkZJR19GQUlMX01BS0VfUkVRVUVTVD15CkNPTkZJR19GQUlMX0lPX1RJTUVPVVQ9eQpD
T05GSUdfRkFJTF9GVVRFWD15CkNPTkZJR19GQVVMVF9JTkpFQ1RJT05fREVCVUdfRlM9eQoj
IENPTkZJR19GQUlMX01NQ19SRVFVRVNUIGlzIG5vdCBzZXQKQ09ORklHX0FSQ0hfSEFTX0tD
T1Y9eQpDT05GSUdfQ0NfSEFTX1NBTkNPVl9UUkFDRV9QQz15CkNPTkZJR19LQ09WPXkKQ09O
RklHX0tDT1ZfRU5BQkxFX0NPTVBBUklTT05TPXkKQ09ORklHX0tDT1ZfSU5TVFJVTUVOVF9B
TEw9eQpDT05GSUdfS0NPVl9JUlFfQVJFQV9TSVpFPTB4NDAwMDAKQ09ORklHX1JVTlRJTUVf
VEVTVElOR19NRU5VPXkKQ09ORklHX0xLRFRNPXkKIyBDT05GSUdfVEVTVF9MSVNUX1NPUlQg
aXMgbm90IHNldAojIENPTkZJR19URVNUX01JTl9IRUFQIGlzIG5vdCBzZXQKIyBDT05GSUdf
VEVTVF9TT1JUIGlzIG5vdCBzZXQKIyBDT05GSUdfQkFDS1RSQUNFX1NFTEZfVEVTVCBpcyBu
b3Qgc2V0CiMgQ09ORklHX1JCVFJFRV9URVNUIGlzIG5vdCBzZXQKIyBDT05GSUdfUkVFRF9T
T0xPTU9OX1RFU1QgaXMgbm90IHNldAojIENPTkZJR19JTlRFUlZBTF9UUkVFX1RFU1QgaXMg
bm90IHNldAojIENPTkZJR19QRVJDUFVfVEVTVCBpcyBub3Qgc2V0CiMgQ09ORklHX0FUT01J
QzY0X1NFTEZURVNUIGlzIG5vdCBzZXQKIyBDT05GSUdfVEVTVF9IRVhEVU1QIGlzIG5vdCBz
ZXQKIyBDT05GSUdfVEVTVF9TVFJJTkdfSEVMUEVSUyBpcyBub3Qgc2V0CiMgQ09ORklHX1RF
U1RfU1RSU0NQWSBpcyBub3Qgc2V0CiMgQ09ORklHX1RFU1RfS1NUUlRPWCBpcyBub3Qgc2V0
CiMgQ09ORklHX1RFU1RfUFJJTlRGIGlzIG5vdCBzZXQKIyBDT05GSUdfVEVTVF9CSVRNQVAg
aXMgbm90IHNldAojIENPTkZJR19URVNUX1VVSUQgaXMgbm90IHNldAojIENPTkZJR19URVNU
X1hBUlJBWSBpcyBub3Qgc2V0CiMgQ09ORklHX1RFU1RfT1ZFUkZMT1cgaXMgbm90IHNldAoj
IENPTkZJR19URVNUX1JIQVNIVEFCTEUgaXMgbm90IHNldAojIENPTkZJR19URVNUX0hBU0gg
aXMgbm90IHNldAojIENPTkZJR19URVNUX0lEQSBpcyBub3Qgc2V0CiMgQ09ORklHX1RFU1Rf
TEtNIGlzIG5vdCBzZXQKIyBDT05GSUdfVEVTVF9CSVRPUFMgaXMgbm90IHNldAojIENPTkZJ
R19URVNUX1ZNQUxMT0MgaXMgbm90IHNldAojIENPTkZJR19URVNUX1VTRVJfQ09QWSBpcyBu
b3Qgc2V0CiMgQ09ORklHX1RFU1RfQlBGIGlzIG5vdCBzZXQKIyBDT05GSUdfVEVTVF9CTEFD
S0hPTEVfREVWIGlzIG5vdCBzZXQKIyBDT05GSUdfRklORF9CSVRfQkVOQ0hNQVJLIGlzIG5v
dCBzZXQKQ09ORklHX1RFU1RfRklSTVdBUkU9eQojIENPTkZJR19URVNUX1NZU0NUTCBpcyBu
b3Qgc2V0CkNPTkZJR19URVNUX1VERUxBWT15CiMgQ09ORklHX1RFU1RfU1RBVElDX0tFWVMg
aXMgbm90IHNldAojIENPTkZJR19URVNUX0tNT0QgaXMgbm90IHNldAojIENPTkZJR19URVNU
X0RFQlVHX1ZJUlRVQUwgaXMgbm90IHNldAojIENPTkZJR19URVNUX01FTUNBVF9QIGlzIG5v
dCBzZXQKIyBDT05GSUdfVEVTVF9TVEFDS0lOSVQgaXMgbm90IHNldAojIENPTkZJR19URVNU
X01FTUlOSVQgaXMgbm90IHNldAojIENPTkZJR19URVNUX0ZSRUVfUEFHRVMgaXMgbm90IHNl
dAojIENPTkZJR19NRU1URVNUIGlzIG5vdCBzZXQKIyBlbmQgb2YgS2VybmVsIFRlc3Rpbmcg
YW5kIENvdmVyYWdlCiMgZW5kIG9mIEtlcm5lbCBoYWNraW5nCg==

--------------0jeaIqpEGzlzS2PBRHSLwsZn--
