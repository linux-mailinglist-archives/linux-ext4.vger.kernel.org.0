Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9AD5271F90
	for <lists+linux-ext4@lfdr.de>; Mon, 21 Sep 2020 12:02:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726478AbgIUKCW (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 21 Sep 2020 06:02:22 -0400
Received: from mail-io1-f80.google.com ([209.85.166.80]:37129 "EHLO
        mail-io1-f80.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbgIUKCW (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 21 Sep 2020 06:02:22 -0400
Received: by mail-io1-f80.google.com with SMTP id 80so9494536iou.4
        for <linux-ext4@vger.kernel.org>; Mon, 21 Sep 2020 03:02:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=j4KEEp1f2qaASWW5tBFBCzsHqw1ayvpgt5EnfAFvzn8=;
        b=eeleTgGeIbn1Kx5NDd9yRFJ8Fz286r0hEjcylfgsM8w88VdgIC4elSayhAey5gv+d7
         7JLbOKL+3dyLrruhZ5TSqK82CZ1KSNO+q9t0NGOLHoA2PBJQr6QckrebeHr/sxTq9lzV
         eYrEMnAgBnlGBAe0JAsBlgVXDDrJD76eRCwAKXYE3sVZjd26dpG3nxmiXIK5JRK4rgMV
         uOEhwSE5KjznE1WBEx8DcmnDyYllNs6lqaO8QltgjfN+NePVbdvJ3AcPMjkpkG4cI6Tc
         cUUFqcN/lFcpg3uxsGFDfxt09E23zC2+8XkMaWcJ1NH/4uPjeAvAmx35EDfH3iikjSOk
         4oVg==
X-Gm-Message-State: AOAM5307gCpoNxb0b++xU3VCq5jubt1jfH1VlxV8+og6iiDGgRjLEfMj
        HM5087ZJn9IQbVagzuO4xAhD/r6s26dlXESz2StL66QTaJLD
X-Google-Smtp-Source: ABdhPJwLt7DzlZJWJctl/F34SRCVAjsAFiUtbybYIrf96SyQHJD+TOXM9uCb5u/+pscovRM+npE4XYXfgTPA+HeBZ1bYlNz4WZV4
MIME-Version: 1.0
X-Received: by 2002:a92:6b04:: with SMTP id g4mr39343145ilc.203.1600682541201;
 Mon, 21 Sep 2020 03:02:21 -0700 (PDT)
Date:   Mon, 21 Sep 2020 03:02:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000443d8a05afcff2b5@google.com>
Subject: memory leak in kobject_set_name_vargs (3)
From:   syzbot <syzbot+9f864abad79fae7c17e1@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    bdcf11de Merge tag 'riscv-for-linus-5.9-rc6' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=179e18d3900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a1f3c5052e8097e9
dashboard link: https://syzkaller.appspot.com/bug?extid=9f864abad79fae7c17e1
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14c33cad900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=154bc6c3900000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9f864abad79fae7c17e1@syzkaller.appspotmail.com

BUG: memory leak
unreferenced object 0xffff88811a0d75c0 (size 32):
  comm "syz-executor307", pid 6444, jiffies 4294941412 (age 12.730s)
  hex dump (first 32 bytes):
    6c 6f 6f 70 30 00 00 00 00 00 00 00 00 00 00 00  loop0...........
    01 00 00 00 03 00 00 00 2b 00 00 00 00 00 00 00  ........+.......
  backtrace:
    [<00000000f89b0bef>] kstrdup+0x36/0x70 mm/util.c:60
    [<000000004b68a0da>] kstrdup_const+0x35/0x60 mm/util.c:82
    [<000000008eb65a51>] kvasprintf_const+0x72/0xe0 lib/kasprintf.c:48
    [<00000000691729e7>] kobject_set_name_vargs+0x3b/0xe0 lib/kobject.c:289
    [<00000000dfb16dfe>] kobject_add_varg lib/kobject.c:384 [inline]
    [<00000000dfb16dfe>] kobject_init_and_add+0x6d/0xc0 lib/kobject.c:473
    [<000000005849f02f>] ext4_register_sysfs+0x6b/0x160 fs/ext4/sysfs.c:508
    [<0000000027523718>] ext4_fill_super+0x2d04/0x46c0 fs/ext4/super.c:4799
    [<0000000095f0e4f3>] mount_bdev+0x1d3/0x210 fs/super.c:1417
    [<00000000415e8d00>] legacy_get_tree+0x26/0x70 fs/fs_context.c:592
    [<00000000bf686d81>] vfs_get_tree+0x28/0xe0 fs/super.c:1547
    [<00000000fd6d6aba>] do_new_mount fs/namespace.c:2875 [inline]
    [<00000000fd6d6aba>] path_mount+0x90e/0xda0 fs/namespace.c:3192
    [<000000008d02c1d0>] do_mount fs/namespace.c:3205 [inline]
    [<000000008d02c1d0>] __do_sys_mount fs/namespace.c:3413 [inline]
    [<000000008d02c1d0>] __se_sys_mount fs/namespace.c:3390 [inline]
    [<000000008d02c1d0>] __x64_sys_mount+0x140/0x190 fs/namespace.c:3390
    [<000000001c682859>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
    [<0000000095c447b2>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff88811a0d74e0 (size 32):
  comm "syz-executor307", pid 6451, jiffies 4294941943 (age 7.420s)
  hex dump (first 32 bytes):
    6c 6f 6f 70 30 00 00 00 00 00 00 00 00 00 00 00  loop0...........
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<00000000f89b0bef>] kstrdup+0x36/0x70 mm/util.c:60
    [<000000004b68a0da>] kstrdup_const+0x35/0x60 mm/util.c:82
    [<000000008eb65a51>] kvasprintf_const+0x72/0xe0 lib/kasprintf.c:48
    [<00000000691729e7>] kobject_set_name_vargs+0x3b/0xe0 lib/kobject.c:289
    [<00000000dfb16dfe>] kobject_add_varg lib/kobject.c:384 [inline]
    [<00000000dfb16dfe>] kobject_init_and_add+0x6d/0xc0 lib/kobject.c:473
    [<000000005849f02f>] ext4_register_sysfs+0x6b/0x160 fs/ext4/sysfs.c:508
    [<0000000027523718>] ext4_fill_super+0x2d04/0x46c0 fs/ext4/super.c:4799
    [<0000000095f0e4f3>] mount_bdev+0x1d3/0x210 fs/super.c:1417
    [<00000000415e8d00>] legacy_get_tree+0x26/0x70 fs/fs_context.c:592
    [<00000000bf686d81>] vfs_get_tree+0x28/0xe0 fs/super.c:1547
    [<00000000fd6d6aba>] do_new_mount fs/namespace.c:2875 [inline]
    [<00000000fd6d6aba>] path_mount+0x90e/0xda0 fs/namespace.c:3192
    [<000000008d02c1d0>] do_mount fs/namespace.c:3205 [inline]
    [<000000008d02c1d0>] __do_sys_mount fs/namespace.c:3413 [inline]
    [<000000008d02c1d0>] __se_sys_mount fs/namespace.c:3390 [inline]
    [<000000008d02c1d0>] __x64_sys_mount+0x140/0x190 fs/namespace.c:3390
    [<000000001c682859>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
    [<0000000095c447b2>] entry_SYSCALL_64_after_hwframe+0x44/0xa9



---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
