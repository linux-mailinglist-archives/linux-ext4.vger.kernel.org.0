Return-Path: <linux-ext4+bounces-2952-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1438917F84
	for <lists+linux-ext4@lfdr.de>; Wed, 26 Jun 2024 13:23:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3F021C21474
	for <lists+linux-ext4@lfdr.de>; Wed, 26 Jun 2024 11:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2210717E448;
	Wed, 26 Jun 2024 11:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="iCbehDgo";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="QngbfZad";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="iCbehDgo";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="QngbfZad"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C6313AD11;
	Wed, 26 Jun 2024 11:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719400979; cv=none; b=RjGZwfzCnucE2HR3DT2xfF+GyHBtgiJldJuPgGctoVpuy1cl/JZTGbV4eVFUfLnWZhuqIjzqViNX81FfELr19pcrCGZrb+EVmVm/eh7F7rNqNpeWysNRBA/1AL9uDySGummkoYErah8Y8zDf7vRgqyOr5juGZO7rk4s4HwkniNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719400979; c=relaxed/simple;
	bh=qcy5gT6+lZiosigVuxdSnB73tlyPavbfF7+4QQq/oHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YW2jrXTqHXf5cl42uNL1oQKuSoI+y10rjaOVYFVC293EKKUQUj7Ib6nEsMQY25beEkq4yLq8IQSh/g/h1ZQAVAdBMHJ9g3g9oYChGMsUggLVWv4GIGy/lMKrVmgSCEWc1cipzEd82VcKuwR7ULA3RJy/u+tGPhMglhMorfeVgT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=iCbehDgo; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=QngbfZad; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=iCbehDgo; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=QngbfZad; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8B7571FB57;
	Wed, 26 Jun 2024 11:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719400974; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ymv9tE5kuaJmuY9l/He3VQ9lDGheARQyb9n1s43Y+fo=;
	b=iCbehDgoEicWHc00jr1NnLhK+oMVrYnyNhtzFAHCaJMRpQFX0ARRzw+xj5c+gQcYa/FSLk
	YHtNGi6/HKo4m40qtd+Yb8l9nOBYN2ldzi/C90gV6iFZHdhZ2SVlgFeQCmDF4+noUBJrnM
	j9vKUhNH9F5rdf5gHpmXCKwAqwhKt5k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719400974;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ymv9tE5kuaJmuY9l/He3VQ9lDGheARQyb9n1s43Y+fo=;
	b=QngbfZadyybZnFcXQlIthKnUrhlFWwGU804aFSGZVXBJGBncxA7nth0eeHSFJKPAxn0yVj
	KFyl3GH2WCQ3pRDQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=iCbehDgo;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=QngbfZad
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719400974; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ymv9tE5kuaJmuY9l/He3VQ9lDGheARQyb9n1s43Y+fo=;
	b=iCbehDgoEicWHc00jr1NnLhK+oMVrYnyNhtzFAHCaJMRpQFX0ARRzw+xj5c+gQcYa/FSLk
	YHtNGi6/HKo4m40qtd+Yb8l9nOBYN2ldzi/C90gV6iFZHdhZ2SVlgFeQCmDF4+noUBJrnM
	j9vKUhNH9F5rdf5gHpmXCKwAqwhKt5k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719400974;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ymv9tE5kuaJmuY9l/He3VQ9lDGheARQyb9n1s43Y+fo=;
	b=QngbfZadyybZnFcXQlIthKnUrhlFWwGU804aFSGZVXBJGBncxA7nth0eeHSFJKPAxn0yVj
	KFyl3GH2WCQ3pRDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7A42C13AAD;
	Wed, 26 Jun 2024 11:22:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ChyRHQ76e2aXGAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 26 Jun 2024 11:22:54 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 1E9EBA082B; Wed, 26 Jun 2024 13:22:54 +0200 (CEST)
Date: Wed, 26 Jun 2024 13:22:54 +0200
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huawei.com>
Cc: Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org,
	Alexander Coffin <alex.coffin@maticrobots.com>,
	stable@vger.kernel.org, Ted Tso <tytso@mit.edu>,
	chengzhihao1@huawei.com
Subject: Re: [PATCH v2 3/4] jbd2: Avoid infinite transaction commit loop
Message-ID: <20240626112254.cu4un6lua2glkfkn@quack3>
References: <20240624165406.12784-1-jack@suse.cz>
 <20240624170127.3253-3-jack@suse.cz>
 <2d49e3de-d7e7-2fd1-0b7a-9a3f9e04cd4d@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d49e3de-d7e7-2fd1-0b7a-9a3f9e04cd4d@huawei.com>
X-Rspamd-Queue-Id: 8B7571FB57
X-Spam-Score: -4.01
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On Wed 26-06-24 15:38:42, Zhang Yi wrote:
> On 2024/6/25 1:01, Jan Kara wrote:
> > Commit 9f356e5a4f12 ("jbd2: Account descriptor blocks into
> > t_outstanding_credits") started to account descriptor blocks into
> > transactions outstanding credits. However it didn't appropriately
> > decrease the maximum amount of credits available to userspace. Thus if
> > the filesystem requests a transaction smaller than
> > j_max_transaction_buffers but large enough that when descriptor blocks
> > are added the size exceeds j_max_transaction_buffers, we confuse
> > add_transaction_credits() into thinking previous handles have grown the
> > transaction too much and enter infinite journal commit loop in
> > start_this_handle() -> add_transaction_credits() trying to create
> > transaction with enough credits available.
> 
> I understand that the incorrect max transaction limit in
> start_this_handle() could lead to infinite loop in
> start_this_handle()-> add_transaction_credits() with large enough
> userspace credits (from j_max_transaction_buffers - overheads to
> j_max_transaction_buffers), but I don't get how could it lead to ran
> out of space in the journal commit traction? IIUC, below codes in
> add_transaction_credits() could make sure that we have enough space
> when committing traction:
> 
> static int add_transaction_credits()
> {
> ...
> 	if (jbd2_log_space_left(journal) < journal->j_max_transaction_buffers) {
> 		...
> 		return 1;
> 		...
> 	}
> ...
> }
> 
> I can't open and download the image Alexander gave, so I can't get to
> the bottom of this issue, please let me know what happened with
> jbd2_journal_next_log_block().

Sure. So what was exactly happening is a loop like this:

start_this_handle()
  blocks = 252 (handle->h_total_credits)
  - starts a new transaction
    - t_outstanding_credits set to 6 to account for the commit block and
      descriptor blocks
  add_transaction_credits(journal, 252, 0)
     needed = atomic_add_return(252, &t->t_outstanding_credits);
     if (needed > journal->j_max_transaction_buffers) {
	/* Yes, this is exceeded due to descriptor blocks being in
	 * t_outstanding_credits */
        ...
        wait_transaction_locked(journal);
	  - this commits an empty transaction - contains only the commit
	    block
        return 1
  goto repeat

So we commit single block transactions in a loop until we exhaust all the
journal space. The condition in add_transaction_credits() whether there's
enough space in the journal is never reached so we don't ever push the
journal tail to make space in the journal.
    
								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

