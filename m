Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81C6E597B38
	for <lists+linux-ext4@lfdr.de>; Thu, 18 Aug 2022 03:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234003AbiHRByv (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 17 Aug 2022 21:54:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbiHRByu (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 17 Aug 2022 21:54:50 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C34F44563;
        Wed, 17 Aug 2022 18:54:48 -0700 (PDT)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4M7SZB1yK4zmVwD;
        Thu, 18 Aug 2022 09:52:34 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 18 Aug 2022 09:54:46 +0800
Message-ID: <803e4ab0-e336-5434-2827-a5091eefad59@huawei.com>
Date:   Thu, 18 Aug 2022 09:54:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH 2/2] ext4: add inode table check in __ext4_get_inode_loc
 to aovid possible infinite loop
Content-Language: en-US
To:     Jan Kara <jack@suse.cz>
CC:     <linux-ext4@vger.kernel.org>, <tytso@mit.edu>,
        <adilger.kernel@dilger.ca>, <ritesh.list@gmail.com>,
        <lczerner@redhat.com>, <enwlinux@gmail.com>,
        <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>,
        <yebin10@huawei.com>, <yukuai3@huawei.com>,
        Baokun Li <libaokun1@huawei.com>
References: <20220817132701.3015912-1-libaokun1@huawei.com>
 <20220817132701.3015912-3-libaokun1@huawei.com>
 <20220817143138.7krkxzoa3skruiyx@quack3>
From:   Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20220817143138.7krkxzoa3skruiyx@quack3>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.174]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500021.china.huawei.com (7.185.36.21)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 8/17/2022 10:31 PM, Jan Kara wrote:
> On Wed 17-08-22 21:27:01, Baokun Li wrote:
>> In do_writepages, if the value returned by ext4_writepages is "-ENOMEM"
>> and "wbc->sync_mode == WB_SYNC_ALL", retry until the condition is not met.
>>
>> In __ext4_get_inode_loc, if the bh returned by sb_getblk is NULL,
>> the function returns -ENOMEM.
>>
>> In __getblk_slow, if the return value of grow_buffers is less than 0,
>> the function returns NULL.
>>
>> When the three processes are connected in series like the following stack,
>> an infinite loop may occur:
>>
>> do_writepages					<--- keep retrying
>>   ext4_writepages
>>    mpage_map_and_submit_extent
>>     mpage_map_one_extent
>>      ext4_map_blocks
>>       ext4_ext_map_blocks
>>        ext4_ext_handle_unwritten_extents
>>         ext4_ext_convert_to_initialized
>>          ext4_split_extent
>>           ext4_split_extent_at
>>            __ext4_ext_dirty
>>             __ext4_mark_inode_dirty
>>              ext4_reserve_inode_write
>>               ext4_get_inode_loc
>>                __ext4_get_inode_loc		<--- return -ENOMEM
>>                 sb_getblk
>>                  __getblk_gfp
>>                   __getblk_slow			<--- return NULL
>>                    grow_buffers
>>                     grow_dev_page		<--- return -ENXIO
>>                      ret = (block < end_block) ? 1 : -ENXIO;
>>
>> In this issue, bg_inode_table_hi is overwritten as an incorrect value.
>> As a result, `block < end_block` cannot be met in grow_dev_page.
>> Therefore, __ext4_get_inode_loc always returns '-ENOMEM' and do_writepages
>> keeps retrying. As a result, the writeback process is in the D state due
>> to an infinite loop.
>>
>> Add a check on inode table block in the __ext4_get_inode_loc function by
>> referring to ext4_read_inode_bitmap to avoid this infinite loop.
>>
>> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> Thanks for the fixes. Normally, we check that inode table is fine in
> ext4_check_descriptors() (and those checks are much stricter) so it seems
Yes, when I first found this problem, I thought that the inode table was 
an abnormal value
when the disk was mounted. However, in ext4_ check_ Descriptors see the 
inspection of inode table.
ext4_ check_ Descriptors is more strict, and it also checks blocks_ 
Bitmap and inode_ bitmap。

However, in addition to mounting, I can't find any changes to 
bg_inode_table_hi  in other parts of
the kernel, which makes me very confused. It wasn't until I tracked the 
address of the variable that
I found it was modified by memcpy.

This check is added here to facilitate us to find problems and avoid 
dead loops. Otherwise,
we may not find problems until the write back process is stuck in the D 
state for several hours.
  At this time, the file system may be in a mess.
> unnecessary to check it again here. I understand that in your case it was
> resize that corrupted the group descriptor after the filesystem was mounted
> which is nasty but there's much more metadata that can be corrupted like
> this and it's infeasible to check each metadata block before we use it.
Indeed, But is it true that checking for inode_bitmap in 
ext4_read_inode_bitmap and
checking for block_bitmap in ext4_read_block_bitmap_nowait also 
unnecessary?
After all, inode_bitmap and block_bitmap may be faulty only when the 
metadata  is corrupted.
I think it seems unreasonable that both block_bitmap and inode_bitmap 
have checks and inode_table does not.
>
> IMHO a proper fix to this class of issues would be for sb_getblk() to
> return proper error so that we can distinguish ENOMEM from other errors.

Totally agree! There is a FIXME in the comments of __getblk_gfp:

` ` `
__getblk_gfp() will lock up the machine if grow_dev_page's
try_to_free_buffers() attempt is failing. FIXME, perhaps?
` ` `

This is the same as this issue because the return value of the 
grow_buffers function is not propagated correctly.

> But that will be a larger undertaking...
>
> 								Honza
Yes, this function can be called in many places, and external interface 
changes are involved.
>> ---
>>   fs/ext4/inode.c | 10 +++++++++-
>>   1 file changed, 9 insertions(+), 1 deletion(-)
Thanks!
-- 
With Best Regards,
Baokun Li
