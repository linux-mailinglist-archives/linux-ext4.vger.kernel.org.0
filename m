Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1AA048C4F9
	for <lists+linux-ext4@lfdr.de>; Wed, 12 Jan 2022 14:39:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241145AbiALNjU (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 12 Jan 2022 08:39:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241076AbiALNjU (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 12 Jan 2022 08:39:20 -0500
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 178B0C06173F
        for <linux-ext4@vger.kernel.org>; Wed, 12 Jan 2022 05:39:20 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id c3-20020a9d6c83000000b00590b9c8819aso2540586otr.6
        for <linux-ext4@vger.kernel.org>; Wed, 12 Jan 2022 05:39:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :cc:to;
        bh=EIeVefQWAYzqAFORFpF2h9lqL7biVyHGuywiewH8ie0=;
        b=KwQSCqf2yRxDx+YeLTPMvtdwDBwdC5kbg8IS3pbTxygJNqXc3CNPnxhIfX05yxxvuA
         Kk2xUFvbjSrAP6/OjCUy/ujdBWAUHgF1WcRQ5Ue8JJGxb0RyyHn51PTUw59eJ1qhYRQx
         49vBflGoHarWJPZXI4/jWF3BLWNu1cWanxZ6dW+yGYhfVDyuXs9nfYuDYrAbiNgMLqQk
         PrYFEKys8v7S8XQusMSq0IZQzZarKRjH/F7I/CrjfXZ6qaE5JwnFlQ/+vLroJZsoLGeZ
         K4MmmzIa06EFbkXPD42G568mcAJJzdnxa0b5VEDMO+swRxWq1qgHQkURtJGGn5vUVUxT
         VaRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:cc:to;
        bh=EIeVefQWAYzqAFORFpF2h9lqL7biVyHGuywiewH8ie0=;
        b=3oUFH0JY0ghP7/LR34ojMMGSETT0MCFkoj38RNDRoiiH7GNF2v0+MtKdg00SPM4Buf
         s/b1+5lUDhyXFg580Gg2xld5TrVNY/lqJ7PVRSdix5S+4oXQnFe7128uMggM656bnHKa
         OtwqkLSgIuY0+RfwD0BgFGgMjgd/dEZwP9vuAaKclOm7GOZY1s3y3yR85X8ICbc/Hn4T
         KT+NMXWQmrNU0dVTHE2CueAyMICBDgVXU32hLzHebFXakhQj4xaD3fknBLLeU8mofGnH
         k80FbY2JwcPcTvO7UqW98GW1TyqBeirZU2WxI0li9Z7jjQty3wEKNq5JwREzbrDKz90+
         JHyg==
X-Gm-Message-State: AOAM530xJ317nJTHp5gfhZi64pGfdQqWecmsyPVdhTF9wwgfG+AYRbFv
        Ik8n6u2aj9mW6IJ4PTHVTGdGEiYQV1k=
X-Google-Smtp-Source: ABdhPJzlLNWlXLVpT+RdMH7JCEfPclGC56lEnIzstK9rvY/fV4do6fb3j4c/W9hJMcFGvVTNtZZ+lA==
X-Received: by 2002:a05:6830:1649:: with SMTP id h9mr6383411otr.135.1641994759062;
        Wed, 12 Jan 2022 05:39:19 -0800 (PST)
Received: from [192.168.2.192] ([83.234.50.195])
        by smtp.gmail.com with ESMTPSA id d1sm2477209oop.35.2022.01.12.05.39.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Jan 2022 05:39:18 -0800 (PST)
From:   Artem Blagodarenko <artem.blagodarenko@gmail.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.21\))
Subject: Kernel panic and filesystem corruption in setxattr due to journal
 transaction restart
Message-Id: <A671B859-92F6-468E-964D-E6737BE7DE78@gmail.com>
Date:   Wed, 12 Jan 2022 16:39:14 +0300
Cc:     andrew.perepechko@hpe.com, Theodore Ts'o <tytso@mit.edu>,
        adilger.kernel@dilger.ca
To:     linux-ext4@vger.kernel.org
X-Mailer: Apple Mail (2.3445.104.21)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello,

During recent testing, we have found a repeatable kernel panic and ext4 =
corruption. Andrew Perepechko investigated the root cause and prepared a =
reproducer that works on the current master HEAD

[root@CO82 linux]# git rev-parse HEAD
daadb3bd0e8d3e317e36bc2c1542e86c528665e5


Here is the reproducer:
[root@CO82 ~]# cat setxttr_corrupt.sh=20
#!/bin/bash
dd if=3D/dev/zero of=3D/tmp/ldiskfs bs=3D1M count=3D100
mkfs.ext4 -O ea_inode /tmp/ldiskfs -J size=3D16 -I 512

mkdir -p /tmp/ldiskfs_m
mount -t ext4 /tmp/ldiskfs /tmp/ldiskfs_m -o loop,commit=3D600,no_mbcache
touch /tmp/ldiskfs_m/file{1..1024}

V=3D$(for i in `seq 60000`; do echo -n x ; done)
V1=3D"1$V"
V2=3D"2$V"

while true; do
        setfattr -n user.xattr -v $V /tmp/ldiskfs_m/file{1..1024}
        setfattr -n user.xattr -v $V1 /tmp/ldiskfs_m/file{1..1024} &
        setfattr -n user.xattr -v $V2 /tmp/ldiskfs_m/file{1024..1} &
        wait
done

umount /tmp/ldiskfs_m


Here is an outpost of the test session:
[root@CO82 ~]# sh ./setxttr_corrupt.sh=20
100+0 records in
100+0 records out
104857600 bytes (105 MB, 100 MiB) copied, 0.0674946 s, 1.6 GB/s
mke2fs 1.46.2.wc3 (18-Jun-2021)
Discarding device blocks: done                           =20
Creating filesystem with 102400 1k blocks and 25584 inodes
Filesystem UUID: c328f332-3f48-49de-b9e0-25ca129fd8da
Superblock backups stored on blocks:=20
	8193, 24577, 40961, 57345, 73729


Allocating group tables: done                           =20
Writing inode tables: done                           =20
Creating journal (16384 blocks): done
Writing superblocks and filesystem accounting information: done=20


Kernel BUG from dmesg:
[  275.670724] ------------[ cut here ]------------
[  275.670729] kernel BUG at fs/jbd2/transaction.c:1503!
[  275.670937] invalid opcode: 0000 [#1] PREEMPT SMP PTI
[  275.671128] CPU: 4 PID: 920 Comm: setfattr Not tainted 5.16.0rash+ =
#56
[  275.671352] Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS =
VirtualBox 12/01/2006
[  275.671621] RIP: 0010:jbd2_journal_dirty_metadata+0x1e5/0x220
[  275.671621] Code: 8e 00 4c 89 e7 ba 01 00 00 00 48 89 ee e8 c3 f5 ff =
ff 48 89 df e8 4b ed 8e 00 e9 54 ff ff ff 49 39 6c 24 30 0f 84 86 fe ff =
ff <0f> 0b 4d 8b 4a 78 4c 39 cd 0f 84 3a ff ff ff e9 cf 4e 8a 00 0f 0b
[  275.671621] RSP: 0018:ffffa54e8088fa20 EFLAGS: 00010207
[  275.671621] RAX: 0000000000000000 RBX: ffff914541e80070 RCX: =
0000000000000000
[  275.671621] RDX: 0000000000000001 RSI: ffff9145437a60d0 RDI: =
0000000000000000
[  275.671621] RBP: ffff914543662d00 R08: ffff9145437a60d0 R09: =
ffff9145575103f8
[  275.671621] R10: ffff9145456b5800 R11: 0000000000000004 R12: =
ffff9145563ebf00
[  275.671621] R13: 0000000000000000 R14: ffff9145437a60d0 R15: =
ffff9145563ebf08
[  275.671621] FS:  00007f82fd09f740(0000) GS:ffff91455bd00000(0000) =
knlGS:0000000000000000
[  275.671621] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  275.671621] CR2: 000055d7358b3f08 CR3: 0000000102220004 CR4: =
00000000000706e0
[  275.671621] DR0: 0000000000000000 DR1: 0000000000000000 DR2: =
0000000000000000
[  275.671621] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: =
0000000000000400
[  275.671621] Call Trace:
[  275.671621]  <TASK>
[  275.671621]  __ext4_handle_dirty_metadata+0x55/0x1a0
[  275.671621]  ext4_mark_iloc_dirty+0x143/0x680
[  275.671621]  ext4_xattr_set_handle+0x39a/0x680
[  275.671621]  ext4_xattr_set+0xd1/0x180
[  275.671621]  __vfs_setxattr+0x65/0x80
[  275.671621]  __vfs_setxattr_noperm+0x6b/0x200
[  275.671621]  vfs_setxattr+0x9d/0x180
[  275.671621]  setxattr+0x11f/0x180
[  275.671621]  ? kmem_cache_alloc+0x2e/0x1a0
[  275.671621]  ? getname_flags+0x65/0x1e0
[  275.671621]  ? preempt_count_add+0x44/0x90
[  275.671621]  path_setxattr+0xc2/0xe0
[  275.671621]  __x64_sys_setxattr+0x22/0x30
[  275.671621]  do_syscall_64+0x3a/0x80
[  275.671621]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[  275.671621] RIP: 0033:0x7f82fc9b3dae
[  275.671621] Code: 48 8b 0d dd 20 2c 00 f7 d8 64 89 01 48 83 c8 ff c3 =
66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 49 89 ca b8 bc 00 00 00 0f =
05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d aa 20 2c 00 f7 d8 64 89 01 48
[  275.671621] RSP: 002b:00007fff8edd7388 EFLAGS: 00000246 ORIG_RAX: =
00000000000000bc
[  275.671621] RAX: ffffffffffffffda RBX: 00005621ae002300 RCX: =
00007f82fc9b3dae
[  275.671621] RDX: 00005621ae002300 RSI: 00007fff8eddae48 RDI: =
00007fff8ede9cae
[  275.671621] RBP: 00007fff8ede9cae R08: 0000000000000000 R09: =
0000000000000003
[  275.671621] R10: 000000000000ea61 R11: 0000000000000246 R12: =
00007fff8eddae48
[  275.671621] R13: 00007fff8edd74b0 R14: 0000000000000000 R15: =
0000000000000000
[  275.671621]  </TASK>
[  275.671621] Modules linked in:
[  275.683183] ---[ end trace 6c451d27803f53e0 ]=E2=80=94=20


The corresponding line of code would map to:
                J_ASSERT_JH(jh, jh->b_transaction =3D=3D transaction ||
                                jh->b_next_transaction =3D=3D =
transaction);

More precisely, jh is associated with an actively committing transaction =
in its disk writing phase (i.e. t_updates already dropped to zero).

After a bit of tracing, we've found that the transaction is restarting =
when changing a large EA to another large EA, which causes a new EA =
inode to be allocated and the old inode to be freed. The truncate part =
of the old inode release sometimes fails to extend current transaction =
and has to restart it (this stack from test session on LDISKFS, ldiskfs_ =
prefix can be changed to the ext4_):

mdt03_024-198115 [012] 45670.650452: kernel_stack:         <stack trace>
=3D> trace_event_raw_event_jbd2_handle_start_class (ffffffffc0c7e60c)
=3D> jbd2__journal_restart (ffffffffc0c75b5c)
=3D> ldiskfs_datasem_ensure_credits (ffffffffc1ac3431)
=3D> ldiskfs_ext_rm_leaf (ffffffffc1ac44e8)
=3D> ldiskfs_ext_remove_space (ffffffffc1ac8240)
=3D> ldiskfs_ext_truncate (ffffffffc1ac953a)
=3D> ldiskfs_truncate (ffffffffc1adbdcb)
=3D> ldiskfs_evict_inode (ffffffffc1adcc71)
=3D> evict (ffffffff84f37202)
=3D> ldiskfs_xattr_set_entry (ffffffffc1abcf1e)
=3D> ldiskfs_xattr_ibody_set (ffffffffc1abd5be)
=3D> ldiskfs_xattr_set_handle (ffffffffc1abf9e4)
=3D> ldiskfs_xattr_set (ffffffffc1abfd70)
=3D> __vfs_setxattr (ffffffff84f431b6)
=3D> osd_xattr_set (ffffffffc1b7891d)
=3D> lod_sub_xattr_set (ffffffffc17da152)
=3D> lod_generate_and_set_lovea (ffffffffc17c7d8c)
=3D> lod_striped_create (ffffffffc17c81d0)
=3D> lod_layout_change (ffffffffc17c839b)
=3D> mdd_layout_change (ffffffffc1850f7d)
=3D> mdt_layout_change (ffffffffc18aeaf1)
=3D> mdt_intent_layout (ffffffffc18b5e30)
=3D> mdt_intent_opc (ffffffffc18ac778)
=3D> mdt_intent_policy (ffffffffc18b3ba6)
=3D> ldlm_lock_enqueue (ffffffffc138ffff)
=3D> ldlm_handle_enqueue0 (ffffffffc13b811f)
=3D> tgt_enqueue (ffffffffc1441b14)
=3D> tgt_request_handle (ffffffffc14465cd)
=3D> ptlrpc_server_handle_request (ffffffffc13ecaea)
=3D> ptlrpc_main (ffffffffc13f132a)
=3D> kthread (ffffffff84d043a6)
=3D> ret_from_fork (ffffffff8560023f)

One problematic part here is that transaction restart enforces current =
transaction commit so the incomplete transaction will likely commit =
before the kernel panics. It will cause ext4 CORRUPTION after remount. =
The reason why the kernel panic is that we restart this transaction =
somewhere in between of ext4_get_write_access() and =
ext4_mark_dirty_metadata() so the inode bh sticks in the old =
transaction:

ext4_xattr_set_handle(handle_t *handle, struct inode *inode, int
 name_index,
                     =20
const char *name, const
 void *value, size_t value_len,
                     =20
int
 flags)
...
        error =3D ext4_reserve_inode_write(handle, inode, &is.iloc);
...
                error =3D ext4_xattr_ibody_set(handle, inode, &i, &is);
...
                error =3D ext4_mark_iloc_dirty(handle, inode, &is.iloc);
...
}

We don't have a fix yet and haven't yet decided how to fix this.
Andreas suggested moving final iput for the old EA inode out of =
transaction. Despite this can work for EXT4,  may be problematic with =
LUSTRE/LDISKFS layering.

Any ideas how to fix this are welcome.

Thanks.

Best regards,
Artem Blagodarenko.


