Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C14252D288
	for <lists+linux-ext4@lfdr.de>; Thu, 19 May 2022 14:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233518AbiESMdY (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 19 May 2022 08:33:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232842AbiESMdW (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 19 May 2022 08:33:22 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1833340E5
        for <linux-ext4@vger.kernel.org>; Thu, 19 May 2022 05:33:20 -0700 (PDT)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4L3q261FjSzQk8g;
        Thu, 19 May 2022 20:30:22 +0800 (CST)
Received: from [10.174.178.134] (10.174.178.134) by
 canpemm500005.china.huawei.com (7.192.104.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 19 May 2022 20:33:17 +0800
Subject: Re: [PATCH] ext4: fix warning when submitting superblock in
 ext4_commit_super()
To:     Jan Kara <jack@suse.cz>, Ritesh Harjani <ritesh.list@gmail.com>
CC:     <linux-ext4@vger.kernel.org>, <tytso@mit.edu>,
        <adilger.kernel@dilger.ca>, <yukuai3@huawei.com>
References: <20220518141020.2432652-1-yi.zhang@huawei.com>
 <20220518170617.vooz4ycfe73xsszx@riteshh-domain>
 <94e7b5f7-54c8-d04a-3a3a-31768b630862@huawei.com>
 <20220519062929.i52y2mwonnrbvr64@riteshh-domain>
 <20220519093035.2kazqodrv4nqauwf@quack3.lan>
From:   Zhang Yi <yi.zhang@huawei.com>
Message-ID: <87282095-5172-eeb0-e78f-367b19e11db4@huawei.com>
Date:   Thu, 19 May 2022 20:33:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20220519093035.2kazqodrv4nqauwf@quack3.lan>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.134]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500005.china.huawei.com (7.192.104.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 2022/5/19 17:30, Jan Kara wrote:
> On Thu 19-05-22 11:59:29, Ritesh Harjani wrote:
>> On 22/05/19 11:13AM, Zhang Yi wrote:
>>> On 2022/5/19 1:06, Ritesh Harjani wrote:
>>>> On 22/05/18 10:10PM, Zhang Yi wrote:
>>>>> We have already check the io_error and uptodate flag before submitting
>>>>> the superblock buffer, and re-set the uptodate flag if it has been
>>>>> failed to write out. But it was lockless and could be raced by another
>>>>> ext4_commit_super(), and finally trigger '!uptodate' WARNING when
>>>>> marking buffer dirty. Fix it by submit buffer directly.
>>>>
>>>> I agree that there could be a race with multiple processes trying to call
>>>> ext4_commit_super(). Do you have a easy reproducer for this issue?
>>>>
>>>
>>> Sorry, I don't have a easy reproducer, but we can always reproduce it through
>>> inject delay and add filters into the ext4_commit_super().
> 
> ...
>  
>>>> Also do you think something like below should fix the problem too?
>>>> So if you lock the buffer from checking until marking the buffer dirty, that
>>>> should avoid the race too that you are reporting.
>>>> Thoughts?
>>>>
>>>
>>> Thanks for your suggestion. I've thought about this solution and yes it's simpler
>>> to fix the race, but I think we lock and unlock the sbh several times just for
>>> calling standard buffer write helpers is not so good. Opencode the submit
>>> procedure looks more clear to me.
>>
>> I agree your solution was cleaner since it does not has a lot of lock/unlock.
>> My suggestion came in from looking at the history.
>> This lock was added here [1] and I think it somehow got removed in this patch[2]
>>
>> [1]: https://lore.kernel.org/linux-ext4/1467285150-15977-2-git-send-email-pranjas@gmail.com/
>> [2]: https://lore.kernel.org/linux-ext4/20201216101844.22917-5-jack@suse.cz/
> 
> So the reason why I've move unlock_buffer() into ext4_update_super() was
> mostly so that the function does not return with buffer lock (which is an
> odd calling convention) when I was adding another user of it
> (flush_stashed_error_work()).
> 
>> Rather then solutions, I had few queries :)
>> 1. What are the implications of not using
>> mark_buffer_dirty()/__sync_dirty_buffer()
> 
> Not much. Using submit_bh() directly is fine. Just the duplication of the
> checks is somewhat unpleasant.
> 
>> 2. In your solution one thing which I was not clear of, was whether we
>> should call clear_buffer_dirty() before calling submit_bh(), in case if
>> somehow(?) the state of the buffer was already marked dirty? Not sure how
>> this can happen, but I see the logic in mark_buffer_dirty() which checks,
>> if the buffer is already marked dirty, it simply returns. Then
>> __sync_dirty_buffer() clears the buffer dirty state.
> 
> It could happen e.g. if there was journalled update of the superblock
> before. I guess calling clear_buffer_dirty() before submit_bh() does no
> harm.
> 

Thanks for point out and explain, I missed this case. Call clear_buffer_dirty()
before submit_bh() can avoid one more redundant submit by writeback process.

Thanks,
Yi.
