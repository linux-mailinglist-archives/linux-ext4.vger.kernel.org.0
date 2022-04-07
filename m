Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26D4D4F895F
	for <lists+linux-ext4@lfdr.de>; Fri,  8 Apr 2022 00:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbiDGVHN (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 7 Apr 2022 17:07:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230420AbiDGVHI (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 7 Apr 2022 17:07:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9061C1753B7
        for <linux-ext4@vger.kernel.org>; Thu,  7 Apr 2022 14:05:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 25DAB61F32
        for <linux-ext4@vger.kernel.org>; Thu,  7 Apr 2022 21:05:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8579BC385A8
        for <linux-ext4@vger.kernel.org>; Thu,  7 Apr 2022 21:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649365505;
        bh=awgFQBXb99Ix4RZEKjlxLWwzppd60gVp7h+Mr2AojFc=;
        h=From:To:Subject:Date:From;
        b=M7Z1th7pm+vH/HyVJP7Ijx7YUGV7SMeupMISJEUQvzHiUjYyOXKYApVkuhOFDDMII
         GPf2MTizZ5mvAr6nqufCH0dC49LWMCnsKIjX1EdZfSAd1iv/0EjWo9ZNaJDeH3DB18
         L2aT1qJRXzotcwQJ0Y6bPPGnbvwWtENPL+pw/x45gZxMEN0zTBCcgBn/SrlZymv1e8
         XfRf5UyW3b8cu5l5ITxagqPF3OrJT3VJILGHO2j5/WzTNNzmKko/8S3IJCVhk4awmn
         B3guYDaZ1fRe9nIuDLxdVNcrOcmGc7EjV4sxos6yaPGmEw24fz46etLpGPXOZpeS+o
         9xR9WdFqtjI0w==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 73CC9CAC6E2; Thu,  7 Apr 2022 21:05:05 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 215818] New: FUZZ: KASAN: slab-out-of-bounds in
 fs/ext4/xattr.c: ext4_xattr_set_entry()
Date:   Thu, 07 Apr 2022 21:05:05 +0000
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
Message-ID: <bug-215818-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215818

            Bug ID: 215818
           Summary: FUZZ: KASAN: slab-out-of-bounds in fs/ext4/xattr.c:
                    ext4_xattr_set_entry()
           Product: File System
           Version: 2.5
    Kernel Version: 5.18-rc1, 5.4.X
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

Created attachment 300714
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D300714&action=3Dedit
poc and .config

- Overview=20
KASAN: slab-out-of-bounds in fs/ext4/xattr.c: ext4_xattr_set_entry() when m=
ount
and operate a corrupted image

- Reproduce=20
tested on kernel 5.18-rc1, 5.4.X

# mkdir test_crash
# cd test_crash=20
# unzip tmp37.zip
# mkdir mnt
# ./single_test.sh ext4 37

- Kernel dump

[  220.523685] loop3: detected capacity change from 0 to 32768
[  220.567579] EXT4-fs (loop3): mounted filesystem with ordered data mode.
Quota mode: none.
[  220.567594] ext4 filesystem being mounted at /home/wq/test_crashes/mnt
supports timestamps until 2038 (0x7fffffff)
[  220.740936]
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[  220.741129] BUG: KASAN: slab-out-of-bounds in
ext4_xattr_set_entry+0x189f/0x3530
[  220.741257] Write of size 4286513180 at addr ffff88811e105be4 by task
tmp37/1223

[  220.741410] CPU: 2 PID: 1223 Comm: tmp37 Not tainted 5.18.0-rc1 #1
[  220.741507] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
1.13.0-1ubuntu1.1 04/01/2014
[  220.741641] Call Trace:
[  220.741700]  <TASK>
[  220.741739]  dump_stack_lvl+0x45/0x5a
[  220.741807]  print_report.cold+0xef/0x67b
[  220.741875]  ? __stack_depot_save+0x1e7/0x530
[  220.741982]  ? ext4_xattr_set_entry+0x189f/0x3530
[  220.742081]  kasan_report+0xa9/0x120
[  220.742163]  ? kasan_save_stack+0x1/0x40
[  220.742247]  ? ext4_xattr_set_entry+0x189f/0x3530
[  220.742346]  kasan_check_range+0x140/0x1b0
[  220.742436]  memset+0x20/0x40
[  220.742507]  ext4_xattr_set_entry+0x189f/0x3530
[  220.742605]  ? _raw_spin_unlock+0x15/0x30
[  220.742696]  ? find_revoke_record+0x14e/0x1a0
[  220.742792]  ? __brelse+0x66/0x80
[  220.742867]  ? jbd2_journal_cancel_revoke+0x35b/0x4c0
[  220.742974]  ? __jbd2_journal_file_buffer+0x2b2/0x5e0
[  220.743081]  ? ext4_xattr_release_block+0x7c0/0x7c0
[  220.743195]  ? kasan_unpoison+0x3e/0x70
[  220.743310]  ? __kasan_slab_alloc+0x52/0xc0
[  220.743403]  ? __kasan_kmalloc+0xa9/0xd0
[  220.743489]  ? __kmalloc+0x18e/0x330
[  220.743566]  ? ext4_xattr_block_set+0x1205/0x27f0
[  220.743666]  ext4_xattr_block_set+0xd53/0x27f0
[  220.743759]  ? _raw_spin_lock_irq+0xe0/0xe0
[  220.743852]  ? folio_mark_accessed+0x5c/0x420
[  220.743946]  ? __find_get_block+0x1a3/0x8b0
[  220.744037]  ? ext4_xattr_block_find.isra.0+0x650/0x650
[  220.744146]  ? __getblk_gfp+0x2d/0x880
[  220.744228]  ? jbd2_write_access_granted+0x164/0x1f0
[  220.744334]  ? xattr_find_entry+0x198/0x270
[  220.744424]  ? ext4_xattr_block_find.isra.0+0x44b/0x650
[  220.744543]  ext4_xattr_set_handle+0xd63/0x12d0
[  220.744639]  ? new_slab+0x23a/0x450
[  220.744723]  ? ext4_xattr_ibody_set+0x270/0x270
[  220.744824]  ? kmem_cache_alloc+0x152/0x4c0
[  220.744912]  ? down_read+0x126/0x210
[  220.748153]  __ext4_set_acl+0x2d3/0x560
[  220.751357]  ext4_set_acl+0x27c/0x450
[  220.754540]  ? ext4_get_acl+0x5f0/0x5f0
[  220.757613]  ? posix_xattr_acl+0x56/0x70
[  220.760561]  ? set_posix_acl+0x11f/0x2a0
[  220.763439]  __vfs_removexattr+0xdb/0x130
[  220.766245]  ? __vfs_getxattr+0x120/0x120
[  220.768374]  ? ima_inode_removexattr+0x2d/0xb0
[  220.770249]  __vfs_removexattr_locked+0x17e/0x380
[  220.772099]  ? path_removexattr+0x81/0x140
[  220.773484]  vfs_removexattr+0xc9/0x230
[  220.774828]  ? __vfs_removexattr_locked+0x380/0x380
[  220.776210]  ? strncpy_from_user+0x5e/0x240
[  220.777482]  removexattr+0x9f/0xf0
[  220.778594]  ? vfs_removexattr+0x230/0x230
[  220.779717]  ? __check_object_size+0x2a5/0x370
[  220.780834]  ? kasan_quarantine_put+0x55/0x180
[  220.781956]  ? preempt_count_add+0x79/0x150
[  220.782891]  ? __mnt_want_write+0x15e/0x240
[  220.783832]  ? mnt_want_write+0xca/0x240
[  220.784759]  path_removexattr+0x111/0x140
[  220.785685]  ? removexattr+0xf0/0xf0
[  220.786605]  ? do_sys_truncate.part.0+0x82/0x100
[  220.787468]  ? fpregs_assert_state_consistent+0x4a/0xb0
[  220.788276]  __x64_sys_removexattr+0x55/0x80
[  220.789084]  ? syscall_exit_to_user_mode+0x22/0x40
[  220.789895]  do_syscall_64+0x38/0x90
[  220.790701]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[  220.791522] RIP: 0033:0x7f17b36a176d
[  220.792304] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 =
89
f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3=
d 01
f0 ff ff 73 01 c3 48 8b 0d f3 36 0d 00 f7 d8 64 89 01 48
[  220.793868] RSP: 002b:00007ffc3185af58 EFLAGS: 00000286 ORIG_RAX:
00000000000000c5
[  220.794685] RAX: ffffffffffffffda RBX: 7876354364585078 RCX:
00007f17b36a176d
[  220.795517] RDX: ffffffffffffff80 RSI: 00007ffc3185b060 RDI:
00007ffc3185c380
[  220.796344] RBP: 00007ffc31863b60 R08: 00007ffc31863c58 R09:
00007ffc31863c58
[  220.797164] R10: 00007ffc31863c58 R11: 0000000000000286 R12:
794f746f48686843
[  220.797907] R13: 49616e6972484539 R14: 394f554a34587135 R15:
6957562f36675555
[  220.798660]  </TASK>

[  220.800131] Allocated by task 1223:
[  220.800866]  kasan_save_stack+0x1e/0x40
[  220.800869]  __kasan_kmalloc+0xa9/0xd0
[  220.800872]  __kmalloc+0x18e/0x330
[  220.800873]  ext4_xattr_block_set+0x1205/0x27f0
[  220.800876]  ext4_xattr_set_handle+0xd63/0x12d0
[  220.800878]  __ext4_set_acl+0x2d3/0x560
[  220.800880]  ext4_set_acl+0x27c/0x450
[  220.800882]  __vfs_removexattr+0xdb/0x130
[  220.800885]  __vfs_removexattr_locked+0x17e/0x380
[  220.800887]  vfs_removexattr+0xc9/0x230
[  220.800889]  removexattr+0x9f/0xf0
[  220.800891]  path_removexattr+0x111/0x140
[  220.800893]  __x64_sys_removexattr+0x55/0x80
[  220.800896]  do_syscall_64+0x38/0x90
[  220.800898]  entry_SYSCALL_64_after_hwframe+0x44/0xae

[  220.801618] The buggy address belongs to the object at ffff88811e105800
                which belongs to the cache kmalloc-1k of size 1024
[  220.803007] The buggy address is located 996 bytes inside of
                1024-byte region [ffff88811e105800, ffff88811e105c00)

[  220.805048] The buggy address belongs to the physical page:
[  220.805745] page:00000000e7ab286d refcount:1 mapcount:0
mapping:0000000000000000 index:0x0 pfn:0x11e100
[  220.805752] head:00000000e7ab286d order:3 compound_mapcount:0
compound_pincount:0
[  220.805754] flags:
0x17ffffc0010200(slab|head|node=3D0|zone=3D2|lastcpupid=3D0x1fffff)
[  220.805759] raw: 0017ffffc0010200 0000000000000000 dead000000000122
ffff888100042dc0
[  220.805764] raw: 0000000000000000 0000000080100010 00000001ffffffff
0000000000000000
[  220.805765] page dumped because: kasan: bad access detected

[  220.806453] Memory state around the buggy address:
[  220.807149]  ffff88811e105b00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00=
 00
00
[  220.807811]  ffff88811e105b80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00=
 00
00
[  220.808462] >ffff88811e105c00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc=
 fc
fc
[  220.809120]                    ^
[  220.809773]  ffff88811e105c80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc=
 fc
fc
[  220.810450]  ffff88811e105d00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc=
 fc
fc
[  220.811119]
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[  220.811845] Disabling lock debugging due to kernel taint
[  220.826595] EXT4-fs error (device loop3): ext4_mb_mark_diskspace_used:38=
21:
comm kworker/u8:0: Allocating blocks 8434-8441 which overlap fs metadata
[  220.828184] EXT4-fs (loop3): Delayed block allocation failed for inode 1=
3 at
logical offset 1 with max blocks 7 with error 117
[  220.829979] EXT4-fs (loop3): This should not happen!! Data will be lost

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
