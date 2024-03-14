Return-Path: <linux-ext4+bounces-1626-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD03F87BB43
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Mar 2024 11:31:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FE11284A4F
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Mar 2024 10:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B49254677;
	Thu, 14 Mar 2024 10:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Rdfaxi+g";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7hkWv6Zc";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Rdfaxi+g";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7hkWv6Zc"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59A71E87C;
	Thu, 14 Mar 2024 10:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710412260; cv=none; b=n1cyP57i2ZRZTzBvWbRENIYpLbSIlp1uKNtpL5UjEZteA/0uZ8+PKuMmvdL0s/0LLyb2Fw0VH9rgHB2SKc3ROaVrtSgV23IpX238dIXKcic69aBmcGaSlISsQdVXBndvJT7o4cA1lwdwxKA2J3YjiGqeMYzJF5275FEbxmprZHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710412260; c=relaxed/simple;
	bh=ECFErk5tKpd8PWA3UDDf7K2uDuRAUVTnmPaFdvr57IM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=reW1yolj3nE5S8UJf6+9SXQoHR9A/w9pU4Biy6mI7nzv0QPzdJ5ZVZPRtAa2uFrGFhQxDXBVyga05mrHrrSkZA5FG2kD+O+MYQNVO5X8FFvsnDZGhOnqJkZQMdW47CWVA2IZp5KvZoD3ONcWVp6ScXGmbv8tN0BiAVLhOqIbdAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Rdfaxi+g; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7hkWv6Zc; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Rdfaxi+g; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7hkWv6Zc; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 92AEE21D11;
	Thu, 14 Mar 2024 10:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710412256; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9fgcPoJWuADTATxVqCMlhkWZkFj6QJEwydD1gS0O8CQ=;
	b=Rdfaxi+gp6HPzAakyNp3fB72w/Z44k0uyMDdByL/in7C1LmV8qXuRNGBoqxXifPWJJMOp6
	lKORGzVlosnJIkJxp3pSsPPJiLGWgr2aHta/GVlegaH1BOuv7CoHsyIKk/ccoQnQAWEKBY
	mj4Va5eamkHPUDvfvBw1HCTU0fyUukE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710412256;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9fgcPoJWuADTATxVqCMlhkWZkFj6QJEwydD1gS0O8CQ=;
	b=7hkWv6ZcgnVnd0qH4FQjpiGyMp/JD7l5nIEw9IG63rx2WU71ODxIwyoFVp4SX+jifscFdN
	fP4wzm1+kCuxBjCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710412256; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9fgcPoJWuADTATxVqCMlhkWZkFj6QJEwydD1gS0O8CQ=;
	b=Rdfaxi+gp6HPzAakyNp3fB72w/Z44k0uyMDdByL/in7C1LmV8qXuRNGBoqxXifPWJJMOp6
	lKORGzVlosnJIkJxp3pSsPPJiLGWgr2aHta/GVlegaH1BOuv7CoHsyIKk/ccoQnQAWEKBY
	mj4Va5eamkHPUDvfvBw1HCTU0fyUukE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710412256;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9fgcPoJWuADTATxVqCMlhkWZkFj6QJEwydD1gS0O8CQ=;
	b=7hkWv6ZcgnVnd0qH4FQjpiGyMp/JD7l5nIEw9IG63rx2WU71ODxIwyoFVp4SX+jifscFdN
	fP4wzm1+kCuxBjCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8258E139E7;
	Thu, 14 Mar 2024 10:30:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sjfOH+DR8mXDTwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 14 Mar 2024 10:30:56 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 2B7C4A07D9; Thu, 14 Mar 2024 11:30:56 +0100 (CET)
Date: Thu, 14 Mar 2024 11:30:56 +0100
From: Jan Kara <jack@suse.cz>
To: Baokun Li <libaokun1@huawei.com>
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
	jack@suse.cz, ritesh.list@gmail.com, ojaswin@linux.ibm.com,
	adobriyan@gmail.com, linux-kernel@vger.kernel.org,
	yi.zhang@huawei.com, yangerkun@huawei.com, stable@vger.kernel.org
Subject: Re: [PATCH v2 4/9] ext4: fix slab-out-of-bounds in
 ext4_mb_find_good_group_avg_frag_lists()
Message-ID: <20240314103056.rykwi2hhfm7v575a@quack3>
References: <20240227091148.178435-1-libaokun1@huawei.com>
 <20240227091148.178435-5-libaokun1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240227091148.178435-5-libaokun1@huawei.com>
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Rdfaxi+g;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=7hkWv6Zc
X-Spamd-Result: default: False [-1.31 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 BAYES_HAM(-3.00)[100.00%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_TWELVE(0.00)[12];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,suse.com:email,huawei.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[vger.kernel.org,mit.edu,dilger.ca,suse.cz,gmail.com,linux.ibm.com,huawei.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Spam-Score: -1.31
X-Rspamd-Queue-Id: 92AEE21D11
X-Spam-Flag: NO
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On Tue 27-02-24 17:11:43, Baokun Li wrote:
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
> At 4k block size, the length of the s_mb_avg_fragment_size list is 14,
> but an oversized s_mb_group_prealloc is set, causing slab-out-of-bounds
> to be triggered by an attempt to access an element at index 29.
> 
> Add a new attr_id attr_clusters_in_group with values in the range
> [0, sbi->s_clusters_per_group] and declare mb_group_prealloc as
> that type to fix the issue. In addition avoid returning an order
> from mb_avg_fragment_size_order() greater than MB_NUM_ORDERS(sb)
> and reduce some useless loops.
> 
> Fixes: 7e170922f06b ("ext4: Add allocation criteria 1.5 (CR1_5)")
> CC: stable@vger.kernel.org
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Looks good. Just one nit below. Otherwise feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

> ---
>  fs/ext4/mballoc.c |  6 ++++++
>  fs/ext4/sysfs.c   | 13 ++++++++++++-
>  2 files changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 85a91a61b761..7ad089df2408 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -831,6 +831,8 @@ static int mb_avg_fragment_size_order(struct super_block *sb, ext4_grpblk_t len)
>  		return 0;
>  	if (order == MB_NUM_ORDERS(sb))
>  		order--;
> +	if (WARN_ON_ONCE(order > MB_NUM_ORDERS(sb)))
> +		order = MB_NUM_ORDERS(sb) - 1;
>  	return order;
>  }
>  
> @@ -1057,6 +1059,10 @@ static void ext4_mb_choose_next_group_best_avail(struct ext4_allocation_context
>  			ac->ac_flags |= EXT4_MB_CR_BEST_AVAIL_LEN_OPTIMIZED;
>  			return;
>  		}
> +
> +		/* Skip some unnecessary loops. */
> +		if (unlikely(i > MB_NUM_ORDERS(ac->ac_sb)))
> +			i = MB_NUM_ORDERS(ac->ac_sb);

How can this possibly trigger now? MB_NUM_ORDERS is sb->s_blocksize_bits +
2. 'i' is starting at fls(ac->ac_g_ex.fe_len) and ac_g_ex.fe_len shouldn't
be larger than clusters per group, hence fls() should be less than
sb->s_blocksize_bits? Am I missing something? And if yes, we should rather
make sure 'order' is never absurdly big?

I suspect this code is defensive upto a point of being confusing :)

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

