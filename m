Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 870B312BCFA
	for <lists+linux-ext4@lfdr.de>; Sat, 28 Dec 2019 08:50:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbfL1Huh convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-ext4@lfdr.de>); Sat, 28 Dec 2019 02:50:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:34388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725857AbfL1Huh (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Sat, 28 Dec 2019 02:50:37 -0500
From:   bugzilla-daemon@bugzilla.kernel.org
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-ext4@vger.kernel.org
Subject: [Bug 205957] Ext4 64 bit hash breaks 32 bit glibc 2.28+
Date:   Sat, 28 Dec 2019 07:50:36 +0000
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
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-205957-13602-ce7D5uRyXO@https.bugzilla.kernel.org/>
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

--- Comment #10 from Andreas Dilger (adilger.kernelbugzilla@dilger.ca) ---
IMHO, adding a new syscall for this is a lot of complexity that could be
avoided.  Using an ioctl() or fadvise() to set the "32-bitness" of the file
descriptor would seem like a simpler implementation that could be handled
directly by an ext4 patch rather than having to change every architecture just
to pass this flag.

Then, in the cases that QEMU is running in the confusing "I want 32-bit values
returned from a 64-bit system call" mode, it would call the ioctl(fd,
FS_IOC_32BITHASH) once before calling getdents64(fd, ...).

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
