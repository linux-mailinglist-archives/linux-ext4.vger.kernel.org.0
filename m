Return-Path: <linux-ext4+bounces-7099-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1749BA7F099
	for <lists+linux-ext4@lfdr.de>; Tue,  8 Apr 2025 01:01:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9106B3AB974
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Apr 2025 23:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB93225779;
	Mon,  7 Apr 2025 23:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="LvFT+oCQ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4949224241
	for <linux-ext4@vger.kernel.org>; Mon,  7 Apr 2025 23:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744066844; cv=none; b=kZHpslvVsgkBwyevHOu0gnqyrZUd1kbzetefhbAw86JGtqbjHtMGLv1TlmUsunlHNxtPAIxiLarF39Z9LoCY3dv2a5Xd0R8q9PyrU6aN+cJmyX7t6SnFn5AO00Zr5PyPoNbzWZhXUiZ125ev70ZK73EN15zMu8CrslbSyGbfi74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744066844; c=relaxed/simple;
	bh=HP9vbFV3vUxCVx7bpkpzw8lFeSnABgzR0hDblww+07o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cc2V+vqWA3cvkt9KdEDVRY02zo2bZFpD4Frxja/627yDvg6cqizXocgYe7I1MDTATZC2BafPcPrRWWu5OikeOwrlb7LUXzPqWKgSZYn2XQVb0fXlL3Q8/u3TaTsScqT6D6GbFdaGq/3uUAwK2xWjy2+lVT/Mq071QXYpVCzebvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=LvFT+oCQ; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-22622ddcc35so66253425ad.2
        for <linux-ext4@vger.kernel.org>; Mon, 07 Apr 2025 16:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1744066842; x=1744671642; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=evNCUqWM/KE8Fgtxc4/OAJwDhlQwnWsjIDPeaW75aro=;
        b=LvFT+oCQtJqvfw+/J/gHlX+6435AsnhgR23GSoZtrDSLtPn63tDhjPcnwQEabUIEMZ
         8svriIETGCA9UopCOLtPyosT0NtclLGEYVuYDbQVbSKLKc+Ri0m7XGiDZigSVVZCEqCS
         VGkL/5FErEFO7Jl/KaurZjwsKXZrnnMxkd5tydWXobY58XgK0+F2IhoKPOXBtAPEFCpm
         vUOnrDkwJnwE/WRDbZRNiLWlHXJUS0mXEUzMTyvpjCcOfCnVOElwZmcO9To63dzbp7uB
         fU2tkZBH6tc8cAQuLyCLk28zx1jq54q+TEox9cONVnogCDJlCGU/h2vG8+TA7JgaZKPv
         axjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744066842; x=1744671642;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=evNCUqWM/KE8Fgtxc4/OAJwDhlQwnWsjIDPeaW75aro=;
        b=AGQpqIskFu3EMAx6FsscONV0i5fA4SX8Mxe4vBdCroNtV73jsYHclUVG+ph/dv1UaE
         nsZQvyvR6BXgEASKYWWedABDtHi1pqAm+Z43kU3tj+KVTy/yyuI+y6yTTZ20lKfTV82i
         hcOwBU5omTEWlOSUSuxZFcWg8aCSGal45BL9LXcKBQ8L3+3EeExP8rKEKdho8ouacjJ3
         g24VDxoqBWUm+vBemsenA8uMe4RCb2TPCd1VXYu+RVWJdNAyDpGS9l0/SPCycXwb9+Um
         fye/3DtflIwDtkWm+9zQlyhhU2ajARyFR5sSYWnPCUCcXEgUBaHwwUQC0nJhBjcURz11
         0F5g==
X-Forwarded-Encrypted: i=1; AJvYcCVQp9oZPTsZcpzrbnLIVMSNHqmz9zb+h9WolUTz4+39DaVVk/adZeFcef+wz2aGloHszktqUZrgD9vc@vger.kernel.org
X-Gm-Message-State: AOJu0YySx0M7ietFzQIOAqY8sZl64R6hxbrr/ERpue2ItqrbVpxygfeM
	15SK72Snf2IjKRbLpB/PPBWbL4Rc6kEt/2O4041ZXM7YI9mwDM8uU8d+mL3mFVM=
X-Gm-Gg: ASbGnctjJu4GMPoCCIJaPZQz/WyEISkf2jHpV0domB5n7QO06/5xaay5gcxfGFPiQzF
	d9OvVn9eEqjttTUyNs93+CMv/cjIZsoL9XGxTc/kzAOd+r7XB7ka3GQb4Z1xQcBjusqnSeW/7wA
	6Pk2Xcg/RWTVLfQWA9Z6D7Pmqzhk6C/lLTUJonq5nkvjD9u29UcHmCw1tCXkmunWRRf9d9zlSEX
	X+a29lgk+lPMqOTYy0QEF0QSgeyGMI3949zUW2VIUEZU98OGz2Wut/b9STuJbIzpdSVl6OhZm3m
	/UBPX8MCOm9rHtdYTc0O95QKiUOACguDJJ7uwEsfFg6emYCY2qR1umfKgvfKsSy0Eh9fEg5GOMi
	JyfNtA5sbUYZfh12CrQ==
X-Google-Smtp-Source: AGHT+IGnjTVKROKhiUbKxR04fwQFtAP05Upi/1tbtxnH3zXCfd/7yJ0o+NE/GXDeWDfof5DG3+Gjjg==
X-Received: by 2002:a17:903:22c2:b0:223:6744:bfb9 with SMTP id d9443c01a7336-22a955738c0mr177726185ad.41.1744066841870;
        Mon, 07 Apr 2025 16:00:41 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-60-96.pa.nsw.optusnet.com.au. [49.181.60.96])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2297865e0b4sm87525135ad.154.2025.04.07.16.00.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 16:00:41 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1u1vSI-00000005pxh-0x3i;
	Tue, 08 Apr 2025 09:00:38 +1000
Date: Tue, 8 Apr 2025 09:00:38 +1000
From: Dave Chinner <david@fromorbit.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Matt Fleming <matt@readmodwrite.com>, adilger.kernel@dilger.ca,
	akpm@linux-foundation.org, linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, luka.2016.cs@gmail.com, tytso@mit.edu,
	Barry Song <baohua@kernel.org>, kernel-team@cloudflare.com,
	Vlastimil Babka <vbabka@suse.cz>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>
Subject: Re: Potential Linux Crash: WARNING in ext4_dirty_folio in Linux
 kernel v6.13-rc5
Message-ID: <Z_RZFrlPArdj9d-5@dread.disaster.area>
References: <Z8kvDz70Wjh5By7c@casper.infradead.org>
 <20250326105914.3803197-1-matt@readmodwrite.com>
 <CAENh_SSbkoa3srjkAMmJuf-iTFxHOtwESHoXiPAu6bO7MLOkDA@mail.gmail.com>
 <Z-7BengoC1j6WQBE@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z-7BengoC1j6WQBE@casper.infradead.org>

On Thu, Apr 03, 2025 at 06:12:26PM +0100, Matthew Wilcox wrote:
> On Thu, Apr 03, 2025 at 01:29:44PM +0100, Matt Fleming wrote:
> > On Wed, Mar 26, 2025 at 10:59 AM Matt Fleming <matt@readmodwrite.com> wrote:
> > >
> > > Hi there,
> > >
> > > I'm also seeing this PF_MEMALLOC WARN triggered from kswapd in 6.12.19.
> > >
> > > Does overlayfs need some kind of background inode reclaim support?
> > 
> > Hey everyone, I know there was some off-list discussion last week at
> > LSFMM, but I don't think a definite solution has been proposed for the
> > below stacktrace.
> 
> Hi Matt,
> 
> We did have a substantial discussion at LSFMM and we just had another
> discussion on the ext4 call.  I'm going to try to summarise those
> discussions here, and people can jump in to correct me (I'm not really
> an expert on this part of MM-FS interaction).
> 
> At LSFMM, we came up with a solution that doesn't work, so let's start
> with ideas that don't work:
> 
>  - Allow PF_MEMALLOC to dip into the atomic reserves.  With large block
>    devices, we might end up doing emergency high-order allocations, and
>    that makes everybody nervous
>  - Only allow inode reclaim from kswapd and not from direct reclaim.

That's what GFP_NOFS does. We already rely on kswapd to do inode
reclaim rather than direct reclaim when filesystem cache pressure
is driving memory reclaim...

>    Your stack trace here is from kswapd, so obviously that doesn't work.
>  - Allow ->evict_inode to return an error.  At this point the inode has
>    been taken off the lists which means that somebody else may have
>    started to start constructing it again, and we can't just put it back
>    on the lists.

No. When ->evict_inode is called, the inode hasn't been taken off
the inode hash list. Hence the inode can still be found
via cache lookups whilst evict_inode() is running. However, the
inode will have I_FREEING set, so lookups will call
wait_on_freeing_inode() before retrying the lookup. They will
get woken by the inode_wake_up_bit() call in evict() that happens
after ->evict_inode returns, so I_FREEING is what provides
->evict_inode serialisation against new lookups trying to recreate
the inode whilst it is being torn down.

IOWs, nothing should be reconstructing the inode whilst evict() is
tearing it down because it can still be found in the inode hash.

> Jan explained that _usually_ the reclaim path is not the last
> holder of a reference to the inode.  What's happening here is that
> we've lost a race where the dentry is being turned negative by
> somebody else at the same time, and usually they'd have the last
> reference and call evict.  But if the shrinker has the last
> reference, it has to do the eviction.
> 
> Jan does not think that Overlayfs is a factor here.  It may change
> the timing somewhat but should not make the race wider (nor
> narrower).
> 
> Ideas still on the table:
> 
>  - Convert all filesystems to use the XFS inode management scheme.
>  Nobody is thrilled by this large amount of work.

There is no need to do that.

>  - Find a simpler version of the XFS scheme to implement for other
>    filesystems.

If we push the last half of evict_inode() out to the background
thread (i.e. go async before remove_inode_hash() is called), then
new lookups will still serialise on the inode hash due to I_FREEING
being set. i.e. Problems only arise if the inode is removed from
lookup visibility whilst they still have cleanup work pending.

e.g. have the filesystem provide a ->evict_inode_async() method
that either completes inode eviction directly or punts it to a
workqueue where it does the work and then completes inode eviction.
As long as all this work is done whilst the inode is marked
I_FREEING and is present in the inode hash, then new lookups will
serialise on the eviction work regardless of how it is scheduled.

It is likely we could simplify the XFS code by converting it over to
a mechanism like this, rather than playing the long-standing "defer
everything to background threads from ->destroy_inode()" game that
we current do.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

