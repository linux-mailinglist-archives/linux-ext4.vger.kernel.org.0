Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D1F665CDEF
	for <lists+linux-ext4@lfdr.de>; Wed,  4 Jan 2023 08:57:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233219AbjADH5l (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 4 Jan 2023 02:57:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232996AbjADH5k (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 4 Jan 2023 02:57:40 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5465018E1E;
        Tue,  3 Jan 2023 23:57:39 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id vm8so73754117ejc.2;
        Tue, 03 Jan 2023 23:57:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zK7L2opGAXsz5a3T3UPT+AWVB2Yji8VtgAt9kjezEcA=;
        b=JNdPN45P5gdJSN1xYZgoRe6vIFMaQi8zuDj/KMl8rVAptEoVMXLfJeESPEavaJNz0y
         S8DxZNcMkeG21EWNmQlTnoHr+bZ+yPMphR4NncBYPMzg8xyswIH6zUQWAZ+lI3LzvnGn
         BoATOMTozjdQGYUcBV1mUM4rRfckTFNCn7SAWKH6UC+1IejX/HnpslNw4MOMz3rdIT8t
         W11AYUehPwVhY6vj3CgRTF73TsIuQTBzlt5nVRVpcPDF9LV9GXdLKrvkzME2j52ow9tt
         tiNQfd8YzUJ2n8rNITg3+eFuxc+WyTug28Hj9sjey9vYQKdArlCerpiaWr/w3sKWQKsr
         MlrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zK7L2opGAXsz5a3T3UPT+AWVB2Yji8VtgAt9kjezEcA=;
        b=RB2UQ4NprqKVgK+DAubS46vSWET5kDiWt6RGpwrdc+BFg7f/GmjETX+Uq8EBXPu6eT
         SWkqK5smh8h+QscXnU2NHV6UQGHEvyR322xK53uYhOglkPWKdV/y4StSvDignWkRY+Tp
         dy6vValLItb8fSJLoOWtllx8xfinnpNwZ/yFeKdOKCeoAVy1dIe88DI1air41ab+5lm9
         0vIban4nkNh3XHjRIDwCbmIFckvFA+y9nYLJSVz8tYfeuEUPFm9gM9g/oZbPoR0d+cUw
         2Nu5zp92ttdoX7GReQgNW19RjD96JlKsL9EcTv3gkYEhIY+HlCB2L3DIn66i6/UcRlsQ
         kRRw==
X-Gm-Message-State: AFqh2kqJNPmksnazyWwDCwOakvX0GQVgtc0M/NL5+//lub2KbpPFhIPa
        2TQ3Wv2slyv9iqtsCbzhSKU=
X-Google-Smtp-Source: AMrXdXtzooCT/+isKKqCb8e/TFJO9BGFDt8HojNJS1UuKmYrXV/YH1OjYcr4s2BJjG9pt/GGOJJwfA==
X-Received: by 2002:a17:906:9c96:b0:7c1:1c5:c7cd with SMTP id fj22-20020a1709069c9600b007c101c5c7cdmr42547430ejc.5.1672819057530;
        Tue, 03 Jan 2023 23:57:37 -0800 (PST)
Received: from [192.168.0.104] ([82.77.81.242])
        by smtp.gmail.com with ESMTPSA id 1-20020a170906318100b0084ce5d5d21bsm1410747ejy.22.2023.01.03.23.57.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jan 2023 23:57:36 -0800 (PST)
Message-ID: <9ef2d089-5c92-2d79-9880-9fb6a305d8a7@gmail.com>
Date:   Wed, 4 Jan 2023 09:57:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] ext4: fix use-after-free Read in ext4_find_extent for
 bigalloc + inline
Content-Language: en-US
To:     Ye Bin <yebin@huaweicloud.com>, tytso@mit.edu,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, jack@suse.cz,
        Ye Bin <yebin10@huawei.com>,
        syzbot+bf4bb7731ef73b83a3b4@syzkaller.appspotmail.com
References: <20230104071559.2051847-1-yebin@huaweicloud.com>
From:   Tudor Ambarus <tudor.ambarus@gmail.com>
In-Reply-To: <20230104071559.2051847-1-yebin@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On 04.01.2023 09:15, Ye Bin wrote:
> From: Ye Bin <yebin10@huawei.com>
> 
> Syzbot found the following issue:
> loop0: detected capacity change from 0 to 2048
> EXT4-fs (loop0): mounted filesystem 00000000-0000-0000-0000-000000000000 without journal. Quota mode: none.
> ==================================================================
> BUG: KASAN: use-after-free in ext4_ext_binsearch_idx fs/ext4/extents.c:768 [inline]
> BUG: KASAN: use-after-free in ext4_find_extent+0x76e/0xd90 fs/ext4/extents.c:931
> Read of size 4 at addr ffff888073644750 by task syz-executor420/5067
> 
> CPU: 0 PID: 5067 Comm: syz-executor420 Not tainted 6.2.0-rc1-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
> Call Trace:
>   <TASK>
>   __dump_stack lib/dump_stack.c:88 [inline]
>   dump_stack_lvl+0x1b1/0x290 lib/dump_stack.c:106
>   print_address_description+0x74/0x340 mm/kasan/report.c:306
>   print_report+0x107/0x1f0 mm/kasan/report.c:417
>   kasan_report+0xcd/0x100 mm/kasan/report.c:517
>   ext4_ext_binsearch_idx fs/ext4/extents.c:768 [inline]
>   ext4_find_extent+0x76e/0xd90 fs/ext4/extents.c:931
>   ext4_clu_mapped+0x117/0x970 fs/ext4/extents.c:5809
>   ext4_insert_delayed_block fs/ext4/inode.c:1696 [inline]
>   ext4_da_map_blocks fs/ext4/inode.c:1806 [inline]
>   ext4_da_get_block_prep+0x9e8/0x13c0 fs/ext4/inode.c:1870
>   ext4_block_write_begin+0x6a8/0x2290 fs/ext4/inode.c:1098
>   ext4_da_write_begin+0x539/0x760 fs/ext4/inode.c:3082
>   generic_perform_write+0x2e4/0x5e0 mm/filemap.c:3772
>   ext4_buffered_write_iter+0x122/0x3a0 fs/ext4/file.c:285
>   ext4_file_write_iter+0x1d0/0x18f0
>   call_write_iter include/linux/fs.h:2186 [inline]
>   new_sync_write fs/read_write.c:491 [inline]
>   vfs_write+0x7dc/0xc50 fs/read_write.c:584
>   ksys_write+0x177/0x2a0 fs/read_write.c:637
>   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>   do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
>   entry_SYSCALL_64_after_hwframe+0x63/0xcd
> RIP: 0033:0x7f4b7a9737b9
> RSP: 002b:00007ffc5cac3668 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f4b7a9737b9
> RDX: 00000000175d9003 RSI: 0000000020000200 RDI: 0000000000000004
> RBP: 00007f4b7a933050 R08: 0000000000000000 R09: 0000000000000000
> R10: 000000000000079f R11: 0000000000000246 R12: 00007f4b7a9330e0
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
>   </TASK>
> 
> Above issue is happens when enable bigalloc and inline data feature. As
> commit 131294c35ed6 fixed delayed allocation bug in ext4_clu_mapped for
> bigalloc + inline. But it only resolved issue when has inline data, if
> inline data has been converted to extent(ext4_da_convert_inline_data_to_extent)
> before writepages, there is no EXT4_STATE_MAY_INLINE_DATA flag. However
> i_data is still store inline data in this scene. Then will trigger UAF
> when find extent.
> To resolve above issue, there is need to add judge "ext4_has_inline_data(inode)"
> in ext4_clu_mapped().
> 
> Reported-by: syzbot+bf4bb7731ef73b83a3b4@syzkaller.appspotmail.com
> Fixes: 131294c35ed6 ("ext4: fix delayed allocation bug in ext4_clu_mapped for bigalloc + inline")
> Signed-off-by: Ye Bin <yebin10@huawei.com>


This also fixes the problem that I tried to address with the superficial
patch at
https://lore.kernel.org/linux-ext4/Y69IaMqZvnGk5skX@mit.edu/T/#t

Tested-by: Tudor Ambarus <tudor.ambarus@linaro.org>

> ---
>   fs/ext4/extents.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index 9de1c9d1a13d..ee5acf2bd5e6 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -5802,7 +5802,8 @@ int ext4_clu_mapped(struct inode *inode, ext4_lblk_t lclu)
>   	 * mapped - no physical clusters have been allocated, and the
>   	 * file has no extents
>   	 */
> -	if (ext4_test_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA))
> +	if (ext4_test_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA) ||
> +	    ext4_has_inline_data(inode))
>   		return 0;
>   
>   	/* search for the extent closest to the first block in the cluster */
