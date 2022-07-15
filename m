Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17D525760FA
	for <lists+linux-ext4@lfdr.de>; Fri, 15 Jul 2022 13:58:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbiGOL6w (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 15 Jul 2022 07:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbiGOL6u (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 15 Jul 2022 07:58:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6763BCE03
        for <linux-ext4@vger.kernel.org>; Fri, 15 Jul 2022 04:58:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7CE67B82BB2
        for <linux-ext4@vger.kernel.org>; Fri, 15 Jul 2022 11:58:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 13E59C34115
        for <linux-ext4@vger.kernel.org>; Fri, 15 Jul 2022 11:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657886326;
        bh=I4V48Pb8JpnBgnxLPiNPDjGcxot3tc0zaJTYtELsWQ0=;
        h=From:To:Subject:Date:From;
        b=aaUo1+C6EvDDEB3KZo59rjm22UKyZ3Fgsv6HmeCo/YKvAaNxrMrGJfnbqAFfXHSDs
         NDQMzkA+QEAQdhxjBN92vV49WwVS0KINkBzpJXUxHdL4ciYVoyHZ+zPFCyVZEf5dLL
         jNaBATGW3+p/HdE9FtRLfZwQVDR8kZqc9Ftk8oGnqoP1RQ2gf5Oc4+4iXbfbXwdkbg
         j9aR5T69dmvdfRtDhYT+GFMEzWCRfMbd6s2XIbdOpv7x8vRBAEzyrzyaWNlieoJwgO
         Z63/obWv+Hjy5eIygHbVNS4aT3o3OsjxoMLJkA8Ru2MZ8GetDASaICN9s3Qd91qbfE
         eEhguZMNWoDAw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id F3C65CC13AD; Fri, 15 Jul 2022 11:58:45 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 216251] New: kernel BUG at fs/jbd2/transaction.c:1629
Date:   Fri, 15 Jul 2022 11:58:45 +0000
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
Message-ID: <bug-216251-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216251

            Bug ID: 216251
           Summary: kernel BUG at fs/jbd2/transaction.c:1629
           Product: File System
           Version: 2.5
    Kernel Version: 5.19-rc6
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

[  227.908690] ------------[ cut here ]------------
[  227.909523] kernel BUG at fs/jbd2/transaction.c:1629!
[  227.910466] invalid opcode: 0000 [#1] PREEMPT SMP
[  227.911306] CPU: 2 PID: 584 Comm: unlink Tainted: G        W=20=20=20=20=
=20=20=20=20
5.19.0-rc6-00115-g4a57a8400075-dirty #697
[  227.913010] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
?-20190727_073836-buildvm-ppc64le-16.ppc.fedoraproject.org-3.f4
[  227.915264] RIP: 0010:jbd2_journal_dirty_metadata+0x3c5/0x470
[  227.916286] Code: 44 24 10 48 83 05 2a 15 97 0b 01 41 83 f8 01 0f 85 89 =
78
9f 00 48 83 05 30 15 97 0b 01 e9 32 ff ff ff 48 83 05 eb 154
[  227.918779] RSP: 0018:ffffc90000be7ce0 EFLAGS: 00010202
[  227.919284] RAX: 0000000001116019 RBX: ffff8881027df000 RCX:
ffff88817d11c000
[  227.919967] RDX: 0000000000000018 RSI: ffffffff82c73015 RDI:
0000000000000000
[  227.920653] RBP: ffff888101852270 R08: 0000000000000000 R09:
ffffc90000be7b70
[  227.921331] R10: 0000000000000001 R11: 0000000000000001 R12:
ffff88810185f258
[  227.922015] R13: 0000000000000000 R14: ffff88810185f260 R15:
ffff88817d11c000
[  227.922705] FS:  00007fa2fbc564c0(0000) GS:ffff888237c80000(0000)
knlGS:0000000000000000
[  227.923472] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  227.924031] CR2: 000055623fe24008 CR3: 000000017c264000 CR4:
00000000000006e0
[  227.924725] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
0000000000000000
[  227.925408] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
0000000000000400
[  227.926086] Call Trace:
[  227.926339]  <TASK>
[  227.926558]  __ext4_handle_dirty_metadata+0xa0/0x290
[  227.927042]  ext4_handle_dirty_dirblock+0x10c/0x1d0
[  227.927515]  ext4_delete_entry+0x104/0x200
[  227.927912]  __ext4_unlink+0x22b/0x360
[  227.928276]  ? __ext4_journal_start_sb+0x1af/0x1f0
[  227.928745]  ext4_unlink+0x275/0x390
[  227.929097]  vfs_unlink+0x20b/0x4c0
[  227.929439]  do_unlinkat+0x42f/0x4c0
[  227.929792]  __x64_sys_unlink+0x37/0x50
[  227.930159]  do_syscall_64+0x35/0x80

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
