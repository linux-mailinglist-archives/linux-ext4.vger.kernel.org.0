Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06C2B2A4C14
	for <lists+linux-ext4@lfdr.de>; Tue,  3 Nov 2020 17:58:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbgKCQ6m (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 3 Nov 2020 11:58:42 -0500
Received: from mx2.suse.de ([195.135.220.15]:36238 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726581AbgKCQ6m (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 3 Nov 2020 11:58:42 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C742CAD29;
        Tue,  3 Nov 2020 16:58:40 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 7DC511E12FB; Tue,  3 Nov 2020 17:58:40 +0100 (CET)
Date:   Tue, 3 Nov 2020 17:58:40 +0100
From:   Jan Kara <jack@suse.cz>
To:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu, jack@suse.cz,
        Andrea Righi <andrea.righi@canonical.com>
Subject: Re: [PATCH 08/10] ext4: fix inode dirty check in case of fast commits
Message-ID: <20201103165840.GL3440@quack2.suse.cz>
References: <20201031200518.4178786-1-harshadshirwadkar@gmail.com>
 <20201031200518.4178786-9-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201031200518.4178786-9-harshadshirwadkar@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat 31-10-20 13:05:16, Harshad Shirwadkar wrote:
> In case of fast commits, determine if the inode is dirty by checking
> if the inode is on fast commit list. This also helps us get rid of
> ext4_inode_info.i_fc_committed_subtid field.
> 
> Reported-by: Andrea Righi <andrea.righi@canonical.com>
> Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

Nice cleanup and looks good to me! You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/ext4.h        | 3 ---
>  fs/ext4/fast_commit.c | 3 ---
>  fs/ext4/inode.c       | 3 +--
>  3 files changed, 1 insertion(+), 8 deletions(-)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 573db158382f..7222a9ba5d66 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -1028,9 +1028,6 @@ struct ext4_inode_info {
>  					 * protected by sbi->s_fc_lock.
>  					 */
>  
> -	/* Fast commit subtid when this inode was committed */
> -	unsigned int i_fc_committed_subtid;
> -
>  	/* Start of lblk range that needs to be committed in this fast commit */
>  	ext4_lblk_t i_fc_lblk_start;
>  
> diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
> index b7b1fe6dbb24..4c0a3e858ea3 100644
> --- a/fs/ext4/fast_commit.c
> +++ b/fs/ext4/fast_commit.c
> @@ -152,7 +152,6 @@ void ext4_fc_init_inode(struct inode *inode)
>  	INIT_LIST_HEAD(&ei->i_fc_list);
>  	init_waitqueue_head(&ei->i_fc_wait);
>  	atomic_set(&ei->i_fc_updates, 0);
> -	ei->i_fc_committed_subtid = 0;
>  }
>  
>  static void ext4_fc_wait_committing_inode(struct inode *inode)
> @@ -1026,8 +1025,6 @@ static int ext4_fc_perform_commit(journal_t *journal)
>  		if (ret)
>  			goto out;
>  		spin_lock(&sbi->s_fc_lock);
> -		EXT4_I(inode)->i_fc_committed_subtid =
> -			atomic_read(&sbi->s_fc_subtid);
>  	}
>  	spin_unlock(&sbi->s_fc_lock);
>  
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 7f6af784e74f..d36c3908272f 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -3311,8 +3311,7 @@ static bool ext4_inode_datasync_dirty(struct inode *inode)
>  			EXT4_I(inode)->i_datasync_tid))
>  			return false;
>  		if (test_opt2(inode->i_sb, JOURNAL_FAST_COMMIT))
> -			return atomic_read(&EXT4_SB(inode->i_sb)->s_fc_subtid) <
> -				EXT4_I(inode)->i_fc_committed_subtid;
> +			return !list_empty(&EXT4_I(inode)->i_fc_list);
>  		return true;
>  	}
>  
> -- 
> 2.29.1.341.ge80a0c044ae-goog
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
