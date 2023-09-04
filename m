Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3035679102C
	for <lists+linux-ext4@lfdr.de>; Mon,  4 Sep 2023 04:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351106AbjIDCur (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 3 Sep 2023 22:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351104AbjIDCur (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 3 Sep 2023 22:50:47 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B16D310A;
        Sun,  3 Sep 2023 19:50:43 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RfCmw2PdPz4f3kKY;
        Mon,  4 Sep 2023 10:50:40 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
        by APP2 (Coremail) with SMTP id Syh0CgCnEGX_RfVk66wsCQ--.16155S2;
        Mon, 04 Sep 2023 10:50:40 +0800 (CST)
Subject: Re: [PATCH v6 01/11] ext4: factor out codes to update block bitmap
 and group descriptor on disk from ext4_mb_mark_bb
To:     Ritesh Harjani <ritesh.list@gmail.com>, tytso@mit.edu,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <87msy78fv6.fsf@doe.com>
From:   Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <881e7e86-2300-929e-d8c5-504a68c1a419@huaweicloud.com>
Date:   Mon, 4 Sep 2023 10:50:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <87msy78fv6.fsf@doe.com>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: Syh0CgCnEGX_RfVk66wsCQ--.16155S2
X-Coremail-Antispam: 1UD129KBjvJXoWxtF1rAw4rZw4UZryUCw4fuFg_yoW7Wr4xpr
        1UA3Wqkr48JrnxCanFvw4Sqr13Kw48JF4UX34fGr1F9r9xtr97AF4DtF1F9F90qrs7AF1Y
        va17XrW7ur4rC37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
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
        c7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1CPfJUUUUU==
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



on 8/31/2023 10:07 PM, Ritesh Harjani wrote:
> Kemeng Shi <shikemeng@huaweicloud.com> writes:
> 
>> on 8/31/2023 8:33 PM, Ritesh Harjani wrote:
>>> Kemeng Shi <shikemeng@huaweicloud.com> writes:
>>>
>>> Hello Kemeng,
>>>
>>>> There are several reasons to add a general function to update block
>>>> bitmap and group descriptor on disk:
>>>
>>> ... named ext4_mb_mark_context(<params>)
>>>
>>>> 1. pair behavior of alloc/free bits. For example,
>>>> ext4_mb_new_blocks_simple will update free_clusters in struct flex_groups
>>>> in ext4_mb_mark_bb while ext4_free_blocks_simple forgets this.
>>>> 2. remove repeat code to read from disk, update and write back to disk.
>>>> 3. reduce future unit test mocks to catch real IO to update structure
>>>> on disk.
>>>>
>>>> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
>>>> Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
>>>> ---
>>>>  fs/ext4/mballoc.c | 169 +++++++++++++++++++++++++++-------------------
>>>>  1 file changed, 99 insertions(+), 70 deletions(-)
>>>>
>>>> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
>>>> index c91db9f57524..e2be572deb75 100644
>>>> --- a/fs/ext4/mballoc.c
>>>> +++ b/fs/ext4/mballoc.c
>>>> @@ -3952,6 +3952,100 @@ void ext4_exit_mballoc(void)
>>>>  	ext4_groupinfo_destroy_slabs();
>>>>  }
>>>>  
>>>> +/*
>>>> + * Collect global setting to reduce the number of variable passing to
>>>> + * ext4_mb_mark_context. Pass target group blocks range directly to
>>>> + * reuse the prepared global setting for multiple block ranges and
>>>> + * to show clearly the specific block range will be marked.
>>>> + */
>>>> +struct ext4_mark_context {
>>>> +	struct super_block *sb;
>>>> +	int state;
>>>> +};
>>>
>>> This structure definition does not reflect of it's naming.
>>> Why can't we also add cblk & clen, flags to it?
>>>
>>> I think the idea of defining a new function named
>>> ext4_mb_prepare_mark_context() was that we can prepare "struct ext4_mark_context"
>>> with different cblk, clen & flags arguments for cases where we might
>>> have to call ext4_mb_mark_context() more than once in the same function
>>> or call ext4_mb_mark_context() anywhere but at the start of the function.
>>>
>>> As I see it in the current series, we are calling
>>> ext4_mb_prepare_mark_context() at the start of every function. Just for
>>> this purpose we don't need an extra function, right? That we can directly do
>>> at the time of declaring a structure variable itself (like how you did
>>> in previous version)
>>>
>> Hi Ritesh, thanks for reply. The ext4_mark_context structure aims to reduce
>> variable passing to ext4_mb_mark_context. If we have to prepare a lot
>> member in ext4_mb_prepare_mark_context, then too many variables issue occurs
>> in ext4_mb_prepare_mark_context.
>> The name of ext4_mark_context maybe not proper. Actually I want a structure
>> to collect information which is not strongly relevant to mark blk bits. In
>> this way, we can initialize them at beginning of function, then there is no
>> need to pay attention to them or to pass them respectively in each call to
>> ext4_mb_mark_context. Instead, we foucus on the useful information called
>> with ext4_mb_mark_context.
>> This design also achive the goal to define ext4_mb_mark_context once for
>> multiple use in the same function as ext4_mark_context unlikely changes
>> after initialization at beginning.
>>> What do you think of the approach where we add cblk, clen & flags
>>> variables to ext4_mark_context()? Do you see any problems/difficulties
>>> with that design?
>>>
>> The providing desgin looks good to me. Please let me konw if you still
>> perfre this and I will do this in next version. Thanks!
>>
> 
> I would have still preferred, the block and len arguments inside struct
> ext4_mark_context, because that better explains the use and definition of
> structure and it's prepare function.
> However, since this is not any functionality change, I am fine if you
> prefer the current design(as you mentioned above).
> We can always discuss & change it later too :) 
> 
Thanks for the reivew. Since more improvement is needed, I would like to
define ext4_mark_context as you suggested in previous version:
    ext4_mark_context {
        ext4_group_t mc_group;          /* block group */
        ext4_grpblk_t mc_clblk;	    /* block in cluster units */
        ext4_grpblk_t mc_cllen;	    /* len in cluster units */
        ext4_grpblk_t mc_clupdates;     /* number of clusters marked/unmarked */
        unsigned int mc_flags;          /* flags ... */
        bool mc_state;                  /* to set or unset state */
    };
And super_block and handle are passed as arguments.

Besides, as we will pass a lot arguments in prepare function anyway. What
about simply passing all arguments to ext4_mb_prepare_mark_context
directly:
static inline void ext4_mb_mark_context(handle_t *handle,
                                                struct super_block *sb,
                                                int state,
                                                ext4_group_t group,
                                                ext4_grpblk_t blkoff,
                                                ext4_grpblk_t len,
                                                int flags,
                                                ext4_grpblk_t *changed)
Look forward to your reply. Thanks!
> Since otherwise the refactoring changes looks good to me.
> Please feel free to add -
> 
> Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> 
> Thanks! 
> -ritesh
> 

