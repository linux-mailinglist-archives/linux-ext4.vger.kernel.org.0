Return-Path: <linux-ext4+bounces-7051-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFEA9A7A547
	for <lists+linux-ext4@lfdr.de>; Thu,  3 Apr 2025 16:37:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F68D1683D1
	for <lists+linux-ext4@lfdr.de>; Thu,  3 Apr 2025 14:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3983E24EF78;
	Thu,  3 Apr 2025 14:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="EdhPOjru"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41AC24EF62
	for <linux-ext4@vger.kernel.org>; Thu,  3 Apr 2025 14:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743690833; cv=none; b=k67ZI/+3RmJMNA0pHC2nqvlNWBom5a5H5M1tSVVf388PTRe8JIr0UXwZsIerYEDlqgDFafSlWQl2/i1DRZgalPs7vBdkCoSsBv8lAlUXj7rZ/MCVblmox+nn107+zM4PdBPc7Zlnzr8/WK3g0Nw47P9r1NuXI3ZpikJV4f1Tr1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743690833; c=relaxed/simple;
	bh=2TDuYkbffUtZNscUeDutELeW6f7LQjrZgxY+nNhgpLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CBRmdOOwr9ruFtsxUTfmnDc8I/P5p8KerbUpngQQvVKVmH+nVmlIh9RSL128H9DdstCyqCo0uKWcDmWvkZ7SDpJrTSkfDfaPpP1UJG/23HKuxgXQ7+57KQgN0E5nPr1u/gXp7/OJZewNwyqCJIzna04M4RrfVOrGApNd907EzPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=EdhPOjru; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43ce71582e9so6853845e9.1
        for <linux-ext4@vger.kernel.org>; Thu, 03 Apr 2025 07:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1743690830; x=1744295630; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aVBsZKIQ13uHowU1y9quubDy59z6xGT4gKGYHYzC0SY=;
        b=EdhPOjruny9SF+Om2FL286F5rm+MuPsGFewvXHKsr+8Q/rSyyyvMMTuT8Sc1kmfwNA
         k5toU9M/MSyC2+aQrRAXqjOMwyg+iE4H/ulY6fuYFgYBOzkZclvolGeFzXKjJcYkOZHO
         ypdUolKtJHegE8S4JsZ6AvgAWRDQhDniX958Kb+ZkSQCyMI+o5oZ3PzVkv5bmEPvfDzS
         sGCzW+WRF1xSbUr+u2S9IAWLw5+XHltx1nzdPx6J+bV1Jsykv77CXnWOsKt33wYji45s
         t2Br/yaBTHrybbBkpCGlsFka3kQrFj3nIASIorLUas6Ez0Yw2vebtf411e6Pdk+bKGFn
         ecUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743690830; x=1744295630;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aVBsZKIQ13uHowU1y9quubDy59z6xGT4gKGYHYzC0SY=;
        b=M74aw0+51nWz0PVQQwpaJr+LdiUN+VOwoeYMXGIDs9DzzbwrKr1IIAWt3HZ8+GPisE
         SZX/FD/V2VnLB2LgcXT/UybvZryCTJopcdm62fHtNGtSo5vomfv0+puxMCbCyjMpkvSi
         y/WnreJAFsPuXR80WisSK4s0mMvo7Wbbt3V+35vzcnRNyVY4Dwy29ykb4dvOmuKSH4En
         zy25nT9j06t/emlXxnEgEdUjAfESu0bs8M965mM9eEsLAmnHJPoWRzy2vX/SAjH+spZ8
         zFH9HilPX0pq0gYQbonBhYpWkke2M4rJMdNZmNdWoZiXKTGeM7deLfCyEPurUBD7DB7r
         GoUg==
X-Forwarded-Encrypted: i=1; AJvYcCWhyJPXeY81wdZIM3tZcs59YvpVMmBJYLzXuPVuXhmIPEq0i2T6R6giU7M6Or2MEhpkALB6AR9YCfwg@vger.kernel.org
X-Gm-Message-State: AOJu0Yyzax8Kk3Q/MGuDLRHZS9lhNvPGjVSrxQEVudQ1SXRVisJyFl7/
	j+EUuZxDxIQeHWs3wfKoilhvTRx5YYdFTAfGf4zYUY0SVyWHf4DyLZxzKDjkaNI=
X-Gm-Gg: ASbGncsoUNPLPs+IooWhrLSY0rtvlDbiw/KTEeyWLL91NW4xWmUEa8Y2ON35A5bDEGM
	bkxUD9IgU/ZdcGs/74LnsJn3WCUQ0+Zst1OPr5q+zpp/AzbA/d7mbVB4RNmClhCZI0TrEg6LRll
	T657AB+Za/U2UBTBg7o70fRjmdmgJd+k8OLb6CmHWVLbk/3qZcePHQ3xvGs8F25xuk+tnLig80G
	GdUpOsWs1gXU4Arw5JnsYeGnuAIB7yTb9OIIrgfH68++6SwdioCQorZu9KyQCi/11jZtI7njB7H
	8vjbgRnhoAXhPf/sMNPHNHzVr7XwM7SRWcNiBjdTqngCwLlbWFd0k7E=
X-Google-Smtp-Source: AGHT+IEGiE0x1PAaWMGoC9ZFiaYEPiaIq/uegZ4wpDRjLqos6a0KnKZou0W0iioyFZ8bH2QBAeGB+w==
X-Received: by 2002:a05:6000:2407:b0:39c:1424:3246 with SMTP id ffacd0b85a97d-39c142432d7mr17623759f8f.2.1743690829940;
        Thu, 03 Apr 2025 07:33:49 -0700 (PDT)
Received: from localhost (109-81-82-69.rct.o2.cz. [109.81.82.69])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-39c30096b9csm1987759f8f.13.2025.04.03.07.33.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 07:33:49 -0700 (PDT)
Date: Thu, 3 Apr 2025 16:33:47 +0200
From: Michal Hocko <mhocko@suse.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Matt Fleming <matt@readmodwrite.com>, willy@infradead.org,
	adilger.kernel@dilger.ca, akpm@linux-foundation.org,
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	luka.2016.cs@gmail.com, tytso@mit.edu,
	Barry Song <baohua@kernel.org>, kernel-team@cloudflare.com,
	Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>,
	Dave Chinner <david@fromorbit.com>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>
Subject: Re: Potential Linux Crash: WARNING in ext4_dirty_folio in Linux
 kernel v6.13-rc5
Message-ID: <Z-6cS9Cg1eN0w6XL@tiehlicka>
References: <Z8kvDz70Wjh5By7c@casper.infradead.org>
 <20250326105914.3803197-1-matt@readmodwrite.com>
 <CAENh_SSbkoa3srjkAMmJuf-iTFxHOtwESHoXiPAu6bO7MLOkDA@mail.gmail.com>
 <a751498e-0bde-4114-a9f3-9d3c755d8835@suse.cz>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a751498e-0bde-4114-a9f3-9d3c755d8835@suse.cz>

On Thu 03-04-25 14:58:25, Vlastimil Babka wrote:
> On 4/3/25 14:29, Matt Fleming wrote:
> > On Wed, Mar 26, 2025 at 10:59 AM Matt Fleming <matt@readmodwrite.com> wrote:
> >>
> >> Hi there,
> 
> + Cc also Michal
> 
> >> I'm also seeing this PF_MEMALLOC WARN triggered from kswapd in 6.12.19.
> 
> We're talking about __alloc_pages_slowpath() doing WARN_ON_ONCE(current-
> >flags & PF_MEMALLOC); for __GFP_NOFAIL allocations.
> 
> kswapd() sets:
> 
> tsk->flags |= PF_MEMALLOC | PF_KSWAPD;
> 
> so any __GFP_NOFAIL allocation done in the kswapd context risks this
> warning. It's also objectively bad IMHO because for direct reclaim we can
> loop and hope kswapd rescues us, but kswapd would then have to rely on
> direct reclaimers to get unstuck. I don't see an easy generic solution?

Right. I do not think NOFAIL request from the reclaim context is really
something we can commit to support. This really needs to be addressed on
the shrinker side.

> >> Does overlayfs need some kind of background inode reclaim support?
> > 
> > Hey everyone, I know there was some off-list discussion last week at
> > LSFMM, but I don't think a definite solution has been proposed for the
> > below stacktrace.
> > 
> > What is the shrinker API policy wrt memory allocation and I/O? Should
> > overlayfs do something more like XFS and background reclaim to avoid
> > GFP_NOFAIL
> > allocations when kswapd is shrinking caches?
> > 
> >>   Call Trace:
> >>    <TASK>
> >>    __alloc_pages_noprof+0x31c/0x330
> >>    alloc_pages_mpol_noprof+0xe3/0x1d0
> >>    folio_alloc_noprof+0x5b/0xa0
> >>    __filemap_get_folio+0x1f3/0x380
> >>    __getblk_slow+0xa3/0x1e0
> >>    __ext4_get_inode_loc+0x121/0x4b0
> >>    ext4_get_inode_loc+0x40/0xa0
> >>    ext4_reserve_inode_write+0x39/0xc0
> >>    __ext4_mark_inode_dirty+0x5b/0x220
> >>    ext4_evict_inode+0x26d/0x690
> >>    evict+0x112/0x2a0
> >>    __dentry_kill+0x71/0x180
> >>    dput+0xeb/0x1b0
> >>    ovl_stack_put+0x2e/0x50 [overlay]
> >>    ovl_destroy_inode+0x3a/0x60 [overlay]
> >>    destroy_inode+0x3b/0x70
> >>    __dentry_kill+0x71/0x180
> >>    shrink_dentry_list+0x6b/0xe0
> >>    prune_dcache_sb+0x56/0x80
> >>    super_cache_scan+0x12c/0x1e0
> >>    do_shrink_slab+0x13b/0x350
> >>    shrink_slab+0x278/0x3a0
> >>    shrink_node+0x328/0x880
> >>    balance_pgdat+0x36d/0x740
> >>    kswapd+0x1f0/0x380
> >>    kthread+0xd2/0x100
> >>    ret_from_fork+0x34/0x50
> >>    ret_from_fork_asm+0x1a/0x30
> >>    </TASK>
> > 

-- 
Michal Hocko
SUSE Labs

