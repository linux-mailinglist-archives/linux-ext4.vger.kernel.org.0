Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2B6258CC34
	for <lists+linux-ext4@lfdr.de>; Mon,  8 Aug 2022 18:38:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244057AbiHHQi3 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 8 Aug 2022 12:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244059AbiHHQi2 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 8 Aug 2022 12:38:28 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D43C91057B
        for <linux-ext4@vger.kernel.org>; Mon,  8 Aug 2022 09:38:26 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id x7-20020a056e021ca700b002ded2e6331aso6995663ill.20
        for <linux-ext4@vger.kernel.org>; Mon, 08 Aug 2022 09:38:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc;
        bh=Ic0PYKwPYNTqopm+2uIfT+XDEbx77UxnXZX9s1PZ3rw=;
        b=IZgocxrrJxBw1r4Q/H3NB1zxIQLjwlxJyzS+azXlAHjF3r60cyaOCWRFUEjSseF5Af
         Ioc4PJTQTf3RcgH2FgCiSiGtUNNhADyzaSKndfXCSBw7hgxR8bG6Iwyh1lTDebZXnxCj
         3MIDJEaI/JI1e1ZxUesUl8R93ZrDuTzBF11avqsykaIOx16JVqNK8cQZNRpwa/GFUuiT
         g45oP7p9mUYmOc+vb5ERYky5JiEUEJDtgU2fJaCyI77c5WreP0BJfBmAV/9jdYzaHcAN
         gOZpJGBxT986FEBExl+4EA7qWxcYCi3OR6csMd37+m+OEJHPcYM1NxD8nsDlfvjqyeTT
         mxeQ==
X-Gm-Message-State: ACgBeo1+7VUlocg1PpgFh0ZoiVaMYtJzkXD0ZMrP1bPM/TZCJIZ0SoR9
        F0ZPDjsZUK2IQVWG8Rz9A7hZeazozMbOixlGlkKU9RaAt6yO
X-Google-Smtp-Source: AA6agR5XsuETGznn10ieK9tmSrcUebqeBji7SiiEBzPifpSLxu7x7m6M53jmgfhQCmyp7LLXTlUJy/AZ1aUePWknVswB5h61xHIw
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1387:b0:342:d852:599e with SMTP id
 w7-20020a056638138700b00342d852599emr5103844jad.281.1659976706223; Mon, 08
 Aug 2022 09:38:26 -0700 (PDT)
Date:   Mon, 08 Aug 2022 09:38:26 -0700
In-Reply-To: <000000000000892a3005e5b5d96c@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e8f52205e5bd716f@google.com>
Subject: Re: [syzbot] possible deadlock in jbd2_journal_lock_updates
From:   syzbot <syzbot+79e6bbabf3ce17357969@syzkaller.appspotmail.com>
To:     jack@suse.com, linux-ext4@vger.kernel.org,
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
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1143ed46080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4c20e006003cdecb
dashboard link: https://syzkaller.appspot.com/bug?extid=79e6bbabf3ce17357969
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1783be71080000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12bcdbfa080000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+79e6bbabf3ce17357969@syzkaller.appspotmail.com

warning: checkpointing journal with EXT4_IOC_CHECKPOINT_FLAG_ZEROOUT can be slow
======================================================
WARNING: possible circular locking dependency detected
5.19.0-next-20220808-syzkaller #0 Not tainted
------------------------------------------------------
syz-executor677/3614 is trying to acquire lock:
ffff88814b8a4170 (&journal->j_barrier){+.+.}-{3:3}, at: jbd2_journal_lock_updates+0x15e/0x310 fs/jbd2/transaction.c:904

but task is already holding lock:
ffff88814b8a2bd8 (&sbi->s_writepages_rwsem){++++}-{0:0}, at: ext4_change_inode_journal_flag+0x178/0x530 fs/ext4/inode.c:6013

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #4 (&sbi->s_writepages_rwsem){++++}-{0:0}:
       percpu_down_write+0x4d/0x440 kernel/locking/percpu-rwsem.c:221
       ext4_change_inode_journal_flag+0x178/0x530 fs/ext4/inode.c:6013
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

-> #3 (mapping.invalidate_lock){++++}-{3:3}:
       down_write+0x90/0x150 kernel/locking/rwsem.c:1552
       filemap_invalidate_lock include/linux/fs.h:806 [inline]
       ext4_setattr+0xd9e/0x2c50 fs/ext4/inode.c:5445
       notify_change+0xcd0/0x1440 fs/attr.c:418
       do_truncate+0x13c/0x200 fs/open.c:65
       do_sys_ftruncate+0x536/0x730 fs/open.c:193
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #2 (&sb->s_type->i_mutex_key#8){++++}-{3:3}:
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

-> #1 (&journal->j_checkpoint_mutex){+.+.}-{3:3}:
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

-> #0 (&journal->j_barrier){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3095 [inline]
       check_prevs_add kernel/locking/lockdep.c:3214 [inline]
       validate_chain kernel/locking/lockdep.c:3829 [inline]
       __lock_acquire+0x2a43/0x56d0 kernel/locking/lockdep.c:5053
       lock_acquire kernel/locking/lockdep.c:5666 [inline]
       lock_acquire+0x1ab/0x570 kernel/locking/lockdep.c:5631
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

other info that might help us debug this:

Chain exists of:
  &journal->j_barrier --> mapping.invalidate_lock --> &sbi->s_writepages_rwsem

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&sbi->s_writepages_rwsem);
                               lock(mapping.invalidate_lock);
                               lock(&sbi->s_writepages_rwsem);
  lock(&journal->j_barrier);

 *** DEADLOCK ***

4 locks held by syz-executor677/3614:
 #0: ffff88814b8a0460 (sb_writers#4){.+.+}-{0:0}, at: ioctl_setflags fs/ioctl.c:725 [inline]
 #0: ffff88814b8a0460 (sb_writers#4){.+.+}-{0:0}, at: do_vfs_ioctl+0xe27/0x15c0 fs/ioctl.c:839
 #1: ffff88807599c030 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: inode_lock include/linux/fs.h:761 [inline]
 #1: ffff88807599c030 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: vfs_fileattr_set+0x148/0xbe0 fs/ioctl.c:681
 #2: ffff88807599c1d0 (mapping.invalidate_lock){++++}-{3:3}, at: filemap_invalidate_lock include/linux/fs.h:806 [inline]
 #2: ffff88807599c1d0 (mapping.invalidate_lock){++++}-{3:3}, at: ext4_change_inode_journal_flag+0x11f/0x530 fs/ext4/inode.c:6005
 #3: ffff88814b8a2bd8 (&sbi->s_writepages_rwsem){++++}-{0:0}, at: ext4_change_inode_journal_flag+0x178/0x530 fs/ext4/inode.c:6013

stack backtrace:
CPU: 0 PID: 3614 Comm: syz-executor677 Not tainted 5.19.0-next-20220808-syzkaller #0
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
RIP: 0033:0x7fb9f377eb39
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 14 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fffd29d1e18 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fffd29d1e58 RCX: 00007fb9f377eb39
RDX: 0000000020000040 RSI: 0000000040086602 RDI: 0000000000000005
RBP: 0000000000000000 R08: 431bde82d7b634db R09: 431bde82d7b634db
R10: 431bde82d7b634db R11: 0000000000000246 R12: 00007fb9f3741e40
R13: 431bde82d7b634db R14: 00007fffd29d1e50 R15: 0000000000000000
 </TASK>

