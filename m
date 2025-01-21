Return-Path: <linux-ext4+bounces-6173-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CD34A17D9A
	for <lists+linux-ext4@lfdr.de>; Tue, 21 Jan 2025 13:11:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5EBC16B6E0
	for <lists+linux-ext4@lfdr.de>; Tue, 21 Jan 2025 12:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D6781F191E;
	Tue, 21 Jan 2025 12:11:54 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D32520318;
	Tue, 21 Jan 2025 12:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737461513; cv=none; b=UWi/pfJqX6j2OX5x6qbfSuw8cdWKo0CvSseJk/1F1oYMEFc7G9AJuKPy+VK/6O34HAUtVI4DdHMJWK1M4Qy6/MrrJDjFKco8AIEab3oiojkLcEwAgJ8KhxadyO7wa+UajQu3xquMAALH9BcevxYopKoJ6nC3st8bNAwlZ/CEjws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737461513; c=relaxed/simple;
	bh=9suzRXIyDMOqb6HUy6MP9nL67IRKgi2egRXKD1U/qxU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=KbFlhsV9dFwkkIzN4gN11lOOC64FebNoCkgcs5nfqpcPuQ7Eeb8ars4LsaZtWrnnKFlqbcJ/DkHwtYmPsI3CJciHKz4RIVpCGlN6CQ1Gh/SeY3dfW+ep8rkP3irJ5hm7O/tIZRD0KTOXnXZ9IvmzyQiE9lTrXGDgvqS8D4JYlDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4YcmKn6J2zz20p67;
	Tue, 21 Jan 2025 20:12:13 +0800 (CST)
Received: from kwepemg500008.china.huawei.com (unknown [7.202.181.45])
	by mail.maildlp.com (Postfix) with ESMTPS id A1F631A016C;
	Tue, 21 Jan 2025 20:11:48 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.71) by kwepemg500008.china.huawei.com
 (7.202.181.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 21 Jan
 2025 20:11:47 +0800
Message-ID: <7e67c369-dbbc-47fd-ace8-2d495f340263@huawei.com>
Date: Tue, 21 Jan 2025 20:11:47 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/8] ext4: reject the 'data_err=abort' option in
 nojournal mode
To: Jan Kara <jack@suse.cz>
CC: <linux-ext4@vger.kernel.org>, <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
	<linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>,
	<yangerkun@huawei.com>, <libaokun@huaweicloud.com>, Baokun Li
	<libaokun1@huawei.com>
References: <20250121071050.3991249-1-libaokun@huaweicloud.com>
 <20250121071050.3991249-4-libaokun@huaweicloud.com>
 <2hr7ifk6f7ojn3iubi3qj2yp5m72fvbch22afkmw2emsypz5kv@uah27xxstly3>
Content-Language: en-US
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <2hr7ifk6f7ojn3iubi3qj2yp5m72fvbch22afkmw2emsypz5kv@uah27xxstly3>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemg500008.china.huawei.com (7.202.181.45)

Hi Honza,

On 2025/1/21 19:37, Jan Kara wrote:
> On Tue 21-01-25 15:10:45, libaokun@huaweicloud.com wrote:
>> From: Baokun Li <libaokun1@huawei.com>
>>
>> data_err=abort aborts the journal on I/O errors. However, this option is
>> meaningless if journal is disabled, so it is rejected in nojournal mode
>> to reduce unnecessary checks. Also, this option is ignored upon remount.
>>
>> Signed-off-by: Baokun Li <libaokun1@huawei.com>
>> Reviewed-by: Zhang Yi <yi.zhang@huawei.com>
> Looks good. Feel free to add:
>
> Reviewed-by: Jan Kara <jack@suse.cz>
Thanks for the review!
>> ---
>> Or maybe we should make mount and remount consistent?
>> Rejecting it in both would make things a lot easier.
> The reason why it is ignored on remount is that we cannot modify
> JBD2_ABORT_ON_SYNCDATA_ERR on remount. Now that we don't really depend on
> JBD2_ABORT_ON_SYNCDATA_ERR, we could indeed make mount and remount
> consistent and probably just drop JBD2_ABORT_ON_SYNCDATA_ERR altogether
> (and only warn in jbd2 as it used to be long ago).
>
> 								Honza
Okay, I'll add a patch in the next version to clean up
JBD2_ABORT_ON_SYNCDATA_ERR.

Cheers,
Baokun
>>   fs/ext4/super.c | 12 ++++++++++++
>>   1 file changed, 12 insertions(+)
>>
>> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
>> index a50e5c31b937..34a7b6523f8b 100644
>> --- a/fs/ext4/super.c
>> +++ b/fs/ext4/super.c
>> @@ -2785,6 +2785,13 @@ static int ext4_check_opt_consistency(struct fs_context *fc,
>>   	}
>>   
>>   	if (is_remount) {
>> +		if (!sbi->s_journal &&
>> +		    ctx_test_mount_opt(ctx, EXT4_MOUNT_DATA_ERR_ABORT)) {
>> +			ext4_msg(NULL, KERN_WARNING,
>> +				 "Remounting fs w/o journal so ignoring data_err option");
>> +			ctx_clear_mount_opt(ctx, EXT4_MOUNT_DATA_ERR_ABORT);
>> +		}
>> +
>>   		if (ctx_test_mount_opt(ctx, EXT4_MOUNT_DAX_ALWAYS) &&
>>   		    (test_opt(sb, DATA_FLAGS) == EXT4_MOUNT_JOURNAL_DATA)) {
>>   			ext4_msg(NULL, KERN_ERR, "can't mount with "
>> @@ -5428,6 +5435,11 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
>>   				 "data=, fs mounted w/o journal");
>>   			goto failed_mount3a;
>>   		}
>> +		if (test_opt(sb, DATA_ERR_ABORT)) {
>> +			ext4_msg(sb, KERN_ERR,
>> +				 "can't mount with data_err=abort, fs mounted w/o journal");
>> +			goto failed_mount3a;
>> +		}
>>   		sbi->s_def_mount_opt &= ~EXT4_MOUNT_JOURNAL_CHECKSUM;
>>   		clear_opt(sb, JOURNAL_CHECKSUM);
>>   		clear_opt(sb, DATA_FLAGS);
>> -- 
>> 2.39.2
>>


