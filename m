Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07A6D4A99C1
	for <lists+linux-ext4@lfdr.de>; Fri,  4 Feb 2022 14:13:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352144AbiBDNNx (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 4 Feb 2022 08:13:53 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:48992 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350186AbiBDNNw (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 4 Feb 2022 08:13:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 090F961BD5
        for <linux-ext4@vger.kernel.org>; Fri,  4 Feb 2022 13:13:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 63347C340F0
        for <linux-ext4@vger.kernel.org>; Fri,  4 Feb 2022 13:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643980431;
        bh=KE5ffrADFOY4iWxyE0pZ2Rxya4e+hwxVVFgiXO+eHvo=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=MlVY4jupGMRf2AblyVIKfV6sAhQlVqTqzR8B2xa2gFiutjXgFzn8f9ZpSMLnEjkza
         zVToDVXxcqebhO6EAjdeYETD5x/yuEeihKT/EriuEibrsIB/c0N+TLYQ5UUFgnegA1
         EZnCWjxsAjOe4ifpAiyrLQ+XjpdtSIJ+JJYUttVb2lBHWitpC4z3FLwiI6aBkmSX7V
         WCPyYktdevucC6H1zcC6JRMObvAhTjMBBCEYSVGGwgFfsLevc+n1Fk7my1POTeX+GT
         676XtOs1k0A80cPfC98gzgA37VC0XZnVB9ydS8aSclIwMLeGVu/U4XIzPEoV2D+Ezw
         9dH33D/Z+jHWQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 4E800C05FD5; Fri,  4 Feb 2022 13:13:51 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 89621] EXT4-fs error (device dm-1):
 ext4_mb_release_inode_pa:3773: group 24089, free 34, pa_free 32
Date:   Fri, 04 Feb 2022 13:13:50 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: kernel.org-115@groovy-skills.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-89621-13602-hp2LAAAyxY@https.bugzilla.kernel.org/>
In-Reply-To: <bug-89621-13602@https.bugzilla.kernel.org/>
References: <bug-89621-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D89621

GSI (kernel.org-115@groovy-skills.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |kernel.org-115@groovy-skill
                   |                            |s.com

--- Comment #20 from GSI (kernel.org-115@groovy-skills.com) ---
This is on a HP ProLiant DL380 G7 with HP Smart Array P410 controller with 8
disks configured as RAID-6.

S.M.A.R.T. reports the disks as healthy.

The server has been running for roughly ten months before this issue occured
the 1st of this month.
fsck did some repairs. Two days later, 3rd, the issue occured again.

What is the meaning of the suffix -8 as reported by
https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git/tree/fs/jbd2=
/journal.c#n2422
for j_devname?

Regardless of actual device, all bug reports appear to have that -8 in comm=
on.
Examples:


"Aborting journal on device sda3-8."
https://askubuntu.com/questions/595024/suddenly-read-only-file-system-ext4

"Aborting journal on device dm-2-8."
https://bugzilla.kernel.org/show_bug.cgi?id=3D102731

"Aborting journal on device sda2:8."
https://bbs.archlinux.org/viewtopic.php?id=3D70077

"Aborting journal on device vda1-8."
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1423672

"Aborting journal on device dm-1-8."
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1423672/comments/26

"Aborting journal on device dm-9-8."
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1423672/comments/28

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
