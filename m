Return-Path: <linux-ext4+bounces-620-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E89A821C1F
	for <lists+linux-ext4@lfdr.de>; Tue,  2 Jan 2024 14:00:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C4C51C21ED4
	for <lists+linux-ext4@lfdr.de>; Tue,  2 Jan 2024 13:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84246F9CC;
	Tue,  2 Jan 2024 13:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="DqM8gO8a";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="YSEWdZ6X";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bszH1oMV";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wP5jwO0z"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C216F9D2;
	Tue,  2 Jan 2024 13:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8E5F921EB7;
	Tue,  2 Jan 2024 13:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704200447; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LOBRnj/7Vs57t/uFTKL7wGB7NFXlu9ZAT6BxFnJuEWU=;
	b=DqM8gO8atjYerO6U9emHONbUTxioXoLtPhlXwz4D0QJ79uUay3wtGsr05Zef6lJe5Ar/i9
	F5Kd3C1JWw4AqD8S6UQzlzC2jPUHdT57TpUeji1Dlh9Gj/fiA16aR5B+NMrj42oaTmbLcD
	xUKLTzNL2aXCNdDYN42loSsBKyiJM8M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704200447;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LOBRnj/7Vs57t/uFTKL7wGB7NFXlu9ZAT6BxFnJuEWU=;
	b=YSEWdZ6XD9UQTQ0Z/tipdEBfWyHDr/ROihBIjPzGj7sR25/Y5OUbjDAhKJfiTDPzMUivN1
	nAd6k5y+uKOf+qAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704200446; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LOBRnj/7Vs57t/uFTKL7wGB7NFXlu9ZAT6BxFnJuEWU=;
	b=bszH1oMVaNvMGb/TCE/TvM9Jdk6Kjq+H1uPFPUw3wJFGpQjYqsAoHy4NbUGLJqto46UIjI
	pfOS2JKyq6nxyK/gSjmAjDCaDovYk087aUJeR2/Yxo6wNpz31F5xdcQ4+kNNaZhROx2auG
	pLDytBJJs2a2coowEXus5NYHdQpvfxc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704200446;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LOBRnj/7Vs57t/uFTKL7wGB7NFXlu9ZAT6BxFnJuEWU=;
	b=wP5jwO0zswn8TCbKcR10qms9amI0Je9khH7bsS2mxXJKLpUSd6pMHl/6qqW3bA3hh88T+A
	4F3mt7SM7T9EIGAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 825511340C;
	Tue,  2 Jan 2024 13:00:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9DbOH/4IlGWtSAAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 02 Jan 2024 13:00:46 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 2F4F0A07EF; Tue,  2 Jan 2024 14:00:46 +0100 (CET)
Date: Tue, 2 Jan 2024 14:00:46 +0100
From: Jan Kara <jack@suse.cz>
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/8] ext4: remove unused return value of __mb_check_buddy
Message-ID: <20240102130046.uc4iubviimhgpmis@quack3>
References: <20231125161143.3945726-1-shikemeng@huaweicloud.com>
 <20231125161143.3945726-2-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231125161143.3945726-2-shikemeng@huaweicloud.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: ****
X-Spam-Score: 4.30
X-Spamd-Result: default: False [4.30 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_SPAM(5.10)[100.00%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO

On Sun 26-11-23 00:11:36, Kemeng Shi wrote:
> Remove unused return value of __mb_check_buddy.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/mballoc.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 454d56126..9f9b8dd06 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -677,7 +677,7 @@ do {									\
>  	}								\
>  } while (0)
>  
> -static int __mb_check_buddy(struct ext4_buddy *e4b, char *file,
> +static void __mb_check_buddy(struct ext4_buddy *e4b, char *file,
>  				const char *function, int line)
>  {
>  	struct super_block *sb = e4b->bd_sb;
> @@ -696,7 +696,7 @@ static int __mb_check_buddy(struct ext4_buddy *e4b, char *file,
>  	void *buddy2;
>  
>  	if (e4b->bd_info->bb_check_counter++ % 10)
> -		return 0;
> +		return;
>  
>  	while (order > 1) {
>  		buddy = mb_find_buddy(e4b, order, &max);
> @@ -758,7 +758,7 @@ static int __mb_check_buddy(struct ext4_buddy *e4b, char *file,
>  
>  	grp = ext4_get_group_info(sb, e4b->bd_group);
>  	if (!grp)
> -		return NULL;
> +		return;
>  	list_for_each(cur, &grp->bb_prealloc_list) {
>  		ext4_group_t groupnr;
>  		struct ext4_prealloc_space *pa;
> @@ -768,7 +768,6 @@ static int __mb_check_buddy(struct ext4_buddy *e4b, char *file,
>  		for (i = 0; i < pa->pa_len; i++)
>  			MB_CHECK_ASSERT(mb_test_bit(k + i, buddy));
>  	}
> -	return 0;
>  }
>  #undef MB_CHECK_ASSERT
>  #define mb_check_buddy(e4b) __mb_check_buddy(e4b,	\
> -- 
> 2.30.0
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

