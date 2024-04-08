Return-Path: <linux-ext4+bounces-1919-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 47E5789CAD2
	for <lists+linux-ext4@lfdr.de>; Mon,  8 Apr 2024 19:31:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F7C3B24D1B
	for <lists+linux-ext4@lfdr.de>; Mon,  8 Apr 2024 17:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CB76143C64;
	Mon,  8 Apr 2024 17:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="tnqnRbDq";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="A4ro0jLC";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gEBNZHNU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="hCELz8T9"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E9C7460;
	Mon,  8 Apr 2024 17:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712597479; cv=none; b=djETH7C+qbncEFTj3unNf8NQ2qoR10KPwFrx4aND21G4eRf1qDbUkEhKIWRaDdcUPz9V+8lRmwuo/JvitWSB74ZsR4sOW+6GhAe7WFuIXQFTpYlHUp89GaPD6RkeqNiXa3AFUSP5S8L6hQI0IiSPOTxhPbukIEWZOJak/MrmWIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712597479; c=relaxed/simple;
	bh=QmunCE9r7aHe7NyWJn9cE2x8M9nPtBbMsTDcmO+sWXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hod8LCaC8nxMzI+XtoIvjwWnkmyoLcFdU6L/zCPg/5YoRNDKpTEmul0MqNldxB3XU88wP5QQWDfZQ7swKNqnRVdq8J9wWFe82O952gtU5HvAPnEt+poDZF4pX0Y8eEbG/NCVbNC6v/oMInGA/J2gmM3UCBBVrY4B7jOmbX4NGjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=tnqnRbDq; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=A4ro0jLC; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gEBNZHNU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=hCELz8T9; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E51EF204A8;
	Mon,  8 Apr 2024 17:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1712597476; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e8wSl4Qy94bbQ6nWeZXuT+KUZw5twMVN28n0HjkxqKs=;
	b=tnqnRbDq+tNxbDlOlgflkL2rqKcbFO55lax68gpXnk6O49o8qu+r5pLjXDMpT31pYbpbxN
	zKUTPwULTLXsrSfwmZWv0dfPn2obORmpWS6w26cGutz7y6pkQG/AXoLzp09onMH0JNmT0U
	Sx0Q69QoWh5teP4+vCIk7CYw+fjffOg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1712597476;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e8wSl4Qy94bbQ6nWeZXuT+KUZw5twMVN28n0HjkxqKs=;
	b=A4ro0jLCGk6EuBbFXbxwbmBYJn7gY5Xym76CuSSPbi4stYUcl0K6qyyZ4AfpfcloqBeB1M
	+aGjPKGZwPXiXYBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1712597475; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e8wSl4Qy94bbQ6nWeZXuT+KUZw5twMVN28n0HjkxqKs=;
	b=gEBNZHNU0j4nSxpXR59U7TFYTL4Ky/M0+W5r/j9CGVkNoUFCXUwf2zkt4cb7l/XKPRo7eR
	bGuv70x8C89K0A0BDaxTgL3SxmbP5DfTfQwE6MTVPTZ2Dua1QQVLiwAevS3kV6Joj4Pl1n
	eWfusq3WxdYcRKlHFQBAO/GYeFkmpC4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1712597475;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e8wSl4Qy94bbQ6nWeZXuT+KUZw5twMVN28n0HjkxqKs=;
	b=hCELz8T9RLbBU2K991ulmNxj2s/PPlVwK3kpb3mJcO28abuMm8dU1/lO3X8jLt9aw2P5qH
	HMEKjUrjpqhMkiAg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id D63BC13A92;
	Mon,  8 Apr 2024 17:31:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id /pxNNOMpFGY6GQAAn2gu4w
	(envelope-from <jack@suse.cz>); Mon, 08 Apr 2024 17:31:15 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 92012A0814; Mon,  8 Apr 2024 19:31:07 +0200 (CEST)
Date: Mon, 8 Apr 2024 19:31:07 +0200
From: Jan Kara <jack@suse.cz>
To: Ye Bin <yebin10@huawei.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org, jack@suse.cz
Subject: Re: [PATCH v2 2/2] jbd2: add prefix 'jbd2' for 'shrink_type'
Message-ID: <20240408173107.zq3sus2qq3ln5dth@quack3>
References: <20240407065355.1528580-1-yebin10@huawei.com>
 <20240407065355.1528580-3-yebin10@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240407065355.1528580-3-yebin10@huawei.com>
X-Spam-Flag: NO
X-Spam-Score: -3.80
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,imap2.dmz-prg2.suse.org:helo,imap2.dmz-prg2.suse.org:rdns,suse.com:email,suse.cz:email]

On Sun 07-04-24 14:53:55, Ye Bin wrote:
> As 'shrink_type' is exported. The module prefix 'jbd2' is added to
> distinguish from memory reclamation.
> 
> Signed-off-by: Ye Bin <yebin10@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/jbd2/checkpoint.c | 22 +++++++++++-----------
>  fs/jbd2/commit.c     |  2 +-
>  include/linux/jbd2.h |  4 ++--
>  3 files changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/jbd2/checkpoint.c b/fs/jbd2/checkpoint.c
> index 80c0ab98bc63..951f78634adf 100644
> --- a/fs/jbd2/checkpoint.c
> +++ b/fs/jbd2/checkpoint.c
> @@ -348,7 +348,7 @@ int jbd2_cleanup_journal_tail(journal_t *journal)
>   * Called with j_list_lock held.
>   */
>  static unsigned long journal_shrink_one_cp_list(struct journal_head *jh,
> -						enum shrink_type type,
> +						enum jbd2_shrink_type type,
>  						bool *released)
>  {
>  	struct journal_head *last_jh;
> @@ -365,12 +365,12 @@ static unsigned long journal_shrink_one_cp_list(struct journal_head *jh,
>  		jh = next_jh;
>  		next_jh = jh->b_cpnext;
>  
> -		if (type == SHRINK_DESTROY) {
> +		if (type == JBD2_SHRINK_DESTROY) {
>  			ret = __jbd2_journal_remove_checkpoint(jh);
>  		} else {
>  			ret = jbd2_journal_try_remove_checkpoint(jh);
>  			if (ret < 0) {
> -				if (type == SHRINK_BUSY_SKIP)
> +				if (type == JBD2_SHRINK_BUSY_SKIP)
>  					continue;
>  				break;
>  			}
> @@ -437,7 +437,7 @@ unsigned long jbd2_journal_shrink_checkpoint_list(journal_t *journal,
>  		tid = transaction->t_tid;
>  
>  		freed = journal_shrink_one_cp_list(transaction->t_checkpoint_list,
> -						   SHRINK_BUSY_SKIP, &released);
> +						   JBD2_SHRINK_BUSY_SKIP, &released);
>  		nr_freed += freed;
>  		(*nr_to_scan) -= min(*nr_to_scan, freed);
>  		if (*nr_to_scan == 0)
> @@ -470,20 +470,20 @@ unsigned long jbd2_journal_shrink_checkpoint_list(journal_t *journal,
>   * journal_clean_checkpoint_list
>   *
>   * Find all the written-back checkpoint buffers in the journal and release them.
> - * If 'type' is SHRINK_DESTROY, release all buffers unconditionally. If 'type'
> - * is SHRINK_BUSY_STOP, will stop release buffers if encounters a busy buffer.
> - * To avoid wasting CPU cycles scanning the buffer list in some cases, don't
> - * pass SHRINK_BUSY_SKIP 'type' for this function.
> + * If 'type' is JBD2_SHRINK_DESTROY, release all buffers unconditionally. If
> + * 'type' is JBD2_SHRINK_BUSY_STOP, will stop release buffers if encounters a
> + * busy buffer. To avoid wasting CPU cycles scanning the buffer list in some
> + * cases, don't pass JBD2_SHRINK_BUSY_SKIP 'type' for this function.
>   *
>   * Called with j_list_lock held.
>   */
>  void __jbd2_journal_clean_checkpoint_list(journal_t *journal,
> -					  enum shrink_type type)
> +					  enum jbd2_shrink_type type)
>  {
>  	transaction_t *transaction, *last_transaction, *next_transaction;
>  	bool released;
>  
> -	WARN_ON_ONCE(type == SHRINK_BUSY_SKIP);
> +	WARN_ON_ONCE(type == JBD2_SHRINK_BUSY_SKIP);
>  
>  	transaction = journal->j_checkpoint_transactions;
>  	if (!transaction)
> @@ -529,7 +529,7 @@ void jbd2_journal_destroy_checkpoint(journal_t *journal)
>  			spin_unlock(&journal->j_list_lock);
>  			break;
>  		}
> -		__jbd2_journal_clean_checkpoint_list(journal, SHRINK_DESTROY);
> +		__jbd2_journal_clean_checkpoint_list(journal, JBD2_SHRINK_DESTROY);
>  		spin_unlock(&journal->j_list_lock);
>  		cond_resched();
>  	}
> diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
> index 78ebd04ac97d..65c857ab49ec 100644
> --- a/fs/jbd2/commit.c
> +++ b/fs/jbd2/commit.c
> @@ -501,7 +501,7 @@ void jbd2_journal_commit_transaction(journal_t *journal)
>  	 * frees some memory
>  	 */
>  	spin_lock(&journal->j_list_lock);
> -	__jbd2_journal_clean_checkpoint_list(journal, SHRINK_BUSY_STOP);
> +	__jbd2_journal_clean_checkpoint_list(journal, JBD2_SHRINK_BUSY_STOP);
>  	spin_unlock(&journal->j_list_lock);
>  
>  	jbd2_debug(3, "JBD2: commit phase 1\n");
> diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
> index 58a961999d70..7479f64c0939 100644
> --- a/include/linux/jbd2.h
> +++ b/include/linux/jbd2.h
> @@ -1434,9 +1434,9 @@ void jbd2_update_log_tail(journal_t *journal, tid_t tid, unsigned long block);
>  extern void jbd2_journal_commit_transaction(journal_t *);
>  
>  /* Checkpoint list management */
> -enum shrink_type {SHRINK_DESTROY, SHRINK_BUSY_STOP, SHRINK_BUSY_SKIP};
> +enum jbd2_shrink_type {JBD2_SHRINK_DESTROY, JBD2_SHRINK_BUSY_STOP, JBD2_SHRINK_BUSY_SKIP};
>  
> -void __jbd2_journal_clean_checkpoint_list(journal_t *journal, enum shrink_type type);
> +void __jbd2_journal_clean_checkpoint_list(journal_t *journal, enum jbd2_shrink_type type);
>  unsigned long jbd2_journal_shrink_checkpoint_list(journal_t *journal, unsigned long *nr_to_scan);
>  int __jbd2_journal_remove_checkpoint(struct journal_head *);
>  int jbd2_journal_try_remove_checkpoint(struct journal_head *jh);
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

