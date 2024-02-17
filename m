Return-Path: <linux-ext4+bounces-1257-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B7FF3858DA5
	for <lists+linux-ext4@lfdr.de>; Sat, 17 Feb 2024 08:28:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17386B21AC7
	for <lists+linux-ext4@lfdr.de>; Sat, 17 Feb 2024 07:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B3F51CD03;
	Sat, 17 Feb 2024 07:28:20 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242A0149E08;
	Sat, 17 Feb 2024 07:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708154900; cv=none; b=f8oOSnOpYxDEJlAjjR1jfHjIrtSSo26K6hbZ/cPEh19AtIrKod358EFwiObuotDip3jDjeWyHIbxeDUyDcW/yePbOzKepIsUPWlYZaSI1bqWVpWlcfL/ni4tBr9D0xHOJ1dH8/7Q0keKi572wpyKc/1AwnsSu9uSDo++2623qec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708154900; c=relaxed/simple;
	bh=+p1cAQFkW6JV/8e9SmwOxLpJ5j837xQISfc1CCJ0plI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=MgfqtYEBbPTc0S3UD6j3zQvJF9zlwRKsIhR2kHtcsPbjyDtb/Q7CjWC9YUTDP0Ce/BirreOJFz11yDMyxzM7cnA2xxdLrzos5Dd6/OmhQSt1xplO/JMB2eA4kACH/MsyD0WXhhhbUbX6odx5jC/STxn9zE87VEfv78sxSXQ57gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4TcKc60Gj9z1Q8yN;
	Sat, 17 Feb 2024 15:07:02 +0800 (CST)
Received: from dggpeml500021.china.huawei.com (unknown [7.185.36.21])
	by mail.maildlp.com (Postfix) with ESMTPS id 8F9701A0172;
	Sat, 17 Feb 2024 15:09:07 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sat, 17 Feb 2024 15:09:06 +0800
Message-ID: <81081ec9-3aab-ecd1-c2f6-9a3835ea4fda@huawei.com>
Date: Sat, 17 Feb 2024 15:09:06 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH 1/7] ext4: avoid overflow when setting values via sysfs
Content-Language: en-US
To: Jan Kara <jack@suse.cz>
CC: <linux-ext4@vger.kernel.org>, <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
	<ritesh.list@gmail.com>, <linux-kernel@vger.kernel.org>,
	<yi.zhang@huawei.com>, <yangerkun@huawei.com>, <chengzhihao1@huawei.com>,
	<yukuai3@huawei.com>, Baokun Li <libaokun1@huawei.com>
References: <20240126085716.1363019-1-libaokun1@huawei.com>
 <20240126085716.1363019-2-libaokun1@huawei.com>
 <20240213160554.35cpsfqqeqpgtux2@quack3>
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20240213160554.35cpsfqqeqpgtux2@quack3>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500021.china.huawei.com (7.185.36.21)

On 2024/2/14 0:05, Jan Kara wrote:
> On Fri 26-01-24 16:57:10, Baokun Li wrote:
>> When setting values of type unsigned int through sysfs, we use kstrtoul()
>> to parse it and then truncate part of it as the final set value, when the
>> set value is greater than UINT_MAX, the set value will not match what we
>> see because of the truncation. As follows:
>>
>>    $ echo 4294967296 > /sys/fs/ext4/sda/mb_max_linear_groups
>>    $ cat /sys/fs/ext4/sda/mb_max_linear_groups
>>      0
>>
>> So when the value set is outside the variable type range, -EINVAL is
>> returned to avoid the inconsistency described above. In addition, a
>> judgment is added to avoid setting s_resv_clusters less than 0.
>>
>> Signed-off-by: Baokun Li <libaokun1@huawei.com>
>> ---
>>   fs/ext4/sysfs.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/ext4/sysfs.c b/fs/ext4/sysfs.c
>> index 6d332dff79dd..3671a8aaf4af 100644
>> --- a/fs/ext4/sysfs.c
>> +++ b/fs/ext4/sysfs.c
>> @@ -104,7 +104,7 @@ static ssize_t reserved_clusters_store(struct ext4_sb_info *sbi,
>>   	int ret;
>>   
>>   	ret = kstrtoull(skip_spaces(buf), 0, &val);
>> -	if (ret || val >= clusters)
>> +	if (ret || val >= clusters || (s64)val < 0)
>>   		return -EINVAL;
> This looks a bit pointless, doesn't it? 'val' is u64, clusters is u64. We
> know that val < clusters so how could (s64)val be < 0?
When clusters is bigger than LLONG_MAX, (s64)val may be less than 0.
Of course we don't have such a large storage device yet, so it's only
theoretically possible to overflow here. But the previous patches in this
patch set were intended to ensure that the values set via sysfs did not
exceed the range of the variable type, so I've modified that here as well.
>
>> @@ -463,6 +463,8 @@ static ssize_t ext4_attr_store(struct kobject *kobj,
>>   		ret = kstrtoul(skip_spaces(buf), 0, &t);
>>   		if (ret)
>>   			return ret;
>> +		if (t != (unsigned int)t)
>> +			return -EINVAL;
>>   		if (a->attr_ptr == ptr_ext4_super_block_offset)
>>   			*((__le32 *) ptr) = cpu_to_le32(t);
>>   		else
> I kind of agree with Alexey that using kstrtouint() here instead would look
> nicer. And it isn't like you have to define many new variables. You just
> need unsigned long for attr_pointer_ul and unsigned int for
> attr_pointer_ui.
>
> 								Honza
If we use both kstrtouint() and kstrtoul(), then we need to add
kstrtouint() or kstrtoul() to each case, which would be a lot of
duplicate code as follows:

static ssize_t ext4_generic_attr_store(struct ext4_attr *a,
                                        struct ext4_sb_info *sbi,
                                        const char *buf, size_t len)
{
         int ret;
         unsigned int t;
         unsigned long lt;
         void *ptr = calc_ptr(a, sbi);

         if (!ptr)
                 return 0;

         switch (a->attr_id) {
         case attr_group_prealloc:
                 ret = kstrtouint(skip_spaces(buf), 0, &t);
                 if (ret)
                         return ret;
                 if (t > sbi->s_clusters_per_group)
                         return -EINVAL;
                 return len;
         case attr_pointer_pi:
                 ret = kstrtouint(skip_spaces(buf), 0, &t);
                 if (ret)
                         return ret;
                 if ((int)t < 0)
                         return -EINVAL;
                 return len;
         case attr_pointer_ui:
                 ret = kstrtouint(skip_spaces(buf), 0, &t);
                 if (ret)
                         return ret;
                 if (t != (unsigned int)t)
                         return -EINVAL;
                 if (a->attr_ptr == ptr_ext4_super_block_offset)
                         *((__le32 *) ptr) = cpu_to_le32(t);
                 else
                         *((unsigned int *) ptr) = t;
                 return len;
         case attr_pointer_ul:
                 ret = kstrtoul(skip_spaces(buf), 0, &lt);
                 if (ret)
                         return ret;
                 *((unsigned long *) ptr) = lt;
                 return len;
         }
         return 0;

}

Also, both kstrtouint() and kstrtoul() are based on the kstrtoull()
implementation, so it feels better to opencode kstrtoul() and
kstrtouint() to reduce duplicate code.
Why is it better to distinguish uint and ulong cases here?

Thanks for your review!
Happy Chinese New Year!
-- 
With Best Regards,
Baokun Li
.

