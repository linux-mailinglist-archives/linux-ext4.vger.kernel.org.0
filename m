Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20B5E34EDEE
	for <lists+linux-ext4@lfdr.de>; Tue, 30 Mar 2021 18:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231998AbhC3Qck (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 30 Mar 2021 12:32:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:55126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232279AbhC3Qc1 (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 30 Mar 2021 12:32:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 555646198A;
        Tue, 30 Mar 2021 16:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617121946;
        bh=I/4cjOahXVvSGejiGFMRycbEOkUIT9cgc08Gzsk+19s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U+5gKlSP8KftwPwDp/lfY2CWQ/uYaIeepA9l2Wyk/uKvwIhFpgnj5bwx8IbF1Q0rU
         ShzmQ4VjL7qMXUJIG8ysbLUAOjMkNzcFrENIZYSZyLJo3Y5h4FdR57gU6e962D46C1
         owOIYrd8DD0be14S9SM1j02IL9tBuWfRjfq+qoLEdxGAcxP9XhlCNUxe6d+OU363A9
         nUU7mvfZ3PCc3pC9uZQnNhkzuXOLVfYIOInRJM9JRFK+PGStBdtbA0gbNiTS3NWWFd
         /1/gVyZosbMuoSzQo/9BHb5pTTB+TXTNw2/jXkA8ShTNPlwEAXdZNYthIhxmXKvMfN
         6PZgX9QY7BaSw==
Date:   Tue, 30 Mar 2021 09:32:23 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     harshad shirwadkar <harshadshirwadkar@gmail.com>
Cc:     Leah Rumancik <leah.rumancik@gmail.com>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH 2/2] ext4: add ioctl EXT4_FLUSH_JOURNAL
Message-ID: <20210330163223.GD22091@magnolia>
References: <20210325181220.1118705-1-leah.rumancik@gmail.com>
 <20210325181220.1118705-2-leah.rumancik@gmail.com>
 <20210326012146.GB22091@magnolia>
 <YGHtC4vEWcRervi1@google.com>
 <CAD+ocbx-DZprEvzSQ2+rVFz6CPJy0iYbG60SGZHpi+ZX8ecqhg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD+ocbx-DZprEvzSQ2+rVFz6CPJy0iYbG60SGZHpi+ZX8ecqhg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Mar 29, 2021 at 03:10:34PM -0700, harshad shirwadkar wrote:
> On Mon, Mar 29, 2021 at 8:09 AM Leah Rumancik <leah.rumancik@gmail.com> wrote:
> >
> > On Thu, Mar 25, 2021 at 06:21:46PM -0700, Darrick J. Wong wrote:
> > > On Thu, Mar 25, 2021 at 06:12:20PM +0000, Leah Rumancik wrote:
> > > > ioctl EXT4_FLUSH_JOURNAL flushes the journal log with the option to
> > > > discard journal log blocks. With the filename wipeout patch, if the discard
> > > > mount option is set, Ext4 guarantees that all data will be discarded on
> > > > deletion. This ioctl allows for periodically discarding journal contents
> > > > too.
> > >
> > > Hrm.  What is the use case here?   I guess the goal is to sanitize the
> > > ondisk log contents (even as wiping deleted filenames becomes default)
> > > every now and then?  Why do we want cleaning up the log to be an
> > > explicitly separate step that userspace has to invoke?
> > >
> > > (As opposed, say, to discarding the log automatically after every
> > > journal checkpoint if a journal/mount option is set?)
> >
> > The goal here is to be able to ensure everything is sanitized at a
> > particular point in time. If done automatically through the checkpoint,
> > there is no guarantee as to how often / when the sanitizing is
> > performed.

Oh, ok, you want a sanitization barrier ("if this call returns zero,
everything sensitive in the journal is no longer accessible") for
$program.  Got it.

It occurred to me overnight that another way to look at this ioctl
proposal is that it checkpoints the filesystem and has a flag to discard
the journal blocks too.  Given that we're now only two days away from
my traditional bootfs[1] drum-banging day, and there's real user
demand[2] for bootloaders to be able to force a journal checkpoint,
I think I'll re-read this patch in that context.

[1] https://lore.kernel.org/linux-fsdevel/20190401070001.GJ1173@magnolia/
[2] https://lore.kernel.org/linux-xfs/1570977420-3944-1-git-send-email-kernelfans@gmail.com/

> To elaborate more on that, this allows userspace to control the
> frequency of journal discards and this is useful if the userspace
> application is trying to put a bound on content erasing time. With
> Leah's earlier patch in the series, Ext4 when mounted with the
> "discard" mount option would ensure that whenever a file is deleted,
> it disappears completely from the fliesystem controlled LBAs of the
> underlying block device, but no such guarantee is provided for the
> potential remains of the file in the journal. With this
> user-controlled discard frequency of the journal, userspace can ensure
> that the contents of a deleted file disappear entirely within X hours
> by calling this ioctl once every X hours. This allows us to greatly
> simplify journal discards - that's because now we don't have to track
> the journal blocks belonging to a particular file.
> 
> Also, sending discards to the entire journal with every commit /
> checkpoint may have some performance issues.

(Heh.)

> So, if we want this to be
> automated, one option would be to invoke this after every N commits
> performed by the journal thread and make N configurable as a mount
> time parameter. But, it's just simpler to call this ioctl from the
> application and let it worry about the frequency, and perhaps these
> applications would anyway be calling fstrim periodically to ensure
> such guarantees. If they are doing that, this would just add another
> step in their periodic discard routine.

Why not make discarding the journal part of FITRIM then?

Or are there really two separate usescases here -- automated background
trimming of everything; and certain programs that want/need to make sure
that all the data stored by that program are no longer accessible via
the LBA interface, and do not want to pay the cost of cleaning the
/entire/ filesystem?  (Which I think you could easily do with a third
patch to force discard-on-free behavior on files with SECRM_FL set.)

--D

> - Harshad
> 
> 
> 
> 
> 
> 
> 
> - Harshad
> >
> > >
> > > > Also, add journal discard (if discard supported) during journal load
> > > > after recovery. This provides a potential solution to
> > > > https://lore.kernel.org/linux-ext4/YDZoaacIYStFQT8g@mit.edu/ for
> > > > disks that support discard. After a successful journal recovery, e2fsck can
> > > > call this ioctl to discard the journal as well.
> > > >
> > > > Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
> > > > ---
> > > >  fs/ext4/ext4.h       |   1 +
> > > >  fs/ext4/ioctl.c      |  28 +++++++++++
> > > >  fs/jbd2/journal.c    | 116 +++++++++++++++++++++++++++++++++++++++++--
> > > >  include/linux/jbd2.h |   1 +
> > > >  4 files changed, 143 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> > > > index 8011418176bc..92c039ebcba7 100644
> > > > --- a/fs/ext4/ext4.h
> > > > +++ b/fs/ext4/ext4.h
> > > > @@ -724,6 +724,7 @@ enum {
> > > >  #define EXT4_IOC_CLEAR_ES_CACHE            _IO('f', 40)
> > > >  #define EXT4_IOC_GETSTATE          _IOW('f', 41, __u32)
> > > >  #define EXT4_IOC_GET_ES_CACHE              _IOWR('f', 42, struct fiemap)
> > > > +#define EXT4_FLUSH_JOURNAL         _IOW('f', 43, int)
> > > >
> > > >  #define EXT4_IOC_SHUTDOWN _IOR ('X', 125, __u32)
> > > >
> > > > diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
> > > > index a2cf35066f46..1d3636c1de3b 100644
> > > > --- a/fs/ext4/ioctl.c
> > > > +++ b/fs/ext4/ioctl.c
> > > > @@ -1318,6 +1318,33 @@ static long __ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
> > > >                     return -EOPNOTSUPP;
> > > >             return fsverity_ioctl_read_metadata(filp,
> > > >                                                 (const void __user *)arg);
> > > > +   case EXT4_FLUSH_JOURNAL:
> > > > +   {
> > > > +           int discard = 0, err = 0;
> > > > +
> > > > +           /* file argument is not the mount point */
> > > > +           if (file_dentry(filp) != sb->s_root)
> > > > +                   return -EINVAL;
> > > > +
> > > > +           /* filesystem is not backed by block device */
> > > > +           if (sb->s_bdev == NULL)
> > > > +                   return -EINVAL;
> > > > +
> > > > +           if (copy_from_user(&discard, (int __user *)arg, sizeof(int)))
> > > > +                   return -EFAULT;
> > > > +
> > > > +           if (EXT4_SB(sb)->s_journal) {
> > > > +                   jbd2_journal_lock_updates(EXT4_SB(sb)->s_journal);
> > > > +
> > > > +                   if (discard)
> > > > +                           err = jbd2_journal_flush_and_discard(EXT4_SB(sb)->s_journal);
> > > > +                   else
> > > > +                           err = jbd2_journal_flush(EXT4_SB(sb)->s_journal);
> > >
> > > Why not pass this as a flag?
> > >
> > > --D
> > >
> >
> > Yes sure, that would make it simpler. I will update it.
> >
> > > > +
> > > > +                   jbd2_journal_unlock_updates(EXT4_SB(sb)->s_journal);
> > > > +           }
> > > > +           return err;
> > > > +   }
> > > >
> > > >     default:
> > > >             return -ENOTTY;
> > > > @@ -1407,6 +1434,7 @@ long ext4_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
> > > >     case EXT4_IOC_GET_ES_CACHE:
> > > >     case FS_IOC_FSGETXATTR:
> > > >     case FS_IOC_FSSETXATTR:
> > > > +   case EXT4_FLUSH_JOURNAL:
> > > >             break;
> > > >     default:
> > > >             return -ENOIOCTLCMD;
> > > > diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> > > > index 2dc944442802..9718512e7178 100644
> > > > --- a/fs/jbd2/journal.c
> > > > +++ b/fs/jbd2/journal.c
> > > > @@ -67,6 +67,7 @@ EXPORT_SYMBOL(jbd2_journal_set_triggers);
> > > >  EXPORT_SYMBOL(jbd2_journal_dirty_metadata);
> > > >  EXPORT_SYMBOL(jbd2_journal_forget);
> > > >  EXPORT_SYMBOL(jbd2_journal_flush);
> > > > +EXPORT_SYMBOL(jbd2_journal_flush_and_discard);
> > > >  EXPORT_SYMBOL(jbd2_journal_revoke);
> > > >
> > > >  EXPORT_SYMBOL(jbd2_journal_init_dev);
> > > > @@ -1686,6 +1687,90 @@ static void jbd2_mark_journal_empty(journal_t *journal, int write_op)
> > > >     write_unlock(&journal->j_state_lock);
> > > >  }
> > > >
> > > > +/* discard journal blocks excluding journal superblock */
> > > > +static int __jbd2_journal_issue_discard(journal_t *journal)
> > > > +{
> > > > +   int err = 0;
> > > > +   unsigned long block, log_offset;
> > > > +   unsigned long long phys_block, block_start, block_stop;
> > > > +   loff_t byte_start, byte_stop, byte_count;
> > > > +   struct request_queue *q = bdev_get_queue(journal->j_dev);
> > > > +
> > > > +   if (!q)
> > > > +           return -ENXIO;
> > > > +
> > > > +   if (!blk_queue_discard(q))
> > > > +           return -EOPNOTSUPP;
> > > > +
> > > > +   /* lookup block mapping and issue discard for each contiguous region */
> > > > +   log_offset = be32_to_cpu(journal->j_superblock->s_first);
> > > > +
> > > > +   err = jbd2_journal_bmap(journal, log_offset, &block_start);
> > > > +   if (err) {
> > > > +           printk(KERN_ERR "JBD2: bad block at offset %lu", log_offset);
> > > > +           return err;
> > > > +   }
> > > > +
> > > > +   /*
> > > > +    * use block_start - 1 to meet check for contiguous with previous region:
> > > > +    * phys_block == block_stop + 1
> > > > +    */
> > > > +   block_stop = block_start - 1;
> > > > +
> > > > +   for (block = log_offset; block < journal->j_total_len; block++) {
> > > > +           err = jbd2_journal_bmap(journal, block, &phys_block);
> > > > +           if (err) {
> > > > +                   printk(KERN_ERR "JBD2: bad block at offset %lu", block);
> > > > +                   return err;
> > > > +           }
> > > > +
> > > > +           /*
> > > > +            * if block is last block, update stopping point
> > > > +            * if not last block and
> > > > +            * block is contiguous with previous block, continue
> > > > +            */
> > > > +           if (block == journal->j_total_len - 1)
> > > > +                   block_stop = phys_block;
> > > > +           else if (phys_block == block_stop + 1) {
> > > > +                   block_stop++;
> > > > +                   continue;
> > > > +           }
> > > > +
> > > > +           /*
> > > > +            * if not contiguous with prior physical block or this is last
> > > > +            * block of journal, take care of the region
> > > > +            */
> > > > +           byte_start = block_start * journal->j_blocksize;
> > > > +           byte_stop = block_stop * journal->j_blocksize;
> > > > +           byte_count = (block_stop - block_start + 1) *
> > > > +                   journal->j_blocksize;
> > > > +
> > > > +           truncate_inode_pages_range(journal->j_dev->bd_inode->i_mapping,
> > > > +                   byte_start, byte_stop);
> > > > +
> > > > +           /*
> > > > +            * use blkdev_issue_discard instead of sb_issue_discard
> > > > +            * because superblock not yet populated when this is
> > > > +            * called during journal_load during mount process
> > > > +            */
> > > > +           err = blkdev_issue_discard(journal->j_dev,
> > > > +                   byte_start >> SECTOR_SHIFT,
> > > > +                   byte_count >> SECTOR_SHIFT,
> > > > +                   GFP_NOFS, 0);
> > > > +
> > > > +           if (unlikely(err != 0)) {
> > > > +                   printk(KERN_ERR "JBD2: unable to discard "
> > > > +                           "journal at physical blocks %llu - %llu",
> > > > +                           block_start, block_stop);
> > > > +                   return err;
> > > > +           }
> > > > +
> > > > +           block_start = phys_block;
> > > > +           block_stop = phys_block;
> > > > +   }
> > > > +
> > > > +   return blkdev_issue_flush(journal->j_dev);
> > > > +}
> > > >
> > > >  /**
> > > >   * jbd2_journal_update_sb_errno() - Update error in the journal.
> > > > @@ -1892,6 +1977,7 @@ int jbd2_journal_load(journal_t *journal)
> > > >  {
> > > >     int err;
> > > >     journal_superblock_t *sb;
> > > > +   struct request_queue *q = bdev_get_queue(journal->j_dev);
> > > >
> > > >     err = load_superblock(journal);
> > > >     if (err)
> > > > @@ -1936,6 +2022,12 @@ int jbd2_journal_load(journal_t *journal)
> > > >      */
> > > >     journal->j_flags &= ~JBD2_ABORT;
> > > >
> > > > +   /* if journal device supports discard, discard journal blocks */
> > > > +   if (q && blk_queue_discard(q)) {
> > > > +           if (__jbd2_journal_issue_discard(journal))
> > > > +                   printk(KERN_ERR "JBD2: failed to discard journal when loading");
> > > > +   }
> > > > +
> > > >     /* OK, we've finished with the dynamic journal bits:
> > > >      * reinitialise the dynamic contents of the superblock in memory
> > > >      * and reset them on disk. */
> > > > @@ -2244,15 +2336,18 @@ void jbd2_journal_clear_features(journal_t *journal, unsigned long compat,
> > > >  EXPORT_SYMBOL(jbd2_journal_clear_features);
> > > >
> > > >  /**
> > > > - * jbd2_journal_flush() - Flush journal
> > > > + * __jbd2_journal_flush() - Flush journal
> > > >   * @journal: Journal to act on.
> > > > + * @discard: flag (see below)
> > > >   *
> > > >   * Flush all data for a given journal to disk and empty the journal.
> > > >   * Filesystems can use this when remounting readonly to ensure that
> > > >   * recovery does not need to happen on remount.
> > > > + *
> > > > + * If 'discard' is false, the journal is simply flushed. If discard is true,
> > > > + * the journal is also discarded.
> > > >   */
> > > > -
> > > > -int jbd2_journal_flush(journal_t *journal)
> > > > +static int __jbd2_journal_flush(journal_t *journal, bool discard)
> > > >  {
> > > >     int err = 0;
> > > >     transaction_t *transaction = NULL;
> > > > @@ -2306,6 +2401,10 @@ int jbd2_journal_flush(journal_t *journal)
> > > >      * commits of data to the journal will restore the current
> > > >      * s_start value. */
> > > >     jbd2_mark_journal_empty(journal, REQ_SYNC | REQ_FUA);
> > > > +
> > > > +   if (discard)
> > > > +           err = __jbd2_journal_issue_discard(journal);
> > > > +
> > > >     mutex_unlock(&journal->j_checkpoint_mutex);
> > > >     write_lock(&journal->j_state_lock);
> > > >     J_ASSERT(!journal->j_running_transaction);
> > > > @@ -2318,6 +2417,17 @@ int jbd2_journal_flush(journal_t *journal)
> > > >     return err;
> > > >  }
> > > >
> > > > +int jbd2_journal_flush(journal_t *journal)
> > > > +{
> > > > +   return __jbd2_journal_flush(journal, false /* don't discard */);
> > > > +}
> > > > +
> > > > +/* flush journal and discard journal log */
> > > > +int jbd2_journal_flush_and_discard(journal_t *journal)
> > > > +{
> > > > +   return __jbd2_journal_flush(journal, true /* also discard */);
> > > > +}
> > > > +
> > > >  /**
> > > >   * jbd2_journal_wipe() - Wipe journal contents
> > > >   * @journal: Journal to act on.
> > > > diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
> > > > index 99d3cd051ac3..9bed34e9a273 100644
> > > > --- a/include/linux/jbd2.h
> > > > +++ b/include/linux/jbd2.h
> > > > @@ -1492,6 +1492,7 @@ extern int     jbd2_journal_invalidatepage(journal_t *,
> > > >  extern int  jbd2_journal_try_to_free_buffers(journal_t *journal, struct page *page);
> > > >  extern int  jbd2_journal_stop(handle_t *);
> > > >  extern int  jbd2_journal_flush (journal_t *);
> > > > +extern int  jbd2_journal_flush_and_discard(journal_t *journal);
> > > >  extern void         jbd2_journal_lock_updates (journal_t *);
> > > >  extern void         jbd2_journal_unlock_updates (journal_t *);
> > > >
> > > > --
> > > > 2.31.0.291.g576ba9dcdaf-goog
> > > >
> >
> > Thanks for the comments :)
