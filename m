Return-Path: <linux-ext4+bounces-675-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 296EC823FC9
	for <lists+linux-ext4@lfdr.de>; Thu,  4 Jan 2024 11:47:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2690E1C23E51
	for <lists+linux-ext4@lfdr.de>; Thu,  4 Jan 2024 10:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D417420DEA;
	Thu,  4 Jan 2024 10:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dbDtUjiK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="cpu22t34";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dbDtUjiK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="cpu22t34"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2406210EC;
	Thu,  4 Jan 2024 10:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 13EA61FCD8;
	Thu,  4 Jan 2024 10:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704365254; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0xDR6XwHytPud1CbM6v6PSB56naMx2aLdGVZIy/AXAE=;
	b=dbDtUjiKOkor6Y3Xfq4BCOUXIDTPuiKUNoLANs4QrHuWa3kXncpygSdaQTzERkZYJUIayp
	IouCbPh+T/wu5w2GJ+ULJW5+kotiw1qCmz4J0jmIp5g05blUsOJ4KenGJL1PZybw+/yrja
	EVEjqFpLGL4Xq9RFb+ANhQ8QCS/Qjhg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704365254;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0xDR6XwHytPud1CbM6v6PSB56naMx2aLdGVZIy/AXAE=;
	b=cpu22t34NOp7Xz0hFfc1RZVzbaX08YP3sjEGuE3c+Qm6NQXyjLsoxizFJQuVU76h2NdKHm
	UIUZxm6gyeiPJlAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704365254; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0xDR6XwHytPud1CbM6v6PSB56naMx2aLdGVZIy/AXAE=;
	b=dbDtUjiKOkor6Y3Xfq4BCOUXIDTPuiKUNoLANs4QrHuWa3kXncpygSdaQTzERkZYJUIayp
	IouCbPh+T/wu5w2GJ+ULJW5+kotiw1qCmz4J0jmIp5g05blUsOJ4KenGJL1PZybw+/yrja
	EVEjqFpLGL4Xq9RFb+ANhQ8QCS/Qjhg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704365254;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0xDR6XwHytPud1CbM6v6PSB56naMx2aLdGVZIy/AXAE=;
	b=cpu22t34NOp7Xz0hFfc1RZVzbaX08YP3sjEGuE3c+Qm6NQXyjLsoxizFJQuVU76h2NdKHm
	UIUZxm6gyeiPJlAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F1D7F13722;
	Thu,  4 Jan 2024 10:47:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id egsHO8WMlmXmdwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 04 Jan 2024 10:47:33 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id ADDE4A07EF; Thu,  4 Jan 2024 11:47:33 +0100 (CET)
Date: Thu, 4 Jan 2024 11:47:33 +0100
From: Jan Kara <jack@suse.cz>
To: Baokun Li <libaokun1@huawei.com>
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
	jack@suse.cz, ritesh.list@gmail.com, linux-kernel@vger.kernel.org,
	yi.zhang@huawei.com, yangerkun@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH v2 7/8] ext4: avoid allocating blocks from corrupted
 group in ext4_mb_find_by_goal()
Message-ID: <20240104104733.d6oyepneq7ky7ote@quack3>
References: <20231221150558.2740823-1-libaokun1@huawei.com>
 <20231221150558.2740823-8-libaokun1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231221150558.2740823-8-libaokun1@huawei.com>
X-Spam-Score: 1.61
X-Spamd-Result: default: False [1.61 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_HAM(-0.29)[74.55%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[10];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[vger.kernel.org,mit.edu,dilger.ca,suse.cz,gmail.com,huawei.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: *
X-Spam-Flag: NO

On Thu 21-12-23 23:05:57, Baokun Li wrote:
> Places the logic for checking if the group's block bitmap is corrupt under
> the protection of the group lock to avoid allocating blocks from the group
> with a corrupted block bitmap.
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/mballoc.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 2bb29f0077bd..b862ca2750fd 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -2340,12 +2340,10 @@ int ext4_mb_find_by_goal(struct ext4_allocation_context *ac,
>  	if (err)
>  		return err;
>  
> -	if (unlikely(EXT4_MB_GRP_BBITMAP_CORRUPT(e4b->bd_info))) {
> -		ext4_mb_unload_buddy(e4b);
> -		return 0;
> -	}
> -
>  	ext4_lock_group(ac->ac_sb, group);
> +	if (unlikely(EXT4_MB_GRP_BBITMAP_CORRUPT(e4b->bd_info)))
> +		goto out;
> +
>  	max = mb_find_extent(e4b, ac->ac_g_ex.fe_start,
>  			     ac->ac_g_ex.fe_len, &ex);
>  	ex.fe_logical = 0xDEADFA11; /* debug value */
> @@ -2378,6 +2376,7 @@ int ext4_mb_find_by_goal(struct ext4_allocation_context *ac,
>  		ac->ac_b_ex = ex;
>  		ext4_mb_use_best_found(ac, e4b);
>  	}
> +out:
>  	ext4_unlock_group(ac->ac_sb, group);
>  	ext4_mb_unload_buddy(e4b);
>  
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

