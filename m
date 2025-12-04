Return-Path: <linux-ext4+bounces-12153-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 077A0CA33B9
	for <lists+linux-ext4@lfdr.de>; Thu, 04 Dec 2025 11:31:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 02A03300452D
	for <lists+linux-ext4@lfdr.de>; Thu,  4 Dec 2025 10:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 084E92DECA1;
	Thu,  4 Dec 2025 10:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Y6EfkqoL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="tbzO//ar";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Y6EfkqoL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="tbzO//ar"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EAA62DE200
	for <linux-ext4@vger.kernel.org>; Thu,  4 Dec 2025 10:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764844292; cv=none; b=KVxahtcUS1km35E6quMVycxjXpy18n35LDb3nZ189WKHoFMTdI8CLE3JFV9by4xGlUFZBTXOUO3V6Zp85NTKU2vNjQCD3xnna6gIBUHp5HfQ+niLgNUdzjU0FFNqXKoTzDxb+tSMOrXsA1Vwomn1TWfJ43sRaEo7t0vDcIydFMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764844292; c=relaxed/simple;
	bh=mJcQOkwx01cZA2MtOGKXlSdx4kWVSvWOiXxqq3qdeck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gmdizN2T1yEG1Tei0FHfQKcEtK5MbLbpE/S6bluyhQRonqpslUOETcDPU1w/TdvazGaF3yXHWCSsoqWn0v3B+XRdZK1o5VYxwMqNUgW8RXiGGtnFJCBKf/2BWuhQHQpdV2Poduln1Dv3P0a+eeR2VbyIqSIUSe8eQ+EhpQUZnh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Y6EfkqoL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=tbzO//ar; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Y6EfkqoL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=tbzO//ar; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 201475BE91;
	Thu,  4 Dec 2025 10:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1764844289; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7y959UByP5GnQCtqyHvvALyBRK6rNWNRFyZypSIc8Tc=;
	b=Y6EfkqoLqatYe6a15pEL8DDeE8VNK/kFiiAt2I8RvZNTi4C9/OpisNARMEVI3R25wZqEF4
	4DojH7RZr2vU9kGYNhgGNaoixZQLGSIoX849bxrJlmT86M+Rwt9KXrxc4T8G649jfJ8hpa
	9HSVuf0ewF9e7LtsGPGllvVD64H3qz4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1764844289;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7y959UByP5GnQCtqyHvvALyBRK6rNWNRFyZypSIc8Tc=;
	b=tbzO//ar88CA84D60Xla0F/goAc6sAUpHeSPtyfNRJ5LN/6hxklKCKQ/h1IgAEC8ljHs8m
	d8oM14/25qd9cQAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1764844289; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7y959UByP5GnQCtqyHvvALyBRK6rNWNRFyZypSIc8Tc=;
	b=Y6EfkqoLqatYe6a15pEL8DDeE8VNK/kFiiAt2I8RvZNTi4C9/OpisNARMEVI3R25wZqEF4
	4DojH7RZr2vU9kGYNhgGNaoixZQLGSIoX849bxrJlmT86M+Rwt9KXrxc4T8G649jfJ8hpa
	9HSVuf0ewF9e7LtsGPGllvVD64H3qz4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1764844289;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7y959UByP5GnQCtqyHvvALyBRK6rNWNRFyZypSIc8Tc=;
	b=tbzO//ar88CA84D60Xla0F/goAc6sAUpHeSPtyfNRJ5LN/6hxklKCKQ/h1IgAEC8ljHs8m
	d8oM14/25qd9cQAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 144043EA63;
	Thu,  4 Dec 2025 10:31:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GpvtBAFjMWmrCAAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 04 Dec 2025 10:31:29 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id C11D6A09A3; Thu,  4 Dec 2025 11:31:24 +0100 (CET)
Date: Thu, 4 Dec 2025 11:31:24 +0100
From: Jan Kara <jack@suse.cz>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Theodore Ts'o <tytso@mit.edu>, 
	Andreas Dilger <adilger.kernel@dilger.ca>, Jan Kara <jack@suse.cz>, "Darrick J. Wong" <djwong@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: fix ext4_tune_sb_params padding
Message-ID: <3ueamfhbmtwmclmtm77msvsuylgxabt3zqkrtvxqtajqhupfdd@vy7bw3e3wiwn>
References: <20251204101914.1037148-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251204101914.1037148-1-arnd@kernel.org>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.992];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,arndb.de:email,suse.cz:email,suse.com:email]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -3.80

On Thu 04-12-25 11:19:10, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The padding at the end of struct ext4_tune_sb_params is architecture
> specific and in particular is different between x86-32 and x86-64,
> since the __u64 member only enforces struct alignment on the latter.
> 
> This shows up as a new warning when test-building the headers with
> -Wpadded:
> 
> include/linux/ext4.h:144:1: error: padding struct size to alignment boundary with 4 bytes [-Werror=padded]
> 
> All members inside the structure are naturally aligned, so the only
> difference here is the amount of padding at the end. Make the padding
> explicit, to have a consistent sizeof(struct ext4_tune_sb_params) of
> 232 on all architectures and avoid adding compat ioctl handling for
> EXT4_IOC_GET_TUNE_SB_PARAM/EXT4_IOC_SET_TUNE_SB_PARAM.
> 
> This is an ABI break on x86-32 but hopefully this can go into 6.18.y early
> enough as a fixup so no actual users will be affected.  Alternatively, the
> kernel could handle the ioctl commands for both sizes (232 and 228 bytes)
> on all architectures.
> 
> Fixes: 04a91570ac67 ("ext4: implemet new ioctls to set and get superblock parameters")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Indeed. I agree this is fairly new so we can just fix the structure. Feel
free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  include/uapi/linux/ext4.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/uapi/linux/ext4.h b/include/uapi/linux/ext4.h
> index 411dcc1e4a35..9c683991c32f 100644
> --- a/include/uapi/linux/ext4.h
> +++ b/include/uapi/linux/ext4.h
> @@ -139,7 +139,7 @@ struct ext4_tune_sb_params {
>  	__u32 clear_feature_incompat_mask;
>  	__u32 clear_feature_ro_compat_mask;
>  	__u8  mount_opts[64];
> -	__u8  pad[64];
> +	__u8  pad[68];
>  };
>  
>  #define EXT4_TUNE_FL_ERRORS_BEHAVIOR	0x00000001
> -- 
> 2.39.5
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

