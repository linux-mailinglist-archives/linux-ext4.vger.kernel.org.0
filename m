Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3048C389AD5
	for <lists+linux-ext4@lfdr.de>; Thu, 20 May 2021 03:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbhETBWQ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 19 May 2021 21:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbhETBWP (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 19 May 2021 21:22:15 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9478AC061574;
        Wed, 19 May 2021 18:20:54 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d16so11142063pfn.12;
        Wed, 19 May 2021 18:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ouxxrOZoBlNY9/ZWpDy87EV/vidd2vtoBo+A+O7NdB4=;
        b=twXbMCcL0FyP0DPrdrqQzik6nxjWebPnaD31f3kQMpfG9HrAakU+HC1YcMaJ+oMQxq
         3GW6DnF398QPZRbEU9zHzegUViqlBwrxUOVPaYcs46HtGVZl0pkIYgasmK/MCRr0xHEu
         SotZQTkgOb456yMu5VyFVFbt/yQdrscbnf/SVs6AG3sj5ByHxHoN5HWRKPwBJxbH3+PV
         FCfZkle9yLUuL5zUd0Hi1VvT0xUXQoPolwqwWCkgghCmh8IjyLpjMYNPBuJdPqYXIFIS
         l898j7Qn+FCHQu+NnwWfxicWFyHVVfuBIDXz4kwiWOz+SjJxr4pbxyaclAInY8Qd0ckV
         Ipvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ouxxrOZoBlNY9/ZWpDy87EV/vidd2vtoBo+A+O7NdB4=;
        b=sZHtMjxDrE6JNzRyd/sLQJsU7JWy2zqRedBqE1cHz5AodoArJKXBvS6hP2dhjhoIPM
         +JNvemfOTC6BFVHjMyRo9yUA/1WGeqjbEBvgDeQe5xyNV4fEoXprA6jaG74EbQi4d/oW
         c8T5y8pD7icV2U3sjLeVp1Gtzr8sF32bxS/lqwLRIBnX1iVDkaYkeuY2WFiDOSJS8Ze5
         Du9r/9QIiAvzLqbnC5cGS+9/8X26J4/4zjILx5XSzS8Ek3ewlibgOwhEg4rTKK9GouEx
         8OCSkvoTGyT2jUTXQiyyOINWBUDc45EhdLK/VTum+ELw/6M2P122HAMTqkdNhUjfAIQY
         wB6A==
X-Gm-Message-State: AOAM530PAhOSoNxlig7vwEwd7ScHwBjTKW4cTr74ggp25wPi4AZiZ68O
        avJhaKn5BBfgHwaqHOYkf/QeWr0LY6CzKA==
X-Google-Smtp-Source: ABdhPJyMzsFoRhTZ2KTiPbWEVzM9RGPwpMRrN+jZce6w/7Btyu4CihxiWd45icyxsz/aCBBJOORc0A==
X-Received: by 2002:a63:6f8e:: with SMTP id k136mr2024214pgc.326.1621473654090;
        Wed, 19 May 2021 18:20:54 -0700 (PDT)
Received: from jianchwadeMacBook-Pro.local ([2402:5ec0:1fff:ffff:db93:56ad:e27f:2e1])
        by smtp.gmail.com with ESMTPSA id 67sm447965pfw.83.2021.05.19.18.20.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 May 2021 18:20:53 -0700 (PDT)
Subject: Re: [PATCH] ext4: get discard out of jbd2 commit kthread
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
References: <53146e54-af36-0c32-cad8-433460461237@gmail.com>
 <YKLXev4cjeRuGRqd@mit.edu> <c7c00420-ed5c-0f5d-23c1-1c64b1800778@gmail.com>
 <YKPV6FZWfoUD3bgL@mit.edu> <1d43599f-fed1-b37e-a411-2b0f31583991@gmail.com>
 <YKUp5BpAwaBREe6d@mit.edu>
From:   Wang Jianchao <jianchao.wan9@gmail.com>
Message-ID: <1e29444c-cbd4-8c5e-d4c3-deaa61592b19@gmail.com>
Date:   Thu, 20 May 2021 09:20:49 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YKUp5BpAwaBREe6d@mit.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On 2021/5/19 11:08 PM, Theodore Y. Ts'o wrote:
> On Wed, May 19, 2021 at 09:27:56AM +0800, Wang Jianchao wrote:
>>
>> We're running ext4 with discard on a nbd device whose backend is storage
>> cluster. The discard can help to free the unused space to storage pool.
>>
>> And sometimes application delete a lot of data and discard is flooding. 
>> Then we see the jbd2 commit kthread is blocked for a long time. Even
>> move the discard out of jbd2, we still see the write IO of jbd2 log
>> could be blocked. blk-wbt could help to relieve this. Finally the delay
>> is shift to allocation path. But this is better than blocking the page
>> fault path which holds the read mm->mmap_sem.
> 
> I'm assuming that the problem is when the application deletes a lot of
> data, the discard flood is causing performance problems on your nbd
> server.  Is that the high level problem that you are trying to solve?
> 

Yes, not only the discard sometimes could be very slow, but also it
would degrade the performance of normal write IO

> So if that's the case, I'd suggest a different approach.  First, move
> kmem_cache_free(ext4_free_data_cachep, entry) out of
> ext4_free_data_in_buddy() to its caller, ext4_process_data.  Then if
> discard is enabled, after calling ext4_free_data_in_buddy(), the
> ext4_free_data struct will be detached from rbtree rooted in
> ext4_group_info.bb_free_root, and then we can attach it to a new
> rbtree rooted in ext4_group_info.bb_discard_root.
> 
> This allows the block to be reused as soon the commit is finished
> (allowing for potentially more efficient block allocations), but we
> can now keep track of which blocks would be useful for discarding and
> decouple that from when we release the blocks to be reused.  We can
> now use the pre-existing fstrim kernel thread infrastructure to lock a
> block group, and we can now iterate over the rbtree, and take into
> account which blocks have since become allocated --- since if a block
> has been allocated, there's no need to send a discard for it.
> 
> I think this will be more efficient, and will allow us to share more
> of the code for fstrim and the discard-at-runtime model used by "mount
> -o discard".  We can also fine-tune how quickly we issue discards; it
> might be that if user has executed "rm -rf" it might actually better
> to wait until the deletes have completed, even if it takes several
> commit intervals, since it might allow us to combine discards if the
> blocks 100-199 and 400-500 are released in one commit, and blocks
> 200-399 are released two or three commits later.


Yes, this is more efficient and fair. I will cook the next version path
based on the suggestion above.

> 
> Something else I'd urge you to consider is whether it's possible to
> enhance the nbd protocol to add some kind of back-channel notification
> when the shared storage is getting low on space.  In that case, when
> the nbd client code a request from the nbd server indicating, "please
> issue discards if possible", it could either trigger an upcall to
> userspace, which could then issue the fstrim ioctl, which in the case
> where "mount -o discard" is enabled, would accelerate when discards
> took place.
> 
> We could then make the fstrim thread normally work on a much slower
> pace, but when there is a signal from the shared storage that space is
> needed, clients could accelerate when they issue discards to free up
> shared space.

This sounds great !!!
I will share this with my colleagues to see how to implement it.

> 
> Cheers,
> 
> 						- Ted
> 
> P.S.  One other potential thought; if we have established a new
> bb_discard_root rbtree, it *might* actually be beneficial to consider
> using that information in the block allocator.  One of the best way to
> tell an SSD that block is no longer needed is to simply overwrite that
> block.  If we do that, we don't need to send a discard to that block
> any more.

This seems also true for the storage server. If the nbd client reuse the
blocks that's just freed, the server needn't to do new allocation.

> 
> Of course, we still want to keep blocks contiguous since even though
> seeks are free for SSD's, we want to keep large reads contiguous as
> much as possible, and we want to keep the extent tree as compact as
> possible.  But if we have just released a 12k file, and we are writing
> a new 12k file, and don't really care *where* in the block group we
> are writing that file, reusing blocks that had just been freed might
> actually be a good strategy.
> 
> That's not something you need to implement in this patch series, but
> it might be an interesting optimization.
> 

And thanks a million for your suggestions

Best Regards
Jianchao 
