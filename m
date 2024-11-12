Return-Path: <linux-ext4+bounces-5063-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A459C4B54
	for <lists+linux-ext4@lfdr.de>; Tue, 12 Nov 2024 01:57:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3BA11F2407C
	for <lists+linux-ext4@lfdr.de>; Tue, 12 Nov 2024 00:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57E8220264A;
	Tue, 12 Nov 2024 00:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="Yw/B7jYd"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE9220262B
	for <linux-ext4@vger.kernel.org>; Tue, 12 Nov 2024 00:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731373030; cv=none; b=SibHUIT3ewMzGrGo/NoV2BxdvB/U7SkaEm5deqyb64eDB9sYAukADRQMznESOKzt0ZbRX6D8COiD2C/Unq7Tu9phOvNAW+6WeOVh9ApXKHdjdUcVr1nUrXDzccG8ZvZyxsXoFUkmkfGzIutJ7PVzWlAcg4bK+JfazsUq4LTnKwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731373030; c=relaxed/simple;
	bh=YYOImkpUT1Yja9zYCaAJgCtxSCnlayekNMYaprAva7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KFml+SkYIcT156Zxdhljc7PI9RTUllBHgRozzyuzgHJbAPksbcNEMZQ1hwFBYtcRXBley2vHvsqJiwmBymcWdyBO6Ywru98jz99Ld/8XqFYKaF6mfd2n0rgxLmcw2068JX+z3L9ENtlMD6Ejwrtchsp7owLS+vBxmDgetDI6Rlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=Yw/B7jYd; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-20e6981ca77so57993675ad.2
        for <linux-ext4@vger.kernel.org>; Mon, 11 Nov 2024 16:57:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1731373027; x=1731977827; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZUwyokbteUzniHEENjrKpRRTwbWjJZjJmULNQblWcik=;
        b=Yw/B7jYd1iTBsqSPt91moD+FDQFLCIDrhCx1LUB35sV9BfXvpGTYPQgsuKBbOp9S0R
         9r2rAWUIq7wkLrCjwSvR461fDS0japg8ra4cRbIcyXD7VGkBgsjToV05zivO9AjaS6Sl
         tPMaNxCCCfXI0ZWXPLWuPtZP1rU8xJFVwpcDbuR6Cny9jhvz9+ObLz6HeKmxj2SX/m3J
         KvUNY3Ih8DthB8OrWFcLKKnBRsrLH+UPjUD2WEVZTE11cHLc0jeTJLAreoRqDG2tLRsH
         dcm3/0FbGi0p10BYQgtlkrIvoucpT1NWS72Y0WJEvrBcQyTXG3h1XtCa1FbZ52IO0HJ0
         XsGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731373027; x=1731977827;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZUwyokbteUzniHEENjrKpRRTwbWjJZjJmULNQblWcik=;
        b=TVBEpUgwF1Q69NU8ugi133ikANJi1lfDcYogXU0WIJz4wCmvRAUcDRSICTGck9m8F/
         4P4jb9AAIED9BoGvciYVg7uvQ13G2V2vPE6ASTIHu6V2WdL++opGPLbkk99mkmpHk+0q
         bN4LyQ1GkIUiESUA1KZ0TbhXByAxQnSmEM4P42zPUsOmRFVQ3MF0EB8ec5MtP4WMGMOf
         Gk86Rv5LzpKFSuFjplj3KqC+BWmdYylYGQ6uOc0V+OIRVCrVu4LyBtSimudc+PyD924X
         wcSu8nPb3qfOSvDafltNhSUHvHTRuyd/6pWnbjsGgAuKIn22QGCBkIf87/KCa066D1wT
         V3vw==
X-Forwarded-Encrypted: i=1; AJvYcCVTuWreyZorr+MZe9PUYn0c3oyILd3b2opDY1Nf1tmcRcc3SPeqoEi9ar5tXaeiy7kPhE4ERmvDyChI@vger.kernel.org
X-Gm-Message-State: AOJu0YzJVPhPFnx2K6Esajm+h+4duXwq2oNVSfNQMsXWHgwR6zbPShDI
	+caK6xQe6t3D/trV6BCN478cLiaZnHwPlaz4NLxNFylw7NBFhdzNLIJEMtkbj/o=
X-Google-Smtp-Source: AGHT+IG6t7qQXVQ3LjFCpVZCH1u4sMB615TBElvGr3S07x/zbJIq4pbcacpDwlnZyNM4UL5MtKIurg==
X-Received: by 2002:a17:902:d50c:b0:20b:449c:8978 with SMTP id d9443c01a7336-21183559ba4mr207039635ad.31.1731373027524;
        Mon, 11 Nov 2024 16:57:07 -0800 (PST)
Received: from dread.disaster.area (pa49-186-86-168.pa.vic.optusnet.com.au. [49.186.86.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177e6a3f4sm81430715ad.234.2024.11.11.16.57.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 16:57:07 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1tAfDM-00DQ0B-1Q;
	Tue, 12 Nov 2024 11:57:04 +1100
Date: Tue, 12 Nov 2024 11:57:04 +1100
From: Dave Chinner <david@fromorbit.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, hannes@cmpxchg.org,
	clm@meta.com, linux-kernel@vger.kernel.org, willy@infradead.org,
	kirill@shutemov.name, linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 10/16] mm/filemap: make buffered writes work with
 RWF_UNCACHED
Message-ID: <ZzKn4OyHXq5r6eiI@dread.disaster.area>
References: <20241111234842.2024180-1-axboe@kernel.dk>
 <20241111234842.2024180-11-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241111234842.2024180-11-axboe@kernel.dk>

On Mon, Nov 11, 2024 at 04:37:37PM -0700, Jens Axboe wrote:
> If RWF_UNCACHED is set for a write, mark new folios being written with
> uncached. This is done by passing in the fact that it's an uncached write
> through the folio pointer. We can only get there when IOCB_UNCACHED was
> allowed, which can only happen if the file system opts in. Opting in means
> they need to check for the LSB in the folio pointer to know if it's an
> uncached write or not. If it is, then FGP_UNCACHED should be used if
> creating new folios is necessary.
> 
> Uncached writes will drop any folios they create upon writeback
> completion, but leave folios that may exist in that range alone. Since
> ->write_begin() doesn't currently take any flags, and to avoid needing
> to change the callback kernel wide, use the foliop being passed in to
> ->write_begin() to signal if this is an uncached write or not. File
> systems can then use that to mark newly created folios as uncached.
> 
> Add a helper, generic_uncached_write(), that generic_file_write_iter()
> calls upon successful completion of an uncached write.

This doesn't implement an "uncached" write operation. This
implements a cache write-through operation.

We've actually been talking about this for some time as a desirable
general buffered write trait on fast SSDs. Excessive write-behind
caching is a real problem in general, especially when doing
streaming sequential writes to pcie 4 and 5 nvme SSDs that can do
more than 7GB/s to disk. When the page cache fills up, we see all
the same problems you are trying to work around in this series
with "uncached" writes.

IOWS, what we really want is page cache write-through as an
automatic feature for buffered writes.


> @@ -70,6 +71,34 @@ static inline int filemap_write_and_wait(struct address_space *mapping)
>  	return filemap_write_and_wait_range(mapping, 0, LLONG_MAX);
>  }
>  
> +/*
> + * generic_uncached_write - start uncached writeback
> + * @iocb: the iocb that was written
> + * @written: the amount of bytes written
> + *
> + * When writeback has been handled by write_iter, this helper should be called
> + * if the file system supports uncached writes. If %IOCB_UNCACHED is set, it
> + * will kick off writeback for the specified range.
> + */
> +static inline void generic_uncached_write(struct kiocb *iocb, ssize_t written)
> +{
> +	if (iocb->ki_flags & IOCB_UNCACHED) {
> +		struct address_space *mapping = iocb->ki_filp->f_mapping;
> +
> +		/* kick off uncached writeback */
> +		__filemap_fdatawrite_range(mapping, iocb->ki_pos,
> +					   iocb->ki_pos + written, WB_SYNC_NONE);
> +	}
> +}

Yup, this is basically write-through.

> +
> +/*
> + * Value passed in to ->write_begin() if IOCB_UNCACHED is set for the write,
> + * and the ->write_begin() handler on a file system supporting FOP_UNCACHED
> + * must check for this and pass FGP_UNCACHED for folio creation.
> + */
> +#define foliop_uncached			((struct folio *) 0xfee1c001)
> +#define foliop_is_uncached(foliop)	(*(foliop) == foliop_uncached)
> +
>  /**
>   * filemap_set_wb_err - set a writeback error on an address_space
>   * @mapping: mapping in which to set writeback error
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 40debe742abe..0d312de4e20c 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -430,6 +430,7 @@ int __filemap_fdatawrite_range(struct address_space *mapping, loff_t start,
>  
>  	return filemap_fdatawrite_wbc(mapping, &wbc);
>  }
> +EXPORT_SYMBOL_GPL(__filemap_fdatawrite_range);
>  
>  static inline int __filemap_fdatawrite(struct address_space *mapping,
>  	int sync_mode)
> @@ -4076,7 +4077,7 @@ ssize_t generic_perform_write(struct kiocb *iocb, struct iov_iter *i)
>  	ssize_t written = 0;
>  
>  	do {
> -		struct folio *folio;
> +		struct folio *folio = NULL;
>  		size_t offset;		/* Offset into folio */
>  		size_t bytes;		/* Bytes to write to folio */
>  		size_t copied;		/* Bytes copied from user */
> @@ -4104,6 +4105,16 @@ ssize_t generic_perform_write(struct kiocb *iocb, struct iov_iter *i)
>  			break;
>  		}
>  
> +		/*
> +		 * If IOCB_UNCACHED is set here, we now the file system
> +		 * supports it. And hence it'll know to check folip for being
> +		 * set to this magic value. If so, it's an uncached write.
> +		 * Whenever ->write_begin() changes prototypes again, this
> +		 * can go away and just pass iocb or iocb flags.
> +		 */
> +		if (iocb->ki_flags & IOCB_UNCACHED)
> +			folio = foliop_uncached;
> +
>  		status = a_ops->write_begin(file, mapping, pos, bytes,
>  						&folio, &fsdata);
>  		if (unlikely(status < 0))
> @@ -4234,8 +4245,10 @@ ssize_t generic_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  		ret = __generic_file_write_iter(iocb, from);
>  	inode_unlock(inode);
>  
> -	if (ret > 0)
> +	if (ret > 0) {
> +		generic_uncached_write(iocb, ret);
>  		ret = generic_write_sync(iocb, ret);

Why isn't the writethrough check inside generic_write_sync()?
Having to add it to every filesystem that supports write-through is
unwieldy. If the IO is DSYNC or SYNC, we're going to run WB_SYNC_ALL
writeback through the generic_write_sync() path already, so the only time we
actually want to run WB_SYNC_NONE write-through here is if the iocb
is not marked as dsync.

Hence I think this write-through check should be done conditionally
inside generic_write_sync(), not in addition to the writeback
generic_write_sync() might need to do...

That also gives us a common place for adding cache write-through
trigger logic (think writebehind trigger logic similar to readahead)
and this is also a place where we could automatically tag mapping
ranges for reclaim on writeback completion....

-Dave.
-- 
Dave Chinner
david@fromorbit.com

