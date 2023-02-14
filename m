Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 747166955C2
	for <lists+linux-ext4@lfdr.de>; Tue, 14 Feb 2023 02:12:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbjBNBM3 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 13 Feb 2023 20:12:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjBNBM2 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 13 Feb 2023 20:12:28 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63D8C2D7C;
        Mon, 13 Feb 2023 17:12:27 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4PG38k1czxz4f3jZ3;
        Tue, 14 Feb 2023 09:12:22 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
        by APP4 (Coremail) with SMTP id gCh0CgCHOa303+pjQe5PDg--.64967S2;
        Tue, 14 Feb 2023 09:12:22 +0800 (CST)
Subject: Re: [PATCH 04/21] ext4: get correct ext4_group_info in
 ext4_mb_prefetch_fini
To:     Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230209194825.511043-1-shikemeng@huaweicloud.com>
 <20230209194825.511043-5-shikemeng@huaweicloud.com>
 <Y+ngxf4fBbhPBHPk@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
 <51940a4e-b01d-cef8-af35-87788df483f1@huaweicloud.com>
 <Y+qaN6fnlOX8EjtL@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
From:   Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <85ab22be-7d91-62f7-b2b5-84f183c73f67@huaweicloud.com>
Date:   Tue, 14 Feb 2023 09:12:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <Y+qaN6fnlOX8EjtL@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: gCh0CgCHOa303+pjQe5PDg--.64967S2
X-Coremail-Antispam: 1UD129KBjvJXoW7urWkKF4UCr17XF43Wr4fAFb_yoW5JF17pr
        Z3GF1jkr4rWr1DCr4I93yjq3W8tw4Igr1UXry3Xw1UurZrtr97JF97Kr18uF1UJFWfWF12
        v3Z8uFy3Cr12k37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



on 2/14/2023 4:14 AM, Ojaswin Mujoo wrote:
> On Mon, Feb 13, 2023 at 08:27:32PM +0800, Kemeng Shi wrote:
>>
>>
>> on 2/13/2023 3:03 PM, Ojaswin Mujoo wrote:
>>> On Fri, Feb 10, 2023 at 03:48:08AM +0800, Kemeng Shi wrote:
>>>> We always get ext4_group_desc with group + 1 and ext4_group_info with
>>>> group to check if we need do initialize ext4_group_info for the group.
>>>> Just get ext4_group_desc with group for ext4_group_info initialization
>>>> check.
>>>>
>>>> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
>>>> ---
>>>>  fs/ext4/mballoc.c | 6 +++---
>>>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
>>>> index 352ac9139fee..f24f80ecf318 100644
>>>> --- a/fs/ext4/mballoc.c
>>>> +++ b/fs/ext4/mballoc.c
>>>> @@ -2570,13 +2570,13 @@ void ext4_mb_prefetch_fini(struct super_block *sb, ext4_group_t group,
>>>>  			   unsigned int nr)
>>>>  {
>>>>  	while (nr-- > 0) {
>>>> -		struct ext4_group_desc *gdp = ext4_get_group_desc(sb, group,
>>>> -								  NULL);
>>>> -		struct ext4_group_info *grp = ext4_get_group_info(sb, group);
>>>> +		struct ext4_group_desc *gdp;
>>>> +		struct ext4_group_info *grp;
>>>>  
>>>>  		if (!group)
>>>>  			group = ext4_get_groups_count(sb);
>>>>  		group--;
>>>> +		gdp = ext4_get_group_desc(sb, group, NULL);
>>>>  		grp = ext4_get_group_info(sb, group);
>>>>  
>>>>  		if (EXT4_MB_GRP_NEED_INIT(grp) &&
>>>> -- 
>>>> 2.30.0
>>>>
>>>
>>> This is a duplicate of [1] :)
>>>
>>> But I'm okay with this going in as that patchseries might take some time
>>> to get merged. Feel free to add:
>>>
>>> Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com> 
>>>
>>> [1] https://lore.kernel.org/r/85bbcb3774e38de65b737ef0000241ddbdda73aa.1674822311.git.ojaswin@linux.ibm.com
>>>
>> Hi Ojaswin, Thank you so much to review my code. I 'm sorry that I didn't
>> notice this patch is duplicated and I really appreciate that you allow this
>> one to get merged first. I will add your sign to this patch in next version.
>> Thanks!
> Hi Kemeng,
> 
> So I'm not sure what the norm is when dealing with such duplicate
> patches, but if you do plan to add the Signed-off-by then I'd just like
> to point out that the patch I linked is mainly from Ritesh Harjani, so
> you can pick his Signed-off-by rather than mine.
> 
Sorry that I miss that there are two Signed-off-bys in patch you have already
sent. I will collect both signs to this patch. Thanks!

-- 
Best wishes
Kemeng Shi

