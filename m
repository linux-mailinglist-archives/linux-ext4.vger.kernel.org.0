Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E302F326AEA
	for <lists+linux-ext4@lfdr.de>; Sat, 27 Feb 2021 02:00:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbhB0A7S (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 26 Feb 2021 19:59:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:38110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229622AbhB0A7R (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 26 Feb 2021 19:59:17 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 98D1B64DBD
        for <linux-ext4@vger.kernel.org>; Sat, 27 Feb 2021 00:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614387516;
        bh=XWkdb7OnQjJ5bAore/z0t+WNU4mgPaeCzMlQRIr/1lU=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=OCD5JzVD83rx49C/MvKNIriWQjDCchgiO/t8Ik/4l4tdby98D0cV7FcfrjlPmPGdB
         K9PMwcVZyrvPWEMwr/XLWORJ0MDw8g+NYDg6F0GbqCWRCag9FPKE8scIahx6OwvxLQ
         hG//dxt2bbpKbAwj2XZiPXA1iKOUqy6Xd8UFougtu8TVO9Z/CDiZKQDd3fBd7mUWot
         S02UnZC3FdB5CXdJJTRJASNTS7hrEGLJhhCNJkfZM5OUEEc63U+30lZoucHYY7xw3n
         XdBv5Ehf5dSeNvu47Gi6LlHr7jaDlHDSmtfFaAqjWjVVBQAT6pNNYe1JcxF3mMY4j4
         jBDcgL4fLzOMw==
Received: by pdx-korg-bugzilla-2.web.codeaurora.org (Postfix, from userid 48)
        id 7E26E652E8; Sat, 27 Feb 2021 00:58:36 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 211971] Incorrect fix by e2fsck for blocks_count corruption
Date:   Sat, 27 Feb 2021 00:58:36 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: enbyamy@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-211971-13602-r6IDKRIC6B@https.bugzilla.kernel.org/>
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

--- Comment #1 from Amy (enbyamy@gmail.com) ---
Can you replicate this on modern 5.4 from kernel.org? -generic kernels
are from Canonical and are sometimes broken compared to upstream. If
you can't replicate this on mainline, you'll need to contact
Canonical. We can't do anything if the problem only persists on
distribution kernels.

On Fri, Feb 26, 2021 at 1:41 PM <bugzilla-daemon@bugzilla.kernel.org> wrote:
>
> https://bugzilla.kernel.org/show_bug.cgi?id=3D211971
>
>             Bug ID: 211971
>            Summary: Incorrect fix by e2fsck for blocks_count corruption
>            Product: File System
>            Version: 2.5
>     Kernel Version: Linux 5.4.0-65-generic
>           Hardware: x86-64
>                 OS: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: normal
>           Priority: P1
>          Component: ext4
>           Assignee: fs_ext4@kernel-bugs.osdl.org
>           Reporter: tmahmud@iastate.edu
>         Regression: No
>
> Created attachment 295497
>   --> https://bugzilla.kernel.org/attachment.cgi?id=3D295497&action=3Dedit
> log files from mke2fs, dumpe2fs and e2fsck
>
> For an ext4 file system image with only one superblock, if the blocks_cou=
nt
> field in superblock is corrupted, e2fsck fixed it incorrectly. In the fix=
ed
> image, the corrupted blocks_count is unchanged and other fields (e.g., fr=
ee
> blocks count) are changed accordingly.
> This issue also occurs in images with multiple superblocks too. For examp=
le,
> For an ext4 image with primary and backup superblock (backup superblocks =
are
> not located in default locations, e.g., it is located on 513rd block), if=
 the
> blocks_count field in superblock is corrupted, e2fsck fixed it incorrectl=
y.
> In
> the fixed image, the corrupted blocks_count is unchanged and other fields
> (e.g., free blocks count) are changed accordingly.
>
> e2fsprogs_version_used: e2fsprogs 1.45.6 (20-Mar-2020)
> The commands that I ran to recreate the scenario are:
> For image with only one superblock:
>
> dd if=3D/dev/zero bs=3D1024 count=3D8193 of=3D/home/hdd/image
> mke2fs -b 1024 image 8193
> debugfs -w image
> debugfs:  ssv blocks_count 4000
> debugfs:  q
> e2fsck -yf image
> e2fsck -yf image
>
> # e2fsck fixes the blocks_count corruption in correctly
> # In the clean image the blocks_count was 8193, in the fixed image the
> blocks_count is 4000
> #The second run of e2fsck is consistent with the first run, it doesn't fix
> anything, but blocks_count is still 4000
> # Expected that e2fsck would fix the blocks count corruption instead of
> changing other fields (e.g.,free blocks_count)
>
> For image with multiple superblocks:
> dd if=3D/dev/zero bs=3D1024 count=3D8193 of=3D/home/hdd/image1
> mke2fs -b 1024 -g 512 image1 8193
> debugfs -w image1
> debugfs:  ssv blocks_count 4000
> debugfs:  q
> e2fsck -yf image1
> e2fsck -yf image1
>
> # e2fsck fixes the blocks_count corruption in correctly
> # In the clean image the blocks_count was 8193, in the fixed image the
> blocks_count is 4000
> # The second run of e2fsck is consistent with the first run, it doesn't f=
ix
> anything, but blocks_count is still 4000
> #There were 16 block groups in the clean image, but there are only 7 block
> groups in the fixed image
> # Expected that e2fsck would fix the blocks count corruption instead of
> changing other fields (e.g.,free blocks_count) and removing the block gro=
ups.
>
> I attached the images and also the logs from mke2fs, dumpe2fs and e2fsck.
>
> --
> You may reply to this email to add a comment.
>
> You are receiving this mail because:
> You are watching the assignee of the bug.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
