Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9598A674B14
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Jan 2023 05:44:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbjATEoD (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 19 Jan 2023 23:44:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjATEng (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 19 Jan 2023 23:43:36 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0C08BC74C
        for <linux-ext4@vger.kernel.org>; Thu, 19 Jan 2023 20:39:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DE601B82729
        for <linux-ext4@vger.kernel.org>; Thu, 19 Jan 2023 20:21:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 92829C433D2
        for <linux-ext4@vger.kernel.org>; Thu, 19 Jan 2023 20:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674159706;
        bh=D5JkfJWl0Gr2ghPZ7dkEWG0tnL9tSm+mHm/87ImgZTQ=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=UeXnEXnPcGspGkVMJW04wjL9mtkRsVPV8XC4tCOFPdXR2m7YUyMun2FKITCFTRQJh
         ySqVxnvLfnFIIPmcn9R6pswfWEFXGCqo0cADzkwA5GD65t2MmKxfXAiD5fgwuqvCif
         oAbjZObbbkMw+6M+xKbVvYLOXO/OyzwUTB8C805bnkKVvqUXBjnm6CjHVdqHRI2Bo8
         V6+0doOjN7F2hxptJPVUr2x7vGcOoW190KhL62ESyX8Wsca5zp3+EF3Wy64Flw2FfX
         613ZlV36zeQsTpEnl6S02f/t5HWFHFzfHFMb6Rnkn798JLi1z4kf7I0t4U2IrAfjVV
         EeeLdHXfKSpiA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 75CE0C43143; Thu, 19 Jan 2023 20:21:46 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 216953] BUG: kernel NULL pointer dereference, address:
 0000000000000008
Date:   Thu, 19 Jan 2023 20:21:46 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: tytso@mit.edu
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-216953-13602-DfRjiRDwj1@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216953-13602@https.bugzilla.kernel.org/>
References: <bug-216953-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D216953

Theodore Tso (tytso@mit.edu) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |tytso@mit.edu

--- Comment #5 from Theodore Tso (tytso@mit.edu) ---
To save trouble from people who might need to download and read the attachm=
ent,
here it is:

Jan 19 08:25:35 serv209 kernel: RIP: 0010:selinux_inode_free_security+0x5b/=
0x90
Jan 19 08:25:35 serv209 kernel: Code: 8b 43 08 4c 8d 63 08 48 03 aa 70 03 0=
0 00
49 39 c4 74 2f 48 83 c5
 40 48 89 ef e8 20 53 7c 00 48 8b 53 08 48 8b 43 10 48 89 ef <48> 89 42 08 =
48
89 10 4c 89 63 08 4c 89 6
3 10 5b 5d 41 5c e9 6d 54
Jan 19 08:25:35 serv209 kernel: RSP: 0018:ffffb45c404e7ac0 EFLAGS: 00010246
Jan 19 08:25:35 serv209 kernel: RAX: 0000000000000000 RBX: ffff9e7e98002da0
RCX: 0000000000000000
Jan 19 08:25:35 serv209 kernel: RDX: 0000000000000000 RSI: 0000000000000000
RDI: ffff9e7c8af2c400
Jan 19 08:25:35 serv209 kernel: RBP: ffff9e7c8af2c400 R08: 0000000000000000
R09: 0000000000000000
Jan 19 08:25:35 serv209 kernel: R10: 0000000000000000 R11: 0000000000000000
R12: ffff9e7e98002da8
Jan 19 08:25:35 serv209 kernel: R13: ffff9e7c8d7ea800 R14: 0000000000201c2b
R15: 000000008070ac00
Jan 19 08:25:35 serv209 kernel: FS:  0000000000000000(0000)
GS:ffff9e83cf080000(0000) knlGS:00000000000
00000
Jan 19 08:25:35 serv209 kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
0000000080050033
Jan 19 08:25:35 serv209 kernel: CR2: 0000000000000008 CR3: 000000083b610006
CR4: 00000000003706e0
Jan 19 08:25:35 serv209 kernel: DR0: 0000000000000000 DR1: 0000000000000000
DR2: 0000000000000000
Jan 19 08:25:35 serv209 kernel: DR3: 0000000000000000 DR6: 00000000fffe0ff0
DR7: 0000000000000400
Jan 19 08:25:35 serv209 kernel: Call Trace:
Jan 19 08:25:35 serv209 kernel:  <TASK>
Jan 19 08:25:35 serv209 kernel:  security_inode_free+0x31/0x70
Jan 19 08:25:35 serv209 kernel:  __destroy_inode+0x71/0x180
Jan 19 08:25:35 serv209 kernel:  destroy_inode+0x2d/0x80
Jan 19 08:25:35 serv209 kernel:  prune_icache_sb+0x7c/0xc0
Jan 19 08:25:35 serv209 kernel:  super_cache_scan+0x15e/0x1f0
Jan 19 08:25:35 serv209 kernel:  do_shrink_slab+0x13e/0x2f0
Jan 19 08:25:35 serv209 kernel:  shrink_slab+0x1f8/0x2a0
Jan 19 08:25:35 serv209 kernel:  shrink_node+0x21c/0x720
Jan 19 08:25:35 serv209 kernel:  balance_pgdat+0x313/0xa70
Jan 19 08:25:35 serv209 kernel:  ? __schedule+0x37f/0x1290
Jan 19 08:25:35 serv209 kernel:  ? get_nohz_timer_target+0x1c/0x1a0
Jan 19 08:25:35 serv209 kernel:  kswapd+0x1fb/0x3c0
Jan 19 08:25:35 serv209 kernel:  ? destroy_sched_domains_rcu+0x30/0x30
Jan 19 08:25:35 serv209 kernel:  ? balance_pgdat+0xa70/0xa70
Jan 19 08:25:35 serv209 kernel:  kthread+0xed/0x120
Jan 19 08:25:35 serv209 kernel:  ? kthread_complete_and_exit+0x20/0x20
Jan 19 08:25:35 serv209 kernel:  ret_from_fork+0x1f/0x30
Jan 19 08:25:35 serv209 kernel:  </TASK>

If selinux is not being used, it's... strange that we could have ended up in
this path, since it requires inode->i_security being set and the LSM code
deciding that selinux was enabled (and so it called
selinux_inode_free_security).

In any case, this is very clearly not an ext4 bug, so I'm going to pass this
off to the linux-security-module list for them to investigate.  Without a
reliable reproducer, though, there may not be much that any of us can do...

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
