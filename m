Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52D4E3F86A1
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Aug 2021 13:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242246AbhHZLn2 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 26 Aug 2021 07:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236957AbhHZLn2 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 26 Aug 2021 07:43:28 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D434C061757;
        Thu, 26 Aug 2021 04:42:41 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id 18so2515865pfh.9;
        Thu, 26 Aug 2021 04:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VGpf2KcdeJnsNgpEgrUODrQceX1nXKO1eVOyUVEhESQ=;
        b=A2H/fZSSB02fijH3p1oEwtbOzMOpcqZgSKJOifuk6qHnR6zgB8SZ+i1a86KTIyjn6A
         L39CUV3SshEtXz8fnbD8zuHPMeS1yztXkyFa8INPtrYQKCrju777ZnxGWUiOTGtJBgK3
         xzwC4aO4Su9WgjUIpjgkCi78Y540zgTARstCzukgpmSYb0DhFD2OHd5LdvalZazwoFsW
         dVxUI0RePZeMFNmtepNopBv0BzIch17giQJWY9U2VtQFo9F/dO4d9F13c457UosvJR5g
         r6nlQAj6UQf6duXGle6j0Dz1TcLQwSijOGycbw6OpeirXhUhG/u9l8WPEkX+zPrttAYv
         NOdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VGpf2KcdeJnsNgpEgrUODrQceX1nXKO1eVOyUVEhESQ=;
        b=jBrnvP34bX3anKLRI68g2I5y6SpJgRVTigY2bgCp9y65RnivfJTjpZs7FcbKFXDewn
         M8uoazfmJkVsO8pKBd3Mh9JPOyP+G5pcgXyhaAZs7r5ZHPGSiwVf2a7fkSIHIzUF0AME
         Om00IFWAv1OoEzdlT5Q+JuILKG9vbxJsFIjj4B5saZ9cI/fcgdd/vcTAxGb0Ao0R9kcu
         AmZBFnLQIPn7dGCQ8S4fIC8xugqJfzJgP2GMJhuhm1t8YOvGtXDBgd9xQbl5jRnR654m
         8+7tTVeFzVrvwrjLCSxNCUMR2c1k+aVcI2VvvMVF+M1MB/dAKRJYwUy4PA7d/kp8HJut
         mrqQ==
X-Gm-Message-State: AOAM533qLgq8V/fp9aW14WuVn1RFGsIVfxI6WUYF7qp+AYwu7izq1X6K
        QBGMpva5XIWcugMsW+t1MK8=
X-Google-Smtp-Source: ABdhPJwcr7WV9uJlsWpHW5Y6OGNnziwx7RS+hZx5BtiVV2NxXvSYE97LesLzR87TgxvPtwqL4m4aDg==
X-Received: by 2002:a63:d64f:: with SMTP id d15mr3013065pgj.9.1629978160683;
        Thu, 26 Aug 2021 04:42:40 -0700 (PDT)
Received: from jianchwadeMacBook-Pro.local ([162.219.34.243])
        by smtp.gmail.com with ESMTPSA id s15sm5847838pjk.21.2021.08.26.04.42.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Aug 2021 04:42:40 -0700 (PDT)
Subject: Re: [PATCH V3 5/5] ext4: make fallocate retry when err is ENOSPC
To:     Jan Kara <jack@suse.cz>
Cc:     Guoqing Jiang <guoqing.jiang@linux.dev>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        tytso@mit.edu, adilger.kernel@dilger.ca
References: <20210724074124.25731-1-jianchao.wan9@gmail.com>
 <20210724074124.25731-6-jianchao.wan9@gmail.com>
 <0ac551b1-6295-9117-757d-12bee70de588@linux.dev>
 <2888807f-2822-a73d-4c01-f073f8fffae2@gmail.com>
 <20210804155214.GN4578@quack2.suse.cz>
From:   Wang Jianchao <jianchao.wan9@gmail.com>
Message-ID: <209ef33f-36b9-fa74-aa6f-306cf7133971@gmail.com>
Date:   Thu, 26 Aug 2021 19:42:35 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210804155214.GN4578@quack2.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On 2021/8/4 11:52 PM, Jan Kara wrote:
> On Mon 26-07-21 15:05:41, Wang Jianchao wrote:
>>
>>
>> On 2021/7/26 11:40 AM, Guoqing Jiang wrote:
>>> Hi,
>>>
>>> On 7/24/21 3:41 PM, Wang Jianchao wrote:
>>>> From: Wang Jianchao <wangjianchao@kuaishou.com>
>>>>
>>>> The blocks may be waiting for journal commit to be freed back to
>>>> mb buddy. Let fallocate wait and retry in that case.
>>>>
>>>> Signed-off-by: Wang Jianchao <wangjianchao@kuaishou.com>
>>>> ---
>>>>   fs/ext4/extents.c | 6 +++++-
>>>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
>>>> index 92ad64b89d9b..ad0b874d3448 100644
>>>> --- a/fs/ext4/extents.c
>>>> +++ b/fs/ext4/extents.c
>>>> @@ -4635,7 +4635,7 @@ long ext4_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
>>>>       struct inode *inode = file_inode(file);
>>>>       loff_t new_size = 0;
>>>>       unsigned int max_blocks;
>>>> -    int ret = 0;
>>>> +    int ret = 0, retries = 0;
>>>>       int flags;
>>>>       ext4_lblk_t lblk;
>>>>       unsigned int blkbits = inode->i_blkbits;
>>>> @@ -4656,6 +4656,7 @@ long ext4_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
>>>>                FALLOC_FL_INSERT_RANGE))
>>>>           return -EOPNOTSUPP;
>>>>   +retry:
>>>>       ext4_fc_start_update(inode);
>>>>         if (mode & FALLOC_FL_PUNCH_HOLE) {
>>>> @@ -4722,6 +4723,9 @@ long ext4_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
>>>>       trace_ext4_fallocate_exit(inode, offset, max_blocks, ret);
>>>>   exit:
>>>>       ext4_fc_stop_update(inode);
>>>> +    if (ret == -ENOSPC && ext4_should_retry_alloc(inode->i_sb, &retries))
>>>> +        goto retry;
>>>> +
>>>
>>> Not sure if it is necessary since ext4_alloc_file_blocks already retries allocate.
>>
>> Yes, this patch should be get rid of.  But it is indeed helpful to fix
>> the xfstest generic/371 which does concurrently write/rm and
>> fallocate/rm. I'll figure out some other way to improve that
> 
> Note that the retry logic is only a heuristic. It is not guaranteed any
> number of retries is enough, we just do three to not give up too easily...
> Your patch effectively raised number of retries to 9 so that may have
> masked the issue. But I don't think so high number of retries is a sensible
> choice because that way it may take too long to return ENOSPC.

The failure seems due to the background discard which marks the blocks used
before issue discard. 

The test make a 256M filesystem which has 59316 4K blocks.
There are two thread running concurrently,
 - write, rm 80M file
 - fallocate, rm 80M file

When the fallocate failed, I can observe there was a 80M on-going background trim

We seems to need to add a flush_work(sbi->s_discard_work) into ext4_should_retry_alloc()

Thanks so much
Jianchao
> 
> 								Honza
> 
