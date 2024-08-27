Return-Path: <linux-ext4+bounces-3924-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D4196165F
	for <lists+linux-ext4@lfdr.de>; Tue, 27 Aug 2024 20:07:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 660681C23024
	for <lists+linux-ext4@lfdr.de>; Tue, 27 Aug 2024 18:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C47F1D3185;
	Tue, 27 Aug 2024 18:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="RbGvqF5z";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="H8rgILaZ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LK79brBw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="6+T1j2J+"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8941D2788;
	Tue, 27 Aug 2024 18:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724781877; cv=none; b=LsnBkEd0JceCE/Y+mKSk6eNt1HxJXx88ezunGdHSoPAWthXEwvbEGCK059WAdO2FOVHMStTV1kDTKAYoHzbEHlkQ1S5nRD4KEb8PgBo9pYzAxLvbDfGfo4s4AitGxlg7A9Zd5REvNdPTXOer+JQ/+TQ9Rxz6yBohim6YxEvSugA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724781877; c=relaxed/simple;
	bh=sRhYB9brfTgLxmSHaM6ykVFYLRTTbgxn53klFVrmjxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mtaZ9XCjgEUYZeIJSxau7V95ozH26ruk1C3IkLn+AoFy9jroV5BIJntDLUpTMDdIGWlB9fWqT2hflepw6eYhuQacslVEVVrS1uzneliWW9MaeCnEi+nT0HO8PM2OM2+s1OSdAlfYMYSZDUWkKjeUY1dfhI01qZ+fHZpvQAFAQ9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=RbGvqF5z; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=H8rgILaZ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LK79brBw; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=6+T1j2J+; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E22721FB80;
	Tue, 27 Aug 2024 18:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724781874; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L69bAogeWWAuRA8L9GBMdOeGkXXZSADCgIZ1Q0rUj5k=;
	b=RbGvqF5zI13MB/9MchvVLYUcf1t8+bsKD2y0Fhfe2/c8H8zPuLiwSKI0nedLeIVL5rCOKU
	l3c1mCYDS1QTtyTZIzrG9ZIBC1Rray+ZnL2D1/M+mk8YTXnSeDmUlmwZUqNXCgH9oipG6Y
	HMl5eMxilDmiyEa95ULGGm9INzQ33Gw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724781874;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L69bAogeWWAuRA8L9GBMdOeGkXXZSADCgIZ1Q0rUj5k=;
	b=H8rgILaZBPi7nLrQIZKcuI9F/hQOs1TZczyiuSVR8piVwP4fzgdka+HNYWsfpNwBZ3/QNd
	xG8ihiHHsZ5OFjAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724781873; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L69bAogeWWAuRA8L9GBMdOeGkXXZSADCgIZ1Q0rUj5k=;
	b=LK79brBwKlNhAN6ljm7exL9WUe2tfc5l4Tj0WDMWd6n/D0Bhn7RM+TWKCLTbAUj27lAaQS
	OBSOAz6sOturK8XfFYfseh7H0SYLDhWaJaFeiU3ZgLkqhdqbVJ57z67xJWhexfYcQt/hk9
	mP8rdWvepSTm3FWkWnExPWKC6YF6Xp8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724781873;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L69bAogeWWAuRA8L9GBMdOeGkXXZSADCgIZ1Q0rUj5k=;
	b=6+T1j2J+d6lO63+FNuHHa2tTr4rW2exfvnUc9dThtNSv1AcpGWHRiV1uhi1HE8FaDLhpgk
	n0CvQfYjMR7xYbDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D765B13A20;
	Tue, 27 Aug 2024 18:04:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id paiUNDEVzmY1VgAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 27 Aug 2024 18:04:33 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 748D8A0968; Tue, 27 Aug 2024 20:04:33 +0200 (CEST)
Date: Tue, 27 Aug 2024 20:04:33 +0200
From: Jan Kara <jack@suse.cz>
To: libaokun@huaweicloud.com
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
	jack@suse.cz, ritesh.list@gmail.com, ojaswin@linux.ibm.com,
	linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
	yangerkun@huawei.com, Baokun Li <libaokun1@huawei.com>,
	stable@kernel.org
Subject: Re: [PATCH v2 05/25] ext4: update orig_path in ext4_find_extent()
Message-ID: <20240827180433.tnv5e4ljn4lzxfff@quack3>
References: <20240822023545.1994557-1-libaokun@huaweicloud.com>
 <20240822023545.1994557-6-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240822023545.1994557-6-libaokun@huaweicloud.com>
X-Spam-Score: -2.30
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,mit.edu,dilger.ca,suse.cz,gmail.com,linux.ibm.com,huawei.com,kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Thu 22-08-24 10:35:25, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 
> In ext4_find_extent(), if the path is not big enough, we free it and set
> *orig_path to NULL. But after reallocating and successfully initializing
> the path, we don't update *orig_path, in which case the caller gets a
> valid path but a NULL ppath, and this may cause a NULL pointer dereference
> or a path memory leak. For example:
> 
> ext4_split_extent
>   path = *ppath = 2000
>   ext4_find_extent
>     if (depth > path[0].p_maxdepth)
>       kfree(path = 2000);
>       *orig_path = path = NULL;
>       path = kcalloc() = 3000
>   ext4_split_extent_at(*ppath = NULL)
>     path = *ppath;
>     ex = path[depth].p_ext;
>     // NULL pointer dereference!
> 
> ==================================================================
> BUG: kernel NULL pointer dereference, address: 0000000000000010
> CPU: 6 UID: 0 PID: 576 Comm: fsstress Not tainted 6.11.0-rc2-dirty #847
> RIP: 0010:ext4_split_extent_at+0x6d/0x560
> Call Trace:
>  <TASK>
>  ext4_split_extent.isra.0+0xcb/0x1b0
>  ext4_ext_convert_to_initialized+0x168/0x6c0
>  ext4_ext_handle_unwritten_extents+0x325/0x4d0
>  ext4_ext_map_blocks+0x520/0xdb0
>  ext4_map_blocks+0x2b0/0x690
>  ext4_iomap_begin+0x20e/0x2c0
> [...]
> ==================================================================
> 
> Therefore, *orig_path is updated when the extent lookup succeeds, so that
> the caller can safely use path or *ppath.
> 
> Fixes: 10809df84a4d ("ext4: teach ext4_ext_find_extent() to realloc path if necessary")
> Cc: stable@kernel.org
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

									Honza

> ---
>  fs/ext4/extents.c     | 3 ++-
>  fs/ext4/move_extent.c | 1 -
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index 0224cf0ef19e..5879aef159d8 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -957,6 +957,8 @@ ext4_find_extent(struct inode *inode, ext4_lblk_t block,
>  
>  	ext4_ext_show_path(inode, path);
>  
> +	if (orig_path)
> +		*orig_path = path;
>  	return path;
>  
>  err:
> @@ -3268,7 +3270,6 @@ static int ext4_split_extent_at(handle_t *handle,
>  	}
>  	depth = ext_depth(inode);
>  	ex = path[depth].p_ext;
> -	*ppath = path;
>  
>  	if (EXT4_EXT_MAY_ZEROOUT & split_flag) {
>  		if (split_flag & (EXT4_EXT_DATA_VALID1|EXT4_EXT_DATA_VALID2)) {
> diff --git a/fs/ext4/move_extent.c b/fs/ext4/move_extent.c
> index 204f53b23622..c95e3e526390 100644
> --- a/fs/ext4/move_extent.c
> +++ b/fs/ext4/move_extent.c
> @@ -36,7 +36,6 @@ get_ext_path(struct inode *inode, ext4_lblk_t lblock,
>  		*ppath = NULL;
>  		return -ENODATA;
>  	}
> -	*ppath = path;
>  	return 0;
>  }
>  
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

