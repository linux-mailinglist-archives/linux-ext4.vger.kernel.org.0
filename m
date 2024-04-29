Return-Path: <linux-ext4+bounces-2238-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3363F8B5F56
	for <lists+linux-ext4@lfdr.de>; Mon, 29 Apr 2024 18:47:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56CB91C219C2
	for <lists+linux-ext4@lfdr.de>; Mon, 29 Apr 2024 16:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 431D48614B;
	Mon, 29 Apr 2024 16:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="CKZ18j6U";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="d+GkVceN";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="IVG+Vq5B";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kDnWDRBe"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11EDD84FDB;
	Mon, 29 Apr 2024 16:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714409212; cv=none; b=TXgBX5YwsImvrHcH7e3HGr/pdX/KEpkIbs6k0H/3VvwjZBrDZ6EWsXFyfeRkU/4fYzc0J0dnVvuX1ldCtm4i0oo4T3uPLlXeoRZGvbiehH+SJbC1qI3HD549rlTLV5tY4qL78Ydm8L/kbnEaE2uu5AiCdPkkmeaxWRmBKELM08Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714409212; c=relaxed/simple;
	bh=RS/Nzkow4JdCZb3e2G1q+ZkbngBwp1eF3Py2i9zh+zs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W7JcZrtbkgVaGbb+q6Up2wAaq9Zdtbs41L97xT/O8TU1gpT303Wqhl0dhC/krsB8tkQorKTZFXes2/VseNCada6J42dkEY4rz0CVTypm+vbWvTQt3oON0cudwJxn5uELom82X5aIijbNjwAjfym2wAVz17uDZpa4VHPndOXFWoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=CKZ18j6U; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=d+GkVceN; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=IVG+Vq5B; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kDnWDRBe; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AC73533948;
	Mon, 29 Apr 2024 16:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1714409209; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ox2K85a+e+AMe/QfYeCjJEP5BT9IuE0nXUiZQg7af6o=;
	b=CKZ18j6UJq+6XAMMI4K75K+U5rNPzWcV/mUuowFFuvT7re/vmVq+vciKBJxomQAfagA9mY
	UummKYf0o2A9Gehug7E5A3dPY8jsYWUOOqtZpCYFGqLqHlB3gwt1AO9n7hUvPaRdfMcSOT
	4M4yv/LtVBM1w/JalV3CAIePS9vFhWs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1714409209;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ox2K85a+e+AMe/QfYeCjJEP5BT9IuE0nXUiZQg7af6o=;
	b=d+GkVceNa0zY5w/3bWdmRLA/mRvJuT6vhguUMLkzaCULG3/zj9NatBInitzt2xmiVMfJxq
	QM0wRDHF7facwjDw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=IVG+Vq5B;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=kDnWDRBe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1714409208; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ox2K85a+e+AMe/QfYeCjJEP5BT9IuE0nXUiZQg7af6o=;
	b=IVG+Vq5BLjyk2Wc/JVJqFA9PYCKOu7JZED4PD8UczFD04JQRajzDMeU3KG6Llv0EfdSKl4
	Dz6of0Cnj7F/TWfvprKJQhEKBOJ+xStB8kNFnZA97sTQwDxt+vmcF2AcwOKXpBlRTGfaIi
	oBxIu3lOIsWrvFstFnkcpty2loBuvms=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1714409208;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ox2K85a+e+AMe/QfYeCjJEP5BT9IuE0nXUiZQg7af6o=;
	b=kDnWDRBe9PNt4LuyCW+2B+jrl4w9Y4UZqNsdyiR17PoEyDgGK8BYSHgo5d4K2dlmni0TUx
	gEJ8iWcI6viBKTBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9630F138A7;
	Mon, 29 Apr 2024 16:46:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OwZkJPjOL2bvOAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 29 Apr 2024 16:46:48 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 3A76AA082F; Mon, 29 Apr 2024 18:46:48 +0200 (CEST)
Date: Mon, 29 Apr 2024 18:46:48 +0200
From: Jan Kara <jack@suse.cz>
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org, jack@suse.cz, ojaswin@linux.ibm.com,
	ritesh.list@gmail.com
Subject: Re: [PATCH v3 3/5] ext4: call ext4_mb_mark_free_simple to free
 continuous bits in found chunk
Message-ID: <20240429164648.juifmjsm7qb3d4ev@quack3>
References: <20240424061904.987525-1-shikemeng@huaweicloud.com>
 <20240424061904.987525-4-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240424061904.987525-4-shikemeng@huaweicloud.com>
X-Spam-Flag: NO
X-Spam-Score: -2.51
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: AC73533948
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[8];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[mit.edu,dilger.ca,vger.kernel.org,suse.cz,linux.ibm.com,gmail.com];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email]

On Wed 24-04-24 14:19:02, Kemeng Shi wrote:
> In mb_mark_used, we will find free chunk and mark it inuse. For chunk
> in mid of passed range, we could simply mark whole chunk inuse. For chunk
> at end of range, we may need to mark a continuous bits at end of part of
> chunk inuse and keep rest part of chunk free. To only mark a part of
> chunk inuse, we firstly mark whole chunk inuse and then mark a continuous
> range at end of chunk free.
> Function mb_mark_used does several times of "mb_find_buddy; mb_clear_bit;
> ..." to mark a continuous range free which can be done by simply calling
> ext4_mb_mark_free_simple which free continuous bits in a more effective
> way.
> Just call ext4_mb_mark_free_simple in mb_mark_used to use existing and
> effective code to free continuous blocks in chunk at end of passed range.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>

I don't know with this patch. It looks correct to me. I don't find either
the old or the new version dramatically better so I'd say I'll leave it
upto Ted whether he finds this new version better or not...

In case Ted decides to take this patch, feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/mballoc.c | 38 +++++++++++++++++++++-----------------
>  1 file changed, 21 insertions(+), 17 deletions(-)
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index a61fc52956b2..5acf413808a2 100644
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
> @@ -2094,20 +2089,29 @@ static int mb_mark_used(struct ext4_buddy *e4b, struct ext4_free_extent *ex)
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
> +		/* first chunk */
> +		if (start > ord_start)
> +			ext4_mb_mark_free_simple(e4b->bd_sb, e4b->bd_buddy,
> +						 ord_start, start - ord_start,
> +						 e4b->bd_info);
> +
> +		/* last chunk */
> +		if (start + len < ord_end) {
> +			ext4_mb_mark_free_simple(e4b->bd_sb, e4b->bd_buddy,
> +						 start + len,
> +						 ord_end - (start + len),
> +						 e4b->bd_info);
> +			break;
> +		}
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

