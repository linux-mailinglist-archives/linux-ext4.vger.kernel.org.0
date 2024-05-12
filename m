Return-Path: <linux-ext4+bounces-2488-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0536C8C424A
	for <lists+linux-ext4@lfdr.de>; Mon, 13 May 2024 15:43:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8518C1F21868
	for <lists+linux-ext4@lfdr.de>; Mon, 13 May 2024 13:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D58E9155317;
	Mon, 13 May 2024 13:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JoPhuCes";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="X8j/+C/h";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JoPhuCes";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="X8j/+C/h"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52640153BFA;
	Mon, 13 May 2024 13:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715607701; cv=none; b=iIA4R5RVrWI+ZNJ3BXszNUeRHGTqqrsDII7iuIM0VL4dMZpzpDYbgZbeq9QdY0ZNZcBo28VmgPtsiVlWxuN3XIws1y6tH5PyFJPdqprgG1BFML908aEDkUEnl+RktrLGbufjGz9qn3dAIbnAEtAARs429TP+PDlfLJ7v0GsMlhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715607701; c=relaxed/simple;
	bh=WCLxEWrIyGElG9qLBm+IRdFk/KeQE60hWIWVJkJiHfM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hHqJlz0nL54ooDpWP47oKMVOk09M30hS3xR2TuIHZPyEqzq8eUWvZRDl5y0FEIKIkfNmXEoXiygg3QrHap5CD2GUj6NXCW4Y8MD45jisiGrzYnmQD4rw8FuvcEYn9RPiefUXw0NR69AdPeiI1N763cS2acnleJ45plWgp1irtQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=JoPhuCes; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=X8j/+C/h; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=JoPhuCes; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=X8j/+C/h; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 32CEE34A49;
	Mon, 13 May 2024 13:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715607696; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YbaiNXowjiOx5ttYJXapRo1hEnRKYdGgRBjGn4cDngs=;
	b=JoPhuCeswMVp+n9wvezUVRO2uUhrvGAokhL895RMVVpNcVzwB+uxwiDHwL8t/AGvdLOYBu
	6PZwgplmSgac0TYuqOd1V9C2/yjz9FlxBJS2dFI55BGF13zWfxdv7IjLfJFjgHAv7hQJir
	+uROtdIDXzKOvMwwXNiKZZ4xC/3NHOQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715607696;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YbaiNXowjiOx5ttYJXapRo1hEnRKYdGgRBjGn4cDngs=;
	b=X8j/+C/hoWux9IemiUy6u15c7zUdiGBdtLfRGsH/5y37fYJd3Q5n8LVp+UAv3tWA+5bmGU
	MYkYKSFzXt7ixUDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715607696; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YbaiNXowjiOx5ttYJXapRo1hEnRKYdGgRBjGn4cDngs=;
	b=JoPhuCeswMVp+n9wvezUVRO2uUhrvGAokhL895RMVVpNcVzwB+uxwiDHwL8t/AGvdLOYBu
	6PZwgplmSgac0TYuqOd1V9C2/yjz9FlxBJS2dFI55BGF13zWfxdv7IjLfJFjgHAv7hQJir
	+uROtdIDXzKOvMwwXNiKZZ4xC/3NHOQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715607696;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YbaiNXowjiOx5ttYJXapRo1hEnRKYdGgRBjGn4cDngs=;
	b=X8j/+C/hoWux9IemiUy6u15c7zUdiGBdtLfRGsH/5y37fYJd3Q5n8LVp+UAv3tWA+5bmGU
	MYkYKSFzXt7ixUDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E144413A62;
	Mon, 13 May 2024 13:41:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id a+3/No8YQmZXDwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 13 May 2024 13:41:35 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 6A1CBA08E3; Sun, 12 May 2024 13:22:05 +0200 (CEST)
Date: Sun, 12 May 2024 13:22:05 +0200
From: Jan Kara <jack@suse.cz>
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: tytso@mit.edu, jack@suse.com, linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/9] jbd2: remove dead equality check of
 j_commit_[sequence/request] in kjournald2
Message-ID: <20240512112205.6bknpxlpovqxjfkm@quack3>
References: <20240506141801.1165315-1-shikemeng@huaweicloud.com>
 <20240506141801.1165315-8-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240506141801.1165315-8-shikemeng@huaweicloud.com>
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	DATE_IN_PAST(1.00)[26];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:email,suse.com:email]

On Mon 06-05-24 22:17:59, Kemeng Shi wrote:
> In kjournald2, two equality checks of j_commit_[sequence/request] are
> under the same j_state_lock. As j_commit_[sequence/request] are updated
> concurrently with j_state_lock held during runtime, the second check is
> unnecessary.
> The j_commit_sequence is only updated concurrently in
> jbd2_journal_commit_transaction with j_state_lock held.
> The j_commit_request is only updated concurrently in
> __jbd2_log_start_commit with j_state_lock held.
> Also see comment in struct journal_s about lock rule of j_commit_sequence
> and j_commit_request.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/jbd2/journal.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> index 01e33b643e4d..e8f592fbd6e1 100644
> --- a/fs/jbd2/journal.c
> +++ b/fs/jbd2/journal.c
> @@ -224,8 +224,6 @@ static int kjournald2(void *arg)
>  
>  		prepare_to_wait(&journal->j_wait_commit, &wait,
>  				TASK_INTERRUPTIBLE);
> -		if (journal->j_commit_sequence != journal->j_commit_request)
> -			should_sleep = 0;
>  		transaction = journal->j_running_transaction;
>  		if (transaction && time_after_eq(jiffies,
>  						transaction->t_expires))
> -- 
> 2.30.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

