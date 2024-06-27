Return-Path: <linux-ext4+bounces-2991-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 384F691A001
	for <lists+linux-ext4@lfdr.de>; Thu, 27 Jun 2024 09:08:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6836F1C2124F
	for <lists+linux-ext4@lfdr.de>; Thu, 27 Jun 2024 07:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 744AC46B83;
	Thu, 27 Jun 2024 07:07:54 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DC02263A
	for <linux-ext4@vger.kernel.org>; Thu, 27 Jun 2024 07:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719472074; cv=none; b=RYtXoI6Sdaoz3ISVH+Gu5/hvhYkXm2D+TAVqPrxnws9YNLONqJuxnCWsNMqPkfdHAmRD3RbIVwN08kxO2RibOC6gQlaWLDzfVteqG33dWZArKk641ULWvq7Q2vR++INnV3yFWm1TdmGC5gkpVMuU2I850Q0OZtqyXkoFe41zKIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719472074; c=relaxed/simple;
	bh=uuHHz8bXl0G+NYlis4e+QoUtGSOqDq7HVRzh7s29wO8=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Yik2v/PcUxzf70/I7uz9Rb9Z5D3ZzOEslVElYRXiELr4jzXL4FPTK08BHQgUq2yL0ES7NKGdFfrlcEw/iMTHMG2xMKqCT6VvewKZrqkJzGPNq007MPqE3m+JXS2mLhup0kRjshWErnFuQ7A8iT0NE9gSREagEj6dvNSVluDLl4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4W8qNl1Vsszddms;
	Thu, 27 Jun 2024 15:06:15 +0800 (CST)
Received: from kwepemf100017.china.huawei.com (unknown [7.202.181.16])
	by mail.maildlp.com (Postfix) with ESMTPS id 7BCBC1402CF;
	Thu, 27 Jun 2024 15:07:49 +0800 (CST)
Received: from [10.174.179.80] (10.174.179.80) by
 kwepemf100017.china.huawei.com (7.202.181.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 27 Jun 2024 15:07:48 +0800
Subject: Re: [PATCH v2 4/4] jbd2: Drop pointless shrinker batch initialization
To: Jan Kara <jack@suse.cz>
CC: <linux-ext4@vger.kernel.org>, Alexander Coffin
	<alex.coffin@maticrobots.com>, Ted Tso <tytso@mit.edu>
References: <20240624165406.12784-1-jack@suse.cz>
 <20240624170127.3253-4-jack@suse.cz>
From: Zhang Yi <yi.zhang@huawei.com>
Message-ID: <d686bddf-0b8b-d8a3-765d-690a8f6b72f6@huawei.com>
Date: Thu, 27 Jun 2024 15:07:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240624170127.3253-4-jack@suse.cz>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemf100017.china.huawei.com (7.202.181.16)

On 2024/6/25 1:01, Jan Kara wrote:
> In jbd2_journal_init_common() we set batch size of a shrinker shrinking
> checkpointed buffers to journal->j_max_transaction_buffers. But that is
> guaranteed to be 0 at that point so we effectively stay with the default
> shrinker batch size of 128. It has been like this since introduction of
> jbd2 shrinkers so just drop the pointless initialization.
> 
> Signed-off-by: Jan Kara <jack@suse.cz>

Looks good to me.

Reviewed-by: Zhang Yi <yi.zhang@huawei.com>

> ---
>  fs/jbd2/journal.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> index ae5b544ed0cc..c356cc027ed7 100644
> --- a/fs/jbd2/journal.c
> +++ b/fs/jbd2/journal.c
> @@ -1641,7 +1641,6 @@ static journal_t *journal_init_common(struct block_device *bdev,
>  
>  	journal->j_shrinker->scan_objects = jbd2_journal_shrink_scan;
>  	journal->j_shrinker->count_objects = jbd2_journal_shrink_count;
> -	journal->j_shrinker->batch = journal->j_max_transaction_buffers;
>  	journal->j_shrinker->private_data = journal;
>  
>  	shrinker_register(journal->j_shrinker);
> 

