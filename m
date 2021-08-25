Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75F293F708E
	for <lists+linux-ext4@lfdr.de>; Wed, 25 Aug 2021 09:40:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238702AbhHYHlT (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 25 Aug 2021 03:41:19 -0400
Received: from verein.lst.de ([213.95.11.211]:55132 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231687AbhHYHlS (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 25 Aug 2021 03:41:18 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2F4E067357; Wed, 25 Aug 2021 09:40:30 +0200 (CEST)
Date:   Wed, 25 Aug 2021 09:40:29 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Alex Sierra <alex.sierra@amd.com>
Cc:     akpm@linux-foundation.org, Felix.Kuehling@amd.com,
        linux-mm@kvack.org, rcampbell@nvidia.com,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        hch@lst.de, jgg@nvidia.com, jglisse@redhat.com
Subject: Re: [PATCH v1 03/14] mm: add iomem vma selection for memory
 migration
Message-ID: <20210825074029.GC29433@lst.de>
References: <20210825034828.12927-1-alex.sierra@amd.com> <20210825034828.12927-4-alex.sierra@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210825034828.12927-4-alex.sierra@amd.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Aug 24, 2021 at 10:48:17PM -0500, Alex Sierra wrote:
> In this case, this is used to migrate pages from device memory, back to
> system memory. This particular device memory type should be accessible
> by the CPU, through IOMEM access. Typically, zone device public type
> memory falls into this category.
> 
> Signed-off-by: Alex Sierra <alex.sierra@amd.com>
> ---
>  include/linux/migrate.h | 1 +
>  mm/migrate.c            | 3 ++-
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/migrate.h b/include/linux/migrate.h
> index 4bb4e519e3f5..6b16f417384f 100644
> --- a/include/linux/migrate.h
> +++ b/include/linux/migrate.h
> @@ -156,6 +156,7 @@ static inline unsigned long migrate_pfn(unsigned long pfn)
>  enum migrate_vma_direction {
>  	MIGRATE_VMA_SELECT_SYSTEM = 1 << 0,
>  	MIGRATE_VMA_SELECT_DEVICE_PRIVATE = 1 << 1,
> +	MIGRATE_VMA_SELECT_IOMEM = 1 << 2,
>  };
>  
>  struct migrate_vma {
> diff --git a/mm/migrate.c b/mm/migrate.c
> index e3a10e2a1bb3..d4ae2da99607 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -2406,7 +2406,8 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
>  			if (is_write_device_private_entry(entry))
>  				mpfn |= MIGRATE_PFN_WRITE;
>  		} else {
> -			if (!(migrate->flags & MIGRATE_VMA_SELECT_SYSTEM))
> +			if (!(migrate->flags & MIGRATE_VMA_SELECT_SYSTEM) &&
> +			    !(migrate->flags & MIGRATE_VMA_SELECT_IOMEM))

This makes the MIGRATE_VMA_SELECT_SYSTEM and MIGRATE_VMA_SELECT_IOMEM
behave entirely identifical, that is redundant.  I think we need to
distinguish between the dfferent cases here.  I think the right check
would be pfn_valid(), which should be true for system memory, and
false for iomem.

Also shouldn't this be called DEVICE_PUBLIC instead of IOMEM?
