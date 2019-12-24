Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97CD612A1F4
	for <lists+linux-ext4@lfdr.de>; Tue, 24 Dec 2019 15:07:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726171AbfLXOHh convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-ext4@lfdr.de>); Tue, 24 Dec 2019 09:07:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:47778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726157AbfLXOHh (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 24 Dec 2019 09:07:37 -0500
From:   bugzilla-daemon@bugzilla.kernel.org
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-ext4@vger.kernel.org
Subject: [Bug 205957] New: Ext4 64 bit hash breaks 32 bit glibc 2.28+
Date:   Tue, 24 Dec 2019 14:07:36 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: aladjev.andrew@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression
Message-ID: <bug-205957-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=205957

            Bug ID: 205957
           Summary: Ext4 64 bit hash breaks 32 bit glibc 2.28+
           Product: File System
           Version: 2.5
    Kernel Version: 5.3.16 (any version)
          Hardware: ARM
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: ext4
          Assignee: fs_ext4@kernel-bugs.osdl.org
          Reporter: aladjev.andrew@gmail.com
        Regression: No

Hello. Please see the following glibc issue:
https://sourceware.org/bugzilla/show_bug.cgi?id=23960.

I am running arm system using qemu on host system with x86_64 kernel. I've
received 64 bits value for "d_off" instead of 32 bits from "getdents64".

Than I've tried i386 instead of arm and it works fine. I've received 32 bits
value for "d_off" from "getdents64".

I think that the problem is here
arch/x86/include/generated/uapi/asm/unistd_x32.h:
#define __NR_getdents64 (__X32_SYSCALL_BIT + 217)

arch/x86/include/asm/compat.h:
static inline bool in_x32_syscall(void)
{
#ifdef CONFIG_X86_X32_ABI
        if (task_pt_regs(current)->orig_ax & __X32_SYSCALL_BIT)
                return true;
#endif
        return false;
}

fs/ext4/dir.c:
static inline int is_32bit_api(void)
{
#ifdef CONFIG_COMPAT
        return in_compat_syscall();
#else
        return (BITS_PER_LONG == 32);
#endif
}

static inline loff_t hash2pos(struct file *filp, __u32 major, __u32 minor)
{
        if ((filp->f_mode & FMODE_32BITHASH) ||
            (!(filp->f_mode & FMODE_64BITHASH) && is_32bit_api()))
                return major >> 1;
        else
                return ((__u64)(major >> 1) << 32) | (__u64)minor;
}

I think that i386 makes a special syscall with "__X32_SYSCALL_BIT" enabled.
This special bit makes "in_x32_syscall", "in_compat_syscall" and "is_32bit_api"
to return true. This thing affects "hash2pos" and it works like
"FMODE_32BITHASH" is enabled.

ARM has no such special system, it uses generic "in_compat_syscall".
include/linux/compat.h:
* For most but not all architectures, "am I in a compat syscall?" and
* "am I a compat task?" are the same question.  For architectures on which
* they aren't the same question, arch code can override in_compat_syscall.

I don't know how to fix this issue.

1. Is it possible to implement special arm syscalls in the same way as x86?

2. Is it possible to add special compatibility syscall like
"__NR_compat_getdents64" that will make generic "in_compat_syscall" return
true?

3. Is it possible to force enable FMODE_32BITHASH for arm syscalls in runtime
in another way?

4. We can't shift "d_off >> 32" now, because we will have to restore "<< 32" in
all third party applications (not only glibc). Is it possible to replace
"((__u64)(major >> 1) << 32) | (__u64)minor" with "((__u64)minor << 32) |
(__u64)(major >> 1)"? So we will just ignore minor overflow.

5. Is it possible to refactor ext4 and remove hash from pos completely? It
provides so much pain.

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
