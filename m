Return-Path: <linux-ext4+bounces-12014-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AD4F6C7EFC9
	for <lists+linux-ext4@lfdr.de>; Mon, 24 Nov 2025 06:16:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 537F4346211
	for <lists+linux-ext4@lfdr.de>; Mon, 24 Nov 2025 05:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B0CA221265;
	Mon, 24 Nov 2025 05:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="bVhxvM5s"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AEB2632
	for <linux-ext4@vger.kernel.org>; Mon, 24 Nov 2025 05:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763961370; cv=none; b=PgRPaP6JzFoKhoXvz5YL6mrwHpoxX0IzjXwfzfuHws8L9YYJLsGnko4vTLK7jIkoud/tjxplJDCT9gLhf8MVdBcmlFeJVfhj7BZ6KpnFxgOGpG//290PZOn2ZohYVZiYXpFfhmRajkkPtMaYH5rbTX67ZTqOunpX5ikyBhJ3sOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763961370; c=relaxed/simple;
	bh=JuhI8zutonQk+2jYhvpGTaoEW45lT1z+fDhR5ru1Az0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rJRt9EAfdB2x6aCf7nH+/CiM3nh6+o00XmRqsyG8keBl0LA0sEQJXld6TYCxDzWh5nvTcJeiIa0tRy7sPuwLdXntAVQFeQ384EythHWjnXdgHVvZApqvqF3WgSoFWeSf/ZNY50bOOfE6Onbqr6FAkHgDe0LXb/i41WHkJzDIAlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=bVhxvM5s; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from macsyma.thunk.org (c-73-9-28-129.hsd1.il.comcast.net [73.9.28.129])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 5AO5FkJI001224
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Nov 2025 00:15:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1763961348; bh=5u3Jr1vbgqW1IxAJ4OVwDPfv/7w1BkadI3jFSMCQzfQ=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=bVhxvM5sHa9mMm2m7wTgHZqbMUvt++Rhs8N56ULOoNoKHlTY7urCO7W/E+rWoToZ8
	 wO8v4Sqe6MRiyEKZWIT1uWhFdJma4xdSFse6MGyfWvHIYY7ugzxFtMIw4vJvcvIVmS
	 dgdedQLlpoUhGfSzvO9obMpYN7d6XDB4fL/8yuR4bcFpi+uZtr4zL2a94G7CX+r5sB
	 Eg6eNJts3Lqkm0C9RUcZ3SGpSGOmCDUF88UrXE2dvFOmSYrkyLW14xi0+QWNpiCopD
	 oAwX7uu7eXrhpsCTsZmDCMCs0WPAEsiAgvkpDtmggpdPn8hp3jnWIWK/JneXD67AYA
	 bKV+MQMNoYi/g==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id B247B4C6E652; Sun, 23 Nov 2025 23:15:45 -0600 (CST)
Date: Sun, 23 Nov 2025 23:15:45 -0600
From: "Theodore Tso" <tytso@mit.edu>
To: bugzilla-daemon@kernel.org
Cc: linux-ext4@vger.kernel.org
Subject: Re: [Bug 220594] Online defragmentation has broken in 6.16
Message-ID: <20251124051545.GE13687@macsyma-3.local>
References: <bug-220594-13602@https.bugzilla.kernel.org/>
 <bug-220594-13602-T0C29jzqNj@https.bugzilla.kernel.org/>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bug-220594-13602-T0C29jzqNj@https.bugzilla.kernel.org/>

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
                        *err = -EBUSY;
                        goto drop_data_sem;
                }

... and this ultimately calls ext4_release_folio:

static bool ext4_release_folio(struct folio *folio, gfp_t wait)
{
	struct inode *inode = folio->mapping->host;
	journal_t *journal = EXT4_JOURNAL(inode);

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
out to the final location on disk (e.g., if you are in data=journal
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

