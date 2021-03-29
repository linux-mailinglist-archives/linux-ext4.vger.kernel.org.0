Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04DAF34D34E
	for <lists+linux-ext4@lfdr.de>; Mon, 29 Mar 2021 17:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbhC2PG5 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 29 Mar 2021 11:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbhC2PGy (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 29 Mar 2021 11:06:54 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B38CC061574
        for <linux-ext4@vger.kernel.org>; Mon, 29 Mar 2021 08:06:54 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id iu14so1012397qvb.4
        for <linux-ext4@vger.kernel.org>; Mon, 29 Mar 2021 08:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aG18Voq/gnKNdZi3/NRHrJCp8ULrgLKc4Lr16xfwxPg=;
        b=WVqXkf+uY9OVEC24iqr8X+0c6HUJl93GJKry58Qan2c+sNPm0RSxQqwNfN0CuBs0AX
         muLmC6q2KAQSdw8VY7hkOh3Br1WckKLV5gDSuicjQvQwUiDPNEhCoqIgpOSES+Kuat2y
         jaah3iyxanjTMTE92qlUsBMZ+uOTqRDs4xxoblquPdWLqqfujwvtTVWVMdKaPHVNSw1r
         lSWBMmi1eFSpv/GMkd8U+Fuc4bQx73e0wnqvUh4DaUL+GVU6whso7UuEXyDGSJl+NSBP
         VtVOkiVOyqgIjSdmT9npn296ss1LNNY7ZMZyPDFBhC+qYnWelbvX3A7VnHS4JDNvGIn/
         Z0dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aG18Voq/gnKNdZi3/NRHrJCp8ULrgLKc4Lr16xfwxPg=;
        b=ApuY/ElKhSNUqUJiylVVZMfN5M9VpXSGUoVDWrzCjH0rcMJkAq6JlIf6cKpSciGQVY
         2qw2u0ni7WXQUu8Yhei3O/5rfQVW/SxYD3jCX2IsqFhpjTA8DiO4cVzvb5E0XeX/YHCr
         JCK1zlxokFItJPX40ICpIkfotSzH7BTIZPpBCNT5+FBCsS9LLLtAPR/A9Ok6XUpBbQx5
         GDyyoXh8utjMinKajaW58rGW3d5R1EivRzur9bE1yYz1xMfQI3MetTTKbg56Pd7TY4fo
         X8RKktgFVNhKKPgPWbaG1wycguV4DyhTtQrdAX/6OP02Hivit5sW7oslmMuVnANLGes3
         SiIg==
X-Gm-Message-State: AOAM532yTZuLh3E/TQqqG57NK9rx9XV2NrLKJ9EIVdqsm1zoWmBsWXz6
        Hh7eKTCZlPoxeFVr+nMgA8IXuY6vzgR6rQ==
X-Google-Smtp-Source: ABdhPJz4CqDvBjhsuo0oCuX9PziJ4+qBKcEbkthTRQfQrfuuodCpNbrbDddE9X30rCJ9fkHflfAdKg==
X-Received: by 2002:a0c:a99a:: with SMTP id a26mr25967264qvb.2.1617030413188;
        Mon, 29 Mar 2021 08:06:53 -0700 (PDT)
Received: from google.com ([2601:4c3:201:ed00:94a2:3853:8ddc:29d3])
        by smtp.gmail.com with ESMTPSA id d3sm13846922qke.27.2021.03.29.08.06.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 08:06:52 -0700 (PDT)
Date:   Mon, 29 Mar 2021 11:06:51 -0400
From:   Leah Rumancik <leah.rumancik@gmail.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu
Subject: Re: [PATCH 2/2] ext4: add ioctl EXT4_FLUSH_JOURNAL
Message-ID: <YGHtC4vEWcRervi1@google.com>
References: <20210325181220.1118705-1-leah.rumancik@gmail.com>
 <20210325181220.1118705-2-leah.rumancik@gmail.com>
 <20210326012146.GB22091@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210326012146.GB22091@magnolia>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Mar 25, 2021 at 06:21:46PM -0700, Darrick J. Wong wrote:
> On Thu, Mar 25, 2021 at 06:12:20PM +0000, Leah Rumancik wrote:
> > ioctl EXT4_FLUSH_JOURNAL flushes the journal log with the option to
> > discard journal log blocks. With the filename wipeout patch, if the discard
> > mount option is set, Ext4 guarantees that all data will be discarded on
> > deletion. This ioctl allows for periodically discarding journal contents
> > too.
> 
> Hrm.  What is the use case here?   I guess the goal is to sanitize the
> ondisk log contents (even as wiping deleted filenames becomes default)
> every now and then?  Why do we want cleaning up the log to be an
> explicitly separate step that userspace has to invoke?
> 
> (As opposed, say, to discarding the log automatically after every
> journal checkpoint if a journal/mount option is set?)

The goal here is to be able to ensure everything is sanitized at a
particular point in time. If done automatically through the checkpoint,
there is no guarantee as to how often / when the sanitizing is
performed.

> 
> > Also, add journal discard (if discard supported) during journal load
> > after recovery. This provides a potential solution to
> > https://lore.kernel.org/linux-ext4/YDZoaacIYStFQT8g@mit.edu/ for
> > disks that support discard. After a successful journal recovery, e2fsck can
> > call this ioctl to discard the journal as well.
> > 
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
> >  
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
> > +			return -EINVAL;
> > +
> > +		if (copy_from_user(&discard, (int __user *)arg, sizeof(int)))
> > +			return -EFAULT;
> > +
> > +		if (EXT4_SB(sb)->s_journal) {
> > +			jbd2_journal_lock_updates(EXT4_SB(sb)->s_journal);
> > +
> > +			if (discard)
> > +				err = jbd2_journal_flush_and_discard(EXT4_SB(sb)->s_journal);
> > +			else
> > +				err = jbd2_journal_flush(EXT4_SB(sb)->s_journal);
> 
> Why not pass this as a flag?
> 
> --D
> 

Yes sure, that would make it simpler. I will update it.

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

Thanks for the comments :)
