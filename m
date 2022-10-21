Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE0AB606E32
	for <lists+linux-ext4@lfdr.de>; Fri, 21 Oct 2022 05:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbiJUDNG (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 20 Oct 2022 23:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbiJUDMr (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 20 Oct 2022 23:12:47 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1B9813C1FA
        for <linux-ext4@vger.kernel.org>; Thu, 20 Oct 2022 20:12:44 -0700 (PDT)
Received: from dggpeml500022.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MtqCc2vKTzmVDJ;
        Fri, 21 Oct 2022 11:07:56 +0800 (CST)
Received: from dggpeml500016.china.huawei.com (7.185.36.70) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 21 Oct 2022 11:12:40 +0800
Received: from [10.174.176.102] (10.174.176.102) by
 dggpeml500016.china.huawei.com (7.185.36.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 21 Oct 2022 11:12:40 +0800
Message-ID: <1fcc1cf2-6990-af2a-958d-c2d25c4bc8cc@huawei.com>
Date:   Fri, 21 Oct 2022 11:12:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v2] misc/fsck.c: Processes may kill other processes.
From:   zhanchengbin <zhanchengbin1@huawei.com>
To:     Theodore Ts'o <tytso@mit.edu>
CC:     <linux-ext4@vger.kernel.org>, Lukas Czerner <lczerner@redhat.com>,
        <liuzhiqiang26@huawei.com>, linfeilong <linfeilong@huawei.com>
References: <2c8f3b3a-b6d1-9b8b-27c7-2df51236fe8c@huawei.com>
In-Reply-To: <2c8f3b3a-b6d1-9b8b-27c7-2df51236fe8c@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.102]
X-ClientProxiedBy: dggpeml500024.china.huawei.com (7.185.36.10) To
 dggpeml500016.china.huawei.com (7.185.36.70)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

ping...

On 2022/10/10 16:56, zhanchengbin wrote:
> I find a error in misc/fsck.c, if run the fsck -N command, processes
> don't execute, just show what would be done. However, the pid whose
> value is -1 is added to the instance_list list in the execute
> function,if the kill_all function is called later, kill(-1, signum)
> is executed, Signals are sent to all processes except the number one
> process and itself. Other processes will be killed if they use the
> default signal processing function.
> 
> Signed-off-by: zhanchengbin <zhanchengbin1@huawei.com>
> Signed-off-by: Lukas Czerner <lczerner@redhat.com>
> ---
> V1->V2:
>    Anything <= 0 is a bug and can have unexpected consequences if
> we actually call the kill(). So change inst->pid==-1 to inst->pid<=0.
> 
>   misc/fsck.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/misc/fsck.c b/misc/fsck.c
> index 4efe10ec..c56d1b00 100644
> --- a/misc/fsck.c
> +++ b/misc/fsck.c
> @@ -546,6 +546,8 @@ static int kill_all(int signum)
>       for (inst = instance_list; inst; inst = inst->next) {
>           if (inst->flags & FLAG_DONE)
>               continue;
> +        if (inst->pid <= 0)
> +            continue;
>           kill(inst->pid, signum);
>           n++;
>       }
