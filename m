Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6D9758CE37
	for <lists+linux-ext4@lfdr.de>; Mon,  8 Aug 2022 21:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236918AbiHHTC1 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 8 Aug 2022 15:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243020AbiHHTC0 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 8 Aug 2022 15:02:26 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6165625ED
        for <linux-ext4@vger.kernel.org>; Mon,  8 Aug 2022 12:02:25 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id q10-20020a056e020c2a00b002dedb497c7fso7158118ilg.16
        for <linux-ext4@vger.kernel.org>; Mon, 08 Aug 2022 12:02:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc;
        bh=oqHBrmrLNW6FZP8ISoYP3AxTA4Ryzm/sJ9jkdQe8RTU=;
        b=GeiPgj+mpMcjNu3irScASOH9k+FeY2ED5MnmLkzDtXMKn5ID7STWHhUKE4az4GfWBf
         NFfHpXbzzDeJHLPMhwh6Szu5E0+0h1+uZCxmbYWUq5W89Jd7VAP7MmODF1PIe58WIo2e
         umPavDqQrd8QCFONfvaSuuBNe11Kq54Q3QbDO5Jo1d9EB2IclFQJpG7i2KrTqqmh8JUa
         gO7wljSfOxv4qWFfsiThhDHw2bn817gqaXMZVx9Sp2yWTLlxIe0EGgIMGu+ysB61quwI
         W4JKYOXoZIWgu/V2nZzygN4G1zTTNqcIdCt6y4N4rAl0c40r2rkriZP05PgU4BY4aNux
         TnZg==
X-Gm-Message-State: ACgBeo00wG96O/5pJf1/UJY073IPKAyf19cVhp6m90WzZOOeiFlnwqth
        mC4fWvhpMwCV+H9D6sqB/P7qyMc9Jt10bo6bwZ7z8KhF/bfo
X-Google-Smtp-Source: AA6agR5VJlgI3qd+dEJIqKRSAe7g44LGSjPfPd/gaaXgV7AcAs4sqk9rm2CG47ksITW/ApcE++YflljvWUHCrs4pcNqLGKk95ML6
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a29:b0:2e0:ea6d:f1d6 with SMTP id
 g9-20020a056e021a2900b002e0ea6df1d6mr3516943ile.108.1659985344772; Mon, 08
 Aug 2022 12:02:24 -0700 (PDT)
Date:   Mon, 08 Aug 2022 12:02:24 -0700
In-Reply-To: <000000000000967c2805e5b5d4ed@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cec16b05e5bf7409@google.com>
Subject: Re: [syzbot] possible deadlock in ext4_bmap
From:   syzbot <syzbot+9543479984ae9e576000@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    ca688bff68bc Add linux-next specific files for 20220808
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=15a71e71080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4c20e006003cdecb
dashboard link: https://syzkaller.appspot.com/bug?extid=9543479984ae9e576000
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1551c53e080000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14fcdbfa080000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9543479984ae9e576000@syzkaller.appspotmail.com

warning: checkpointing journal with EXT4_IOC_CHECKPOINT_FLAG_ZEROOUT can be slow
======================================================
WARNING: possible circular locking dependency detected
5.19.0-next-20220808-syzkaller #0 Not tainted
------------------------------------------------------
syz-executor725/3607 is trying to acquire lock:
ffff888144c48400 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: inode_lock_shared include/linux/fs.h:771 [inline]
ffff888144c48400 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: ext4_bmap+0x4e/0x460 fs/ext4/inode.c:3157

but task is already holding lock:
ffff88807ec503f8 (&journal->j_checkpoint_mutex){+.+.}-{3:3}, at: jbd2_journal_flush+0x487/0xc00 fs/jbd2/journal.c:2472

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (&journal->j_checkpoint_mutex){+.+.}-{3:3}:
       __mutex_lock_common kernel/locking/mutex.c:603 [inline]
       mutex_lock_io_nested+0x13f/0x1190 kernel/locking/mutex.c:833
       jbd2_journal_flush+0x19a/0xc00 fs/jbd2/journal.c:2462
       ext4_ioctl_checkpoint fs/ext4/ioctl.c:1082 [inline]
       __ext4_ioctl+0x28fd/0x4ab0 fs/ext4/ioctl.c:1586
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:870 [inline]
       __se_sys_ioctl fs/ioctl.c:856 [inline]
       __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:856
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #2 (&journal->j_barrier){+.+.}-{3:3}:
       __mutex_lock_common kernel/locking/mutex.c:603 [inline]
       __mutex_lock+0x12f/0x1350 kernel/locking/mutex.c:747
       jbd2_journal_lock_updates+0x15e/0x310 fs/jbd2/transaction.c:904
       ext4_change_inode_journal_flag+0x180/0x530 fs/ext4/inode.c:6014
       ext4_ioctl_setflags fs/ext4/ioctl.c:685 [inline]
       ext4_fileattr_set+0xddf/0x1930 fs/ext4/ioctl.c:1001
       vfs_fileattr_set+0x7f5/0xbe0 fs/ioctl.c:696
       ioctl_fssetxattr fs/ioctl.c:758 [inline]
       do_vfs_ioctl+0xe62/0x15c0 fs/ioctl.c:845
       __do_sys_ioctl fs/ioctl.c:868 [inline]
       __se_sys_ioctl fs/ioctl.c:856 [inline]
       __x64_sys_ioctl+0x108/0x200 fs/ioctl.c:856
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #1 (&sbi->s_writepages_rwsem){++++}-{0:0}:
       percpu_down_write+0x4d/0x440 kernel/locking/percpu-rwsem.c:221
       ext4_ind_migrate+0x237/0x840 fs/ext4/migrate.c:624
       ext4_ioctl_setflags fs/ext4/ioctl.c:694 [inline]
       ext4_fileattr_set+0x14b8/0x1930 fs/ext4/ioctl.c:1001
       vfs_fileattr_set+0x7f5/0xbe0 fs/ioctl.c:696
       ioctl_fssetxattr fs/ioctl.c:758 [inline]
       do_vfs_ioctl+0xe62/0x15c0 fs/ioctl.c:845
       __do_sys_ioctl fs/ioctl.c:868 [inline]
       __se_sys_ioctl fs/ioctl.c:856 [inline]
       __x64_sys_ioctl+0x108/0x200 fs/ioctl.c:856
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #0 (&sb->s_type->i_mutex_key#8){++++}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3095 [inline]
       check_prevs_add kernel/locking/lockdep.c:3214 [inline]
       validate_chain kernel/locking/lockdep.c:3829 [inline]
       __lock_acquire+0x2a43/0x56d0 kernel/locking/lockdep.c:5053
       lock_acquire kernel/locking/lockdep.c:5666 [inline]
       lock_acquire+0x1ab/0x570 kernel/locking/lockdep.c:5631
       down_read+0x98/0x450 kernel/locking/rwsem.c:1499
       inode_lock_shared include/linux/fs.h:771 [inline]
       ext4_bmap+0x4e/0x460 fs/ext4/inode.c:3157
       bmap+0xaa/0x120 fs/inode.c:1799
       jbd2_journal_bmap+0xa8/0x180 fs/jbd2/journal.c:971
       __jbd2_journal_erase fs/jbd2/journal.c:1784 [inline]
       jbd2_journal_flush+0x84f/0xc00 fs/jbd2/journal.c:2490
       ext4_ioctl_checkpoint fs/ext4/ioctl.c:1082 [inline]
       __ext4_ioctl+0x28fd/0x4ab0 fs/ext4/ioctl.c:1586
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:870 [inline]
       __se_sys_ioctl fs/ioctl.c:856 [inline]
       __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:856
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

other info that might help us debug this:

Chain exists of:
  &sb->s_type->i_mutex_key#8 --> &journal->j_barrier --> &journal->j_checkpoint_mutex

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&journal->j_checkpoint_mutex);
                               lock(&journal->j_barrier);
                               lock(&journal->j_checkpoint_mutex);
  lock(&sb->s_type->i_mutex_key#8);

 *** DEADLOCK ***

2 locks held by syz-executor725/3607:
 #0: ffff88807ec50170 (&journal->j_barrier){+.+.}-{3:3}, at: jbd2_journal_lock_updates+0x15e/0x310 fs/jbd2/transaction.c:904
 #1: ffff88807ec503f8 (&journal->j_checkpoint_mutex){+.+.}-{3:3}, at: jbd2_journal_flush+0x487/0xc00 fs/jbd2/journal.c:2472

stack backtrace:
CPU: 1 PID: 3607 Comm: syz-executor725 Not tainted 5.19.0-next-20220808-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 check_noncircular+0x25f/0x2e0 kernel/locking/lockdep.c:2175
 check_prev_add kernel/locking/lockdep.c:3095 [inline]
 check_prevs_add kernel/locking/lockdep.c:3214 [inline]
 validate_chain kernel/locking/lockdep.c:3829 [inline]
 __lock_acquire+0x2a43/0x56d0 kernel/locking/lockdep.c:5053
 lock_acquire kernel/locking/lockdep.c:5666 [inline]
 lock_acquire+0x1ab/0x570 kernel/locking/lockdep.c:5631
 down_read+0x98/0x450 kernel/locking/rwsem.c:1499
 inode_lock_shared include/linux/fs.h:771 [inline]
 ext4_bmap+0x4e/0x460 fs/ext4/inode.c:3157
 bmap+0xaa/0x120 fs/inode.c:1799
 jbd2_journal_bmap+0xa8/0x180 fs/jbd2/journal.c:971
 __jbd2_journal_erase fs/jbd2/journal.c:1784 [inline]
 jbd2_journal_flush+0x84f/0xc00 fs/jbd2/journal.c:2490
 ext4_ioctl_checkpoint fs/ext4/ioctl.c:1082 [inline]
 __ext4_ioctl+0x28fd/0x4ab0 fs/ext4/ioctl.c:1586
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl fs/ioctl.c:856 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fe2d1101d69
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 b1 14 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd7aba8f78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fe2d1101d69
RDX: 0000000020000000 RSI: 000000004004662b RDI: 0000000000000004
RBP: 0000000000000000 R08: 00007ffd7aba9118 R09: 00007ffd7aba9118
R10: 00007ffd7aba9118 R11: 0000000000000246 R12: 00007fe2d10c55f0
R13: 431bde82d7b634db R14: 0000000000000000 R15: 0000000000000000
 </TASK>

