Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35FD067CAC8
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Jan 2023 13:19:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236877AbjAZMTU (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 26 Jan 2023 07:19:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237157AbjAZMTI (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 26 Jan 2023 07:19:08 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81BCA6C119;
        Thu, 26 Jan 2023 04:19:07 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1E05E1FF3F;
        Thu, 26 Jan 2023 12:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1674735546; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zHF9kquaWcC1l2gA0KVzxN/HOTgD8UsYaZgONfx7Wmg=;
        b=IXrGALAO8TmdveocmWoPmWzpaigNCcS6+2Pqyq0VzjOYxCY+z+cOskl1u+jhr87yuxJ/gN
        nxyFKao7OrutGtG1ObkJ2M+f7zDBTIK8yzh7Re1G4uMA7tGBgCfcVzFl5Qb818Kxhw6Wag
        SzxUnWqAfUpvYhuYzY9FI7DLylzX3lQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1674735546;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zHF9kquaWcC1l2gA0KVzxN/HOTgD8UsYaZgONfx7Wmg=;
        b=QjP+2mfPzOQg07ENPqU2XB16gExqApD1u0Dmw4Iw5EL67BtWvvFgjawXI2yalg595MuBfS
        I83z3dlJUZ/ofoDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0F79E13A09;
        Thu, 26 Jan 2023 12:19:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 59PBA7pv0mOfOwAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 26 Jan 2023 12:19:06 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 82FD3A06B4; Thu, 26 Jan 2023 13:19:05 +0100 (CET)
Date:   Thu, 26 Jan 2023 13:19:05 +0100
From:   Jan Kara <jack@suse.cz>
To:     syzbot <syzbot+edce54daffee36421b4c@syzkaller.appspotmail.com>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu
Subject: Re: [syzbot] [ext4?] possible deadlock in ext4_xattr_set_handle (3)
Message-ID: <20230126121905.toze65yum336s42p@quack3>
References: <000000000000f6540d05f30bb23f@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000f6540d05f30bb23f@google.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi!

On Tue 24-01-23 16:27:36, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    edc00350d205 Merge tag 'block-6.2-2023-01-20' of git://git..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=134b1441480000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=899d86a7610a0ea0
> dashboard link: https://syzkaller.appspot.com/bug?extid=edce54daffee36421b4c
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> userspace arch: i386
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+edce54daffee36421b4c@syzkaller.appspotmail.com
> 
> ext4 filesystem being mounted at /syzkaller-testdir3627507797/syzkaller.9jT2hR/316/file0 supports timestamps until 2038 (0x7fffffff)
> ======================================================
> WARNING: possible circular locking dependency detected
> 6.2.0-rc4-syzkaller-00350-gedc00350d205 #0 Not tainted
> ------------------------------------------------------
> syz-executor.2/573 is trying to acquire lock:
> ffffffff8c8d4f60 (fs_reclaim){+.+.}-{0:0}, at: might_alloc include/linux/sched/mm.h:271 [inline]
> ffffffff8c8d4f60 (fs_reclaim){+.+.}-{0:0}, at: slab_pre_alloc_hook mm/slab.h:720 [inline]
> ffffffff8c8d4f60 (fs_reclaim){+.+.}-{0:0}, at: slab_alloc_node mm/slub.c:3434 [inline]
> ffffffff8c8d4f60 (fs_reclaim){+.+.}-{0:0}, at: __kmem_cache_alloc_node+0x41/0x430 mm/slub.c:3491
> 
> but task is already holding lock:
> ffff8880277eb2f0 (&ei->xattr_sem){++++}-{3:3}, at: ext4_write_lock_xattr fs/ext4/xattr.h:155 [inline]
> ffff8880277eb2f0 (&ei->xattr_sem){++++}-{3:3}, at: ext4_xattr_set_handle+0x160/0x1510 fs/ext4/xattr.c:2305
> 
> which lock already depends on the new lock.

So I don't see how the below is ever possible:

> -> #0 (fs_reclaim){+.+.}-{0:0}:
>        check_prev_add kernel/locking/lockdep.c:3097 [inline]
>        check_prevs_add kernel/locking/lockdep.c:3216 [inline]
>        validate_chain kernel/locking/lockdep.c:3831 [inline]
>        __lock_acquire+0x2a43/0x56d0 kernel/locking/lockdep.c:5055
>        lock_acquire kernel/locking/lockdep.c:5668 [inline]
>        lock_acquire+0x1e3/0x630 kernel/locking/lockdep.c:5633
>        __fs_reclaim_acquire mm/page_alloc.c:4674 [inline]

So we are acquiring fs_reclaim here which means that
current_gfp_context(gfp_mask) contained __GFP_FS...

>        fs_reclaim_acquire+0x11d/0x160 mm/page_alloc.c:4688
>        might_alloc include/linux/sched/mm.h:271 [inline]
>        slab_pre_alloc_hook mm/slab.h:720 [inline]
>        slab_alloc_node mm/slub.c:3434 [inline]
>        __kmem_cache_alloc_node+0x41/0x430 mm/slub.c:3491
>        __do_kmalloc_node mm/slab_common.c:967 [inline]
>        __kmalloc_node+0x4d/0xd0 mm/slab_common.c:975
>        kmalloc_node include/linux/slab.h:610 [inline]
>        kvmalloc_node+0x76/0x1a0 mm/util.c:581
>        kvmalloc include/linux/slab.h:737 [inline]
>        ext4_xattr_inode_cache_find fs/ext4/xattr.c:1484 [inline]
>        ext4_xattr_inode_lookup_create fs/ext4/xattr.c:1527 [inline]
>        ext4_xattr_set_entry+0x1d92/0x3a00 fs/ext4/xattr.c:1669
>        ext4_xattr_block_set+0x61b/0x3000 fs/ext4/xattr.c:1906
>        ext4_xattr_set_handle+0xd8a/0x1510 fs/ext4/xattr.c:2390
>        ext4_xattr_set+0x144/0x360 fs/ext4/xattr.c:2492

... however here we've started a transaction so we should have
PF_MEMALLOC_NOFS set?

The only good explanation I have is that lockdep is mixing dependencies
from an ext4 filesystem without a journal with dependencies created by
filesystem with a journal. Since we have no reproducer, it's hard to
tell.

>        __vfs_setxattr+0x173/0x1e0 fs/xattr.c:202
>        __vfs_setxattr_noperm+0x129/0x5f0 fs/xattr.c:236
>        __vfs_setxattr_locked+0x1d3/0x260 fs/xattr.c:297
>        vfs_setxattr+0x143/0x340 fs/xattr.c:323
>        do_setxattr+0x151/0x190 fs/xattr.c:608
>        setxattr+0x146/0x160 fs/xattr.c:631
>        path_setxattr+0x197/0x1c0 fs/xattr.c:650
>        __do_sys_setxattr fs/xattr.c:666 [inline]
>        __se_sys_setxattr fs/xattr.c:662 [inline]
>        __ia32_sys_setxattr+0xc0/0x160 fs/xattr.c:662
>        do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
>        __do_fast_syscall_32+0x65/0xf0 arch/x86/entry/common.c:178
>        do_fast_syscall_32+0x33/0x70 arch/x86/entry/common.c:203
>        entry_SYSENTER_compat_after_hwframe+0x70/0x82

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
