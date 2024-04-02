Return-Path: <linux-ext4+bounces-1822-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A1F89540D
	for <lists+linux-ext4@lfdr.de>; Tue,  2 Apr 2024 14:56:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27149285D59
	for <lists+linux-ext4@lfdr.de>; Tue,  2 Apr 2024 12:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C95F84A33;
	Tue,  2 Apr 2024 12:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Or4i/ENo";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9YvGzYa7"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2A283CB9;
	Tue,  2 Apr 2024 12:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712062561; cv=none; b=fnLAOp+OE8e9Vyx2J0UgyUdOaiw3m+vb45Cs9u9f+NsFSbvcN3ZarQ3bYPcyGL+DbbkCNnnYUuWdrOW1nSNAK28xeCLnqBNZ54cT+Hyz5lzuShsKWvCKdu5pgtCCDpQqIcpTxLPVP1zdqo3gOJcGukwOB9SosheATxdNWD80zFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712062561; c=relaxed/simple;
	bh=TtZLtq8Hz8doC1J37xg6YqY30LO/H0F9ybpVFSesKt0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HaEjgy62JpE8YuLIZry/MAS+qnQRJNrYEPGylBd3bPN0elis6rkzifg3qY5u6zRMclkGCLSiy7jzzBzFtGKyKQeBwmF+MCrMmzjQoGQpaau9bIGUOkJyUx+euJ6pBQFIJ5Gb7Lm0C32XycXAXu2E/aCo/zoxzDsAjoJpNwK4qH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Or4i/ENo; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9YvGzYa7; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 17ADD5BD3D;
	Tue,  2 Apr 2024 12:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1712062556; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QVwsTL4VXfxmQnjRGfaT+5S6pqQmO4IL8cSJr05k2/4=;
	b=Or4i/ENo7CiiZ589iN6rMHL38JcSTi9UPmnJ2Rjvx4aLBY7fBvcKc70W44UE4rMjJ0tFjv
	lCiYvXQHjkbQTMbBvDqudo58qLeRQo5HkaQVha9hv3VX5Mg789mR4wNM0tPSobF0yHIYR7
	c1nENf7lzNgIBhNNbRT76JFgQ0wB884=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1712062556;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QVwsTL4VXfxmQnjRGfaT+5S6pqQmO4IL8cSJr05k2/4=;
	b=9YvGzYa7eQPk5x2MdCr3lPY3PCCb3v4ndrCCWR+POUOJaK3EaZSIL3SfMeXX1m93x/QKzj
	1Vj617lGCLCjM0DA==
Authentication-Results: smtp-out2.suse.de;
	dkim=none
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 0CC3413357;
	Tue,  2 Apr 2024 12:55:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id MQ4aA1wADGZnSQAAn2gu4w
	(envelope-from <jack@suse.cz>); Tue, 02 Apr 2024 12:55:56 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 9CE09A0813; Tue,  2 Apr 2024 14:55:55 +0200 (CEST)
Date: Tue, 2 Apr 2024 14:55:55 +0200
From: Jan Kara <jack@suse.cz>
To: "yebin (H)" <yebin10@huawei.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>, tytso@mit.edu,
	adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org, jack@suse.cz
Subject: Re: [PATCH] jbd2: use shrink_type type instead of bool type for
 __jbd2_journal_clean_checkpoint_list()
Message-ID: <20240402125555.kqxsfmzeaeqbsmdp@quack3>
References: <20240401011614.3650958-1-yebin10@huawei.com>
 <20240401024417.GA739535@frogsfrogsfrogs>
 <660A5535.7080005@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <660A5535.7080005@huawei.com>
X-Rspamd-Queue-Id: 17ADD5BD3D
X-Spamd-Result: default: False [-2.81 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	R_DKIM_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap2.dmz-prg2.suse.org:rdns,imap2.dmz-prg2.suse.org:helo,huawei.com:email]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Score: -2.81
X-Spam-Level: 
X-Spam-Flag: NO

On Mon 01-04-24 14:33:25, yebin (H) wrote:
> On 2024/4/1 10:44, Darrick J. Wong wrote:
> > On Mon, Apr 01, 2024 at 09:16:14AM +0800, Ye Bin wrote:
> > > "enum shrink_type" can clearly express the meaning of the parameter of
> > > __jbd2_journal_clean_checkpoint_list(), and there is no need to use the
> > > bool type.
> > > 
> > > Signed-off-by: Ye Bin <yebin10@huawei.com>
> > > ---
> > >   fs/jbd2/checkpoint.c | 9 +++------
> > >   fs/jbd2/commit.c     | 2 +-
> > >   include/linux/jbd2.h | 4 +++-
> > >   3 files changed, 7 insertions(+), 8 deletions(-)
> > > 
> > > diff --git a/fs/jbd2/checkpoint.c b/fs/jbd2/checkpoint.c
> > > index 1c97e64c4784..d6e8b80a4078 100644
> > > --- a/fs/jbd2/checkpoint.c
> > > +++ b/fs/jbd2/checkpoint.c
> > > @@ -337,8 +337,6 @@ int jbd2_cleanup_journal_tail(journal_t *journal)
> > >   /* Checkpoint list management */
> > > -enum shrink_type {SHRINK_DESTROY, SHRINK_BUSY_STOP, SHRINK_BUSY_SKIP};
> > > -
> > >   /*
> > >    * journal_shrink_one_cp_list
> > >    *
> > > @@ -476,17 +474,16 @@ unsigned long jbd2_journal_shrink_checkpoint_list(journal_t *journal,
> > >    *
> > >    * Called with j_list_lock held.
> > >    */
> > > -void __jbd2_journal_clean_checkpoint_list(journal_t *journal, bool destroy)
> > > +void __jbd2_journal_clean_checkpoint_list(journal_t *journal,
> > > +					  enum shrink_type type)

The comment above this function needs updating after this change.

> > >   {
> > >   	transaction_t *transaction, *last_transaction, *next_transaction;
> > > -	enum shrink_type type;
> > >   	bool released;
> > >   	transaction = journal->j_checkpoint_transactions;
> > >   	if (!transaction)
> > >   		return;
> > > -	type = destroy ? SHRINK_DESTROY : SHRINK_BUSY_STOP;
> > What is supposed to happen if the caller passes in SHRINK_BUSY_SKIP?
> > 
> > --D
> 
> If SHRING_BUSY_SKIP is passed, the buffers in use will be skipped during traversal
> and release.Currently, SHRINKING_BUSY_SKIP is used in the memory reclamation process.

I guess Darrick was wondering whether there's some usefulness in calling
__jbd2_journal_clean_checkpoint_list() with SHRINKING_BUSY_SKIP. I agree it
does no harm but as we have seen in the past, it just wastes CPU cycles
scanning the buffer list in some cases so that's why we created
SHRINKING_BUSY_STOP. I also agree the 'bool' argument isn't great and the
enum is actually explaining more so I'm in favor of switching to enum but
perhaps we can have WARN_ON_ONCE(type == SHRINKING_BUSY_SKIP) (perhaps with
a short explanation in the comment above the function) to see if we
accidentally didn't grow unexpected use.

									Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

