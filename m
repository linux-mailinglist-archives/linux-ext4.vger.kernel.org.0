Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87A5AA1922
	for <lists+linux-ext4@lfdr.de>; Thu, 29 Aug 2019 13:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbfH2LpY (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 29 Aug 2019 07:45:24 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37551 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726889AbfH2LpY (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 29 Aug 2019 07:45:24 -0400
Received: by mail-pf1-f195.google.com with SMTP id y9so1884998pfl.4
        for <linux-ext4@vger.kernel.org>; Thu, 29 Aug 2019 04:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbobrowski-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MqS1n+/kWBlf5HzoeS1+0Wf6ywBuVHMcP4Zd5v2vykU=;
        b=mdIDqLaBtnn4IaZZGKHrtyp7wJkdWaciLMXUalX3oHKTw8eg3NcOhn8yxFRxgVznu6
         /6WxBSATWjFePBBZ/jwCizKSOgNE4EkKaGoAQnRcRFVwdJUaNibVxg3B9/wdtM6Pp6ae
         rbmgtQrseeTlGuo3fQhKIczNVCU+ufHd6nYxkHSOLR9XNJWg3kIJIjB9CDJfpLSBftwV
         4wm2tIGASGoR8X7L1d81xixB6T8dgZ+KXBrPY7t6L2MXspMrftFVgwXSLIjdsKBG9euM
         fviBHk03XgfpQC11Z4JlNUP+cLDt52hpD+cB0F9tTjq5513FTwZsiSHsRw3wBz8i+Nac
         v8Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MqS1n+/kWBlf5HzoeS1+0Wf6ywBuVHMcP4Zd5v2vykU=;
        b=rbPAJarfsFBURGr4ffWMW0sIzS5GmnFs2bYvwOM4s0WoyU98dCPHSU9IO8Hj+IvxGM
         hQrSMrzzjnGY/7SJnha0Gt9du3wL1sUzp1r79xwTI6yAlvVdcpmo1xEVfXYb9peHlCfu
         hwsE/ThQT/UVumsNgW/f7j8qBZ2rpLNJGw90f2cEe5qrYon4efRjfFX6U/NVy/5ZgV6U
         jkjyS27FISEQiuOJdbwTxKUcxcoKVai9qKu5l2tQGipACdmfqjtyxyVJQZ1tfI05WSSQ
         lLyRwUvByrGEzM9Tv2EicL437RHQHQTdqu147l1RhF7pgG1oI5hUBrt2Es/rerUmZ2DX
         +F2g==
X-Gm-Message-State: APjAAAVtLhKZPaXmAu/BMyJCfSVEgMfAZEALAu949bqFU/mbYi9RVSGK
        YrHpkKT/kcg7M5JvZbF+NHrwM+YX49Fh
X-Google-Smtp-Source: APXvYqxyyv3vrGiGoFRwu+mIaDxxP1991nfE5Nqq9aGNNsvch//llh6EIlc/Xjuh4IHFEFVA9DnUgg==
X-Received: by 2002:a17:90a:9f09:: with SMTP id n9mr9402548pjp.72.1567079122932;
        Thu, 29 Aug 2019 04:45:22 -0700 (PDT)
Received: from poseidon.bobrowski.net ([114.78.226.167])
        by smtp.gmail.com with ESMTPSA id t11sm2200901pgb.33.2019.08.29.04.45.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 04:45:22 -0700 (PDT)
Date:   Thu, 29 Aug 2019 21:45:17 +1000
From:   Matthew Bobrowski <mbobrowski@mbobrowski.org>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tytso@mit.edu, riteshh@linux.ibm.com
Subject: Re: [PATCH 4/5] ext4: introduce direct IO write code path using
 iomap infrastructure
Message-ID: <20190829114515.GB2486@poseidon.bobrowski.net>
References: <cover.1565609891.git.mbobrowski@mbobrowski.org>
 <581c3a2da89991e7ce5862d93dcfb23e1dc8ddc8.1565609891.git.mbobrowski@mbobrowski.org>
 <20190828202619.GG22343@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190828202619.GG22343@quack2.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Aug 28, 2019 at 10:26:19PM +0200, Jan Kara wrote:
> On Mon 12-08-19 22:53:26, Matthew Bobrowski wrote:
> Overall this is very nice. Some smaller comments below.

Awesome, thanks for the review Jan!

> > @@ -235,6 +244,34 @@ static ssize_t ext4_write_checks(struct kiocb *iocb, struct iov_iter *from)
> >  	return iov_iter_count(from);
> >  }
> >  
> > +static ssize_t ext4_buffered_write_iter(struct kiocb *iocb,
> > +					struct iov_iter *from)
> > +{
> > +	ssize_t ret;
> > +	struct inode *inode = file_inode(iocb->ki_filp);
> > +
> > +	if (!inode_trylock(inode)) {
> > +		if (iocb->ki_flags & IOCB_NOWAIT)
> > +			return -EOPNOTSUPP;
> > +		inode_lock(inode);
> > +	}
> 
> Currently there's no support for IOCB_NOWAIT for buffered IO so you can
> replace this with "inode_lock(inode)".

Noted. I've also taken into consideration what Dave mentioned in the
other thread around explicitly checking for IOCB_NOWAIT and returning
EOPTNOTSUPP irrespective whether we can acquire the lock or not.

> > @@ -284,6 +321,128 @@ static int ext4_handle_inode_extension(struct inode *inode, loff_t size,
> >  	return ret;
> >  }
> >  
> 
> I'd mention here that for cases where inode size is extended,
> ext4_dio_write_iter() waits for DIO to complete and thus we are protected
> by inode_lock in that case.

Easy.

> > +static int ext4_dio_write_end_io(struct kiocb *iocb, ssize_t size,
> > +				 ssize_t error, unsigned int flags)
> 
> Here I'd expand the comment to explain that we wait in case inode is
> extended so that inode extension in ext4_dio_write_end_io() is properly
> covered by inode_lock.
>

Easy.

> > +	if (ret == -EIOCBQUEUED && (unaligned_aio || extend))
> > +		inode_dio_wait(inode);
> > +
> > +	if (ret >= 0 && iov_iter_count(from)) {
> > +		overwrite ? inode_unlock_shared(inode) : inode_unlock(inode);
> > +		return ext4_buffered_write_iter(iocb, from);
> > +	}
> > +out:
> > +	overwrite ? inode_unlock_shared(inode) : inode_unlock(inode);
> > +	return ret;
> > +}
> > +
> >  #ifdef CONFIG_FS_DAX
> >  static ssize_t
> >  ext4_dax_write_iter(struct kiocb *iocb, struct iov_iter *from)
> 
> ...
> 
> > @@ -3581,10 +3611,10 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
> >  		iomap->type = delalloc ? IOMAP_DELALLOC : IOMAP_HOLE;
> >  		iomap->addr = IOMAP_NULL_ADDR;
> >  	} else {
> > -		if (map.m_flags & EXT4_MAP_MAPPED) {
> > -			iomap->type = IOMAP_MAPPED;
> > -		} else if (map.m_flags & EXT4_MAP_UNWRITTEN) {
> > +		if (map.m_flags & EXT4_MAP_UNWRITTEN) {
> >  			iomap->type = IOMAP_UNWRITTEN;
> > +		} else if (map.m_flags & EXT4_MAP_MAPPED) {
> > +			iomap->type = IOMAP_MAPPED;
> >  		} else {
> >  			WARN_ON_ONCE(1);
> >  			return -EIO;
> 
> Possibly this hunk should go into a separate patch (since this is not
> directly related with iomap conversion) with a changelog / comment
> explaining why we need to check EXT4_MAP_UNWRITTEN first.

But wouldn't doing so break bisection? Seeing as though we needed to
change this statement specifically to accommodate for the weirdness
being returned from ext4_map_blocks()? i.e. map.m_flags being set to
either of the following:

	- (EXT4_MAP_NEW | EXT4_MAP_MAPPED)
        or
        - (EXT4_MAP_NEW | EXT4_MAP_MAPPED | EXT4_MAP_UNWRITTEN)

So, if we left the statement in its original form, we'd allocate
unwritten extents but never actually get around to converting them in
ext4_dio_write_end_io() as IOMAP_DIO_UNWRITTEN would never be set?

--M
