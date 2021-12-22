Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4769D47D3D0
	for <lists+linux-ext4@lfdr.de>; Wed, 22 Dec 2021 15:38:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343496AbhLVOh7 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 22 Dec 2021 09:37:59 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:54228 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238818AbhLVOh6 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 22 Dec 2021 09:37:58 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id C4AD6212B7;
        Wed, 22 Dec 2021 14:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1640183877; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gc7GULz8GdRORFE4g+VjvQfetQYn3CecFaan/rOImzU=;
        b=pp2MQa4g4afqeHnnbpstvRRU0/qWMlW3OK2cev8JBu+h0CU2G607lmDtWIKsVNc5MPiGlf
        UQYbLtLeBmrUAxD4kratrxEyvquGjz1GfnyYp2i/V7jM0BhhPl2n1Km6Hqp2GGdldC0qqR
        hD2XX1rjZZsYBlFXLZ+Ujjay4STNAgA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1640183877;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gc7GULz8GdRORFE4g+VjvQfetQYn3CecFaan/rOImzU=;
        b=E33r5WLDqBxz72e8y/vh9Rj8eAHM6hee0L1G3De5TXXGsSaRB+ut2Ly/Amuo1Ed0D7oG7w
        Kp9twdzYx7wOzdAg==
Received: from quack2.suse.cz (unknown [10.163.28.18])
        by relay2.suse.de (Postfix) with ESMTP id B0536A3B81;
        Wed, 22 Dec 2021 14:37:57 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 832E51F2CEF; Wed, 22 Dec 2021 15:37:57 +0100 (CET)
Date:   Wed, 22 Dec 2021 15:37:57 +0100
From:   Jan Kara <jack@suse.cz>
To:     Ye Bin <yebin10@huawei.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        jack@suse.cz
Subject: Re: [PATCH -next] ext4: Fix BUG_ON in ext4_bread when write quota
 data
Message-ID: <20211222143757.GD685@quack2.suse.cz>
References: <20211222013537.3096310-1-yebin10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211222013537.3096310-1-yebin10@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 22-12-21 09:35:37, Ye Bin wrote:
> We got issue as follows when run syzkaller:
> [  167.936972] EXT4-fs error (device loop0): __ext4_remount:6314: comm rep: Abort forced by user
> [  167.938306] EXT4-fs (loop0): Remounting filesystem read-only
> [  167.981637] Assertion failure in ext4_getblk() at fs/ext4/inode.c:847: '(EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY) || handle != NULL || create == 0'
> [  167.983601] ------------[ cut here ]------------
> [  167.984245] kernel BUG at fs/ext4/inode.c:847!
> [  167.984882] invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
> [  167.985624] CPU: 7 PID: 2290 Comm: rep Tainted: G    B             5.16.0-rc5-next-20211217+ #123
> [  167.986823] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS ?-20190727_073836-buildvm-ppc64le-16.ppc.fedoraproject.org-3.fc31 04/01/2014
> [  167.988590] RIP: 0010:ext4_getblk+0x17e/0x504
> [  167.989189] Code: c6 01 74 28 49 c7 c0 a0 a3 5c 9b b9 4f 03 00 00 48 c7 c2 80 9c 5c 9b 48 c7 c6 40 b6 5c 9b 48 c7 c7 20 a4 5c 9b e8 77 e3 fd ff <0f> 0b 8b 04 244
> [  167.991679] RSP: 0018:ffff8881736f7398 EFLAGS: 00010282
> [  167.992385] RAX: 0000000000000094 RBX: 1ffff1102e6dee75 RCX: 0000000000000000
> [  167.993337] RDX: 0000000000000001 RSI: ffffffff9b6e29e0 RDI: ffffed102e6dee66
> [  167.994292] RBP: ffff88816a076210 R08: 0000000000000094 R09: ffffed107363fa09
> [  167.995252] R10: ffff88839b1fd047 R11: ffffed107363fa08 R12: ffff88816a0761e8
> [  167.996205] R13: 0000000000000000 R14: 0000000000000021 R15: 0000000000000001
> [  167.997158] FS:  00007f6a1428c740(0000) GS:ffff88839b000000(0000) knlGS:0000000000000000
> [  167.998238] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  167.999025] CR2: 00007f6a140716c8 CR3: 0000000133216000 CR4: 00000000000006e0
> [  167.999987] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [  168.000944] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [  168.001899] Call Trace:
> [  168.002235]  <TASK>
> [  168.007167]  ext4_bread+0xd/0x53
> [  168.007612]  ext4_quota_write+0x20c/0x5c0
> [  168.010457]  write_blk+0x100/0x220
> [  168.010944]  remove_free_dqentry+0x1c6/0x440
> [  168.011525]  free_dqentry.isra.0+0x565/0x830
> [  168.012133]  remove_tree+0x318/0x6d0
> [  168.014744]  remove_tree+0x1eb/0x6d0
> [  168.017346]  remove_tree+0x1eb/0x6d0
> [  168.019969]  remove_tree+0x1eb/0x6d0
> [  168.022128]  qtree_release_dquot+0x291/0x340
> [  168.023297]  v2_release_dquot+0xce/0x120
> [  168.023847]  dquot_release+0x197/0x3e0
> [  168.024358]  ext4_release_dquot+0x22a/0x2d0
> [  168.024932]  dqput.part.0+0x1c9/0x900
> [  168.025430]  __dquot_drop+0x120/0x190
> [  168.025942]  ext4_clear_inode+0x86/0x220
> [  168.026472]  ext4_evict_inode+0x9e8/0xa22
> [  168.028200]  evict+0x29e/0x4f0
> [  168.028625]  dispose_list+0x102/0x1f0
> [  168.029148]  evict_inodes+0x2c1/0x3e0
> [  168.030188]  generic_shutdown_super+0xa4/0x3b0
> [  168.030817]  kill_block_super+0x95/0xd0
> [  168.031360]  deactivate_locked_super+0x85/0xd0
> [  168.031977]  cleanup_mnt+0x2bc/0x480
> [  168.033062]  task_work_run+0xd1/0x170
> [  168.033565]  do_exit+0xa4f/0x2b50
> [  168.037155]  do_group_exit+0xef/0x2d0
> [  168.037666]  __x64_sys_exit_group+0x3a/0x50
> [  168.038237]  do_syscall_64+0x3b/0x90
> [  168.038751]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> In order to reproduce this problem, the following conditions need to be met:
> 1. Ext4 filesystem with no journal;
> 2. Filesystem image with incorrect quota data;
> 3. Abort filesystem forced by user;
> 4. umount filesystem;
> 
> As in ext4_quota_write:
> ...
>          if (EXT4_SB(sb)->s_journal && !handle) {
>                  ext4_msg(sb, KERN_WARNING, "Quota write (off=%llu, len=%llu)"
>                          " cancelled because transaction is not started",
>                          (unsigned long long)off, (unsigned long long)len);
>                  return -EIO;
>          }
> ...
> We only check handle if NULL when filesystem has journal. There is need
> check handle if NULL even when filesystem has no journal.

Hum, so I think we can just drop this whole condition and warning and
instead add a silent return of -EROFS if the filesystem is readonly. That
should also fix the bug and also make aborted case less noisy. The message
from ext4_quota_write() IMO is not very useful and ext4_bread() will
provide us with a BUG and stacktrace which is better for debugging what
went wrong anyway.

								Honza

> 
> Signed-off-by: Ye Bin <yebin10@huawei.com>
> ---
>  fs/ext4/super.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 071b7b3c5678..c8ca5811ea65 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -6955,9 +6955,10 @@ static ssize_t ext4_quota_write(struct super_block *sb, int type,
>  	struct buffer_head *bh;
>  	handle_t *handle = journal_current_handle();
>  
> -	if (EXT4_SB(sb)->s_journal && !handle) {
> +	if (!handle) {
>  		ext4_msg(sb, KERN_WARNING, "Quota write (off=%llu, len=%llu)"
> -			" cancelled because transaction is not started",
> +			" cancelled because transaction is not started"
> +			" or filesystem is abort forced by user",
>  			(unsigned long long)off, (unsigned long long)len);
>  		return -EIO;
>  	}
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
