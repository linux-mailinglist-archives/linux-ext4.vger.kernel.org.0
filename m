Return-Path: <linux-ext4+bounces-760-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47E47829352
	for <lists+linux-ext4@lfdr.de>; Wed, 10 Jan 2024 06:31:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6D68288CCA
	for <lists+linux-ext4@lfdr.de>; Wed, 10 Jan 2024 05:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF768DDAB;
	Wed, 10 Jan 2024 05:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sLC263s9"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1A32A1C0
	for <linux-ext4@vger.kernel.org>; Wed, 10 Jan 2024 05:31:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4CDFC433F1;
	Wed, 10 Jan 2024 05:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704864696;
	bh=7KRfy1m6ll7/cLHkwg23NYxrnWnJee3CCe6wF73ayZY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sLC263s9pi4DJ1HMoQnDx8sggHvg48l341Kcf1S3VI/B7vO5noNM7vhqrNHjfr2em
	 McV/3RA1pAG4H5i5+PhIczgIlwml6ym4r/TuFMEkHYicplhl2yN3JU8EJz1XVS1ZAq
	 GFO6zyaLm0WcN/qWcfpEybeICvs6okHSBx/fgP0bg//Oc6CCu2xkO4lWycs1Yj8xfq
	 EOHOMOfTRuzzxSnea/828EHKKX4dPEv37spja9H0YMiCSkAYZofIxGg1OZKp+EIWey
	 nApwNFWHyUOvfyhK0msuXhAXpdvTORTAdUpQBUH5yXnmPoDCMtQcE2CLBkrsZe8YTQ
	 2x8x0QywAeGWg==
Date: Tue, 9 Jan 2024 21:31:35 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: "Brian J. Murrell" <brian@interlinx.bc.ca>, tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Subject: Re: e2scrub finds corruption immediately after mounting
Message-ID: <20240110053135.GB722946@frogsfrogsfrogs>
References: <536d25b24364eaf11a38b47e853008c3115d82b8.camel@interlinx.bc.ca>
 <20240104045540.GD36164@frogsfrogsfrogs>
 <cf4fb33f3a60629d3b6108c1c206aa5b931d8498.camel@interlinx.bc.ca>
 <01b2c55a334cf970e49958a5f932d5822bfa74b4.camel@interlinx.bc.ca>
 <20240109060629.GA722946@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240109060629.GA722946@frogsfrogsfrogs>

On Mon, Jan 08, 2024 at 10:06:29PM -0800, Darrick J. Wong wrote:
> On Mon, Jan 08, 2024 at 07:52:33AM -0500, Brian J. Murrell wrote:
> > On Thu, 2024-01-04 at 09:13 -0500, Brian J. Murrell wrote:
> > > On Wed, 2024-01-03 at 20:55 -0800, Darrick J. Wong wrote:
> > > > Curious.  Normally e2scrub will run e2fsck twice: Once in journal-
> > > > only
> > > > preen mode to replay the journal, then again with -fy to perform
> > > > the
> > > > full filesystem (snapshot) check.
> > > 
> > > It is doing that.  I suspect the first e2fsck is silent.
> > > 
> > > > I wonder if you would paste the output of
> > > > "bash -x e2scrub /dev/rootvol_tmp/almalinux8_opt" here?  I'd be
> > > > curious
> > > > to see what the command flow is.
> > > 
> > > Sure.
> > 
> > Was the bash -x output useful in any way, or was any of the information
> > I supplied in my other replies on this list:
> > 
> > https://lore.kernel.org/linux-ext4/51aa3ceea05945c9f28e884bc2f43a249ef7e23e.camel@interlinx.bc.ca/
> > https://lore.kernel.org/linux-ext4/be5e8488f8484194889216603d2aba2812c6adcb.camel@interlinx.bc.ca/
> > 
> > useful including the test of 1.47.0 being able to reproduce the
> > behaviour?
> 
> It was good and bad -- good in that it eliminated all of my hypotheses
> about what could be causing it; and bad in that now I have no idea.
> 
> *Something* is causing the e2fsck exit code to be nonzero, but there's
> nothing identifying what did that in the stdout/stderr dump.
> 
> > Any thoughts on how to proceed?
> 
> If you're willing to share a metadata dump of the filesystem, injecting:
> 
> e2image -Q "${snap_dev}" /tmp/disk.qcow2
> 
> right before the second e2fsck invocation in check() might help us get a
> reproducer going.  Please compress the qcow2 file before uploading it
> somewhere.

/me downloads dump, takes a look...

AHA!  This is an ext2 filesystem, since it doesn't have the
"has_journal" or "extents" features turned on:

# e2image -r /tmp/disk.qcow2 /dev/sda
# dumpe2fs /dev/sda -h
dumpe2fs 1.47.1~WIP-2023-12-27 (27-Dec-2023)
Filesystem volume name:   <none>
Last mounted on:          /opt
Filesystem UUID:          2c70368a-0d54-4805-8620-fda19466d819
Filesystem magic number:  0xEF53
Filesystem revision #:    1 (dynamic)
Filesystem features:      ext_attr resize_inode dir_index filetype sparse_super large_file
Filesystem flags:         signed_directory_hash
Default mount options:    user_xattr acl
Filesystem state:         not clean with errors

(Note: Filesystem state == "clean" means that EXT2_VALID_FS is set in
the superblock s_state field; "not clean with errors" means that the
flag is not set.)

I bet the "journal only" preen doesn't actually reset the filesystem
state either:

# e2fsck -E journal_only -p  /dev/sda
# dumpe2fs /dev/sda -h | grep state
dumpe2fs 1.47.1~WIP-2023-12-27 (27-Dec-2023)
Filesystem state:         not clean with errors

Nope.

So now I know what happened -- when mounting an ext* filesystem that
doesn't have a journal, the driver clears EXT2_VALID_FS from the primary
superblock.  This forces the system to run e2fsck after a crash, because
that's what you have to do for unjournalled filesystems.

The "e2fsck -E journal_only -p" call in e2scrub only replays the
journal.  Since there is no journal, it exits almost immediately.
That's the intended behavior, but then it means that the "e2fsck -fy"
call immediately after sees that the superblock doesn't have
EXT2_VALID_FS set, sets it, and makes e2fsck return 1.

So that's why you're getting the e2scrub failures.

Contrast this to what you get when the filesystem has a journal:

# dumpe2fs -h /dev/sdb
dumpe2fs 1.47.0 (5-Feb-2023)
Filesystem volume name:   <none>
Last mounted on:          <not available>
Filesystem UUID:          e18b8b57-a75e-4316-87ce-6a08969476c3
Filesystem magic number:  0xEF53
Filesystem revision #:    1 (dynamic)
Filesystem features:      has_journal ext_attr resize_inode dir_index filetype needs_recovery sparse_super large_file
Filesystem flags:         signed_directory_hash
Default mount options:    user_xattr acl
Filesystem state:         clean

Filesystems with journals retain their EXT4_VALID_FS state when they're
mounted.

Hmm.  I'll have to think tomorrow morning about what e2scrub should do
about unjournalled filesystems.  My initial thought is that it skip
them, because a mounted unjournalled filesystem cannot by definition be
made to be consistent.

Restricting the scope of e2scrub sucks, but in the meantime at least it
means that your filesystem isn't massively corrupt.  Thanks for the
metadump, it was very useful for root cause analysis.

Ted: do you have any ideas?

--D

> --D
> 
> > Cheers,
> > b.
> > 
> 
> 
> 

