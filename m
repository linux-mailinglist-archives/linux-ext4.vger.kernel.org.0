Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8927112C10
	for <lists+linux-ext4@lfdr.de>; Wed,  4 Dec 2019 13:52:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727446AbfLDMwP (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 4 Dec 2019 07:52:15 -0500
Received: from mx2.suse.de ([195.135.220.15]:34442 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726832AbfLDMwP (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 4 Dec 2019 07:52:15 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 64CE5B33E;
        Wed,  4 Dec 2019 12:52:13 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 28B441E0B99; Wed,  4 Dec 2019 13:52:13 +0100 (CET)
Date:   Wed, 4 Dec 2019 13:52:13 +0100
From:   Jan Kara <jack@suse.cz>
To:     "zhangyi (F)" <yi.zhang@huawei.com>
Cc:     linux-ext4@vger.kernel.org, jack@suse.com, tytso@mit.edu,
        adilger.kernel@dilger.ca, liangyun2@huawei.com,
        luoshijie1@huawei.com
Subject: Re: [PATCH v3 2/4] ext4, jbd2: ensure panic when aborting with zero
 errno
Message-ID: <20191204125213.GG8206@quack2.suse.cz>
References: <20191204124614.45424-1-yi.zhang@huawei.com>
 <20191204124614.45424-3-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191204124614.45424-3-yi.zhang@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 04-12-19 20:46:12, zhangyi (F) wrote:
> JBD2_REC_ERR flag used to indicate the errno has been updated when jbd2
> aborted, and then __ext4_abort() and ext4_handle_error() can invoke
> panic if ERRORS_PANIC is specified. But if the journal has been aborted
> with zero errno, jbd2_journal_abort() didn't set this flag so we can
> no longer panic. Fix this by always record the proper errno in the
> journal superblock.
> 
> Fixes: 4327ba52afd03 ("ext4, jbd2: ensure entering into panic after recording an error in superblock")
> Signed-off-by: zhangyi (F) <yi.zhang@huawei.com>

Looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/jbd2/checkpoint.c |  2 +-
>  fs/jbd2/journal.c    | 15 ++++-----------
>  2 files changed, 5 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/jbd2/checkpoint.c b/fs/jbd2/checkpoint.c
> index a1909066bde6..62cf497f18eb 100644
> --- a/fs/jbd2/checkpoint.c
> +++ b/fs/jbd2/checkpoint.c
> @@ -164,7 +164,7 @@ void __jbd2_log_wait_for_space(journal_t *journal)
>  				       "journal space in %s\n", __func__,
>  				       journal->j_devname);
>  				WARN_ON(1);
> -				jbd2_journal_abort(journal, 0);
> +				jbd2_journal_abort(journal, -EIO);
>  			}
>  			write_lock(&journal->j_state_lock);
>  		} else {
> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> index 1c58859aa592..b2d6e7666d0f 100644
> --- a/fs/jbd2/journal.c
> +++ b/fs/jbd2/journal.c
> @@ -2118,12 +2118,10 @@ static void __journal_abort_soft (journal_t *journal, int errno)
>  
>  	__jbd2_journal_abort_hard(journal);
>  
> -	if (errno) {
> -		jbd2_journal_update_sb_errno(journal);
> -		write_lock(&journal->j_state_lock);
> -		journal->j_flags |= JBD2_REC_ERR;
> -		write_unlock(&journal->j_state_lock);
> -	}
> +	jbd2_journal_update_sb_errno(journal);
> +	write_lock(&journal->j_state_lock);
> +	journal->j_flags |= JBD2_REC_ERR;
> +	write_unlock(&journal->j_state_lock);
>  }
>  
>  /**
> @@ -2165,11 +2163,6 @@ static void __journal_abort_soft (journal_t *journal, int errno)
>   * failure to disk.  ext3_error, for example, now uses this
>   * functionality.
>   *
> - * Errors which originate from within the journaling layer will NOT
> - * supply an errno; a null errno implies that absolutely no further
> - * writes are done to the journal (unless there are any already in
> - * progress).
> - *
>   */
>  
>  void jbd2_journal_abort(journal_t *journal, int errno)
> -- 
> 2.17.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
