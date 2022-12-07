Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D47CD6455ED
	for <lists+linux-ext4@lfdr.de>; Wed,  7 Dec 2022 09:59:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbiLGI7l (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 7 Dec 2022 03:59:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbiLGI7N (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 7 Dec 2022 03:59:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAE112CDFB
        for <linux-ext4@vger.kernel.org>; Wed,  7 Dec 2022 00:59:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2A2EEB81B91
        for <linux-ext4@vger.kernel.org>; Wed,  7 Dec 2022 08:58:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C9AF7C433D7
        for <linux-ext4@vger.kernel.org>; Wed,  7 Dec 2022 08:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670403537;
        bh=Arr/LCXYmgHBcbM87JQSlpUx1bvoletFuk2N2FE9O0o=;
        h=From:To:Subject:Date:From;
        b=JIjHg2pxYrsOXtfSVKL0CpKK5GPsq/V21Y4E0e2jZkfq3i065+CiF8thzSMdTYOnD
         wjYfrb+mL7brQjRR6RhxdZaYghakrFjZCb5irL88GFowCNumXlFMHDXzbdkJKmrbsZ
         4jgfrlWlt62lkiz39tQR84OHtnp1c+7K9Nw22+DS0I54TXDcRY6D4P8H+VAYv35MZ8
         zGEIOoTst5zTOM54pF3UN4p0xcXCH8tKwmnzqjLtf+NIRMD2KEh1AJ/71oKS7SdCCm
         aYsDUjtqH5UC1t1TlWa3+xB+5WRFQPGQhfgLwpOTIoiElgcoJkPaS3D96WgtJKvc4Y
         8almKaIakRpTw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id BA8EBC433E7; Wed,  7 Dec 2022 08:58:57 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 216784] New: There is "ext4_xattr_block_set" WARNING in
 v6.1-rc8 guest kernel
Date:   Wed, 07 Dec 2022 08:58:57 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: pengfei.xu@intel.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression
Message-ID: <bug-216784-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216784

            Bug ID: 216784
           Summary: There is "ext4_xattr_block_set" WARNING in v6.1-rc8
                    guest kernel
           Product: File System
           Version: 2.5
    Kernel Version: v6.1-rc8
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: ext4
          Assignee: fs_ext4@kernel-bugs.osdl.org
          Reporter: pengfei.xu@intel.com
        Regression: No

Platform: raptor lake

There is "ext4_xattr_block_set" WARNING in v6.1-rc8 guest kernel.
"
[   27.922337] loop0: detected capacity change from 0 to 1024
[   27.922663] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[   27.922663] WARNING: The mand mount option has been deprecated and
[   27.922663]          and is ignored by this kernel. Remove the mand
[   27.922663]          option from the mount to silence this warning.
[   27.922663] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[   27.923771] EXT4-fs: Ignoring removed bh option
[   27.923947] EXT4-fs: Ignoring removed i_version option
[   27.924204] EXT4-fs: Journaled quota options ignored when QUOTA feature =
is
enabled
[   27.925839] EXT4-fs (loop0): mounted filesystem without journal. Quota m=
ode:
writeback.
[   27.928984] ------------[ cut here ]------------
[   27.929173] WARNING: CPU: 0 PID: 567 at fs/ext4/xattr.c:2069
ext4_xattr_block_set+0x170d/0x1770
[   27.929514] Modules linked in:
[   27.929651] CPU: 0 PID: 567 Comm: repro Not tainted 6.1.0-rc8-76dcd734ec=
a2
#1
[   27.929931] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
[   27.930355] RIP: 0010:ext4_xattr_block_set+0x170d/0x1770
[   27.930562] Code: e8 78 18 ff ff 48 8b 7d a0 e8 4f eb e5 ff e9 80 fe ff =
ff
e8 25 3d b5 ff 4c 89 ff e8 fd c2 e9 ff e9 b6 f5 ff ff e8 13 3d b5 ff <0f> 0=
b e9
21 1
[   27.931241] RSP: 0018:ffffc90000fc7a10 EFLAGS: 00010246
[   27.931442] RAX: 0000000000000000 RBX: 0000000000000001 RCX:
ffffffff816fa04d
[   27.931708] RDX: 0000000000000000 RSI: ffff88800cb6cc80 RDI:
0000000000000002
[   27.931973] RBP: ffffc90000fc7ae8 R08: ffff88800bae3824 R09:
ffff88800bae3bfe
[   27.932236] R10: ffffc90000fc7e28 R11: 00000000fa83b201 R12:
0000000000000000
[   27.932502] R13: ffff88800cb85800 R14: 0000000000000000 R15:
0000000000000000
[   27.932781] FS:  00007f69b3c68740(0000) GS:ffff88807dc00000(0000)
knlGS:0000000000000000
[   27.933079] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   27.933296] CR2: 000055c48486e5e8 CR3: 000000000b76a005 CR4:
0000000000770ef0
[   27.933569] PKRU: 55555554
[   27.933676] Call Trace:
[   27.933773]  <TASK>
[   27.933861]  ? __sanitizer_cov_trace_pc+0x25/0x60
[   27.934048]  ext4_expand_extra_isize_ea+0x5e9/0xcd0
[   27.934242]  __ext4_expand_extra_isize+0x188/0x1f0
[   27.934443]  __ext4_mark_inode_dirty+0x246/0x370
[   27.934637]  ? ext4_setattr+0x1380/0x1380
[   27.934794]  ext4_dirty_inode+0x7a/0xa0
[   27.934946]  __mark_inode_dirty+0xa3/0x650
[   27.935107]  ? setattr_copy+0x11e/0x320
[   27.935259]  ext4_setattr+0xb26/0x1380
[   27.935407]  ? __sanitizer_cov_trace_pc+0x25/0x60
[   27.935593]  ? ext4_journalled_write_end+0x900/0x900
[   27.935792]  notify_change+0x3f8/0xb50
[   27.935943]  chmod_common+0xef/0x200
[   27.936085]  ? chmod_common+0xef/0x200
[   27.936235]  ? __sanitizer_cov_trace_pc+0x25/0x60
[   27.936420]  do_fchmodat+0x76/0xf0
[   27.936558]  __x64_sys_chmod+0x28/0x40
[   27.936713]  do_syscall_64+0x3b/0x90
[   27.936862]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[   27.937062] RIP: 0033:0x7f69b3d8d59d
[   27.937203] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 =
89
f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3=
d 01
f0 8
[   27.937900] RSP: 002b:00007ffccac7eef8 EFLAGS: 00000246 ORIG_RAX:
000000000000005a
[   27.938184] RAX: ffffffffffffffda RBX: 0000000000000000 RCX:
00007f69b3d8d59d
[   27.938450] RDX: 0031656c69662f2e RSI: 0000000000000140 RDI:
0000000020000100
[   27.938719] RBP: 00007ffccac7ef00 R08: 00007ffccac7ed60 R09:
00000000004028e0
[   27.938985] R10: 00007ffccac7ed60 R11: 0000000000000246 R12:
00000000004011a0
[   27.939250] R13: 00007ffccac7efe0 R14: 0000000000000000 R15:
0000000000000000
[   27.939517]  </TASK>
[   27.939605] ---[ end trace 0000000000000000 ]---
"

Bisect automation tried twice on 2 different rpl-p platforms, both results =
show
the same first bad commit as below:
"
cebe85d570cf84804e848332d6721bc9e5300e07
ext4: switch to the new mount api
"

And I tried that: installed the patch in below link based on v6.1-rc8,
this issue still could be reproduced.
https://lore.kernel.org/lkml/20221107133651.qmitthhev3lq4h5q@quack3/

Kconfig, reproduced code, bisect info are in attached.
All detailed info is in link:
https://github.com/xupengfe/syzkaller_logs/tree/main/221207_100056_ext4_xat=
tr_block_set

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
