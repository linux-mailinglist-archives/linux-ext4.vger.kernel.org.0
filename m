Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE3D930A431
	for <lists+linux-ext4@lfdr.de>; Mon,  1 Feb 2021 10:18:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232802AbhBAJRR (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 1 Feb 2021 04:17:17 -0500
Received: from mail-il1-f197.google.com ([209.85.166.197]:47559 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232704AbhBAJQw (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 1 Feb 2021 04:16:52 -0500
Received: by mail-il1-f197.google.com with SMTP id y12so4234314ilu.14
        for <linux-ext4@vger.kernel.org>; Mon, 01 Feb 2021 01:16:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=PfqqKaGy38PTHwEubCQk5qbh0oisqJ7mRK3LM8lNjJY=;
        b=gj5k50uwGmKGhELXSL45/AciFa5VBrNYP1dggbOvIDJ7HhOil00ahZ0EayH54x7vwr
         dI0iHGyB6Vv4jIVWrFszAzzxW5lBbFj1yMj67ggieN9qguYDclT6ucnislZmuQM3XYPH
         JPUwCvcsJpHUinDrA9OuAADVStXlyW21im/j43liI6KPNRV2G10YEnfgHsVcLU7pVzQM
         J1Q0vsLzgxZWvnZ1ieo1SYpgzpif8c1OKIQ5KWl8GPAG4Gj3jcaWID7wVvhhGehW4p7O
         ud8F2fDJ+yeCO5y5YcyZlXIWnD+bG7Nyw9TF48+maPd9yvx2pNwL+YlQUUOGNqUKuFJR
         5hAg==
X-Gm-Message-State: AOAM531ZpxWx9LTPHoxnE7/XotOU+2Janx7Wan6Ns0pdVF2+q1Rk9iJY
        qvfg8AqmIE9MESK9wmQNZUm21gIEJBrCMK4qxHNbl7B8mV2Y
X-Google-Smtp-Source: ABdhPJy72jHACnFpjQDXXr0NT17id6K/Xm/BMyAuipj0cTAREguj+4EI/3tftvdCAKyqobsM/Xgyb4ea8x+My4uTxDV18myrImoY
MIME-Version: 1.0
X-Received: by 2002:a05:6638:116:: with SMTP id x22mr13488247jao.93.1612170971594;
 Mon, 01 Feb 2021 01:16:11 -0800 (PST)
Date:   Mon, 01 Feb 2021 01:16:11 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000014448405ba42ce31@google.com>
Subject: UBSAN: shift-out-of-bounds in ext4_mb_init
From:   syzbot <syzbot+a8b4b0c60155e87e9484@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, adilger@whamcloud.com,
        bzzz@whamcloud.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    6642d600 Merge tag '5.11-rc5-smb3' of git://git.samba.org/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16f064acd00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9408d1770a50819c
dashboard link: https://syzkaller.appspot.com/bug?extid=a8b4b0c60155e87e9484
compiler:       clang version 11.0.1
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=127be3d8d00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1065a9e8d00000

The issue was bisected to:

commit cfd73237722135807967f389bcbda558a60a30d6
Author: Alex Zhuravlev <bzzz@whamcloud.com>
Date:   Tue Apr 21 07:54:07 2020 +0000

    ext4: add prefetching for block allocation bitmaps

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13b5c1d8d00000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1075c1d8d00000
console output: https://syzkaller.appspot.com/x/log.txt?x=17b5c1d8d00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a8b4b0c60155e87e9484@syzkaller.appspotmail.com
Fixes: cfd732377221 ("ext4: add prefetching for block allocation bitmaps")

loop0: detected capacity change from 264192 to 0
================================================================================
UBSAN: shift-out-of-bounds in fs/ext4/mballoc.c:2713:24
shift exponent 60 is too large for 32-bit type 'int'
CPU: 1 PID: 8433 Comm: syz-executor484 Not tainted 5.11.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x137/0x1be lib/dump_stack.c:120
 ubsan_epilogue lib/ubsan.c:148 [inline]
 __ubsan_handle_shift_out_of_bounds+0x432/0x4d0 lib/ubsan.c:395
 ext4_mb_init_backend fs/ext4/mballoc.c:2713 [inline]
 ext4_mb_init+0x19bc/0x19f0 fs/ext4/mballoc.c:2898
 ext4_fill_super+0xc2ec/0xfbe0 fs/ext4/super.c:4983
 mount_bdev+0x26c/0x3a0 fs/super.c:1366
 legacy_get_tree+0xea/0x180 fs/fs_context.c:592
 vfs_get_tree+0x86/0x270 fs/super.c:1496
 do_new_mount fs/namespace.c:2881 [inline]
 path_mount+0x17ad/0x2a00 fs/namespace.c:3211
 do_mount fs/namespace.c:3224 [inline]
 __do_sys_mount fs/namespace.c:3432 [inline]
 __se_sys_mount+0x28c/0x320 fs/namespace.c:3409
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x44710a
Code: b8 08 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 fd ad fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 0f 83 da ad fb ff c3 66 0f 1f 84 00 00 00 00 00
RSP: 002b:00007ffc5b95ff48 EFLAGS: 00000206 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007ffc5b95ffa0 RCX: 000000000044710a
RDX: 0000000020000000 RSI: 0000000020000180 RDI: 00007ffc5b95ff60
RBP: 00007ffc5b95ff60 R08: 00007ffc5b95ffa0 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000206 R12: 0000000000000013
R13: 0000000000000004 R14: 0000000000000003 R15: 0000000000000003
================================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
