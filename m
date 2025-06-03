Return-Path: <linux-ext4+bounces-8289-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18582ACC850
	for <lists+linux-ext4@lfdr.de>; Tue,  3 Jun 2025 15:49:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6590A18875CE
	for <lists+linux-ext4@lfdr.de>; Tue,  3 Jun 2025 13:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D06C239581;
	Tue,  3 Jun 2025 13:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="jJVQcqeC"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901172376E4
	for <linux-ext4@vger.kernel.org>; Tue,  3 Jun 2025 13:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748958549; cv=none; b=rYaZnXtgn9onJfQ8H1PzbezgqJXaazhxXFBoIMe45xmAgHTQx4Ju+VShTigRqrk57RMgJ1oHLmPjIohFTwxC717QW1yMQjI3DLLI8ygEahdGzwkO9zvSA8b6fn2fH/UZw0N58RutDtrm2lg33yymQ4z8AnAljBO11Z/Np0UN1I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748958549; c=relaxed/simple;
	bh=z6KLOqm9i0ROrUFmuMKuPSFgLeSRnBoRY1z3awpPe7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mZKBQeF6hWLTLvSMGn78SQ0GUSdqkG5MChHFEkzF2ejTfV89bqvsfDiCLCU6Cuf8K3wn/SxhKdYa7b1/3TRU0FL1WuIuqLLcxta3appLSN1/ZtlcSx+m0+DBOz9Wi19QiPr94/S+7PA5G3jQOjRNgpOxiZs5PsLPBcjlh+QDlvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=jJVQcqeC; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4a43e277198so40295381cf.1
        for <linux-ext4@vger.kernel.org>; Tue, 03 Jun 2025 06:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1748958546; x=1749563346; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ooaH+MVJLI6au3+Z1ecUWfQ+S7G2Wg3KD+ti8ca06oA=;
        b=jJVQcqeCAc0iTCARHARG2NmR+PX11EDVnFDiahfPqaQTUdXWScZbdTlKmMfZhzmJn1
         rDC7kWLDXsIbilCjju0o/WGrcB+N8UcZ4IKxdQlNREzXmxbaXT1X5l8HfKJdYk9pSkfi
         dxbsGMqa62vDKd3pRQANnxKTtc+tv74/hLJqCamxg8F6SrZez31ZVtLH52rBR+blcXJo
         gRwepcr+jYILzItfj77n3cmsg/NqDOZp2EFfpLVFSOX+NgEBtytbNnrPnt/CMYpcao13
         gxCLzNK/ENITed7fzdzsMwHnkVTZ8FOaVKOyFvstoi+OKo6wD9a7wQ/IW+Cj5LmnWpel
         HNHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748958546; x=1749563346;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ooaH+MVJLI6au3+Z1ecUWfQ+S7G2Wg3KD+ti8ca06oA=;
        b=vhUpfSS52nFHTLgZK/eSUi0eOz7E609FmVWnve6FMzbMYWCdaNQk3Unv8Oyhr9NjTo
         /L/zq+Wy/XI+r4ggeW5kEFvbcEJ+9brRkT7ySTo6s4rE6MhQ5QbnKXxAAXewemnCL6Ie
         E7Vuh+gUpcym8EiNt13Ob2Zn7IixlYVQ2MlE9jr2T/StYGPPzAIK0ED7pBc/9seNFs4b
         bt4L8IozG6Uwrt0HPgVpTBgKfkf9MXoNCUz6N3wYowTkcwG7fKRhhLuzKog1SMqir8Vs
         V/nlkZTo8sV7PS51Z5wB8Uok1gegpobNMm/wsfABEqjxqhzsjP39CQGApDNz5PziX/ox
         f9Ng==
X-Forwarded-Encrypted: i=1; AJvYcCV8UEeimNbdD59RgkXm6s8heoSwa6wAWh1oSZQH+pw6zGd9LKdmTaNPw42nNx64HFAnk2RQEj6g1UbM@vger.kernel.org
X-Gm-Message-State: AOJu0Yym4g0qrLtypFc4RBvPvlfpzo2EKd2d2qMwwooYUbXQAWkod7fz
	imcfJvq++RFLxuld+IYz7y8HBoOFVJj/h8dsppmCaBSnzeQt9GIvPV1uhA2vOk9LpJo=
X-Gm-Gg: ASbGncstWYG3jvd/MOg7Jfjn/YM/Hfewg5c5rnL2h7dGc8pnaTC+Ibq0iwEYGGOzZjy
	fIxY6Pl7wi8wSNZR4yVBm+qhrhjdTkZOcdBdi0Yew/m7AvCXlnaUjom0qDWTJDEDkY5vhEOGbTA
	6uLEOqv8ZBVXgVzJ8A8ZahjKFWm300DVmPHPYphqG6cpvf/ZAN+fWLOsU7bxal0Qtnl6E1bav5d
	Z1dEflca25R3CXPr0eIqieJ0K/Rc5NJ6y2A4XpukTFgm/Y9Md6ji3WI/NahO7bQISJnh1BHoNO4
	vK0150XTqLHExKhNzoXIFM/Mg/RyoE1T6iPdj1IgsboutQug9vRB/PuayAFwts0nJIEMCES7Riy
	MoCUPZ76alOiDk2qmyu1/tPdKZ+w=
X-Google-Smtp-Source: AGHT+IGIU1g+493Q79vIGhbP57BxcXzG4cORozjsE0WNUaw+m77zFEPhKIIEfe6WhON7WEL1UbHK4w==
X-Received: by 2002:a05:622a:5a98:b0:494:b914:d140 with SMTP id d75a77b69052e-4a4aed8a697mr209908281cf.43.1748958546430;
        Tue, 03 Jun 2025 06:49:06 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-56-70.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.56.70])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a435772a19sm74189111cf.1.2025.06.03.06.49.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 06:49:05 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uMS0n-00000001hCF-1wNL;
	Tue, 03 Jun 2025 10:49:05 -0300
Date: Tue, 3 Jun 2025 10:49:05 -0300
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
Subject: Re: [PATCH 09/12] powerpc: Remove checks for devmap pages and
 PMDs/PUDs
Message-ID: <20250603134905.GJ386142@ziepe.ca>
References: <cover.541c2702181b7461b84f1a6967a3f0e823023fcc.1748500293.git-series.apopple@nvidia.com>
 <b837a9191e296e0b9f4e431979bab1f6616beab6.1748500293.git-series.apopple@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b837a9191e296e0b9f4e431979bab1f6616beab6.1748500293.git-series.apopple@nvidia.com>

On Thu, May 29, 2025 at 04:32:10PM +1000, Alistair Popple wrote:
> PFN_DEV no longer exists. This means no devmap PMDs or PUDs will be
> created, so checking for them is redundant. Instead mappings of pages that
> would have previously returned true for pXd_devmap() will return true for
> pXd_trans_huge()
> 
> Signed-off-by: Alistair Popple <apopple@nvidia.com>
> ---
>  arch/powerpc/mm/book3s64/hash_hugepage.c |  2 +-
>  arch/powerpc/mm/book3s64/hash_pgtable.c  |  3 +--
>  arch/powerpc/mm/book3s64/hugetlbpage.c   |  2 +-
>  arch/powerpc/mm/book3s64/pgtable.c       | 10 ++++------
>  arch/powerpc/mm/book3s64/radix_pgtable.c |  5 ++---
>  arch/powerpc/mm/pgtable.c                |  2 +-
>  6 files changed, 10 insertions(+), 14 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

