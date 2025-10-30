Return-Path: <linux-ext4+bounces-11371-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BA072C21406
	for <lists+linux-ext4@lfdr.de>; Thu, 30 Oct 2025 17:41:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E3BF14EC8DC
	for <lists+linux-ext4@lfdr.de>; Thu, 30 Oct 2025 16:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C386B2DA779;
	Thu, 30 Oct 2025 16:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="eHmm86lF";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="OAgraI62";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="eHmm86lF";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="OAgraI62"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C14425EFBE
	for <linux-ext4@vger.kernel.org>; Thu, 30 Oct 2025 16:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761842363; cv=none; b=MBIdGZ8apTzVnrxQ5mdA0U+KpDrShrtijgNVtY8eeMZC0UlXNzXldNKyZF5A12+qCbCrfitfSsZJDdhhu3AiEKzvI1EwStCrAykcEHF/ZwLhOZsgNFGpLLmPRsSRxoYNSqEzAndI8DTDa/FQkxCzXD1b7Co6Q8Ngk6bmumR63ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761842363; c=relaxed/simple;
	bh=Evn3B0D4skYSZdLKLlKMUdlqbrJ7YA6kmTSp9i+64ds=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TJNtE3DB07QBmbeiIFh7AypGrLW515alk9ar6gBQHFfPDr3Fncp5qX71H+o5FNyNcFEXra92U5BxKrjfoshPOnHofArLhfS00BGTr1kfG5IG92WOuFKA5K9Wko8conUd8fi52PJLlp+PvqoRbStPWoQaK43fBPBlsXqYx+u/55o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=eHmm86lF; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=OAgraI62; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=eHmm86lF; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=OAgraI62; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8B1841F8B8;
	Thu, 30 Oct 2025 16:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761842359; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Wiy+U/AQlM6qnKofaU0EH6uvOrXsym1vqU/rghgli48=;
	b=eHmm86lFHYAfqWqJgZF5JvYesJjmVDuLRKiC1TaRZJkHwLhcZzVScC8qJ1F2NWqIarp7tb
	RLybPislVLLOmBVhyLAwZgCDwp4dhvwz/BYDzBMh2IxuHlUGvKbqVsetS8nlGIWzjt1KB5
	oY8whzVrWAk7NLuhojUUaC3bjTaVjUs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761842359;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Wiy+U/AQlM6qnKofaU0EH6uvOrXsym1vqU/rghgli48=;
	b=OAgraI62465BGDHP2x4wlx/Li1smzJmxDus9HWxvvzW+DEaRU+ikVIlFmKHCjBp3AvLa98
	tyEMpK38ktSRwdBQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=eHmm86lF;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=OAgraI62
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761842359; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Wiy+U/AQlM6qnKofaU0EH6uvOrXsym1vqU/rghgli48=;
	b=eHmm86lFHYAfqWqJgZF5JvYesJjmVDuLRKiC1TaRZJkHwLhcZzVScC8qJ1F2NWqIarp7tb
	RLybPislVLLOmBVhyLAwZgCDwp4dhvwz/BYDzBMh2IxuHlUGvKbqVsetS8nlGIWzjt1KB5
	oY8whzVrWAk7NLuhojUUaC3bjTaVjUs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761842359;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Wiy+U/AQlM6qnKofaU0EH6uvOrXsym1vqU/rghgli48=;
	b=OAgraI62465BGDHP2x4wlx/Li1smzJmxDus9HWxvvzW+DEaRU+ikVIlFmKHCjBp3AvLa98
	tyEMpK38ktSRwdBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 65CA013393;
	Thu, 30 Oct 2025 16:39:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id lP9OGLeUA2m9IwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Thu, 30 Oct 2025 16:39:19 +0000
Message-ID: <aa71ebf3-4445-49cf-a68a-0effc567fee7@suse.cz>
Date: Thu, 30 Oct 2025 17:39:19 +0100
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH V3 0/7] mm/slab: reduce slab accounting memory
 overhead by allocating slabobj_ext metadata within unused slab space
Content-Language: en-US
To: Harry Yoo <harry.yoo@oracle.com>, akpm@linux-foundation.org
Cc: andreyknvl@gmail.com, cl@linux.com, dvyukov@google.com,
 glider@google.com, hannes@cmpxchg.org, linux-mm@kvack.org,
 mhocko@kernel.org, muchun.song@linux.dev, rientjes@google.com,
 roman.gushchin@linux.dev, ryabinin.a.a@gmail.com, shakeel.butt@linux.dev,
 surenb@google.com, vincenzo.frascino@arm.com, yeoreum.yun@arm.com,
 tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251027122847.320924-1-harry.yoo@oracle.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <20251027122847.320924-1-harry.yoo@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 8B1841F8B8
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,linux.com,google.com,cmpxchg.org,kvack.org,kernel.org,linux.dev,arm.com,mit.edu,dilger.ca,vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -3.01

On 10/27/25 13:28, Harry Yoo wrote:
> RFC v2: https://lore.kernel.org/linux-mm/20250827113726.707801-1-harry.yoo@oracle.com/
> 
> RFC v2 -> v3:
>   - RFC v3 now depends on the patch "[PATCH V2] mm/slab: ensure all metadata
>     in slab object are word-aligned"

Looks like there's some outstanding feedback on that patch. Also on this
series already, so I'll wait for the next version before looking in detail,
but overall it looks good to me! Thanks!

>   - During the merge window, the size of ext4 inode cache has shrunken
>     and it couldn't benefit from the change anymore as the unused space
>     became smaller. But I somehow found a way to shrink the size of
>     ext4 inode object by a word...
> 
>     With new patch 1 and 2, now it can benefit from the optimization again.
> 
>   - As suggested by Andrey, SLUB now disables KASAN and KMSAN, and reset the
>     kasan tag instead of unpoisoning slabobj_ext metadata (Patch 5).
> 
> When CONFIG_MEMCG and CONFIG_MEM_ALLOC_PROFILING are enabled,
> the kernel allocates two pointers per object: one for the memory cgroup
> (obj_cgroup) to which it belongs, and another for the code location
> that requested the allocation.
> 
> In two special cases, this overhead can be eliminated by allocating
> slabobj_ext metadata from unused space within a slab:
> 
>   Case 1. The "leftover" space after the last slab object is larger than
>           the size of an array of slabobj_ext.
> 
>   Case 2. The per-object alignment padding is larger than
>           sizeof(struct slabobj_ext).
> 
> For these two cases, one or two pointers can be saved per slab object.
> Examples: ext4 inode cache (case 1) and xfs inode cache (case 2).
> That's approximately 0.7-0.8% (memcg) or 1.5-1.6%% (memcg + mem profiling)
> of the total inode cache size.
> 
> Implementing case 2 is not straightforward, because the existing code
> assumes that slab->obj_exts is an array of slabobj_ext, while case 2
> breaks the assumption.
> 
> As suggested by Vlastimil, abstract access to individual slabobj_ext
> metadata via a new helper named slab_obj_ext():
> 
> static inline struct slabobj_ext *slab_obj_ext(struct slab *slab,
>                                                unsigned long obj_exts,
>                                                unsigned int index)
> {
>         return (struct slabobj_ext *)(obj_exts + slab_get_stride(slab) * index);
> } 
> 
> In the normal case (including case 1), slab->obj_exts points to an array
> of slabobj_ext, and the stride is sizeof(struct slabobj_ext).
> 
> In case 2, the stride is s->size and
> slab->obj_exts = slab_address(slab) + s->red_left_pad + (offset of slabobj_ext)
> 
> With this approach, the memcg charging fastpath doesn't need to care the
> storage method of slabobj_ext.
> 
> Harry Yoo (7):
>   mm/slab: allow specifying freepointer offset when using constructor
>   ext4: specify the free pointer offset for ext4_inode_cache
>   mm/slab: abstract slabobj_ext access via new slab_obj_ext() helper
>   mm/slab: use stride to access slabobj_ext
>   mm/memcontrol,alloc_tag: handle slabobj_ext access under KASAN poison
>   mm/slab: save memory by allocating slabobj_ext array from leftover
>   mm/slab: place slabobj_ext metadata in unused space within s->size
> 
>  fs/ext4/super.c      |  20 ++-
>  include/linux/slab.h |   9 ++
>  mm/memcontrol.c      |  34 +++--
>  mm/slab.h            |  94 ++++++++++++-
>  mm/slab_common.c     |   8 +-
>  mm/slub.c            | 304 ++++++++++++++++++++++++++++++++++++-------
>  6 files changed, 398 insertions(+), 71 deletions(-)
> 


