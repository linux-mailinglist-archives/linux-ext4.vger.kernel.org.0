Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC9915A6D5
	for <lists+linux-ext4@lfdr.de>; Wed, 12 Feb 2020 11:45:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727936AbgBLKpz (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 12 Feb 2020 05:45:55 -0500
Received: from mx2.suse.de ([195.135.220.15]:60818 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727535AbgBLKpz (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 12 Feb 2020 05:45:55 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 6B181ADC8;
        Wed, 12 Feb 2020 10:45:52 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 551D01E0E01; Wed, 12 Feb 2020 11:45:51 +0100 (CET)
Date:   Wed, 12 Feb 2020 11:45:51 +0100
From:   Jan Kara <jack@suse.cz>
To:     "zhangyi (F)" <yi.zhang@huawei.com>
Cc:     linux-ext4@vger.kernel.org, jack@suse.cz, tytso@mit.edu,
        luoshijie1@huawei.com, zhangxiaoxu5@huawei.com
Subject: Re: [PATCH v2 1/2] jbd2: move the clearing of b_modified flag to the
 journal_unmap_buffer()
Message-ID: <20200212104551.GF25573@quack2.suse.cz>
References: <20200211135500.40524-1-yi.zhang@huawei.com>
 <20200211135500.40524-2-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200211135500.40524-2-yi.zhang@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue 11-02-20 21:54:59, zhangyi (F) wrote:
> There is no need to delay the clearing of b_modified flag to the
> transaction committing time when unmapping the journalled buffer, so
> just move it to the journal_unmap_buffer().
> 
> Signed-off-by: zhangyi (F) <yi.zhang@huawei.com>

The patch looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/jbd2/commit.c      | 43 +++++++++++++++----------------------------
>  fs/jbd2/transaction.c | 10 ++++++----
>  2 files changed, 21 insertions(+), 32 deletions(-)
> 
> diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
> index 7f0b362b3842..ecc2ea5f1b59 100644
> --- a/fs/jbd2/commit.c
> +++ b/fs/jbd2/commit.c
> @@ -976,34 +976,21 @@ void jbd2_journal_commit_transaction(journal_t *journal)
>  		 * it. */
>  
>  		/*
> -		* A buffer which has been freed while still being journaled by
> -		* a previous transaction.
> -		*/
> -		if (buffer_freed(bh)) {
> -			/*
> -			 * If the running transaction is the one containing
> -			 * "add to orphan" operation (b_next_transaction !=
> -			 * NULL), we have to wait for that transaction to
> -			 * commit before we can really get rid of the buffer.
> -			 * So just clear b_modified to not confuse transaction
> -			 * credit accounting and refile the buffer to
> -			 * BJ_Forget of the running transaction. If the just
> -			 * committed transaction contains "add to orphan"
> -			 * operation, we can completely invalidate the buffer
> -			 * now. We are rather through in that since the
> -			 * buffer may be still accessible when blocksize <
> -			 * pagesize and it is attached to the last partial
> -			 * page.
> -			 */
> -			jh->b_modified = 0;
> -			if (!jh->b_next_transaction) {
> -				clear_buffer_freed(bh);
> -				clear_buffer_jbddirty(bh);
> -				clear_buffer_mapped(bh);
> -				clear_buffer_new(bh);
> -				clear_buffer_req(bh);
> -				bh->b_bdev = NULL;
> -			}
> +		 * A buffer which has been freed while still being journaled
> +		 * by a previous transaction, refile the buffer to BJ_Forget of
> +		 * the running transaction. If the just committed transaction
> +		 * contains "add to orphan" operation, we can completely
> +		 * invalidate the buffer now. We are rather through in that
> +		 * since the buffer may be still accessible when blocksize <
> +		 * pagesize and it is attached to the last partial page.
> +		 */
> +		if (buffer_freed(bh) && !jh->b_next_transaction) {
> +			clear_buffer_freed(bh);
> +			clear_buffer_jbddirty(bh);
> +			clear_buffer_mapped(bh);
> +			clear_buffer_new(bh);
> +			clear_buffer_req(bh);
> +			bh->b_bdev = NULL;
>  		}
>  
>  		if (buffer_jbddirty(bh)) {
> diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
> index 27b9f9dee434..0603dfa9ad90 100644
> --- a/fs/jbd2/transaction.c
> +++ b/fs/jbd2/transaction.c
> @@ -2329,14 +2329,16 @@ static int journal_unmap_buffer(journal_t *journal, struct buffer_head *bh,
>  			return -EBUSY;
>  		}
>  		/*
> -		 * OK, buffer won't be reachable after truncate. We just set
> -		 * j_next_transaction to the running transaction (if there is
> -		 * one) and mark buffer as freed so that commit code knows it
> -		 * should clear dirty bits when it is done with the buffer.
> +		 * OK, buffer won't be reachable after truncate. We just clear
> +		 * b_modified to not confuse transaction credit accounting, and
> +		 * set j_next_transaction to the running transaction (if there
> +		 * is one) and mark buffer as freed so that commit code knows
> +		 * it should clear dirty bits when it is done with the buffer.
>  		 */
>  		set_buffer_freed(bh);
>  		if (journal->j_running_transaction && buffer_jbddirty(bh))
>  			jh->b_next_transaction = journal->j_running_transaction;
> +		jh->b_modified = 0;
>  		spin_unlock(&journal->j_list_lock);
>  		spin_unlock(&jh->b_state_lock);
>  		write_unlock(&journal->j_state_lock);
> -- 
> 2.17.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
