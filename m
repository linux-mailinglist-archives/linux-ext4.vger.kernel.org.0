Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17E40719E96
	for <lists+linux-ext4@lfdr.de>; Thu,  1 Jun 2023 15:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232140AbjFANpH (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 1 Jun 2023 09:45:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233948AbjFANpF (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 1 Jun 2023 09:45:05 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6C4318F
        for <linux-ext4@vger.kernel.org>; Thu,  1 Jun 2023 06:45:00 -0700 (PDT)
Received: from kwepemm600013.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4QX6hJ3dVYz18LXB;
        Thu,  1 Jun 2023 21:40:16 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 1 Jun 2023 21:44:55 +0800
Subject: Re: [PATCH 4/5] jbd2: Fix wrongly judgement for buffer head removing
 while doing checkpoint
To:     Jan Kara <jack@suse.cz>, Zhang Yi <yi.zhang@huaweicloud.com>
CC:     <linux-ext4@vger.kernel.org>, <tytso@mit.edu>,
        <adilger.kernel@dilger.ca>, <yi.zhang@huawei.com>,
        <yukuai3@huawei.com>
References: <20230531115100.2779605-1-yi.zhang@huaweicloud.com>
 <20230531115100.2779605-5-yi.zhang@huaweicloud.com>
 <20230601094156.m4b7rxntmaxc5zy7@quack3>
From:   Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <d73ecd71-cb4f-921f-2284-d756c68e084c@huawei.com>
Date:   Thu, 1 Jun 2023 21:44:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20230601094156.m4b7rxntmaxc5zy7@quack3>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.46]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600013.china.huawei.com (7.193.23.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

ÔÚ 2023/6/1 17:41, Jan Kara Ð´µÀ:

Hi, Jan
> On Wed 31-05-23 19:50:59, Zhang Yi wrote:
>> From: Zhihao Cheng <chengzhihao1@huawei.com>
>>
>> Following process,
>>
>> jbd2_journal_commit_transaction
>> // there are several dirty buffer heads in transaction->t_checkpoint_list
>>            P1                   wb_workfn
>> jbd2_log_do_checkpoint
>>   if (buffer_locked(bh)) // false
>>                              __block_write_full_page
>>                               trylock_buffer(bh)
>>                               test_clear_buffer_dirty(bh)
>>   if (!buffer_dirty(bh))
>>    __jbd2_journal_remove_checkpoint(jh)
>>     if (buffer_write_io_error(bh)) // false
>>                               >> bh IO error occurs <<
>>   jbd2_cleanup_journal_tail
>>    __jbd2_update_log_tail
>>     jbd2_write_superblock
>>     // The bh won't be replayed in next mount.
>> , which could corrupt the ext4 image, fetch a reproducer in [Link].
>>
>> Since writeback process clears buffer dirty after locking buffer head,
>> we can fix it by checking buffer dirty firstly and then checking buffer
>> locked, the buffer head can be removed if it is neither dirty nor locked.
>>
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=217490
>> Fixes: 470decc613ab ("[PATCH] jbd2: initial copy of files from jbd")
>> Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
>> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> 
> OK, the analysis is correct but I'm afraid the fix won't be that easy.  The
> reordering of tests you did below doesn't really help because CPU or the
> compiler are free to order the loads (and stores) in whatever way they
> wish. You'd have to use memory barriers when reading and modifying bh flags
> (although the modification side is implicitely handled by the bitlock
> code) to make this work reliably. But that is IMHO too subtle for this
> code.
> 

Do you mean there might be a sequence like following:

jbd2_log_do_checkpoint
  if (buffer_dirty(bh))
  else if (buffer_locked(bh))
  else
    __jbd2_journal_remove_checkpoint(jh)

CPU re-arranges the order of getting buffer state.
reg_1 = buffer_locked(bh)  // false
                            lock_buffer(bh)
                            clear_buffer(bh)
reg_2 = buffer_dirty(bh)   // false

Then, jbd2_log_do_checkpoint() could become:
if (reg_2)
else if (reg_1)
else
   __jbd2_journal_remove_checkpoint(jh)  // enter !

Am I understanding right?

> What we should be doing to avoid these races is to lock the bh. So
> something like:
> 
> 	if (jh->b_transaction != NULL) {
> 		do stuff
> 	}
> 	if (!trylock_buffer(bh)) {
> 		buffer_locked() branch
> 	}
> 	... Now we have the buffer locked and can safely check for dirtyness
> 
> And we need to do a similar treatment for journal_clean_one_cp_list() and
> journal_shrink_one_cp_list().
> 
> BTW, I think we could merge journal_clean_one_cp_list() and
> journal_shrink_one_cp_list() into a single common function. I think we can
> drop the nr_to_scan argument and just always cleanup the whole checkpoint
> list and return the number of freed buffers. That way we have one less
> function to deal with checkpoint list cleaning.
> 
> Thinking about it some more maybe we can have a function like:
> 
> int jbd2_try_remove_checkpoint(struct journal_head *jh)
> {
> 	struct buffer_head *bh = jh2bh(jh);
> 
> 	if (!trylock_buffer(bh) || buffer_dirty(bh))
> 		return -EBUSY;
> 	/*
> 	 * Buffer is clean and the IO has finished (we hold the buffer lock) so
> 	 * the checkpoint is done. We can safely remove the buffer from this
> 	 * transaction.
> 	 */
> 	unlock_buffer(bh);
> 	return __jbd2_journal_remove_checkpoint(jh);
> }
> 
> and that can be used with a bit of care in the checkpointing functions as
> well as in jbd2_journal_forget(), __journal_try_to_free_buffer(),
> journal_unmap_buffer().
> 
> 								Honza
> 

