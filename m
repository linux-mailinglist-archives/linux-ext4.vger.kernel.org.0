Return-Path: <linux-ext4+bounces-3448-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 268CC93C007
	for <lists+linux-ext4@lfdr.de>; Thu, 25 Jul 2024 12:38:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0409282025
	for <lists+linux-ext4@lfdr.de>; Thu, 25 Jul 2024 10:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17EE7198E9A;
	Thu, 25 Jul 2024 10:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="woBd4nR+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Y2OicCqM";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="12VLq1KH";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="xs1OCbvW"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D890198E74;
	Thu, 25 Jul 2024 10:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721903916; cv=none; b=CsI7OPlgHQcP4pxn33ZhEk1/WcL1N0/uil9h14nqbasWUZHttbdJSpIJ3bYZw9+gbs156iYPbe0THPjELcB3e/vGBVyR4UvceIR6ez/43gZhKf0GogXp6KAVZ3Te3cX5sfJddmLVUEUfSwRr6L0CQoZJ17S0dFZS/TiuUsFYavs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721903916; c=relaxed/simple;
	bh=6J70W6t31FAmFT7Miv48fok6V3Se39LFPBt5i+rBr7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VcesXEll0FfO5GrCXTKiP+8nnNXqpWyMzme6uDfBD0wjYFBjPR+o/jmO9yotfsyF5yUQNvYT3GHvgNb532ETQ8kOGPp4hsWzuihjrwhxYLj86nKEwRmTjMNse2/gM4b8xeF18qAssaITtYieZ+PLlukz6CfaL5M6p6TML6SwoSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=woBd4nR+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Y2OicCqM; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=12VLq1KH; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=xs1OCbvW; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 84FA61F7B2;
	Thu, 25 Jul 2024 10:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721903912; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nvDC87/jvz0noE+cyWz6Y6Lw756TMFZplIYd+GcXkxg=;
	b=woBd4nR+SBxt61yqbKopFdY5mGt1gv4ybgMHGpkKLm8UUPBPpX8u/c01RdeH2oTW5gNj8S
	JPojuapfFuW/lwhx3zdjUt9WXohy7DLLoNlJWIr21D85OOKTSNK9pqlKmAAD3Kt5EFgmAU
	boJP1NTtzvUVvX6FEM5xw4NlYtzhYUc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721903912;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nvDC87/jvz0noE+cyWz6Y6Lw756TMFZplIYd+GcXkxg=;
	b=Y2OicCqMNVKgSk/wHVrN5n5xhCq1zqEHw6Ynw1Myqupy3+QCHqZeXGeT+hQBk9NR4V+DMw
	uIChrJiSB7vJ5/CQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=12VLq1KH;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=xs1OCbvW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721903911; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nvDC87/jvz0noE+cyWz6Y6Lw756TMFZplIYd+GcXkxg=;
	b=12VLq1KHekE2tEnMDhSz1Cb8gxsW+w+Ub0fvwi2ybVMle7Bqw7h+6fDITV1huQXhpSPtGX
	3KFa+wyIJhlc0vWIBIFwoRRL8gGp5TPmZYzvN7HHEe1ZjqhJYTCHDIzQEb1qCY4QW7ANTd
	YoWfGxdlRTyXLhuZ05ATkdQLs/7MAtM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721903911;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nvDC87/jvz0noE+cyWz6Y6Lw756TMFZplIYd+GcXkxg=;
	b=xs1OCbvWgfSMRX4X5To6z+rJHvXm92MIqweK1h9acyF9OqCvqAWBfNTJ87Mn4BXIdAjR39
	G7AqTr++aCEvNFAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7B26713874;
	Thu, 25 Jul 2024 10:38:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1HYPHicromboTAAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 25 Jul 2024 10:38:31 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 3CB28A0996; Thu, 25 Jul 2024 12:38:23 +0200 (CEST)
Date: Thu, 25 Jul 2024 12:38:23 +0200
From: Jan Kara <jack@suse.cz>
To: libaokun@huaweicloud.com
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
	jack@suse.cz, ritesh.list@gmail.com, linux-kernel@vger.kernel.org,
	yi.zhang@huawei.com, yangerkun@huawei.com,
	Baokun Li <libaokun1@huawei.com>
Subject: Re: [PATCH 08/20] ext4: get rid of ppath in ext4_find_extent()
Message-ID: <20240725103823.fvvinixcctacf4fx@quack3>
References: <20240710040654.1714672-1-libaokun@huaweicloud.com>
 <20240710040654.1714672-9-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710040654.1714672-9-libaokun@huaweicloud.com>
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [0.69 / 50.00];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,mit.edu,dilger.ca,suse.cz,gmail.com,huawei.com];
	RCPT_COUNT_SEVEN(0.00)[10];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,suse.com:email,huaweicloud.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Spamd-Bar: /
X-Rspamd-Queue-Id: 84FA61F7B2
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: 0.69

On Wed 10-07-24 12:06:42, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 
> The use of path and ppath is now very confusing, so to make the code more
> readable, pass path between functions uniformly, and get rid of ppath.
> 
> Getting rid of ppath in ext4_find_extent() requires its caller to update
> ppath. These ppaths will also be dropped later. No functional changes.
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

One nit below, otherwise feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

> @@ -3260,11 +3257,12 @@ static int ext4_split_extent_at(handle_t *handle,
>  	 * WARN_ON may be triggered in ext4_da_update_reserve_space() due to
>  	 * an incorrect ee_len causing the i_reserved_data_blocks exception.
>  	 */
> -	path = ext4_find_extent(inode, ee_block, ppath,
> +	path = ext4_find_extent(inode, ee_block, *ppath,
>  				flags | EXT4_EX_NOFAIL);
>  	if (IS_ERR(path)) {
>  		EXT4_ERROR_INODE(inode, "Failed split extent on %u, err %ld",
>  				 split, PTR_ERR(path));
> +		*ppath = NULL;
>  		return PTR_ERR(path);
>  	}

I think here you forgot to update ppath on success case. It will go away by
the end of the series but still it's good to keep thing consistent...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

