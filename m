Return-Path: <linux-ext4+bounces-1872-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CDAAC899149
	for <lists+linux-ext4@lfdr.de>; Fri,  5 Apr 2024 00:29:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D59DB218CC
	for <lists+linux-ext4@lfdr.de>; Thu,  4 Apr 2024 22:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED37013C677;
	Thu,  4 Apr 2024 22:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MRSqA7hR"
X-Original-To: linux-ext4@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DCA513C3E3;
	Thu,  4 Apr 2024 22:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712269734; cv=none; b=hANRIifNB+HXylYHuvET0X97q9/GQHeui2+Eyp2nbvGbCjyRmSCIOZZJATaZKxIl/iyMfcTHMy8YbVs3xMmUqkrPQ2BCpsaa8JiQKLPGc9Mx/5ot5effze349o9vKHAQIzjS+fO4F3Vo3cMcM017IaD5vxs4W7mM/gfgptkLT30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712269734; c=relaxed/simple;
	bh=RxUgTHy6Q08KN0jBS41CMT9Ci5RsJ+C8p9GGt3Gfp6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mh1BbqtBN2L8XTewRgd7Ph4tuUeSTYKLrZVt+dlUUInGYTmtkm2VJLg0AjD19+bpma3ONgEitDbYW8d6gCRE5SMV2c5ElHw/RImYrmE7gxFmbflAJRB56tiTlNFA44g4J3kp2BYAJGvQdVeeTecLXQNZHIrSmt3Dk/KfiuMq6XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MRSqA7hR; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 4 Apr 2024 18:28:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712269730;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cfxyCzvtzmWi1KSrX/XZIalfQOEPT3xbF6m5fU6kp1Y=;
	b=MRSqA7hRXbZz0tmIJVXahqUTpqENt47k4TugvBcfJSyR0Cm1gh2WA4N6yRjmSx7aVgCNTP
	AtxKikLCy/Cnvx95nkww4y4oLedWDdmjqq1jSIM2X6aubg8cqXD8PoPTacuEpfuX2MFiLW
	VByPFt5v8rdJJuUvwqP0pi7SRB4TFpA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Matthew Wilcox <willy@infradead.org>, akpm@linux-foundation.org, 
	joro@8bytes.org, will@kernel.org, trond.myklebust@hammerspace.com, 
	anna@kernel.org, arnd@arndb.de, herbert@gondor.apana.org.au, davem@davemloft.net, 
	jikos@kernel.org, benjamin.tissoires@redhat.com, tytso@mit.edu, jack@suse.com, 
	dennis@kernel.org, tj@kernel.org, cl@linux.com, jakub@cloudflare.com, 
	penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com, vbabka@suse.cz, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, linux-acpi@vger.kernel.org, 
	acpica-devel@lists.linux.dev, linux-arch@vger.kernel.org, linux-crypto@vger.kernel.org, 
	bpf@vger.kernel.org, linux-input@vger.kernel.org, linux-ext4@vger.kernel.org, 
	linux-mm@kvack.org, netdev@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH 1/1] mm: change inlined allocation helpers to account at
 the call site
Message-ID: <qwwylzjcezfdyznm25epghmynvybgnzw2cmwahsyvwtqjrptsl@xdag7w65kn7b>
References: <20240404165404.3805498-1-surenb@google.com>
 <Zg7dmp5VJkm1nLRM@casper.infradead.org>
 <CAJuCfpHbTCwDERz+Hh+aLZzNdtSFKA+Q7sW-xzvmFmtyHCqROg@mail.gmail.com>
 <CAJuCfpHy5Xo76S7h9rEuA3cQ1pVqurL=wmtQ2cx9-xN1aa_C_A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpHy5Xo76S7h9rEuA3cQ1pVqurL=wmtQ2cx9-xN1aa_C_A@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Apr 04, 2024 at 03:17:43PM -0700, Suren Baghdasaryan wrote:
> On Thu, Apr 4, 2024 at 10:08 AM Suren Baghdasaryan <surenb@google.com> wrote:
> >
> > On Thu, Apr 4, 2024 at 10:04 AM Matthew Wilcox <willy@infradead.org> wrote:
> > >
> > > On Thu, Apr 04, 2024 at 09:54:04AM -0700, Suren Baghdasaryan wrote:
> > > > +++ b/include/linux/dma-fence-chain.h
> > > > @@ -86,10 +86,7 @@ dma_fence_chain_contained(struct dma_fence *fence)
> > > >   *
> > > >   * Returns a new struct dma_fence_chain object or NULL on failure.
> > > >   */
> > > > -static inline struct dma_fence_chain *dma_fence_chain_alloc(void)
> > > > -{
> > > > -     return kmalloc(sizeof(struct dma_fence_chain), GFP_KERNEL);
> > > > -};
> > > > +#define dma_fence_chain_alloc()      kmalloc(sizeof(struct dma_fence_chain), GFP_KERNEL)
> > >
> > > You've removed some typesafety here.  Before, if I wrote:
> > >
> > >         struct page *page = dma_fence_chain_alloc();
> > >
> > > the compiler would warn me that I've done something stupid.  Now it
> > > can't tell.  Suggest perhaps:
> > >
> > > #define dma_fence_chain_alloc()                                           \
> > >         (struct dma_fence_chain *)kmalloc(sizeof(struct dma_fence_chain), \
> > >                                                 GFP_KERNEL)
> > >
> > > but maybe there's a better way of doing that.  There are a few other
> > > occurrences of the same problem in this monster patch.
> >
> > Got your point.
> 
> Ironically, checkpatch generates warnings for these type casts:
> 
> WARNING: unnecessary cast may hide bugs, see
> http://c-faq.com/malloc/mallocnocast.html
> #425: FILE: include/linux/dma-fence-chain.h:90:
> + ((struct dma_fence_chain *)kmalloc(sizeof(struct dma_fence_chain),
> GFP_KERNEL))
> 
> I guess I can safely ignore them in this case (since we cast to the
> expected type)?

Correct, it's not hiding bugs in this case, it's adding type safety.

checkpatch is definitely not authoritative, you really have to use your
own judgement with it

