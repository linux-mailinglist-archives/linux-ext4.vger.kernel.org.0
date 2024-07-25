Return-Path: <linux-ext4+bounces-3450-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E0393C06C
	for <lists+linux-ext4@lfdr.de>; Thu, 25 Jul 2024 12:48:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00565280EF0
	for <lists+linux-ext4@lfdr.de>; Thu, 25 Jul 2024 10:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02809199221;
	Thu, 25 Jul 2024 10:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="K1hzo4/e";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="p3RN5eaC";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="K1hzo4/e";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="p3RN5eaC"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3D0198A31;
	Thu, 25 Jul 2024 10:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721904392; cv=none; b=rx+Ue9GffG+H0BGDCRWUa7PMtpFGZMqu8BZHYFc5JAnif8WxMjXdyKsJIMIp4XxM1qKCMfivq4IO7HH12bWMut21r7Q7l0gtmR4ZjROxopzbc0L3p/qbGREYPtthzFdENvay4q0qk1myhtAs/LQFC0PyEd7epbZUzSEED+ij3XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721904392; c=relaxed/simple;
	bh=umJt6Rj1F75Nd8wFupB9WpN9p8T9zTBswhHf4ig+m5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ThB3MiiY0phP6LB/qXTViyPh2L0YMVoRl3Gv+J5ARiMIT+ZvPMJ2mV15F5Qq2qOiN6kIRcFeUF+GtVxuANIYTdkQ1HhDpjPBLraftEGTE7z/EytJbpyM7IDC2JMesLELYlT+loc3gcdroP9TGr+QWEdMHvyr4KhBD/V2QMh9Ic0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=K1hzo4/e; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=p3RN5eaC; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=K1hzo4/e; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=p3RN5eaC; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CC2341F7B2;
	Thu, 25 Jul 2024 10:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721904388; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m0hZY2LQplqTXHXKQs8ulG2dniDeQFGiScHfMpj3t1o=;
	b=K1hzo4/eSnhCY3zCgchMYNjsJBwIUFr3OMVH7iEFD0+2MJOt86Q/vBGghXa9zB7YuRKvKL
	ncwAakQAW0cVkS4ULk2aemzRlRx86nRPjVp+vc98rwWkMCLXj+utEBFbHC4f0JvM9lyaad
	jUdM/ARSJCDLF9EK7FmH4cF9my0ucJk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721904388;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m0hZY2LQplqTXHXKQs8ulG2dniDeQFGiScHfMpj3t1o=;
	b=p3RN5eaCsRdvV6kLLZC2WnXncKxQ5bjVrrOj8TuJOfAipBnHESC5VUfyg8DnauhQobZj/m
	RceVy+I4AWEvptAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721904388; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m0hZY2LQplqTXHXKQs8ulG2dniDeQFGiScHfMpj3t1o=;
	b=K1hzo4/eSnhCY3zCgchMYNjsJBwIUFr3OMVH7iEFD0+2MJOt86Q/vBGghXa9zB7YuRKvKL
	ncwAakQAW0cVkS4ULk2aemzRlRx86nRPjVp+vc98rwWkMCLXj+utEBFbHC4f0JvM9lyaad
	jUdM/ARSJCDLF9EK7FmH4cF9my0ucJk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721904388;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m0hZY2LQplqTXHXKQs8ulG2dniDeQFGiScHfMpj3t1o=;
	b=p3RN5eaCsRdvV6kLLZC2WnXncKxQ5bjVrrOj8TuJOfAipBnHESC5VUfyg8DnauhQobZj/m
	RceVy+I4AWEvptAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C25C613874;
	Thu, 25 Jul 2024 10:46:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tSlvLwQtomaRTwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 25 Jul 2024 10:46:28 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 7DAD2A0996; Thu, 25 Jul 2024 12:46:24 +0200 (CEST)
Date: Thu, 25 Jul 2024 12:46:24 +0200
From: Jan Kara <jack@suse.cz>
To: libaokun@huaweicloud.com
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
	jack@suse.cz, ritesh.list@gmail.com, linux-kernel@vger.kernel.org,
	yi.zhang@huawei.com, yangerkun@huawei.com,
	Baokun Li <libaokun1@huawei.com>
Subject: Re: [PATCH 10/20] ext4: get rid of ppath in
 ext4_ext_create_new_leaf()
Message-ID: <20240725104624.v73lgnkrojxaiuig@quack3>
References: <20240710040654.1714672-1-libaokun@huaweicloud.com>
 <20240710040654.1714672-11-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710040654.1714672-11-libaokun@huaweicloud.com>
X-Spam-Level: 
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,huawei.com:email,suse.cz:email,imap1.dmz-prg2.suse.org:helo,huaweicloud.com:email]
X-Spam-Flag: NO
X-Spam-Score: -2.10

On Wed 10-07-24 12:06:44, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 
> The use of path and ppath is now very confusing, so to make the code more
> readable, pass path between functions uniformly, and get rid of ppath.
> 
> To get rid of the ppath in ext4_ext_create_new_leaf(), the following is
> done here:
> 
>  * Free the extents path when an error is encountered.
>  * Its caller needs to update ppath if it uses ppath.
> 
> No functional changes.
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Just one nit below. Otherwise feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

> @@ -1424,28 +1423,24 @@ static int ext4_ext_create_new_leaf(handle_t *handle, struct inode *inode,
>  		 * entry: create all needed subtree and add new leaf */
>  		err = ext4_ext_split(handle, inode, mb_flags, path, newext, i);
>  		if (err)
> -			goto out;
> +			goto errout;
>  
>  		/* refill path */
>  		path = ext4_find_extent(inode,
>  				    (ext4_lblk_t)le32_to_cpu(newext->ee_block),
>  				    path, gb_flags);
> -		if (IS_ERR(path))
> -			err = PTR_ERR(path);

So I'd rather have here:
		return path;

That way it's obvious we will not confuse some code below with error stored
in 'path' and we can also save one indentation level by removing 'else'
below (probably do reindenting in a separate patch).

								Honza

>  	} else {
>  		/* tree is full, time to grow in depth */
>  		err = ext4_ext_grow_indepth(handle, inode, mb_flags);
>  		if (err)
> -			goto out;
> +			goto errout;
>  
>  		/* refill path */
>  		path = ext4_find_extent(inode,
>  				   (ext4_lblk_t)le32_to_cpu(newext->ee_block),
>  				    path, gb_flags);
> -		if (IS_ERR(path)) {
> -			err = PTR_ERR(path);
> -			goto out;
> -		}
> +		if (IS_ERR(path))
> +			return path;
>  
>  		/*
>  		 * only first (depth 0 -> 1) produces free space;
> @@ -1457,9 +1452,11 @@ static int ext4_ext_create_new_leaf(handle_t *handle, struct inode *inode,
>  			goto repeat;
>  		}
>  	}
> -out:
> -	*ppath = IS_ERR(path) ? NULL : path;
> -	return err;
> +	return path;
> +
> +errout:
> +	ext4_free_ext_path(path);
> +	return ERR_PTR(err);
>  }
>  
>  /*
> @@ -2112,10 +2109,14 @@ int ext4_ext_insert_extent(handle_t *handle, struct inode *inode,
>  	 */
>  	if (gb_flags & EXT4_GET_BLOCKS_METADATA_NOFAIL)
>  		mb_flags |= EXT4_MB_USE_RESERVED;
> -	err = ext4_ext_create_new_leaf(handle, inode, mb_flags, gb_flags,
> -				       ppath, newext);
> -	if (err)
> +	path = ext4_ext_create_new_leaf(handle, inode, mb_flags, gb_flags,
> +					path, newext);
> +	if (IS_ERR(path)) {
> +		*ppath = NULL;
> +		err = PTR_ERR(path);
>  		goto cleanup;
> +	}
> +	*ppath = path;
>  	depth = ext_depth(inode);
>  	eh = path[depth].p_hdr;
>  
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

