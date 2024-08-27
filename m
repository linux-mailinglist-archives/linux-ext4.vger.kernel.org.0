Return-Path: <linux-ext4+bounces-3922-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B2B961547
	for <lists+linux-ext4@lfdr.de>; Tue, 27 Aug 2024 19:16:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAA3D1C22E95
	for <lists+linux-ext4@lfdr.de>; Tue, 27 Aug 2024 17:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D62201CF28F;
	Tue, 27 Aug 2024 17:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="DEO8f6Vu";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ThrCG66A";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="zLFsx+H+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="29UJV7eu"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3E71BFE02;
	Tue, 27 Aug 2024 17:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724778986; cv=none; b=AFol5346n373SMUAhemjiCBqqWXP2CUslWxhSeTAcSdq6epqa9IxZR/RSFBP9PJT69kmvsgtZfJxHDIs2zT+CSoPDQBkMNRaZIN5XoTepwTM/3YtgU9044I8UDd2QNUx1VQU2NAJz+gxy/AfPlB9OFYJ4VQfQCxY1ZV0yqXdUMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724778986; c=relaxed/simple;
	bh=Y7t5rJddbLUq4n+i3+yj2m5zP8CQT2c4swpDMAFftrs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PYLHjMdBZZ8oXRwzCfnR+Pr3rfZHPe6M3qhifVrxRakYTkwnIx5E/CgZwhRaI8FctQ/I7jfPrY8Nx29kcBIOMq56vjY3xjhbJUZJujfzRaDnMF5NB4KxYvXWAZjOHdbD9cMiGtudb2Y/zBNnGJ3tCl+jtEVfDCWt9X9ifv1K0go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=DEO8f6Vu; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ThrCG66A; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=zLFsx+H+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=29UJV7eu; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0A09721B19;
	Tue, 27 Aug 2024 17:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724778982; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C/1ifMX9yXxtn8apWIAaHKF/yept+COR9CswO4IlPRE=;
	b=DEO8f6VuykTkHL6lEDkpL0tWP1fMgcqPgQmE1JEMK4h+7TY9+ecK6XTeBZMKP5HCBZwMty
	DS4JGgGz6GN7cf/ZbcHetyxENraz700QlYxSfxVXcD6446uc27oKyFgc+L3Dh1eR74vFwr
	rjmRBWG7DwxeJ1rH/li00OF/qcNK6mg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724778982;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C/1ifMX9yXxtn8apWIAaHKF/yept+COR9CswO4IlPRE=;
	b=ThrCG66AublzdcD+79+IdwKuULZx2IJt4pj7zmcTByQwnFF4EiJoDpTE27l72bX9jxvz8a
	KHoV2tBPyD8TzjCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724778981; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C/1ifMX9yXxtn8apWIAaHKF/yept+COR9CswO4IlPRE=;
	b=zLFsx+H+owd5RVnJPCn+KvRu0yCIICd+U5kl+CkbVhd877aU58VOS7K5UtREYcfYW7kmcA
	e3RUG8VHuK+kOAk6WaYLRXVUCbkH6TR7j52SKSy4eIkY0F15SYGQrkw+gAy8q0pvmkMGBM
	7mxa4riAuOcWNctN/3F994eBiqaSyis=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724778981;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C/1ifMX9yXxtn8apWIAaHKF/yept+COR9CswO4IlPRE=;
	b=29UJV7euQ+FlEg+Teu3B1g46+j4suzFyse2lLIUB5PYLp3SPg3ASHo9ceWL2dXnYqVV1HB
	80HzZdEnd12qcCDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EA88B13724;
	Tue, 27 Aug 2024 17:16:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XVI+OeQJzmbhRwAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 27 Aug 2024 17:16:20 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 844AAA0968; Tue, 27 Aug 2024 19:16:20 +0200 (CEST)
Date: Tue, 27 Aug 2024 19:16:20 +0200
From: Jan Kara <jack@suse.cz>
To: libaokun@huaweicloud.com
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
	jack@suse.cz, ritesh.list@gmail.com, ojaswin@linux.ibm.com,
	linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
	yangerkun@huawei.com, Baokun Li <libaokun1@huawei.com>
Subject: Re: [PATCH v2 25/25] ext4: save unnecessary indentation in
 ext4_ext_create_new_leaf()
Message-ID: <20240827171620.jrnp32rcmqu36wp4@quack3>
References: <20240822023545.1994557-1-libaokun@huaweicloud.com>
 <20240822023545.1994557-26-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240822023545.1994557-26-libaokun@huaweicloud.com>
X-Spam-Score: -2.30
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,mit.edu,dilger.ca,suse.cz,gmail.com,linux.ibm.com,huawei.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,huawei.com:email,huaweicloud.com:email,suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

On Thu 22-08-24 10:35:45, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 
> Save an indentation level in ext4_ext_create_new_leaf() by removing
> unnecessary 'else'. Besides, the variable 'ee_block' is declared to
> avoid line breaks. No functional changes.
> 
> Suggested-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/extents.c | 44 +++++++++++++++++++++-----------------------
>  1 file changed, 21 insertions(+), 23 deletions(-)
> 
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index ca1f946514dd..45ddc0692673 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -1403,6 +1403,7 @@ ext4_ext_create_new_leaf(handle_t *handle, struct inode *inode,
>  {
>  	struct ext4_ext_path *curp;
>  	int depth, i, err = 0;
> +	ext4_lblk_t ee_block = le32_to_cpu(newext->ee_block);
>  
>  repeat:
>  	i = depth = ext_depth(inode);
> @@ -1424,33 +1425,30 @@ ext4_ext_create_new_leaf(handle_t *handle, struct inode *inode,
>  			goto errout;
>  
>  		/* refill path */
> -		path = ext4_find_extent(inode,
> -				    (ext4_lblk_t)le32_to_cpu(newext->ee_block),
> -				    path, gb_flags);
> +		path = ext4_find_extent(inode, ee_block, path, gb_flags);
>  		return path;
> -	} else {
> -		/* tree is full, time to grow in depth */
> -		err = ext4_ext_grow_indepth(handle, inode, mb_flags);
> -		if (err)
> -			goto errout;
> +	}
>  
> -		/* refill path */
> -		path = ext4_find_extent(inode,
> -				   (ext4_lblk_t)le32_to_cpu(newext->ee_block),
> -				    path, gb_flags);
> -		if (IS_ERR(path))
> -			return path;
> +	/* tree is full, time to grow in depth */
> +	err = ext4_ext_grow_indepth(handle, inode, mb_flags);
> +	if (err)
> +		goto errout;
>  
> -		/*
> -		 * only first (depth 0 -> 1) produces free space;
> -		 * in all other cases we have to split the grown tree
> -		 */
> -		depth = ext_depth(inode);
> -		if (path[depth].p_hdr->eh_entries == path[depth].p_hdr->eh_max) {
> -			/* now we need to split */
> -			goto repeat;
> -		}
> +	/* refill path */
> +	path = ext4_find_extent(inode, ee_block, path, gb_flags);
> +	if (IS_ERR(path))
> +		return path;
> +
> +	/*
> +	 * only first (depth 0 -> 1) produces free space;
> +	 * in all other cases we have to split the grown tree
> +	 */
> +	depth = ext_depth(inode);
> +	if (path[depth].p_hdr->eh_entries == path[depth].p_hdr->eh_max) {
> +		/* now we need to split */
> +		goto repeat;
>  	}
> +
>  	return path;
>  
>  errout:
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

