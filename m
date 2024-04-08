Return-Path: <linux-ext4+bounces-1918-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 04C9C89CAD0
	for <lists+linux-ext4@lfdr.de>; Mon,  8 Apr 2024 19:31:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A43E1F21FC1
	for <lists+linux-ext4@lfdr.de>; Mon,  8 Apr 2024 17:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADE0A143C59;
	Mon,  8 Apr 2024 17:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2FwAFRh7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="C8hwhnVW";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2FwAFRh7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="C8hwhnVW"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4230B7460;
	Mon,  8 Apr 2024 17:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712597462; cv=none; b=eQmfPK3+l8yRo+7LjUcdY/K+SafrH+c+6n3FjBzl8ZcNnG0vC/c/YQDfsxqHGOdD2qbQl65x/qiXIAId9cVDt2v6fz2Xk05u3DnobsFw0SnedvrwZ1FKe01Ql/5rgn8pH4S4wXuzMnAreOaQR/wS/jtwHlKKgAtFt4hUskWa4FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712597462; c=relaxed/simple;
	bh=twqbe68/XRyzhadcXrUVGJkZd/W9Wk/J9xpcSGDM68s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ifkn+u33o/ZOl3HNPSMiyISHSuExabHxnwaCzJJbHy6KMF5ZSNluGRqrtUbPcvtL6kS/X+pLV1K3YkauKRZJxNBy1XXS/sI7yRTBwQJAIn4x4zF+xc7gne7Xi32qqHOYyVS12FsOQBRqFkfajCUKu1YEYxAoKEA+xQwBQPo1Fk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2FwAFRh7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=C8hwhnVW; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2FwAFRh7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=C8hwhnVW; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0A9A0204A7;
	Mon,  8 Apr 2024 17:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1712597458; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xV81rmNEyhjlhM2Tp+PiGt98fW3umGqOG+Ocyj52zOw=;
	b=2FwAFRh7UixIMuAfk8CfXn0J9As5n1Vz5uJDceH0553zub4gGKorsCmtkvCtWd56/qMrzu
	baCLrgN0gtQa0MroZUYWXDecNweEQrvPiI6RNgrOEOjFqgFfION/j+vaH4A2BxXdOgzbLL
	PJMwPFoaF65zmIwxl8H3DiemxMBLJPY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1712597458;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xV81rmNEyhjlhM2Tp+PiGt98fW3umGqOG+Ocyj52zOw=;
	b=C8hwhnVW0eBQH+DJAOqdmQpiJixyj+97IoCAhfaqIyz8teTcaKSFWxUb+oHw6lv4kQiO5P
	/N1Y36DbeN4daOCw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=2FwAFRh7;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=C8hwhnVW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1712597458; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xV81rmNEyhjlhM2Tp+PiGt98fW3umGqOG+Ocyj52zOw=;
	b=2FwAFRh7UixIMuAfk8CfXn0J9As5n1Vz5uJDceH0553zub4gGKorsCmtkvCtWd56/qMrzu
	baCLrgN0gtQa0MroZUYWXDecNweEQrvPiI6RNgrOEOjFqgFfION/j+vaH4A2BxXdOgzbLL
	PJMwPFoaF65zmIwxl8H3DiemxMBLJPY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1712597458;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xV81rmNEyhjlhM2Tp+PiGt98fW3umGqOG+Ocyj52zOw=;
	b=C8hwhnVW0eBQH+DJAOqdmQpiJixyj+97IoCAhfaqIyz8teTcaKSFWxUb+oHw6lv4kQiO5P
	/N1Y36DbeN4daOCw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id F2C5E13A92;
	Mon,  8 Apr 2024 17:30:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 8e89O9EpFGYkGQAAn2gu4w
	(envelope-from <jack@suse.cz>); Mon, 08 Apr 2024 17:30:57 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 89EAAA0814; Mon,  8 Apr 2024 19:30:57 +0200 (CEST)
Date: Mon, 8 Apr 2024 19:30:57 +0200
From: Jan Kara <jack@suse.cz>
To: Ye Bin <yebin10@huawei.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org, jack@suse.cz
Subject: Re: [PATCH v2 1/2] jbd2: use shrink_type type instead of bool type
 for __jbd2_journal_clean_checkpoint_list()
Message-ID: <20240408173057.3wn4pnlzrxkai5fc@quack3>
References: <20240407065355.1528580-1-yebin10@huawei.com>
 <20240407065355.1528580-2-yebin10@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240407065355.1528580-2-yebin10@huawei.com>
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 0A9A0204A7
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
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
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,suse.com:email,suse.cz:dkim,suse.cz:email,imap2.dmz-prg2.suse.org:helo,imap2.dmz-prg2.suse.org:rdns];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DKIM_TRACE(0.00)[suse.cz:+]

On Sun 07-04-24 14:53:54, Ye Bin wrote:
> "enum shrink_type" can clearly express the meaning of the parameter of
> __jbd2_journal_clean_checkpoint_list(), and there is no need to use the
> bool type.
> 
> Signed-off-by: Ye Bin <yebin10@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/jbd2/checkpoint.c | 16 +++++++++-------
>  fs/jbd2/commit.c     |  2 +-
>  include/linux/jbd2.h |  4 +++-
>  3 files changed, 13 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/jbd2/checkpoint.c b/fs/jbd2/checkpoint.c
> index 1c97e64c4784..80c0ab98bc63 100644
> --- a/fs/jbd2/checkpoint.c
> +++ b/fs/jbd2/checkpoint.c
> @@ -337,8 +337,6 @@ int jbd2_cleanup_journal_tail(journal_t *journal)
>  
>  /* Checkpoint list management */
>  
> -enum shrink_type {SHRINK_DESTROY, SHRINK_BUSY_STOP, SHRINK_BUSY_SKIP};
> -
>  /*
>   * journal_shrink_one_cp_list
>   *
> @@ -472,21 +470,25 @@ unsigned long jbd2_journal_shrink_checkpoint_list(journal_t *journal,
>   * journal_clean_checkpoint_list
>   *
>   * Find all the written-back checkpoint buffers in the journal and release them.
> - * If 'destroy' is set, release all buffers unconditionally.
> + * If 'type' is SHRINK_DESTROY, release all buffers unconditionally. If 'type'
> + * is SHRINK_BUSY_STOP, will stop release buffers if encounters a busy buffer.
> + * To avoid wasting CPU cycles scanning the buffer list in some cases, don't
> + * pass SHRINK_BUSY_SKIP 'type' for this function.
>   *
>   * Called with j_list_lock held.
>   */
> -void __jbd2_journal_clean_checkpoint_list(journal_t *journal, bool destroy)
> +void __jbd2_journal_clean_checkpoint_list(journal_t *journal,
> +					  enum shrink_type type)
>  {
>  	transaction_t *transaction, *last_transaction, *next_transaction;
> -	enum shrink_type type;
>  	bool released;
>  
> +	WARN_ON_ONCE(type == SHRINK_BUSY_SKIP);
> +
>  	transaction = journal->j_checkpoint_transactions;
>  	if (!transaction)
>  		return;
>  
> -	type = destroy ? SHRINK_DESTROY : SHRINK_BUSY_STOP;
>  	last_transaction = transaction->t_cpprev;
>  	next_transaction = transaction;
>  	do {
> @@ -527,7 +529,7 @@ void jbd2_journal_destroy_checkpoint(journal_t *journal)
>  			spin_unlock(&journal->j_list_lock);
>  			break;
>  		}
> -		__jbd2_journal_clean_checkpoint_list(journal, true);
> +		__jbd2_journal_clean_checkpoint_list(journal, SHRINK_DESTROY);
>  		spin_unlock(&journal->j_list_lock);
>  		cond_resched();
>  	}
> diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
> index 5e122586e06e..78ebd04ac97d 100644
> --- a/fs/jbd2/commit.c
> +++ b/fs/jbd2/commit.c
> @@ -501,7 +501,7 @@ void jbd2_journal_commit_transaction(journal_t *journal)
>  	 * frees some memory
>  	 */
>  	spin_lock(&journal->j_list_lock);
> -	__jbd2_journal_clean_checkpoint_list(journal, false);
> +	__jbd2_journal_clean_checkpoint_list(journal, SHRINK_BUSY_STOP);
>  	spin_unlock(&journal->j_list_lock);
>  
>  	jbd2_debug(3, "JBD2: commit phase 1\n");
> diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
> index 971f3e826e15..58a961999d70 100644
> --- a/include/linux/jbd2.h
> +++ b/include/linux/jbd2.h
> @@ -1434,7 +1434,9 @@ void jbd2_update_log_tail(journal_t *journal, tid_t tid, unsigned long block);
>  extern void jbd2_journal_commit_transaction(journal_t *);
>  
>  /* Checkpoint list management */
> -void __jbd2_journal_clean_checkpoint_list(journal_t *journal, bool destroy);
> +enum shrink_type {SHRINK_DESTROY, SHRINK_BUSY_STOP, SHRINK_BUSY_SKIP};
> +
> +void __jbd2_journal_clean_checkpoint_list(journal_t *journal, enum shrink_type type);
>  unsigned long jbd2_journal_shrink_checkpoint_list(journal_t *journal, unsigned long *nr_to_scan);
>  int __jbd2_journal_remove_checkpoint(struct journal_head *);
>  int jbd2_journal_try_remove_checkpoint(struct journal_head *jh);
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

