Return-Path: <linux-ext4+bounces-4194-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A603097B026
	for <lists+linux-ext4@lfdr.de>; Tue, 17 Sep 2024 14:33:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04670B26563
	for <lists+linux-ext4@lfdr.de>; Tue, 17 Sep 2024 12:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FF1F170A12;
	Tue, 17 Sep 2024 12:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PNDm7dee";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="TVZvAQNd";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YEFB+KhC";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Qa//7uSy"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F322BAEB;
	Tue, 17 Sep 2024 12:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726576406; cv=none; b=lIXxr8EwbWhvhwc3N4EAlLrKtd7wnu19ruGAAMDjudW+4ZJU84fnxDLkycDxhzT5ASk84XXe0LtSxAn4unXUNuzdKPnD0lTkHezgWdimVQv3kajwiPEnrEGxZryaRCdBjNI9W/sRVeLcbJc3iw9Y6G6k15DHSOmaR0BSIm2/jgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726576406; c=relaxed/simple;
	bh=wui/ZUOoOmIWC9sU2kxiGayhDoDZligC6DIdni7/nzE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jA5Gq+RoeebHAO2jU9Gd6J1vfAMHIRJA5YVYjwUIYS/koAoRBmyeU3M/z0BpweDWgz+0bPipV449st47xQ1NqPrRuq9+NRZGRK2wa0JwMQuunYImbPZ1CPMkHa7BasdQjtVdEo4zLStHd51CaW4ik4DSy3qvyLoboohmxOwoUWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PNDm7dee; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=TVZvAQNd; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=YEFB+KhC; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Qa//7uSy; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E606C221D9;
	Tue, 17 Sep 2024 12:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1726576402; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SqiTc/6rJz2xOTDJDdGyME6zy5fT6lpOKLr82cV+5mg=;
	b=PNDm7deewFy7U48HTCVLbguwDBDT9EnwH0Iz6y5GSDGHpc3PBdWOtz3UgSxuPdWYfaMCGo
	6Qt2njtewTil2xnS/J5qA2cR6EsqRN+7auioaxGLJNBUbme59i1JfbNn1TIFJ9Hfon/Ksp
	nvPh3UHgaggA9U3hg3wNPVxHczCdDBk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1726576402;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SqiTc/6rJz2xOTDJDdGyME6zy5fT6lpOKLr82cV+5mg=;
	b=TVZvAQNdAgiUvTaFPZ9565VfrH01xPjXYxy1ulUNBAQZrs5bk9n2l4dFV9r8thA7AH132p
	h2MIMc/MhrUmUgCA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=YEFB+KhC;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="Qa//7uSy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1726576401; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SqiTc/6rJz2xOTDJDdGyME6zy5fT6lpOKLr82cV+5mg=;
	b=YEFB+KhCZ+rwYiixc04ciMaAELaDC1UGGK7srCBcIpOiJIXRg435wMfiysDWxlcGtdONpo
	j7/icPnq+OOpb+uPmIZt97z16yN4yEpnb+z6/K8nmOwlyzYS+ASqdw0NUWFPVPSTEFJcje
	ort/BrCRTzTsNg7Tuc6uC8PNh03JcJ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1726576401;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SqiTc/6rJz2xOTDJDdGyME6zy5fT6lpOKLr82cV+5mg=;
	b=Qa//7uSyEy6b9nJPBCiP7rsJV66w+brPRf2rhU1goCKL+acCxSFYxOJCIAyHymxaF5vcwi
	4BDJqFkFrmOinYBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A725C13AB6;
	Tue, 17 Sep 2024 12:33:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 80O8KBF36WahHgAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 17 Sep 2024 12:33:21 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 8AC57A0989; Tue, 17 Sep 2024 14:25:29 +0200 (CEST)
Date: Tue, 17 Sep 2024 14:25:29 +0200
From: Jan Kara <jack@suse.cz>
To: Thorsten Blum <thorsten.blum@toblux.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, kees@kernel.org,
	gustavoars@kernel.org, linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] ext4: Annotate struct fname with __counted_by()
Message-ID: <20240917122529.lmikh56cfbjr3lsz@quack3>
References: <20240913110013.151331-2-thorsten.blum@toblux.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240913110013.151331-2-thorsten.blum@toblux.com>
X-Rspamd-Queue-Id: E606C221D9
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[8];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Fri 13-09-24 13:00:14, Thorsten Blum wrote:
> Add the __counted_by compiler attribute to the flexible array member
> name to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
> CONFIG_FORTIFY_SOURCE.
> 
> Inline and use struct_size() to calculate the number of bytes to
> allocate for new_fn and remove the local variable len.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/dir.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/ext4/dir.c b/fs/ext4/dir.c
> index ff4514e4626b..8e7df15bb971 100644
> --- a/fs/ext4/dir.c
> +++ b/fs/ext4/dir.c
> @@ -408,7 +408,7 @@ struct fname {
>  	__u32		inode;
>  	__u8		name_len;
>  	__u8		file_type;
> -	char		name[];
> +	char		name[] __counted_by(name_len);
>  };
>  
>  /*
> @@ -464,14 +464,13 @@ int ext4_htree_store_dirent(struct file *dir_file, __u32 hash,
>  	struct rb_node **p, *parent = NULL;
>  	struct fname *fname, *new_fn;
>  	struct dir_private_info *info;
> -	int len;
>  
>  	info = dir_file->private_data;
>  	p = &info->root.rb_node;
>  
>  	/* Create and allocate the fname structure */
> -	len = sizeof(struct fname) + ent_name->len + 1;
> -	new_fn = kzalloc(len, GFP_KERNEL);
> +	new_fn = kzalloc(struct_size(new_fn, name, ent_name->len + 1),
> +			 GFP_KERNEL);
>  	if (!new_fn)
>  		return -ENOMEM;
>  	new_fn->hash = hash;
> -- 
> 2.46.0
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

