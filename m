Return-Path: <linux-ext4+bounces-9134-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF23B0C226
	for <lists+linux-ext4@lfdr.de>; Mon, 21 Jul 2025 13:07:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 460913AF507
	for <lists+linux-ext4@lfdr.de>; Mon, 21 Jul 2025 11:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBC40292B3A;
	Mon, 21 Jul 2025 11:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="o2AFoa9G";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1nEP1v8U";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="o2AFoa9G";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1nEP1v8U"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A64D292B28
	for <linux-ext4@vger.kernel.org>; Mon, 21 Jul 2025 11:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753096063; cv=none; b=s9FbULNJiW6zOJhrZMa0ycPfMm3SEJ5eOTVJtGLsReznxHnWSM8T4TxtaKHZf4/Q3aFXjKRauqrHVehpschbSR0J9zxCGi/ikkreD6cBSBT2DudKBocDRkcEZwZ5wXazfd+TOJS+mX+vKCuKEs4kaU5wDPfp2kIm4VluCUzJ8f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753096063; c=relaxed/simple;
	bh=7AJ8iJNawx1DrvQg5WnzxaMT3FoKhVppqfTGnLdjF1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rEqC68X+RQUq9L+K5ECf7ZANc4EBqt+ZReJ4bfQT3BzDM1aQDBdQTbgipU0o3olMd4SEiAXst7W94KnwNPcCPCXSu3RHWl3V2PpvqzrkfI0uVoDEYFFSqhGd7n05GHYjVJ16H4Ujh+VLpQYKADXA28yTIKlia/7lTPapFFwUDLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=o2AFoa9G; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=1nEP1v8U; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=o2AFoa9G; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=1nEP1v8U; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3215F1F395;
	Mon, 21 Jul 2025 11:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1753096060; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uwvVNF55BD9c27mWgUxNs2jFQnqGRUiCOISUdPy2rms=;
	b=o2AFoa9GxHxMDObZWkzl3TvqAXGNcq/VXGB8Fur061OIn3WoqGPaIOQFtoC4VxquFpW41E
	ZylYkC0Snymg6A6LMQIvhl4CKDNp/wKcLb92VSXQoN9Ml/bqEApKL9WcqnvuPG+NV9Vwlp
	+8LqbFp/s+P9jg4Zi+4et/r6VHwQKy8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1753096060;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uwvVNF55BD9c27mWgUxNs2jFQnqGRUiCOISUdPy2rms=;
	b=1nEP1v8Uk5DrEWpJRL4dlKt6vicPmvQcCsdOvGgnO0tCQhEqmtjAhIJTJUHO72EDxhSrbK
	lcprT/6TjTaWbwBw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=o2AFoa9G;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=1nEP1v8U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1753096060; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uwvVNF55BD9c27mWgUxNs2jFQnqGRUiCOISUdPy2rms=;
	b=o2AFoa9GxHxMDObZWkzl3TvqAXGNcq/VXGB8Fur061OIn3WoqGPaIOQFtoC4VxquFpW41E
	ZylYkC0Snymg6A6LMQIvhl4CKDNp/wKcLb92VSXQoN9Ml/bqEApKL9WcqnvuPG+NV9Vwlp
	+8LqbFp/s+P9jg4Zi+4et/r6VHwQKy8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1753096060;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uwvVNF55BD9c27mWgUxNs2jFQnqGRUiCOISUdPy2rms=;
	b=1nEP1v8Uk5DrEWpJRL4dlKt6vicPmvQcCsdOvGgnO0tCQhEqmtjAhIJTJUHO72EDxhSrbK
	lcprT/6TjTaWbwBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 09DD7136A8;
	Mon, 21 Jul 2025 11:07:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rQleAnwffmh0JwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 21 Jul 2025 11:07:40 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 98B2CA0884; Mon, 21 Jul 2025 13:07:39 +0200 (CEST)
Date: Mon, 21 Jul 2025 13:07:39 +0200
From: Jan Kara <jack@suse.cz>
To: Baokun Li <libaokun1@huawei.com>
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca, 
	jack@suse.cz, linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com, 
	julia.lawall@inria.fr, yi.zhang@huawei.com, yangerkun@huawei.com, 
	libaokun@huaweicloud.com
Subject: Re: [PATCH v3 15/17] ext4: convert free groups order lists to xarrays
Message-ID: <iulwol5ygqv7fry543vuoawhn7fjzlz7hmai5stjxqkkvvz6pc@wukeepjempwn>
References: <20250714130327.1830534-1-libaokun1@huawei.com>
 <20250714130327.1830534-16-libaokun1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714130327.1830534-16-libaokun1@huawei.com>
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 3215F1F395
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_SEVEN(0.00)[11];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Score: -4.01

On Mon 14-07-25 21:03:25, Baokun Li wrote:
> While traversing the list, holding a spin_lock prevents load_buddy, making
> direct use of ext4_try_lock_group impossible. This can lead to a bouncing
> scenario where spin_is_locked(grp_A) succeeds, but ext4_try_lock_group()
> fails, forcing the list traversal to repeatedly restart from grp_A.
> 
> In contrast, linear traversal directly uses ext4_try_lock_group(),
> avoiding this bouncing. Therefore, we need a lockless, ordered traversal
> to achieve linear-like efficiency.
> 
> Therefore, this commit converts both average fragment size lists and
> largest free order lists into ordered xarrays.
> 
> In an xarray, the index represents the block group number and the value
> holds the block group information; a non-empty value indicates the block
> group's presence.
> 
> While insertion and deletion complexity remain O(1), lookup complexity
> changes from O(1) to O(nlogn), which may slightly reduce single-threaded
> performance.
> 
> Additionally, xarray insertions might fail, potentially due to memory
> allocation issues. However, since we have linear traversal as a fallback,
> this isn't a major problem. Therefore, we've only added a warning message
> for insertion failures here.
> 
> A helper function ext4_mb_find_good_group_xarray() is added to find good
> groups in the specified xarray starting at the specified position start,
> and when it reaches ngroups-1, it wraps around to 0 and then to start-1.
> This ensures an ordered traversal within the xarray.
> 
> Performance test results are as follows: Single-process operations
> on an empty disk show negligible impact, while multi-process workloads
> demonstrate a noticeable performance gain.
> 
> |CPU: Kunpeng 920   |          P80           |            P1           |
> |Memory: 512GB      |------------------------|-------------------------|
> |960GB SSD (0.5GB/s)| base  |    patched     | base   |    patched     |
> |-------------------|-------|----------------|--------|----------------|
> |mb_optimize_scan=0 | 20097 | 19555 (-2.6%)  | 316141 | 315636 (-0.2%) |
> |mb_optimize_scan=1 | 13318 | 15496 (+16.3%) | 325273 | 323569 (-0.5%) |
> 
> |CPU: AMD 9654 * 2  |          P96           |             P1          |
> |Memory: 1536GB     |------------------------|-------------------------|
> |960GB SSD (1GB/s)  | base  |    patched     | base   |    patched     |
> |-------------------|-------|----------------|--------|----------------|
> |mb_optimize_scan=0 | 53603 | 53192 (-0.7%)  | 214243 | 212678 (-0.7%) |
> |mb_optimize_scan=1 | 20887 | 37636 (+80.1%) | 213632 | 214189 (+0.2%) |
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

The patch looks good and the results are nice. I've just noticed two typos:

> +static inline void ext4_mb_avg_fragment_size_destory(struct ext4_sb_info *sbi)
						^^^ destroy


> +{
> +	for (int i = 0; i < MB_NUM_ORDERS(sbi->s_sb); i++)
> +		xa_destroy(&sbi->s_mb_avg_fragment_size[i]);
> +	kfree(sbi->s_mb_avg_fragment_size);
> +}
> +
> +static inline void ext4_mb_largest_free_orders_destory(struct ext4_sb_info *sbi)
						  ^^^ destroy

> +{
> +	for (int i = 0; i < MB_NUM_ORDERS(sbi->s_sb); i++)
> +		xa_destroy(&sbi->s_mb_largest_free_orders[i]);
> +	kfree(sbi->s_mb_largest_free_orders);
> +}

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

