Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E7645FE91E
	for <lists+linux-ext4@lfdr.de>; Fri, 14 Oct 2022 08:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbiJNGwt (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 14 Oct 2022 02:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiJNGwt (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 14 Oct 2022 02:52:49 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE7261669B6
        for <linux-ext4@vger.kernel.org>; Thu, 13 Oct 2022 23:52:46 -0700 (PDT)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MpcTF36jRzDsXs;
        Fri, 14 Oct 2022 14:50:09 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (7.193.23.202) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 14 Oct 2022 14:52:43 +0800
Received: from [127.0.0.1] (10.174.179.254) by kwepemm600003.china.huawei.com
 (7.193.23.202) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 14 Oct
 2022 14:52:42 +0800
Subject: Re: [PATCH v2] misc/fsck.c: Processes may kill other processes.
To:     zhanchengbin <zhanchengbin1@huawei.com>,
        Theodore Ts'o <tytso@mit.edu>
CC:     <linux-ext4@vger.kernel.org>, Lukas Czerner <lczerner@redhat.com>,
        linfeilong <linfeilong@huawei.com>
References: <2c8f3b3a-b6d1-9b8b-27c7-2df51236fe8c@huawei.com>
From:   Zhiqiang Liu <liuzhiqiang26@huawei.com>
Message-ID: <2dd75638-de3b-64cf-4f7c-d68388fa06fe@huawei.com>
Date:   Fri, 14 Oct 2022 14:52:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <2c8f3b3a-b6d1-9b8b-27c7-2df51236fe8c@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.254]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On 2022/10/10 16:56, zhanchengbin wrote:
> I find a error in misc/fsck.c, if run the fsck -N command, processes
> don't execute, just show what would be done. However, the pid whose
> value is -1 is added to the instance_list list in the execute
> function,if the kill_all function is called later, kill(-1, signum)
> is executed, Signals are sent to all processes except the number one
> process and itself. Other processes will be killed if they use the
> default signal processing function.
> 
Looks good to me,
Reviewed-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
> Signed-off-by: zhanchengbin <zhanchengbin1@huawei.com>
> Signed-off-by: Lukas Czerner <lczerner@redhat.com>
> ---
> V1->V2:
>   Anything <= 0 is a bug and can have unexpected consequences if
> we actually call the kill(). So change inst->pid==-1 to inst->pid<=0.
> 
>  misc/fsck.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/misc/fsck.c b/misc/fsck.c
> index 4efe10ec..c56d1b00 100644
> --- a/misc/fsck.c
> +++ b/misc/fsck.c
> @@ -546,6 +546,8 @@ static int kill_all(int signum)
>      for (inst = instance_list; inst; inst = inst->next) {
>          if (inst->flags & FLAG_DONE)
>              continue;
> +        if (inst->pid <= 0)
> +            continue;
>          kill(inst->pid, signum);
>          n++;
>      }

