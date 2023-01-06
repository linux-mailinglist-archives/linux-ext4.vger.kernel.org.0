Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D8A4660208
	for <lists+linux-ext4@lfdr.de>; Fri,  6 Jan 2023 15:23:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233100AbjAFOXA (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 6 Jan 2023 09:23:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233898AbjAFOW6 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 6 Jan 2023 09:22:58 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D99A7BDCA;
        Fri,  6 Jan 2023 06:22:57 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C096426DA0;
        Fri,  6 Jan 2023 14:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1673014975; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ecx/oHASbbZpxUh4K46+VPuV5skiCtzUDP0hKsj3nsQ=;
        b=AvLHeYSIE/vneG5QGV15RG9Qtc8x1LTeDPTSVwMhcZ4wuzAGKcA74cRB3E+u+ZVZ2579Xe
        NmPJ5LSlPxPbjr4KmUhkZCrEwYl7hDG9/tPYi+96ZKGiF2LbPnSMfPXmOytQ7SCxrle3vx
        eKmDr6mYdQMREQjRMt+JpvB+VGs0gKg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1673014975;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ecx/oHASbbZpxUh4K46+VPuV5skiCtzUDP0hKsj3nsQ=;
        b=Q1G9fD6UpS3cIthvniPBuBUzDD0w3qXxgEJAOM9Ow5UGIf9CWYVLrZEvDGS3xH6Y2sDgzK
        M3SO+Ev6BLDKqeDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B1D2013596;
        Fri,  6 Jan 2023 14:22:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id gHZfK78uuGOpdwAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 06 Jan 2023 14:22:55 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 3641BA0742; Fri,  6 Jan 2023 15:22:55 +0100 (CET)
Date:   Fri, 6 Jan 2023 15:22:55 +0100
From:   Jan Kara <jack@suse.cz>
To:     Zhihao Cheng <chengzhihao1@huawei.com>
Cc:     tytso@mit.edu, jack@suse.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        libaokun1@huawei.com, zhanchengbin1@huawei.com
Subject: Re: [PATCH v2] jbd2: Fix data missing when reusing bh which is ready
 to be checkpointed
Message-ID: <20230106142255.fqnzgw5tqr77mdzj@quack3>
References: <20230106115603.2624644-1-chengzhihao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230106115603.2624644-1-chengzhihao1@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri 06-01-23 19:56:03, Zhihao Cheng wrote:
> Following process will make data lost and could lead to a filesystem
> corrupted problem:
> 
> 1. jh(bh) is inserted into T1->t_checkpoint_list, bh is dirty, and
>    jh->b_transaction = NULL
> 2. T1 is added into journal->j_checkpoint_transactions.
> 3. Get bh prepare to write while doing checkpoing:
>            PA				    PB
>    do_get_write_access             jbd2_log_do_checkpoint
>     spin_lock(&jh->b_state_lock)
>      if (buffer_dirty(bh))
>       clear_buffer_dirty(bh)   // clear buffer dirty
>        set_buffer_jbddirty(bh)
> 				    transaction =
> 				    journal->j_checkpoint_transactions
> 				    jh = transaction->t_checkpoint_list
> 				    if (!buffer_dirty(bh))
> 		                      __jbd2_journal_remove_checkpoint(jh)
> 				      // bh won't be flushed
> 		                    jbd2_cleanup_journal_tail
>     __jbd2_journal_file_buffer(jh, transaction, BJ_Reserved)
> 4. Aborting journal/Power-cut before writing latest bh on journal area.
> 
> In this way we get a corrupted filesystem with bh's data lost.
> 
> Fix it by moving the clearing of buffer_dirty bit just before the call
> to __jbd2_journal_file_buffer(), both bit clearing and jh->b_transaction
> assignment are under journal->j_list_lock locked, so that
> jbd2_log_do_checkpoint() will wait until jh's new transaction fininshed
> even bh is currently not dirty. And journal_shrink_one_cp_list() won't
> remove jh from checkpoint list if the buffer head is reused in
> do_get_write_access().
> 
> Cc: <stable@kernel.org>
> Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
> Signed-off-by: zhanchengbin <zhanchengbin1@huawei.com>
> Suggested-by: Jan Kara <jack@suse.cz>

Thanks for the patch! It looks good, some suggestions for making it a bit
more tidy below:

> diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
> index 6a404ac1c178..06a5e7961ef2 100644
> --- a/fs/jbd2/transaction.c
> +++ b/fs/jbd2/transaction.c
> @@ -1010,36 +1010,37 @@ do_get_write_access(handle_t *handle, struct journal_head *jh,
>  	 * ie. locked but not dirty) or tune2fs (which may actually have
>  	 * the buffer dirtied, ugh.)  */
>  
> -	if (buffer_dirty(bh)) {
> +	if (buffer_dirty(bh) && jh->b_transaction) {
>  		/*
>  		 * First question: is this buffer already part of the current
>  		 * transaction or the existing committing transaction?
>  		 */
> -		if (jh->b_transaction) {
> -			J_ASSERT_JH(jh,
> -				jh->b_transaction == transaction ||
> -				jh->b_transaction ==
> -					journal->j_committing_transaction);
> -			if (jh->b_next_transaction)
> -				J_ASSERT_JH(jh, jh->b_next_transaction ==
> -							transaction);
> -			warn_dirty_buffer(bh);
> -		}
> +		J_ASSERT_JH(jh, jh->b_transaction == transaction ||
> +			jh->b_transaction == journal->j_committing_transaction);
> +		if (jh->b_next_transaction)
> +			J_ASSERT_JH(jh, jh->b_next_transaction == transaction);
> +		warn_dirty_buffer(bh);
>  		/*
> -		 * In any case we need to clean the dirty flag and we must
> -		 * do it under the buffer lock to be sure we don't race
> -		 * with running write-out.
> +		 * We need to clean the dirty flag and we must do it under the
> +		 * buffer lock to be sure we don't race with running write-out.
>  		 */
>  		JBUFFER_TRACE(jh, "Journalling dirty buffer");
>  		clear_buffer_dirty(bh);
> +		/*
> +		 * Setting jbddirty after clearing buffer dirty is necessary.
> +		 * Function jbd2_journal_restart() could keep buffer on
> +		 * BJ_Reserved list until the transaction committing, then the
> +		 * buffer won't be dirtied by jbd2_journal_refile_buffer()
> +		 * after committing, the buffer couldn't fall on disk even
> +		 * last checkpoint finished, which may corrupt filesystem.
> +		 */
>  		set_buffer_jbddirty(bh);
>  	}

So I think the sequence:

	if (buffer_dirty(bh)) {
		warn_dirty_buffer(bh);
		JBUFFER_TRACE(jh, "Journalling dirty buffer");
		clear_buffer_dirty(bh);
		set_buffer_jbddirty(bh);
	}

can be moved into the branch

  	if (jh->b_transaction == transaction ||
	    jh->b_next_transaction == transaction) {

below. That way you can drop the assertions as well because they happen
later in do_get_write_access() again anyway.

Also I don't quite understand the new comment you have added. Do you mean
we need to not only clear BH_Dirty bit but also set BH_JBDdirty as dirtying
(through jbd2_journal_dirty_metadata()) does not have to follow after
do_get_write_access()?

Otherwise the patch looks good.

								Honza
>  
> -	unlock_buffer(bh);
> -
>  	error = -EROFS;
>  	if (is_handle_aborted(handle)) {
>  		spin_unlock(&jh->b_state_lock);
> +		unlock_buffer(bh);
>  		goto out;
>  	}
>  	error = 0;
> @@ -1049,8 +1050,10 @@ do_get_write_access(handle_t *handle, struct journal_head *jh,
>  	 * b_next_transaction points to it
>  	 */
>  	if (jh->b_transaction == transaction ||
> -	    jh->b_next_transaction == transaction)
> +	    jh->b_next_transaction == transaction) {
> +		unlock_buffer(bh);
>  		goto done;
> +	}
>  
>  	/*
>  	 * this is the first time this transaction is touching this buffer,
> @@ -1074,10 +1077,24 @@ do_get_write_access(handle_t *handle, struct journal_head *jh,
>  		 */
>  		smp_wmb();
>  		spin_lock(&journal->j_list_lock);
> +		if (test_clear_buffer_dirty(bh)) {
> +			/*
> +			 * Execute buffer dirty clearing and jh->b_transaction
> +			 * assignment under journal->j_list_lock locked to
> +			 * prevent bh being removed from checkpoint list if
> +			 * the buffer is in an intermediate state (not dirty
> +			 * and jh->b_transaction is NULL).
> +			 */
> +			JBUFFER_TRACE(jh, "Journalling dirty buffer");
> +			set_buffer_jbddirty(bh);
> +		}
>  		__jbd2_journal_file_buffer(jh, transaction, BJ_Reserved);
>  		spin_unlock(&journal->j_list_lock);
> +		unlock_buffer(bh);
>  		goto done;
>  	}
> +	unlock_buffer(bh);
> +
>  	/*
>  	 * If there is already a copy-out version of this buffer, then we don't
>  	 * need to make another one
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
