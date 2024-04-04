Return-Path: <linux-ext4+bounces-1860-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE0578989BD
	for <lists+linux-ext4@lfdr.de>; Thu,  4 Apr 2024 16:17:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 579E51F2DBE4
	for <lists+linux-ext4@lfdr.de>; Thu,  4 Apr 2024 14:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9739129E6B;
	Thu,  4 Apr 2024 14:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="J34CAesQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="y3TSZ9E8";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wM+o/06Y";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ggkm8+W7"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7A4129A78;
	Thu,  4 Apr 2024 14:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712240192; cv=none; b=O//UdKGOYpgMAhjaMNR9pR21aybTKeFxEXrlU2J+oBCX52rib4+SCvMAb9a2O7zau0dSxtx1h6yv2ZkhzhaYC5fU60TPXVs7ADROeyiHS+0wrNGzOpigtku/B2wmcpRG2kmZD7Adpoiw+YXF2SQyDrq09qA6xjAUw8fNLWzXHD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712240192; c=relaxed/simple;
	bh=iSKl3B70Jm2tgaEcWKgOH1/HFeN5dl8AFw81AlbVK0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rf/nshT1b8e/+ZeJp7BRXJPn5u8oiPUl/flyA46xCW8qUaAsIoPix7ZD7C6bAxKpPNBRok4puiwkFnfOoi0LTpyKgkO/KtOKP41x1llWGvbvIbm3H35b2eeWdU/ILaosLmwAo/r3kS0KyfY/Fjkn4GryAIxy23wI2muk4B2PFqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=J34CAesQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=y3TSZ9E8; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wM+o/06Y; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ggkm8+W7; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A2F4937B0B;
	Thu,  4 Apr 2024 14:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1712240180; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=By6646MfL2u4LNBLsReSd5XkDVIg1VQY4Axh9wcefH4=;
	b=J34CAesQ1tHteSCpoYkOUi8mkY3Ld+3hiNF7BFzamZLFAakdUQfZFYNQ+RtkcmHX1UDmxD
	Ieu5pe8ke5YcrmxjTB8MGNdSknsYdZET6NsV5D/a6ywEAMtiHJN90mnyGW1Z8AvgbOfQYG
	CUddXh5E7LdkTkgTdrFSKgHvM1CMGa4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1712240180;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=By6646MfL2u4LNBLsReSd5XkDVIg1VQY4Axh9wcefH4=;
	b=y3TSZ9E8r8D5qqjnvMX5uO1dmZv+GMtzGdxuWvKAnADwFjCAFvpX7ImLwYt5Vsujz5DJKj
	xu4hTidSH44azODg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1712240179; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=By6646MfL2u4LNBLsReSd5XkDVIg1VQY4Axh9wcefH4=;
	b=wM+o/06YW9q7HxN0VZeXsBiLKvWyM841JWS26PUArezQ8kn9YIQCkrsybjwXcTeqjpc+yk
	i2bmDHzlT4wgnwclerUXuJ7D0F2E60RwU6L1prajp5vvW4UHx+oxsm20YbAKEXqSg8llWi
	HuvfOamQnvA3NFIWMkJLMvsGWgfTVec=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1712240179;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=By6646MfL2u4LNBLsReSd5XkDVIg1VQY4Axh9wcefH4=;
	b=Ggkm8+W7Z3qB7BxVKwoYZ7CB8MV3AOSHYWMSGpSY9a50YT5pu+3V/9KwUL9Hxw+5uoHWcp
	yWYdzJPBWcpK/UDA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 9723E13298;
	Thu,  4 Apr 2024 14:16:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id x9rhJDO2DmYQBQAAn2gu4w
	(envelope-from <jack@suse.cz>); Thu, 04 Apr 2024 14:16:19 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 4CC9EA0816; Thu,  4 Apr 2024 16:16:19 +0200 (CEST)
Date: Thu, 4 Apr 2024 16:16:19 +0200
From: Jan Kara <jack@suse.cz>
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org, jack@suse.cz, ojaswin@linux.ibm.com,
	ritesh.list@gmail.com
Subject: Re: [PATCH 3/5] ext4: call ext4_mb_mark_free_simple in mb_mark_used
 to clear bits
Message-ID: <20240404141619.xrgtjhtpcae3kqk6@quack3>
References: <20240326213823.528302-1-shikemeng@huaweicloud.com>
 <20240326213823.528302-4-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326213823.528302-4-shikemeng@huaweicloud.com>
X-Spam-Flag: NO
X-Spam-Score: -2.30
X-Spam-Level: 
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[mit.edu,dilger.ca,vger.kernel.org,suse.cz,linux.ibm.com,gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap2.dmz-prg2.suse.org:helo,imap2.dmz-prg2.suse.org:rdns,suse.com:email]

On Wed 27-03-24 05:38:21, Kemeng Shi wrote:
> Function ext4_mb_mark_free_simple could search order for bit clearing in
> O(1) cost while mb_mark_used will search order in O(distance from chunk
> order to target order) and introduce unnecessary bit flips.

Let me see if I understand you right. I agree that mb_mark_used() is
actually O(log(bitmap_size)^2) because each call to
mb_find_order_for_block() is O(log(bitmap_size)). Do I understand your
concern right?

> Consider we have 4 continuous free bits and going to mark bit 0-2 inuse.
> initial state of buddy bitmap:
> order 2 |           0           |
> order 1 |     1     |     1     |
> order 0 |  1  |  1  |  1  |  1  |
>
> mark whole chunk inuse
> order 2 |           1           |
> order 1 |     1     |     1     |
> order 0 |  1  |  1  |  1  |  1  |
> 
> split chunk to order 1
> order 2 |           1           |
> order 1 |     0     |     0     |
> order 0 |  1  |  1  |  1  |  1  |
> 
> set the first bit in order 1 to mark bit 0-1 inuse
> set the second bit in order 1 for split
> order 2 |           1           |
> order 1 |     1     |     1     |
> order 0 |  1  |  1  |  1  |  1  |
> 
> step 3: split the second bit in order 1 to order 0
> order 2 |           1           |
> order 1 |     1     |     1     |
> order 0 |  1  |  1  |  0  |  0  |
> 
> step 4: set the third bit in order 0 to mark bit 2 inuse.
> order 2 |           1           |
> order 1 |     1     |     1     |
> order 0 |  1  |  1  |  1  |  0  |
> There are two unnecessary splits and three unnecessary bit flips.
> 
> With ext4_mb_mark_free_simple, we will clear the 4th bit in order 0
> with O(1) search and no extra bit flip.

However this looks like a bit ugly way to speed it up, I'm not even sure
this would result in practical speedups and asymptotically, I think the
complexity is still O(log^2). Also the extra bit flips are not really a
concern I'd say as they are in the same cacheline anyway. The unnecessary
overhead (if at all measurable) comes from the O(log^2) behavior. And there
I agree we could do better by not starting the block order search from 1 in
all the cases - we know the found order will be first increasing for some
time and then decreasing again so with some effort we could amortize all
block order searches to O(log) time. But it makes the code more complex and
I'm not conviced this is all worth it. So if you want to go this direction,
then please provide (micro-)benchmarks from real hardware (not just
theoretical cost estimations) showing the benefit. Thanks.

								Honza

> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index a61fc52956b2..62d468379722 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -2040,13 +2040,12 @@ static int mb_mark_used(struct ext4_buddy *e4b, struct ext4_free_extent *ex)
>  	int ord;
>  	int mlen = 0;
>  	int max = 0;
> -	int cur;
>  	int start = ex->fe_start;
>  	int len = ex->fe_len;
>  	unsigned ret = 0;
>  	int len0 = len;
>  	void *buddy;
> -	bool split = false;
> +	int ord_start, ord_end;
>  
>  	BUG_ON(start + len > (e4b->bd_sb->s_blocksize << 3));
>  	BUG_ON(e4b->bd_group != ex->fe_group);
> @@ -2071,16 +2070,12 @@ static int mb_mark_used(struct ext4_buddy *e4b, struct ext4_free_extent *ex)
>  
>  	/* let's maintain buddy itself */
>  	while (len) {
> -		if (!split)
> -			ord = mb_find_order_for_block(e4b, start);
> +		ord = mb_find_order_for_block(e4b, start);
>  
>  		if (((start >> ord) << ord) == start && len >= (1 << ord)) {
>  			/* the whole chunk may be allocated at once! */
>  			mlen = 1 << ord;
> -			if (!split)
> -				buddy = mb_find_buddy(e4b, ord, &max);
> -			else
> -				split = false;
> +			buddy = mb_find_buddy(e4b, ord, &max);
>  			BUG_ON((start >> ord) >= max);
>  			mb_set_bit(start >> ord, buddy);
>  			e4b->bd_info->bb_counters[ord]--;
> @@ -2094,20 +2089,28 @@ static int mb_mark_used(struct ext4_buddy *e4b, struct ext4_free_extent *ex)
>  		if (ret == 0)
>  			ret = len | (ord << 16);
>  
> -		/* we have to split large buddy */
>  		BUG_ON(ord <= 0);
>  		buddy = mb_find_buddy(e4b, ord, &max);
>  		mb_set_bit(start >> ord, buddy);
>  		e4b->bd_info->bb_counters[ord]--;
>  
> -		ord--;
> -		cur = (start >> ord) & ~1U;
> -		buddy = mb_find_buddy(e4b, ord, &max);
> -		mb_clear_bit(cur, buddy);
> -		mb_clear_bit(cur + 1, buddy);
> -		e4b->bd_info->bb_counters[ord]++;
> -		e4b->bd_info->bb_counters[ord]++;
> -		split = true;
> +		ord_start = (start >> ord) << ord;
> +		ord_end = ord_start + (1 << ord);
> +		if (start > ord_start)
> +			ext4_mb_mark_free_simple(e4b->bd_sb, e4b->bd_buddy,
> +						 ord_start, start - ord_start,
> +						 e4b->bd_info);
> +
> +		if (start + len < ord_end) {
> +			ext4_mb_mark_free_simple(e4b->bd_sb, e4b->bd_buddy,
> +						 start + len,
> +						 ord_end - (start + len),
> +						 e4b->bd_info);
> +			break;
> +		}
> +
> +		len = start + len - ord_end;
> +		start = ord_end;
>  	}
>  	mb_set_largest_free_order(e4b->bd_sb, e4b->bd_info);
>  
> -- 
> 2.30.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

