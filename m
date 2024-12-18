Return-Path: <linux-ext4+bounces-5743-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE8359F64F9
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Dec 2024 12:36:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 805BC188D927
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Dec 2024 11:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 168D419F49F;
	Wed, 18 Dec 2024 11:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="uDP+IY6R";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="YXtcQH4S";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="uDP+IY6R";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="YXtcQH4S"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808F319CC2E;
	Wed, 18 Dec 2024 11:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734521754; cv=none; b=S75ovvTBKNjq39xkpSRAXmoOVi0mpJs2YNXqv+f9Rw7HqdhkDD+syv9Iti9r3eZMP8+WDXBnEsRALI6AhjcT57vbcGe3G36g/2ehDWIQkPURQhSqdaJwLDSajhLSLB0Ys/T7eVP4tfs89INDuld+0akqrD/tkGzlM0nLABU9Oys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734521754; c=relaxed/simple;
	bh=Pdl9auTdzXmvf3ZaHV/2+DsmbCbQUth1SXoNEFcKOAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jFCMq0qvrvuXRgxrz5KdvASddSM9B/ioeKUgrwvYq5JrlzaaJrQDIxoJcAssnXd2sjCbRXZA9SXm6WfQnfQkPHUqbKGurF0nBrxvCgfslAAgEW2A/Q/ydEev4CBq5L0s9gQOqIvr/81eIa2b2i1Hnd4teK/+TyXDNzVmVeXBj+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=uDP+IY6R; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=YXtcQH4S; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=uDP+IY6R; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=YXtcQH4S; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 82B0521102;
	Wed, 18 Dec 2024 11:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1734521750; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=94eKmATP+oW7iIgsmvhS3q9J4yHRaTZvEkXomtUjHz0=;
	b=uDP+IY6RytFcuErjNqhsz3kQWRBAFhN92LNwFT+zOzMgNAhUMekHkN19xYGlkgBP1IYBbS
	ZHNRxKBglGLeVjiosr+B58vKeFyJhgZAYhpssUNrnrUQjHgb8QMnEjYLkC1C58Qv5pQ58i
	C+H/TjwizyqgigCA7MfgFlROs5QJG18=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1734521750;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=94eKmATP+oW7iIgsmvhS3q9J4yHRaTZvEkXomtUjHz0=;
	b=YXtcQH4ScYAZv8hp9N0sLM4T371X0iIDPu1DUQTzqw9djq5RzF7Bd5lI+smNqgoUFNNvmu
	D+ciJ161CBVeUUAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1734521750; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=94eKmATP+oW7iIgsmvhS3q9J4yHRaTZvEkXomtUjHz0=;
	b=uDP+IY6RytFcuErjNqhsz3kQWRBAFhN92LNwFT+zOzMgNAhUMekHkN19xYGlkgBP1IYBbS
	ZHNRxKBglGLeVjiosr+B58vKeFyJhgZAYhpssUNrnrUQjHgb8QMnEjYLkC1C58Qv5pQ58i
	C+H/TjwizyqgigCA7MfgFlROs5QJG18=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1734521750;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=94eKmATP+oW7iIgsmvhS3q9J4yHRaTZvEkXomtUjHz0=;
	b=YXtcQH4ScYAZv8hp9N0sLM4T371X0iIDPu1DUQTzqw9djq5RzF7Bd5lI+smNqgoUFNNvmu
	D+ciJ161CBVeUUAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7463B132EA;
	Wed, 18 Dec 2024 11:35:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zCFlHJazYmd3bgAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 18 Dec 2024 11:35:50 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 1F6C9A0935; Wed, 18 Dec 2024 12:35:50 +0100 (CET)
Date: Wed, 18 Dec 2024 12:35:50 +0100
From: Jan Kara <jack@suse.cz>
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.com,
	dennis.lamerice@gmail.com, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 1/3] ext4: remove unused ext4 journal callback
Message-ID: <20241218113550.bmvit2exnzvetv6f@quack3>
References: <20241217120356.1399443-1-shikemeng@huaweicloud.com>
 <20241217120356.1399443-2-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241217120356.1399443-2-shikemeng@huaweicloud.com>
X-Spam-Score: -2.30
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[mit.edu,dilger.ca,suse.com,gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Tue 17-12-24 20:03:54, Kemeng Shi wrote:
> Remove unused ext4 journal callback.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/ext4_jbd2.h | 84 ---------------------------------------------
>  fs/ext4/super.c     | 14 --------
>  2 files changed, 98 deletions(-)
> 
> diff --git a/fs/ext4/ext4_jbd2.h b/fs/ext4/ext4_jbd2.h
> index 0c77697d5e90..3f2596c9e5f2 100644
> --- a/fs/ext4/ext4_jbd2.h
> +++ b/fs/ext4/ext4_jbd2.h
> @@ -122,90 +122,6 @@
>  #define EXT4_HT_EXT_CONVERT     11
>  #define EXT4_HT_MAX             12
>  
> -/**
> - *   struct ext4_journal_cb_entry - Base structure for callback information.
> - *
> - *   This struct is a 'seed' structure for a using with your own callback
> - *   structs. If you are using callbacks you must allocate one of these
> - *   or another struct of your own definition which has this struct
> - *   as it's first element and pass it to ext4_journal_callback_add().
> - */
> -struct ext4_journal_cb_entry {
> -	/* list information for other callbacks attached to the same handle */
> -	struct list_head jce_list;
> -
> -	/*  Function to call with this callback structure */
> -	void (*jce_func)(struct super_block *sb,
> -			 struct ext4_journal_cb_entry *jce, int error);
> -
> -	/* user data goes here */
> -};
> -
> -/**
> - * ext4_journal_callback_add: add a function to call after transaction commit
> - * @handle: active journal transaction handle to register callback on
> - * @func: callback function to call after the transaction has committed:
> - *        @sb: superblock of current filesystem for transaction
> - *        @jce: returned journal callback data
> - *        @rc: journal state at commit (0 = transaction committed properly)
> - * @jce: journal callback data (internal and function private data struct)
> - *
> - * The registered function will be called in the context of the journal thread
> - * after the transaction for which the handle was created has completed.
> - *
> - * No locks are held when the callback function is called, so it is safe to
> - * call blocking functions from within the callback, but the callback should
> - * not block or run for too long, or the filesystem will be blocked waiting for
> - * the next transaction to commit. No journaling functions can be used, or
> - * there is a risk of deadlock.
> - *
> - * There is no guaranteed calling order of multiple registered callbacks on
> - * the same transaction.
> - */
> -static inline void _ext4_journal_callback_add(handle_t *handle,
> -			struct ext4_journal_cb_entry *jce)
> -{
> -	/* Add the jce to transaction's private list */
> -	list_add_tail(&jce->jce_list, &handle->h_transaction->t_private_list);
> -}
> -
> -static inline void ext4_journal_callback_add(handle_t *handle,
> -			void (*func)(struct super_block *sb,
> -				     struct ext4_journal_cb_entry *jce,
> -				     int rc),
> -			struct ext4_journal_cb_entry *jce)
> -{
> -	struct ext4_sb_info *sbi =
> -			EXT4_SB(handle->h_transaction->t_journal->j_private);
> -
> -	/* Add the jce to transaction's private list */
> -	jce->jce_func = func;
> -	spin_lock(&sbi->s_md_lock);
> -	_ext4_journal_callback_add(handle, jce);
> -	spin_unlock(&sbi->s_md_lock);
> -}
> -
> -
> -/**
> - * ext4_journal_callback_del: delete a registered callback
> - * @handle: active journal transaction handle on which callback was registered
> - * @jce: registered journal callback entry to unregister
> - * Return true if object was successfully removed
> - */
> -static inline bool ext4_journal_callback_try_del(handle_t *handle,
> -					     struct ext4_journal_cb_entry *jce)
> -{
> -	bool deleted;
> -	struct ext4_sb_info *sbi =
> -			EXT4_SB(handle->h_transaction->t_journal->j_private);
> -
> -	spin_lock(&sbi->s_md_lock);
> -	deleted = !list_empty(&jce->jce_list);
> -	list_del_init(&jce->jce_list);
> -	spin_unlock(&sbi->s_md_lock);
> -	return deleted;
> -}
> -
>  int
>  ext4_mark_iloc_dirty(handle_t *handle,
>  		     struct inode *inode,
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index a09f4621b10d..8dfda41dabaa 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -502,25 +502,11 @@ static void ext4_maybe_update_superblock(struct super_block *sb)
>  static void ext4_journal_commit_callback(journal_t *journal, transaction_t *txn)
>  {
>  	struct super_block		*sb = journal->j_private;
> -	struct ext4_sb_info		*sbi = EXT4_SB(sb);
> -	int				error = is_journal_aborted(journal);
> -	struct ext4_journal_cb_entry	*jce;
>  
>  	BUG_ON(txn->t_state == T_FINISHED);
>  
>  	ext4_process_freed_data(sb, txn->t_tid);
>  	ext4_maybe_update_superblock(sb);
> -
> -	spin_lock(&sbi->s_md_lock);
> -	while (!list_empty(&txn->t_private_list)) {
> -		jce = list_entry(txn->t_private_list.next,
> -				 struct ext4_journal_cb_entry, jce_list);
> -		list_del_init(&jce->jce_list);
> -		spin_unlock(&sbi->s_md_lock);
> -		jce->jce_func(sb, jce, error);
> -		spin_lock(&sbi->s_md_lock);
> -	}
> -	spin_unlock(&sbi->s_md_lock);
>  }
>  
>  /*
> -- 
> 2.30.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

