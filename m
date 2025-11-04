Return-Path: <linux-ext4+bounces-11451-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA352C31887
	for <lists+linux-ext4@lfdr.de>; Tue, 04 Nov 2025 15:33:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7D91462B32
	for <lists+linux-ext4@lfdr.de>; Tue,  4 Nov 2025 14:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FC7A331A78;
	Tue,  4 Nov 2025 14:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="NA195JRs";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="OWok5sSB";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="NA195JRs";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="OWok5sSB"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B39832ED5B
	for <linux-ext4@vger.kernel.org>; Tue,  4 Nov 2025 14:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762266536; cv=none; b=RIr2Nq9POPASTZ3pQyIlIqPGzWfVKD43aDu5gqcNUnC9d2AIgoi1dJ8agFkEbM09K5VaeyAfFmK0EOIvUNkQ06A4gLKl+/ToGVs09zv7Un6OTJxDJuwtvcvPAfG53WUTxrzzMq0jByq3gzu8OEgk7if9Rv/mudllG/omTQOk4w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762266536; c=relaxed/simple;
	bh=dP6tDYguZ2LB5z1lCvKjXVSScqlg3pZNdBGb75F+TQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O9efqSsXfW4o6YjHC+LYPGFlNkc7sFq+1jxYMIHk+A10z2X2mpe0nUoe2m+YMEiuUvUeUrRV4cEpMZyGAA1gjW285+1VHYx3TNNjtViMi/H3EVgx5rKtA2ArC9mOWBTJjye0G09dUre9NO67t25Sl5Hok/vSX7piGod8fNGyrUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=NA195JRs; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=OWok5sSB; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=NA195JRs; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=OWok5sSB; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4B2481F391;
	Tue,  4 Nov 2025 14:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762266532; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B5arVQIu36jUhvZQ/tXX/W3R7trzIl47WR+eF4rlTis=;
	b=NA195JRs2MQ7TzyvpvSzNoxtg4h0xk3OvDxBJUhrYcr8g2Pgp9wgPtGRlpm19AJ20+W4MU
	sgdL2v0pTicTXJZF0cLCfQyuo3/IUuoUE0WMJdaYokPpC+N/jDQe8RZxPIY+uY2mHkb9mp
	lB0QeMWJEfGPXBBYJHs2bHyzJQbQS9A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762266532;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B5arVQIu36jUhvZQ/tXX/W3R7trzIl47WR+eF4rlTis=;
	b=OWok5sSBA2Z+4SF5DrpafZjejka33RBEcsXGyMKb//o5PjEUhNPr5ANT59DjyNo2cCBixI
	spqEp2cEezIvFBBA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=NA195JRs;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=OWok5sSB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762266532; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B5arVQIu36jUhvZQ/tXX/W3R7trzIl47WR+eF4rlTis=;
	b=NA195JRs2MQ7TzyvpvSzNoxtg4h0xk3OvDxBJUhrYcr8g2Pgp9wgPtGRlpm19AJ20+W4MU
	sgdL2v0pTicTXJZF0cLCfQyuo3/IUuoUE0WMJdaYokPpC+N/jDQe8RZxPIY+uY2mHkb9mp
	lB0QeMWJEfGPXBBYJHs2bHyzJQbQS9A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762266532;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B5arVQIu36jUhvZQ/tXX/W3R7trzIl47WR+eF4rlTis=;
	b=OWok5sSBA2Z+4SF5DrpafZjejka33RBEcsXGyMKb//o5PjEUhNPr5ANT59DjyNo2cCBixI
	spqEp2cEezIvFBBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 37D6B13A31;
	Tue,  4 Nov 2025 14:28:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id lZCeDaQNCmmPTQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 04 Nov 2025 14:28:52 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id C847AA28EA; Tue,  4 Nov 2025 15:28:51 +0100 (CET)
Date: Tue, 4 Nov 2025 15:28:51 +0100
From: Jan Kara <jack@suse.cz>
To: Yang Erkun <yangerkun@huawei.com>
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca, 
	jack@suse.cz, yi.zhang@huawei.com, libaokun1@huawei.com, 
	yangerkun@huaweicloud.com
Subject: Re: [PATCH v2 1/4] ext4: remove useless code in
 ext4_map_create_blocks
Message-ID: <j7hzyzb6ounq5tofuxg6mwmb4w5c2ldmkat6ngaf2ijt3rgsfc@fdty7kn7bdjn>
References: <20251104131750.1581541-1-yangerkun@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251104131750.1581541-1-yangerkun@huawei.com>
X-Rspamd-Queue-Id: 4B2481F391
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 

On Tue 04-11-25 21:17:47, Yang Erkun wrote:
> IO path with EXT4_GET_BLOCKS_PRE_IO means dio within i_size or
> dioread_nolock buffer writeback, they all means we need a unwritten
> extent(or this extent has already been initialized), and the split won't
> zero the range we really write. So this check seems useless. Besides,
> even if we repeatedly execute ext4_es_insert_extent, there won't
> actually be any issues.
> 
> Reviewed-by: Zhang Yi <yi.zhang@huawei.com>
> Signed-off-by: Yang Erkun <yangerkun@huawei.com>

I agree the check isn't needed for correctness but it seems to be
reasonable performance optimization for a common case of writing back
already written data in dioread_nolock mode?

								Honza

> ---
>  fs/ext4/inode.c | 11 -----------
>  1 file changed, 11 deletions(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index e99306a8f47c..e8bac93ca668 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -583,7 +583,6 @@ static int ext4_map_query_blocks(handle_t *handle, struct inode *inode,
>  static int ext4_map_create_blocks(handle_t *handle, struct inode *inode,
>  				  struct ext4_map_blocks *map, int flags)
>  {
> -	struct extent_status es;
>  	unsigned int status;
>  	int err, retval = 0;
>  
> @@ -644,16 +643,6 @@ static int ext4_map_create_blocks(handle_t *handle, struct inode *inode,
>  			return err;
>  	}
>  
> -	/*
> -	 * If the extent has been zeroed out, we don't need to update
> -	 * extent status tree.
> -	 */
> -	if (flags & EXT4_GET_BLOCKS_PRE_IO &&
> -	    ext4_es_lookup_extent(inode, map->m_lblk, NULL, &es)) {
> -		if (ext4_es_is_written(&es))
> -			return retval;
> -	}
> -
>  	status = map->m_flags & EXT4_MAP_UNWRITTEN ?
>  			EXTENT_STATUS_UNWRITTEN : EXTENT_STATUS_WRITTEN;
>  	ext4_es_insert_extent(inode, map->m_lblk, map->m_len, map->m_pblk,
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

