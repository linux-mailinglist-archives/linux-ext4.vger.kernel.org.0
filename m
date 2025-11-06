Return-Path: <linux-ext4+bounces-11529-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD762C3BA6E
	for <lists+linux-ext4@lfdr.de>; Thu, 06 Nov 2025 15:18:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C211256514C
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Nov 2025 14:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B936230E836;
	Thu,  6 Nov 2025 14:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="Qwg3oM9j"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8DD5336EF7
	for <linux-ext4@vger.kernel.org>; Thu,  6 Nov 2025 14:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762438186; cv=none; b=sa6NtJ49r8KyGSeKRDZfLsHPHtfSlhxtd6vdOxV1T3DsrCbqhL1sFRa+MsGupauqnzHOG1MO473UTFAD4t+gR7O59Kroo4LAiUgrN2MMh0b3RIvgWFvy0Q+fM0psuMRjYa4NxDaOXw3amUXxR6u/yfy8VsyzGixF8qcHT7V09Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762438186; c=relaxed/simple;
	bh=Z3uANiNMk4r6fnAxcqCq/CTkxJgzvPJiltqaGzoO5Qo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XZJ9s1O/iPBfRyDGi6blf6VzB4Vacw47YYyaYoZbO4nzFaL52Lu0h4sjG1/++C65tcWp+QyTpT1j1ry2zePBAcug6mmxhPD9ZhPWBdjj07AVWgg6BHvWmjxiHum72/0p5OWko91wRJ14nQP3l8/dakeypQT/oW/GzIGhNn+GkEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=Qwg3oM9j; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-124-240.bstnma.fios.verizon.net [173.48.124.240])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 5A6E9UPM017790
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 6 Nov 2025 09:09:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1762438174; bh=8DMDfezeAVfp6kmu589LYOzfvjXtFG4WQ0MxWGtbsEw=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=Qwg3oM9jsv3wsjryz3eZq8trFBFiLPw3VYSPzAL7N5DjQ29omMPp+3gC5PwVXtVP2
	 X7Q3VvFAgF5QRI5HzFgaVf7CSpMYC8Dh3/kYaiRA2jNtHW0Y9I7BsXR4RQYpUpNnB0
	 ZGt86KxY2WWCgGxmhbsJNonNR/LI0CcZarq3zL8taZSvSOyZLwJjyYR7qnEPyz9JtK
	 Kc5/hRu3oMYn4tZd7RrFogXeduYKHZrAvDm8o4Xxo5oFzaYuyxKypkhSawNdUXjWVE
	 NQ4coqTSeGimCK55wVUz+ryVv847wO9Zv1bhFoeUPWdth3BScKZ3PzevyEODJ449eD
	 ouvRMLwoxf2rg==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 3F8942E00D9; Thu, 06 Nov 2025 09:09:30 -0500 (EST)
Date: Thu, 6 Nov 2025 09:09:30 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Greg KH <greg@kroah.com>
Cc: =?utf-8?B?56ug5oC/6LS6?= <12421252@zju.edu.cn>, security@kernel.org,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [SECURITY] ext4: KASAN use-after-free and Oops in
 ext4_xattr_set_entry with crafted ext4 image
Message-ID: <20251106140930.GC826105@mit.edu>
References: <dd5c923.1fc4a.19a5475534a.Coremail.l1zao@zju.edu.cn>
 <2025110632-fondue-chewer-2e20@gregkh>
 <58255d5d.20a1f.19a585765c9.Coremail.12421252@zju.edu.cn>
 <2025110602-display-remodeler-80f0@gregkh>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2025110602-display-remodeler-80f0@gregkh>

On Thu, Nov 06, 2025 at 05:50:35PM +0900, Greg KH wrote:
> 
> > I ran e2fsck -fn on the extracted image and it does report errors
> > (including “padding at end of block bitmap is not set”), so it seems
> > fsck already detects the corruption. Next time I will evaluate the
> > impact more carefully before contacting the Linux community again.
> 
> That's great to hear, but I'm sure the ext4 developers would still
> appreciate a kernel patch for this if you have one :)

A couple of other things.  First of all, when you send a report which
involves a corrupted file system, please include a copy of the
corrupted file system so the file system developers don't have to
waste a lot of time digging it out of the poc.c file.  For reports
from the upstream syzkaller, developers use syzbot website too
download artifiacts like the corrupted file system, and in cases where
they can't reproduce the problem, they can request that the syzbot
test a proposed patch for them.

One of the problems with academic researchers sending reports from
forked syzkallers is that they often don't stand up the webserver,
which causes a lot of extra effort from upstream maintainers from
responding.

I did spend an hour or so trying to pry out out the image, and took a
look at it long enough to confirm that indeed, the file system was
corrupted and so it's very low priority for me to debug it --- since
as Greg has pointed out, if you can mount a file system, in general
you're asking for problems.  Sure, you can disable setuid programs,
et. al, but for a **long** time, the block device is considered part
of the trust boundary.

Yes, there are some particularly bone-headed decisions made by certain
distributions, such as Red Hat mounting file systems whenever someone
is stupid enough to insert a USB stick (scattered in the parking lot
of the targetted defense contractor by the MSS or the CIA) in their
laptop.  This is **why* e2fsprogs and xfsprogs ships udev rules which
override that particular bit of product-manager driven stupidity.  (I
wlil note that most enterprise sysadmins already disable USB mounts.)
But if someone really wants to do that stupid thing, they should send
us patches; it's not high priority for me to fix.

That being said, it does look that e2fsck doesn't actually fix the
problem.  The issue seems to be a maliciously corrupted inode with
bogus extended attributes inline in the inode structure.  There are
other things corrupted by syzkaller, including block bitmap padding,
but it's not really relevant for the reproducer.

If you want to save time for the upstream maintainer, please try to
minimize the reproducer.  That means removing irrelevant bits from the
file system image, and those bits of the reproducer which is
completely irrelevant.  I'll try to take a look at it later, when I
have free time.  But if you'd like to help me, try to create a minimal
reproducer.

Cheers,

						- Ted


