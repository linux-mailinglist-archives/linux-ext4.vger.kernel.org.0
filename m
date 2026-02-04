Return-Path: <linux-ext4+bounces-13531-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OO6vAVO8g2kgtwMAu9opvQ
	(envelope-from <linux-ext4+bounces-13531-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Wed, 04 Feb 2026 22:38:27 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E2DECC7F
	for <lists+linux-ext4@lfdr.de>; Wed, 04 Feb 2026 22:38:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 66CA83011A6D
	for <lists+linux-ext4@lfdr.de>; Wed,  4 Feb 2026 21:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B486D39525A;
	Wed,  4 Feb 2026 21:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="HuG+JQe9"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14DA731814F
	for <linux-ext4@vger.kernel.org>; Wed,  4 Feb 2026 21:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770241104; cv=none; b=NP0WQVu/MJnq3VT3k7xYxi+etZ2xc68/OtPMBc48wQhkUhtkrbD+7OlCuBrMHhIe585Jwf1ZI6WxLNMF3/BopmSvRSVnfjBFlz/uzvsQNfmx19mPdD+KQ/BMNL6FLnoOhfykEC4XpwEA59alBgiLulsPVhciEGdLxQZL4tSMAd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770241104; c=relaxed/simple;
	bh=O6qBV6gGN87BHthPO96VoB+LodK9kjJIc83STvOyD44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gzfUoLvhwsmqSSSyjN1IlE9k+v+ZwbmFE0/En2MXBw2yKrKzDXTLodgYv/0dQLwY7zM3erUKOV+NrZ9uOJ7rW7+JVr4jcmrpXNy6VZLjUio6b7lPZeHEJEGDx01WBSTMYXuODmoD7h2FHMTwCZic5cSVlV8EdJuqnJSZ4MSjxso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=HuG+JQe9; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from macsyma.thunk.org (pool-173-48-119-77.bstnma.fios.verizon.net [173.48.119.77])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 614LcDwi024801
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 4 Feb 2026 16:38:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1770241099; bh=o+Ve8qwMXjyJI60yJIDvTa/BgGKoP1paH+c8Ka1uPgY=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=HuG+JQe9iSGxEXCqg8fXzsDQdz91LzEzmr6CAQMEAc3mMr3MwAWs+eABJhFpFTO9m
	 F1GfuYHPahTPNit+eDPnVeahRP/uHGprFhynHIwAFXfdMP+69yBv8VgzweCtQRGNR6
	 aqe8uQ/2s1XAAjO3iE4OBSc366GbXf2Woe5TeXIamxS3jW/7Q//QSj8TbFPtjnZ9GW
	 +mMIx/vNLL5vj88SNeYi95rPPeQHOolAxpjNSamrexjHa7/yvkZc+uc4qHgnzjiHiq
	 HbDf6BQ0lGiOcgCKeh8P5xtW1pLDUDd2nM4SqKNm0BJTwomeEtQ1fFHHOJs6ALMlyy
	 KTbYhhoRC6sSQ==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id 4EBEE57405D6; Wed,  4 Feb 2026 16:37:13 -0500 (EST)
Date: Wed, 4 Feb 2026 16:37:13 -0500
From: "Theodore Tso" <tytso@mit.edu>
To: Mario Lohajner <mario_lohajner@rocketmail.com>
Cc: Andreas Dilger <adilger@dilger.ca>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: add optional rotating block allocation policy
Message-ID: <20260204213713.GD31420@macsyma.lan>
References: <20260204033112.406079-1-mario_lohajner.ref@rocketmail.com>
 <20260204033112.406079-1-mario_lohajner@rocketmail.com>
 <C3DAF83A-CE88-4348-BCE2-237960F3CD9D@dilger.ca>
 <c00064e6-a3d4-4f91-a50b-053db07c7d33@rocketmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c00064e6-a3d4-4f91-a50b-053db07c7d33@rocketmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mit.edu,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[mit.edu:s=outgoing];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13531-lists,linux-ext4=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[rocketmail.com];
	DKIM_TRACE(0.00)[mit.edu:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tytso@mit.edu,linux-ext4@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-ext4];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 75E2DECC7F
X-Rspamd-Action: no action

On Wed, Feb 04, 2026 at 12:07:57PM +0100, Mario Lohajner wrote:
> 
> Yes, the main motive for this allocator is flash wear leveling,
> but it is not strictly a wear leveling mechanism, and it is not named
> as such for a reason.

If the device needs such a flash wear leveling scheme, it's very
likely that it's not going to work very well for ext4, because there
will be *far* more writes to statially located metadata --- the
superblock, inode table, allocation bitmaps, which are scattered
across the LBA space, --- that will potentially becausing problem to
such a flash device.

In practice, even the simplest Flash Translation Layer implementations
do not require this, so I question whether devices that would need
this exist in practice.  Even the cheapest flash devices, for low-cost
mobile and digital cameras, have not needed this in the 30 plus years
that commercial flash storage have been around, and the
micro-controllers which implement the FTL have been getting more
sophisticated, not less.  Do you have a specific flash storage device
where this would be helpful?  Or this a hypothetical exercise?

> This policy helps avoid allocation hotspots at mount start by
> distributing allocations sequentially across the entire mount,
> not just a file or allocation stream.

Why are you worrying about allocation hotspots?  What's the high level
problem that you are trying to address, if it is not about wear
leveling?

> At the block/group allocation level, the file system is fairly stochastic
> and timing-sensitive. Rather than providing raw benchmark data, I prefer
> to explain the design analytically:

Whether you use raw benchmarks or try to do thought experiments you
really need to specify your assumptions about the nature of (a) the
storage device, and (b) the workload.  For example, if the flash
device has such a primitive, terible flash translation that the file
system needs to handle wear levelling, it's generally the cheapest,
most trashy storage device that can be imagined.  In those cases, the
bottleneck will likely be read/write speed.  So we probably don't need
to worry about the block allocate performance while writing to this
storage device, because the I/O throughput latency is probably
comparable to the worst possible USB thumb drive that you might find
in the checkout line of a drug store.

From the workload perforamnce, how many files are you expecting that
system will be writing in parallel?  For example, is the user going to
be running "make -j32" while building some software project?  Probably
not, because why would connect a really powerful AMD Threadripper CPU
to the cheapest possible trash flash device?  That
would be a system that would be very out of balance.  But if this is
going to be low-demand, low-power performacne, then you might be able
to use an even simpler allocator --- say, like what FAT file system
uses.

Speaking of FAT, depending on the quality of the storage device and
benchmark, perhaps another file system would be a better choice.  In
addition to FAT, another file system to consider is f2fs, which is a
log-structured file system that avoids the static inode table which
might be a problem with with a flash device that needs file system
aware wear-leveling.

> Of course, this is not optimal for classic HDDs, but NVMe drives behave
> differently.

I'm not aware of *any* NVMe devices that that would find this to be
advantages.  This is where some real benchmarks with real hardware,
and with specific workload that is used in real world devices would be
really helpful.

Cheers,

						- Ted
						

