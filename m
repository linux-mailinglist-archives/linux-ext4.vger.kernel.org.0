Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 221021F3A17
	for <lists+linux-ext4@lfdr.de>; Tue,  9 Jun 2020 13:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729084AbgFILua (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 9 Jun 2020 07:50:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:53098 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726395AbgFILu3 (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 9 Jun 2020 07:50:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 8279CAC22;
        Tue,  9 Jun 2020 11:50:31 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id F0B0A1E1283; Tue,  9 Jun 2020 13:50:26 +0200 (CEST)
Date:   Tue, 9 Jun 2020 13:50:26 +0200
From:   Jan Kara <jack@suse.cz>
To:     "zhangyi (F)" <yi.zhang@huawei.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu, jack@suse.cz,
        adilger.kernel@dilger.ca, zhangxiaoxu5@huawei.com
Subject: Re: [PATCH v2] ext4, jbd2: ensure panic by fix a race between jbd2
 abort and ext4 error handlers
Message-ID: <20200609115026.GA12551@quack2.suse.cz>
References: <20200609073540.3810702-1-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200609073540.3810702-1-yi.zhang@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue 09-06-20 15:35:40, zhangyi (F) wrote:
> In the ext4 filesystem with errors=panic, if one process is recording
> errno in the superblock when invoking jbd2_journal_abort() due to some
> error cases, it could be raced by another __ext4_abort() which is
> setting the SB_RDONLY flag but missing panic because errno has not been
> recorded.
> 
> jbd2_journal_commit_transaction()
>  jbd2_journal_abort()
>   journal->j_flags |= JBD2_ABORT;
>   jbd2_journal_update_sb_errno()
>                                     | ext4_journal_check_start()
>                                     |  __ext4_abort()
>                                     |   sb->s_flags |= SB_RDONLY;
>                                     |   if (!JBD2_REC_ERR)
>                                     |        return;
>   journal->j_flags |= JBD2_REC_ERR;
> 
> Finally, it will no longer trigger panic because the filesystem has
> already been set read-only. Fix this by introduce j_abort_mutex to make
> sure journal abort is completed before panic, and remove JBD2_REC_ERR
> flag.
> 
> Fixes: 4327ba52afd03 ("ext4, jbd2: ensure entering into panic after recording an error in superblock")
> Signed-off-by: zhangyi (F) <yi.zhang@huawei.com>
> Cc: <stable@vger.kernel.org>

Great, thanks! The patch looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> v1 -> v2:
>  - Introduce j_abort_mutex and remove j_record_errno completion.
> 
>  fs/ext4/super.c      | 16 +++++-----------
>  fs/jbd2/journal.c    | 17 ++++++++++++-----
>  include/linux/jbd2.h |  6 +++++-
>  3 files changed, 22 insertions(+), 17 deletions(-)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 9824cd8203e8..8b3771e61c49 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -522,9 +522,6 @@ static void ext4_handle_error(struct super_block *sb)
>  		smp_wmb();
>  		sb->s_flags |= SB_RDONLY;
>  	} else if (test_opt(sb, ERRORS_PANIC)) {
> -		if (EXT4_SB(sb)->s_journal &&
> -		  !(EXT4_SB(sb)->s_journal->j_flags & JBD2_REC_ERR))
> -			return;
>  		panic("EXT4-fs (device %s): panic forced after error\n",
>  			sb->s_id);
>  	}
> @@ -725,23 +722,20 @@ void __ext4_abort(struct super_block *sb, const char *function,
>  	va_end(args);
>  
>  	if (sb_rdonly(sb) == 0) {
> -		ext4_msg(sb, KERN_CRIT, "Remounting filesystem read-only");
>  		EXT4_SB(sb)->s_mount_flags |= EXT4_MF_FS_ABORTED;
> +		if (EXT4_SB(sb)->s_journal)
> +			jbd2_journal_abort(EXT4_SB(sb)->s_journal, -EIO);
> +
> +		ext4_msg(sb, KERN_CRIT, "Remounting filesystem read-only");
>  		/*
>  		 * Make sure updated value of ->s_mount_flags will be visible
>  		 * before ->s_flags update
>  		 */
>  		smp_wmb();
>  		sb->s_flags |= SB_RDONLY;
> -		if (EXT4_SB(sb)->s_journal)
> -			jbd2_journal_abort(EXT4_SB(sb)->s_journal, -EIO);
>  	}
> -	if (test_opt(sb, ERRORS_PANIC) && !system_going_down()) {
> -		if (EXT4_SB(sb)->s_journal &&
> -		  !(EXT4_SB(sb)->s_journal->j_flags & JBD2_REC_ERR))
> -			return;
> +	if (test_opt(sb, ERRORS_PANIC) && !system_going_down())
>  		panic("EXT4-fs panic from previous error\n");
> -	}
>  }
>  
>  void __ext4_msg(struct super_block *sb,
> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> index a49d0e670ddf..e4944436e733 100644
> --- a/fs/jbd2/journal.c
> +++ b/fs/jbd2/journal.c
> @@ -1140,6 +1140,7 @@ static journal_t *journal_init_common(struct block_device *bdev,
>  	init_waitqueue_head(&journal->j_wait_commit);
>  	init_waitqueue_head(&journal->j_wait_updates);
>  	init_waitqueue_head(&journal->j_wait_reserved);
> +	mutex_init(&journal->j_abort_mutex);
>  	mutex_init(&journal->j_barrier);
>  	mutex_init(&journal->j_checkpoint_mutex);
>  	spin_lock_init(&journal->j_revoke_lock);
> @@ -1402,7 +1403,8 @@ static int jbd2_write_superblock(journal_t *journal, int write_flags)
>  		printk(KERN_ERR "JBD2: Error %d detected when updating "
>  		       "journal superblock for %s.\n", ret,
>  		       journal->j_devname);
> -		jbd2_journal_abort(journal, ret);
> +		if (!is_journal_aborted(journal))
> +			jbd2_journal_abort(journal, ret);
>  	}
>  
>  	return ret;
> @@ -2153,6 +2155,13 @@ void jbd2_journal_abort(journal_t *journal, int errno)
>  {
>  	transaction_t *transaction;
>  
> +	/*
> +	 * Lock the aborting procedure until everything is done, this avoid
> +	 * races between filesystem's error handling flow (e.g. ext4_abort()),
> +	 * ensure panic after the error info is written into journal's
> +	 * superblock.
> +	 */
> +	mutex_lock(&journal->j_abort_mutex);
>  	/*
>  	 * ESHUTDOWN always takes precedence because a file system check
>  	 * caused by any other journal abort error is not required after
> @@ -2167,6 +2176,7 @@ void jbd2_journal_abort(journal_t *journal, int errno)
>  			journal->j_errno = errno;
>  			jbd2_journal_update_sb_errno(journal);
>  		}
> +		mutex_unlock(&journal->j_abort_mutex);
>  		return;
>  	}
>  
> @@ -2188,10 +2198,7 @@ void jbd2_journal_abort(journal_t *journal, int errno)
>  	 * layer could realise that a filesystem check is needed.
>  	 */
>  	jbd2_journal_update_sb_errno(journal);
> -
> -	write_lock(&journal->j_state_lock);
> -	journal->j_flags |= JBD2_REC_ERR;
> -	write_unlock(&journal->j_state_lock);
> +	mutex_unlock(&journal->j_abort_mutex);
>  }
>  
>  /**
> diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
> index f613d8529863..d56128df2aff 100644
> --- a/include/linux/jbd2.h
> +++ b/include/linux/jbd2.h
> @@ -765,6 +765,11 @@ struct journal_s
>  	 */
>  	int			j_errno;
>  
> +	/**
> +	 * @j_abort_mutex: Lock the whole aborting procedure.
> +	 */
> +	struct mutex		j_abort_mutex;
> +
>  	/**
>  	 * @j_sb_buffer: The first part of the superblock buffer.
>  	 */
> @@ -1247,7 +1252,6 @@ JBD2_FEATURE_INCOMPAT_FUNCS(csum3,		CSUM_V3)
>  #define JBD2_ABORT_ON_SYNCDATA_ERR	0x040	/* Abort the journal on file
>  						 * data write error in ordered
>  						 * mode */
> -#define JBD2_REC_ERR	0x080	/* The errno in the sb has been recorded */
>  
>  /*
>   * Function declarations for the journaling transaction and buffer
> -- 
> 2.25.4
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
