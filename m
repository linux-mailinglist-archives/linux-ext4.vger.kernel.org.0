Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A68AF6BCC69
	for <lists+linux-ext4@lfdr.de>; Thu, 16 Mar 2023 11:20:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbjCPKUI (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 16 Mar 2023 06:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230227AbjCPKTr (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 16 Mar 2023 06:19:47 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD8AD521;
        Thu, 16 Mar 2023 03:19:45 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4PcjtN28Bkz4f47nr;
        Thu, 16 Mar 2023 18:19:40 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
        by APP4 (Coremail) with SMTP id gCh0CgBnG6887RJkmOznFQ--.57637S2;
        Thu, 16 Mar 2023 18:19:41 +0800 (CST)
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
From:   Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <d88a3d33-6832-2921-c8bb-b935b19e7db4@huaweicloud.com>
Date:   Thu, 16 Mar 2023 18:19:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20230316050740.GL860405@mit.edu>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: gCh0CgBnG6887RJkmOznFQ--.57637S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Ar1UtrWxJFW8Aw4fWF17Jrb_yoW8XFW5pF
        Z3u3WrtFs7Gw4Utrn7Z3ySq3W0vw48Jr15GrWrK3y5uF9xXas3GF4kGw4Yva42grZ3KF42
        qFW3ur9xC3W5ZaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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



on 3/16/2023 1:07 PM, Theodore Ts'o wrote:
> On Sat, Mar 04, 2023 at 01:21:20AM +0800, Kemeng Shi wrote:
>> We try to allocate a block from goal in ext4_mb_new_blocks_simple. We
>> only need get blkoff in first group with goal and set blkoff to 0 for
>> the rest groups.
>>
>> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> 
> While this patch is OK as a simplification, there's a bigger problem
> with ext4_mb_new_blocks_simple(), and that is that we start looking
> for free blocks starting at the goal block, and then if we can't any
> free blocks by the time we get to the last block group.... we stop,
> and return ENOSPC.
> 
> This function is only used in the fast commit replay path, but for a
> very full file system, this could cause a fast commit replay to fail
> unnecesarily.  What we need to do is to try wrapping back to the
> beginning of the file system, and stop when we hit the original group
> (of the goal block) minus one.
> 
> We can fix this up in a separate patch, since this doesn't make things
> any worse, but essentially we need to do something like this:
Hi Theodore, thanks for feedback. I will submit another patchset for
mballoc and I would like to include this fix if no one else does. As
new patches may be conflicted with old ones I submited, I would submit
the new patchset after the old ones are fully reviewed and applied
if this fix is not in rush. Thanks!
> 
>     	maxgroups = ext4_get_groups_count(sb);
> 	for (g = 0; g < maxgroups ; g++) {
> 	
> 		...
> 		group++;
> 		if (group > maxgroups)
> 			group = 0;
> 	}
> 
> 					- Ted
> 

-- 
Best wishes
Kemeng Shi

