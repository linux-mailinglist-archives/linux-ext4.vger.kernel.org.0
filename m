Return-Path: <linux-ext4+bounces-3412-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B26993AEC0
	for <lists+linux-ext4@lfdr.de>; Wed, 24 Jul 2024 11:20:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8134A1F24F87
	for <lists+linux-ext4@lfdr.de>; Wed, 24 Jul 2024 09:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 579171514E9;
	Wed, 24 Jul 2024 09:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VJYAG3H1";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="UzaB2ipQ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QoopRCRt";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="RhnTS5kN"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28900433B5;
	Wed, 24 Jul 2024 09:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721812809; cv=none; b=PLrbRHjUrNVyzVlW7gz2J9J242iAPkRv9JEIB/cYlWmnwkD2u+wp8bvGhMr2ZEnTqvCOGJFlafE5859FiA71tQ/M/DSbdrul4Z5QWCVOA3N9h9Qi5gIsOxAh7S8/7zMbND0ap1MsFJJw1eVPDuNKF/SSgBu9E7r51mBNxbqClYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721812809; c=relaxed/simple;
	bh=nulWraoQSqye9tK1Jj50gbQhwQQyZcyhPOzNlv19XY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KxTCwo51GGNjq0RMUTj5kR8jx2fcG1JofUguefCX0lg1pKB7FPdZPEznuvCh/DipXIi9znzxBJyC6JUcesMj4NM1fTyYMcLXujbm6oGlv5rZp4KynWGM2GrkUz0OrAUm/ermHYsNsWv/mpqwRIQGVA9fS+XgWxo4hL+BbTJpxDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=VJYAG3H1; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=UzaB2ipQ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QoopRCRt; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=RhnTS5kN; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 38AB021BAC;
	Wed, 24 Jul 2024 09:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721812806; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OYSJIqqlTYlQISPvJ9eLHHdSdPg7LN3Hv/QnUacHE38=;
	b=VJYAG3H13ey33gqglLfH7zhlbGLWi36RD9BA1KbnG6fY4K/AX5U8E6WEFT5CtknztNNtPY
	rM57XRI1h9PHUvLtSr/LVLru4ssUXSk0ykOrAhazJ8kmWn46uDJzEPIIJD8DuFs/OKGztD
	zXoPTAKxiOj5nBpdvj9+2TYwo/vcap8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721812806;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OYSJIqqlTYlQISPvJ9eLHHdSdPg7LN3Hv/QnUacHE38=;
	b=UzaB2ipQ5Ak+SVxd/mp6yVsAzKu+5sX/WwoEROShMf8d16Uu788ncgF49DVY2CEEN5SB3/
	xEslqFJVD4mHzuDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721812805; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OYSJIqqlTYlQISPvJ9eLHHdSdPg7LN3Hv/QnUacHE38=;
	b=QoopRCRtGlGketdSdvOCxcWhdrUujjCFcTnm0OeySVGxwtU0tNk0AmE0a4f3sS+HhaqROK
	yikwVwFpwXH4TSJHsIFyAMvkrWTLoiXy42zdKJ9zPgQL5FzoV6KYBvZqk1+H5wG9YraPBg
	SyEE4wdoKQ+VcZF6cF3gNYbjW2pKMqE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721812805;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OYSJIqqlTYlQISPvJ9eLHHdSdPg7LN3Hv/QnUacHE38=;
	b=RhnTS5kNqyc7Ku+a44XZ0R2Hg007Fz4ZQiurfXk+p5BbKqeNYb1RSwTPOoTqoxsfCi9Fto
	H5ySlXl63SLXi8CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2EB6D1324F;
	Wed, 24 Jul 2024 09:20:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id i5pmC0XHoGYWVQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 24 Jul 2024 09:20:05 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id DC8F3A0990; Wed, 24 Jul 2024 11:20:04 +0200 (CEST)
Date: Wed, 24 Jul 2024 11:20:04 +0200
From: Jan Kara <jack@suse.cz>
To: "Luis Henriques (SUSE)" <luis.henriques@linux.dev>
Cc: Theodore Ts'o <tytso@mit.edu>, Andreas Dilger <adilger@dilger.ca>,
	Jan Kara <jack@suse.cz>,
	Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] ext4: fix incorrect tid assumption in
 __jbd2_log_wait_for_space()
Message-ID: <20240724092004.mzwdecz35cal227n@quack3>
References: <20240723154402.21125-1-luis.henriques@linux.dev>
 <20240723154402.21125-3-luis.henriques@linux.dev>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240723154402.21125-3-luis.henriques@linux.dev>
X-Spamd-Result: default: False [-3.60 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.10)[text/plain];
	URIBL_BLOCKED(0.00)[suse.cz:email,linux.dev:email,suse.com:email,imap1.dmz-prg2.suse.org:helo];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[mit.edu,dilger.ca,suse.cz,gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,suse.cz:email,imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -3.60

On Tue 23-07-24 16:44:00, Luis Henriques (SUSE) wrote:
> Function __jbd2_log_wait_for_space() assumes that '0' is not a valid value
> for transaction IDs, which is incorrect.  Don't assume that and invoke
> jbd2_log_wait_commit() if the journal had a committing transaction instead.
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
> index 951f78634adf..77bc522e6821 100644
> --- a/fs/jbd2/checkpoint.c
> +++ b/fs/jbd2/checkpoint.c
> @@ -79,9 +79,12 @@ __releases(&journal->j_state_lock)
>  		if (space_left < nblocks) {
>  			int chkpt = journal->j_checkpoint_transactions != NULL;
>  			tid_t tid = 0;
> +			bool has_transaction = false;
>  
> -			if (journal->j_committing_transaction)
> +			if (journal->j_committing_transaction) {
>  				tid = journal->j_committing_transaction->t_tid;
> +				has_transaction = true;
> +			}
>  			spin_unlock(&journal->j_list_lock);
>  			write_unlock(&journal->j_state_lock);
>  			if (chkpt) {
> @@ -89,7 +92,7 @@ __releases(&journal->j_state_lock)
>  			} else if (jbd2_cleanup_journal_tail(journal) == 0) {
>  				/* We were able to recover space; yay! */
>  				;
> -			} else if (tid) {
> +			} else if (has_transaction) {
>  				/*
>  				 * jbd2_journal_commit_transaction() may want
>  				 * to take the checkpoint_mutex if JBD2_FLUSHED
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

