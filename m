Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8B7676C22D
	for <lists+linux-ext4@lfdr.de>; Wed,  2 Aug 2023 03:26:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbjHBB0D (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 1 Aug 2023 21:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbjHBB0C (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 1 Aug 2023 21:26:02 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BF7C2736;
        Tue,  1 Aug 2023 18:25:49 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4RFvS73z9Hz4f3lw4;
        Wed,  2 Aug 2023 09:25:43 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
        by APP2 (Coremail) with SMTP id Syh0CgB3V9WXsMlkL9coPQ--.12109S2;
        Wed, 02 Aug 2023 09:25:44 +0800 (CST)
Subject: Re: [PATCH v3 10/10] ext4: correct some stale comment of criteria
To:     Ritesh Harjani <ritesh.list@gmail.com>, tytso@mit.edu,
        adilger.kernel@dilger.ca, ojaswin@linux.ibm.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
References: <87v8dyw8ar.fsf@doe.com>
From:   Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <b04b471c-cda1-2247-196f-5e5d3725bc7d@huaweicloud.com>
Date:   Wed, 2 Aug 2023 09:25:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <87v8dyw8ar.fsf@doe.com>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: Syh0CgB3V9WXsMlkL9coPQ--.12109S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJF1UGrW7Zr1kJw15tw1UJrb_yoW8AF4Dpr
        43KFyxCF1fXr1UCF47u3WkWw1qgw4fWFyUJryFqw1FvrZxJryxuanrtr1ruFyxZrs7Jw1Y
        vrZIvFyxCa4DC37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



on 8/2/2023 9:18 AM, Ritesh Harjani wrote:
> Kemeng Shi <shikemeng@huaweicloud.com> writes:
> 
>> We named criteria with CR_XXX, correct stale comment to criteria with
>> raw number.
>>
>> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
>> ---
>>  fs/ext4/mballoc.c | 8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
>> index bfaab173a3f4..1e8ce0ece47a 100644
>> --- a/fs/ext4/mballoc.c
>> +++ b/fs/ext4/mballoc.c
>> @@ -2782,8 +2782,8 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
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
>> @@ -2840,8 +2840,8 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
>>  			/*
>>  			 * Batch reads of the block allocation bitmaps
>>  			 * to get multiple READs in flight; limit
>> -			 * prefetching at cr=0/1, otherwise mballoc can
>> -			 * spend a lot of time loading imperfect groups
>> +			 * prefetching at inexpensive CR, otherwise mballoc
>> +			 * can spend a lot of time loading imperfect groups
>>  			 */
>>  			if ((prefetch_grp == group) &&
>>  			    (ext4_mb_cr_expensive(cr) ||
> Is this function defined at any place ^^^
> 
> -ritesh
> 
Hi Ritesh, sorry for the bother. I actually menthioned this in v2->v3 change in cover
letter that patch 10 is on top of [1] which has reviewed before.

[1] https://lore.kernel.org/linux-ext4/20230630085927.140137-1-ojaswin@linux.ibm.com/
-- 
Best wishes
Kemeng Shi

