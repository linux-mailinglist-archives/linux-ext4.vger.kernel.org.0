Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF61C60F1F4
	for <lists+linux-ext4@lfdr.de>; Thu, 27 Oct 2022 10:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233850AbiJ0IMt (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 27 Oct 2022 04:12:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbiJ0IMt (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 27 Oct 2022 04:12:49 -0400
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8F28FBCC1
        for <linux-ext4@vger.kernel.org>; Thu, 27 Oct 2022 01:12:47 -0700 (PDT)
Subject: Re: [PATCH] ext4: make ext4_mb_initialize_context return void
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1666858366;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SJVZrUr41goct1Mh+/412/ZAMANgHCVy8AhsoEQbyzI=;
        b=dxCz4ShHlfOxgV8tJV8edUux/Ro4Hgan6Dod7AXGaV2HKPku3kDa9sAuiT1dolWQ0iRl+t
        FPOowG4a3ZB9BnFh+D08AMDhb3jniYeChRWPBAq8XeYtkH54IKmRNXcZfC1voKSSyVPWwS
        0G01AA7kHjWFjCiv3XTD2EtVwuxhxPw=
To:     Jason Yan <yanaijie@huawei.com>, tytso@mit.edu,
        adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org
References: <20221027032435.27374-1-guoqing.jiang@linux.dev>
 <bf9dba6f-50c6-5ba8-31e3-b60de18105f1@huawei.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
Message-ID: <23c58b71-8dbc-b314-de53-31e2593f94d4@linux.dev>
Date:   Thu, 27 Oct 2022 16:12:45 +0800
MIME-Version: 1.0
In-Reply-To: <bf9dba6f-50c6-5ba8-31e3-b60de18105f1@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On 10/27/22 2:29 PM, Jason Yan wrote:
>
> On 2022/10/27 11:24, Guoqing Jiang wrote:
>> Change the return type to void since it always return 0, and no need
>> to do the checking in ext4_mb_new_blocks.
>>
>> Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
>> ---
>>   fs/ext4/mballoc.c | 10 ++--------
>>   1 file changed, 2 insertions(+), 8 deletions(-)
>>
>> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
>> index 9dad93059945..5b2ae37a8b80 100644
>> --- a/fs/ext4/mballoc.c
>> +++ b/fs/ext4/mballoc.c
>> @@ -5204,7 +5204,7 @@ static void ext4_mb_group_or_file(struct 
>> ext4_allocation_context *ac)
>>       mutex_lock(&ac->ac_lg->lg_mutex);
>>   }
>>   -static noinline_for_stack int
>> +static noinline_for_stack void
>>   ext4_mb_initialize_context(struct ext4_allocation_context *ac,
>>                   struct ext4_allocation_request *ar)
>>   {
>> @@ -5253,8 +5253,6 @@ ext4_mb_initialize_context(struct 
>> ext4_allocation_context *ac,
>>               (unsigned) ar->lleft, (unsigned) ar->pleft,
>>               (unsigned) ar->lright, (unsigned) ar->pright,
>>               inode_is_open_for_write(ar->inode) ? "" : "non-");
>> -    return 0;
>> -
>>   }
>>     static noinline_for_stack void
>> @@ -5591,11 +5589,7 @@ ext4_fsblk_t ext4_mb_new_blocks(handle_t *handle,
>>           goto out;
>>       }
>>   -    *errp = ext4_mb_initialize_context(ac, ar);
>> -    if (*errp) {
>> -        ar->len = 0;
>> -        goto out;
>> -    }
>> +    ext4_mb_initialize_context(ac, ar);
>
> This changed the logic here slightly. *errp will not be intialized 
> with zero after this change. So we need to carefully check whether 
> this will cause any issues.

Yes, thanks for reminder. I think "*errp" is always set later with below.

https://elixir.bootlin.com/linux/v6.1-rc2/source/fs/ext4/mballoc.c#L5606
https://elixir.bootlin.com/linux/v6.1-rc2/source/fs/ext4/mballoc.c#L5611
https://elixir.bootlin.com/linux/v6.1-rc2/source/fs/ext4/mballoc.c#L5629
https://elixir.bootlin.com/linux/v6.1-rc2/source/fs/ext4/mballoc.c#L5646

Is there any place where don't set it accordfingly? If so,  the below 
should be kept.

*errp = ext4_mb_initialize_context(ac, ar);

Thanks,
Guoqing
