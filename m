Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C58AF5A2CE1
	for <lists+linux-ext4@lfdr.de>; Fri, 26 Aug 2022 18:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234340AbiHZQx3 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 26 Aug 2022 12:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344544AbiHZQx1 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 26 Aug 2022 12:53:27 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 947964E848
        for <linux-ext4@vger.kernel.org>; Fri, 26 Aug 2022 09:53:26 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id q10-20020a0566022f0a00b00688d703717bso1232388iow.9
        for <linux-ext4@vger.kernel.org>; Fri, 26 Aug 2022 09:53:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc;
        bh=O4xE16U1PcNmJvjpOhAN7LuGuI92F91Ca8SLJk21uSE=;
        b=ZEEv0qyuZsfSv/0YfkOt+tJ/FIw4RgafljCYFKEH5oNVNg8QIodNzPPkwRzz0ewxI4
         AWm/NS6ysvN/L54m1Jjs44VGKR/3hdK6ZlOlJWpha15YEmCjwgKEGkTxz4ka298zxlTf
         8SzSuDQ/8FCsrXE4kY3HKzHBbHUpkg198Ey9k2Nf/kvmcciWE9bLSJnXZFbJuhGsCRwD
         fR0agBhO0FeqVxWDB9lFfqiHfpeyjFnqiNgixuYQ6hCk2Q7wRZYnX8rmz96722JeKHu/
         2HL9IdyHjGJxOItJ9wVkBvEvLq6IaLvFXeqkPAJu3zC+5WI36TGlM4dTHkEQg00KjZSA
         FoiA==
X-Gm-Message-State: ACgBeo3OFbCswxLTmh5dpaI0D20ZmBp4E8CxbHNa/X8CmBP+NLv3mAie
        wp+pWsu1zibIj7qR1tH4kS7YokJwXefc5Ldgwo7Z5dKF7KBz
X-Google-Smtp-Source: AA6agR7FLZVFUv6fjm0fltgjZs2aUZj2vnwWLzSsh6q6zjMQGFJlD1zJQcmnGG2dzIdVBHU48SGqk269+nAQkilpTFXQFflmqzYt
MIME-Version: 1.0
X-Received: by 2002:a92:511:0:b0:2ea:9574:c6b8 with SMTP id
 q17-20020a920511000000b002ea9574c6b8mr2299310ile.31.1661532805948; Fri, 26
 Aug 2022 09:53:25 -0700 (PDT)
Date:   Fri, 26 Aug 2022 09:53:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ae6d9205e727c0f5@google.com>
Subject: [syzbot] WARNING in ext2_fill_super
From:   syzbot <syzbot+0f2f7e65a3007d39539f@syzkaller.appspotmail.com>
To:     jack@suse.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    680fb5b009e8 Merge tag 'arm64-upstream' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=13afe5e3080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4557ad2600fc45f4
dashboard link: https://syzkaller.appspot.com/bug?extid=0f2f7e65a3007d39539f
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14ea730d080000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1546af0d080000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0f2f7e65a3007d39539f@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 15
Dev loop0: unable to read RDB block 15
 loop0: unable to read partition table
loop0: partition table beyond EOD, truncated
------------[ cut here ]------------
WARNING: CPU: 0 PID: 3025 at mm/page_alloc.c:5403 __alloc_pages+0x150/0x1fc mm/page_alloc.c:5403
Modules linked in:
CPU: 0 PID: 3025 Comm: syz-executor332 Not tainted 5.19.0-rc8-syzkaller-01618-g680fb5b009e8 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/20/2022
pstate: 20400005 (nzCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __alloc_pages+0x150/0x1fc mm/page_alloc.c:5403
lr : alloc_pages+0x2fc/0x404
sp : ffff80000fee3960
x29: ffff80000fee39a0 x28: 00000000000007c0 x27: ffff0000ca8a0800
x26: ffff80000ef11938 x25: ffff0000c5470000 x24: ffff80000ee71730
x23: 0000000000000000 x22: 0000000000000000 x21: 0000000000000000
x20: 0000000000000000 x19: 000000000000000c x18: 00000000000000c0
x17: 0000000000000009 x16: 0000000000000000 x15: 0000000000000000
x14: 0000000000000000 x13: 0000000000000005 x12: ffff80000d468290
x11: ff808000084ff6a0 x10: 0000000000000000 x9 : 0000000000000001
x8 : ffff80000d8c1000 x7 : ffff80000856455c x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000000002 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 000000000000000c x0 : 0000000000040dc0
Call trace:
 __alloc_pages+0x150/0x1fc mm/page_alloc.c:5403
 alloc_pages+0x2fc/0x404
 kmalloc_order+0x34/0x104 mm/slab_common.c:945
 kmalloc_order_trace+0x2c/0x7c mm/slab_common.c:961
 kmalloc_large include/linux/slab.h:529 [inline]
 __kmalloc+0x2cc/0x374 mm/slub.c:4435
 kmalloc_array include/linux/slab.h:640 [inline]
 kcalloc include/linux/slab.h:671 [inline]
 ext2_fill_super+0xad0/0xfe0 fs/ext2/super.c:1085
 mount_bdev+0x1b8/0x210 fs/super.c:1367
 ext2_mount+0x44/0x58 fs/ext2/super.c:1465
 legacy_get_tree+0x30/0x74 fs/fs_context.c:610
 vfs_get_tree+0x40/0x140 fs/super.c:1497
 do_new_mount+0x1dc/0x4e4 fs/namespace.c:3040
 path_mount+0x358/0x8b0 fs/namespace.c:3370
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount fs/namespace.c:3568 [inline]
 __arm64_sys_mount+0x2f8/0x408 fs/namespace.c:3568
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
 el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x48/0x154 arch/arm64/kernel/syscall.c:206
 el0_svc+0x58/0x14c arch/arm64/kernel/entry-common.c:624
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:642
 el0t_64_sync+0x18c/0x190
irq event stamp: 12290
hardirqs last  enabled at (12289): [<ffff800008438d28>] mod_lruvec_page_state include/linux/vmstat.h:569 [inline]
hardirqs last  enabled at (12289): [<ffff800008438d28>] kmalloc_order+0xac/0x104 mm/slab_common.c:948
hardirqs last disabled at (12290): [<ffff80000bfa4314>] el1_dbg+0x24/0x5c arch/arm64/kernel/entry-common.c:395
softirqs last  enabled at (12146): [<ffff8000080102e4>] _stext+0x2e4/0x37c
softirqs last disabled at (12129): [<ffff800008101e20>] do_softirq_own_stack include/asm-generic/softirq_stack.h:10 [inline]
softirqs last disabled at (12129): [<ffff800008101e20>] invoke_softirq+0x70/0xbc kernel/softirq.c:452
---[ end trace 0000000000000000 ]---
EXT2-fs (loop0): error: not enough memory


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
