Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A5BD6CA30E
	for <lists+linux-ext4@lfdr.de>; Mon, 27 Mar 2023 14:06:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232574AbjC0MGi (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 27 Mar 2023 08:06:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232019AbjC0MGh (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 27 Mar 2023 08:06:37 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 931AF113;
        Mon, 27 Mar 2023 05:06:35 -0700 (PDT)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4PlWfw3rdTz17MBh;
        Mon, 27 Mar 2023 20:03:20 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 27 Mar 2023 20:06:33 +0800
Message-ID: <11b2fbb6-ab71-10a4-d2cb-8d115f15f16d@huawei.com>
Date:   Mon, 27 Mar 2023 20:06:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH v2 1/2] ext4: turning quotas off if mount failed after
 enable quotas
Content-Language: en-US
To:     Jan Kara <jack@suse.cz>
CC:     <linux-ext4@vger.kernel.org>, <tytso@mit.edu>,
        <adilger.kernel@dilger.ca>, <ritesh.list@gmail.com>,
        <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>,
        <yangerkun@huawei.com>, <yukuai3@huawei.com>, <stable@kernel.org>,
        Baokun Li <libaokun1@huawei.com>
References: <20230327022703.576857-1-libaokun1@huawei.com>
 <20230327022703.576857-2-libaokun1@huawei.com>
 <20230327090506.a3notb7a2zgz4hue@quack3>
From:   Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20230327090506.a3notb7a2zgz4hue@quack3>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.174]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500021.china.huawei.com (7.185.36.21)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.3 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 2023/3/27 17:05, Jan Kara wrote:
> On Mon 27-03-23 10:27:02, Baokun Li wrote:
>> Yi found during a review of the patch "ext4: don't BUG on inconsistent
>> journal feature" that when ext4_mark_recovery_complete() returns an error
>> value, the error handling path does not turn off the enabled quotas,
>> which triggers the following kmemleak:
>>
>> ================================================================
>> unreferenced object 0xffff8cf68678e7c0 (size 64):
>> comm "mount", pid 746, jiffies 4294871231 (age 11.540s)
>> hex dump (first 32 bytes):
>> 00 90 ef 82 f6 8c ff ff 00 00 00 00 41 01 00 00  ............A...
>> c7 00 00 00 bd 00 00 00 0a 00 00 00 48 00 00 00  ............H...
>> backtrace:
>> [<00000000c561ef24>] __kmem_cache_alloc_node+0x4d4/0x880
>> [<00000000d4e621d7>] kmalloc_trace+0x39/0x140
>> [<00000000837eee74>] v2_read_file_info+0x18a/0x3a0
>> [<0000000088f6c877>] dquot_load_quota_sb+0x2ed/0x770
>> [<00000000340a4782>] dquot_load_quota_inode+0xc6/0x1c0
>> [<0000000089a18bd5>] ext4_enable_quotas+0x17e/0x3a0 [ext4]
>> [<000000003a0268fa>] __ext4_fill_super+0x3448/0x3910 [ext4]
>> [<00000000b0f2a8a8>] ext4_fill_super+0x13d/0x340 [ext4]
>> [<000000004a9489c4>] get_tree_bdev+0x1dc/0x370
>> [<000000006e723bf1>] ext4_get_tree+0x1d/0x30 [ext4]
>> [<00000000c7cb663d>] vfs_get_tree+0x31/0x160
>> [<00000000320e1bed>] do_new_mount+0x1d5/0x480
>> [<00000000c074654c>] path_mount+0x22e/0xbe0
>> [<0000000003e97a8e>] do_mount+0x95/0xc0
>> [<000000002f3d3736>] __x64_sys_mount+0xc4/0x160
>> [<0000000027d2140c>] do_syscall_64+0x3f/0x90
>> ================================================================
>>
>> To solve this problem, we add a "failed_mount10" tag, and call
>> ext4_quota_off_umount() in this tag to release the enabled qoutas.
>>
>> Fixes: 11215630aada ("ext4: don't BUG on inconsistent journal feature")
>> Cc: stable@kernel.org
>> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
>> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> Looks good. Just one comment:
>
>> +failed_mount10:
>> +#ifdef CONFIG_QUOTA
>> +	ext4_quota_off_umount(sb);
>>   failed_mount9:
>> +#endif  /* CONFIG_QUOTA */
> How about dealing with this using __maybe_unused attribute instead. Like:
>
> failed_mount9: __maybe_unused
>
> That would be much easier to read...
>
> 								Honza

Indeed!

Thank you very much for the review!

I will send a patch V3 with the changes suggested by you.
-- 
With Best Regards,
Baokun Li
.
