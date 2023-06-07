Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DDB47257A8
	for <lists+linux-ext4@lfdr.de>; Wed,  7 Jun 2023 10:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234020AbjFGIaZ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 7 Jun 2023 04:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235660AbjFGIaY (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 7 Jun 2023 04:30:24 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FC9E83
        for <linux-ext4@vger.kernel.org>; Wed,  7 Jun 2023 01:30:23 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E739F219F2;
        Wed,  7 Jun 2023 08:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1686126621; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xfz8P5aKBwf077U7hT94NxYJ+Wqgu9Gn7nRQzJPP744=;
        b=2C52cLyex1MbXWjnsgqb28DJlRErG5PoAZzosQm5cghlNfxg5kQEOLOnQEgWXmvVBbQYLd
        O8k+8D+olRYW+S3wEZDbzkWEVsepXsl9n+/JtmSGkITI5NDpaRuJL/xD2jll6Ach6TnYxT
        eT8rk2bLbh5h2F8Q9tJM++0ammZgT/U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1686126621;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xfz8P5aKBwf077U7hT94NxYJ+Wqgu9Gn7nRQzJPP744=;
        b=7Zg599glXu1PZ0WLiph7+dAurQIHPY1Dxp/mdgToUhbd2slgmCZQDRpKbllWWdB9TXof6s
        zm70hgGVFDIR5HDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D38541346D;
        Wed,  7 Jun 2023 08:30:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id KGaaMx1AgGRZQAAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 07 Jun 2023 08:30:21 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 58F24A0754; Wed,  7 Jun 2023 10:30:21 +0200 (CEST)
Date:   Wed, 7 Jun 2023 10:30:21 +0200
From:   Jan Kara <jack@suse.cz>
To:     Zhang Yi <yi.zhang@huaweicloud.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, yi.zhang@huawei.com,
        yukuai3@huawei.com, chengzhihao1@huawei.com
Subject: Re: [PATCH v3 3/6] jbd2: remove journal_clean_one_cp_list()
Message-ID: <20230607083021.l7d4gfa53yl3heka@quack3>
References: <20230606135928.434610-1-yi.zhang@huaweicloud.com>
 <20230606135928.434610-4-yi.zhang@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230606135928.434610-4-yi.zhang@huaweicloud.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue 06-06-23 21:59:25, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> journal_clean_one_cp_list() and journal_shrink_one_cp_list() are almost
> the same, so merge them into journal_shrink_one_cp_list(), remove the
> nr_to_scan parameter, always scan and try to free the whole checkpoint
> list.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/jbd2/checkpoint.c        | 75 +++++++++----------------------------
>  include/trace/events/jbd2.h | 12 ++----
>  2 files changed, 21 insertions(+), 66 deletions(-)
> 
> diff --git a/fs/jbd2/checkpoint.c b/fs/jbd2/checkpoint.c
> index 55d6efdbea64..b94f847960c2 100644
> --- a/fs/jbd2/checkpoint.c
> +++ b/fs/jbd2/checkpoint.c
> @@ -347,50 +347,10 @@ int jbd2_cleanup_journal_tail(journal_t *journal)
>  
>  /* Checkpoint list management */
>  
> -/*
> - * journal_clean_one_cp_list
> - *
> - * Find all the written-back checkpoint buffers in the given list and
> - * release them. If 'destroy' is set, clean all buffers unconditionally.
> - *
> - * Called with j_list_lock held.
> - * Returns 1 if we freed the transaction, 0 otherwise.
> - */
> -static int journal_clean_one_cp_list(struct journal_head *jh, bool destroy)
> -{
> -	struct journal_head *last_jh;
> -	struct journal_head *next_jh = jh;
> -
> -	if (!jh)
> -		return 0;
> -
> -	last_jh = jh->b_cpprev;
> -	do {
> -		jh = next_jh;
> -		next_jh = jh->b_cpnext;
> -
> -		if (!destroy && __cp_buffer_busy(jh))
> -			return 0;
> -
> -		if (__jbd2_journal_remove_checkpoint(jh))
> -			return 1;
> -		/*
> -		 * This function only frees up some memory
> -		 * if possible so we dont have an obligation
> -		 * to finish processing. Bail out if preemption
> -		 * requested:
> -		 */
> -		if (need_resched())
> -			return 0;
> -	} while (jh != last_jh);
> -
> -	return 0;
> -}
> -
>  /*
>   * journal_shrink_one_cp_list
>   *
> - * Find 'nr_to_scan' written-back checkpoint buffers in the given list
> + * Find all the written-back checkpoint buffers in the given list
>   * and try to release them. If the whole transaction is released, set
>   * the 'released' parameter. Return the number of released checkpointed
>   * buffers.
> @@ -398,15 +358,15 @@ static int journal_clean_one_cp_list(struct journal_head *jh, bool destroy)
>   * Called with j_list_lock held.
>   */
>  static unsigned long journal_shrink_one_cp_list(struct journal_head *jh,
> -						unsigned long *nr_to_scan,
> -						bool *released)
> +						bool destroy, bool *released)
>  {
>  	struct journal_head *last_jh;
>  	struct journal_head *next_jh = jh;
>  	unsigned long nr_freed = 0;
>  	int ret;
>  
> -	if (!jh || *nr_to_scan == 0)
> +	*released = false;
> +	if (!jh)
>  		return 0;
>  
>  	last_jh = jh->b_cpprev;
> @@ -414,8 +374,7 @@ static unsigned long journal_shrink_one_cp_list(struct journal_head *jh,
>  		jh = next_jh;
>  		next_jh = jh->b_cpnext;
>  
> -		(*nr_to_scan)--;
> -		if (__cp_buffer_busy(jh))
> +		if (!destroy && __cp_buffer_busy(jh))
>  			continue;
>  
>  		nr_freed++;
> @@ -427,7 +386,7 @@ static unsigned long journal_shrink_one_cp_list(struct journal_head *jh,
>  
>  		if (need_resched())
>  			break;
> -	} while (jh != last_jh && *nr_to_scan);
> +	} while (jh != last_jh);
>  
>  	return nr_freed;
>  }
> @@ -445,11 +404,11 @@ unsigned long jbd2_journal_shrink_checkpoint_list(journal_t *journal,
>  						  unsigned long *nr_to_scan)
>  {
>  	transaction_t *transaction, *last_transaction, *next_transaction;
> -	bool released;
> +	bool __maybe_unused released;
>  	tid_t first_tid = 0, last_tid = 0, next_tid = 0;
>  	tid_t tid = 0;
>  	unsigned long nr_freed = 0;
> -	unsigned long nr_scanned = *nr_to_scan;
> +	unsigned long freed;
>  
>  again:
>  	spin_lock(&journal->j_list_lock);
> @@ -478,10 +437,11 @@ unsigned long jbd2_journal_shrink_checkpoint_list(journal_t *journal,
>  		transaction = next_transaction;
>  		next_transaction = transaction->t_cpnext;
>  		tid = transaction->t_tid;
> -		released = false;
>  
> -		nr_freed += journal_shrink_one_cp_list(transaction->t_checkpoint_list,
> -						       nr_to_scan, &released);
> +		freed = journal_shrink_one_cp_list(transaction->t_checkpoint_list,
> +						   false, &released);
> +		nr_freed += freed;
> +		(*nr_to_scan) -= min(*nr_to_scan, freed);
>  		if (*nr_to_scan == 0)
>  			break;
>  		if (need_resched() || spin_needbreak(&journal->j_list_lock))
> @@ -502,9 +462,8 @@ unsigned long jbd2_journal_shrink_checkpoint_list(journal_t *journal,
>  	if (*nr_to_scan && next_tid)
>  		goto again;
>  out:
> -	nr_scanned -= *nr_to_scan;
>  	trace_jbd2_shrink_checkpoint_list(journal, first_tid, tid, last_tid,
> -					  nr_freed, nr_scanned, next_tid);
> +					  nr_freed, next_tid);
>  
>  	return nr_freed;
>  }
> @@ -520,7 +479,7 @@ unsigned long jbd2_journal_shrink_checkpoint_list(journal_t *journal,
>  void __jbd2_journal_clean_checkpoint_list(journal_t *journal, bool destroy)
>  {
>  	transaction_t *transaction, *last_transaction, *next_transaction;
> -	int ret;
> +	bool released;
>  
>  	transaction = journal->j_checkpoint_transactions;
>  	if (!transaction)
> @@ -531,8 +490,8 @@ void __jbd2_journal_clean_checkpoint_list(journal_t *journal, bool destroy)
>  	do {
>  		transaction = next_transaction;
>  		next_transaction = transaction->t_cpnext;
> -		ret = journal_clean_one_cp_list(transaction->t_checkpoint_list,
> -						destroy);
> +		journal_shrink_one_cp_list(transaction->t_checkpoint_list,
> +					   destroy, &released);
>  		/*
>  		 * This function only frees up some memory if possible so we
>  		 * dont have an obligation to finish processing. Bail out if
> @@ -545,7 +504,7 @@ void __jbd2_journal_clean_checkpoint_list(journal_t *journal, bool destroy)
>  		 * avoids pointless scanning of transactions which still
>  		 * weren't checkpointed.
>  		 */
> -		if (!ret)
> +		if (!released)
>  			return;
>  	} while (transaction != last_transaction);
>  }
> diff --git a/include/trace/events/jbd2.h b/include/trace/events/jbd2.h
> index 8f5ee380d309..5646ae15a957 100644
> --- a/include/trace/events/jbd2.h
> +++ b/include/trace/events/jbd2.h
> @@ -462,11 +462,9 @@ TRACE_EVENT(jbd2_shrink_scan_exit,
>  TRACE_EVENT(jbd2_shrink_checkpoint_list,
>  
>  	TP_PROTO(journal_t *journal, tid_t first_tid, tid_t tid, tid_t last_tid,
> -		 unsigned long nr_freed, unsigned long nr_scanned,
> -		 tid_t next_tid),
> +		 unsigned long nr_freed, tid_t next_tid),
>  
> -	TP_ARGS(journal, first_tid, tid, last_tid, nr_freed,
> -		nr_scanned, next_tid),
> +	TP_ARGS(journal, first_tid, tid, last_tid, nr_freed, next_tid),
>  
>  	TP_STRUCT__entry(
>  		__field(dev_t, dev)
> @@ -474,7 +472,6 @@ TRACE_EVENT(jbd2_shrink_checkpoint_list,
>  		__field(tid_t, tid)
>  		__field(tid_t, last_tid)
>  		__field(unsigned long, nr_freed)
> -		__field(unsigned long, nr_scanned)
>  		__field(tid_t, next_tid)
>  	),
>  
> @@ -484,15 +481,14 @@ TRACE_EVENT(jbd2_shrink_checkpoint_list,
>  		__entry->tid		= tid;
>  		__entry->last_tid	= last_tid;
>  		__entry->nr_freed	= nr_freed;
> -		__entry->nr_scanned	= nr_scanned;
>  		__entry->next_tid	= next_tid;
>  	),
>  
>  	TP_printk("dev %d,%d shrink transaction %u-%u(%u) freed %lu "
> -		  "scanned %lu next transaction %u",
> +		  "next transaction %u",
>  		  MAJOR(__entry->dev), MINOR(__entry->dev),
>  		  __entry->first_tid, __entry->tid, __entry->last_tid,
> -		  __entry->nr_freed, __entry->nr_scanned, __entry->next_tid)
> +		  __entry->nr_freed, __entry->next_tid)
>  );
>  
>  #endif /* _TRACE_JBD2_H */
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
