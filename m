Return-Path: <linux-ext4+bounces-8700-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFFE9AED4F7
	for <lists+linux-ext4@lfdr.de>; Mon, 30 Jun 2025 08:54:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30AD81731F2
	for <lists+linux-ext4@lfdr.de>; Mon, 30 Jun 2025 06:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A655E202F79;
	Mon, 30 Jun 2025 06:53:53 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06ACE2A1CA;
	Mon, 30 Jun 2025 06:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751266433; cv=none; b=cV/JG32N4L6Y6ujGJzzFYU1lSfnyhXQanr++Pf6yPRZ2utLwb+luWpe2EmTFmlPXNbkWG4iA4RWmFwATK0tZd1KihyruOmI4jYW3IMYgMlxyw7C/sai3CE7AuTESYfO3jHSmDLWzSsKIVuJfG/ImxNT7HKgGcPAnai/yONB/2tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751266433; c=relaxed/simple;
	bh=yRFqEHoJQzbPVzLUCQehKeaWsx+eIRFoUN+yQRANVjE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=b/bsP82gOzg8bxG83+rgWaNT+BKRjCUWCBr/vJVGVnlZ/z94WLva+/UTx2tlyRsexAYSIQU0k6gQFpTxGknECC1hd8EXua3TwwWtD6ODHrxdh2pRNoju35yqrhUJAH99qU/ZhRHR/xb/xEopyvLFQ88Au0InCux6K6XWmfuja6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4bVxg66PFzztSd8;
	Mon, 30 Jun 2025 14:52:34 +0800 (CST)
Received: from dggpemf500013.china.huawei.com (unknown [7.185.36.188])
	by mail.maildlp.com (Postfix) with ESMTPS id 17C10140257;
	Mon, 30 Jun 2025 14:53:43 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.71) by dggpemf500013.china.huawei.com
 (7.185.36.188) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 30 Jun
 2025 14:53:42 +0800
Message-ID: <649000b5-dd4d-4b08-8615-be07fdfdfe5e@huawei.com>
Date: Mon, 30 Jun 2025 14:53:41 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/16] ext4: fix zombie groups in average fragment size
 lists
To: Jan Kara <jack@suse.cz>
CC: <linux-ext4@vger.kernel.org>, <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
	<ojaswin@linux.ibm.com>, <linux-kernel@vger.kernel.org>,
	<yi.zhang@huawei.com>, <yangerkun@huawei.com>, <stable@vger.kernel.org>,
	Baokun Li <libaokun1@huawei.com>
References: <20250623073304.3275702-1-libaokun1@huawei.com>
 <20250623073304.3275702-10-libaokun1@huawei.com>
 <pouh5hfd7lswwhczu667k2pywuawaetvv4lr44zinexbb75jeu@rgaaqa5myop7>
Content-Language: en-US
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <pouh5hfd7lswwhczu667k2pywuawaetvv4lr44zinexbb75jeu@rgaaqa5myop7>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 dggpemf500013.china.huawei.com (7.185.36.188)

On 2025/6/28 3:14, Jan Kara wrote:
> On Mon 23-06-25 15:32:57, Baokun Li wrote:
>> Groups with no free blocks shouldn't be in any average fragment size list.
>> However, when all blocks in a group are allocated(i.e., bb_fragments or
>> bb_free is 0), we currently skip updating the average fragment size, which
>> means the group isn't removed from its previous s_mb_avg_fragment_size[old]
>> list.
>>
>> This created "zombie" groups that were always skipped during traversal as
>> they couldn't satisfy any block allocation requests, negatively impacting
>> traversal efficiency.
>>
>> Therefore, when a group becomes completely free, bb_avg_fragment_size_order
> 					     ^^^ full

Oh, thank you for pointing out that typo!
I'll correct it in the next version.


Thanks,
Baokun

>> is now set to -1. If the old order was not -1, a removal operation is
>> performed; if the new order is not -1, an insertion is performed.
>>
>> Fixes: 196e402adf2e ("ext4: improve cr 0 / cr 1 group scanning")
>> CC: stable@vger.kernel.org
>> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> Good catch! The patch looks good. Feel free to add:
>
> Reviewed-by: Jan Kara <jack@suse.cz>
>
> 								Honza
>
>> ---
>>   fs/ext4/mballoc.c | 36 ++++++++++++++++++------------------
>>   1 file changed, 18 insertions(+), 18 deletions(-)
>>
>> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
>> index 94950b07a577..e6d6c2da3c6e 100644
>> --- a/fs/ext4/mballoc.c
>> +++ b/fs/ext4/mballoc.c
>> @@ -841,30 +841,30 @@ static void
>>   mb_update_avg_fragment_size(struct super_block *sb, struct ext4_group_info *grp)
>>   {
>>   	struct ext4_sb_info *sbi = EXT4_SB(sb);
>> -	int new_order;
>> +	int new, old;
>>   
>> -	if (!test_opt2(sb, MB_OPTIMIZE_SCAN) || grp->bb_fragments == 0)
>> +	if (!test_opt2(sb, MB_OPTIMIZE_SCAN))
>>   		return;
>>   
>> -	new_order = mb_avg_fragment_size_order(sb,
>> -					grp->bb_free / grp->bb_fragments);
>> -	if (new_order == grp->bb_avg_fragment_size_order)
>> +	old = grp->bb_avg_fragment_size_order;
>> +	new = grp->bb_fragments == 0 ? -1 :
>> +	      mb_avg_fragment_size_order(sb, grp->bb_free / grp->bb_fragments);
>> +	if (new == old)
>>   		return;
>>   
>> -	if (grp->bb_avg_fragment_size_order != -1) {
>> -		write_lock(&sbi->s_mb_avg_fragment_size_locks[
>> -					grp->bb_avg_fragment_size_order]);
>> +	if (old >= 0) {
>> +		write_lock(&sbi->s_mb_avg_fragment_size_locks[old]);
>>   		list_del(&grp->bb_avg_fragment_size_node);
>> -		write_unlock(&sbi->s_mb_avg_fragment_size_locks[
>> -					grp->bb_avg_fragment_size_order]);
>> -	}
>> -	grp->bb_avg_fragment_size_order = new_order;
>> -	write_lock(&sbi->s_mb_avg_fragment_size_locks[
>> -					grp->bb_avg_fragment_size_order]);
>> -	list_add_tail(&grp->bb_avg_fragment_size_node,
>> -		&sbi->s_mb_avg_fragment_size[grp->bb_avg_fragment_size_order]);
>> -	write_unlock(&sbi->s_mb_avg_fragment_size_locks[
>> -					grp->bb_avg_fragment_size_order]);
>> +		write_unlock(&sbi->s_mb_avg_fragment_size_locks[old]);
>> +	}
>> +
>> +	grp->bb_avg_fragment_size_order = new;
>> +	if (new >= 0) {
>> +		write_lock(&sbi->s_mb_avg_fragment_size_locks[new]);
>> +		list_add_tail(&grp->bb_avg_fragment_size_node,
>> +				&sbi->s_mb_avg_fragment_size[new]);
>> +		write_unlock(&sbi->s_mb_avg_fragment_size_locks[new]);
>> +	}
>>   }
>>   
>>   /*
>> -- 
>> 2.46.1
>>


