Return-Path: <linux-ext4+bounces-9151-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11BAFB0DBB0
	for <lists+linux-ext4@lfdr.de>; Tue, 22 Jul 2025 15:52:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9FFD3B78AB
	for <lists+linux-ext4@lfdr.de>; Tue, 22 Jul 2025 13:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2FB02EA743;
	Tue, 22 Jul 2025 13:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cJbNamUS";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="FK+eNgqK";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cJbNamUS";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="FK+eNgqK"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49F22EA735
	for <linux-ext4@vger.kernel.org>; Tue, 22 Jul 2025 13:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753192255; cv=none; b=GwWtizsz9iyTE8ZVyKasHQHrhHaKGGBm9RK2yGVnGcwn3wVArdfHUOJvpIMRfWEV0E8Zp0qx0Szx1kQyzR6BDnHNytS3RdACf6coH/9Y7e3UV2DjyGtHTe+bv7ZxId6V+eEpvToV8LF9xW5Ei/QLmEeB1N/WUNJM7lw9t1O5iG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753192255; c=relaxed/simple;
	bh=TYC3FXtFQP1iqu+l/wNK/OzGc3vTTU7cxlzLkdChvKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RLU5r4pNNEeTsGEh7NjlTHXQFZvX75iLh/ySYuSKbcj0NxchSs8cpW4WCiDOABP7XPh2izUINhg58LXuphu3buZ6q4LeIL8Wb+DsOpJs9lVz8GPj8+2BKOtI8TCnjOpl8WRzTpPKfHCF/iuk4v5hblI9609k0gTy0sG2mllCjW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=cJbNamUS; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=FK+eNgqK; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=cJbNamUS; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=FK+eNgqK; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7523C2121A;
	Tue, 22 Jul 2025 13:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1753192251;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DgeJXPfYMI3yalQSdZxfZdgdWFe+DHRFpjFSkmFBoSY=;
	b=cJbNamUSEo3n1ITQEAGXILii0szuLPGe9ZjAMdVgqb/eHFkojjrKF9yHA4AAFAxXvLL4kP
	vPJN06Zbx6XWeDvAwKBlqSXqGCZ8c67AeHV7PqhyaGtV3UIhVih2VLdwqY3Hw7mfWPzw/N
	Xu1ORQzH0jY2R7OG4o/EV1rYwtiffaw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1753192251;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DgeJXPfYMI3yalQSdZxfZdgdWFe+DHRFpjFSkmFBoSY=;
	b=FK+eNgqKNahipJtLYLp2pa/MTCNSXK6vVlaBK5G7OJLW39MGuz88W0boJsENRh4PwLbw6P
	FSpW5Aw0b8s4HQAA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=cJbNamUS;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=FK+eNgqK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1753192251;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DgeJXPfYMI3yalQSdZxfZdgdWFe+DHRFpjFSkmFBoSY=;
	b=cJbNamUSEo3n1ITQEAGXILii0szuLPGe9ZjAMdVgqb/eHFkojjrKF9yHA4AAFAxXvLL4kP
	vPJN06Zbx6XWeDvAwKBlqSXqGCZ8c67AeHV7PqhyaGtV3UIhVih2VLdwqY3Hw7mfWPzw/N
	Xu1ORQzH0jY2R7OG4o/EV1rYwtiffaw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1753192251;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DgeJXPfYMI3yalQSdZxfZdgdWFe+DHRFpjFSkmFBoSY=;
	b=FK+eNgqKNahipJtLYLp2pa/MTCNSXK6vVlaBK5G7OJLW39MGuz88W0boJsENRh4PwLbw6P
	FSpW5Aw0b8s4HQAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4135113A32;
	Tue, 22 Jul 2025 13:50:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uHVODjuXf2h4GwAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Tue, 22 Jul 2025 13:50:51 +0000
Date: Tue, 22 Jul 2025 15:50:49 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Jan Kara <jack@suse.cz>
Cc: linux-ext4@vger.kernel.org, ltp@lists.linux.it,
	Cyril Hrubis <chrubis@suse.cz>, Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>, Jan Kara <jack@suse.com>
Subject: Re: [LTP] [PATCH 1/1] ioctl_ficlone03.c: Support test on more
 filesystems
Message-ID: <20250722135049.GB84869@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20250326142259.50981-1-pvorel@suse.cz>
 <aHEccDO8lJiTzbEs@yuki.lan>
 <20250722102346.GA6890@pevik>
 <azo7y22pblcngf6y5xkzda5cew4p3kxylfse7i32hixjtld2mh@ml2bonivmpbe>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <azo7y22pblcngf6y5xkzda5cew4p3kxylfse7i32hixjtld2mh@ml2bonivmpbe>
X-Spamd-Result: default: False [-3.71 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	HAS_REPLYTO(0.30)[pvorel@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	REPLYTO_EQ_FROM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 7523C2121A
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.71

Hi Jan, all,

> Hi!

> On Tue 22-07-25 12:23:46, Petr Vorel wrote:
> > ...
> > > >  static void setup(void)

> > > I find it strange that we manage to set the FS_IMMUTABLE_FL in the setup
> > > with the FS_IOC_SETFLAGS without any error. Maybe it would make sense to
> > > check with ext devs what is going on here.

> > > > @@ -117,6 +123,10 @@ static struct tst_test test = {
> > > >  			.mkfs_ver = "mkfs.xfs >= 1.5.0",
> > > >  			.mkfs_opts = (const char *const []) {"-m", "reflink=1", NULL},
> > > >  		},
> > > > +		{.type = "ext2"},
> > > > +		{.type = "ext3"},
> > > > +		{.type = "ext4"},
> > > > +		{.type = "tmpfs"},
> > > >  		{}

> > While I was working on extending [1] LTP ioctl_ficlone03.c to run on more
> > filesystems [2], I found that ext[2-4] don't support FS_IMMUTABLE_FL.

> Why do you think FS_IMMUTABLE_FL is unsupported? ext2 was the filesystem
> actually introducing it to the kernel ;)

Lol, I should have git grep kernel sources and google before asking silly
question :). Thanks for correcting me.

> > 	immut_fd = open(MNTPOINT"/immutable", O_CREAT | O_RDWR, 0640);
> > 	mnt_file = open(MNTPOINT"/file", O_CREAT | O_RDWR, 0640);
> > 	int attr = FS_IMMUTABLE_FL;
> > 	ioctl(immut_fd, FS_IOC_SETFLAGS, &attr);
> > 	...

> > 	struct file_clone_range *clone_range;
> > 	ioctl(immut_fd, FICLONE, mnt_file),
> > 	ioctl(immut_fd, FICLONERANGE, clone_range),

> > The last two ioctl() with FICLONE and FICLONERANGE get errno EOPNOTSUPP
> > (instead of EPERM as on other fs). Cyril raised concern [3], why first
> > ioctl() FS_IOC_SETFLAGS even works. Shouldn't it also gets EINVAL as
> > vfat, exfat and ntfs get?

> Unlink FICLONE and FICLONERANGE which are indeed unsupported on any ext?
> based filesystem so EOPNOTSUPP seems like a correct answer to me.
> So I'm confused where you see a problem.

Thanks for info, obviously there is no problem now :).
I'll amend the commit message before merge that FICLONE and FICLONERANGE are not
supported (not FS_IMMUTABLE_FL).

Kind regards,
Petr

> 								Honza

