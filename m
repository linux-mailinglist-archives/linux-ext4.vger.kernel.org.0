Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73BDBB4412
	for <lists+linux-ext4@lfdr.de>; Tue, 17 Sep 2019 00:37:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387555AbfIPWhu (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 16 Sep 2019 18:37:50 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33880 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728123AbfIPWhu (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 16 Sep 2019 18:37:50 -0400
Received: by mail-pf1-f196.google.com with SMTP id b128so819983pfa.1
        for <linux-ext4@vger.kernel.org>; Mon, 16 Sep 2019 15:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbobrowski-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=59X5RvHm807OLFbm3taZna4w+6L5coMBB4Ni//2NeKI=;
        b=C80DicDCYT7rIcDYOHOGrrJk3NvfyZfExEswz6GbI2lAEjINTbwPDtebRCvZFSnMW9
         9w8vIF/xVyR16X1mX7uz9+pP+nI4VHxGrgxY8M0dUcCO9yp3Tnkg9Gb2sx8r6Z3Z1KVh
         gKQTpNpmFERkJwtqz7IHImJWQVEtvVdagn6Mf3XYzhWWE4k67g8p49N8/CvI6oAuSfM4
         oUHTY/I5JWpm0HJTmnOui5/ef/qLmKYL8MWVF62Gbbs0yiyy8tasexPK0JI/Un8KvJj8
         FelXqV94iaGUw/sZHScuzvDcv4qWPGJkvVmW3PJYVxChiskv+pzi9i5kWlKIyFK7cjwE
         U/Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=59X5RvHm807OLFbm3taZna4w+6L5coMBB4Ni//2NeKI=;
        b=jZ1+ePqrMnbtFdcC7imrWP26leXpN69ymUoMFuc85ejWopSkUyviNZXyy4bwZkpBkv
         xDsNisfsrmldldluH8FZJHdjo2gsarkO/JHzYG8u4AAUrK3yDeaoW+7Q776WoT/B6n8Q
         ng+4etczpXw83jc8/AQAxf3LGcI6w2SETJ6kWn/kZOc3/UdNOOqsLd7aWppo5aDDxyNb
         NepU2gpCocIbrHzPP4s+Cid5A1bmtBu2qzhn4lRbuPrD7q0rUZFt7aDWRBaY2yZ2uoBA
         MtJetXwm7ThU0qYhGACa1RR+uK+O3/xb3xMCODzV2zq5xVA78sJeqln31Phy5fHfur+r
         DhXw==
X-Gm-Message-State: APjAAAW2iWlElThjRTNBYHwSWdXfyuSWLgSMcRMik32ye8QgAB/G5QBq
        K0BMvL4QkUPVl5HCFtHtUP1N
X-Google-Smtp-Source: APXvYqw201emQOCzAUYbBBuxD2MbgCxcjbSVpKAy7S6p1X+7ll9pov8i2Lw4qCsPmWAubk01ux60tw==
X-Received: by 2002:a63:1c09:: with SMTP id c9mr25644pgc.347.1568673469085;
        Mon, 16 Sep 2019 15:37:49 -0700 (PDT)
Received: from bobrowski ([110.232.114.101])
        by smtp.gmail.com with ESMTPSA id b10sm125472pfo.123.2019.09.16.15.37.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 15:37:48 -0700 (PDT)
Date:   Tue, 17 Sep 2019 08:37:41 +1000
From:   Matthew Bobrowski <mbobrowski@mbobrowski.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     tytso@mit.edu, jack@suse.cz, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        david@fromorbit.com, darrick.wong@oracle.com
Subject: Re: [PATCH v3 5/6] ext4: introduce direct IO write path using iomap
 infrastructure
Message-ID: <20190916223741.GA5936@bobrowski>
References: <cover.1568282664.git.mbobrowski@mbobrowski.org>
 <db33705f9ba35ccbe20fc19b8ecbbf2078beff08.1568282664.git.mbobrowski@mbobrowski.org>
 <20190916121248.GD4005@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190916121248.GD4005@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Sep 16, 2019 at 05:12:48AM -0700, Christoph Hellwig wrote:
> On Thu, Sep 12, 2019 at 09:04:46PM +1000, Matthew Bobrowski wrote:
> > @@ -213,12 +214,16 @@ static ssize_t ext4_write_checks(struct kiocb *iocb, struct iov_iter *from)
> >  	struct inode *inode = file_inode(iocb->ki_filp);
> >  	ssize_t ret;
> >  
> > +	if (unlikely(IS_IMMUTABLE(inode)))
> > +		return -EPERM;
> > +
> >  	ret = generic_write_checks(iocb, from);
> >  	if (ret <= 0)
> >  		return ret;
> >  
> > -	if (unlikely(IS_IMMUTABLE(inode)))
> > -		return -EPERM;
> > +	ret = file_modified(iocb->ki_filp);
> > +	if (ret)
> > +		return 0;
> >  
> >  	/*
> >  	 * If we have encountered a bitmap-format file, the size limit
> 
> Independent of the error return issue you probably want to split
> modifying ext4_write_checks into a separate preparation patch.

Providing that there's no objections to introducing a possible performance
change with this separate preparation patch (overhead of calling
file_remove_privs/file_update_time twice), then I have no issues in doing so.

> > +/*
> > + * For a write that extends the inode size, ext4_dio_write_iter() will
> > + * wait for the write to complete. Consequently, operations performed
> > + * within this function are still covered by the inode_lock(). On
> > + * success, this function returns 0.
> > + */
> > +static int ext4_dio_write_end_io(struct kiocb *iocb, ssize_t size, int error,
> > +				 unsigned int flags)
> > +{
> > +	int ret;
> > +	loff_t offset = iocb->ki_pos;
> > +	struct inode *inode = file_inode(iocb->ki_filp);
> > +
> > +	if (error) {
> > +		ret = ext4_handle_failed_inode_extension(inode, offset + size);
> > +		return ret ? ret : error;
> > +	}
> 
> Just a personal opinion, but I find the use of the ternary operator
> here a little weird.
> 
> A plain old:
> 
> 	ret = ext4_handle_failed_inode_extension(inode, offset + size);
> 	if (ret)
> 		return ret;
> 	return error;
> 
> flow much easier.

Agree, much cleaner.
 
> > +	if (!inode_trylock(inode)) {
> > +		if (iocb->ki_flags & IOCB_NOWAIT)
> > +			return -EAGAIN;
> > +		inode_lock(inode);
> > +	}
> > +
> > +	if (!ext4_dio_checks(inode)) {
> > +		inode_unlock(inode);
> > +		/*
> > +		 * Fallback to buffered IO if the operation on the
> > +		 * inode is not supported by direct IO.
> > +		 */
> > +		return ext4_buffered_write_iter(iocb, from);
> 
> I think you want to lift the locking into the caller of this function
> so that you don't have to unlock and relock for the buffered write
> fallback.

I don't exactly know what you really mean by "lift the locking into the caller
of this function". I'm interpreting that as moving the inode_unlock()
operation into ext4_buffered_write_iter(), but I can't see how that would be
any different from doing it directly here? Wouldn't this also run the risk of
the locks becoming unbalanced as we'd need to add checks around whether the
resource is being contended? Maybe I'm misunderstanding something here...

> > +	if (offset + count > i_size_read(inode) ||
> > +	    offset + count > EXT4_I(inode)->i_disksize) {
> > +		ext4_update_i_disksize(inode, inode->i_size);
> > +		extend = true;
> 
> Doesn't the ext4_update_i_disksize need to be under an open journal
> handle?

After all, it is a metadata update, which should go through an open journal
handle.

Thank you for the review Christoph!

--<M>--
