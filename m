Return-Path: <linux-ext4+bounces-6168-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F199DA17CF9
	for <lists+linux-ext4@lfdr.de>; Tue, 21 Jan 2025 12:23:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33AC1161577
	for <lists+linux-ext4@lfdr.de>; Tue, 21 Jan 2025 11:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30D7D1F12FD;
	Tue, 21 Jan 2025 11:22:59 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7171BBBEA;
	Tue, 21 Jan 2025 11:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737458579; cv=none; b=iISinXyLDeKMSyw0nglaLT13YnVb9vAlxhI7TGq6C++7H7EtMBdqnpePpsbY0fZGr6jak8ZQv7ZCW8I56MjrFU9UHKiHdRkaqXdDOOaIxhCPH2MRMI9kv7/3JzRs1G6pkCHsx1cy71YJzXbsZnz205dblays4U66uIdZ0GzvT7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737458579; c=relaxed/simple;
	bh=e1KA3m/wJ0ztxP4eFP5kk4BLCMPI7mC8+G00dSEEJqE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=b7FIRhyVE4Hngo1bBF+bt09NklOUl2Te5te7YTEG81TWpTzIwUWBP0/3L15i2KvMMt7hThPxn68uubYfQrfhVbgHzX+GhEAXa+v0mQ8D0gI7GsJzOjcnoZrvaJqz0As8UxE+l69lNCkCR1scGIUgZW5CgOlsUckfid9sONrRzOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Ycl9t1FmMz22lVd;
	Tue, 21 Jan 2025 19:20:18 +0800 (CST)
Received: from kwepemg500008.china.huawei.com (unknown [7.202.181.45])
	by mail.maildlp.com (Postfix) with ESMTPS id 45F1D1A0188;
	Tue, 21 Jan 2025 19:22:47 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.71) by kwepemg500008.china.huawei.com
 (7.202.181.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 21 Jan
 2025 19:22:46 +0800
Message-ID: <d04d3ab5-84d9-4c15-a774-d9cf631e5b37@huawei.com>
Date: Tue, 21 Jan 2025 19:22:45 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/8] ext4: extract ext4_check_nojournal_options() from
 __ext4_fill_super()
To: Jan Kara <jack@suse.cz>
CC: <linux-ext4@vger.kernel.org>, <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
	<linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>,
	<yangerkun@huawei.com>, Baokun Li <libaokun1@huawei.com>, Baokun Li
	<libaokun@huaweicloud.com>
References: <20250121071050.3991249-1-libaokun@huaweicloud.com>
 <20250121071050.3991249-5-libaokun@huaweicloud.com>
 <nv5selt2rw3rn2f2hfk7doejpjj2tir4mho4i4fnwrj5mqqwru@bqmdwvefw4lh>
Content-Language: en-US
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <nv5selt2rw3rn2f2hfk7doejpjj2tir4mho4i4fnwrj5mqqwru@bqmdwvefw4lh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemg500008.china.huawei.com (7.202.181.45)

On 2025/1/21 19:04, Jan Kara wrote:
> On Tue 21-01-25 15:10:46, libaokun@huaweicloud.com wrote:
>> From: Baokun Li <libaokun1@huawei.com>
>>
>> Extract the ext4_check_nojournal_options() helper function to reduce code
>> duplication. No functional changes.
>>
>> Signed-off-by: Baokun Li <libaokun1@huawei.com>
>> Reviewed-by: Zhang Yi <yi.zhang@huawei.com>
> Looks good. Just a small naming suggestion:
>
>> +static const char *ext4_check_nojournal_options(struct super_block *sb)
> I'd call this ext4_has_journal_option() to make it somewhat more obvious
> what we are checking. Otherwise feel free to add:
>
> Reviewed-by: Jan Kara <jack@suse.cz>
>
> 								Honza
Awesome, this function name is much better and makes more sense.
I'll use it in the next version. Naming is really hard! 😅

Thanks a lot for the review!

Cheers,
Baokun
>
>> +{
>> +	struct ext4_sb_info *sbi = EXT4_SB(sb);
>> +
>> +	if (test_opt(sb, JOURNAL_ASYNC_COMMIT))
>> +		return "journal_async_commit";
>> +	if (test_opt2(sb, EXPLICIT_JOURNAL_CHECKSUM))
>> +		return "journal_checksum";
>> +	if (sbi->s_commit_interval != JBD2_DEFAULT_MAX_COMMIT_AGE*HZ)
>> +		return "commit=";
>> +	if (EXT4_MOUNT_DATA_FLAGS &
>> +	    (sbi->s_mount_opt ^ sbi->s_def_mount_opt))
>> +		return "data=";
>> +	if (test_opt(sb, DATA_ERR_ABORT))
>> +		return "data_err=abort";
>> +	return NULL;
>> +}
>> +
>>   static int ext4_load_super(struct super_block *sb, ext4_fsblk_t *lsb,
>>   			   int silent)
>>   {
>> @@ -5411,35 +5429,17 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
>>   		       "suppressed and not mounted read-only");
>>   		goto failed_mount3a;
>>   	} else {
>> -		/* Nojournal mode, all journal mount options are illegal */
>> -		if (test_opt(sb, JOURNAL_ASYNC_COMMIT)) {
>> -			ext4_msg(sb, KERN_ERR, "can't mount with "
>> -				 "journal_async_commit, fs mounted w/o journal");
>> -			goto failed_mount3a;
>> -		}
>> +		const char *journal_option;
>>   
>> -		if (test_opt2(sb, EXPLICIT_JOURNAL_CHECKSUM)) {
>> -			ext4_msg(sb, KERN_ERR, "can't mount with "
>> -				 "journal_checksum, fs mounted w/o journal");
>> -			goto failed_mount3a;
>> -		}
>> -		if (sbi->s_commit_interval != JBD2_DEFAULT_MAX_COMMIT_AGE*HZ) {
>> -			ext4_msg(sb, KERN_ERR, "can't mount with "
>> -				 "commit=%lu, fs mounted w/o journal",
>> -				 sbi->s_commit_interval / HZ);
>> -			goto failed_mount3a;
>> -		}
>> -		if (EXT4_MOUNT_DATA_FLAGS &
>> -		    (sbi->s_mount_opt ^ sbi->s_def_mount_opt)) {
>> -			ext4_msg(sb, KERN_ERR, "can't mount with "
>> -				 "data=, fs mounted w/o journal");
>> -			goto failed_mount3a;
>> -		}
>> -		if (test_opt(sb, DATA_ERR_ABORT)) {
>> +		/* Nojournal mode, all journal mount options are illegal */
>> +		journal_option = ext4_check_nojournal_options(sb);
>> +		if (journal_option != NULL) {
>>   			ext4_msg(sb, KERN_ERR,
>> -				 "can't mount with data_err=abort, fs mounted w/o journal");
>> +				 "can't mount with %s, fs mounted w/o journal",
>> +				 journal_option);
>>   			goto failed_mount3a;
>>   		}
>> +
>>   		sbi->s_def_mount_opt &= ~EXT4_MOUNT_JOURNAL_CHECKSUM;
>>   		clear_opt(sb, JOURNAL_CHECKSUM);
>>   		clear_opt(sb, DATA_FLAGS);
>> -- 
>> 2.39.2
>>


