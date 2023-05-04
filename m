Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C2586F6A18
	for <lists+linux-ext4@lfdr.de>; Thu,  4 May 2023 13:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbjEDLfz (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 4 May 2023 07:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbjEDLfz (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 4 May 2023 07:35:55 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABB8646B9
        for <linux-ext4@vger.kernel.org>; Thu,  4 May 2023 04:35:37 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QBsFG3m5Vz4f3tqM
        for <linux-ext4@vger.kernel.org>; Thu,  4 May 2023 19:35:30 +0800 (CST)
Received: from [10.174.176.34] (unknown [10.174.176.34])
        by APP2 (Coremail) with SMTP id Syh0CgAXB+WCmFNkk0yPIg--.20397S3;
        Thu, 04 May 2023 19:35:31 +0800 (CST)
Subject: Re: [PATCH] jbd2: recheck chechpointing non-dirty buffer
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, yi.zhang@huawei.com, yukuai3@huawei.com,
        chengzhihao1@huawei.com
References: <20230426131041.1004383-1-yi.zhang@huaweicloud.com>
 <20230503155012.37ysqzd7b6fquulf@quack3>
From:   Zhang Yi <yi.zhang@huaweicloud.com>
Message-ID: <dcb72c9d-001a-e416-b4cb-c78baedcb236@huaweicloud.com>
Date:   Thu, 4 May 2023 19:35:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20230503155012.37ysqzd7b6fquulf@quack3>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: Syh0CgAXB+WCmFNkk0yPIg--.20397S3
X-Coremail-Antispam: 1UD129KBjvJXoWxGFy3GFyxWr4UtFWUAr45trb_yoW5AFWxpr
        Zaga40qr4kGr1xCr1IqF45A3yrtFs7ZrW7Gry5G3ZxA3WF9wsIqry3K3yjkryDKwn3Wa1Y
        vF4UCw13WF4jya7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyCb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
        j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
        kEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAK
        I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
        xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xII
        jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
        0EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF
        7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UWE__UUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 2023/5/3 23:50, Jan Kara wrote:
> On Wed 26-04-23 21:10:41, Zhang Yi wrote:
>> From: Zhang Yi <yi.zhang@huawei.com>
>>
>> There is a long-standing metadata corruption issue that happens from
>> time to time, but it's very difficult to reproduce and analyse, benefit
>> from the JBD2_CYCLE_RECORD option, we found out that the problem is the
>> checkpointing process miss to write out some buffers which are raced by
>> another do_get_write_access(). Looks below for detail.
>>
>> jbd2_log_do_checkpoint() //transaction X
>>  //buffer A is dirty and not belones to any transaction
>>  __buffer_relink_io() //move it to the IO list
>>  __flush_batch()
>>   write_dirty_buffer()
>>                              do_get_write_access()
>>                              clear_buffer_dirty
>>                              __jbd2_journal_file_buffer()
>>                              //add buffer A to a new transaction Y
>>    lock_buffer(bh)
>>    //doesn't write out
>>  __jbd2_journal_remove_checkpoint()
>>  //finish checkpoint except buffer A
>>  //filesystem corrupt if the new transaction Y isn't fully write out.
>>
>> The fix is subtle because we can't trust the chechpointing buffers and
>> transactions once we release the j_list_lock, they could be written back
>> and checkpointed by some others, or they could have been added to a new
>> transaction. So we have to re-add them on the checkpoint list and
>> recheck their status if they are clean and don't need to write out.
>>
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
>> Tested-by: Zhihao Cheng <chengzhihao1@huawei.com>
> 
> Thanks for the analysis. This indeed looks like a nasty issue to debug.  I
> think we can actually solve the problem by simplifying the checkpointing
> code in jbd2_log_do_checkpoint(), not by making it more complex. What I
> think we can do is that we can completely remove the t_checkpoint_io_list
> and only keep buffers on t_checkpoint_list. When processing
> t_checkpoint_list in jbd2_log_do_checkpoint(), we just need to make sure to
> move t_checkpoint_list pointer to the next buffer when adding buffer to
> j_chkpt_bhs array. That way buffers to submit / already submitted buffers
> will be accumulating at the tail of the list. The logic in the loop already
> handles waiting for buffers under IO / removing cleaned buffers so this
> makes sure the list will eventually get empty. Buffers cannot get redirtied
> without being removed from the checkpoint list and moved to a newer
> transaction's checkpoint list so forward progress is guaranteed. The only
> other tweak we need to add is to check for the situation when all the
> buffers are in the j_chkpt_bhs array. So the end of the loop should look
> like:
> 
> 		transaction->t_checkpoint_list = jh->j_cpnext;
> 		if (batch_count == JBD2_NR_BATCH || need_resched() ||
> 		    spin_needbreak(&journal->j_list_lock) ||
> 		    transaction->t_checkpoint_list == journal->j_chkpt_bhs[0])
> 			flush and restart
> 
> and that should be it. What do you think?
> 

This solution sounds great, Let me do it.

Thanks,
Yi.

