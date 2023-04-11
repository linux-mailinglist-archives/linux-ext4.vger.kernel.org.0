Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA136DDD54
	for <lists+linux-ext4@lfdr.de>; Tue, 11 Apr 2023 16:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbjDKOLI (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 11 Apr 2023 10:11:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230274AbjDKOLF (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 11 Apr 2023 10:11:05 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B39094C1C;
        Tue, 11 Apr 2023 07:10:52 -0700 (PDT)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4PwnlX3wbZzrZn5;
        Tue, 11 Apr 2023 22:09:28 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 11 Apr 2023 22:10:50 +0800
Message-ID: <c42cda34-9a4b-155a-6a62-32afbe8f86f8@huawei.com>
Date:   Tue, 11 Apr 2023 22:10:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH v2 1/2] ext4: only update i_reserved_data_blocks on
 successful block allocation
Content-Language: en-US
To:     Jan Kara <jack@suse.cz>
CC:     <linux-ext4@vger.kernel.org>, <tytso@mit.edu>,
        <adilger.kernel@dilger.ca>, <ritesh.list@gmail.com>,
        <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>,
        <yangerkun@huawei.com>, <yukuai3@huawei.com>,
        Baokun Li <libaokun1@huawei.com>
References: <20230406132834.1669710-1-libaokun1@huawei.com>
 <20230406132834.1669710-2-libaokun1@huawei.com>
 <20230411090800.rrsvbab3tio7rs2m@quack3>
From:   Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20230411090800.rrsvbab3tio7rs2m@quack3>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.174]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500021.china.huawei.com (7.185.36.21)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.5 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 2023/4/11 17:08, Jan Kara wrote:
> On Thu 06-04-23 21:28:33, Baokun Li wrote:
>> In our fault injection test, we create an ext4 file, migrate it to
>> non-extent based file, then punch a hole and finally trigger a WARN_ON
>> in the ext4_da_update_reserve_space():
>>
>> EXT4-fs warning (device sda): ext4_da_update_reserve_space:369:
>> ino 14, used 11 with only 10 reserved data blocks
>>
>> When writing back a non-extent based file, if we enable delalloc, the
>> number of reserved blocks will be subtracted from the number of blocks
>> mapped by ext4_ind_map_blocks(), and the extent status tree will be
>> updated. We update the extent status tree by first removing the old
>> extent_status and then inserting the new extent_status. If the block range
>> we remove happens to be in an extent, then we need to allocate another
>> extent_status with ext4_es_alloc_extent().
>>
>>         use old    to remove   to add new
>>      |----------|------------|------------|
>>                old extent_status
>>
>> The problem is that the allocation of a new extent_status failed due to a
>> fault injection, and __es_shrink() did not get free memory, resulting in
>> a return of -ENOMEM. Then do_writepages() retries after receiving -ENOMEM,
>> we map to the same extent again, and the number of reserved blocks is again
>> subtracted from the number of blocks in that extent. Since the blocks in
>> the same extent are subtracted twice, we end up triggering WARN_ON at
>> ext4_da_update_reserve_space() because used > ei->i_reserved_data_blocks.
>>
>> For non-extent based file, we update the number of reserved blocks after
>> ext4_ind_map_blocks() is executed, which causes a problem that when we call
>> ext4_ind_map_blocks() to create a block, it doesn't always create a block,
>> but we always reduce the number of reserved blocks. So we move the logic
>> for updating reserved blocks to ext4_ind_map_blocks() to ensure that the
>> number of reserved blocks is updated only after we do succeed in allocating
>> some new blocks.
>>
>> Fixes: 5f634d064c70 ("ext4: Fix quota accounting error with fallocate")
>> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> Looks good, just one nit below.
>
>> diff --git a/fs/ext4/indirect.c b/fs/ext4/indirect.c
>> index c68bebe7ff4b..9acab70ddf5e 100644
>> --- a/fs/ext4/indirect.c
>> +++ b/fs/ext4/indirect.c
>> @@ -651,6 +651,14 @@ int ext4_ind_map_blocks(handle_t *handle, struct inode *inode,
>>   
>>   	ext4_update_inode_fsync_trans(handle, inode, 1);
>>   	count = ar.len;
>> +
>> +	/*
>> +	 * Update reserved blocks/metadata blocks after successful block
>> +	 * allocation which had been deferred till now.
>> +	 */
>> +	if ((count > 0) && (flags & EXT4_GET_BLOCKS_DELALLOC_RESERVE))
> You don't need the count > 0 condition here. It should be always true.
>
> 								Honza
>
Indeed!

Thanks a million!

I will remove this condition in patch v3.

-- 
With Best Regards,
Baokun Li
.
