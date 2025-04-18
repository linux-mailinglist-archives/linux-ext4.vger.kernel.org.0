Return-Path: <linux-ext4+bounces-7338-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE21A93105
	for <lists+linux-ext4@lfdr.de>; Fri, 18 Apr 2025 05:57:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4C7119E2173
	for <lists+linux-ext4@lfdr.de>; Fri, 18 Apr 2025 03:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 121F92676EC;
	Fri, 18 Apr 2025 03:57:37 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DEDA770E2
	for <linux-ext4@vger.kernel.org>; Fri, 18 Apr 2025 03:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744948656; cv=none; b=r9/yeJaCacKA5aeB4sPLLu6YKVhX7DewuotWkYYwxQo8OspJMl4jSgPrOYYUBIytYYNgyNafZSaNUXd7lEBf+5SgVmK9rEHxNhVYLbtZqaX0DUNJW9nrsI6Ln7spDQDaBYzVTdJYeCekGsEP1lvPus0JQhERcKfgWIA0BKtmdU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744948656; c=relaxed/simple;
	bh=+9GDEtuNbwbJbnUKLAmXPzRWDd8iSiYycEpFFqo1kH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JxySWfuZoWqurqzN1XesyHvn2/1abPhpEy2nLWE6xMPFgFE+8vTsKP+oMM8FjV5Tp0xcmBEGq9gE8idRozo/abDQEoraeDhO0BDWzgTdkI4rF8mfxHA4C+uCIJRj/IFM0ODAkBkUi52KkcuAmTdT6XuH4JNM9bH3z7wXd4eZTZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from macsyma.thunk.org ([204.26.30.8])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 53I3v7ng002639
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Apr 2025 23:57:08 -0400
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id 35878340A4B; Thu, 17 Apr 2025 22:56:23 -0500 (CDT)
Date: Thu, 17 Apr 2025 22:56:23 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        kdevops@lists.linux.dev, dave@stgolabs.net, jack@suse.cz
Subject: Re: ext4 v6.15-rc2 baseline
Message-ID: <20250418035623.GC6008@mit.edu>
References: <Z__vQcCF9xovbwtT@bombadil.infradead.org>
 <20250416233415.GA3779528@mit.edu>
 <20250417164907.GA6008@mit.edu>
 <aAFmDjDtZBzxiN66@bombadil.infradead.org>
 <aAGuAYGZfpUSabSf@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aAGuAYGZfpUSabSf@bombadil.infradead.org>

On Thu, Apr 17, 2025 at 06:42:25PM -0700, Luis Chamberlain wrote:
> 
> ext4_defaults: 793 tests, 2 failures, 259 skipped, 10521 seconds
>   Failures: generic/223 generic/741

generic/223 is excluded in my tests.  From [1]:

// generic/223 tests file alignment, which works on ext4 only by
// accident because we're not RAID stripe aware yet, and works at all
// because we have bias towards aligning on power-of-two block numbers.
// It is a flaky test for some configurations, so skip it.
generic/223

[1] https://github.com/tytso/xfstests-bld/blob/master/test-appliance/files/root/fs/ext4/exclude

generic/741 looks like some kind of device-mapper setup problem.  From
741.out.bad:

device-mapper: remove ioctl on flakey-test  failed: No such device or address
Command failed.

There's nothing interesting in generic/741, but all I can tell you is,
"it works for me"(tm).

Ran: generic/741
Passed all 1 tests


> ext4_bigalloc16k_4k: 793 tests, 26 failures, 341 skipped, 8856 seconds
>   Failures: ext4/033 generic/075 generic/082 generic/091 generic/112
>     generic/127 generic/219 generic/223 generic/230 generic/231
>     generic/232 generic/233 generic/234 generic/235 generic/263
>     generic/280 generic/381 generic/382 generic/566 generic/587
>     generic/600 generic/601 generic/681 generic/682 generic/691
>     generic/741

Hmm, some of these are because there ar a bunch of tests that don't
work well the allocation cluster size != the file system block size.
See [2] for the tests that I exclude.  These are fundamentally test
bugs that just don't work for bigalloc's clustered allocation.

[2] https://github.com/tytso/xfstests-bld/blob/master/test-appliance/files/root/fs/ext4/cfg/bigalloc_4k.exclude

As far as the rest of the bigalloc failures, some of them is hard to
tell because you're not saving all of the test artifacts.  In
particular, the tests which run fsx create ${seq}.*.fsx{good,bad,log}
files.  My test appliance saves them, because they are super helpful
when debugging a test failure.  kdevops apparently doesn't.

What I do is save the entire results directory, although by default I
truncate any test artifacts from passing tests to 31k (this amount is
configurable via a command line option to gce-xfstests).  This is
important because some of artifact files are super verbose, and if you
save them all, the time to run xz on the tar file takes forever.  But
if the tests fail, they are *super* useful.

For the other bigalloc failures, I have a suspicion --- how big is the
TEST and SCRATCH devices that you are using?  By default, most of my
test scenarios use a "small" config which is 5G.  But for the bigalloc
tests, for the 4k block / 64k cluster size, the deviec needs to be at
least 20G or some of the tests will fail with ENOSPC.

Cheers,

						- Ted

