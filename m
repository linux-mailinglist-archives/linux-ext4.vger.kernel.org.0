Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B225F750284
	for <lists+linux-ext4@lfdr.de>; Wed, 12 Jul 2023 11:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232113AbjGLJHb (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 12 Jul 2023 05:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233049AbjGLJHC (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 12 Jul 2023 05:07:02 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D258710C4
        for <linux-ext4@vger.kernel.org>; Wed, 12 Jul 2023 02:06:34 -0700 (PDT)
Received: from dggpeml500016.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4R1Bft0L1Gz1JCVD;
        Wed, 12 Jul 2023 17:05:58 +0800 (CST)
Received: from [10.174.176.102] (10.174.176.102) by
 dggpeml500016.china.huawei.com (7.185.36.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 12 Jul 2023 17:06:32 +0800
Message-ID: <4a3ac0da-69cf-e282-dc56-aefaa0e90718@huawei.com>
Date:   Wed, 12 Jul 2023 17:06:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [bug report] tune2fs: filesystem inconsistency occurs by
 concurrent write
To:     "Darrick J. Wong" <djwong@kernel.org>
CC:     Theodore Ts'o <tytso@mit.edu>, <linux-ext4@vger.kernel.org>,
        linfeilong <linfeilong@huawei.com>, <louhongxiang@huawei.com>,
        <liuzhiqiang26@huawei.com>, Ye Bin <yebin@huaweicloud.com>
References: <29f6134f-ba0a-d601-0a5a-ad2b5e9bbf1d@huawei.com>
 <20230626021758.GF8954@mit.edu>
 <4e647e9b-4f2f-b89f-6825-838f22c4bf2e@huawei.com>
 <20230704193357.GG1178919@mit.edu>
 <84a1a21a-be09-f70d-1d1b-234c706ddf14@huawei.com>
 <20230712000511.GA11427@frogsfrogsfrogs>
From:   zhanchengbin <zhanchengbin1@huawei.com>
In-Reply-To: <20230712000511.GA11427@frogsfrogsfrogs>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.102]
X-ClientProxiedBy: dggpeml100016.china.huawei.com (7.185.36.216) To
 dggpeml500016.china.huawei.com (7.185.36.70)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On 2023/7/12 8:05, Darrick J. Wong wrote:
> On Sat, Jul 08, 2023 at 03:29:51PM +0800, zhanchengbin wrote:
>> On 2023/7/5 3:33, Theodore Ts'o wrote:
>>
>> I have written the ioctl for EXT4_IOC_SET_ERROR_BEHAVIOR according to your
>> instructions and verified that it can indeed modify the data on the disk.
>>
>> However, I realized some problems. If we use the ioctl method to modify the
>> data, it would require multiple ioctls in user space to modify the
>> superblock.
>> If one ioctl successfully modifies the superblock data, but another ioctl
>> fails, the atomicity of the superblock cannot be guaranteed. This is just
>> within one user space process, not to mention the scenario of multiple user
>> space processes calling ioctls concurrently. Additionally, multiple ioctls
>> modifying the superblock may be placed in multiple transactions, which
>> further
>> compromises atomicity.
>>
>> Writing the entire superblock buffer_head to disk can ensure atomicity.
> 
> ...at a cost of racing with the mounted fs, which might be updating the
> superblock at the same time; and prohibiting the kernel devs from
> closing the "scribble on mounted bdev" attack surface.

Regardless of whether I am modifying a single byte or the entire
buffer_head, there will always be a situation of contention with the kernel
lock, You can take a look at ext4_update_superblocks_fn which calls
lock_buffer.

What I am more concerned about is that the superblock needs to be
synchronized to the memory before being saved to the disk. Otherwise, during
the ext4_commit_super process, outdated data may be saved to the disk.

> 
> How many of these attributes do you /really/ need to be able to commit

My plan with Tytso is to add seven attribute modifications.

> atomically, anyway?  If the system crashes, can't you re-run the
> program and end up with the same super fields?
Just run the program again after the system crashes, o.O? I don't think so.

The program perceives that the superblock has been modified 
successfully, and
the value of the modified superblock is saved on disk in
ext4_update_primary_sb, but there is no guarantee whether the super block is
saved in journal on the disk or whether it is checkpointed. If the super 
block
has not been saved in journal on the disk and the system crashes, the
modification of the super block may be overwritten when the journal
recover; similarly, this problem will also occur for the translation 
that has
not been checkpointed; Both of these scenarios are not perceptible to user
process unless there is a backup mechanism implemented in user mode.

Moreover, the method of rerunning the program cannot resolve the conflicting
racing condition between the two ioctls.

Thanks,
  - bin.

> 
> --D
> 
>> However, these data need to be converted to ext4_sb_info. Otherwise, during
>> unmount, the data in memory will overwrite the data on the disk.
>> (Modifying the values in ext4_sb_info can potentially introduce unexpected
>> issues, just like the problem thata arises when setting the UUID without
>> checking ext4_has_feature_csum_seed.)
