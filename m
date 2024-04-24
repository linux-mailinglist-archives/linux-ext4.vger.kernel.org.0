Return-Path: <linux-ext4+bounces-2176-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A01988B1442
	for <lists+linux-ext4@lfdr.de>; Wed, 24 Apr 2024 22:13:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5846F289BA6
	for <lists+linux-ext4@lfdr.de>; Wed, 24 Apr 2024 20:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B106213CAB5;
	Wed, 24 Apr 2024 20:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="udIBxy+1";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="USm4Azm7";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="udIBxy+1";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="USm4Azm7"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7475A757FD;
	Wed, 24 Apr 2024 20:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713989628; cv=none; b=kkO7aFyvAsr3f1vZ/mi8FutHB3oLlAzFJ0so8whOevtLWl3tkTMIbMmD0ND/zA9F446pcpguARR37sH3BqUnLjFWJym1AaTYDK0Sxj7IvxZA7qS8rZTQSvY8tmWvBdjPplBagrK7iWlzpm6FSPaKVRMlO2yMcWrI7x9AOXT2Les=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713989628; c=relaxed/simple;
	bh=vfQgCAkdVJ4kJp97sE8VzRgXjqLGiNaURH678O/OQ+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WTNQIEoQqnb53JvlV6MTnw4pvFUMSvmh3PRAXBZt+337zRgbPTNmVVM+7AWIfcDpxyUO/afa7nH6JxtLVeZ+DiVSP2sIb3DiBt1teBMY9crpkszOoFjee7BI7obJfeul1FHcC45fT0ydDCJOh2A97rNAOqW6RLx31R4LU9fyLyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=udIBxy+1; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=USm4Azm7; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=udIBxy+1; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=USm4Azm7; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6B5721FD0B;
	Wed, 24 Apr 2024 20:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1713989624; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2qNR9+TornBy2AeGJvOUkUmY+RJytFmKXO5Q/dtA9Ks=;
	b=udIBxy+1hr8cq4kKcoDGRCjXwi5QSmuCZ5hC+daUwx2d+90psw4Nls5yCT+nNs1ufXktb9
	xtLSoQfY3/emuurp2eoEAEIa+ixLxtATt0whsZoCVuuUvNdUb10RZxwzuPT0qi50K/qb8n
	H0CEuxgi1TWVpnFsZyFUchGxuvz8yj8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1713989624;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2qNR9+TornBy2AeGJvOUkUmY+RJytFmKXO5Q/dtA9Ks=;
	b=USm4Azm76sJNHosI+H+YilznKhb0aGD4GoVw3MywlXO07q8qYbrmkBytCbfJXYltAVmq1S
	ykzmdro3KSW3giCw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=udIBxy+1;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=USm4Azm7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1713989624; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2qNR9+TornBy2AeGJvOUkUmY+RJytFmKXO5Q/dtA9Ks=;
	b=udIBxy+1hr8cq4kKcoDGRCjXwi5QSmuCZ5hC+daUwx2d+90psw4Nls5yCT+nNs1ufXktb9
	xtLSoQfY3/emuurp2eoEAEIa+ixLxtATt0whsZoCVuuUvNdUb10RZxwzuPT0qi50K/qb8n
	H0CEuxgi1TWVpnFsZyFUchGxuvz8yj8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1713989624;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2qNR9+TornBy2AeGJvOUkUmY+RJytFmKXO5Q/dtA9Ks=;
	b=USm4Azm76sJNHosI+H+YilznKhb0aGD4GoVw3MywlXO07q8qYbrmkBytCbfJXYltAVmq1S
	ykzmdro3KSW3giCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 61ECF13690;
	Wed, 24 Apr 2024 20:13:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5InhF/hnKWaMdAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 24 Apr 2024 20:13:44 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 2AD07A0861; Wed, 24 Apr 2024 22:13:40 +0200 (CEST)
Date: Wed, 24 Apr 2024 22:13:40 +0200
From: Jan Kara <jack@suse.cz>
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org, jack@suse.cz, ojaswin@linux.ibm.com,
	ritesh.list@gmail.com
Subject: Re: [PATCH v3 4/5] ext4: use correct criteria name instead stale
 integer number in comment
Message-ID: <20240424201340.36c6nvp57z4paoob@quack3>
References: <20240424061904.987525-1-shikemeng@huaweicloud.com>
 <20240424061904.987525-5-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240424061904.987525-5-shikemeng@huaweicloud.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[mit.edu,dilger.ca,vger.kernel.org,suse.cz,linux.ibm.com,gmail.com];
	RCPT_COUNT_SEVEN(0.00)[8];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 6B5721FD0B
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -2.51

On Wed 24-04-24 14:19:03, Kemeng Shi wrote:
> Use correct criteria name instead stale integer number in comment
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/ext4.h    |  9 ++++++---
>  fs/ext4/mballoc.c | 16 +++++++++-------
>  fs/ext4/mballoc.h |  4 ++--
>  3 files changed, 17 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 023571f8dd1b..9bd3764d1121 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -213,11 +213,14 @@ enum criteria {
>  #define EXT4_MB_USE_RESERVED		0x2000
>  /* Do strict check for free blocks while retrying block allocation */
>  #define EXT4_MB_STRICT_CHECK		0x4000
> -/* Large fragment size list lookup succeeded at least once for cr = 0 */
> +/* Large fragment size list lookup succeeded at least once for
> + * CR_POWER2_ALIGNED */
>  #define EXT4_MB_CR_POWER2_ALIGNED_OPTIMIZED		0x8000
> -/* Avg fragment size rb tree lookup succeeded at least once for cr = 1 */
> +/* Avg fragment size rb tree lookup succeeded at least once for
> + * CR_GOAL_LEN_FAST */
>  #define EXT4_MB_CR_GOAL_LEN_FAST_OPTIMIZED		0x00010000
> -/* Avg fragment size rb tree lookup succeeded at least once for cr = 1.5 */
> +/* Avg fragment size rb tree lookup succeeded at least once for
> + * CR_BEST_AVAIL_LEN */
>  #define EXT4_MB_CR_BEST_AVAIL_LEN_OPTIMIZED		0x00020000
>  
>  struct ext4_allocation_request {
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 5acf413808a2..3d344a21b7f0 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -1131,8 +1131,9 @@ static void ext4_mb_choose_next_group(struct ext4_allocation_context *ac,
>  		ext4_mb_choose_next_group_best_avail(ac, new_cr, group);
>  	} else {
>  		/*
> -		 * TODO: For CR=2, we can arrange groups in an rb tree sorted by
> -		 * bb_free. But until that happens, we should never come here.
> +		 * TODO: For CR_GOAL_LEN_SLOW, we can arrange groups in an
> +		 * rb tree sorted by bb_free. But until that happens, we should
> +		 * never come here.
>  		 */
>  		WARN_ON(1);
>  	}
> @@ -2679,7 +2680,7 @@ static int ext4_mb_good_group_nolock(struct ext4_allocation_context *ac,
>  		int ret;
>  
>  		/*
> -		 * cr=CR_POWER2_ALIGNED/CR_GOAL_LEN_FAST is a very optimistic
> +		 * CR_POWER2_ALIGNED/CR_GOAL_LEN_FAST is a very optimistic
>  		 * search to find large good chunks almost for free. If buddy
>  		 * data is not ready, then this optimization makes no sense. But
>  		 * we never skip the first block group in a flex_bg, since this
> @@ -3445,10 +3446,11 @@ static int ext4_mb_init_backend(struct super_block *sb)
>  	}
>  	if (sbi->s_mb_prefetch > ext4_get_groups_count(sb))
>  		sbi->s_mb_prefetch = ext4_get_groups_count(sb);
> -	/* now many real IOs to prefetch within a single allocation at cr=0
> -	 * given cr=0 is an CPU-related optimization we shouldn't try to
> -	 * load too many groups, at some point we should start to use what
> -	 * we've got in memory.
> +	/*
> +	 * now many real IOs to prefetch within a single allocation at
> +	 * CR_POWER2_ALIGNED. Given CR_POWER2_ALIGNED is an CPU-related
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

