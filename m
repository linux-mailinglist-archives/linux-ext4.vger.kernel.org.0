Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A28747B153E
	for <lists+linux-ext4@lfdr.de>; Thu, 28 Sep 2023 09:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbjI1Hpq (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 28 Sep 2023 03:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjI1Hpq (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 28 Sep 2023 03:45:46 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87F758F;
        Thu, 28 Sep 2023 00:45:44 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Rx5BB36hyz4f3m76;
        Thu, 28 Sep 2023 15:45:38 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
        by APP4 (Coremail) with SMTP id gCh0CgDHXNwiLxVlU+xbBg--.14651S2;
        Thu, 28 Sep 2023 15:45:39 +0800 (CST)
Subject: Re: [PATCH v7 02/12] ext4: factor out codes to update block bitmap
 and group descriptor on disk from ext4_mb_mark_bb
To:     Ritesh Harjani <ritesh.list@gmail.com>, tytso@mit.edu,
        adilger.kernel@dilger.ca
Cc:     ojaswin@linux.ibm.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <87sf6yrjre.fsf@doe.com>
From:   Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <9eacc6e6-ae33-ac1e-cc7c-2defcc0517d9@huaweicloud.com>
Date:   Thu, 28 Sep 2023 15:45:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <87sf6yrjre.fsf@doe.com>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: gCh0CgDHXNwiLxVlU+xbBg--.14651S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCFyxCFy7GF1fZr48uFWUtwb_yoW5Xr4Upr
        43J3WFkr4UtrnrCr4I9w1xXr1rtw4IkF1UXr9xWw1rXFZFya4xWFZrKF1F9FyUurZ3WF1S
        qa1YqF9F9w1Fka7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
        xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UE-erUUUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



on 9/28/2023 12:42 PM, Ritesh Harjani wrote:
> Kemeng Shi <shikemeng@huaweicloud.com> writes:
> 
>> on 9/27/2023 4:49 PM, Ritesh Harjani wrote:
>>> Kemeng Shi <shikemeng@huaweicloud.com> writes:
>>>
>>>> There are several reasons to add a general function ext4_mb_mark_context
>>>> to update block bitmap and group descriptor on disk:
>>>> 1. pair behavior of alloc/free bits. For example,
>>>> ext4_mb_new_blocks_simple will update free_clusters in struct flex_groups
>>>> in ext4_mb_mark_bb while ext4_free_blocks_simple forgets this.
>>>> 2. remove repeat code to read from disk, update and write back to disk.
>>>> 3. reduce future unit test mocks to catch real IO to update structure
>>>> on disk.
>>>>
>>>> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
>>>> ---
>>>>  fs/ext4/mballoc.c | 147 ++++++++++++++++++++++++----------------------
>>>>  1 file changed, 77 insertions(+), 70 deletions(-)
>>>>
>>>> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
>>>> index cf09adfbaf11..e1320eea46e9 100644
>>>> --- a/fs/ext4/mballoc.c
>>>> +++ b/fs/ext4/mballoc.c
>>>> @@ -3953,6 +3953,80 @@ void ext4_exit_mballoc(void)
>>>>  	ext4_groupinfo_destroy_slabs();
>>>>  }
>>>>  
>>>> +static int
>>>> +ext4_mb_mark_context(struct super_block *sb, bool state, ext4_group_t group,
>>>> +		     ext4_grpblk_t blkoff, ext4_grpblk_t len)
>>>
>>>
>>> ext4_grpblk_t is defined as int.
>>>     /* data type for block offset of block group */
>>>     typedef int ext4_grpblk_t;
>>>
>>> I think len should be unsigned int (u32) here. 
>>>
>> Hi Ritesh, thanks for reply and a lot suggestions to this patch and other
>> patches in this series.
>> I define len as ext4_grpblk_t as I think ext4_grpblk_t is supposed to fit
>> block or cluster number of single group.
>>
> 
> At different places the use of datatype for no. of blocks/clusters within
> a group gets very confusing :(
> > However, IMO ext4_grpblk_t should be fine for using len argument here.
> I did respond about that while reviewing in some later patches [1]
> 
> [1]: https://lore.kernel.org/linux-ext4/87r0mkey45.fsf@doe.com/
> 
> So, I don't think we need any changes to this patch. 
>     Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> 
Sorry for missing this.
> Also overall the series looks good. There are just some minor
> changes suggested in 1st patch and some commit msg updates suggested for
> other changes. If you send a v8, then I think that looks good to be
> picked up :) 
> 
> Thanks a lot for working on it & the suggested changes!
Thanks a lot for your suggestion and patience! I will send a v8 include
all changes that you suggested. Thanks!
> 
> -ritesh
> 

