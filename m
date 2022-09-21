Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBF8C5BFAD3
	for <lists+linux-ext4@lfdr.de>; Wed, 21 Sep 2022 11:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbiIUJZn (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 21 Sep 2022 05:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231485AbiIUJZl (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 21 Sep 2022 05:25:41 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7126B88DCC
        for <linux-ext4@vger.kernel.org>; Wed, 21 Sep 2022 02:25:39 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id r12-20020a92cd8c000000b002f32d0d9fceso3228653ilb.11
        for <linux-ext4@vger.kernel.org>; Wed, 21 Sep 2022 02:25:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=Sw8xGa+5rfhRKnCnMGpEZdGfRSKGhu1Hh3K8LTUkBrs=;
        b=fLalZZiTIbzS6b+mCW48E1S6kl59E5t1/5P9TaPuQYw4yRvCjWL9UdKt95OmIpZLc9
         ZchPzM7J0o9e5JsmbQFqtAgJvUAj+F8P9HJBwcaJQd0rpX1cfo6FGChCVanMqR8OFez6
         tJqC0MLcJ1Cdgzu/ONOfqcebblmMKG4to/LozwTEVjSwbYr9LFtJkA0EeVyEPOGUCWaY
         DJTRELSAiyGsy6nyNpUptDx/RyTaW4bi5g4lSz5ndb5kCEs5nSovNOAG7MJk8SiHheYs
         +3vXF9VUhFJlMTPAVLA97BYDo7gUGECfxZJX5NB+4ivy77ggn+enPkXDeFmZDXYHQ83C
         p2Tg==
X-Gm-Message-State: ACrzQf0r4bZGnR1qvtlVswT8tCnO9esvrf0mcQnwwsOJy8sAOPjxpWU6
        ICstEkF2mx04E1c+WbVAN18nMUDRRjs6m7xc7Ahld7wX2odz
X-Google-Smtp-Source: AMsMyM7a08PxXlHaBKs6V2J5eAo3zLh5P7rAgw+a+juScIT+UJAEgQ6D4ZQox3myH9vsj2Mtb971/75Y46f4Hpkq6FhVDlD6aCMg
MIME-Version: 1.0
X-Received: by 2002:a6b:e714:0:b0:6a1:35af:82dc with SMTP id
 b20-20020a6be714000000b006a135af82dcmr10499522ioh.205.1663752338792; Wed, 21
 Sep 2022 02:25:38 -0700 (PDT)
Date:   Wed, 21 Sep 2022 02:25:38 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000025e61105e92c8724@google.com>
Subject: [syzbot] possible deadlock in ext4_evict_inode (2)
From:   syzbot <syzbot+b6ad7e348919e233ee7f@syzkaller.appspotmail.com>
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

HEAD commit:    60891ec99e14 Merge tag 'for-6.0-rc6-tag' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16bd5654880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c221af36f6d1d811
dashboard link: https://syzkaller.appspot.com/bug?extid=b6ad7e348919e233ee7f
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/26088fcec75b/disk-60891ec9.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/71fa9bd9b624/vmlinux-60891ec9.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b6ad7e348919e233ee7f@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.0.0-rc6-syzkaller-00009-g60891ec99e14 #0 Not tainted
------------------------------------------------------
syz-executor.5/29299 is trying to acquire lock:
ffff88814afb8650 (sb_internal){.+.+}-{0:0}, at: __sb_start_write include/linux/fs.h:1826 [inline]
ffff88814afb8650 (sb_internal){.+.+}-{0:0}, at: sb_start_intwrite include/linux/fs.h:1948 [inline]
ffff88814afb8650 (sb_internal){.+.+}-{0:0}, at: ext4_evict_inode+0x4b7/0x1010 fs/ext4/inode.c:240

but task is already holding lock:
ffff88814afbabd8 (&sbi->s_writepages_rwsem){++++}-{0:0}, at: ext4_ext_migrate+0x212/0x1220 fs/ext4/migrate.c:437

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (&sbi->s_writepages_rwsem){++++}-{0:0}:
       lock_acquire+0x182/0x3c0 kernel/locking/lockdep.c:5666
       percpu_down_write+0x50/0x330 kernel/locking/percpu-rwsem.c:221
       ext4_ind_migrate+0x262/0x730 fs/ext4/migrate.c:624
       ext4_ioctl_setflags fs/ext4/ioctl.c:694 [inline]
       ext4_fileattr_set+0xe53/0x17d0 fs/ext4/ioctl.c:1001
       vfs_fileattr_set+0x8be/0xd20 fs/ioctl.c:696
       ioctl_setflags fs/ioctl.c:728 [inline]
       do_vfs_ioctl+0x1d26/0x29a0 fs/ioctl.c:839
       __do_sys_ioctl fs/ioctl.c:868 [inline]
       __se_sys_ioctl+0x83/0x170 fs/ioctl.c:856
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #2 (&sb->s_type->i_mutex_key#8){++++}-{3:3}:
       lock_acquire+0x182/0x3c0 kernel/locking/lockdep.c:5666
       down_read+0x39/0x50 kernel/locking/rwsem.c:1499
       inode_lock_shared include/linux/fs.h:766 [inline]
       ext4_bmap+0x55/0x410 fs/ext4/inode.c:3157
       bmap+0xa1/0xd0 fs/inode.c:1799
       jbd2_journal_bmap fs/jbd2/journal.c:971 [inline]
       __jbd2_journal_erase fs/jbd2/journal.c:1784 [inline]
       jbd2_journal_flush+0x5d0/0xca0 fs/jbd2/journal.c:2490
       ext4_ioctl_checkpoint fs/ext4/ioctl.c:1082 [inline]
       __ext4_ioctl fs/ext4/ioctl.c:1586 [inline]
       ext4_ioctl+0x31ad/0x5410 fs/ext4/ioctl.c:1606
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:870 [inline]
       __se_sys_ioctl+0xfb/0x170 fs/ioctl.c:856
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #1 (&journal->j_checkpoint_mutex){+.+.}-{3:3}:
       lock_acquire+0x182/0x3c0 kernel/locking/lockdep.c:5666
       __mutex_lock_common+0x1bd/0x26e0 kernel/locking/mutex.c:603
       mutex_lock_io_nested+0x43/0x60 kernel/locking/mutex.c:833
       __jbd2_log_wait_for_space+0x21d/0x6f0 fs/jbd2/checkpoint.c:110
       add_transaction_credits+0x916/0xbd0 fs/jbd2/transaction.c:298
       start_this_handle+0x744/0x1670 fs/jbd2/transaction.c:422
       jbd2__journal_start+0x2ca/0x5b0 fs/jbd2/transaction.c:520
       __ext4_journal_start_sb+0x111/0x1d0 fs/ext4/ext4_jbd2.c:105
       __ext4_journal_start fs/ext4/ext4_jbd2.h:326 [inline]
       ext4_evict_inode+0x8e7/0x1010 fs/ext4/inode.c:251
       evict+0x2a4/0x620 fs/inode.c:665
       do_unlinkat+0x4f2/0x940 fs/namei.c:4304
       __do_sys_unlink fs/namei.c:4345 [inline]
       __se_sys_unlink fs/namei.c:4343 [inline]
       __x64_sys_unlink+0x45/0x50 fs/namei.c:4343
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #0 (sb_internal){.+.+}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3095 [inline]
       check_prevs_add kernel/locking/lockdep.c:3214 [inline]
       validate_chain+0x1873/0x6c00 kernel/locking/lockdep.c:3829
       __lock_acquire+0x1292/0x1f60 kernel/locking/lockdep.c:5053
       lock_acquire+0x182/0x3c0 kernel/locking/lockdep.c:5666
       percpu_down_read+0x44/0x190 include/linux/percpu-rwsem.h:51
       __sb_start_write include/linux/fs.h:1826 [inline]
       sb_start_intwrite include/linux/fs.h:1948 [inline]
       ext4_evict_inode+0x4b7/0x1010 fs/ext4/inode.c:240
       evict+0x2a4/0x620 fs/inode.c:665
       ext4_ext_migrate+0xf3a/0x1220 fs/ext4/migrate.c:587
       __ext4_ioctl fs/ext4/ioctl.c:1388 [inline]
       ext4_ioctl+0x1b95/0x5410 fs/ext4/ioctl.c:1606
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:870 [inline]
       __se_sys_ioctl+0xfb/0x170 fs/ioctl.c:856
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

other info that might help us debug this:

Chain exists of:
  sb_internal --> &sb->s_type->i_mutex_key#8 --> &sbi->s_writepages_rwsem

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&sbi->s_writepages_rwsem);
                               lock(&sb->s_type->i_mutex_key#8);
                               lock(&sbi->s_writepages_rwsem);
  lock(sb_internal);

 *** DEADLOCK ***

3 locks held by syz-executor.5/29299:
 #0: ffff88814afb8460 (sb_writers#4){.+.+}-{0:0}, at: mnt_want_write_file+0x5a/0x1f0 fs/namespace.c:437
 #1: ffff88804626ac20 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: inode_lock include/linux/fs.h:756 [inline]
 #1: ffff88804626ac20 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: __ext4_ioctl fs/ext4/ioctl.c:1387 [inline]
 #1: ffff88804626ac20 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: ext4_ioctl+0x1b8d/0x5410 fs/ext4/ioctl.c:1606
 #2: ffff88814afbabd8 (&sbi->s_writepages_rwsem){++++}-{0:0}, at: ext4_ext_migrate+0x212/0x1220 fs/ext4/migrate.c:437

stack backtrace:
CPU: 0 PID: 29299 Comm: syz-executor.5 Not tainted 6.0.0-rc6-syzkaller-00009-g60891ec99e14 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1b1/0x28e lib/dump_stack.c:106
 check_noncircular+0x2cc/0x390 kernel/locking/lockdep.c:2175
 check_prev_add kernel/locking/lockdep.c:3095 [inline]
 check_prevs_add kernel/locking/lockdep.c:3214 [inline]
 validate_chain+0x1873/0x6c00 kernel/locking/lockdep.c:3829
 __lock_acquire+0x1292/0x1f60 kernel/locking/lockdep.c:5053
 lock_acquire+0x182/0x3c0 kernel/locking/lockdep.c:5666
 percpu_down_read+0x44/0x190 include/linux/percpu-rwsem.h:51
 __sb_start_write include/linux/fs.h:1826 [inline]
 sb_start_intwrite include/linux/fs.h:1948 [inline]
 ext4_evict_inode+0x4b7/0x1010 fs/ext4/inode.c:240
 evict+0x2a4/0x620 fs/inode.c:665
 ext4_ext_migrate+0xf3a/0x1220 fs/ext4/migrate.c:587
 __ext4_ioctl fs/ext4/ioctl.c:1388 [inline]
 ext4_ioctl+0x1b95/0x5410 fs/ext4/ioctl.c:1606
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl+0xfb/0x170 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f0701689409
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f0702713168 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f070179c050 RCX: 00007f0701689409
RDX: 0000000000000000 RSI: 0000000000006609 RDI: 0000000000000003
RBP: 00007f07016e4367 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffc01036e8f R14: 00007f0702713300 R15: 0000000000022000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
