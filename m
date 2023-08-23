Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF867785C7E
	for <lists+linux-ext4@lfdr.de>; Wed, 23 Aug 2023 17:49:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232155AbjHWPtv (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 23 Aug 2023 11:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233210AbjHWPtv (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 23 Aug 2023 11:49:51 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DFA1CD1
        for <linux-ext4@vger.kernel.org>; Wed, 23 Aug 2023 08:49:47 -0700 (PDT)
Received: from letrec.thunk.org (c-73-8-226-230.hsd1.il.comcast.net [73.8.226.230])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 37NFnGpj004223
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Aug 2023 11:49:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1692805760; bh=qTYD7JMLwbxBnDTz9dx1iI/6wZjEWTaXAF4uOGIbexU=;
        h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
        b=KQjU0jSe63g1fdGhf8ZPlZqhdnsZKNswKfARgtcP7cEDcpJ1yL3OpZEGKVnlNQSLj
         9WkNrgTvzmQqAa97NwJovVnpHr04fFmckggRk61dNpMxI1yNETHT/qBxKVtvuGeGVP
         00n+nwCG/iaaMJy3XkbQRNHghafQlHLM0IRqJU4rs8c8O9gaZDYGKzJYcM87zHZu1k
         OFTmep1BJkIsSi92XcFk3houpdMwFsoYJNXynkQjYKZK5GQ8+BjOTGVW7p0o34E10m
         zSCIU5V0K4wQsI/5MfQuIDEFkknEof+5mLDaSPMYfC7QJUt11NnipVPvgbUVBijyKN
         HS94T+HrIqn7A==
Received: by letrec.thunk.org (Postfix, from userid 15806)
        id 565568C023A; Wed, 23 Aug 2023 11:49:16 -0400 (EDT)
Date:   Wed, 23 Aug 2023 11:49:16 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Fengnan Chang <changfengnan@bytedance.com>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org
Subject: Re: [PATCH v4] ext4: improve trim efficiency
Message-ID: <ZOYqfDeUAFsO7X8j@mit.edu>
References: <20230822015135.50579-1-changfengnan@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230822015135.50579-1-changfengnan@bytedance.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Aug 22, 2023 at 09:51:35AM +0800, Fengnan Chang wrote:
> In commit a015434480dc("ext4: send parallel discards on commit
> completions"), issue all discard commands in parallel make all
> bios could merged into one request, so lowlevel drive can issue
> multi segments in one time which is more efficiency, but commit
> 55cdd0af2bc5 ("ext4: get discard out of jbd2 commit kthread contex")
> seems broke this way, let's fix it.
> In my test:
> 1. create 10 normal files, each file size is 10G.
> 2. deallocate file, punch a 16k holes every 32k.
> 3. trim all fs.
> 
> the time of fstrim fs reduce from 6.7s to 1.3s.
> 
> Signed-off-by: Fengnan Chang <changfengnan@bytedance.com>

Are you set up to run xfstests?  This commit is causing generic/251 to
fail, and that test is designed to test fstrim functionality.  To
reproduce the failure, please see:

  https://github.com/tytso/xfstests-bld/blob/master/Documentation/kvm-quickstart.md

... and then run "kvm-xfstests -c ext4 generic/251".

I've attached the failing test log for your convenience.

When you're working on improving this commit, please run

     "kvm-xfstests -c ext4 -g trim"

... to make sure there are no regression caused by the changes.

Thanks!!

					- Ted

KERNEL: kernel	6.5.0-rc3-xfstests-00061-g2251f08ac268 #256 SMP PREEMPT_DYNAMIC Wed Aug 23 11:35:44 EDT 2023 x86_64
FSTESTVER: blktests	527d03f (Sun, 6 Aug 2023 23:12:48 -0700)
FSTESTVER: e2fsprogs	v1.47.0-144-g441741fc (Tue, 8 Aug 2023 16:08:52 -0400)
FSTESTVER: fio		fio-3.35 (Tue, 23 May 2023 12:33:03 -0600)
FSTESTVER: fsverity	v1.5-7-g585e14a (Wed, 5 Jul 2023 20:46:59 -0700)
FSTESTVER: ima-evm-utils	v1.5 (Mon, 6 Mar 2023 07:40:07 -0500)
FSTESTVER: nvme-cli	v1.16 (Thu, 11 Nov 2021 13:09:06 -0800)
FSTESTVER: quota		v4.05-53-gd90b7d5 (Tue, 6 Dec 2022 12:59:03 +0100)
FSTESTVER: util-linux	v2.39.1 (Tue, 27 Jun 2023 14:31:13 +0200)
FSTESTVER: xfsprogs	v6.4.0 (Wed, 19 Jul 2023 14:01:37 +0200)
FSTESTVER: xfstests	v2023.08.06-7-g973a461dd (Tue, 8 Aug 2023 20:16:18 -0400)
FSTESTVER: xfstests-bld	dff94950 (Thu, 10 Aug 2023 16:35:45 -0400)
FSTESTVER: zz_build-distro	bookworm
FSTESTCFG: "ext4/4k"
FSTESTSET: "generic/251"
FSTESTEXC: ""
FSTESTOPT: "aex"
MNTOPTS: ""
CPUS: "2"
MEM: "1975.34"
               total        used        free      shared  buff/cache   available
Mem:            1975          93        1831           0          83        1882
Swap:              0           0           0
BEGIN TEST 4k (1 test): Ext4 4k block Wed Aug 23 11:35:55 EDT 2023
DEVICE: /dev/vdb
EXT_MKFS_OPTIONS: -b 4096
EXT_MOUNT_OPTIONS: -o block_validity
FSTYP         -- ext4
PLATFORM      -- Linux/x86_64 kvm-xfstests 6.5.0-rc3-xfstests-00061-g2251f08ac268 #256 SMP PREEMPT_DYNAMIC Wed Aug 23 11:35:44 EDT 2023
MKFS_OPTIONS  -- -F -q -b 4096 /dev/vdc
MOUNT_OPTIONS -- -o acl,user_xattr -o block_validity /dev/vdc /vdc

generic/251 105s ...  [11:35:55][    3.436826] run fstests generic/251 at 2023-08-23 11:35:55
[    4.483484] EXT4-fs error (device vdc): mb_free_blocks:1916: group 24, block 786432:freeing already freed block (bit 0); block bitmap corrupt.
[    4.487526] divide error: 0000 [#1] PREEMPT SMP NOPTI
[    4.487783] CPU: 0 PID: 2802 Comm: fstrim Not tainted 6.5.0-rc3-xfstests-00061-g2251f08ac268 #256
[    4.488212] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[    4.488624] RIP: 0010:mb_update_avg_fragment_size.isra.0+0x29/0x150
[    4.488907] Code: 90 0f 1f 44 00 00 f6 46 7c 80 0f 84 cb 00 00 00 41 56 41 55 41 54 55 53 8b 42 14 48 89 d3 85 c0 0f 84 a8 00 00 00 99 48 89 f5 <f7> 7b 18 ba ff ff ff ff 0f bd d0 41 89 d4 41 83 ec 01 0f 88 f8 00
[    4.489734] RSP: 0018:ffffc90003d43be8 EFLAGS: 00010206
[    4.489969] RAX: 000000000000062b RBX: ffff888009543450 RCX: ffff88800831fdd0
[    4.490288] RDX: 0000000000000000 RSI: ffff88800c677000 RDI: 000000000000000c
[    4.490610] RBP: ffff88800c677000 R08: 000000000000000d R09: 0000000000000003
[    4.490931] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000003
[    4.491255] R13: 0000000000000000 R14: 0000000000000000 R15: ffffc90003d43d70
[    4.491575] FS:  00007f06cb0dd840(0000) GS:ffff88807dc00000(0000) knlGS:0000000000000000
[    4.491936] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    4.492196] CR2: 00007f06cb37c445 CR3: 000000000c5be002 CR4: 0000000000770ef0
[    4.492519] PKRU: 55555554
[    4.492644] Call Trace:
[    4.492763]  <TASK>
[    4.492865]  ? die+0x36/0x80
[    4.493003]  ? do_trap+0xf4/0x100
[    4.493157]  ? mb_update_avg_fragment_size.isra.0+0x29/0x150
[    4.493415]  ? do_error_trap+0x65/0x80
[    4.493586]  ? mb_update_avg_fragment_size.isra.0+0x29/0x150
[    4.493843]  ? exc_divide_error+0x38/0x50
[    4.494026]  ? mb_update_avg_fragment_size.isra.0+0x29/0x150
[    4.494282]  ? asm_exc_divide_error+0x1a/0x20
[    4.494482]  ? mb_update_avg_fragment_size.isra.0+0x29/0x150
[    4.494739]  ? mb_set_largest_free_order.isra.0+0xb4/0x140
[    4.494986]  mb_mark_used+0x319/0x370
[    4.495156]  ext4_try_to_trim_range+0x244/0x650
[    4.495369]  ext4_trim_all_free+0xf0/0x1f0
[    4.495559]  ext4_trim_fs+0x23a/0x2e0
[    4.495727]  __ext4_ioctl+0x615/0x1190
[    4.495898]  ? kmem_cache_free+0x1f5/0x3f0
[    4.496086]  __x64_sys_ioctl+0x94/0xd0
[    4.496260]  do_syscall_64+0x3b/0x90
[    4.496429]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
[    4.496662] RIP: 0033:0x7f06cb2feafb
[    4.496828] Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 1c 48 8b 44 24 18 64 48 2b 04 25 28 00 00
[    4.497646] RSP: 002b:00007fff3a167cf0 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
[    4.497982] RAX: ffffffffffffffda RBX: 000055abce9da960 RCX: 00007f06cb2feafb
[    4.498301] RDX: 00007fff3a167d50 RSI: 00000000c0185879 RDI: 0000000000000003
[    4.498619] RBP: 00007fff3a167e00 R08: 00007f06cb3d3c60 R09: 00007fff3a1670e0
[    4.498940] R10: 0000000000000000 R11: 0000000000000246 R12: 00007fff3a169b22
[    4.499262] R13: 0000000000000003 R14: 0000000000000000 R15: 00007f06cb0dd7b8
[    4.499581]  </TASK>
[    4.499696] ---[ end trace 0000000000000000 ]---
[    4.500054] RIP: 0010:mb_update_avg_fragment_size.isra.0+0x29/0x150
[    4.500339] Code: 90 0f 1f 44 00 00 f6 46 7c 80 0f 84 cb 00 00 00 41 56 41 55 41 54 55 53 8b 42 14 48 89 d3 85 c0 0f 84 a8 00 00 00 99 48 89 f5 <f7> 7b 18 ba ff ff ff ff 0f bd d0 41 89 d4 41 83 ec 01 0f 88 f8 00
[    4.501173] RSP: 0018:ffffc90003d43be8 EFLAGS: 00010206
[    4.501410] RAX: 000000000000062b RBX: ffff888009543450 RCX: ffff88800831fdd0
[    4.501731] RDX: 0000000000000000 RSI: ffff88800c677000 RDI: 000000000000000c
[    4.502051] RBP: ffff88800c677000 R08: 000000000000000d R09: 0000000000000003
[    4.502372] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000003
[    4.502691] R13: 0000000000000000 R14: 0000000000000000 R15: ffffc90003d43d70
[    4.503012] FS:  00007f06cb0dd840(0000) GS:ffff88807dc00000(0000) knlGS:0000000000000000
[    4.503376] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    4.503636] CR2: 00007f06cb37c445 CR3: 000000000c5be002 CR4: 0000000000770ef0
[    4.503956] PKRU: 55555554
[    4.504083] note: fstrim[2802] exited with preempt_count 1
[    4.504336] ------------[ cut here ]------------
[    4.504554] WARNING: CPU: 0 PID: 2802 at kernel/exit.c:818 do_exit+0x3f6/0x440
[    4.504882] CPU: 0 PID: 2802 Comm: fstrim Tainted: G      D            6.5.0-rc3-xfstests-00061-g2251f08ac268 #256
[    4.505339] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[    4.505750] RIP: 0010:do_exit+0x3f6/0x440
[    4.505935] Code: d2 48 89 54 24 08 e9 10 fd ff ff e8 c4 7c 1c 00 e9 1a ff ff ff 48 8d 7d 18 e8 e6 3d 06 00 e9 02 fd ff ff 0f 0b e9 44 fc ff ff <0f> 0b e9 79 fc ff ff 4c 89 ee bf 05 06 00 00 e8 b6 fd 00 00 e9 37
[    4.506757] RSP: 0018:ffffc90003d43ef8 EFLAGS: 00010282
[    4.506991] RAX: 0000000000000001 RBX: ffff888006425d00 RCX: 0000000000000000
[    4.507313] RDX: 0000000000000001 RSI: 0000000000002710 RDI: ffff88800c5b5280
[    4.507635] RBP: ffff8880099d52c0 R08: 0000000000000000 R09: ffffffff8285ed40
[    4.507960] R10: ffffc90003d43e00 R11: ffffffff828ced88 R12: ffff88800c5b5280
[    4.508282] R13: 000000000000000b R14: ffff888006425d00 R15: ffffc90003d43b38
[    4.508603] FS:  00007f06cb0dd840(0000) GS:ffff88807dc00000(0000) knlGS:0000000000000000
[    4.508964] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    4.509224] CR2: 00007f06cb37c445 CR3: 000000000c5be002 CR4: 0000000000770ef0
[    4.509545] PKRU: 55555554
[    4.509673] Call Trace:
[    4.509787]  <TASK>
[    4.509887]  ? do_exit+0x3f6/0x440
[    4.510044]  ? __warn+0x7c/0x130
[    4.510192]  ? do_exit+0x3f6/0x440
[    4.510351]  ? report_bug+0x173/0x1d0
[    4.510520]  ? handle_bug+0x3c/0x70
[    4.510682]  ? exc_invalid_op+0x17/0x70
[    4.510858]  ? asm_exc_invalid_op+0x1a/0x20
[    4.511057]  ? do_exit+0x3f6/0x440
[    4.511221]  ? do_exit+0x68/0x440
[    4.511376]  make_task_dead+0x77/0x130
[    4.511548]  rewind_stack_and_make_dead+0x17/0x20
[    4.511764] RIP: 0033:0x7f06cb2feafb
[    4.511928] Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 1c 48 8b 44 24 18 64 48 2b 04 25 28 00 00
[    4.512752] RSP: 002b:00007fff3a167cf0 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
[    4.513090] RAX: ffffffffffffffda RBX: 000055abce9da960 RCX: 00007f06cb2feafb
[    4.513410] RDX: 00007fff3a167d50 RSI: 00000000c0185879 RDI: 0000000000000003
[    4.513731] RBP: 00007fff3a167e00 R08: 00007f06cb3d3c60 R09: 00007fff3a1670e0
[    4.514051] R10: 0000000000000000 R11: 0000000000000246 R12: 00007fff3a169b22
[    4.514378] R13: 0000000000000003 R14: 0000000000000000 R15: 00007f06cb0dd7b8
[    4.514697]  </TASK>
[    4.514801] ---[ end trace 0000000000000000 ]---
[   25.517834] rcu: INFO: rcu_preempt self-detected stall on CPU
[   25.519235] rcu: 	0-...!: (6299 ticks this GP) idle=e2f4/1/0x4000000000000000 softirq=8446/8475 fqs=182
[   25.519906] rcu: 	(t=6300 jiffies g=1349 q=434 ncpus=2)
[   25.520147] rcu: rcu_preempt kthread starved for 5754 jiffies! g1349 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=0
[   25.520600] rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
[   25.521006] rcu: RCU grace-period kthread stack dump:
[   25.521238] task:rcu_preempt     state:R  running task     stack:0     pid:16    ppid:2      flags:0x00004000
[   25.521680] Call Trace:
[   25.521795]  <TASK>
[   25.521898]  __schedule+0x2a2/0x820
[   25.522063]  ? __pfx_rcu_gp_kthread+0x10/0x10
[   25.522263]  schedule+0x5e/0xd0
[   25.522409]  schedule_timeout+0x98/0x170
[   25.522595]  ? __pfx_process_timeout+0x10/0x10
[   25.522799]  rcu_gp_fqs_loop+0x15b/0x680
[   25.522978]  rcu_gp_kthread+0x1bb/0x270
[   25.523159]  kthread+0xef/0x120
[   25.523305]  ? __pfx_kthread+0x10/0x10
[   25.523481]  ret_from_fork+0x31/0x50
[   25.523648]  ? __pfx_kthread+0x10/0x10
[   25.523822]  ret_from_fork_asm+0x1b/0x30
[   25.524001] RIP: 0000:0x0
[   25.524126] Code: Unable to access opcode bytes at 0xffffffffffffffd6.
[   25.524414] RSP: 0000:0000000000000000 EFLAGS: 00000000 ORIG_RAX: 0000000000000000
[   25.524755] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
[   25.525072] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
[   25.525393] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
[   25.525714] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
[   25.526030] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[   25.526349]  </TASK>
[   25.526453] rcu: Stack dump where RCU GP kthread last ran:
[   25.526702] CPU: 0 PID: 2806 Comm: fstrim Tainted: G      D W          6.5.0-rc3-xfstests-00061-g2251f08ac268 #256
[   25.527165] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[   25.527581] RIP: 0010:kvm_wait+0x4f/0x60
[   25.527760] Code: 74 1d fb c3 cc cc cc cc 0f b6 07 40 38 c6 75 f3 66 90 0f 00 2d 16 6f 1a 01 f4 c3 cc cc cc cc 66 90 0f 00 2d 07 6f 1a 01 fb f4 <c3> cc cc cc cc 66 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90
[   25.528587] RSP: 0018:ffffc90003dbbd10 EFLAGS: 00000246
[   25.528822] RAX: 0000000000000003 RBX: 0000000000040000 RCX: 0000000000000008
[   25.529140] RDX: 0000000000000000 RSI: 0000000000000003 RDI: ffff88800c574600
[   25.529459] RBP: 0000000000000001 R08: 0000000000000008 R09: 0000000000000000
[   25.529778] R10: ffff88807dc2d640 R11: 0000000000000001 R12: 0000000000000100
[   25.530099] R13: ffff88800c574600 R14: ffff88807dc2d640 R15: 0000000000000000
[   25.530423] FS:  00007f795203b840(0000) GS:ffff88807dc00000(0000) knlGS:0000000000000000
[   25.530786] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   25.531046] CR2: ffffffffffffffd6 CR3: 000000000c71e006 CR4: 0000000000770ef0
[   25.531373] PKRU: 55555554
[   25.531499] Call Trace:
[   25.531616]  <IRQ>
[   25.531715]  ? rcu_check_gp_kthread_starvation+0x120/0x1a0
[   25.531964]  ? print_cpu_stall+0x13b/0x290
[   25.532150]  ? check_cpu_stall+0xe9/0x240
[   25.532337]  ? rcu_sched_clock_irq+0xdf/0x440
[   25.532536]  ? update_process_times+0x74/0xb0
[   25.532739]  ? tick_sched_timer+0x77/0xb0
[   25.532922]  ? __pfx_tick_sched_timer+0x10/0x10
[   25.533131]  ? __hrtimer_run_queues+0x10d/0x2a0
[   25.533336]  ? hrtimer_interrupt+0xf8/0x230
[   25.533529]  ? __sysvec_apic_timer_interrupt+0x5e/0x130
[   25.533767]  ? sysvec_apic_timer_interrupt+0x65/0x80
[   25.533994]  </IRQ>
[   25.534095]  <TASK>
[   25.534194]  ? asm_sysvec_apic_timer_interrupt+0x1a/0x20
[   25.534432]  ? kvm_wait+0x4f/0x60
[   25.534588]  __pv_queued_spin_lock_slowpath+0x333/0x370
[   25.534825]  _raw_spin_lock+0x29/0x30
[   25.534992]  ext4_trim_all_free+0xbb/0x1f0
[   25.535184]  ext4_trim_fs+0x23a/0x2e0
[   25.535356]  __ext4_ioctl+0x615/0x1190
[   25.535533]  ? kmem_cache_free+0x1f5/0x3f0
[   25.535723]  __x64_sys_ioctl+0x94/0xd0
[   25.535896]  do_syscall_64+0x3b/0x90
[   25.536061]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
[   25.536296] RIP: 0033:0x7f795225cafb
[   25.536461] Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 1c 48 8b 44 24 18 64 48 2b 04 25 28 00 00
[   25.537290] RSP: 002b:00007ffd6b698520 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
[   25.537632] RAX: ffffffffffffffda RBX: 0000559e989b9960 RCX: 00007f795225cafb
[   25.537954] RDX: 00007ffd6b698580 RSI: 00000000c0185879 RDI: 0000000000000003
[   25.538274] RBP: 00007ffd6b698630 R08: 00007f7952331c60 R09: 00007ffd6b697910
[   25.538595] R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffd6b699b22
[   25.538915] R13: 0000000000000003 R14: 0000000000000000 R15: 00007f795203b7b8
[   25.539237]  </TASK>
[   25.539341] CPU: 0 PID: 2806 Comm: fstrim Tainted: G      D W          6.5.0-rc3-xfstests-00061-g2251f08ac268 #256
[   25.539804] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[   25.540216] RIP: 0010:kvm_wait+0x4f/0x60
[   25.540396] Code: 74 1d fb c3 cc cc cc cc 0f b6 07 40 38 c6 75 f3 66 90 0f 00 2d 16 6f 1a 01 f4 c3 cc cc cc cc 66 90 0f 00 2d 07 6f 1a 01 fb f4 <c3> cc cc cc cc 66 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90
[   25.541216] RSP: 0018:ffffc90003dbbd10 EFLAGS: 00000246
[   25.541452] RAX: 0000000000000003 RBX: 0000000000040000 RCX: 0000000000000008
[   25.541774] RDX: 0000000000000000 RSI: 0000000000000003 RDI: ffff88800c574600
[   25.542098] RBP: 0000000000000001 R08: 0000000000000008 R09: 0000000000000000
[   25.542417] R10: ffff88807dc2d640 R11: 0000000000000001 R12: 0000000000000100
[   25.542738] R13: ffff88800c574600 R14: ffff88807dc2d640 R15: 0000000000000000
[   25.543057] FS:  00007f795203b840(0000) GS:ffff88807dc00000(0000) knlGS:0000000000000000
[   25.543420] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   25.543681] CR2: ffffffffffffffd6 CR3: 000000000c71e006 CR4: 0000000000770ef0
[   25.543997] PKRU: 55555554
[   25.544124] Call Trace:
[   25.544238]  <IRQ>
[   25.544336]  ? rcu_dump_cpu_stacks+0xf7/0x180
[   25.544534]  ? print_cpu_stall+0x140/0x290
[   25.544720]  ? check_cpu_stall+0xe9/0x240
[   25.544905]  ? rcu_sched_clock_irq+0xdf/0x440
[   25.545109]  ? update_process_times+0x74/0xb0
[   25.545309]  ? tick_sched_timer+0x77/0xb0
[   25.545492]  ? __pfx_tick_sched_timer+0x10/0x10
[   25.545696]  ? __hrtimer_run_queues+0x10d/0x2a0
[   25.545905]  ? hrtimer_interrupt+0xf8/0x230
[   25.546097]  ? __sysvec_apic_timer_interrupt+0x5e/0x130
[   25.546336]  ? sysvec_apic_timer_interrupt+0x65/0x80
[   25.546564]  </IRQ>
[   25.546664]  <TASK>
[   25.546762]  ? asm_sysvec_apic_timer_interrupt+0x1a/0x20
[   25.547001]  ? kvm_wait+0x4f/0x60
[   25.547155]  __pv_queued_spin_lock_slowpath+0x333/0x370
[   25.547394]  _raw_spin_lock+0x29/0x30
[   25.547562]  ext4_trim_all_free+0xbb/0x1f0
[   25.547747]  ext4_trim_fs+0x23a/0x2e0
[   25.547919]  __ext4_ioctl+0x615/0x1190
[   25.548092]  ? kmem_cache_free+0x1f5/0x3f0
[   25.548278]  __x64_sys_ioctl+0x94/0xd0
[   25.548451]  do_syscall_64+0x3b/0x90
[   25.548617]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
[   25.548842] RIP: 0033:0x7f795225cafb
[   25.549005] Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 1c 48 8b 44 24 18 64 48 2b 04 25 28 00 00
[   25.549829] RSP: 002b:00007ffd6b698520 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
[   25.550166] RAX: ffffffffffffffda RBX: 0000559e989b9960 RCX: 00007f795225cafb
[   25.550487] RDX: 00007ffd6b698580 RSI: 00000000c0185879 RDI: 0000000000000003
[   25.550805] RBP: 00007ffd6b698630 R08: 00007f7952331c60 R09: 00007ffd6b697910
[   25.551117] R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffd6b699b22
[   25.551467] R13: 0000000000000003 R14: 0000000000000000 R15: 00007f795203b7b8
[   25.551903]  </TASK>
[   28.044765] watchdog: BUG: soft lockup - CPU#1 stuck for 23s! [ext4lazyinit:163]
[   28.046276] CPU: 1 PID: 163 Comm: ext4lazyinit Tainted: G      D W          6.5.0-rc3-xfstests-00061-g2251f08ac268 #256
[   28.047924] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[   28.048535] RIP: 0010:__pv_queued_spin_lock_slowpath+0x275/0x370
[   28.048926] Code: 40 d6 02 00 8d 42 ff 48 98 48 03 2c c5 00 a9 6c 82 4c 89 75 00 b8 00 80 00 00 eb 13 84 c0 75 08 0f b6 55 14 84 d2 75 4b f3 90 <83> e8 01 74 44 41 8b 56 08 85 d2 74 e5 41 8b 46 08 85 c0 75 0a f3
[   28.050207] RSP: 0018:ffffc90000a57db0 EFLAGS: 00000202
[   28.050544] RAX: 0000000000006e6b RBX: 0000000000080000 RCX: 0000000000000001
[   28.051007] RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff88807dd2d654
[   28.051494] RBP: ffff88807dc2d640 R08: 0000000000000000 R09: 0000000000031590
[   28.051954] R10: 0000000000000000 R11: ffff888003f5a540 R12: 0000000000000600
[   28.052420] R13: ffff88800c574600 R14: ffff88807dd2d640 R15: 0000000000000000
[   28.052887] FS:  0000000000000000(0000) GS:ffff88807dd00000(0000) knlGS:0000000000000000
[   28.053409] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   28.053785] CR2: 000055e824c511dc CR3: 0000000008168004 CR4: 0000000000770ee0
[   28.054255] PKRU: 55555554
[   28.054411] Call Trace:
[   28.054555]  <IRQ>
[   28.054678]  ? watchdog_timer_fn+0x1b3/0x220
[   28.054966]  ? __pfx_watchdog_timer_fn+0x10/0x10
[   28.055256]  ? __hrtimer_run_queues+0x10d/0x2a0
[   28.055548]  ? hrtimer_interrupt+0xf8/0x230
[   28.055807]  ? __sysvec_apic_timer_interrupt+0x5e/0x130
[   28.056141]  ? sysvec_apic_timer_interrupt+0x65/0x80
[   28.056460]  </IRQ>
[   28.056578]  <TASK>
[   28.056717]  ? asm_sysvec_apic_timer_interrupt+0x1a/0x20
[   28.057071]  ? __pv_queued_spin_lock_slowpath+0x275/0x370
[   28.057413]  _raw_spin_lock+0x29/0x30
[   28.057635]  ext4_init_inode_table+0x315/0x370
[   28.057916]  ext4_run_li_request+0xc7/0x250
[   28.058177]  ext4_lazyinit_thread.part.0+0x1cd/0x3b0
[   28.058492]  ? __pfx_ext4_lazyinit_thread+0x10/0x10
[   28.058799]  kthread+0xef/0x120
[   28.058985]  ? __pfx_kthread+0x10/0x10
[   28.059195]  ret_from_fork+0x31/0x50
[   28.059425]  ? __pfx_kthread+0x10/0x10
[   28.059648]  ret_from_fork_asm+0x1b/0x30
[   28.059883] RIP: 0000:0x0
[   28.060035] Code: Unable to access opcode bytes at 0xffffffffffffffd6.
[   28.060460] RSP: 0000:0000000000000000 EFLAGS: 00000000 ORIG_RAX: 0000000000000000
[   28.060955] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
[   28.061418] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
[   28.061886] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
[   28.062347] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
[   28.062812] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[   28.063291]  </TASK>
QEMU: Terminated
