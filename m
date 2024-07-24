Return-Path: <linux-ext4+bounces-3437-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BBAA93B73F
	for <lists+linux-ext4@lfdr.de>; Wed, 24 Jul 2024 21:13:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA3732859A3
	for <lists+linux-ext4@lfdr.de>; Wed, 24 Jul 2024 19:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E70BD16C688;
	Wed, 24 Jul 2024 19:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lb082w0p";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="AAJ2w+Hh";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hsyTMAZR";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="l1oHDOW2"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E50816B3BA;
	Wed, 24 Jul 2024 19:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721848406; cv=none; b=TdTU6GhsiieYAyRP7hl4nJJuyIyWNslHfFseGp4+J8vpJlbfe2smIYhGkNmO8JRBOwr5i498xdsXNhTYXGXfBx49vNUN9dbV/ITKHelzTlIzDDu7GUnc1M3AZSd5fO6lueikd0O7HuHlkLRBAfk+cS2FNkiGH/LHiOBsD8u7s70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721848406; c=relaxed/simple;
	bh=YK7O3DvzNqhg4Atqy9bgSJ/exSVPXbJFfHyu3Zk5KLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ebtfrSA2L+afjmNLdyrMog6f7OfRtYzAhu/j2j+2AlboCvCSFWx6KOqLemOhMEoP0rrX7h4Y+RC0cYFv4R07Zx4oSThbKcVVzoEAxIR8uCzhXM8cEV6Q5MV835+/L5mMZwAEduukGZTxHQgLhU1xLPGvDj6ubGUvi71zdQKbtCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lb082w0p; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=AAJ2w+Hh; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=hsyTMAZR; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=l1oHDOW2; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E1776219F2;
	Wed, 24 Jul 2024 19:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721848402; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XCLAMkAFc+eSaq0gB3aKXiVpCE/NB6K9L07emQn6yHI=;
	b=lb082w0pqrWOVFbmPi1g2roXF6Chokvg4gsoSu8ik94Ufj73rELPImBfpxoBdo7R/V5M4C
	vlMzvjFccU+ZykgK8a/tV99/dwsfL/EoXKVuCu0ioVwCroT7E5uoh2EsocjanhmiKahoN7
	Of4PoVf4d6Xq/Db5SfzzFePxprfXSUA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721848402;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XCLAMkAFc+eSaq0gB3aKXiVpCE/NB6K9L07emQn6yHI=;
	b=AAJ2w+Hhl5x0/agnfypgBkB1b4EqJijNb7usWxq9Jwmkcms/mqaO8h/2HjCxR1kc2GVcIt
	Pv/kUkWTUHdTYTDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721848401; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XCLAMkAFc+eSaq0gB3aKXiVpCE/NB6K9L07emQn6yHI=;
	b=hsyTMAZRBvzu8DdbVTjGd77bzir+9y7SIJ3/FOM0T8YAsZ31aioVKni44XQmA2nMsc82Hz
	mzVuMjolL2teNeD9JyZLV42UfP7WXn4LHU++7nRH3Llq/xu3JGMw8HKbO6T0nwxAVNLR/2
	rdHe/Aj4JKEFOhqOmjB0qKHrU4u5Pqc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721848401;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XCLAMkAFc+eSaq0gB3aKXiVpCE/NB6K9L07emQn6yHI=;
	b=l1oHDOW2UXCkRol/feR3wUrG7po5SLN/rDfDGdtkEjluye1s+zsgOoq0Ns6rZu8t43/F9R
	gIm9urKC4s0tveCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CA11013411;
	Wed, 24 Jul 2024 19:13:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +OERMVFSoWascAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 24 Jul 2024 19:13:21 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 67A04A08F2; Wed, 24 Jul 2024 21:13:21 +0200 (CEST)
Date: Wed, 24 Jul 2024 21:13:21 +0200
From: Jan Kara <jack@suse.cz>
To: libaokun@huaweicloud.com
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
	jack@suse.cz, ritesh.list@gmail.com, linux-kernel@vger.kernel.org,
	yi.zhang@huawei.com, yangerkun@huawei.com,
	Baokun Li <libaokun1@huawei.com>, stable@kernel.org
Subject: Re: [PATCH 05/20] ext4: fix slab-use-after-free in
 ext4_split_extent_at()
Message-ID: <20240724191321.rgdevlcordkjhpgy@quack3>
References: <20240710040654.1714672-1-libaokun@huaweicloud.com>
 <20240710040654.1714672-6-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710040654.1714672-6-libaokun@huaweicloud.com>
X-Spamd-Result: default: False [-2.10 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,mit.edu,dilger.ca,suse.cz,gmail.com,huawei.com,kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.10

On Wed 10-07-24 12:06:39, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 
> We hit the following use-after-free:
> 
> ==================================================================
> BUG: KASAN: slab-use-after-free in ext4_split_extent_at+0xba8/0xcc0
> Read of size 2 at addr ffff88810548ed08 by task kworker/u20:0/40
> CPU: 0 PID: 40 Comm: kworker/u20:0 Not tainted 6.9.0-dirty #724
> Call Trace:
>  <TASK>
>  kasan_report+0x93/0xc0
>  ext4_split_extent_at+0xba8/0xcc0
>  ext4_split_extent.isra.0+0x18f/0x500
>  ext4_split_convert_extents+0x275/0x750
>  ext4_ext_handle_unwritten_extents+0x73e/0x1580
>  ext4_ext_map_blocks+0xe20/0x2dc0
>  ext4_map_blocks+0x724/0x1700
>  ext4_do_writepages+0x12d6/0x2a70
> [...]
> 
> Allocated by task 40:
>  __kmalloc_noprof+0x1ac/0x480
>  ext4_find_extent+0xf3b/0x1e70
>  ext4_ext_map_blocks+0x188/0x2dc0
>  ext4_map_blocks+0x724/0x1700
>  ext4_do_writepages+0x12d6/0x2a70
> [...]
> 
> Freed by task 40:
>  kfree+0xf1/0x2b0
>  ext4_find_extent+0xa71/0x1e70
>  ext4_ext_insert_extent+0xa22/0x3260
>  ext4_split_extent_at+0x3ef/0xcc0
>  ext4_split_extent.isra.0+0x18f/0x500
>  ext4_split_convert_extents+0x275/0x750
>  ext4_ext_handle_unwritten_extents+0x73e/0x1580
>  ext4_ext_map_blocks+0xe20/0x2dc0
>  ext4_map_blocks+0x724/0x1700
>  ext4_do_writepages+0x12d6/0x2a70
> [...]
> ==================================================================
> 
> The flow of issue triggering is as follows:
> 
> ext4_split_extent_at
>   path = *ppath
>   ext4_ext_insert_extent(ppath)
>     ext4_ext_create_new_leaf(ppath)
>       ext4_find_extent(orig_path)
>         path = *orig_path
>         read_extent_tree_block
>           // return -ENOMEM or -EIO
>         ext4_free_ext_path(path)
>           kfree(path)
>         *orig_path = NULL
>   a. If err is -ENOMEM:
>   ext4_ext_dirty(path + path->p_depth)
>   // path use-after-free !!!
>   b. If err is -EIO and we have EXT_DEBUG defined:
>   ext4_ext_show_leaf(path)
>     eh = path[depth].p_hdr
>     // path also use-after-free !!!
> 
> So when trying to zeroout or fix the extent length, call ext4_find_extent()
> to update the path.
> 
> In addition we use *ppath directly as an ext4_ext_show_leaf() input to
> avoid possible use-after-free when EXT_DEBUG is defined, and to avoid
> unnecessary path updates.
> 
> Fixes: dfe5080939ea ("ext4: drop EXT4_EX_NOFREE_ON_ERR from rest of extents handling code")
> Cc: stable@kernel.org
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

									Honza

> ---
>  fs/ext4/extents.c | 21 ++++++++++++++++++++-
>  1 file changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index 6e5b5baf3aa6..3a70a0739af8 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -3252,6 +3252,25 @@ static int ext4_split_extent_at(handle_t *handle,
>  	if (err != -ENOSPC && err != -EDQUOT && err != -ENOMEM)
>  		goto out;
>  
> +	/*
> +	 * Update path is required because previous ext4_ext_insert_extent()
> +	 * may have freed or reallocated the path. Using EXT4_EX_NOFAIL
> +	 * guarantees that ext4_find_extent() will not return -ENOMEM,
> +	 * otherwise -ENOMEM will cause a retry in do_writepages(), and a
> +	 * WARN_ON may be triggered in ext4_da_update_reserve_space() due to
> +	 * an incorrect ee_len causing the i_reserved_data_blocks exception.
> +	 */
> +	path = ext4_find_extent(inode, ee_block, ppath,
> +				flags | EXT4_EX_NOFAIL);
> +	if (IS_ERR(path)) {
> +		EXT4_ERROR_INODE(inode, "Failed split extent on %u, err %ld",
> +				 split, PTR_ERR(path));
> +		return PTR_ERR(path);
> +	}
> +	depth = ext_depth(inode);
> +	ex = path[depth].p_ext;
> +	*ppath = path;
> +
>  	if (EXT4_EXT_MAY_ZEROOUT & split_flag) {
>  		if (split_flag & (EXT4_EXT_DATA_VALID1|EXT4_EXT_DATA_VALID2)) {
>  			if (split_flag & EXT4_EXT_DATA_VALID1) {
> @@ -3304,7 +3323,7 @@ static int ext4_split_extent_at(handle_t *handle,
>  	ext4_ext_dirty(handle, inode, path + path->p_depth);
>  	return err;
>  out:
> -	ext4_ext_show_leaf(inode, path);
> +	ext4_ext_show_leaf(inode, *ppath);
>  	return err;
>  }
>  
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

