Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3854F611F7F
	for <lists+linux-ext4@lfdr.de>; Sat, 29 Oct 2022 04:57:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbiJ2C5J (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 28 Oct 2022 22:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbiJ2C5G (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 28 Oct 2022 22:57:06 -0400
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70D8B1D1AB1
        for <linux-ext4@vger.kernel.org>; Fri, 28 Oct 2022 19:56:40 -0700 (PDT)
Subject: Re: [PATCH] ext4: make ext4_mb_initialize_context return void
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1667012198;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CV7a/QQR+oFlpXmsuE3ax28iQ6IKQ/NfmwK7oLCorTg=;
        b=izY9R0IseBfp2KWE13kPrNeBWS29o2kgwEfHj4ghwGACwGfijaQd03wOggSfub1WVaEOqp
        JEad5mAAIPPRtzV2Q9RW6uhNHK7ViE3w+oBMS4qLR55EqeXcxpbxOdjFMTMq9bLW2cV4Ao
        gqgplwUoZ2sagPOGmHoO32EVE1LWEtk=
To:     Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc:     Jason Yan <yanaijie@huawei.com>, tytso@mit.edu,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org
References: <20221027032435.27374-1-guoqing.jiang@linux.dev>
 <bf9dba6f-50c6-5ba8-31e3-b60de18105f1@huawei.com>
 <23c58b71-8dbc-b314-de53-31e2593f94d4@linux.dev>
 <Y1u05l3L/gb/cSYg@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
Message-ID: <a0b501bc-296d-dcb9-ebd0-8d2d4498c6c1@linux.dev>
Date:   Sat, 29 Oct 2022 10:56:26 +0800
MIME-Version: 1.0
In-Reply-To: <Y1u05l3L/gb/cSYg@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Ojaswin,

On 10/28/22 6:54 PM, Ojaswin Mujoo wrote:
> On Thu, Oct 27, 2022 at 04:12:45PM +0800, Guoqing Jiang wrote:
>>
>> On 10/27/22 2:29 PM, Jason Yan wrote:
>>> On 2022/10/27 11:24, Guoqing Jiang wrote:
>>>> Change the return type to void since it always return 0, and no need
>>>> to do the checking in ext4_mb_new_blocks.
>>>>
>>>> Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
>>>> ---
>>>>    fs/ext4/mballoc.c | 10 ++--------
>>>>    1 file changed, 2 insertions(+), 8 deletions(-)
>>>>
>>>> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
>>>> index 9dad93059945..5b2ae37a8b80 100644
>>>> --- a/fs/ext4/mballoc.c
>>>> +++ b/fs/ext4/mballoc.c
>>>> @@ -5204,7 +5204,7 @@ static void ext4_mb_group_or_file(struct
>>>> ext4_allocation_context *ac)
>>>>        mutex_lock(&ac->ac_lg->lg_mutex);
>>>>    }
>>>>    -static noinline_for_stack int
>>>> +static noinline_for_stack void
>>>>    ext4_mb_initialize_context(struct ext4_allocation_context *ac,
>>>>                    struct ext4_allocation_request *ar)
>>>>    {
>>>> @@ -5253,8 +5253,6 @@ ext4_mb_initialize_context(struct
>>>> ext4_allocation_context *ac,
>>>>                (unsigned) ar->lleft, (unsigned) ar->pleft,
>>>>                (unsigned) ar->lright, (unsigned) ar->pright,
>>>>                inode_is_open_for_write(ar->inode) ? "" : "non-");
>>>> -    return 0;
>>>> -
>>>>    }
>>>>      static noinline_for_stack void
>>>> @@ -5591,11 +5589,7 @@ ext4_fsblk_t ext4_mb_new_blocks(handle_t *handle,
>>>>            goto out;
>>>>        }
>>>>    -    *errp = ext4_mb_initialize_context(ac, ar);
>>>> -    if (*errp) {
>>>> -        ar->len = 0;
>>>> -        goto out;
>>>> -    }
>>>> +    ext4_mb_initialize_context(ac, ar);
>>> This changed the logic here slightly. *errp will not be intialized with
>>> zero after this change. So we need to carefully check whether this will
>>> cause any issues.
>> Yes, thanks for reminder. I think "*errp" is always set later with below.
>>
>> https://elixir.bootlin.com/linux/v6.1-rc2/source/fs/ext4/mballoc.c#L5606
>> https://elixir.bootlin.com/linux/v6.1-rc2/source/fs/ext4/mballoc.c#L5611
>> https://elixir.bootlin.com/linux/v6.1-rc2/source/fs/ext4/mballoc.c#L5629
>> https://elixir.bootlin.com/linux/v6.1-rc2/source/fs/ext4/mballoc.c#L5646
> Hi Guoqing,
>
> I agree, it seems to be intialized correctly later in the code. The
> flow is something like:
>
>    ext4_fsblk_t ext4_mb_new_blocks(...)
>    {
>        ...
>        ext4_mb_initialize_context(ac, ar);
>        ...
>        if (!ext4_mb_use_preallocated(ac)) {
>            *errp = ext4_mb_pa_alloc(ac);  // *errp init to 0 on success
>            ...
>        }
>
>        if (likely(ac->ac_status == AC_STATUS_FOUND)) {
>            // *errp init to 0 on success
>            *errp = ext4_mb_mark_diskspace_used(ac, handle, reserv_clstrs);
>            ...
>        } else {
>            ...
>            *errp = -ENOSPC;
>        }
>        ...
>    }

Yes, thanks for the above.

> So it seems like this cleanup won't alter the behavior. Feel free to,
> add:
>
> Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

Appreciate for your review!

Thanks,
Guoqing
