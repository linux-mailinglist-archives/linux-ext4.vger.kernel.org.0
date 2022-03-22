Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FCE74E3CF0
	for <lists+linux-ext4@lfdr.de>; Tue, 22 Mar 2022 11:49:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232859AbiCVKu3 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 22 Mar 2022 06:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231843AbiCVKu2 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 22 Mar 2022 06:50:28 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A5A7811BA;
        Tue, 22 Mar 2022 03:49:01 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id AA00C210F1;
        Tue, 22 Mar 2022 10:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1647946138; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0/MS6PTFwvGlMff+fmHo+wapCdTSqM2WuKx4kjihEQ8=;
        b=ZfLXpa9/tqS97W10ssQ0skDVsBjSAB/1cV3Ek5JsGuhhpq1QQb6Ra47mIr3JqBUvrq0/td
        Yu7F6S2P7ELd8+00xeqqsGb0S0xW7QxJepCI9d8hnACUGnRmXVX10ejVSWtM+k7RoBgU7m
        ay+/Gr1afpGP8qICEQz8iCZwNPQtdEY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1647946138;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0/MS6PTFwvGlMff+fmHo+wapCdTSqM2WuKx4kjihEQ8=;
        b=/A43+c8IpcqTZouKIxX2h47kT1r6+4qpeFL5cxmq842YCs1/2I1TVVNEK3wgIGo2AQ1uxi
        zBazoeg1K5ylpyCg==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 98986A3B88;
        Tue, 22 Mar 2022 10:48:58 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 4DC3DA0610; Tue, 22 Mar 2022 11:48:57 +0100 (CET)
Date:   Tue, 22 Mar 2022 11:48:57 +0100
From:   Jan Kara <jack@suse.cz>
To:     Ye Bin <yebin10@huawei.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        jack@suse.cz, lczerner@redhat.com
Subject: Re: [PATCH -next] ext4: fix bug_on in start_this_handle during
 umount filesystem
Message-ID: <20220322104857.ehiu3payojri4cmq@quack3.lan>
References: <20220322012419.725457-1-yebin10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220322012419.725457-1-yebin10@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue 22-03-22 09:24:19, Ye Bin wrote:
> We got issue as follows:
> ------------[ cut here ]------------
> kernel BUG at fs/jbd2/transaction.c:389!
> invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
> CPU: 9 PID: 131 Comm: kworker/9:1 Not tainted 5.17.0-862.14.0.6.x86_64-00001-g23f87daf7d74-dirty #197
> Workqueue: events flush_stashed_error_work
> RIP: 0010:start_this_handle+0x41c/0x1160
> RSP: 0018:ffff888106b47c20 EFLAGS: 00010202
> RAX: ffffed10251b8400 RBX: ffff888128dc204c RCX: ffffffffb52972ac
> RDX: 0000000000000200 RSI: 0000000000000004 RDI: ffff888128dc2050
> RBP: 0000000000000039 R08: 0000000000000001 R09: ffffed10251b840a
> R10: ffff888128dc204f R11: ffffed10251b8409 R12: ffff888116d78000
> R13: 0000000000000000 R14: dffffc0000000000 R15: ffff888128dc2000
> FS:  0000000000000000(0000) GS:ffff88839d680000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000001620068 CR3: 0000000376c0e000 CR4: 00000000000006e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  jbd2__journal_start+0x38a/0x790
>  jbd2_journal_start+0x19/0x20
>  flush_stashed_error_work+0x110/0x2b3
>  process_one_work+0x688/0x1080
>  worker_thread+0x8b/0xc50
>  kthread+0x26f/0x310
>  ret_from_fork+0x22/0x30
>  </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> 
> Above issue may happen as follows:
>       umount            read procfs            error_work
> ext4_put_super
>   flush_work(&sbi->s_error_work);
> 
>                       ext4_mb_seq_groups_show
> 	                ext4_mb_load_buddy_gfp
> 			  ext4_mb_init_group
> 			    ext4_mb_init_cache
> 	                      ext4_read_block_bitmap_nowait
> 			        ext4_validate_block_bitmap
> 				  ext4_error
> 			            ext4_handle_error
> 			              schedule_work(&EXT4_SB(sb)->s_error_work);
> 
>   ext4_unregister_sysfs(sb);
>   jbd2_journal_destroy(sbi->s_journal);
>     journal_kill_thread
>       journal->j_flags |= JBD2_UNMOUNT;
> 
>                                           flush_stashed_error_work
> 				            jbd2_journal_start
> 					      start_this_handle
> 					        BUG_ON(journal->j_flags & JBD2_UNMOUNT);
> 
> To solve this issue, we call 'ext4_unregister_sysfs' in 'ext4_put_super' firstly
> like 'ext4_fill_super' error handle.
> 
> Signed-off-by: Ye Bin <yebin10@huawei.com>

Looks good. Thanks! Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/super.c | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 81749eaddf4c..a673012e35c8 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -1199,20 +1199,25 @@ static void ext4_put_super(struct super_block *sb)
>  	int aborted = 0;
>  	int i, err;
>  
> -	ext4_unregister_li_request(sb);
> -	ext4_quota_off_umount(sb);
> -
> -	flush_work(&sbi->s_error_work);
> -	destroy_workqueue(sbi->rsv_conversion_wq);
> -	ext4_release_orphan_info(sb);
> -
>  	/*
>  	 * Unregister sysfs before destroying jbd2 journal.
>  	 * Since we could still access attr_journal_task attribute via sysfs
>  	 * path which could have sbi->s_journal->j_task as NULL
> +	 * Unregister sysfs before flush sbi->s_error_work.
> +	 * Since user may read /proc/fs/ext4/xx/mb_groups during umount, If
> +	 * read metadata verify failed then will queue error work.
> +	 * flush_stashed_error_work will call start_this_handle may trigger
> +	 * BUG_ON.
>  	 */
>  	ext4_unregister_sysfs(sb);
>  
> +	ext4_unregister_li_request(sb);
> +	ext4_quota_off_umount(sb);
> +
> +	flush_work(&sbi->s_error_work);
> +	destroy_workqueue(sbi->rsv_conversion_wq);
> +	ext4_release_orphan_info(sb);
> +
>  	if (sbi->s_journal) {
>  		aborted = is_journal_aborted(sbi->s_journal);
>  		err = jbd2_journal_destroy(sbi->s_journal);
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
