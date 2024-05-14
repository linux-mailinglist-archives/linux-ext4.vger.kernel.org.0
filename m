Return-Path: <linux-ext4+bounces-2510-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 634CF8C5E24
	for <lists+linux-ext4@lfdr.de>; Wed, 15 May 2024 01:41:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B393BB21715
	for <lists+linux-ext4@lfdr.de>; Tue, 14 May 2024 23:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 000E6182CA2;
	Tue, 14 May 2024 23:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="kG6cxxqN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="W6bo8AVv";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="kG6cxxqN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="W6bo8AVv"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF911E871;
	Tue, 14 May 2024 23:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715730069; cv=none; b=s3ay0ldJYWOL+h33jQA9Vae90i+FTktOJz5D7gFFLAqK9iao9d6cEPUoifeYVcfsN3+5P02d163lZT2djUm6OepMsEBRNeDMIhCfqNxJKfQusdw1cRkZyk2GiwhQd3xrAuAP49499ElLsX7kBGl8aCN6y5Rak+WhqBSoZXzuqTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715730069; c=relaxed/simple;
	bh=w2X85Z2HthCEJW9eHGQmyHOLa23xK8+fkZHLn+hr7nY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hi9yr9FV3E2VcCsXwkx6ZLlHqiOgk/GUxaDbILvNL3PvEWdDi8ITT99MDifBlgNWY+V/nh/dXv0QT7UZWAVFanDAnVzZ5uLtn+xyxeyZVTwIk2lBVLd+wNcnVfJ2+touT1zElcKxjvZ2JR8jaZMmR+S7ZM7+Zp/XZxN5TfOw5l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=kG6cxxqN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=W6bo8AVv; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=kG6cxxqN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=W6bo8AVv; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1FC841FED5;
	Tue, 14 May 2024 23:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715730065; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lyV7ngpZjilvk2cY2YRxyfYD5wIrha2SfFGOdjClKe4=;
	b=kG6cxxqN2w4xfnjDvdsuSNRb0HrwXETX1VWGfYj73F7M23SyQkNg+kikALL/yrfKfyzekK
	BXo6qO0DOqHSGE1BQEtsONylGT7a4M2ZBayISXzZJmTQNjhARJYYXEzDmvfnSd39sgtIU4
	u6dUFpE6qlplt4v5EQ0ZPQ8fGIj0KFs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715730065;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lyV7ngpZjilvk2cY2YRxyfYD5wIrha2SfFGOdjClKe4=;
	b=W6bo8AVvxX7pPTyVownj3lUVac7R2+BP0xM+vvNE3spyho6a3tkS1ZcEeI4/aYlzqrX5EZ
	AXx2jQay/KjoZRDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715730065; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lyV7ngpZjilvk2cY2YRxyfYD5wIrha2SfFGOdjClKe4=;
	b=kG6cxxqN2w4xfnjDvdsuSNRb0HrwXETX1VWGfYj73F7M23SyQkNg+kikALL/yrfKfyzekK
	BXo6qO0DOqHSGE1BQEtsONylGT7a4M2ZBayISXzZJmTQNjhARJYYXEzDmvfnSd39sgtIU4
	u6dUFpE6qlplt4v5EQ0ZPQ8fGIj0KFs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715730065;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lyV7ngpZjilvk2cY2YRxyfYD5wIrha2SfFGOdjClKe4=;
	b=W6bo8AVvxX7pPTyVownj3lUVac7R2+BP0xM+vvNE3spyho6a3tkS1ZcEeI4/aYlzqrX5EZ
	AXx2jQay/KjoZRDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C176D137C3;
	Tue, 14 May 2024 23:41:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yHktL5D2Q2bvTAAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 14 May 2024 23:41:04 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 98917A08B5; Wed, 15 May 2024 01:41:01 +0200 (CEST)
Date: Wed, 15 May 2024 01:41:01 +0200
From: Jan Kara <jack@suse.cz>
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: tytso@mit.edu, jack@suse.com, yi.zhang@huaweicloud.com,
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/9] jbd2: remove unused return info from
 jbd2_journal_write_metadata_buffer
Message-ID: <20240514234101.2ke6hq4xwitwk7a5@quack3>
References: <20240514112438.1269037-1-shikemeng@huaweicloud.com>
 <20240514112438.1269037-3-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240514112438.1269037-3-shikemeng@huaweicloud.com>
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]

On Tue 14-05-24 19:24:31, Kemeng Shi wrote:
> The done_copy_out info from jbd2_journal_write_metadata_buffer is not
> used. Simply remove it.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/jbd2/commit.c  | 10 +++++-----
>  fs/jbd2/journal.c |  9 +++------
>  2 files changed, 8 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
> index 5e122586e06e..67077308b56b 100644
> --- a/fs/jbd2/commit.c
> +++ b/fs/jbd2/commit.c
> @@ -353,7 +353,7 @@ void jbd2_journal_commit_transaction(journal_t *journal)
>  	struct buffer_head *descriptor;
>  	struct buffer_head **wbuf = journal->j_wbuf;
>  	int bufs;
> -	int flags;
> +	int escape;
>  	int err;
>  	unsigned long long blocknr;
>  	ktime_t start_time;
> @@ -661,10 +661,10 @@ void jbd2_journal_commit_transaction(journal_t *journal)
>  		 */
>  		set_bit(BH_JWrite, &jh2bh(jh)->b_state);
>  		JBUFFER_TRACE(jh, "ph3: write metadata");
> -		flags = jbd2_journal_write_metadata_buffer(commit_transaction,
> +		escape = jbd2_journal_write_metadata_buffer(commit_transaction,
>  						jh, &wbuf[bufs], blocknr);
> -		if (flags < 0) {
> -			jbd2_journal_abort(journal, flags);
> +		if (escape < 0) {
> +			jbd2_journal_abort(journal, escape);
>  			continue;
>  		}
>  		jbd2_file_log_bh(&io_bufs, wbuf[bufs]);
> @@ -673,7 +673,7 @@ void jbd2_journal_commit_transaction(journal_t *journal)
>                     buffer */
>  
>  		tag_flag = 0;
> -		if (flags & 1)
> +		if (escape)
>  			tag_flag |= JBD2_FLAG_ESCAPE;
>  		if (!first_tag)
>  			tag_flag |= JBD2_FLAG_SAME_UUID;
> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> index 207b24e12ce9..2dca2f613a8e 100644
> --- a/fs/jbd2/journal.c
> +++ b/fs/jbd2/journal.c
> @@ -316,11 +316,8 @@ static void journal_kill_thread(journal_t *journal)
>   *
>   * Return value:
>   *  <0: Error
> - * >=0: Finished OK
> - *
> - * On success:
> - * Bit 0 set == escape performed on the data
> - * Bit 1 set == buffer copy-out performed (kfree the data after IO)
> + *  =0: Finished OK without escape
> + *  =1: Finished OK with escape
>   */
>  
>  int jbd2_journal_write_metadata_buffer(transaction_t *transaction,
> @@ -455,7 +452,7 @@ int jbd2_journal_write_metadata_buffer(transaction_t *transaction,
>  	set_buffer_shadow(bh_in);
>  	spin_unlock(&jh_in->b_state_lock);
>  
> -	return do_escape | (done_copy_out << 1);
> +	return do_escape;
>  }
>  
>  /*
> -- 
> 2.30.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

