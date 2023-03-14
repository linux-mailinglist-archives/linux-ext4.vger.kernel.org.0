Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 246526B8DC9
	for <lists+linux-ext4@lfdr.de>; Tue, 14 Mar 2023 09:50:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbjCNIuZ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 14 Mar 2023 04:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjCNIuU (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 14 Mar 2023 04:50:20 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3D102658A;
        Tue, 14 Mar 2023 01:49:59 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 84EBD222DE;
        Tue, 14 Mar 2023 08:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1678783798; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kHJBumZhVWKtIuaDFxrM/ahmBWwdqJxTNSlIlMMAJlY=;
        b=PMH9bRfFUPxST080PtHc/h3ytgRrq8ScWYXvNnnmCWbjYL5o/09sICBzS9C343TCeqHNd/
        3x/BO2q/wLVdP/iPkPsY2mjwA4c5J7Zm4fal6zZqTWYtd7By1fhJMoCZXEibAKwuLi10Dn
        ex/1tsq/FMZFeK9AUrSNRzcxAP0nm58=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1678783798;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kHJBumZhVWKtIuaDFxrM/ahmBWwdqJxTNSlIlMMAJlY=;
        b=yXIPBB/D/3XaCvX4EUlpZliVwIHop0JuGQ+agp1g07nXXP+oqf0zSfazhytamcVubok7pG
        udQpBzwKNsewtDBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 71B6F13A1B;
        Tue, 14 Mar 2023 08:49:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6RnAGzY1EGSUTwAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 14 Mar 2023 08:49:58 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id EFA50A06FD; Tue, 14 Mar 2023 09:49:57 +0100 (CET)
Date:   Tue, 14 Mar 2023 09:49:57 +0100
From:   Jan Kara <jack@suse.cz>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Jan Kara <jack@suse.cz>, Tudor Ambarus <tudor.ambarus@linaro.org>,
        syzbot <syzbot+8785e41224a3afd04321@syzkaller.appspotmail.com>,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        nathan@kernel.org, ndesaulniers@google.com,
        syzkaller-bugs@googlegroups.com, trix@redhat.com, tytso@mit.edu,
        Lee Jones <joneslee@google.com>
Subject: Re: [syzbot] [ext4?] KASAN: slab-out-of-bounds Read in
 ext4_group_desc_csum
Message-ID: <20230314084957.eauygcciss4bxwqp@quack3>
References: <000000000000ef6cf905f496e40b@google.com>
 <7e4a0f15-4d82-6026-c14b-59852ffab08e@linaro.org>
 <20230307103958.lo6ynoypgwreqmnq@quack3>
 <60788e5d-5c7c-1142-e554-c21d709acfd9@linaro.org>
 <976a7f24-0446-182f-c99e-98f3b98aef49@linaro.org>
 <20230313115728.2wxy2qj4mqpwgrx7@quack3>
 <CACT4Y+ZVWYX=NX4br=0MFTYxJGBE9gEQdx+YNYi1P4B1z8B0iw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+ZVWYX=NX4br=0MFTYxJGBE9gEQdx+YNYi1P4B1z8B0iw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon 13-03-23 15:53:57, Dmitry Vyukov wrote:
> On Mon, 13 Mar 2023 at 12:57, Jan Kara <jack@suse.cz> wrote:
> >
> > Hi Tudor!
> >
> > On Mon 13-03-23 11:11:18, Tudor Ambarus wrote:
> > > On 3/7/23 11:02, Tudor Ambarus wrote:
> > > > On 3/7/23 10:39, Jan Kara wrote:
> > > >> On Wed 01-03-23 12:13:51, Tudor Ambarus wrote:
> > > >>> On 2/13/23 15:56, syzbot wrote:
> > > >>>> syzbot has found a reproducer for the following issue on:
> > > >>>>
> > > >>>> HEAD commit:    ceaa837f96ad Linux 6.2-rc8
> > > >>>> git tree:       upstream
> > > >>>> console output:
> > > >>>> https://syzkaller.appspot.com/x/log.txt?x=11727cc7480000
> > > >>>> kernel config:
> > > >>>> https://syzkaller.appspot.com/x/.config?x=42ba4da8e1e6af9f
> > > >>>> dashboard link:
> > > >>>> https://syzkaller.appspot.com/bug?extid=8785e41224a3afd04321
> > > >>>> compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils
> > > >>>> for Debian) 2.35.2
> > > >>>> syz repro:
> > > >>>> https://syzkaller.appspot.com/x/repro.syz?x=14392a4f480000
> > > >>>>
> > > >>>> Downloadable assets:
> > > >>>> disk image:
> > > >>>> https://storage.googleapis.com/syzbot-assets/88042f9b5fc8/disk-ceaa837f.raw.xz
> > > >>>> vmlinux:
> > > >>>> https://storage.googleapis.com/syzbot-assets/9945b57ec9ee/vmlinux-ceaa837f.xz
> > > >>>> kernel image:
> > > >>>> https://storage.googleapis.com/syzbot-assets/72ff118ed96b/bzImage-ceaa837f.xz
> > > >>>> mounted in repro:
> > > >>>> https://storage.googleapis.com/syzbot-assets/dabec17b2679/mount_0.gz
> > > >>>>
> > > >>>> IMPORTANT: if you fix the issue, please add the following tag to the
> > > >>>> commit:
> > > >>>> Reported-by: syzbot+8785e41224a3afd04321@syzkaller.appspotmail.com
> > > >>>>
> > > >>>> ==================================================================
> > > >>>> BUG: KASAN: use-after-free in crc16+0x1fb/0x280 lib/crc16.c:58
> > > >>>> Read of size 1 at addr ffff88807de00000 by task syz-executor.1/5339
> > > >>>>
> > > >>>> CPU: 1 PID: 5339 Comm: syz-executor.1 Not tainted
> > > >>>> 6.2.0-rc8-syzkaller #0
> > > >>>> Hardware name: Google Google Compute Engine/Google Compute Engine,
> > > >>>> BIOS Google 01/21/2023
> > > >>>> Call Trace:
> > > >>>>    <TASK>
> > > >>>>    __dump_stack lib/dump_stack.c:88 [inline]
> > > >>>>    dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
> > > >>>>    print_address_description mm/kasan/report.c:306 [inline]
> > > >>>>    print_report+0x163/0x4f0 mm/kasan/report.c:417
> > > >>>>    kasan_report+0x13a/0x170 mm/kasan/report.c:517
> > > >>>>    crc16+0x1fb/0x280 lib/crc16.c:58
> > > >>>>    ext4_group_desc_csum+0x90f/0xc50 fs/ext4/super.c:3187
> > > >>>>    ext4_group_desc_csum_set+0x19b/0x240 fs/ext4/super.c:3210
> > > >>>>    ext4_mb_clear_bb fs/ext4/mballoc.c:6027 [inline]
> > > >>>>    ext4_free_blocks+0x1c57/0x3010 fs/ext4/mballoc.c:6173
> > > >>>>    ext4_remove_blocks fs/ext4/extents.c:2527 [inline]
> > > >>>>    ext4_ext_rm_leaf fs/ext4/extents.c:2710 [inline]
> > > >>>>    ext4_ext_remove_space+0x289e/0x5270 fs/ext4/extents.c:2958
> > > >>>>    ext4_ext_truncate+0x176/0x210 fs/ext4/extents.c:4416
> > > >>>>    ext4_truncate+0xafa/0x1450 fs/ext4/inode.c:4342
> > > >>>>    ext4_evict_inode+0xc40/0x1230 fs/ext4/inode.c:286
> > > >>>>    evict+0x2a4/0x620 fs/inode.c:664
> > > >>>>    do_unlinkat+0x4f1/0x930 fs/namei.c:4327
> > > >>>>    __do_sys_unlink fs/namei.c:4368 [inline]
> > > >>>>    __se_sys_unlink fs/namei.c:4366 [inline]
> > > >>>>    __x64_sys_unlink+0x49/0x50 fs/namei.c:4366
> > > >>>>    do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> > > >>>>    do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
> > > >>>>    entry_SYSCALL_64_after_hwframe+0x63/0xcd
> > > >>>> RIP: 0033:0x7fbc85a8c0f9
> > > >>>> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48
> > > >>>> 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48>
> > > >>>> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> > > >>>> RSP: 002b:00007fbc86838168 EFLAGS: 00000246 ORIG_RAX: 0000000000000057
> > > >>>> RAX: ffffffffffffffda RBX: 00007fbc85babf80 RCX: 00007fbc85a8c0f9
> > > >>>> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000020000000
> > > >>>> RBP: 00007fbc85ae7ae9 R08: 0000000000000000 R09: 0000000000000000
> > > >>>> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> > > >>>> R13: 00007ffd5743beaf R14: 00007fbc86838300 R15: 0000000000022000
> > > >>>>    </TASK>
> > > >>>>
> > > >>>> The buggy address belongs to the physical page:
> > > >>>> page:ffffea0001f78000 refcount:0 mapcount:-128
> > > >>>> mapping:0000000000000000 index:0x0 pfn:0x7de00
> > > >>>> flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
> > > >>>> raw: 00fff00000000000 ffffea0001f86008 ffffea0001db2a08
> > > >>>> 0000000000000000
> > > >>>> raw: 0000000000000000 0000000000000001 00000000ffffff7f
> > > >>>> 0000000000000000
> > > >>>> page dumped because: kasan: bad access detected
> > > >>>> page_owner tracks the page as freed
> > > >>>> page last allocated via order 1, migratetype Unmovable, gfp_mask
> > > >>>> 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 4855, tgid 4855 (sshd), ts 43553490210, free_ts 58249059760
> > > >>>>    prep_new_page mm/page_alloc.c:2531 [inline]
> > > >>>>    get_page_from_freelist+0x3449/0x35c0 mm/page_alloc.c:4283
> > > >>>>    __alloc_pages+0x291/0x7e0 mm/page_alloc.c:5549
> > > >>>>    alloc_slab_page+0x6a/0x160 mm/slub.c:1851
> > > >>>>    allocate_slab mm/slub.c:1998 [inline]
> > > >>>>    new_slab+0x84/0x2f0 mm/slub.c:2051
> > > >>>>    ___slab_alloc+0xa85/0x10a0 mm/slub.c:3193
> > > >>>>    __kmem_cache_alloc_bulk mm/slub.c:3951 [inline]
> > > >>>>    kmem_cache_alloc_bulk+0x160/0x430 mm/slub.c:4026
> > > >>>>    mt_alloc_bulk lib/maple_tree.c:157 [inline]
> > > >>>>    mas_alloc_nodes+0x381/0x640 lib/maple_tree.c:1257
> > > >>>>    mas_node_count_gfp lib/maple_tree.c:1316 [inline]
> > > >>>>    mas_preallocate+0x131/0x350 lib/maple_tree.c:5724
> > > >>>>    vma_expand+0x277/0x850 mm/mmap.c:541
> > > >>>>    mmap_region+0xc43/0x1fb0 mm/mmap.c:2592
> > > >>>>    do_mmap+0x8c9/0xf70 mm/mmap.c:1411
> > > >>>>    vm_mmap_pgoff+0x1ce/0x2e0 mm/util.c:520
> > > >>>>    do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> > > >>>>    do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
> > > >>>>    entry_SYSCALL_64_after_hwframe+0x63/0xcd
> > > >>>> page last free stack trace:
> > > >>>>    reset_page_owner include/linux/page_owner.h:24 [inline]
> > > >>>>    free_pages_prepare mm/page_alloc.c:1446 [inline]
> > > >>>>    free_pcp_prepare mm/page_alloc.c:1496 [inline]
> > > >>>>    free_unref_page_prepare+0xf3a/0x1040 mm/page_alloc.c:3369
> > > >>>>    free_unref_page+0x37/0x3f0 mm/page_alloc.c:3464
> > > >>>>    qlist_free_all+0x22/0x60 mm/kasan/quarantine.c:187
> > > >>>>    kasan_quarantine_reduce+0x15a/0x170 mm/kasan/quarantine.c:294
> > > >>>>    __kasan_slab_alloc+0x23/0x80 mm/kasan/common.c:302
> > > >>>>    kasan_slab_alloc include/linux/kasan.h:201 [inline]
> > > >>>>    slab_post_alloc_hook+0x68/0x390 mm/slab.h:761
> > > >>>>    slab_alloc_node mm/slub.c:3452 [inline]
> > > >>>>    kmem_cache_alloc_node+0x158/0x2c0 mm/slub.c:3497
> > > >>>>    __alloc_skb+0xd6/0x2d0 net/core/skbuff.c:552
> > > >>>>    alloc_skb include/linux/skbuff.h:1270 [inline]
> > > >>>>    alloc_skb_with_frags+0xa8/0x750 net/core/skbuff.c:6194
> > > >>>>    sock_alloc_send_pskb+0x919/0xa50 net/core/sock.c:2743
> > > >>>>    unix_dgram_sendmsg+0x5b5/0x2050 net/unix/af_unix.c:1943
> > > >>>>    sock_sendmsg_nosec net/socket.c:714 [inline]
> > > >>>>    sock_sendmsg net/socket.c:734 [inline]
> > > >>>>    __sys_sendto+0x475/0x5f0 net/socket.c:2117
> > > >>>>    __do_sys_sendto net/socket.c:2129 [inline]
> > > >>>>    __se_sys_sendto net/socket.c:2125 [inline]
> > > >>>>    __x64_sys_sendto+0xde/0xf0 net/socket.c:2125
> > > >>>>    do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> > > >>>>    do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
> > > >>>>    entry_SYSCALL_64_after_hwframe+0x63/0xcd
> > > >>>>
> > > >>>> Memory state around the buggy address:
> > > >>>>    ffff88807ddfff00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > > >>>>    ffff88807ddfff80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > > >>>>> ffff88807de00000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > > >>>>                      ^
> > > >>>>    ffff88807de00080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > > >>>>    ffff88807de00100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > > >>>> ==================================================================
> > > >>>>
> > > >>>
> > > >>>
> > > >>> I think the patch from below should fix it.
> > > >>>
> > > >>> I printed le16_to_cpu(sbi->s_es->s_desc_size) and it was greater than
> > > >>> EXT4_MAX_DESC_SIZE. What I think it happens is that the contents of the
> > > >>> super block in the buffer get corrupted sometime after the .get_tree
> > > >>> (which eventually calls __ext4_fill_super()) is called. So instead of
> > > >>> relying on the contents of the buffer, we should instead rely on the
> > > >>> s_desc_size initialized at the __ext4_fill_super() time.
> > > >>>
> > > >>> If someone finds this good (or bad), or has a more in depth explanation,
> > > >>> please let me know, it will help me better understand the subsystem. In
> > > >>> the meantime I'll continue to investigate this and prepare a patch for
> > > >>> it.
> > > >>
> > > >> If there's something corrupting the superblock while the filesystem is
> > > >> mounted, we need to find what is corrupting the SB and fix *that*. Not
> > > >> try
> > > >> to paper over the problem by not using the on-disk data... Maybe journal
> > > >> replay is corrupting the value or something like that?
> > > >>
> > > >>                                 Honza
> > > >>
> > > >
> > > > Ok, I agree. First thing would be to understand the reproducer and to
> > > > simplify it if possible. I haven't yet decoded what the syz repro is
> > > > doing at
> > > > https://syzkaller.appspot.com/text?tag=ReproSyz&x=16ce3de4c80000
> > > > Will reply to this email thread once I understand what's happening. If
> > > > you or someone else can decode the syz repro faster than me, shoot.
> > > >
> > >
> > > I can now explain how the contents of the super block of the buffer get
> > > corrupted. After the ext4 fs is mounted to the target ("./bus"), the
> > > reproducer maps 6MB of data starting at offset 0 in the target's file
> > > ("./bus"), then it starts overriding the data with something else, by
> > > using memcpy, memset, individual byte inits. Does that mean that we
> > > shouldn't rely on the contents of the super block in the buffer after we
> > > mount the file system? If so, then my patch stands. I'll be happy to
> > > extend it if needed. Below one may find a step by step interpretation of
> > > the reproducer.
> > >
> > > We have a strace log for the same bug, but on Android 5.15:
> > > https://syzkaller.appspot.com/text?tag=CrashLog&x=14ecec8cc80000
> > >
> > > Look for pid 328. You notice that the bpf() syscalls return error, so I
> > > commented them out in the c repro to confirm that they are not the
> > > cause. The bug reproduced without the bpf() calls. One can find the c
> > > repro at:
> > > https://syzkaller.appspot.com/text?tag=ReproC&x=17c5fc50c80000
> > >
> > > Let's look at these calls, just before the bug was hit:
> > > [pid   328] open("./bus",
> > > O_RDWR|O_CREAT|O_TRUNC|O_NONBLOCK|O_SYNC|O_DIRECT|O_LARGEFILE|O_NOATIME,
> > > 000) = 4
> > > [pid   328] mount("/dev/loop0", "./bus", NULL, MS_BIND, NULL) = 0
> > > [pid   328] open("./bus", O_RDWR|O_SYNC|O_NOATIME|0x3c) = 5
> > > [pid   328] mmap(0x20000000, 6291456,
> > > PROT_READ|PROT_WRITE|PROT_EXEC|PROT_SEM|0x47ffff0, MAP_SHARED|MAP_FIXED,
> > > 5, 0) = 0x20000000
> >
> > Yeah, looking at the reproducer, before this the reproducer also mounts
> > /dev/loop0 as ext4 filesystem.
> >
> > > - ./bus is created (if it does not exist), fd 4 is returned.
> > > - /dev/loop0 is mounted to ./bus
> > > - then it creates a new file descriptor (5) for the same ./bus
> > > - then it creates a mapping for ./bus starting at offset zero. The
> > > mapped area is at 0x20000000 and is of 0x600000ul length.
> >
> > So the result is that the reproducer modified the block device while it is
> > mounted by the filesystem. We know cases like this can crash the kernel and
> > it is inherently difficult to fix. We have to trust the buffer cache
> > contents as otherwise the performance will be unacceptable. For historical
> > reasons we also have to allow modifications of buffer cache while ext4 is
> > mounted because tune2fs uses this to e.g. update the label of a mounted
> > filesystem.
> >
> > Long-term we are moving ext4 in a direction where we can disallow block
> > device modifications while the fs is mounted but we are not there yet. I've
> > discussed some shorter-term solution to avoid such known problems with syzbot
> > developers and what seems plausible would be a kconfig option to disallow
> > writing to a block device when it is exclusively open by someone else.
> > But so far I didn't get to trying whether this would reasonably work. Would
> > you be interested in having a look into this?
> 
> Does this affect only the loop device or also USB storage devices?
> Say, if the USB device returns different contents during mount and on
> subsequent reads?

So if USB returns a different content, we are fine because we verify the
content each time when loading it into the buffer cache. But if something
in the software opens the block device and modifies it, it modifies
directly the buffer cache and thus bypasses any checks we do when loading
data from the storage.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
