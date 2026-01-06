Return-Path: <linux-ext4+bounces-12593-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AD70FCF9169
	for <lists+linux-ext4@lfdr.de>; Tue, 06 Jan 2026 16:32:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6D9993006998
	for <lists+linux-ext4@lfdr.de>; Tue,  6 Jan 2026 15:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 908D32EB10;
	Tue,  6 Jan 2026 15:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="on1GNc0C";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="vhfdxuJ2";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="on1GNc0C";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="vhfdxuJ2"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D04C13D521
	for <linux-ext4@vger.kernel.org>; Tue,  6 Jan 2026 15:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767713494; cv=none; b=mmREzlP0G2+R86k1ejlxZR0SLRAGYMa3C8TGeutzHn2i9Ki4v9DZhiRFWtjAZ5/WeJrddncJK8hvD0xliTfSjjGHpgOSbRDYlOmJSXnAQ6ot2j9NsX3+FpOf89ceFx4jOXSPQAsSsGfr35NJ4cbto7rG5tZGBtcre3kiK9P/VeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767713494; c=relaxed/simple;
	bh=NnLG5JquGoLieucAB+cJK659qnCkkYiAC5CCSYyiN9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VvWH2EWLcvn1tGrvvUOKp+CupM8KaT7SJAVPluNgpS8w1StUYsYCwIN633tqA8YsrM8HaJngGzsHhcxQh4WSo3mXql5zYl6+7tznU7hNvd5XaVgLkjrLrM39eZB1Mjy1JCYc7ZFJ+mMB001UySGsLOVm/c/ivmYizjA5pUbB8C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=on1GNc0C; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=vhfdxuJ2; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=on1GNc0C; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=vhfdxuJ2; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2B2445BCC5;
	Tue,  6 Jan 2026 15:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1767713484; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R022aewY7zsJqzKwdIPwfKSamSGYGfTNrZvpas90LF8=;
	b=on1GNc0CSy9tBDB6UscbRlYuXqnv+42AaZppRaNR6rFmI24VWalV7r9sFm/w5jO6wphCzn
	k3619OPwtkJqVdxnCGx5xxsJ7DYpTX9uNfLqonBZyzewK3iCcv2+kWTFNsxsB49IsokfxL
	4+lHuUmkTaLZQIiRhWRkkfQu6W6hPM0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1767713484;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R022aewY7zsJqzKwdIPwfKSamSGYGfTNrZvpas90LF8=;
	b=vhfdxuJ2mPL1DJpaDCMNsITU+/+qmlCJqj2uYCuTN2wU0d5Yv8x6TVSk9wgRvwYoM5gUAO
	CVmLaZEyxpI9tjCQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=on1GNc0C;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=vhfdxuJ2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1767713484; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R022aewY7zsJqzKwdIPwfKSamSGYGfTNrZvpas90LF8=;
	b=on1GNc0CSy9tBDB6UscbRlYuXqnv+42AaZppRaNR6rFmI24VWalV7r9sFm/w5jO6wphCzn
	k3619OPwtkJqVdxnCGx5xxsJ7DYpTX9uNfLqonBZyzewK3iCcv2+kWTFNsxsB49IsokfxL
	4+lHuUmkTaLZQIiRhWRkkfQu6W6hPM0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1767713484;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R022aewY7zsJqzKwdIPwfKSamSGYGfTNrZvpas90LF8=;
	b=vhfdxuJ2mPL1DJpaDCMNsITU+/+qmlCJqj2uYCuTN2wU0d5Yv8x6TVSk9wgRvwYoM5gUAO
	CVmLaZEyxpI9tjCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1F99F3EA63;
	Tue,  6 Jan 2026 15:31:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8uCvB8wqXWmRLAAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 06 Jan 2026 15:31:24 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id D0C97A0A4A; Tue,  6 Jan 2026 16:31:23 +0100 (CET)
Date: Tue, 6 Jan 2026 16:31:23 +0100
From: Jan Kara <jack@suse.cz>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>, 
	Ritesh Harjani <ritesh.list@gmail.com>, Zhang Yi <yi.zhang@huawei.com>, Jan Kara <jack@suse.cz>, 
	libaokun1@huawei.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/7] ext4: Refactor zeroout path and handle all cases
Message-ID: <berakgy2my7h2v5wfijozaucks2fykqhqaq6zdbaucy7cx5osq@gkzxv4snj2ug>
References: <cover.1767528171.git.ojaswin@linux.ibm.com>
 <1ecffaf1edd7a37d90a7fcc8808b9b6e4e7a1245.1767528171.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ecffaf1edd7a37d90a7fcc8808b9b6e4e7a1245.1767528171.git.ojaswin@linux.ibm.com>
X-Spam-Flag: NO
X-Spam-Score: -2.51
X-Rspamd-Queue-Id: 2B2445BCC5
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,mit.edu,gmail.com,huawei.com,suse.cz];
	RCPT_COUNT_SEVEN(0.00)[8];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Level: 

On Sun 04-01-26 17:49:18, Ojaswin Mujoo wrote:
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
> - unwritten to unwritten: Zeroout everything
> - written to unwritten: Zeroout only the mapped range.
> 
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

...

> @@ -3383,11 +3440,12 @@ static struct ext4_ext_path *ext4_split_extent(handle_t *handle,
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
> +	int err = 0, orig_err;

Cannot orig_err be used uninitialized in this function? At least it isn't
obvious to me some of the branches setting it is always taken.

> @@ -3395,23 +3453,29 @@ static struct ext4_ext_path *ext4_split_extent(handle_t *handle,
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
> -		if (IS_ERR(path))
> -			return path;
> +
> +		if (IS_ERR(path)) {
> +			orig_err = PTR_ERR(path);
> +			if (orig_err != -ENOSPC && orig_err != -EDQUOT &&
> +			    orig_err != -ENOMEM)
> +				return path;
> +
> +			goto try_zeroout;
> +		}
>  		/*
>  		 * Update path is required because previous ext4_split_extent_at
>  		 * may result in split of original leaf or extent zeroout.
> @@ -3427,22 +3491,68 @@ static struct ext4_ext_path *ext4_split_extent(handle_t *handle,
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
> +
> +		if (IS_ERR(path)) {
> +			orig_err = PTR_ERR(path);
> +			if (orig_err != -ENOSPC && orig_err != -EDQUOT &&
> +			    orig_err != -ENOMEM)
> +				return path;
> +
> +			goto try_zeroout;
> +		}
> +	}
> +
> +	if (!err)

Nothing touches 'err' in this function...

> +		goto out;
> +
> +try_zeroout:
> +	/*
> +	 * There was an error in splitting the extent, just zeroout and convert
> +	 * to initialize as a last resort
> +	 */
> +	if (split_flag & EXT4_EXT_MAY_ZEROOUT) {
> +		path = ext4_find_extent(inode, map->m_lblk, NULL, flags);
>  		if (IS_ERR(path))
>  			return path;
> +
> +		depth = ext_depth(inode);
> +		ex = path[depth].p_ext;
> +		ee_block = le32_to_cpu(ex->ee_block);
> +		ee_len = ext4_ext_get_actual_len(ex);
> +		unwritten = ext4_ext_is_unwritten(ex);
> +
> +		/*
> +		 * The extent to zeroout should have been unchanged
> +		 * but its not, just return error to caller
> +		 */
> +		if (WARN_ON(ee_block != orig_ee_block ||
> +			    ee_len != orig_ee_len ||
> +			    unwritten != orig_unwritten))
> +			return ERR_PTR(orig_err);
> +
> +		/*
> +		 * Something went wrong in zeroout, just return the
> +		 * original error
> +		 */
> +		if (ext4_split_extent_zeroout(handle, inode, path, map, flags))
> +			return ERR_PTR(orig_err);
>  	}

Also nothing seems to zero out orig_err in case zero out above succeeded.
What am I missing?

								Honza

>  
> +	/* There's an error and we can't zeroout, just return the err */
> +	return ERR_PTR(orig_err);
> +
> +out:
> +
>  	if (allocated) {
>  		if (map->m_lblk + map->m_len > ee_block + ee_len)
>  			*allocated = ee_len - (map->m_lblk - ee_block);
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

