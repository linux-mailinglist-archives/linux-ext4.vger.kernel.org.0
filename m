Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEB686444CF
	for <lists+linux-ext4@lfdr.de>; Tue,  6 Dec 2022 14:44:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbiLFNoz (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 6 Dec 2022 08:44:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiLFNoy (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 6 Dec 2022 08:44:54 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B77BC2981E;
        Tue,  6 Dec 2022 05:44:51 -0800 (PST)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NRM8G6pkgzmWLK;
        Tue,  6 Dec 2022 21:43:58 +0800 (CST)
Received: from [10.174.178.185] (10.174.178.185) by
 canpemm500010.china.huawei.com (7.192.105.118) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 6 Dec 2022 21:44:47 +0800
Subject: Re: [PATCH -next 1/6] ext4: fix WARNING in ext4_expand_extra_isize_ea
To:     Jan Kara <jack@suse.cz>, Ye Bin <yebin@huaweicloud.com>
References: <20221206015806.3420321-1-yebin@huaweicloud.com>
 <20221206015806.3420321-2-yebin@huaweicloud.com>
 <20221206120417.225uxtlg255bzph4@quack3>
CC:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
        <linux-ext4@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <syzbot+4d99a966fd74bdeeec36@syzkaller.appspotmail.com>
From:   "yebin (H)" <yebin10@huawei.com>
Message-ID: <638F474E.9070901@huawei.com>
Date:   Tue, 6 Dec 2022 21:44:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
MIME-Version: 1.0
In-Reply-To: <20221206120417.225uxtlg255bzph4@quack3>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.185]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500010.china.huawei.com (7.192.105.118)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On 2022/12/6 20:04, Jan Kara wrote:
> On Tue 06-12-22 09:58:01, Ye Bin wrote:
>> From: Ye Bin <yebin10@huawei.com>
>>
>> Syzbot found the following issue:
>> ------------[ cut here ]------------
>> WARNING: CPU: 1 PID: 3631 at mm/page_alloc.c:5534 __alloc_pages+0x30a/0x560 mm/page_alloc.c:5534
>> Modules linked in:
>> CPU: 1 PID: 3631 Comm: syz-executor261 Not tainted 6.1.0-rc6-syzkaller-00308-g644e9524388a #0
>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
>> RIP: 0010:__alloc_pages+0x30a/0x560 mm/page_alloc.c:5534
>> RSP: 0018:ffffc90003ccf080 EFLAGS: 00010246
>> RAX: ffffc90003ccf0e0 RBX: 000000000000000c RCX: 0000000000000000
>> RDX: 0000000000000028 RSI: 0000000000000000 RDI: ffffc90003ccf108
>> RBP: ffffc90003ccf198 R08: dffffc0000000000 R09: ffffc90003ccf0e0
>> R10: fffff52000799e21 R11: 1ffff92000799e1c R12: 0000000000040c40
>> R13: 1ffff92000799e18 R14: dffffc0000000000 R15: 1ffff92000799e14
>> FS:  0000555555c10300(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: 00007ffc36f70000 CR3: 00000000744ad000 CR4: 00000000003506e0
>> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>> Call Trace:
>>   <TASK>
>>   __alloc_pages_node include/linux/gfp.h:223 [inline]
>>   alloc_pages_node include/linux/gfp.h:246 [inline]
>>   __kmalloc_large_node+0x8a/0x1a0 mm/slab_common.c:1096
>>   __do_kmalloc_node mm/slab_common.c:943 [inline]
>>   __kmalloc+0xfe/0x1a0 mm/slab_common.c:968
>>   kmalloc include/linux/slab.h:558 [inline]
>>   ext4_xattr_move_to_block fs/ext4/xattr.c:2558 [inline]
>>   ext4_xattr_make_inode_space fs/ext4/xattr.c:2673 [inline]
>>   ext4_expand_extra_isize_ea+0xe3f/0x1cd0 fs/ext4/xattr.c:2765
>>   __ext4_expand_extra_isize+0x2b8/0x3f0 fs/ext4/inode.c:5857
>>   ext4_try_to_expand_extra_isize fs/ext4/inode.c:5900 [inline]
>>   __ext4_mark_inode_dirty+0x51a/0x670 fs/ext4/inode.c:5978
>>   ext4_inline_data_truncate+0x548/0xd00 fs/ext4/inline.c:2021
>>   ext4_truncate+0x341/0xeb0 fs/ext4/inode.c:4221
>>   ext4_process_orphan+0x1aa/0x2d0 fs/ext4/orphan.c:339
>>   ext4_orphan_cleanup+0xb60/0x1340 fs/ext4/orphan.c:474
>>   __ext4_fill_super fs/ext4/super.c:5515 [inline]
>>   ext4_fill_super+0x80ed/0x8610 fs/ext4/super.c:5643
>>   get_tree_bdev+0x400/0x620 fs/super.c:1324
>>   vfs_get_tree+0x88/0x270 fs/super.c:1531
>>   do_new_mount+0x289/0xad0 fs/namespace.c:3040
>>   do_mount fs/namespace.c:3383 [inline]
>>   __do_sys_mount fs/namespace.c:3591 [inline]
>>   __se_sys_mount+0x2d3/0x3c0 fs/namespace.c:3568
>>   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>>   do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
>>   entry_SYSCALL_64_after_hwframe+0x63/0xcd
>>   </TASK>
>>
>> Reason is allocate 16M memory by kmalloc, but MAX_ORDER is 11, kmalloc
>> can allocate maxium size memory is 4M.
>> XATTR_SIZE_MAX is currently 64k, but EXT4_XATTR_SIZE_MAX is '(1 << 24)',
>> so 'ext4_xattr_check_entries()' regards this length as legal. Then trigger
>> warning in 'ext4_xattr_move_to_block()'.
>> To solve above issue, according to Jan Kara's suggestion use kvmalloc()
>> to allocate memory in ext4_xattr_move_to_block().
>>
>> Reported-by: syzbot+4d99a966fd74bdeeec36@syzkaller.appspotmail.com
>> Fixes: 54dd0e0a1b25 ("ext4: add extra checks to ext4_xattr_block_get()")
>> Signed-off-by: Ye Bin <yebin10@huawei.com>
> The changelog speak about kvmalloc() while your patch changes
> EXT4_XATTR_SIZE_MAX. This needs to be fixed. If Ted is find with this
> change, I have no problem with it either but I remember there were some
> discussions about what EXT4_XATTR_SIZE_MAX should be when ea_inode feature
> has been developed. Ted might remember.

I'm sorry I forgot to modify the commit message, I will modify the 
changelog again.

> Also the change from kmalloc() to kvmalloc() is a desirable one anyway. It
> is not always easy to find physically contiguous 64k of memory so
> kvmalloc() makes the allocation much more likely to succeed.
>
> 								Honza

A later patch use kvmalloc to allocate  extended attribute value memory.


