Return-Path: <linux-ext4+bounces-6176-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99593A17DBB
	for <lists+linux-ext4@lfdr.de>; Tue, 21 Jan 2025 13:20:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 995113AA312
	for <lists+linux-ext4@lfdr.de>; Tue, 21 Jan 2025 12:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A4761F1517;
	Tue, 21 Jan 2025 12:20:54 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF031F0E25;
	Tue, 21 Jan 2025 12:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737462053; cv=none; b=SZrfvSCbLhnys2OjXzXTQgC9dZrBjHBbIk7kX4gWZ28Lbqmq+Om3yCBD3NZFdFWRK2NkXyeNV9/ALyWXysCdPjuHoNScEFsxMaSLDs5V9Jgm533Ff/tXcJ+uGLZbQ17ULvbTDT07auaNq8MeFwOt6UxngLYiyRaQ6tMZFWsGKvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737462053; c=relaxed/simple;
	bh=NaFeyOpdjit9Ny9HmInNgP8MyWzdaqRl88/R0/iXXto=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qpL5cl/tXvExUb3a+4bFSnCBBHDTeubM45uxnehmV7Mie5LymrV9F9mI2nwJavvDmqDbAyuTjI8IgQUB0wE4uLG9f7bykSD7Et3hHLmKqJY2Y5Oxg5eeZIIA5BAWxRE3V3NohmT67wJbTUThAY7FFgM6dCEmfug4kYl5K2r8jTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4YcmSq5t7nz22ld5;
	Tue, 21 Jan 2025 20:18:19 +0800 (CST)
Received: from kwepemg500008.china.huawei.com (unknown [7.202.181.45])
	by mail.maildlp.com (Postfix) with ESMTPS id EEA7A1A016C;
	Tue, 21 Jan 2025 20:20:48 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.71) by kwepemg500008.china.huawei.com
 (7.202.181.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 21 Jan
 2025 20:20:48 +0800
Message-ID: <d0a24bff-714a-4709-9a64-f4b508a1c231@huawei.com>
Date: Tue, 21 Jan 2025 20:20:47 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] ext4: add EXT4_FLAGS_EMERGENCY_RO bit
To: Jan Kara <jack@suse.cz>
CC: <linux-ext4@vger.kernel.org>, <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
	<linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>,
	<yangerkun@huawei.com>, Baokun Li <libaokun1@huawei.com>, Baokun Li
	<libaokun@huaweicloud.com>
References: <20250117082315.2869996-1-libaokun@huaweicloud.com>
 <20250117082315.2869996-3-libaokun@huaweicloud.com>
 <jlmjgo6xm5t3wuomxgo46c22csv6dlqubb35ctaa3u7qizbqmf@qeum4e6ffyoc>
Content-Language: en-US
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <jlmjgo6xm5t3wuomxgo46c22csv6dlqubb35ctaa3u7qizbqmf@qeum4e6ffyoc>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemg500008.china.huawei.com (7.202.181.45)

On 2025/1/21 20:08, Jan Kara wrote:
> On Fri 17-01-25 16:23:10, libaokun@huaweicloud.com wrote:
>> From: Baokun Li <libaokun1@huawei.com>
>>
>> EXT4_FLAGS_EMERGENCY_RO Indicates that the current file system has become
>> read-only due to some error. Compared to SB_RDONLY, setting it does not
>> require a lock because we won't clear it, which avoids over-coupling with
>> vfs freeze. Also, add a helper function ext4_emergency_ro() to check if
>> the bit is set.
>>
>> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> The same comment about comma after the last enum member. Otherwise looks
> good. Feel free to add:
>
> Reviewed-by: Jan Kara <jack@suse.cz>
>
> 								Honza
Okay, I'm going to add a comma here in the next version as well.

Thank you for your review!


Regards,
Baokun

>> ---
>>   fs/ext4/ext4.h | 8 +++++++-
>>   1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
>> index 612208527512..c5b775482897 100644
>> --- a/fs/ext4/ext4.h
>> +++ b/fs/ext4/ext4.h
>> @@ -2235,7 +2235,8 @@ extern int ext4_feature_set_ok(struct super_block *sb, int readonly);
>>   enum {
>>   	EXT4_FLAGS_RESIZING,	/* Avoid superblock update and resize race */
>>   	EXT4_FLAGS_SHUTDOWN,	/* Prevent access to the file system */
>> -	EXT4_FLAGS_BDEV_IS_DAX	/* Current block device support DAX */
>> +	EXT4_FLAGS_BDEV_IS_DAX,	/* Current block device support DAX */
>> +	EXT4_FLAGS_EMERGENCY_RO	/* Emergency read-only due to fs errors */
>>   };
>>   
>>   static inline int ext4_forced_shutdown(struct super_block *sb)
>> @@ -2243,6 +2244,11 @@ static inline int ext4_forced_shutdown(struct super_block *sb)
>>   	return test_bit(EXT4_FLAGS_SHUTDOWN, &EXT4_SB(sb)->s_ext4_flags);
>>   }
>>   
>> +static inline int ext4_emergency_ro(struct super_block *sb)
>> +{
>> +	return test_bit(EXT4_FLAGS_EMERGENCY_RO, &EXT4_SB(sb)->s_ext4_flags);
>> +}
>> +
>>   /*
>>    * Default values for user and/or group using reserved blocks
>>    */
>> -- 
>> 2.39.2
>>

