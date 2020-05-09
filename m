Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C32A51CBF9A
	for <lists+linux-ext4@lfdr.de>; Sat,  9 May 2020 11:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727844AbgEIJHS convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-ext4@lfdr.de>); Sat, 9 May 2020 05:07:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:34692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725930AbgEIJHS (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Sat, 9 May 2020 05:07:18 -0400
From:   bugzilla-daemon@bugzilla.kernel.org
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-ext4@vger.kernel.org
Subject: [Bug 207635] New: EXT4-fs error (device sda3): ext4_lookup:1701:
 inode #...: comm find: casefold flag without casefold feature; EXT4-fs
 (sda3): Remounting filesystem read-only
Date:   Sat, 09 May 2020 09:07:16 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: blocking
X-Bugzilla-Who: joerg.sigle@jsigle.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression
Message-ID: <bug-207635-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=207635

            Bug ID: 207635
           Summary: EXT4-fs error (device sda3): ext4_lookup:1701: inode
                    #...: comm find: casefold flag without casefold
                    feature; EXT4-fs (sda3): Remounting filesystem
                    read-only
           Product: File System
           Version: 2.5
    Kernel Version: 5.5.11
          Hardware: x86-64
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: blocking
          Priority: P1
         Component: ext4
          Assignee: fs_ext4@kernel-bugs.osdl.org
          Reporter: joerg.sigle@jsigle.com
        Regression: No

Hello.

Since upgrade to Linux 5.5.11 on a Devuan System I've had a previously
completely stable system repeatedly remount the root file system as read only,
effectively requiring a reboot and fsck.

This problem appeared at about the same time when I read about the casefold
feature being added; I did not willingly activate that feature nor do I want to
use it. I suspect however, that the new feature might have come with a new bug.

This is an ext2 filesystem using the ext4 kernel subsystem.

The error occurs maybe once every few days; i.e. I'm practically unable to
reproduce it willingly, but it's often enough to recognize it as a truly
existing problem. It's definitely a show-stopper, but I don't know yet whether
it causes data loss as well.

Going back to the previously used Linux 5.3.15 quite probably removed the
problem. And going forward to 5.5.11 made the problem re-appear.

These are self compiled kernels, quite possibly I don't use the best .config
that I could. I can provide the .config files for both the 5.3.15 and the
5.5.11 kernels I have used.

$ cat /proc/version
Linux version 5.5.11-i7 (root@think3) (gcc version 8.3.0 (Debian 8.3.0-6)) #1
SMP PREEMPT Wed Mar 25 04:44:37 CET 2020

# dmesg | tail
EXT4-fs error (device sda3): ext4_lookup:1701: inode #4253945: comm find:
casefold flag without casefold feature
EXT4-fs (sda3): Remounting filesystem read-only

This was after startup, a little bit of web browsing, and getting and reading
my e-mail.

And upon restart:

/dev/sda3 contains a file system with errors, check forced.
/dev/sda3: Deleted inode 14729236 has zero dtime.  FIXED.
/dev/sda3: Deleted inode 14729243 has zero dtime.  FIXED.
/dev/sda3: Deleted inode 14738534 has zero dtime.  FIXED.
/dev/sda3: Deleted inode 14738583 has zero dtime.  FIXED.
/dev/sda3: Deleted inode 14738843 has zero dtime.  FIXED.

Thanks a lot for looking into this; and I may provide additional info if you
tell me what you need.

Kind regards - j.

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
