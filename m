Return-Path: <linux-ext4+bounces-6543-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C08A42752
	for <lists+linux-ext4@lfdr.de>; Mon, 24 Feb 2025 17:06:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FD16188C898
	for <lists+linux-ext4@lfdr.de>; Mon, 24 Feb 2025 16:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42D9625B66A;
	Mon, 24 Feb 2025 16:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="W3zbVNoD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="g5x+Ivx1";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="UG20S6Ey";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jWfB3hHg"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF89D188CD8
	for <linux-ext4@vger.kernel.org>; Mon, 24 Feb 2025 16:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740412925; cv=none; b=gF2tjGq1I/KYICVpwSrriWj/N5JBbkeDzJjXvm6FNz3XlFqooHQyCNnR9dxIoinYr4+U3Bvn1Zgq55U6D0EvA3lQSqjx/eG5jZ6lzXKcvVzEWqEBWkbmMDI77QNEDthvGHHUoMaLEnMcvPQOPn9ejhunklLRx6Teb6KbsVbcUkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740412925; c=relaxed/simple;
	bh=GHbAzQSSFioNvRypNrTDWkMqHzuJ7pn4FfBc6uccumA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VUIbLNr67aB+y0YsDtpPJbpb/71BA9xFCUYdHnJqc7B6As36COZRYx2jefb1ZyFHLe1M9UqUF2Cvb3t+HcmXf8sDB+W+t/kBfpWFYf5b+8MMpyNYx9Q+mFxGawJswe7NZ72nCcJn7JP9CGn9LIIWaACF8MNrUHpWlEbm92468sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=W3zbVNoD; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=g5x+Ivx1; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=UG20S6Ey; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jWfB3hHg; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B34301F441;
	Mon, 24 Feb 2025 16:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740412921; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ewllgQWPI2oc5xJeL7mpXVvnQV3E4eFa8c5GHvjCzjg=;
	b=W3zbVNoDXdRZgeDgIVxBJqR+HPzsydhj1mWzgnRnubkh0k+llZWRTTiGqCJX6M34aASSly
	FrQf2BRkYKkvICZgUQsAjp03VigA1WlflXAEBjY2Okq/j7hiZk1KLzVN6j978ZNUJvHKJu
	X+CP/qDn3IwTJvNx5qzXwigP1sc4rJM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740412921;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ewllgQWPI2oc5xJeL7mpXVvnQV3E4eFa8c5GHvjCzjg=;
	b=g5x+Ivx1//at7nS0Opj1YRwhMj5S51Gprs/smErIDPXdbmNfRe7mwVUW6d6HPrgb6t+Ssy
	K6+UCdLxIoRcapAg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=UG20S6Ey;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=jWfB3hHg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740412920; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ewllgQWPI2oc5xJeL7mpXVvnQV3E4eFa8c5GHvjCzjg=;
	b=UG20S6EyX2uaj5c6ud5W7pQloF9ZlC5vMzs1SJ23eukl5LL1lvExjMzTWC8o2Zcu1euvOH
	hltSzf4ncfdhtkfo2j0uHzG5D8bZ4rwvbaewWn4qn7Gskbpynx1hlAdroZ+aikvcvDNKvF
	NKjouG7wRd9HGqZaAw5JsFSDepp/Hz8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740412920;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ewllgQWPI2oc5xJeL7mpXVvnQV3E4eFa8c5GHvjCzjg=;
	b=jWfB3hHgRtUSHIPKxmr4RALhUNUzwvx8HY/6ogLtFWNHunX1vcmp5pVQ0y8/BtaZSEDYmE
	3rmI5YWQE1ZoTIBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AB92713707;
	Mon, 24 Feb 2025 16:02:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iGbdKfiXvGerZgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 24 Feb 2025 16:02:00 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 69D85A0851; Mon, 24 Feb 2025 17:01:52 +0100 (CET)
Date: Mon, 24 Feb 2025 17:01:52 +0100
From: Jan Kara <jack@suse.cz>
To: Eric Sandeen <sandeen@redhat.com>
Cc: jack@suse.com, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 2/2] ext2: create ext2_msg_fc for use during parsing
Message-ID: <eyqjaiiytiuwuuf5gx2bk6oger2n6sxcco5gdbdxk4ciyk27lr@c4oxd73rg5ve>
References: <20250223201014.7541-1-sandeen@redhat.com>
 <20250223201014.7541-3-sandeen@redhat.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250223201014.7541-3-sandeen@redhat.com>
X-Rspamd-Queue-Id: B34301F441
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.com:email];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Sun 23-02-25 13:57:41, Eric Sandeen wrote:
> Rather than send a NULL sb to ext2_msg, which omits the s_id from
> messages, create a new ext2_msg_fc which is able to provide this
> information from the filesystem context *fc when parsing.
> 
> Signed-off-by: Eric Sandeen <sandeen@redhat.com>
...
> +static void ext2_msg_fc(struct fs_context *fc, const char *prefix,
> +			const char *fmt, ...)
> +{
> +	struct va_format vaf;
> +	va_list args;
> +	const char *s_id;
> +
> +	if (fc->purpose == FS_CONTEXT_FOR_RECONFIGURE) {
> +		s_id = fc->root->d_sb->s_id;

So the remount handling is definitely valuable...

> +	} else {
> +		/* get last path component of source */
> +		s_id = strrchr(fc->source, '/');
> +		if (s_id)
> +			s_id++;
> +	}

And this isn't too bad but I think it will crash if fc->source has no / in
it? I'll fix that up on commit.

Thanks for the patch!

								Honza

> +	va_start(args, fmt);
> +
> +	vaf.fmt = fmt;
> +	vaf.va = &args;
> +
> +	printk("%sEXT2-fs (%s): %pV\n", prefix, s_id, &vaf);
> +
> +	va_end(args);
> +}
> +
>  void ext2_msg(struct super_block *sb, const char *prefix,
>  		const char *fmt, ...)
>  {
> @@ -92,10 +117,7 @@ void ext2_msg(struct super_block *sb, const char *prefix,
>  	vaf.fmt = fmt;
>  	vaf.va = &args;
>  
> -	if (sb)
> -		printk("%sEXT2-fs (%s): %pV\n", prefix, sb->s_id, &vaf);
> -	else
> -		printk("%sEXT2-fs: %pV\n", prefix, &vaf);
> +	printk("%sEXT2-fs (%s): %pV\n", prefix, sb->s_id, &vaf);
>  
>  	va_end(args);
>  }
> @@ -544,7 +566,7 @@ static int ext2_parse_param(struct fs_context *fc, struct fs_parameter *param)
>  		ctx_clear_mount_opt(ctx, EXT2_MOUNT_OLDALLOC);
>  		break;
>  	case Opt_nobh:
> -		ext2_msg(NULL, KERN_INFO, "nobh option not supported\n");
> +		ext2_msg_fc(fc, KERN_INFO, "nobh option not supported\n");
>  		break;
>  #ifdef CONFIG_EXT2_FS_XATTR
>  	case Opt_user_xattr:
> @@ -555,7 +577,7 @@ static int ext2_parse_param(struct fs_context *fc, struct fs_parameter *param)
>  		break;
>  #else
>  	case Opt_user_xattr:
> -		ext2_msg(NULL, KERN_INFO, "(no)user_xattr options not supported");
> +		ext2_msg_fc(fc, KERN_INFO, "(no)user_xattr options not supported");
>  		break;
>  #endif
>  #ifdef CONFIG_EXT2_FS_POSIX_ACL
> @@ -567,20 +589,20 @@ static int ext2_parse_param(struct fs_context *fc, struct fs_parameter *param)
>  		break;
>  #else
>  	case Opt_acl:
> -		ext2_msg(NULL, KERN_INFO, "(no)acl options not supported");
> +		ext2_msg_fc(fc, KERN_INFO, "(no)acl options not supported");
>  		break;
>  #endif
>  	case Opt_xip:
> -		ext2_msg(NULL, KERN_INFO, "use dax instead of xip");
> +		ext2_msg_fc(fc, KERN_INFO, "use dax instead of xip");
>  		ctx_set_mount_opt(ctx, EXT2_MOUNT_XIP);
>  		fallthrough;
>  	case Opt_dax:
>  #ifdef CONFIG_FS_DAX
> -		ext2_msg(NULL, KERN_WARNING,
> +		ext2_msg_fc(fc, KERN_WARNING,
>  		    "DAX enabled. Warning: EXPERIMENTAL, use at your own risk");
>  		ctx_set_mount_opt(ctx, EXT2_MOUNT_DAX);
>  #else
> -		ext2_msg(NULL, KERN_INFO, "dax option not supported");
> +		ext2_msg_fc(fc, KERN_INFO, "dax option not supported");
>  #endif
>  		break;
>  
> @@ -597,16 +619,16 @@ static int ext2_parse_param(struct fs_context *fc, struct fs_parameter *param)
>  	case Opt_quota:
>  	case Opt_usrquota:
>  	case Opt_grpquota:
> -		ext2_msg(NULL, KERN_INFO, "quota operations not supported");
> +		ext2_msg_fc(fc, KERN_INFO, "quota operations not supported");
>  		break;
>  #endif
>  	case Opt_reservation:
>  		if (!result.negated) {
>  			ctx_set_mount_opt(ctx, EXT2_MOUNT_RESERVATION);
> -			ext2_msg(NULL, KERN_INFO, "reservations ON");
> +			ext2_msg_fc(fc, KERN_INFO, "reservations ON");
>  		} else {
>  			ctx_clear_mount_opt(ctx, EXT2_MOUNT_RESERVATION);
> -			ext2_msg(NULL, KERN_INFO, "reservations OFF");
> +			ext2_msg_fc(fc, KERN_INFO, "reservations OFF");
>  		}
>  		break;
>  	case Opt_ignore:
> -- 
> 2.48.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

