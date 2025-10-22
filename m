Return-Path: <linux-ext4+bounces-11013-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DAF4BF99E7
	for <lists+linux-ext4@lfdr.de>; Wed, 22 Oct 2025 03:36:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DDA694E88E8
	for <lists+linux-ext4@lfdr.de>; Wed, 22 Oct 2025 01:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52A881D5CEA;
	Wed, 22 Oct 2025 01:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="itq05RMg"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D121BD9F0
	for <linux-ext4@vger.kernel.org>; Wed, 22 Oct 2025 01:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761096979; cv=none; b=X2oIiRjcKf3NdpCJwkv6KiQ3WURM42oA93WsjikAekL38sApIQz0OqAWeklD9zpGbihB+kKvjYC0xIU8/oAfm0/i4ymnVx0m3wNKNXbnZ4sCKvTdLOQ3ak4KVGZAigF+Pb0GcEYr2rv3xE3vAahOUyymeZf79Xh3s1KRkDK9YZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761096979; c=relaxed/simple;
	bh=Jc+9P/gMEm7X/KHUY3llKvAleAjuvTsG04bTNVQ8ozU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rt2BIKqk0sZQi2hINZrENmfoCcsneXrFWvBwqK/CxTueLrDXjqCYmAlT0WsOqI0+TIQS6vqJQOYkUm4Y3BsyPCste+UID3eMkxY7DtPKkQQndRZ1+ddxgN2wVxIIbkCZRdQAQpLbU3TYWRgm5GFfLSyxqVaPf3OaIfpXfNY6W3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=itq05RMg; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from macsyma.thunk.org ([104.133.198.215])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 59M1a5PW026369
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Oct 2025 21:36:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1761096968; bh=MG9msmjp1OUrWD4gKmJhdsLYExQNIlWDwnsK+lxIJnY=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=itq05RMg7kD49hy3Y/66Rej7GMAUrLDdxF2pC7SkhNDUEgku3eTzGvLxmG6h4cgcA
	 KM7beWfP2rzkq8CpDA6lAijPY5YoENEnGPa2Aqvk3Dpn4N3/2YaOgZH+6g33JcimQ6
	 UaXjF1jheoMMLm3X0esvxlu4pNRHCItPbRxXMEo93xzTnX/91dkEFlETfVNUtrMzB+
	 MXkI1o+z0MV0T2We1crrcMhhrlzzWwPB9/vXoz0X49zAhVEVjInBwj65J8NzEBw/WG
	 iO7sLIUPJN+Rn5Ybhq2LjkbjXdldCxIn6cRGor7yQsK3owT1CTZKBmCASTMUSi46M8
	 Y6iaiIFqXsKdw==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id 2A70C47A8604; Tue, 21 Oct 2025 18:36:05 -0700 (PDT)
Date: Tue, 21 Oct 2025 18:36:05 -0700
From: "Theodore Tso" <tytso@mit.edu>
To: Dave Dykstra <dwd@cern.ch>
Cc: "Darrick J. Wong" <djwong@kernel.org>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH] fuse2fs: updates for message reporting journal is not
 supported
Message-ID: <20251022013605.GC6859@macsyma-3.local>
References: <20251016200903.3508-1-dave.dykstra@cern.ch>
 <20251017191800.GF6170@frogsfrogsfrogs>
 <aPKilSNCQRW9c6rl@cern.ch>
 <20251017232521.GI6170@frogsfrogsfrogs>
 <aPgKP-wUhhfwqKke@cern.ch>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPgKP-wUhhfwqKke@cern.ch>

On Tue, Oct 21, 2025 at 05:33:35PM -0500, Dave Dykstra wrote:
> I understood that, but does the filesystem actually write metadata after
> the journal is recovered, such that if the fuse2fs process dies without
> a clean unmount there might be file corruption or data loss?  That is,
> in the case of ro when there is write access, does the warning message
> really apply?

As an example, if file system inconsistencies is detected by the
kernel, it will update various fields in the superblock to indicate
that file system is corrupted, as well as when and where the
corruption is detected:

	__le32	s_error_count;		/* number of fs errors */
	__le32	s_first_error_time;	/* first time an error happened */
	__le32	s_first_error_ino;	/* inode involved in first error */
	__le64	s_first_error_block;	/* block involved of first error */
	__u8	s_first_error_func[32] __nonstring;	/* function where the error happened */
	__le32	s_first_error_line;	/* line number where error happened */
	__le32	s_last_error_time;	/* most recent time of an error */
	__le32	s_last_error_ino;	/* inode involved in last error */
	__le32	s_last_error_line;	/* line number where error happened */
	__le64	s_last_error_block;	/* block involved of last error */
	__u8	s_last_error_func[32] __nonstring;	/* function where the error happened */

Since this is a singleton 4k update the superblock, we don't really
need to worry about problems caused by a non-atomic update of this
metadata.  And similarly, with the journal replay, if we get
interrupted while doing the journal replay, the replay is idempotent,
so we can just restart the journal replay from scratch.

As far as the warning message, if you mean the warning message printed
by fuse2fs indicating that it doen't have journal support, and so if
you are modifying the file system and the system or fuse2fs crashes,
there may be file system corruption and/or data loss, that only needs
to be printed when mounting read-write.  It should be safe to skip
printing that warning message if the file system is mounted with -o
ro, based on the resoning abovce.

> > Are you running fstests QA on these patches before you send them out?
> 
> I had not heard of them, and do not see them documented anywhere in
> e2fsprogs, so I don't know how I was supposed to have known they were
> needed.  Ideally there would be an automated CI test suite.  The patches
> have passed the github CI checks (which don't show up in the standard
> pull request place, but I found them in my own repo's Actions tab).
> 
> Are you talking about the tests at https://github.com/btrfs/fstests?
> If so, it looks like there are a ton of options.  Is there a standard
> way to run them with fuse2fs?

This is btrfs's local form of https://github.com/btrfs/fstests of
xfstests (or fstests, as it is now sometimes called).  We do have an
automated way of running them for ext4 kernel code.   See [1][2]

[1] https://thunk.org/gce-xfstests
[2] https://github.com/tytso/xfstests-bld/blob/master/Documentation/kvm-quickstart.md

Darrick has been doing a lot of really good work to run fuse2fs using
fstests/xfstests.  There isn't a turnkey way of running fuse2fs using
this test suite yet.  It's on my todo list to add an easy way to do
this via kvm-xfstests/gce-xfstests but I'm probably not going to get
to it until sometime next year.  If someone would like to give it a
try --- patches would be gratefully accepted.

						- Ted
						

