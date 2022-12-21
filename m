Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34A53652F30
	for <lists+linux-ext4@lfdr.de>; Wed, 21 Dec 2022 11:15:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234588AbiLUKPB (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 21 Dec 2022 05:15:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234697AbiLUKOM (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 21 Dec 2022 05:14:12 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 314AE222BC;
        Wed, 21 Dec 2022 02:13:46 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9E4A821BB1;
        Wed, 21 Dec 2022 10:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1671617624; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2TvwPzi6wiLtMmmPj4i4B3RDTNRfbARTRFeV+JMX0Js=;
        b=zG5A5IIjP4mGDMFds4+99IZGxAVw8smJzZITFQh3e05y+KDNILgN++q7cuwS4z1/tRTV7r
        zVdmya3DcO8ork6Lg9/je8pgsFWUkBTFb6Uzz8a3cLEbQdFJrVFLhvZgXQcLRbLhTmz70Q
        i/WOOXamOpYmsZLbHamqnvpDqVGXFpU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1671617624;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2TvwPzi6wiLtMmmPj4i4B3RDTNRfbARTRFeV+JMX0Js=;
        b=aTfckfLmnAhj/yqAof5u03rFVy5r5S2jurQGunR49hIyz2SE5meeFq06u/pYKT9lvMoJRO
        Orx6jmW/6KK4mHAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9105013913;
        Wed, 21 Dec 2022 10:13:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0mxdI1jcomPQHwAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 21 Dec 2022 10:13:44 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 21FD4A0732; Wed, 21 Dec 2022 11:13:44 +0100 (CET)
Date:   Wed, 21 Dec 2022 11:13:44 +0100
From:   Jan Kara <jack@suse.cz>
To:     Zhihao Cheng <chengzhihao1@huawei.com>
Cc:     tytso@mit.edu, jack@suse.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        libaokun1@huawei.com, zhanchengbin1@huawei.com,
        yangerkun@huawei.com
Subject: Re: [PATCH] [RFC] Fix data missing when reusing bh which is ready to
 be checkpointed
Message-ID: <20221221101344.mup3mmrlt5c7yjfv@quack3>
References: <20221220150551.653925-1-chengzhihao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221220150551.653925-1-chengzhihao1@huawei.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue 20-12-22 23:05:51, Zhihao Cheng wrote:
> From: zhanchengbin <zhanchengbin1@huawei.com>
> 
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
> In this way we get a corrupted filesystem with bh'data lost.
> 
> Fix it by wrapping clear_buffer_dirty(bh) and jh->b_transaction setting
> into journal->j_list_lock, so that jbd2_log_do_checkpoint() will wait
> until jh's new transaction fininshed even bh is currently not dirty.
> 
> Cc: <stable@kernel.org>
> Signed-off-by: zhanchengbin <zhanchengbin1@huawei.com>
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
> ---
>  This is a quick fix, I need some suggestions about this patch, whether
>  it will import new problems if this patch is applied.
>  Yi suggests that the formal solution could be splitting
>  journal->j_list_lock into two locks: one protects checkpoint list and
>  the other one for other lists. Besides, jh->b_state_lock should be
>  held while traversing transaction->t_checkpoint_list in
>  jbd2_log_do_checkpoint()/journal_shrink_one_cp_list().
> 
>  fs/jbd2/transaction.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)

Good catch! Did you find it by code inspection or were you able to actually
trigger this problem?

I think there might be a simpler fix of the problem. Move the clearing
of buffer_dirty bit just before the call to __jbd2_journal_file_buffer().
We'll need to keep the buffer locked somewhat longer but that should not be
a huge deal.

								Honza


> diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
> index 6a404ac1c178..d22460001d6b 100644
> --- a/fs/jbd2/transaction.c
> +++ b/fs/jbd2/transaction.c
> @@ -990,6 +990,7 @@ do_get_write_access(handle_t *handle, struct journal_head *jh,
>   	start_lock = jiffies;
>  	lock_buffer(bh);
>  	spin_lock(&jh->b_state_lock);
> +	spin_lock(&journal->j_list_lock);
>  
>  	/* If it takes too long to lock the buffer, trace it */
>  	time_lock = jbd2_time_diff(start_lock, jiffies);
> @@ -1039,6 +1040,7 @@ do_get_write_access(handle_t *handle, struct journal_head *jh,
>  
>  	error = -EROFS;
>  	if (is_handle_aborted(handle)) {
> +		spin_unlock(&journal->j_list_lock);
>  		spin_unlock(&jh->b_state_lock);
>  		goto out;
>  	}
> @@ -1049,8 +1051,10 @@ do_get_write_access(handle_t *handle, struct journal_head *jh,
>  	 * b_next_transaction points to it
>  	 */
>  	if (jh->b_transaction == transaction ||
> -	    jh->b_next_transaction == transaction)
> +	    jh->b_next_transaction == transaction) {
> +		spin_unlock(&journal->j_list_lock);
>  		goto done;
> +	}
>  
>  	/*
>  	 * this is the first time this transaction is touching this buffer,
> @@ -1073,11 +1077,11 @@ do_get_write_access(handle_t *handle, struct journal_head *jh,
>  		 * Paired with barrier in jbd2_write_access_granted()
>  		 */
>  		smp_wmb();
> -		spin_lock(&journal->j_list_lock);
>  		__jbd2_journal_file_buffer(jh, transaction, BJ_Reserved);
>  		spin_unlock(&journal->j_list_lock);
>  		goto done;
>  	}
> +	spin_unlock(&journal->j_list_lock);
>  	/*
>  	 * If there is already a copy-out version of this buffer, then we don't
>  	 * need to make another one
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
