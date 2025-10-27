Return-Path: <linux-ext4+bounces-11102-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2961FC0F41C
	for <lists+linux-ext4@lfdr.de>; Mon, 27 Oct 2025 17:25:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1052189D7B1
	for <lists+linux-ext4@lfdr.de>; Mon, 27 Oct 2025 16:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2394931329D;
	Mon, 27 Oct 2025 16:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r+sbj3if"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44687272816
	for <linux-ext4@vger.kernel.org>; Mon, 27 Oct 2025 16:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761582319; cv=none; b=doj7Wq+imxrlyAcbDtYvYbLYdLucdm84QdMtBJpuXWyVMM5xjK63Mh+Dji4deSnmNnizUTeYqV0zT4lTQ5igQMRdZJ4JitK4tI+qjvnyY0U9tB42IfPI0NjFdhhTz9EX2rLiLhrGUfFdPW8EGsJEr8uADeSA8S3xk5aLRp9unTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761582319; c=relaxed/simple;
	bh=NHQFCgdRmLY6YieuNEQSpa1ugmd876uhsKPea5BZfmc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QsnFK/IW9fe1ur2SWZ4THnwWoD3ncg0M7hXF6YSuXpC0dX1mzV01AgoevnIfN0r4zz5EXlq2qmLQIhizdJApc0UrHO9pmxP1cFA6oMkg5WGXLQwcCfEzBS6fSgbZx9IleT8+ko5vlhX6S8x6n1n6+cssVfdifTOfobJkOzGWH5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r+sbj3if; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-27eeafd4882so438905ad.0
        for <linux-ext4@vger.kernel.org>; Mon, 27 Oct 2025 09:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761582317; x=1762187117; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OA9l/QOwE9NOyiyFNsn7QxEhEu+4ZD2/v3QYZRP7FEE=;
        b=r+sbj3ifHd2Y4gmXEBg/qllCCsmXbAVTJYZvC7jtnBId0J21ggZwLWo/N+05X/YwON
         NOsi440ntenlkqaorBsC4KHBu3SiL+Nm6BkySUyyL6+py5x5mHWcHlRwGq+ZOU5RzYf5
         e5VnvNtLDT/8fLnPrkWXWHalAnyNc7JHDib8wgl9KYlyNh08l4yw5lO1NmWFqlscFcNn
         vCncWTpKxlspEdcniV/RFW0XRul3f3ubnHbHbkdU6OUgLqrBmjNyFKJL7Q6Uuh2C+JIf
         YeTzX8o+PgMvnIXKW85EkqzX8xmSI/37Tc/fluuyeiXgiEarPa7R5Ab+lQedxEZfg2VT
         KYjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761582317; x=1762187117;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OA9l/QOwE9NOyiyFNsn7QxEhEu+4ZD2/v3QYZRP7FEE=;
        b=xBdWAjds+dqoTujqycSRLj1eRuDZNI44vKGQQHQxNv3U/Gb+iLm+zb2mSA0/BKI8Jp
         VK10viXkqNF17urzw12jnZWFo5Zomv3dK5/do2jx0chXmLpP0Yc2GUxYgSNppgifqEH/
         9f5NZ4NfvgTj/TT7xNsp/td1APZWH7rVuIE86WxhznE6p6nKmRQ2Vl5VpmuxqXuhswm4
         Djx8mVnen/PTS2BxHesUdKmeDieXJ9U8KFnC3vCwP6Lg4JpfIWGKUJA7S28VrC6AEDGX
         KybL8qCDofnpzrEMWLhQ0eW6CTJcm7QSp/7vxtqNv9GwOPLt9oa93rYoWfAxb2XCRQwV
         exLA==
X-Forwarded-Encrypted: i=1; AJvYcCV8VHAHURGkltNDtsDHSGhV2LPay9qx72x85W/HfgXd+AtzwWkjmdDQQU774Vt0rAbfv3+ESqaYVSFS@vger.kernel.org
X-Gm-Message-State: AOJu0YxNANxJWWTc1IhLfIubt26aGTaRFs6C8SmzJgqrPhC6SbJSWyIg
	F+ipLHza8uGAzkBQZT8rzwNRSKfJpCd4w+ljY2sJsqMKyHOGfJbh3+xpL4WHyjyspg==
X-Gm-Gg: ASbGncveeqRV0/CdLSTsrrnqEpgR20I75wubdW/ZedEvtAm8j28WAgzh1IDFE7Ehty2
	2rn/rK7Sa/knYKa6X2PwDcG2E9TTCMPirkzpK0xaWSktMwIxTNYFqTyBQ3UNUudqSN+1cz4iV3c
	41ujwoG+A1h0Y3m4SISsCgcE9SQxyYQgnaIslMPrWMVeBNF68PAqfyEv/uJ89xMqrAlO08HqEDn
	E3aKVzTFBn2QKHWg5k+L1Ss3OZQomDp14K6WdZ60MISaQBZFrGvCCIEYW2QYAEX6ubupO4nTWSB
	tJfR0Mt0uF1IMDC2wi8bZmL5uIKmflKja6KuNI+kE00v5QmjmOiA2xINhVTpbOmVzKr0pdc+akw
	Sm1dUK98ssf79XsKfwj2P49fiuLTkysDRVEUQOXv4APJOSWOkYqVQxV0tvcAev+4MfMIqmsmv1h
	0U7cSTD1a4z/ROhCglsXLPxuChAqJXR47wuZHVJr8OMgg5n1wfIisXtzidO+DQ6kyFXPA41OESq
	4x+5yiuOrPl+9anYO6g/Xx+
X-Google-Smtp-Source: AGHT+IFKZDRX6tQRN5pvW3CwhpfGgubDP1vSSsxiWhhv07ddyAa3jE3sqUCokPVKtw7qF4bHsuW1iw==
X-Received: by 2002:a17:902:ce84:b0:274:1a09:9553 with SMTP id d9443c01a7336-29497bb4f1amr9734305ad.6.1761582316225;
        Mon, 27 Oct 2025 09:25:16 -0700 (PDT)
Received: from google.com (235.215.125.34.bc.googleusercontent.com. [34.125.215.235])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed74028fsm9091554a91.8.2025.10.27.09.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 09:25:15 -0700 (PDT)
Date: Mon, 27 Oct 2025 16:25:10 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org, hch@lst.de,
	axboe@kernel.dk, Keith Busch <kbusch@kernel.org>,
	Hannes Reinecke <hare@suse.de>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCHv4 5/8] iomap: simplify direct io validity check
Message-ID: <aP-c5gPjrpsn0vJA@google.com>
References: <20250827141258.63501-1-kbusch@meta.com>
 <20250827141258.63501-6-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250827141258.63501-6-kbusch@meta.com>

On Wed, Aug 27, 2025 at 07:12:55AM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> The block layer checks all the segments for validity later, so no need
> for an early check. Just reduce it to a simple position and total length
> check, and defer the more invasive segment checks to the block layer.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/iomap/direct-io.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index fea23fa6a402f..c06e41fd4d0af 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -337,8 +337,7 @@ static int iomap_dio_bio_iter(struct iomap_iter *iter, struct iomap_dio *dio)
>  	u64 copied = 0;
>  	size_t orig_count;
>  
> -	if ((pos | length) & (bdev_logical_block_size(iomap->bdev) - 1) ||
> -	    !bdev_iter_is_aligned(iomap->bdev, dio->submit.iter))
> +	if ((pos | length) & (bdev_logical_block_size(iomap->bdev) - 1))
>  		return -EINVAL;
>  
>  	if (dio->flags & IOMAP_DIO_WRITE) {
> -- 
> 2.47.3
> 

Hey Keith, I'be bisected an LTP issue down to this patch. There is a
O_DIRECT read test that expects EINVAL for a bad buffer alignment.
However, if I understand the patchset correctly, this is intentional
move which makes this LTP test obsolete, correct?

The broken test is "test 5" here:
https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/syscalls/read/read02.c

... and this is what I get now:
  read02.c:87: TFAIL: read() failed unexpectedly, expected EINVAL: EIO (5)

Cheers,
Carlos Llamas

