Return-Path: <linux-ext4+bounces-3419-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8DB893B36F
	for <lists+linux-ext4@lfdr.de>; Wed, 24 Jul 2024 17:14:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90670283132
	for <lists+linux-ext4@lfdr.de>; Wed, 24 Jul 2024 15:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8933115B122;
	Wed, 24 Jul 2024 15:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rpzh0C2E";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="p54rKvof";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rpzh0C2E";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="p54rKvof"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4727B155739;
	Wed, 24 Jul 2024 15:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721834034; cv=none; b=nM+tEj0G3Z7IG9Oyb03tP0ivtTlE1/lCrKRlZQ3rrm/ywvkPLjf3ut04o9kXiYEDhaVSxyO46FIswUepm53ZtLc5eHPcAU928Anq1tEF4G8x8jweef6a+CNUObZRwqtwW4CzjoR8cRGVZ0NI39k0nT56XJtpn4XYlcA3GyopjqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721834034; c=relaxed/simple;
	bh=SSC75iRiebvtrZGGNH3TDH4ypRixqQZ8f2epaqoruVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OHrfpAOOhjVn3ArrRCZWage8FJC5VNFKA4oB6PNPxVU6H/cPF8NX6hKlk0no/YaJmXfDAXWgXuDReuu79U/DNYXLsvWzR6X/snzFAssHeUePoD2j+/AXQOhZsJ96gBnXQYkajORDfkiBXg5CCvsVDBzd29AsOS//0DY9vC5W7oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rpzh0C2E; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=p54rKvof; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rpzh0C2E; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=p54rKvof; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 60CD721B41;
	Wed, 24 Jul 2024 15:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721834030; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=14JI4I2SJHbROZROoRQf7kBlHYGSpf27/5uVaWQA70s=;
	b=rpzh0C2E7HwjMGsOy21jTp3Z18e4xKRLfD4xSuaDYmMom/CInb8b2kS6VJ4jP3kcQZ5nuB
	4Gd8DneSeo3aCxDWuF264uCfjaJtB6qUcx9037pC/fb92f5qlVBaSxEtiUZEuQHah9Sw0b
	F0iHaN6Urfkp2VmwBeHOEAcLmNvmIvU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721834030;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=14JI4I2SJHbROZROoRQf7kBlHYGSpf27/5uVaWQA70s=;
	b=p54rKvofzOCg4ifM+vP1apODzc5GV7Oocx0vLFrUYTrVnSh6VlS/vc6WajhgM5T/vCDmS/
	eJTydsd6gPBDHCDQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=rpzh0C2E;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=p54rKvof
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721834030; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=14JI4I2SJHbROZROoRQf7kBlHYGSpf27/5uVaWQA70s=;
	b=rpzh0C2E7HwjMGsOy21jTp3Z18e4xKRLfD4xSuaDYmMom/CInb8b2kS6VJ4jP3kcQZ5nuB
	4Gd8DneSeo3aCxDWuF264uCfjaJtB6qUcx9037pC/fb92f5qlVBaSxEtiUZEuQHah9Sw0b
	F0iHaN6Urfkp2VmwBeHOEAcLmNvmIvU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721834030;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=14JI4I2SJHbROZROoRQf7kBlHYGSpf27/5uVaWQA70s=;
	b=p54rKvofzOCg4ifM+vP1apODzc5GV7Oocx0vLFrUYTrVnSh6VlS/vc6WajhgM5T/vCDmS/
	eJTydsd6gPBDHCDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 560A21324F;
	Wed, 24 Jul 2024 15:13:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jE2VFC4aoWaSMwAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 24 Jul 2024 15:13:50 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 0EE0DA08F2; Wed, 24 Jul 2024 17:13:50 +0200 (CEST)
Date: Wed, 24 Jul 2024 17:13:50 +0200
From: Jan Kara <jack@suse.cz>
To: Luis Henriques <luis.henriques@linux.dev>
Cc: Jan Kara <jack@suse.cz>, Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger@dilger.ca>,
	Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] ext4: fix incorrect tid assumption in
 ext4_fc_mark_ineligible()
Message-ID: <20240724151350.wkdxrqg6bf6jzh3t@quack3>
References: <20240723154402.21125-1-luis.henriques@linux.dev>
 <20240723154402.21125-5-luis.henriques@linux.dev>
 <20240724101504.e2t4pvgw6td7rrmm@quack3>
 <87ed7ikhva.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ed7ikhva.fsf@linux.dev>
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.81 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[7];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,mit.edu,dilger.ca,gmail.com,vger.kernel.org];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -3.81
X-Rspamd-Queue-Id: 60CD721B41

On Wed 24-07-24 15:02:49, Luis Henriques wrote:
> On Wed, Jul 24 2024, Jan Kara wrote:
> 
> > On Tue 23-07-24 16:44:02, Luis Henriques (SUSE) wrote:
> >> Function jbd2_journal_shrink_checkpoint_list() assumes that '0' is not a
> >> valid value for transaction IDs, which is incorrect.
> >> 
> >> Furthermore, the sbi->s_fc_ineligible_tid handling also makes the same
> >> assumption by being initialised to '0'.  Fortunately, the sb flag
> >> EXT4_MF_FC_INELIGIBLE can be used to check whether sbi->s_fc_ineligible_tid
> >> has been previously set instead of comparing it with '0'.
> >> 
> >> Signed-off-by: Luis Henriques (SUSE) <luis.henriques@linux.dev>
> >
> > Just one style nit below, otherwise looks good. Feel free to add:
> >
> > Reviewed-by: Jan Kara <jack@suse.cz>
> >
> > BTW, the ineligibility handling looks flaky to me, in particular the cases
> > where we call ext4_fc_mark_ineligible() with NULL handle seem racy to me as
> > fastcommit can happen *before* we mark the filesystem as ineligible.  But
> > that's not really related to your changes, they just made me look at that
> > code in detail and I couldn't resist complaining :)
> 
> Heh, fair enough.  Regarding this race, I may try to look into it but I'll
> need to dig a bit more.  And yeah it's probably better to separate that
> from this patch.

I suspect all the places that mark the fs as ineligible with NULL handle
need to actually mark corresponding transactions as ineligible using handle
instead. This is going to require a bit of churn e.g. for stuff like
resize or __track_dentry_update() but shouldn't be hard to do.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

