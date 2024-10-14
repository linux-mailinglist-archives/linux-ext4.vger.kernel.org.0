Return-Path: <linux-ext4+bounces-4583-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC6299CC97
	for <lists+linux-ext4@lfdr.de>; Mon, 14 Oct 2024 16:17:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2177E1C21BD2
	for <lists+linux-ext4@lfdr.de>; Mon, 14 Oct 2024 14:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E5591AAE32;
	Mon, 14 Oct 2024 14:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GBJwmJo/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1Z0Ig7Qp";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GBJwmJo/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1Z0Ig7Qp"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE401AAC4;
	Mon, 14 Oct 2024 14:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728915428; cv=none; b=MoHbMnMRlYhTtjK1q2NJO1hvJNi+CAAjxKvEaeFDRz/hBk+M79gLcaeSF/0mj2og1bRDu/KUd4xUArfVif9ycyex9I1SXOE3kDDb0oM9kA3m2Bx3WxDvXlMr1qHNLjEHQt7Ql2YJz1k0G3hlNUfBQogVi+Xvu0NtcUonLSVw2kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728915428; c=relaxed/simple;
	bh=uJiW21VT/6sXu7kavh+EaHIp1K7jbTfhuf/zhASzkDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NNUVPq7GI/57AdKr863CBazehGjW8Y5UcT2WnQ+xgsT/xkoYxspBqlhwginjCn6OAtD7qRrDRJbTKsB4FI/64GSkGYHO7i+mR1jVfcsdFhySQmGTY3CS2Fl5DvjJog/DvszPz5NtZH9CUvfEoYbwJORDuzyOKmaEQkxAv5Y+Osg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=GBJwmJo/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=1Z0Ig7Qp; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=GBJwmJo/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=1Z0Ig7Qp; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 42A2521D30;
	Mon, 14 Oct 2024 14:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728915425; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=f03tn5Xd/oNwILhzo86YWC/s6SaJxCfglgrDR0HP1Ts=;
	b=GBJwmJo/6xVbLCo+wiS8rDl5cngkHlmRQdQl/RuowI+Whx8EE6PArHOHSD3DHnAC0AjE2q
	tLk755t9CPU7HDrnYHCzr//J0BJZMLkQEm4umnd8fZFP89mCif7WUZ1gn2iqYWwihxJyn5
	jEe2CkZnGzRCIaUJuFrM5C6M2GAlRhc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728915425;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=f03tn5Xd/oNwILhzo86YWC/s6SaJxCfglgrDR0HP1Ts=;
	b=1Z0Ig7QpDP8DhSzyebrDaIXdKyz50/cL7JT4VCk674zD7W16zV8X8bFbg7qstNj3Cz44X6
	XpKh8RF+nF2VHVBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728915425; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=f03tn5Xd/oNwILhzo86YWC/s6SaJxCfglgrDR0HP1Ts=;
	b=GBJwmJo/6xVbLCo+wiS8rDl5cngkHlmRQdQl/RuowI+Whx8EE6PArHOHSD3DHnAC0AjE2q
	tLk755t9CPU7HDrnYHCzr//J0BJZMLkQEm4umnd8fZFP89mCif7WUZ1gn2iqYWwihxJyn5
	jEe2CkZnGzRCIaUJuFrM5C6M2GAlRhc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728915425;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=f03tn5Xd/oNwILhzo86YWC/s6SaJxCfglgrDR0HP1Ts=;
	b=1Z0Ig7QpDP8DhSzyebrDaIXdKyz50/cL7JT4VCk674zD7W16zV8X8bFbg7qstNj3Cz44X6
	XpKh8RF+nF2VHVBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3592413A51;
	Mon, 14 Oct 2024 14:17:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 73YPDeEnDWcCZQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 14 Oct 2024 14:17:05 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id DCA57A0896; Mon, 14 Oct 2024 16:17:04 +0200 (CEST)
Date: Mon, 14 Oct 2024 16:17:04 +0200
From: Jan Kara <jack@suse.cz>
To: Zhihao Cheng <chengzhihao@huaweicloud.com>
Cc: tytso@mit.edu, jack@suse.com, linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org, chengzhihao1@huawei.com,
	yi.zhang@huawei.com
Subject: Re: [PATCH] jbd2: Make b_frozen_data allocation always succeed
Message-ID: <20241014141704.lz5r7nn6bzjzcyhn@quack3>
References: <20241012085530.2147846-1-chengzhihao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241012085530.2147846-1-chengzhihao@huaweicloud.com>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,huawei.com:email,suse.com:email,suse.cz:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Sat 12-10-24 16:55:30, Zhihao Cheng wrote:
> From: Zhihao Cheng <chengzhihao1@huawei.com>
> 
> The b_frozen_data allocation should not be failed during journal
> committing process, otherwise jbd2 will abort.
> Since commit 490c1b444ce653d("jbd2: do not fail journal because of
> frozen_buffer allocation failure") already added '__GFP_NOFAIL' flag
> in do_get_write_access(), just add '__GFP_NOFAIL' flag for all allocations
> in jbd2_journal_write_metadata_buffer(), like 'new_bh' allocation does.
> Besides, remove all error handling branches for do_get_write_access().
> 
> Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/jbd2/commit.c  | 4 ----
>  fs/jbd2/journal.c | 8 +-------
>  2 files changed, 1 insertion(+), 11 deletions(-)
> 
> diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
> index 4305a1ac808a..9153ff3a08e7 100644
> --- a/fs/jbd2/commit.c
> +++ b/fs/jbd2/commit.c
> @@ -662,10 +662,6 @@ void jbd2_journal_commit_transaction(journal_t *journal)
>  		JBUFFER_TRACE(jh, "ph3: write metadata");
>  		escape = jbd2_journal_write_metadata_buffer(commit_transaction,
>  						jh, &wbuf[bufs], blocknr);
> -		if (escape < 0) {
> -			jbd2_journal_abort(journal, escape);
> -			continue;
> -		}
>  		jbd2_file_log_bh(&io_bufs, wbuf[bufs]);
>  
>  		/* Record the new block's tag in the current descriptor
> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> index 97f487c3d8fc..29d30eddf727 100644
> --- a/fs/jbd2/journal.c
> +++ b/fs/jbd2/journal.c
> @@ -318,7 +318,6 @@ static inline void jbd2_data_do_escape(char *data)
>   *
>   *
>   * Return value:
> - *  <0: Error
>   *  =0: Finished OK without escape
>   *  =1: Finished OK with escape
>   */
> @@ -386,12 +385,7 @@ int jbd2_journal_write_metadata_buffer(transaction_t *transaction,
>  			goto escape_done;
>  
>  		spin_unlock(&jh_in->b_state_lock);
> -		tmp = jbd2_alloc(bh_in->b_size, GFP_NOFS);
> -		if (!tmp) {
> -			brelse(new_bh);
> -			free_buffer_head(new_bh);
> -			return -ENOMEM;
> -		}
> +		tmp = jbd2_alloc(bh_in->b_size, GFP_NOFS | __GFP_NOFAIL);
>  		spin_lock(&jh_in->b_state_lock);
>  		if (jh_in->b_frozen_data) {
>  			jbd2_free(tmp, bh_in->b_size);
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

