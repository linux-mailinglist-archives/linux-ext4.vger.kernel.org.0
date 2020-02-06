Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7FCFB154364
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Feb 2020 12:46:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727662AbgBFLqu (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 6 Feb 2020 06:46:50 -0500
Received: from mx2.suse.de ([195.135.220.15]:58394 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726538AbgBFLqu (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 6 Feb 2020 06:46:50 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 01135AD07;
        Thu,  6 Feb 2020 11:46:47 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 67F551E0E31; Thu,  6 Feb 2020 12:46:47 +0100 (CET)
Date:   Thu, 6 Feb 2020 12:46:47 +0100
From:   Jan Kara <jack@suse.cz>
To:     "zhangyi (F)" <yi.zhang@huawei.com>
Cc:     jack@suse.cz, tytso@mit.edu, linux-ext4@vger.kernel.org,
        luoshijie1@huawei.com, zhangxiaoxu5@huawei.com
Subject: Re: [PATCH 2/2] jbd2: do not clear the BH_Mapped flag when
 forgetting a metadata buffer
Message-ID: <20200206114647.GB3994@quack2.suse.cz>
References: <20200203140458.37397-1-yi.zhang@huawei.com>
 <20200203140458.37397-3-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200203140458.37397-3-yi.zhang@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon 03-02-20 22:04:58, zhangyi (F) wrote:
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
> For the metadata buffer we forgetting, clear the dirty flags is enough,
> so this patch add BH_Unmap flag for the journal_unmap_buffer() case and
> keep the mapped flag for the metadata buffer.
> 
> Fixes: 904cdbd41d74 ("jbd2: clear dirty flag when revoking a buffer from an older transaction")
> Signed-off-by: zhangyi (F) <yi.zhang@huawei.com>

Good spotting! Thanks for the patch. Some comments below:

> diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
> index 6396fe70085b..a649cdd1c5e5 100644
> --- a/fs/jbd2/commit.c
> +++ b/fs/jbd2/commit.c
> @@ -987,10 +987,13 @@ void jbd2_journal_commit_transaction(journal_t *journal)
>  		if (buffer_freed(bh) && !jh->b_next_transaction) {
>  			clear_buffer_freed(bh);
>  			clear_buffer_jbddirty(bh);
> -			clear_buffer_mapped(bh);
> -			clear_buffer_new(bh);
> -			clear_buffer_req(bh);
> -			bh->b_bdev = NULL;
> +			if (buffer_unmap(bh)) {
> +				clear_buffer_unmap(bh);
> +				clear_buffer_mapped(bh);
> +				clear_buffer_new(bh);
> +				clear_buffer_req(bh);
> +				bh->b_bdev = NULL;
> +			}

Any reason why you don't want to clear buffer_req and buffer_new flags for
all buffers as well? I agree that b_bdev setting and buffer_mapped need
special treatment.

Also rather than introducing this new buffer_unmap bit, I'd use the fact
this special treatment is needed only for buffers coming from the block device
mapping. And we can check for that like:

		/*
		 * We can (and need to) unmap buffer only for normal mappings.
		 * Block device buffers need to stay mapped all the time.
		 * We need to be careful about the check because the page
		 * mapping can get cleared under our hands.
		 */
		mapping = READ_ONCE(bh->b_page->mapping);
		if (mapping && !sb_is_blkdev_sb(mapping->host->i_sb)) {
			...
		}

Longer term, we might want to rework how the handling of truncated buffers
works with JDB2. There's lots of duplication between jbd2_journal_forget()
and jbd2_journal_unmap_buffer(), the dirtiness is tracked in jh->b_modified
as well as buffer_jbddirty() and it is further redundant with the journal
list the buffer is currently on. So I suspect it could all be simplified if
we took a fresh look at things.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
