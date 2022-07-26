Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04BD4581A5C
	for <lists+linux-ext4@lfdr.de>; Tue, 26 Jul 2022 21:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbiGZTfa (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 26 Jul 2022 15:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbiGZTf3 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 26 Jul 2022 15:35:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D820012AB7
        for <linux-ext4@vger.kernel.org>; Tue, 26 Jul 2022 12:35:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 72C98614F7
        for <linux-ext4@vger.kernel.org>; Tue, 26 Jul 2022 19:35:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CBEA5C433D6
        for <linux-ext4@vger.kernel.org>; Tue, 26 Jul 2022 19:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658864126;
        bh=ZkXmug23pEpimBtSV3PuZzfDeIYTkS/DtNHbmhwU1Tk=;
        h=From:To:Subject:Date:From;
        b=eWZq7DGN/YIG8u+ZnQH6DO0kDD6quvIzwKXG7nfQcfoAO0Ck2FNHJiMjuQ61a6Kwl
         7YzLN9XbeWBDjWI6MACqH+Pv5CgTcWBP7k/I45n+LdtcLayBAnU+TnXU1ZbYEX5/wq
         fgoBXEtsusociRiobAtVzEg+7vSgso9TDtycxaNaJoRzxbaBzNNsK4h5fzD1uek+mW
         1LPNj36GhCQKK2IIaNHHqEjky+03VGhrNXleTFOurt5KZ5m1jmNEVEMAppu5YvR8Hk
         d7fD+xR+dey4yPLS8zCtHIuausuWpjT6kKRSAqmoatl+YVGZtdr5Ot7K6neDLP7lf/
         LZFoKvrXCBnNw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id B5C2BC433E7; Tue, 26 Jul 2022 19:35:26 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 216283] New: FUZZ: BUG() triggered in
 fs/ext4/extent.c:ext4_ext_insert_extent() when mount and operate on crafted
 image
Date:   Tue, 26 Jul 2022 19:35:26 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: wenqingliu0120@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression attachments.created
Message-ID: <bug-216283-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216283

            Bug ID: 216283
           Summary: FUZZ: BUG() triggered in
                    fs/ext4/extent.c:ext4_ext_insert_extent() when mount
                    and operate on crafted image
           Product: File System
           Version: 2.5
    Kernel Version: 5.15-5.19-rc8
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: ext4
          Assignee: fs_ext4@kernel-bugs.osdl.org
          Reporter: wenqingliu0120@gmail.com
        Regression: No

Created attachment 301487
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D301487&action=3Dedit
poc and .config

- Overview=20
FUZZ: BUG() triggered in fs/ext4/extent.c:ext4_ext_insert_extent()when mount
and operate on crafted image

- Reproduce=20
Tested on kernel 5.15.57, 5.19-rc8

# mkdir test_crash
# cd test_crash=20
# unzip tmp15.zip
# mkdir mnt
# ./single_test.sh ext4 15

-Kernel dump
[ 1524.446966] loop5: detected capacity change from 0 to 32768
[ 1524.536425] EXT4-fs (loop5): recovery complete
[ 1524.542174] EXT4-fs (loop5): mounted filesystem with ordered data mode.
Quota mode: none.
[ 1524.542850] ext4 filesystem being mounted at /home/wq/test_crashes/mnt
supports timestamps until 2038 (0x7fffffff)
[ 1524.849072] ------------[ cut here ]------------
[ 1524.849076] kernel BUG at fs/ext4/extents.c:1006!
[ 1524.849141] invalid opcode: 0000 [#1] PREEMPT SMP KASAN NOPTI
[ 1524.849167] CPU: 0 PID: 1186 Comm: tmp15 Not tainted 5.19.0-rc8 #1
[ 1524.849193] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
1.13.0-1ubuntu1.1 04/01/2014
[ 1524.849228] RIP: 0010:ext4_ext_insert_extent+0x3b8e/0x43d0
[ 1524.849259] Code: df ba f7 03 00 00 48 c7 c6 e0 9b f8 8d 41 be 8b ff ff =
ff
e8 e4 20 12 00 e9 da f5 ff ff 4c 89 ff e8 a7 91 cf ff e9 a0 f4 ff ff <0f> 0=
b e8
1b 91 cf ff e9 49 f4 ff ff 44 0f b7 fa 50 49 c7 c1 e0 8f
[ 1524.849330] RSP: 0018:ffff88812689f5f8 EFLAGS: 00010286
[ 1524.849353] RAX: 00000000ffffffff RBX: ffff888105227aa8 RCX:
0000000000000000
[ 1524.849381] RDX: ffffffffffffffff RSI: 0000000000017ef8 RDI:
ffff888173197004
[ 1524.849410] RBP: ffff888105227986 R08: 0000000000000001 R09:
ffffed1020af02a9
[ 1524.849438] R10: ffff888105781547 R11: ffffed1020af02a8 R12:
0000000000001013
[ 1524.849466] R13: ffff888103723c58 R14: ffff888173197000 R15:
ffff888173197018
[ 1524.849494] FS:  00007f653cb8b540(0000) GS:ffff888293600000(0000)
knlGS:0000000000000000
[ 1524.849526] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1524.849549] CR2: 000055c5c050c008 CR3: 000000011caae004 CR4:
0000000000370ef0
[ 1524.849579] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
0000000000000000
[ 1524.849610] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
0000000000000400
[ 1524.849638] Call Trace:
[ 1524.849650]  <TASK>
[ 1524.849661]  ? ext4_discard_preallocations+0xd70/0xd70
[ 1524.849686]  ? ext4_ext_shift_extents+0xc50/0xc50
[ 1524.849707]  ? ext4_ext_search_right+0x822/0xc20
[ 1524.849728]  ? _raw_spin_unlock_irqrestore+0x23/0x40
[ 1524.849750]  ext4_ext_map_blocks+0xc86/0x3710
[ 1524.849771]  ? ext4_ext_release+0x10/0x10
[ 1524.849789]  ? do_writepages+0x170/0x590
[ 1524.849819]  ? __filemap_fdatawrite_range+0xa7/0xe0
[ 1524.849859]  ? ext4_sync_file+0x18a/0x9b0
[ 1524.849895]  ? do_fsync+0x38/0x70
[ 1524.849928]  ? __x64_sys_fdatasync+0x32/0x50
[ 1524.849965]  ? mpage_process_page_bufs+0xe8/0x5b0
[ 1524.850005]  ? __pagevec_release+0x7f/0x110
[ 1524.850042]  ? down_write_killable+0x130/0x130
[ 1524.850080]  ? ext4_es_lookup_extent+0x3ae/0x960
[ 1524.850104]  ext4_map_blocks+0x600/0x1460
[ 1524.850123]  ? ext4_issue_zeroout+0x190/0x190
[ 1524.850142]  ? __kasan_slab_alloc+0x90/0xc0
[ 1524.850163]  ext4_writepages+0xffa/0x25e0
[ 1524.850182]  ? __ext4_mark_inode_dirty+0x5f0/0x5f0
[ 1524.850204]  ? __stack_depot_save+0x34/0x540
[ 1524.850223]  ? _raw_spin_lock+0x87/0xda
[ 1524.850245]  ? _raw_spin_lock_irqsave+0xf0/0xf0
[ 1524.850283]  ? kmem_cache_free+0xd3/0x3b0
[ 1524.850320]  ? do_syscall_64+0x38/0x90
[ 1524.851019]  ? entry_SYSCALL_64_after_hwframe+0x63/0xcd
[ 1524.851716]  do_writepages+0x170/0x590
[ 1524.852415]  ? page_writeback_cpu_online+0x20/0x20
[ 1524.853162]  ? avc_has_extended_perms+0xe70/0xe70
[ 1524.853848]  ? may_linkat+0x310/0x310
[ 1524.854524]  ? _raw_spin_lock+0x87/0xda
[ 1524.855182]  ? _raw_spin_lock_irqsave+0xf0/0xf0
[ 1524.855824]  ? wbc_attach_and_unlock_inode+0x21/0x590
[ 1524.856449]  filemap_fdatawrite_wbc+0x11d/0x190
[ 1524.857095]  __filemap_fdatawrite_range+0xa7/0xe0
[ 1524.857686]  ? delete_from_page_cache_batch+0x950/0x950
[ 1524.858274]  ? do_faccessat+0x1d2/0x630
[ 1524.858855]  ? kmem_cache_free+0xd3/0x3b0
[ 1524.859434]  file_write_and_wait_range+0x92/0x100
[ 1524.860013]  ext4_sync_file+0x18a/0x9b0
[ 1524.860587]  do_fsync+0x38/0x70
[ 1524.861193]  __x64_sys_fdatasync+0x32/0x50
[ 1524.861744]  do_syscall_64+0x38/0x90
[ 1524.862284]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[ 1524.862832] RIP: 0033:0x7f653cab073d
[ 1524.863388] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 =
89
f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3=
d 01
f0 ff ff 73 01 c3 48 8b 0d 23 37 0d 00 f7 d8 64 89 01 48
[ 1524.864581] RSP: 002b:00007ffe69164218 EFLAGS: 00000217 ORIG_RAX:
000000000000004b
[ 1524.865245] RAX: ffffffffffffffda RBX: 000055c5c050b720 RCX:
00007f653cab073d
[ 1524.865868] RDX: 00007f653cab073d RSI: ffffffffffffff80 RDI:
0000000000000004
[ 1524.866499] RBP: 00007ffe69168b80 R08: 00007ffe69168c78 R09:
00007ffe69168c78
[ 1524.867134] R10: 00007ffe69168c78 R11: 0000000000000217 R12:
000055c5c050b0a0
[ 1524.867770] R13: 00007ffe69168c70 R14: 0000000000000000 R15:
0000000000000000
[ 1524.868404]  </TASK>
[ 1524.869048] Modules linked in: input_leds joydev serio_raw qemu_fw_cfg x=
fs
autofs4 raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor
async_tx raid1 raid0 multipath linear qxl drm_ttm_helper ttm drm_kms_helper
hid_generic usbhid syscopyarea sysfillrect sysimgblt fb_sys_fops hid drm
crct10dif_pclmul crc32_pclmul ghash_clmulni_intel aesni_intel psmouse
crypto_simd cryptd
[ 1524.871971] ---[ end trace 0000000000000000 ]---
[ 1524.872717] RIP: 0010:ext4_ext_insert_extent+0x3b8e/0x43d0
[ 1524.873715] Code: df ba f7 03 00 00 48 c7 c6 e0 9b f8 8d 41 be 8b ff ff =
ff
e8 e4 20 12 00 e9 da f5 ff ff 4c 89 ff e8 a7 91 cf ff e9 a0 f4 ff ff <0f> 0=
b e8
1b 91 cf ff e9 49 f4 ff ff 44 0f b7 fa 50 49 c7 c1 e0 8f
[ 1524.875375] RSP: 0018:ffff88812689f5f8 EFLAGS: 00010286
[ 1524.876222] RAX: 00000000ffffffff RBX: ffff888105227aa8 RCX:
0000000000000000
[ 1524.877110] RDX: ffffffffffffffff RSI: 0000000000017ef8 RDI:
ffff888173197004
[ 1524.877964] RBP: ffff888105227986 R08: 0000000000000001 R09:
ffffed1020af02a9
[ 1524.878829] R10: ffff888105781547 R11: ffffed1020af02a8 R12:
0000000000001013
[ 1524.879684] R13: ffff888103723c58 R14: ffff888173197000 R15:
ffff888173197018
[ 1524.880561] FS:  00007f653cb8b540(0000) GS:ffff888293600000(0000)
knlGS:0000000000000000
[ 1524.881491] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1524.882372] CR2: 000055c5c050c008 CR3: 000000011caae004 CR4:
0000000000370ef0
[ 1524.883270] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
0000000000000000
[ 1524.884182] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
0000000000000400
[ 1524.885084] ------------[ cut here ]------------
[ 1524.885972] WARNING: CPU: 0 PID: 1186 at kernel/exit.c:741
do_exit+0x1798/0x2740
[ 1524.886885] Modules linked in: input_leds joydev serio_raw qemu_fw_cfg x=
fs
autofs4 raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor
async_tx raid1 raid0 multipath linear qxl drm_ttm_helper ttm drm_kms_helper
hid_generic usbhid syscopyarea sysfillrect sysimgblt fb_sys_fops hid drm
crct10dif_pclmul crc32_pclmul ghash_clmulni_intel aesni_intel psmouse
crypto_simd cryptd
[ 1524.890831] CPU: 0 PID: 1186 Comm: tmp15 Tainted: G      D=20=20=20=20=
=20=20=20=20=20=20
5.19.0-rc8 #1
[ 1524.891858] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
1.13.0-1ubuntu1.1 04/01/2014
[ 1524.892918] RIP: 0010:do_exit+0x1798/0x2740
[ 1524.893959] Code: c0 74 08 3c 03 0f 8e cc 0c 00 00 8b 83 48 13 00 00 65 =
01
05 7a 59 aa 74 e9 92 fc ff ff 48 89 df e8 fd 77 28 00 e9 ec ee ff ff <0f> 0=
b e9
fa e8 ff ff 4c 89 e6 bf 05 06 00 00 e8 d4 72 02 00 e9 b2
[ 1524.896142] RSP: 0018:ffff88812689fe48 EFLAGS: 00010286
[ 1524.897245] RAX: 1ffff11024d12815 RBX: ffff888126893400 RCX:
0000000000000000
[ 1524.898357] RDX: dffffc0000000000 RSI: 0000000000000000 RDI:
ffff8881268940a8
[ 1524.899473] RBP: ffff888126893400 R08: 0000000000000041 R09:
ffffed1024d13000
[ 1524.900604] R10: ffff88829362848b R11: ffffed10526c5091 R12:
000000000000000b
[ 1524.901737] R13: ffffffff8de22ac0 R14: ffff888126893400 R15:
0000000000000000
[ 1524.902863] FS:  00007f653cb8b540(0000) GS:ffff888293600000(0000)
knlGS:0000000000000000
[ 1524.904014] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1524.905156] CR2: 000055c5c050c008 CR3: 000000011caae004 CR4:
0000000000370ef0
[ 1524.906287] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
0000000000000000
[ 1524.907395] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
0000000000000400
[ 1524.908495] Call Trace:
[ 1524.909570]  <TASK>
[ 1524.910628]  ? file_write_and_wait_range+0x92/0x100
[ 1524.911697]  ? mm_update_next_owner+0x6e0/0x6e0
[ 1524.912777]  ? ext4_sync_file+0x18a/0x9b0
[ 1524.913849]  make_task_dead+0xb0/0xc0
[ 1524.914904]  rewind_stack_and_make_dead+0x17/0x17
[ 1524.915952] RIP: 0033:0x7f653cab073d
[ 1524.916963] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 =
89
f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3=
d 01
f0 ff ff 73 01 c3 48 8b 0d 23 37 0d 00 f7 d8 64 89 01 48
[ 1524.918998] RSP: 002b:00007ffe69164218 EFLAGS: 00000217 ORIG_RAX:
000000000000004b
[ 1524.920032] RAX: ffffffffffffffda RBX: 000055c5c050b720 RCX:
00007f653cab073d
[ 1524.921062] RDX: 00007f653cab073d RSI: ffffffffffffff80 RDI:
0000000000000004
[ 1524.922070] RBP: 00007ffe69168b80 R08: 00007ffe69168c78 R09:
00007ffe69168c78
[ 1524.923061] R10: 00007ffe69168c78 R11: 0000000000000217 R12:
000055c5c050b0a0
[ 1524.924051] R13: 00007ffe69168c70 R14: 0000000000000000 R15:
0000000000000000
[ 1524.925023]  </TASK>
[ 1524.925975] ---[ end trace 0000000000000000 ]---

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
