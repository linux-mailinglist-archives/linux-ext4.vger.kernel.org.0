Return-Path: <linux-ext4+bounces-1940-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D02D089F1AA
	for <lists+linux-ext4@lfdr.de>; Wed, 10 Apr 2024 14:05:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8627F2823C8
	for <lists+linux-ext4@lfdr.de>; Wed, 10 Apr 2024 12:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9E0115B541;
	Wed, 10 Apr 2024 12:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gi+aUPFr";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="L8GpkAD0";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gi+aUPFr";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="L8GpkAD0"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC6015B130;
	Wed, 10 Apr 2024 12:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712750732; cv=none; b=k2J6YTAkEhjokAOU/zC/KRDaNljyQVlOir3t8WtEQNOmvdKMkvVYZnvXSD1MIeOOjwY2AojGtlAWk8QEESswhfHaMsQAKWYXwiHIKqyFC6hhngf0yY6eZ6g0H2ur4Uw65dmQSmqMhRp2NR5OQwh5SD5hy+WlSisdidNHnx70rcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712750732; c=relaxed/simple;
	bh=BUBDmIoEG33TRM8dUlpufq0UNJhZ+19dYpk7y2R9Q+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M4MXH+b3lxMDz0ZQWC8IzX091xtibdieW3xg0y/8jQE/WxD9wV6XYyy1lzbyhHYhUKsUZGVrcynJ8R2t6fxreO3MLRQDLOrVm8rM+76QkS+wd8/89HP+8vz/Y9LVi75VHG0bBZeGkrd2LznWHEN6CcJAbb+TObjYxOVCFKK5nm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gi+aUPFr; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=L8GpkAD0; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gi+aUPFr; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=L8GpkAD0; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7E659350AA;
	Wed, 10 Apr 2024 12:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1712750727; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nilFxSt4AAqE2lRCUBz3PtSSaWDM5UjMiq7TLWAkpuI=;
	b=gi+aUPFrLBBLpuiLHhY1c5QoQjWfa/8gl/uJ2Lxub8UX39xPS3ndjRn2f9OUtKngbeGtin
	TrqpWkfgX1ZHylP1if3IbuL8igqmWPoJWyWIxqqVeydY0LtwjTa5Kt53VX2GCpuBmBmlE4
	NBKeJf7R0CSddWwtd83VNyH9nBMB0qk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1712750727;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nilFxSt4AAqE2lRCUBz3PtSSaWDM5UjMiq7TLWAkpuI=;
	b=L8GpkAD078iLHJ85nZsCTBf/Tb3vwgOEoGLhPtiv55bSzc0rXH+pn8HGUvkSF9CMdah69g
	giFUQNhL41C9Q8Dw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=gi+aUPFr;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=L8GpkAD0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1712750727; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nilFxSt4AAqE2lRCUBz3PtSSaWDM5UjMiq7TLWAkpuI=;
	b=gi+aUPFrLBBLpuiLHhY1c5QoQjWfa/8gl/uJ2Lxub8UX39xPS3ndjRn2f9OUtKngbeGtin
	TrqpWkfgX1ZHylP1if3IbuL8igqmWPoJWyWIxqqVeydY0LtwjTa5Kt53VX2GCpuBmBmlE4
	NBKeJf7R0CSddWwtd83VNyH9nBMB0qk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1712750727;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nilFxSt4AAqE2lRCUBz3PtSSaWDM5UjMiq7TLWAkpuI=;
	b=L8GpkAD078iLHJ85nZsCTBf/Tb3vwgOEoGLhPtiv55bSzc0rXH+pn8HGUvkSF9CMdah69g
	giFUQNhL41C9Q8Dw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 7453B13A92;
	Wed, 10 Apr 2024 12:05:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id gmRjHIeAFmZcBAAAn2gu4w
	(envelope-from <jack@suse.cz>); Wed, 10 Apr 2024 12:05:27 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 222A1A06D8; Wed, 10 Apr 2024 14:05:27 +0200 (CEST)
Date: Wed, 10 Apr 2024 14:05:27 +0200
From: Jan Kara <jack@suse.cz>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.com>,
	linux-ext4@vger.kernel.org, kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] jbd2: remove redundant assignement to variable err
Message-ID: <20240410120527.i5mfitfnik2jywgw@quack3>
References: <20240410112803.232993-1-colin.i.king@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240410112803.232993-1-colin.i.king@gmail.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-0.11 / 50.00];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	BAYES_HAM(-0.60)[81.72%];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim,suse.cz:email,imap2.dmz-prg2.suse.org:helo,imap2.dmz-prg2.suse.org:rdns]
X-Spam-Flag: NO
X-Spam-Score: -0.11
X-Spamd-Bar: /
X-Rspamd-Queue-Id: 7E659350AA
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action

On Wed 10-04-24 12:28:03, Colin Ian King wrote:
> The variable err is being assigned a value that is never read, it
> is being re-assigned inside the following while loop and also
> after the while loop. The assignment is redundant and can be
> removed.
> 
> Cleans up clang scan build warning:
> fs/jbd2/commit.c:574:2: warning: Value stored to 'err' is never
> read [deadcode.DeadStores]
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

OK, this assignment indeed looks redundant and is not even making code
easier to reason about. So feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/jbd2/commit.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
> index 5e122586e06e..78a9d08ae9f8 100644
> --- a/fs/jbd2/commit.c
> +++ b/fs/jbd2/commit.c
> @@ -571,7 +571,6 @@ void jbd2_journal_commit_transaction(journal_t *journal)
>  	J_ASSERT(commit_transaction->t_nr_buffers <=
>  		 atomic_read(&commit_transaction->t_outstanding_credits));
>  
> -	err = 0;
>  	bufs = 0;
>  	descriptor = NULL;
>  	while (commit_transaction->t_buffers) {
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

