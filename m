Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77B4B12E7F9
	for <lists+linux-ext4@lfdr.de>; Thu,  2 Jan 2020 16:16:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728634AbgABPQ0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-ext4@lfdr.de>); Thu, 2 Jan 2020 10:16:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:41126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728561AbgABPQ0 (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 2 Jan 2020 10:16:26 -0500
From:   bugzilla-daemon@bugzilla.kernel.org
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-ext4@vger.kernel.org
Subject: [Bug 206061] Poor NVME SSD support, EXT4 re-mounted
Date:   Thu, 02 Jan 2020 15:16:25 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: low
X-Bugzilla-Who: tytso@mit.edu
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-206061-13602-4TmUTg69sz@https.bugzilla.kernel.org/>
In-Reply-To: <bug-206061-13602@https.bugzilla.kernel.org/>
References: <bug-206061-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=206061

Theodore Tso (tytso@mit.edu) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |tytso@mit.edu

--- Comment #1 from Theodore Tso (tytso@mit.edu) ---
These kernel messages (modulo the timestamps) are normal.   The root file
system is mounted read-only, and after the file system is checked, the file
system is mounted read-write.

What is not supposed to be happening is the file system getting checked after
every boot.   I would need to look at the fsck logs to be sure, but the most
likely cause is that your motherboard's real time clock is not correctly set,
or the battery for the real time clock is dead.

Normally, when the kernel is booted, it sets the system clock from the
motherboard's real-time clock, and then the file system is mounted, it is
checked, and then it is remounted read-write.   After that, the network is set
up, and the time gets set from an internet time server.  The motherboard's real
time clock should be set after the time is set from the internet time server
(to correct it from clock drift), and most init scripts will also set the
hardware clock from the system clock at shutdown.  And then the real-time clock
will be maintained even while the power is off using the battery on the
motherboard.  (It's normally a watch battery, such as a CR2032.)

To work around something going wrong with the above, please try adding to
/etc/e2fsck.conf --- or creating /etc/e2fsck.conf if it does not exist --- the
following lines

[options]
    broken_system_clock = true

More information about this can be found in the e2fsck.conf man page.

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
