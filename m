Return-Path: <linux-ext4+bounces-9150-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C541B0D868
	for <lists+linux-ext4@lfdr.de>; Tue, 22 Jul 2025 13:41:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D46116181A
	for <lists+linux-ext4@lfdr.de>; Tue, 22 Jul 2025 11:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1446628A1D5;
	Tue, 22 Jul 2025 11:41:40 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B17423A98E
	for <linux-ext4@vger.kernel.org>; Tue, 22 Jul 2025 11:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753184499; cv=none; b=i44H1W7mLwwSpWYpW8a7kANK47wYJBCN7hckF+Cfakge/q/NY3nFFWK2eC5ujcYsoTLDcatsBfsTIU5QHX2Yl/Pk7pYD6MK1+M3XFQ6dApv6TTEFCnp6+UtWn0Rfn9kOGAQ2KNLSW7i+aonstXOjYzwwFj78+5u0EtD0skC3bVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753184499; c=relaxed/simple;
	bh=pWqioZeFjOsvUP9R6/AB1FTreWqsmlUowyVdySH7YGM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CBiYkZSQiPjjHQoYhOc10I58f4MsuMcQgbX/o8HTzNdyoNWO+HTvNcVregdXfKp1Bt/FYhIIX492K9+RYnsW0vFIxjMiGQB6PHpxHNrM4yCKLldmzweaMR4aKVKEVh6FuU+CFjULKEgn7Y8KveF6e0DIxtMr/6eW75Y7ugOfOts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A657321A64;
	Tue, 22 Jul 2025 11:41:35 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9AB6B13A32;
	Tue, 22 Jul 2025 11:41:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id nau/Je94f2jDSgAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 22 Jul 2025 11:41:35 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 0EDFAA0A69; Tue, 22 Jul 2025 13:41:35 +0200 (CEST)
Date: Tue, 22 Jul 2025 13:41:35 +0200
From: Jan Kara <jack@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Cc: linux-ext4@vger.kernel.org, ltp@lists.linux.it, 
	Cyril Hrubis <chrubis@suse.cz>, Theodore Ts'o <tytso@mit.edu>, 
	Andreas Dilger <adilger.kernel@dilger.ca>, Jan Kara <jack@suse.com>
Subject: Re: [LTP] [PATCH 1/1] ioctl_ficlone03.c: Support test on more
 filesystems
Message-ID: <azo7y22pblcngf6y5xkzda5cew4p3kxylfse7i32hixjtld2mh@ml2bonivmpbe>
References: <20250326142259.50981-1-pvorel@suse.cz>
 <aHEccDO8lJiTzbEs@yuki.lan>
 <20250722102346.GA6890@pevik>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250722102346.GA6890@pevik>
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: A657321A64
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.00

Hi!

On Tue 22-07-25 12:23:46, Petr Vorel wrote:
> ...
> > >  static void setup(void)
> 
> > I find it strange that we manage to set the FS_IMMUTABLE_FL in the setup
> > with the FS_IOC_SETFLAGS without any error. Maybe it would make sense to
> > check with ext devs what is going on here.
> 
> > > @@ -117,6 +123,10 @@ static struct tst_test test = {
> > >  			.mkfs_ver = "mkfs.xfs >= 1.5.0",
> > >  			.mkfs_opts = (const char *const []) {"-m", "reflink=1", NULL},
> > >  		},
> > > +		{.type = "ext2"},
> > > +		{.type = "ext3"},
> > > +		{.type = "ext4"},
> > > +		{.type = "tmpfs"},
> > >  		{}
> 
> While I was working on extending [1] LTP ioctl_ficlone03.c to run on more
> filesystems [2], I found that ext[2-4] don't support FS_IMMUTABLE_FL.

Why do you think FS_IMMUTABLE_FL is unsupported? ext2 was the filesystem
actually introducing it to the kernel ;)

> 	immut_fd = open(MNTPOINT"/immutable", O_CREAT | O_RDWR, 0640);
> 	mnt_file = open(MNTPOINT"/file", O_CREAT | O_RDWR, 0640);
> 	int attr = FS_IMMUTABLE_FL;
> 	ioctl(immut_fd, FS_IOC_SETFLAGS, &attr);
> 	...
> 
> 	struct file_clone_range *clone_range;
> 	ioctl(immut_fd, FICLONE, mnt_file),
> 	ioctl(immut_fd, FICLONERANGE, clone_range),
> 
> The last two ioctl() with FICLONE and FICLONERANGE get errno EOPNOTSUPP
> (instead of EPERM as on other fs). Cyril raised concern [3], why first
> ioctl() FS_IOC_SETFLAGS even works. Shouldn't it also gets EINVAL as
> vfat, exfat and ntfs get?

Unlink FICLONE and FICLONERANGE which are indeed unsupported on any ext?
based filesystem so EOPNOTSUPP seems like a correct answer to me.
So I'm confused where you see a problem.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

