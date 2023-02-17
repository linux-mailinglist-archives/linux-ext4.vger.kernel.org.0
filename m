Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAC3069A7C3
	for <lists+linux-ext4@lfdr.de>; Fri, 17 Feb 2023 10:04:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbjBQJEz (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 17 Feb 2023 04:04:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbjBQJEy (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 17 Feb 2023 04:04:54 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 532125FBFE
        for <linux-ext4@vger.kernel.org>; Fri, 17 Feb 2023 01:04:52 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id er25so1481606edb.6
        for <linux-ext4@vger.kernel.org>; Fri, 17 Feb 2023 01:04:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Dhb0aPgnPmpo07pKFTh62OPPG7TlvzL6v9Z1rC4Zkkg=;
        b=qVqnYG2BR/uaxokjqUCtvuy9n/aZFD4BUvKqra79mx+N3fb7GKsS39RqG3yICm25Ql
         oeZBuXDCnNDWU/dgjYwA6PwfNKFJ7AeFwn31m3mWSd5slh7ig+fa2ulMBB0LY+0OlZqi
         ZO2Bvz6q4uvPUK1u1sw/eeeQssHB8kWVutdTpioz7cjKjt8+1bEH572cDgKeYYJLtfS8
         QL/xY9gYKVM0+fWxVq54igCRKscUkfHEgm1Nrr73otlAyKgVfy8L5OYfe5XKWSphGx7V
         ZY0hwksNPTpeyYwnOQ9bUu7HsjAid6jQGpoYDWhIg+fJudAlNZCvMJLQSfSiAdxuNfA1
         Xb3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dhb0aPgnPmpo07pKFTh62OPPG7TlvzL6v9Z1rC4Zkkg=;
        b=uChUJ9JnXLbJy+n5ZgSvHxSPtRokwWbbRHZqZcnLCOLWgQXjxbIqAvVOGSgX81EOrw
         9kDyMDcbXVAzWLMp7GgnXra/3LAi36QrxcHoZYgpvybp55u72QSPP0OIUdf38AbaMkdb
         nI0pYlhMMGUk21HKTeeaHPaVO4qgT8Rnzcecf6L333CXwaomu/Y1ZBYIkTq4bmNunD1m
         V5qmJ+ji+TdaO7pO3nso4USQhPmcoMUoGQ2HlkAIOs3N/VVZQ0LqrdwRhBcN65crMY7P
         brQFkcA9xVnZkpvIewdPFJdBv9cY7IB4s0aHbB+nnw+odOvyNQNfpKFf5+mYMRNdLvMv
         DQ/g==
X-Gm-Message-State: AO0yUKXy9bNfkrcszqUuoSTYvAp+w6T4nY2dxM4EFzmInywWnor3kKi4
        13LHu/fIrarIsr0FZtZXtqIm7tLH9ToHbHWs
X-Google-Smtp-Source: AK7set+tAcSvpwfAAlLUptl/j567KNqu4vpCF3WTsS8yA5J8qWm0aSmzWMiPCp9ZE1TurarXy/CYwg==
X-Received: by 2002:aa7:cd6d:0:b0:4ac:bd84:43d9 with SMTP id ca13-20020aa7cd6d000000b004acbd8443d9mr462571edb.2.1676624690805;
        Fri, 17 Feb 2023 01:04:50 -0800 (PST)
Received: from [192.168.0.108] ([82.77.80.113])
        by smtp.gmail.com with ESMTPSA id u12-20020a50c04c000000b004ab4db9be14sm1988264edd.81.2023.02.17.01.04.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Feb 2023 01:04:50 -0800 (PST)
Message-ID: <3e125c64-da56-2a2b-1a20-fdcc5a0d3014@linaro.org>
Date:   Fri, 17 Feb 2023 09:04:49 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] ext4: fix another off-by-one fsmap error on 1k block
 filesystems
Content-Language: en-US
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
To:     "Darrick J. Wong" <djwong@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>
Cc:     Jun Nie <jun.nie@linaro.org>, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lee Jones <joneslee@google.com>
References: <Y+58NPTH7VNGgzdd@magnolia>
 <5da85766-65c7-107f-e525-2ae75b04750a@linaro.org>
 <4b705abb-f780-1342-c1ec-9187687ef8af@linaro.org>
In-Reply-To: <4b705abb-f780-1342-c1ec-9187687ef8af@linaro.org>
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



On 2/17/23 08:37, Tudor Ambarus wrote:
> 
> 
> On 2/17/23 08:10, Tudor Ambarus wrote:
>> Hi, Darrick,
>>
>> On 2/16/23 18:55, Darrick J. Wong wrote:
>>> From: Darrick J. Wong <djwong@kernel.org>
>>>
>>> Apparently syzbot figured out that issuing this FSMAP call:
>>>
>>> struct fsmap_head cmd = {
>>>     .fmh_count    = ...;
>>>     .fmh_keys    = {
>>>         { .fmr_device = /* ext4 dev */, .fmr_physical = 0, },
>>>         { .fmr_device = /* ext4 dev */, .fmr_physical = 0, },
>>>     },
>>> ...
>>> };
>>> ret = ioctl(fd, FS_IOC_GETFSMAP, &cmd);
>>>
>>> Produces this crash if the underlying filesystem is a 1k-block ext4
>>> filesystem:
>>>
>>> kernel BUG at fs/ext4/ext4.h:3331!
>>> invalid opcode: 0000 [#1] PREEMPT SMP
>>> CPU: 3 PID: 3227965 Comm: xfs_io Tainted: G        W  O 6.2.0-rc8-achx
>>> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.15.0-1 
>>> 04/01/2014
>>> RIP: 0010:ext4_mb_load_buddy_gfp+0x47c/0x570 [ext4]
>>> RSP: 0018:ffffc90007c03998 EFLAGS: 00010246
>>> RAX: ffff888004978000 RBX: ffffc90007c03a20 RCX: ffff888041618000
>>> RDX: 0000000000000000 RSI: 00000000000005a4 RDI: ffffffffa0c99b11
>>> RBP: ffff888012330000 R08: ffffffffa0c2b7d0 R09: 0000000000000400
>>> R10: ffffc90007c03950 R11: 0000000000000000 R12: 0000000000000001
>>> R13: 00000000ffffffff R14: 0000000000000c40 R15: ffff88802678c398
>>> FS:  00007fdf2020c880(0000) GS:ffff88807e100000(0000) 
>>> knlGS:0000000000000000
>>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>> CR2: 00007ffd318a5fe8 CR3: 000000007f80f001 CR4: 00000000001706e0
>>> Call Trace:
>>>   <TASK>
>>>   ext4_mballoc_query_range+0x4b/0x210 [ext4 
>>> dfa189daddffe8fecd3cdfd00564e0f265a8ab80]
>>>   ext4_getfsmap_datadev+0x713/0x890 [ext4 
>>> dfa189daddffe8fecd3cdfd00564e0f265a8ab80]
>>>   ext4_getfsmap+0x2b7/0x330 [ext4 
>>> dfa189daddffe8fecd3cdfd00564e0f265a8ab80]
>>>   ext4_ioc_getfsmap+0x153/0x2b0 [ext4 
>>> dfa189daddffe8fecd3cdfd00564e0f265a8ab80]
>>>   __ext4_ioctl+0x2a7/0x17e0 [ext4 
>>> dfa189daddffe8fecd3cdfd00564e0f265a8ab80]
>>>   __x64_sys_ioctl+0x82/0xa0
>>>   do_syscall_64+0x2b/0x80
>>>   entry_SYSCALL_64_after_hwframe+0x46/0xb0
>>> RIP: 0033:0x7fdf20558aff
>>> RSP: 002b:00007ffd318a9e30 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
>>> RAX: ffffffffffffffda RBX: 00000000000200c0 RCX: 00007fdf20558aff
>>> RDX: 00007fdf1feb2010 RSI: 00000000c0c0583b RDI: 0000000000000003
>>> RBP: 00005625c0634be0 R08: 00005625c0634c40 R09: 0000000000000001
>>> R10: 0000000000000000 R11: 0000000000000246 R12: 00007fdf1feb2010
>>> R13: 00005625be70d994 R14: 0000000000000800 R15: 0000000000000000
>>>
>>> For GETFSMAP calls, the caller selects a physical block device by
>>> writing its block number into fsmap_head.fmh_keys[01].fmr_device.
>>> To query mappings for a subrange of the device, the starting byte of the
>>> range is written to fsmap_head.fmh_keys[0].fmr_physical and the last
>>> byte of the range goes in fsmap_head.fmh_keys[1].fmr_physical.
>>>
>>> IOWs, to query what mappings overlap with bytes 3-14 of /dev/sda, you'd
>>> set the inputs as follows:
>>>
>>>     fmh_keys[0] = { .fmr_device = major(8, 0), .fmr_physical = 3},
>>>     fmh_keys[1] = { .fmr_device = major(8, 0), .fmr_physical = 14},
>>>
>>> Which would return you whatever is mapped in the 12 bytes starting at
>>> physical offset 3.
>>>
>>> The crash is due to insufficient range validation of keys[1] in
>>> ext4_getfsmap_datadev.  On 1k-block filesystems, block 0 is not part of
>>> the filesystem, which means that s_first_data_block is nonzero.
>>> ext4_get_group_no_and_offset subtracts this quantity from the blocknr
>>> argument before cracking it into a group number and a block number
>>> within a group.  IOWs, block group 0 spans blocks 1-8192 (1-based)
>>> instead of 0-8191 (0-based) like what happens with larger blocksizes.
>>>
>>> The net result of this encoding is that blocknr < s_first_data_block is
>>> not a valid input to this function.  The end_fsb variable is set from
>>> the keys that are copied from userspace, which means that in the above
>>> example, its value is zero.  That leads to an underflow here:
>>>
>>>     blocknr = blocknr - le32_to_cpu(es->s_first_data_block);
>>>
>>> The division then operates on -1:
>>>
>>>     offset = do_div(blocknr, EXT4_BLOCKS_PER_GROUP(sb)) >>
>>>         EXT4_SB(sb)->s_cluster_bits;
>>>
>>> Leaving an impossibly large group number (2^32-1) in blocknr.
>>> ext4_getfsmap_check_keys checked that keys[0].fmr_physical and
>>> keys[1].fmr_physical are in increasing order, but
>>> ext4_getfsmap_datadev adjusts keys[0].fmr_physical to be at least
>>> s_first_data_block.  This implies that we have to check it again after
>>> the adjustment, which is the piece that I forgot.
>>>
>>> Fixes: 4a4956249dac ("ext4: fix off-by-one fsmap error on 1k block 
>>> filesystems")
>>> Link: 
>>> https://syzkaller.appspot.com/bug?id=79d5768e9bfe362911ac1a5057a36fc6b5c30002
>>> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
>>> ---
>>>   fs/ext4/fsmap.c |    2 ++
>>>   1 file changed, 2 insertions(+)
>>>
>>> diff --git a/fs/ext4/fsmap.c b/fs/ext4/fsmap.c
>>> index 4493ef0c715e..cdf9bfe10137 100644
>>> --- a/fs/ext4/fsmap.c
>>> +++ b/fs/ext4/fsmap.c
>>> @@ -486,6 +486,8 @@ static int ext4_getfsmap_datadev(struct 
>>> super_block *sb,
>>>           keys[0].fmr_physical = bofs;
>>>       if (keys[1].fmr_physical >= eofs)
>>>           keys[1].fmr_physical = eofs - 1;
>>> +    if (keys[1].fmr_physical < keys[0].fmr_physical)
>>> +        return 0;
>>
>> This is an indirect implication, we can be more straightforward. Also we
>> should stop the execution when high_key->fmr_physical == bofs. So maybe:
>>
>> --- a/fs/ext4/fsmap.c
>> +++ b/fs/ext4/fsmap.c
>> @@ -479,6 +479,8 @@ static int ext4_getfsmap_datadev(struct 
>> super_block *sb,
>>          int error = 0;
>>
>>          bofs = le32_to_cpu(sbi->s_es->s_first_data_block);
>> +       if (keys[1].fmr_physical <= bofs)
>> +               return 0;
>>          eofs = ext4_blocks_count(sbi->s_es);
>>          if (keys[0].fmr_physical >= eofs)
>>                  return 0;
> 
> oops, it was too morning for me, this is wrong, as the high key can come 
> with zero value. So if we want to keep the check in

or maybe not? xfsprogs-dev/io/fsmap.c initializes h->fmr_physical = end;
and end = -1 for the ext4 case.

 From the code I see two magic values that are accepted for fmr_device,
zero and UINT_MAX, so maybe we should check the sanity of the keys's
fmr_physical considering the magic values for fmr_device. I'll stop
burbling and wait for Darrick's feedback.

Cheers,
ta

> ext4_getfsmap_datadev we can use your patch, but slightly adapted to
> if (keys[1].fmr_physical <= keys[0].fmr_physical)
>      return 0;
> 
> However I think I prefer the version from below if it makes sense.
> Cheers,
> ta
> 
>>
>>
>> But I'm not thrilled about this. Can we stop the execution earlier?
>> How about something like:
>>
>> diff --git a/fs/ext4/fsmap.c b/fs/ext4/fsmap.c
>> index 4493ef0c715e..8c4b1fb5c10a 100644
>> --- a/fs/ext4/fsmap.c
>> +++ b/fs/ext4/fsmap.c
>> @@ -586,10 +586,12 @@ static bool ext4_getfsmap_check_keys(struct 
>> ext4_fsmap *low_key,
>>   {
>>          if (low_key->fmr_device > high_key->fmr_device)
>>                  return false;
>> -       if (low_key->fmr_device < high_key->fmr_device)
>> +       if (low_key->fmr_device != 0 &&
>> +           low_key->fmr_device < high_key->fmr_device)
>>                  return true;
>>
>> -       if (low_key->fmr_physical > high_key->fmr_physical)
>> +       if (high_key->fmr_physical == 0 ||
>> +           low_key->fmr_physical > high_key->fmr_physical)
>>                  return false;
>>          if (low_key->fmr_physical < high_key->fmr_physical)
>>                  return true;
>>
>> You'll notice that my proposal will stop the execution with -EINVAL, as
>> the key range is invalid IMO. But we can adapt code to return zero if
>> you like, what I'm interested in is whether this key check is valid for
>> ext4_getfsmap_logdev() or not. How about the
>> if (keys[1].fmr_physical == bofs) check, is it valid for
>> ext4_getfsmap_logdev()?
>>
>> I'd like that with your guidance to fix this bug, extend the xfs_io
>> fsmap support to query ext4 fs range and to add an xfstest for keys
>> validation, to check if stable kernels will be fixed. This would help me
>> with the fs ramp-up, as I'd like to fix some other fs bugs too. If you
>> want to handle this by yourself, it's fine too, but please let me know
>> so that we don't duplicate effort.
>>
>> Cheers,
>> ta
