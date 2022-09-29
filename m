Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 601CD5EEF4C
	for <lists+linux-ext4@lfdr.de>; Thu, 29 Sep 2022 09:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235334AbiI2HkG (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 29 Sep 2022 03:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235351AbiI2HkC (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 29 Sep 2022 03:40:02 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 022E941D22
        for <linux-ext4@vger.kernel.org>; Thu, 29 Sep 2022 00:40:00 -0700 (PDT)
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MdQB53d1PzHtdn;
        Thu, 29 Sep 2022 15:35:09 +0800 (CST)
Received: from dggpeml500016.china.huawei.com (7.185.36.70) by
 dggpeml500026.china.huawei.com (7.185.36.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 29 Sep 2022 15:39:57 +0800
Received: from [10.174.176.102] (10.174.176.102) by
 dggpeml500016.china.huawei.com (7.185.36.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 29 Sep 2022 15:39:57 +0800
Message-ID: <4ffe3143-fc53-7178-cf44-f3481eb96ae4@huawei.com>
Date:   Thu, 29 Sep 2022 15:39:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
To:     Theodore Ts'o <tytso@mit.edu>
CC:     <linux-ext4@vger.kernel.org>, <liuzhiqiang26@huawei.com>,
        linfeilong <linfeilong@huawei.com>
From:   zhanchengbin <zhanchengbin1@huawei.com>
Subject: [bug report] misc/fsck.c: Processes may kill other processes.
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.102]
X-ClientProxiedBy: dggpeml100003.china.huawei.com (7.185.36.120) To
 dggpeml500016.china.huawei.com (7.185.36.70)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Tytso,
I find a error in misc/fsck.c, if run the fsck -N command, processes
don't execute, just show what would be done. However, the pid whose
value is -1 is added to the instance_list list in the execute
function,if the kill_all function is called later, kill(-1, signum)
is executed, Signals are sent to all processes except the number one
process and itself. Other processes will be killed if they use the
default signal processing function.

execute:
     if (noexecute)
         pid = -1;
     inst->pid = pid;
     // Find the end of the list, so we add the instance on at the end.

kill_all:
     for (inst = instance_list; inst; inst = inst->next) {
         kill(inst->pid, signum);
     }

misc/fsck.c:
main:
     ->PRS
         case 'N':
             noexecute++;
     for (num_devices) {
         if (cancel_requested) {
             ->kill_all(SIGTERM);
         }
         ->fsck_device
             ->execute
     }

(gdb) bt
#0  execute (type=<optimized out>, type@entry=0x412cd0 "ext4", 
device=0x412b00 "/root/a.img", mntpt=<optimized out>, 
interactive=interactive@entry=1) at fsck.c:523
#1  0x0000000000404959 in fsck_device (fs=fs@entry=0x412ac0, 
interactive=interactive@entry=1) at fsck.c:727
#2  0x0000000000402704 in main (argc=<optimized out>, argv=<optimized 
out>) at fsck.c:1333
(gdb) p inst->pid
$7 = -1

regards,
Zhan Chengbin
