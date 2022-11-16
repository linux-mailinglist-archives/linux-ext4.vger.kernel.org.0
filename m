Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7CC62C26D
	for <lists+linux-ext4@lfdr.de>; Wed, 16 Nov 2022 16:25:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233379AbiKPPZj (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 16 Nov 2022 10:25:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232009AbiKPPZj (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 16 Nov 2022 10:25:39 -0500
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5A99F25
        for <linux-ext4@vger.kernel.org>; Wed, 16 Nov 2022 07:25:37 -0800 (PST)
Received: by mail-il1-f198.google.com with SMTP id d2-20020a056e020be200b00300ecc7e0d4so13352167ilu.5
        for <linux-ext4@vger.kernel.org>; Wed, 16 Nov 2022 07:25:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=68N2xS9/qlYpCMYhLzwM4pJ45bPpQ706olwGX56CiVI=;
        b=69MjzKnO7RloRtVI7lMtYLaYF6CgDq+tXwSKuz9UiXb1Ae+pjNRUGBIjZ2mkf5DPcO
         6JzPJYgokmwWDomiejfKMSQwSSdM5r11SMntlXlXo2nD0o4ho3BojEyDsR5hGbg/YAv0
         ncdFsz2JDZDroqf3qEo1ZeJG33Kk8Wd88S+idi7HH9M25gPo61nGBX005yVUHJUzRM0a
         vQyjiRnVrcGlAGX3c2Y7y1E+lt4nYL2QGWyyR8rf6dJjdtHYgJDYFvrA1Y40XARYSHer
         KV5RIiqFhcjs5Q7ZiQAcuVkB0Q7mV0pQfjpogCsB7NBNmSEEq2k/7OAMye0Xeeqr1Tsq
         tPog==
X-Gm-Message-State: ANoB5pmHkFENWRiXtp99RiPW8ftWFf7mjU7S1xBGyGGVulwLO2k5AayN
        JrIsoCYrceSexuTgp31PunU0U18130ckKXjB0OuDUvsbJTWx
X-Google-Smtp-Source: AA0mqf774zJLjVplinj2vmnuTWLzr4UQdjD3lomAIdqd7nFEg39qjWi/T6vYXLNSk7awuNtVAgilAIICMAwdVg8u4fJTdGHW05tM
MIME-Version: 1.0
X-Received: by 2002:a05:6602:22c8:b0:6de:1179:f429 with SMTP id
 e8-20020a05660222c800b006de1179f429mr6643334ioe.175.1668612337194; Wed, 16
 Nov 2022 07:25:37 -0800 (PST)
Date:   Wed, 16 Nov 2022 07:25:37 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a05e6705ed98152b@google.com>
Subject: [syzbot] KMSAN: uninit-value in ext4_evict_inode
From:   syzbot <syzbot+57b25da729eb0b88177d@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, glider@google.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    cb231e2f67ec fs: more fsdata fixes
git tree:       https://github.com/google/kmsan.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=138f5735880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=dc6d7125db95a828
dashboard link: https://syzkaller.appspot.com/bug?extid=57b25da729eb0b88177d
compiler:       clang version 15.0.0 (https://github.com/llvm/llvm-project.git 610139d2d9ce6746b3c617fb3e2f7886272d26ff), GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/6eabbc575a06/disk-cb231e2f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/01e99c04e1d7/vmlinux-cb231e2f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/67893482166a/bzImage-cb231e2f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+57b25da729eb0b88177d@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in ext4_evict_inode+0xdd/0x26b0 fs/ext4/inode.c:180
 ext4_evict_inode+0xdd/0x26b0 fs/ext4/inode.c:180
 evict+0x365/0x9a0 fs/inode.c:664
 iput_final fs/inode.c:1747 [inline]
 iput+0x985/0xdd0 fs/inode.c:1773
 __ext4_new_inode+0xe54/0x7ec0 fs/ext4/ialloc.c:1361
 ext4_mknod+0x376/0x840 fs/ext4/namei.c:2844
 vfs_mknod+0x79d/0x830 fs/namei.c:3914
 do_mknodat+0x47d/0xaa0
 __do_sys_mknodat fs/namei.c:3992 [inline]
 __se_sys_mknodat fs/namei.c:3989 [inline]
 __ia32_sys_mknodat+0xeb/0x150 fs/namei.c:3989
 do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
 __do_fast_syscall_32+0xa2/0x100 arch/x86/entry/common.c:178
 do_fast_syscall_32+0x33/0x70 arch/x86/entry/common.c:203
 do_SYSENTER_32+0x1b/0x20 arch/x86/entry/common.c:246
 entry_SYSENTER_compat_after_hwframe+0x70/0x82

Uninit was created at:
 __alloc_pages+0x9f1/0xe80 mm/page_alloc.c:5578
 alloc_pages+0xaae/0xd80 mm/mempolicy.c:2285
 alloc_slab_page mm/slub.c:1794 [inline]
 allocate_slab+0x1b5/0x1010 mm/slub.c:1939
 new_slab mm/slub.c:1992 [inline]
 ___slab_alloc+0x10c3/0x2d60 mm/slub.c:3180
 __slab_alloc mm/slub.c:3279 [inline]
 slab_alloc_node mm/slub.c:3364 [inline]
 slab_alloc mm/slub.c:3406 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3413 [inline]
 kmem_cache_alloc_lru+0x6f3/0xb30 mm/slub.c:3429
 alloc_inode_sb include/linux/fs.h:3117 [inline]
 ext4_alloc_inode+0x5f/0x860 fs/ext4/super.c:1321
 alloc_inode+0x83/0x440 fs/inode.c:259
 new_inode_pseudo fs/inode.c:1018 [inline]
 new_inode+0x3b/0x430 fs/inode.c:1046
 __ext4_new_inode+0x2a7/0x7ec0 fs/ext4/ialloc.c:959
 ext4_mkdir+0x4d5/0x1560 fs/ext4/namei.c:2992
 vfs_mkdir+0x62a/0x870 fs/namei.c:4035
 do_mkdirat+0x466/0x7b0 fs/namei.c:4060
 __do_sys_mkdirat fs/namei.c:4075 [inline]
 __se_sys_mkdirat fs/namei.c:4073 [inline]
 __ia32_sys_mkdirat+0xc4/0x120 fs/namei.c:4073
 do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
 __do_fast_syscall_32+0xa2/0x100 arch/x86/entry/common.c:178
 do_fast_syscall_32+0x33/0x70 arch/x86/entry/common.c:203
 do_SYSENTER_32+0x1b/0x20 arch/x86/entry/common.c:246
 entry_SYSENTER_compat_after_hwframe+0x70/0x82

CPU: 1 PID: 4625 Comm: syz-executor.2 Not tainted 6.1.0-rc4-syzkaller-62821-gcb231e2f67ec #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
=====================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
