Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0912A501BF7
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Apr 2022 21:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244798AbiDNTbR (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 14 Apr 2022 15:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240820AbiDNTbQ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 14 Apr 2022 15:31:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC715ECC6D
        for <linux-ext4@vger.kernel.org>; Thu, 14 Apr 2022 12:28:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7AFEAB82BA0
        for <linux-ext4@vger.kernel.org>; Thu, 14 Apr 2022 19:28:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2A3D5C385A5
        for <linux-ext4@vger.kernel.org>; Thu, 14 Apr 2022 19:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649964527;
        bh=2N8ELdFzlmgHlTyXwJz2OoPFBufU7R8KOYY234DiAvM=;
        h=From:To:Subject:Date:From;
        b=UVK2ecF+iOoBIz0ymYeBgGucUD31F81dNeFnvDKvIjRLlxetdbB369o9q4zADwVXG
         oi1PxSNdV8c9yV7r/yrfRAs7rysESTf085CxW09Bm52Mmj3JxWCLJUJU1mCakCwI01
         zJYp9KSdL4DhBQzhJ4i46RpPWNUyKxtbyl5k98htU7MLRRPdsj4vIgc/bNKNQa+Ns1
         w7al2d73zrY0xK6RYSf80cUKtrB4v7xSmbKV/FI3bEEHfcI/5e6VxcaHWKOqGMJMBv
         JiAJhSnvaLWJXJ6xuoIZur61ws4TfKr15yrEwTKauvrpj6ZpO/FzjK6+7TXRRKi2p9
         BpykUuufDV9wQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 0F294C05FD4; Thu, 14 Apr 2022 19:28:47 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 215838] New: FUZZ: KASAN: use-after-free in
 fs/ext4/namei.c:ext4_insert_dentry() when mount and operate on a corrupted
 image
Date:   Thu, 14 Apr 2022 19:28:46 +0000
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
Message-ID: <bug-215838-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215838

            Bug ID: 215838
           Summary: FUZZ: KASAN: use-after-free in
                    fs/ext4/namei.c:ext4_insert_dentry() when mount and
                    operate on a corrupted image
           Product: File System
           Version: 2.5
    Kernel Version: 5.18-rc1, 5.4.171
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

Created attachment 300760
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D300760&action=3Dedit
poc and .config

- Overview=20
KASAN: use-after-free in fs/ext4/namei.c:ext4_insert_dentry() when mount and
operate on a corrupted image

- Reproduce=20
tested on kernel 5.18-rc1, 5.4.X

# mkdir test_crash
# cd test_crash=20
# unzip tmp42.zip
# mkdir mnt
# ./single_test.sh ext4 42

Sometimes need to unzip the file again and ran several times to reproduce

- Kernel dump

[  188.103345] loop6: detected capacity change from 0 to 32768
[  188.156064] EXT4-fs (loop6): mounted filesystem with ordered data mode.
Quota mode: none.
[  188.158361] ext4 filesystem being mounted at /home/wq/test_crashes/mnt
supports timestamps until 2038 (0x7fffffff)
[  188.296756]
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[  188.298129] BUG: KASAN: use-after-free in ext4_insert_dentry+0x37c/0x650
[  188.300278] Write of size 96 at addr ffff888147adeffc by task tmp42/1272

[  188.303236] CPU: 2 PID: 1272 Comm: tmp42 Tainted: G      D=20=20=20=20=
=20=20=20=20=20=20
5.18.0-rc1 #1
[  188.304687] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
1.13.0-1ubuntu1.1 04/01/2014
[  188.306164] Call Trace:
[  188.307646]  <TASK>
[  188.309062]  dump_stack_lvl+0x45/0x5a
[  188.310454]  print_report.cold+0xef/0x67b
[  188.311799]  ? ext4_insert_dentry+0x37c/0x650
[  188.313123]  kasan_report+0xa9/0x120
[  188.314513]  ? ext4_insert_dentry+0x37c/0x650
[  188.315834]  kasan_check_range+0x140/0x1b0
[  188.317135]  memcpy+0x39/0x60
[  188.318420]  ext4_insert_dentry+0x37c/0x650
[  188.319709]  add_dirent_to_buf+0x201/0x8a0
[  188.321023]  ? ext4_handle_dirty_dirblock+0x450/0x450
[  188.322385]  ? ext4_insert_dentry+0x650/0x650
[  188.323661]  ? __ext4_journal_get_write_access+0x17c/0x3b0
[  188.324932]  ext4_dx_add_entry+0x31b/0x2d30
[  188.326221]  ? __ext4_handle_dirty_metadata+0xdd/0x670
[  188.327453]  ? add_dirent_to_buf+0x8a0/0x8a0
[  188.328674]  ? ext4_mark_iloc_dirty+0x55b/0x19d0
[  188.329921]  ? ext4_reserve_inode_write+0x157/0x220
[  188.331130]  ext4_add_entry+0x5f2/0xa90
[  188.332425]  ? ext4_expand_extra_isize+0x540/0x540
[  188.333742]  ? make_indexed_dir+0x10f0/0x10f0
[  188.335031]  ? ext4_init_new_dir+0x2e8/0x410
[  188.336230]  ext4_mkdir+0x368/0x920
[  188.337373]  ? ext4_init_new_dir+0x410/0x410
[  188.338545]  ? from_kgid+0x84/0xc0
[  188.339644]  vfs_mkdir+0x498/0x800
[  188.340728]  do_mkdirat+0x1c1/0x230
[  188.341799]  ? do_file_open_root+0x3e0/0x3e0
[  188.342825]  ? getname_flags+0xfd/0x4e0
[  188.343827]  __x64_sys_mkdir+0x61/0x80
[  188.344795]  do_syscall_64+0x38/0x90
[  188.345759]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[  188.346699] RIP: 0033:0x7f24fdc5076d
[  188.347629] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 =
89
f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3=
d 01
f0 ff ff 73 01 c3 48 8b 0d f3 36 0d 00 f7 d8 64 89 01 48
[  188.349559] RSP: 002b:00007ffe582e1108 EFLAGS: 00000217 ORIG_RAX:
0000000000000053
[  188.350493] RAX: ffffffffffffffda RBX: 58666e5745624249 RCX:
00007f24fdc5076d
[  188.351401] RDX: 00007f24fdc5076d RSI: ffffffffffffff80 RDI:
00007ffe582e1650
[  188.352313] RBP: 00007ffe582e5860 R08: 00007ffe582e5958 R09:
00007ffe582e5958
[  188.353208] R10: 00007ffe582e5958 R11: 0000000000000217 R12:
756d685933654469
[  188.354109] R13: 00007ffe582e5950 R14: 4554477647466448 R15:
4e54356e77513250
[  188.354958]  </TASK>

[  188.356588] The buggy address belongs to the physical page:
[  188.357409] page:0000000079ad8a85 refcount:2 mapcount:0
mapping:00000000b7222df2 index:0x97 pfn:0x147ade
[  188.358294] memcg:ffff8881250b8000
[  188.359118] aops:def_blk_aops ino:700006
[  188.359928] flags:
0x17ffffc0002032(referenced|lru|active|private|node=3D0|zone=3D2|lastcpupid=
=3D0x1fffff)
[  188.360791] raw: 0017ffffc0002032 ffffea00051a5008 ffffea00051eb548
ffff888100480b80
[  188.361686] raw: 0000000000000097 ffff88810b1c87e0 00000002ffffffff
ffff8881250b8000
[  188.362561] page dumped because: kasan: bad access detected

[  188.364302] Memory state around the buggy address:
[  188.365189]  ffff888147adef00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00=
 00
00
[  188.366115]  ffff888147adef80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00=
 00
00
[  188.367012] >ffff888147adf000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff=
 ff
ff
[  188.367924]                    ^
[  188.368835]  ffff888147adf080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff=
 ff
ff
[  188.369794]  ffff888147adf100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff=
 ff
ff
[  188.370723]
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
