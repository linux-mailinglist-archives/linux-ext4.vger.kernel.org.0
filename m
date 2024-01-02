Return-Path: <linux-ext4+bounces-626-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 378A1821C35
	for <lists+linux-ext4@lfdr.de>; Tue,  2 Jan 2024 14:07:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4940C1C21FE8
	for <lists+linux-ext4@lfdr.de>; Tue,  2 Jan 2024 13:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A908F9D2;
	Tue,  2 Jan 2024 13:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Z6wpNsQ2";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="r2RZobTY";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Z6wpNsQ2";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="r2RZobTY"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BEB0F9C4;
	Tue,  2 Jan 2024 13:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B082F1FCF9;
	Tue,  2 Jan 2024 13:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704200816; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N1HK5st0fjaPdug9MxLaEr7IcyAcjUJdi+MRE5GHHGs=;
	b=Z6wpNsQ2HKtELcdmv+yjRWtIvj3Ifwl+6HM1EUbOv+kh86MCgfAZ9LmpE+GpJBKdi0yoc8
	HBADIoRmDXl4eb1NMqfJRu2eBzCojJTplxCoZYa4u2TrjOxgQ8yYmaLuLMuBdN1PDcSXrY
	luDW+mANvmJGaL8ctxbCREyqnLWe4fE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704200816;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N1HK5st0fjaPdug9MxLaEr7IcyAcjUJdi+MRE5GHHGs=;
	b=r2RZobTY6VJjm0gY36hXLiUeGIId6dHnVWXCxVYx9dg+E82A/VeRjkhp4HgJwyLpL/HfpH
	wxVxQEB/d1ah73BA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704200816; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N1HK5st0fjaPdug9MxLaEr7IcyAcjUJdi+MRE5GHHGs=;
	b=Z6wpNsQ2HKtELcdmv+yjRWtIvj3Ifwl+6HM1EUbOv+kh86MCgfAZ9LmpE+GpJBKdi0yoc8
	HBADIoRmDXl4eb1NMqfJRu2eBzCojJTplxCoZYa4u2TrjOxgQ8yYmaLuLMuBdN1PDcSXrY
	luDW+mANvmJGaL8ctxbCREyqnLWe4fE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704200816;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N1HK5st0fjaPdug9MxLaEr7IcyAcjUJdi+MRE5GHHGs=;
	b=r2RZobTY6VJjm0gY36hXLiUeGIId6dHnVWXCxVYx9dg+E82A/VeRjkhp4HgJwyLpL/HfpH
	wxVxQEB/d1ah73BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A555513AC6;
	Tue,  2 Jan 2024 13:06:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id okJdKHAKlGU3SgAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 02 Jan 2024 13:06:56 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 5B919A07EF; Tue,  2 Jan 2024 14:06:41 +0100 (CET)
Date: Tue, 2 Jan 2024 14:06:41 +0100
From: Jan Kara <jack@suse.cz>
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/8] ext4: remove unused return value of
 ext4_mb_release_group_pa
Message-ID: <20240102130641.5mzf24ydmov3itxi@quack3>
References: <20231125161143.3945726-1-shikemeng@huaweicloud.com>
 <20231125161143.3945726-8-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231125161143.3945726-8-shikemeng@huaweicloud.com>
X-Spam-Level: *
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Z6wpNsQ2;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=r2RZobTY
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.01 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[5];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,huaweicloud.com:email,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[40.57%]
X-Spam-Score: -1.01
X-Rspamd-Queue-Id: B082F1FCF9
X-Spam-Flag: NO

On Sun 26-11-23 00:11:42, Kemeng Shi wrote:
> Remove unused return value of ext4_mb_release_group_pa.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/mballoc.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 1ed6d1d5a..e6561a09d 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -5330,7 +5330,7 @@ ext4_mb_release_inode_pa(struct ext4_buddy *e4b, struct buffer_head *bitmap_bh,
>  	atomic_add(free, &sbi->s_mb_discarded);
>  }
>  
> -static noinline_for_stack int
> +static noinline_for_stack void
>  ext4_mb_release_group_pa(struct ext4_buddy *e4b,
>  				struct ext4_prealloc_space *pa)
>  {
> @@ -5344,13 +5344,11 @@ ext4_mb_release_group_pa(struct ext4_buddy *e4b,
>  	if (unlikely(group != e4b->bd_group && pa->pa_len != 0)) {
>  		ext4_warning(sb, "bad group: expected %u, group %u, pa_start %llu",
>  			     e4b->bd_group, group, pa->pa_pstart);
> -		return 0;
> +		return;
>  	}
>  	mb_free_blocks(pa->pa_inode, e4b, bit, pa->pa_len);
>  	atomic_add(pa->pa_len, &EXT4_SB(sb)->s_mb_discarded);
>  	trace_ext4_mballoc_discard(sb, NULL, group, bit, pa->pa_len);
> -
> -	return 0;
>  }
>  
>  /*
> -- 
> 2.30.0
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

