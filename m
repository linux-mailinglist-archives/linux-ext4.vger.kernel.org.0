Return-Path: <linux-ext4+bounces-5732-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E4A1A9F5F35
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Dec 2024 08:23:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F25677A14C6
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Dec 2024 07:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B6B315886D;
	Wed, 18 Dec 2024 07:23:47 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4BC6155C83;
	Wed, 18 Dec 2024 07:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734506626; cv=none; b=ayX2cQ8B42lVKj+bDSivlolnUHR5GnOsdnEgDQLU+0KfOkk/2XKRtT5BoLapTcYp69a/rQb7hPK4FMF0an2ZHIu0NU/oc5H1T6FFphu+JDZP4AOaj05Cp0TjqcgnpIe+J7l0U4SeErFS35U38PHV5X8owkUDKBCtCd9VCvx/Of4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734506626; c=relaxed/simple;
	bh=S4lyzucd7ASRAhi2JQAxVDvjKPFvobbSiM/RkXuR46M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s91N9gozFZ9NoGmEw64ETKU1+SG7ii2LJ1mFMzNkb4B2VY0v2XmeXtDmNNARmYedWUcRrEvMIxN9hplPSUvikzuudfc6n4YmtX32lZqMpoHrEgpprXKdWIC70CMQr+l9V7xpE+s43Tcj0GCJSMvKckOe3zlSPD7r0VzXwzCUvHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YClX71gkJz4f3l20;
	Wed, 18 Dec 2024 15:23:19 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id BCB171A0568;
	Wed, 18 Dec 2024 15:23:39 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgB3U4d5eGJn9Xa6Ew--.30573S3;
	Wed, 18 Dec 2024 15:23:39 +0800 (CST)
Message-ID: <1d6ce847-dcef-4b46-8f74-1460bf9e9faf@huaweicloud.com>
Date: Wed, 18 Dec 2024 15:23:37 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] jbd2: remove unused transaction->t_private_list
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: dennis.lamerice@gmail.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org, corbet@lwn.net,
 tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.com
References: <20241218145414.1422946-1-shikemeng@huaweicloud.com>
 <20241218145414.1422946-3-shikemeng@huaweicloud.com>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <20241218145414.1422946-3-shikemeng@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgB3U4d5eGJn9Xa6Ew--.30573S3
X-Coremail-Antispam: 1UD129KBjvJXoWxAF1kuw1rtFWxCFWxur1rJFb_yoW5Jw4xpF
	95u3Wxtry0kryUCr1xXF4xJrW2qF4vyrWUGry2k3Z3Ca17Kwn7KFZrtryakF4Dtr4F9a10
	qF129F98Cr4jy37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkv14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWUtVW8
	ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r
	1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij
	64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr
	0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF
	0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUQZ2fUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2024/12/18 22:54, Kemeng Shi wrote:
> After we remove ext4 journal callback, transaction->t_private_list is
> not used anymore. Just remove unused transaction->t_private_list.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>

Looks good to me.

Reviewed-by: Zhang Yi <yi.zhang@huawei.com>

> ---
>  Documentation/filesystems/journalling.rst | 4 +---
>  fs/jbd2/transaction.c                     | 1 -
>  include/linux/jbd2.h                      | 6 ------
>  3 files changed, 1 insertion(+), 10 deletions(-)
> 
> diff --git a/Documentation/filesystems/journalling.rst b/Documentation/filesystems/journalling.rst
> index 0254f7d57429..863e93e623f7 100644
> --- a/Documentation/filesystems/journalling.rst
> +++ b/Documentation/filesystems/journalling.rst
> @@ -111,9 +111,7 @@ a callback function when the transaction is finally committed to disk,
>  so that you can do some of your own management. You ask the journalling
>  layer for calling the callback by simply setting
>  ``journal->j_commit_callback`` function pointer and that function is
> -called after each transaction commit. You can also use
> -``transaction->t_private_list`` for attaching entries to a transaction
> -that need processing when the transaction commits.
> +called after each transaction commit.
>  
>  JBD2 also provides a way to block all transaction updates via
>  jbd2_journal_lock_updates() /
> diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
> index 66513c18ca29..9fe17e290c21 100644
> --- a/fs/jbd2/transaction.c
> +++ b/fs/jbd2/transaction.c
> @@ -92,7 +92,6 @@ static void jbd2_get_transaction(journal_t *journal,
>  	atomic_set(&transaction->t_outstanding_revokes, 0);
>  	atomic_set(&transaction->t_handle_count, 0);
>  	INIT_LIST_HEAD(&transaction->t_inode_list);
> -	INIT_LIST_HEAD(&transaction->t_private_list);
>  
>  	/* Set up the commit timer for the new transaction. */
>  	journal->j_commit_timer.expires = round_jiffies_up(transaction->t_expires);
> diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
> index 50f7ea8714bf..90c802e48e23 100644
> --- a/include/linux/jbd2.h
> +++ b/include/linux/jbd2.h
> @@ -700,12 +700,6 @@ struct transaction_s
>  
>  	/* Disk flush needs to be sent to fs partition [no locking] */
>  	int			t_need_data_flush;
> -
> -	/*
> -	 * For use by the filesystem to store fs-specific data
> -	 * structures associated with the transaction
> -	 */
> -	struct list_head	t_private_list;
>  };
>  
>  struct transaction_run_stats_s {


