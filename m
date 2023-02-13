Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13BE66946F7
	for <lists+linux-ext4@lfdr.de>; Mon, 13 Feb 2023 14:27:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbjBMN1O (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 13 Feb 2023 08:27:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbjBMN1N (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 13 Feb 2023 08:27:13 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 843211ABCD;
        Mon, 13 Feb 2023 05:27:10 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4PFlVv1dYFz4f3jMK;
        Mon, 13 Feb 2023 21:27:03 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
        by APP2 (Coremail) with SMTP id Syh0CgBHOOanOupj5dX_DQ--.24452S2;
        Mon, 13 Feb 2023 21:27:05 +0800 (CST)
Subject: Re: [PATCH 03/21] ext4: avoid to use preallocated blocks if
 EXT4_MB_HINT_GOAL_ONLY is set
To:     Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230209194825.511043-1-shikemeng@huaweicloud.com>
 <20230209194825.511043-4-shikemeng@huaweicloud.com>
 <Y+n2+7pjkeb3vWQ7@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
From:   Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <f967d63b-907e-a495-3ec5-9043c35b9938@huaweicloud.com>
Date:   Mon, 13 Feb 2023 21:27:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <Y+n2+7pjkeb3vWQ7@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: Syh0CgBHOOanOupj5dX_DQ--.24452S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CryfKF18Gw4DAr43Jw17Awb_yoW8Cr15pF
        WfJay8KFn7uw47uanF9w15Gw409a1xKr18XF4FgryrZr9xA393KFsrKF1Fga40yrsruFn0
        qF4aqFW3Cr1rua7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0E
        wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
        80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0
        I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04
        k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UE-erUUUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



on 2/13/2023 4:38 PM, Ojaswin Mujoo wrote:
> On Fri, Feb 10, 2023 at 03:48:07AM +0800, Kemeng Shi wrote:
>> ext4_mb_use_preallocated will ignore the demand to alloc at goal block
>> only. Return false if EXT4_MB_HINT_GOAL_ONLY is set before use
>> preallocated blocks in ext4_mb_use_preallocated.
>>
>> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
>> ---
>>  fs/ext4/mballoc.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
>> index 375d9655b525..352ac9139fee 100644
>> --- a/fs/ext4/mballoc.c
>> +++ b/fs/ext4/mballoc.c
>> @@ -4368,6 +4368,9 @@ ext4_mb_use_preallocated(struct ext4_allocation_context *ac)
>>  	if (!(ac->ac_flags & EXT4_MB_HINT_DATA))
>>  		return false;
>>  
>> +	if (unlikely(ac->ac_flags & EXT4_MB_HINT_GOAL_ONLY))
>> +		return false;
>> +
>>  	/* first, try per-file preallocation */
>>  	rcu_read_lock();
>>  	list_for_each_entry_rcu(pa, &ei->i_prealloc_list, pa_inode_list) {
>> -- 
>> 2.30.0
>>
> So with the flag, even when we request for a logical/goal block
> combination that can be satisfied by one of the inode PAs in the list,
> we would still exit early and the allocation would eventually fail since
> the goal block would be marked "in-use" in the buddy. This doesn't seem
> to be desirable.
> 
> Maybe instead of exiting early we should try to find a PA that satisfies
> the logical block we are asking for and then incase of
> EXT4_MB_HINT_GOAL_ONLY, we can add a check to see if the physical block
> of the PA corresponds to the goal block. Would like to hear your
> thoughts on this.
Yes, this is a more thoughtful, I will improve this in next version.
Besides, maybe we should also test length if EXT4_MB_HINT_MERGE is set
as ext4_mb_find_by_goal do.

> Regards,
> ojaswin
> 

-- 
Best wishes
Kemeng Shi

