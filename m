Return-Path: <linux-ext4+bounces-3571-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0A66942DA4
	for <lists+linux-ext4@lfdr.de>; Wed, 31 Jul 2024 14:00:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F7CE1C2200B
	for <lists+linux-ext4@lfdr.de>; Wed, 31 Jul 2024 12:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6CEE1AD416;
	Wed, 31 Jul 2024 12:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PPS2FjUk";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mwwokeb2";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PPS2FjUk";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mwwokeb2"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F291AA3EC;
	Wed, 31 Jul 2024 12:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722427226; cv=none; b=YGRju9eJmsTWLqH+kAwEOh0leawgycyWQN/nlXaY8K3lmw2nGi4Ahl9fDsgNVPlQbOn0i/SJEBm5uQZxOR7h6p/HpZ0kKk/QlDhhVLSKlTiUuUICC2SNIhUu9VIXYm89g50khZplFKqhR/JJ9ll26iTYkr0p2dBxyFVb/Ya8C0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722427226; c=relaxed/simple;
	bh=ta1O0518Lcfw7BfTJw32bDytobN+lLxj83NzoQlWQ6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QpoRL32wwACxXrdp+QZNJJRLa4y2iEx08m8UC+VC94aXh7pFrlWi8izGZTv9J8Qhtnn8bAX/PH5T2YPI6Md6HlYQGuh2UH0nCi1LoWYOl0vUYBGUvr8xldIH5bwbgUSrbFftlIQzA5atgysdlcgGxZVkntJHzTauytFSQ7FHTeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PPS2FjUk; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=mwwokeb2; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PPS2FjUk; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=mwwokeb2; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A5A851F84D;
	Wed, 31 Jul 2024 12:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722427222; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZJ95qJziCzeZyEUUv/bvBxmYwS6mVIvuDyz74A6E5zs=;
	b=PPS2FjUkKtSeWekEmyMhjeKiIv/wDjxELpnSIUuVwN+Ngypb5kt4AU9ZhC+2dQe5x1t2cX
	AAFfs2K1bpJNn14QhDSG6WFeO/SD/YaRDSodEcz1Mh3FmLJyg7qDeTKVCxF8ZkSGOp/yYr
	eJkGCaaDAfmyUyNqVfoUvvOdNtowcxI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722427222;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZJ95qJziCzeZyEUUv/bvBxmYwS6mVIvuDyz74A6E5zs=;
	b=mwwokeb2KehAXGi0gzhq99mvYxFC0MHtfPBWyY0YR3WjQXp4GPaEuv4oyErp53UXcGxvxZ
	d4uADdT07Kk67YBg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=PPS2FjUk;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=mwwokeb2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722427222; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZJ95qJziCzeZyEUUv/bvBxmYwS6mVIvuDyz74A6E5zs=;
	b=PPS2FjUkKtSeWekEmyMhjeKiIv/wDjxELpnSIUuVwN+Ngypb5kt4AU9ZhC+2dQe5x1t2cX
	AAFfs2K1bpJNn14QhDSG6WFeO/SD/YaRDSodEcz1Mh3FmLJyg7qDeTKVCxF8ZkSGOp/yYr
	eJkGCaaDAfmyUyNqVfoUvvOdNtowcxI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722427222;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZJ95qJziCzeZyEUUv/bvBxmYwS6mVIvuDyz74A6E5zs=;
	b=mwwokeb2KehAXGi0gzhq99mvYxFC0MHtfPBWyY0YR3WjQXp4GPaEuv4oyErp53UXcGxvxZ
	d4uADdT07Kk67YBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 42D6D1368F;
	Wed, 31 Jul 2024 12:00:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7exKEFYnqmb6RgAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 31 Jul 2024 12:00:22 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 114ADA099C; Wed, 31 Jul 2024 14:00:17 +0200 (CEST)
Date: Wed, 31 Jul 2024 14:00:17 +0200
From: Jan Kara <jack@suse.cz>
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: tytso@mit.edu, jack@suse.com, linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/8] ext4: move escape handle to futher improve
 jbd2_journal_write_metadata_buffer
Message-ID: <20240731120017.m7jsl3vbsrempupv@quack3>
References: <20240731062247.2380440-1-shikemeng@huaweicloud.com>
 <20240731062247.2380440-7-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240731062247.2380440-7-shikemeng@huaweicloud.com>
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-0.81 / 50.00];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huaweicloud.com:email,suse.cz:email,suse.cz:dkim,suse.com:email];
	MISSING_XM_UA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spamd-Bar: /
X-Rspamd-Queue-Id: A5A851F84D
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -0.81

On Wed 31-07-24 14:22:45, Kemeng Shi wrote:
> Move escape handle to futher improve code readability and remove some
> repeat check.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> Suggested-by: Jan Kara <jack@suse.cz>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/jbd2/journal.c | 49 +++++++++++++++++++++++------------------------
>  1 file changed, 24 insertions(+), 25 deletions(-)
> 
> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> index f17d05bc61df..85273fb1accb 100644
> --- a/fs/jbd2/journal.c
> +++ b/fs/jbd2/journal.c
> @@ -281,6 +281,16 @@ static void journal_kill_thread(journal_t *journal)
>  	write_unlock(&journal->j_state_lock);
>  }
>  
> +static inline bool jbd2_data_needs_escaping(char *data)
> +{
> +	return *((__be32 *)data) == cpu_to_be32(JBD2_MAGIC_NUMBER);
> +}
> +
> +static inline void jbd2_data_do_escape(char *data)
> +{
> +	*((unsigned int *)data) = 0;
> +}
> +
>  /*
>   * jbd2_journal_write_metadata_buffer: write a metadata buffer to the journal.
>   *
> @@ -319,7 +329,6 @@ int jbd2_journal_write_metadata_buffer(transaction_t *transaction,
>  				  sector_t blocknr)
>  {
>  	int do_escape = 0;
> -	char *mapped_data;
>  	struct buffer_head *new_bh;
>  	struct folio *new_folio;
>  	unsigned int new_offset;
> @@ -350,8 +359,13 @@ int jbd2_journal_write_metadata_buffer(transaction_t *transaction,
>  	if (jh_in->b_frozen_data) {
>  		new_folio = virt_to_folio(jh_in->b_frozen_data);
>  		new_offset = offset_in_folio(new_folio, jh_in->b_frozen_data);
> -		mapped_data = jh_in->b_frozen_data;
> +		do_escape = jbd2_data_needs_escaping(jh_in->b_frozen_data);
> +		if (do_escape)
> +			jbd2_data_do_escape(jh_in->b_frozen_data);
>  	} else {
> +		char *tmp;
> +		char *mapped_data;
> +
>  		new_folio = bh_in->b_folio;
>  		new_offset = offset_in_folio(new_folio, bh_in->b_data);
>  		mapped_data = kmap_local_folio(new_folio, new_offset);
> @@ -363,21 +377,13 @@ int jbd2_journal_write_metadata_buffer(transaction_t *transaction,
>  		 */
>  		jbd2_buffer_frozen_trigger(jh_in, mapped_data,
>  					   jh_in->b_triggers);
> -	}
> -
> -	/*
> -	 * Check for escaping
> -	 */
> -	if (*((__be32 *)mapped_data) == cpu_to_be32(JBD2_MAGIC_NUMBER))
> -		do_escape = 1;
> -	if (!jh_in->b_frozen_data)
> +		do_escape = jbd2_data_needs_escaping(mapped_data);
>  		kunmap_local(mapped_data);
> -
> -	/*
> -	 * Do we need to do a data copy?
> -	 */
> -	if (do_escape && !jh_in->b_frozen_data) {
> -		char *tmp;
> +		/*
> +		 * Do we need to do a data copy?
> +		 */
> +		if (!do_escape)
> +			goto escape_done;
>  
>  		spin_unlock(&jh_in->b_state_lock);
>  		tmp = jbd2_alloc(bh_in->b_size, GFP_NOFS);
> @@ -404,17 +410,10 @@ int jbd2_journal_write_metadata_buffer(transaction_t *transaction,
>  copy_done:
>  		new_folio = virt_to_folio(jh_in->b_frozen_data);
>  		new_offset = offset_in_folio(new_folio, jh_in->b_frozen_data);
> +		jbd2_data_do_escape(jh_in->b_frozen_data);
>  	}
>  
> -	/*
> -	 * Did we need to do an escaping?  Now we've done all the
> -	 * copying, we can finally do so.
> -	 * b_frozen_data is from jbd2_alloc() which always provides an
> -	 * address from the direct kernels mapping.
> -	 */
> -	if (do_escape)
> -		*((unsigned int *)jh_in->b_frozen_data) = 0;
> -
> +escape_done:
>  	folio_set_bh(new_bh, new_folio, new_offset);
>  	new_bh->b_size = bh_in->b_size;
>  	new_bh->b_bdev = journal->j_dev;
> -- 
> 2.30.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

