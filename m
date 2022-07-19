Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ACF857A90A
	for <lists+linux-ext4@lfdr.de>; Tue, 19 Jul 2022 23:35:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239771AbiGSVfT (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 19 Jul 2022 17:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232712AbiGSVfR (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 19 Jul 2022 17:35:17 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CF8DE08E
        for <linux-ext4@vger.kernel.org>; Tue, 19 Jul 2022 14:35:15 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id l14so9732203qtv.4
        for <linux-ext4@vger.kernel.org>; Tue, 19 Jul 2022 14:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gNyRolRa4SDv5wmylpdgPdd+HZ/UQh7gluwNd9i869E=;
        b=JMMDfsolJ5eWGe2gzdFYRAz/7aTPF2k7FSyOFqubmzcrCti/hyccem/94leLCYuvWk
         EjAkXg3Vrkff4r6CzGrX11IXUuZY73I5qpZXw8UBcU0dzMUoLu1m+L0fEmUdrfcwTNT2
         2Z9bJ5rGiOCwWbUzlbYkCVxHkr+OnL1OC4k699wlCTwWh6V5rLbsrtnvdZEfYrJd+26x
         CiWRkKdPBgnS8qzSS4Okba872MLLzpkds3jP986GjVEHXlrEMymH8j2LU6c2k0SH1Syg
         rpKl5W0H8YWaiZthB3UER80uGm4UWnmjr606eVxBDOSkiOAP10SkhXD6JcFzcmVeqXhs
         Np2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gNyRolRa4SDv5wmylpdgPdd+HZ/UQh7gluwNd9i869E=;
        b=CiO3OCD6Jgz7eGZRNZ7S4Jpg1ZXuTzNYnMS1EL2wxYG8DdZTJk5whvJrx/4MM16mru
         10QVXGaOR95CeE7dQfLiIqyC4F8sD0ZRCsCEsDN0K7KS18bBHxLUQWkNgl23h934iiHO
         OgbpdNhyBaBDgfAltx7YpR2GbSfZE0E2eBiMBhTXL4hrfZf9PV3Inb0PCGM1RxDibgFv
         4cdjaiSolV+m+fK0lQjXv/+7R8Cj85M+wwD0Pbv+CIwFJEjSI15WNkP8Elq2J1IBbCcz
         grh8ObK3AHh3vKgcdNShoNASD5v1V/4Y9PFCDlbMQ/7wHSfImWHWynB4PJnefzQG5RBa
         WmBg==
X-Gm-Message-State: AJIora+M1fdbyLC7vPgAzVBPLgc36dSkNt6+lrduO+tnP0alTxdKOoIe
        IXZmzCkF358BAqDFQxA32F4LPwzNTPI=
X-Google-Smtp-Source: AGRyM1s8MizoVUDIgO08j3TuSGemZ9TuCi7yo80bSFTHXahi9jy5x4x5vhkTQOck/UF8hnZirlJ6lQ==
X-Received: by 2002:ac8:5a50:0:b0:31e:f587:f891 with SMTP id o16-20020ac85a50000000b0031ef587f891mr7316042qta.10.1658266514108;
        Tue, 19 Jul 2022 14:35:14 -0700 (PDT)
Received: from debian-BULLSEYE-live-builder-AMD64 (h96-61-90-13.cntcnh.broadband.dynamic.tds.net. [96.61.90.13])
        by smtp.gmail.com with ESMTPSA id u5-20020a05620a430500b006b5bf5d45casm16389070qko.27.2022.07.19.14.35.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 14:35:13 -0700 (PDT)
Date:   Tue, 19 Jul 2022 17:35:12 -0400
From:   Eric Whitney <enwlinux@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Eric Whitney <enwlinux@gmail.com>, linux-ext4@vger.kernel.org,
        tytso@mit.edu
Subject: Re: [PATCH] ext4: minor defrag code improvements
Message-ID: <YtcjkMcYQCATlt0Y@debian-BULLSEYE-live-builder-AMD64>
References: <20220621143340.2268087-1-enwlinux@gmail.com>
 <20220714115326.qhjsrchoepnnsffu@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220714115326.qhjsrchoepnnsffu@quack3>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

* Jan Kara <jack@suse.cz>:
> On Tue 21-06-22 10:33:40, Eric Whitney wrote:
> > Modify two error paths returning EBUSY for bad argument file types to
> > return EOPNOTSUPP instead.  Move an extent tree search whose results are
> > only occasionally required to the site always requiring them for
> > improved efficiency.  Address a few typos.
> > 
> > Signed-off-by: Eric Whitney <enwlinux@gmail.com>
> 
> So why is EOPNOTSUPP better than EBUSY? Honestly we are rather inconsistent
> with errors returned for various operations on swapfile -
> read/write/fallocate/truncate return ETXTBSY, unlink returns EPERM, some
> ext4 ioctls return EINVAL... I guess ETXTBSY is the most common return
> value?
> 
> Otherwise the patch looks good.
> 
> 								Honza

Hi Jan - thanks for your review.

I think EOPNOTSUPP is better than EBUSY when EXT4_IOC_MOVE_EXT is applied to
a swap file because it's a much more direct message indicating that ext4
doesn't support swap file defragmentation.  With the exception of the two
sites modified by this patch, all the other sites in the defrag code where
checks are made for unsupported file types or file system configurations,
EOPNOTSUPP is returned.  Because EBUSY really doesn't seem to convey what's
happening here very well - this isn't so much a case of a potentially
temporarily busy resource as an attempt to perform an operation that will
never succeed - another choice seemed more appropriate.  I picked EOPNOTSUPP
simply because it's used in those other sites in the defrag code, and was
trying to be consistent. (The defrag code reports EBUSYs when it can't
release pages with references on them.)

EINVAL could be an alternative.  It's not quite as direct but it does
convey the idea that an argument to the ioctl is wrong.  The defrag code
uses it (a little inconsistently) when argument values are out of range or
otherwise invalid.

Is ETXTBUSY still reported by the kernel?  I couldn't find it in a search after
reading this:  lwn.net/Articles/866493/
I didn't consider that because an executable wasn't involved - interesting that
it was used for some operations applied to swap files.

At any rate, I'm open to suggestions here - just trying to clean up a few
things after a little code review.

Thanks,
Eric

> 
> > ---
> >  fs/ext4/move_extent.c | 16 +++++++---------
> >  1 file changed, 7 insertions(+), 9 deletions(-)
> > 
> > diff --git a/fs/ext4/move_extent.c b/fs/ext4/move_extent.c
> > index 701f1d6a217f..4e4b0452106e 100644
> > --- a/fs/ext4/move_extent.c
> > +++ b/fs/ext4/move_extent.c
> > @@ -472,19 +472,17 @@ mext_check_arguments(struct inode *orig_inode,
> >  	if (IS_IMMUTABLE(donor_inode) || IS_APPEND(donor_inode))
> >  		return -EPERM;
> >  
> > -	/* Ext4 move extent does not support swapfile */
> > +	/* Ext4 move extent does not support swap files */
> >  	if (IS_SWAPFILE(orig_inode) || IS_SWAPFILE(donor_inode)) {
> > -		ext4_debug("ext4 move extent: The argument files should "
> > -			"not be swapfile [ino:orig %lu, donor %lu]\n",
> > +		ext4_debug("ext4 move extent: The argument files should not be swap files [ino:orig %lu, donor %lu]\n",
> >  			orig_inode->i_ino, donor_inode->i_ino);
> > -		return -EBUSY;
> > +		return -EOPNOTSUPP;
> >  	}
> >  
> >  	if (ext4_is_quota_file(orig_inode) && ext4_is_quota_file(donor_inode)) {
> > -		ext4_debug("ext4 move extent: The argument files should "
> > -			"not be quota files [ino:orig %lu, donor %lu]\n",
> > +		ext4_debug("ext4 move extent: The argument files should not be quota files [ino:orig %lu, donor %lu]\n",
> >  			orig_inode->i_ino, donor_inode->i_ino);
> > -		return -EBUSY;
> > +		return -EOPNOTSUPP;
> >  	}
> >  
> >  	/* Ext4 move extent supports only extent based file */
> > @@ -631,11 +629,11 @@ ext4_move_extents(struct file *o_filp, struct file *d_filp, __u64 orig_blk,
> >  		if (ret)
> >  			goto out;
> >  		ex = path[path->p_depth].p_ext;
> > -		next_blk = ext4_ext_next_allocated_block(path);
> >  		cur_blk = le32_to_cpu(ex->ee_block);
> >  		cur_len = ext4_ext_get_actual_len(ex);
> >  		/* Check hole before the start pos */
> >  		if (cur_blk + cur_len - 1 < o_start) {
> > +			next_blk = ext4_ext_next_allocated_block(path);
> >  			if (next_blk == EXT_MAX_BLOCKS) {
> >  				ret = -ENODATA;
> >  				goto out;
> > @@ -663,7 +661,7 @@ ext4_move_extents(struct file *o_filp, struct file *d_filp, __u64 orig_blk,
> >  		donor_page_index = d_start >> (PAGE_SHIFT -
> >  					       donor_inode->i_blkbits);
> >  		offset_in_page = o_start % blocks_per_page;
> > -		if (cur_len > blocks_per_page- offset_in_page)
> > +		if (cur_len > blocks_per_page - offset_in_page)
> >  			cur_len = blocks_per_page - offset_in_page;
> >  		/*
> >  		 * Up semaphore to avoid following problems:
> > -- 
> > 2.30.2
> > 
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
