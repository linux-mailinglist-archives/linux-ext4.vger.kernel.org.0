Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8BA36A8E88
	for <lists+linux-ext4@lfdr.de>; Fri,  3 Mar 2023 02:14:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbjCCBOz (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 2 Mar 2023 20:14:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbjCCBN5 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 2 Mar 2023 20:13:57 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C92E75942C;
        Thu,  2 Mar 2023 17:12:16 -0800 (PST)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4PSVJP6wNDz9tDy;
        Fri,  3 Mar 2023 09:10:13 +0800 (CST)
Received: from [10.174.178.185] (10.174.178.185) by
 canpemm500010.china.huawei.com (7.192.105.118) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 3 Mar 2023 09:12:14 +0800
Subject: Re: [PATCH] ext4: fix use-after-free Read in ext4_find_extent for
 bigalloc + inline
To:     Ye Bin <yebin@huaweicloud.com>, <tytso@mit.edu>,
        <adilger.kernel@dilger.ca>, <linux-ext4@vger.kernel.org>
References: <20230104071559.2051847-1-yebin@huaweicloud.com>
CC:     <linux-kernel@vger.kernel.org>, <jack@suse.cz>,
        <syzbot+bf4bb7731ef73b83a3b4@syzkaller.appspotmail.com>
From:   "yebin (H)" <yebin10@huawei.com>
Message-ID: <6401496D.2090308@huawei.com>
Date:   Fri, 3 Mar 2023 09:12:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
MIME-Version: 1.0
In-Reply-To: <20230104071559.2051847-1-yebin@huaweicloud.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.185]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500010.china.huawei.com (7.192.105.118)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

ping...

On 2023/1/4 15:15, Ye Bin wrote:
> From: Ye Bin <yebin10@huawei.com>
>
> Syzbot found the following issue:
> loop0: detected capacity change from 0 to 2048
> EXT4-fs (loop0): mounted filesystem 00000000-0000-0000-0000-000000000000 without journal. Quota mode: none.
> ==================================================================
> BUG: KASAN: use-after-free in ext4_ext_binsearch_idx fs/ext4/extents.c:768 [inline]
> BUG: KASAN: use-after-free in ext4_find_extent+0x76e/0xd90 fs/ext4/extents.c:931
> Read of size 4 at addr ffff888073644750 by task syz-executor420/5067
>
> CPU: 0 PID: 5067 Comm: syz-executor420 Not tainted 6.2.0-rc1-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
> Call Trace:
>   <TASK>
>   __dump_stack lib/dump_stack.c:88 [inline]
>   dump_stack_lvl+0x1b1/0x290 lib/dump_stack.c:106
>   print_address_description+0x74/0x340 mm/kasan/report.c:306
>   print_report+0x107/0x1f0 mm/kasan/report.c:417
>   kasan_report+0xcd/0x100 mm/kasan/report.c:517
>   ext4_ext_binsearch_idx fs/ext4/extents.c:768 [inline]
>   ext4_find_extent+0x76e/0xd90 fs/ext4/extents.c:931
>   ext4_clu_mapped+0x117/0x970 fs/ext4/extents.c:5809
>   ext4_insert_delayed_block fs/ext4/inode.c:1696 [inline]
>   ext4_da_map_blocks fs/ext4/inode.c:1806 [inline]
>   ext4_da_get_block_prep+0x9e8/0x13c0 fs/ext4/inode.c:1870
>   ext4_block_write_begin+0x6a8/0x2290 fs/ext4/inode.c:1098
>   ext4_da_write_begin+0x539/0x760 fs/ext4/inode.c:3082
>   generic_perform_write+0x2e4/0x5e0 mm/filemap.c:3772
>   ext4_buffered_write_iter+0x122/0x3a0 fs/ext4/file.c:285
>   ext4_file_write_iter+0x1d0/0x18f0
>   call_write_iter include/linux/fs.h:2186 [inline]
>   new_sync_write fs/read_write.c:491 [inline]
>   vfs_write+0x7dc/0xc50 fs/read_write.c:584
>   ksys_write+0x177/0x2a0 fs/read_write.c:637
>   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>   do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
>   entry_SYSCALL_64_after_hwframe+0x63/0xcd
> RIP: 0033:0x7f4b7a9737b9
> RSP: 002b:00007ffc5cac3668 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f4b7a9737b9
> RDX: 00000000175d9003 RSI: 0000000020000200 RDI: 0000000000000004
> RBP: 00007f4b7a933050 R08: 0000000000000000 R09: 0000000000000000
> R10: 000000000000079f R11: 0000000000000246 R12: 00007f4b7a9330e0
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
>   </TASK>
>
> Above issue is happens when enable bigalloc and inline data feature. As
> commit 131294c35ed6 fixed delayed allocation bug in ext4_clu_mapped for
> bigalloc + inline. But it only resolved issue when has inline data, if
> inline data has been converted to extent(ext4_da_convert_inline_data_to_extent)
> before writepages, there is no EXT4_STATE_MAY_INLINE_DATA flag. However
> i_data is still store inline data in this scene. Then will trigger UAF
> when find extent.
> To resolve above issue, there is need to add judge "ext4_has_inline_data(inode)"
> in ext4_clu_mapped().
>
> Reported-by: syzbot+bf4bb7731ef73b83a3b4@syzkaller.appspotmail.com
> Fixes: 131294c35ed6 ("ext4: fix delayed allocation bug in ext4_clu_mapped for bigalloc + inline")
> Signed-off-by: Ye Bin <yebin10@huawei.com>
> ---
>   fs/ext4/extents.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index 9de1c9d1a13d..ee5acf2bd5e6 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -5802,7 +5802,8 @@ int ext4_clu_mapped(struct inode *inode, ext4_lblk_t lclu)
>   	 * mapped - no physical clusters have been allocated, and the
>   	 * file has no extents
>   	 */
> -	if (ext4_test_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA))
> +	if (ext4_test_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA) ||
> +	    ext4_has_inline_data(inode))
>   		return 0;
>   
>   	/* search for the extent closest to the first block in the cluster */

