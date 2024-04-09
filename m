Return-Path: <linux-ext4+bounces-1924-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C354189CFAC
	for <lists+linux-ext4@lfdr.de>; Tue,  9 Apr 2024 03:14:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0963DB21B49
	for <lists+linux-ext4@lfdr.de>; Tue,  9 Apr 2024 01:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB6E86138;
	Tue,  9 Apr 2024 01:14:43 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDA26FA7;
	Tue,  9 Apr 2024 01:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712625283; cv=none; b=ETUnHXGonVUQc32wbNSVNomo6YMm8nYPgkE9Do6DQRx/1QfvIwp+jK2iAkuHoRjBE9idvdO5ga5h7+RlaZzHoJLWSbQSGb1m6E+eVa2yc00kF2pwpmfxeuMxqLaOFIzswvNPbjWYnCAfbrIEqzLRDS5wiOmyarGTfV9GvIxjGd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712625283; c=relaxed/simple;
	bh=x6qPd8VeMbrl8tqohLNQ3poVzzQN5QmHRJgD+RxVN74=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=IYg7WG8wqT532qvsT9rSLPHszQZpf9+4zMyEcZ+NDP+mqVmjwJNOTKqNC5mesVmv2INC2ODDtNjeYmw2fMHk3y9Eo++yuYwD1pP8TSigdfIecEIWKmtj60ReqZT5pjbEFk1OzQL2V1LyeH5frbyP7mMOn1DVQzUxkR1zavReZcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VD7GN5fL9ztRxV;
	Tue,  9 Apr 2024 09:11:56 +0800 (CST)
Received: from canpemm500005.china.huawei.com (unknown [7.192.104.229])
	by mail.maildlp.com (Postfix) with ESMTPS id 6A71614059C;
	Tue,  9 Apr 2024 09:14:38 +0800 (CST)
Received: from [10.174.176.34] (10.174.176.34) by
 canpemm500005.china.huawei.com (7.192.104.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 9 Apr 2024 09:14:37 +0800
Subject: Re: [PATCH v2 2/2] jbd2: add prefix 'jbd2' for 'shrink_type'
To: Ye Bin <yebin10@huawei.com>, <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
	<linux-ext4@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <jack@suse.cz>
References: <20240407065355.1528580-1-yebin10@huawei.com>
 <20240407065355.1528580-3-yebin10@huawei.com>
From: Zhang Yi <yi.zhang@huawei.com>
Message-ID: <2a665a23-7684-a719-4a1c-08136e2f6c46@huawei.com>
Date: Tue, 9 Apr 2024 09:14:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240407065355.1528580-3-yebin10@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500005.china.huawei.com (7.192.104.229)

On 2024/4/7 14:53, Ye Bin wrote:
> As 'shrink_type' is exported. The module prefix 'jbd2' is added to
> distinguish from memory reclamation.
> 
> Signed-off-by: Ye Bin <yebin10@huawei.com>

Looks nice.

Reviewed-by: Zhang Yi <yi.zhang@huawei.com>

> ---
>  fs/jbd2/checkpoint.c | 22 +++++++++++-----------
>  fs/jbd2/commit.c     |  2 +-
>  include/linux/jbd2.h |  4 ++--
>  3 files changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/jbd2/checkpoint.c b/fs/jbd2/checkpoint.c
> index 80c0ab98bc63..951f78634adf 100644
> --- a/fs/jbd2/checkpoint.c
> +++ b/fs/jbd2/checkpoint.c
> @@ -348,7 +348,7 @@ int jbd2_cleanup_journal_tail(journal_t *journal)
>   * Called with j_list_lock held.
>   */
>  static unsigned long journal_shrink_one_cp_list(struct journal_head *jh,
> -						enum shrink_type type,
> +						enum jbd2_shrink_type type,
>  						bool *released)
>  {
>  	struct journal_head *last_jh;
> @@ -365,12 +365,12 @@ static unsigned long journal_shrink_one_cp_list(struct journal_head *jh,
>  		jh = next_jh;
>  		next_jh = jh->b_cpnext;
>  
> -		if (type == SHRINK_DESTROY) {
> +		if (type == JBD2_SHRINK_DESTROY) {
>  			ret = __jbd2_journal_remove_checkpoint(jh);
>  		} else {
>  			ret = jbd2_journal_try_remove_checkpoint(jh);
>  			if (ret < 0) {
> -				if (type == SHRINK_BUSY_SKIP)
> +				if (type == JBD2_SHRINK_BUSY_SKIP)
>  					continue;
>  				break;
>  			}
> @@ -437,7 +437,7 @@ unsigned long jbd2_journal_shrink_checkpoint_list(journal_t *journal,
>  		tid = transaction->t_tid;
>  
>  		freed = journal_shrink_one_cp_list(transaction->t_checkpoint_list,
> -						   SHRINK_BUSY_SKIP, &released);
> +						   JBD2_SHRINK_BUSY_SKIP, &released);
>  		nr_freed += freed;
>  		(*nr_to_scan) -= min(*nr_to_scan, freed);
>  		if (*nr_to_scan == 0)
> @@ -470,20 +470,20 @@ unsigned long jbd2_journal_shrink_checkpoint_list(journal_t *journal,
>   * journal_clean_checkpoint_list
>   *
>   * Find all the written-back checkpoint buffers in the journal and release them.
> - * If 'type' is SHRINK_DESTROY, release all buffers unconditionally. If 'type'
> - * is SHRINK_BUSY_STOP, will stop release buffers if encounters a busy buffer.
> - * To avoid wasting CPU cycles scanning the buffer list in some cases, don't
> - * pass SHRINK_BUSY_SKIP 'type' for this function.
> + * If 'type' is JBD2_SHRINK_DESTROY, release all buffers unconditionally. If
> + * 'type' is JBD2_SHRINK_BUSY_STOP, will stop release buffers if encounters a
> + * busy buffer. To avoid wasting CPU cycles scanning the buffer list in some
> + * cases, don't pass JBD2_SHRINK_BUSY_SKIP 'type' for this function.
>   *
>   * Called with j_list_lock held.
>   */
>  void __jbd2_journal_clean_checkpoint_list(journal_t *journal,
> -					  enum shrink_type type)
> +					  enum jbd2_shrink_type type)
>  {
>  	transaction_t *transaction, *last_transaction, *next_transaction;
>  	bool released;
>  
> -	WARN_ON_ONCE(type == SHRINK_BUSY_SKIP);
> +	WARN_ON_ONCE(type == JBD2_SHRINK_BUSY_SKIP);
>  
>  	transaction = journal->j_checkpoint_transactions;
>  	if (!transaction)
> @@ -529,7 +529,7 @@ void jbd2_journal_destroy_checkpoint(journal_t *journal)
>  			spin_unlock(&journal->j_list_lock);
>  			break;
>  		}
> -		__jbd2_journal_clean_checkpoint_list(journal, SHRINK_DESTROY);
> +		__jbd2_journal_clean_checkpoint_list(journal, JBD2_SHRINK_DESTROY);
>  		spin_unlock(&journal->j_list_lock);
>  		cond_resched();
>  	}
> diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
> index 78ebd04ac97d..65c857ab49ec 100644
> --- a/fs/jbd2/commit.c
> +++ b/fs/jbd2/commit.c
> @@ -501,7 +501,7 @@ void jbd2_journal_commit_transaction(journal_t *journal)
>  	 * frees some memory
>  	 */
>  	spin_lock(&journal->j_list_lock);
> -	__jbd2_journal_clean_checkpoint_list(journal, SHRINK_BUSY_STOP);
> +	__jbd2_journal_clean_checkpoint_list(journal, JBD2_SHRINK_BUSY_STOP);
>  	spin_unlock(&journal->j_list_lock);
>  
>  	jbd2_debug(3, "JBD2: commit phase 1\n");
> diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
> index 58a961999d70..7479f64c0939 100644
> --- a/include/linux/jbd2.h
> +++ b/include/linux/jbd2.h
> @@ -1434,9 +1434,9 @@ void jbd2_update_log_tail(journal_t *journal, tid_t tid, unsigned long block);
>  extern void jbd2_journal_commit_transaction(journal_t *);
>  
>  /* Checkpoint list management */
> -enum shrink_type {SHRINK_DESTROY, SHRINK_BUSY_STOP, SHRINK_BUSY_SKIP};
> +enum jbd2_shrink_type {JBD2_SHRINK_DESTROY, JBD2_SHRINK_BUSY_STOP, JBD2_SHRINK_BUSY_SKIP};
>  
> -void __jbd2_journal_clean_checkpoint_list(journal_t *journal, enum shrink_type type);
> +void __jbd2_journal_clean_checkpoint_list(journal_t *journal, enum jbd2_shrink_type type);
>  unsigned long jbd2_journal_shrink_checkpoint_list(journal_t *journal, unsigned long *nr_to_scan);
>  int __jbd2_journal_remove_checkpoint(struct journal_head *);
>  int jbd2_journal_try_remove_checkpoint(struct journal_head *jh);
> 

