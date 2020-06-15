Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F31A71F8BD7
	for <lists+linux-ext4@lfdr.de>; Mon, 15 Jun 2020 02:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728014AbgFOAKz convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-ext4@lfdr.de>); Sun, 14 Jun 2020 20:10:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:49802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727954AbgFOAKy (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Sun, 14 Jun 2020 20:10:54 -0400
From:   bugzilla-daemon@bugzilla.kernel.org
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-ext4@vger.kernel.org
Subject: [Bug 208173] New: BUG: using smp_processor_id() in preemptible,
 caller is ext4_mb_new_blocks
Date:   Mon, 15 Jun 2020 00:10:53 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: tseewald@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression attachments.created
Message-ID: <bug-208173-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=208173

            Bug ID: 208173
           Summary: BUG: using smp_processor_id() in preemptible, caller
                    is ext4_mb_new_blocks
           Product: File System
           Version: 2.5
    Kernel Version: 5.8.0-rc1
          Hardware: x86-64
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: ext4
          Assignee: fs_ext4@kernel-bugs.osdl.org
          Reporter: tseewald@gmail.com
        Regression: No

Created attachment 289655
  --> https://bugzilla.kernel.org/attachment.cgi?id=289655&action=edit
dmesg

Immediately after booting 5.8.0-rc1 and logging in, dmesg is filled with BUG
backtraces like:

[   10.823091] BUG: using smp_processor_id() in preemptible [00000000] code:
auditd/788
[   10.823095] caller is ext4_mb_new_blocks+0x285/0xd50
[   10.823096] CPU: 2 PID: 788 Comm: auditd Not tainted 5.8.0-rc1 #15
[   10.823097] Hardware name: To Be Filled By O.E.M. To Be Filled By O.E.M./Z77
Extreme4, BIOS P2.90 07/11/2013
[   10.823097] Call Trace:
[   10.823104]  dump_stack+0x57/0x70
[   10.823107]  check_preemption_disabled+0xab/0xc0
[   10.823109]  ext4_mb_new_blocks+0x285/0xd50
[   10.823112]  ? __kmalloc+0x1ac/0x280
[   10.823114]  ? ext4_find_extent+0x2a1/0x370
[   10.823116]  ? ext4_find_extent+0x163/0x370
[   10.823118]  ? release_pages+0x3b1/0x470
[   10.823120]  ext4_ext_map_blocks+0x84d/0xcc0
[   10.823122]  ext4_map_blocks+0xef/0x560
[   10.823124]  ? kmem_cache_alloc+0x181/0x220
[   10.823126]  ext4_writepages+0x856/0xe00
[   10.823130]  ? futex_wait+0x11d/0x210
[   10.823132]  ? do_writepages+0x41/0xd0
[   10.823134]  ? __ext4_mark_inode_dirty+0x250/0x250
[   10.823134]  do_writepages+0x41/0xd0
[   10.823137]  ? wbc_attach_and_unlock_inode+0xd6/0x140
[   10.823139]  __filemap_fdatawrite_range+0xcb/0x100
[   10.823141]  file_write_and_wait_range+0x5e/0xb0
[   10.823143]  ext4_sync_file+0x10c/0x3a0
[   10.823144]  do_fsync+0x38/0x70
[   10.823146]  __x64_sys_fsync+0x10/0x20
[   10.823147]  do_syscall_64+0x47/0x80
[   10.823150]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   10.823152] RIP: 0033:0x7fb904384f1b
[   10.823152] Code: Bad RIP value.
[   10.823153] RSP: 002b:00007fb903d4cd00 EFLAGS: 00000293 ORIG_RAX:
000000000000004a
[   10.823154] RAX: ffffffffffffffda RBX: 0000000000000000 RCX:
00007fb904384f1b
[   10.823155] RDX: 0000000000000001 RSI: 0000000000000081 RDI:
0000000000000005
[   10.823155] RBP: 000055c4f63e82c0 R08: 0000000000000000 R09:
00007fb903d4d700
[   10.823156] R10: 0000000000000000 R11: 0000000000000293 R12:
00007ffd56550cce
[   10.823156] R13: 00007ffd56550ccf R14: 00007ffd56550cd0 R15:
00007fb903d4d700

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
