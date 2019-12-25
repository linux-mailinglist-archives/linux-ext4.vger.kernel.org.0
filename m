Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9478E12A93D
	for <lists+linux-ext4@lfdr.de>; Wed, 25 Dec 2019 23:53:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbfLYWxO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-ext4@lfdr.de>); Wed, 25 Dec 2019 17:53:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:50082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726469AbfLYWxO (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 25 Dec 2019 17:53:14 -0500
From:   bugzilla-daemon@bugzilla.kernel.org
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-ext4@vger.kernel.org
Subject: [Bug 205957] Ext4 64 bit hash breaks 32 bit glibc 2.28+
Date:   Wed, 25 Dec 2019 22:53:13 +0000
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
Message-ID: <bug-205957-13602-9v8DcYwBox@https.bugzilla.kernel.org/>
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

--- Comment #9 from aladjev.andrew@gmail.com (aladjev.andrew@gmail.com) ---
I've created heavy (but easy) bunch of patches that fixes issue. This is the
order of right patches applyment (for gentoo):

+----------------------------------------------------------------------------+
|                                                                            |
| amd64 host:            +-------------------------------------------------+ |
|                        |                                                 | |
| linux-headers: kernel  | amd64 container:      +-----------------------+ | |
| gentoo-sources: kernel |                       |                       | | |
| libseccomp             | linux-headers: kernel | arm container (qemu): | | |
| go                     | qemu                  |                       | | |
| buildah                |                       | linux-headers: kernel | | |
|                        |                       | glibc                 | | |
|                        |                       |                       | | |
|                        |                       +-----------------------+ | |
|                        |                                                 | |
|                        +-------------------------------------------------+ |
|                                                                            |
+----------------------------------------------------------------------------+

You can find full example here
https://github.com/andrew-aladev/test-images/tree/master/cross/arm-unknown-linux-gnueabi.
Now I am able to emerge several application inside arm container (qemu), so
glibc with "getdents64_x32" works perfect.

I understand that kernel developers don't like additional syscalls, so they
won't accept such kernel patch. But this syscall is the easiest way for me to
provide a proof of concept.

How to understand these patches? Please read "glibc.patch". Our amd64 kernel is
the common kernel for amd64, i386 and arm (via qemu). amd64 is using
"getdents64" and arm (without LFS) is using "getdents64_x32". We need to have 2
syscalls simultaneously: "getdents64" and "getdents64_x32" or maybe single
syscall with some "x32" flag. I think this will be the most reliable solution.

I want to ask glibc and kernel developers to cooperate and find the right
solution. This is important not only for arm, it looks like this issue affects
any x32 abi.

Thank you.

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
