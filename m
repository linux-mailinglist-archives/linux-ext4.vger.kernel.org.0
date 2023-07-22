Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 771FF75D95F
	for <lists+linux-ext4@lfdr.de>; Sat, 22 Jul 2023 05:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbjGVDQR (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 21 Jul 2023 23:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjGVDQQ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 21 Jul 2023 23:16:16 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFC9C3A9C;
        Fri, 21 Jul 2023 20:16:14 -0700 (PDT)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4R7BPk5djjzrRmB;
        Sat, 22 Jul 2023 11:15:22 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sat, 22 Jul 2023 11:16:10 +0800
Message-ID: <1e382d8f-84b6-c1df-4091-9db14e9f82cf@huawei.com>
Date:   Sat, 22 Jul 2023 11:16:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH 2/4] ext4: fix BUG in ext4_mb_new_inode_pa() due to
 overflow
Content-Language: en-US
To:     Theodore Ts'o <tytso@mit.edu>
CC:     "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        <linux-ext4@vger.kernel.org>, <adilger.kernel@dilger.ca>,
        <jack@suse.cz>, <ojaswin@linux.ibm.com>,
        <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>,
        <yangerkun@huawei.com>, <yukuai3@huawei.com>,
        Baokun Li <libaokun1@huawei.com>
References: <87lef9lljt.fsf@doe.com>
 <c9cde644-f757-2d72-6ac6-d5cfb1e43da5@huawei.com> <ZLq9MROKiyet9Oce@mit.edu>
From:   Baokun Li <libaokun1@huawei.com>
In-Reply-To: <ZLq9MROKiyet9Oce@mit.edu>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.174]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500021.china.huawei.com (7.185.36.21)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 2023/7/22 1:15, Theodore Ts'o wrote:
> On Fri, Jul 21, 2023 at 05:13:13PM +0800, Baokun Li wrote:
>>> Doing this with helpers, IMO is not useful as we also saw above.
>> I still think it is necessary to add a helper to make the code more concise.
>>
>> Ted, do you think the fex_end() helper function is needed here?
>>
>> I think we might need your advice to end this discussion. 😅
> Having helper functions doesn't bother me all _that_ much --- so long
> as they are named appropriately.  The readibility issues start with
> the fact that the helper function uses loff_t as opposed to
> ext4_lblk_t, and because someone looking at fex_end() would need
> additional thinking to figure out what it did.  If renamed it to be
> fex_logical_end() and made it take an ext4_lblk_t, I think it would be
> better.
Yes, naming is one of the most difficult things.

The reason the helper function uses loff_t instead of ext4_lblk_t is because
when we compute the extent logical end or pa end, we may exceed the
maximum length of ext4_lblk_t and get an overflowed result, which can lead
to the four issues fixed in the patch set. Perhaps I should add some 
comments
to explain these.

In other words, add this helper function and limit the return value of 
the function
to loff_t is precisely to remind people that such overflow problems exist.
As mentioned by ritesh, ext4 has many places to directly perform type 
conversion
in place. However, when we modify the kernel or review code, we will 
still ignore
that the current code may have overflow problems, as in the commit fixed 
by this
patch.

If we have a helper function fex_end(), we can avoid potential overflow 
problems
by using it directly when we make changes or by questioning why we 
didn't use
a simpler helper function when reviewing the code, rather than just 
adding a (loff_t)
when we spot the problem and saying, "Oh, the problem is perfectly 
solved!" 😀

The current problem can be solved in any way, the key is how to prevent 
similar
problems in the future?
> The bigger complaint that I have, although it's not the fault of your
> patch, is the use of "ext4_free_extent" all over ext4/mballoc.c when
> it's much more often used for allocating blocks.  So the name of the
> structure and the "fex" in "fex_end" or "fex_logical_end" is also
> confusing.
>
> Hmm... how about naming helper function extent_logial_end()?
Great! Thank you for naming the helper function.
>
> And at some point we might want to do a global search and replace
> changing ext4_free_extent to something like ext4_mballoc_extent, and
> changing the structure element names.  Perhaps:
>
>         fe_logical  --->  ex_lblk
>         fe_start    --->  ex_cluster_start
>         fe_group    --->  ex_group
>         fe_len      --->  ex_cluster_len
>
> This is addressing problems where "start" can mean the starting
> physical block, the starting logical block, or the starting cluster
> relative to the beginning of the block group.
>
> There is also documentation which is just wrong.  For example:
>
> /**
>   * ext4_trim_all_free -- function to trim all free space in alloc. group
>   * @sb:			super block for file system
>   * @group:		group to be trimmed
>   * @start:		first group block to examine
>   * @max:		last group block to examine
>
> start and max should be "first group cluster to examine" and "last
> group cluster to examine", respectively.
Yes, it is also very important to distinguish between mballoc_extent and 
free_extent.
I will try to rename ext4_free_extent to ext4_mballoc_extent and fix 
some comment
errors in another patch set that does some performance optimizations using
"free extent".
>
> The bottom line is that there are much larger opportunities to make
> the code more maintainable than worrying about two new helper
> functions.  :-)
>
> Cheers,
>
> 					- Ted
Yes, making code more maintainable is always the goal.
Thank you for your patient explanation!

Cheers!
-- 
With Best Regards,
Baokun Li
.
