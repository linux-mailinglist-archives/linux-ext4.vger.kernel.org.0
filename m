Return-Path: <linux-ext4+bounces-8686-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47159AEC444
	for <lists+linux-ext4@lfdr.de>; Sat, 28 Jun 2025 04:48:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B25573BACE8
	for <lists+linux-ext4@lfdr.de>; Sat, 28 Jun 2025 02:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2254199FB0;
	Sat, 28 Jun 2025 02:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nz2TS++L"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F9242AA6
	for <linux-ext4@vger.kernel.org>; Sat, 28 Jun 2025 02:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751078923; cv=none; b=tdmP+mXSGB87K9buZs5b20iKxdrX8hIdMZl37Jk5Juf/pwpX8IFTwdtqEsfHJW1s4KzkCE2jwPf0efzp9XACXo7FVH02VB/xpz363XKdJwzgDduDM73ZYhu7DEnZReBBHu5D+Oisz9L36kzkatJIOewxPbiy/0XDJaIT/4rC0ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751078923; c=relaxed/simple;
	bh=RNUdPoFWCHrDvOuGMmNiDKFC1du7VhNBIA5IrlWZfM0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tMkFKENbu4jLGwKzIJxAY7WI91Gh9Qirv8lHuwki38jWVb21csbrT/OJWzrJfwxTYsY2+rv9j1wDW/4l1RWcxQykgWhLok/Z689MKt3nRvHkHD8M4Zzdwa2McKqpr3pVpG0JYN+x58bQDZoPOrEqsZ0ub4XUJLnbWbypBYSAgPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nz2TS++L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0F626C4CEF0
	for <linux-ext4@vger.kernel.org>; Sat, 28 Jun 2025 02:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751078923;
	bh=RNUdPoFWCHrDvOuGMmNiDKFC1du7VhNBIA5IrlWZfM0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=nz2TS++LjzSG+MBZWxCKWqIWz8MOsmSHLghwF50gLLCgyQnw4D/YdXZ0MjNI5pCF7
	 5AfDlpsmcKMMkiVe/vn1ZlhvuPjl2fYnc8sbXnVH4O+P6KJ7A1fU3exZVUnYE+1jDd
	 NdxrnP4f/h6AwIoxcd86oM/eFxjw4VZShHjmjyCP3E8BMDqJpZzdXiK2xSbgJMwl52
	 wub9v+SLAxdXFyx55fmoBGXIuXNiFTb4lKEF83njHMCPDos49XcgjrrttqkxgiW0Zv
	 2kY9t5jWIbrycwrP9x+Uml/cwrHM+7hSDso1ekDqVLDuwfGhvbADW8m94vEn+kx42a
	 tuhdMMwGVlM+w==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id EF0C1C41614; Sat, 28 Jun 2025 02:48:42 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 220288] A typo Leads to loss of all data on disk
Date: Sat, 28 Jun 2025 02:48:42 +0000
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
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-220288-13602-W848vhM7oV@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220288-13602@https.bugzilla.kernel.org/>
References: <bug-220288-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220288

--- Comment #1 from Theodore Tso (tytso@mit.edu) ---
I don't see how that happened.  /dev/sdc has a partition table at the
beginning of the disk.  That partition table contains the definition
of /dev/sdc1.

So if you ran "fsck.ext4 /dev/sdc" instead of "fsck.ext4 /dev/sdc1",
you should have gotten something like this:

   root@xfstests:~# fsck.ext4 /dev/sdb
   e2fsck 1.47.2-rc1 (28-Nov-2024)
   ext2fs_open2: Bad magic number in super-block
   fsck.ext4: Superblock invalid, trying backup blocks...
   fsck.ext4: Bad magic number in super-block while trying to open /dev/sdb

   The superblock could not be read or does not describe a valid ext2/ext3/=
ext4
   filesystem.  If the device is valid and it really contains an ext2/ext3/=
ext4
   filesystem (and not swap or ufs or something else), then the superblock
   is corrupt, and you might try running e2fsck with an alternate superbloc=
k:
       e2fsck -b 8193 <device>
    or
       e2fsck -b 32768 <device>

   Found a gpt partition table in /dev/sdb

In any case, fsck.ext4 will not make any changes unless you give it
permission by answering "yes".  For example (do not try this at home,
kids):

    root@xfstests:~# debugfs  -w -R "clri <2>" /dev/sdb1 ; debugfs -w -R "s=
sv
state 2" /dev/sdb1
    debugfs 1.47.2-rc1 (28-Nov-2024)
    debugfs 1.47.2-rc1 (28-Nov-2024)
    root@xfstests:~# fsck.ext4 /dev/sdb1
    e2fsck 1.47.2-rc1 (28-Nov-2024)
    /dev/sdb1 contains a file system with errors, check forced.
    Pass 1: Checking inodes, blocks, and sizes
    Root inode is not a directory.  Clear<y>? yes
    Pass 2: Checking directory structure
    Entry '..' in <2>/<11> (11) has deleted/unused inode 2.  Clear<y>? yes
    Pass 3: Checking directory connectivity
    Root inode not allocated.  Allocate<y>? yes
    Unconnected directory inode 11 (was in /)
    Connect to /lost+found<y>? yes
    /lost+found not found.  Create<y>? yes
    Pass 3A: Optimizing directories
    Pass 4: Checking reference counts
    Inode 11 ref count is 3, should be 2.  Fix<y>? yes
    Pass 5: Checking group summary information

    /dev/sdb1: ***** FILE SYSTEM WAS MODIFIED *****
    /dev/sdb1: 13/655360 files (0.0% non-contiguous), 67263/2620928 blocks

See how fsck.ext4 asks for permission before it makes any change to
the filesystem?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

