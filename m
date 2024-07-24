Return-Path: <linux-ext4+bounces-3431-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5171D93B729
	for <lists+linux-ext4@lfdr.de>; Wed, 24 Jul 2024 21:03:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5673CB249FB
	for <lists+linux-ext4@lfdr.de>; Wed, 24 Jul 2024 19:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B37AF16B74A;
	Wed, 24 Jul 2024 19:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="kPddF1eC";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="EHiKUkag";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="kPddF1eC";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="EHiKUkag"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9058416B722;
	Wed, 24 Jul 2024 19:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721847768; cv=none; b=PztGUnJ7hueZLeLeSNsa+SWYkYftXrgY1mX+jM5Mh2apjIqBF4LhDoEz+FmCnp+DGZdYr2jK59GPkC017hmO6v8D6Dm0J2UGjqEOfFWQlLiPGkSfVHbbzst39UzcarVsJaB4gCq+6FBVf3iuXsKSEsDjxa/moGOnb73Xqz+Qaww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721847768; c=relaxed/simple;
	bh=/fUpCf7WN/hvHmqVwWZfVLxMXBf6wAmtV77gYxny0FI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qMxuiYr78krVgRsmu1b4Kjq9TJtGFUXqQD34vNumlM75brayefFKD4bzXKEaVdxiIPTQv43/8Ff+TS8A02oQ/EZINFPwuvjr91OW9/zaiTTwFV1j8oscW0bPPoRrkv2CMP+SMcWgxSyEJbD1mIIFO9g/wWQxJ6xTWHIbHeC09HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=kPddF1eC; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=EHiKUkag; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=kPddF1eC; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=EHiKUkag; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A2928219A8;
	Wed, 24 Jul 2024 19:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721847764; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=glng+kpt1IPtS4eIY7egQTcXEaYT3xiMDmsYwHFyFaQ=;
	b=kPddF1eCZRjtn7VTOfB4Me7+sGpGVY8Y7L9CM6p1hWN8Q357oXsvaZoNx/ffmEvLmG6Px/
	3z6NysJJM50MIH5mizpAVXBXWfLDfPhq4+IV3RIf88cXdzPdw+Q7imwZKsjJscrCTgPm7y
	3XppZeumofXnWTT5kOShtgSxs9FX1Y4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721847764;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=glng+kpt1IPtS4eIY7egQTcXEaYT3xiMDmsYwHFyFaQ=;
	b=EHiKUkagat3JYbu6tRRCySL3fzSlyozB2fwQM6NL3dQ09KHvfChy9fXfzPRIVXzAlpk731
	nRVTwl6dstKZ/XBw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=kPddF1eC;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=EHiKUkag
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721847764; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=glng+kpt1IPtS4eIY7egQTcXEaYT3xiMDmsYwHFyFaQ=;
	b=kPddF1eCZRjtn7VTOfB4Me7+sGpGVY8Y7L9CM6p1hWN8Q357oXsvaZoNx/ffmEvLmG6Px/
	3z6NysJJM50MIH5mizpAVXBXWfLDfPhq4+IV3RIf88cXdzPdw+Q7imwZKsjJscrCTgPm7y
	3XppZeumofXnWTT5kOShtgSxs9FX1Y4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721847764;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=glng+kpt1IPtS4eIY7egQTcXEaYT3xiMDmsYwHFyFaQ=;
	b=EHiKUkagat3JYbu6tRRCySL3fzSlyozB2fwQM6NL3dQ09KHvfChy9fXfzPRIVXzAlpk731
	nRVTwl6dstKZ/XBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 96C5A13411;
	Wed, 24 Jul 2024 19:02:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xwG+JNRPoWaFbgAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 24 Jul 2024 19:02:44 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 5B57BA08F2; Wed, 24 Jul 2024 21:02:40 +0200 (CEST)
Date: Wed, 24 Jul 2024 21:02:40 +0200
From: Jan Kara <jack@suse.cz>
To: libaokun@huaweicloud.com
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
	jack@suse.cz, ritesh.list@gmail.com, linux-kernel@vger.kernel.org,
	yi.zhang@huawei.com, yangerkun@huawei.com,
	Baokun Li <libaokun1@huawei.com>
Subject: Re: [PATCH 04/20] ext4: add new ext4_ext_path_brelse() helper
Message-ID: <20240724190240.z565j4t45uyociij@quack3>
References: <20240710040654.1714672-1-libaokun@huaweicloud.com>
 <20240710040654.1714672-5-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710040654.1714672-5-libaokun@huaweicloud.com>
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [0.69 / 50.00];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TAGGED_RCPT(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,mit.edu,dilger.ca,suse.cz,gmail.com,huawei.com];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spamd-Bar: /
X-Rspamd-Queue-Id: A2928219A8
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: 0.69

On Wed 10-07-24 12:06:38, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 
> Add ext4_ext_path_brelse() helper function to reduce duplicate code
> and ensure that path->p_bh is set to NULL after it is released.
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Why not. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/extents.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index 657baf3991c1..6e5b5baf3aa6 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -106,6 +106,12 @@ static int ext4_ext_trunc_restart_fn(struct inode *inode, int *dropped)
>  	return 0;
>  }
>  
> +static inline void ext4_ext_path_brelse(struct ext4_ext_path *path)
> +{
> +	brelse(path->p_bh);
> +	path->p_bh = NULL;
> +}
> +
>  static void ext4_ext_drop_refs(struct ext4_ext_path *path)
>  {
>  	int depth, i;
> @@ -113,10 +119,8 @@ static void ext4_ext_drop_refs(struct ext4_ext_path *path)
>  	if (!path)
>  		return;
>  	depth = path->p_depth;
> -	for (i = 0; i <= depth; i++, path++) {
> -		brelse(path->p_bh);
> -		path->p_bh = NULL;
> -	}
> +	for (i = 0; i <= depth; i++, path++)
> +		ext4_ext_path_brelse(path);
>  }
>  
>  void ext4_free_ext_path(struct ext4_ext_path *path)
> @@ -635,8 +639,7 @@ int ext4_ext_precache(struct inode *inode)
>  		 */
>  		if ((i == depth) ||
>  		    path[i].p_idx > EXT_LAST_INDEX(path[i].p_hdr)) {
> -			brelse(path[i].p_bh);
> -			path[i].p_bh = NULL;
> +			ext4_ext_path_brelse(path + i);
>  			i--;
>  			continue;
>  		}
> @@ -1887,8 +1890,7 @@ static void ext4_ext_try_to_merge_up(handle_t *handle,
>  		(path[1].p_ext - EXT_FIRST_EXTENT(path[1].p_hdr));
>  	path[0].p_hdr->eh_max = cpu_to_le16(max_root);
>  
> -	brelse(path[1].p_bh);
> -	path[1].p_bh = NULL;
> +	ext4_ext_path_brelse(path + 1);
>  	ext4_free_blocks(handle, inode, NULL, blk, 1,
>  			 EXT4_FREE_BLOCKS_METADATA | EXT4_FREE_BLOCKS_FORGET);
>  }
> @@ -2956,8 +2958,7 @@ int ext4_ext_remove_space(struct inode *inode, ext4_lblk_t start,
>  			err = ext4_ext_rm_leaf(handle, inode, path,
>  					       &partial, start, end);
>  			/* root level has p_bh == NULL, brelse() eats this */
> -			brelse(path[i].p_bh);
> -			path[i].p_bh = NULL;
> +			ext4_ext_path_brelse(path + i);
>  			i--;
>  			continue;
>  		}
> @@ -3019,8 +3020,7 @@ int ext4_ext_remove_space(struct inode *inode, ext4_lblk_t start,
>  				err = ext4_ext_rm_idx(handle, inode, path, i);
>  			}
>  			/* root level has p_bh == NULL, brelse() eats this */
> -			brelse(path[i].p_bh);
> -			path[i].p_bh = NULL;
> +			ext4_ext_path_brelse(path + i);
>  			i--;
>  			ext_debug(inode, "return to level %d\n", i);
>  		}
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

