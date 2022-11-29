Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2746963B9B6
	for <lists+linux-ext4@lfdr.de>; Tue, 29 Nov 2022 07:17:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235497AbiK2GQ7 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 29 Nov 2022 01:16:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235319AbiK2GQx (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 29 Nov 2022 01:16:53 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3947E13F2B
        for <linux-ext4@vger.kernel.org>; Mon, 28 Nov 2022 22:16:51 -0800 (PST)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NLsXn48bkzRpWw;
        Tue, 29 Nov 2022 14:16:09 +0800 (CST)
Received: from [10.174.178.134] (10.174.178.134) by
 canpemm500005.china.huawei.com (7.192.104.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 29 Nov 2022 14:16:47 +0800
Subject: Re: [PATCH] ext4: add barrier info if journal device write cache is
 not enabled
To:     Jan Kara <jack@suse.cz>
CC:     <linux-ext4@vger.kernel.org>, <tytso@mit.edu>,
        <adilger.kernel@dilger.ca>, <yukuai3@huawei.com>
References: <20221124135744.1488959-1-yi.zhang@huawei.com>
 <20221128101108.nslkglhz7pmflyoa@quack3>
 <02ab48e0-27d7-1a59-603a-34bd85bb2b68@huawei.com>
 <20221128151551.fo6ct7nbozlqjvci@quack3>
From:   Zhang Yi <yi.zhang@huawei.com>
Message-ID: <91aff807-ecde-b37f-444c-010276fd09f7@huawei.com>
Date:   Tue, 29 Nov 2022 14:16:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20221128151551.fo6ct7nbozlqjvci@quack3>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.134]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500005.china.huawei.com (7.192.104.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 2022/11/28 23:15, Jan Kara wrote:
> On Mon 28-11-22 21:01:07, Zhang Yi wrote:
>> On 2022/11/28 18:11, Jan Kara wrote:
>>> On Thu 24-11-22 21:57:44, Zhang Yi wrote:
>>>> The block layer will check and suppress flush bio if the device write
>>>> cache is not enabled, so the journal barrier will not go into effect
>>>> even if uer specify 'barrier=1' mount option. It's dangerous if the
>>>> write cache state is false negative, and we cannot distinguish such
>>>> case easily. So just give an info and an inquire interface to let
>>>> sysadmin know the barrier is suppressed for the case of write cache is
>>>> not enabled.
>>>>
>>>> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
>>>
>>> Hum, so have you seen a situation when write cache information is incorrect
>>> in the block layer? Does it happen often enough that it warrants extra
>>> sysfs file?
>>>
>>
>> Thanks for response. Yes, It often happens on some SCSI devices with RAID
>> card, the disks below the RAID card enabled write cache, but the RAID driver
>> declare the write cache was disabled when probing, and the RAID card seems
>> cannot guarantee data writing back to disk medium on power failure. So the
>> ext4 filesystem will probably be corrupted at the next startup. It's
>> difficult to distinguish it's a hardware or an software problem.
>> I am not familiar with the RAID card. So I don't know why the cache state
>> is incorrect (maybe incorrect configured or firmware bug).
> 
> OK, thanks for info. I believe usually you're expected to disable write
> cache on the disks themselves and leave caching to the RAID card. But I'm
> not an expert here and it's a bit besides the point anyway ;)
> 
>>> After all you should be able to query what the block layer thinks about the
>>> write cache - you definitely can for SCSI devices, I'm not sure about
>>> others. So you can have a look there. Providing this info in the filesystem
>>> seems like doing it in the wrong layer - I don't see anything jbd2/ext4
>>> specific here...
>>>
>>
>> Yes, the best way is to figure out the RAID card problem.
>> This patch is not to aim to fix something in ext4. The reason why I want to add
>> this in ext4 is just give a hint from the fs barrier's point of view, it show the
>> barrier's running state at mount time, could help us to delimit the cache problem
>> more easily when we found ext4 corruption after power failure. Before this patch,
>> we could do that through SCSI probing info and /sys/block/sda/queue/write_cache
>> (maybe some others?), it's not quite clear.
>>
>>   [    2.520176] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
>>
>>   [root@localhost ~]# cat /sys/block/sda/queue/write_cache
>>   write back
> 
> Yes. /sys/block/<device>/queue/write_cache is what you should query to find
> whether barriers will be ignored or not. My point is - you need this for
> ext4, now if you start using XFS filesystem you'd need similar patch for
> XFS and then if you transition to btrfs you'd need this for btrfs as well
> and all this duplication is there because you are querying through the
> filesystem a property of the underlying block device. So why not ask the
> block device directly?
> 
> I understand it may be more *convenient* to grab the information from the
> filesystem given the infrastructure you have for gathering filesystem
> information. But carrying around various sysfs files has its cost as well.
> 
OK, it's fine, let's keep querying the block layer.

Thanks,
Yi.
