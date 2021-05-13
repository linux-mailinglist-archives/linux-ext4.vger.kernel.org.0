Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47E5A37FEC5
	for <lists+linux-ext4@lfdr.de>; Thu, 13 May 2021 22:18:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232535AbhEMUTZ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 13 May 2021 16:19:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:43914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232513AbhEMUTY (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 13 May 2021 16:19:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E433E613CB;
        Thu, 13 May 2021 20:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620937094;
        bh=W9MrwOqUNvsM8PkLUhR26DHv1FlZ5/cUY1DXnkIrsK8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GQH884ivptZyg9EEY6uVSuJ7Lj2ZiJA4R4KjZMrhvZ/0ZoSI5ze+S/xMhOhH/T+5B
         Ogww+S8VPebf7JYkUBuG5ZQ+wpor/EMZhxWWl2c4Duob9h8sIrMfOHOdEMuKijzX4j
         b+MYwdwZnTZaPiNEEgFxuVcA4qipmngxqwT6W5JwFWyNlD9WIjem34/O3SpqRIS0Tz
         EzGzVOK5DSLsYhIlf/1dU6CFH3i+OcL9FDEN7q32GQKoFZh/Ja+myq3HXhMU5tIPAg
         S48LKu8a45syeRpp4/8w4pMQoanR1UWww7A00wl4Ya5j781fgoocFxiqldJNT/Ctaz
         5vT6usriB9SBQ==
Date:   Thu, 13 May 2021 13:18:12 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Leah Rumancik <leah.rumancik@gmail.com>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH v4 1/3] ext4: add discard/zeroout flags to journal flush
Message-ID: <20210513201812.GA9617@magnolia>
References: <20210511180428.3358267-1-leah.rumancik@gmail.com>
 <YJ1rVr7Sf7Az+MQm@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YJ1rVr7Sf7Az+MQm@mit.edu>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, May 13, 2021 at 02:09:26PM -0400, Theodore Ts'o wrote:
> On Tue, May 11, 2021 at 06:04:26PM +0000, Leah Rumancik wrote:
> > @@ -3223,7 +3223,7 @@ static sector_t ext4_bmap(struct address_space *mapping, sector_t block)
> >  		ext4_clear_inode_state(inode, EXT4_STATE_JDATA);
> >  		journal = EXT4_JOURNAL(inode);
> >  		jbd2_journal_lock_updates(journal);
> > -		err = jbd2_journal_flush(journal);
> > +		err = jbd2_journal_flush(journal, 0);
> 
> In the ocfs2 changes, I noticed you are using "false", instead of 0,
> in the second argument to jbd2_journal_flush.
> 
> When I looked more closely, the function signature of
> jbd2_journal_flush is also using an unsigned long long for flags,
> which struck me as strange:
> 
> > +extern int	 jbd2_journal_flush(journal_t *journal, unsigned long long flags);
> 
> I then noticed that later in the patch series, the ioctl argument is
> taking an unsigned long long and we're passing that straight through
> to jbd2_journal_flush().
> 
> First of all, unsigned long long is not very efficient on many
> platforms (especially 32-bit platforms), but also on platforms where
> int is 32 bits.  If we don't expect us to need more than 32 flag bits,
> I'd suggest explicit ly using __u32 in ioctl interface.  (__u32 is
> fine; it's the use of the base int type which can get us into trouble,
> since int can be either 32 or 64 bits depending on the architecture).

FWIW I had been advocating for u64 for the ioctl interface since that's
the hardest part to change; once we've gotten that into the kernel and
remapped the ioctl flags to jbd2 flags, you can do whatever you want.

> Secondly, I'd suggest using a different set of flags for
> jbd2_journal_flush(), which is an internal kernel interface, and the
> EXT4_IOC_CHECKPOINT interface.  We might in the future want to add
> some internal flags to jbd2_journal_flush that we do *not* want to
> expose via EXT4_IOC_CHECKPOINT, and so it's best that we keep those
> two interfaces separate.
> 
> > diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> > index 2dc944442802..f86929dbca3c 100644
> > --- a/fs/jbd2/journal.c
> > +++ b/fs/jbd2/journal.c
> > @@ -1686,6 +1686,106 @@ static void jbd2_mark_journal_empty(journal_t *journal, int write_op)
> >  	write_unlock(&journal->j_state_lock);
> >  }
> >  
> > +#define JBD2_ERASE_FLAG_DISCARD	1
> > +#define JBD2_ERASE_FLAG_ZEROOUT	2
> 
> I'd suggest defining these in include/linux/jbd2.h, and giving them
> names like: JBD2_JOURNAL_FLUSH_DISCARD and JBD2_JOURNAL_FLUSH_ERASE...
> (and making the flags parameter an unsigned int).
> 
> > +	/* flags must be set to either discard or zeroout */
> > +	if ((flags & JBD2_ERASE_FLAG_DISCARD & JBD2_ERASE_FLAG_ZEROOUT) || !flags)
> > +		return -EINVAL;
> 
> The expression (flags & JBD2_ERASE_FLAG_DISCARD & JBD2_ERASE_FLAG_ZEROOUT)
> is always going to evaluate to zero, since (1 & 2) is 0.
> 
> What you probably want is something like:
> 
> #define JBD2_JOURNAL_FLUSH_DISCARD	0x0001
> #define JBD2_JOURNAL_FLUSH_ZEROOUT	0x0002
> #define JBD2_JOURNAL_FLUSH_VALID	0x0003
> 
>      if ((flags & ~JBD2_JOURNAL_FLUSH_VALID) ||
>          ((flags & JBD2_JOURNAL_FLUSH_DISCARD) &&
> 	  (flags & JBD2_JOURNAL_FLUSH_ZEROOUT)))
> 	return -EINVAL;
> 
> > +
> > +	err = jbd2_journal_bmap(journal, log_offset, &block_start);
> > +	if (err) {
> > +		printk(KERN_ERR "JBD2: bad block at offset %lu", log_offset);
> > +		return err;
> > +	}
> 
> We could get rid of this, and instead make sure block_start is initialized
> to ~((unsigned long long) 0).  Then in the loop we can do...

Also FWIW I can't find the fiemap code that let you do fiemap from
within the kernel, so I guess we only talked about it on fsdevel and
none of it ever got merged.  So I guess looping is what we'll have to do
for now...

--D

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
> 
> 		if (block_start == ~((unsigned long long) 0)) {
> 			block_start = phys_block;
> 			block_Stop = block_start - 1;
> 		}
> 
> > +
> > +		if (block == journal->j_total_len - 1) {
> > +			block_stop = phys_block;
> > +		} else if (phys_block == block_stop + 1) {
> > +			block_stop++;
> > +			continue;
> > +		}
> > +
> > +		/*
> > +		 * not contiguous with prior physical block or this is last
> > +		 * block of journal, take care of the region
> > +		 */
> > +		byte_start = block_start * journal->j_blocksize;
> > +		byte_stop = block_stop * journal->j_blocksize;
> > +		byte_count = (block_stop - block_start + 1) *
> > +				journal->j_blocksize;
> > +
> > +		truncate_inode_pages_range(journal->j_dev->bd_inode->i_mapping,
> > +				byte_start, byte_stop);
> > +
> > +		if (flags & JBD2_ERASE_FLAG_DISCARD) {
> > +			err = blkdev_issue_discard(journal->j_dev,
> > +					byte_start >> SECTOR_SHIFT,
> > +					byte_count >> SECTOR_SHIFT,
> > +					GFP_NOFS, 0);
> > +		} else if (flags & JBD2_ERASE_FLAG_ZEROOUT) {
> > +			err = blkdev_issue_zeroout(journal->j_dev,
> > +					byte_start >> SECTOR_SHIFT,
> > +					byte_count >> SECTOR_SHIFT,
> > +					GFP_NOFS, 0);
> > +		}
> > +
> > +		if (unlikely(err != 0)) {
> > +			printk(KERN_ERR "JBD2: (error %d) unable to wipe journal at physical blocks %llu - %llu",
> > +					err, block_start, block_stop);
> > +			return err;
> > +		}
> > +
> > +		block_start = phys_block;
> > +		block_stop = phys_block;
> 
> Is this right?  When we initialized the loop, above, block_stop was
> set to block_start-1 (where block_start == phys_block).  So I think it
> might be more correct to replace the above two lines with:
> 
> 		block_start = ~((unsigned long long) 0);
> 
> ... and then let block_start and block_stop be initialized in a single
> place.  Do you agree?  Does this make sense to you?
> 
> 	       	       	    	      	    - Ted
