Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98C0D134FCB
	for <lists+linux-ext4@lfdr.de>; Thu,  9 Jan 2020 00:11:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbgAHXLa convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-ext4@lfdr.de>); Wed, 8 Jan 2020 18:11:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:54666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726548AbgAHXL3 (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 8 Jan 2020 18:11:29 -0500
From:   bugzilla-daemon@bugzilla.kernel.org
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-ext4@vger.kernel.org
Subject: [Bug 205957] Ext4 64 bit hash breaks 32 bit glibc 2.28+
Date:   Wed, 08 Jan 2020 23:11:27 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
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
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-205957-13602-kTK5qTDlXc@https.bugzilla.kernel.org/>
In-Reply-To: <bug-205957-13602@https.bugzilla.kernel.org/>
References: <bug-205957-13602@https.bugzilla.kernel.org/>
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

--- Comment #15 from aladjev.andrew@gmail.com (aladjev.andrew@gmail.com) ---
I've investigated mips related linux-user qemu and glibc source and mosaic
looks complete.

See qemu:
https://github.com/qemu/qemu/blob/master/linux-user/syscall.c#L9465-L9536
emulates getdents via getdents or getdents64, but don't emulate getdents64
using getdents.

Is it possible to emulate getdents64 using getdents? Yes, it was implemented in
glibc for mips 64:
https://github.com/bminor/glibc/blob/master/sysdeps/unix/sysv/linux/mips/mips64/getdents64.c#L49-L139
This emulation has been done because getdents64 was not available for some
ancient kernels on mips n64.

But this emulation should be a part of kernel. It has almost nothing to do with
qemu or glibc. Qemu should just launch compat syscall instead of regular and
that's it. Please see the following easy example:
https://github.com/torvalds/linux/blob/master/fs/read_write.c#L322-L332

SYSCALL_DEFINE3(lseek, unsigned int, fd, off_t, offset, unsigned int, whence)
{
        return ksys_lseek(fd, offset, whence);
}

#ifdef CONFIG_COMPAT
COMPAT_SYSCALL_DEFINE3(lseek, unsigned int, fd, compat_off_t, offset, unsigned
int, whence)
{
        return ksys_lseek(fd, offset, whence);
}
#endif

We need to declear compat syscall in the same way, like:

COMPAT_SYSCALL_DEFINE3(getdents64, unsigned int, fd, struct
compat_linux_dirent64 __user *, dirent, unsigned int, count)

"COMPAT_SYSCALL_DEFINE" will guarantee that "in_compat_syscall" will return
true and ext4 will use 32 bit hash.

Than we need to add this syscall to
https://github.com/torvalds/linux/blob/master/arch/x86/entry/syscalls/syscall_64.tbl#L361-L402

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
