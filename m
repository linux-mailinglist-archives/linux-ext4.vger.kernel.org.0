Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5B5116A13F
	for <lists+linux-ext4@lfdr.de>; Mon, 24 Feb 2020 10:11:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727932AbgBXJLa (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 24 Feb 2020 04:11:30 -0500
Received: from mx2.suse.de ([195.135.220.15]:42758 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728355AbgBXJKw (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 24 Feb 2020 04:10:52 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 7C1D9AC92;
        Mon, 24 Feb 2020 09:10:50 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 6BBFA1E0E33; Mon, 24 Feb 2020 10:10:51 +0100 (CET)
Date:   Mon, 24 Feb 2020 10:10:51 +0100
From:   Jan Kara <jack@suse.cz>
To:     Qian Cai <cai@lca.pw>
Cc:     tytso@mit.edu, jack@suse.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/jbd2: fix data races at struct journal_head
Message-ID: <20200224091051.GC27857@quack2.suse.cz>
References: <20200222043111.2227-1-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200222043111.2227-1-cai@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri 21-02-20 23:31:11, Qian Cai wrote:
> journal_head::b_transaction and journal_head::b_next_transaction could
> be accessed concurrently as noticed by KCSAN,
> 
>  LTP: starting fsync04
>  /dev/zero: Can't open blockdev
>  EXT4-fs (loop0): mounting ext3 file system using the ext4 subsystem
>  EXT4-fs (loop0): mounted filesystem with ordered data mode. Opts: (null)
>  ==================================================================
>  BUG: KCSAN: data-race in __jbd2_journal_refile_buffer [jbd2] / jbd2_write_access_granted [jbd2]
> 
>  write to 0xffff99f9b1bd0e30 of 8 bytes by task 25721 on cpu 70:
>   __jbd2_journal_refile_buffer+0xdd/0x210 [jbd2]
>   __jbd2_journal_refile_buffer at fs/jbd2/transaction.c:2569
>   jbd2_journal_commit_transaction+0x2d15/0x3f20 [jbd2]
>   (inlined by) jbd2_journal_commit_transaction at fs/jbd2/commit.c:1034
>   kjournald2+0x13b/0x450 [jbd2]
>   kthread+0x1cd/0x1f0
>   ret_from_fork+0x27/0x50
> 
>  read to 0xffff99f9b1bd0e30 of 8 bytes by task 25724 on cpu 68:
>   jbd2_write_access_granted+0x1b2/0x250 [jbd2]
>   jbd2_write_access_granted at fs/jbd2/transaction.c:1155
>   jbd2_journal_get_write_access+0x2c/0x60 [jbd2]
>   __ext4_journal_get_write_access+0x50/0x90 [ext4]
>   ext4_mb_mark_diskspace_used+0x158/0x620 [ext4]
>   ext4_mb_new_blocks+0x54f/0xca0 [ext4]
>   ext4_ind_map_blocks+0xc79/0x1b40 [ext4]
>   ext4_map_blocks+0x3b4/0x950 [ext4]
>   _ext4_get_block+0xfc/0x270 [ext4]
>   ext4_get_block+0x3b/0x50 [ext4]
>   __block_write_begin_int+0x22e/0xae0
>   __block_write_begin+0x39/0x50
>   ext4_write_begin+0x388/0xb50 [ext4]
>   generic_perform_write+0x15d/0x290
>   ext4_buffered_write_iter+0x11f/0x210 [ext4]
>   ext4_file_write_iter+0xce/0x9e0 [ext4]
>   new_sync_write+0x29c/0x3b0
>   __vfs_write+0x92/0xa0
>   vfs_write+0x103/0x260
>   ksys_write+0x9d/0x130
>   __x64_sys_write+0x4c/0x60
>   do_syscall_64+0x91/0xb05
>   entry_SYSCALL_64_after_hwframe+0x49/0xbe
> 
>  5 locks held by fsync04/25724:
>   #0: ffff99f9911093f8 (sb_writers#13){.+.+}, at: vfs_write+0x21c/0x260
>   #1: ffff99f9db4c0348 (&sb->s_type->i_mutex_key#15){+.+.}, at: ext4_buffered_write_iter+0x65/0x210 [ext4]
>   #2: ffff99f5e7dfcf58 (jbd2_handle){++++}, at: start_this_handle+0x1c1/0x9d0 [jbd2]
>   #3: ffff99f9db4c0168 (&ei->i_data_sem){++++}, at: ext4_map_blocks+0x176/0x950 [ext4]
>   #4: ffffffff99086b40 (rcu_read_lock){....}, at: jbd2_write_access_granted+0x4e/0x250 [jbd2]
>  irq event stamp: 1407125
>  hardirqs last  enabled at (1407125): [<ffffffff980da9b7>] __find_get_block+0x107/0x790
>  hardirqs last disabled at (1407124): [<ffffffff980da8f9>] __find_get_block+0x49/0x790
>  softirqs last  enabled at (1405528): [<ffffffff98a0034c>] __do_softirq+0x34c/0x57c
>  softirqs last disabled at (1405521): [<ffffffff97cc67a2>] irq_exit+0xa2/0xc0
> 
>  Reported by Kernel Concurrency Sanitizer on:
>  CPU: 68 PID: 25724 Comm: fsync04 Tainted: G L 5.6.0-rc2-next-20200221+ #7
>  Hardware name: HPE ProLiant DL385 Gen10/ProLiant DL385 Gen10, BIOS A40 07/10/2019
> 
> The plain reads are outside of jh->b_state_lock critical section which result
> in data races. Fix them by adding pairs of READ|WRITE_ONCE().
> 
> Signed-off-by: Qian Cai <cai@lca.pw>

Yeah, makes sense. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/jbd2/transaction.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
> index 2dd848a743ed..c5f7f6d0f33b 100644
> --- a/fs/jbd2/transaction.c
> +++ b/fs/jbd2/transaction.c
> @@ -1152,8 +1152,8 @@ static bool jbd2_write_access_granted(handle_t *handle, struct buffer_head *bh,
>  	/* For undo access buffer must have data copied */
>  	if (undo && !jh->b_committed_data)
>  		goto out;
> -	if (jh->b_transaction != handle->h_transaction &&
> -	    jh->b_next_transaction != handle->h_transaction)
> +	if (READ_ONCE(jh->b_transaction) != handle->h_transaction &&
> +	    READ_ONCE(jh->b_next_transaction) != handle->h_transaction)
>  		goto out;
>  	/*
>  	 * There are two reasons for the barrier here:
> @@ -2565,8 +2565,8 @@ bool __jbd2_journal_refile_buffer(struct journal_head *jh)
>  	 * our jh reference and thus __jbd2_journal_file_buffer() must not
>  	 * take a new one.
>  	 */
> -	jh->b_transaction = jh->b_next_transaction;
> -	jh->b_next_transaction = NULL;
> +	WRITE_ONCE(jh->b_transaction, jh->b_next_transaction);
> +	WRITE_ONCE(jh->b_next_transaction, NULL);
>  	if (buffer_freed(bh))
>  		jlist = BJ_Forget;
>  	else if (jh->b_modified)
> -- 
> 2.21.0 (Apple Git-122.2)
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
