Return-Path: <linux-ext4+bounces-3526-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C806794132C
	for <lists+linux-ext4@lfdr.de>; Tue, 30 Jul 2024 15:33:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAC801C23256
	for <lists+linux-ext4@lfdr.de>; Tue, 30 Jul 2024 13:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C0ED19EEC8;
	Tue, 30 Jul 2024 13:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ubMPzN2v";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7W2u5j1S";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ubMPzN2v";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7W2u5j1S"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9CA63D;
	Tue, 30 Jul 2024 13:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722346376; cv=none; b=UDu6CuQQ7+2UyF5cB8ENDtqYooPnpXheSLBtWNNnZCS6ogBSzs+F4OxwxjaO2ibeSUpST2a+P7xykHcZzIzNzSoBBis8KRtAW4+Vyim7hd937youpLU23yTHsCj2J8FREVDJ8hCAbzM3Be3Tg39y7oKXzPjMIjSp/NRlgsI7Aew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722346376; c=relaxed/simple;
	bh=adhNAza1pVf4N1QsdW9F7E1DGAcCpUgTsaAlRdYFLGM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LuB+GEVo3CkmZiifRhjQ+EpundwITuS36OtHBkZ1Qhx00N+z07AHluFhqMK7EyPqE1Vb8jqGrWy14WA5zutz0y2yNvebxlhx8UzcTfJw6Jbu+J+BWm9+RDpuj+tmsDZL9o2il7GAjhfOl4QWJ5xVCiYit3i8RK8Jpe6OrS2ij88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ubMPzN2v; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7W2u5j1S; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ubMPzN2v; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7W2u5j1S; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 36F8921A79;
	Tue, 30 Jul 2024 13:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722346373; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5S44Wdgx/0xNGoWaOUDCn2p2slrl+ejMtJf7mRLMCow=;
	b=ubMPzN2vfcCd/dgQUY4ppyFzIvjWJsKuUTfKKugCQg9SkjjXCjfvkGWcEIUerYSTyv6IMw
	xic2aAyytSutmZb311JQfjP3W3UvPfvkfbqMqTIz5wHGg9+rPfFqF3Vdjf40RxXgfE2Csv
	UIEUxjbcZWzFlovbZ8yHBCTin0MXEqY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722346373;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5S44Wdgx/0xNGoWaOUDCn2p2slrl+ejMtJf7mRLMCow=;
	b=7W2u5j1STbAsm44iftW7SLwENGga7cLAt/0hK4cD1zg7q6qfQu4tgxUJZDisf1IU6Yldko
	JZPpqqs+QZi+VXDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722346373; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5S44Wdgx/0xNGoWaOUDCn2p2slrl+ejMtJf7mRLMCow=;
	b=ubMPzN2vfcCd/dgQUY4ppyFzIvjWJsKuUTfKKugCQg9SkjjXCjfvkGWcEIUerYSTyv6IMw
	xic2aAyytSutmZb311JQfjP3W3UvPfvkfbqMqTIz5wHGg9+rPfFqF3Vdjf40RxXgfE2Csv
	UIEUxjbcZWzFlovbZ8yHBCTin0MXEqY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722346373;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5S44Wdgx/0xNGoWaOUDCn2p2slrl+ejMtJf7mRLMCow=;
	b=7W2u5j1STbAsm44iftW7SLwENGga7cLAt/0hK4cD1zg7q6qfQu4tgxUJZDisf1IU6Yldko
	JZPpqqs+QZi+VXDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 289A513983;
	Tue, 30 Jul 2024 13:32:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0vCoCYXrqGbHWwAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 30 Jul 2024 13:32:53 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id D6406A099C; Tue, 30 Jul 2024 15:32:48 +0200 (CEST)
Date: Tue, 30 Jul 2024 15:32:48 +0200
From: Jan Kara <jack@suse.cz>
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: tytso@mit.edu, jack@suse.com, linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/7] jbd2: remove unneeded kmap for jh_in->b_frozen_data
 in jbd2_journal_write_metadata_buffer
Message-ID: <20240730133248.k4ttccw3gla6xgoy@quack3>
References: <20240730113335.2365290-1-shikemeng@huaweicloud.com>
 <20240730113335.2365290-5-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240730113335.2365290-5-shikemeng@huaweicloud.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.60 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huaweicloud.com:email,suse.com:email]
X-Spam-Flag: NO
X-Spam-Score: -3.60

On Tue 30-07-24 19:33:32, Kemeng Shi wrote:
> Remove kmap for page of b_frozen_data from jbd2_alloc() which always
> provides an address from the direct kernel mapping.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>

I don't think this is really a win. On majority of installations kmap is a
noop anyway and for the remainder kmap_local() is cheap. And the
readability of the code is just worse with this.

								Honza

> ---
>  fs/jbd2/journal.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> index 312c7575b54f..9c1ffb0dc740 100644
> --- a/fs/jbd2/journal.c
> +++ b/fs/jbd2/journal.c
> @@ -352,12 +352,13 @@ int jbd2_journal_write_metadata_buffer(transaction_t *transaction,
>  		done_copy_out = 1;
>  		new_folio = virt_to_folio(jh_in->b_frozen_data);
>  		new_offset = offset_in_folio(new_folio, jh_in->b_frozen_data);
> +		mapped_data = jh_in->b_frozen_data;
>  	} else {
>  		new_folio = bh_in->b_folio;
>  		new_offset = offset_in_folio(new_folio, bh_in->b_data);
> +		mapped_data = kmap_local_folio(new_folio, new_offset);
>  	}
>  
> -	mapped_data = kmap_local_folio(new_folio, new_offset);
>  	/*
>  	 * Fire data frozen trigger if data already wasn't frozen.  Do this
>  	 * before checking for escaping, as the trigger may modify the magic
> @@ -373,7 +374,8 @@ int jbd2_journal_write_metadata_buffer(transaction_t *transaction,
>  	 */
>  	if (*((__be32 *)mapped_data) == cpu_to_be32(JBD2_MAGIC_NUMBER))
>  		do_escape = 1;
> -	kunmap_local(mapped_data);
> +	if (!jh_in->b_frozen_data)
> +		kunmap_local(mapped_data);
>  
>  	/*
>  	 * Do we need to do a data copy?
> -- 
> 2.30.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

