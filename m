Return-Path: <linux-ext4+bounces-12022-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BA78AC81984
	for <lists+linux-ext4@lfdr.de>; Mon, 24 Nov 2025 17:35:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E99224E6A85
	for <lists+linux-ext4@lfdr.de>; Mon, 24 Nov 2025 16:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E1861A285;
	Mon, 24 Nov 2025 16:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rkcbpele"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FDE122A4FC
	for <linux-ext4@vger.kernel.org>; Mon, 24 Nov 2025 16:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764002004; cv=none; b=I6YSFU2MPag+7NZPLWXGN0JB8YnKRTZUKJoUpj7PU9M7Y0D/qS1vgZevIzZHsglPiuJ99cGG5WajWsThhhHaNiZ5eSVpfLgUn8t0qRWgF8vsLIbzs+Nn2YUQqdAWwUWYU3L04kKQKmypSjXIK0MFWGzpSbTnynzeT0Ykz7j1X/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764002004; c=relaxed/simple;
	bh=JHTZ18mfj25ucyRZdAE9G7LT2RgarVyZiOwTz5LfXrQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gCW6aY0hRKwdQiZn2OkyvmAsf60HL1cmtdNAO106keNvUD5tQTR6O7zsvilCLy4L5b09xGglyE8m7uRIw41oHJOc0jbPGA8huuEISY0pJPFfMaaPCQ9ak3SFQNqjxQ2igYU1jm9OKfwCo9FIQhssGcL1VMormrlckJUQlxIXefs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rkcbpele; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9A993C19421
	for <linux-ext4@vger.kernel.org>; Mon, 24 Nov 2025 16:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764002003;
	bh=JHTZ18mfj25ucyRZdAE9G7LT2RgarVyZiOwTz5LfXrQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=RkcbpeleW3ov+hIVjB3/VuTEZzrF+zy+MQrlUahEyLvXezBp9Xa5eQ9MzRahilsnl
	 nbNK4ErMXfhDrcDDIeTvf6bY94f7hEU75Cc4Y3PhD1MDl6rteHNme7ZJIBWhlRoItB
	 TI5P3I7+Ai3KBv4wfI89B5YMlUUJOAedZe81nfnf87bCHSwra0oGfCr/yGZW/18MIi
	 QWEUpX+LNI5MjHmBVA41IifjlbayB0HPErOarvz0dSXOJyq6+aUWUcGkBsNIDN+uwb
	 vcJvx7zCBUUMRJXfc4FPFS7eKnhftte5GfisXmJaNEmhhc9Z9coBrdtg91JOHkZ/70
	 3BbUI+NKB/b2A==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 91043C53BC5; Mon, 24 Nov 2025 16:33:23 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 220594] Online defragmentation has broken in 6.16
Date: Mon, 24 Nov 2025 16:33:23 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: low
X-Bugzilla-Who: tytso@mit.edu
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-220594-13602-Z3beIa2CkE@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220594-13602@https.bugzilla.kernel.org/>
References: <bug-220594-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

https://bugzilla.kernel.org/show_bug.cgi?id=3D220594

--- Comment #13 from Theodore Tso (tytso@mit.edu) ---
On Mon, Nov 24, 2025 at 04:13:27PM +0000, bugzilla-daemon@kernel.org wrote:
> > And for the files that were failing, if you unmount the file system
> > and remount it, can you then defrag the file in question?  If the
>=20
> No. Tried that thrice.

Can you try that again, and verify using strace that you get the same
EBUSY error (as opposed to some other error) after unmounting and
remounting the file system?  At this point, I don't want to take
*anything* for granted.

Given that past attempts where you've sent me a metadata-only e2image
dump, I haven't been able to reproduce it, are you willing to build an
upstream kernel (as opposed to a Fedora kernel), and demonstrate that
it reproduces on an upstream kernel?  If so, would you be willing to
run an upstream kernel with some printk debugging added so we can see
what is going on --- since again, I still haven't been able to
reprdouce it on my systems.

> > What this means is that if the file has pages which need to be written
> > out to the final location on disk (e.g., if you are in data=3Djournal
>=20
> Journalling is disabled on all my ext4 partitions.

So you are running a file system with ^has_journal?  Can you send me a
copy dumpe2fs -h on that file system?

Something else to do.  For those files for which e2defrag is failing
reliably after an unmount/remount, are you reproducing the failure by
running e4defrag on just that one file, or by iterating over the
entire file system?  If it reproduces reliably where you try
defragging just that one file, can you try using debugfs's "stat"
command and see what might be different on that file versus some file
for which e4defrag on just that one file *does* work?

e.g.:

debugfs /dev/hdXX
debugfs:  stat groups
Inode: 177   Type: regular    Mode:  0755   Flags: 0x80000
Generation: 0    Version: 0x00000000:00000000
User:     0   Group:     0   Project:     0   Size: 43432
File ACL: 0
Links: 1   Blockcount: 88
Fragment:  Address: 0    Number: 0    Size: 0
 ctime: 0x6916c804:00000000 -- Fri Nov 14 01:11:16 2025
 atime: 0x6916c879:00000000 -- Fri Nov 14 01:13:13 2025
 mtime: 0x684062bd:00000000 -- Wed Jun  4 11:14:05 2025
crtime: 0x6924883d:00000000 -- Mon Nov 24 11:30:53 2025
Size of extra inode fields: 32
Inode checksum: 0x2e204798
EXTENTS:
(0-10):9368-9378

Finally, I'm curious --- if it's only just a few files out of hundreds
of thousands of files, why do you *care*?  You seem to be emphatic
about calling online defragmentation *broken* and seem outraged that
no one else seems to be discussing or working this issue.  Why is this
a high priority issue for you?

Thanks,

                                        - Ted

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

