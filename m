Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0D50375809
	for <lists+linux-ext4@lfdr.de>; Thu,  6 May 2021 17:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235222AbhEFP7y (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 6 May 2021 11:59:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:36806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235136AbhEFP7w (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 6 May 2021 11:59:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4331C6105A;
        Thu,  6 May 2021 15:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620316734;
        bh=bbZvQTWZW6QP6cYsYGuPhTcK2Eg6Mb4x1+0oxadgAYY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=proAweiDlGXTALQuUxKraS9pLzBMSirTLpkojq9msahQfKlHTJ5OJZRF4Peq47xn3
         P4cJU2Qbw4u/2bxIMOmfD32j2jHbArlEcVCjNc5N/FEXjOG3eYoy1bIF2xHupoxrh3
         3/yhbyEOaNfWMQxZbZkDpQF16EXnPGF3UaCxE7u85jjSdRyNiIhiOFDzkTtC7kWjl2
         XSv2a5PEGma6uhh5iotWQZlLCavwvN967bCH60RLbtSzeIbMxQgguRKgJ5dkW8xQei
         GLh4Ofhw8ZzFXwFVXbt1ro8hoe8NiFkj7JtxTE7qZ6VczhoYNEMC3l67hVMO9efeLO
         qT3ztD6YDS6ew==
Date:   Thu, 6 May 2021 08:58:53 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Leah Rumancik <leah.rumancik@gmail.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu
Subject: Re: [PATCH v3 2/3] ext4: add ioctl EXT4_IOC_CHECKPOINT
Message-ID: <20210506155853.GF8532@magnolia>
References: <20210504163550.1486337-1-leah.rumancik@gmail.com>
 <20210504163550.1486337-2-leah.rumancik@gmail.com>
 <20210505212711.GA8532@magnolia>
 <20210505220844.GD8532@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210505220844.GD8532@magnolia>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, May 05, 2021 at 03:08:44PM -0700, Darrick J. Wong wrote:
> On Wed, May 05, 2021 at 02:27:11PM -0700, Darrick J. Wong wrote:
> > On Tue, May 04, 2021 at 04:35:49PM +0000, Leah Rumancik wrote:
> > > ioctl EXT4_IOC_CHECKPOINT checkpoints and flushes the journal. This
> > > includes forcing all the transactions to the log, checkpointing the
> > > transactions, and flushing the log to disk. This ioctl takes u64 "flags"
> > > as an argument. With the EXT4_IOC_CHECKPOINT_FLAG_DISCARD flag set, the
> > > journal blocks are also discarded.
> > > 
> > > Systems that wish to achieve content deletion SLO can set up a daemon
> > > that calls this ioctl at a regular interval such that it matches with the
> > > SLO requirement. Thus, with this patch, the ext4_dir_entry2 wipeout
> > > patch[1], and the Ext4 "-o discard" mount option set, Ext4 can now
> > > guarantee that all data will be erased
> > 
> > Er... what specifically does "data" mean?  File data, or just the dirent
> > blocks?
> > 
> > I think this is only true if discard_zeroes_data == 1, right?  The last
> > I looked, ext4 was calling REQ_OP_DISCARD, not REQ_OP_WRITE_ZEROES.
> > 
> > Also, there are some SSDs that "implement" discard as nop, which means
> > that the old contents can still be read by re-reading the LBAs.  What
> > about those?
> > 
> > (Also wondering if this is where FS_SECRM_FL files should get their
> > freed file blocks erased with REQ_OP_SECURE_ERASE...)
> > 
> > Like Dave says, the commit message needs to be a lot more precise about
> > what data are being targeted, and what the user can expect afterwards.
> > 
> > Something like (setting aside my questions about discard for a moment):
> > 
> > "...and with the ext4 '-o discard' mount option set, ext4 can now
> > guarantee that all file contents, file metadata, and directory names
> > will not be accessible through the filesystem or raw block device reads
> > after a file deletion."
> > 
> > > and discarded on deletion.  Note
> > > that this ioctl won't write zeros if the device doesn't support discards.
> > 
> > AFAICT the patch doesn't call blkdev_issue_zeroout, so this statement is
> > always true.
> > 
> > > The __jbd2_journal_issue_discard function could also be used to discard the
> > > journal (if discard is supported) during journal load after recovery. This
> > > would provide a potential solution to a journal replay bug reported earlier
> > > this year[2] for block devices that support discard. After a successful
> > > journal recovery, e2fsck can call this ioctl to discard the journal as
> > > well.
> > > 
> > > [1] https://lore.kernel.org/linux-ext4/YIHknqxngB1sUdie@mit.edu/
> > > [2] https://lore.kernel.org/linux-ext4/YDZoaacIYStFQT8g@mit.edu/
> > > 
> > > Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
> > > ---
> > >  fs/ext4/ext4.h    |  4 +++
> > >  fs/ext4/ioctl.c   | 38 +++++++++++++++++++++++
> > >  fs/jbd2/journal.c | 79 +++++++++++++++++++++++++++++++++++++++++++++++
> > >  3 files changed, 121 insertions(+)
> > > 
> > > diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> > > index 18f021c988a1..2fe8565706fc 100644
> > > --- a/fs/ext4/ext4.h
> > > +++ b/fs/ext4/ext4.h
> > > @@ -715,6 +715,7 @@ enum {
> > >  #define EXT4_IOC_CLEAR_ES_CACHE		_IO('f', 40)
> > >  #define EXT4_IOC_GETSTATE		_IOW('f', 41, __u32)
> > >  #define EXT4_IOC_GET_ES_CACHE		_IOWR('f', 42, struct fiemap)
> > > +#define EXT4_IOC_CHECKPOINT		_IOW('f', 43, __u64)
> > >  
> > >  #define EXT4_IOC_SHUTDOWN _IOR ('X', 125, __u32)
> > >  
> > > @@ -736,6 +737,9 @@ enum {
> > >  #define EXT4_STATE_FLAG_NEWENTRY	0x00000004
> > >  #define EXT4_STATE_FLAG_DA_ALLOC_CLOSE	0x00000008
> > >  
> > > +/* flag to enable discarding journal blocks through ioctl EXT4_IOC_CHECKPOINT */
> > > +#define EXT4_IOC_CHECKPOINT_FLAG_DISCARD	1

Reiterating what I said on the ext4 concall this morning for benefit of
everyone else following along at home:

You could add a second flag (EXT4_IOC_CHECKPOINT_DRY_RUN) to the ioctl
that returns zero to userspace before making any state changes.  Then
all the fstests cases that exercise this feature (and the dirent name
zering patch that just went upstream) could call the ioctl in dry run
mode to detect kernels that support the zeroing feature, rather than
burning more memory on another feature support file in sysfs.

--D

> > > +
> > >  #if defined(__KERNEL__) && defined(CONFIG_COMPAT)
> > >  /*
> > >   * ioctl commands in 32 bit emulation
> > > diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
> > > index ef809feb7e77..839ffd067357 100644
> > > --- a/fs/ext4/ioctl.c
> > > +++ b/fs/ext4/ioctl.c
> > > @@ -794,6 +794,40 @@ static int ext4_ioctl_get_es_cache(struct file *filp, unsigned long arg)
> > >  	return error;
> > >  }
> > >  
> > > +static int ext4_ioctl_checkpoint(struct file *filp, unsigned long arg)
> > > +{
> > > +	int err = 0;
> > > +	unsigned long long flags = 0;
> > > +	struct super_block *sb = file_inode(filp)->i_sb;
> > > +
> > > +	if (!capable(CAP_SYS_ADMIN))
> > > +		return -EPERM;
> > > +
> > > +	/* file argument is not the mount point */
> > > +	if (file_dentry(filp) != sb->s_root)
> > > +		return -EINVAL;
> > > +
> > > +	/* filesystem is not backed by block device */
> > > +	if (sb->s_bdev == NULL)
> > > +		return -EINVAL;
> > > +
> > > +	if (copy_from_user(&flags, (__u64 __user *)arg,
> > > +				sizeof(__u64)))
> > > +		return -EFAULT;
> > > +
> > > +	/* flags can only be 0 or EXT4_IOC_CHECKPOINT_FLAG_DISCARD */
> > > +	if (flags & ~EXT4_IOC_CHECKPOINT_FLAG_DISCARD)
> > > +		return -EINVAL;
> > > +
> > > +	if (EXT4_SB(sb)->s_journal) {
> > > +		jbd2_journal_lock_updates(EXT4_SB(sb)->s_journal);
> > > +		err = jbd2_journal_flush(EXT4_SB(sb)->s_journal,
> 
> Huh.  So we don't flush the filesystem at all, just the journal?  I
> don't see anything in the documentation saying that syncfs() is a
> prerequisite.
> 
> > > +			flags & EXT4_IOC_CHECKPOINT_FLAG_DISCARD);
> > > +		jbd2_journal_unlock_updates(EXT4_SB(sb)->s_journal);
> > > +	}
> > > +	return err;
> > > +}
> > > +
> > >  static long __ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
> > >  {
> > >  	struct inode *inode = file_inode(filp);
> > > @@ -1205,6 +1239,9 @@ static long __ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
> > >  		return fsverity_ioctl_read_metadata(filp,
> > >  						    (const void __user *)arg);
> > >  
> > > +	case EXT4_IOC_CHECKPOINT:
> > > +		return ext4_ioctl_checkpoint(filp, arg);
> > > +
> > >  	default:
> > >  		return -ENOTTY;
> > >  	}
> > > @@ -1285,6 +1322,7 @@ long ext4_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
> > >  	case EXT4_IOC_CLEAR_ES_CACHE:
> > >  	case EXT4_IOC_GETSTATE:
> > >  	case EXT4_IOC_GET_ES_CACHE:
> > > +	case EXT4_IOC_CHECKPOINT:
> > >  		break;
> > >  	default:
> > >  		return -ENOIOCTLCMD;
> > > diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> > > index 4b7953934c82..ce33e4817aab 100644
> > > --- a/fs/jbd2/journal.c
> > > +++ b/fs/jbd2/journal.c
> > > @@ -1686,6 +1686,80 @@ static void jbd2_mark_journal_empty(journal_t *journal, int write_op)
> > >  	write_unlock(&journal->j_state_lock);
> > >  }
> > >  
> > > +/* discard journal blocks excluding journal superblock */
> > > +static int __jbd2_journal_issue_discard(journal_t *journal)
> > > +{
> > > +	int err = 0;
> > > +	unsigned long block, log_offset; /* logical */
> > > +	unsigned long long phys_block, block_start, block_stop; /* physical */
> > > +	loff_t byte_start, byte_stop, byte_count;
> > > +	struct request_queue *q = bdev_get_queue(journal->j_dev);
> > > +
> > > +	if (!q)
> > > +		return -ENXIO;
> > > +
> > > +	if (!blk_queue_discard(q))
> > > +		return -EOPNOTSUPP;
> > > +
> > > +	/* lookup block mapping and issue discard for each contiguous region */
> > > +	log_offset = be32_to_cpu(journal->j_superblock->s_first);
> > > +
> > > +	err = jbd2_journal_bmap(journal, log_offset, &block_start);
> > > +	if (err) {
> > > +		printk(KERN_ERR "JBD2: bad block at offset %lu", log_offset);
> > > +		return err;
> > > +	}
> > > +
> > > +	/*
> > > +	 * use block_start - 1 to meet check for contiguous with previous region:
> > > +	 * phys_block == block_stop + 1
> > > +	 */
> > > +	block_stop = block_start - 1;
> > > +
> > > +	for (block = log_offset; block < journal->j_total_len; block++) {
> > > +		err = jbd2_journal_bmap(journal, block, &phys_block);
> > > +		if (err) {
> > > +			printk(KERN_ERR "JBD2: bad block at offset %lu", block);
> > > +			return err;
> > > +		}
> > > +
> > > +		if (block == journal->j_total_len - 1)
> > > +			block_stop = phys_block;
> > > +		else if (phys_block == block_stop + 1) {
> > > +			block_stop++;
> > > +			continue;
> > > +		}
> > > +
> > > +		/*
> > > +		 * not contiguous with prior physical block or this is last
> > > +		 * block of journal, take care of the region
> > > +		 */
> > > +		byte_start = block_start * journal->j_blocksize;
> > > +		byte_stop = block_stop * journal->j_blocksize;
> > > +		byte_count = (block_stop - block_start + 1) *
> > > +			journal->j_blocksize;
> > > +
> > > +		truncate_inode_pages_range(journal->j_dev->bd_inode->i_mapping,
> > > +			byte_start, byte_stop);
> > > +
> > > +		err = blkdev_issue_discard(journal->j_dev,
> > > +			byte_start >> SECTOR_SHIFT,
> > > +			byte_count >> SECTOR_SHIFT,
> > > +			GFP_NOFS, 0);
> > 
> > Dumb style nit: I think kernel style rules say to indent second lines
> > more than one tab.
> > 
> > (Dumb in the sense of "ha look at the xfs code!" :P)
> 
> I had a second thought -- this is issuing one discard per journal block.
> Discards are expensive (especially on SATA SSDs where you have to
> suspend all other commands while they run) and especially here since
> we're running them serially.
> 
> One place where jbd2 shows its age is that it relies on bmap() to figure
> out where the journal blocks are on disk.  For regular operation this
> isnn't a big deal since jbd2 only writes data one fs block at a time,
> but for a bulk operation like this, I suspect it's going to be very
> advantageous to be able to discard/zero entire extents at once.
> 
> (No need to cram all that into this patch; that's something for a patch
> 4.)
> 
> > > +
> > > +		if (unlikely(err != 0)) {
> > > +			printk(KERN_ERR "JBD2: unable to discard "
> > > +				"journal at physical blocks %llu - %llu",
> > > +				block_start, block_stop);
> > > +			return err;
> > > +		}
> > > +
> > > +		block_start = phys_block;
> > > +		block_stop = phys_block;
> > > +	}
> > > +
> > > +	return blkdev_issue_flush(journal->j_dev);
> > > +}
> > >  
> > >  /**
> > >   * jbd2_journal_update_sb_errno() - Update error in the journal.
> > > @@ -2246,6 +2320,7 @@ EXPORT_SYMBOL(jbd2_journal_clear_features);
> > >  /**
> > >   * jbd2_journal_flush() - Flush journal
> > >   * @journal: Journal to act on.
> > > + * @discard: discard the journal blocks
> > >   *
> > >   * Flush all data for a given journal to disk and empty the journal.
> > >   * Filesystems can use this when remounting readonly to ensure that
> > > @@ -2305,6 +2380,10 @@ int jbd2_journal_flush(journal_t *journal, bool discard)
> > >  	 * commits of data to the journal will restore the current
> > >  	 * s_start value. */
> > >  	jbd2_mark_journal_empty(journal, REQ_SYNC | REQ_FUA);
> > > +
> > > +	if (discard)
> > > +		err = __jbd2_journal_issue_discard(journal);
> > > +
> > >  	mutex_unlock(&journal->j_checkpoint_mutex);
> > >  	write_lock(&journal->j_state_lock);
> > >  	J_ASSERT(!journal->j_running_transaction);
> > > -- 
> > > 2.31.1.527.g47e6f16901-goog
> > > 
