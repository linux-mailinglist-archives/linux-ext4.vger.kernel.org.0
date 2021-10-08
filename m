Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53EC3426352
	for <lists+linux-ext4@lfdr.de>; Fri,  8 Oct 2021 05:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242760AbhJHDvI (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 7 Oct 2021 23:51:08 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:28897 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231658AbhJHDvI (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 7 Oct 2021 23:51:08 -0400
Received: from dggeme754-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4HQYwb3nyHzbmlD;
        Fri,  8 Oct 2021 11:44:47 +0800 (CST)
Received: from [10.174.178.185] (10.174.178.185) by
 dggeme754-chm.china.huawei.com (10.3.19.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.8; Fri, 8 Oct 2021 11:49:11 +0800
Subject: Re: [PATCH -next v2 6/6] ext4: fix possible store wrong check
 interval value in disk when umount
To:     Jan Kara <jack@suse.cz>
References: <20210911090059.1876456-1-yebin10@huawei.com>
 <20210911090059.1876456-7-yebin10@huawei.com>
 <20211007131207.GJ12712@quack2.suse.cz>
CC:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
        <linux-ext4@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From:   yebin <yebin10@huawei.com>
Message-ID: <615FBFB6.9030208@huawei.com>
Date:   Fri, 8 Oct 2021 11:49:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
MIME-Version: 1.0
In-Reply-To: <20211007131207.GJ12712@quack2.suse.cz>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.185]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggeme754-chm.china.huawei.com (10.3.19.100)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On 2021/10/7 21:12, Jan Kara wrote:
> On Sat 11-09-21 17:00:59, Ye Bin wrote:
>> Test follow steps:
>> 1. mkfs.ext4 /dev/sda -O mmp
>> 2. mount /dev/sda  /mnt
>> 3. wait for about 1 minute
>> 4. umount mnt
>> 5. debugfs /dev/sda
>> 6. dump_mmp
>> 7. fsck.ext4 /dev/sda
>>
>> I found 'check_interval' is range in [5, 10]. And sometime run fsck
>> print "MMP interval is 10 seconds and total wait time is 42 seconds.
>> Please wait...".
>> kmmpd:
>> ...
>> 	if (diff < mmp_update_interval * HZ)
>> 		schedule_timeout_interruptible(mmp_update_interval * HZ - diff);
>> 	 diff = jiffies - last_update_time;
>> ...
>> 	mmp_check_interval = max(min(EXT4_MMP_CHECK_MULT * diff / HZ,
>> 				EXT4_MMP_MAX_CHECK_INTERVAL),
>> 			        EXT4_MMP_MIN_CHECK_INTERVAL);
>> 	mmp->mmp_check_interval = cpu_to_le16(mmp_check_interval);
>> ...
>> We will call ext4_stop_mmpd to stop kmmpd kthread when umount, and
>> schedule_timeout_interruptible will be interrupted, so 'diff' maybe
>> little than mmp_update_interval. Then mmp_check_interval will range
>> in [EXT4_MMP_MAX_CHECK_INTERVAL, EXT4_MMP_CHECK_MULT * diff / HZ].
>> To solve this issue, if 'diff' little then mmp_update_interval * HZ
>> just break loop, don't update check interval.
>>
>> Signed-off-by: Ye Bin <yebin10@huawei.com>
>> ---
>>   fs/ext4/mmp.c | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/fs/ext4/mmp.c b/fs/ext4/mmp.c
>> index a0d47a906faa..f39e1fa0c6db 100644
>> --- a/fs/ext4/mmp.c
>> +++ b/fs/ext4/mmp.c
>> @@ -205,6 +205,14 @@ static int kmmpd(void *data)
>>   			schedule_timeout_interruptible(mmp_update_interval *
>>   						       HZ - diff);
>>   			diff = jiffies - last_update_time;
>> +			/* If 'diff' little 'than mmp_update_interval * HZ', it
>> +			 * means someone call ext4_stop_mmpd to stop kmmpd
>> +			 * kthread. We don't need to update mmp_check_interval
>> +			 * any more, as 'diff' is not exact value.
>> +			 */
>> +			if (unlikely(diff < mmp_update_interval * HZ &&
>> +			    kthread_should_stop()))
>> +				break;
>>   		}
> So in this case, mmp_check_interval would be EXT4_MMP_MIN_CHECK_INTERVAL. I
> don't quite understand what the practical problem is - the fsck message?
> That will happen anytime mmp_check_interval is >= 10 AFAICT and I don't
> quite see how that is connected to this condition... Can you explain a bit
> more please?
>
> 								Honza
I just think 'mmp_check_interval' is not reflect real check interval, 
and also sometime run fsck
print "MMP interval is 10 seconds and total wait time is 42 seconds. 
Please wait...", but
sometime not.

