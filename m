Return-Path: <linux-ext4+bounces-3459-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9388A93C1ED
	for <lists+linux-ext4@lfdr.de>; Thu, 25 Jul 2024 14:24:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D9FF1F213F2
	for <lists+linux-ext4@lfdr.de>; Thu, 25 Jul 2024 12:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 232E919A29B;
	Thu, 25 Jul 2024 12:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="heBeOFQT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZE8Yqdr+";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="heBeOFQT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZE8Yqdr+"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012DF19A291;
	Thu, 25 Jul 2024 12:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721910227; cv=none; b=tldCLNmeeCE5fkp5NPADZkKZ4vJMKXencwFUXUXOuscL92cRsqhnPd9UvQrP3ptGo33nFy3dtATuP8OJmIHClONeb8L26UFinaVe16SN7QpJf1fr29K7y5zX8TXW881M3bPbtpszo4QaJe+qMulhLNza8p3bJwb9wNm8BxsVagw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721910227; c=relaxed/simple;
	bh=l0v0veZ0g0iGMrnbUOoTVKEJeBWucLvXSvGWaxKSgeM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hsdk5gTugeLO6spLoN0ORpvAJLh6g9FjTHibRZVi0W9NYjJkg72O2KkB7MWkjmbS1loiGqhXh4MQ1XT+9h8ukJAT3Cr9R53x1xokPPNokeW0mQ5ZlL2HvAGy7nLZc7mvkKGak/eqrCTNoYNBZG/QX1OgheN4kiRhvFyigrIhoeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=heBeOFQT; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZE8Yqdr+; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=heBeOFQT; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZE8Yqdr+; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2C31821AC6;
	Thu, 25 Jul 2024 12:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721910224; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=maXuvzdAAcQg9+FFOgyr0GTFX5Y3J3HHBr4nUzQksho=;
	b=heBeOFQTYN2LLcy1MOPs4QPHrFmyp4xIfAMHB/4nOrPWGwxKxZADecOBf1ORRtSiV3tc+U
	+Zff8nzKXpMFyAZB3LjZLxA4o4jGyKWa1tdGxzLFeiGCvRC1OM8i2d5cawQHQt1RGv6vdI
	pV7rQ94LzhoPI0k0T3z4wdkJNyhputk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721910224;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=maXuvzdAAcQg9+FFOgyr0GTFX5Y3J3HHBr4nUzQksho=;
	b=ZE8Yqdr+tcKXkkUukYRmITP7pwQk2YSYZ4TJEWV7BeP75v6/o0+8u2SSXbk4rmPzlXkM4I
	sw9l4lB32hrFcbAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721910224; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=maXuvzdAAcQg9+FFOgyr0GTFX5Y3J3HHBr4nUzQksho=;
	b=heBeOFQTYN2LLcy1MOPs4QPHrFmyp4xIfAMHB/4nOrPWGwxKxZADecOBf1ORRtSiV3tc+U
	+Zff8nzKXpMFyAZB3LjZLxA4o4jGyKWa1tdGxzLFeiGCvRC1OM8i2d5cawQHQt1RGv6vdI
	pV7rQ94LzhoPI0k0T3z4wdkJNyhputk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721910224;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=maXuvzdAAcQg9+FFOgyr0GTFX5Y3J3HHBr4nUzQksho=;
	b=ZE8Yqdr+tcKXkkUukYRmITP7pwQk2YSYZ4TJEWV7BeP75v6/o0+8u2SSXbk4rmPzlXkM4I
	sw9l4lB32hrFcbAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1FE3A1368A;
	Thu, 25 Jul 2024 12:23:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mL3EB9BDombPbAAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 25 Jul 2024 12:23:44 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id D3658A0996; Thu, 25 Jul 2024 14:23:43 +0200 (CEST)
Date: Thu, 25 Jul 2024 14:23:43 +0200
From: Jan Kara <jack@suse.cz>
To: libaokun@huaweicloud.com
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
	jack@suse.cz, ritesh.list@gmail.com, linux-kernel@vger.kernel.org,
	yi.zhang@huawei.com, yangerkun@huawei.com,
	Baokun Li <libaokun1@huawei.com>
Subject: Re: [PATCH 19/20] ext4: get rid of ppath in
 convert_initialized_extent()
Message-ID: <20240725122343.shdvi722ncsvg7ox@quack3>
References: <20240710040654.1714672-1-libaokun@huaweicloud.com>
 <20240710040654.1714672-20-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710040654.1714672-20-libaokun@huaweicloud.com>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,huawei.com:email,huaweicloud.com:email,imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.10

On Wed 10-07-24 12:06:53, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 
> The use of path and ppath is now very confusing, so to make the code more
> readable, pass path between functions uniformly, and get rid of ppath.
> 
> To get rid of the ppath in convert_initialized_extent(), the following is
> done here:
> 
>  * Free the extents path when an error is encountered.
> 
> No functional changes.
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/extents.c | 37 +++++++++++++++++++------------------
>  1 file changed, 19 insertions(+), 18 deletions(-)
> 
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index badadcd64e66..737432bb316e 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -3810,13 +3810,12 @@ ext4_convert_unwritten_extents_endio(handle_t *handle, struct inode *inode,
>  	return ERR_PTR(err);
>  }
>  
> -static int
> +static struct ext4_ext_path *
>  convert_initialized_extent(handle_t *handle, struct inode *inode,
>  			   struct ext4_map_blocks *map,
> -			   struct ext4_ext_path **ppath,
> +			   struct ext4_ext_path *path,
>  			   unsigned int *allocated)
>  {
> -	struct ext4_ext_path *path = *ppath;
>  	struct ext4_extent *ex;
>  	ext4_lblk_t ee_block;
>  	unsigned int ee_len;
> @@ -3841,29 +3840,25 @@ convert_initialized_extent(handle_t *handle, struct inode *inode,
>  	if (ee_block != map->m_lblk || ee_len > map->m_len) {
>  		path = ext4_split_convert_extents(handle, inode, map, path,
>  				EXT4_GET_BLOCKS_CONVERT_UNWRITTEN, NULL);
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
>  		if (!ex) {
>  			EXT4_ERROR_INODE(inode, "unexpected hole at %lu",
>  					 (unsigned long) map->m_lblk);
> -			return -EFSCORRUPTED;
> +			err = -EFSCORRUPTED;
> +			goto errout;
>  		}
>  	}
>  
>  	err = ext4_ext_get_access(handle, inode, path + depth);
>  	if (err)
> -		return err;
> +		goto errout;
>  	/* first mark the extent as unwritten */
>  	ext4_ext_mark_unwritten(ex);
>  
> @@ -3875,7 +3870,7 @@ convert_initialized_extent(handle_t *handle, struct inode *inode,
>  	/* Mark modified extent as dirty */
>  	err = ext4_ext_dirty(handle, inode, path + path->p_depth);
>  	if (err)
> -		return err;
> +		goto errout;
>  	ext4_ext_show_leaf(inode, path);
>  
>  	ext4_update_inode_fsync_trans(handle, inode, 1);
> @@ -3884,7 +3879,11 @@ convert_initialized_extent(handle_t *handle, struct inode *inode,
>  	if (*allocated > map->m_len)
>  		*allocated = map->m_len;
>  	map->m_len = *allocated;
> -	return 0;
> +	return path;
> +
> +errout:
> +	ext4_free_ext_path(path);
> +	return ERR_PTR(err);
>  }
>  
>  static struct ext4_ext_path *
> @@ -4254,8 +4253,10 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
>  			 */
>  			if ((!ext4_ext_is_unwritten(ex)) &&
>  			    (flags & EXT4_GET_BLOCKS_CONVERT_UNWRITTEN)) {
> -				err = convert_initialized_extent(handle,
> -					inode, map, &path, &allocated);
> +				path = convert_initialized_extent(handle,
> +					inode, map, path, &allocated);
> +				if (IS_ERR(path))
> +					err = PTR_ERR(path);
>  				goto out;
>  			} else if (!ext4_ext_is_unwritten(ex)) {
>  				map->m_flags |= EXT4_MAP_MAPPED;
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

