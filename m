Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC6D3719FAD
	for <lists+linux-ext4@lfdr.de>; Thu,  1 Jun 2023 16:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233777AbjFAOVA (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 1 Jun 2023 10:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233927AbjFAOUy (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 1 Jun 2023 10:20:54 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C04F98
        for <linux-ext4@vger.kernel.org>; Thu,  1 Jun 2023 07:20:46 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QX7Zx4hfKz4f3jJB
        for <linux-ext4@vger.kernel.org>; Thu,  1 Jun 2023 22:20:41 +0800 (CST)
Received: from [10.174.176.34] (unknown [10.174.176.34])
        by APP2 (Coremail) with SMTP id Syh0CgBnW+k2qXhkYdlsKg--.47315S3;
        Thu, 01 Jun 2023 22:20:40 +0800 (CST)
Subject: Re: [PATCH 4/5] jbd2: Fix wrongly judgement for buffer head removing
 while doing checkpoint
To:     Zhihao Cheng <chengzhihao1@huawei.com>, Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, yi.zhang@huawei.com, yukuai3@huawei.com
References: <20230531115100.2779605-1-yi.zhang@huaweicloud.com>
 <20230531115100.2779605-5-yi.zhang@huaweicloud.com>
 <20230601094156.m4b7rxntmaxc5zy7@quack3>
 <d73ecd71-cb4f-921f-2284-d756c68e084c@huawei.com>
From:   Zhang Yi <yi.zhang@huaweicloud.com>
Message-ID: <ee706b3e-2a87-fa1a-570b-64870d5e49ad@huaweicloud.com>
Date:   Thu, 1 Jun 2023 22:20:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <d73ecd71-cb4f-921f-2284-d756c68e084c@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgBnW+k2qXhkYdlsKg--.47315S3
X-Coremail-Antispam: 1UD129KBjvJXoWxtr47KFWrCrWUGw47Zry8AFb_yoWxWF13pr
        95KFyUKrWDGr1kAr12qF45JryUJFnrXw1UGFyUXFyxAr4UAr1aqryUXr1qgr1UJrs7Ww45
        Jr1UWryxur1jkwUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 2023/6/1 21:44, Zhihao Cheng wrote:
> 在 2023/6/1 17:41, Jan Kara 写道:
> 
> Hi, Jan
>> On Wed 31-05-23 19:50:59, Zhang Yi wrote:
>>> From: Zhihao Cheng <chengzhihao1@huawei.com>
>>>
>>> Following process,
>>>
>>> jbd2_journal_commit_transaction
>>> // there are several dirty buffer heads in transaction->t_checkpoint_list
>>>            P1                   wb_workfn
>>> jbd2_log_do_checkpoint
>>>   if (buffer_locked(bh)) // false
>>>                              __block_write_full_page
>>>                               trylock_buffer(bh)
>>>                               test_clear_buffer_dirty(bh)
>>>   if (!buffer_dirty(bh))
>>>    __jbd2_journal_remove_checkpoint(jh)
>>>     if (buffer_write_io_error(bh)) // false
>>>                               >> bh IO error occurs <<
>>>   jbd2_cleanup_journal_tail
>>>    __jbd2_update_log_tail
>>>     jbd2_write_superblock
>>>     // The bh won't be replayed in next mount.
>>> , which could corrupt the ext4 image, fetch a reproducer in [Link].
>>>
>>> Since writeback process clears buffer dirty after locking buffer head,
>>> we can fix it by checking buffer dirty firstly and then checking buffer
>>> locked, the buffer head can be removed if it is neither dirty nor locked.
>>>
>>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=217490
>>> Fixes: 470decc613ab ("[PATCH] jbd2: initial copy of files from jbd")
>>> Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
>>> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
>>
>> OK, the analysis is correct but I'm afraid the fix won't be that easy.  The
>> reordering of tests you did below doesn't really help because CPU or the
>> compiler are free to order the loads (and stores) in whatever way they
>> wish. You'd have to use memory barriers when reading and modifying bh flags
>> (although the modification side is implicitely handled by the bitlock
>> code) to make this work reliably. But that is IMHO too subtle for this
>> code.
>>
> 

I write two litmus-test files in tools/memory-model to check the memory module
of these two cases as jbd2_log_do_checkpoint() and __cp_buffer_busy() does.

**1. test-ww-rr.litmus**  //simulate our changes in jbd2_log_do_checkpoint()

  C WW-RR

  (*
   * Result: Never
   *
   * This test shows that write-write ordering
   * (in P0()) is visible to external process P2().
   *
   * bit 0: lock
   * bit 1: dirty
   *)

  {
          x=2;
  }

  P0(int *x)
  {
          int r1;

          r1 = READ_ONCE(*x);
          r1 = r1 | 1;  //lock
          WRITE_ONCE(*x, r1);

          r1 = READ_ONCE(*x);
          r1 = r1 & 253;  //&~2, clear dirty
          WRITE_ONCE(*x, r1);
  }

  P1(int *x)
  {
          int r0;
          int r1;

          r0 = READ_ONCE(*x);
          r1 = READ_ONCE(*x);
  }

  exists (1:r1=2 /\ 1:r0=1)

The test results are:

  $ herd7 -conf linux-kernel.cfg litmus-tests/test-ww-rr.litmus
  Test WW-RR Allowed
  States 6
  1:r0=1; 1:r1=1;
  1:r0=2; 1:r1=1;
  1:r0=2; 1:r1=2;
  1:r0=2; 1:r1=3;
  1:r0=3; 1:r1=1;
  1:r0=3; 1:r1=3;
  No
  Witnesses
  Positive: 0 Negative: 6
  Condition exists (1:r1=2 /\ 1:r0=1)
  Observation WW-RR Never 0 6
  Time WW-RR 0.02
  Hash=d91ecee2379f8ac878b8d06f17967874

**2. test-ww-r.litmus**  //simulate our changes in __cp_buffer_busy()

  C WW-R

  (*
   * Result: Never
   *
   * This test shows that write-write ordering
   * (in P0()) is visible to external process P2().
   *
   * bit 0: lock
   * bit 1: dirty
   *)

  {
          x=2;
  }

  P0(int *x)
  {
          int r1;

          r1 = READ_ONCE(*x);
          r1 = r1 | 1;  //lock
          WRITE_ONCE(*x, r1);

          r1 = READ_ONCE(*x);
          r1 = r1 & 253;  //&~2, clear dirty
          WRITE_ONCE(*x, r1);
  }

  P1(int *x)
  {
          int r0;

          r0 = READ_ONCE(*x);
  }

  exists (1:r0=0)

The test results are:

  $ herd7 -conf linux-kernel.cfg litmus-tests/test-ww-r.litmus
  Test WW-R Allowed
  States 3
  1:r0=1;
  1:r0=2;
  1:r0=3;
  No
  Witnesses
  Positive: 0 Negative: 3
  Condition exists (1:r0=0)
  Observation WW-R Never 0 3
  Time WW-R 0.01
  Hash=d76bb39c367dc0cbd0c363a87c6c9eb7

So it looks like the out-of-order situation cannot happen, am I miss something?

Thanks,
Yi.

> Do you mean there might be a sequence like following:
> 
> jbd2_log_do_checkpoint
>  if (buffer_dirty(bh))
>  else if (buffer_locked(bh))
>  else
>    __jbd2_journal_remove_checkpoint(jh)
> 
> CPU re-arranges the order of getting buffer state.
> reg_1 = buffer_locked(bh)  // false
>                            lock_buffer(bh)
>                            clear_buffer(bh)
> reg_2 = buffer_dirty(bh)   // false
> 
> Then, jbd2_log_do_checkpoint() could become:
> if (reg_2)
> else if (reg_1)
> else
>   __jbd2_journal_remove_checkpoint(jh)  // enter !
> 
> Am I understanding right?
> 
>> What we should be doing to avoid these races is to lock the bh. So
>> something like:
>>
>>     if (jh->b_transaction != NULL) {
>>         do stuff
>>     }
>>     if (!trylock_buffer(bh)) {
>>         buffer_locked() branch
>>     }
>>     ... Now we have the buffer locked and can safely check for dirtyness
>>
>> And we need to do a similar treatment for journal_clean_one_cp_list() and
>> journal_shrink_one_cp_list().
>>
>> BTW, I think we could merge journal_clean_one_cp_list() and
>> journal_shrink_one_cp_list() into a single common function. I think we can
>> drop the nr_to_scan argument and just always cleanup the whole checkpoint
>> list and return the number of freed buffers. That way we have one less
>> function to deal with checkpoint list cleaning.
>>
>> Thinking about it some more maybe we can have a function like:
>>
>> int jbd2_try_remove_checkpoint(struct journal_head *jh)
>> {
>>     struct buffer_head *bh = jh2bh(jh);
>>
>>     if (!trylock_buffer(bh) || buffer_dirty(bh))
>>         return -EBUSY;
>>     /*
>>      * Buffer is clean and the IO has finished (we hold the buffer lock) so
>>      * the checkpoint is done. We can safely remove the buffer from this
>>      * transaction.
>>      */
>>     unlock_buffer(bh);
>>     return __jbd2_journal_remove_checkpoint(jh);
>> }
>>
>> and that can be used with a bit of care in the checkpointing functions as
>> well as in jbd2_journal_forget(), __journal_try_to_free_buffer(),
>> journal_unmap_buffer().
>>
>>                                 Honza
>>

