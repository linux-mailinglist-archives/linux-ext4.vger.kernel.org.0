Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B2FA4068B8
	for <lists+linux-ext4@lfdr.de>; Fri, 10 Sep 2021 10:49:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231831AbhIJIux (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 10 Sep 2021 04:50:53 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:19024 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231502AbhIJIux (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 10 Sep 2021 04:50:53 -0400
Received: from dggeme754-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4H5Twf31TJzbmQD;
        Fri, 10 Sep 2021 16:45:38 +0800 (CST)
Received: from [10.174.178.185] (10.174.178.185) by
 dggeme754-chm.china.huawei.com (10.3.19.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.8; Fri, 10 Sep 2021 16:49:40 +0800
Subject: Re: [PATCH -next 2/6] ext4: introduce last_check_time record previous
 check time
To:     Guoqing Jiang <guoqing.jiang@linux.dev>, <tytso@mit.edu>,
        <adilger.kernel@dilger.ca>, <linux-ext4@vger.kernel.org>
References: <20210906144754.2601607-1-yebin10@huawei.com>
 <20210906144754.2601607-3-yebin10@huawei.com>
 <03bd0982-f0ad-78b4-7b98-cbfdbab9deec@linux.dev>
CC:     <linux-kernel@vger.kernel.org>, <jack@suse.cz>
From:   yebin <yebin10@huawei.com>
Message-ID: <613B1C24.4040901@huawei.com>
Date:   Fri, 10 Sep 2021 16:49:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
MIME-Version: 1.0
In-Reply-To: <03bd0982-f0ad-78b4-7b98-cbfdbab9deec@linux.dev>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.185]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggeme754-chm.china.huawei.com (10.3.19.100)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On 2021/9/9 10:20, Guoqing Jiang wrote:
>
>
> On 9/6/21 10:47 PM, Ye Bin wrote:
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
>> ---
>>   fs/ext4/mmp.c | 14 +++++++++-----
>>   1 file changed, 9 insertions(+), 5 deletions(-)
>>
>> diff --git a/fs/ext4/mmp.c b/fs/ext4/mmp.c
>> index 12af6dc8457b..89797f12a815 100644
>> --- a/fs/ext4/mmp.c
>> +++ b/fs/ext4/mmp.c
>> @@ -152,6 +152,7 @@ static int kmmpd(void *data)
>>       int mmp_update_interval = le16_to_cpu(es->s_mmp_update_interval);
>>       unsigned mmp_check_interval;
>>       unsigned long last_update_time;
>> +    unsigned long last_check_time;
>>       unsigned long diff;
>>       int retval = 0;
>>   @@ -170,6 +171,7 @@ static int kmmpd(void *data)
>>         memcpy(mmp->mmp_nodename, init_utsname()->nodename,
>>              sizeof(mmp->mmp_nodename));
>> +    last_update_time = jiffies;
I'm sorry, actually i want to init 'last_check_time' at here,  I will 
fix it in v2.
Thanks,
YeBin
>>         while (!kthread_should_stop() && !sb_rdonly(sb)) {
>>           if (!ext4_has_feature_mmp(sb)) {
>> @@ -198,17 +200,18 @@ static int kmmpd(void *data)
>>           }
>>             diff = jiffies - last_update_time;
>> -        if (diff < mmp_update_interval * HZ)
>> +        if (diff < mmp_update_interval * HZ) {
>>               schedule_timeout_interruptible(mmp_update_interval *
>>                                  HZ - diff);
>> +            diff = jiffies - last_update_time;
>> +        }
>>             /*
>>            * We need to make sure that more than mmp_check_interval
>> -         * seconds have not passed since writing. If that has happened
>> -         * we need to check if the MMP block is as we left it.
>> +         * seconds have not passed since check. If that has happened
>> +         * we need to check if the MMP block is as we write it.
>>            */
>> -        diff = jiffies - last_update_time;
>> -        if (diff > mmp_check_interval * HZ) {
>> +        if (jiffies - last_check_time > mmp_check_interval * HZ) {
>
> Before the above checking, seems last_check_time is not initialized yet.
>>               struct buffer_head *bh_check = NULL;
>>               struct mmp_struct *mmp_check;
>>   @@ -234,6 +237,7 @@ static int kmmpd(void *data)
>>                   goto wait_to_exit;
>>               }
>>               put_bh(bh_check);
>> +            last_check_time = jiffies;
>>           }
>>              /*
>
> Thanks,
> Guoqing
> .
>

