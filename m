Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FF595F82A3
	for <lists+linux-ext4@lfdr.de>; Sat,  8 Oct 2022 05:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbiJHDF7 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 7 Oct 2022 23:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiJHDF5 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 7 Oct 2022 23:05:57 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEEAF7D7B7
        for <linux-ext4@vger.kernel.org>; Fri,  7 Oct 2022 20:05:50 -0700 (PDT)
Received: from dggpeml500020.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Mkqgz6gvTzlXh8;
        Sat,  8 Oct 2022 11:01:19 +0800 (CST)
Received: from dggpeml500016.china.huawei.com (7.185.36.70) by
 dggpeml500020.china.huawei.com (7.185.36.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 8 Oct 2022 11:05:49 +0800
Received: from [10.174.176.102] (10.174.176.102) by
 dggpeml500016.china.huawei.com (7.185.36.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 8 Oct 2022 11:05:48 +0800
Message-ID: <01783b8c-2a39-73ec-c537-cc1df82643e2@huawei.com>
Date:   Sat, 8 Oct 2022 11:05:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
To:     Theodore Ts'o <tytso@mit.edu>
CC:     <linux-ext4@vger.kernel.org>, Lukas Czerner <lczerner@redhat.com>,
        <liuzhiqiang26@huawei.com>, linfeilong <linfeilong@huawei.com>
From:   zhanchengbin <zhanchengbin1@huawei.com>
Subject: [PATCH] misc/fsck.c: Processes may kill other processes.
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.102]
X-ClientProxiedBy: dggpeml500017.china.huawei.com (7.185.36.243) To
 dggpeml500016.china.huawei.com (7.185.36.70)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

If run the fsck -N command, processes don't execute, just show what
would be done. However, the pid whose value is -1 is added to the
instance_list list in the execute function,if the kill_all function
is called later, kill(-1, signum) is executed, Signals are sent to
all processes except the number one process and itself. Other
processes will be killed if they use the default signal processing
function.

Signed-off-by: zhanchengbin <zhanchengbin1@huawei.com>
---
  misc/fsck.c | 2 ++
  1 file changed, 2 insertions(+)

diff --git a/misc/fsck.c b/misc/fsck.c
index 4efe10ec..faf7789d 100644
--- a/misc/fsck.c
+++ b/misc/fsck.c
@@ -546,6 +546,8 @@ static int kill_all(int signum)
  	for (inst = instance_list; inst; inst = inst->next) {
  		if (inst->flags & FLAG_DONE)
  			continue;
+		if (inst->pid == -1)
+			continue;
  		kill(inst->pid, signum);
  		n++;
  	}
-- 
2.27.0
