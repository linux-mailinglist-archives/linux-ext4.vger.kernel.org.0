Return-Path: <linux-ext4+bounces-6175-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A4E55A17DAA
	for <lists+linux-ext4@lfdr.de>; Tue, 21 Jan 2025 13:16:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 413467A3338
	for <lists+linux-ext4@lfdr.de>; Tue, 21 Jan 2025 12:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C01B91F03D3;
	Tue, 21 Jan 2025 12:15:35 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F1415098A;
	Tue, 21 Jan 2025 12:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737461735; cv=none; b=Rmb4JiH6sqgEHJKgUuLvLh0U6nhjtxh/6t7DZoaUJmF4Q58tMGhXuX1jEBKrW+NXqea8mHktGJDgx3GTkVFsztKfrfeopaDxrDpi26eCMbruiBCzWcAthi+IoqVUoCptBXkZI9BNRj/MF+1Y+lIYBrD/WTxKKsOghY4FJuwck/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737461735; c=relaxed/simple;
	bh=IAS6VK5CBlA6ovnnFVNcSpvQD1+mJLasld/5TnK2Goo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=maHnds4PdAh+Uq4Nu8DfGebW3mWp6SMpeVMBjdlt9H9SM90clwzq2qVFowOO0m72j7dcRuglHinWSAV3xPmq1l5yt+tDQmldVNtZVbebfFM7ReEg6C3JMIJPgh3jcn9pggvpRPZaVdaZNPhqaZHkD3HCf/4pfUePkNfsKd1irjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4YcmMg03YVzmZ7K;
	Tue, 21 Jan 2025 20:13:51 +0800 (CST)
Received: from kwepemg500008.china.huawei.com (unknown [7.202.181.45])
	by mail.maildlp.com (Postfix) with ESMTPS id 0A2D0180105;
	Tue, 21 Jan 2025 20:15:30 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.71) by kwepemg500008.china.huawei.com
 (7.202.181.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 21 Jan
 2025 20:15:29 +0800
Message-ID: <32851fb9-faf6-4321-bcd1-911cfa180228@huawei.com>
Date: Tue, 21 Jan 2025 20:15:28 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] ext4: convert EXT4_FLAGS_* defines to enum
To: Jan Kara <jack@suse.cz>
CC: <linux-ext4@vger.kernel.org>, <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
	<linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>,
	<yangerkun@huawei.com>, Baokun Li <libaokun1@huawei.com>, Baokun Li
	<libaokun@huaweicloud.com>
References: <20250117082315.2869996-1-libaokun@huaweicloud.com>
 <20250117082315.2869996-2-libaokun@huaweicloud.com>
 <qrvjasx2ggnmtdet62fyi4xig5as25d2stpb7eowzovpzgqxxh@7fvccxntqqyq>
Content-Language: en-US
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <qrvjasx2ggnmtdet62fyi4xig5as25d2stpb7eowzovpzgqxxh@7fvccxntqqyq>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemg500008.china.huawei.com (7.202.181.45)

On 2025/1/21 20:07, Jan Kara wrote:
> On Fri 17-01-25 16:23:09, libaokun@huaweicloud.com wrote:
>> From: Baokun Li <libaokun1@huawei.com>
>>
>> Do away with the defines and use an enum as it's cleaner.
>>
>> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> Yeah, why not. Feel free to add:
>
> Reviewed-by: Jan Kara <jack@suse.cz>
>
> 								Honza
Thank you for the review!
>> ---
>>   fs/ext4/ext4.h | 8 +++++---
>>   1 file changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
>> index 4e7de7eaa374..612208527512 100644
>> --- a/fs/ext4/ext4.h
>> +++ b/fs/ext4/ext4.h
>> @@ -2232,9 +2232,11 @@ extern int ext4_feature_set_ok(struct super_block *sb, int readonly);
>>   /*
>>    * Superblock flags
>>    */
>> -#define EXT4_FLAGS_RESIZING	0
>> -#define EXT4_FLAGS_SHUTDOWN	1
>> -#define EXT4_FLAGS_BDEV_IS_DAX	2
>> +enum {
>> +	EXT4_FLAGS_RESIZING,	/* Avoid superblock update and resize race */
>> +	EXT4_FLAGS_SHUTDOWN,	/* Prevent access to the file system */
>> +	EXT4_FLAGS_BDEV_IS_DAX	/* Current block device support DAX */
> 			      ^^ we usually put comma here so that future
> additions doesn't need to modify this line.
Okay, I will add a comma here in the next version.

Thanks,
Baokun
>> +};
>>   
>>   static inline int ext4_forced_shutdown(struct super_block *sb)
>>   {
>> -- 
>> 2.39.2
>>


