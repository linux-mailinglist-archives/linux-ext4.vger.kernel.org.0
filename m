Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5661F23D1B6
	for <lists+linux-ext4@lfdr.de>; Wed,  5 Aug 2020 22:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727884AbgHEUFl (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 5 Aug 2020 16:05:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:58434 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727793AbgHEQf6 (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 5 Aug 2020 12:35:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3617EB5FD;
        Wed,  5 Aug 2020 14:16:40 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 54C291E12CB; Wed,  5 Aug 2020 16:16:23 +0200 (CEST)
Date:   Wed, 5 Aug 2020 16:16:23 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org, Lukas Czerner <lczerner@redhat.com>,
        Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v3] ext4: don't BUG on inconsistent journal feature
Message-ID: <20200805141623.GC16475@quack2.suse.cz>
References: <20200710140759.18031-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200710140759.18031-1-jack@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri 10-07-20 16:07:59, Jan Kara wrote:
> A customer has reported a BUG_ON in ext4_clear_journal_err() hitting
> during an LTP testing. Either this has been caused by a test setup
> issue where the filesystem was being overwritten while LTP was mounting
> it or the journal replay has overwritten the superblock with invalid
> data. In either case it is preferable we don't take the machine down
> with a BUG_ON. So handle the situation of unexpectedly missing
> has_journal feature more gracefully. We issue warning and fail the mount
> in the cases where the race window is narrow and the failed check is
> most likely a programming error. In cases where fs corruption is more
> likely, we do full ext4_error() handling before failing mount / remount.
> 
> Reviewed-by: Lukas Czerner <lczerner@redhat.com>
> Signed-off-by: Jan Kara <jack@suse.cz>

Ted, can you please pick up this patch? Thanks!

								Honza

> ---
>  fs/ext4/super.c | 68 +++++++++++++++++++++++++++++++++++++++------------------
>  1 file changed, 47 insertions(+), 21 deletions(-)
> 
> Changes since v2:
> - added Reviewed-by tag
> - fixup compilation failure without CONFIG_QUOTA
> 
> Changes since v1:
> - handle failures more likely coming from fs corruption as with ext4_error
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 330957ed1f05..9fdad843b30e 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -66,10 +66,10 @@ static int ext4_load_journal(struct super_block *, struct ext4_super_block *,
>  			     unsigned long journal_devnum);
>  static int ext4_show_options(struct seq_file *seq, struct dentry *root);
>  static int ext4_commit_super(struct super_block *sb, int sync);
> -static void ext4_mark_recovery_complete(struct super_block *sb,
> +static int ext4_mark_recovery_complete(struct super_block *sb,
>  					struct ext4_super_block *es);
> -static void ext4_clear_journal_err(struct super_block *sb,
> -				   struct ext4_super_block *es);
> +static int ext4_clear_journal_err(struct super_block *sb,
> +				  struct ext4_super_block *es);
>  static int ext4_sync_fs(struct super_block *sb, int wait);
>  static int ext4_remount(struct super_block *sb, int *flags, char *data);
>  static int ext4_statfs(struct dentry *dentry, struct kstatfs *buf);
> @@ -4770,7 +4770,9 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
>  	EXT4_SB(sb)->s_mount_state &= ~EXT4_ORPHAN_FS;
>  	if (needs_recovery) {
>  		ext4_msg(sb, KERN_INFO, "recovery complete");
> -		ext4_mark_recovery_complete(sb, es);
> +		err = ext4_mark_recovery_complete(sb, es);
> +		if (err)
> +			goto failed_mount8;
>  	}
>  	if (EXT4_SB(sb)->s_journal) {
>  		if (test_opt(sb, DATA_FLAGS) == EXT4_MOUNT_JOURNAL_DATA)
> @@ -4813,10 +4815,8 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
>  		ext4_msg(sb, KERN_ERR, "VFS: Can't find ext4 filesystem");
>  	goto failed_mount;
>  
> -#ifdef CONFIG_QUOTA
>  failed_mount8:
>  	ext4_unregister_sysfs(sb);
> -#endif
>  failed_mount7:
>  	ext4_unregister_li_request(sb);
>  failed_mount6:
> @@ -4956,7 +4956,8 @@ static journal_t *ext4_get_journal(struct super_block *sb,
>  	struct inode *journal_inode;
>  	journal_t *journal;
>  
> -	BUG_ON(!ext4_has_feature_journal(sb));
> +	if (WARN_ON_ONCE(!ext4_has_feature_journal(sb)))
> +		return NULL;
>  
>  	journal_inode = ext4_get_journal_inode(sb, journal_inum);
>  	if (!journal_inode)
> @@ -4986,7 +4987,8 @@ static journal_t *ext4_get_dev_journal(struct super_block *sb,
>  	struct ext4_super_block *es;
>  	struct block_device *bdev;
>  
> -	BUG_ON(!ext4_has_feature_journal(sb));
> +	if (WARN_ON_ONCE(!ext4_has_feature_journal(sb)))
> +		return NULL;
>  
>  	bdev = ext4_blkdev_get(j_dev, sb);
>  	if (bdev == NULL)
> @@ -5078,7 +5080,8 @@ static int ext4_load_journal(struct super_block *sb,
>  	int err = 0;
>  	int really_read_only;
>  
> -	BUG_ON(!ext4_has_feature_journal(sb));
> +	if (WARN_ON_ONCE(!ext4_has_feature_journal(sb)))
> +		return -EFSCORRUPTED;
>  
>  	if (journal_devnum &&
>  	    journal_devnum != le32_to_cpu(es->s_journal_dev)) {
> @@ -5148,7 +5151,12 @@ static int ext4_load_journal(struct super_block *sb,
>  	}
>  
>  	EXT4_SB(sb)->s_journal = journal;
> -	ext4_clear_journal_err(sb, es);
> +	err = ext4_clear_journal_err(sb, es);
> +	if (err) {
> +		EXT4_SB(sb)->s_journal = NULL;
> +		jbd2_journal_destroy(journal);
> +		return err;
> +	}
>  
>  	if (!really_read_only && journal_devnum &&
>  	    journal_devnum != le32_to_cpu(es->s_journal_dev)) {
> @@ -5244,26 +5252,32 @@ static int ext4_commit_super(struct super_block *sb, int sync)
>   * remounting) the filesystem readonly, then we will end up with a
>   * consistent fs on disk.  Record that fact.
>   */
> -static void ext4_mark_recovery_complete(struct super_block *sb,
> -					struct ext4_super_block *es)
> +static int ext4_mark_recovery_complete(struct super_block *sb,
> +				       struct ext4_super_block *es)
>  {
> +	int err;
>  	journal_t *journal = EXT4_SB(sb)->s_journal;
>  
>  	if (!ext4_has_feature_journal(sb)) {
> -		BUG_ON(journal != NULL);
> -		return;
> +		if (journal != NULL) {
> +			ext4_error(sb, "Journal got removed while the fs was "
> +				   "mounted!");
> +			return -EFSCORRUPTED;
> +		}
> +		return 0;
>  	}
>  	jbd2_journal_lock_updates(journal);
> -	if (jbd2_journal_flush(journal) < 0)
> +	err = jbd2_journal_flush(journal);
> +	if (err < 0)
>  		goto out;
>  
>  	if (ext4_has_feature_journal_needs_recovery(sb) && sb_rdonly(sb)) {
>  		ext4_clear_feature_journal_needs_recovery(sb);
>  		ext4_commit_super(sb, 1);
>  	}
> -
>  out:
>  	jbd2_journal_unlock_updates(journal);
> +	return err;
>  }
>  
>  /*
> @@ -5271,14 +5285,17 @@ static void ext4_mark_recovery_complete(struct super_block *sb,
>   * has recorded an error from a previous lifetime, move that error to the
>   * main filesystem now.
>   */
> -static void ext4_clear_journal_err(struct super_block *sb,
> +static int ext4_clear_journal_err(struct super_block *sb,
>  				   struct ext4_super_block *es)
>  {
>  	journal_t *journal;
>  	int j_errno;
>  	const char *errstr;
>  
> -	BUG_ON(!ext4_has_feature_journal(sb));
> +	if (!ext4_has_feature_journal(sb)) {
> +		ext4_error(sb, "Journal got removed while the fs was mounted!");
> +		return -EFSCORRUPTED;
> +	}
>  
>  	journal = EXT4_SB(sb)->s_journal;
>  
> @@ -5303,6 +5320,7 @@ static void ext4_clear_journal_err(struct super_block *sb,
>  		jbd2_journal_clear_err(journal);
>  		jbd2_journal_update_sb_errno(journal);
>  	}
> +	return 0;
>  }
>  
>  /*
> @@ -5573,8 +5591,13 @@ static int ext4_remount(struct super_block *sb, int *flags, char *data)
>  			    (sbi->s_mount_state & EXT4_VALID_FS))
>  				es->s_state = cpu_to_le16(sbi->s_mount_state);
>  
> -			if (sbi->s_journal)
> +			if (sbi->s_journal) {
> +				/*
> +				 * We let remount-ro finish even if marking fs
> +				 * as clean failed...
> +				 */
>  				ext4_mark_recovery_complete(sb, es);
> +			}
>  			if (sbi->s_mmp_tsk)
>  				kthread_stop(sbi->s_mmp_tsk);
>  		} else {
> @@ -5622,8 +5645,11 @@ static int ext4_remount(struct super_block *sb, int *flags, char *data)
>  			 * been changed by e2fsck since we originally mounted
>  			 * the partition.)
>  			 */
> -			if (sbi->s_journal)
> -				ext4_clear_journal_err(sb, es);
> +			if (sbi->s_journal) {
> +				err = ext4_clear_journal_err(sb, es);
> +				if (err)
> +					goto restore_opts;
> +			}
>  			sbi->s_mount_state = le16_to_cpu(es->s_state);
>  
>  			err = ext4_setup_super(sb, es, 0);
> -- 
> 2.16.4
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
