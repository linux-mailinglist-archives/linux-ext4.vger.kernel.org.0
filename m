Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54DDF6F5B83
	for <lists+linux-ext4@lfdr.de>; Wed,  3 May 2023 17:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbjECPu2 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 3 May 2023 11:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbjECPu0 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 3 May 2023 11:50:26 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BB1B6EB9
        for <linux-ext4@vger.kernel.org>; Wed,  3 May 2023 08:50:14 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id F100C204F3;
        Wed,  3 May 2023 15:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1683129012; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ivDEPmX8csaA5TQmloN1jtL3lvGXw/MilA49W6c0p6I=;
        b=WSOIDI6hx2lbfCcCd4Mzfuo7imWg3U1OsEnedKj0eIr6HAY0aAXguglh2alw6dohObKpED
        m8kGZz7mOHcD9lA/iQz7u8VANOm5lpAbIfvUhjKEiBQ3N/WYYof4DzMMEQbDo10hFnNlpV
        htXxaLMX7aCmFBWtv/OG+iXY5/IVry0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1683129013;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ivDEPmX8csaA5TQmloN1jtL3lvGXw/MilA49W6c0p6I=;
        b=KemmlUIENxWD8MNJ9JcWOYwpqujRcET2wZfA9vWGT3e+HVi058ovXKvTzXovGeVs1gQOOj
        oO743IDt2D0S/oBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E019013584;
        Wed,  3 May 2023 15:50:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id pX+zNrSCUmQBcgAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 03 May 2023 15:50:12 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 5D74AA0744; Wed,  3 May 2023 17:50:12 +0200 (CEST)
Date:   Wed, 3 May 2023 17:50:12 +0200
From:   Jan Kara <jack@suse.cz>
To:     Zhang Yi <yi.zhang@huaweicloud.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, yi.zhang@huawei.com,
        yukuai3@huawei.com, chengzhihao1@huawei.com
Subject: Re: [PATCH] jbd2: recheck chechpointing non-dirty buffer
Message-ID: <20230503155012.37ysqzd7b6fquulf@quack3>
References: <20230426131041.1004383-1-yi.zhang@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230426131041.1004383-1-yi.zhang@huaweicloud.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 26-04-23 21:10:41, Zhang Yi wrote:
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
> The fix is subtle because we can't trust the chechpointing buffers and
> transactions once we release the j_list_lock, they could be written back
> and checkpointed by some others, or they could have been added to a new
> transaction. So we have to re-add them on the checkpoint list and
> recheck their status if they are clean and don't need to write out.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> Tested-by: Zhihao Cheng <chengzhihao1@huawei.com>

Thanks for the analysis. This indeed looks like a nasty issue to debug.  I
think we can actually solve the problem by simplifying the checkpointing
code in jbd2_log_do_checkpoint(), not by making it more complex. What I
think we can do is that we can completely remove the t_checkpoint_io_list
and only keep buffers on t_checkpoint_list. When processing
t_checkpoint_list in jbd2_log_do_checkpoint(), we just need to make sure to
move t_checkpoint_list pointer to the next buffer when adding buffer to
j_chkpt_bhs array. That way buffers to submit / already submitted buffers
will be accumulating at the tail of the list. The logic in the loop already
handles waiting for buffers under IO / removing cleaned buffers so this
makes sure the list will eventually get empty. Buffers cannot get redirtied
without being removed from the checkpoint list and moved to a newer
transaction's checkpoint list so forward progress is guaranteed. The only
other tweak we need to add is to check for the situation when all the
buffers are in the j_chkpt_bhs array. So the end of the loop should look
like:

		transaction->t_checkpoint_list = jh->j_cpnext;
		if (batch_count == JBD2_NR_BATCH || need_resched() ||
		    spin_needbreak(&journal->j_list_lock) ||
		    transaction->t_checkpoint_list == journal->j_chkpt_bhs[0])
			flush and restart

and that should be it. What do you think?

								Honza

> diff --git a/fs/jbd2/checkpoint.c b/fs/jbd2/checkpoint.c
> index 51bd38da21cd..1aca860eb0f6 100644
> --- a/fs/jbd2/checkpoint.c
> +++ b/fs/jbd2/checkpoint.c
> @@ -77,8 +77,31 @@ static inline void __buffer_relink_io(struct journal_head *jh)
>  		jh->b_cpnext->b_cpprev = jh;
>  	}
>  	transaction->t_checkpoint_io_list = jh;
> +	transaction->t_chp_stats.cs_written++;
>  }
>  
> +/*
> + * Move a buffer from the checkpoint io list back to the checkpoint list
> + *
> + * Called with j_list_lock held
> + */
> +static inline void __buffer_relink_cp(struct journal_head *jh)
> +{
> +	transaction_t *transaction = jh->b_cp_transaction;
> +
> +	__buffer_unlink(jh);
> +
> +	if (!transaction->t_checkpoint_list) {
> +		jh->b_cpnext = jh->b_cpprev = jh;
> +	} else {
> +		jh->b_cpnext = transaction->t_checkpoint_list;
> +		jh->b_cpprev = transaction->t_checkpoint_list->b_cpprev;
> +		jh->b_cpprev->b_cpnext = jh;
> +		jh->b_cpnext->b_cpprev = jh;
> +	}
> +	transaction->t_checkpoint_list = jh;
> +	transaction->t_chp_stats.cs_written--;
> +}
>  /*
>   * Check a checkpoint buffer could be release or not.
>   *
> @@ -175,8 +198,31 @@ __flush_batch(journal_t *journal, int *batch_count)
>  	struct blk_plug plug;
>  
>  	blk_start_plug(&plug);
> -	for (i = 0; i < *batch_count; i++)
> -		write_dirty_buffer(journal->j_chkpt_bhs[i], REQ_SYNC);
> +	for (i = 0; i < *batch_count; i++) {
> +		struct buffer_head *bh = journal->j_chkpt_bhs[i];
> +		struct journal_head *jh = bh2jh(bh);
> +
> +		lock_buffer(bh);
> +		/*
> +		 * This buffer isn't dirty, it could be getten write access
> +		 * again by a new transaction, re-add it on the checkpoint
> +		 * list if it still needs to be checkpointed, and wait
> +		 * until that transaction finished to write out.
> +		 */
> +		if (!test_clear_buffer_dirty(bh)) {
> +			unlock_buffer(bh);
> +			spin_lock(&journal->j_list_lock);
> +			if (jh->b_cp_transaction)
> +				__buffer_relink_cp(jh);
> +			spin_unlock(&journal->j_list_lock);
> +			jbd2_journal_put_journal_head(jh);
> +			continue;
> +		}
> +		jbd2_journal_put_journal_head(jh);
> +		bh->b_end_io = end_buffer_write_sync;
> +		get_bh(bh);
> +		submit_bh(REQ_OP_WRITE | REQ_SYNC, bh);
> +	}
>  	blk_finish_plug(&plug);
>  
>  	for (i = 0; i < *batch_count; i++) {
> @@ -303,9 +349,9 @@ int jbd2_log_do_checkpoint(journal_t *journal)
>  		BUFFER_TRACE(bh, "queue");
>  		get_bh(bh);
>  		J_ASSERT_BH(bh, !buffer_jwrite(bh));
> +		jbd2_journal_grab_journal_head(bh);
>  		journal->j_chkpt_bhs[batch_count++] = bh;
>  		__buffer_relink_io(jh);
> -		transaction->t_chp_stats.cs_written++;
>  		if ((batch_count == JBD2_NR_BATCH) ||
>  		    need_resched() ||
>  		    spin_needbreak(&journal->j_list_lock))
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
