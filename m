Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00A986D8CCC
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Apr 2023 03:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234499AbjDFBgW (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 5 Apr 2023 21:36:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjDFBgU (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 5 Apr 2023 21:36:20 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A83C76B7;
        Wed,  5 Apr 2023 18:36:19 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4PsPGj43G0z4f3jYG;
        Thu,  6 Apr 2023 09:36:13 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
        by APP1 (Coremail) with SMTP id cCh0CgAnjykNIi5kn8WLGQ--.52810S2;
        Thu, 06 Apr 2023 09:36:15 +0800 (CST)
Subject: Re: [PATCH 3/8] ext4: fix wrong unit use in ext4_mb_new_inode_pa
To:     Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230321161220.418652-1-shikemeng@huaweicloud.com>
 <20230321161220.418652-4-shikemeng@huaweicloud.com>
 <ZC3LXYKjp5zwYfO1@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
From:   Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <72df8e87-6798-20f0-2524-b6430f1b3846@huaweicloud.com>
Date:   Thu, 6 Apr 2023 09:36:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <ZC3LXYKjp5zwYfO1@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: cCh0CgAnjykNIi5kn8WLGQ--.52810S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Gr17uF18trWfZF15XFWrXwb_yoW8JrW7pF
        s7JFyjka4fWw1UCrs7G3Z8Gr1Y93y2gF18J345ta45uF9rWrW8Aan2y348Wr9xGr4jyF1F
        vFs2ga45Gw47uaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyKb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
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
X-Spam-Status: No, score=0.7 required=5.0 tests=KHOP_HELO_FCRDNS,MAY_BE_FORGED,
        NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



on 4/6/2023 3:26 AM, Ojaswin Mujoo wrote:
> On Wed, Mar 22, 2023 at 12:12:15AM +0800, Kemeng Shi wrote:
>> fe_logical and win are both in block unit. Remove wrong convertion for
>> win from block unit to cluster unit.
>>
>> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
>> ---
>>  fs/ext4/mballoc.c | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
>> index 7f695830621a..86d978e1f7dc 100644
>> --- a/fs/ext4/mballoc.c
>> +++ b/fs/ext4/mballoc.c
>> @@ -4640,8 +4640,7 @@ ext4_mb_new_inode_pa(struct ext4_allocation_context *ac)
>>  		if (offs && offs < win)
>>  			win = offs;
>>  
>> -		ac->ac_b_ex.fe_logical = ac->ac_o_ex.fe_logical -
>> -			EXT4_NUM_B2C(sbi, win);
>> +		ac->ac_b_ex.fe_logical = ac->ac_o_ex.fe_logical - win;
>>  		BUG_ON(ac->ac_o_ex.fe_logical < ac->ac_b_ex.fe_logical);
>>  		BUG_ON(ac->ac_o_ex.fe_len > ac->ac_b_ex.fe_len);
> 
> So this bit of code is removed in the patchset I sent here [1]. My patchset
> is mostly ready to be merged and Ted did mention that he was going to
> pick that up soon. So would it be okay with you if we drop this particular patch?
Sure, I will drop this in next version.
>>  	}
>> -- 
>> 2.30.0
>>
> 

-- 
Best wishes
Kemeng Shi

