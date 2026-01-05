Return-Path: <linux-ext4+bounces-12581-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F20EDCF4BD4
	for <lists+linux-ext4@lfdr.de>; Mon, 05 Jan 2026 17:38:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1A5023093507
	for <lists+linux-ext4@lfdr.de>; Mon,  5 Jan 2026 16:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2D3030146C;
	Mon,  5 Jan 2026 16:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GdC6Q99U";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="J7LB/5HO";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GdC6Q99U";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="J7LB/5HO"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867F834846A
	for <linux-ext4@vger.kernel.org>; Mon,  5 Jan 2026 16:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767629859; cv=none; b=W7gsWGkmmkanXRNr1jBUulN7LuucO4Y88HHLlWcmMILV2dHMFu1z8phrtGvUQHAC8zzgaFP2t/A24FSauVzov8t+CGnSiqLTEI0pFJJFiZBk+l5j7YAxMaRnIXgiSRoPEWDu9IcquephBITd+7vPfih37LM1FVkAjPav4lgmv4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767629859; c=relaxed/simple;
	bh=YVW1LDxkjZLxqXA9x8hJLjFNKUDUxMy4dxo1fikP2iA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JFzfCFTgBT3n/74RSEglv1ijesSYLpgAq1dfKrEMvbWxXXJrMVyzaUZBGwvUh2MNgD/73rRk3c46n0TBVvpUNdtTgjdfqj9FWjjLZqy9HD/dSa4bDFZn8APAIlGFro2/RBCoc7MaaOJ6FoLL1WF4TAKTS0pO/w04QG7RzqXOip4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=GdC6Q99U; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=J7LB/5HO; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=GdC6Q99U; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=J7LB/5HO; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A780C5BD96;
	Mon,  5 Jan 2026 16:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1767629855; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TjNWkh+e+yz/iZ3klUB2Jqb9OfP0tqwOhPQ27CRXLKQ=;
	b=GdC6Q99UL4TMBA8P0OJehYt6BpLQA/pzAMRK6SXN/xZ+M3NfD09G2wnIrXjMrRLe7M+3tR
	21rJ7SgUR4dDEAqA4v0MilqfGEs1xW7zE6rnRNzWNGf3y7d41JlRW4zXN1p2oo8vEh5mnD
	ozxnKs1iOEH3hc5298uu+ko+il8kNqQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1767629855;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TjNWkh+e+yz/iZ3klUB2Jqb9OfP0tqwOhPQ27CRXLKQ=;
	b=J7LB/5HO70Vtn5q+1BVEI7pL8fkNlQ40opmozqvrsRxiN7eY9zvcWOHqXbfnuIQz6ZQO8u
	P9HNQo/bZIr6JVCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1767629855; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TjNWkh+e+yz/iZ3klUB2Jqb9OfP0tqwOhPQ27CRXLKQ=;
	b=GdC6Q99UL4TMBA8P0OJehYt6BpLQA/pzAMRK6SXN/xZ+M3NfD09G2wnIrXjMrRLe7M+3tR
	21rJ7SgUR4dDEAqA4v0MilqfGEs1xW7zE6rnRNzWNGf3y7d41JlRW4zXN1p2oo8vEh5mnD
	ozxnKs1iOEH3hc5298uu+ko+il8kNqQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1767629855;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TjNWkh+e+yz/iZ3klUB2Jqb9OfP0tqwOhPQ27CRXLKQ=;
	b=J7LB/5HO70Vtn5q+1BVEI7pL8fkNlQ40opmozqvrsRxiN7eY9zvcWOHqXbfnuIQz6ZQO8u
	P9HNQo/bZIr6JVCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9D2D13EA63;
	Mon,  5 Jan 2026 16:17:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Qh9aJh/kW2nTHQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 05 Jan 2026 16:17:35 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 41A65A0837; Mon,  5 Jan 2026 17:17:31 +0100 (CET)
Date: Mon, 5 Jan 2026 17:17:31 +0100
From: Jan Kara <jack@suse.cz>
To: Li Chen <me@linux.beauty>
Cc: Theodore Ts'o <tytso@mit.edu>, 
	Andreas Dilger <adilger.kernel@dilger.ca>, Jan Kara <jack@suse.cz>, 
	Harshad Shirwadkar <harshadshirwadkar@gmail.com>, linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: fast commit: avoid fs_reclaim inversion in
 perform_commit
Message-ID: <jdssgnr44c6scnzhpbl7gwgcpo2f25n3cxaaw6fo2uzh3bdwda@ograleyyoyot>
References: <20251223131342.287864-1-me@linux.beauty>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251223131342.287864-1-me@linux.beauty>
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	URIBL_BLOCKED(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,linux.beauty:email];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[mit.edu,dilger.ca,suse.cz,gmail.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]

On Tue 23-12-25 21:13:42, Li Chen wrote:
> lockdep reports a possible deadlock due to lock order inversion:
> 
>      CPU0                    CPU1
>      ----                    ----
> lock(fs_reclaim);
>                              lock(&sbi->s_fc_lock);
>                              lock(fs_reclaim);
> lock(&sbi->s_fc_lock);
> 
> ext4_fc_perform_commit() holds s_fc_lock while writing the fast commit
> log. Allocations here can enter reclaim and take fs_reclaim, inverting
> with ext4_fc_del() which runs under fs_reclaim during inode eviction.
> Wrap Step 6 in memalloc_nofs_save()/restore() so reclaim is skipped
> while s_fc_lock is held.
> 
> Fixes: 6593714d67ba ("ext4: hold s_fc_lock while during fast commit")
> Signed-off-by: Li Chen <me@linux.beauty>

Thanks for the analysis and the patch! Your solution is in principle
correct but it's a bit fragile because there can be other instances (or we
can grow them in the future) where sbi->s_fc_lock is held when doing
allocation. The situation is that sbi->s_fc_lock can be acquired from inode
eviction path (ext4_clear_inode()) and thus this lock is inherently reclaim
unsafe. What we do in such cases is that we create helper functions for
acquiring / releasing the lock while also setting proper context and using
these helpers - like in commit 00d873c17e29 ("ext4: avoid deadlock in fs
reclaim with page writeback"). Can you perhaps modify your patch to follow
that behavior as well?

								Honza

> diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
> index 3bcdd4619de1..b0c458082997 100644
> --- a/fs/ext4/fast_commit.c
> +++ b/fs/ext4/fast_commit.c
> @@ -1045,6 +1045,7 @@ static int ext4_fc_perform_commit(journal_t *journal)
>  	struct ext4_fc_head head;
>  	struct inode *inode;
>  	struct blk_plug plug;
> +	unsigned int nofs;
>  	int ret = 0;
>  	u32 crc = 0;
>  
> @@ -1118,6 +1119,7 @@ static int ext4_fc_perform_commit(journal_t *journal)
>  		blkdev_issue_flush(journal->j_fs_dev);
>  
>  	blk_start_plug(&plug);
> +	nofs = memalloc_nofs_save();
>  	/* Step 6: Write fast commit blocks to disk. */
>  	if (sbi->s_fc_bytes == 0) {
>  		/*
> @@ -1158,6 +1160,7 @@ static int ext4_fc_perform_commit(journal_t *journal)
>  
>  out:
>  	mutex_unlock(&sbi->s_fc_lock);
> +	memalloc_nofs_restore(nofs);
>  	blk_finish_plug(&plug);
>  	return ret;
>  }
> -- 
> 2.52.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

