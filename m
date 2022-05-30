Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AA0853737E
	for <lists+linux-ext4@lfdr.de>; Mon, 30 May 2022 04:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232174AbiE3CMy (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 29 May 2022 22:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231473AbiE3CMy (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 29 May 2022 22:12:54 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89BF95933B;
        Sun, 29 May 2022 19:12:51 -0700 (PDT)
Received: from dggpeml500020.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4LBJmc6vFjz1JC2B;
        Mon, 30 May 2022 10:11:12 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500020.china.huawei.com (7.185.36.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 30 May 2022 10:12:48 +0800
Message-ID: <881d1758-4594-c451-3dcc-e43c8e8b37f6@huawei.com>
Date:   Mon, 30 May 2022 10:12:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v3 1/3] ext4: fix bug_on ext4_mb_use_inode_pa
To:     Ritesh Harjani <ritesh.list@gmail.com>
CC:     <linux-ext4@vger.kernel.org>, <tytso@mit.edu>,
        <adilger.kernel@dilger.ca>, <jack@suse.cz>, <lczerner@redhat.com>,
        <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>,
        <yebin10@huawei.com>, <yukuai3@huawei.com>,
        Hulk Robot <hulkci@huawei.com>,
        Baokun Li <libaokun1@huawei.com>
References: <20220528110017.354175-1-libaokun1@huawei.com>
 <20220528110017.354175-2-libaokun1@huawei.com>
 <20220528151044.u3quqpy4krsfwszq@riteshh-domain>
From:   Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20220528151044.u3quqpy4krsfwszq@riteshh-domain>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.174]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500020.china.huawei.com (7.185.36.88)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

在 2022/5/28 23:10, Ritesh Harjani 写道:
> On 22/05/28 07:00PM, Baokun Li wrote:
>> Hulk Robot reported a BUG_ON:
>> ==================================================================
>> kernel BUG at fs/ext4/mballoc.c:3211!
>> [...]
>> RIP: 0010:ext4_mb_mark_diskspace_used.cold+0x85/0x136f
>> [...]
>> Call Trace:
>>   ext4_mb_new_blocks+0x9df/0x5d30
>>   ext4_ext_map_blocks+0x1803/0x4d80
>>   ext4_map_blocks+0x3a4/0x1a10
>>   ext4_writepages+0x126d/0x2c30
>>   do_writepages+0x7f/0x1b0
>>   __filemap_fdatawrite_range+0x285/0x3b0
>>   file_write_and_wait_range+0xb1/0x140
>>   ext4_sync_file+0x1aa/0xca0
>>   vfs_fsync_range+0xfb/0x260
>>   do_fsync+0x48/0xa0
>> [...]
>> ==================================================================
>>
>> Above issue may happen as follows:
>> -------------------------------------
>> do_fsync
>>   vfs_fsync_range
>>    ext4_sync_file
>>     file_write_and_wait_range
>>      __filemap_fdatawrite_range
>>       do_writepages
>>        ext4_writepages
>>         mpage_map_and_submit_extent
>>          mpage_map_one_extent
>>           ext4_map_blocks
>>            ext4_mb_new_blocks
>>             ext4_mb_normalize_request
>>              >>> start + size <= ac->ac_o_ex.fe_logical
>>             ext4_mb_regular_allocator
>>              ext4_mb_simple_scan_group
>>               ext4_mb_use_best_found
>>                ext4_mb_new_preallocation
>>                 ext4_mb_new_inode_pa
>>                  ext4_mb_use_inode_pa
>>                   >>> set ac->ac_b_ex.fe_len <= 0
>>             ext4_mb_mark_diskspace_used
>>              >>> BUG_ON(ac->ac_b_ex.fe_len <= 0);
>>
>> we can easily reproduce this problem with the following commands:
>> 	`fallocate -l100M disk`
>> 	`mkfs.ext4 -b 1024 -g 256 disk`
>> 	`mount disk /mnt`
>> 	`fsstress -d /mnt -l 0 -n 1000 -p 1`
>>
>> The size must be smaller than or equal to EXT4_BLOCKS_PER_GROUP.
>> Therefore, "start + size <= ac->ac_o_ex.fe_logical" may occur
>> when the size is truncated. So start should be the start position of
>> the group where ac_o_ex.fe_logical is located after alignment.
>> In addition, when the value of fe_logical or EXT4_BLOCKS_PER_GROUP
>> is very large, the value calculated by start_off is more accurate.
>>
>> Fixes: cd648b8a8fd5 ("ext4: trim allocation requests to group size")
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Signed-off-by: Baokun Li <libaokun1@huawei.com>
>> ---
>> V1->V2:
>> 	Replace round_down() with rounddown().
>> 	Modified comments.
>> V2->V3:
>> 	Convert EXT4_BLOCKS_PER_GROUP type to ext4_lblk_t
>> 	to avoid compilation warnings.
> Looks good to me. Feel free to add -
>
> Reviewed-by: Ritesh Harjani <ritesh.list@gmail.com>
>
>>   fs/ext4/mballoc.c | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
> .
>
Thank you for your review!
-- 
With Best Regards,
Baokun Li

