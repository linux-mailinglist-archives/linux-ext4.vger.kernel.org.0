Return-Path: <linux-ext4+bounces-2726-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C6B8D6A87
	for <lists+linux-ext4@lfdr.de>; Fri, 31 May 2024 22:12:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 318F91F2208B
	for <lists+linux-ext4@lfdr.de>; Fri, 31 May 2024 20:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5814517D37D;
	Fri, 31 May 2024 20:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="F1L0x7Rr";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="pzPuoZ5R";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="F1L0x7Rr";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="pzPuoZ5R"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCBB6EAE7;
	Fri, 31 May 2024 20:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717186355; cv=none; b=jIPG0sSjPqtCkvqXO+p95zWIobODl8B1r9LLfBLJarmBGMuexZ/V1QyGZ0NUGYyjlOfRfRR1/Ea+IndUVAs8zpE2X4Ox3b8dKByEVdWviX3LjrNpZNR6npMpZwQoFruWAWlk0VUpcOHoIQpnKuQEY3Zmfl4BeKa6mLNtWu6ObKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717186355; c=relaxed/simple;
	bh=PS4M7kRCVQqt7j4FPqpECbKoj/X5NVci6cyJdj4/aUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GcLG7P/gsnKbz9eGhQM14dNX0HUs1qu1id/WfLHHpjtbDLQ4yKAa7yCdaNC3I4E/qGhK5wzB4qsOnpJ5qHebxHaqoq/5VMP6CQu8lIhFXHn1JKtS9cMfH/s86NphJtsPgv69m3CdEFWxjx31KJ28tlvjibdDPPJTDtCp+XRbDBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=F1L0x7Rr; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=pzPuoZ5R; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=F1L0x7Rr; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=pzPuoZ5R; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AAACA21D2A;
	Fri, 31 May 2024 20:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1717186351; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OIMdQxVWcgHgoT8x+qFv2MPalSLenD4lbNogIdyldgc=;
	b=F1L0x7RrtEVSY1XEfg4x+8M3k1eC2YQ4bswqGLXBJo6igI+iYmhCfoQfQNudYV6gLLSzQF
	k+ko4XzaH3DhHcCEyNGmtrZB4gf+wxyLjrcwUilfEV+y+ZfcnTJnBAjl9KLhKV2APcVnOQ
	gShTYzxWr74DYHKZD0yf3Qc2eUc06Wc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1717186351;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OIMdQxVWcgHgoT8x+qFv2MPalSLenD4lbNogIdyldgc=;
	b=pzPuoZ5RjnG5P/fUErIvchIVIsypURQpHuBNR2a6p5Id+xSv5ZkphPLS8QI2MBqRk4PvfR
	VbFZVcjg9BP50uCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1717186351; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OIMdQxVWcgHgoT8x+qFv2MPalSLenD4lbNogIdyldgc=;
	b=F1L0x7RrtEVSY1XEfg4x+8M3k1eC2YQ4bswqGLXBJo6igI+iYmhCfoQfQNudYV6gLLSzQF
	k+ko4XzaH3DhHcCEyNGmtrZB4gf+wxyLjrcwUilfEV+y+ZfcnTJnBAjl9KLhKV2APcVnOQ
	gShTYzxWr74DYHKZD0yf3Qc2eUc06Wc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1717186351;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OIMdQxVWcgHgoT8x+qFv2MPalSLenD4lbNogIdyldgc=;
	b=pzPuoZ5RjnG5P/fUErIvchIVIsypURQpHuBNR2a6p5Id+xSv5ZkphPLS8QI2MBqRk4PvfR
	VbFZVcjg9BP50uCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 989E3132C2;
	Fri, 31 May 2024 20:12:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id V9cAJS8vWmZ6WgAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 31 May 2024 20:12:31 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 30D2EA088F; Fri, 31 May 2024 22:12:27 +0200 (CEST)
Date: Fri, 31 May 2024 22:12:27 +0200
From: Jan Kara <jack@suse.cz>
To: Thorsten Blum <thorsten.blum@toblux.com>
Cc: Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.com>,
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH] jbd2: Use str_plural() to fix Coccinelle warning
Message-ID: <20240531201227.h6gc4cu3h6ltg6kl@quack3>
References: <20240531104159.564605-2-thorsten.blum@toblux.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240531104159.564605-2-thorsten.blum@toblux.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.988];
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
	RCPT_COUNT_FIVE(0.00)[5];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email]
X-Spam-Score: -3.80
X-Spam-Flag: NO

On Fri 31-05-24 12:42:00, Thorsten Blum wrote:
> Use str_plural() to fix the following Coccinelle/coccicheck warning
> reported by string_choices.cocci:
> 
> 	opportunity for str_plural(dropped)
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/jbd2/recovery.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/jbd2/recovery.c b/fs/jbd2/recovery.c
> index 1f7664984d6e..af930c3d0d97 100644
> --- a/fs/jbd2/recovery.c
> +++ b/fs/jbd2/recovery.c
> @@ -19,6 +19,7 @@
>  #include <linux/errno.h>
>  #include <linux/crc32.h>
>  #include <linux/blkdev.h>
> +#include <linux/string_choices.h>
>  #endif
>  
>  /*
> @@ -374,7 +375,7 @@ int jbd2_journal_skip_recovery(journal_t *journal)
>  			be32_to_cpu(journal->j_superblock->s_sequence);
>  		jbd2_debug(1,
>  			  "JBD2: ignoring %d transaction%s from the journal.\n",
> -			  dropped, (dropped == 1) ? "" : "s");
> +			  dropped, str_plural(dropped));
>  #endif
>  		journal->j_transaction_sequence = ++info.end_transaction;
>  		journal->j_head = info.head_block;
> -- 
> 2.45.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

