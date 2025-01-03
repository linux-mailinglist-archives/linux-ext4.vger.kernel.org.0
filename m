Return-Path: <linux-ext4+bounces-5877-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95383A00A9C
	for <lists+linux-ext4@lfdr.de>; Fri,  3 Jan 2025 15:35:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73ADE3A3F35
	for <lists+linux-ext4@lfdr.de>; Fri,  3 Jan 2025 14:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2F8E1FA257;
	Fri,  3 Jan 2025 14:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="S6OxHBvo";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="hm6zkicB";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="S6OxHBvo";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="hm6zkicB"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5221FA17F;
	Fri,  3 Jan 2025 14:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735914938; cv=none; b=YGn99n8//0k3C/Bns+qJBimx+t7hbzGRXjjnhFh4sXe7+rUyaUIwyE6UkSNe9EhaltPntV0aIbEzAXLIJTWvq2ML4Tu0gL5pj/z0dr9S5xYrAE7UpB/9zwWgTMAvzclHj375M1BNL/pSFLnpndRKX0E+6xtRH5opvd3OEofqN5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735914938; c=relaxed/simple;
	bh=5nc8G5/4biPSqzsSs9RMVUj7L4IHGpqrmBagU+KsV3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b8rqbj7aLfT8YBDLRV4Tzg/eW1EdLgWU9GWF2TSF93haDiJVMFnQfswzpOP+WF5+fbtCBhamloNZE9HGLc8ElLyd7ngEulHwk1/fFhIYrToNWjtctqzztksF4VCwAXOVlvl6yNcEcenkwWiQQs0AnM5ZSzUuEKJTdnUyRY5slDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=S6OxHBvo; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=hm6zkicB; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=S6OxHBvo; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=hm6zkicB; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B090B1F38E;
	Fri,  3 Jan 2025 14:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1735914934; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8KlJYWtJMCkgFtmsCBULtgQThrkn1qyEpUPBA3+R4K8=;
	b=S6OxHBvoJiPyIkKV6Gh3jmBW4uHp2L3lic6C3fKQrK/hLs2M4DJN0tP8Ag/CG6ct88spiU
	2acqm9tPZajkYQpjeRjJaRseiq5hJATQI2atZ2iTuDYT4JatUhYyWsJw3NMej+ao43agi3
	IO4uJATtK/zLT4iVzb2V5xPEeAfMfXw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1735914934;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8KlJYWtJMCkgFtmsCBULtgQThrkn1qyEpUPBA3+R4K8=;
	b=hm6zkicBjXxhxseY9sldAU5tCp7eUjJ30et8SNKB69RE6dBJwTEFgBLRszgJpa0Jhhdomg
	IsY+7qF2mWp1P7Dg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1735914934; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8KlJYWtJMCkgFtmsCBULtgQThrkn1qyEpUPBA3+R4K8=;
	b=S6OxHBvoJiPyIkKV6Gh3jmBW4uHp2L3lic6C3fKQrK/hLs2M4DJN0tP8Ag/CG6ct88spiU
	2acqm9tPZajkYQpjeRjJaRseiq5hJATQI2atZ2iTuDYT4JatUhYyWsJw3NMej+ao43agi3
	IO4uJATtK/zLT4iVzb2V5xPEeAfMfXw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1735914934;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8KlJYWtJMCkgFtmsCBULtgQThrkn1qyEpUPBA3+R4K8=;
	b=hm6zkicBjXxhxseY9sldAU5tCp7eUjJ30et8SNKB69RE6dBJwTEFgBLRszgJpa0Jhhdomg
	IsY+7qF2mWp1P7Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A345A134E4;
	Fri,  3 Jan 2025 14:35:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ZfbPJ7b1d2fSXgAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 03 Jan 2025 14:35:34 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id A4B8BA0844; Fri,  3 Jan 2025 15:35:32 +0100 (CET)
Date: Fri, 3 Jan 2025 15:35:32 +0100
From: Jan Kara <jack@suse.cz>
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: tytso@mit.edu, jack@suse.com, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] jbd2: remove unused h_jdata flag of handle
Message-ID: <rugozcqq4ysdsqgaojzdj56rvc6luxo52yy7upbpckoiz2se37@zpeu7q7jozun>
References: <20241224202707.1530558-1-shikemeng@huaweicloud.com>
 <20241224202707.1530558-2-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241224202707.1530558-2-shikemeng@huaweicloud.com>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Wed 25-12-24 04:27:02, Kemeng Shi wrote:
> Flag h_jdata is not used, just remove it.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza


> ---
>  include/linux/jbd2.h | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
> index 50f7ea8714bf..c7fdb2b1b9a6 100644
> --- a/include/linux/jbd2.h
> +++ b/include/linux/jbd2.h
> @@ -459,7 +459,6 @@ struct jbd2_revoke_table_s;
>   * @h_ref: Reference count on this handle.
>   * @h_err: Field for caller's use to track errors through large fs operations.
>   * @h_sync: Flag for sync-on-close.
> - * @h_jdata: Flag to force data journaling.
>   * @h_reserved: Flag for handle for reserved credits.
>   * @h_aborted: Flag indicating fatal error on handle.
>   * @h_type: For handle statistics.
> @@ -491,7 +490,6 @@ struct jbd2_journal_handle
>  
>  	/* Flags [no locking] */
>  	unsigned int	h_sync:		1;
> -	unsigned int	h_jdata:	1;
>  	unsigned int	h_reserved:	1;
>  	unsigned int	h_aborted:	1;
>  	unsigned int	h_type:		8;
> -- 
> 2.30.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

