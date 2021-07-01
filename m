Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B698C3B8B2F
	for <lists+linux-ext4@lfdr.de>; Thu,  1 Jul 2021 02:24:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237828AbhGAA0e (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 30 Jun 2021 20:26:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:54422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236734AbhGAA0d (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 30 Jun 2021 20:26:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 44DE761452
        for <linux-ext4@vger.kernel.org>; Thu,  1 Jul 2021 00:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625099044;
        bh=qGjmhDctBZGIFbOtIEBW2NamNRcEt+/mXssFSFIWmeE=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=nEhXQRLqSiDTpxH/Ues/+nhQb8AsYiV3Ry1Fobn3WzZjQQrRyRsRQmt5KQ426Kzoe
         fR8AhbMlBDd8t5JqGajnHRkMhqD03k9BmglACviiXkMOsWx4g1AbRBkgvasyaaWfQL
         2evlTzxQjDeQVDfu8895wqLrp1iCI7FUqNhfEAP3STh6zx9H/G7r2GG4qcsjQkjxuE
         sZBob/4a0gtgZW220DWwC2wBHXJgvl+BYIngDlPYUckkcCsyVHXpdBckg0Lih5WBll
         iBG9PKmY13UGpPoNKFtKfMgVhjUe5widQgmrUj5nStGzYHHcxsQVpdZsBfQ58k0kBf
         q1HdSeBrb8fzA==
Received: by pdx-korg-bugzilla-2.web.codeaurora.org (Postfix, from userid 48)
        id 41004612AD; Thu,  1 Jul 2021 00:24:04 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 213627] Fail to read block descriptors data of ext4 filesystem
Date:   Thu, 01 Jul 2021 00:24:04 +0000
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
Message-ID: <bug-213627-13602-6yfWtwuOft@https.bugzilla.kernel.org/>
In-Reply-To: <bug-213627-13602@https.bugzilla.kernel.org/>
References: <bug-213627-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D213627

Theodore Tso (tytso@mit.edu) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |tytso@mit.edu

--- Comment #2 from Theodore Tso (tytso@mit.edu) ---
I'm guessing that it's your snapshot driver which is buggy.   Certainly, if=
 you
take a snapshot using LVM, things work fine.  e.g.:

# mke2fs -t ext4 /dev/cwcc-wg/scratch
# mount -t ext4 /dev/cwcc-wg/scratch /mnt
# cp -r /etc /mnt
# lvcreate --snapshot -n snap -L 5G cwcc-wg/scratch
# e2fsck -fn /dev/cwcc-wg/snap

You can see everything that has changed via a command such as "git log
v5.0..v5.3 block fs/ext4".    In terms of what might be a relevant change,
without understanding how your snapshot driver works, your guess is probably
going to be better than mine --- since you have access to your snapshot dri=
ver
and know how it works.

When you say that your driver "bypasses read/write calls to system block
driver", I'm not 100% sure how it works, but at a guess, some things I'd lo=
ok
at are: (a) ext4 uses the buffer cache to read/write metadata blocks.   May=
be
your driver isn't properly intercepting buffer cache reads/writes?    (b) E=
xt4
at mount time reads the superblock via the buffer cache with the block size=
 set
to 1k; and then after it determines the block size of the file system (say,
4k), it switches the block size of the buffer cache to the block size of the
file system.    Ext[234] has been doing this for decades, but depending on =
how
your snapshot driver is working, perhaps there is some change in the how the
buffer cache works which is confusing your driver.

Sorry I can't help more.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
