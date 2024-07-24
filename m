Return-Path: <linux-ext4+bounces-3413-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A233093AF0A
	for <lists+linux-ext4@lfdr.de>; Wed, 24 Jul 2024 11:30:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F3F11F21B4C
	for <lists+linux-ext4@lfdr.de>; Wed, 24 Jul 2024 09:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AFF514290C;
	Wed, 24 Jul 2024 09:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="M3pkWACB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3eTAMd22";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="M3pkWACB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3eTAMd22"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE83140384;
	Wed, 24 Jul 2024 09:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721813406; cv=none; b=Cu5rJVuIzlWiOaHZRDimf0JajxuqB3Xst7glF5kh9z8sRfdEagJO6R9kyS3d36VqpUSnChg5y03XxyYUiVkv4qWlCrtDYzciD2ng/2sB3fMHTqYP7+zDsVQIkD71rQQNwmMka/p6iWsiC/UxWLz/DCHrPLiNCuNVS2sLHGX8NR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721813406; c=relaxed/simple;
	bh=M5T9/3b7Kut2vpxC0paxHLGkJj9Z1YCDtsubVtaifrk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hk/pmo8830uQYU2B6j2uogH+8unBOpS6BhbDB3hiIWn0uVR0NILfKjxiz0AcLcnFOFHRPbh0637NCjvfojqt6RA5+8hIgzp/JNEsuOotobJTXsZ/UGEhYgqzzqzK5P9d4U0mKTFvwL7azYqvHsNcqQAb9NjS60KOTXlbLsw9LSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=M3pkWACB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3eTAMd22; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=M3pkWACB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3eTAMd22; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 53C241F38E;
	Wed, 24 Jul 2024 09:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721813403; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YEivGrLFhTxqtu6NIvwgliGb++s5BwWl1bkhzaxkZdk=;
	b=M3pkWACBn1oB+9OfJFHVQPwpf+5wcXslzBTU180M7RwCaLU7/6HlYVr9gtmfYHd8+e6U+P
	xJlbQXiUytpzuHsT8S67hLst5EcdaijySchkPDGN/Mg7gymgDFO8T3L37zLs5FW9gCj2Zw
	etV2AInpHLf60DOJfxp2MDDnPn+Z2z4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721813403;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YEivGrLFhTxqtu6NIvwgliGb++s5BwWl1bkhzaxkZdk=;
	b=3eTAMd22f23K7xdNsyxlZZVUjDnUqGzST/VXm3xZqmXSMZWrskL5KTetVkhJHh/rPEtbXu
	UiCOehzLbnGjsUDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721813403; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YEivGrLFhTxqtu6NIvwgliGb++s5BwWl1bkhzaxkZdk=;
	b=M3pkWACBn1oB+9OfJFHVQPwpf+5wcXslzBTU180M7RwCaLU7/6HlYVr9gtmfYHd8+e6U+P
	xJlbQXiUytpzuHsT8S67hLst5EcdaijySchkPDGN/Mg7gymgDFO8T3L37zLs5FW9gCj2Zw
	etV2AInpHLf60DOJfxp2MDDnPn+Z2z4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721813403;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YEivGrLFhTxqtu6NIvwgliGb++s5BwWl1bkhzaxkZdk=;
	b=3eTAMd22f23K7xdNsyxlZZVUjDnUqGzST/VXm3xZqmXSMZWrskL5KTetVkhJHh/rPEtbXu
	UiCOehzLbnGjsUDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3CA601324F;
	Wed, 24 Jul 2024 09:30:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kt7JDpvJoGZuVwAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 24 Jul 2024 09:30:03 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id E6CFDA0990; Wed, 24 Jul 2024 11:29:54 +0200 (CEST)
Date: Wed, 24 Jul 2024 11:29:54 +0200
From: Jan Kara <jack@suse.cz>
To: "Luis Henriques (SUSE)" <luis.henriques@linux.dev>
Cc: Theodore Ts'o <tytso@mit.edu>, Andreas Dilger <adilger@dilger.ca>,
	Jan Kara <jack@suse.cz>,
	Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] ext4: fix incorrect tid assumption in
 jbd2_journal_shrink_checkpoint_list()
Message-ID: <20240724092954.gw3hwyax7u5kpn5o@quack3>
References: <20240723154402.21125-1-luis.henriques@linux.dev>
 <20240723154402.21125-4-luis.henriques@linux.dev>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240723154402.21125-4-luis.henriques@linux.dev>
X-Spamd-Result: default: False [-3.60 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[mit.edu,dilger.ca,suse.cz,gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -3.60

On Tue 23-07-24 16:44:01, Luis Henriques (SUSE) wrote:
> Function jbd2_journal_shrink_checkpoint_list() assumes that '0' is not a
> valid value for transaction IDs, which is incorrect.  Don't assume that and
> use two extra boolean variables to control the loop iterations and keep
> track of the first and last tid.
> 
> Signed-off-by: Luis Henriques (SUSE) <luis.henriques@linux.dev>
> ---
>  fs/jbd2/checkpoint.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/jbd2/checkpoint.c b/fs/jbd2/checkpoint.c
> index 77bc522e6821..f5a594237b7a 100644
> --- a/fs/jbd2/checkpoint.c
> +++ b/fs/jbd2/checkpoint.c
> @@ -410,6 +410,7 @@ unsigned long jbd2_journal_shrink_checkpoint_list(journal_t *journal,
>  	tid_t tid = 0;
>  	unsigned long nr_freed = 0;
>  	unsigned long freed;
> +	bool is_first = true, is_last = false;
>  
>  again:
>  	spin_lock(&journal->j_list_lock);
> @@ -429,8 +430,10 @@ unsigned long jbd2_journal_shrink_checkpoint_list(journal_t *journal,
>  	else
>  		transaction = journal->j_checkpoint_transactions;
>  
> -	if (!first_tid)
> +	if (is_first) {
>  		first_tid = transaction->t_tid;
> +		is_first = false;
> +	}
>  	last_transaction = journal->j_checkpoint_transactions->t_cpprev;
>  	next_transaction = transaction;
>  	last_tid = last_transaction->t_tid;
> @@ -455,12 +458,13 @@ unsigned long jbd2_journal_shrink_checkpoint_list(journal_t *journal,
>  	} else {
>  		journal->j_shrink_transaction = NULL;
>  		next_tid = 0;
> +		is_last = true;
>  	}
>  
>  	spin_unlock(&journal->j_list_lock);
>  	cond_resched();
>  
> -	if (*nr_to_scan && next_tid)
> +	if (*nr_to_scan && !is_last)

I'd make this:

	if (*nr_to_scan && journal->j_shrink_transaction)
		goto again;

and just remove is_last. Also we might rename is_first to first_set? At
least to me it would be more comprehensible. Thanks!

								Honza

>  		goto again;
>  out:
>  	trace_jbd2_shrink_checkpoint_list(journal, first_tid, tid, last_tid,
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

