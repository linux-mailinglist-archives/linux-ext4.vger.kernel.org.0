Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 034506C2776
	for <lists+linux-ext4@lfdr.de>; Tue, 21 Mar 2023 02:29:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbjCUB3t (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 20 Mar 2023 21:29:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbjCUB3q (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 20 Mar 2023 21:29:46 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC1D52068D;
        Mon, 20 Mar 2023 18:29:42 -0700 (PDT)
Received: from kwepemm600013.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4PgYpz13V6znYSS;
        Tue, 21 Mar 2023 09:26:35 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 21 Mar 2023 09:29:39 +0800
Subject: Re: [PATCH] ext4: Fix i_disksize exceeding i_size problem in
 paritally written case
To:     Jan Kara <jack@suse.cz>
CC:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.com>,
        <tudor.ambarus@linaro.org>, <linux-ext4@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>
References: <20230317013553.1009553-1-chengzhihao1@huawei.com>
 <20230317124513.drx3wywcjnap5jme@quack3>
 <884950ac-e60a-d331-9f68-310ab81ee595@huawei.com>
 <71990726-c677-34df-d29b-a0fec1a6f68c@huawei.com>
 <20230320112038.3q2eqpv6xsmj22br@quack3>
 <48deeadf-05cd-3535-a589-907cfa252799@huawei.com>
 <20230320162446.vkqsxxcsmv4cacwa@quack3>
From:   Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <60c01340-d7f5-ad20-4d5f-2c473de459cc@huawei.com>
Date:   Tue, 21 Mar 2023 09:29:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20230320162446.vkqsxxcsmv4cacwa@quack3>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.46]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600013.china.huawei.com (7.193.23.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

> On Mon 20-03-23 20:49:07, Zhihao Cheng wrote:
>> [...]
>>
>>>> BTW, I want send another patch as follows:
>>>> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
>>>> index bf0b7dea4900..570a687ae847 100644
>>>> --- a/fs/ext4/inode.c
>>>> +++ b/fs/ext4/inode.c
>>>> @@ -3149,7 +3149,7 @@ static int ext4_da_write_end(struct file *file,
>>>>                   return ext4_write_inline_data_end(inode, pos, len, copied,
>>>> page);
>>>>
>>>>           start = pos & (PAGE_SIZE - 1);
>>>> -       end = start + copied - 1;
>>>> +       end = start + (copied ? copied - 1 : copied);
>>>>
>>>>           /*
>>>>            * Since we are holding inode lock, we are sure i_disksize <=
>>>> @@ -3167,7 +3167,7 @@ static int ext4_da_write_end(struct file *file,
>>>>            * ext4_da_write_inline_data_end().
>>>>            */
>>>>           new_i_size = pos + copied;
>>>> -       if (copied && new_i_size > inode->i_size &&
>>>> +       if (new_i_size > inode->i_size &&
>>>>               ext4_da_should_update_i_disksize(page, end))
>>>>                   ext4_update_i_disksize(inode, new_i_size);
>>>>
>>>> This modification handle unconsistent i_size and i_disksize imported by
>>>> ea51d132dbf9 ("ext4: avoid hangs in ext4_da_should_update_i_disksize()").
>>>>
>>>> Paritially written may display a fake inode size for user, for example:
>>>>
>>>>
>>>>
>>>> i_disksize=1
>>>>
>>>> generic_perform_write
>>>>
>>>>    copied = iov_iter_copy_from_user_atomic(len) // copied = 0
>>>>
>>>>    ext4_da_write_end // skip updating i_disksize
>>>>
>>>>    generic_write_end
>>>>
>>>>     if (pos + copied > inode->i_size) {  // 10 + 0 > 1, true
>>>>
>>>>      i_size_write(inode, pos + copied);  // i_size = 10
>>>>
>>>>     }
>>>>
>>>>
>>>>
>>>>      0 1      10                4096
>>>>
>>>>      |_|_______|_________..._____|
>>>>
>>>>        |       |
>>>>
>>>>       i_size  pos
>>>>
>>>>
>>>>
>>>> Now, user see the i_size is 10 (i_disksize is still 1). After inode
>>>>
>>>> destroyed, user will get the i_size is 1 read from disk.
>>>
>>> OK, but shouldn't we rather change generic_write_end() to not increase
>>> i_size if no write happened? Because that is what seems somewhat
>>> problematic...
>>>
>>> 								Honza
>>>
>>
>> After looking through some code, I find some other places have similar
>> problem:
>> 1. In ext4_write_end(), i_size is updated by ext4 not generic_write_end().
>> 2. The iommap framework, i_size is updated even copied is zero.
>> 3. ubifs_write_end, i_size is updated even copied is zero.
>>
>> It seems that fixing all places is not an easy work.
> 
> Well, yeah, probably not trivial but still desirable ;). Will you look into
> that?
> 
> 								Honza
> 


I'am happy to investigate it, maybe it will take some time, and I'm also 
glad to help review code if somebody come up a solution firstly.
