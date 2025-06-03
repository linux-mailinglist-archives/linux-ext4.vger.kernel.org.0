Return-Path: <linux-ext4+bounces-8286-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 908D7ACC839
	for <lists+linux-ext4@lfdr.de>; Tue,  3 Jun 2025 15:48:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B62021889D54
	for <lists+linux-ext4@lfdr.de>; Tue,  3 Jun 2025 13:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ACDE238D2B;
	Tue,  3 Jun 2025 13:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="bcbblDxg"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442B123816C
	for <linux-ext4@vger.kernel.org>; Tue,  3 Jun 2025 13:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748958472; cv=none; b=Dy+QUvxfHrOBm+tuOOcb2tQ1uvsM9k/UnhQYCB/uQTZevnf8HAlfLKzjuixisU/bTygCpvRhXQrXXCJ7C2D0wVlMLIYwoefN+hXWlD+Hk7dQpm2fq+9vDkJYkr+dOS1TtTUF+jzJgMYoiMSANShV8y6tZn1epQOdFMORyA230co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748958472; c=relaxed/simple;
	bh=QuA4bLScr7zZl9oRdPCFKpAujll0Lr/hMN/nG963i68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LehaUMj4xmO8CXvPqKBTLVmp+ObomDmfQZzsbHRjVxAgIKZtO8Vq3ZXlttpbY6aXOyLgSxdkQ1rB10IaPksPQUG0NChVxWrAetR0rJGL0x9ws+/3d4PYZqM1M/ytqcoWQNLB3Y8+cWfzWHkTKYOZFa4q895QC4ubkH8lbmvg2lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=bcbblDxg; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-730580b0de8so3721017a34.1
        for <linux-ext4@vger.kernel.org>; Tue, 03 Jun 2025 06:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1748958470; x=1749563270; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UpF3njOJtHrMyikmrAfZ4zzOg2YUvEVFUbKoE3kb2rM=;
        b=bcbblDxgaCWpXfttqmUcdoBoYMbuay6D8z7S4RlHmwfg9FWEFerb/mKsF3806mT3F1
         +aspVIhWyWVbnQL4vAxjsApLcyRisrxoBGXPJFuWGESq65R/E+xIevTVOjpR74I0/y2o
         5hgqYceelth0nebvZWKjpqdAlbrdxBVpwbWFiPfwOhNYuoOHO2OJc/R3u77bzDsgxOz3
         YPNH9j40XI1UuIvlytU1x5oB+i+0ifWfYOF/ym+YnoStzsmbtcqTOIzU1lgtZPvyCgqZ
         xxo2WEYmh1a8DDHv+pocQwyFijicYQvSbWw8VrKRF5p5RkG7jhn0rwkNMcsVe37DyV1d
         2BeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748958470; x=1749563270;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UpF3njOJtHrMyikmrAfZ4zzOg2YUvEVFUbKoE3kb2rM=;
        b=sj3P2K2GXzr7ItbOwm3fYoNuCLQXEiLIB/6xgPV5ecAxjtdMZn3uBd6RfXrbSWMC88
         iIPnhJParA8+CckPvd0zUah7+ZNqK/aBk/kdZuT8+3wTOw0jSKZVEyF+nLdwiXwdU321
         fRY/4ZRjzJeZPQ46/thdbAaCGBRtqVXZ0wW1K6l8aC1Z8RC+f/IPGjTHmYQ/nwkYqbHa
         6X2GD4Apij+SBCY71qZyzHyN0UkqutzO6WW2nsuvSLtD6kascHjxlr+mHz7/vq7quECV
         rVbBos5bv0+FGM5tLnp3bGyrkZzteNpNs234n3vHa7BecZpdsYSS7FyVmnqbod0qcIz+
         qIEw==
X-Forwarded-Encrypted: i=1; AJvYcCWX58DleYulOpGF/o8K9ImgFx2it/I/abMZ41jFjhe29OA7Sc7wjO0YXccMfHokcwXg8lr0myxaR1Xi@vger.kernel.org
X-Gm-Message-State: AOJu0YyHeit6mCjQwvmrLdyOXmOp/e+gix6y3bPm7qFqDOjHZf/WR0rY
	B0e1dp+4h3zXZLYCeplqU7kNhqgyX5cY0hf3wKnfVYsK/gKe9+Tbl+4IqdpfRRYl+vqB1bq7L4E
	wqHJW
X-Gm-Gg: ASbGncvtI0QTT0PjobVHJAf4kI1o4UvhVfDe2spWPw2dG+TdEtL1s6htuASGPIn5o8O
	GlzWApSehJd9HHcoQoqAWuH36/SMd9J1a+hPJAFqQ4S43Z0Q+um7voAJslG1ECBJu+4n/VfhJnQ
	QrLxNONQqPgOh5v0pKqbuMcuPk5C0RwMV/l2Ss8fr7uYpbuMzmpdxpExbLXqQZBWO0TiSjwDwwI
	hYdWkLJgINupx5n5eMlLnlxvetCb5vsrC8jIiJON7Epuupe/iU4t9l37PrSXEx5icGUZ6axRgo5
	pAzYT+0pOkshGcxzfd3TVrnRjrZL7FOHu9HzANSu6Ltt4HhEAn7j09kaBRgTDTxLiQ+OL5bCYZi
	1HIlCeYaWIvky0VoTZOUvdbJIpu4=
X-Google-Smtp-Source: AGHT+IEn/uCXnqGk9mGrQEIlQbsguMg4s70jmRhOs28+dV79kPuZtTFgI19mnXFgGkPMbOXTAF/Qjg==
X-Received: by 2002:a05:620a:278d:b0:7c5:d71c:6a47 with SMTP id af79cd13be357-7d211676724mr394455585a.8.1748958459265;
        Tue, 03 Jun 2025 06:47:39 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-56-70.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.56.70])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d09a195d7dsm840098585a.78.2025.06.03.06.47.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 06:47:38 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uMRzO-00000001hB3-1CmA;
	Tue, 03 Jun 2025 10:47:38 -0300
Date: Tue, 3 Jun 2025 10:47:38 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Alistair Popple <apopple@nvidia.com>
Cc: linux-mm@kvack.org, gerald.schaefer@linux.ibm.com,
	dan.j.williams@intel.com, willy@infradead.org, david@redhat.com,
	linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org, jhubbard@nvidia.com, hch@lst.de,
	zhang.lyra@gmail.com, debug@rivosinc.com, bjorn@kernel.org,
	balbirs@nvidia.com, lorenzo.stoakes@oracle.com,
	linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
	linux-cxl@vger.kernel.org, dri-devel@lists.freedesktop.org,
	John@groves.net
Subject: Re: [PATCH 06/12] mm/gup: Remove pXX_devmap usage from
 get_user_pages()
Message-ID: <20250603134738.GG386142@ziepe.ca>
References: <cover.541c2702181b7461b84f1a6967a3f0e823023fcc.1748500293.git-series.apopple@nvidia.com>
 <c4d81161c6d04a7ae3f63cc087bdc87fb25fd8ea.1748500293.git-series.apopple@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4d81161c6d04a7ae3f63cc087bdc87fb25fd8ea.1748500293.git-series.apopple@nvidia.com>

On Thu, May 29, 2025 at 04:32:07PM +1000, Alistair Popple wrote:
> GUP uses pXX_devmap() calls to see if it needs to a get a reference on
> the associated pgmap data structure to ensure the pages won't go
> away. However it's a driver responsibility to ensure that if pages are
> mapped (ie. discoverable by GUP) that they are not offlined or removed
> from the memmap so there is no need to hold a reference on the pgmap
> data structure to ensure this.

Yes, the pgmap refcounting never made any sense here.

But I'm not sure this ever got fully fixed up?

To solve races with GUP fast we need a IPI/synchronize_rcu after all
VMAs are zapped and before the pgmap gets destroyed. Granted it is a
very small race in gup fast, it still should have this locking.

> Furthermore mappings with PFN_DEV are no longer created, hence this
> effectively dead code anyway so can be removed.
> 
> Signed-off-by: Alistair Popple <apopple@nvidia.com>
> ---
>  include/linux/huge_mm.h |   3 +-
>  mm/gup.c                | 162 +----------------------------------------
>  mm/huge_memory.c        |  40 +----------
>  3 files changed, 5 insertions(+), 200 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

