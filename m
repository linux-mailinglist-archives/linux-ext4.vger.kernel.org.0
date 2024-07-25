Return-Path: <linux-ext4+bounces-3447-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D74C93BFF4
	for <lists+linux-ext4@lfdr.de>; Thu, 25 Jul 2024 12:32:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A16321F2250D
	for <lists+linux-ext4@lfdr.de>; Thu, 25 Jul 2024 10:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F59C198E99;
	Thu, 25 Jul 2024 10:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2k6rnkyL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="zvDsF8Ab";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="pob+kq6U";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="t/vHgwDl"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF78198E89;
	Thu, 25 Jul 2024 10:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721903522; cv=none; b=SzOOGDtwSCv/xVoewEkU+ivRlM76HToBKko4+teHm9I+xGXDKp2FTFir1fVz9E+hSmGbt7TUObSH3ZmoUnc/TGqWUp3MbeE3fYAQFRIlUsIzTekCpEKKUoJ9aQuiuqSCuybtL0fg7HOUORI+wWLgqxU71CMaS4jDqfci7B+Jufk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721903522; c=relaxed/simple;
	bh=cofU9la5SYvTj7YozW63nX2MFyceKW1t5Jcc+sK0XCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VuJUgcYXBR1m8qdKp8/74XbWIlA/HylUx4SmSXrUAJKuixIiMAthSAtrswH8LFZmdrCMH9snzs1BaH9ASeSN8n3il0nVOsSMfm+4Oo0IqAD0/p49vuOP4NUXTKVYNw2de3ZkP0AjHlSO41EoaL2AQ+pkA99yF1QT0gFcW8quJlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2k6rnkyL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=zvDsF8Ab; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=pob+kq6U; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=t/vHgwDl; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C5B9021A9C;
	Thu, 25 Jul 2024 10:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721903518; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z0yzzD/Dk3sPTHGa6I/agUhnv5LDHCUgL+l9TOJH6gE=;
	b=2k6rnkyLQEkSF/OMmKXsfQBatlbuqrWVLUbCVTWYxD2uDEQIZV+s5YCl5f5j/mQT8I+J8c
	4X6UJyWzf9GadYlUfmSubf4bw/vqXxTA/WqhbDZ2Ad6pfqRiSYVC8bS5cRPty4Oot67xBf
	I7Ybjfvt4fsZZcm9d/tPU0jHoDdQLZ4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721903518;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z0yzzD/Dk3sPTHGa6I/agUhnv5LDHCUgL+l9TOJH6gE=;
	b=zvDsF8AbfW+VUymzrjkc+NAh+gkDHJNnz/O2WOP8qHW+fcO5OCssWfVdWrph7HgxLGItOF
	QiEaJLdBJ1xEjCBw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=pob+kq6U;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="t/vHgwDl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721903517; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z0yzzD/Dk3sPTHGa6I/agUhnv5LDHCUgL+l9TOJH6gE=;
	b=pob+kq6UX+alqac4MGl1uhT98CBmFBrZLTomrLGVVbW5FI5g3O9KdRGUtTfiKFOPS8YI6G
	fhQi/+JmmyeWFOFOEpiOKGw1eLphIMaCKIFmD4RH/sOUZcwRqhVDnU0uHevo0Odbz2Zlxi
	0ZSjrLztm4pSZ19XPKNsL+j+G/0Pzwo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721903517;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z0yzzD/Dk3sPTHGa6I/agUhnv5LDHCUgL+l9TOJH6gE=;
	b=t/vHgwDlfcCBT7tb/RkXF/0yC2yErBUaPi8ZViAY9JGzH4HXD9Xxs3G4ydpa1448J+NEjW
	7TVG3joP/PDy7kCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B556B13874;
	Thu, 25 Jul 2024 10:31:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id h7RALJ0pomYfSwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 25 Jul 2024 10:31:57 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 73016A0996; Thu, 25 Jul 2024 12:31:57 +0200 (CEST)
Date: Thu, 25 Jul 2024 12:31:57 +0200
From: Jan Kara <jack@suse.cz>
To: libaokun@huaweicloud.com
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
	jack@suse.cz, ritesh.list@gmail.com, linux-kernel@vger.kernel.org,
	yi.zhang@huawei.com, yangerkun@huawei.com,
	Baokun Li <libaokun1@huawei.com>, stable@kernel.org
Subject: Re: [PATCH 07/20] ext4: drop ppath from ext4_ext_replay_update_ex()
 to avoid double-free
Message-ID: <20240725103157.3dts4pcgqxnpougd@quack3>
References: <20240710040654.1714672-1-libaokun@huaweicloud.com>
 <20240710040654.1714672-8-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710040654.1714672-8-libaokun@huaweicloud.com>
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.31 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,mit.edu,dilger.ca,suse.cz,gmail.com,huawei.com,kernel.org];
	RCPT_COUNT_SEVEN(0.00)[11];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -2.31
X-Rspamd-Queue-Id: C5B9021A9C

On Wed 10-07-24 12:06:41, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 
> When calling ext4_force_split_extent_at() in ext4_ext_replay_update_ex(),
> the 'ppath' is updated but it is the 'path' that is freed, thus potentially
> triggering a double-free in the following process:
> 
> ext4_ext_replay_update_ex
>   ppath = path
>   ext4_force_split_extent_at(&ppath)
>     ext4_split_extent_at
>       ext4_ext_insert_extent
>         ext4_ext_create_new_leaf
>           ext4_ext_grow_indepth
>             ext4_find_extent
>               if (depth > path[0].p_maxdepth)
>                 kfree(path)                 ---> path First freed
>                 *orig_path = path = NULL    ---> null ppath
>   kfree(path)                               ---> path double-free !!!
> 
> So drop the unnecessary ppath and use path directly to avoid this problem.
> And use ext4_find_extent() directly to update path, avoiding unnecessary
> memory allocation and freeing. Also, propagate the error returned by
> ext4_find_extent() instead of using strange error codes.
> 
> Fixes: 8016e29f4362 ("ext4: fast commit recovery path")
> Cc: stable@kernel.org
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Nice! Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/extents.c | 21 ++++++++++-----------
>  1 file changed, 10 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index 1660434fbfc7..b1cfce5b57d2 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -5920,7 +5920,7 @@ int ext4_clu_mapped(struct inode *inode, ext4_lblk_t lclu)
>  int ext4_ext_replay_update_ex(struct inode *inode, ext4_lblk_t start,
>  			      int len, int unwritten, ext4_fsblk_t pblk)
>  {
> -	struct ext4_ext_path *path = NULL, *ppath;
> +	struct ext4_ext_path *path;
>  	struct ext4_extent *ex;
>  	int ret;
>  
> @@ -5936,30 +5936,29 @@ int ext4_ext_replay_update_ex(struct inode *inode, ext4_lblk_t start,
>  	if (le32_to_cpu(ex->ee_block) != start ||
>  		ext4_ext_get_actual_len(ex) != len) {
>  		/* We need to split this extent to match our extent first */
> -		ppath = path;
>  		down_write(&EXT4_I(inode)->i_data_sem);
> -		ret = ext4_force_split_extent_at(NULL, inode, &ppath, start, 1);
> +		ret = ext4_force_split_extent_at(NULL, inode, &path, start, 1);
>  		up_write(&EXT4_I(inode)->i_data_sem);
>  		if (ret)
>  			goto out;
> -		kfree(path);
> -		path = ext4_find_extent(inode, start, NULL, 0);
> +
> +		path = ext4_find_extent(inode, start, &path, 0);
>  		if (IS_ERR(path))
> -			return -1;
> -		ppath = path;
> +			return PTR_ERR(path);
>  		ex = path[path->p_depth].p_ext;
>  		WARN_ON(le32_to_cpu(ex->ee_block) != start);
> +
>  		if (ext4_ext_get_actual_len(ex) != len) {
>  			down_write(&EXT4_I(inode)->i_data_sem);
> -			ret = ext4_force_split_extent_at(NULL, inode, &ppath,
> +			ret = ext4_force_split_extent_at(NULL, inode, &path,
>  							 start + len, 1);
>  			up_write(&EXT4_I(inode)->i_data_sem);
>  			if (ret)
>  				goto out;
> -			kfree(path);
> -			path = ext4_find_extent(inode, start, NULL, 0);
> +
> +			path = ext4_find_extent(inode, start, &path, 0);
>  			if (IS_ERR(path))
> -				return -EINVAL;
> +				return PTR_ERR(path);
>  			ex = path[path->p_depth].p_ext;
>  		}
>  	}
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

