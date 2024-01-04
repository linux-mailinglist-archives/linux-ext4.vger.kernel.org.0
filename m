Return-Path: <linux-ext4+bounces-679-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B5F18240AD
	for <lists+linux-ext4@lfdr.de>; Thu,  4 Jan 2024 12:32:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DAA0285C02
	for <lists+linux-ext4@lfdr.de>; Thu,  4 Jan 2024 11:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4F5621118;
	Thu,  4 Jan 2024 11:32:04 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D44D210F4;
	Thu,  4 Jan 2024 11:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4T5PYB3DcmzWlkW;
	Thu,  4 Jan 2024 19:31:10 +0800 (CST)
Received: from dggpeml500021.china.huawei.com (unknown [7.185.36.21])
	by mail.maildlp.com (Postfix) with ESMTPS id B3708140487;
	Thu,  4 Jan 2024 19:31:52 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 4 Jan 2024 19:31:52 +0800
Message-ID: <6c93726b-75b8-a6a6-34d3-d0f6c7a1f35d@huawei.com>
Date: Thu, 4 Jan 2024 19:31:51 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH v2 3/8] ext4: regenerate buddy after block freeing failed
 if under fc replay
To: Jan Kara <jack@suse.cz>
CC: <linux-ext4@vger.kernel.org>, <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
	<ritesh.list@gmail.com>, <linux-kernel@vger.kernel.org>,
	<yi.zhang@huawei.com>, <yangerkun@huawei.com>, <yukuai3@huawei.com>, Baokun
 Li <libaokun1@huawei.com>
References: <20231221150558.2740823-1-libaokun1@huawei.com>
 <20231221150558.2740823-4-libaokun1@huawei.com>
 <20240104103336.fjwhqiv2maezquef@quack3>
Content-Language: en-US
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20240104103336.fjwhqiv2maezquef@quack3>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500021.china.huawei.com (7.185.36.21)

On 2024/1/4 18:33, Jan Kara wrote:
> On Thu 21-12-23 23:05:53, Baokun Li wrote:
>> This reverts [Fixes] under fast commit replay. When we are freeing blocks
>> that have already been freed, the buddy may be corrupted, and we need to
>> regenerate the buddy when the fast commit is being replayed in order to
>> avoid using an corrupted buddy, since it will not mark the group block
>> bitmap as corrupted at that point.
> I'd rephrase the changelog as:
>
> This mostly reverts commit 6bd97bf273bd ("ext4: remove redundant
> mb_regenerate_buddy()") and reintroduces mb_regenerate_buddy(). Based on
> code in mb_free_blocks(), fast commit replay can end up marking as free
> blocks that are already marked as such. This causes corruption of the
> buddy bitmap so we need to regenerate it in that case.
>
> Otherwise the patch looks good to me so feel free to add:
>
> Reviewed-by: Jan Kara <jack@suse.cz>
>
> 								Honza
Hello Honza, Happy New Year!

Thank you very much for your review!
This changelog looks a lot more relevant!
  I will use this changelog in the next version.
>> Reported-by: Jan Kara <jack@suse.cz>
>> Fixes: 6bd97bf273bd ("ext4: remove redundant mb_regenerate_buddy()")
>> Signed-off-by: Baokun Li <libaokun1@huawei.com>
>> ---
>>   fs/ext4/mballoc.c | 20 ++++++++++++++++++++
>>   1 file changed, 20 insertions(+)
>>
>> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
>> index a95fa6e2b0f9..f6131ba514c8 100644
>> --- a/fs/ext4/mballoc.c
>> +++ b/fs/ext4/mballoc.c
>> @@ -1233,6 +1233,24 @@ void ext4_mb_generate_buddy(struct super_block *sb,
>>   	atomic64_add(period, &sbi->s_mb_generation_time);
>>   }
>>   
>> +static void mb_regenerate_buddy(struct ext4_buddy *e4b)
>> +{
>> +	int count;
>> +	int order = 1;
>> +	void *buddy;
>> +
>> +	while ((buddy = mb_find_buddy(e4b, order++, &count)))
>> +		mb_set_bits(buddy, 0, count);
>> +
>> +	e4b->bd_info->bb_fragments = 0;
>> +	memset(e4b->bd_info->bb_counters, 0,
>> +		sizeof(*e4b->bd_info->bb_counters) *
>> +		(e4b->bd_sb->s_blocksize_bits + 2));
>> +
>> +	ext4_mb_generate_buddy(e4b->bd_sb, e4b->bd_buddy,
>> +		e4b->bd_bitmap, e4b->bd_group, e4b->bd_info);
>> +}
>> +
>>   /* The buddy information is attached the buddy cache inode
>>    * for convenience. The information regarding each group
>>    * is loaded via ext4_mb_load_buddy. The information involve
>> @@ -1921,6 +1939,8 @@ static void mb_free_blocks(struct inode *inode, struct ext4_buddy *e4b,
>>   			ext4_mark_group_bitmap_corrupted(
>>   				sb, e4b->bd_group,
>>   				EXT4_GROUP_INFO_BBITMAP_CORRUPT);
>> +		} else {
>> +			mb_regenerate_buddy(e4b);
>>   		}
>>   		goto done;
>>   	}
>> -- 
>> 2.31.1
>>

Thanks again!
-- 
With Best Regards,
Baokun Li
.


