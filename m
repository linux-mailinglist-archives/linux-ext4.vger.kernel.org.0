Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B65E60C1E5
	for <lists+linux-ext4@lfdr.de>; Tue, 25 Oct 2022 04:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbiJYCsh (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 24 Oct 2022 22:48:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230336AbiJYCsg (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 24 Oct 2022 22:48:36 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E40B082870;
        Mon, 24 Oct 2022 19:48:35 -0700 (PDT)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MxGbB425tzHvBM;
        Tue, 25 Oct 2022 10:48:22 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 25 Oct 2022 10:48:33 +0800
Message-ID: <370a7ef1-885b-66b6-2282-fcc2a1dcfcec@huawei.com>
Date:   Tue, 25 Oct 2022 10:48:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH v2 1/2] ext4: fix bug_on in __es_tree_search caused by
 wrong s_usr_quota_inum
Content-Language: en-US
To:     Jan Kara <jack@suse.cz>
CC:     <linux-ext4@vger.kernel.org>, <tytso@mit.edu>,
        <adilger.kernel@dilger.ca>, <ritesh.list@gmail.com>,
        <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>,
        <yukuai3@huawei.com>, Baokun Li <libaokun1@huawei.com>
References: <20221021040731.4180649-1-libaokun1@huawei.com>
 <20221021040731.4180649-2-libaokun1@huawei.com>
 <20221024141053.n3ds3q37abdajrto@quack3>
 <20221024141630.r6egasefk744taxi@quack3>
From:   Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20221024141630.r6egasefk744taxi@quack3>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.174]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500021.china.huawei.com (7.185.36.21)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 2022/10/24 22:16, Jan Kara wrote:
> On Mon 24-10-22 16:10:53, Jan Kara wrote:
>> On Fri 21-10-22 12:07:30, Baokun Li wrote:
>>> We got a issue as fllows:
>>> ==================================================================
>>>   kernel BUG at fs/ext4/extents_status.c:202!
>>>   invalid opcode: 0000 [#1] PREEMPT SMP
>>>   CPU: 1 PID: 810 Comm: mount Not tainted 6.1.0-rc1-next-g9631525255e3 #352
>>>   RIP: 0010:__es_tree_search.isra.0+0xb8/0xe0
>>>   RSP: 0018:ffffc90001227900 EFLAGS: 00010202
>>>   RAX: 0000000000000000 RBX: 0000000077512a0f RCX: 0000000000000000
>>>   RDX: 0000000000000002 RSI: 0000000000002a10 RDI: ffff8881004cd0c8
>>>   RBP: ffff888177512ac8 R08: 47ffffffffffffff R09: 0000000000000001
>>>   R10: 0000000000000001 R11: 00000000000679af R12: 0000000000002a10
>>>   R13: ffff888177512d88 R14: 0000000077512a10 R15: 0000000000000000
>>>   FS: 00007f4bd76dbc40(0000)GS:ffff88842fd00000(0000)knlGS:0000000000000000
>>>   CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>   CR2: 00005653bf993cf8 CR3: 000000017bfdf000 CR4: 00000000000006e0
>>>   DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>>>   DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>>>   Call Trace:
>>>    <TASK>
>>>    ext4_es_cache_extent+0xe2/0x210
>>>    ext4_cache_extents+0xd2/0x110
>>>    ext4_find_extent+0x5d5/0x8c0
>>>    ext4_ext_map_blocks+0x9c/0x1d30
>>>    ext4_map_blocks+0x431/0xa50
>>>    ext4_getblk+0x82/0x340
>>>    ext4_bread+0x14/0x110
>>>    ext4_quota_read+0xf0/0x180
>>>    v2_read_header+0x24/0x90
>>>    v2_check_quota_file+0x2f/0xa0
>>>    dquot_load_quota_sb+0x26c/0x760
>>>    dquot_load_quota_inode+0xa5/0x190
>>>    ext4_enable_quotas+0x14c/0x300
>>>    __ext4_fill_super+0x31cc/0x32c0
>>>    ext4_fill_super+0x115/0x2d0
>>>    get_tree_bdev+0x1d2/0x360
>>>    ext4_get_tree+0x19/0x30
>>>    vfs_get_tree+0x26/0xe0
>>>    path_mount+0x81d/0xfc0
>>>    do_mount+0x8d/0xc0
>>>    __x64_sys_mount+0xc0/0x160
>>>    do_syscall_64+0x35/0x80
>>>    entry_SYSCALL_64_after_hwframe+0x63/0xcd
>>>    </TASK>
>>> ==================================================================
>>>
>>> Above issue may happen as follows:
>>> -------------------------------------
>>> ext4_fill_super
>>>   ext4_orphan_cleanup
>>>    ext4_enable_quotas
>>>     ext4_quota_enable
>>>      ext4_iget --> get error inode <5>
>>>       ext4_ext_check_inode --> Wrong imode makes it escape inspection
>>>       make_bad_inode(inode) --> EXT4_BOOT_LOADER_INO set imode
>>>      dquot_load_quota_inode
>>>       vfs_setup_quota_inode --> check pass
>>>       dquot_load_quota_sb
>>>        v2_check_quota_file
>>>         v2_read_header
>>>          ext4_quota_read
>>>           ext4_bread
>>>            ext4_getblk
>>>             ext4_map_blocks
>>>              ext4_ext_map_blocks
>>>               ext4_find_extent
>>>                ext4_cache_extents
>>>                 ext4_es_cache_extent
>>>                  __es_tree_search.isra.0
>>>                   ext4_es_end --> Wrong extents trigger BUG_ON
>>>
>>> In the above issue, s_usr_quota_inum is set to 5, but inode<5> contains
>>> incorrect imode and disordered extents. Because 5 is EXT4_BOOT_LOADER_INO,
>>> the ext4_ext_check_inode check in the ext4_iget function can be bypassed,
>>> finally, the extents that are not checked trigger the BUG_ON in the
>>> __es_tree_search function. To solve this issue, check whether qf_inode
>>> obtained by ext4_iget is bad_inode.
>>>
>>> Signed-off-by: Baokun Li <libaokun1@huawei.com>
>> Looks good to me. Feel free to add:
>>
>> Reviewed-by: Jan Kara <jack@suse.cz>
> Hum, on a second thought: Would not it be better if vfs_setup_quota_inode()
> actually checked for bad inode and refused it with EUCLEAN? That would
> sound like a more generic approach (covers all filesystems) to this
> problem.
>
> 								Honza

Hello Honza,

Totally agree with you! We initially added the check to 
vfs_setup_quota_inode(),
because the check for imode is here. However, in ext4_quota_enable, if 
qf_inode
is abnormal, "Bad quota inode..." is printed. Therefore, we feel that 
adding a check
here can help us quickly find out where the problem occurs.
Perhaps we should still add the check to vfs_setup_quota_inode() and 
also add the
print ino when ext4_enable_quotas fails.


Thank you for your review!
-- 
With Best Regards,
Baokun Li

