Return-Path: <linux-ext4+bounces-4938-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ECC09BB2D3
	for <lists+linux-ext4@lfdr.de>; Mon,  4 Nov 2024 12:17:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E5782828AB
	for <lists+linux-ext4@lfdr.de>; Mon,  4 Nov 2024 11:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D1871C07ED;
	Mon,  4 Nov 2024 11:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="nzhRX3ws";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2KCUJ+9o";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="nzhRX3ws";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2KCUJ+9o"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DECB1B3945;
	Mon,  4 Nov 2024 11:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730718313; cv=none; b=XqwTeqa4Wy+MLjr/1Q54zeFrphiY5MUbGdDz4wXp4EJv+hEmO0ILENGhZMB3K3uJ0KeN5Ub5FFsI6k7+07zW9bQGFls9TsvBkLqKS6KZrBkWHpqbW1PTzFof+sacxUcQbBax+EV87bpLcMDxVu6hfzGQbNHUovpGIWkShK5zS18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730718313; c=relaxed/simple;
	bh=f3pAOqk8IC3w0cLsAAhJK8VGcIR6Zcf9Dq7TLsqk0nk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GytNh/Ogj3W5ZvV0MuZP2VkxpzBiBOhqTMJS4/BMnMSUGnBffsrFIjPngZWjVDVSAD+ZmkRVnvDrq8Yeczr0PVQ25KdQ1TqkJvK3z8tfTe1quexiQ0Qq3zSkpY6XbIzoDQqdfp3pR/OZI0s/zIFs+R6m3X52vdo4+tSv9TjRLWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=nzhRX3ws; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2KCUJ+9o; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=nzhRX3ws; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2KCUJ+9o; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8769D1F7ED;
	Mon,  4 Nov 2024 11:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1730718309; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gUgU/TTvEr4qoByuVJVnHPP7dypTWalKUMSb1hzqpog=;
	b=nzhRX3wsiMG6k866trksWO5gBrfNGC3q69wGSBhm2zkmc9r8CUNFMaFFa8ZehCyeYNxMSK
	ES9wPRgAUhhptI9iKhuWK5XITedXa1JnkGMwdwnj5+tYwY1/CH17ThjmCPI3jhsiiBsnTW
	Ui0vnUIuOre5hD2i/+YGFrdmZi6n20Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1730718309;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gUgU/TTvEr4qoByuVJVnHPP7dypTWalKUMSb1hzqpog=;
	b=2KCUJ+9ogvVm6QL3rzDZg64ZTEj1hbMFcaZKjZiuUHykrg/iR62mfJXuUKdJwkmtPqCW1G
	JKOluQFs6jSVgnDg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=nzhRX3ws;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=2KCUJ+9o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1730718309; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gUgU/TTvEr4qoByuVJVnHPP7dypTWalKUMSb1hzqpog=;
	b=nzhRX3wsiMG6k866trksWO5gBrfNGC3q69wGSBhm2zkmc9r8CUNFMaFFa8ZehCyeYNxMSK
	ES9wPRgAUhhptI9iKhuWK5XITedXa1JnkGMwdwnj5+tYwY1/CH17ThjmCPI3jhsiiBsnTW
	Ui0vnUIuOre5hD2i/+YGFrdmZi6n20Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1730718309;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gUgU/TTvEr4qoByuVJVnHPP7dypTWalKUMSb1hzqpog=;
	b=2KCUJ+9ogvVm6QL3rzDZg64ZTEj1hbMFcaZKjZiuUHykrg/iR62mfJXuUKdJwkmtPqCW1G
	JKOluQFs6jSVgnDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 74FF213736;
	Mon,  4 Nov 2024 11:05:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id LqlEHGWqKGfCPAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 04 Nov 2024 11:05:09 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 15CAEA0AFB; Mon,  4 Nov 2024 12:05:09 +0100 (CET)
Date: Mon, 4 Nov 2024 12:05:09 +0100
From: Jan Kara <jack@suse.cz>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.com>,
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2][next] jbd2: Avoid dozens of
 -Wflex-array-member-not-at-end warnings
Message-ID: <20241104110509.4ioef4oqzvlg7u6e@quack3>
References: <ZyU94w0IALVhc9Jy@kspp>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZyU94w0IALVhc9Jy@kspp>
X-Rspamd-Queue-Id: 8769D1F7ED
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Fri 01-11-24 14:45:23, Gustavo A. R. Silva wrote:
> -Wflex-array-member-not-at-end was introduced in GCC-14, and we
> are getting ready to enable it, globally.
> 
> Use the `DEFINE_RAW_FLEX()` helper for an on-stack definition of
> a flexible structure (`struct shash_desc`) where the size of the
> flexible-array member (`__ctx`) is known at compile-time, and
> refactor the rest of the code, accordingly.
> 
> So, with this, fix 77 of the following warnings:
> 
> include/linux/jbd2.h:1800:35: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> Changes in v2:
>  - Use DIV_ROUND_UP() to compute the number of elements for the flex
>    array. (Jan Kara)
> 
> v1:
>  - Link: https://lore.kernel.org/linux-hardening/ZxvyavDjXDaV9cNg@kspp/
> 
>  include/linux/jbd2.h | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
> index 8aef9bb6ad57..50f7ea8714bf 100644
> --- a/include/linux/jbd2.h
> +++ b/include/linux/jbd2.h
> @@ -1796,22 +1796,21 @@ static inline unsigned long jbd2_log_space_left(journal_t *journal)
>  static inline u32 jbd2_chksum(journal_t *journal, u32 crc,
>  			      const void *address, unsigned int length)
>  {
> -	struct {
> -		struct shash_desc shash;
> -		char ctx[JBD_MAX_CHECKSUM_SIZE];
> -	} desc;
> +	DEFINE_RAW_FLEX(struct shash_desc, desc, __ctx,
> +		DIV_ROUND_UP(JBD_MAX_CHECKSUM_SIZE,
> +			     sizeof(*((struct shash_desc *)0)->__ctx)));
>  	int err;
>  
>  	BUG_ON(crypto_shash_descsize(journal->j_chksum_driver) >
>  		JBD_MAX_CHECKSUM_SIZE);
>  
> -	desc.shash.tfm = journal->j_chksum_driver;
> -	*(u32 *)desc.ctx = crc;
> +	desc->tfm = journal->j_chksum_driver;
> +	*(u32 *)desc->__ctx = crc;
>  
> -	err = crypto_shash_update(&desc.shash, address, length);
> +	err = crypto_shash_update(desc, address, length);
>  	BUG_ON(err);
>  
> -	return *(u32 *)desc.ctx;
> +	return *(u32 *)desc->__ctx;
>  }
>  
>  /* Return most recent uncommitted transaction */
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

