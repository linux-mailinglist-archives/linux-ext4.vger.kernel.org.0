Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0E8367F549
	for <lists+linux-ext4@lfdr.de>; Sat, 28 Jan 2023 07:50:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbjA1Gty (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 28 Jan 2023 01:49:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233119AbjA1Gtx (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 28 Jan 2023 01:49:53 -0500
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2299B757A6
        for <linux-ext4@vger.kernel.org>; Fri, 27 Jan 2023 22:49:50 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4P3lRr0p4Yz4f3wTC
        for <linux-ext4@vger.kernel.org>; Sat, 28 Jan 2023 14:49:44 +0800 (CST)
Received: from [10.174.176.34] (unknown [10.174.176.34])
        by APP4 (Coremail) with SMTP id gCh0CgAHcLNuxdRjKekzCg--.6764S3;
        Sat, 28 Jan 2023 14:49:46 +0800 (CST)
Subject: Re: [RFC PATCH 1/2] jbd2: cycled record log on clean journal logging
 area
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, yi.zhang@huawei.com, yukuai3@huawei.com
References: <20230119034600.3431194-1-yi.zhang@huaweicloud.com>
 <20230119034600.3431194-2-yi.zhang@huaweicloud.com>
 <20230126101456.ptkroqvfg442ct5q@quack3>
From:   Zhang Yi <yi.zhang@huaweicloud.com>
Message-ID: <8efacf8a-b02a-f407-5c38-b0986ae347ed@huaweicloud.com>
Date:   Sat, 28 Jan 2023 14:49:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20230126101456.ptkroqvfg442ct5q@quack3>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: gCh0CgAHcLNuxdRjKekzCg--.6764S3
X-Coremail-Antispam: 1UD129KBjvJXoWxXF45Jw48WrW5JrWkXw1rXrb_yoWrZFWUpF
        WYka47KrWkAF1xJF109F4xXFWrZw40yFWDGrykur93Zan8GF1I9r1fta4jkFyDKrWSga1j
        qr4kW3srGw1qyaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
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
        c7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1zuWJUUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello Jan, thanks for suggestions.

On 2023/1/26 18:14, Jan Kara wrote:
> Hello!
> 
> On Thu 19-01-23 11:45:59, Zhang Yi wrote:
>> From: Zhang Yi <yi.zhang@huawei.com>
>>
>> For a newly mounted file system, the journal committing thread always
>> record log from the beginning of the journal area, no matter whether the
>> journal is clean or it has just been recovered. It is disadvantageous to
>> analysis corrupted file system image and locate the file system
>> inconsistency bugs. When we get a corrupted file system image and want
>> to find out what has happened, besides lookup the system log, one
>> effective may is to backtrack the journal log. But we may not always run
>> e2fsck before each mount and the default fsck -a mode also cannot always
>> find all inconsistencies, so it could left over some inconsistencies
>> into the next mount until we detect it. Finally, the transactions in the
>> journal may probably discontinuous and some relatively new transactions
>> has been covered, it becomes hard to analyse. So if we could records
>> transactions continuously between each mounts, we could acquire more
>> useful info from the journal.
>>
>>  |Previous mount checkpointed/recovered logs|Current mount logs         |
>>  |{------}{---}{--------} ... {------}| ... |{======}{========}...000000|
>>
>> This patch save the head blocknr in the superblock after flushing the
>> journal or unmounting the file system, let the next mount could continue
>> to record new transaction behind it. This change is backward compatible
>> because the old kernel does not care about the head blocknr of the
>> journal. It is also fine if we mount a clean old image without valid
>> head blocknr, we fail back to set it to s_first just like before.
>> Finally, for the case of mount an unclean file system, we could also get
>> the journal head easily after scanning the journal, it will continue to
>> record new transaction after the recovered transactions.
> 
> I understand the usecase although if there are multiple mounts between
> the time when the corruption happened and when it got detected I suspect
> the journal will be already overwritten (filled and wrapped over) and so not
> too useful anyway. But still the number of blocks preserved in the journal
> will be higher so I guess there is some chance there will be something
> useful in there.
> 
> Do you want this mostly for debugging stuff (like fuzzer testing) or
> would you really want to run with this on production machines?

It's useful for debugging stuff, but it may also benefit to our production
machines (e.g. we have many consumer products and embedded products that are
not long running and have not too much filesystem changes for each running
and mount), so I really want to run with this on production machines
if possible.

> 
> Also I think we could actually implement something like this without adding
> s_head field (i.e., without any on-disk format change). Setting of s_start
> to 0 when the journal is empty is actually only an optimization. We could
> leave it where it is (in this debug mode), just make jbd2 detect empty
> journal while it is used from j_head == s_start instead of by testing
> s_start == 0, and the only difference would be that jbd2_journal_recover()
> would now try recovering even empty journal (but abort immediately) which
> mostly should not happen on clean mount anyway because we call jbd2 to
> recover the journal only if ext4_has_feature_journal_needs_recovery().
> 

I understand it's best to avoid changing the on-disk format. But IIUC, I think
this is not backward compatible, it changes the 'magic code' (s_start==0) of a
clean journal, the old kernel use it. If we mount a clean ext4 image in old
kernel which has been just worked in debug mode, below warning in
jbd2_journal_wipe() appears, and the fsck also complain about it.

  JBD2: Clearing recovery information on journal

  fsck.ext4 -a /dev/pmem1
  /dev/pmem1: Superblock needs_recovery flag is clear, but journal has data.
  /dev/pmem1: Run journal anyway.
  /dev/pmem1: recovering journal
  ...

Although it is not a big stuff, but it looks strange and confused. For this
reason, it seems that this (reuse s_start) may only used for debugging stuff
if we don't care about this incompatible warning. Or else we make things
complicated, we may have to add one more incompatible feature bit for this
mode and we cannot mount it in old kernels. What do you think?

Thanks.
Yi.

