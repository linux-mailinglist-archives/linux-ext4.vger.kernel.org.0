Return-Path: <linux-ext4+bounces-1923-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0230489CFA5
	for <lists+linux-ext4@lfdr.de>; Tue,  9 Apr 2024 03:12:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92AFF1F22A56
	for <lists+linux-ext4@lfdr.de>; Tue,  9 Apr 2024 01:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F31625CB8;
	Tue,  9 Apr 2024 01:12:13 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDCC71773D;
	Tue,  9 Apr 2024 01:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712625133; cv=none; b=dfkkUg0nyC1PPdmGOErpYtf/D9/4jKlUrC+UcajFCxufqoS0SQsZVj9noYPpULfh38Nje9TlHj1qoHdtqGdo12noRMCAcnF5zOUZyZZ3/n7heeZ7+2fGQmW8eSlyt12Ql2y6UxMAJT+Wt9faJ08dS1N3EZ3aTBpdXAgC+Iho/zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712625133; c=relaxed/simple;
	bh=gcqDFTMvX3s6jet5CsDQiZ2uhJxUVB4vcFnj99xDfoA=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=ga8Uv2Aj+61cCXG+aRUjwykaNTw9bWOYJRIpbWVd+hRb4wEMNLiOvAs2WgXr5a7uWG0L97ZXXVPsOFcR7XraJdvbwHLNPY7Tzy8SNf0oqCJa5x6iSfzzQk74YUYWkoWmi0K0lMSMSmmhOSc3Spj9wr0d11/mT86Kq+aNkN5YObw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4VD7D12jY7zNnJF;
	Tue,  9 Apr 2024 09:09:53 +0800 (CST)
Received: from canpemm500005.china.huawei.com (unknown [7.192.104.229])
	by mail.maildlp.com (Postfix) with ESMTPS id F2E0B14068B;
	Tue,  9 Apr 2024 09:12:07 +0800 (CST)
Received: from [10.174.176.34] (10.174.176.34) by
 canpemm500005.china.huawei.com (7.192.104.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 9 Apr 2024 09:12:07 +0800
Subject: Re: [PATCH v2 1/2] jbd2: use shrink_type type instead of bool type
 for __jbd2_journal_clean_checkpoint_list()
To: Ye Bin <yebin10@huawei.com>, <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
	<linux-ext4@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <jack@suse.cz>
References: <20240407065355.1528580-1-yebin10@huawei.com>
 <20240407065355.1528580-2-yebin10@huawei.com>
From: Zhang Yi <yi.zhang@huawei.com>
Message-ID: <2e73e036-9c79-d95a-d7f3-ecbc72d2ab0a@huawei.com>
Date: Tue, 9 Apr 2024 09:12:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240407065355.1528580-2-yebin10@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500005.china.huawei.com (7.192.104.229)

On 2024/4/7 14:53, Ye Bin wrote:
> "enum shrink_type" can clearly express the meaning of the parameter of
> __jbd2_journal_clean_checkpoint_list(), and there is no need to use the
> bool type.
> 
> Signed-off-by: Ye Bin <yebin10@huawei.com>

Looks good to me.

Reviewed-by: Zhang Yi <yi.zhang@huawei.com>

> ---
>  fs/jbd2/checkpoint.c | 16 +++++++++-------
>  fs/jbd2/commit.c     |  2 +-
>  include/linux/jbd2.h |  4 +++-
>  3 files changed, 13 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/jbd2/checkpoint.c b/fs/jbd2/checkpoint.c
> index 1c97e64c4784..80c0ab98bc63 100644
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
> @@ -472,21 +470,25 @@ unsigned long jbd2_journal_shrink_checkpoint_list(journal_t *journal,
>   * journal_clean_checkpoint_list
>   *
>   * Find all the written-back checkpoint buffers in the journal and release them.
> - * If 'destroy' is set, release all buffers unconditionally.
> + * If 'type' is SHRINK_DESTROY, release all buffers unconditionally. If 'type'
> + * is SHRINK_BUSY_STOP, will stop release buffers if encounters a busy buffer.
> + * To avoid wasting CPU cycles scanning the buffer list in some cases, don't
> + * pass SHRINK_BUSY_SKIP 'type' for this function.
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
> +	WARN_ON_ONCE(type == SHRINK_BUSY_SKIP);
> +
>  	transaction = journal->j_checkpoint_transactions;
>  	if (!transaction)
>  		return;
>  
> -	type = destroy ? SHRINK_DESTROY : SHRINK_BUSY_STOP;
>  	last_transaction = transaction->t_cpprev;
>  	next_transaction = transaction;
>  	do {
> @@ -527,7 +529,7 @@ void jbd2_journal_destroy_checkpoint(journal_t *journal)
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

