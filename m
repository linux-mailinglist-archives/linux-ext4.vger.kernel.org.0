Return-Path: <linux-ext4+bounces-3458-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1092A93C1E3
	for <lists+linux-ext4@lfdr.de>; Thu, 25 Jul 2024 14:23:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 337381C21C4B
	for <lists+linux-ext4@lfdr.de>; Thu, 25 Jul 2024 12:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C300D19A2A5;
	Thu, 25 Jul 2024 12:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wmZH0MyF";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="BS1wWNcz";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wmZH0MyF";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="BS1wWNcz"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B191993B2;
	Thu, 25 Jul 2024 12:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721910160; cv=none; b=uIQ4w7rY8PoopI2XH73ZMkIcRW5Zd2tlmmePquLDWEHcxyJ5tkKMS++USq59rDl0C5/u+Du0yE1l6Uco+mkcAhjL46cWA/yFD/Djt8GMaMs6hZaUu2zzUomkyoBZ0KFonfP1Ibp6G940FaX/6hnmr5IM+tXc86rALk5vkVC6RvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721910160; c=relaxed/simple;
	bh=ChXfpYlS1wwk5feS/h6qNwS7SXDQ9JmfQ0RwzDBkpes=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AkfotOgRIqcbsCaZKjuWU3zh0BysT+e0S6VSIdqjbWg+yFgnwLy57fx4HMhZOS9gv/icASwdnM7FGN+GwSQ7uSO6sjO593vKBOKrDrao62tRcMWJYfCemi0jYw7X3TGX6eEyc9XNZuI3RLeA1Hd8vLACtewbvn0hWoC7UpMc270=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wmZH0MyF; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=BS1wWNcz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wmZH0MyF; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=BS1wWNcz; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6F7B01F7E2;
	Thu, 25 Jul 2024 12:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721910156; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JAkLSUirsUtrp5xJYVZ5B08ry6+Hvbg1dZgzIxssxbk=;
	b=wmZH0MyF9pRtBzotOshmF+FofrvY5WI/OYeEaOgi9qyQarx6w8VFuuCqzCnnlhFAU4Scz9
	jJw6Yzu3sIBSF09oGNRYFUUJPV0pM8Sdf7yGmJvS5H7Jt9Krr4TMNgHo23hVnxKT9y2MSj
	MHY50ruMNDQkKRIdM3kB0Jx3X5t5MWU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721910156;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JAkLSUirsUtrp5xJYVZ5B08ry6+Hvbg1dZgzIxssxbk=;
	b=BS1wWNczPqGR78NPGdo5QU3ngaI7U/ZELSNharavNJfLk9VkbFPC3mig6HozPRtYRbJXIo
	f/EelLoxHmEH7dDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721910156; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JAkLSUirsUtrp5xJYVZ5B08ry6+Hvbg1dZgzIxssxbk=;
	b=wmZH0MyF9pRtBzotOshmF+FofrvY5WI/OYeEaOgi9qyQarx6w8VFuuCqzCnnlhFAU4Scz9
	jJw6Yzu3sIBSF09oGNRYFUUJPV0pM8Sdf7yGmJvS5H7Jt9Krr4TMNgHo23hVnxKT9y2MSj
	MHY50ruMNDQkKRIdM3kB0Jx3X5t5MWU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721910156;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JAkLSUirsUtrp5xJYVZ5B08ry6+Hvbg1dZgzIxssxbk=;
	b=BS1wWNczPqGR78NPGdo5QU3ngaI7U/ZELSNharavNJfLk9VkbFPC3mig6HozPRtYRbJXIo
	f/EelLoxHmEH7dDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 573951368A;
	Thu, 25 Jul 2024 12:22:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fJ3qFIxDomZ5bAAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 25 Jul 2024 12:22:36 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id E98B6A0996; Thu, 25 Jul 2024 14:22:35 +0200 (CEST)
Date: Thu, 25 Jul 2024 14:22:35 +0200
From: Jan Kara <jack@suse.cz>
To: libaokun@huaweicloud.com
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
	jack@suse.cz, ritesh.list@gmail.com, linux-kernel@vger.kernel.org,
	yi.zhang@huawei.com, yangerkun@huawei.com,
	Baokun Li <libaokun1@huawei.com>
Subject: Re: [PATCH 18/20] ext4: get rid of ppath in
 ext4_ext_handle_unwritten_extents()
Message-ID: <20240725122235.oy72kt4qciek3giz@quack3>
References: <20240710040654.1714672-1-libaokun@huaweicloud.com>
 <20240710040654.1714672-19-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710040654.1714672-19-libaokun@huaweicloud.com>
X-Spamd-Result: default: False [-2.10 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_LAST(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,mit.edu,dilger.ca,suse.cz,gmail.com,huawei.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.com:email,imap1.dmz-prg2.suse.org:helo,huaweicloud.com:email,huawei.com:email]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.10

On Wed 10-07-24 12:06:52, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 
> The use of path and ppath is now very confusing, so to make the code more
> readable, pass path between functions uniformly, and get rid of ppath.
> 
> To get rid of the ppath in ext4_ext_handle_unwritten_extents(), the
> following is done here:
> 
>  * Free the extents path when an error is encountered.
>  * The 'allocated' is changed from passing a value to passing an address.
> 
> No functional changes.
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/extents.c | 82 +++++++++++++++++++++--------------------------
>  1 file changed, 37 insertions(+), 45 deletions(-)
> 
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index 59e80926fe3a..badadcd64e66 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -3887,18 +3887,18 @@ convert_initialized_extent(handle_t *handle, struct inode *inode,
>  	return 0;
>  }
>  
> -static int
> +static struct ext4_ext_path *
>  ext4_ext_handle_unwritten_extents(handle_t *handle, struct inode *inode,
>  			struct ext4_map_blocks *map,
> -			struct ext4_ext_path **ppath, int flags,
> -			unsigned int allocated, ext4_fsblk_t newblock)
> +			struct ext4_ext_path *path, int flags,
> +			unsigned int *allocated, ext4_fsblk_t newblock)
>  {
>  	int err = 0;
>  
>  	ext_debug(inode, "logical block %llu, max_blocks %u, flags 0x%x, allocated %u\n",
>  		  (unsigned long long)map->m_lblk, map->m_len, flags,
> -		  allocated);
> -	ext4_ext_show_leaf(inode, *ppath);
> +		  *allocated);
> +	ext4_ext_show_leaf(inode, path);
>  
>  	/*
>  	 * When writing into unwritten space, we should not fail to
> @@ -3907,40 +3907,34 @@ ext4_ext_handle_unwritten_extents(handle_t *handle, struct inode *inode,
>  	flags |= EXT4_GET_BLOCKS_METADATA_NOFAIL;
>  
>  	trace_ext4_ext_handle_unwritten_extents(inode, map, flags,
> -						    allocated, newblock);
> +						*allocated, newblock);
>  
>  	/* get_block() before submitting IO, split the extent */
>  	if (flags & EXT4_GET_BLOCKS_PRE_IO) {
> -		*ppath = ext4_split_convert_extents(handle, inode, map, *ppath,
> -				flags | EXT4_GET_BLOCKS_CONVERT, &allocated);
> -		if (IS_ERR(*ppath)) {
> -			err = PTR_ERR(*ppath);
> -			*ppath = NULL;
> -			goto out2;
> -		}
> +		path = ext4_split_convert_extents(handle, inode, map, path,
> +				flags | EXT4_GET_BLOCKS_CONVERT, allocated);
> +		if (IS_ERR(path))
> +			return path;
>  		/*
>  		 * shouldn't get a 0 allocated when splitting an extent unless
>  		 * m_len is 0 (bug) or extent has been corrupted
>  		 */
> -		if (unlikely(allocated == 0)) {
> +		if (unlikely(*allocated == 0)) {
>  			EXT4_ERROR_INODE(inode,
>  					 "unexpected allocated == 0, m_len = %u",
>  					 map->m_len);
>  			err = -EFSCORRUPTED;
> -			goto out2;
> +			goto errout;
>  		}
>  		map->m_flags |= EXT4_MAP_UNWRITTEN;
>  		goto out;
>  	}
>  	/* IO end_io complete, convert the filled extent to written */
>  	if (flags & EXT4_GET_BLOCKS_CONVERT) {
> -		*ppath = ext4_convert_unwritten_extents_endio(handle, inode,
> -							      map, *ppath);
> -		if (IS_ERR(*ppath)) {
> -			err = PTR_ERR(*ppath);
> -			*ppath = NULL;
> -			goto out2;
> -		}
> +		path = ext4_convert_unwritten_extents_endio(handle, inode,
> +							    map, path);
> +		if (IS_ERR(path))
> +			return path;
>  		ext4_update_inode_fsync_trans(handle, inode, 1);
>  		goto map_out;
>  	}
> @@ -3972,23 +3966,20 @@ ext4_ext_handle_unwritten_extents(handle_t *handle, struct inode *inode,
>  	 * For buffered writes, at writepage time, etc.  Convert a
>  	 * discovered unwritten extent to written.
>  	 */
> -	*ppath = ext4_ext_convert_to_initialized(handle, inode, map, *ppath,
> -						 flags, &allocated);
> -	if (IS_ERR(*ppath)) {
> -		err = PTR_ERR(*ppath);
> -		*ppath = NULL;
> -		goto out2;
> -	}
> +	path = ext4_ext_convert_to_initialized(handle, inode, map, path,
> +					       flags, allocated);
> +	if (IS_ERR(path))
> +		return path;
>  	ext4_update_inode_fsync_trans(handle, inode, 1);
>  	/*
>  	 * shouldn't get a 0 allocated when converting an unwritten extent
>  	 * unless m_len is 0 (bug) or extent has been corrupted
>  	 */
> -	if (unlikely(allocated == 0)) {
> +	if (unlikely(*allocated == 0)) {
>  		EXT4_ERROR_INODE(inode, "unexpected allocated == 0, m_len = %u",
>  				 map->m_len);
>  		err = -EFSCORRUPTED;
> -		goto out2;
> +		goto errout;
>  	}
>  
>  out:
> @@ -3997,12 +3988,15 @@ ext4_ext_handle_unwritten_extents(handle_t *handle, struct inode *inode,
>  	map->m_flags |= EXT4_MAP_MAPPED;
>  out1:
>  	map->m_pblk = newblock;
> -	if (allocated > map->m_len)
> -		allocated = map->m_len;
> -	map->m_len = allocated;
> -	ext4_ext_show_leaf(inode, *ppath);
> -out2:
> -	return err ? err : allocated;
> +	if (*allocated > map->m_len)
> +		*allocated = map->m_len;
> +	map->m_len = *allocated;
> +	ext4_ext_show_leaf(inode, path);
> +	return path;
> +
> +errout:
> +	ext4_free_ext_path(path);
> +	return ERR_PTR(err);
>  }
>  
>  /*
> @@ -4199,7 +4193,7 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
>  	struct ext4_extent newex, *ex, ex2;
>  	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
>  	ext4_fsblk_t newblock = 0, pblk;
> -	int err = 0, depth, ret;
> +	int err = 0, depth;
>  	unsigned int allocated = 0, offset = 0;
>  	unsigned int allocated_clusters = 0;
>  	struct ext4_allocation_request ar;
> @@ -4273,13 +4267,11 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
>  				goto out;
>  			}
>  
> -			ret = ext4_ext_handle_unwritten_extents(
> -				handle, inode, map, &path, flags,
> -				allocated, newblock);
> -			if (ret < 0)
> -				err = ret;
> -			else
> -				allocated = ret;
> +			path = ext4_ext_handle_unwritten_extents(
> +				handle, inode, map, path, flags,
> +				&allocated, newblock);
> +			if (IS_ERR(path))
> +				err = PTR_ERR(path);
>  			goto out;
>  		}
>  	}
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

