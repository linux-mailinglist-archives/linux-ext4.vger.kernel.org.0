Return-Path: <linux-ext4+bounces-3455-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ADC693C176
	for <lists+linux-ext4@lfdr.de>; Thu, 25 Jul 2024 14:12:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E78B81F2160A
	for <lists+linux-ext4@lfdr.de>; Thu, 25 Jul 2024 12:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98F65199380;
	Thu, 25 Jul 2024 12:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ypKCQm/n";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5miCrkg/";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ypKCQm/n";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5miCrkg/"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D7B22089;
	Thu, 25 Jul 2024 12:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721909548; cv=none; b=IDqLrsp7MhsOKt5jErhnxelekX/2u6kse8MVmWoM7TkasItngMXRvXGwj4ctqHeLHrqMDBmWpby6uGn/3BaVsKLlkVuTW/9nwhMFyKaTCiylwI6tCy1IjxAB3WFV0oHou6UdE7w3aRWHN6h/ZW1207+a7K2mWaW8x1s6GISpXMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721909548; c=relaxed/simple;
	bh=Ff/59HRlCvj8G3mMo2jas7O6Ju8LyZiYxAQ43k+O+eM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N0A6i9R5BK1S1XSFrMnBL4CMXu0mya4slWm8cPBJ9Y+WOtgspqXpYnuwYCH1YkYqnbiox3/KE6u95WjX3ufFkKGZGikFqkG4c252ADKSZ0uQPWo5oPzFn2giKJJ2k9gvGjM9VdZp9ASiwZ2RefYV0FgDRDUTutpkqf3YvPwCSxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ypKCQm/n; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5miCrkg/; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ypKCQm/n; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5miCrkg/; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9114621B2B;
	Thu, 25 Jul 2024 12:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721909544; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CEoJzGyLhtj1CXvSKWZkCZtZwfPh3vxj2e0OM8FawtM=;
	b=ypKCQm/nSDrPHEEa2PMWe06VYYoR6CO+ROfN4yD90VG7Q6tYUjDYTOmMcUz7+PmJEhySyJ
	YZ6vI5io2h8577vA/d4vknOxHEN0IpiPHvirj+hCmuVoT+oHukYGgWQon0P89O5EwUtOuQ
	0ZQp1HN4ZoB7ksbgEQhiWOly94t3N/I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721909544;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CEoJzGyLhtj1CXvSKWZkCZtZwfPh3vxj2e0OM8FawtM=;
	b=5miCrkg/68uZ1uz+07r307UfDKB0pkfx1yySKDMZfT0ojaqaS5AOeUpRxrwUcjG217PYOw
	yUTuAWLGvSCYxOBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721909544; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CEoJzGyLhtj1CXvSKWZkCZtZwfPh3vxj2e0OM8FawtM=;
	b=ypKCQm/nSDrPHEEa2PMWe06VYYoR6CO+ROfN4yD90VG7Q6tYUjDYTOmMcUz7+PmJEhySyJ
	YZ6vI5io2h8577vA/d4vknOxHEN0IpiPHvirj+hCmuVoT+oHukYGgWQon0P89O5EwUtOuQ
	0ZQp1HN4ZoB7ksbgEQhiWOly94t3N/I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721909544;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CEoJzGyLhtj1CXvSKWZkCZtZwfPh3vxj2e0OM8FawtM=;
	b=5miCrkg/68uZ1uz+07r307UfDKB0pkfx1yySKDMZfT0ojaqaS5AOeUpRxrwUcjG217PYOw
	yUTuAWLGvSCYxOBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 804061368A;
	Thu, 25 Jul 2024 12:12:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Cv1HHyhBomZ6aQAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 25 Jul 2024 12:12:24 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 0E559A0996; Thu, 25 Jul 2024 14:12:16 +0200 (CEST)
Date: Thu, 25 Jul 2024 14:12:16 +0200
From: Jan Kara <jack@suse.cz>
To: libaokun@huaweicloud.com
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
	jack@suse.cz, ritesh.list@gmail.com, linux-kernel@vger.kernel.org,
	yi.zhang@huawei.com, yangerkun@huawei.com,
	Baokun Li <libaokun1@huawei.com>
Subject: Re: [PATCH 15/20] ext4: get rid of ppath in
 ext4_split_convert_extents()
Message-ID: <20240725121216.mlmmyobjvyjjnln6@quack3>
References: <20240710040654.1714672-1-libaokun@huaweicloud.com>
 <20240710040654.1714672-16-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710040654.1714672-16-libaokun@huaweicloud.com>
X-Spam-Level: 
X-Spamd-Result: default: False [0.90 / 50.00];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,mit.edu,dilger.ca,suse.cz,gmail.com,huawei.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.com:email,huaweicloud.com:email,huawei.com:email]
X-Spam-Flag: NO
X-Spam-Score: 0.90

On Wed 10-07-24 12:06:49, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 
> The use of path and ppath is now very confusing, so to make the code more
> readable, pass path between functions uniformly, and get rid of ppath.
> 
> To get rid of the ppath in ext4_split_convert_extents(), the following is
> done here:
> 
>  * Its caller needs to update ppath if it uses ppath.
> 
> No functional changes.
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza


> ---
>  fs/ext4/extents.c | 65 ++++++++++++++++++++++++-----------------------
>  1 file changed, 33 insertions(+), 32 deletions(-)
> 
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index 2a4f6c89858c..a41cbb8c4475 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -3699,21 +3699,21 @@ static int ext4_ext_convert_to_initialized(handle_t *handle,
>   * being filled will be convert to initialized by the end_io callback function
>   * via ext4_convert_unwritten_extents().
>   *
> - * Returns the size of unwritten extent to be written on success.
> + * The size of unwritten extent to be written is passed to the caller via the
> + * allocated pointer. Return an extent path pointer on success, or an error
> + * pointer on failure.
>   */
> -static int ext4_split_convert_extents(handle_t *handle,
> +static struct ext4_ext_path *ext4_split_convert_extents(handle_t *handle,
>  					struct inode *inode,
>  					struct ext4_map_blocks *map,
> -					struct ext4_ext_path **ppath,
> -					int flags)
> +					struct ext4_ext_path *path,
> +					int flags, unsigned int *allocated)
>  {
> -	struct ext4_ext_path *path = *ppath;
>  	ext4_lblk_t eof_block;
>  	ext4_lblk_t ee_block;
>  	struct ext4_extent *ex;
>  	unsigned int ee_len;
>  	int split_flag = 0, depth;
> -	unsigned int allocated = 0;
>  
>  	ext_debug(inode, "logical block %llu, max_blocks %u\n",
>  		  (unsigned long long)map->m_lblk, map->m_len);
> @@ -3741,14 +3741,8 @@ static int ext4_split_convert_extents(handle_t *handle,
>  		split_flag |= (EXT4_EXT_MARK_UNWRIT2 | EXT4_EXT_DATA_VALID2);
>  	}
>  	flags |= EXT4_GET_BLOCKS_PRE_IO;
> -	path = ext4_split_extent(handle, inode, path, map, split_flag, flags,
> -				 &allocated);
> -	if (IS_ERR(path)) {
> -		*ppath = NULL;
> -		return PTR_ERR(path);
> -	}
> -	*ppath = path;
> -	return allocated;
> +	return ext4_split_extent(handle, inode, path, map, split_flag, flags,
> +				 allocated);
>  }
>  
>  static int ext4_convert_unwritten_extents_endio(handle_t *handle,
> @@ -3784,11 +3778,14 @@ static int ext4_convert_unwritten_extents_endio(handle_t *handle,
>  			     inode->i_ino, (unsigned long long)ee_block, ee_len,
>  			     (unsigned long long)map->m_lblk, map->m_len);
>  #endif
> -		err = ext4_split_convert_extents(handle, inode, map, ppath,
> -						 EXT4_GET_BLOCKS_CONVERT);
> -		if (err < 0)
> -			return err;
> -		path = ext4_find_extent(inode, map->m_lblk, *ppath, 0);
> +		path = ext4_split_convert_extents(handle, inode, map, path,
> +						EXT4_GET_BLOCKS_CONVERT, NULL);
> +		if (IS_ERR(path)) {
> +			*ppath = NULL;
> +			return PTR_ERR(path);
> +		}
> +
> +		path = ext4_find_extent(inode, map->m_lblk, path, 0);
>  		if (IS_ERR(path)) {
>  			*ppath = NULL;
>  			return PTR_ERR(path);
> @@ -3845,11 +3842,14 @@ convert_initialized_extent(handle_t *handle, struct inode *inode,
>  		  (unsigned long long)ee_block, ee_len);
>  
>  	if (ee_block != map->m_lblk || ee_len > map->m_len) {
> -		err = ext4_split_convert_extents(handle, inode, map, ppath,
> -				EXT4_GET_BLOCKS_CONVERT_UNWRITTEN);
> -		if (err < 0)
> -			return err;
> -		path = ext4_find_extent(inode, map->m_lblk, *ppath, 0);
> +		path = ext4_split_convert_extents(handle, inode, map, path,
> +				EXT4_GET_BLOCKS_CONVERT_UNWRITTEN, NULL);
> +		if (IS_ERR(path)) {
> +			*ppath = NULL;
> +			return PTR_ERR(path);
> +		}
> +
> +		path = ext4_find_extent(inode, map->m_lblk, path, 0);
>  		if (IS_ERR(path)) {
>  			*ppath = NULL;
>  			return PTR_ERR(path);
> @@ -3915,19 +3915,20 @@ ext4_ext_handle_unwritten_extents(handle_t *handle, struct inode *inode,
>  
>  	/* get_block() before submitting IO, split the extent */
>  	if (flags & EXT4_GET_BLOCKS_PRE_IO) {
> -		ret = ext4_split_convert_extents(handle, inode, map, ppath,
> -					 flags | EXT4_GET_BLOCKS_CONVERT);
> -		if (ret < 0) {
> -			err = ret;
> +		*ppath = ext4_split_convert_extents(handle, inode, map, *ppath,
> +				flags | EXT4_GET_BLOCKS_CONVERT, &allocated);
> +		if (IS_ERR(*ppath)) {
> +			err = PTR_ERR(*ppath);
> +			*ppath = NULL;
>  			goto out2;
>  		}
>  		/*
> -		 * shouldn't get a 0 return when splitting an extent unless
> +		 * shouldn't get a 0 allocated when splitting an extent unless
>  		 * m_len is 0 (bug) or extent has been corrupted
>  		 */
> -		if (unlikely(ret == 0)) {
> +		if (unlikely(allocated == 0)) {
>  			EXT4_ERROR_INODE(inode,
> -					 "unexpected ret == 0, m_len = %u",
> +					 "unexpected allocated == 0, m_len = %u",
>  					 map->m_len);
>  			err = -EFSCORRUPTED;
>  			goto out2;
> @@ -3988,9 +3989,9 @@ ext4_ext_handle_unwritten_extents(handle_t *handle, struct inode *inode,
>  		err = -EFSCORRUPTED;
>  		goto out2;
>  	}
> +	allocated = ret;
>  
>  out:
> -	allocated = ret;
>  	map->m_flags |= EXT4_MAP_NEW;
>  map_out:
>  	map->m_flags |= EXT4_MAP_MAPPED;
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

