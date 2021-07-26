Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6669F3D538E
	for <lists+linux-ext4@lfdr.de>; Mon, 26 Jul 2021 09:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232012AbhGZGZT (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 26 Jul 2021 02:25:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231895AbhGZGZS (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 26 Jul 2021 02:25:18 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11CAEC061757;
        Mon, 26 Jul 2021 00:05:48 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id k4-20020a17090a5144b02901731c776526so18356328pjm.4;
        Mon, 26 Jul 2021 00:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FfJvyftSw8I9bvycaoSgqvRdK17Vot8rl+gl1vH68gE=;
        b=jpJwmFQCd566vpEbfTNRHFbGKs60vnCoZ/F8VJ0GMl9ZZ8M96F891vYNww0FkPTVUh
         yDwTFGtUR6Ejp0feGCmbxwrQVcePLG+AuRE/pYHmVQ7NcHvk589WHrQNmR4UOOiNoYrZ
         k+ySbVpkK/rrvit/0GfpYlQKcs+D/9r47C9NmdV6cNetxr1P1SE2zcJXcEaGC8mZmxsu
         5vCNPGSh1NeqXEBpPgtPHvd5a+1AsGiFkd9e2eie4ffk/v1WUe+YyCEgSJnb6/OLWFAZ
         4TRhtXadX8h53ae5wS9ZLBpTY3gPq0rtiv+xuz3AKkwSl5Kwq6xppd3GZD7HZSq4kMrV
         YbiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FfJvyftSw8I9bvycaoSgqvRdK17Vot8rl+gl1vH68gE=;
        b=X/fIydds64abhykZ7Xj0GOYuXC2U0GIimubsrDsGnBCaFQFnw8Vro+CB3zhr+QRxkL
         SyAGPQ3EmujaHaJCma6vdLWc5YavzxFCssvgy0wgBfvU4/G7pIBz2oFxB9LbusVVj0Lp
         O+CCLBpMAba5L8DPc1G7qCjvPw3EOV4fHzCOKi+Ynk5RLNgSI9kF27Nhl4KmuqwA9BgD
         VIkw5Z0kVtBN+CXfPmDe3DMupE2BL0r4k8dMATb/9vr9omMYkcNyeZ97Gzk4G5JQTVoZ
         IIy/pmDl1LHzjdR5IdhrZPrWdQiEKJvelKriagJTYYsorj9CNjclJaSKPUqwDDDeIbj7
         H3gg==
X-Gm-Message-State: AOAM533aESdzEeYmZagIthb8U4MxQEzIe7rfh5TJ6veLgP+kuGoz9T87
        H6JOYxe8kTCIotXQK+dujEMLqLGlsF/mnw==
X-Google-Smtp-Source: ABdhPJztI0qApV0cz6QRYMk88fwO0nzkihx3dX3V+oo5XvBmlvmTjTLJLjq55QeMfjR/yDCU6SmHsA==
X-Received: by 2002:a63:fb16:: with SMTP id o22mr9091557pgh.309.1627283147616;
        Mon, 26 Jul 2021 00:05:47 -0700 (PDT)
Received: from jianchwadeMacBook-Pro.local ([154.223.168.30])
        by smtp.gmail.com with ESMTPSA id c24sm41829730pfn.86.2021.07.26.00.05.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jul 2021 00:05:47 -0700 (PDT)
Subject: Re: [PATCH V3 5/5] ext4: make fallocate retry when err is ENOSPC
To:     Guoqing Jiang <guoqing.jiang@linux.dev>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca
References: <20210724074124.25731-1-jianchao.wan9@gmail.com>
 <20210724074124.25731-6-jianchao.wan9@gmail.com>
 <0ac551b1-6295-9117-757d-12bee70de588@linux.dev>
From:   Wang Jianchao <jianchao.wan9@gmail.com>
Message-ID: <2888807f-2822-a73d-4c01-f073f8fffae2@gmail.com>
Date:   Mon, 26 Jul 2021 15:05:41 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <0ac551b1-6295-9117-757d-12bee70de588@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On 2021/7/26 11:40 AM, Guoqing Jiang wrote:
> Hi,
> 
> On 7/24/21 3:41 PM, Wang Jianchao wrote:
>> From: Wang Jianchao <wangjianchao@kuaishou.com>
>>
>> The blocks may be waiting for journal commit to be freed back to
>> mb buddy. Let fallocate wait and retry in that case.
>>
>> Signed-off-by: Wang Jianchao <wangjianchao@kuaishou.com>
>> ---
>>   fs/ext4/extents.c | 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
>> index 92ad64b89d9b..ad0b874d3448 100644
>> --- a/fs/ext4/extents.c
>> +++ b/fs/ext4/extents.c
>> @@ -4635,7 +4635,7 @@ long ext4_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
>>       struct inode *inode = file_inode(file);
>>       loff_t new_size = 0;
>>       unsigned int max_blocks;
>> -    int ret = 0;
>> +    int ret = 0, retries = 0;
>>       int flags;
>>       ext4_lblk_t lblk;
>>       unsigned int blkbits = inode->i_blkbits;
>> @@ -4656,6 +4656,7 @@ long ext4_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
>>                FALLOC_FL_INSERT_RANGE))
>>           return -EOPNOTSUPP;
>>   +retry:
>>       ext4_fc_start_update(inode);
>>         if (mode & FALLOC_FL_PUNCH_HOLE) {
>> @@ -4722,6 +4723,9 @@ long ext4_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
>>       trace_ext4_fallocate_exit(inode, offset, max_blocks, ret);
>>   exit:
>>       ext4_fc_stop_update(inode);
>> +    if (ret == -ENOSPC && ext4_should_retry_alloc(inode->i_sb, &retries))
>> +        goto retry;
>> +
> 
> Not sure if it is necessary since ext4_alloc_file_blocks already retries allocate.

Yes, this patch should be get rid of.
But it is indeed helpful to fix the xfstest generic/371 which does concurrently write/rm
and fallocate/rm. I'll figure out some other way to improve that

Thanks
Jianchao

> 
> Thanks,
> Guoqing
