Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C36558E7C0
	for <lists+linux-ext4@lfdr.de>; Wed, 10 Aug 2022 09:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbiHJHU4 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 10 Aug 2022 03:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbiHJHUz (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 10 Aug 2022 03:20:55 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9518CF5C;
        Wed, 10 Aug 2022 00:20:52 -0700 (PDT)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4M2h9J3grLzfYwv;
        Wed, 10 Aug 2022 15:17:56 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 10 Aug 2022 15:20:49 +0800
Message-ID: <c937578b-e7f2-79cb-2e81-3330edf2bf6c@huawei.com>
Date:   Wed, 10 Aug 2022 15:20:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] ext4: fix null-ptr-deref in ext4_write_info
To:     Lukas Czerner <lczerner@redhat.com>
CC:     <linux-ext4@vger.kernel.org>, <tytso@mit.edu>,
        <adilger.kernel@dilger.ca>, <jack@suse.cz>,
        <ritesh.list@gmail.com>, <enwlinux@gmail.com>,
        <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>,
        <yebin10@huawei.com>, <yukuai3@huawei.com>,
        Baokun Li <libaokun1@huawei.com>
References: <20220805123947.565152-1-libaokun1@huawei.com>
 <20220805130726.a3otpkbrjv3ijumd@fedora>
From:   Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20220805130726.a3otpkbrjv3ijumd@fedora>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.174]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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

在 2022/8/5 21:07, Lukas Czerner 写道:
> On Fri, Aug 05, 2022 at 08:39:47PM +0800, Baokun Li wrote:
>> I caught a null-ptr-deref bug as follows:
>> ==================================================================
>> KASAN: null-ptr-deref in range [0x0000000000000068-0x000000000000006f]
>> CPU: 1 PID: 1589 Comm: umount Not tainted 5.10.0-02219-dirty #339
>> RIP: 0010:ext4_write_info+0x53/0x1b0
>> [...]
>> Call Trace:
>>   dquot_writeback_dquots+0x341/0x9a0
>>   ext4_sync_fs+0x19e/0x800
>>   __sync_filesystem+0x83/0x100
>>   sync_filesystem+0x89/0xf0
>>   generic_shutdown_super+0x79/0x3e0
>>   kill_block_super+0xa1/0x110
>>   deactivate_locked_super+0xac/0x130
>>   deactivate_super+0xb6/0xd0
>>   cleanup_mnt+0x289/0x400
>>   __cleanup_mnt+0x16/0x20
>>   task_work_run+0x11c/0x1c0
>>   exit_to_user_mode_prepare+0x203/0x210
>>   syscall_exit_to_user_mode+0x5b/0x3a0
>>   do_syscall_64+0x59/0x70
>>   entry_SYSCALL_64_after_hwframe+0x44/0xa9
>>   ==================================================================
>>
>> Above issue may happen as follows:
>> -------------------------------------
>> exit_to_user_mode_prepare
>>   task_work_run
>>    __cleanup_mnt
>>     cleanup_mnt
>>      deactivate_super
>>       deactivate_locked_super
>>        kill_block_super
>>         generic_shutdown_super
>>          shrink_dcache_for_umount
>>           dentry = sb->s_root
>>           sb->s_root = NULL              <--- Here set NULL
>>          sync_filesystem
>>           __sync_filesystem
>>            sb->s_op->sync_fs > ext4_sync_fs
>>             dquot_writeback_dquots
>>              sb->dq_op->write_info > ext4_write_info
>>               ext4_journal_start(d_inode(sb->s_root), EXT4_HT_QUOTA, 2)
>>                d_inode(sb->s_root)
>>                 s_root->d_inode          <--- Null pointer dereference
>>
>> To solve this problem, we use ext4_journal_start_sb directly
>> to avoid s_root being used.
> Are we syncing the file system after the superblock shutdown and getting
> away with it? This does not look good. Do you have a reproducer?
>
> Thanks!
> -Lukas

Hi, Lukas!

This problem is triggered by a pressure test when I reproduce another 
problem.

So I didn't have the reproducer.

I looked at the error stack code and found that it seems there is 
something wrong.

Moreover, it's really weird to write code like 
"ext4_journal_start(d_inode(sb->s_root), ...)".

>> Signed-off-by: Baokun Li <libaokun1@huawei.com>
>> ---
>>   fs/ext4/super.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
>> index 9a66abcca1a8..0ce4565422f6 100644
>> --- a/fs/ext4/super.c
>> +++ b/fs/ext4/super.c
>> @@ -6653,7 +6653,7 @@ static int ext4_write_info(struct super_block *sb, int type)
>>   	handle_t *handle;
>>   
>>   	/* Data block + inode block */
>> -	handle = ext4_journal_start(d_inode(sb->s_root), EXT4_HT_QUOTA, 2);
>> +	handle = ext4_journal_start_sb(sb, EXT4_HT_QUOTA, 2);
>>   	if (IS_ERR(handle))
>>   		return PTR_ERR(handle);
>>   	ret = dquot_commit_info(sb, type);
>> -- 
>> 2.31.1
>>
> .


Thanks!

-- 
With Best Regards,
Baokun Li

