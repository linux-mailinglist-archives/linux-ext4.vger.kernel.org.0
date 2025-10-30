Return-Path: <linux-ext4+bounces-11369-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E7DDC2134F
	for <lists+linux-ext4@lfdr.de>; Thu, 30 Oct 2025 17:34:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D397D4EE4DE
	for <lists+linux-ext4@lfdr.de>; Thu, 30 Oct 2025 16:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0213754652;
	Thu, 30 Oct 2025 16:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="AJdIHbZd";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="SK/u9tLA";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="AJdIHbZd";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="SK/u9tLA"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44BD267386
	for <linux-ext4@vger.kernel.org>; Thu, 30 Oct 2025 16:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761842014; cv=none; b=fjVkCE0xFsOTXq7nJT5AGueI8MeQPiiSpg7TsDidpZjsu7Nfme8379hKbAD8TZAKaAi1cTFG9KYLiU0ESkTeyXOR+DomMM+tpMhdSTY3A05L/ejHGuk5xWHmtBo0LGrsHDU3vOChITRYvmvueuaYotPdZlDnOPTypt3OTXWazP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761842014; c=relaxed/simple;
	bh=GoUGrbAG2okeeeO8woJ1MTyH27w4G7Z0LLRtE73SOzs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UcqMRvG1kq4sQKMBo0zHtZdOzkawg38A14ng92Ac6eN7poTA2yJU36Q27ryKh/1WTEXI1sBbdvxWzP53a2L2LoXwrwITQ8Db33+W72hZ+miItTs1qqppQ0oxyUmi9AKR9fm5qi+ycSTjpN1oryxFGX9Kw1CSwX4xH6HauIKC3FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=AJdIHbZd; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=SK/u9tLA; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=AJdIHbZd; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=SK/u9tLA; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1DDB633867;
	Thu, 30 Oct 2025 16:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761842011; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=DWrK5CMDfQDYvJeMdC/0XNpGcRIzCb/z7YPeUhp9cn8=;
	b=AJdIHbZdawoM+1A/v9u8T0d7Msg2ILyQl8XxcWcItctZTw8FgguWL2PfBAE8SjSTufGCTf
	q9C/So9D5aMj82QZswDDkc6MMQ6PUxczFTMrefq3d2GxU1SFiP+PSx/5JKRVDey4n+F5Lj
	OudNDsQFbMc33WpQHV2ZopI3prg4V5w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761842011;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=DWrK5CMDfQDYvJeMdC/0XNpGcRIzCb/z7YPeUhp9cn8=;
	b=SK/u9tLAwmSDCXlgXCdvED/60dBowSj/1i2dtbni5TwltEQ4sQGwJ8vqJzJk7UglQ57wWG
	2qhkO4hFqhHVAOCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761842011; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=DWrK5CMDfQDYvJeMdC/0XNpGcRIzCb/z7YPeUhp9cn8=;
	b=AJdIHbZdawoM+1A/v9u8T0d7Msg2ILyQl8XxcWcItctZTw8FgguWL2PfBAE8SjSTufGCTf
	q9C/So9D5aMj82QZswDDkc6MMQ6PUxczFTMrefq3d2GxU1SFiP+PSx/5JKRVDey4n+F5Lj
	OudNDsQFbMc33WpQHV2ZopI3prg4V5w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761842011;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=DWrK5CMDfQDYvJeMdC/0XNpGcRIzCb/z7YPeUhp9cn8=;
	b=SK/u9tLAwmSDCXlgXCdvED/60dBowSj/1i2dtbni5TwltEQ4sQGwJ8vqJzJk7UglQ57wWG
	2qhkO4hFqhHVAOCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ECEEF13393;
	Thu, 30 Oct 2025 16:33:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id X0eHOVqTA2msHQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Thu, 30 Oct 2025 16:33:30 +0000
Message-ID: <48029aab-20ea-4d90-bfd1-255592b2018e@suse.cz>
Date: Thu, 30 Oct 2025 17:33:30 +0100
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH V3 6/7] mm/slab: save memory by allocating slabobj_ext
 array from leftover
Content-Language: en-US
To: Harry Yoo <harry.yoo@oracle.com>, Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, andreyknvl@gmail.com, cl@linux.com,
 dvyukov@google.com, glider@google.com, hannes@cmpxchg.org,
 linux-mm@kvack.org, mhocko@kernel.org, muchun.song@linux.dev,
 rientjes@google.com, roman.gushchin@linux.dev, ryabinin.a.a@gmail.com,
 shakeel.butt@linux.dev, vincenzo.frascino@arm.com, yeoreum.yun@arm.com,
 tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251027122847.320924-1-harry.yoo@oracle.com>
 <20251027122847.320924-7-harry.yoo@oracle.com>
 <CAJuCfpGY0h2d6VEAEa4kjH2yUMGDdke_QTFt6d+gb+kH=rnXyQ@mail.gmail.com>
 <aQHJfyoUN-tbnVFr@hyeyoo>
 <CAJuCfpFhaPTqtKbjrigptPJ-9kKJB--mPnicBzN1=rfJxhN3PQ@mail.gmail.com>
 <aQK0Bj8DL21WJ0gq@hyeyoo>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <aQK0Bj8DL21WJ0gq@hyeyoo>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[21];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,gmail.com,linux.com,google.com,cmpxchg.org,kvack.org,kernel.org,linux.dev,arm.com,mit.edu,dilger.ca,vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -2.80

On 10/30/25 01:40, Harry Yoo wrote:
> On Wed, Oct 29, 2025 at 11:37:27AM -0700, Suren Baghdasaryan wrote:
>> > > >         mod_node_page_state(slab_pgdat(slab), cache_vmstat_idx(s),
>> > > > @@ -3219,9 +3352,6 @@ static struct slab *allocate_slab(struct kmem_cache *s, gfp_t flags, int node)
>> > > >         slab->objects = oo_objects(oo);slab_obj_exts
>> > > >         slab->inuse = 0;
>> > > >         slab->frozen = 0;
>> > > > -       init_slab_obj_exts(slab);
>> > > > -
>> > > > -       account_slab(slab, oo_order(oo), s, flags);
>> > > >
>> > > >         slab->slab_cache = s;
>> > > >
>> > > > @@ -3230,6 +3360,13 @@ static struct slab *allocate_slab(struct kmem_cache *s, gfp_t flags, int node)
>> > > >         start = slab_address(slab);
>> > > >
>> > > >         setup_slab_debug(s, slab, start);
>> > > > +       init_slab_obj_exts(slab);
>> > > > +       /*
>> > > > +        * Poison the slab before initializing the slabobj_ext array
>> > > > +        * to prevent the array from being overwritten.
>> > > > +        */
>> > > > +       alloc_slab_obj_exts_early(s, slab);
>> > > > +       account_slab(slab, oo_order(oo), s, flags);
>> > >
>> > >  alloc_slab_obj_exts() is called in 2 other places:
>> > > 1. __memcg_slab_post_alloc_hook()
>> > > 2. prepare_slab_obj_exts_hook()
>> > >
>> > > Don't you need alloc_slab_obj_exts_early() there as well?
>> >
>> > That's good point, and I thought it's difficult to address
>> > concurrency problem without using a per-slab lock.
>> >
>> > Thread A                    Thread B
>> > - sees slab->obj_exts == 0
>> >                             - sees slab->obj_exts == 0
>> >                             - allocates the vector from unused space
>> >                               and initializes it.
>> >                             - try cmpxchg()
>> > - allocates the vector
>> >   from unused space and
>> >   initializes it.
>> >   (the vector is already
>> >    in use and it's overwritten!)
>> >
>> > - try cmpxchg()
>> >
>> > But since this is slowpath, using slab_{lock,unlock}() here is probably
>> > fine. What do you think?
>> 
>> Ok, was your original intent to leave these callers as is and allocate
>> the vector like we do today even if obj_exts fit inside the slab?
> 
> Yes that's what I intended, and maybe later we could allocate the vector
> from the unused space even after the slab is allocated, as long as
> it doesn't hurt performance.

It would be nice. I guess what can happen is there's a cache without
SLAB_ACCOUNT but then some allocations from that will use __GFP_ACCOUNT and
we need to allocate obj_exts on-demand, right?

>> >
>> > --
>> > Cheers,
>> > Harry / Hyeonggon
> 


