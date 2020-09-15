Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F4D0269D95
	for <lists+linux-ext4@lfdr.de>; Tue, 15 Sep 2020 06:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726168AbgIOEpj (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 15 Sep 2020 00:45:39 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:60691 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726057AbgIOEpe (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 15 Sep 2020 00:45:34 -0400
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 08F4jJ6n021282
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Sep 2020 00:45:20 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 7150D42004D; Tue, 15 Sep 2020 00:45:19 -0400 (EDT)
Date:   Tue, 15 Sep 2020 00:45:19 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-ext4@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: REGRESSION: 37f4a24c2469: blk-mq: centralise related handling into
 blk_mq_get_driver_tag
Message-ID: <20200915044519.GA38283@mit.edu>
References: <20200818181117.GA34125@mit.edu>
 <990cc101-d4a1-f346-fe78-0fb5b963b406@kernel.dk>
 <20c844c8-b649-3250-ff5b-b7420f72ff38@kernel.dk>
 <20200822143326.GC199705@mit.edu>
 <aff250ad-4c31-15c2-fa1d-3f3945cb7aa5@kernel.dk>
 <7f0e2d99-5da2-237e-a894-0afddc0ace1e@kernel.dk>
 <049a97db-c362-bcfb-59e5-4b1d2df59383@kernel.dk>
 <5140ba6c-779c-2a71-b7f2-3c3220cdf19c@kernel.dk>
 <68510957-c887-8e26-4a1a-a7a93488586a@kernel.dk>
 <20200904035528.GE558530@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200904035528.GE558530@mit.edu>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Sep 03, 2020 at 11:55:28PM -0400, Theodore Y. Ts'o wrote:
> Worse, right now, -rc1 and -rc2 is causing random crashes in my
> gce-xfstests framework.  Sometimes it happens before we've run even a
> single xfstests; sometimes it happens after we have successfully
> completed all of the tests, and we're doing a shutdown of the VM under
> test.  Other times it happens in the middle of a test run.  Given that
> I'm seeing this at -rc1, which is before my late ext4 pull request to
> Linus, it's probably not an ext4 related bug.  But it also means that
> I'm partially blind in terms of my kernel testing at the moment.  So I
> can't even tell Linus that I've run lots of tests and I'm 100%
> confident your one-line change is 100% safe.

I was finally able to bisect it down to the commit:

37f4a24c2469: blk-mq: centralise related handling into blk_mq_get_driver_tag

(See below for [1] Bisect log.)

The previous commit allows the tests to run to completion.  With
commit 37f4a24c2469 and later all 11 test scenarios (4k blocks, 1k
blocks, ext3 compat, ext4 w/ fscrypt, nojournal mode, data=journal,
bigalloc, etc.) the VM will get stuck.

The symptom is that while running xfstests in a Google Compute Engine
(GCE) VM, the tests just hang.  There are a number of tests where this
is more likely, but it's not unique to a single test.

In most cases, there is nothing; just the test stops running until the
test framework times out after an hour (tests usually complete in
seconds or at most a few tens of minutes or so in the worst case) and
kills the VM.  In one case, I did get a report like this.  (See below
for [2] stack trace from 37f4a24c2469.)

I attempted to revert the commit in question against -rc1 and -rc4;
that result can be found at the branches manual-revert-of-blk-mq-patch
and manual-revert-of-blk-mq-patch-rc4 at https://github.com/tytso/ext4.

I don't think I got the revert quite right; with the revert, most of
the test VM's successfully complete, but 2 out of the 11 fail, with a
different stack trace.  (See below for [3] stack trace from my
attempted manual revert of 37f4a24c2469).  But it does seem to confirm
that the primary cause of the test VM hangs is caused by commit
37f4a24c2469.

Does this make any sense as to what might be going on?  I hope it does
for you, since I'm pretty confused what might be going on.

Thanks,

     	       	   	       - Ted
			       

[1] Bisect log

git bisect start
# bad: [9123e3a74ec7b934a4a099e98af6a61c2f80bbf5] Linux 5.9-rc1
git bisect bad 9123e3a74ec7b934a4a099e98af6a61c2f80bbf5
# good: [bcf876870b95592b52519ed4aafcf9d95999bc9c] Linux 5.8
git bisect good bcf876870b95592b52519ed4aafcf9d95999bc9c
# bad: [8186749621ed6b8fc42644c399e8c755a2b6f630] Merge tag 'drm-next-2020-08-06' of git://anongit.freedesktop.org/drm/drm
git bisect bad 8186749621ed6b8fc42644c399e8c755a2b6f630
# bad: [2324d50d051ec0f14a548e78554fb02513d6dcef] Merge tag 'docs-5.9' of git://git.lwn.net/linux
git bisect bad 2324d50d051ec0f14a548e78554fb02513d6dcef
# bad: [92c59e126b21fd212195358a0d296e787e444087] Merge tag 'arm-defconfig-5.9' of git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc
git bisect bad 92c59e126b21fd212195358a0d296e787e444087
# bad: [cdc8fcb49905c0b67e355e027cb462ee168ffaa3] Merge tag 'for-5.9/io_uring-20200802' of git://git.kernel.dk/linux-block
git bisect bad cdc8fcb49905c0b67e355e027cb462ee168ffaa3
# good: [ab5c60b79ab6cc50b39bbb21b2f9fb55af900b84] Merge branch 'linus' of git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6
git bisect good ab5c60b79ab6cc50b39bbb21b2f9fb55af900b84
# bad: [d958e343bdc3de2643ce25225bed082dc222858d] block: blk-timeout: delete duplicated word
git bisect bad d958e343bdc3de2643ce25225bed082dc222858d
# bad: [53042f3cc411adc79811ba3cfbca5d7a42a7b806] ps3vram: stop using ->queuedata
git bisect bad 53042f3cc411adc79811ba3cfbca5d7a42a7b806
# good: [621c1f42945e76015c3a585e7a9fe6e71665eba0] block: move struct block_device to blk_types.h
git bisect good 621c1f42945e76015c3a585e7a9fe6e71665eba0
# good: [36a3df5a4574d5ddf59804fcd0c4e9654c514d9a] blk-mq: put driver tag when this request is completed
git bisect good 36a3df5a4574d5ddf59804fcd0c4e9654c514d9a
# good: [570e9b73b0af2e5381ca5343759779b8c1ed20e3] blk-mq: move blk_mq_get_driver_tag into blk-mq.c
git bisect good 570e9b73b0af2e5381ca5343759779b8c1ed20e3
# bad: [b5fc1e8bedf8ad2c6381e0df6331ad5686aca425] blk-mq: remove pointless call of list_entry_rq() in hctx_show_busy_rq()
git bisect bad b5fc1e8bedf8ad2c6381e0df6331ad5686aca425
# bad: [37f4a24c2469a10a4c16c641671bd766e276cf9f] blk-mq: centralise related handling into blk_mq_get_driver_tag
git bisect bad 37f4a24c2469a10a4c16c641671bd766e276cf9f
# good: [723bf178f158abd1ce6069cb049581b3cb003aab] blk-mq: move blk_mq_put_driver_tag() into blk-mq.c
git bisect good 723bf178f158abd1ce6069cb049581b3cb003aab
# first bad commit: [37f4a24c2469a10a4c16c641671bd766e276cf9f] blk-mq: centralise related handling into blk_mq_get_driver_tag

========================================================================

[2] Lockup stack traces from commit 37f4a24c2469

[ 1842.777020] INFO: task fsstress:20611 blocked for more than 122 seconds.
[ 1842.784641]       Not tainted 5.8.0-rc2-xfstests-00060-g37f4a24c2469 #2
[ 1842.791650] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
Sep 10 22:26:22 [ 1842.800070] RIP: 0033:0x7f4f526c5287
[ 1842.805552] Code: Bad RIP value.
[ 1842.809028] RSP: 002b:00007ffd02de72e8 EFLAGS: 00000206 ORIG_RAX: 00000000000000a2
[ 1842.817482] RAX: ffffffffffffffda RBX: 000000000000001d RCX: 00007f4f526c5287
xfstests-ltm-202[ 1842.824896] RDX: 0000000000000000 RSI: 00000000107e85e6 RDI: 000000000000001d
[ 1842.834501] RBP: 0000556a76eed4e0 R08: 000000000000002a R09: 0000556a78579410
[ 1842.841927] R10: fffffffffffff146 R11: 0000000000000206 R12: 00000000000001f4
[ 1842.849331] R13: 0000000051eb851f R14: 00007ffd02de7360 R15: 0000556a76eda2f0
[ 1842.856928] 
[ 1842.856928] Showing all locks held in the system:
[ 1842.863371] 1 lock held by khungtaskd/23:
[ 1842.867539]  #0: ffffffff8de69100 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire.constprop.53+0x0/0x30
00910215247-aa k[ 1842.877502] 6 locks held by kworker/u4:1/77:
ernel: [ 1842.77[ 1842.883403]  #0: ffff8a61183a5d48 ((wq_completion)writeback){+.+.}-{0:0}, at: process_one_work+0x1cf/0x590
[ 1842.895259]  #1: ffffa607419cbe68 ((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}, at: process_one_work+0x1cf/0x590
7020] INFO: task[ 1842.908549]  #2: ffff8a60fc9a30e8 (&type->s_umount_key#36){++++}-{3:3}, at: trylock_super+0x16/0x50
[ 1842.920206]  #3: ffff8a60fc8c0ae8 (&sbi->s_writepages_rwsem){++++}-{0:0}, at: do_writepages+0x41/0xe0
 fsstress:20611 [ 1842.930026]  #4: ffff8a6111fbf8d8 (jbd2_handle){++++}-{0:0}, at: start_this_handle+0x1b2/0x690
[ 1842.941998]  #5: ffff8a60fc35a610 (&ei->i_data_sem){++++}-{3:3}, at: ext4_map_blocks+0xd4/0x640
blocked for more[ 1842.951178] 4 locks held by kworker/u4:3/510:
 than 122 second[ 1842.957297]  #0: ffff8a610f3ce548 ((wq_completion)ext4-rsv-conversion#2){+.+.}-{0:0}, at: process_one_work+0x1cf/0x590
[ 1842.970201]  #1: ffffa6074055be68 ((work_completion)(&ei->i_rsv_conversion_work)){+.+.}-{0:0}, at: process_one_work+0x1cf/0x590
s.
Sep 10 22:26[ 1842.982027]  #2: ffff8a6111fbf8d8 (jbd2_handle){++++}-{0:0}, at: start_this_handle+0x1b2/0x690
[ 1842.994472]  #3: ffff8a60ff80f7d0 (&ei->i_data_sem){++++}-{3:3}, at: ext4_map_blocks+0xd4/0x640
:22 xfstests-ltm[ 1843.003697] 1 lock held by in:imklog/1887:
[ 1843.009383] 5 locks held by rs:main Q:Reg/1888:
-20200910215247-[ 1843.014635] 3 locks held by fsstress/20602:
[ 1843.020470]  #0: ffff8a60fc9a3488 (sb_writers#3){.+.+}-{0:0}, at: vfs_write+0x18b/0x1c0
aa kernel: [ 184[ 1843.028764]  #1: ffff8a6105e53848 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_buffered_write_iter+0x33/0x120
[ 1843.041101]  #2: ffff8a6111fbf8d8 (jbd2_handle){++++}-{0:0}, at: start_this_handle+0x1b2/0x690
2.784641]       [ 1843.050219] 2 locks held by fsstress/20604:
[ 1843.056033]  #0: ffff8a60fc9a30e8 (&type->s_umount_key#36){++++}-{3:3}, at: iterate_supers+0x74/0xf0
Not tainted 5.8.[ 1843.065637]  #1: ffff8a60fc9a3978 (&s->s_sync_lock){+.+.}-{3:3}, at: sync_inodes_sb+0x120/0x480
[ 1843.076050] 1 lock held by fsstress/20605:
[ 1843.080301]  #0: ffff8a60dece9708 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x50b/0x700
0-rc2-xfstests-0[ 1843.090782] 1 lock held by fsstress/20606:
[ 1843.096535]  #0: ffff8a60fe7c1670 (&pipe->mutex/1){+.+.}-{3:3}, at: do_splice+0x509/0x660
0060-g37f4a24c24[ 1843.105309] 2 locks held by fsstress/20607:
[ 1843.111362]  #0: ffff8a60fc9a30e8 (&type->s_umount_key#36){++++}-{3:3}, at: iterate_supers+0x74/0xf0
69 #2
Sep 10 22[ 1843.121495]  #1: ffff8a60fc9a3978 (&s->s_sync_lock){+.+.}-{3:3}, at: sync_inodes_sb+0x120/0x480
[ 1843.131856] 2 locks held by fsstress/20608:
:26:22 xfstests-[ 1843.136214]  #0: ffff8a60fc9a3488 (sb_writers#3){.+.+}-{0:0}, at: vfs_write+0x18b/0x1c0
[ 1843.145943]  #1: ffff8a6111740488 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x2c7/0x700
ltm-202009102152[ 1843.156514] 2 locks held by fsstress/20610:
[ 1843.162313]  #0: ffff8a60fc9a30e8 (&type->s_umount_key#36){++++}-{3:3}, at: iterate_supers+0x74/0xf0
47-aa kernel: [ [ 1843.172161]  #1: ffff8a60fc9a3978 (&s->s_sync_lock){+.+.}-{3:3}, at: sync_inodes_sb+0x120/0x480
[ 1843.182439] 2 locks held by fsstress/20611:
[ 1843.186975]  #0: ffff8a60fc9a30e8 (&type->s_umount_key#36){++++}-{3:3}, at: iterate_supers+0x74/0xf0
1842.791650] "ec[ 1843.196426]  #1: ffff8a60fc9a3978 (&s->s_sync_lock){+.+.}-{3:3}, at: sync_inodes_sb+0x120/0x480
[ 1843.206798] 2 locks held by fsstress/20612:
[ 1843.211146]  #0: ffff8a60fc9a3488 (sb_writers#3){.+.+}-{0:0}, at: vfs_write+0x18b/0x1c0
ho 0 > /proc/sys[ 1843.219359]  #1: ffff8a60fc24d6c8 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x2c7/0x700
[ 1843.232693] 2 locks held by fsstress/20613:
[ 1843.237043]  #0: ffff8a60fc9a3488 (sb_writers#3){.+.+}-{0:0}, at: vfs_write+0x18b/0x1c0
/kernel/hung_tas[ 1843.245394]  #1: ffff8a6100fa69c8 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x50b/0x700
[ 1843.257573] 2 locks held by fsstress/20614:
[ 1843.261909]  #0: ffff8a60fc9a30e8 (&type->s_umount_key#36){++++}-{3:3}, at: iterate_supers+0x74/0xf0
[ 1843.271222]  #1: ffff8a60fc9a3978 (&s->s_sync_lock){+.+.}-{3:3}, at: sync_inodes_sb+0x120/0x480
[ 1843.280216] 2 locks held by fsstress/20616:
k_timeout_secs" [ 1843.284594]  #0: ffff8a60fc9a3488 (sb_writers#3){.+.+}-{0:0}, at: mnt_want_write+0x20/0x50
[ 1843.294701]  #1: ffff8a610bff3508 (&type->i_mutex_dir_key#3){++++}-{3:3}, at: path_openat+0x336/0x980
disables this me[ 1843.304245] 2 locks held by fsstress/20617:
ssage.
Sep 10 2[ 1843.310081]  #0: ffff8a60fc9a30e8 (&type->s_umount_key#36){++++}-{3:3}, at: iterate_supers+0x74/0xf0
[ 1843.321202]  #1: ffff8a60fc9a3978 (&s->s_sync_lock){+.+.}-{3:3}, at: sync_inodes_sb+0x120/0x480
2:26:22 xfstests[ 1843.333613] 2 locks held by fsstress/20618:
[ 1843.339777]  #0: ffff8a60fc9a3488 (sb_writers#3){.+.+}-{0:0}, at: vfs_write+0x18b/0x1c0
-ltm-20200910215[ 1843.348226]  #1: ffff8a610bea0888 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x50b/0x700
[ 1843.360211] 2 locks held by fsstress/20619:
[ 1843.364558]  #0: ffff8a60fc9a30e8 (&type->s_umount_key#36){++++}-{3:3}, at: iterate_supers+0x74/0xf0
247-aa kernel: [[ 1843.373869]  #1: ffff8a60fc9a3978 (&s->s_sync_lock){+.+.}-{3:3}, at: sync_inodes_sb+0x120/0x480
[ 1843.384165] 1 lock held by fsstress/20620:
[ 1843.388424]  #0: ffff8a61117b1188 (&bdev->bd_mutex){+.+.}-{3:3}, at: iterate_bdevs+0x96/0x13f
 1842.799971] fs[ 1843.397134] 1 lock held by fsstress/20621:
[ 1843.402773]  #0: ffff8a6100c8b8c8 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_read_iter+0x11c/0x160
stress        D [ 1843.413537] 
[ 1843.416751] =============================================
[ 1843.416751] 
   0 20611  20601 0x00004000
Sep 10 22:26:22 xfstests-ltm-20200910215247-aa kernel: [ 1842.799979] Call Trace:
Sep 10 22:26:22 xfstests-ltm-20200910215247-aa kernel: [ 1842.799993]  __schedule+0x2cc/0x6e0
Sep 10 22:26:22 xfstests-ltm-20200910215247-aa kernel: [ 1842.800002]  ? sched_clock_cpu+0xc/0xb0
Sep 10 22:26:22 xfstests-ltm-20200910215247-aa kernel: [ 1842.800009]  ? sync_inodes_sb+0x120/0x480
Sep 10 22:26:22 xfstests-ltm-20200910215247-aa kernel: [ 1842.800012]  schedule+0x55/0xd0
Sep 10 22:26:22 xfstests-ltm-20200910215247-aa kernel: [ 1842.800017]  schedule_preempt_disabled+0x11/0x20
Sep 10 22:26:22 xfstests-ltm-20200910215247-aa kernel: [ 1842.800020]  __mutex_lock+0x397/0x9b0
Sep 10 22:26:22 xfstests-ltm-20200910215247-aa kernel: [ 1842.800025]  ? mark_held_locks+0x47/0x70
Sep 10 22:26:22 xfstests-ltm-20200910215247-aa kernel: [ 1842.800031]  ? kvm_sched_clock_read+0x14/0x30
Sep 10 22:26:22 xfstests-ltm-20200910215247-aa kernel: [ 1842.800034]  ? sync_inodes_sb+0x120/0x480
Sep 10 22:26:22 xfstests-ltm-20200910215247-aa kernel: [ 1842.800036]  sync_inodes_sb+0x120/0x480
Sep 10 22:26:22 xfstests-ltm-20200910215247-aa kernel: [ 1842.800042]  ? __ia32_sys_tee+0xc0/0xc0
Sep 10 22:26:22 xfstests-ltm-20200910215247-aa kernel: [ 1842.800047]  iterate_supers+0x8c/0xf0
Sep 10 22:26:22 xfstests-ltm-20200910215247-aa kernel: [ 1842.800051]  ksys_sync+0x40/0xb0
Sep 10 22:26:22 xfstests-ltm-20200910215247-aa kernel: [ 1842.800055]  __do_sys_sync+0xa/0x10
Sep 10 22:26:22 xfstests-ltm-20200910215247-aa kernel: [ 1842.800059]  do_syscall_64+0x56/0xa0
Sep 10 22:26:22 xfstests-ltm-20200910215247-aa kernel: [ 1842.800065]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
Sep 10 22:26:22 xfstests-ltm-20200910215247-aa kernel: [ 1842.800070] RIP: 0033:0x7f4f526c5287
Sep 10 22:26:22 xfstests-ltm-20200910215247-aa kernel: [ 1842.805552] Code: Bad RIP value.
Sep 10 22:26:22 xfstests-ltm-20200910215247-aa kernel: [ 1842.809028] RSP: 002b:00007ffd02de72e8 EFLAGS: 00000206 ORIG_RAX: 00000000000000a2
Sep 10 22:26:22 xfstests-ltm-20200910215247-aa kernel: [ 1842.817482] RAX: ffffffffffffffda RBX: 000000000000001d RCX: 00007f4f526c5287
Sep 10 22:26:22 xfstests-ltm-20200910215247-aa kernel: [ 1842.824896] RDX: 0000000000000000 RSI: 00000000107e85e6 RDI: 000000000000001d
Sep 10 22:26:22 xfstests-ltm-20200910215247-aa kernel: [ 1842.834501] RBP: 0000556a76eed4e0 R08: 000000000000002a R09: 0000556a78579410
Sep 10 22:26:22 xfstests-ltm-20200910215247-aa kernel: [ 1842.841927] R10: fffffffffffff146 R11: 0000000000000206 R12: 00000000000001f4
Sep 10 22:26:22 xfstests-ltm-20200910215247-aa kernel: [ 1842.849331] R13: 0000000051eb851f R14: 00007ffd02de7360 R15: 0000556a76eda2f0
Sep 10 22:26:22 xfstests-ltm-20200910215247-aa kernel: [ 1842.856928] 
Sep 10 22:26:22 xfstests-ltm-20200910215247-aa kernel: [ 1842.856928] Showing all locks held in the system:
Sep 10 22:26:22 xfstests-ltm-20200910215247-aa kernel: [ 1842.863371] 1 lock held by khungtaskd/23:
Sep 10 22:26:22 xfstests-ltm-20200910215247-aa kernel: [ 1842.867539]  #0: ffffffff8de69100 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire.constprop.53+0x0/0x30
Sep 10 22:26:22 xfstests-ltm-20200910215247-aa kernel: [ 1842.877502] 6 locks held by kworker/u4:1/77:
Sep 10 22:26:22 xfstests-ltm-20200910215247-aa kernel: [ 1842.883403]  #0: ffff8a61183a5d48 ((wq_completion)writeback){+.+.}-{0:0}, at: process_one_work+0x1cf/0x590
Sep 10 22:26:22 xfstests-ltm-20200910215247-aa kernel: [ 1842.895259]  #1: ffffa607419cbe68 ((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}, at: process_one_work+0x1cf/0x590
Sep 10 22:26:22 xfstests-ltm-20200910215247-aa kernel: [ 1842.908549]  #2: ffff8a60fc9a30e8 (&type->s_umount_key#36){++++}-{3:3}, at: trylock_super+0x16/0x50
Sep 10 22:26:22 xfstests-ltm-20200910215247-aa kernel: [ 1842.920206]  #3: ffff8a60fc8c0ae8 (&sbi->s_writepages_rwsem){++++}-{0:0}, at: do_writepages+0x41/0xe0
Sep 10 22:26:22 xfstests-ltm-20200910215247-aa kernel: [ 1842.930026]  #4: ffff8a6111fbf8d8 (jbd2_handle){++++}-{0:0}, at: start_this_handle+0x1b2/0x690
Sep 10 22:26:22 xfstests-ltm-20200910215247-aa kernel: [ 1842.941998]  #5: ffff8a60fc35a610 (&ei->i_data_sem){++++}-{3:3}, at: ext4_map_blocks+0xd4/0x640
Sep 10 22:26:22 xfstests-ltm-20200910215247-aa kernel: [ 1842.951178] 4 locks held by kworker/u4:3/510:
Sep 10 22:26:22 xfstests-ltm-20200910215247-aa kernel: [ 1842.957297]  #0: ffff8a610f3ce548 ((wq_completion)ext4-rsv-conversion#2){+.+.}-{0:0}, at: process_one_work+0x1cf/0x590
Sep 10 22:26:22 xfstests-ltm-20200910215247-aa kernel: [ 1842.970201]  #1: ffffa6074055be68 ((work_completion)(&ei->i_rsv_conversion_work)){+.+.}-{0:0}, at: process_one_work+0x1cf/0x590
Sep 10 22:26:22 xfstests-ltm-20200910215247-aa kernel: [ 1842.982027]  #2: ffff8a6111fbf8d8 (jbd2_handle){++++}-{0:0}, at: start_this_handle+0x1b2/0x690
Sep 10 22:26:22 xfstests-ltm-20200910215247-aa kernel: [ 1842.994472]  #3: ffff8a60ff80f7d0 (&ei->i_data_sem){++++}-{3:3}, at: ext4_map_blocks+0xd4/0x640
Sep 10 22:26:22 xfstests-ltm-20200910215247-aa kernel: [ 1843.003697] 1 lock held by in:imklog/1887:
Sep 10 22:26:22 xfstests-ltm-20200910215247-aa kernel: [ 1843.009383] 5 locks held by rs:main Q:Reg/1888:
Sep 10 22:26:22 xfstests-ltm-20200910215247-aa kernel: [ 1843.014635] 3 locks held by fsstress/20602:
Sep 10 22:26:22 xfstests-ltm-20200910215247-aa kernel: [ 1843.020470]  #0: ffff8a60fc9a3488 (sb_writers#3){.+.+}-{0:0}, at: vfs_write+0x18b/0x1c0
Sep 10 22:26:22 xfstests-ltm-20200910215247-aa kernel: [ 1843.028764]  #1: ffff8a6105e53848 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_buffered_write_iter+0x33/0x120
Sep 10 22:26:22 xfstests-ltm-20200910215247-aa kernel: [ 1843.041101]  #2: ffff8a6111fbf8d8 (jbd2_handle){++++}-{0:0}, at: start_this_handle+0x1b2/0x690
Sep 10 22:26:22 xfstests-ltm-20200910215247-aa kernel: [ 1843.050219] 2 locks held by fsstress/20604:
Sep 10 22:26:22 xfstests-ltm-20200910215247-aa kernel: [ 1843.056033]  #0: ffff8a60fc9a30e8 (&type->s_umount_key#36){++++}-{3:3}, at: iterate_supers+0x74/0xf0
Sep 10 22:26:22 xfstests-ltm-20200910215247-aa kernel: [ 1843.065637]  #1: ffff8a60fc9a3978 (&s->s_sync_lock){+.+.}-{3:3}, at: sync_inodes_sb+0x120/0x480
Sep 10 22:26:22 xfstests-ltm-20200910215247-aa kernel: [ 1843.076050] 1 lock held by fsstress/20605:
Sep 10 22:26:22 xfstests-ltm-20200910215247-aa kernel: [ 1843.080301]  #0: ffff8a60dece9708 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x50b/0x700
Sep 10 22:26:22 xfstests-ltm-20200910215247-aa kernel: [ 1843.090782] 1 lock held by fsstress/20606:
Sep 10 22:26:22 xfstests-ltm-20200910215247-aa kernel: [ 1843.096535]  #0: ffff8a60fe7c1670 (&pipe->mutex/1){+.+.}-{3:3}, at: do_splice+0x509/0x660
Sep 10 22:26:22 xfstests-ltm-20200910215247-aa kernel: [ 1843.105309] 2 locks held by fsstress/20607:
Sep 10 22:26:22 xfstests-ltm-20200910215247-aa kernel: [ 1843.111362]  #0: ffff8a60fc9a30e8 (&type->s_umount_key#36){++++}-{3:3}, at: iterate_supers+0x74/0xf0
Sep 10 22:26:22 xfstests-ltm-20200910215247-aa kernel: [ 1843.121495]  #1: ffff8a60fc9a3978 (&s->s_sync_lock){+.+.}-{3:3}, at: sync_inodes_sb+0x120/0x480
Sep 10 22:26:22 xfstests-ltm-20200910215247-aa kernel: [ 1843.131856] 2 locks held by fsstress/20608:
Sep 10 22:26:22 xfstests-ltm-20200910215247-aa kernel: [ 1843.136214]  #0: ffff8a60fc9a3488 (sb_writers#3){.+.+}-{0:0}, at: vfs_write+0x18b/0x1c0
Sep 10 22:26:22 xfstests-ltm-20200910215247-aa kernel: [ 1843.145943]  #1: ffff8a6111740488 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x2c7/0x700
Sep 10 22:26:22 xfstests-ltm-20200910215247-aa kernel: [ 1843.156514] 2 locks held by fsstress/20610:
Sep 10 22:26:22 xfstests-ltm-20200910215247-aa kernel: [ 1843.162313]  #0: ffff8a60fc9a30e8 (&type->s_umount_key#36){++++}-{3:3}, at: iterate_supers+0x74/0xf0
Sep 10 22:26:22 xfstests-ltm-20200910215247-aa kernel: [ 1843.172161]  #1: ffff8a60fc9a3978 (&s->s_sync_lock){+.+.}-{3:3}, at: sync_inodes_sb+0x120/0x480
Sep 10 22:26:22 xfstests-ltm-20200910215247-aa kernel: [ 1843.182439] 2 locks held by fsstress/20611:
Sep 10 22:26:22 xfstests-ltm-20200910215247-aa kernel: [ 1843.186975]  #0: ffff8a60fc9a30e8 (&type->s_umount_key#36){++++}-{3:3}, at: iterate_supers+0x74/0xf0
Sep 10 22:26:22 xfstests-ltm-20200910215247-aa kernel: [ 1843.196426]  #1: ffff8a60fc9a3978 (&s->s_sync_lock){+.+.}-{3:3}, at: sync_inodes_sb+0x120/0x480
Sep 10 22:26:22 xfstests-ltm-20200910215247-aa kernel: [ 1843.206798] 2 locks held by fsstress/20612:
Sep 10 22:26:22 xfstests-ltm-20200910215247-aa kernel: [ 1843.211146]  #0: ffff8a60fc9a3488 (sb_writers#3){.+.+}-{0:0}, at: vfs_write+0x18b/0x1c0
Sep 10 22:26:22 xfstests-ltm-20200910215247-aa kernel: [ 1843.219359]  #1: ffff8a60fc24d6c8 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x2c7/0x700
Sep 10 22:26:22 xfstests-ltm-20200910215247-aa kernel: [ 1843.232693] 2 locks held by fsstress/20613:
Sep 10 22:26:22 xfstests-ltm-20200910215247-aa kernel: [ 1843.237043]  #0: ffff8a60fc9a3488 (sb_writers#3){.+.+}-{0:0}, at: vfs_write+0x18b/0x1c0
Sep 10 22:26:22 xfstests-ltm-20200910215247-aa kernel: [ 1843.245394]  #1: ffff8a6100fa69c8 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x50b/0x700
Sep 10 22:26:22 xfstests-ltm-20200910215247-aa kernel: [ 1843.257573] 2 locks held by fsstress/20614:
Sep 10 22:26:22 xfstests-ltm-20200910215247-aa kernel: [ 1843.261909]  #0: ffff8a60fc9a30e8 (&type->s_umount_key#36){++++}-{3:3}, at: iterate_supers+0x74/0xf0
Sep 10 22:26:22 xfstests-ltm-20200910215247-aa kernel: [ 1843.271222]  #1: ffff8a60fc9a3978 (&s->s_sync_lock){+.+.}-{3:3}, at: sync_inodes_sb+0x120/0x480
Sep 10 22:26:22 xfstests-ltm-20200910215247-aa kernel: [ 1843.280216] 2 locks held by fsstress/20616:
Sep 10 22:26:22 xfstests-ltm-20200910215247-aa kernel: [ 1843.284594]  #0: ffff8a60fc9a3488 (sb_writers#3){.+.+}-{0:0}, at: mnt_want_write+0x20/0x50
Sep 10 22:26:22 xfstests-ltm-20200910215247-aa kernel: [ 1843.294701]  #1: ffff8a610bff3508 (&type->i_mutex_dir_key#3){++++}-{3:3}, at: path_openat+0x336/0x980
Sep 10 22:26:22 xfstests-ltm-20200910215247-aa kernel: [ 1843.304245] 2 locks held by fsstress/20617:
Sep 10 22:26:22 xfstests-ltm-20200910215247-aa kernel: [ 1843.310081]  #0: ffff8a60fc9a30e8 (&type->s_umount_key#36){++++}-{3:3}, at: iterate_supers+0x74/0xf0
Sep 10 22:26:22 xfstests-ltm-20200910215247-aa kernel: [ 1843.321202]  #1: ffff8a60fc9a3978 (&s->s_sync_lock){+.+.}-{3:3}, at: sync_inodes_sb+0x120/0x480
Sep 10 22:26:22 xfstests-ltm-20200910215247-aa kernel: [ 1843.333613] 2 locks held by fsstress/20618:
Sep 10 22:26:22 xfstests-ltm-20200910215247-aa kernel: [ 1843.339777]  #0: ffff8a60fc9a3488 (sb_writers#3){.+.+}-{0:0}, at: vfs_write+0x18b/0x1c0
Sep 10 22:26:22 xfstests-ltm-20200910215247-aa kernel: [ 1843.348226]  #1: ffff8a610bea0888 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_write_iter+0x50b/0x700
Sep 10 22:26:22 xfstests-ltm-20200910215247-aa kernel: [ 1843.360211] 2 locks held by fsstress/20619:
Sep 10 22:26:22 xfstests-ltm-20200910215247-aa kernel: [ 1843.364558]  #0: ffff8a60fc9a30e8 (&type->s_umount_key#36){++++}-{3:3}, at: iterate_supers+0x74/0xf0
Sep 10 22:26:22 xfstests-ltm-20200910215247-aa kernel: [ 1843.373869]  #1: ffff8a60fc9a3978 (&s->s_sync_lock){+.+.}-{3:3}, at: sync_inodes_sb+0x120/0x480
Sep 10 22:26:22 xfstests-ltm-20200910215247-aa kernel: [ 1843.384165] 1 lock held by fsstress/20620:
Sep 10 22:26:22 xfstests-ltm-20200910215247-aa kernel: [ 1843.388424]  #0: ffff8a61117b1188 (&bdev->bd_mutex){+.+.}-{3:3}, at: iterate_bdevs+0x96/0x13f
Sep 10 22:26:22 xfstests-ltm-20200910215247-aa kernel: [ 1843.397134] 1 lock held by fsstress/20621:
Sep 10 22:26:22 xfstests-ltm-20200910215247-aa kernel: [ 1843.402773]  #0: ffff8a6100c8b8c8 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: ext4_file_read_iter+0x11c/0x160
Sep 10 22:26:22 xfstests-ltm-20200910215247-aa kernel: [ 1843.413537] 
Sep 10 22:26:22 xfstests-ltm-20200910215247-aa kernel: [ 1843.416751] =============================================
Sep 10 22:26:22 xfstests-ltm-20200910215247-aa kernel: [ 1843.416751]

========================================================================

[3] stack trace from my attempted manual revert of 37f4a24c2469

[ 2738.659707] BUG: unable to handle page fault for address: ffff8d7c2825e59e
[ 2738.666740] #PF: supervisor write access in kernel mode
[ 2738.672172] #PF: error_code(0x0002) - not-present page
[ 2738.677424] PGD 23fe01067 P4D 23fe01067 PUD 1dffff067 PMD 0 
[ 2738.683217] Oops: 0002 [#1] SMP PTI
[ 2738.686822] CPU: 1 PID: 15400 Comm: kworker/1:0 Not tainted 5.9.0-rc1-xfstests-13682-g6a184ca6da62 #1
[ 2738.696238] Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
[ 2738.705571] Workqueue: events free_work
[ 2738.709638] RIP: 0010:free_block+0x157/0x270
[ 2738.714029] Code: b6 4c 24 1c 48 c1 ee 20 29 f0 d3 e8 41 0f b6 4c 24 1d 01 f0 49 8b 76 20 d3 e8 8d 4f ff 48 85 f6 41 89 4e 30 0f 84 01 01 00 00 <88> 04 0e 41 8b 46 30 85 c0 0f 84 ed fe ff ff 4d 8b 6f 50 4d 8d 4f
[ 2738.732911] RSP: 0018:ffff9131052d7ad0 EFLAGS: 00010046
[ 2738.738253] RAX: 000000000000002d RBX: ffffb130ffc00bd8 RCX: 00000000fffffffe
[ 2738.745492] RDX: ffffbc1444a09788 RSI: ffff8d7b2825e5a0 RDI: 00000000ffffffff
[ 2738.752733] RBP: ffffbc1444a09788 R08: ffffbc1444a09780 R09: ffff8d7bd80421c8
[ 2738.759973] R10: 0000000000000001 R11: 00000000ffffffff R12: ffff8d7bd80410c0
[ 2738.767379] R13: ffff8d7b2825e5a0 R14: ffffbc1444a09780 R15: ffff8d7bd8042180
[ 2738.774624] FS:  0000000000000000(0000) GS:ffff8d7bd9200000(0000) knlGS:0000000000000000
[ 2738.783005] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 2738.788867] CR2: ffff8d7c2825e59e CR3: 000000023e212004 CR4: 00000000001706e0
[ 2738.796125] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 2738.803467] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 2738.810798] Call Trace:
[ 2738.813359]  ___cache_free+0x49a/0x6a0
[ 2738.817218]  kfree+0xc9/0x1d0
[ 2738.820294]  kmem_freepages+0xa0/0xf0
[ 2738.824063]  slab_destroy+0x19/0x50
[ 2738.827660]  slabs_destroy+0x6d/0x90
[ 2738.831345]  ___cache_free+0x4b6/0x6a0
[ 2738.835200]  kfree+0xc9/0x1d0
[ 2738.838275]  kmem_freepages+0xa0/0xf0
[ 2738.842045]  slab_destroy+0x19/0x50
[ 2738.845651]  slabs_destroy+0x6d/0x90
[ 2738.849347]  ___cache_free+0x4b6/0x6a0
[ 2738.853229]  ? sched_clock_cpu+0xc/0xb0
[ 2738.857177]  kfree+0xc9/0x1d0
[ 2738.860254]  __vunmap+0x1e0/0x230
[ 2738.863680]  free_work+0x21/0x30
[ 2738.867035]  process_one_work+0x250/0x590
[ 2738.871158]  ? worker_thread+0xcf/0x390
[ 2738.875119]  ? process_one_work+0x590/0x590
[ 2738.880191]  worker_thread+0x3d/0x390
[ 2738.883965]  ? process_one_work+0x590/0x590
[ 2738.888256]  kthread+0x136/0x150
[ 2738.891681]  ? __kthread_queue_delayed_work+0x90/0x90
[ 2738.897105]  ret_from_fork+0x22/0x30
[ 2738.900868] CR2: ffff8d7c2825e59e
[ 2738.904297] ---[ end trace 6b0889ea3014c11b ]---



