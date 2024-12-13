Return-Path: <linux-ext4+bounces-5626-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AAE99F1094
	for <lists+linux-ext4@lfdr.de>; Fri, 13 Dec 2024 16:14:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 699161883318
	for <lists+linux-ext4@lfdr.de>; Fri, 13 Dec 2024 15:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7BA11E102E;
	Fri, 13 Dec 2024 15:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KAA7Tvzg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZS2/YFkN";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KAA7Tvzg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZS2/YFkN"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6F51DFE33
	for <linux-ext4@vger.kernel.org>; Fri, 13 Dec 2024 15:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734102727; cv=none; b=vDJFj9r6hLwiyxAgpWqZyeaXPDQV6foOp1lRmykqyYoUIy2z1Hi8l7KKPmcy87sdMwNLxxcfr4KMgIUJeWP4f6ygFv+o6pOOyOTuchyRCc7OlmTAYQDe4s01JNVhjtTbDMAgCcPXxOHO4DWePL74K0Gm1/n9TUrTBBM4sCQjFps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734102727; c=relaxed/simple;
	bh=75gcsS8ZuSf0ADPVm87vu4uoo/P3mviFJ7Nk+ITu2lA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=abAJESL4utgzcORmBzVFJBJM42/XaZqfKKkKMhoPpv6vU3WYvp/Y9gwd4hWA8qD42Ma8zk0QYWaYmCBFOrMDXq4XLp29X7rUFO3LbU6g9k1CT6YIkgMwJx6MqOrGx3NTe8XZP0RT/v+ei8HkV/6KaEZl2ng2ouW/ldPSXK0++gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KAA7Tvzg; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZS2/YFkN; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KAA7Tvzg; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZS2/YFkN; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2A888211B1;
	Fri, 13 Dec 2024 15:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1734102723; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0CfJ63JhuOY2ovRDqVxTmCyDDkl1SR+jaZ5MKweaD4E=;
	b=KAA7TvzgPCnBi0JAz9kQ5ngElDTNzxO6ffHo2gmmoeiRzFjxE8B62DeoNLXl8M0ZDWETJO
	zgkpkDl2yPqAAG9vG7aimw7WHkjValAThtw7jFaa8DJuUrd+EcJSVcLkRNcXEpoBcr5TX2
	5ZDnLfld5L+zSozqeNjtcDIgj1m3zzA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1734102723;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0CfJ63JhuOY2ovRDqVxTmCyDDkl1SR+jaZ5MKweaD4E=;
	b=ZS2/YFkNMsCwrPmLVhfFGU/reezXliHyLwWosfbZLduTNWnqz7H8AiIzUIAb3pqr996qZk
	DV4ePmVheFaMNOBA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=KAA7Tvzg;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="ZS2/YFkN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1734102723; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0CfJ63JhuOY2ovRDqVxTmCyDDkl1SR+jaZ5MKweaD4E=;
	b=KAA7TvzgPCnBi0JAz9kQ5ngElDTNzxO6ffHo2gmmoeiRzFjxE8B62DeoNLXl8M0ZDWETJO
	zgkpkDl2yPqAAG9vG7aimw7WHkjValAThtw7jFaa8DJuUrd+EcJSVcLkRNcXEpoBcr5TX2
	5ZDnLfld5L+zSozqeNjtcDIgj1m3zzA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1734102723;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0CfJ63JhuOY2ovRDqVxTmCyDDkl1SR+jaZ5MKweaD4E=;
	b=ZS2/YFkNMsCwrPmLVhfFGU/reezXliHyLwWosfbZLduTNWnqz7H8AiIzUIAb3pqr996qZk
	DV4ePmVheFaMNOBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 147A013927;
	Fri, 13 Dec 2024 15:12:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7b79BMNOXGe4LwAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 13 Dec 2024 15:12:03 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id CC5D9A0B0E; Fri, 13 Dec 2024 16:12:02 +0100 (CET)
Date: Fri, 13 Dec 2024 16:12:02 +0100
From: Jan Kara <jack@suse.cz>
To: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, jack@suse.cz,
	harshads@google.com
Subject: Re: [PATCH v7 4/9] ext4: rework fast commit commit path
Message-ID: <20241213151202.kf4xvqcoof2oytk4@quack3>
References: <20240818040356.241684-1-harshadshirwadkar@gmail.com>
 <20240818040356.241684-6-harshadshirwadkar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240818040356.241684-6-harshadshirwadkar@gmail.com>
X-Rspamd-Queue-Id: 2A888211B1
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Sun 18-08-24 04:03:51, Harshad Shirwadkar wrote:
> This patch reworks fast commit's commit path to remove locking the
> journal for the entire duration of a fast commit. Instead, we only lock
> the journal while marking all the eligible inodes as "committing". This
> allows handles to make progress in parallel with the fast commit.
> 
> Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/fast_commit.c | 74 ++++++++++++++++++++++++++++---------------
>  fs/jbd2/journal.c     |  2 --
>  2 files changed, 49 insertions(+), 27 deletions(-)
> 
> diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
> index dfa999913..7a35234ce 100644
> --- a/fs/ext4/fast_commit.c
> +++ b/fs/ext4/fast_commit.c
> @@ -291,20 +291,30 @@ void ext4_fc_del(struct inode *inode)
>  	if (ext4_fc_disabled(inode->i_sb))
>  		return;
>  
> -restart:
>  	spin_lock(&EXT4_SB(inode->i_sb)->s_fc_lock);
>  	if (list_empty(&ei->i_fc_list) && list_empty(&ei->i_fc_dilist)) {
>  		spin_unlock(&EXT4_SB(inode->i_sb)->s_fc_lock);
>  		return;
>  	}
>  
> -	if (ext4_test_inode_state(inode, EXT4_STATE_FC_COMMITTING)) {
> -		ext4_fc_wait_committing_inode(inode);
> -		goto restart;
> -	}
> -
> -	if (!list_empty(&ei->i_fc_list))
> -		list_del_init(&ei->i_fc_list);
> +	/*
> +	 * Since ext4_fc_del is called from ext4_evict_inode while having a
> +	 * handle open, there is no need for us to wait here even if a fast
> +	 * commit is going on. That is because, if this inode is being
> +	 * committed, ext4_mark_inode_dirty would have waited for inode commit
> +	 * operation to finish before we come here. So, by the time we come
> +	 * here, inode's EXT4_STATE_FC_COMMITTING would have been cleared. So,
> +	 * we shouldn't see EXT4_STATE_FC_COMMITTING to be set on this inode
> +	 * here.
> +	 *
> +	 * We may come here without any handles open in the "no_delete" case of
> +	 * ext4_evict_inode as well. However, if that happens, we first mark the
> +	 * file system as fast commit ineligible anyway. So, even in that case,
> +	 * it is okay to remove the inode from the fc list.
> +	 */
> +	WARN_ON(ext4_test_inode_state(inode, EXT4_STATE_FC_COMMITTING)
> +		&& !ext4_test_mount_flag(inode->i_sb, EXT4_MF_FC_INELIGIBLE));
> +	list_del_init(&ei->i_fc_list);
>  
>  	/*
>  	 * Since this inode is getting removed, let's also remove all FC
> @@ -327,8 +337,6 @@ void ext4_fc_del(struct inode *inode)
>  		fc_dentry->fcd_name.len > DNAME_INLINE_LEN)
>  		kfree(fc_dentry->fcd_name.name);
>  	kmem_cache_free(ext4_fc_dentry_cachep, fc_dentry);
> -
> -	return;
>  }
>  
>  /*
> @@ -1004,19 +1012,6 @@ static int ext4_fc_submit_inode_data_all(journal_t *journal)
>  
>  	spin_lock(&sbi->s_fc_lock);
>  	list_for_each_entry(ei, &sbi->s_fc_q[FC_Q_MAIN], i_fc_list) {
> -		ext4_set_inode_state(&ei->vfs_inode, EXT4_STATE_FC_COMMITTING);
> -		while (atomic_read(&ei->i_fc_updates)) {
> -			DEFINE_WAIT(wait);
> -
> -			prepare_to_wait(&ei->i_fc_wait, &wait,
> -						TASK_UNINTERRUPTIBLE);
> -			if (atomic_read(&ei->i_fc_updates)) {
> -				spin_unlock(&sbi->s_fc_lock);
> -				schedule();
> -				spin_lock(&sbi->s_fc_lock);
> -			}
> -			finish_wait(&ei->i_fc_wait, &wait);
> -		}
>  		spin_unlock(&sbi->s_fc_lock);
>  		ret = jbd2_submit_inode_data(journal, ei->jinode);
>  		if (ret)
> @@ -1129,6 +1124,19 @@ static int ext4_fc_perform_commit(journal_t *journal)
>  	int ret = 0;
>  	u32 crc = 0;
>  
> +	/*
> +	 * Wait for all the handles of the current transaction to complete
> +	 * and then lock the journal.
> +	 */
> +	jbd2_journal_lock_updates(journal);
> +	spin_lock(&sbi->s_fc_lock);
> +	list_for_each_entry(iter, &sbi->s_fc_q[FC_Q_MAIN], i_fc_list) {
> +		ext4_set_inode_state(&iter->vfs_inode,
> +				     EXT4_STATE_FC_COMMITTING);
> +	}
> +	spin_unlock(&sbi->s_fc_lock);
> +	jbd2_journal_unlock_updates(journal);
> +
>  	ret = ext4_fc_submit_inode_data_all(journal);
>  	if (ret)
>  		return ret;
> @@ -1179,6 +1187,18 @@ static int ext4_fc_perform_commit(journal_t *journal)
>  		ret = ext4_fc_write_inode(inode, &crc);
>  		if (ret)
>  			goto out;
> +		ext4_clear_inode_state(inode, EXT4_STATE_FC_COMMITTING);
> +		/*
> +		 * Make sure clearing of EXT4_STATE_FC_COMMITTING is
> +		 * visible before we send the wakeup. Pairs with implicit
> +		 * barrier in prepare_to_wait() in ext4_fc_track_inode().
> +		 */
> +		smp_mb();
> +#if (BITS_PER_LONG < 64)
> +		wake_up_bit(&iter->i_state_flags, EXT4_STATE_FC_COMMITTING);
> +#else
> +		wake_up_bit(&iter->i_flags, EXT4_STATE_FC_COMMITTING);
> +#endif
>  		spin_lock(&sbi->s_fc_lock);
>  	}
>  	spin_unlock(&sbi->s_fc_lock);
> @@ -1316,13 +1336,17 @@ static void ext4_fc_cleanup(journal_t *journal, int full, tid_t tid)
>  	spin_lock(&sbi->s_fc_lock);
>  	list_for_each_entry_safe(iter, iter_n, &sbi->s_fc_q[FC_Q_MAIN],
>  				 i_fc_list) {
> -		list_del_init(&iter->i_fc_list);
>  		ext4_clear_inode_state(&iter->vfs_inode,
>  				       EXT4_STATE_FC_COMMITTING);
>  		if (tid_geq(tid, iter->i_sync_tid))
>  			ext4_fc_reset_inode(&iter->vfs_inode);
> -		/* Make sure EXT4_STATE_FC_COMMITTING bit is clear */
> +		/*
> +		 * Make sure clearing of EXT4_STATE_FC_COMMITTING is
> +		 * visible before we send the wakeup. Pairs with implicit
> +		 * barrier in prepare_to_wait() in ext4_fc_track_inode().
> +		 */
>  		smp_mb();
> +		list_del_init(&iter->i_fc_list);
>  #if (BITS_PER_LONG < 64)
>  		wake_up_bit(&iter->i_state_flags, EXT4_STATE_FC_COMMITTING);
>  #else
> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> index 1ebf2393b..ecd70b506 100644
> --- a/fs/jbd2/journal.c
> +++ b/fs/jbd2/journal.c
> @@ -728,7 +728,6 @@ int jbd2_fc_begin_commit(journal_t *journal, tid_t tid)
>  	}
>  	journal->j_flags |= JBD2_FAST_COMMIT_ONGOING;
>  	write_unlock(&journal->j_state_lock);
> -	jbd2_journal_lock_updates(journal);
>  
>  	return 0;
>  }
> @@ -740,7 +739,6 @@ EXPORT_SYMBOL(jbd2_fc_begin_commit);
>   */
>  static int __jbd2_fc_end_commit(journal_t *journal, tid_t tid, bool fallback)
>  {
> -	jbd2_journal_unlock_updates(journal);
>  	if (journal->j_fc_cleanup_callback)
>  		journal->j_fc_cleanup_callback(journal, 0, tid);
>  	write_lock(&journal->j_state_lock);
> -- 
> 2.46.0.184.g6999bdac58-goog
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

