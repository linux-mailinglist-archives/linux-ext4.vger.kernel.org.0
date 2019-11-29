Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2DCA10D743
	for <lists+linux-ext4@lfdr.de>; Fri, 29 Nov 2019 15:46:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbfK2OqO (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 29 Nov 2019 09:46:14 -0500
Received: from mx2.suse.de ([195.135.220.15]:60510 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726893AbfK2OqN (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 29 Nov 2019 09:46:13 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9F917B1CC;
        Fri, 29 Nov 2019 14:46:11 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 206CF1E0B7B; Fri, 29 Nov 2019 15:46:11 +0100 (CET)
Date:   Fri, 29 Nov 2019 15:46:11 +0100
From:   Jan Kara <jack@suse.cz>
To:     "zhangyi (F)" <yi.zhang@huawei.com>
Cc:     linux-ext4@vger.kernel.org, jack@suse.com, tytso@mit.edu,
        adilger.kernel@dilger.ca, liangyun2@huawei.com
Subject: Re: [PATCH] ext4, jbd2: ensure panic when there is no need to record
 errno in the jbd2 sb
Message-ID: <20191129144611.GA27588@quack2.suse.cz>
References: <20191126144537.30020-1-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191126144537.30020-1-yi.zhang@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue 26-11-19 22:45:37, zhangyi (F) wrote:
> JBD2_REC_ERR flag used to indicate the errno has been updated when jbd2
> aborted, and then __ext4_abort() and ext4_handle_error() can invoke
> panic if ERRORS_PANIC is specified. But there is one exception, if jbd2
> thread failed to submit commit record, it abort journal through
> invoking __jbd2_journal_abort_hard() without set this flag, so we can
> no longer panic. Fix this by set such flag even if there is no need to
> record errno in the jbd2 super block.
> 
> Fixes: 4327ba52afd03 ("ext4, jbd2: ensure entering into panic after recording an error in superblock")
> Signed-off-by: zhangyi (F) <yi.zhang@huawei.com>
> Cc: <stable@vger.kernel.org>

Thanks for the patch. This indeed looks like a bug. I was trying hard to
understand why are we actually using __jbd2_journal_abort_hard() in
fs/jbd2/commit.c in the first place. And after some digging, I think it is
an oversight and we should just use jbd2_journal_abort(). The calls have been
introduced by commit 818d276ceb83a "ext4: Add the journal checksum
feature". Before that commit, we were just using jbd2_journal_abort() when
writing commit block failed. And when we use jbd2_journal_abort() from
everywhere, that will also deal with the problem you've found.

Also as a nice cleanup we could then just drop __jbd2_journal_abort_hard(),
__jbd2_journal_abort_soft() and have all the functionality in a single
function jbd2_journal_abort().

								Honza

> ---
>  fs/ext4/super.c      |  4 ++--
>  fs/jbd2/journal.c    | 46 +++++++++++++++++++++++++++++---------------
>  include/linux/jbd2.h |  4 +++-
>  3 files changed, 36 insertions(+), 18 deletions(-)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index dd654e53ba3d..76cde5fb8207 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -482,7 +482,7 @@ static void ext4_handle_error(struct super_block *sb)
>  		sb->s_flags |= SB_RDONLY;
>  	} else if (test_opt(sb, ERRORS_PANIC)) {
>  		if (EXT4_SB(sb)->s_journal &&
> -		  !(EXT4_SB(sb)->s_journal->j_flags & JBD2_REC_ERR))
> +		  !(EXT4_SB(sb)->s_journal->j_flags & JBD2_ABORT_FINISHED))
>  			return;
>  		panic("EXT4-fs (device %s): panic forced after error\n",
>  			sb->s_id);
> @@ -701,7 +701,7 @@ void __ext4_abort(struct super_block *sb, const char *function,
>  	}
>  	if (test_opt(sb, ERRORS_PANIC) && !system_going_down()) {
>  		if (EXT4_SB(sb)->s_journal &&
> -		  !(EXT4_SB(sb)->s_journal->j_flags & JBD2_REC_ERR))
> +		  !(EXT4_SB(sb)->s_journal->j_flags & JBD2_ABORT_FINISHED))
>  			return;
>  		panic("EXT4-fs panic from previous error\n");
>  	}
> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> index 1c58859aa592..eb5e60df0da4 100644
> --- a/fs/jbd2/journal.c
> +++ b/fs/jbd2/journal.c
> @@ -2072,13 +2072,7 @@ int jbd2_journal_wipe(journal_t *journal, int write)
>   * Two internal functions, which provide abort to the jbd layer
>   * itself are here.
>   */
> -
> -/*
> - * Quick version for internal journal use (doesn't lock the journal).
> - * Aborts hard --- we mark the abort as occurred, but do _nothing_ else,
> - * and don't attempt to make any other journal updates.
> - */
> -void __jbd2_journal_abort_hard(journal_t *journal)
> +static void __jbd2_journal_abort(journal_t *journal)
>  {
>  	transaction_t *transaction;
>  
> @@ -2096,8 +2090,33 @@ void __jbd2_journal_abort_hard(journal_t *journal)
>  	write_unlock(&journal->j_state_lock);
>  }
>  
> -/* Soft abort: record the abort error status in the journal superblock,
> - * but don't do any other IO. */
> +/*
> + * Mark journal abort finished when the errno in the sb has been recorded
> + * or no need to record.
> + */
> +static void __jbd2_journal_finish_abort(journal_t *journal)
> +{
> +	write_lock(&journal->j_state_lock);
> +	journal->j_flags |= JBD2_ABORT_FINISHED;
> +	write_unlock(&journal->j_state_lock);
> +}
> +
> +/*
> + * Quick version for internal journal use (doesn't lock the journal).
> + * Aborts hard --- we mark the abort as occurred, but do _nothing_ else,
> + * and don't attempt to make any other journal updates.
> + */
> +void __jbd2_journal_abort_hard(journal_t *journal)
> +{
> +	/* Nothing need to be recorded, mark it as finished directly */
> +	__jbd2_journal_abort(journal);
> +	__jbd2_journal_finish_abort(journal);
> +}
> +
> +/*
> + * Soft abort: record the abort error status in the journal superblock,
> + * but don't do any other IO.
> + */
>  static void __journal_abort_soft (journal_t *journal, int errno)
>  {
>  	int old_errno;
> @@ -2116,14 +2135,11 @@ static void __journal_abort_soft (journal_t *journal, int errno)
>  	}
>  	write_unlock(&journal->j_state_lock);
>  
> -	__jbd2_journal_abort_hard(journal);
> +	__jbd2_journal_abort(journal);
>  
> -	if (errno) {
> +	if (errno)
>  		jbd2_journal_update_sb_errno(journal);
> -		write_lock(&journal->j_state_lock);
> -		journal->j_flags |= JBD2_REC_ERR;
> -		write_unlock(&journal->j_state_lock);
> -	}
> +	__jbd2_journal_finish_abort(journal);
>  }
>  
>  /**
> diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
> index 603fbc4e2f70..870f7f2f912c 100644
> --- a/include/linux/jbd2.h
> +++ b/include/linux/jbd2.h
> @@ -1248,7 +1248,9 @@ JBD2_FEATURE_INCOMPAT_FUNCS(csum3,		CSUM_V3)
>  #define JBD2_ABORT_ON_SYNCDATA_ERR	0x040	/* Abort the journal on file
>  						 * data write error in ordered
>  						 * mode */
> -#define JBD2_REC_ERR	0x080	/* The errno in the sb has been recorded */
> +#define JBD2_ABORT_FINISHED		0x080	/* Abort finished, the errno
> +						 * in the sb has been recorded
> +						 * if necessary */
>  
>  /*
>   * Function declarations for the journaling transaction and buffer
> -- 
> 2.17.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
