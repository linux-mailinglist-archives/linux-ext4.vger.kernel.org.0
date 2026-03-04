Return-Path: <linux-ext4+bounces-14604-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wPEuEEsTqGnUngAAu9opvQ
	(envelope-from <linux-ext4+bounces-14604-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Wed, 04 Mar 2026 12:11:07 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D9C5C1FEBCA
	for <lists+linux-ext4@lfdr.de>; Wed, 04 Mar 2026 12:11:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 493683052DBE
	for <lists+linux-ext4@lfdr.de>; Wed,  4 Mar 2026 11:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 085F23AE18E;
	Wed,  4 Mar 2026 11:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="o2IVpG/p";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="JTZKP1rH";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="o2IVpG/p";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="JTZKP1rH"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3312239D6FB
	for <linux-ext4@vger.kernel.org>; Wed,  4 Mar 2026 11:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772622631; cv=none; b=LVc8Sbie2Ks+tgwcLclKt3EWEOGu897jjivaFhpM+fYC4pnOnMD8DKHsQBBmLEXGemIpCvfOAy0lje4N0VLhPGzi1JiWjvMQKKuugDB2G6bPlsc8BWy0I8qL8rxmpsr0OlZKoPvdSg/ZKSYrctXVEFjwa7lVbXum5cGTYsZ69HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772622631; c=relaxed/simple;
	bh=/rKUYfMvQCWohtQr2F5A6NnEYzwygkSZDzJ+Qbv4bVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RvpL4taiS7Z5gd+BfbXwiq00LnE5HpyLzrNV7Up/vgllxdgXJOuU99ZeDC6WS8ZpG3MarZDxPhYXMg96lb7r5TWzrw3WPH6Gw18942ulfFwa8PHiM0aLsF2vysIwigo+G6BmBLVn/Ar2CEi+y7y+leLSSa2267XG7oXatG/Yc34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=o2IVpG/p; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=JTZKP1rH; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=o2IVpG/p; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=JTZKP1rH; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8F1223E83E;
	Wed,  4 Mar 2026 11:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772622627; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0Fm+rH3e+9iXRtdO3YNCNHvJ4KCjtp2A/ysLyR0P9hE=;
	b=o2IVpG/pz1KNwj8qE0bJvHH4YuZqc7j5yBvqnDNboT4iDNIAllOgl1TqMVz2T0153mYpeT
	2Q5o1D6VONlthySGr6Ojwsu3KByX6bd0cLgUa9lFXJyY7QXickx3jepbBIB6PXrKrU098j
	ydat4cjcpJjVRRzpujtXNr5cpSJ7lAU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772622627;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0Fm+rH3e+9iXRtdO3YNCNHvJ4KCjtp2A/ysLyR0P9hE=;
	b=JTZKP1rHhePpsQw8NW+hB+csz2B9uhKZaeEGKJpgJDe5m+vCc3Wy9aY9c2s9xkNREdflTR
	550VzZbszcxC1NCA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="o2IVpG/p";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=JTZKP1rH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772622627; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0Fm+rH3e+9iXRtdO3YNCNHvJ4KCjtp2A/ysLyR0P9hE=;
	b=o2IVpG/pz1KNwj8qE0bJvHH4YuZqc7j5yBvqnDNboT4iDNIAllOgl1TqMVz2T0153mYpeT
	2Q5o1D6VONlthySGr6Ojwsu3KByX6bd0cLgUa9lFXJyY7QXickx3jepbBIB6PXrKrU098j
	ydat4cjcpJjVRRzpujtXNr5cpSJ7lAU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772622627;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0Fm+rH3e+9iXRtdO3YNCNHvJ4KCjtp2A/ysLyR0P9hE=;
	b=JTZKP1rHhePpsQw8NW+hB+csz2B9uhKZaeEGKJpgJDe5m+vCc3Wy9aY9c2s9xkNREdflTR
	550VzZbszcxC1NCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 822603EA69;
	Wed,  4 Mar 2026 11:10:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bKq8HyMTqGkuOQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 04 Mar 2026 11:10:27 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 42210A0A1B; Wed,  4 Mar 2026 12:10:27 +0100 (CET)
Date: Wed, 4 Mar 2026 12:10:27 +0100
From: Jan Kara <jack@suse.cz>
To: Milos Nikic <nikic.milos@gmail.com>
Cc: jack@suse.cz, tytso@mit.edu, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] jbd2: gracefully abort on transaction state
 corruptions
Message-ID: <7b6gqfzey7yukcxb5mst5nmb6kvlp7r2ocriro4pjejf2bao74@3dvxtephric6>
References: <20260303180157.53061-1-nikic.milos@gmail.com>
 <20260303180157.53061-3-nikic.milos@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260303180157.53061-3-nikic.milos@gmail.com>
X-Spam-Flag: NO
X-Spam-Score: -2.51
X-Spam-Level: 
X-Rspamd-Queue-Id: D9C5C1FEBCA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-14604-lists,linux-ext4=lfdr.de];
	TO_DN_SOME(0.00)[];
	DMARC_NA(0.00)[suse.cz];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,suse.com:email];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-ext4@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	NEURAL_HAM(-0.00)[-0.994];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-ext4];
	RCPT_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On Tue 03-03-26 10:01:57, Milos Nikic wrote:
> Auditing the jbd2 codebase reveals several legacy J_ASSERT calls
> that enforce internal state machine invariants (e.g., verifying
> jh->b_transaction or jh->b_next_transaction pointers).
> 
> When these invariants are broken, the journal is in a corrupted
> state. However, triggering a fatal panic brings down the entire
> system for a localized filesystem error.
> 
> This patch targets a specific class of these asserts: those
> residing inside functions that natively return integer error codes,
> booleans, or error pointers. It replaces the hard J_ASSERTs with
> WARN_ON_ONCE to capture the offending stack trace, safely drops
> any held locks, gracefully aborts the journal, and returns -EINVAL.
> 
> This prevents a catastrophic kernel panic while ensuring the
> corrupted journal state is safely contained and upstream callers
> (like ext4 or ocfs2) can gracefully handle the aborted handle.
> 
> Functions modified in fs/jbd2/transaction.c:
> - jbd2__journal_start()
> - do_get_write_access()
> - jbd2_journal_dirty_metadata()
> - jbd2_journal_forget()
> - jbd2_journal_try_to_free_buffers()
> - jbd2_journal_file_inode()
> 
> Signed-off-by: Milos Nikic <nikic.milos@gmail.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/jbd2/transaction.c | 112 ++++++++++++++++++++++++++++++++----------
>  1 file changed, 86 insertions(+), 26 deletions(-)
> 
> diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
> index 04d17a5f2a82..bae6c99d635c 100644
> --- a/fs/jbd2/transaction.c
> +++ b/fs/jbd2/transaction.c
> @@ -474,7 +474,8 @@ handle_t *jbd2__journal_start(journal_t *journal, int nblocks, int rsv_blocks,
>  		return ERR_PTR(-EROFS);
>  
>  	if (handle) {
> -		J_ASSERT(handle->h_transaction->t_journal == journal);
> +		if (WARN_ON_ONCE(handle->h_transaction->t_journal != journal))
> +			return ERR_PTR(-EINVAL);
>  		handle->h_ref++;
>  		return handle;
>  	}
> @@ -1036,7 +1037,13 @@ do_get_write_access(handle_t *handle, struct journal_head *jh,
>  	 */
>  	if (!jh->b_transaction) {
>  		JBUFFER_TRACE(jh, "no transaction");
> -		J_ASSERT_JH(jh, !jh->b_next_transaction);
> +		if (WARN_ON_ONCE(jh->b_next_transaction)) {
> +			spin_unlock(&jh->b_state_lock);
> +			unlock_buffer(bh);
> +			error = -EINVAL;
> +			jbd2_journal_abort(journal, error);
> +			goto out;
> +		}
>  		JBUFFER_TRACE(jh, "file as BJ_Reserved");
>  		/*
>  		 * Make sure all stores to jh (b_modified, b_frozen_data) are
> @@ -1069,13 +1076,27 @@ do_get_write_access(handle_t *handle, struct journal_head *jh,
>  	 */
>  	if (jh->b_frozen_data) {
>  		JBUFFER_TRACE(jh, "has frozen data");
> -		J_ASSERT_JH(jh, jh->b_next_transaction == NULL);
> +		if (WARN_ON_ONCE(jh->b_next_transaction)) {
> +			spin_unlock(&jh->b_state_lock);
> +			error = -EINVAL;
> +			jbd2_journal_abort(journal, error);
> +			goto out;
> +		}
>  		goto attach_next;
>  	}
>  
>  	JBUFFER_TRACE(jh, "owned by older transaction");
> -	J_ASSERT_JH(jh, jh->b_next_transaction == NULL);
> -	J_ASSERT_JH(jh, jh->b_transaction == journal->j_committing_transaction);
> +	if (WARN_ON_ONCE(jh->b_next_transaction ||
> +			 jh->b_transaction !=
> +			 journal->j_committing_transaction)) {
> +		pr_err("JBD2: %s: assertion failure: b_next_transaction=%p b_transaction=%p j_committing_transaction=%p\n",
> +		       journal->j_devname, jh->b_next_transaction,
> +		       jh->b_transaction, journal->j_committing_transaction);
> +		spin_unlock(&jh->b_state_lock);
> +		error = -EINVAL;
> +		jbd2_journal_abort(journal, error);
> +		goto out;
> +	}
>  
>  	/*
>  	 * There is one case we have to be very careful about.  If the
> @@ -1496,7 +1517,7 @@ void jbd2_buffer_abort_trigger(struct journal_head *jh,
>  int jbd2_journal_dirty_metadata(handle_t *handle, struct buffer_head *bh)
>  {
>  	transaction_t *transaction = handle->h_transaction;
> -	journal_t *journal;
> +	journal_t *journal = transaction->t_journal;
>  	struct journal_head *jh;
>  	int ret = 0;
>  
> @@ -1520,8 +1541,14 @@ int jbd2_journal_dirty_metadata(handle_t *handle, struct buffer_head *bh)
>  	if (data_race(jh->b_transaction != transaction &&
>  	    jh->b_next_transaction != transaction)) {
>  		spin_lock(&jh->b_state_lock);
> -		J_ASSERT_JH(jh, jh->b_transaction == transaction ||
> -				jh->b_next_transaction == transaction);
> +		if (WARN_ON_ONCE(jh->b_transaction != transaction &&
> +				 jh->b_next_transaction != transaction)) {
> +			pr_err("JBD2: %s: assertion failure: b_transaction=%p transaction=%p b_next_transaction=%p\n",
> +			       journal->j_devname, jh->b_transaction,
> +			       transaction, jh->b_next_transaction);
> +			ret = -EINVAL;
> +			goto out_unlock_bh;
> +		}
>  		spin_unlock(&jh->b_state_lock);
>  	}
>  	if (data_race(jh->b_modified == 1)) {
> @@ -1531,13 +1558,15 @@ int jbd2_journal_dirty_metadata(handle_t *handle, struct buffer_head *bh)
>  			spin_lock(&jh->b_state_lock);
>  			if (jh->b_transaction == transaction &&
>  			    jh->b_jlist != BJ_Metadata)
> -				pr_err("JBD2: assertion failure: h_type=%u "
> -				       "h_line_no=%u block_no=%llu jlist=%u\n",
> +				pr_err("JBD2: assertion failure: h_type=%u h_line_no=%u block_no=%llu jlist=%u\n",
>  				       handle->h_type, handle->h_line_no,
>  				       (unsigned long long) bh->b_blocknr,
>  				       jh->b_jlist);
> -			J_ASSERT_JH(jh, jh->b_transaction != transaction ||
> -					jh->b_jlist == BJ_Metadata);
> +			if (WARN_ON_ONCE(jh->b_transaction == transaction &&
> +					 jh->b_jlist != BJ_Metadata)) {
> +				ret = -EINVAL;
> +				goto out_unlock_bh;
> +			}
>  			spin_unlock(&jh->b_state_lock);
>  		}
>  		goto out;
> @@ -1557,8 +1586,6 @@ int jbd2_journal_dirty_metadata(handle_t *handle, struct buffer_head *bh)
>  		goto out_unlock_bh;
>  	}
>  
> -	journal = transaction->t_journal;
> -
>  	if (jh->b_modified == 0) {
>  		/*
>  		 * This buffer's got modified and becoming part
> @@ -1636,7 +1663,10 @@ int jbd2_journal_dirty_metadata(handle_t *handle, struct buffer_head *bh)
>  	}
>  
>  	/* That test should have eliminated the following case: */
> -	J_ASSERT_JH(jh, jh->b_frozen_data == NULL);
> +	if (WARN_ON_ONCE(jh->b_frozen_data)) {
> +		ret = -EINVAL;
> +		goto out_unlock_bh;
> +	}
>  
>  	JBUFFER_TRACE(jh, "file as BJ_Metadata");
>  	spin_lock(&journal->j_list_lock);
> @@ -1675,6 +1705,7 @@ int jbd2_journal_forget(handle_t *handle, struct buffer_head *bh)
>  	int err = 0;
>  	int was_modified = 0;
>  	int wait_for_writeback = 0;
> +	int abort_journal = 0;
>  
>  	if (is_handle_aborted(handle))
>  		return -EROFS;
> @@ -1708,7 +1739,11 @@ int jbd2_journal_forget(handle_t *handle, struct buffer_head *bh)
>  	jh->b_modified = 0;
>  
>  	if (jh->b_transaction == transaction) {
> -		J_ASSERT_JH(jh, !jh->b_frozen_data);
> +		if (WARN_ON_ONCE(jh->b_frozen_data)) {
> +			err = -EINVAL;
> +			abort_journal = 1;
> +			goto drop;
> +		}
>  
>  		/* If we are forgetting a buffer which is already part
>  		 * of this transaction, then we can just drop it from
> @@ -1747,8 +1782,11 @@ int jbd2_journal_forget(handle_t *handle, struct buffer_head *bh)
>  		}
>  		spin_unlock(&journal->j_list_lock);
>  	} else if (jh->b_transaction) {
> -		J_ASSERT_JH(jh, (jh->b_transaction ==
> -				 journal->j_committing_transaction));
> +		if (WARN_ON_ONCE(jh->b_transaction != journal->j_committing_transaction)) {
> +			err = -EINVAL;
> +			abort_journal = 1;
> +			goto drop;
> +		}
>  		/* However, if the buffer is still owned by a prior
>  		 * (committing) transaction, we can't drop it yet... */
>  		JBUFFER_TRACE(jh, "belongs to older transaction");
> @@ -1766,7 +1804,11 @@ int jbd2_journal_forget(handle_t *handle, struct buffer_head *bh)
>  			jh->b_next_transaction = transaction;
>  			spin_unlock(&journal->j_list_lock);
>  		} else {
> -			J_ASSERT(jh->b_next_transaction == transaction);
> +			if (WARN_ON_ONCE(jh->b_next_transaction != transaction)) {
> +				err = -EINVAL;
> +				abort_journal = 1;
> +				goto drop;
> +			}
>  
>  			/*
>  			 * only drop a reference if this transaction modified
> @@ -1812,6 +1854,8 @@ int jbd2_journal_forget(handle_t *handle, struct buffer_head *bh)
>  drop:
>  	__brelse(bh);
>  	spin_unlock(&jh->b_state_lock);
> +	if (abort_journal)
> +		jbd2_journal_abort(journal, err);
>  	if (wait_for_writeback)
>  		wait_on_buffer(bh);
>  	jbd2_journal_put_journal_head(jh);
> @@ -2136,7 +2180,8 @@ bool jbd2_journal_try_to_free_buffers(journal_t *journal, struct folio *folio)
>  	struct buffer_head *bh;
>  	bool ret = false;
>  
> -	J_ASSERT(folio_test_locked(folio));
> +	if (WARN_ON_ONCE(!folio_test_locked(folio)))
> +		return false;
>  
>  	head = folio_buffers(folio);
>  	bh = head;
> @@ -2651,6 +2696,8 @@ static int jbd2_journal_file_inode(handle_t *handle, struct jbd2_inode *jinode,
>  {
>  	transaction_t *transaction = handle->h_transaction;
>  	journal_t *journal;
> +	int err = 0;
> +	int abort_transaction = 0;
>  
>  	if (is_handle_aborted(handle))
>  		return -EROFS;
> @@ -2685,20 +2732,33 @@ static int jbd2_journal_file_inode(handle_t *handle, struct jbd2_inode *jinode,
>  	/* On some different transaction's list - should be
>  	 * the committing one */
>  	if (jinode->i_transaction) {
> -		J_ASSERT(jinode->i_next_transaction == NULL);
> -		J_ASSERT(jinode->i_transaction ==
> -					journal->j_committing_transaction);
> +		if (WARN_ON_ONCE(jinode->i_next_transaction ||
> +				 jinode->i_transaction !=
> +				 journal->j_committing_transaction)) {
> +			pr_err("JBD2: %s: assertion failure: i_next_transaction=%p i_transaction=%p j_committing_transaction=%p\n",
> +			       journal->j_devname, jinode->i_next_transaction,
> +			       jinode->i_transaction,
> +			       journal->j_committing_transaction);
> +			err = -EINVAL;
> +			abort_transaction = 1;
> +			goto done;
> +		}
>  		jinode->i_next_transaction = transaction;
>  		goto done;
>  	}
>  	/* Not on any transaction list... */
> -	J_ASSERT(!jinode->i_next_transaction);
> +	if (WARN_ON_ONCE(jinode->i_next_transaction)) {
> +		err = -EINVAL;
> +		abort_transaction = 1;
> +		goto done;
> +	}
>  	jinode->i_transaction = transaction;
>  	list_add(&jinode->i_list, &transaction->t_inode_list);
>  done:
>  	spin_unlock(&journal->j_list_lock);
> -
> -	return 0;
> +	if (abort_transaction)
> +		jbd2_journal_abort(journal, err);
> +	return err;
>  }
>  
>  int jbd2_journal_inode_ranged_write(handle_t *handle,
> -- 
> 2.53.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

