Return-Path: <linux-ext4+bounces-12444-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 67095CCDF7D
	for <lists+linux-ext4@lfdr.de>; Fri, 19 Dec 2025 00:36:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0DEA5300D93D
	for <lists+linux-ext4@lfdr.de>; Thu, 18 Dec 2025 23:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 638D0310624;
	Thu, 18 Dec 2025 23:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VVc5dwna"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0596B29E113
	for <linux-ext4@vger.kernel.org>; Thu, 18 Dec 2025 23:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766100998; cv=none; b=Ypl+VO6h2b/4wdmsIC81ZAchaaEfZ1h6cIyYL911RPSNfkaAdDuxlj0sWgGSo0FoWbkkg38v2IyoQSQE5l+g5u4N98O92aU04o7s6koEG0oepO2+WFPANoUmcygXfh1W1zOpps3srPoe9+sUhdMgd5wKRtRbl4USLMUMTaoyiYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766100998; c=relaxed/simple;
	bh=7A3GsIE1Essr0JSsrrcPXnsqdJ5H5ux6TpO5bElERRA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qzTu45fi5MJU6tkeYyeKGVWY/bJuUVAIbH/sWHFTnS5YKmFJWJ3beBH9yMo73aMXT++IhiCoWxagdBQWJbu5NzZRnUaIimHyd04BvrvElkL6Di3yIpXRZHWObLq+MjNO4qAYIQ0/H0Cmr6/fTIeuxwebvT1jmbS063zQ+pFl67M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VVc5dwna; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D00BC4CEFB;
	Thu, 18 Dec 2025 23:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766100997;
	bh=7A3GsIE1Essr0JSsrrcPXnsqdJ5H5ux6TpO5bElERRA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VVc5dwnaASjaGmFYfHnBDpVN8LZ5EXf8fb4NZK/jmMfmBfv0qtg3XyLY4RmVbXkQn
	 eKkdwrejd0D1qaMkVMSTEOpPYh4I08GeauY1nsrQ8ohVncUzjdx+zw1xnHIkYsgqbh
	 wRQigZx3SkBGJSqEkhJQF+earykoUqOApZTms49ItSvBZ3M1gtpCYLTCoC7kHCN7Yy
	 8Uxa2XPsInma1famQQSbOkDsSjtejUHQ419EnWnLSMBvld93uYp6nD+njeNz5B98Fe
	 W7KrJwytVL/3gKxJM5bCVMs9/P7lZhXbCdchrICqK/8e6Sw/QJJ2HvVgnvl+elqQ0+
	 5lDM/+32Qu43g==
Date: Thu, 18 Dec 2025 15:36:36 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: "wangjianjian (C)" <wangjianjian3@huawei.com>
Cc: tytso@mit.edu, linux-ext4@vger.kernel.org, wangjianjian0@foxmail.com
Subject: Re: [PATCH] ext4,fiemap: Add inode offset for xattr fiemap
Message-ID: <20251218233636.GR94594@frogsfrogsfrogs>
References: <20251217084708.494396-1-wangjianjian3@huawei.com>
 <20251217163521.GO94594@frogsfrogsfrogs>
 <fcc21a8b-4c53-4755-9747-8e6b83036ecd@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fcc21a8b-4c53-4755-9747-8e6b83036ecd@huawei.com>

On Thu, Dec 18, 2025 at 09:05:57AM +0800, wangjianjian (C) wrote:
> On 2025/12/18 0:35, Darrick J. Wong wrote:
> > On Wed, Dec 17, 2025 at 04:47:08PM +0800, Wang Jianjian wrote:
> > > For xattr in inode, need add inode offset in this block?
> > > Also, there is one problem, if we have xattrs both in inode
> > > and block, current implementation will only return xattr inode fiemap.
> > > Is this by design?
> > 
> > I don't think there's much value in reporting the inline xattrs via
> > FIEMAP because user programs can't directly access that area anyway.
> > The only reason (AFAICT) for reporting the external xattr block is for
> > building a map of lost data given a report of localized media failure.
> yes, I agree with this. however, current behavior is it will always
> reporting inline xattr first. Do you think we should fix this?

Nah.  If there are no complaints, then let's leave it alone.
It's not like the xattr structure has a meaningful byte position index.

> > (FIEMAP only being useful for debugging and after-the-shatter forensics)
> > 
> > > Signed-off-by: Wang Jianjian <wangjianjian3@huawei.com>
> > > ---
> > >   fs/ext4/extents.c | 1 +
> > >   1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> > > index 2cf5759ba689..a16bfc75345d 100644
> > > --- a/fs/ext4/extents.c
> > > +++ b/fs/ext4/extents.c
> > > @@ -5043,6 +5043,7 @@ static int ext4_iomap_xattr_fiemap(struct inode *inode, struct iomap *iomap)
> > >   		if (error)
> > >   			return error;
> > >   		physical = (__u64)iloc.bh->b_blocknr << blockbits;
> > > +		physical += iloc.offset;
> > 
> > Also it doesn't make sense to add the address of the external block to
> > the inode offset.
> IIUC, bh is the buffer head of the inode is in and iloc.offset is its offset
> of this block.

Oh silly me.  Yes, that's more correct, though if you really wanted to
be pedantic, you could also add in the distance from the start of the
inode core to wherever the xattr data actually is.

--D

> > 
> > --D
> > 
> > >   		offset = EXT4_GOOD_OLD_INODE_SIZE +
> > >   				EXT4_I(inode)->i_extra_isize;
> > >   		physical += offset;
> > > -- 
> > > 2.34.1
> > > 
> > > 
> -- 
> Regards
> 
> 

