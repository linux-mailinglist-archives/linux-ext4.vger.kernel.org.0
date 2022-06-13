Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BB8D548DBC
	for <lists+linux-ext4@lfdr.de>; Mon, 13 Jun 2022 18:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357886AbiFMNLb (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 13 Jun 2022 09:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359243AbiFMNJn (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 13 Jun 2022 09:09:43 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FBB0289BB
        for <linux-ext4@vger.kernel.org>; Mon, 13 Jun 2022 04:19:37 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 341B821D38;
        Mon, 13 Jun 2022 11:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655119176; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RR3+DQXxZAzr5Tv6WqaMfyGsj9xrGZ5VFzKQwU9pEEg=;
        b=zT5wRMYaybh9MaMku6gcwO58QZ7P8tRc/33kQDN6Q7MPtMbyzJkAUwCOXQPr59rtz34GvE
        M9J741x5Ez2c3KJTSNukCav7riqp4kE2gn+HQxasxA7011lLIEDMvOpRNgUAAF5cAQC9Hk
        ZP9ZGKXgoezyCLPgOVgnsNxadIS7Qis=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655119176;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RR3+DQXxZAzr5Tv6WqaMfyGsj9xrGZ5VFzKQwU9pEEg=;
        b=mA5hS6dqJzHy0tI247vrnznGQ99ZkY8yS/mciOjuE4k7I/gBm3RwgAjJdbEFUN3eu2kgMM
        evRf2XfAoypolOCQ==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id C45872C141;
        Mon, 13 Jun 2022 11:19:35 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 736D9A0634; Mon, 13 Jun 2022 13:19:35 +0200 (CEST)
Date:   Mon, 13 Jun 2022 13:19:35 +0200
From:   Jan Kara <jack@suse.cz>
To:     Zhang Yi <yi.zhang@huawei.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, yukuai3@huawei.com
Subject: Re: [PATCH] jbd2: fix outstanding credits assert in
 jbd2_journal_commit_transaction()
Message-ID: <20220613111935.swheyx3p7psvshxn@quack3.lan>
References: <20220611130426.2013258-1-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220611130426.2013258-1-yi.zhang@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat 11-06-22 21:04:26, Zhang Yi wrote:
> We catch an assert problem in jbd2_journal_commit_transaction() when
> doing fsstress and request falut injection tests. The problem is
> happened in a race condition between jbd2_journal_commit_transaction()
> and ext4_end_io_end(). Firstly, ext4_writepages() writeback dirty pages
> and start reserved handle, and then the journal was aborted due to some
> previous metadata IO error, jbd2_journal_abort() start to commit current
> running transaction, the committing procedure could be raced by
> ext4_end_io_end() and lead to subtract j_reserved_credits twice from
> commit_transaction->t_outstanding_credits, finally the
> t_outstanding_credits is mistakenly smaller than t_nr_buffers and
> trigger assert.
> 
> kjournald2           kworker
> 
> jbd2_journal_commit_transaction()
>  write_unlock(&journal->j_state_lock);
>  atomic_sub(j_reserved_credits, t_outstanding_credits); //sub once
> 
>      	             jbd2_journal_start_reserved()
>      	              start_this_handle()  //detect aborted journal
>      	              jbd2_journal_free_reserved()  //get running transaction
>                        read_lock(&journal->j_state_lock)
>      	                __jbd2_journal_unreserve_handle()
>      	               atomic_sub(j_reserved_credits, t_outstanding_credits);
>                        //sub again
>                        read_unlock(&journal->j_state_lock);
> 
>  journal->j_running_transaction = NULL;
>  J_ASSERT(t_nr_buffers <= t_outstanding_credits) //bomb!!!
> 
> Fix this issue by using journal->j_state_lock to protect the subtraction
> in jbd2_journal_commit_transaction().
> 
> Fixes: 96f1e0974575 ("jbd2: avoid long hold times of j_state_lock while committing a transaction")
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Thanks for the analysis and the fix! This is indeed subtle. This fix looks
good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/jbd2/commit.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
> index eb315e81f1a6..af1a9191368c 100644
> --- a/fs/jbd2/commit.c
> +++ b/fs/jbd2/commit.c
> @@ -553,13 +553,13 @@ void jbd2_journal_commit_transaction(journal_t *journal)
>  	 */
>  	jbd2_journal_switch_revoke_table(journal);
>  
> +	write_lock(&journal->j_state_lock);
>  	/*
>  	 * Reserved credits cannot be claimed anymore, free them
>  	 */
>  	atomic_sub(atomic_read(&journal->j_reserved_credits),
>  		   &commit_transaction->t_outstanding_credits);
>  
> -	write_lock(&journal->j_state_lock);
>  	trace_jbd2_commit_flushing(journal, commit_transaction);
>  	stats.run.rs_flushing = jiffies;
>  	stats.run.rs_locked = jbd2_time_diff(stats.run.rs_locked,
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
