Return-Path: <linux-ext4+bounces-8679-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30BD1AEBEFC
	for <lists+linux-ext4@lfdr.de>; Fri, 27 Jun 2025 20:19:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BB01170E91
	for <lists+linux-ext4@lfdr.de>; Fri, 27 Jun 2025 18:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A7CD2E92CA;
	Fri, 27 Jun 2025 18:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ij/01L0i";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="6xzzM48p";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ij/01L0i";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="6xzzM48p"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D051DF271
	for <linux-ext4@vger.kernel.org>; Fri, 27 Jun 2025 18:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751048387; cv=none; b=nO3cAjzNdeCN+VJ9E79ZwvrYBUcIZPqZKi59b8Qr+mUQVgIyQXhMOsmwek6yz9cYm4IpQmQRu5Evb48X+NNgnJDDoE/bf806fFPRE75nhxBFUFprX4NhG1nO1UbRiozWWmglRg/5PCatC0xcZeeyfwqRoKz0Ny9fR7P3tif0DRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751048387; c=relaxed/simple;
	bh=GNw2x8TmxK4nenHqFgTHG2Xadt40+zHebHyHfByQYZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cjfNCrCw2RA+NAY0xgvZ7BVgGDjjaHb2NKJkrLj4Yy3SZknFGyQdMCow+YN/+PrnRxJrCIgcA0V2I4D1tG/k8D412mkNK2CNUjaPpTCCWULyn15qARy7E/yUfaPR+Gcu7E41BtdKlOmuJRhUn2nmNyQPplDoUZKebSwqqQA6QP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ij/01L0i; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=6xzzM48p; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ij/01L0i; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=6xzzM48p; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AC0C01F38C;
	Fri, 27 Jun 2025 18:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751048381; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I/X5wdqHTDbrLu538w/pMOYF4gx2cyKGvTIJJruMnIE=;
	b=ij/01L0i8EbYvrFv3/9MBLabmX1D8E+kGe/1IU1rGWg4BZ/amEpQLXkrVNT5N59iZwPXqA
	n04jmFyuBVZ3ZzFAJ+ev5puGPHp5H2ow4v4uhnEtF4iih0PT/BFIBVMwB+iTygyFba5Oby
	BNM57w8z8kbq8qr+I8wYgl3UpOmrpsU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751048381;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I/X5wdqHTDbrLu538w/pMOYF4gx2cyKGvTIJJruMnIE=;
	b=6xzzM48p0+YaQSN2UMkdKUW2qMWCQXktmH9hk8k/gMAmgcZahHYWTlSfvvINRWmF+KuCKY
	qqlK+5AX0vKYQPDw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="ij/01L0i";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=6xzzM48p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751048381; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I/X5wdqHTDbrLu538w/pMOYF4gx2cyKGvTIJJruMnIE=;
	b=ij/01L0i8EbYvrFv3/9MBLabmX1D8E+kGe/1IU1rGWg4BZ/amEpQLXkrVNT5N59iZwPXqA
	n04jmFyuBVZ3ZzFAJ+ev5puGPHp5H2ow4v4uhnEtF4iih0PT/BFIBVMwB+iTygyFba5Oby
	BNM57w8z8kbq8qr+I8wYgl3UpOmrpsU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751048381;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I/X5wdqHTDbrLu538w/pMOYF4gx2cyKGvTIJJruMnIE=;
	b=6xzzM48p0+YaQSN2UMkdKUW2qMWCQXktmH9hk8k/gMAmgcZahHYWTlSfvvINRWmF+KuCKY
	qqlK+5AX0vKYQPDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8A71113786;
	Fri, 27 Jun 2025 18:19:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /UeHIb3gXmj0EQAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 27 Jun 2025 18:19:41 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id EE8EAA08D2; Fri, 27 Jun 2025 20:19:40 +0200 (CEST)
Date: Fri, 27 Jun 2025 20:19:40 +0200
From: Jan Kara <jack@suse.cz>
To: Baokun Li <libaokun1@huawei.com>
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, jack@suse.cz, 
	adilger.kernel@dilger.ca, ojaswin@linux.ibm.com, linux-kernel@vger.kernel.org, 
	yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH v2 03/16] ext4: remove unnecessary s_md_lock on update
 s_mb_last_group
Message-ID: <xlzlyqudvp7a6ufdvc4rgsoe7ty425rrexuxgfbgwxoazfjd25@6eqbh66w7ayr>
References: <20250623073304.3275702-1-libaokun1@huawei.com>
 <20250623073304.3275702-4-libaokun1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250623073304.3275702-4-libaokun1@huawei.com>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,huawei.com:email];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: AC0C01F38C
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -4.01

On Mon 23-06-25 15:32:51, Baokun Li wrote:
> After we optimized the block group lock, we found another lock
> contention issue when running will-it-scale/fallocate2 with multiple
> processes. The fallocate's block allocation and the truncate's block
> release were fighting over the s_md_lock. The problem is, this lock
> protects totally different things in those two processes: the list of
> freed data blocks (s_freed_data_list) when releasing, and where to start
> looking for new blocks (mb_last_group) when allocating.
> 
> Now we only need to track s_mb_last_group and no longer need to track
> s_mb_last_start, so we don't need the s_md_lock lock to ensure that the
> two are consistent, and we can ensure that the s_mb_last_group read is up
> to date by using smp_store_release/smp_load_acquire.
> 
> Besides, the s_mb_last_group data type only requires ext4_group_t
> (i.e., unsigned int), rendering unsigned long superfluous.
> 
> Performance test data follows:
> 
> Test: Running will-it-scale/fallocate2 on CPU-bound containers.
> Observation: Average fallocate operations per container per second.
> 
>                    | Kunpeng 920 / 512GB -P80|  AMD 9654 / 1536GB -P96 |
>  Disk: 960GB SSD   |-------------------------|-------------------------|
>                    | base  |    patched      | base  |    patched      |
> -------------------|-------|-----------------|-------|-----------------|
> mb_optimize_scan=0 | 4821  | 7612  (+57.8%)  | 15371 | 21647 (+40.8%)  |
> mb_optimize_scan=1 | 4784  | 7568  (+58.1%)  | 6101  | 9117  (+49.4%)  |
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

...

> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 5cdae3bda072..3f103919868b 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -2168,11 +2168,9 @@ static void ext4_mb_use_best_found(struct ext4_allocation_context *ac,
>  	ac->ac_buddy_folio = e4b->bd_buddy_folio;
>  	folio_get(ac->ac_buddy_folio);
>  	/* store last allocated for subsequent stream allocation */
> -	if (ac->ac_flags & EXT4_MB_STREAM_ALLOC) {
> -		spin_lock(&sbi->s_md_lock);
> -		sbi->s_mb_last_group = ac->ac_f_ex.fe_group;
> -		spin_unlock(&sbi->s_md_lock);
> -	}
> +	if (ac->ac_flags & EXT4_MB_STREAM_ALLOC)
> +		/* pairs with smp_load_acquire in ext4_mb_regular_allocator() */
> +		smp_store_release(&sbi->s_mb_last_group, ac->ac_f_ex.fe_group);

Do you really need any kind of barrier (implied by smp_store_release())
here? I mean the store to s_mb_last_group is perfectly fine to be reordered
with other accesses from the thread, isn't it? As such it should be enough
to have WRITE_ONCE() here...

>  	/*
>  	 * As we've just preallocated more space than
>  	 * user requested originally, we store allocated
> @@ -2844,12 +2842,9 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
>  	}
>  
>  	/* if stream allocation is enabled, use global goal */
> -	if (ac->ac_flags & EXT4_MB_STREAM_ALLOC) {
> -		/* TBD: may be hot point */
> -		spin_lock(&sbi->s_md_lock);
> -		ac->ac_g_ex.fe_group = sbi->s_mb_last_group;
> -		spin_unlock(&sbi->s_md_lock);
> -	}
> +	if (ac->ac_flags & EXT4_MB_STREAM_ALLOC)
> +		/* pairs with smp_store_release in ext4_mb_use_best_found() */
> +		ac->ac_g_ex.fe_group = smp_load_acquire(&sbi->s_mb_last_group);

... and READ_ONCE() here.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

