Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62C7451208F
	for <lists+linux-ext4@lfdr.de>; Wed, 27 Apr 2022 20:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241399AbiD0QJ5 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 27 Apr 2022 12:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242592AbiD0QJq (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 27 Apr 2022 12:09:46 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C325487037
        for <linux-ext4@vger.kernel.org>; Wed, 27 Apr 2022 09:05:41 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id BDA36210FC;
        Wed, 27 Apr 2022 15:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1651075108; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MFrw8cN8Cf7Eguyxjf0dxcCq/u3Z76a1MNXexWpFSC4=;
        b=wl2+DQTUAt7rBPQ7y9Km5BKseAb091TXQL9WwmvmnBN1unaPTfulki/36PVhH7y9dnZe9q
        awiDZFN4I5VWlx7GJFYz3A19Va+oTnB73KlOBbdSM3LLU/E5CpP91cbWAwC7+S8G86dZJe
        IssZNpnVa+9RueUOTburNbEaeTH1boU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1651075108;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MFrw8cN8Cf7Eguyxjf0dxcCq/u3Z76a1MNXexWpFSC4=;
        b=F/SVn0BqbxRNlfwjM4HC5OprK8uYcIyc+B9WJHDWv2ts4AcV2crXlsUxdjBI2fMbaZotvI
        XpZkl4vhe1eyeRAQ==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 6CF512C141;
        Wed, 27 Apr 2022 15:58:28 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 85AD6A061C; Wed, 27 Apr 2022 17:58:25 +0200 (CEST)
Date:   Wed, 27 Apr 2022 17:58:25 +0200
From:   Jan Kara <jack@suse.cz>
To:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Cc:     linux-ext4@vger.kernel.org, riteshh@linux.ibm.com, jack@suse.cz,
        tytso@mit.edu
Subject: Re: [PATCH v3 1/6] ext4: convert i_fc_lock to spinlock
Message-ID: <20220427155825.qxorb7fmwoj2zxql@quack3.lan>
References: <20220419173143.3564144-1-harshads@google.com>
 <20220419173143.3564144-2-harshads@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220419173143.3564144-2-harshads@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue 19-04-22 10:31:38, Harshad Shirwadkar wrote:
> From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
> 
> Convert ext4_inode_info->i_fc_lock to spinlock to avoid sleeping
> in invalid contexts.
> 
> Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/ext4.h        |  7 +++++--
>  fs/ext4/fast_commit.c | 22 ++++++++++------------
>  fs/ext4/super.c       |  2 +-
>  3 files changed, 16 insertions(+), 15 deletions(-)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 1d79012c5a5b..46ca0979e73b 100644
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
> index 3d72565ec6e8..c278060a15bc 100644
> --- a/fs/ext4/fast_commit.c
> +++ b/fs/ext4/fast_commit.c
> @@ -380,7 +380,7 @@ static int ext4_fc_track_template(
>  	int ret;
>  
>  	tid = handle->h_transaction->t_tid;
> -	mutex_lock(&ei->i_fc_lock);
> +	spin_lock(&ei->i_fc_lock);
>  	if (tid == ei->i_sync_tid) {
>  		update = true;
>  	} else {
> @@ -388,7 +388,7 @@ static int ext4_fc_track_template(
>  		ei->i_sync_tid = tid;
>  	}
>  	ret = __fc_track_fn(inode, args, update);
> -	mutex_unlock(&ei->i_fc_lock);
> +	spin_unlock(&ei->i_fc_lock);
>  
>  	if (!enqueue)
>  		return ret;
> @@ -420,11 +420,11 @@ static int __track_dentry_update(struct inode *inode, void *arg, bool update)
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
> @@ -437,7 +437,7 @@ static int __track_dentry_update(struct inode *inode, void *arg, bool update)
>  			kmem_cache_free(ext4_fc_dentry_cachep, node);
>  			ext4_fc_mark_ineligible(inode->i_sb,
>  				EXT4_FC_REASON_NOMEM, NULL);
> -			mutex_lock(&ei->i_fc_lock);
> +			spin_lock(&ei->i_fc_lock);
>  			return -ENOMEM;
>  		}
>  		memcpy((u8 *)node->fcd_name.name, dentry->d_name.name,
> @@ -471,7 +471,7 @@ static int __track_dentry_update(struct inode *inode, void *arg, bool update)
>  		list_add_tail(&node->fcd_dilist, &ei->i_fc_dilist);
>  	}
>  	spin_unlock(&sbi->s_fc_lock);
> -	mutex_lock(&ei->i_fc_lock);
> +	spin_lock(&ei->i_fc_lock);
>  
>  	return 0;
>  }
> @@ -611,10 +611,8 @@ static int __track_range(struct inode *inode, void *arg, bool update)
>  	struct __track_range_args *__arg =
>  		(struct __track_range_args *)arg;
>  
> -	if (inode->i_ino < EXT4_FIRST_INO(inode->i_sb)) {
> -		ext4_debug("Special inode %ld being modified\n", inode->i_ino);
> +	if (inode->i_ino < EXT4_FIRST_INO(inode->i_sb))
>  		return -ECANCELED;
> -	}
>  
>  	oldstart = ei->i_fc_lblk_start;
>  
> @@ -906,15 +904,15 @@ static int ext4_fc_write_inode_data(struct inode *inode, u32 *crc)
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
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index ae98b07285d2..d6fc12782657 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -1347,7 +1347,7 @@ static struct inode *ext4_alloc_inode(struct super_block *sb)
>  	atomic_set(&ei->i_unwritten, 0);
>  	INIT_WORK(&ei->i_rsv_conversion_work, ext4_end_io_rsv_work);
>  	ext4_fc_init_inode(&ei->vfs_inode);
> -	mutex_init(&ei->i_fc_lock);
> +	spin_lock_init(&ei->i_fc_lock);
>  	return &ei->vfs_inode;
>  }
>  
> -- 
> 2.36.0.rc0.470.gd361397f0d-goog
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
