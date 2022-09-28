Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34AE05EE9B9
	for <lists+linux-ext4@lfdr.de>; Thu, 29 Sep 2022 00:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbiI1Wur (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 28 Sep 2022 18:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234164AbiI1Wur (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 28 Sep 2022 18:50:47 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 088CDA5C7D
        for <linux-ext4@vger.kernel.org>; Wed, 28 Sep 2022 15:50:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 1E8A3CE1EA3
        for <linux-ext4@vger.kernel.org>; Wed, 28 Sep 2022 22:50:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 33750C43141
        for <linux-ext4@vger.kernel.org>; Wed, 28 Sep 2022 22:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664405441;
        bh=FMeguq6uawbA/fsG4UJh1Qqxkuz1cVUhw9T6sjirulU=;
        h=From:To:Subject:Date:From;
        b=gq6mZKn6IOslhj3fHO8f7qf1ndAC44LLaEulV3afRE02QNhdrE5bdqcJNIjVhT3kO
         1Zkkp/1yz3CHx12X3m05AD5KQyPKoVvORpBRvRHlNAokAjF6dAEot9o+PL87/Fy/MS
         KG4YGitYLUDS6CoqPW0yiCCD8bSo4ATbsAADV0d5kHhjQ4gi461TFpR52SMGx4NkPJ
         HgtFMnON568kGnKGEv/IITf7igRVIhqnU4mUjQSJriX/OLHqOhCc7kx3FA4vzTBnR0
         hlDY00/DD5d0ITkZ6UMs6Bnc3rPrPNyvl6Nt3g2iX9Mh4PtayyftjAzjw9Uz93nh2t
         xoFfdfd7PbCxg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 1EE88C433E7; Wed, 28 Sep 2022 22:50:41 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 216541] New: FUZZ: general protection fault, KASAN:
 null-ptr-deref at fs/ext4/ialloc.c:ext4_read_inode_bitmap() when mount a
 corrupted image
Date:   Wed, 28 Sep 2022 22:50:40 +0000
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
Message-ID: <bug-216541-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D216541

            Bug ID: 216541
           Summary: FUZZ: general protection fault, KASAN: null-ptr-deref
                    at fs/ext4/ialloc.c:ext4_read_inode_bitmap() when
                    mount a corrupted image
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

Created attachment 301892
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D301892&action=3Dedit
corrupted image and .config

- Overview=20
FUZZ: general protection fault, KASAN: null-ptr-deref at
fs/ext4/ialloc.c:ext4_read_inode_bitmap() when mount a corrupted image

- Reproduce=20
Tested on kernel 5.15.71, 6.0-rc7

# mkdir mnt
# mount tmp303.img mnt

-Kernel dump
[  468.970349] loop5: detected capacity change from 0 to 32768
[  469.031258] EXT4-fs (loop5): warning: mounting unchecked fs, running e2f=
sck
is recommended
[  469.034841] EXT4-fs error (device loop5): ext4_clear_blocks:866: inode #=
32:
comm mount: attempt to clear invalid blocks 16777450 len 1
[  469.034935] EXT4-fs error (device loop5): ext4_free_branches:1012: inode
#32: comm mount: invalid indirect mapped block 1258291200 (level 1)
[  469.034991] EXT4-fs error (device loop5): ext4_free_branches:1012: inode
#32: comm mount: invalid indirect mapped block 7379847 (level 2)
[  469.035539] general protection fault, probably for non-canonical address
0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN NOPTI
[  469.035603] KASAN: null-ptr-deref in range
[0x0000000000000000-0x0000000000000007]
[  469.035636] CPU: 1 PID: 1088 Comm: mount Not tainted 6.0.0-rc7 #1
[  469.035665] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
1.15.0-1 04/01/2014
[  469.035699] RIP: 0010:ext4_read_inode_bitmap+0x682/0x1240
[  469.035730] Code: 80 3c 02 00 0f 85 ac 0b 00 00 49 8b 87 b8 02 00 00 8b =
54
24 08 4c 8d 3c d0 48 b8 00 00 00 00 00 fc ff df 4c 89 fa 48 c1 ea 03 <80> 3=
c 02
00 0f 85 75 0b 00 00 4d 8b 3f e8 6c fa 78 ff 48 b8 00 00
[  469.035803] RSP: 0018:ffffc900007ff730 EFLAGS: 00010246
[  469.035830] RAX: dffffc0000000000 RBX: 0000000000000000 RCX:
1ffff11024f21407
[  469.035861] RDX: 0000000000000000 RSI: ffff88812ea2e0a8 RDI:
ffff88812790a2b8
[  469.035891] RBP: 0000000000000000 R08: 0000000000000002 R09:
ffffed1025d45c16
[  469.035921] R10: ffff88812ea2e0af R11: ffffed1025d45c15 R12:
ffff888142dd7800
[  469.035951] R13: ffff888125c07000 R14: ffff88812ea2e0a8 R15:
0000000000000000
[  469.035981] FS:  00007f99fcf24840(0000) GS:ffff888293680000(0000)
knlGS:0000000000000000
[  469.036015] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  469.036040] CR2: 000055c988e952f8 CR3: 0000000121fb8003 CR4:
0000000000370ee0
[  469.036072] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
0000000000000000
[  469.036101] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
0000000000000400
[  469.036131] Call Trace:
[  469.036144]  <TASK>
[  469.036156]  ext4_free_inode+0x451/0xfb0
[  469.036179]  ? ext4_mark_bitmap_end+0x20/0x20
[  469.036200]  ? __ext4_journal_start_sb+0x23f/0x2d0
[  469.036223]  ext4_evict_inode+0xaf4/0x14e0
[  469.036243]  ? complete_all+0xc0/0xc0
[  469.036262]  ? ext4_da_write_begin+0x6b0/0x6b0
[  469.036283]  ? _raw_spin_lock_irqsave+0xf0/0xf0
[  469.036305]  ? _raw_spin_lock_irqsave+0xf0/0xf0
[  469.036326]  ? kmem_cache_alloc+0x13b/0x4e0
[  469.036347]  evict+0x284/0x4e0
[  469.036364]  ext4_setup_system_zone+0x66c/0x840
[  469.036386]  ? preempt_schedule_common+0x5e/0xd0
[  469.036408]  ? ext4_exit_system_zone+0x20/0x20
[  469.036429]  ? ext4_setup_super+0x3b7/0x8e0
[  469.036449]  ? _raw_spin_unlock+0x15/0x30
[  469.036468]  ext4_fill_super+0x999c/0xea10
[  469.036490]  ? ext4_reconfigure+0x2250/0x2250
[  469.036511]  ? down_write+0xad/0x120
[  469.037418]  ? snprintf+0x9e/0xd0
[  469.038319]  ? vsprintf+0x10/0x10
[  469.039200]  ? mutex_unlock+0x80/0xd0
[  469.040054]  ? __mutex_unlock_slowpath.isra.0+0x2d0/0x2d0
[  469.040909]  ? sget_fc+0x4e9/0x6b0
[  469.041726]  ? get_tree_bdev+0x388/0x660
[  469.042506]  get_tree_bdev+0x388/0x660
[  469.043256]  ? ext4_reconfigure+0x2250/0x2250
[  469.043983]  vfs_get_tree+0x81/0x2b0
[  469.044681]  ? ns_capable_common+0x57/0xe0
[  469.045363]  path_mount+0x47e/0x19d0
[  469.046027]  ? kasan_quarantine_put+0x55/0x180
[  469.046677]  ? finish_automount+0x5f0/0x5f0
[  469.047312]  ? user_path_at_empty+0x45/0x60
[  469.047934]  ? kmem_cache_free+0x1c2/0x4e0
[  469.048533]  do_mount+0xce/0xf0
[  469.049122]  ? path_mount+0x19d0/0x19d0
[  469.049694]  ? _copy_from_user+0x50/0x80
[  469.050253]  ? memdup_user+0x4e/0xa0
[  469.050804]  __x64_sys_mount+0x12c/0x1a0
[  469.051353]  do_syscall_64+0x38/0x90
[  469.051895]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[  469.052442] RIP: 0033:0x7f99fd184c7e
[  469.052990] Code: 48 8b 0d 15 c2 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 =
2e
0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 49 89 ca b8 a5 00 00 00 0f 05 <48> 3=
d 01
f0 ff ff 73 01 c3 48 8b 0d e2 c1 0c 00 f7 d8 64 89 01 48
[  469.054144] RSP: 002b:00007fff57286818 EFLAGS: 00000246 ORIG_RAX:
00000000000000a5
[  469.054732] RAX: ffffffffffffffda RBX: 00007f99fd2b6204 RCX:
00007f99fd184c7e
[  469.055332] RDX: 000055c988e8de90 RSI: 000055c988e87370 RDI:
000055c988e8de30
[  469.055928] RBP: 000055c988e85460 R08: 0000000000000000 R09:
00007f99fd251d60
[  469.056531] R10: 0000000000000000 R11: 0000000000000246 R12:
0000000000000000
[  469.057145] R13: 000055c988e8de30 R14: 000055c988e8de90 R15:
000055c988e85460
[  469.057764]  </TASK>
[  469.058366] Modules linked in: joydev input_leds serio_raw qemu_fw_cfg x=
fs
autofs4 raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor
async_tx raid1 raid0 multipath linear qxl drm_ttm_helper ttm drm_kms_helper
hid_generic syscopyarea usbhid sysfillrect sysimgblt fb_sys_fops hid
crct10dif_pclmul drm crc32_pclmul ghash_clmulni_intel aesni_intel crypto_si=
md
cryptd psmouse
[  469.061085] ---[ end trace 0000000000000000 ]---
[  469.062245] RIP: 0010:ext4_read_inode_bitmap+0x682/0x1240
[  469.063133] Code: 80 3c 02 00 0f 85 ac 0b 00 00 49 8b 87 b8 02 00 00 8b =
54
24 08 4c 8d 3c d0 48 b8 00 00 00 00 00 fc ff df 4c 89 fa 48 c1 ea 03 <80> 3=
c 02
00 0f 85 75 0b 00 00 4d 8b 3f e8 6c fa 78 ff 48 b8 00 00
[  469.065120] RSP: 0018:ffffc900007ff730 EFLAGS: 00010246
[  469.066087] RAX: dffffc0000000000 RBX: 0000000000000000 RCX:
1ffff11024f21407
[  469.067293] RDX: 0000000000000000 RSI: ffff88812ea2e0a8 RDI:
ffff88812790a2b8
[  469.068371] RBP: 0000000000000000 R08: 0000000000000002 R09:
ffffed1025d45c16
[  469.069678] R10: ffff88812ea2e0af R11: ffffed1025d45c15 R12:
ffff888142dd7800
[  469.070731] R13: ffff888125c07000 R14: ffff88812ea2e0a8 R15:
0000000000000000
[  469.072092] FS:  00007f99fcf24840(0000) GS:ffff888293680000(0000)
knlGS:0000000000000000
[  469.073541] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  469.074966] CR2: 000055c988e952f8 CR3: 0000000121fb8003 CR4:
0000000000370ee0
[  469.075781] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
0000000000000000
[  469.076595] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
0000000000000400

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
