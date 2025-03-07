Return-Path: <linux-ext4+bounces-6699-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1777A55C94
	for <lists+linux-ext4@lfdr.de>; Fri,  7 Mar 2025 02:03:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3AC877A4D8F
	for <lists+linux-ext4@lfdr.de>; Fri,  7 Mar 2025 01:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 736A41494CC;
	Fri,  7 Mar 2025 01:02:52 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBBBC14830A;
	Fri,  7 Mar 2025 01:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741309372; cv=none; b=orEootIWYHz5a/IIu4aY+IGBclyQGXNnWdiUp96KnNhyBLjfrsxi3Y1tSEuRWWiIUT53IH9iKpNaJYgk9OoyD5NW3CYrMT+nMvRfrjhGrC8X8hZulGj61bQMP7g/jXnhRx1yLCwLz4o3+zPg7QdzVOHTRGx6ycirXfJ1be2BuSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741309372; c=relaxed/simple;
	bh=rHoZRuHrZyKIgwOgWEruuTSdd8F1g/1ItTDHnvwS+cA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=g5hshDa9+vknv3AC1+O7vBNR7S/1s/SZPaVKiFx7lAb+f5EWb3MG/eJTydrCUtjLlEGHYdmQyRD12mJNUERNme44h+gx06hzZoUiIDDxhVS5PYyeZPYyF24ybKAgIXyVcwxq+MTFL2s0sjUQiOyA9XLyWeYAieLoqqK15I3NTVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Z87Jl1bK0zpbX2;
	Fri,  7 Mar 2025 09:01:11 +0800 (CST)
Received: from kwepemf100017.china.huawei.com (unknown [7.202.181.16])
	by mail.maildlp.com (Postfix) with ESMTPS id 88D3E140157;
	Fri,  7 Mar 2025 09:02:41 +0800 (CST)
Received: from [10.174.179.80] (10.174.179.80) by
 kwepemf100017.china.huawei.com (7.202.181.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 7 Mar 2025 09:02:40 +0800
Message-ID: <94ee6407-0d67-48cb-8252-f0fd8c5aa14b@huawei.com>
Date: Fri, 7 Mar 2025 09:02:39 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] jbd2: remove jbd2_journal_unfile_buffer()
To: <libaokun@huaweicloud.com>
CC: <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
	<linux-kernel@vger.kernel.org>, <yangerkun@huawei.com>, Baokun Li
	<libaokun1@huawei.com>, <linux-ext4@vger.kernel.org>
References: <20250306063240.157884-1-libaokun@huaweicloud.com>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huawei.com>
In-Reply-To: <20250306063240.157884-1-libaokun@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemf100017.china.huawei.com (7.202.181.16)

On 2025/3/6 14:32, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 
> Since the function jbd2_journal_unfile_buffer() is no longer called
> anywhere after commit e5a120aeb57f ("jbd2: remove journal_head from
> descriptor buffers"), so let's remove it.
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Looks good to me.

Reviewed-by: Zhang Yi <yi.zhang@huawei.com>

> ---
>  fs/jbd2/transaction.c | 15 ---------------
>  include/linux/jbd2.h  |  1 -
>  2 files changed, 16 deletions(-)
> 
> diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
> index 9fe17e290c21..2bc14291a0fb 100644
> --- a/fs/jbd2/transaction.c
> +++ b/fs/jbd2/transaction.c
> @@ -2078,21 +2078,6 @@ static void __jbd2_journal_unfile_buffer(struct journal_head *jh)
>  	jh->b_transaction = NULL;
>  }
>  
> -void jbd2_journal_unfile_buffer(journal_t *journal, struct journal_head *jh)
> -{
> -	struct buffer_head *bh = jh2bh(jh);
> -
> -	/* Get reference so that buffer cannot be freed before we unlock it */
> -	get_bh(bh);
> -	spin_lock(&jh->b_state_lock);
> -	spin_lock(&journal->j_list_lock);
> -	__jbd2_journal_unfile_buffer(jh);
> -	spin_unlock(&journal->j_list_lock);
> -	spin_unlock(&jh->b_state_lock);
> -	jbd2_journal_put_journal_head(jh);
> -	__brelse(bh);
> -}
> -
>  /**
>   * jbd2_journal_try_to_free_buffers() - try to free page buffers.
>   * @journal: journal for operation
> diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
> index 82ef232935c0..2205c99beff4 100644
> --- a/include/linux/jbd2.h
> +++ b/include/linux/jbd2.h
> @@ -1401,7 +1401,6 @@ JBD2_FEATURE_INCOMPAT_FUNCS(fast_commit,	FAST_COMMIT)
>   */
>  
>  /* Filing buffers */
> -extern void jbd2_journal_unfile_buffer(journal_t *, struct journal_head *);
>  extern bool __jbd2_journal_refile_buffer(struct journal_head *);
>  extern void jbd2_journal_refile_buffer(journal_t *, struct journal_head *);
>  extern void __jbd2_journal_file_buffer(struct journal_head *, transaction_t *, int);


