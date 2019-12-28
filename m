Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02EBC12BD6D
	for <lists+linux-ext4@lfdr.de>; Sat, 28 Dec 2019 12:20:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbfL1LUM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-ext4@lfdr.de>); Sat, 28 Dec 2019 06:20:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:40518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726187AbfL1LUL (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Sat, 28 Dec 2019 06:20:11 -0500
From:   bugzilla-daemon@bugzilla.kernel.org
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-ext4@vger.kernel.org
Subject: [Bug 205957] Ext4 64 bit hash breaks 32 bit glibc 2.28+
Date:   Sat, 28 Dec 2019 11:20:10 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: adilger.kernelbugzilla@dilger.ca
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-205957-13602-ilzvZjRWFg@https.bugzilla.kernel.org/>
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

--- Comment #12 from Andreas Dilger (adilger.kernelbugzilla@dilger.ca) ---
Created attachment 286491
  --> https://bugzilla.kernel.org/attachment.cgi?id=286491&action=edit
add ioctl(EXT4_IOC_SET_DIRLIMIT) to limit directory cookie size

Totally untested prototype patch to add ioctl(fd, EXT4_IOC_SET_DIRLIMIT, 32)
that could be used by glibc/QEMU to force ext4 to return a 32-bit directory
offset cookie for the 64-bit getdirent64() syscall on a per-fd basis.

The glibc patch would look something like the following, though this could
potentially be done only once per open:

 +  // It is affected by "__USE_FILE_OFFSET64" and "__USE_LARGEFILE64".
 +  if (sizeof (outp->u.d_off) != sizeof (inp->k.d_off))
 +    (void *) ioctl (fd, EXT4_IOC_SET_DIRLIMIT, 32); // ignore error return
 +
    retval = INLINE_SYSCALL_CALL (getdents64, fd, kbuf, kbytes);


If glibc/QEMU want ext4 to be totally transparent w.r.t. the behavior of the
syscalls, then glibc/QEMU would need set the kernel task state so that
is_32bit_api()->in_compat_syscall() return true and hash2pos() and related
functions can determine this directly to return a 32-bit pos in a manner
similar to x86.  That is outside my area of expertise, so I can't really
suggest how it might be done.  It would also be possible to add some different
logic to is_32bit_api() for ARM/etc. so that it is more transparent to
userspace, but I don't know what it should check.

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
