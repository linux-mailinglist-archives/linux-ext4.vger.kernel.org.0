Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32CC578EF44
	for <lists+linux-ext4@lfdr.de>; Thu, 31 Aug 2023 16:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236405AbjHaOHu (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 31 Aug 2023 10:07:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231364AbjHaOHt (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 31 Aug 2023 10:07:49 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35578B8;
        Thu, 31 Aug 2023 07:07:47 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1c0ecb9a075so5732935ad.2;
        Thu, 31 Aug 2023 07:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693490866; x=1694095666; darn=vger.kernel.org;
        h=in-reply-to:subject:to:from:message-id:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nKmljnXQc8hbvUKMknfY/Hh3OtRtzCqX7FY2eK02Obk=;
        b=Fx/bMg6bK4cchJSM96ifN5gj8E5+lJzDxStI1fM+YKddgUrKVmJDAfi8DTmIOvStGp
         fQ7zLnEf38gx5ceTxpyU+Yvw9dKs3NueswarEk0tWFv6GlwmFd8yr8MMZds+NE4gzJFg
         BJVMmi7jpXxO4aKGiwcRq5AYPEstFH9PP89gzruAPaJLtjsfUhmnaTbRu+1AyWnW/doh
         b3lkps+QcXClCp/9Xh1sZ/FlQ5BMk7wc1wTr1bUVz25raVNlR/qUqtOeM/fg3YgulJll
         LGqpmrAaFYKuVKGrR+mDUtPlAwvAwxC2y19HJcDTfKHiJlazryb+j283JxSD86EnlnGy
         2Ocg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693490866; x=1694095666;
        h=in-reply-to:subject:to:from:message-id:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nKmljnXQc8hbvUKMknfY/Hh3OtRtzCqX7FY2eK02Obk=;
        b=bAwklKegJFqhM1jnaaKe6GVeZhTRumxOAO7/T6tIbSJOrbnapb0EkRBuPFZGwqb6af
         zKnKbntulWUOdDbtzYAwpCwDAezl1qZdb5n5w1scP7IAo8JRQmDBDgwrCIc+Eiotc4lp
         M1Sfp5YttGlqGbkzk3JrtW0cTELQ/11rZoYiUsVXk4tvF6S+UvysGQWRdAzEwb608tsV
         nZqo3R/9R0iKh0xLqYCwzB8bcAn5fB9dDvvnmeOIwPmQrAlsXVUxGYBqXQ5etfcZNTM1
         2vZR886nf+CRZbg95awCXUW194J7n8rWJzSyObF2ghURSGpfY9dSkfH8X0JpoElkhRZU
         lNNw==
X-Gm-Message-State: AOJu0Yy/CrPU9UgncRJnYT9rcDOvTV0YevYYma7P+6zzyrpsIYMcHxg1
        fO0yGNbdyTGq06/Q5HqGUTa6bgngLHw=
X-Google-Smtp-Source: AGHT+IE6CCE2tGlRU53ynLO54L8Y/KpupBA4rXC1ijL2OKBgQwfVG8K+YM9ddKgl+j7RKWpDtK+MKA==
X-Received: by 2002:a17:903:4283:b0:1bd:a42a:215e with SMTP id ju3-20020a170903428300b001bda42a215emr4583049plb.38.1693490865803;
        Thu, 31 Aug 2023 07:07:45 -0700 (PDT)
Received: from dw-tp ([49.207.223.191])
        by smtp.gmail.com with ESMTPSA id x2-20020a170902fe8200b001bf6ea340a9sm1298360plm.159.2023.08.31.07.07.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 07:07:45 -0700 (PDT)
Date:   Thu, 31 Aug 2023 19:37:41 +0530
Message-Id: <87msy78fv6.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Kemeng Shi <shikemeng@huaweicloud.com>, tytso@mit.edu,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 01/11] ext4: factor out codes to update block bitmap and group descriptor on disk from ext4_mb_mark_bb
In-Reply-To: <f3fb910c-c170-43b9-6cac-41fe0562ad6a@huaweicloud.com>
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

> on 8/31/2023 8:33 PM, Ritesh Harjani wrote:
>> Kemeng Shi <shikemeng@huaweicloud.com> writes:
>> 
>> Hello Kemeng,
>> 
>>> There are several reasons to add a general function to update block
>>> bitmap and group descriptor on disk:
>> 
>> ... named ext4_mb_mark_context(<params>)
>> 
>>> 1. pair behavior of alloc/free bits. For example,
>>> ext4_mb_new_blocks_simple will update free_clusters in struct flex_groups
>>> in ext4_mb_mark_bb while ext4_free_blocks_simple forgets this.
>>> 2. remove repeat code to read from disk, update and write back to disk.
>>> 3. reduce future unit test mocks to catch real IO to update structure
>>> on disk.
>>>
>>> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
>>> Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
>>> ---
>>>  fs/ext4/mballoc.c | 169 +++++++++++++++++++++++++++-------------------
>>>  1 file changed, 99 insertions(+), 70 deletions(-)
>>>
>>> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
>>> index c91db9f57524..e2be572deb75 100644
>>> --- a/fs/ext4/mballoc.c
>>> +++ b/fs/ext4/mballoc.c
>>> @@ -3952,6 +3952,100 @@ void ext4_exit_mballoc(void)
>>>  	ext4_groupinfo_destroy_slabs();
>>>  }
>>>  
>>> +/*
>>> + * Collect global setting to reduce the number of variable passing to
>>> + * ext4_mb_mark_context. Pass target group blocks range directly to
>>> + * reuse the prepared global setting for multiple block ranges and
>>> + * to show clearly the specific block range will be marked.
>>> + */
>>> +struct ext4_mark_context {
>>> +	struct super_block *sb;
>>> +	int state;
>>> +};
>> 
>> This structure definition does not reflect of it's naming.
>> Why can't we also add cblk & clen, flags to it?
>> 
>> I think the idea of defining a new function named
>> ext4_mb_prepare_mark_context() was that we can prepare "struct ext4_mark_context"
>> with different cblk, clen & flags arguments for cases where we might
>> have to call ext4_mb_mark_context() more than once in the same function
>> or call ext4_mb_mark_context() anywhere but at the start of the function.
>> 
>> As I see it in the current series, we are calling
>> ext4_mb_prepare_mark_context() at the start of every function. Just for
>> this purpose we don't need an extra function, right? That we can directly do
>> at the time of declaring a structure variable itself (like how you did
>> in previous version)
>> 
> Hi Ritesh, thanks for reply. The ext4_mark_context structure aims to reduce
> variable passing to ext4_mb_mark_context. If we have to prepare a lot
> member in ext4_mb_prepare_mark_context, then too many variables issue occurs
> in ext4_mb_prepare_mark_context.
> The name of ext4_mark_context maybe not proper. Actually I want a structure
> to collect information which is not strongly relevant to mark blk bits. In
> this way, we can initialize them at beginning of function, then there is no
> need to pay attention to them or to pass them respectively in each call to
> ext4_mb_mark_context. Instead, we foucus on the useful information called
> with ext4_mb_mark_context.
> This design also achive the goal to define ext4_mb_mark_context once for
> multiple use in the same function as ext4_mark_context unlikely changes
> after initialization at beginning.
>> What do you think of the approach where we add cblk, clen & flags
>> variables to ext4_mark_context()? Do you see any problems/difficulties
>> with that design?
>> 
> The providing desgin looks good to me. Please let me konw if you still
> perfre this and I will do this in next version. Thanks!
>

I would have still preferred, the block and len arguments inside struct
ext4_mark_context, because that better explains the use and definition of
structure and it's prepare function.
However, since this is not any functionality change, I am fine if you
prefer the current design(as you mentioned above).
We can always discuss & change it later too :) 

Since otherwise the refactoring changes looks good to me.
Please feel free to add -

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

Thanks! 
-ritesh
