Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB5586F838F
	for <lists+linux-ext4@lfdr.de>; Fri,  5 May 2023 15:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbjEENMu (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 5 May 2023 09:12:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231788AbjEENMu (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 5 May 2023 09:12:50 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1522B1E986
        for <linux-ext4@vger.kernel.org>; Fri,  5 May 2023 06:12:49 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id BB24020006;
        Fri,  5 May 2023 13:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1683292367; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9igqpj2sU/InEuN4X7vT7HpGfKSp9kIAfPIPb5wkbQk=;
        b=ZEIVKSKea+gHwW6wEKI4Mqy8Hd2ShWk2mTBHBb/1OwuBof8PJi5mZ1mNwsX2jwVDxrVaOv
        mo95/f5i/8gl8VZxlWdED2mS4Gp2Ka0zuDOTqcSTVBTSX5zk+pvrkuO/kvWYsOX8D36P4d
        nyBaR8UQQtuCdffsefUTHrmJvYt3pnQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1683292367;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9igqpj2sU/InEuN4X7vT7HpGfKSp9kIAfPIPb5wkbQk=;
        b=ovOPkKVOh9R6SbVvnvtqIessCMoH7c5RCsDyKIeGL44L+WK01o4S4g/t3suZk8mjIOHRsT
        hIfBSSe1P1z3LiCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id ABB1313488;
        Fri,  5 May 2023 13:12:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id sbDbKc8AVWTsTQAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 05 May 2023 13:12:47 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 4A707A0729; Fri,  5 May 2023 15:12:47 +0200 (CEST)
Date:   Fri, 5 May 2023 15:12:47 +0200
From:   Jan Kara <jack@suse.cz>
To:     Zhang Yi <yi.zhang@huaweicloud.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, yi.zhang@huawei.com,
        yukuai3@huawei.com, chengzhihao1@huawei.com
Subject: Re: [PATCH v2 1/3] jbd2: recheck chechpointing non-dirty buffer
Message-ID: <20230505131247.hceuzekpqvyfyoya@quack3>
References: <20230505123219.4135141-1-yi.zhang@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230505123219.4135141-1-yi.zhang@huaweicloud.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri 05-05-23 20:32:17, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> There is a long-standing metadata corruption issue that happens from
> time to time, but it's very difficult to reproduce and analyse, benefit
> from the JBD2_CYCLE_RECORD option, we found out that the problem is the
> checkpointing process miss to write out some buffers which are raced by
> another do_get_write_access(). Looks below for detail.
> 
> jbd2_log_do_checkpoint() //transaction X
>  //buffer A is dirty and not belones to any transaction
>  __buffer_relink_io() //move it to the IO list
>  __flush_batch()
>   write_dirty_buffer()
>                              do_get_write_access()
>                              clear_buffer_dirty
>                              __jbd2_journal_file_buffer()
>                              //add buffer A to a new transaction Y
>    lock_buffer(bh)
>    //doesn't write out
>  __jbd2_journal_remove_checkpoint()
>  //finish checkpoint except buffer A
>  //filesystem corrupt if the new transaction Y isn't fully write out.
> 
> Due to the t_checkpoint_list walking loop in jbd2_log_do_checkpoint()
> have already handles waiting for buffers under IO and re-added new
> transaction to complete commit, and it also removing cleaned buffers,
> this makes sure the list will eventually get empty. So it's fine to
> leave buffers on the t_checkpoint_list while flushing out and completely
> stop using the t_checkpoint_io_list.
> 
> Cc: stable@vger.kernel.org
> Suggested-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> Tested-by: Zhihao Cheng <chengzhihao1@huawei.com>
> ---
> v1->v2:
>  - Leave flushing checkpointing buffers on the t_checkpoint_list and
>    stop using t_checkpoint_io_list.
> 
>  fs/jbd2/checkpoint.c | 94 +++++++++++---------------------------------
>  1 file changed, 23 insertions(+), 71 deletions(-)

Thanks for the fix! The patch looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> 
> diff --git a/fs/jbd2/checkpoint.c b/fs/jbd2/checkpoint.c
> index 51bd38da21cd..ae1ebfb8bc86 100644
> --- a/fs/jbd2/checkpoint.c
> +++ b/fs/jbd2/checkpoint.c
> @@ -57,28 +57,6 @@ static inline void __buffer_unlink(struct journal_head *jh)
>  	}
>  }
>  
> -/*
> - * Move a buffer from the checkpoint list to the checkpoint io list
> - *
> - * Called with j_list_lock held
> - */
> -static inline void __buffer_relink_io(struct journal_head *jh)
> -{
> -	transaction_t *transaction = jh->b_cp_transaction;
> -
> -	__buffer_unlink_first(jh);
> -
> -	if (!transaction->t_checkpoint_io_list) {
> -		jh->b_cpnext = jh->b_cpprev = jh;
> -	} else {
> -		jh->b_cpnext = transaction->t_checkpoint_io_list;
> -		jh->b_cpprev = transaction->t_checkpoint_io_list->b_cpprev;
> -		jh->b_cpprev->b_cpnext = jh;
> -		jh->b_cpnext->b_cpprev = jh;
> -	}
> -	transaction->t_checkpoint_io_list = jh;
> -}
> -
>  /*
>   * Check a checkpoint buffer could be release or not.
>   *
> @@ -183,6 +161,7 @@ __flush_batch(journal_t *journal, int *batch_count)
>  		struct buffer_head *bh = journal->j_chkpt_bhs[i];
>  		BUFFER_TRACE(bh, "brelse");
>  		__brelse(bh);
> +		journal->j_chkpt_bhs[i] = NULL;
>  	}
>  	*batch_count = 0;
>  }
> @@ -242,6 +221,11 @@ int jbd2_log_do_checkpoint(journal_t *journal)
>  		jh = transaction->t_checkpoint_list;
>  		bh = jh2bh(jh);
>  
> +		/*
> +		 * The buffer may be writing back, or flushing out in the
> +		 * last couple of cycles, or re-adding into a new transaction,
> +		 * need to check it again until it's unlocked.
> +		 */
>  		if (buffer_locked(bh)) {
>  			get_bh(bh);
>  			spin_unlock(&journal->j_list_lock);
> @@ -290,25 +274,25 @@ int jbd2_log_do_checkpoint(journal_t *journal)
>  			if (__jbd2_journal_remove_checkpoint(jh))
>  				/* The transaction was released; we're done */
>  				goto out;
> -			continue;
> +		} else {
> +			/*
> +			 * We are about to write the buffer, it could be
> +			 * raced by some other transaction shrink or buffer
> +			 * re-log logic once we release the j_list_lock,
> +			 * leave it on the checkpoint list and check status
> +			 * again to make sure it's clean.
> +			 */
> +			BUFFER_TRACE(bh, "queue");
> +			get_bh(bh);
> +			J_ASSERT_BH(bh, !buffer_jwrite(bh));
> +			journal->j_chkpt_bhs[batch_count++] = bh;
> +			transaction->t_chp_stats.cs_written++;
> +			transaction->t_checkpoint_list = jh->b_cpnext;
>  		}
> -		/*
> -		 * Important: we are about to write the buffer, and
> -		 * possibly block, while still holding the journal
> -		 * lock.  We cannot afford to let the transaction
> -		 * logic start messing around with this buffer before
> -		 * we write it to disk, as that would break
> -		 * recoverability.
> -		 */
> -		BUFFER_TRACE(bh, "queue");
> -		get_bh(bh);
> -		J_ASSERT_BH(bh, !buffer_jwrite(bh));
> -		journal->j_chkpt_bhs[batch_count++] = bh;
> -		__buffer_relink_io(jh);
> -		transaction->t_chp_stats.cs_written++;
> +
>  		if ((batch_count == JBD2_NR_BATCH) ||
> -		    need_resched() ||
> -		    spin_needbreak(&journal->j_list_lock))
> +		    need_resched() || spin_needbreak(&journal->j_list_lock) ||
> +		    jh2bh(transaction->t_checkpoint_list) == journal->j_chkpt_bhs[0])
>  			goto unlock_and_flush;
>  	}
>  
> @@ -322,38 +306,6 @@ int jbd2_log_do_checkpoint(journal_t *journal)
>  			goto restart;
>  	}
>  
> -	/*
> -	 * Now we issued all of the transaction's buffers, let's deal
> -	 * with the buffers that are out for I/O.
> -	 */
> -restart2:
> -	/* Did somebody clean up the transaction in the meanwhile? */
> -	if (journal->j_checkpoint_transactions != transaction ||
> -	    transaction->t_tid != this_tid)
> -		goto out;
> -
> -	while (transaction->t_checkpoint_io_list) {
> -		jh = transaction->t_checkpoint_io_list;
> -		bh = jh2bh(jh);
> -		if (buffer_locked(bh)) {
> -			get_bh(bh);
> -			spin_unlock(&journal->j_list_lock);
> -			wait_on_buffer(bh);
> -			/* the journal_head may have gone by now */
> -			BUFFER_TRACE(bh, "brelse");
> -			__brelse(bh);
> -			spin_lock(&journal->j_list_lock);
> -			goto restart2;
> -		}
> -
> -		/*
> -		 * Now in whatever state the buffer currently is, we
> -		 * know that it has been written out and so we can
> -		 * drop it from the list
> -		 */
> -		if (__jbd2_journal_remove_checkpoint(jh))
> -			break;
> -	}
>  out:
>  	spin_unlock(&journal->j_list_lock);
>  	result = jbd2_cleanup_journal_tail(journal);
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
