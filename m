Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D470173D8A2
	for <lists+linux-ext4@lfdr.de>; Mon, 26 Jun 2023 09:36:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbjFZHgr (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 26 Jun 2023 03:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjFZHgq (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 26 Jun 2023 03:36:46 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2414A102
        for <linux-ext4@vger.kernel.org>; Mon, 26 Jun 2023 00:36:44 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QqKRC71kTz4f3lfZ
        for <linux-ext4@vger.kernel.org>; Mon, 26 Jun 2023 15:36:39 +0800 (CST)
Received: from [10.174.176.34] (unknown [10.174.176.34])
        by APP2 (Coremail) with SMTP id Syh0CgAXvusHQJlkO8XyMQ--.3208S3;
        Mon, 26 Jun 2023 15:36:40 +0800 (CST)
Subject: Re: [PATCH v3 4/6] jbd2: Fix wrongly judgement for buffer head
 removing while doing checkpoint
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Zhihao Cheng <chengzhihao1@huawei.com>, linux-ext4@vger.kernel.org,
        adilger.kernel@dilger.ca, jack@suse.cz, yi.zhang@huawei.com,
        yukuai3@huawei.com
References: <20230606135928.434610-1-yi.zhang@huaweicloud.com>
 <20230606135928.434610-5-yi.zhang@huaweicloud.com>
 <20230613043120.GB1584772@mit.edu>
 <20002902-39c5-914b-75b0-5a21b5cee25c@huawei.com>
 <20230613172749.GA18303@mit.edu> <20230614054222.GD51259@mit.edu>
 <1033cd3b-e41f-e4e0-c2ee-c4b23979208a@huaweicloud.com>
 <20230614203740.GE51259@mit.edu>
From:   Zhang Yi <yi.zhang@huaweicloud.com>
Message-ID: <22da163b-e6ab-d0b6-af75-ea1c3f4909ec@huaweicloud.com>
Date:   Mon, 26 Jun 2023 15:36:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20230614203740.GE51259@mit.edu>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: Syh0CgAXvusHQJlkO8XyMQ--.3208S3
X-Coremail-Antispam: 1UD129KBjvJXoWxuFW5JryrXry8WrWDtr4Utwb_yoW7XFy5pF
        WfGa43AF4DJr18WFs7Za1UJFW0qw1UAry5GF1rCwn2yay5ZF1IyrZ7KF4FyFyDCrZ3u34F
        qF4UX34UCw1jkaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
        xK8VAvwI8IcIk0rVW3JVWrJr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY
        1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1zuWJUUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 2023/6/15 4:37, Theodore Ts'o wrote:
> On Wed, Jun 14, 2023 at 09:25:28PM +0800, Zhang Yi wrote:
>>
>> Sorry about the regression, I found that this issue is not introduced
>> by the first patch in this patch series ("jbd2: recheck chechpointing
>> non-dirty buffer"), is d9eafe0afafa ("jbd2: factor out journal
>> initialization from journal_get_superblock()") [1] on your dev branch.
>>
>> The problem is the journal super block had been failed to write out
>> due to IO fault, it's uptodate bit was cleared by
>> end_buffer_write_syn() and didn't reset yet in jbd2_write_superblock().
>> And it raced by jbd2_journal_revoke()->jbd2_journal_set_features()->
>> jbd2_journal_check_used_features()->journal_get_superblock()->bh_read(),
>> unfortunately, the read IO is also fail, so the error handling in
>> journal_fail_superblock() clear the journal->j_sb_buffer, finally lead
>> to above NULL pointer dereference issue.
> 
> Thanks for looking into this.  What I believe you are saying is that
> the root cause is that earlier patch, but it is still something about
> the patch "jbd2: recheck chechpointing non-dirty buffer" which is
> changing the timing enough that we're hitting this buffer (because
> without the "recheck checkpointing" patch, I'm not seeing the NULL
> pointer dereference.
> 
> As far as the e2fsck bug that was causing it to hang in the ext4/adv
> test scenario, the patch was a simple one, and I have also checked in
> a test case which was a reliable reproducer of the problem.  (See
> attached for the patches and more detail.)
> 
> It is really interesting that "recheck checkpointing" patch is making
> enough of a difference that it is unmasking these bugs.  If you could
> take a look at these changes and perhaps think about how this patch
> series could be changing the nature of the corruption (specifically,
> how symlink inodes referenced from inline directories could be
> corupted with "rechecking checkpointing", thus unmasking the
> e2fsprogs, I'd really appreciate it.
> 

Hello Ted.

I have found the root cause of which trigger the e2fsck bug, it's a
real kernel bug which was introduced in 5b849b5f96b4 ("jbd2: fast
commit recovery path") when merging fast commit feature.

The problem is that when fast commit is enabled, kernel doesn't replay
the journal completely at mount time (there a bug in do_one_pass(),
see below for details) if the unrecovered transactions loop back to
the head of the normal journal area. If the missing transactions
contain a symlink block revoke record and a reuse record of the same
block, and the reuse record have been write back to the disk before
it's last umount, it could trigger the "Symlink xxx is invalid" after
the incomplete journal replay. Meanwhile it the symlink belongs to a
inline directory, it will trigger the e2fsck bug.

For example, we have a not cleaned image below.


 | normal journal area                             | fast commit area |
 +-------------------------------------------------+------------------+
 | tX+1(rere half)|tX+2|...| tX | tX+1(front half) |       ....       |
 +-------------------------------------------------+------------------+
                       /        /                  /                  /
             (real head)  s_start    journal->j_last journal->j_fc_last

Transaction X(checkpointed):
 - Create symlink 'foo' (use block A, contain 500 length of link name)
   in inline directory 'dir';
Transaction X+1(uncheckpoint):
 - Remove symlink 'foo' (block A is also freed);
Transaction X+2(uncheckpoint):
 - Create symlink 'bar' (reuse block A, contain 400 length of link
   name).

The above transactions are recorded to the journal, block A is also
successfully written back by the background write-back process.

If fast_commit feature is enabled, the journal->j_last point to the
first unused block behind the normal journal area instead of the whole
log area, and the journal->j_fc_last point to the first unused block
behind the fast_commit journal area. While doing journal recovery,
do_one_pass(PASS_SCAN) should first scan tX+1 in the normal journal
area and turn around to the first block once it meet journal->j_last,
but the wrap() macro misuse the journal->j_fc_last, so it could not
read tX+1's commit block, the recovery quit early mistakenly and
missing tX+1 and tX+2. So, after we mount the filesystem, we could
leftover an invalid symlink 'foo' in the inline directory and trigger
issue.

I can reproduce this issue either with or without this patch series
("jbd2: recheck chechpointing non-dirty buffer"), sometimes it takes
longer, sometimes it takes less. It's easy to reproduce the "Symlink
xxx is invalid" issue, but it's a little hard to trigger the e2fsck
bug (which means the invalid symlink should in a inline dir).
Especially I could 100% reproduce the fast_commit recovery bug when
running generic/475. So I couldn't find any relations between this
issue and this patch series.

I've send a patch to fix the fast commit bug separately[1]. I cannot
reproduce this issue again with this patch, please take a look at
that.

[1] https://lore.kernel.org/linux-ext4/20230626073322.3956567-1-yi.zhang@huaweicloud.com/T/#u

Thanks,
Yi.

