Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72A05746C08
	for <lists+linux-ext4@lfdr.de>; Tue,  4 Jul 2023 10:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231435AbjGDIf5 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 4 Jul 2023 04:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231464AbjGDIfu (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 4 Jul 2023 04:35:50 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C60CD127
        for <linux-ext4@vger.kernel.org>; Tue,  4 Jul 2023 01:35:46 -0700 (PDT)
Received: from dggpeml500016.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4QwGK84FN0zLnfL;
        Tue,  4 Jul 2023 16:33:32 +0800 (CST)
Received: from [10.174.176.102] (10.174.176.102) by
 dggpeml500016.china.huawei.com (7.185.36.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 4 Jul 2023 16:35:43 +0800
Message-ID: <4e647e9b-4f2f-b89f-6825-838f22c4bf2e@huawei.com>
Date:   Tue, 4 Jul 2023 16:35:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [bug report] tune2fs: filesystem inconsistency occurs by
 concurrent write
To:     Theodore Ts'o <tytso@mit.edu>
CC:     <linux-ext4@vger.kernel.org>, linfeilong <linfeilong@huawei.com>,
        <louhongxiang@huawei.com>, <liuzhiqiang26@huawei.com>,
        Ye Bin <yebin@huaweicloud.com>
References: <29f6134f-ba0a-d601-0a5a-ad2b5e9bbf1d@huawei.com>
 <20230626021758.GF8954@mit.edu>
From:   zhanchengbin <zhanchengbin1@huawei.com>
In-Reply-To: <20230626021758.GF8954@mit.edu>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.102]
X-ClientProxiedBy: dggpeml500001.china.huawei.com (7.185.36.227) To
 dggpeml500016.china.huawei.com (7.185.36.70)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Tytso,

Referring to you kind and insightful advice, I have come up with three
solutions, listed as follows:

1) Add interface blkdev_bh_read and blkdev_bh_write in blkdev_ioctl. 
Lock the
bh_lock when blkdev_bh_read is called, then change the value of the data and
write back it, and finally unlock_buffer;

This solution ensures that there is no coupling between the block layer and
the file system layer, but the interfaces are invoked by user processes, and
since user processes are subject to scheduling, there may be potential
performance overhead. Additionally, if user process is killed before 
releasing
the bh_lock, it can result in a deadlock situation.

2) Add interface write_super in blkdev_ioctl. In this case, a hook is 
used in
the write_super to invoke the commit_super function of each file system. 
During
the mount process, the commit_super function of the respective filesystem is
saved into the hook. Since the metadata cache is stored through bdev, it is
sufficient to memcpy the data to bh->b_data and then flush it to disk.

This solution allows each file system to implement its own method of 
flushing
the superblock. However, it introduces coupling between the block layer and
the filesystem layer, and there needs to be a place to store this 
commit_super
hook function pointer. Is it stored in the block_device? It seems a 
little bit
strange to me.

3) Add interface write_super in ext4_ioctl. The mount point is obtained 
through
the block device, and open a random file in the file system, the 
superblock is
passed to the kernel through ioctl of the file, and finally, the 
superblock is
flushed to disk. Due to the inherent risks associated with granting user 
space
write permissions to the superblock, it is deemed unsafe to utilize the 
entire
superblock as provided by user space. Instead, the superblock should be
validated, followed by selective data writing and recording. Of course, 
it is
dangerous to directly modify the data in the super block, so I plan to add a
flag in the super block to record that this modification is from the 
user state.

This solution has no coupling with other layers, but uses the ioctl of 
ordinary
files.

Personally speaking, I favour the third solution the most, what are your
opinions? If you already have other schemes, I will be more than 
delighted to
discuss it with you.
Looking foward to hearing from you soon!

Thanks,
  - bin.
