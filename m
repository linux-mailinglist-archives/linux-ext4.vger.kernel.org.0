Return-Path: <linux-ext4+bounces-12013-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B19E9C7EFC6
	for <lists+linux-ext4@lfdr.de>; Mon, 24 Nov 2025 06:16:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 28A4C346195
	for <lists+linux-ext4@lfdr.de>; Mon, 24 Nov 2025 05:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DE5C221265;
	Mon, 24 Nov 2025 05:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VkKP1rcd"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2E4632
	for <linux-ext4@vger.kernel.org>; Mon, 24 Nov 2025 05:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763961357; cv=none; b=lurwIbZ9G2J5qAX19zHVjFCJ8+36KyU+em++EvrqisQEB4uuPeXfBh8+hkCBgxZ3QUF692Fi0Wv8SALhjt6yCEyTdHfwsAHeB0kupkPBVruIUTqLNpUyL0FR5MM0sXf0Gwk2xUsAX7W3Vh0AY2dc4NrUUB2zl0Zwu/N3Ir9d+go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763961357; c=relaxed/simple;
	bh=UPqESuE0c+HX2VVgCkVeHaopCa5VBCQV/2Lk3GfW7yU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cmhbXgI7vj62X5eBlfozmg3XnHUsBFrENXLEaD6jnRJJL4BsRuFn0keDzDltZu3XKGaql0ka7RQ3VwXX5TArgJI26trtWZxUlXxRnpr5/MuYTJAb7/5Pfk0d4ufoMWlgIf8f4LUHSsIsstV542acQUtlj7oBt8eD4mRe0FamKgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VkKP1rcd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 85AD4C116C6
	for <linux-ext4@vger.kernel.org>; Mon, 24 Nov 2025 05:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763961357;
	bh=UPqESuE0c+HX2VVgCkVeHaopCa5VBCQV/2Lk3GfW7yU=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=VkKP1rcdAmUUF+zLWGvAzlPDbuP7+QPeQ+BOKJ2RQxnGgCbv09Z/YzLsp2QTMW66r
	 5bF9MBMWjCGQ13zLoCQ7/Ecf/74FWZOUVFszfPBBUbgb0dDqU8NQo+TymiUzbZIudP
	 xrdLqyeMOHy9InvbryMe3pD4Dw424oKXC2b2FiyBhgU0l4iR8b/aVUMtujUute0X3H
	 JwjLTNUVPaqz/Lqh0n/dUHDlyAqrwj/u6l8eTBxApeS/jVofGPVBq2wdMUF/eHZxi2
	 dLQqN3nJ9j6VlefTstILxApeUSLTMJY907M8jRbwJaAmU28xYIMWFJi3ig1qwCyRgt
	 CaokoBn5t5zqg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 7690AC53BC5; Mon, 24 Nov 2025 05:15:57 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 220594] Online defragmentation has broken in 6.16
Date: Mon, 24 Nov 2025 05:15:57 +0000
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
Message-ID: <bug-220594-13602-ebvxZxFkrn@https.bugzilla.kernel.org/>
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

--- Comment #11 from Theodore Tso (tytso@mit.edu) ---
So it's not that all files can't be defragged; just *some* files.  Is
that correct?

And when I ask whether or not it's reproducible, can you take a
snapshot of your file system, and then remount the snapshot, and will
the exact same file that failed before fails on the snapshot?

And for the files that were failing, if you unmount the file system
and remount it, can you then defrag the file in question?  If the
answer is yes, this is why bug reports of the form "Online
defragmentation in 6.16 is broken" is not particularly useful.  And
it's why I've not spent a lot of time on this bug.  We have
defragmentation tests in fstests, and they are passing, and I've tried
running defrag on the snapshot that you sent me, And It Works For Me.
So a broad "it's broken" without any further data, when it most
manifestly is not broken in my tests, means that if you really want it
to be fixed, you're going to have to do more of the debugging.

But now that we know that it's an EBUSY error, it sounds like it's
some kind of transient thing, and that's why I'm not seeing it when I
tried running it on your snapshot.

For example, one of the places where you can get EBUSY in the MOVE_EXT
ioctl is here:

                if (!filemap_release_folio(folio[0], 0) ||
                    !filemap_release_folio(folio[1], 0)) {
                        *err =3D -EBUSY;
                        goto drop_data_sem;
                }

... and this ultimately calls ext4_release_folio:

static bool ext4_release_folio(struct folio *folio, gfp_t wait)
{
        struct inode *inode =3D folio->mapping->host;
        journal_t *journal =3D EXT4_JOURNAL(inode);

        trace_ext4_release_folio(inode, folio);

        /* Page has dirty journalled data -> cannot release */
        if (folio_test_checked(folio))
                return false;
        if (journal)
                return jbd2_journal_try_to_free_buffers(journal, folio);
        else
                return try_to_free_buffers(folio);
}

What this means is that if the file has pages which need to be written
out to the final location on disk (e.g., if you are in data=3Djournal
mode, and the modified file may have been written or scheduled to be
written to the journal, but not *yet* to the final location on disk,
or you are using delayed allocation and the file was just recently
written, delayed allocation is enabled, and blocks get allocated but
they haven't been written back yet) --- then the MOVE_EXT ioctl will
return EBUSY.

This is not new behaviour; we've always had this.  Now, 6.16 is when
large folio support landed for ext4, and this can result in some
really wonderful performance improvements.  This may have resulted in
a change in how often recently written files might end up getting
EBUSY when you try to defrag them --- but quite frankly, if this is a
very tiny fraction of the files in your file system, and a subsequent
defrag run will take care of them --- I'd probably think that is a
fair tradeoff.

So... if you take a look at the files that failed trying call MOVE_EXT
--- can you take a look at the timestamps and see if they are
relatively recently written files?

Also, for future reference, if you had disclosed that this was only
happening on a tiny percentage of all of the files in your file
system, and if you checked to see if the specific small number of
files (by percentage) that were failing could be defragged later, and
checked the timestamps, that would have been really useful data which
would have allowed you (and me) to waste a lot less time.

Cheers,

                                        - Ted

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

