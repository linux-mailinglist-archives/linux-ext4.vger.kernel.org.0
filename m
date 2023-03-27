Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C068A6CA533
	for <lists+linux-ext4@lfdr.de>; Mon, 27 Mar 2023 15:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbjC0NJr (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 27 Mar 2023 09:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjC0NJq (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 27 Mar 2023 09:09:46 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF7DDDF;
        Mon, 27 Mar 2023 06:09:44 -0700 (PDT)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4PlY6D2tp4zrY40;
        Mon, 27 Mar 2023 21:08:36 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 27 Mar 2023 21:09:42 +0800
Message-ID: <a4ee8f3e-9428-ebb1-c0b4-9348075902b6@huawei.com>
Date:   Mon, 27 Mar 2023 21:09:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH] ext4: only update i_reserved_data_blocks on successful
 block allocation
Content-Language: en-US
To:     Jan Kara <jack@suse.cz>
CC:     <linux-ext4@vger.kernel.org>, <tytso@mit.edu>,
        <adilger.kernel@dilger.ca>, <ritesh.list@gmail.com>,
        <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>,
        <yangerkun@huawei.com>, <yukuai3@huawei.com>,
        Baokun Li <libaokun1@huawei.com>
References: <20230325063443.1839558-1-libaokun1@huawei.com>
 <20230327124700.mnldh4sosp3ptbls@quack3>
From:   Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20230327124700.mnldh4sosp3ptbls@quack3>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.174]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500021.china.huawei.com (7.185.36.21)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.3 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 2023/3/27 20:47, Jan Kara wrote:
> On Sat 25-03-23 14:34:43, Baokun Li wrote:
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
> Hum, but this second call to ext4_map_blocks() should find already allocated
> blocks in the indirect block and thus should not be subtracting
> ei->i_reserved_data_blocks for the second time. What am I missing?
>
> 								Honza
>
ext4_map_blocks
   1. Lookup extent status tree firstly
        goto found;
   2. get the block without requesting a new file system block.
found:
   3. ceate and map the block

When we call ext4_map_blocks() for the second time, we directly find the
corresponding blocks in the extent status tree, and then go directly to 
step 3,
because our flag is brand new and therefore does not contain EXT4_MAP_MAPPED
but contains EXT4_GET_BLOCKS_CREATE, thus subtracting 
ei->i_reserved_data_blocks
for the second time.

Thanks!
-- 
With Best Regards,
Baokun Li
.
