Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5357A35746B
	for <lists+linux-ext4@lfdr.de>; Wed,  7 Apr 2021 20:35:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355364AbhDGSgA (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 7 Apr 2021 14:36:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:37118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1355362AbhDGSf6 (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 7 Apr 2021 14:35:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A0919611BD;
        Wed,  7 Apr 2021 18:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617820548;
        bh=9j6grNjJvAHr+7D91Ku5nhCdhP0V8roln1AJVIVczhM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Mvh/4X82sQbhcPxPw6hjiISySE9sdHqC7/3iIxMAc1IMX0UP4bOQ0C8p5TpzOQ4WD
         OAqADmMGet9xyGmmgZOkgNdZ6mk84VYSS+57PErNoTciDzzmiLBHiKIiAV8WA4E3sN
         Zs+fjOo8QkLsLizpKLiLICYkVMCjschRJzLPVH3FAiAyPOuPvp85PVg6w2FBIB+k8L
         5jEAiZvNtFxWAerr06BVsaEbnQ6SHfM3/KEV5vxLrBQELuGUVThdKS1rFoRzOZFpiv
         1+8GBpCHPmoM2tS0hPXkUzOpiKvt+vjZxh66JG4Ea7+LqI5LoGLfPzkKYeSWyFswxa
         C9cRHuHTQuGlQ==
Date:   Wed, 7 Apr 2021 11:35:47 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Leah Rumancik <leah.rumancik@gmail.com>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH v2 2/2] ext4: add ioctl FS_IOC_CHKPT_JRNL
Message-ID: <20210407183547.GG22091@magnolia>
References: <20210407154202.1527941-1-leah.rumancik@gmail.com>
 <20210407154202.1527941-3-leah.rumancik@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210407154202.1527941-3-leah.rumancik@gmail.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Apr 07, 2021 at 03:42:02PM +0000, Leah Rumancik wrote:
> ioctl FS_IOC_CHKPT_JRNL checkpoints and flushes the journal. With the
> CHKPT_JRNL_DISCARD flag set, the journal blocks are also discarded.
> With the filename wipeout patch, Ext4 guarantees that all data will be
> discarded on deletion. This ioctl allows for periodically discarding
> journal contents too.

This needs a documentation update to cover what this new userspace ABI
does, and probably linux-api and linux-fsdevel should be cc'd.

> Also, add journal discard (if discard supported) during journal load
> after recovery. This provides a potential solution to
> https://lore.kernel.org/linux-ext4/YDZoaacIYStFQT8g@mit.edu/ for
> disks that support discard. After a successful journal recovery, e2fsck
> can call this ioctl to discard the journal as well.
> 
> Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
> ---
>  fs/ext4/ext4.h          |   1 +
>  fs/ext4/inode.c         |   4 +-
>  fs/ext4/ioctl.c         |  34 ++++++++++++--
>  fs/ext4/super.c         |   6 +--
>  fs/jbd2/journal.c       | 100 +++++++++++++++++++++++++++++++++++++++-
>  fs/ocfs2/alloc.c        |   2 +-
>  fs/ocfs2/journal.c      |   8 ++--
>  include/linux/jbd2.h    |   5 +-
>  include/uapi/linux/fs.h |   4 ++
>  9 files changed, 148 insertions(+), 16 deletions(-)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 826a56e3bbd2..e76e9961e992 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -724,6 +724,7 @@ enum {
>  #define EXT4_IOC_CLEAR_ES_CACHE		_IO('f', 40)
>  #define EXT4_IOC_GETSTATE		_IOW('f', 41, __u32)
>  #define EXT4_IOC_GET_ES_CACHE		_IOWR('f', 42, struct fiemap)
> +/* ioctl code 43 reserved for FS_IOC_JRNL_CHKPT */

Pat Sajak hates it when people won't buy vowels. ;)

FS_IOC_CHECKPOINT, maybe?

>  
>  #define EXT4_IOC_SHUTDOWN _IOR ('X', 125, __u32)
>  
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 0948a43f1b3d..715077e30c58 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -3225,7 +3225,7 @@ static sector_t ext4_bmap(struct address_space *mapping, sector_t block)
>  		ext4_clear_inode_state(inode, EXT4_STATE_JDATA);
>  		journal = EXT4_JOURNAL(inode);
>  		jbd2_journal_lock_updates(journal);
> -		err = jbd2_journal_flush(journal);
> +		err = jbd2_journal_flush(journal, 0);
>  		jbd2_journal_unlock_updates(journal);
>  
>  		if (err)
> @@ -6007,7 +6007,7 @@ int ext4_change_inode_journal_flag(struct inode *inode, int val)
>  	if (val)
>  		ext4_set_inode_flag(inode, EXT4_INODE_JOURNAL_DATA);
>  	else {
> -		err = jbd2_journal_flush(journal);
> +		err = jbd2_journal_flush(journal, 0);
>  		if (err < 0) {
>  			jbd2_journal_unlock_updates(journal);
>  			percpu_up_write(&sbi->s_writepages_rwsem);
> diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
> index a2cf35066f46..ca64c680ef6d 100644
> --- a/fs/ext4/ioctl.c
> +++ b/fs/ext4/ioctl.c
> @@ -756,7 +756,7 @@ static long ext4_ioctl_group_add(struct file *file,
>  	err = ext4_group_add(sb, input);
>  	if (EXT4_SB(sb)->s_journal) {
>  		jbd2_journal_lock_updates(EXT4_SB(sb)->s_journal);
> -		err2 = jbd2_journal_flush(EXT4_SB(sb)->s_journal);
> +		err2 = jbd2_journal_flush(EXT4_SB(sb)->s_journal, 0);
>  		jbd2_journal_unlock_updates(EXT4_SB(sb)->s_journal);
>  	}
>  	if (err == 0)
> @@ -939,7 +939,7 @@ static long __ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>  		err = ext4_group_extend(sb, EXT4_SB(sb)->s_es, n_blocks_count);
>  		if (EXT4_SB(sb)->s_journal) {
>  			jbd2_journal_lock_updates(EXT4_SB(sb)->s_journal);
> -			err2 = jbd2_journal_flush(EXT4_SB(sb)->s_journal);
> +			err2 = jbd2_journal_flush(EXT4_SB(sb)->s_journal, 0);
>  			jbd2_journal_unlock_updates(EXT4_SB(sb)->s_journal);
>  		}
>  		if (err == 0)
> @@ -1082,7 +1082,7 @@ static long __ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>  		if (EXT4_SB(sb)->s_journal) {
>  			ext4_fc_mark_ineligible(sb, EXT4_FC_REASON_RESIZE);
>  			jbd2_journal_lock_updates(EXT4_SB(sb)->s_journal);
> -			err2 = jbd2_journal_flush(EXT4_SB(sb)->s_journal);
> +			err2 = jbd2_journal_flush(EXT4_SB(sb)->s_journal, 0);
>  			jbd2_journal_unlock_updates(EXT4_SB(sb)->s_journal);
>  		}
>  		if (err == 0)
> @@ -1318,6 +1318,33 @@ static long __ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>  			return -EOPNOTSUPP;
>  		return fsverity_ioctl_read_metadata(filp,
>  						    (const void __user *)arg);
> +	case FS_IOC_CHKPT_JRNL:
> +	{

Should this whole block be a separate static function?

> +		int err = 0;
> +		unsigned long long flags = 0;
> +
> +		if (!capable(CAP_SYS_ADMIN))
> +			return -EPERM;
> +
> +		/* file argument is not the mount point */
> +		if (file_dentry(filp) != sb->s_root)
> +			return -EINVAL;
> +
> +		/* filesystem is not backed by block device */
> +		if (sb->s_bdev == NULL)
> +			return -EINVAL;
> +
> +		if (copy_from_user(&flags, (__u64 __user *)arg,
> +					sizeof(__u64)))
> +			return -EFAULT;

Needs a check here to return -EINVAL if any flags bits are set other
than CHKPT_JRNL_DO_DISCARD, particularly since you're feeding flags
straight into jbd2 code.

FWIW I would also separate the changes into two patches -- one to
add the flags paramter to jbd2_journal_flush, and a second patch to
define the new ioctl and wire it up.

> +
> +		if (EXT4_SB(sb)->s_journal) {
> +			jbd2_journal_lock_updates(EXT4_SB(sb)->s_journal);
> +			err = jbd2_journal_flush(EXT4_SB(sb)->s_journal, flags);
> +			jbd2_journal_unlock_updates(EXT4_SB(sb)->s_journal);
> +		}
> +		return err;
> +	}
>  
>  	default:
>  		return -ENOTTY;
> @@ -1407,6 +1434,7 @@ long ext4_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
>  	case EXT4_IOC_GET_ES_CACHE:
>  	case FS_IOC_FSGETXATTR:
>  	case FS_IOC_FSSETXATTR:
> +	case FS_IOC_CHKPT_JRNL:
>  		break;
>  	default:
>  		return -ENOIOCTLCMD;
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index b9693680463a..1b3a9eb58b63 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -5613,7 +5613,7 @@ static int ext4_mark_recovery_complete(struct super_block *sb,
>  		return 0;
>  	}
>  	jbd2_journal_lock_updates(journal);
> -	err = jbd2_journal_flush(journal);
> +	err = jbd2_journal_flush(journal, 0);
>  	if (err < 0)
>  		goto out;
>  
> @@ -5755,7 +5755,7 @@ static int ext4_freeze(struct super_block *sb)
>  		 * Don't clear the needs_recovery flag if we failed to
>  		 * flush the journal.
>  		 */
> -		error = jbd2_journal_flush(journal);
> +		error = jbd2_journal_flush(journal, 0);
>  		if (error < 0)
>  			goto out;
>  
> @@ -6349,7 +6349,7 @@ static int ext4_quota_on(struct super_block *sb, int type, int format_id,
>  		 * otherwise be livelocked...
>  		 */
>  		jbd2_journal_lock_updates(EXT4_SB(sb)->s_journal);
> -		err = jbd2_journal_flush(EXT4_SB(sb)->s_journal);
> +		err = jbd2_journal_flush(EXT4_SB(sb)->s_journal, 0);
>  		jbd2_journal_unlock_updates(EXT4_SB(sb)->s_journal);
>  		if (err)
>  			return err;
> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> index 2dc944442802..6bb5980ac789 100644
> --- a/fs/jbd2/journal.c
> +++ b/fs/jbd2/journal.c
> @@ -1686,6 +1686,90 @@ static void jbd2_mark_journal_empty(journal_t *journal, int write_op)
>  	write_unlock(&journal->j_state_lock);
>  }
>  
> +/* discard journal blocks excluding journal superblock */
> +static int __jbd2_journal_issue_discard(journal_t *journal)
> +{
> +	int err = 0;
> +	unsigned long block, log_offset; /* logical */
> +	unsigned long long phys_block, block_start, block_stop; /* physical */
> +	loff_t byte_start, byte_stop, byte_count;
> +	struct request_queue *q = bdev_get_queue(journal->j_dev);
> +
> +	if (!q)
> +		return -ENXIO;
> +
> +	if (!blk_queue_discard(q))
> +		return -EOPNOTSUPP;
> +
> +	/* lookup block mapping and issue discard for each contiguous region */
> +	log_offset = be32_to_cpu(journal->j_superblock->s_first);
> +
> +	err = jbd2_journal_bmap(journal, log_offset, &block_start);
> +	if (err) {
> +		printk(KERN_ERR "JBD2: bad block at offset %lu", log_offset);
> +		return err;
> +	}
> +
> +	/*
> +	 * use block_start - 1 to meet check for contiguous with previous region:
> +	 * phys_block == block_stop + 1
> +	 */
> +	block_stop = block_start - 1;
> +
> +	for (block = log_offset; block < journal->j_total_len; block++) {
> +		err = jbd2_journal_bmap(journal, block, &phys_block);
> +		if (err) {
> +			printk(KERN_ERR "JBD2: bad block at offset %lu", block);
> +			return err;
> +		}
> +
> +		/*
> +		 * if block is last block, update stopping point
> +		 * if not last block and
> +		 * block is contiguous with previous block, continue
> +		 */
> +		if (block == journal->j_total_len - 1)
> +			block_stop = phys_block;
> +		else if (phys_block == block_stop + 1) {
> +			block_stop++;
> +			continue;
> +		}
> +
> +		/*
> +		 * if not contiguous with prior physical block or this is last
> +		 * block of journal, take care of the region
> +		 */
> +		byte_start = block_start * journal->j_blocksize;
> +		byte_stop = block_stop * journal->j_blocksize;
> +		byte_count = (block_stop - block_start + 1) *
> +			journal->j_blocksize;
> +
> +		truncate_inode_pages_range(journal->j_dev->bd_inode->i_mapping,
> +			byte_start, byte_stop);
> +
> +		/*
> +		 * use blkdev_issue_discard instead of sb_issue_discard
> +		 * because superblock not yet populated when this is
> +		 * called during journal_load during mount process
> +		 */
> +		err = blkdev_issue_discard(journal->j_dev,
> +			byte_start >> SECTOR_SHIFT,
> +			byte_count >> SECTOR_SHIFT,
> +			GFP_NOFS, 0);
> +
> +		if (unlikely(err != 0)) {
> +			printk(KERN_ERR "JBD2: unable to discard "
> +				"journal at physical blocks %llu - %llu",
> +				block_start, block_stop);
> +			return err;
> +		}
> +
> +		block_start = phys_block;
> +		block_stop = phys_block;
> +	}
> +
> +	return blkdev_issue_flush(journal->j_dev);
> +}
>  
>  /**
>   * jbd2_journal_update_sb_errno() - Update error in the journal.
> @@ -1936,6 +2020,10 @@ int jbd2_journal_load(journal_t *journal)
>  	 */
>  	journal->j_flags &= ~JBD2_ABORT;
>  
> +	/* if journal device supports discard, discard journal blocks */
> +	if (__jbd2_journal_issue_discard(journal))
> +		printk(KERN_WARNING "JBD2: failed to discard journal when loading");

How badly do you need to log this?  The journal still works, right?
This is going to trigger on all the old spinning disks that don't
support discard.

> +
>  	/* OK, we've finished with the dynamic journal bits:
>  	 * reinitialise the dynamic contents of the superblock in memory
>  	 * and reset them on disk. */
> @@ -2246,13 +2334,17 @@ EXPORT_SYMBOL(jbd2_journal_clear_features);
>  /**
>   * jbd2_journal_flush() - Flush journal
>   * @journal: Journal to act on.
> + * @flags: options (see below)
>   *
>   * Flush all data for a given journal to disk and empty the journal.
>   * Filesystems can use this when remounting readonly to ensure that
>   * recovery does not need to happen on remount.
> + *
> + * flags:
> + * JBD2_FLAG_DO_DISCARD: also discard the journal blocks; if discard is not
> + *	supported on the device, returns err
>   */
> -
> -int jbd2_journal_flush(journal_t *journal)
> +int jbd2_journal_flush(journal_t *journal, unsigned long long flags)
>  {
>  	int err = 0;
>  	transaction_t *transaction = NULL;
> @@ -2306,6 +2398,10 @@ int jbd2_journal_flush(journal_t *journal)
>  	 * commits of data to the journal will restore the current
>  	 * s_start value. */
>  	jbd2_mark_journal_empty(journal, REQ_SYNC | REQ_FUA);
> +
> +	if (flags & JBD2_FLAG_DO_DISCARD)
> +		err = __jbd2_journal_issue_discard(journal);
> +
>  	mutex_unlock(&journal->j_checkpoint_mutex);
>  	write_lock(&journal->j_state_lock);
>  	J_ASSERT(!journal->j_running_transaction);
> diff --git a/fs/ocfs2/alloc.c b/fs/ocfs2/alloc.c
> index 78710788c237..1b41bf9f4a7e 100644
> --- a/fs/ocfs2/alloc.c
> +++ b/fs/ocfs2/alloc.c
> @@ -6020,7 +6020,7 @@ int __ocfs2_flush_truncate_log(struct ocfs2_super *osb)
>  	 * Then truncate log will be replayed resulting in cluster double free.
>  	 */
>  	jbd2_journal_lock_updates(journal->j_journal);
> -	status = jbd2_journal_flush(journal->j_journal);
> +	status = jbd2_journal_flush(journal->j_journal, 0);
>  	jbd2_journal_unlock_updates(journal->j_journal);
>  	if (status < 0) {
>  		mlog_errno(status);
> diff --git a/fs/ocfs2/journal.c b/fs/ocfs2/journal.c
> index db52e843002a..a1438548747e 100644
> --- a/fs/ocfs2/journal.c
> +++ b/fs/ocfs2/journal.c
> @@ -310,7 +310,7 @@ static int ocfs2_commit_cache(struct ocfs2_super *osb)
>  	}
>  
>  	jbd2_journal_lock_updates(journal->j_journal);
> -	status = jbd2_journal_flush(journal->j_journal);
> +	status = jbd2_journal_flush(journal->j_journal, 0);
>  	jbd2_journal_unlock_updates(journal->j_journal);
>  	if (status < 0) {
>  		up_write(&journal->j_trans_barrier);
> @@ -1002,7 +1002,7 @@ void ocfs2_journal_shutdown(struct ocfs2_super *osb)
>  
>  	if (ocfs2_mount_local(osb)) {
>  		jbd2_journal_lock_updates(journal->j_journal);
> -		status = jbd2_journal_flush(journal->j_journal);
> +		status = jbd2_journal_flush(journal->j_journal, 0);
>  		jbd2_journal_unlock_updates(journal->j_journal);
>  		if (status < 0)
>  			mlog_errno(status);
> @@ -1072,7 +1072,7 @@ int ocfs2_journal_load(struct ocfs2_journal *journal, int local, int replayed)
>  
>  	if (replayed) {
>  		jbd2_journal_lock_updates(journal->j_journal);
> -		status = jbd2_journal_flush(journal->j_journal);
> +		status = jbd2_journal_flush(journal->j_journal, 0);
>  		jbd2_journal_unlock_updates(journal->j_journal);
>  		if (status < 0)
>  			mlog_errno(status);
> @@ -1668,7 +1668,7 @@ static int ocfs2_replay_journal(struct ocfs2_super *osb,
>  
>  	/* wipe the journal */
>  	jbd2_journal_lock_updates(journal);
> -	status = jbd2_journal_flush(journal);
> +	status = jbd2_journal_flush(journal, 0);
>  	jbd2_journal_unlock_updates(journal);
>  	if (status < 0)
>  		mlog_errno(status);
> diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
> index 99d3cd051ac3..50510473283e 100644
> --- a/include/linux/jbd2.h
> +++ b/include/linux/jbd2.h
> @@ -307,6 +307,9 @@ typedef struct journal_superblock_s
>  					JBD2_FEATURE_INCOMPAT_CSUM_V3 | \
>  					JBD2_FEATURE_INCOMPAT_FAST_COMMIT)
>  
> +/* discard journal blocks flag for jbd2_journal_flush */
> +#define JBD2_FLAG_DO_DISCARD		1
> +
>  #ifdef __KERNEL__
>  
>  #include <linux/fs.h>
> @@ -1491,7 +1494,7 @@ extern int	 jbd2_journal_invalidatepage(journal_t *,
>  				struct page *, unsigned int, unsigned int);
>  extern int	 jbd2_journal_try_to_free_buffers(journal_t *journal, struct page *page);
>  extern int	 jbd2_journal_stop(handle_t *);
> -extern int	 jbd2_journal_flush (journal_t *);
> +extern int	 jbd2_journal_flush(journal_t *journal, unsigned long long flags);
>  extern void	 jbd2_journal_lock_updates (journal_t *);
>  extern void	 jbd2_journal_unlock_updates (journal_t *);
>  
> diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
> index f44eb0a04afd..d66408c38c1d 100644
> --- a/include/uapi/linux/fs.h
> +++ b/include/uapi/linux/fs.h
> @@ -214,6 +214,7 @@ struct fsxattr {
>  #define FS_IOC_FSSETXATTR		_IOW('X', 32, struct fsxattr)
>  #define FS_IOC_GETFSLABEL		_IOR(0x94, 49, char[FSLABEL_MAX])
>  #define FS_IOC_SETFSLABEL		_IOW(0x94, 50, char[FSLABEL_MAX])
> +#define FS_IOC_CHKPT_JRNL		_IOW('f', 43, __u64)
>  
>  /*
>   * Inode flags (FS_IOC_GETFLAGS / FS_IOC_SETFLAGS)
> @@ -304,4 +305,7 @@ typedef int __bitwise __kernel_rwf_t;
>  #define RWF_SUPPORTED	(RWF_HIPRI | RWF_DSYNC | RWF_SYNC | RWF_NOWAIT |\
>  			 RWF_APPEND)
>  
> +/* flag for ioctl FS_IOC_JRNL_CHKPT */
> +#define CHKPT_JRNL_DO_DISCARD	1

FS_IOC_CHECKPOINT_FLAG_DISCARD, to go with FS_IOC_CHECKPOINT?

--D

> +
>  #endif /* _UAPI_LINUX_FS_H */
> -- 
> 2.31.0.208.g409f899ff0-goog
> 
