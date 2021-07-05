Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 806523BBC07
	for <lists+linux-ext4@lfdr.de>; Mon,  5 Jul 2021 13:15:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbhGELS0 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 5 Jul 2021 07:18:26 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:33032 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbhGELS0 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 5 Jul 2021 07:18:26 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 6A6051FE65;
        Mon,  5 Jul 2021 11:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1625483748; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sfatcCCgs2VzKb85jnyGEQBbLmIfD7PreoAG1YlqNFk=;
        b=PQVzYEp+afL1R2rEBmC6vacczbFpu0v1ftG1mZjKjm7QZc4UmytR6L9GBcJ7IDY4AJhPje
        gX2PtNcaisid5WSKglm5+b5K7ezcCURWRNvJ6XijdZb1K/hYTF5RSX5NSOenimpcsvWJKw
        zBNnurX83mGUSRhg7TCclyHhPlLqX38=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1625483748;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sfatcCCgs2VzKb85jnyGEQBbLmIfD7PreoAG1YlqNFk=;
        b=+Hco9BasUJWicWcLSmzR+NYSaV1ZugbrYz+X8WdRuZW87cwnVKVD9dZTou0fYqEyRuDe/F
        up1HoAxd3tY4V8CA==
Received: from quack2.suse.cz (unknown [10.163.43.118])
        by relay2.suse.de (Postfix) with ESMTP id 53F9CA3B8C;
        Mon,  5 Jul 2021 11:15:48 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 2A2341E1139; Mon,  5 Jul 2021 13:15:48 +0200 (CEST)
Date:   Mon, 5 Jul 2021 13:15:48 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ye Bin <yebin10@huawei.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        jack@suse.cz
Subject: Re: [PATCH 1/2] ext4: Fix use-after-free about sbi->s_mmp_tsk
Message-ID: <20210705111548.GD15373@quack2.suse.cz>
References: <20210629143603.2166962-1-yebin10@huawei.com>
 <20210629143603.2166962-2-yebin10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210629143603.2166962-2-yebin10@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue 29-06-21 22:36:02, Ye Bin wrote:
> After merge 618f003199c6("ext4: fix memory leak in ext4_fill_super") commit,
> we add delay in ext4_remount after "sb->s_flags |= SB_RDONLY", then
> remount filesystem with read-only kasan report following warning:
> [  888.695326] ==================================================================
> [  888.696566] BUG: KASAN: use-after-free in kthread_stop+0x4c/0x2f0
> [  888.697599] Write of size 4 at addr ffff8883849e0020 by task mount/2013
> [  888.698707]
> [  888.698982] CPU: 4 PID: 2013 Comm: mount Not tainted 4.19.95-00013-ga369a6189bbf-dirty #413
> [  888.700376] Hardware name: QEMU Standard PC
> [  888.702587] Call Trace:
> [  888.703017]  dump_stack+0x108/0x15f
> [  888.703615]  print_address_description+0xa5/0x372
> [  888.704420]  kasan_report.cold+0x236/0x2a8
> [  888.705761]  check_memory_region+0x240/0x270
> [  888.706486]  kasan_check_write+0x20/0x30
> [  888.707156]  kthread_stop+0x4c/0x2f0
> [  888.707776]  ext4_stop_mmpd+0x32/0x90
> [  888.708262]  ext4_remount.cold+0xf6/0x116
> [  888.712671]  do_remount_sb+0xff/0x460
> [  888.714007]  do_mount+0xce3/0x1be0
> [  888.717749]  ksys_mount+0xb2/0x150
> [  888.718163]  __x64_sys_mount+0x6a/0x80
> [  888.718607]  do_syscall_64+0xd9/0x1f0
> [  888.719047]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> As kmmpd will exit if filesystem is read-only. Then sbi->s_mmp_tsk become wild
> ptr, lead to use-after-free. As kmmpd will exit by others(call ktread_stop)
> or by itself. After 618f003199c6 commit we can trigger this issue very easy.
> Before this commit also exist this issue.
> If kmmpd exit by itself, after merge 618f003199c6 commit there will trigger UAF
> when umount filesystem.
> To fix this issue, introduce sbi->s_mmp_lock to protect sbi->s_mmp_tsk. If kmmpd
> exit by itself, we set sbi->s_mmp_tsk with NULL, and release mmp buffer_head.
> 
> Fixes: 618f003199c6 ("ext4: fix memory leak in ext4_fill_super")
> Signed-off-by: Ye Bin <yebin10@huawei.com>
> ---
>  fs/ext4/ext4.h  |  1 +
>  fs/ext4/mmp.c   | 24 ++++++++++++++++++++++--
>  fs/ext4/super.c |  1 +
>  3 files changed, 24 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 8d3446746718..a479da37fed4 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -1489,6 +1489,7 @@ struct ext4_sb_info {
>  	struct completion s_kobj_unregister;
>  	struct super_block *s_sb;
>  	struct buffer_head *s_mmp_bh;
> +	struct mutex s_mmp_lock;
>  
>  	/* Journaling */
>  	struct journal_s *s_journal;
> diff --git a/fs/ext4/mmp.c b/fs/ext4/mmp.c
> index 6cb598b549ca..fc18a8c205c7 100644
> --- a/fs/ext4/mmp.c
> +++ b/fs/ext4/mmp.c
> @@ -128,8 +128,9 @@ void __dump_mmp_msg(struct super_block *sb, struct mmp_struct *mmp,
>  static int kmmpd(void *data)
>  {
>  	struct super_block *sb = (struct super_block *) data;
> -	struct ext4_super_block *es = EXT4_SB(sb)->s_es;
> -	struct buffer_head *bh = EXT4_SB(sb)->s_mmp_bh;
> +	struct ext4_sb_info *sbi = EXT4_SB(sb);
> +	struct ext4_super_block *es = sbi->s_es;
> +	struct buffer_head *bh = sbi->s_mmp_bh;
>  	struct mmp_struct *mmp;
>  	ext4_fsblk_t mmp_block;
>  	u32 seq = 0;
> @@ -245,16 +246,35 @@ static int kmmpd(void *data)
>  	retval = write_mmp_block(sb, bh);
>  
>  exit_thread:
> +	/*
> +	 * Maybe s_mmp_tsk kthread is stoped by others or by itself. If exit
> +	 * by itself then sbi->s_mmp_tsk will be wild ptr, so there is need
> +	 * set sbi->s_mmp_tsk with NULL, and also release mmp buffer_head.
> +	 */
> +	while (!kthread_should_stop()) {
> +		if (!mutex_trylock(&sbi->s_mmp_lock))
> +			continue;
> +
> +		if (sbi->s_mmp_tsk) {
> +			sbi->s_mmp_tsk = NULL;
> +			brelse(bh);
> +		}
> +		mutex_unlock(&sbi->s_mmp_lock);
> +		break;
> +	}
> +
>  	return retval;
>  }

Honestly, this is just ugly. I think it would be saner if ext4_stop_mmpd()
did:

void ext4_stop_mmpd(struct ext4_sb_info *sbi)
{
	struct task_struct *tsk;

	mutex_lock(&sbi->s_mmp_lock);
	tsk = sbi->s_mmp_tsk;
	if (tsk) {
		sbi->s_mmp_tsk = NULL;
		get_task_struct(tsk);
	}
     	mutex_unlock(&sbi->s_mmp_lock);
	if (tsk) {
		kthread_stop(tsk);
		put_task_struct(k);
	}
}

And you leave freeing of 'bh' to exit path from kmmpd() which can also use
normal locking scheme for zeroing s_mmp_tsk now.

That being said for this scheme spinlock is enough, you don't need a mutex
for s_mmp_lock.

								Honza

>  void ext4_stop_mmpd(struct ext4_sb_info *sbi)
>  {
> +	mutex_lock(&sbi->s_mmp_lock);
>  	if (sbi->s_mmp_tsk) {
>  		kthread_stop(sbi->s_mmp_tsk);
>  		brelse(sbi->s_mmp_bh);
>  		sbi->s_mmp_tsk = NULL;
>  	}
> +	mutex_unlock(&sbi->s_mmp_lock);
>  }
>  
>  /*
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index c3942804b57f..5bc3230553fb 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -4786,6 +4786,7 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
>  	needs_recovery = (es->s_last_orphan != 0 ||
>  			  ext4_has_feature_journal_needs_recovery(sb));
>  
> +	mutex_init(&sbi->s_mmp_lock);
>  	if (ext4_has_feature_mmp(sb) && !sb_rdonly(sb))
>  		if (ext4_multi_mount_protect(sb, le64_to_cpu(es->s_mmp_block)))
>  			goto failed_mount3a;
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
