Return-Path: <linux-ext4+bounces-3456-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C413693C187
	for <lists+linux-ext4@lfdr.de>; Thu, 25 Jul 2024 14:14:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A5072821CD
	for <lists+linux-ext4@lfdr.de>; Thu, 25 Jul 2024 12:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E65B199E9F;
	Thu, 25 Jul 2024 12:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="iQ9FTfxx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5mEuSs5K";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="iQ9FTfxx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5mEuSs5K"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BDFB16D9C9;
	Thu, 25 Jul 2024 12:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721909650; cv=none; b=J1IDl8+3jDl2tdJC7X8GktLMt/QWNC+qe1ic2FYh8JLSVVgeY7alLoLT0L57nnX1HcEsAWUNN9Q/aogNNBO8m4QDxbU/i0fuwkNYc+Q0MCN1xsfk9tT3BZxZek+BFjBKJqHiPqzjU0ay7Rx5U79PXj6qCOdA2jH/6qC2hiSqS9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721909650; c=relaxed/simple;
	bh=74d0sZIaKoaqavr5fm4ghUak0m3jHxaQ9g6xb6jAkjw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GETlTuyO4KPBpznBia+p0ZSyWNRKkfTTpyLbPc7U7uBS8SNf4aDEfAdizHpHOHJUDovoL/X6xKB0+MCkO2RucSQbxBm3FHTzp+IL5eXxUhsZ0pfawEXeKbhJuxxBOWMoGSolKk4nvjdIrlpklT+WTlwI2rSTHKuhHQ0fTQIa1So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=iQ9FTfxx; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5mEuSs5K; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=iQ9FTfxx; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5mEuSs5K; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 37F5B1F806;
	Thu, 25 Jul 2024 12:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721909646; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KMzzsysTjBt5gFEEIQsfeQ538IzgNTp9XOSYU4lJhlQ=;
	b=iQ9FTfxxAveMJxqolev5Q76ZuOxz9m0uhO7EIjjlfQEuavYHI9QtV30rMwJB2tX6MfHXO7
	/87jGCAxNsmgohd1teOYmjcqD7nIYhoTCR5Tr0POIJR0GsGbXwR/5W8GFIrqHg4/LKV34A
	u55mVz3Q0HZjjssGs9dq/wmGrj05Yss=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721909646;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KMzzsysTjBt5gFEEIQsfeQ538IzgNTp9XOSYU4lJhlQ=;
	b=5mEuSs5KzGWz754JhFhWcexuqUMJyu1gdrDhPSsN+OdbhKBqobjU7FD4jJyWvotDC5jx5s
	RyxdNSQDyOdRzTCQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=iQ9FTfxx;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=5mEuSs5K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721909646; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KMzzsysTjBt5gFEEIQsfeQ538IzgNTp9XOSYU4lJhlQ=;
	b=iQ9FTfxxAveMJxqolev5Q76ZuOxz9m0uhO7EIjjlfQEuavYHI9QtV30rMwJB2tX6MfHXO7
	/87jGCAxNsmgohd1teOYmjcqD7nIYhoTCR5Tr0POIJR0GsGbXwR/5W8GFIrqHg4/LKV34A
	u55mVz3Q0HZjjssGs9dq/wmGrj05Yss=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721909646;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KMzzsysTjBt5gFEEIQsfeQ538IzgNTp9XOSYU4lJhlQ=;
	b=5mEuSs5KzGWz754JhFhWcexuqUMJyu1gdrDhPSsN+OdbhKBqobjU7FD4jJyWvotDC5jx5s
	RyxdNSQDyOdRzTCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 28ECD1368A;
	Thu, 25 Jul 2024 12:14:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id TdSYCY5Bomb8aQAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 25 Jul 2024 12:14:06 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id D7A22A0996; Thu, 25 Jul 2024 14:14:01 +0200 (CEST)
Date: Thu, 25 Jul 2024 14:14:01 +0200
From: Jan Kara <jack@suse.cz>
To: libaokun@huaweicloud.com
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
	jack@suse.cz, ritesh.list@gmail.com, linux-kernel@vger.kernel.org,
	yi.zhang@huawei.com, yangerkun@huawei.com,
	Baokun Li <libaokun1@huawei.com>
Subject: Re: [PATCH 16/20] ext4: get rid of ppath in
 ext4_convert_unwritten_extents_endio()
Message-ID: <20240725121401.fz3vgohhe5runpuj@quack3>
References: <20240710040654.1714672-1-libaokun@huaweicloud.com>
 <20240710040654.1714672-17-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710040654.1714672-17-libaokun@huaweicloud.com>
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [0.69 / 50.00];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,huaweicloud.com:email,huawei.com:email,suse.com:email,suse.cz:email,suse.cz:dkim]
X-Spamd-Bar: /
X-Rspamd-Queue-Id: 37F5B1F806
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: 0.69

On Wed 10-07-24 12:06:50, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 
> The use of path and ppath is now very confusing, so to make the code more
> readable, pass path between functions uniformly, and get rid of ppath.
> 
> To get rid of the ppath in ext4_convert_unwritten_extents_endio(), the
> following is done here:
> 
>  * Free the extents path when an error is encountered.
>  * Its caller needs to update ppath if it uses ppath.
> 
> No functional changes.
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/extents.c | 43 +++++++++++++++++++++++--------------------
>  1 file changed, 23 insertions(+), 20 deletions(-)
> 
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index a41cbb8c4475..b7f443f98e9d 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -3745,12 +3745,11 @@ static struct ext4_ext_path *ext4_split_convert_extents(handle_t *handle,
>  				 allocated);
>  }
>  
> -static int ext4_convert_unwritten_extents_endio(handle_t *handle,
> -						struct inode *inode,
> -						struct ext4_map_blocks *map,
> -						struct ext4_ext_path **ppath)
> +static struct ext4_ext_path *
> +ext4_convert_unwritten_extents_endio(handle_t *handle, struct inode *inode,
> +				     struct ext4_map_blocks *map,
> +				     struct ext4_ext_path *path)
>  {
> -	struct ext4_ext_path *path = *ppath;
>  	struct ext4_extent *ex;
>  	ext4_lblk_t ee_block;
>  	unsigned int ee_len;
> @@ -3780,24 +3779,19 @@ static int ext4_convert_unwritten_extents_endio(handle_t *handle,
>  #endif
>  		path = ext4_split_convert_extents(handle, inode, map, path,
>  						EXT4_GET_BLOCKS_CONVERT, NULL);
> -		if (IS_ERR(path)) {
> -			*ppath = NULL;
> -			return PTR_ERR(path);
> -		}
> +		if (IS_ERR(path))
> +			return path;
>  
>  		path = ext4_find_extent(inode, map->m_lblk, path, 0);
> -		if (IS_ERR(path)) {
> -			*ppath = NULL;
> -			return PTR_ERR(path);
> -		}
> -		*ppath = path;
> +		if (IS_ERR(path))
> +			return path;
>  		depth = ext_depth(inode);
>  		ex = path[depth].p_ext;
>  	}
>  
>  	err = ext4_ext_get_access(handle, inode, path + depth);
>  	if (err)
> -		goto out;
> +		goto errout;
>  	/* first mark the extent as initialized */
>  	ext4_ext_mark_initialized(ex);
>  
> @@ -3808,9 +3802,15 @@ static int ext4_convert_unwritten_extents_endio(handle_t *handle,
>  
>  	/* Mark modified extent as dirty */
>  	err = ext4_ext_dirty(handle, inode, path + path->p_depth);
> -out:
> +	if (err)
> +		goto errout;
> +
>  	ext4_ext_show_leaf(inode, path);
> -	return err;
> +	return path;
> +
> +errout:
> +	ext4_free_ext_path(path);
> +	return ERR_PTR(err);
>  }
>  
>  static int
> @@ -3938,10 +3938,13 @@ ext4_ext_handle_unwritten_extents(handle_t *handle, struct inode *inode,
>  	}
>  	/* IO end_io complete, convert the filled extent to written */
>  	if (flags & EXT4_GET_BLOCKS_CONVERT) {
> -		err = ext4_convert_unwritten_extents_endio(handle, inode, map,
> -							   ppath);
> -		if (err < 0)
> +		*ppath = ext4_convert_unwritten_extents_endio(handle, inode,
> +							      map, *ppath);
> +		if (IS_ERR(*ppath)) {
> +			err = PTR_ERR(*ppath);
> +			*ppath = NULL;
>  			goto out2;
> +		}
>  		ext4_update_inode_fsync_trans(handle, inode, 1);
>  		goto map_out;
>  	}
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

