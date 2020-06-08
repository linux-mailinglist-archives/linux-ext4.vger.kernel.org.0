Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 844181F11AF
	for <lists+linux-ext4@lfdr.de>; Mon,  8 Jun 2020 05:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728691AbgFHDZf (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 7 Jun 2020 23:25:35 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5863 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728065AbgFHDZf (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Sun, 7 Jun 2020 23:25:35 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 3471FD8015FC39EABC3A;
        Mon,  8 Jun 2020 11:25:32 +0800 (CST)
Received: from [127.0.0.1] (10.166.215.198) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.487.0; Mon, 8 Jun 2020
 11:25:24 +0800
Subject: Re: [PATCH] ext4, jbd2: switch to use completion variable instead of
 JBD2_REC_ERR
To:     <linux-ext4@vger.kernel.org>
CC:     <tytso@mit.edu>, <jack@suse.cz>, <adilger.kernel@dilger.ca>,
        <zhangxiaoxu5@huawei.com>
References: <20200526142039.32643-1-yi.zhang@huawei.com>
From:   "zhangyi (F)" <yi.zhang@huawei.com>
Message-ID: <3539a7de-2bc5-cdeb-18a3-8fd72d1ac1ec@huawei.com>
Date:   Mon, 8 Jun 2020 11:25:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200526142039.32643-1-yi.zhang@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.166.215.198]
X-CFilter-Loop: Reflected
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi，Ted and Jan, any suggestions of this patch?

Thanks,
Yi.

On 2020/5/26 22:20, zhangyi (F) wrote:
> In the ext4 filesystem with errors=panic, if one process is recording
> errno in the superblock when invoking jbd2_journal_abort() due to some
> error cases, it could be raced by another __ext4_abort() which is
> setting the SB_RDONLY flag but missing panic because errno has not been
> recorded.
> 
> jbd2_journal_abort()
>  journal->j_flags |= JBD2_ABORT;
>  jbd2_journal_update_sb_errno()
>                                    | __ext4_abort()
>                                    |  sb->s_flags |= SB_RDONLY;
>                                    |  if (!JBD2_REC_ERR)
>                                    |       return;
>  journal->j_flags |= JBD2_REC_ERR;
> 
> Finally, it will no longer trigger panic because the filesystem has
> already been set read-only. Fix this by remove JBD2_REC_ERR and switch
> to use completion variable instead.
> 
> Fixes: 4327ba52afd03 ("ext4, jbd2: ensure entering into panic after recording an error in superblock")
> Signed-off-by: zhangyi (F) <yi.zhang@huawei.com>
> ---
>  fs/ext4/super.c      | 25 +++++++++++++------------
>  fs/jbd2/journal.c    |  6 ++----
>  include/linux/jbd2.h |  6 +++++-
>  3 files changed, 20 insertions(+), 17 deletions(-)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index bf5fcb477f66..987a0bd5b78a 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -495,6 +495,8 @@ static bool system_going_down(void)
>  
>  static void ext4_handle_error(struct super_block *sb)
>  {
> +	struct ext4_sb_info *sbi = EXT4_SB(sb);
> +
>  	if (test_opt(sb, WARN_ON_ERROR))
>  		WARN_ON_ONCE(1);
>  
> @@ -502,9 +504,9 @@ static void ext4_handle_error(struct super_block *sb)
>  		return;
>  
>  	if (!test_opt(sb, ERRORS_CONT)) {
> -		journal_t *journal = EXT4_SB(sb)->s_journal;
> +		journal_t *journal = sbi->s_journal;
>  
> -		EXT4_SB(sb)->s_mount_flags |= EXT4_MF_FS_ABORTED;
> +		sbi->s_mount_flags |= EXT4_MF_FS_ABORTED;
>  		if (journal)
>  			jbd2_journal_abort(journal, -EIO);
>  	}
> @@ -522,9 +524,8 @@ static void ext4_handle_error(struct super_block *sb)
>  		smp_wmb();
>  		sb->s_flags |= SB_RDONLY;
>  	} else if (test_opt(sb, ERRORS_PANIC)) {
> -		if (EXT4_SB(sb)->s_journal &&
> -		  !(EXT4_SB(sb)->s_journal->j_flags & JBD2_REC_ERR))
> -			return;
> +		if (sbi->s_journal && is_journal_aborted(sbi->s_journal))
> +			wait_for_completion(&sbi->s_journal->j_record_errno);
>  		panic("EXT4-fs (device %s): panic forced after error\n",
>  			sb->s_id);
>  	}
> @@ -710,10 +711,11 @@ void __ext4_std_error(struct super_block *sb, const char *function,
>  void __ext4_abort(struct super_block *sb, const char *function,
>  		  unsigned int line, int error, const char *fmt, ...)
>  {
> +	struct ext4_sb_info *sbi = EXT4_SB(sb);
>  	struct va_format vaf;
>  	va_list args;
>  
> -	if (unlikely(ext4_forced_shutdown(EXT4_SB(sb))))
> +	if (unlikely(ext4_forced_shutdown(sbi)))
>  		return;
>  
>  	save_error_info(sb, error, 0, 0, function, line);
> @@ -726,20 +728,19 @@ void __ext4_abort(struct super_block *sb, const char *function,
>  
>  	if (sb_rdonly(sb) == 0) {
>  		ext4_msg(sb, KERN_CRIT, "Remounting filesystem read-only");
> -		EXT4_SB(sb)->s_mount_flags |= EXT4_MF_FS_ABORTED;
> +		sbi->s_mount_flags |= EXT4_MF_FS_ABORTED;
>  		/*
>  		 * Make sure updated value of ->s_mount_flags will be visible
>  		 * before ->s_flags update
>  		 */
>  		smp_wmb();
>  		sb->s_flags |= SB_RDONLY;
> -		if (EXT4_SB(sb)->s_journal)
> -			jbd2_journal_abort(EXT4_SB(sb)->s_journal, -EIO);
> +		if (sbi->s_journal)
> +			jbd2_journal_abort(sbi->s_journal, -EIO);
>  	}
>  	if (test_opt(sb, ERRORS_PANIC) && !system_going_down()) {
> -		if (EXT4_SB(sb)->s_journal &&
> -		  !(EXT4_SB(sb)->s_journal->j_flags & JBD2_REC_ERR))
> -			return;
> +		if (sbi->s_journal && is_journal_aborted(sbi->s_journal))
> +			wait_for_completion(&sbi->s_journal->j_record_errno);
>  		panic("EXT4-fs panic from previous error\n");
>  	}
>  }
> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> index a49d0e670ddf..b8acdb2f7ac7 100644
> --- a/fs/jbd2/journal.c
> +++ b/fs/jbd2/journal.c
> @@ -1140,6 +1140,7 @@ static journal_t *journal_init_common(struct block_device *bdev,
>  	init_waitqueue_head(&journal->j_wait_commit);
>  	init_waitqueue_head(&journal->j_wait_updates);
>  	init_waitqueue_head(&journal->j_wait_reserved);
> +	init_completion(&journal->j_record_errno);
>  	mutex_init(&journal->j_barrier);
>  	mutex_init(&journal->j_checkpoint_mutex);
>  	spin_lock_init(&journal->j_revoke_lock);
> @@ -2188,10 +2189,7 @@ void jbd2_journal_abort(journal_t *journal, int errno)
>  	 * layer could realise that a filesystem check is needed.
>  	 */
>  	jbd2_journal_update_sb_errno(journal);
> -
> -	write_lock(&journal->j_state_lock);
> -	journal->j_flags |= JBD2_REC_ERR;
> -	write_unlock(&journal->j_state_lock);
> +	complete_all(&journal->j_record_errno);
>  }
>  
>  /**
> diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
> index f613d8529863..0f623b0c347f 100644
> --- a/include/linux/jbd2.h
> +++ b/include/linux/jbd2.h
> @@ -765,6 +765,11 @@ struct journal_s
>  	 */
>  	int			j_errno;
>  
> +	/**
> +	 * @j_record_errno: complete to record errno in the journal superblock
> +	 */
> +	struct completion	j_record_errno;
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
> 

