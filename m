Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9136660CAE0
	for <lists+linux-ext4@lfdr.de>; Tue, 25 Oct 2022 13:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231415AbiJYLZk (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 25 Oct 2022 07:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232127AbiJYLZ1 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 25 Oct 2022 07:25:27 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D955F161FD7;
        Tue, 25 Oct 2022 04:25:12 -0700 (PDT)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MxTxv11M5zmVFj;
        Tue, 25 Oct 2022 19:20:19 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 25 Oct 2022 19:25:10 +0800
Message-ID: <0d691d8a-6d79-f04b-43cb-15c4fe391b31@huawei.com>
Date:   Tue, 25 Oct 2022 19:25:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH v2 2/2] ext4: fix bug_on in __es_tree_search caused by
 wrong boot loader inode
Content-Language: en-US
To:     Jan Kara <jack@suse.cz>
CC:     <linux-ext4@vger.kernel.org>, <tytso@mit.edu>,
        <adilger.kernel@dilger.ca>, <ritesh.list@gmail.com>,
        <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>,
        <yukuai3@huawei.com>, Baokun Li <libaokun1@huawei.com>
References: <20221021040731.4180649-1-libaokun1@huawei.com>
 <20221021040731.4180649-3-libaokun1@huawei.com>
 <20221024142527.avwgiztqvzmeo4se@quack3>
 <c29e93a7-d4c8-6126-2046-830f43d9adc6@huawei.com>
 <20221025091813.oo27uhwybvkd7mzc@quack3>
From:   Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20221025091813.oo27uhwybvkd7mzc@quack3>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.174]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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

On 2022/10/25 17:18, Jan Kara wrote:
> On Tue 25-10-22 10:26:14, Baokun Li wrote:
>> On 2022/10/24 22:25, Jan Kara wrote:
>>> On Fri 21-10-22 12:07:31, Baokun Li wrote:
>>>> We got a issue as fllows:
>>>> ...
>>>>
>>>> In the above issue, ioctl invokes the swap_inode_boot_loader function to
>>>> swap inode<5> and inode<12>. However, inode<5> contain incorrect imode and
>>>> disordered extents, and i_nlink is set to 1. The extents check for inode in
>>>> the ext4_iget function can be bypassed bacause 5 is EXT4_BOOT_LOADER_INO.
>>>> While links_count is set to 1, the extents are not initialized in
>>>> swap_inode_boot_loader. After the ioctl command is executed successfully,
>>>> the extents are swapped to inode<12>, in this case, run the `cat` command
>>>> to view inode<12>. And Bug_ON is triggered due to the incorrect extents.
>>>>
>>>> When the boot loader inode is not initialized, its imode can be one of the
>>>> following:
>>>> 1) the imode is a bad type, which is marked as bad_inode in ext4_iget and
>>>>      set to S_IFREG.
>>>> 2) the imode is good type but not S_IFREG.
>>>> 3) the imode is S_IFREG.
>>>>
>>>> The BUG_ON may be triggered by bypassing the check in cases 1 and 2.
>>>> Therefore, when the boot loader inode is bad_inode or its imode is not
>>>> S_IFREG, initialize the inode to avoid triggering the BUG.
>>>>
>>>> Signed-off-by: Baokun Li <libaokun1@huawei.com>
>>> Grepping for calls to ext4_iget() in the ext4 code shows there are many
>>> more places that will get unhappy (and crash) when ext4_iget() returns a
>>> bad inode. In fact, I didn't find a place when returning bad inode would be
>>> useful for anything. So why don't we just return EFSCORRUPTED instead of
>>> returning a bad inode?
>>>
>>> 								Honza
>> Hello Honza,
>>
>> In ext4_iget(), the inode is marked as bad and returned only when ino is
>> equal to
>> EXT4_BOOT_LOADER_INO. In the error branch bad_inode, although the inode is
>> marked as bad, the returned value is the corresponding error number.
>> The boot loader inode is not initialized during mkfs. Therefore, when
>> ext4_iget() is
>> entered for the first time, imode of the inode is bad type. However, the
>> swap_inode_boot_loader() needs to obtain the inode for initialization and
>> swap.
>> Therefore, a bad_inode is returned in ext4_iget.
>>
>> Generally, ext4_iget() does not get the boot loader inode. Therefore, we
>> only need
>> to pay attention to the special inodes that can be specified.
>> The following figure shows the check result:
>>
>> 1) usr_quota_inum/grp_quota_inum/prj_quota_inum
>> These inodes may be faulty. In the first patch, this situation is
>> intercepted.
>> At the beginning, FUZZ found that the quota inode was faulty. Later, we
>> found that
>> the operation function swap_inode_boot_loader() related to inode 5 was also
>> faulty.
>>
>> 2) journal_inum
>> In ext4_get_journal_inode(), the system checks whether the imode is S_IFREG.
>> Then,
>> the bmap in jbd2_journal_init_inode() checks whether the inode has
>> a_ops->bmap
>> operation. The bad inode does not set the bmap operation, so there is no
>> problem.
>>
>> 3) last_orphan
>> In ext4_orphan_get(), it checks if the imode is normal and if the inode is
>> bad inode,
>> so there is no problem.
>>
>> 4) snapshot_inum
>> No place to use snapshot_inum was found in the kernel, so there is no kernel
>> issue.
> Thanks for detailed explanation! Now I agree you have actually covered all
> the cases. But since EXT4_BOOT_LOADER_INO has this special behavior maybe
> it would be more robust to create a special iget flag for it? Like
> EXT4_IGET_BAD? And only with this flag we'd be returning bad inode from
> ext4_iget(), otherwise we always return the error code?
>
> 								Honza
Adding a special iget tag sounds great！
Thank you very much for your review！
I will send a patch V2 with the changes suggested by you.

-- 
With Best Regards,
Baokun Li
.
