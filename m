Return-Path: <linux-ext4+bounces-11454-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A8A1C31C76
	for <lists+linux-ext4@lfdr.de>; Tue, 04 Nov 2025 16:14:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BFEC3B2D3D
	for <lists+linux-ext4@lfdr.de>; Tue,  4 Nov 2025 15:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60680246BD2;
	Tue,  4 Nov 2025 15:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hkHwFi3C";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="CIJXEUBb";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hkHwFi3C";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="CIJXEUBb"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B51202C5C
	for <linux-ext4@vger.kernel.org>; Tue,  4 Nov 2025 15:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762268841; cv=none; b=WQyO2O0Z3/3clA1NGd742pNtILkfegz7HnEJaq4qAIK6mS+bWWuEc3qFf7PXBw2Mryx2JfN3767FvQxRwSo1T6HRjehYYuREwAqCjVZvpM7x10fJ07WXo97AYJy7W0fPkfHSDJJQ1Pk6RmnnL/nygcgMzsKgaMC9UB2fGSD/IR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762268841; c=relaxed/simple;
	bh=Ue8AbG0pKpUp0/OYjyrgtt5Lhd8KaOFt6GjqVA0IGfg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cL/+grPAoSUYSOUJgVULLi8tURJXu7l2bPIwZDi46po85/F2SNlXo4RWuLaJmk8PO4dzAumHdO2Qgk/vhNhaPQ9vR6M3l2UJMURCQyIIxgKyM/dm4lrJCGBW7KcS4OjOQpS2xoJi7A6NH5JE0ve/OeOEPn3F9DFSBcJ7rb/VZg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=hkHwFi3C; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=CIJXEUBb; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=hkHwFi3C; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=CIJXEUBb; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 860881F387;
	Tue,  4 Nov 2025 15:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762268837; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cHKubhI7EjGLG1FUB3T6Ls/1iWSaXU6S0h6lJnKN9Fc=;
	b=hkHwFi3Cgc8oDaKF5VLK3/ad2fqjivYWkRqWvccu/j+rIc3SyZaR5yFUAausCg5xMWwpEt
	CBIQobWbtx0Ilb9q4zkqV2ZNQKZN4/8LmM3RrQvW44+X7VzartJykuOEPBm+W4iqPqzzBL
	MI3mgaK0qv3p9z2hICCw1vq/5fTfIKA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762268837;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cHKubhI7EjGLG1FUB3T6Ls/1iWSaXU6S0h6lJnKN9Fc=;
	b=CIJXEUBbWv/e9fDCO0D2cQ5zLhOg6RVmi5LFd95ZJummOygGldmV1sXIM937vOyqXLHsJ5
	cqUbcFTDZiQr9nBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762268837; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cHKubhI7EjGLG1FUB3T6Ls/1iWSaXU6S0h6lJnKN9Fc=;
	b=hkHwFi3Cgc8oDaKF5VLK3/ad2fqjivYWkRqWvccu/j+rIc3SyZaR5yFUAausCg5xMWwpEt
	CBIQobWbtx0Ilb9q4zkqV2ZNQKZN4/8LmM3RrQvW44+X7VzartJykuOEPBm+W4iqPqzzBL
	MI3mgaK0qv3p9z2hICCw1vq/5fTfIKA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762268837;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cHKubhI7EjGLG1FUB3T6Ls/1iWSaXU6S0h6lJnKN9Fc=;
	b=CIJXEUBbWv/e9fDCO0D2cQ5zLhOg6RVmi5LFd95ZJummOygGldmV1sXIM937vOyqXLHsJ5
	cqUbcFTDZiQr9nBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6CCBA139A9;
	Tue,  4 Nov 2025 15:07:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id NmaHGqUWCmkjdAAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 04 Nov 2025 15:07:17 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id C68CDA28EA; Tue,  4 Nov 2025 16:07:16 +0100 (CET)
Date: Tue, 4 Nov 2025 16:07:16 +0100
From: Jan Kara <jack@suse.cz>
To: Yang Erkun <yangerkun@huawei.com>
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca, 
	jack@suse.cz, yi.zhang@huawei.com, libaokun1@huawei.com, 
	yangerkun@huaweicloud.com
Subject: Re: [PATCH v2 4/4] ext4: order mode should not take effect for DIO
Message-ID: <m4alrnslmj753wmjmvzydo3w2vq66plzkjj3rff4k2fqfc53mx@mvtip26su7d7>
References: <20251104131750.1581541-1-yangerkun@huawei.com>
 <20251104131750.1581541-4-yangerkun@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251104131750.1581541-4-yangerkun@huawei.com>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,huawei.com:email]
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 

On Tue 04-11-25 21:17:50, Yang Erkun wrote:
> Since the size will be updated after the DIO completes, the data
> will not be shown to userspace before that.
> 
> Reviewed-by: Zhang Yi <yi.zhang@huawei.com>
> Signed-off-by: Yang Erkun <yangerkun@huawei.com>

Hum, is there some measurable performance benefit from this? If yes, it
would be good to mention it in the changelog. If not, then why bother?

								Honza

> ---
>  fs/ext4/ext4.h              | 2 ++
>  fs/ext4/inode.c             | 5 +++--
>  include/trace/events/ext4.h | 1 +
>  3 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 96d7d649ccb0..d0331697467d 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -715,6 +715,8 @@ enum {
>  #define EXT4_GET_BLOCKS_METADATA_NOFAIL		0x0020
>  	/* Don't normalize allocation size (used for fallocate) */
>  #define EXT4_GET_BLOCKS_NO_NORMALIZE		0x0040
> +	/* Get blocks from DIO */
> +#define EXT4_GET_BLOCKS_DIO			0x0080
>  	/* Convert written extents to unwritten */
>  #define EXT4_GET_BLOCKS_CONVERT_UNWRITTEN	0x0100
>  	/* Write zeros to newly created written extents */
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 3d8ada26d5cd..168dbcc9e921 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -818,6 +818,7 @@ int ext4_map_blocks(handle_t *handle, struct inode *inode,
>  		if (map->m_flags & EXT4_MAP_NEW &&
>  		    !(map->m_flags & EXT4_MAP_UNWRITTEN) &&
>  		    !(flags & EXT4_GET_BLOCKS_ZERO) &&
> +		    !(flags & EXT4_GET_BLOCKS_DIO) &&
>  		    !ext4_is_quota_file(inode) &&
>  		    ext4_should_order_data(inode)) {
>  			loff_t start_byte =
> @@ -3729,9 +3730,9 @@ static int ext4_iomap_alloc(struct inode *inode, struct ext4_map_blocks *map,
>  	 * happening and thus expose allocated blocks to direct I/O reads.
>  	 */
>  	else if (((loff_t)map->m_lblk << blkbits) >= i_size_read(inode))
> -		m_flags = EXT4_GET_BLOCKS_CREATE;
> +		m_flags = EXT4_GET_BLOCKS_CREATE | EXT4_GET_BLOCKS_DIO;
>  	else if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
> -		m_flags = EXT4_GET_BLOCKS_IO_CREATE_EXT;
> +		m_flags = EXT4_GET_BLOCKS_IO_CREATE_EXT | EXT4_GET_BLOCKS_DIO;
>  
>  	if (flags & IOMAP_ATOMIC)
>  		ret = ext4_map_blocks_atomic_write(handle, inode, map, m_flags,
> diff --git a/include/trace/events/ext4.h b/include/trace/events/ext4.h
> index ada2b9223df5..de6d848f2e37 100644
> --- a/include/trace/events/ext4.h
> +++ b/include/trace/events/ext4.h
> @@ -43,6 +43,7 @@ struct partial_cluster;
>  	{ EXT4_GET_BLOCKS_CONVERT,		"CONVERT" },		\
>  	{ EXT4_GET_BLOCKS_METADATA_NOFAIL,	"METADATA_NOFAIL" },	\
>  	{ EXT4_GET_BLOCKS_NO_NORMALIZE,		"NO_NORMALIZE" },	\
> +	{ EXT4_GET_BLOCKS_DIO,			"DIO" },		\
>  	{ EXT4_GET_BLOCKS_CONVERT_UNWRITTEN,	"CONVERT_UNWRITTEN" },  \
>  	{ EXT4_GET_BLOCKS_ZERO,			"ZERO" },		\
>  	{ EXT4_GET_BLOCKS_IO_SUBMIT,		"IO_SUBMIT" },		\
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

