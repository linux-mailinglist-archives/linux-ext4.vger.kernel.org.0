Return-Path: <linux-ext4+bounces-6777-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD1CA5E4CE
	for <lists+linux-ext4@lfdr.de>; Wed, 12 Mar 2025 20:52:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C10067A9E52
	for <lists+linux-ext4@lfdr.de>; Wed, 12 Mar 2025 19:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DE9D25B69A;
	Wed, 12 Mar 2025 19:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="GOGJO3C2"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6251925A348
	for <linux-ext4@vger.kernel.org>; Wed, 12 Mar 2025 19:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741809125; cv=none; b=FZpmEvfPuNNYaSP/kBZ1OJBZg/8Mhu+u3ZQBo5/U4qrzl/xFvGWDEHabISJOT5Zg/QV7iiYBxE7R2jqV3DLYWNAS308F1WBrExeSUSR48c0BdzIMsjk5PF732uFIMgxaOijGQf/1zwEkwos8b32vYMWFw0oFYylH1UHPf2aBw2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741809125; c=relaxed/simple;
	bh=9nCebzwQcT7vsmLoqvflspQkiwpll02VlnYPMm4lKOU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tCnQ6JmbuDjK5DOOElJkzYUtVOnlhG8zaxCiFRBq9x9vFjrqgQHkOQof1BOvX4MhNfuSG8wxrgc1BfsA9gFvXpJZi7wiF9wrVoB5/Aq+nV+BfSo6ZoHXaD/fNBuCtdkdQ3UhKcgg8CqcXMNCj9K4uh03gC2xIdtHCRlHO5V0A88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=GOGJO3C2; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2255003f4c6so4900355ad.0
        for <linux-ext4@vger.kernel.org>; Wed, 12 Mar 2025 12:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1741809123; x=1742413923; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IZXks1yCL59Hzx10jJaOlAET0rV27Iyc9SiIzk3nPyM=;
        b=GOGJO3C2/wlKBsCli3wHpFSOAwpXN67Fhww6AHNXYt6ZpwFMGx0mwROgOHuRh31IsN
         XMYFA56eCx/vM/UTdDzC2NI8M2998h9Uwk3pdfw7BIdhyCXy+qL8JGnSRQFNo4u+89O7
         ACbwFNWCtPHgj/g+5zdJIKSwNc2W0hJYYTMOG9ybHwEwyM5G8RvLELZntsHfU7/dEYL1
         8IantO9rfNEihePEb018gGVDovaRq/eiz6zb8BanToOTCBKOWkh6X/IV3pK8dUAziGqa
         Vy8in57gtB5Q3gDxLDCyihkhXEARr3IHWvdHZyC+QbCi+iYQQ1nDkOWrs0wv23WRgqPC
         aflQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741809123; x=1742413923;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IZXks1yCL59Hzx10jJaOlAET0rV27Iyc9SiIzk3nPyM=;
        b=lxCkhXwO66nt7yjrlVF10qqvyS6U2AsBAgqY7Nh0z5bfK4huL2q+CtAPQQD+KsEsRk
         2WLv+hJqGO8Yd7tcxmB0a3W2vTC7jtkf/4Bw3mNZ9x2oXZoe74ldb7drd/5PBIpWUEM3
         f9dnUkHQnnz8McHmO7q0F0Zm7UMNIia2nFFoPNS/+HZyggbOb9cB0ehzlq5gxQI57ZXZ
         uRpUCSvfIjjrv+2j+a6qKy1zj7Dase/ITlh/Cars/dieOX/zcMTqoq8hV0vuEE9gdpxS
         2RV/GX3egSRGUdOcM0/7YZpqgO840KMltZ0VUuQHPzy7oQRBYvsFNhJCEBi0IhOY26YY
         XkRA==
X-Forwarded-Encrypted: i=1; AJvYcCUvPmAQ19DAiCASpm2c/HQ2fE2Aeh7mPVvqRRNwdflP0FR316oHs0QYW1HOzukUYTz6JtxDO/GWoO2y@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5H4r6WRcKrRn0qRSwSFkmnZ1DKyjt+qOx6ysCxlsjb/fikuNf
	P2OaasCmJNOsanR67W898TOCkxAZ8FXbDWmGTseP1Fsl7LhZUEFqnMmAStt5LXSCbpcXtZbSaIr
	T
X-Gm-Gg: ASbGncuMR5ZlyDonb3jiwRF5T54fKrJp+a8w1bk89m72Cfq6FSFlXZVL9hgroZuz8UF
	9okoA+BN3ziC7Y7UtLq6w3mTovcNbuzkPyBKwRqXMn6XA17Ggw9d3kEEogXB0k9AlBJ0DG4zFog
	8hBOk/dWZ9u21OJhPKStPgKcuMhi+FpDGtsIti/fqxVPOaKEhtAsh7TXhy1er1fZH4PtLLeVcrd
	heX5pL7avawRQbLWESss14omfSX8j+8eGuF7JWkRwhzQlCr+lMmIhPLXJhC8y0XBDIqL/Anbupw
	pnW7TSe9kQV8t9mVKaGn8Xuqh7oz9EQjL/EIxzXlTj8uFRxbVpL1p8OKVU673n1ySN77XzTeviI
	IMsAOGzf484Eh/hX64ARQ
X-Google-Smtp-Source: AGHT+IEE2EJW9ndEG7Y/L7HAyUCKmqOhXbnMCG+N60tA8rq5IwDA5m81XvtvYTp7j4ChVG457AtQ1g==
X-Received: by 2002:a17:903:228e:b0:224:b60:3cd3 with SMTP id d9443c01a7336-22592e2d676mr134144265ad.19.1741809122629;
        Wed, 12 Mar 2025 12:52:02 -0700 (PDT)
Received: from dread.disaster.area (pa49-186-89-135.pa.vic.optusnet.com.au. [49.186.89.135])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-224109e99dfsm120190275ad.91.2025.03.12.12.52.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 12:52:02 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tsS7T-0000000CHVL-0aXe;
	Thu, 13 Mar 2025 06:51:59 +1100
Date: Thu, 13 Mar 2025 06:51:59 +1100
From: Dave Chinner <david@fromorbit.com>
To: John Garry <john.g.garry@oracle.com>
Cc: brauner@kernel.org, djwong@kernel.org, cem@kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
	ritesh.list@gmail.com, martin.petersen@oracle.com, tytso@mit.edu,
	linux-ext4@vger.kernel.org
Subject: Re: [PATCH v4 12/12] xfs: Allow block allocator to take an alignment
 hint
Message-ID: <Z9Hl39cS-V2r-5mY@dread.disaster.area>
References: <20250303171120.2837067-1-john.g.garry@oracle.com>
 <20250303171120.2837067-13-john.g.garry@oracle.com>
 <Z84QRx_yEDEDUxr5@dread.disaster.area>
 <ad152fa0-0767-45cb-921e-c3e9f5eac110@oracle.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad152fa0-0767-45cb-921e-c3e9f5eac110@oracle.com>

On Mon, Mar 10, 2025 at 12:10:44PM +0000, John Garry wrote:
> On 09/03/2025 22:03, Dave Chinner wrote:
> > On Mon, Mar 03, 2025 at 05:11:20PM +0000, John Garry wrote:
> > > diff --git a/fs/xfs/libxfs/xfs_bmap.h b/fs/xfs/libxfs/xfs_bmap.h
> > > index 4b721d935994..e6baa81e20d8 100644
> > > --- a/fs/xfs/libxfs/xfs_bmap.h
> > > +++ b/fs/xfs/libxfs/xfs_bmap.h
> > > @@ -87,6 +87,9 @@ struct xfs_bmalloca {
> > >   /* Do not update the rmap btree.  Used for reconstructing bmbt from rmapbt. */
> > >   #define XFS_BMAPI_NORMAP	(1u << 10)
> > > +/* Try to align allocations to the extent size hint */
> > > +#define XFS_BMAPI_EXTSZALIGN	(1u << 11)
> > 
> > Don't we already do that?
> > 
> > Or is this doing something subtle and non-obvious like overriding
> > stripe width alignment for large atomic writes?
> > 
> 
> stripe alignment only comes into play for eof allocation.
> 
> args->alignment is used in xfs_alloc_compute_aligned() to actually align the
> start bno.
> 
> If I don't have this, then we can get this ping-pong affect when overwriting
> atomically the same region:
> 
> # dd if=/dev/zero of=mnt/file bs=1M count=10 conv=fsync
> # xfs_bmap -vp mnt/file
> mnt/file:
> EXT: FILE-OFFSET      BLOCK-RANGE      AG AG-OFFSET        TOTAL FLAGS
>   0: [0..20479]:      192..20671        0 (192..20671)     20480 000000
> # /xfs_io -d -C "pwrite -b 64k -V 1 -A -D 0 64k" mnt/file
> wrote 65536/65536 bytes at offset 0
> 64 KiB, 1 ops; 0.0525 sec (1.190 MiB/sec and 19.0425 ops/sec)
> # xfs_bmap -vp mnt/file
> mnt/file:
> EXT: FILE-OFFSET      BLOCK-RANGE      AG AG-OFFSET        TOTAL FLAGS
>   0: [0..127]:        20672..20799      0 (20672..20799)     128 000000
>   1: [128..20479]:    320..20671        0 (320..20671)     20352 000000
> # /xfs_io -d -C "pwrite -b 64k -V 1 -A -D 0 64k" mnt/file
> wrote 65536/65536 bytes at offset 0
> 64 KiB, 1 ops; 0.0524 sec (1.191 MiB/sec and 19.0581 ops/sec)
> # xfs_bmap -vp mnt/file
> mnt/file:
> EXT: FILE-OFFSET      BLOCK-RANGE      AG AG-OFFSET        TOTAL FLAGS
>   0: [0..20479]:      192..20671        0 (192..20671)     20480 000000
> # /xfs_io -d -C "pwrite -b 64k -V 1 -A -D 0 64k" mnt/file
> wrote 65536/65536 bytes at offset 0
> 64 KiB, 1 ops; 0.0524 sec (1.191 MiB/sec and 19.0611 ops/sec)
> # xfs_bmap -vp mnt/file
> mnt/file:
> EXT: FILE-OFFSET      BLOCK-RANGE      AG AG-OFFSET        TOTAL FLAGS
>   0: [0..127]:        20672..20799      0 (20672..20799)     128 000000
>   1: [128..20479]:    320..20671        0 (320..20671)     20352 000000
> 
> We are never getting aligned extents wrt write length, and so have to fall
> back to the SW-based atomic write always. That is not what we want.

Please add a comment to explain this where the XFS_BMAPI_EXTSZALIGN
flag is set, because it's not at all obvious what it is doing or why
it is needed from the name of the variable or the implementation.

-Dave.

-- 
Dave Chinner
david@fromorbit.com

