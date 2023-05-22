Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0F1370C2D4
	for <lists+linux-ext4@lfdr.de>; Mon, 22 May 2023 17:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbjEVP5E (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 22 May 2023 11:57:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbjEVP5D (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 22 May 2023 11:57:03 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D987B0
        for <linux-ext4@vger.kernel.org>; Mon, 22 May 2023 08:57:01 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 089BD21E1F;
        Mon, 22 May 2023 15:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1684771020; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ff6unVa8otGF4QfRWV6rJE5huov39A85EwPFJVIX9AM=;
        b=jRCJIgvBBe4mDoNNb69Z/TrIatgqXAkHv6m2LNrhIfJAKR4tpuh6vmQTIIZ9APHE6le1Eq
        P+kXPZKfUFs3aPheVrYgvPi/wIo3x9d9odkX0RKEbZHZUd811HP58c4xBLxiM6QhFNYKg+
        fUn33ut73p/IMApCpCFZH06Y2QzyLhM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1684771020;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ff6unVa8otGF4QfRWV6rJE5huov39A85EwPFJVIX9AM=;
        b=OXcQ0A8A/FDH99bxuoNNfWoFdNKOuXkV/5Xh4mvz4k2SkwOVzfvQZOQpWd5nRa8UKj4yDI
        yDXOnYBrOsiQEMCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id ECA0B13336;
        Mon, 22 May 2023 15:56:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id veW5OcuQa2Q6UgAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 22 May 2023 15:56:59 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 5AF3BA075B; Mon, 22 May 2023 17:56:59 +0200 (CEST)
Date:   Mon, 22 May 2023 17:56:59 +0200
From:   Jan Kara <jack@suse.cz>
To:     Zhang Yi <yi.zhang@huaweicloud.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, yi.zhang@huawei.com,
        yukuai3@huawei.com, chengzhihao1@huawei.com
Subject: Re: [PATCH v3 1/3] jbd2: recheck chechpointing non-dirty buffer
Message-ID: <20230522155659.bysqnuvzjemyjzch@quack3>
References: <20230516020226.2813588-1-yi.zhang@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230516020226.2813588-1-yi.zhang@huaweicloud.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue 16-05-23 10:02:24, Zhang Yi wrote:
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

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza


> ---
> v2->v3:
>  - Fix a NULL pointer issue caused by an !T_FINISHED checkpoint
>    transaction with empty checkpoint list.
> v1->v2:
>  - Leave flushing checkpointing buffers on the t_checkpoint_list and
>    stop using t_checkpoint_io_list.
> 
>  fs/jbd2/checkpoint.c | 102 ++++++++++++-------------------------------
>  1 file changed, 29 insertions(+), 73 deletions(-)
> 
> diff --git a/fs/jbd2/checkpoint.c b/fs/jbd2/checkpoint.c
> index 51bd38da21cd..25e3c20eb19f 100644
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
> @@ -287,28 +271,32 @@ int jbd2_log_do_checkpoint(journal_t *journal)
>  		}
>  		if (!buffer_dirty(bh)) {
>  			BUFFER_TRACE(bh, "remove from checkpoint");
> -			if (__jbd2_journal_remove_checkpoint(jh))
> -				/* The transaction was released; we're done */
> +			/*
> +			 * If the transaction was released or the checkpoint
> +			 * list was empty, we're done.
> +			 */
> +			if (__jbd2_journal_remove_checkpoint(jh) ||
> +			    !transaction->t_checkpoint_list)
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
> @@ -322,38 +310,6 @@ int jbd2_log_do_checkpoint(journal_t *journal)
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
