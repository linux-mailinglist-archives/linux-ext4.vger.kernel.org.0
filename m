Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDD9226CAFE
	for <lists+linux-ext4@lfdr.de>; Wed, 16 Sep 2020 22:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbgIPUUw (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 16 Sep 2020 16:20:52 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:48014 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727658AbgIPUUm (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 16 Sep 2020 16:20:42 -0400
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 08GKKR1g004583
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Sep 2020 16:20:27 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id E533C42004D; Wed, 16 Sep 2020 16:20:26 -0400 (EDT)
Date:   Wed, 16 Sep 2020 16:20:26 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-ext4@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-block@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: REGRESSION: 37f4a24c2469: blk-mq: centralise related handling
 into blk_mq_get_driver_tag
Message-ID: <20200916202026.GC38283@mit.edu>
References: <aff250ad-4c31-15c2-fa1d-3f3945cb7aa5@kernel.dk>
 <7f0e2d99-5da2-237e-a894-0afddc0ace1e@kernel.dk>
 <049a97db-c362-bcfb-59e5-4b1d2df59383@kernel.dk>
 <5140ba6c-779c-2a71-b7f2-3c3220cdf19c@kernel.dk>
 <68510957-c887-8e26-4a1a-a7a93488586a@kernel.dk>
 <20200904035528.GE558530@mit.edu>
 <20200915044519.GA38283@mit.edu>
 <20200915073303.GA754106@T590>
 <20200915224541.GB38283@mit.edu>
 <20200915230941.GA791425@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200915230941.GA791425@T590>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Sep 16, 2020 at 07:09:41AM +0800, Ming Lei wrote:
> > The problem is it's a bit tricky to revert 568f27006577, since there
> > is a merge conflict in blk_kick_flush().  I attempted to do the bisect
> > manually here, but it's clearly not right since the kernel is not
> > booting after the revert:
> > 
> > https://github.com/tytso/ext4/commit/1e67516382a33da2c9d483b860ac4ec2ad390870
> > 
> > branch:
> > 
> > https://github.com/tytso/ext4/tree/manual-revert-of-568f27006577
> > 
> > Can you send me a patch which correctly reverts 568f27006577?  I can
> > try it against -rc1 .. -rc4, whichever is most convenient.
> 
> Please test the following revert patch against -rc4.

Unfortunately the results of the revert is... wierd.

With -rc4, *all* of the VM's are failing --- reliably.  With rc4 with
the revert, *some* of the VM's are able to complete the tests, but
over half are still locking up or failing with some kind of oops.  So
that seems to imply that there is some kind of timing issue going on,
or maybe there are multiple bugs in play?

So let's review the bidding.   We're going to review four commits:

7bf137298cb7: (Parent of 568f27006577)  Completely clean, all VM's complete the tests

568f27006577: Fails reliably.  In 9 of the 11 VM's there is nothing on
	the console; the I/O is just stopped.  If I've been able to
	get to the VM before it gets killed from the timeout, ssh
	works, but any attempt do any I/O will hang, which presumably
	explains why the tests are hanging.  In the other two VM's
	there are a hung task timeouts, with stack traces that look
	like this...

v5.9-rc4: More than half of the VM's are failing --- but at least some are succeeding,
	which is more than can be said for 568f27006577.  There is a
	*variety* of different sort of failures.  So the fact that
	we're not seeing the silent hangs in -rc4 is... interesting....


v5.9-rc4 with the revert of 568f27006577: we're seeing a similar
	number of VM failures, but the failure signature is different.
	The most common failure is...

(More details below, with the stack traces.)

I really don't know what to make of this.  It looks like there's
something going on in the block layer, based the fact that
568f27006577 fails reliably, but its predecssor is completely clean.
But then things have changed significantly by the time we get to -rc4.
I'll do a more in-depth analysis of -rc1 to see if the failure
patterns are more similar to 568f27006577 than -rc4.  But hopefully
you can see something that I'm missing?

Thanks,

						- Ted

---------------------------


7bf137298cb7: (Parent of 568f27006577)  Completely clean, all VM's complete the tests

---------------------------

568f27006577: Fails reliably.  In 9 of the 11 VM's there is nothing on
	the console; the I/O is just stopped.  If I've been able to
	get to the VM before it gets killed from the timeout, ssh
	works, but any attempt do any I/O will hang, which presumably
	explains why the tests are hanging.  In the other two VM's
	there are a hung task timeouts, with stack traces that look
	like this:

	[14375.634282] INFO: task jbd2/sda1-8:116 blocked for more than 122 seconds.
	[14375.641679]      Not tainted 5.8.0-rc2-xfstests-30545-g568f27006577 #6
	[14375.648517] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
	[14375.656523] jbd2/sda1-8     D    0   116      2 0x00004000
	[14375.656530] Call Trace:
	[14375.656548]  __schedule+0x2cc/0x6e0
	[14375.656695]  ? sched_clock_cpu+0xc/0xb0
	[14375.656699]  schedule+0x55/0xd0
	[14375.656702]  io_schedule+0x12/0x40
	[14375.656708]  blk_mq_get_tag+0x11e/0x280
	[14375.656715]  ? __wake_up_common_lock+0xc0/0xc0
	[14375.656719]  __blk_mq_alloc_request+0xb6/0x100
	[14375.656722]  blk_mq_submit_bio+0x13f/0x7d0
	[14375.656727]  ? blk_queue_enter+0x15c/0x510
	[14375.656731]  submit_bio_noacct+0x48d/0x500
	[14375.656737]  ? kvm_sched_clock_read+0x14/0x30
	[14375.656740]  ? submit_bio+0x42/0x150
	[14375.656744]  submit_bio+0x42/0x150
	[14375.656748]  ? guard_bio_eod+0x90/0x140
	[14375.656754]  submit_bh_wbc+0x16d/0x190
	[14375.656761]  jbd2_journal_commit_transaction+0x70d/0x1f23
	[14375.656767]  ? kjournald2+0x128/0x3b0
	[14375.656771]  kjournald2+0x128/0x3b0
	[14375.656777]  ? trace_hardirqs_on+0x1c/0xf0
	[14375.656781]  ? __wake_up_common_lock+0xc0/0xc0
	[14375.656785]  ? __jbd2_debug+0x50/0x50
	[14375.656788]  kthread+0x136/0x150
	[14375.656792]  ? __kthread_queue_delayed_work+0x90/0x90
	[14375.656796]  ret_from_fork+0x22/0x30

---------------------------

v5.9-rc4: More than half of the VM's are failing --- but at least some are succeeding,
	which is more than can be said for 568f27006577.  There is a
	*variety* of different sort of failures.  So the fact that
	we're not seeing the silent hangs in -rc4 is... interesting.

	Instead, the most common is this kind of failure inside kfree():

	[ 5059.977824] #PF: supervisor write access in kernel mode
	[ 5059.983383] #PF: error_code(0x0002) - not-present page
	[ 5059.988823] PGD 23fe01067 P4D 23fe01067 PUD 0 
	[ 5059.993568] Oops: 0002 [#1] SMP PTI
	[ 5059.997180] CPU: 1 PID: 25689 Comm: umount Not tainted 5.9.0-rc4-xfstests #4
	[ 5060.004542] Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
	[ 5060.014107] RIP: 0010:free_block+0x157/0x270
	[ 5060.053458] RDX: fffff2bd4627ab08 RSI: ffff9f38c9eacf84 RDI: 0000000000000000
	[ 5060.020313] Code: b6 4c 24 1c 48 c1 ee 20 29 f0 d3 e8 41 0f b6 4c 24 1d 01 f0 49 8b 76 20 d3 e8 8d 4f ff 48 85 f6 41 89 4e 30 0f 84 01 01 00 00 <88> 04 0e 41 8b 46 30 85 c0 0f 84 ed fe ff ff 4d 8b 6f 50 4d 8d 4f
	[ 5060.040316] RSP: 0018:ffffa27b47017b38 EFLAGS: 00010086
	[ 5060.045897] RAX: 0000000000000050 RBX: ffffc27b3fc00b90 RCX: 00000000ffffffff
	[ 5060.062293] RBP: fffff2bd4627ab08 R08: fffff2bd4627ab00 R09: ffff9f39180421c8
	[ 5060.069662] R10: ffff9f38f9765480 R11: 0000000000000046 R12: ffff9f39180410c0
	[ 5060.077417] R13: ffff9f38c9eaca00 R14: fffff2bd4627ab00 R15: ffff9f3918042180
	[ 5060.084682] FS:  00007f0a2e49e080(0000) GS:ffff9f3919200000(0000) knlGS:0000000000000000
	[ 5060.092985] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
	[ 5060.099075] CR2: ffff9f39c9eacf83 CR3: 00000001bec2e005 CR4: 00000000003706e0
	[ 5060.106650] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
	[ 5060.114329] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
	[ 5060.121657] Call Trace:
	[ 5060.124412]  ___cache_free+0x488/0x6b0
	[ 5060.128666]  kfree+0xc9/0x1d0
	[ 5060.131947]  kmem_freepages+0xa0/0xf0
	[ 5060.135746]  slab_destroy+0x19/0x50
	[ 5060.139577]  slabs_destroy+0x6d/0x90
	[ 5060.143379]  ___cache_free+0x4a3/0x6b0
	[ 5060.147896]  kfree+0xc9/0x1d0
	[ 5060.151082]  kmem_freepages+0xa0/0xf0
	[ 5060.155121]  slab_destroy+0x19/0x50
	[ 5060.159028]  slabs_destroy+0x6d/0x90
	[ 5060.162920]  ___cache_free+0x4a3/0x6b0
	[ 5060.167097]  kfree+0xc9/0x1d0
	[ 5060.170446]  memcg_destroy_list_lru_node.isra.8+0x37/0x50
	[ 5060.177401]  list_lru_destroy+0xc6/0xf0
	[ 5060.181630]  deactivate_locked_super+0x47/0x70
	[ 5060.187738]  cleanup_mnt+0xb8/0x140
	[ 5060.192911]  task_work_run+0x73/0xc0
	[ 5060.198649]  exit_to_user_mode_prepare+0x197/0x1a0
	[ 5060.204002]  syscall_exit_to_user_mode+0x3c/0x210
	[ 5060.209012]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
	[ 5060.214438] RIP: 0033:0x7f0a2e8c4507
	[ 5060.218366] Code: 19 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 0f 1f 44 00 00 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 59 19 0c 00 f7 d8 64 89 01 48
	[ 5060.237504] RSP: 002b:00007ffc19305098 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
	[ 5060.245186] RAX: 0000000000000000 RBX: 000055c4bc302970 RCX: 00007f0a2e8c4507
	[ 5060.252454] RDX: 0000000000000001 RSI: 0000000000000000 RDI: 000055c4bc306ce0
	[ 5060.259790] RBP: 0000000000000000 R08: 000055c4bc306d00 R09: 00007f0a2e945e80
	[ 5060.267037] R10: 0000000000000000 R11: 0000000000000246 R12: 000055c4bc306ce0
	[ 5060.274734] R13: 00007f0a2e9ea1c4 R14: 000055c4bc302a68 R15: 000055c4bc302b80
	[ 5060.282036] CR2: ffff9f39c9eacf83
	[ 5060.285485] ---[ end trace c24e82a07e154b54 ]---

	In a few cases, we are dying before tests are even started.

	[   28.529981] watchdog: BUG: soft lockup - CPU#1 stuck for 22s! [swapper/1:0]
	[   28.529981] irq event stamp: 4611485
	[   28.529981] hardirqs last  enabled at (4611484): [<ffffffff83600b9e>] asm_common_interrupt+0x1e/0x40
	[   28.529981] hardirqs last disabled at (4611485): [<ffffffff8358eaaa>] sysvec_apic_timer_interrupt+0xa/0x90
	[   28.529981] softirqs last  enabled at (2902): [<ffffffff82abad1d>] irq_enter_rcu+0x6d/0x70
	[   28.529981] softirqs last disabled at (2903): [<ffffffff83600f72>] asm_call_on_stack+0x12/0x20
	[   28.529981] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 5.9.0-rc4-xfstests #4
	[   28.529981] Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
	[   28.529981] RIP: 0010:__do_softirq+0xa8/0x45f
	[   28.529981] Code: 00 00 01 c7 44 24 1c 0a 00 00 00 45 89 e6 48 c7 c0 00 ad 1e 00 65 66 c7 00 00 00 e8 32 a5 3a ff fb 48 c7 44 24 08 40 51 e0 83 <b8> ff ff ff ff 41 0f bc c6 83 c0 01 89 04 24 0f 84 d7 01 00 00 44
	[   28.529981] RSP: 0000:ffff9c57c00e0f98 EFLAGS: 00000202
	[   28.529981] RAX: 0000000000000b58 RBX: ffff9c57c00abd88 RCX: 0000000000000b56
	[   28.529981] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffff8380009e
	[   28.529981] RBP: ffff9c57c00abd50 R08: 0000000000000001 R09: 0000000000000001
	[   28.529981] R10: 0000000000000001 R11: 0000000000000046 R12: 0000000000000080
	[   28.529981] R13: 0000000000000000 R14: 0000000000000080 R15: 0000000000000000
	[   28.529981] FS:  0000000000000000(0000) GS:ffff92fc59200000(0000) knlGS:0000000000000000
	[   28.529981] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
	[   28.529981] CR2: 0000000000000000 CR3: 000000023e212001 CR4: 00000000001706e0
	[   28.529981] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
	[   28.529981] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
	[   28.529981] Call Trace:
	[   28.529981]  <IRQ>
	[   28.529981]  asm_call_on_stack+0x12/0x20
	[   28.529981]  </IRQ>
	[   28.529981]  do_softirq_own_stack+0x52/0x60
	[   28.529981]  irq_exit_rcu+0xae/0xb0
	[   28.529981]  sysvec_call_function_single+0x41/0x90
	[   28.529981]  asm_sysvec_call_function_single+0x12/0x20
	[   28.529981] RIP: 0010:acpi_safe_halt.part.13+0x18/0x30
	[   28.529981] Code: a2 00 01 e8 a8 5e 58 ff e9 c3 fe ff ff cc cc cc cc cc 0f 1f 44 00 00 e8 b6 08 61 ff e9 07 00 00 00 0f 00 2d d4 24 54 00 fb f4 <9c> 58 fa f6 c4 02 75 01 c3 e9 7a 0a 61 ff 66 2e 0f 1f 84 00 00 00
	[   28.529981] RSP: 0000:ffff9c57c00abe38 EFLAGS: 00000206
	[   28.529981] RAX: 0000000000000aff RBX: ffff92fc579b0000 RCX: 0000000000000034
	[   28.529981] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffff83599d1a
	[   28.529981] RBP: ffff92fc579b0064 R08: 0000000000000001 R09: 0000000000000001
	[   28.529981] R10: ffff92fc593ea744 R11: ffff92fc593ea724 R12: 0000000000000001
	[   28.529981] R13: 0000000000000001 R14: 0000000000000001 R15: 0000000000000000
	[   28.529981]  ? acpi_safe_halt.part.13+0xa/0x30
	[   28.529981]  ? acpi_safe_halt.part.13+0xa/0x30
	[   28.529981]  acpi_idle_enter+0xea/0x2b0
	[   28.529981]  ? rcu_read_lock_sched_held+0x52/0x80
	[   28.529981]  cpuidle_enter_state+0x96/0x460
	[   28.529981]  cpuidle_enter+0x29/0x40
	[   28.529981]  do_idle+0x1c2/0x200
	[   28.529981]  cpu_startup_entry+0x19/0x20
	[   28.529981]  start_secondary+0x116/0x150
	[   28.529981]  secondary_startup_64+0xb6/0xc0

---------------------------

v5.9-rc4 with the revert of 568f27006577: we're seeing a similar
	number of VM failures, but the failure signature is different.
	The most common failure is:

	[  390.023691] ------------[ cut here ]------------
	[  390.028614] list_del corruption, ffffe1c241b00408->next is LIST_POISON1 (dead000000000100)
	[  390.037040] WARNING: CPU: 1 PID: 5948 at lib/list_debug.c:47 __list_del_entry_valid+0x4e/0x90
	[  390.045684] CPU: 1 PID: 5948 Comm: umount Not tainted 5.9.0-rc4-xfstests-00001-g6fdef015feba #11
	[  390.054581] Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
	[  390.063943] RIP: 0010:__list_del_entry_valid+0x4e/0x90
	[  390.069731] Code: 2e 48 8b 32 48 39 fe 75 3a 48 8b 50 08 48 39 f2 75 48 b8 01 00 00 00 c3 48 89 fe 48 89 c2 48 c7 c7 10 13 12 9b e8 30 2f 8c ff <0f> 0b 31 c0 c3 48 89 fe 48 c7 c7 48 13 12 9b e8 1c 2f 8c ff 0f 0b
	[  390.088615] RSP: 0018:ffffae95c6ddba28 EFLAGS: 00010082
	[  390.094079] RAX: 0000000000000000 RBX: ffffce95bfc007d0 RCX: 0000000000000027
	[  390.101338] RDX: 0000000000000027 RSI: ffffa0c9d93d7dc0 RDI: ffffa0c9d93d7dc8
	[  390.108659] RBP: ffffe1c241b00408 R08: 0000006ba6bff7dc R09: 0000000000000000
	[  390.115925] R10: ffffa0c9d3f444c0 R11: 0000000000000046 R12: ffffa0c9d8041180
	[  390.123186] R13: ffffa0c86c010e00 R14: ffffe1c241b00400 R15: ffffa0c9d8042240
	[  390.130637] FS:  00007fb227580080(0000) GS:ffffa0c9d9200000(0000) knlGS:0000000000000000
	[  390.138860] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
	[  390.144721] CR2: 00007ff72d2dfe74 CR3: 00000001cdbb8002 CR4: 00000000003706e0
	[  390.152022] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
	[  390.159314] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
	[  390.166569] Call Trace:
	[  390.169148]  free_block+0xec/0x270
	[  390.173100]  ___cache_free+0x488/0x6b0
	[  390.177062]  kfree+0xc9/0x1d0
	[  390.181202]  kmem_freepages+0xa0/0xf0
	[  390.185009]  slab_destroy+0x19/0x50
	[  390.188653]  slabs_destroy+0x6d/0x90
	[  390.192339]  ___cache_free+0x4a3/0x6b0
	[  390.196477]  kfree+0xc9/0x1d0
	[  390.199651]  kmem_freepages+0xa0/0xf0
	[  390.203459]  slab_destroy+0x19/0x50
	[  390.207060]  slabs_destroy+0x6d/0x90
	[  390.210784]  ___cache_free+0x4a3/0x6b0
	[  390.214672]  ? lockdep_hardirqs_on_prepare+0xe7/0x180
	[  390.219845]  kfree+0xc9/0x1d0
	[  390.222928]  put_crypt_info+0xe3/0x100
	[  390.226801]  fscrypt_put_encryption_info+0x15/0x30
	[  390.231721]  ext4_clear_inode+0x80/0x90
	[  390.235774]  ext4_evict_inode+0x6d/0x630
	[  390.239960]  evict+0xd0/0x1a0
	[  390.243049]  dispose_list+0x51/0x80
	[  390.246659]  evict_inodes+0x15b/0x1b0
	[  390.250526]  generic_shutdown_super+0x37/0x100
	[  390.255094]  kill_block_super+0x21/0x50
	[  390.259066]  deactivate_locked_super+0x2f/0x70
	[  390.263638]  cleanup_mnt+0xb8/0x140
	[  390.267248]  task_work_run+0x73/0xc0
	[  390.270953]  exit_to_user_mode_prepare+0x197/0x1a0
	[  390.277333]  syscall_exit_to_user_mode+0x3c/0x210
	[  390.282171]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
	[  390.287348] RIP: 0033:0x7fb2279a6507
	[  390.291128] Code: 19 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 0f 1f 44 00 00 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 59 19 0c 00 f7 d8 64 89 01 48
	[  390.310018] RSP: 002b:00007ffd41391c08 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
	[  390.317711] RAX: 0000000000000000 RBX: 000055b889e1f970 RCX: 00007fb2279a6507
	[  390.324969] RDX: 0000000000000001 RSI: 0000000000000000 RDI: 000055b889e24f00
	[  390.332300] RBP: 0000000000000000 R08: 000055b889e24f20 R09: 00007fb227a27e80
	[  390.339543] R10: 0000000000000000 R11: 0000000000000246 R12: 000055b889e24f00
	[  390.346818] R13: 00007fb227acc1c4 R14: 000055b889e1fa68 R15: 000055b889e1fb80
	[  390.354075] irq event stamp: 3176310
	[  390.357762] hardirqs last  enabled at (3176309): [<ffffffff9a090df2>] kfree+0x132/0x1d0
	[  390.365891] hardirqs last disabled at (3176310): [<ffffffff9a090df9>] kfree+0x139/0x1d0
	[  390.374021] softirqs last  enabled at (3174992): [<ffffffff9ac00347>] __do_softirq+0x347/0x45f
	[  390.382762] softirqs last disabled at (3174535): [<ffffffff9aa00f72>] asm_call_on_stack+0x12/0x20
	[  390.391742] ---[ end trace 8fb872d4de3e00ed ]---

	There was one silent hang with no console output to explain
	why.  (We started running generic/038 and there was nothing
	else after the file systems got mounted).

	There was also a free related crash in one of 

	[ 3100.368026] #PF: supervisor write access in kernel mode
	[ 3100.373369] #PF: error_code(0x0002) - not-present page
	[ 3100.378623] PGD 23fe01067 P4D 23fe01067 PUD 0 
	[ 3100.384588] Oops: 0002 [#1] SMP PTI
	[ 3100.388194] CPU: 1 PID: 1243 Comm: umount Not tainted 5.9.0-rc4-xfstests-00001-g6fdef015feba #11
	[ 3100.397096] Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
	[ 3100.406541] RIP: 0010:free_block+0x157/0x270
	[ 3100.412216] Code: b6 4c 24 1c 48 c1 ee 20 29 f0 d3 e8 41 0f b6 4c 24 1d 01 f0 49 8b 76 20 d3 e8 8d 4f ff 48 85 f6 41 89 4e 30 0f 84 01 01 00 00 <88> 04 0e 41 8b 46 30 85 c0 0f 84 ed fe ff ff 4d 8b 6f 50 4d 8d 4f
	[ 3100.431141] RSP: 0018:ffffa4dbc66a7b38 EFLAGS: 00010086
	[ 3100.436481] RAX: 0000000000000039 RBX: ffffc4dbbfc00c78 RCX: 00000000ffffffff
	[ 3100.443730] RDX: ffffef9a86cd78c8 RSI: ffff9b5e335e3f84 RDI: 0000000000000000
	[ 3100.450982] RBP: ffffef9a86cd78c8 R08: ffffef9a86cd78c0 R09: ffff9b5e580421c8
	[ 3100.458237] R10: ffff9b5e50989540 R11: 0000000000000046 R12: ffff9b5e580410c0
	[ 3100.465658] R13: ffff9b5e335e3720 R14: ffffef9a86cd78c0 R15: ffff9b5e58042180
	[ 3100.472911] FS:  00007f391da87080(0000) GS:ffff9b5e59200000(0000) knlGS:0000000000000000
	[ 3100.481117] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
	[ 3100.486979] CR2: ffff9b5f335e3f83 CR3: 00000001d479c005 CR4: 00000000003706e0
	[ 3100.494232] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
	[ 3100.501488] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
	[ 3100.508748] Call Trace:
	[ 3100.511313]  ___cache_free+0x488/0x6b0
	[ 3100.515183]  kfree+0xc9/0x1d0
	[ 3100.519566]  kmem_freepages+0xa0/0xf0
	[ 3100.523341]  slab_destroy+0x19/0x50
	[ 3100.526945]  slabs_destroy+0x6d/0x90
	[ 3100.530635]  ___cache_free+0x4a3/0x6b0
	[ 3100.534506]  kfree+0xc9/0x1d0
	[ 3100.537594]  kmem_freepages+0xa0/0xf0
	[ 3100.541564]  slab_destroy+0x19/0x50
	[ 3100.545341]  slabs_destroy+0x6d/0x90
	[ 3100.549030]  ___cache_free+0x4a3/0x6b0
	[ 3100.552905]  kfree+0xc9/0x1d0
	.
	[ 3100.556112]  memcg_destroy_list_lru_node.isra.8+0x37/0x50
	[ 3100.562905]  list_lru_destroy+0xc6/0xf0
	[ 3100.566906]  deactivate_locked_super+0x47/0x70
	[ 3100.572859]  cleanup_mnt+0xb8/0x140
	[ 3100.577995]  task_work_run+0x73/0xc0
	[ 3100.583086]  exit_to_user_mode_prepare+0x197/0x1a0
	[ 3100.589363]  syscall_exit_to_user_mode+0x3c/0x210
	[ 3100.595560]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
	[ 3100.602117] RIP: 0033:0x7f391dead507
	[ 3100.605809] Code: 19 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 0f 1f 44 00 00 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 59 19 0c 00 f7 d8 64 89 01 48
	[ 3100.624691] RSP: 002b:00007ffd66365c28 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
	[ 3100.632483] RAX: 0000000000000000 RBX: 000055eca5bc4970 RCX: 00007f391dead507
	[ 3100.639801] RDX: 0000000000000001 RSI: 0000000000000000 RDI: 000055eca5bc4b80
	[ 3100.647063] RBP: 0000000000000000 R08: 000055eca5bc4ba0 R09: 00007f391df2ee80
	[ 3100.654401] R10: 0000000000000000 R11: 0000000000000246 R12: 000055eca5bc4b80
	[ 3100.661648] R13: 00007f391dfd31c4 R14: 000055eca5bc4a68 R15: 0000000000000000
	[ 3100.668957] CR2: ffff9b5f335e3f83
	[ 3100.673815] ---[ end trace 2853d4dd454a6a2e ]---
