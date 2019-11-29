Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D68BB10D8C7
	for <lists+linux-ext4@lfdr.de>; Fri, 29 Nov 2019 18:05:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbfK2RFg convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-ext4@lfdr.de>); Fri, 29 Nov 2019 12:05:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:38674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726608AbfK2RFf (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 29 Nov 2019 12:05:35 -0500
From:   bugzilla-daemon@bugzilla.kernel.org
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-ext4@vger.kernel.org
Subject: [Bug 205707] New: LINUX KERNEL 5.3.10 - ext4_xattr_set_entry
 use-after-free
Date:   Fri, 29 Nov 2019 17:05:34 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: tristmd@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression
Message-ID: <bug-205707-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=205707

            Bug ID: 205707
           Summary: LINUX KERNEL 5.3.10 - ext4_xattr_set_entry
                    use-after-free
           Product: File System
           Version: 2.5
    Kernel Version: 5.3.10
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: ext4
          Assignee: fs_ext4@kernel-bugs.osdl.org
          Reporter: tristmd@gmail.com
        Regression: No

LINUX KERNEL 5.3.10 - ext4_xattr_set_entry use-after-free

0x01 - Introduction
===

# Product: Linux Kernel 
# Version: 5.3.10 (and probably other versions)
# Bug: UAF (Read)
# Tested on: GNU/Linux Debian 9 x86_64


0x02 - Crash report
===

EXT4-fs (sda): Unrecognized mount option
"fsuuid=Pcc366a�-1035-3ea9-7c93-j1a9eda2" or missing value
==================================================================
BUG: KASAN: use-after-free in ext4_xattr_set_entry+0x2a6b/0x3440
fs/ext4/xattr.c:1600
Read of size 4 at addr ffff88800aaf0002 by task syz-executor.3/354

CPU: 0 PID: 354 Comm: syz-executor.3 Not tainted 5.3.10 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0xca/0x13e lib/dump_stack.c:113
 print_address_description+0x67/0x360 mm/kasan/report.c:351
 __kasan_report.cold.7+0x1a/0x3b mm/kasan/report.c:482
 kasan_report+0xe/0x12 mm/kasan/common.c:618
 ext4_xattr_set_entry+0x2a6b/0x3440 fs/ext4/xattr.c:1600
 ext4_xattr_ibody_set+0x78/0x2b0 fs/ext4/xattr.c:2236
 ext4_xattr_set_handle+0x70e/0xff0 fs/ext4/xattr.c:2392
 ext4_initxattrs+0xb8/0x120 fs/ext4/xattr_security.c:43
 security_inode_init_security security/security.c:956 [inline]
 security_inode_init_security+0x186/0x310 security/security.c:929
 __ext4_new_inode+0x4000/0x49c0 fs/ext4/ialloc.c:1160
EXT4-fs error (device sda): ext4_xattr_set_entry:1603: inode #15574: comm
syz-executor.0: corrupted xattr entries
 ext4_mkdir+0x266/0xd10 fs/ext4/namei.c:2763
 vfs_mkdir+0x3ae/0x5c0 fs/namei.c:3815
 do_mkdirat+0x144/0x250 fs/namei.c:3838
 do_syscall_64+0xbc/0x560 arch/x86/entry/common.c:296
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x464cd7
Code: 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f
84 00 00 00 00 00 0f 1f 44 00 00 b8 53 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01
c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc3097ec68 EFLAGS: 00000202 ORIG_RAX: 0000000000000053
RAX: ffffffffffffffda RBX: 00007ffc3097ecb0 RCX: 0000000000464cd7
RDX: 00000000004a5f12 RSI: 00000000000001ff RDI: 00007ffc3097ecb0
RBP: 00007ffc3097ecac R08: 0000000000000000 R09: 0000000000000006
R10: 0000000000000000 R11: 0000000000000202 R12: 00000000000e9973
R13: 0000000000000004 R14: 00000000000e9937 R15: 00000000ffffffff

The buggy address belongs to the page:
page:ffffea00002abc00 refcount:0 mapcount:-128 mapping:0000000000000000
index:0x1
flags: 0x100000000000000()
raw: 0100000000000000 ffffea00002aee08 ffffea00002a9c08 0000000000000000
raw: 0000000000000001 0000000000000003 00000000ffffff7f 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff88800aaeff00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff88800aaeff80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff88800aaf0000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                   ^
 ffff88800aaf0080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff88800aaf0100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
==================================================================

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
