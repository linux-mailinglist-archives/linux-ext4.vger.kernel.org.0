Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 741CF6EC8EB
	for <lists+linux-ext4@lfdr.de>; Mon, 24 Apr 2023 11:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbjDXJcr (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 24 Apr 2023 05:32:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjDXJcq (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 24 Apr 2023 05:32:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07953E7C
        for <linux-ext4@vger.kernel.org>; Mon, 24 Apr 2023 02:32:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 95CAD61F4F
        for <linux-ext4@vger.kernel.org>; Mon, 24 Apr 2023 09:32:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EE1F9C433D2
        for <linux-ext4@vger.kernel.org>; Mon, 24 Apr 2023 09:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682328762;
        bh=AVMa9eSL3xozAALa7Sz/fXXH3grLmPAfjQutaxlwoSY=;
        h=From:To:Subject:Date:From;
        b=U6q37NC9DEAL3JywvLtCPlZr+RIJFdInPL4mH4fQVIEjg4vTx0wJwk+rEGIbaRgx2
         EeRP2vcaOBL0KynDV5qZftuj9NDM+acD48wOF78GDfBfzVBmcZmSPr7vQ+GP74pXYR
         vpeHqwtExF5p4Oe13npmVDoS67O7K9S7i/SaR/BRgxFizob7ZJ4QvAjP/oG4NuCdS0
         X5Oy1gVQmonVpELQmkFlTEFv0854B06j5Oe7cMIasYDOLGi9UedljYQnKLoDYvVv98
         Bc5RBbKpFEOGVWou79ry73T7PZdtR6qkero3P4SrN6wOYqiF72LCZPEBcKw82zW15j
         fsdP5Y85zJzOw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id C6BBAC43143; Mon, 24 Apr 2023 09:32:41 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 217363] New: jbd2: Data missing when reusing bh which is ready
 to be submitted in checkpoint
Date:   Mon, 24 Apr 2023 09:32:41 +0000
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
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-217363-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D217363

            Bug ID: 217363
           Summary: jbd2: Data missing when reusing bh which is ready to
                    be submitted in checkpoint
           Product: File System
           Version: 2.5
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: ext4
          Assignee: fs_ext4@kernel-bugs.osdl.org
          Reporter: chengzhihao1@huawei.com
        Regression: No

CONFIG_EXT4_FS=3Dy
CONFIG_JBD2=3Dy

-smp 4

1. Apply diff and compile kernel
2. ./test.sh
[   76.050388] jbd2_journal_commit_transaction ---
[   76.051528] jbd2_journal_commit_transaction =3D=3D=3D=3D
[   76.179116] umount(3642): commit ffff88817a547500
[   76.300237] ext4 filesystem being mounted at /root/temp supports timesta=
mps
until 2038 (0x7fffffff)
[   76.315293] assign g_bh, trace dir 2 buffer, add a(1036)
[   76.349959] jbd2_journal_commit_transaction ---
[   76.350915] insert ffff888173aa3340 into trans ffff888173aa4100
[   76.352158] mark buffer dirty
[   76.352829] jbd2_journal_commit_transaction =3D=3D=3D=3D
[   76.377202] chmod(3649): commit ffff888173aa4100
[   76.378019] checkpoint: bh dirty bit should be cleared before flush
[   76.379045] commit ffff888173aa4100 done
[   76.379708] Do access to bh
[   78.415834] commit ffff888173aa4100 done
[   78.512334] Kernel panic - not syncing: DONE
[   78.513351] CPU: 0 PID: 3649 Comm: chmod Not tainted
6.3.0-00012-g8eab99f47c2b-dirty #1188
[   78.515079] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
?-20190727_073836-buildvm-ppc64le-16.ppc.fedoraproje4
[   78.517776] Call Trace:
[   78.518305]  <TASK>
[   78.518790]  dump_stack_lvl+0x7f/0xb0
[   78.519580]  dump_stack+0x18/0x30
[   78.520292]  panic+0x4e6/0x520
[   78.520965]  jbd2_log_do_checkpoint+0x818/0x840
[   78.521935]  __jbd2_log_wait_for_space+0x187/0x3c0
[   78.522949]  add_transaction_credits+0x3fc/0x4d0
[   78.523697]  ? add_timer+0x1ca/0x350
[   78.524020]  start_this_handle+0x156/0x970
[   78.524389]  ? kmem_cache_alloc+0x4db/0xac0
[   78.524862]  jbd2__journal_start+0x130/0x300
[   78.525288]  __ext4_journal_start_sb+0x2aa/0x300
[   78.525715]  ext4_dirty_inode+0x41/0xa0
[   78.526073]  __mark_inode_dirty+0x93/0x6b0
[   78.526472]  ext4_setattr+0x16d/0x10b0
[   78.526832]  ? path_lookupat.isra.0+0xca/0x200
[   78.527248]  notify_change+0x44f/0x760
[   78.527604]  ? __call_rcu_common.constprop.0+0x116/0xa80
[   78.528089]  ? chmod_common+0x11f/0x210
[   78.528444]  chmod_common+0x11f/0x210
[   78.528791]  ? kmemleak_free+0x47/0xa0
[   78.529145]  ? putname+0x79/0xa0
[   78.529456]  do_fchmodat+0x6e/0xf0
[   78.529788]  __x64_sys_fchmodat+0x22/0x30
[   78.530159]  do_syscall_64+0x39/0x80
[   78.530497]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[   78.530970] RIP: 0033:0x7fc88a6ffdb9
[   78.531304] Code: ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 f7 =
c1
ff fe ff ff 75 38 80 e5 01 75 4b 48 63 ff 89 d2 b0
[   78.532967] RSP: 002b:00007fffb4c6e0e8 EFLAGS: 00000246 ORIG_RAX:
000000000000010c
[   78.533671] RAX: ffffffffffffffda RBX: 0000000000000001 RCX:
00007fc88a6ffdb9
[   78.534323] RDX: 00000000000001ed RSI: 000055555b1d30f0 RDI:
ffffffffffffff9c
[   78.534984] RBP: 000055555b1d3060 R08: 0000000000000000 R09:
0000000000000000
[   78.535648] R10: 0000000000000000 R11: 0000000000000246 R12:
0000555559a0a734
[   78.536302] R13: 000055555b1d30f0 R14: 000055555b1d4320 R15:
0000000000008000
[   78.536974]  </TASK>
[   78.537345] Kernel Offset: disabled
[   78.537681] ---[ end Kernel panic - not syncing: DONE ]---

3. reboot
4. fsck.ext4 -fa /dev/sda
[root@localhost ~]# fsck.ext4  -fa /dev/sda
/dev/sda: recovering journal
/dev/sda: Entry 'a' in / (2) references inode 1036 found in group 0's unused
inodes area.
FIXED.
/dev/sda: Entry 'a' in / (2) has an incorrect filetype (was 1, should be 0).


/dev/sda: UNEXPECTED INCONSISTENCY; RUN fsck MANUALLY.
        (i.e., without -a or -p options)

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
