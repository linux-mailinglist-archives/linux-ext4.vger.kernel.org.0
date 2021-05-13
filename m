Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 143E737FF0D
	for <lists+linux-ext4@lfdr.de>; Thu, 13 May 2021 22:27:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232860AbhEMU2h (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 13 May 2021 16:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232845AbhEMU2g (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 13 May 2021 16:28:36 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F3C8C061574
        for <linux-ext4@vger.kernel.org>; Thu, 13 May 2021 13:27:26 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id 76so26783490qkn.13
        for <linux-ext4@vger.kernel.org>; Thu, 13 May 2021 13:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/S8+aAfgl/yImqy9yxRRCpay02xe0BIIIa9gQvM5ZVw=;
        b=VJa2VjcwBmSQ4HllLNKZdWjtyBHsgn0ChHYPycOf6JBHtk/gm6sFW2jW7agbEy0/yM
         UhKB89e1JV1DhdoMkau+2BqU8LCn96jflA/lLSpzVOm9NTzuO4DGQOzP4kUor3r9Rja7
         4xHKcRPwAHNowRMu4V0EWnpyi8/4MXrhnb+1Lsay+nckJJraRhyskQ6EqQ/elvkHawAy
         qxuSyqI5h+r6JiObB4yvhOYUXAG3H9fcMDIFs1shv03+xXF3vgKU/GdKNEuxyAXIW7pg
         dwitHZj+3L08z6GUWukrsIpwCf6Bev0nKosj7vRPZi5v7vAdocJCPa+pXOQafa6ha/fk
         cUXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/S8+aAfgl/yImqy9yxRRCpay02xe0BIIIa9gQvM5ZVw=;
        b=C4N7+Xq031VdcfLSuMgZrTni/7kmbvEYj0I/xu3qNjesHsf3rfxsetb+e2Ht7SD+Bf
         O01obfi5zwiFyahrJmWrMdbykmfH8Ax1dyq9b6af8tUCSjqCq3Mw7k2Gg9hFfopUXyB3
         J0yWylsyQM6Eo7Ww+aQMC9hLjpt7uvaxLRiv/02o2Blr0MkXI5zklMyIs6Ya2HRiKKQN
         nfQcxeq7zXKjrwduJENk1ReRT8skQlsrYrlNLZ1AjmaK9Ne80xWkNcfqN+N4JA4nPv2x
         FocBDFfCVYMYHMm75PAVoek14EGKAyqPHOXx/6VG352EPlBFzt8buE3FgXZUfJNHf104
         n+0w==
X-Gm-Message-State: AOAM532mJZp1rfd09h9NM43nx8V9AI6Hxngljfvawti1285CjDR2idA6
        5tPVChwbfouSFVJbqwf7lNLfbdRGOm9yyA==
X-Google-Smtp-Source: ABdhPJxeboZoTBfVE4omeZrl0K5ehpF4C9oKkMQBXu2m9OoROqTF025EXgL/JGTDYzYZeja+lCSoqw==
X-Received: by 2002:a37:5ca:: with SMTP id 193mr39739856qkf.356.1620937645325;
        Thu, 13 May 2021 13:27:25 -0700 (PDT)
Received: from google.com ([2601:4c3:201:ed00:8626:664b:8242:8ae7])
        by smtp.gmail.com with ESMTPSA id s5sm3297865qkg.88.2021.05.13.13.27.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 May 2021 13:27:25 -0700 (PDT)
Date:   Thu, 13 May 2021 16:27:23 -0400
From:   Leah Rumancik <leah.rumancik@gmail.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH v4 1/3] ext4: add discard/zeroout flags to journal flush
Message-ID: <YJ2Lq4rTCv7RciL1@google.com>
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
> 

Just to make sure I understand correctly, the explicit __u32 is critical
due to the size being read in by the ioctl, specifically through
copy_from_user? When do you switch from __u32 to unsigned long? I don't
see the __* types being carried throughout.

(Also, just got Darrick's reply about the 32 vs. 64. Yes, originally
went with 64 because there was an argument for it. I believe the 32
is likely sufficient, but I don't feel that strongly about this matter)

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

Why call them JBD2_JOURNAL_FLUSH* instead of JBD2_JOURNAL_ERASE* since
they get passed directly through to the erase function? I feel like it
would be weird if someone wanted to use the erase function directly but
had to use JBD2_JOURNAL_FLUSH* flags.

>      if ((flags & ~JBD2_JOURNAL_FLUSH_VALID) ||
>          ((flags & JBD2_JOURNAL_FLUSH_DISCARD) &&
> 	  (flags & JBD2_JOURNAL_FLUSH_ZEROOUT)))
> 	return -EINVAL;
> 
Ah, great. Thanks!

> > +
> > +	err = jbd2_journal_bmap(journal, log_offset, &block_start);
> > +	if (err) {
> > +		printk(KERN_ERR "JBD2: bad block at offset %lu", log_offset);
> > +		return err;
> > +	}
> 
> We could get rid of this, and instead make sure block_start is initialized
> to ~((unsigned long long) 0).  Then in the loop we can do...
> 
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

I'll play around with this and see if I can get it to work. Seems like
it might simplify the code a bit.

> ... and then let block_start and block_stop be initialized in a single
> place.  Do you agree?  Does this make sense to you?
> 
> 	       	       	    	      	    - Ted


Thanks!
Leah
