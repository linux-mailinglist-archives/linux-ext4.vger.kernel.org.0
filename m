Return-Path: <linux-ext4+bounces-2625-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD42C8CBF65
	for <lists+linux-ext4@lfdr.de>; Wed, 22 May 2024 12:45:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E15571C20E94
	for <lists+linux-ext4@lfdr.de>; Wed, 22 May 2024 10:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04C5282491;
	Wed, 22 May 2024 10:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="AjgjKYEq";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="6OO8ThvD";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="EiR1Zyvw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4+H7d7FA"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E413A8002E;
	Wed, 22 May 2024 10:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716374710; cv=none; b=usfxbE3tq6WB6hU+Gfqhi9ti8tSB5EdumEiDaKPmldwVrBsMQ9ovIawMbXzSORF8gLlNStEdDCLyOa3vXIVi22fBWtWZaIQliiA4czfarZOon3IikRt1PCHvTNXUvBoExGOhQdm3f1FbbC47ibFi1b9TnV3uTgO/ndYA7BKi6NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716374710; c=relaxed/simple;
	bh=RA3qaOFWbz7fU3CE2Fiqb8Q+sEfpMukAVJztfPUeXac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qCwv8Euj/yTztqPbUT4KjrOcdciE8HEd/c4d20PWCotE9Nm+2eKBtWfsTm9Fq6lsB/N6dLCxgTxIxrTi4tb2rnRhg+fajL6bR+BWnbBtuj89j3ABdfFCcfZhkRH7pk1/SU4gaLbY4+9VoDZzsYy3fGlR7NtbXdBvr5XcQqziyt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=AjgjKYEq; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=6OO8ThvD; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=EiR1Zyvw; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4+H7d7FA; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D23CA5C798;
	Wed, 22 May 2024 10:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716374705; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HJ9io9qYP6ulq/5g7SWFYCZQV6Nuer7VvEkHzj8oJtE=;
	b=AjgjKYEqutEQcGvDS9rblBSel3bmFS48XpoAd4J80BRHMxiEVyr+Crz+sT7ei0O7OWus/x
	hf+KIEacKQ4ldqZv94v3s6UHym1tH/VtvQ9xbx6NT8OIcev7UYRg7m6sqPtFUWT9O44/co
	dNcmXl129bXEYLyyk6NszqSwRHhcdco=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716374705;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HJ9io9qYP6ulq/5g7SWFYCZQV6Nuer7VvEkHzj8oJtE=;
	b=6OO8ThvDur3d+LuV5XuLqpS3uvS4Bs9dLT8NK5i7UQTtWgYWEUSTJ0odi8nUqUdjo1o1q5
	BFDKAIRGx1zu9UAw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=EiR1Zyvw;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=4+H7d7FA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716374704; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HJ9io9qYP6ulq/5g7SWFYCZQV6Nuer7VvEkHzj8oJtE=;
	b=EiR1Zyvw78Af7Mq+vNKtpE7hdnQ+K5j+sWlBhE7lD9Gu/AXsqeNwfvO9nS2QQE6DHjd+mv
	EKm6MK44VYl1whMfuvFZZs+qdThqTZFbafwArC5wu9Xqw8fdalb9uhzvxbpgY4Z3OUXCur
	OqYtKR31gkAg0U1XLIGoQ1BnZhwq9F4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716374704;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HJ9io9qYP6ulq/5g7SWFYCZQV6Nuer7VvEkHzj8oJtE=;
	b=4+H7d7FADkr2r51u8fMdSAxFg7LN+W61GJOGklC3w8ixkKWRWYZmNSQISVlLrq1Dm4Wu3E
	ciV7x2jE51TkY6BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C2E8F13A6B;
	Wed, 22 May 2024 10:45:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id k/VKL7DMTWb2ZQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 22 May 2024 10:45:04 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 6A7D9A0861; Wed, 22 May 2024 12:45:00 +0200 (CEST)
Date: Wed, 22 May 2024 12:45:00 +0200
From: Jan Kara <jack@suse.cz>
To: "Luis Henriques (SUSE)" <luis.henriques@linux.dev>
Cc: Theodore Ts'o <tytso@mit.edu>, Andreas Dilger <adilger@dilger.ca>,
	Jan Kara <jack@suse.com>, linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] jbd2: reset fast commit offset only after fs
 cleanup is done
Message-ID: <20240522104500.z343a6xqfduuq5i3@quack3>
References: <20240521154535.12911-1-luis.henriques@linux.dev>
 <20240521154535.12911-3-luis.henriques@linux.dev>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240521154535.12911-3-luis.henriques@linux.dev>
X-Spam-Flag: NO
X-Spam-Score: -3.93
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: D23CA5C798
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.93 / 50.00];
	BAYES_HAM(-2.92)[99.68%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,linux.dev:email,suse.cz:dkim]

On Tue 21-05-24 16:45:35, Luis Henriques (SUSE) wrote:
> When doing a journal commit, the fast journal offset (journal->j_fc_off) is
> set to zero too early in the process.  Since ext4 filesystem calls function
> jbd2_fc_release_bufs() in its j_fc_cleanup_callback (ext4_fc_cleanup()),
> that call will be a no-op exactly because the offset is zero.
> 
> Move the fast commit offset further down in the journal commit code, until
> it's mostly done, immediately before clearing the on-going commit flags.
> 
> Signed-off-by: Luis Henriques (SUSE) <luis.henriques@linux.dev>

Did you see any particular failure because of this? Because AFAICS the
buffers cleaned up by jbd2_fc_release_bufs() are only allocated during fast
commit (from ext4_fc_reserve_space()). And the code in
jbd2_journal_commit_transaction() is making sure fast commit isn't running
before we set journal->j_fc_off to 0.

								Honza

> ---
>  fs/jbd2/commit.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
> index 75ea4e9a5cab..88b834c7c9c9 100644
> --- a/fs/jbd2/commit.c
> +++ b/fs/jbd2/commit.c
> @@ -435,7 +435,6 @@ void jbd2_journal_commit_transaction(journal_t *journal)
>  			commit_transaction->t_tid);
>  
>  	write_lock(&journal->j_state_lock);
> -	journal->j_fc_off = 0;
>  	J_ASSERT(commit_transaction->t_state == T_RUNNING);
>  	commit_transaction->t_state = T_LOCKED;
>  
> @@ -1133,6 +1132,7 @@ void jbd2_journal_commit_transaction(journal_t *journal)
>  		  journal->j_commit_sequence, journal->j_tail_sequence);
>  
>  	write_lock(&journal->j_state_lock);
> +	journal->j_fc_off = 0;
>  	journal->j_flags &= ~JBD2_FULL_COMMIT_ONGOING;
>  	journal->j_flags &= ~JBD2_FAST_COMMIT_ONGOING;
>  	spin_lock(&journal->j_list_lock);
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

