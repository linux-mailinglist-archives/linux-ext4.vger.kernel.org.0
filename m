Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86E6D63CD24
	for <lists+linux-ext4@lfdr.de>; Wed, 30 Nov 2022 03:08:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbiK3CIR (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 29 Nov 2022 21:08:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiK3CIQ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 29 Nov 2022 21:08:16 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9715B4B760;
        Tue, 29 Nov 2022 18:08:15 -0800 (PST)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4NMMzV32r5z15Mn9;
        Wed, 30 Nov 2022 10:07:34 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 30 Nov 2022 10:08:13 +0800
Message-ID: <3cd4e5d1-4837-a569-18b4-72fcaabf103d@huawei.com>
Date:   Wed, 30 Nov 2022 10:08:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH 0/2] ext4: fix a infinite loop in do_writepages after
 online resizing
Content-Language: en-US
To:     Theodore Ts'o <tytso@mit.edu>, <linux-ext4@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <enwlinux@gmail.com>,
        <jack@suse.cz>, <lczerner@redhat.com>, <yukuai3@huawei.com>,
        <yi.zhang@huawei.com>, <yebin10@huawei.com>,
        <ritesh.list@gmail.com>, <adilger.kernel@dilger.ca>
References: <20220817132701.3015912-1-libaokun1@huawei.com>
 <166975630697.2135297.7495422853696969304.b4-ty@mit.edu>
From:   Baokun Li <libaokun1@huawei.com>
In-Reply-To: <166975630697.2135297.7495422853696969304.b4-ty@mit.edu>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.174]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500021.china.huawei.com (7.185.36.21)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 2022/11/30 5:12, Theodore Ts'o wrote:
> On Wed, 17 Aug 2022 21:26:59 +0800, Baokun Li wrote:
>> We got a issue: the ext4 writeback process was stuck in do_writepages and
>> do_writepages kept retrying. However, '-ENOMEM' is returned each time, even
>> if there is still free memory on the current machine.
>>
>> We find that the direct cause of this issue is that the bg_inode_table_hi
>> in the group descriptor is written to an incorrect value, which causes the
>> inode block found through the inode table to exceed the end_ block。Then,
>> sb_getblk always returns null, __ext4_get_inode_loc returns `-ENOMEM`,
>> and do_writepages keeps retrying.
>>
>> [...]
> Applied, thanks!
>
> [1/2] ext4: fix GDT corruption after online resizing with bigalloc enable and blocksize is 1024
>        commit: 496fb12f8e236f303de6bc73a0334dd50c4eb64a
> [2/2] ext4: add inode table check in __ext4_get_inode_loc to aovid possible infinite loop
>        commit: bfb0625e8e86f8797264b1c7d10e146afe243d23
>
> Best regards,

Hi Theodore,

Thank you very much for applying this patch set!

But I thought this patch set was discarded because there was no 
"Reviewed-by".
And a few days ago, I came up with a better solution to the problem 
fixed by PATCH 1/2.
The new solution is called "ext4: fix corruption when online resizing a 
1K bigalloc fs", which
is in another patch set  ("[PATCH v3 0/3] ext4: fix some bugs in online 
resize") that fixes
some online resize problems. This patch set has been reviewed, and I 
would appreciate it if
you could revert PATCH 1/2 and apply the patch set containing the new 
solution.

Sorry for wasting your time without stating that a new solution is 
available after the old patch.

Thanks again!
-- 
With Best Regards,
Baokun Li
