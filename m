Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05232468D4B
	for <lists+linux-ext4@lfdr.de>; Sun,  5 Dec 2021 21:36:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238781AbhLEUjl (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 5 Dec 2021 15:39:41 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:49130 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238706AbhLEUjl (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 5 Dec 2021 15:39:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 82ACAB80ED2
        for <linux-ext4@vger.kernel.org>; Sun,  5 Dec 2021 20:36:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 15D73C341C6
        for <linux-ext4@vger.kernel.org>; Sun,  5 Dec 2021 20:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638736571;
        bh=qmfa8svmn9yZ5vxpYic+lZiGXwe6cmdLiffJZgGdXIo=;
        h=From:To:Subject:Date:From;
        b=SgPOxHs0woM6pgQcFCrkJdIBztY4BDwTGOnLSiEZZUGgRJyhg6auJXvQ7RkNiMvSk
         08LLdjPaZgBM8QsC97VdfFDp5stFkQsgvxJdzwwDmXE3uhMwdQJIuy+dbPgEV67LcQ
         Ca0qvMIVo/LqYBZYXSI37sovweWEgUKJdtzS/91vVU4DQD22NUYA0t3ThLO9sPMV0O
         TtLMNhSWxJM5OVXvpOPxUwjstVF/nszlkCQKlOXwEh/BpS7ql2d5D3xmsRwnPMK7zl
         B7AuqiEni2DhqEr63WH1X+6aH2JehuDN4LvAHh3qZogI9/AXAEjx8fNWyQgIb9VDUn
         eUlf67K0G4KzQ==
Received: by pdx-korg-bugzilla-2.web.codeaurora.org (Postfix, from userid 48)
        id D52D561179; Sun,  5 Dec 2021 20:36:10 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 215225] New: FUZZ: Page fault and infinite loop after mount and
 operate on crafted image
Date:   Sun, 05 Dec 2021 20:36:10 +0000
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
Message-ID: <bug-215225-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215225

            Bug ID: 215225
           Summary: FUZZ: Page fault and infinite loop after mount and
                    operate on crafted image
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

Created attachment 299901
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D299901&action=3Dedit
tmp38.zip

From: Liu Wenqing <wenqingliu0120@gmail.com>

- Overview
Page fault and infinite loop after mount and operate on crafted image.

- Reproduce
tested on kernel 5.16.0-rc3, tested under root.

# mkdir mnt
# mount -t ext4 tmp38.img mnt
# gcc -o tmp38 tmp38.c
# cp tmp38 mnt
# cd mnt
# ./tmp38

- Reason
Seems to be related to integer overflow in fs/ext4/extents_status.c:202

- Kernel dump
[  229.915301] R10: 000000000000001a R11: 0000000000000001 R12:
0000000000000046
[  229.915983] R13: 0000000000000000 R14: 0000000000000009 R15:
0000000000000000
[  229.916540] FS:  0000000000000000(0000) GS:ffff8882f5c80000(0000)
knlGS:0000000000000000
[  229.917364] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  229.918038] CR2: 000002f000000008 CR3: 000000000260a003 CR4:
0000000000370ee0
[  229.918614] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
0000000000000000
[  229.919191] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
0000000000000400
[  229.919762] Call Trace:
[  229.920559]  <TASK>
[  229.921143]  ? ksys_read+0xa1/0xe0
[  229.921702]  rewind_stack_do_exit+0x17/0x17
[  229.922259] RIP: 0033:0x7f28c2609639
[  229.922787] Code: Unable to access opcode bytes at RIP 0x7f28c260960f.
[  229.923312] RSP: 002b:00007ffcd8835228 EFLAGS: 00000203 ORIG_RAX:
0000000000000000
[  229.923833] RAX: ffffffffffffffda RBX: 0000000000000000 RCX:
00007f28c2609639
[  229.924363] RDX: 0000000000000874 RSI: 00007ffcd8835590 RDI:
0000000000000003
[  229.924875] RBP: 00007ffcd88395a0 R08: 00007ffcd8839688 R09:
00007ffcd8839688
[  229.925409] R10: 00007f28c28dad80 R11: 0000000000000203 R12:
000055ae4ba005f0
[  229.925906] R13: 00007ffcd8839680 R14: 0000000000000000 R15:
0000000000000000
[  229.926397]  </TASK>
[  229.926988] ---[ end trace a2c131a00c70ed86 ]---
[  229.927820] Fixing recursive fault but reboot is needed!
[  229.928694] BUG: unable to handle page fault for address:
000002f000000008
[  229.929563] #PF: supervisor write access in kernel mode
[  229.930409] #PF: error_code(0x0002) - not-present page
[  229.931156] PGD 0 P4D 0
[  229.931818] Oops: 0002 [#14] PREEMPT SMP NOPTI
[  229.932458] CPU: 1 PID: 1058 Comm: tmp38 Tainted: G      D W
5.16.0-rc3 #2
[  229.933008] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
1.13.0-1ubuntu1.1 04/01/2014
[  229.933525] RIP: 0010:blk_flush_plug+0xb2/0x120
[  229.934056] Code: 24 08 48 89 02 48 89 50 08 4c 89 7d 18 4c 89 7d 20 48
8b 44 24 08 48 39 d8 74 bf 48 8b 7c 24 08 44 89 f6 48 8b 47 08 48 8b 17
<48> 89 42 08 48 89 10 4c 89 2f 4c 89 67 08 48 8b 47 10 ff d0 0f 1f
[  229.935609] RSP: 0018:ffffc900006dbe90 EFLAGS: 00010293
[  229.936757] RAX: ffffc900006dbe98 RBX: ffffc900006dbe98 RCX:
ffff888102d8cea0
[  229.937597] RDX: 000002f000000000 RSI: 0000000000000001 RDI:
ffff888102d8cea0
[  229.938213] RBP: ffffc900006dbbc0 R08: 0000000000000000 R09:
0000000000000001
[  229.938851] R10: 000000000000001a R11: 0000000000000001 R12:
dead000000000122
[  229.939352] R13: dead000000000100 R14: 0000000000000001 R15:
ffffc900006dbbd8
[  229.939808] FS:  0000000000000000(0000) GS:ffff8882f5c80000(0000)
knlGS:0000000000000000
[  229.940280] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  229.940779] CR2: 000002f000000008 CR3: 000000000260a003 CR4:
0000000000370ee0
[  229.941247] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
0000000000000000
[  229.941765] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
0000000000000400
[  229.942300] Call Trace:
[  229.942729]  <TASK>
[  229.943161]  schedule+0x96/0xc0
[  229.943588]  do_exit+0x9be/0xc10
[  229.944003]  ? ksys_read+0xa1/0xe0
[  229.944445]  rewind_stack_do_exit+0x17/0x17
[  229.944862] RIP: 0033:0x7f28c2609639
[  229.945354] Code: Unable to access opcode bytes at RIP 0x7f28c260960f.
[  229.945802] RSP: 002b:00007ffcd8835228 EFLAGS: 00000203 ORIG_RAX:
0000000000000000
[  229.946241] RAX: ffffffffffffffda RBX: 0000000000000000 RCX:
00007f28c2609639
[  229.946708] RDX: 0000000000000874 RSI: 00007ffcd8835590 RDI:
0000000000000003
[  229.947145] RBP: 00007ffcd88395a0 R08: 00007ffcd8839688 R09:
00007ffcd8839688
[  229.947668] R10: 00007f28c28dad80 R11: 0000000000000203 R12:
000055ae4ba005f0
[  229.948149] R13: 00007ffcd8839680 R14: 0000000000000000 R15:
0000000000000000
[  229.948632]  </TASK>
[  229.949101] Modules linked in: joydev input_leds serio_raw qemu_fw_cfg
iscsi_tcp libiscsi_tcp libiscsi scsi_transport_iscsi autofs4 btrfs
blake2b_generic zstd_compress raid10 raid456 async_raid6_recov async_memcpy
async_pq async_xor async_tx xor raid6_pq raid1 raid0 multipath linear qxl
drm_ttm_helper ttm drm_kms_helper syscopyarea sysfillrect sysimgblt
fb_sys_fops drm hid_generic usbhid crct10dif_pclmul crc32_pclmul hid
ghash_clmulni_intel psmouse aesni_intel crypto_simd cryptd
[  229.951134] CR2: 000002f000000008
[  229.951637] ---[ end trace a2c131a00c70ed87 ]---
[  229.952124] RIP: 0010:__es_tree_search+0x59/0x60
[  229.952606] Code: 25 48 8b 48 08 48 85 c9 75 df 39 f2 77 16 03 50 1c 72
19 83 ea 01 39 d6 76 08 48 89 c7 e9 5f 97 1f 00 31 c0 f3 c3 f3 c3 f3 c3
<0f> 0b 0f 0b 0f 1f 00 0f 1f 44 00 00 4d 85 c0 41 57 49 89 ff 41 56
[  229.953657] RSP: 0018:ffffc900006db838 EFLAGS: 00010257
[  229.954152] RAX: ffff888105d27258 RBX: 0000000000000001 RCX:
0000000000000000
[  229.954677] RDX: 0000000000000001 RSI: 0000000000000001 RDI:
ffff8881059abea8
[  229.955236] RBP: ffff8881059abc00 R08: 47ffffffffffffff R09:
0000000000000000
[  229.955752] R10: 0000000000000009 R11: 0000000000000001 R12:
0000000000000001
[  229.956276] R13: ffff8881059abeb8 R14: ffffffffffffffff R15:
0000000000000002
[  229.956793] FS:  0000000000000000(0000) GS:ffff8882f5c80000(0000)
knlGS:0000000000000000
[  229.957357] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  229.957885] CR2: 000002f000000008 CR3: 000000000260a003 CR4:
0000000000370ee0
[  229.958530] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
0000000000000000
[  229.959063] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
0000000000000400
[  229.959561] ------------[ cut here ]------------
[  229.960034] WARNING: CPU: 1 PID: 1058 at kernel/exit.c:745
do_exit+0x45/0xc10
[  229.960545] Modules linked in: joydev input_leds serio_raw qemu_fw_cfg
iscsi_tcp libiscsi_tcp libiscsi scsi_transport_iscsi autofs4 btrfs
blake2b_generic zstd_compress raid10 raid456 async_raid6_recov async_memcpy
async_pq async_xor async_tx xor raid6_pq raid1 raid0 multipath linear qxl
drm_ttm_helper ttm drm_kms_helper syscopyarea sysfillrect sysimgblt
fb_sys_fops drm hid_generic usbhid crct10dif_pclmul crc32_pclmul hid
ghash_clmulni_intel psmouse aesni_intel crypto_simd cryptd
[  229.962759] CPU: 1 PID: 1058 Comm: tmp38 Tainted: G      D W
5.16.0-rc3 #2
[  229.963354] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
1.13.0-1ubuntu1.1 04/01/2014
[  229.963901] RIP: 0010:do_exit+0x45/0xc10
[  229.964533] Code: 48 83 ec 28 65 48 8b 04 25 28 00 00 00 48 89 44 24 20
31 c0 48 8b 83 a8 0c 00 00 48 85 c0 74 0c 48 83 38 00 0f 84 08 05 00 00
<0f> 0b 65 8b 0d 22 6b f7 7e 89 c8 25 00 ff ff 00 89 44 24 0c 0f 85
[  229.966104] RSP: 0018:ffffc900006dbef8 EFLAGS: 00010012
[  229.966957] RAX: ffffc900006dbbd8 RBX: ffff888110e69900 RCX:
0000000000000001
[  229.967940] RDX: ffffffff81115902 RSI: ffffffff8232a839 RDI:
0000000000000009
[  229.968764] RBP: 0000000000000000 R08: 0000000000000000 R09:
0000000000000001
[  229.969608] R10: 000000000000001a R11: 0000000000000001 R12:
0000000000000046
[  229.970494] R13: 0000000000000000 R14: 0000000000000009 R15:
0000000000000000
[  229.971375] FS:  0000000000000000(0000) GS:ffff8882f5c80000(0000)
knlGS:0000000000000000
[  229.972224] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  229.973087] CR2: 000002f000000008 CR3: 000000000260a003 CR4:
0000000000370ee0
[  229.973922] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
0000000000000000
[  229.974760] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
0000000000000400
[  229.975575] Call Trace:
[  229.976394]  <TASK>
[  229.977211]  ? ksys_read+0xa1/0xe0
[  229.978007]  rewind_stack_do_exit+0x17/0x17
[  229.978826] RIP: 0033:0x7f28c2609639
[  229.979782] Code: Unable to access opcode bytes at RIP 0x7f28c260960f.
[  229.980647] RSP: 002b:00007ffcd8835228 EFLAGS: 00000203 ORIG_RAX:
0000000000000000
[  229.981493] RAX: ffffffffffffffda RBX: 0000000000000000 RCX:
00007f28c2609639
[  229.982378] RDX: 0000000000000874 RSI: 00007ffcd8835590 RDI:
0000000000000003
[  229.982952] RBP: 00007ffcd88395a0 R08: 00007ffcd8839688 R09:
00007ffcd8839688
[  229.983441] R10: 00007f28c28dad80 R11: 0000000000000203 R12:
000055ae4ba005f0
[  229.983931] R13: 00007ffcd8839680 R14: 0000000000000000 R15:
0000000000000000
[  229.984424]  </TASK>
[  229.984899] ---[ end trace a2c131a00c70ed88 ]---
[  229.985423] Fixing recursive fault but reboot is needed!
[  229.986005] BUG: unable to handle page fault for address:
000002f000000008
[  229.986507] #PF: supervisor write access in kernel mode
[  229.987049] #PF: error_code(0x0002) - not-present page
[  229.987589] PGD 0 P4D 0
[  229.988209] Oops: 0002 [#15] PREEMPT SMP NOPTI
[  229.989026] CPU: 1 PID: 1058 Comm: tmp38 Tainted: G      D W
5.16.0-rc3 #2
[  229.989805] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
1.13.0-1ubuntu1.1 04/01/2014
[  229.990585] RIP: 0010:blk_flush_plug+0xb2/0x120
[  229.991204] Code: 24 08 48 89 02 48 89 50 08 4c 89 7d 18 4c 89 7d 20 48
8b 44 24 08 48 39 d8 74 bf 48 8b 7c 24 08 44 89 f6 48 8b 47 08 48 8b 17
<48> 89 42 08 48 89 10 4c 89 2f 4c 89 67 08 48 8b 47 10 ff d0 0f 1f
[  229.992476] RSP: 0018:ffffc900006dbe90 EFLAGS: 00010293
[  229.993095] RAX: ffffc900006dbe98 RBX: ffffc900006dbe98 RCX:
ffff888102d8cea0
[  229.993789] RDX: 000002f000000000 RSI: 0000000000000001 RDI:
ffff888102d8cea0
[  229.994346] RBP: ffffc900006dbbc0 R08: 0000000000000000 R09:
0000000000000001
[  229.994904] R10: 000000000000001a R11: 0000000000000001 R12:
dead000000000122
[  229.995477] R13: dead000000000100 R14: 0000000000000001 R15:
ffffc900006dbbd8
[  229.996091] FS:  0000000000000000(0000) GS:ffff8882f5c80000(0000)
knlGS:0000000000000000
[  229.996568] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  229.997007] CR2: 000002f000000008 CR3: 000000000260a003 CR4:
0000000000370ee0
[  229.997541] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
0000000000000000
[  229.998144] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
0000000000000400
[  229.998740] Call Trace:
[  229.999171]  <TASK>
[  229.999616]  schedule+0x96/0xc0
[  230.000070]  do_exit+0x9be/0xc10
[  230.000495]  ? ksys_read+0xa1/0xe0
[  230.000892]  rewind_stack_do_exit+0x17/0x17
[  230.001333] RIP: 0033:0x7f28c2609639
[  230.001767] Code: Unable to access opcode bytes at RIP 0x7f28c260960f.
[  230.002187] RSP: 002b:00007ffcd8835228 EFLAGS: 00000203 ORIG_RAX:
0000000000000000
[  230.002651] RAX: ffffffffffffffda RBX: 0000000000000000 RCX:
00007f28c2609639
[  230.003138] RDX: 0000000000000874 RSI: 00007ffcd8835590 RDI:
0000000000000003
[  230.003647] RBP: 00007ffcd88395a0 R08: 00007ffcd8839688 R09:
00007ffcd8839688
[  230.004184] R10: 00007f28c28dad80 R11: 0000000000000203 R12:
000055ae4ba005f0
[  230.004669] R13: 00007ffcd8839680 R14: 0000000000000000 R15:
0000000000000000
[  230.005247]  </TASK>
[  230.005754] Modules linked in: joydev input_leds serio_raw qemu_fw_cfg
iscsi_tcp libiscsi_tcp libiscsi scsi_transport_iscsi autofs4 btrfs
blake2b_generic zstd_compress raid10 raid456 async_raid6_recov async_memcpy
async_pq async_xor async_tx xor raid6_pq raid1 raid0 multipath linear qxl
drm_ttm_helper ttm drm_kms_helper syscopyarea sysfillrect sysimgblt
fb_sys_fops drm hid_generic usbhid crct10dif_pclmul crc32_pclmul hid
ghash_clmulni_intel psmouse aesni_intel crypto_simd cryptd
[  230.007714] CR2: 000002f000000008
[  230.008218] ---[ end trace a2c131a00c70ed89 ]---
[  230.008671] RIP: 0010:__es_tree_search+0x59/0x60
[  230.009219] Code: 25 48 8b 48 08 48 85 c9 75 df 39 f2 77 16 03 50 1c 72
19 83 ea 01 39 d6 76 08 48 89 c7 e9 5f 97 1f 00 31 c0 f3 c3 f3 c3 f3 c3
<0f> 0b 0f 0b 0f 1f 00 0f 1f 44 00 00 4d 85 c0 41 57 49 89 ff 41 56
[  230.010410] RSP: 0018:ffffc900006db838 EFLAGS: 00010257
[  230.010977] RAX: ffff888105d27258 RBX: 0000000000000001 RCX:
0000000000000000
[  230.011542] RDX: 0000000000000001 RSI: 0000000000000001 RDI:
ffff8881059abea8
[  230.012133] RBP: ffff8881059abc00 R08: 47ffffffffffffff R09:
0000000000000000
[  230.012683] R10: 0000000000000009 R11: 0000000000000001 R12:
0000000000000001
[  230.013201] R13: ffff8881059abeb8 R14: ffffffffffffffff R15:
0000000000000002
[  230.013679] FS:  0000000000000000(0000) GS:ffff8882f5c80000(0000)
knlGS:0000000000000000
[  230.014245] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  230.014831] CR2: 000002f000000008 CR3: 000000000260a003 CR4:
0000000000370ee0
[  230.015386] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
0000000000000000
[  230.015973] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
0000000000000400
[  230.016504] ------------[ cut here ]------------
[  230.016971] WARNING: CPU: 1 PID: 1058 at kernel/exit.c:745
do_exit+0x45/0xc10
[  230.017491] Modules linked in: joydev input_leds serio_raw qemu_fw_cfg
iscsi_tcp libiscsi_tcp libiscsi scsi_transport_iscsi autofs4 btrfs
blake2b_generic zstd_compress raid10 raid456 async_raid6_recov async_memcpy
async_pq async_xor async_tx xor raid6_pq raid1 raid0 multipath linear qxl
drm_ttm_helper ttm drm_kms_helper syscopyarea sysfillrect sysimgblt
fb_sys_fops drm hid_generic usbhid crct10dif_pclmul crc32_pclmul hid
ghash_clmulni_intel psmouse aesni_intel crypto_simd cryptd
[  230.019608] CPU: 1 PID: 1058 Comm: tmp38 Tainted: G      D W
5.16.0-rc3 #2
[  230.020170] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
1.13.0-1ubuntu1.1 04/01/2014
[  230.020715] RIP: 0010:do_exit+0x45/0xc10
[  230.021332] Code: 48 83 ec 28 65 48 8b 04 25 28 00 00 00 48 89 44 24 20
31 c0 48 8b 83 a8 0c 00 00 48 85 c0 74 0c 48 83 38 00 0f 84 08 05 00 00
<0f> 0b 65 8b 0d 22 6b f7 7e 89 c8 25 00 ff ff 00 89 44 24 0c 0f 85
[  230.022468] RSP: 0018:ffffc900006dbef8 EFLAGS: 00010012
[  230.023075] RAX: ffffc900006dbbd8 RBX: ffff888110e69900 RCX:
0000000000000001
[  230.023677] RDX: ffffffff81115902 RSI: ffffffff8232a839 RDI:
0000000000000009
[  230.024253] RBP: 0000000000000000 R08: 0000000000000000 R09:
0000000000000001
[  230.024800] R10: 000000000000001a R11: 0000000000000001 R12:
0000000000000046
[  230.025383] R13: 0000000000000000 R14: 0000000000000009 R15:
0000000000000000
[  230.026005] FS:  0000000000000000(0000) GS:ffff8882f5c80000(0000)
knlGS:0000000000000000
[  230.026611] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  230.027184] CR2: 000002f000000008 CR3: 000000000260a003 CR4:
0000000000370ee0
[  230.027769] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
0000000000000000
[  230.028341] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
0000000000000400
[  230.028882] Call Trace:
[  230.029443]  <TASK>
[  230.029975]  ? ksys_read+0xa1/0xe0
[  230.030509]  rewind_stack_do_exit+0x17/0x17
[  230.031044] RIP: 0033:0x7f28c2609639
[  230.031570] Code: Unable to access opcode bytes at RIP 0x7f28c260960f.
[  230.032113] RSP: 002b:00007ffcd8835228 EFLAGS: 00000203 ORIG_RAX:
0000000000000000
[  230.032633] RAX: ffffffffffffffda RBX: 0000000000000000 RCX:
00007f28c2609639
[  230.033159] RDX: 0000000000000874 RSI: 00007ffcd8835590 RDI:
0000000000000003
[  230.033656] RBP: 00007ffcd88395a0 R08: 00007ffcd8839688 R09:
00007ffcd8839688
[  230.034143] R10: 00007f28c28dad80 R11: 0000000000000203 R12:
000055ae4ba005f0
[  230.034631] R13: 00007ffcd8839680 R14: 0000000000000000 R15:
0000000000000000
[  230.035120]  </TASK>
[  230.035593] ---[ end trace a2c131a00c70ed8a ]---
[  230.036133] Fixing recursive fault but reboot is needed!
[  230.036622] BUG: unable to handle page fault for address:
000002f000000008
[  230.037179] #PF: supervisor write access in kernel mode
[  230.037709] #PF: error_code(0x0002) - not-present page
[  230.038257] PGD 0 P4D 0
[  230.038744] Oops: 0002 [#16] PREEMPT SMP NOPTI
[  230.039282] CPU: 1 PID: 1058 Comm: tmp38 Tainted: G      D W
5.16.0-rc3 #2
[  230.039990] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
1.13.0-1ubuntu1.1 04/01/2014
[  230.040604] RIP: 0010:blk_flush_plug+0xb2/0x120
[  230.041112] Code: 24 08 48 89 02 48 89 50 08 4c 89 7d 18 4c 89 7d 20 48
8b 44 24 08 48 39 d8 74 bf 48 8b 7c 24 08 44 89 f6 48 8b 47 08 48 8b 17
<48> 89 42 08 48 89 10 4c 89 2f 4c 89 67 08 48 8b 47 10 ff d0 0f 1f
[  230.042166] RSP: 0018:ffffc900006dbe90 EFLAGS: 00010293
[  230.043013] RAX: ffffc900006dbe98 RBX: ffffc900006dbe98 RCX:
ffff888102d8cea0
[  230.043655] RDX: 000002f000000000 RSI: 0000000000000001 RDI:
ffff888102d8cea0
[  230.044172] RBP: ffffc900006dbbc0 R08: 0000000000000000 R09:
0000000000000001
[  230.044721] R10: 000000000000001a R11: 0000000000000001 R12:
dead000000000122
[  230.045248] R13: dead000000000100 R14: 0000000000000001 R15:
ffffc900006dbbd8
[  230.045777] FS:  0000000000000000(0000) GS:ffff8882f5c80000(0000)
knlGS:0000000000000000
[  230.046234] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  230.046696] CR2: 000002f000000008 CR3: 000000000260a003 CR4:
0000000000370ee0
[  230.047195] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
0000000000000000
[  230.047684] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
0000000000000400
[  230.048265] Call Trace:
[  230.048773]  <TASK>
[  230.049292]  schedule+0x96/0xc0
[  230.049748]  do_exit+0x9be/0xc10
[  230.050178]  ? ksys_read+0xa1/0xe0
[  230.050662]  rewind_stack_do_exit+0x17/0x17
[  230.051242] RIP: 0033:0x7f28c2609639
[  230.051708] Code: Unable to access opcode bytes at RIP 0x7f28c260960f.
[  230.052127] RSP: 002b:00007ffcd8835228 EFLAGS: 00000203 ORIG_RAX:
0000000000000000
[  230.052566] RAX: ffffffffffffffda RBX: 0000000000000000 RCX:
00007f28c2609639
[  230.053037] RDX: 0000000000000874 RSI: 00007ffcd8835590 RDI:
0000000000000003
[  230.053511] RBP: 00007ffcd88395a0 R08: 00007ffcd8839688 R09:
00007ffcd8839688
[  230.053931] R10: 00007f28c28dad80 R11: 0000000000000203 R12:
000055ae4ba005f0
[  230.054375] R13: 00007ffcd8839680 R14: 0000000000000000 R15:
0000000000000000
[  230.054811]  </TASK>
[  230.055221] Modules linked in: joydev input_leds serio_raw qemu_fw_cfg
iscsi_tcp libiscsi_tcp libiscsi scsi_transport_iscsi autofs4 btrfs
blake2b_generic zstd_compress raid10 raid456 async_raid6_recov async_memcpy
async_pq async_xor async_tx xor raid6_pq raid1 raid0 multipath linear qxl
drm_ttm_helper ttm drm_kms_helper syscopyarea sysfillrect sysimgblt
fb_sys_fops drm hid_generic usbhid crct10dif_pclmul crc32_pclmul hid
ghash_clmulni_intel psmouse aesni_intel crypto_simd cryptd
[  230.057268] CR2: 000002f000000008
[  230.057757] ---[ end trace a2c131a00c70ed8b ]---

Wenqing Liu

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
