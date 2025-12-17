Return-Path: <linux-ext4+bounces-12383-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 73F33CC7584
	for <lists+linux-ext4@lfdr.de>; Wed, 17 Dec 2025 12:30:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 692C53043812
	for <lists+linux-ext4@lfdr.de>; Wed, 17 Dec 2025 11:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E47D4279334;
	Wed, 17 Dec 2025 11:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="v5/vv4R6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3lISW4KQ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="v5/vv4R6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3lISW4KQ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3530339B53
	for <linux-ext4@vger.kernel.org>; Wed, 17 Dec 2025 11:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765971023; cv=none; b=aNcwwWCZ+hL8ad4VQcahE3I0cZex0yPg6aGcYzYFK0mA2tkpADbkuWZM8s+3n9mgGlp39qEH31/Yv9Zs7j3Vj47P7QqYv3RljzlUJCiOUpswR1jdxbYy1FguE0GESrTLY51vbkIbpI2GOGlsvOSu2XIe3sbeyMXUIsxRQEU4EZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765971023; c=relaxed/simple;
	bh=gncn/pXeYtbNeFPKcyq5wl4gsKvAfSeCDDP/WxlUaFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uvxEWK2gtgLCRJzBxedF5BdeAKp1Cg6baTSbuavu579NJCta5Rmu2BTorMEzUzb1kF6x2CdyLoW30GzoN/3oU+p/bwHiQcJ9nHO/dm0xyB/u4zqhV8+Cnwlqs6pH7A1cG2hPJdGktTPmxjty+ar2PSxwjm0giu3iIDs8npjUhbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=v5/vv4R6; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3lISW4KQ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=v5/vv4R6; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3lISW4KQ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 05E6E336CA;
	Wed, 17 Dec 2025 11:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1765971020; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+z/KFBjig9MuWmr9AhGSFARmuOAuGrcardEU8oLHv8o=;
	b=v5/vv4R6z5Io6CVu1IMNp1tl/oHZRzc+XTls3RntXEb0hBgMIfBOaROngTHyA492Kzbt5I
	gbbmkkle3/Br5hP9I4OU9fEPKcDT5+sSUmMUzdB2xm4AbW3jNG8e8uxLyk1MaRa9GFKDtp
	mRipMjriuXbKS6lW90M+7pHBPrXwgLc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1765971020;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+z/KFBjig9MuWmr9AhGSFARmuOAuGrcardEU8oLHv8o=;
	b=3lISW4KQn58dtKtkNI61aoEatutS9zc6JQVCEgEt4SZcZ7uqV+q/nakUVoXVwuxKlk3VWJ
	AFFrrvn3xM4WCqDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1765971020; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+z/KFBjig9MuWmr9AhGSFARmuOAuGrcardEU8oLHv8o=;
	b=v5/vv4R6z5Io6CVu1IMNp1tl/oHZRzc+XTls3RntXEb0hBgMIfBOaROngTHyA492Kzbt5I
	gbbmkkle3/Br5hP9I4OU9fEPKcDT5+sSUmMUzdB2xm4AbW3jNG8e8uxLyk1MaRa9GFKDtp
	mRipMjriuXbKS6lW90M+7pHBPrXwgLc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1765971020;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+z/KFBjig9MuWmr9AhGSFARmuOAuGrcardEU8oLHv8o=;
	b=3lISW4KQn58dtKtkNI61aoEatutS9zc6JQVCEgEt4SZcZ7uqV+q/nakUVoXVwuxKlk3VWJ
	AFFrrvn3xM4WCqDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E00E73EA63;
	Wed, 17 Dec 2025 11:30:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id c3GwNkuUQmkVYgAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 17 Dec 2025 11:30:19 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 609C8A0927; Wed, 17 Dec 2025 12:30:15 +0100 (CET)
Date: Wed, 17 Dec 2025 12:30:15 +0100
From: Jan Kara <jack@suse.cz>
To: Jinchao Wang <wangjinchao600@gmail.com>
Cc: Theodore Ts'o <tytso@mit.edu>, 
	Andreas Dilger <adilger.kernel@dilger.ca>, Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	syzbot+f792df426ff0f5ceb8d1@syzkaller.appspotmail.com
Subject: Re: [PATCH] ext4: xattr: fix wrong search.here in clone_block
Message-ID: <4msliwnvyg6n3xdzfrh4jnqklzt6zji5vlr5qj4v3lrylaigpr@lyd36cukckl7>
References: <20251216113504.297535-1-wangjinchao600@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251216113504.297535-1-wangjinchao600@gmail.com>
X-Spam-Flag: NO
X-Spam-Score: -2.30
X-Spam-Level: 
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MISSING_XM_UA(0.00)[];
	TAGGED_RCPT(0.00)[f792df426ff0f5ceb8d1];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]

Hello!

On Tue 16-12-25 19:34:55, Jinchao Wang wrote:
> syzbot reported a KASAN out-of-bounds Read in ext4_xattr_set_entry()[1].
> 
> When xattr_find_entry() returns -ENODATA, search.here still points to the
> position after the last valid entry. ext4_xattr_block_set() clones the xattr
> block because the original block maybe shared and must not be modified in
> place.
> 
> In the clone_block, search.here is recomputed unconditionally from the old
> offset, which may place it past search.first. This results in a negative
> reset size and an out-of-bounds memmove() in ext4_xattr_set_entry().
> 
> Fix this by initializing search.here correctly when search.not_found is set.
> 
> [1] https://syzkaller.appspot.com/bug?extid=f792df426ff0f5ceb8d1
> 
> Fixes: fd48e9acdf2 (ext4: Unindent codeblock in ext4_xattr_block_set)
> Cc: stable@vger.kernel.org
> Reported-by: syzbot+f792df426ff0f5ceb8d1@syzkaller.appspotmail.com
> Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>

Thanks for the patch! But I think the problem must be somewhere else. When
a search ends without success (-ENODATA error), s->here points to the
4-byte zeroed word inside xattr space that terminates the part with xattr
headers. If I understand correctly the expression which overflows is:

size_t rest = (void *)last - (void *)here + sizeof(__u32);

in ext4_xattr_set_entry(). And I don't see how 'here' can be greater than
'last' which should be pointing to the very same 4-byte zeroed word. The
fact that 'here' and 'last' are not equal is IMO the problem which needs
debugging and it indicates there's something really fishy going on with the
xattr block we work with. The block should be freshly allocated one as far
as I'm checking the disk image (as the 'file1' file doesn't have xattr
block in the original image).

								Honza

> diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
> index 2e02efbddaac..cc30abeb7f30 100644
> --- a/fs/ext4/xattr.c
> +++ b/fs/ext4/xattr.c
> @@ -1980,7 +1980,10 @@ ext4_xattr_block_set(handle_t *handle, struct inode *inode,
>  			goto cleanup;
>  		s->first = ENTRY(header(s->base)+1);
>  		header(s->base)->h_refcount = cpu_to_le32(1);
> -		s->here = ENTRY(s->base + offset);
> +		if (s->not_found)
> +			s->here = s->first;
> +		else
> +			s->here = ENTRY(s->base + offset);
>  		s->end = s->base + bs->bh->b_size;
>  
>  		/*
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

