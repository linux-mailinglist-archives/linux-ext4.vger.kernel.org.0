Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 950CC59ABBB
	for <lists+linux-ext4@lfdr.de>; Sat, 20 Aug 2022 08:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243758AbiHTGZ7 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 20 Aug 2022 02:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiHTGZ7 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 20 Aug 2022 02:25:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C14539F0FD;
        Fri, 19 Aug 2022 23:25:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 40C6060C41;
        Sat, 20 Aug 2022 06:25:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AD0DC433C1;
        Sat, 20 Aug 2022 06:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660976755;
        bh=9+ztVqpSbEOVwUvw4xOXCHoOncFZUnrxQsLaABqzYoo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g0pfiZfiseMHTmhBJ3uwKLat8/kKcO9+bbsa6I1/OhF2wweSD/TLgbvLZW0R0t1Wy
         LKJLbBbAn7NVZ3ZLGMWnLz8abBPoeyfIiQFHCkduBVLW0Y/z54dd9Iuuk/W/Jk5H2g
         L9qQD2e5aGnFEIMc7mAUrGtDFgXUyuVuZb2zr6kf0WFd1dA/tl5XIiCpnkxx6HDiIQ
         tG4RkmkVhRX/iGtUENqobHSCSKZa4PfhW9bk9A1MOt8fBWffqeQaVYHi29Kuhlendy
         aZw+stR6Jsg2GtaJSgs+kCPPUkvHPDaBWAfPTe6/JeAh/NVwhBLGsq6f/HVZ8Ovx5D
         +P9YSHkcBOkVw==
Date:   Fri, 19 Aug 2022 23:25:53 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Ye Bin <yebin10@huawei.com>
Cc:     syzbot <syzbot+9543479984ae9e576000@syzkaller.appspotmail.com>,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu, Jason Yan <yanaijie@huawei.com>
Subject: Re: [syzbot] possible deadlock in ext4_bmap
Message-ID: <YwB+cXMCS/uk61PR@sol.localdomain>
References: <000000000000967c2805e5b5d4ed@google.com>
 <cad2edc1-57dd-1d79-0f2f-966e6fb31d5b@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cad2edc1-57dd-1d79-0f2f-966e6fb31d5b@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Aug 12, 2022 at 10:46:16AM +0800, 'Jason Yan' via syzkaller-bugs wrote:
> The inode_lock(inode) in vfs_fileattr_set() is a regular file inode and
> inode_lock_shared(inode) in ext4_bmap() is a journal inode.
> 
> So this might be a false positive deadlock warning.
> 
> Thanks,
> Jason
> 
> On 2022/8/8 15:33, syzbot wrote:
> > Hello,
> > 
> > syzbot found the following issue on:
> > 
> > HEAD commit:    ca688bff68bc Add linux-next specific files for 20220808
> > git tree:       linux-next
> > console output: https://syzkaller.appspot.com/x/log.txt?x=177eb001080000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=4c20e006003cdecb
> > dashboard link: https://syzkaller.appspot.com/bug?extid=9543479984ae9e576000
> > compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> > 
> > Unfortunately, I don't have any reproducer for this issue yet.
> > 
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+9543479984ae9e576000@syzkaller.appspotmail.com
> > 
> > ======================================================
> > WARNING: possible circular locking dependency detected
> > 5.19.0-next-20220808-syzkaller #0 Not tainted
> > ------------------------------------------------------
> > syz-executor.3/15950 is trying to acquire lock:
> > ffff88801b348400 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: inode_lock_shared include/linux/fs.h:771 [inline]
> > ffff88801b348400 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: ext4_bmap+0x4e/0x460 fs/ext4/inode.c:3157
> > 
> > but task is already holding lock:
> > ffff88814bede3f8 (&journal->j_checkpoint_mutex){+.+.}-{3:3}, at: jbd2_journal_flush+0x487/0xc00 fs/jbd2/journal.c:2472
> > 
> > which lock already depends on the new lock.
> > 
> > 
> > the existing dependency chain (in reverse order) is:
> > 
> > -> #1 (&journal->j_checkpoint_mutex){+.+.}-{3:3}:
> >         __mutex_lock_common kernel/locking/mutex.c:603 [inline]
> >         mutex_lock_io_nested+0x13f/0x1190 kernel/locking/mutex.c:833
> >         __jbd2_log_wait_for_space+0x234/0x460 fs/jbd2/checkpoint.c:110
> >         add_transaction_credits+0xa2d/0xb70 fs/jbd2/transaction.c:298
> >         start_this_handle+0x3ae/0x14a0 fs/jbd2/transaction.c:422
> >         jbd2__journal_start+0x38c/0x910 fs/jbd2/transaction.c:520
> >         __ext4_journal_start_sb+0x3a3/0x490 fs/ext4/ext4_jbd2.c:105
> >         __ext4_journal_start fs/ext4/ext4_jbd2.h:326 [inline]
> >         ext4_dirty_inode+0x9d/0x110 fs/ext4/inode.c:5963
> >         __mark_inode_dirty+0x48b/0x1040 fs/fs-writeback.c:2381
> >         mark_inode_dirty include/linux/fs.h:2467 [inline]
> >         generic_write_end+0x350/0x440 fs/buffer.c:2199
> >         ext4_da_write_end+0x16e/0x9a0 fs/ext4/inode.c:3089
> >         generic_perform_write+0x306/0x560 mm/filemap.c:3749
> >         ext4_buffered_write_iter+0x15b/0x460 fs/ext4/file.c:270
> >         ext4_file_write_iter+0x44a/0x1660 fs/ext4/file.c:679
> >         call_write_iter include/linux/fs.h:2192 [inline]
> >         do_iter_readv_writev+0x20b/0x3b0 fs/read_write.c:729
> >         do_iter_write+0x182/0x700 fs/read_write.c:855
> >         vfs_iter_write+0x70/0xa0 fs/read_write.c:896
> >         iter_file_splice_write+0x741/0xc90 fs/splice.c:686
> >         do_splice_from fs/splice.c:764 [inline]
> >         direct_splice_actor+0x110/0x180 fs/splice.c:931
> >         splice_direct_to_actor+0x331/0x8a0 fs/splice.c:886
> >         do_splice_direct+0x1a7/0x270 fs/splice.c:974
> >         do_sendfile+0xb19/0x1270 fs/read_write.c:1249
> >         __do_sys_sendfile64 fs/read_write.c:1311 [inline]
> >         __se_sys_sendfile64 fs/read_write.c:1303 [inline]
> >         __x64_sys_sendfile64+0x149/0x210 fs/read_write.c:1303
> >         do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> >         do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
> >         entry_SYSCALL_64_after_hwframe+0x63/0xcd
> > 
> > -> #0 (&sb->s_type->i_mutex_key#8){++++}-{3:3}:
> >         check_prev_add kernel/locking/lockdep.c:3095 [inline]
> >         check_prevs_add kernel/locking/lockdep.c:3214 [inline]
> >         validate_chain kernel/locking/lockdep.c:3829 [inline]
> >         __lock_acquire+0x2a43/0x56d0 kernel/locking/lockdep.c:5053
> >         lock_acquire kernel/locking/lockdep.c:5666 [inline]
> >         lock_acquire+0x1ab/0x570 kernel/locking/lockdep.c:5631
> >         down_read+0x98/0x450 kernel/locking/rwsem.c:1499
> >         inode_lock_shared include/linux/fs.h:771 [inline]
> >         ext4_bmap+0x4e/0x460 fs/ext4/inode.c:3157
> >         bmap+0xaa/0x120 fs/inode.c:1799
> >         jbd2_journal_bmap+0xa8/0x180 fs/jbd2/journal.c:971
> >         __jbd2_journal_erase fs/jbd2/journal.c:1784 [inline]
> >         jbd2_journal_flush+0x84f/0xc00 fs/jbd2/journal.c:2490
> >         ext4_ioctl_checkpoint fs/ext4/ioctl.c:1082 [inline]
> >         __ext4_ioctl+0x28fd/0x4ab0 fs/ext4/ioctl.c:1586
> >         vfs_ioctl fs/ioctl.c:51 [inline]
> >         __do_sys_ioctl fs/ioctl.c:870 [inline]
> >         __se_sys_ioctl fs/ioctl.c:856 [inline]
> >         __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:856
> >         do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> >         do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
> >         entry_SYSCALL_64_after_hwframe+0x63/0xcd
> > 
> > other info that might help us debug this:
> > 
> >   Possible unsafe locking scenario:
> > 
> >         CPU0                    CPU1
> >         ----                    ----
> >    lock(&journal->j_checkpoint_mutex);
> >                                 lock(&sb->s_type->i_mutex_key#8);
> >                                 lock(&journal->j_checkpoint_mutex);
> >    lock(&sb->s_type->i_mutex_key#8);
> > 
> >   *** DEADLOCK ***
> > 
> > 2 locks held by syz-executor.3/15950:
> >   #0: ffff88814bede170 (&journal->j_barrier){+.+.}-{3:3}, at: jbd2_journal_lock_updates+0x15e/0x310 fs/jbd2/transaction.c:904
> >   #1: ffff88814bede3f8 (&journal->j_checkpoint_mutex){+.+.}-{3:3}, at: jbd2_journal_flush+0x487/0xc00 fs/jbd2/journal.c:2472
> > 
> > stack backtrace:
> > CPU: 1 PID: 15950 Comm: syz-executor.3 Not tainted 5.19.0-next-20220808-syzkaller #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
> > Call Trace:
> >   <TASK>
> >   __dump_stack lib/dump_stack.c:88 [inline]
> >   dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
> >   check_noncircular+0x25f/0x2e0 kernel/locking/lockdep.c:2175
> >   check_prev_add kernel/locking/lockdep.c:3095 [inline]
> >   check_prevs_add kernel/locking/lockdep.c:3214 [inline]
> >   validate_chain kernel/locking/lockdep.c:3829 [inline]
> >   __lock_acquire+0x2a43/0x56d0 kernel/locking/lockdep.c:5053
> >   lock_acquire kernel/locking/lockdep.c:5666 [inline]
> >   lock_acquire+0x1ab/0x570 kernel/locking/lockdep.c:5631
> >   down_read+0x98/0x450 kernel/locking/rwsem.c:1499
> >   inode_lock_shared include/linux/fs.h:771 [inline]
> >   ext4_bmap+0x4e/0x460 fs/ext4/inode.c:3157
> >   bmap+0xaa/0x120 fs/inode.c:1799
> >   jbd2_journal_bmap+0xa8/0x180 fs/jbd2/journal.c:971
> >   __jbd2_journal_erase fs/jbd2/journal.c:1784 [inline]
> >   jbd2_journal_flush+0x84f/0xc00 fs/jbd2/journal.c:2490
> >   ext4_ioctl_checkpoint fs/ext4/ioctl.c:1082 [inline]
> >   __ext4_ioctl+0x28fd/0x4ab0 fs/ext4/ioctl.c:1586
> >   vfs_ioctl fs/ioctl.c:51 [inline]
> >   __do_sys_ioctl fs/ioctl.c:870 [inline]
> >   __se_sys_ioctl fs/ioctl.c:856 [inline]
> >   __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:856
> >   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> >   do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
> >   entry_SYSCALL_64_after_hwframe+0x63/0xcd
> > RIP: 0033:0x7feb4e689279
> > Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> > RSP: 002b:00007feb4f798168 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> > RAX: ffffffffffffffda RBX: 00007feb4e79bf80 RCX: 00007feb4e689279
> > RDX: 0000000020000000 RSI: 000000004004662b RDI: 0000000000000005
> > RBP: 00007feb4e6e3189 R08: 0000000000000000 R09: 0000000000000000
> > R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> > R13: 00007ffc38bb538f R14: 00007feb4f798300 R15: 0000000000022000
> >   </TASK>
> > 
> > 

I got this report while running syzkaller too.  It's very annoying because
anyone running syzkaller will probably get this if the filesystem is ext4.

ext4_bmap() didn't use to take the inode lock.  It started in this very recent
commit:

commit 51ae846cff568c8c29921b1b28eb2dfbcd4ac12d
Author: Ye Bin <yebin10@huawei.com>
Date:   Fri Jun 17 09:39:35 2022 +0800

    ext4: fix warning in ext4_iomap_begin as race between bmap and write

Ye, any thoughts on what to do about this?

- Eric
