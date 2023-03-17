Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D74D96BDE27
	for <lists+linux-ext4@lfdr.de>; Fri, 17 Mar 2023 02:33:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbjCQBdD (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 16 Mar 2023 21:33:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjCQBdC (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 16 Mar 2023 21:33:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ADD8E07C
        for <linux-ext4@vger.kernel.org>; Thu, 16 Mar 2023 18:32:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7B0FE6216B
        for <linux-ext4@vger.kernel.org>; Fri, 17 Mar 2023 01:32:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D777EC433D2
        for <linux-ext4@vger.kernel.org>; Fri, 17 Mar 2023 01:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679016776;
        bh=zZ6dkeOMdLsMRclg2KRFvqvimKGeoC19zUbKR9pE22c=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=O7BBBd8+iLkXbxilvE8waxyZnms5b7Bk212Q7lBxDq24H2ynFhideiHTvOgxGjg6e
         SmN6a4IXmn6fRijb4BFrn6uB6cbh25gZTHWfIG/5drlWniSqNZEO+EEWWNj2bzi85I
         PQVX6z6fkNwCkLVO1h2/0VBwHuxkSmjZ7bkj+TsagffmBpZirb2Y1cQFjMFcA0O7yq
         sFyARehYWj1vY5qImMgILjazaveXH0bjyfS8/mbhYeL6OhquK0fiewGIuATOkim9wW
         pN7cDMTSS4jmhm3Spp/i/1//eiwJDNnqJu96bmEQQzsawJ4Wm5mLqiK3Ilgj+4hr6U
         CNEjihKJG+gyQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id C15C8C43142; Fri, 17 Mar 2023 01:32:56 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 217209] ext4_da_write_end: i_disksize exceeds i_size in
 paritally written case
Date:   Fri, 17 Mar 2023 01:32:56 +0000
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
Message-ID: <bug-217209-13602-1CqTZhdaaI@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217209-13602@https.bugzilla.kernel.org/>
References: <bug-217209-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D217209

--- Comment #1 from Zhihao Cheng (chengzhihao1@huawei.com) ---
Reproducer:
1. Apply diff and compile kernel
2. gcc -o aa a.c && ./aa

[   60.567873] inject
[   60.568175] iomap_dio_bio_iter len 409
[   60.569383] ------------[ cut here ]------------
[   60.570198] WARNING: CPU: 2 PID: 2609 at fs/ext4/file.c:319
ext4_file_write_iter+0xbc7/0xd10
[   60.571698] Modules linked in:
[   60.572282] CPU: 2 PID: 2609 Comm: aa Not tainted
6.3.0-rc2-00009-g5312a778686a-dirty #1136
[   60.573723] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
?-20190727_073836-buildvm-ppc64le-16.ppc.fedoraproje4
[   60.575989] RIP: 0010:ext4_file_write_iter+0xbc7/0xd10
[   60.576905] Code: b6 0d e5 0c 01 48 83 05 d6 10 e5 0c 01 e9 f1 fd ff ff =
48
83 05 09 13 e5 0c 01 49 89 c7 e9 01 fb ff ff 48 8c
[   60.580074] RSP: 0018:ffffc9000191bde0 EFLAGS: 00010202
[   60.580842] RAX: 000000000000012c RBX: 0000000000000000 RCX:
0000000001bea002
[   60.581516] RDX: 0000000001be8002 RSI: ffff888172aff5c0 RDI:
0000000000030f70
[   60.582184] RBP: ffffc9000191be70 R08: ffff888172aff588 R09:
0000000000000000
[   60.582839] R10: 0000000000000001 R11: 0000000000000199 R12:
ffff888173d64610
[   60.583513] R13: 000000000000000a R14: ffffc9000191be98 R15:
ffffffffffffffea
[   60.584186] FS:  00007f96cc2f1440(0000) GS:ffff88842fd00000(0000)
knlGS:0000000000000000
[   60.584932] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   60.585489] CR2: 0000000000da4048 CR3: 0000000174498000 CR4:
00000000000006e0
[   60.586161] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
0000000000000000
[   60.586816] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
0000000000000400
[   60.587490] Call Trace:
[   60.587727]  <TASK>
[   60.587933]  ? __call_rcu_common.constprop.0+0x111/0xa80
[   60.588450]  vfs_write+0x3b1/0x5c0
[   60.588778]  ksys_write+0x77/0x160
[   60.589117]  __x64_sys_write+0x22/0x30
[   60.589471]  do_syscall_64+0x39/0x80
[   60.589809]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[   60.590296] RIP: 0033:0x7f96cbd00130
[   60.590640] Code: 73 01 c3 48 8b 0d 58 ed 2c 00 f7 d8 64 89 01 48 83 c8 =
ff
c3 66 0f 1f 44 00 00 83 3d b9 45 2d 00 00 75 10 b4
[   60.592365] RSP: 002b:00007ffc18543058 EFLAGS: 00000246 ORIG_RAX:
0000000000000001
[   60.593065] RAX: ffffffffffffffda RBX: 0000000000000000 RCX:
00007f96cbd00130
[   60.593751] RDX: 0000000000000199 RSI: 0000000000da3000 RDI:
0000000000000003
[   60.594433] RBP: 00007ffc18543080 R08: 0000000000da4010 R09:
0000000000001050
[   60.595096] R10: 000000000000007c R11: 0000000000000246 R12:
0000000000400600
[   60.595755] R13: 00007ffc18543160 R14: 0000000000000000 R15:
0000000000000000
[   60.596435]  </TASK>
[   60.596647] ---[ end trace 0000000000000000 ]---

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
