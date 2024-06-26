Return-Path: <linux-ext4+bounces-2951-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38AA59179DE
	for <lists+linux-ext4@lfdr.de>; Wed, 26 Jun 2024 09:39:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0C861F212D5
	for <lists+linux-ext4@lfdr.de>; Wed, 26 Jun 2024 07:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 942E815CD63;
	Wed, 26 Jun 2024 07:38:55 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310AE15B986;
	Wed, 26 Jun 2024 07:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719387535; cv=none; b=dfAE02cxdy07bvylP90gYdEf2AAWoAnOxTk3rOWkTe5uq1UQM42knAzfL2/yCYMXvsogPvREhsm2NLprEApEcLGnWWC8om0rgTM9xHpIR6ulb2X6DV1lSAYZShxww6QZUWOCIqvrAwX6JAuQGt5ICWd+dmK7/VilEWwMIrJAKR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719387535; c=relaxed/simple;
	bh=2YOp45yK0RjlCooNPDqr/f7qe2TM9WhOQKD6Ji3roro=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=lXv3gURJFoS/9PHITvOWzqSTZV5dm9W+fUVCVTY5IfBP8Z9AiDOkjFxAOsJP6KvoE4zidWGK2DZVUBQg3l0QQX1bKIRjRxTF9UU1ezVdDO6sZ6V6qj9nuYbXEYRKkJSWNeHrzRhnFiDyXx2p8b8wc2eJb2OJdJTNtw5EmfpZ0Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4W8D3h1R0RzxThL;
	Wed, 26 Jun 2024 15:34:24 +0800 (CST)
Received: from kwepemf100017.china.huawei.com (unknown [7.202.181.16])
	by mail.maildlp.com (Postfix) with ESMTPS id D50B718006E;
	Wed, 26 Jun 2024 15:38:43 +0800 (CST)
Received: from [10.174.179.80] (10.174.179.80) by
 kwepemf100017.china.huawei.com (7.202.181.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 26 Jun 2024 15:38:43 +0800
Subject: Re: [PATCH v2 3/4] jbd2: Avoid infinite transaction commit loop
To: Jan Kara <jack@suse.cz>
CC: <linux-ext4@vger.kernel.org>, Alexander Coffin
	<alex.coffin@maticrobots.com>, <stable@vger.kernel.org>, Ted Tso
	<tytso@mit.edu>, <chengzhihao1@huawei.com>
References: <20240624165406.12784-1-jack@suse.cz>
 <20240624170127.3253-3-jack@suse.cz>
From: Zhang Yi <yi.zhang@huawei.com>
Message-ID: <2d49e3de-d7e7-2fd1-0b7a-9a3f9e04cd4d@huawei.com>
Date: Wed, 26 Jun 2024 15:38:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240624170127.3253-3-jack@suse.cz>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemf100017.china.huawei.com (7.202.181.16)

On 2024/6/25 1:01, Jan Kara wrote:
> Commit 9f356e5a4f12 ("jbd2: Account descriptor blocks into
> t_outstanding_credits") started to account descriptor blocks into
> transactions outstanding credits. However it didn't appropriately
> decrease the maximum amount of credits available to userspace. Thus if
> the filesystem requests a transaction smaller than
> j_max_transaction_buffers but large enough that when descriptor blocks
> are added the size exceeds j_max_transaction_buffers, we confuse
> add_transaction_credits() into thinking previous handles have grown the
> transaction too much and enter infinite journal commit loop in
> start_this_handle() -> add_transaction_credits() trying to create
> transaction with enough credits available.
> 
Hello Jan!

I understand that the incorrect max transaction limit in
start_this_handle() could lead to infinite loop in
start_this_handle()-> add_transaction_credits() with large enough
userspace credits (from j_max_transaction_buffers - overheads to
j_max_transaction_buffers), but I don't get how could it lead to ran
out of space in the journal commit traction? IIUC, below codes in
add_transaction_credits() could make sure that we have enough space
when committing traction:

static int add_transaction_credits()
{
...
	if (jbd2_log_space_left(journal) < journal->j_max_transaction_buffers) {
		...
		return 1;
		...
	}
...
}

I can't open and download the image Alexander gave, so I can't get to
the bottom of this issue, please let me know what happened with
jbd2_journal_next_log_block().

Thanks,
Yi.

> Fix the problem by properly accounting for transaction space reserved
> for descriptor blocks when verifying requested transaction handle size.
> 
> CC: stable@vger.kernel.org
> Fixes: 9f356e5a4f12 ("jbd2: Account descriptor blocks into t_outstanding_credits")
> Reported-by: Alexander Coffin <alex.coffin@maticrobots.com>
> Link: https://lore.kernel.org/all/CA+hUFcuGs04JHZ_WzA1zGN57+ehL2qmHOt5a7RMpo+rv6Vyxtw@mail.gmail.com
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  fs/jbd2/transaction.c | 21 ++++++++++++++-------
>  1 file changed, 14 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
> index a095f1a3114b..66513c18ca29 100644
> --- a/fs/jbd2/transaction.c
> +++ b/fs/jbd2/transaction.c
> @@ -191,6 +191,13 @@ static void sub_reserved_credits(journal_t *journal, int blocks)
>  	wake_up(&journal->j_wait_reserved);
>  }
>  
> +/* Maximum number of blocks for user transaction payload */
> +static int jbd2_max_user_trans_buffers(journal_t *journal)
> +{
> +	return journal->j_max_transaction_buffers -
> +				journal->j_transaction_overhead_buffers;
> +}
> +
>  /*
>   * Wait until we can add credits for handle to the running transaction.  Called
>   * with j_state_lock held for reading. Returns 0 if handle joined the running
> @@ -240,12 +247,12 @@ __must_hold(&journal->j_state_lock)
>  		 * big to fit this handle? Wait until reserved credits are freed.
>  		 */
>  		if (atomic_read(&journal->j_reserved_credits) + total >
> -		    journal->j_max_transaction_buffers) {
> +		    jbd2_max_user_trans_buffers(journal)) {
>  			read_unlock(&journal->j_state_lock);
>  			jbd2_might_wait_for_commit(journal);
>  			wait_event(journal->j_wait_reserved,
>  				   atomic_read(&journal->j_reserved_credits) + total <=
> -				   journal->j_max_transaction_buffers);
> +				   jbd2_max_user_trans_buffers(journal));
>  			__acquire(&journal->j_state_lock); /* fake out sparse */
>  			return 1;
>  		}
> @@ -285,14 +292,14 @@ __must_hold(&journal->j_state_lock)
>  
>  	needed = atomic_add_return(rsv_blocks, &journal->j_reserved_credits);
>  	/* We allow at most half of a transaction to be reserved */
> -	if (needed > journal->j_max_transaction_buffers / 2) {
> +	if (needed > jbd2_max_user_trans_buffers(journal) / 2) {
>  		sub_reserved_credits(journal, rsv_blocks);
>  		atomic_sub(total, &t->t_outstanding_credits);
>  		read_unlock(&journal->j_state_lock);
>  		jbd2_might_wait_for_commit(journal);
>  		wait_event(journal->j_wait_reserved,
>  			 atomic_read(&journal->j_reserved_credits) + rsv_blocks
> -			 <= journal->j_max_transaction_buffers / 2);
> +			 <= jbd2_max_user_trans_buffers(journal) / 2);
>  		__acquire(&journal->j_state_lock); /* fake out sparse */
>  		return 1;
>  	}
> @@ -322,12 +329,12 @@ static int start_this_handle(journal_t *journal, handle_t *handle,
>  	 * size and limit the number of total credits to not exceed maximum
>  	 * transaction size per operation.
>  	 */
> -	if ((rsv_blocks > journal->j_max_transaction_buffers / 2) ||
> -	    (rsv_blocks + blocks > journal->j_max_transaction_buffers)) {
> +	if (rsv_blocks > jbd2_max_user_trans_buffers(journal) / 2 ||
> +	    rsv_blocks + blocks > jbd2_max_user_trans_buffers(journal)) {
>  		printk(KERN_ERR "JBD2: %s wants too many credits "
>  		       "credits:%d rsv_credits:%d max:%d\n",
>  		       current->comm, blocks, rsv_blocks,
> -		       journal->j_max_transaction_buffers);
> +		       jbd2_max_user_trans_buffers(journal));
>  		WARN_ON(1);
>  		return -ENOSPC;
>  	}
> 

