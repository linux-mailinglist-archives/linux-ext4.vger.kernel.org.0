Return-Path: <linux-ext4+bounces-8229-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C564AC7E32
	for <lists+linux-ext4@lfdr.de>; Thu, 29 May 2025 14:57:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0CA54E4AEF
	for <lists+linux-ext4@lfdr.de>; Thu, 29 May 2025 12:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 940AB224AEF;
	Thu, 29 May 2025 12:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sGAVOtQs";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="sdK3QCQK";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sGAVOtQs";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="sdK3QCQK"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDA721421E
	for <linux-ext4@vger.kernel.org>; Thu, 29 May 2025 12:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748523420; cv=none; b=oGUW1dKnrlUMYT/1fLcb+/mzAo4FA96oHBoQTEqjJ9K8dGMYNAKifpAKc1NgDSDONay9LXEbiTL/EyQr+6tPj88NfmO4At4kFZTjSpY3c3jWH9DjoaVp6I5vlTfASa9yQPjNWEBG6L58wDiGdc8fVr16RkA/i9D1lQHBEzj82wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748523420; c=relaxed/simple;
	bh=319J1P+OJhXxIWO+wIzDMbTzEt3aXDCCltCjs0ffe58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rc8v0iXHApdzOiBKZIvsXCd2WlTgF2Gp1KUPX0j62qXXbG4FHZgX7ywcQGva5Py6dzgehVvXPc7KPq1keCXvW/g3Af7cRxWXy2iXNMoCfK4VsapoKSIINdlbiBWXEeE4UZZywyJZzU1y/D3+kMGe7nBDUn625WoK9MdpxUzbsV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=sGAVOtQs; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=sdK3QCQK; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=sGAVOtQs; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=sdK3QCQK; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 865F421EBF;
	Thu, 29 May 2025 12:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1748523416; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l5E7n7pfFDehIJQEacIYyiEeuI8RxF7fS+NAow+HFPk=;
	b=sGAVOtQsc++IHk/zT14hVXQzFNFYVbVQUl/420K7MMcSylRmePV8u1BOD1OxpOTglK+t4j
	8UfQvPaiyBFrcJ5sUt7DnfisSAWX/N53g05GhMUo5ux5AHSGRr/Vr7f8DAbSV7WPpNJhRP
	hTIaaWLR3CnXAXaDy3VjbBxCbF+toAo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1748523416;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l5E7n7pfFDehIJQEacIYyiEeuI8RxF7fS+NAow+HFPk=;
	b=sdK3QCQKNIhVNILHHa3mh10zYRRPviYQr/dQ7Q3yjzzJWjPAUSmFJZlVSDbEKnkghHbwDH
	nTOlaYXRBqsM2fCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1748523416; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l5E7n7pfFDehIJQEacIYyiEeuI8RxF7fS+NAow+HFPk=;
	b=sGAVOtQsc++IHk/zT14hVXQzFNFYVbVQUl/420K7MMcSylRmePV8u1BOD1OxpOTglK+t4j
	8UfQvPaiyBFrcJ5sUt7DnfisSAWX/N53g05GhMUo5ux5AHSGRr/Vr7f8DAbSV7WPpNJhRP
	hTIaaWLR3CnXAXaDy3VjbBxCbF+toAo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1748523416;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l5E7n7pfFDehIJQEacIYyiEeuI8RxF7fS+NAow+HFPk=;
	b=sdK3QCQKNIhVNILHHa3mh10zYRRPviYQr/dQ7Q3yjzzJWjPAUSmFJZlVSDbEKnkghHbwDH
	nTOlaYXRBqsM2fCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7D3FC136E0;
	Thu, 29 May 2025 12:56:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id shSPHphZOGitLQAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 29 May 2025 12:56:56 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 362CFA09B5; Thu, 29 May 2025 14:56:48 +0200 (CEST)
Date: Thu, 29 May 2025 14:56:48 +0200
From: Jan Kara <jack@suse.cz>
To: libaokun@huaweicloud.com
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca, 
	jack@suse.cz, linux-kernel@vger.kernel.org, yi.zhang@huawei.com, 
	yangerkun@huawei.com, libaokun1@huawei.com
Subject: Re: [PATCH 2/4] ext4: move mb_last_[group|start] to ext4_inode_info
Message-ID: <afjkyrm4y5mp5p72ew3ddqma7v4gkmjqdkcloeaidcj55ruami@zfkn6dzgqfwh>
References: <20250523085821.1329392-1-libaokun@huaweicloud.com>
 <20250523085821.1329392-3-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250523085821.1329392-3-libaokun@huaweicloud.com>
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Level: 

On Fri 23-05-25 16:58:19, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 
> After we optimized the block group lock, we found another lock
> contention issue when running will-it-scale/fallocate2 with multiple
> processes. The fallocate's block allocation and the truncate's block
> release were fighting over the s_md_lock. The problem is, this lock
> protects totally different things in those two processes: the list of
> freed data blocks (s_freed_data_list) when releasing, and where to start
> looking for new blocks (mb_last_[group|start]) when allocating.
> 
> Moreover, when allocating data blocks, if the first try (goal allocation)
> fails and stream allocation is on, it tries a global goal starting from
> the last group we used (s_mb_last_group). This can make things faster by
> writing blocks close together on the disk. But when many processes are
> allocating, they all fight over s_md_lock and might even try to use the
> same group. This makes it harder to merge extents and can make files more
> fragmented. If different processes allocate chunks of very different sizes,
> the free space on the disk can also get fragmented. A small allocation
> might fit in a partially full group, but a big allocation might have
> skipped it, leading to the small IO ending up in a more empty group.
> 
> So, we're changing stream allocation to work per inode. First, it tries
> the goal, then the last group where that inode successfully allocated a
> block. This keeps an inode's data closer together. Plus, after moving
> mb_last_[group|start] to ext4_inode_info, we don't need s_md_lock during
> block allocation anymore because we already have the write lock on
> i_data_sem. This gets rid of the contention between allocating and
> releasing blocks, which gives a huge performance boost to fallocate2.
> 
> Performance test data follows:
> 
> CPU: HUAWEI Kunpeng 920
> Memory: 480GB
> Disk: 480GB SSD SATA 3.2
> Test: Running will-it-scale/fallocate2 on 64 CPU-bound containers.
> Observation: Average fallocate operations per container per second.
> 
>                       base     patched
> mb_optimize_scan=0    6755     23280 (+244.6%)
> mb_optimize_scan=1    4302     10430 (+142.4%)
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Good spotting with the s_md_lock contention here. But your changes don't
quite make sense to me. The idea of streaming allocation in mballoc is to
have an area of filesystem for large files to reduce fragmentation.  When
you switch to per-inode, this effect of packing large files together goes
away. Futhermore for each inode either all allocations will be very likely
streaming or not streaming (the logic uses file size) so either your
per-inode target will be unused or just another constantly used copy of
goal value.

So I can see two sensible solutions here:
a) Drop streaming allocations support altogether.

b) Enhance streaming allocation support to avoid contention between
processes allocating in parallel and freeing. Frankly, there's no strong
reason why reads & writes of streaming allocation goal need to use a
spinlock AFAICS. We could just store a physical block number and use
atomic64 accessors for it? Also having single goal value is just causing
more contention on group locks for parallel writers that end up using it
(that's the problem I suspect you were hitting the most). So perhaps we
can keep multiple streaming goal slots in the superblock (scale the count
based on CPU count & filesystem group count) and just pick the slot based
on inode number hash to reduce contention?

								Honza

> ---
>  fs/ext4/ext4.h    |  7 ++++---
>  fs/ext4/mballoc.c | 20 +++++++++-----------
>  fs/ext4/super.c   |  2 ++
>  3 files changed, 15 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 9c665a620a46..16c14dd09df6 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -1171,6 +1171,10 @@ struct ext4_inode_info {
>  	__u32 i_csum_seed;
>  
>  	kprojid_t i_projid;
> +
> +	/* where last allocation was done - for stream allocation */
> +	ext4_group_t i_mb_last_group;
> +	ext4_grpblk_t i_mb_last_start;
>  };
>  
>  /*
> @@ -1603,9 +1607,6 @@ struct ext4_sb_info {
>  	unsigned int s_mb_order2_reqs;
>  	unsigned int s_mb_group_prealloc;
>  	unsigned int s_max_dir_size_kb;
> -	/* where last allocation was done - for stream allocation */
> -	unsigned long s_mb_last_group;
> -	unsigned long s_mb_last_start;
>  	unsigned int s_mb_prefetch;
>  	unsigned int s_mb_prefetch_limit;
>  	unsigned int s_mb_best_avail_max_trim_order;
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 5c13d9f8a1cc..ee9696f9bac8 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -2138,7 +2138,6 @@ static int mb_mark_used(struct ext4_buddy *e4b, struct ext4_free_extent *ex)
>  static void ext4_mb_use_best_found(struct ext4_allocation_context *ac,
>  					struct ext4_buddy *e4b)
>  {
> -	struct ext4_sb_info *sbi = EXT4_SB(ac->ac_sb);
>  	int ret;
>  
>  	BUG_ON(ac->ac_b_ex.fe_group != e4b->bd_group);
> @@ -2169,10 +2168,8 @@ static void ext4_mb_use_best_found(struct ext4_allocation_context *ac,
>  	folio_get(ac->ac_buddy_folio);
>  	/* store last allocated for subsequent stream allocation */
>  	if (ac->ac_flags & EXT4_MB_STREAM_ALLOC) {
> -		spin_lock(&sbi->s_md_lock);
> -		sbi->s_mb_last_group = ac->ac_f_ex.fe_group;
> -		sbi->s_mb_last_start = ac->ac_f_ex.fe_start;
> -		spin_unlock(&sbi->s_md_lock);
> +		EXT4_I(ac->ac_inode)->i_mb_last_group = ac->ac_f_ex.fe_group;
> +		EXT4_I(ac->ac_inode)->i_mb_last_start = ac->ac_f_ex.fe_start;
>  	}
>  	/*
>  	 * As we've just preallocated more space than
> @@ -2844,13 +2841,14 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
>  							   MB_NUM_ORDERS(sb));
>  	}
>  
> -	/* if stream allocation is enabled, use global goal */
> +	/* if stream allocation is enabled, use last goal */
>  	if (ac->ac_flags & EXT4_MB_STREAM_ALLOC) {
> -		/* TBD: may be hot point */
> -		spin_lock(&sbi->s_md_lock);
> -		ac->ac_g_ex.fe_group = sbi->s_mb_last_group;
> -		ac->ac_g_ex.fe_start = sbi->s_mb_last_start;
> -		spin_unlock(&sbi->s_md_lock);
> +		struct ext4_inode_info *ei = EXT4_I(ac->ac_inode);
> +
> +		if (ei->i_mb_last_group || ei->i_mb_last_start) {
> +			ac->ac_g_ex.fe_group = ei->i_mb_last_group;
> +			ac->ac_g_ex.fe_start = ei->i_mb_last_start;
> +		}
>  	}
>  
>  	/*
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 181934499624..6c49c43bb2cb 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -1416,6 +1416,8 @@ static struct inode *ext4_alloc_inode(struct super_block *sb)
>  	INIT_WORK(&ei->i_rsv_conversion_work, ext4_end_io_rsv_work);
>  	ext4_fc_init_inode(&ei->vfs_inode);
>  	mutex_init(&ei->i_fc_lock);
> +	ei->i_mb_last_group = 0;
> +	ei->i_mb_last_start = 0;
>  	return &ei->vfs_inode;
>  }
>  
> -- 
> 2.46.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

