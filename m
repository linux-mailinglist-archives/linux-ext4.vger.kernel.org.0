Return-Path: <linux-ext4+bounces-11361-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F1C5C1FD5C
	for <lists+linux-ext4@lfdr.de>; Thu, 30 Oct 2025 12:33:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B97564EB2F8
	for <lists+linux-ext4@lfdr.de>; Thu, 30 Oct 2025 11:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04FE22E2667;
	Thu, 30 Oct 2025 11:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="iQjV4Qkw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="APYEF91G";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MOvoqIVB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wArq54LY"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A982E093C
	for <linux-ext4@vger.kernel.org>; Thu, 30 Oct 2025 11:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761823928; cv=none; b=lhxdKI6MUWoS1Koqe5BQkXtLLKmg/6jcg8a6361krhUjBEg+NQj5co54GZqeACb6/iJUkCfR9fQqBUXvNYw6dIqa79t0SZhQrNyesing145+aCu+EqhZgJRmn8zNj65cs/XHIg+xvpgFKjfLlrilxWQMamtqepjeNLWPpi9NT/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761823928; c=relaxed/simple;
	bh=OZ3Yq4YdDmWhDi/hUxHScmEubonH1DIfS5EheJ/DK3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TnlrsWrj1P7c+WhGpRWqMJhIHOZ2gwFce2tCpFtovDAX96zU5iIKN6RW/3XIbbzwQWI2KQZl+batCCM8tW4qr/UOkGy+PVc1GE5mt72/Nr6yWm/RxNSh4BljjrFnH2lOJD9tTOuotX1jxtpwBwcPNpTXBMJjimRxzh8piibDHiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=iQjV4Qkw; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=APYEF91G; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=MOvoqIVB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=wArq54LY; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C263D3370D;
	Thu, 30 Oct 2025 11:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761823924; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ntw06CVPtYKA20BePGYDvcSPKowAchzswyZRcPGcQqs=;
	b=iQjV4QkwkctgtDR0/g883064ybVchiq/QmGKncpucj8wgHtn2qpN8Rq9SPdUdQv+hWoFhX
	Tmo+bPJbU3FCIm/dUeTNJdyNQ2eURN2IMLr9KPCuHCyg02zyse1qn4uO4/yoz4FRhVUC1o
	Uoq/2oPXgyvdLXt9Qn7vjpqszi7oe/M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761823924;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ntw06CVPtYKA20BePGYDvcSPKowAchzswyZRcPGcQqs=;
	b=APYEF91GxFI+yR6Mip4jKTTT7Dmr6yyjkMVDhWfeqRX91yTP4UHMu8kmswBb9qWiRdqnpx
	bFchAEGXRbVz4sDw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=MOvoqIVB;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=wArq54LY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761823922; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ntw06CVPtYKA20BePGYDvcSPKowAchzswyZRcPGcQqs=;
	b=MOvoqIVBUlXjCsKDPCoKy1sAGtX5virqZ5SXbUwaG2l96SDllOR/UAjOWSQll7fp+xWppD
	6UEDwkD4rczojsJdVBtryz2kNUm7bWAOCKvvHvN9/nHciOCbza5rUV3rJjqiRfOromIYY3
	RwgC06sp5Ok2T+zNWJ2txge5wgYkN7c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761823922;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ntw06CVPtYKA20BePGYDvcSPKowAchzswyZRcPGcQqs=;
	b=wArq54LYoiQ4MYXRHLzZurpiYk5/OJPzr8ipIn+tuDskxBlxdAUkPzHi7lGhjFUdJdmjQF
	xkoBYKZu/PbnDVAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B32E81396A;
	Thu, 30 Oct 2025 11:32:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fyy6K7JMA2mebgAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 30 Oct 2025 11:32:02 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id ED0F8A0AD6; Thu, 30 Oct 2025 12:32:01 +0100 (CET)
Date: Thu, 30 Oct 2025 12:32:01 +0100
From: Jan Kara <jack@suse.cz>
To: Fedor Pchelkin <pchelkin@ispras.ru>
Cc: Theodore Ts'o <tytso@mit.edu>, 
	Andreas Dilger <adilger.kernel@dilger.ca>, Jan Kara <jack@suse.cz>, "Darrick J. Wong" <djwong@kernel.org>, 
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>, 
	lvc-project@linuxtesting.org
Subject: Re: [PATCH 1/2] ext4: fix up copying of mount_opts in superblock
 tuning ioctls
Message-ID: <yq6rbx54jt4btntsh37urd6u63wwcd3lyhovbrm6w7occaveea@riljfkx5jmhi>
References: <20251028130949.599847-1-pchelkin@ispras.ru>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251028130949.599847-1-pchelkin@ispras.ru>
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: C263D3370D
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,ispras.ru:email,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Score: -4.01

On Tue 28-10-25 16:09:47, Fedor Pchelkin wrote:
> Judging by commit 8ecb790ea8c3 ("ext4: avoid potential buffer over-read in
> parse_apply_sb_mount_options()"), the contents of s_mount_opts should be
> treated as __nonstring, i.e. there might be no NUL-terminator in the
> provided buffer.
> 
> Then the same holds for the corresponding mount_opts field of the struct
> ext4_tune_sb_params exchanged with userspace via a recently implemented
> superblock tuning ioctl.
> 
> The problem is that strscpy_pad() can't work properly with non-NUL-term
> strings.  String fortifying infrastructure would complain if that happens.
> Commit 0efc5990bca5 ("string.h: Introduce memtostr() and memtostr_pad()")
> gives additional information in that regard.
> 
> Both buffers are just raw arrays of the similar fixed size, essentially
> they should represent the same contents.  As they don't necessarily have
> NUL-terminators, in both directions use plain memcpy() to copy their
> contents.
> 
> Found by Linux Verification Center (linuxtesting.org).
> 
> Fixes: 04a91570ac67 ("ext4: implemet new ioctls to set and get superblock parameters")
> Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>

I agree there are some holes in the logic of 8ecb790ea8c3 ("ext4: avoid
potential buffer over-read in parse_apply_sb_mount_options()") and
consequently 04a91570ac67 may need fixing up as well. But I think the fixes
should look differently. The clear intended use of s_mount_opts field is
that it is at most 63 characters long with the last byte guaranteed to be
0. This is how userspace utilities use it and they complain if you try
setting more than 63 characters long string. So I think strscpy_pad() use
in ext4_ioctl_get_tune_sb() is actually fine (sizes of both buffers match).
In ext4_sb_setparams() we should actually make sure userspace buffer is
properly Nul-terminated and return error otherwise. And the buffer in
parse_apply_sb_mount_options() should actually be only 64 bytes long to
match the size of the source buffer at which point using strscpy_pad()
becomes correct. How does that sound?

								Honza

> ---
> 
> The 1/2 patch of the current series fixes an issue existing only in 6.18-rc
> while 2/2 fixes the commit which was in turn backported to stable kernels.
> That's the reasoning for separation.
> 
>  fs/ext4/ioctl.c           | 4 ++--
>  include/uapi/linux/ext4.h | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
> index a93a7baae990..c39b87d52cb0 100644
> --- a/fs/ext4/ioctl.c
> +++ b/fs/ext4/ioctl.c
> @@ -1292,7 +1292,7 @@ static int ext4_ioctl_get_tune_sb(struct ext4_sb_info *sbi,
>  	ret.raid_stripe_width = le32_to_cpu(es->s_raid_stripe_width);
>  	ret.encoding = le16_to_cpu(es->s_encoding);
>  	ret.encoding_flags = le16_to_cpu(es->s_encoding_flags);
> -	strscpy_pad(ret.mount_opts, es->s_mount_opts);
> +	memcpy(ret.mount_opts, es->s_mount_opts, sizeof(ret.mount_opts));
>  	ret.feature_compat = le32_to_cpu(es->s_feature_compat);
>  	ret.feature_incompat = le32_to_cpu(es->s_feature_incompat);
>  	ret.feature_ro_compat = le32_to_cpu(es->s_feature_ro_compat);
> @@ -1353,7 +1353,7 @@ static void ext4_sb_setparams(struct ext4_sb_info *sbi,
>  		es->s_encoding = cpu_to_le16(params->encoding);
>  	if (params->set_flags & EXT4_TUNE_FL_ENCODING_FLAGS)
>  		es->s_encoding_flags = cpu_to_le16(params->encoding_flags);
> -	strscpy_pad(es->s_mount_opts, params->mount_opts);
> +	memcpy(es->s_mount_opts, params->mount_opts, sizeof(es->s_mount_opts));
>  	if (params->set_flags & EXT4_TUNE_FL_EDIT_FEATURES) {
>  		es->s_feature_compat |=
>  			cpu_to_le32(params->set_feature_compat_mask);
> diff --git a/include/uapi/linux/ext4.h b/include/uapi/linux/ext4.h
> index 411dcc1e4a35..8ed9acbd0e03 100644
> --- a/include/uapi/linux/ext4.h
> +++ b/include/uapi/linux/ext4.h
> @@ -138,7 +138,7 @@ struct ext4_tune_sb_params {
>  	__u32 clear_feature_compat_mask;
>  	__u32 clear_feature_incompat_mask;
>  	__u32 clear_feature_ro_compat_mask;
> -	__u8  mount_opts[64];
> +	__u8  mount_opts[64] __nonstring;
>  	__u8  pad[64];
>  };
>  
> -- 
> 2.51.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

