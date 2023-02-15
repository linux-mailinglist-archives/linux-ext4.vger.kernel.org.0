Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB0FE697B2F
	for <lists+linux-ext4@lfdr.de>; Wed, 15 Feb 2023 12:53:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233859AbjBOLxq (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 15 Feb 2023 06:53:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbjBOLxp (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 15 Feb 2023 06:53:45 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD3BF38029
        for <linux-ext4@vger.kernel.org>; Wed, 15 Feb 2023 03:53:43 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id f18-20020a7bcd12000000b003e206711347so380282wmj.0
        for <linux-ext4@vger.kernel.org>; Wed, 15 Feb 2023 03:53:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6qAEm60zAjYbidmJtLwfwM2R2OwVdISmEQiRde9avaQ=;
        b=BsjRseDrYNS4oKcnPrCGGLjVNynZOev/qn7wCklDlouinViPLxTfg2NZ+0lK0A07pm
         mVTswAoQ6Xi3ElhUByvwdp9W9nUgDIfVh43tMcDWg4K0YodVuVjfKc5kqTwmcvGqpFca
         clsOIoQgUdhvfBr27BSJ8XP41WYmKTHoUXJodUZI8uUsn1GTfOEfSRCmkgqyK/13QLIL
         G5fdGAnGA1+Kgccxc0jSUkWKC1b+wGhv6oeb5L4+oSe+CfgB8BTYz33R7mRugW8qBsw9
         d03nCwgejUJh5Sa3Ytfiu4CDVXXq6vT/12cwKNiqDfJex6J3V8YNYXC2vxcaEmV5lzXz
         wEGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6qAEm60zAjYbidmJtLwfwM2R2OwVdISmEQiRde9avaQ=;
        b=ybllgjh1ECmX6uBFyhGnwfxCPPv6hKAQUAc/4PEu0QPpCvIHX88uvnuEiIev4L+Xo/
         uFdzvHUh/Fs/pYsSxWgpmGnukBof7zkQK4QVa2xgfNZn9DRFpVnHUZEc0eCq1LtRSjdI
         xnp2yrLOf4r05ZkXGsHJiJW5MHxTZCM+97S+RBQblia03W+dg2+xeDS+Z3Jvh69UjFbk
         l4AfH6U6MS+hR1/Gd1a468sHEXlGlRqziQItwASKoXK57LCp9fIM9Kw9113tImavSBrT
         q3rm918OLPt3P9YeHPZZSIpj6auZ7zFmhbYGMW7nEK6tv6SYFwDz3biXDQH2NK/Z2LeK
         bq+g==
X-Gm-Message-State: AO0yUKVvJ8m5deBAq24DIGAtkDNt6l9y1mo7QK7SnVqao+v8vLOHNe2y
        o+O+by8tuFPCYKDmnfM+b8Vy3A==
X-Google-Smtp-Source: AK7set8Pf8ltr+gtEvF1S6oNXjt9R10oMEqRkPBeVcL7ka4NgaYK6sS3PXiv27//TZcVPUYhmg/EOw==
X-Received: by 2002:a05:600c:13c3:b0:3e2:522:45f7 with SMTP id e3-20020a05600c13c300b003e2052245f7mr1127957wmg.13.1676462022351;
        Wed, 15 Feb 2023 03:53:42 -0800 (PST)
Received: from [192.168.0.108] ([82.77.80.113])
        by smtp.gmail.com with ESMTPSA id r18-20020a05600c459200b003dc4baaedd3sm2069483wmo.37.2023.02.15.03.53.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Feb 2023 03:53:42 -0800 (PST)
Message-ID: <4e5fb36f-d234-1f94-5e6c-746aef612bb6@linaro.org>
Date:   Wed, 15 Feb 2023 11:53:40 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] ext4: reject 1k block fs on the first block of disk
Content-Language: en-US
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
To:     Theodore Ts'o <tytso@mit.edu>, Jun Nie <jun.nie@linaro.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lee Jones <joneslee@google.com>
References: <20221229014502.2322727-1-jun.nie@linaro.org>
 <Y7R/QKIbYQ2TCP+W@magnolia>
 <CABymUCPCT9KbMQDUTxwf6A+Cg9fWJNkefbMHD7SZD3Fc7FMFHg@mail.gmail.com>
 <Y+xgQklC81XCB+q4@mit.edu> <d8f51f11-6942-51bd-7761-a356125d8e53@linaro.org>
In-Reply-To: <d8f51f11-6942-51bd-7761-a356125d8e53@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On 2/15/23 11:46, Tudor Ambarus wrote:
> Hi, Ted!
> 
> On 2/15/23 04:32, Theodore Ts'o wrote:
>> On Wed, Jan 04, 2023 at 09:58:03AM +0800, Jun Nie wrote:
>>> Darrick J. Wong <djwong@kernel.org> 于2023年1月4日周三 03:17写道：
>>>>
>>>> On Thu, Dec 29, 2022 at 09:45:02AM +0800, Jun Nie wrote:
>>>>> For 1k-block filesystems, the filesystem starts at block 1, not 
>>>>> block 0.
>>>>> If start_fsb is 0, it will be bump up to s_first_data_block. Then
>>>>> ext4_get_group_no_and_offset don't know what to do and return garbage
>>>>> results (blockgroup 2^32-1). The underflow make index
>>>>> exceed es->s_groups_count in ext4_get_group_info() and trigger the 
>>>>> BUG_ON.
>>>>>
>>>>> Fixes: 4a4956249dac0 ("ext4: fix off-by-one fsmap error on 1k block 
>>>>> filesystems")
>>>>> Link: 
>>>>> https://syzkaller.appspot.com/bug?id=79d5768e9bfe362911ac1a5057a36fc6b5c30002
>>>>> Reported-by: syzbot+6be2b977c89f79b6b153@syzkaller.appspotmail.com
>>>>> Signed-off-by: Jun Nie <jun.nie@linaro.org>
>>>>> ---
>>>>>   fs/ext4/fsmap.c | 6 ++++++
>>>>>   1 file changed, 6 insertions(+)
>>>>>
>>>>> diff --git a/fs/ext4/fsmap.c b/fs/ext4/fsmap.c
>>>>> index 4493ef0c715e..1aef127b0634 100644
>>>>> --- a/fs/ext4/fsmap.c
>>>>> +++ b/fs/ext4/fsmap.c
>>>>> @@ -702,6 +702,12 @@ int ext4_getfsmap(struct super_block *sb, 
>>>>> struct ext4_fsmap_head *head,
>>>>>                if (handlers[i].gfd_dev > head->fmh_keys[0].fmr_device)
>>>>>                        memset(&dkeys[0], 0, sizeof(struct 
>>>>> ext4_fsmap));
>>>>>
>>>>> +             /*
>>>>> +              * Re-check the range after above limit operation and 
>>>>> reject
>>>>> +              * 1K fs on block 0 as fs should start block 1. */
>>>>> +             if (dkeys[0].fmr_physical ==0 && 
>>>>> dkeys[1].fmr_physical == 0)
>>>>> +                     continue;
>>>>
>>>> ...and if this filesystem has 4k blocks, and therefore *does* define a
>>>> block 0?
>>>
>>> Yes, this is a real corner case test :-)
>>
>> So I'm really nervous about this change.  I don't understand the code;
>> and I don't understand how the reproducer works.  I can certainly
>> reproduce it using the reproducer found here[1], but it seems to
>> require running multiple processes all creating loop devices and then
>> running FS_IOC_GETMAP.
>>
>> [1] 
>> https://syzkaller.appspot.com/bug?id=79d5768e9bfe362911ac1a5057a36fc6b5c30002
>>
>> If I change the reproducer to just run the execute_one() once, it
>> doesn't trigger the bug.  It seems to only trigger when you have
>> multiple processes all racing to create a loop device, mount the file
>> system, try running FS_IOC_GETMAP --- and then delete the loop device
>> without actually unmounting the file system.  Which is **weird***.
>>
>> I've tried taking the image, and just running "xfs_io -c fsmap /mnt",
>> and that doesn't trigger it either.
>>
>> And I don't understand the reply to Darrick's question about why it's
>> safe to add the check since for 4k block file systems, block 0 *is*
>> valid.
>>
>> So if someone can explain to me what is going on here with this code
>> (there are too many abstractions and what's going on with keys is just
>> making my head hurt), *and* what the change actually does, and how to
>> reproduce the problem with a ***simple*** reproducer -- the syzbot
>> mess doesn't count, that would be great.  But applying a change that I
>> don't understand to code I don't understand, to fix a reproducer which
>> I also doesn't understand, just doesn't make me feel comfortable.
>>
> 
> Let me share what I understood until now. The low key is zeroed. The
> high key is defined and uses a fmr_physical of value zero, which is
> smaller than the first data block for the 1k-block ext4 fs (which starts
> at offset 1024).
> 
> -> ext4_getfsmap_datadev()
>    keys[0].fmr_physical = 0, keys[1].fmr_physical = 0
>    bofs = le32_to_cpu(sbi->s_es->s_first_data_block) = 1, eofs = 256
>    start_fsb = keys[0].fmr_physical = 1, end_fsb = keys[1].fmr_physical = 0
>    -> ext4_get_group_no_and_offset()
>      blocknr = 1, le32_to_cpu(es->s_first_data_block) =1
>    start_ag = 0, first_cluster = 0
>    ->
>      blocknr = 0, le32_to_cpu(es->s_first_data_block) =1
>    end_ag = 4294967295, last_cluster = 8191

because of poor key validation we get a wrong end_ag which eventually
causes the BUG_ON.

> 
>    Then there's a loop that stops when info->gfi_agno <= end_ag; that 
> will trigger the BUG_ON in ext4_get_group_info() as the group nr exceeds 
> EXT4_SB(sb)->s_groups_count)
>    -> ext4_mballoc_query_range()
>      -> ext4_mb_load_buddy()
>        -> ext4_mb_load_buddy_gfp()
>          -> ext4_get_group_info()
> 
> It's an out of bounds request and Darrick suggested to not return any
> mapping for the byte range 0-1023 for the 1k-block filesystem. The
> alternative would be to return -EINVAL when the high key starts at
> fmr_phisical of value zero for the 1k-block fs.
> 
> In order to reproduce this one would have to create an 1k-block ext4 fs
> and to pass a high key with fmr_physical of value zero, thus I would
> expect to reproduce it with something like this:
> xfs_io -c 'fsmap -d 0 0' /mnt/scratch
> 
> However when doing this I notice that in
> xfsprogs-dev/io/fsmap.c l->fmr_device and h->fmr_device will have value
> zero, FS_IOC_GETFSMAP is called and then we receive no entries
> (head->fmh_entries = 0). Now I'm trying to see what I do wrong, and how
> to reproduce the bug.
> 
> Cheers,
> ta
