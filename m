Return-Path: <linux-ext4+bounces-1803-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47AF88936E0
	for <lists+linux-ext4@lfdr.de>; Mon,  1 Apr 2024 04:18:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E1F2B210F5
	for <lists+linux-ext4@lfdr.de>; Mon,  1 Apr 2024 02:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B1FF138C;
	Mon,  1 Apr 2024 02:18:07 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB98A59;
	Mon,  1 Apr 2024 02:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711937886; cv=none; b=fBGqbSHN6F+q0/TgliBcyd0By9s/VsFUlWCbYaov1ZDAMCm4RkDQn72BCYu+O9LbRx4W52FCUIMn/OZaSuMwwKeMc1v5sDwjcupI293y5wyTC5Kp6vz9u3P2nO700xn5a5yCrUrVht4GQrIZN3a0oFF1FEznAyJ3rGJLtxZp8Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711937886; c=relaxed/simple;
	bh=LYPGhO2dpocf5zxxetIYl2zEOEb4isl3NqS1BT4F0TY=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Mr9oftK7QkEsSz9UZ17Qm/uH9wvFDezDbjAGbB62Fr8mbVkDLnD6u0DNIEP37G0JgU/UvzUN6jCcNWhpqqlwyWJ4BEpCD9S1Hf096LatkOlV1DdJXoVNGzq8OyIJXD+QgHdi8z5qYvtLqOzDTIXXHdbaCGDXCPLB7Lq2Djxnrlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4V7F5B0gnCzbdqL;
	Mon,  1 Apr 2024 10:17:02 +0800 (CST)
Received: from canpemm500005.china.huawei.com (unknown [7.192.104.229])
	by mail.maildlp.com (Postfix) with ESMTPS id 0B657140487;
	Mon,  1 Apr 2024 10:17:56 +0800 (CST)
Received: from [10.174.176.34] (10.174.176.34) by
 canpemm500005.china.huawei.com (7.192.104.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 1 Apr 2024 10:17:55 +0800
Subject: Re: [PATCH] jbd2: use shrink_type type instead of bool type for
 __jbd2_journal_clean_checkpoint_list()
To: Ye Bin <yebin10@huawei.com>, <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
	<linux-ext4@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <jack@suse.cz>
References: <20240401011614.3650958-1-yebin10@huawei.com>
From: Zhang Yi <yi.zhang@huawei.com>
Message-ID: <8001bda3-730d-c360-f78f-a3909bf6f02f@huawei.com>
Date: Mon, 1 Apr 2024 10:17:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240401011614.3650958-1-yebin10@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500005.china.huawei.com (7.192.104.229)

On 2024/4/1 9:16, Ye Bin wrote:
> "enum shrink_type" can clearly express the meaning of the parameter of
> __jbd2_journal_clean_checkpoint_list(), and there is no need to use the
> bool type.
> 
> Signed-off-by: Ye Bin <yebin10@huawei.com>

Make sense, thanks for the cleanup.

Reviewed-by: Zhang Yi <yi.zhang@huawei.com>

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
> 

