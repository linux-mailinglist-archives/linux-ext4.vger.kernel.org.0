Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBF8B71F833
	for <lists+linux-ext4@lfdr.de>; Fri,  2 Jun 2023 03:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbjFBBxI (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 1 Jun 2023 21:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233179AbjFBBxH (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 1 Jun 2023 21:53:07 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC3D3C0
        for <linux-ext4@vger.kernel.org>; Thu,  1 Jun 2023 18:53:05 -0700 (PDT)
Received: from kwepemm600013.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4QXQrR4S8sz18Lnv;
        Fri,  2 Jun 2023 09:48:23 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 2 Jun 2023 09:53:03 +0800
Subject: Re: [PATCH 4/5] jbd2: Fix wrongly judgement for buffer head removing
 while doing checkpoint
To:     Jan Kara <jack@suse.cz>, Zhang Yi <yi.zhang@huaweicloud.com>
CC:     <linux-ext4@vger.kernel.org>, <tytso@mit.edu>,
        <adilger.kernel@dilger.ca>, <yi.zhang@huawei.com>,
        <yukuai3@huawei.com>
References: <20230531115100.2779605-1-yi.zhang@huaweicloud.com>
 <20230531115100.2779605-5-yi.zhang@huaweicloud.com>
 <20230601094156.m4b7rxntmaxc5zy7@quack3>
 <d73ecd71-cb4f-921f-2284-d756c68e084c@huawei.com>
 <ee706b3e-2a87-fa1a-570b-64870d5e49ad@huaweicloud.com>
 <20230601163121.jjdo4f2xfpfx6dzi@quack3>
From:   Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <9d8555fd-818f-24af-1324-0135a79b086f@huawei.com>
Date:   Fri, 2 Jun 2023 09:52:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20230601163121.jjdo4f2xfpfx6dzi@quack3>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.46]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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

在 2023/6/2 0:31, Jan Kara 写道:
> On Thu 01-06-23 22:20:38, Zhang Yi wrote:
>> On 2023/6/1 21:44, Zhihao Cheng wrote:
>>> 在 2023/6/1 17:41, Jan Kara 写道:
>>>
>>> Hi, Jan
>>>> On Wed 31-05-23 19:50:59, Zhang Yi wrote:
>>>>> From: Zhihao Cheng <chengzhihao1@huawei.com>
>>>>>
>>>>> Following process,
>>>>>
>>>>> jbd2_journal_commit_transaction
>>>>> // there are several dirty buffer heads in transaction->t_checkpoint_list
>>>>>             P1                   wb_workfn
>>>>> jbd2_log_do_checkpoint
>>>>>    if (buffer_locked(bh)) // false
>>>>>                               __block_write_full_page
>>>>>                                trylock_buffer(bh)
>>>>>                                test_clear_buffer_dirty(bh)
>>>>>    if (!buffer_dirty(bh))
>>>>>     __jbd2_journal_remove_checkpoint(jh)
>>>>>      if (buffer_write_io_error(bh)) // false
>>>>>                                >> bh IO error occurs <<
>>>>>    jbd2_cleanup_journal_tail
>>>>>     __jbd2_update_log_tail
>>>>>      jbd2_write_superblock
>>>>>      // The bh won't be replayed in next mount.
>>>>> , which could corrupt the ext4 image, fetch a reproducer in [Link].
>>>>>
>>>>> Since writeback process clears buffer dirty after locking buffer head,
>>>>> we can fix it by checking buffer dirty firstly and then checking buffer
>>>>> locked, the buffer head can be removed if it is neither dirty nor locked.
>>>>>
>>>>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=217490
>>>>> Fixes: 470decc613ab ("[PATCH] jbd2: initial copy of files from jbd")
>>>>> Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
>>>>> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
>>>>
>>>> OK, the analysis is correct but I'm afraid the fix won't be that easy.  The
>>>> reordering of tests you did below doesn't really help because CPU or the
>>>> compiler are free to order the loads (and stores) in whatever way they
>>>> wish. You'd have to use memory barriers when reading and modifying bh flags
>>>> (although the modification side is implicitely handled by the bitlock
>>>> code) to make this work reliably. But that is IMHO too subtle for this
>>>> code.
>>>>
>>>
>>
>> I write two litmus-test files in tools/memory-model to check the memory module
>> of these two cases as jbd2_log_do_checkpoint() and __cp_buffer_busy() does.
> 
> <snip litmus tests>
> 
>> So it looks like the out-of-order situation cannot happen, am I miss something?
> 
> After thinking about it a bit, indeed CPU cannot reorder the two loads
> because they are from the same location in memory. Thanks for correcting me
> on this. I'm not sure whether a C compiler still could not reorder the
> tests - technically I suspect the C standard does not forbid this although
> it would have to be really evil compiler to do this.
> 
> But still I think with the helper function I've suggested things are much
> more obviously correct.

Thanks for suggestions, we will modify it in next iteration.
