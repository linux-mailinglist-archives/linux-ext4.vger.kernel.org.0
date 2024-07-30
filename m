Return-Path: <linux-ext4+bounces-3530-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CD62C94139A
	for <lists+linux-ext4@lfdr.de>; Tue, 30 Jul 2024 15:50:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2AAE9B2367C
	for <lists+linux-ext4@lfdr.de>; Tue, 30 Jul 2024 13:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF0BB1A08A4;
	Tue, 30 Jul 2024 13:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="CzfF7ntO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9NAV39oo";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sei8oBXd";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="dxIb1Y8J"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF841A073B;
	Tue, 30 Jul 2024 13:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722347388; cv=none; b=p2GDfT6KD+z5zsB8VAp/Xf9qpk81lM7DG/puUPFQXUsABMAv9EnHdwImE3WAs1LW7JBYewVi23mRKqB0jZPHwcHPSON6LlrEZEt1H68gPGifxPPiWh+e7Ey2XknKH+hxsXGwY5/04gs/gnZr6Ja4nVsSW955yh9sR5X4lGkUzfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722347388; c=relaxed/simple;
	bh=jU3aiZVomZnAPqUoHCHAli8BTgU6RkcwBw95QvWafrg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cCTtGBSHxwh5kP3ll0bIb+oHXeG3dcjJvvnGjQGf+EK4weD0euxWqCm2d+XIN7nti25abYC+3WdZKOwELelDTr8vONH4DAZL52OGVSqFFye2VZbLAlNjfpgO0QH3jD+NGpvqkbt7o6hZwLvlGd/Itb/s1eih10DKhgjD7R5DbAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=CzfF7ntO; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9NAV39oo; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=sei8oBXd; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=dxIb1Y8J; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E3FFC21B2B;
	Tue, 30 Jul 2024 13:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722347384; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SRUJ85wJganPzBfhSgfDqep7IoKWMa8zEd3jiw9hB6k=;
	b=CzfF7ntOH3/Nkn63GmQnXxq6mK/m0cl6+7aWODtArZZpoLzhuvNjJ5qkzGZeinkKvmdQ0J
	qsCYmfaKGo+Pt9LvMCZwjRL45EM/Ccoc1b4ujhY5cLK2A64nKiP3pGIK7JZq0BwJ7GOYTZ
	jnMOC/VxFIwBs8A4sSKzwmv9wA9NPhY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722347384;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SRUJ85wJganPzBfhSgfDqep7IoKWMa8zEd3jiw9hB6k=;
	b=9NAV39oo0fE0B2OvBmYWysJnxGmIVHdRp1He7xAyrGF4ll7kK5H9L6UGspVXOMsGudcT95
	if0bTwhcp1OZU+Dw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=sei8oBXd;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=dxIb1Y8J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722347383; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SRUJ85wJganPzBfhSgfDqep7IoKWMa8zEd3jiw9hB6k=;
	b=sei8oBXdF7tuQIXaYjnVHIOjjuJb8tfLXlDjA8lKDt8UTvdvSZ/qJJw6gGeeR+BxzopjR1
	zUnKJXMaPOkajIWJxRcbJApYEHqwIU8ddaNVySjpI3wrAZy1rgyViJS/y1eMC56u9B6zvh
	kIwuy49VQyuA9ybOWOg81TeDpPFEL/o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722347383;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SRUJ85wJganPzBfhSgfDqep7IoKWMa8zEd3jiw9hB6k=;
	b=dxIb1Y8JexEACAvJGWbIRuUiA6HrH1GH1Kjbb4pL5TDYohvDurOYWJ3fTK+MBnQ2Xbn+/O
	YzHBdVHaoBuIpZBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CD98313983;
	Tue, 30 Jul 2024 13:49:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YN8rMnfvqGYSYQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 30 Jul 2024 13:49:43 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 7A6CAA099C; Tue, 30 Jul 2024 15:49:43 +0200 (CEST)
Date: Tue, 30 Jul 2024 15:49:43 +0200
From: Jan Kara <jack@suse.cz>
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: tytso@mit.edu, jack@suse.com, linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/7] jbd2: remove unneeded done_copy_out variable in
 jbd2_journal_write_metadata_buffer
Message-ID: <20240730134943.ircjz6l5ix6zmmwe@quack3>
References: <20240730113335.2365290-1-shikemeng@huaweicloud.com>
 <20240730113335.2365290-6-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240730113335.2365290-6-shikemeng@huaweicloud.com>
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: E3FFC21B2B
X-Spam-Score: -3.81
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.81 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.cz:dkim,huaweicloud.com:email];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]

On Tue 30-07-24 19:33:33, Kemeng Shi wrote:
> It's more intuitive to use jh_in->b_frozen_data directly instead of
> done_copy_out variable. Simply remove unneeded done_copy_out variable
> and use b_frozen_data instead.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>

> @@ -357,17 +355,15 @@ int jbd2_journal_write_metadata_buffer(transaction_t *transaction,
>  		new_folio = bh_in->b_folio;
>  		new_offset = offset_in_folio(new_folio, bh_in->b_data);
>  		mapped_data = kmap_local_folio(new_folio, new_offset);
> -	}
> -
> -	/*
> -	 * Fire data frozen trigger if data already wasn't frozen.  Do this
> -	 * before checking for escaping, as the trigger may modify the magic
> -	 * offset.  If a copy-out happens afterwards, it will have the correct
> -	 * data in the buffer.
> -	 */
> -	if (!done_copy_out)
> +		/*
> +		 * Fire data frozen trigger if data already wasn't frozen. Do
> +		 * this before checking for escaping, as the trigger may modify
> +		 * the magic offset.  If a copy-out happens afterwards, it will
> +		 * have the correct data in the buffer.
> +		 */
>  		jbd2_buffer_frozen_trigger(jh_in, mapped_data,
>  					   jh_in->b_triggers);
> +	}

I like how you've got rid of the conditional. But I'd go further and also
move the escaping check and thus unmap & possible frozen buffer creation
into the branch. Like:

		do_escape = jbd2_data_needs_escaping(mapped_data);
			- create this trivial helper
		kunmap_local(mapped_data);
		if (do_escape) {
			handle b_frozen_data creation
		}

								Honza

>  
>  	/*
>  	 * Check for escaping
> @@ -380,7 +376,7 @@ int jbd2_journal_write_metadata_buffer(transaction_t *transaction,
>  	/*
>  	 * Do we need to do a data copy?
>  	 */
> -	if (do_escape && !done_copy_out) {
> +	if (do_escape && !jh_in->b_frozen_data) {
>  		char *tmp;
>  
>  		spin_unlock(&jh_in->b_state_lock);
> @@ -408,7 +404,6 @@ int jbd2_journal_write_metadata_buffer(transaction_t *transaction,
>  copy_done:
>  		new_folio = virt_to_folio(jh_in->b_frozen_data);
>  		new_offset = offset_in_folio(new_folio, jh_in->b_frozen_data);
> -		done_copy_out = 1;
>  	}
>  
>  	/*
> -- 
> 2.30.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

