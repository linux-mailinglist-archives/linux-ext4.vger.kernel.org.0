Return-Path: <linux-ext4+bounces-622-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E94AF821C24
	for <lists+linux-ext4@lfdr.de>; Tue,  2 Jan 2024 14:02:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D90C281399
	for <lists+linux-ext4@lfdr.de>; Tue,  2 Jan 2024 13:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC51CFBEC;
	Tue,  2 Jan 2024 13:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="eRkWXwV6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="XAsNmO5m";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="eRkWXwV6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="XAsNmO5m"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF04EFBE2;
	Tue,  2 Jan 2024 13:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A4FB221D40;
	Tue,  2 Jan 2024 13:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704200560; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aS8vDxAY34LDQvIiF79KkpXKjKeYevZsWTMmJdrrseA=;
	b=eRkWXwV62lMhED5n/iHCCBf7Il+S3datzThu1CCjmHLGoaWYnM331VodBvBcScEHXRCM0a
	sMVDwcjq9lqBUieBKJlkiMhyTs07QGAHMBjJ5mzDpISHqthWjPNmMoqHyHwJA5b8+adNJi
	wMbbx6zm56sJLop6XllS6J6t39xvcr0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704200560;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aS8vDxAY34LDQvIiF79KkpXKjKeYevZsWTMmJdrrseA=;
	b=XAsNmO5mhoL8j+98fua1vmopzCwyvTwk2hwqUz4yDc81D8r8YGiVIXqGZnKMwpS30cTYDc
	zLqZcOIEz/uHSpBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704200560; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aS8vDxAY34LDQvIiF79KkpXKjKeYevZsWTMmJdrrseA=;
	b=eRkWXwV62lMhED5n/iHCCBf7Il+S3datzThu1CCjmHLGoaWYnM331VodBvBcScEHXRCM0a
	sMVDwcjq9lqBUieBKJlkiMhyTs07QGAHMBjJ5mzDpISHqthWjPNmMoqHyHwJA5b8+adNJi
	wMbbx6zm56sJLop6XllS6J6t39xvcr0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704200560;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aS8vDxAY34LDQvIiF79KkpXKjKeYevZsWTMmJdrrseA=;
	b=XAsNmO5mhoL8j+98fua1vmopzCwyvTwk2hwqUz4yDc81D8r8YGiVIXqGZnKMwpS30cTYDc
	zLqZcOIEz/uHSpBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 999FE1340C;
	Tue,  2 Jan 2024 13:02:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id PbZ9JXAJlGUeSQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 02 Jan 2024 13:02:40 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 57308A07EF; Tue,  2 Jan 2024 14:02:40 +0100 (CET)
Date: Tue, 2 Jan 2024 14:02:40 +0100
From: Jan Kara <jack@suse.cz>
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/8] ext4: remove unneeded return value of
 ext4_mb_release_context
Message-ID: <20240102130240.to4hnuuheo72nbt3@quack3>
References: <20231125161143.3945726-1-shikemeng@huaweicloud.com>
 <20231125161143.3945726-4-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231125161143.3945726-4-shikemeng@huaweicloud.com>
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -0.84
X-Spamd-Result: default: False [-0.84 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,huaweicloud.com:email,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.04)[58.43%]
X-Spam-Flag: NO

On Sun 26-11-23 00:11:38, Kemeng Shi wrote:
> Function ext4_mb_release_context always return 0 and the return value is
> never used. Just remove unneeded return value of ext4_mb_release_context.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/mballoc.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 765b62729..f79e87ad3 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -5939,7 +5939,7 @@ static void ext4_mb_add_n_trim(struct ext4_allocation_context *ac)
>  /*
>   * release all resource we used in allocation
>   */
> -static int ext4_mb_release_context(struct ext4_allocation_context *ac)
> +static void ext4_mb_release_context(struct ext4_allocation_context *ac)
>  {
>  	struct ext4_sb_info *sbi = EXT4_SB(ac->ac_sb);
>  	struct ext4_prealloc_space *pa = ac->ac_pa;
> @@ -5976,7 +5976,6 @@ static int ext4_mb_release_context(struct ext4_allocation_context *ac)
>  	if (ac->ac_flags & EXT4_MB_HINT_GROUP_ALLOC)
>  		mutex_unlock(&ac->ac_lg->lg_mutex);
>  	ext4_mb_collect_stats(ac);
> -	return 0;
>  }
>  
>  static int ext4_mb_discard_preallocations(struct super_block *sb, int needed)
> -- 
> 2.30.0
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

