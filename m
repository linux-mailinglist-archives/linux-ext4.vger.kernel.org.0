Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C46F764366
	for <lists+linux-ext4@lfdr.de>; Thu, 27 Jul 2023 03:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbjG0B3V (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 26 Jul 2023 21:29:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjG0B3U (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 26 Jul 2023 21:29:20 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDDDC1738;
        Wed, 26 Jul 2023 18:29:18 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RBCpy3K82z4f3vdm;
        Thu, 27 Jul 2023 09:29:14 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
        by APP1 (Coremail) with SMTP id cCh0CgDnUCtoyMFkLJR3OA--.21216S2;
        Thu, 27 Jul 2023 09:29:13 +0800 (CST)
Subject: Re: [PATCH v2 10/10] ext4: correct some stale comment of criteria
To:     Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, ritesh.list@gmail.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230725185106.2147273-1-shikemeng@huaweicloud.com>
 <20230725185106.2147273-11-shikemeng@huaweicloud.com>
 <ZMEyxLauFkXBwgUZ@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
From:   Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <5db4b292-fee8-9581-841c-206ba10d4b80@huaweicloud.com>
Date:   Thu, 27 Jul 2023 09:29:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <ZMEyxLauFkXBwgUZ@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: cCh0CgDnUCtoyMFkLJR3OA--.21216S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Zw1UZw48Cr18tFyUZrW8JFb_yoW8uw4kpr
        WfKFyxCF1fXr1UCFZF93W8WwsFgw4SgFWUXr9Y9w4Fvr9xJryfC3ZrK3Z5uFyxAr4fG3W5
        ZwnIvFWxC3WUu37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
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
        c7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1CPfJUUUUU==
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



on 7/26/2023 10:50 PM, Ojaswin Mujoo wrote:
> On Wed, Jul 26, 2023 at 02:51:06AM +0800, Kemeng Shi wrote:
>> We named criteria with CR_XXX, correct stale comment to criteria with
>> raw number.
> 
> Hi Kemeng,
> 
> Thanks for the cleanups.
> 
>>
>> Fixes: f52f3d2b9fba ("ext4: Give symbolic names to mballoc criterias")
>> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
>> Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>> ---
>>  fs/ext4/mballoc.c | 8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
>> index 36eea63eaace..de5da76e6748 100644
>> --- a/fs/ext4/mballoc.c
>> +++ b/fs/ext4/mballoc.c
>> @@ -2777,8 +2777,8 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
>>  
>>  	/*
>>  	 * ac->ac_2order is set only if the fe_len is a power of 2
>> -	 * if ac->ac_2order is set we also set criteria to 0 so that we
>> -	 * try exact allocation using buddy.
>> +	 * if ac->ac_2order is set we also set criteria to CR_POWER2_ALIGNED
>> +	 * so that we try exact allocation using buddy.
>>  	 */
>>  	i = fls(ac->ac_g_ex.fe_len);
>>  	ac->ac_2order = 0;
>> @@ -2835,8 +2835,8 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
>>  			/*
>>  			 * Batch reads of the block allocation bitmaps
>>  			 * to get multiple READs in flight; limit
>> -			 * prefetching at cr=0/1, otherwise mballoc can
>> -			 * spend a lot of time loading imperfect groups
>> +			 * prefetching at cr below CR_FAST, otherwise mballoc
> 
> One of my earlier patchset has replaced the CR_FAST macro with
> ext4_mb_cr_expensive() so maybe we can account for that here:
> 
> https://lore.kernel.org/linux-ext4/20230630085927.140137-1-ojaswin@linux.ibm.com/
> 
Hi Ojaswin, sorry for missing this. I still could not find the comment update
of stale comment "limit prefetching at cr=0/1" in that patch. Maybe we could
update comment to "prefetching at inexpensive CR, otherwise ...". What do
you think. Or did I miss anything.

-- 
Best wishes
Kemeng Shi
> Regards,
> ojaswin
> 
>> +			 * can spend a lot of time loading imperfect groups
> 
>>  			 */
>>  			if ((prefetch_grp == group) &&
>>  			    (cr >= CR_FAST ||
>> -- 
>> 2.30.0
>>
>

