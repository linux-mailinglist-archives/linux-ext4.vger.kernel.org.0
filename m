Return-Path: <linux-ext4+bounces-500-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A3D817FC7
	for <lists+linux-ext4@lfdr.de>; Tue, 19 Dec 2023 03:29:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D91E01F23B72
	for <lists+linux-ext4@lfdr.de>; Tue, 19 Dec 2023 02:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 938BB441B;
	Tue, 19 Dec 2023 02:29:30 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06554409;
	Tue, 19 Dec 2023 02:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4SvLHB6Mh1zMnyZ;
	Tue, 19 Dec 2023 10:29:10 +0800 (CST)
Received: from dggpeml500021.china.huawei.com (unknown [7.185.36.21])
	by mail.maildlp.com (Postfix) with ESMTPS id 8085814068C;
	Tue, 19 Dec 2023 10:29:09 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 19 Dec 2023 10:29:08 +0800
Message-ID: <7e0f5796-99eb-867d-8885-8df553de8df9@huawei.com>
Date: Tue, 19 Dec 2023 10:29:08 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH 3/4] ext4: avoid bb_free and bb_fragments inconsistency in
 mb_free_blocks()
Content-Language: en-US
To: Jan Kara <jack@suse.cz>, Theodore Ts'o <tytso@mit.edu>
CC: <linux-ext4@vger.kernel.org>, <adilger.kernel@dilger.ca>,
	<ritesh.list@gmail.com>, <linux-kernel@vger.kernel.org>,
	<yi.zhang@huawei.com>, <yangerkun@huawei.com>, <yukuai3@huawei.com>,
	<stable@vger.kernel.org>, Baokun Li <libaokun1@huawei.com>
References: <20231218141814.1477338-1-libaokun1@huawei.com>
 <20231218141814.1477338-4-libaokun1@huawei.com>
 <20231218151455.yqph44iz4ihsujz5@quack3>
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20231218151455.yqph44iz4ihsujz5@quack3>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500021.china.huawei.com (7.185.36.21)

On 2023/12/18 23:14, Jan Kara wrote:
> On Mon 18-12-23 22:18:13, Baokun Li wrote:
>> After updating bb_free in mb_free_blocks, it is possible to return without
>> updating bb_fragments because the block being freed is found to have
>> already been freed, which leads to inconsistency between bb_free and
>> bb_fragments.
>>
>> Since the group may be unlocked in ext4_grp_locked_error(), this can lead
>> to problems such as dividing by zero when calculating the average fragment
>> length. Therefore, to ensure consistency, move the update of bb_free to
>> after the block double-free check.
>>
>> Fixes: eabe0444df90 ("ext4: speed-up releasing blocks on commit")
>> CC: stable@vger.kernel.org # 3.10
>> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> I agree there's no point in updating the allocation info if the bitmap is
> corrupted. We will not try to allocate (or free) blocks in that group
> anymore. I'm just a bit unsure about the EXT4_FC_REPLAY state where we
> don't mark the bitmap as corrupted although some blocks were already marked
> as freed. So in this case the free space statistics tracking will go
> permanently wrong. I'm kind of wondering in which case does fast-commit
> free already freed blocks. Ted, any idea?
>
> 								Honza
Some additional information, this judgment was introduced in
commit 8016e29f4362 ("ext4: fast commit recovery path") in v5.10-rc1,
at which point mb_regenerate_buddy() was called to regenerate the
buddy when it was found to be freeing a block that had already been
freed, so there was no problem. Until v5.11-rc1 commit 6bd97bf273bd
("ext4: remove redundant mb_regenerate_buddy()") removes the logic
to regenerate the buddy, it looks like the free space statistics will
remain wrong. If this normal scenario exists, perhaps buddy should
be regenerated here?

Thanks,
Baokun
>> ---
>>   fs/ext4/mballoc.c | 13 ++++++-------
>>   1 file changed, 6 insertions(+), 7 deletions(-)
>>
>> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
>> index a95fa6e2b0f9..2fbee0f0f5c3 100644
>> --- a/fs/ext4/mballoc.c
>> +++ b/fs/ext4/mballoc.c
>> @@ -1892,11 +1892,6 @@ static void mb_free_blocks(struct inode *inode, struct ext4_buddy *e4b,
>>   	mb_check_buddy(e4b);
>>   	mb_free_blocks_double(inode, e4b, first, count);
>>   
>> -	this_cpu_inc(discard_pa_seq);
>> -	e4b->bd_info->bb_free += count;
>> -	if (first < e4b->bd_info->bb_first_free)
>> -		e4b->bd_info->bb_first_free = first;
>> -
>>   	/* access memory sequentially: check left neighbour,
>>   	 * clear range and then check right neighbour
>>   	 */
>> @@ -1922,9 +1917,14 @@ static void mb_free_blocks(struct inode *inode, struct ext4_buddy *e4b,
>>   				sb, e4b->bd_group,
>>   				EXT4_GROUP_INFO_BBITMAP_CORRUPT);
>>   		}
>> -		goto done;
>> +		return;
>>   	}
>>   
>> +	this_cpu_inc(discard_pa_seq);
>> +	e4b->bd_info->bb_free += count;
>> +	if (first < e4b->bd_info->bb_first_free)
>> +		e4b->bd_info->bb_first_free = first;
>> +
>>   	/* let's maintain fragments counter */
>>   	if (left_is_free && right_is_free)
>>   		e4b->bd_info->bb_fragments--;
>> @@ -1949,7 +1949,6 @@ static void mb_free_blocks(struct inode *inode, struct ext4_buddy *e4b,
>>   	if (first <= last)
>>   		mb_buddy_mark_free(e4b, first >> 1, last >> 1);
>>   
>> -done:
>>   	mb_set_largest_free_order(sb, e4b->bd_info);
>>   	mb_update_avg_fragment_size(sb, e4b->bd_info);
>>   	mb_check_buddy(e4b);
>> -- 
>> 2.31.1
>>

