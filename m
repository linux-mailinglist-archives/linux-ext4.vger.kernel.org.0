Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03F67537380
	for <lists+linux-ext4@lfdr.de>; Mon, 30 May 2022 04:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232206AbiE3CN2 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 29 May 2022 22:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231473AbiE3CN1 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 29 May 2022 22:13:27 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D02025DD10;
        Sun, 29 May 2022 19:13:25 -0700 (PDT)
Received: from dggpeml500020.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LBJns2yLjzjX0y;
        Mon, 30 May 2022 10:12:17 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500020.china.huawei.com (7.185.36.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 30 May 2022 10:13:23 +0800
Message-ID: <94ef9fb3-8085-fa30-2d02-b6ba9d58603f@huawei.com>
Date:   Mon, 30 May 2022 10:13:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v3 2/3] ext4: correct the judgment of BUG in
 ext4_mb_normalize_request
To:     Ritesh Harjani <ritesh.list@gmail.com>
CC:     <linux-ext4@vger.kernel.org>, <tytso@mit.edu>,
        <adilger.kernel@dilger.ca>, <jack@suse.cz>, <lczerner@redhat.com>,
        <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>,
        <yebin10@huawei.com>, <yukuai3@huawei.com>,
        Baokun Li <libaokun1@huawei.com>
References: <20220528110017.354175-1-libaokun1@huawei.com>
 <20220528110017.354175-3-libaokun1@huawei.com>
 <20220528151219.ojgwg7pct6ci5zd6@riteshh-domain>
From:   Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20220528151219.ojgwg7pct6ci5zd6@riteshh-domain>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.174]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500020.china.huawei.com (7.185.36.88)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

在 2022/5/28 23:12, Ritesh Harjani 写道:
> On 22/05/28 07:00PM, Baokun Li wrote:
>> ext4_mb_normalize_request() can move logical start of allocated blocks
>> to reduce fragmentation and better utilize preallocation. However logical
>> block requested as a start of allocation (ac->ac_o_ex.fe_logical) should
>> always be covered by allocated blocks so we should check that by
>> modifying and to or in the assertion.
>>
>> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> Changes looks good to me as we discussed. Feel free to add -
>
> Reviewed-by: Ritesh Harjani <ritesh.list@gmail.com>
>
>> ---
>> V1->V2:
>> 	Change Fixes from dfe076c106f6 to c9de560ded61.
>> V2->V3:
>> 	Delete Fixes tag.
>> 	Add more comments and commit logs to make the code easier to understand.
>>
>>   fs/ext4/mballoc.c | 17 ++++++++++++++++-
>>   1 file changed, 16 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
>> index 4d3740fdff90..9e06334771a3 100644
>> --- a/fs/ext4/mballoc.c
>> +++ b/fs/ext4/mballoc.c
>> @@ -4185,7 +4185,22 @@ ext4_mb_normalize_request(struct ext4_allocation_context *ac,
>>   	}
>>   	rcu_read_unlock();
>>
>> -	if (start + size <= ac->ac_o_ex.fe_logical &&
>> +	/*
>> +	 * In this function "start" and "size" are normalized for better
>> +	 * alignment and length such that we could preallocate more blocks.
>> +	 * This normalization is done such that original request of
>> +	 * ac->ac_o_ex.fe_logical & fe_len should always lie within "start" and
>> +	 * "size" boundaries.
>> +	 * (Note fe_len can be relaxed since FS block allocation API does not
>> +	 * provide gurantee on number of contiguous blocks allocation since that
>> +	 * depends upon free space left, etc).
>> +	 * In case of inode pa, later we use the allocated blocks
>> +	 * [pa_start + fe_logical - pa_lstart, fe_len/size] from the preallocated
>> +	 * range of goal/best blocks [start, size] to put it at the
>> +	 * ac_o_ex.fe_logical extent of this inode.
>> +	 * (See ext4_mb_use_inode_pa() for more details)
>> +	 */
>> +	if (start + size <= ac->ac_o_ex.fe_logical ||
>>   			start > ac->ac_o_ex.fe_logical) {
>>   		ext4_msg(ac->ac_sb, KERN_ERR,
>>   			 "start %lu, size %lu, fe_logical %lu",
>> --
>> 2.31.1
>>
> .

Thank you for your review!
-- 
With Best Regards,
Baokun Li

