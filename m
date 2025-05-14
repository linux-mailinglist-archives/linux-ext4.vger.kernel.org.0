Return-Path: <linux-ext4+bounces-7877-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79FEBAB6867
	for <lists+linux-ext4@lfdr.de>; Wed, 14 May 2025 12:07:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02696460760
	for <lists+linux-ext4@lfdr.de>; Wed, 14 May 2025 10:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CB7526FD8E;
	Wed, 14 May 2025 10:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xB6JwS6o";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="XjQ3tlpo";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xB6JwS6o";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="XjQ3tlpo"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D431FC7E7
	for <linux-ext4@vger.kernel.org>; Wed, 14 May 2025 10:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747217268; cv=none; b=lOUuI6XzLwhrZaLyBMaWdGGiJUWFlB8ClDKftL6t3k4hbvFaw243h50SYNu4LkzU2Y+gTAxfHhDbpkbh5xjA3wdgvtI+gGPSGC0PVlE2WpYRvkPeyyiTqlEF+BfKaYvjEK8hiHIUSwhV9R+ThVAM806gYqO9/B1NjTQyzIZyOYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747217268; c=relaxed/simple;
	bh=FEat6LLCEzvwiX2TjuWW+9FR8W2ns0vfPg2MauexgeM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k6MWw0kbCQE/HhL3L1vGsUc7FKAf3bwCSWyKrtJHWr1r97Br1Q4O4QgnScAmLlOeS37ktWT7jXRXoYf0GcYG7C2GY3vaNBu4I9Bls44n/7dOzsRXG8Lr5CVfSlRVJ5TiWqO5T8CvDegty02FS8YAnX617axAGD2QA9muZJM6DVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xB6JwS6o; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=XjQ3tlpo; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xB6JwS6o; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=XjQ3tlpo; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1535E21203;
	Wed, 14 May 2025 10:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747217264; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n456aI6jq0P1TSTlPKrDgnacHuDdChXTe65g3cUCZgU=;
	b=xB6JwS6oLUMLaZZ80Djtm/gTvmQnvy5QGoicXi4Bi0kFWC3lZkLe6mM2nivoP2WQXkPoUm
	3fEWTjImQ/nUg2+Xr8d2UOy/Ca61h4daRcivqi5OEh2Qb0vBNnYT0TxBprydfKmC/TJB7D
	Of7JwdvQATJV2ISpa+Ea8fqGoKmquD0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747217264;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n456aI6jq0P1TSTlPKrDgnacHuDdChXTe65g3cUCZgU=;
	b=XjQ3tlpo/TLsUkK9cDyTkHqw+/D+2HdB6AMBJyDWmEzMiqGcEo/76fqUhvw0mBps+boOe9
	twxS+YFYPwsQZUAQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=xB6JwS6o;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=XjQ3tlpo
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747217264; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n456aI6jq0P1TSTlPKrDgnacHuDdChXTe65g3cUCZgU=;
	b=xB6JwS6oLUMLaZZ80Djtm/gTvmQnvy5QGoicXi4Bi0kFWC3lZkLe6mM2nivoP2WQXkPoUm
	3fEWTjImQ/nUg2+Xr8d2UOy/Ca61h4daRcivqi5OEh2Qb0vBNnYT0TxBprydfKmC/TJB7D
	Of7JwdvQATJV2ISpa+Ea8fqGoKmquD0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747217264;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n456aI6jq0P1TSTlPKrDgnacHuDdChXTe65g3cUCZgU=;
	b=XjQ3tlpo/TLsUkK9cDyTkHqw+/D+2HdB6AMBJyDWmEzMiqGcEo/76fqUhvw0mBps+boOe9
	twxS+YFYPwsQZUAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 09A4913306;
	Wed, 14 May 2025 10:07:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id JHRXAnBrJGi/OAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 14 May 2025 10:07:44 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id B7B3BA0A02; Wed, 14 May 2025 12:07:35 +0200 (CEST)
Date: Wed, 14 May 2025 12:07:35 +0200
From: Jan Kara <jack@suse.cz>
To: Jeongjun Park <aha310510@gmail.com>
Cc: tytso@mit.edu, jack@suse.cz, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzbot+de24c3fe3c4091051710@syzkaller.appspotmail.com
Subject: Re: [PATCH] jbd2: fix data-race and null-ptr-deref in
 jbd2_journal_dirty_metadata()
Message-ID: <ikdnwnux5ks25eqn5nbya6dpb2wrtsb22m57757ewdzd4qo6rx@e46o3ugl5wfa>
References: <20250513170441.54658-1-aha310510@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250513170441.54658-1-aha310510@gmail.com>
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 1535E21203
X-Spam-Flag: NO
X-Spam-Score: -2.51
X-Spam-Level: 
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[de24c3fe3c4091051710];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.com:email]
X-Rspamd-Action: no action

On Wed 14-05-25 02:04:41, Jeongjun Park wrote:
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
> According to this crash report, there is a read/write data-race in
> jh->b_modified.
> 
> This is because the b_state_lock is locked too late.
> 
> For some reason, jbd2_journal_dirty_metadata() has been written in a way
> that it does not lock b_state_lock before checking jh->b_transaction.

Yes and that is deliberate because for some buffers like bitmaps the
contention (and cacheline bouncing) on the b_state_lock can be actually
quite significant. See commit 6e06ae88edae ("jbd2: speedup
jbd2_journal_dirty_metadata()") for a bit more description.

> However, This makes the code that checks jh->b_transaction messy and
> causes a data-race in jh->b_* variables. Since locking b_state_lock
> earlier is not enough to significantly affect performance and most of the
> functions defined in transaction.c lock b_state_lock before
> reading/writing jh->b_*.

Well, the code is written with the expectation that b_transaction, b_jlist,
and b_modified fields can be changing underneath. Since this was
implemented 10 years ago, we didn't really bother with properly annotating
this but the code as is is safe. I agree the data_race() annotation for the
b_modified check was missed when adding data_race() annotations 4 years
ago so that should be fixed.

								Honza

> Thereforce, I think it would be appropriate to modify 
> jbd2_journal_dirty_metadata() to lock b_state_lock earlier as well.
> 
> Reported-by: syzbot+de24c3fe3c4091051710@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=de24c3fe3c4091051710
> Fixes: 6e06ae88edae ("jbd2: speedup jbd2_journal_dirty_metadata()")
> Signed-off-by: Jeongjun Park <aha310510@gmail.com>
> ---
>  fs/jbd2/transaction.c | 49 +++++++++++++++----------------------------
>  1 file changed, 17 insertions(+), 32 deletions(-)
> 
> diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
> index cbc4785462f5..7e6dbf37396f 100644
> --- a/fs/jbd2/transaction.c
> +++ b/fs/jbd2/transaction.c
> @@ -1496,41 +1496,25 @@ int jbd2_journal_dirty_metadata(handle_t *handle, struct buffer_head *bh)
>  	jbd2_debug(5, "journal_head %p\n", jh);
>  	JBUFFER_TRACE(jh, "entry");
>  
> -	/*
> -	 * This and the following assertions are unreliable since we may see jh
> -	 * in inconsistent state unless we grab bh_state lock. But this is
> -	 * crucial to catch bugs so let's do a reliable check until the
> -	 * lockless handling is fully proven.
> -	 */
> -	if (data_race(jh->b_transaction != transaction &&
> -	    jh->b_next_transaction != transaction)) {
> -		spin_lock(&jh->b_state_lock);
> -		J_ASSERT_JH(jh, jh->b_transaction == transaction ||
> -				jh->b_next_transaction == transaction);
> -		spin_unlock(&jh->b_state_lock);
> -	}
> +	spin_lock(&jh->b_state_lock);
> +
> +	J_ASSERT_JH(jh, jh->b_transaction == transaction ||
> +			jh->b_next_transaction == transaction);
> +
>  	if (jh->b_modified == 1) {
>  		/* If it's in our transaction it must be in BJ_Metadata list. */
> -		if (data_race(jh->b_transaction == transaction &&
> -		    jh->b_jlist != BJ_Metadata)) {
> -			spin_lock(&jh->b_state_lock);
> -			if (jh->b_transaction == transaction &&
> -			    jh->b_jlist != BJ_Metadata)
> -				pr_err("JBD2: assertion failure: h_type=%u "
> -				       "h_line_no=%u block_no=%llu jlist=%u\n",
> -				       handle->h_type, handle->h_line_no,
> -				       (unsigned long long) bh->b_blocknr,
> -				       jh->b_jlist);
> -			J_ASSERT_JH(jh, jh->b_transaction != transaction ||
> -					jh->b_jlist == BJ_Metadata);
> -			spin_unlock(&jh->b_state_lock);
> -		}
> -		goto out;
> +		if (jh->b_transaction == transaction &&
> +			jh->b_jlist != BJ_Metadata)
> +			pr_err("JBD2: assertion failure: h_type=%u "
> +			       "h_line_no=%u block_no=%llu jlist=%u\n",
> +			       handle->h_type, handle->h_line_no,
> +			       (unsigned long long) bh->b_blocknr,
> +			       jh->b_jlist);
> +		J_ASSERT_JH(jh, jh->b_transaction != transaction ||
> +				jh->b_jlist == BJ_Metadata);
> +		goto out_unlock_bh;
>  	}
>  
> -	journal = transaction->t_journal;
> -	spin_lock(&jh->b_state_lock);
> -
>  	if (is_handle_aborted(handle)) {
>  		/*
>  		 * Check journal aborting with @jh->b_state_lock locked,
> @@ -1543,6 +1527,8 @@ int jbd2_journal_dirty_metadata(handle_t *handle, struct buffer_head *bh)
>  		goto out_unlock_bh;
>  	}
>  
> +	journal = transaction->t_journal;
> +
>  	if (jh->b_modified == 0) {
>  		/*
>  		 * This buffer's got modified and becoming part
> @@ -1628,7 +1614,6 @@ int jbd2_journal_dirty_metadata(handle_t *handle, struct buffer_head *bh)
>  	spin_unlock(&journal->j_list_lock);
>  out_unlock_bh:
>  	spin_unlock(&jh->b_state_lock);
> -out:
>  	JBUFFER_TRACE(jh, "exit");
>  	return ret;
>  }
> --
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

