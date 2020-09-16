Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9885126CD1A
	for <lists+linux-ext4@lfdr.de>; Wed, 16 Sep 2020 22:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbgIPUxo (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 16 Sep 2020 16:53:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:44524 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726600AbgIPQyH (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 16 Sep 2020 12:54:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A3868B45D;
        Wed, 16 Sep 2020 16:19:39 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 1AAD61E12E1; Wed, 16 Sep 2020 18:19:24 +0200 (CEST)
Date:   Wed, 16 Sep 2020 18:19:24 +0200
From:   Jan Kara <jack@suse.cz>
To:     Mauricio Faria de Oliveira <mfo@canonical.com>
Cc:     Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org,
        dann frazier <dann.frazier@canonical.com>,
        Mauricio Faria de Oliveira <mauricio.foliveira@gmail.com>
Subject: Re: [RFC PATCH v3 1/3] jbd2: introduce/export functions
 jbd2_journal_submit|finish_inode_data_buffers()
Message-ID: <20200916161924.GL3607@quack2.suse.cz>
References: <20200910193127.276214-1-mfo@canonical.com>
 <20200910193127.276214-2-mfo@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200910193127.276214-2-mfo@canonical.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu 10-09-20 16:31:25, Mauricio Faria de Oliveira wrote:
> Export functions that implement the current behavior done
> for an inode in journal_submit|finish_inode_data_buffers().
> 
> No functional change.
> 
> Signed-off-by: Mauricio Faria de Oliveira <mfo@canonical.com>
> Suggested-by: Jan Kara <jack@suse.cz>

The patch looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/jbd2/commit.c     | 32 +++++++++++++++++---------------
>  fs/jbd2/journal.c    |  2 ++
>  include/linux/jbd2.h |  4 ++++
>  3 files changed, 23 insertions(+), 15 deletions(-)
> 
> diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
> index 6d2da8ad0e6f..c17cda96926e 100644
> --- a/fs/jbd2/commit.c
> +++ b/fs/jbd2/commit.c
> @@ -187,9 +187,11 @@ static int journal_wait_on_commit_record(journal_t *journal,
>   * use writepages() because with delayed allocation we may be doing
>   * block allocation in writepages().
>   */
> -static int journal_submit_inode_data_buffers(struct address_space *mapping,
> -		loff_t dirty_start, loff_t dirty_end)
> +int jbd2_journal_submit_inode_data_buffers(struct jbd2_inode *jinode)
>  {
> +	struct address_space *mapping = jinode->i_vfs_inode->i_mapping;
> +	loff_t dirty_start = jinode->i_dirty_start;
> +	loff_t dirty_end = jinode->i_dirty_end;
>  	int ret;
>  	struct writeback_control wbc = {
>  		.sync_mode =  WB_SYNC_ALL,
> @@ -215,16 +217,11 @@ static int journal_submit_data_buffers(journal_t *journal,
>  {
>  	struct jbd2_inode *jinode;
>  	int err, ret = 0;
> -	struct address_space *mapping;
>  
>  	spin_lock(&journal->j_list_lock);
>  	list_for_each_entry(jinode, &commit_transaction->t_inode_list, i_list) {
> -		loff_t dirty_start = jinode->i_dirty_start;
> -		loff_t dirty_end = jinode->i_dirty_end;
> -
>  		if (!(jinode->i_flags & JI_WRITE_DATA))
>  			continue;
> -		mapping = jinode->i_vfs_inode->i_mapping;
>  		jinode->i_flags |= JI_COMMIT_RUNNING;
>  		spin_unlock(&journal->j_list_lock);
>  		/*
> @@ -234,8 +231,7 @@ static int journal_submit_data_buffers(journal_t *journal,
>  		 * only allocated blocks here.
>  		 */
>  		trace_jbd2_submit_inode_data(jinode->i_vfs_inode);
> -		err = journal_submit_inode_data_buffers(mapping, dirty_start,
> -				dirty_end);
> +		err = jbd2_journal_submit_inode_data_buffers(jinode);
>  		if (!ret)
>  			ret = err;
>  		spin_lock(&journal->j_list_lock);
> @@ -248,6 +244,17 @@ static int journal_submit_data_buffers(journal_t *journal,
>  	return ret;
>  }
>  
> +int jbd2_journal_finish_inode_data_buffers(struct jbd2_inode *jinode)
> +{
> +	struct address_space *mapping = jinode->i_vfs_inode->i_mapping;
> +	loff_t dirty_start = jinode->i_dirty_start;
> +	loff_t dirty_end = jinode->i_dirty_end;
> +	int ret;
> +
> +	ret = filemap_fdatawait_range_keep_errors(mapping, dirty_start, dirty_end);
> +	return ret;
> +}
> +
>  /*
>   * Wait for data submitted for writeout, refile inodes to proper
>   * transaction if needed.
> @@ -262,16 +269,11 @@ static int journal_finish_inode_data_buffers(journal_t *journal,
>  	/* For locking, see the comment in journal_submit_data_buffers() */
>  	spin_lock(&journal->j_list_lock);
>  	list_for_each_entry(jinode, &commit_transaction->t_inode_list, i_list) {
> -		loff_t dirty_start = jinode->i_dirty_start;
> -		loff_t dirty_end = jinode->i_dirty_end;
> -
>  		if (!(jinode->i_flags & JI_WAIT_DATA))
>  			continue;
>  		jinode->i_flags |= JI_COMMIT_RUNNING;
>  		spin_unlock(&journal->j_list_lock);
> -		err = filemap_fdatawait_range_keep_errors(
> -				jinode->i_vfs_inode->i_mapping, dirty_start,
> -				dirty_end);
> +		err = jbd2_journal_finish_inode_data_buffers(jinode);
>  		if (!ret)
>  			ret = err;
>  		spin_lock(&journal->j_list_lock);
> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> index 17fdc482f554..c0600405e7a2 100644
> --- a/fs/jbd2/journal.c
> +++ b/fs/jbd2/journal.c
> @@ -91,6 +91,8 @@ EXPORT_SYMBOL(jbd2_journal_try_to_free_buffers);
>  EXPORT_SYMBOL(jbd2_journal_force_commit);
>  EXPORT_SYMBOL(jbd2_journal_inode_ranged_write);
>  EXPORT_SYMBOL(jbd2_journal_inode_ranged_wait);
> +EXPORT_SYMBOL(jbd2_journal_submit_inode_data_buffers);
> +EXPORT_SYMBOL(jbd2_journal_finish_inode_data_buffers);
>  EXPORT_SYMBOL(jbd2_journal_init_jbd_inode);
>  EXPORT_SYMBOL(jbd2_journal_release_jbd_inode);
>  EXPORT_SYMBOL(jbd2_journal_begin_ordered_truncate);
> diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
> index 08f904943ab2..2865a5475888 100644
> --- a/include/linux/jbd2.h
> +++ b/include/linux/jbd2.h
> @@ -1421,6 +1421,10 @@ extern int	   jbd2_journal_inode_ranged_write(handle_t *handle,
>  extern int	   jbd2_journal_inode_ranged_wait(handle_t *handle,
>  			struct jbd2_inode *inode, loff_t start_byte,
>  			loff_t length);
> +extern int	   jbd2_journal_submit_inode_data_buffers(
> +			struct jbd2_inode *jinode);
> +extern int	   jbd2_journal_finish_inode_data_buffers(
> +			struct jbd2_inode *jinode);
>  extern int	   jbd2_journal_begin_ordered_truncate(journal_t *journal,
>  				struct jbd2_inode *inode, loff_t new_size);
>  extern void	   jbd2_journal_init_jbd_inode(struct jbd2_inode *jinode, struct inode *inode);
> -- 
> 2.17.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
