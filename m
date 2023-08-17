Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B959377EF2F
	for <lists+linux-ext4@lfdr.de>; Thu, 17 Aug 2023 04:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347679AbjHQCtD (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 16 Aug 2023 22:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347680AbjHQCs4 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 16 Aug 2023 22:48:56 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72A4126AA;
        Wed, 16 Aug 2023 19:48:55 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RR8b71DzVz4f3nV7;
        Thu, 17 Aug 2023 10:48:51 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
        by APP2 (Coremail) with SMTP id Syh0CgAHKm6Tit1k7ZaOAw--.40390S2;
        Thu, 17 Aug 2023 10:48:52 +0800 (CST)
Subject: Re: [PATCH 03/13] ext4: correct return value of ext4_convert_meta_bg
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230629120044.1261968-1-shikemeng@huaweicloud.com>
 <20230629120044.1261968-4-shikemeng@huaweicloud.com>
 <20230816030044.GI2247938@mit.edu>
From:   Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <a7ea5edb-834d-091a-efe6-7d15a5a55338@huaweicloud.com>
Date:   Thu, 17 Aug 2023 10:48:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20230816030044.GI2247938@mit.edu>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: Syh0CgAHKm6Tit1k7ZaOAw--.40390S2
X-Coremail-Antispam: 1UD129KBjvdXoW7GFyrKFy5tF4UArWDGryDZFb_yoWktrc_GF
        48C3W7XrsIvrsaka1fCr1Yvw4ag3WDJr4UWanYqFW0gFyYva1kXr4kXrZ3Cry8ur10kFsx
        CFn7ZFyxta4a9jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb7xYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20E
        Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
        A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x02
        67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0E
        wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
        80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0
        I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04
        k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UWHqcUUUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



on 8/16/2023 11:00 AM, Theodore Ts'o wrote:
> On Thu, Jun 29, 2023 at 08:00:34PM +0800, Kemeng Shi wrote:
>> We return error in "ret", so collect previous error in "ret" instead
>> of "err" or previous error will be ignored.
>>
>> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
>> ---
>>  fs/ext4/resize.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/ext4/resize.c b/fs/ext4/resize.c
>> index 7cbc695b7005..0b3d8c808de1 100644
>> --- a/fs/ext4/resize.c
>> +++ b/fs/ext4/resize.c
>> @@ -1984,8 +1984,8 @@ static int ext4_convert_meta_bg(struct super_block *sb, struct inode *inode)
>>  
>>  errout:
>>  	ret = ext4_journal_stop(handle);
>> -	if (!err)
>> -		err = ret;
>> +	if (!ret)
>> +		ret = err;
>>  	return ret;
> 
> If there is a previous error in "err", I think we would want to
> prioritize returning that error, as opposed to the potential error
> from ext4_journal_stop().  So how about this instead?
> 
> errout:
> 	ret = ext4_journal_stop(handle);
> 	if (!err)
> 		ret = err;
> 	return ret;
> 
I think you mean:
errout:
	ret = ext4_journal_stop(handle);
	if (*err*)
		ret = err;
	return ret;
And I will fix in this way if I don't get wrong.
> 
> 						- Ted
> 

