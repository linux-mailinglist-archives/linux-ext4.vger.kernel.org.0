Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 385E14D16CE
	for <lists+linux-ext4@lfdr.de>; Tue,  8 Mar 2022 13:03:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233849AbiCHMEs (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 8 Mar 2022 07:04:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346641AbiCHMEp (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 8 Mar 2022 07:04:45 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2EE4286E6
        for <linux-ext4@vger.kernel.org>; Tue,  8 Mar 2022 04:03:48 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 8870A210F3;
        Tue,  8 Mar 2022 12:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1646741027; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+qUK6RCjoiYBA+4tRgzrFvnqYY+iKr1ul419CL5Y2+A=;
        b=KX1NCoSntNyRmr0kceoyHGmI+xm80C0g2XTgcYLbyuYYEWWLWmEPQpY5puX/VqXK7ZJmS0
        d1RDZfaYdyohnX4N5Upb4uYX22PKh6YyGEYP9Kvse03c2eSeAfGHSMg1eOyTDAch48Jreg
        O/tFJSItEDwxvraDFvNwsSx0Le4o/jU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1646741027;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+qUK6RCjoiYBA+4tRgzrFvnqYY+iKr1ul419CL5Y2+A=;
        b=feCrwpd3JamT2s42heqiiYNxQ9v7gILlqHdoNn2AlZcBFUNkJylgBi+0isgw5Xx1MGi0lj
        tldmh8LLC5GKWBCQ==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 6BBE0A3B84;
        Tue,  8 Mar 2022 12:03:47 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id BD188A0609; Tue,  8 Mar 2022 13:03:44 +0100 (CET)
Date:   Tue, 8 Mar 2022 13:03:44 +0100
From:   Jan Kara <jack@suse.cz>
To:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Cc:     linux-ext4@vger.kernel.org, riteshh@linux.ibm.com, jack@suse.cz,
        tytso@mit.edu
Subject: Re: [PATCH 1/5] ext4: convert i_fc_lock to spinlock
Message-ID: <20220308120344.dplfoodvjl63u7jp@quack3.lan>
References: <20220308105112.404498-1-harshads@google.com>
 <20220308105112.404498-2-harshads@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220308105112.404498-2-harshads@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue 08-03-22 02:51:08, Harshad Shirwadkar wrote:
> From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
> 
> Convert ext4_inode_info->i_fc_lock to spinlock to avoid sleeping
> in invalid contexts.
> 
> Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

I don't think ext4_debug() is safe under spinlock in __track_range(). But
otherwise the patch looks good to me. So feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

after fixing this.

								Honza

> ---
>  fs/ext4/ext4.h        |  7 +++++--
>  fs/ext4/fast_commit.c | 24 ++++++++++++++----------
>  fs/ext4/super.c       |  2 +-
>  3 files changed, 20 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 3f87cca49f0c..fb6d65f1176f 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -1065,8 +1065,11 @@ struct ext4_inode_info {
>  	/* Fast commit wait queue for this inode */
>  	wait_queue_head_t i_fc_wait;
>  
> -	/* Protect concurrent accesses on i_fc_lblk_start, i_fc_lblk_len */
> -	struct mutex i_fc_lock;
> +	/*
> +	 * Protect concurrent accesses on i_fc_lblk_start, i_fc_lblk_len
> +	 * and inode's EXT4_FC_STATE_COMMITTING state bit.
> +	 */
> +	spinlock_t i_fc_lock;
>  
>  	/*
>  	 * i_disksize keeps track of what the inode size is ON DISK, not
> diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
> index 5ac594e03402..4f2caf6f987c 100644
> --- a/fs/ext4/fast_commit.c
> +++ b/fs/ext4/fast_commit.c
> @@ -387,7 +387,7 @@ static int ext4_fc_track_template(
>  		return -EINVAL;
>  
>  	tid = handle->h_transaction->t_tid;
> -	mutex_lock(&ei->i_fc_lock);
> +	spin_lock(&ei->i_fc_lock);
>  	if (tid == ei->i_sync_tid) {
>  		update = true;
>  	} else {
> @@ -395,7 +395,7 @@ static int ext4_fc_track_template(
>  		ei->i_sync_tid = tid;
>  	}
>  	ret = __fc_track_fn(inode, args, update);
> -	mutex_unlock(&ei->i_fc_lock);
> +	spin_unlock(&ei->i_fc_lock);
>  
>  	if (!enqueue)
>  		return ret;
> @@ -427,11 +427,11 @@ static int __track_dentry_update(struct inode *inode, void *arg, bool update)
>  	struct dentry *dentry = dentry_update->dentry;
>  	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
>  
> -	mutex_unlock(&ei->i_fc_lock);
> +	spin_unlock(&ei->i_fc_lock);
>  	node = kmem_cache_alloc(ext4_fc_dentry_cachep, GFP_NOFS);
>  	if (!node) {
>  		ext4_fc_mark_ineligible(inode->i_sb, EXT4_FC_REASON_NOMEM, NULL);
> -		mutex_lock(&ei->i_fc_lock);
> +		spin_lock(&ei->i_fc_lock);
>  		return -ENOMEM;
>  	}
>  
> @@ -444,7 +444,7 @@ static int __track_dentry_update(struct inode *inode, void *arg, bool update)
>  			kmem_cache_free(ext4_fc_dentry_cachep, node);
>  			ext4_fc_mark_ineligible(inode->i_sb,
>  				EXT4_FC_REASON_NOMEM, NULL);
> -			mutex_lock(&ei->i_fc_lock);
> +			spin_lock(&ei->i_fc_lock);
>  			return -ENOMEM;
>  		}
>  		memcpy((u8 *)node->fcd_name.name, dentry->d_name.name,
> @@ -478,7 +478,7 @@ static int __track_dentry_update(struct inode *inode, void *arg, bool update)
>  		list_add_tail(&node->fcd_dilist, &ei->i_fc_dilist);
>  	}
>  	spin_unlock(&sbi->s_fc_lock);
> -	mutex_lock(&ei->i_fc_lock);
> +	spin_lock(&ei->i_fc_lock);
>  
>  	return 0;
>  }
> @@ -867,15 +867,15 @@ static int ext4_fc_write_inode_data(struct inode *inode, u32 *crc)
>  	struct ext4_extent *ex;
>  	int ret;
>  
> -	mutex_lock(&ei->i_fc_lock);
> +	spin_lock(&ei->i_fc_lock);
>  	if (ei->i_fc_lblk_len == 0) {
> -		mutex_unlock(&ei->i_fc_lock);
> +		spin_unlock(&ei->i_fc_lock);
>  		return 0;
>  	}
>  	old_blk_size = ei->i_fc_lblk_start;
>  	new_blk_size = ei->i_fc_lblk_start + ei->i_fc_lblk_len - 1;
>  	ei->i_fc_lblk_len = 0;
> -	mutex_unlock(&ei->i_fc_lock);
> +	spin_unlock(&ei->i_fc_lock);
>  
>  	cur_lblk_off = old_blk_size;
>  	jbd_debug(1, "%s: will try writing %d to %d for inode %ld\n",
> @@ -972,9 +972,13 @@ static int ext4_fc_wait_inode_data_all(journal_t *journal)
>  
>  	spin_lock(&sbi->s_fc_lock);
>  	list_for_each_entry_safe(pos, n, &sbi->s_fc_q[FC_Q_MAIN], i_fc_list) {
> +		spin_lock(&pos->i_fc_lock);
>  		if (!ext4_test_inode_state(&pos->vfs_inode,
> -					   EXT4_STATE_FC_COMMITTING))
> +					   EXT4_STATE_FC_COMMITTING)) {
> +			spin_unlock(&pos->i_fc_lock);
>  			continue;
> +		}
> +		spin_unlock(&pos->i_fc_lock);
>  		spin_unlock(&sbi->s_fc_lock);
>  
>  		ret = jbd2_wait_inode_data(journal, pos->jinode);
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 1e5f4994fe57..38d63113c383 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -1346,7 +1346,7 @@ static struct inode *ext4_alloc_inode(struct super_block *sb)
>  	atomic_set(&ei->i_unwritten, 0);
>  	INIT_WORK(&ei->i_rsv_conversion_work, ext4_end_io_rsv_work);
>  	ext4_fc_init_inode(&ei->vfs_inode);
> -	mutex_init(&ei->i_fc_lock);
> +	spin_lock_init(&ei->i_fc_lock);
>  	return &ei->vfs_inode;
>  }
>  
> -- 
> 2.35.1.616.g0bdcbb4464-goog
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
