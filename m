Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBC6B697B0F
	for <lists+linux-ext4@lfdr.de>; Wed, 15 Feb 2023 12:47:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233714AbjBOLrG (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 15 Feb 2023 06:47:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233728AbjBOLrC (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 15 Feb 2023 06:47:02 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED2CD3800A
        for <linux-ext4@vger.kernel.org>; Wed, 15 Feb 2023 03:46:55 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id z13so13131048wmp.2
        for <linux-ext4@vger.kernel.org>; Wed, 15 Feb 2023 03:46:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=faQZKHHFpLhX2wgy+xoL7jA6O/xdhku2u9VYP21BKzQ=;
        b=DMlBNRQWEerjCWb6gYuuHDUgcuVG848i8WE5spCpMgOWN6dbI/zOuZ4bB7vy/mut9S
         DwvLOlOJNehqx209gfp45uTElK7P9ZA9yok6IS/vZYl8+rEjjunpr7hyH1F0UxPhSiUl
         jjBS1V5UvltaWK6a06JHTfqBlEu6SVpaybjygN/Cg4ApBL1g411UyXHDEnlEw4GbtYFs
         VjcTzYYiq0HpzsxNbCgiol13RQgmGx0AUkxgQhJNAY22K0v8qPoquScWC0Rrcuw+tKbT
         GQOztpqNhkuaPZcfWWa5MxRh73rbSjgxx25zE6oI87vDszrULLqziYhb3D1A7aChkqaX
         cI0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=faQZKHHFpLhX2wgy+xoL7jA6O/xdhku2u9VYP21BKzQ=;
        b=kpJa9QD4T2oo8aGHUcYIQImeY8GF1RK+jpEuLpms6+jv94EyjyKsEVkyd2qEPSA3Pe
         eHOHVHnkxTAu6GvOHLaYo67xA5PF4yArENIcdyqzlu7nqIdNI2sHodzST2+USauNCgj/
         iYorzdevNvAph4H4OQSxBhQu2b3wCYzMgkYRb85i5hPOqTATDdCpD9KKY/Rh6Up7HBPo
         dlwphtK2HGxomrwO3e37WYFhuMmHzVsyF2MDfJvEJhIQ78WsBk+JuefB0lavntXUhNjE
         rXVSYc+rFeWnaMuAxtHIyRH2xCP+1dGZTsKlb9P5flZz++3DSwkllkj/n1wdXUWP6sM0
         h3Vw==
X-Gm-Message-State: AO0yUKVAzlhhMtX70lxPlY5YeCxPRBoUhBdLIH69ArKNnHblkw+gLWhf
        f1HhuLJXuUIqqz0+awxeJHUMig==
X-Google-Smtp-Source: AK7set8TTOKrYTXUOswpD3TQmRosxuRBBeOH/SWuN4FeWbG6uJJq2udLpIeKWNWBHj1qlxQy5WA4aA==
X-Received: by 2002:a05:600c:1c9a:b0:3df:fc69:e96b with SMTP id k26-20020a05600c1c9a00b003dffc69e96bmr1896344wms.5.1676461614254;
        Wed, 15 Feb 2023 03:46:54 -0800 (PST)
Received: from [192.168.0.108] ([82.77.80.113])
        by smtp.gmail.com with ESMTPSA id c3-20020a7bc843000000b003d9aa76dc6asm1851265wml.0.2023.02.15.03.46.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Feb 2023 03:46:53 -0800 (PST)
Message-ID: <d8f51f11-6942-51bd-7761-a356125d8e53@linaro.org>
Date:   Wed, 15 Feb 2023 11:46:52 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] ext4: reject 1k block fs on the first block of disk
Content-Language: en-US
To:     Theodore Ts'o <tytso@mit.edu>, Jun Nie <jun.nie@linaro.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lee Jones <joneslee@google.com>
References: <20221229014502.2322727-1-jun.nie@linaro.org>
 <Y7R/QKIbYQ2TCP+W@magnolia>
 <CABymUCPCT9KbMQDUTxwf6A+Cg9fWJNkefbMHD7SZD3Fc7FMFHg@mail.gmail.com>
 <Y+xgQklC81XCB+q4@mit.edu>
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <Y+xgQklC81XCB+q4@mit.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi, Ted!

On 2/15/23 04:32, Theodore Ts'o wrote:
> On Wed, Jan 04, 2023 at 09:58:03AM +0800, Jun Nie wrote:
>> Darrick J. Wong <djwong@kernel.org> 于2023年1月4日周三 03:17写道：
>>>
>>> On Thu, Dec 29, 2022 at 09:45:02AM +0800, Jun Nie wrote:
>>>> For 1k-block filesystems, the filesystem starts at block 1, not block 0.
>>>> If start_fsb is 0, it will be bump up to s_first_data_block. Then
>>>> ext4_get_group_no_and_offset don't know what to do and return garbage
>>>> results (blockgroup 2^32-1). The underflow make index
>>>> exceed es->s_groups_count in ext4_get_group_info() and trigger the BUG_ON.
>>>>
>>>> Fixes: 4a4956249dac0 ("ext4: fix off-by-one fsmap error on 1k block filesystems")
>>>> Link: https://syzkaller.appspot.com/bug?id=79d5768e9bfe362911ac1a5057a36fc6b5c30002
>>>> Reported-by: syzbot+6be2b977c89f79b6b153@syzkaller.appspotmail.com
>>>> Signed-off-by: Jun Nie <jun.nie@linaro.org>
>>>> ---
>>>>   fs/ext4/fsmap.c | 6 ++++++
>>>>   1 file changed, 6 insertions(+)
>>>>
>>>> diff --git a/fs/ext4/fsmap.c b/fs/ext4/fsmap.c
>>>> index 4493ef0c715e..1aef127b0634 100644
>>>> --- a/fs/ext4/fsmap.c
>>>> +++ b/fs/ext4/fsmap.c
>>>> @@ -702,6 +702,12 @@ int ext4_getfsmap(struct super_block *sb, struct ext4_fsmap_head *head,
>>>>                if (handlers[i].gfd_dev > head->fmh_keys[0].fmr_device)
>>>>                        memset(&dkeys[0], 0, sizeof(struct ext4_fsmap));
>>>>
>>>> +             /*
>>>> +              * Re-check the range after above limit operation and reject
>>>> +              * 1K fs on block 0 as fs should start block 1. */
>>>> +             if (dkeys[0].fmr_physical ==0 && dkeys[1].fmr_physical == 0)
>>>> +                     continue;
>>>
>>> ...and if this filesystem has 4k blocks, and therefore *does* define a
>>> block 0?
>>
>> Yes, this is a real corner case test :-)
> 
> So I'm really nervous about this change.  I don't understand the code;
> and I don't understand how the reproducer works.  I can certainly
> reproduce it using the reproducer found here[1], but it seems to
> require running multiple processes all creating loop devices and then
> running FS_IOC_GETMAP.
> 
> [1] https://syzkaller.appspot.com/bug?id=79d5768e9bfe362911ac1a5057a36fc6b5c30002
> 
> If I change the reproducer to just run the execute_one() once, it
> doesn't trigger the bug.  It seems to only trigger when you have
> multiple processes all racing to create a loop device, mount the file
> system, try running FS_IOC_GETMAP --- and then delete the loop device
> without actually unmounting the file system.  Which is **weird***.
> 
> I've tried taking the image, and just running "xfs_io -c fsmap /mnt",
> and that doesn't trigger it either.
> 
> And I don't understand the reply to Darrick's question about why it's
> safe to add the check since for 4k block file systems, block 0 *is*
> valid.
> 
> So if someone can explain to me what is going on here with this code
> (there are too many abstractions and what's going on with keys is just
> making my head hurt), *and* what the change actually does, and how to
> reproduce the problem with a ***simple*** reproducer -- the syzbot
> mess doesn't count, that would be great.  But applying a change that I
> don't understand to code I don't understand, to fix a reproducer which
> I also doesn't understand, just doesn't make me feel comfortable.
> 

Let me share what I understood until now. The low key is zeroed. The
high key is defined and uses a fmr_physical of value zero, which is
smaller than the first data block for the 1k-block ext4 fs (which starts
at offset 1024).

-> ext4_getfsmap_datadev()
   keys[0].fmr_physical = 0, keys[1].fmr_physical = 0
   bofs = le32_to_cpu(sbi->s_es->s_first_data_block) = 1, eofs = 256
   start_fsb = keys[0].fmr_physical = 1, end_fsb = keys[1].fmr_physical = 0
   -> ext4_get_group_no_and_offset()
     blocknr = 1, le32_to_cpu(es->s_first_data_block) =1
   start_ag = 0, first_cluster = 0
   ->
     blocknr = 0, le32_to_cpu(es->s_first_data_block) =1
   end_ag = 4294967295, last_cluster = 8191

   Then there's a loop that stops when info->gfi_agno <= end_ag; that 
will trigger the BUG_ON in ext4_get_group_info() as the group nr exceeds 
EXT4_SB(sb)->s_groups_count)
   -> ext4_mballoc_query_range()
     -> ext4_mb_load_buddy()
       -> ext4_mb_load_buddy_gfp()
         -> ext4_get_group_info()

It's an out of bounds request and Darrick suggested to not return any
mapping for the byte range 0-1023 for the 1k-block filesystem. The
alternative would be to return -EINVAL when the high key starts at
fmr_phisical of value zero for the 1k-block fs.

In order to reproduce this one would have to create an 1k-block ext4 fs
and to pass a high key with fmr_physical of value zero, thus I would
expect to reproduce it with something like this:
xfs_io -c 'fsmap -d 0 0' /mnt/scratch

However when doing this I notice that in
xfsprogs-dev/io/fsmap.c l->fmr_device and h->fmr_device will have value
zero, FS_IOC_GETFSMAP is called and then we receive no entries
(head->fmh_entries = 0). Now I'm trying to see what I do wrong, and how
to reproduce the bug.

Cheers,
ta
