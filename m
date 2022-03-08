Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B318E4D16DD
	for <lists+linux-ext4@lfdr.de>; Tue,  8 Mar 2022 13:07:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234009AbiCHMIj (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 8 Mar 2022 07:08:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241074AbiCHMIg (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 8 Mar 2022 07:08:36 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93FDE63ED
        for <linux-ext4@vger.kernel.org>; Tue,  8 Mar 2022 04:07:36 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 34169210F6;
        Tue,  8 Mar 2022 12:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1646741255; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HLX7yUAogR4L7Hy2cabRlRM/CF1JZbFwGnU+9YvZKO4=;
        b=enzsQS64In8g4QQXe92N6ncjur6ZigVvt+e8GqxQBw0r+OARuz80mc/JVRG3j/QJPizj5E
        S41fbIB597z5U4YLyVJKc5IojohkzmXXG1fUQaFkM0TpUay8yrc/SOB8iNdfeS8egpKD1g
        xzuj35zoDA2I55V4jmYun6ppCAc8+vs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1646741255;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HLX7yUAogR4L7Hy2cabRlRM/CF1JZbFwGnU+9YvZKO4=;
        b=thPoeD0gyMXGdG/vrN6Ig/5doHmU/FPzgtbAE6J4es/8ZGp1lXDSB1tRVTUYeY76m/chLk
        emfAJ8XUa1dJ1fAw==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 23F4FA3B96;
        Tue,  8 Mar 2022 12:07:35 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id E5E71A0609; Tue,  8 Mar 2022 13:07:31 +0100 (CET)
Date:   Tue, 8 Mar 2022 13:07:31 +0100
From:   Jan Kara <jack@suse.cz>
To:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Cc:     linux-ext4@vger.kernel.org, riteshh@linux.ibm.com, jack@suse.cz,
        tytso@mit.edu
Subject: Re: [PATCH 2/5] ext4: drop i_fc_updates from inode fc info
Message-ID: <20220308120731.rw525hbt2i7fl2lf@quack3.lan>
References: <20220308105112.404498-1-harshads@google.com>
 <20220308105112.404498-3-harshads@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220308105112.404498-3-harshads@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue 08-03-22 02:51:09, Harshad Shirwadkar wrote:
> From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
> 
> The new logic introduced in this series does not require tracking number
> of active handles open on an inode. So, drop it.
> 
> Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

OK, but this patch needs to go towards the end of the series. Otherwise
fastcommit would be broken in the middle of the series which is nasty (e.g.
for bisection).

								Honza

> ---
>  fs/ext4/ext4.h        |  5 ----
>  fs/ext4/fast_commit.c | 58 +------------------------------------------
>  2 files changed, 1 insertion(+), 62 deletions(-)
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
> index 4f2caf6f987c..a589fc415dbe 100644
> --- a/fs/ext4/fast_commit.c
> +++ b/fs/ext4/fast_commit.c
> @@ -201,7 +201,6 @@ void ext4_fc_init_inode(struct inode *inode)
>  	INIT_LIST_HEAD(&ei->i_fc_list);
>  	INIT_LIST_HEAD(&ei->i_fc_dilist);
>  	init_waitqueue_head(&ei->i_fc_wait);
> -	atomic_set(&ei->i_fc_updates, 0);
>  }
>  
>  /* This function must be called with sbi->s_fc_lock held. */
> @@ -229,50 +228,6 @@ __releases(&EXT4_SB(inode->i_sb)->s_fc_lock)
>  	finish_wait(wq, &wait.wq_entry);
>  }
>  
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
> -}
> -
>  /*
>   * Remove inode from fast commit list. If the inode is being committed
>   * we wait until inode commit is done.
> @@ -939,18 +894,7 @@ static int ext4_fc_submit_inode_data_all(journal_t *journal)
>  	spin_lock(&sbi->s_fc_lock);
>  	list_for_each_entry(ei, &sbi->s_fc_q[FC_Q_MAIN], i_fc_list) {
>  		ext4_set_inode_state(&ei->vfs_inode, EXT4_STATE_FC_COMMITTING);
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
> +
>  		spin_unlock(&sbi->s_fc_lock);
>  		ret = jbd2_submit_inode_data(ei->jinode);
>  		if (ret)
> -- 
> 2.35.1.616.g0bdcbb4464-goog
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
