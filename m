Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46C5ADDAA5
	for <lists+linux-ext4@lfdr.de>; Sat, 19 Oct 2019 21:19:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726142AbfJSTTl (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 19 Oct 2019 15:19:41 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:52533 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726101AbfJSTTl (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 19 Oct 2019 15:19:41 -0400
Received: from callcc.thunk.org (pool-72-93-95-157.bstnma.fios.verizon.net [72.93.95.157])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x9JJJY6D024691
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 19 Oct 2019 15:19:34 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id E063C420458; Sat, 19 Oct 2019 15:19:33 -0400 (EDT)
Date:   Sat, 19 Oct 2019 15:19:33 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH 0/19 v3] ext4: Fix transaction overflow due to revoke
 descriptors
Message-ID: <20191019191933.GA25841@mit.edu>
References: <20191003215523.7313-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="/9DWx/yDrRhgMJTb"
Content-Disposition: inline
In-Reply-To: <20191003215523.7313-1-jack@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Jan,

I've tried applying this patch set against 5.4-rc3, and I'm finding a
easily reproducible failure using:

	kvm-xfstests -c ext3conv ext4/039

It is the BUG_ON in fs/jbd2/commit.c, around line 570:

	J_ASSERT(commit_transaction->t_nr_buffers <=
		 atomic_read(&commit_transaction->t_outstanding_credits));

The failure (with the obvious debugging printk added) is:

ext4/039		[15:13:16][    6.747101] run fstests ext4/039 at 2019-10
-19 15:13:16
[    7.018766] Mounted ext4 file system at /vdc supports timestamps until 2038 (
0x7fffffff)
[    8.227631] JBD2: t_nr_buffers 226, t_outstanding_credits=223
[    8.229215] ------------[ cut here ]------------
[    8.230249] kernel BUG at fs/jbd2/commit.c:573!
     	       ...

The full log is attached (although the stack trace isn't terribly
interesting, since this is being run out of kjournald2).

						- Ted


--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="log.201910191513"
Content-Transfer-Encoding: quoted-printable

=1Bc=1B[?7l=1B[2J=1B[0mSeaBIOS (version 1.12.0-1)=0D
Booting from ROM..=1Bc=1B[?7l=1B[2JKERNEL: kernel	5.4.0-rc3-xfstests-00022-=
g6db1a59f1c6a-dirty #1234 SMP Sat Oct 19 15:10:53 EDT 2019 x86_64=0D
FSTESTVER: blktests	667d741 (Wed, 4 Sep 2019 10:49:18 -0700)=0D
FSTESTVER: e2fsprogs	v1.45.4-15-g4b4f7b35 (Wed, 9 Oct 2019 20:25:01 -0400)=
=0D
FSTESTVER: fio		fio-3.15 (Fri, 12 Jul 2019 10:40:36 -0600)=0D
FSTESTVER: fsverity	2151209 (Fri, 28 Jun 2019 14:34:41 -0700)=0D
FSTESTVER: ima-evm-utils	0267fa1 (Mon, 3 Dec 2018 06:11:35 -0500)=0D
FSTESTVER: nvme-cli	v1.9 (Thu, 15 Aug 2019 13:14:59 -0600)=0D
FSTESTVER: quota		6e63107 (Thu, 15 Aug 2019 11:23:55 +0200)=0D
FSTESTVER: util-linux	v2.33.2 (Tue, 9 Apr 2019 14:58:07 +0200)=0D
FSTESTVER: xfsprogs	v5.3.0-rc1-8-g7aaa32db (Thu, 19 Sep 2019 13:21:52 -0400=
)=0D
FSTESTVER: xfstests	linux-v3.8-2563-g45bd2a28 (Mon, 14 Oct 2019 08:11:38 -0=
400)=0D
FSTESTVER: xfstests-bld	5e2a748 (Mon, 14 Oct 2019 09:36:05 -0400)=0D
FSTESTCFG: "ext3conv"=0D
FSTESTSET: "ext4/039"=0D
FSTESTEXC: ""=0D
FSTESTOPT: "aex"=0D
MNTOPTS: ""=0D
CPUS: "2"=0D
MEM: "1966.97"=0D
              total        used        free      shared  buff/cache   avail=
able=0D
Mem:           1966          96        1778           8          92        =
1830=0D
Swap:             0           0           0=0D
[    5.146878] NFSD: Using /var/lib/nfs/v4recovery as the NFSv4 state recov=
ery directory=0D
[    5.148619] NFSD: Using legacy client tracking operations.=0D
BEGIN TEST ext3conv (1 test): Ext4 4k block w/nodelalloc and no flex_bg Sat=
 Oct 19 15:13:15 EDT 2019=0D
DEVICE: /dev/vdd=0D
EXT_MKFS_OPTIONS: -O ^flex_bg=0D
EXT_MOUNT_OPTIONS: -o block_validity,nodelalloc=0D
FSTYP         -- ext4=0D
PLATFORM      -- Linux/x86_64 kvm-xfstests 5.4.0-rc3-xfstests-00022-g6db1a5=
9f1c6a-dirty #1234 SMP Sat Oct 19 15:10:53 EDT 2019=0D
MKFS_OPTIONS  -- -q -O ^flex_bg /dev/vdc=0D
MOUNT_OPTIONS -- -o acl,user_xattr -o block_validity,nodelalloc /dev/vdc /v=
dc=0D
=0D
ext4/039		[15:13:16][    6.747101] run fstests ext4/039 at 2019-10-19 15:13=
:16=0D
[    7.018766] Mounted ext4 file system at /vdc supports timestamps until 2=
038 (0x7fffffff)=0D
[    8.227631] JBD2: t_nr_buffers 226, t_outstanding_credits=3D223=0D
[    8.229215] ------------[ cut here ]------------=0D
[    8.230249] kernel BUG at fs/jbd2/commit.c:573!=0D
[    8.231231] invalid opcode: 0000 [#1] SMP NOPTI=0D
[    8.232223] CPU: 1 PID: 1384 Comm: jbd2/vdc-8 Not tainted 5.4.0-rc3-xfst=
ests-00022-g6db1a59f1c6a-dirty #1234=0D
[    8.234303] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.12.0-1 04/01/2014=0D
[    8.236124] RIP: 0010:jbd2_journal_commit_transaction+0x1565/0x1f35=0D
[    8.237489] Code: f0 fe ff ff 48 c7 c2 b8 52 3a 8c be 4e 00 00 00 48 c7 =
c7 3f 06 3f 8c c6 05 a8 c5 5a 01 01 e8 8f 15 d4 ff e9 cc fe ff ff 0f 0b <0f=
> 0b 0f 0b 0f 0b e8 10 a0 d5 ff 85 c0 0f 85 15 fb ff ff 48 c7 c2=0D
[    8.241449] RSP: 0018:ffffaa64c22cbcf0 EFLAGS: 00010283=0D
[    8.242581] RAX: 00000000000000df RBX: ffff8ed0b8b7f028 RCX: 00000000000=
00000=0D
[    8.244138] RDX: 0000000000000000 RSI: 00000000000000e2 RDI: ffff8ed0bdb=
d6608=0D
[    8.245664] RBP: ffffaa64c22cbe80 R08: ffff8ed0bdbd6608 R09: 00000000000=
00000=0D
[    8.247029] R10: 0000000000000000 R11: 0000000000000000 R12: 00000000000=
00000=0D
[    8.248023] R13: ffff8ed0b52045a0 R14: ffff8ed0b5204540 R15: ffff8ed0b8b=
7f000=0D
[    8.249042] FS:  0000000000000000(0000) GS:ffff8ed0bda00000(0000) knlGS:=
0000000000000000=0D
[    8.250191] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=0D
[    8.251007] CR2: 00005601514547c0 CR3: 00000000722c4006 CR4: 00000000003=
60ee0=0D
[    8.252007] Call Trace:=0D
[    8.252356]  ? __lock_acquire+0x24a/0xf80=0D
[    8.252946]  ? __lock_acquired+0x1eb/0x310=0D
[    8.253574]  ? kjournald2+0xe3/0x3a0=0D
[    8.254108]  kjournald2+0xe3/0x3a0=0D
[    8.254567]  ? replenish_dl_entity.cold+0x1d/0x1d=0D
[    8.255364]  ? __jbd2_debug+0x50/0x50=0D
[    8.255886]  kthread+0x126/0x140=0D
[    8.256408]  ? kthread_delayed_work_timer_fn+0xa0/0xa0=0D
[    8.257324]  ret_from_fork+0x3a/0x50=0D
[    8.257916] ---[ end trace 9acad1489f655cc4 ]---=0D
[    8.258799] RIP: 0010:jbd2_journal_commit_transaction+0x1565/0x1f35=0D
[    8.259742] Code: f0 fe ff ff 48 c7 c2 b8 52 3a 8c be 4e 00 00 00 48 c7 =
c7 3f 06 3f 8c c6 05 a8 c5 5a 01 01 e8 8f 15 d4 ff e9 cc fe ff ff 0f 0b <0f=
> 0b 0f 0b 0f 0b e8 10 a0 d5 ff 85 c0 0f 85 15 fb ff ff 48 c7 c2=0D
[    8.264348] RSP: 0018:ffffaa64c22cbcf0 EFLAGS: 00010283=0D
[    8.265803] RAX: 00000000000000df RBX: ffff8ed0b8b7f028 RCX: 00000000000=
00000=0D
[    8.267610] RDX: 0000000000000000 RSI: 00000000000000e2 RDI: ffff8ed0bdb=
d6608=0D
[    8.269498] RBP: ffffaa64c22cbe80 R08: ffff8ed0bdbd6608 R09: 00000000000=
00000=0D
[    8.271295] R10: 0000000000000000 R11: 0000000000000000 R12: 00000000000=
00000=0D
[    8.273021] R13: ffff8ed0b52045a0 R14: ffff8ed0b5204540 R15: ffff8ed0b8b=
7f000=0D
[    8.274792] FS:  0000000000000000(0000) GS:ffff8ed0bda00000(0000) knlGS:=
0000000000000000=0D
[    8.276789] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=0D
[    8.278152] CR2: 00005601514547c0 CR3: 00000000722c4006 CR4: 00000000003=
60ee0=0D
[    8.279796] ------------[ cut here ]------------=0D
[    8.280909] WARNING: CPU: 1 PID: 1384 at kernel/exit.c:723 do_exit+0x47/=
0xb70=0D
[    8.282588] CPU: 1 PID: 1384 Comm: jbd2/vdc-8 Tainted: G      D         =
  5.4.0-rc3-xfstests-00022-g6db1a59f1c6a-dirty #1234=0D
[    8.284979] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.12.0-1 04/01/2014=0D
[    8.286909] RIP: 0010:do_exit+0x47/0xb70=0D
[    8.287809] Code: 00 00 48 89 44 24 38 31 c0 65 48 8b 1c 25 c0 5d 01 00 =
48 8b 83 20 12 00 00 48 85 c0 74 0e 48 8b 10 48 39 d0 0f 84 71 04 00 00 <0f=
> 0b 65 44 8b 25 07 fa 15 75 41 81 e4 00 ff 1f 00 44 89 64 24 0c=0D
[    8.290621] RSP: 0018:ffffaa64c22cbee0 EFLAGS: 00010216=0D
[    8.291398] RAX: ffffaa64c22cbdc0 RBX: ffff8ed0b5aa6400 RCX: 00000000000=
00000=0D
[    8.292582] RDX: ffff8ed0ba5e4548 RSI: 0000000000000000 RDI: 00000000000=
0000b=0D
[    8.293818] RBP: 000000000000000b R08: 0000000000000000 R09: 00000000000=
00000=0D
[    8.295187] R10: 0000000000000008 R11: ffffaa64c22cba1d R12: 00000000000=
0000b=0D
[    8.296506] R13: 0000000000000002 R14: 0000000000000006 R15: ffff8ed0b5a=
a6400=0D
[    8.297843] FS:  0000000000000000(0000) GS:ffff8ed0bda00000(0000) knlGS:=
0000000000000000=0D
[    8.299363] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=0D
[    8.300503] CR2: 00005601514547c0 CR3: 00000000722c4006 CR4: 00000000003=
60ee0=0D
[    8.301841] Call Trace:=0D
[    8.302275]  ? __jbd2_debug+0x50/0x50=0D
[    8.303003]  ? kthread+0x126/0x140=0D
[    8.303754]  rewind_stack_do_exit+0x17/0x20=0D
[    8.304485] irq event stamp: 134503=0D
[    8.305232] hardirqs last  enabled at (134503): [<ffffffff8ae017ea>] tra=
ce_hardirqs_on_thunk+0x1a/0x20=0D
[    8.306951] hardirqs last disabled at (134501): [<ffffffff8bc002b0>] __d=
o_softirq+0x2b0/0x42a=0D
[    8.308579] softirqs last  enabled at (134502): [<ffffffff8bc0032a>] __d=
o_softirq+0x32a/0x42a=0D
[    8.310100] softirqs last disabled at (134495): [<ffffffff8aeb84d3>] irq=
_exit+0xb3/0xc0=0D
[    8.311524] ---[ end trace 9acad1489f655cc5 ]---=0D
QEMU: Terminated
=0D
--/9DWx/yDrRhgMJTb--
