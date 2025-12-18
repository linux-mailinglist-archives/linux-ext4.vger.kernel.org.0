Return-Path: <linux-ext4+bounces-12437-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 61731CCC906
	for <lists+linux-ext4@lfdr.de>; Thu, 18 Dec 2025 16:49:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A9D2F3031273
	for <lists+linux-ext4@lfdr.de>; Thu, 18 Dec 2025 15:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC1AC3563E2;
	Thu, 18 Dec 2025 15:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ijCJjywC";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="cJxdH32s";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="BqpSIMhH";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="KNETyq3S"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF98C3559E2
	for <linux-ext4@vger.kernel.org>; Thu, 18 Dec 2025 15:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766072354; cv=none; b=bLLqvOyGYE074d28x/teX0WwR/yXx2xOTOqEgsyKgnCQcEn2fGve77cT0BOygSE2hjr0fveu9rLmXI0toBxXquUmhtDjUQgIH5+g+Q/nWNs18eU78qM987ZsuJjRGIttFJhYOIN0KNh+aEF0aNzOvno6MhrOvpPWEKVX/C0zt8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766072354; c=relaxed/simple;
	bh=BYnXZKfbNxWxUw7kbhutdj0s05hj2kVuAKjkQDXpq3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K+E3oRalnoNDDIaUu8LEjOGyv1ddnM9IvB0tVBsuV0Dd2J+KwuT+8coHOzpmVrF5P6S6UrjwP/9tn15KVDG6R1mX4VcAs6Qn7lusR49CRoqqpCpG8/jcD5zw+QoXTs7wv6zE2tiIkkoHM2jY7VhwzeKazLwfrO05Dt6U/1kOFIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ijCJjywC; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=cJxdH32s; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=BqpSIMhH; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=KNETyq3S; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BAE5F33697;
	Thu, 18 Dec 2025 15:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1766072350; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SdldBYzBnT450QSkjeDvAde+ejOK/G7H0j77WSB1tE0=;
	b=ijCJjywCoQxd97M557g3/ei8rJSdzDjAofFEFfcrvKkHogBQjy19VDSXCkuP6H4WwVtTTk
	Lv6NNSivBpqlbVmgR7q7yRtRGAqOYjzIAONGcq5cY2Y9mYpEwJKdfD7kxl7t4Siw7uWBHo
	dOuJY9/je19R8R2rd4XdcXp9ybJ0S7U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1766072350;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SdldBYzBnT450QSkjeDvAde+ejOK/G7H0j77WSB1tE0=;
	b=cJxdH32stB7B+p+D7tmXTrKfgY03cz/GgTni0ztwU2Ne03F4aPdAVlK3+PmXb3+lvWj1GO
	QGzhUcZbR0MPXvDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1766072348; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SdldBYzBnT450QSkjeDvAde+ejOK/G7H0j77WSB1tE0=;
	b=BqpSIMhH/BpTE95kQJtWhFSIqw/Of5GHtIgqXpaD34E31kkjia2d91eaiXDqbuioDXbzPb
	naYcChBxxkFmN3MrRzXMo4HwpAbxVeKRCNACzhuRoWgJhNji4+8nIaRh8LPFiRlXGOJpVy
	l4WnkS+FcyjQmXFQ01ZgviStSxBJK7c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1766072348;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SdldBYzBnT450QSkjeDvAde+ejOK/G7H0j77WSB1tE0=;
	b=KNETyq3SKE0IZIOzlTNka/gPgP2HuJjUKumwgv8HqlLzLIMS0W09OUYhiT/CzYz6iWMIgq
	9de9GodoYbH8xyDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AEF883EA63;
	Thu, 18 Dec 2025 15:39:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id i0GyKhwgRGlxIQAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 18 Dec 2025 15:39:08 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 601D3A0918; Thu, 18 Dec 2025 16:39:08 +0100 (CET)
Date: Thu, 18 Dec 2025 16:39:08 +0100
From: Jan Kara <jack@suse.cz>
To: Jinchao Wang <wangjinchao600@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Theodore Ts'o <tytso@mit.edu>, 
	Andreas Dilger <adilger.kernel@dilger.ca>, linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, syzbot+f792df426ff0f5ceb8d1@syzkaller.appspotmail.com
Subject: Re: [PATCH] ext4: xattr: fix wrong search.here in clone_block
Message-ID: <qn25xtvqu76womw47qq6uhlhmudymvfqableicrodalzfkeo4r@qjwl5oegvlpd>
References: <20251216113504.297535-1-wangjinchao600@gmail.com>
 <4msliwnvyg6n3xdzfrh4jnqklzt6zji5vlr5qj4v3lrylaigpr@lyd36cukckl7>
 <aUNbhrPEY9Aa2U4L@ndev>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aUNbhrPEY9Aa2U4L@ndev>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,s.base:url,syzkaller.appspot.com:url,search.here:url,appspotmail.com:email]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.30

On Thu 18-12-25 09:40:36, Jinchao Wang wrote:
> On Wed, Dec 17, 2025 at 12:30:15PM +0100, Jan Kara wrote:
> > Hello!
> > 
> > On Tue 16-12-25 19:34:55, Jinchao Wang wrote:
> > > syzbot reported a KASAN out-of-bounds Read in ext4_xattr_set_entry()[1].
> > > 
> > > When xattr_find_entry() returns -ENODATA, search.here still points to the
> > > position after the last valid entry. ext4_xattr_block_set() clones the xattr
> > > block because the original block maybe shared and must not be modified in
> > > place.
> > > 
> > > In the clone_block, search.here is recomputed unconditionally from the old
> > > offset, which may place it past search.first. This results in a negative
> > > reset size and an out-of-bounds memmove() in ext4_xattr_set_entry().
> > > 
> > > Fix this by initializing search.here correctly when search.not_found is set.
> > > 
> > > [1] https://syzkaller.appspot.com/bug?extid=f792df426ff0f5ceb8d1
> > > 
> > > Fixes: fd48e9acdf2 (ext4: Unindent codeblock in ext4_xattr_block_set)
> > > Cc: stable@vger.kernel.org
> > > Reported-by: syzbot+f792df426ff0f5ceb8d1@syzkaller.appspotmail.com
> > > Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
> > 
> > Thanks for the patch! But I think the problem must be somewhere else. 
> The first syzbot test report was run without the patch applied,
> which caused confusion.
> The correct usage and report show that this patch fixes the crash:
> https://lore.kernel.org/all/20251216123945.391988-2-wangjinchao600@gmail.com/
> https://lore.kernel.org/all/6941580e.a70a0220.33cd7b.013d.GAE@google.com/

I was not arguing that your patch doesn't fix this syzbot issue. Just that
I don't understand how what you describe can happen and thus I'm not sure
whether the fix is really the best one...

> > in ext4_xattr_set_entry(). And I don't see how 'here' can be greater than
> > 'last' which should be pointing to the very same 4-byte zeroed word. The
> > fact that 'here' and 'last' are not equal is IMO the problem which needs
> > debugging and it indicates there's something really fishy going on with the
> > xattr block we work with. The block should be freshly allocated one as far
> > as I'm checking the disk image (as the 'file1' file doesn't have xattr
> > block in the original image).
> 
> I traced the crash path and find how this hapens:

Thanks for sharing the details!

> entry_SYSCALL_64
> ...
> ext4_xattr_move_to_block
>   ext4_xattr_block_find (){
>     error = xattr_find_entry(inode, &bs->s.here, ...); // bs->s.here updated 
>                                                        // to ENTRY(header(s->first)+1);
>     if (error && error != -ENODATA)
>       return error;
>     bs->s.not_found = error; // and returned to the caller
>   }
>   ext4_xattr_block_set (bs) {
>     s = bs->s;
>     offset = (char *)s->here - bs->bh->b_data; // bs->bh->b_data == bs->s.base
>                                                // offset = ENTRY(header(s->first)+1) - s.base
>                                                // leads to wrong offset

Why do you think the offset is wrong here? The offset is correct AFAICS -
it will be the offset of the 0 word from the beginning of xattr block. I
have run the reproducer myself and as I guessed in my previous email the
real problem is that someone modifies the xattr block between we compute
the offset here and the moment we call kmemdup() in clone_block. Thus the
computation of 'last' in ext4_xattr_set_entry() yields a different result
that what we saw in ext4_xattr_block_set(). The block modification happens
because the xattr block - block 33 is used for it - is also referenced from
file3 (but it was marked as unused in the block bitmap and so xattr block
got placed there).

So your patch was fixing the problem only by chance and slightly different
syzbot reproducer (overwriting the block 33 with a different contents)
would trigger the crash again.

So far I wasn't able to figure out how exactly the block 33 got zeroed out
but with corrupted filesystem it can happen in principle rather easily. The
question is how we can possibly fix this because this is one of the nastier
cases of fs corrution to deal with. The overhead of re-verifying fs
metadata each time we relock the buffer is just too big... So far no great
ideas for this.

								Honza

>     clone_block: {
> 	s->base = kmemdup(BHDR(bs->bh), bs->bh->b_size, GFP_NOFS);
> 	s->first = ENTRY(header(s->base)+1);
> 	s->here = ENTRY(s->base + offset); // wrong s->here
>     }
>     ext4_xattr_set_entry (s) {
>       last = s->first; // last < here
>       rest = (void *)last - (void *)here + sizeof(__u32); // negative rest
>       memmove((void *)here + size, here, rest); // crash
>     }
>   }
> > 
> > 								Honza
> > 
> > > diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
> > > index 2e02efbddaac..cc30abeb7f30 100644
> > > --- a/fs/ext4/xattr.c
> > > +++ b/fs/ext4/xattr.c
> > > @@ -1980,7 +1980,10 @@ ext4_xattr_block_set(handle_t *handle, struct inode *inode,
> > >  			goto cleanup;
> > >  		s->first = ENTRY(header(s->base)+1);
> > >  		header(s->base)->h_refcount = cpu_to_le32(1);
> > > -		s->here = ENTRY(s->base + offset);
> > > +		if (s->not_found)
> > > +			s->here = s->first;
> > > +		else
> > > +			s->here = ENTRY(s->base + offset);
> > >  		s->end = s->base + bs->bh->b_size;
> > >  
> > >  		/*
> > > -- 
> > > 2.43.0
> > > 
> > -- 
> > Jan Kara <jack@suse.com>
> > SUSE Labs, CR
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

