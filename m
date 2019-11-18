Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC50100CF9
	for <lists+linux-ext4@lfdr.de>; Mon, 18 Nov 2019 21:15:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbfKRUPL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-ext4@lfdr.de>); Mon, 18 Nov 2019 15:15:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:41674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726435AbfKRUPK (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 18 Nov 2019 15:15:10 -0500
From:   bugzilla-daemon@bugzilla.kernel.org
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-ext4@vger.kernel.org
Subject: [Bug 205567] New: potential (possibly benign) data race on
 ext4_dir_entry_2->inode when getdents64 and rename happens on the same
 directory
Date:   Mon, 18 Nov 2019 20:15:09 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: mengxu.gatech@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression
Message-ID: <bug-205567-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=205567

            Bug ID: 205567
           Summary: potential (possibly benign) data race on
                    ext4_dir_entry_2->inode when getdents64 and rename
                    happens on the same directory
           Product: File System
           Version: 2.5
    Kernel Version: 5.4-rc5
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: ext4
          Assignee: fs_ext4@kernel-bugs.osdl.org
          Reporter: mengxu.gatech@gmail.com
        Regression: No

I am reporting a potential data race (maybe benign) in the ext4 layer on 
ext4_dir_entry_2->inode when getdents64 and rename happens on the same
directory.

[Setup]
mkdir(dir_foo, 0777);
open(dir_foo, 0x10000, 0777) = 0;
dup2(0, 199) = 199;

[Thread 1] getdents64(199, <some buffer>, 4469) = 48;
[Thread 2] rename(dir_foo, aaaaa) = 0;

The function call trace is shown below:

[Thread 1: SYS_getdents64]
__do_sys_getdents64
  ksys_getdents64
    iterate_dir
      ext4_readdir
        ext4_dx_readdir
          ext4_htree_fill_tree
            htree_dirblock_to_tree
              [READ] if (de->inode == 0)

[Thread 2: SYS_rename]
__do_renameat2
  do_renameat2
    vfs_rename
      ext4_rename2
        ext4_rename
          ext4_rename_dir_finish
            [WRITE] ent->parent_de->inode = cpu_to_le32(dir_ino);


I could confirm that the WRITE may happen before and after the READ operation
by controlling the timing of the two threads, i.e., by setting breakpoints
before the WRITE statement.

However, I am not very sure about the implication of such a data race (e.g.,
causing violations of assumptions). I would appreciate if you could help check
on this potential bug and advise whether this is a harmful data race or it
is intended. Thank you!

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
