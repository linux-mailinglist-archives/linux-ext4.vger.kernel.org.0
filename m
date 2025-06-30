Return-Path: <linux-ext4+bounces-8703-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D977CAED60E
	for <lists+linux-ext4@lfdr.de>; Mon, 30 Jun 2025 09:47:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C58121898877
	for <lists+linux-ext4@lfdr.de>; Mon, 30 Jun 2025 07:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47B862376F2;
	Mon, 30 Jun 2025 07:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="E86GuxsB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rWcxBdQD";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="UrPIfwU0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="llgry64d"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F752367B9
	for <linux-ext4@vger.kernel.org>; Mon, 30 Jun 2025 07:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751269637; cv=none; b=M9Y8XrJgExL813uVQ3Dvn40SCftOk2EQcMD/ppqt+i2eWYOQC1Wr1gK5KHPb7GhetuhlFgX9MIQnyFWWvllelfE2uyKSzDAna9UQYvte0AGYRIuAmw9pFZ6AY+OPkAhb1isY0gnQ6PZMoLLHvEKII+XL5YrSIaL3+vBEz7WJjio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751269637; c=relaxed/simple;
	bh=N4/gemkwOOG9oZKd1jobRaruueJI6mhQQIOWpqNKuGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o/199siUY6NRcrejPgoAIvgJjbd0oNtg6bc/oc80cTy75CThT5ujhdwO4PLU8ZltvXUQy/Xso04l/I6HcWMl0Jq1bYAImBqaki89OFR8duRRimSWTd+8vEnUkovxdXLJz2WnHoT8o2MOsZBZvedXRWUQa51riJZxtBdJ18d3HPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=E86GuxsB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rWcxBdQD; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=UrPIfwU0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=llgry64d; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9294421161;
	Mon, 30 Jun 2025 07:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751269634; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=G0xMeV4r4NgmZRD7f2uu1EqqO6HZViLKTYU5qUxhpb0=;
	b=E86GuxsB7Lk7XJ9Y8PYu7aK+EUoPoyOT90eSY0utaqCRk3R4gVVIC1e+GobodoRf3XRRHy
	4dnZRBS/sRBTqEeeH71KMQqrEVRQfPdDB5bh5hENMS9yVhLBPXFL2XOK1L0/OP4myBZCcS
	6ItaOhRn/PHkmVNmcSuwxM89SOaLgL0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751269634;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=G0xMeV4r4NgmZRD7f2uu1EqqO6HZViLKTYU5qUxhpb0=;
	b=rWcxBdQDBMb9qf1WCRZzl+QVeNq8BQjPTsmtz3koGlqvFBn935oVtZ83oAEBvlxGPlmOTp
	U3jG4iTKax8KWrDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751269633; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=G0xMeV4r4NgmZRD7f2uu1EqqO6HZViLKTYU5qUxhpb0=;
	b=UrPIfwU0InrHCrmdmQhEs9y3FmBDiMeQeuDBKtpTkwjXxWD77YcoANZiE1qYV1SJVHIK4P
	67UGyw6dpPTx45EjJ9elrtRFNKDZ5QmDvDYy6YuVEN9IdJszrfioWvW6h5JwjmiYM1Gn+e
	RNSVYoAFQuqm4zPRy4OXs/Dk1CVs7vw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751269633;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=G0xMeV4r4NgmZRD7f2uu1EqqO6HZViLKTYU5qUxhpb0=;
	b=llgry64dSVfm6ADa4s4hLJMFBFdPJvnL6t2XbmnbKXBkuwjy1XhYe/UzSz+rvbqND0FilR
	oitzWmHnZNEi4TBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7C04013983;
	Mon, 30 Jun 2025 07:47:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id x8xCHgFBYmj8bAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 30 Jun 2025 07:47:13 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 3E2F0A08D2; Mon, 30 Jun 2025 09:47:13 +0200 (CEST)
Date: Mon, 30 Jun 2025 09:47:13 +0200
From: Jan Kara <jack@suse.cz>
To: Baokun Li <libaokun1@huawei.com>
Cc: Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org, tytso@mit.edu, 
	adilger.kernel@dilger.ca, ojaswin@linux.ibm.com, linux-kernel@vger.kernel.org, 
	yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH v2 03/16] ext4: remove unnecessary s_md_lock on update
 s_mb_last_group
Message-ID: <mfybwoygcycblgaln2j4et4zmyzli2zibcgvixysanugjjhhh5@xyzoc4juy4wv>
References: <20250623073304.3275702-1-libaokun1@huawei.com>
 <20250623073304.3275702-4-libaokun1@huawei.com>
 <xlzlyqudvp7a6ufdvc4rgsoe7ty425rrexuxgfbgwxoazfjd25@6eqbh66w7ayr>
 <1c2d7881-94bb-46ff-9cf6-ef1fbffc13e5@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c2d7881-94bb-46ff-9cf6-ef1fbffc13e5@huawei.com>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Level: 

On Mon 30-06-25 11:48:20, Baokun Li wrote:
> On 2025/6/28 2:19, Jan Kara wrote:
> > On Mon 23-06-25 15:32:51, Baokun Li wrote:
> > > After we optimized the block group lock, we found another lock
> > > contention issue when running will-it-scale/fallocate2 with multiple
> > > processes. The fallocate's block allocation and the truncate's block
> > > release were fighting over the s_md_lock. The problem is, this lock
> > > protects totally different things in those two processes: the list of
> > > freed data blocks (s_freed_data_list) when releasing, and where to start
> > > looking for new blocks (mb_last_group) when allocating.
> > > 
> > > Now we only need to track s_mb_last_group and no longer need to track
> > > s_mb_last_start, so we don't need the s_md_lock lock to ensure that the
> > > two are consistent, and we can ensure that the s_mb_last_group read is up
> > > to date by using smp_store_release/smp_load_acquire.
> > > 
> > > Besides, the s_mb_last_group data type only requires ext4_group_t
> > > (i.e., unsigned int), rendering unsigned long superfluous.
> > > 
> > > Performance test data follows:
> > > 
> > > Test: Running will-it-scale/fallocate2 on CPU-bound containers.
> > > Observation: Average fallocate operations per container per second.
> > > 
> > >                     | Kunpeng 920 / 512GB -P80|  AMD 9654 / 1536GB -P96 |
> > >   Disk: 960GB SSD   |-------------------------|-------------------------|
> > >                     | base  |    patched      | base  |    patched      |
> > > -------------------|-------|-----------------|-------|-----------------|
> > > mb_optimize_scan=0 | 4821  | 7612  (+57.8%)  | 15371 | 21647 (+40.8%)  |
> > > mb_optimize_scan=1 | 4784  | 7568  (+58.1%)  | 6101  | 9117  (+49.4%)  |
> > > 
> > > Signed-off-by: Baokun Li <libaokun1@huawei.com>
> > ...
> > 
> > > diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> > > index 5cdae3bda072..3f103919868b 100644
> > > --- a/fs/ext4/mballoc.c
> > > +++ b/fs/ext4/mballoc.c
> > > @@ -2168,11 +2168,9 @@ static void ext4_mb_use_best_found(struct ext4_allocation_context *ac,
> > >   	ac->ac_buddy_folio = e4b->bd_buddy_folio;
> > >   	folio_get(ac->ac_buddy_folio);
> > >   	/* store last allocated for subsequent stream allocation */
> > > -	if (ac->ac_flags & EXT4_MB_STREAM_ALLOC) {
> > > -		spin_lock(&sbi->s_md_lock);
> > > -		sbi->s_mb_last_group = ac->ac_f_ex.fe_group;
> > > -		spin_unlock(&sbi->s_md_lock);
> > > -	}
> > > +	if (ac->ac_flags & EXT4_MB_STREAM_ALLOC)
> > > +		/* pairs with smp_load_acquire in ext4_mb_regular_allocator() */
> > > +		smp_store_release(&sbi->s_mb_last_group, ac->ac_f_ex.fe_group);
> > Do you really need any kind of barrier (implied by smp_store_release())
> > here? I mean the store to s_mb_last_group is perfectly fine to be reordered
> > with other accesses from the thread, isn't it? As such it should be enough
> > to have WRITE_ONCE() here...
> 
> WRITE_ONCE()/READ_ONCE() primarily prevent compiler reordering and ensure
> that variable reads/writes access values directly from L1/L2 cache rather
> than registers.

I agree READ_ONCE() / WRITE_ONCE() are about compiler optimizations - in
particular they force the compiler to read / write the memory location
exactly once instead of reading it potentially multiple times in different
parts of expression and getting inconsistent values, or possibly writing
the value say byte by byte (yes, that would be insane but not contrary to
the C standard).

> They do not guarantee that other CPUs see the latest values. Reading stale
> values could lead to more useless traversals, which might incur higher
> overhead than memory barriers. This is why we use memory barriers to ensure
> the latest values are read.

But smp_load_acquire() / smp_store_release() have no guarantee about CPU
seeing latest values either. They are just speculation barriers meaning
they prevent the CPU from reordering accesses in the code after
smp_load_acquire() to be performed before the smp_load_acquire() is
executed and similarly with smp_store_release(). So I dare to say that
these barries have no (positive) impact on the allocation performance and
just complicate the code - but if you have some data that show otherwise,
I'd be happy to be proven wrong.

> If we could guarantee that each goal is used on only one CPU, we could
> switch to the cheaper WRITE_ONCE()/READ_ONCE().

Well, neither READ_ONCE() / WRITE_ONCE() nor smp_load_acquire() /
smp_store_release() can guarantee that.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

