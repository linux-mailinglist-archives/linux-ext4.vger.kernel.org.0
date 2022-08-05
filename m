Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B409D58A481
	for <lists+linux-ext4@lfdr.de>; Fri,  5 Aug 2022 03:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234902AbiHEBhI (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 4 Aug 2022 21:37:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240662AbiHEBg3 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 4 Aug 2022 21:36:29 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ACF023BCB
        for <linux-ext4@vger.kernel.org>; Thu,  4 Aug 2022 18:36:26 -0700 (PDT)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LzSkt5xldzWf8p;
        Fri,  5 Aug 2022 09:32:22 +0800 (CST)
Received: from [10.174.178.134] (10.174.178.134) by
 canpemm500005.china.huawei.com (7.192.104.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 5 Aug 2022 09:36:23 +0800
Subject: Re: [PATCH v3 1/2] ext4: silence the warning when evicting inode with
 dioread_nolock
To:     <tytso@mit.edu>
CC:     <jack@suse.cz>, <yukuai3@huawei.com>, <linux-ext4@vger.kernel.org>
References: <20220629112647.4141034-1-yi.zhang@huawei.com>
From:   Zhang Yi <yi.zhang@huawei.com>
Message-ID: <7701a2f8-5876-2795-4831-83a5d07eb70e@huawei.com>
Date:   Fri, 5 Aug 2022 09:36:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20220629112647.4141034-1-yi.zhang@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.134]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500005.china.huawei.com (7.192.104.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi, Ted.

Could you please pick up these two patches for 5.20?

Thanks,
Yi.

On 2022/6/29 19:26, Zhang Yi wrote:
> When evicting an inode with default dioread_nolock, it could be raced by
> the unwritten extents converting kworker after writeback some new
> allocated dirty blocks. It convert unwritten extents to written, the
> extents could be merged to upper level and free extent blocks, so it
> could mark the inode dirty again even this inode has been marked
> I_FREEING. But the inode->i_io_list check and warning in
> ext4_evict_inode() missing this corner case. Fortunately,
> ext4_evict_inode() will wait all extents converting finished before this
> check, so it will not lead to inode use-after-free problem, every thing
> is OK besides this warning. The WARN_ON_ONCE was originally designed
> for finding inode use-after-free issues in advance, but if we add
> current dioread_nolock case in, it will become not quite useful, so fix
> this warning by just remove this check.
> 
>  ======
>  WARNING: CPU: 7 PID: 1092 at fs/ext4/inode.c:227
>  ext4_evict_inode+0x875/0xc60
>  ...
>  RIP: 0010:ext4_evict_inode+0x875/0xc60
>  ...
>  Call Trace:
>   <TASK>
>   evict+0x11c/0x2b0
>   iput+0x236/0x3a0
>   do_unlinkat+0x1b4/0x490
>   __x64_sys_unlinkat+0x4c/0xb0
>   do_syscall_64+0x3b/0x90
>   entry_SYSCALL_64_after_hwframe+0x46/0xb0
>  RIP: 0033:0x7fa933c1115b
>  ======
> 
> rm                          kworker
>                             ext4_end_io_end()
> vfs_unlink()
>  ext4_unlink()
>                              ext4_convert_unwritten_io_end_vec()
>                               ext4_convert_unwritten_extents()
>                                ext4_map_blocks()
>                                 ext4_ext_map_blocks()
>                                  ext4_ext_try_to_merge_up()
>                                   __mark_inode_dirty()
>                                    check !I_FREEING
>                                    locked_inode_to_wb_and_lock_list()
>  iput()
>   iput_final()
>    evict()
>     ext4_evict_inode()
>      truncate_inode_pages_final() //wait release io_end
>                                     inode_io_list_move_locked()
>                              ext4_release_io_end()
>      trigger WARN_ON_ONCE()
> 
> Fixes: ceff86fddae8 ("ext4: Avoid freeing inodes on dirty list")
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> Reviewed-by: Jan Kara <jack@suse.cz>
> ---
>  fs/ext4/inode.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 84c0eb55071d..702cc208689a 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -220,13 +220,13 @@ void ext4_evict_inode(struct inode *inode)
>  
>  	/*
>  	 * For inodes with journalled data, transaction commit could have
> -	 * dirtied the inode. Flush worker is ignoring it because of I_FREEING
> -	 * flag but we still need to remove the inode from the writeback lists.
> +	 * dirtied the inode. And for inodes with dioread_nolock, unwritten
> +	 * extents converting worker could merge extents and also have dirtied
> +	 * the inode. Flush worker is ignoring it because of I_FREEING flag but
> +	 * we still need to remove the inode from the writeback lists.
>  	 */
> -	if (!list_empty_careful(&inode->i_io_list)) {
> -		WARN_ON_ONCE(!ext4_should_journal_data(inode));
> +	if (!list_empty_careful(&inode->i_io_list))
>  		inode_io_list_del(inode);
> -	}
>  
>  	/*
>  	 * Protect us against freezing - iput() caller didn't have to have any
> 
