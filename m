Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE6D8189EFE
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Mar 2020 16:07:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726866AbgCRPHd convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-ext4@lfdr.de>); Wed, 18 Mar 2020 11:07:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:36582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726822AbgCRPHc (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 18 Mar 2020 11:07:32 -0400
From:   bugzilla-daemon@bugzilla.kernel.org
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-ext4@vger.kernel.org
Subject: [Bug 206879] New: "extent tree corrupted" after several syscalls
 involving EXT4_IOC_SWAP_BOOT on a sparse file
Date:   Wed, 18 Mar 2020 15:07:32 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: anatoly.trosinenko@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression attachments.created
Message-ID: <bug-206879-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=206879

            Bug ID: 206879
           Summary: "extent tree corrupted" after several syscalls
                    involving EXT4_IOC_SWAP_BOOT on a sparse file
           Product: File System
           Version: 2.5
    Kernel Version: tytso/ext4/dev (dce8e2371)
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: ext4
          Assignee: fs_ext4@kernel-bugs.osdl.org
          Reporter: anatoly.trosinenko@gmail.com
        Regression: No

Created attachment 287969
  --> https://bugzilla.kernel.org/attachment.cgi?id=287969&action=edit
Reproducer

Hello,

By fuzzing, I have found an "extent tree corrupted" message after invoking
several syscalls on a clean ext4 file system image. Some of these are quite
special ioctls probably mis-used by my fuzzer, still I report this just in
case.

How to reproduce (with kvm-xfstests):

1) Checkout tytso/ext4 branch dev (commit dce8e2371)
2) cp /path/to/fstests/kernel-configs/x86_64-config-5.4 .config
3) make olddefconfig
4) make
5) Compile the attached reproducer:

   gcc ext4-test.c -o /tmp/kvm-xfstests-USER/repro -static

   In my case, the kernel was built for amd64, so reproducer is for amd64, too.
With `-m32`, I get a ENOTTY error on EXT4_IOC_SWAP_BOOT
6) Run `./kvm-xfstests shell`
7) Inside the shell:
   mke2fs -t ext4 test.img 1024M
   mount test.img /mnt
   /vtmp/repro /mnt/123 /mnt/abc
8) Observe in dmesg:
   [  114.760535] EXT4-fs error (device loop0): ext4_ext_precache:579: inode
#12: comm repro: pblk 32897 bad header/extent: extent tree corrupted - magic
f30a, entries 5, max 340(340), depth 0(0)

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
