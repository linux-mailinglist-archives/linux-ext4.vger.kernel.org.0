Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30FC469A604
	for <lists+linux-ext4@lfdr.de>; Fri, 17 Feb 2023 08:24:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbjBQHYU (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 17 Feb 2023 02:24:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBQHYO (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 17 Feb 2023 02:24:14 -0500
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9539E5529C;
        Thu, 16 Feb 2023 23:24:12 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4PJ3GH2b9qz4f3jHn;
        Fri, 17 Feb 2023 15:24:07 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
        by APP4 (Coremail) with SMTP id gCh0CgAX8bRsKu9jMfUfDw--.45875S2;
        Fri, 17 Feb 2023 15:19:09 +0800 (CST)
Subject: Re: [PATCH 04/21] ext4: get correct ext4_group_info in
 ext4_mb_prefetch_fini
To:     "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
References: <87ttzkiybi.fsf@doe.com>
From:   Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <182b8237-d504-46de-8521-8508449f7b82@huaweicloud.com>
Date:   Fri, 17 Feb 2023 15:19:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <87ttzkiybi.fsf@doe.com>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: gCh0CgAX8bRsKu9jMfUfDw--.45875S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KFWfZr1kGrWUWF1DGrW8tFb_yoW8Ww48pr
        ZxJ3WUur45WrWDCr4xWay2q3W0yw4xWFyUJry3Ww1UuF9rGryxKF97KF48ZF1UCFsa9r17
        Z3ZIvrnrCr13CaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
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
        c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UE-erUUUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        MAY_BE_FORGED,NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



on 2/17/2023 2:46 PM, Ritesh Harjani (IBM) wrote:
> Kemeng Shi <shikemeng@huaweicloud.com> writes:
> 
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
> 
> We can even declare these variables at the begining of the function like
> in [1]. Also I would advise to rearrange any "fixes" patches at the
> begining of the patch series and "cleanup" patches at the end.
> e.g. this looks like a fix to me.
> 
> That way it is sometimes easier for people to cherry-pick any fixes if
> required in their older kernel trees. ;)
> 
Hi Ritesh, Thanks for feedback. I declare these variables at the begining
of the function in next version.
I agree that we should keep bugfix patches at the beginning. Actually,
patch 1-8 are all fix patches from my view. So I think current patch sort
is fine.
Thanks.

-- 
Best wishes
Kemeng Shi

