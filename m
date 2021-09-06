Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58EC74017FB
	for <lists+linux-ext4@lfdr.de>; Mon,  6 Sep 2021 10:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241099AbhIFI0q (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 6 Sep 2021 04:26:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:44008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240975AbhIFI0o (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 6 Sep 2021 04:26:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 1E05960041
        for <linux-ext4@vger.kernel.org>; Mon,  6 Sep 2021 08:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630916740;
        bh=Kt5DY37xJN4dNTViCOdItjnvb2x+0IvHWdUle+K/UP8=;
        h=From:To:Subject:Date:From;
        b=YVya7HnDIF1BcwSzFAZepOZfPpIBsVlXeceH+yYkH+CE9juRgUEPE+vY2f3zY/l8M
         Ujd8TmtnOx9LWNKnHrT8H7UgYRkvRMwwPiiPYZ+b/11WByj7sk6Jb72U3bVe7uVUEB
         K1+Sszl4WJScLP3GrheeWRwi7dS9CZZGxKoyVY9Jq2EcrzLTqAHFY+GTLo1Zh8PdX0
         yYgvQQglqyKd59yD7RHGCkVYurq2uqVGSOt4Zd/V0g0mgVL4yWA20rTzzY3MQHp9/R
         kA9kW55bci7ZNJ2cJ/nCCdCDbanRJkuY6vtoF+vs6yUnIa64j7FOiTX45aabX0MIVm
         8iKrH9MOxxQSg==
Received: by pdx-korg-bugzilla-2.web.codeaurora.org (Postfix, from userid 48)
        id 1244660F90; Mon,  6 Sep 2021 08:25:40 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 214327] New: Cant't shutdown or reboot: loop messages
 "ext4_writepages: jbd2_start: err -30"
Date:   Mon, 06 Sep 2021 08:25:39 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: antdev66@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression attachments.created
Message-ID: <bug-214327-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D214327

            Bug ID: 214327
           Summary: Cant't shutdown or reboot: loop messages
                    "ext4_writepages: jbd2_start: err -30"
           Product: File System
           Version: 2.5
    Kernel Version: 5.14.1
          Hardware: x86-64
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: ext4
          Assignee: fs_ext4@kernel-bugs.osdl.org
          Reporter: antdev66@gmail.com
        Regression: No

Created attachment 298677
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D298677&action=3Dedit
reboot/shutdown phase

Hello,
I have my workflow on Debian/Sid, with kernel compiled by
https://www.kernel.org/, currently at version 5.14.1, on asus x555ln notebo=
ok.

The problem occurs when the external USB 3 harddisk is disconnected from
itself: in some cases it is no longer reconnected and if I try to do "sync"
from console, this command appears freezed.

If I reboot, at the end the system log shows that it has reached the
"Rebooting" phase but remains in loops on the message indicated above (see
image file).

When this happens, the system should recognize that the harddisk is no long=
er
available or stalled, to interrupt the write of the cache and terminate the
reboot or shutdown phase.

Thanks,
Antonio


-- DETAILS --

dmesg:

scsi host4: uas
scsi 4:0:0:0: Direct-Access     ASMT     2115             0    PQ: 0 ANSI: 6
sd 4:0:0:0: Attached scsi generic sg0 type 0
sd 4:0:0:0: [sda] 1953525168 512-byte logical blocks: (1.00 TB/932 GiB)
sd 4:0:0:0: [sda] Write Protect is off
sd 4:0:0:0: [sda] Mode Sense: 43 00 00 00
sd 4:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support
DPO or FUA
sd 4:0:0:0: [sda] Optimal transfer size 33553920 bytes
 sda: sda1
sd 4:0:0:0: [sda] Attached SCSI disk
usb 3-1: USB disconnect, device number 8
xhci_hcd 0000:00:14.0: WARN Set TR Deq Ptr cmd failed due to incorrect slot=
 or
ep state.
sd 4:0:0:0: [sda] tag#28 uas_eh_abort_handler 0 uas-tag 5 inflight: CMD IN=
=20
sd 4:0:0:0: [sda] tag#28 CDB: Read(10) 28 00 00 00 01 08 00 00 f8 00

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
