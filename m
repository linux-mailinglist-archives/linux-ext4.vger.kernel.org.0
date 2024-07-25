Return-Path: <linux-ext4+bounces-3454-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19A4093C16F
	for <lists+linux-ext4@lfdr.de>; Thu, 25 Jul 2024 14:08:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 309B91C2189B
	for <lists+linux-ext4@lfdr.de>; Thu, 25 Jul 2024 12:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A71FC199246;
	Thu, 25 Jul 2024 12:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KFi5gTqi";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9YuC0nGb";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wZ04mj0C";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0fdCM9QW"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F235122089;
	Thu, 25 Jul 2024 12:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721909288; cv=none; b=B3qee/JypUjD7HrGC7Vh3WRqQskj+pvoOU+WJwmRb0UzoiADn7tGggVWXZ99dDba6JkXns+aj1AZGOSDyNkOWgyRJxtKF2SW5bnAobwsumdfjorBKJy9LeCaptTdPkpmnz3FaqByIb5yPV7QfS8+HfT7JbMzjOqknhjAStcXoXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721909288; c=relaxed/simple;
	bh=bJ9vsHC11lZMna560ivrxe+33O4CSQEBQOjfrYwn9Ng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=You3EtH4eivU6vayO+1rW4gNBc4mOOBikIhxvy+PVmxlH3BaYDFK9JnFHA8xz1HXdIVsZNxHwwVo1sQRCG1c/fqqMTXxMiV4P0zTe3k8/YhMNW+i7/kP1fid0WRtHScKg0fmM25HeTg5+BRS56dR6MC+ues+HxAOV/LtT2py558=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KFi5gTqi; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9YuC0nGb; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wZ04mj0C; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0fdCM9QW; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C001121B1B;
	Thu, 25 Jul 2024 12:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721909284; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o0j3c9BQCEwz91ND1sko5oUmnVHgGFyYjukjBeyAOTY=;
	b=KFi5gTqikIhaZYca83Fivdao9XXIFW4JJhgw+ei6riAiaxL7vtHkjNEkiqUOXnBhMH3wHj
	Ql78wQ2qs0AUfo8FEyPE+UjsKaTpusyPGM9AIkMfjVaNhG2mTQLLihL0DRXwQCZN0aZy5E
	U+kwGbD1HEF5bTgwlwHfKcHMcpa/hcs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721909284;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o0j3c9BQCEwz91ND1sko5oUmnVHgGFyYjukjBeyAOTY=;
	b=9YuC0nGbW31a2WbHAdiPk9vJvnEsnCWigOIIk8O+A0S6j7xj8HsjB/9EM9mAJbDpukN2Gw
	RdSeBjyLkDPPI3DA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721909282; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o0j3c9BQCEwz91ND1sko5oUmnVHgGFyYjukjBeyAOTY=;
	b=wZ04mj0CMHx0t7xpIZKCdJfsaoBFBt+Ws6z7BHVpFwoTNgVuUEuczFD4XpXNq7vyfD3xIe
	jjld24EqJjFvd5y11DsVgww/qH9j8aVUD7tjQo2A43vh6qlaZQgcB7NNf1DzBnIOQxsH4r
	Do1xMOS6u74tX+2VE/PWqLU6dZf6VXA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721909282;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o0j3c9BQCEwz91ND1sko5oUmnVHgGFyYjukjBeyAOTY=;
	b=0fdCM9QWW7V4BhJTqRrFNsqv8i2ILO7igNpq3SNq2TzMRggU8pjQ6FA+0ScTkoeEKxeenx
	YCjSRXwu1i2PagCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AFE561368A;
	Thu, 25 Jul 2024 12:08:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id auPlKiJAomZOaAAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 25 Jul 2024 12:08:02 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 6407CA0996; Thu, 25 Jul 2024 14:07:54 +0200 (CEST)
Date: Thu, 25 Jul 2024 14:07:54 +0200
From: Jan Kara <jack@suse.cz>
To: libaokun@huaweicloud.com
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
	jack@suse.cz, ritesh.list@gmail.com, linux-kernel@vger.kernel.org,
	yi.zhang@huawei.com, yangerkun@huawei.com,
	Baokun Li <libaokun1@huawei.com>
Subject: Re: [PATCH 14/20] ext4: get rid of ppath in ext4_split_extent()
Message-ID: <20240725120754.q6wfgluukul33vh3@quack3>
References: <20240710040654.1714672-1-libaokun@huaweicloud.com>
 <20240710040654.1714672-15-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710040654.1714672-15-libaokun@huaweicloud.com>
X-Spamd-Result: default: False [-2.10 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,mit.edu,dilger.ca,suse.cz,gmail.com,huawei.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huaweicloud.com:email,huawei.com:email,suse.com:email,imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.10

On Wed 10-07-24 12:06:48, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 
> The use of path and ppath is now very confusing, so to make the code more
> readable, pass path between functions uniformly, and get rid of ppath.
> 
> To get rid of the ppath in ext4_split_extent(), the following is done here:
> 
>  * The 'allocated' is changed from passing a value to passing an address.
>  * Its caller needs to update ppath if it uses ppath.
> 
> No functional changes.
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/extents.c | 97 ++++++++++++++++++++++++-----------------------
>  1 file changed, 50 insertions(+), 47 deletions(-)
> 
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index 0bd068ed324f..2a4f6c89858c 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -3345,21 +3345,18 @@ static struct ext4_ext_path *ext4_split_extent_at(handle_t *handle,
>   *   c> Splits in three extents: Somone is splitting in middle of the extent
>   *
>   */
> -static int ext4_split_extent(handle_t *handle,
> -			      struct inode *inode,
> -			      struct ext4_ext_path **ppath,
> -			      struct ext4_map_blocks *map,
> -			      int split_flag,
> -			      int flags)
> +static struct ext4_ext_path *ext4_split_extent(handle_t *handle,
> +					       struct inode *inode,
> +					       struct ext4_ext_path *path,
> +					       struct ext4_map_blocks *map,
> +					       int split_flag, int flags,
> +					       unsigned int *allocated)
>  {
> -	struct ext4_ext_path *path = *ppath;
>  	ext4_lblk_t ee_block;
>  	struct ext4_extent *ex;
>  	unsigned int ee_len, depth;
> -	int err = 0;
>  	int unwritten;
>  	int split_flag1, flags1;
> -	int allocated = map->m_len;
>  
>  	depth = ext_depth(inode);
>  	ex = path[depth].p_ext;
> @@ -3377,33 +3374,25 @@ static int ext4_split_extent(handle_t *handle,
>  			split_flag1 |= EXT4_EXT_DATA_VALID1;
>  		path = ext4_split_extent_at(handle, inode, path,
>  				map->m_lblk + map->m_len, split_flag1, flags1);
> -		if (IS_ERR(path)) {
> -			err = PTR_ERR(path);
> -			*ppath = NULL;
> -			goto out;
> +		if (IS_ERR(path))
> +			return path;
> +		/*
> +		 * Update path is required because previous ext4_split_extent_at
> +		 * may result in split of original leaf or extent zeroout.
> +		 */
> +		path = ext4_find_extent(inode, map->m_lblk, path, flags);
> +		if (IS_ERR(path))
> +			return path;
> +		depth = ext_depth(inode);
> +		ex = path[depth].p_ext;
> +		if (!ex) {
> +			EXT4_ERROR_INODE(inode, "unexpected hole at %lu",
> +					(unsigned long) map->m_lblk);
> +			ext4_free_ext_path(path);
> +			return ERR_PTR(-EFSCORRUPTED);
>  		}
> -		*ppath = path;
> -	} else {
> -		allocated = ee_len - (map->m_lblk - ee_block);
> -	}
> -	/*
> -	 * Update path is required because previous ext4_split_extent_at() may
> -	 * result in split of original leaf or extent zeroout.
> -	 */
> -	path = ext4_find_extent(inode, map->m_lblk, path, flags);
> -	if (IS_ERR(path)) {
> -		*ppath = NULL;
> -		return PTR_ERR(path);
> -	}
> -	*ppath = path;
> -	depth = ext_depth(inode);
> -	ex = path[depth].p_ext;
> -	if (!ex) {
> -		EXT4_ERROR_INODE(inode, "unexpected hole at %lu",
> -				 (unsigned long) map->m_lblk);
> -		return -EFSCORRUPTED;
> +		unwritten = ext4_ext_is_unwritten(ex);
>  	}
> -	unwritten = ext4_ext_is_unwritten(ex);
>  
>  	if (map->m_lblk >= ee_block) {
>  		split_flag1 = split_flag & EXT4_EXT_DATA_VALID2;
> @@ -3414,17 +3403,18 @@ static int ext4_split_extent(handle_t *handle,
>  		}
>  		path = ext4_split_extent_at(handle, inode, path,
>  				map->m_lblk, split_flag1, flags);
> -		if (IS_ERR(path)) {
> -			err = PTR_ERR(path);
> -			*ppath = NULL;
> -			goto out;
> -		}
> -		*ppath = path;
> +		if (IS_ERR(path))
> +			return path;
>  	}
>  
> +	if (allocated) {
> +		if (map->m_lblk + map->m_len > ee_block + ee_len)
> +			*allocated = ee_len - (map->m_lblk - ee_block);
> +		else
> +			*allocated = map->m_len;
> +	}
>  	ext4_ext_show_leaf(inode, path);
> -out:
> -	return err ? err : allocated;
> +	return path;
>  }
>  
>  /*
> @@ -3669,10 +3659,15 @@ static int ext4_ext_convert_to_initialized(handle_t *handle,
>  	}
>  
>  fallback:
> -	err = ext4_split_extent(handle, inode, ppath, &split_map, split_flag,
> -				flags);
> -	if (err > 0)
> -		err = 0;
> +	path = ext4_split_extent(handle, inode, path, &split_map, split_flag,
> +				 flags, NULL);
> +	if (IS_ERR(path)) {
> +		err = PTR_ERR(path);
> +		*ppath = NULL;
> +		goto out;
> +	}
> +	err = 0;
> +	*ppath = path;
>  out:
>  	/* If we have gotten a failure, don't zero out status tree */
>  	if (!err) {
> @@ -3718,6 +3713,7 @@ static int ext4_split_convert_extents(handle_t *handle,
>  	struct ext4_extent *ex;
>  	unsigned int ee_len;
>  	int split_flag = 0, depth;
> +	unsigned int allocated = 0;
>  
>  	ext_debug(inode, "logical block %llu, max_blocks %u\n",
>  		  (unsigned long long)map->m_lblk, map->m_len);
> @@ -3745,7 +3741,14 @@ static int ext4_split_convert_extents(handle_t *handle,
>  		split_flag |= (EXT4_EXT_MARK_UNWRIT2 | EXT4_EXT_DATA_VALID2);
>  	}
>  	flags |= EXT4_GET_BLOCKS_PRE_IO;
> -	return ext4_split_extent(handle, inode, ppath, map, split_flag, flags);
> +	path = ext4_split_extent(handle, inode, path, map, split_flag, flags,
> +				 &allocated);
> +	if (IS_ERR(path)) {
> +		*ppath = NULL;
> +		return PTR_ERR(path);
> +	}
> +	*ppath = path;
> +	return allocated;
>  }
>  
>  static int ext4_convert_unwritten_extents_endio(handle_t *handle,
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

