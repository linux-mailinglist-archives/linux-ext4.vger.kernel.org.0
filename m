Return-Path: <linux-ext4+bounces-8417-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A7E22AD9220
	for <lists+linux-ext4@lfdr.de>; Fri, 13 Jun 2025 17:57:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 150BF1899781
	for <lists+linux-ext4@lfdr.de>; Fri, 13 Jun 2025 15:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DB031FDE1E;
	Fri, 13 Jun 2025 15:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="j0RiOAkh";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5uUXeId8";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="j0RiOAkh";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5uUXeId8"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220C718DB29
	for <linux-ext4@vger.kernel.org>; Fri, 13 Jun 2025 15:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749830154; cv=none; b=gEODKVfasfjnR7Rhpo7pJzSNclPqOeIlfyAjJEMui9hjg79XfCS8NqOrVzdACDzJTI78rXJ12lSGKB0uSlZS33vr3MlraQgmQ5XSWjQ5zmG24DGYtTxQ7KOJ5cSgfTtz1nd7cA70BK/nu2M0rpemRb6UNW6hXdrve7rwrep9tX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749830154; c=relaxed/simple;
	bh=LA9KMFx22SDlmIdsNUvqINZWyaU7ZbM3j1938f2NZIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IzHSxAv56OT/6KztYI+m9fjz1W3mahUaKc74kU4WL0fSocryR4/6c5nrxlEFBCxDny9sIeOOrrwaWBA8rNLG0iDyItFxEybxSFHjKFCE3ddKufoRjGMzFXRPKKylDhM3AH2f42TqOei2tUl1rV0oowjW4Wmvc/bbnkRc1zJ22Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=j0RiOAkh; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5uUXeId8; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=j0RiOAkh; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5uUXeId8; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0B78A1F394;
	Fri, 13 Jun 2025 15:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1749830150; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6HmU5UhLrCtmKzq9wnn1QgmH8ORcyh4xVbHFKpC+Zdw=;
	b=j0RiOAkhOLPB65cD9t0oUlmiajmJitWpJtjYL3zfcj8RxT8eZf9QwhM1JryG4M2i4H3Qm2
	TYvDFraKeqMx3EJdg68mmcpRroOWydifjieNmgea5mdIVVX/QGLB6rtW63ZuJqJ2+x7OQ9
	5/SxV/7RNUSOb5S/H/OLuIkl5a1hUU8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1749830150;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6HmU5UhLrCtmKzq9wnn1QgmH8ORcyh4xVbHFKpC+Zdw=;
	b=5uUXeId8BKmff9LhWy8yJ1Ii/fUxsdM73WC0+9DwBMruo23rZDh/FRjoGazKjO7Sm6i/WH
	UrBTlGNIleB+8lDw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=j0RiOAkh;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=5uUXeId8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1749830150; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6HmU5UhLrCtmKzq9wnn1QgmH8ORcyh4xVbHFKpC+Zdw=;
	b=j0RiOAkhOLPB65cD9t0oUlmiajmJitWpJtjYL3zfcj8RxT8eZf9QwhM1JryG4M2i4H3Qm2
	TYvDFraKeqMx3EJdg68mmcpRroOWydifjieNmgea5mdIVVX/QGLB6rtW63ZuJqJ2+x7OQ9
	5/SxV/7RNUSOb5S/H/OLuIkl5a1hUU8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1749830150;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6HmU5UhLrCtmKzq9wnn1QgmH8ORcyh4xVbHFKpC+Zdw=;
	b=5uUXeId8BKmff9LhWy8yJ1Ii/fUxsdM73WC0+9DwBMruo23rZDh/FRjoGazKjO7Sm6i/WH
	UrBTlGNIleB+8lDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F0EE0137FE;
	Fri, 13 Jun 2025 15:55:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ZJ2FOgVKTGh+MQAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 13 Jun 2025 15:55:49 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 85691A09B0; Fri, 13 Jun 2025 17:55:45 +0200 (CEST)
Date: Fri, 13 Jun 2025 17:55:45 +0200
From: Jan Kara <jack@suse.cz>
To: Wei Gao <wegao@suse.com>
Cc: Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org, 
	linux-ext4@vger.kernel.org
Subject: Re: [PATCH v2] ext2: Handle fiemap on empty files to prevent EINVAL
Message-ID: <5tsjb3wlierqa4cnevn4vv5dnwved7fsg55ggxlqf5coyptsjz@uco7crwg6x4m>
References: <20250612142855.2678267-1-wegao@suse.com>
 <20250613152402.3432135-1-wegao@suse.com>
 <mxios5pbq3vq5267on4vnt5siozd4nap5w7wemsd2vlxoooexd@ia2ezhdu7ujq>
 <aEytOcFNAI7ZcxzM@MiWiFi-CR6608-srv>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aEytOcFNAI7ZcxzM@MiWiFi-CR6608-srv>
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 0B78A1F394
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_THREE(0.00)[3];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Score: -4.01
X-Spam-Level: 

On Fri 13-06-25 18:59:05, Wei Gao wrote:
> On Fri, Jun 13, 2025 at 11:42:17AM +0200, Jan Kara wrote:
> > On Fri 13-06-25 11:18:38, Wei Gao wrote:
> > > Previously, ext2_fiemap would unconditionally apply "len = min_t(u64, len,
> > > i_size_read(inode));", When inode->i_size was 0 (for an empty file), this
> > > would reduce the requested len to 0. Passing len = 0 to iomap_fiemap could
> > > then result in an -EINVAL error, even for valid queries on empty files.
> > > 
> > > Link: https://github.com/linux-test-project/ltp/issues/1246
> > > Signed-off-by: Wei Gao <wegao@suse.com>
> > 
> > ...
> > 
> > > diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
> > > index 30f8201c155f..591db2b4390a 100644
> > > --- a/fs/ext2/inode.c
> > > +++ b/fs/ext2/inode.c
> > > @@ -895,9 +895,15 @@ int ext2_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
> > >  		u64 start, u64 len)
> > >  {
> > >  	int ret;
> > > +	u64 i_size;
> > >  
> > >  	inode_lock(inode);
> > > -	len = min_t(u64, len, i_size_read(inode));
> > > +
> > > +	i_size = i_size_read(inode);
> > > +
> > > +	if (i_size > 0)
> > > +		len = min_t(u64, len, i_size_read(inode));
> > 
> > 
> > Thanks! This would actually lead to excessively slow fiemap for 0-length
> > files. So what I've ended up with is attached modification of your patch.
> Thank you for your patient review, I really appreciate it. 
> 
> BTW i have stupid question:
> Where can I see the real-time status of this patch? such as whether it has been merged?
> I have checked https://patchwork.kernel.org/project/linux-fsdevel/list/
> but do not find current patch, maybe this patch need specific sent it to
> linux-fsdevel@vger.kernel.org? I just get maillist through scripts/get_maintainer.pl but
> mail list not contain linux-fsdevel@vger.kernel.org.

You cannot easily check it. You can see the patch is sitting in
git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git for_next
branch. During the next merge window, I'll push it to Linus.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

