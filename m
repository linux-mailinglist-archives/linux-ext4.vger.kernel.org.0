Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEB19349D42
	for <lists+linux-ext4@lfdr.de>; Fri, 26 Mar 2021 01:06:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbhCZAGG (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 25 Mar 2021 20:06:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:60468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230115AbhCZAFh (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 25 Mar 2021 20:05:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B3D8C619F8;
        Fri, 26 Mar 2021 00:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616717136;
        bh=QKX6D1rP7KdDL6NWeCJIYk/jnqb0OgVTY2O2AurvNws=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SWWjsRC7hWIRshPNzC2jtBtioHHNihJf9iJuqtu6nNlSZlIBpD4ks7zZ/qN5pWM0z
         pCp6eN2jO5VYGfFbYiICXTbigSYVMU9yeY9qCM1QlT+8l1nrlPJOr0Mry4jXaCCQTK
         w5aLxA2t9/RJ0pzSikGQnirq9w8pH5HYDW9XnUsk/Bb2wc/gmVK7PweY0anf98wdB9
         Re1SquY/Q+vLgQf9da3WDOKuTwMpU0yJ7CSTfxY31ik7auoUXuvDwGU184rAmE668j
         hL7FWkpEeocapn/HlKfjsHp/wlXvMnOYQ5WogggwA62kZlANuwjpDOW9oL+6AAdzzj
         R8GI/oBxRaKlw==
Date:   Thu, 25 Mar 2021 17:05:36 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Leah Rumancik <leah.rumancik@gmail.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu
Subject: Re: [PATCH 1/2] ext4: wipe filename upon file deletion
Message-ID: <20210326000536.GA22091@magnolia>
References: <20210325181220.1118705-1-leah.rumancik@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210325181220.1118705-1-leah.rumancik@gmail.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Mar 25, 2021 at 06:12:19PM +0000, Leah Rumancik wrote:
> Zero out filename field when file is deleted. Also, add mount option
> nowipe_filename to disable this filename wipeout if desired.
> 
> Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>

I'm totally cribbing off of the previous decade's dirname wipe patch[1].

[1] https://lore.kernel.org/linux-ext4/1309468923-5677-1-git-send-email-achender@linux.vnet.ibm.com/T/#ma0442145ca50bb6e62f8e3502d607c758dd24418

> ---
>  fs/ext4/ext4.h  |  1 +
>  fs/ext4/namei.c |  4 ++++
>  fs/ext4/super.c | 11 ++++++++++-
>  3 files changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 826a56e3bbd2..8011418176bc 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -1247,6 +1247,7 @@ struct ext4_inode_info {
>  #define EXT4_MOUNT2_JOURNAL_FAST_COMMIT	0x00000010 /* Journal fast commit */
>  #define EXT4_MOUNT2_DAX_NEVER		0x00000020 /* Do not allow Direct Access */
>  #define EXT4_MOUNT2_DAX_INODE		0x00000040 /* For printing options only */
> +#define EXT4_MOUNT2_WIPE_FILENAME       0x00000080 /* Wipe filename on del entry */
>  
>  
>  #define clear_opt(sb, opt)		EXT4_SB(sb)->s_mount_opt &= \
> diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
> index 883e2a7cd4ab..ae6ecabd4d97 100644
> --- a/fs/ext4/namei.c
> +++ b/fs/ext4/namei.c
> @@ -2492,6 +2492,10 @@ int ext4_generic_delete_entry(struct inode *dir,
>  			else
>  				de->inode = 0;
>  			inode_inc_iversion(dir);
> +
> +			if (test_opt2(dir->i_sb, WIPE_FILENAME))
> +				memset(de_del->name, 0, de_del->name_len);

You probably ought to erase the file type information too.

> +
>  			return 0;
>  		}
>  		i += ext4_rec_len_from_disk(de->rec_len, blocksize);
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index b9693680463a..5e8737b3f171 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -1688,7 +1688,7 @@ enum {
>  	Opt_dioread_nolock, Opt_dioread_lock,
>  	Opt_discard, Opt_nodiscard, Opt_init_itable, Opt_noinit_itable,
>  	Opt_max_dir_size_kb, Opt_nojournal_checksum, Opt_nombcache,
> -	Opt_prefetch_block_bitmaps,
> +	Opt_prefetch_block_bitmaps, Opt_nowipe_filename,
>  #ifdef CONFIG_EXT4_DEBUG
>  	Opt_fc_debug_max_replay, Opt_fc_debug_force
>  #endif
> @@ -1787,6 +1787,7 @@ static const match_table_t tokens = {
>  	{Opt_test_dummy_encryption, "test_dummy_encryption"},
>  	{Opt_inlinecrypt, "inlinecrypt"},
>  	{Opt_nombcache, "nombcache"},
> +	{Opt_nowipe_filename, "nowipe_filename"},
>  	{Opt_nombcache, "no_mbcache"},	/* for backward compatibility */
>  	{Opt_prefetch_block_bitmaps, "prefetch_block_bitmaps"},
>  	{Opt_removed, "check=none"},	/* mount option from ext2/3 */
> @@ -2007,6 +2008,8 @@ static const struct mount_opts {
>  	{Opt_max_dir_size_kb, 0, MOPT_GTE0},
>  	{Opt_test_dummy_encryption, 0, MOPT_STRING},
>  	{Opt_nombcache, EXT4_MOUNT_NO_MBCACHE, MOPT_SET},
> +	{Opt_nowipe_filename, EXT4_MOUNT2_WIPE_FILENAME, MOPT_CLEAR | MOPT_2 |
> +		MOPT_EXT4_ONLY},
>  	{Opt_prefetch_block_bitmaps, EXT4_MOUNT_PREFETCH_BLOCK_BITMAPS,
>  	 MOPT_SET},
>  #ifdef CONFIG_EXT4_DEBUG
> @@ -2621,6 +2624,10 @@ static int _ext4_show_options(struct seq_file *seq, struct super_block *sb,
>  	} else if (test_opt2(sb, DAX_INODE)) {
>  		SEQ_OPTS_PUTS("dax=inode");
>  	}
> +
> +	if (!test_opt2(sb, WIPE_FILENAME))
> +		SEQ_OPTS_PUTS("nowipe_filename");

Interesting how this time around it's a mount option...

At the risk of dredging up bad old memories, any chance you'd want to
select this if the file being unlinked has EXT4_SECRM_FL set?

Also, uh, I guess this is a change in default behavior?  Now you have to
opt-out of wiping filenames?  I suppose it's not a big deal
performance-wise since we're logging and writing buffers to disk anyway,
but I bet there's at last a few people who have recovered accidental
deltree invocations this way...

--D

> +
>  	ext4_show_quota_options(seq, sb);
>  	return 0;
>  }
> @@ -4161,6 +4168,8 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
>  	if (def_mount_opts & EXT4_DEFM_DISCARD)
>  		set_opt(sb, DISCARD);
>  
> +	set_opt2(sb, WIPE_FILENAME);
> +
>  	sbi->s_resuid = make_kuid(&init_user_ns, le16_to_cpu(es->s_def_resuid));
>  	sbi->s_resgid = make_kgid(&init_user_ns, le16_to_cpu(es->s_def_resgid));
>  	sbi->s_commit_interval = JBD2_DEFAULT_MAX_COMMIT_AGE * HZ;
> -- 
> 2.31.0.291.g576ba9dcdaf-goog
> 
