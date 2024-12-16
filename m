Return-Path: <linux-ext4+bounces-5667-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E0889F3108
	for <lists+linux-ext4@lfdr.de>; Mon, 16 Dec 2024 13:59:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F20716706B
	for <lists+linux-ext4@lfdr.de>; Mon, 16 Dec 2024 12:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D4F204F88;
	Mon, 16 Dec 2024 12:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ys8z1gFK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ztIhWAOZ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ys8z1gFK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ztIhWAOZ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9631E4B2;
	Mon, 16 Dec 2024 12:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734353986; cv=none; b=KCZGaEbT7TdSu4yLgCjXvVUQ0GpZZtHB7zNe2Ra4P7lSapXFX43FyRx+aj+GD/G11SKoXI/wPWqOkBP6lQGedbsnnTz7w/3aqcqh1B1wIHJ63k9FO5LElQ9ppBLtiI7P1V0G8gLUO30ZRLHGljRk8mRXHJx7ABR7QMUl/G8i1Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734353986; c=relaxed/simple;
	bh=RUVKc6L+uUfWMTE0IFmH0FPnVyl/zUUqsu6vxUK33Ok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fIP6NIZVu0jnHILE418HSvfR9Ny6OD6qlx5CGZLQVyrYuPq5wOAzAbDf493lleqSS/Uxs8k54MJUTGfF9rbNjEGJGLhHPRARfZD/Q8qDY92MHrMGtmKX172daf1Ls9RPIhzS5C62m3yVZySA4rev1HHT7VdYKtnnVos8JjiD5T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ys8z1gFK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ztIhWAOZ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ys8z1gFK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ztIhWAOZ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5F43A21114;
	Mon, 16 Dec 2024 12:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1734353982; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JB5RmYamRlU7T6WnviEORO25jJqAtZFfrSqR55m0b40=;
	b=Ys8z1gFKzYTNgMfyEH2QVNzPDmmKywnWBf2QxHHVzTHR6pzjhgHrK5iwISJFcOzl9hbtOe
	j10R8VaMm4Ba95VrltqcOEk7YuW9Pj9zR6X64EgrXOgICyUjT0IXqrIy9P6mgv5mb9xGdH
	DsUs14Vqncn8YUhJYrt+OkycRHtxZCI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1734353982;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JB5RmYamRlU7T6WnviEORO25jJqAtZFfrSqR55m0b40=;
	b=ztIhWAOZ/0QtotkKi58nhzD6KikdhcTxarr9LJhLo9qxWfp2OusHXnpkD0iq6xG/JTeLPV
	vvveLEDB0PlO8qCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1734353982; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JB5RmYamRlU7T6WnviEORO25jJqAtZFfrSqR55m0b40=;
	b=Ys8z1gFKzYTNgMfyEH2QVNzPDmmKywnWBf2QxHHVzTHR6pzjhgHrK5iwISJFcOzl9hbtOe
	j10R8VaMm4Ba95VrltqcOEk7YuW9Pj9zR6X64EgrXOgICyUjT0IXqrIy9P6mgv5mb9xGdH
	DsUs14Vqncn8YUhJYrt+OkycRHtxZCI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1734353982;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JB5RmYamRlU7T6WnviEORO25jJqAtZFfrSqR55m0b40=;
	b=ztIhWAOZ/0QtotkKi58nhzD6KikdhcTxarr9LJhLo9qxWfp2OusHXnpkD0iq6xG/JTeLPV
	vvveLEDB0PlO8qCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 51736137CF;
	Mon, 16 Dec 2024 12:59:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AgHeEz4kYGeqUwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 16 Dec 2024 12:59:42 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id EB810A09D9; Mon, 16 Dec 2024 13:59:41 +0100 (CET)
Date: Mon, 16 Dec 2024 13:59:41 +0100
From: Jan Kara <jack@suse.cz>
To: Nikolai Zhubr <zhubr.2@gmail.com>
Cc: Theodore Ts'o <tytso@mit.edu>, linux-ext4@vger.kernel.org,
	stable@vger.kernel.org, linux-kernel@vger.kernel.org, jack@suse.cz
Subject: Re: ext4 damage suspected in between 5.15.167 - 5.15.170
Message-ID: <20241216125941.pr2eufott5pmqyyh@quack3>
References: <CALQo8TpjoV8JtuYDH_nBU5i4e-iuCQ1-NORAE8uobpDD_yYBTA@mail.gmail.com>
 <20241212191603.GA2158320@mit.edu>
 <79af4b93-63a1-da4c-2793-8843c60068f5@gmail.com>
 <20241213161230.GF1265540@mit.edu>
 <ce9055d7-7301-0abe-3609-3a4e2e7b1e5e@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce9055d7-7301-0abe-3609-3a4e2e7b1e5e@gmail.com>
X-Spam-Score: -2.30
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 

Hi Nikolai!

On Sat 14-12-24 22:58:24, Nikolai Zhubr wrote:
> On 12/13/24 19:12, Theodore Ts'o wrote:
> > Note that some hardware errors can be caused by one-off errors, such
> > as cosmic rays causing a bit-flip in memory DIMM.  If that happens,
> > RAID won't save you, since the error was introduced before an updated
> 
> Certainly cosmic rays is a possibility, but based on previous episodes I'd
> still rather bet on a more usual "subtle interaction" problem, either exact
> same or some similar to [1].
> I even tried to run an existing test for this particular case as described
> in [2] but it is not too user-friendly and somehow exits abnormally without
> actually doing any interesting work. I'll get back to it later when I have
> some time.
> 
> [1] https://lore.kernel.org/stable/20231205122122.dfhhoaswsfscuhc3@quack3/
> [2] https://lwn.net/Articles/954364/
> 
> > The location of block allocation bitmaps never gets changed, so this
> > sort of thing only happens due to hardware-induced corruption.
> 
> Well, unless e.g. some modified sectors start being flushed to random wrong
> offsets, like in [1] above, or something similar.

Note that above bug led to writing file data to another position in that
file. As such it cannot really lead to metadata corruption. Corrupting data
in a file is relatively frequent event (given the wide variety of
manipulations we do with file data). OTOH I've never seen corrupting
metadata like this (in particular because ext4 has additional sanity checks
that newly allocated blocks don't overlap with critical fs metadata). In
theory, there could be software bug leading to writing sector to a wrong
position but frankly, in all the cases I've investigated so far such bugs
ended up being HW related.

> > Otherwise, I strongly encourage you to learn, and to take
> > responsibility for the health of your own system.  And ideally, you
> > can also use that knowledge to help other users out, which is the only
> > way the free-as-in-beer ecosystem can flurish; by having everybody
> 
> True. Generally I try to follow that, as much as appears possible.
> It is sad a direct communication end-user-to-developer for solving issues is
> becoming increasingly problematic here.

On one hand I understand you, on the other hand back in the good old days
(and I remember those as well ;) you wouldn't get much help when running
over three years old kernel either. And I understand you're running a stable
kernel that gets at least some updates but that's meant more for companies
that build their products on top of that and have teams available for
debugging issues. For an enduser I find some distribution kernels (Debian,
Ubuntu, openSUSE, Fedora) more suitable as they get much more scrutiny
before being released than -stable and also people there are more willing
to look at issues with older kernels (that are still supported by the
distro).

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

