Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F8544D2CF2
	for <lists+linux-ext4@lfdr.de>; Wed,  9 Mar 2022 11:17:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbiCIKSR (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 9 Mar 2022 05:18:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiCIKSQ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 9 Mar 2022 05:18:16 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C634116A5BC
        for <linux-ext4@vger.kernel.org>; Wed,  9 Mar 2022 02:17:17 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 7D7A7210EE;
        Wed,  9 Mar 2022 10:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1646821036; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pAdTpS7E41CKHaSJ/uJn76LxXxngHpPBKu0eKeDjAW0=;
        b=NxGtPECOQnSNcO3ICrMUpi3MiQJguAVydnyUhasSSwuMHJXQtDHB3rcSXvHZH81l4652xB
        FBgKvKsMF3UeoIo5j17OJJAI3lje59AQz7tUxegWYRKRST+lba+bY/cbqlj+PKNICD6PMC
        jBc8OmqxuACOHjdUtotzaE9jgc5CogE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1646821036;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pAdTpS7E41CKHaSJ/uJn76LxXxngHpPBKu0eKeDjAW0=;
        b=m6F2W0BisJ7LePi7pARMFdOOOyYwIeIzNx+qdv4mX1OWCaaozHZu2jsaPrX30QEVyK0CpA
        /rOuAxD0zfeQLACg==
Received: from quack3.suse.cz (unknown [10.163.43.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 63FDAA3B85;
        Wed,  9 Mar 2022 10:17:16 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 03386A060B; Wed,  9 Mar 2022 11:17:10 +0100 (CET)
Date:   Wed, 9 Mar 2022 11:17:10 +0100
From:   Jan Kara <jack@suse.cz>
To:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Cc:     linux-ext4@vger.kernel.org, riteshh@linux.ibm.com, jack@suse.cz,
        tytso@mit.edu
Subject: Re: [PATCH v2 3/5] ext4: rework fast commit commit path
Message-ID: <20220309101710.5wilce5ijzp3a3l5@quack3.lan>
References: <20220308163319.1183625-1-harshads@google.com>
 <20220308163319.1183625-4-harshads@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220308163319.1183625-4-harshads@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue 08-03-22 08:33:17, Harshad Shirwadkar wrote:
> From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
> 
> This patch reworks fast commit's commit path to remove locking the
> journal for the entire duration of a fast commit. Instead, we only lock
> the journal while marking all the eligible inodes as "committing". This
> allows handles to make progress in parallel with the fast commit.
> 
> Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

The patch looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza


> ---
>  fs/ext4/fast_commit.c | 77 ++++++++++++++++++++++++++-----------------
>  fs/jbd2/journal.c     |  2 --
>  2 files changed, 47 insertions(+), 32 deletions(-)
> 
> diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
> index be8c5b3456ec..eedcf8b4d47b 100644
> --- a/fs/ext4/fast_commit.c
> +++ b/fs/ext4/fast_commit.c
> @@ -287,20 +287,30 @@ void ext4_fc_del(struct inode *inode)
>  	    (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY))
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
> @@ -323,8 +333,6 @@ void ext4_fc_del(struct inode *inode)
>  		fc_dentry->fcd_name.len > DNAME_INLINE_LEN)
>  		kfree(fc_dentry->fcd_name.name);
>  	kmem_cache_free(ext4_fc_dentry_cachep, fc_dentry);
> -
> -	return;
>  }
>  
>  /*
> @@ -964,19 +972,6 @@ static int ext4_fc_submit_inode_data_all(journal_t *journal)
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
>  		ret = jbd2_submit_inode_data(ei->jinode);
>  		if (ret)
> @@ -998,13 +993,9 @@ static int ext4_fc_wait_inode_data_all(journal_t *journal)
>  
>  	spin_lock(&sbi->s_fc_lock);
>  	list_for_each_entry_safe(pos, n, &sbi->s_fc_q[FC_Q_MAIN], i_fc_list) {
> -		spin_lock(&pos->i_fc_lock);
>  		if (!ext4_test_inode_state(&pos->vfs_inode,
> -					   EXT4_STATE_FC_COMMITTING)) {
> -			spin_unlock(&pos->i_fc_lock);
> +					   EXT4_STATE_FC_COMMITTING))
>  			continue;
> -		}
> -		spin_unlock(&pos->i_fc_lock);
>  		spin_unlock(&sbi->s_fc_lock);
>  
>  		ret = jbd2_wait_inode_data(journal, pos->jinode);
> @@ -1093,6 +1084,16 @@ static int ext4_fc_perform_commit(journal_t *journal)
>  	int ret = 0;
>  	u32 crc = 0;
>  
> +	/* Lock the journal */
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
> @@ -1143,6 +1144,18 @@ static int ext4_fc_perform_commit(journal_t *journal)
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
> @@ -1276,13 +1289,17 @@ static void ext4_fc_cleanup(journal_t *journal, int full, tid_t tid)
>  	spin_lock(&sbi->s_fc_lock);
>  	list_for_each_entry_safe(iter, iter_n, &sbi->s_fc_q[FC_Q_MAIN],
>  				 i_fc_list) {
> -		list_del_init(&iter->i_fc_list);
>  		ext4_clear_inode_state(&iter->vfs_inode,
>  				       EXT4_STATE_FC_COMMITTING);
>  		if (iter->i_sync_tid <= tid)
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
> index c2cf74b01ddb..06b885628b1c 100644
> --- a/fs/jbd2/journal.c
> +++ b/fs/jbd2/journal.c
> @@ -757,7 +757,6 @@ int jbd2_fc_begin_commit(journal_t *journal, tid_t tid)
>  	}
>  	journal->j_flags |= JBD2_FAST_COMMIT_ONGOING;
>  	write_unlock(&journal->j_state_lock);
> -	jbd2_journal_lock_updates(journal);
>  
>  	return 0;
>  }
> @@ -769,7 +768,6 @@ EXPORT_SYMBOL(jbd2_fc_begin_commit);
>   */
>  static int __jbd2_fc_end_commit(journal_t *journal, tid_t tid, bool fallback)
>  {
> -	jbd2_journal_unlock_updates(journal);
>  	if (journal->j_fc_cleanup_callback)
>  		journal->j_fc_cleanup_callback(journal, 0, tid);
>  	write_lock(&journal->j_state_lock);
> -- 
> 2.35.1.616.g0bdcbb4464-goog
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
