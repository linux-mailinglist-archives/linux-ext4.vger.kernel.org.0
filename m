Return-Path: <linux-ext4+bounces-8682-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA66AEBF7A
	for <lists+linux-ext4@lfdr.de>; Fri, 27 Jun 2025 21:11:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47803172EB0
	for <lists+linux-ext4@lfdr.de>; Fri, 27 Jun 2025 19:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BBAD202C38;
	Fri, 27 Jun 2025 19:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PAr0Axp+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="39s8DCb7";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PAr0Axp+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="39s8DCb7"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C3F200110
	for <linux-ext4@vger.kernel.org>; Fri, 27 Jun 2025 19:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751051500; cv=none; b=YV/LvKfVjNg1+KVivJYZkw2ORi5uv5PhhUwBUePjiISOHDuNLa3dfg6U2vOylHgUlGlp7E4NsKC1NGZHAzx1r4fodIxIeU2KvXe8fiSmR3J/pjnZQIlIdqHPcaE4+lWxuyfe36uLZ0kL1w1wzYxOfue/lRmqmez5JIQqBVVLVA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751051500; c=relaxed/simple;
	bh=ceb9dt7giSkpdzaLvWyBrC2cey5gGpnzKli7QJAEgoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ya2y7vrkrvLf+oKabNYa6v4Dm+3mkG+YAC19ED88Lfk+CqC6viIIoiOHjVuQWHjd408n+77LXQz1IUwPMuQ/dMPsCtfqTmRHcrTmDGaJFFgkK61iIy+sGyfNo3vLXYGx6GQ+/MUdXPPjL84viX7mSasqd1eF3vvofQl1fg+6mC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PAr0Axp+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=39s8DCb7; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PAr0Axp+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=39s8DCb7; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9F9F321180;
	Fri, 27 Jun 2025 19:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751051496; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=21bjnz7XARCDbcBLPY8MR0klXzrVEXq4DsGpt0IuhAI=;
	b=PAr0Axp+d6pMC4npYtGzrOR51C6YXicQ24jDNYIz39L2JU0kfGe6cLE4aTmG8xhDJfjzjE
	tK66qphD5Cn5qNAKZ/BJZucgnzW88hFvv3qhDA3rJn/DY3y59+HzZKcnkRcaMvF5GtMDxQ
	gatoqe7gnI2zCiEFA+DTkDBzVd/hO4c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751051496;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=21bjnz7XARCDbcBLPY8MR0klXzrVEXq4DsGpt0IuhAI=;
	b=39s8DCb7lwoE0+/63i4SWOcpFAPM+kTK7906qyi6jk2t2MHl8eAhDo0WKDjEu8RU8p2uka
	v2TKb0+PiZbM0wCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751051496; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=21bjnz7XARCDbcBLPY8MR0klXzrVEXq4DsGpt0IuhAI=;
	b=PAr0Axp+d6pMC4npYtGzrOR51C6YXicQ24jDNYIz39L2JU0kfGe6cLE4aTmG8xhDJfjzjE
	tK66qphD5Cn5qNAKZ/BJZucgnzW88hFvv3qhDA3rJn/DY3y59+HzZKcnkRcaMvF5GtMDxQ
	gatoqe7gnI2zCiEFA+DTkDBzVd/hO4c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751051496;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=21bjnz7XARCDbcBLPY8MR0klXzrVEXq4DsGpt0IuhAI=;
	b=39s8DCb7lwoE0+/63i4SWOcpFAPM+kTK7906qyi6jk2t2MHl8eAhDo0WKDjEu8RU8p2uka
	v2TKb0+PiZbM0wCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8D9FA138A7;
	Fri, 27 Jun 2025 19:11:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3cSNIujsXmjjHgAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 27 Jun 2025 19:11:36 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 50B64A08D2; Fri, 27 Jun 2025 21:11:32 +0200 (CEST)
Date: Fri, 27 Jun 2025 21:11:32 +0200
From: Jan Kara <jack@suse.cz>
To: Baokun Li <libaokun1@huawei.com>
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, jack@suse.cz, 
	adilger.kernel@dilger.ca, ojaswin@linux.ibm.com, linux-kernel@vger.kernel.org, 
	yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH v2 08/16] ext4: merge freed extent with existing extents
 before insertion
Message-ID: <gvy6graln2rfpkaa3ms7lx7wlzzpjruzvefagsnnf3vcdfoxq7@dlsvj2gw6huk>
References: <20250623073304.3275702-1-libaokun1@huawei.com>
 <20250623073304.3275702-9-libaokun1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250623073304.3275702-9-libaokun1@huawei.com>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -3.80

On Mon 23-06-25 15:32:56, Baokun Li wrote:
> Attempt to merge ext4_free_data with already inserted free extents prior
> to adding new ones. This strategy drastically cuts down the number of
> times locks are held.
> 
> For example, if prev, new, and next extents are all mergeable, the existing
> code (before this patch) requires acquiring the s_md_lock three times:
> 
>   prev merge into new and free prev // hold lock
>   next merge into new and free next // hold lock
>   insert new // hold lock
> 
> After the patch, it only needs to be acquired once:
> 
>   new merge next and free new // no lock
>   next merge into prev and free prev // hold lock
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
> mb_optimize_scan=0 | 20982 | 21157 (+0.8%)   | 50629 | 50420 (-0.4%)   |
> mb_optimize_scan=1 | 10703 | 12896 (+20.4%)  | 14856 | 17273 (+16.2%)  |
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/mballoc.c | 113 +++++++++++++++++++++++++++++++---------------
>  1 file changed, 76 insertions(+), 37 deletions(-)
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 5410fb3688ee..94950b07a577 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -6298,28 +6298,63 @@ ext4_fsblk_t ext4_mb_new_blocks(handle_t *handle,
>   * are contiguous, AND the extents were freed by the same transaction,
>   * AND the blocks are associated with the same group.
>   */
> -static void ext4_try_merge_freed_extent(struct ext4_sb_info *sbi,
> -					struct ext4_free_data *entry,
> -					struct ext4_free_data *new_entry,
> -					struct rb_root *entry_rb_root)
> +static inline bool
> +ext4_freed_extents_can_be_merged(struct ext4_free_data *entry1,
> +				 struct ext4_free_data *entry2)
>  {
> -	if ((entry->efd_tid != new_entry->efd_tid) ||
> -	    (entry->efd_group != new_entry->efd_group))
> -		return;
> -	if (entry->efd_start_cluster + entry->efd_count ==
> -	    new_entry->efd_start_cluster) {
> -		new_entry->efd_start_cluster = entry->efd_start_cluster;
> -		new_entry->efd_count += entry->efd_count;
> -	} else if (new_entry->efd_start_cluster + new_entry->efd_count ==
> -		   entry->efd_start_cluster) {
> -		new_entry->efd_count += entry->efd_count;
> -	} else
> -		return;
> +	if (entry1->efd_tid != entry2->efd_tid)
> +		return false;
> +	if (entry1->efd_start_cluster + entry1->efd_count !=
> +	    entry2->efd_start_cluster)
> +		return false;
> +	if (WARN_ON_ONCE(entry1->efd_group != entry2->efd_group))
> +		return false;
> +	return true;
> +}
> +
> +static inline void
> +ext4_merge_freed_extents(struct ext4_sb_info *sbi, struct rb_root *root,
> +			 struct ext4_free_data *entry1,
> +			 struct ext4_free_data *entry2)
> +{
> +	entry1->efd_count += entry2->efd_count;
>  	spin_lock(&sbi->s_md_lock);
> -	list_del(&entry->efd_list);
> +	list_del(&entry2->efd_list);
>  	spin_unlock(&sbi->s_md_lock);
> -	rb_erase(&entry->efd_node, entry_rb_root);
> -	kmem_cache_free(ext4_free_data_cachep, entry);
> +	rb_erase(&entry2->efd_node, root);
> +	kmem_cache_free(ext4_free_data_cachep, entry2);
> +}
> +
> +static inline void
> +ext4_try_merge_freed_extent_prev(struct ext4_sb_info *sbi, struct rb_root *root,
> +				 struct ext4_free_data *entry)
> +{
> +	struct ext4_free_data *prev;
> +	struct rb_node *node;
> +
> +	node = rb_prev(&entry->efd_node);
> +	if (!node)
> +		return;
> +
> +	prev = rb_entry(node, struct ext4_free_data, efd_node);
> +	if (ext4_freed_extents_can_be_merged(prev, entry))
> +		ext4_merge_freed_extents(sbi, root, prev, entry);
> +}
> +
> +static inline void
> +ext4_try_merge_freed_extent_next(struct ext4_sb_info *sbi, struct rb_root *root,
> +				 struct ext4_free_data *entry)
> +{
> +	struct ext4_free_data *next;
> +	struct rb_node *node;
> +
> +	node = rb_next(&entry->efd_node);
> +	if (!node)
> +		return;
> +
> +	next = rb_entry(node, struct ext4_free_data, efd_node);
> +	if (ext4_freed_extents_can_be_merged(entry, next))
> +		ext4_merge_freed_extents(sbi, root, entry, next);
>  }
>  
>  static noinline_for_stack void
> @@ -6329,11 +6364,12 @@ ext4_mb_free_metadata(handle_t *handle, struct ext4_buddy *e4b,
>  	ext4_group_t group = e4b->bd_group;
>  	ext4_grpblk_t cluster;
>  	ext4_grpblk_t clusters = new_entry->efd_count;
> -	struct ext4_free_data *entry;
> +	struct ext4_free_data *entry = NULL;
>  	struct ext4_group_info *db = e4b->bd_info;
>  	struct super_block *sb = e4b->bd_sb;
>  	struct ext4_sb_info *sbi = EXT4_SB(sb);
> -	struct rb_node **n = &db->bb_free_root.rb_node, *node;
> +	struct rb_root *root = &db->bb_free_root;
> +	struct rb_node **n = &root->rb_node;
>  	struct rb_node *parent = NULL, *new_node;
>  
>  	BUG_ON(!ext4_handle_valid(handle));
> @@ -6369,27 +6405,30 @@ ext4_mb_free_metadata(handle_t *handle, struct ext4_buddy *e4b,
>  		}
>  	}
>  
> -	rb_link_node(new_node, parent, n);
> -	rb_insert_color(new_node, &db->bb_free_root);
> -
> -	/* Now try to see the extent can be merged to left and right */
> -	node = rb_prev(new_node);
> -	if (node) {
> -		entry = rb_entry(node, struct ext4_free_data, efd_node);
> -		ext4_try_merge_freed_extent(sbi, entry, new_entry,
> -					    &(db->bb_free_root));
> +	atomic_add(clusters, &sbi->s_mb_free_pending);
> +	if (!entry)
> +		goto insert;
> +
> +	/* Now try to see the extent can be merged to prev and next */
> +	if (ext4_freed_extents_can_be_merged(new_entry, entry)) {
> +		entry->efd_start_cluster = cluster;
> +		entry->efd_count += new_entry->efd_count;
> +		kmem_cache_free(ext4_free_data_cachep, new_entry);
> +		ext4_try_merge_freed_extent_prev(sbi, root, entry);
> +		return;
>  	}
> -
> -	node = rb_next(new_node);
> -	if (node) {
> -		entry = rb_entry(node, struct ext4_free_data, efd_node);
> -		ext4_try_merge_freed_extent(sbi, entry, new_entry,
> -					    &(db->bb_free_root));
> +	if (ext4_freed_extents_can_be_merged(entry, new_entry)) {
> +		entry->efd_count += new_entry->efd_count;
> +		kmem_cache_free(ext4_free_data_cachep, new_entry);
> +		ext4_try_merge_freed_extent_next(sbi, root, entry);
> +		return;
>  	}
> +insert:
> +	rb_link_node(new_node, parent, n);
> +	rb_insert_color(new_node, root);
>  
>  	spin_lock(&sbi->s_md_lock);
>  	list_add_tail(&new_entry->efd_list, &sbi->s_freed_data_list[new_entry->efd_tid & 1]);
> -	atomic_add(clusters, &sbi->s_mb_free_pending);
>  	spin_unlock(&sbi->s_md_lock);
>  }
>  
> -- 
> 2.46.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

