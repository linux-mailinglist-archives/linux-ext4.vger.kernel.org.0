Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B7AD349E98
	for <lists+linux-ext4@lfdr.de>; Fri, 26 Mar 2021 02:22:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbhCZBVy (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 25 Mar 2021 21:21:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:43264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230137AbhCZBVs (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 25 Mar 2021 21:21:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 43DEE61A33;
        Fri, 26 Mar 2021 01:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616721707;
        bh=f1Jkwfzbfty4d7t5e4SWdzzNq5Oa9iJrogfk3veACJY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cboMNfDJmzDn3Jt1HkW+PQigZn1C1S0WG+NlkdB0FfpH+BCwxjmBDKrtoRNmuyhiF
         5nDGbyK2KHs6rcpQZ7YJmw/EVg2jOmRT8nlUxcxy9KPRpldP8v7m/Ze6A1IWONtDpq
         06II4/5OEyFzymHnpUHKKtGf4Y+vOGNXgEds55euDt0NDnk0p3Mz2Lvw6gGrVUxVQG
         INcCotmpNakmbRchycBvc+ydXO1+9vct2ZVif/QznRdHjXw6yX3Ltg+U9WrOhuhejW
         4RWuC0badvtmZx6wQ1ePOyuAFqXFVlf8pyrbxLmnHxkYaT+w/hF1z3U7Greukuc5AX
         0HtaPesaDOwGg==
Date:   Thu, 25 Mar 2021 18:21:46 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Leah Rumancik <leah.rumancik@gmail.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu
Subject: Re: [PATCH 2/2] ext4: add ioctl EXT4_FLUSH_JOURNAL
Message-ID: <20210326012146.GB22091@magnolia>
References: <20210325181220.1118705-1-leah.rumancik@gmail.com>
 <20210325181220.1118705-2-leah.rumancik@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210325181220.1118705-2-leah.rumancik@gmail.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Mar 25, 2021 at 06:12:20PM +0000, Leah Rumancik wrote:
> ioctl EXT4_FLUSH_JOURNAL flushes the journal log with the option to
> discard journal log blocks. With the filename wipeout patch, if the discard
> mount option is set, Ext4 guarantees that all data will be discarded on
> deletion. This ioctl allows for periodically discarding journal contents
> too.

Hrm.  What is the use case here?   I guess the goal is to sanitize the
ondisk log contents (even as wiping deleted filenames becomes default)
every now and then?  Why do we want cleaning up the log to be an
explicitly separate step that userspace has to invoke?

(As opposed, say, to discarding the log automatically after every
journal checkpoint if a journal/mount option is set?)

> Also, add journal discard (if discard supported) during journal load
> after recovery. This provides a potential solution to
> https://lore.kernel.org/linux-ext4/YDZoaacIYStFQT8g@mit.edu/ for
> disks that support discard. After a successful journal recovery, e2fsck can
> call this ioctl to discard the journal as well.
> 
> Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
> ---
>  fs/ext4/ext4.h       |   1 +
>  fs/ext4/ioctl.c      |  28 +++++++++++
>  fs/jbd2/journal.c    | 116 +++++++++++++++++++++++++++++++++++++++++--
>  include/linux/jbd2.h |   1 +
>  4 files changed, 143 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 8011418176bc..92c039ebcba7 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -724,6 +724,7 @@ enum {
>  #define EXT4_IOC_CLEAR_ES_CACHE		_IO('f', 40)
>  #define EXT4_IOC_GETSTATE		_IOW('f', 41, __u32)
>  #define EXT4_IOC_GET_ES_CACHE		_IOWR('f', 42, struct fiemap)
> +#define EXT4_FLUSH_JOURNAL		_IOW('f', 43, int)
>  
>  #define EXT4_IOC_SHUTDOWN _IOR ('X', 125, __u32)
>  
> diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
> index a2cf35066f46..1d3636c1de3b 100644
> --- a/fs/ext4/ioctl.c
> +++ b/fs/ext4/ioctl.c
> @@ -1318,6 +1318,33 @@ static long __ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>  			return -EOPNOTSUPP;
>  		return fsverity_ioctl_read_metadata(filp,
>  						    (const void __user *)arg);
> +	case EXT4_FLUSH_JOURNAL:
> +	{
> +		int discard = 0, err = 0;
> +
> +		/* file argument is not the mount point */
> +		if (file_dentry(filp) != sb->s_root)
> +			return -EINVAL;
> +
> +		/* filesystem is not backed by block device */
> +		if (sb->s_bdev == NULL)
> +			return -EINVAL;
> +
> +		if (copy_from_user(&discard, (int __user *)arg, sizeof(int)))
> +			return -EFAULT;
> +
> +		if (EXT4_SB(sb)->s_journal) {
> +			jbd2_journal_lock_updates(EXT4_SB(sb)->s_journal);
> +
> +			if (discard)
> +				err = jbd2_journal_flush_and_discard(EXT4_SB(sb)->s_journal);
> +			else
> +				err = jbd2_journal_flush(EXT4_SB(sb)->s_journal);

Why not pass this as a flag?

--D

> +
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
> +	case EXT4_FLUSH_JOURNAL:
>  		break;
>  	default:
>  		return -ENOIOCTLCMD;
> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> index 2dc944442802..9718512e7178 100644
> --- a/fs/jbd2/journal.c
> +++ b/fs/jbd2/journal.c
> @@ -67,6 +67,7 @@ EXPORT_SYMBOL(jbd2_journal_set_triggers);
>  EXPORT_SYMBOL(jbd2_journal_dirty_metadata);
>  EXPORT_SYMBOL(jbd2_journal_forget);
>  EXPORT_SYMBOL(jbd2_journal_flush);
> +EXPORT_SYMBOL(jbd2_journal_flush_and_discard);
>  EXPORT_SYMBOL(jbd2_journal_revoke);
>  
>  EXPORT_SYMBOL(jbd2_journal_init_dev);
> @@ -1686,6 +1687,90 @@ static void jbd2_mark_journal_empty(journal_t *journal, int write_op)
>  	write_unlock(&journal->j_state_lock);
>  }
>  
> +/* discard journal blocks excluding journal superblock */
> +static int __jbd2_journal_issue_discard(journal_t *journal)
> +{
> +	int err = 0;
> +	unsigned long block, log_offset;
> +	unsigned long long phys_block, block_start, block_stop;
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
> @@ -1892,6 +1977,7 @@ int jbd2_journal_load(journal_t *journal)
>  {
>  	int err;
>  	journal_superblock_t *sb;
> +	struct request_queue *q = bdev_get_queue(journal->j_dev);
>  
>  	err = load_superblock(journal);
>  	if (err)
> @@ -1936,6 +2022,12 @@ int jbd2_journal_load(journal_t *journal)
>  	 */
>  	journal->j_flags &= ~JBD2_ABORT;
>  
> +	/* if journal device supports discard, discard journal blocks */
> +	if (q && blk_queue_discard(q)) {
> +		if (__jbd2_journal_issue_discard(journal))
> +			printk(KERN_ERR "JBD2: failed to discard journal when loading");
> +	}
> +
>  	/* OK, we've finished with the dynamic journal bits:
>  	 * reinitialise the dynamic contents of the superblock in memory
>  	 * and reset them on disk. */
> @@ -2244,15 +2336,18 @@ void jbd2_journal_clear_features(journal_t *journal, unsigned long compat,
>  EXPORT_SYMBOL(jbd2_journal_clear_features);
>  
>  /**
> - * jbd2_journal_flush() - Flush journal
> + * __jbd2_journal_flush() - Flush journal
>   * @journal: Journal to act on.
> + * @discard: flag (see below)
>   *
>   * Flush all data for a given journal to disk and empty the journal.
>   * Filesystems can use this when remounting readonly to ensure that
>   * recovery does not need to happen on remount.
> + *
> + * If 'discard' is false, the journal is simply flushed. If discard is true,
> + * the journal is also discarded.
>   */
> -
> -int jbd2_journal_flush(journal_t *journal)
> +static int __jbd2_journal_flush(journal_t *journal, bool discard)
>  {
>  	int err = 0;
>  	transaction_t *transaction = NULL;
> @@ -2306,6 +2401,10 @@ int jbd2_journal_flush(journal_t *journal)
>  	 * commits of data to the journal will restore the current
>  	 * s_start value. */
>  	jbd2_mark_journal_empty(journal, REQ_SYNC | REQ_FUA);
> +
> +	if (discard)
> +		err = __jbd2_journal_issue_discard(journal);
> +
>  	mutex_unlock(&journal->j_checkpoint_mutex);
>  	write_lock(&journal->j_state_lock);
>  	J_ASSERT(!journal->j_running_transaction);
> @@ -2318,6 +2417,17 @@ int jbd2_journal_flush(journal_t *journal)
>  	return err;
>  }
>  
> +int jbd2_journal_flush(journal_t *journal)
> +{
> +	return __jbd2_journal_flush(journal, false /* don't discard */);
> +}
> +
> +/* flush journal and discard journal log */
> +int jbd2_journal_flush_and_discard(journal_t *journal)
> +{
> +	return __jbd2_journal_flush(journal, true /* also discard */);
> +}
> +
>  /**
>   * jbd2_journal_wipe() - Wipe journal contents
>   * @journal: Journal to act on.
> diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
> index 99d3cd051ac3..9bed34e9a273 100644
> --- a/include/linux/jbd2.h
> +++ b/include/linux/jbd2.h
> @@ -1492,6 +1492,7 @@ extern int	 jbd2_journal_invalidatepage(journal_t *,
>  extern int	 jbd2_journal_try_to_free_buffers(journal_t *journal, struct page *page);
>  extern int	 jbd2_journal_stop(handle_t *);
>  extern int	 jbd2_journal_flush (journal_t *);
> +extern int	 jbd2_journal_flush_and_discard(journal_t *journal);
>  extern void	 jbd2_journal_lock_updates (journal_t *);
>  extern void	 jbd2_journal_unlock_updates (journal_t *);
>  
> -- 
> 2.31.0.291.g576ba9dcdaf-goog
> 
