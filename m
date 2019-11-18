Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 203B0100EBC
	for <lists+linux-ext4@lfdr.de>; Mon, 18 Nov 2019 23:23:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbfKRWXJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-ext4@lfdr.de>); Mon, 18 Nov 2019 17:23:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:58388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726647AbfKRWXJ (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 18 Nov 2019 17:23:09 -0500
From:   bugzilla-daemon@bugzilla.kernel.org
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-ext4@vger.kernel.org
Subject: [Bug 205571] New: potential data race on ext4_setattr around
 inode->i_mtime with ftruncate and readv
Date:   Mon, 18 Nov 2019 22:23:08 +0000
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
Message-ID: <bug-205571-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=205571

            Bug ID: 205571
           Summary: potential data race on ext4_setattr around
                    inode->i_mtime with ftruncate and readv
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

I am bringing up the visibility of a potential data race on ext4_setattr around
inode->i_mtime when one thread is doing ftruncate and the other readv.

[Setup]
creat(file_bar, 0777, ) = 4;
dup2(4, 198) = 198;
link(file_bar, link_bar) = 0;
open(link_bar, 0x2, 0777) = 6;
dup2(6, 196) = 196;


[Thread 1] ftruncate(198, 21009);
[Thread 2] readv(196, [{iov_base=0x0x7fa652a1fa07, iov_len=1641}, ,..], 6);

The function call trace is shown below:

[Thread 1: SYS_ftruncate]
__do_sys_ftruncate
  do_sys_ftruncate
    do_truncate
      ext4_setattr
        [WRITE] inode->i_mtime = current_time(inode);

[Thread 2: SYS_readv]
__do_sys_readv
  do_readv
    vfs_readv
      do_iter_read
        do_iter_readv_writev
          call_read_iter
            ext4_file_read_iter
              generic_file_read_iter
                generic_file_buffered_read
                  file_accessed
                    atime_needs_update
                      relatime_need_update
                        [READ] if (timespec64_compare(&inode->i_mtime,
&inode->i_atime) >= 0)


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
