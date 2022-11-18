Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 476B762ED02
	for <lists+linux-ext4@lfdr.de>; Fri, 18 Nov 2022 06:02:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbiKRFCy (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 18 Nov 2022 00:02:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiKRFCx (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 18 Nov 2022 00:02:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 771EF5D68D;
        Thu, 17 Nov 2022 21:02:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1466862324;
        Fri, 18 Nov 2022 05:02:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34AE9C433C1;
        Fri, 18 Nov 2022 05:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668747771;
        bh=ZX8ld+jC7zyJN8RKp/NiKUjeKsrkrw250KJAa+bb4Do=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dpkGOrWvYVl4BYRMg3Fofp4yF1iki0Q8LvEYTsJyRroS4aT6ppWuq6UG7EygoGxE4
         y73ax9bXXnQqp5wzNuWIN4F80b+ad77Jg/TFD++ST+VliFkBfGAKue600y04bUsKEI
         oj6HDahU4tHlW1LaKfEleJ59lUXuvs8tcpGBGh9ackLQLMbagYndoMPv+BseB+KM5z
         iPzlicMd2mR2eSa8tCuadOnOjEZVpLZfdZUC3THWSnDdcbSC7hjw1tQ32XVW4RQPe9
         o5diBg2D/CBBWT+gqWE1sKhKI8l9f6MMQRbfS5+AusB7Gojc5/IELFZDVGacTW8vIX
         ItA1zlbNqfeZA==
Date:   Thu, 17 Nov 2022 21:02:49 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Ye Bin <yebin@huaweicloud.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        jack@suse.cz, Ye Bin <yebin10@huawei.com>,
        syzbot+57b25da729eb0b88177d@syzkaller.appspotmail.com
Subject: Re: [PATCH] ext4: fix uninit-value in 'ext4_evict_inode'
Message-ID: <Y3cR+Rdr69eMEpjn@sol.localdomain>
References: <20221117073603.2598882-1-yebin@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221117073603.2598882-1-yebin@huaweicloud.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Nov 17, 2022 at 03:36:03PM +0800, Ye Bin wrote:
> From: Ye Bin <yebin10@huawei.com>
> 
> Syzbot found the following issue:
> =====================================================
> BUG: KMSAN: uninit-value in ext4_evict_inode+0xdd/0x26b0 fs/ext4/inode.c:180
>  ext4_evict_inode+0xdd/0x26b0 fs/ext4/inode.c:180
>  evict+0x365/0x9a0 fs/inode.c:664
>  iput_final fs/inode.c:1747 [inline]
>  iput+0x985/0xdd0 fs/inode.c:1773
>  __ext4_new_inode+0xe54/0x7ec0 fs/ext4/ialloc.c:1361
>  ext4_mknod+0x376/0x840 fs/ext4/namei.c:2844
>  vfs_mknod+0x79d/0x830 fs/namei.c:3914
>  do_mknodat+0x47d/0xaa0
>  __do_sys_mknodat fs/namei.c:3992 [inline]
>  __se_sys_mknodat fs/namei.c:3989 [inline]
>  __ia32_sys_mknodat+0xeb/0x150 fs/namei.c:3989
>  do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
>  __do_fast_syscall_32+0xa2/0x100 arch/x86/entry/common.c:178
>  do_fast_syscall_32+0x33/0x70 arch/x86/entry/common.c:203
>  do_SYSENTER_32+0x1b/0x20 arch/x86/entry/common.c:246
>  entry_SYSENTER_compat_after_hwframe+0x70/0x82
> 
> Uninit was created at:
>  __alloc_pages+0x9f1/0xe80 mm/page_alloc.c:5578
>  alloc_pages+0xaae/0xd80 mm/mempolicy.c:2285
>  alloc_slab_page mm/slub.c:1794 [inline]
>  allocate_slab+0x1b5/0x1010 mm/slub.c:1939
>  new_slab mm/slub.c:1992 [inline]
>  ___slab_alloc+0x10c3/0x2d60 mm/slub.c:3180
>  __slab_alloc mm/slub.c:3279 [inline]
>  slab_alloc_node mm/slub.c:3364 [inline]
>  slab_alloc mm/slub.c:3406 [inline]
>  __kmem_cache_alloc_lru mm/slub.c:3413 [inline]
>  kmem_cache_alloc_lru+0x6f3/0xb30 mm/slub.c:3429
>  alloc_inode_sb include/linux/fs.h:3117 [inline]
>  ext4_alloc_inode+0x5f/0x860 fs/ext4/super.c:1321
>  alloc_inode+0x83/0x440 fs/inode.c:259
>  new_inode_pseudo fs/inode.c:1018 [inline]
>  new_inode+0x3b/0x430 fs/inode.c:1046
>  __ext4_new_inode+0x2a7/0x7ec0 fs/ext4/ialloc.c:959
>  ext4_mkdir+0x4d5/0x1560 fs/ext4/namei.c:2992
>  vfs_mkdir+0x62a/0x870 fs/namei.c:4035
>  do_mkdirat+0x466/0x7b0 fs/namei.c:4060
>  __do_sys_mkdirat fs/namei.c:4075 [inline]
>  __se_sys_mkdirat fs/namei.c:4073 [inline]
>  __ia32_sys_mkdirat+0xc4/0x120 fs/namei.c:4073
>  do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
>  __do_fast_syscall_32+0xa2/0x100 arch/x86/entry/common.c:178
>  do_fast_syscall_32+0x33/0x70 arch/x86/entry/common.c:203
>  do_SYSENTER_32+0x1b/0x20 arch/x86/entry/common.c:246
>  entry_SYSENTER_compat_after_hwframe+0x70/0x82
> 
> CPU: 1 PID: 4625 Comm: syz-executor.2 Not tainted 6.1.0-rc4-syzkaller-62821-gcb231e2f67ec #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
> =====================================================
> 
> Now, 'ext4_alloc_inode()' didn't init 'ei->i_flags'. If new inode failed
> before set 'ei->i_flags' in '__ext4_new_inode()', then do 'iput()'. As after
> 6bc0d63dad7f commit will access 'ei->i_flags' in 'ext4_evict_inode()' which
> will lead to access uninit-value.
> To solve above issue just init 'ei->i_flags' in 'ext4_alloc_inode()'.
> 
> Reported-by: syzbot+57b25da729eb0b88177d@syzkaller.appspotmail.com
> Fixes:6bc0d63dad7f("ext4: remove EA inode entry from mbcache on inode eviction")
> Signed-off-by: Ye Bin <yebin10@huawei.com>
> ---
>  fs/ext4/super.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index ae433e1337ed..cd2590489392 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -1323,6 +1323,7 @@ static struct inode *ext4_alloc_inode(struct super_block *sb)
>  		return NULL;
>  
>  	inode_set_iversion(&ei->vfs_inode, 1);
> +	ei->i_flags = 0;
>  	spin_lock_init(&ei->i_raw_lock);
>  	INIT_LIST_HEAD(&ei->i_prealloc_list);
>  	atomic_set(&ei->i_prealloc_active, 0);

Reviewed-by: Eric Biggers <ebiggers@google.com>

I'm seeing this when running xfstests on a kernel with KMSAN enabled, so it
would be nice to get this fixed.

- Eric
