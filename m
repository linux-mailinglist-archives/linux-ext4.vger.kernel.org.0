Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 864586B3F7B
	for <lists+linux-ext4@lfdr.de>; Fri, 10 Mar 2023 13:38:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbjCJMiY (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 10 Mar 2023 07:38:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbjCJMiK (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 10 Mar 2023 07:38:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1A1010D779
        for <linux-ext4@vger.kernel.org>; Fri, 10 Mar 2023 04:37:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 730C2B82288
        for <linux-ext4@vger.kernel.org>; Fri, 10 Mar 2023 12:37:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 35F80C4339B
        for <linux-ext4@vger.kernel.org>; Fri, 10 Mar 2023 12:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678451858;
        bh=1WlJglMLFO53mosNulpGu6EdYVrS8HVqGbbHgVyeIOw=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Gzfzfj4zLaO2FosoiAFO2GjSyngxOGVujIRIfdMoDfXB0OVQnJNoUi/f2ycvgdosg
         aVw5O2Tukm/Jv/la+iwK1x+3BZcvKAX+IjnQnJiRqJNhQsAKDSlH0nOOClglMWkKvO
         2Sfd9A6gsbVf29WxmN6KUdqaKek7us1PSUmla9Inf2510YokF9gL4SuWFE0kbfbOYw
         Y99+mYGw6ZkQywlTK5yiWfoygAWaX4AMBUHhyE2kiKbRRWsID8HiZwINnYCaayG31v
         CPrz76OQdkOMKCo3JWl/e6E69LpH39Cn+J/zZlfI1k4Tl8g9pT3BukjnxZmyl98SPP
         iesJGxYi+W+8w==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 2262CC43142; Fri, 10 Mar 2023 12:37:38 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 217171] ext4: stale buffer loading from last failed mounting
Date:   Fri, 10 Mar 2023 12:37:37 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
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
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-217171-13602-ocMIEJvL6b@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217171-13602@https.bugzilla.kernel.org/>
References: <bug-217171-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D217171

--- Comment #1 from Zhihao Cheng (chengzhihao1@huawei.com) ---
1. Apply main_diff
2. sh test.sh
[  116.709224] mount sda
[  116.711840] load bh ffff88817b33edd0
[  116.712425] inject
[  116.712681] JBD2: recovery failed
[  116.713067] EXT4-fs (sda): error loading journal
[  116.731617] mount sda
[  116.732129] found stale bh ffff88817b33edd0  # stale buffer head from la=
st
failed mounting
[  116.732713] Kernel panic - not syncing: not verified
[  116.733366] CPU: 3 PID: 2613 Comm: mount Not tainted
6.3.0-rc1-00003-g737d811674e8-dirty #1125
[  116.734528] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
?-20190727_073836-buildvm-ppc64le-16.ppc.fedoraprojec4
[  116.736052] Call Trace:
[  116.736339]  <TASK>
[  116.736600]  dump_stack_lvl+0x7f/0xb0
[  116.736941]  dump_stack+0x18/0x30
[  116.737316]  panic+0x4e6/0x520
[  116.737719]  journal_get_superblock+0x7dc/0x7e0
[  116.738285]  load_superblock+0x16/0x100
[  116.738713]  jbd2_journal_wipe+0x2c/0x140
[  116.739138]  ? ext4_init_journal_params+0xa0/0xe0
[  116.739668]  ext4_load_and_init_journal.isra.0+0x8df/0x11c0
[  116.740291]  ? _printk+0x64/0x90
[  116.740617]  __ext4_fill_super+0x2a15/0x3370
[  116.741098]  ? __ext4_fill_super+0x3370/0x3370
[  116.741667]  ext4_fill_super+0x121/0x2f0
[  116.742073]  get_tree_bdev+0x1d6/0x370
[  116.742493]  ext4_get_tree+0x1d/0x30
[  116.742922]  vfs_get_tree+0x2a/0x110
[  116.743357]  ? capable+0x21/0x30
[  116.743701]  path_mount+0x821/0xfc0
[  116.744077]  do_mount+0x91/0xc0
[  116.744480]  __x64_sys_mount+0xc4/0x160
[  116.744906]  do_syscall_64+0x39/0x80
[  116.745300]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[  116.745838] RIP: 0033:0x7fc8f931123a
[  116.746350] Code: 48 8b 0d 51 dc 2b 00 f7 d8 64 89 01 48 83 c8 ff c3 66 =
2e
0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 49 89 ca b88
[  116.748348] RSP: 002b:00007fffdb903258 EFLAGS: 00000202 ORIG_RAX:
00000000000000a5
[  116.749172] RAX: ffffffffffffffda RBX: 0000000000733240 RCX:
00007fc8f931123a
[  116.749996] RDX: 0000000000739f90 RSI: 00000000007334a0 RDI:
0000000000733480
[  116.750801] RBP: 0000000000000000 R08: 0000000000000000 R09:
00007fffdb9021c8
[  116.751565] R10: 0000000000000000 R11: 0000000000000202 R12:
0000000000733480
[  116.752372] R13: 0000000000739f90 R14: 0000000000000001 R15:
0000000000733240
[  116.753137]  </TASK>
[  116.753498] Kernel Offset: disabled
[  116.753822] ---[ end Kernel panic - not syncing: not verified ]---

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
