Return-Path: <linux-ext4+bounces-1804-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60F7F893778
	for <lists+linux-ext4@lfdr.de>; Mon,  1 Apr 2024 04:44:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9C69B211FE
	for <lists+linux-ext4@lfdr.de>; Mon,  1 Apr 2024 02:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F12CF46B5;
	Mon,  1 Apr 2024 02:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K5lEEqyd"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2923C38;
	Mon,  1 Apr 2024 02:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711939459; cv=none; b=tZeAuz7UV5nPNaMai/L6WNEmzkKXUx8w3ZztozHo9q8WmzP11+JB1s/ei0qDaU74IaZNuuqiARdppZp4TbEnqfo8L1Ap/LNjAq+lAg+33EVMXD0kNn8sPrSj6MI82GbGdzanAsJYKp3GoMoqd5VjFWpbyUZCX6aiaQR0fEaU5b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711939459; c=relaxed/simple;
	bh=YDCv6PVm8edK9rWdtKh4lZvGMbuZfAuCtEths1coMrk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IqQuUyNoAsMp4A3iJT8nEO9coBsVrfPHEKHrDDn9+GNcn/kyjUlv6GYmG9av3U75o2YTra0CWnY5bv1YrpUImSuLahGF1yF72TGnCsQhFTYk1s+tPDjJ3eW8ucy1OIUYUbdG1IiwHaRLpBZJpQ5xW/tWk5FExRu9/4hpQ4U6KrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K5lEEqyd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 909F9C43609;
	Mon,  1 Apr 2024 02:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711939458;
	bh=YDCv6PVm8edK9rWdtKh4lZvGMbuZfAuCtEths1coMrk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K5lEEqydUUKskF2czcElJ3JlcVcwl8+bbSyCHAcrqoD7XeKdKGhglIA0xA8Qm2WQr
	 GSqH+MVXl63wLf0nwg2Z+lVOyx8TXq3rXvGYEHtvlb+QoGRZrdvbZx18vlWPNh1FqZ
	 r+CMa25IMGweDRptzybb/aYzHfNP57itVnRa5lHVQuLr/SpwRQN6DN+6x65mUg4CTh
	 Hiy5XCjrvnh0wxYsFDEAiRNSxHygUm4gsbKtLiCkzLhSl8IsO/VS6DEbx5Rpcp6Xjr
	 JaO/j08zKedDp3CkZqsiTtqSnyv1O2nM5xnS1RExW0snGpKFAkGdC0t3GsvhzBtZ+v
	 gCctPbnNcNlSA==
Date: Sun, 31 Mar 2024 19:44:17 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Ye Bin <yebin10@huawei.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org, jack@suse.cz
Subject: Re: [PATCH] jbd2: use shrink_type type instead of bool type for
 __jbd2_journal_clean_checkpoint_list()
Message-ID: <20240401024417.GA739535@frogsfrogsfrogs>
References: <20240401011614.3650958-1-yebin10@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240401011614.3650958-1-yebin10@huawei.com>

On Mon, Apr 01, 2024 at 09:16:14AM +0800, Ye Bin wrote:
> "enum shrink_type" can clearly express the meaning of the parameter of
> __jbd2_journal_clean_checkpoint_list(), and there is no need to use the
> bool type.
> 
> Signed-off-by: Ye Bin <yebin10@huawei.com>
> ---
>  fs/jbd2/checkpoint.c | 9 +++------
>  fs/jbd2/commit.c     | 2 +-
>  include/linux/jbd2.h | 4 +++-
>  3 files changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/jbd2/checkpoint.c b/fs/jbd2/checkpoint.c
> index 1c97e64c4784..d6e8b80a4078 100644
> --- a/fs/jbd2/checkpoint.c
> +++ b/fs/jbd2/checkpoint.c
> @@ -337,8 +337,6 @@ int jbd2_cleanup_journal_tail(journal_t *journal)
>  
>  /* Checkpoint list management */
>  
> -enum shrink_type {SHRINK_DESTROY, SHRINK_BUSY_STOP, SHRINK_BUSY_SKIP};
> -
>  /*
>   * journal_shrink_one_cp_list
>   *
> @@ -476,17 +474,16 @@ unsigned long jbd2_journal_shrink_checkpoint_list(journal_t *journal,
>   *
>   * Called with j_list_lock held.
>   */
> -void __jbd2_journal_clean_checkpoint_list(journal_t *journal, bool destroy)
> +void __jbd2_journal_clean_checkpoint_list(journal_t *journal,
> +					  enum shrink_type type)
>  {
>  	transaction_t *transaction, *last_transaction, *next_transaction;
> -	enum shrink_type type;
>  	bool released;
>  
>  	transaction = journal->j_checkpoint_transactions;
>  	if (!transaction)
>  		return;
>  
> -	type = destroy ? SHRINK_DESTROY : SHRINK_BUSY_STOP;

What is supposed to happen if the caller passes in SHRINK_BUSY_SKIP?

--D

>  	last_transaction = transaction->t_cpprev;
>  	next_transaction = transaction;
>  	do {
> @@ -527,7 +524,7 @@ void jbd2_journal_destroy_checkpoint(journal_t *journal)
>  			spin_unlock(&journal->j_list_lock);
>  			break;
>  		}
> -		__jbd2_journal_clean_checkpoint_list(journal, true);
> +		__jbd2_journal_clean_checkpoint_list(journal, SHRINK_DESTROY);
>  		spin_unlock(&journal->j_list_lock);
>  		cond_resched();
>  	}
> diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
> index 5e122586e06e..78ebd04ac97d 100644
> --- a/fs/jbd2/commit.c
> +++ b/fs/jbd2/commit.c
> @@ -501,7 +501,7 @@ void jbd2_journal_commit_transaction(journal_t *journal)
>  	 * frees some memory
>  	 */
>  	spin_lock(&journal->j_list_lock);
> -	__jbd2_journal_clean_checkpoint_list(journal, false);
> +	__jbd2_journal_clean_checkpoint_list(journal, SHRINK_BUSY_STOP);
>  	spin_unlock(&journal->j_list_lock);
>  
>  	jbd2_debug(3, "JBD2: commit phase 1\n");
> diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
> index 971f3e826e15..58a961999d70 100644
> --- a/include/linux/jbd2.h
> +++ b/include/linux/jbd2.h
> @@ -1434,7 +1434,9 @@ void jbd2_update_log_tail(journal_t *journal, tid_t tid, unsigned long block);
>  extern void jbd2_journal_commit_transaction(journal_t *);
>  
>  /* Checkpoint list management */
> -void __jbd2_journal_clean_checkpoint_list(journal_t *journal, bool destroy);
> +enum shrink_type {SHRINK_DESTROY, SHRINK_BUSY_STOP, SHRINK_BUSY_SKIP};
> +
> +void __jbd2_journal_clean_checkpoint_list(journal_t *journal, enum shrink_type type);
>  unsigned long jbd2_journal_shrink_checkpoint_list(journal_t *journal, unsigned long *nr_to_scan);
>  int __jbd2_journal_remove_checkpoint(struct journal_head *);
>  int jbd2_journal_try_remove_checkpoint(struct journal_head *jh);
> -- 
> 2.31.1
> 
> 

