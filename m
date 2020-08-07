Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D64A623ED34
	for <lists+linux-ext4@lfdr.de>; Fri,  7 Aug 2020 14:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728103AbgHGMRt (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 7 Aug 2020 08:17:49 -0400
Received: from kerio.exonet.nl ([178.22.62.240]:57582 "EHLO kerio.exonet.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727783AbgHGMRs (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 7 Aug 2020 08:17:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
        d=exonet.nl; s=mail;
        h=from:subject:date:message-id:to:mime-version:content-type:
         content-transfer-encoding;
        bh=uVXtXHAq5sxOZXcqzMUzPapkM1Z2DSIR+IaeaGVZ5TM=;
        b=Bc7+yuKGYToBnIlKHv6LWGHJMRMP1L2xe9c8gaNz9gUxhnoyLmNcB8ZAA0+gEKzmPGZ4w061tIcuB
         5kPwDCmcCGA6jExFNStIzVRldSnyVH4E9/RNrUt/3Qq00lN0tCv9HkOQhGuNHr82sSNRVuB0RUsaL2
         yv4yg8ZiF+ITyakuGl6oZEyxK//B3jQndL3xii5vEpLqAgPAqk1i7WOQrPiUpYPKwF4xwNvlqLdOX5
         4W7OxXiPyIFzt/qzQanFWdVN1iRngWn721hFIRSBOjU5sG9MmQ9aJhc0JipdHnwz2gPEdc7jAQDKtm
         I8vmcPjRqCQn4aatRM+tJtgI5fkr5nQ==
X-Footer: ZXhvbmV0Lm5s
Received: from [10.3.12.3] ([185.31.247.5])
        (authenticated user h.kraal@exonet.nl)
        by kerio.exonet.nl (Kerio Connect 9.2.11) with ESMTPSA
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
        for linux-ext4@vger.kernel.org;
        Fri, 7 Aug 2020 14:17:43 +0200
From:   Henk Kraal <h.kraal@exonet.nl>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: [EXT4] orphaned inodes on RO device trigger "unable to handle kernel
 paging request at"
Message-Id: <E57F2086-629A-40C3-BA75-916CA0E02445@exonet.nl>
Date:   Fri, 7 Aug 2020 14:17:42 +0200
To:     linux-ext4@vger.kernel.org
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi all,

It seems I=E2=80=99ve triggered some kind of bug (based on the log) when =
trying to mount a device I=E2=80=99m trying to access a EXT4 formatted =
LVM volume on a read-only PVS but as soon as I try to mount (with: -o =
ro,noload) I=E2=80=99m getting a kernel oops. The system is running =
Debian jessie with kernel 3.16.0-11-amd64.

Any suggestions how to get around this issue (if at all)?


/var/log/kern.log:
Aug  7 09:37:38 xoa04-ede1 kernel: [  793.269337] EXT4-fs (dm-2): orphan =
cleanup on readonly fs
Aug  7 09:37:39 xoa04-ede1 kernel: [  794.082158] EXT4-fs error (device =
dm-2): ext4_read_inode_bitmap:177: comm mount: Corrupt inode bitmap - =
block_group =3D 193, inode_bitmap =3D 6291473
Aug  7 09:37:39 xoa04-ede1 kernel: [  794.083736] Buffer I/O error on =
device dm-2, logical block 0
Aug  7 09:37:39 xoa04-ede1 kernel: [  794.084784] lost page write due to =
I/O error on dm-2
Aug  7 09:37:39 xoa04-ede1 kernel: [  794.085747] EXT4-fs error (device =
dm-2): ext4_orphan_get:1086: comm mount: inode bitmap error for orphan =
1580546
Aug  7 09:37:39 xoa04-ede1 kernel: [  794.087649] EXT4-fs (dm-2): =
previous I/O error to superblock detected
Aug  7 09:37:39 xoa04-ede1 kernel: [  794.089161] Buffer I/O error on =
device dm-2, logical block 0
Aug  7 09:37:39 xoa04-ede1 kernel: [  794.090846] lost page write due to =
I/O error on dm-2
Aug  7 09:37:39 xoa04-ede1 kernel: [  794.092414] BUG: unable to handle =
kernel paging request at ffffffffffffff98
Aug  7 09:37:39 xoa04-ede1 kernel: [  794.095168] IP: =
[<ffffffffa01ecbdf>] ext4_fill_super+0x32ef/0x3510 [ext4]
Aug  7 09:37:39 xoa04-ede1 kernel: [  794.096363] PGD 1817067 PUD =
1819067 PMD 0
Aug  7 09:37:39 xoa04-ede1 kernel: [  794.096363] Oops: 0002 [#1] SMP
Aug  7 09:37:39 xoa04-ede1 kernel: [  794.096363] Modules linked in: =
loop binfmt_misc xt_tcpudp ip6t_REJECT ip6table_filter nf_nat_ftp =
xt_REDIRECT xt_conntrack nf_conntrack_ftp xt_LOG xt_limit xt_multiport =
iptable_nat nf_conntrack_ipv4 nf_defrag_ipv4 nf_nat_ipv4 ip6table_mangle =
ip6table_raw ip6table_nat nf_conntrack_ipv6 nf_defrag_ipv6 nf_nat_ipv6 =
nf_nat nf_conntrack ip6_tables iptable_mangle iptable_raw ipt_REJECT =
iptable_filter ip_tables x_tables dm_service_time scsi_dh_rdac xenfs =
xen_privcmd nfsd auth_rpcgss oid_registry sd_mod nfs_acl crc_t10dif =
crct10dif_generic nfs lockd fscache sunrpc ib_iser rdma_cm iw_cm ib_cm =
ib_sa ib_mad ib_core ib_addr iscsi_tcp libiscsi_tcp libiscsi =
scsi_transport_iscsi dm_multipath scsi_dh ppdev joydev ttm =
drm_kms_helper crc32_pclmul parport_pc parport drm evdev aesni_intel =
aes_x86_64 lrw processor gf128mul glue_helper serio_raw pcspkr =
thermal_sys ablk_helper cryptd button fuse autofs4 ext4 crc16 mbcache =
jbd2 dm_mod hid_generic usbhid hid sg sr_mod cdrom ata_generic =
xen_netfront xen_blkfront crct10dif_pclmul crct10dif_common uhci_hcd =
crc32c_intel ehci_hcd ata_piix psmouse i2c_piix4 libata i2c_core usbcore =
scsi_mod usb_common floppy
Aug  7 09:37:39 xoa04-ede1 kernel: [  794.096363] CPU: 1 PID: 2617 Comm: =
mount Not tainted 3.16.0-11-amd64 #1 Debian 3.16.84-1
Aug  7 09:37:39 xoa04-ede1 kernel: [  794.096363] Hardware name: Xen HVM =
domU, BIOS 4.7.6-6.5.1.xcpng 05/16/2019
Aug  7 09:37:39 xoa04-ede1 kernel: [  794.096363] task: ffff8800ea618980 =
ti: ffff8800eac70000 task.ti: ffff8800eac70000
Aug  7 09:37:39 xoa04-ede1 kernel: [  794.096363] RIP: =
0010:[<ffffffffa01ecbdf>]  [<ffffffffa01ecbdf>] =
ext4_fill_super+0x32ef/0x3510 [ext4]
Aug  7 09:37:39 xoa04-ede1 kernel: [  794.096363] RSP: =
0018:ffff8800eac73cb8  EFLAGS: 00010207
Aug  7 09:37:39 xoa04-ede1 kernel: [  794.096363] RAX: ffff88021585b000 =
RBX: ffff8800ea98b000 RCX: ffff88021585b200
Aug  7 09:37:39 xoa04-ede1 kernel: [  794.096363] RDX: ffffffffffffff98 =
RSI: ffff880036620e00 RDI: 0000000000000000
Aug  7 09:37:39 xoa04-ede1 kernel: [  794.096363] RBP: ffff8800d3bb2400 =
R08: 0000000000000082 R09: 000000000000030a
Aug  7 09:37:39 xoa04-ede1 kernel: [  794.096363] R10: 00000000000000d1 =
R11: 0000000000000309 R12: 0000000000000000
Aug  7 09:37:39 xoa04-ede1 kernel: [  794.096363] R13: 000000000000000f =
R14: 0000000000000000 R15: ffff88021585b000
Aug  7 09:37:39 xoa04-ede1 kernel: [  794.096363] FS:  =
00007f57224ee840(0000) GS:ffff880219020000(0000) knlGS:0000000000000000
Aug  7 09:37:39 xoa04-ede1 kernel: [  794.096363] CS:  0010 DS: 0000 ES: =
0000 CR0: 0000000080050033
Aug  7 09:37:39 xoa04-ede1 kernel: [  794.096363] CR2: ffffffffffffff98 =
CR3: 00000000ea778000 CR4: 0000000000360670
Aug  7 09:37:39 xoa04-ede1 kernel: [  794.096363] DR0: 0000000000000000 =
DR1: 0000000000000000 DR2: 0000000000000000
Aug  7 09:37:39 xoa04-ede1 kernel: [  794.096363] DR3: 0000000000000000 =
DR6: 00000000fffe0ff0 DR7: 0000000000000400
Aug  7 09:37:39 xoa04-ede1 kernel: [  794.096363] Stack:
Aug  7 09:37:39 xoa04-ede1 kernel: [  794.096363]  ffff880222fad160 =
ffffffff812cfdf6 ffff8802161cc3c0 0000000010010001
Aug  7 09:37:39 xoa04-ede1 kernel: [  794.096363]  ffff8800ea98b2e0 =
ffff88021585b430 ffff88021585b158 ffff88021585b000
Aug  7 09:37:39 xoa04-ede1 kernel: [  794.096363]  ffff88021585b130 =
0000000000000fad 0000003feac73de0 0000000000000000
Aug  7 09:37:39 xoa04-ede1 kernel: [  794.096363] Call Trace:
Aug  7 09:37:39 xoa04-ede1 kernel: [  794.096363]  [<ffffffff812cfdf6>] =
? string.isra.7+0x36/0xe0
Aug  7 09:37:39 xoa04-ede1 kernel: [  794.096363]  [<ffffffffa01e98f0>] =
? ext4_calculate_overhead+0x3f0/0x3f0 [ext4]
Aug  7 09:37:39 xoa04-ede1 kernel: [  794.096363]  [<ffffffff8115bfd3>] =
? register_shrinker+0x73/0xb0
Aug  7 09:37:39 xoa04-ede1 kernel: [  794.096363]  [<ffffffffa01e98f0>] =
? ext4_calculate_overhead+0x3f0/0x3f0 [ext4]
Aug  7 09:37:39 xoa04-ede1 kernel: [  794.096363]  [<ffffffff811be3db>] =
? mount_bdev+0x1ab/0x1e0
Aug  7 09:37:39 xoa04-ede1 kernel: [  794.096363]  [<ffffffff811bec8b>] =
? mount_fs+0x3b/0x1c0
Aug  7 09:37:39 xoa04-ede1 kernel: [  794.096363]  [<ffffffff811da532>] =
? vfs_kern_mount+0x62/0x110
Aug  7 09:37:39 xoa04-ede1 kernel: [  794.096363]  [<ffffffff811dd07a>] =
? do_mount+0x22a/0xc90
Aug  7 09:37:39 xoa04-ede1 kernel: [  794.096363]  [<ffffffff811968d1>] =
? alloc_pages_current+0x91/0x150
Aug  7 09:37:39 xoa04-ede1 kernel: [  794.096363]  [<ffffffff811dde03>] =
? SyS_mount+0xa3/0xf0
Aug  7 09:37:39 xoa04-ede1 kernel: [  794.096363]  [<ffffffff815412ac>] =
? system_call_fast_compare_end+0x1c/0x21
Aug  7 09:37:39 xoa04-ede1 kernel: [  794.096363] Code: a6 fd ff 48 3d =
00 f0 ff ff 49 89 c6 0f 87 e5 00 00 00 48 8b 83 10 03 00 00 49 8d 56 98 =
4c 89 f7 48 8b 88 00 02 00 00 48 89 51 08 <49> 89 4e 98 48 8d 88 00 02 =
00 00 49 89 4e a0 48 89 90 00 02 00
Aug  7 09:37:39 xoa04-ede1 kernel: [  794.096363] RIP  =
[<ffffffffa01ecbdf>] ext4_fill_super+0x32ef/0x3510 [ext4]
Aug  7 09:37:39 xoa04-ede1 kernel: [  794.096363]  RSP =
<ffff8800eac73cb8>
Aug  7 09:37:39 xoa04-ede1 kernel: [  794.096363] CR2: ffffffffffffff98
Aug  7 09:37:39 xoa04-ede1 kernel: [  794.096363] ---[ end trace =
d6493d5e4917bc66 ]---


I=E2=80=99m not entirely sure how relevant it is but the mount command =
is part of a procedure to access data stored on a read-only virtual disk =
(which is part of a backup solution) which boils down to;
# vhdimount 20200714T234001Z.vhd /mnt/20200714T234001Z
# losetup -P -r -f /mnt/20200714T234001Z/vhdi1
# lsblk /dev/loop0
NAME      MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
loop0       7:0    0   42G  1 loop
|-loop0p1 259:0    0  243M  1 part
|-loop0p2 259:1    0    1K  1 part
`-loop0p5 259:2    0 41.8G  1 part

In the above output the loop0p5 is the PV containing the VG group =
=E2=80=9Csystem=E2=80=9D which contains 2 volumes named root & swap. =
Please note that the procedure example just for illustration, the actual =
procedure in this case involves multiple .vhd each having it=E2=80=99s =
own loopback devices as the VG =E2=80=9Csystem=E2=80=9D is extended with =
multiple disks.

With kind regards,

Henk Kraal

PS: I=E2=80=99m aware of the the age of the OS, I=E2=80=99m fully =
prepped to switch to buster but that path is blocked at this moment.=

