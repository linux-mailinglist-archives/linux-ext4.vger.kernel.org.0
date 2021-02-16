Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61D9C31D03F
	for <lists+linux-ext4@lfdr.de>; Tue, 16 Feb 2021 19:33:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbhBPSbB (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 16 Feb 2021 13:31:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:42842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229744AbhBPSa5 (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 16 Feb 2021 13:30:57 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 89A9064E28
        for <linux-ext4@vger.kernel.org>; Tue, 16 Feb 2021 18:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613500216;
        bh=04lRWFvA+k1YgA4vjTYJQa2Fp1TPHDe5O5jAit5WA0c=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=F3C5DZB6HiUQswLLe7nadwbQwKrP3xZDiJ7vEk9A/5P+L6Sz5jlAsK7sN//9UdnxY
         CBioHEol4R/7H6ZSErFqR2FQVI0rVX2r5gZPglDrxOj49+hVOn2O8adwU2kCaBdu3h
         ta82GeOft/vbNZNw/JtuK3LeYvkL3YH4AamAW5/AulZo9ot5CF8eudY8rTp2XGu/Bx
         Piv5O0+iU2Re16ElU+nEaHbnqziAfymNjTbVOjhctmQbv/YWymMEPjyInqzZcJcvF5
         cHmV+jIg1IyxtVI4Q3V2QxTOpUkxlwoJYrU2AsHOL8dz5E7uCE9Lcge01SBYT0xkFZ
         2CLjg6ZbesJzw==
Received: by pdx-korg-bugzilla-2.web.codeaurora.org (Postfix, from userid 48)
        id 7EBA9653C0; Tue, 16 Feb 2021 18:30:16 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 211733] ext4 file system unrecoverable corruption
Date:   Tue, 16 Feb 2021 18:30:16 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: tytso@mit.edu
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-211733-13602-9rb3WFWokp@https.bugzilla.kernel.org/>
In-Reply-To: <bug-211733-13602@https.bugzilla.kernel.org/>
References: <bug-211733-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D211733

Theodore Tso (tytso@mit.edu) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |tytso@mit.edu

--- Comment #1 from Theodore Tso (tytso@mit.edu) ---
The symptoms may be the same as a news article from 8 or 9 years ago, but t=
hat
particular bug was solved a *long* time ago.

Unfortunately, there are many different potential causes of data loss.  It
could be caused by bad partition tables, such that (for example) the Window=
s 7
partition overlaps (or Windows 7 thinks that) the partition overlaps with t=
he
Linux system.   It could be caused by hardware problems.   It could because=
d by
the user incorrectly using the GUI.  There's no way to tell based on the
complete lack of data in the bug report.

It's much like sending a doctor an e-mail complaining with a tinghtness of
chest and trouble breathing, but not giving the doctor any medical history,=
 no
ability for the doctor to give the patient a reading of an ECG, etc.

You're going to have to reproduce it, and do this with a large number of sm=
all
checks.   Try copying data from Windows 7 to Linux.  Check to see if the da=
ta
is there in Linux.  Try rebooting from Linux into Linux, and see if the dat=
a is
there.  Then try rebooting into Windows and do some things, recording exact=
ly
what you are doing, and then try rebooting back into Linux and check the
Documents folder.

Then (using a command line interface, so it's easier to capture the output =
and
report it to a bug tracker), you need to get a printout of the partition ta=
ble,
and/or the Logical Volume and Physical Volume layout if you are using LVM, =
and
also grab the kernel logs to see if there are any errors reported by the fi=
le
system or device drivers, etc.

If you don't know how to do this, it's much more likely that the problem is
user error, and my best suggestion is to find a local Linux user's group and
ask for help.   Those folks might ask lots of potentially insultning questi=
ons,
such as making sure that you were cleanly shutting down the system before
rebooting back from Linux to Windows, or before powering down the computer;=
 but
those sorts of questions tend to be less insulting when someone asks you in
person as opposed to via phone or e-mail tech support when people are oblig=
ated
to ask the "are you sure the computer is plugged in" kind of basic question=
s.

Good luck!

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
