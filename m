Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF5D22E843
	for <lists+linux-ext4@lfdr.de>; Mon, 27 Jul 2020 10:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbgG0I5J (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 27 Jul 2020 04:57:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:38496 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726269AbgG0I5J (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 27 Jul 2020 04:57:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 37E1AAC1D;
        Mon, 27 Jul 2020 08:57:17 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id D41DA1E12C5; Mon, 27 Jul 2020 10:57:06 +0200 (CEST)
Date:   Mon, 27 Jul 2020 10:57:06 +0200
From:   Jan Kara <jack@suse.cz>
To:     Xianting Tian <xianting_tian@126.com>
Cc:     tytso@mit.edu, jack@suse.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] jbd2: check bh2jh() before accessing it
Message-ID: <20200727085706.GE23179@quack2.suse.cz>
References: <1595078883-8647-1-git-send-email-xianting_tian@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1595078883-8647-1-git-send-email-xianting_tian@126.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat 18-07-20 09:28:03, Xianting Tian wrote:
> We met a crash issue when testing nbd device on kernel 4.14.0-115,
> the scenario of the issue is "nbd device disconnected before unmounting
> ext4 filesystem".
> The call trace of the crash as below:
> [346961.426274] block nbd2: Connection timed out
> [346961.426943] EXT4-fs warning (device nbd2): ext4_end_bio:323: I/O error 10 writing to inode 5768758
> 			(offset 155926528 size 8192 starting block 8998070)
> [346961.426957] Aborting journal on device nbd2-8.
> [346961.427027] EXT4-fs error (device nbd2) in __ext4_new_inode:927: Readonly filesystem
>  ... ...
> [346961.437288] Buffer I/O error on dev nbd2, logical block 13139968, lost sync page write
> [346961.437878] JBD2: Error -5 detected when updating journal superblock for nbd2-8.
> [346961.438478] BUG: unable to handle kernel NULL pointer dereference at 0000000000000008
> [346961.452495] RIP: 0010:jbd2_journal_grab_journal_head+0x1e/0x40 [jbd2]  <== crash code offset is 0x1e(30)
> [346961.453457] RSP: 0018:ffffc9000ffbbca8 EFLAGS: 00010206
> [346961.454414] RAX: 0000000000000000 RBX: ffff881dafe04960 RCX: ffff881aee5b0ac8
> [346961.455378] RDX: ffff881df7768690 RSI: ffff88100a5e9800 RDI: ffff880a22593d40
> [346961.456360] RBP: ffffc9000ffbbca8 R08: ffff881dafe04960 R09: 000000018040001c
> [346961.457332] R10: 000000002fe92601 R11: ffff88202fe90700 R12: ffff88100a5e9800
> [346961.458302] R13: 0000000000000000 R14: ffff880a22593d40 R15: ffff881dafe04960
> [346961.459269] FS:  0000000000000000(0000) GS:ffff88103e5c0000(0000) knlGS:0000000000000000
> [346961.460250] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [346961.461216] CR2: 0000000000000008 CR3: 0000000001c09004 CR4: 00000000007606e0
> [346961.462201] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [346961.463164] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [346961.465047] Call Trace:
> [346961.465981]  __jbd2_journal_insert_checkpoint+0x28/0x80 [jbd2]
> [346961.466907]  jbd2_journal_commit_transaction+0x1185/0x1a20 [jbd2]
> [346961.467862]  ? lock_timer_base+0x7d/0xa0
> [346961.468794]  kjournald2+0xd2/0x260 [jbd2]
> [346961.469717]  ? remove_wait_queue+0x60/0x60
> [346961.470630]  kthread+0x109/0x140
> [346961.471533]  ? commit_timeout+0x10/0x10 [jbd2]
> [346961.472438]  ? kthread_park+0x60/0x60
> [346961.473521]  ? do_syscall_64+0x182/0x1b0
> [346961.474546]  ret_from_fork+0x25/0x30
> 
> Analysis of the crash code as below:
> struct journal_head *jbd2_journal_grab_journal_head(struct buffer_head *bh)
> {
>         struct journal_head *jh = NULL;
> 
>         jbd_lock_bh_journal_head(bh);
>         if (buffer_jbd(bh)) {
>                 jh = bh2jh(bh); <== jh is NULL (bh->b_private = NULL)
>                 jh->b_jcount++; <== crash here!!!
> 				    b_jcount offset in 'struct journal_head' is 0x8
>         }
>         jbd_unlock_bh_journal_head(bh);
>         return jh;
> }
> 
> crash> dis -l jbd2_journal_grab_journal_head
> 0xffffffffa00b6050 <jbd2_journal_grab_journal_head>:    nopl   0x0(%rax,%rax,1) [FTRACE NOP]
> 0xffffffffa00b6055 <jbd2_journal_grab_journal_head+5>:  push   %rbp
> 0xffffffffa00b6056 <jbd2_journal_grab_journal_head+6>:  mov    %rsp,%rbp
> 0xffffffffa00b6059 <jbd2_journal_grab_journal_head+9>:  lock btsl $0x18,(%rdi)
> 0xffffffffa00b605e <jbd2_journal_grab_journal_head+14>: jb     0xffffffffa00b6079 <jbd2_journal_grab_journal_head+41>
> 0xffffffffa00b6060 <jbd2_journal_grab_journal_head+16>: mov    (%rdi),%rax
> 0xffffffffa00b6063 <jbd2_journal_grab_journal_head+19>: test   $0x20000,%eax
> 0xffffffffa00b6068 <jbd2_journal_grab_journal_head+24>: je     0xffffffffa00b6087 <jbd2_journal_grab_journal_head+55>
> 0xffffffffa00b606a <jbd2_journal_grab_journal_head+26>: mov    0x40(%rdi),%rax  <== jh is NULL(b_private's offset in 'struct buffer_head' is 0x40)
> 0xffffffffa00b606e <jbd2_journal_grab_journal_head+30>: addl   $0x1,0x8(%rax)  <== "jh->b_jcount++" crash!!!
> 
> According to the logical in above code, buffer_head has an attached
> journal_head("buffer_jbd(bh)" is true), but buffer_head doesn't record
> it(bh->b_private is NULL).
> So testing if "buffer_jbd(bh)" is true can't guarantee "bh->b_private"
> is not NULL under the abnormal test case.
> 
> Signed-off-by: Xianting Tian <xianting_tian@126.com>
> ---
>  fs/jbd2/journal.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> index e494443..cb661d4 100644
> --- a/fs/jbd2/journal.c
> +++ b/fs/jbd2/journal.c
> @@ -2535,7 +2535,7 @@ struct journal_head *jbd2_journal_grab_journal_head(struct buffer_head *bh)
>  	struct journal_head *jh = NULL;
>  
>  	jbd_lock_bh_journal_head(bh);
> -	if (buffer_jbd(bh)) {
> +	if (buffer_jbd(bh) && bh2jh(bh)) {

Thanks for the report and the patch but this is not the right way how to
fix the problem. The buffer shouldn't have BH_JBD bit set when
bh->b_private is NULL. Furthermore looking at the call stack
__jbd2_journal_insert_checkpoint() already holds the journal_head we are
interested in so it rather looks like we race with invalidation of the
block device buffer cache after NBD device disappeared. There were some
changes in the lifetime of the block devices after 4.14. Can you reproduce
the issue with some more recent kernel because I suspect the problem may be
already fixed. Anyway the right fix is to make sure NBD does not destroy
buffers while the filesystem is still using them...

>  		jh = bh2jh(bh);
>  		jh->b_jcount++;
>  	}
> 

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
