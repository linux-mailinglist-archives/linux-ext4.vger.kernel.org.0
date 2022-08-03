Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37668589313
	for <lists+linux-ext4@lfdr.de>; Wed,  3 Aug 2022 22:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235732AbiHCUS3 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 3 Aug 2022 16:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbiHCUS2 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 3 Aug 2022 16:18:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2ECC59242
        for <linux-ext4@vger.kernel.org>; Wed,  3 Aug 2022 13:18:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2510B614C3
        for <linux-ext4@vger.kernel.org>; Wed,  3 Aug 2022 20:18:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6C9EDC433D7
        for <linux-ext4@vger.kernel.org>; Wed,  3 Aug 2022 20:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659557906;
        bh=u6YzNUewvLCELuZWlRiDA1fx7AmQCFFW/KvgPl6zmok=;
        h=From:To:Subject:Date:From;
        b=IsFn7+gdtIbeAOpYL/gQ5jKgr/EMI5XuHx1fUqhk9bZR5CFiWUl/M45lJZMEpZX65
         yW/Tc2VnNJ2sU4BeVJeIffpsBlGYiUdMckeKU7Jtdty95zHrkbtdz/zsTfGNle71aC
         ol72BZNes6CUTOSXei2giNeXP3J7W1ZI52j/pg0N5GguBifGfQfgOJzMZjMwOwHF2Q
         D76oHiDWirMsQZ2OGntF1ssAuhyvNum1rXWlRYjr6JzP9Y2YMlGbamcRpPES6qXBJH
         tAMZ9BfTNdOs/z8WudHYbZ0bq72C4Ig/OFx0+y+CJ+ocnZ5IhpAdnTLCRjuT8fNFG9
         TgRTvwV3kpDdA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 513E3C433E7; Wed,  3 Aug 2022 20:18:26 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 216322] New: Freezing of tasks failed after 60.004 seconds (1
 tasks refusing to freeze... task:fstrim  ext4_trim_fs - Dell XPS 13 9310
Date:   Wed, 03 Aug 2022 20:18:26 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: lenb@kernel.org
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression
Message-ID: <bug-216322-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D216322

            Bug ID: 216322
           Summary: Freezing of tasks failed after 60.004 seconds (1 tasks
                    refusing to freeze... task:fstrim  ext4_trim_fs - Dell
                    XPS 13 9310
           Product: File System
           Version: 2.5
    Kernel Version: 5.19.0
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: ext4
          Assignee: fs_ext4@kernel-bugs.osdl.org
          Reporter: lenb@kernel.org
        Regression: No

The system suspend to idle path occasionally times out after 60 seconds
and throws the stack trace below.

The result is that the suspend path is aborted and the systems continues
running.

Unfortunately, when a user invokes suspend, they expect it to work,
and they may not be around (lid closed) to try it again when it aborts...

[10483.047079] PM: suspend entry (s2idle)
[10483.052777] Filesystems sync: 0.005 seconds
[10483.052782] PM: Preparing system for sleep (s2idle)
[10483.060824] Freezing user space processes ...=20
[10543.024088] Freezing of tasks failed after 60.004 seconds (1 tasks refus=
ing
to freeze, wq_busy=3D0):
[10543.024175] task:fstrim          state:D stack:    0 pid:225775 ppid:   =
  1
flags:0x00004006
[10543.024183] Call Trace:
[10543.024186]  &ltTASK&gt
[10543.024192]  __schedule+0x306/0x9f0
[10543.024202]  schedule+0x5c/0xd0
[10543.024206]  schedule_timeout+0x87/0x160
[10543.024211]  ? timer_migration_handler+0xa0/0xa0
[10543.024217]  trace_clock_x86_tsc+0x20/0x20
[10543.024224]  __wait_for_common+0x8f/0x190
[10543.024228]  ? firmware_map_remove+0x9c/0x9c
[10543.024233]  wait_for_completion_io_timeout+0x1d/0x30
[10543.024237]  submit_bio_wait+0x7f/0xc0
[10543.024244]  blkdev_issue_discard+0x6e/0xc0
[10543.024250]  ext4_try_to_trim_range+0x1f0/0x440
[10543.024259]  ext4_trim_fs+0x327/0x4d0
[10543.024266]  __ext4_ioctl+0x2d3/0x1590
[10543.024270]  ? putname+0x59/0x70
[10543.024275]  ? __seccomp_filter+0x3a6/0x5c0
[10543.024283]  ext4_ioctl+0xe/0x20
[10543.024287]  __x64_sys_ioctl+0x92/0xd0
[10543.024293]  do_syscall_64+0x59/0x90
[10543.024297]  ? do_syscall_64+0x69/0x90
[10543.024300]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[10543.024306] RIP: 0033:0x7f2ae6b1aaff
[10543.024312] RSP: 002b:00007ffd41e6de60 EFLAGS: 00000246 ORIG_RAX:
0000000000000010
[10543.024317] RAX: ffffffffffffffda RBX: 00007ffd41e6dfb0 RCX:
00007f2ae6b1aaff
[10543.024319] RDX: 00007ffd41e6ded0 RSI: 00000000c0185879 RDI:
0000000000000003
[10543.024322] RBP: 00005621c3642e90 R08: 00005621c3642e90 R09:
0000000000000000
[10543.024324] R10: 0000000000000000 R11: 0000000000000246 R12:
0000000000000003
[10543.024326] R13: 00005621c3642ce0 R14: 00005621c3642980 R15:
00005621c3642980
[10543.024330]  &lt/TASK&gt
[10543.024343] OOM killer enabled.
[10543.024344] Restarting tasks ... done.
[10543.085776] PM: suspend exit

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
