Return-Path: <linux-ext4+bounces-12525-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D533CE56FF
	for <lists+linux-ext4@lfdr.de>; Sun, 28 Dec 2025 21:10:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C77CC3017F26
	for <lists+linux-ext4@lfdr.de>; Sun, 28 Dec 2025 20:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B1C328135D;
	Sun, 28 Dec 2025 20:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UXPaTvIN"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E7A259C80;
	Sun, 28 Dec 2025 20:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766952571; cv=none; b=o8L3gU0YT5eROpJYWX73ELSXqzMh/Z45EZ/6aMp1CNDO28cn2+FhW4im3mP2dGCyrbou6wjoK4FyJP5pK4zZP1gbAxX7GRobTELPJQQ+1Ugjex/qT7IzzeUSM3+KqHpbuAOENtkZOGu/jhf7EyfbDy88k1aO7RQMZ5QruyTU76I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766952571; c=relaxed/simple;
	bh=TC2nm0EhZWtdnkSETSKNleBF05kbN3asFscul2p8WN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MjqrdQb5GNotvmsEZNJrButeWd+ErNf/52ulJiZGH7/3ThR+Dm6LfN4+d/c1wpxBscQoHV209oNZgKhRbnBXhqfa9DXBk5uADS/lpBA6w5ECFV99rvQ6ree3+H+By8mMzGwWjNv0n18RQmcDe3wD8SRwatO8UMMe0/XBZ22VDzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UXPaTvIN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AFE1C4CEFB;
	Sun, 28 Dec 2025 20:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766952570;
	bh=TC2nm0EhZWtdnkSETSKNleBF05kbN3asFscul2p8WN8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UXPaTvINu3EknPTKxdMpWC0hBqOePkr9OIhuJyn1qQb/ezBXophP9XP2zv4oaesAI
	 gM1nSo+rQMHccr3tdsZJPtfGM3SddO6jxH40ThdJMreRObeVJUOwyIBXhklL5qsepX
	 IZ/dJ6Y+MgoJn/UJ03u5tdxc6AtzuPCCQL9u5AJ3PWZ3YUC/E0caMKBJ8LttN07LGm
	 BllX/i5alEQBcpha+mirp7ERZmXIQgZrv1b/+BQOnQsTDS8ImU89/M+yqRRm/PxJtr
	 aTDc2yG3Hf2qEDMFSRt5n4QQ6/MzeWg7gzBmQ9tYAXEjy7WEYNl67QdV9FtHir/5it
	 qVNaLNbXz0vLQ==
Date: Sun, 28 Dec 2025 12:09:28 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: =?utf-8?Q?Bart=C5=82omiej?= Kubik <kubik.bartlomiej@gmail.com>
Cc: Baokun Li <libaokun1@huawei.com>, tytso@mit.edu,
	adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org, david.hunter.linux@gmail.com,
	skhan@linuxfoundation.org, khalid@kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	syzbot+703d8a2cd20971854b06@syzkaller.appspotmail.com
Subject: Re: [PATCH] fs/ext4: Initialize new folios before use
Message-ID: <20251228200928.GA2431@quark>
References: <20251223215855.2486271-1-kubik.bartlomiej@gmail.com>
 <b09e6934-6924-4f9a-a866-82599fe64879@huawei.com>
 <CAPqLRf224VcJJM1rmiJTnFXg+5tNeF4HC+AEBWpBpWZO6VxbiQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPqLRf224VcJJM1rmiJTnFXg+5tNeF4HC+AEBWpBpWZO6VxbiQ@mail.gmail.com>

On Sun, Dec 28, 2025 at 02:00:46PM +0100, Bartłomiej Kubik wrote:
> Hi,
> 
> Thank you for your suggestions.
> 
> On Wed, 24 Dec 2025 at 02:39, Baokun Li <libaokun1@huawei.com> wrote:
> >
> > Hi Bartlomiej,
> >
> > On 2025-12-24 05:58, Bartlomiej Kubik wrote:
> > > KMSAN reports an uninitialized value in adiantum_crypt, created at
> > > write_begin_get_folio(). New folios are allocated with the FGP_CREAT
> > > flag and may be returned uninitialized. These uninitialized folios are
> > > then used without proper initialization.
> > >
> > > Fixes: b799474b9aeb ("mm/pagemap: add write_begin_get_folio() helper function")
> > > Tested-by: syzbot+703d8a2cd20971854b06@syzkaller.appspotmail.com
> > > Reported-by: syzbot+703d8a2cd20971854b06@syzkaller.appspotmail.com
> > > Closes: https://syzkaller.appspot.com/bug?extid=703d8a2cd20971854b06
> > >
> > > Signed-off-by: Bartlomiej Kubik <kubik.bartlomiej@gmail.com>
> > > ---
> > >  include/linux/pagemap.h | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> > > index 31a848485ad9..31bbc8299e08 100644
> > > --- a/include/linux/pagemap.h
> > > +++ b/include/linux/pagemap.h
> > > @@ -787,7 +787,8 @@ static inline struct folio *write_begin_get_folio(const struct kiocb *iocb,
> > >                  fgp_flags |= FGP_DONTCACHE;
> > >
> > >          return __filemap_get_folio(mapping, index, fgp_flags,
> > > -                                   mapping_gfp_mask(mapping));
> > > +                             mapping_gfp_mask(mapping)|
> > > +                             __GFP_ZERO);
> > We do need to perform some initialization, but doing it in this common
> > path is clearly unreasonable. It would introduce unnecessary zeroing
> > overhead even for non-crypto scenarios.
> 
> Yes. That could introduce unnecessary zeroing in other paths.
> 
> > Therefore, I suspect something was missed in certain crypto-related
> > initialization paths where the zeroing should have been handled instead.
> 
> I will try to fix this in the crypto-path only and send [PATCH v2].

Please see https://lore.kernel.org/linux-ext4/20251210022202.GB4128@sol/
for my earlier analysis of this issue.

- Eric

