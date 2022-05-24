Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 520F35322DD
	for <lists+linux-ext4@lfdr.de>; Tue, 24 May 2022 08:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234725AbiEXGJk (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 24 May 2022 02:09:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234732AbiEXGJi (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 24 May 2022 02:09:38 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9805A6A438;
        Mon, 23 May 2022 23:09:37 -0700 (PDT)
Received: from dggpeml500020.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4L6kKd6wN7zjWvr;
        Tue, 24 May 2022 14:08:53 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500020.china.huawei.com (7.185.36.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 24 May 2022 14:09:35 +0800
Message-ID: <371b06da-e3e4-f717-234c-bfb32d323b5f@huawei.com>
Date:   Tue, 24 May 2022 14:09:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
From:   Baokun Li <libaokun1@huawei.com>
Subject: Re: [PATCH 2/2] ext4: correct the judgment of BUG in
 ext4_mb_normalize_request
To:     Ritesh Harjani <ritesh.list@gmail.com>
CC:     <linux-ext4@vger.kernel.org>, <tytso@mit.edu>,
        <adilger.kernel@dilger.ca>, <jack@suse.cz>,
        <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>,
        <yebin10@huawei.com>, <yukuai3@huawei.com>
References: <20220521134217.312071-1-libaokun1@huawei.com>
 <20220521134217.312071-3-libaokun1@huawei.com>
 <20220523200844.fal3pmp7epid3rvv@riteshh-domain>
In-Reply-To: <20220523200844.fal3pmp7epid3rvv@riteshh-domain>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.174]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500020.china.huawei.com (7.185.36.88)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

在 2022/5/24 4:08, Ritesh Harjani 写道:
> On 22/05/21 09:42PM, Baokun Li wrote:
>> When either of the "start + size <= ac->ac_o_ex.fe_logical" or
>> "start > ac->ac_o_ex.fe_logical" conditions is met, it indicates
>> that the fe_logical is not in the allocated range.
> Sounds about right to me based on the logic in ext4_mb_use_inode_pa().
> We try to allocate/preallocate such that ac->ac_o_ex.fe_logical should fall
> within the preallocated range. So if our start or start + size doesn't include
> fe_logical then it is a bug in the ext4_mb_normalize_request() logic.
Yes, exactly.
> But should we be so harsh to hit a bug_on() or make it warn_on()?
I don't think hit a bug_on() is a problem. BUG_ON is not triggered here 
and will be triggered later.
> Also did you run any fs tests with this change.
Yes, I ran xfstests on ext3 and ext4 and found no problems.
> Since it looks like this
> logic existed since mballoc was introduced.
>
Yes, on our coverage report, those lines of code never seem to get there.

>> In this case, it should be bug_ON.
>>
>> Fixes: dfe076c106f6 ("ext4: get rid of code duplication")
> No, there is no issue with this patch. It correctly just removes the duplicate
> logic.
Okay, I'm going to remove this tag.
>> Signed-off-by: Baokun Li<libaokun1@huawei.com>
>> ---
>>   fs/ext4/mballoc.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
>> index 32410b79b664..d0fb57970648 100644
>> --- a/fs/ext4/mballoc.c
>> +++ b/fs/ext4/mballoc.c
>> @@ -4190,7 +4190,7 @@ ext4_mb_normalize_request(struct ext4_allocation_context *ac,
>>   	}
>>   	rcu_read_unlock();
>>
>> -	if (start + size <= ac->ac_o_ex.fe_logical &&
>> +	if (start + size <= ac->ac_o_ex.fe_logical ||
>>   			start > ac->ac_o_ex.fe_logical) {
>>   		ext4_msg(ac->ac_sb, KERN_ERR,
>>   			 "start %lu, size %lu, fe_logical %lu",
>> --
>> 2.31.1
>>
> .

-- 
With Best Regards,
Baokun Li

