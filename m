Return-Path: <linux-ext4+bounces-5744-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E13209F64FE
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Dec 2024 12:36:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C8917A287A
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Dec 2024 11:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE3819F429;
	Wed, 18 Dec 2024 11:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xvrWCrsZ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3IgzxX76";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="m/dzmD1G";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2Q3l+2I5"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A92165F16;
	Wed, 18 Dec 2024 11:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734521800; cv=none; b=UH/28RbU0sz5J+1Z1/HahFI7r06In3Zio1SHixQ43F7LFdSR5iLRyU0iYBflFr1B9QDn0rUtOr9wPatlX47S4GiI37BKtL4Bto9qxf0g/bYuFi7O2AtD3lSogohKFt6HLbqZ8ZfJLW/Il3LvzAES43yy1DAlmA8FgQ0U/k2DVj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734521800; c=relaxed/simple;
	bh=wcCx7T7OhdN38ja3l825sFTWyUPfDsljpBkp8eBad9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=arX+4gXbONoY1Y3ggnPKKo1VxU/Z0DrdKjtKzrO+WVuRpkWVhyL6l/ntD9rY7vMUv2K7AUbSU7UYq6VMSic8AyBDTxhQtJyjSbn+LN8XmWuKAaX8mqZo8nVZq6kHLpzx/krl8KPeqKSTHxHzg1pm0wHwtiNtvtVBhYb6698tCOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xvrWCrsZ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3IgzxX76; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=m/dzmD1G; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2Q3l+2I5; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 533321F444;
	Wed, 18 Dec 2024 11:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1734521796; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PjsJeeRKbZh/qNYlsgShoVkqgcnrgD6hTu+jgEgrPK0=;
	b=xvrWCrsZMnSW0KeXp3QNz7UIASmq4y1JCfWQsr2C9hgk1hZhG/IH/FUZPOW1ROYyO4do8O
	AUUzpGa8s8MlIhX0ZZVZFaeXqgOBomP3TTZmwNGeMciaZ3jXY5vWioBc5HgJlNUjrkqtb0
	VKsHQJ/NBVd2heuQoGcm6+mJhedKku0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1734521796;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PjsJeeRKbZh/qNYlsgShoVkqgcnrgD6hTu+jgEgrPK0=;
	b=3IgzxX76HL1AWAobc/CyfDQ3e3I4yaaeyCgqF5MP7sfA9gisy2MPSUJdBLvZpilwmr/zLJ
	ygUprfZsyZpgzIDg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="m/dzmD1G";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=2Q3l+2I5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1734521795; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PjsJeeRKbZh/qNYlsgShoVkqgcnrgD6hTu+jgEgrPK0=;
	b=m/dzmD1GA4bb4Blv70LDeB4JagfYU8aonlDNtTnrEEhRd78st4YwNBOxMSD7BE5Aorlfkr
	MMUswnWztifuZPrH1DNhYRZLpZ4qSJ27dVgm8cgD8JCudPpSfED/n5+IWCWLPCQtGrFpM2
	OlvTzzXmThjggAgcG4RSsw3TPRvp9sw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1734521795;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PjsJeeRKbZh/qNYlsgShoVkqgcnrgD6hTu+jgEgrPK0=;
	b=2Q3l+2I5YhwK/RDrIvw9gNDsiiUbW9thcY0ABwzMAT2VSemIg5zJKAFvj1bq3DlhBb/Ofx
	ASGvPRKt9LZV5yCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 42C45132EA;
	Wed, 18 Dec 2024 11:36:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4BJKEMOzYmegbgAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 18 Dec 2024 11:36:35 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id F374EA0935; Wed, 18 Dec 2024 12:36:34 +0100 (CET)
Date: Wed, 18 Dec 2024 12:36:34 +0100
From: Jan Kara <jack@suse.cz>
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.com,
	dennis.lamerice@gmail.com, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 2/3] jbd2: remove unused transaction->t_private_list
Message-ID: <20241218113634.7t3m6ctguwfmwrwg@quack3>
References: <20241217120356.1399443-1-shikemeng@huaweicloud.com>
 <20241217120356.1399443-3-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241217120356.1399443-3-shikemeng@huaweicloud.com>
X-Rspamd-Queue-Id: 533321F444
X-Spam-Score: -2.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[8];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[mit.edu,dilger.ca,suse.com,gmail.com,vger.kernel.org];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huaweicloud.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Tue 17-12-24 20:03:55, Kemeng Shi wrote:
> After we remove ext4 journal callback, transaction->t_private_list is
> not used anymore. Just remove unused transaction->t_private_list.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>

After the doc fixup feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  Documentation/filesystems/journalling.rst | 2 --
>  fs/jbd2/transaction.c                     | 1 -
>  include/linux/jbd2.h                      | 6 ------
>  3 files changed, 9 deletions(-)
> 
> diff --git a/Documentation/filesystems/journalling.rst b/Documentation/filesystems/journalling.rst
> index 0254f7d57429..74f6aa2e1009 100644
> --- a/Documentation/filesystems/journalling.rst
> +++ b/Documentation/filesystems/journalling.rst
> @@ -112,8 +112,6 @@ so that you can do some of your own management. You ask the journalling
>  layer for calling the callback by simply setting
>  ``journal->j_commit_callback`` function pointer and that function is
>  called after each transaction commit. You can also use
> -``transaction->t_private_list`` for attaching entries to a transaction
> -that need processing when the transaction commits.
>  
>  JBD2 also provides a way to block all transaction updates via
>  jbd2_journal_lock_updates() /
> diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
> index 66513c18ca29..9fe17e290c21 100644
> --- a/fs/jbd2/transaction.c
> +++ b/fs/jbd2/transaction.c
> @@ -92,7 +92,6 @@ static void jbd2_get_transaction(journal_t *journal,
>  	atomic_set(&transaction->t_outstanding_revokes, 0);
>  	atomic_set(&transaction->t_handle_count, 0);
>  	INIT_LIST_HEAD(&transaction->t_inode_list);
> -	INIT_LIST_HEAD(&transaction->t_private_list);
>  
>  	/* Set up the commit timer for the new transaction. */
>  	journal->j_commit_timer.expires = round_jiffies_up(transaction->t_expires);
> diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
> index 50f7ea8714bf..90c802e48e23 100644
> --- a/include/linux/jbd2.h
> +++ b/include/linux/jbd2.h
> @@ -700,12 +700,6 @@ struct transaction_s
>  
>  	/* Disk flush needs to be sent to fs partition [no locking] */
>  	int			t_need_data_flush;
> -
> -	/*
> -	 * For use by the filesystem to store fs-specific data
> -	 * structures associated with the transaction
> -	 */
> -	struct list_head	t_private_list;
>  };
>  
>  struct transaction_run_stats_s {
> -- 
> 2.30.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

