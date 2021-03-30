Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7D7534F0AB
	for <lists+linux-ext4@lfdr.de>; Tue, 30 Mar 2021 20:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232450AbhC3SPW (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 30 Mar 2021 14:15:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232465AbhC3SO6 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 30 Mar 2021 14:14:58 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EA36C061574
        for <linux-ext4@vger.kernel.org>; Tue, 30 Mar 2021 11:14:58 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id o19so8653267qvu.0
        for <linux-ext4@vger.kernel.org>; Tue, 30 Mar 2021 11:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oFPdKH9PCtQRItLmag3Ya4fzFb4HR3z5avDnpfX2hc0=;
        b=G+GbD4TqEn9N3svGBVb7Zzit63I6b1DvQ2U5zAaobWllhDMXq5/rdRD3nbiUoJwdjV
         RhLRYveSFZ/6vqzBjQygzivNzSTVrFGQj+c9/H2EDXiSTOywrUVAtcIJEh+osOoI9U5o
         V7V8F7tAO8W9/tw8LbXEtW7xHTPzdW/Tuq4QQ8kZJVMj5PQtqKR8wHTDCHoEJVC0hkRo
         CG8cF1h1x4cy66pByHKM+S3NWy+LVBgo2YuN/XkE26Kvj7jMr3gOJPYXHx1IBQE/Z1LV
         VIUU98SFbQDqTeI65wNkttp/5O7LlC6bdvmgdmYMkpAWqM05fvZcA47OT69VR3si2r4B
         3Rjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oFPdKH9PCtQRItLmag3Ya4fzFb4HR3z5avDnpfX2hc0=;
        b=F3LpmgO4GWX7bDk0/+KG0pChObz9dYIMGKsQ3Uz3QniJc31W3HpudKCQc28cmC8Ei8
         Ybs7IQdMBkaVygrl3Ks3bf4cqlL0JYZ/t2LU7ymh1/V+Fsdp/zvG1rbl8rNSzwbMR+jR
         fVBhtQmuYJCOy4/wQRzfJerbr+9Ax3A52KtrPecaW0/LQpBkXUyJm0RFwPp7O4s7IAYJ
         GQB74RBjgkx2yGqNpQ5T+aGP6SVxlVVjdMzP7YdMnHAOr/ewCJBaTshy/qtoC5jSZAS+
         a+UnX9R2AvBANFx0ysUrDdNrBV0qVWofhxfQ43dah5BaqQQI+pkzY31S3TgaYHwdgGmX
         EY5A==
X-Gm-Message-State: AOAM533aUpZc70V0bQI4nKQ/Ea93r7pDwQKUGZxsm1aG5DLFd2lDHCO8
        0Whm3sYT0EHTnq080cN+wp2RbOgZnAZegw==
X-Google-Smtp-Source: ABdhPJypCQMPEKpxspLCjwha+BltR9S14AifulTynzx+3nEMxD8EVeBJMta4DFHtDf389Q2wHdJueg==
X-Received: by 2002:ad4:55ef:: with SMTP id bu15mr31540220qvb.46.1617128097235;
        Tue, 30 Mar 2021 11:14:57 -0700 (PDT)
Received: from google.com ([2601:4c3:201:ed00:21a7:bce5:b37e:1076])
        by smtp.gmail.com with ESMTPSA id e3sm1226542qkn.99.2021.03.30.11.14.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 11:14:56 -0700 (PDT)
Date:   Tue, 30 Mar 2021 14:14:55 -0400
From:   Leah Rumancik <leah.rumancik@gmail.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu
Subject: Re: [PATCH 2/2] ext4: add ioctl EXT4_FLUSH_JOURNAL
Message-ID: <YGNqn9WHP+7ha89i@google.com>
References: <20210325181220.1118705-1-leah.rumancik@gmail.com>
 <20210325181220.1118705-2-leah.rumancik@gmail.com>
 <20210330171734.GE22091@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210330171734.GE22091@magnolia>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Mar 30, 2021 at 10:17:34AM -0700, Darrick J. Wong wrote:
> On Thu, Mar 25, 2021 at 06:12:20PM +0000, Leah Rumancik wrote:
> > ioctl EXT4_FLUSH_JOURNAL flushes the journal log with the option to
> > discard journal log blocks. With the filename wipeout patch, if the discard
> > mount option is set, Ext4 guarantees that all data will be discarded on
> > deletion. This ioctl allows for periodically discarding journal contents
> > too.
> > 
> > Also, add journal discard (if discard supported) during journal load
> > after recovery. This provides a potential solution to
> > https://lore.kernel.org/linux-ext4/YDZoaacIYStFQT8g@mit.edu/ for
> > disks that support discard. After a successful journal recovery, e2fsck can
> > call this ioctl to discard the journal as well.
> 
> Ok, round 2, this time from the perspective of a adding a journal
> checkpointing ioctl so that we can finally fix grub stupidity.
> 
> > Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
> > ---
> >  fs/ext4/ext4.h       |   1 +
> >  fs/ext4/ioctl.c      |  28 +++++++++++
> >  fs/jbd2/journal.c    | 116 +++++++++++++++++++++++++++++++++++++++++--
> >  include/linux/jbd2.h |   1 +
> >  4 files changed, 143 insertions(+), 3 deletions(-)
> > 
> > diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> > index 8011418176bc..92c039ebcba7 100644
> > --- a/fs/ext4/ext4.h
> > +++ b/fs/ext4/ext4.h
> > @@ -724,6 +724,7 @@ enum {
> >  #define EXT4_IOC_CLEAR_ES_CACHE		_IO('f', 40)
> >  #define EXT4_IOC_GETSTATE		_IOW('f', 41, __u32)
> >  #define EXT4_IOC_GET_ES_CACHE		_IOWR('f', 42, struct fiemap)
> > +#define EXT4_FLUSH_JOURNAL		_IOW('f', 43, int)
> 
> This really ought to be named "CHECKPOINT", not "FLUSH", because
> flushing only requires persisting to stable storage somewhere.  This
> call does a lot more work than that, so its name ought to reflect the
> fact that it checkpoints the filesystem to clean the journal and then
> trims the journal blocks.

Yes, sure. I will rename it.

> 
> The grub bootloader has had a serious design flaw ever since it
> introduced the ext4 and xfs drivers -- it ignores the journal when it's
> reading a filesystem, which means that unrecovered transactions in the
> journal are ignored.  We (XFS anyway) /really/ don't want grub's
> diminutive filesystem drivers trying to implement recovery.
> 
> Because of this inadequacy, we get sporadic complaints about grub
> failing to recognize new kernel files if the system goes down
> immediately after the package manager installs a new kernel, even if it
> succeeds in syncfs()ing /boot afterwards.  The cause, of course, is that
> we /did/ flush the directory updates to disk, but they're in the journal
> and the journal didn't checkpoint before the system went down.
> 
> XFS is far worse off in this category because we only tend to checkpoint
> the log when the head approaches the tail; iirc ext4/jbd2 tend to
> checkpoint frequently enough that I get fewer bug reports about it.
> 
> The solution, I think, is to add a checkpoint call so that grub can
> operate with greater confidence that the bootloader stage2 will be able
> to find the files it just wrote to the filesystem.  Previous iterations
> on this complaint suggested FIFREEZE/FITHAW, which was proven not to
> work because we cannot guarantee the ability to stop the world for a
> freeze, and grub only requires that the effects of previous system calls
> can be found with a norecovery mount.
> 
> IOWS: I really like this new checkpointing ioctl!  If we can wire this
> up in the five major /boot filesystems (ext*, XFS, btrfs, and vfat) then
> we can finally tell the grub developers to we have a real solution for
> them. :)

Sounds good to me!

> 
> >  #define EXT4_IOC_SHUTDOWN _IOR ('X', 125, __u32)
> >  
> > diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
> > index a2cf35066f46..1d3636c1de3b 100644
> > --- a/fs/ext4/ioctl.c
> > +++ b/fs/ext4/ioctl.c
> > @@ -1318,6 +1318,33 @@ static long __ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
> >  			return -EOPNOTSUPP;
> >  		return fsverity_ioctl_read_metadata(filp,
> >  						    (const void __user *)arg);
> > +	case EXT4_FLUSH_JOURNAL:
> > +	{
> > +		int discard = 0, err = 0;
> > +
> > +		/* file argument is not the mount point */
> > +		if (file_dentry(filp) != sb->s_root)
> > +			return -EINVAL;
> > +
> > +		/* filesystem is not backed by block device */
> > +		if (sb->s_bdev == NULL)
> > +			return -EINVAL;o
> 
> Could it be a problem that unprivileged programs can pound on a
> heavyweight ioctl?  The other callers of jbd2_journal_flush imply pretty
> heavily that checkpointing is expensive and that we don't really expect
> users to be able to induce a checkpoint.

Hmm yeah that's a good point. The original reasoning for not requiring
root privileges was so it could be used even if a filesystem was created
without root privileges. But that's not the common case and considering
the expensivness, I think requiring root privileges makes sense.

> 
> > +
> > +		if (copy_from_user(&discard, (int __user *)arg, sizeof(int)))
> > +			return -EFAULT;
> 
> Please use an explicit struct with extra padding for future expansion,
> because the history of ext4 ioctls taking integer pointer arguments is a
> mess[1].
> 
> struct ioc_checkpoint_journal {
> 	u64	flags;
> 	u64	pad[3]; /* must be zero */
> };
> 
> The GETFLAGS and SETFLAGS ioctls are defined to take a pointer to a
> signed long, but the implementations use an unsigned int.  Nobody
> noticed the potential for memory corruption in the calling processes
> until well after we moved to 64-bit.  Hopefully we can avoid a repeat of
> that by using explicitly sized types and named structs that are a little
> more obvious to readers.
> 
> [1] https://lore.kernel.org/linux-fsdevel/20131219232739.GA10192@birch.djwong.org/
> 
> > +
> > +		if (EXT4_SB(sb)->s_journal) {
> > +			jbd2_journal_lock_updates(EXT4_SB(sb)->s_journal);
> > +
> > +			if (discard)
> 
> There's only a single bit of information here, so please only use one
> bit, and leave the other 63/31 bits for future expansion.
> 

Yes, sure. Thanks for the suggestions/references.

> Also, um, is there a manpage to document this new call?  Or an fstest
> to check its operation?  I would very much like to port this to XFS, but
> we need artifacts and the ability to show that it works.

There isn't a manpage yet, but I'd be happy to add one. I also plan on
submitting an fstest.

> 
> --D
> 
> > +				err = jbd2_journal_flush_and_discard(EXT4_SB(sb)->s_journal);
> > +			else
> > +				err = jbd2_journal_flush(EXT4_SB(sb)->s_journal);
> > +
> > +			jbd2_journal_unlock_updates(EXT4_SB(sb)->s_journal);
> > +		}
> > +		return err;
> > +	}
> >  
> >  	default:
> >  		return -ENOTTY;
> > @@ -1407,6 +1434,7 @@ long ext4_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
> >  	case EXT4_IOC_GET_ES_CACHE:
> >  	case FS_IOC_FSGETXATTR:
> >  	case FS_IOC_FSSETXATTR:
> > +	case EXT4_FLUSH_JOURNAL:
> >  		break;
> >  	default:
> >  		return -ENOIOCTLCMD;
> > diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> > index 2dc944442802..9718512e7178 100644
> > --- a/fs/jbd2/journal.c
> > +++ b/fs/jbd2/journal.c
> > @@ -67,6 +67,7 @@ EXPORT_SYMBOL(jbd2_journal_set_triggers);
> >  EXPORT_SYMBOL(jbd2_journal_dirty_metadata);
> >  EXPORT_SYMBOL(jbd2_journal_forget);
> >  EXPORT_SYMBOL(jbd2_journal_flush);
> > +EXPORT_SYMBOL(jbd2_journal_flush_and_discard);
> >  EXPORT_SYMBOL(jbd2_journal_revoke);
> >  
> >  EXPORT_SYMBOL(jbd2_journal_init_dev);
> > @@ -1686,6 +1687,90 @@ static void jbd2_mark_journal_empty(journal_t *journal, int write_op)
> >  	write_unlock(&journal->j_state_lock);
> >  }
> >  
> > +/* discard journal blocks excluding journal superblock */
> > +static int __jbd2_journal_issue_discard(journal_t *journal)
> > +{
> > +	int err = 0;
> > +	unsigned long block, log_offset;
> > +	unsigned long long phys_block, block_start, block_stop;
> > +	loff_t byte_start, byte_stop, byte_count;
> > +	struct request_queue *q = bdev_get_queue(journal->j_dev);
> > +
> > +	if (!q)
> > +		return -ENXIO;
> > +
> > +	if (!blk_queue_discard(q))
> > +		return -EOPNOTSUPP;
> > +
> > +	/* lookup block mapping and issue discard for each contiguous region */
> > +	log_offset = be32_to_cpu(journal->j_superblock->s_first);
> > +
> > +	err = jbd2_journal_bmap(journal, log_offset, &block_start);
> > +	if (err) {
> > +		printk(KERN_ERR "JBD2: bad block at offset %lu", log_offset);
> > +		return err;
> > +	}
> > +
> > +	/*
> > +	 * use block_start - 1 to meet check for contiguous with previous region:
> > +	 * phys_block == block_stop + 1
> > +	 */
> > +	block_stop = block_start - 1;
> > +
> > +	for (block = log_offset; block < journal->j_total_len; block++) {
> > +		err = jbd2_journal_bmap(journal, block, &phys_block);
> > +		if (err) {
> > +			printk(KERN_ERR "JBD2: bad block at offset %lu", block);
> > +			return err;
> > +		}
> > +
> > +		/*
> > +		 * if block is last block, update stopping point
> > +		 * if not last block and
> > +		 * block is contiguous with previous block, continue
> > +		 */
> > +		if (block == journal->j_total_len - 1)
> > +			block_stop = phys_block;
> > +		else if (phys_block == block_stop + 1) {
> > +			block_stop++;
> > +			continue;
> > +		}
> > +
> > +		/*
> > +		 * if not contiguous with prior physical block or this is last
> > +		 * block of journal, take care of the region
> > +		 */
> > +		byte_start = block_start * journal->j_blocksize;
> > +		byte_stop = block_stop * journal->j_blocksize;
> > +		byte_count = (block_stop - block_start + 1) *
> > +			journal->j_blocksize;
> > +
> > +		truncate_inode_pages_range(journal->j_dev->bd_inode->i_mapping,
> > +			byte_start, byte_stop);
> > +
> > +		/*
> > +		 * use blkdev_issue_discard instead of sb_issue_discard
> > +		 * because superblock not yet populated when this is
> > +		 * called during journal_load during mount process
> > +		 */
> > +		err = blkdev_issue_discard(journal->j_dev,
> > +			byte_start >> SECTOR_SHIFT,
> > +			byte_count >> SECTOR_SHIFT,
> > +			GFP_NOFS, 0);
> > +
> > +		if (unlikely(err != 0)) {
> > +			printk(KERN_ERR "JBD2: unable to discard "
> > +				"journal at physical blocks %llu - %llu",
> > +				block_start, block_stop);
> > +			return err;
> > +		}
> > +
> > +		block_start = phys_block;
> > +		block_stop = phys_block;
> > +	}
> > +
> > +	return blkdev_issue_flush(journal->j_dev);
> > +}
> >  
> >  /**
> >   * jbd2_journal_update_sb_errno() - Update error in the journal.
> > @@ -1892,6 +1977,7 @@ int jbd2_journal_load(journal_t *journal)
> >  {
> >  	int err;
> >  	journal_superblock_t *sb;
> > +	struct request_queue *q = bdev_get_queue(journal->j_dev);
> >  
> >  	err = load_superblock(journal);
> >  	if (err)
> > @@ -1936,6 +2022,12 @@ int jbd2_journal_load(journal_t *journal)
> >  	 */
> >  	journal->j_flags &= ~JBD2_ABORT;
> >  
> > +	/* if journal device supports discard, discard journal blocks */
> > +	if (q && blk_queue_discard(q)) {
> > +		if (__jbd2_journal_issue_discard(journal))
> > +			printk(KERN_ERR "JBD2: failed to discard journal when loading");
> > +	}
> > +
> >  	/* OK, we've finished with the dynamic journal bits:
> >  	 * reinitialise the dynamic contents of the superblock in memory
> >  	 * and reset them on disk. */
> > @@ -2244,15 +2336,18 @@ void jbd2_journal_clear_features(journal_t *journal, unsigned long compat,
> >  EXPORT_SYMBOL(jbd2_journal_clear_features);
> >  
> >  /**
> > - * jbd2_journal_flush() - Flush journal
> > + * __jbd2_journal_flush() - Flush journal
> >   * @journal: Journal to act on.
> > + * @discard: flag (see below)
> >   *
> >   * Flush all data for a given journal to disk and empty the journal.
> >   * Filesystems can use this when remounting readonly to ensure that
> >   * recovery does not need to happen on remount.
> > + *
> > + * If 'discard' is false, the journal is simply flushed. If discard is true,
> > + * the journal is also discarded.
> >   */
> > -
> > -int jbd2_journal_flush(journal_t *journal)
> > +static int __jbd2_journal_flush(journal_t *journal, bool discard)
> >  {
> >  	int err = 0;
> >  	transaction_t *transaction = NULL;
> > @@ -2306,6 +2401,10 @@ int jbd2_journal_flush(journal_t *journal)
> >  	 * commits of data to the journal will restore the current
> >  	 * s_start value. */
> >  	jbd2_mark_journal_empty(journal, REQ_SYNC | REQ_FUA);
> > +
> > +	if (discard)
> > +		err = __jbd2_journal_issue_discard(journal);
> > +
> >  	mutex_unlock(&journal->j_checkpoint_mutex);
> >  	write_lock(&journal->j_state_lock);
> >  	J_ASSERT(!journal->j_running_transaction);
> > @@ -2318,6 +2417,17 @@ int jbd2_journal_flush(journal_t *journal)
> >  	return err;
> >  }
> >  
> > +int jbd2_journal_flush(journal_t *journal)
> > +{
> > +	return __jbd2_journal_flush(journal, false /* don't discard */);
> > +}
> > +
> > +/* flush journal and discard journal log */
> > +int jbd2_journal_flush_and_discard(journal_t *journal)
> > +{
> > +	return __jbd2_journal_flush(journal, true /* also discard */);
> > +}
> > +
> >  /**
> >   * jbd2_journal_wipe() - Wipe journal contents
> >   * @journal: Journal to act on.
> > diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
> > index 99d3cd051ac3..9bed34e9a273 100644
> > --- a/include/linux/jbd2.h
> > +++ b/include/linux/jbd2.h
> > @@ -1492,6 +1492,7 @@ extern int	 jbd2_journal_invalidatepage(journal_t *,
> >  extern int	 jbd2_journal_try_to_free_buffers(journal_t *journal, struct page *page);
> >  extern int	 jbd2_journal_stop(handle_t *);
> >  extern int	 jbd2_journal_flush (journal_t *);
> > +extern int	 jbd2_journal_flush_and_discard(journal_t *journal);
> >  extern void	 jbd2_journal_lock_updates (journal_t *);
> >  extern void	 jbd2_journal_unlock_updates (journal_t *);
> >  
> > -- 
> > 2.31.0.291.g576ba9dcdaf-goog
> > 
