Return-Path: <linux-ext4+bounces-4826-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3817D9B210D
	for <lists+linux-ext4@lfdr.de>; Sun, 27 Oct 2024 23:26:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D78221F21347
	for <lists+linux-ext4@lfdr.de>; Sun, 27 Oct 2024 22:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAF4117E900;
	Sun, 27 Oct 2024 22:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="IjW6bUL0"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB4C17BB38
	for <linux-ext4@vger.kernel.org>; Sun, 27 Oct 2024 22:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730067998; cv=none; b=VFkpj5gInl8XfWB4mF0Hdqpfq2FQlspriuZeyW4td5YEjip/6njXFe4r75znkyYhgnTgKk0btZerxeKJnWOu60CFCcpbJ1cQ1CPHc0XLrw3iaLPBmKzVbJDrFLMxYJ2DORLh53n/5F4DcwGiLpnfJbbfFXuCacAbnVIry+XRdOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730067998; c=relaxed/simple;
	bh=zMgjdlwzIGQ5AXpdeYA4WHxBtuo2laAJNVW4nG/kSKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nplMw+hmj+o0kjuxp4xFXocV78Reyaz/a4rf1VTyIt0Od1nScPsLFihoH4teTmFP+i9PC6taqAMn6IE2UuBv6mVHLdRXNCC4kbY85qsMLNgZKAXs2Yb0bXl53XKzHKUQIXZ6Oq5aaIUSsTKgrButu/prT8HV5FiBmiTa8wo7gT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=IjW6bUL0; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-71e5a1c9071so2740628b3a.0
        for <linux-ext4@vger.kernel.org>; Sun, 27 Oct 2024 15:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1730067996; x=1730672796; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D5KLTPWrKVlL1s8NH4uZYFz8Mrab34cutllMbEGsnf0=;
        b=IjW6bUL0w0GP95A1OFoZtgJysmSK+I/YlutjD47ZGavOQkpRBMljk56UkLzQppNFLy
         NSCS5b2oTnbc6focB85L/cPvTl8aWbQtup/EHtoyGyhjD/zU+6dMqvS5464cJZHEzfVT
         YdPbiVD9GzQoN63AEALWVI7nWHv7JU5/rNGdW9t651c1gh5A9huuhP8Bnow3b6XaqagK
         OCg3ubri/hR/BGRapJLMW4T4yuKwJZ0ZKXyxzB/gIo+rGlZUFz123qiTKq5Gsw14VPdj
         I5d4U7tsa86RrwztM9D8lmbRwS7CKfuZPzzltx3ZCjo2CVahXpxWl6hWz5Ykzb7s4Q1Q
         Dcaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730067996; x=1730672796;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D5KLTPWrKVlL1s8NH4uZYFz8Mrab34cutllMbEGsnf0=;
        b=kDhUKQHv6Y0/J6hUf7+/kPW7x2m4nwg/aKCxyWxlTgM9z6PGVHOFLV6yaTmHixAm1A
         H9OPQy7amZXQ8b348Lmf0poY+Llb1CLYqxTbJJBgmayeo8/DG+68hzhcEHEwHF7F80JI
         zB10/mdFwSeODY9kCEeCu6OgW/78Kd91Rru0K7l7h/z8XR/cO+DDIN2q7xXUfwggJmyT
         b3xeoRDIVYSsCXbglmLoxjqzGM/7I0tIXRPVdJoe3pfJvmAQ21UBMctvKqdbzQT09utU
         lIk2WdC7kb4EnIZDrjpWoNXhFu5sxWIFnM4W+jwIAQcwdNtP1Ue+S+64llavFcjobm/z
         x99w==
X-Gm-Message-State: AOJu0YyqFU0HrKTbCBcmrAMtisisRD19LL4POPxwHHq7jJWI3uiSBzkw
	aoSIfCEeU4Ey9mJ+LVyR+AUoGGiZgpdosw0kBLNLIcGLxWhMvfVEk3JwOYNDq7g=
X-Google-Smtp-Source: AGHT+IEAKeexdRAG9F5wrcM3jmaPqrDjugV8ZVU3CGrquy532srSBlH8YaKtAz3ee9RU27iCMWii5w==
X-Received: by 2002:a05:6a00:845:b0:71e:7674:4cf6 with SMTP id d2e1a72fcca58-72062f8335fmr9345518b3a.8.1730067995974;
        Sun, 27 Oct 2024 15:26:35 -0700 (PDT)
Received: from dread.disaster.area (pa49-186-86-168.pa.vic.optusnet.com.au. [49.186.86.168])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72057935dafsm4482206b3a.87.2024.10.27.15.26.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2024 15:26:35 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1t5BiR-006eji-2a;
	Mon, 28 Oct 2024 09:26:31 +1100
Date: Mon, 28 Oct 2024 09:26:31 +1100
From: Dave Chinner <david@fromorbit.com>
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
	Jan Kara <jack@suse.cz>, "Darrick J . Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	John Garry <john.g.garry@oracle.com>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>, linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 4/6] ext4: Warn if we ever fallback to buffered-io for
 DIO atomic writes
Message-ID: <Zx6+F4Cl1owSDspD@dread.disaster.area>
References: <cover.1729825985.git.ritesh.list@gmail.com>
 <7c4779f1f0c8ead30f660a2cfbdf4d7cc08e405a.1729825985.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c4779f1f0c8ead30f660a2cfbdf4d7cc08e405a.1729825985.git.ritesh.list@gmail.com>

On Fri, Oct 25, 2024 at 09:15:53AM +0530, Ritesh Harjani (IBM) wrote:
> iomap will not return -ENOTBLK in case of dio atomic writes. But let's
> also add a WARN_ON_ONCE and return -EIO as a safety net.
> 
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> ---
>  fs/ext4/file.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/file.c b/fs/ext4/file.c
> index f9516121a036..af6ebd0ac0d6 100644
> --- a/fs/ext4/file.c
> +++ b/fs/ext4/file.c
> @@ -576,8 +576,16 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  		iomap_ops = &ext4_iomap_overwrite_ops;
>  	ret = iomap_dio_rw(iocb, from, iomap_ops, &ext4_dio_write_ops,
>  			   dio_flags, NULL, 0);
> -	if (ret == -ENOTBLK)
> +	if (ret == -ENOTBLK) {
>  		ret = 0;
> +		/*
> +		 * iomap will never return -ENOTBLK if write fails for atomic
> +		 * write. But let's just add a safety net.
> +		 */
> +		if (WARN_ON_ONCE(iocb->ki_flags & IOCB_ATOMIC))
> +			ret = -EIO;
> +	}

Why can't the iomap code return EIO in this case for IOCB_ATOMIC?
That way we don't have to put this logic into every filesystem.

When/if we start supporting atomic writes for buffered IO, then it's
worth pushing this out to filesystems, but right now it doesn't seem
necessary...

-Dave.
-- 
Dave Chinner
david@fromorbit.com

