Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59D4430D50E
	for <lists+linux-ext4@lfdr.de>; Wed,  3 Feb 2021 09:21:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232492AbhBCIU0 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 3 Feb 2021 03:20:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:39970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232242AbhBCIUZ (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 3 Feb 2021 03:20:25 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id EB1E164F68
        for <linux-ext4@vger.kernel.org>; Wed,  3 Feb 2021 08:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612340384;
        bh=OMhALt6rk2nWecJl5lDTURYT1F5pjSwdhPkWF2VRKWk=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=V59e82sP0oHoI9ImkbeIv69s6bzcaCBmyvXtVZwRbrqMILIWyl5j9IaJeSRDWFoy/
         dQzrmg5XH3nfSQZfr1FxU9OcyZ6XJbY4/2XYEeaxxoXSLH+L/0btuOIzK+FlGtmL1x
         sGUw57IMV1CLuLaakAZ54Yw5xq1mmOwpmT28yjcOVDkcofs/9p2Ws3NXn4I7VdTnP5
         uZj/gbB548jPBNzQANo+7GDZhd0cSLbIRJdvXNVKLc4SvSJQwBhZsP12hphwBSJio1
         HpIyqZDwP0hNXWHnONIGC7jhgbf/JSd/DxPU7uT1ikZuFUVwyUw/rN6BM5EPdjO6IA
         Ruh3zc4nAuj4A==
Received: by pdx-korg-bugzilla-2.web.codeaurora.org (Postfix, from userid 48)
        id E076765332; Wed,  3 Feb 2021 08:19:43 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 210185] kernel BUG at fs/ext4/page-io.c:126!
Date:   Wed, 03 Feb 2021 08:19:43 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: gernot.poerner@web.de
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-210185-13602-RXKtJJk3FS@https.bugzilla.kernel.org/>
In-Reply-To: <bug-210185-13602@https.bugzilla.kernel.org/>
References: <bug-210185-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D210185

--- Comment #14 from gpo (gernot.poerner@web.de) ---
This is on Debian Buster running 5.x kernels from backports. These are VMs =
(on
kvm) with 4 cores/32G Ram each. They are running as kubernetes workers.

When we set those up with Debian which in our image comes with kernel 5.9 t=
hey
constantly crashed after a while with:

[58832.748868] ------------[ cut here ]------------

[58832.749391] kernel BUG at fs/ext4/page-io.c:126!

[58832.749797] invalid opcode: 0000 [#1] SMP PTI

[58832.750166] CPU: 3 PID: 4233 Comm: kworker/u8:4 Not tainted
5.9.0-0.bpo.2-amd64 #1 Debian 5.9.6-1~bpo10+1

[58832.750903] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS

[58832.751468] Workqueue: ext4-rsv-conversion ext4_end_io_rsv_work [ext4]

[58832.752001] RIP: 0010:ext4_finish_bio+0x248/0x250 [ext4]

[58832.752434] Code: c7 a0 d0 66 c0 e8 d8 a0 03 f3 85 c0 0f 84 4c ff ff ff =
e9
f8 37 02 00 49 8b 44 24 28 4c 89 64 24 28 48 89 04 24 e9 51 fe ff ff <0f> 0=
b 66
0f 1f 44 00 00 66 66 66 66 90 41 57 41 56 41 55 41 54 55

[58832.753829] RSP: 0018:ffffb7b603637dc0 EFLAGS: 00010246

[58832.754264] RAX: 0000000000000081 RBX: ffff8c042706ae40 RCX:
0000000000000001

[58832.754822] RDX: 0000000000000000 RSI: 0000000000001000 RDI:
ffff8c042706ae40

[58832.755378] RBP: 0000000000001000 R08: 0000000000000000 R09:
ffffffffc0682b50

[58832.755943] R10: ffff8c0262c7f9d8 R11: 0000000000000001 R12:
ffffefbd1c982cc0

[58832.756510] R13: ffff8c042706ae40 R14: 0000000000000001 R15:
0000000000000000

[58832.757055] FS:  0000000000000000(0000) GS:ffff8c045fd80000(0000)
knlGS:0000000000000000

[58832.757677] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033

[58832.758138] CR2: 00007fd4543d2d80 CR3: 0000000609c48004 CR4:
00000000000606e0

[58832.758703] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
0000000000000000

[58832.759252] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
0000000000000400

[58832.759801] Call Trace:

[58832.760048]  ext4_release_io_end+0x48/0xf0 [ext4]

[58832.760422]  ext4_end_io_rsv_work+0x92/0x180 [ext4]

[58832.760824]  process_one_work+0x1ad/0x370

[58832.761191]  worker_thread+0x30/0x390

[58832.761505]  ? create_worker+0x1a0/0x1a0

[58832.761843]  kthread+0x116/0x130

[58832.762115]  ? kthread_park+0x80/0x80

[58832.762426]  ret_from_fork+0x22/0x30

[58832.762719] Modules linked in: rpcsec_gss_krb5 auth_rpcgss nfsv4
dns_resolver nfs lockd grace nfs_ssc fscache iptable_filter xt_CT xt_multip=
ort
xt_nat xt_tcpudp veth dm_mod xt_set ip_set_hash_ipport ip_set_bitmap_port
ip_set_hash_ipportnet ip_set_hash_ipportip ip_set dummy ip_vs_sh ip_vs_wrr
ip_vs_rr ip_vs xt_comment xt_mark xt_conntrack xt_MASQUERADE
nf_conntrack_netlink xfrm_user xfrm_algo nft_counter xt_addrtype nft_compat
nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c
nf_tables nfnetlink br_netfilter bridge stp llc overlay intel_rapl_msr
intel_rapl_common crc32_pclmul ghash_clmulni_intel aesni_intel libaes
crypto_simd cryptd glue_helper hid_generic usbhid hid virtio_balloon joydev
evdev pcspkr serio_raw qemu_fw_cfg button sunrpc tcp_bbr ip_tables x_tables
autofs4 ext4 crc16 mbcache jbd2 crc32c_generic ata_generic virtio_net
net_failover virtio_blk failover uhci_hcd ata_piix ehci_hcd libata usbcore
scsi_mod crct10dif_pclmul crct10dif_common psmouse usb_common

[58832.762748]  crc32c_intel virtio_pci virtio_ring virtio i2c_piix4

[58832.769326] ---[ end trace 22c803ae565a2f8c ]---

[58832.769746] RIP: 0010:ext4_finish_bio+0x248/0x250 [ext4]

[58832.770183] Code: c7 a0 d0 66 c0 e8 d8 a0 03 f3 85 c0 0f 84 4c ff ff ff =
e9
f8 37 02 00 49 8b 44 24 28 4c 89 64 24 28 48 89 04 24 e9 51 fe ff ff <0f> 0=
b 66
0f 1f 44 00 00 66 66 66 66 90 41 57 41 56 41 55 41 54 55

[58832.771522] RSP: 0018:ffffb7b603637dc0 EFLAGS: 00010246

[58832.771927] RAX: 0000000000000081 RBX: ffff8c042706ae40 RCX:
0000000000000001

[58832.772454] RDX: 0000000000000000 RSI: 0000000000001000 RDI:
ffff8c042706ae40

[58832.772984] RBP: 0000000000001000 R08: 0000000000000000 R09:
ffffffffc0682b50

[58832.773521] R10: ffff8c0262c7f9d8 R11: 0000000000000001 R12:
ffffefbd1c982cc0

[58832.774045] R13: ffff8c042706ae40 R14: 0000000000000001 R15:
0000000000000000

[58832.774566] FS:  0000000000000000(0000) GS:ffff8c045fd80000(0000)
knlGS:0000000000000000

[58832.775157] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033

[58832.775604] CR2: 00007fd4543d2d80 CR3: 0000000609c48004 CR4:
00000000000606e0

[58832.776122] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
0000000000000000

[58832.776636] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
0000000000000400

[58832.777195] Kernel panic - not syncing: Fatal exception

[58832.777840] Kernel Offset: 0x32200000 from 0xffffffff81000000 (relocation
range: 0xffffffff80000000-0xffffffffbfffffff)

[58832.778610] Rebooting in 1 seconds..

Loading Linux 5.9.0-0.bpo.2-amd64 ...

Loading initial ramdisk ...

[    0.000000] Linux version 5.9.0-0.bpo.2-amd64
(debian-kernel@lists.debian.org) (gcc-8 (Debian 8.3.0-6) 8.3.0, GNU ld (GNU
Binutils for Debian) 2.31.1) #1 SMP Debian 5.9.6-1~bpo10+1 (2020-11-19)

[    0.000000] Command line: BOOT_IMAGE=3D/vmlinuz-5.9.0-0.bpo.2-amd64
root=3DUUID=3Db722221a-e6a3-4609-a545-19454bd4f53c ro console=3Dtty0
console=3DttyS0,115200n8 noplymouth elevator=3Dnoop nomodeset net.ifnames=
=3D0
biosdevname=3D0

[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point
registers'

[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'

[    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'

[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256

[    0.000000] x86/fpu: Enabled xstate features 0x7, context size is 832 by=
tes,
using 'standard' format.

[    0.000000] BIOS-provided physical RAM map:

[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff] usable

[    0.000000] BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff] reser=
ved

[    0.000000] BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] reser=
ved

[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000bffdbfff] usable

[    0.000000] BIOS-e820: [mem 0x00000000bffdc000-0x00000000bfffffff] reser=
ved

[    0.000000] BIOS-e820: [mem 0x00000000feffc000-0x00000000feffffff] reser=
ved

[    0.000000] BIOS-e820: [mem 0x00000000fffc0000-0x00000000ffffffff] reser=
ved

[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000083fffffff] usable

This is also how I came upon this bug report.

Downgrading to the latest 5.8 (5.8.0-0.bpo.2-amd64 #1 SMP Debian
5.8.10-1~bpo10+1 (2020-09-26) x86_64 GNU/Linux) stopped the constant crashi=
ng.

The problem here is that we could not identify for sure what really causes =
the
crash, these nodes are running differing workloads since they are kubernete=
s.

I would go ahead and test a later kernel (5.10) on one of these to see if t=
he
problem is fixed in upstream already.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
