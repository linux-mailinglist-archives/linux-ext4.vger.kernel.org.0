Return-Path: <linux-ext4+bounces-12021-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B68E0C8180B
	for <lists+linux-ext4@lfdr.de>; Mon, 24 Nov 2025 17:13:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 60F514E5D40
	for <lists+linux-ext4@lfdr.de>; Mon, 24 Nov 2025 16:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F407314D28;
	Mon, 24 Nov 2025 16:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ixlCUve7"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49CE314D07
	for <linux-ext4@vger.kernel.org>; Mon, 24 Nov 2025 16:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764000807; cv=none; b=QNSlK0lHLrrkRX6QT++zJxWMyPIPSvXC4gbIBez8mIBFeCoqFhmKUPG4PD3CW21dOyz8awmAXhwksCUGX0D+ofyaq4yhy41XrAoXqAfB/CU/q88ujTuBgkGaqH3WguoKrNKWqqKm9EQ+wlB1/G83orxUCsiWIK3RLrHlVv9aSCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764000807; c=relaxed/simple;
	bh=G24ZugKlmNTi5pevzRjGeNrphfpIjbA7diW+79xW3KI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UArE2uydvqsApqU8rCu6eKGvcVnSAOvdi945QPKtMMqmP6EcHaKYoxdqdoBjQQoVHwkhT7FUUrKbntwslmJQe9VPi/FqRU3B+YoFBeCi8QYAUAby6FcsOFUfj48oTuM6HY0xg5prmza9RodcTFNoI3C+5iBZiefs5uQmBSiLG7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ixlCUve7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 69620C19422
	for <linux-ext4@vger.kernel.org>; Mon, 24 Nov 2025 16:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764000807;
	bh=G24ZugKlmNTi5pevzRjGeNrphfpIjbA7diW+79xW3KI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ixlCUve7vpxZNyndYLqNor3OBxjVicdqjdAzkGupJPJnUc7Eg8bdy3lgkaojl3RHn
	 z12Dz6Doir3V4MmXTbEna1onhzCc3wGUdUY1USWsetXIM97V0akPgfqC7ParvkrjLj
	 tgnHPOfryngRv3N6gIe+tYWoCIHFiiytujR4IWYemSOi97wk0OUU4UeauKjJ7rlfOI
	 bnZlrTdERJmP87HCpLizM1PoIReRh1R07+kvKWL2U4JVLhFlHgS7L/j/pJ+U9bOTu/
	 G+OcZxhhy1Zop8H9mux6Zh42G0kC844EnnFH8ErUXYYyI/fkg3SyVjpzqlvFnEeOZc
	 DDrSkpB2A8rcA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 5EB8BC41613; Mon, 24 Nov 2025 16:13:27 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 220594] Online defragmentation has broken in 6.16
Date: Mon, 24 Nov 2025 16:13:27 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: low
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-220594-13602-a5cboOdpR3@https.bugzilla.kernel.org/>
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

--- Comment #12 from Artem S. Tashkinov (aros@gmx.com) ---
(In reply to Theodore Tso from comment #11)
> So it's not that all files can't be defragged; just *some* files.  Is
> that correct?

That's correct.

>=20
> And when I ask whether or not it's reproducible, can you take a
> snapshot of your file system, and then remount the snapshot, and will
> the exact same file that failed before fails on the snapshot?

It still fails on the snapshot.

>=20
> And for the files that were failing, if you unmount the file system
> and remount it, can you then defrag the file in question?  If the

No. Tried that thrice.

> answer is yes, this is why bug reports of the form "Online
> defragmentation in 6.16 is broken" is not particularly useful.  And
> it's why I've not spent a lot of time on this bug.  We have
> defragmentation tests in fstests, and they are passing, and I've tried
> running defrag on the snapshot that you sent me, And It Works For Me.

It still doesn't with the Fedora's kernel (now running 6.17.8-200.fc42.x86_=
64).

> So a broad "it's broken" without any further data, when it most
> manifestly is not broken in my tests, means that if you really want it
> to be fixed, you're going to have to do more of the debugging.

I'd love to help however I cant to get it fixed.

>=20
> But now that we know that it's an EBUSY error, it sounds like it's
> some kind of transient thing, and that's why I'm not seeing it when I
> tried running it on your snapshot.
>=20
> For example, one of the places where you can get EBUSY in the MOVE_EXT
> ioctl is here:
>=20
>                 if (!filemap_release_folio(folio[0], 0) ||
>                     !filemap_release_folio(folio[1], 0)) {
>                         *err =3D -EBUSY;
>                         goto drop_data_sem;
>                 }
>=20
> ... and this ultimately calls ext4_release_folio:
>=20
> static bool ext4_release_folio(struct folio *folio, gfp_t wait)
> {
>       struct inode *inode =3D folio->mapping->host;
>       journal_t *journal =3D EXT4_JOURNAL(inode);
>=20
>       trace_ext4_release_folio(inode, folio);
>=20
>       /* Page has dirty journalled data -> cannot release */
>       if (folio_test_checked(folio))
>               return false;
>       if (journal)
>               return jbd2_journal_try_to_free_buffers(journal, folio);
>       else
>               return try_to_free_buffers(folio);
> }
>=20
> What this means is that if the file has pages which need to be written
> out to the final location on disk (e.g., if you are in data=3Djournal

Journalling is disabled on all my ext4 partitions.

> mode, and the modified file may have been written or scheduled to be
> written to the journal, but not *yet* to the final location on disk,
> or you are using delayed allocation and the file was just recently
> written, delayed allocation is enabled, and blocks get allocated but
> they haven't been written back yet) --- then the MOVE_EXT ioctl will
> return EBUSY.
>=20
> This is not new behaviour; we've always had this.  Now, 6.16 is when
> large folio support landed for ext4, and this can result in some
> really wonderful performance improvements.  This may have resulted in
> a change in how often recently written files might end up getting
> EBUSY when you try to defrag them --- but quite frankly, if this is a
> very tiny fraction of the files in your file system, and a subsequent
> defrag run will take care of them --- I'd probably think that is a
> fair tradeoff.

6.15 didn't have the issue.

subsequent defrag runs don't help. I've tried rebooting multiple times, tri=
ed
to defrag in single user mode (booted with `1`), with only systemd running =
and
journald disabled altogether, so only ~/.bash_history is opened for writing,
nothing else. No dirty buffers to speak of, `sync` does nothing as there's
nothing to flush.

>=20
> So... if you take a look at the files that failed trying call MOVE_EXT
> --- can you take a look at the timestamps and see if they are
> relatively recently written files?

I'll check it.

>=20
> Also, for future reference, if you had disclosed that this was only
> happening on a tiny percentage of all of the files in your file
> system, and if you checked to see if the specific small number of
> files (by percentage) that were failing could be defragged later, and
> checked the timestamps, that would have been really useful data which
> would have allowed you (and me) to waste a lot less time.
>=20
> Cheers,
>=20
>                                       - Ted

Thanks!

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

