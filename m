Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DBCC4D2CF6
	for <lists+linux-ext4@lfdr.de>; Wed,  9 Mar 2022 11:18:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbiCIKTA (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 9 Mar 2022 05:19:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiCIKS7 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 9 Mar 2022 05:18:59 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 850C414995D
        for <linux-ext4@vger.kernel.org>; Wed,  9 Mar 2022 02:18:01 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 3EF0D1F380;
        Wed,  9 Mar 2022 10:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1646821080; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=M1TN5eeKkU9f3WjhJ0ELK4lPLFM3g/QVYLS1CEccEjg=;
        b=tG2fdkyEkOUtuvxqnI4Y5XhgPjOKuaUgEvNpZGQ2J3yjjbqJr6XZkllNSWn/uyDJhuBx7/
        elM/LXBdKcVka2Tj9JzCNb95FRlTj3ePXFCw27yJqEEDObv3YHgAjXBKXA7NktanO+9AZz
        knlWs5hgBZlRjYO54lvwK4DbrxD1MyA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1646821080;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=M1TN5eeKkU9f3WjhJ0ELK4lPLFM3g/QVYLS1CEccEjg=;
        b=v0Y4bh190UlsParMltsU8YpvviX95ZURLRffYHJoF318b8NocdJDNFEv2Jd6do8bUW3b7C
        HKFyKPMP/XjjJHCw==
Received: from quack3.suse.cz (unknown [10.163.43.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 31C77A3B88;
        Wed,  9 Mar 2022 10:18:00 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id D2B9FA060B; Wed,  9 Mar 2022 11:17:59 +0100 (CET)
Date:   Wed, 9 Mar 2022 11:17:59 +0100
From:   Jan Kara <jack@suse.cz>
To:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Cc:     linux-ext4@vger.kernel.org, riteshh@linux.ibm.com, jack@suse.cz,
        tytso@mit.edu
Subject: Re: [PATCH v2 4/5] ext4: drop i_fc_updates from inode fc info
Message-ID: <20220309101759.77tpu5ldw4t6r73u@quack3.lan>
References: <20220308163319.1183625-1-harshads@google.com>
 <20220308163319.1183625-5-harshads@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220308163319.1183625-5-harshads@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue 08-03-22 08:33:18, Harshad Shirwadkar wrote:
> From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
> 
> The new logic introduced in this series does not require tracking number
> of active handles open on an inode. So, drop it.
> 
> Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/ext4.h        |  5 ----
>  fs/ext4/fast_commit.c | 70 -------------------------------------------
>  2 files changed, 75 deletions(-)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index fb6d65f1176f..6861a3127a42 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -1059,9 +1059,6 @@ struct ext4_inode_info {
>  	/* End of lblk range that needs to be committed in this fast commit */
>  	ext4_lblk_t i_fc_lblk_len;
>  
> -	/* Number of ongoing updates on this inode */
> -	atomic_t  i_fc_updates;
> -
>  	/* Fast commit wait queue for this inode */
>  	wait_queue_head_t i_fc_wait;
>  
> @@ -2930,8 +2927,6 @@ void __ext4_fc_track_create(handle_t *handle, struct inode *inode,
>  void ext4_fc_track_create(handle_t *handle, struct dentry *dentry);
>  void ext4_fc_track_inode(handle_t *handle, struct inode *inode);
>  void ext4_fc_mark_ineligible(struct super_block *sb, int reason, handle_t *handle);
> -void ext4_fc_start_update(struct inode *inode);
> -void ext4_fc_stop_update(struct inode *inode);
>  void ext4_fc_del(struct inode *inode);
>  bool ext4_fc_replay_check_excluded(struct super_block *sb, ext4_fsblk_t block);
>  void ext4_fc_replay_cleanup(struct super_block *sb);
> diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
> index eedcf8b4d47b..eea19e3ea9ba 100644
> --- a/fs/ext4/fast_commit.c
> +++ b/fs/ext4/fast_commit.c
> @@ -201,76 +201,6 @@ void ext4_fc_init_inode(struct inode *inode)
>  	INIT_LIST_HEAD(&ei->i_fc_list);
>  	INIT_LIST_HEAD(&ei->i_fc_dilist);
>  	init_waitqueue_head(&ei->i_fc_wait);
> -	atomic_set(&ei->i_fc_updates, 0);
> -}
> -
> -/* This function must be called with sbi->s_fc_lock held. */
> -static void ext4_fc_wait_committing_inode(struct inode *inode)
> -__releases(&EXT4_SB(inode->i_sb)->s_fc_lock)
> -{
> -	wait_queue_head_t *wq;
> -	struct ext4_inode_info *ei = EXT4_I(inode);
> -
> -#if (BITS_PER_LONG < 64)
> -	DEFINE_WAIT_BIT(wait, &ei->i_state_flags,
> -			EXT4_STATE_FC_COMMITTING);
> -	wq = bit_waitqueue(&ei->i_state_flags,
> -				EXT4_STATE_FC_COMMITTING);
> -#else
> -	DEFINE_WAIT_BIT(wait, &ei->i_flags,
> -			EXT4_STATE_FC_COMMITTING);
> -	wq = bit_waitqueue(&ei->i_flags,
> -				EXT4_STATE_FC_COMMITTING);
> -#endif
> -	lockdep_assert_held(&EXT4_SB(inode->i_sb)->s_fc_lock);
> -	prepare_to_wait(wq, &wait.wq_entry, TASK_UNINTERRUPTIBLE);
> -	spin_unlock(&EXT4_SB(inode->i_sb)->s_fc_lock);
> -	schedule();
> -	finish_wait(wq, &wait.wq_entry);
> -}
> -
> -/*
> - * Inform Ext4's fast about start of an inode update
> - *
> - * This function is called by the high level call VFS callbacks before
> - * performing any inode update. This function blocks if there's an ongoing
> - * fast commit on the inode in question.
> - */
> -void ext4_fc_start_update(struct inode *inode)
> -{
> -	struct ext4_inode_info *ei = EXT4_I(inode);
> -
> -	if (!test_opt2(inode->i_sb, JOURNAL_FAST_COMMIT) ||
> -	    (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY))
> -		return;
> -
> -restart:
> -	spin_lock(&EXT4_SB(inode->i_sb)->s_fc_lock);
> -	if (list_empty(&ei->i_fc_list))
> -		goto out;
> -
> -	if (ext4_test_inode_state(inode, EXT4_STATE_FC_COMMITTING)) {
> -		ext4_fc_wait_committing_inode(inode);
> -		goto restart;
> -	}
> -out:
> -	atomic_inc(&ei->i_fc_updates);
> -	spin_unlock(&EXT4_SB(inode->i_sb)->s_fc_lock);
> -}
> -
> -/*
> - * Stop inode update and wake up waiting fast commits if any.
> - */
> -void ext4_fc_stop_update(struct inode *inode)
> -{
> -	struct ext4_inode_info *ei = EXT4_I(inode);
> -
> -	if (!test_opt2(inode->i_sb, JOURNAL_FAST_COMMIT) ||
> -	    (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY))
> -		return;
> -
> -	if (atomic_dec_and_test(&ei->i_fc_updates))
> -		wake_up_all(&ei->i_fc_wait);
>  }
>  
>  /*
> -- 
> 2.35.1.616.g0bdcbb4464-goog
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
