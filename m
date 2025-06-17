Return-Path: <linux-ext4+bounces-8472-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3856ADC6A5
	for <lists+linux-ext4@lfdr.de>; Tue, 17 Jun 2025 11:36:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79377188FA16
	for <lists+linux-ext4@lfdr.de>; Tue, 17 Jun 2025 09:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12C532951A0;
	Tue, 17 Jun 2025 09:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D/zDTGDP"
X-Original-To: linux-ext4@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2293A229B28
	for <linux-ext4@vger.kernel.org>; Tue, 17 Jun 2025 09:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750152923; cv=none; b=Rz/2OqIrxFhAzk7HSLtYUO4oZRIQ84SjMHPFiq3dMIY+nQfJJ9s+JIY63u+M80DvjAwyuvvaWkgE5BrpGj6TdE7s0aqRQbtmMrmWysxv+BLxRBpi4OmQP3ZX6LydbS/gWe6iSuJZrCUHdf0PyORvIVBBQFzpzvCx67mqRslj1hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750152923; c=relaxed/simple;
	bh=orOmsWmK7arl5guU70AdaHCHCOleWhKkPZuEjky9V7Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SYN/oDszctSRJGic457hZX0OpEdKacPLQL1AHKtzYs5juwNFJP+esUKra2+bxS7JcjMx3IytUI71XhXR5HwtZ2dMcG2bg+SBFuoY8nYUQwod2XOLgjwe1pGN8vqq0ClyrGqd/xHeRHYj7/UDhB4Q6lV6JBMWlbiJqY7Yikg05sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D/zDTGDP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750152921;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=sxNGLVvBoDB549OTJwTVX80yqxzNkqnyUmP8nOzpMNA=;
	b=D/zDTGDPSFDLYnYiB6MjqVuiov28xW39P/Grr03Hhy952o9XfQibTfCKCzfv0TcmLN/ZDi
	Ghuq7B8hsmNVn7DQhTddtnUbHpuKYuqnvlzhWTowKZiGa+mcXntjwYCaA90C4ON9n6dWoP
	ka/nBn1neCXgllSsmANXOEubMGpqazQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-C48sSrAgPTSDU8uFNRC5Og-1; Tue, 17 Jun 2025 05:35:18 -0400
X-MC-Unique: C48sSrAgPTSDU8uFNRC5Og-1
X-Mimecast-MFC-AGG-ID: C48sSrAgPTSDU8uFNRC5Og_1750152917
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-450de98b28eso32699785e9.0
        for <linux-ext4@vger.kernel.org>; Tue, 17 Jun 2025 02:35:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750152917; x=1750757717;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sxNGLVvBoDB549OTJwTVX80yqxzNkqnyUmP8nOzpMNA=;
        b=cXB1cWgYvrPyuoqq6dotZTzidh4lV2lX7llydZzLpJjGoVU1dNM2i3btMkLJq/C+2q
         W3M47VvDhOgWGinILiIhCNC2Yz+qYN6+XlH9H6PlE0j9q4O1GdeP375iYR+/M2KjZTIT
         o+pfaNVQtI8gWJTXmAYVqhmYuejXeGIQ2Wdf2Cm1FOY55jm85pacmw7IT1w4167ZJfFX
         5OX3siectvTis0oH77384bc6zYrgIgrB92/hZ6mBBRNtCF2Axky6xR9ZbQxXzu0q1CMh
         ZTedendUX/sMv+MqpTl8n1Ol7VkmLV6L2VA7j84ZeXPO24roHGlJVsvjLgiCI6C/8bAm
         DP5A==
X-Forwarded-Encrypted: i=1; AJvYcCVTrPp1BvMAMAVjxfE/JqjpJgrwK32i5/dxhtOijVYjAHKiqtvmvIInD+bjgMIOtqVszadXWZ+MU1VC@vger.kernel.org
X-Gm-Message-State: AOJu0YzYUPalrCi9J+nNEWyO6Aq1bWBWGSuzRbrqcH1JkPhpV7tQzCYQ
	fX10NWtoUZeSuRZQBGVG1NgcTiZGJvBW0Nxf/p7YE1AU2VSP2F0tiJ4uFKPHVAq0R0hzqbF426r
	lu+76l4rPrLSChqdX2m6NKJ2cn42LRX3DMygQ6Hqe4sklkbXAFoqFBtjM6n4pWFw=
X-Gm-Gg: ASbGncuWq/0U/mi2LMqStKOxVyPY00YDi7jXGaNxyqJ0GtzJzGnIIz6itvCzCtZpIg7
	uf7a/lIjzuoInpmxAHSdndKcdwCtfzcJGJC3XtYA3GhyiSVGKq+CTZKzMSuEKaWjElXDQVNoabN
	oxXkzuk8goGlEi1x6GAtQu3H+KPc0o/XFG/1WJonpq6Z/qUxBvZFCwWwgpanlRvNVXsXREj9mV6
	Y7eKp5wbe2eCpgPAK+Nq69L1jFtAh2jmBDTM1PKwfKrj0JcgNpLyMc5UdaeVdiDI+8AQs+NJAMk
	e5cZalsGgOLudGnzoCX9LyETQoExiw2hnCN9VaaDS4HUA9qeQ7GXcQfvXHlMBYkRyzLqPc6kiD6
	MT7Ssj70nF4wchvPlis/WRU8WexovEQfNhVReknwyJ9209ck=
X-Received: by 2002:a05:600c:64c8:b0:442:d9fb:d9a5 with SMTP id 5b1f17b1804b1-4533c92e02dmr116196965e9.9.1750152917439;
        Tue, 17 Jun 2025 02:35:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEit+yPVLJbHP2/NKoMhgu9bHwQKBDL8e7RYDOzVbEtAUjPvQmNHH9hZ4psmoetdsF5NGVCyg==
X-Received: by 2002:a05:600c:64c8:b0:442:d9fb:d9a5 with SMTP id 5b1f17b1804b1-4533c92e02dmr116195515e9.9.1750152915523;
        Tue, 17 Jun 2025 02:35:15 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f31:700:3851:c66a:b6b9:3490? (p200300d82f3107003851c66ab6b93490.dip0.t-ipconnect.de. [2003:d8:2f31:700:3851:c66a:b6b9:3490])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a57b15015fsm7801901f8f.95.2025.06.17.02.35.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jun 2025 02:35:15 -0700 (PDT)
Message-ID: <69bea6b9-e9e7-4d17-843c-001029d4f2c2@redhat.com>
Date: Tue, 17 Jun 2025 11:35:13 +0200
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/14] mm: Remove callers of pfn_t functionality
To: Alistair Popple <apopple@nvidia.com>, akpm@linux-foundation.org
Cc: linux-mm@kvack.org, gerald.schaefer@linux.ibm.com,
 dan.j.williams@intel.com, jgg@ziepe.ca, willy@infradead.org,
 linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-xfs@vger.kernel.org, jhubbard@nvidia.com, hch@lst.de,
 zhang.lyra@gmail.com, debug@rivosinc.com, bjorn@kernel.org,
 balbirs@nvidia.com, lorenzo.stoakes@oracle.com,
 linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-cxl@vger.kernel.org, dri-devel@lists.freedesktop.org, John@Groves.net,
 m.szyprowski@samsung.com, Jason Gunthorpe <jgg@nvidia.com>
References: <cover.8d04615eb17b9e46fc0ae7402ca54b69e04b1043.1750075065.git-series.apopple@nvidia.com>
 <657be8fef1f0d15c377ad3c420d77ca4db918013.1750075065.git-series.apopple@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <657be8fef1f0d15c377ad3c420d77ca4db918013.1750075065.git-series.apopple@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16.06.25 13:58, Alistair Popple wrote:
> All PFN_* pfn_t flags have been removed. Therefore there is no longer
> a need for the pfn_t type and all uses can be replaced with normal
> pfns.
> 
> Signed-off-by: Alistair Popple <apopple@nvidia.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> 
> ---
> 
> Changes since v1:
> 
>   - Rebased on David's cleanup[1]
> 
> [1] https://lore.kernel.org/linux-mm/20250611120654.545963-1-david@redhat.com/
> ---
>   arch/x86/mm/pat/memtype.c                |  1 +-
>   drivers/dax/device.c                     | 23 +++----
>   drivers/dax/hmem/hmem.c                  |  1 +-
>   drivers/dax/kmem.c                       |  1 +-
>   drivers/dax/pmem.c                       |  1 +-
>   drivers/dax/super.c                      |  3 +-
>   drivers/gpu/drm/exynos/exynos_drm_gem.c  |  1 +-
>   drivers/gpu/drm/gma500/fbdev.c           |  3 +-
>   drivers/gpu/drm/i915/gem/i915_gem_mman.c |  1 +-
>   drivers/gpu/drm/msm/msm_gem.c            |  1 +-
>   drivers/gpu/drm/omapdrm/omap_gem.c       |  6 +--
>   drivers/gpu/drm/v3d/v3d_bo.c             |  1 +-
>   drivers/hwtracing/intel_th/msu.c         |  3 +-
>   drivers/md/dm-linear.c                   |  2 +-
>   drivers/md/dm-log-writes.c               |  2 +-
>   drivers/md/dm-stripe.c                   |  2 +-
>   drivers/md/dm-target.c                   |  2 +-
>   drivers/md/dm-writecache.c               | 11 +--
>   drivers/md/dm.c                          |  2 +-
>   drivers/nvdimm/pmem.c                    |  8 +--
>   drivers/nvdimm/pmem.h                    |  4 +-
>   drivers/s390/block/dcssblk.c             |  9 +--
>   drivers/vfio/pci/vfio_pci_core.c         |  5 +-
>   fs/cramfs/inode.c                        |  5 +-
>   fs/dax.c                                 | 50 +++++++--------
>   fs/ext4/file.c                           |  2 +-
>   fs/fuse/dax.c                            |  3 +-
>   fs/fuse/virtio_fs.c                      |  5 +-
>   fs/xfs/xfs_file.c                        |  2 +-
>   include/linux/dax.h                      |  9 +--
>   include/linux/device-mapper.h            |  2 +-
>   include/linux/huge_mm.h                  |  6 +-
>   include/linux/mm.h                       |  4 +-
>   include/linux/pfn.h                      |  9 +---
>   include/linux/pfn_t.h                    | 85 +-------------------------
>   mm/debug_vm_pgtable.c                    |  1 +-
>   mm/huge_memory.c                         | 21 +++---
>   mm/memory.c                              | 31 ++++-----
>   mm/memremap.c                            |  1 +-
>   mm/migrate.c                             |  1 +-
>   tools/testing/nvdimm/pmem-dax.c          |  6 +-
>   tools/testing/nvdimm/test/iomap.c        |  7 +--
>   tools/testing/nvdimm/test/nfit_test.h    |  1 +-
>   43 files changed, 109 insertions(+), 235 deletions(-)
>   delete mode 100644 include/linux/pfn_t.h
> 

Lovely

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


