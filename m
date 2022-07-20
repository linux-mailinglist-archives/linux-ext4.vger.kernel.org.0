Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ADFD57B93F
	for <lists+linux-ext4@lfdr.de>; Wed, 20 Jul 2022 17:11:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241132AbiGTPLp (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 20 Jul 2022 11:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241084AbiGTPLn (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 20 Jul 2022 11:11:43 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5B3052FF9
        for <linux-ext4@vger.kernel.org>; Wed, 20 Jul 2022 08:11:41 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id h22so13536468qta.3
        for <linux-ext4@vger.kernel.org>; Wed, 20 Jul 2022 08:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+fyOSDGFhiRg3U5D3lu09JNRPejVKpHF7EXIm583gb0=;
        b=VG0Mdy9OVVMctpa+RajbkcrTqgg0awPph0h9S40RZzWdg4urSpyIre1LsETyx8C1cM
         E4ZE9nB/Mx3t9XFgdQBAwNOr/LlWRrzyz9R8QrAZ57AMphoT6hMhGZoFZVKFvuXeHakg
         k5UYNgP7cXST0zubrwM8jdleBlxz8YIK2kTcpxbVUfnRgpS9Wb/WFn4uLT005b2rZL0w
         YOse4ZgYFuD92y6PGjREIaPVf/BkUV1bDIpl8CXyK+ncu8ZWqWWS6Vode1gCLUJ2rncW
         kDd6AhiQRRuweZU//3GcCAP1FlfEo54ryOHu4C1lERSh983bJ7utTyYDx4jiPCGMYKu3
         pcXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+fyOSDGFhiRg3U5D3lu09JNRPejVKpHF7EXIm583gb0=;
        b=DKtZmZeOPY80+N+kqKtdRER1rzOUogPxgsBgibNwlJFyQ/GVpoJPcr6uxa5gbGQpO9
         7BMY2UCX95QFkZI4TuozqISH/0o5ZgTfJdS11XGYnSWFRTVfylW9njjq///Ab5BWpmVD
         wicflk4ca7PSrmCR2GVEMySNyQFsaKYhzIi/LRzPWZovflc2nIJRA0XoKtBlLdMS1bPC
         NP6Vs0J+CEkpCR3+kXi3+A7gnRCsFVHTGrhSq9tmRpC/jolm5t16fQizz0uFdXxmi3yN
         bkt4bw4TYt2eJ6Q9UFyjuoYt+BihERcfGlMSxic7OJT49ndwUc9zrpG5GgnQEMfRpGYj
         qzQA==
X-Gm-Message-State: AJIora8mzBVnSbz+/ccrFk20EbKOaEoSX7tMk7Nj1AncH5WqtE/tc3+d
        F1HSlTuemoajWfupuANb5n8=
X-Google-Smtp-Source: AGRyM1st7LzqSMO7h+v0qLs4M80kCekYT1PLxfi2kDSXJV8FDa0Ruce6rk38yS+oDR0DaVPfOQ6F/A==
X-Received: by 2002:a05:622a:1052:b0:31e:fcb3:4aa2 with SMTP id f18-20020a05622a105200b0031efcb34aa2mr7134095qte.399.1658329900440;
        Wed, 20 Jul 2022 08:11:40 -0700 (PDT)
Received: from debian-BULLSEYE-live-builder-AMD64 (h96-61-90-13.cntcnh.broadband.dynamic.tds.net. [96.61.90.13])
        by smtp.gmail.com with ESMTPSA id z11-20020ac86b8b000000b0031ee738fe1dsm7664536qts.67.2022.07.20.08.11.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 08:11:40 -0700 (PDT)
Date:   Wed, 20 Jul 2022 11:11:38 -0400
From:   Eric Whitney <enwlinux@gmail.com>
To:     Eric Whitney <enwlinux@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org, tytso@mit.edu
Subject: Re: [PATCH] ext4: minor defrag code improvements
Message-ID: <YtgbKhYxbX4NPJts@debian-BULLSEYE-live-builder-AMD64>
References: <20220621143340.2268087-1-enwlinux@gmail.com>
 <20220714115326.qhjsrchoepnnsffu@quack3>
 <YtcjkMcYQCATlt0Y@debian-BULLSEYE-live-builder-AMD64>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YtcjkMcYQCATlt0Y@debian-BULLSEYE-live-builder-AMD64>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

* Eric Whitney <enwlinux@gmail.com>:
> * Jan Kara <jack@suse.cz>:
> > On Tue 21-06-22 10:33:40, Eric Whitney wrote:
> > > Modify two error paths returning EBUSY for bad argument file types to
> > > return EOPNOTSUPP instead.  Move an extent tree search whose results are
> > > only occasionally required to the site always requiring them for
> > > improved efficiency.  Address a few typos.
> > > 
> > > Signed-off-by: Eric Whitney <enwlinux@gmail.com>
> > 
> > So why is EOPNOTSUPP better than EBUSY? Honestly we are rather inconsistent
> > with errors returned for various operations on swapfile -
> > read/write/fallocate/truncate return ETXTBSY, unlink returns EPERM, some
> > ext4 ioctls return EINVAL... I guess ETXTBSY is the most common return
> > value?
> > 
> > Otherwise the patch looks good.
> > 
> > 								Honza
> 
> Hi Jan - thanks for your review.
> 
> I think EOPNOTSUPP is better than EBUSY when EXT4_IOC_MOVE_EXT is applied to
> a swap file because it's a much more direct message indicating that ext4
> doesn't support swap file defragmentation.  With the exception of the two
> sites modified by this patch, all the other sites in the defrag code where
> checks are made for unsupported file types or file system configurations,
> EOPNOTSUPP is returned.  Because EBUSY really doesn't seem to convey what's
> happening here very well - this isn't so much a case of a potentially
> temporarily busy resource as an attempt to perform an operation that will
> never succeed - another choice seemed more appropriate.  I picked EOPNOTSUPP
> simply because it's used in those other sites in the defrag code, and was
> trying to be consistent. (The defrag code reports EBUSYs when it can't
> release pages with references on them.)
> 
> EINVAL could be an alternative.  It's not quite as direct but it does
> convey the idea that an argument to the ioctl is wrong.  The defrag code
> uses it (a little inconsistently) when argument values are out of range or
> otherwise invalid.
> 
> Is ETXTBUSY still reported by the kernel?  I couldn't find it in a search after
> reading this:  lwn.net/Articles/866493/
> I didn't consider that because an executable wasn't involved - interesting that
> it was used for some operations applied to swap files.

And of course I botched my search - ETXTBSY, not ETXTBUSY. 50+ instances
remain in the kernel.

So, EOPNOTSUPP or EINVAL would be a clearer indication that the move extents
ioctl is being applied to a file type it can't defrag.  I can go with ETXTBSY
if you really prefer - any of these is better than EBUSY in this case, IMHO.

Eric

> 
> At any rate, I'm open to suggestions here - just trying to clean up a few
> things after a little code review.
> 
> Thanks,
> Eric
> 
> > 
> > > ---
> > >  fs/ext4/move_extent.c | 16 +++++++---------
> > >  1 file changed, 7 insertions(+), 9 deletions(-)
> > > 
> > > diff --git a/fs/ext4/move_extent.c b/fs/ext4/move_extent.c
> > > index 701f1d6a217f..4e4b0452106e 100644
> > > --- a/fs/ext4/move_extent.c
> > > +++ b/fs/ext4/move_extent.c
> > > @@ -472,19 +472,17 @@ mext_check_arguments(struct inode *orig_inode,
> > >  	if (IS_IMMUTABLE(donor_inode) || IS_APPEND(donor_inode))
> > >  		return -EPERM;
> > >  
> > > -	/* Ext4 move extent does not support swapfile */
> > > +	/* Ext4 move extent does not support swap files */
> > >  	if (IS_SWAPFILE(orig_inode) || IS_SWAPFILE(donor_inode)) {
> > > -		ext4_debug("ext4 move extent: The argument files should "
> > > -			"not be swapfile [ino:orig %lu, donor %lu]\n",
> > > +		ext4_debug("ext4 move extent: The argument files should not be swap files [ino:orig %lu, donor %lu]\n",
> > >  			orig_inode->i_ino, donor_inode->i_ino);
> > > -		return -EBUSY;
> > > +		return -EOPNOTSUPP;
> > >  	}
> > >  
> > >  	if (ext4_is_quota_file(orig_inode) && ext4_is_quota_file(donor_inode)) {
> > > -		ext4_debug("ext4 move extent: The argument files should "
> > > -			"not be quota files [ino:orig %lu, donor %lu]\n",
> > > +		ext4_debug("ext4 move extent: The argument files should not be quota files [ino:orig %lu, donor %lu]\n",
> > >  			orig_inode->i_ino, donor_inode->i_ino);
> > > -		return -EBUSY;
> > > +		return -EOPNOTSUPP;
> > >  	}
> > >  
> > >  	/* Ext4 move extent supports only extent based file */
> > > @@ -631,11 +629,11 @@ ext4_move_extents(struct file *o_filp, struct file *d_filp, __u64 orig_blk,
> > >  		if (ret)
> > >  			goto out;
> > >  		ex = path[path->p_depth].p_ext;
> > > -		next_blk = ext4_ext_next_allocated_block(path);
> > >  		cur_blk = le32_to_cpu(ex->ee_block);
> > >  		cur_len = ext4_ext_get_actual_len(ex);
> > >  		/* Check hole before the start pos */
> > >  		if (cur_blk + cur_len - 1 < o_start) {
> > > +			next_blk = ext4_ext_next_allocated_block(path);
> > >  			if (next_blk == EXT_MAX_BLOCKS) {
> > >  				ret = -ENODATA;
> > >  				goto out;
> > > @@ -663,7 +661,7 @@ ext4_move_extents(struct file *o_filp, struct file *d_filp, __u64 orig_blk,
> > >  		donor_page_index = d_start >> (PAGE_SHIFT -
> > >  					       donor_inode->i_blkbits);
> > >  		offset_in_page = o_start % blocks_per_page;
> > > -		if (cur_len > blocks_per_page- offset_in_page)
> > > +		if (cur_len > blocks_per_page - offset_in_page)
> > >  			cur_len = blocks_per_page - offset_in_page;
> > >  		/*
> > >  		 * Up semaphore to avoid following problems:
> > > -- 
> > > 2.30.2
> > > 
> > -- 
> > Jan Kara <jack@suse.com>
> > SUSE Labs, CR
