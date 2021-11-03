Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A4E6444472
	for <lists+linux-ext4@lfdr.de>; Wed,  3 Nov 2021 16:13:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231571AbhKCPQM (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 3 Nov 2021 11:16:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:53528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231175AbhKCPQM (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 3 Nov 2021 11:16:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 9DEFC6109F
        for <linux-ext4@vger.kernel.org>; Wed,  3 Nov 2021 15:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635952415;
        bh=XLoJ2GeDt/RL1WxPRv1Q96xF82QVp6iKfNakXR135D8=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=meYqkSfHZ7HyNd5C8ySECfEHgweyMnd4blquNy969jm8z+CtAt1wonCsxg2bn6CIk
         RZaaXSUeSL0r3HimUDl+uxV4/ptk76DZrD4WzKWt9aODw1iDa7sMKORnGEEmMOkw06
         WqaDbbaG3PQFcRw6EKMD5kGettL1Lnp/+YoiyyZ/+IeH+KRw2qSmUR1btUh6OH7eCY
         7WVWIaFeWkr3uC04vcBu92aQ2s/xI+38o3tMl2M+vvRhYUikpNht+0dURhPJxHin3/
         Zh9ZagzjppB1ME0game5JAPPepTb5W95RNGhMxDr2iKhHdAQ+aN9DSJzWa1hj7o63N
         FTwUg7sB8EUAw==
Received: by pdx-korg-bugzilla-2.web.codeaurora.org (Postfix, from userid 48)
        id 92D7260F41; Wed,  3 Nov 2021 15:13:35 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 214927] re-mount read-write (mount -oremount,rw) of read-only
 filesystem rejected with EROFS, but block device is not read-only
Date:   Wed, 03 Nov 2021 15:13:35 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext3@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext3
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: tytso@mit.edu
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext3@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-214927-13602-0kDc4tAxpa@https.bugzilla.kernel.org/>
In-Reply-To: <bug-214927-13602@https.bugzilla.kernel.org/>
References: <bug-214927-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D214927

Theodore Tso (tytso@mit.edu) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |tytso@mit.edu

--- Comment #3 from Theodore Tso (tytso@mit.edu) ---
In the case when there is a I/O error while trying to write to the journal,
there's nothing that can be done safely other than to force the file system=
 to
be read-only.

When there is a file system which has aborted or otherwise has run into err=
ors,
you have to unmount the file system before it is safe to remount it read/wr=
ite.
 In fact, the ideal procedure is to umount the file system, run fsck, and t=
hen
remount the file system.

In the case of the root file system, you can't unmount the file system, so =
it
is acceptable to remount it read/only (if that hasn't been done automatical=
ly),
run fsck, and then reboot.

The reason for this because while the file system is mounted, there may be =
file
system corruption which was fixed by fsck, but for which some corruption (f=
or
example, a corrupted refcount) is still present in memory.  So it is not sa=
fe
to take a mounted root file system, and modify it using fsck, and then remo=
unt
it read/write.   You have to reboot so it can be freshly mounted on the reb=
oot.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
