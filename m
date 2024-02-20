Return-Path: <linux-ext4+bounces-1288-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0FAA85B2F2
	for <lists+linux-ext4@lfdr.de>; Tue, 20 Feb 2024 07:31:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AD53286D28
	for <lists+linux-ext4@lfdr.de>; Tue, 20 Feb 2024 06:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 384121EB42;
	Tue, 20 Feb 2024 06:31:36 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0972D29A8;
	Tue, 20 Feb 2024 06:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708410695; cv=none; b=T0JqMWlkQRa78DdC352yxoWbK+qVZXUeggpMNc6ZeX6xvln8IzYeqIu5P3MQ81Vz0ldaZv1kDlR2z805x8Rk4xjgYeBsi44nVU92kQjaM8+ieUElf9POpoDXMzd+r+7ZpK8iJ3FhyF+1/au6BhMtPKpsuNdprJXIdbDpZI98J2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708410695; c=relaxed/simple;
	bh=P2xhFqP/sLJefSBnZs/bXJGtSX+uYWG8SN57iAHNZyA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=d2/2wALcIFJIDsjrU7Z0mCdl7AqhG4SJvxCMU/B1vnRFv6oSunu5Ps01qzz28eYlLTKb6H/r5izAUkwa8F8BQwW3QHEdSzTU2BygIMh5PT/jPpygGCQJijuJXLR9s6xvuirFgPwwCcphKKtgVRdNX9hBBrsB8AXfDQpjvq5RZYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Tf8g42lQtzqj7r;
	Tue, 20 Feb 2024 14:30:56 +0800 (CST)
Received: from dggpeml500021.china.huawei.com (unknown [7.185.36.21])
	by mail.maildlp.com (Postfix) with ESMTPS id 0D4911402DE;
	Tue, 20 Feb 2024 14:31:30 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 20 Feb 2024 14:31:29 +0800
Message-ID: <2fdd3948-0fa0-c8af-a5b4-ce595314f9ac@huawei.com>
Date: Tue, 20 Feb 2024 14:31:29 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH 5/7] ext4: fix slab-out-of-bounds in
 ext4_mb_find_good_group_avg_frag_lists()
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
CC: <linux-ext4@vger.kernel.org>, <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
	<jack@suse.cz>, <ritesh.list@gmail.com>, <linux-kernel@vger.kernel.org>,
	<yi.zhang@huawei.com>, <yangerkun@huawei.com>, <chengzhihao1@huawei.com>,
	<yukuai3@huawei.com>, <stable@vger.kernel.org>, Baokun Li
	<libaokun1@huawei.com>
References: <20240126085716.1363019-1-libaokun1@huawei.com>
 <20240126085716.1363019-6-libaokun1@huawei.com>
 <ZdQ7FEA7KC4eAMpg@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
Content-Language: en-US
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <ZdQ7FEA7KC4eAMpg@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500021.china.huawei.com (7.185.36.21)

On 2024/2/20 13:39, Ojaswin Mujoo wrote:
> On Fri, Jan 26, 2024 at 04:57:14PM +0800, Baokun Li wrote:
>
> Hey Baokun,
>
> Good catch! I've added some minor comments below. Other than that feel
> free to add
>
> Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
>
>> We can trigger a slab-out-of-bounds with the following commands:
>>
>>      mkfs.ext4 -F /dev/$disk 10G
>>      mount /dev/$disk /tmp/test
>>      echo 2147483647 > /sys/fs/ext4/$disk/mb_group_prealloc
>>      echo test > /tmp/test/file && sync
>>
>> ==================================================================
>> BUG: KASAN: slab-out-of-bounds in ext4_mb_find_good_group_avg_frag_lists+0x8a/0x200 [ext4]
>> Read of size 8 at addr ffff888121b9d0f0 by task kworker/u2:0/11
>> CPU: 0 PID: 11 Comm: kworker/u2:0 Tainted: GL 6.7.0-next-20240118 #521
>> Call Trace:
>>   dump_stack_lvl+0x2c/0x50
>>   kasan_report+0xb6/0xf0
>>   ext4_mb_find_good_group_avg_frag_lists+0x8a/0x200 [ext4]
>>   ext4_mb_regular_allocator+0x19e9/0x2370 [ext4]
>>   ext4_mb_new_blocks+0x88a/0x1370 [ext4]
>>   ext4_ext_map_blocks+0x14f7/0x2390 [ext4]
>>   ext4_map_blocks+0x569/0xea0 [ext4]
>>   ext4_do_writepages+0x10f6/0x1bc0 [ext4]
>> [...]
>> ==================================================================
>>
>> The flow of issue triggering is as follows:
>>
>> // Set s_mb_group_prealloc to 2147483647 via sysfs
>> ext4_mb_new_blocks
>>    ext4_mb_normalize_request
>>      ext4_mb_normalize_group_request
>>        ac->ac_g_ex.fe_len = EXT4_SB(sb)->s_mb_group_prealloc
>>    ext4_mb_regular_allocator
>>      ext4_mb_choose_next_group
>>        ext4_mb_choose_next_group_best_avail
>>          mb_avg_fragment_size_order
>>            order = fls(len) - 2 = 29
>>          ext4_mb_find_good_group_avg_frag_lists
>>            frag_list = &sbi->s_mb_avg_fragment_size[order]
>>            if (list_empty(frag_list)) // Trigger SOOB!
>>
>> At 4k block size, the length of the s_mb_avg_fragment_size list is 14, but
>> an oversized s_mb_group_prealloc is set, causing slab-out-of-bounds to be
>> triggered by an attempt to access an element at index 29.
>>
>> Therefore it is not allowed to set s_mb_group_prealloc to a value greater
>> than s_clusters_per_group via sysfs, and to avoid returning an order from
>> mb_avg_fragment_size_order() that is greater than MB_NUM_ORDERS(sb).
>>
>> Fixes: 7e170922f06b ("ext4: Add allocation criteria 1.5 (CR1_5)")
>> CC: stable@vger.kernel.org
>> Signed-off-by: Baokun Li <libaokun1@huawei.com>
>> ---
>>   fs/ext4/mballoc.c | 2 ++
>>   fs/ext4/sysfs.c   | 9 ++++++++-
>>   2 files changed, 10 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
>> index f44f668e407f..1ea6491b6b00 100644
>> --- a/fs/ext4/mballoc.c
>> +++ b/fs/ext4/mballoc.c
>> @@ -832,6 +832,8 @@ static int mb_avg_fragment_size_order(struct super_block *sb, ext4_grpblk_t len)
>>      return 0;
>>    if (order == MB_NUM_ORDERS(sb))
>>      order--;
>> + if (WARN_ON_ONCE(order > MB_NUM_ORDERS(sb)))
>> +   order = MB_NUM_ORDERS(sb) - 1;
>>    return order;
>>   }
> So along with this change, I think it'll also be good to add an extra
> check in ext4_mb_choose_next_group_best_avail() as:
>
>    if (1 << min_order < ac->ac_o_ex.fe_len)
>      min_order = fls(ac->ac_o_ex.fe_len);
>   
> + if (order >= MB_NUM_ORDERS(ac->ac_sb))
> +   order = MB_NUM_ORDERS(ac->ac_sb) - 1;
> +
>    for (i = order; i >= min_order; i--) {
>      int frag_order;
>      /*
>
>
> The reason for this is that otherwise when order is large eg 29,
> we would unnecessarily loop from i=29 to i=13 while always
> looking at the same avg_fragment_list[13].
>
> Regards,
> ojaswin


Yeah, good point! This will cut down on some unnecessary loops.

I'll add this extra check in the next version.

Thanks for having a look!

-- 
With Best Regards,
Baokun Li
.

