Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 053241CE056
	for <lists+linux-ext4@lfdr.de>; Mon, 11 May 2020 18:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729815AbgEKQYu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-ext4@lfdr.de>); Mon, 11 May 2020 12:24:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:35406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729463AbgEKQYu (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 11 May 2020 12:24:50 -0400
From:   bugzilla-daemon@bugzilla.kernel.org
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-ext4@vger.kernel.org
Subject: [Bug 207635] EXT4-fs error (device sda3): ext4_lookup:1701: inode
 #...: comm find: casefold flag without casefold feature; EXT4-fs (sda3):
 Remounting filesystem read-only
Date:   Mon, 11 May 2020 16:24:49 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
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
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-207635-13602-nVlNElDZFn@https.bugzilla.kernel.org/>
In-Reply-To: <bug-207635-13602@https.bugzilla.kernel.org/>
References: <bug-207635-13602@https.bugzilla.kernel.org/>
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

--- Comment #4 from Joerg M. Sigle (joerg.sigle@jsigle.com) ---
Hi Eric - thanks for your quick & helpful response.

Your explanation sounds plausible; now I also understand why the problem was
persistent:

The e2fsck of my distribution was 1.44. If it is too old for these problems,
setting the fs to ro and marking it for an fsck on next reboot simply could not
achieve anything.

Me manually overwriting the default kernel version in grub.cfg with 5.3.15, was
also short lived: because grub.cfg gets rewritten during various apt updates.
This is why the problem kept coming back even when I did not /knowingly/ switch
back to a more recent kernel...

Now I got the current master e2fsck from github - thank you tytso.
This may hopefully have found and fixed the problem:

e2fsck 1.46-WIP (20-Mar-2020)
Pass 1: Checking inodes, blocks, and sizes
Inode 4244276 has encrypt flag but no encryption extended attribute.
Clear flag<y>? yes
Inode 4253945 has the casefold flag set but is not a directory. Clear flag<y>?
yes
Inode 4253945 has encrypt flag but no encryption extended attribute.
Clear flag<y>? yes
Pass 2: Checking directorry structure
Pass 3: Checking directorry connectivity
Pass 4: Checking reference counts
Pass 5: Checking group summary information

/dev/sda3: ***** FILE SYSTEM WAS MODIFIED *****
/dev/sda3: ***** REBOOT SYSTEM *****
...

(The last mentioned inode is the same that caused the error message in the
beginning of this thread.)

Kind regards, Joerg

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
