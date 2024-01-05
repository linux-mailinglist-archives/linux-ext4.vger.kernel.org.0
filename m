Return-Path: <linux-ext4+bounces-726-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C90D98251B7
	for <lists+linux-ext4@lfdr.de>; Fri,  5 Jan 2024 11:18:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E11451C22FDB
	for <lists+linux-ext4@lfdr.de>; Fri,  5 Jan 2024 10:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1B6324B52;
	Fri,  5 Jan 2024 10:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="jNco0foW";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="cxW0xp/c";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="jNco0foW";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="cxW0xp/c"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917D124B43
	for <linux-ext4@vger.kernel.org>; Fri,  5 Jan 2024 10:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 675151F851;
	Fri,  5 Jan 2024 10:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704449844; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J9qvKjZI9M1hUYrPHDsPcw/RqWaUFmKECe5In8f1xpw=;
	b=jNco0foWbibkmIeeEGOynOb585j5UihzgnoNpsPIRAkbuH+ri3D1LGETlOZVKA4SmwlM0C
	TF0nldeQM6NWiDhAHnVpJqKnob7NHieUlKAk5YnTKftqbUaD6R2MPtFYH7bGopyv7mAfl9
	KWXiUQ3vYk7vfoXlCavqS+/rThF0hMs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704449844;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J9qvKjZI9M1hUYrPHDsPcw/RqWaUFmKECe5In8f1xpw=;
	b=cxW0xp/cdt5ERFufznpGuAxCYHan3+VIRKVios9JNqd0T9uBU64lpMt0N/lHJdHWoANuGC
	Wf1LcJ3orkRh8cDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704449844; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J9qvKjZI9M1hUYrPHDsPcw/RqWaUFmKECe5In8f1xpw=;
	b=jNco0foWbibkmIeeEGOynOb585j5UihzgnoNpsPIRAkbuH+ri3D1LGETlOZVKA4SmwlM0C
	TF0nldeQM6NWiDhAHnVpJqKnob7NHieUlKAk5YnTKftqbUaD6R2MPtFYH7bGopyv7mAfl9
	KWXiUQ3vYk7vfoXlCavqS+/rThF0hMs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704449844;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J9qvKjZI9M1hUYrPHDsPcw/RqWaUFmKECe5In8f1xpw=;
	b=cxW0xp/cdt5ERFufznpGuAxCYHan3+VIRKVios9JNqd0T9uBU64lpMt0N/lHJdHWoANuGC
	Wf1LcJ3orkRh8cDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 56C5B13C99;
	Fri,  5 Jan 2024 10:17:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SzQsFTTXl2XIXAAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 05 Jan 2024 10:17:24 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id D646AA07EF; Fri,  5 Jan 2024 11:17:23 +0100 (CET)
Date: Fri, 5 Jan 2024 11:17:23 +0100
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
	jack@suse.cz, yi.zhang@huawei.com, chengzhihao1@huawei.com,
	yukuai3@huawei.com
Subject: Re: [PATCH v3 3/6] ext4: correct the hole length returned by
 ext4_map_blocks()
Message-ID: <20240105101723.gl5ew2mkhtn4nyyg@quack3>
References: <20240105033018.1665752-1-yi.zhang@huaweicloud.com>
 <20240105033018.1665752-4-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240105033018.1665752-4-yi.zhang@huaweicloud.com>
X-Spam-Level: 
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=jNco0foW;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="cxW0xp/c"
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-3.00)[100.00%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 URIBL_BLOCKED(0.00)[suse.com:email,huawei.com:email,suse.cz:dkim,suse.cz:email];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,suse.cz:dkim,suse.cz:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -4.01
X-Rspamd-Queue-Id: 675151F851
X-Spam-Flag: NO

On Fri 05-01-24 11:30:15, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> In ext4_map_blocks(), if we can't find a range of mapping in the
> extents cache, we are calling ext4_ext_map_blocks() to search the real
> path and ext4_ext_determine_hole() to determine the hole range. But if
> the querying range was partially or completely overlaped by a delalloc
> extent, we can't find it in the real extent path, so the returned hole
> length could be incorrect.
> 
> Fortunately, ext4_ext_put_gap_in_cache() have already handle delalloc
> extent, but it searches start from the expanded hole_start, doesn't
> start from the querying range, so the delalloc extent found could not be
> the one that overlaped the querying range, plus, it also didn't adjust
> the hole length. Let's just remove ext4_ext_put_gap_in_cache(), handle
> delalloc and insert adjusted hole extent in ext4_ext_determine_hole().
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> Suggested-by: Jan Kara <jack@suse.cz>

Thanks! Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/extents.c | 111 +++++++++++++++++++++++++++++-----------------
>  1 file changed, 70 insertions(+), 41 deletions(-)
> 
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index d5efe076d3d3..e0b7e48c4c67 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -2229,7 +2229,7 @@ static int ext4_fill_es_cache_info(struct inode *inode,
>  
>  
>  /*
> - * ext4_ext_determine_hole - determine hole around given block
> + * ext4_ext_find_hole - find hole around given block according to the given path
>   * @inode:	inode we lookup in
>   * @path:	path in extent tree to @lblk
>   * @lblk:	pointer to logical block around which we want to determine hole
> @@ -2241,9 +2241,9 @@ static int ext4_fill_es_cache_info(struct inode *inode,
>   * The function returns the length of a hole starting at @lblk. We update @lblk
>   * to the beginning of the hole if we managed to find it.
>   */
> -static ext4_lblk_t ext4_ext_determine_hole(struct inode *inode,
> -					   struct ext4_ext_path *path,
> -					   ext4_lblk_t *lblk)
> +static ext4_lblk_t ext4_ext_find_hole(struct inode *inode,
> +				      struct ext4_ext_path *path,
> +				      ext4_lblk_t *lblk)
>  {
>  	int depth = ext_depth(inode);
>  	struct ext4_extent *ex;
> @@ -2270,30 +2270,6 @@ static ext4_lblk_t ext4_ext_determine_hole(struct inode *inode,
>  	return len;
>  }
>  
> -/*
> - * ext4_ext_put_gap_in_cache:
> - * calculate boundaries of the gap that the requested block fits into
> - * and cache this gap
> - */
> -static void
> -ext4_ext_put_gap_in_cache(struct inode *inode, ext4_lblk_t hole_start,
> -			  ext4_lblk_t hole_len)
> -{
> -	struct extent_status es;
> -
> -	ext4_es_find_extent_range(inode, &ext4_es_is_delayed, hole_start,
> -				  hole_start + hole_len - 1, &es);
> -	if (es.es_len) {
> -		/* There's delayed extent containing lblock? */
> -		if (es.es_lblk <= hole_start)
> -			return;
> -		hole_len = min(es.es_lblk - hole_start, hole_len);
> -	}
> -	ext_debug(inode, " -> %u:%u\n", hole_start, hole_len);
> -	ext4_es_insert_extent(inode, hole_start, hole_len, ~0,
> -			      EXTENT_STATUS_HOLE);
> -}
> -
>  /*
>   * ext4_ext_rm_idx:
>   * removes index from the index block.
> @@ -4062,6 +4038,69 @@ static int get_implied_cluster_alloc(struct super_block *sb,
>  	return 0;
>  }
>  
> +/*
> + * Determine hole length around the given logical block, first try to
> + * locate and expand the hole from the given @path, and then adjust it
> + * if it's partially or completely converted to delayed extents, insert
> + * it into the extent cache tree if it's indeed a hole, finally return
> + * the length of the determined extent.
> + */
> +static ext4_lblk_t ext4_ext_determine_insert_hole(struct inode *inode,
> +						  struct ext4_ext_path *path,
> +						  ext4_lblk_t lblk)
> +{
> +	ext4_lblk_t hole_start, len;
> +	struct extent_status es;
> +
> +	hole_start = lblk;
> +	len = ext4_ext_find_hole(inode, path, &hole_start);
> +again:
> +	ext4_es_find_extent_range(inode, &ext4_es_is_delayed, hole_start,
> +				  hole_start + len - 1, &es);
> +	if (!es.es_len)
> +		goto insert_hole;
> +
> +	/*
> +	 * There's a delalloc extent in the hole, handle it if the delalloc
> +	 * extent is in front of, behind and straddle the queried range.
> +	 */
> +	if (lblk >= es.es_lblk + es.es_len) {
> +		/*
> +		 * The delalloc extent is in front of the queried range,
> +		 * find again from the queried start block.
> +		 */
> +		len -= lblk - hole_start;
> +		hole_start = lblk;
> +		goto again;
> +	} else if (in_range(lblk, es.es_lblk, es.es_len)) {
> +		/*
> +		 * The delalloc extent containing lblk, it must have been
> +		 * added after ext4_map_blocks() checked the extent status
> +		 * tree, adjust the length to the delalloc extent's after
> +		 * lblk.
> +		 */
> +		len = es.es_lblk + es.es_len - lblk;
> +		return len;
> +	} else {
> +		/*
> +		 * The delalloc extent is partially or completely behind
> +		 * the queried range, update hole length until the
> +		 * beginning of the delalloc extent.
> +		 */
> +		len = min(es.es_lblk - hole_start, len);
> +	}
> +
> +insert_hole:
> +	/* Put just found gap into cache to speed up subsequent requests */
> +	ext_debug(inode, " -> %u:%u\n", hole_start, len);
> +	ext4_es_insert_extent(inode, hole_start, len, ~0, EXTENT_STATUS_HOLE);
> +
> +	/* Update hole_len to reflect hole size after lblk */
> +	if (hole_start != lblk)
> +		len -= lblk - hole_start;
> +
> +	return len;
> +}
>  
>  /*
>   * Block allocation/map/preallocation routine for extents based files
> @@ -4179,22 +4218,12 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
>  	 * we couldn't try to create block if create flag is zero
>  	 */
>  	if ((flags & EXT4_GET_BLOCKS_CREATE) == 0) {
> -		ext4_lblk_t hole_start, hole_len;
> +		ext4_lblk_t len;
>  
> -		hole_start = map->m_lblk;
> -		hole_len = ext4_ext_determine_hole(inode, path, &hole_start);
> -		/*
> -		 * put just found gap into cache to speed up
> -		 * subsequent requests
> -		 */
> -		ext4_ext_put_gap_in_cache(inode, hole_start, hole_len);
> +		len = ext4_ext_determine_insert_hole(inode, path, map->m_lblk);
>  
> -		/* Update hole_len to reflect hole size after map->m_lblk */
> -		if (hole_start != map->m_lblk)
> -			hole_len -= map->m_lblk - hole_start;
>  		map->m_pblk = 0;
> -		map->m_len = min_t(unsigned int, map->m_len, hole_len);
> -
> +		map->m_len = min_t(unsigned int, map->m_len, len);
>  		goto out;
>  	}
>  
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

