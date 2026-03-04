Return-Path: <linux-ext4+bounces-14623-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aEXXJSFFqGlOrwAAu9opvQ
	(envelope-from <linux-ext4+bounces-14623-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Wed, 04 Mar 2026 15:43:45 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 16CB9201D20
	for <lists+linux-ext4@lfdr.de>; Wed, 04 Mar 2026 15:43:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1A49D339DFCC
	for <lists+linux-ext4@lfdr.de>; Wed,  4 Mar 2026 14:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8FB43B583C;
	Wed,  4 Mar 2026 14:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mNvvTheM"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2423339EF10
	for <linux-ext4@vger.kernel.org>; Wed,  4 Mar 2026 14:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772633667; cv=none; b=Q/MxRZyyp00X1Q6hc2x6ncrxboRtFB31kjNv3EbFYyVsoXLHjFWaH8oia3a3NSPNOEFx5HHlH+wCQHxpYzmUPRgjVuqJu4aCd/L16SuS6TBKT27NZQPqDE4zaqCV4Y9HEQ7vOoD5+nO/Ua/u6lUwXOnW1edhpn8163hMA3F3hI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772633667; c=relaxed/simple;
	bh=6JiuLVebgivZ2vsTx2x+1Al0eHJq4S/vov04c4v7sU8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cTrn7f2/PuHXgcnbQl2i/FEIUFvSbSzCpuszqc7Q0M5Oa8E7okayyc9XyvKerqQE5Dm/vXmH1K0mjbFaROIHQQXybaWOAGOrYWHVqOFcUwGWHnNKStUtjqRhABNRttwAOcJDjsDQC5HzDIgmP5GHFdtZW1Wdxgf+WU8ZNF+JNTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mNvvTheM; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2ae3a2f6007so30435215ad.2
        for <linux-ext4@vger.kernel.org>; Wed, 04 Mar 2026 06:14:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772633665; x=1773238465; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=frFJX7ipsdW7Yy9fLiDDAPIBKA5hp2FTUjMAFcwH28s=;
        b=mNvvTheMhdAt+A9VVOzAgILNm7UObDe7NvJqZ9gqUjZWr+neZWyG0jziFf7JDXbXEp
         UO6zibsR4DdxgqPM6v77l+sm/NM5gHMXYAcMfPPnWTYqLWZpfQAdYwCm6grfYLEkzRH/
         B8wdgyxMCehD3doRWLxi09g2km2Zz6K4+vOYEJz7RE6UqJ9xwexPd8MOAq1Ew5EP7VD3
         sYu68C7Wiahbebpptx8p/5o0quWS6zWY+qimamFE7sNxcdnjELBF2qV+3mWRsl1I0q7R
         ch+02leEayLsKrj//wql0XJFtZxdVBWtU41B4Ka9vpjAc4oC3jemQmkEO3wskx4KXGq/
         pRzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772633665; x=1773238465;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=frFJX7ipsdW7Yy9fLiDDAPIBKA5hp2FTUjMAFcwH28s=;
        b=EQh6f6RkNpcvKvTqWFrypORljDObrlOJDlqH52+Z3w5X9yR8DmO8flLY7jC9yNEPw6
         jgPM3CYR/CCTRwj2Fb80vRKV0R+RZp9waVuaFfVmFuZy1v82RwSOgk/P0mpb810XtOZC
         Bcboq8ppb4gLqZxeFtjxXBJF4zjVTGpxi6OIf8eYd4nSxqdJViSxTTDOOxlxI3QtGpax
         voXMKtcCkWMGez6Eia1ukhWbUomewny74SGbmHGF+rF7U3aL5N9GYznsiKQzx1TLqeel
         ceLu96ueCTHO6xqsTK5oPbA36D+4KFLom5J835Juc8VEows9Pbw9iGadvNP562oQBU0q
         SeXQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3bp13igPbd9x4JrIM8+x0Ni7h2b3Vy4VE2yCY3R2LuG2ogor6VQR2DIl3NdUQte/hrIvC0n7rrEh9@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/Y1C3dIjuTVTKgUl5HOT8tab+EGGbl6oy70n4F6vHulyU/LP3
	O6lbWC9IEsf+1XAlOERGyzM0H8qf3wwxRFQgA6wcqnwINyJWUBti00deqzSUeH+FiBA=
X-Gm-Gg: ATEYQzyYKyqXkVuiBMR64FFlgYKX6s4chR/Cr1CAnqIt0ltrfwuXazThzUC05t3oIQv
	+Pe0Ooxm8SDKhni+M/XT+4nQywXREh7UTpPteJ2yJPzwTnwuIxo4OjHLXSUT/HKIEJHaDqDQSCb
	flHB4eL8Ei68xMgShlx7ZfEcIaBHF5fSYBn+uKZyLL6I7Ya7/kjhkKk0TxkKuVMe8ILjyiTeySb
	WTGlvMnyo4s5Kcz2wDUotum4tvXvW5mHt75B17yKQDR7Z+tVkOaM2OkOTn0Cx5wKpgtNpJyf2Sd
	vG0UrBtqxIAItjHLr+VKXHoy+MQoPYMxa4Jkoj1EiLekFuvFEGfp1meC5hDFBExKG4vmbPBzT/0
	OZiAYM7LTgNqIw8islzj7IWgKbM0f76jbKoW0UpJ3a3w4shxGPiQM/UGb5WOW+G47e2PywwgQ/K
	Eqm8uUg5v4I8w7AP82ThEepQGS+wgSgAcsl1sBvNsWc/92pRIQZAzg/R54TlAkLGN1dszD3/9bW
	5lDsfFWltqW
X-Received: by 2002:a17:903:b0d:b0:2ae:4c76:14ea with SMTP id d9443c01a7336-2ae6abbb840mr19367495ad.57.1772633665404;
        Wed, 04 Mar 2026 06:14:25 -0800 (PST)
Received: from ?IPV6:240e:390:a83:9701:448a:9bfc:ef26:c872? ([240e:390:a83:9701:448a:9bfc:ef26:c872])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae4e571b90sm93703415ad.62.2026.03.04.06.14.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Mar 2026 06:14:25 -0800 (PST)
Message-ID: <105e3b54-94ad-4ae8-aa7c-2cd5f67506ba@gmail.com>
Date: Wed, 4 Mar 2026 22:14:16 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] jbd2: gracefully abort on transaction state
 corruptions
To: Milos Nikic <nikic.milos@gmail.com>, jack@suse.cz
Cc: tytso@mit.edu, linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260303180157.53061-1-nikic.milos@gmail.com>
 <20260303180157.53061-3-nikic.milos@gmail.com>
Content-Language: en-US
From: Zhang Yi <yizhang089@gmail.com>
In-Reply-To: <20260303180157.53061-3-nikic.milos@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 16CB9201D20
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14623-lists,linux-ext4=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,suse.cz];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yizhang089@gmail.com,linux-ext4@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.993];
	TAGGED_RCPT(0.00)[linux-ext4];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,huawei.com:email]
X-Rspamd-Action: no action

On 3/4/2026 2:01 AM, Milos Nikic wrote:
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

Thank you for the improvement, this looks good to me.

Reviewed-by: Zhang Yi <yi.zhang@huawei.com>

> ---
>   fs/jbd2/transaction.c | 112 ++++++++++++++++++++++++++++++++----------
>   1 file changed, 86 insertions(+), 26 deletions(-)
> 
> diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
> index 04d17a5f2a82..bae6c99d635c 100644
> --- a/fs/jbd2/transaction.c
> +++ b/fs/jbd2/transaction.c
> @@ -474,7 +474,8 @@ handle_t *jbd2__journal_start(journal_t *journal, int nblocks, int rsv_blocks,
>   		return ERR_PTR(-EROFS);
>   
>   	if (handle) {
> -		J_ASSERT(handle->h_transaction->t_journal == journal);
> +		if (WARN_ON_ONCE(handle->h_transaction->t_journal != journal))
> +			return ERR_PTR(-EINVAL);
>   		handle->h_ref++;
>   		return handle;
>   	}
> @@ -1036,7 +1037,13 @@ do_get_write_access(handle_t *handle, struct journal_head *jh,
>   	 */
>   	if (!jh->b_transaction) {
>   		JBUFFER_TRACE(jh, "no transaction");
> -		J_ASSERT_JH(jh, !jh->b_next_transaction);
> +		if (WARN_ON_ONCE(jh->b_next_transaction)) {
> +			spin_unlock(&jh->b_state_lock);
> +			unlock_buffer(bh);
> +			error = -EINVAL;
> +			jbd2_journal_abort(journal, error);
> +			goto out;
> +		}
>   		JBUFFER_TRACE(jh, "file as BJ_Reserved");
>   		/*
>   		 * Make sure all stores to jh (b_modified, b_frozen_data) are
> @@ -1069,13 +1076,27 @@ do_get_write_access(handle_t *handle, struct journal_head *jh,
>   	 */
>   	if (jh->b_frozen_data) {
>   		JBUFFER_TRACE(jh, "has frozen data");
> -		J_ASSERT_JH(jh, jh->b_next_transaction == NULL);
> +		if (WARN_ON_ONCE(jh->b_next_transaction)) {
> +			spin_unlock(&jh->b_state_lock);
> +			error = -EINVAL;
> +			jbd2_journal_abort(journal, error);
> +			goto out;
> +		}
>   		goto attach_next;
>   	}
>   
>   	JBUFFER_TRACE(jh, "owned by older transaction");
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
>   	/*
>   	 * There is one case we have to be very careful about.  If the
> @@ -1496,7 +1517,7 @@ void jbd2_buffer_abort_trigger(struct journal_head *jh,
>   int jbd2_journal_dirty_metadata(handle_t *handle, struct buffer_head *bh)
>   {
>   	transaction_t *transaction = handle->h_transaction;
> -	journal_t *journal;
> +	journal_t *journal = transaction->t_journal;
>   	struct journal_head *jh;
>   	int ret = 0;
>   
> @@ -1520,8 +1541,14 @@ int jbd2_journal_dirty_metadata(handle_t *handle, struct buffer_head *bh)
>   	if (data_race(jh->b_transaction != transaction &&
>   	    jh->b_next_transaction != transaction)) {
>   		spin_lock(&jh->b_state_lock);
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
>   		spin_unlock(&jh->b_state_lock);
>   	}
>   	if (data_race(jh->b_modified == 1)) {
> @@ -1531,13 +1558,15 @@ int jbd2_journal_dirty_metadata(handle_t *handle, struct buffer_head *bh)
>   			spin_lock(&jh->b_state_lock);
>   			if (jh->b_transaction == transaction &&
>   			    jh->b_jlist != BJ_Metadata)
> -				pr_err("JBD2: assertion failure: h_type=%u "
> -				       "h_line_no=%u block_no=%llu jlist=%u\n",
> +				pr_err("JBD2: assertion failure: h_type=%u h_line_no=%u block_no=%llu jlist=%u\n",
>   				       handle->h_type, handle->h_line_no,
>   				       (unsigned long long) bh->b_blocknr,
>   				       jh->b_jlist);
> -			J_ASSERT_JH(jh, jh->b_transaction != transaction ||
> -					jh->b_jlist == BJ_Metadata);
> +			if (WARN_ON_ONCE(jh->b_transaction == transaction &&
> +					 jh->b_jlist != BJ_Metadata)) {
> +				ret = -EINVAL;
> +				goto out_unlock_bh;
> +			}
>   			spin_unlock(&jh->b_state_lock);
>   		}
>   		goto out;
> @@ -1557,8 +1586,6 @@ int jbd2_journal_dirty_metadata(handle_t *handle, struct buffer_head *bh)
>   		goto out_unlock_bh;
>   	}
>   
> -	journal = transaction->t_journal;
> -
>   	if (jh->b_modified == 0) {
>   		/*
>   		 * This buffer's got modified and becoming part
> @@ -1636,7 +1663,10 @@ int jbd2_journal_dirty_metadata(handle_t *handle, struct buffer_head *bh)
>   	}
>   
>   	/* That test should have eliminated the following case: */
> -	J_ASSERT_JH(jh, jh->b_frozen_data == NULL);
> +	if (WARN_ON_ONCE(jh->b_frozen_data)) {
> +		ret = -EINVAL;
> +		goto out_unlock_bh;
> +	}
>   
>   	JBUFFER_TRACE(jh, "file as BJ_Metadata");
>   	spin_lock(&journal->j_list_lock);
> @@ -1675,6 +1705,7 @@ int jbd2_journal_forget(handle_t *handle, struct buffer_head *bh)
>   	int err = 0;
>   	int was_modified = 0;
>   	int wait_for_writeback = 0;
> +	int abort_journal = 0;
>   
>   	if (is_handle_aborted(handle))
>   		return -EROFS;
> @@ -1708,7 +1739,11 @@ int jbd2_journal_forget(handle_t *handle, struct buffer_head *bh)
>   	jh->b_modified = 0;
>   
>   	if (jh->b_transaction == transaction) {
> -		J_ASSERT_JH(jh, !jh->b_frozen_data);
> +		if (WARN_ON_ONCE(jh->b_frozen_data)) {
> +			err = -EINVAL;
> +			abort_journal = 1;
> +			goto drop;
> +		}
>   
>   		/* If we are forgetting a buffer which is already part
>   		 * of this transaction, then we can just drop it from
> @@ -1747,8 +1782,11 @@ int jbd2_journal_forget(handle_t *handle, struct buffer_head *bh)
>   		}
>   		spin_unlock(&journal->j_list_lock);
>   	} else if (jh->b_transaction) {
> -		J_ASSERT_JH(jh, (jh->b_transaction ==
> -				 journal->j_committing_transaction));
> +		if (WARN_ON_ONCE(jh->b_transaction != journal->j_committing_transaction)) {
> +			err = -EINVAL;
> +			abort_journal = 1;
> +			goto drop;
> +		}
>   		/* However, if the buffer is still owned by a prior
>   		 * (committing) transaction, we can't drop it yet... */
>   		JBUFFER_TRACE(jh, "belongs to older transaction");
> @@ -1766,7 +1804,11 @@ int jbd2_journal_forget(handle_t *handle, struct buffer_head *bh)
>   			jh->b_next_transaction = transaction;
>   			spin_unlock(&journal->j_list_lock);
>   		} else {
> -			J_ASSERT(jh->b_next_transaction == transaction);
> +			if (WARN_ON_ONCE(jh->b_next_transaction != transaction)) {
> +				err = -EINVAL;
> +				abort_journal = 1;
> +				goto drop;
> +			}
>   
>   			/*
>   			 * only drop a reference if this transaction modified
> @@ -1812,6 +1854,8 @@ int jbd2_journal_forget(handle_t *handle, struct buffer_head *bh)
>   drop:
>   	__brelse(bh);
>   	spin_unlock(&jh->b_state_lock);
> +	if (abort_journal)
> +		jbd2_journal_abort(journal, err);
>   	if (wait_for_writeback)
>   		wait_on_buffer(bh);
>   	jbd2_journal_put_journal_head(jh);
> @@ -2136,7 +2180,8 @@ bool jbd2_journal_try_to_free_buffers(journal_t *journal, struct folio *folio)
>   	struct buffer_head *bh;
>   	bool ret = false;
>   
> -	J_ASSERT(folio_test_locked(folio));
> +	if (WARN_ON_ONCE(!folio_test_locked(folio)))
> +		return false;
>   
>   	head = folio_buffers(folio);
>   	bh = head;
> @@ -2651,6 +2696,8 @@ static int jbd2_journal_file_inode(handle_t *handle, struct jbd2_inode *jinode,
>   {
>   	transaction_t *transaction = handle->h_transaction;
>   	journal_t *journal;
> +	int err = 0;
> +	int abort_transaction = 0;
>   
>   	if (is_handle_aborted(handle))
>   		return -EROFS;
> @@ -2685,20 +2732,33 @@ static int jbd2_journal_file_inode(handle_t *handle, struct jbd2_inode *jinode,
>   	/* On some different transaction's list - should be
>   	 * the committing one */
>   	if (jinode->i_transaction) {
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
>   		jinode->i_next_transaction = transaction;
>   		goto done;
>   	}
>   	/* Not on any transaction list... */
> -	J_ASSERT(!jinode->i_next_transaction);
> +	if (WARN_ON_ONCE(jinode->i_next_transaction)) {
> +		err = -EINVAL;
> +		abort_transaction = 1;
> +		goto done;
> +	}
>   	jinode->i_transaction = transaction;
>   	list_add(&jinode->i_list, &transaction->t_inode_list);
>   done:
>   	spin_unlock(&journal->j_list_lock);
> -
> -	return 0;
> +	if (abort_transaction)
> +		jbd2_journal_abort(journal, err);
> +	return err;
>   }
>   
>   int jbd2_journal_inode_ranged_write(handle_t *handle,


