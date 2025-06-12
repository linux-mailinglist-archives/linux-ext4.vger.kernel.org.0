Return-Path: <linux-ext4+bounces-8388-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8538CAD6E9D
	for <lists+linux-ext4@lfdr.de>; Thu, 12 Jun 2025 13:07:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0ED733B087C
	for <lists+linux-ext4@lfdr.de>; Thu, 12 Jun 2025 11:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94F3323BCFF;
	Thu, 12 Jun 2025 11:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="w+7ebqnK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="hJbVaxwj";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="w+7ebqnK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="hJbVaxwj"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5CC9234971
	for <linux-ext4@vger.kernel.org>; Thu, 12 Jun 2025 11:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749726415; cv=none; b=SVd38TT8gvj5124Yz+CYu6SOo2/IiRO0WtY2hnj2ULaG/uNuc2eJouYY4rwNrMCcb1MCBJmjy4CFpoCCz/gBMguAF6mDma80caBzjIOYCrs0ygIwHGT5ZLQZvOEYbS87iYVMxU+TQ9qwAe1tWWUsFbg+/t8/4cVwUmiDYjku7Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749726415; c=relaxed/simple;
	bh=Gh9rW/QdgvgrjyhYijZNuPf01GIPHV2uxE5YQhV/yFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O1v514cCLq21TwZTtz8M+7b0SdhYhXbvy8T54AhysCl2LJ0qNsXJxYmTP/D4Ybj223sfAM681e2d4nQBC/fDymnntXmZk2ijRooQAURSejuPP2XNUHmD0JTDEpudJbpNY+WOgYFAURhupQIkOWmhy7i35FKROIQMB027XtpgTLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=w+7ebqnK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=hJbVaxwj; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=w+7ebqnK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=hJbVaxwj; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0A6B21F78E;
	Thu, 12 Jun 2025 11:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1749726411; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a37KPNxiSG0b/2gFdhH0Jd54vMhtpQaRuLzH+9O/ztM=;
	b=w+7ebqnKHo+2J19h3nRBlQcPMhaYV+CxuJy9ay8QoF6cLzHm9/G89pXX4zaodmOLUb/dh4
	ziAgh8+oCqCt+f1tlwg278+ZNBBA+7QI62b4/64g1woVHGorMHySX8Wt2c9IbHTMmiMrcM
	tfxKh+Iw+rtqljvDRp9ZMrJ9E2i6uDA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1749726411;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a37KPNxiSG0b/2gFdhH0Jd54vMhtpQaRuLzH+9O/ztM=;
	b=hJbVaxwjZZUqfKr/cnFARjXYro6uk+jak5h5jKZa1ZRx7+AoN5EcLts6FLiJ8eSIqgRYbD
	kfZWe8lA8my0nbCw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=w+7ebqnK;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=hJbVaxwj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1749726411; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a37KPNxiSG0b/2gFdhH0Jd54vMhtpQaRuLzH+9O/ztM=;
	b=w+7ebqnKHo+2J19h3nRBlQcPMhaYV+CxuJy9ay8QoF6cLzHm9/G89pXX4zaodmOLUb/dh4
	ziAgh8+oCqCt+f1tlwg278+ZNBBA+7QI62b4/64g1woVHGorMHySX8Wt2c9IbHTMmiMrcM
	tfxKh+Iw+rtqljvDRp9ZMrJ9E2i6uDA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1749726411;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a37KPNxiSG0b/2gFdhH0Jd54vMhtpQaRuLzH+9O/ztM=;
	b=hJbVaxwjZZUqfKr/cnFARjXYro6uk+jak5h5jKZa1ZRx7+AoN5EcLts6FLiJ8eSIqgRYbD
	kfZWe8lA8my0nbCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F4028139E2;
	Thu, 12 Jun 2025 11:06:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3CuLO8q0SmjWXQAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 12 Jun 2025 11:06:50 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id B5683A099E; Thu, 12 Jun 2025 13:06:46 +0200 (CEST)
Date: Thu, 12 Jun 2025 13:06:46 +0200
From: Jan Kara <jack@suse.cz>
To: Wei Gao <wegao@suse.com>
Cc: linux-kernel@vger.kernel.org, jack@suse.com, 
	linux-ext4@vger.kernel.org
Subject: Re: [PATCH] ext2: Handle fiemap on empty files to prevent EINVAL
Message-ID: <yqvm4j2xv7udi7qd5egxyc4zqe7ywaqb5begvuxjwokgc7bi32@ybl3v4hbkiyc>
References: <20250612142855.2678267-1-wegao@suse.com>
 <ve7pt2nbw6qmdoy2i6dzvtlougxjcl6eye73kjysomhxx4vans@24vgczp5ospk>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ve7pt2nbw6qmdoy2i6dzvtlougxjcl6eye73kjysomhxx4vans@24vgczp5ospk>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email]
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 0A6B21F78E
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -4.01

On Thu 12-06-25 12:29:16, Jan Kara wrote:
> On Thu 12-06-25 10:28:55, Wei Gao wrote:
> > Previously, ext2_fiemap would unconditionally apply "len = min_t(u64, len,
> > i_size_read(inode));", When inode->i_size was 0 (for an empty file), this
> > would reduce the requested len to 0. Passing len = 0 to iomap_fiemap could
> > then result in an -EINVAL error, even for valid queries on empty files.
> > The new validation logic directly references ext4_fiemap_check_ranges.
> > 
> > Link: https://github.com/linux-test-project/ltp/issues/1246
> > Signed-off-by: Wei Gao <wegao@suse.com>
> 
> Thanks for the fix. Some comments below:
> 
> > diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
> > index 30f8201c155f..e5cc61088f21 100644
> > --- a/fs/ext2/inode.c
> > +++ b/fs/ext2/inode.c
> > @@ -895,10 +895,30 @@ int ext2_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
> >  		u64 start, u64 len)
> >  {
> >  	int ret;
> > +	u64 maxbytes;
> >  
> >  	inode_lock(inode);
> > -	len = min_t(u64, len, i_size_read(inode));
> 
> So I agree this 'len' reduction to i_size looks bogus and can be removed.
> But why are you adding those maxbytes checks when they are done inside
> iomap_fiemap() shorly later?

After experimenting a bit I see the purpose of trimming to i_size -
otherwise with large range iomap will iterate all available inode offsets
block by block wasting a lot of CPU. This is because ext2_get_blocks() is
always reporting holes as a single block long. So we either need to keep
the i_size limitation (and just treat i_size == 0 specially) or we need to
improve ext2_get_blocks() to better report length of holes (at least
whatever is in the currently loaded indirect block) - not sure if that is
worth it.

								Honza

> > +	maxbytes = inode->i_sb->s_maxbytes;
> > +
> > +	if (len == 0) {
> > +		ret = -EINVAL;
> > +		goto unlock_inode;
> > +	}
> > +
> > +	if (start > maxbytes) {
> > +		ret = -EFBIG;
> > +		goto unlock_inode;
> > +	}
> > +
> > +	/*
> > +	 * Shrink request scope to what the fs can actually handle.
> > +	 */
> > +	if (len > maxbytes || (maxbytes - len) < start)
> > +		len = maxbytes - start;
> > +
> >  	ret = iomap_fiemap(inode, fieinfo, start, len, &ext2_iomap_ops);
> > +
> > +unlock_inode:
> >  	inode_unlock(inode);
> >  
> >  	return ret;
> > -- 
> > 2.49.0
> > 
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

