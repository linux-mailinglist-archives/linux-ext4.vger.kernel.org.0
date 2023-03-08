Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FCA36AFD19
	for <lists+linux-ext4@lfdr.de>; Wed,  8 Mar 2023 03:55:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjCHCzj (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 7 Mar 2023 21:55:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjCHCzh (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 7 Mar 2023 21:55:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1DD9984CB
        for <linux-ext4@vger.kernel.org>; Tue,  7 Mar 2023 18:55:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3D02F6163C
        for <linux-ext4@vger.kernel.org>; Wed,  8 Mar 2023 02:55:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A0390C4339B
        for <linux-ext4@vger.kernel.org>; Wed,  8 Mar 2023 02:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678244135;
        bh=srCnxU1T5Hm286DilEz66chO4XmiH7UtJ/GjQxkRFWk=;
        h=From:To:Subject:Date:From;
        b=dv/fZjA7zpaLRKrhAv1p/JVjQCtIbl4G01CqF/Q46hCdLg2bG7xhKDI+sDnBap7dP
         55EIjyEcCrCkxvUooisd+AqD0FaWljogabKLNPtEvyX+ca2hHZ/GNDCLdAJI4ruxr2
         voItL/oS3GRql3mUKeVsRRnsYqNdvSQCRyC7E8KDMdEnlorpoRWkH346FWiDYV3jW8
         kKVQvlrIANM67xJm4JO8A4/NhGc6RDnH8t5vU1onah6kX7PZxCvb81YVXRxNy8z++2
         x0oNyl3ZW9FSyamSu5VRVKCWHBzFzNGUjbq28eCcUb7q65y6fzLtpkh+b4B0FXFxHq
         CjCKS0RDysDYA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 86261C43143; Wed,  8 Mar 2023 02:55:35 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 217159] New: WARN in ext4_handle_inode_extension:
 i_size_read(inode) < EXT4_I(inode)->i_disksize
Date:   Wed, 08 Mar 2023 02:55:35 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: chengzhihao1@huawei.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression
Message-ID: <bug-217159-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D217159

            Bug ID: 217159
           Summary: WARN in ext4_handle_inode_extension:
                    i_size_read(inode) < EXT4_I(inode)->i_disksize
           Product: File System
           Version: 2.5
    Kernel Version: 6.3.0-rc1
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: ext4
          Assignee: fs_ext4@kernel-bugs.osdl.org
          Reporter: chengzhihao1@huawei.com
        Regression: No

CONFIG_EXT4_FS=3Dy

1. download corrupted ext4 image disk(nonzero i_size for EXT4_BOOT_LOADER_I=
NO)
2. gcc -o bb b.c
3. ./bb
[   16.966779] ------------[ cut here ]------------
[   16.967594] WARNING: CPU: 0 PID: 2580 at fs/ext4/file.c:319
ext4_file_write_iter+0xbc7/0xd10
[   16.968996] Modules linked in:
[   16.969521] CPU: 0 PID: 2580 Comm: bb Not tainted
6.3.0-rc1-00004-g703695902cfa #1109
[   16.970806] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
?-20190727_073836-buildvm-ppc64le-16.ppc.fedoraprojec4
[   16.973047] RIP: 0010:ext4_file_write_iter+0xbc7/0xd10
[   16.973813] Code: 56 0f e5 0c 01 48 83 05 76 12 e5 0c 01 e9 f1 fd ff ff =
48
83 05 a9 14 e5 0c 01 49 89 c7 e9 01 fb ff ff 48 83c
[   16.975571] RSP: 0018:ffffc9000189fde0 EFLAGS: 00010202
[   16.976073] RAX: 0000000000006464 RBX: 0000000000000000 RCX:
00000000038b8000
[   16.976753] RDX: 00000000038b6000 RSI: ffff8881738c60f0 RDI:
0000000000030f70
[   16.977444] RBP: ffffc9000189fe70 R08: ffff8881738c60b8 R09:
ffff8881738c60b8
[   16.978130] R10: 0000000000000307 R11: 0000000000000400 R12:
ffff88817a9c61a0
[   16.978796] R13: 000000000000000a R14: ffffc9000189fe98 R15:
0000000000000400
[   16.979483] FS:  00007f3de0f00440(0000) GS:ffff88842fc00000(0000)
knlGS:0000000000000000
[   16.980251] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   16.980787] CR2: 00007f3de08ffe70 CR3: 000000017576a000 CR4:
00000000000006f0
[   16.981491] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
0000000000000000
[   16.982179] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
0000000000000400
[   16.982851] Call Trace:
[   16.983110]  <TASK>
[   16.983327]  ? __ext4_ioctl+0x1375/0x2700
[   16.983711]  vfs_write+0x3b1/0x5c0
[   16.984059]  ksys_write+0x77/0x160
[   16.984395]  __x64_sys_write+0x22/0x30
[   16.984754]  do_syscall_64+0x39/0x80
[   16.985120]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[   16.985611] RIP: 0033:0x7f3de0900130
[   16.985972] Code: 73 01 c3 48 8b 0d 58 ed 2c 00 f7 d8 64 89 01 48 83 c8 =
ff
c3 66 0f 1f 44 00 00 83 3d b9 45 2d 00 00 75 10 b84
[   16.987744] RSP: 002b:00007ffe63ff5e98 EFLAGS: 00000246 ORIG_RAX:
0000000000000001
[   16.988482] RAX: ffffffffffffffda RBX: 0000000000000000 RCX:
00007f3de0900130
[   16.989181] RDX: 0000000000000400 RSI: 00000000012e1400 RDI:
0000000000000003
[   16.989874] RBP: 00007ffe63ff5eb0 R08: 0000000000000000 R09:
0000000000000450
[   16.990569] R10: 0000000000000003 R11: 0000000000000246 R12:
0000000000400570
[   16.991266] R13: 00007ffe63ff5f90 R14: 0000000000000000 R15:
0000000000000000
[   16.991948]  </TASK>
[   16.992174] ---[ end trace 0000000000000000 ]---

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
