Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C130031ACBC
	for <lists+linux-ext4@lfdr.de>; Sat, 13 Feb 2021 16:55:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbhBMPz5 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 13 Feb 2021 10:55:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:52546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229625AbhBMPzz (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Sat, 13 Feb 2021 10:55:55 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 42A6464DEB
        for <linux-ext4@vger.kernel.org>; Sat, 13 Feb 2021 15:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613231712;
        bh=nPy1DUQ7aqNP1/UldWE4RnpTVEypKGYg+44CnybVv1c=;
        h=From:To:Subject:Date:From;
        b=bC99zWUUnE6NqQS3y07tR1oU69/+O1vKy4NUgxRm4KY5euEVkUJqzjiDqNKXxUC+Y
         FsQazB2LRFl/7BOqaHigSH21EZF1CCuYICO7BX3DViZ1oaEBBtWNfq2nCdq1/0xh4x
         ahm/r4MSBNggmfpdj4Q7XHJPeHUEpjskkpNUv0eID4rPinO7LBHcgX/gvVnxnyD0d3
         SrxOLJuD19L6lrZLSz+CuY/9Dv1mHipmBkdoqXiaU6AKQotzp3PIXeSA3AX2tM2JRl
         EeEWvJ0M0a9j4XXyjlp/s72NT9U8O7T54VMGoGEqaoK6rJsSRvOEap9SFXJl+JtwM9
         Tk69RARKv7T0A==
Received: by pdx-korg-bugzilla-2.web.codeaurora.org (Postfix, from userid 48)
        id 3091365360; Sat, 13 Feb 2021 15:55:12 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 211733] New: ext4 file system unrecoverable corruption
Date:   Sat, 13 Feb 2021 15:55:11 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: martrw@yahoo.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression
Message-ID: <bug-211733-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D211733

            Bug ID: 211733
           Summary: ext4 file system unrecoverable corruption
           Product: File System
           Version: 2.5
    Kernel Version: 5.4.0-65-generic
          Hardware: i386
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: high
          Priority: P1
         Component: ext4
          Assignee: fs_ext4@kernel-bugs.osdl.org
          Reporter: martrw@yahoo.com
        Regression: No

Kubuntu 20.04, two week old installation
500 SATA HDD, 50GiB / partition/ 180GiB /home partition
Dual boot with Win7 on 50GiB partition

Observation:
Was switching between the Win7 OS and Linux with multiple reboots in short
spans of time(<5min).  From Linux OS using Dolphin I moved ~5MB document fi=
les
from Win7 partition to Linux /home/xxx/Documents directory and rebooted sys=
tem
to return to Win7.  Made changes in Win7 as needed and booted back into Lin=
ux.=20
I noticed the entire Documents directory was missing, about 50GiB files.=20
Immediately shut down system and booted up Linux on duplicate drive contain=
ing
image from about two weeks prior.  Made read only image of /home directory =
from
corrupted drive and placed on external 1 GiB backup drive.

Using R-Linux, extundelete, debugfs no trace of the Documents directory can=
 be
located on the image or the original /home directory.  I can see files I
intentionally deleted during normal operations for over a week prior.

fsck, smartctl indicate no disk issues.

I have not tried to reproduce this issue.

This event seems very similar to the one discuss in this link but I have not
been able to locate that particular bug.

https://www.itnews.com.au/news/stable-linux-kernels-hit-by-serious-file-sys=
tem-bug-320709

I entered bug report on the bugs.kde.org bug tracker(432762) but was told t=
hat
the issue is lower level than the Dolphin gui which I was using.

Apologies if this is a duplicate, but I could not find a similar issue on t=
his
tracker.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
