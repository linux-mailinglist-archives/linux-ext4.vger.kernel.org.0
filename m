Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 287DC3F70A1
	for <lists+linux-ext4@lfdr.de>; Wed, 25 Aug 2021 09:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238651AbhHYHqv (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 25 Aug 2021 03:46:51 -0400
Received: from verein.lst.de ([213.95.11.211]:55145 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231687AbhHYHqu (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 25 Aug 2021 03:46:50 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id C709967357; Wed, 25 Aug 2021 09:46:02 +0200 (CEST)
Date:   Wed, 25 Aug 2021 09:46:02 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Alex Sierra <alex.sierra@amd.com>
Cc:     akpm@linux-foundation.org, Felix.Kuehling@amd.com,
        linux-mm@kvack.org, rcampbell@nvidia.com,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        hch@lst.de, jgg@nvidia.com, jglisse@redhat.com
Subject: Re: [PATCH v1 03/14] mm: add iomem vma selection for memory
 migration
Message-ID: <20210825074602.GA29620@lst.de>
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
>  		} else {
> -			if (!(migrate->flags & MIGRATE_VMA_SELECT_SYSTEM))
> +			if (!(migrate->flags & MIGRATE_VMA_SELECT_SYSTEM) &&
> +			    !(migrate->flags & MIGRATE_VMA_SELECT_IOMEM))
>  				goto next;
>  			pfn = pte_pfn(pte);
>  			if (is_zero_pfn(pfn)) {

.. also how is this going to work for the device public memory?  That
should be pte_special() an thus fail vm_normal_page.
