Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 593813B8826
	for <lists+linux-ext4@lfdr.de>; Wed, 30 Jun 2021 20:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232358AbhF3SJW (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 30 Jun 2021 14:09:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:34176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229991AbhF3SJV (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 30 Jun 2021 14:09:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id A1BEB61469
        for <linux-ext4@vger.kernel.org>; Wed, 30 Jun 2021 18:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625076412;
        bh=VN2ZgW82z4VpdDYAbft5K2/ZjiFAaV0B67CIZgR/z/8=;
        h=From:To:Subject:Date:From;
        b=EBSPDlGI0UG+bwAtFmUZVFePlbcntPJ4GGxXKHCATg0N9PYEquVlLBrcgtwjxA/kK
         fBlLXpqm5GRlSQeRFqhTe4u2XqTaqgmaL1bexUWTVZwHiB9vaO+3hgJ472NpfAl/E+
         IVCv+QC+U7R+3nyo1xOgcp48A0e2Ten9NjNIs/9VVQF61hR1qkxn4hti1YdsJsBgjB
         2m492cB3NAY9GJKyeyEvCCa2nItQdoB2M3V1sPpMFfpPPzCBrGlP8TsNXWTaENsEez
         Vf37cmCskhr9FhBxXMX1Kkz5lLE+Jod7cVLJDkNzSlRV/5H7eX7s8Mm5EX+e0WaaTp
         T+i8fVwHK37Pg==
Received: by pdx-korg-bugzilla-2.web.codeaurora.org (Postfix, from userid 48)
        id 9556F612AD; Wed, 30 Jun 2021 18:06:52 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 213627] New: Fail to read block descriptors data of ext4
 filesystem
Date:   Wed, 30 Jun 2021 18:06:52 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: nipunasri.eerapu@arcserve.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression
Message-ID: <bug-213627-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D213627

            Bug ID: 213627
           Summary: Fail to read block descriptors data of ext4 filesystem
           Product: File System
           Version: 2.5
    Kernel Version: 5.3.x-5.4.x
          Hardware: x86-64
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: high
          Priority: P1
         Component: ext4
          Assignee: fs_ext4@kernel-bugs.osdl.org
          Reporter: nipunasri.eerapu@arcserve.com
        Regression: No

Our product takes backup of filesystems (ext2/3/4,xfs,btrfs) after taking t=
he
snapshot of the volume. We have our own drivers for taking snapshot.

After taking snapshot, we calculate block group count and group descriptors
blocks in Block group0 (group zero). From group descriptors, we read block
bitmap and inode bitmaps.

All this was working well till 5.0.x kernels  and from 5.3.x kernels, block
bitmap and inode bitmap values are getting garbage. It doesnot happen all t=
he
time.Everytime after reboot, it works fine.

Our driver simply bypasses read/write calls to system block driver, not sure
why data is corrupted.

Can you please help me what have been changed between 5.0.x and 5.3.x kerne=
ls
regarding ext,block driver.

We are not seeing this issue for xfs and btrfs filesystem.

We are suspecting something might have changed in ext2/3/4 and block driver=
 in
5.3.x kernels.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
