Return-Path: <linux-ext4+bounces-5974-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 282CDA05179
	for <lists+linux-ext4@lfdr.de>; Wed,  8 Jan 2025 04:13:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 604DC1888C89
	for <lists+linux-ext4@lfdr.de>; Wed,  8 Jan 2025 03:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B59AA199EAF;
	Wed,  8 Jan 2025 03:13:11 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CAE6189905;
	Wed,  8 Jan 2025 03:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736305991; cv=none; b=b0yQuNT3fhce1Ws9cntdXmbE/hDhrFZRXo+wvyp7oweu8Io++lVIbQ2MWDwybZcdHNIs2V0tjWzFXsg1qnzZUFvqQV/NY7pWXfCu5LcZ4YGOcXvJpnycOReXW0FkpPdM70r8hH0hzhekcAEDgY8MgyLDHmBK9wxhTN6Am7JscVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736305991; c=relaxed/simple;
	bh=kBey9aA+pYD3dzXs6+3rV4EWdOR1RGyrvenUBfQaRVM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=itvP7RmNmcU+A71/94cAf3SEV8N4hZt1ikjFkpB0zD0m8dBN01H8YMDDIIgE66t0ANs4WieLGSPuVn9cUr/Pg741xoNJUmv3+cZ+sNGRQ1bq9Pv4/XZd0XUTCSB8c6hZV+opkuAdWZObreDgrgxfPn/ADLDd48KpPIQqThcO6eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4YSXx04Y19zRkl6;
	Wed,  8 Jan 2025 11:10:44 +0800 (CST)
Received: from kwepemf100017.china.huawei.com (unknown [7.202.181.16])
	by mail.maildlp.com (Postfix) with ESMTPS id 90AB418010B;
	Wed,  8 Jan 2025 11:12:59 +0800 (CST)
Received: from [10.174.179.80] (10.174.179.80) by
 kwepemf100017.china.huawei.com (7.202.181.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 8 Jan 2025 11:12:58 +0800
Message-ID: <1e9d3fa3-7951-4d26-a63a-d16927cb4a78@huawei.com>
Date: Wed, 8 Jan 2025 11:12:58 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] jbd2: remove stale comment of update_t_max_wait
To: Kemeng Shi <shikemeng@huaweicloud.com>
CC: <linux-ext4@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<tytso@mit.edu>, <jack@suse.com>
References: <20241224202707.1530558-1-shikemeng@huaweicloud.com>
 <20241224202707.1530558-5-shikemeng@huaweicloud.com>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huawei.com>
In-Reply-To: <20241224202707.1530558-5-shikemeng@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemf100017.china.huawei.com (7.202.181.16)

On 2024/12/25 4:27, Kemeng Shi wrote:
> Commit 2d44292058828 "jbd2: remove CONFIG_JBD2_DEBUG to update t_max_wait"
> removed jbd2_journal_enable_debug, just remove stale comment about
> jbd2_journal_enable_debug.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> ---
>  fs/jbd2/transaction.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
> index 66513c18ca29..e00b87635512 100644
> --- a/fs/jbd2/transaction.c
> +++ b/fs/jbd2/transaction.c
> @@ -119,7 +119,6 @@ static void jbd2_get_transaction(journal_t *journal,
>   * t_max_wait is carefully updated here with use of atomic compare exchange.
>   * Note that there could be multiplre threads trying to do this simultaneously
>   * hence using cmpxchg to avoid any use of locks in this case.
> - * With this t_max_wait can be updated w/o enabling jbd2_journal_enable_debug.
>   */
>  static inline void update_t_max_wait(transaction_t *transaction,
>  				     unsigned long ts)

Hi, Kemeng,

It seems that the first sentence in this comment should be removed
together, as it also appears staled.

  "Update transaction's maximum wait time, if debugging is enabled."

Thanks,
Yi.

