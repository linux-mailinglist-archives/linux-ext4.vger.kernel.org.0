Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA4021B000C
	for <lists+linux-ext4@lfdr.de>; Mon, 20 Apr 2020 04:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726012AbgDTC5c (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 19 Apr 2020 22:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725896AbgDTC5b (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Sun, 19 Apr 2020 22:57:31 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D912C061A0C
        for <linux-ext4@vger.kernel.org>; Sun, 19 Apr 2020 19:57:30 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id y22so3415957pll.4
        for <linux-ext4@vger.kernel.org>; Sun, 19 Apr 2020 19:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0mvvknjH/om5mg9aEPawMVGoGXMv6ineQ5fF9+WlTmE=;
        b=tgl71i+gYWBvkV4lCU0LKfV/xer3AKV4HhKU5jvdevtHuUK4YqQeJnabGSQu7pYlA+
         TLo9EIl5dC5WCEpNjMs+bBFmnRQlAyvTpqkhR59et+TjvlMu7tuA9die9Hwf6J7abHOk
         Z+ZwUydYbULy4G3K1isIUsX5zKARFXaTzAEJi1fDE+lRwo5+u42Suv9KlZicpMqNJdd5
         00e1AxehWpFsrJs8aSq9PZmyfzPwe5FtsyZSLcX2kZFub4MYq57fwehg39SyTuNYVnIc
         kjWIPlwbqP03yKUI+DHPQyGmVjG+tRqGq1LL9Iy/JscH0sfIj7oc7CH0izT2UzahnWYx
         01hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0mvvknjH/om5mg9aEPawMVGoGXMv6ineQ5fF9+WlTmE=;
        b=sFwWViUCH/l05gDZP17jrBfti0BffqNOxIwLt6I7QegDytnpiuZS/iEGozdxMb0i/q
         RC9kqzWQwwbR9qmEx0V0Z53S4Z0Lzuh736nTLaxzhcSrORtVcnHlvGsdang5Ll9EhjEs
         otWzVMV/Z9dGylU2oxHPXCmlOLcAcyOSE44c3KO0mGihO8CWuCvmUbOyr7i6dKJdly0/
         QDuHtLD22JQccoanRer1+33CSraGb8+bC6rn0pyuRM8Mt/3Ky1ocwkgh2czCR0vkfr8v
         y6z3WGAoOI8bIQbpQ1/8w4HoueIaMrCgGqtpyUOEqyOgOvA8i8PMMz/BorWG1rIZG6/1
         GpJg==
X-Gm-Message-State: AGi0PuaaLt80o9H7X9QnWia7Fou2JHIYLAXyOTXfh3elJUEgqZLk8sJ6
        aXUSg/MSxLrcchykROZzvVA=
X-Google-Smtp-Source: APiQypKhPsGE8bE7tx+93WHnsm8q34g8mx/zGqznWkztahjdmOCtIKN5niAsfamfU8/ERUPzyIEJlA==
X-Received: by 2002:a17:902:7d92:: with SMTP id a18mr15053018plm.62.1587351449874;
        Sun, 19 Apr 2020 19:57:29 -0700 (PDT)
Received: from localhost ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id w16sm1540437pgf.94.2020.04.19.19.57.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2020 19:57:29 -0700 (PDT)
Date:   Mon, 20 Apr 2020 10:57:21 +0800
From:   Murphy Zhou <jencce.kernel@gmail.com>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Murphy Zhou <jencce.kernel@gmail.com>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Jan Kara <jack@suse.cz>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH] ext4: validate fiemap iomap begin offset and length value
Message-ID: <20200420025721.ac5ighvy77fffnxf@xzhoux.usersys.redhat.com>
References: <20200418233231.z767yvfiupy7hwgp@xzhoux.usersys.redhat.com>
 <20200419015654.F2061A4051@d06av23.portsmouth.uk.ibm.com>
 <20200419044224.GA311394@mit.edu>
 <20200419044612.GB311394@mit.edu>
 <20200419161928.6D6CC5204E@d06av21.portsmouth.uk.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200419161928.6D6CC5204E@d06av21.portsmouth.uk.ibm.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sun, Apr 19, 2020 at 09:49:27PM +0530, Ritesh Harjani wrote:
> Hello Ted,
> 
> On 4/19/20 10:16 AM, Theodore Y. Ts'o wrote:
> 
> > ext4_map_block() is returning EFSCORRUPTED when lblk is
> > EXT4_MAX_LOGICAL_BLOCK, which is why he's constraining lblk to
> > EXT4_MAX_LOGICAL_BLOCK.  I haven't looked into this more closely yet,
> 
> Yes, I did mention about this case in point 2 in below link though.
> But maybe I was only focused on testing syzcaller reproducer, so
> couldn't test this reported case.
> 
> https://www.spinics.net/lists/linux-ext4/msg71387.html
> 
> 
> > On Sun, Apr 19, 2020 at 12:42:24AM -0400, Theodore Y. Ts'o wrote:
> > > I think we need to take his patch, and make a simialr change to
> > > ext4_iomap_begin().   Ritesh, do you agree?
> > 
> > For example...
> > 
> > diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> > index 2a4aae6acdcb..adce3339d697 100644
> > --- a/fs/ext4/inode.c
> > +++ b/fs/ext4/inode.c
> > @@ -3424,8 +3424,10 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
> >   	int ret;
> >   	struct ext4_map_blocks map;
> >   	u8 blkbits = inode->i_blkbits;
> > +	ext4_lblk_t lblk = offset >> blkbits;
> > +	ext4_lblk_t last_lblk = (offset + length - 1) >> blkbits;
> 
> Why play with last_lblk but?
> 
> 
> 
> > -	if ((offset >> blkbits) > EXT4_MAX_LOGICAL_BLOCK)
> > +	if (lblk > EXT4_MAX_LOGICAL_BLOCK)
> >   		return -EINVAL;
> >   	if (WARN_ON_ONCE(ext4_has_inline_data(inode)))
> > @@ -3434,9 +3436,15 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
> >   	/*
> >   	 * Calculate the first and last logical blocks respectively.
> >   	 */
> > -	map.m_lblk = offset >> blkbits;
> > -	map.m_len = min_t(loff_t, (offset + length - 1) >> blkbits,
> > -			  EXT4_MAX_LOGICAL_BLOCK) - map.m_lblk + 1;
> > +	if (last_lblk >= EXT4_MAX_LOGICAL_BLOCK)
> > +		last_lblk = EXT4_MAX_LOGICAL_BLOCK - 1;
> > +	if (lblk >= EXT4_MAX_LOGICAL_BLOCK)
> > +		lblk = EXT4_MAX_LOGICAL_BLOCK - 1;
> > +
> > +	map.m_lblk = lblk;
> > +	map.m_len = last_lblk - lblk + 1;
> > +	if (map.m_len == 0 )
> > +		map.m_len = 1;
> 
> Not sure but with above changes map.m_len will never be
> 0. Right?

Yes. If it's 0, in ext4_iomap_is_delalloc we will get an "end" that
is less then m_lblk, causing another WARN in ext4_es_find_extent_range.

> 
> Ok, so the problem mainly is coming since ext4_map_blocks()
> is returning -EFSCORRUPTED in case if lblk >= EXT4_MAX_LOGICAL_BLOCK.
> 
> So why change last_lblk?

I guess because we need to make sure a sane length value. In the loop
in iomap_fiemap, start and length are not checked, assuming be checked
by caller. If length get overflowed, the start value for the next loop
can also be affected, which makes lblk last_lblk and m_len to go crazy.

Thanks.

> Shouldn't we just change the logic to return -ENOENT in case
> if (lblk >= EXT4_MAX_LOGICAL_BLOCK)? ENOENT can be handled by
> IOMAP APIs to abort the loop properly.
> This along with the map.m_len overlflow patch which I had submitted
> before. (since the overflow patch is anyway a valid fix which we anyways
> need).
> 
> -ritesh
> 
> 
> >   	if (flags & IOMAP_WRITE)
> >   		ret = ext4_iomap_alloc(inode, &map, flags);
> > @@ -3524,8 +3532,10 @@ static int ext4_iomap_begin_report(struct inode *inode, loff_t offset,
> >   	bool delalloc = false;
> >   	struct ext4_map_blocks map;
> >   	u8 blkbits = inode->i_blkbits;
> > +	ext4_lblk_t lblk = offset >> blkbits;
> > +	ext4_lblk_t last_lblk = (offset + length - 1) >> blkbits;
> > -	if ((offset >> blkbits) > EXT4_MAX_LOGICAL_BLOCK)
> > +	if (lblk > EXT4_MAX_LOGICAL_BLOCK)
> >   		return -EINVAL;
> >   	if (ext4_has_inline_data(inode)) {
> > @@ -3540,9 +3550,15 @@ static int ext4_iomap_begin_report(struct inode *inode, loff_t offset,
> >   	/*
> >   	 * Calculate the first and last logical block respectively.
> >   	 */
> > -	map.m_lblk = offset >> blkbits;
> > -	map.m_len = min_t(loff_t, (offset + length - 1) >> blkbits,
> > -			  EXT4_MAX_LOGICAL_BLOCK) - map.m_lblk + 1;
> > +	if (last_lblk >= EXT4_MAX_LOGICAL_BLOCK)
> > +		last_lblk = EXT4_MAX_LOGICAL_BLOCK - 1;
> > +	if (lblk >= EXT4_MAX_LOGICAL_BLOCK)
> > +		lblk = EXT4_MAX_LOGICAL_BLOCK - 1;
> > +
> > +	map.m_lblk = lblk;
> > +	map.m_len = last_lblk - lblk + 1;
> > +	if (map.m_len == 0 )
> > +		map.m_len = 1;
> >   	/*
> >   	 * Fiemap callers may call for offset beyond s_bitmap_maxbytes.
> > 
> 

-- 
Murphy
