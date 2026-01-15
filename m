Return-Path: <linux-ext4+bounces-12859-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B6038D245BD
	for <lists+linux-ext4@lfdr.de>; Thu, 15 Jan 2026 13:01:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D78073008795
	for <lists+linux-ext4@lfdr.de>; Thu, 15 Jan 2026 12:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75D7038B7B8;
	Thu, 15 Jan 2026 12:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XEaUA7ar";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ttl8FWrB";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XEaUA7ar";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ttl8FWrB"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC643491C4
	for <linux-ext4@vger.kernel.org>; Thu, 15 Jan 2026 12:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768478479; cv=none; b=a78gWn4u+IWCgpNPJBAvY5p6w49K6TEZLmWFhirSDSkgyv5XK3VQLY7Vaqp5xaWsJx/grCKOc5TuIaDsDR7PKnc+/t7myJZk8KgUaD3eWzZPYnTXwlY3OY876LETzYszZ0e7xtj/ZeXDzQiNe9qqRg6hdDClUNqzPXhbTL6K6f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768478479; c=relaxed/simple;
	bh=OFuSgbmiv1Dq0+fqFgBAW5vvuJrE1HBidemS/YLkaSM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z3gU52BR7eq+BvmELVHN70KrMvMQvKA3rxYy+5NdrgBEe9FQeJ7Aob1copMowYxhsZnD8fMAvRNfzaEWxkYPmy/dENpjl/HoeiyTaHoqKOroXVPzTcQpWzUZRqMplSqFiB7d8CF1+Xovip4TAP7uMDJdOs2WFnAGKHfvSNz8H08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XEaUA7ar; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ttl8FWrB; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XEaUA7ar; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ttl8FWrB; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4ADA85BD43;
	Thu, 15 Jan 2026 12:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768478475; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6cfWvie/yu4h6hx370M5Yi5LSfZ2wLHoF7eeNGPwHsw=;
	b=XEaUA7arjRCwoA4jncGhE0YBySkLlhJfLi8aM6he8m53kFymSOsr+01FQFSFm/EHWZnCoy
	t8gdGObh8PWHsIQgZ15T2itaAMsPYDUQ+CE9Wakn02K5vN5DmIP0ftCWTxZ7ZZ+n/Igoaf
	L7uPLkeX3/m0rcTLa2wKGtYxXXRgjPc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768478475;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6cfWvie/yu4h6hx370M5Yi5LSfZ2wLHoF7eeNGPwHsw=;
	b=ttl8FWrBMl2lKEK1tBTnzHe2MdJiI3gfU1eap0RNSaXkQ7L2+2OT3OGjLHgfpsgTDYDoGy
	ZTqkfvF3xqRDnwDw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=XEaUA7ar;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ttl8FWrB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768478475; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6cfWvie/yu4h6hx370M5Yi5LSfZ2wLHoF7eeNGPwHsw=;
	b=XEaUA7arjRCwoA4jncGhE0YBySkLlhJfLi8aM6he8m53kFymSOsr+01FQFSFm/EHWZnCoy
	t8gdGObh8PWHsIQgZ15T2itaAMsPYDUQ+CE9Wakn02K5vN5DmIP0ftCWTxZ7ZZ+n/Igoaf
	L7uPLkeX3/m0rcTLa2wKGtYxXXRgjPc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768478475;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6cfWvie/yu4h6hx370M5Yi5LSfZ2wLHoF7eeNGPwHsw=;
	b=ttl8FWrBMl2lKEK1tBTnzHe2MdJiI3gfU1eap0RNSaXkQ7L2+2OT3OGjLHgfpsgTDYDoGy
	ZTqkfvF3xqRDnwDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 318903EA63;
	Thu, 15 Jan 2026 12:01:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AhkSDAvXaGlCWwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 15 Jan 2026 12:01:15 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id CEC42A0A04; Thu, 15 Jan 2026 13:01:14 +0100 (CET)
Date: Thu, 15 Jan 2026 13:01:14 +0100
From: Jan Kara <jack@suse.cz>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>, 
	Ritesh Harjani <ritesh.list@gmail.com>, Zhang Yi <yi.zhang@huawei.com>, Jan Kara <jack@suse.cz>, 
	libaokun1@huawei.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/8] ext4: Refactor zeroout path and handle all cases
Message-ID: <62d5naxy5tq2gvi4vv4hhxhjfabkcr7w2qsvz7y73ihei6o7ue@oieo2mwvx344>
References: <cover.1768402426.git.ojaswin@linux.ibm.com>
 <3a63beac9855f41efcdb11b839b4cb6fdc9fb3a4.1768402426.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a63beac9855f41efcdb11b839b4cb6fdc9fb3a4.1768402426.git.ojaswin@linux.ibm.com>
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,mit.edu,gmail.com,huawei.com,suse.cz];
	RCPT_COUNT_SEVEN(0.00)[8];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email]
X-Spam-Flag: NO
X-Spam-Score: -2.51
X-Rspamd-Queue-Id: 4ADA85BD43
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 

On Wed 14-01-26 20:27:50, Ojaswin Mujoo wrote:
> Currently, zeroout is used as a fallback in case we fail to
> split/convert extents in the "traditional" modify-the-extent-tree way.
> This is essential to mitigate failures in critical paths like extent
> splitting during endio. However, the logic is very messy and not easy to
> follow. Further, the fragile use of various flags has made it prone to
> errors.
> 
> Refactor zeroout out logic by moving it up to ext4_split_extents().
> Further, zeroout correctly based on the type of conversion we want, ie:
> - unwritten to written: Zeroout everything around the mapped range.
> - written to unwritten: Zeroout only the mapped range.
> 
> Also, ext4_ext_convert_to_initialized() now passes
> EXT4_GET_BLOCKS_CONVERT to make the intention clear.
> 
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

Overall looks nice. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

A few nits below:

> +static int ext4_split_extent_zeroout(handle_t *handle, struct inode *inode,
> +				     struct ext4_ext_path *path,
> +				     struct ext4_map_blocks *map, int flags)
> +{
> +	struct ext4_extent *ex;
> +	unsigned int ee_len, depth;
> +	ext4_lblk_t ee_block;
> +	uint64_t lblk, pblk, len;
> +	int is_unwrit;
> +	int err = 0;
> +
> +	depth = ext_depth(inode);
> +	ex = path[depth].p_ext;
> +	ee_block = le32_to_cpu(ex->ee_block);
> +	ee_len = ext4_ext_get_actual_len(ex);
> +	is_unwrit = ext4_ext_is_unwritten(ex);
>  
> +	if (flags & EXT4_GET_BLOCKS_CONVERT) {
>  		/*
> -		 * The first half contains partially valid data, the splitting
> -		 * of this extent has not been completed, fix extent length
> -		 * and ext4_split_extent() split will the first half again.
> +		 * EXT4_GET_BLOCKS_CONVERT: Caller wants the range specified by
> +		 * map to be initialized. Zeroout everything except the map
> +		 * range.
>  		 */
> -		if (split_flag & EXT4_EXT_DATA_PARTIAL_VALID1) {
> -			/*
> -			 * Drop extent cache to prevent stale unwritten
> -			 * extents remaining after zeroing out.
> -			 */
> -			ext4_es_remove_extent(inode,
> -					le32_to_cpu(zero_ex.ee_block),
> -					ext4_ext_get_actual_len(&zero_ex));
> -			goto fix_extent_len;
> +
> +		loff_t map_end = (loff_t) map->m_lblk + map->m_len;
> +		loff_t ex_end = (loff_t) ee_block + ee_len;
> +
> +		if (!is_unwrit)
> +			/* Shouldn't happen. Just exit */
> +			return -EINVAL;
> +
> +		/* zeroout left */
> +		if (map->m_lblk > ee_block) {
> +			lblk = ee_block;
> +			len = map->m_lblk - ee_block;
> +			pblk = ext4_ext_pblock(ex);
> +			err = ext4_issue_zeroout(inode, lblk, pblk, len);
> +			if (err)
> +				/* ZEROOUT failed, just return original error */
> +				return err;
>  		}
>  
> -		/* update the extent length and mark as initialized */
> -		ex->ee_len = cpu_to_le16(ee_len);
> -		ext4_ext_try_to_merge(handle, inode, path, ex);
> -		err = ext4_ext_dirty(handle, inode, path + path->p_depth);
> -		if (!err)
> -			/* update extent status tree */
> -			ext4_zeroout_es(inode, &zero_ex);
> +		/* zeroout right */
> +		if (map->m_lblk + map->m_len < ee_block + ee_len) {

Use map_end and ex_end in the above condition when we have it?

...
> @@ -3382,11 +3428,13 @@ static struct ext4_ext_path *ext4_split_extent(handle_t *handle,
>  					       int split_flag, int flags,
>  					       unsigned int *allocated)
>  {
> -	ext4_lblk_t ee_block;
> +	ext4_lblk_t ee_block, orig_ee_block;
>  	struct ext4_extent *ex;
> -	unsigned int ee_len, depth;
> -	int unwritten;
> -	int split_flag1, flags1;
> +	unsigned int ee_len, orig_ee_len, depth;
> +	int unwritten, orig_unwritten;
> +	int split_flag1 = 0, flags1 = 0;
> +	int  orig_err = 0;
	   ^^ extra space

> +	int orig_flags = flags;
>  
>  	depth = ext_depth(inode);
>  	ex = path[depth].p_ext;
> @@ -3394,30 +3442,31 @@ static struct ext4_ext_path *ext4_split_extent(handle_t *handle,
>  	ee_len = ext4_ext_get_actual_len(ex);
>  	unwritten = ext4_ext_is_unwritten(ex);
>  
> +	orig_ee_block = ee_block;
> +	orig_ee_len = ee_len;
> +	orig_unwritten = unwritten;
> +
>  	/* Do not cache extents that are in the process of being modified. */
>  	flags |= EXT4_EX_NOCACHE;
>  
>  	if (map->m_lblk + map->m_len < ee_block + ee_len) {
> -		split_flag1 = split_flag & EXT4_EXT_MAY_ZEROOUT;
>  		flags1 = flags | EXT4_GET_BLOCKS_SPLIT_NOMERGE;
>  		if (unwritten)
>  			split_flag1 |= EXT4_EXT_MARK_UNWRIT1 |
>  				       EXT4_EXT_MARK_UNWRIT2;
> -		if (split_flag & EXT4_EXT_DATA_VALID2)
> -			split_flag1 |= map->m_lblk > ee_block ?
> -				       EXT4_EXT_DATA_PARTIAL_VALID1 :
> -				       EXT4_EXT_DATA_ENTIRE_VALID1;
>  		path = ext4_split_extent_at(handle, inode, path,
>  				map->m_lblk + map->m_len, split_flag1, flags1);
>  		if (IS_ERR(path))
> -			return path;
> +			goto try_zeroout;
> +
>  		/*
>  		 * Update path is required because previous ext4_split_extent_at
>  		 * may result in split of original leaf or extent zeroout.
>  		 */
>  		path = ext4_find_extent(inode, map->m_lblk, path, flags);
>  		if (IS_ERR(path))
> -			return path;
> +			goto try_zeroout;
> +
>  		depth = ext_depth(inode);
>  		ex = path[depth].p_ext;
>  		if (!ex) {
> @@ -3426,22 +3475,64 @@ static struct ext4_ext_path *ext4_split_extent(handle_t *handle,
>  			ext4_free_ext_path(path);
>  			return ERR_PTR(-EFSCORRUPTED);
>  		}
> -		unwritten = ext4_ext_is_unwritten(ex);
>  	}
>  
>  	if (map->m_lblk >= ee_block) {
> -		split_flag1 = split_flag & EXT4_EXT_DATA_VALID2;
> +		split_flag1 = 0;
>  		if (unwritten) {
>  			split_flag1 |= EXT4_EXT_MARK_UNWRIT1;
> -			split_flag1 |= split_flag & (EXT4_EXT_MAY_ZEROOUT |
> -						     EXT4_EXT_MARK_UNWRIT2);
> +			split_flag1 |= split_flag & EXT4_EXT_MARK_UNWRIT2;
>  		}
> -		path = ext4_split_extent_at(handle, inode, path,
> -				map->m_lblk, split_flag1, flags);
> +		path = ext4_split_extent_at(handle, inode, path, map->m_lblk,
> +					    split_flag1, flags);
>  		if (IS_ERR(path))
> -			return path;
> +			goto try_zeroout;
>  	}
>  
> +	goto success;
> +
> +try_zeroout:
> +	/*
> +	 * There was an error in splitting the extent. So instead, just zeroout
> +	 * unwritten portions and convert it to initialize as a last resort. If
> +	 * there is any failure here we just return the original error
> +	 */
> +
> +	orig_err = PTR_ERR(path);
> +	if (orig_err != -ENOSPC && orig_err != -EDQUOT && orig_err != -ENOMEM)
> +		goto out_orig_err;
> +
> +	if (!(split_flag & EXT4_EXT_MAY_ZEROOUT))
> +		/* There's an error and we can't zeroout, just return the
> +		 * original err
> +		 */

I'd put this before if and just write:

	/* We can't zeroout? Just return the original error */

so that the comment fits on a single line :)

> +		goto out_orig_err;
> +
> +	path = ext4_find_extent(inode, map->m_lblk, NULL, flags);
> +	if (IS_ERR(path))
> +		goto out_orig_err;
> +
> +	depth = ext_depth(inode);
> +	ex = path[depth].p_ext;
> +	ee_block = le32_to_cpu(ex->ee_block);
> +	ee_len = ext4_ext_get_actual_len(ex);
> +	unwritten = ext4_ext_is_unwritten(ex);
> +
> +	if (WARN_ON(ee_block != orig_ee_block || ee_len != orig_ee_len ||
> +		    unwritten != orig_unwritten))
> +		/*
> +		 * The extent to zeroout should have been unchanged
> +		 * but its not.
> +		 */
> +		goto out_free_path;
> +
> +	if (ext4_split_extent_zeroout(handle, inode, path, map, orig_flags))
> +		/*
> +		 * Something went wrong in zeroout
> +		 */

I think this comment isn't really useful...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

