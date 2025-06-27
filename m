Return-Path: <linux-ext4+bounces-8684-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A371AEC004
	for <lists+linux-ext4@lfdr.de>; Fri, 27 Jun 2025 21:35:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF0F6168845
	for <lists+linux-ext4@lfdr.de>; Fri, 27 Jun 2025 19:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12A9C20C001;
	Fri, 27 Jun 2025 19:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="m5nR2kfT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5Pnlu9zE";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="m5nR2kfT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5Pnlu9zE"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1132A202F7C
	for <linux-ext4@vger.kernel.org>; Fri, 27 Jun 2025 19:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751052893; cv=none; b=N6QJMApurwNpAgDjPdJNcQ3RSTID/ZnZ7LHX+dkBVhHm/8aDtKsThqpptZAyb5hcLgHLESno39TNeKADyOY1ABooGHTSuRdKb1GgXlB1MmFib6Y5KPAu0TXFypetG9vWe/mQ695A5opfcfe1iXyojYgxFe5VMrXE5w1vtAFVD74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751052893; c=relaxed/simple;
	bh=x2btc7zpsPfEH8LJTiqnoU8xEsX4OQijHFTLD8cKJ84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Txd4BdNdA+Qo1IDcrkqW/8nKbGHWq9OsUJEhLoBwHWaF8f0XbfKrlvYbJkV0Tjb4E543lGKL+pWQiGs/NxeVudt0Pk/7xsaalDMUw5iUqoZa0ZLFNXPthBGLdde4098yooJxqKhQQEH+WCDSeWU59xHQcbyPIwBVglzPLkhPfWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=m5nR2kfT; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5Pnlu9zE; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=m5nR2kfT; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5Pnlu9zE; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2D11521180;
	Fri, 27 Jun 2025 19:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751052890; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jP2THP74KFsduCJsyg6L0wSX1PMWOGo99jfXkrSBM3I=;
	b=m5nR2kfTy84+NOdliWdMFhoUxhtbRJvmi0SE+iOc9BUJwijTbDRhTu4E6cA/2rUwJ7P3I1
	AcC2g1R+bkxDCB5VTc/i8CFwSsUUPH74c44L+TZZc3l/ztVbadmjWIVMtvb+XFL+rbX55W
	kQNrLHjeyVSxMhgh7k69zd9Ocpf70og=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751052890;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jP2THP74KFsduCJsyg6L0wSX1PMWOGo99jfXkrSBM3I=;
	b=5Pnlu9zEcK1plO+kck/0GmbYf7n+g/gIHyu2AMIjKGS3pq3XQazyUwYKcdSCmkKU+UA34/
	lM38SX+y+KgzEDAw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=m5nR2kfT;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=5Pnlu9zE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751052890; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jP2THP74KFsduCJsyg6L0wSX1PMWOGo99jfXkrSBM3I=;
	b=m5nR2kfTy84+NOdliWdMFhoUxhtbRJvmi0SE+iOc9BUJwijTbDRhTu4E6cA/2rUwJ7P3I1
	AcC2g1R+bkxDCB5VTc/i8CFwSsUUPH74c44L+TZZc3l/ztVbadmjWIVMtvb+XFL+rbX55W
	kQNrLHjeyVSxMhgh7k69zd9Ocpf70og=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751052890;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jP2THP74KFsduCJsyg6L0wSX1PMWOGo99jfXkrSBM3I=;
	b=5Pnlu9zEcK1plO+kck/0GmbYf7n+g/gIHyu2AMIjKGS3pq3XQazyUwYKcdSCmkKU+UA34/
	lM38SX+y+KgzEDAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A3FB9138A7;
	Fri, 27 Jun 2025 19:34:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IwkGKFnyXmiwJAAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 27 Jun 2025 19:34:49 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 152D9A08D2; Fri, 27 Jun 2025 21:34:45 +0200 (CEST)
Date: Fri, 27 Jun 2025 21:34:45 +0200
From: Jan Kara <jack@suse.cz>
To: Baokun Li <libaokun1@huawei.com>
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, jack@suse.cz, 
	adilger.kernel@dilger.ca, ojaswin@linux.ibm.com, linux-kernel@vger.kernel.org, 
	yi.zhang@huawei.com, yangerkun@huawei.com, stable@vger.kernel.org
Subject: Re: [PATCH v2 10/16] ext4: fix largest free orders lists corruption
 on mb_optimize_scan switch
Message-ID: <a4rctz75l4c6vejweqq67ptzojs276eicqp6kqegpxinirk32n@dnhg6h4pbvdr>
References: <20250623073304.3275702-1-libaokun1@huawei.com>
 <20250623073304.3275702-11-libaokun1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250623073304.3275702-11-libaokun1@huawei.com>
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 2D11521180
X-Rspamd-Action: no action
X-Spam-Flag: NO
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
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Score: -4.01
X-Spam-Level: 

On Mon 23-06-25 15:32:58, Baokun Li wrote:
> The grp->bb_largest_free_order is updated regardless of whether
> mb_optimize_scan is enabled. This can lead to inconsistencies between
> grp->bb_largest_free_order and the actual s_mb_largest_free_orders list
> index when mb_optimize_scan is repeatedly enabled and disabled via remount.
> 
> For example, if mb_optimize_scan is initially enabled, largest free
> order is 3, and the group is in s_mb_largest_free_orders[3]. Then,
> mb_optimize_scan is disabled via remount, block allocations occur,
> updating largest free order to 2. Finally, mb_optimize_scan is re-enabled
> via remount, more block allocations update largest free order to 1.
> 
> At this point, the group would be removed from s_mb_largest_free_orders[3]
> under the protection of s_mb_largest_free_orders_locks[2]. This lock
> mismatch can lead to list corruption.
> 
> To fix this, a new field bb_largest_free_order_idx is added to struct
> ext4_group_info to explicitly track the list index. Then still update
> bb_largest_free_order unconditionally, but only update
> bb_largest_free_order_idx when mb_optimize_scan is enabled. so that there
> is no inconsistency between the lock and the data to be protected.
> 
> Fixes: 196e402adf2e ("ext4: improve cr 0 / cr 1 group scanning")
> CC: stable@vger.kernel.org
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Hum, rather than duplicating index like this, couldn't we add to
mb_set_largest_free_order():

	/* Did mb_optimize_scan setting change? */
	if (!test_opt2(sb, MB_OPTIMIZE_SCAN) &&
	    !list_empty(&grp->bb_largest_free_order_node)) {
		write_lock(&sbi->s_mb_largest_free_orders_locks[old]);
		list_del_init(&grp->bb_largest_free_order_node);
		write_unlock(&sbi->s_mb_largest_free_orders_locks[old]);
	}

Also arguably we should reinit bb lists when mb_optimize_scan gets
reenabled because otherwise inconsistent lists could lead to suboptimal
results... But that's less important to fix I guess.

								Honza

> ---
>  fs/ext4/ext4.h    |  1 +
>  fs/ext4/mballoc.c | 35 ++++++++++++++++-------------------
>  2 files changed, 17 insertions(+), 19 deletions(-)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 003b8d3726e8..0e574378c6a3 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -3476,6 +3476,7 @@ struct ext4_group_info {
>  	int		bb_avg_fragment_size_order;	/* order of average
>  							   fragment in BG */
>  	ext4_grpblk_t	bb_largest_free_order;/* order of largest frag in BG */
> +	ext4_grpblk_t	bb_largest_free_order_idx; /* index of largest frag */
>  	ext4_group_t	bb_group;	/* Group number */
>  	struct          list_head bb_prealloc_list;
>  #ifdef DOUBLE_CHECK
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index e6d6c2da3c6e..dc82124f0905 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -1152,33 +1152,29 @@ static void
>  mb_set_largest_free_order(struct super_block *sb, struct ext4_group_info *grp)
>  {
>  	struct ext4_sb_info *sbi = EXT4_SB(sb);
> -	int i;
> +	int new, old = grp->bb_largest_free_order_idx;
>  
> -	for (i = MB_NUM_ORDERS(sb) - 1; i >= 0; i--)
> -		if (grp->bb_counters[i] > 0)
> +	for (new = MB_NUM_ORDERS(sb) - 1; new >= 0; new--)
> +		if (grp->bb_counters[new] > 0)
>  			break;
> +
> +	grp->bb_largest_free_order = new;
>  	/* No need to move between order lists? */
> -	if (!test_opt2(sb, MB_OPTIMIZE_SCAN) ||
> -	    i == grp->bb_largest_free_order) {
> -		grp->bb_largest_free_order = i;
> +	if (!test_opt2(sb, MB_OPTIMIZE_SCAN) || new == old)
>  		return;
> -	}
>  
> -	if (grp->bb_largest_free_order >= 0) {
> -		write_lock(&sbi->s_mb_largest_free_orders_locks[
> -					      grp->bb_largest_free_order]);
> +	if (old >= 0) {
> +		write_lock(&sbi->s_mb_largest_free_orders_locks[old]);
>  		list_del_init(&grp->bb_largest_free_order_node);
> -		write_unlock(&sbi->s_mb_largest_free_orders_locks[
> -					      grp->bb_largest_free_order]);
> +		write_unlock(&sbi->s_mb_largest_free_orders_locks[old]);
>  	}
> -	grp->bb_largest_free_order = i;
> -	if (grp->bb_largest_free_order >= 0 && grp->bb_free) {
> -		write_lock(&sbi->s_mb_largest_free_orders_locks[
> -					      grp->bb_largest_free_order]);
> +
> +	grp->bb_largest_free_order_idx = new;
> +	if (new >= 0 && grp->bb_free) {
> +		write_lock(&sbi->s_mb_largest_free_orders_locks[new]);
>  		list_add_tail(&grp->bb_largest_free_order_node,
> -		      &sbi->s_mb_largest_free_orders[grp->bb_largest_free_order]);
> -		write_unlock(&sbi->s_mb_largest_free_orders_locks[
> -					      grp->bb_largest_free_order]);
> +			      &sbi->s_mb_largest_free_orders[new]);
> +		write_unlock(&sbi->s_mb_largest_free_orders_locks[new]);
>  	}
>  }
>  
> @@ -3391,6 +3387,7 @@ int ext4_mb_add_groupinfo(struct super_block *sb, ext4_group_t group,
>  	INIT_LIST_HEAD(&meta_group_info[i]->bb_avg_fragment_size_node);
>  	meta_group_info[i]->bb_largest_free_order = -1;  /* uninit */
>  	meta_group_info[i]->bb_avg_fragment_size_order = -1;  /* uninit */
> +	meta_group_info[i]->bb_largest_free_order_idx = -1;  /* uninit */
>  	meta_group_info[i]->bb_group = group;
>  
>  	mb_group_bb_bitmap_alloc(sb, meta_group_info[i], group);
> -- 
> 2.46.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

