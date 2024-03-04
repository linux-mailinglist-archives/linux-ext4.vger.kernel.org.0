Return-Path: <linux-ext4+bounces-1487-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C5B86F822
	for <lists+linux-ext4@lfdr.de>; Mon,  4 Mar 2024 02:17:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EDEB1F2116B
	for <lists+linux-ext4@lfdr.de>; Mon,  4 Mar 2024 01:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E5C410F2;
	Mon,  4 Mar 2024 01:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="Lq4kxYHr"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25FAF17CE
	for <linux-ext4@vger.kernel.org>; Mon,  4 Mar 2024 01:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709515022; cv=none; b=EQLaMbGR2zaLeal2ppJm2ffpN5l+vMyYZOJzloD8Yv16oU/KGnv5TSRwHjjjhrYvMnCFMU4CRBOYfEqZWAt9Kr3bsbP7T5LfhpO/Xm8DEOPrnjC81zq0E+/E9rAUQD9NFOKP9u34G24VWU8ax1q1v49x83eIRmKcytzmBBzUdo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709515022; c=relaxed/simple;
	bh=b7SSYspclds0BRCRMLVbMDZF22HsnPgTIN5c8uq/atE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DHSOqGJ40uEp1sx8kBo+TTYGC0c+5ownJB9Nbr6B3m6vx0sNVjf8nM+vayCM70pyln/7xmEkqBg1vz+24AuxrX237RLruNOBv+RMHPETQaij/znrz6szym9bKxOeD2oBmW44b+XEIeYWfdCZIlC9Ms2ywJvhYW3ZVy7FjZBuFGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=Lq4kxYHr; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1dc75972f25so32120615ad.1
        for <linux-ext4@vger.kernel.org>; Sun, 03 Mar 2024 17:17:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1709515020; x=1710119820; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Et25xNcaZ8dKVZKTWn3ytnYkOD3/9xAeQVIkCIdPgRA=;
        b=Lq4kxYHrOyTGL47PBBXiJG8XXdzo0/uX8eXP0kHhIJfwf2AlR8Zcyf8rNo8CgVnNqb
         S8IIClAUqJv2o8QopaZ2tUnw6Z368GMsO00A9t0xzMBboFLmV3UcpSNuYFKx+Wt9L7Lc
         wtGmmuSUecSQZV7OtQ9EWwgj4RF++jztkPFAkPpELXI/0zVuh0obYHIrbf1e5gLkwK0s
         Dh/lB681niDMxwwDI7wXVnhIr/RL+qBs8iEv/zrlgq3MuifpFT4xQZAYGBPUbqk+w5a/
         Cwsla5vIOREsYwfyggz7WN3SXUCL7gFu0MQpyLryFsMY1E8brRUzuO/rWqgtGF8SpXf3
         CVEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709515020; x=1710119820;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Et25xNcaZ8dKVZKTWn3ytnYkOD3/9xAeQVIkCIdPgRA=;
        b=WKzaqvHDkDyCSQDwE6QH/uv7lkViVxJZz7iQoadyvy7zN5zmmMFs3zfLseWBtYvoNw
         zfCMhaL+CaHL9ycOEFvEmPWb4baKIS9fQv1653z7akVYJisqGTpk03wmnyQBiWc/VReW
         DxYxA4jUZDEQ/rTE+WjJKBWdjqPQcOLVqrj3ex6fNBtM02a0vypzhWvD4NN0Bze/jOo6
         BR/FyguLNbTMN6Vwccox2xw3BzDss/i/dTxBr//vduomCRNYs10w0pWv2QOBt5PKzPgL
         mQhNjQHVvZf1D0a7uxUY/UlnV4bviAFjJXP0jhag0mz8brVhcfFuiiC/behb7lPuEhKL
         J/BA==
X-Forwarded-Encrypted: i=1; AJvYcCXKMh/eF34vvp0Y8GtHQEIn0YkO53C4jFDftVL4Sy1aN5saVee9mARwtRGch025BmTNBNLNnf7WIqKcW71Eah517tlMGhPpgVT4uA==
X-Gm-Message-State: AOJu0Yxttc9t6+N+0zrkV8zYGxZBahOKnYRfE1ATlfe2oi9xjXgYVNzX
	8pvpJJhKitd+tMyHwrrxkzlRgT41eFhF4YzM1uWu849Wva8gQzEgTT6PGt72w8A=
X-Google-Smtp-Source: AGHT+IHkP92HVlEQaJyjtxeGimyAxRhgYGP3Nf+sZvScwD+toU1xyj8AIK7lAKdqqqFDTXgrXsgkbA==
X-Received: by 2002:a17:903:298e:b0:1dc:7fb4:20cb with SMTP id lm14-20020a170903298e00b001dc7fb420cbmr8978654plb.62.1709515020106;
        Sun, 03 Mar 2024 17:17:00 -0800 (PST)
Received: from dread.disaster.area (pa49-181-247-196.pa.nsw.optusnet.com.au. [49.181.247.196])
        by smtp.gmail.com with ESMTPSA id p8-20020a170902e74800b001dd091cbc4esm1598569plf.181.2024.03.03.17.16.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Mar 2024 17:16:59 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rgwwr-00Egwg-18;
	Mon, 04 Mar 2024 12:16:57 +1100
Date: Mon, 4 Mar 2024 12:16:57 +1100
From: Dave Chinner <david@fromorbit.com>
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>, Jan Kara <jack@suse.cz>,
	Theodore Ts'o <tytso@mit.edu>, Matthew Wilcox <willy@infradead.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	John Garry <john.g.garry@oracle.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC 3/8] iomap: Add atomic write support for direct-io
Message-ID: <ZeUhCbT4sbucOT3L@dread.disaster.area>
References: <555cc3e262efa77ee5648196362f415a1efc018d.1709361537.git.ritesh.list@gmail.com>
 <6a09654d152d3d1a07636174f5abcfce9948c20c.1709361537.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a09654d152d3d1a07636174f5abcfce9948c20c.1709361537.git.ritesh.list@gmail.com>

On Sat, Mar 02, 2024 at 01:12:00PM +0530, Ritesh Harjani (IBM) wrote:
> This adds direct-io atomic writes support in iomap. This adds -
> 1. IOMAP_ATOMIC flag for iomap iter.
> 2. Sets REQ_ATOMIC to bio opflags.
> 3. Adds necessary checks in iomap_dio code to ensure a single bio is
>    submitted for an atomic write request. (since we only support ubuf
>    type iocb). Otherwise return an error EIO.
> 4. Adds a common helper routine iomap_dio_check_atomic(). It helps in
>    verifying mapped length and start/end physical offset against the hw
>    device constraints for supporting atomic writes.
> 
> This patch is based on a patch from John Garry <john.g.garry@oracle.com>
> which adds such support of DIO atomic writes to iomap.
> 
> Co-developed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> ---
>  fs/iomap/direct-io.c  | 75 +++++++++++++++++++++++++++++++++++++++++--
>  fs/iomap/trace.h      |  3 +-
>  include/linux/iomap.h |  1 +
>  3 files changed, 75 insertions(+), 4 deletions(-)

Ugh. Now we have two competing sets of changes to bring RWF_ATOMIC
support to iomap. One from John here:

https://lore.kernel.org/linux-fsdevel/20240124142645.9334-1-john.g.garry@oracle.com/

and now this one.

Can the two of you please co-ordinate your efforts and based your
filesysetm work off the same iomap infrastructure changes?

.....

> @@ -356,6 +360,11 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
>  	if (need_zeroout) {
>  		/* zero out from the start of the block to the write offset */
>  		pad = pos & (fs_block_size - 1);
> +		if (unlikely(pad && atomic_write)) {
> +			WARN_ON_ONCE("pos not atomic write aligned\n");
> +			ret = -EINVAL;
> +			goto out;
> +		}

This atomic IO should have been rejected before it even got to
the layers where the bios are being built. If the IO alignment is
such that it does not align to filesystem allocation constraints, it
should be rejected at the filesystem ->write_iter() method and not
even get to the iomap layer.

.....

> @@ -516,6 +535,44 @@ static loff_t iomap_dio_iter(const struct iomap_iter *iter,
>  	}
>  }
>  
> +/*
> + * iomap_dio_check_atomic:	DIO Atomic checks before calling bio submission.
> + * @iter:			iomap iterator
> + * This function is called after filesystem block mapping and before bio
> + * formation/submission. This is the right place to verify hw device/block
> + * layer constraints to be followed for doing atomic writes. Hence do those
> + * common checks here.
> + */
> +static bool iomap_dio_check_atomic(struct iomap_iter *iter)
> +{
> +	struct block_device *bdev = iter->iomap.bdev;
> +	unsigned long long map_len = iomap_length(iter);
> +	unsigned long long start = iomap_sector(&iter->iomap, iter->pos)
> +						<< SECTOR_SHIFT;
> +	unsigned long long end = start + map_len - 1;
> +	unsigned int awu_min =
> +			queue_atomic_write_unit_min_bytes(bdev->bd_queue);
> +	unsigned int awu_max =
> +			queue_atomic_write_unit_max_bytes(bdev->bd_queue);
> +	unsigned long boundary =
> +			queue_atomic_write_boundary_bytes(bdev->bd_queue);
> +	unsigned long mask = ~(boundary - 1);
> +
> +
> +	/* map_len should be same as user specified iter->len */
> +	if (map_len < iter->len)
> +		return false;
> +	/* start should be aligned to block device min atomic unit alignment */
> +	if (!IS_ALIGNED(start, awu_min))
> +		return false;
> +	/* If top bits doesn't match, means atomic unit boundary is crossed */
> +	if (boundary && ((start | mask) != (end | mask)))
> +		return false;
> +
> +	return true;
> +}

I think you are re-implementing stuff that John has already done at
higher layers and in a generic manner. i.e.
generic_atomic_write_valid() in this patch:

https://lore.kernel.org/linux-fsdevel/20240226173612.1478858-4-john.g.garry@oracle.com/

We shouldn't be getting anywhere near the iomap layer if the IO is
not properly aligned to atomic IO constraints...

So, yeah, can you please co-ordinate the development of this
patchset with John and the work that has already been done to
support this functionality on block devices and XFS?

-Dave.
-- 
Dave Chinner
david@fromorbit.com

