Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CDD342622F
	for <lists+linux-ext4@lfdr.de>; Fri,  8 Oct 2021 03:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231688AbhJHB6l (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 7 Oct 2021 21:58:41 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:23353 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbhJHB6k (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 7 Oct 2021 21:58:40 -0400
Received: from dggeme754-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4HQWQr3xRvzbcxj;
        Fri,  8 Oct 2021 09:52:20 +0800 (CST)
Received: from [10.174.178.185] (10.174.178.185) by
 dggeme754-chm.china.huawei.com (10.3.19.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.8; Fri, 8 Oct 2021 09:56:44 +0800
Subject: Re: [PATCH -next v2 2/6] ext4: introduce last_check_time record
 previous check time
To:     Jan Kara <jack@suse.cz>
References: <20210911090059.1876456-1-yebin10@huawei.com>
 <20210911090059.1876456-3-yebin10@huawei.com>
 <20211007123100.GG12712@quack2.suse.cz>
CC:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
        <linux-ext4@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From:   yebin <yebin10@huawei.com>
Message-ID: <615FA55B.5070404@huawei.com>
Date:   Fri, 8 Oct 2021 09:56:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
MIME-Version: 1.0
In-Reply-To: <20211007123100.GG12712@quack2.suse.cz>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.185]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggeme754-chm.china.huawei.com (10.3.19.100)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On 2021/10/7 20:31, Jan Kara wrote:
> On Sat 11-09-21 17:00:55, Ye Bin wrote:
>> kmmpd:
>> ...
>>      diff = jiffies - last_update_time;
>>      if (diff > mmp_check_interval * HZ) {
>> ...
>> As "mmp_check_interval = 2 * mmp_update_interval", 'diff' always little
>> than 'mmp_update_interval', so there will never trigger detection.
>> Introduce last_check_time record previous check time.
>>
>> Signed-off-by: Ye Bin <yebin10@huawei.com>
> I think the check is there only for the case where write_mmp_block() +
> sleep took longer than mmp_check_interval. I agree that should rarely
> happen but on a really busy system it is possible and in that case we would
> miss updating mmp block for too long and so another node could have started
> using the filesystem. I actually don't see a reason why kmmpd should be
> checking the block each mmp_check_interval as you do - mmp_check_interval
> is just for ext4_multi_mount_protect() to know how long it should wait
> before considering mmp block stale... Am I missing something?
>
> 								Honza
I'm sorry, I didn't understand the detection mechanism here before. Now 
I understand
the detection mechanism here.
As you said, it's just an abnormal protection. There's really no problem.

>> ---
>>   fs/ext4/mmp.c | 14 +++++++++-----
>>   1 file changed, 9 insertions(+), 5 deletions(-)
>>
>> diff --git a/fs/ext4/mmp.c b/fs/ext4/mmp.c
>> index 12af6dc8457b..c781b09a78c9 100644
>> --- a/fs/ext4/mmp.c
>> +++ b/fs/ext4/mmp.c
>> @@ -152,6 +152,7 @@ static int kmmpd(void *data)
>>   	int mmp_update_interval = le16_to_cpu(es->s_mmp_update_interval);
>>   	unsigned mmp_check_interval;
>>   	unsigned long last_update_time;
>> +	unsigned long last_check_time;
>>   	unsigned long diff;
>>   	int retval = 0;
>>   
>> @@ -170,6 +171,7 @@ static int kmmpd(void *data)
>>   
>>   	memcpy(mmp->mmp_nodename, init_utsname()->nodename,
>>   	       sizeof(mmp->mmp_nodename));
>> +	last_check_time = jiffies;
>>   
>>   	while (!kthread_should_stop() && !sb_rdonly(sb)) {
>>   		if (!ext4_has_feature_mmp(sb)) {
>> @@ -198,17 +200,18 @@ static int kmmpd(void *data)
>>   		}
>>   
>>   		diff = jiffies - last_update_time;
>> -		if (diff < mmp_update_interval * HZ)
>> +		if (diff < mmp_update_interval * HZ) {
>>   			schedule_timeout_interruptible(mmp_update_interval *
>>   						       HZ - diff);
>> +			diff = jiffies - last_update_time;
>> +		}
>>   
>>   		/*
>>   		 * We need to make sure that more than mmp_check_interval
>> -		 * seconds have not passed since writing. If that has happened
>> -		 * we need to check if the MMP block is as we left it.
>> +		 * seconds have not passed since check. If that has happened
>> +		 * we need to check if the MMP block is as we write it.
>>   		 */
>> -		diff = jiffies - last_update_time;
>> -		if (diff > mmp_check_interval * HZ) {
>> +		if (jiffies - last_check_time > mmp_check_interval * HZ) {
>>   			struct buffer_head *bh_check = NULL;
>>   			struct mmp_struct *mmp_check;
>>   
>> @@ -234,6 +237,7 @@ static int kmmpd(void *data)
>>   				goto wait_to_exit;
>>   			}
>>   			put_bh(bh_check);
>> +			last_check_time = jiffies;
>>   		}
>>   
>>   		 /*
>> -- 
>> 2.31.1
>>

