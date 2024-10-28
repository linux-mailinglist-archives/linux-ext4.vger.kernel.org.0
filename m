Return-Path: <linux-ext4+bounces-4831-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D27299B2422
	for <lists+linux-ext4@lfdr.de>; Mon, 28 Oct 2024 06:26:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13552B2142F
	for <lists+linux-ext4@lfdr.de>; Mon, 28 Oct 2024 05:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F039818C91F;
	Mon, 28 Oct 2024 05:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="pJ/hLgol"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1BD170A14
	for <linux-ext4@vger.kernel.org>; Mon, 28 Oct 2024 05:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730093169; cv=none; b=DLKJsS2ORmYM0w5aTp4juqx3Ye1/9GACYPdNhvCcrMOGJ0i1Al4bBwBSE2IqurQy71J/dzM+4uLKJI17lkbjasSV5TseRViiizFcEpPOCGIvXJEaJOGsjuIdibyKwEPXgUl8/CCZl8npLQMQBUALQ6Iu/inSbarPj2SbdSscMK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730093169; c=relaxed/simple;
	bh=iRnLCBjGCZmdswD8L6vxT3DzJwoWN7WXYl0w/SsifZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p991h/fXjNAdtaiXKWny7AaGl37QWe4CdlF5HVjDpkeJZCW3pjL2bKlZZ9cOfa3luIqoqO1mXA8Ypfeqjuz69+4E1aP1BRJM2elWWSrOREf6G8npNIbKolEtc/YY5uDgQrUnAjbnqhYhHTG/i0PRk3Bo9oHTp7sbJiyAG1zpUzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=pJ/hLgol; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20caccadbeeso40990675ad.2
        for <linux-ext4@vger.kernel.org>; Sun, 27 Oct 2024 22:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1730093167; x=1730697967; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2Q7ptIREBatZjd8dBV5b/Qd6B2L3n4WY1Wuc9++2Okc=;
        b=pJ/hLgolkDPoiVpQIm/DPz1tIIHooSfb8Or05XIuy2uXZrNaYJt0u6tK2g/xjWlSRC
         WgFnx8AhmkNMQufUOF/RMqbuBhyRc6upJubJlYUl5gdNC0+iHMmFRe3dS1CaLQFqXl/q
         j7r9iM3f4Mv/9L1esVv1HvP0/aqqZ4gtAGbSh7wKEBTiEMpO7oE/rnJaxIyQ7aU/iko6
         N2BDNN2Ge/ITXWQoSSc1t4J1CKoU+wYMlu4mee/U0A9Rs6kPLUdNW2mUFwVMsIcfLLCu
         j7yO9QxY4vq2NC4MiQxtH5WqtwlVlu77WlxjzOFXZ0LR4GN6ONhR+xEks3mvPqFZiuuq
         hf3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730093167; x=1730697967;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Q7ptIREBatZjd8dBV5b/Qd6B2L3n4WY1Wuc9++2Okc=;
        b=pRTa44Esqh8e/sNRlcSeZ7N1JfXO9rK4Zho7v3dgdlfxTsdxEQUc5EVPqC9yK3iFRb
         Ps2LYdnJBVgmduomm5h8paxOLPOjZESE1SeXSmDLT53DHV3jvQNirh+s6HueQGyJAhg4
         X3WLupOkjgZv6CLlTUs4EfUvy47HajOxm41iSmZS08WjORq3zN7FErhRoy17GKbNwZGG
         lJ85ewfCqU52nl8cf9UcQxodXkgHgKPlMe5FBxrrStwz9p1eOFgVhWxvjF5J1xk2oIea
         bBYZ7BCAh9LvpGyrfgeRvMF6pX3l1O9dZ0WwNUfMBx8/110qFua5GmRRfRXEOD7Ak3TH
         BsgA==
X-Gm-Message-State: AOJu0YwY/APLxkxdu2zHJMS46ebbvr7v5vkbID8KHBNGTvRlZbhsu8Nx
	p6qasD5SPzkVousPTv7v3aP9npEhSoguquDSjQHizcJ1LyHENSmZ/IA5/4ZDTIA=
X-Google-Smtp-Source: AGHT+IFPxeRf9IuVVTDCJj4v1ByXNtqUKo50trb3jTrgm4WFJiMGk499pN63tQrEWj+eFKMRI/dnXQ==
X-Received: by 2002:a17:902:c943:b0:205:709e:1949 with SMTP id d9443c01a7336-210c6d4450cmr90056815ad.57.1730093166880;
        Sun, 27 Oct 2024 22:26:06 -0700 (PDT)
Received: from dread.disaster.area (pa49-186-86-168.pa.vic.optusnet.com.au. [49.186.86.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bbf4435asm43489265ad.55.2024.10.27.22.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2024 22:26:06 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1t5IGR-006mkH-0i;
	Mon, 28 Oct 2024 16:26:03 +1100
Date: Mon, 28 Oct 2024 16:26:03 +1100
From: Dave Chinner <david@fromorbit.com>
To: Ritesh Harjani <ritesh.list@gmail.com>
Cc: linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
	Jan Kara <jack@suse.cz>, "Darrick J . Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	John Garry <john.g.garry@oracle.com>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>, linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 4/6] ext4: Warn if we ever fallback to buffered-io for
 DIO atomic writes
Message-ID: <Zx8ga59h0JgU/YIC@dread.disaster.area>
References: <cover.1729825985.git.ritesh.list@gmail.com>
 <7c4779f1f0c8ead30f660a2cfbdf4d7cc08e405a.1729825985.git.ritesh.list@gmail.com>
 <Zx6+F4Cl1owSDspD@dread.disaster.area>
 <87iktdm3sf.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87iktdm3sf.fsf@gmail.com>

On Mon, Oct 28, 2024 at 06:39:36AM +0530, Ritesh Harjani wrote:
> 
> Hi Dave, 
> 
> Dave Chinner <david@fromorbit.com> writes:
> 
> > On Fri, Oct 25, 2024 at 09:15:53AM +0530, Ritesh Harjani (IBM) wrote:
> >> iomap will not return -ENOTBLK in case of dio atomic writes. But let's
> >> also add a WARN_ON_ONCE and return -EIO as a safety net.
> >> 
> >> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> >> ---
> >>  fs/ext4/file.c | 10 +++++++++-
> >>  1 file changed, 9 insertions(+), 1 deletion(-)
> >> 
> >> diff --git a/fs/ext4/file.c b/fs/ext4/file.c
> >> index f9516121a036..af6ebd0ac0d6 100644
> >> --- a/fs/ext4/file.c
> >> +++ b/fs/ext4/file.c
> >> @@ -576,8 +576,16 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
> >>  		iomap_ops = &ext4_iomap_overwrite_ops;
> >>  	ret = iomap_dio_rw(iocb, from, iomap_ops, &ext4_dio_write_ops,
> >>  			   dio_flags, NULL, 0);
> >> -	if (ret == -ENOTBLK)
> >> +	if (ret == -ENOTBLK) {
> >>  		ret = 0;
> >> +		/*
> >> +		 * iomap will never return -ENOTBLK if write fails for atomic
> >> +		 * write. But let's just add a safety net.
> >> +		 */
> >> +		if (WARN_ON_ONCE(iocb->ki_flags & IOCB_ATOMIC))
> >> +			ret = -EIO;
> >> +	}
> >
> > Why can't the iomap code return EIO in this case for IOCB_ATOMIC?
> > That way we don't have to put this logic into every filesystem.
> 
> This was origially intended as a safety net hence the WARN_ON_ONCE.
> Later Darrick pointed out that we still might have an unconverted
> condition in iomap which can return ENOTBLK for DIO atomic writes (page
> cache invalidation).

Yes. That's my point - iomap knows that it's an atomic write, it
knows that invalidation failed, and it knows that there is no such
thing as buffered atomic writes. So there is no possible fallback
here, and it should be returning EIO in the page cache invalidation
failure case and not ENOTBLK.

> You pointed it right that it should be fixed in iomap. However do you
> think filesystems can still keep this as safety net (maybe no need of
> WARN_ON_ONCE).

I don't see any point in adding "impossible to hit" checks into
filesystems just in case some core infrastructure has a bug
introduced....

-Dave.

-- 
Dave Chinner
david@fromorbit.com

