Return-Path: <linux-ext4+bounces-3744-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6D39954F01
	for <lists+linux-ext4@lfdr.de>; Fri, 16 Aug 2024 18:38:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3688EB226AB
	for <lists+linux-ext4@lfdr.de>; Fri, 16 Aug 2024 16:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 061991BE235;
	Fri, 16 Aug 2024 16:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="DziBoPAC"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C941BE259
	for <linux-ext4@vger.kernel.org>; Fri, 16 Aug 2024 16:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723826326; cv=none; b=IOQjcsi0jvJv1vIDCG1Ux79QwLVfolfzRCLyvfBsuwgnkX/42wRnEUSVSn5fgXvTlQ+18hjt1Y9Xqz0mWbw7SWFa10XJoGwfWZyVGRlHIv5M8Tw2O6ZE7hgRHmCOxVwsOZweE4/Q0uX9r5U3fD8ZWYoI5VZne4Fr+CJLHFncXU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723826326; c=relaxed/simple;
	bh=N0gYsH2CkMU9WUzyeKkDMFIKT6XgcxKXGmjs6Odce3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GOXNoHO9g9L1975sk/QQIVjaKoRrG9CUlnQJ4er+HicQ4gH0//Etd5hNTLZi9ljquuak67ywXR0R+UoLGtWdPd+tGofXc9kEJLnoosCCvdjCHx8Bg12TRNqDKkUvXHEkNMgS+5BtxiqEvwXDsXiKgeEbrwKbj1kuhjKQaQZAaCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=DziBoPAC; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-113-74.bstnma.fios.verizon.net [173.48.113.74])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 47GGZMSi021664
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Aug 2024 12:35:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1723826126; bh=/gsgMVXGIRAap23/7MM79YKbQX53ES2N0h6afyTSiuc=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=DziBoPAC9E4jcJIYgnonVtfGrAjF9uGl3eHs61ASbN4KgwbCX7+0WIjtWrM7MFyBC
	 p21EnYyC5lkGZAWJOMCxznUuz3+I+JayQkmXW1EwI1vVe1/oNezpyCjysYmT3b+NHU
	 418Rsfb6whrCulw4yuEu8XJtiJjvFSjMdSZDK+tIoem3TY8PFY6iKv7RZdG7b32s/s
	 3FwRvqRboPPpx0IZmnI9mXrrn6XujCxk5Civ7tZuK4NAOQ4Fuc0EMq2fIxx1KdJT+2
	 n0chYU32isYFITnYk4X0NrdHSUps8zSIWpnSWjldhwTZmVzWW+rgdHfzLSRctsgUuF
	 J0RYDdG3dVr3A==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 38CF415C02C0; Fri, 16 Aug 2024 12:35:22 -0400 (EDT)
Date: Fri, 16 Aug 2024 12:35:22 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
        Kemeng Shi <shikemeng@huaweicloud.com>, linux-ext4@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/7] ext4: avoid buffer_head leak in ext4_mark_inode_used
Message-ID: <20240816163522.GB8108@mit.edu>
References: <20240813120712.2592310-2-shikemeng@huaweicloud.com>
 <fec59d4d-898d-447c-b4fb-e9d055550f96@web.de>
 <5d75ab7f-0fad-07ef-bbcb-3fed16a5170e@huaweicloud.com>
 <20240815144905.GA6039@frogsfrogsfrogs>
 <a5ddf25d-3bd3-4323-8649-c75b65070d01@web.de>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5ddf25d-3bd3-4323-8649-c75b65070d01@web.de>

On Fri, Aug 16, 2024 at 08:56:45AM +0200, Markus Elfring wrote:
> >>>> Release inode_bitmap_bh from ext4_read_inode_bitmap in
> >>>> ext4_mark_inode_used to avoid buffer_head leak.
> >>>> By the way, remove unneeded goto for invalid ino when inode_bitmap_bh
> >>>> is NULL.
> >>>
> >>> 1. I suggest to split such changes into separate update steps.
> >>>    https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.11-rc3#n81
> >> It's acceptable to me, but I'm not sure if it worth separate patches
> >> to others. I will do separate in next version if no person is against
> >> this.
> >
> > No, that suggestion is stupid.
> 
> Please reconsider such a view a bit more.

Darrick is absolutely correct; that suggestion is.... ill-considered.

> >                                 There's no reason to generate even more
> > patches for a three line fix, it's very obvious that you're fixing a
> > missing resource release and rearranging the first error out
> > accordingly.
> 
> You would probably like to distinguish the severity for two changes,
> wouldn't you?
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.11-rc3#n168
> 
> Under which circumstances can you accept the separation of development concerns better?

We will sometimes do minor cleanups in the course of fixing a bug.  In
this particular case, the cleanup is so minor, that if someone
suggested it as a stand-alone cleanup patch, I'd reject it as adding
noise, and not being worth the extra commit.

Blindly following rules is a bad idea; that's because software
programming is an engineering discpline, which means we are often
trading off multiple goals, each of which are good in and of
themselves.  For example, extra patch noise, such as fixing
whitespace, or changing a goto errout to a return, makes zero
difference to the generated code, only a very tiny margial improvement
in the readability in the code base; and also increases the chance
that some future bug fix won't backport cleanly to older LTS kernels.

I expect ext4 developers to use their good judgement, and not just
blindly follow rules, even good rules which may make sense 80% or even
95% of the time in the submitting-patches.rst file.

Markus, perhaps you could good "blindly following rules" and read some
of the eassays found from that web search, if you need more
explorations of that topic.

Best regards, 

						- Ted

