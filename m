Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34857596A02
	for <lists+linux-ext4@lfdr.de>; Wed, 17 Aug 2022 09:04:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238638AbiHQHCc (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 17 Aug 2022 03:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238717AbiHQHC0 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 17 Aug 2022 03:02:26 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A169679EE3
        for <linux-ext4@vger.kernel.org>; Wed, 17 Aug 2022 00:02:22 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id h25-20020a056e021d9900b002e069b96119so8593994ila.14
        for <linux-ext4@vger.kernel.org>; Wed, 17 Aug 2022 00:02:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc;
        bh=AVy8zYCWjiIYaAwAGw4xq9fAnoGnbLuxa0nQhh+cRCs=;
        b=LSnD5PLYrOdtAN8v81L2kSNnfN03F+tQT3Q/jC8WKcGyNDcgYMxsGM1R8iWN0Xh0ja
         FYdSPMUaKxBVTKTzbyF0KEZx3t9YLSuhJXosTIgOng1+WKCblVH/EC8uHhnrhYWxXxTN
         1q/0nedL2g0IjGYFqPPF+tLfTrQDEsC4Kc8wPCZOyv9kLn5mMS9pznun5rCibC/3zkC+
         wZspjmAOX+scVzhDs7XERk+/6KV68ojBMO3EqCWU7KQyC0XY9hvD7Ji4WE/OJuLrP7rW
         z5vpDfWvYYYUhPvlvEmq4KVbc587HI6O0HVhQme/eyRAiEEkxuu4D7JBo6Q5fWoFqIyW
         g+Yg==
X-Gm-Message-State: ACgBeo085b2a4QLJzW83nN8UgXl7+LLe3xEx8kryLMd6wSRC926Pg0DS
        cNN0imyQm+ttsxJlMw21LUjAqYaTUwT5Tab//2Nbc8AUpNEE
X-Google-Smtp-Source: AA6agR6rN7dhNVaxttfrEsOm5NHuRq2p14qzf5syX0piTZG3OQJsWMw/voN29CUtiLfIvSTED5mjAUWS+WLDv+bhtyGbp7TgauI7
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c8b:b0:2de:ec44:e139 with SMTP id
 w11-20020a056e021c8b00b002deec44e139mr10522256ill.215.1660719742003; Wed, 17
 Aug 2022 00:02:22 -0700 (PDT)
Date:   Wed, 17 Aug 2022 00:02:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004b320405e66a72cf@google.com>
Subject: [syzbot] possible deadlock in ext4_writepages
From:   syzbot <syzbot+c8139688c30ecca75857@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    7ebfc85e2cd7 Merge tag 'net-6.0-rc1' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16fdc2f3080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=20bc0b329895d963
dashboard link: https://syzkaller.appspot.com/bug?extid=c8139688c30ecca75857
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c8139688c30ecca75857@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
5.19.0-syzkaller-13930-g7ebfc85e2cd7 #0 Not tainted
------------------------------------------------------
syz-executor.1/6130 is trying to acquire lock:
ffff88814b25cbd8 (&sbi->s_writepages_rwsem){.+.+}-{0:0}, at: ext4_writepages+0x1e7/0x3be0 fs/ext4/inode.c:2687

but task is already holding lock:
ffff88803dd0ca38 (&sb->s_type->i_mutex_key#7){++++}-{3:3}, at: inode_lock_shared include/linux/fs.h:771 [inline]
ffff88803dd0ca38 (&sb->s_type->i_mutex_key#7){++++}-{3:3}, at: ext4_dio_read_iter fs/ext4/file.c:63 [inline]
ffff88803dd0ca38 (&sb->s_type->i_mutex_key#7){++++}-{3:3}, at: ext4_file_read_iter+0x26b/0x740 fs/ext4/file.c:130

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (&sb->s_type->i_mutex_key#7){++++}-{3:3}:
       lock_acquire+0x1a7/0x400 kernel/locking/lockdep.c:5666
       down_read+0x39/0x50 kernel/locking/rwsem.c:1499
       inode_lock_shared include/linux/fs.h:771 [inline]
       ext4_bmap+0x55/0x410 fs/ext4/inode.c:3157
       bmap+0xa1/0xd0 fs/inode.c:1799
       jbd2_journal_bmap fs/jbd2/journal.c:971 [inline]
       __jbd2_journal_erase fs/jbd2/journal.c:1784 [inline]
       jbd2_journal_flush+0x5d0/0xca0 fs/jbd2/journal.c:2490
       ext4_ioctl_checkpoint fs/ext4/ioctl.c:1082 [inline]
       __ext4_ioctl fs/ext4/ioctl.c:1586 [inline]
       ext4_ioctl+0x378a/0x55c0 fs/ext4/ioctl.c:1606
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:870 [inline]
       __se_sys_ioctl+0xfb/0x170 fs/ioctl.c:856
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x2b/0x70 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #1 (&journal->j_checkpoint_mutex){+.+.}-{3:3}:
       lock_acquire+0x1a7/0x400 kernel/locking/lockdep.c:5666
       __mutex_lock_common+0x1de/0x26c0 kernel/locking/mutex.c:603
       mutex_lock_io_nested+0x43/0x60 kernel/locking/mutex.c:833
       __jbd2_log_wait_for_space+0x22d/0x790 fs/jbd2/checkpoint.c:110
       add_transaction_credits+0x936/0xbf0 fs/jbd2/transaction.c:298
       start_this_handle+0x758/0x1660 fs/jbd2/transaction.c:422
       jbd2__journal_start+0x2ca/0x5b0 fs/jbd2/transaction.c:520
       __ext4_journal_start_sb+0x111/0x1d0 fs/ext4/ext4_jbd2.c:105
       __ext4_journal_start fs/ext4/ext4_jbd2.h:326 [inline]
       ext4_writepages+0x1181/0x3be0 fs/ext4/inode.c:2810
       do_writepages+0x3c3/0x690 mm/page-writeback.c:2468
       filemap_fdatawrite_wbc+0x11e/0x170 mm/filemap.c:388
       __filemap_fdatawrite_range mm/filemap.c:421 [inline]
       file_write_and_wait_range+0x1e7/0x2f0 mm/filemap.c:773
       ext4_sync_file+0x1b0/0x850 fs/ext4/fsync.c:151
       generic_write_sync include/linux/fs.h:2874 [inline]
       ext4_buffered_write_iter+0x308/0x3a0 fs/ext4/file.c:277
       ext4_file_write_iter+0xabb/0x1ae0
       do_iter_write+0x6f0/0xc50 fs/read_write.c:855
       iter_file_splice_write+0x830/0xff0 fs/splice.c:686
       do_splice_from fs/splice.c:764 [inline]
       direct_splice_actor+0xe6/0x1c0 fs/splice.c:931
       splice_direct_to_actor+0x4e4/0xc00 fs/splice.c:886
       do_splice_direct+0x2a0/0x3f0 fs/splice.c:974
       do_sendfile+0x641/0xfd0 fs/read_write.c:1249
       __do_sys_sendfile64 fs/read_write.c:1311 [inline]
       __se_sys_sendfile64+0xfc/0x1e0 fs/read_write.c:1303
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x2b/0x70 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #0 (&sbi->s_writepages_rwsem){.+.+}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3095 [inline]
       check_prevs_add kernel/locking/lockdep.c:3214 [inline]
       validate_chain+0x1872/0x6600 kernel/locking/lockdep.c:3829
       __lock_acquire+0x1292/0x1f60 kernel/locking/lockdep.c:5053
       lock_acquire+0x1a7/0x400 kernel/locking/lockdep.c:5666
       percpu_down_read+0x44/0x190 include/linux/percpu-rwsem.h:51
       ext4_writepages+0x1e7/0x3be0 fs/ext4/inode.c:2687
       do_writepages+0x3c3/0x690 mm/page-writeback.c:2468
       filemap_fdatawrite_wbc+0x11e/0x170 mm/filemap.c:388
       __filemap_fdatawrite_range mm/filemap.c:421 [inline]
       filemap_write_and_wait_range+0x1c1/0x2c0 mm/filemap.c:673
       __iomap_dio_rw+0xb25/0x20e0 fs/iomap/direct-io.c:573
       iomap_dio_rw+0x42/0xa0 fs/iomap/direct-io.c:690
       ext4_dio_read_iter fs/ext4/file.c:79 [inline]
       ext4_file_read_iter+0x595/0x740 fs/ext4/file.c:130
       call_read_iter include/linux/fs.h:2186 [inline]
       generic_file_splice_read+0x24e/0x650 fs/splice.c:309
       do_splice_to fs/splice.c:793 [inline]
       splice_direct_to_actor+0x41b/0xc00 fs/splice.c:865
       do_splice_direct+0x2a0/0x3f0 fs/splice.c:974
       do_sendfile+0x641/0xfd0 fs/read_write.c:1249
       __do_sys_sendfile64 fs/read_write.c:1317 [inline]
       __se_sys_sendfile64+0x178/0x1e0 fs/read_write.c:1303
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x2b/0x70 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

other info that might help us debug this:

Chain exists of:
  &sbi->s_writepages_rwsem --> &journal->j_checkpoint_mutex --> &sb->s_type->i_mutex_key#7

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&sb->s_type->i_mutex_key#7);
                               lock(&journal->j_checkpoint_mutex);
                               lock(&sb->s_type->i_mutex_key#7);
  lock(&sbi->s_writepages_rwsem);

 *** DEADLOCK ***

2 locks held by syz-executor.1/6130:
 #0: ffff88814b25a460 (sb_writers#4){.+.+}-{0:0}, at: do_sendfile+0x61c/0xfd0 fs/read_write.c:1248
 #1: ffff88803dd0ca38 (&sb->s_type->i_mutex_key#7){++++}-{3:3}, at: inode_lock_shared include/linux/fs.h:771 [inline]
 #1: ffff88803dd0ca38 (&sb->s_type->i_mutex_key#7){++++}-{3:3}, at: ext4_dio_read_iter fs/ext4/file.c:63 [inline]
 #1: ffff88803dd0ca38 (&sb->s_type->i_mutex_key#7){++++}-{3:3}, at: ext4_file_read_iter+0x26b/0x740 fs/ext4/file.c:130

stack backtrace:
CPU: 1 PID: 6130 Comm: syz-executor.1 Not tainted 5.19.0-syzkaller-13930-g7ebfc85e2cd7 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e3/0x2cb lib/dump_stack.c:106
 check_noncircular+0x2f9/0x3b0 kernel/locking/lockdep.c:2175
 check_prev_add kernel/locking/lockdep.c:3095 [inline]
 check_prevs_add kernel/locking/lockdep.c:3214 [inline]
 validate_chain+0x1872/0x6600 kernel/locking/lockdep.c:3829
 __lock_acquire+0x1292/0x1f60 kernel/locking/lockdep.c:5053
 lock_acquire+0x1a7/0x400 kernel/locking/lockdep.c:5666
 percpu_down_read+0x44/0x190 include/linux/percpu-rwsem.h:51
 ext4_writepages+0x1e7/0x3be0 fs/ext4/inode.c:2687
 do_writepages+0x3c3/0x690 mm/page-writeback.c:2468
 filemap_fdatawrite_wbc+0x11e/0x170 mm/filemap.c:388
 __filemap_fdatawrite_range mm/filemap.c:421 [inline]
 filemap_write_and_wait_range+0x1c1/0x2c0 mm/filemap.c:673
 __iomap_dio_rw+0xb25/0x20e0 fs/iomap/direct-io.c:573
 iomap_dio_rw+0x42/0xa0 fs/iomap/direct-io.c:690
 ext4_dio_read_iter fs/ext4/file.c:79 [inline]
 ext4_file_read_iter+0x595/0x740 fs/ext4/file.c:130
 call_read_iter include/linux/fs.h:2186 [inline]
 generic_file_splice_read+0x24e/0x650 fs/splice.c:309
 do_splice_to fs/splice.c:793 [inline]
 splice_direct_to_actor+0x41b/0xc00 fs/splice.c:865
 do_splice_direct+0x2a0/0x3f0 fs/splice.c:974
 do_sendfile+0x641/0xfd0 fs/read_write.c:1249
 __do_sys_sendfile64 fs/read_write.c:1317 [inline]
 __se_sys_sendfile64+0x178/0x1e0 fs/read_write.c:1303
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x2b/0x70 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fce42889279
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fce4395e168 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 00007fce4299c1f0 RCX: 00007fce42889279
RDX: 0000000000000000 RSI: 0000000000000008 RDI: 0000000000000003
RBP: 00007fce428e3189 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000010000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fffdba263bf R14: 00007fce4395e300 R15: 0000000000022000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
