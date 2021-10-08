Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C72AC426229
	for <lists+linux-ext4@lfdr.de>; Fri,  8 Oct 2021 03:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbhJHBwl (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 7 Oct 2021 21:52:41 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:23352 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbhJHBwk (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 7 Oct 2021 21:52:40 -0400
Received: from dggeme754-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4HQWHw6w5vzYfNN;
        Fri,  8 Oct 2021 09:46:20 +0800 (CST)
Received: from [10.174.178.185] (10.174.178.185) by
 dggeme754-chm.china.huawei.com (10.3.19.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.8; Fri, 8 Oct 2021 09:50:44 +0800
Subject: Re: [PATCH -next v2 1/6] ext4: init seq with random value in kmmpd
To:     Jan Kara <jack@suse.cz>
References: <20210911090059.1876456-1-yebin10@huawei.com>
 <20210911090059.1876456-2-yebin10@huawei.com>
 <20211007122604.GF12712@quack2.suse.cz>
CC:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
        <linux-ext4@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From:   yebin <yebin10@huawei.com>
Message-ID: <615FA3F4.30406@huawei.com>
Date:   Fri, 8 Oct 2021 09:50:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
MIME-Version: 1.0
In-Reply-To: <20211007122604.GF12712@quack2.suse.cz>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.185]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggeme754-chm.china.huawei.com (10.3.19.100)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On 2021/10/7 20:26, Jan Kara wrote:
> On Sat 11-09-21 17:00:54, Ye Bin wrote:
>> If two host has the same nodename, and seq start from 0, May cause the
>> detection mechanism to fail.
>> So init seq with random value to accelerate conflict detection.
>>
>> Signed-off-by: Ye Bin <yebin10@huawei.com>
> Thanks for the patch. I agree the code in kmmpd looks suspicious.  The
> sequence number is initialized to a random number in
> ext4_multi_mount_protect() which is called before kmmpd is started. I think
> kmmpd() should initialize its 'seq' to a number fetched from the mmp
> block, instead of 0 as is currently in the code. I don't think generating a
> new random number as you do is really needed...
>
> 								Honza
Thank you for your advice，i  will  fix it.
>
>> ---
>>   fs/ext4/mmp.c | 32 ++++++++++++++++----------------
>>   1 file changed, 16 insertions(+), 16 deletions(-)
>>
>> diff --git a/fs/ext4/mmp.c b/fs/ext4/mmp.c
>> index cebea4270817..12af6dc8457b 100644
>> --- a/fs/ext4/mmp.c
>> +++ b/fs/ext4/mmp.c
>> @@ -122,6 +122,21 @@ void __dump_mmp_msg(struct super_block *sb, struct mmp_struct *mmp,
>>   		       (int)sizeof(mmp->mmp_bdevname), mmp->mmp_bdevname);
>>   }
>>   
>> +/*
>> + * Get a random new sequence number but make sure it is not greater than
>> + * EXT4_MMP_SEQ_MAX.
>> + */
>> +static unsigned int mmp_new_seq(void)
>> +{
>> +	u32 new_seq;
>> +
>> +	do {
>> +		new_seq = prandom_u32();
>> +	} while (new_seq > EXT4_MMP_SEQ_MAX);
>> +
>> +	return new_seq;
>> +}
>> +
>>   /*
>>    * kmmpd will update the MMP sequence every s_mmp_update_interval seconds
>>    */
>> @@ -132,7 +147,7 @@ static int kmmpd(void *data)
>>   	struct buffer_head *bh = EXT4_SB(sb)->s_mmp_bh;
>>   	struct mmp_struct *mmp;
>>   	ext4_fsblk_t mmp_block;
>> -	u32 seq = 0;
>> +	u32 seq = mmp_new_seq();
>>   	unsigned long failed_writes = 0;
>>   	int mmp_update_interval = le16_to_cpu(es->s_mmp_update_interval);
>>   	unsigned mmp_check_interval;
>> @@ -258,21 +273,6 @@ void ext4_stop_mmpd(struct ext4_sb_info *sbi)
>>   	}
>>   }
>>   
>> -/*
>> - * Get a random new sequence number but make sure it is not greater than
>> - * EXT4_MMP_SEQ_MAX.
>> - */
>> -static unsigned int mmp_new_seq(void)
>> -{
>> -	u32 new_seq;
>> -
>> -	do {
>> -		new_seq = prandom_u32();
>> -	} while (new_seq > EXT4_MMP_SEQ_MAX);
>> -
>> -	return new_seq;
>> -}
>> -
>>   /*
>>    * Protect the filesystem from being mounted more than once.
>>    */
>> -- 
>> 2.31.1
>>

