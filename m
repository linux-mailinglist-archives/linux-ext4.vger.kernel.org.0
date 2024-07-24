Return-Path: <linux-ext4+bounces-3427-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7244E93B50B
	for <lists+linux-ext4@lfdr.de>; Wed, 24 Jul 2024 18:31:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5FD11F229C9
	for <lists+linux-ext4@lfdr.de>; Wed, 24 Jul 2024 16:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1DA715EFA0;
	Wed, 24 Jul 2024 16:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="UhMdyT+l";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="RQ5xmJJc";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bDthbKvS";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="DWGmwTpW"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEFA115E5D6;
	Wed, 24 Jul 2024 16:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721838669; cv=none; b=uGGE37U1HadXs2VRIfIoFGR4+erjNybC7IMTaPUps+R9Fs9q+UEDi3hQ1WO4YVGLPoTcAvjCAHSo1GJgSkO7vxm4k6NLKXN0meUevTu/kvObn73G5wX+dNgzMEoEWtfJApUq5wR8USNGY4Ht4EvUHnrbmufHDFj2yHhR5TSjV1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721838669; c=relaxed/simple;
	bh=X4S+axh6n9d+UraU6tyfWp+dVxygrwe7VRmBJ8Eg3i4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CunfRZtxuYUJfotwB/27kgxQpDXUsG93tuwvwwd8VZHp7T5nZgTU6KBg229WChDWbPEnaJJTqEoaxHwLsyQM//xDMEwAzJd/CQzh/K+9BPBTzmmdfwp8ZFAWGhcecvXxXyh1B5tytAsNtKV+8GwGNqQUFANuns2Do6bG3dsdC8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=UhMdyT+l; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=RQ5xmJJc; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=bDthbKvS; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=DWGmwTpW; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1C69F219AB;
	Wed, 24 Jul 2024 16:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721838664; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2dEphAPeE6p30riL82+Jp1jl4eil7NiVQyFk0C6DpMw=;
	b=UhMdyT+lQ93ueFie3niS4FbzJqadMHmph8mbYJXTvMKHtWOua1OL5dt2MlWQaiCmesJyoN
	CS26XR9bFhn9Gojwlv/pFjhFJLrOLRyaQKDLwbsq/fOiMqxKcpL35170p6dfFU+3uCq8bR
	NuN0fcFRKavk0fIQXm9Wj8K4ZR3eeRg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721838664;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2dEphAPeE6p30riL82+Jp1jl4eil7NiVQyFk0C6DpMw=;
	b=RQ5xmJJcJXqComB1YFPinZ2Sr0LWWE6Y/x+CZ3k1VIqET9TjntMsvKA30LiPT2aGqWPEJj
	vPmTNYQvcVLuyCDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=bDthbKvS;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=DWGmwTpW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721838663; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2dEphAPeE6p30riL82+Jp1jl4eil7NiVQyFk0C6DpMw=;
	b=bDthbKvS082K4odebS5j4JNiEs9f/PDNSoFLN9jmsBICFyxq+xy41iDXzXSW5jPz9Tsjvr
	7r/Qi1BeUl6hG5BKKI4cXEAP4+5T654wcnDD4bEjCip+umlDYjC/pQC/XDYQF8HqO3Hqod
	zFJj9pruRjTLj8QQK5oSV8fycORB2UU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721838663;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2dEphAPeE6p30riL82+Jp1jl4eil7NiVQyFk0C6DpMw=;
	b=DWGmwTpWg0Oj2CFIK0JqqOh/VD6j5QMwNqIiIKMEqmoODlYqCG05C45zoEodPFcw1ys+Qt
	hJ7FLd9xVS7SR6Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0E8A613411;
	Wed, 24 Jul 2024 16:31:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4q+IA0csoWZmTAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 24 Jul 2024 16:31:03 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id B2319A08F2; Wed, 24 Jul 2024 18:31:02 +0200 (CEST)
Date: Wed, 24 Jul 2024 18:31:02 +0200
From: Jan Kara <jack@suse.cz>
To: "Luis Henriques (SUSE)" <luis.henriques@linux.dev>
Cc: Theodore Ts'o <tytso@mit.edu>, Andreas Dilger <adilger@dilger.ca>,
	Jan Kara <jack@suse.cz>,
	Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] ext4: fix incorrect tid assumption in
 jbd2_journal_shrink_checkpoint_list()
Message-ID: <20240724163102.gbmw6h3g7jrgsqft@quack3>
References: <20240724161119.13448-1-luis.henriques@linux.dev>
 <20240724161119.13448-4-luis.henriques@linux.dev>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240724161119.13448-4-luis.henriques@linux.dev>
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 1C69F219AB
X-Spam-Score: -3.81
X-Spam-Level: 
X-Spam-Flag: NO
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:dkim,linux.dev:email,suse.com:email]

On Wed 24-07-24 17:11:17, Luis Henriques (SUSE) wrote:
> Function jbd2_journal_shrink_checkpoint_list() assumes that '0' is not a
> valid value for transaction IDs, which is incorrect.  Don't assume that and
> use two extra boolean variables to control the loop iterations and keep
> track of the first and last tid.
> 
> Signed-off-by: Luis Henriques (SUSE) <luis.henriques@linux.dev>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/jbd2/checkpoint.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/jbd2/checkpoint.c b/fs/jbd2/checkpoint.c
> index 77bc522e6821..98a0b2eb84f5 100644
> --- a/fs/jbd2/checkpoint.c
> +++ b/fs/jbd2/checkpoint.c
> @@ -410,6 +410,7 @@ unsigned long jbd2_journal_shrink_checkpoint_list(journal_t *journal,
>  	tid_t tid = 0;
>  	unsigned long nr_freed = 0;
>  	unsigned long freed;
> +	bool first_set = false;
>  
>  again:
>  	spin_lock(&journal->j_list_lock);
> @@ -429,8 +430,10 @@ unsigned long jbd2_journal_shrink_checkpoint_list(journal_t *journal,
>  	else
>  		transaction = journal->j_checkpoint_transactions;
>  
> -	if (!first_tid)
> +	if (!first_set) {
>  		first_tid = transaction->t_tid;
> +		first_set = true;
> +	}
>  	last_transaction = journal->j_checkpoint_transactions->t_cpprev;
>  	next_transaction = transaction;
>  	last_tid = last_transaction->t_tid;
> @@ -460,7 +463,7 @@ unsigned long jbd2_journal_shrink_checkpoint_list(journal_t *journal,
>  	spin_unlock(&journal->j_list_lock);
>  	cond_resched();
>  
> -	if (*nr_to_scan && next_tid)
> +	if (*nr_to_scan && journal->j_shrink_transaction)
>  		goto again;
>  out:
>  	trace_jbd2_shrink_checkpoint_list(journal, first_tid, tid, last_tid,
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

