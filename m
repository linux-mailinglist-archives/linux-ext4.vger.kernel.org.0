Return-Path: <linux-ext4+bounces-5000-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A509C0CAE
	for <lists+linux-ext4@lfdr.de>; Thu,  7 Nov 2024 18:17:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66B4D1F22F31
	for <lists+linux-ext4@lfdr.de>; Thu,  7 Nov 2024 17:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02B2D215F4D;
	Thu,  7 Nov 2024 17:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YFvxOr0y";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="pFRHwlaG";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YFvxOr0y";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="pFRHwlaG"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56048212F0E;
	Thu,  7 Nov 2024 17:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730999857; cv=none; b=b7dyaiYr9TkknCZSypXhLXi/V9EsevYcM3kcnKSFMQtBPRYbwqOJIhS2D+mpEPcI2/qwfLWLKYEMfyiSrx5SmY6SV/Pk7B0zkjiVciAMuPu1SbZhUb7wJd1TsZ6wAP7waEvFhW5I9Z5Sldp1EusKsAuCXGjejKtMaAcuBt+hxbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730999857; c=relaxed/simple;
	bh=VaWW2DFFCTYdWWQET8wM9ft5WooLa1sb93u/KZLj/tE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fq+BJxA2yo57U/Dwt4bFtMRI2EHnaHTlOb9FD+21vxvF8JivbrebFE1yyuhfk4CTGSoWC1voBMWJAZeewxR4qEJTwquOFjI6/6ZALDjgJT98R9yGzkO7LXV/XkWqiQFy3XbqbycixJZJY+vumQEJFUwY7D6NsZOv49SjoVaP6yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=YFvxOr0y; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=pFRHwlaG; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=YFvxOr0y; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=pFRHwlaG; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 028C421BFB;
	Thu,  7 Nov 2024 17:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1730999847; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YhoKKPeq71OZQU120h9eJbeH9ItIKhio+QA5rswmTvw=;
	b=YFvxOr0yG4k6SQz3DkIoAdgT2FepLe+IVy1eAA3+5Y8CSk4tzp2ParPNmN9zhdGJy7A2+/
	Lj5zMetC8Gtqx3iTqVJur3vJzcDhEW8QJSf6UV0SbAfEpSkAHq/ecGBS6+Jcj8ANjh2Okk
	cWPokzVwNnrz20duuoQ0t7dpYS4zM18=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1730999847;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YhoKKPeq71OZQU120h9eJbeH9ItIKhio+QA5rswmTvw=;
	b=pFRHwlaGozfWjtN3xsl4gqo9c35jTZcQ3dEHjJZBss74QgmeDu72qilebst3c60oxdAFGO
	cVzXwIvPZWefVQAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1730999847; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YhoKKPeq71OZQU120h9eJbeH9ItIKhio+QA5rswmTvw=;
	b=YFvxOr0yG4k6SQz3DkIoAdgT2FepLe+IVy1eAA3+5Y8CSk4tzp2ParPNmN9zhdGJy7A2+/
	Lj5zMetC8Gtqx3iTqVJur3vJzcDhEW8QJSf6UV0SbAfEpSkAHq/ecGBS6+Jcj8ANjh2Okk
	cWPokzVwNnrz20duuoQ0t7dpYS4zM18=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1730999847;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YhoKKPeq71OZQU120h9eJbeH9ItIKhio+QA5rswmTvw=;
	b=pFRHwlaGozfWjtN3xsl4gqo9c35jTZcQ3dEHjJZBss74QgmeDu72qilebst3c60oxdAFGO
	cVzXwIvPZWefVQAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EAB71139B3;
	Thu,  7 Nov 2024 17:17:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7mlLOSb2LGfAGQAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 07 Nov 2024 17:17:26 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 898C9A08FE; Thu,  7 Nov 2024 18:17:26 +0100 (CET)
Date: Thu, 7 Nov 2024 18:17:26 +0100
From: Jan Kara <jack@suse.cz>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH] ext4: Use str_yes_no() helper function
Message-ID: <20241107171726.w3izawdg237qngit@quack3>
References: <20241104233204.7771-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104233204.7771-2-thorsten.blum@linux.dev>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

On Tue 05-11-24 00:32:05, Thorsten Blum wrote:
> Remove hard-coded strings by using the str_yes_no() helper function.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

OK. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/mballoc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index d73e38323879..4d8e82cb90fd 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -5711,7 +5711,7 @@ static void ext4_mb_show_ac(struct ext4_allocation_context *ac)
>  			(unsigned long)ac->ac_b_ex.fe_logical,
>  			(int)ac->ac_criteria);
>  	mb_debug(sb, "%u found", ac->ac_found);
> -	mb_debug(sb, "used pa: %s, ", ac->ac_pa ? "yes" : "no");
> +	mb_debug(sb, "used pa: %s, ", str_yes_no(ac->ac_pa));
>  	if (ac->ac_pa)
>  		mb_debug(sb, "pa_type %s\n", ac->ac_pa->pa_type == MB_GROUP_PA ?
>  			 "group pa" : "inode pa");
> @@ -6056,7 +6056,7 @@ static bool ext4_mb_discard_preallocations_should_retry(struct super_block *sb,
>  	}
>  
>  out_dbg:
> -	mb_debug(sb, "freed %d, retry ? %s\n", freed, ret ? "yes" : "no");
> +	mb_debug(sb, "freed %d, retry ? %s\n", freed, str_yes_no(ret));
>  	return ret;
>  }
>  
> -- 
> 2.47.0
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

