Return-Path: <linux-ext4+bounces-11415-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 170B0C2B716
	for <lists+linux-ext4@lfdr.de>; Mon, 03 Nov 2025 12:39:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 90A41348953
	for <lists+linux-ext4@lfdr.de>; Mon,  3 Nov 2025 11:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3B56301491;
	Mon,  3 Nov 2025 11:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="c0LXDZn/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="vQivLMfd";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="RKQ7+278";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="StkIyM2c"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C488E21CC55
	for <linux-ext4@vger.kernel.org>; Mon,  3 Nov 2025 11:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762169985; cv=none; b=ueb9ZaS0tCYLbRt3clWXKZ+gvZslpsWHZlM5G55SImx48x/WQ69n4gLHBwvtfFVzvuBQ9ps619IIOu3K212zTokkuKquqw8vazJdbv/ja6qj75ItcUBc9K42dMiffHxLMlPOgJOowDzThZm/wJnA8gLAL6N3CSaYwJu4OJLAfWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762169985; c=relaxed/simple;
	bh=xuqF16WhVzqA2FUfzxBa/BY/nWht4SzK/jI91oQ4ofI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tpitmh+8M+Wwg/lLuHAbzW0lOjJgoCMt7jWHcwwo5zp1wxaGUjMZF5Yym663b2Rj7XdIDg+a+b+CPEiCPbE08r5x4nT/1e64omFa/8W0rUb3gefMNJdGjb9qlB5MyOb0ZbBnPfP5TBC9Jw+nTPBcdMnKMTwEZmP+d+7d0r8uFxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=c0LXDZn/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=vQivLMfd; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=RKQ7+278; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=StkIyM2c; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0C2601F7A8;
	Mon,  3 Nov 2025 11:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762169982; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BYFPo24Ij3UmRulCj1bzPQQbaCPLRcKYWdpbhhJioFM=;
	b=c0LXDZn/rEv9qCVCEdIAMgviTwFch9IB9JdeqCueY+Y+mqg1orsxMNeGVL7mcYDG09L3QM
	86iPjfg3GGQSKqWDKXvi84paNZW3vnuVDbI2U/D3sUiJHYzxJf/J8sMHmkSaJpUlEx8Fm5
	zYTTifMoudqrcX9Svd2PGIf/bkCEk+k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762169982;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BYFPo24Ij3UmRulCj1bzPQQbaCPLRcKYWdpbhhJioFM=;
	b=vQivLMfd1A3C4ey8ake8iSeCjaRxxyEdkg05xM0nMEW0ma4LSzKPBDpz9B2sSRlsrKjSNP
	iJkw0mC5hh7kQ4Cg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=RKQ7+278;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=StkIyM2c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762169981; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BYFPo24Ij3UmRulCj1bzPQQbaCPLRcKYWdpbhhJioFM=;
	b=RKQ7+278ovdiZrReoIFld+tN1YkggIuKaBp/+02bCIN9aEBG61kzYq1QEwxH9inc6NIBpK
	OAtM/bdgePHxODPs5U/89U+GBclpqWd6LV7q+5FnnW/TsSbI5hkWQppWfgkim4FNtzQvts
	I8rLxExUkpuorpghioqeJygoVlbAEzg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762169981;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BYFPo24Ij3UmRulCj1bzPQQbaCPLRcKYWdpbhhJioFM=;
	b=StkIyM2cKhGyKLYb6um/A53ZZo9s1ktcQBQUOl7o50jGcLjp0qVbNXjIW7MQhd51g14obB
	4PnFAy9704+CluCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F21691364F;
	Mon,  3 Nov 2025 11:39:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Z0EVO3yUCGlqLQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 03 Nov 2025 11:39:40 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 51008A2812; Mon,  3 Nov 2025 12:39:40 +0100 (CET)
Date: Mon, 3 Nov 2025 12:39:40 +0100
From: Jan Kara <jack@suse.cz>
To: Fedor Pchelkin <pchelkin@ispras.ru>
Cc: Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.cz>, 
	linux-ext4@vger.kernel.org, Andreas Dilger <adilger.kernel@dilger.ca>, 
	"Darrick J. Wong" <djwong@kernel.org>, linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH v2 2/2] ext4: check if mount_opts is NUL-terminated in
 ext4_ioctl_set_tune_sb()
Message-ID: <3rscuc2wkxmfwgvyblxqlormqecmqtbysh6pploetnd2pendlh@xoiinaf7j6aj>
References: <20251101160430.222297-1-pchelkin@ispras.ru>
 <20251101160430.222297-2-pchelkin@ispras.ru>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251101160430.222297-2-pchelkin@ispras.ru>
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 0C2601F7A8
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxtesting.org:url,suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_THREE(0.00)[3];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Score: -4.01

On Sat 01-11-25 19:04:29, Fedor Pchelkin wrote:
> params.mount_opts may come as potentially non-NUL-term string.  Userspace
> is expected to pass a NUL-term string.  Add an extra check to ensure this
> holds true.  Note that further code utilizes strscpy_pad() so this is just
> for proper informing the user of incorrect data being provided.
> 
> Found by Linux Verification Center (linuxtesting.org).
> 
> Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> 
> v2: check length of mount_opts in superblock tuning ioctl (Jan Kara)
> 
>     Can't plainly return error at strscpy_pad() call site in
>     ext4_sb_setparams(), that's a void ext4_update_sb_callback.
> 
> v1: https://lore.kernel.org/lkml/20251028130949.599847-1-pchelkin@ispras.ru/T/#u
> 
>  fs/ext4/ioctl.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
> index a93a7baae990..3dec26c939fd 100644
> --- a/fs/ext4/ioctl.c
> +++ b/fs/ext4/ioctl.c
> @@ -1394,6 +1394,10 @@ static int ext4_ioctl_set_tune_sb(struct file *filp,
>  	if (copy_from_user(&params, in, sizeof(params)))
>  		return -EFAULT;
>  
> +	if (strnlen(params.mount_opts, sizeof(params.mount_opts)) ==
> +	    sizeof(params.mount_opts))
> +		return -E2BIG;
> +
>  	if ((params.set_flags & ~TUNE_OPS_SUPPORTED) != 0)
>  		return -EOPNOTSUPP;
>  
> -- 
> 2.51.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

