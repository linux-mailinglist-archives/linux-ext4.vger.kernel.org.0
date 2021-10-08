Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73EC7426357
	for <lists+linux-ext4@lfdr.de>; Fri,  8 Oct 2021 05:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242809AbhJHDyn (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 7 Oct 2021 23:54:43 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:24176 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbhJHDyn (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 7 Oct 2021 23:54:43 -0400
Received: from dggeme754-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4HQZ442HyFz1DHXS;
        Fri,  8 Oct 2021 11:51:16 +0800 (CST)
Received: from [10.174.178.185] (10.174.178.185) by
 dggeme754-chm.china.huawei.com (10.3.19.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.8; Fri, 8 Oct 2021 11:52:46 +0800
Subject: Re: [PATCH -next v2 4/6] ext4: avoid to re-read mmp check data get
 from page cache
To:     Jan Kara <jack@suse.cz>
References: <20210911090059.1876456-1-yebin10@huawei.com>
 <20210911090059.1876456-5-yebin10@huawei.com>
 <20211007124422.GI12712@quack2.suse.cz>
CC:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
        <linux-ext4@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From:   yebin <yebin10@huawei.com>
Message-ID: <615FC08E.3060301@huawei.com>
Date:   Fri, 8 Oct 2021 11:52:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
MIME-Version: 1.0
In-Reply-To: <20211007124422.GI12712@quack2.suse.cz>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.185]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggeme754-chm.china.huawei.com (10.3.19.100)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On 2021/10/7 20:44, Jan Kara wrote:
> On Sat 11-09-21 17:00:57, Ye Bin wrote:
>> As call read_mmp_block pass bh_check which value is NULL, then call
>> sb_getblk to get buffer_head. But mmp_block's buffer_head is already exist
>>   which also is uptodate. Lead to compare the same data.
>>
>> Signed-off-by: Ye Bin <yebin10@huawei.com>
> This looks good, except that read_mmp_block() also releases bh it is passed
> in case of error. So it can free buffer head which is still referenced from
> EXT4_SB(sb)->s_mmp_bh and cause use-after-free issues.
>
> I guess I would just get rid of sb_getblk() in read_mmp_block() and always
> expect valid bh passed. The only place that passes NULL bh after this
> patch is one case in ext4_multi_mount_protect() and that can call
> sb_getblk() on its own. That way we can also simplify read_mmp_block()
> prototype to:
>
> static int read_mmp_block(struct super_block *sb, struct buffer_head *bh);
>
> 								Honza
> Yeah, I will refactor 'read_mmp_block'.
>> ---
>>   fs/ext4/mmp.c | 17 ++++++-----------
>>   1 file changed, 6 insertions(+), 11 deletions(-)
>>
>> diff --git a/fs/ext4/mmp.c b/fs/ext4/mmp.c
>> index 4433fe7e9e86..007bde3c12b8 100644
>> --- a/fs/ext4/mmp.c
>> +++ b/fs/ext4/mmp.c
>> @@ -213,10 +213,7 @@ static int kmmpd(void *data)
>>   		 * we need to check if the MMP block is as we write it.
>>   		 */
>>   		if (jiffies - last_check_time > mmp_check_interval * HZ) {
>> -			struct buffer_head *bh_check = NULL;
>> -			struct mmp_struct *mmp_check;
>> -
>> -			retval = read_mmp_block(sb, &bh_check, mmp_block);
>> +			retval = read_mmp_block(sb, &bh, mmp_block);
>>   			if (retval) {
>>   				ext4_error_err(sb, -retval,
>>   					       "error reading MMP data: %d",
>> @@ -224,20 +221,18 @@ static int kmmpd(void *data)
>>   				goto wait_to_exit;
>>   			}
>>   
>> -			mmp_check = (struct mmp_struct *)(bh_check->b_data);
>> -			if (seq != mmp_check->mmp_seq ||
>> -			    memcmp(nodename, mmp_check->mmp_nodename,
>> -				   sizeof(mmp->mmp_nodename))) {
>> -				dump_mmp_msg(sb, mmp_check,
>> +			mmp = (struct mmp_struct *)(bh->b_data);
>> +			if (seq != le32_to_cpu(mmp->mmp_seq) ||
>> +			    memcmp(nodename, mmp->mmp_nodename,
>> +				    sizeof(nodename))) {
>> +				dump_mmp_msg(sb, mmp,
>>   					     "Error while updating MMP info. "
>>   					     "The filesystem seems to have been"
>>   					     " multiply mounted.");
>>   				ext4_error_err(sb, EBUSY, "abort");
>> -				put_bh(bh_check);
>>   				retval = -EBUSY;
>>   				goto wait_to_exit;
>>   			}
>> -			put_bh(bh_check);
>>   			last_check_time = jiffies;
>>   		}
>>   
>> -- 
>> 2.31.1
>>

