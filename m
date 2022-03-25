Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C14464E7BFD
	for <lists+linux-ext4@lfdr.de>; Sat, 26 Mar 2022 01:21:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233741AbiCYWhy (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 25 Mar 2022 18:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233826AbiCYWhx (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 25 Mar 2022 18:37:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84FD150E02
        for <linux-ext4@vger.kernel.org>; Fri, 25 Mar 2022 15:36:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 13B0560ADD
        for <linux-ext4@vger.kernel.org>; Fri, 25 Mar 2022 22:36:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6DE36C340ED
        for <linux-ext4@vger.kernel.org>; Fri, 25 Mar 2022 22:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648247777;
        bh=UybdRUeGIHTeFW8NoAOaxlNTJGYTWRZnLiycMrpVESY=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=a9e3kHyyl4Cq9GohjrcjQGT5jC7JcoLchwLgRiz6FfCbBM5Ur52PFHw4AVh2Bsz+5
         bojreDyq92Gcfl//Q71aoOlLCBqXmb/peRG+tVDDqywb5q4gx6XmQSVEnDIAg7eiOu
         lPPpJJfz8kf3RIjCW+3afQCEyt4nmyy+skfavy7nuhH+Hei4NiZCgpXxFKVdgb+gwR
         IYwcbSJkUT+f4JeFyJKKpP3Ad0B1/FLbQvc/45Lac7ywnI4bDnJ/wReQcBo8qqeVWd
         8Y0hC5Pe6IZ/0SwCILpb6NNp0lZnJz+dDDpd9m8WxhPUhx2lz5Lx6zCbjckGq/MR9N
         T0vVeqWcsalVw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 4DEDAC05FD4; Fri, 25 Mar 2022 22:36:17 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 211819] Processes stuck in D-state after accessing
 ext4+fast_commit+fscrypt
Date:   Fri, 25 Mar 2022 22:36:16 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: kernel@twinhelix.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-211819-13602-opkiWIhkdR@https.bugzilla.kernel.org/>
In-Reply-To: <bug-211819-13602@https.bugzilla.kernel.org/>
References: <bug-211819-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D211819

AT (kernel@twinhelix.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |kernel@twinhelix.com

--- Comment #1 from AT (kernel@twinhelix.com) ---
This affects kernels 5.16.15-arch1 and 5.16.16-arch1 at least (distro sugge=
sted
I add to this report). While running 5.16.16 with my home directory encrypt=
ed
with fscrypt (automatically unlocked on login), I enabled EXT4 fast_commit =
on
my root drive with:

sudo tune2fs -O fast_commit /dev/nvme0n1p2

( Other filesystem features: has_journal ext_attr resize_inode dir_index
filetype needs_recovery extent flex_bg encrypt sparse_super large_file
huge_file dir_nlink extra_isize metadata_csum )

The system remained responsive but after that there were repeated episodes =
like
this in the log while running Firefox:

1 Mar 23 22:19:15 hostname kernel: INFO: task IndexedDB #19:3350 blocked for
more than 122 seconds.
1 Mar 23 22:19:15 hostname kernel: Not tainted 5.16.16-arch1-1 #1
2 Mar 23 22:19:15 hostname kernel: "echo 0 >
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
3 Mar 23 22:19:15 hostname kernel: task:IndexedDB #19 state:D stack: 0 pid:
3350 ppid: 1393 flags:0x00000002
4 Mar 23 22:19:15 hostname kernel: Call Trace:
5 Mar 23 22:19:15 hostname kernel: <TASK>
6 Mar 23 22:19:15 hostname kernel: __schedule+0x2f6/0xf80
7 Mar 23 22:19:15 hostname kernel: ? touch_atime+0x44/0x190
8 Mar 23 22:19:15 hostname kernel: schedule+0x4b/0xc0
9 Mar 23 22:19:15 hostname kernel: ext4_fc_wait_committing_inode+0xad/0xe0
[ext4 ef9ba7b6856d0b378c7bc2df0cae9987df17f5c0]
10 Mar 23 22:19:15 hostname kernel: ? var_wake_function+0x20/0x20
11 Mar 23 22:19:15 hostname kernel: ext4_fc_start_update+0x43/0x90 [ext4
ef9ba7b6856d0b378c7bc2df0cae9987df17f5c0]
12 Mar 23 22:19:15 hostname kernel: ext4_buffered_write_iter+0x35/0x120 [ex=
t4
ef9ba7b6856d0b378c7bc2df0cae9987df17f5c0]
13 Mar 23 22:19:15 hostname kernel: new_sync_write+0x15c/0x1f0
14 Mar 23 22:19:15 hostname kernel: vfs_write+0x1eb/0x280
15 Mar 23 22:19:15 hostname kernel: ksys_write+0x67/0xe0
16 Mar 23 22:19:15 hostname kernel: do_syscall_64+0x5c/0x80
17 Mar 23 22:19:15 hostname kernel: ? do_syscall_64+0x69/0x80
18 Mar 23 22:19:15 hostname kernel: ? syscall_exit_to_user_mode+0x23/0x40
19 Mar 23 22:19:15 hostname kernel: ? do_syscall_64+0x69/0x80
20 Mar 23 22:19:15 hostname kernel: entry_SYSCALL_64_after_hwframe+0x44/0xae
21 Mar 23 22:19:15 hostname kernel: RIP: 0033:0x7f5c0222928f
22 Mar 23 22:19:15 hostname kernel: RSP: 002b:00007f5becaac970 EFLAGS: 0000=
0293
ORIG_RAX: 0000000000000001
23 Mar 23 22:19:15 hostname kernel: RAX: ffffffffffffffda RBX: 00007f5bbcfc=
ffa0
RCX: 00007f5c0222928f
24 Mar 23 22:19:15 hostname kernel: RDX: 0000000000001000 RSI: 00007f5bb8e8=
9000
RDI: 0000000000000038
25 Mar 23 22:19:15 hostname kernel: RBP: 0000000000000038 R08: 000000000000=
0000
R09: 0000000000000001
26 Mar 23 22:19:15 hostname kernel: R10: 00007ffea35cb080 R11: 000000000000=
0293
R12: 00007f5bb8e89000
27 Mar 23 22:19:15 hostname kernel: R13: 0000000000001000 R14: 00007f5bbcfc=
ffa0
R15: 0000000000012000
28 Mar 23 22:19:15 hostname kernel: </TASK>

Shutdown was held up by Firefox/Thunderbird processes hanging, after an exp=
ired
timeout I had to forcefully reboot with Magic SysRq key. At one point the
system wouldn't boot with disk errors and I had to fsck.ext4 in the initrd,
luckily managed to get booting again. Log from the latter part of an attemp=
ted
suspend:

Mar 24 00:41:16 hostname kernel: PM: suspend entry (s2idle)
Mar 24 00:41:16 hostname kernel: Filesystems sync: 0.009 seconds
Mar 24 00:41:36 hostname kernel: Freezing user space processes ...
Mar 24 00:41:36 hostname kernel: Freezing of tasks failed after 20.009 seco=
nds
(3 tasks refusing to freeze, wq_busy=3D0):
Mar 24 00:41:36 hostname kernel: task:IndexedDB #19 state:D stack: 0 pid: 3=
350
ppid: 1393 flags:0x00000006
Mar 24 00:41:36 hostname kernel: Call Trace:
Mar 24 00:41:36 hostname kernel: <TASK>
Mar 24 00:41:36 hostname kernel: __schedule+0x2f6/0xf80
Mar 24 00:41:36 hostname kernel: ? touch_atime+0x44/0x190
Mar 24 00:41:36 hostname kernel: schedule+0x4b/0xc0
Mar 24 00:41:36 hostname kernel: ext4_fc_wait_committing_inode+0xad/0xe0 [e=
xt4
ef9ba7b6856d0b378c7bc2df0cae9987df17f5c0]
Mar 24 00:41:36 hostname kernel: ? var_wake_function+0x20/0x20
Mar 24 00:41:36 hostname kernel: ext4_fc_start_update+0x43/0x90 [ext4
ef9ba7b6856d0b378c7bc2df0cae9987df17f5c0]
Mar 24 00:41:36 hostname kernel: ext4_buffered_write_iter+0x35/0x120 [ext4
ef9ba7b6856d0b378c7bc2df0cae9987df17f5c0]
Mar 24 00:41:36 hostname kernel: new_sync_write+0x15c/0x1f0
Mar 24 00:41:36 hostname kernel: vfs_write+0x1eb/0x280
Mar 24 00:41:36 hostname kernel: ksys_write+0x67/0xe0
Mar 24 00:41:36 hostname kernel: do_syscall_64+0x5c/0x80
Mar 24 00:41:36 hostname kernel: ? do_syscall_64+0x69/0x80
Mar 24 00:41:36 hostname kernel: ? syscall_exit_to_user_mode+0x23/0x40
Mar 24 00:41:36 hostname kernel: ? do_syscall_64+0x69/0x80
Mar 24 00:41:36 hostname kernel: entry_SYSCALL_64_after_hwframe+0x44/0xae
Mar 24 00:41:36 hostname kernel: RIP: 0033:0x7f5c0222928f
Mar 24 00:41:36 hostname kernel: RSP: 002b:00007f5becaac970 EFLAGS: 00000293
ORIG_RAX: 0000000000000001
Mar 24 00:41:36 hostname kernel: RAX: ffffffffffffffda RBX: 00007f5bbcfcffa0
RCX: 00007f5c0222928f
Mar 24 00:41:36 hostname kernel: RDX: 0000000000001000 RSI: 00007f5bb8e89000
RDI: 0000000000000038
Mar 24 00:41:36 hostname kernel: RBP: 0000000000000038 R08: 0000000000000000
R09: 0000000000000001
Mar 24 00:41:36 hostname kernel: R10: 00007ffea35cb080 R11: 0000000000000293
R12: 00007f5bb8e89000
Mar 24 00:41:36 hostname kernel: R13: 0000000000001000 R14: 00007f5bbcfcffa0
R15: 0000000000012000
Mar 24 00:41:36 hostname kernel: </TASK>
Mar 24 00:41:36 hostname kernel: task:Indexed~ Mnt #1 state:D stack: 0
pid:64999 ppid: 1393 flags:0x00000006
Mar 24 00:41:36 hostname kernel: Call Trace:
Mar 24 00:41:36 hostname kernel: <TASK>
Mar 24 00:41:36 hostname kernel: __schedule+0x2f6/0xf80
Mar 24 00:41:36 hostname kernel: schedule+0x4b/0xc0
Mar 24 00:41:36 hostname kernel: ext4_fc_wait_committing_inode+0xad/0xe0 [e=
xt4
ef9ba7b6856d0b378c7bc2df0cae9987df17f5c0]
Mar 24 00:41:36 hostname kernel: ? var_wake_function+0x20/0x20
Mar 24 00:41:36 hostname kernel: ext4_fc_start_update+0x43/0x90 [ext4
ef9ba7b6856d0b378c7bc2df0cae9987df17f5c0]
Mar 24 00:41:36 hostname kernel: ext4_buffered_write_iter+0x35/0x120 [ext4
ef9ba7b6856d0b378c7bc2df0cae9987df17f5c0]
Mar 24 00:41:36 hostname kernel: new_sync_write+0x15c/0x1f0
Mar 24 00:41:36 hostname kernel: vfs_write+0x1eb/0x280
Mar 24 00:41:36 hostname kernel: ksys_write+0x67/0xe0
Mar 24 00:41:36 hostname kernel: do_syscall_64+0x5c/0x80
Mar 24 00:41:36 hostname kernel: ? __fget_light+0x8f/0x110
Mar 24 00:41:36 hostname kernel: ? syscall_exit_to_user_mode+0x23/0x40
Mar 24 00:41:36 hostname kernel: ? do_syscall_64+0x69/0x80
Mar 24 00:41:36 hostname kernel: ? do_syscall_64+0x69/0x80
Mar 24 00:41:36 hostname kernel: ? syscall_exit_to_user_mode+0x23/0x40
Mar 24 00:41:36 hostname kernel: ? do_syscall_64+0x69/0x80
Mar 24 00:41:36 hostname kernel: ? do_syscall_64+0x69/0x80
Mar 24 00:41:36 hostname kernel: entry_SYSCALL_64_after_hwframe+0x44/0xae
Mar 24 00:41:36 hostname kernel: RIP: 0033:0x7f5c0222928f
Mar 24 00:41:36 hostname kernel: RSP: 002b:00007f5bbc0ebcf0 EFLAGS: 00000293
ORIG_RAX: 0000000000000001
Mar 24 00:41:36 hostname kernel: RAX: ffffffffffffffda RBX: 00007f5ba7fa5608
RCX: 00007f5c0222928f
Mar 24 00:41:36 hostname kernel: RDX: 0000000000000018 RSI: 00007f5bbc0ebeb0
RDI: 00000000000000ce
Mar 24 00:41:36 hostname kernel: RBP: 00000000000000ce R08: 0000000000000000
R09: 0000000000000000
Mar 24 00:41:36 hostname kernel: R10: 00007ffea35cb080 R11: 0000000000000293
R12: 00007f5bbc0ebeb0
Mar 24 00:41:36 hostname kernel: R13: 0000000000000018 R14: 00007f5ba7fa5608
R15: 0000000000058860
Mar 24 00:41:36 hostname kernel: </TASK>
Mar 24 00:41:36 hostname kernel: task:Indexed~ Mnt #2 state:D stack: 0
pid:65000 ppid: 1393 flags:0x00000006
Mar 24 00:41:36 hostname kernel: Call Trace:
Mar 24 00:41:36 hostname kernel: <TASK>
Mar 24 00:41:36 hostname kernel: __schedule+0x2f6/0xf80
Mar 24 00:41:36 hostname kernel: ? atime_needs_update+0x82/0x100
Mar 24 00:41:36 hostname kernel: schedule+0x4b/0xc0
Mar 24 00:41:36 hostname kernel: ext4_fc_wait_committing_inode+0xad/0xe0 [e=
xt4
ef9ba7b6856d0b378c7bc2df0cae9987df17f5c0]
Mar 24 00:41:36 hostname kernel: ? var_wake_function+0x20/0x20
Mar 24 00:41:36 hostname kernel: ext4_fc_start_update+0x43/0x90 [ext4
ef9ba7b6856d0b378c7bc2df0cae9987df17f5c0]
Mar 24 00:41:36 hostname kernel: ext4_buffered_write_iter+0x35/0x120 [ext4
ef9ba7b6856d0b378c7bc2df0cae9987df17f5c0]
Mar 24 00:41:36 hostname kernel: new_sync_write+0x15c/0x1f0
Mar 24 00:41:36 hostname kernel: vfs_write+0x1eb/0x280
Mar 24 00:41:36 hostname kernel: ksys_write+0x67/0xe0
Mar 24 00:41:36 hostname kernel: do_syscall_64+0x5c/0x80
Mar 24 00:41:36 hostname kernel: ? syscall_exit_to_user_mode+0x23/0x40
Mar 24 00:41:36 hostname kernel: ? do_syscall_64+0x69/0x80
Mar 24 00:41:36 hostname kernel: ? syscall_exit_to_user_mode+0x23/0x40
Mar 24 00:41:36 hostname kernel: ? do_syscall_64+0x69/0x80
Mar 24 00:41:36 hostname kernel: ? syscall_exit_to_user_mode+0x23/0x40
Mar 24 00:41:36 hostname kernel: ? do_syscall_64+0x69/0x80
Mar 24 00:41:36 hostname kernel: ? native_flush_tlb_local+0x31/0x40
Mar 24 00:41:36 hostname kernel: ? flush_tlb_func+0xc8/0x1d0
Mar 24 00:41:36 hostname kernel: ? sched_clock_cpu+0x9/0xb0
Mar 24 00:41:36 hostname kernel: ? irqtime_account_irq+0x38/0xb0
Mar 24 00:41:36 hostname kernel: entry_SYSCALL_64_after_hwframe+0x44/0xae
Mar 24 00:41:36 hostname kernel: RIP: 0033:0x7f5c0222928f
Mar 24 00:41:36 hostname kernel: RSP: 002b:00007f5baf502130 EFLAGS: 00000293
ORIG_RAX: 0000000000000001
Mar 24 00:41:36 hostname kernel: RAX: ffffffffffffffda RBX: 00007f5b98511da0
RCX: 00007f5c0222928f
Mar 24 00:41:36 hostname kernel: RDX: 0000000000001000 RSI: 00007f5baaf4c000
RDI: 00000000000000a2
Mar 24 00:41:36 hostname kernel: RBP: 00000000000000a2 R08: 0000000000000000
R09: 0000000000000001
Mar 24 00:41:36 hostname kernel: R10: 00007ffea35cb080 R11: 0000000000000293
R12: 00007f5baaf4c000
Mar 24 00:41:36 hostname kernel: R13: 0000000000001000 R14: 00007f5b98511da0
R15: 0000000000007000
Mar 24 00:41:36 hostname kernel: </TASK>
Mar 24 00:41:36 hostname kernel:
Mar 24 00:41:36 hostname kernel: OOM killer enabled.
Mar 24 00:41:36 hostname kernel: Restarting tasks ... done.
Mar 24 00:41:36 hostname kernel: PM: suspend exit
Mar 24 00:41:36 hostname systemd-sleep[65047]: Failed to put system to slee=
p.
System resumed again: Device or resource busy
Mar 24 00:41:36 hostname systemd[1]: systemd-suspend.service: Main process
exited, code=3Dexited, status=3D1/FAILURE
Mar 24 00:41:36 hostname audit[1]: SERVICE_START pid=3D1 uid=3D0 auid=3D429=
4967295
ses=3D4294967295 subj=3D=3Dunconfined msg=3D'unit=3Dsystemd-suspend comm=3D=
"systemd"
exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=3Df=
ailed'
Mar 24 00:41:36 hostname kernel: audit: type=3D1130 audit(1648035696.209:16=
6):
pid=3D1 uid=3D0 auid=3D4294967295 ses=3D4294967295 subj=3D=3Dunconfined
msg=3D'unit=3Dsystemd-suspend comm=3D"systemd" exe=3D"/usr/lib/systemd/syst=
emd"
hostname=3D? addr=3D? terminal=3D? res=3Dfailed'
Mar 24 00:41:36 hostname systemd[1]: systemd-suspend.service: Failed with
result 'exit-code'.
Mar 24 00:41:36 hostname systemd[1]: Failed to start System Suspend.
Mar 24 00:41:36 hostname systemd[1]: Dependency failed for Suspend.
Mar 24 00:41:36 hostname systemd[1]: suspend.target: Job suspend.target/sta=
rt
failed with result 'dependency'.
Mar 24 00:41:36 hostname systemd[1]: Stopped target Sleep.
Mar 24 00:41:36 hostname systemd-logind[595]: Operation 'sleep' finished.

I tried both kernels with the same issue. Then to remove it I ran:

sudo tune2fs -O ^fast_commit /dev/nvme0n1p2

which still resulted in errors until I rebooted and appended "fsck.mode=3Df=
orce"
to the Linux boot cmdline; the system now runs OK. Hope this helps debug the
fscrypt/fast_commit interaction.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
