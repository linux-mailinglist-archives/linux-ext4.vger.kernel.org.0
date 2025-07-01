Return-Path: <linux-ext4+bounces-8742-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B881AEF836
	for <lists+linux-ext4@lfdr.de>; Tue,  1 Jul 2025 14:21:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B6C5162965
	for <lists+linux-ext4@lfdr.de>; Tue,  1 Jul 2025 12:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BBCA2737F2;
	Tue,  1 Jul 2025 12:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Veh6C+BK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="VDVWZrTc";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="CwFVekm+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="M2mREuwu"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D6C19994F
	for <linux-ext4@vger.kernel.org>; Tue,  1 Jul 2025 12:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751372468; cv=none; b=LdozN0dQ9Bc6BcKTZ+Plx76p6xbphHX6MpeB2f5C94WzO9IGZp2l1qdkdcao9NVBuTCm3p8ik5HNONF3cKVsXg5mmWBJl47Ebmg8p/ITsfyZGi47LiDxPTieThQDMZ2i10+jpTO0VeDEB3Cgp2um1Ayg3oGys6vRkWUS9fkXzMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751372468; c=relaxed/simple;
	bh=HHFnlvR1k0/CYBXXQmNn/9i74AvuUINjHNGdkOfa6Jk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RQLDTI4ExW4iXa9vDSF7+hNmJX0b2pdHdyticM6FLNlucGt9fXqktGv5l7B9oMEcUA9k/yPweCtA8Rn/Yppm+zosbzekwFlvNIkmkoTBbo0+GzyH9hFvnJBqQAG8bioNz/EkDT8VsOxKWL4xwTR4K+Rp5eeQJhyVeOoGulhsQNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Veh6C+BK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=VDVWZrTc; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=CwFVekm+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=M2mREuwu; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4E38D1F393;
	Tue,  1 Jul 2025 12:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751372463; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g/yk0UT899Izj9wKoX4fKQWpaXA0kRN1xJBxg7GUJxs=;
	b=Veh6C+BKkLGFBizfS4DEJn8A/1ZxoUYP/QT/udD8LYSsaS5cnrghxaazQ5IhSouKa8p45U
	0d9D0NR96/u4+Kcx0FjKEE6YVKo0YesFsn/fua/1Tn7Qy403XlbAtjoQnoHtWrnC2vngf6
	Kq6lfPrA8tcQEljtYjYT0j3FijpksKg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751372463;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g/yk0UT899Izj9wKoX4fKQWpaXA0kRN1xJBxg7GUJxs=;
	b=VDVWZrTcHMatSGplfJH+I1iJDxHX4SVAFfy/iyxFOmtb+UUrTi+QOnS32lAhh8HxuBih0K
	esEVFuzh19IriHDQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=CwFVekm+;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=M2mREuwu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751372462; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g/yk0UT899Izj9wKoX4fKQWpaXA0kRN1xJBxg7GUJxs=;
	b=CwFVekm+PT3WMEf3wzb19ITFeu5eUhStDfFrejZ4eGpcZaAk549bx65GmG54stSniFIhjJ
	5evkjdljDQML6hx2iizE1+IgBQjwi3LsDvoaP/kxyAeCTbBlkkwmeONWFZKzN9xYB4Kyox
	DFiNd9cXyTVpC8QSINYllWh+Q0jE/GI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751372462;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g/yk0UT899Izj9wKoX4fKQWpaXA0kRN1xJBxg7GUJxs=;
	b=M2mREuwuacaxYUsgokhqCq5bIZKhRylj3dh07IDWC7KKGoqUhGrP/cPgZXXYbgDDZCINq7
	EFvxi1vBodd0rLBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 257DA1364B;
	Tue,  1 Jul 2025 12:21:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oJnZCK7SY2g5ZgAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 01 Jul 2025 12:21:02 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 84BACA0A23; Tue,  1 Jul 2025 14:21:01 +0200 (CEST)
Date: Tue, 1 Jul 2025 14:21:01 +0200
From: Jan Kara <jack@suse.cz>
To: Baokun Li <libaokun1@huawei.com>
Cc: Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org, tytso@mit.edu, 
	adilger.kernel@dilger.ca, ojaswin@linux.ibm.com, linux-kernel@vger.kernel.org, 
	yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH v2 03/16] ext4: remove unnecessary s_md_lock on update
 s_mb_last_group
Message-ID: <kvgztznp6z2gwuujrw5vtklfbmq3arjg54bpiufmxdwmuwjliw@og7qkacbdtax>
References: <20250623073304.3275702-1-libaokun1@huawei.com>
 <20250623073304.3275702-4-libaokun1@huawei.com>
 <xlzlyqudvp7a6ufdvc4rgsoe7ty425rrexuxgfbgwxoazfjd25@6eqbh66w7ayr>
 <1c2d7881-94bb-46ff-9cf6-ef1fbffc13e5@huawei.com>
 <mfybwoygcycblgaln2j4et4zmyzli2zibcgvixysanugjjhhh5@xyzoc4juy4wv>
 <db4b9d71-c34d-4315-a87d-2edf3bbaff2d@huawei.com>
 <e2dgjtqvqjapir5xizb5ixkilhzr7fm7m7ymxzk6ixzdbwxjjs@24n4nzolye77>
 <272e8673-36a9-4fef-a9f1-5be29a57c2dc@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <272e8673-36a9-4fef-a9f1-5be29a57c2dc@huawei.com>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,huawei.com:email,suse.cz:dkim];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 4E38D1F393
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -4.01

On Tue 01-07-25 10:39:53, Baokun Li wrote:
> On 2025/7/1 0:32, Jan Kara wrote:
> > On Mon 30-06-25 17:21:48, Baokun Li wrote:
> > > On 2025/6/30 15:47, Jan Kara wrote:
> > > > On Mon 30-06-25 11:48:20, Baokun Li wrote:
> > > > > On 2025/6/28 2:19, Jan Kara wrote:
> > > > > > On Mon 23-06-25 15:32:51, Baokun Li wrote:
> > > > > > > After we optimized the block group lock, we found another lock
> > > > > > > contention issue when running will-it-scale/fallocate2 with multiple
> > > > > > > processes. The fallocate's block allocation and the truncate's block
> > > > > > > release were fighting over the s_md_lock. The problem is, this lock
> > > > > > > protects totally different things in those two processes: the list of
> > > > > > > freed data blocks (s_freed_data_list) when releasing, and where to start
> > > > > > > looking for new blocks (mb_last_group) when allocating.
> > > > > > > 
> > > > > > > Now we only need to track s_mb_last_group and no longer need to track
> > > > > > > s_mb_last_start, so we don't need the s_md_lock lock to ensure that the
> > > > > > > two are consistent, and we can ensure that the s_mb_last_group read is up
> > > > > > > to date by using smp_store_release/smp_load_acquire.
> > > > > > > 
> > > > > > > Besides, the s_mb_last_group data type only requires ext4_group_t
> > > > > > > (i.e., unsigned int), rendering unsigned long superfluous.
> > > > > > > 
> > > > > > > Performance test data follows:
> > > > > > > 
> > > > > > > Test: Running will-it-scale/fallocate2 on CPU-bound containers.
> > > > > > > Observation: Average fallocate operations per container per second.
> > > > > > > 
> > > > > > >                       | Kunpeng 920 / 512GB -P80|  AMD 9654 / 1536GB -P96 |
> > > > > > >     Disk: 960GB SSD   |-------------------------|-------------------------|
> > > > > > >                       | base  |    patched      | base  |    patched      |
> > > > > > > -------------------|-------|-----------------|-------|-----------------|
> > > > > > > mb_optimize_scan=0 | 4821  | 7612  (+57.8%)  | 15371 | 21647 (+40.8%)  |
> > > > > > > mb_optimize_scan=1 | 4784  | 7568  (+58.1%)  | 6101  | 9117  (+49.4%)  |
> > > > > > > 
> > > > > > > Signed-off-by: Baokun Li <libaokun1@huawei.com>
> > > > > > ...
> > > > > > 
> > > > > > > diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> > > > > > > index 5cdae3bda072..3f103919868b 100644
> > > > > > > --- a/fs/ext4/mballoc.c
> > > > > > > +++ b/fs/ext4/mballoc.c
> > > > > > > @@ -2168,11 +2168,9 @@ static void ext4_mb_use_best_found(struct ext4_allocation_context *ac,
> > > > > > >     	ac->ac_buddy_folio = e4b->bd_buddy_folio;
> > > > > > >     	folio_get(ac->ac_buddy_folio);
> > > > > > >     	/* store last allocated for subsequent stream allocation */
> > > > > > > -	if (ac->ac_flags & EXT4_MB_STREAM_ALLOC) {
> > > > > > > -		spin_lock(&sbi->s_md_lock);
> > > > > > > -		sbi->s_mb_last_group = ac->ac_f_ex.fe_group;
> > > > > > > -		spin_unlock(&sbi->s_md_lock);
> > > > > > > -	}
> > > > > > > +	if (ac->ac_flags & EXT4_MB_STREAM_ALLOC)
> > > > > > > +		/* pairs with smp_load_acquire in ext4_mb_regular_allocator() */
> > > > > > > +		smp_store_release(&sbi->s_mb_last_group, ac->ac_f_ex.fe_group);
> > > > > > Do you really need any kind of barrier (implied by smp_store_release())
> > > > > > here? I mean the store to s_mb_last_group is perfectly fine to be reordered
> > > > > > with other accesses from the thread, isn't it? As such it should be enough
> > > > > > to have WRITE_ONCE() here...
> > > > > WRITE_ONCE()/READ_ONCE() primarily prevent compiler reordering and ensure
> > > > > that variable reads/writes access values directly from L1/L2 cache rather
> > > > > than registers.
> > > > I agree READ_ONCE() / WRITE_ONCE() are about compiler optimizations - in
> > > > particular they force the compiler to read / write the memory location
> > > > exactly once instead of reading it potentially multiple times in different
> > > > parts of expression and getting inconsistent values, or possibly writing
> > > > the value say byte by byte (yes, that would be insane but not contrary to
> > > > the C standard).
> > > READ_ONCE() and WRITE_ONCE() rely on the volatile keyword, which serves
> > > two main purposes:
> > > 
> > > 1. It tells the compiler that the variable's value can change unexpectedly,
> > >     preventing the compiler from making incorrect optimizations based on
> > >     assumptions about its stability.
> > > 
> > > 2. It ensures the CPU directly reads from or writes to the variable's
> > >     memory address. This means the value will be fetched from cache (L1/L2)
> > >     if available, or from main memory otherwise, rather than using a stale
> > >     value from a CPU register.
> > Yes, we agree on this.
> > 
> > > > > They do not guarantee that other CPUs see the latest values. Reading stale
> > > > > values could lead to more useless traversals, which might incur higher
> > > > > overhead than memory barriers. This is why we use memory barriers to ensure
> > > > > the latest values are read.
> > > > But smp_load_acquire() / smp_store_release() have no guarantee about CPU
> > > > seeing latest values either. They are just speculation barriers meaning
> > > > they prevent the CPU from reordering accesses in the code after
> > > > smp_load_acquire() to be performed before the smp_load_acquire() is
> > > > executed and similarly with smp_store_release(). So I dare to say that
> > > > these barries have no (positive) impact on the allocation performance and
> > > > just complicate the code - but if you have some data that show otherwise,
> > > > I'd be happy to be proven wrong.
> > > smp_load_acquire() / smp_store_release() guarantee that CPUs read the
> > > latest data.
> > > 
> > > For example, imagine a variable a = 0, with both CPU0 and CPU1 having
> > > a=0 in their caches.
> > > 
> > > Without a memory barrier:
> > > When CPU0 executes WRITE_ONCE(a, 1), a=1 is written to the store buffer,
> > > an RFO is broadcast, and CPU0 continues other tasks. After receiving ACKs,
> > > a=1 is written to main memory and becomes visible to other CPUs.
> > > Then, if CPU1 executes READ_ONCE(a), it receives the RFO and adds it to
> > > its invalidation queue. However, it might not process it immediately;
> > > instead, it could perform the read first, potentially still reading a=0
> > > from its cache.
> > > 
> > > With a memory barrier:
> > > When CPU0 executes smp_store_release(&a, 1), a=1 is not only written to
> > > the store buffer, but data in the store buffer is also written to main
> > > memory. An RFO is then broadcast, and CPU0 waits for ACKs from all CPUs.
> > > 
> > > When CPU1 executes smp_load_acquire(a), it receives the RFO and adds it
> > > to its invalidation queue. Here, the invalidation queue is flushed, which
> > > invalidates a in CPU1's cache. CPU1 then replies with an ACK, and when it
> > > performs the read, its cache is invalid, so it reads the latest a=1 from
> > > main memory.
> > Well, here I think you assume way more about the CPU architecture than is
> > generally true (and I didn't find what you write above guaranteed neither
> > by x86 nor by arm64 CPU documentation). Generally I'm following the
> > guarantees as defined by Documentation/memory-barriers.txt and there you
> > can argue only about order of effects as observed by different CPUs but not
> > really about when content is fetched to / from CPU caches.
> 
> Explaining why smp_load_acquire() and smp_store_release() guarantee the
> latest data is read truly requires delving into their underlying
> implementation details.
> 
> I suggest you Google "why memory barriers are needed." You might find
> introductions to concepts like 'Total Store Order', 'Weak Memory Ordering',
> MESI, store buffers, and invalidate queue, along with the stories behind
> them.

Yes, I know these things. Not that I'd be really an expert in them but I'd
call myself familiar enough :). But that is kind of besides the point here.
What I want to point out it that if you have code like:

  some access A
  grp = smp_load_acquire(&sbi->s_mb_last_group)
  some more accesses

then the CPU is fully within it's right to execute them as:

  grp = smp_load_acquire(&sbi->s_mb_last_group)
  some access A
  some more accesses

Now your *particular implementation* of the ARM64 CPU model may never do
that similarly as no x86 CPU currently does it but some other CPU
implementation may (e.g. Alpha CPU probably would, as much as that's
irrevelent these days :). So using smp_load_acquire() is at best a
heuristics that may happen to help using more fresh value for some CPU
models but it isn't guaranteed to help for all architectures and all CPU
models Linux supports.

So can you do me a favor please and do a performance comparison of using
READ_ONCE / WRITE_ONCE vs using smp_load_acquire / smp_store_release on
your Arm64 server for streaming goal management? If smp_load_acquire /
smp_store_release indeed bring any performance benefit for your servers, we
can just stick a comment there explaining why they are used. If they bring
no measurable benefit I'd put READ_ONCE / WRITE_ONCE there for code
simplicity. Do you agree?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

