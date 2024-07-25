Return-Path: <linux-ext4+bounces-3457-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C4093C1C7
	for <lists+linux-ext4@lfdr.de>; Thu, 25 Jul 2024 14:21:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 211841F26F59
	for <lists+linux-ext4@lfdr.de>; Thu, 25 Jul 2024 12:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1D4719AD5E;
	Thu, 25 Jul 2024 12:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Yzd+8f8b";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ewnr3FjM";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Yzd+8f8b";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ewnr3FjM"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513DA19AA76;
	Thu, 25 Jul 2024 12:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721909903; cv=none; b=o97JsevDdsPiMz4jA+U6PX0HZnYYlYdWzQnLi7zfIvCKnNX4so3HQwN8owwmsXxMF6F1aU+KePIr7EAH+uQG+iFcjM91taV2ZHtSPLq04DRoA211YjVPH2fJ/1enQpho32IQixYNq/bWSEXiAAL7Zmv8Biwr/MS1LzOqHMp/LMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721909903; c=relaxed/simple;
	bh=jkb8Klg/bPt2GJaJRVQFsOMdXVEc6aqTnDDSiX5/NA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lvu5hBwPAfFD+mk4Ge0zeHYJUXWjky9/WSEWI4LWNpLtHusZviGo9D1GP5snimmuSchYFsEIHJAKyN/piP+l9DQ0A+gcr58XS6S5+DZmIyp6Tf0h5DvosZd0CmoqVeGpTskiw95a+nBSZhy0E7n+4YQu97b9fjl/OgIhj+Dll1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Yzd+8f8b; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ewnr3FjM; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Yzd+8f8b; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ewnr3FjM; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5D7781F45A;
	Thu, 25 Jul 2024 12:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721909899; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9qsspf/ZvVz7trhlr563UsK7mzD/eYjq9BgdMJzgM3A=;
	b=Yzd+8f8bbkKo6GSUXW7gxUlSNbByrEjE0nSXwMDNRzAh7QdKiNJZIOpsGzwrht3Jp+WOBK
	6dAoBjJflJo0d2IjFA72Gg2FwwuEH6UzD1wQNdqnkPM1sVV0eTJv/Mih8peVwwJ6YTGLao
	Vr27pujNMZgbHbbELunx7h7fpQ7KHXQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721909899;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9qsspf/ZvVz7trhlr563UsK7mzD/eYjq9BgdMJzgM3A=;
	b=Ewnr3FjM67IhGKRHmVWPExyM8lLxah0q3fTwNVcVRju3r1+T9+wM94WVULxAK+wsfUB4/n
	w4domEPPFSsp9HCA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Yzd+8f8b;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Ewnr3FjM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721909899; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9qsspf/ZvVz7trhlr563UsK7mzD/eYjq9BgdMJzgM3A=;
	b=Yzd+8f8bbkKo6GSUXW7gxUlSNbByrEjE0nSXwMDNRzAh7QdKiNJZIOpsGzwrht3Jp+WOBK
	6dAoBjJflJo0d2IjFA72Gg2FwwuEH6UzD1wQNdqnkPM1sVV0eTJv/Mih8peVwwJ6YTGLao
	Vr27pujNMZgbHbbELunx7h7fpQ7KHXQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721909899;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9qsspf/ZvVz7trhlr563UsK7mzD/eYjq9BgdMJzgM3A=;
	b=Ewnr3FjM67IhGKRHmVWPExyM8lLxah0q3fTwNVcVRju3r1+T9+wM94WVULxAK+wsfUB4/n
	w4domEPPFSsp9HCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4D0AF1368A;
	Thu, 25 Jul 2024 12:18:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1tDIEotComZRawAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 25 Jul 2024 12:18:19 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id ED9B0A0996; Thu, 25 Jul 2024 14:18:03 +0200 (CEST)
Date: Thu, 25 Jul 2024 14:18:03 +0200
From: Jan Kara <jack@suse.cz>
To: libaokun@huaweicloud.com
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
	jack@suse.cz, ritesh.list@gmail.com, linux-kernel@vger.kernel.org,
	yi.zhang@huawei.com, yangerkun@huawei.com,
	Baokun Li <libaokun1@huawei.com>
Subject: Re: [PATCH 17/20] ext4: get rid of ppath in
 ext4_ext_convert_to_initialized()
Message-ID: <20240725121803.bsfnpchwk5rvq6gg@quack3>
References: <20240710040654.1714672-1-libaokun@huaweicloud.com>
 <20240710040654.1714672-18-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710040654.1714672-18-libaokun@huaweicloud.com>
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 5D7781F45A
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
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[10];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,huawei.com:email,huaweicloud.com:email]

On Wed 10-07-24 12:06:51, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 
> The use of path and ppath is now very confusing, so to make the code more
> readable, pass path between functions uniformly, and get rid of ppath.
> 
> To get rid of the ppath in ext4_ext_convert_to_initialized(), the following
> is done here:
> 
>  * Free the extents path when an error is encountered.
>  * Its caller needs to update ppath if it uses ppath.
>  * The 'allocated' is changed from passing a value to passing an address.
> 
> No functional changes.
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/extents.c | 73 +++++++++++++++++++++++------------------------
>  1 file changed, 35 insertions(+), 38 deletions(-)
> 
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index b7f443f98e9d..59e80926fe3a 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -3437,13 +3437,11 @@ static struct ext4_ext_path *ext4_split_extent(handle_t *handle,
>   *    that are allocated and initialized.
>   *    It is guaranteed to be >= map->m_len.
>   */
> -static int ext4_ext_convert_to_initialized(handle_t *handle,
> -					   struct inode *inode,
> -					   struct ext4_map_blocks *map,
> -					   struct ext4_ext_path **ppath,
> -					   int flags)
> +static struct ext4_ext_path *
> +ext4_ext_convert_to_initialized(handle_t *handle, struct inode *inode,
> +			struct ext4_map_blocks *map, struct ext4_ext_path *path,
> +			int flags, unsigned int *allocated)
>  {
> -	struct ext4_ext_path *path = *ppath;
>  	struct ext4_sb_info *sbi;
>  	struct ext4_extent_header *eh;
>  	struct ext4_map_blocks split_map;
> @@ -3453,7 +3451,6 @@ static int ext4_ext_convert_to_initialized(handle_t *handle,
>  	unsigned int ee_len, depth, map_len = map->m_len;
>  	int err = 0;
>  	int split_flag = EXT4_EXT_DATA_VALID2;
> -	int allocated = 0;
>  	unsigned int max_zeroout = 0;
>  
>  	ext_debug(inode, "logical block %llu, max_blocks %u\n",
> @@ -3494,6 +3491,7 @@ static int ext4_ext_convert_to_initialized(handle_t *handle,
>  	 *  - L2: we only attempt to merge with an extent stored in the
>  	 *    same extent tree node.
>  	 */
> +	*allocated = 0;
>  	if ((map->m_lblk == ee_block) &&
>  		/* See if we can merge left */
>  		(map_len < ee_len) &&		/*L1*/
> @@ -3523,7 +3521,7 @@ static int ext4_ext_convert_to_initialized(handle_t *handle,
>  			(prev_len < (EXT_INIT_MAX_LEN - map_len))) {	/*C4*/
>  			err = ext4_ext_get_access(handle, inode, path + depth);
>  			if (err)
> -				goto out;
> +				goto errout;
>  
>  			trace_ext4_ext_convert_to_initialized_fastpath(inode,
>  				map, ex, abut_ex);
> @@ -3538,7 +3536,7 @@ static int ext4_ext_convert_to_initialized(handle_t *handle,
>  			abut_ex->ee_len = cpu_to_le16(prev_len + map_len);
>  
>  			/* Result: number of initialized blocks past m_lblk */
> -			allocated = map_len;
> +			*allocated = map_len;
>  		}
>  	} else if (((map->m_lblk + map_len) == (ee_block + ee_len)) &&
>  		   (map_len < ee_len) &&	/*L1*/
> @@ -3569,7 +3567,7 @@ static int ext4_ext_convert_to_initialized(handle_t *handle,
>  		    (next_len < (EXT_INIT_MAX_LEN - map_len))) {	/*C4*/
>  			err = ext4_ext_get_access(handle, inode, path + depth);
>  			if (err)
> -				goto out;
> +				goto errout;
>  
>  			trace_ext4_ext_convert_to_initialized_fastpath(inode,
>  				map, ex, abut_ex);
> @@ -3584,18 +3582,20 @@ static int ext4_ext_convert_to_initialized(handle_t *handle,
>  			abut_ex->ee_len = cpu_to_le16(next_len + map_len);
>  
>  			/* Result: number of initialized blocks past m_lblk */
> -			allocated = map_len;
> +			*allocated = map_len;
>  		}
>  	}
> -	if (allocated) {
> +	if (*allocated) {
>  		/* Mark the block containing both extents as dirty */
>  		err = ext4_ext_dirty(handle, inode, path + depth);
>  
>  		/* Update path to point to the right extent */
>  		path[depth].p_ext = abut_ex;
> +		if (err)
> +			goto errout;
>  		goto out;
>  	} else
> -		allocated = ee_len - (map->m_lblk - ee_block);
> +		*allocated = ee_len - (map->m_lblk - ee_block);
>  
>  	WARN_ON(map->m_lblk < ee_block);
>  	/*
> @@ -3622,21 +3622,21 @@ static int ext4_ext_convert_to_initialized(handle_t *handle,
>  	split_map.m_lblk = map->m_lblk;
>  	split_map.m_len = map->m_len;
>  
> -	if (max_zeroout && (allocated > split_map.m_len)) {
> -		if (allocated <= max_zeroout) {
> +	if (max_zeroout && (*allocated > split_map.m_len)) {
> +		if (*allocated <= max_zeroout) {
>  			/* case 3 or 5 */
>  			zero_ex1.ee_block =
>  				 cpu_to_le32(split_map.m_lblk +
>  					     split_map.m_len);
>  			zero_ex1.ee_len =
> -				cpu_to_le16(allocated - split_map.m_len);
> +				cpu_to_le16(*allocated - split_map.m_len);
>  			ext4_ext_store_pblock(&zero_ex1,
>  				ext4_ext_pblock(ex) + split_map.m_lblk +
>  				split_map.m_len - ee_block);
>  			err = ext4_ext_zeroout(inode, &zero_ex1);
>  			if (err)
>  				goto fallback;
> -			split_map.m_len = allocated;
> +			split_map.m_len = *allocated;
>  		}
>  		if (split_map.m_lblk - ee_block + split_map.m_len <
>  								max_zeroout) {
> @@ -3654,27 +3654,24 @@ static int ext4_ext_convert_to_initialized(handle_t *handle,
>  
>  			split_map.m_len += split_map.m_lblk - ee_block;
>  			split_map.m_lblk = ee_block;
> -			allocated = map->m_len;
> +			*allocated = map->m_len;
>  		}
>  	}
>  
>  fallback:
>  	path = ext4_split_extent(handle, inode, path, &split_map, split_flag,
>  				 flags, NULL);
> -	if (IS_ERR(path)) {
> -		err = PTR_ERR(path);
> -		*ppath = NULL;
> -		goto out;
> -	}
> -	err = 0;
> -	*ppath = path;
> +	if (IS_ERR(path))
> +		return path;
>  out:
>  	/* If we have gotten a failure, don't zero out status tree */
> -	if (!err) {
> -		ext4_zeroout_es(inode, &zero_ex1);
> -		ext4_zeroout_es(inode, &zero_ex2);
> -	}
> -	return err ? err : allocated;
> +	ext4_zeroout_es(inode, &zero_ex1);
> +	ext4_zeroout_es(inode, &zero_ex2);
> +	return path;
> +
> +errout:
> +	ext4_free_ext_path(path);
> +	return ERR_PTR(err);
>  }
>  
>  /*
> @@ -3896,7 +3893,6 @@ ext4_ext_handle_unwritten_extents(handle_t *handle, struct inode *inode,
>  			struct ext4_ext_path **ppath, int flags,
>  			unsigned int allocated, ext4_fsblk_t newblock)
>  {
> -	int ret = 0;
>  	int err = 0;
>  
>  	ext_debug(inode, "logical block %llu, max_blocks %u, flags 0x%x, allocated %u\n",
> @@ -3976,23 +3972,24 @@ ext4_ext_handle_unwritten_extents(handle_t *handle, struct inode *inode,
>  	 * For buffered writes, at writepage time, etc.  Convert a
>  	 * discovered unwritten extent to written.
>  	 */
> -	ret = ext4_ext_convert_to_initialized(handle, inode, map, ppath, flags);
> -	if (ret < 0) {
> -		err = ret;
> +	*ppath = ext4_ext_convert_to_initialized(handle, inode, map, *ppath,
> +						 flags, &allocated);
> +	if (IS_ERR(*ppath)) {
> +		err = PTR_ERR(*ppath);
> +		*ppath = NULL;
>  		goto out2;
>  	}
>  	ext4_update_inode_fsync_trans(handle, inode, 1);
>  	/*
> -	 * shouldn't get a 0 return when converting an unwritten extent
> +	 * shouldn't get a 0 allocated when converting an unwritten extent
>  	 * unless m_len is 0 (bug) or extent has been corrupted
>  	 */
> -	if (unlikely(ret == 0)) {
> -		EXT4_ERROR_INODE(inode, "unexpected ret == 0, m_len = %u",
> +	if (unlikely(allocated == 0)) {
> +		EXT4_ERROR_INODE(inode, "unexpected allocated == 0, m_len = %u",
>  				 map->m_len);
>  		err = -EFSCORRUPTED;
>  		goto out2;
>  	}
> -	allocated = ret;
>  
>  out:
>  	map->m_flags |= EXT4_MAP_NEW;
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

