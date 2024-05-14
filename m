Return-Path: <linux-ext4+bounces-2511-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 332868C5E27
	for <lists+linux-ext4@lfdr.de>; Wed, 15 May 2024 01:43:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6AAC1F21582
	for <lists+linux-ext4@lfdr.de>; Tue, 14 May 2024 23:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9166182CA4;
	Tue, 14 May 2024 23:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LAgfWWD6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="k+oGnfHS";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LAgfWWD6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="k+oGnfHS"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C141E491;
	Tue, 14 May 2024 23:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715730173; cv=none; b=Gzv6AF9thYI7nurJLazOERceyht1ricgvZEDmPsZMgFw+hLrtgMhMgyo5tXvLqpWvwgxHV43HXc/QoFA+T2GcLCf71TTjsGe4Q/23iVv33GJkn0p6m0u2bH/9lNN8lUuHIaLbeh2RfzWSurFQUr3PD3Kf0caSjU/6prZfZONVBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715730173; c=relaxed/simple;
	bh=fYSwDpuW4GhmMPIAz4xHNUDOByuEcQeBnQCI8bspCJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZRfO2FX4QcLIYwI19nNrOA3D1nxZfxqGkou7jeEmqMkiaoarXKlgrReMm2NuYUJsQgJcTFF1pRTFA9wvP8UoXGmLukxlTWTCN5vcphPygnjjX1ic2ztR7xWFashMWnyIADhb3V4wbzjjJv0NBfRXR0UFPrzT5t2qg4mw8mlD+qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LAgfWWD6; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=k+oGnfHS; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LAgfWWD6; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=k+oGnfHS; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B3D7222CA4;
	Tue, 14 May 2024 23:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715730169; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5elmeUPTP1BK9yq34XxdelS1MaponklyZgQTVC7NNqc=;
	b=LAgfWWD6YxVRZ10JMoW5EyJiGrSlbHax+FAsPiRcRbj6pK5XGP/xAVM6ZYxlj37SwodQgL
	cbm4Y0maKV2BNDh7PBuuzxla+IiPMDLER3+59bzWZJnYDdHwvaphP2dzE9BuQA4V9MR9lf
	2iLg5SS76slFj1nZnxw1LTkCqBpXKNI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715730169;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5elmeUPTP1BK9yq34XxdelS1MaponklyZgQTVC7NNqc=;
	b=k+oGnfHSPDR2Q9g2FQi6i06nBWeutO+yzFgakDQJRVptvUulsrrv4XrlB1pzMkzr365YE8
	xRz1HoCpyhxJ0EDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=LAgfWWD6;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=k+oGnfHS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715730169; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5elmeUPTP1BK9yq34XxdelS1MaponklyZgQTVC7NNqc=;
	b=LAgfWWD6YxVRZ10JMoW5EyJiGrSlbHax+FAsPiRcRbj6pK5XGP/xAVM6ZYxlj37SwodQgL
	cbm4Y0maKV2BNDh7PBuuzxla+IiPMDLER3+59bzWZJnYDdHwvaphP2dzE9BuQA4V9MR9lf
	2iLg5SS76slFj1nZnxw1LTkCqBpXKNI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715730169;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5elmeUPTP1BK9yq34XxdelS1MaponklyZgQTVC7NNqc=;
	b=k+oGnfHSPDR2Q9g2FQi6i06nBWeutO+yzFgakDQJRVptvUulsrrv4XrlB1pzMkzr365YE8
	xRz1HoCpyhxJ0EDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5515B137C3;
	Tue, 14 May 2024 23:42:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BnZVFPn2Q2ZbTQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 14 May 2024 23:42:49 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id B17B4A08B5; Wed, 15 May 2024 01:42:46 +0200 (CEST)
Date: Wed, 15 May 2024 01:42:46 +0200
From: Jan Kara <jack@suse.cz>
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: tytso@mit.edu, jack@suse.com, yi.zhang@huaweicloud.com,
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/9] jbd2: jump to new copy_done tag when
 b_frozen_data is created concurrently
Message-ID: <20240514234246.3kspcjji4pjrwsnc@quack3>
References: <20240514112438.1269037-1-shikemeng@huaweicloud.com>
 <20240514112438.1269037-5-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240514112438.1269037-5-shikemeng@huaweicloud.com>
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: B3D7222CA4
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DKIM_TRACE(0.00)[suse.cz:+]

On Tue 14-05-24 19:24:33, Kemeng Shi wrote:
> If b_frozen_data is created concurrently, we can update new_folio and
> new_offset with b_frozen_data and then move forward
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/jbd2/journal.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> index 714e2ef0115a..5fb5062cf7ae 100644
> --- a/fs/jbd2/journal.c
> +++ b/fs/jbd2/journal.c
> @@ -351,7 +351,6 @@ int jbd2_journal_write_metadata_buffer(transaction_t *transaction,
>  	atomic_set(&new_bh->b_count, 1);
>  
>  	spin_lock(&jh_in->b_state_lock);
> -repeat:
>  	/*
>  	 * If a new transaction has already done a buffer copy-out, then
>  	 * we use that version of the data for the commit.
> @@ -399,22 +398,22 @@ int jbd2_journal_write_metadata_buffer(transaction_t *transaction,
>  		spin_lock(&jh_in->b_state_lock);
>  		if (jh_in->b_frozen_data) {
>  			jbd2_free(tmp, bh_in->b_size);
> -			goto repeat;
> +			goto copy_done;
>  		}
>  
>  		jh_in->b_frozen_data = tmp;
>  		memcpy_from_folio(tmp, new_folio, new_offset, bh_in->b_size);
> -
> -		new_folio = virt_to_folio(tmp);
> -		new_offset = offset_in_folio(new_folio, tmp);
> -		done_copy_out = 1;
> -
>  		/*
>  		 * This isn't strictly necessary, as we're using frozen
>  		 * data for the escaping, but it keeps consistency with
>  		 * b_frozen_data usage.
>  		 */
>  		jh_in->b_frozen_triggers = jh_in->b_triggers;
> +
> +copy_done:
> +		new_folio = virt_to_folio(jh_in->b_frozen_data);
> +		new_offset = offset_in_folio(new_folio, jh_in->b_frozen_data);
> +		done_copy_out = 1;
>  	}
>  
>  	/*
> -- 
> 2.30.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

