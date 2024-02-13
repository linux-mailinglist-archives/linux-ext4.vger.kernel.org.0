Return-Path: <linux-ext4+bounces-1225-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ECC48535C0
	for <lists+linux-ext4@lfdr.de>; Tue, 13 Feb 2024 17:15:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAEAF1F24983
	for <lists+linux-ext4@lfdr.de>; Tue, 13 Feb 2024 16:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69EF45F850;
	Tue, 13 Feb 2024 16:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ssyt+A0f";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="6Ih9k2Mi";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="deDG+00k";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="T4mWZ9ak"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2772922089;
	Tue, 13 Feb 2024 16:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707840897; cv=none; b=tBpTA+/bcGGP7HZEX84XwHTrHH2rnkjoR4RMB9L8QbB/XqPKyreXaOQ27WVogzF46rHDITm+cLwW/Fh5HdLbX+4xUOzw73bUd066cjpOWMP29uuzgcGhOXbYkq7SLxO80246eh4tVOL/4ZykQjMJP0/4TP2qD6+/HMKXw50J31A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707840897; c=relaxed/simple;
	bh=3WGZ36f6Oh8vvXnEEUUycihFVNcjNNZiflWCuEjCRAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VWLCcHEqXDA5LV09unJ1wy0wPQp4vO0j4r0qDZHOgFRqTvusUJAxoW7KqdgTvP79gGAuK43GyKplgqhe/1aeTvSD6x5HmO1+SLu8QXbCHQJZ6jnKQMbf/BHrSZkFzXMdjJMFZL/rF4jJkj6+4vtKzguTem4mLDmSouVqIQMazM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ssyt+A0f; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=6Ih9k2Mi; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=deDG+00k; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=T4mWZ9ak; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 17B2321B22;
	Tue, 13 Feb 2024 16:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707840893; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T1x7JiDroo7nMuW4dzx7zdO5XEC9rduDdHhCg4rCfP4=;
	b=Ssyt+A0f/nsbboi6gHKkJBX23BYna/drKVKMmST5B4/YBsAacxZVU1dQWi606AtXVPNzQf
	Df7584SaxbTNhr9vcUUS2abnwc6shQbdmb1bSAqzyYhjGjItpz2aQf0oYEDM5carl7oC/n
	8ssKU+OoJkYSyvuJHsJWRlhoQ/gKRkc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707840893;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T1x7JiDroo7nMuW4dzx7zdO5XEC9rduDdHhCg4rCfP4=;
	b=6Ih9k2MiSHiArqXXzMXPDFFEVS6VfgUrNZxF8vEl+69+uqJGx4NZk+9KJ2hT39ZriXOlI0
	5FVrAroZfbkqTHDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707840892; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T1x7JiDroo7nMuW4dzx7zdO5XEC9rduDdHhCg4rCfP4=;
	b=deDG+00kj5lYGTUT1NxIsGU+Zdwq0vOkVo84Q+Xt8ZyLfdRNqQrPICgyH4wUz9kL6JANAh
	4Zol+0JX7MN/9f4KnQq8n9mSaRMOYfyTD8TDL7L5qCN8TbetdKxsAYnD+lhR+WGd4p8tA+
	Th5a0yZJwALpwWuUm5E04+7XWqx3tGo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707840892;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T1x7JiDroo7nMuW4dzx7zdO5XEC9rduDdHhCg4rCfP4=;
	b=T4mWZ9akcXD9c/UXDkykLubPOp+hSrmPv92xkpOVtOuNxjIsoGUblVwe4HvmxJQ4FK00bX
	Xq/onLDLileuK2Bg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 0BEB91329E;
	Tue, 13 Feb 2024 16:14:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 6SznAnyVy2UlCAAAn2gu4w
	(envelope-from <jack@suse.cz>); Tue, 13 Feb 2024 16:14:52 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id A37CDA0809; Tue, 13 Feb 2024 17:14:51 +0100 (CET)
Date: Tue, 13 Feb 2024 17:14:51 +0100
From: Jan Kara <jack@suse.cz>
To: Baokun Li <libaokun1@huawei.com>
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
	jack@suse.cz, ritesh.list@gmail.com, linux-kernel@vger.kernel.org,
	yi.zhang@huawei.com, yangerkun@huawei.com, chengzhihao1@huawei.com,
	yukuai3@huawei.com, stable@vger.kernel.org
Subject: Re: [PATCH 5/7] ext4: fix slab-out-of-bounds in
 ext4_mb_find_good_group_avg_frag_lists()
Message-ID: <20240213161451.vrki7prkqs7izif7@quack3>
References: <20240126085716.1363019-1-libaokun1@huawei.com>
 <20240126085716.1363019-6-libaokun1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240126085716.1363019-6-libaokun1@huawei.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -2.30
X-Spamd-Result: default: False [-2.30 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-3.00)[100.00%];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[12];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,suse.com:email,suse.cz:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[vger.kernel.org,mit.edu,dilger.ca,suse.cz,gmail.com,huawei.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Flag: NO

On Fri 26-01-24 16:57:14, Baokun Li wrote:
> We can trigger a slab-out-of-bounds with the following commands:
> 
>     mkfs.ext4 -F /dev/$disk 10G
>     mount /dev/$disk /tmp/test
>     echo 2147483647 > /sys/fs/ext4/$disk/mb_group_prealloc
>     echo test > /tmp/test/file && sync
> 
> ==================================================================
> BUG: KASAN: slab-out-of-bounds in ext4_mb_find_good_group_avg_frag_lists+0x8a/0x200 [ext4]
> Read of size 8 at addr ffff888121b9d0f0 by task kworker/u2:0/11
> CPU: 0 PID: 11 Comm: kworker/u2:0 Tainted: GL 6.7.0-next-20240118 #521
> Call Trace:
>  dump_stack_lvl+0x2c/0x50
>  kasan_report+0xb6/0xf0
>  ext4_mb_find_good_group_avg_frag_lists+0x8a/0x200 [ext4]
>  ext4_mb_regular_allocator+0x19e9/0x2370 [ext4]
>  ext4_mb_new_blocks+0x88a/0x1370 [ext4]
>  ext4_ext_map_blocks+0x14f7/0x2390 [ext4]
>  ext4_map_blocks+0x569/0xea0 [ext4]
>  ext4_do_writepages+0x10f6/0x1bc0 [ext4]
> [...]
> ==================================================================
> 
> The flow of issue triggering is as follows:
> 
> // Set s_mb_group_prealloc to 2147483647 via sysfs
> ext4_mb_new_blocks
>   ext4_mb_normalize_request
>     ext4_mb_normalize_group_request
>       ac->ac_g_ex.fe_len = EXT4_SB(sb)->s_mb_group_prealloc
>   ext4_mb_regular_allocator
>     ext4_mb_choose_next_group
>       ext4_mb_choose_next_group_best_avail
>         mb_avg_fragment_size_order
>           order = fls(len) - 2 = 29
>         ext4_mb_find_good_group_avg_frag_lists
>           frag_list = &sbi->s_mb_avg_fragment_size[order]
>           if (list_empty(frag_list)) // Trigger SOOB!
> 
> At 4k block size, the length of the s_mb_avg_fragment_size list is 14, but
> an oversized s_mb_group_prealloc is set, causing slab-out-of-bounds to be
> triggered by an attempt to access an element at index 29.
> 
> Therefore it is not allowed to set s_mb_group_prealloc to a value greater
> than s_clusters_per_group via sysfs, and to avoid returning an order from
> mb_avg_fragment_size_order() that is greater than MB_NUM_ORDERS(sb).
> 
> Fixes: 7e170922f06b ("ext4: Add allocation criteria 1.5 (CR1_5)")
> CC: stable@vger.kernel.org
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza


> ---
>  fs/ext4/mballoc.c | 2 ++
>  fs/ext4/sysfs.c   | 9 ++++++++-
>  2 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index f44f668e407f..1ea6491b6b00 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -832,6 +832,8 @@ static int mb_avg_fragment_size_order(struct super_block *sb, ext4_grpblk_t len)
>  		return 0;
>  	if (order == MB_NUM_ORDERS(sb))
>  		order--;
> +	if (WARN_ON_ONCE(order > MB_NUM_ORDERS(sb)))
> +		order = MB_NUM_ORDERS(sb) - 1;
>  	return order;
>  }
>  
> diff --git a/fs/ext4/sysfs.c b/fs/ext4/sysfs.c
> index 6f9f96e00f2f..60ca7b2797b2 100644
> --- a/fs/ext4/sysfs.c
> +++ b/fs/ext4/sysfs.c
> @@ -29,6 +29,7 @@ typedef enum {
>  	attr_trigger_test_error,
>  	attr_first_error_time,
>  	attr_last_error_time,
> +	attr_group_prealloc,
>  	attr_feature,
>  	attr_pointer_pi,
>  	attr_pointer_ui,
> @@ -211,13 +212,14 @@ EXT4_ATTR_FUNC(sra_exceeded_retry_limit, 0444);
>  
>  EXT4_ATTR_OFFSET(inode_readahead_blks, 0644, inode_readahead,
>  		 ext4_sb_info, s_inode_readahead_blks);
> +EXT4_ATTR_OFFSET(mb_group_prealloc, 0644, group_prealloc,
> +		 ext4_sb_info, s_mb_group_prealloc);
>  EXT4_RW_ATTR_SBI_UI(inode_goal, s_inode_goal);
>  EXT4_RW_ATTR_SBI_UI(mb_stats, s_mb_stats);
>  EXT4_RW_ATTR_SBI_UI(mb_max_to_scan, s_mb_max_to_scan);
>  EXT4_RW_ATTR_SBI_UI(mb_min_to_scan, s_mb_min_to_scan);
>  EXT4_RW_ATTR_SBI_UI(mb_order2_req, s_mb_order2_reqs);
>  EXT4_RW_ATTR_SBI_UI(mb_stream_req, s_mb_stream_request);
> -EXT4_RW_ATTR_SBI_PI(mb_group_prealloc, s_mb_group_prealloc);
>  EXT4_RW_ATTR_SBI_UI(mb_max_linear_groups, s_mb_max_linear_groups);
>  EXT4_RW_ATTR_SBI_UI(extent_max_zeroout_kb, s_extent_max_zeroout_kb);
>  EXT4_ATTR(trigger_fs_error, 0200, trigger_test_error);
> @@ -380,6 +382,7 @@ static ssize_t ext4_generic_attr_show(struct ext4_attr *a,
>  
>  	switch (a->attr_id) {
>  	case attr_inode_readahead:
> +	case attr_group_prealloc:
>  	case attr_pointer_pi:
>  	case attr_pointer_ui:
>  		if (a->attr_ptr == ptr_ext4_super_block_offset)
> @@ -453,6 +456,10 @@ static ssize_t ext4_generic_attr_store(struct ext4_attr *a,
>  		return ret;
>  
>  	switch (a->attr_id) {
> +	case attr_group_prealloc:
> +		if (t > sbi->s_clusters_per_group)
> +			return -EINVAL;
> +		fallthrough;
>  	case attr_pointer_pi:
>  		if ((int)t < 0)
>  			return -EINVAL;
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

