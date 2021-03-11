Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF68333759A
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Mar 2021 15:26:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233805AbhCKOZc (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 11 Mar 2021 09:25:32 -0500
Received: from mx2.suse.de ([195.135.220.15]:49540 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233254AbhCKOZG (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 11 Mar 2021 09:25:06 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A8368AC8C;
        Thu, 11 Mar 2021 14:25:04 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 3DFEA1F2BD9; Thu, 11 Mar 2021 15:25:03 +0100 (CET)
Date:   Thu, 11 Mar 2021 15:25:03 +0100
From:   Jan Kara <jack@suse.cz>
To:     syzbot <syzbot+30774a6acf6a2cf6d535@syzkaller.appspotmail.com>
Cc:     jack@suse.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu
Subject: Re: [syzbot] KCSAN: data-race in start_this_handle /
 start_this_handle
Message-ID: <20210311142503.GA31816@quack2.suse.cz>
References: <0000000000008de88005bd40ac36@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000008de88005bd40ac36@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu 11-03-21 02:59:14, syzbot wrote:
> HEAD commit:    a74e6a01 Merge tag 's390-5.12-3' of git://git.kernel.org/p..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=159f69ecd00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=de394bbaade74fb7
> dashboard link: https://syzkaller.appspot.com/bug?extid=30774a6acf6a2cf6d535
> compiler:       Debian clang version 11.0.1-2
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+30774a6acf6a2cf6d535@syzkaller.appspotmail.com
> 
> ==================================================================
> BUG: KCSAN: data-race in start_this_handle / start_this_handle
> 
> write to 0xffff888103880870 of 8 bytes by task 29956 on cpu 1:
>  jbd2_get_transaction fs/jbd2/transaction.c:125 [inline]
>  start_this_handle+0xceb/0x1010 fs/jbd2/transaction.c:400
>  jbd2__journal_start+0x1fc/0x3f0 fs/jbd2/transaction.c:503
>  __ext4_journal_start_sb+0x159/0x310 fs/ext4/ext4_jbd2.c:105
>  __ext4_journal_start fs/ext4/ext4_jbd2.h:320 [inline]
>  ext4_da_write_begin+0x460/0xaf0 fs/ext4/inode.c:2998
>  generic_perform_write+0x196/0x3a0 mm/filemap.c:3575
>  ext4_buffered_write_iter+0x2e5/0x3e0 fs/ext4/file.c:269
>  ext4_file_write_iter+0x48a/0x10b0 fs/ext4/file.c:502
>  call_write_iter include/linux/fs.h:1977 [inline]
>  do_iter_readv_writev+0x2cb/0x360 fs/read_write.c:740
>  do_iter_write+0x112/0x4c0 fs/read_write.c:866
>  vfs_iter_write+0x4c/0x70 fs/read_write.c:907
>  iter_file_splice_write+0x40a/0x750 fs/splice.c:689
>  do_splice_from fs/splice.c:767 [inline]
>  direct_splice_actor+0x80/0xa0 fs/splice.c:936
>  splice_direct_to_actor+0x345/0x650 fs/splice.c:891
>  do_splice_direct+0xf5/0x170 fs/splice.c:979
>  do_sendfile+0x7a6/0xe20 fs/read_write.c:1260
>  __do_sys_sendfile64 fs/read_write.c:1319 [inline]
>  __se_sys_sendfile64 fs/read_write.c:1311 [inline]
>  __x64_sys_sendfile64+0xa9/0x130 fs/read_write.c:1311
>  do_syscall_64+0x39/0x80 arch/x86/entry/common.c:46
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> read to 0xffff888103880870 of 8 bytes by task 29936 on cpu 0:
>  start_this_handle+0x1c1/0x1010 fs/jbd2/transaction.c:352
>  jbd2__journal_start+0x1fc/0x3f0 fs/jbd2/transaction.c:503
>  __ext4_journal_start_sb+0x159/0x310 fs/ext4/ext4_jbd2.c:105
>  __ext4_journal_start fs/ext4/ext4_jbd2.h:320 [inline]
>  ext4_da_write_begin+0x460/0xaf0 fs/ext4/inode.c:2998
>  generic_perform_write+0x196/0x3a0 mm/filemap.c:3575
>  ext4_buffered_write_iter+0x2e5/0x3e0 fs/ext4/file.c:269
>  ext4_file_write_iter+0x48a/0x10b0 fs/ext4/file.c:502
>  call_write_iter include/linux/fs.h:1977 [inline]
>  do_iter_readv_writev+0x2cb/0x360 fs/read_write.c:740
>  do_iter_write+0x112/0x4c0 fs/read_write.c:866
>  vfs_iter_write+0x4c/0x70 fs/read_write.c:907
>  iter_file_splice_write+0x40a/0x750 fs/splice.c:689
>  do_splice_from fs/splice.c:767 [inline]
>  direct_splice_actor+0x80/0xa0 fs/splice.c:936
>  splice_direct_to_actor+0x345/0x650 fs/splice.c:891
>  do_splice_direct+0xf5/0x170 fs/splice.c:979
>  do_sendfile+0x7a6/0xe20 fs/read_write.c:1260
>  __do_sys_sendfile64 fs/read_write.c:1319 [inline]
>  __se_sys_sendfile64 fs/read_write.c:1311 [inline]
>  __x64_sys_sendfile64+0xa9/0x130 fs/read_write.c:1311
>  do_syscall_64+0x39/0x80 arch/x86/entry/common.c:46
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> Reported by Kernel Concurrency Sanitizer on:
> CPU: 0 PID: 29936 Comm: syz-executor.5 Not tainted 5.12.0-rc2-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> ==================================================================

So this case is harmless. start_this_handle() does indeed check
journal->j_running_transaction without any protection and this is only a
racy check to opportunistically preallocate a transaction if we are likely
to need it. There was some macro to instruct KCSAN that the read is
actually fine, wasn't there?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
