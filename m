Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7F445EE988
	for <lists+linux-ext4@lfdr.de>; Thu, 29 Sep 2022 00:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234211AbiI1WlO (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 28 Sep 2022 18:41:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232298AbiI1WlM (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 28 Sep 2022 18:41:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E8AD10961C
        for <linux-ext4@vger.kernel.org>; Wed, 28 Sep 2022 15:41:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0B67961FF9
        for <linux-ext4@vger.kernel.org>; Wed, 28 Sep 2022 22:41:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6C31FC4347C
        for <linux-ext4@vger.kernel.org>; Wed, 28 Sep 2022 22:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664404870;
        bh=ZUQFfdpwhGKoBhW68F/liFw42/T33xV7P2m8PO6zJ+E=;
        h=From:To:Subject:Date:From;
        b=oUhwSDA2y7FqEdL99GYPT5p5/XUIJ+F6OUwi7qDmxk35JAJhVAAPXKxtPH2lwV/QO
         l0JtVRXKEqrbrxREDPKzX9QSxGMeIr1e55BiBjs5MKWWJBc9yej8xShekORh9JkLFa
         pNmgrampoNaBjjQ+5JXL7oHMiTbeeoc8f1W/uY1Uy6u0Z5UxG2EuxkPf6zGUH4LmXH
         eWd3LBVpSHp+JpySSuWiHCQs1B/UogPbMAZW/0TTkS5n/9GfB1zmdY5kStU4c+VP3a
         VWR/33ma/Dyglvl3mOdnJE9lLh/h4Begq0fzRf0XNBBguhpTOlQrKxzEWoJA9/ov92
         1dpGKxlPagLtQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 585D9C433E7; Wed, 28 Sep 2022 22:41:10 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 216540] New: FUZZ: kernel BUG at kernel BUG at
 fs/ext4/ext4.h:2413 when mount and operate on crafted image
Date:   Wed, 28 Sep 2022 22:41:10 +0000
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
Message-ID: <bug-216540-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216540

            Bug ID: 216540
           Summary: FUZZ: kernel BUG at kernel BUG at fs/ext4/ext4.h:2413
                    when mount and operate on crafted image
           Product: File System
           Version: 2.5
    Kernel Version: 5.15.71, 6.0-rc7
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

Created attachment 301891
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D301891&action=3Dedit
poc and .config

- Overview=20
FUZZ: kernel BUG at fs/ext4/ext4.h:ext4_rec_len_to_disk() when mount and
operate on crafted image

- Reproduce=20
Tested on kernel 5.15.71, 6.0-rc7

# mkdir test_crash
# cd test_crash=20
# unzip ext4_247.zip
# mkdir mnt
# ./single_test.sh ext4 247

-Kernel dump
[  800.153426] loop7: detected capacity change from 0 to 32768
[  800.189527] EXT4-fs (loop7): barriers disabled
[  800.199319] EXT4-fs (loop7): warning: mounting fs with errors, running
e2fsck is recommended
[  800.206218] EXT4-fs (loop7): mounted filesystem with journalled data mod=
e.
Quota mode: none.
[  800.207555] ext4 filesystem being mounted at
/home/wq/test_crashes/mt_crashes/mt_crashes/mnt supports timestamps until 2=
038
(0x7fffffff)
[  800.217041] EXT4-fs error (device loop7): htree_dirblock_to_tree:1093: i=
node
#2: block 582: comm ls: bad entry in directory: rec_len is smaller than min=
imal
- offset=3D780, inode=3D0, rec_len=3D0, size=3D1024 fake=3D0
[  800.465782] ------------[ cut here ]------------
[  800.467047] kernel BUG at fs/ext4/ext4.h:2413!
[  800.468264] invalid opcode: 0000 [#3] PREEMPT SMP KASAN NOPTI
[  800.469448] CPU: 3 PID: 2346 Comm: tmp247 Tainted: G      D=20=20=20=20=
=20=20=20=20=20=20=20
6.0.0-rc7 #1
[  800.470639] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
1.15.0-1 04/01/2014
[  800.471888] RIP: 0010:make_indexed_dir+0xd6c/0x1100
[  800.473089] Code: c9 48 89 ef ba 0b 02 00 00 48 c7 c6 00 17 79 88 e8 79 =
de
06 00 e9 71 fe ff ff bb 06 00 00 00 41 be 06 00 00 00 e9 70 f7 ff ff <0f> 0=
b 48
b8 00 00 00 00 00 fc ff df 48 8b 54 24 18 48 c1 ea 03 80
[  800.475608] RSP: 0018:ffffc900012376d8 EFLAGS: 00010202
[  800.476843] RAX: ffff888193057c13 RBX: ffff88819304abe8 RCX:
0000000000000000
[  800.478083] RDX: dffffc0000000000 RSI: 0000000000000000 RDI:
ffff88819304a817
[  800.479369] RBP: ffff888107934808 R08: 00000000000003ed R09:
ffff8881880c6818
[  800.480606] R10: ffff8881880c6bff R11: ffffed1031018d7f R12:
ffff8881880c6800
[  800.481849] R13: ffff88819304a813 R14: 0000000000000400 R15:
ffff8881880c6810
[  800.483081] FS:  00007fed8f338540(0000) GS:ffff888293780000(0000)
knlGS:0000000000000000
[  800.484352] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  800.485557] CR2: 00007fed8f25d720 CR3: 0000000152ea6005 CR4:
0000000000370ee0
[  800.486770] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
0000000000000000
[  800.488011] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
0000000000000400
[  800.489171] Call Trace:
[  800.490302]  <TASK>
[  800.491459]  ? ext4_dx_add_entry+0x2d40/0x2d40
[  800.492569]  ? add_dirent_to_buf+0x4a0/0x8a0
[  800.493670]  ? ext4_insert_dentry+0x650/0x650
[  800.494770]  ? __ext4_read_dirblock+0x31d/0xc70
[  800.495907]  ext4_add_entry+0x840/0xa90
[  800.496974]  ? make_indexed_dir+0x1100/0x1100
[  800.498017]  ext4_add_nondir+0x90/0x220
[  800.499032]  ext4_create+0x2dc/0x420
[  800.500062]  ? ext4_symlink+0x840/0x840
[  800.501033]  ? from_kgid+0x84/0xc0
[  800.501997]  path_openat+0x255b/0x3aa0
[  800.502955]  ? do_sys_openat2+0x256/0x680
[  800.503953]  ? path_lookupat.isra.0+0x490/0x490
[  800.504899]  ? _raw_spin_unlock_irqrestore+0x23/0x40
[  800.505818]  ? __stack_depot_save+0x1eb/0x540
[  800.506713]  do_filp_open+0x1b9/0x290
[  800.507623]  ? do_sys_truncate.part.0+0x82/0x100
[  800.508465]  ? do_syscall_64+0x38/0x90
[  800.509291]  ? may_open_dev+0xd0/0xd0
[  800.510107]  ? filename_lookup+0x236/0x3d0
[  800.510918]  ? ___slab_alloc+0x4e7/0x9a0
[  800.511770]  ? _raw_spin_lock+0x87/0xda
[  800.512558]  ? _raw_spin_lock_irqsave+0xf0/0xf0
[  800.513321]  ? __check_object_size+0x171/0x620
[  800.514057]  ? _raw_spin_unlock+0x15/0x30
[  800.514766]  ? alloc_fd+0x1bc/0x4f0
[  800.515494]  do_sys_openat2+0x336/0x680
[  800.516160]  ? file_open_root+0x220/0x220
[  800.516824]  ? security_file_permission+0x50/0x580
[  800.517490]  do_sys_open+0x8a/0xe0
[  800.518140]  ? filp_open+0x60/0x60
[  800.518771]  ? exit_to_user_mode_prepare+0x3d/0x150
[  800.519478]  do_syscall_64+0x38/0x90
[  800.520078]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[  800.520665] RIP: 0033:0x7fed8f25d73d
[  800.521236] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 =
89
f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3=
d 01
f0 ff ff 73 01 c3 48 8b 0d 23 37 0d 00 f7 d8 64 89 01 48
[  800.522454] RSP: 002b:00007ffd508c7dc8 EFLAGS: 00000286 ORIG_RAX:
0000000000000002
[  800.523080] RAX: ffffffffffffffda RBX: 00005648bdddfc30 RCX:
00007fed8f25d73d
[  800.523761] RDX: 00000000000001b6 RSI: 0000000000000042 RDI:
00007ffd508c8bb0
[  800.524397] RBP: 00007ffd508cf620 R08: 00007ffd508cf718 R09:
00007ffd508cf718
[  800.525022] R10: 00007ffd508cf718 R11: 0000000000000286 R12:
00005648bdddd0a0
[  800.525639] R13: 00007ffd508cf710 R14: 0000000000000000 R15:
0000000000000000
[  800.526245]  </TASK>
[  800.526840] Modules linked in: joydev input_leds serio_raw qemu_fw_cfg x=
fs
autofs4 raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor
async_tx raid1 raid0 multipath linear qxl drm_ttm_helper ttm drm_kms_helper
hid_generic syscopyarea usbhid sysfillrect sysimgblt fb_sys_fops hid
crct10dif_pclmul drm crc32_pclmul ghash_clmulni_intel aesni_intel crypto_si=
md
cryptd psmouse
[  800.529689] ---[ end trace 0000000000000000 ]---
[  800.530404] RIP: 0010:ext4_read_inode_bitmap+0x682/0x1240
[  800.531175] Code: 80 3c 02 00 0f 85 ac 0b 00 00 49 8b 87 b8 02 00 00 8b =
54
24 08 4c 8d 3c d0 48 b8 00 00 00 00 00 fc ff df 4c 89 fa 48 c1 ea 03 <80> 3=
c 02
00 0f 85 75 0b 00 00 4d 8b 3f e8 6c fa 78 ff 48 b8 00 00
[  800.532730] RSP: 0018:ffffc900007ff730 EFLAGS: 00010246
[  800.533517] RAX: dffffc0000000000 RBX: 0000000000000000 RCX:
1ffff11024f21407
[  800.534301] RDX: 0000000000000000 RSI: ffff88812ea2e0a8 RDI:
ffff88812790a2b8
[  800.535095] RBP: 0000000000000000 R08: 0000000000000002 R09:
ffffed1025d45c16
[  800.535887] R10: ffff88812ea2e0af R11: ffffed1025d45c15 R12:
ffff888142dd7800
[  800.536687] R13: ffff888125c07000 R14: ffff88812ea2e0a8 R15:
0000000000000000
[  800.537507] FS:  00007fed8f338540(0000) GS:ffff888293780000(0000)
knlGS:0000000000000000
[  800.538328] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  800.539197] CR2: 00007fed8f25d720 CR3: 0000000152ea6005 CR4:
0000000000370ee0
[  800.540034] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
0000000000000000
[  800.540881] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
0000000000000400

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
