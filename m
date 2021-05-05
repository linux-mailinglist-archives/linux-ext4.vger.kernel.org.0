Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5E453746F4
	for <lists+linux-ext4@lfdr.de>; Wed,  5 May 2021 19:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235267AbhEERf4 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 5 May 2021 13:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234168AbhEER1T (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 5 May 2021 13:27:19 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACE70C026CFE
        for <linux-ext4@vger.kernel.org>; Wed,  5 May 2021 09:55:17 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id n2so3933846ejy.7
        for <linux-ext4@vger.kernel.org>; Wed, 05 May 2021 09:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vP0ok1PNYlL9yVnCYlkI3yR2QD072gSKXIsqPIbFGv8=;
        b=ozYXv71tsARFMn16DR+pckKMVngOk2OWiU0cuiJyy6yKcJRByzNsAcZkx7MdgeDEg6
         I4TZdALQ7Y+3xA4CC89WB3c2CNg0SS6N6cGdmrKZy7KYqlORVCv+IwmaUhZ2zxDzd/2c
         PZKuMhhmwHrw+ECAXV1ev/PbPyKmLuwMC0Hc31/I/YzmDIeXkV4ecO+aSVLlRmTKDGD9
         4x7LGgrAv3aSvRCpn9Iqme+VgBzwxzHwCQHg2vz1rIekpeS/R5ajMyvwipVfRbW1jr+4
         2vQ/9KxI+IqZIcBouF7DkgQhFXBDwT8MyaexxhaPVHC3OOCFGeZKkR1WD5vgJKav8pQa
         Lp4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vP0ok1PNYlL9yVnCYlkI3yR2QD072gSKXIsqPIbFGv8=;
        b=Iayzo/xKhdxPT/CcEveLdwk9ehNT39hS0QPG6yvN3RW3k0xiLmHB7ThcxZELpOsxb3
         5muPRlQjuz8vXZTvaVOf8CvVP8e8sf4xAG/ukJ432GvnmtmDGD6pXIpq4Jzx1iSuNYui
         1epRfGmRdDy3olGx6/t9AJCWAqtU//XOerpSI6OfrtI974uS3KG4HU7bzNSDFe+Tq1L9
         apwrkqzd9772/U158cl0twId5GIKKFFQVHDP8vI8jR14mJJXAlkaFUX+BEUDjP0+G7wX
         ijZXIT+G0xOcgwFjHCy9Qrtp5SmlP7URPABNgyxRLBLDcZYyUUuoAehRRjNvcGRomrUm
         XTbw==
X-Gm-Message-State: AOAM530t+SGDbhNSN6I77yqkdlt9fJdilXSbQkIkaNfnh979snzaI6H+
        +Rf/w9Tbw3OzatT5zqIsmA8lC/l2p3OW+9gDsBk=
X-Google-Smtp-Source: ABdhPJxvw7cKloXf6+9syD5rXfek77ToBE7SENfoWUe9R5YK4u0i2T/Z03P4s5mB9Tqj1ShUacSQIVHeXvCwFR6qySc=
X-Received: by 2002:a17:906:8a51:: with SMTP id gx17mr25822994ejc.549.1620233716222;
 Wed, 05 May 2021 09:55:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210504163550.1486337-1-leah.rumancik@gmail.com> <20210504163550.1486337-2-leah.rumancik@gmail.com>
In-Reply-To: <20210504163550.1486337-2-leah.rumancik@gmail.com>
From:   harshad shirwadkar <harshadshirwadkar@gmail.com>
Date:   Wed, 5 May 2021 09:55:04 -0700
Message-ID: <CAD+ocbwV+tNye-xihUEw7Vu=VA3P96fdNV3QGzu1zQd-ufcstA@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] ext4: add ioctl EXT4_IOC_CHECKPOINT
To:     Leah Rumancik <leah.rumancik@gmail.com>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Leah,

Thanks for the patch. The patch mostly looks good. But, I noticed that
this patch doesn't apply on Ext4 dev tree. Could you please rebase it
on the dev tree? Other than that, I have left some minor comments
below:

On Tue, May 4, 2021 at 9:39 AM Leah Rumancik <leah.rumancik@gmail.com> wrote:
>
> ioctl EXT4_IOC_CHECKPOINT checkpoints and flushes the journal. This
> includes forcing all the transactions to the log, checkpointing the
> transactions, and flushing the log to disk. This ioctl takes u64 "flags"
> as an argument. With the EXT4_IOC_CHECKPOINT_FLAG_DISCARD flag set, the
> journal blocks are also discarded.
>
> Systems that wish to achieve content deletion SLO can set up a daemon
> that calls this ioctl at a regular interval such that it matches with the
> SLO requirement. Thus, with this patch, the ext4_dir_entry2 wipeout
> patch[1], and the Ext4 "-o discard" mount option set, Ext4 can now
> guarantee that all data will be erased and discarded on deletion. Note
> that this ioctl won't write zeros if the device doesn't support discards.
>
> The __jbd2_journal_issue_discard function could also be used to discard the
> journal (if discard is supported) during journal load after recovery. This
> would provide a potential solution to a journal replay bug reported earlier
> this year[2] for block devices that support discard. After a successful
> journal recovery, e2fsck can call this ioctl to discard the journal as
> well.
>
> [1] https://lore.kernel.org/linux-ext4/YIHknqxngB1sUdie@mit.edu/
> [2] https://lore.kernel.org/linux-ext4/YDZoaacIYStFQT8g@mit.edu/
>
> Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
> ---
>  fs/ext4/ext4.h    |  4 +++
>  fs/ext4/ioctl.c   | 38 +++++++++++++++++++++++
>  fs/jbd2/journal.c | 79 +++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 121 insertions(+)
>
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 18f021c988a1..2fe8565706fc 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -715,6 +715,7 @@ enum {
>  #define EXT4_IOC_CLEAR_ES_CACHE                _IO('f', 40)
>  #define EXT4_IOC_GETSTATE              _IOW('f', 41, __u32)
>  #define EXT4_IOC_GET_ES_CACHE          _IOWR('f', 42, struct fiemap)
> +#define EXT4_IOC_CHECKPOINT            _IOW('f', 43, __u64)
>
>  #define EXT4_IOC_SHUTDOWN _IOR ('X', 125, __u32)
>
> @@ -736,6 +737,9 @@ enum {
>  #define EXT4_STATE_FLAG_NEWENTRY       0x00000004
>  #define EXT4_STATE_FLAG_DA_ALLOC_CLOSE 0x00000008
>
> +/* flag to enable discarding journal blocks through ioctl EXT4_IOC_CHECKPOINT */
> +#define EXT4_IOC_CHECKPOINT_FLAG_DISCARD       1
> +
>  #if defined(__KERNEL__) && defined(CONFIG_COMPAT)
>  /*
>   * ioctl commands in 32 bit emulation
> diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
> index ef809feb7e77..839ffd067357 100644
> --- a/fs/ext4/ioctl.c
> +++ b/fs/ext4/ioctl.c
> @@ -794,6 +794,40 @@ static int ext4_ioctl_get_es_cache(struct file *filp, unsigned long arg)
>         return error;
>  }
>
> +static int ext4_ioctl_checkpoint(struct file *filp, unsigned long arg)
> +{
> +       int err = 0;
> +       unsigned long long flags = 0;
> +       struct super_block *sb = file_inode(filp)->i_sb;
> +
> +       if (!capable(CAP_SYS_ADMIN))
> +               return -EPERM;
> +
> +       /* file argument is not the mount point */
> +       if (file_dentry(filp) != sb->s_root)
> +               return -EINVAL;
> +
> +       /* filesystem is not backed by block device */
> +       if (sb->s_bdev == NULL)
> +               return -EINVAL;
> +
> +       if (copy_from_user(&flags, (__u64 __user *)arg,
> +                               sizeof(__u64)))
> +               return -EFAULT;
> +
> +       /* flags can only be 0 or EXT4_IOC_CHECKPOINT_FLAG_DISCARD */
> +       if (flags & ~EXT4_IOC_CHECKPOINT_FLAG_DISCARD)
> +               return -EINVAL;
> +
> +       if (EXT4_SB(sb)->s_journal) {
> +               jbd2_journal_lock_updates(EXT4_SB(sb)->s_journal);
> +               err = jbd2_journal_flush(EXT4_SB(sb)->s_journal,
> +                       flags & EXT4_IOC_CHECKPOINT_FLAG_DISCARD);
> +               jbd2_journal_unlock_updates(EXT4_SB(sb)->s_journal);
> +       }
It seems like you are returning 0 if no journal is found? Is that
intentional? I think returning -EINVAL would be better. Also while
we're at it, arranging this if condition as follows might slightly
better:

if (!EXT4_SB(sb)->s_journal))
   return -EINVAL;

jbd2_journal_lock_updates(EXT4_SB(sb)->s_journal);
err = jbd2_journal_flush(EXT4_SB(sb)->s_journal,
             flags & EXT4_IOC_CHECKPOINT_FLAG_DISCARD);
jbd2_journal_unlock_updates(EXT4_SB(sb)->s_journal);
return err;
>  static long __ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>  {
>         struct inode *inode = file_inode(filp);
> @@ -1205,6 +1239,9 @@ static long __ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>                 return fsverity_ioctl_read_metadata(filp,
>                                                     (const void __user *)arg);
>
> +       case EXT4_IOC_CHECKPOINT:
> +               return ext4_ioctl_checkpoint(filp, arg);
> +
>         default:
>                 return -ENOTTY;
>         }
> @@ -1285,6 +1322,7 @@ long ext4_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
>         case EXT4_IOC_CLEAR_ES_CACHE:
>         case EXT4_IOC_GETSTATE:
>         case EXT4_IOC_GET_ES_CACHE:
> +       case EXT4_IOC_CHECKPOINT:
FYI, this hunk fails to apply.
>                 break;
>         default:
>                 return -ENOIOCTLCMD;
> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> index 4b7953934c82..ce33e4817aab 100644
> --- a/fs/jbd2/journal.c
> +++ b/fs/jbd2/journal.c
> @@ -1686,6 +1686,80 @@ static void jbd2_mark_journal_empty(journal_t *journal, int write_op)
>         write_unlock(&journal->j_state_lock);
>  }
>
> +/* discard journal blocks excluding journal superblock */
> +static int __jbd2_journal_issue_discard(journal_t *journal)
> +{
> +       int err = 0;
> +       unsigned long block, log_offset; /* logical */
> +       unsigned long long phys_block, block_start, block_stop; /* physical */
> +       loff_t byte_start, byte_stop, byte_count;
> +       struct request_queue *q = bdev_get_queue(journal->j_dev);
> +
> +       if (!q)
> +               return -ENXIO;
> +
> +       if (!blk_queue_discard(q))
> +               return -EOPNOTSUPP;
> +
> +       /* lookup block mapping and issue discard for each contiguous region */
> +       log_offset = be32_to_cpu(journal->j_superblock->s_first);
> +
> +       err = jbd2_journal_bmap(journal, log_offset, &block_start);
> +       if (err) {
> +               printk(KERN_ERR "JBD2: bad block at offset %lu", log_offset);
> +               return err;
> +       }
> +
> +       /*
> +        * use block_start - 1 to meet check for contiguous with previous region:
> +        * phys_block == block_stop + 1
> +        */
> +       block_stop = block_start - 1;
> +
> +       for (block = log_offset; block < journal->j_total_len; block++) {
> +               err = jbd2_journal_bmap(journal, block, &phys_block);
> +               if (err) {
> +                       printk(KERN_ERR "JBD2: bad block at offset %lu", block);
> +                       return err;
> +               }
> +
> +               if (block == journal->j_total_len - 1)
> +                       block_stop = phys_block;
(nit) Given that else if is a multi-line block, can you also added
braces for the if condition (like in else if)?
> +               else if (phys_block == block_stop + 1) {
> +                       block_stop++;
> +                       continue;
> +               }
> +
> +               /*
> +                * not contiguous with prior physical block or this is last
> +                * block of journal, take care of the region
> +                */
> +               byte_start = block_start * journal->j_blocksize;
> +               byte_stop = block_stop * journal->j_blocksize;
> +               byte_count = (block_stop - block_start + 1) *
> +                       journal->j_blocksize;
> +
> +               truncate_inode_pages_range(journal->j_dev->bd_inode->i_mapping,
> +                       byte_start, byte_stop);
> +
> +               err = blkdev_issue_discard(journal->j_dev,
> +                       byte_start >> SECTOR_SHIFT,
> +                       byte_count >> SECTOR_SHIFT,
> +                       GFP_NOFS, 0);
> +
> +               if (unlikely(err != 0)) {
> +                       printk(KERN_ERR "JBD2: unable to discard "
> +                               "journal at physical blocks %llu - %llu",
> +                               block_start, block_stop);
I think it will be good to print the err received as well.

Thanks,
Harshad
> +                       return err;
> +               }
> +
> +               block_start = phys_block;
> +               block_stop = phys_block;
> +       }
> +
> +       return blkdev_issue_flush(journal->j_dev);
> +}
>
>  /**
>   * jbd2_journal_update_sb_errno() - Update error in the journal.
> @@ -2246,6 +2320,7 @@ EXPORT_SYMBOL(jbd2_journal_clear_features);
>  /**
>   * jbd2_journal_flush() - Flush journal
>   * @journal: Journal to act on.
> + * @discard: discard the journal blocks
>   *
>   * Flush all data for a given journal to disk and empty the journal.
>   * Filesystems can use this when remounting readonly to ensure that
> @@ -2305,6 +2380,10 @@ int jbd2_journal_flush(journal_t *journal, bool discard)
>          * commits of data to the journal will restore the current
>          * s_start value. */
>         jbd2_mark_journal_empty(journal, REQ_SYNC | REQ_FUA);
> +
> +       if (discard)
> +               err = __jbd2_journal_issue_discard(journal);
> +
>         mutex_unlock(&journal->j_checkpoint_mutex);
>         write_lock(&journal->j_state_lock);
>         J_ASSERT(!journal->j_running_transaction);
> --
> 2.31.1.527.g47e6f16901-goog
>
