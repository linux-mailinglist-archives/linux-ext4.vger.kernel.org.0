Return-Path: <linux-ext4+bounces-3315-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 225DA934C20
	for <lists+linux-ext4@lfdr.de>; Thu, 18 Jul 2024 13:02:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96DDE1F223BD
	for <lists+linux-ext4@lfdr.de>; Thu, 18 Jul 2024 11:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CACC657CB1;
	Thu, 18 Jul 2024 11:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KhrmtiEI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZXGn7n7F";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="z7nuwnKN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZCK2+Nl+"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EDBA12E1ED;
	Thu, 18 Jul 2024 11:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721300419; cv=none; b=MaMmrQFnR7s6zFUiMHI6xD7UmBqjsymkxMNTsTvb83Mnb4Nq51aDE1XX7Ir5858YoqrZIuyAtVkR4QIOcQSLV1Eq7KvsM71zmUOYL2HmIifbqkua0p9ndCXYZf54HJRVRn8fS5uvXa3zEO7E7sFxud33mzclZAB3Auegr65caN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721300419; c=relaxed/simple;
	bh=ZnFBgBSdghWnOThKxFAs+bNBSnTvOa0eWC1NThbVxes=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fdu5HEwQJBqXYTT8rCLh3j1XPSvLRLUlLf3Z4trhTpJqdk1eMUnlbtnFqJC3bYudSIBhvH22FmgQPOH9iwMEL6yNuZVVQ1zu0bHTTVUVflsilWXPX+/G/jooiJuE36QDQQtVULNLpKZAj90cnl8Ppr78qk9zX9uCIqD61K4wcDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KhrmtiEI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZXGn7n7F; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=z7nuwnKN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZCK2+Nl+; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E00AD1FBCD;
	Thu, 18 Jul 2024 11:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721300416; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZKcjZ/QSjyruTeoxo246rV87qrDID/c6cWL+ycl2EnY=;
	b=KhrmtiEI/XMEwFb/mSqs2YLOq3S4slfLXlAtsNXzLI1ca4wieMWLBxz667Ao3kZupIB+UH
	eeZJddx8qESOAMofQw/OQvG3+mzHfHcgJNTYPkotHQCxj0h4VUtlFQ+VOOsRVT1xy9IpAD
	NnDCyOMr5aENe8wSqzLb7VsgFOpA0eI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721300416;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZKcjZ/QSjyruTeoxo246rV87qrDID/c6cWL+ycl2EnY=;
	b=ZXGn7n7FozqiYIWEQR9tm1GsTOzV3kdPQMShOWGKU72yjJE634QNVR3MYnDi2CojfU97dF
	s1GNpAJWwEEDO2Dg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=z7nuwnKN;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ZCK2+Nl+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721300415; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZKcjZ/QSjyruTeoxo246rV87qrDID/c6cWL+ycl2EnY=;
	b=z7nuwnKNAwwDjeqeFOiZQgOaBCXDJ9dMkRdfsckxJvrVqWIh5yVDuTe7mlaKnpwIi65I63
	pLq8NBIISNLtZC4thXJkMQba+a7BIUtuwqCyPXRUr0xrAx1MuwISB/812wZ2Wys+v7W7oN
	8U/aKQwCOzEyv72yIfXW18UUbONsVqM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721300415;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZKcjZ/QSjyruTeoxo246rV87qrDID/c6cWL+ycl2EnY=;
	b=ZCK2+Nl+A6tFn2FEVbYes4Xwz0t5TnVny6G/nduVOTD4TaiKTVHbZ2I3SU1pBi1HW/2cGP
	EvB3qpuCLPmNZZCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D2189137EB;
	Thu, 18 Jul 2024 11:00:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id No5MM7/1mGZiVQAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 18 Jul 2024 11:00:15 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 743B8A0987; Thu, 18 Jul 2024 13:00:11 +0200 (CEST)
Date: Thu, 18 Jul 2024 13:00:11 +0200
From: Jan Kara <jack@suse.cz>
To: "Luis Henriques (SUSE)" <luis.henriques@linux.dev>
Cc: Theodore Ts'o <tytso@mit.edu>, Andreas Dilger <adilger@dilger.ca>,
	Jan Kara <jack@suse.cz>,
	Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] ext4: fix fast commit inode enqueueing during a full
 journal commit
Message-ID: <20240718110011.p2sq5hdy57nqkpxg@quack3>
References: <20240717172220.14201-1-luis.henriques@linux.dev>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240717172220.14201-1-luis.henriques@linux.dev>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[mit.edu,dilger.ca,suse.cz,gmail.com,vger.kernel.org];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,linux.dev:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:email,suse.cz:dkim]
X-Spam-Flag: NO
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01
X-Spam-Level: 
X-Rspamd-Queue-Id: E00AD1FBCD

On Wed 17-07-24 18:22:20, Luis Henriques (SUSE) wrote:
> When a full journal commit is on-going, any fast commit has to be enqueued
> into a different queue: FC_Q_STAGING instead of FC_Q_MAIN.  This enqueueing
> is done only once, i.e. if an inode is already queued in a previous fast
> commit entry it won't be enqueued again.  However, if a full commit starts
> _after_ the inode is enqueued into FC_Q_MAIN, the next fast commit needs to
> be done into FC_Q_STAGING.  And this is not being done in function
> ext4_fc_track_template().
> 
> This patch fixes the issue by re-enqueuing an inode into the STAGING queue
> during the fast commit clean-up callback when doing a full commit.  However,
> to prevent a race with a fast-commit, the clean-up callback has to be called
> with the journal locked.
> 
> This bug was found using fstest generic/047.  This test creates several 32k
> bytes files, sync'ing each of them after it's creation, and then shutting
> down the filesystem.  Some data may be loss in this operation; for example a
> file may have it's size truncated to zero.
> 
> Suggested-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Luis Henriques (SUSE) <luis.henriques@linux.dev>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> Hi!
> 
> And here's another attempt to fix this bug.  The most significant change is
> that now it doesn't assume a 'special' meaning for a tid of '0'.  Which is
> a wrong assumption as Jan has shown.
> 
> I've also added a Suggested-by: tag, although Jan pretty much owns this
> patch -- I have simply tested it and sent it out!
> 
>  fs/ext4/fast_commit.c | 15 ++++++++++++++-
>  fs/jbd2/journal.c     |  2 +-
>  2 files changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
> index 3926a05eceee..df71fd5b1fed 100644
> --- a/fs/ext4/fast_commit.c
> +++ b/fs/ext4/fast_commit.c
> @@ -1288,8 +1288,21 @@ static void ext4_fc_cleanup(journal_t *journal, int full, tid_t tid)
>  		list_del_init(&iter->i_fc_list);
>  		ext4_clear_inode_state(&iter->vfs_inode,
>  				       EXT4_STATE_FC_COMMITTING);
> -		if (tid_geq(tid, iter->i_sync_tid))
> +		if (tid_geq(tid, iter->i_sync_tid)) {
>  			ext4_fc_reset_inode(&iter->vfs_inode);
> +		} else if (full) {
> +			/*
> +			 * We are called after a full commit, inode has been
> +			 * modified while the commit was running. Re-enqueue
> +			 * the inode into STAGING, which will then be splice
> +			 * back into MAIN. This cannot happen during
> +			 * fastcommit because the journal is locked all the
> +			 * time in that case (and tid doesn't increase so
> +			 * tid check above isn't reliable).
> +			 */
> +			list_add_tail(&EXT4_I(&iter->vfs_inode)->i_fc_list,
> +				      &sbi->s_fc_q[FC_Q_STAGING]);
> +		}
>  		/* Make sure EXT4_STATE_FC_COMMITTING bit is clear */
>  		smp_mb();
>  #if (BITS_PER_LONG < 64)
> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> index 1ebf2393bfb7..291a431f8aaf 100644
> --- a/fs/jbd2/journal.c
> +++ b/fs/jbd2/journal.c
> @@ -740,9 +740,9 @@ EXPORT_SYMBOL(jbd2_fc_begin_commit);
>   */
>  static int __jbd2_fc_end_commit(journal_t *journal, tid_t tid, bool fallback)
>  {
> -	jbd2_journal_unlock_updates(journal);
>  	if (journal->j_fc_cleanup_callback)
>  		journal->j_fc_cleanup_callback(journal, 0, tid);
> +	jbd2_journal_unlock_updates(journal);
>  	write_lock(&journal->j_state_lock);
>  	journal->j_flags &= ~JBD2_FAST_COMMIT_ONGOING;
>  	if (fallback)
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

