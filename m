Return-Path: <linux-ext4+bounces-11022-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB474BFEBCD
	for <lists+linux-ext4@lfdr.de>; Thu, 23 Oct 2025 02:22:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7883118C64E8
	for <lists+linux-ext4@lfdr.de>; Thu, 23 Oct 2025 00:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B23E155CB3;
	Thu, 23 Oct 2025 00:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HoU2c57I"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C0D2F85B
	for <linux-ext4@vger.kernel.org>; Thu, 23 Oct 2025 00:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761178915; cv=none; b=Czk3M/XEvLYETb7ZOzBKtSazuQ8zBCsakbBoJaKVBWUsT/to9HKdxUwiGce8GFsMZDdAjBwmoW3tBSZ3mt7cv7ogqR661kBfsNdERv0/FZ7nWt3SuXamjecr3RjAp7zC2Uqtzg3At4zmKYPO8BPX2TbIbfL0+xTo0S1iJn785BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761178915; c=relaxed/simple;
	bh=G9bNz4VJ823w9m6icPHR6Cl+YfsTOnmiJLFec+mR54I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BFYGDUKEU0MEy/27/CMVQYi2xFBORBYTadxHC2NFVEys3X22RcEZrJXVqavxtKunPl1nsBYLZ5ii4lDyYZgq2myoLQNGM+5MbVaSK2x0ah723CTditPA8bETJs9t35C/XRksoZCXCVFUm4AbRdyeFJFvltFSNnYInO7GUTitggY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HoU2c57I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BDDFC4CEE7;
	Thu, 23 Oct 2025 00:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761178915;
	bh=G9bNz4VJ823w9m6icPHR6Cl+YfsTOnmiJLFec+mR54I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HoU2c57Ie0nXik22jVoe4sqxz0TEC8Xyqayg55QosHWlI52o1Zt10JO9coJVxNFyT
	 nc4WrMkI6U9nAzqwZpmG/Gm0QbCwQVDmSATwZaVMx0KKghn0wztcTvbPAggm1EY+td
	 QdZi5OL95tJ+iZ312P828gF4YR+/Z8LPDX7V5McGGEszk9qjWQGofKF8QLMZh+USAk
	 U1fKOpuhyDmwAX5MS9BF4LsQQs6BnsPlmimAHFYu2R4c4P2CnH7QC+BLMDtnavJ5uR
	 8ICFQv6v4mFuyzgY1vhgG3aFRFE+3YN/sBGqWTEo8izNt3W67NM1buFMSIWuovH3Xf
	 HxRS3+oBxIgbg==
Date: Wed, 22 Oct 2025 17:21:54 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Theodore Tso <tytso@mit.edu>
Cc: Dave Dykstra <dwd@cern.ch>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH] fuse2fs: updates for message reporting journal is not
 supported
Message-ID: <20251023002154.GQ6170@frogsfrogsfrogs>
References: <20251016200903.3508-1-dave.dykstra@cern.ch>
 <20251017191800.GF6170@frogsfrogsfrogs>
 <aPKilSNCQRW9c6rl@cern.ch>
 <20251017232521.GI6170@frogsfrogsfrogs>
 <aPgKP-wUhhfwqKke@cern.ch>
 <20251022013605.GC6859@macsyma-3.local>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022013605.GC6859@macsyma-3.local>

On Tue, Oct 21, 2025 at 06:36:05PM -0700, Theodore Tso wrote:
> On Tue, Oct 21, 2025 at 05:33:35PM -0500, Dave Dykstra wrote:
> > I understood that, but does the filesystem actually write metadata after
> > the journal is recovered, such that if the fuse2fs process dies without
> > a clean unmount there might be file corruption or data loss?  That is,
> > in the case of ro when there is write access, does the warning message
> > really apply?
> 
> As an example, if file system inconsistencies is detected by the
> kernel, it will update various fields in the superblock to indicate
> that file system is corrupted, as well as when and where the
> corruption is detected:
> 
> 	__le32	s_error_count;		/* number of fs errors */
> 	__le32	s_first_error_time;	/* first time an error happened */
> 	__le32	s_first_error_ino;	/* inode involved in first error */
> 	__le64	s_first_error_block;	/* block involved of first error */
> 	__u8	s_first_error_func[32] __nonstring;	/* function where the error happened */
> 	__le32	s_first_error_line;	/* line number where error happened */
> 	__le32	s_last_error_time;	/* most recent time of an error */
> 	__le32	s_last_error_ino;	/* inode involved in last error */
> 	__le32	s_last_error_line;	/* line number where error happened */
> 	__le64	s_last_error_block;	/* block involved of last error */
> 	__u8	s_last_error_func[32] __nonstring;	/* function where the error happened */
> 
> Since this is a singleton 4k update the superblock, we don't really
> need to worry about problems caused by a non-atomic update of this
> metadata.  And similarly, with the journal replay, if we get
> interrupted while doing the journal replay, the replay is idempotent,
> so we can just restart the journal replay from scratch.
> 
> As far as the warning message, if you mean the warning message printed
> by fuse2fs indicating that it doen't have journal support, and so if
> you are modifying the file system and the system or fuse2fs crashes,
> there may be file system corruption and/or data loss, that only needs
> to be printed when mounting read-write.  It should be safe to skip
> printing that warning message if the file system is mounted with -o
> ro, based on the resoning abovce.

/me notes that (as I pointed out elsewhere in the thread) the fuse
server isn't notified if a mount goes from ro -> rw, so fuse2fs really
ought to print the warning unconditionally.

--D

> > > Are you running fstests QA on these patches before you send them out?
> > 
> > I had not heard of them, and do not see them documented anywhere in
> > e2fsprogs, so I don't know how I was supposed to have known they were
> > needed.  Ideally there would be an automated CI test suite.  The patches
> > have passed the github CI checks (which don't show up in the standard
> > pull request place, but I found them in my own repo's Actions tab).
> > 
> > Are you talking about the tests at https://github.com/btrfs/fstests?
> > If so, it looks like there are a ton of options.  Is there a standard
> > way to run them with fuse2fs?
> 
> This is btrfs's local form of https://github.com/btrfs/fstests of
> xfstests (or fstests, as it is now sometimes called).  We do have an
> automated way of running them for ext4 kernel code.   See [1][2]
> 
> [1] https://thunk.org/gce-xfstests
> [2] https://github.com/tytso/xfstests-bld/blob/master/Documentation/kvm-quickstart.md
> 
> Darrick has been doing a lot of really good work to run fuse2fs using
> fstests/xfstests.  There isn't a turnkey way of running fuse2fs using
> this test suite yet.  It's on my todo list to add an easy way to do
> this via kvm-xfstests/gce-xfstests but I'm probably not going to get
> to it until sometime next year.  If someone would like to give it a
> try --- patches would be gratefully accepted.
> 
> 						- Ted
> 						
> 

