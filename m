Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF8E3AE902
	for <lists+linux-ext4@lfdr.de>; Tue, 10 Sep 2019 13:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729635AbfIJLVK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 10 Sep 2019 07:21:10 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39627 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731081AbfIJLUV (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 10 Sep 2019 07:20:21 -0400
Received: by mail-pf1-f195.google.com with SMTP id i1so2503321pfa.6
        for <linux-ext4@vger.kernel.org>; Tue, 10 Sep 2019 04:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbobrowski-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=N3/5vLMmzRhTd1W36lW3qUn81GaFZZqufFsh/hbWviw=;
        b=c4IjVDMLL4thjceUBw/l9sDVEDn+wiXyGZuGRRFtm2PXWYziXwSBLD7w39Y5AGMNIl
         j+BsPnZY0mkflOk4BD+6MTYZO0vSneLehaGysvVBXgsEe8CrhNfKUpOuuqknn1DRKpyn
         brEalmlrhBrOd/RniDXpZ42TRe7afJk59A6KgFrLXSA1MRHIH3AW5WVl/0AIKZalPbL/
         f3FUKa7Y0Tbd67KkyYohj2Fw8WzCKFfPSH1sR0apJAQxy2EVi3XApX1kCBI4bnRZHOjk
         9csrb8x8ISfVRvAIUNusKvvPX9WDWdavNtPUq1n7EERFj2ZUQYQSvOzjykKkGkeKgCnl
         qpYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=N3/5vLMmzRhTd1W36lW3qUn81GaFZZqufFsh/hbWviw=;
        b=LthFuV38lN2yAiO+YSUz12TO/aoj1X4UqwGw7FkKUoA6Utx6jnHb+irKc0QzBPNflL
         Wlp29AppGAbGL+i5tWexT5+tE1iXX7A/hW0ZTj28uSaMXh06FDQsX8D+LVIQAvEUkmBn
         J281rd6+cblyNIfZOjDpZfQWLHRbS8KCYeBvFYhjpXVcHWRd94WlojhMHhML+nUECRoE
         KOJfc4nEZSpk5eVZnci/UkkJ9sj7n0r4w9bjfC/Xln3+c7oj6jQBokZQshxpls1wFnLU
         apo+/miPhErjukcbGmjqbJQA2+kIrMptxU9Wx59Nk6rUYig6KxC5oygaQJq9fKr7Jo4x
         Achg==
X-Gm-Message-State: APjAAAWXQ1SOXO50vPbSioEzLVjZion2hqbjsub+MNBbsE8CDf8W6koh
        J40s713sEWD5tlMtyIjDDRd0
X-Google-Smtp-Source: APXvYqz+2UiK906iZ7AxWC3xdRNinP0SM90NeHnmz41pRV9/XrsirsNMM4cXIG0/trsOo3aq31VGxg==
X-Received: by 2002:a65:6093:: with SMTP id t19mr27228026pgu.79.1568114420750;
        Tue, 10 Sep 2019 04:20:20 -0700 (PDT)
Received: from bobrowski ([110.232.114.101])
        by smtp.gmail.com with ESMTPSA id f27sm14950640pgm.60.2019.09.10.04.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2019 04:20:20 -0700 (PDT)
Date:   Tue, 10 Sep 2019 21:20:14 +1000
From:   Matthew Bobrowski <mbobrowski@mbobrowski.org>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     tytso@mit.edu, jack@suse.cz, adilger.kernel@dilger.ca,
        hch@infradead.org, darrick.wong@oracle.com,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        david@fromorbit.com
Subject: Re: [PATCH v2 5/6] ext4: introduce direct IO write path using iomap
 infrastructure
Message-ID: <20190910112014.GB10579@bobrowski>
References: <cover.1567978633.git.mbobrowski@mbobrowski.org>
 <7c2f0ee02b2659d5a45f3e30dbee66b443b5ea0a.1567978633.git.mbobrowski@mbobrowski.org>
 <20190909092617.07ECB42041@d06av24.portsmouth.uk.ibm.com>
 <20190909143219.B549042049@d06av24.portsmouth.uk.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190909143219.B549042049@d06av24.portsmouth.uk.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Sep 09, 2019 at 08:02:13PM +0530, Ritesh Harjani wrote:
> On 9/9/19 2:56 PM, Ritesh Harjani wrote:
> > > +    ret = iomap_dio_rw(iocb, from, &ext4_iomap_ops,
> > > ext4_dio_write_end_io);
> > > +
> > > +    /*
> > > +     * Unaligned direct AIO must be the only IO in flight or else
> > > +     * any overlapping aligned IO after unaligned IO might result
> > > +     * in data corruption. We also need to wait here in the case
> > > +     * where the inode is being extended so that inode extension
> > > +     * routines in ext4_dio_write_end_io() are covered by the
> > > +     * inode_lock().
> > > +     */
> > > +    if (ret == -EIOCBQUEUED && (unaligned_aio || extend))
> > > +        inode_dio_wait(inode);
> 
> So, I looked this more closely into the AIO DIO write extend case
> of yours here. AFAICT, this looks good in the sense that it follows
> the behavior what we used to have before from __blockdev_direct_IO.
> In that it used to wait for AIO DIO writes beyond EOF, but the iomap
> framework does not have that. So waiting in case of writes beyond EOF
> should be the right thing to do here for ext4 (following the legacy code).
> 
> But I would like to confirm the exact race this extend case
> is protecting here.
> Since writes beyond EOF will require update of inode i_size
> (ext4_update_inode_size()) which require us to hold the inode_lock
> in exclusive mode, so we must need to wait in extend case here,
> even for AIO DIO writes.
> 
> Q1. Is above understanding completely correct?

Yes, that's essentially correct.

> Q2. Or is there anything else also which it is also protecting which I am
> missing?

No, I think that's it...

> Do we need to hold inode exclusive lock for ext4_orphan_del() as well?

Yes, I believe so.

> Q3. How about XFS then?
> (I do see some tricks done with IOLOCK handling in case of ki__pos > i_size
> & to zero out the buffer space between old i_size & ki_pos).
> 
> But if we talk only about the above case of extending AIO DIO writes beyond
> EOF, XFS only takes a shared lock. why?
> 
> Looking into XFS code, I see that they have IOLOCK & ILOCK.
> So I guess for protecting inode->i_size update they use ILOCK (in
> xfs_dio_write_end_io() -> xfs_iomap_write_unwritten()
> or ip->i_flags_lock lock in NON-UNWRITTEN case). And for IO part the IOLOCK
> is used and hence IOLOCK can be used in shared mode. Is this correct
> understanding for XFS?

* David/Christoph/Darrick

I haven't looked at the intricate XFS locking semantics, so I can't really
comment until I've looked at the code to be perfectly honest. Perhaps asking
one of the XFS maintainers could get you the answer you're looking for on
this.

--<M>--
