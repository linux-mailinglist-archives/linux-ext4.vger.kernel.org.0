Return-Path: <linux-ext4+bounces-3527-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 88EC594134B
	for <lists+linux-ext4@lfdr.de>; Tue, 30 Jul 2024 15:38:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 156181F252B3
	for <lists+linux-ext4@lfdr.de>; Tue, 30 Jul 2024 13:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4E9819F478;
	Tue, 30 Jul 2024 13:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Nhn5VE3l";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="qhbAaeyh";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Nhn5VE3l";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="qhbAaeyh"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87072173;
	Tue, 30 Jul 2024 13:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722346683; cv=none; b=gIFSYF0aFxRBsRuf1yyzKHktwlR7NJsmf/zAh1cVskps43xlfW8rvMGZbE0uoOe6OG8mIzNiEsDGKxIW45OZ6bSJXzCr0+tzOzUb8w/coh35eGYRHL7X+xRoi2ynw0kuQ0XB52F3Z1cFFhs8BVzLnTv1ggqLGlLLOYVg5C91VNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722346683; c=relaxed/simple;
	bh=dA0uhtuOgUhDsyAaODOaK2LIY1drzHDqIl3N9rjT2P0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SMkP2Rc0LpPjMOQuozozDtd1h82qRhYLffKIvX7izCD5OUpYJmav3zq8mb82/i864HIKgKyYq5m7ztWS94LU0MmNEqmSYnz0T04g/1rTrvDojfn9DqkiHqWl4sZVv1AN7j1N5ZVKS8FjI8JJImGUuIXTWCIFH+QpNH11llLPER4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Nhn5VE3l; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=qhbAaeyh; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Nhn5VE3l; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=qhbAaeyh; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A065E21A73;
	Tue, 30 Jul 2024 13:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722346679; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ixEMlP2+wOFI7HiP2zY1F0yJKKpQ4OgmDFRDHgtq7yY=;
	b=Nhn5VE3lw9ZaovzdQoG15E2Dd9TuJWq6ODoPG80/ra781Ct8rjmJFJ+2sC2D0whc4A2eRf
	Klaq81PZ/cKpj7UfpTPeCha2Pzv8NT/RjP/0X8xm/LvltsKNTiaMz+RNvY4BLl3Ae1s1P9
	eTkjRyrcyx/4uwZKcC73v7EWP8miZfU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722346679;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ixEMlP2+wOFI7HiP2zY1F0yJKKpQ4OgmDFRDHgtq7yY=;
	b=qhbAaeyhlcMoTPfnR5vbGa/OvgfcbjHelulABfe6PeztKLjoOYCf1Tmh+O707cvyOm3en2
	fRmuEfXYTqSoODAg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Nhn5VE3l;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=qhbAaeyh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722346679; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ixEMlP2+wOFI7HiP2zY1F0yJKKpQ4OgmDFRDHgtq7yY=;
	b=Nhn5VE3lw9ZaovzdQoG15E2Dd9TuJWq6ODoPG80/ra781Ct8rjmJFJ+2sC2D0whc4A2eRf
	Klaq81PZ/cKpj7UfpTPeCha2Pzv8NT/RjP/0X8xm/LvltsKNTiaMz+RNvY4BLl3Ae1s1P9
	eTkjRyrcyx/4uwZKcC73v7EWP8miZfU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722346679;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ixEMlP2+wOFI7HiP2zY1F0yJKKpQ4OgmDFRDHgtq7yY=;
	b=qhbAaeyhlcMoTPfnR5vbGa/OvgfcbjHelulABfe6PeztKLjoOYCf1Tmh+O707cvyOm3en2
	fRmuEfXYTqSoODAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9742313983;
	Tue, 30 Jul 2024 13:37:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4k7nJLfsqGZ4XQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 30 Jul 2024 13:37:59 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 59EE3A099C; Tue, 30 Jul 2024 15:37:55 +0200 (CEST)
Date: Tue, 30 Jul 2024 15:37:55 +0200
From: Jan Kara <jack@suse.cz>
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: tytso@mit.edu, jack@suse.com, linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/7] jbd2: correct comment jbd2_mark_journal_empty
Message-ID: <20240730133755.lbu65hpxwxq6eo64@quack3>
References: <20240730113335.2365290-1-shikemeng@huaweicloud.com>
 <20240730113335.2365290-7-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240730113335.2365290-7-shikemeng@huaweicloud.com>
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-0.81 / 50.00];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,huaweicloud.com:email,suse.cz:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spamd-Bar: /
X-Rspamd-Queue-Id: A065E21A73
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -0.81

On Tue 30-07-24 19:33:34, Kemeng Shi wrote:
> After jbd2_mark_journal_empty, journal log is supposed to be empty.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

							Honza

> ---
>  fs/jbd2/journal.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> index f17d05bc61df..dc18b9f7c999 100644
> --- a/fs/jbd2/journal.c
> +++ b/fs/jbd2/journal.c
> @@ -1939,7 +1939,7 @@ static void jbd2_mark_journal_empty(journal_t *journal, blk_opf_t write_flags)
>  	if (had_fast_commit)
>  		jbd2_set_feature_fast_commit(journal);
>  
> -	/* Log is no longer empty */
> +	/* Log is empty */
>  	write_lock(&journal->j_state_lock);
>  	journal->j_flags |= JBD2_FLUSHED;
>  	write_unlock(&journal->j_state_lock);
> -- 
> 2.30.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

