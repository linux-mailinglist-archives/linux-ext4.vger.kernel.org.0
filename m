Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2E623B216A
	for <lists+linux-ext4@lfdr.de>; Wed, 23 Jun 2021 21:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbhFWTw1 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 23 Jun 2021 15:52:27 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:56859 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229523AbhFWTwZ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 23 Jun 2021 15:52:25 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 15NJnrBJ023616
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Jun 2021 15:49:53 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id E314115C3CD6; Wed, 23 Jun 2021 15:49:52 -0400 (EDT)
Date:   Wed, 23 Jun 2021 15:49:52 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Wang Jianchao <jianchao.wan9@gmail.com>
Cc:     Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        lishujin@kuaishou.com, Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH V2 1/7] ext4: remove the 'group' parameter of
 ext4_trim_extent
Message-ID: <YNOQYF7vKedXQnI8@mit.edu>
References: <164ffa3b-c4d5-6967-feba-b972995a6dfb@gmail.com>
 <61eceb4c-6e5f-34d0-9317-a833d7c63b6f@gmail.com>
 <YNMzhm2gIM2oQfjs@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNMzhm2gIM2oQfjs@mit.edu>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

CC'ed Josh since he was testing this patchset.

On Wed, Jun 23, 2021 at 09:13:42AM -0400, Theodore Ts'o wrote:
> 
> The conflicts were relatively minor, but the obvious fix-ups resulted
> in a large number of crashes caused by various stress tests, such as
> generic/068 and generic/204.  I'm currently investigating to see what
> I might have messed up when I tried applying these patches, as well as
> running your patch set applied against 5.12 to make sure the problems
> weren't introduced by the patch set itself.

I applied this patch set on top of 5.12, where it applied w/o any
patch conflicts, and I'm still seeing large number of crashes[1].  The
crashes are in a wide variety of tests, and many of the stack traces
involve the ext4_discard_work workqueue.

[1] I ran the test via "gce-xfstests ltm -c ext4/all -g auto --kernel
gs://<bucket>/kernel.deb", but almost all of the file system configs
were crashing.  So "kvm-xfstests -c ext4/4k -g auto" should be
sufficient to reproduce the problem.  kvm-xfstests can be found at
https://github.com/tytso/xfstests-bld.

I don't have time to debug this more closely right now, but at a rough
guess is that workqueue isn't properly getting shutdown during a file
system unmount, and this is causing all sorts of mischief.

       	  	     	      	 	     - Ted


Jun 23 09:04:46 debian kernel: [    0.000000] Linux version 5.12.0-xfstests-00007-g1d72c24b1506 (tytso@cwcc) (gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2) #188 SMP Wed Jun 23 08:59:01 EDT 2021
Jun 23 09:04:46 debian kernel: [    0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz-5.12.0-xfstests-00007-g1d72c24b1506 root=UUID=d7961c9f-8636-4194-bcb7-b7861b5a470f ro console=ttyS0,115200 earlyprintk=ttyS0,115200 elevator=noop console=ttyS0 net.ifnames=0 biosdevname=0 mem=7680M fstestcfg=ext4/4k fstestset=-g,auto fstestexc= fstestopt=aex fstesttyp=ext4 fstestapi=1.5 fsteststr= nfssrv= orig_cmdline=LS1pbnN0YW5jZS1uYW1lIHhmc3Rlc3RzLWx0bS0yMDIxMDYyMzA5MDI0Ny1hYSAtLWdjZS16b25lIHVzLXdlc3QxLWEgLS1ncy1idWNrZXQgZ2NlLXhmc3Rlc3RzIC0taW1hZ2UtcHJvamVjdCBnY2UteGZzdGVzdHMgLS1rZXJuZWwgZ3M6Ly9nY2UteGZzdGVzdHMva2VybmVsLmRlYiAtLWJ1Y2tldC1zdWJkaXIgcmVzdWx0cyAtLW5vLWVtYWlsIC1jIGV4dDQvNGsgZnVsbA==
	...
[  954.782827] run fstests generic/041 at 2021-06-23 09:20:30
Jun 23 09:20:30 xfstests-ltm-20210623090247-aa systemd[1]: Started /usr/bin/bash -c test -w /proc/self/oom_score_adj && echo 250 > /proc/self/oom_score_adj; exec ./tests/generic/041.
Jun 23 09:20:31 xfstests-ltm-20210623090247-aa kernel: [  955.288215] EXT4-fs (dm-0): mounted filesystem with ordered data mode. Opts: acl,user_xattr,block_validity. Quota mode: none.
Jun 23 09:20:31 xfstests-ltm-20210623090247-aa kernel: [  955.879898] EXT4-fs (dm-2): mounted filesystem with ordered data mode. Opts: acl,user_xattr,block_validity. Quota mode: none.
Jun 23 09:20:50 xfstests-ltm-20210623090247-aa systemd[1]: xt\x2dvdc.mount: Succeeded.
Jun 23 09:20:50 xfstests-ltm-20210623090247-aa systemd[921]: xt\x2dvdc.mount: Succeeded.
Jun 23 09:20:51 xfstests-ltm-20210623090247-aa kernel: [  975.090048] EXT4-fs (dm-2): recovery complete
Jun 23 09:20:51 xfstests-ltm-20210623090247-aa kernel: [  975.090776] EXT4-fs (dm-2): mounted filesystem with ordered data mode. Opts: acl,user_xattr,block_validity. Quota mode: none.
Jun 23 09:21:01 xfstests-ltm-20210623090247-aa systemd[1]: xt\x2dvdc.mount: Succeeded.
Jun 23 09:21:01 xfstests-ltm-20210623090247-aa systemd[921]: xt\x2dvdc.mount: Succeeded.
[  985.883114] BUG: kernel NULL pointer dereference, address: 0000000000000040
[  985.890856] #PF: supervisor read access in kernel mode
[  985.896241] #PF: error_code(0x0000) - not-present page
[  985.901665] PGD 0 P4D 0 
[  985.904648] Oops: 0000 [#1] SMP PTI
[  985.908265] CPU: 0 PID: 5738 Comm: kworker/u4:2 Not tainted 5.12.0-xfstests-00007-g1d72c24b1506 #188
[  985.917880] Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
[  985.927582] Workqueue: ext4discard ext4_discard_work
[  985.932662] RIP: 0010:ext4_discard_work+0x31/0x3f0
[  985.937653] Code: 41 56 41 55 41 54 55 53 48 83 ec 50 48 8b af 88 fe ff ff 65 48 8b 04 25 28 00 00 00 48 89 44 24 48 31 c0 48 8b 85 e8 06 00 00 <8b> 50 40 85 d2 48 89 14 24 0f 84 82 02 00 00 31 db eb 2c 41 89 d9
[  985.956879] RSP: 0018:ffffa527052c7dd8 EFLAGS: 00010246
[  985.962235] RAX: 0000000000000000 RBX: ffff8db25dd98000 RCX: 0000000000000001
[  985.969496] RDX: 0000000000000000 RSI: ffffffffa0adde80 RDI: ffff8db25fff3510
[  985.976997] RBP: ffff8db25fc2f000 R08: 0000000000000000 R09: 0000000000040479
[  985.985066] R10: 0000000000000000 R11: 0000000000000000 R12: ffff8db24011b800
[  985.992332] R13: ffff8db240822500 R14: 0000000000000000 R15: 0000000000000000
[  985.999966] FS:  0000000000000000(0000) GS:ffff8db319200000(0000) knlGS:0000000000000000
[  986.008242] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  986.014229] CR2: 0000000000000040 CR3: 000000002c212006 CR4: 00000000003706f0
[  986.021660] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  986.029742] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  986.037346] Call Trace:
[  986.039958]  ? lock_acquire.part.0+0x5c/0x120
[  986.044430]  ? process_one_work+0x1fb/0x590
[  986.048844]  ? lock_is_held_type+0x98/0x100
[  986.053742]  process_one_work+0x27b/0x590
[  986.058146]  worker_thread+0x4e/0x300
[  986.061953]  ? process_one_work+0x590/0x590
[  986.066255]  kthread+0x13a/0x150
[  986.069770]  ? __kthread_bind_mask+0x60/0x60
[  986.074420]  ret_from_fork+0x22/0x30
[  986.078269] CR2: 0000000000000040
[  986.081703] ---[ end trace 01e941885177e812 ]---
[  986.086543] RIP: 0010:ext4_discard_work+0x31/0x3f0
[  986.091558] Code: 41 56 41 55 41 54 55 53 48 83 ec 50 48 8b af 88 fe ff ff 65 48 8b 04 25 28 00 00 00 48 89 44 24 48 31 c0 48 8b 85 e8 06 00 00 <8b> 50 40 85 d2 48 89 14 24 0f 84 82 02 00 00 31 db eb 2c 41 89 d9
[  986.110810] RSP: 0018:ffffa527052c7dd8 EFLAGS: 00010246
[  986.116344] RAX: 0000000000000000 RBX: ffff8db25dd98000 RCX: 0000000000000001
[  986.123850] RDX: 0000000000000000 RSI: ffffffffa0adde80 RDI: ffff8db25fff3510
[  986.131096] RBP: ffff8db25fc2f000 R08: 0000000000000000 R09: 0000000000040479
[  986.138443] R10: 0000000000000000 R11: 0000000000000000 R12: ffff8db24011b800
[  986.145968] R13: ffff8db240822500 R14: 0000000000000000 R15: 0000000000000000
[  986.153412] FS:  0000000000000000(0000) GS:ffff8db319200000(0000) knlGS:0000000000000000
[  986.161707] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  986.167563] CR2: 0000000000000040 CR3: 000000002c212006 CR4: 00000000003706f0
[  986.175089] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  986.182509] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  986.190000] BUG: sleeping function called from invalid context at include/linux/percpu-rwsem.h:49
[  986.199449] in_atomic(): 0, irqs_disabled(): 1, non_block: 0, pid: 5738, name: kworker/u4:2
[  986.208016] INFO: lockdep is turned off.
[  986.212055] irq event stamp: 559784
[  986.215784] hardirqs last  enabled at (559783): [<ffffffff9ff78ec4>] _raw_spin_unlock_irq+0x24/0x30
[  986.225129] hardirqs last disabled at (559784): [<ffffffff9ff69405>] exc_page_fault+0x35/0x240
[  986.233856] softirqs last  enabled at (559776): [<ffffffff9f50b8cd>] wb_workfn+0x18d/0x350
[  986.242258] softirqs last disabled at (559772): [<ffffffff9f45cd8e>] wb_wakeup_delayed+0x2e/0x70
[  986.251281] CPU: 0 PID: 5738 Comm: kworker/u4:2 Tainted: G      D           5.12.0-xfstests-00007-g1d72c24b1506 #188
[  986.261926] Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
[  986.271275] Workqueue: ext4discard ext4_discard_work
[  986.276382] Call Trace:
[  986.279012]  dump_stack+0x6d/0x89
[  986.283240]  ___might_sleep.cold+0xa6/0xb6
[  986.287489]  exit_signals+0x1c/0x2c0
[  986.291417]  do_exit+0xa6/0x3c0
[  986.294672]  rewind_stack_do_exit+0x17/0x20
[  986.299092] RIP: 0000:0x0
[  986.301940] Code: Unable to access opcode bytes at RIP 0xffffffffffffffd6.
[  986.309322] RSP: 0000:0000000000000000 EFLAGS: 00000000 ORIG_RAX: 0000000000000000
[  986.317124] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
[  986.324586] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
[  986.331945] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
[  986.339473] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
[  986.346718] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
Jun 23 09:21:02 xfstests-ltm-20210623090247-aa kernel: [  985.883114] BUG: kernel NULL pointer dereference, address: 0000000000000040
Jun 23 09:21:02 xfstests-ltm-20210623090247-aa kernel: [  985.890856] #PF: supervisor read access in kernel mode
Jun 23 09:21:02 xfstests-ltm-20210623090247-aa kernel: [  985.896241] #PF: error_code(0x0000) - not-present page
Jun 23 09:21:02 xfstests-ltm-20210623090247-aa kernel: [  985.901665] PGD 0 P4D 0 
Jun 23 09:21:02 xfstests-ltm-20210623090247-aa kernel: [  985.904648] Oops: 0000 [#1] SMP PTI
Jun 23 09:21:02 xfstests-ltm-20210623090247-aa kernel: [  985.908265] CPU: 0 PID: 5738 Comm: kworker/u4:2 Not tainted 5.12.0-xfstests-00007-g1d72c24b1506 #188
Jun 23 09:21:02 xfstests-ltm-20210623090247-aa kernel: [  985.917880] Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Jun 23 09:21:02 xfstests-ltm-20210623090247-aa kernel: [  985.927582] Workqueue: ext4discard ext4_discard_work
Jun 23 09:21:02 xfstests-ltm-20210623090247-aa kernel: [  985.932662] RIP: 0010:ext4_discard_work+0x31/0x3f0
Jun 23 09:21:02 xfstests-ltm-20210623090247-aa kernel: [  985.937653] Code: 41 56 41 55 41 54 55 53 48 83 ec 50 48 8b af 88 fe ff ff 65 48 8b 04 25 28 00 00 00 48 89 44 24 48 31 c0 48 8b 85 e8 06 00 00 <8b> 50 40 85 d2 48 89 14 24 0f 84 82 02 00 00 31 db eb 2c 41 89 d9
Jun 23 09:21:02 xfstests-ltm-20210623090247-aa kernel: [  985.956879] RSP: 0018:ffffa527052c7dd8 EFLAGS: 00010246
Jun 23 09:21:02 xfstests-ltm-20210623090247-aa kernel: [  985.962235] RAX: 0000000000000000 RBX: ffff8db25dd98000 RCX: 0000000000000001
Jun 23 09:21:02 xfstests-ltm-20210623090247-aa kernel: [  985.969496] RDX: 0000000000000000 RSI: ffffffffa0adde80 RDI: ffff8db25fff3510
Jun 23 09:21:02 xfstests-ltm-20210623090247-aa kernel: [  985.976997] RBP: ffff8db25fc2f000 R08: 0000000000000000 R09: 0000000000040479
Jun 23 09:21:02 xfstests-ltm-20210623090247-aa kernel: [  985.985066] R10: 0000000000000000 R11: 0000000000000000 R12: ffff8db24011b800
Jun 23 09:21:02 xfstests-ltm-20210623090247-aa kernel: [  985.992332] R13: ffff8db240822500 R14: 0000000000000000 R15: 0000000000000000
Jun 23 09:21:02 xfstests-ltm-20210623090247-aa kernel: [  985.999966] FS:  0000000000000000(0000) GS:ffff8db319200000(0000) knlGS:0000000000000000
Jun 23 09:21:02 xfstests-ltm-20210623090247-aa kernel: [  986.008242] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Jun 23 09:21:02 xfstests-ltm-20210623090247-aa kernel: [  986.014229] CR2: 0000000000000040 CR3: 000000002c212006 CR4: 00000000003706f0
Jun 23 09:21:02 xfstests-ltm-20210623090247-aa kernel: [  986.021660] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
Jun 23 09:21:02 xfstests-ltm-20210623090247-aa kernel: [  986.029742] DR3: 0000000000000000 DR6: 0000[  986.603186] run fstests generic/043 at 2021-06-23 09:21:02
0000fffe0ff0 DR7: 0000000000000400
Jun 23 09:21:02 xfstests-ltm-20210623090247-aa kernel: [  986.037346] Call Trace:
Jun 23 09:21:02 xfstests-ltm-20210623090247-aa kernel: [  986.039958]  ? lock_acquire.part.0+0x5c/0x120
Jun 23 09:21:02 xfstests-ltm-20210623090247-aa kernel: [  986.044430]  ? process_one_work+0x1fb/0x590
Jun 23 09:21:02 xfstests-ltm-20210623090247-aa kernel: [  986.048844]  ? lock_is_held_type+0x98/0x100
Jun 23 09:21:02 xfstests-ltm-20210623090247-aa kernel: [  986.053742]  process_one_work+0x27b/0x590
Jun 23 09:21:02 xfstests-ltm-20210623090247-aa kernel: [  986.058146]  worker_thread+0x4e/0x300
Jun 23 09:21:02 xfstests-ltm-20210623090247-aa kernel: [  986.061953]  ? process_one_work+0x590/0x590
Jun 23 09:21:02 xfstests-ltm-20210623090247-aa kernel: [  986.066255]  kthread+0x13a/0x150
Jun 23 09:21:02 xfstests-ltm-20210623090247-aa kernel: [  986.069770]  ? __kthread_bind_mask+0x60/0x60
Jun 23 09:21:02 xfstests-ltm-20210623090247-aa kernel: [  986.074420]  ret_from_fork+0x22/0x30
Jun 23 09:21:02 xfstests-ltm-20210623090247-aa kernel: [  986.078269] CR2: 0000000000000040
Jun 23 09:21:02 xfstests-ltm-20210623090247-aa kernel: [  986.081703] ---[ end trace 01e941885177e812 ]---
Jun 23 09:21:02 xfstests-ltm-20210623090247-aa kernel: [  986.086543] RIP: 0010:ext4_discard_work+0x31/0x3f0
Jun 23 09:21:02 xfstests-ltm-20210623090247-aa kernel: [  986.091558] Code: 41 56 41 55 41 54 55 53 48 83 ec 50 48 8b af 88 fe ff ff 65 48 8b 04 25 28 00 00 00 48 89 44 24 48 31 c0 48 8b 85 e8 06 00 00 <8b> 50 40 85 d2 48 89 14 24 0f 84 82 02 00 00 31 db eb 2c 41 89 d9
Jun 23 09:21:02 xfstests-ltm-20210623090247-aa kernel: [  986.110810] RSP: 0018:ffffa527052c7dd8 EFLAGS: 00010246
Jun 23 09:21:02 xfstests-ltm-20210623090247-aa kernel: [  986.116344] RAX: 0000000000000000 RBX: ffff8db25dd98000 RCX: 0000000000000001
Jun 23 09:21:02 xfstests-ltm-20210623090247-aa kernel: [  986.123850] RDX: 0000000000000000 RSI: ffffffffa0adde80 RDI: ffff8db25fff3510
Jun 23 09:21:02 xfstests-ltm-20210623090247-aa kernel: [  986.131096] RBP: ffff8db25fc2f000 R08: 0000000000000000 R09: 0000000000040479
Jun 23 09:21:02 xfstests-ltm-20210623090247-aa kernel: [  986.138443] R10: 0000000000000000 R11: 0000000000000000 R12: ffff8db24011b800
Jun 23 09:21:02 xfstests-ltm-20210623090247-aa kernel: [  986.145968] R13: ffff8db240822500 R14: 0000000000000000 R15: 0000000000000000
Jun 23 09:21:02 xfstests-ltm-20210623090247-aa kernel: [  986.153412] FS:  0000000000000000(0000) GS:ffff8db319200000(0000) knlGS:0000000000000000
Jun 23 09:21:02 xfstests-ltm-20210623090247-aa kernel: [  986.161707] C[  986.843267] EXT4-fs (dm-0): mounted filesystem with ordered data mode. Opts: acl,user_xattr,block_validity. Quota mode: none.
S:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Jun 23 09:21:02 xfstests-ltm-20210623090247-aa kernel: [  986.167563] CR2: 0000000000000040 CR3: 000000002c212006 CR4: 00000000003706f0
Jun 23 09:21:02 xfstests-ltm-20210623090247-aa kernel: [  986.175089] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
Jun 23 09:21:02 xfstests-ltm-20210623090247-aa kernel: [  986.182509] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Jun 23 09:21:02 xfstests-ltm-20210623090247-aa kernel: [  986.190000] BUG: sleeping function called from invalid context at include/linux/percpu-rwsem.h:49
Jun 23 09:21:02 xfstests-ltm-20210623090247-aa kernel: [  986.199449] in_atomic(): 0, irqs_disabled(): 1, non_block: 0, pid: 5738, name: kworker/u4:2
Jun 23 09:21:02 xfstests-ltm-20210623090247-aa kernel: [  986.208016] INFO: lockdep is turned off.
Jun 23 09:21:02 xfstests-ltm-20210623090247-aa kernel: [  986.212055] irq event stamp: 559784
Jun 23 09:21:02 xfstests-ltm-20210623090247-aa kernel: [  986.215784] hardirqs last  enabled at (559783): [<ffffffff9ff78ec4>] _raw_spin_unlock_irq+0x24/0x30
Jun 23 09:21:02 xfstests-ltm-20210623090247-aa kernel: [  986.225129] hardirqs last disabled at (559784): [<ffffffff9ff69405>] exc_page_fault+0x35/0x240
Jun 23 09:21:02 xfstests-ltm-20210623090247-aa kernel: [  986.233856] softirqs last  enabled at (559776): [<ffffffff9f50b8cd>] wb_workfn+0x18d/0x350
Jun 23 09:21:02 xfstests-ltm-20210623090247-aa kernel: [  986.242258] softirqs last disabled at (559772): [<ffffffff9f45cd8e>] wb_wakeup_delayed+0x2e/0x70
Jun 23 09:21:02 xfstests-ltm-20210623090247-aa kernel: [  986.251281] CPU: 0 PID: 5738 Comm: kworker/u4:2 Tainted: G      D           5.12.0-xfstests-00007-g1d72c24b1506 #188
Jun 23 09:21:02 xfstests-ltm-20210623090247-aa kernel: [  986.261926] Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Jun 23 09:21:02 xfstests-ltm-20210623090247-aa kernel: [  986.271275] Workqueue: ext4discard ext4_discard_work
Jun 23 09:21:02 xfstests-ltm-20210623090247-aa kernel: [  986.276382] Call Trace:
Jun 23 09:21:02 xfstests-ltm-20210623090247-a[  987.049261] EXT4-fs (dm-1): mounted filesystem with ordered data mode. Opts: acl,user_xattr,block_validity. Quota mode: none.
a kernel: [  986.279012]  dump_stack+0x6d/0x89
Jun 23 09:21:02 xfstests-ltm-20210623090247-aa kernel: [  986.283240]  ___might_sleep.cold+0xa6/0xb6
Jun 23 09:21:02 xfstests-ltm-20210623090247-aa kernel: [  986.287489]  exit_signals+0x1c/0x2c0
Jun 23 09:21:02 xfstests-ltm-20210623090247-aa kernel: [  986.291417]  do_exit+0xa6/0x3c0
Jun 23 09:21:02 xfstests-ltm-20210623090247-aa kernel: [  986.294672]  rewind_stack_do_exit+0x17/0x20
Jun 23 0[  987.102134] EXT4-fs (dm-1): shut down requested (1)
9:21:02 xfstests[  987.107927] Aborting journal on device dm-1-8.
-ltm-20210623090247-aa kernel: [  986.299092] RIP: 0000:0x0
Jun 23 09:21:02 xfstests-ltm-20210623090247-aa kernel: [  986.301940] Code: Unable to access opcode bytes at RIP 0xffffffffffffffd6.
Jun 23 09:21:02 xfstests-ltm-20210623090247-aa kernel: [  986.309322] RSP: 0000:0000000000000000 EFLAGS: 00000000 ORIG_RAX: 0000000000000000
Jun 23 09:21:02 xfstests-ltm-20210623090247-aa kernel: [  986.317124] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
Jun 23 09:21:02 xfstests-ltm-20210623090247-aa kernel: [  986.324586] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
Jun 23 09:21:02 xfstests-ltm-20210623090247-aa kernel: [  986.331945] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
Jun 23 09:21:02 xfstests-ltm-20210623090247-aa kernel: [  986.339473] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
Jun 23 09:21:02 xfstests-ltm-20210623090247-aa kernel: [  986.346718] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
Jun 23 09:21:02 xfstests-ltm-20210623090247-aa systemd[1]: fstests-generic-041.scope: Succeeded.
Jun 23 09:21:02 xfstests-ltm-20210623090247-aa systemd[921]: xt\x2dvdb.mount: Succeeded.
Jun 23 09:21:02 xfstests-ltm-20210623090247-aa systemd[1]: xt\x2dvdb.mount: Succeeded.
Jun 23 09:21:02 xfstests-ltm-20210623090247-aa systemd[1]: Started /usr/bin/bash -c test -w /proc/self/oom_score_adj && echo 250 > /proc/self/oom_score_adj; exec ./tests/generic/043.
Jun 23 09:21:02 xfstests-ltm-20210623090247-aa kernel: [  986.843267] EXT4-fs (dm-0): mounted filesystem with ordered data mode. Opts: acl,user_xattr,block_validity. Quota mode: none.
Jun 23 09:21:03 xfstests-ltm-20210623090247-aa kernel: [  987.049261] EXT4-fs (dm-1): mounted filesystem with ordered data mode. Opts: acl,user_xattr,block_validity. Quota mode: none.
Jun 23 09:21:03 xfstests-ltm-20210623090247-aa kernel: [  987.102134] EXT4-fs (dm-1)[  987.284882] EXT4-fs (dm-1): mounted filesystem with ordered data mode. Opts: acl,user_xattr,block_validity. Quota mode: none.
: shut down requested (1)
Jun 23 09:21:03 xfstests-ltm-20210623090247-aa kernel: [  987.107927] Aborting journal on device dm-1-8.
Jun 23 09:21:03 xfstests-ltm-20210623090247-aa systemd[1]: xt\x2dvdc.mount: Succeeded.
Jun 23 09:21:03 xfstests-ltm-20210623090247-aa systemd[921]: xt\x2dvdc.mount: Succeeded.
Jun 23 09:21:03 xfstests-ltm-20210623090247-aa kernel: [  987.284882] EXT4-fs (dm-1): mounted filesystem with ordered data mode. Opts: acl,user_xattr,block_validity. Quota mode: none.
[  999.135257] EXT4-fs (dm-1): shut down requested (2)
[  999.140764] Aborting journal on device dm-1-8.
Jun 23 09:21:15 xfstests-ltm-20210623090247-aa kernel: [  999.135257] EXT4-fs (dm-1): shut down requested (2)
Jun 23 09:21:15 xfstests-ltm-20210623090247-aa kernel: [  999.140764] Aborting journal on device dm-1-8.
Jun 23 09:21:15 xfstests-ltm-20210623090247-aa systemd[1]: xt\x2dvdc.mount: Succeeded.
Jun 23 09:21:15 xfstests-ltm-20210623090247-aa systemd[921]: xt\x2dvdc.mount: Succeeded.
[  999.206122] EXT4-fs (dm-1): recovery complete
