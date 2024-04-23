Return-Path: <linux-ext4+bounces-2162-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9A528AFA23
	for <lists+linux-ext4@lfdr.de>; Tue, 23 Apr 2024 23:46:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B7261F2902D
	for <lists+linux-ext4@lfdr.de>; Tue, 23 Apr 2024 21:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43DEE143C6C;
	Tue, 23 Apr 2024 21:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bfjyqmdt";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rc+C+8xr";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bfjyqmdt";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rc+C+8xr"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0506E148850;
	Tue, 23 Apr 2024 21:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713908640; cv=none; b=SUy/1xI3YyRXA6RW/hLAhKy4a8aBRCGjTunRspENOm08pPvJNNm1pGXQxhjHVRDEubIlFJoyjPI62rB3sJB2VAy7AhM/9QSNeOM7ZiADuUcw3NIS3x/yNMZ1s0VG9BMCAtIQPuxISWwJ5P2ncDMUkHdz7xhJ6F982/20ZDzeC8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713908640; c=relaxed/simple;
	bh=ecOe/OzguW1PvCBYxp6vLdDqIxUHefvPJoGSRBkzwo8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xl/f5N4FxUtF5pjkUq0UzScnZfCcfG1fmrDC8QxpkjabpvE9PMjdYu7MvOEoZ/o3q2blApw1eD1WXvKSf8Ko4ZDdEVK5W7B2VLtjIOH6zw+71SnDDr/z9QJ/3gqX5RDn+NEIQlMlSz9lPtPk2kR0ngpEGnkSGafaZMK1CLWXnUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=bfjyqmdt; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rc+C+8xr; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=bfjyqmdt; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rc+C+8xr; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 10D853877E;
	Tue, 23 Apr 2024 21:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1713908637; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uMpaUDb7FMjHQOS99Uhw1BMiERfdDNdNMDsWOmWv3Lw=;
	b=bfjyqmdtJVHu7qZ1D/wL0GNOUd+Fk+lmcKoK1LRmjCm2N0VdNF6PE/iUBkQmJTzh1j17GC
	LKZiwB9u39PULkgcv7Swh4krfackJXmhMlJEmv/BPj7jX5T4fOZ9ytA9YFM2QYPtaJahRG
	arKFYDtlUXuuD8Mk4uzL3YO2XasmAbw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1713908637;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uMpaUDb7FMjHQOS99Uhw1BMiERfdDNdNMDsWOmWv3Lw=;
	b=rc+C+8xrdjAtWOpaFGijPrl9aTwfZGiDrgWfprgstheGp5c3fKJrpRcFGCed7+8pA5q8Oq
	OgZRu09p6iYQ7iAw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=bfjyqmdt;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=rc+C+8xr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1713908637; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uMpaUDb7FMjHQOS99Uhw1BMiERfdDNdNMDsWOmWv3Lw=;
	b=bfjyqmdtJVHu7qZ1D/wL0GNOUd+Fk+lmcKoK1LRmjCm2N0VdNF6PE/iUBkQmJTzh1j17GC
	LKZiwB9u39PULkgcv7Swh4krfackJXmhMlJEmv/BPj7jX5T4fOZ9ytA9YFM2QYPtaJahRG
	arKFYDtlUXuuD8Mk4uzL3YO2XasmAbw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1713908637;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uMpaUDb7FMjHQOS99Uhw1BMiERfdDNdNMDsWOmWv3Lw=;
	b=rc+C+8xrdjAtWOpaFGijPrl9aTwfZGiDrgWfprgstheGp5c3fKJrpRcFGCed7+8pA5q8Oq
	OgZRu09p6iYQ7iAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 02F7313929;
	Tue, 23 Apr 2024 21:43:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Lby0AJ0rKGYBeAAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 23 Apr 2024 21:43:57 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 9F021A082F; Tue, 23 Apr 2024 23:43:52 +0200 (CEST)
Date: Tue, 23 Apr 2024 23:43:52 +0200
From: Jan Kara <jack@suse.cz>
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org, jack@suse.cz, ojaswin@linux.ibm.com,
	ritesh.list@gmail.com
Subject: Re: [PATCH v2 4/5] ext4: use correct criteria name instead stale
 integer number in comment
Message-ID: <20240423214352.t7yelmtvfbu7oggi@quack3>
References: <20240423124046.974134-1-shikemeng@huaweicloud.com>
 <20240423124046.974134-5-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240423124046.974134-5-shikemeng@huaweicloud.com>
X-Spam-Flag: NO
X-Spam-Score: -2.51
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 10D853877E
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
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
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[mit.edu,dilger.ca,vger.kernel.org,suse.cz,linux.ibm.com,gmail.com];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.com:email]

On Tue 23-04-24 20:40:45, Kemeng Shi wrote:
> Use correct criteria name instead stale integer number in comment
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

You have cleaned up the superfluous "CR=" bits in several places but still
left them is couple more :). See below:

> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 5acf413808a2..71b2f9a18875 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -1131,8 +1131,9 @@ static void ext4_mb_choose_next_group(struct ext4_allocation_context *ac,
>  		ext4_mb_choose_next_group_best_avail(ac, new_cr, group);
>  	} else {
>  		/*
> -		 * TODO: For CR=2, we can arrange groups in an rb tree sorted by
> -		 * bb_free. But until that happens, we should never come here.
> +		 * TODO: For CR=CR_GOAL_LEN_SLOW, we can arrange groups in an
			     ^^^ Still you have left these superfluous
"CR=" bits here.
 
> +		 * rb tree sorted by bb_free. But until that happens, we should
> +		 * never come here.
>  		 */
>  		WARN_ON(1);
>  	}
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
> +	 * cr=CR_POWER2_ALIGNED. Given cr=CR_POWER2_ALIGNED is an CPU-related
           ^^^  and here               ^^^

> +	 * optimization we shouldn't try to load too many groups, at some point
> +	 * we should start to use what we've got in memory.
>  	 * with an average random access time 5ms, it'd take a second to get
>  	 * 200 groups (* N with flex_bg), so let's make this limit 4
>  	 */

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

