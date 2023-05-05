Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 833C86F8391
	for <lists+linux-ext4@lfdr.de>; Fri,  5 May 2023 15:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232052AbjEENNE (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 5 May 2023 09:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231788AbjEENND (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 5 May 2023 09:13:03 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74F341D940
        for <linux-ext4@vger.kernel.org>; Fri,  5 May 2023 06:13:02 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 359C720012;
        Fri,  5 May 2023 13:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1683292381; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aP8ucgSKWZ+6oWS8BkWtiN/SKYzsbUY3TVFeTAV3Re8=;
        b=PzuvrXJWUGbJJ3+8FPlK56vYENnvJG6H+eOsG1M6KgeCWPCU5vtPEM6pQI5oXehrw0XuOl
        eEiUjkYnrkPcvwtXnSW6MY4Pd97eofN8uJOhvanxppSQB3DeT5EubYCMwua1549BnZQqA/
        XPE8Y0+nwsWQlRTAgl76v9/q0RzmTpk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1683292381;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aP8ucgSKWZ+6oWS8BkWtiN/SKYzsbUY3TVFeTAV3Re8=;
        b=tVilGRBoju5gBhsos03Y77GXsLAuFoE5yerf6uEMcfLpUXXW8uh8xbKs/ntPgj3rqcAbPb
        UZO8uuLudejZgkAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 24F1913488;
        Fri,  5 May 2023 13:13:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id dc7/CN0AVWQJTgAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 05 May 2023 13:13:01 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id A1A4FA0729; Fri,  5 May 2023 15:13:00 +0200 (CEST)
Date:   Fri, 5 May 2023 15:13:00 +0200
From:   Jan Kara <jack@suse.cz>
To:     Zhang Yi <yi.zhang@huaweicloud.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, yi.zhang@huawei.com,
        yukuai3@huawei.com, chengzhihao1@huawei.com
Subject: Re: [PATCH v2 2/3] jbd2: remove t_checkpoint_io_list
Message-ID: <20230505131300.57p23wh53m3iabod@quack3>
References: <20230505123219.4135141-1-yi.zhang@huaweicloud.com>
 <20230505123219.4135141-2-yi.zhang@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230505123219.4135141-2-yi.zhang@huaweicloud.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri 05-05-23 20:32:18, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> Since t_checkpoint_io_list was stop using in jbd2_log_do_checkpoint()
> now, it's time to remove the whole t_checkpoint_io_list logic.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/jbd2/checkpoint.c | 42 ++----------------------------------------
>  fs/jbd2/commit.c     |  3 +--
>  include/linux/jbd2.h |  6 ------
>  3 files changed, 3 insertions(+), 48 deletions(-)
> 
> diff --git a/fs/jbd2/checkpoint.c b/fs/jbd2/checkpoint.c
> index ae1ebfb8bc86..2b62154e9f1e 100644
> --- a/fs/jbd2/checkpoint.c
> +++ b/fs/jbd2/checkpoint.c
> @@ -27,7 +27,7 @@
>   *
>   * Called with j_list_lock held.
>   */
> -static inline void __buffer_unlink_first(struct journal_head *jh)
> +static inline void __buffer_unlink(struct journal_head *jh)
>  {
>  	transaction_t *transaction = jh->b_cp_transaction;
>  
> @@ -40,23 +40,6 @@ static inline void __buffer_unlink_first(struct journal_head *jh)
>  	}
>  }
>  
> -/*
> - * Unlink a buffer from a transaction checkpoint(io) list.
> - *
> - * Called with j_list_lock held.
> - */
> -static inline void __buffer_unlink(struct journal_head *jh)
> -{
> -	transaction_t *transaction = jh->b_cp_transaction;
> -
> -	__buffer_unlink_first(jh);
> -	if (transaction->t_checkpoint_io_list == jh) {
> -		transaction->t_checkpoint_io_list = jh->b_cpnext;
> -		if (transaction->t_checkpoint_io_list == jh)
> -			transaction->t_checkpoint_io_list = NULL;
> -	}
> -}
> -
>  /*
>   * Check a checkpoint buffer could be release or not.
>   *
> @@ -499,15 +482,6 @@ unsigned long jbd2_journal_shrink_checkpoint_list(journal_t *journal,
>  			break;
>  		if (need_resched() || spin_needbreak(&journal->j_list_lock))
>  			break;
> -		if (released)
> -			continue;
> -
> -		nr_freed += journal_shrink_one_cp_list(transaction->t_checkpoint_io_list,
> -						       nr_to_scan, &released);
> -		if (*nr_to_scan == 0)
> -			break;
> -		if (need_resched() || spin_needbreak(&journal->j_list_lock))
> -			break;
>  	} while (transaction != last_transaction);
>  
>  	if (transaction != last_transaction) {
> @@ -562,17 +536,6 @@ void __jbd2_journal_clean_checkpoint_list(journal_t *journal, bool destroy)
>  		 */
>  		if (need_resched())
>  			return;
> -		if (ret)
> -			continue;
> -		/*
> -		 * It is essential that we are as careful as in the case of
> -		 * t_checkpoint_list with removing the buffer from the list as
> -		 * we can possibly see not yet submitted buffers on io_list
> -		 */
> -		ret = journal_clean_one_cp_list(transaction->
> -				t_checkpoint_io_list, destroy);
> -		if (need_resched())
> -			return;
>  		/*
>  		 * Stop scanning if we couldn't free the transaction. This
>  		 * avoids pointless scanning of transactions which still
> @@ -657,7 +620,7 @@ int __jbd2_journal_remove_checkpoint(struct journal_head *jh)
>  	jbd2_journal_put_journal_head(jh);
>  
>  	/* Is this transaction empty? */
> -	if (transaction->t_checkpoint_list || transaction->t_checkpoint_io_list)
> +	if (transaction->t_checkpoint_list)
>  		return 0;
>  
>  	/*
> @@ -749,7 +712,6 @@ void __jbd2_journal_drop_transaction(journal_t *journal, transaction_t *transact
>  	J_ASSERT(transaction->t_forget == NULL);
>  	J_ASSERT(transaction->t_shadow_list == NULL);
>  	J_ASSERT(transaction->t_checkpoint_list == NULL);
> -	J_ASSERT(transaction->t_checkpoint_io_list == NULL);
>  	J_ASSERT(atomic_read(&transaction->t_updates) == 0);
>  	J_ASSERT(journal->j_committing_transaction != transaction);
>  	J_ASSERT(journal->j_running_transaction != transaction);
> diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
> index b33155dd7001..1073259902a6 100644
> --- a/fs/jbd2/commit.c
> +++ b/fs/jbd2/commit.c
> @@ -1141,8 +1141,7 @@ void jbd2_journal_commit_transaction(journal_t *journal)
>  	spin_lock(&journal->j_list_lock);
>  	commit_transaction->t_state = T_FINISHED;
>  	/* Check if the transaction can be dropped now that we are finished */
> -	if (commit_transaction->t_checkpoint_list == NULL &&
> -	    commit_transaction->t_checkpoint_io_list == NULL) {
> +	if (commit_transaction->t_checkpoint_list == NULL) {
>  		__jbd2_journal_drop_transaction(journal, commit_transaction);
>  		jbd2_journal_free_transaction(commit_transaction);
>  	}
> diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
> index f619bae1dcc5..91a2cf4bc575 100644
> --- a/include/linux/jbd2.h
> +++ b/include/linux/jbd2.h
> @@ -622,12 +622,6 @@ struct transaction_s
>  	 */
>  	struct journal_head	*t_checkpoint_list;
>  
> -	/*
> -	 * Doubly-linked circular list of all buffers submitted for IO while
> -	 * checkpointing. [j_list_lock]
> -	 */
> -	struct journal_head	*t_checkpoint_io_list;
> -
>  	/*
>  	 * Doubly-linked circular list of metadata buffers being
>  	 * shadowed by log IO.  The IO buffers on the iobuf list and
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
