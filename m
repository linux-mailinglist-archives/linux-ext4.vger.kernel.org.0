Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14BDF721461
	for <lists+linux-ext4@lfdr.de>; Sun,  4 Jun 2023 05:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbjFDDFu (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 3 Jun 2023 23:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbjFDDFt (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 3 Jun 2023 23:05:49 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2361B1
        for <linux-ext4@vger.kernel.org>; Sat,  3 Jun 2023 20:05:46 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-119-27.bstnma.fios.verizon.net [173.48.119.27])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 35434jVE004461
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 3 Jun 2023 23:04:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1685847889; bh=z3KOKa4T8ydEds+s7I+g3pAbtZdaGhQ4PRNpvqJaAj0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=RlQ+G3SCR+YNZy68s+wn0uz4M7XQaZXz45TKekR3IiFYnNtSPRsNtf4EWzcjTvUtx
         WAVqwplRrP5uRFfH/unt+5IbiHCIFnd8H6CYVLxOUDUgJkL4m1F2tO1+GV6VnpM3wg
         HFj1ma4liKXFYHL4duUGAwGTYXsQDJaQsl7Hfevg/MJxlX+F12cbDqZH16A6G6faA7
         5RFe0TsNliQD4Ex2iSNBrNiJLFmzrKYkpKLFZX5yY0Sp+NLvrvUR69A6BIbOidLIBy
         OcCyrPyq15IDccalea7ymjjzW6JDXNB0w6xsf3vdBcZwKnBOPpVJaWchMy5I0mWQ2O
         8dlbjkjddYbXw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 827AE15C02EE; Sat,  3 Jun 2023 23:04:45 -0400 (EDT)
Date:   Sat, 3 Jun 2023 23:04:45 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Baokun Li <libaokun1@huawei.com>
Cc:     linux-ext4@vger.kernel.org, adilger.kernel@dilger.ca, jack@suse.cz,
        ritesh.list@gmail.com, linux-kernel@vger.kernel.org,
        jun.nie@linaro.org, ebiggers@kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com, yukuai3@huawei.com,
        syzbot+a158d886ca08a3fecca4@syzkaller.appspotmail.com,
        stable@vger.kernel.org
Subject: Re: [PATCH v2] ext4: fix race condition between buffer write and
 page_mkwrite
Message-ID: <20230604030445.GF1128744@mit.edu>
References: <20230530134405.322194-1-libaokun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530134405.322194-1-libaokun1@huawei.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

I tried testing to see if this fixed [1], and it appears to be
triggering a lockdep warning[2] at this line in the patch:

[1] https://syzkaller.appspot.com/bug?extid=f4582777a19ec422b517
[2] https://syzkaller.appspot.com/x/report.txt?x=17260843280000

> diff --git a/fs/ext4/file.c b/fs/ext4/file.c
> index d101b3b0c7da..9df82d72eb90 100644
> --- a/fs/ext4/file.c
> +++ b/fs/ext4/file.c
> @@ -808,6 +809,27 @@ static int ext4_file_mmap(struct file *file, struct vm_area_struct *vma)
>  	if (!daxdev_mapping_supported(vma, dax_dev))
>  		return -EOPNOTSUPP;
>  
> +	/*
> +	 * Writing via mmap has no logic to handle inline data, so we
> +	 * need to call ext4_convert_inline_data() to convert the inode
> +	 * to normal format before doing so, otherwise a BUG_ON will be
> +	 * triggered in ext4_writepages() due to the
> +	 * EXT4_STATE_MAY_INLINE_DATA flag. Moreover, we need to grab
> +	 * i_rwsem during conversion, since clearing and setting the
> +	 * inline data flag may race with ext4_buffered_write_iter()
> +	 * to trigger a BUG_ON.
> +	 */
> +	if (ext4_has_feature_inline_data(sb) &&
> +	    vma->vm_flags & VM_SHARED && vma->vm_flags & VM_MAYWRITE) {
> +		int err;
> +
> +		inode_lock(inode); <=================== LOCKDEP warning
> +		err = ext4_convert_inline_data(inode);
> +		inode_unlock(inode);
> +		if (err)
> +			return err;
> +	}


The details of the lockdep warning from [2], which appears to be a
mmap(2) racing with a buffered write(2) are below.  Could you take a
look?

Thanks!

					- Ted

======================================================
WARNING: possible circular locking dependency detected
6.4.0-rc4-syzkaller-geb1f822c76be-dirty #0 Not tainted
------------------------------------------------------
syz-executor.4/5589 is trying to acquire lock:
ffff888024228168 (&mm->mmap_lock){++++}-{3:3}, at: mmap_read_lock include/linux/mmap_lock.h:142 [inline]
ffff888024228168 (&mm->mmap_lock){++++}-{3:3}, at: do_user_addr_fault+0xb3d/0x1210 arch/x86/mm/fault.c:1391

but task is already holding lock:
ffff88806a066800 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: inode_lock include/linux/fs.h:775 [inline]
ffff88806a066800 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: ext4_buffered_write_iter+0xb0/0x460 fs/ext4/file.c:283

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&sb->s_type->i_mutex_key#8){++++}-{3:3}:
       down_write+0x92/0x200 kernel/locking/rwsem.c:1573
       inode_lock include/linux/fs.h:775 [inline]
       ext4_file_mmap+0x62e/0x800 fs/ext4/file.c:826
       call_mmap include/linux/fs.h:1873 [inline]
       mmap_region+0x694/0x28d0 mm/mmap.c:2652
       do_mmap+0x831/0xf60 mm/mmap.c:1394
       vm_mmap_pgoff+0x1a2/0x3b0 mm/util.c:543
       ksys_mmap_pgoff+0x41f/0x5a0 mm/mmap.c:1440
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #0 (&mm->mmap_lock){++++}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3113 [inline]
       check_prevs_add kernel/locking/lockdep.c:3232 [inline]
       validate_chain kernel/locking/lockdep.c:3847 [inline]
       __lock_acquire+0x2fcd/0x5f30 kernel/locking/lockdep.c:5088
       lock_acquire kernel/locking/lockdep.c:5705 [inline]
       lock_acquire+0x1b1/0x520 kernel/locking/lockdep.c:5670
       down_read+0x9c/0x480 kernel/locking/rwsem.c:1520
       mmap_read_lock include/linux/mmap_lock.h:142 [inline]
       do_user_addr_fault+0xb3d/0x1210 arch/x86/mm/fault.c:1391
       handle_page_fault arch/x86/mm/fault.c:1534 [inline]
       exc_page_fault+0x98/0x170 arch/x86/mm/fault.c:1590
       asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:570
       fault_in_readable+0x1a5/0x210 mm/gup.c:1856
       fault_in_iov_iter_readable+0x252/0x2c0 lib/iov_iter.c:362
       generic_perform_write+0x1ae/0x570 mm/filemap.c:3913
       ext4_buffered_write_iter+0x15b/0x460 fs/ext4/file.c:289
       ext4_file_write_iter+0xbe0/0x1740 fs/ext4/file.c:710
       call_write_iter include/linux/fs.h:1868 [inline]
       new_sync_write fs/read_write.c:491 [inline]
       vfs_write+0x945/0xd50 fs/read_write.c:584
       ksys_write+0x12b/0x250 fs/read_write.c:637
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&sb->s_type->i_mutex_key#8);
                               lock(&mm->mmap_lock);
                               lock(&sb->s_type->i_mutex_key#8);
  rlock(&mm->mmap_lock);

 *** DEADLOCK ***

3 locks held by syz-executor.4/5589:
 #0: ffff88802a7fe0e8 (&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0xe7/0x100 fs/file.c:1047
 #1: ffff888021fe0460 (sb_writers#4){.+.+}-{0:0}, at: ksys_write+0x12b/0x250 fs/read_write.c:637
 #2: ffff88806a066800 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: inode_lock include/linux/fs.h:775 [inline]
 #2: ffff88806a066800 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: ext4_buffered_write_iter+0xb0/0x460 fs/ext4/file.c:283

stack backtrace:
CPU: 0 PID: 5589 Comm: syz-executor.4 Not tainted 6.4.0-rc4-syzkaller-geb1f822c76be-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/25/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x150 lib/dump_stack.c:106
 check_noncircular+0x25f/0x2e0 kernel/locking/lockdep.c:2188
 check_prev_add kernel/locking/lockdep.c:3113 [inline]
 check_prevs_add kernel/locking/lockdep.c:3232 [inline]
 validate_chain kernel/locking/lockdep.c:3847 [inline]
 __lock_acquire+0x2fcd/0x5f30 kernel/locking/lockdep.c:5088
 lock_acquire kernel/locking/lockdep.c:5705 [inline]
 lock_acquire+0x1b1/0x520 kernel/locking/lockdep.c:5670
 down_read+0x9c/0x480 kernel/locking/rwsem.c:1520
 mmap_read_lock include/linux/mmap_lock.h:142 [inline]
 do_user_addr_fault+0xb3d/0x1210 arch/x86/mm/fault.c:1391
 handle_page_fault arch/x86/mm/fault.c:1534 [inline]
 exc_page_fault+0x98/0x170 arch/x86/mm/fault.c:1590
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:570
RIP: 0010:fault_in_readable+0x1a5/0x210 mm/gup.c:1856
Code: fc ff df 48 c7 04 02 00 00 00 00 48 83 c4 48 4c 89 e0 5b 5d 41 5c 41 5d 41 5e 41 5f c3 45 31 e4 eb ce e8 ae 51 c4 ff 45 31 f6 <41> 8a 45 00 31 ff 44 89 f6 88 44 24 28 e8 b9 4d c4 ff 45 85 f6 75
RSP: 0018:ffffc90006187a38 EFLAGS: 00050246
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffff888026905940 RSI: ffffffff81bff672 RDI: 0000000000000007
RBP: 00000000200002cc R08: 0000000000000007 R09: 0000000000000000
R10: 00000000000002c0 R11: 1ffffffff219cbe3 R12: 000000000000000c
R13: 00000000200002c0 R14: 0000000000000000 R15: 1ffff92000c30f48
 fault_in_iov_iter_readable+0x252/0x2c0 lib/iov_iter.c:362
 generic_perform_write+0x1ae/0x570 mm/filemap.c:3913
 ext4_buffered_write_iter+0x15b/0x460 fs/ext4/file.c:289
 ext4_file_write_iter+0xbe0/0x1740 fs/ext4/file.c:710
 call_write_iter include/linux/fs.h:1868 [inline]
 new_sync_write fs/read_write.c:491 [inline]
 vfs_write+0x945/0xd50 fs/read_write.c:584
 ksys_write+0x12b/0x250 fs/read_write.c:637
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f2359a8c169
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f235a721168 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f2359bac050 RCX: 00007f2359a8c169
RDX: 000000000000000c RSI: 00000000200002c0 RDI: 0000000000000004
RBP: 00007f2359ae7ca1 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffea89659df R14: 00007f235a721300 R15: 0000000000022000
 </TASK>
----------------
Code disassembly (best guess), 2 bytes skipped:
   0:	df 48 c7             	fisttps -0x39(%rax)
   3:	04 02                	add    $0x2,%al
   5:	00 00                	add    %al,(%rax)
   7:	00 00                	add    %al,(%rax)
   9:	48 83 c4 48          	add    $0x48,%rsp
   d:	4c 89 e0             	mov    %r12,%rax
  10:	5b                   	pop    %rbx
  11:	5d                   	pop    %rbp
  12:	41 5c                	pop    %r12
  14:	41 5d                	pop    %r13
  16:	41 5e                	pop    %r14
  18:	41 5f                	pop    %r15
  1a:	c3                   	retq
  1b:	45 31 e4             	xor    %r12d,%r12d
  1e:	eb ce                	jmp    0xffffffee
  20:	e8 ae 51 c4 ff       	callq  0xffc451d3
  25:	45 31 f6             	xor    %r14d,%r14d
* 28:	41 8a 45 00          	mov    0x0(%r13),%al <-- trapping instruction
  2c:	31 ff                	xor    %edi,%edi
  2e:	44 89 f6             	mov    %r14d,%esi
  31:	88 44 24 28          	mov    %al,0x28(%rsp)
  35:	e8 b9 4d c4 ff       	callq  0xffc44df3
  3a:	45 85 f6             	test   %r14d,%r14d
  3d:	75                   	.byte 0x75
  
