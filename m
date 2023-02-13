Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88F066945C6
	for <lists+linux-ext4@lfdr.de>; Mon, 13 Feb 2023 13:27:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbjBMM1l (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 13 Feb 2023 07:27:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjBMM1k (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 13 Feb 2023 07:27:40 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDA0B6A71;
        Mon, 13 Feb 2023 04:27:38 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4PFkBF4QVhz4f3jJ4;
        Mon, 13 Feb 2023 20:27:33 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
        by APP2 (Coremail) with SMTP id Syh0CgD35eO0LOpjH0D9DQ--.20612S2;
        Mon, 13 Feb 2023 20:27:33 +0800 (CST)
Subject: Re: [PATCH 04/21] ext4: get correct ext4_group_info in
 ext4_mb_prefetch_fini
To:     Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230209194825.511043-1-shikemeng@huaweicloud.com>
 <20230209194825.511043-5-shikemeng@huaweicloud.com>
 <Y+ngxf4fBbhPBHPk@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
From:   Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <51940a4e-b01d-cef8-af35-87788df483f1@huaweicloud.com>
Date:   Mon, 13 Feb 2023 20:27:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <Y+ngxf4fBbhPBHPk@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: Syh0CgD35eO0LOpjH0D9DQ--.20612S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJrWxWF15tw1xtr1xZw43Jrb_yoW8CryUp3
        95JF1Uur4rWr1DCr4I93yjq3W8tw4Igr1UJry3Xw1UuFZrJr97XF97Kr18uF1UAFZakr1I
        v3Z8ZF13Cr12kaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyKb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0E
        wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
        80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0
        I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04
        k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY
        1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUzsqWUUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



on 2/13/2023 3:03 PM, Ojaswin Mujoo wrote:
> On Fri, Feb 10, 2023 at 03:48:08AM +0800, Kemeng Shi wrote:
>> We always get ext4_group_desc with group + 1 and ext4_group_info with
>> group to check if we need do initialize ext4_group_info for the group.
>> Just get ext4_group_desc with group for ext4_group_info initialization
>> check.
>>
>> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
>> ---
>>  fs/ext4/mballoc.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
>> index 352ac9139fee..f24f80ecf318 100644
>> --- a/fs/ext4/mballoc.c
>> +++ b/fs/ext4/mballoc.c
>> @@ -2570,13 +2570,13 @@ void ext4_mb_prefetch_fini(struct super_block *sb, ext4_group_t group,
>>  			   unsigned int nr)
>>  {
>>  	while (nr-- > 0) {
>> -		struct ext4_group_desc *gdp = ext4_get_group_desc(sb, group,
>> -								  NULL);
>> -		struct ext4_group_info *grp = ext4_get_group_info(sb, group);
>> +		struct ext4_group_desc *gdp;
>> +		struct ext4_group_info *grp;
>>  
>>  		if (!group)
>>  			group = ext4_get_groups_count(sb);
>>  		group--;
>> +		gdp = ext4_get_group_desc(sb, group, NULL);
>>  		grp = ext4_get_group_info(sb, group);
>>  
>>  		if (EXT4_MB_GRP_NEED_INIT(grp) &&
>> -- 
>> 2.30.0
>>
> 
> This is a duplicate of [1] :)
> 
> But I'm okay with this going in as that patchseries might take some time
> to get merged. Feel free to add:
> 
> Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com> 
> 
> [1] https://lore.kernel.org/r/85bbcb3774e38de65b737ef0000241ddbdda73aa.1674822311.git.ojaswin@linux.ibm.com
> 
Hi Ojaswin, Thank you so much to review my code. I 'm sorry that I didn't
notice this patch is duplicated and I really appreciate that you allow this
one to get merged first. I will add your sign to this patch in next version.
Thanks!

-- 
Best wishes
Kemeng Shi

