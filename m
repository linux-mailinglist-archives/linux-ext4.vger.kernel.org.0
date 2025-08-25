Return-Path: <linux-ext4+bounces-9614-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8046AB3422A
	for <lists+linux-ext4@lfdr.de>; Mon, 25 Aug 2025 15:54:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC4CC2A0A97
	for <lists+linux-ext4@lfdr.de>; Mon, 25 Aug 2025 13:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E7A41DE2AD;
	Mon, 25 Aug 2025 13:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="27of3jdQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="iX7X+Wla";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="27of3jdQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="iX7X+Wla"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E517221FC8
	for <linux-ext4@vger.kernel.org>; Mon, 25 Aug 2025 13:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756129629; cv=none; b=GPTYMbrxbrAMWCP7CkS+K0L/yP5lv0869g6822IQxMLOtmNgx3i02ISgAX8ydmdpg2YuSgGoXRmTQuzwur4ApPm7EYo3D8+3Hd9gY0z1Bf6tQA4pB3O6CjFLCGY1wA/IX79yPszr5WFqPRISHcyL+LpS7iLRsWoXEiXh/GYj3YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756129629; c=relaxed/simple;
	bh=mfhqR09WgzXGq2kiOMHV+Kv7xE2XBl4M33GN5Kl3pSg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l+BHamYnoN+e+ixvookKeDnpSXaYTV4KechRvdsCruHY6WhiuNqmubtlamp7cGZH5lXxf5wnUnEsqYNyXYm6Afon+v3iq9fS5neVyCgUQpjvvEfNUvijY0SWODEWg2WgDMGLvpUidU4reKKG5dlVWw/tfumtEa0W+YaFL21LWbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=27of3jdQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=iX7X+Wla; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=27of3jdQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=iX7X+Wla; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 06E212123F;
	Mon, 25 Aug 2025 13:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756129626; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aIjrXcm+c/t0Y6bS63pX6cxkABL2Y/EIKwiCgmjfNa4=;
	b=27of3jdQPvFMvixGNpMcHlUx+aj0JjoDrkiIC2V0M5T3LTJyHuBwlYLCiXOVRgRD5IpMc+
	8ZOfFH2mtO9kvkXqfLU3Y7ydoE6eTsKF3UJXPEkf7VBm1QTmNLJPD8yYHxDWXIVKhBY267
	jhRVoZKSRkEw46ImYSbirlJwYNX9Pj4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756129626;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aIjrXcm+c/t0Y6bS63pX6cxkABL2Y/EIKwiCgmjfNa4=;
	b=iX7X+Wla17BQ3xZz85TCs5YTpaRlFgGjotYsxHzHyN27wws2G8jxVgPsxPuJnrJ8/C3h1q
	TUwafHxfH8FWsOBA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=27of3jdQ;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=iX7X+Wla
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756129626; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aIjrXcm+c/t0Y6bS63pX6cxkABL2Y/EIKwiCgmjfNa4=;
	b=27of3jdQPvFMvixGNpMcHlUx+aj0JjoDrkiIC2V0M5T3LTJyHuBwlYLCiXOVRgRD5IpMc+
	8ZOfFH2mtO9kvkXqfLU3Y7ydoE6eTsKF3UJXPEkf7VBm1QTmNLJPD8yYHxDWXIVKhBY267
	jhRVoZKSRkEw46ImYSbirlJwYNX9Pj4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756129626;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aIjrXcm+c/t0Y6bS63pX6cxkABL2Y/EIKwiCgmjfNa4=;
	b=iX7X+Wla17BQ3xZz85TCs5YTpaRlFgGjotYsxHzHyN27wws2G8jxVgPsxPuJnrJ8/C3h1q
	TUwafHxfH8FWsOBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F043D1368F;
	Mon, 25 Aug 2025 13:47:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id lgOhOllprGhYKgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 25 Aug 2025 13:47:05 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 12A5AA0A19; Mon, 25 Aug 2025 15:47:05 +0200 (CEST)
Date: Mon, 25 Aug 2025 15:47:05 +0200
From: Jan Kara <jack@suse.cz>
To: Julian Sun <sunjunchao@bytedance.com>
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, jack@suse.com, 
	yi.zhang@huawei.com
Subject: Re: [PATCH] jbd2: Increase IO priority of checkpoint.
Message-ID: <na76bcwkb6567qdr3h2sikczfrhadfvb4dy6s66l5366sujsvz@2hxt2n6kcrnu>
References: <20250825125339.1368799-1-sunjunchao@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250825125339.1368799-1-sunjunchao@bytedance.com>
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 06E212123F
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.cz:email];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Score: -4.01

On Mon 25-08-25 20:53:39, Julian Sun wrote:
> In commit 6a3afb6ac6df ("jbd2: increase the journal IO's priority"),
> the priority of IOs initiated by jbd2 has been raised, exempting them
> from WBT throttling.
> Checkpoint is also a crucial operation of jbd2. While no serious issues
> have been observed so far, it should still be reasonable to exempt
> checkpoint from WBT throttling.
> 
> Signed-off-by: Julian Sun <sunjunchao@bytedance.com>

Makes sense. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/jbd2/checkpoint.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/jbd2/checkpoint.c b/fs/jbd2/checkpoint.c
> index 38861ca04899..2d0719bf6d87 100644
> --- a/fs/jbd2/checkpoint.c
> +++ b/fs/jbd2/checkpoint.c
> @@ -131,7 +131,7 @@ __flush_batch(journal_t *journal, int *batch_count)
>  
>  	blk_start_plug(&plug);
>  	for (i = 0; i < *batch_count; i++)
> -		write_dirty_buffer(journal->j_chkpt_bhs[i], REQ_SYNC);
> +		write_dirty_buffer(journal->j_chkpt_bhs[i], JBD2_JOURNAL_REQ_FLAGS);
>  	blk_finish_plug(&plug);
>  
>  	for (i = 0; i < *batch_count; i++) {
> -- 
> 2.20.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

