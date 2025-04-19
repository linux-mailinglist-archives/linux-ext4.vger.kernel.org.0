Return-Path: <linux-ext4+bounces-7342-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA05DA9450D
	for <lists+linux-ext4@lfdr.de>; Sat, 19 Apr 2025 20:37:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5414E3B6E2C
	for <lists+linux-ext4@lfdr.de>; Sat, 19 Apr 2025 18:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DF591DE4E0;
	Sat, 19 Apr 2025 18:37:39 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748E2141987
	for <linux-ext4@vger.kernel.org>; Sat, 19 Apr 2025 18:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745087859; cv=none; b=PW39Hx50YGNcKEVAv3/7tMMMw5cHnfupqP4uD/NaBdfbnoZjDzMft3XCxI/vKxqgjGo7QpjGDTsiJaIm0ekLq8hrxhq+7hhPcCl/mJiY5GRUD1UkLS2nZPvIwu4pyOvHR9hH90SG6ZzERFMyvwG2+e/O+OYpM7eej5H3nsb5F7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745087859; c=relaxed/simple;
	bh=vqPb5HJk2CBR2P7ZHR7/COJfV1F+6jjY+Hb7tuCgmdA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iIwqCH0nZdqnWwRsK1jhnRFRonxOOnBLqE25vkclMSTVrs/NTAti+3qm6ASfq1ENTIeS+QiEzzaPAE9RkudSLUwpvOXyhDMwgheB3QayVBTx7oYzde9cyHUo9pAFB0cyziIkIe8gxyxHIImfjuh4tw/wjOVnmf2MJid0WCZ2p2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from macsyma.thunk.org ([204.26.30.8])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 53JIbNxO010980
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 19 Apr 2025 14:37:24 -0400
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id D7F473458E4; Sat, 19 Apr 2025 13:36:41 -0500 (CDT)
Date: Sat, 19 Apr 2025 13:36:41 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        kdevops@lists.linux.dev, dave@stgolabs.net, jack@suse.cz
Subject: Re: ext4 v6.15-rc2 baseline
Message-ID: <20250419183641.GD210438@mit.edu>
References: <Z__vQcCF9xovbwtT@bombadil.infradead.org>
 <20250416233415.GA3779528@mit.edu>
 <20250417164907.GA6008@mit.edu>
 <aAFmDjDtZBzxiN66@bombadil.infradead.org>
 <aAGuAYGZfpUSabSf@bombadil.infradead.org>
 <20250418035623.GC6008@mit.edu>
 <aAKjIUbRYH8h4FnE@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aAKjIUbRYH8h4FnE@bombadil.infradead.org>

On Fri, Apr 18, 2025 at 12:08:17PM -0700, Luis Chamberlain wrote:
> > [1] https://github.com/tytso/xfstests-bld/blob/master/test-appliance/files/root/fs/ext4/exclude
> 
> Why not just add a hook to the test to skip it upstream?

Quite a few years ago, the upstream xfstests-bld maintainer at the
time was very much against adding these sorts of exceptions.

Instead of trying to pursuade upstream about these sorts of changes,
it was just simpler for me to exclude them in my test runner.  It's
for similar reasons why I still have some out of tree patches.  The
standards of patch review of patches from some folks such as myself
are *substantially* higher than say, those of parallel check patches,
where xfstests for-next was broken for three months.

If upstream was more willing to take patches that I find useful, I'd
certainly send them upstream.  But it's been painful.

> > Hmm, some of these are because there ar a bunch of tests that don't
> > work well the allocation cluster size != the file system block size.
> 
> We experienced a lot of test bugs for LBS but we addressed them.

If I recall correctly, upstream was hostile to the bigalloc changes a
while back, but that was many years ago. 

> 
> > See [2] for the tests that I exclude.  These are fundamentally test
> > bugs that just don't work for bigalloc's clustered allocation.
> 
> Absolutely all of these are test bugs? And they can't be fixed to
> test bigalloc?

The ones in [2] are test bugs, and *why* they are test bugs are
clearly documented in the exclude file.  If I had confidence that
upstream would accept them, I could work on it in my copious spare
time.  But it's *way* simpler for me to exclude them in my test
runner, as opposed to trying to get changes upstream in xfstests.

If other people want to try to get changes upstream, please be my
guest.  :-)

						- Ted

