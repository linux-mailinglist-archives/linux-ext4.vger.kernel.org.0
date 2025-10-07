Return-Path: <linux-ext4+bounces-10648-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC99BC1638
	for <lists+linux-ext4@lfdr.de>; Tue, 07 Oct 2025 14:41:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 265864F5B86
	for <lists+linux-ext4@lfdr.de>; Tue,  7 Oct 2025 12:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F5792D97B8;
	Tue,  7 Oct 2025 12:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="NSJn3ZJh";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="WHF/q9uQ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="NSJn3ZJh";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="WHF/q9uQ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D58C2D5C97
	for <linux-ext4@vger.kernel.org>; Tue,  7 Oct 2025 12:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759840906; cv=none; b=nHW5locuCt25HGJyVZ31zDtSpw1Uz70KymfUQHLMTAoOBQNy9AF/rzwWQ3OXjMmJWwQosKKVUx6tlGo1bbB7PmdLlho2/cnASW/0qJCfQrXV+ZZwmvef6eZt1QIquayvNxy8bABD3f3yR1+ASNQioC3ynXi2jgmHL59s4g/FVVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759840906; c=relaxed/simple;
	bh=feNSRSwEtoz7YZLF7NAE0/7KPXjzEWRq4gd7BjxquxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sBuIrouVGxM+NPA1NIyFOXoIwJb5WQcJ1u23CpXV1X48UzDJvaYmUxJ2fvsqZV0plp44OJ5aXwgMLqfC7m83L9qBLvSZ3pirWs6qmBjvldwZtM/76vp4BNkoNb/af9/+oow5sYnmbw92HvPeRxl+9boc3LRVQS1YsTZtOoPI5I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=NSJn3ZJh; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=WHF/q9uQ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=NSJn3ZJh; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=WHF/q9uQ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AA21B1F7DE;
	Tue,  7 Oct 2025 12:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759840902; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c7OBybBhLl7N+S0TusTWlygZX4BfpcVyM4TEZK3o3Cw=;
	b=NSJn3ZJho3/MjC6jAuyErBHgstEzAj/Tdy3vVQGmdPxeZx4ic8qhXYiO4SewbEpqmQjxqd
	L2g8zuvQXBXYP1VjWX2y4u+fSaIuGGlY/FtgcJnKqAGH+eg0zCK+k3UEqxt4ZD6cubN7Qo
	XaeY/JSODUeSE3OaEyrwunnU4/tVC/k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759840902;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c7OBybBhLl7N+S0TusTWlygZX4BfpcVyM4TEZK3o3Cw=;
	b=WHF/q9uQhUTNLnT9rYTpcSNeP7/qxZ/gbBcahv24sIWOBQk9Mp9frHrV030ZwC2y5kWwIE
	Ted53uORMG8U4WAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759840902; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c7OBybBhLl7N+S0TusTWlygZX4BfpcVyM4TEZK3o3Cw=;
	b=NSJn3ZJho3/MjC6jAuyErBHgstEzAj/Tdy3vVQGmdPxeZx4ic8qhXYiO4SewbEpqmQjxqd
	L2g8zuvQXBXYP1VjWX2y4u+fSaIuGGlY/FtgcJnKqAGH+eg0zCK+k3UEqxt4ZD6cubN7Qo
	XaeY/JSODUeSE3OaEyrwunnU4/tVC/k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759840902;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c7OBybBhLl7N+S0TusTWlygZX4BfpcVyM4TEZK3o3Cw=;
	b=WHF/q9uQhUTNLnT9rYTpcSNeP7/qxZ/gbBcahv24sIWOBQk9Mp9frHrV030ZwC2y5kWwIE
	Ted53uORMG8U4WAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9415513AAC;
	Tue,  7 Oct 2025 12:41:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5qAfJIYK5WhpFQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 07 Oct 2025 12:41:42 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id D209FA0A58; Tue,  7 Oct 2025 14:41:41 +0200 (CEST)
Date: Tue, 7 Oct 2025 14:41:41 +0200
From: Jan Kara <jack@suse.cz>
To: Chris Mason <clm@meta.com>
Cc: Jan Kara <jack@suse.cz>, Ted Tso <tytso@mit.edu>, 
	linux-ext4@vger.kernel.org, syzbot+0b92850d68d9b12934f5@syzkaller.appspotmail.com
Subject: Re: [PATCH] ext4: verify orphan file size is not too big
Message-ID: <qwkid6zi3wekavyp5ravu32wlyfqgo5osfnlnsjctsp7godboc@ekwo4ooyutum>
References: <20250909112206.10459-2-jack@suse.cz>
 <20251006172822.2762117-1-clm@meta.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251006172822.2762117-1-clm@meta.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	TAGGED_RCPT(0.00)[0b92850d68d9b12934f5];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.com:email]
X-Spam-Flag: NO
X-Spam-Score: -2.30

On Mon 06-10-25 10:28:10, Chris Mason wrote:
> On Tue,  9 Sep 2025 13:22:07 +0200 Jan Kara <jack@suse.cz> wrote:
> 
> > In principle orphan file can be arbitrarily large. However orphan replay
> > needs to traverse it all and we also pin all its buffers in memory. Thus
> > filesystems with absurdly large orphan files can lead to big amounts of
> > memory consumed. Limit orphan file size to a sane value and also use
> > kvmalloc() for allocating array of block descriptor structures to avoid
> > large order allocations for sane but large orphan files.
> > 
> > Reported-by: syzbot+0b92850d68d9b12934f5@syzkaller.appspotmail.com
> > Fixes: 02f310fcf47f ("ext4: Speedup ext4 orphan inode handling")
> > Signed-off-by: Jan Kara <jack@suse.cz>
> > ---
> >  fs/ext4/orphan.c | 13 ++++++++++++-
> >  1 file changed, 12 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/ext4/orphan.c b/fs/ext4/orphan.c
> > index 524d4658fa40..7e4f48c15c2e 100644
> > --- a/fs/ext4/orphan.c
> > +++ b/fs/ext4/orphan.c
> > @@ -587,9 +587,20 @@ int ext4_init_orphan_info(struct super_block *sb)
> >  		ext4_msg(sb, KERN_ERR, "get orphan inode failed");
> >  		return PTR_ERR(inode);
> >  	}
> > +	/*
> > +	 * This is just an artificial limit to prevent corrupted fs from
> > +	 * consuming absurd amounts of memory when pinning blocks of orphan
> > +	 * file in memory.
> > +	 */
> > +	if (inode->i_size > 8 << 20) {
> > +		ext4_msg(sb, KERN_ERR, "orphan file too big: %llu",
> > +			 (unsigned long long)inode->i_size);
> > +		ret = -EFSCORRUPTED;
> > +		goto out_put;
> > +	}
> >  	oi->of_blocks = inode->i_size >> sb->s_blocksize_bits;
> >  	oi->of_csum_seed = EXT4_I(inode)->i_csum_seed;
> > -	oi->of_binfo = kmalloc_array(oi->of_blocks,
> > +	oi->of_binfo = kvmalloc_array(oi->of_blocks,
> >  				     sizeof(struct ext4_orphan_block),
> >  				     GFP_KERNEL);
> >  	if (!oi->of_binfo) {
> 
> Hi everyone,
> 
> I tripped over this while testing some review automation on linux-next.
> 
> Should we swap all the kfree(oi->of_binfo) to kvfree?

Yes, we should. Thanks for spotting this. I'll send a fix.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

