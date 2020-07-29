Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9419E23270A
	for <lists+linux-ext4@lfdr.de>; Wed, 29 Jul 2020 23:39:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbgG2Vi6 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 29 Jul 2020 17:38:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:44642 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726560AbgG2Vi6 (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 29 Jul 2020 17:38:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AC2A7ABE4;
        Wed, 29 Jul 2020 21:39:06 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 507C61E12CB; Wed, 29 Jul 2020 23:38:54 +0200 (CEST)
Date:   Wed, 29 Jul 2020 23:38:54 +0200
From:   Jan Kara <jack@suse.cz>
To:     Xianting Tian <xianting_tian@126.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: check superblock mapped prior to get write access
Message-ID: <20200729213854.GE16052@quack2.suse.cz>
References: <1595946833-13011-1-git-send-email-xianting_tian@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1595946833-13011-1-git-send-email-xianting_tian@126.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello!

On Tue 28-07-20 10:33:53, Xianting Tian wrote:
> One crash issue happened when directly down the network interface,
> which nbd device is connected to. The kernel version is kernel
> 4.14.0-115.
> According to the debug log and call trace, the buffer of ext4
> superblock already unmapped after the network of nbd device down.
> But the code continue to run until crash.
> I checked latest kernel code of 5.8-rc7 based on the call trace,
> no function checked if buffer of ext4 superblock unmapped.
> The patch is similar to commit 742b06b, aim to check superblock
> mapped prior to get write access.
> 
> The crash reason described as below:
> struct journal_head *jbd2_journal_add_journal_head(struct buffer_head *bh)
> {
>         ... ...
> 	jbd_lock_bh_journal_head(bh);
> 	if (buffer_jbd(bh)) {
> 		jh = bh2jh(bh); <<== jh is null!!!
> 	} else {
>                 ... ...
> 	}
> 	jh->b_jcount++; <<==crash here!!!!
> 	jbd_unlock_bh_journal_head(bh);
>         ... ...
> }

This is the same problem as you've tried to fix in [1] for jbd2. And the
answer is still the same as I mentioned in my reply [2]. This is just
papering over the real problem. Please check whether this still happens
with recent kernel, if yes, we need do find out how there can be
buffer_jbd() buffer with bh->b_private == NULL.

[1] https://lore.kernel.org/lkml/1595078883-8647-1-git-send-email-xianting_tian@126.com
[2] https://lore.kernel.org/lkml/20200727085706.GE23179@quack2.suse.cz

								Honza

> 
> Debug code added to __ext4_journal_get_write_access:
> int __ext4_journal_get_write_access(const char *where, unsigned int line,
>                                 handle_t *handle, struct buffer_head *bh)
> {
>         int err = 0;
> 
>         might_sleep();
> 
>         if (ext4_handle_valid(handle)) {
>                 struct super_block *sb;
>                 struct buffer_head *sbh;
> 
>                 sb = handle->h_transaction->t_journal->j_private;
>                 if (unlikely(ext4_forced_shutdown(EXT4_SB(sb)))) {
>                         jbd2_journal_abort_handle(handle);
>                         return -EIO;
>                 }
> 
>                 sbh = EXT4_SB(sb)->s_sbh;
>                 if (!buffer_mapped(sbh)) {
>                         ext4 sb bh not mapped\n");  <<==debug code
>                 }
> 
>                 err = jbd2_journal_get_write_access(handle, bh);
>                 if (err)
>                         ext4_journal_abort_handle(where, line, __func__, bh,
>                                                   handle, err);
>         }
>         return err;
> }
> 
> Call trace of crash:
> [ 1715.669527] print_req_error: I/O error, dev nbd3, sector 42211904
> 
> [ 1715.674940] ext4 sb bh not mapped   <<== debug log, which is added and printed by the
>                                             function "__ext4_journal_get_write_access"
> 
> [ 1715.674946] BUG: unable to handle kernel NULL pointer dereference at 0000000000000008
> [ 1715.674955] IP: jbd2_journal_add_journal_head+0x9d/0x110 [jbd2]
> [ 1715.674956] PGD 2010004067 P4D 2010004067 PUD 201000b067 PMD 0
> [ 1715.674961] Oops: 0002 [#1] SMP
> [ 1715.675020] task: ffff8808a4d3dac0 task.stack: ffffc9002e78c000
> [ 1715.675024] RIP: 0010:jbd2_journal_add_journal_head+0x9d/0x110 [jbd2] <== the crash is caused
> [ 1715.675025] RSP: 0018:ffffc9002e78fb50 EFLAGS: 00010206
> [ 1715.675026] RAX: 0000000000000000 RBX: ffff8816b71cad00 RCX: 0000000000000000
> [ 1715.675026] RDX: 0000000000000000 RSI: ffff8816b71cad00 RDI: ffff8816b71cad00
> [ 1715.675027] RBP: ffffc9002e78fb58 R08: 000000000000001b R09: ffff88207f82fe07
> [ 1715.675028] R10: 000000000000113d R11: 0000000000000000 R12: ffff8820223a5ab0
> [ 1715.675028] R13: 0000000000000000 R14: ffff8816b71cad00 R15: ffff88196053d930
> [ 1715.675029] FS:  00007fc2ce9e9700(0000) GS:ffff88203d740000(0000) knlGS:0000000000000000
> [ 1715.675030] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 1715.675031] CR2: 0000000000000008 CR3: 0000002016d2c004 CR4: 00000000007606e0
> [ 1715.675033] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [ 1715.675034] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [ 1715.675034] PKRU: 55555554
> [ 1715.675035] Call Trace:
> [ 1715.675041]  jbd2_journal_get_write_access+0x6c/0xc0 [jbd2]
> [ 1715.675057]  __ext4_journal_get_write_access+0x8f/0x120 [ext4]
> [ 1715.675069]  ext4_reserve_inode_write+0x7b/0xb0 [ext4]
> [ 1715.675079]  ? ext4_dirty_inode+0x48/0x70 [ext4]
> [ 1715.675088]  ext4_mark_inode_dirty+0x53/0x1e0 [ext4]
> [ 1715.675096]  ? __ext4_journal_start_sb+0x6d/0xf0 [ext4]
> [ 1715.675104]  ext4_dirty_inode+0x48/0x70 [ext4]
> [ 1715.675111]  __mark_inode_dirty+0x17f/0x350
> [ 1715.675116]  generic_update_time+0x87/0xd0
> [ 1715.675119]  file_update_time+0xbc/0x110
> [ 1715.675122]  ? try_to_wake_up+0x59/0x470
> [ 1715.675125]  __generic_file_write_iter+0x9d/0x1e0
> [ 1715.675134]  ext4_file_write_iter+0xca/0x420 [ext4]
> [ 1715.675136]  __vfs_write+0xf3/0x170
> [ 1715.675138]  vfs_write+0xb2/0x1b0
> [ 1715.675141]  ? syscall_trace_enter+0x1d0/0x2b0
> [ 1715.675142]  SyS_write+0x55/0xc0
> [ 1715.675144]  do_syscall_64+0x67/0x1b0
> [ 1715.675147]  entry_SYSCALL64_slow_path+0x25/0x25
> 
> Signed-off-by: Xianting Tian <xianting_tian@126.com>
> ---
>  fs/ext4/ext4_jbd2.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/fs/ext4/ext4_jbd2.c b/fs/ext4/ext4_jbd2.c
> index 0c76cdd..9a60ca7 100644
> --- a/fs/ext4/ext4_jbd2.c
> +++ b/fs/ext4/ext4_jbd2.c
> @@ -203,6 +203,15 @@ int __ext4_journal_get_write_access(const char *where, unsigned int line,
>  	might_sleep();
>  
>  	if (ext4_handle_valid(handle)) {
> +		struct super_block *sb;
> +		struct buffer_head *sbh;
> +
> +		sb = handle->h_transaction->t_journal->j_private;
> +		sbh = EXT4_SB(sb)->s_sbh;
> +		if (unlikely(!buffer_mapped(sbh))) {
> +			return -EIO;
> +		}
> +
>  		err = jbd2_journal_get_write_access(handle, bh);
>  		if (err)
>  			ext4_journal_abort_handle(where, line, __func__, bh,
> -- 
> 1.8.3.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
