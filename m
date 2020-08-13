Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6328A2435EF
	for <lists+linux-ext4@lfdr.de>; Thu, 13 Aug 2020 10:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbgHMI1K (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 13 Aug 2020 04:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbgHMI1J (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 13 Aug 2020 04:27:09 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B668FC061757
        for <linux-ext4@vger.kernel.org>; Thu, 13 Aug 2020 01:27:09 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id q19so2326421pll.0
        for <linux-ext4@vger.kernel.org>; Thu, 13 Aug 2020 01:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=dRXzEU7LtobTFqOMJ7caq0zbU+BLxVmDY8TGf5u+AN8=;
        b=V2G6NnFPKoDzN/LV5FDl4QEk+6SPhsNsOxaZ3dodb+KOHSzHoJTtSKO5gkoO2+4uRq
         FxjvWKH5hf6riD6KMOOcg+JW7dj/c1thUo5sntJKu3tauJAHtNYDJjOBMuCjX2zGgGy+
         K1ByWfi1okPHYoQABoInNTapmdd85GriUHzWcg6nRS5DjsaLJ7njiwnfBPCAVTAFM7p8
         MT8QnfSPBOnfEkTS7C7nkUe2n2MEdDFLtQZ6zBGbr5/hpTCFl5XKuuE58JX6vYx9/ukY
         RA+3NxQvXDN5VCQ3/o6BcNvUd2LrBTerVqBRUfXDJHr0xnUBNW5pNdqiGlEq3w/4dB91
         Vf/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=dRXzEU7LtobTFqOMJ7caq0zbU+BLxVmDY8TGf5u+AN8=;
        b=ZTntQwuUMQ+UaKk+RT4ekUI++NO+U+ZKWcvYS9nixfHBStlXXzCfO6p/7UYSc2CdOB
         I7SV6Gmaw8N49SEgK5UBPkn6bl3n1dSDZQVBf1DnuRmaxtJcHS4rj/VJD5e4VGJIb0Gl
         Qh2RSRI9Z4YJskLbzXe+gxAVxGkygQDzcTjh7ptSmWNNX0SVwoFKMqS+9LxN9Qxq3/Zo
         mYfg4oMBztGr62IMszhZ6dT/EoCOP1bplrq39QyGONt9SUNdhYw3wBQLiqDcMBK0T6l6
         Te8Q2edLKM7Lp1qGp3lkC69OlRJI3pzi/chcahkOzVIWyZsOsFziGodOPaxn2qvt79Wi
         eNIg==
X-Gm-Message-State: AOAM530CYVKCu51H9er3hgARN1R5pygchYvkT2arjD3kKE89pLBJruBu
        1XQ7tQYEfHOVn+lOkOr6baEjENWE9c8fCg==
X-Google-Smtp-Source: ABdhPJxSL61esbWUEiD5dC57hFafa/NQfoSEmhUpwYdwf+JePixMZkkiYNfEna9f0wCjgPJ+IXYk3w==
X-Received: by 2002:a17:90a:bf86:: with SMTP id d6mr3946317pjs.83.1597307229191;
        Thu, 13 Aug 2020 01:27:09 -0700 (PDT)
Received: from [192.168.10.160] (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id r25sm4334307pgv.88.2020.08.13.01.27.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Aug 2020 01:27:08 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <811ADCEA-EF75-469E-B18C-B6B3C3616DF1@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_2A6F1459-BD06-4431-968B-933FA37D8693";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [EXT4] orphaned inodes on RO device trigger "unable to handle
 kernel paging request at"
Date:   Thu, 13 Aug 2020 02:27:05 -0600
In-Reply-To: <E57F2086-629A-40C3-BA75-916CA0E02445@exonet.nl>
Cc:     linux-ext4@vger.kernel.org
To:     Henk Kraal <h.kraal@exonet.nl>
References: <E57F2086-629A-40C3-BA75-916CA0E02445@exonet.nl>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_2A6F1459-BD06-4431-968B-933FA37D8693
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

On Aug 7, 2020, at 6:17 AM, Henk Kraal <h.kraal@exonet.nl> wrote:
>=20
> Hi all,
>=20
> It seems I=E2=80=99ve triggered some kind of bug (based on the log) =
when trying to mount a device I=E2=80=99m trying to access a EXT4 =
formatted LVM volume on a read-only PVS but as soon as I try to mount =
(with: -o ro,noload) I=E2=80=99m getting a kernel oops. The system is =
running Debian jessie with kernel 3.16.0-11-amd64.
>=20
> Any suggestions how to get around this issue (if at all)?

Definitely a newer kernel is likely to avoid the oops (lots of bugs have =
been
fixed over the years from fuzzed filesystems), but that wouldn't =
necessarily
allow you to mount the filesystem, just avoid the crash and return an =
error.

The correct thing to do would be to run "e2fsck -fy" on the device with =
the
latest version of e2fsprogs (1.45.6 IIRC), since it seems there is =
corruption
in the filesystem.  Once that fixes the problem then it is likely that =
the
filesystem can mount without errors.

If the latest e2fsck checks the whole filesystem and does not report an =
error,
and you still see a crash with the latest kernel, then it is more likely =
someone
will look into the details.

Cheers, Andreas

> /var/log/kern.log:
> Aug  7 09:37:38 xoa04-ede1 kernel: [  793.269337] EXT4-fs (dm-2): =
orphan cleanup on readonly fs
> Aug  7 09:37:39 xoa04-ede1 kernel: [  794.082158] EXT4-fs error =
(device dm-2): ext4_read_inode_bitmap:177: comm mount: Corrupt inode =
bitmap - block_group =3D 193, inode_bitmap =3D 6291473
> Aug  7 09:37:39 xoa04-ede1 kernel: [  794.083736] Buffer I/O error on =
device dm-2, logical block 0
> Aug  7 09:37:39 xoa04-ede1 kernel: [  794.084784] lost page write due =
to I/O error on dm-2
> Aug  7 09:37:39 xoa04-ede1 kernel: [  794.085747] EXT4-fs error =
(device dm-2): ext4_orphan_get:1086: comm mount: inode bitmap error for =
orphan 1580546
> Aug  7 09:37:39 xoa04-ede1 kernel: [  794.087649] EXT4-fs (dm-2): =
previous I/O error to superblock detected
> Aug  7 09:37:39 xoa04-ede1 kernel: [  794.089161] Buffer I/O error on =
device dm-2, logical block 0
> Aug  7 09:37:39 xoa04-ede1 kernel: [  794.090846] lost page write due =
to I/O error on dm-2
> Aug  7 09:37:39 xoa04-ede1 kernel: [  794.092414] BUG: unable to =
handle kernel paging request at ffffffffffffff98
> Aug  7 09:37:39 xoa04-ede1 kernel: [  794.095168] IP: =
[<ffffffffa01ecbdf>] ext4_fill_super+0x32ef/0x3510 [ext4]
> Aug  7 09:37:39 xoa04-ede1 kernel: [  794.096363] PGD 1817067 PUD =
1819067 PMD 0
> Aug  7 09:37:39 xoa04-ede1 kernel: [  794.096363] Oops: 0002 [#1] SMP
> Aug  7 09:37:39 xoa04-ede1 kernel: [  794.096363] Modules linked in: =
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
> Aug  7 09:37:39 xoa04-ede1 kernel: [  794.096363] CPU: 1 PID: 2617 =
Comm: mount Not tainted 3.16.0-11-amd64 #1 Debian 3.16.84-1
> Aug  7 09:37:39 xoa04-ede1 kernel: [  794.096363] Hardware name: Xen =
HVM domU, BIOS 4.7.6-6.5.1.xcpng 05/16/2019
> Aug  7 09:37:39 xoa04-ede1 kernel: [  794.096363] task: =
ffff8800ea618980 ti: ffff8800eac70000 task.ti: ffff8800eac70000
> Aug  7 09:37:39 xoa04-ede1 kernel: [  794.096363] RIP: =
0010:[<ffffffffa01ecbdf>]  [<ffffffffa01ecbdf>] =
ext4_fill_super+0x32ef/0x3510 [ext4]
> Aug  7 09:37:39 xoa04-ede1 kernel: [  794.096363] RSP: =
0018:ffff8800eac73cb8  EFLAGS: 00010207
> Aug  7 09:37:39 xoa04-ede1 kernel: [  794.096363] RAX: =
ffff88021585b000 RBX: ffff8800ea98b000 RCX: ffff88021585b200
> Aug  7 09:37:39 xoa04-ede1 kernel: [  794.096363] RDX: =
ffffffffffffff98 RSI: ffff880036620e00 RDI: 0000000000000000
> Aug  7 09:37:39 xoa04-ede1 kernel: [  794.096363] RBP: =
ffff8800d3bb2400 R08: 0000000000000082 R09: 000000000000030a
> Aug  7 09:37:39 xoa04-ede1 kernel: [  794.096363] R10: =
00000000000000d1 R11: 0000000000000309 R12: 0000000000000000
> Aug  7 09:37:39 xoa04-ede1 kernel: [  794.096363] R13: =
000000000000000f R14: 0000000000000000 R15: ffff88021585b000
> Aug  7 09:37:39 xoa04-ede1 kernel: [  794.096363] FS:  =
00007f57224ee840(0000) GS:ffff880219020000(0000) knlGS:0000000000000000
> Aug  7 09:37:39 xoa04-ede1 kernel: [  794.096363] CS:  0010 DS: 0000 =
ES: 0000 CR0: 0000000080050033
> Aug  7 09:37:39 xoa04-ede1 kernel: [  794.096363] CR2: =
ffffffffffffff98 CR3: 00000000ea778000 CR4: 0000000000360670
> Aug  7 09:37:39 xoa04-ede1 kernel: [  794.096363] DR0: =
0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> Aug  7 09:37:39 xoa04-ede1 kernel: [  794.096363] DR3: =
0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Aug  7 09:37:39 xoa04-ede1 kernel: [  794.096363] Stack:
> Aug  7 09:37:39 xoa04-ede1 kernel: [  794.096363]  ffff880222fad160 =
ffffffff812cfdf6 ffff8802161cc3c0 0000000010010001
> Aug  7 09:37:39 xoa04-ede1 kernel: [  794.096363]  ffff8800ea98b2e0 =
ffff88021585b430 ffff88021585b158 ffff88021585b000
> Aug  7 09:37:39 xoa04-ede1 kernel: [  794.096363]  ffff88021585b130 =
0000000000000fad 0000003feac73de0 0000000000000000
> Aug  7 09:37:39 xoa04-ede1 kernel: [  794.096363] Call Trace:
> Aug  7 09:37:39 xoa04-ede1 kernel: [  794.096363]  =
[<ffffffff812cfdf6>] ? string.isra.7+0x36/0xe0
> Aug  7 09:37:39 xoa04-ede1 kernel: [  794.096363]  =
[<ffffffffa01e98f0>] ? ext4_calculate_overhead+0x3f0/0x3f0 [ext4]
> Aug  7 09:37:39 xoa04-ede1 kernel: [  794.096363]  =
[<ffffffff8115bfd3>] ? register_shrinker+0x73/0xb0
> Aug  7 09:37:39 xoa04-ede1 kernel: [  794.096363]  =
[<ffffffffa01e98f0>] ? ext4_calculate_overhead+0x3f0/0x3f0 [ext4]
> Aug  7 09:37:39 xoa04-ede1 kernel: [  794.096363]  =
[<ffffffff811be3db>] ? mount_bdev+0x1ab/0x1e0
> Aug  7 09:37:39 xoa04-ede1 kernel: [  794.096363]  =
[<ffffffff811bec8b>] ? mount_fs+0x3b/0x1c0
> Aug  7 09:37:39 xoa04-ede1 kernel: [  794.096363]  =
[<ffffffff811da532>] ? vfs_kern_mount+0x62/0x110
> Aug  7 09:37:39 xoa04-ede1 kernel: [  794.096363]  =
[<ffffffff811dd07a>] ? do_mount+0x22a/0xc90
> Aug  7 09:37:39 xoa04-ede1 kernel: [  794.096363]  =
[<ffffffff811968d1>] ? alloc_pages_current+0x91/0x150
> Aug  7 09:37:39 xoa04-ede1 kernel: [  794.096363]  =
[<ffffffff811dde03>] ? SyS_mount+0xa3/0xf0
> Aug  7 09:37:39 xoa04-ede1 kernel: [  794.096363]  =
[<ffffffff815412ac>] ? system_call_fast_compare_end+0x1c/0x21
> Aug  7 09:37:39 xoa04-ede1 kernel: [  794.096363] Code: a6 fd ff 48 3d =
00 f0 ff ff 49 89 c6 0f 87 e5 00 00 00 48 8b 83 10 03 00 00 49 8d 56 98 =
4c 89 f7 48 8b 88 00 02 00 00 48 89 51 08 <49> 89 4e 98 48 8d 88 00 02 =
00 00 49 89 4e a0 48 89 90 00 02 00
> Aug  7 09:37:39 xoa04-ede1 kernel: [  794.096363] RIP  =
[<ffffffffa01ecbdf>] ext4_fill_super+0x32ef/0x3510 [ext4]
> Aug  7 09:37:39 xoa04-ede1 kernel: [  794.096363]  RSP =
<ffff8800eac73cb8>
> Aug  7 09:37:39 xoa04-ede1 kernel: [  794.096363] CR2: =
ffffffffffffff98
> Aug  7 09:37:39 xoa04-ede1 kernel: [  794.096363] ---[ end trace =
d6493d5e4917bc66 ]---
>=20
>=20
> I=E2=80=99m not entirely sure how relevant it is but the mount command =
is part of a procedure to access data stored on a read-only virtual disk =
(which is part of a backup solution) which boils down to;
> # vhdimount 20200714T234001Z.vhd /mnt/20200714T234001Z
> # losetup -P -r -f /mnt/20200714T234001Z/vhdi1
> # lsblk /dev/loop0
> NAME      MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
> loop0       7:0    0   42G  1 loop
> |-loop0p1 259:0    0  243M  1 part
> |-loop0p2 259:1    0    1K  1 part
> `-loop0p5 259:2    0 41.8G  1 part
>=20
> In the above output the loop0p5 is the PV containing the VG group =
=E2=80=9Csystem=E2=80=9D which contains 2 volumes named root & swap. =
Please note that the procedure example just for illustration, the actual =
procedure in this case involves multiple .vhd each having it=E2=80=99s =
own loopback devices as the VG =E2=80=9Csystem=E2=80=9D is extended with =
multiple disks.
>=20
> With kind regards,
>=20
> Henk Kraal
>=20
> PS: I=E2=80=99m aware of the the age of the OS, I=E2=80=99m fully =
prepped to switch to buster but that path is blocked at this moment.


Cheers, Andreas






--Apple-Mail=_2A6F1459-BD06-4431-968B-933FA37D8693
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl80+VoACgkQcqXauRfM
H+AHNRAAv/P9zPn5m7vFnLZaaZp/i6BnMjh7BRI6OkjRjMQex6Uf5TKmCA7i72ud
pOFC0gqwKS1cDZq4R2eLakSyeaZ4qdbf8NNUqjt2nZNo+Wpg2RpCsBWa0eUYNHPr
RYtSS7Xn9hHxhM2AfAlTJffnVWe8o88ZL/BrfZucTaSE5U6Pdeet/GDWdDRPcvPt
5K0/Xo6wtBfIYo8EBZ6pgqbOls30qq4dGoqFUk9lANxKEZi9uQyv/azkYXT4wG3/
aP2u8RmuxvAHSiixPE5l2na/DHuyY1cul47MqBzB/naS2ayQ2P8NNiaMeS22kEy1
l/xGJwCNwLYiMqB1Vy0jmZ95d6D2NuyOoXvPInkevO10gxQ29pH1c12dzA/iEFI7
IaepUO5lRIEZPCoFtpF5TTTiESWlccjehcZEY2QFtm9VqAakQTNBcJDQdNzukfYo
jHvlM5E51Z2+CoABaJtTgOz3USamT6Hz8Dd/cBhu2unbZOfeZBgViZ81eqNqVfsr
abfqFRD6EuDasRQjh27SUWkgOKaomIncLdD0SDZsz8SZSoP0mo02NrN6zBk/Mg6r
RsRZaxurapk9CK2Z06oFLvYI51EI8D1LxJSfe6obEBoRYmWR4LyYlsAF1KWT3Xgn
cS++aKnR5n7xuxPbGGYNqUaO3WXb+P++SW7KtlAY5cD10OWaVJY=
=IQmD
-----END PGP SIGNATURE-----

--Apple-Mail=_2A6F1459-BD06-4431-968B-933FA37D8693--
