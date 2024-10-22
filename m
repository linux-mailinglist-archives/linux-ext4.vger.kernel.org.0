Return-Path: <linux-ext4+bounces-4717-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4338D9A9EB8
	for <lists+linux-ext4@lfdr.de>; Tue, 22 Oct 2024 11:40:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2AA5281204
	for <lists+linux-ext4@lfdr.de>; Tue, 22 Oct 2024 09:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A842B198E7F;
	Tue, 22 Oct 2024 09:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vXL7kbXj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mWpmrCWr";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vXL7kbXj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mWpmrCWr"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6DCE12D75C
	for <linux-ext4@vger.kernel.org>; Tue, 22 Oct 2024 09:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729590044; cv=none; b=eopU8QmRp+wWsmUgrcr5Lb6k1CTLcT7ZvkZcJZLEfwiYLq+coqKSeocvCfaD0WMMXs17esdYP6K63cUEFZyXDjWVRi2GR/8pCXEWzHHWHCSztaBDYBCmb1JPz+m8kJmyUupuAHbZTvfDFWA6tVB4Qb0tG6QqhDRTTnV+EbowZDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729590044; c=relaxed/simple;
	bh=n3cIPjNlmhhDKpy5dtS9I4GWf+cbAJnU9dqdG0gMagE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=miMKo94bUaStbbE9ag00EJDnqT8yRFwqLYORKzHiyYHxDIIGxY1N0kdb9ojatYZlfrFVY34tCmMntSKxG3pMd1XXP/ydk4TMqKWgy5TLNGA8xoQdOFkoRlCGCOuaDWCKh0WcNY7gSdL9po2HANTjuSCTOQfetANGtQp7vHlZcF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vXL7kbXj; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=mWpmrCWr; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vXL7kbXj; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=mWpmrCWr; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A0FD621C5E;
	Tue, 22 Oct 2024 09:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729590040; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iX9v/1QecoT5tk1VC4dOytqVgZGLtbuQdPNKprehSjc=;
	b=vXL7kbXjoKCBpbPE6vNwglUNO38xXixA8tRfpKs1mOrGFBZs3VtTHRXzmVCfIfnv9HfACx
	uleoBSOTAQI8dGOt1w7kD3heKNAP3lHyEWC+yrG57NBo7dK23YsoDDAaoYjUJu9rShLqcZ
	TT8EcMJJpvPS6vJJwKCKHhYBm9Gdcg8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729590040;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iX9v/1QecoT5tk1VC4dOytqVgZGLtbuQdPNKprehSjc=;
	b=mWpmrCWrpEfBKi7OrX5Pcfbvr0/3ii/to09SWdC/cLAbSiPDoRSE0rcoOyEMqMKmmrhRV4
	zVkWC5HCAPQOaJCg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=vXL7kbXj;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=mWpmrCWr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729590040; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iX9v/1QecoT5tk1VC4dOytqVgZGLtbuQdPNKprehSjc=;
	b=vXL7kbXjoKCBpbPE6vNwglUNO38xXixA8tRfpKs1mOrGFBZs3VtTHRXzmVCfIfnv9HfACx
	uleoBSOTAQI8dGOt1w7kD3heKNAP3lHyEWC+yrG57NBo7dK23YsoDDAaoYjUJu9rShLqcZ
	TT8EcMJJpvPS6vJJwKCKHhYBm9Gdcg8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729590040;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iX9v/1QecoT5tk1VC4dOytqVgZGLtbuQdPNKprehSjc=;
	b=mWpmrCWrpEfBKi7OrX5Pcfbvr0/3ii/to09SWdC/cLAbSiPDoRSE0rcoOyEMqMKmmrhRV4
	zVkWC5HCAPQOaJCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 966DC13AC9;
	Tue, 22 Oct 2024 09:40:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id H3e2JBhzF2ciFAAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 22 Oct 2024 09:40:40 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 5380AA06D5; Tue, 22 Oct 2024 11:40:32 +0200 (CEST)
Date: Tue, 22 Oct 2024 11:40:32 +0200
From: Jan Kara <jack@suse.cz>
To: Mahmoud Adam <mngyadam@amazon.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, jack@suse.cz, hch@lst.de,
	sashal@kernel.org, tytso@mit.edu, linux-ext4@vger.kernel.org,
	regressions@lists.linux.dev
Subject: Re: [5.10.y] Regression in EXT3/4 with v5.10.227, LTP preadv03 is
 failing
Message-ID: <20241022094032.h5fnoqcudkxjp3vu@quack3>
References: <lrkyqy12hpikl.fsf@dev-dsk-mngyadam-1c-a2602c62.eu-west-1.amazon.com>
 <2024102130-thieving-parchment-7885@gregkh>
 <lrkyqldyhpeb5.fsf@dev-dsk-mngyadam-1c-a2602c62.eu-west-1.amazon.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <lrkyqldyhpeb5.fsf@dev-dsk-mngyadam-1c-a2602c62.eu-west-1.amazon.com>
X-Rspamd-Queue-Id: A0FD621C5E
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	MISSING_XM_UA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_SEVEN(0.00)[8];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01
X-Spam-Flag: NO

On Mon 21-10-24 19:15:58, Mahmoud Adam wrote:
> Greg KH <gregkh@linuxfoundation.org> writes:
> 
> > On Mon, Oct 21, 2024 at 05:43:54PM +0200, Mahmoud Adam wrote:
> >> 
> >> Hello,
> >> 
> >>   In the latest 5.10.227 we see LTP preadv03 failing on EXT3/4, when
> >> bisected it was found that the commit dde4c1e1663b6 ("ext4: properly
> >> sync file size update after O_SYNC direct IO") is causing it
> >> 
> >> This seems similar to what occurred before[1] and if I understand
> >> correctly it was because of missing dependency backport 936e114a245b6
> >> ("iomap: update ki_pos a little later in iomap_dio_complete") which was
> >> then backported to 5.15 & 6.1 but not to 5.10.
> >> 
> >> *This is not failing on 5.15 nor 6.1, and it does fail consistently in x86-64 & ARM
> >> 
> >> [1]: https://lore.kernel.org/all/20231205122122.dfhhoaswsfscuhc3@quack3/
> >> 
> >
> >
> > What do you suggest be done?
> >
> 
> I think as an urgent fix I would suggest reverting the mentioned commit
> and commits that depend on it from 5.10.y..
> 
> 4911610c7a1fe ("ext4: fix warning in ext4_dio_write_end_io()")
> f8a7c342326f6 ("ext4: dax: fix overflowing extents beyond inode size when partially writing")
> dde4c1e1663b6 ("ext4: properly sync file size update after O_SYNC direct
> IO")

Looks sensible to me. Another possibility would be to backport commit
936e114a245b6e3 ("iomap: update ki_pos a little later in
iomap_dio_complete") to 5.10-stable. We've done this for other stable
branches which had this issue and so far I didn't hear about any fallout
from that.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

