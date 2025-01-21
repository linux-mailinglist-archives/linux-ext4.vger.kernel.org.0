Return-Path: <linux-ext4+bounces-6187-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 338FEA185AC
	for <lists+linux-ext4@lfdr.de>; Tue, 21 Jan 2025 20:34:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66B761654EB
	for <lists+linux-ext4@lfdr.de>; Tue, 21 Jan 2025 19:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F9001F4715;
	Tue, 21 Jan 2025 19:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="Zf95eyc4"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4139F1B0F39
	for <linux-ext4@vger.kernel.org>; Tue, 21 Jan 2025 19:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737488043; cv=none; b=r70TaNKsmtpgxHwiBs4RE1oQ/lle1okImxumerK2d7qOrDvJg4S7CZLTOY2tmDsFehnDCHh8g8ucFMVb1bh47JfYF70t7c0qpLxhQiwz77X5Jwcba3Bo/2N62CvBhFGi+y35RMCcULE8ABeayPcgSb1/ocOX7DYcftsEFmGsLsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737488043; c=relaxed/simple;
	bh=9f4kXQtzEFzweGqrPOgljK2fIk8o5lAkKZVikEb/ypI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AMdAKESjS0JnR3TAtFMO4AfIZ99lxn+ygFNXLR6QYE2qWwsUneQxjPh0ldelbQKRG0QCICbdZsSiZua+uD2ZOubXWV3dGzz6Ra38ZnSwRtXZjYZa52ZYiD4BIWE9RrwixbZ7omZ1shjTruU2OXbn3EJiLUUgeYPo6JFewID4KF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=Zf95eyc4; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-114-200.bstnma.fios.verizon.net [173.48.114.200])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 50LJXpdo001781
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Jan 2025 14:33:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1737488032; bh=wGOpOq4zicm+GssBqGhA8nhHchRbPuRIuAxOhR3njsQ=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=Zf95eyc4Za0zr7fmTovLW7A9fWc3Z2yV7sc830HWHd3s3FXyQTGyxqhkt3TxWsB/P
	 O2aPm6Bi7kMZ6623gqlVUm8/xd5jCgvg1Q081yxLqdf5PlqCXWAAnQhewtM7ztagAM
	 N4EquneKi8NMjFQIFxkxS3iIjbQ9laiy6vOG3wDbWLjD7RcPLmRtfotrnnE92an3JQ
	 py4YZf7bYMRvFNNrbucYyupeawXc58pqqD6EG9UJOHW4GTEyIqq8Z5WkLegHAZN5yD
	 t129ykIWrpOM73/6n9T9IBOWmBpxiOBDf6xZxLNWD8W7CSZOM03eX4cWdWfoNwIlkj
	 MeeNCV/vHkcBw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 1026315C01A1; Tue, 21 Jan 2025 14:33:51 -0500 (EST)
Date: Tue, 21 Jan 2025 14:33:51 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Gerhard Wiesinger <lists@wiesinger.com>
Cc: linux-ext4@vger.kernel.org
Subject: Re: Transparent compression with ext4 - especially with zstd
Message-ID: <20250121193351.GA3820043@mit.edu>
References: <8cb4d855-6bd8-427f-ac8f-8cf7b91547fb@wiesinger.com>
 <20250121040125.GC3761769@mit.edu>
 <213343dc-3911-45de-8195-469da9dd1a91@wiesinger.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <213343dc-3911-45de-8195-469da9dd1a91@wiesinger.com>

On Tue, Jan 21, 2025 at 07:47:24PM +0100, Gerhard Wiesinger wrote:
> We are talking in some scenarios about some factors of diskspace. E.g. in
> my database scenario with PostgreSQL around 85% of disk space can be saved
> (e.g. around factor 7).

So the problem with using compression with databases is that they need
to be able to do random writes into the middle of a file.  So that
means you need to use tricks such as writing into clusters, typically
32k or 64k.  What this means is that a single 4k random write gets
amplified into a 32k or 64k write.

> In cloud usage scenarios you can easily reduce that amount of allocated
> diskspace by around a factor 7 and reduce cost therefore.

If you are running this on a cloud platform, where you are limited (on
GCE) or charged (on AWS) by IOPS and throughput, this can be a
performance bottleneck (or cost you extra).  At the minimum the extra
I/O throughput will very likely show up on various performance
benchmarks.

Worse, using a transparent compression breaks the ACID properties of
the database.  If you crash or have a power failure while rewriting
the 64k compression cluster, all or part of that 64k compression
cluster can be corrupted.  And if your customers care about (their)
data integrity, the fact that you cheaped out on disk space might not
be something that would impress them terribly.

The short version is that transparent compression is not free, even if
you ignore the SWE development costs of implementing such a feature,
and then getting that feature to be fit for use in an enterprise use
case.  No matter what file system you might want to use, I *strongly*
suggest that you get a power fail rack and try putting the whole stack
on said power fail rack, and try dropping power while running a stress
test --- over, and over, and over again.  What you might find would
surprise you.

> The technical topic is that IMHO no stable and practical usable Linux
> filesystem which is included in the default kernel exists.
> - ZFS works but is not included in the default kernel
> - BTRFS has stability and repair issues (see mailing lists) and bugs with
> compression (does not compress on the fly in some scenarios)
> - bcachefs is experimental

When I started work at Google 15 years ago to deploy ext4 into
production, we did precisely this, and as well as deploying to a small
percentage of Google's test fleet to do A:B comparisons before we
deployed to the entire production fleet.

Whether or not it is "practical" and "usable" depends on your
definition, I guess, but from my perspective "stable" and "not losing
users' data" is job #1.

But hey, if it's worth so much to you, I suggest you cost out what it
would cost to actually implement the features that you so much want,
or how much it would cost to make the more complex file systems to be
stable for production use.  You might decide that paying the extra
storage costs is way cheaper than software engineering investment
costs involved.  At Google, and when I was at IBM before that, we were
always super disciplined about trying to figure out the ROI costs of
some particular project and not just doing it because it was "cool".

There's a famous story about how the engineers working on ZFS didn't
ask for management's permission or input from the sales team before
they started.  Sounds great, and there was some cool technology there
in ZFS --- but note that Sun had to put the company up for sale
because they were losing money...

Cheers,

						- Ted

P.S.  Note: using a compression cluster is the only real way to
support transparent compression if you are using an update-in-place
file system like ext4 or xfs.  (And that is what was coverd by the
Stac patents that I mentioned.)

If you are using a log-structed file system, such as ZFS, then you can
simply rewrite the compression cluster *and* update the file system
metadata to point at the new compression cluster --- but then the
garbage collection costs, and the file system metadata update costs
for each database commit are *huge*, and the I/O throughput hit is
even higher.  So much so that ZFS recommends that you turn off the
log-structured write and do update-in-place if you want to use a
database on ZFS.  But I'm pretty sure that this disables transparent
compression if you are using update-in-place.  TNSTAAFL.

