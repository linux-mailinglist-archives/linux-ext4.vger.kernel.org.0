Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79ECF710A13
	for <lists+linux-ext4@lfdr.de>; Thu, 25 May 2023 12:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240911AbjEYKaQ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 25 May 2023 06:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240908AbjEYKaO (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 25 May 2023 06:30:14 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6310010B;
        Thu, 25 May 2023 03:30:12 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1E70C21845;
        Thu, 25 May 2023 10:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1685010611; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aTxciTh1uzj9x8GS4OITj4Zwz8m3/P8MmqMVgrmo36o=;
        b=qnut/kVTkpTzEa5SCnd//scXOTu+CUMjsnkLaxmA19DCYoQyzvITWvlkYZQGT1Y+PIZe3i
        dszz/FHPKBDAy2wziRhbQzKS8rwjQvLklvBxvkpVhJGw8ai6hHl2yL1GNzGUFcdGG137ku
        ecTPilzs2TLDhhFccUHULosVMwp27vU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1685010611;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aTxciTh1uzj9x8GS4OITj4Zwz8m3/P8MmqMVgrmo36o=;
        b=iyPGm/xP7PZ/kUbFcuSZTt54Lk6+w9WrjPoAtIIJcoSeQyIfX+MjFK7yP19io/el5aDl22
        dlcux8vnjbkM9uCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 10C4E134B2;
        Thu, 25 May 2023 10:30:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id npQNBLM4b2TLfQAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 25 May 2023 10:30:11 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 8D889A075C; Thu, 25 May 2023 12:30:10 +0200 (CEST)
Date:   Thu, 25 May 2023 12:30:10 +0200
From:   Jan Kara <jack@suse.cz>
To:     Baokun Li <libaokun1@huawei.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, ritesh.list@gmail.com,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com, yukuai3@huawei.com, stable@vger.kernel.org
Subject: Re: [PATCH v4] ext4: fix race between writepages and remount
Message-ID: <20230525103010.jowdiecabckx5cwq@quack3>
References: <20230524072538.2883391-1-libaokun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230524072538.2883391-1-libaokun1@huawei.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 24-05-23 15:25:38, Baokun Li wrote:
> We got a WARNING in ext4_add_complete_io:
> ==================================================================
>  WARNING: at fs/ext4/page-io.c:231 ext4_put_io_end_defer+0x182/0x250
>  CPU: 10 PID: 77 Comm: ksoftirqd/10 Tainted: 6.3.0-rc2 #85
>  RIP: 0010:ext4_put_io_end_defer+0x182/0x250 [ext4]
>  [...]
>  Call Trace:
>   <TASK>
>   ext4_end_bio+0xa8/0x240 [ext4]
>   bio_endio+0x195/0x310
>   blk_update_request+0x184/0x770
>   scsi_end_request+0x2f/0x240
>   scsi_io_completion+0x75/0x450
>   scsi_finish_command+0xef/0x160
>   scsi_complete+0xa3/0x180
>   blk_complete_reqs+0x60/0x80
>   blk_done_softirq+0x25/0x40
>   __do_softirq+0x119/0x4c8
>   run_ksoftirqd+0x42/0x70
>   smpboot_thread_fn+0x136/0x3c0
>   kthread+0x140/0x1a0
>   ret_from_fork+0x2c/0x50
> ==================================================================
> 
> Above issue may happen as follows:
> 
>             cpu1                        cpu2
> ----------------------------|----------------------------
> mount -o dioread_lock
> ext4_writepages
>  ext4_do_writepages
>   *if (ext4_should_dioread_nolock(inode))*
>     // rsv_blocks is not assigned here
>                                  mount -o remount,dioread_nolock
>   ext4_journal_start_with_reserve
>    __ext4_journal_start
>     __ext4_journal_start_sb
>      jbd2__journal_start
>       *if (rsv_blocks)*
>         // h_rsv_handle is not initialized here
>   mpage_map_and_submit_extent
>     mpage_map_one_extent
>       dioread_nolock = ext4_should_dioread_nolock(inode)
>       if (dioread_nolock && (map->m_flags & EXT4_MAP_UNWRITTEN))
>         mpd->io_submit.io_end->handle = handle->h_rsv_handle
>         ext4_set_io_unwritten_flag
>           io_end->flag |= EXT4_IO_END_UNWRITTEN
>       // now io_end->handle is NULL but has EXT4_IO_END_UNWRITTEN flag
> 
> scsi_finish_command
>  scsi_io_completion
>   scsi_io_completion_action
>    scsi_end_request
>     blk_update_request
>      req_bio_endio
>       bio_endio
>        bio->bi_end_io  > ext4_end_bio
>         ext4_put_io_end_defer
> 	 ext4_add_complete_io
> 	  // trigger WARN_ON(!io_end->handle && sbi->s_journal);
> 
> The immediate cause of this problem is that ext4_should_dioread_nolock()
> function returns inconsistent values in the ext4_do_writepages() and
> mpage_map_one_extent(). There are four conditions in this function that
> can be changed at mount time to cause this problem. These four conditions
> can be divided into two categories:
> 
>     (1) journal_data and EXT4_EXTENTS_FL, which can be changed by ioctl
>     (2) DELALLOC and DIOREAD_NOLOCK, which can be changed by remount
> 
> The two in the first category have been fixed by commit c8585c6fcaf2
> ("ext4: fix races between changing inode journal mode and ext4_writepages")
> and commit cb85f4d23f79 ("ext4: fix race between writepages and enabling
> EXT4_EXTENTS_FL") respectively.
> 
> Two cases in the other category have not yet been fixed, and the above
> issue is caused by this situation. We refer to the fix for the first
> category, when applying options during remount, we grab s_writepages_rwsem
> to avoid racing with writepages ops to trigger this problem.
> 
> Fixes: 6b523df4fb5a ("ext4: use transaction reservation for extent conversion in ext4_end_io")
> Cc: stable@vger.kernel.org
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Thanks for the fix! It looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> V1->V2:
> 	Grab s_writepages_rwsem unconditionally during remount.
> 	Remove patches 1,2 that are no longer needed.
> V2->V3:
> 	Also grab s_writepages_rwsem when restoring options.
> V3->V4:
> 	Rebased on top of mainline.
> 	Reference 00d873c17e29 ("ext4: avoid deadlock in fs reclaim with
> 	page writeback") to use s_writepages_rwsem.
> 
>  fs/ext4/ext4.h  |  3 ++-
>  fs/ext4/super.c | 14 ++++++++++++++
>  2 files changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 6948d673bba2..97ef99c7f296 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -1613,7 +1613,8 @@ struct ext4_sb_info {
>  
>  	/*
>  	 * Barrier between writepages ops and changing any inode's JOURNAL_DATA
> -	 * or EXTENTS flag.
> +	 * or EXTENTS flag or between writepages ops and changing DELALLOC or
> +	 * DIOREAD_NOLOCK mount options on remount.
>  	 */
>  	struct percpu_rw_semaphore s_writepages_rwsem;
>  	struct dax_device *s_daxdev;
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 9680fe753e59..fff42682e4e0 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -6389,6 +6389,7 @@ static int __ext4_remount(struct fs_context *fc, struct super_block *sb)
>  	ext4_group_t g;
>  	int err = 0;
>  	int enable_rw = 0;
> +	int alloc_ctx;
>  #ifdef CONFIG_QUOTA
>  	int enable_quota = 0;
>  	int i, j;
> @@ -6429,7 +6430,16 @@ static int __ext4_remount(struct fs_context *fc, struct super_block *sb)
>  
>  	}
>  
> +	/*
> +	 * Changing the DIOREAD_NOLOCK or DELALLOC mount options may cause
> +	 * two calls to ext4_should_dioread_nolock() to return inconsistent
> +	 * values, triggering WARN_ON in ext4_add_complete_io(). we grab
> +	 * here s_writepages_rwsem to avoid race between writepages ops and
> +	 * remount.
> +	 */
> +	alloc_ctx = ext4_writepages_down_write(sb);
>  	ext4_apply_options(fc, sb);
> +	ext4_writepages_up_write(sb, alloc_ctx);
>  
>  	if ((old_opts.s_mount_opt & EXT4_MOUNT_JOURNAL_CHECKSUM) ^
>  	    test_opt(sb, JOURNAL_CHECKSUM)) {
> @@ -6650,6 +6660,8 @@ static int __ext4_remount(struct fs_context *fc, struct super_block *sb)
>  	if ((sb->s_flags & SB_RDONLY) && !(old_sb_flags & SB_RDONLY) &&
>  	    sb_any_quota_suspended(sb))
>  		dquot_resume(sb, -1);
> +
> +	alloc_ctx = ext4_writepages_down_write(sb);
>  	sb->s_flags = old_sb_flags;
>  	sbi->s_mount_opt = old_opts.s_mount_opt;
>  	sbi->s_mount_opt2 = old_opts.s_mount_opt2;
> @@ -6658,6 +6670,8 @@ static int __ext4_remount(struct fs_context *fc, struct super_block *sb)
>  	sbi->s_commit_interval = old_opts.s_commit_interval;
>  	sbi->s_min_batch_time = old_opts.s_min_batch_time;
>  	sbi->s_max_batch_time = old_opts.s_max_batch_time;
> +	ext4_writepages_up_write(sb, alloc_ctx);
> +
>  	if (!test_opt(sb, BLOCK_VALIDITY) && sbi->s_system_blks)
>  		ext4_release_system_zone(sb);
>  #ifdef CONFIG_QUOTA
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
