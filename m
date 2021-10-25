Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 556E8439459
	for <lists+linux-ext4@lfdr.de>; Mon, 25 Oct 2021 12:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232560AbhJYK7w (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 25 Oct 2021 06:59:52 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:40823 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232625AbhJYK7t (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 25 Oct 2021 06:59:49 -0400
Received: by mail-io1-f71.google.com with SMTP id t1-20020a5d81c1000000b005de76e9e20cso5474809iol.7
        for <linux-ext4@vger.kernel.org>; Mon, 25 Oct 2021 03:57:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=skC0MN0LWJsv8NJPLncPz/C6ZTXW9VvQmWkmzfnaU0s=;
        b=4TEFL+3j8Fhs8tAkfhmDITijerUZA0G4sxbVB54DMklehi9+QmWGfudwIRDnnNlghU
         WBwAumadArkGtk0M9XP42+9txqvI0bOOVCduevsUfjLCSxTvU5uEm9Sru9pQJdlt+7X0
         R8n0q1ESQGPgGNxX2fuP2FhGyNjTdreV1f7H117Lso92f9ePGhHhgi8FDb49iCfzTFsL
         yWRN/FVxUT8/EWvFGE/p33M82A+CC/nlK2BCsGAeyWg4d63gVs4ZvJqQyfNfp+E7lTFp
         +X/JjRDWISBtOp8B2WOUB+BgWpmGC1vMiEDmJUsMeIN2KdLV0XUBD9zk2TfvQBk+ia2P
         /u5Q==
X-Gm-Message-State: AOAM532rvBuqaPZOkeGZNJh/Zv+oSR7/3N/aqZc+u6mkbpi6owO2iJ+0
        t6VTDZ5t0kwxrk/Yw/Xc2yz+JZ1SkVmNvjCZMTjef+obsxge
X-Google-Smtp-Source: ABdhPJzntQm6t/PLaUFKDFZbQaUp5/czZN0OoWsKqVNxOIhOgGwqaBnqVojfufLe30KPKsCHhLJpksRUW6BIsM39WpYtQvlJ4gDZ
MIME-Version: 1.0
X-Received: by 2002:a92:cda3:: with SMTP id g3mr8925898ild.103.1635159447424;
 Mon, 25 Oct 2021 03:57:27 -0700 (PDT)
Date:   Mon, 25 Oct 2021 03:57:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000003d49d05cf2b3a9e@google.com>
Subject: [syzbot] KCSAN: data-race in ext4_mark_iloc_dirty / ext4_mark_iloc_dirty
From:   syzbot <syzbot+900324b91168c395f1a2@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    9c0c4d24ac00 Merge tag 'block-5.15-2021-10-22' of git://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15418e52b00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6339b6ea86d89fd7
dashboard link: https://syzkaller.appspot.com/bug?extid=900324b91168c395f1a2
compiler:       Debian clang version 11.0.1-2, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+900324b91168c395f1a2@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in ext4_mark_iloc_dirty / ext4_mark_iloc_dirty

write to 0xffff888104bdf5c8 of 4 bytes by task 505 on cpu 0:
 ext4_update_inode_fsync_trans fs/ext4/ext4_jbd2.h:445 [inline]
 ext4_do_update_inode fs/ext4/inode.c:5114 [inline]
 ext4_mark_iloc_dirty+0x156a/0x1700 fs/ext4/inode.c:5683
 ext4_orphan_del+0x593/0x730 fs/ext4/orphan.c:297
 ext4_evict_inode+0xb1e/0xdb0 fs/ext4/inode.c:318
 evict+0x1c8/0x3c0 fs/inode.c:588
 iput_final fs/inode.c:1664 [inline]
 iput+0x430/0x580 fs/inode.c:1690
 do_unlinkat+0x2d4/0x540 fs/namei.c:4176
 __do_sys_unlink fs/namei.c:4217 [inline]
 __se_sys_unlink fs/namei.c:4215 [inline]
 __x64_sys_unlink+0x2c/0x30 fs/namei.c:4215
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x44/0xa0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae

write to 0xffff888104bdf5c8 of 4 bytes by task 6959 on cpu 1:
 ext4_update_inode_fsync_trans fs/ext4/ext4_jbd2.h:445 [inline]
 ext4_do_update_inode fs/ext4/inode.c:5114 [inline]
 ext4_mark_iloc_dirty+0x156a/0x1700 fs/ext4/inode.c:5683
 __ext4_mark_inode_dirty+0x4ec/0x5c0 fs/ext4/inode.c:5879
 ext4_evict_inode+0x95e/0xdb0 fs/ext4/inode.c:280
 evict+0x1c8/0x3c0 fs/inode.c:588
 iput_final fs/inode.c:1664 [inline]
 iput+0x430/0x580 fs/inode.c:1690
 dentry_unlink_inode+0x273/0x290 fs/dcache.c:376
 d_delete+0x78/0xe0 fs/dcache.c:2505
 vfs_rmdir+0x2e6/0x300 fs/namei.c:3984
 do_rmdir+0x18d/0x330 fs/namei.c:4032
 __do_sys_rmdir fs/namei.c:4051 [inline]
 __se_sys_rmdir fs/namei.c:4049 [inline]
 __x64_sys_rmdir+0x2c/0x30 fs/namei.c:4049
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x44/0xa0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae

value changed: 0x0000c326 -> 0x0000c327

Reported by Kernel Concurrency Sanitizer on:
CPU: 1 PID: 6959 Comm: syz-executor.2 Tainted: G        W         5.15.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
