Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 409FD53742B
	for <lists+linux-ext4@lfdr.de>; Mon, 30 May 2022 06:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232459AbiE3EzZ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 30 May 2022 00:55:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232388AbiE3EzY (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 30 May 2022 00:55:24 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 049702E9EC
        for <linux-ext4@vger.kernel.org>; Sun, 29 May 2022 21:55:21 -0700 (PDT)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LBNNh5FByzjXCL;
        Mon, 30 May 2022 12:54:12 +0800 (CST)
Received: from [10.174.178.134] (10.174.178.134) by
 canpemm500005.china.huawei.com (7.192.104.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 30 May 2022 12:55:19 +0800
Subject: Re: [PATCH] ext4: add reserved GDT blocks check
To:     Ritesh Harjani <ritesh.list@gmail.com>
CC:     <linux-ext4@vger.kernel.org>, <tytso@mit.edu>,
        <adilger.kernel@dilger.ca>, <jack@suse.cz>, <yukuai3@huawei.com>,
        <lilingfeng3@huawei.com>
References: <20220526073222.380259-1-yi.zhang@huawei.com>
 <20220528150111.jw7env3gkpt24a2i@riteshh-domain>
From:   Zhang Yi <yi.zhang@huawei.com>
Message-ID: <95609364-e148-afe2-42fa-57cc91ed15d6@huawei.com>
Date:   Mon, 30 May 2022 12:55:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20220528150111.jw7env3gkpt24a2i@riteshh-domain>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.134]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500005.china.huawei.com (7.192.104.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 2022/5/28 23:01, Ritesh Harjani wrote:
> On 22/05/26 03:32PM, Zhang Yi wrote:
>> We capture a NULL pointer issue when resizing a corrupt ext4 image which
>> is freshly clear resize_inode feature (not run e2fsck). It could be
>> simply reproduced by following steps. The problem is because of the
>> resize_inode feature was cleared, and it will convert the filesystem to
>> meta_bg mode in ext4_resize_fs(), but the es->s_reserved_gdt_blocks was
>> not reduced to zero, so could we mistakenly call reserve_backup_gdb()
>> and passing an uninitialized resize_inode to it when adding new group
>> descriptors.
>>
>>  mkfs.ext4 /dev/sda 3G
>>  tune2fs -O ^resize_inode /dev/sda #forget to run requested e2fsck
>>  mount /dev/sda /mnt
>>  resize2fs /dev/sda 8G
>>
>>  ========
>>  BUG: kernel NULL pointer dereference, address: 0000000000000028
>>  CPU: 19 PID: 3243 Comm: resize2fs Not tainted 5.18.0-rc7-00001-gfde086c5ebfd #748
>>  ...
>>  RIP: 0010:ext4_flex_group_add+0xe08/0x2570
>>  ...
>>  Call Trace:
>>   <TASK>
>>   ext4_resize_fs+0xbec/0x1660
>>   __ext4_ioctl+0x1749/0x24e0
>>   ext4_ioctl+0x12/0x20
>>   __x64_sys_ioctl+0xa6/0x110
>>   do_syscall_64+0x3b/0x90
>>   entry_SYSCALL_64_after_hwframe+0x44/0xae
>>  RIP: 0033:0x7f2dd739617b
>>  ========
>>
>> The fix is simple, add a check in ext4_resize_fs() to make sure that the
>> es->s_reserved_gdt_blocks is zero when the resize_inode feature is
>> disabled.
> 
> Your reasoning looks correct to me.
> 
>>
>> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
>> ---
>>  fs/ext4/resize.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/fs/ext4/resize.c b/fs/ext4/resize.c
>> index 90a941d20dff..5791eb7c0761 100644
>> --- a/fs/ext4/resize.c
>> +++ b/fs/ext4/resize.c
>> @@ -2031,6 +2031,9 @@ int ext4_resize_fs(struct super_block *sb, ext4_fsblk_t n_blocks_count)
>>  			ext4_warning(sb, "Error opening resize inode");
>>  			return PTR_ERR(resize_inode);
>>  		}
>> +	} else if (es->s_reserved_gdt_blocks) {
>> +		ext4_error(sb, "resize_inode disabled but reserved GDT blocks non-zero");
>> +		return -EFSCORRUPTED;
>>  	}
> 
> I think we should do this check in ext4_resize_begin(), i.e.
> if ext4_has_feature_resize_inode() is false and es->s_reserved_gdt_blocks is
> non-zero, then we should straight away mark and return error.
> 

Thanks for your suggestion. Yes, put this check in ext4_resize_begin() looks
better, it is also useful for EXT4_IOC_GROUP_ADD (although we have a check in
ext4_group_add() already, it is still worth). I will put this check into
ext4_resize_begin() in my next iteration.

> Later (not as part of this patch/fix) maybe if we detect this problem, we could
> use helpers like ext4_update_super() to fix this mismatch problem in kernel
> during mount itself. But I think this is not absolutely necessary,
> as kernel already during mount outputs a warning and ask for running e2fsck.
> 

I think the warning from mount outputs is enough, sysadmins should run e2fsck
after getting this note. It's hard and costly if we want to fix this inconsistent
problem in kernel because from the kernel's point of view, if it detect above
inconsistency, it means that both of the es->s_reserved_gdt_blocks and resize_inode
feature are not trusted anymore, we have to do in depth check as e2fsck does, and
it's hard to make a fix decision automatically(not even e2fsck).

Thanks,
Yi.
