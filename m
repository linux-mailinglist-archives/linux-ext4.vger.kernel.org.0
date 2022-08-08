Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF9258C401
	for <lists+linux-ext4@lfdr.de>; Mon,  8 Aug 2022 09:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233965AbiHHHdZ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 8 Aug 2022 03:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235718AbiHHHdY (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 8 Aug 2022 03:33:24 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E25CE6323
        for <linux-ext4@vger.kernel.org>; Mon,  8 Aug 2022 00:33:22 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id c5-20020a5ea805000000b00684468c5005so3338005ioa.15
        for <linux-ext4@vger.kernel.org>; Mon, 08 Aug 2022 00:33:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc;
        bh=Ll8lnnKrxnKYgqNtsLbJ5AyFsT37/qiByMcezJF+Tp8=;
        b=gl6uaT1BGNW3YladF1yArrPsTsani5GS0KmygmVwPJqncAcA8L2HH3GWf6HtMXwegH
         3OguF3hFc4eyxbTmQdxqFYHuhXPpxUSguemKINhEB0FIdMV+n5fU334DOjVP0TqIXEUx
         qnE/iXGONcKTz8wHL4IB5ObwFYDfrbJo22fFWJ3U81BL+cMZhdETFkI24+auO/CO22N7
         4UZXRaXndYriuN5qwjsO8pzO4vbeXlC0+dVkS+BhWOenHpR1VXzh8IKLDvw4DxGyPOGF
         l6sLuBTinecmLkaDhOqftKPtBITFoIXX6VKAPjeL1WGb4vutzMiCWTRSOS7iE/dtT+rP
         efYA==
X-Gm-Message-State: ACgBeo1SAIG12ZOaWEwv4yvpYT6fFZML3E6vVbnr4Mr0zv2NPNxQyYwY
        8D4BTw/M2OPaoV5OUa62QRLVxAnqNMGNdjngDxPZU/s4Mfv1
X-Google-Smtp-Source: AA6agR7X7EF0brrvIfV6ih3crwSbgyrfOgS3AVWdmjC9l6xp95Z8Ej8L6Ug0C4bbX3GX0lzER6XVSk1PUKchtSLEIW0KdnGRNXZa
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:188c:b0:2e0:efaf:2d12 with SMTP id
 o12-20020a056e02188c00b002e0efaf2d12mr2156064ilu.103.1659944002208; Mon, 08
 Aug 2022 00:33:22 -0700 (PDT)
Date:   Mon, 08 Aug 2022 00:33:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000994fbe05e5b5d4d9@google.com>
Subject: [syzbot] possible deadlock in __jbd2_log_wait_for_space
From:   syzbot <syzbot+fa1bbda326271b8808c9@syzkaller.appspotmail.com>
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

Hello,

syzbot found the following issue on:

HEAD commit:    ca688bff68bc Add linux-next specific files for 20220808
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1376e68e080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4c20e006003cdecb
dashboard link: https://syzkaller.appspot.com/bug?extid=fa1bbda326271b8808c9
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+fa1bbda326271b8808c9@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
5.19.0-next-20220808-syzkaller #0 Not tainted
------------------------------------------------------
syz-executor.4/19227 is trying to acquire lock:
ffff8880272aa3f8 (&journal->j_checkpoint_mutex){+.+.}-{3:3}, at: __jbd2_log_wait_for_space+0x234/0x460 fs/jbd2/checkpoint.c:110

but task is already holding lock:
ffff888076d40e08 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: inode_lock include/linux/fs.h:761 [inline]
ffff888076d40e08 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: ext4_dio_write_iter fs/ext4/file.c:510 [inline]
ffff888076d40e08 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: ext4_file_write_iter+0xbea/0x1660 fs/ext4/file.c:677

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&sb->s_type->i_mutex_key#8){++++}-{3:3}:
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

-> #0 (&journal->j_checkpoint_mutex){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3095 [inline]
       check_prevs_add kernel/locking/lockdep.c:3214 [inline]
       validate_chain kernel/locking/lockdep.c:3829 [inline]
       __lock_acquire+0x2a43/0x56d0 kernel/locking/lockdep.c:5053
       lock_acquire kernel/locking/lockdep.c:5666 [inline]
       lock_acquire+0x1ab/0x570 kernel/locking/lockdep.c:5631
       __mutex_lock_common kernel/locking/mutex.c:603 [inline]
       mutex_lock_io_nested+0x13f/0x1190 kernel/locking/mutex.c:833
       __jbd2_log_wait_for_space+0x234/0x460 fs/jbd2/checkpoint.c:110
       add_transaction_credits+0xa2d/0xb70 fs/jbd2/transaction.c:298
       start_this_handle+0x3ae/0x14a0 fs/jbd2/transaction.c:422
       jbd2__journal_start+0x38c/0x910 fs/jbd2/transaction.c:520
       __ext4_journal_start_sb+0x3a3/0x490 fs/ext4/ext4_jbd2.c:105
       __ext4_journal_start fs/ext4/ext4_jbd2.h:326 [inline]
       ext4_handle_inode_extension+0x312/0x870 fs/ext4/file.c:325
       ext4_dio_write_iter fs/ext4/file.c:573 [inline]
       ext4_file_write_iter+0x12df/0x1660 fs/ext4/file.c:677
       call_write_iter include/linux/fs.h:2192 [inline]
       do_iter_readv_writev+0x20b/0x3b0 fs/read_write.c:729
       do_iter_write+0x182/0x700 fs/read_write.c:855
       vfs_iter_write+0x70/0xa0 fs/read_write.c:896
       iter_file_splice_write+0x741/0xc90 fs/splice.c:686
       do_splice_from fs/splice.c:764 [inline]
       direct_splice_actor+0x110/0x180 fs/splice.c:931
       splice_direct_to_actor+0x331/0x8a0 fs/splice.c:886
       do_splice_direct+0x1a7/0x270 fs/splice.c:974
       do_sendfile+0xb19/0x1270 fs/read_write.c:1249
       __do_sys_sendfile64 fs/read_write.c:1317 [inline]
       __se_sys_sendfile64 fs/read_write.c:1303 [inline]
       __x64_sys_sendfile64+0x1cc/0x210 fs/read_write.c:1303
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&sb->s_type->i_mutex_key#8);
                               lock(&journal->j_checkpoint_mutex);
                               lock(&sb->s_type->i_mutex_key#8);
  lock(&journal->j_checkpoint_mutex);

 *** DEADLOCK ***

2 locks held by syz-executor.4/19227:
 #0: ffff88801c596460 (sb_writers#4){.+.+}-{0:0}, at: __do_sys_sendfile64 fs/read_write.c:1317 [inline]
 #0: ffff88801c596460 (sb_writers#4){.+.+}-{0:0}, at: __se_sys_sendfile64 fs/read_write.c:1303 [inline]
 #0: ffff88801c596460 (sb_writers#4){.+.+}-{0:0}, at: __x64_sys_sendfile64+0x1cc/0x210 fs/read_write.c:1303
 #1: ffff888076d40e08 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: inode_lock include/linux/fs.h:761 [inline]
 #1: ffff888076d40e08 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: ext4_dio_write_iter fs/ext4/file.c:510 [inline]
 #1: ffff888076d40e08 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: ext4_file_write_iter+0xbea/0x1660 fs/ext4/file.c:677

stack backtrace:
CPU: 1 PID: 19227 Comm: syz-executor.4 Not tainted 5.19.0-next-20220808-syzkaller #0
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
 mutex_lock_io_nested+0x13f/0x1190 kernel/locking/mutex.c:833
 __jbd2_log_wait_for_space+0x234/0x460 fs/jbd2/checkpoint.c:110
 add_transaction_credits+0xa2d/0xb70 fs/jbd2/transaction.c:298
 start_this_handle+0x3ae/0x14a0 fs/jbd2/transaction.c:422
 jbd2__journal_start+0x38c/0x910 fs/jbd2/transaction.c:520
 __ext4_journal_start_sb+0x3a3/0x490 fs/ext4/ext4_jbd2.c:105
 __ext4_journal_start fs/ext4/ext4_jbd2.h:326 [inline]
 ext4_handle_inode_extension+0x312/0x870 fs/ext4/file.c:325
 ext4_dio_write_iter fs/ext4/file.c:573 [inline]
 ext4_file_write_iter+0x12df/0x1660 fs/ext4/file.c:677
 call_write_iter include/linux/fs.h:2192 [inline]
 do_iter_readv_writev+0x20b/0x3b0 fs/read_write.c:729
 do_iter_write+0x182/0x700 fs/read_write.c:855
 vfs_iter_write+0x70/0xa0 fs/read_write.c:896
 iter_file_splice_write+0x741/0xc90 fs/splice.c:686
 do_splice_from fs/splice.c:764 [inline]
 direct_splice_actor+0x110/0x180 fs/splice.c:931
 splice_direct_to_actor+0x331/0x8a0 fs/splice.c:886
 do_splice_direct+0x1a7/0x270 fs/splice.c:974
 do_sendfile+0xb19/0x1270 fs/read_write.c:1249
 __do_sys_sendfile64 fs/read_write.c:1317 [inline]
 __se_sys_sendfile64 fs/read_write.c:1303 [inline]
 __x64_sys_sendfile64+0x1cc/0x210 fs/read_write.c:1303
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f0ff2c89279
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f0ff3d23168 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 00007f0ff2d9bf80 RCX: 00007f0ff2c89279
RDX: 0000000000000000 RSI: 0000000000000005 RDI: 0000000000000004
RBP: 00007f0ff2ce3189 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000f03b2900 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffcbe563eef R14: 00007f0ff3d23300 R15: 0000000000022000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
