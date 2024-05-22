Return-Path: <linux-ext4+bounces-2624-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB1F38CBF4E
	for <lists+linux-ext4@lfdr.de>; Wed, 22 May 2024 12:36:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DE0D1F229BB
	for <lists+linux-ext4@lfdr.de>; Wed, 22 May 2024 10:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD95B823CC;
	Wed, 22 May 2024 10:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qIT7W79F";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="vleHrvQv";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qIT7W79F";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="vleHrvQv"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855CB405CC;
	Wed, 22 May 2024 10:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716374153; cv=none; b=ofpZC63IJAGPhpaErbJJSs7XN2kuxt4jln8c5hCug0FUArqhBbliNhPNdyfn4EmYLX5ETGTwSb30yoQqaLTUWIqs00E4W9hnUXNR3tnyA4MCtsXz0qNqIGIzKP3KJ4HNyxFmHm83Py7EbOMI6Bu54AUYxtqvWlSyF/SCJWg9Ap0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716374153; c=relaxed/simple;
	bh=L4ojqItERhC/vUlkg2RLWZA0UCsWXUSx3Spew+SToow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UyiU1I5g50MmfcFuxqeo2V5PfUlfs6LLa3pIBt8JCazciCh7hMJc5RZ6wkUVt08IsDZuSsqD35z2GbJ35qYCs35wy0HE0B/CvtlKn2/e3YFn1Y07LK8pWQDXbncvP1fbsBFeqIM2Dp6qtZzsNYvS1R0GZYjVmqbA7ywPhXmVXzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qIT7W79F; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=vleHrvQv; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qIT7W79F; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=vleHrvQv; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 897495C793;
	Wed, 22 May 2024 10:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716374149; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KIzmfr/9qh4BgQPDRngO8Z5BAg5puL/OuUQ2VMHKt3E=;
	b=qIT7W79F66Z/+Xwj7wnVBu5IfWNCqoGsEd8LsGggFveAzbxRW5ZI5fx6LMKgStJpOZKTW+
	9XiJGPWIDREZVWlNpM8EZOVXwm6mxIlHh3eAgF0cKzUCSqiWs6MNXxSs0yhOI63tgqV8LV
	OR/LfYVhJO7Pdrx0VwNuRLgHNdS/Y48=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716374149;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KIzmfr/9qh4BgQPDRngO8Z5BAg5puL/OuUQ2VMHKt3E=;
	b=vleHrvQvMNrSarVyih/NojeIemyY6oLUs6ltmfowHFlRTsM97giHd29ERp5GPmCvDifdsO
	ZKlyOcXSSHrm2cAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716374149; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KIzmfr/9qh4BgQPDRngO8Z5BAg5puL/OuUQ2VMHKt3E=;
	b=qIT7W79F66Z/+Xwj7wnVBu5IfWNCqoGsEd8LsGggFveAzbxRW5ZI5fx6LMKgStJpOZKTW+
	9XiJGPWIDREZVWlNpM8EZOVXwm6mxIlHh3eAgF0cKzUCSqiWs6MNXxSs0yhOI63tgqV8LV
	OR/LfYVhJO7Pdrx0VwNuRLgHNdS/Y48=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716374149;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KIzmfr/9qh4BgQPDRngO8Z5BAg5puL/OuUQ2VMHKt3E=;
	b=vleHrvQvMNrSarVyih/NojeIemyY6oLUs6ltmfowHFlRTsM97giHd29ERp5GPmCvDifdsO
	ZKlyOcXSSHrm2cAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7B89A13A6B;
	Wed, 22 May 2024 10:35:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OFEkHoXKTWb4NwAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 22 May 2024 10:35:49 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 2B538A0861; Wed, 22 May 2024 12:35:45 +0200 (CEST)
Date: Wed, 22 May 2024 12:35:45 +0200
From: Jan Kara <jack@suse.cz>
To: "Luis Henriques (SUSE)" <luis.henriques@linux.dev>
Cc: Theodore Ts'o <tytso@mit.edu>, Andreas Dilger <adilger@dilger.ca>,
	Jan Kara <jack@suse.com>, linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] ext4: fix fast commit inode enqueueing during a
 full journal commit
Message-ID: <20240522103545.ypmmoyxvls52i6yl@quack3>
References: <20240521154535.12911-1-luis.henriques@linux.dev>
 <20240521154535.12911-2-luis.henriques@linux.dev>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240521154535.12911-2-luis.henriques@linux.dev>
X-Spam-Level: 
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
	RCPT_COUNT_FIVE(0.00)[6];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Score: -3.80
X-Spam-Flag: NO

On Tue 21-05-24 16:45:34, Luis Henriques (SUSE) wrote:
> When a full journal commit is on-going, any fast commit has to be enqueued
> into a different queue: FC_Q_STAGING instead of FC_Q_MAIN.  This enqueueing
> is done only once, i.e. if an inode is already queued in a previous fast
> commit entry it won't be enqueued again.  However, if a full commit starts
> _after_ the inode is enqueued into FC_Q_MAIN, the next fast commit needs to
> be done into FC_Q_STAGING.  And this is not being done in function
> ext4_fc_track_template().

Ah, good catch.

> This patch fixes the issue by simply re-enqueuing the inode from the MAIN
> into the STAGING queue.
> 
> This bug was found using fstest generic/047.  This test creates several 32k
> bytes files, sync'ing each of them after it's creation, and then shutting
> down the filesystem.  Some data may be loss in this operation; for example a
> file may have it's size truncated to zero.
> 
> Signed-off-by: Luis Henriques (SUSE) <luis.henriques@linux.dev>
> ---
>  fs/ext4/fast_commit.c | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
> index 87c009e0c59a..337b5289cf11 100644
> --- a/fs/ext4/fast_commit.c
> +++ b/fs/ext4/fast_commit.c
> @@ -396,12 +396,19 @@ static int ext4_fc_track_template(
>  		return ret;
>  
>  	spin_lock(&sbi->s_fc_lock);
> -	if (list_empty(&EXT4_I(inode)->i_fc_list))
> -		list_add_tail(&EXT4_I(inode)->i_fc_list,
> -				(sbi->s_journal->j_flags & JBD2_FULL_COMMIT_ONGOING ||
> -				 sbi->s_journal->j_flags & JBD2_FAST_COMMIT_ONGOING) ?
> -				&sbi->s_fc_q[FC_Q_STAGING] :
> -				&sbi->s_fc_q[FC_Q_MAIN]);
> +	if (sbi->s_journal->j_flags & JBD2_FULL_COMMIT_ONGOING ||
> +	    sbi->s_journal->j_flags & JBD2_FAST_COMMIT_ONGOING) {
> +		if (list_empty(&EXT4_I(inode)->i_fc_list))
> +			list_add_tail(&EXT4_I(inode)->i_fc_list,
> +				      &sbi->s_fc_q[FC_Q_STAGING]);
> +		else
> +			list_move_tail(&EXT4_I(inode)->i_fc_list,
> +				       &sbi->s_fc_q[FC_Q_STAGING]);

So I'm not sure this is actually safe. I'm concerned about the following
race:

Task1					Task2

					handle = ext4_journal_start(..)
modify inode_X
  ext4_fc_track_inode(inode_X)
ext4_fsync(inode_X)
  ext4_fc_commit()
    jbd2_fc_begin_commit()
      journal->j_flags |= JBD2_FAST_COMMIT_ONGOING;
      ...
      jbd2_journal_lock_updates()
        blocks waiting for handle of Task2
					modify inode_X
					  ext4_fc_track_inode(inode_X)
					    - moves inode out of FC_Q_MAIN
					ext4_journal_stop()
    fast commit proceeds but skips inode_X...

How we deal with a similar issue in jbd2 for ordinary buffers is that we
just mark the buffer as *also* belonging to the next transaction (by
setting jh->b_next_transaction) and during commit cleanup we move the bh to
the appropriate list of the next transaction. Here, we could mark the inode
as also being part of the next fast commit and during fastcommit cleanup we
could move it to FC_Q_STAGING which is then spliced back to FC_Q_MAIN.

Also Harshad has recently posted changes to fast commit code that modify
how fast commits are serialized (in particular jbd2_journal_lock_updates()
is gone). I didn't read them yet but your change definitely needs a careful
verification against those changes to make sure we don't introduce new data
integrity issues.

> +	} else {
> +		if (list_empty(&EXT4_I(inode)->i_fc_list))
> +			list_add_tail(&EXT4_I(inode)->i_fc_list,
> +				      &sbi->s_fc_q[FC_Q_MAIN]);
> +	}
>  	spin_unlock(&sbi->s_fc_lock);
>  
>  	return ret;

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

