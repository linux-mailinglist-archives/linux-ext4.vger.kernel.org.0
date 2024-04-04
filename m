Return-Path: <linux-ext4+bounces-1861-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E34D28989C9
	for <lists+linux-ext4@lfdr.de>; Thu,  4 Apr 2024 16:19:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42A11B22C19
	for <lists+linux-ext4@lfdr.de>; Thu,  4 Apr 2024 14:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 505E91292F2;
	Thu,  4 Apr 2024 14:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="jD3gmdwb";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="vEKXyExf";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="jD3gmdwb";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="vEKXyExf"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09559128812;
	Thu,  4 Apr 2024 14:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712240354; cv=none; b=iDFMAB4cSqyrr56K9L5r9w+rIkT0MFiEB+aPWzzheCojpPXrW8tLH4Y4B1U2y5oumegGsp2TcFtCJg+Kbnbt6NH+7XRBjJlzDAbEOBkMUh5JKfXfxMkilJlmGFe/LpDtneOYWvnMAazMqsEW99Ng/1hwQKVmiNzU/LNi41Qlp3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712240354; c=relaxed/simple;
	bh=XJjDieTO1w0pl8GzPETpUUaCgNf0AYfLaFI+Dk9srHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sv7LYczBiTgLs4P1PTQjqfLd9NUmXwUhDYECyF2bIyveU0sN6b27gE4zi4OdkjIvdu9bhMk8IwuZmGN6ZRIjyg8hqXVL4EyKvODYxvPirYdTl/VPZidxRuiyHWNXXsmxthsn56Q/0vIGc7JmtfgNlIFX6S7tWUUG6kaSfPMtpvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=jD3gmdwb; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=vEKXyExf; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=jD3gmdwb; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=vEKXyExf; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3CE9D5F7B5;
	Thu,  4 Apr 2024 14:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1712240351; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/03H7hOh0GUJswqYaiMm+uzdwS+6pYD4p/9O8jdbNko=;
	b=jD3gmdwbELggl6VJ3Z4wYnTUJ3G+Ff2eQhKteJoX23MDfui/8MotZAtZ1fDKkIL+Xc10tv
	+T7Yv5/SglzV7hRUq3plTOdFIMecyHGcC3b1fprhch21IZbm/sb9D23anFKorPoEVAZbWy
	SOZxxELUpPopWkQKzP/b+lM+XgHV6ds=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1712240351;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/03H7hOh0GUJswqYaiMm+uzdwS+6pYD4p/9O8jdbNko=;
	b=vEKXyExf1n7SDazEjF5HjLvFcu+7UMzf/LnCLO+pCnauN8mYuGRunTrS9t7w1SR0rFel2G
	D100ouR1vjwjShAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1712240351; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/03H7hOh0GUJswqYaiMm+uzdwS+6pYD4p/9O8jdbNko=;
	b=jD3gmdwbELggl6VJ3Z4wYnTUJ3G+Ff2eQhKteJoX23MDfui/8MotZAtZ1fDKkIL+Xc10tv
	+T7Yv5/SglzV7hRUq3plTOdFIMecyHGcC3b1fprhch21IZbm/sb9D23anFKorPoEVAZbWy
	SOZxxELUpPopWkQKzP/b+lM+XgHV6ds=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1712240351;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/03H7hOh0GUJswqYaiMm+uzdwS+6pYD4p/9O8jdbNko=;
	b=vEKXyExf1n7SDazEjF5HjLvFcu+7UMzf/LnCLO+pCnauN8mYuGRunTrS9t7w1SR0rFel2G
	D100ouR1vjwjShAQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 336E513298;
	Thu,  4 Apr 2024 14:19:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id k2CKDN+2DmYLBgAAn2gu4w
	(envelope-from <jack@suse.cz>); Thu, 04 Apr 2024 14:19:11 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id DC60EA0816; Thu,  4 Apr 2024 16:19:02 +0200 (CEST)
Date: Thu, 4 Apr 2024 16:19:02 +0200
From: Jan Kara <jack@suse.cz>
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org, jack@suse.cz, ojaswin@linux.ibm.com,
	ritesh.list@gmail.com
Subject: Re: [PATCH 4/5] ext4: use correct criteria name instead stale
 integer number in comment
Message-ID: <20240404141902.t5ut465q7vxusoa6@quack3>
References: <20240326213823.528302-1-shikemeng@huaweicloud.com>
 <20240326213823.528302-5-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326213823.528302-5-shikemeng@huaweicloud.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[mit.edu,dilger.ca,vger.kernel.org,suse.cz,linux.ibm.com,gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap2.dmz-prg2.suse.org:helo,imap2.dmz-prg2.suse.org:rdns,suse.com:email]
X-Spam-Score: -2.30
X-Spam-Flag: NO

On Wed 27-03-24 05:38:22, Kemeng Shi wrote:
> Use correct criteria name instead stale integer number in comment
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>

Looks good. But since the symbolic names already have CR prefix, we
probably don't have to write e.g.:

/* Large fragment size list lookup succeeded at least once for cr =
 * CR_POWER2_ALIGNED */

But we can write directly:

/* Large fragment size list lookup succeeded at least once for
 * CR_POWER2_ALIGNED */

								Honza

> ---
>  fs/ext4/ext4.h    | 15 ++++++++++++---
>  fs/ext4/mballoc.c | 14 ++++++++------
>  fs/ext4/mballoc.h |  4 ++--
>  3 files changed, 22 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 023571f8dd1b..9b90013c59a3 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -213,11 +213,20 @@ enum criteria {
>  #define EXT4_MB_USE_RESERVED		0x2000
>  /* Do strict check for free blocks while retrying block allocation */
>  #define EXT4_MB_STRICT_CHECK		0x4000
> -/* Large fragment size list lookup succeeded at least once for cr = 0 */
> +/*
> + * Large fragment size list lookup succeeded at least once for cr =
> + * CR_POWER2_ALIGNED
> + */
>  #define EXT4_MB_CR_POWER2_ALIGNED_OPTIMIZED		0x8000
> -/* Avg fragment size rb tree lookup succeeded at least once for cr = 1 */
> +/*
> + * Avg fragment size rb tree lookup succeeded at least once for cr =
> + * CR_GOAL_LEN_FAST
> + */
>  #define EXT4_MB_CR_GOAL_LEN_FAST_OPTIMIZED		0x00010000
> -/* Avg fragment size rb tree lookup succeeded at least once for cr = 1.5 */
> +/*
> + * Avg fragment size rb tree lookup succeeded at least once for cr =
> + * CR_BEST_AVAIL_LEN
> + */
>  #define EXT4_MB_CR_BEST_AVAIL_LEN_OPTIMIZED		0x00020000
>  
>  struct ext4_allocation_request {
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 62d468379722..0f8a34513bf6 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -1131,8 +1131,9 @@ static void ext4_mb_choose_next_group(struct ext4_allocation_context *ac,
>  		ext4_mb_choose_next_group_best_avail(ac, new_cr, group);
>  	} else {
>  		/*
> -		 * TODO: For CR=2, we can arrange groups in an rb tree sorted by
> -		 * bb_free. But until that happens, we should never come here.
> +		 * TODO: For CR=CR_GOAL_LEN_SLOW, we can arrange groups in an
> +		 * rb tree sorted by bb_free. But until that happens, we should
> +		 * never come here.
>  		 */
>  		WARN_ON(1);
>  	}
> @@ -3444,10 +3445,11 @@ static int ext4_mb_init_backend(struct super_block *sb)
>  	}
>  	if (sbi->s_mb_prefetch > ext4_get_groups_count(sb))
>  		sbi->s_mb_prefetch = ext4_get_groups_count(sb);
> -	/* now many real IOs to prefetch within a single allocation at cr=0
> -	 * given cr=0 is an CPU-related optimization we shouldn't try to
> -	 * load too many groups, at some point we should start to use what
> -	 * we've got in memory.
> +	/*
> +	 * now many real IOs to prefetch within a single allocation at
> +	 * cr=CR_POWER2_ALIGNED. Given cr=CR_POWER2_ALIGNED is an CPU-related
> +	 * optimization we shouldn't try to load too many groups, at some point
> +	 * we should start to use what we've got in memory.
>  	 * with an average random access time 5ms, it'd take a second to get
>  	 * 200 groups (* N with flex_bg), so let's make this limit 4
>  	 */
> diff --git a/fs/ext4/mballoc.h b/fs/ext4/mballoc.h
> index 56938532b4ce..042437d8860f 100644
> --- a/fs/ext4/mballoc.h
> +++ b/fs/ext4/mballoc.h
> @@ -187,8 +187,8 @@ struct ext4_allocation_context {
>  	struct ext4_free_extent ac_f_ex;
>  
>  	/*
> -	 * goal len can change in CR1.5, so save the original len. This is
> -	 * used while adjusting the PA window and for accounting.
> +	 * goal len can change in CR_BEST_AVAIL_LEN, so save the original len.
> +	 * This is used while adjusting the PA window and for accounting.
>  	 */
>  	ext4_grpblk_t	ac_orig_goal_len;
>  
> -- 
> 2.30.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

