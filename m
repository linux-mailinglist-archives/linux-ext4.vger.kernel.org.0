Return-Path: <linux-ext4+bounces-3411-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20C7593AE69
	for <lists+linux-ext4@lfdr.de>; Wed, 24 Jul 2024 11:17:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 393581C2328F
	for <lists+linux-ext4@lfdr.de>; Wed, 24 Jul 2024 09:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D01BA1514ED;
	Wed, 24 Jul 2024 09:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="EsQPVv9m";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="qHG+n8Tp";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="EsQPVv9m";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="qHG+n8Tp"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5FD1BF2B;
	Wed, 24 Jul 2024 09:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721812641; cv=none; b=IImABTU6wO6ENXiOtypN1NylxgZvJrde2Iw8eNq+r/HE0J+hizPZNROqEzlW8r+sAmaLk9q8yEI6MgHcK01PzyatYPvUkjeFFgwHvtMcYAtpAm3/FH/eg8H2FE9Vdm8UY6T9JquJ12WFWhwuBG0hePKTctQJGU+lbudZ1CZWjnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721812641; c=relaxed/simple;
	bh=CXofBHzrpBdaUbj8XC7Ld7WMGE7vEFg6z3VokrioM1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Op9HgQ5GyEcpeel8/Ec0KAQpsiXC6oWb2N56N6b09/yT2fCM6bJY506ckQck9B1VxMVDU6nF+MMDKj41zSFz3M7cMuvwmoB3MtZDM/k+ZBXV9zpD0N3CCw7eml7ehf6HfX0fs/8EaFOmrx5XwGW6Mi/vqpnENecj5swZSqU3aSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=EsQPVv9m; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=qHG+n8Tp; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=EsQPVv9m; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=qHG+n8Tp; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 83EFC21B8C;
	Wed, 24 Jul 2024 09:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721812637; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nbN52Lpu/7vkUhsIY32Ih86bpn/mJ4b+OSL2WMk2ltY=;
	b=EsQPVv9mNGaqh2wdsPKg2UulCQjg8tVHNehxNJubmgDfVKKsEd0Uk0xy76rzhLyBtcYdRH
	xpPw3efIHILOOkcg1YHb1wRQVgonW/tvffgbv2riBAw1jz19kjaJyb97c1Vv/k87+zOIuj
	GqrM3OI2Pdnh9mKb030dDxMUfBM2lqY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721812637;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nbN52Lpu/7vkUhsIY32Ih86bpn/mJ4b+OSL2WMk2ltY=;
	b=qHG+n8TphMAuK2tJoiQI/kZFbotvqQN2QFn9bzo9eHXJ0mIf+LP3Fk2Vl/euBCloJKwPwb
	gqMpHm8IxnNr0SBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721812637; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nbN52Lpu/7vkUhsIY32Ih86bpn/mJ4b+OSL2WMk2ltY=;
	b=EsQPVv9mNGaqh2wdsPKg2UulCQjg8tVHNehxNJubmgDfVKKsEd0Uk0xy76rzhLyBtcYdRH
	xpPw3efIHILOOkcg1YHb1wRQVgonW/tvffgbv2riBAw1jz19kjaJyb97c1Vv/k87+zOIuj
	GqrM3OI2Pdnh9mKb030dDxMUfBM2lqY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721812637;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nbN52Lpu/7vkUhsIY32Ih86bpn/mJ4b+OSL2WMk2ltY=;
	b=qHG+n8TphMAuK2tJoiQI/kZFbotvqQN2QFn9bzo9eHXJ0mIf+LP3Fk2Vl/euBCloJKwPwb
	gqMpHm8IxnNr0SBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7910F1324F;
	Wed, 24 Jul 2024 09:17:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QbKJHZ3GoGZvVAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 24 Jul 2024 09:17:17 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 1843CA0990; Wed, 24 Jul 2024 11:17:13 +0200 (CEST)
Date: Wed, 24 Jul 2024 11:17:13 +0200
From: Jan Kara <jack@suse.cz>
To: "Luis Henriques (SUSE)" <luis.henriques@linux.dev>
Cc: Theodore Ts'o <tytso@mit.edu>, Andreas Dilger <adilger@dilger.ca>,
	Jan Kara <jack@suse.cz>,
	Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] ext4: fix incorrect tid assumption in
 ext4_wait_for_tail_page_commit()
Message-ID: <20240724091713.e4w2hskcybulz27z@quack3>
References: <20240723154402.21125-1-luis.henriques@linux.dev>
 <20240723154402.21125-2-luis.henriques@linux.dev>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240723154402.21125-2-luis.henriques@linux.dev>
X-Spam-Level: 
X-Spamd-Result: default: False [-0.60 / 50.00];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[mit.edu,dilger.ca,suse.cz,gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -0.60

On Tue 23-07-24 16:43:59, Luis Henriques (SUSE) wrote:
> Function ext4_wait_for_tail_page_commit() assumes that '0' is not a valid
> value for transaction IDs, which is incorrect.  Don't assume that and invoke
> jbd2_log_wait_commit() if the journal had a committing transaction instead.
> 
> Signed-off-by: Luis Henriques (SUSE) <luis.henriques@linux.dev>
> ---
>  fs/ext4/inode.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 941c1c0d5c6e..e65fc2086701 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -5279,8 +5279,9 @@ static void ext4_wait_for_tail_page_commit(struct inode *inode)
>  {
>  	unsigned offset;
>  	journal_t *journal = EXT4_SB(inode->i_sb)->s_journal;
> -	tid_t commit_tid = 0;
> +	tid_t commit_tid;
>  	int ret;
> +	bool has_transaction = false;
>  
>  	offset = inode->i_size & (PAGE_SIZE - 1);
>  	/*
> @@ -5305,12 +5306,13 @@ static void ext4_wait_for_tail_page_commit(struct inode *inode)
>  		folio_put(folio);
>  		if (ret != -EBUSY)
>  			return;
> -		commit_tid = 0;

We should set "has_transaction = false" here to make things work properly
when looping... Otherwise looks good.

								Honza

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

