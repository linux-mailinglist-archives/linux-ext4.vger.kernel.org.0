Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB63D38846A
	for <lists+linux-ext4@lfdr.de>; Wed, 19 May 2021 03:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232784AbhESBae (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 18 May 2021 21:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231689AbhESBae (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 18 May 2021 21:30:34 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C580C06175F;
        Tue, 18 May 2021 18:29:15 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id t11so6506106pjm.0;
        Tue, 18 May 2021 18:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VhtGsRQc+R6QdXUUosI8SyxA+4ob1+wx8JCGQB2aGos=;
        b=ePVH2Y9lhx8keq05JyRcVnQiJ5/gCyhzA0oOtmSk9HelPosG8YbTaA5ZFIcuimZVI5
         km9ct2j/Pxmvf6j85CjNGWJ6yx/ZVmZbv6FDNXfQePzxoXzM7cv1KtaCj9ilR6kvXj/M
         kGnPnQwMmAVLfLalYfGnQ/tReLMIdbN4AvC3ljF8WR2Fi09WrwMR9AucTa1Whk6rzbGp
         ONyee7EkgN+k5zIEeqS/4nZl1KJ5OzdHyaiJpyuZAgcd06Vfn/KoZTR+1hiWquoSTb4t
         XVtS5bM+4jzbmXcAEQ2nsF9WC7zG9B/zcmK3kNYCuVaAWqKq/6FeqVLRlGVxZ8fThXSV
         Cdvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VhtGsRQc+R6QdXUUosI8SyxA+4ob1+wx8JCGQB2aGos=;
        b=j+s6qmVjNt8N1Tkl0iaSLV+cSpWG64CsH1JPFVSAFX9guTxj/27PsWEz7ITpc1YjK2
         mIR0ydq5K6VKkHIyk5i/TOP5JoGFu0c/IGvgQUH1Wi27vzQ3sAUxbJDcKbM4X8OIBNgr
         ZMsH0tMXV5+tnpAM62ETD3I2nnpoHDzVw+AOZiUumKd4Mi+cV5eSQg+hL1ooltMThXls
         trkQXF8oH5R8xf/gXVkOjwY1B56p6QT1dcsmiNeWeSPW8L3VW/pM3j5DOh264UZ2O/hW
         dNeccSb4wfEXymkW5gxsjBZ4hwNw8NkERto+gWlXw/TmbUY0DL0ZDas9W8SNb96a8CeC
         wIrA==
X-Gm-Message-State: AOAM533cpwvCKyKZz/GBtQa9mVvXIHajhjVkadl0xKxSOOyR5ljf8x53
        R5nZIDlj7qpoa++MeeeNudpCogWqd1CELA==
X-Google-Smtp-Source: ABdhPJzuGgnZo4UuzRhIECEwsmc+lXFofPjkB3LTrhrSQIILdP9TbmpsjUhs6nZL4cW6DnPToNJf7A==
X-Received: by 2002:a17:902:d305:b029:f0:d3db:26db with SMTP id b5-20020a170902d305b02900f0d3db26dbmr7808100plc.36.1621387754639;
        Tue, 18 May 2021 18:29:14 -0700 (PDT)
Received: from jianchwadeMacBook-Pro.local ([122.10.101.135])
        by smtp.gmail.com with ESMTPSA id c16sm5908231pfd.206.2021.05.18.18.29.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 May 2021 18:29:14 -0700 (PDT)
Subject: Re: [PATCH] ext4: get discard out of jbd2 commit kthread
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
References: <53146e54-af36-0c32-cad8-433460461237@gmail.com>
 <YKLXev4cjeRuGRqd@mit.edu> <c7c00420-ed5c-0f5d-23c1-1c64b1800778@gmail.com>
 <YKPV6FZWfoUD3bgL@mit.edu>
From:   Wang Jianchao <jianchao.wan9@gmail.com>
Message-ID: <1d43599f-fed1-b37e-a411-2b0f31583991@gmail.com>
Date:   Wed, 19 May 2021 09:27:56 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YKPV6FZWfoUD3bgL@mit.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On 2021/5/18 10:57 PM, Theodore Y. Ts'o wrote:
> On Tue, May 18, 2021 at 09:19:13AM +0800, Wang Jianchao wrote:
>>> That way we don't need to move all of this to a kworker context.
>>
>> The submit_bio also needs to be out of jbd2 commit kthread as it may be
>> blocked due to blk-wbt or no enough request tag. ;)
> 
> Actually, there's a bigger deal that I hadn't realized, about why we
> is why are currently using submit_bio_wait().  We *must* wait until
> discard has completed before we call ext4_free_data_in_buddy(), which
> is what allows those blocks to be reused by the block allocator.
> 
> If the discard happens after we reallocate the block, there is a good
> chance that we will end up corrupting a data or metadata block,
> leading to user data loss.

Yes

> 
> There's another corollary to this; if you use blk-wbt, and you are
> doing lots of deletes, and we move this all to a writeback thread,
> this *significantly* increases the chance that the user will see
> ENOSPC errors in the case where they are with a very full (close to
> 100% used) file system.

We would flush the kwork that's doing discard in this patch.
That's done in ext4_should_retry_alloc()

> 
> I'd argue that this is a *really* good reason why using mount -o
> discard is Just A Bad Idea if you are running with blk-wbt.  If
> discards are slow, using fstrim is a much better choice.  It's also
> the case that for most SSD's and workloads, doing frequent discards
> doesn't actually help that much.  The write endurance of the device is
> not compromised that much if you only run fs-trim and discard unused
> blocks once a day, or even once a week --- I only recommend use of
> mount -o discard in cases where the discard operation is effectively
> free.  (e.g., in cases where the FTL is implemented on the Host OS, or
> you are running with super-fast flash which is PCIe or NVMe attached.)

We're running ext4 with discard on a nbd device whose backend is storage
cluster. The discard can help to free the unused space to storage pool.

And sometimes application delete a lot of data and discard is flooding. 
Then we see the jbd2 commit kthread is blocked for a long time. Even
move the discard out of jbd2, we still see the write IO of jbd2 log
could be blocked. blk-wbt could help to relieve this. Finally the delay
is shift to allocation path. But this is better than blocking the page
fault path which holds the read mm->mmap_sem.

Best regards
Jianchao

> 
> Cheers,
> 
> 					- Ted
> 
