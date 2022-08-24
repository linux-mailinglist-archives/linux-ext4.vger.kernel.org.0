Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B22459F71C
	for <lists+linux-ext4@lfdr.de>; Wed, 24 Aug 2022 12:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235775AbiHXKHL (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 24 Aug 2022 06:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236529AbiHXKG6 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 24 Aug 2022 06:06:58 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B4ED80346;
        Wed, 24 Aug 2022 03:06:55 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C0F813410E;
        Wed, 24 Aug 2022 10:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1661335613; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mQdnWDksafcen/pWl8+CdCJb1hGVeKtGPSapNUlHeMc=;
        b=ZqBjl95wmiBpvbTOEtsoEkbEOUeCgrrIkxj0mHGXnMsZAtdz6VkCzyIx1n9gS7MBxPN29z
        LsiwQAbJvqFFbQHOYwd80ZpQBL6HafD/AszUbi6vm+iXaAbZimQSySKUiip9+X/s+eF2SJ
        6ksSU19XaiD1ZybgM4b+VUA834x1bbc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1661335613;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mQdnWDksafcen/pWl8+CdCJb1hGVeKtGPSapNUlHeMc=;
        b=PiurbHI9NQa47xF6X9O/2VJD5kt9j0RX6GR08S2nVYQaMcb1g5Z+z8F8IP4mXqsFcfj7yE
        D44OPp67qkXX5tBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id ABDE413AC0;
        Wed, 24 Aug 2022 10:06:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id rjQSKT34BWNwEgAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 24 Aug 2022 10:06:53 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 04391A0679; Wed, 24 Aug 2022 12:06:52 +0200 (CEST)
Date:   Wed, 24 Aug 2022 12:06:52 +0200
From:   Jan Kara <jack@suse.cz>
To:     syzbot <syzbot+79e6bbabf3ce17357969@syzkaller.appspotmail.com>
Cc:     jack@suse.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu, Ye Bin <yebin10@huawei.com>
Subject: Re: [syzbot] possible deadlock in jbd2_journal_lock_updates
Message-ID: <20220824100652.227m7eq4zqq7luir@quack3>
References: <000000000000892a3005e5b5d96c@google.com>
 <000000000000e8f52205e5bd716f@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000e8f52205e5bd716f@google.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SORTED_RECIPS,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon 08-08-22 09:38:26, syzbot wrote:
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    ca688bff68bc Add linux-next specific files for 20220808
> git tree:       linux-next
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=1143ed46080000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=4c20e006003cdecb
> dashboard link: https://syzkaller.appspot.com/bug?extid=79e6bbabf3ce17357969
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1783be71080000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12bcdbfa080000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+79e6bbabf3ce17357969@syzkaller.appspotmail.com
> 
> warning: checkpointing journal with EXT4_IOC_CHECKPOINT_FLAG_ZEROOUT can be slow
> ======================================================
> WARNING: possible circular locking dependency detected
> 5.19.0-next-20220808-syzkaller #0 Not tainted
> ------------------------------------------------------
> syz-executor677/3614 is trying to acquire lock:
> ffff88814b8a4170 (&journal->j_barrier){+.+.}-{3:3}, at: jbd2_journal_lock_updates+0x15e/0x310 fs/jbd2/transaction.c:904
> 
> but task is already holding lock:
> ffff88814b8a2bd8 (&sbi->s_writepages_rwsem){++++}-{0:0}, at: ext4_change_inode_journal_flag+0x178/0x530 fs/ext4/inode.c:6013

So this seems like a real issue. Essentially, the problem is that
ext4_bmap() acquires inode->i_rwsem while its caller jbd2_journal_flush()
is holding journal->j_checkpoint_mutex. This looks like a real deadlock
possibility. This lock inversion was introduced by commit 51ae846cff5
("ext4: fix warning in ext4_iomap_begin as race between bmap and write")
which was fixing up a race in inline data handling.

Thinking about it some more, it does not seem locking i_rwsem in
ext4_bmap() is really workable and as I've noted in one of my replies to
this patch [1] it is not a complete solution to the problem anyway. So I
would be for reverting 51ae846cff5 and thinking more about how we can make
inline data locking suck less...

[1] https://lore.kernel.org/all/20220615172609.oydxhjw7exas23hd@quack3.lan/

								Honza

> which lock already depends on the new lock.
> 
> 
> the existing dependency chain (in reverse order) is:
> 
> -> #4 (&sbi->s_writepages_rwsem){++++}-{0:0}:
>        percpu_down_write+0x4d/0x440 kernel/locking/percpu-rwsem.c:221
>        ext4_change_inode_journal_flag+0x178/0x530 fs/ext4/inode.c:6013
>        ext4_ioctl_setflags fs/ext4/ioctl.c:685 [inline]
>        ext4_fileattr_set+0xddf/0x1930 fs/ext4/ioctl.c:1001
>        vfs_fileattr_set+0x7f5/0xbe0 fs/ioctl.c:696
>        ioctl_fssetxattr fs/ioctl.c:758 [inline]
>        do_vfs_ioctl+0xe62/0x15c0 fs/ioctl.c:845
>        __do_sys_ioctl fs/ioctl.c:868 [inline]
>        __se_sys_ioctl fs/ioctl.c:856 [inline]
>        __x64_sys_ioctl+0x108/0x200 fs/ioctl.c:856
>        do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>        do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>        entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 
> -> #3 (mapping.invalidate_lock){++++}-{3:3}:
>        down_write+0x90/0x150 kernel/locking/rwsem.c:1552
>        filemap_invalidate_lock include/linux/fs.h:806 [inline]
>        ext4_setattr+0xd9e/0x2c50 fs/ext4/inode.c:5445
>        notify_change+0xcd0/0x1440 fs/attr.c:418
>        do_truncate+0x13c/0x200 fs/open.c:65
>        do_sys_ftruncate+0x536/0x730 fs/open.c:193
>        do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>        do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>        entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 
> -> #2 (&sb->s_type->i_mutex_key#8){++++}-{3:3}:
>        down_read+0x98/0x450 kernel/locking/rwsem.c:1499
>        inode_lock_shared include/linux/fs.h:771 [inline]
>        ext4_bmap+0x4e/0x460 fs/ext4/inode.c:3157
>        bmap+0xaa/0x120 fs/inode.c:1799
>        jbd2_journal_bmap+0xa8/0x180 fs/jbd2/journal.c:971
>        __jbd2_journal_erase fs/jbd2/journal.c:1784 [inline]
>        jbd2_journal_flush+0x84f/0xc00 fs/jbd2/journal.c:2490
>        ext4_ioctl_checkpoint fs/ext4/ioctl.c:1082 [inline]
>        __ext4_ioctl+0x28fd/0x4ab0 fs/ext4/ioctl.c:1586
>        vfs_ioctl fs/ioctl.c:51 [inline]
>        __do_sys_ioctl fs/ioctl.c:870 [inline]
>        __se_sys_ioctl fs/ioctl.c:856 [inline]
>        __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:856
>        do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>        do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>        entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 
> -> #1 (&journal->j_checkpoint_mutex){+.+.}-{3:3}:
>        __mutex_lock_common kernel/locking/mutex.c:603 [inline]
>        mutex_lock_io_nested+0x13f/0x1190 kernel/locking/mutex.c:833
>        jbd2_journal_flush+0x19a/0xc00 fs/jbd2/journal.c:2462
>        ext4_ioctl_checkpoint fs/ext4/ioctl.c:1082 [inline]
>        __ext4_ioctl+0x28fd/0x4ab0 fs/ext4/ioctl.c:1586
>        vfs_ioctl fs/ioctl.c:51 [inline]
>        __do_sys_ioctl fs/ioctl.c:870 [inline]
>        __se_sys_ioctl fs/ioctl.c:856 [inline]
>        __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:856
>        do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>        do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>        entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 
> -> #0 (&journal->j_barrier){+.+.}-{3:3}:
>        check_prev_add kernel/locking/lockdep.c:3095 [inline]
>        check_prevs_add kernel/locking/lockdep.c:3214 [inline]
>        validate_chain kernel/locking/lockdep.c:3829 [inline]
>        __lock_acquire+0x2a43/0x56d0 kernel/locking/lockdep.c:5053
>        lock_acquire kernel/locking/lockdep.c:5666 [inline]
>        lock_acquire+0x1ab/0x570 kernel/locking/lockdep.c:5631
>        __mutex_lock_common kernel/locking/mutex.c:603 [inline]
>        __mutex_lock+0x12f/0x1350 kernel/locking/mutex.c:747
>        jbd2_journal_lock_updates+0x15e/0x310 fs/jbd2/transaction.c:904
>        ext4_change_inode_journal_flag+0x180/0x530 fs/ext4/inode.c:6014
>        ext4_ioctl_setflags fs/ext4/ioctl.c:685 [inline]
>        ext4_fileattr_set+0xddf/0x1930 fs/ext4/ioctl.c:1001
>        vfs_fileattr_set+0x7f5/0xbe0 fs/ioctl.c:696
>        ioctl_fssetxattr fs/ioctl.c:758 [inline]
>        do_vfs_ioctl+0xe62/0x15c0 fs/ioctl.c:845
>        __do_sys_ioctl fs/ioctl.c:868 [inline]
>        __se_sys_ioctl fs/ioctl.c:856 [inline]
>        __x64_sys_ioctl+0x108/0x200 fs/ioctl.c:856
>        do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>        do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>        entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 
> other info that might help us debug this:
> 
> Chain exists of:
>   &journal->j_barrier --> mapping.invalidate_lock --> &sbi->s_writepages_rwsem
> 
>  Possible unsafe locking scenario:
> 
>        CPU0                    CPU1
>        ----                    ----
>   lock(&sbi->s_writepages_rwsem);
>                                lock(mapping.invalidate_lock);
>                                lock(&sbi->s_writepages_rwsem);
>   lock(&journal->j_barrier);
> 
>  *** DEADLOCK ***
> 
> 4 locks held by syz-executor677/3614:
>  #0: ffff88814b8a0460 (sb_writers#4){.+.+}-{0:0}, at: ioctl_setflags fs/ioctl.c:725 [inline]
>  #0: ffff88814b8a0460 (sb_writers#4){.+.+}-{0:0}, at: do_vfs_ioctl+0xe27/0x15c0 fs/ioctl.c:839
>  #1: ffff88807599c030 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: inode_lock include/linux/fs.h:761 [inline]
>  #1: ffff88807599c030 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: vfs_fileattr_set+0x148/0xbe0 fs/ioctl.c:681
>  #2: ffff88807599c1d0 (mapping.invalidate_lock){++++}-{3:3}, at: filemap_invalidate_lock include/linux/fs.h:806 [inline]
>  #2: ffff88807599c1d0 (mapping.invalidate_lock){++++}-{3:3}, at: ext4_change_inode_journal_flag+0x11f/0x530 fs/ext4/inode.c:6005
>  #3: ffff88814b8a2bd8 (&sbi->s_writepages_rwsem){++++}-{0:0}, at: ext4_change_inode_journal_flag+0x178/0x530 fs/ext4/inode.c:6013
> 
> stack backtrace:
> CPU: 0 PID: 3614 Comm: syz-executor677 Not tainted 5.19.0-next-20220808-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
>  check_noncircular+0x25f/0x2e0 kernel/locking/lockdep.c:2175
>  check_prev_add kernel/locking/lockdep.c:3095 [inline]
>  check_prevs_add kernel/locking/lockdep.c:3214 [inline]
>  validate_chain kernel/locking/lockdep.c:3829 [inline]
>  __lock_acquire+0x2a43/0x56d0 kernel/locking/lockdep.c:5053
>  lock_acquire kernel/locking/lockdep.c:5666 [inline]
>  lock_acquire+0x1ab/0x570 kernel/locking/lockdep.c:5631
>  __mutex_lock_common kernel/locking/mutex.c:603 [inline]
>  __mutex_lock+0x12f/0x1350 kernel/locking/mutex.c:747
>  jbd2_journal_lock_updates+0x15e/0x310 fs/jbd2/transaction.c:904
>  ext4_change_inode_journal_flag+0x180/0x530 fs/ext4/inode.c:6014
>  ext4_ioctl_setflags fs/ext4/ioctl.c:685 [inline]
>  ext4_fileattr_set+0xddf/0x1930 fs/ext4/ioctl.c:1001
>  vfs_fileattr_set+0x7f5/0xbe0 fs/ioctl.c:696
>  ioctl_fssetxattr fs/ioctl.c:758 [inline]
>  do_vfs_ioctl+0xe62/0x15c0 fs/ioctl.c:845
>  __do_sys_ioctl fs/ioctl.c:868 [inline]
>  __se_sys_ioctl fs/ioctl.c:856 [inline]
>  __x64_sys_ioctl+0x108/0x200 fs/ioctl.c:856
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> RIP: 0033:0x7fb9f377eb39
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 14 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007fffd29d1e18 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 00007fffd29d1e58 RCX: 00007fb9f377eb39
> RDX: 0000000020000040 RSI: 0000000040086602 RDI: 0000000000000005
> RBP: 0000000000000000 R08: 431bde82d7b634db R09: 431bde82d7b634db
> R10: 431bde82d7b634db R11: 0000000000000246 R12: 00007fb9f3741e40
> R13: 431bde82d7b634db R14: 00007fffd29d1e50 R15: 0000000000000000
>  </TASK>
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
