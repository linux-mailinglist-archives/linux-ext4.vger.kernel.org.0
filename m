Return-Path: <linux-ext4+bounces-3019-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2287791BFCD
	for <lists+linux-ext4@lfdr.de>; Fri, 28 Jun 2024 15:43:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEB1C2843AE
	for <lists+linux-ext4@lfdr.de>; Fri, 28 Jun 2024 13:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5CD6153BFC;
	Fri, 28 Jun 2024 13:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sCYB+Fd5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="GTe5AtCi";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sCYB+Fd5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="GTe5AtCi"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB1A1E495
	for <linux-ext4@vger.kernel.org>; Fri, 28 Jun 2024 13:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719582199; cv=none; b=U8jOFhCv5PyYaoCk6wmGt1XQDm42d5oL+vfPqjLPfA5IIi0smQd86oDFEqXQt3V+1AnF91IA/3NplahdrnM+3K7fYWERa4WbtbnRWbkETb4aHCZ/hUogr1ybqTVMrwqWKU4UDRPxvhxFBy9AdTGQjFE35cwIqVKrwMNp5um1q7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719582199; c=relaxed/simple;
	bh=yuAZ8M7dkqhbTi2uIlJVkWH+eGMBsTaZL5Hzs75gX74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k6EakMEtGp/H117l+4L9guTe35rVfct4QTLBzNJ6MlsgPN7rkO+F+UgV/lS2AMDfQ+exFmiwlylsZo+Ff6b2JXJ8+ol2TGjkLAmnSmLV273LS9wKQaEE+0h5vk+nnQZw8WbGiKAYAySgDQoTqZv6uBCbPTyfOikPic2ooNAYQ80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=sCYB+Fd5; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=GTe5AtCi; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=sCYB+Fd5; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=GTe5AtCi; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5AFD41F454;
	Fri, 28 Jun 2024 13:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719582195; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6QCkmX0KyVqXqYVr724jmzNarYZg9hr4xtpsutFsF8o=;
	b=sCYB+Fd52457pxGzgj9iTXjQdAvbbZS1iNTj9ImBs63lj5F76hxEvdhp6Z0+rqAeeSG3ML
	VpendoeYPB3q1BNP5JLc8bRZMGYL+eq5Yk0G+1MXgwy9Ny1G1W8WPifh3C0g5CeoeZ9Xax
	wgasORxsytSbpuMBgF0t0xOZvlhY7wA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719582195;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6QCkmX0KyVqXqYVr724jmzNarYZg9hr4xtpsutFsF8o=;
	b=GTe5AtCiXnTZiyPcpxbFtSsfSiSEk2eiR7NXdSw3UPxk2ZUqU5vHmTWdoj42lIPorVosU3
	nhm9iI/HsOCEuKAw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=sCYB+Fd5;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=GTe5AtCi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719582195; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6QCkmX0KyVqXqYVr724jmzNarYZg9hr4xtpsutFsF8o=;
	b=sCYB+Fd52457pxGzgj9iTXjQdAvbbZS1iNTj9ImBs63lj5F76hxEvdhp6Z0+rqAeeSG3ML
	VpendoeYPB3q1BNP5JLc8bRZMGYL+eq5Yk0G+1MXgwy9Ny1G1W8WPifh3C0g5CeoeZ9Xax
	wgasORxsytSbpuMBgF0t0xOZvlhY7wA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719582195;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6QCkmX0KyVqXqYVr724jmzNarYZg9hr4xtpsutFsF8o=;
	b=GTe5AtCiXnTZiyPcpxbFtSsfSiSEk2eiR7NXdSw3UPxk2ZUqU5vHmTWdoj42lIPorVosU3
	nhm9iI/HsOCEuKAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4FD8013375;
	Fri, 28 Jun 2024 13:43:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id JyZ6E/O9fmY2BQAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 28 Jun 2024 13:43:15 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id CC8A5A088E; Fri, 28 Jun 2024 15:43:10 +0200 (CEST)
Date: Fri, 28 Jun 2024 15:43:10 +0200
From: Jan Kara <jack@suse.cz>
To: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, saukad@google.com,
	harshads@google.com
Subject: Re: [PATCH v6 04/10] ext4: rework fast commit commit path
Message-ID: <20240628134310.jlne3gscmac3e2ab@quack3>
References: <20240529012003.4006535-1-harshadshirwadkar@gmail.com>
 <20240529012003.4006535-5-harshadshirwadkar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240529012003.4006535-5-harshadshirwadkar@gmail.com>
X-Rspamd-Queue-Id: 5AFD41F454
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
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On Wed 29-05-24 01:19:57, Harshad Shirwadkar wrote:
> This patch reworks fast commit's commit path to remove locking the
> journal for the entire duration of a fast commit. Instead, we only lock
> the journal while marking all the eligible inodes as "committing". This
> allows handles to make progress in parallel with the fast commit.
> 
> Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
...
> @@ -1124,6 +1119,20 @@ static int ext4_fc_perform_commit(journal_t *journal)
>  	int ret = 0;
>  	u32 crc = 0;
>  
> +	/*
> +	 * Wait for all the handles of the current transaction to complete
> +	 * and then lock the journal. Since this is essentially the commit
> +	 * path, we don't need to wait for reserved handles.
> +	 */

Here I'd expand the comment to explain better why this is safe. Like:

	/*
	 * Wait for all the handles of the current transaction to complete
	 * and then lock the journal. We don't need to wait for reserved
	 * handles since we only need to set EXT4_STATE_FC_COMMITTING state
	 * while the journal is locked - in particular we don't depend on
	 * page writeback state so there's no risk of deadlocking reserved
	 * handles.
	 */

> +	jbd2_journal_lock_updates_no_rsv(journal);
> +	spin_lock(&sbi->s_fc_lock);
> +	list_for_each_entry(iter, &sbi->s_fc_q[FC_Q_MAIN], i_fc_list) {
> +		ext4_set_inode_state(&iter->vfs_inode,
> +				     EXT4_STATE_FC_COMMITTING);
> +	}
> +	spin_unlock(&sbi->s_fc_lock);
> +	jbd2_journal_unlock_updates(journal);
> +
>  	ret = ext4_fc_submit_inode_data_all(journal);
>  	if (ret)
>  		return ret;
> @@ -1174,6 +1183,18 @@ static int ext4_fc_perform_commit(journal_t *journal)
>  		ret = ext4_fc_write_inode(inode, &crc);
>  		if (ret)
>  			goto out;
> +		ext4_clear_inode_state(inode, EXT4_STATE_FC_COMMITTING);
> +		/*
> +		 * Make sure clearing of EXT4_STATE_FC_COMMITTING is
> +		 * visible before we send the wakeup. Pairs with implicit
> +		 * barrier in prepare_to_wait() in ext4_fc_track_inode().
> +		 */
> +		smp_mb();
> +#if (BITS_PER_LONG < 64)
> +		wake_up_bit(&iter->i_state_flags, EXT4_STATE_FC_COMMITTING);
> +#else
> +		wake_up_bit(&iter->i_flags, EXT4_STATE_FC_COMMITTING);
> +#endif

Maybe create a helper function for clearing the EXT4_STATE_FC_COMMITTING
bit and waking up the wait queue? It's a bit subtle and used in a few
places.

> diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
> index cb0b8d6fc0c6..4361e5c56490 100644
> --- a/fs/jbd2/transaction.c
> +++ b/fs/jbd2/transaction.c
> @@ -865,25 +865,15 @@ void jbd2_journal_wait_updates(journal_t *journal)
>  	}
>  }
>  
> -/**
> - * jbd2_journal_lock_updates () - establish a transaction barrier.
> - * @journal:  Journal to establish a barrier on.
> - *
> - * This locks out any further updates from being started, and blocks
> - * until all existing updates have completed, returning only once the
> - * journal is in a quiescent state with no updates running.
> - *
> - * The journal lock should not be held on entry.
> - */
> -void jbd2_journal_lock_updates(journal_t *journal)
> +static void __jbd2_journal_lock_updates(journal_t *journal, bool wait_on_rsv)
>  {
>  	jbd2_might_wait_for_commit(journal);
>  
>  	write_lock(&journal->j_state_lock);
>  	++journal->j_barrier_count;
>  
> -	/* Wait until there are no reserved handles */
> -	if (atomic_read(&journal->j_reserved_credits)) {
> +	if (wait_on_rsv && atomic_read(&journal->j_reserved_credits)) {
> +		/* Wait until there are no reserved handles */

So it is not as simple as this. start_this_handle() ignores
journal->j_barrier_count for reserved handles so they would happily start
while you have the journal locked with jbd2_journal_lock_updates_no_rsv()
and then writeback code could mess with your fastcommit state. Or perhaps I
miss some subtlety why this is fine - but that then deserves a good
explanation in a comment or maybe a different API because currently
jbd2_journal_lock_updates_no_rsv() doesn't do what one would naively
expect.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

