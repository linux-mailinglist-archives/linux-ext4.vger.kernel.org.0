Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA7D791372
	for <lists+linux-ext4@lfdr.de>; Mon,  4 Sep 2023 10:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234541AbjIDIat (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 4 Sep 2023 04:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjIDIar (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 4 Sep 2023 04:30:47 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F77594;
        Mon,  4 Sep 2023 01:30:42 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-68bedc0c268so995397b3a.0;
        Mon, 04 Sep 2023 01:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693816241; x=1694421041; darn=vger.kernel.org;
        h=in-reply-to:subject:to:from:message-id:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uZ/UamNa2WAGrvZVIew9GnOqWCLV8c0b7yCMONPExh0=;
        b=RNF0KLWH7ldNEy/QA0LK3Zpxc6RWCc0olulH9ghpnSX+ovLmOLPz/7hyV8fZKFaTfF
         JwryOoHB8YOekcd5BKnZD3Q34exxzr/5ycbo41XVCDL/uIwLQ5lwXdQ/sN8UMrNvC68/
         mOZHX8hXDCm3+ym/N5PYy4AcsSbRbmJwsnLLyoV/aduUiLDpT6RCVDgiA/Ny3IA2C4OF
         yV+fBiBu3Jjyv059E+4QYbUQN11s6yJT0NKkwb4b87a5v9Hq6V0x+v9yp37uKSSGRe8e
         R3AUX7GLCUYUXPEU8SU4nd7KJYFV1NiRqmeRolCUd0wyOQd2cXxrUxw/v5tJ8x3cvg/G
         ryXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693816241; x=1694421041;
        h=in-reply-to:subject:to:from:message-id:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uZ/UamNa2WAGrvZVIew9GnOqWCLV8c0b7yCMONPExh0=;
        b=DIMDKdDWIhrDIsD8bxHwFWSG+/VKCiosJDgxz9Zcebpdt4S4qByxtGrsw9WTsIT2CD
         arYRSWi2dkDOivrlFlRZSfFVWvoV9D9QzfWvTim4AUj504Ld3dc1tyLHjI+atuesa+XL
         FBgHCBhSkdz4rKi8YN6mU9MglWUECK4IuC3oRM35YwH1SHFik7DiZhU2YRGatFddxrkI
         ppSJZEUTxk9R+NWm1FLkJbpuVHC31s9JQB3LixDe7o0yOEi1fnStsxRcexV3T8tUE2sd
         OaYsATILla9crqI9DU0DJSa/CH15HvgvN0UCEVibc9ZC2ALVOGzL+XZYAXFIfmDO9IkZ
         halw==
X-Gm-Message-State: AOJu0YzCP126yI5ShmJCTzERvEHmcWj/rU0J71JLK3KXaxuVSTsFe6wW
        158hJWdXudt0XazuttaptHECosEC9Ko=
X-Google-Smtp-Source: AGHT+IF7vtvRapNuxad44dIIVZAxlaWLhAthOx5nIxM1lGlqianBIWgt3xQVh15RSLDH2Dk10DZr0g==
X-Received: by 2002:a05:6a20:4295:b0:14a:b444:dcce with SMTP id o21-20020a056a20429500b0014ab444dccemr13718160pzj.4.1693816240848;
        Mon, 04 Sep 2023 01:30:40 -0700 (PDT)
Received: from dw-tp ([49.207.223.191])
        by smtp.gmail.com with ESMTPSA id j15-20020aa78d0f000000b0068c97a4eb0dsm6831334pfe.191.2023.09.04.01.30.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Sep 2023 01:30:40 -0700 (PDT)
Date:   Mon, 04 Sep 2023 14:00:31 +0530
Message-Id: <87zg222vdk.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Kemeng Shi <shikemeng@huaweicloud.com>, tytso@mit.edu,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 01/11] ext4: factor out codes to update block bitmap and group descriptor on disk from ext4_mb_mark_bb
In-Reply-To: <881e7e86-2300-929e-d8c5-504a68c1a419@huaweicloud.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Kemeng Shi <shikemeng@huaweicloud.com> writes:

> on 8/31/2023 10:07 PM, Ritesh Harjani wrote:
>> Kemeng Shi <shikemeng@huaweicloud.com> writes:
>> 
>>> on 8/31/2023 8:33 PM, Ritesh Harjani wrote:
>>>> Kemeng Shi <shikemeng@huaweicloud.com> writes:
>>>>
>>>> Hello Kemeng,
>>>>
>>>>> There are several reasons to add a general function to update block
>>>>> bitmap and group descriptor on disk:
>>>>
>>>> ... named ext4_mb_mark_context(<params>)
>>>>
>>>>> 1. pair behavior of alloc/free bits. For example,
>>>>> ext4_mb_new_blocks_simple will update free_clusters in struct flex_groups
>>>>> in ext4_mb_mark_bb while ext4_free_blocks_simple forgets this.
>>>>> 2. remove repeat code to read from disk, update and write back to disk.
>>>>> 3. reduce future unit test mocks to catch real IO to update structure
>>>>> on disk.
>>>>>
>>>>> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
>>>>> Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
>>>>> ---
>>>>>  fs/ext4/mballoc.c | 169 +++++++++++++++++++++++++++-------------------
>>>>>  1 file changed, 99 insertions(+), 70 deletions(-)
>>>>>
>>>>> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
>>>>> index c91db9f57524..e2be572deb75 100644
>>>>> --- a/fs/ext4/mballoc.c
>>>>> +++ b/fs/ext4/mballoc.c
>>>>> @@ -3952,6 +3952,100 @@ void ext4_exit_mballoc(void)
>>>>>  	ext4_groupinfo_destroy_slabs();
>>>>>  }
>>>>>  
>>>>> +/*
>>>>> + * Collect global setting to reduce the number of variable passing to
>>>>> + * ext4_mb_mark_context. Pass target group blocks range directly to
>>>>> + * reuse the prepared global setting for multiple block ranges and
>>>>> + * to show clearly the specific block range will be marked.
>>>>> + */
>>>>> +struct ext4_mark_context {
>>>>> +	struct super_block *sb;
>>>>> +	int state;
>>>>> +};
>>>>
>>>> This structure definition does not reflect of it's naming.
>>>> Why can't we also add cblk & clen, flags to it?
>>>>
>>>> I think the idea of defining a new function named
>>>> ext4_mb_prepare_mark_context() was that we can prepare "struct ext4_mark_context"
>>>> with different cblk, clen & flags arguments for cases where we might
>>>> have to call ext4_mb_mark_context() more than once in the same function
>>>> or call ext4_mb_mark_context() anywhere but at the start of the function.
>>>>
>>>> As I see it in the current series, we are calling
>>>> ext4_mb_prepare_mark_context() at the start of every function. Just for
>>>> this purpose we don't need an extra function, right? That we can directly do
>>>> at the time of declaring a structure variable itself (like how you did
>>>> in previous version)
>>>>
>>> Hi Ritesh, thanks for reply. The ext4_mark_context structure aims to reduce
>>> variable passing to ext4_mb_mark_context. If we have to prepare a lot
>>> member in ext4_mb_prepare_mark_context, then too many variables issue occurs
>>> in ext4_mb_prepare_mark_context.
>>> The name of ext4_mark_context maybe not proper. Actually I want a structure
>>> to collect information which is not strongly relevant to mark blk bits. In
>>> this way, we can initialize them at beginning of function, then there is no
>>> need to pay attention to them or to pass them respectively in each call to
>>> ext4_mb_mark_context. Instead, we foucus on the useful information called
>>> with ext4_mb_mark_context.
>>> This design also achive the goal to define ext4_mb_mark_context once for
>>> multiple use in the same function as ext4_mark_context unlikely changes
>>> after initialization at beginning.
>>>> What do you think of the approach where we add cblk, clen & flags
>>>> variables to ext4_mark_context()? Do you see any problems/difficulties
>>>> with that design?
>>>>
>>> The providing desgin looks good to me. Please let me konw if you still
>>> perfre this and I will do this in next version. Thanks!
>>>
>> 
>> I would have still preferred, the block and len arguments inside struct
>> ext4_mark_context, because that better explains the use and definition of
>> structure and it's prepare function.
>> However, since this is not any functionality change, I am fine if you
>> prefer the current design(as you mentioned above).
>> We can always discuss & change it later too :) 
>> 
> Thanks for the reivew. Since more improvement is needed, I would like to
> define ext4_mark_context as you suggested in previous version:
>     ext4_mark_context {
>         ext4_group_t mc_group;          /* block group */
>         ext4_grpblk_t mc_clblk;	    /* block in cluster units */
>         ext4_grpblk_t mc_cllen;	    /* len in cluster units */
>         ext4_grpblk_t mc_clupdates;     /* number of clusters marked/unmarked */
>         unsigned int mc_flags;          /* flags ... */
>         bool mc_state;                  /* to set or unset state */
>     };
> And super_block and handle are passed as arguments.
>
> Besides, as we will pass a lot arguments in prepare function anyway. What
> about simply passing all arguments to ext4_mb_prepare_mark_context
> directly:
> static inline void ext4_mb_mark_context(handle_t *handle,
>                                                 struct super_block *sb,
>                                                 int state,
>                                                 ext4_group_t group,
>                                                 ext4_grpblk_t blkoff,
>                                                 ext4_grpblk_t len,
>                                                 int flags,
>                                                 ext4_grpblk_t *changed)
> Look forward to your reply. Thanks!

Sounds good to me. Thanks

-ritesh
