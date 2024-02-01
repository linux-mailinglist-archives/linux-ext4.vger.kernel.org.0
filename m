Return-Path: <linux-ext4+bounces-1049-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7176D844FC6
	for <lists+linux-ext4@lfdr.de>; Thu,  1 Feb 2024 04:31:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA1A41F252A5
	for <lists+linux-ext4@lfdr.de>; Thu,  1 Feb 2024 03:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CEC23A8F1;
	Thu,  1 Feb 2024 03:31:13 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F413A8E3;
	Thu,  1 Feb 2024 03:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706758272; cv=none; b=HOhazYntXPpp2RpwvaPhc/PGHOghEu0Ilf2McP4ZTrCi8aoSLndU2D/0QcgVnaa92I666Fzj/DRHtPes+LY2XKDg0yGP5zenCEa3AdyBOgqNcf6FSZ+9LYgOvEvm2kKkDA0TP8Hfnc3ysiGkkdei54Cx1sWeIdcwQUWxT1tdCsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706758272; c=relaxed/simple;
	bh=++2CHZr65fhuecAEhLAFwLhOjI+zPUQIy5KfDz66NW8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=est1+RitBUMH9aymUyViICA1YBPKX/AnfmY8bgHuN2H/wqaD0Dh/LzWM2VVyNBOnMaWm+JNdiIdGTJ2qizu/0lwdBjSigFOX0aMLZ3terD9e9jk8+PTke4PV6649s0N1Csjst/CdbzLVY+t43fbF4eTkBrvJpVlAuQ5dwgKwtSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4TQPT81glzz1FK4W;
	Thu,  1 Feb 2024 11:26:36 +0800 (CST)
Received: from dggpeml500021.china.huawei.com (unknown [7.185.36.21])
	by mail.maildlp.com (Postfix) with ESMTPS id 126E41400D4;
	Thu,  1 Feb 2024 11:31:06 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 1 Feb 2024 11:31:05 +0800
Message-ID: <3630fa7f-b432-7afd-5f79-781bc3b2c5ea@huawei.com>
Date: Thu, 1 Feb 2024 11:31:04 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH] ext4: correct best extent lstart adjustment logic
Content-Language: en-US
To: Jan Kara <jack@suse.cz>
CC: <linux-ext4@vger.kernel.org>, <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
	<ritesh.list@gmail.com>, <linux-kernel@vger.kernel.org>,
	<yi.zhang@huawei.com>, <yangerkun@huawei.com>, <yukuai3@huawei.com>,
	<stable@kernel.org>, Ojaswin Mujoo <ojaswin@linux.ibm.com>, Baokun Li
	<libaokun1@huawei.com>
References: <20240122123332.555370-1-libaokun1@huawei.com>
 <20240131124636.gmxaiex6yqrhvxcj@quack3>
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20240131124636.gmxaiex6yqrhvxcj@quack3>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500021.china.huawei.com (7.185.36.21)

On 2024/1/31 20:46, Jan Kara wrote:
> [Added Ojaswin to CC as an author of the discussed patch]
>
> On Mon 22-01-24 20:33:32, Baokun Li wrote:
>> When yangerkun review commit 93cdf49f6eca ("ext4: Fix best extent lstart
>> adjustment logic in ext4_mb_new_inode_pa()"), it was found that the best
>> extent did not completely cover the original request after adjusting the
>> best extent lstart in ext4_mb_new_inode_pa() as follows:
>>
>>    original request: 2/10(8)
>>    normalized request: 0/64(64)
>>    best extent: 0/9(9)
>>
>> When we check if best ex can be kept at start of goal, ac_o_ex.fe_logical
>> is 2 less than the adjusted best extent logical end 9, so we think the
>> adjustment is done. But obviously 0/9(9) doesn't cover 2/10(8), so we
>> should determine here if the original request logical end is less than or
>> equal to the adjusted best extent logical end.

Hello Jan，

Thanks for the detailed explanation! 😉

> I'm sorry for a bit delayed reply. Why do you think it is a problem if the
> resulting extent doesn't cover the full original range?

We adjust lstart when ac_o_ex.fe_len < ac_b_ex.fe_len and
ac_b_ex.fe_len < ac->ac_orig_goal_len, in which case the length of
the allocation is greater than the length of the original request,
and we would normally assume that this allocation would satisfy
the request for the block allocation without the need for an
additional allocation.

      /* we can't allocate as much as normalizer wants.
       * so, found space must get proper lstart
       * to cover original request */

And the comment in the code states that we need to "cover original
request", but this logic is not fulfilled in the code below, so yangerkun
is very puzzled and presents the above counterexample, so we think
it's a problem.

> We must always
> cover the first block of the original extent so that the allocation makes
> forward progress. But otherwise we choose to align to the start / end of
> the goal range to reduce fragmentation even if we don't cover the whole
> requested range - the rest of the range will be covered by the next
> allocation.
Totally agree, for the example above, if we end up with a total of 64
blocks, then the final extent distribution might look like this:

Before:  [0/9(9)], [9/64(55)]
Patched: [0/2(2)], [2/11(9)], [11/64(53)]

So the question is really whether we expect fewer allocations currently
or fewer fragments later.
> Also there is a problem with trying to cover the whole original
> range described in [1]. Essentially the goal range does not need to cover
> the whole original range and if we try to align the allocated range to
> cover the whole original range, it may result in exceeding the goal range
> and thus overlapping preallocations and triggering asserts in the prealloc
> code.
>
> So if we decided we want to handle the case you describe in a better way,
> we'd need something making sure we don't exceed the goal range.
>
> 								Honza
>
> [1] https://lore.kernel.org/all/Y+UzQJRIJEiAr4Z4@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com/
goal_start          B    original_start   A              goal_end
   |-----------------|----------*----------|-----------------|
      best_ex_len                              best_ex_len

The current logic guarantees that the goal range will not be exceeded.
If original_start + best_ex_len > goal_end, then in case1 the ex_end
will be adjusted to align with the goal_end, and if the
goal_end < original_end, then another block allocation will be triggered,
which is fine. But in other cases, we can guarantee that the original
request will be covered by the adjusted best ex.

The problem is that in case2, when we aligned ex_fe_start with
goal_start, we exited the alignment as soon as we contained the
original_start, which may not have contained the original_end and
triggered an additional block allocation, but if we jumped to case3
we could cover the entire original request.

In general, this patch will not cause the goal range to be exceeded.
>> Moreover, the best extent len is not modified during the adjustment
>> process, and it is already checked by the previous assertion, so replace
>> the check for fe_len with a check for the best extent logical end.
>>
>> Cc: stable@kernel.org
>> Fixes: 93cdf49f6eca ("ext4: Fix best extent lstart adjustment logic in ext4_mb_new_inode_pa()")
>> Signed-off-by: yangerkun <yangerkun@huawei.com>
>> Signed-off-by: Baokun Li <libaokun1@huawei.com>
>> ---
>>   fs/ext4/mballoc.c | 7 ++++---
>>   1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
>> index f44f668e407f..fa5977fe8d72 100644
>> --- a/fs/ext4/mballoc.c
>> +++ b/fs/ext4/mballoc.c
>> @@ -5146,6 +5146,7 @@ ext4_mb_new_inode_pa(struct ext4_allocation_context *ac)
>>   			.fe_len = ac->ac_orig_goal_len,
>>   		};
>>   		loff_t orig_goal_end = extent_logical_end(sbi, &ex);
>> +		loff_t o_ex_end = extent_logical_end(sbi, &ac->ac_o_ex);
>>   
>>   		/* we can't allocate as much as normalizer wants.
>>   		 * so, found space must get proper lstart
>> @@ -5161,7 +5162,7 @@ ext4_mb_new_inode_pa(struct ext4_allocation_context *ac)
>>   		 * 1. Check if best ex can be kept at end of goal (before
>>   		 *    cr_best_avail trimmed it) and still cover original start
>>   		 * 2. Else, check if best ex can be kept at start of goal and
>> -		 *    still cover original start
>> +		 *    still cover original end
>>   		 * 3. Else, keep the best ex at start of original request.
>>   		 */
>>   		ex.fe_len = ac->ac_b_ex.fe_len;
>> @@ -5171,7 +5172,7 @@ ext4_mb_new_inode_pa(struct ext4_allocation_context *ac)
>>   			goto adjust_bex;
>>   
>>   		ex.fe_logical = ac->ac_g_ex.fe_logical;
>> -		if (ac->ac_o_ex.fe_logical < extent_logical_end(sbi, &ex))
>> +		if (o_ex_end <= extent_logical_end(sbi, &ex))
>>   			goto adjust_bex;
>>   
>>   		ex.fe_logical = ac->ac_o_ex.fe_logical;
>> @@ -5179,7 +5180,7 @@ ext4_mb_new_inode_pa(struct ext4_allocation_context *ac)
>>   		ac->ac_b_ex.fe_logical = ex.fe_logical;
>>   
>>   		BUG_ON(ac->ac_o_ex.fe_logical < ac->ac_b_ex.fe_logical);
>> -		BUG_ON(ac->ac_o_ex.fe_len > ac->ac_b_ex.fe_len);
>> +		BUG_ON(o_ex_end > extent_logical_end(sbi, &ex));
>>   		BUG_ON(extent_logical_end(sbi, &ex) > orig_goal_end);
>>   	}
>>   
>> -- 
>> 2.31.1
>>
Cheers!
-- 
With Best Regards,
Baokun Li
.

