Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18D4B510706
	for <lists+linux-ext4@lfdr.de>; Tue, 26 Apr 2022 20:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351465AbiDZSeh (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 26 Apr 2022 14:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351436AbiDZSeg (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 26 Apr 2022 14:34:36 -0400
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 317DB26AD9
        for <linux-ext4@vger.kernel.org>; Tue, 26 Apr 2022 11:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1650997888; x=1682533888;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EPFkrvYzzEnBU5B8E1LfK5E6xn9ZbXldaw8ZFDlxsgk=;
  b=UIcZIFmuE5XpQrpXFQGJcGjZtOuLwPl14kwR6roiJcUW+aUgzue/9Fnk
   G/SpsWKv+adwxmuX1tSZSAxEAXtq5ENlDYHW+c6DB3YtN/ODpZIDfou6n
   Q5ph91NOdxkGIVKycSvWxFX32+gw4ExuomjRfOmc3+dsiNnI7/Dvq58nz
   k=;
X-IronPort-AV: E=Sophos;i="5.90,291,1643673600"; 
   d="scan'208";a="193216123"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-pdx-2b-05e8af15.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP; 26 Apr 2022 18:31:26 +0000
Received: from EX13MTAUWA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-pdx-2b-05e8af15.us-west-2.amazon.com (Postfix) with ESMTPS id BC4B8A285E;
        Tue, 26 Apr 2022 18:31:25 +0000 (UTC)
Received: from EX13D01UWA002.ant.amazon.com (10.43.160.74) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.58) with Microsoft SMTP Server (TLS)
 id 15.0.1497.32; Tue, 26 Apr 2022 18:31:25 +0000
Received: from localhost (10.43.160.52) by EX13d01UWA002.ant.amazon.com
 (10.43.160.74) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Tue, 26 Apr
 2022 18:31:24 +0000
Date:   Tue, 26 Apr 2022 11:31:24 -0700
From:   Samuel Mendoza-Jonas <samjonas@amazon.com>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
CC:     <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>,
        <syzbot+afa2ca5171d93e44b348@syzkaller.appspotmail.com>
Subject: Re: [PATCH] jbd2: Fix use-after-free of transaction_t race
Message-ID: <20220426183124.phrwsl77bch5uljx@u46989501580c5c.ant.amazon.com>
References: <948c2fed518ae739db6a8f7f83f1d58b504f87d0.1644497105.git.ritesh.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <948c2fed518ae739db6a8f7f83f1d58b504f87d0.1644497105.git.ritesh.list@gmail.com>
X-Originating-IP: [10.43.160.52]
X-ClientProxiedBy: EX13D46UWC004.ant.amazon.com (10.43.162.173) To
 EX13d01UWA002.ant.amazon.com (10.43.160.74)
X-Spam-Status: No, score=-12.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Feb 10, 2022 at 09:07:11PM +0530, Ritesh Harjani wrote:
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

Hi Ritesh,

Looking at the refactor in the commit this fixes, I believe the same
issue is present prior to the refactor, so this would apply before 5.17
as well.
I've posted a backport for 4.9-4.19 and 5.4-5.16 to stable here:
https://lore.kernel.org/stable/20220426182702.716304-1-samjonas@amazon.com/T/#t

Please have a look and let me know if you agree.

Cheers,
Sam Mendoza-Jonas


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
