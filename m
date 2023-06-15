Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90370730DCC
	for <lists+linux-ext4@lfdr.de>; Thu, 15 Jun 2023 05:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241570AbjFOD4f (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 14 Jun 2023 23:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242320AbjFOD40 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 14 Jun 2023 23:56:26 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F6BB272B
        for <linux-ext4@vger.kernel.org>; Wed, 14 Jun 2023 20:56:18 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QhT3y0tyPz4f3mVc
        for <linux-ext4@vger.kernel.org>; Thu, 15 Jun 2023 11:56:14 +0800 (CST)
Received: from [10.174.176.34] (unknown [10.174.176.34])
        by APP2 (Coremail) with SMTP id Syh0CgDHtOLdi4pk3VyeLg--.11425S3;
        Thu, 15 Jun 2023 11:56:15 +0800 (CST)
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
Message-ID: <4e82b97c-137f-52d0-da11-555184fe01f5@huaweicloud.com>
Date:   Thu, 15 Jun 2023 11:56:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20230614203740.GE51259@mit.edu>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: Syh0CgDHtOLdi4pk3VyeLg--.11425S3
X-Coremail-Antispam: 1UD129KBjvJXoW7KryrJw13XFW8AFWxuFWUtwb_yoW8KFWrpr
        Z3Ka4F9FWDJr1UGFn2qF1UAF1Y934jy345Gr1rGwsrZay5uF1IgryftF45Ca98urZ3W3Wa
        qF4UWayfur1j93DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
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

I have send out a separate patch names "jbd2: skip reading super block
if it has been verified" to fix above NULL pointer dereference issue, I
have been runing ext3 generic/475 about 12hours and have not reproduced
the problem again (I will also do more tests later). Please take a look
at it.

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

Sure, we will take a look at it for details.

Thanks,
Yi.

