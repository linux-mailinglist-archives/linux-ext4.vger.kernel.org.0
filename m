Return-Path: <linux-ext4+bounces-6151-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F4ACA14E36
	for <lists+linux-ext4@lfdr.de>; Fri, 17 Jan 2025 12:11:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93F30168217
	for <lists+linux-ext4@lfdr.de>; Fri, 17 Jan 2025 11:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B30611FCFF0;
	Fri, 17 Jan 2025 11:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="S9W9oV8Z";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7ixcoqpM";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="S9W9oV8Z";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7ixcoqpM"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A34D1F7577
	for <linux-ext4@vger.kernel.org>; Fri, 17 Jan 2025 11:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737112292; cv=none; b=cNE7c0UAd7wcdRVrwBS4TTEpNnkZgqv50SPW35x6W726zARTsMMpNa00TiRYjaThLKddpTsa72ScM+qojGqMXv9YUHiySoPU8jgVRhp0qs6+I8HLfIth/fax4VrmSA4YQ/EI5xLqzSJ7JPQCLiqaHleIO3FJeeItabU6uktpQqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737112292; c=relaxed/simple;
	bh=2gpBpIoH98HOpWNEKLpTdGxeWTwN4Wgicxc/g+eQHB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bsmCTkvWCbWWEYUsjQ0SeVutvvu3dkT1C2PG8mQnOkJ+DAsmuFv5vmbbSjZEGWjQHf4l2ji/BeEYiV5JonxhpQ/VGXZAejZGSyVRZtYy2fQlyHvvVYEwlMsJxm93/8gQwQqitxBvkmqLHIfk8cT1izo9Hkyib/kOAB5t38ZBHJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=S9W9oV8Z; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7ixcoqpM; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=S9W9oV8Z; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7ixcoqpM; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8183A2117A;
	Fri, 17 Jan 2025 11:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1737112288; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P/K0I9+FJfsjVYMMwQNMy08HM0ufpR57CJCYFChWdGQ=;
	b=S9W9oV8Z5kXi6SRHqV77+Ost+/grhrVAln1nrHkmyjm7pPXub/BvsUsNzseON7RLsc8g8A
	EfT5/mY7LQHFMr/WvsFUDTljvUteWXMlhsX8SKjzfcUk/8bhLlTuM8ERbVS92GM179cj2o
	+/pO04raW5P1hX7eMyLLjNMd8oPdSJ4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1737112288;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P/K0I9+FJfsjVYMMwQNMy08HM0ufpR57CJCYFChWdGQ=;
	b=7ixcoqpMQ1SUOm0Tw09iiVOWkZJIgeQAL9s1WcJvTSi8mwm39H3M6lLauQ917bpiNc7p59
	4eF60XGhsSw5j6CA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=S9W9oV8Z;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=7ixcoqpM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1737112288; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P/K0I9+FJfsjVYMMwQNMy08HM0ufpR57CJCYFChWdGQ=;
	b=S9W9oV8Z5kXi6SRHqV77+Ost+/grhrVAln1nrHkmyjm7pPXub/BvsUsNzseON7RLsc8g8A
	EfT5/mY7LQHFMr/WvsFUDTljvUteWXMlhsX8SKjzfcUk/8bhLlTuM8ERbVS92GM179cj2o
	+/pO04raW5P1hX7eMyLLjNMd8oPdSJ4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1737112288;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P/K0I9+FJfsjVYMMwQNMy08HM0ufpR57CJCYFChWdGQ=;
	b=7ixcoqpMQ1SUOm0Tw09iiVOWkZJIgeQAL9s1WcJvTSi8mwm39H3M6lLauQ917bpiNc7p59
	4eF60XGhsSw5j6CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 68E9B13332;
	Fri, 17 Jan 2025 11:11:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1TI3GeA6imezXQAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 17 Jan 2025 11:11:28 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 06B1CA08E0; Fri, 17 Jan 2025 12:11:28 +0100 (CET)
Date: Fri, 17 Jan 2025 12:11:27 +0100
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huawei.com>
Cc: Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org, 
	Andreas Dilger <adilger@dilger.ca>, Alexey Zhuravlev <azhuravlev@ddn.com>, Ted Tso <tytso@mit.edu>
Subject: Re: [PATCH] jbd2: Avoid long replay times due to high number or
 revoke blocks
Message-ID: <tu5tqgicy4agkzg6uhfw3bawtp472ldmvqa4otgtn2ntetrjo7@q7eb3l5nwlyr>
References: <20250116180223.18564-2-jack@suse.cz>
 <6c9ce6fe-9d6f-49cf-b274-3355bb1ea8af@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c9ce6fe-9d6f-49cf-b274-3355bb1ea8af@huawei.com>
X-Rspamd-Queue-Id: 8183A2117A
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:email]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01
X-Spam-Flag: NO

On Fri 17-01-25 10:58:42, Zhang Yi wrote:
> On 2025/1/17 2:02, Jan Kara wrote:
> > Some users are reporting journal replay takes a long time when there is
> > excessive number of revoke blocks in the journal. Reported times are
> > like:
> > 
> > 1048576 records - 95 seconds
> > 2097152 records - 580 seconds
> > 
> > The problem is that hash chains in the revoke table gets excessively
> > long in these cases. Fix the problem by sizing the revoke table
> > appropriately before the revoke pass.
> > 
> > Thanks to Alexey Zhuravlev <azhuravlev@ddn.com> for benchmarking the patch with
> > large numbers of revoke blocks [1].
> > 
> > [1] https://lore.kernel.org/all/20250113183107.7bfef7b6@x390.bzzz77.ru
> > 
> > Signed-off-by: Jan Kara <jack@suse.cz>
> 
> Hi, Jan,
> 
> This overall patch looks good to me; however, it appears to be not
> based on the latested version of the upstream kernel, and I have one
> minor suggestion below.

OK, will do.

> > @@ -874,14 +905,16 @@ static int do_one_pass(journal_t *journal,
> >  				need_check_commit_time = true;
> >  			}
> >  
> > -			/* If we aren't in the REVOKE pass, then we can
> > -			 * just skip over this block. */
> > -			if (pass != PASS_REVOKE) {
> > +			/*
> > +			 * If we aren't in the SCAN or REVOKE pass, then we can
> > +			 * just skip over this block.
> > +			 */
> > +			if (pass != PASS_REVOKE && pass != PASS_SCAN) {
> >  				brelse(bh);
> >  				continue;
> >  			}
> 
> How about move this code snippets to the beginning of the
> JBD2_REVOKE_BLOCK branch case?

I guess a good idea after the change. Thanks!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

