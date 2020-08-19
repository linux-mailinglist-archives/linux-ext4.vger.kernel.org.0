Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F25D249863
	for <lists+linux-ext4@lfdr.de>; Wed, 19 Aug 2020 10:44:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbgHSIoY (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 19 Aug 2020 04:44:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:47280 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725903AbgHSIoX (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 19 Aug 2020 04:44:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E5781B669;
        Wed, 19 Aug 2020 08:44:47 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 59D421E1312; Wed, 19 Aug 2020 10:44:21 +0200 (CEST)
Date:   Wed, 19 Aug 2020 10:44:21 +0200
From:   Jan Kara <jack@suse.cz>
To:     Mauricio Faria de Oliveira <mfo@canonical.com>
Cc:     Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org,
        dann frazier <dann.frazier@canonical.com>,
        Mauricio Faria de Oliveira <mauricio.foliveira@gmail.com>,
        Jan Kara <jack@suse.com>
Subject: Re: [RFC PATCH v2 3/5] ext4: data=journal: write-protect pages on
 submit inode data buffers callback
Message-ID: <20200819084421.GD1902@quack2.suse.cz>
References: <20200810010210.3305322-1-mfo@canonical.com>
 <20200810010210.3305322-4-mfo@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200810010210.3305322-4-mfo@canonical.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sun 09-08-20 22:02:06, Mauricio Faria de Oliveira wrote:
> This implements the journal's j_submit_inode_data_buffers() callback
> to write-protect the inode's pages with write_cache_pages(), and use
> a writepage callback to redirty pages with buffers that are not part
> of the committing transaction or the next transaction.
> 
> And set a no-op function as j_finish_inode_data_buffers() callback
> (nothing needed other than the write-protect above.)
> 
> Currently, the inode is added to the transaction's inode list in the
> __ext4_journalled_writepage() function.
> ---
>  fs/ext4/inode.c |  4 +++
>  fs/ext4/super.c | 65 +++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 69 insertions(+)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 10dd470876b3..978ccde8454f 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -1911,6 +1911,10 @@ static int __ext4_journalled_writepage(struct page *page,
>  		err = ext4_walk_page_buffers(handle, page_bufs, 0, len, NULL,
>  					     write_end_fn);
>  	}
> +	if (ret == 0)
> +		ret = err;
> +	// XXX: is this correct for inline data inodes?

Inodes with inline data should never get here. The thing is that when a
file with inline data is faulted for writing, ext4_page_mkwrite() converts
the file to normal data format. And ordinary write(2) will directly update
the inline data and clear the page dirty bit so writepage isn't called for
it.

> +	err = ext4_jbd2_inode_add_write(handle, inode, 0, len);
>  	if (ret == 0)
>  		ret = err;
>  	EXT4_I(inode)->i_datasync_tid = handle->h_transaction->t_tid;
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 330957ed1f05..38aaac6572ea 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -472,6 +472,66 @@ static void ext4_journal_commit_callback(journal_t *journal, transaction_t *txn)
>  	spin_unlock(&sbi->s_md_lock);
>  }
>  
> +/*
> + * This writepage callback for write_cache_pages()
> + * takes care of a few cases after page cleaning.
> + *
> + * write_cache_pages() already checks for dirty pages
> + * and calls clear_page_dirty_for_io(), which we want,
> + * to write protect the pages.
> + *
> + * However, we have to redirty a page in two cases:
> + * 1) some buffer is not part of the committing transaction
> + * 2) some buffer already has b_next_transaction set
> + */
> +
> +static int ext4_journalled_writepage_callback(struct page *page,
> +					      struct writeback_control *wbc,
> +					      void *data)
> +{
> +	transaction_t *transaction = (transaction_t *) data;
> +	struct buffer_head *bh, *head;
> +	struct journal_head *jh;
> +
> +	// XXX: any chance of !bh here?

No. In ext4, whenever a page is dirty, it should have buffers attached.

> +	bh = head = page_buffers(page);
> +	do {
> +		jh = bh2jh(bh);
> +		if (!jh || jh->b_transaction != transaction ||
> +		    jh->b_next_transaction) {
> +			redirty_page_for_writepage(wbc, page);
> +			goto out;
> +		}
> +	} while ((bh = bh->b_this_page) != head);
> +
> +out:
> +	return AOP_WRITEPAGE_ACTIVATE;
> +}
> +
> +static int ext4_journalled_submit_inode_data_buffers(struct jbd2_inode *jinode)
> +{
> +	struct address_space *mapping = jinode->i_vfs_inode->i_mapping;
> +	transaction_t *transaction = jinode->i_transaction;
> +	loff_t dirty_start = jinode->i_dirty_start;
> +	loff_t dirty_end = jinode->i_dirty_end;
> +
> +	struct writeback_control wbc = {
> +		.sync_mode =  WB_SYNC_ALL,
> +		.nr_to_write = mapping->nrpages * 2,

For WB_SYNC_ALL writeback, .nr_to_write is mostly ignored so just set it to
~0ULL.

> +		.range_start = dirty_start,
> +		.range_end = dirty_end,
> +        };
> +
> +	return write_cache_pages(mapping, &wbc,
> +				 ext4_journalled_writepage_callback,
> +				 transaction);

I was thinking about this and we may need to do this somewhat differently.
I've realized that there's the slight trouble that we now use page dirty
bit for two purposes in data=journal mode - to track pages that need write
protection during commit and also to track pages which have buffers that
need checkpointing. And this mixing is making things complex. So I was
thinking that we could simply leave PageDirty bit for checkpointing
purposes and always make sure buffers are appropriately attached to a
transaction as dirty in ext4_page_mkwrite(). This will make mmap writes in
data=journal mode somewhat less efficient (all the pages written through
mmap while transaction T was running will be written to the journal during
transaction T commit while currently, we write only pages that also went
through __ext4_journalled_writepage() while T was running which usually
happens less frequently). But the code should be simpler and we don't care
about mmap write performance for data=journal mode much. Furthermore I
don't think that the tricks with PageChecked logic we play in data=journal
mode are really needed as well which should bring further simplifications.
I'll try to code this cleanup.

Then in ext4_journalled_submit_inode_data_buffers() we would need to walk
all the pages in the range describe by jinode and call page_mkclean() for
each page which has buffer attached to the committing transaction.

> +}
> +
> +static int ext4_journalled_finish_inode_data_buffers(struct jbd2_inode *jinode)
> +{
> +	return 0;
> +}
> +
>  static bool system_going_down(void)
>  {
>  	return system_state == SYSTEM_HALT || system_state == SYSTEM_POWER_OFF
> @@ -4599,6 +4659,11 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
>  		ext4_msg(sb, KERN_ERR, "can't mount with "
>  			"journal_async_commit in data=ordered mode");
>  		goto failed_mount_wq;
> +	} else if (test_opt(sb, DATA_FLAGS) == EXT4_MOUNT_JOURNAL_DATA) {
> +		sbi->s_journal->j_submit_inode_data_buffers =
> +			ext4_journalled_submit_inode_data_buffers;
> +		sbi->s_journal->j_finish_inode_data_buffers =
> +			ext4_journalled_finish_inode_data_buffers;

We can journal data only for individual inodes (when inode has journal_data
flag set). So you have to set the callback unconditionally here and only in
the callback decide what to do with the particular inode based on what
ext4_should_journal_data() tells about the inode.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
