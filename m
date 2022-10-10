Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F6D05F9B11
	for <lists+linux-ext4@lfdr.de>; Mon, 10 Oct 2022 10:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbiJJIcj (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 10 Oct 2022 04:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231162AbiJJIci (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 10 Oct 2022 04:32:38 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8089161715
        for <linux-ext4@vger.kernel.org>; Mon, 10 Oct 2022 01:32:35 -0700 (PDT)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MmBr96qsFzVhxF;
        Mon, 10 Oct 2022 16:28:09 +0800 (CST)
Received: from dggpeml500016.china.huawei.com (7.185.36.70) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 10 Oct 2022 16:32:33 +0800
Received: from [10.174.176.102] (10.174.176.102) by
 dggpeml500016.china.huawei.com (7.185.36.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 10 Oct 2022 16:32:33 +0800
Message-ID: <64352d65-dc3e-69ee-cd96-0440a32709d3@huawei.com>
Date:   Mon, 10 Oct 2022 16:32:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] misc/fsck.c: Processes may kill other processes.
To:     Lukas Czerner <lczerner@redhat.com>
CC:     Theodore Ts'o <tytso@mit.edu>, <linux-ext4@vger.kernel.org>,
        <liuzhiqiang26@huawei.com>, linfeilong <linfeilong@huawei.com>
References: <01783b8c-2a39-73ec-c537-cc1df82643e2@huawei.com>
 <20221010071725.ghflyqxj7poqlwtq@fedora>
From:   zhanchengbin <zhanchengbin1@huawei.com>
In-Reply-To: <20221010071725.ghflyqxj7poqlwtq@fedora>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.102]
X-ClientProxiedBy: dggpeml100017.china.huawei.com (7.185.36.161) To
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



On 2022/10/10 15:17, Lukas Czerner wrote:
> On Sat, Oct 08, 2022 at 11:05:48AM +0800, zhanchengbin wrote:
>> If run the fsck -N command, processes don't execute, just show what
>> would be done. However, the pid whose value is -1 is added to the
>> instance_list list in the execute function,if the kill_all function
>> is called later, kill(-1, signum) is executed, Signals are sent to
>> all processes except the number one process and itself. Other
>> processes will be killed if they use the default signal processing
>> function.
>>
>> Signed-off-by: zhanchengbin <zhanchengbin1@huawei.com>
>> ---
>>   misc/fsck.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/misc/fsck.c b/misc/fsck.c
>> index 4efe10ec..faf7789d 100644
>> --- a/misc/fsck.c
>> +++ b/misc/fsck.c
>> @@ -546,6 +546,8 @@ static int kill_all(int signum)
>>   	for (inst = instance_list; inst; inst = inst->next) {
>>   		if (inst->flags & FLAG_DONE)
>>   			continue;
>> +		if (inst->pid == -1)
>> +			continue;
> 
> That works, but I think we can afford to be a little defensive here.
> Anything <= 0 is a bug and can have unexpected consequences if we
> actually call the kill().
> 
> 		if (inst->pid <= 0)
> 			continue

OK, I'll fix this and send the v2 version of the patch.

> 
> 
> Also as Darrick pointed out we need to send the patch to util-linux
> (disk-utils/fsck.c) as well if you haven't already.

I'll check and modify util-linux(disk-utils/fsck.c).

-zhanchengbin

> 
> -Lukas
> 
> 
>>   		kill(inst->pid, signum);
>>   		n++;
>>   	}
>> -- 
>> 2.27.0
>>
> 
> .
> 
