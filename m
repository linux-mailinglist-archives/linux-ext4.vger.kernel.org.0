Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B7755F9BD3
	for <lists+linux-ext4@lfdr.de>; Mon, 10 Oct 2022 11:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbiJJJ0z (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 10 Oct 2022 05:26:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230509AbiJJJ0y (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 10 Oct 2022 05:26:54 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA28458094
        for <linux-ext4@vger.kernel.org>; Mon, 10 Oct 2022 02:26:52 -0700 (PDT)
Received: from dggpeml500022.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MmD2q0fCHzVj6F;
        Mon, 10 Oct 2022 17:22:27 +0800 (CST)
Received: from dggpeml500016.china.huawei.com (7.185.36.70) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 10 Oct 2022 17:26:50 +0800
Received: from [10.174.176.102] (10.174.176.102) by
 dggpeml500016.china.huawei.com (7.185.36.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 10 Oct 2022 17:26:50 +0800
Message-ID: <99a2b3c4-db7d-a949-a4f3-cc462b72de8b@huawei.com>
Date:   Mon, 10 Oct 2022 17:26:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [bug report] misc/fsck.c: Processes may kill other processes.
To:     Karel Zak <kzak@redhat.com>, Lukas Czerner <lczerner@redhat.com>
CC:     Theodore Ts'o <tytso@mit.edu>, <linux-ext4@vger.kernel.org>,
        <liuzhiqiang26@huawei.com>, linfeilong <linfeilong@huawei.com>
References: <4ffe3143-fc53-7178-cf44-f3481eb96ae4@huawei.com>
 <20220929112813.6aqtktwaff2m7fh2@fedora>
 <470ea2ee-54fd-3dd5-2500-36fb82665c11@huawei.com>
 <20220930072042.dwakvbnefctk2jyd@fedora>
 <20221010080944.u447ovrfpmpjwj6q@ws.net.home>
From:   zhanchengbin <zhanchengbin1@huawei.com>
In-Reply-To: <20221010080944.u447ovrfpmpjwj6q@ws.net.home>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.102]
X-ClientProxiedBy: dggpeml100015.china.huawei.com (7.185.36.168) To
 dggpeml500016.china.huawei.com (7.185.36.70)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



在 2022/10/10 16:09, Karel Zak 写道:
> On Fri, Sep 30, 2022 at 09:20:42AM +0200, Lukas Czerner wrote:
>> On Fri, Sep 30, 2022 at 09:42:52AM +0800, zhanchengbin wrote:
>>>
>>>
>>> On 2022/9/29 19:28, Lukas Czerner wrote:
>>>> Hi,
>>>>
>>>> indeed we'd like to avoid killing the instance that was not ran because
>>>> of noexecute. Can you try the following patch?
>>>>
>>>> Thanks!
>>>> -Lukas
>>>
>>> Yes, you're right, I think we can fix it in this way.
>>>
>>> diff --git a/misc/fsck.c b/misc/fsck.c
>>> index 1f6ec7d9..91edbf17 100644
>>> --- a/misc/fsck.c
>>> +++ b/misc/fsck.c
>>> @@ -547,6 +547,8 @@ static int kill_all(int signum)
>>>          for (inst = instance_list; inst; inst = inst->next) {
>>>                  if (inst->flags & FLAG_DONE)
>>>                          continue;
>>> +               if (inst->pid == -1)
>>> +                       continue;
>>
>> Yeah, that works as well although I find the "if (noexecute)" condition
>> more obvious. We can do both. Also rather than checking for -1 we can
>> check for <= 0 since anything other than real pid at this point is a bug.
>>
>> Feel free to send a proper patch.
> 
> Yes, please. It would be nice to have the same solution in the both
> (e2fsprogs and util-linux) trees.

Ok, I have sent the patch, please review it.

  -zhanchengbin
> 
>      Karel
> 
