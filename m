Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB2301F1C34
	for <lists+linux-ext4@lfdr.de>; Mon,  8 Jun 2020 17:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730292AbgFHPg0 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 8 Jun 2020 11:36:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:43126 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729580AbgFHPg0 (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 8 Jun 2020 11:36:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id F162EAC46;
        Mon,  8 Jun 2020 15:36:26 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 9BDEE1E1283; Mon,  8 Jun 2020 17:36:22 +0200 (CEST)
Date:   Mon, 8 Jun 2020 17:36:22 +0200
From:   Jan Kara <jack@suse.cz>
To:     "zhangyi (F)" <yi.zhang@huawei.com>
Cc:     Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, zhangxiaoxu5@huawei.com
Subject: Re: [PATCH] ext4, jbd2: switch to use completion variable instead of
 JBD2_REC_ERR
Message-ID: <20200608153622.GB861@quack2.suse.cz>
References: <20200526142039.32643-1-yi.zhang@huawei.com>
 <20200608075729.GI13248@quack2.suse.cz>
 <0adeaa3a-25e0-0f73-8fb2-1b3dcecd190b@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0adeaa3a-25e0-0f73-8fb2-1b3dcecd190b@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon 08-06-20 23:08:42, zhangyi (F) wrote:
> Hi, Jan.
> 
> On 2020/6/8 15:57, Jan Kara wrote:
> > On Tue 26-05-20 22:20:39, zhangyi (F) wrote:
> >> In the ext4 filesystem with errors=panic, if one process is recording
> >> errno in the superblock when invoking jbd2_journal_abort() due to some
> >> error cases, it could be raced by another __ext4_abort() which is
> >> setting the SB_RDONLY flag but missing panic because errno has not been
> >> recorded.
> >>
> >> jbd2_journal_abort()
> >>  journal->j_flags |= JBD2_ABORT;
> >>  jbd2_journal_update_sb_errno()
> >>                                    | __ext4_abort()
> >>                                    |  sb->s_flags |= SB_RDONLY;
> >>                                    |  if (!JBD2_REC_ERR)
> >>                                    |       return;
> >>  journal->j_flags |= JBD2_REC_ERR;
> >>
> >> Finally, it will no longer trigger panic because the filesystem has
> >> already been set read-only. Fix this by remove JBD2_REC_ERR and switch
> >> to use completion variable instead.
> > 
> > Thanks for the patch! I don't quite understand how this last part can
> > happen: "Finally, it will no longer trigger panic because the filesystem has
> > already been set read-only."
> > 
> > AFAIU jbd2_journal_abort() gets called somewhere from jbd2 so ext4 doesn't
> > know about it. At the same time ext4_abort() gets called somewhere from
> > ext4 and races as you describe above. OK. But then the next ext4_abort()
> > call should panic() just fine. What am I missing? I understand that we
> > might want that the first ext4_abort() already triggers the panic but I'd
> > like to understand whether that's the bug you're trying to fix or something
> > else...
> > 
> Since the fs is marked to read-only in the first ext4_abort(), the
> ext4_journal_check_start() will return -EROFS immediately, so we
> have no chance to invoke ext4_abort() again and trigger panic.
> 
> static int ext4_journal_check_start(struct super_block *sb)
> {
> ...
> 	if (sb_rdonly(sb))
> 		return -EROFS;
> ...
> }

Ah, I see. I didn't look into ext4_journal_check_start() in particular.
Thanks for explanation.

> > WRT the solution I think that the completion you add unnecessarily
> > complicates matters. I'd rather introduce j_abort_mutex to the journal and
> > all jbd2_journal_abort() calls will take it and release it once everything
> > is done. That way we can remove JBD2_REC_ERR, races are avoided, and the
> > filesystem (ext4 or ocfs2) knows that after its call to
> > jbd2_journal_abort() completes, journal abort is completed (either by us or
> > someone else) and so we are free to panic. No need for strange
> > wait_for_completion() calls in ext4_handle_error() or __ext4_abort() and
> > the error handling is again fully self-contained within the jbd2 layer.
> > 
> 
> Now, the race condition is between jbd2_journal_abort() and
> ext4_handle_error()/__ext4_abort(), so if we only use j_abort_mutex, it
> will re-introduce the problem which 4327ba52afd03 want to fix, think
> about below case:
> 
> jbd2_journal_commit_transaction()   ext4_journal_check_start()   ext4_journal_check_start()
>  jbd2_journal_abort()
>    lock j_abort_mutex
>    journal->j_flags |= JBD2_ABORT;
>                                      __ext4_abort()
>                                                                    __ext4_abort()
>                                       sb->s_flags |= SB_RDONLY;
>                                                                      panic()  <-- system panic here due to "sb_rdonly()==true"
>                                       jbd2_journal_abort() <-- block
>    jbd2_journal_update_sb_errno  <-- not write to disk
>    unlock j_abort_mutex
> 
> The system will panic before the error info is written to the journal's
> super block. Use j_abort_mutex to avoid the race between jbd2_journal_abort()
> and ext4_handle_error()/__ext4_abort() is depends on the both of those two
> ext4 error handlers invoke jbd2_journal_abort(), if not, the race will
> re-open.

Yes, you're right. Or we could move sb->s_flags |= SB_RDONLY in
__ext4_abort() after jbd2_journal_abort() call, can't we?

								Honza

> >> Fixes: 4327ba52afd03 ("ext4, jbd2: ensure entering into panic after recording an error in superblock")
> >> Signed-off-by: zhangyi (F) <yi.zhang@huawei.com>
> >> ---
> >>  fs/ext4/super.c      | 25 +++++++++++++------------
> >>  fs/jbd2/journal.c    |  6 ++----
> >>  include/linux/jbd2.h |  6 +++++-
> >>  3 files changed, 20 insertions(+), 17 deletions(-)
> >>
> >> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> >> index bf5fcb477f66..987a0bd5b78a 100644
> >> --- a/fs/ext4/super.c
> >> +++ b/fs/ext4/super.c
> >> @@ -495,6 +495,8 @@ static bool system_going_down(void)
> >>  
> >>  static void ext4_handle_error(struct super_block *sb)
> >>  {
> >> +	struct ext4_sb_info *sbi = EXT4_SB(sb);
> >> +
> >>  	if (test_opt(sb, WARN_ON_ERROR))
> >>  		WARN_ON_ONCE(1);
> >>  
> >> @@ -502,9 +504,9 @@ static void ext4_handle_error(struct super_block *sb)
> >>  		return;
> >>  
> >>  	if (!test_opt(sb, ERRORS_CONT)) {
> >> -		journal_t *journal = EXT4_SB(sb)->s_journal;
> >> +		journal_t *journal = sbi->s_journal;
> >>  
> >> -		EXT4_SB(sb)->s_mount_flags |= EXT4_MF_FS_ABORTED;
> >> +		sbi->s_mount_flags |= EXT4_MF_FS_ABORTED;
> >>  		if (journal)
> >>  			jbd2_journal_abort(journal, -EIO);
> >>  	}
> >> @@ -522,9 +524,8 @@ static void ext4_handle_error(struct super_block *sb)
> >>  		smp_wmb();
> >>  		sb->s_flags |= SB_RDONLY;
> >>  	} else if (test_opt(sb, ERRORS_PANIC)) {
> >> -		if (EXT4_SB(sb)->s_journal &&
> >> -		  !(EXT4_SB(sb)->s_journal->j_flags & JBD2_REC_ERR))
> >> -			return;
> >> +		if (sbi->s_journal && is_journal_aborted(sbi->s_journal))
> >> +			wait_for_completion(&sbi->s_journal->j_record_errno);
> >>  		panic("EXT4-fs (device %s): panic forced after error\n",
> >>  			sb->s_id);
> >>  	}
> >> @@ -710,10 +711,11 @@ void __ext4_std_error(struct super_block *sb, const char *function,
> >>  void __ext4_abort(struct super_block *sb, const char *function,
> >>  		  unsigned int line, int error, const char *fmt, ...)
> >>  {
> >> +	struct ext4_sb_info *sbi = EXT4_SB(sb);
> >>  	struct va_format vaf;
> >>  	va_list args;
> >>  
> >> -	if (unlikely(ext4_forced_shutdown(EXT4_SB(sb))))
> >> +	if (unlikely(ext4_forced_shutdown(sbi)))
> >>  		return;
> >>  
> >>  	save_error_info(sb, error, 0, 0, function, line);
> >> @@ -726,20 +728,19 @@ void __ext4_abort(struct super_block *sb, const char *function,
> >>  
> >>  	if (sb_rdonly(sb) == 0) {
> >>  		ext4_msg(sb, KERN_CRIT, "Remounting filesystem read-only");
> >> -		EXT4_SB(sb)->s_mount_flags |= EXT4_MF_FS_ABORTED;
> >> +		sbi->s_mount_flags |= EXT4_MF_FS_ABORTED;
> >>  		/*
> >>  		 * Make sure updated value of ->s_mount_flags will be visible
> >>  		 * before ->s_flags update
> >>  		 */
> >>  		smp_wmb();
> >>  		sb->s_flags |= SB_RDONLY;
> >> -		if (EXT4_SB(sb)->s_journal)
> >> -			jbd2_journal_abort(EXT4_SB(sb)->s_journal, -EIO);
> >> +		if (sbi->s_journal)
> >> +			jbd2_journal_abort(sbi->s_journal, -EIO);
> >>  	}
> >>  	if (test_opt(sb, ERRORS_PANIC) && !system_going_down()) {
> >> -		if (EXT4_SB(sb)->s_journal &&
> >> -		  !(EXT4_SB(sb)->s_journal->j_flags & JBD2_REC_ERR))
> >> -			return;
> >> +		if (sbi->s_journal && is_journal_aborted(sbi->s_journal))
> >> +			wait_for_completion(&sbi->s_journal->j_record_errno);
> >>  		panic("EXT4-fs panic from previous error\n");
> >>  	}
> >>  }
> >> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> >> index a49d0e670ddf..b8acdb2f7ac7 100644
> >> --- a/fs/jbd2/journal.c
> >> +++ b/fs/jbd2/journal.c
> >> @@ -1140,6 +1140,7 @@ static journal_t *journal_init_common(struct block_device *bdev,
> >>  	init_waitqueue_head(&journal->j_wait_commit);
> >>  	init_waitqueue_head(&journal->j_wait_updates);
> >>  	init_waitqueue_head(&journal->j_wait_reserved);
> >> +	init_completion(&journal->j_record_errno);
> >>  	mutex_init(&journal->j_barrier);
> >>  	mutex_init(&journal->j_checkpoint_mutex);
> >>  	spin_lock_init(&journal->j_revoke_lock);
> >> @@ -2188,10 +2189,7 @@ void jbd2_journal_abort(journal_t *journal, int errno)
> >>  	 * layer could realise that a filesystem check is needed.
> >>  	 */
> >>  	jbd2_journal_update_sb_errno(journal);
> >> -
> >> -	write_lock(&journal->j_state_lock);
> >> -	journal->j_flags |= JBD2_REC_ERR;
> >> -	write_unlock(&journal->j_state_lock);
> >> +	complete_all(&journal->j_record_errno);
> >>  }
> >>  
> >>  /**
> >> diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
> >> index f613d8529863..0f623b0c347f 100644
> >> --- a/include/linux/jbd2.h
> >> +++ b/include/linux/jbd2.h
> >> @@ -765,6 +765,11 @@ struct journal_s
> >>  	 */
> >>  	int			j_errno;
> >>  
> >> +	/**
> >> +	 * @j_record_errno: complete to record errno in the journal superblock
> >> +	 */
> >> +	struct completion	j_record_errno;
> >> +
> >>  	/**
> >>  	 * @j_sb_buffer: The first part of the superblock buffer.
> >>  	 */
> >> @@ -1247,7 +1252,6 @@ JBD2_FEATURE_INCOMPAT_FUNCS(csum3,		CSUM_V3)
> >>  #define JBD2_ABORT_ON_SYNCDATA_ERR	0x040	/* Abort the journal on file
> >>  						 * data write error in ordered
> >>  						 * mode */
> >> -#define JBD2_REC_ERR	0x080	/* The errno in the sb has been recorded */
> >>  
> >>  /*
> >>   * Function declarations for the journaling transaction and buffer
> >> -- 
> >> 2.21.3
> >>
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
