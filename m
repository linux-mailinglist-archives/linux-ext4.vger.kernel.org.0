Return-Path: <linux-ext4+bounces-4047-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F5EB96BA06
	for <lists+linux-ext4@lfdr.de>; Wed,  4 Sep 2024 13:17:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBE76285EDF
	for <lists+linux-ext4@lfdr.de>; Wed,  4 Sep 2024 11:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59FE11D4169;
	Wed,  4 Sep 2024 11:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vmV8OQ09";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="fMXtvkd8";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="G6nSpGsq";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="HPKstyY4"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021E01D2235;
	Wed,  4 Sep 2024 11:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725448463; cv=none; b=fh7gdD8GYCOyQi4C6BvsuHB5xkdYigxfNEHD5M4eg53xNb07QzjHCrBIJ1qj65nSq7pBWT9sMJr98AjkPCVXrqsnQ4eK6m5S8ToBfFD332IEjASBjJvjRaA3D7wmUo9CHtA1+qLy7IetHvnVe4EBRIyK22yRdHJF4b5G7lcZMJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725448463; c=relaxed/simple;
	bh=AjjPgpJzo2eKfimYCkqQOMZHOdwRWbumpxASTKp4IYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=itJwn+LhXDNLxTCd+AlvYKKqTwUjIfZzWRGP7iZT22ellGTGG3frD5EcHH80Lt3OOatbb9WCp3glSEV60LU/yiwCMIDpnZnt/HXxMXsimwQbpRTyVrsIUIo3CezRUV55a4GcQZFBtJCHDwRQOKdV/Oi44sOlaHDwgs4Ovds7E1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vmV8OQ09; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=fMXtvkd8; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=G6nSpGsq; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=HPKstyY4; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EFBB421995;
	Wed,  4 Sep 2024 11:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725448460; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Oopo4gGEFFQxxuBDcyFPfasP6UTSXH8j8+SKkx6xPAQ=;
	b=vmV8OQ09lxbEo00aY3zPtJmzTN0y3VV9rV66C6zZU1Imofx8t1d/nP1BoCr9+5rZ3CjczU
	oOPUZDqrwxRz2PFoNqqunxdxj8TaO9vMOh0lQoMunXXdmKzu5n+xrm3Z8Rz6fUDFOS5QrV
	/g9Mnl55u29hyRTYfCwPoifSsjQyef8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725448460;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Oopo4gGEFFQxxuBDcyFPfasP6UTSXH8j8+SKkx6xPAQ=;
	b=fMXtvkd8E3gcTJlJZgciJ07Yel8BeSq2D4KFEWQNQIwF1xMSoZrKum68Rzj/PstcAzg+4c
	dOgIATSGhWmsaOBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725448459; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Oopo4gGEFFQxxuBDcyFPfasP6UTSXH8j8+SKkx6xPAQ=;
	b=G6nSpGsqOjxF68BDMygQDOkgO8m1S3FJ2EfMl0rRQxSQ7dsuT8ZBNwmnDiLzdkZVqW4w94
	mITlKuhkzj4nyvRVYOvj4ShCUWWcfZIRpsmUo9QAx+38dicAN0/2fjozUpJOwMKNQPGqWC
	A9X5BJGQ0vo/Bvbh1bq9eAwYMEiAKs8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725448459;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Oopo4gGEFFQxxuBDcyFPfasP6UTSXH8j8+SKkx6xPAQ=;
	b=HPKstyY4Gz0HuPF2bf6qBOsPKYcq1yURARK+MuBEMtiQnVX2NKvVETcC5qJtqZs8YgAVOs
	4Qt8ZX/Mucg7oAAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E33AC139E2;
	Wed,  4 Sep 2024 11:14:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2+WCNwtB2GbENwAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 04 Sep 2024 11:14:19 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 90B11A0968; Wed,  4 Sep 2024 13:14:15 +0200 (CEST)
Date: Wed, 4 Sep 2024 13:14:15 +0200
From: Jan Kara <jack@suse.cz>
To: syzbot <syzbot+c28d8da3e83b3cc68dc6@syzkaller.appspotmail.com>
Cc: jack@suse.cz, jack@suse.com, linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
	tytso@mit.edu
Subject: Re: [syzbot] [ext4?] kernel BUG in jbd2_journal_dirty_metadata
Message-ID: <20240904111415.eo22zmhpggdavlzj@quack3>
References: <20240904110644.g52vgotsmi4lm56c@quack3>
 <000000000000b8b0b30621492b9d@google.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000b8b0b30621492b9d@google.com>
X-Spam-Score: -1.30
X-Spamd-Result: default: False [-1.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=996585887acdadb3];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_RCPT(0.00)[c28d8da3e83b3cc68dc6];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

On Wed 04-09-24 04:06:50, syzbot wrote:
> > On Tue 03-09-24 21:50:20, syzbot wrote:
> >> syzbot found the following issue on:
> >> 
> >> HEAD commit:    fb24560f31f9 Merge tag 'lsm-pr-20240830' of git://git.kern..
> >> git tree:       upstream
> >> console output: https://syzkaller.appspot.com/x/log.txt?x=1739530b980000
> >> kernel config:  https://syzkaller.appspot.com/x/.config?x=996585887acdadb3
> >> dashboard link: https://syzkaller.appspot.com/bug?extid=c28d8da3e83b3cc68dc6
> >> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> >> 
> >> Unfortunately, I don't have any reproducer for this issue yet.
> >> 
> >> Downloadable assets:
> >> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-fb24560f.raw.xz
> >> vmlinux: https://storage.googleapis.com/syzbot-assets/2d39db26a2bc/vmlinux-fb24560f.xz
> >> kernel image: https://storage.googleapis.com/syzbot-assets/8910481ae16e/bzImage-fb24560f.xz
> >> 
> >> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> >> Reported-by: syzbot+c28d8da3e83b3cc68dc6@syzkaller.appspotmail.com
> >> 
> >> loop0: detected capacity change from 0 to 32768
> >> =======================================================
> >> WARNING: The mand mount option has been deprecated and
> >>          and is ignored by this kernel. Remove the mand
> >>          option from the mount to silence this warning.
> >> =======================================================
> >> ocfs2: Mounting device (7,0) on (node local, slot 0) with ordered data mode.
> >> loop0: detected capacity change from 32768 to 0
> >> syz.0.0: attempt to access beyond end of device
> >> loop0: rw=0, sector=10576, nr_sectors = 1 limit=0
> >> (syz.0.0,5108,0):__ocfs2_xattr_set_value_outside:1385 ERROR: status = -5
> >
> > Looks like ocfs2 issue, not ext4.
> >
> > #syz set ocfs2

#syz set subsystems: ocfs2

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

