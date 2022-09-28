Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1324C5EE943
	for <lists+linux-ext4@lfdr.de>; Thu, 29 Sep 2022 00:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233350AbiI1WR3 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 28 Sep 2022 18:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232166AbiI1WR2 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 28 Sep 2022 18:17:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91281E21F7
        for <linux-ext4@vger.kernel.org>; Wed, 28 Sep 2022 15:17:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 09CF36200B
        for <linux-ext4@vger.kernel.org>; Wed, 28 Sep 2022 22:17:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6B9D3C43140
        for <linux-ext4@vger.kernel.org>; Wed, 28 Sep 2022 22:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664403446;
        bh=LKMg3OdYnZeNwlF+n/ZWF8ssJl/vuibO91hG5HlAZ/0=;
        h=From:To:Subject:Date:From;
        b=l/DzOGOd0GnXMtDYcEyPiv8sG4AyebiiHuzv8uzRTmNTitVR88SZ+B1C5fY+PGNBP
         G7g325Yo9g1ZP2a4H0cxbANdoYiDSL9e6RfiV8t9RcIRN0+IcwyPMRP4gyn+Fc5MXE
         BbFTGlKWcBylR+KF9N3fwmze1g7it532XFSo74j5H/hmoI3ZFGGQghZpUbe5+1P0Tm
         GtwaLXKfQKqVwQPOo/cbrOFvhTi/nY85EbIRBPAbTGoQf97Bvn40ec9/DnFC3PFAX1
         ysMH/+BWQIQQknzkMclPvpTmNhVhi1G8L+7Wecjg6wZr5jJDpV6NQgAGouy6l7uEOK
         JyNkQQC5ln0/Q==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 571CCC433E7; Wed, 28 Sep 2022 22:17:26 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 216539] New: FUZZ: general protection fault, KASAN:
 null-ptr-deref at fs/ext4/ext4.h:ext4_free_blocks() when mount a corrupted
 image
Date:   Wed, 28 Sep 2022 22:17:26 +0000
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
Message-ID: <bug-216539-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D216539

            Bug ID: 216539
           Summary: FUZZ: general protection fault, KASAN: null-ptr-deref
                    at fs/ext4/ext4.h:ext4_free_blocks() when mount a
                    corrupted image
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

Created attachment 301890
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D301890&action=3Dedit
corrupted image and .config

- Overview=20
FUZZ: general protection fault, KASAN: null-ptr-deref at
fs/ext4/ext4.h:ext4_free_blocks() when mount a corrupted image

- Reproduce=20
Tested on kernel 5.15.71, 6.0-rc7

# mkdir mnt
# mount tmp19.img mnt

-Kernel dump
[  487.033334] loop5: detected capacity change from 0 to 32768
[  487.064295] EXT4-fs (loop5): warning: mounting unchecked fs, running e2f=
sck
is recommended
[  487.067570] general protection fault, probably for non-canonical address
0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN NOPTI
[  487.067697] KASAN: null-ptr-deref in range
[0x0000000000000000-0x0000000000000007]
[  487.067753] CPU: 1 PID: 1099 Comm: mount Not tainted 6.0.0-rc7 #1
[  487.067802] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
1.15.0-1 04/01/2014
[  487.067858] RIP: 0010:ext4_free_blocks+0x7c1/0x1e30
[  487.067907] Code: 49 8d bf b8 02 00 00 48 89 f8 48 c1 e8 03 80 3c 18 00 =
0f
85 42 11 00 00 49 8b 87 b8 02 00 00 4e 8d 24 e0 4c 89 e0 48 c1 e8 03 <80> 3=
c 18
00 0f 85 30 11 00 00 4d 8b 24 24 e8 4c df 71 ff 4f 8d 24
[  487.068031] RSP: 0018:ffffc9000085f3c0 EFLAGS: 00010246
[  487.068075] RAX: 0000000000000000 RBX: dffffc0000000000 RCX:
0000000000000005
[  487.068125] RDX: 0000000000000000 RSI: 0000000000001c06 RDI:
ffff8881260a82b8
[  487.068175] RBP: ffff88812a6c8000 R08: 00000000000000fe R09:
0000000000000030
[  487.068226] R10: ffff8881260a8000 R11: 00000000000000fe R12:
0000000000000000
[  487.068276] R13: ffff888108f9fec8 R14: 0000000000000001 R15:
ffff8881260a8000
[  487.068326] FS:  00007f6c2fd0c840(0000) GS:ffff888293680000(0000)
knlGS:0000000000000000
[  487.068382] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  487.068439] CR2: 00007f9e763a6400 CR3: 00000001058e6006 CR4:
0000000000370ee0
[  487.068493] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
0000000000000000
[  487.068542] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
0000000000000400
[  487.068596] Call Trace:
[  487.068617]  <TASK>
[  487.068637]  ? ext4_mb_new_blocks+0x4030/0x4030
[  487.068677]  ? ext4_sb_block_valid+0x257/0x380
[  487.068712]  ? __ext4_ext_check+0x689/0x13c0
[  487.068746]  ext4_ext_remove_space+0x12d2/0x3b40
[  487.068785]  ? _raw_write_lock+0x87/0xe0
[  487.068816]  ? ext4_ext_index_trans_blocks+0x100/0x100
[  487.068855]  ? _raw_write_unlock+0x39/0x70
[  487.068886]  ? ext4_es_remove_extent+0x170/0x260
[  487.068922]  ? ext4_es_lookup_extent+0x960/0x960
[  487.068957]  ? down_write+0xad/0x120
[  487.068987]  ext4_ext_truncate+0x261/0x300
[  487.069020]  ext4_truncate+0x9f8/0xef0
[  487.069049]  ? ext4_punch_hole+0x1030/0x1030
[  487.069082]  ? __ext4_journal_start_sb+0x23f/0x2d0
[  487.069119]  ext4_evict_inode+0x7e6/0x14e0
[  487.069151]  ? complete_all+0xc0/0xc0
[  487.069182]  ? ext4_da_write_begin+0x6b0/0x6b0
[  487.069215]  ? _raw_spin_lock_irqsave+0xf0/0xf0
[  487.069249]  ? _raw_spin_lock_irqsave+0xf0/0xf0
[  487.069284]  evict+0x284/0x4e0
[  487.069310]  ext4_setup_system_zone+0x66c/0x840
[  487.069345]  ? preempt_schedule_common+0x5e/0xd0
[  487.069381]  ? ext4_exit_system_zone+0x20/0x20
[  487.069416]  ? ext4_setup_super+0x3b7/0x8e0
[  487.070661]  ? _raw_spin_unlock+0x15/0x30
[  487.071887]  ext4_fill_super+0x999c/0xea10
[  487.073131]  ? ext4_reconfigure+0x2250/0x2250
[  487.074317]  ? down_write+0xad/0x120
[  487.075454]  ? snprintf+0x9e/0xd0
[  487.076571]  ? vsprintf+0x10/0x10
[  487.077645]  ? mutex_unlock+0x80/0xd0
[  487.078695]  ? __mutex_unlock_slowpath.isra.0+0x2d0/0x2d0
[  487.079740]  ? sget_fc+0x4e9/0x6b0
[  487.080753]  ? get_tree_bdev+0x388/0x660
[  487.081715]  get_tree_bdev+0x388/0x660
[  487.082649]  ? ext4_reconfigure+0x2250/0x2250
[  487.083627]  vfs_get_tree+0x81/0x2b0
[  487.084608]  ? ns_capable_common+0x57/0xe0
[  487.085534]  path_mount+0x47e/0x19d0
[  487.086463]  ? kasan_quarantine_put+0x55/0x180
[  487.087400]  ? finish_automount+0x5f0/0x5f0
[  487.088314]  ? user_path_at_empty+0x45/0x60
[  487.089217]  ? kmem_cache_free+0x1c2/0x4e0
[  487.090086]  do_mount+0xce/0xf0
[  487.090859]  ? path_mount+0x19d0/0x19d0
[  487.091624]  ? _copy_from_user+0x50/0x80
[  487.092373]  ? memdup_user+0x4e/0xa0
[  487.093161]  __x64_sys_mount+0x12c/0x1a0
[  487.093918]  do_syscall_64+0x38/0x90
[  487.094678]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[  487.095355] RIP: 0033:0x7f6c2ff6cc7e
[  487.096039] Code: 48 8b 0d 15 c2 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 =
2e
0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 49 89 ca b8 a5 00 00 00 0f 05 <48> 3=
d 01
f0 ff ff 73 01 c3 48 8b 0d e2 c1 0c 00 f7 d8 64 89 01 48
[  487.097528] RSP: 002b:00007fffe10578f8 EFLAGS: 00000246 ORIG_RAX:
00000000000000a5
[  487.098292] RAX: ffffffffffffffda RBX: 00007f6c3009e204 RCX:
00007f6c2ff6cc7e
[  487.099064] RDX: 000055b42bbf1e90 RSI: 000055b42bbeb370 RDI:
000055b42bbf1e30
[  487.099839] RBP: 000055b42bbe9460 R08: 0000000000000000 R09:
00007f6c30039d60
[  487.100548] R10: 0000000000000000 R11: 0000000000000246 R12:
0000000000000000
[  487.101256] R13: 000055b42bbf1e30 R14: 000055b42bbf1e90 R15:
000055b42bbe9460
[  487.101971]  </TASK>
[  487.102677] Modules linked in: joydev input_leds serio_raw qemu_fw_cfg x=
fs
autofs4 raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor
async_tx raid1 raid0 multipath linear qxl hid_generic usbhid drm_ttm_helper=
 hid
ttm drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops drm
crct10dif_pclmul crc32_pclmul ghash_clmulni_intel aesni_intel psmouse
crypto_simd cryptd
[  487.105863] ---[ end trace 0000000000000000 ]---
[  487.106628] RIP: 0010:ext4_free_blocks+0x7c1/0x1e30
[  487.107444] Code: 49 8d bf b8 02 00 00 48 89 f8 48 c1 e8 03 80 3c 18 00 =
0f
85 42 11 00 00 49 8b 87 b8 02 00 00 4e 8d 24 e0 4c 89 e0 48 c1 e8 03 <80> 3=
c 18
00 0f 85 30 11 00 00 4d 8b 24 24 e8 4c df 71 ff 4f 8d 24
[  487.109121] RSP: 0018:ffffc9000085f3c0 EFLAGS: 00010246
[  487.109947] RAX: 0000000000000000 RBX: dffffc0000000000 RCX:
0000000000000005
[  487.110724] RDX: 0000000000000000 RSI: 0000000000001c06 RDI:
ffff8881260a82b8
[  487.111503] RBP: ffff88812a6c8000 R08: 00000000000000fe R09:
0000000000000030
[  487.112324] R10: ffff8881260a8000 R11: 00000000000000fe R12:
0000000000000000
[  487.113231] R13: ffff888108f9fec8 R14: 0000000000000001 R15:
ffff8881260a8000
[  487.114146] FS:  00007f6c2fd0c840(0000) GS:ffff888293680000(0000)
knlGS:0000000000000000
[  487.115238] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  487.116093] CR2: 00007f9e763a6400 CR3: 00000001058e6006 CR4:
0000000000370ee0
[  487.117089] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
0000000000000000
[  487.117994] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
0000000000000400

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
