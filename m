Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD89701D1C
	for <lists+linux-ext4@lfdr.de>; Sun, 14 May 2023 13:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233095AbjENLlM (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 14 May 2023 07:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbjENLlL (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 14 May 2023 07:41:11 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A90A71BDA;
        Sun, 14 May 2023 04:41:09 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QK0v45d1nz4f3tqd;
        Sun, 14 May 2023 19:41:04 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
        by APP4 (Coremail) with SMTP id gCh0CgCnQpbQyGBko2+1JQ--.27373S2;
        Sun, 14 May 2023 19:41:05 +0800 (CST)
Subject: Re: [PATCH v3 13/19] ext4: call ext4_mb_mark_group_bb in
 ext4_free_blocks_simple
To:     Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230417110617.2664129-1-shikemeng@huaweicloud.com>
 <20230417110617.2664129-14-shikemeng@huaweicloud.com>
 <ZGCqkC+UHebpPSwm@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
From:   Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <f3043c72-1cc1-147d-c86b-7126395b423e@huaweicloud.com>
Date:   Sun, 14 May 2023 19:41:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <ZGCqkC+UHebpPSwm@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: gCh0CgCnQpbQyGBko2+1JQ--.27373S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Wr4xGw4UGw15AF4ftF1rXrb_yoWfWrg_Wr
        sFvw1kKFZrK3Z3Ja18ZFZ8trs7KrW5tFs0gFWrWFW8ua4UXFs3AF1DZryavwnxGFy7CasI
        ka4Sgr9rKF42vjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbzxYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20E
        Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
        A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x02
        67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267
        AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80
        ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4
        AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vI
        r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
        xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0
        cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
        AvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7Cj
        xVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1CPfJUUUUU==
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



on 5/14/2023 5:32 PM, Ojaswin Mujoo wrote:
> On Mon, Apr 17, 2023 at 07:06:11PM +0800, Kemeng Shi wrote:
>> call ext4_mb_mark_group_bb in ext4_free_blocks_simple to:
>> 1. remove repeat code
>> 2. pair update of free_clusters in ext4_mb_new_blocks_simple.
>> 3. add missing ext4_lock_group/ext4_unlock_group protection.
>>
>> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> 
> Correct me if I'm wrong but I think we will never try to clear bitmap
> bits for a BLOCK_UNINIT BG right. Maybe if that's the case we can add a
> WARN_ON as follows in ext4_mb_mark_group_bb():
> 
> 	if (ext4_has_group_desc_csum(sb) &&
> 		(gdp->bg_flags & cpu_to_le16(EXT4_BG_BLOCK_UNINIT))) {
> 
> 		WARN_ON(mc->state == 0);
> 		...
> 
> 	}

Yes, bitmap clear for BLOCK_UNINIT block group should not happen , I will
add this in next version. Thanks for the suggestion.

-- 
Best wishes
Kemeng Shi

