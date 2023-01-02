Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBCD765AF24
	for <lists+linux-ext4@lfdr.de>; Mon,  2 Jan 2023 11:01:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232483AbjABKA7 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 2 Jan 2023 05:00:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232397AbjABKA4 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 2 Jan 2023 05:00:56 -0500
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 666B710C4
        for <linux-ext4@vger.kernel.org>; Mon,  2 Jan 2023 02:00:54 -0800 (PST)
Received: by mail-il1-f199.google.com with SMTP id n15-20020a056e021baf00b0030387c2e1d3so17537430ili.5
        for <linux-ext4@vger.kernel.org>; Mon, 02 Jan 2023 02:00:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/3sYdIIqXD3TNWdMD/Ryy2duPEvlDt8azEXzUT/oyMk=;
        b=4oSDub0OZTciDf8MlXc2s/xvIleiF0KWCdgqAme+e+J3C/z9QZ9v1NmlHshfRcKRPG
         WIEsFXiDQnd3Hpjp9ef9qSez22G5Ts5/O0p1hK5joDGN4aHwcYtsEIWqNHMnzvu25rgJ
         MzOssoJoNot4UZeROhWszKnhcXCxuUDC0WsELPRR8SrcHR2JwXm+gi8yUnsFO6pU//G6
         XOFZDCQSNOcZEZgqhO7yvSu6VjB7geutj95GTDEoUvDhwG6E62xkNGXrNrOENZRu/tSj
         z/HJYLNIujEui2JX07cNhOI6Lr9xeWDxTm26Rln2GjOAtov8VBpnMVshxgzwf2JwIWk0
         X56A==
X-Gm-Message-State: AFqh2kpW1D6fIYdaH9jgQ9ZBM+VbbPWbMRI+gBKpRxPo1iD98hH1+Ra9
        FVafgDYbndar9WFvTqoHmHu2YY1VmcrJAPG+VPzW0dP4+12E
X-Google-Smtp-Source: AMrXdXu+yh5pZeU5FV7IvdSJz14ARd4GtQsutWkjOmz43/Jv1IYHN0nYCNupIZdzpnLq2ZNwhkUZyZuokjpX5mWDE0GT+97XpLm8
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1303:b0:30c:1694:dc05 with SMTP id
 g3-20020a056e02130300b0030c1694dc05mr1816538ilr.236.1672653653763; Mon, 02
 Jan 2023 02:00:53 -0800 (PST)
Date:   Mon, 02 Jan 2023 02:00:53 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000dd6d6705f14506dd@google.com>
Subject: [syzbot] [ext4?] BUG: unable to handle kernel paging request in ext4_htree_store_dirent
From:   syzbot <syzbot+e95995159a736f0cd3f0@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu
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

HEAD commit:    a5541c0811a0 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=12b03958480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cbd4e584773e9397
dashboard link: https://syzkaller.appspot.com/bug?extid=e95995159a736f0cd3f0
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/4b7702208fb9/disk-a5541c08.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9ec0153ec051/vmlinux-a5541c08.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6f8725ad290a/Image-a5541c08.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e95995159a736f0cd3f0@syzkaller.appspotmail.com

Unable to handle kernel paging request at virtual address 0030303030303070
Mem abort info:
  ESR = 0x0000000096000004
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x04: level 0 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000004
  CM = 0, WnR = 0
[0030303030303070] address between user and kernel address ranges
Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
Modules linked in:
CPU: 1 PID: 3118 Comm: syz-executor.1 Not tainted 6.1.0-rc8-syzkaller-33330-ga5541c0811a0 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
pstate: 40400005 (nZcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __kmem_cache_alloc_node+0x17c/0x350 mm/slub.c:3437
lr : slab_pre_alloc_hook mm/slab.h:712 [inline]
lr : slab_alloc_node mm/slub.c:3318 [inline]
lr : __kmem_cache_alloc_node+0x80/0x350 mm/slub.c:3437
sp : ffff800010ff38e0
x29: ffff800010ff38f0 x28: ffff0000cb14cec0 x27: ffff00010a33200c
x26: 0000000000000001 x25: 00000000ffffffff x24: ffff8000087a7010
x23: 0000000000000033 x22: 3030303030303030 x21: 0000000000000000
x20: 0000000000000dc0 x19: ffff0000c0001200 x18: 0000000067c04b24
x17: 00000000f35b7102 x16: ffff80000dbe6158 x15: ffff0000cb14cec0
x14: 0000000000000010 x13: 0000000000000000 x12: ffff0000cb14cec0
x11: 0000000000000001 x10: 0000000000000000 x9 : 0000000000000040
x8 : 00000000008c2d71 x7 : ffff8000084c07a4 x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000000001 x3 : 00000000008c2d79
x2 : 0000000000000000 x1 : 0000000000000080 x0 : fffffc00045fa0c0
Call trace:
 next_tid mm/slub.c:2349 [inline]
 slab_alloc_node mm/slub.c:3382 [inline]
 __kmem_cache_alloc_node+0x17c/0x350 mm/slub.c:3437
 __do_kmalloc_node mm/slab_common.c:954 [inline]
 __kmalloc+0xb4/0x140 mm/slab_common.c:968
 kmalloc include/linux/slab.h:558 [inline]
 kzalloc include/linux/slab.h:689 [inline]
 ext4_htree_store_dirent+0x4c/0x1a8 fs/ext4/dir.c:474
 htree_dirblock_to_tree+0x374/0x510 fs/ext4/namei.c:1125
 ext4_htree_fill_tree+0x2a0/0x698 fs/ext4/namei.c:1204
 ext4_dx_readdir+0x58c/0x8c0 fs/ext4/dir.c:597
 ext4_readdir+0x17c/0xba4 fs/ext4/dir.c:142
 iterate_dir+0x114/0x28c
 __do_sys_getdents64 fs/readdir.c:369 [inline]
 __se_sys_getdents64 fs/readdir.c:354 [inline]
 __arm64_sys_getdents64+0x80/0x204 fs/readdir.c:354
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
 el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x48/0x140 arch/arm64/kernel/syscall.c:197
 el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:637
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:584
Code: 54000ee1 34000eeb b9402a69 91002103 (f8696ada) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	54000ee1 	b.ne	0x1dc  // b.any
   4:	34000eeb 	cbz	w11, 0x1e0
   8:	b9402a69 	ldr	w9, [x19, #40]
   c:	91002103 	add	x3, x8, #0x8
* 10:	f8696ada 	ldr	x26, [x22, x9] <-- trapping instruction


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
