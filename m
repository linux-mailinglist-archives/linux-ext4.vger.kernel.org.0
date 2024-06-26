Return-Path: <linux-ext4+bounces-2954-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B2DC9184F6
	for <lists+linux-ext4@lfdr.de>; Wed, 26 Jun 2024 16:55:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0088C28E2F7
	for <lists+linux-ext4@lfdr.de>; Wed, 26 Jun 2024 14:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 844C1186E36;
	Wed, 26 Jun 2024 14:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="K9koSc79";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="JonazgUQ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="K9koSc79";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="JonazgUQ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0CF1755A;
	Wed, 26 Jun 2024 14:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719413721; cv=none; b=Vp0D6DbUeUJGdUBq92tzBeEMLhk8se1gqTFUHE406d8tBp70BW6sbwRo4D+gjM/7gDq1TN8Km43r+36ud9H9sjd1WibSyl442nDWAZiq7cctFyPmgjI3tiEkJb+wgH32zLTp36adxg2TRoldbmIss4BHKg+dfiXbZMY1297Dl0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719413721; c=relaxed/simple;
	bh=GyMP46sw7XAitbLkddTylJH/Ijj2fbGIIxX+Mu1kzhs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TJXNsBlB/QuiWorCS2uQro0w6L7jwCRCiAx6LSxp6DOK6oFZaXnJpCM/N782NHR2olOf4g/D92q36fFNyKQ/8vjKRpsL5oXrI93mjKl7SZrKQiLOMVk5dcZBKT817mvnf6SBGhdavW/IiH0sU8EBmBZR1OiYVABq/qFWd3YdDFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=K9koSc79; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=JonazgUQ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=K9koSc79; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=JonazgUQ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5CF981FB57;
	Wed, 26 Jun 2024 14:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719413717; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6Sk/BMOpx1GwgCuwoI5NGidQ0QAJHEh2mh7ucsZ2av8=;
	b=K9koSc79RrMlcvH90oYqlTqRUtUmacyWrrlrETgTUPPdrC+rpZEcLedqyED39NZod56EgT
	QPDjK4nhabFYFr5dSmBpddl/WYO4q4Yr44ntzDCu4PqL9+81lCz5QqjsmLUq8I7p9vWkmq
	lKYCf0MRnEqIAk4YSJoYiz8UKrZ8t0Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719413717;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6Sk/BMOpx1GwgCuwoI5NGidQ0QAJHEh2mh7ucsZ2av8=;
	b=JonazgUQ1SXtlw8L3ewEkY1it4jdYwv4+MlIZeET1CBQDil22pVulZt3ocr1dzUxU6Ht1x
	ZljcydcQz3lbZ8Dw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=K9koSc79;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=JonazgUQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719413717; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6Sk/BMOpx1GwgCuwoI5NGidQ0QAJHEh2mh7ucsZ2av8=;
	b=K9koSc79RrMlcvH90oYqlTqRUtUmacyWrrlrETgTUPPdrC+rpZEcLedqyED39NZod56EgT
	QPDjK4nhabFYFr5dSmBpddl/WYO4q4Yr44ntzDCu4PqL9+81lCz5QqjsmLUq8I7p9vWkmq
	lKYCf0MRnEqIAk4YSJoYiz8UKrZ8t0Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719413717;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6Sk/BMOpx1GwgCuwoI5NGidQ0QAJHEh2mh7ucsZ2av8=;
	b=JonazgUQ1SXtlw8L3ewEkY1it4jdYwv4+MlIZeET1CBQDil22pVulZt3ocr1dzUxU6Ht1x
	ZljcydcQz3lbZ8Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 51721139C2;
	Wed, 26 Jun 2024 14:55:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id X4TcE9UrfGY9XgAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 26 Jun 2024 14:55:17 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id DE157A0882; Wed, 26 Jun 2024 16:55:16 +0200 (CEST)
Date: Wed, 26 Jun 2024 16:55:16 +0200
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org,
	Alexander Coffin <alex.coffin@maticrobots.com>,
	stable@vger.kernel.org, Ted Tso <tytso@mit.edu>,
	chengzhihao1@huawei.com
Subject: Re: [PATCH v2 3/4] jbd2: Avoid infinite transaction commit loop
Message-ID: <20240626145516.xopg62cxcztte3ek@quack3>
References: <20240624165406.12784-1-jack@suse.cz>
 <20240624170127.3253-3-jack@suse.cz>
 <2d49e3de-d7e7-2fd1-0b7a-9a3f9e04cd4d@huawei.com>
 <20240626112254.cu4un6lua2glkfkn@quack3>
 <e5a3187c-b333-ec5b-0d8b-a02934a37b06@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e5a3187c-b333-ec5b-0d8b-a02934a37b06@huaweicloud.com>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.cz:dkim];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 5CF981FB57
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 

On Wed 26-06-24 21:24:13, Zhang Yi wrote:
> On 2024/6/26 19:22, Jan Kara wrote:
> > On Wed 26-06-24 15:38:42, Zhang Yi wrote:
> >> On 2024/6/25 1:01, Jan Kara wrote:
> >>> Commit 9f356e5a4f12 ("jbd2: Account descriptor blocks into
> >>> t_outstanding_credits") started to account descriptor blocks into
> >>> transactions outstanding credits. However it didn't appropriately
> >>> decrease the maximum amount of credits available to userspace. Thus if
> >>> the filesystem requests a transaction smaller than
> >>> j_max_transaction_buffers but large enough that when descriptor blocks
> >>> are added the size exceeds j_max_transaction_buffers, we confuse
> >>> add_transaction_credits() into thinking previous handles have grown the
> >>> transaction too much and enter infinite journal commit loop in
> >>> start_this_handle() -> add_transaction_credits() trying to create
> >>> transaction with enough credits available.
> >>
> >> I understand that the incorrect max transaction limit in
> >> start_this_handle() could lead to infinite loop in
> >> start_this_handle()-> add_transaction_credits() with large enough
> >> userspace credits (from j_max_transaction_buffers - overheads to
> >> j_max_transaction_buffers), but I don't get how could it lead to ran
> >> out of space in the journal commit traction? IIUC, below codes in
> >> add_transaction_credits() could make sure that we have enough space
> >> when committing traction:
> >>
> >> static int add_transaction_credits()
> >> {
> >> ...
> >> 	if (jbd2_log_space_left(journal) < journal->j_max_transaction_buffers) {
> >> 		...
> >> 		return 1;
> >> 		...
> >> 	}
> >> ...
> >> }
> >>
> >> I can't open and download the image Alexander gave, so I can't get to
> >> the bottom of this issue, please let me know what happened with
> >> jbd2_journal_next_log_block().
> > 
> > Sure. So what was exactly happening is a loop like this:
> > 
> > start_this_handle()
> >   blocks = 252 (handle->h_total_credits)
> >   - starts a new transaction
> >     - t_outstanding_credits set to 6 to account for the commit block and
> >       descriptor blocks
> >   add_transaction_credits(journal, 252, 0)
> >      needed = atomic_add_return(252, &t->t_outstanding_credits);
> >      if (needed > journal->j_max_transaction_buffers) {
> > 	/* Yes, this is exceeded due to descriptor blocks being in
> > 	 * t_outstanding_credits */
> >         ...
> >         wait_transaction_locked(journal);
> > 	  - this commits an empty transaction - contains only the commit
> > 	    block
> >         return 1
> >   goto repeat
> > 
> > So we commit single block transactions in a loop until we exhaust all the
> > journal space. The condition in add_transaction_credits() whether there's
> > enough space in the journal is never reached so we don't ever push the
> > journal tail to make space in the journal.
> >     
> 
> mm-hm, ha, yeah, this will lead to submit an empty transaction in each loop,
> but I still have one question, although the journal tail can't be updated
> in add_transaction_credits(), I think the journal tail should be updated in
> jbd2_journal_commit_transaction()->jbd2_update_log_tail() since we don't
> add empty transactions to journal->j_checkpoint_transactions list, the loop
> in jbd2_journal_commit_transaction() should like this:
> 
> ...
> jbd2_journal_commit_transaction()
>   update_tail = jbd2_journal_get_log_tail()
>     //journal->j_checkpoint_transactions should be NULL, tid is the
>     //committing transaction's tid, which should be large than the
>     //tail tid since the second loop, so this should be true after
>     //the second loop
>   if (freed < journal->j_max_transaction_buffers)
>     update_tail = 0;
>     //update_tail should be true after j_max_transaction_buffers loop
> 
> jbd2_update_log_tail()  //j_free should be increased in each
>                         //j_max_transaction_buffers loop
>   if (tid_gt(tid, journal->j_tail_sequence)) //it's true
>   __jbd2_update_log_tail()
>     journal->j_free += freed; //update log tail and increase j_free
>                               //j_max_transaction_buffers blocks
> ...
> 
> As I understand it, the journal space can't be exhausted, I don't know how
> it happened, am I missing something?

Well, at the beginning of the journal there are a few non-empty
transactions whose buffers didn't get checkpointed before we entered the
commit loop. So we cannot just push the journal tail without doing a
checkpoint and we never call into the checkpointing code in the commit
loop...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

