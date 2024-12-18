Return-Path: <linux-ext4+bounces-5751-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 55AD99F6CBE
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Dec 2024 18:57:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF0B61889E1A
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Dec 2024 17:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34AC31FA8E7;
	Wed, 18 Dec 2024 17:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="IO77DBBm";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="HOAdHZ33";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="nB1BKta+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="P9IEKNc3"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17AB31FA270;
	Wed, 18 Dec 2024 17:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734544642; cv=none; b=t5L9rtLs+T4R2MiMsmPUf04Oeb6GHhQXbHW+zvGfYK6UNDrEPbqO90Q6ZRTgPphw2Vaf8Sp4Z1IrGB5FqTSgRa0C58TcY4b7kioUrxAa4EPDVZZJeJo78P20zkSctlIkT6uf3hAkH4gVUvSVME55+bP7i2Qe4AViWK6CdAkn08g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734544642; c=relaxed/simple;
	bh=dZ+oMhl/6klOgFGKC1TlP6cXwmL7PaSbcK0Ao/KrHzc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M9FdZwdoYGMIs5FvtkYOkErzKmUO0b7m2xryeHSS8bPSutNRoBiY95DLMhun0zskZ15vGUu6Xy3xJkYroDOXmRFR/CvHWZmNmi6Q2gZUjFA2dhhsAmmkaKY4JV3iwU2VFtnT8acrn2+cew9ghqWtiA8NenfduHNDs0G5keGpgso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=IO77DBBm; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=HOAdHZ33; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=nB1BKta+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=P9IEKNc3; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 69D3F1F396;
	Wed, 18 Dec 2024 17:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1734544639;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vyqu7+5hM/O675sj05pWPBOwQ7+qTbm8DFtagxH8B5Q=;
	b=IO77DBBmmo5IO25PJrBaW1lyPFyCmVO8hLEPKALr12BYpfqkYO/bb3vgdMywsPBXup+xBP
	FJLnDqac5cvPRZX4/MEL8vT5n51dlT8En9MGRZ17P+ITF34jzEpJ1qjTNyrlyd+QatfYF1
	K1vqsXLNAa5VaP25DnSEQOVuBbX3UH0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1734544639;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vyqu7+5hM/O675sj05pWPBOwQ7+qTbm8DFtagxH8B5Q=;
	b=HOAdHZ33gN4tFOuq97/OBFU7nh4aGK0FWIMyPlAAfa4KRFs8PB4Gs7sgZN6ccOmhUTtfOz
	66iKvb1mJbGUceCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1734544638;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vyqu7+5hM/O675sj05pWPBOwQ7+qTbm8DFtagxH8B5Q=;
	b=nB1BKta+MmBC9c0Kpsz50liSlps+HsuojVZC0wflIhcBOXENIN0L/Oejmg0NzoeyFe9b1L
	iubN0btzwaaHrtJQNK+PM5wib5PXgOpsSagwv7R6ZpupWea6dR+CjuWtoCo5NL8k+lyvQI
	1qPESaLcXU2nHwf8vO1tSkmC6flNVf8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1734544638;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vyqu7+5hM/O675sj05pWPBOwQ7+qTbm8DFtagxH8B5Q=;
	b=P9IEKNc38XOWAd9vPBDvgmOteNTo+CrsYoclclFQc9IPKjDX/l7EZyaF0+APk1SH+/UQR2
	I0LDEo23Ur7WD8Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 479AC137CF;
	Wed, 18 Dec 2024 17:57:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hXXuEP4MY2e/ZAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 18 Dec 2024 17:57:18 +0000
Date: Wed, 18 Dec 2024 18:57:16 +0100
From: David Sterba <dsterba@suse.cz>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: qemu-devel@nongnu.org, open list <linux-kernel@vger.kernel.org>,
	Linux Regressions <regressions@lists.linux.dev>,
	linux-ext4 <linux-ext4@vger.kernel.org>,
	lkft-triage@lists.linaro.org, linux-mm <linux-mm@kvack.org>,
	Linux btrfs <linux-btrfs@vger.kernel.org>,
	Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
	Anders Roxell <anders.roxell@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Dan Carpenter <dan.carpenter@linaro.org>, Qu Wenruo <wqu@suse.com>,
	David Sterba <dsterba@suse.com>
Subject: Re: qemu-arm64: CONFIG_ARM64_64K_PAGES=y kernel crash on qemu-arm64
 with Linux next-20241210 and above
Message-ID: <20241218175716.GD31418@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <CA+G9fYvf0YQw4EY4gsHdQ1gCtSgQLPYo8RGnkbo=_XnAe7ORhw@mail.gmail.com>
 <CA+G9fYv7_fMKOxA8DB8aUnsDjQ9TX8OQtHVRcRQkFGqdD0vjNQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYv7_fMKOxA8DB8aUnsDjQ9TX8OQtHVRcRQkFGqdD0vjNQ@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Wed, Dec 18, 2024 at 09:22:26PM +0530, Naresh Kamboju wrote:
> On Wed, 18 Dec 2024 at 17:33, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
> >
> > The following kernel crash noticed on qemu-arm64 while running the
> > Linux next-20241210 tag (to next-20241218) kernel built with
> >  - CONFIG_ARM64_64K_PAGES=y
> >  - CONFIG_ARM64_16K_PAGES=y
> > and running LTP smoke tests.
> >
> > First seen on Linux next-20241210.
> >   Good: next-20241209
> >   Bad:  next-20241210 and next-20241218
> >
> > qemu-arm64: 9.1.2
> >
> > Anyone noticed this ?
> >
> 
> Anders bisected this reported regression and found,
> # first bad commit:
>   [9c1d66793b6faa00106ae4c866359578bfc012d2]
>   btrfs: validate system chunk array at btrfs_validate_super()

Thanks, I'll drop the patch from linux-next for now.

