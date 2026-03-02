Return-Path: <linux-ext4+bounces-14327-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8NxRDlC6pWmoFQAAu9opvQ
	(envelope-from <linux-ext4+bounces-14327-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Mon, 02 Mar 2026 17:26:56 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A5BD91DCC36
	for <lists+linux-ext4@lfdr.de>; Mon, 02 Mar 2026 17:26:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6046C3069661
	for <lists+linux-ext4@lfdr.de>; Mon,  2 Mar 2026 16:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7325530498E;
	Mon,  2 Mar 2026 16:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="voFKSuCm";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="zMrRlWoP";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="voFKSuCm";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="zMrRlWoP"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0519309F09
	for <linux-ext4@vger.kernel.org>; Mon,  2 Mar 2026 16:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772468417; cv=none; b=drSik2JDD6qorsTNlEdQIGolwFmI3+ZkAyFdd0IdFgkzR62hu2eUfwurRRqyWuvBQbrZrcDp9pbutZHa8yb6oH7QviHEHxOjpf3nJYox1mAKH4A5RMKsC0upt94ayweJSTho2ho/wY5MuQ8Zfx/QApBLodISekbBVxwvxok2V4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772468417; c=relaxed/simple;
	bh=4AvMOKw0bS7gpumoPWsB5haxAS1qvnXZbGEirUq0FcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hLztZBwKk9c8bhywsX+Ex28yf1RuG2Ndbe0qxdImpKqePg2ar1GY6X/CAfz0a6/RuE2q/3KE5HOQdftUB2CafCPyXUlL+9sIVjBVoB4MN20G692omlxd1c0BZW4B7a/y74/acl50ZUyBco8v/nN52RkEXgMk2YwoHv1YpzdbjGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=voFKSuCm; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=zMrRlWoP; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=voFKSuCm; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=zMrRlWoP; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0EC995BD89;
	Mon,  2 Mar 2026 16:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772468414; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XWWnGmAHQ9pxE8qUEqMgH7DF94niP5eDpAY2QnskI2Q=;
	b=voFKSuCm/PZT79AeS+AgQukQmGtyQ5RORh69hGOfW9c/fY86WKOrvD9oRaIGWcvHbjYUhC
	eZr4EbyoPccPBZ27UYU+mSv7/AEdrH65SJUhUDOoh3CzLUmQ2fY6x96SCsLQwnuwa6hl8T
	ALJgp1u2otYxAimzD7g8OM0nyneAseQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772468414;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XWWnGmAHQ9pxE8qUEqMgH7DF94niP5eDpAY2QnskI2Q=;
	b=zMrRlWoPuKAKfCF/Hv/0kjGVZi1rWV7XLt5iFHmROd4xzOO27OmKFzHcfr2uX7pHEY08lZ
	LbZPzVLQSa/4saCQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=voFKSuCm;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=zMrRlWoP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772468414; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XWWnGmAHQ9pxE8qUEqMgH7DF94niP5eDpAY2QnskI2Q=;
	b=voFKSuCm/PZT79AeS+AgQukQmGtyQ5RORh69hGOfW9c/fY86WKOrvD9oRaIGWcvHbjYUhC
	eZr4EbyoPccPBZ27UYU+mSv7/AEdrH65SJUhUDOoh3CzLUmQ2fY6x96SCsLQwnuwa6hl8T
	ALJgp1u2otYxAimzD7g8OM0nyneAseQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772468414;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XWWnGmAHQ9pxE8qUEqMgH7DF94niP5eDpAY2QnskI2Q=;
	b=zMrRlWoPuKAKfCF/Hv/0kjGVZi1rWV7XLt5iFHmROd4xzOO27OmKFzHcfr2uX7pHEY08lZ
	LbZPzVLQSa/4saCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F322A3EA6C;
	Mon,  2 Mar 2026 16:20:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id LltWO724pWkKMgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 02 Mar 2026 16:20:13 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id B607BA0A0B; Mon,  2 Mar 2026 17:20:13 +0100 (CET)
Date: Mon, 2 Mar 2026 17:20:13 +0100
From: Jan Kara <jack@suse.cz>
To: Milos Nikic <nikic.milos@gmail.com>
Cc: Jan Kara <jack@suse.cz>, jack@suse.com, tytso@mit.edu, 
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, yi.zhang@huaweicloud.com
Subject: Re: [PATCH] jbd2: gracefully abort instead of panicking on unlocked
 buffer
Message-ID: <bijafi76dl3ss3zqwkugerpawibijujq2kr4jqcfxnry2tgsau@fvek77ply7pm>
References: <20260302003135.93802-1-nikic.milos@gmail.com>
 <u4zbebo5va2oxs3ggr5caspz5mklufrfx2rjjg4sw3vhm5d3pw@a5vd7a2ufarh>
 <CAOeJtk_JmASoSZQ_Y=qY155vQCXGnpqtXy8EPc3HA5yj4QFsJQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOeJtk_JmASoSZQ_Y=qY155vQCXGnpqtXy8EPc3HA5yj4QFsJQ@mail.gmail.com>
X-Spam-Flag: NO
X-Spam-Score: -2.51
X-Spam-Level: 
X-Rspamd-Queue-Id: A5BD91DCC36
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14327-lists,linux-ext4=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[suse.cz];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-ext4@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-ext4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On Mon 02-03-26 07:58:41, Milos Nikic wrote:
> Hi Jan,
> 
> No, I didn't trigger this in the wild. I have been auditing jbd2 for
> J_ASSERT usage to see where we could proactively swap hard panics for
> graceful journal aborts.
> You are right that there are many similar asserts, but I focused on this
> one because it belongs to a specific, easily-actionable group: it resides
> in a function that already returns an error code (int).
> 
> Many of the other J_ASSERTs are buried inside void functions. Converting
> those to return errors would require cascading API changes and rewriting
> caller error-handling paths across the subsystem, which is a much bigger
> and riskier lift.
> My goal was just to target the "low-hanging fruit"—the asserts where the
> function signature already supports returning an error (-EINVAL/-EIO) and
> aborting the journal safely without changing the API.
> 
> If you are open to it, I can audit the codebase for the rest of the asserts
> that fit this exact profile and submit them.
> Would you prefer them grouped into a single patch, or a short series?

OK, thanks for explanation. So if you can submit a patch addressing these
easy cases (possibly split to one patch per file in case the patch would be
too big) that would be good. For this patch feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> 
> Thanks,
> Milos
> 
> On Mon, Mar 2, 2026 at 5:08 AM Jan Kara <jack@suse.cz> wrote:
> 
> > On Sun 01-03-26 16:31:35, Milos Nikic wrote:
> > > In jbd2_journal_get_create_access(), if the caller passes an unlocked
> > > buffer, the code currently triggers a fatal J_ASSERT.
> > >
> > > While an unlocked buffer here is a clear API violation and a bug in the
> > > caller, crashing the entire system is an overly severe response. It
> > brings
> > > down the whole machine for a localized filesystem inconsistency.
> > >
> > > Replace the J_ASSERT with a WARN_ON_ONCE to capture the offending
> > caller's
> > > stack trace, and return an error (-EINVAL). This allows the journal to
> > > gracefully abort the transaction, protecting data integrity without
> > > causing a kernel panic.
> > >
> > > Signed-off-by: Milos Nikic <nikic.milos@gmail.com>
> >
> > In principle I'm fine with this however we have lots of similar asserts in
> > the code. So how is this one special? Did you somehow trigger it?
> >
> >                                                                 Honza
> >
> > > ---
> > >  fs/jbd2/transaction.c | 7 ++++++-
> > >  1 file changed, 6 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
> > > index dca4b5d8aaaa..04d17a5f2a82 100644
> > > --- a/fs/jbd2/transaction.c
> > > +++ b/fs/jbd2/transaction.c
> > > @@ -1302,7 +1302,12 @@ int jbd2_journal_get_create_access(handle_t
> > *handle, struct buffer_head *bh)
> > >               goto out;
> > >       }
> > >
> > > -     J_ASSERT_JH(jh, buffer_locked(jh2bh(jh)));
> > > +     if (WARN_ON_ONCE(!buffer_locked(jh2bh(jh)))) {
> > > +             err = -EINVAL;
> > > +             spin_unlock(&jh->b_state_lock);
> > > +             jbd2_journal_abort(journal, err);
> > > +             goto out;
> > > +     }
> > >
> > >       if (jh->b_transaction == NULL) {
> > >               /*
> > > --
> > > 2.53.0
> > >
> > --
> > Jan Kara <jack@suse.com>
> > SUSE Labs, CR
> >
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

