Return-Path: <linux-ext4+bounces-3451-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCD0393C07D
	for <lists+linux-ext4@lfdr.de>; Thu, 25 Jul 2024 12:59:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93C19282722
	for <lists+linux-ext4@lfdr.de>; Thu, 25 Jul 2024 10:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35BD11991B4;
	Thu, 25 Jul 2024 10:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Etg3KoFH";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="xt3FxY9e";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Etg3KoFH";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="xt3FxY9e"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500A7197A77;
	Thu, 25 Jul 2024 10:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721905150; cv=none; b=UEFY7VjlCJKUmyE39q2JF0eS5Int7a2w2NSHy3VDgB0LRylLzJDGQYJA+wsZ74sFSMx4C1p5zG18psMnmhl+90gh02lD2Nvywqy64rELvSJKZcMjbJz8s39wL5yj4UP/NSKITGcOibIoLXjxHTkBuy+g9peOoLw9EXzcLM8brQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721905150; c=relaxed/simple;
	bh=ehBtB007lhDWJ4xN0DbifAIP/w/O5moSwXyMiiAe2oE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QB+e49ey29Cvl5xOHcAjetD35Vb47CFq5QM8GYy/y1e5SWCw3DQN6wXQwegJ11K5HsfhBHk1TdluHZinPukeQFy4cnEkUhGwtK+OgmK9tskVJcU40u8KST+idSnCJQSAICQ0/y1L3qHAWwTwwc8eOcmIQR/4+a33R3u5DbaB2QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Etg3KoFH; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=xt3FxY9e; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Etg3KoFH; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=xt3FxY9e; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6A0BC21B37;
	Thu, 25 Jul 2024 10:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721905146; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+s8HYX954RevvEABrcX+VxedGvuIf4BNutRXY9xqAbc=;
	b=Etg3KoFHnq2F4Q0b5TbUQ7003PB4mSjKDCZp6eWu9q/eRrJTeui+LGyGC7bEORcwnYLVwN
	OmLqBp5PY7hkAWqy9W6Zz1DG0ushxhAVNgArRYhrfGWMFa1OvToETc4MrAJxfqzMcCxhe0
	H+KNIkICXmzRFY1SO6xSvJFHzOPXRKM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721905146;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+s8HYX954RevvEABrcX+VxedGvuIf4BNutRXY9xqAbc=;
	b=xt3FxY9eYVe5IsNGjM7/RLnUh8Sr85K1mEPCUG2QHgCAVoYu5junqaC13L1Gr2BnLNIdad
	NNT6jHY9IDmsS5CQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Etg3KoFH;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=xt3FxY9e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721905146; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+s8HYX954RevvEABrcX+VxedGvuIf4BNutRXY9xqAbc=;
	b=Etg3KoFHnq2F4Q0b5TbUQ7003PB4mSjKDCZp6eWu9q/eRrJTeui+LGyGC7bEORcwnYLVwN
	OmLqBp5PY7hkAWqy9W6Zz1DG0ushxhAVNgArRYhrfGWMFa1OvToETc4MrAJxfqzMcCxhe0
	H+KNIkICXmzRFY1SO6xSvJFHzOPXRKM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721905146;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+s8HYX954RevvEABrcX+VxedGvuIf4BNutRXY9xqAbc=;
	b=xt3FxY9eYVe5IsNGjM7/RLnUh8Sr85K1mEPCUG2QHgCAVoYu5junqaC13L1Gr2BnLNIdad
	NNT6jHY9IDmsS5CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 58B2E13874;
	Thu, 25 Jul 2024 10:59:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id F3qiFfovomaEUwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 25 Jul 2024 10:59:06 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 11B84A0996; Thu, 25 Jul 2024 12:59:06 +0200 (CEST)
Date: Thu, 25 Jul 2024 12:59:06 +0200
From: Jan Kara <jack@suse.cz>
To: libaokun@huaweicloud.com
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
	jack@suse.cz, ritesh.list@gmail.com, linux-kernel@vger.kernel.org,
	yi.zhang@huawei.com, yangerkun@huawei.com,
	Baokun Li <libaokun1@huawei.com>
Subject: Re: [PATCH 11/20] ext4: get rid of ppath in ext4_ext_insert_extent()
Message-ID: <20240725105906.4oab5gqt7ekjgkji@quack3>
References: <20240710040654.1714672-1-libaokun@huaweicloud.com>
 <20240710040654.1714672-12-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710040654.1714672-12-libaokun@huaweicloud.com>
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 6A0BC21B37
X-Spam-Score: -2.31
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.31 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,mit.edu,dilger.ca,suse.cz,gmail.com,huawei.com];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	RCPT_COUNT_SEVEN(0.00)[10];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,huawei.com:email,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,huaweicloud.com:email]

On Wed 10-07-24 12:06:45, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 
> The use of path and ppath is now very confusing, so to make the code more
> readable, pass path between functions uniformly, and get rid of ppath.
> 
> To get rid of the ppath in ext4_ext_insert_extent(), the following is done
> here:
> 
>  * Free the extents path when an error is encountered.
>  * Its caller needs to update ppath if it uses ppath.
>  * Free path when npath is used, free npath when it is not used.
>  * The got_allocated_blocks label in ext4_ext_map_blocks() does not
>    update err now, so err is updated to 0 if the err returned by
>    ext4_ext_search_right() is greater than 0 and is about to enter
>    got_allocated_blocks.
> 
> No functional changes.
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/ext4.h        |  7 ++--
>  fs/ext4/extents.c     | 88 ++++++++++++++++++++++++-------------------
>  fs/ext4/fast_commit.c |  8 ++--
>  fs/ext4/migrate.c     |  5 ++-
>  4 files changed, 61 insertions(+), 47 deletions(-)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index cbe8d6062c52..53b4c1f454e6 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -3710,9 +3710,10 @@ extern int ext4_map_blocks(handle_t *handle, struct inode *inode,
>  extern int ext4_ext_calc_credits_for_single_extent(struct inode *inode,
>  						   int num,
>  						   struct ext4_ext_path *path);
> -extern int ext4_ext_insert_extent(handle_t *, struct inode *,
> -				  struct ext4_ext_path **,
> -				  struct ext4_extent *, int);
> +extern struct ext4_ext_path *ext4_ext_insert_extent(
> +				handle_t *handle, struct inode *inode,
> +				struct ext4_ext_path *path,
> +				struct ext4_extent *newext, int gb_flags);
>  extern struct ext4_ext_path *ext4_find_extent(struct inode *, ext4_lblk_t,
>  					      struct ext4_ext_path *,
>  					      int flags);
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index 0d6ce9e74b01..fc75390d591a 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -1974,16 +1974,15 @@ static unsigned int ext4_ext_check_overlap(struct ext4_sb_info *sbi,
>   * inserts requested extent as new one into the tree,
>   * creating new leaf in the no-space case.
>   */
> -int ext4_ext_insert_extent(handle_t *handle, struct inode *inode,
> -				struct ext4_ext_path **ppath,
> -				struct ext4_extent *newext, int gb_flags)
> +struct ext4_ext_path *
> +ext4_ext_insert_extent(handle_t *handle, struct inode *inode,
> +		       struct ext4_ext_path *path,
> +		       struct ext4_extent *newext, int gb_flags)
>  {
> -	struct ext4_ext_path *path = *ppath;
>  	struct ext4_extent_header *eh;
>  	struct ext4_extent *ex, *fex;
>  	struct ext4_extent *nearex; /* nearest extent */
> -	struct ext4_ext_path *npath = NULL;
> -	int depth, len, err;
> +	int depth, len, err = 0;
>  	ext4_lblk_t next;
>  	int mb_flags = 0, unwritten;
>  
> @@ -1991,14 +1990,16 @@ int ext4_ext_insert_extent(handle_t *handle, struct inode *inode,
>  		mb_flags |= EXT4_MB_DELALLOC_RESERVED;
>  	if (unlikely(ext4_ext_get_actual_len(newext) == 0)) {
>  		EXT4_ERROR_INODE(inode, "ext4_ext_get_actual_len(newext) == 0");
> -		return -EFSCORRUPTED;
> +		err = -EFSCORRUPTED;
> +		goto errout;
>  	}
>  	depth = ext_depth(inode);
>  	ex = path[depth].p_ext;
>  	eh = path[depth].p_hdr;
>  	if (unlikely(path[depth].p_hdr == NULL)) {
>  		EXT4_ERROR_INODE(inode, "path[%d].p_hdr == NULL", depth);
> -		return -EFSCORRUPTED;
> +		err = -EFSCORRUPTED;
> +		goto errout;
>  	}
>  
>  	/* try to insert block into found extent and return */
> @@ -2036,7 +2037,7 @@ int ext4_ext_insert_extent(handle_t *handle, struct inode *inode,
>  			err = ext4_ext_get_access(handle, inode,
>  						  path + depth);
>  			if (err)
> -				return err;
> +				goto errout;
>  			unwritten = ext4_ext_is_unwritten(ex);
>  			ex->ee_len = cpu_to_le16(ext4_ext_get_actual_len(ex)
>  					+ ext4_ext_get_actual_len(newext));
> @@ -2061,7 +2062,7 @@ int ext4_ext_insert_extent(handle_t *handle, struct inode *inode,
>  			err = ext4_ext_get_access(handle, inode,
>  						  path + depth);
>  			if (err)
> -				return err;
> +				goto errout;
>  
>  			unwritten = ext4_ext_is_unwritten(ex);
>  			ex->ee_block = newext->ee_block;
> @@ -2086,21 +2087,26 @@ int ext4_ext_insert_extent(handle_t *handle, struct inode *inode,
>  	if (le32_to_cpu(newext->ee_block) > le32_to_cpu(fex->ee_block))
>  		next = ext4_ext_next_leaf_block(path);
>  	if (next != EXT_MAX_BLOCKS) {
> +		struct ext4_ext_path *npath;
> +
>  		ext_debug(inode, "next leaf block - %u\n", next);
> -		BUG_ON(npath != NULL);
>  		npath = ext4_find_extent(inode, next, NULL, gb_flags);
> -		if (IS_ERR(npath))
> -			return PTR_ERR(npath);
> +		if (IS_ERR(npath)) {
> +			err = PTR_ERR(npath);
> +			goto errout;
> +		}
>  		BUG_ON(npath->p_depth != path->p_depth);
>  		eh = npath[depth].p_hdr;
>  		if (le16_to_cpu(eh->eh_entries) < le16_to_cpu(eh->eh_max)) {
>  			ext_debug(inode, "next leaf isn't full(%d)\n",
>  				  le16_to_cpu(eh->eh_entries));
> +			ext4_free_ext_path(path);
>  			path = npath;
>  			goto has_space;
>  		}
>  		ext_debug(inode, "next leaf has no free space(%d,%d)\n",
>  			  le16_to_cpu(eh->eh_entries), le16_to_cpu(eh->eh_max));
> +		ext4_free_ext_path(npath);
>  	}
>  
>  	/*
> @@ -2111,12 +2117,8 @@ int ext4_ext_insert_extent(handle_t *handle, struct inode *inode,
>  		mb_flags |= EXT4_MB_USE_RESERVED;
>  	path = ext4_ext_create_new_leaf(handle, inode, mb_flags, gb_flags,
>  					path, newext);
> -	if (IS_ERR(path)) {
> -		*ppath = NULL;
> -		err = PTR_ERR(path);
> -		goto cleanup;
> -	}
> -	*ppath = path;
> +	if (IS_ERR(path))
> +		return path;
>  	depth = ext_depth(inode);
>  	eh = path[depth].p_hdr;
>  
> @@ -2125,7 +2127,7 @@ int ext4_ext_insert_extent(handle_t *handle, struct inode *inode,
>  
>  	err = ext4_ext_get_access(handle, inode, path + depth);
>  	if (err)
> -		goto cleanup;
> +		goto errout;
>  
>  	if (!nearex) {
>  		/* there is no extent in this leaf, create first one */
> @@ -2183,17 +2185,20 @@ int ext4_ext_insert_extent(handle_t *handle, struct inode *inode,
>  	if (!(gb_flags & EXT4_GET_BLOCKS_PRE_IO))
>  		ext4_ext_try_to_merge(handle, inode, path, nearex);
>  
> -
>  	/* time to correct all indexes above */
>  	err = ext4_ext_correct_indexes(handle, inode, path);
>  	if (err)
> -		goto cleanup;
> +		goto errout;
>  
>  	err = ext4_ext_dirty(handle, inode, path + path->p_depth);
> +	if (err)
> +		goto errout;
>  
> -cleanup:
> -	ext4_free_ext_path(npath);
> -	return err;
> +	return path;
> +
> +errout:
> +	ext4_free_ext_path(path);
> +	return ERR_PTR(err);
>  }
>  
>  static int ext4_fill_es_cache_info(struct inode *inode,
> @@ -3248,24 +3253,29 @@ static int ext4_split_extent_at(handle_t *handle,
>  	if (split_flag & EXT4_EXT_MARK_UNWRIT2)
>  		ext4_ext_mark_unwritten(ex2);
>  
> -	err = ext4_ext_insert_extent(handle, inode, ppath, &newex, flags);
> -	if (err != -ENOSPC && err != -EDQUOT && err != -ENOMEM)
> +	path = ext4_ext_insert_extent(handle, inode, path, &newex, flags);
> +	if (!IS_ERR(path)) {
> +		*ppath = path;
>  		goto out;
> +	}
> +	*ppath = NULL;
> +	err = PTR_ERR(path);
> +	if (err != -ENOSPC && err != -EDQUOT && err != -ENOMEM)
> +		return err;
>  
>  	/*
> -	 * Update path is required because previous ext4_ext_insert_extent()
> -	 * may have freed or reallocated the path. Using EXT4_EX_NOFAIL
> -	 * guarantees that ext4_find_extent() will not return -ENOMEM,
> -	 * otherwise -ENOMEM will cause a retry in do_writepages(), and a
> -	 * WARN_ON may be triggered in ext4_da_update_reserve_space() due to
> -	 * an incorrect ee_len causing the i_reserved_data_blocks exception.
> +	 * Get a new path to try to zeroout or fix the extent length.
> +	 * Using EXT4_EX_NOFAIL guarantees that ext4_find_extent()
> +	 * will not return -ENOMEM, otherwise -ENOMEM will cause a
> +	 * retry in do_writepages(), and a WARN_ON may be triggered
> +	 * in ext4_da_update_reserve_space() due to an incorrect
> +	 * ee_len causing the i_reserved_data_blocks exception.
>  	 */
> -	path = ext4_find_extent(inode, ee_block, *ppath,
> +	path = ext4_find_extent(inode, ee_block, NULL,
>  				flags | EXT4_EX_NOFAIL);
>  	if (IS_ERR(path)) {
>  		EXT4_ERROR_INODE(inode, "Failed split extent on %u, err %ld",
>  				 split, PTR_ERR(path));
> -		*ppath = NULL;
>  		return PTR_ERR(path);
>  	}
>  	depth = ext_depth(inode);
> @@ -3324,7 +3334,7 @@ static int ext4_split_extent_at(handle_t *handle,
>  	ext4_ext_dirty(handle, inode, path + path->p_depth);
>  	return err;
>  out:
> -	ext4_ext_show_leaf(inode, *ppath);
> +	ext4_ext_show_leaf(inode, path);
>  	return err;
>  }
>  
> @@ -4313,6 +4323,7 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
>  	    get_implied_cluster_alloc(inode->i_sb, map, &ex2, path)) {
>  		ar.len = allocated = map->m_len;
>  		newblock = map->m_pblk;
> +		err = 0;
>  		goto got_allocated_blocks;
>  	}
>  
> @@ -4385,8 +4396,9 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
>  		map->m_flags |= EXT4_MAP_UNWRITTEN;
>  	}
>  
> -	err = ext4_ext_insert_extent(handle, inode, &path, &newex, flags);
> -	if (err) {
> +	path = ext4_ext_insert_extent(handle, inode, path, &newex, flags);
> +	if (IS_ERR(path)) {
> +		err = PTR_ERR(path);
>  		if (allocated_clusters) {
>  			int fb_flags = 0;
>  
> diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
> index 87c009e0c59a..1dee40477727 100644
> --- a/fs/ext4/fast_commit.c
> +++ b/fs/ext4/fast_commit.c
> @@ -1777,12 +1777,12 @@ static int ext4_fc_replay_add_range(struct super_block *sb,
>  			if (ext4_ext_is_unwritten(ex))
>  				ext4_ext_mark_unwritten(&newex);
>  			down_write(&EXT4_I(inode)->i_data_sem);
> -			ret = ext4_ext_insert_extent(
> -				NULL, inode, &path, &newex, 0);
> +			path = ext4_ext_insert_extent(NULL, inode,
> +						      path, &newex, 0);
>  			up_write((&EXT4_I(inode)->i_data_sem));
> -			ext4_free_ext_path(path);
> -			if (ret)
> +			if (IS_ERR(path))
>  				goto out;
> +			ext4_free_ext_path(path);
>  			goto next;
>  		}
>  
> diff --git a/fs/ext4/migrate.c b/fs/ext4/migrate.c
> index d98ac2af8199..0f68b8a14560 100644
> --- a/fs/ext4/migrate.c
> +++ b/fs/ext4/migrate.c
> @@ -37,7 +37,6 @@ static int finish_range(handle_t *handle, struct inode *inode,
>  	path = ext4_find_extent(inode, lb->first_block, NULL, 0);
>  	if (IS_ERR(path)) {
>  		retval = PTR_ERR(path);
> -		path = NULL;
>  		goto err_out;
>  	}
>  
> @@ -53,7 +52,9 @@ static int finish_range(handle_t *handle, struct inode *inode,
>  	retval = ext4_datasem_ensure_credits(handle, inode, needed, needed, 0);
>  	if (retval < 0)
>  		goto err_out;
> -	retval = ext4_ext_insert_extent(handle, inode, &path, &newext, 0);
> +	path = ext4_ext_insert_extent(handle, inode, path, &newext, 0);
> +	if (IS_ERR(path))
> +		retval = PTR_ERR(path);
>  err_out:
>  	up_write((&EXT4_I(inode)->i_data_sem));
>  	ext4_free_ext_path(path);
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

