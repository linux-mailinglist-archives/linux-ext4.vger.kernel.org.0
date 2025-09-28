Return-Path: <linux-ext4+bounces-10463-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB9C3BA6733
	for <lists+linux-ext4@lfdr.de>; Sun, 28 Sep 2025 05:47:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A30EB176D45
	for <lists+linux-ext4@lfdr.de>; Sun, 28 Sep 2025 03:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 840C3264A83;
	Sun, 28 Sep 2025 03:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="UOCHf60x"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467F92620C3
	for <linux-ext4@vger.kernel.org>; Sun, 28 Sep 2025 03:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759031217; cv=none; b=esaaN/M8uZze2K2niOP+XUCNPg6WzkRvnlRukY4VfWDbeixaCmr1CnQwR8r/V/Bq1P0CkmfjadAJ7uC2pRuwac4qQnxLDTkXlsnG5PGD8f9maUkAIYhDA9heS2vn55oE9e3HyMz1DLVCdbYeB5MwRdqtn0LWM0LkZuDtJ6ARYKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759031217; c=relaxed/simple;
	bh=0fjwJ0ghSCT8xX9kwJ4dKXE95keNFtBxZ1EskAh9Uj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ja1ajHazp/aWkFTdYJn99sUsWbWSxWV4DRiAjx/HCQbqv7AFg32y3Db9Lb7tuTktTYo/YgL49rzeRKfoI0x6fE+t404frJYq6SC9I5da4u+CiOe9l8VhgJ7N+mmEcyD7i/RosY7MqNM5etXCQaaIpTBUfyta8DsF4y3lnn9mS9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=UOCHf60x; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-115-162.bstnma.fios.verizon.net [173.48.115.162])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 58S3kcnE005609
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 27 Sep 2025 23:46:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1759031202; bh=UBIk5t0owKETCq6QzEMoRhrHTqzSBjvqgg1mUzVm/Po=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=UOCHf60x5vTRhvXWUXpogP7yxlTaqYbkHH4JAVpFxDdKxITe38HO5iTXqYO0Zd6+I
	 SPZvkgDPb1SStuC4DJrlzrcjRITwAKvexeG5iCFQ9ufYFeXXSmJSjJhhlX0g0W+ckC
	 xAntilbVvZVchZMQRb0YjPFdbD1XJS1mQDXD8w8pe202xo8Oz8xZqHdXqrdcMWurs4
	 6hBltVJ3TkKCHYP3vU73vT22id1Z1xnJCrKoCLgyj8BJitA6j7oAahV6AzXC3YARFA
	 SqOeJKhyidOdfbhvG5aQAW5ttUdslyGRo1BBYH+lmiSRg7794JrxNjEpsleJd9+krF
	 dID+uPGlvSi0g==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 4C93C2E00D9; Sat, 27 Sep 2025 23:46:38 -0400 (EDT)
Date: Sat, 27 Sep 2025 23:46:38 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Julian Sun <sunjunchao2870@gmail.com>
Cc: Harshad Shirwadkar <harshadshirwadkar@gmail.com>, adilger@dilger.ca,
        jack@suse.cz, Ext4 Developers List <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] ext4: reimplement ext4_empty_dir() using
 is_dirent_block_empty
Message-ID: <20250928034638.GC200463@mit.edu>
References: <20200407064616.221459-3-harshadshirwadkar@gmail.com>
 <c7a41ba13a3551fca25d7498b9d4542a104fac74.camel@gmail.com>
 <CAHB1NagYz+BLXdEtUa7C_6-A6DDCT9Q+A7Vg6PXSwm9D7ZyAkQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHB1NagYz+BLXdEtUa7C_6-A6DDCT9Q+A7Vg6PXSwm9D7ZyAkQ@mail.gmail.com>

On Sat, Sep 27, 2025 at 04:11:54PM +0800, Julian Sun wrote:
> >
> > I’ve recently been looking into the ext4 directory shrinking problem
> > and was considering trying to add this feature myself. To my surprise,
> > I found that this patch set had already implemented it and even
> > received Reviewed-by. I’m curious whether it was never merged, or if it
> > was merged and later reverted?
> >
> > If possible, is there anything I could do to contribute to moving this
> > patch set forward toward being merged?

I *think* there was one or two test regressions that Harshad was
wrking on, but real problem was the original business imperative for
the project became no longer as compelling, and we moved to focus on
other priorities.

So if you'd like tocontribute to moving this forward, what we'd need
to do is to forward port the patch set to the latest kernel.  I've
taken a quick look at the patches, and predates the addition of the
support of 3-level htrees (the incompat_largedir feature).  There are
also some hardening against maliciously fuzzed file systems that will
prevent the patches from applying cleanly.

Then we'd need to run regression tests on a variety of different ext4
configurations to see if there are any regressions, and if so, they
would need to be fixed.

Also, please note that this first set of changes doesn't really make a
big difference for real-world use casses, since a directory block
won't get dropped when it is completely empty.  For example, if we
assume an average directory entry size of 32, there can be up to 128
entries in a 4k block.  If we assume that the average leaf block is
75% filled, there will be 96 directory entries.  All 96 directory
entries have to be deleted before that block can be removed.  If the
directory is 4MB, there will be roughly 100,000 directory entries and
1024 blocks.  If we assume a random distribution and random deletion
(which is a fair assumption given that we're using a hash of the file
name).  I will leave it as an exercise to the reader what percentage
of directory entries need to be deleted before the probability that at
least one 4k directory block is emptied is at least, say, 80%.  But in
practice, you have to delete most of the files in the directory before
the directory starts shrinking.

So this this is why we really need to implement the next step (which
is not in this patch series), and that is to merging two adjacent leaf
blocks once they fall below to some threshold --- say, 25%.  We will
also need to merge two adjacent index nodes if they are mostly empty.

Cheers,

						- Ted

