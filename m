Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3AD345B710
	for <lists+linux-ext4@lfdr.de>; Wed, 24 Nov 2021 10:01:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241048AbhKXJE1 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 24 Nov 2021 04:04:27 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:28103 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240975AbhKXJEY (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 24 Nov 2021 04:04:24 -0500
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4HzZg55xzCz1DJYC;
        Wed, 24 Nov 2021 16:58:41 +0800 (CST)
Received: from kwepemm600019.china.huawei.com (7.193.23.64) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 24 Nov 2021 17:01:13 +0800
Received: from [10.174.177.210] (10.174.177.210) by
 kwepemm600019.china.huawei.com (7.193.23.64) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 24 Nov 2021 17:01:13 +0800
Subject: Re: [PATCH] ext4: if zeroout fails fall back to splitting the extent
 node
To:     Jan Kara <jack@suse.cz>
CC:     Theodore Ts'o <tytso@mit.edu>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        <yukuai3@huawei.com>
References: <YRaNKc2PvM+Eyzmp@mit.edu> <20210813212701.366447-1-tytso@mit.edu>
 <715f636e-ff1b-301f-38a9-602437fdd95a@huawei.com>
 <20211123092741.GA8583@quack2.suse.cz>
From:   yangerkun <yangerkun@huawei.com>
Message-ID: <d5346e36-3331-0d0d-e36d-83f543986ccb@huawei.com>
Date:   Wed, 24 Nov 2021 17:01:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20211123092741.GA8583@quack2.suse.cz>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.210]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600019.china.huawei.com (7.193.23.64)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On 2021/11/23 17:27, Jan Kara wrote:
> Hello,
> 
> On Sun 26-09-21 19:35:01, yangerkun wrote:
>> Rethink about this problem. Should we consider other place which call
>> ext4_issue_zeroout? Maybe it can trigger the problem too(in theory, not
>> really happened)...
>>
>> How about include follow patch which not only transfer ENOSPC to EIO. But
>> also stop to overwrite the error return by ext4_ext_insert_extent in
>> ext4_split_extent_at.
>>
>> Besides, 308c57ccf431 ("ext4: if zeroout fails fall back to splitting the
>> extent node") can work together with this patch.
> 
> I've got back to this. The ext4_ext_zeroout() calls in
> ext4_split_extent_at() seem to be there as fallback when insertion of a new
> extent fails due to ENOSPC / EDQUOT. If even ext4_ext_zeroout(), then I
> think returning an error as the code does now is correct and we don't have
> much other option. Also we are really running out of disk space so I think
> returning ENOSPC is fine. What exact scenario are you afraid of?

I am afraid about the EDQUOT from ext4_ext_insert_extent may be 
overwrite by ext4_ext_zeroout with ENOSPC. And this may lead to dead 
loop since ext4_writepages will retry once get ENOSPC? Maybe I am wrong...

> 
> 								Honza
> 
>> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
>> index c0de30f25185..66767ede235f 100644
>> --- a/fs/ext4/extents.c
>> +++ b/fs/ext4/extents.c
>> @@ -3218,16 +3218,18 @@ static int ext4_split_extent_at(handle_t *handle,
>>                  goto out;
>>
>>          if (EXT4_EXT_MAY_ZEROOUT & split_flag) {
>> +               int ret = 0;
>> +
>>                  if (split_flag &
>> (EXT4_EXT_DATA_VALID1|EXT4_EXT_DATA_VALID2)) {
>>                          if (split_flag & EXT4_EXT_DATA_VALID1) {
>> -                               err = ext4_ext_zeroout(inode, ex2);
>> +                               ret = ext4_ext_zeroout(inode, ex2);
>>                                  zero_ex.ee_block = ex2->ee_block;
>>                                  zero_ex.ee_len = cpu_to_le16(
>>
>> ext4_ext_get_actual_len(ex2));
>>                                  ext4_ext_store_pblock(&zero_ex,
>>
>> ext4_ext_pblock(ex2));
>>                          } else {
>> -                               err = ext4_ext_zeroout(inode, ex);
>> +                               ret = ext4_ext_zeroout(inode, ex);
>>                                  zero_ex.ee_block = ex->ee_block;
>>                                  zero_ex.ee_len = cpu_to_le16(
>>
>> ext4_ext_get_actual_len(ex));
>> @@ -3235,7 +3237,7 @@ static int ext4_split_extent_at(handle_t *handle,
>>                                                        ext4_ext_pblock(ex));
>>                          }
>>                  } else {
>> -                       err = ext4_ext_zeroout(inode, &orig_ex);
>> +                       ret = ext4_ext_zeroout(inode, &orig_ex);
>>                          zero_ex.ee_block = orig_ex.ee_block;
>>                          zero_ex.ee_len = cpu_to_le16(
>>
>> ext4_ext_get_actual_len(&orig_ex));
>> @@ -3243,7 +3245,7 @@ static int ext4_split_extent_at(handle_t *handle,
>>                                                ext4_ext_pblock(&orig_ex));
>>                  }
>>
>> -               if (!err) {
>> +               if (!ret) {
>>                          /* update the extent length and mark as initialized
>> */
>>                          ex->ee_len = cpu_to_le16(ee_len);
>>                          ext4_ext_try_to_merge(handle, inode, path, ex);
>> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
>> index d18852d6029c..95b970581864 100644
>> --- a/fs/ext4/inode.c
>> +++ b/fs/ext4/inode.c
>> @@ -427,6 +427,9 @@ int ext4_issue_zeroout(struct inode *inode, ext4_lblk_t
>> lblk, ext4_fsblk_t pblk,
>>          if (ret > 0)
>>                  ret = 0;
>>
>> +       if (ret == -ENOSPC)
>> +               ret = -EIO;
>> +
>>          return ret;
>>   }
>>
>>
>>
>> 在 2021/8/14 5:27, Theodore Ts'o 写道:
>>> If the underlying storage device is using thin-provisioning, it's
>>> possible for a zeroout operation to return ENOSPC.
>>>
>>> Commit df22291ff0fd ("ext4: Retry block allocation if we have free blocks
>>> left") added logic to retry block allocation since we might get free block
>>> after we commit a transaction. But the ENOSPC from thin-provisioning
>>> will confuse ext4, and lead to an infinite loop.
>>>
>>> Since using zeroout instead of splitting the extent node is an
>>> optimization, if it fails, we might as well fall back to splitting the
>>> extent node.
>>>
>>> Reported-by: yangerkun <yangerkun@huawei.com>
>>> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
>>> ---
>>>
>>> I've run this through my battery of tests, and it doesn't cause any
>>> regressions.  Yangerkun, can you test this and see if this works for
>>> you?
>>>
>>>    fs/ext4/extents.c | 5 +++--
>>>    1 file changed, 3 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
>>> index 92ad64b89d9b..501516cadc1b 100644
>>> --- a/fs/ext4/extents.c
>>> +++ b/fs/ext4/extents.c
>>> @@ -3569,7 +3569,7 @@ static int ext4_ext_convert_to_initialized(handle_t *handle,
>>>    				split_map.m_len - ee_block);
>>>    			err = ext4_ext_zeroout(inode, &zero_ex1);
>>>    			if (err)
>>> -				goto out;
>>> +				goto fallback;
>>>    			split_map.m_len = allocated;
>>>    		}
>>>    		if (split_map.m_lblk - ee_block + split_map.m_len <
>>> @@ -3583,7 +3583,7 @@ static int ext4_ext_convert_to_initialized(handle_t *handle,
>>>    						      ext4_ext_pblock(ex));
>>>    				err = ext4_ext_zeroout(inode, &zero_ex2);
>>>    				if (err)
>>> -					goto out;
>>> +					goto fallback;
>>>    			}
>>>    			split_map.m_len += split_map.m_lblk - ee_block;
>>> @@ -3592,6 +3592,7 @@ static int ext4_ext_convert_to_initialized(handle_t *handle,
>>>    		}
>>>    	}
>>> +fallback:
>>>    	err = ext4_split_extent(handle, inode, ppath, &split_map, split_flag,
>>>    				flags);
>>>    	if (err > 0)
>>>
