Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52923326B0B
	for <lists+linux-ext4@lfdr.de>; Sat, 27 Feb 2021 02:37:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbhB0Bac (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 26 Feb 2021 20:30:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:40942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229618AbhB0Baa (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 26 Feb 2021 20:30:30 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 116EF64EDB
        for <linux-ext4@vger.kernel.org>; Sat, 27 Feb 2021 01:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614389390;
        bh=zQ8A4qe8TBcy/HViy7nPjvYA/xdlsP4rvUKRVF46tJU=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=NFgt8mLojOyvt0CoQlsrW9gde6yuluJYog2nmxfZC4Di35F5SsmK3hZZRYVQiE2+t
         83L1mV38C4AUzKrc7HvJRlf3gDIWDVfmpFlYDYr7YUDTzrKBYy8b397OLchy7LhRKt
         LsGLG+s9uoybDliWtGwdmmXm6NtMXY1111t2eolUngOC+yomeVCGJIxDt8JgbSReK0
         hun6mxGRI7O27qLj1T20JE3RIfNQU+tlGEE3BrcPePypeKCZGAjDyi2aehv1Fgx+Lg
         1gUbQuaLaCS3FHtxc0bfqIqkCX+ci2NYfV+YO4BbVjsRrh/XfM5wKpLf1B2jfaXlk3
         id5GypY9AtPpQ==
Received: by pdx-korg-bugzilla-2.web.codeaurora.org (Postfix, from userid 48)
        id 034EC652E8; Sat, 27 Feb 2021 01:29:50 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 211971] Incorrect fix by e2fsck for blocks_count corruption
Date:   Sat, 27 Feb 2021 01:29:49 +0000
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
Message-ID: <bug-211971-13602-gbjhQYQXM1@https.bugzilla.kernel.org/>
In-Reply-To: <bug-211971-13602@https.bugzilla.kernel.org/>
References: <bug-211971-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D211971

--- Comment #2 from Theodore Tso (tytso@mit.edu) ---
On Fri, Feb 26, 2021 at 04:58:23PM -0800, Amy Parker wrote:
> Can you replicate this on modern 5.4 from kernel.org? -generic kernels
> are from Canonical and are sometimes broken compared to upstream. If
> you can't replicate this on mainline, you'll need to contact
> Canonical. We can't do anything if the problem only persists on
> distribution kernels.

This has nothing to do with the kernel.  What the user is complaining
about is that e2fsck trusts the blocks count field in the superblock
as to be a source of truth.  If that field is artificially changed to
be a smaller value, e2fsck will assume the file system size indicated
by that changed size.

That's an intentional design choice of e2fsck.  Given that with modern
ext4 file systems, we have metadata checksums, if the superblock has
been accidentally corrupted, the checksum will fail, and then e2fsck
will try using the backup superblock instead.

For older file systems that don't have metadata checksums enabled, we
could check to see if certain "fundamental constants" in the primary
superblock is different from the secondary superblock, but...

> > debugfs -w image
> > debugfs:  ssv blocks_count 4000
> > debugfs:  q

This will update the blocks_count in the primary and all secondary
backups.  So that's not going to really help the user.  Effectively,
the complaint is "I pointed the gun at my foot, and pulled the
triggered, and now my foot hurts!"

> > # Expected that e2fsck would fix the blocks count corruption instead of
> > changing other fields (e.g.,free blocks_count)

The problem is that e2fsck can't really determine that the blocks
count field has been corrupted.  We could warn the user if the
blocks_count is smaller than the reported size of the device,
but.... that's actually something that can happen in real life, and
it's not necessarily a file system "corruption", but rather an
intentional choice by the system administrator.  If we were to give a
warning, or worse, assume that blocks count should be adjusted to be
the size of the deivce, we'd be getting complaints from users who
deliberately chose to set the file system size to be something smaller
than the block device.

So this is a case of e2fsck is working as intended.

Cheers,

                                        - Ted

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
