Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F5763ECEE6
	for <lists+linux-ext4@lfdr.de>; Mon, 16 Aug 2021 08:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233550AbhHPG6L (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 16 Aug 2021 02:58:11 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:8417 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233349AbhHPG6K (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 16 Aug 2021 02:58:10 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Gp4cw3WTjz85NG;
        Mon, 16 Aug 2021 14:53:36 +0800 (CST)
Received: from dggema766-chm.china.huawei.com (10.1.198.208) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Mon, 16 Aug 2021 14:57:37 +0800
Received: from [10.174.177.210] (10.174.177.210) by
 dggema766-chm.china.huawei.com (10.1.198.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Mon, 16 Aug 2021 14:57:37 +0800
Subject: Re: [PATCH] ext4: if zeroout fails fall back to splitting the extent
 node
From:   yangerkun <yangerkun@huawei.com>
To:     Theodore Ts'o <tytso@mit.edu>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
CC:     <yukuai3@huawei.com>
References: <YRaNKc2PvM+Eyzmp@mit.edu> <20210813212701.366447-1-tytso@mit.edu>
 <2714202a-872e-aa75-7033-fb06a47b9241@huawei.com>
Message-ID: <9fdbfcce-961d-8074-e431-5d867fbf5216@huawei.com>
Date:   Mon, 16 Aug 2021 14:57:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <2714202a-872e-aa75-7033-fb06a47b9241@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.210]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggema766-chm.china.huawei.com (10.1.198.208)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



在 2021/8/14 10:15, yangerkun 写道:
> 
> 
> 在 2021/8/14 5:27, Theodore Ts'o 写道:
>> If the underlying storage device is using thin-provisioning, it's
>> possible for a zeroout operation to return ENOSPC.
>>
>> Commit df22291ff0fd ("ext4: Retry block allocation if we have free blocks
>> left") added logic to retry block allocation since we might get free 
>> block
>> after we commit a transaction. But the ENOSPC from thin-provisioning
>> will confuse ext4, and lead to an infinite loop.
>>
>> Since using zeroout instead of splitting the extent node is an
>> optimization, if it fails, we might as well fall back to splitting the
>> extent node.
>>
>> Reported-by: yangerkun <yangerkun@huawei.com>
>> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
>> ---
>>
>> I've run this through my battery of tests, and it doesn't cause any
>> regressions.  Yangerkun, can you test this and see if this works for
>> you?
> 
> Will do it.

Thanks for the patch, it can help us to pass the testcase. And after 
some review, it's really a better fix for me.

Thanks,
Kun.

> 
>>
>>   fs/ext4/extents.c | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
>> index 92ad64b89d9b..501516cadc1b 100644
>> --- a/fs/ext4/extents.c
>> +++ b/fs/ext4/extents.c
>> @@ -3569,7 +3569,7 @@ static int 
>> ext4_ext_convert_to_initialized(handle_t *handle,
>>                   split_map.m_len - ee_block);
>>               err = ext4_ext_zeroout(inode, &zero_ex1);
>>               if (err)
>> -                goto out;
>> +                goto fallback;
>>               split_map.m_len = allocated;
>>           }
>>           if (split_map.m_lblk - ee_block + split_map.m_len <
>> @@ -3583,7 +3583,7 @@ static int 
>> ext4_ext_convert_to_initialized(handle_t *handle,
>>                                 ext4_ext_pblock(ex));
>>                   err = ext4_ext_zeroout(inode, &zero_ex2);
>>                   if (err)
>> -                    goto out;
>> +                    goto fallback;
>>               }
>>               split_map.m_len += split_map.m_lblk - ee_block;
>> @@ -3592,6 +3592,7 @@ static int 
>> ext4_ext_convert_to_initialized(handle_t *handle,
>>           }
>>       }
>> +fallback:
>>       err = ext4_split_extent(handle, inode, ppath, &split_map, 
>> split_flag,
>>                   flags);
>>       if (err > 0)
>>
> .
