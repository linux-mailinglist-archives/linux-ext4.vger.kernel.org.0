Return-Path: <linux-ext4+bounces-1579-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DBC7876ED8
	for <lists+linux-ext4@lfdr.de>; Sat,  9 Mar 2024 03:51:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54C7A1C20BD5
	for <lists+linux-ext4@lfdr.de>; Sat,  9 Mar 2024 02:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C7B32D60A;
	Sat,  9 Mar 2024 02:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RCRWH/Q8"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928A5208A8
	for <linux-ext4@vger.kernel.org>; Sat,  9 Mar 2024 02:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709952666; cv=none; b=QvjO/LZfuQHTUDmi/FA7nKHMQFugmp+xBr/Jmy2gJR7/mE77lEMFCOJeMW/s7UDdwG13gdwa7JXZuuLlCKMiGGBOzkqmG6U+WOoFgpYskxehZoydGd/tzdmlE25ABsutFGNcP9Lb1aAwHrcTrNZp4Pqaf8NjdAJWSdqIJVbVaQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709952666; c=relaxed/simple;
	bh=wNo7akoTlTS5GAC160jlopvlPQzUgcAaS2GNBJK7NXQ=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=DOuF40KSnJbz+RlUureJXr8MT17QUZKXlbyIZjtIXtSsF8k/JZrF2BnLVansTwxQT7wpwAOMbVNhhnVl+qfq6hM8Iy60e/fsx7ZU/tKqhLe0gs9hI+YY2n5T/uFscRpWUxifnoEXj1vi2pDEbWIJNaumvScAIj22AxVrww/zFQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RCRWH/Q8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1E86FC43390
	for <linux-ext4@vger.kernel.org>; Sat,  9 Mar 2024 02:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709952666;
	bh=wNo7akoTlTS5GAC160jlopvlPQzUgcAaS2GNBJK7NXQ=;
	h=From:To:Subject:Date:From;
	b=RCRWH/Q8j+/K4A6lv0bX9h77QCbnYGvZNln2Ob09qGVGLvd4uOsfHFjBkiH40DSHn
	 pv92ocTgeWwkD3KoBbaBFBCrEPfmeA0DfY+Hn5wi1Lj+bst8550owJvdEq/7Ujt3Q4
	 CZ3StyRAMeQecFv5p2Hhc0NIM+5d+OYTnHyOsNLJ3xGB35seBAVQCE88vkm6RS6xLS
	 oN0eMCBfSIc0oItLVqoYAQguRmmHx73ttIn/ZsvTd2vCl0yciaYfW2dl9z34SsoVWb
	 Blj1ZRg1Vsr77TU4dnELF7ehmLCzXoNFJjJOqIbb6ZvJw5D/6wCB46KrzzAJLTuUGu
	 PXzwXVjR0hNMA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 06840C53BC6; Sat,  9 Mar 2024 02:51:06 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 218576] New: ext4: ext4_mb_use_inode_pa: BUGON triggered by
 invalid pa
Date: Sat, 09 Mar 2024 02:51:05 +0000
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
Message-ID: <bug-218576-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

https://bugzilla.kernel.org/show_bug.cgi?id=3D218576

            Bug ID: 218576
           Summary: ext4: ext4_mb_use_inode_pa: BUGON triggered by invalid
                    pa
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

Reproducer:
1. Apply diff and compile kernel(CONFIG_EXT4_FS=3Dy)
2. Start vm(Use non-ext4 as rootfs), gcc -o aa a.c
3. ./aa
[   17.773715] pa_free 3 len 1
[   17.774530] assign g_bh ffff88810040a068
[   17.777084] fault inject
[   17.777852] Buffer I/O error on dev sda, logical block 45, lost async pa=
ge
write
[   17.785313] free bh
[   17.923462] EXT4-fs error (device sda): ext4_check_bdev_write_error:224:
comm dd: Error while async write back metadata
[   17.937886] pa_free 2 len 3
[   17.938747] ------------[ cut here ]------------
[   17.939991] kernel BUG at fs/ext4/mballoc.c:4681!
[   17.941228] invalid opcode: 0000 [#1] PREEMPT SMP
[   17.942446] CPU: 3 PID: 97 Comm: kworker/u8:3 Not tainted
6.8.0-rc7-00149-g472e37c02986-dirty #491
[   17.944684] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.16.1-2.fc37 04/01/2014
[   17.946866] Workqueue: writeback wb_workfn (flush-8:0)
[   17.948104] RIP: 0010:ext4_mb_use_inode_pa+0x1b6/0x1e0
[   17.949289] Code: 05 fe 10 60 0c 01 0f 0b 48 83 05 fc 10 60 0c 01 48 83 =
05
fc 10 60 0c 01 0f 0b 48 83 05 fa 10 60 0c 01 48 83 05 fa 10 60 0c 01 <0f3
[   17.953457] RSP: 0018:ffffc900004af7c0 EFLAGS: 00010202
[   17.954648] RAX: 0000000000000002 RBX: 0000000000000003 RCX:
0000000000000000
[   17.956273] RDX: 0000000000000015 RSI: ffff88882fd9ca40 RDI:
ffff88882fd9ca40
[   17.957718] RBP: ffff8881789cb000 R08: 0000000000000000 R09:
ffffc900004af660
[   17.958893] R10: ffffffff8351e680 R11: ffffffff8a51e668 R12:
ffff8881789cc000
[   17.960078] R13: 0000000000000015 R14: ffff88810382e000 R15:
0000000000000018
[   17.961260] FS:  0000000000000000(0000) GS:ffff88882fd80000(0000)
knlGS:0000000000000000
[   17.962588] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   17.963546] CR2: 00007fc58da1e000 CR3: 0000000003448000 CR4:
00000000000006f0
[   17.964725] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
0000000000000000
[   17.965904] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
0000000000000400
[   17.967083] Call Trace:
[   17.967480]  <TASK>
[   17.967750]  ? show_regs+0x88/0xa0
[   17.968181]  ? __die_body+0x26/0x90
[   17.968613]  ? die+0x5c/0xa0
[   17.969004]  ? do_trap+0x10e/0x140
[   17.969428]  ? do_error_trap+0x85/0xd0
[   17.969903]  ? ext4_mb_use_inode_pa+0x1b6/0x1e0
[   17.970464]  ? exc_invalid_op+0x68/0x80
[   17.970949]  ? ext4_mb_use_inode_pa+0x1b6/0x1e0
[   17.971505]  ? asm_exc_invalid_op+0x1a/0x20
[   17.972024]  ? ext4_mb_use_inode_pa+0x1b6/0x1e0
[   17.972580]  ext4_mb_use_preallocated.constprop.0+0x19e/0x540
[   17.973280]  ext4_mb_new_blocks+0x220/0x1f30
[   17.973800]  ? ext4_find_extent+0x21e/0x910
[   17.974320]  ext4_ext_map_blocks+0xf3c/0x2900
[   17.974856]  ? ext4_do_writepages+0xa25/0x1400
[   17.975402]  ? ext4_writepages+0x102/0x2b0
[   17.975901]  ? do_writepages+0x8c/0x260
[   17.976374]  ? __writeback_single_inode+0x61/0x710
[   17.976968]  ? writeback_sb_inodes+0x224/0x720
[   17.977509]  ? wb_writeback+0xd8/0x580
[   17.977939]  ? wb_workfn+0x148/0x820
[   17.978322]  ? process_scheduled_works+0x1ad/0x5d0
[   17.978832]  ? worker_thread+0x1f9/0x510
[   17.979251]  ? kthread+0x149/0x1c0
[   17.979613]  ? ret_from_fork+0x52/0x70
[   17.980019]  ? ret_from_fork_asm+0x11/0x20
[   17.980456]  ext4_map_blocks+0x264/0xa40
[   17.980872]  ext4_do_writepages+0xb15/0x1400
[   17.981335]  ext4_writepages+0x102/0x2b0
[   17.981755]  do_writepages+0x8c/0x260
[   17.982150]  __writeback_single_inode+0x61/0x710
[   17.982635]  writeback_sb_inodes+0x224/0x720
[   17.983088]  wb_writeback+0xd8/0x580
[   17.983468]  wb_workfn+0x148/0x820
[   17.983832]  ? finish_task_switch.isra.0+0x121/0x4d0
[   17.984364]  ? __schedule+0x5ae/0x1260
[   17.984765]  process_scheduled_works+0x1ad/0x5d0
[   17.985261]  worker_thread+0x1f9/0x510
[   17.985661]  ? rescuer_thread+0x490/0x490
[   17.986085]  kthread+0x149/0x1c0
[   17.986428]  ? kthread_exit+0x50/0x50
[   17.986819]  ret_from_fork+0x52/0x70
[   17.987200]  ? kthread_exit+0x50/0x50
[   17.987585]  ret_from_fork_asm+0x11/0x20
[   17.988004]  </TASK>
[   17.988242] Modules linked in:
[   17.988599] ---[ end trace 0000000000000000 ]---

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

