Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D3CD468D50
	for <lists+linux-ext4@lfdr.de>; Sun,  5 Dec 2021 21:42:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238841AbhLEUp3 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 5 Dec 2021 15:45:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238788AbhLEUp2 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 5 Dec 2021 15:45:28 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07BCEC061714
        for <linux-ext4@vger.kernel.org>; Sun,  5 Dec 2021 12:42:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 654856113E
        for <linux-ext4@vger.kernel.org>; Sun,  5 Dec 2021 20:42:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C4E10C00446
        for <linux-ext4@vger.kernel.org>; Sun,  5 Dec 2021 20:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638736919;
        bh=RHtBud7zw09/gLG54OIBrZ3EjWsOJ1CA7lb4YIsRobo=;
        h=From:To:Subject:Date:From;
        b=sDR6h4jmMSYsnZ+CzuAw97nHDcaNjT0bU0J5xzaMiHTZul3xyRE7g1qPYRcO+mlvl
         ItwHT/YJ/vODJYxfdzc6fvDNxmaPp1lJ2wS4Y1L3pEtxTr/f8cpWc8uK3TnYIkfuRl
         C2e7EHrl8nTm7susdnJJWz48IoxiB56Iwny0TD4X3MDqisqOAKSFtG2dLhAEHiKZbY
         oHNROWyLwycrETd4xyPDQuUy1tpun/aGRtAGSOSEoTBtLdanNg+IOcjL3UelacKOuN
         laSPgWun8R21bXg33SC35AT9bY+1Q5amEEHZRDXT07+Ehfo2TL57pnK6AwXEBI37Zx
         Qj1RgIk2TWU3w==
Received: by pdx-korg-bugzilla-2.web.codeaurora.org (Postfix, from userid 48)
        id AB32D61179; Sun,  5 Dec 2021 20:41:59 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 215227] New: FUZZ: Page fault in fs/ext4/namei.c: do_split when
 crafted image is mounted and operated
Date:   Sun, 05 Dec 2021 20:41:59 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: tytso@mit.edu
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression attachments.created
Message-ID: <bug-215227-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215227

            Bug ID: 215227
           Summary: FUZZ: Page fault in fs/ext4/namei.c: do_split when
                    crafted image is mounted and operated
           Product: File System
           Version: 2.5
    Kernel Version: 5.16.0-rc3
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: ext4
          Assignee: fs_ext4@kernel-bugs.osdl.org
          Reporter: tytso@mit.edu
        Regression: No

Created attachment 299903
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D299903&action=3Dedit
tmp173

Original report:
https://lore.kernel.org/r/CA+AJg7NwCgxw65JbyWLbbq4aP-vbBzFMEn-=3Dk6DrdTpWMB=
QbxQ@mail.gmail.com

From: Liu Wenqing <wenqingliu0120@gmail.com>

- Overview
A page fault occurs in fs/ext4/namei.c: do_split when a crafted image is
mounted and operated.

- Reproduce
tested on kernel 5.16-rc3, 5.15.X, 5.14.X under root
# mkdir mnt
# mount -t ext4 tmp173.img mnt
# gcc -o tmp173 tmp173.c
# cp tmp173 mnt
# cd mnt
# ./tmp173

-Reason
Seems to be an integer underflow
https://elixir.bootlin.com/linux/v5.16-rc3/source/fs/ext4/namei.c#L1973

- Kernel dump
[   68.084727] loop0: detected capacity change from 0 to 32768
[   68.115775] EXT4-fs (loop0): mounted filesystem with ordered data mode.
Opts: (null). Quota mode: none.
[   68.115793] ext4 filesystem being mounted at
/home/wq/test_crashes/crash_tests/mnt supports timestamps until 2038
(0x7fffffff)
[   80.025429] BUG: unable to handle page fault for address:
ffff88891e93dbf0
[   80.025461] #PF: supervisor read access in kernel mode
[   80.025472] #PF: error_code(0x0000) - not-present page
[   80.025483] PGD 3401067 P4D 3401067 PUD 0
[   80.025493] Oops: 0000 [#1] PREEMPT SMP NOPTI
[   80.025505] CPU: 1 PID: 920 Comm: tmp173 Not tainted 5.16.0-rc3 #2
[   80.025518] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
1.13.0-1ubuntu1.1 04/01/2014
[   80.025534] RIP: 0010:do_split+0x3be/0x8b0
[   80.025564] Code: c8 44 39 d0 0f 87 d0 03 00 00 41 83 e8 01 01 d1 41 83
c1 01 41 83 f8 ff 75 d6 44 89 f8 d1 e8 89 c2 8d 48 ff 48 8d 14 d6 8b 3a
<39> 3c ce 89 7c 24 38 40 0f 94 c7 81 7c 24 18 00 00 04 00 40 0f b6
[   80.025598] RSP: 0018:ffffc90000c6fbf8 EFLAGS: 00010247
[   80.025609] RAX: 0000000000000000 RBX: ffff888105995730 RCX:
00000000ffffffff
[   80.025623] RDX: ffff88811e93dbf8 RSI: ffff88811e93dbf8 RDI:
0000000040ab9e92
[   80.025637] RBP: ffff888105c3f000 R08: 00000000ffffffff R09:
0000000000000001
[   80.025650] R10: 0000000000000200 R11: 00000000a0b6181c R12:
ffffc90000c6fcf8
[   80.025664] R13: ffff88811e93dc00 R14: ffff88811e93dbf8 R15:
0000000000000001
[   80.025678] FS:  00007fb08a0f64c0(0000) GS:ffff8882f5c80000(0000)
knlGS:0000000000000000
[   80.025696] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   80.025707] CR2: ffff88891e93dbf0 CR3: 000000010a7f4006 CR4:
0000000000370ee0
[   80.025723] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
0000000000000000
[   80.025736] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
0000000000000400
[   80.025750] Call Trace:
[   80.025756]  <TASK>
[   80.025763]  make_indexed_dir+0x487/0x5d0
[   80.025775]  ext4_add_entry+0x376/0x410
[   80.025788]  ext4_add_nondir+0x2b/0xc0
[   80.025798]  ext4_symlink+0x2aa/0x450
[   80.025807]  vfs_symlink+0x105/0x1a0
[   80.025821]  do_symlinkat+0xde/0xf0
[   80.025830]  __x64_sys_symlink+0x37/0x40
[   80.025839]  do_syscall_64+0x37/0xb0
[   80.025857]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[   80.025870] RIP: 0033:0x7fb089c00639
[   80.025878] Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05
<48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 1f f8 2c 00 f7 d8 64 89 01 48
[   80.025912] RSP: 002b:00007fffcbbbe558 EFLAGS: 00000286 ORIG_RAX:
0000000000000058
[   80.025928] RAX: ffffffffffffffda RBX: 0000000000000000 RCX:
00007fb089c00639
[   80.025941] RDX: ffffffffffffff80 RSI: 00007fffcbbbe700 RDI:
00007fffcbbbe5e4
[   80.025955] RBP: 00007fffcbbc0910 R08: 00007fffcbbc09f8 R09:
00007fffcbbc09f8
[   80.025968] R10: 00007fffcbbc09f8 R11: 0000000000000286 R12:
000055f1994005f0
[   80.025982] R13: 00007fffcbbc09f0 R14: 0000000000000000 R15:
0000000000000000
[   80.025996]  </TASK>
[   80.026001] Modules linked in: joydev input_leds serio_raw qemu_fw_cfg
iscsi_tcp libiscsi_tcp libiscsi scsi_transport_iscsi autofs4 btrfs
blake2b_generic zstd_compress raid10 raid456 async_raid6_recov async_memcpy
async_pq async_xor async_tx xor raid6_pq raid1 raid0 multipath linear qxl
drm_ttm_helper ttm drm_kms_helper syscopyarea sysfillrect sysimgblt
fb_sys_fops drm crct10dif_pclmul crc32_pclmul ghash_clmulni_intel
hid_generic psmouse usbhid aesni_intel crypto_simd cryptd hid
[   80.026946] CR2: ffff88891e93dbf0
[   80.027378] ---[ end trace f76e3850025c0375 ]---
[   80.027803] RIP: 0010:do_split+0x3be/0x8b0
[   80.028243] Code: c8 44 39 d0 0f 87 d0 03 00 00 41 83 e8 01 01 d1 41 83
c1 01 41 83 f8 ff 75 d6 44 89 f8 d1 e8 89 c2 8d 48 ff 48 8d 14 d6 8b 3a
<39> 3c ce 89 7c 24 38 40 0f 94 c7 81 7c 24 18 00 00 04 00 40 0f b6
[   80.029143] RSP: 0018:ffffc90000c6fbf8 EFLAGS: 00010247
[   80.029602] RAX: 0000000000000000 RBX: ffff888105995730 RCX:
00000000ffffffff
[   80.030064] RDX: ffff88811e93dbf8 RSI: ffff88811e93dbf8 RDI:
0000000040ab9e92
[   80.030521] RBP: ffff888105c3f000 R08: 00000000ffffffff R09:
0000000000000001
[   80.030992] R10: 0000000000000200 R11: 00000000a0b6181c R12:
ffffc90000c6fcf8
[   80.031430] R13: ffff88811e93dc00 R14: ffff88811e93dbf8 R15:
0000000000000001
[   80.031861] FS:  00007fb08a0f64c0(0000) GS:ffff8882f5c80000(0000)
knlGS:0000000000000000
[   80.032293] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   80.032724] CR2: ffff88891e93dbf0 CR3: 000000010a7f4006 CR4:
0000000000370ee0
[   80.033167] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
0000000000000000
[   80.033604] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
0000000000000400

Thanks,
Wenqing Liu

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
