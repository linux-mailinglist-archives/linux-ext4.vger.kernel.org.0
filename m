Return-Path: <linux-ext4+bounces-8716-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F1E2AEE4BC
	for <lists+linux-ext4@lfdr.de>; Mon, 30 Jun 2025 18:36:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7FD2189EBDE
	for <lists+linux-ext4@lfdr.de>; Mon, 30 Jun 2025 16:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE35E293B72;
	Mon, 30 Jun 2025 16:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cozCC9hM";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Lr3mFZoL";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cozCC9hM";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Lr3mFZoL"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1E9293B5F
	for <linux-ext4@vger.kernel.org>; Mon, 30 Jun 2025 16:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751301182; cv=none; b=fQBtkHQGmE7Gwosxzf7v2PWfUwu2yZxSHnJsr2xTJ9/SyRiKWg2Cb631m1DDjNih22ql/1oP131lubuOx57/GcwLz4GVmYNzcviCrSJTDgxnOK+5lNzIoWrV1kI9MTxFnbXeb4H4gMB2F8DKJEhi20sztHwS4fegb2R+T1lClrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751301182; c=relaxed/simple;
	bh=hILGVps7WZuRoAglos6o6D6bgZ1NoYmpFBWzkIxRNjw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lQkzrmRMF3IxIl+Dw03n7QBLwYAzOaENCCSjQA8MYm2AMr9/sa5Zy6eXe63IS2EXrmliHTX8aMY9d9NNip1GGPdKPE3o/j2AA6METlNKdpqCBR0XvsCIg8zwmeapC9jMEFHRErPPnpwNKTk7WMZdamLqCVDxB3YeFMpFIEpOhtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=cozCC9hM; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Lr3mFZoL; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=cozCC9hM; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Lr3mFZoL; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 922DA211FA;
	Mon, 30 Jun 2025 16:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751301178; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HZhig65L9jQkcX5aL7br2qiBHujlq+/I7yPqCDoVk5g=;
	b=cozCC9hMGf3Z9RkXVYmyrZ71MTHkaYet7MO4w1Di516KdTgLkkTquFvebjWJT9VWyjkPll
	5gKMRGUFaQuG0MruZkJ+0NV18PpBHyH705CaPxP6eRtEgI2OYb6W1IbaX9VXzKjqBkEoRT
	M8C8xYHc4vsx+3+elUV9OcOj04Sd0tA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751301178;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HZhig65L9jQkcX5aL7br2qiBHujlq+/I7yPqCDoVk5g=;
	b=Lr3mFZoLyWQKTZpfHjB20a4X1kkP2DMrpvPE/hZNZC2nbRl5dD7BbvJyFWnEHvNvthN4dW
	3I5GHq0PIqXNRzBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751301178; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HZhig65L9jQkcX5aL7br2qiBHujlq+/I7yPqCDoVk5g=;
	b=cozCC9hMGf3Z9RkXVYmyrZ71MTHkaYet7MO4w1Di516KdTgLkkTquFvebjWJT9VWyjkPll
	5gKMRGUFaQuG0MruZkJ+0NV18PpBHyH705CaPxP6eRtEgI2OYb6W1IbaX9VXzKjqBkEoRT
	M8C8xYHc4vsx+3+elUV9OcOj04Sd0tA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751301178;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HZhig65L9jQkcX5aL7br2qiBHujlq+/I7yPqCDoVk5g=;
	b=Lr3mFZoLyWQKTZpfHjB20a4X1kkP2DMrpvPE/hZNZC2nbRl5dD7BbvJyFWnEHvNvthN4dW
	3I5GHq0PIqXNRzBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8699013983;
	Mon, 30 Jun 2025 16:32:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id DILUIDq8YmhIGgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 30 Jun 2025 16:32:58 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 3442EA0A31; Mon, 30 Jun 2025 18:32:54 +0200 (CEST)
Date: Mon, 30 Jun 2025 18:32:54 +0200
From: Jan Kara <jack@suse.cz>
To: Baokun Li <libaokun1@huawei.com>
Cc: Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org, tytso@mit.edu, 
	adilger.kernel@dilger.ca, ojaswin@linux.ibm.com, linux-kernel@vger.kernel.org, 
	yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH v2 03/16] ext4: remove unnecessary s_md_lock on update
 s_mb_last_group
Message-ID: <e2dgjtqvqjapir5xizb5ixkilhzr7fm7m7ymxzk6ixzdbwxjjs@24n4nzolye77>
References: <20250623073304.3275702-1-libaokun1@huawei.com>
 <20250623073304.3275702-4-libaokun1@huawei.com>
 <xlzlyqudvp7a6ufdvc4rgsoe7ty425rrexuxgfbgwxoazfjd25@6eqbh66w7ayr>
 <1c2d7881-94bb-46ff-9cf6-ef1fbffc13e5@huawei.com>
 <mfybwoygcycblgaln2j4et4zmyzli2zibcgvixysanugjjhhh5@xyzoc4juy4wv>
 <db4b9d71-c34d-4315-a87d-2edf3bbaff2d@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <db4b9d71-c34d-4315-a87d-2edf3bbaff2d@huawei.com>
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,huawei.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 

On Mon 30-06-25 17:21:48, Baokun Li wrote:
> On 2025/6/30 15:47, Jan Kara wrote:
> > On Mon 30-06-25 11:48:20, Baokun Li wrote:
> > > On 2025/6/28 2:19, Jan Kara wrote:
> > > > On Mon 23-06-25 15:32:51, Baokun Li wrote:
> > > > > After we optimized the block group lock, we found another lock
> > > > > contention issue when running will-it-scale/fallocate2 with multiple
> > > > > processes. The fallocate's block allocation and the truncate's block
> > > > > release were fighting over the s_md_lock. The problem is, this lock
> > > > > protects totally different things in those two processes: the list of
> > > > > freed data blocks (s_freed_data_list) when releasing, and where to start
> > > > > looking for new blocks (mb_last_group) when allocating.
> > > > > 
> > > > > Now we only need to track s_mb_last_group and no longer need to track
> > > > > s_mb_last_start, so we don't need the s_md_lock lock to ensure that the
> > > > > two are consistent, and we can ensure that the s_mb_last_group read is up
> > > > > to date by using smp_store_release/smp_load_acquire.
> > > > > 
> > > > > Besides, the s_mb_last_group data type only requires ext4_group_t
> > > > > (i.e., unsigned int), rendering unsigned long superfluous.
> > > > > 
> > > > > Performance test data follows:
> > > > > 
> > > > > Test: Running will-it-scale/fallocate2 on CPU-bound containers.
> > > > > Observation: Average fallocate operations per container per second.
> > > > > 
> > > > >                      | Kunpeng 920 / 512GB -P80|  AMD 9654 / 1536GB -P96 |
> > > > >    Disk: 960GB SSD   |-------------------------|-------------------------|
> > > > >                      | base  |    patched      | base  |    patched      |
> > > > > -------------------|-------|-----------------|-------|-----------------|
> > > > > mb_optimize_scan=0 | 4821  | 7612  (+57.8%)  | 15371 | 21647 (+40.8%)  |
> > > > > mb_optimize_scan=1 | 4784  | 7568  (+58.1%)  | 6101  | 9117  (+49.4%)  |
> > > > > 
> > > > > Signed-off-by: Baokun Li <libaokun1@huawei.com>
> > > > ...
> > > > 
> > > > > diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> > > > > index 5cdae3bda072..3f103919868b 100644
> > > > > --- a/fs/ext4/mballoc.c
> > > > > +++ b/fs/ext4/mballoc.c
> > > > > @@ -2168,11 +2168,9 @@ static void ext4_mb_use_best_found(struct ext4_allocation_context *ac,
> > > > >    	ac->ac_buddy_folio = e4b->bd_buddy_folio;
> > > > >    	folio_get(ac->ac_buddy_folio);
> > > > >    	/* store last allocated for subsequent stream allocation */
> > > > > -	if (ac->ac_flags & EXT4_MB_STREAM_ALLOC) {
> > > > > -		spin_lock(&sbi->s_md_lock);
> > > > > -		sbi->s_mb_last_group = ac->ac_f_ex.fe_group;
> > > > > -		spin_unlock(&sbi->s_md_lock);
> > > > > -	}
> > > > > +	if (ac->ac_flags & EXT4_MB_STREAM_ALLOC)
> > > > > +		/* pairs with smp_load_acquire in ext4_mb_regular_allocator() */
> > > > > +		smp_store_release(&sbi->s_mb_last_group, ac->ac_f_ex.fe_group);
> > > > Do you really need any kind of barrier (implied by smp_store_release())
> > > > here? I mean the store to s_mb_last_group is perfectly fine to be reordered
> > > > with other accesses from the thread, isn't it? As such it should be enough
> > > > to have WRITE_ONCE() here...
> > > WRITE_ONCE()/READ_ONCE() primarily prevent compiler reordering and ensure
> > > that variable reads/writes access values directly from L1/L2 cache rather
> > > than registers.
> > I agree READ_ONCE() / WRITE_ONCE() are about compiler optimizations - in
> > particular they force the compiler to read / write the memory location
> > exactly once instead of reading it potentially multiple times in different
> > parts of expression and getting inconsistent values, or possibly writing
> > the value say byte by byte (yes, that would be insane but not contrary to
> > the C standard).
> READ_ONCE() and WRITE_ONCE() rely on the volatile keyword, which serves
> two main purposes:
> 
> 1. It tells the compiler that the variable's value can change unexpectedly,
>    preventing the compiler from making incorrect optimizations based on
>    assumptions about its stability.
> 
> 2. It ensures the CPU directly reads from or writes to the variable's
>    memory address. This means the value will be fetched from cache (L1/L2)
>    if available, or from main memory otherwise, rather than using a stale
>    value from a CPU register.

Yes, we agree on this.

> > > They do not guarantee that other CPUs see the latest values. Reading stale
> > > values could lead to more useless traversals, which might incur higher
> > > overhead than memory barriers. This is why we use memory barriers to ensure
> > > the latest values are read.
> > But smp_load_acquire() / smp_store_release() have no guarantee about CPU
> > seeing latest values either. They are just speculation barriers meaning
> > they prevent the CPU from reordering accesses in the code after
> > smp_load_acquire() to be performed before the smp_load_acquire() is
> > executed and similarly with smp_store_release(). So I dare to say that
> > these barries have no (positive) impact on the allocation performance and
> > just complicate the code - but if you have some data that show otherwise,
> > I'd be happy to be proven wrong.
> smp_load_acquire() / smp_store_release() guarantee that CPUs read the
> latest data.
> 
> For example, imagine a variable a = 0, with both CPU0 and CPU1 having
> a=0 in their caches.
> 
> Without a memory barrier:
> When CPU0 executes WRITE_ONCE(a, 1), a=1 is written to the store buffer,
> an RFO is broadcast, and CPU0 continues other tasks. After receiving ACKs,
> a=1 is written to main memory and becomes visible to other CPUs.
> Then, if CPU1 executes READ_ONCE(a), it receives the RFO and adds it to
> its invalidation queue. However, it might not process it immediately;
> instead, it could perform the read first, potentially still reading a=0
> from its cache.
> 
> With a memory barrier:
> When CPU0 executes smp_store_release(&a, 1), a=1 is not only written to
> the store buffer, but data in the store buffer is also written to main
> memory. An RFO is then broadcast, and CPU0 waits for ACKs from all CPUs.
> 
> When CPU1 executes smp_load_acquire(a), it receives the RFO and adds it
> to its invalidation queue. Here, the invalidation queue is flushed, which
> invalidates a in CPU1's cache. CPU1 then replies with an ACK, and when it
> performs the read, its cache is invalid, so it reads the latest a=1 from
> main memory.

Well, here I think you assume way more about the CPU architecture than is
generally true (and I didn't find what you write above guaranteed neither
by x86 nor by arm64 CPU documentation). Generally I'm following the
guarantees as defined by Documentation/memory-barriers.txt and there you
can argue only about order of effects as observed by different CPUs but not
really about when content is fetched to / from CPU caches.

BTW on x86 in particular smp_load_acquire() and smp_store_release() aren't
very different from pure READ_ONCE() / WRITE_ONCE:

arch/x86/include/asm/barrier.h:

#define __smp_store_release(p, v)                                       \
do {                                                                    \
        compiletime_assert_atomic_type(*p);                             \
        barrier();                                                      \
        WRITE_ONCE(*p, v);                                              \
} while (0)

#define __smp_load_acquire(p)                                           \
({                                                                      \
        typeof(*p) ___p1 = READ_ONCE(*p);                               \
        compiletime_assert_atomic_type(*p);                             \
        barrier();                                                      \
        ___p1;                                                          \
})

where barrier() is just a compiler barrier - i.e., preventing the compiler
from reordering accesses around this point. This is because x86 is strongly
ordered and the CPU can only reorder loads earlier than previous stores.
TL;DR; on x86 there's no practical difference between using READ_ONCE() /
WRITE_ONCE() and smp_load_acquire() and smp_store_release() in your code.
So I still think using those will be clearer and I'd be curious if you can
see any performance impacts from using READ_ONCE / WRITE_ONCE instead of
smp_load_acquire() / smp_store_release().

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

