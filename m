Return-Path: <linux-ext4+bounces-8516-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B843EADF16A
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Jun 2025 17:30:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 070AE1896A34
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Jun 2025 15:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 929642EAB84;
	Wed, 18 Jun 2025 15:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bKeuBENT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="P0w3gLC7";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sTZCOPFV";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="QuggbyRu"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF921ADC98
	for <linux-ext4@vger.kernel.org>; Wed, 18 Jun 2025 15:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750260648; cv=none; b=fRd+SNWqgIbwaP74Hfg9trIR4YLUct2FaJsNAW72GT+CYYTKcoX0tYKJSc5vs1bCO7hN3hEt5V42UGEte8uOGjb1RM2aOwbFWgoXftV37jTjslZaHZS8kJNZ3r5IVfNlEpDKCai0JF3iKjmQrSsvmRqGW66DfSPo9Ub+8VrxKqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750260648; c=relaxed/simple;
	bh=wzNkVNuyHBoPhvXS39tjekTxJ+C0955IXG43RX8sbdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FxcSRd8o4TgcNR4lb+alJr0+yvXEiZevhxogIa4t7YRYmxUq/Io5eEMvz4ep6IgoDGlxIyfZWyX8HqWtgQYzKfqATTrGudol+OdQr8ZqChVTTZxbaPVPUHFOcf1QBeeWIhBTz840RPVyXNVMJaJFLLWg2YCvKl0d+But+33zZKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=bKeuBENT; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=P0w3gLC7; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=sTZCOPFV; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=QuggbyRu; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 87BBC1F7BD;
	Wed, 18 Jun 2025 15:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750260644; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dmp0pn+7P2LeB8jcZl16lNsb0uNmv7UC9EUciykSHOM=;
	b=bKeuBENTtuRzHSrmLB9oq5NGBwBk86tTVsm1ECVqQrGG0m6PLxnsp8EXYskLBQaZpbB9kn
	iwcwvx4UfnZp0uqqN7oNFwE80qe8h1eKF8A6RGke7iLkhWV/qT+bd0aZo/Yqyr8A42qOfD
	2LDwbiYFUjjE6pNiZ77n7+ZeOrpQryI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750260644;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dmp0pn+7P2LeB8jcZl16lNsb0uNmv7UC9EUciykSHOM=;
	b=P0w3gLC7Hsrfp2BTJ7kcEslvGBeew1pxgM9ul+w9ZRr72OkffGhrdb6rAyz3PwPRSGKFaP
	g7BEDU8Rkf1vqmDw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=sTZCOPFV;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=QuggbyRu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750260643; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dmp0pn+7P2LeB8jcZl16lNsb0uNmv7UC9EUciykSHOM=;
	b=sTZCOPFVtBT5AeJjssSfP/ldNG2stJf3De1d/CrkG1eNi1E/9Vn1Oc9HLIZqesDePZ3QUR
	VSnwrH3oZbRfuWmvBlShFC022KQkRqrg6e5FTPAa1NBfY7mXDuX6JllGffsDzkaztqIcpJ
	h99vrNmqhaQYAKltCBLQjUGVgGnA4mM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750260643;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dmp0pn+7P2LeB8jcZl16lNsb0uNmv7UC9EUciykSHOM=;
	b=QuggbyRu+J+MBUcITzRl3au0HBDbz6AfT6MHcI8eFHxNWgCkQmUTnDewBsIB8AqnhnTUxG
	sCn/v6e5ATWn9tDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 67CAC13A3F;
	Wed, 18 Jun 2025 15:30:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zGxTGaPbUmhwEwAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 18 Jun 2025 15:30:43 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 0AE2CA09DC; Wed, 18 Jun 2025 17:30:43 +0200 (CEST)
Date: Wed, 18 Jun 2025 17:30:42 +0200
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Theodore Ts'o <tytso@mit.edu>, 
	Sasha Levin <sashal@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	linux-ext4@vger.kernel.org, ltp@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 5.15 0/2] fix LTP regression in fanotify22
Message-ID: <x73m64odktyusdo2vueir7cltop7jbzwdammlppqslust6phbf@vynaswrrk4tt>
References: <20250617210956.146158-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250617210956.146158-1-amir73il@gmail.com>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 87BBC1F7BD
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -4.01

Hi!

On Tue 17-06-25 23:09:54, Amir Goldstein wrote:
> I noticed that fanotify22, the FAN_FS_ERROR test has regressed in the
> 5.15.y stable tree.
> 
> This is because commit d3476f3dad4a ("ext4: don't set SB_RDONLY after
> filesystem errors") was backported to 5.15.y and the later Fixes
> commit could not be cleanly applied to 5.15.y over the new mount api
> re-factoring.
> 
> I am not sure it is critical to fix this regression, because it is
> mostly a regression in a test feature, but I think the backport is
> pretty simple, although I could be missing something.
> 
> Please ACK if you agree that this backport should be applied to 5.15.y.

Yes, I think these are fine to pull into 5.15 kernels...

								Honza

> 
> Thanks,
> Amir.
> 
> Amir Goldstein (2):
>   ext4: make 'abort' mount option handling standard
>   ext4: avoid remount errors with 'abort' mount option
> 
>  fs/ext4/ext4.h  |  1 +
>  fs/ext4/super.c | 15 +++++++++------
>  2 files changed, 10 insertions(+), 6 deletions(-)
> 
> -- 
> 2.47.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

