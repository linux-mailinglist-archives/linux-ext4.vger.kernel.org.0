Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0776E6DDD38
	for <lists+linux-ext4@lfdr.de>; Tue, 11 Apr 2023 16:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbjDKOFZ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 11 Apr 2023 10:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbjDKOFY (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 11 Apr 2023 10:05:24 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A287EE5B;
        Tue, 11 Apr 2023 07:05:21 -0700 (PDT)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4PwnYq54W2zSrTf;
        Tue, 11 Apr 2023 22:01:03 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 11 Apr 2023 22:04:58 +0800
Message-ID: <6df9fd42-1b1b-746a-10aa-7bd64ec2ce76@huawei.com>
Date:   Tue, 11 Apr 2023 22:04:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH v2 2/2] ext4: use __GFP_NOFAIL if allocating
 extents_status cannot fail
Content-Language: en-US
To:     Jan Kara <jack@suse.cz>
CC:     <linux-ext4@vger.kernel.org>, <tytso@mit.edu>,
        <adilger.kernel@dilger.ca>, <ritesh.list@gmail.com>,
        <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>,
        <yangerkun@huawei.com>, <yukuai3@huawei.com>,
        Baokun Li <libaokun1@huawei.com>
References: <20230406132834.1669710-1-libaokun1@huawei.com>
 <20230406132834.1669710-3-libaokun1@huawei.com>
 <20230411091957.wuwa7wii7pj35ua7@quack3>
From:   Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20230411091957.wuwa7wii7pj35ua7@quack3>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.174]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500021.china.huawei.com (7.185.36.21)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.5 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 2023/4/11 17:19, Jan Kara wrote:
> On Thu 06-04-23 21:28:34, Baokun Li wrote:
>> If extent status tree update fails, we have inconsistency between what is
>> stored in the extent status tree and what is stored on disk. And that can
>> cause even data corruption issues in some cases.
>>
>> In the extent status tree, we have extents which we can just drop without
>> issues and extents we must not drop - this depends on the extent's status
>> - currently ext4_es_is_delayed() extents must stay, others may be dropped.
>>
>> For extents that cannot be dropped we use __GFP_NOFAIL to allocate memory.
>> A helper function is also added to help determine if the current extent can
>> be dropped, although only ext4_es_is_delayed() extents cannot be dropped
>> currently. In addition, with the above logic, the undo operation in
>> __es_remove_extent that may cause inconsistency if the split extent fails
>> is unnecessary, so we remove it as well.
>>
>> Suggested-by: Jan Kara <jack@suse.cz>
>> Signed-off-by: Baokun Li <libaokun1@huawei.com>
>> ---
>> V1->V2:
>> 	Add the patch 2 as suggested by Jan Kara.
>>
>>   fs/ext4/extents_status.c | 36 +++++++++++++++++++++++++++++-------
>>   1 file changed, 29 insertions(+), 7 deletions(-)
>>
>> diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
>> index 7bc221038c6c..8eed17f35b11 100644
>> --- a/fs/ext4/extents_status.c
>> +++ b/fs/ext4/extents_status.c
>> @@ -448,12 +448,29 @@ static void ext4_es_list_del(struct inode *inode)
>>   	spin_unlock(&sbi->s_es_lock);
>>   }
>>   
>> +/*
>> + * Helper function to help determine if memory allocation for this
>> + * extent_status is allowed to fail.
>> + */
>> +static inline bool ext4_es_alloc_should_nofail(struct extent_status *es)
> I'd call this function ext4_es_must_keep() and also use it in
> es_do_reclaim_extents() instead of ext4_es_is_delayed(). Do this as a
> preparatory patch please.

Totally agree! ext4_es_must_keep() is short and clear. It does make more 
sense to
replace ext4_es_is_delayed() in es_do_reclaim_extents() with the new 
helper, I'll try
to find out if there are any ext4_es_is_delayed() that need to be 
replaced as well.

>> @@ -792,9 +809,16 @@ static int __es_insert_extent(struct inode *inode, struct extent_status *newes)
>>   	}
>>   
>>   	es = ext4_es_alloc_extent(inode, newes->es_lblk, newes->es_len,
>> -				  newes->es_pblk);
>> -	if (!es)
>> -		return -ENOMEM;
>> +				  newes->es_pblk, 0);
> I would just call this like:
>
> 	es = ext4_es_alloc_extent(inode, newes->es_lblk, newes->es_len,
> 				newes->es_pblk, ext4_es_must_keep(newes));
>
> to save the ifs below.

Yes! It does get a little long-winded here.

>
>> +	if (!es) {
>> +		/* Use GFP_NOFAIL if the allocation cannot fail. */
>> +		if (ext4_es_alloc_should_nofail(newes))
>> +			es = ext4_es_alloc_extent(inode, newes->es_lblk,
>> +					newes->es_len, newes->es_pblk, 1);
>> +		else
>> +			return -ENOMEM;
>> +	}
>> +
>>   	rb_link_node(&es->rb_node, parent, p);
>>   	rb_insert_color(&es->rb_node, &tree->root);
>>   
>> @@ -1349,8 +1373,6 @@ static int __es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
>>   						    ext4_es_status(&orig_es));
>>   			err = __es_insert_extent(inode, &newes);
>>   			if (err) {
>> -				es->es_lblk = orig_es.es_lblk;
>> -				es->es_len = orig_es.es_len;
>>   				if ((err == -ENOMEM) &&
>>   				    __es_shrink(EXT4_SB(inode->i_sb),
>>   							128, EXT4_I(inode)))
> Also now __es_remove_extent() cannot fail (it will always remove what it
> should, maybe more) so please just make it void function (as a separate
> cleanup patch afterwards). Thanks!
>
> 								Honza
Yes! Thank you very much for the review!
I will send a patch V3 with the changes suggested by you.

-- 
With Best Regards,
Baokun Li
.
