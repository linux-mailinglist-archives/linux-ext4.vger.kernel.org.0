Return-Path: <linux-ext4+bounces-10233-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB9A1B80F0C
	for <lists+linux-ext4@lfdr.de>; Wed, 17 Sep 2025 18:20:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA7ED5446F4
	for <lists+linux-ext4@lfdr.de>; Wed, 17 Sep 2025 16:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE26234BA59;
	Wed, 17 Sep 2025 16:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="aasZvccv";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="8HcnzO2j";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Bp5DW7yS";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4Z/4/W/y"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC6734BA4A
	for <linux-ext4@vger.kernel.org>; Wed, 17 Sep 2025 16:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758125110; cv=none; b=cL4zh4AkOoJgRwCa8LoqzE25as/rva7zxT237AUeWTus0H76+J6t4G53pK2mlXA/EaOSaTHyyUVC2Qwwu8jM1dFwZBFr7f+tYKtZqM7M1n6eKrGRyBKftW5Vm3g2A09EVZIeG95tMOyP3z0azjRSLTvf+Wy7+4A+86J67lF7qGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758125110; c=relaxed/simple;
	bh=cjKoV1Ml2mdg973m1JTZsn9Z7R153MdyGnB9Arxg8O4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k19UY0mAoWtRO0nQ8JpzgFcG6r647tQRBUqhUubyBReJM8lpgw0pKusHqyz8U+1qCb+Asi4oa08KT7zkR0EaIg/srBQWHjnMu1uU0gpWhfbBDi8UySfNzbGzor6Jwj/DYvsXKZ/GjtbsbcRZmmblvhxWrrIuI9s0OCQFU+7A9ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=aasZvccv; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=8HcnzO2j; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Bp5DW7yS; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4Z/4/W/y; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DE67B33BAE;
	Wed, 17 Sep 2025 16:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758125107; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C2R25L5oz2gyvUsf4Zn8S0eWF+OxAm+fOvyZd8KgMG4=;
	b=aasZvccvU8K7aEDNw5B4/B2hoCjFHLcjGdG9lt2hUEjTmW1aasSizcN6fzEn/PYwC2y707
	MzXtf1hZ8mVMVB6nYIzGIpkumHjKMzy7qDPVhE/0bK1mDGY7z1yNzE9qeNqtXkwHx8i5fk
	u0WGKzDkU0sgDg/ZeaoPP5ymbiT+Uz4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758125107;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C2R25L5oz2gyvUsf4Zn8S0eWF+OxAm+fOvyZd8KgMG4=;
	b=8HcnzO2jRt+t3R8C9K3ZH95WM3ocZFfQU6pqLRzm3Trh3vA/0E6sQkeUXJHdravHRxit/x
	5GFgMMWDYqTJ7rAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758125106; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C2R25L5oz2gyvUsf4Zn8S0eWF+OxAm+fOvyZd8KgMG4=;
	b=Bp5DW7ySIzRxPqZkRClHtj5mgfTpbYah6iewEiJLzhydcxZfzNupFyJ9Yr1jDhYzkm3Nq+
	YDW6zSQiyg9D3Yegbp9V8hOHqW6a7xL5bXeP7Jq/nPm6AMvq0cYUVO7fMf2nelxWEd0QQw
	XXqt5mxXxmNtHraqoG/g/tPThtObVcA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758125106;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C2R25L5oz2gyvUsf4Zn8S0eWF+OxAm+fOvyZd8KgMG4=;
	b=4Z/4/W/yKRBzPq2DJuG1y+LGwowctDZ9K4/8Vcf2+ihr6EtDQrYKXtf2tgFX1pFEbDsQFJ
	a0IlA7OOze76+pAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D0838137C3;
	Wed, 17 Sep 2025 16:05:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hzCGMjLcymiLKgAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 17 Sep 2025 16:05:06 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 89C24A083B; Wed, 17 Sep 2025 18:05:06 +0200 (CEST)
Date: Wed, 17 Sep 2025 18:05:06 +0200
From: Jan Kara <jack@suse.cz>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org, linux-api@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH v2 1/3] ext4: avoid potential buffer over-read in
 parse_apply_sb_mount_options()
Message-ID: <ik565ztp7s7zyhiog6n52zxylybtkkael6opfrmtvtf6su34iw@zho5dlhfvibq>
References: <20250916-tune2fs-v2-0-d594dc7486f0@mit.edu>
 <20250916-tune2fs-v2-1-d594dc7486f0@mit.edu>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916-tune2fs-v2-1-d594dc7486f0@mit.edu>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -3.80

On Tue 16-09-25 23:22:47, Theodore Ts'o via B4 Relay wrote:
> From: Theodore Ts'o <tytso@mit.edu>
> 
> Unlike other strings in the ext4 superblock, we rely on tune2fs to
> make sure s_mount_opts is NUL terminated.  Harden
> parse_apply_sb_mount_options() by treating s_mount_opts as a potential
> __nonstring.
> 
> Cc: stable@vger.kernel.org
> Fixes: 8b67f04ab9de ("ext4: Add mount options in superblock")
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/super.c | 17 +++++------------
>  1 file changed, 5 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 699c15db28a82f26809bf68533454a242596f0fd..94c98446c84f9a4614971d246ca7f001de610a8a 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -2460,7 +2460,7 @@ static int parse_apply_sb_mount_options(struct super_block *sb,
>  					struct ext4_fs_context *m_ctx)
>  {
>  	struct ext4_sb_info *sbi = EXT4_SB(sb);
> -	char *s_mount_opts = NULL;
> +	char s_mount_opts[65];
>  	struct ext4_fs_context *s_ctx = NULL;
>  	struct fs_context *fc = NULL;
>  	int ret = -ENOMEM;
> @@ -2468,15 +2468,11 @@ static int parse_apply_sb_mount_options(struct super_block *sb,
>  	if (!sbi->s_es->s_mount_opts[0])
>  		return 0;
>  
> -	s_mount_opts = kstrndup(sbi->s_es->s_mount_opts,
> -				sizeof(sbi->s_es->s_mount_opts),
> -				GFP_KERNEL);
> -	if (!s_mount_opts)
> -		return ret;
> +	strscpy_pad(s_mount_opts, sbi->s_es->s_mount_opts);
>  
>  	fc = kzalloc(sizeof(struct fs_context), GFP_KERNEL);
>  	if (!fc)
> -		goto out_free;
> +		return -ENOMEM;
>  
>  	s_ctx = kzalloc(sizeof(struct ext4_fs_context), GFP_KERNEL);
>  	if (!s_ctx)
> @@ -2508,11 +2504,8 @@ static int parse_apply_sb_mount_options(struct super_block *sb,
>  	ret = 0;
>  
>  out_free:
> -	if (fc) {
> -		ext4_fc_free(fc);
> -		kfree(fc);
> -	}
> -	kfree(s_mount_opts);
> +	ext4_fc_free(fc);
> +	kfree(fc);
>  	return ret;
>  }
>  
> 
> -- 
> 2.51.0
> 
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

