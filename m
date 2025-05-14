Return-Path: <linux-ext4+bounces-7887-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57A9AAB709B
	for <lists+linux-ext4@lfdr.de>; Wed, 14 May 2025 18:00:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 407181893AC3
	for <lists+linux-ext4@lfdr.de>; Wed, 14 May 2025 15:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8558220F25;
	Wed, 14 May 2025 15:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MK7wLptE";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="tw8YG1t8";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PrxcIFC9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="PNLdDYp+"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C788C270EDD
	for <linux-ext4@vger.kernel.org>; Wed, 14 May 2025 15:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747238245; cv=none; b=A+kkQLwaX+JaY3HaNIhrdNaTiQ67+3uD/q06iD/DqlGYee8keZk6W7YkU98YCR6vOGAVwHySiuqJrwGh6wAhOIH0og9EYMCto/2eHrasn9r3GojaO6OBozwYaoo3/T6yEp34s06CofOGiHhd2NPhnC5LC89K56sl7Iz9QEkbl64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747238245; c=relaxed/simple;
	bh=052pumwJl93KDknodrpqNZt/3prp83O92+ghmdrVrc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qrzujhDkBP5esc2305a9DRy3w4VXjqUCs/bStncwxU4egT8WBL5FCmZF2f6G1tsOJVVZc/TYkhPYZqdaMVUmg6IQS9ssRRiiFZmimyACBu3mqVM3TnKbcLX/fxvXpdHT9S3P/W93VNWiJTaOoz5YN+CF3Sn9/pAYWr9MZXkvIRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=MK7wLptE; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=tw8YG1t8; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PrxcIFC9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=PNLdDYp+; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B0AA421243;
	Wed, 14 May 2025 15:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747238242; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZQ/S4HV8U5n0J1FpazsbH8kk/GBZuPkWvT2S6ox5eqc=;
	b=MK7wLptEpLkn4oa8S4ooOe14BHfMIGkdZx5FCzE8qVIFIUmVPfB9kZPmiUZFt4UWdqJ3RF
	fRKT59VTUMIPUGYsqXMi07JUF+YgLh8oSZBTtY5RyAOtr8V9LRsyD4UfVBvAXMJ4Xc5DsY
	9Bi4b+nB/zBojPMflHCjgQsB0z5KdBk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747238242;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZQ/S4HV8U5n0J1FpazsbH8kk/GBZuPkWvT2S6ox5eqc=;
	b=tw8YG1t8N6kFTU5y2/EOdQDu9XGkTnsLKOEJerJ9xt9OsrFOLRfdHRgVFtadzJWChdTACj
	LxbXd1ACIE+nfkBA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=PrxcIFC9;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=PNLdDYp+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747238240; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZQ/S4HV8U5n0J1FpazsbH8kk/GBZuPkWvT2S6ox5eqc=;
	b=PrxcIFC9pQxA7y9CusA71kc537VIWdnPJ7Vgd6s/hvze+AFYILlnhNqtrKcR4M1mdQQ4zF
	ppMrkYP2EyrKq9/RMaNixgyvOIHQINp7tqYvWc7aNcZBzXxL72DE1g0JIgyMIjgcboamFe
	Gr8FChVxS7y2rz+ClndGkDAoIWXM6Hk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747238240;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZQ/S4HV8U5n0J1FpazsbH8kk/GBZuPkWvT2S6ox5eqc=;
	b=PNLdDYp+moUsgV7OB7pnXZrbtrXp4n/t93HYaFok41G19q7sOuW6Vtq1OlCeHa1I41fjCB
	QRXXdavbzn6Th9CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 931E313306;
	Wed, 14 May 2025 15:57:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id P2LgI2C9JGjVMgAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 14 May 2025 15:57:20 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id C340FA0A02; Wed, 14 May 2025 17:57:15 +0200 (CEST)
Date: Wed, 14 May 2025 17:57:15 +0200
From: Jan Kara <jack@suse.cz>
To: Jeongjun Park <aha310510@gmail.com>
Cc: tytso@mit.edu, jack@suse.cz, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzbot+de24c3fe3c4091051710@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] jbd2: fix data-race and null-ptr-deref in
 jbd2_journal_dirty_metadata()
Message-ID: <74flzxcuaj7sozun7bxbaxcv5wn7hnxg6kfmzzveb24ibufv2d@jycpstzyqfa2>
References: <20250514130855.99010-1-aha310510@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250514130855.99010-1-aha310510@gmail.com>
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: B0AA421243
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[gmail.com];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_RCPT(0.00)[de24c3fe3c4091051710];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,appspotmail.com:email,syzkaller.appspot.com:url,suse.com:email,suse.cz:email,suse.cz:dkim]
X-Spam-Score: -2.51

On Wed 14-05-25 22:08:55, Jeongjun Park wrote:
> Since handle->h_transaction may be a NULL pointer, so we should change it
> to call is_handle_aborted(handle) first before dereferencing it.
> 
> And the following data-race was reported in my fuzzer:
> 
> ==================================================================
> BUG: KCSAN: data-race in jbd2_journal_dirty_metadata / jbd2_journal_dirty_metadata
> 
> write to 0xffff888011024104 of 4 bytes by task 10881 on cpu 1:
>  jbd2_journal_dirty_metadata+0x2a5/0x770 fs/jbd2/transaction.c:1556
>  __ext4_handle_dirty_metadata+0xe7/0x4b0 fs/ext4/ext4_jbd2.c:358
>  ext4_do_update_inode fs/ext4/inode.c:5220 [inline]
>  ext4_mark_iloc_dirty+0x32c/0xd50 fs/ext4/inode.c:5869
>  __ext4_mark_inode_dirty+0xe1/0x450 fs/ext4/inode.c:6074
>  ext4_dirty_inode+0x98/0xc0 fs/ext4/inode.c:6103
> ....
> 
> read to 0xffff888011024104 of 4 bytes by task 10880 on cpu 0:
>  jbd2_journal_dirty_metadata+0xf2/0x770 fs/jbd2/transaction.c:1512
>  __ext4_handle_dirty_metadata+0xe7/0x4b0 fs/ext4/ext4_jbd2.c:358
>  ext4_do_update_inode fs/ext4/inode.c:5220 [inline]
>  ext4_mark_iloc_dirty+0x32c/0xd50 fs/ext4/inode.c:5869
>  __ext4_mark_inode_dirty+0xe1/0x450 fs/ext4/inode.c:6074
>  ext4_dirty_inode+0x98/0xc0 fs/ext4/inode.c:6103
> ....
> 
> value changed: 0x00000000 -> 0x00000001
> ==================================================================
> 
> This issue is caused by missing data-race annotation for jh->b_modified.
> Therefore, the missing annotation needs to be added.
> 
> Reported-by: syzbot+de24c3fe3c4091051710@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=de24c3fe3c4091051710
> Fixes: 6e06ae88edae ("jbd2: speedup jbd2_journal_dirty_metadata()")
> Signed-off-by: Jeongjun Park <aha310510@gmail.com>

Looks good now! Thanks! Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> v2: Changed to annotate jh->b_modified to avoid performance overhead
> - Link to v1: https://lore.kernel.org/all/20250513170441.54658-1-aha310510@gmail.com/
> ---
>  fs/jbd2/transaction.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
> index cbc4785462f5..c7867139af69 100644
> --- a/fs/jbd2/transaction.c
> +++ b/fs/jbd2/transaction.c
> @@ -1509,7 +1509,7 @@ int jbd2_journal_dirty_metadata(handle_t *handle, struct buffer_head *bh)
>  				jh->b_next_transaction == transaction);
>  		spin_unlock(&jh->b_state_lock);
>  	}
> -	if (jh->b_modified == 1) {
> +	if (data_race(jh->b_modified == 1)) {
>  		/* If it's in our transaction it must be in BJ_Metadata list. */
>  		if (data_race(jh->b_transaction == transaction &&
>  		    jh->b_jlist != BJ_Metadata)) {
> @@ -1528,7 +1528,6 @@ int jbd2_journal_dirty_metadata(handle_t *handle, struct buffer_head *bh)
>  		goto out;
>  	}
>  
> -	journal = transaction->t_journal;
>  	spin_lock(&jh->b_state_lock);
>  
>  	if (is_handle_aborted(handle)) {
> @@ -1543,6 +1542,8 @@ int jbd2_journal_dirty_metadata(handle_t *handle, struct buffer_head *bh)
>  		goto out_unlock_bh;
>  	}
>  
> +	journal = transaction->t_journal;
> +
>  	if (jh->b_modified == 0) {
>  		/*
>  		 * This buffer's got modified and becoming part
> --
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

