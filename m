Return-Path: <linux-ext4+bounces-11836-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D4AFDC542E2
	for <lists+linux-ext4@lfdr.de>; Wed, 12 Nov 2025 20:39:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BA0274F3305
	for <lists+linux-ext4@lfdr.de>; Wed, 12 Nov 2025 19:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0299234D931;
	Wed, 12 Nov 2025 19:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VhM3EOws";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="f+fg8GWg";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="luoCamOd";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="8vVy2E1i"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7281C695
	for <linux-ext4@vger.kernel.org>; Wed, 12 Nov 2025 19:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762975762; cv=none; b=PTmsRwxWbPWDJtsQ9S6slq0veBwRhCry4xnH7kg91VZSNli/c+GG/dc78KTvEUpPkKEE2bWCuA2SnlZ8ghMbafA0lvcqgV24mXl/Ta7SuhN+8dXUmUN9jIVXBy/co76QxQchNK2pi9SI7is0xEUWXlNYHbU6hg+YeGyOB14W6kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762975762; c=relaxed/simple;
	bh=FD7eUpod2UNtT0QKbAG2A1LcpQ+PqnkPwoOm9PKTAL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JOltroF4jcOihVzf1oDws+q+THmk571LmMQu8hv5L+0RP8CJzLTD5mKQsxQvgkfqW+EpbWm9d5pMm47jQKmYKSHMuFPTglFO40U5XjIlIj4+gAvFpkK7VL98RS7WZNQCd3JnpSmVs1viZzEbMBCmY4jTe6XAbfALLFCrOjSEJ80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=VhM3EOws; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=f+fg8GWg; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=luoCamOd; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=8vVy2E1i; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A7A3A1F798;
	Wed, 12 Nov 2025 19:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762975759; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BU5pkr1oCLNwoXlaGDpJq+j/j/Vf+8W3OKczzQ5Iz8c=;
	b=VhM3EOwsUV1oEi6/J8VtZkVrxFgMwFAwM5eZnjaM+/hsNwlkP021onizIgFE/KDonYwgUr
	T/MMbb4ffMDtWRkmLfgQG6GLn4oUO44bqVnlykHDgP32dSSCk9lJhGxwZUHaA8qp9LJMfK
	xVxu1unhgA9rgZzK2RKT1e5TEZW3eo0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762975759;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BU5pkr1oCLNwoXlaGDpJq+j/j/Vf+8W3OKczzQ5Iz8c=;
	b=f+fg8GWgGwdftEgJ9gld4BXp4cH5kY5GNPFF7B5+6edCiMI7ViP7k/beF+lhv2dD11DTWV
	8aE5v5BT+tEqIOCg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=luoCamOd;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=8vVy2E1i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762975758; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BU5pkr1oCLNwoXlaGDpJq+j/j/Vf+8W3OKczzQ5Iz8c=;
	b=luoCamOdSrS9JYnA+eTHNq/ECaqsMxjQeRWzZwV75WV27WRS1xVsFiEEHj68nMGet9k/ok
	8cYxU3Q5Ay1IDRatTkjvsERX4GK/G8s5lKTsAf5hFMOT6P2GOED/0A2GIig/QdbqlLAJV3
	l6tAAwyViuhE2mqB7Lo0pu/ik6XLd7s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762975758;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BU5pkr1oCLNwoXlaGDpJq+j/j/Vf+8W3OKczzQ5Iz8c=;
	b=8vVy2E1iLSgjfVviuH6hvD8e7zISljyEqLYi/xDHQ+ldXmIFlZjCFgFkvJ2Ueby4jtr1Lb
	tdMFhUVgOB6cOpBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 96D963EA61;
	Wed, 12 Nov 2025 19:29:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uCx7JA7gFGm6WwAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 12 Nov 2025 19:29:18 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id F1DEBA06F7; Wed, 12 Nov 2025 20:29:17 +0100 (CET)
Date: Wed, 12 Nov 2025 20:29:17 +0100
From: Jan Kara <jack@suse.cz>
To: Baolin Liu <liubaolin12138@163.com>
Cc: tytso@mit.edu, jack@suse.com, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Baolin Liu <liubaolin@kylinos.cn>
Subject: Re: [PATCH v1] jbd2: use J_ASSERT instead of BUG_ON for checkpoint
 mutex
Message-ID: <xjdoodv3rxgz74sfqoosfr6jt2td5zdxz55t6cuqknua5347r6@hfkq6e56jsmx>
References: <20251112102914.82278-1-liubaolin12138@163.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251112102914.82278-1-liubaolin12138@163.com>
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: A7A3A1F798
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
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[163.com];
	MISSING_XM_UA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[163.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Score: -4.01

Hello!

On Wed 12-11-25 18:29:14, Baolin Liu wrote:
> From: Baolin Liu <liubaolin@kylinos.cn>
> 
> Replace BUG_ON with J_ASSERT to write the assertion in a positive form.
> 
> No functional change.
> 
> Signed-off-by: Baolin Liu <liubaolin@kylinos.cn>

Thanks for the patch I don't think this is really useful. It is IMO just
a pointless churn... If something, we could get rid of J_ASSERT,
J_ASSERT_JH and J_ASSERT_BH macros which are mostly pointless obfuscation
but even that will cause newer patches to not apply to later stable kernels
and thus I don't think it's really worth it.

								Honza

> ---
>  fs/jbd2/journal.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> index d480b94117cd..c858ade1f7f3 100644
> --- a/fs/jbd2/journal.c
> +++ b/fs/jbd2/journal.c
> @@ -1058,7 +1058,7 @@ int __jbd2_update_log_tail(journal_t *journal, tid_t tid, unsigned long block)
>  	unsigned long freed;
>  	int ret;
>  
> -	BUG_ON(!mutex_is_locked(&journal->j_checkpoint_mutex));
> +	J_ASSERT(mutex_is_locked(&journal->j_checkpoint_mutex));
>  
>  	/*
>  	 * We cannot afford for write to remain in drive's caches since as
> @@ -1863,7 +1863,7 @@ int jbd2_journal_update_sb_log_tail(journal_t *journal, tid_t tail_tid,
>  		return -EIO;
>  	}
>  
> -	BUG_ON(!mutex_is_locked(&journal->j_checkpoint_mutex));
> +	J_ASSERT(mutex_is_locked(&journal->j_checkpoint_mutex));
>  	jbd2_debug(1, "JBD2: updating superblock (start %lu, seq %u)\n",
>  		  tail_block, tail_tid);
>  
> @@ -1897,7 +1897,7 @@ static void jbd2_mark_journal_empty(journal_t *journal, blk_opf_t write_flags)
>  	journal_superblock_t *sb = journal->j_superblock;
>  	bool had_fast_commit = false;
>  
> -	BUG_ON(!mutex_is_locked(&journal->j_checkpoint_mutex));
> +	J_ASSERT(mutex_is_locked(&journal->j_checkpoint_mutex));
>  	lock_buffer(journal->j_sb_buffer);
>  	if (sb->s_start == 0) {		/* Is it already empty? */
>  		unlock_buffer(journal->j_sb_buffer);
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

