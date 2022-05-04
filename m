Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3F7451AE22
	for <lists+linux-ext4@lfdr.de>; Wed,  4 May 2022 21:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377610AbiEDTqo (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 4 May 2022 15:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377595AbiEDTqi (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 4 May 2022 15:46:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45D234D9E6
        for <linux-ext4@vger.kernel.org>; Wed,  4 May 2022 12:43:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BACA0B82833
        for <linux-ext4@vger.kernel.org>; Wed,  4 May 2022 19:42:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6DA4AC385B0
        for <linux-ext4@vger.kernel.org>; Wed,  4 May 2022 19:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651693377;
        bh=Mk7jmLPmkoNUobdjMI2hEWUEHKlnln7QsNNTVlKBlsg=;
        h=From:To:Subject:Date:From;
        b=l1UAK3n24Ds0J5Wk0IToJLpNc40cAuGhq9I5BOjCl+VJhGSRv6y/Wb2k5PRtkzSJ7
         z2YQjO6EmkTmnW9pJmqWmzvSIg5lXyO75kmaurzEHdQscDqZKF5Ay6PUxbgZMxbGOi
         FaE7/ECvyYUrnYBJN0C6p8N2CpArt+px7uUDSe6+Y0F9pOmekEL4KYrbMrpMzbcdV8
         AJiNjSJCU6561AwMARGSFuelRs8XvfTfTrHDFNdGOncyyGHdUMBRfjUajrFUXIWNaq
         czAccl5LcJz30Z7AJ0LUig58Iuu/OH7XhBH6fNIXSTTI+8IJwZsKFnsR+gPeYTbIlS
         vTZGhYDurs9YA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 4F727C05FD5; Wed,  4 May 2022 19:42:57 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 215941] New: FUZZ: BUG() triggered in
 fs/ext4/extent.c:ext4_ext_determine_hole() when mount and operate on crafted
 image
Date:   Wed, 04 May 2022 19:42:56 +0000
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
Message-ID: <bug-215941-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215941

            Bug ID: 215941
           Summary: FUZZ: BUG() triggered in
                    fs/ext4/extent.c:ext4_ext_determine_hole() when mount
                    and operate on crafted image
           Product: File System
           Version: 2.5
    Kernel Version: 5.18, 5.17
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

Created attachment 300878
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D300878&action=3Dedit
poc and .config

- Overview=20
FUZZ: BUG() triggered in fs/ext4/extent.c:ext4_ext_determine_hole() and cau=
sing
general protection fault when mount and operate on crafted image

- Reproduce=20
tested on kernel 5.18-rc5, 5.17.X

# mkdir test_crash
# cd test_crash=20
# unzip tmp118.zip
# mkdir mnt
# ./single_test.sh ext4 118

-Kernel dump
[   39.470657] loop5: detected capacity change from 0 to 32768
[   39.500549] EXT4-fs: Warning: mounting with data=3Djournal disables dela=
yed
allocation, dioread_nolock, O_DIRECT and fast_commit support!
[   39.547582] EXT4-fs (loop5): mounted filesystem with journalled data mod=
e.
Quota mode: none.
[   39.547804] ext4 filesystem being mounted at /home/wq/test_crashes/mnt
supports timestamps until 2038 (0x7fffffff)
[   39.695260] EXT4-fs error (device loop5): ext4_mb_generate_buddy:1141: g=
roup
0, block bitmap and bg descriptor inconsistent: 7551 vs 7520 free clusters
[   39.700838] ------------[ cut here ]------------
[   39.700841] kernel BUG at fs/ext4/extents.c:2258!
[   39.700894] invalid opcode: 0000 [#1] PREEMPT SMP KASAN NOPTI
[   39.700922] CPU: 3 PID: 1021 Comm: tmp118 Not tainted 5.18.0-rc5 #1
[   39.700949] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
1.13.0-1ubuntu1.1 04/01/2014
[   39.700984] RIP: 0010:ext4_ext_map_blocks+0x189b/0x3710
[   39.701009] Code: ef 44 39 fb 0f 82 9f 1d 00 00 48 89 f7 44 89 fb e8 0a =
1e
ff ff 41 89 c6 41 89 c5 8d 48 ff 45 29 fe 41 39 c7 0f 85 ef f7 ff ff <0f> 0=
b b9
fe ff ff ff 41 bd ff ff ff ff 31 db 41 be ff ff ff ff e9
[   39.701080] RSP: 0018:ffffc900006d73a8 EFLAGS: 00010246
[   39.701103] RAX: 0000000000000024 RBX: 0000000000000024 RCX:
0000000000000023
[   39.701132] RDX: 0000000000000000 RSI: ffff8881250f3000 RDI:
ffff88810b911968
[   39.701160] RBP: ffff88810b911a78 R08: 0000000000000024 R09:
0000000000002602
[   39.701189] R10: ffff88810b911956 R11: ffff88812cc3b810 R12:
ffffc900006d7760
[   39.701217] R13: 0000000000000024 R14: 0000000000000000 R15:
0000000000000024
[   39.701246] FS:  00007faab09cd540(0000) GS:ffff888293780000(0000)
knlGS:0000000000000000
[   39.701278] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   39.701301] CR2: 000055cb4ab92008 CR3: 000000011f47c004 CR4:
0000000000370ee0
[   39.701332] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
0000000000000000
[   39.701360] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
0000000000000400
[   39.701389] Call Trace:
[   39.701401]  <TASK>
[   39.701412]  ? __kasan_record_aux_stack+0xb1/0xc0
[   39.701435]  ? ext4_ext_release+0x10/0x10
[   39.701453]  ? __radix_tree_lookup+0x9b/0x280
[   39.701474]  ? __queue_work+0x3bc/0xd80
[   39.701493]  ? radix_tree_insert+0x550/0x550
[   39.701513]  ? kmem_cache_alloc+0x134/0x4c0
[   39.701532]  ? down_read+0x126/0x210
[   39.701550]  ? down_write+0x120/0x120
[   39.701567]  ? _raw_read_unlock+0x26/0x40
[   39.701586]  ? ext4_es_lookup_extent+0x3aa/0x960
[   39.701606]  ext4_map_blocks+0x726/0x13f0
[   39.701626]  ? ext4_issue_zeroout+0x180/0x180
[   39.701646]  ? xa_load+0xbc/0x110
[   39.701661]  ? xas_free_nodes+0x280/0x280
[   39.701679]  ? bio_add_page+0x10d/0x170
[   39.701698]  ? kasan_unpoison+0x3e/0x70
[   39.701716]  ext4_mpage_readpages+0xa62/0x19c0
[   39.701738]  ? verity_work+0x90/0x90
[   39.701758]  ? __mod_lruvec_page_state+0x1a9/0x3c0
[   39.701780]  ? __filemap_add_folio+0x512/0xc20
[   39.701805]  read_pages+0x191/0xa60
[   39.701822]  ? __alloc_pages+0x2d6/0x5c0
[   39.701841]  ? pagevec_add_and_need_flush+0xd6/0x110
[   39.702576]  ? file_ra_state_init+0xd0/0xd0
[   39.703289]  ? folio_add_lru+0xa0/0x100
[   39.703999]  ? policy_node+0xb9/0x140
[   39.704688]  page_cache_ra_unbounded+0x25b/0x410
[   39.705391]  filemap_get_pages+0x4f1/0x1270
[   39.706047]  ? filemap_fault+0x1b40/0x1b40
[   39.706698]  ? __stack_depot_save+0x34/0x530
[   39.707342]  ? kasan_save_stack+0x2e/0x40
[   39.707969]  filemap_read+0x28c/0x930
[   39.708578]  ? entry_SYSCALL_64_after_hwframe+0x44/0xae
[   39.709237]  ? filemap_get_pages+0x1270/0x1270
[   39.709814]  ? may_open_dev+0xd0/0xd0
[   39.710374]  new_sync_read+0x2f6/0x540
[   39.710925]  ? __x64_sys_llseek+0x2e0/0x2e0
[   39.711474]  ? __inode_security_revalidate+0xb2/0xd0
[   39.712021]  ? security_file_permission+0x309/0x580
[   39.712566]  vfs_read+0x337/0x460
[   39.713153]  ksys_read+0xed/0x1c0
[   39.713675]  ? vfs_write+0x7b0/0x7b0
[   39.714186]  ? exit_to_user_mode_prepare+0x149/0x160
[   39.714698]  do_syscall_64+0x38/0x90
[   39.715203]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[   39.715722] RIP: 0033:0x7faab08f276d
[   39.716230] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 =
89
f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3=
d 01
f0 ff ff 73 01 c3 48 8b 0d f3 36 0d 00 f7 d8 64 89 01 48
[   39.717403] RSP: 002b:00007ffd87bc35d8 EFLAGS: 00000203 ORIG_RAX:
0000000000000000
[   39.717986] RAX: ffffffffffffffda RBX: 000055cb4ab91940 RCX:
00007faab08f276d
[   39.718577] RDX: 000000000000144b RSI: 00007ffd87bc4840 RDI:
0000000000000003
[   39.719174] RBP: 00007ffd87bc8850 R08: 00007ffd87bc8948 R09:
00007ffd87bc8948
[   39.719774] R10: 00007faab09e8d50 R11: 0000000000000203 R12:
000055cb4ab910a0
[   39.720377] R13: 00007ffd87bc8940 R14: 0000000000000000 R15:
0000000000000000
[   39.720986]  </TASK>
[   39.721589] Modules linked in: joydev input_leds serio_raw qemu_fw_cfg x=
fs
autofs4 raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor
async_tx raid1 raid0 multipath linear hid_generic qxl usbhid hid drm_ttm_he=
lper
ttm drm_kms_helper syscopyarea sysfillrect crct10dif_pclmul sysimgblt
fb_sys_fops crc32_pclmul drm ghash_clmulni_intel aesni_intel psmouse
crypto_simd cryptd
[   39.724453] ---[ end trace 0000000000000000 ]---
[   39.725271] RIP: 0010:ext4_ext_map_blocks+0x189b/0x3710
[   39.726014] Code: ef 44 39 fb 0f 82 9f 1d 00 00 48 89 f7 44 89 fb e8 0a =
1e
ff ff 41 89 c6 41 89 c5 8d 48 ff 45 29 fe 41 39 c7 0f 85 ef f7 ff ff <0f> 0=
b b9
fe ff ff ff 41 bd ff ff ff ff 31 db 41 be ff ff ff ff e9
[   39.727593] RSP: 0018:ffffc900006d73a8 EFLAGS: 00010246
[   39.728424] RAX: 0000000000000024 RBX: 0000000000000024 RCX:
0000000000000023
[   39.729282] RDX: 0000000000000000 RSI: ffff8881250f3000 RDI:
ffff88810b911968
[   39.730101] RBP: ffff88810b911a78 R08: 0000000000000024 R09:
0000000000002602
[   39.730937] R10: ffff88810b911956 R11: ffff88812cc3b810 R12:
ffffc900006d7760
[   39.731766] R13: 0000000000000024 R14: 0000000000000000 R15:
0000000000000024
[   39.732600] FS:  00007faab09cd540(0000) GS:ffff888293780000(0000)
knlGS:0000000000000000
[   39.733508] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   39.734357] CR2: 000055cb4ab92008 CR3: 000000011f47c004 CR4:
0000000000370ee0
[   39.735234] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
0000000000000000
[   39.736104] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
0000000000000400
[   39.737015] ------------[ cut here ]------------
[   39.737865] WARNING: CPU: 3 PID: 1021 at kernel/exit.c:741
do_exit+0x17cb/0x2770
[   39.738751] Modules linked in: joydev input_leds serio_raw qemu_fw_cfg x=
fs
autofs4 raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor
async_tx raid1 raid0 multipath linear hid_generic qxl usbhid hid drm_ttm_he=
lper
ttm drm_kms_helper syscopyarea sysfillrect crct10dif_pclmul sysimgblt
fb_sys_fops crc32_pclmul drm ghash_clmulni_intel aesni_intel psmouse
crypto_simd cryptd
[   39.742529] CPU: 3 PID: 1021 Comm: tmp118 Tainted: G      D=20=20=20=20=
=20=20=20=20=20=20
5.18.0-rc5 #1
[   39.743523] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
1.13.0-1ubuntu1.1 04/01/2014
[   39.744526] RIP: 0010:do_exit+0x17cb/0x2770
[   39.745532] Code: 01 05 99 8c 2a 52 e9 92 fc ff ff 48 89 df e8 5c c5 27 =
00
e9 ec ee ff ff 4c 89 e6 bf 05 06 00 00 e8 6a 4a 02 00 e9 98 eb ff ff <0f> 0=
b e9
c7 e8 ff ff 48 8b 54 24 08 b8 ff ff 37 00 48 c1 e0 2a 48
[   39.747649] RSP: 0018:ffffc900006d7e48 EFLAGS: 00010282
[   39.748716] RAX: 1ffff1102535e195 RBX: ffff888129af0000 RCX:
0000000000000000
[   39.749787] RDX: dffffc0000000000 RSI: 0000000000000000 RDI:
ffff888129af0ca8
[   39.750882] RBP: ffff888129af0000 R08: 0000000000000041 R09:
fffff520000da000
[   39.751966] R10: ffff8882937a84cb R11: ffffed10526f5099 R12:
000000000000000b
[   39.753056] R13: ffffffffb06221c0 R14: ffff888129af0000 R15:
0000000000000000
[   39.754140] FS:  00007faab09cd540(0000) GS:ffff888293780000(0000)
knlGS:0000000000000000
[   39.755247] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   39.756341] CR2: 000055cb4ab92008 CR3: 000000011f47c004 CR4:
0000000000370ee0
[   39.757434] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
0000000000000000
[   39.758500] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
0000000000000400
[   39.759559] Call Trace:
[   39.760590]  <TASK>
[   39.761614]  ? vfs_read+0x337/0x460
[   39.762651]  ? mm_update_next_owner+0x6d0/0x6d0
[   39.763676]  ? vfs_write+0x7b0/0x7b0
[   39.764700]  make_task_dead+0xb0/0xc0
[   39.765709]  rewind_stack_and_make_dead+0x17/0x17
[   39.766719] RIP: 0033:0x7faab08f276d
[   39.767661] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 =
89
f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3=
d 01
f0 ff ff 73 01 c3 48 8b 0d f3 36 0d 00 f7 d8 64 89 01 48
[   39.769610] RSP: 002b:00007ffd87bc35d8 EFLAGS: 00000203 ORIG_RAX:
0000000000000000
[   39.770565] RAX: ffffffffffffffda RBX: 000055cb4ab91940 RCX:
00007faab08f276d
[   39.771537] RDX: 000000000000144b RSI: 00007ffd87bc4840 RDI:
0000000000000003
[   39.772485] RBP: 00007ffd87bc8850 R08: 00007ffd87bc8948 R09:
00007ffd87bc8948
[   39.773455] R10: 00007faab09e8d50 R11: 0000000000000203 R12:
000055cb4ab910a0
[   39.774406] R13: 00007ffd87bc8940 R14: 0000000000000000 R15:
0000000000000000
[   39.775330]  </TASK>
[   39.776226] ---[ end trace 0000000000000000 ]---
[   39.777391] general protection fault, probably for non-canonical address
0xe3fffb240001b5e6: 0000 [#2] PREEMPT SMP KASAN NOPTI
[   39.779488] KASAN: maybe wild-memory-access in range
[0x1ffff920000daf30-0x1ffff920000daf37]
[   39.780507] CPU: 2 PID: 1021 Comm: tmp118 Tainted: G      D W=20=20=20=
=20=20=20=20=20
5.18.0-rc5 #1
[   39.781584] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
1.13.0-1ubuntu1.1 04/01/2014
[   39.782653] RIP: 0010:__blk_flush_plug+0x144/0x610
[   39.783701] Code: 00 4c 8b 74 24 68 0f 85 72 03 00 00 41 80 3c 1a 00 4c =
8b
7d 18 0f 85 8c 03 00 00 49 8d 7f 08 4c 8b 65 20 48 89 fe 48 c1 ee 03 <80> 3=
c 1e
00 0f 85 c9 03 00 00 4c 89 e6 49 89 4f 08 48 c1 ee 03 4c
[   39.787041] RSP: 0018:ffffc900006d7a58 EFLAGS: 00010202
[   39.788145] RAX: ffffc900006d78f8 RBX: dffffc0000000000 RCX:
ffffc900006d7ac0
[   39.789303] RDX: fffff520000daf1f RSI: 03ffff240001b5e6 RDI:
1ffff920000daf32
[   39.790359] RBP: ffffc900006d78e0 R08: 0000000000000001 R09:
ffffed102172234b
[   39.791434] R10: 1ffff920000daf20 R11: ffffed102172234a R12:
ffffc900006d7aa8
[   39.792464] R13: fffff520000daf1f R14: ffffc900006d7ac0 R15:
1ffff920000daf2a
[   39.793483] FS:  0000000000000000(0000) GS:ffff888293700000(0000)
knlGS:0000000000000000
[   39.794442] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   39.795436] CR2: 00007f66080200d8 CR3: 000000022e20e002 CR4:
0000000000370ee0
[   39.796353] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
0000000000000000
[   39.797290] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
0000000000000400
[   39.798158] Call Trace:
[   39.799013]  <TASK>
[   39.799854]  ? _raw_spin_lock_irqsave+0x98/0xf0
[   39.800773]  ? blk_start_plug_nr_ios+0x270/0x270
[   39.801637]  ? _raw_spin_lock_irq+0x8d/0xe0
[   39.802482]  schedule+0x193/0x1f0
[   39.803313]  rwsem_down_write_slowpath+0x5cf/0xee0
[   39.804142]  ? rwsem_down_read_slowpath+0x880/0x880
[   39.805053]  ? lru_lazyfree_fn+0x1400/0x1400
[   39.805874]  ? free_unref_page_commit+0x354/0x800
[   39.806701]  ? remove_vma+0xf8/0x130
[   39.807516]  ? kmem_cache_free+0xc6/0x530
[   39.808335]  down_write+0x104/0x120
[   39.809236]  ? down_write_killable+0x130/0x130
[   39.810059]  ? fcntl_setlk+0x930/0x930
[   39.810880]  ext4_release_file+0x254/0x2e0
[   39.811703]  __fput+0x1e9/0x8b0
[   39.812522]  task_work_run+0xca/0x150
[   39.813382]  do_exit+0x8b6/0x2770
[   39.814176]  ? mm_update_next_owner+0x6d0/0x6d0
[   39.814953]  ? vfs_write+0x7b0/0x7b0
[   39.815713]  make_task_dead+0xb0/0xc0
[   39.816474]  rewind_stack_and_make_dead+0x17/0x17
[   39.817492] RIP: 0033:0x7faab08f276d
[   39.818240] Code: Unable to access opcode bytes at RIP 0x7faab08f2743.
[   39.819005] RSP: 002b:00007ffd87bc35d8 EFLAGS: 00000203 ORIG_RAX:
0000000000000000
[   39.819780] RAX: ffffffffffffffda RBX: 000055cb4ab91940 RCX:
00007faab08f276d
[   39.820551] RDX: 000000000000144b RSI: 00007ffd87bc4840 RDI:
0000000000000003
[   39.821372] RBP: 00007ffd87bc8850 R08: 00007ffd87bc8948 R09:
00007ffd87bc8948
[   39.822126] R10: 00007faab09e8d50 R11: 0000000000000203 R12:
000055cb4ab910a0
[   39.822858] R13: 00007ffd87bc8940 R14: 0000000000000000 R15:
0000000000000000
[   39.823575]  </TASK>
[   39.824270] Modules linked in: joydev input_leds serio_raw qemu_fw_cfg x=
fs
autofs4 raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor
async_tx raid1 raid0 multipath linear hid_generic qxl usbhid hid drm_ttm_he=
lper
ttm drm_kms_helper syscopyarea sysfillrect crct10dif_pclmul sysimgblt
fb_sys_fops crc32_pclmul drm ghash_clmulni_intel aesni_intel psmouse
crypto_simd cryptd
[   39.827352] ---[ end trace 0000000000000000 ]---
[   39.828094] RIP: 0010:ext4_ext_map_blocks+0x189b/0x3710
[   39.828865] Code: ef 44 39 fb 0f 82 9f 1d 00 00 48 89 f7 44 89 fb e8 0a =
1e
ff ff 41 89 c6 41 89 c5 8d 48 ff 45 29 fe 41 39 c7 0f 85 ef f7 ff ff <0f> 0=
b b9
fe ff ff ff 41 bd ff ff ff ff 31 db 41 be ff ff ff ff e9
[   39.830387] RSP: 0018:ffffc900006d73a8 EFLAGS: 00010246
[   39.831172] RAX: 0000000000000024 RBX: 0000000000000024 RCX:
0000000000000023
[   39.831952] RDX: 0000000000000000 RSI: ffff8881250f3000 RDI:
ffff88810b911968
[   39.832766] RBP: ffff88810b911a78 R08: 0000000000000024 R09:
0000000000002602
[   39.833535] R10: ffff88810b911956 R11: ffff88812cc3b810 R12:
ffffc900006d7760
[   39.834302] R13: 0000000000000024 R14: 0000000000000000 R15:
0000000000000024
[   39.835080] FS:  0000000000000000(0000) GS:ffff888293700000(0000)
knlGS:0000000000000000
[   39.835879] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   39.836789] CR2: 00007f66080200d8 CR3: 000000022e20e002 CR4:
0000000000370ee0
[   39.837671] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
0000000000000000
[   39.838588] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
0000000000000400
[   39.839445] Fixing recursive fault but reboot is needed!
[   39.840420] BUG: using smp_processor_id() in preemptible [00000000] code:
tmp118/1021
[   39.841391] caller is __schedule+0x82/0x2300
[   39.842273] CPU: 2 PID: 1021 Comm: tmp118 Tainted: G      D W=20=20=20=
=20=20=20=20=20
5.18.0-rc5 #1
[   39.843221] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
1.13.0-1ubuntu1.1 04/01/2014
[   39.844195] Call Trace:
[   39.845151]  <TASK>
[   39.846012]  dump_stack_lvl+0x45/0x5a
[   39.846959]  check_preemption_disabled+0xdd/0xe0
[   39.847858]  __schedule+0x82/0x2300
[   39.848824]  ? _printk+0xb2/0xe3
[   39.849718]  ? __sched_text_start+0x8/0x8
[   39.850666]  ? _raw_spin_lock_irq+0xe0/0xe0
[   39.851568]  do_task_dead+0xa0/0xc0
[   39.852439]  make_task_dead.cold+0x9c/0x160
[   39.853406]  rewind_stack_and_make_dead+0x17/0x17
[   39.854320] RIP: 0033:0x7faab08f276d
[   39.855224] Code: Unable to access opcode bytes at RIP 0x7faab08f2743.
[   39.856112] RSP: 002b:00007ffd87bc35d8 EFLAGS: 00000203 ORIG_RAX:
0000000000000000
[   39.857067] RAX: ffffffffffffffda RBX: 000055cb4ab91940 RCX:
00007faab08f276d
[   39.857941] RDX: 000000000000144b RSI: 00007ffd87bc4840 RDI:
0000000000000003
[   39.858809] RBP: 00007ffd87bc8850 R08: 00007ffd87bc8948 R09:
00007ffd87bc8948
[   39.859668] R10: 00007faab09e8d50 R11: 0000000000000203 R12:
000055cb4ab910a0
[   39.860530] R13: 00007ffd87bc8940 R14: 0000000000000000 R15:
0000000000000000
[   39.861430]  </TASK>
[   39.862293] BUG: scheduling while atomic: tmp118/1021/0x00000000
[   39.863165] Modules linked in: joydev input_leds serio_raw qemu_fw_cfg x=
fs
autofs4 raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor
async_tx raid1 raid0 multipath linear hid_generic qxl usbhid hid drm_ttm_he=
lper
ttm drm_kms_helper syscopyarea sysfillrect crct10dif_pclmul sysimgblt
fb_sys_fops crc32_pclmul drm ghash_clmulni_intel aesni_intel psmouse
crypto_simd cryptd
[   39.866853] Preemption disabled at:
[   39.866854] [<0000000000000000>] 0x0
[   39.868562] CPU: 2 PID: 1021 Comm: tmp118 Tainted: G      D W=20=20=20=
=20=20=20=20=20
5.18.0-rc5 #1
[   39.869460] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
1.13.0-1ubuntu1.1 04/01/2014
[   39.870328] Call Trace:
[   39.871169]  <TASK>
[   39.871982]  dump_stack_lvl+0x45/0x5a
[   39.872837]  __schedule_bug.cold+0x122/0x132
[   39.873636]  __schedule+0x1715/0x2300
[   39.874427]  ? __sched_text_start+0x8/0x8
[   39.875210]  ? _raw_spin_lock_irq+0xe0/0xe0
[   39.875990]  do_task_dead+0xa0/0xc0
[   39.876806]  make_task_dead.cold+0x9c/0x160
[   39.877571]  rewind_stack_and_make_dead+0x17/0x17
[   39.878331] RIP: 0033:0x7faab08f276d
[   39.879079] Code: Unable to access opcode bytes at RIP 0x7faab08f2743.
[   39.879843] RSP: 002b:00007ffd87bc35d8 EFLAGS: 00000203 ORIG_RAX:
0000000000000000
[   39.880628] RAX: ffffffffffffffda RBX: 000055cb4ab91940 RCX:
00007faab08f276d
[   39.881455] RDX: 000000000000144b RSI: 00007ffd87bc4840 RDI:
0000000000000003
[   39.882231] RBP: 00007ffd87bc8850 R08: 00007ffd87bc8948 R09:
00007ffd87bc8948
[   39.882996] R10: 00007faab09e8d50 R11: 0000000000000203 R12:
000055cb4ab910a0
[   39.883757] R13: 00007ffd87bc8940 R14: 0000000000000000 R15:
0000000000000000
[   39.884504]  </TASK>

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
