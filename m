Return-Path: <linux-ext4+bounces-3572-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB1F942DA7
	for <lists+linux-ext4@lfdr.de>; Wed, 31 Jul 2024 14:00:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7EFF2B22E86
	for <lists+linux-ext4@lfdr.de>; Wed, 31 Jul 2024 12:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D47321AD9CA;
	Wed, 31 Jul 2024 12:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hHKKb14G";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1VJjiVbt";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hHKKb14G";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1VJjiVbt"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1CBD18DF93;
	Wed, 31 Jul 2024 12:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722427239; cv=none; b=igNrw7KR9k3uGc+B/AaYX3ivp+wNfJf15sxIzWwef9kr39h/qkwf5UWY4ZKTPxXkTI8JTm3QRdHxoPdbdGUrLvTlfviHiC2Gb53YYp38syQ//bUik4c6G13elhaYMzuivBr1FVcToW9u26k/vifjWxeCnSd6pUiUaoUg1UkXk1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722427239; c=relaxed/simple;
	bh=7X0glzCv49a4A0vWSYBw540pwDZNymabwjdOBbQ0rJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hFauXijTpQU2Q6fij6TbQjFwZ2Pf+KxceXOtTrOzlTqQ+wTiG4Xgws/02lbmyHeKY1Xbtb2Nf2Svyk7MRPIQHpHKiif9l4beYjTljB5ImMZUBnnvnkDgtPuYtqQ3qG1pKhITsn6P8VUPWCp6wmMMLoFzbqbN8XX0ZuH+PKzbixE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=hHKKb14G; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=1VJjiVbt; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=hHKKb14G; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=1VJjiVbt; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1CDD11F84B;
	Wed, 31 Jul 2024 12:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722427236; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j0f3WWCUuOxHtv6OXlvNwnzPFYtZMQULMScewqyDVa8=;
	b=hHKKb14GhBR6DZB1ELkzOxgIbC4/Pfh2fRIkdYobYSNLF3XKhPH1gYVVD1IeEWTZdg/ROT
	WjM16FasoNKVxVdYfvuKoosgSr9H6+ZmQKNBsUSc0v8Oilt7ExmcRwkuP3GXbnoYZzi1Ez
	SUqLE/TZEgYwoaUUcee9plunah3ZP14=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722427236;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j0f3WWCUuOxHtv6OXlvNwnzPFYtZMQULMScewqyDVa8=;
	b=1VJjiVbt6y+CVAj3VUIwvXf0LzLIQQNTU3T1ER6DSZ2eETA04o2gBO17TOJh7Y4St/VX0h
	egU/kPWMNI+fUUCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722427236; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j0f3WWCUuOxHtv6OXlvNwnzPFYtZMQULMScewqyDVa8=;
	b=hHKKb14GhBR6DZB1ELkzOxgIbC4/Pfh2fRIkdYobYSNLF3XKhPH1gYVVD1IeEWTZdg/ROT
	WjM16FasoNKVxVdYfvuKoosgSr9H6+ZmQKNBsUSc0v8Oilt7ExmcRwkuP3GXbnoYZzi1Ez
	SUqLE/TZEgYwoaUUcee9plunah3ZP14=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722427236;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j0f3WWCUuOxHtv6OXlvNwnzPFYtZMQULMScewqyDVa8=;
	b=1VJjiVbt6y+CVAj3VUIwvXf0LzLIQQNTU3T1ER6DSZ2eETA04o2gBO17TOJh7Y4St/VX0h
	egU/kPWMNI+fUUCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E06CA1368F;
	Wed, 31 Jul 2024 12:00:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id z8TINmMnqmYPRwAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 31 Jul 2024 12:00:35 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 99F59A099C; Wed, 31 Jul 2024 14:00:29 +0200 (CEST)
Date: Wed, 31 Jul 2024 14:00:29 +0200
From: Jan Kara <jack@suse.cz>
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: tytso@mit.edu, jack@suse.com, linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/8] jbd2: remove unneeded done_copy_out variable in
 jbd2_journal_write_metadata_buffer
Message-ID: <20240731120029.coefse52w2kwpuip@quack3>
References: <20240731062247.2380440-1-shikemeng@huaweicloud.com>
 <20240731062247.2380440-6-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240731062247.2380440-6-shikemeng@huaweicloud.com>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,huaweicloud.com:email,suse.com:email]
X-Spam-Flag: NO
X-Spam-Score: -3.60

On Wed 31-07-24 14:22:44, Kemeng Shi wrote:
> It's more intuitive to use jh_in->b_frozen_data directly instead of
> done_copy_out variable. Simply remove unneeded done_copy_out variable
> and use b_frozen_data instead.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/jbd2/journal.c | 21 ++++++++-------------
>  1 file changed, 8 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> index 9c1ffb0dc740..f17d05bc61df 100644
> --- a/fs/jbd2/journal.c
> +++ b/fs/jbd2/journal.c
> @@ -318,7 +318,6 @@ int jbd2_journal_write_metadata_buffer(transaction_t *transaction,
>  				  struct buffer_head **bh_out,
>  				  sector_t blocknr)
>  {
> -	int done_copy_out = 0;
>  	int do_escape = 0;
>  	char *mapped_data;
>  	struct buffer_head *new_bh;
> @@ -349,7 +348,6 @@ int jbd2_journal_write_metadata_buffer(transaction_t *transaction,
>  	 * we use that version of the data for the commit.
>  	 */
>  	if (jh_in->b_frozen_data) {
> -		done_copy_out = 1;
>  		new_folio = virt_to_folio(jh_in->b_frozen_data);
>  		new_offset = offset_in_folio(new_folio, jh_in->b_frozen_data);
>  		mapped_data = jh_in->b_frozen_data;
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

