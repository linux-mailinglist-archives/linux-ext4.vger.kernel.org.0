Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F7CA160EB8
	for <lists+linux-ext4@lfdr.de>; Mon, 17 Feb 2020 10:36:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728942AbgBQJgt (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 17 Feb 2020 04:36:49 -0500
Received: from mx2.suse.de ([195.135.220.15]:52564 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728698AbgBQJgt (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 17 Feb 2020 04:36:49 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D592AB3EA;
        Mon, 17 Feb 2020 09:36:46 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id A91F21E0D47; Mon, 17 Feb 2020 10:36:45 +0100 (CET)
Date:   Mon, 17 Feb 2020 10:36:45 +0100
From:   Jan Kara <jack@suse.cz>
To:     "zhangyi (F)" <yi.zhang@huawei.com>
Cc:     jack@suse.cz, tytso@mit.edu, linux-ext4@vger.kernel.org,
        luoshijie1@huawei.com, zhangxiaoxu5@huawei.com
Subject: Re: [PATCH v3 2/2] jbd2: do not clear the BH_Mapped flag when
 forgetting a metadata buffer
Message-ID: <20200217093645.GC12032@quack2.suse.cz>
References: <20200213063821.30455-1-yi.zhang@huawei.com>
 <20200213063821.30455-3-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200213063821.30455-3-yi.zhang@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu 13-02-20 14:38:21, zhangyi (F) wrote:
> Commit 904cdbd41d74 ("jbd2: clear dirty flag when revoking a buffer from
> an older transaction") set the BH_Freed flag when forgetting a metadata
> buffer which belongs to the committing transaction, it indicate the
> committing process clear dirty bits when it is done with the buffer. But
> it also clear the BH_Mapped flag at the same time, which may trigger
> below NULL pointer oops when block_size < PAGE_SIZE.
> 
> rmdir 1             kjournald2                 mkdir 2
>                     jbd2_journal_commit_transaction
> 		    commit transaction N
> jbd2_journal_forget
> set_buffer_freed(bh1)
>                     jbd2_journal_commit_transaction
>                      commit transaction N+1
>                      ...
>                      clear_buffer_mapped(bh1)
>                                                ext4_getblk(bh2 ummapped)
>                                                ...
>                                                grow_dev_page
>                                                 init_page_buffers
>                                                  bh1->b_private=NULL
>                                                  bh2->b_private=NULL
>                      jbd2_journal_put_journal_head(jh1)
>                       __journal_remove_journal_head(hb1)
> 		       jh1 is NULL and trigger oops
> 
> *) Dir entry block bh1 and bh2 belongs to one page, and the bh2 has
>    already been unmapped.
> 
> For the metadata buffer we forgetting, we should always keep the mapped
> flag and clear the dirty flags is enough, so this patch pick out the
> these buffers and keep their BH_Mapped flag.
> 
> Fixes: 904cdbd41d74 ("jbd2: clear dirty flag when revoking a buffer from an older transaction")
> Signed-off-by: zhangyi (F) <yi.zhang@huawei.com>
> ---
>  fs/jbd2/commit.c | 25 +++++++++++++++++++++----
>  1 file changed, 21 insertions(+), 4 deletions(-)

Thanks! The patch looks good. I have just some comment reformulation
suggestion below, otherwise feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

> diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
> index 6396fe70085b..27373f5792a4 100644
> --- a/fs/jbd2/commit.c
> +++ b/fs/jbd2/commit.c
> @@ -985,12 +985,29 @@ void jbd2_journal_commit_transaction(journal_t *journal)
>  		 * pagesize and it is attached to the last partial page.
>  		 */
>  		if (buffer_freed(bh) && !jh->b_next_transaction) {
> +			struct address_space *mapping;
> +
>  			clear_buffer_freed(bh);
>  			clear_buffer_jbddirty(bh);
> -			clear_buffer_mapped(bh);
> -			clear_buffer_new(bh);
> -			clear_buffer_req(bh);
> -			bh->b_bdev = NULL;
> +
> +			/*
> +			 * Block device buffers need to stay mapped all the
> +			 * time, so it is enough to clear buffer_jbddirty and
> +			 * buffer_freed bits. For the file mapping buffers (i.e.
> +			 * journalled data) we need to unmap buffer and clear
> +			 * more bits. We also need to be careful about the check
> +			 * because the data page mapping can get cleared under
> +			 * out hands, which alse need not to clear more bits
			   ^^^ our    ^^^^ Maybe I'd rephrase this like:

... under our hands. Note that if mapping == NULL, we don't need to make
buffer unmapped because the page is already detached from the mapping and
buffers cannot get reused.

> +			 * because the page and buffers will be freed and can
> +			 * never be reused once we are done with them.
> +			 */
> +			mapping = READ_ONCE(bh->b_page->mapping);
> +			if (mapping && !sb_is_blkdev_sb(mapping->host->i_sb)) {
> +				clear_buffer_mapped(bh);
> +				clear_buffer_new(bh);
> +				clear_buffer_req(bh);
> +				bh->b_bdev = NULL;
> +			}
>  		}

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
