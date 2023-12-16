Return-Path: <linux-ext4+bounces-474-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C3298155CE
	for <lists+linux-ext4@lfdr.de>; Sat, 16 Dec 2023 02:02:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9659FB23877
	for <lists+linux-ext4@lfdr.de>; Sat, 16 Dec 2023 01:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EDA718AE6;
	Sat, 16 Dec 2023 01:01:40 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A8615493;
	Sat, 16 Dec 2023 01:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4SsSPC4pnBz1FDwq;
	Sat, 16 Dec 2023 08:57:51 +0800 (CST)
Received: from canpemm500010.china.huawei.com (unknown [7.192.105.118])
	by mail.maildlp.com (Postfix) with ESMTPS id A74D21402CF;
	Sat, 16 Dec 2023 09:01:30 +0800 (CST)
Received: from [10.174.178.185] (10.174.178.185) by
 canpemm500010.china.huawei.com (7.192.105.118) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sat, 16 Dec 2023 09:01:30 +0800
Subject: Re: [PATCH] ext4: fix inconsistent between segment fstrim and full
 fstrim
To: Jan Kara <jack@suse.cz>
References: <20231214064635.4128391-1-yebin10@huawei.com>
 <20231215114135.qwdoscxg7myw3r6x@quack3>
CC: <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <linux-ext4@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
From: "yebin (H)" <yebin10@huawei.com>
Message-ID: <657CF6E9.602@huawei.com>
Date: Sat, 16 Dec 2023 09:01:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231215114135.qwdoscxg7myw3r6x@quack3>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500010.china.huawei.com (7.192.105.118)



On 2023/12/15 19:41, Jan Kara wrote:
> On Thu 14-12-23 14:46:35, Ye Bin wrote:
>> There will not issue discard cmd when do segment fstrim for ext4 fs, however,
>> if full fstrim for the same fs will issue discard cmd.
>> Above issue may happens as follows:
>> Precondition:
>> 1. Fstrim range [0, 15] and [16, 31];
>> 2. Discard granularity is 16;
>>              Range1          Range2
>>        1111000000000000 0000111010101011
>> There's no free space length large or equal than 16 in 'Range1' or 'Range2'.
>> As ext4_try_to_trim_range() only search free space among range which user
>> specified. However, there's maximum free space length 16 in 'Range1'+ 'Range2'.
>> To solve above issue, we need to find the longest free space to discard.
> The patch looks good so feel free to add:
>
> Reviewed-by: Jan Kara <jack@suse.cz>
>
> I'd just rephrase the changelog to make it a bit easier to read:
>
> Suppose we issue two FITRIM ioctls for ranges [0,15] and [16,31] with
> mininum length of trimmed range set to 8 blocks. If we have say a range of
> blocks 10-22 free, this range will not be trimmed because it straddles the
> boundary of the two FITRIM ranges and neither part is big enough. This is a
> bit surprising to some users that call FITRIM on smaller ranges of blocks
> to limit impact on the system. Also XFS trims all free space extents that
> overlap with the specified range so we are inconsistent among filesystems.
> Let's change ext4_try_to_trim_range() to consider for trimming the whole
> free space extent that straddles the end of specified range, not just the
> part of it within the range.
>
> 								Honza
>   
Thank you very much for your clear explanation of the patch.  I'll 
update patch's
changelog and resend a version.
>> Signed-off-by: Ye Bin <yebin10@huawei.com>
>> ---
>>   fs/ext4/mballoc.c | 11 ++++++++---
>>   1 file changed, 8 insertions(+), 3 deletions(-)
>>
>> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
>> index d72b5e3c92ec..d195461123d8 100644
>> --- a/fs/ext4/mballoc.c
>> +++ b/fs/ext4/mballoc.c
>> @@ -6753,13 +6753,15 @@ static int ext4_try_to_trim_range(struct super_block *sb,
>>   __acquires(ext4_group_lock_ptr(sb, e4b->bd_group))
>>   __releases(ext4_group_lock_ptr(sb, e4b->bd_group))
>>   {
>> -	ext4_grpblk_t next, count, free_count;
>> +	ext4_grpblk_t next, count, free_count, last, origin_start;
>>   	bool set_trimmed = false;
>>   	void *bitmap;
>>   
>> +	last = ext4_last_grp_cluster(sb, e4b->bd_group);
>>   	bitmap = e4b->bd_bitmap;
>> -	if (start == 0 && max >= ext4_last_grp_cluster(sb, e4b->bd_group))
>> +	if (start == 0 && max >= last)
>>   		set_trimmed = true;
>> +	origin_start = start;
>>   	start = max(e4b->bd_info->bb_first_free, start);
>>   	count = 0;
>>   	free_count = 0;
>> @@ -6768,7 +6770,10 @@ __releases(ext4_group_lock_ptr(sb, e4b->bd_group))
>>   		start = mb_find_next_zero_bit(bitmap, max + 1, start);
>>   		if (start > max)
>>   			break;
>> -		next = mb_find_next_bit(bitmap, max + 1, start);
>> +
>> +		next = mb_find_next_bit(bitmap, last + 1, start);
>> +		if (origin_start == 0 && next >= last)
>> +			set_trimmed = true;
>>   
>>   		if ((next - start) >= minblocks) {
>>   			int ret = ext4_trim_extent(sb, start, next - start, e4b);
>> -- 
>> 2.31.1
>>


