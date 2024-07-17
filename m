Return-Path: <linux-ext4+bounces-3308-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBBC8933CDF
	for <lists+linux-ext4@lfdr.de>; Wed, 17 Jul 2024 14:11:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E991D1C22412
	for <lists+linux-ext4@lfdr.de>; Wed, 17 Jul 2024 12:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A945838385;
	Wed, 17 Jul 2024 12:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rDe2gqnq";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="DqfT0BFr";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rDe2gqnq";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="DqfT0BFr"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3F117FAA4
	for <linux-ext4@vger.kernel.org>; Wed, 17 Jul 2024 12:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721218309; cv=none; b=Mcpw/qD8yKwuwJlaLm9s7OCzkZzcHNOONopSoxjj/Yav+wsYsrA9y/DadZXUwLUXM4QhTsw55nuHgvRbhPqPGWvY25UMVqmd8n1SzTkDEi2woszQ+BqdFLWDE3EfYN4E44Xg/Ow1hux4SIwpcUlj1V1AdYMQvH0v1Ud1oVMcVGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721218309; c=relaxed/simple;
	bh=cTINZU5S9tRvaqqquRf8p6qsDEpeTPDjQsP7HsQITnM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CbJtYsfufSC0Y1ONYED2TaCN+nJfMfd7CvUWxyYnIizKUz8xsGmzyVzN/N2Dvfj0XhbEYjHipDIiCDheoqC2M9mshpRGAFNcP4gp/yYuiJ/A3G2BDtUVgeCBCxZFFB5JEpxyDqcbbFdynMFokDYg2ClK0Ucb+MOz2HIslvu/a4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rDe2gqnq; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=DqfT0BFr; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rDe2gqnq; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=DqfT0BFr; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A77C021B48;
	Wed, 17 Jul 2024 12:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721218305; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bgebhH4drKc/gAv6wMqk6qWNLg+kxoFZUxtBoRrnSb0=;
	b=rDe2gqnq5Ti/Xx3JlPI/RKk6bgQzn6vPqiY6ppIQP5GpXamd1x4JxG+o3XaTYSuYbTJkoK
	pLGCHeSW819Xk9cdNIIls83nN1r2Py5dD0QCVnobCveSTZ8PcitO9Ak43ItUViXmvDWw+P
	CmKlWh4kVtIYUrmCRvubrVQM1yCuUw4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721218305;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bgebhH4drKc/gAv6wMqk6qWNLg+kxoFZUxtBoRrnSb0=;
	b=DqfT0BFrz3OJO7yTllv/FdacoPEpYdzLCkf2SA+Zz05UysQIp94tPNSAk4bfZPbnbFYYMY
	47/evs2AHODUVNDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721218305; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bgebhH4drKc/gAv6wMqk6qWNLg+kxoFZUxtBoRrnSb0=;
	b=rDe2gqnq5Ti/Xx3JlPI/RKk6bgQzn6vPqiY6ppIQP5GpXamd1x4JxG+o3XaTYSuYbTJkoK
	pLGCHeSW819Xk9cdNIIls83nN1r2Py5dD0QCVnobCveSTZ8PcitO9Ak43ItUViXmvDWw+P
	CmKlWh4kVtIYUrmCRvubrVQM1yCuUw4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721218305;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bgebhH4drKc/gAv6wMqk6qWNLg+kxoFZUxtBoRrnSb0=;
	b=DqfT0BFrz3OJO7yTllv/FdacoPEpYdzLCkf2SA+Zz05UysQIp94tPNSAk4bfZPbnbFYYMY
	47/evs2AHODUVNDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9D7E21368F;
	Wed, 17 Jul 2024 12:11:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2XluJgG1l2bCWAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 17 Jul 2024 12:11:45 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 38128A0987; Wed, 17 Jul 2024 14:11:41 +0200 (CEST)
Date: Wed, 17 Jul 2024 14:11:41 +0200
From: Jan Kara <jack@suse.cz>
To: harshad shirwadkar <harshadshirwadkar@gmail.com>
Cc: Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org, tytso@mit.edu,
	saukad@google.com, harshads@google.com
Subject: Re: [PATCH v6 04/10] ext4: rework fast commit commit path
Message-ID: <20240717121141.lhxyzdb42i735vie@quack3>
References: <20240529012003.4006535-1-harshadshirwadkar@gmail.com>
 <20240529012003.4006535-5-harshadshirwadkar@gmail.com>
 <20240628134310.jlne3gscmac3e2ab@quack3>
 <CAD+ocbxzTnB9Jd0NNgY3JtgiZdNgkdLRPTpr9qJoZVk0qMXHsA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD+ocbxzTnB9Jd0NNgY3JtgiZdNgkdLRPTpr9qJoZVk0qMXHsA@mail.gmail.com>
X-Spam-Flag: NO
X-Spam-Score: 0.20
X-Spamd-Result: default: False [0.20 / 50.00];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 

On Fri 12-07-24 18:38:21, harshad shirwadkar wrote:
> On Fri, Jun 28, 2024 at 6:43 AM Jan Kara <jack@suse.cz> wrote:
> > > +static void __jbd2_journal_lock_updates(journal_t *journal, bool wait_on_rsv)
> > >  {
> > >       jbd2_might_wait_for_commit(journal);
> > >
> > >       write_lock(&journal->j_state_lock);
> > >       ++journal->j_barrier_count;
> > >
> > > -     /* Wait until there are no reserved handles */
> > > -     if (atomic_read(&journal->j_reserved_credits)) {
> > > +     if (wait_on_rsv && atomic_read(&journal->j_reserved_credits)) {
> > > +             /* Wait until there are no reserved handles */
> >
> > So it is not as simple as this. start_this_handle() ignores
> > journal->j_barrier_count for reserved handles so they would happily start
> > while you have the journal locked with jbd2_journal_lock_updates_no_rsv()
> > and then writeback code could mess with your fastcommit state. Or perhaps I
> > miss some subtlety why this is fine - but that then deserves a good
> > explanation in a comment or maybe a different API because currently
> > jbd2_journal_lock_updates_no_rsv() doesn't do what one would naively
> > expect.
> 
> AFAICT, jbd2_journal_commit_transaction() only calls
> jbd2_journal_wait_updates(journal) which waits for
> trasaction->t_updates to reach 0. But it doesn't wait for
> journal->j_reserved_credits to reach 0. I saw a performance
> improvement by removing waiting on reserved handles in FC commit code
> as well. Given that JBD2 doesn't wait, I (perhaps incorrectly) thought
> that it'd be okay to not wait in FC as well. Could you help me
> understand why the JBD2 journal commit doesn't need to wait for
> reserved handles?

Sure. When we do page writeback, we may need to do some metadata
modifications (such as clearing unwritten bits in the extent tree) before
the writeback can complete and we can clear PG_Writeback bits. Hence if we
started a normal transaction after IO completes to do metadata
modifications, we could easily deadlock with transaction commit - broadly
speaking transaction commit waits for PG_Writeback to clear, page writeback
code waits for transaction commit so that it can free space in the journal
and start a new transaction. This is why reserved transactions were
introduced. Their main point is: If you have handle reserved, you are
guaranteed you can start this handle without blocking waiting for space in
the journal. Note that we could also start a normal handle before doing
page writeback and use it after IO completion for metadata changes and this
would work in principle (besides the technical troubles with propagating
the handle to IO completion context) but because we can writeback quite
large chunks of data, these handles could be running for tens of seconds
which would make other filesystem operations starve. Thus we allow reserved
(but not yet started) handles to be moved from currently running
transaction into a next one and this is fine because the reservation code
makes sure there's always enough free space in the journal for reserved
handles. So commit code can happily do transaction commit while reserved
handles are existing because if their owner decides to start them, they'll
just join the currently running transaction (or create one if there's
none).

But jbd2_journal_lock_updates() always needs to wait for all outstanding
handles including the reserved ones because it needs to guarantee there are
no modifications pending for the journal. Even you in fastcommit code rely
on inode list not being modified after jbd2_journal_lock_updates() and
reserved handles would break that assumption because existing reserved
handles can start after your version of jbd2_journal_lock_updates() not
waiting for reserved handles would return. And reserved handles need to be
able to start while jbd2_journal_lock_updates() is waiting for the journal
to quiesce because we need page writeback to finish before we can quiesce
the journal.

In theory you could create new journal locking mechanism for fastcommit
code that would *also* block starting of reserved handles since what
fastcommit needs to do with a locked journal does not depend on page
writeback. But frankly I'm not convinced this complication is worth it.

I hope this makes things clearer.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

