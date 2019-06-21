Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DAD24F01B
	for <lists+linux-ext4@lfdr.de>; Fri, 21 Jun 2019 22:47:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726017AbfFUUrd convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-ext4@lfdr.de>); Fri, 21 Jun 2019 16:47:33 -0400
Received: from mail.wl.linuxfoundation.org ([198.145.29.98]:58484 "EHLO
        mail.wl.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725985AbfFUUrd (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 21 Jun 2019 16:47:33 -0400
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id A81F128A77
        for <linux-ext4@vger.kernel.org>; Fri, 21 Jun 2019 20:47:32 +0000 (UTC)
Received: by mail.wl.linuxfoundation.org (Postfix, from userid 486)
        id 9C7E528BA9; Fri, 21 Jun 2019 20:47:32 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on
        pdx-wl-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=2.0 tests=BAYES_00,NO_RECEIVED,
        NO_RELAYS autolearn=unavailable version=3.3.1
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 203943] ext4 corruption after RAID6 degraded; e2fsck skips
 block checks and fails
Date:   Fri, 21 Jun 2019 20:47:31 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: tytso@mit.edu
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-203943-13602-okw2w42dCu@https.bugzilla.kernel.org/>
In-Reply-To: <bug-203943-13602@https.bugzilla.kernel.org/>
References: <bug-203943-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=203943

--- Comment #6 from Theodore Tso (tytso@mit.edu) ---
That's because the German translation is busted.   I've complained to the
German maintainer of the e2fsprogs messages file at the Translation Project,
but it hasn't been fixed yet.   See [1] for more details.

[1] https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=892173#10

It *should* have actually printed the inode number, and it does if you just use
the built-in English text.  In general, I *really* wish people would disable
the use of the translation when reporting bugs, because very often the use of
the translations add noise that make life harder for developers, and in this
case, it was losing information for you, the system administrator.

See the debugfs man page for more details, but to specify inode numbers to
debugfs, you need to surround the inode number with angle brackets.  Here are
some examples:

% debugfs /tmp/test.img
debugfs 1.45.2 (27-May-2019)
debugfs:  ls a
 12  (12) .    2  (12) ..    13  (988) motd   
debugfs:  stat /a/motd
Inode: 13   Type: regular    Mode:  0644   Flags: 0x80000
Generation: 0    Version: 0x00000000
User:     0   Group:     0   Size: 286
File ACL: 0
Links: 1   Blockcount: 2
Fragment:  Address: 0    Number: 0    Size: 0
ctime: 0x5d0d416e -- Fri Jun 21 16:43:26 2019
atime: 0x5d0d416e -- Fri Jun 21 16:43:26 2019
mtime: 0x5d0d416e -- Fri Jun 21 16:43:26 2019
Inode checksum: 0x0000857d
EXTENTS:
(0):20
debugfs:  stat <13>
Inode: 13   Type: regular    Mode:  0644   Flags: 0x80000
Generation: 0    Version: 0x00000000
User:     0   Group:     0   Size: 286
File ACL: 0
Links: 1   Blockcount: 2
Fragment:  Address: 0    Number: 0    Size: 0
ctime: 0x5d0d416e -- Fri Jun 21 16:43:26 2019
atime: 0x5d0d416e -- Fri Jun 21 16:43:26 2019
mtime: 0x5d0d416e -- Fri Jun 21 16:43:26 2019
Inode checksum: 0x0000857d
EXTENTS:
(0):20
debugfs:  ncheck 13
Inode   Pathname
13      /a/motd 
debugfs:  stat a
Inode: 12   Type: directory    Mode:  0755   Flags: 0x80000
Generation: 0    Version: 0x00000000
User:     0   Group:     0   Size: 1024
File ACL: 0
Links: 2   Blockcount: 2
Fragment:  Address: 0    Number: 0    Size: 0
ctime: 0x5d0d416b -- Fri Jun 21 16:43:23 2019
atime: 0x5d0d416b -- Fri Jun 21 16:43:23 2019
mtime: 0x5d0d416b -- Fri Jun 21 16:43:23 2019
Inode checksum: 0x000042d4
EXTENTS:
(0):18
debugfs:  block_dump 18
0000  0c00 0000 0c00 0102 2e00 0000 0200 0000  ................
0020  0c00 0202 2e2e 0000 0d00 0000 dc03 0401  ................
0040  6d6f 7464 0000 0000 0000 0000 0000 0000  motd............
0060  0000 0000 0000 0000 0000 0000 0000 0000  ................
*
1760  0000 0000 0000 0000 0c00 00de be4e 16e9  .............N..

debugfs:

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
