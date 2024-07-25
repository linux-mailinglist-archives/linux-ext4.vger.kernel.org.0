Return-Path: <linux-ext4+bounces-3442-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBDCF93BC16
	for <lists+linux-ext4@lfdr.de>; Thu, 25 Jul 2024 07:42:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AD961C219E5
	for <lists+linux-ext4@lfdr.de>; Thu, 25 Jul 2024 05:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10DE31CD29;
	Thu, 25 Jul 2024 05:41:54 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C8017C91;
	Thu, 25 Jul 2024 05:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721886113; cv=none; b=JPRghPIrCJwRaKL5P1m7De4xPvk0ARZsILt3QpPiTwUJ3xAtL581tpABcJ8HnIaeUtD2ySlSbvHPKJR+1iKAnALWeoj6hDCWq3EPfFIothx2BGDRCLnYzf0LQTPi3Nxo0oMUjcqcR/LBOMD+K+J6octSAFi1aiyON7M1HWy9lFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721886113; c=relaxed/simple;
	bh=pOfIORBUYVtA1WumEjMqc0fDLkcYAjCHU1C1AzAMrOg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tQ1V3pz3Nz8QidRFuwL3sn1PLobvsZJiyk9lYcUqeOW5yZmo/vzhpnU0nGPhd1Jf23L6V2Z0K61ODJBuC/lqr02qiBLGHoBD9risfQ2QCo+eu40WRtINFgJuYw8nhdvVcr2hIbJhhj1JT/qTm8iaQsfBvkoftBeXuK1yZCG8diw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WV0B00f1kz4f3kvY;
	Thu, 25 Jul 2024 13:41:28 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id B1D651A140B;
	Thu, 25 Jul 2024 13:41:41 +0800 (CST)
Received: from [10.174.177.174] (unknown [10.174.177.174])
	by APP4 (Coremail) with SMTP id gCh0CgCHazmS5aFm+C5rBA--.63565S3;
	Thu, 25 Jul 2024 13:41:41 +0800 (CST)
Message-ID: <19ce4750-b1e3-4db6-821e-a70b6d03f2ec@huaweicloud.com>
Date: Thu, 25 Jul 2024 13:41:38 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/20] ext4: avoid use-after-free in ext4_ext_show_leaf()
To: Jan Kara <jack@suse.cz>
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
 ritesh.list@gmail.com, linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
 yangerkun@huawei.com, Baokun Li <libaokun1@huawei.com>,
 Baokun Li <libaokun@huaweicloud.com>
References: <20240710040654.1714672-1-libaokun@huaweicloud.com>
 <20240710040654.1714672-7-libaokun@huaweicloud.com>
 <20240724191604.6grmtu4t7gmvtlec@quack3>
Content-Language: en-US
From: Baokun Li <libaokun@huaweicloud.com>
In-Reply-To: <20240724191604.6grmtu4t7gmvtlec@quack3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgCHazmS5aFm+C5rBA--.63565S3
X-Coremail-Antispam: 1UD129KBjvJXoWxAw45Ww43ur45Gr47urW8Crg_yoW5tFWfp3
	sxCF1DKr45Jay2gFWqqF4DAr129a1jkr4xGrW7KFyagFZ8tF9agF1xt3WFvFWrJF48Wa4a
	qr48t3WUu3W3AaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvK14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
	c2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbV
	WUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF
	67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42
	IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF
	0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxh
	VjvjDU0xZFpf9x0JUZYFZUUUUU=
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAQAPBWaguvxRywABsQ

On 2024/7/25 3:16, Jan Kara wrote:
> On Wed 10-07-24 12:06:40, libaokun@huaweicloud.com wrote:
>> From: Baokun Li <libaokun1@huawei.com>
>>
>> In ext4_find_extent(), path may be freed by error or be reallocated, so
>> using a previously saved *ppath may have been freed and thus may trigger
>> use-after-free, as follows:
>>
>> ext4_split_extent
>>    path = *ppath;
>>    ext4_split_extent_at(ppath)
>>    path = ext4_find_extent(ppath)
>>    ext4_split_extent_at(ppath)
>>      // ext4_find_extent fails to free path
>>      // but zeroout succeeds
>>    ext4_ext_show_leaf(inode, path)
>>      eh = path[depth].p_hdr
>>      // path use-after-free !!!
>>
>> Similar to ext4_split_extent_at(), we use *ppath directly as an input to
>> ext4_ext_show_leaf(). Fix a spelling error by the way.
>>
>> Same problem in ext4_ext_handle_unwritten_extents(). Since 'path' is only
>> used in ext4_ext_show_leaf(), remove 'path' and use *ppath directly.
>>
>> This issue is triggered only when EXT_DEBUG is defined and therefore does
>> not affect functionality.
>>
>> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> Looks good. Feel free to add:
>
> Reviewed-by: Jan Kara <jack@suse.cz>
>
> I'd just note that this shows that modifying ppath in the called function
> was not a great idea as it makes possible use-after-free issues due to
> cached values being used very hard to spot and very easy to introduce...
>
> 								Honza

Hi Honza,

Thank you very much for your review!

Yes, it was too confusing, which is why I dropped all ppaths after fixing
the problem. Judging and using the returned path every time would
make the code look a lot simpler.

Thanks,
Baokun
>> ---
>>   fs/ext4/extents.c | 9 ++++-----
>>   1 file changed, 4 insertions(+), 5 deletions(-)
>>
>> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
>> index 3a70a0739af8..1660434fbfc7 100644
>> --- a/fs/ext4/extents.c
>> +++ b/fs/ext4/extents.c
>> @@ -3328,7 +3328,7 @@ static int ext4_split_extent_at(handle_t *handle,
>>   }
>>   
>>   /*
>> - * ext4_split_extents() splits an extent and mark extent which is covered
>> + * ext4_split_extent() splits an extent and mark extent which is covered
>>    * by @map as split_flags indicates
>>    *
>>    * It may result in splitting the extent into multiple extents (up to three)
>> @@ -3404,7 +3404,7 @@ static int ext4_split_extent(handle_t *handle,
>>   			goto out;
>>   	}
>>   
>> -	ext4_ext_show_leaf(inode, path);
>> +	ext4_ext_show_leaf(inode, *ppath);
>>   out:
>>   	return err ? err : allocated;
>>   }
>> @@ -3869,14 +3869,13 @@ ext4_ext_handle_unwritten_extents(handle_t *handle, struct inode *inode,
>>   			struct ext4_ext_path **ppath, int flags,
>>   			unsigned int allocated, ext4_fsblk_t newblock)
>>   {
>> -	struct ext4_ext_path __maybe_unused *path = *ppath;
>>   	int ret = 0;
>>   	int err = 0;
>>   
>>   	ext_debug(inode, "logical block %llu, max_blocks %u, flags 0x%x, allocated %u\n",
>>   		  (unsigned long long)map->m_lblk, map->m_len, flags,
>>   		  allocated);
>> -	ext4_ext_show_leaf(inode, path);
>> +	ext4_ext_show_leaf(inode, *ppath);
>>   
>>   	/*
>>   	 * When writing into unwritten space, we should not fail to
>> @@ -3973,7 +3972,7 @@ ext4_ext_handle_unwritten_extents(handle_t *handle, struct inode *inode,
>>   	if (allocated > map->m_len)
>>   		allocated = map->m_len;
>>   	map->m_len = allocated;
>> -	ext4_ext_show_leaf(inode, path);
>> +	ext4_ext_show_leaf(inode, *ppath);
>>   out2:
>>   	return err ? err : allocated;
>>   }
>> -- 
>> 2.39.2
>>
-- 
With Best Regards,
Baokun Li


