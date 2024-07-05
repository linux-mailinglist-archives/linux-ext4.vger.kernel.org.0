Return-Path: <linux-ext4+bounces-3107-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80463928AA7
	for <lists+linux-ext4@lfdr.de>; Fri,  5 Jul 2024 16:24:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E2CF283453
	for <lists+linux-ext4@lfdr.de>; Fri,  5 Jul 2024 14:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDF4F16B3B9;
	Fri,  5 Jul 2024 14:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GomyGT6q"
X-Original-To: linux-ext4@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6731B1514F1
	for <linux-ext4@vger.kernel.org>; Fri,  5 Jul 2024 14:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720189464; cv=none; b=NtF58lS+4LmeUAsZmNGUDs47YBKaSUKxce2VGrpcJ8mF4PqtrN7BvNJdFZA1dvNqzFYDMhh/vVNBp7ketcqH5+ft8libubjw5T0q8MFWu3MLFO4NNnWYPrgt0tjlMUxaBvEE5/4rlKENMq0upUITzDCNGQNef0tNynvhXnw+J0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720189464; c=relaxed/simple;
	bh=ezE9cMK85xGULq2NDfyultVM78ZkLbyifJxcFeIVVd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OtAoNNJLiX0gtUWMxC2z+HK9GnjriiDaWwCyIngUAu5lCqZDAhnO3IVfPo0jrzV+x5RVSBgIdIv+F3v8WmCTXbecOGYzt0eFox9hLw2/MwKRwMnlEmorez+T4a0cR33/o4icoL+ill9dr1GYySW1DFvCkZVMCdYDzQNqrq51psE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GomyGT6q; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720189460;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IqBTg61cVL77faXIzfdAxULAIPGMk1ZHXjVPHmfrZtE=;
	b=GomyGT6q4Dkoew0pCRUYAoml9aFCdZYOXIEQEjz64CtThBXoFF7Mra3soyxFZs7BYZGnr4
	vzGyfb+mUwBbgyhfR+bveNOh3TOMIFBnkRrYodstWMD/mhDtfkrnQteBVO2+kFcUWqNqxi
	S8ghGxK+13S2T1g7QDuve6Z+12fHe3M=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-88-CYD6EbHPORaJpgyuY-EoEQ-1; Fri, 05 Jul 2024 10:24:19 -0400
X-MC-Unique: CYD6EbHPORaJpgyuY-EoEQ-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-44671e02749so3653321cf.1
        for <linux-ext4@vger.kernel.org>; Fri, 05 Jul 2024 07:24:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720189458; x=1720794258;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IqBTg61cVL77faXIzfdAxULAIPGMk1ZHXjVPHmfrZtE=;
        b=oTbkIj9TKaTg+C5NhQwLAlQUxFDv0LkHTHj1NQoIHkg+4uiDjcTSgy/LJEHkS23SmN
         4DUM3fHuLfMnSZVbs8khdgx7STxaw0TpPxLxh3SfpjjmXl5nXDGhbxmEVqJQgU/EgYLO
         bN2sGtfvBXwE47X7rhfcgfgIbxvhGJpYRoMFbp87XSXBsYZhpghh4yUcB5R45eCN+wyV
         Sj+QTpjrzoeYvtSqJ4gzAk9hI3UoSnpRN8UhM6U6akNCDAu0c7Pbht3JHYeJOPveuIW8
         80ACObeGWoNz0a+CyPSKj9hPzPqZAty2D584ZqkBruLrJbU2e8dphEeWBGp78BjSAySn
         +rgw==
X-Forwarded-Encrypted: i=1; AJvYcCW6NCnDvBHA7YbJjjUNE4AM5pKa6HzmCzul4j2P5ntU/l5ZTvf5/qqrK4IJG59Hf8dvzhDO+kDMdlUo6255cwKZJSzcZklaMdVEiw==
X-Gm-Message-State: AOJu0Yz7tiBWxJnRmZPa15Z4chIcVSinYAbvVR86znsj5y4LHcKS8Jte
	HSRH/DArzFMCYYP7HJPp/3KYaXDQAJoBL/mDsPsrtnsjK9aLs6FMPLMVKfZBqeZJBDq7li+uYSU
	oxXbBpn/EMrMoTbZLRBTRasntX7o9uQq8MvhyGdVxYH8s0+7x0jo2oEJ2PmQ=
X-Received: by 2002:ac8:7c4b:0:b0:446:395a:37c9 with SMTP id d75a77b69052e-447cc1cd760mr50256901cf.4.1720189458370;
        Fri, 05 Jul 2024 07:24:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGKP4/uPX8iCeoUcNLMV3z8vBAByHvLymsXhgYIxVOYKgo8tVByPTMSYbiLBJ2KPlAF3hMSkQ==
X-Received: by 2002:ac8:7c4b:0:b0:446:395a:37c9 with SMTP id d75a77b69052e-447cc1cd760mr50256521cf.4.1720189457935;
        Fri, 05 Jul 2024 07:24:17 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4465149b579sm69523231cf.75.2024.07.05.07.24.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 07:24:17 -0700 (PDT)
Date: Fri, 5 Jul 2024 10:24:14 -0400
From: Peter Xu <peterx@redhat.com>
To: Alistair Popple <apopple@nvidia.com>
Cc: dan.j.williams@intel.com, vishal.l.verma@intel.com,
	dave.jiang@intel.com, logang@deltatee.com, bhelgaas@google.com,
	jack@suse.cz, jgg@ziepe.ca, catalin.marinas@arm.com,
	will@kernel.org, mpe@ellerman.id.au, npiggin@gmail.com,
	dave.hansen@linux.intel.com, ira.weiny@intel.com,
	willy@infradead.org, djwong@kernel.org, tytso@mit.edu,
	linmiaohe@huawei.com, david@redhat.com, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org, nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org, jhubbard@nvidia.com, hch@lst.de,
	david@fromorbit.com, Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH 11/13] huge_memory: Remove dead vmf_insert_pXd code
Message-ID: <ZogCDpfSyCcjVXWH@x1n>
References: <cover.66009f59a7fe77320d413011386c3ae5c2ee82eb.1719386613.git-series.apopple@nvidia.com>
 <400a4584f6f628998a7093aee49d9f86c592754b.1719386613.git-series.apopple@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <400a4584f6f628998a7093aee49d9f86c592754b.1719386613.git-series.apopple@nvidia.com>

Hi, Alistair,

On Thu, Jun 27, 2024 at 10:54:26AM +1000, Alistair Popple wrote:
> Now that DAX is managing page reference counts the same as normal
> pages there are no callers for vmf_insert_pXd functions so remove
> them.
> 
> Signed-off-by: Alistair Popple <apopple@nvidia.com>
> ---
>  include/linux/huge_mm.h |   2 +-
>  mm/huge_memory.c        | 165 +-----------------------------------------
>  2 files changed, 167 deletions(-)
> 
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index 9207d8e..0fb6bff 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -37,8 +37,6 @@ int change_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
>  		    pmd_t *pmd, unsigned long addr, pgprot_t newprot,
>  		    unsigned long cp_flags);
>  
> -vm_fault_t vmf_insert_pfn_pmd(struct vm_fault *vmf, pfn_t pfn, bool write);
> -vm_fault_t vmf_insert_pfn_pud(struct vm_fault *vmf, pfn_t pfn, bool write);
>  vm_fault_t dax_insert_pfn_pmd(struct vm_fault *vmf, pfn_t pfn, bool write);
>  vm_fault_t dax_insert_pfn_pud(struct vm_fault *vmf, pfn_t pfn, bool write);

There's a plan to support huge pfnmaps in VFIO, which may still make good
use of these functions.  I think it's fine to remove them but it may mean
we'll need to add them back when supporting pfnmaps with no memmap.

Is it still possible to make the old API generic to both service the new
dax refcount plan, but at the meantime working for pfn injections when
there's no page struct?

Thanks,

-- 
Peter Xu


