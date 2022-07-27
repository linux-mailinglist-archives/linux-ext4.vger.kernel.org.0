Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 997DF5831C9
	for <lists+linux-ext4@lfdr.de>; Wed, 27 Jul 2022 20:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235759AbiG0SQ7 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 27 Jul 2022 14:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233686AbiG0SQj (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 27 Jul 2022 14:16:39 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0DC2E1C89
        for <linux-ext4@vger.kernel.org>; Wed, 27 Jul 2022 10:17:08 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id b10so16951651pjq.5
        for <linux-ext4@vger.kernel.org>; Wed, 27 Jul 2022 10:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:content-language:to:cc
         :references:from:subject:in-reply-to:content-transfer-encoding;
        bh=5mRe+/UrqoSJ1C3f37eazs7VLH5LNilY/86t42B0jwg=;
        b=EVMdmchKHUYvLwHAzXzMt4aNmDGHqzxJwQPH557hYnfTSUEbHIa1l0x6I5iFpcclSI
         OkW6d5tfOc5DUWgFr5LvT6ImX00KN6wMtTxveZ4kuKVgNharCGApWDWDa0/FpzkG7i+u
         erba9aRqkEhUDYXcBD9wllf8MXa4c+Ig+Cgp4vGO20kuFWRG4YxXo9UC4RfnLH2Hfj9P
         yZXj1eglDyqRRh0Ebp6TWjieV78Lk77qUZVjDC3cXJgniEk45veW9bi8r4dj7j5Y2u5U
         fosURs4YXl3kpspKYwhIzw79LNDIFNBq8+uVUziLWfqgCaHsKbrf0K/gwO3DIrnXvNFE
         VhCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=5mRe+/UrqoSJ1C3f37eazs7VLH5LNilY/86t42B0jwg=;
        b=5U+99mrxGCU/XHO6656V3DM9bDBOd6GvLB9Cnvrc4hzL+HrDvWv/Xku5QFgBJMKBAM
         RjEA0sU+/BQnSsQy1xhI4DO0DTqA3+c+O0/Y7nBOxFbi5/yBCM0eIM4aUYbqt7q6LC0r
         juKoWax5ojT0H+C2bdFWJkY5/OhWzRP3RYel2cRYY78ZOnTJgXbSW5T64578Swk73q3b
         NaR0DKTdDTX4nnW6ohy+gaOXXqgzMUCxNrIYwqMej9dxb/btqiEF+55DH/u978+KQyOx
         iCgcqLRTS2BEjYeaYLWNzCSW0cB3SBBWY55qMGfurdL5AnY/uGqSIpOJiE6LI9E+dEnV
         Td8g==
X-Gm-Message-State: AJIora/dcFxC+H+KfC9zC04b3fjyKEmTK2WzgK6urtRqY3ki5tmbR5hc
        GjyagVbT48fG4Mx6ygmsEWGFGA==
X-Google-Smtp-Source: AGRyM1vFnmV3PICo1XP2M+/0rPUgzbNXm7tFsEvSv6HTL5mxsNM/3x/5dAugk1qMIP8EitCnhK3ing==
X-Received: by 2002:a17:90b:4c8d:b0:1f2:c360:5e6b with SMTP id my13-20020a17090b4c8d00b001f2c3605e6bmr5756311pjb.195.1658942227716;
        Wed, 27 Jul 2022 10:17:07 -0700 (PDT)
Received: from ?IPV6:2601:1c0:4c00:ad20:feaa:14ff:fe3a:b225? ([2601:1c0:4c00:ad20:feaa:14ff:fe3a:b225])
        by smtp.gmail.com with ESMTPSA id i14-20020a17090332ce00b0016a33177d3csm14248105plr.160.2022.07.27.10.17.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Jul 2022 10:17:07 -0700 (PDT)
Message-ID: <f9de5566-1c66-2987-8b27-ab737d564b77@linaro.org>
Date:   Wed, 27 Jul 2022 10:17:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     Jan Kara <jack@suse.cz>, Ted Tso <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org,
        syzbot+bd13648a53ed6933ca49@syzkaller.appspotmail.com
References: <20220727155753.13969-1-jack@suse.cz>
From:   Tadeusz Struk <tadeusz.struk@linaro.org>
Subject: Re: [PATCH] ext4: Avoid crash when inline data creation follows DIO
 write
In-Reply-To: <20220727155753.13969-1-jack@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 7/27/22 08:57, Jan Kara wrote:
> When inode is created and written to using direct IO, there is nothing
> to clear the EXT4_STATE_MAY_INLINE_DATA flag. Thus when inode gets
> truncated later to say 1 byte and written using normal write, we will
> try to store the data as inline data. This confuses the code later
> because the inode now has both normal block and inline data allocated
> and the confusion manifests for example as:
> 
> kernel BUG at fs/ext4/inode.c:2721!
> invalid opcode: 0000 [#1] PREEMPT SMP KASAN
> CPU: 0 PID: 359 Comm: repro Not tainted 5.19.0-rc8-00001-g31ba1e3b8305-dirty #15
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-1.fc36 04/01/2014
> RIP: 0010:ext4_writepages+0x363d/0x3660
> RSP: 0018:ffffc90000ccf260 EFLAGS: 00010293
> RAX: ffffffff81e1abcd RBX: 0000008000000000 RCX: ffff88810842a180
> RDX: 0000000000000000 RSI: 0000008000000000 RDI: 0000000000000000
> RBP: ffffc90000ccf650 R08: ffffffff81e17d58 R09: ffffed10222c680b
> R10: dfffe910222c680c R11: 1ffff110222c680a R12: ffff888111634128
> R13: ffffc90000ccf880 R14: 0000008410000000 R15: 0000000000000001
> FS:  00007f72635d2640(0000) GS:ffff88811b000000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000565243379180 CR3: 000000010aa74000 CR4: 0000000000150eb0
> Call Trace:
>   <TASK>
>   do_writepages+0x397/0x640
>   filemap_fdatawrite_wbc+0x151/0x1b0
>   file_write_and_wait_range+0x1c9/0x2b0
>   ext4_sync_file+0x19e/0xa00
>   vfs_fsync_range+0x17b/0x190
>   ext4_buffered_write_iter+0x488/0x530
>   ext4_file_write_iter+0x449/0x1b90
>   vfs_write+0xbcd/0xf40
>   ksys_write+0x198/0x2c0
>   __x64_sys_write+0x7b/0x90
>   do_syscall_64+0x3d/0x90
>   entry_SYSCALL_64_after_hwframe+0x63/0xcd
>   </TASK>
> 
> Fix the problem by clearing EXT4_STATE_MAY_INLINE_DATA when we are doing
> direct IO write to a file.
> 
> Reported-by: Tadeusz Struk<tadeusz.struk@linaro.org>
> Reported-by:syzbot+bd13648a53ed6933ca49@syzkaller.appspotmail.com
> Link:https://syzkaller.appspot.com/bug?id=a1e89d09bbbcbd5c4cb45db230ee28c822953984
> Signed-off-by: Jan Kara<jack@suse.cz>

That works fine for me. Thanks Honza.

Tested-by: Tadeusz Struk<tadeusz.struk@linaro.org>

It should also be applied to stable v5.15 and v5.10.
I will send a request once this lands in mainline.
-- 
Thanks,
Tadeusz
