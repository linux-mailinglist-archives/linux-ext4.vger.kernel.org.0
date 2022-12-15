Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F4B064D874
	for <lists+linux-ext4@lfdr.de>; Thu, 15 Dec 2022 10:21:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbiLOJVc (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 15 Dec 2022 04:21:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbiLOJV3 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 15 Dec 2022 04:21:29 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6314C65
        for <linux-ext4@vger.kernel.org>; Thu, 15 Dec 2022 01:21:27 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4NXmv61bdcz4f3nT5
        for <linux-ext4@vger.kernel.org>; Thu, 15 Dec 2022 17:21:22 +0800 (CST)
Received: from [10.174.178.134] (unknown [10.174.178.134])
        by APP4 (Coremail) with SMTP id gCh0CgDHONYT55pjas8TCQ--.38660S3;
        Thu, 15 Dec 2022 17:21:25 +0800 (CST)
Subject: Re: [RFC PATCH] ext4: dio take shared inode lock when overwriting
 preallocated blocks
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, yukuai3@huawei.com
References: <20221203103956.3691847-1-yi.zhang@huawei.com>
 <20221214170125.bixz46ybm76rtbzf@quack3>
 <1df360ba-35f4-18e1-5544-acb18a680a90@huaweicloud.com>
 <20221215090026.scnl7nx5klkjgsld@quack3>
From:   Zhang Yi <yi.zhang@huaweicloud.com>
Message-ID: <e1294bbb-008f-a789-99bf-33de63089beb@huaweicloud.com>
Date:   Thu, 15 Dec 2022 17:21:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20221215090026.scnl7nx5klkjgsld@quack3>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: gCh0CgDHONYT55pjas8TCQ--.38660S3
X-Coremail-Antispam: 1UD129KBjvJXoWxCFWxXFW7tFWkWw1kuF47twb_yoWrJw15pr
        WIqa48tFWq9FyFkF1Iva10qF1Yk3yftr45Xrn5Xw4UAF909r9aqrZ2qFWY9a4vgrs7GF4U
        Xr4Yq3y7WFyUZaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 2022/12/15 17:00, Jan Kara wrote:
> On Thu 15-12-22 16:24:49, Zhang Yi wrote:
>> On 2022/12/15 1:01, Jan Kara wrote:
>>> On Sat 03-12-22 18:39:56, Zhang Yi wrote:
>>>> In the dio write path, we only take shared inode lock for the case of
>>>> aligned overwriting initialized blocks inside EOF. But for overwriting
>>>> preallocated blocks, it may only need to split unwritten extents, this
>>>> procedure has been protected under i_data_sem lock, it's safe to
>>>> release the exclusive inode lock and take shared inode lock.
>>>>
>>>> This could give a significant speed up for multi-threaded writes. Test
>>>> on Intel Xeon Gold 6140 and nvme SSD with below fio parameters.
>>>>
>>>>  direct=1
>>>>  ioengine=libaio
>>>>  iodepth=10
>>>>  numjobs=10
>>>>  runtime=60
>>>>  rw=randwrite
>>>>  size=100G
>>>>
>>>> And the test result are:
>>>> Before:
>>>>  bs=4k       IOPS=11.1k, BW=43.2MiB/s
>>>>  bs=16k      IOPS=11.1k, BW=173MiB/s
>>>>  bs=64k      IOPS=11.2k, BW=697MiB/s
>>>>
>>>> After:
>>>>  bs=4k       IOPS=41.4k, BW=162MiB/s
>>>>  bs=16k      IOPS=41.3k, BW=646MiB/s
>>>>  bs=64k      IOPS=13.5k, BW=843MiB/s
>>>>
>>>> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
>>>> ---
>>>>  It passed xfstests auto mode with 1k and 4k blocksize.
>>>
>>> Besides some naming nits (see below) I think this should work. But I have
>>> to say I'm a bit uneasy about this because we will now be changing block
>>> mapping from unwritten to written only with shared i_rwsem. OTOH that
>>> happens during writeback as well so we should be fine and the gain is very
>>> nice.
>>>
>> Thanks for advice, I will change the argument name to make it more reasonable.
>>
>>> Out of curiosity do you have a real usecase for this?
>>
>> No, I was just analyse the performance gap in our benchmark tests, and have
>> some question and idea while reading the code. Maybe it could speed up the
>> first time write in some database. :)
>>
>> Besides, I want to discuss it a bit more. I originally changed this code to
>> switch to take the shared inode and also use ext4_iomap_overwrite_ops for
>> the overwriting preallocated blocks case. It will postpone the splitting extent
>> procedure to endio and could give a much more gain than this patch (+~27%).
>>
>> This patch:
>>   bs=4k       IOPS=41.4k, BW=162MiB/s
>> Postpone split:
>>   bs=4k       IOPS=52.9k, BW=207MiB/s
>>
>> But I think it's maybe too radical. I looked at the history and notice in
>> commit 0031462b5b39 ("ext4: Split uninitialized extents for direct I/O"),
>> it introduce the flag EXT4_GET_BLOCKS_DIO(now it had been renamed to
>> EXT4_GET_BLOCKS_PRE_IO) to make sure that the preallocated unwritten
>> extent have been splitted before submitting the I/O, which is used to
>> prevent the ENOSPC problem if the filesystem run out-of-space in the
>> endio procedure. And 4 years later, commit 27dd43854227 ("ext4: introduce
>> reserved space") reserve some blocks for metedata allocation.  It looks
>> like this commit could also slove the ENOSPC problem for most cases if we
>> postpone extent splitting into the endio procedure. I don't find other
>> side effect, so I think it may also fine if we do that. Do you have some
>> advice or am I missing something?
> 
> So you are right these days splitting of extents could be done only on IO
> completion because we have a pool of blocks reserved for these cases. OTOH
> this will make the pressure on the reserved pool higher and if we are
> running out of space and there are enough operations running in parallel we
> *could* run out of reserved blocks. So I wouldn't always defer extent
> splitting to IO completion unless we have a practical and sufficiently
> widespread usecase that would benefit from this optimization.
> 

Sure, I think so, thanks for advice.

Yi.

