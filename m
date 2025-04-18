Return-Path: <linux-ext4+bounces-7340-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3BFAA93E20
	for <lists+linux-ext4@lfdr.de>; Fri, 18 Apr 2025 21:08:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9ABD4644BD
	for <lists+linux-ext4@lfdr.de>; Fri, 18 Apr 2025 19:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C54822B8D9;
	Fri, 18 Apr 2025 19:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UghTy/qo"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3F2208A7;
	Fri, 18 Apr 2025 19:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745003301; cv=none; b=PnepSHc2LydryLo3i974+k/7gXQmOMDp1t4oZXzy5JdV+0SLD0+fOWCUyAHUPcmyGVw77mVYHflHziQhdcC6NYPyMy0i/Pa9YJfUCDBoDy+ZngjJ8umKaikWCN3qsEPsAfYwYb/H39aCVhmo3LrFA7LBN688faf0aXnlBp0NIMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745003301; c=relaxed/simple;
	bh=GyAm89p9rpvXZdwX10q+VZrBMKuEi9xSyLqDJmlbQio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XqLCb11YKrzxqm5bUAh5U7vZ9vL6icblbekn5z9E107hKIdhOAFQjQRtB0ycNezVIP2ysADRAeVMV9XjhPe9RnLOmNW7fkzkKWvuYevz28klHNlEtuCVyiBasFVwomfnSEKHt0Qf9p2pEZcwDtbwbk3EMip8heSey0yQX6WqFFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UghTy/qo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A3E5C4CEE2;
	Fri, 18 Apr 2025 19:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745003300;
	bh=GyAm89p9rpvXZdwX10q+VZrBMKuEi9xSyLqDJmlbQio=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UghTy/qoQUBp6BwvVi2tvNJblbReq7+pxTMFTno5kWM3GkGIcO9xtiVfk1Xw3oqa5
	 i721e/FrOYRJYR3pITQLwL2+QFE/BvfWX5kduR4w71yP1CbtuEIkE5wRlt1oNRnhcB
	 WHBMJ+KAIX7u3LbUE8YxfkzPfFZLivfOspbwZBOKSZCMCKG+SlkmJEU8SFZHezfFIj
	 oqBRpACh2NxFUoxw1pdcE8Saa16K72dP8rFvkSiCmAHpCa81HUhj0+qYiNfnXKmMSf
	 uzVR0y8kRr9NCeWAnLIJHozCixg566xvgRKn6A7n/L8VSuaxRbybKlr7Glaxb/Yc6F
	 OQmo0kOVhVEMg==
Date: Fri, 18 Apr 2025 12:08:17 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Theodore Ts'o <tytso@mit.edu>
Cc: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
	kdevops@lists.linux.dev, dave@stgolabs.net, jack@suse.cz
Subject: Re: ext4 v6.15-rc2 baseline
Message-ID: <aAKjIUbRYH8h4FnE@bombadil.infradead.org>
References: <Z__vQcCF9xovbwtT@bombadil.infradead.org>
 <20250416233415.GA3779528@mit.edu>
 <20250417164907.GA6008@mit.edu>
 <aAFmDjDtZBzxiN66@bombadil.infradead.org>
 <aAGuAYGZfpUSabSf@bombadil.infradead.org>
 <20250418035623.GC6008@mit.edu>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250418035623.GC6008@mit.edu>

On Thu, Apr 17, 2025 at 10:56:23PM -0500, Theodore Ts'o wrote:
> On Thu, Apr 17, 2025 at 06:42:25PM -0700, Luis Chamberlain wrote:
> > 
> > ext4_defaults: 793 tests, 2 failures, 259 skipped, 10521 seconds
> >   Failures: generic/223 generic/741
> 
> generic/223 is excluded in my tests.  From [1]:
> 
> // generic/223 tests file alignment, which works on ext4 only by
> // accident because we're not RAID stripe aware yet, and works at all
> // because we have bias towards aligning on power-of-two block numbers.
> // It is a flaky test for some configurations, so skip it.
> generic/223
> 
> [1] https://github.com/tytso/xfstests-bld/blob/master/test-appliance/files/root/fs/ext4/exclude

Why not just add a hook to the test to skip it upstream?

> > ext4_bigalloc16k_4k: 793 tests, 26 failures, 341 skipped, 8856 seconds
> >   Failures: ext4/033 generic/075 generic/082 generic/091 generic/112
> >     generic/127 generic/219 generic/223 generic/230 generic/231
> >     generic/232 generic/233 generic/234 generic/235 generic/263
> >     generic/280 generic/381 generic/382 generic/566 generic/587
> >     generic/600 generic/601 generic/681 generic/682 generic/691
> >     generic/741
> 
> Hmm, some of these are because there ar a bunch of tests that don't
> work well the allocation cluster size != the file system block size.

We experienced a lot of test bugs for LBS but we addressed them.

> See [2] for the tests that I exclude.  These are fundamentally test
> bugs that just don't work for bigalloc's clustered allocation.

Absolutely all of these are test bugs? And they can't be fixed to
test bigalloc?

> [2] https://github.com/tytso/xfstests-bld/blob/master/test-appliance/files/root/fs/ext4/cfg/bigalloc_4k.exclude
> 
> As far as the rest of the bigalloc failures, some of them is hard to
> tell because you're not saving all of the test artifacts.  In
> particular, the tests which run fsx create ${seq}.*.fsx{good,bad,log}
> files.  My test appliance saves them, because they are super helpful
> when debugging a test failure.  kdevops apparently doesn't.

Patch posted.

> What I do is save the entire results directory, 

The experience we have is sometimes test bugs create TFB files (too f big),
and also earlier its not clear if we had to be conservative about space.
We have a solution in place now to not have to care about space for
results, but also in practice TFB files in practice also stall CIs and
networks, etc. And so TFB files are ignored.

If *.fsx{good,bad,log} won't ever be TFB, then we'll be good. Specially
since we can scale for archiving now.

> although by default I
> truncate any test artifacts from passing tests to 31k (this amount is
> configurable via a command line option to gce-xfstests).  This is
> important because some of artifact files are super verbose, and if you
> save them all, the time to run xz on the tar file takes forever.  But
> if the tests fail, they are *super* useful.

Right, same experience here. We call these TFB files. And we have a size
threshold too.

> For the other bigalloc failures, I have a suspicion --- how big is the
> TEST and SCRATCH devices that you are using?  By default, most of my
> test scenarios use a "small" config which is 5G.  But for the bigalloc
> tests, for the 4k block / 64k cluster size, the deviec needs to be at
> least 20G or some of the tests will fail with ENOSPC.

They are 20GiB. This is configurable via CONFIG_FSTESTS_SPARSE_FILE_SIZE.

  Luis

