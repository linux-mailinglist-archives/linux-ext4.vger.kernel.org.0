Return-Path: <linux-ext4+bounces-3426-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D87693B504
	for <lists+linux-ext4@lfdr.de>; Wed, 24 Jul 2024 18:30:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AB3A1F21F18
	for <lists+linux-ext4@lfdr.de>; Wed, 24 Jul 2024 16:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8815815ADB1;
	Wed, 24 Jul 2024 16:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YEHNYp0U";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="GWfa/qLa";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bK2uYOEi";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="XnQFSv6/"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376F717C6A;
	Wed, 24 Jul 2024 16:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721838641; cv=none; b=m7WSoNJwJk23CtqZ5kmo8whF2WJTjp3w8glP3jitRE9vU447BEHDvLD377KNhIZyLdDLXf94YyZSZaqqzdXGW9mm482ZhaEy/w/Yql8gBVelt/uCfxGBYCuc9+qkWSXlYKBe/uMXRXW/N/6Oj6xkNoOOi68VZmUjWMuNIPAKLoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721838641; c=relaxed/simple;
	bh=EuAgZTw909yCeKEy7/cVRk5wbS1WJhMMh7YuKSEZF2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jfg6BWFXNrpcQ02zWgh6pg0kuOLTgEBvQN1xGqpEp11wQrvEv97oK6QsReNWEFJB+REuHteBTdP339HpW2Rn8B9ukClDRmhGEJhCrSpLSly2N4cRX4BlNb01V2b8L+wvO52+ZdYJposMi6uANfRuFqdjvVBpGl7eKP22TBrTSeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=YEHNYp0U; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=GWfa/qLa; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=bK2uYOEi; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=XnQFSv6/; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 304101F7B1;
	Wed, 24 Jul 2024 16:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721838637; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=55xTIR4A1PEU6rWUZYuzmbslXBC0J9yBaGCTl3ynzo0=;
	b=YEHNYp0Ut9ZBFOgrlZq04eZi7hLzq9qiXVaWEzFH0/6HYsaNw9nDXQ8uZVxj1clWphmW2x
	avCHuYzhI9l8DEgKDlf1uww9mExcsY3olApADsVfqZlM0WKMe7zeYbjOcdocyxu315bd5r
	7rbcQ+HWr2JjOOgrp2ql9RTgoY9uqpk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721838637;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=55xTIR4A1PEU6rWUZYuzmbslXBC0J9yBaGCTl3ynzo0=;
	b=GWfa/qLa3bwixf7QCfxGToj17unaqnN3ldtbScroVNJIukF5NOSn2YgL1fO7rOqAjitlpJ
	zkYGEhV8UVVDE+DQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=bK2uYOEi;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="XnQFSv6/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721838636; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=55xTIR4A1PEU6rWUZYuzmbslXBC0J9yBaGCTl3ynzo0=;
	b=bK2uYOEi2EY+5KNT2Roqwv77zKGj+t3pTTYBkUXxAet8tbbgYh0vpdqKBbDrA9BmCOyOv6
	B27Q5cqF1e1aGiKys46zMIQXehhgUCA1MTcHzs+wtDwaAt64ATdNGuW4Yb3CMbDSA1+q6T
	Y0oX4EhiRsLZuplUexQn5AVC8sQtkL4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721838636;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=55xTIR4A1PEU6rWUZYuzmbslXBC0J9yBaGCTl3ynzo0=;
	b=XnQFSv6/SOJwCtHRIam6ckITwu88B6LwMzehqKVdUodokrdEi+zlNSR5LIZIiOZU7vgnwm
	kasgDeu/QVaxuIDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 25BB013411;
	Wed, 24 Jul 2024 16:30:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hHszCSwsoWYxTAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 24 Jul 2024 16:30:36 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id C6E11A08F2; Wed, 24 Jul 2024 18:30:31 +0200 (CEST)
Date: Wed, 24 Jul 2024 18:30:31 +0200
From: Jan Kara <jack@suse.cz>
To: "Luis Henriques (SUSE)" <luis.henriques@linux.dev>
Cc: Theodore Ts'o <tytso@mit.edu>, Andreas Dilger <adilger@dilger.ca>,
	Jan Kara <jack@suse.cz>,
	Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] ext4: fix incorrect tid assumption in
 ext4_wait_for_tail_page_commit()
Message-ID: <20240724163031.kxuamtgcxoopng46@quack3>
References: <20240724161119.13448-1-luis.henriques@linux.dev>
 <20240724161119.13448-2-luis.henriques@linux.dev>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240724161119.13448-2-luis.henriques@linux.dev>
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.81 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[7];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[mit.edu,dilger.ca,suse.cz,gmail.com,vger.kernel.org];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,suse.cz:email,suse.cz:dkim,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -3.81
X-Rspamd-Queue-Id: 304101F7B1

On Wed 24-07-24 17:11:15, Luis Henriques (SUSE) wrote:
> Function ext4_wait_for_tail_page_commit() assumes that '0' is not a valid
> value for transaction IDs, which is incorrect.  Don't assume that and invoke
> jbd2_log_wait_commit() if the journal had a committing transaction instead.
> 
> Signed-off-by: Luis Henriques (SUSE) <luis.henriques@linux.dev>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/inode.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 941c1c0d5c6e..a0fa5192db8e 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -5279,8 +5279,9 @@ static void ext4_wait_for_tail_page_commit(struct inode *inode)
>  {
>  	unsigned offset;
>  	journal_t *journal = EXT4_SB(inode->i_sb)->s_journal;
> -	tid_t commit_tid = 0;
> +	tid_t commit_tid;
>  	int ret;
> +	bool has_transaction;
>  
>  	offset = inode->i_size & (PAGE_SIZE - 1);
>  	/*
> @@ -5305,12 +5306,14 @@ static void ext4_wait_for_tail_page_commit(struct inode *inode)
>  		folio_put(folio);
>  		if (ret != -EBUSY)
>  			return;
> -		commit_tid = 0;
> +		has_transaction = false;
>  		read_lock(&journal->j_state_lock);
> -		if (journal->j_committing_transaction)
> +		if (journal->j_committing_transaction) {
>  			commit_tid = journal->j_committing_transaction->t_tid;
> +			has_transaction = true;
> +		}
>  		read_unlock(&journal->j_state_lock);
> -		if (commit_tid)
> +		if (has_transaction)
>  			jbd2_log_wait_commit(journal, commit_tid);
>  	}
>  }
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

