Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90C4B69F7C8
	for <lists+linux-ext4@lfdr.de>; Wed, 22 Feb 2023 16:29:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231684AbjBVP34 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 22 Feb 2023 10:29:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231842AbjBVP3z (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 22 Feb 2023 10:29:55 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50CE114E8D
        for <linux-ext4@vger.kernel.org>; Wed, 22 Feb 2023 07:29:53 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id ck15so33173383edb.0
        for <linux-ext4@vger.kernel.org>; Wed, 22 Feb 2023 07:29:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YRpTGuARTRBMn36r7tlXq3qs+CoLxHqb66PgbsuqrJE=;
        b=aFfhi1Q8liHmCDttqXt4BsRE4pKOyZ0BsLYT1rHW4sAf2cDnZaVnaOcNi9Srhgcri4
         2weua2b9PjnHvF7A69aGjDs61at2sWlxZmigpK+jmJ4eCpM7a7WEeWr+XpLtekbFlpbZ
         wRsPek9Mr2Mh4aACdHW4f4dYR9reJpqp5g2cvHoquprU9j2kexlgxVaQLFxX0aPfDcJ/
         xMs3kLPlD6FGyc3s412vZaYpD2CCj1M4dXX7kW28PTf1/pEVmY66qa0XpVEqfzrfeqbr
         MM00XJKfXUwonXSrZZNSoc1vDYVIQKUK8Cgw8EeZLsxrZVDuYVUSQ9F6Pdv0lPPvT1Fo
         EAkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YRpTGuARTRBMn36r7tlXq3qs+CoLxHqb66PgbsuqrJE=;
        b=57J6v5yMQA4PMvS/Nl7cxgPUH0jBX0pXsI+T6XH3yJlmdHJkQJXWdokCjUwzRM3NG1
         tYtsG1KufbBvNHf85iClnbnx3yBL3NyBfN6K65eeAVmQLczFSnSmiTXiV889GYDg9Ihs
         YtaATv/ZfUgI+3bzFL3j1rpLDyUoPnPbSsYRDOkgy6kVmWQtfgQ/diBmsMaM18pePGN0
         jWtYXnGTldH0zxc1ti9iEzPc3z3W+N9QkOH8SBrSCjsHNclBd/h29cG+u31YeBB2os7g
         QpDszQavl1kmKJO4q3jOjcWQPyadZXM+TuZkMKn6RKn0gn0B5sfXTI5eMUl9Lz4J7zwR
         Xwhg==
X-Gm-Message-State: AO0yUKUS7QuSdBAulZvMLzH7o5kQrlzmglXfz4vfYRV2hv85n9da/jqI
        FID4eUk/BYBXk7/veL+1FC3ptQ==
X-Google-Smtp-Source: AK7set8PzT2qWIgKTOfPggUjC00P2pwJYwx3QVR25wRd+rFFsKXlbkH/ugDvhVjFizuu6pcEOnFeaQ==
X-Received: by 2002:aa7:c054:0:b0:4ae:f496:f32 with SMTP id k20-20020aa7c054000000b004aef4960f32mr10274813edo.26.1677079791760;
        Wed, 22 Feb 2023 07:29:51 -0800 (PST)
Received: from [192.168.0.109] ([82.77.80.204])
        by smtp.gmail.com with ESMTPSA id c23-20020a50f617000000b004acde0a1ae5sm3650529edn.89.2023.02.22.07.29.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Feb 2023 07:29:51 -0800 (PST)
Message-ID: <68ed0578-f4e9-250d-9742-cbb7815b1d61@linaro.org>
Date:   Wed, 22 Feb 2023 15:29:49 +0000
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
In-Reply-To: <5da85766-65c7-107f-e525-2ae75b04750a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi, Darrick,

On 2/17/23 08:10, Tudor Ambarus wrote:
> Hi, Darrick,
> 
> On 2/16/23 18:55, Darrick J. Wong wrote:
>> From: Darrick J. Wong <djwong@kernel.org>
>>
>> Apparently syzbot figured out that issuing this FSMAP call:
>>
>> struct fsmap_head cmd = {
>>     .fmh_count    = ...;
>>     .fmh_keys    = {
>>         { .fmr_device = /* ext4 dev */, .fmr_physical = 0, },
>>         { .fmr_device = /* ext4 dev */, .fmr_physical = 0, },
>>     },
>> ...
>> };
>> ret = ioctl(fd, FS_IOC_GETFSMAP, &cmd);
>>
>> Produces this crash if the underlying filesystem is a 1k-block ext4
>> filesystem:
>>
>> kernel BUG at fs/ext4/ext4.h:3331!
>> invalid opcode: 0000 [#1] PREEMPT SMP
>> CPU: 3 PID: 3227965 Comm: xfs_io Tainted: G        W  O       
>> 6.2.0-rc8-achx
>> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.15.0-1 
>> 04/01/2014
>> RIP: 0010:ext4_mb_load_buddy_gfp+0x47c/0x570 [ext4]
>> RSP: 0018:ffffc90007c03998 EFLAGS: 00010246
>> RAX: ffff888004978000 RBX: ffffc90007c03a20 RCX: ffff888041618000
>> RDX: 0000000000000000 RSI: 00000000000005a4 RDI: ffffffffa0c99b11
>> RBP: ffff888012330000 R08: ffffffffa0c2b7d0 R09: 0000000000000400
>> R10: ffffc90007c03950 R11: 0000000000000000 R12: 0000000000000001
>> R13: 00000000ffffffff R14: 0000000000000c40 R15: ffff88802678c398
>> FS:  00007fdf2020c880(0000) GS:ffff88807e100000(0000) 
>> knlGS:0000000000000000
>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: 00007ffd318a5fe8 CR3: 000000007f80f001 CR4: 00000000001706e0
>> Call Trace:
>>   <TASK>
>>   ext4_mballoc_query_range+0x4b/0x210 [ext4 
>> dfa189daddffe8fecd3cdfd00564e0f265a8ab80]
>>   ext4_getfsmap_datadev+0x713/0x890 [ext4 
>> dfa189daddffe8fecd3cdfd00564e0f265a8ab80]
>>   ext4_getfsmap+0x2b7/0x330 [ext4 
>> dfa189daddffe8fecd3cdfd00564e0f265a8ab80]
>>   ext4_ioc_getfsmap+0x153/0x2b0 [ext4 
>> dfa189daddffe8fecd3cdfd00564e0f265a8ab80]
>>   __ext4_ioctl+0x2a7/0x17e0 [ext4 
>> dfa189daddffe8fecd3cdfd00564e0f265a8ab80]
>>   __x64_sys_ioctl+0x82/0xa0
>>   do_syscall_64+0x2b/0x80
>>   entry_SYSCALL_64_after_hwframe+0x46/0xb0
>> RIP: 0033:0x7fdf20558aff
>> RSP: 002b:00007ffd318a9e30 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
>> RAX: ffffffffffffffda RBX: 00000000000200c0 RCX: 00007fdf20558aff
>> RDX: 00007fdf1feb2010 RSI: 00000000c0c0583b RDI: 0000000000000003
>> RBP: 00005625c0634be0 R08: 00005625c0634c40 R09: 0000000000000001
>> R10: 0000000000000000 R11: 0000000000000246 R12: 00007fdf1feb2010
>> R13: 00005625be70d994 R14: 0000000000000800 R15: 0000000000000000
>>
>> For GETFSMAP calls, the caller selects a physical block device by
>> writing its block number into fsmap_head.fmh_keys[01].fmr_device.
>> To query mappings for a subrange of the device, the starting byte of the
>> range is written to fsmap_head.fmh_keys[0].fmr_physical and the last
>> byte of the range goes in fsmap_head.fmh_keys[1].fmr_physical.
>>
>> IOWs, to query what mappings overlap with bytes 3-14 of /dev/sda, you'd
>> set the inputs as follows:
>>
>>     fmh_keys[0] = { .fmr_device = major(8, 0), .fmr_physical = 3},
>>     fmh_keys[1] = { .fmr_device = major(8, 0), .fmr_physical = 14},
>>
>> Which would return you whatever is mapped in the 12 bytes starting at
>> physical offset 3.
>>
>> The crash is due to insufficient range validation of keys[1] in
>> ext4_getfsmap_datadev.  On 1k-block filesystems, block 0 is not part of
>> the filesystem, which means that s_first_data_block is nonzero.
>> ext4_get_group_no_and_offset subtracts this quantity from the blocknr
>> argument before cracking it into a group number and a block number
>> within a group.  IOWs, block group 0 spans blocks 1-8192 (1-based)
>> instead of 0-8191 (0-based) like what happens with larger blocksizes.
>>
>> The net result of this encoding is that blocknr < s_first_data_block is
>> not a valid input to this function.  The end_fsb variable is set from
>> the keys that are copied from userspace, which means that in the above
>> example, its value is zero.  That leads to an underflow here:
>>
>>     blocknr = blocknr - le32_to_cpu(es->s_first_data_block);
>>
>> The division then operates on -1:
>>
>>     offset = do_div(blocknr, EXT4_BLOCKS_PER_GROUP(sb)) >>
>>         EXT4_SB(sb)->s_cluster_bits;
>>
>> Leaving an impossibly large group number (2^32-1) in blocknr.
>> ext4_getfsmap_check_keys checked that keys[0].fmr_physical and
>> keys[1].fmr_physical are in increasing order, but
>> ext4_getfsmap_datadev adjusts keys[0].fmr_physical to be at least
>> s_first_data_block.  This implies that we have to check it again after
>> the adjustment, which is the piece that I forgot.
>>
>> Fixes: 4a4956249dac ("ext4: fix off-by-one fsmap error on 1k block 
>> filesystems")
>> Link: 
>> https://syzkaller.appspot.com/bug?id=79d5768e9bfe362911ac1a5057a36fc6b5c30002
>> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
>> ---
>>   fs/ext4/fsmap.c |    2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/fs/ext4/fsmap.c b/fs/ext4/fsmap.c
>> index 4493ef0c715e..cdf9bfe10137 100644
>> --- a/fs/ext4/fsmap.c
>> +++ b/fs/ext4/fsmap.c
>> @@ -486,6 +486,8 @@ static int ext4_getfsmap_datadev(struct 
>> super_block *sb,
>>           keys[0].fmr_physical = bofs;
>>       if (keys[1].fmr_physical >= eofs)
>>           keys[1].fmr_physical = eofs - 1;
>> +    if (keys[1].fmr_physical < keys[0].fmr_physical)
>> +        return 0;
> 
> This is an indirect implication, we can be more straightforward. Also we
> should stop the execution when high_key->fmr_physical == bofs. So maybe:
> 
> --- a/fs/ext4/fsmap.c
> +++ b/fs/ext4/fsmap.c
> @@ -479,6 +479,8 @@ static int ext4_getfsmap_datadev(struct super_block 
> *sb,
>          int error = 0;
> 
>          bofs = le32_to_cpu(sbi->s_es->s_first_data_block);
> +       if (keys[1].fmr_physical <= bofs)
> +               return 0;
>          eofs = ext4_blocks_count(sbi->s_es);
>          if (keys[0].fmr_physical >= eofs)
>                  return 0;

Just wanted to let you know that I sent this patch together with two 
others at:
https://lore.kernel.org/linux-ext4/20230222131211.3898066-1-tudor.ambarus@linaro.org/T/

Cheers,
ta
