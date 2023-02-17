Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A8F869A6A7
	for <lists+linux-ext4@lfdr.de>; Fri, 17 Feb 2023 09:10:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbjBQIKl (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 17 Feb 2023 03:10:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbjBQIKW (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 17 Feb 2023 03:10:22 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D53535ECB8
        for <linux-ext4@vger.kernel.org>; Fri, 17 Feb 2023 00:10:20 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id cn2so1269765edb.4
        for <linux-ext4@vger.kernel.org>; Fri, 17 Feb 2023 00:10:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xxB9l0IpZhi7cAgtzJWSXjaqUj05fykqIkxGTKlbv34=;
        b=Y1UvigxowlYkHSsk7kzy5O98oQuYqBSxa2LHnbXBIaoJpEvLDeOVvnhFUazo0QmX38
         kewKFnwEhHBkkyqwXA+Ce6MzVzpWsKEg3c1bS/0P5GGd08OyhdWv82ovPECY6wOCklOe
         X7m6NteWhdA7Q5psr9apNDBG2iOcTl4q3eOhHkFBpA39yd2vOXQTSUM/wjuFgLLu92kr
         /f0hhyf8w/nD09DeQg2L52zwWkgMUDlblj3M4XlPqLv4sWcRC8jcoph+fLpuL3BNqay3
         932bvcFm2h22WOqQlLzm+hD8r7QhHkTatPs6wSNfPE87CTzpEAWmoohCbf+ZH9VifxwR
         xKQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xxB9l0IpZhi7cAgtzJWSXjaqUj05fykqIkxGTKlbv34=;
        b=yu2J3CZgWTCjabOmdNkt5gprlnXwIs8kVuwNzijOdx0kXJH0GEbclAnS/JbOvp8o2l
         AYv8Bnijy2XDe0S8oz2Pise+/Uq+F1dko7L/yrn33u+K1GN6flZLsBYW4LhohBqi/xmn
         ckfwoMy8C92grIMr7bK0hGbvEnQU+zII5BdZq3tOiaQ/QAYhqduXjiPl0M5YA1zvb3Sm
         ycGriyj9AITDHwQpIeQSTCRnYlDKXnkHjzYrVeGsg2XLq4VfRPwXh6cTY4ceI3BMl/TN
         EvU4dwUsr4PZLZEmAt1KTBXXIG9OjIVvWhOutu86GVdFYKaMmNx213mEQBmJoZjgzkk2
         fYGQ==
X-Gm-Message-State: AO0yUKVkkC6yGUINA0eAwtx9X/xCRx73uq1ui4r8JpLwd7t7BJbuY7Z5
        CEXl1KDQkz/cejzCkIM+S2JrOO3800JTyP3s
X-Google-Smtp-Source: AK7set95jjOVgax441XIVRkvVbX9Wk03L/7QVKgrQYoPw3FjigyZpuBGj2n59dEhslnWlApUkM/sOA==
X-Received: by 2002:a17:906:3e47:b0:87b:7c1d:e02b with SMTP id t7-20020a1709063e4700b0087b7c1de02bmr8277134eji.36.1676621419139;
        Fri, 17 Feb 2023 00:10:19 -0800 (PST)
Received: from [192.168.0.108] ([82.77.80.113])
        by smtp.gmail.com with ESMTPSA id h26-20020a17090634da00b008b158cbac66sm1798278ejb.210.2023.02.17.00.10.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Feb 2023 00:10:18 -0800 (PST)
Message-ID: <5da85766-65c7-107f-e525-2ae75b04750a@linaro.org>
Date:   Fri, 17 Feb 2023 08:10:17 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] ext4: fix another off-by-one fsmap error on 1k block
 filesystems
Content-Language: en-US
To:     "Darrick J. Wong" <djwong@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>
Cc:     Jun Nie <jun.nie@linaro.org>, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lee Jones <joneslee@google.com>
References: <Y+58NPTH7VNGgzdd@magnolia>
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <Y+58NPTH7VNGgzdd@magnolia>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi, Darrick,

On 2/16/23 18:55, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Apparently syzbot figured out that issuing this FSMAP call:
> 
> struct fsmap_head cmd = {
> 	.fmh_count	= ...;
> 	.fmh_keys	= {
> 		{ .fmr_device = /* ext4 dev */, .fmr_physical = 0, },
> 		{ .fmr_device = /* ext4 dev */, .fmr_physical = 0, },
> 	},
> ...
> };
> ret = ioctl(fd, FS_IOC_GETFSMAP, &cmd);
> 
> Produces this crash if the underlying filesystem is a 1k-block ext4
> filesystem:
> 
> kernel BUG at fs/ext4/ext4.h:3331!
> invalid opcode: 0000 [#1] PREEMPT SMP
> CPU: 3 PID: 3227965 Comm: xfs_io Tainted: G        W  O       6.2.0-rc8-achx
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.15.0-1 04/01/2014
> RIP: 0010:ext4_mb_load_buddy_gfp+0x47c/0x570 [ext4]
> RSP: 0018:ffffc90007c03998 EFLAGS: 00010246
> RAX: ffff888004978000 RBX: ffffc90007c03a20 RCX: ffff888041618000
> RDX: 0000000000000000 RSI: 00000000000005a4 RDI: ffffffffa0c99b11
> RBP: ffff888012330000 R08: ffffffffa0c2b7d0 R09: 0000000000000400
> R10: ffffc90007c03950 R11: 0000000000000000 R12: 0000000000000001
> R13: 00000000ffffffff R14: 0000000000000c40 R15: ffff88802678c398
> FS:  00007fdf2020c880(0000) GS:ffff88807e100000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007ffd318a5fe8 CR3: 000000007f80f001 CR4: 00000000001706e0
> Call Trace:
>   <TASK>
>   ext4_mballoc_query_range+0x4b/0x210 [ext4 dfa189daddffe8fecd3cdfd00564e0f265a8ab80]
>   ext4_getfsmap_datadev+0x713/0x890 [ext4 dfa189daddffe8fecd3cdfd00564e0f265a8ab80]
>   ext4_getfsmap+0x2b7/0x330 [ext4 dfa189daddffe8fecd3cdfd00564e0f265a8ab80]
>   ext4_ioc_getfsmap+0x153/0x2b0 [ext4 dfa189daddffe8fecd3cdfd00564e0f265a8ab80]
>   __ext4_ioctl+0x2a7/0x17e0 [ext4 dfa189daddffe8fecd3cdfd00564e0f265a8ab80]
>   __x64_sys_ioctl+0x82/0xa0
>   do_syscall_64+0x2b/0x80
>   entry_SYSCALL_64_after_hwframe+0x46/0xb0
> RIP: 0033:0x7fdf20558aff
> RSP: 002b:00007ffd318a9e30 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 00000000000200c0 RCX: 00007fdf20558aff
> RDX: 00007fdf1feb2010 RSI: 00000000c0c0583b RDI: 0000000000000003
> RBP: 00005625c0634be0 R08: 00005625c0634c40 R09: 0000000000000001
> R10: 0000000000000000 R11: 0000000000000246 R12: 00007fdf1feb2010
> R13: 00005625be70d994 R14: 0000000000000800 R15: 0000000000000000
> 
> For GETFSMAP calls, the caller selects a physical block device by
> writing its block number into fsmap_head.fmh_keys[01].fmr_device.
> To query mappings for a subrange of the device, the starting byte of the
> range is written to fsmap_head.fmh_keys[0].fmr_physical and the last
> byte of the range goes in fsmap_head.fmh_keys[1].fmr_physical.
> 
> IOWs, to query what mappings overlap with bytes 3-14 of /dev/sda, you'd
> set the inputs as follows:
> 
> 	fmh_keys[0] = { .fmr_device = major(8, 0), .fmr_physical = 3},
> 	fmh_keys[1] = { .fmr_device = major(8, 0), .fmr_physical = 14},
> 
> Which would return you whatever is mapped in the 12 bytes starting at
> physical offset 3.
> 
> The crash is due to insufficient range validation of keys[1] in
> ext4_getfsmap_datadev.  On 1k-block filesystems, block 0 is not part of
> the filesystem, which means that s_first_data_block is nonzero.
> ext4_get_group_no_and_offset subtracts this quantity from the blocknr
> argument before cracking it into a group number and a block number
> within a group.  IOWs, block group 0 spans blocks 1-8192 (1-based)
> instead of 0-8191 (0-based) like what happens with larger blocksizes.
> 
> The net result of this encoding is that blocknr < s_first_data_block is
> not a valid input to this function.  The end_fsb variable is set from
> the keys that are copied from userspace, which means that in the above
> example, its value is zero.  That leads to an underflow here:
> 
> 	blocknr = blocknr - le32_to_cpu(es->s_first_data_block);
> 
> The division then operates on -1:
> 
> 	offset = do_div(blocknr, EXT4_BLOCKS_PER_GROUP(sb)) >>
> 		EXT4_SB(sb)->s_cluster_bits;
> 
> Leaving an impossibly large group number (2^32-1) in blocknr.
> ext4_getfsmap_check_keys checked that keys[0].fmr_physical and
> keys[1].fmr_physical are in increasing order, but
> ext4_getfsmap_datadev adjusts keys[0].fmr_physical to be at least
> s_first_data_block.  This implies that we have to check it again after
> the adjustment, which is the piece that I forgot.
> 
> Fixes: 4a4956249dac ("ext4: fix off-by-one fsmap error on 1k block filesystems")
> Link: https://syzkaller.appspot.com/bug?id=79d5768e9bfe362911ac1a5057a36fc6b5c30002
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> ---
>   fs/ext4/fsmap.c |    2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/fs/ext4/fsmap.c b/fs/ext4/fsmap.c
> index 4493ef0c715e..cdf9bfe10137 100644
> --- a/fs/ext4/fsmap.c
> +++ b/fs/ext4/fsmap.c
> @@ -486,6 +486,8 @@ static int ext4_getfsmap_datadev(struct super_block *sb,
>   		keys[0].fmr_physical = bofs;
>   	if (keys[1].fmr_physical >= eofs)
>   		keys[1].fmr_physical = eofs - 1;
> +	if (keys[1].fmr_physical < keys[0].fmr_physical)
> +		return 0;

This is an indirect implication, we can be more straightforward. Also we
should stop the execution when high_key->fmr_physical == bofs. So maybe:

--- a/fs/ext4/fsmap.c
+++ b/fs/ext4/fsmap.c
@@ -479,6 +479,8 @@ static int ext4_getfsmap_datadev(struct super_block *sb,
         int error = 0;

         bofs = le32_to_cpu(sbi->s_es->s_first_data_block);
+       if (keys[1].fmr_physical <= bofs)
+               return 0;
         eofs = ext4_blocks_count(sbi->s_es);
         if (keys[0].fmr_physical >= eofs)
                 return 0;


But I'm not thrilled about this. Can we stop the execution earlier?
How about something like:

diff --git a/fs/ext4/fsmap.c b/fs/ext4/fsmap.c
index 4493ef0c715e..8c4b1fb5c10a 100644
--- a/fs/ext4/fsmap.c
+++ b/fs/ext4/fsmap.c
@@ -586,10 +586,12 @@ static bool ext4_getfsmap_check_keys(struct 
ext4_fsmap *low_key,
  {
         if (low_key->fmr_device > high_key->fmr_device)
                 return false;
-       if (low_key->fmr_device < high_key->fmr_device)
+       if (low_key->fmr_device != 0 &&
+           low_key->fmr_device < high_key->fmr_device)
                 return true;

-       if (low_key->fmr_physical > high_key->fmr_physical)
+       if (high_key->fmr_physical == 0 ||
+           low_key->fmr_physical > high_key->fmr_physical)
                 return false;
         if (low_key->fmr_physical < high_key->fmr_physical)
                 return true;

You'll notice that my proposal will stop the execution with -EINVAL, as
the key range is invalid IMO. But we can adapt code to return zero if
you like, what I'm interested in is whether this key check is valid for
ext4_getfsmap_logdev() or not. How about the
if (keys[1].fmr_physical == bofs) check, is it valid for
ext4_getfsmap_logdev()?

I'd like that with your guidance to fix this bug, extend the xfs_io
fsmap support to query ext4 fs range and to add an xfstest for keys
validation, to check if stable kernels will be fixed. This would help me
with the fs ramp-up, as I'd like to fix some other fs bugs too. If you
want to handle this by yourself, it's fine too, but please let me know
so that we don't duplicate effort.

Cheers,
ta
