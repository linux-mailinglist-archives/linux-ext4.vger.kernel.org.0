Return-Path: <linux-ext4+bounces-5778-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29AD79F80F0
	for <lists+linux-ext4@lfdr.de>; Thu, 19 Dec 2024 18:03:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 298D6188F34A
	for <lists+linux-ext4@lfdr.de>; Thu, 19 Dec 2024 17:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3329619D8A3;
	Thu, 19 Dec 2024 17:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="ZZWXPB5A"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E44C16CD1D
	for <linux-ext4@vger.kernel.org>; Thu, 19 Dec 2024 17:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734627761; cv=none; b=cblnaYvQ3UPoLCdNIFozSWYJWxg4EVMm2cpnShZ1WcTzWbN0zuz059VDZ6A8sDVlVEpKGo7jECtVnnTqDC0wMBA4P/9QLQkJL+YpucF1n2bbxeAOxZQ2ldGKMQXWxsB/wczYLkH5O9BWqp3/vEjwDsfU8/ckn8MXrHESM0t2oqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734627761; c=relaxed/simple;
	bh=upuM+R3MtuDSg3Iia279gR+wsGQwfW9USxs1V02Xpr4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hdl1MT7pYOe1tmLSMQsQyjbwooi6ccA1jjXnYg5jVweS9RcAC4WJJVhW/OgQd+n3X23a/A/gKnm+pmqPVNvLZ9ZJEJ/Ja7uNeP3n5xXSKWrfxHN1wiAaTEEoxeYuJjnyDX4K55WM+jdZ7n78LPlAThDaJRJoQKSHtBD4geTbi00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=ZZWXPB5A; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-82-226.bstnma.fios.verizon.net [173.48.82.226])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 4BJH2CZ6015642
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Dec 2024 12:02:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1734627734; bh=uN9lPunIguV3iGtN3rpjNbh29BetKE/Dfb90QEgIy2M=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=ZZWXPB5A8fHrzFQ6iUnYvMENNq2vKaoXVzvHYmvBN6x3KQWkoYkjlOYB6QHc4c605
	 81gs6tMcb1fJwDUypGyE/ZFD2aADOPBEeLR5L4v3CM1OKcRpjWshyNZfTQe7UdTDjY
	 Ym82AMelEyU3jsxSop3NHpzYOp6Kjq6W+CxUsw4qfyUkjBBE9EREd2Gbj1eEA7Rd3Q
	 XDziz7nXDpdRenWdQ9MgqdpQeITOg1HEd3Vj4jUbh9MrmvOXs29cfQUtnwefuplY9V
	 BCE9aeedqBQY0X6mzkmCDgfYt4kcAIAo1z8AqDsrHfjaM82ynkhuy7Fr1Rvvlpy0Y0
	 ebfBD33JjuxGQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 6F2E315C5BC3; Thu, 19 Dec 2024 12:02:12 -0500 (EST)
Date: Thu, 19 Dec 2024 12:02:12 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Christoph Hellwig <hch@lst.de>
Cc: Zorro Lang <zlang@kernel.org>, Brian Foster <bfoster@redhat.com>,
        fstests@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: remove _supported_fs
Message-ID: <20241219170212.GA1585694@mit.edu>
References: <20241210065900.1235379-1-hch@lst.de>
 <20241210130033.GA1839653@mit.edu>
 <20241210160827.GA26559@lst.de>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241210160827.GA26559@lst.de>

On Tue, Dec 10, 2024 at 05:08:27PM +0100, Christoph Hellwig wrote:
> I think the diffstat alone makes it pretty clear that moving away
> form that is a benefit, and it's also a lot easier to understand than
> that ext2 and ext3 magically run ext4 tests.

We talked about this on the weekly ext4 video chat, and I think what
we'd think is actually cleaner is to have a single directory for all
ext2/ext3/ext4 tests, and then eventually, have feature-specific
guards which skip a test if a particular feature isn't supported by a
particular file system.

It's always been my position that ext2, ext3, and ext4 are effectively
the same file system from a conceptual perspective, with multiple
implementations that support different subsets of file system
features.  This includes /usr/src/linux/fs/ext2,
/usr/src/linux/fs/ext3 (before we removed it from more recent
rernels), /usr/src/linux/fs/ext4, HURD's implementation of ext2,
NetBSD/FreeBSD's implementation of ext2, etc.

So effectively, what I'm proposing is that we use xfstests/tests/ext4
effectively as "extN", which would be used when testing with
FSTYP=ext[234].

Yes, we'll need to do some cleanup to add feature guards (e.g.,
_require_metadata_journaling, and "_require_scratch_ext4_feature mmp")
instead of _exclude_fs ext2, but in the end, I think this will be
cleaner and easier to understand since we'll know exactly what the
test is testing.

Cheers,

						- Ted

