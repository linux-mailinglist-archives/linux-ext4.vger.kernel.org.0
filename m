Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 940C94B1609
	for <lists+linux-ext4@lfdr.de>; Thu, 10 Feb 2022 20:16:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343796AbiBJTPj (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 10 Feb 2022 14:15:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239426AbiBJTPi (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 10 Feb 2022 14:15:38 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 841B8101C
        for <linux-ext4@vger.kernel.org>; Thu, 10 Feb 2022 11:15:39 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 2D59C21117;
        Thu, 10 Feb 2022 19:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1644520538; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TY3BI3uplLhp3LCwljp291bBEmcESFOkt0pRpJDb6Xw=;
        b=SXXAGFn1TTj0zlsGD96OkQNkwF6IbPyOyLu2100aCt2Hrj5zCW6XExN7iv7D8aR3XPfJMP
        T3ek4GFHzlWqDI6AThV61Nd5LAQy4leXpNNGuJ8Erm4fQ0+6HL95LmFikGWI05NXNNTGJr
        n280iTU7Y6uucBCSzIYYYKqIdYzpLgo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1644520538;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TY3BI3uplLhp3LCwljp291bBEmcESFOkt0pRpJDb6Xw=;
        b=GRgVsTysy3OsitT13YXgFEMIrpL99OFjn4tePR6b5KGjn84fRtoem4OazfK/PioQ1ycP3/
        QdLduYddEMtR3QDA==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 0D0FFA3B83;
        Thu, 10 Feb 2022 19:15:38 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id B394CA05BC; Thu, 10 Feb 2022 20:15:37 +0100 (CET)
Date:   Thu, 10 Feb 2022 20:15:37 +0100
From:   Jan Kara <jack@suse.cz>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     linux-ext4@vger.kernel.org, Jan Kara <jack@suse.cz>,
        syzbot+afa2ca5171d93e44b348@syzkaller.appspotmail.com
Subject: Re: [PATCH] jbd2: Fix use-after-free of transaction_t race
Message-ID: <20220210191537.rgqbnuxqdt5lu4cr@quack3.lan>
References: <948c2fed518ae739db6a8f7f83f1d58b504f87d0.1644497105.git.ritesh.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <948c2fed518ae739db6a8f7f83f1d58b504f87d0.1644497105.git.ritesh.list@gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu 10-02-22 21:07:11, Ritesh Harjani wrote:
> jbd2_journal_wait_updates() is called with j_state_lock held. But if
> there is a commit in progress, then this transaction might get committed
> and freed via jbd2_journal_commit_transaction() ->
> jbd2_journal_free_transaction(), when we release j_state_lock.
> So check for journal->j_running_transaction everytime we release and
> acquire j_state_lock to avoid use-after-free issue.
> 
> Fixes: 4f98186848707f53 ("jbd2: refactor wait logic for transaction updates into a common function")
> Reported-and-tested-by: syzbot+afa2ca5171d93e44b348@syzkaller.appspotmail.com
> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/jbd2/transaction.c | 41 +++++++++++++++++++++++++----------------
>  1 file changed, 25 insertions(+), 16 deletions(-)
> 
> diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
> index 8e2f8275a253..259e00046a8b 100644
> --- a/fs/jbd2/transaction.c
> +++ b/fs/jbd2/transaction.c
> @@ -842,27 +842,38 @@ EXPORT_SYMBOL(jbd2_journal_restart);
>   */
>  void jbd2_journal_wait_updates(journal_t *journal)
>  {
> -	transaction_t *commit_transaction = journal->j_running_transaction;
> +	DEFINE_WAIT(wait);
> 
> -	if (!commit_transaction)
> -		return;
> +	while (1) {
> +		/*
> +		 * Note that the running transaction can get freed under us if
> +		 * this transaction is getting committed in
> +		 * jbd2_journal_commit_transaction() ->
> +		 * jbd2_journal_free_transaction(). This can only happen when we
> +		 * release j_state_lock -> schedule() -> acquire j_state_lock.
> +		 * Hence we should everytime retrieve new j_running_transaction
> +		 * value (after j_state_lock release acquire cycle), else it may
> +		 * lead to use-after-free of old freed transaction.
> +		 */
> +		transaction_t *transaction = journal->j_running_transaction;
> 
> -	spin_lock(&commit_transaction->t_handle_lock);
> -	while (atomic_read(&commit_transaction->t_updates)) {
> -		DEFINE_WAIT(wait);
> +		if (!transaction)
> +			break;
> 
> +		spin_lock(&transaction->t_handle_lock);
>  		prepare_to_wait(&journal->j_wait_updates, &wait,
> -					TASK_UNINTERRUPTIBLE);
> -		if (atomic_read(&commit_transaction->t_updates)) {
> -			spin_unlock(&commit_transaction->t_handle_lock);
> -			write_unlock(&journal->j_state_lock);
> -			schedule();
> -			write_lock(&journal->j_state_lock);
> -			spin_lock(&commit_transaction->t_handle_lock);
> +				TASK_UNINTERRUPTIBLE);
> +		if (!atomic_read(&transaction->t_updates)) {
> +			spin_unlock(&transaction->t_handle_lock);
> +			finish_wait(&journal->j_wait_updates, &wait);
> +			break;
>  		}
> +		spin_unlock(&transaction->t_handle_lock);
> +		write_unlock(&journal->j_state_lock);
> +		schedule();
>  		finish_wait(&journal->j_wait_updates, &wait);
> +		write_lock(&journal->j_state_lock);
>  	}
> -	spin_unlock(&commit_transaction->t_handle_lock);
>  }
> 
>  /**
> @@ -877,8 +888,6 @@ void jbd2_journal_wait_updates(journal_t *journal)
>   */
>  void jbd2_journal_lock_updates(journal_t *journal)
>  {
> -	DEFINE_WAIT(wait);
> -
>  	jbd2_might_wait_for_commit(journal);
> 
>  	write_lock(&journal->j_state_lock);
> --
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
