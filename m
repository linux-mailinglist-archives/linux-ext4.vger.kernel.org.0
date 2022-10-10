Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3DF15F99F6
	for <lists+linux-ext4@lfdr.de>; Mon, 10 Oct 2022 09:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231591AbiJJH3T (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 10 Oct 2022 03:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232390AbiJJH24 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 10 Oct 2022 03:28:56 -0400
Received: from mail-io1-xd47.google.com (mail-io1-xd47.google.com [IPv6:2607:f8b0:4864:20::d47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97C185E330
        for <linux-ext4@vger.kernel.org>; Mon, 10 Oct 2022 00:23:38 -0700 (PDT)
Received: by mail-io1-xd47.google.com with SMTP id j20-20020a6b3114000000b006a3211a0ff0so6714921ioa.7
        for <linux-ext4@vger.kernel.org>; Mon, 10 Oct 2022 00:23:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NGoThy7TJe2yljVtnWE6Uf0DsLu4yQMNAkIqerh70AM=;
        b=OZz/IxVsa2Wp2e8XJBb8WoRuCcpi/b+FbZOYLP58tztBw5aNV+mrlcoHLBmRVoOMG+
         tew7rgO+/ypRQuViU2Rn67ogv/8Sr4r5q/UqiGR4qdezJXoXDxrtsJpGgPfEokCWgFtn
         tgRi2bxT7GgW/+yJVlxPgCqs32bOYmGmx8jleIgKHXcP39oIVXVKx2e71kQ4vVUWpBjx
         eC3sazEYbeZy/OyCY7LZM45abadWJha/HB/eomjBP9o2mUFZgZntQuvLyATD3OQ2hLF1
         bdunzRM1pa879QcrsIR+6+yuSe4wu1bZ51fSh4hrgDVQsRODDH+7kXJaEXvZ9Xoo5dR9
         uf/w==
X-Gm-Message-State: ACrzQf10Ax/dHtAoqCZn0yTPaC3ML6jktzNFKhp4+euGf8q5EFW7xUS3
        +6MFS13Z0NY2FE2FSSy1O601oxpmY1YWN8VC0uho62ie3hWq
X-Google-Smtp-Source: AMsMyM7aeyRfY8X9Ejb3A+1i5Y4SpZvkZVagN5g1qzY+LGdr7dyNgn6OEUO2MlaalFyq/7dnx8oRsqywzLO8mRD/H/iCHwSfIBNG
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3791:b0:6a2:f312:a26a with SMTP id
 be17-20020a056602379100b006a2f312a26amr7734350iob.83.1665386260165; Mon, 10
 Oct 2022 00:17:40 -0700 (PDT)
Date:   Mon, 10 Oct 2022 00:17:40 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007378eb05eaa8f450@google.com>
Subject: [syzbot] possible deadlock in ext4_ioctl
From:   syzbot <syzbot+09fc75e906a761cf8eb3@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    4c86114194e6 Merge tag 'iomap-6.1-merge-1' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11c7311c880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9905c889cc4ad738
dashboard link: https://syzkaller.appspot.com/bug?extid=09fc75e906a761cf8eb3
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/bf7f1dcd539b/disk-4c861141.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c214481af743/vmlinux-4c861141.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+09fc75e906a761cf8eb3@syzkaller.appspotmail.com

loop1: detected capacity change from 0 to 1024
EXT4-fs (loop1): mounted filesystem without journal. Quota mode: writeback.
======================================================
WARNING: possible circular locking dependency detected
6.0.0-syzkaller-06475-g4c86114194e6 #0 Not tainted
------------------------------------------------------
syz-executor.1/28617 is trying to acquire lock:
ffff88803cd070e0 (&ei->i_data_sem/1){+.+.}-{3:3}, at: swap_inode_boot_loader fs/ext4/ioctl.c:426 [inline]
ffff88803cd070e0 (&ei->i_data_sem/1){+.+.}-{3:3}, at: __ext4_ioctl fs/ext4/ioctl.c:1417 [inline]
ffff88803cd070e0 (&ei->i_data_sem/1){+.+.}-{3:3}, at: ext4_ioctl+0x4129/0x5510 fs/ext4/ioctl.c:1607

but task is already holding lock:
ffff88803cd048c0 (&ei->i_data_sem/2){++++}-{3:3}, at: ext4_double_down_write_data_sem+0x28/0x40

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (&ei->i_data_sem/2){++++}-{3:3}:
       lock_acquire+0x182/0x3c0 kernel/locking/lockdep.c:5666
       down_read+0x39/0x50 kernel/locking/rwsem.c:1499
       ext4_map_blocks+0x398/0x1cc0 fs/ext4/inode.c:568
       ext4_getblk+0x1b9/0x770 fs/ext4/inode.c:858
       ext4_bread+0x2a/0x170 fs/ext4/inode.c:914
       ext4_quota_write+0x225/0x570 fs/ext4/super.c:7087
       write_blk fs/quota/quota_tree.c:64 [inline]
       get_free_dqblk+0x357/0x6a0 fs/quota/quota_tree.c:93
       do_insert_tree+0x26c/0x1a40 fs/quota/quota_tree.c:300
       do_insert_tree+0x693/0x1a40 fs/quota/quota_tree.c:331
       dq_insert_tree fs/quota/quota_tree.c:357 [inline]
       qtree_write_dquot+0x3b6/0x530 fs/quota/quota_tree.c:376
       v2_write_dquot+0x11b/0x190 fs/quota/quota_v2.c:358
       dquot_acquire+0x348/0x670 fs/quota/dquot.c:444
       ext4_acquire_dquot+0x2e0/0x400 fs/ext4/super.c:6743
       dqget+0x999/0xdc0 fs/quota/dquot.c:914
       __dquot_initialize+0x291/0xcf0 fs/quota/dquot.c:1492
       ext4_mkdir+0x194/0xcf0 fs/ext4/namei.c:2977
       vfs_mkdir+0x3b3/0x590 fs/namei.c:4013
       do_mkdirat+0x279/0x550 fs/namei.c:4038
       __do_sys_mkdirat fs/namei.c:4053 [inline]
       __se_sys_mkdirat fs/namei.c:4051 [inline]
       __x64_sys_mkdirat+0x85/0x90 fs/namei.c:4051
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #2 (&s->s_dquot.dqio_sem){++++}-{3:3}:
       lock_acquire+0x182/0x3c0 kernel/locking/lockdep.c:5666
       down_read+0x39/0x50 kernel/locking/rwsem.c:1499
       v2_read_dquot+0x4a/0x100 fs/quota/quota_v2.c:332
       dquot_acquire+0x186/0x670 fs/quota/dquot.c:435
       ext4_acquire_dquot+0x2e0/0x400 fs/ext4/super.c:6743
       dqget+0x999/0xdc0 fs/quota/dquot.c:914
       __dquot_initialize+0x291/0xcf0 fs/quota/dquot.c:1492
       ext4_create+0xb0/0x560 fs/ext4/namei.c:2794
       lookup_open fs/namei.c:3413 [inline]
       open_last_lookups fs/namei.c:3481 [inline]
       path_openat+0x12d0/0x2df0 fs/namei.c:3688
       do_filp_open+0x264/0x4f0 fs/namei.c:3718
       do_sys_openat2+0x124/0x4e0 fs/open.c:1310
       do_sys_open fs/open.c:1326 [inline]
       __do_sys_open fs/open.c:1334 [inline]
       __se_sys_open fs/open.c:1330 [inline]
       __x64_sys_open+0x221/0x270 fs/open.c:1330
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #1 (&dquot->dq_lock){+.+.}-{3:3}:
       lock_acquire+0x182/0x3c0 kernel/locking/lockdep.c:5666
       __mutex_lock_common+0x1bd/0x26e0 kernel/locking/mutex.c:603
       __mutex_lock kernel/locking/mutex.c:747 [inline]
       mutex_lock_nested+0x17/0x20 kernel/locking/mutex.c:799
       dquot_commit+0x58/0x4e0 fs/quota/dquot.c:479
       ext4_write_dquot+0x1e4/0x2b0 fs/ext4/super.c:6727
       mark_dquot_dirty fs/quota/dquot.c:346 [inline]
       mark_all_dquot_dirty fs/quota/dquot.c:384 [inline]
       __dquot_alloc_space+0xa09/0x1030 fs/quota/dquot.c:1722
       dquot_alloc_space_nodirty include/linux/quotaops.h:300 [inline]
       dquot_alloc_space include/linux/quotaops.h:313 [inline]
       swap_inode_boot_loader fs/ext4/ioctl.c:493 [inline]
       __ext4_ioctl fs/ext4/ioctl.c:1417 [inline]
       ext4_ioctl+0x501f/0x5510 fs/ext4/ioctl.c:1607
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:870 [inline]
       __se_sys_ioctl+0xfb/0x170 fs/ioctl.c:856
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #0 (&ei->i_data_sem/1){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3095 [inline]
       check_prevs_add kernel/locking/lockdep.c:3214 [inline]
       validate_chain+0x18c1/0x6bd0 kernel/locking/lockdep.c:3829
       __lock_acquire+0x1292/0x1f60 kernel/locking/lockdep.c:5053
       lock_acquire+0x182/0x3c0 kernel/locking/lockdep.c:5666
       down_write_nested+0x9e/0x180 kernel/locking/rwsem.c:1662
       swap_inode_boot_loader fs/ext4/ioctl.c:426 [inline]
       __ext4_ioctl fs/ext4/ioctl.c:1417 [inline]
       ext4_ioctl+0x4129/0x5510 fs/ext4/ioctl.c:1607
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:870 [inline]
       __se_sys_ioctl+0xfb/0x170 fs/ioctl.c:856
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

other info that might help us debug this:

Chain exists of:
  &ei->i_data_sem/1 --> &s->s_dquot.dqio_sem --> &ei->i_data_sem/2

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&ei->i_data_sem/2);
                               lock(&s->s_dquot.dqio_sem);
                               lock(&ei->i_data_sem/2);
  lock(&ei->i_data_sem/1);

 *** DEADLOCK ***

5 locks held by syz-executor.1/28617:
 #0: ffff888077ba8460 (sb_writers#4){.+.+}-{0:0}, at: mnt_want_write_file+0x5a/0x1f0 fs/namespace.c:437
 #1: ffff88803cd04a38 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: inode_lock include/linux/fs.h:756 [inline]
 #1: ffff88803cd04a38 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: lock_two_nondirectories+0xdd/0x130 fs/inode.c:1121
 #2: ffff88803cd07258 (&sb->s_type->i_mutex_key#8/4){+.+.}-{3:3}, at: swap_inode_boot_loader fs/ext4/ioctl.c:385 [inline]
 #2: ffff88803cd07258 (&sb->s_type->i_mutex_key#8/4){+.+.}-{3:3}, at: __ext4_ioctl fs/ext4/ioctl.c:1417 [inline]
 #2: ffff88803cd07258 (&sb->s_type->i_mutex_key#8/4){+.+.}-{3:3}, at: ext4_ioctl+0x23c6/0x5510 fs/ext4/ioctl.c:1607
 #3: ffff88803cd04bd8 (mapping.invalidate_lock){++++}-{3:3}, at: filemap_invalidate_lock include/linux/fs.h:801 [inline]
 #3: ffff88803cd04bd8 (mapping.invalidate_lock){++++}-{3:3}, at: swap_inode_boot_loader fs/ext4/ioctl.c:402 [inline]
 #3: ffff88803cd04bd8 (mapping.invalidate_lock){++++}-{3:3}, at: __ext4_ioctl fs/ext4/ioctl.c:1417 [inline]
 #3: ffff88803cd04bd8 (mapping.invalidate_lock){++++}-{3:3}, at: ext4_ioctl+0x3e21/0x5510 fs/ext4/ioctl.c:1607
 #4: ffff88803cd048c0 (&ei->i_data_sem/2){++++}-{3:3}, at: ext4_double_down_write_data_sem+0x28/0x40

stack backtrace:
CPU: 1 PID: 28617 Comm: syz-executor.1 Not tainted 6.0.0-syzkaller-06475-g4c86114194e6 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/22/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1b1/0x28e lib/dump_stack.c:106
 check_noncircular+0x2cc/0x390 kernel/locking/lockdep.c:2175
 check_prev_add kernel/locking/lockdep.c:3095 [inline]
 check_prevs_add kernel/locking/lockdep.c:3214 [inline]
 validate_chain+0x18c1/0x6bd0 kernel/locking/lockdep.c:3829
 __lock_acquire+0x1292/0x1f60 kernel/locking/lockdep.c:5053
 lock_acquire+0x182/0x3c0 kernel/locking/lockdep.c:5666
 down_write_nested+0x9e/0x180 kernel/locking/rwsem.c:1662
 swap_inode_boot_loader fs/ext4/ioctl.c:426 [inline]
 __ext4_ioctl fs/ext4/ioctl.c:1417 [inline]
 ext4_ioctl+0x4129/0x5510 fs/ext4/ioctl.c:1607
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl+0xfb/0x170 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f30f208a5a9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f30f32ea168 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f30f21abf80 RCX: 00007f30f208a5a9
RDX: 0000000000000000 RSI: 0000000000006611 RDI: 0000000000000003
RBP: 00007f30f20e5580 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffd148b2c6f R14: 00007f30f32ea300 R15: 0000000000022000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
