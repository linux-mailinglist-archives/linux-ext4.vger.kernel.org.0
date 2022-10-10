Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BF515F9B78
	for <lists+linux-ext4@lfdr.de>; Mon, 10 Oct 2022 10:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbiJJI5E (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 10 Oct 2022 04:57:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbiJJI5D (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 10 Oct 2022 04:57:03 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 940A8631CA
        for <linux-ext4@vger.kernel.org>; Mon, 10 Oct 2022 01:57:01 -0700 (PDT)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MmCMj43KzzHtsr;
        Mon, 10 Oct 2022 16:52:01 +0800 (CST)
Received: from dggpeml500016.china.huawei.com (7.185.36.70) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 10 Oct 2022 16:56:59 +0800
Received: from [10.174.176.102] (10.174.176.102) by
 dggpeml500016.china.huawei.com (7.185.36.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 10 Oct 2022 16:56:59 +0800
Message-ID: <2c8f3b3a-b6d1-9b8b-27c7-2df51236fe8c@huawei.com>
Date:   Mon, 10 Oct 2022 16:56:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
To:     Theodore Ts'o <tytso@mit.edu>
CC:     <linux-ext4@vger.kernel.org>, Lukas Czerner <lczerner@redhat.com>,
        <liuzhiqiang26@huawei.com>, linfeilong <linfeilong@huawei.com>
From:   zhanchengbin <zhanchengbin1@huawei.com>
Subject: [PATCH v2] misc/fsck.c: Processes may kill other processes.
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.102]
X-ClientProxiedBy: dggpeml100022.china.huawei.com (7.185.36.176) To
 dggpeml500016.china.huawei.com (7.185.36.70)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

I find a error in misc/fsck.c, if run the fsck -N command, processes
don't execute, just show what would be done. However, the pid whose
value is -1 is added to the instance_list list in the execute
function,if the kill_all function is called later, kill(-1, signum)
is executed, Signals are sent to all processes except the number one
process and itself. Other processes will be killed if they use the
default signal processing function.

Signed-off-by: zhanchengbin <zhanchengbin1@huawei.com>
Signed-off-by: Lukas Czerner <lczerner@redhat.com>
---
V1->V2:
   Anything <= 0 is a bug and can have unexpected consequences if
we actually call the kill(). So change inst->pid==-1 to inst->pid<=0.

  misc/fsck.c | 2 ++
  1 file changed, 2 insertions(+)

diff --git a/misc/fsck.c b/misc/fsck.c
index 4efe10ec..c56d1b00 100644
--- a/misc/fsck.c
+++ b/misc/fsck.c
@@ -546,6 +546,8 @@ static int kill_all(int signum)
  	for (inst = instance_list; inst; inst = inst->next) {
  		if (inst->flags & FLAG_DONE)
  			continue;
+		if (inst->pid <= 0)
+			continue;
  		kill(inst->pid, signum);
  		n++;
  	}
-- 
2.27.0

