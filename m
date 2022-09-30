Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 170315F0252
	for <lists+linux-ext4@lfdr.de>; Fri, 30 Sep 2022 03:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbiI3Bm5 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 29 Sep 2022 21:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiI3Bm4 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 29 Sep 2022 21:42:56 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8E1B1FF167
        for <linux-ext4@vger.kernel.org>; Thu, 29 Sep 2022 18:42:55 -0700 (PDT)
Received: from dggpeml500020.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MdtDC1F2xz1P6x5;
        Fri, 30 Sep 2022 09:38:35 +0800 (CST)
Received: from dggpeml500016.china.huawei.com (7.185.36.70) by
 dggpeml500020.china.huawei.com (7.185.36.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 30 Sep 2022 09:42:53 +0800
Received: from [10.174.176.102] (10.174.176.102) by
 dggpeml500016.china.huawei.com (7.185.36.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 30 Sep 2022 09:42:52 +0800
Message-ID: <470ea2ee-54fd-3dd5-2500-36fb82665c11@huawei.com>
Date:   Fri, 30 Sep 2022 09:42:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [bug report] misc/fsck.c: Processes may kill other processes.
To:     Lukas Czerner <lczerner@redhat.com>
CC:     Theodore Ts'o <tytso@mit.edu>, <linux-ext4@vger.kernel.org>,
        <liuzhiqiang26@huawei.com>, linfeilong <linfeilong@huawei.com>
References: <4ffe3143-fc53-7178-cf44-f3481eb96ae4@huawei.com>
 <20220929112813.6aqtktwaff2m7fh2@fedora>
From:   zhanchengbin <zhanchengbin1@huawei.com>
In-Reply-To: <20220929112813.6aqtktwaff2m7fh2@fedora>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.102]
X-ClientProxiedBy: dggpeml100009.china.huawei.com (7.185.36.95) To
 dggpeml500016.china.huawei.com (7.185.36.70)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On 2022/9/29 19:28, Lukas Czerner wrote:
> Hi,
> 
> indeed we'd like to avoid killing the instance that was not ran because
> of noexecute. Can you try the following patch?
> 
> Thanks!
> -Lukas

Yes, you're right, I think we can fix it in this way.

diff --git a/misc/fsck.c b/misc/fsck.c
index 1f6ec7d9..91edbf17 100644
--- a/misc/fsck.c
+++ b/misc/fsck.c
@@ -547,6 +547,8 @@ static int kill_all(int signum)
         for (inst = instance_list; inst; inst = inst->next) {
                 if (inst->flags & FLAG_DONE)
                         continue;
+               if (inst->pid == -1)
+                       continue;
                 kill(inst->pid, signum);
                 n++;
         }
> 
> 
> diff --git a/misc/fsck.c b/misc/fsck.c
> index 1f6ec7d9..8fae7730 100644
> --- a/misc/fsck.c
> +++ b/misc/fsck.c
> @@ -497,9 +497,10 @@ static int execute(const char *type, const char *device, const char *mntpt,
>   	}
>   
>   	/* Fork and execute the correct program. */
> -	if (noexecute)
> +	if (noexecute) {
>   		pid = -1;
> -	else if ((pid = fork()) < 0) {
> +		inst->flags |= FLAG_DONE;
> +	} else if ((pid = fork()) < 0) {
>   		perror("fork");
>   		free(inst);
>   		return errno;
> @@ -544,6 +545,9 @@ static int kill_all(int signum)
>   	struct fsck_instance *inst;
>   	int	n = 0;
>   
> +	if (noexecute)
> +		return 0;
> +
>   	for (inst = instance_list; inst; inst = inst->next) {
>   		if (inst->flags & FLAG_DONE)
>   			continue;
regards,
Zhan Chengbin

