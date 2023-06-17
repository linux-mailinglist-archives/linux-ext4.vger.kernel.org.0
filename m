Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 524AB733DA8
	for <lists+linux-ext4@lfdr.de>; Sat, 17 Jun 2023 04:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbjFQCnJ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 16 Jun 2023 22:43:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232118AbjFQCnI (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 16 Jun 2023 22:43:08 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49F6726A2
        for <linux-ext4@vger.kernel.org>; Fri, 16 Jun 2023 19:43:06 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QjgLX3tDQz4f3w10
        for <linux-ext4@vger.kernel.org>; Sat, 17 Jun 2023 10:43:00 +0800 (CST)
Received: from [10.174.176.34] (unknown [10.174.176.34])
        by APP2 (Coremail) with SMTP id Syh0CgBH7eqzHY1k6vczLw--.28922S3;
        Sat, 17 Jun 2023 10:43:01 +0800 (CST)
Subject: Re: [PATCH v2] jbd2: skip reading super block if it has been verified
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, yi.zhang@huawei.com,
        chengzhihao1@huawei.com, yukuai3@huawei.com
References: <20230616015547.3155195-1-yi.zhang@huaweicloud.com>
 <20230616132745.d3enqs4uni55abrj@quack3>
From:   Zhang Yi <yi.zhang@huaweicloud.com>
Message-ID: <bfd1b9f3-7f0e-4b3c-9399-4d697be37a9e@huaweicloud.com>
Date:   Sat, 17 Jun 2023 10:42:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20230616132745.d3enqs4uni55abrj@quack3>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: Syh0CgBH7eqzHY1k6vczLw--.28922S3
X-Coremail-Antispam: 1UD129KBjvJXoWxXw4xAFy5GF1kXF47urWUXFb_yoWrJrW3pr
        97KFy0krWvvryUAa18tFs8JFWjva10yFyUGr4kuwn2yayrXrnxtr9rKr15G34qyFWxuw48
        XF1UCa9akw4qk37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
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
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        MAY_BE_FORGED,NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 2023/6/16 21:27, Jan Kara wrote:
> On Fri 16-06-23 09:55:47, Zhang Yi wrote:
>> From: Zhang Yi <yi.zhang@huawei.com>
>>
>> We got a NULL pointer dereference issue below while running generic/475
>> I/O failure pressure test.
>>
>>  BUG: kernel NULL pointer dereference, address: 0000000000000000
>>  #PF: supervisor write access in kernel mode
>>  #PF: error_code(0x0002) - not-present page
>>  PGD 0 P4D 0
>>  Oops: 0002 [#1] PREEMPT SMP PTI
>>  CPU: 1 PID: 15600 Comm: fsstress Not tainted 6.4.0-rc5-xfstests-00055-gd3ab1bca26b4 #190
>>  RIP: 0010:jbd2_journal_set_features+0x13d/0x430
>>  ...
>>  Call Trace:
>>   <TASK>
>>   ? __die+0x23/0x60
>>   ? page_fault_oops+0xa4/0x170
>>   ? exc_page_fault+0x67/0x170
>>   ? asm_exc_page_fault+0x26/0x30
>>   ? jbd2_journal_set_features+0x13d/0x430
>>   jbd2_journal_revoke+0x47/0x1e0
>>   __ext4_forget+0xc3/0x1b0
>>   ext4_free_blocks+0x214/0x2f0
>>   ext4_free_branches+0xeb/0x270
>>   ext4_ind_truncate+0x2bf/0x320
>>   ext4_truncate+0x1e4/0x490
>>   ext4_handle_inode_extension+0x1bd/0x2a0
>>   ? iomap_dio_complete+0xaf/0x1d0
>>
>> The root cause is the journal super block had been failed to write out
>> due to I/O fault injection, it's uptodate bit was cleared by
>> end_buffer_write_sync() and didn't reset yet in jbd2_write_superblock().
>> And it raced by journal_get_superblock()->bh_read(), unfortunately, the
>> read IO is also failed, so the error handling in
>> journal_fail_superblock() unexpectedly clear the journal->j_sb_buffer,
>> finally lead to above NULL pointer dereference issue.
>>
>> If the journal super block had been read and verified, there is no need
>> to call bh_read() read it again even if it has been failed to written
>> out. So the fix could be simply move buffer_verified(bh) in front of
>> bh_read(). Also remove a stale comment left in
>> jbd2_journal_check_used_features().
>>
>> Fixes: 51bacdba23d8 ("jbd2: factor out journal initialization from journal_get_superblock()")
>> Reported-by: Theodore Ts'o <tytso@mit.edu>
>> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> 
> This works as a workaround. It is a bit kludgy but for now I guess it is
> good enough. Thanks for the fix and feel free to add:
> 

Thanks for the review. Yes, I suppose it's better to find a way to adjust
the sequence of journal load and feature checking in ocfs2_check_volume(),
so that we could completely remove the journal_get_superblock() in
jbd2_journal_check_used_features().

Thanks,
Yi.

> 
> 
>> ---
>> v1->v2:
>>  - Remove a stale comment left in jbd2_journal_check_used_features().
>>
>>  fs/jbd2/journal.c | 7 +++----
>>  1 file changed, 3 insertions(+), 4 deletions(-)
>>
>> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
>> index b5e57735ab3f..559242df0f9a 100644
>> --- a/fs/jbd2/journal.c
>> +++ b/fs/jbd2/journal.c
>> @@ -1919,6 +1919,9 @@ static int journal_get_superblock(journal_t *journal)
>>  	bh = journal->j_sb_buffer;
>>  
>>  	J_ASSERT(bh != NULL);
>> +	if (buffer_verified(bh))
>> +		return 0;
>> +
>>  	err = bh_read(bh, 0);
>>  	if (err < 0) {
>>  		printk(KERN_ERR
>> @@ -1926,9 +1929,6 @@ static int journal_get_superblock(journal_t *journal)
>>  		goto out;
>>  	}
>>  
>> -	if (buffer_verified(bh))
>> -		return 0;
>> -
>>  	sb = journal->j_superblock;
>>  
>>  	err = -EINVAL;
>> @@ -2229,7 +2229,6 @@ int jbd2_journal_check_used_features(journal_t *journal, unsigned long compat,
>>  
>>  	if (!compat && !ro && !incompat)
>>  		return 1;
>> -	/* Load journal superblock if it is not loaded yet. */
>>  	if (journal_get_superblock(journal))
>>  		return 0;
>>  	if (!jbd2_format_support_feature(journal))
>> -- 
>> 2.39.2
>>

