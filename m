Return-Path: <linux-ext4+bounces-3429-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF7493B70E
	for <lists+linux-ext4@lfdr.de>; Wed, 24 Jul 2024 20:54:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 586951F21CD3
	for <lists+linux-ext4@lfdr.de>; Wed, 24 Jul 2024 18:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8712716A95B;
	Wed, 24 Jul 2024 18:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="eK5omhTN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0swYGws2";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="eK5omhTN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0swYGws2"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B0115D5C5;
	Wed, 24 Jul 2024 18:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721847243; cv=none; b=iHI63kVWOBwiveop3qCDeg6Sba+g81rnm7Z1Xvm81gLqQelLTfPI/AnQPC4C0WK617jdyR0yeoWXY78CVW0sUKgWWVLcZRHljmnGGpxpg83wY0lq6ERgUIt04rWZnB9WgDFE9rM+M/vrRlE8LNV27eYkeqAD3w7QQOAB34jvSBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721847243; c=relaxed/simple;
	bh=OCRco25IIgGNkEM3eS8T2rr0/UblGNb+ycwZGmj6T6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YARBjoMf3quT+N804iv0SXWrICF83vIxU1yLfwBGrengo4zlxDVSzVkyF/W41IttG8p1bWQaNGZKEyDQXlf+hOizdcYchwaUWhcaLYq2hTGobynoEdgX6G3MIl96sxh9jjB0kBYdndUCKcykdclk1lCvR6OfDGYjT/BfbTHD4AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=eK5omhTN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0swYGws2; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=eK5omhTN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0swYGws2; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 57E6D1F766;
	Wed, 24 Jul 2024 18:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721847239; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9edQPlFtRXmADCPMaWe6kUVkyNj0Cvh9WTL95HPe5vA=;
	b=eK5omhTNT1EdR75FJihm84honW/rY1+mXFMKwF6eij7WYNlNvTdSmttVKXZVHigoOj79Zi
	kjEOxKieEYPG2acL76msjw6HomnsoOcnZ0uNLvQim/IrEQrPdrhon5cM7+pV+/VABPik+F
	iWhO40hIEVrtdhlIXprAgMO35DGq+pc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721847239;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9edQPlFtRXmADCPMaWe6kUVkyNj0Cvh9WTL95HPe5vA=;
	b=0swYGws2JQaBS0xBPYy8T6kweqH+3KhMcOeNbjkafu5HG64bN5n7cXdOm9XT4w3ZWaSv0Z
	yAcuR+y/mV6qMIDg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=eK5omhTN;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=0swYGws2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721847239; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9edQPlFtRXmADCPMaWe6kUVkyNj0Cvh9WTL95HPe5vA=;
	b=eK5omhTNT1EdR75FJihm84honW/rY1+mXFMKwF6eij7WYNlNvTdSmttVKXZVHigoOj79Zi
	kjEOxKieEYPG2acL76msjw6HomnsoOcnZ0uNLvQim/IrEQrPdrhon5cM7+pV+/VABPik+F
	iWhO40hIEVrtdhlIXprAgMO35DGq+pc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721847239;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9edQPlFtRXmADCPMaWe6kUVkyNj0Cvh9WTL95HPe5vA=;
	b=0swYGws2JQaBS0xBPYy8T6kweqH+3KhMcOeNbjkafu5HG64bN5n7cXdOm9XT4w3ZWaSv0Z
	yAcuR+y/mV6qMIDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4A14A13411;
	Wed, 24 Jul 2024 18:53:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QFwJEsdNoWZnbAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 24 Jul 2024 18:53:59 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id EB635A08F2; Wed, 24 Jul 2024 20:53:58 +0200 (CEST)
Date: Wed, 24 Jul 2024 20:53:58 +0200
From: Jan Kara <jack@suse.cz>
To: libaokun@huaweicloud.com
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
	jack@suse.cz, ritesh.list@gmail.com, linux-kernel@vger.kernel.org,
	yi.zhang@huawei.com, yangerkun@huawei.com,
	Baokun Li <libaokun1@huawei.com>,
	zhanchengbin <zhanchengbin1@huawei.com>
Subject: Re: [PATCH 02/20] ext4: prevent partial update of the extents path
Message-ID: <20240724185358.jv7qehigpj7oelgd@quack3>
References: <20240710040654.1714672-1-libaokun@huaweicloud.com>
 <20240710040654.1714672-3-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710040654.1714672-3-libaokun@huaweicloud.com>
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 57E6D1F766
X-Spam-Score: -2.31
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.31 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,mit.edu,dilger.ca,suse.cz,gmail.com,huawei.com];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]

On Wed 10-07-24 12:06:36, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 
> In ext4_ext_rm_idx() and ext4_ext_correct_indexes(), there is no proper
> rollback of already executed updates when updating a level of the extents
> path fails, so we may get an inconsistent extents tree, which may trigger
> some bad things in errors=continue mode.
> 
> Hence clear the verified bit of modified extents buffers if the tree fails
> to be updated in ext4_ext_rm_idx() or ext4_ext_correct_indexes(), which
> forces the extents buffers to be checked in ext4_valid_extent_entries(),
> ensuring that the extents tree is consistent.
> 
> Signed-off-by: zhanchengbin <zhanchengbin1@huawei.com>
> Link: https://lore.kernel.org/r/20230213080514.535568-3-zhanchengbin1@huawei.com/
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/extents.c | 31 +++++++++++++++++++++++++++----
>  1 file changed, 27 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index bff3666c891a..4d589d34b30e 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -1749,12 +1749,23 @@ static int ext4_ext_correct_indexes(handle_t *handle, struct inode *inode,
>  			break;
>  		err = ext4_ext_get_access(handle, inode, path + k);
>  		if (err)
> -			break;
> +			goto clean;
>  		path[k].p_idx->ei_block = border;
>  		err = ext4_ext_dirty(handle, inode, path + k);
>  		if (err)
> -			break;
> +			goto clean;
>  	}
> +	return 0;
> +
> +clean:
> +	/*
> +	 * The path[k].p_bh is either unmodified or with no verified bit
> +	 * set (see ext4_ext_get_access()). So just clear the verified bit
> +	 * of the successfully modified extents buffers, which will force
> +	 * these extents to be checked to avoid using inconsistent data.
> +	 */
> +	while (++k < depth)
> +		clear_buffer_verified(path[k].p_bh);
>  
>  	return err;
>  }
> @@ -2312,12 +2323,24 @@ static int ext4_ext_rm_idx(handle_t *handle, struct inode *inode,
>  			break;
>  		err = ext4_ext_get_access(handle, inode, path + k);
>  		if (err)
> -			break;
> +			goto clean;
>  		path[k].p_idx->ei_block = path[k + 1].p_idx->ei_block;
>  		err = ext4_ext_dirty(handle, inode, path + k);
>  		if (err)
> -			break;
> +			goto clean;
>  	}
> +	return 0;
> +
> +clean:
> +	/*
> +	 * The path[k].p_bh is either unmodified or with no verified bit
> +	 * set (see ext4_ext_get_access()). So just clear the verified bit
> +	 * of the successfully modified extents buffers, which will force
> +	 * these extents to be checked to avoid using inconsistent data.
> +	 */
> +	while (++k < depth)
> +		clear_buffer_verified(path[k].p_bh);
> +
>  	return err;
>  }
>  
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

