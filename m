Return-Path: <linux-ext4+bounces-1652-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE52587C26F
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Mar 2024 19:12:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BAA81C21325
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Mar 2024 18:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3DF574BFB;
	Thu, 14 Mar 2024 18:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Zuah9+n/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="98NEdqPy";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Zuah9+n/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="98NEdqPy"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6401A38EC
	for <linux-ext4@vger.kernel.org>; Thu, 14 Mar 2024 18:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710439935; cv=none; b=WNlyDw+WrRyWZ3c81QUXxZ4MNIonJU27ledNBoZGOmpgdDWIInHePEE7jaS1+Dr7/dKEw6ZshQ3cbn8iZLYRZIcvJHpw8/fy+riEUlceOVrAzHP8SbINDBGNqBtiQponQl2LPRAVkjKXSv9x2Qh3UcKXuXyP0aE5Gc1bwMMCqiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710439935; c=relaxed/simple;
	bh=I3RsAzEiN+D2JxK3362Z5SAwxf1kR3mQuFfUVqEThB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ep0EnwRemsR4jwwTY3ITWrcyi4mLnggUIouQ1CpeNYCT5442UZSJ+apd61XaBFgftFFpaiVfH1VzpD+epFns5TkI56qBywmJMudWz0pf2Z3owOcVZ3gceZyHEaK67FtI7HkHjAhgYn9fSM2TDpOPbaET6S4yFP4yVplYq6vyHLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Zuah9+n/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=98NEdqPy; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Zuah9+n/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=98NEdqPy; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7F9181F893;
	Thu, 14 Mar 2024 18:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710439924; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wnjOmLO3dTDNSu+w7TnTHKL7kmqQPx7WGrTR993wbEo=;
	b=Zuah9+n/0MoMKFsbbjG5tjAtZunda5enfoLJb/TNeE/nmmeYgEA7raCF9EJk4Jbef0UEnr
	/a8MahPykmysUhDc3KC+RA+iabuncp44xvcbWbLhk/g1h242cCY1ChHPo/c5bHLRgbYls5
	+SLPupBjmeuKUUWlResvBLJI6uC3bwk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710439924;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wnjOmLO3dTDNSu+w7TnTHKL7kmqQPx7WGrTR993wbEo=;
	b=98NEdqPyRBLS4QrewM4H+jSDOPAAGjLatFjIrPkww7mEzEo4NSub3hgtzlbmJwyLiEXTnw
	T3N7roehfG+xeaBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710439924; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wnjOmLO3dTDNSu+w7TnTHKL7kmqQPx7WGrTR993wbEo=;
	b=Zuah9+n/0MoMKFsbbjG5tjAtZunda5enfoLJb/TNeE/nmmeYgEA7raCF9EJk4Jbef0UEnr
	/a8MahPykmysUhDc3KC+RA+iabuncp44xvcbWbLhk/g1h242cCY1ChHPo/c5bHLRgbYls5
	+SLPupBjmeuKUUWlResvBLJI6uC3bwk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710439924;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wnjOmLO3dTDNSu+w7TnTHKL7kmqQPx7WGrTR993wbEo=;
	b=98NEdqPyRBLS4QrewM4H+jSDOPAAGjLatFjIrPkww7mEzEo4NSub3hgtzlbmJwyLiEXTnw
	T3N7roehfG+xeaBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 727EA1368C;
	Thu, 14 Mar 2024 18:12:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id G7yxG/Q982VRXwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 14 Mar 2024 18:12:04 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 0D78FA07D9; Thu, 14 Mar 2024 19:12:04 +0100 (CET)
Date: Thu, 14 Mar 2024 19:12:04 +0100
From: Jan Kara <jack@suse.cz>
To: Theodore Ts'o <tytso@mit.edu>
Cc: Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org,
	syzbot+a43d4f48b8397d0e41a9@syzkaller.appspotmail.com
Subject: Re: [PATCH 2/3] ext4: Do not create EA inode under buffer lock
Message-ID: <20240314181204.shdck2lv4v7ogdzj@quack3>
References: <20240209111418.22308-1-jack@suse.cz>
 <20240209112107.10585-2-jack@suse.cz>
 <20240229155917.GA1146088@mit.edu>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240229155917.GA1146088@mit.edu>
X-Spam-Score: -0.02
X-Spamd-Result: default: False [-0.02 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_HAM(-0.72)[83.64%];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[a43d4f48b8397d0e41a9];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Flag: NO

On Thu 29-02-24 10:59:17, Theodore Ts'o wrote:
> On Fri, Feb 09, 2024 at 12:21:00PM +0100, Jan Kara wrote:
> > ext4_xattr_set_entry() creates new EA inodes while holding buffer lock
> > on the external xattr block. This is problematic as it nests all the
> > allocation locking (which acquires locks on other buffers) under the
> > buffer lock. This can even deadlock when the filesystem is corrupted and
> > e.g. quota file is setup to contain xattr block as data block. Move the
> > allocation of EA inode out of ext4_xattr_set_entry() into the callers.
> > 
> > Reported-by: syzbot+a43d4f48b8397d0e41a9@syzkaller.appspotmail.com
> > Signed-off-by: Jan Kara <jack@suse.cz>
> 
> In my testing I've found that this is causing a regression for
> ext4/026 in the encrypt configuration.  This can be replicated using
> "kvm-xfstests -c encrypt ext4/026.   Logs follow below.
> 
> I'll try to take a closer look, but I may end up deciding to drop this
> patch or possible the whole patch series until we can figure out
> what's going on.

OK, I've found the problem. I'll rebase patches on top of rc1 when it
happens and send fixed version. Thanks for catching this!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

