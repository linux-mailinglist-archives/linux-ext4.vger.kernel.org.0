Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B17877BD52
	for <lists+linux-ext4@lfdr.de>; Mon, 14 Aug 2023 17:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbjHNPm6 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 14 Aug 2023 11:42:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjHNPml (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 14 Aug 2023 11:42:41 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4B5710CE;
        Mon, 14 Aug 2023 08:42:39 -0700 (PDT)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RPdqx5JyqzFqXL;
        Mon, 14 Aug 2023 23:39:41 +0800 (CST)
Received: from [10.174.178.185] (10.174.178.185) by
 canpemm500010.china.huawei.com (7.192.105.118) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 14 Aug 2023 23:42:37 +0800
Subject: Re: [PATCH 1/2] ext2: fix race between setxattr and write back
To:     Jan Kara <jack@suse.cz>
References: <20230811033857.1800578-1-yebin10@huawei.com>
 <20230811033857.1800578-2-yebin10@huawei.com>
 <20230814124610.uyzbvktfwzjwypee@quack3>
CC:     <linux-ext4@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From:   "yebin (H)" <yebin10@huawei.com>
Message-ID: <64DA4B6C.9020603@huawei.com>
Date:   Mon, 14 Aug 2023 23:42:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
MIME-Version: 1.0
In-Reply-To: <20230814124610.uyzbvktfwzjwypee@quack3>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.185]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500010.china.huawei.com (7.192.105.118)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On 2023/8/14 20:46, Jan Kara wrote:
> On Fri 11-08-23 11:38:56, Ye Bin wrote:
>> There's a issue as follows:
>> Block Allocation Reservation Windows Map (ext2_try_to_allocate_with_rsv):
>> reservation window 0x000000006f105382 start: 0, end: 0
>> reservation window 0x000000008fd1a555 start: 1044, end: 1059
>> Window map complete.
>> kernel BUG at fs/ext2/balloc.c:1158!
>> invalid opcode: 0000 [#1] PREEMPT SMP KASAN
>> RIP: 0010:ext2_try_to_allocate_with_rsv.isra.0+0x15c4/0x1800
>> Call Trace:
>>   <TASK>
>>   ext2_new_blocks+0x935/0x1690
>>   ext2_new_block+0x73/0xa0
>>   ext2_xattr_set2+0x74f/0x1730
>>   ext2_xattr_set+0x12b6/0x2260
>>   ext2_xattr_user_set+0x9c/0x110
>>   __vfs_setxattr+0x139/0x1d0
>>   __vfs_setxattr_noperm+0xfc/0x370
>>   __vfs_setxattr_locked+0x205/0x2c0
>>   vfs_setxattr+0x19d/0x3b0
>>   do_setxattr+0xff/0x220
>>   setxattr+0x123/0x150
>>   path_setxattr+0x193/0x1e0
>>   __x64_sys_setxattr+0xc8/0x170
>>   do_syscall_64+0x35/0x80
>>   entry_SYSCALL_64_after_hwframe+0x63/0xcd
>>
>> Above issue may happens as follows:
>>          setxattr                             write back
>> ext2_xattr_set
>>    ext2_xattr_set2
>>      ext2_new_block
>>        ext2_new_blocks
>>          ext2_try_to_allocate_with_rsv
>> 	  alloc_new_reservation
>> 	  --> group=0 [0, 1023] rsv [1016, 1023]
>> 	                                do_writepages
>> 					  mpage_writepages
>> 					    write_cache_pages
>> 					      __mpage_writepage
>> 					        ext2_get_block
>> 						  ext2_get_blocks
>> 						   ext2_alloc_branch
>> 						    ext2_new_blocks
>> 						     ext2_try_to_allocate_with_rsv
>> 						       alloc_new_reservation
>> 		                     -->group=1 [1024, 2047] rsv [1044, 1059]
>> 	  if ((my_rsv->rsv_start > group_last_block) ||
>> 	      (my_rsv->rsv_end < group_first_block)
>> 	      rsv_window_dump
>> 	      BUG();
>> Now ext2 mkwrite delay allocate new blocks. So there maybe allocate blocks when
>> do write back. However, there is no concurrent protection between
>> ext2_xattr_set() and do_writepages().
>> To solve about issue hold '&ei->truncate_mutex' lock when new block for xattr.
>>
>> Signed-off-by: Ye Bin <yebin10@huawei.com>
> Thanks for the patch! I agree the handling of reservation window and its
> use for block allocation needs to be protected by ei->i_truncate_mutex.
> However in this particular case of xattr allocation where we want to
> allocate just one block which is completely independent of file data, I'd
> rather choose to make ext2_new_blocks() ignore the reservation window (set
> my_rsv to NULL). There's already a logic at the beginning of
> ext2_new_blocks() deciding whether to use the reservation window or not and
> we could extend it - probably by adding flags argument to it a introducing
> a NORESERVE flag.
>
> Also as a preparatory patch, I'd just remove ext2_new_block() and opencode
> it in the xattr code since it has only that one user anyway.
>
> 								Honza
>
Thanks for your suggestion.  I will send new version according to your 
suggestion.
>
>> ---
>>   fs/ext2/balloc.c | 8 +++++++-
>>   1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/ext2/balloc.c b/fs/ext2/balloc.c
>> index c8049c90323d..039f655febfd 100644
>> --- a/fs/ext2/balloc.c
>> +++ b/fs/ext2/balloc.c
>> @@ -1432,8 +1432,14 @@ ext2_fsblk_t ext2_new_blocks(struct inode *inode, ext2_fsblk_t goal,
>>   ext2_fsblk_t ext2_new_block(struct inode *inode, unsigned long goal, int *errp)
>>   {
>>   	unsigned long count = 1;
>> +	struct ext2_inode_info *ei = EXT2_I(inode);
>> +	ext2_fsblk_t ret;
>> +
>> +	mutex_lock(&ei->truncate_mutex);
>> +	ret = ext2_new_blocks(inode, goal, &count, errp);
>> +	mutex_unlock(&ei->truncate_mutex);
>>   
>> -	return ext2_new_blocks(inode, goal, &count, errp);
>> +	return ret;
>>   }
>>   
>>   #ifdef EXT2FS_DEBUG
>> -- 
>> 2.31.1
>>

