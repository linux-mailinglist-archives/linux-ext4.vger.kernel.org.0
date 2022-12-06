Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB7E56442E6
	for <lists+linux-ext4@lfdr.de>; Tue,  6 Dec 2022 13:05:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235256AbiLFMFu (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 6 Dec 2022 07:05:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234982AbiLFMFe (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 6 Dec 2022 07:05:34 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BC762934C;
        Tue,  6 Dec 2022 04:04:20 -0800 (PST)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C07BF1FE3E;
        Tue,  6 Dec 2022 12:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1670328258; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8q6ZPg/tqFRuvaWD1LpVpkaIE6BD7BT1f0oDRYe1ZbI=;
        b=umPJYJtv9Mo8wdyWE643zdsspQ8aZGh0KrsM3nLBwy3lqHAj1IAg7w4pSV9w5JNnMns9Vr
        JrR6Amw62P8aHLNWQ/LKbUvBQJhen1xugoWKGBjO+PWfY3ZmyNoKQ2puv5cvfwP71yzNV/
        hmZH3Rj+6GlU6q5nV/Z01kTyo5KFuYc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1670328258;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8q6ZPg/tqFRuvaWD1LpVpkaIE6BD7BT1f0oDRYe1ZbI=;
        b=8MP3y+KPOw3Xtedhk68KkSyF8iEtA/6ppFOk9eIn9YysTOiGjKBwLku8WD1RGwDpNY4ZYH
        7BW7rI1i9cveFaDA==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id AF901132F3;
        Tue,  6 Dec 2022 12:04:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id rMLKKsIvj2PgWgAAGKfGzw
        (envelope-from <jack@suse.cz>); Tue, 06 Dec 2022 12:04:18 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 07A92A0725; Tue,  6 Dec 2022 13:04:17 +0100 (CET)
Date:   Tue, 6 Dec 2022 13:04:17 +0100
From:   Jan Kara <jack@suse.cz>
To:     Ye Bin <yebin@huaweicloud.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        jack@suse.cz, Ye Bin <yebin10@huawei.com>,
        syzbot+4d99a966fd74bdeeec36@syzkaller.appspotmail.com
Subject: Re: [PATCH -next 1/6] ext4: fix WARNING in ext4_expand_extra_isize_ea
Message-ID: <20221206120417.225uxtlg255bzph4@quack3>
References: <20221206015806.3420321-1-yebin@huaweicloud.com>
 <20221206015806.3420321-2-yebin@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221206015806.3420321-2-yebin@huaweicloud.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue 06-12-22 09:58:01, Ye Bin wrote:
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
> To solve above issue, according to Jan Kara's suggestion use kvmalloc()
> to allocate memory in ext4_xattr_move_to_block().
> 
> Reported-by: syzbot+4d99a966fd74bdeeec36@syzkaller.appspotmail.com
> Fixes: 54dd0e0a1b25 ("ext4: add extra checks to ext4_xattr_block_get()")
> Signed-off-by: Ye Bin <yebin10@huawei.com>

The changelog speak about kvmalloc() while your patch changes
EXT4_XATTR_SIZE_MAX. This needs to be fixed. If Ted is find with this
change, I have no problem with it either but I remember there were some
discussions about what EXT4_XATTR_SIZE_MAX should be when ea_inode feature
has been developed. Ted might remember.

Also the change from kmalloc() to kvmalloc() is a desirable one anyway. It
is not always easy to find physically contiguous 64k of memory so
kvmalloc() makes the allocation much more likely to succeed.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
