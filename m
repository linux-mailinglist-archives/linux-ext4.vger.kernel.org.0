Return-Path: <linux-ext4+bounces-2491-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C9FFE8C4250
	for <lists+linux-ext4@lfdr.de>; Mon, 13 May 2024 15:44:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DE52B242C8
	for <lists+linux-ext4@lfdr.de>; Mon, 13 May 2024 13:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 711A115535A;
	Mon, 13 May 2024 13:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="U0SzHXu5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7HE3OQMp";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="U0SzHXu5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7HE3OQMp"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28BE4153BE7;
	Mon, 13 May 2024 13:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715607702; cv=none; b=esfM9nBZ+wa+sC9hwaSykhE2PrisFCUkvBaSsvId+WmZc4g84HnwL/K1fQXefDlwtZx+0NmZOP2QJmKdyq573Bgk5g9fZb9AgpHjASsz5u6eaMRNolOfinDztbsoww8J6mRAXBEcrRhS87lfEKP9X6gmsf4Icay3JPxIcPpu2yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715607702; c=relaxed/simple;
	bh=bnKv9hUuEE6isl5vUdapDAM5AvVUq4o+jPsROipumjY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JXeD5mTfizhX015lwB/VaQAQJI1+UzL1JLed9K4n1RJrcxJSVUj9soXXIPpp1gZNhKjBmCxp1AP3JWd09BHyGctdYQ7i5KOpMgdQUcBv+r4HWCZxnoDyA+C8OrfZVeyfOtlAzUyeTyYrZs3fWc5At54g2BVuuAjIZMDeNhpOtIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=U0SzHXu5; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7HE3OQMp; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=U0SzHXu5; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7HE3OQMp; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 32E1434A54;
	Mon, 13 May 2024 13:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715607696; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jv6058otnH+uK/D6TMYgyXy8L3PlzLOlJi3KPN9MW6o=;
	b=U0SzHXu5ved92dklWliu0gYyGvo2cTWCquM9Y5M3it/6DiwO0i553RnYUqNGTL0YUas9Sp
	sDnIemX53089ua98IqFMLRCcdp2W9SAUoP8od1L03jaJq2Gtc9S55o7uUaMR0iYmIielbg
	exL6dH2IU1X8A3OyfshVIAd/9cjnkAs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715607696;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jv6058otnH+uK/D6TMYgyXy8L3PlzLOlJi3KPN9MW6o=;
	b=7HE3OQMpygvUyUhHq2kzt5qk9OJipVG1QL5pcyuj0by8rzEUcNv4KQLuijCvaIGnki+lvf
	DPblRSs22o6rkNAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715607696; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jv6058otnH+uK/D6TMYgyXy8L3PlzLOlJi3KPN9MW6o=;
	b=U0SzHXu5ved92dklWliu0gYyGvo2cTWCquM9Y5M3it/6DiwO0i553RnYUqNGTL0YUas9Sp
	sDnIemX53089ua98IqFMLRCcdp2W9SAUoP8od1L03jaJq2Gtc9S55o7uUaMR0iYmIielbg
	exL6dH2IU1X8A3OyfshVIAd/9cjnkAs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715607696;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jv6058otnH+uK/D6TMYgyXy8L3PlzLOlJi3KPN9MW6o=;
	b=7HE3OQMpygvUyUhHq2kzt5qk9OJipVG1QL5pcyuj0by8rzEUcNv4KQLuijCvaIGnki+lvf
	DPblRSs22o6rkNAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E7E0513A6F;
	Mon, 13 May 2024 13:41:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id unAoOI8YQmZaDwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 13 May 2024 13:41:35 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 31CBAA08DA; Sun, 12 May 2024 13:06:35 +0200 (CEST)
Date: Sun, 12 May 2024 13:06:35 +0200
From: Jan Kara <jack@suse.cz>
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: tytso@mit.edu, jack@suse.com, linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/9] jbd2: remove unnedded "need_copy_out" in
 jbd2_journal_write_metadata_buffer
Message-ID: <20240512110635.qqllcn2q4dfyvmzr@quack3>
References: <20240506141801.1165315-1-shikemeng@huaweicloud.com>
 <20240506141801.1165315-4-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240506141801.1165315-4-shikemeng@huaweicloud.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	DATE_IN_PAST(1.00)[26];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.cz:email]
X-Spam-Score: -2.80
X-Spam-Flag: NO

On Mon 06-05-24 22:17:55, Kemeng Shi wrote:
> As we only need to copy out when we should do escape, need_copy_out
> could be simply replaced by "do_escape".
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/jbd2/journal.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> index 068031f35aea..9a35d0c5b38c 100644
> --- a/fs/jbd2/journal.c
> +++ b/fs/jbd2/journal.c
> @@ -327,7 +327,6 @@ int jbd2_journal_write_metadata_buffer(transaction_t *transaction,
>  				  struct buffer_head **bh_out,
>  				  sector_t blocknr)
>  {
> -	int need_copy_out = 0;
>  	int done_copy_out = 0;
>  	int do_escape = 0;
>  	char *mapped_data;
> @@ -382,16 +381,14 @@ int jbd2_journal_write_metadata_buffer(transaction_t *transaction,
>  	/*
>  	 * Check for escaping
>  	 */
> -	if (*((__be32 *)mapped_data) == cpu_to_be32(JBD2_MAGIC_NUMBER)) {
> -		need_copy_out = 1;
> +	if (*((__be32 *)mapped_data) == cpu_to_be32(JBD2_MAGIC_NUMBER))
>  		do_escape = 1;
> -	}
>  	kunmap_local(mapped_data);
>  
>  	/*
>  	 * Do we need to do a data copy?
>  	 */
> -	if (need_copy_out && !done_copy_out) {
> +	if (do_escape && !done_copy_out) {
>  		char *tmp;
>  
>  		spin_unlock(&jh_in->b_state_lock);
> -- 
> 2.30.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

