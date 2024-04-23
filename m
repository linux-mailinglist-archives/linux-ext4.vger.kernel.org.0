Return-Path: <linux-ext4+bounces-2163-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 361F18AFB18
	for <lists+linux-ext4@lfdr.de>; Tue, 23 Apr 2024 23:53:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7F561F26F12
	for <lists+linux-ext4@lfdr.de>; Tue, 23 Apr 2024 21:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F1EF14C5BF;
	Tue, 23 Apr 2024 21:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GzYhFQah";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="lJrO8EOB";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GzYhFQah";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="lJrO8EOB"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80361145B38;
	Tue, 23 Apr 2024 21:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713908815; cv=none; b=kIis+6Qi+u0uKPyzBrjQjqGEZ4dXDtRY7u+jvyYxgpwXSZwlXL8XSqvKkds9LkOG7Dc3fa+L6456CrYYzuvldDKMCvL7V30Q4kphSvxaigH7AEXkkmKNs1jFmLPEEIFILHtV905MFh+qGtk6w/B7ZFkYUvHqTtN8lD1UtFiJYmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713908815; c=relaxed/simple;
	bh=kmuVjF8KAUkxt0gcupljV05k6/m4UbaCtGln84oipt8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H4O8fQewx1GQwXoRh8TSjTrAYTimo247Bacwml5/Jt7GaIdcQT9rbnwB5EbMJOj99QklfckUkGiP8rX+TXdlT8rZavkssUBT8CKF1if0KSVhpOAE54y0TgxZqQeu2Wqr1tc1WM2p2NVXb/G1ySSUTjEjJdPKWR3yd5EuEse+Jhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=GzYhFQah; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=lJrO8EOB; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=GzYhFQah; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=lJrO8EOB; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 846AB3878A;
	Tue, 23 Apr 2024 21:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1713908811; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1Owf3IHJ7IMkSjpRBlY3smfRwZEWBGDK534+fPxEpJo=;
	b=GzYhFQahgc8kBEfOYUyJx4T2HJi2bOOf44++/EPwSif+QjEfFrYR191ntlMLTLnnAAimij
	yf94AUqYbVKcCq0gy9SIMotH/bX8oCbrhI/5rt4zrHvpMMgdJwBDhTutxmI6DawIoRrRQ9
	N1NekkBbj/VoT/BpmqAcpSHmuZIj9kE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1713908811;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1Owf3IHJ7IMkSjpRBlY3smfRwZEWBGDK534+fPxEpJo=;
	b=lJrO8EOBlwfF5im/ncKJeGUtQtTna+5srAVx+zZ5Vf+ljFsQetMXyChSojLE7jVvpfzXhY
	UyAKkLLcuf0PL6Cg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=GzYhFQah;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=lJrO8EOB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1713908811; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1Owf3IHJ7IMkSjpRBlY3smfRwZEWBGDK534+fPxEpJo=;
	b=GzYhFQahgc8kBEfOYUyJx4T2HJi2bOOf44++/EPwSif+QjEfFrYR191ntlMLTLnnAAimij
	yf94AUqYbVKcCq0gy9SIMotH/bX8oCbrhI/5rt4zrHvpMMgdJwBDhTutxmI6DawIoRrRQ9
	N1NekkBbj/VoT/BpmqAcpSHmuZIj9kE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1713908811;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1Owf3IHJ7IMkSjpRBlY3smfRwZEWBGDK534+fPxEpJo=;
	b=lJrO8EOBlwfF5im/ncKJeGUtQtTna+5srAVx+zZ5Vf+ljFsQetMXyChSojLE7jVvpfzXhY
	UyAKkLLcuf0PL6Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 75C9713929;
	Tue, 23 Apr 2024 21:46:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1Sl5HEssKGbHeAAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 23 Apr 2024 21:46:51 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 1D0A9A082F; Tue, 23 Apr 2024 23:46:51 +0200 (CEST)
Date: Tue, 23 Apr 2024 23:46:51 +0200
From: Jan Kara <jack@suse.cz>
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org, jack@suse.cz, ojaswin@linux.ibm.com,
	ritesh.list@gmail.com
Subject: Re: [PATCH v2 5/5] ext4: open coding repeated check in
 next_linear_group
Message-ID: <20240423214651.v7veh2x2pmkpxti4@quack3>
References: <20240423124046.974134-1-shikemeng@huaweicloud.com>
 <20240423124046.974134-6-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240423124046.974134-6-shikemeng@huaweicloud.com>
X-Spam-Flag: NO
X-Spam-Score: -2.40
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 846AB3878A
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.40 / 50.00];
	BAYES_HAM(-2.89)[99.53%];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.cz:dkim,suse.cz:email]

On Tue 23-04-24 20:40:46, Kemeng Shi wrote:
> Open coding repeated check in next_linear_group.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/mballoc.c | 31 +++++++++++++++----------------
>  1 file changed, 15 insertions(+), 16 deletions(-)
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 71b2f9a18875..4afe5bb94bf4 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -1076,23 +1076,11 @@ static inline int should_optimize_scan(struct ext4_allocation_context *ac)
>  }
>  
>  /*
> - * Return next linear group for allocation. If linear traversal should not be
> - * performed, this function just returns the same group
> + * Return next linear group for allocation.
>   */
>  static ext4_group_t
> -next_linear_group(struct ext4_allocation_context *ac, ext4_group_t group,
> -		  ext4_group_t ngroups)
> +next_linear_group(ext4_group_t group, ext4_group_t ngroups)
>  {
> -	if (!should_optimize_scan(ac))
> -		goto inc_and_return;
> -
> -	if (ac->ac_groups_linear_remaining) {
> -		ac->ac_groups_linear_remaining--;
> -		goto inc_and_return;
> -	}
> -
> -	return group;
> -inc_and_return:
>  	/*
>  	 * Artificially restricted ngroups for non-extent
>  	 * files makes group > ngroups possible on first loop.
> @@ -1118,8 +1106,19 @@ static void ext4_mb_choose_next_group(struct ext4_allocation_context *ac,
>  {
>  	*new_cr = ac->ac_criteria;
>  
> -	if (!should_optimize_scan(ac) || ac->ac_groups_linear_remaining) {
> -		*group = next_linear_group(ac, *group, ngroups);
> +	if (!should_optimize_scan(ac)) {
> +		*group = next_linear_group(*group, ngroups);
> +		return;
> +	}
> +
> +	/*
> +	 * Optimized scanning can return non adjacent groups which can cause
> +	 * seek overhead for rotational disks. So try few linear groups before
> +	 * trying optimized scan.
> +	 */
> +	if (ac->ac_groups_linear_remaining) {
> +		*group = next_linear_group(*group, ngroups);
> +		ac->ac_groups_linear_remaining--;
>  		return;
>  	}
>  
> -- 
> 2.30.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

