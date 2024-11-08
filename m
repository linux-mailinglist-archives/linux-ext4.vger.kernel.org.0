Return-Path: <linux-ext4+bounces-5007-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A61C9C1BDC
	for <lists+linux-ext4@lfdr.de>; Fri,  8 Nov 2024 12:08:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DECE4281771
	for <lists+linux-ext4@lfdr.de>; Fri,  8 Nov 2024 11:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E5B91E32A6;
	Fri,  8 Nov 2024 11:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="27y1htOn";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="oUPEm/TJ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="c6NUgwkK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="apnO0UV1"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239231E22FD;
	Fri,  8 Nov 2024 11:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731064104; cv=none; b=DU84ofjuwJd9tc7guQkgPqLJ/SBmWqbvw5Bs203TA9h+3S7YRTg3BwBw/tvTreUFppiTu9p25HUrGFUl1sdXEfgrwXRDGfiMfV5lIVKq5F2HiWqY9sCv1HJkeQfPFxMtWcnGh8nfgb19LqyMZu9q0FkOEdNGFdK721yJOvDQeB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731064104; c=relaxed/simple;
	bh=Bhn6OLhrtVpvudY+i414MJifpOgv7kqE1NRk9RgBSUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iOM4GyreBMIEehisAo8Q5jNlmHEjKjfrowtRnG5SFIr88o2W5DuOS1fuP2zzp2IszpY/8WBQaeVB20wcTgAQMoP3tsnJbt5ei+PtCT3AzuU9otk9PONxX4gZ2B8q48A518yIHPVWxpOJaDwDtuM3oFyf56fNUbqQ7DqhjTGUNXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=27y1htOn; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=oUPEm/TJ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=c6NUgwkK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=apnO0UV1; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 703D521E05;
	Fri,  8 Nov 2024 11:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731064100; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BIxOZRCrquIXgIxNtQyqvlqv0UgBsCwgmyLXRJKzxgI=;
	b=27y1htOnH/RA0zPOahtMqgB8ooJwWkmkw0XOSWCTYs9mMPeOT0Esbw+CSy2ScyZnEIuB+9
	tUx/qjniY1RyvwhnyTzU8FVTDzgqnCxeZREmB2GDmLvr7xUdLX+5f6In0gQ6tTW5AwN//8
	UGQKnJfmaj7E5WcNKzANC3s6wgl/8HQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731064100;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BIxOZRCrquIXgIxNtQyqvlqv0UgBsCwgmyLXRJKzxgI=;
	b=oUPEm/TJEmDTXjwrTjTR1TfaisiM7i7vY/2QadGt0bEAF51W1mH/Ii5cuFS7zYPcIWvo7R
	XBYpe0ttOrCAn/Aw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731064099; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BIxOZRCrquIXgIxNtQyqvlqv0UgBsCwgmyLXRJKzxgI=;
	b=c6NUgwkKBCfThM3kTVwOWTJGFhbCqfsn9cH5Ln4Q5nTf3zf0hZ1p5mNCmxDQ8n8MXyrl+D
	qeVWvpgQZ4Mpd8NugdmqQuRlTtLDAqNsNm5HnY7KdaX+EN82LC3Ycgtc4/IS/mWAdAFO8a
	YMyTHAq6qO+c1fwLT2glUS0jMXgAkZQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731064099;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BIxOZRCrquIXgIxNtQyqvlqv0UgBsCwgmyLXRJKzxgI=;
	b=apnO0UV17a6tNaUEJsy44QlPjCLHwqz/7GpeDm4YD8NEG2i7yOYlz/sdiWJof931f/hnRM
	jY1Ke7o7hBD9rHDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 62BD21394A;
	Fri,  8 Nov 2024 11:08:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6SgbGCPxLWcCQwAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 08 Nov 2024 11:08:19 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 1C97DA0AF4; Fri,  8 Nov 2024 12:08:15 +0100 (CET)
Date: Fri, 8 Nov 2024 12:08:15 +0100
From: Jan Kara <jack@suse.cz>
To: Daniel =?utf-8?B?TWFydMOtbiBHw7NtZXo=?= <dalme@riseup.net>
Cc: Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.com>,
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] jbd2: Fix comment describing journal_init_common()
Message-ID: <20241108110815.pjqgf4dqxq4was2f@quack3>
References: <20241107144538.3544-1-dalme@riseup.net>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241107144538.3544-1-dalme@riseup.net>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

On Thu 07-11-24 15:45:38, Daniel Martín Gómez wrote:
> The code indicates that journal_init_common() fills the journal_t object
> it returns while the comment incorrectly states that only a few fields are
> initialised. Also, the comment claims that journal structures could be
> created from scratch which isn't possible as journal_init_common() calls
> journal_load_superblock() which loads and checks journal superblock from
> disk.
> 
> Signed-off-by: Daniel Martín Gómez <dalme@riseup.net>

Indeed. Thanks for fixing this up. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/jbd2/journal.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> index 97f487c3d8fc..3c1d42133687 100644
> --- a/fs/jbd2/journal.c
> +++ b/fs/jbd2/journal.c
> @@ -1518,9 +1518,10 @@ static int journal_load_superblock(journal_t *journal)
>   * destroy journal_t structures, and to initialise and read existing
>   * journal blocks from disk.  */
>  
> -/* First: create and setup a journal_t object in memory.  We initialise
> - * very few fields yet: that has to wait until we have created the
> - * journal structures from from scratch, or loaded them from disk. */
> +/* The journal_init_common() function creates and fills a journal_t object
> + * in memory. It calls journal_load_superblock() to load the on-disk journal
> + * superblock and initialize the journal_t object.
> + */
>  
>  static journal_t *journal_init_common(struct block_device *bdev,
>  			struct block_device *fs_dev,
> -- 
> 2.39.5
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

