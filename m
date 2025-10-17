Return-Path: <linux-ext4+bounces-10954-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1918BEB64D
	for <lists+linux-ext4@lfdr.de>; Fri, 17 Oct 2025 21:38:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EE503BADED
	for <lists+linux-ext4@lfdr.de>; Fri, 17 Oct 2025 19:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0376D311964;
	Fri, 17 Oct 2025 19:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EU/ljWNe"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9771533F8DD
	for <linux-ext4@vger.kernel.org>; Fri, 17 Oct 2025 19:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760729922; cv=none; b=ktIQ49KdTAvPgIgb3AuaUojMsY3TSpANbKWjXoxGRqehQvlWCrNH9WCMVhfiFB9Yw/ieRGoG1BA3ASE3BLQEFm97xVdYSbd9NvNPugwVhhXf1zUlbG2BRrK/vINNiX8NqrObGQBl/nyBVSodq2wiyA6iMTp6+/etAB2v4g8W2Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760729922; c=relaxed/simple;
	bh=3V6LGP0oSfA+ZLcU3myPrlCtGAEGUtpu4y3QxOwSYm4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SEvnXLPPgU2J427QAmSuPyJ18T/BQz/Vfsl8gTquAQ45ZDGNgPF6yne20sIVqcPaBFWt3yQOZ0RMK72b5Asvm+SQYjw67JrNbAdEMMpxZwkDra5jgOowBc9mmjnd2qvvFx0NJic9Y/RHxB4NBlidwDrUFWs69+0zS4k+yzEPMjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EU/ljWNe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13C15C4CEE7;
	Fri, 17 Oct 2025 19:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760729922;
	bh=3V6LGP0oSfA+ZLcU3myPrlCtGAEGUtpu4y3QxOwSYm4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EU/ljWNeGSheSerfhvsqsDVU0OLCbpt8Uuxu2RpBjsSdvPUw2pa/BF1OL4GkOb68O
	 P7kETR5TqDfrn2cpAEMWYzXbj6lcrXrAD/tugmhIsqgUhJgbu5hhfbd/PjduJAVnbR
	 msd93GLRlrYPrsmD1MrhmTG6aSIGr6n2jtx+7rzlHzPSdwF9a8H2YUcw5SoZEmA4b5
	 /I9HDloRisnZEJxJpb23ja/R2pSZBpMobYFl4jQUHkJeEWBdj8aYCGLTjdgUaDxjIo
	 spnSpe4q06NTHfbPgV3y6UryQy+BZVuVau7Sq4ozlXP5KleaRaCttnWbKxs24xVqur
	 Qkgzev5Bjupyg==
Date: Fri, 17 Oct 2025 12:38:41 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Dave Dykstra <dwd@cern.ch>
Cc: tytso@mit.edu, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 1/2] fuse2fs: mount norecovery if main block device is
 readonly
Message-ID: <20251017193841.GH6170@frogsfrogsfrogs>
References: <175798064753.350013.16579522589765092470.stgit@frogsfrogsfrogs>
 <175798064776.350013.6744611652039454651.stgit@frogsfrogsfrogs>
 <aPFIultQzQd6fk-o@cern.ch>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPFIultQzQd6fk-o@cern.ch>

On Thu, Oct 16, 2025 at 02:34:18PM -0500, Dave Dykstra wrote:
> I have a few problems with this patch, details below.
> 
> I have proposed an alternative at
>     https://github.com/tytso/e2fsprogs/pull/250
> and I'll email that here next.
> 
> On Mon, Sep 15, 2025 at 05:03:14PM -0700, Darrick J. Wong wrote:
> ...
> > diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
> > index 48473321f469dc..fb44b0a79b53e6 100644
> > --- a/misc/fuse2fs.c
> > +++ b/misc/fuse2fs.c
> > @@ -946,6 +946,15 @@ static errcode_t fuse2fs_open(struct fuse2fs *ff, int libext2_flags)
> >  
> >  	err = ext2fs_open2(ff->device, options, flags, 0, 0, unix_io_manager,
> >  			   &ff->fs);
> > +	if (err == EPERM) {
> 
> In my case the error here is EACCES (Permission denied) rather than EPERM
> so I in my patch I included both.

Ok, I'll go update my own patch.

> > +		err_printf(ff, "%s.\n",
> > +			   _("read-only device, trying to mount norecovery"));
> > +		flags &= ~EXT2_FLAG_RW;
> > +		ff->ro = 1;
> > +		ff->norecovery = 1;
> 
> I don't think it's good to switch to read-only+norecovery even when a
> read-write mode was requested.  That goes too far.

The block device cannot be opened for write, so the mount cannot allow
user programs to write to files, and the fs driver cannot recover the
journal and it cannot write to the disk.  The only other choice would
be to fail the mount.

norecovery is wrong though.  The kernel fails the mount if the journal
needs recovery, the block device is ro, and the user didn't specify
norecovery.

> It also doesn't catch when recovery is needed.

What specifically do you mean "catch when recovery is needed"?  68 lines
down from the ext2fs_open2 call is a check for the needsrecovery state,
followed by recovering the journal.

> My proposed patch only reopens read-only
> when ro was requested and then later checks to see if recovery is needed
> and if so, errors out.

Your patch also didn't re-check the feature support after reopening the
block device, which you dismissed even though that can lead to
catastrophic behavior.

--D

> 
> Dave
> 

