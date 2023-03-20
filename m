Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E2886C0B62
	for <lists+linux-ext4@lfdr.de>; Mon, 20 Mar 2023 08:32:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbjCTHcJ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 20 Mar 2023 03:32:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjCTHcI (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 20 Mar 2023 03:32:08 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C515BCA17;
        Mon, 20 Mar 2023 00:32:05 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Pg5z26JmRz4f3jYp;
        Mon, 20 Mar 2023 15:31:58 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
        by APP2 (Coremail) with SMTP id Syh0CgC3qObrCxhktKaXFg--.12780S2;
        Mon, 20 Mar 2023 15:31:56 +0800 (CST)
Subject: Re: [PATCH v3 20/20] ext4: simplify calculation of blkoff in
 ext4_mb_new_blocks_simple
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     adilger.kernel@dilger.ca, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230303172120.3800725-1-shikemeng@huaweicloud.com>
 <20230303172120.3800725-21-shikemeng@huaweicloud.com>
 <20230316050740.GL860405@mit.edu>
 <d88a3d33-6832-2921-c8bb-b935b19e7db4@huaweicloud.com>
 <20230317155047.GB3270589@mit.edu>
From:   Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <c4ac2156-b773-bc9e-a764-8c3beeeaf3ac@huaweicloud.com>
Date:   Mon, 20 Mar 2023 15:31:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20230317155047.GB3270589@mit.edu>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: Syh0CgC3qObrCxhktKaXFg--.12780S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGFWkWrW5AF4fZrWrtr45Awb_yoW5WrWrpa
        n3GF18trs8Ca48Xr97Zr4xtw4F9393AF17Cr45W34UZa98Xrya9Fs2krWFvF9F9rZxuFy2
        v3WYkrsxWwn8Z3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
        xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1zuWJUUUUU==
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        MAY_BE_FORGED,NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



on 3/17/2023 11:50 PM, Theodore Ts'o wrote:
> On Thu, Mar 16, 2023 at 06:19:40PM +0800, Kemeng Shi wrote:
>> Hi Theodore, thanks for feedback. I will submit another patchset for
>> mballoc and I would like to include this fix if no one else does. As
>> new patches may be conflicted with old ones I submited, I would submit
>> the new patchset after the old ones are fully reviewed and applied
>> if this fix is not in rush. Thanks!
> 
> Hi, I've already taken the your patches into the dev branch; were
> there any changes you were intending to make to your patches?
> 
> If you could submit a separate fix for the bug that I noticed, that
> would be great.
Hi, I was stuck in some urgent work recently and I will do this ASAP and
it should be done in this week.
> Also, if you are interested in doing some more work in mballoc.c, I
> was wondering if you would be interested in adding some Kunit tests
> for mballoc.c.  A simple example Kunit test for ext4 can be found in
> fs/ext4/inode_test.c.  (The convention is to place tests for foo.c in
> foo_test.c.)

> [1] https://docs.kernel.org/dev-tools/kunit/
> 
> In order to add mballoc Kunit tests, we will need to add some "mock"[2]
> functions to simulate what happens when mballoc.c tries reading a
> block bitmap.  My thinking was to have a test provide an array of some
> data structure like this:
> 
> struct test_bitmap {
>        unsigned int	start;
>        unsigned int	len;
> };
> 
> [2] https://en.wikipedia.org/wiki/Mock_object
> 
> ... which indicates the starting block, and the length of a run of
> blocks that are marked as in use, where the list of blocks are sorted
> by starting block number, and where a starting block of ~0 indicates
> the end of the list of block extents.
> We would also need have a set of utility ext4 Kunit functions to
> create "fake" ext4 superblocks and ext4_sb_info structures.
The Kunit tests thing sounds interesting and I would like to this. But
I still need some time to get basic knowledge then I maybe able to discuss
detais. Of couse, anyone is also interesting in this and can make this work
soon is fine.:)
> I was originally thinking that obvious starting Kunit tests would be
> for fs/ext4/hash.c and fs/ext4/extents_status.c, since they require
> the little or no "mocking" support.  However, there are so many
> changes in fs/ext4/mballoc.c, the urgency in having unit tests for it
> is getting more urgent --- since if there is a bug in one of these
> functions, such as the one that I noted in
> ext4_mb_new_blocks_simple(), since it's harder to exhaustively test
> some of these smaller sub-functions in integration tests such as those
> found in xfstests.  Unit tests are the best way to make sure we're
> testing all of the code paths in a complex module such as mballoc.c
Yes, I can't agree more and this may be able to find other exsiting bugs.

-- 
Best wishes
Kemeng Shi

