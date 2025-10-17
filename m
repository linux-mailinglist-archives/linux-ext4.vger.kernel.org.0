Return-Path: <linux-ext4+bounces-10964-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E38BEBFF7
	for <lists+linux-ext4@lfdr.de>; Sat, 18 Oct 2025 01:31:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 918664E571E
	for <lists+linux-ext4@lfdr.de>; Fri, 17 Oct 2025 23:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31C8D23BF91;
	Fri, 17 Oct 2025 23:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fk31ghA5"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79E718DB26
	for <linux-ext4@vger.kernel.org>; Fri, 17 Oct 2025 23:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760743858; cv=none; b=WHEFiLqp2fpnZm8izbqW1UaRfIOEZsAHxdEPvbuQoVsmV7Y6i9TJrEOu5C1DXXhx+ahYnxk5cd+t5JdoDjRFs/4FGRiED6znPdovQAivo4lvSmHdRz4rjIZC6HHt3gqwUg1DpwarCMo01U0E9QTy1nOqL1EGsMpXSsfu2w4OxvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760743858; c=relaxed/simple;
	bh=CkQDOZAUVQEfoAAx+WUnaILLe7RRyuCElz1XXQ+m+Jg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mdMnsz/JQIlOs/AiLFojXFIBDIRVj+J7Eaa3c6kiIov3sb2LsKOOuysoPHCYmpf6/TtP96pY+tYvXZy5S1AlcaEoIefto7IOJAFU9OmRKCd9sIDiJUaDigH9ngfXldiMq56kRuA53rjqFh6Bt9yaVH/5M0D+GOdpj5LRJU4/a2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fk31ghA5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93741C4CEE7;
	Fri, 17 Oct 2025 23:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760743858;
	bh=CkQDOZAUVQEfoAAx+WUnaILLe7RRyuCElz1XXQ+m+Jg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fk31ghA5dmrDhXvZWKpqVvRmuktiZQSbeIDbY09MIS6Bc35gfBwv68vYASmjIBopG
	 3BGxhhJMquER1hXm+yznXkpEuRSFBh79cd7cNgT85GlRPXgIjv9wIr3cgcC0WMSCuC
	 mCTmzYCmEYP/01umx9a3Z6tCvyWBFgd8Qy7UjAtRA77pApAkn56lIX38QyWNziF4K3
	 Lzi5856ANbaZRgRz+sfeF7ZKEBB7ccMl3oCqwBi/qsZdi6N1It8aiVfJCGEyKy0hXt
	 Q3Q239xg7DTG8p6n5ylzTwESlbNm5MPsP5cW2Cgc/hHWoVUu5Cj0Q0L9+55m+a5fdN
	 qjuSkEh/v9aGA==
Date: Fri, 17 Oct 2025 16:30:57 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Dave Dykstra <dwd@cern.ch>
Cc: tytso@mit.edu, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 1/2] fuse2fs: mount norecovery if main block device is
 readonly
Message-ID: <20251017233057.GK6170@frogsfrogsfrogs>
References: <175798064753.350013.16579522589765092470.stgit@frogsfrogsfrogs>
 <175798064776.350013.6744611652039454651.stgit@frogsfrogsfrogs>
 <aPFIultQzQd6fk-o@cern.ch>
 <20251017193841.GH6170@frogsfrogsfrogs>
 <aPKk8N1_ssr3f6Zd@cern.ch>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPKk8N1_ssr3f6Zd@cern.ch>

On Fri, Oct 17, 2025 at 03:20:00PM -0500, Dave Dykstra wrote:
> On Fri, Oct 17, 2025 at 12:38:41PM -0700, Darrick J. Wong wrote:
> > On Thu, Oct 16, 2025 at 02:34:18PM -0500, Dave Dykstra wrote:
> ...
> > > > +		err_printf(ff, "%s.\n",
> > > > +			   _("read-only device, trying to mount norecovery"));
> > > > +		flags &= ~EXT2_FLAG_RW;
> > > > +		ff->ro = 1;
> > > > +		ff->norecovery = 1;
> > > 
> > > I don't think it's good to switch to read-only+norecovery even when a
> > > read-write mode was requested.  That goes too far.
> > 
> > The block device cannot be opened for write, so the mount cannot allow
> > user programs to write to files, and the fs driver cannot recover the
> > journal and it cannot write to the disk.  The only other choice would
> > be to fail the mount.
> 
> Yes, I think it's better to fail the mount if recovery is needed and it
> can't be done.
> 
> > norecovery is wrong though.  The kernel fails the mount if the journal
> > needs recovery, the block device is ro, and the user didn't specify
> > norecovery.
> 
> That makes more sense.
> 
> > > It also doesn't catch when recovery is needed.
> > 
> > What specifically do you mean "catch when recovery is needed"?  68 lines
> > down from the ext2fs_open2 call is a check for the needsrecovery state,
> > followed by recovering the journal.
> 
> I meant that it should fail in that case because it can't recover.
> 
> > > My proposed patch only reopens read-only
> > > when ro was requested and then later checks to see if recovery is needed
> > > and if so, errors out.
> > 
> > Your patch also didn't re-check the feature support after reopening the
> > block device, which you dismissed even though that can lead to
> > catastrophic behavior.
> 
> In this version of the patch there is no reopening, there is only a
> switch to open without RW if the RW open fails.  So all feature checks
> happen after it.

Well I'm struggling to reshuffle my patch deck to keep up with you.

I already _had_ patches to fix every thing you've mentioned, but since
you pre-declared you wouldn't make time even to go look at my patch
stack why the hell am I even bothering?

I no longer have patience for these interactions.

--D

> Dave
> 

