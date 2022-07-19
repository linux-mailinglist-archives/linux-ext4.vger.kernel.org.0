Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07E8B579C6B
	for <lists+linux-ext4@lfdr.de>; Tue, 19 Jul 2022 14:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240735AbiGSMkF (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 19 Jul 2022 08:40:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241083AbiGSMin (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 19 Jul 2022 08:38:43 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 205DA10568;
        Tue, 19 Jul 2022 05:15:19 -0700 (PDT)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LnHkB2HXzzVgX6;
        Tue, 19 Jul 2022 20:11:30 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 19 Jul 2022 20:15:13 +0800
Message-ID: <ffb13c36-521e-0e06-8fd6-30b0fec727da@huawei.com>
Date:   Tue, 19 Jul 2022 20:15:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 4.19] ext4: fix race condition between ext4_ioctl_setflags
 and ext4_fiemap
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <stable@vger.kernel.org>, <linux-ext4@vger.kernel.org>,
        <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
        <ritesh.list@gmail.com>, <lczerner@redhat.com>,
        <enwlinux@gmail.com>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>, <yebin10@huawei.com>, <yukuai3@huawei.com>,
        Hulk Robot <hulkci@huawei.com>
References: <20220715023928.2701166-1-libaokun1@huawei.com>
 <YtF1XygwvIo2Dwae@kroah.com>
 <425ab528-7d9a-975a-7f4c-5f903cedd8bc@huawei.com>
 <YtaVAWMlxrQNcS34@kroah.com>
From:   Baokun Li <libaokun1@huawei.com>
In-Reply-To: <YtaVAWMlxrQNcS34@kroah.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.174]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500021.china.huawei.com (7.185.36.21)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

在 2022/7/19 19:26, Greg KH 写道:
> On Sat, Jul 16, 2022 at 10:33:30AM +0800, Baokun Li wrote:
>> 在 2022/7/15 22:10, Greg KH 写道:
>>> On Fri, Jul 15, 2022 at 10:39:28AM +0800, Baokun Li wrote:
>>>> This patch and problem analysis is based on v4.19 LTS.
>>>> The d3b6f23f7167("ext4: move ext4_fiemap to use iomap framework") patch
>>>> is incorporated in v5.7-rc1. This patch avoids this problem by switching
>>>> to iomap in ext4_fiemap.
>>>>
>>>> Hulk Robot reported a BUG on stable 4.19.252:
>>>> ==================================================================
>>>> kernel BUG at fs/ext4/extents_status.c:762!
>>>> invalid opcode: 0000 [#1] SMP KASAN PTI
>>>> CPU: 7 PID: 2845 Comm: syz-executor Not tainted 4.19.252 #46
>>>> RIP: 0010:ext4_es_cache_extent+0x30e/0x370
>>>> [...]
>>>> Call Trace:
>>>>    ext4_cache_extents+0x238/0x2f0
>>>>    ext4_find_extent+0x785/0xa40
>>>>    ext4_fiemap+0x36d/0xe90
>>>>    do_vfs_ioctl+0x6af/0x1200
>>>> [...]
>>>> ==================================================================
>>>>
>>>> Above issue may happen as follows:
>>>> -------------------------------------
>>>>              cpu1		    cpu2
>>>> _____________________|_____________________
>>>> do_vfs_ioctl
>>>>    ext4_ioctl
>>>>     ext4_ioctl_setflags
>>>>      ext4_ind_migrate
>>>>                           do_vfs_ioctl
>>>>                            ioctl_fiemap
>>>>                             ext4_fiemap
>>>>                              ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS)
>>>>                              ext4_fill_fiemap_extents
>>>>       down_write(&EXT4_I(inode)->i_data_sem);
>>>>       ext4_ext_check_inode
>>>>       ext4_clear_inode_flag(inode, EXT4_INODE_EXTENTS)
>>>>       memset(ei->i_data, 0, sizeof(ei->i_data))
>>>>       up_write(&EXT4_I(inode)->i_data_sem);
>>>>                               down_read(&EXT4_I(inode)->i_data_sem);
>>>>                               ext4_find_extent
>>>>                                ext4_cache_extents
>>>>                                 ext4_es_cache_extent
>>>>                                  BUG_ON(end < lblk)
>>>>
>>>> We can easily reproduce this problem with the syzkaller testcase:
>>>> ```
>>>> 02:37:07 executing program 3:
>>>> r0 = openat(0xffffffffffffff9c, &(0x7f0000000040)='./file0\x00', 0x26e1, 0x0)
>>>> ioctl$FS_IOC_FSSETXATTR(r0, 0x40086602, &(0x7f0000000080)={0x17e})
>>>> mkdirat(0xffffffffffffff9c, &(0x7f00000000c0)='./file1\x00', 0x1ff)
>>>> r1 = openat(0xffffffffffffff9c, &(0x7f0000000100)='./file1\x00', 0x0, 0x0)
>>>> ioctl$FS_IOC_FIEMAP(r1, 0xc020660b, &(0x7f0000000180)={0x0, 0x1, 0x0, 0xef3, 0x6, []}) (async, rerun: 32)
>>>> ioctl$FS_IOC_FSSETXATTR(r1, 0x40086602, &(0x7f0000000140)={0x17e}) (rerun: 32)
>>>> ```
>>>>
>>>> To solve this issue, we use __generic_block_fiemap() instead of
>>>> generic_block_fiemap() and add inode_lock_shared to avoid race condition.
>>>>
>>>> Reported-by: Hulk Robot <hulkci@huawei.com>
>>>> Signed-off-by: Baokun Li <libaokun1@huawei.com>
>>>> ---
>>>>    fs/ext4/extents.c | 15 +++++++++++----
>>>>    1 file changed, 11 insertions(+), 4 deletions(-)
>>> What is the git commit id of this change in Linus's tree?
>>>
>>> If it is not in Linus's tree, why not?
>>>
>>> confused,
>>>
>>> greg k-h
>>> .
>> This patch does not exist in the Linus' tree.
>>
>> This problem persists until the patch d3b6f23f7167("ext4: move ext4_fiemap
>> to use iomap framework") is incorporated in v5.7-rc1.
> Then why not ask for that change to be added instead?
>
> thanks,
>
> greg k-h
> .

If we want to switch to the iomap framework, we need to analyze and 
integrate about 60 patches.

The workload may be greater than that of solving this problem alone.

Thank you!

Thanks a lot!

-- 
With Best Regards,
Baokun Li


-- 
With Best Regards,
Baokun Li

