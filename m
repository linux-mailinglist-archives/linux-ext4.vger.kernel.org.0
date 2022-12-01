Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA76863F04F
	for <lists+linux-ext4@lfdr.de>; Thu,  1 Dec 2022 13:19:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbiLAMTd (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 1 Dec 2022 07:19:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbiLAMTc (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 1 Dec 2022 07:19:32 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12FD8A9CC8;
        Thu,  1 Dec 2022 04:19:31 -0800 (PST)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9606F21AC2;
        Thu,  1 Dec 2022 12:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1669897169; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mBDZWtkJz7CG5w27dMv5hsW73h8kfL7x6yErLTOzvvI=;
        b=vQD0YI6LBqKMyWi7Y+8bkkGgpOVN02LhcL3HQ/Xs/+7NvFGE0l+UEHFP6gZ6yzUuJs7Cf0
        RU6WdLbMXQmNxasTVYJO+bK/bc2Xr4At9QOilJmh9U5mlUVDjUhuFKJI0t/maC/Pijt8VL
        eZNb+M6SsGb7gZCkWQAlyiM8V2pt8uI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1669897169;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mBDZWtkJz7CG5w27dMv5hsW73h8kfL7x6yErLTOzvvI=;
        b=cOgcyQ8d+BstxwBa644Y9wnmuBFRnYGMo2wXv4jz3vZxYsKVyKoWTAatBIKvN5AuU8NvKM
        kZS/unG28EY1+DDA==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 6A97A1320E;
        Thu,  1 Dec 2022 12:19:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id pC0CGtGbiGOFagAAGKfGzw
        (envelope-from <jack@suse.cz>); Thu, 01 Dec 2022 12:19:29 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 8CA0EA06E4; Thu,  1 Dec 2022 13:19:28 +0100 (CET)
Date:   Thu, 1 Dec 2022 13:19:28 +0100
From:   Jan Kara <jack@suse.cz>
To:     Ye Bin <yebin@huaweicloud.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        jack@suse.cz, Ye Bin <yebin10@huawei.com>,
        syzbot+4d99a966fd74bdeeec36@syzkaller.appspotmail.com
Subject: Re: [PATCH] ext4: fix WARNING in ext4_expand_extra_isize_ea
Message-ID: <20221201121928.xk5tte4dj3vmxivs@quack3>
References: <20221201084844.2855621-1-yebin@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221201084844.2855621-1-yebin@huaweicloud.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello!

On Thu 01-12-22 16:48:44, Ye Bin wrote:
> From: Ye Bin <yebin10@huawei.com>
> 
> Syzbot found the following issue:
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 3631 at mm/page_alloc.c:5534 __alloc_pages+0x30a/0x560 mm/page_alloc.c:5534
> Modules linked in:
> CPU: 1 PID: 3631 Comm: syz-executor261 Not tainted 6.1.0-rc6-syzkaller-00308-g644e9524388a #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
> RIP: 0010:__alloc_pages+0x30a/0x560 mm/page_alloc.c:5534
> RSP: 0018:ffffc90003ccf080 EFLAGS: 00010246
> RAX: ffffc90003ccf0e0 RBX: 000000000000000c RCX: 0000000000000000
> RDX: 0000000000000028 RSI: 0000000000000000 RDI: ffffc90003ccf108
> RBP: ffffc90003ccf198 R08: dffffc0000000000 R09: ffffc90003ccf0e0
> R10: fffff52000799e21 R11: 1ffff92000799e1c R12: 0000000000040c40
> R13: 1ffff92000799e18 R14: dffffc0000000000 R15: 1ffff92000799e14
> FS:  0000555555c10300(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007ffc36f70000 CR3: 00000000744ad000 CR4: 00000000003506e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  __alloc_pages_node include/linux/gfp.h:223 [inline]
>  alloc_pages_node include/linux/gfp.h:246 [inline]
>  __kmalloc_large_node+0x8a/0x1a0 mm/slab_common.c:1096
>  __do_kmalloc_node mm/slab_common.c:943 [inline]
>  __kmalloc+0xfe/0x1a0 mm/slab_common.c:968
>  kmalloc include/linux/slab.h:558 [inline]
>  ext4_xattr_move_to_block fs/ext4/xattr.c:2558 [inline]
>  ext4_xattr_make_inode_space fs/ext4/xattr.c:2673 [inline]
>  ext4_expand_extra_isize_ea+0xe3f/0x1cd0 fs/ext4/xattr.c:2765
>  __ext4_expand_extra_isize+0x2b8/0x3f0 fs/ext4/inode.c:5857
>  ext4_try_to_expand_extra_isize fs/ext4/inode.c:5900 [inline]
>  __ext4_mark_inode_dirty+0x51a/0x670 fs/ext4/inode.c:5978
>  ext4_inline_data_truncate+0x548/0xd00 fs/ext4/inline.c:2021
>  ext4_truncate+0x341/0xeb0 fs/ext4/inode.c:4221
>  ext4_process_orphan+0x1aa/0x2d0 fs/ext4/orphan.c:339
>  ext4_orphan_cleanup+0xb60/0x1340 fs/ext4/orphan.c:474
>  __ext4_fill_super fs/ext4/super.c:5515 [inline]
>  ext4_fill_super+0x80ed/0x8610 fs/ext4/super.c:5643
>  get_tree_bdev+0x400/0x620 fs/super.c:1324
>  vfs_get_tree+0x88/0x270 fs/super.c:1531
>  do_new_mount+0x289/0xad0 fs/namespace.c:3040
>  do_mount fs/namespace.c:3383 [inline]
>  __do_sys_mount fs/namespace.c:3591 [inline]
>  __se_sys_mount+0x2d3/0x3c0 fs/namespace.c:3568
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
>  </TASK>
> 
> Reason is allocate 16M memory by kmalloc, but MAX_ORDER is 11, kmalloc
> can allocate maxium size memory is 4M.
> XATTR_SIZE_MAX is currently 64k, but EXT4_XATTR_SIZE_MAX is '(1 << 24)',
> so 'ext4_xattr_check_entries()' regards this length as legal. Then trigger
> warning in 'ext4_xattr_move_to_block()'.
> To solve above issue, adjust EXT4_XATTR_SIZE_MAX to '(1 << 22)' which
> is kmalloc can allocate maxium size.
> 
> Reported-by: syzbot+4d99a966fd74bdeeec36@syzkaller.appspotmail.com
> Fixes: 54dd0e0a1b25 ("ext4: add extra checks to ext4_xattr_block_get()")
> Signed-off-by: Ye Bin <yebin10@huawei.com>

Thanks for the report and the fix but I think it is actually wrong.  We
cannot just change EXT4_XATTR_SIZE_MAX because there may be already
filesystems with this large extended attributes and we'd be suddently
unable to read them. So a better fix would be to use kvmalloc() to allocate
the memory which is able to accommodate arbitrary allocation size.

Arguably, even better might be to make ext4_xattr_move_to_block() more
clever because currently it loads attribute into memory from the inode only
to store it there again. We could just create xattr entry in the block and
be done with it. But it will be more complex and maybe it's not worth it...

								Honza

> ---
>  fs/ext4/xattr.h | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/ext4/xattr.h b/fs/ext4/xattr.h
> index 824faf0b15a8..22f0c89b1184 100644
> --- a/fs/ext4/xattr.h
> +++ b/fs/ext4/xattr.h
> @@ -75,11 +75,12 @@ struct ext4_xattr_entry {
>   * for file system consistency errors, we use a somewhat bigger value.
>   * This allows XATTR_SIZE_MAX to grow in the future, but by using this
>   * instead of INT_MAX for certain consistency checks, we don't need to
> - * worry about arithmetic overflows.  (Actually XATTR_SIZE_MAX is
> - * defined in include/uapi/linux/limits.h, so changing it is going
> - * not going to be trivial....)
> - */
> -#define EXT4_XATTR_SIZE_MAX (1 << 24)
> + * worry about arithmetic overflows. Now, MAX_ORDER is 11 kmalloc can
> + * allocate maxium size is 4M. (Actually XATTR_SIZE_MAX is defined in
> + * include/uapi/linux/limits.h, so changing it is going not going to
> + * be trivial....)
> +  */
> +#define EXT4_XATTR_SIZE_MAX (1 << 22)
>  
>  /*
>   * The minimum size of EA value when you start storing it in an external inode
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
