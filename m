Return-Path: <linux-ext4+bounces-2487-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 331E98C4249
	for <lists+linux-ext4@lfdr.de>; Mon, 13 May 2024 15:43:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D4F31F21B84
	for <lists+linux-ext4@lfdr.de>; Mon, 13 May 2024 13:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF0E915530F;
	Mon, 13 May 2024 13:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LywpPHr8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="fQu2vBiS";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LywpPHr8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="fQu2vBiS"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D06153BFB;
	Mon, 13 May 2024 13:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715607701; cv=none; b=X5LO8LLI47ZNrSA2mQop7IhqKdt99ddPbi/S64K6GPIlEQGIpi8cXlMdBzhc0ULehYCCo344E4i/Tag3MIXQdJVScrY4DLsNg5LVoqK6OxpigHVBzT6/C/eEIL1yUuKANBCKDo9TY8F8Xk6fDNQ75JydUJMbvpcmECkQE8JW1Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715607701; c=relaxed/simple;
	bh=i2MZywAms1251QhXPG9roroqj1uofnRXMJPm9D0qYJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CuoQ2jzOgzxOsKIgMDt+R97994I17yOsuwBKKAQp5nJoTnSW8vfQPWstRoZ5T/CgmAPNOCUFQ18jbsWRFaP/AE2IetLQfVA6jhD7e6vcwUuZb9jsnZyfRW3kFGRMrfXBfGsoUDCWIH5OLo2gGzUDkdrPbCGfQ3xDxhQYVpM+F7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LywpPHr8; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=fQu2vBiS; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LywpPHr8; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=fQu2vBiS; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 30F0B34A56;
	Mon, 13 May 2024 13:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715607697; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZTbT2D0BxWrI6ugnXsYApYO0mCuLz8/GBZsyHz5AITg=;
	b=LywpPHr8MVZhU4t3Ayr5PDKQI435hHFCtQzwUwTrKk8AIzXsSpGo08Y6LP/axk8o8cLmpu
	jBpWM0wZBaIo96htK5cC6Etr6ed0BNCMoaE3GUs3UEqT7gatT+qRdUkgZG4hLKZM/GU1h4
	1P6DqhflqHO99HGluMiqx8eyxMTYyRA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715607697;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZTbT2D0BxWrI6ugnXsYApYO0mCuLz8/GBZsyHz5AITg=;
	b=fQu2vBiSErwfn3bav/a1iPyp7s2eqa4ycdnLCBRJDGP/AU3Mwtn+GIUbHVecLb670nr3z4
	bX0RK6/qv8lZ+bDw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=LywpPHr8;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=fQu2vBiS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715607697; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZTbT2D0BxWrI6ugnXsYApYO0mCuLz8/GBZsyHz5AITg=;
	b=LywpPHr8MVZhU4t3Ayr5PDKQI435hHFCtQzwUwTrKk8AIzXsSpGo08Y6LP/axk8o8cLmpu
	jBpWM0wZBaIo96htK5cC6Etr6ed0BNCMoaE3GUs3UEqT7gatT+qRdUkgZG4hLKZM/GU1h4
	1P6DqhflqHO99HGluMiqx8eyxMTYyRA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715607697;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZTbT2D0BxWrI6ugnXsYApYO0mCuLz8/GBZsyHz5AITg=;
	b=fQu2vBiSErwfn3bav/a1iPyp7s2eqa4ycdnLCBRJDGP/AU3Mwtn+GIUbHVecLb670nr3z4
	bX0RK6/qv8lZ+bDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 02B6113A5F;
	Mon, 13 May 2024 13:41:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uEKkAJEYQmaRDwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 13 May 2024 13:41:37 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id F3660A08E6; Sun, 12 May 2024 13:24:27 +0200 (CEST)
Date: Sun, 12 May 2024 13:24:27 +0200
From: Jan Kara <jack@suse.cz>
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: tytso@mit.edu, jack@suse.com, linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/9] jbd2: remove dead check of JBD2_UNMOUNT in kjournald2
Message-ID: <20240512112427.zo5jmjxovts5ekdu@quack3>
References: <20240506141801.1165315-1-shikemeng@huaweicloud.com>
 <20240506141801.1165315-9-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240506141801.1165315-9-shikemeng@huaweicloud.com>
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 30F0B34A56
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	DATE_IN_PAST(1.00)[26];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MISSING_XM_UA(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]

On Mon 06-05-24 22:18:00, Kemeng Shi wrote:
> We always set JBD2_UNMOUNT with j_state_lock held in journal_kill_thread.
> In kjournald2, we check JBD2_UNMOUNT flag two times under the same
> j_state_lock. Then the second check is unnecessary.
> Also see comment in struct journal_s about lock rule of j_flags.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/jbd2/journal.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> index e8f592fbd6e1..ce9004f40ffb 100644
> --- a/fs/jbd2/journal.c
> +++ b/fs/jbd2/journal.c
> @@ -228,8 +228,6 @@ static int kjournald2(void *arg)
>  		if (transaction && time_after_eq(jiffies,
>  						transaction->t_expires))
>  			should_sleep = 0;
> -		if (journal->j_flags & JBD2_UNMOUNT)
> -			should_sleep = 0;
>  		if (should_sleep) {
>  			write_unlock(&journal->j_state_lock);
>  			schedule();
> -- 
> 2.30.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

