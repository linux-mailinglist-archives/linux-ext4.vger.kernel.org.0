Return-Path: <linux-ext4+bounces-2400-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29C908C0A30
	for <lists+linux-ext4@lfdr.de>; Thu,  9 May 2024 05:35:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D22C0284797
	for <lists+linux-ext4@lfdr.de>; Thu,  9 May 2024 03:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 642C1147C6B;
	Thu,  9 May 2024 03:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lGn2vwV7"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE8FD26D
	for <linux-ext4@vger.kernel.org>; Thu,  9 May 2024 03:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715225748; cv=none; b=q/Yii5IqdEzRk9vYQtwsEd79J+qkyE8jHqoP75gqrqCLOJLbdDG/PFy4BLHmHFpudVFw7DR3V8AtzcXaqf+jWkFi0WnBv1WsYoNjPOwfVHa5kE1F6HYnKh2/nopCBbhQAN0ErDR1JxfT5xHrGS6wseSqSLJl/zrk7RYPr2xUt1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715225748; c=relaxed/simple;
	bh=HtmJRVvcl6V9zxl/Ou6jG0dWHGdjloz286t95PB9hI4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GVv34OYKhRNRRj62kjNTbGyESiYX1GK0A7d5GGgIliOur4RnAgQXsl1kP3UBAnN/i87mKRk+zkepTND7TfvUh7TWYIMdtasoKmjcP3vesBtKeoSDGahTol3KZPVcWii47e1VaRKta+v+vvbK5ORoFO8VrAYs3IGWRGr+X3OHkB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lGn2vwV7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 736B1C2BD11
	for <linux-ext4@vger.kernel.org>; Thu,  9 May 2024 03:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715225748;
	bh=HtmJRVvcl6V9zxl/Ou6jG0dWHGdjloz286t95PB9hI4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=lGn2vwV7rx0rISkWLKS6YlOKwluiHtmQZcyBpD4iz83anjaTDzpVcQlfcgm83jEWy
	 Irnuc+6JlpBVEl4z9kuiTAWPlNQh6WcAbCMctz2KYpA+UuYkY8e4IJSDLq8F84G2Qh
	 ST/FFleJDkhBTxkeaGw/Q1rgxiYgjh3rTA1uRvfVeCO+rVkqmbWIwKAEKZZAPAIl5q
	 apCO83n7qRQSRbed4qKOjzjef44M7RzwBPz64C1LSgpsqr7raCR84AwsbVsGvfhSJd
	 5S3du/sUdbYRe2HGa8J/K9xv9T6b1bSxczJoBEFB2xhqjf1RmE7nHLLL3fzrJRVzod
	 1ql96dw9imRpg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 5DB85C53B6F; Thu,  9 May 2024 03:35:48 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 218820] The empty file occupies incorrect blocks
Date: Thu, 09 May 2024 03:35:48 +0000
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
Message-ID: <bug-218820-13602-J5dupHZgBt@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218820-13602@https.bugzilla.kernel.org/>
References: <bug-218820-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218820

--- Comment #1 from Theodore Tso (tytso@mit.edu) ---
On Wed, May 08, 2024 at 01:33:56PM +0000, bugzilla-daemon@kernel.org wrote:
>=20
> The following is the triggering script:
> ```
> dd if=3D/dev/zero of=3Dext4-0.img bs=3D1M count=3D120
> mkfs.ext4 ext4-0.img
> g++ -static reproduce.c
> losetup /dev/loop0 ext4-0.img
> mkdir /root/mnt
> ./a.out
> stat /root/mnt/a
> ```
>=20
> After run the script, you will get the following outputs:
> ```
>   File: /root/mnt/a
>   Size: 0               Blocks: 82         IO Block: 1024   regular empty
>   file
> Device: 700h/1792d      Inode: 12          Links: 1
> Access: (0755/-rwxr-xr-x)  Uid: (    0/    root)   Gid: (    0/    root)
> Context: system_u:object_r:unlabeled_t:s0
> Access: 2024-05-08 11:47:48.000000000 +0000
> Modify: 2024-05-08 11:47:48.000000000 +0000
> Change: 2024-05-08 11:47:48.000000000 +0000
>  Birth: -
> ```

Thanks for the bug report.  What the reproducer script is doing is
opening a file for writing, and then remounting the file system to
disable delayhed allocations.  It then writes 40k to the file, and
then truncates the file, and close it.

The reproducer script leaves the file system mounted; if you unmount
the file system, the kernel will issue a warning message:

EXT4-fs (loop0): Inode 13 (0000000082f8ff6c): i_reserved_data_blocks (40) n=
ot
cleared!

... and then if you examine the on-disk image, you'll see that the
i_blocks field is correct.


The root cause is that when the file is open, the address_operations
which is instaniated is one which is designed for delayed allocation.
So when 40k is written to the file, although we haven't allocated the
space yet, we *will* allocate the space, so we update in-memory
i_blocks to reflect the to-be-allocated disk space (although we don't
update the on-disk i_blocks until the allocation actually takes place,
so if we crash, the file system stays consistent).

However, some of the *other* logic is done based on whether the
delayed allocation flag is set in the struct super (as opposed to the
address_operations in the struct inode at the time that file is
opened).  This includes what happens when we truncate the file, where
in the nodelalloc case, the in-memory and on-disk i_blocks are in
sync, and when the blocks are delallocated, the i_blocks field is
dropped.  But since the blocks weren't actually allocated because the
file descriptor was in delalloc mode, there was nothing to
delallocate, so the in-memory i_blocks stayed elevanted.

There are a number ways of fixing this.  The simplest is to simply not
allow the delayed allocation mode to be changed on a remount.  Since
in the long term, once we fix some performance for some specialized
use case which has caused people to want to disable delayed
allocation, this is the one that probably makes the most sense.

The two other approaches involve a lot more complexity.  The first
alternate approach is to iterate over all open files, and resolve any
pending delayed allocations, and then update the address_operations to
use ext4_aops instead of ext4_da_aops, while avoiding the races
involving writes happening while we are trying to do the remount.
Yelch.

The second alternate approach is to treat the delayed allocation
status on a per-inode basis, with a per-inode flag indicating whether
delayed allocation is active, so that the truncate logic stays
consistent with the ext4_da_ops active on file descriptors associated
with the file.  But this gets super messy since subsequent file opens
on the inode also need to use the same delayed allocation mode until
the last file descriptor associated with the inode is closed.  Double
Yelch.

So preventing the "mount -o remount,nodelalloc" in the reproducer
program is how we'll address this issue.

                                        - Ted

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

