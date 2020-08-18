Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0DA9248840
	for <lists+linux-ext4@lfdr.de>; Tue, 18 Aug 2020 16:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbgHROwK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 18 Aug 2020 10:52:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:56172 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726745AbgHROwH (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 18 Aug 2020 10:52:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B2F71AFC1;
        Tue, 18 Aug 2020 14:52:31 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 2F9DA1E09FC; Tue, 18 Aug 2020 16:52:04 +0200 (CEST)
Date:   Tue, 18 Aug 2020 16:52:04 +0200
From:   Jan Kara <jack@suse.cz>
To:     Mauricio Faria de Oliveira <mfo@canonical.com>
Cc:     Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org,
        dann frazier <dann.frazier@canonical.com>,
        Mauricio Faria de Oliveira <mauricio.foliveira@gmail.com>,
        Jan Kara <jack@suse.com>
Subject: Re: [RFC PATCH v2 2/5] jbd2: introduce journal callbacks
 j_submit|finish_inode_data_buffers
Message-ID: <20200818145204.GC1902@quack2.suse.cz>
References: <20200810010210.3305322-1-mfo@canonical.com>
 <20200810010210.3305322-3-mfo@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200810010210.3305322-3-mfo@canonical.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sun 09-08-20 22:02:05, Mauricio Faria de Oliveira wrote:
> Add the callbacks as opt-in to override the default behavior for
> the transaction's inode list, instead of moving that code around.
> 
> This is important as not only ext4 uses the inode list: ocfs2 too,
> via jbd2_journal_inode_ranged_write(), and maybe out-of-tree code.

I'd prefer if the callback is called unconditionally, jbd2 exports the
callback that implements the current behavior and and both ext4 & ocfs2
are adapted to use this callback. We don't care about out of tree code.
That way things are cleaner long term...

> To opt-out of the default behavior (i.e., to do nothing), one has
> to opt-in with a no-op function.

Your Signed-off-by is missing for this patch.

> ---
>  fs/jbd2/commit.c     | 21 ++++++++++++++++-----
>  include/linux/jbd2.h | 21 ++++++++++++++++++++-
>  2 files changed, 36 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
> index 51f713089e35..b98d227b50d8 100644
> --- a/fs/jbd2/commit.c
> +++ b/fs/jbd2/commit.c
> @@ -237,10 +237,14 @@ static int journal_submit_data_buffers(journal_t *journal,
>  		 * instead of writepages. Because writepages can do
>  		 * block allocation  with delalloc. We need to write
>  		 * only allocated blocks here.
> +		 * This can be overriden with a custom callback.
>  		 */
>  		trace_jbd2_submit_inode_data(jinode->i_vfs_inode);
> -		err = journal_submit_inode_data_buffers(mapping, dirty_start,
> -				dirty_end);
> +		if (journal->j_submit_inode_data_buffers)
> +			err = journal->j_submit_inode_data_buffers(jinode);
> +		else
> +			err = journal_submit_inode_data_buffers(mapping,
> +					dirty_start, dirty_end);
>  		if (!ret)
>  			ret = err;
>  		spin_lock(&journal->j_list_lock);
> @@ -274,9 +278,16 @@ static int journal_finish_inode_data_buffers(journal_t *journal,
>  			continue;
>  		jinode->i_flags |= JI_COMMIT_RUNNING;
>  		spin_unlock(&journal->j_list_lock);
> -		err = filemap_fdatawait_range_keep_errors(
> -				jinode->i_vfs_inode->i_mapping, dirty_start,
> -				dirty_end);
> +		/*
> +		 * Wait for the inode data buffers writeout.
> +		 * This can be overriden with a custom callback.
> +		 */
> +		if (journal->j_finish_inode_data_buffers)
> +			err = journal->j_finish_inode_data_buffers(jinode);
> +		else
> +			err = filemap_fdatawait_range_keep_errors(
> +					jinode->i_vfs_inode->i_mapping,
> +					dirty_start, dirty_end);
>  		if (!ret)
>  			ret = err;
>  		spin_lock(&journal->j_list_lock);
> diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
> index d56128df2aff..24efe88eda1b 100644
> --- a/include/linux/jbd2.h
> +++ b/include/linux/jbd2.h
> @@ -628,7 +628,8 @@ struct transaction_s
>  	struct journal_head	*t_shadow_list;
>  
>  	/*
> -	 * List of inodes whose data we've modified in data=ordered mode.
> +	 * List of inodes whose data we've modified in data=ordered mode
> +	 * or whose pages we should write-protect in data=journaled mode.

I'd rather change the comment to generic "List of inodes associated with
the transaction. E.g. ext4 uses this to track inodes in data=ordered and
data=journal mode that need special handling on transaction commit.".

>  	 * [j_list_lock]
>  	 */
>  	struct list_head	t_inode_list;
> @@ -1110,6 +1111,24 @@ struct journal_s
>  	void			(*j_commit_callback)(journal_t *,
>  						     transaction_t *);
>  
> +	/**
> +	 * @j_submit_inode_data_buffers:
> +	 *
> +	 * This function is called before flushing metadata buffers.
> +	 * This overrides the default behavior (writeout data buffers.)
> +	 */

I'd change the comment to:
	 * This function is called for all inodes associated with the
	 * committing transaction marked with JI_WRITE_DATA flag before we
	 * start to write out the transaction to the journal.

> +	int			(*j_submit_inode_data_buffers)
> +					(struct jbd2_inode *);
> +
> +	/**
> +	 * @j_finish_inode_data_buffers:
> +	 *
> +	 * This function is called after flushing metadata buffers.
> +	 * This overrides the default behavior (wait writeout.)
> +	 */

And here:
	 * This function is called for all inodes associated with the
	 * committing transaction marked with JI_WAIT_DATA flag after we
	 * we have written the transaction to the journal but before we
	 * write out the commit block.


> +	int			(*j_finish_inode_data_buffers)
> +					(struct jbd2_inode *);
> +
>  	/*
>  	 * Journal statistics
>  	 */

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
