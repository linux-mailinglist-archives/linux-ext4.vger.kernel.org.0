Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9D6443F99
	for <lists+linux-ext4@lfdr.de>; Wed,  3 Nov 2021 10:49:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231435AbhKCJwE (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 3 Nov 2021 05:52:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:60080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230097AbhKCJwE (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 3 Nov 2021 05:52:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id DF72F60720
        for <linux-ext4@vger.kernel.org>; Wed,  3 Nov 2021 09:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635932967;
        bh=z0ssZdseCZyJqZ5f/I2amlhxshgSLI0q+kzqJLSQwVE=;
        h=From:To:Subject:Date:From;
        b=mHCKanqKL0hVyPiLQ4hHgVeTWBsrw4petY6oHIJ+d3JiXEIb8iJ5TAxawmHGc7QRp
         x9/Ry+9hDrj+urONNOEpckzKMDRupOLFj5kaE4nbGAaWPpOIGhV/fR2lxP/6j6dJTy
         RrZx577a0yIBkTZId6f/Ac00zQ22iLpxUDWLuoGP69Luk29qK9uFDdesIynxch0vyC
         5tGL5NPL0UtJhsiC4LDq9VC9BI/PeKMaD9I7z1XVGWDMJONAlQBefIJ2sMwCh2wDDX
         uOwY63bpPZ0raaM/MhW8mTehQUFmYZT7+JZ1Qh5ZqCpn6OVL0RvYNKyyP2Q/fCl9yp
         mPbyfpN939g6A==
Received: by pdx-korg-bugzilla-2.web.codeaurora.org (Postfix, from userid 48)
        id DC25E60FF3; Wed,  3 Nov 2021 09:49:27 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 214927] New: re-mount read-write (mount -oremount,rw) of
 read-only filesystem rejected with EROFS, but block device is nor read-only
Date:   Wed, 03 Nov 2021 09:49:27 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo fs_ext3@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext3
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: Ulrich.Windl@rz.uni-regensburg.de
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext3@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression
Message-ID: <bug-214927-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D214927

            Bug ID: 214927
           Summary: re-mount read-write (mount -oremount,rw) of read-only
                    filesystem rejected with EROFS, but block device is
                    nor read-only
           Product: File System
           Version: 2.5
    Kernel Version: 4.12.14-122.91-default (SLES12 SP5)
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: ext3
          Assignee: fs_ext3@kernel-bugs.osdl.org
          Reporter: Ulrich.Windl@rz.uni-regensburg.de
        Regression: No

I think there's a kernel or filesystem bug related to ext3:
We run a SLES12 SP5 Xen PVM that gets its system disk from a sparse file
located on a SLES15 SP2 Xen host using OCFS2 (the host is a node in a pacem=
aker
cluster).

The OCFS2 filesystem became full or almost full, and thus the ext3
filesystem(s) experienced write errors, remounting to read-only.
So far, so good, but:
The errors behavior of ext 3 was set to "continue", so I wonder why it had =
been
set to read-only at all.
Next, after having extended the OCFS2 filesystem size, any remount-attempt
fails with:

mount: /: cannot remount /dev/... read-write, is write-protected.

I strace-d the mount command and the mount syscall is returning EROFS
(Read-only filesystem).
However in the VM configuration on the host the disk is marked read-write, =
the
disk in the VM is flagged read-write, also the VG, LVs, etc. I checked the
/sys/block/*/ro, too: It's all "0".

I also did an fsck (which succeeded), but still after that the error is the
same.
Interestingly I noticed that after a *failed* remount attempt, the filesyst=
em
(that is mounted read-only) got the error flag being set again.

The only conclusion I have is that there is at least one kernel bug regardi=
ng
the read-only status of the block device.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
