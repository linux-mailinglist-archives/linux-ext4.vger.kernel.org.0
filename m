Return-Path: <linux-ext4+bounces-9596-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C926B3369B
	for <lists+linux-ext4@lfdr.de>; Mon, 25 Aug 2025 08:42:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D73671897156
	for <lists+linux-ext4@lfdr.de>; Mon, 25 Aug 2025 06:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5DDA283FDE;
	Mon, 25 Aug 2025 06:40:16 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9748B283FD7;
	Mon, 25 Aug 2025 06:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756104016; cv=none; b=JL66qgO1bVzf9xOZf67gOyXv3uDyRNvr0T1p3I0J6yf5mgbfchKwEnopYzBAGIa0tBismoqNdC1bVmh1N2oHT4SL6wQoHmoSp9xEcoAq1ykMPSWhHYXCkKHJ0YEBlC/7gYSSWGrT723PVOmAhgkhSccV88hWqqnczi6rCz579BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756104016; c=relaxed/simple;
	bh=hrwFPrss3rkO4wgDjPMx5OanWYmu6XnbNUfK3XiMZVs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ajNK+US8RIKziha3kKtlBPzY/L+T8S67XmvF5cYZuIDbEdFF3sgkr+3KeEXR0ZIlnYdY43FGYFic21jrOm220ylFkZ8wEHqhQvNubFc3MFAGeF2OiUM5bt0lDnvlz1kAUXnS6drMioalP8+TjVup0n3vfs5Rhagns7JXYy5MNUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4c9LmD5SkBz27jBq;
	Mon, 25 Aug 2025 14:41:16 +0800 (CST)
Received: from dggpemf500013.china.huawei.com (unknown [7.185.36.188])
	by mail.maildlp.com (Postfix) with ESMTPS id 89C2C140298;
	Mon, 25 Aug 2025 14:40:10 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.71) by dggpemf500013.china.huawei.com
 (7.185.36.188) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 25 Aug
 2025 14:40:09 +0800
Message-ID: <c1b10723-342f-49fd-b952-709353aff7e4@huawei.com>
Date: Mon, 25 Aug 2025 14:40:08 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ext4: fix potential null deref in ext4_mb_init()
Content-Language: en-GB
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
CC: <linux-ext4@vger.kernel.org>, <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
	<jack@suse.cz>, <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>,
	<yangerkun@huawei.com>, <libaokun@huaweicloud.com>,
	<syzbot+1713b1aa266195b916c2@syzkaller.appspotmail.com>, Baokun Li
	<libaokun1@huawei.com>
References: <20250825033830.2230202-1-libaokun@huaweicloud.com>
 <87349g9hh8.fsf@gmail.com>
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <87349g9hh8.fsf@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 dggpemf500013.china.huawei.com (7.185.36.188)

On 2025-08-25 12:02, Ritesh Harjani (IBM) wrote:
> libaokun@huaweicloud.com writes:
>
>> From: Baokun Li <libaokun1@huawei.com>
>>
>> In ext4_mb_init(), ext4_mb_avg_fragment_size_destroy() may be called
>> when sbi->s_mb_avg_fragment_size remains uninitialized (e.g., if groupinfo
>> slab cache allocation fails). Since ext4_mb_avg_fragment_size_destroy()
>> lacks null pointer checking, this leads to a null pointer dereference.
>>
>> ==================================================================
>> EXT4-fs: no memory for groupinfo slab cache
>> BUG: kernel NULL pointer dereference, address: 0000000000000000
>> PGD 0 P4D 0
>> Oops: Oops: 0002 [#1] SMP PTI
>> CPU:2 UID: 0 PID: 87 Comm:mount Not tainted 6.17.0-rc2 #1134 PREEMPT(none)
>> RIP: 0010:_raw_spin_lock_irqsave+0x1b/0x40
>> Call Trace:
>>  <TASK>
>>  xa_destroy+0x61/0x130
>>  ext4_mb_init+0x483/0x540
>>  __ext4_fill_super+0x116d/0x17b0
>>  ext4_fill_super+0xd3/0x280
>>  get_tree_bdev_flags+0x132/0x1d0
>>  vfs_get_tree+0x29/0xd0
>>  do_new_mount+0x197/0x300
>>  __x64_sys_mount+0x116/0x150
>>  do_syscall_64+0x50/0x1c0
>>  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>> ==================================================================
>>
>> Therefore, add necessary null check to ext4_mb_avg_fragment_size_destroy()
>> to prevent this issue. The same fix is also applied to
>> ext4_mb_largest_free_orders_destroy().
>>
>> Reported-by: syzbot+1713b1aa266195b916c2@syzkaller.appspotmail.com
>> Closes: https://syzkaller.appspot.com/bug?extid=1713b1aa266195b916c2
>> Fixes: f7eaacbb4e54 ("ext4: convert free groups order lists to xarrays")
>> Signed-off-by: Baokun Li <libaokun1@huawei.com>
>> ---
>>  fs/ext4/mballoc.c | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
> I was just looking at the syzbot report. You submitted the fix pretty
> fast ;)
Since this code was introduced by me, when I saw the syzbot report,
I immediately realized that my previous changes had unintentionally
removed the null pointer check...
> Since these two functions can get called in error handling routine, we
> should check for null before iterating over the uninitalized array.
Yes, when making the changes, I missed the implicit null pointer check
within kfree. Sorry for this oversight.
>
> The fix looks good to me. Please feel free to add:
> Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>
> -ritesh
>
Thanks for the review!


Cheers,
Baokun

>> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
>> index 5898d92ba19f..6070d3c86678 100644
>> --- a/fs/ext4/mballoc.c
>> +++ b/fs/ext4/mballoc.c
>> @@ -3655,16 +3655,26 @@ static void ext4_discard_work(struct work_struct *work)
>>  
>>  static inline void ext4_mb_avg_fragment_size_destroy(struct ext4_sb_info *sbi)
>>  {
>> +	if (!sbi->s_mb_avg_fragment_size)
>> +		return;
>> +
>>  	for (int i = 0; i < MB_NUM_ORDERS(sbi->s_sb); i++)
>>  		xa_destroy(&sbi->s_mb_avg_fragment_size[i]);
>> +
>>  	kfree(sbi->s_mb_avg_fragment_size);
>> +	sbi->s_mb_avg_fragment_size = NULL;
>>  }
>>  
>>  static inline void ext4_mb_largest_free_orders_destroy(struct ext4_sb_info *sbi)
>>  {
>> +	if (!sbi->s_mb_largest_free_orders)
>> +		return;
>> +
>>  	for (int i = 0; i < MB_NUM_ORDERS(sbi->s_sb); i++)
>>  		xa_destroy(&sbi->s_mb_largest_free_orders[i]);
>> +
>>  	kfree(sbi->s_mb_largest_free_orders);
>> +	sbi->s_mb_largest_free_orders = NULL;
>>  }
>>  
>>  int ext4_mb_init(struct super_block *sb)
>> -- 
>> 2.46.1



