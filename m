Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F233769BD3
	for <lists+linux-ext4@lfdr.de>; Mon, 31 Jul 2023 18:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233251AbjGaQGZ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 31 Jul 2023 12:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232960AbjGaQGV (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 31 Jul 2023 12:06:21 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5AEC173F
        for <linux-ext4@vger.kernel.org>; Mon, 31 Jul 2023 09:06:03 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 73DD11F88C;
        Mon, 31 Jul 2023 16:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1690819562; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qivf/uN8csJwmlwGRd/3pugn22eQsqc7D0pnt6PGlpE=;
        b=fJCWFwsM+v/G6dQY/SDCGoWbEzkLCVlhjx3JBcvycRviwUth8h4DmZpJFfWnKu4jIcCDxq
        dPQkbdO4RPOI/mXzx0O/qT/jPc5glq4swXrLzdse87EpIdGzs6t8Q87G+0IMvpDcQ2xTdl
        S+yhv1vDPpOlUA7dR/BrWnLdoip9rJg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1690819562;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qivf/uN8csJwmlwGRd/3pugn22eQsqc7D0pnt6PGlpE=;
        b=L+ol5Sh27ss8b7Sa++ySQD/Ng4j5oQk266hehe8DO3V4h90iUskQVagcEVs3MrB0YBLO+q
        nggN3xlGp0vQAQAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 57EE51322C;
        Mon, 31 Jul 2023 16:06:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id PTlsFerbx2SsCQAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 31 Jul 2023 16:06:02 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id C136FA075D; Mon, 31 Jul 2023 18:06:01 +0200 (CEST)
Date:   Mon, 31 Jul 2023 18:06:01 +0200
From:   Jan Kara <jack@suse.cz>
To:     Zhang Yi <yi.zhang@huaweicloud.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, yi.zhang@huawei.com,
        chengzhihao1@huawei.com, yang.lee@linux.alibaba.com,
        yukuai3@huawei.com
Subject: Re: [PATCH 1/3] jbd2: fix checkpoint cleanup performance regression
Message-ID: <20230731160601.vslgnghz4av46zqy@quack3>
References: <20230714025528.564988-1-yi.zhang@huaweicloud.com>
 <20230714025528.564988-2-yi.zhang@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230714025528.564988-2-yi.zhang@huaweicloud.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri 14-07-23 10:55:26, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> journal_clean_one_cp_list() has been merged into
> journal_shrink_one_cp_list(), but do chekpoint buffer cleanup from the
> committing process is just a best effort, it should stop scan once it
> meet a busy buffer, or else it will cause a lot of invalid buffer scan
> and checks. We catch a performance regression when doing fs_mark tests
> below.
> 
> Test cmd:
>  ./fs_mark  -d  scratch  -s  1024  -n  10000  -t  1  -D  100  -N  100
> 
> Before merging checkpoint buffer cleanup:
>  FSUse%        Count         Size    Files/sec     App Overhead
>      95        10000         1024       8304.9            49033
> 
> After merging checkpoint buffer cleanup:
>  FSUse%        Count         Size    Files/sec     App Overhead
>      95        10000         1024       7649.0            50012
>  FSUse%        Count         Size    Files/sec     App Overhead
>      95        10000         1024       2107.1            50871
> 
> After merging checkpoint buffer cleanup, the total loop count in
> journal_shrink_one_cp_list() could be up to 6,261,600+ (50,000+ ~
> 100,000+ in general), most of them are invalid. This patch fix it
> through passing 'shrink_type' into journal_shrink_one_cp_list() and add
> a new 'SHRINK_BUSY_STOP' to indicate it should stop once meet a busy
> buffer. After fix, the loop count descending back to 10,000+.
> 
> After this fix:
>  FSUse%        Count         Size    Files/sec     App Overhead
>      95        10000         1024       8558.4            49109
> 
> Fixes: b98dba273a0e ("jbd2: remove journal_clean_one_cp_list()")
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/jbd2/checkpoint.c | 20 ++++++++++++++------
>  1 file changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/jbd2/checkpoint.c b/fs/jbd2/checkpoint.c
> index 9ec91017a7f3..936c6d758a65 100644
> --- a/fs/jbd2/checkpoint.c
> +++ b/fs/jbd2/checkpoint.c
> @@ -349,6 +349,8 @@ int jbd2_cleanup_journal_tail(journal_t *journal)
>  
>  /* Checkpoint list management */
>  
> +enum shrink_type {SHRINK_DESTROY, SHRINK_BUSY_STOP, SHRINK_BUSY_SKIP};
> +
>  /*
>   * journal_shrink_one_cp_list
>   *
> @@ -360,7 +362,8 @@ int jbd2_cleanup_journal_tail(journal_t *journal)
>   * Called with j_list_lock held.
>   */
>  static unsigned long journal_shrink_one_cp_list(struct journal_head *jh,
> -						bool destroy, bool *released)
> +						enum shrink_type type,
> +						bool *released)
>  {
>  	struct journal_head *last_jh;
>  	struct journal_head *next_jh = jh;
> @@ -376,12 +379,15 @@ static unsigned long journal_shrink_one_cp_list(struct journal_head *jh,
>  		jh = next_jh;
>  		next_jh = jh->b_cpnext;
>  
> -		if (destroy) {
> +		if (type == SHRINK_DESTROY) {
>  			ret = __jbd2_journal_remove_checkpoint(jh);
>  		} else {
>  			ret = jbd2_journal_try_remove_checkpoint(jh);
> -			if (ret < 0)
> -				continue;
> +			if (ret < 0) {
> +				if (type == SHRINK_BUSY_SKIP)
> +					continue;
> +				break;
> +			}
>  		}
>  
>  		nr_freed++;
> @@ -445,7 +451,7 @@ unsigned long jbd2_journal_shrink_checkpoint_list(journal_t *journal,
>  		tid = transaction->t_tid;
>  
>  		freed = journal_shrink_one_cp_list(transaction->t_checkpoint_list,
> -						   false, &released);
> +						   SHRINK_BUSY_SKIP, &released);
>  		nr_freed += freed;
>  		(*nr_to_scan) -= min(*nr_to_scan, freed);
>  		if (*nr_to_scan == 0)
> @@ -485,19 +491,21 @@ unsigned long jbd2_journal_shrink_checkpoint_list(journal_t *journal,
>  void __jbd2_journal_clean_checkpoint_list(journal_t *journal, bool destroy)
>  {
>  	transaction_t *transaction, *last_transaction, *next_transaction;
> +	enum shrink_type type;
>  	bool released;
>  
>  	transaction = journal->j_checkpoint_transactions;
>  	if (!transaction)
>  		return;
>  
> +	type = destroy ? SHRINK_DESTROY : SHRINK_BUSY_STOP;
>  	last_transaction = transaction->t_cpprev;
>  	next_transaction = transaction;
>  	do {
>  		transaction = next_transaction;
>  		next_transaction = transaction->t_cpnext;
>  		journal_shrink_one_cp_list(transaction->t_checkpoint_list,
> -					   destroy, &released);
> +					   type, &released);
>  		/*
>  		 * This function only frees up some memory if possible so we
>  		 * dont have an obligation to finish processing. Bail out if
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
