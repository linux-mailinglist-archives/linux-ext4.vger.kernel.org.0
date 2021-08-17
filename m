Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 990F53EE65B
	for <lists+linux-ext4@lfdr.de>; Tue, 17 Aug 2021 07:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234163AbhHQFsX (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 17 Aug 2021 01:48:23 -0400
Received: from verein.lst.de ([213.95.11.211]:57146 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233928AbhHQFsX (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 17 Aug 2021 01:48:23 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id C7A586736F; Tue, 17 Aug 2021 07:47:47 +0200 (CEST)
Date:   Tue, 17 Aug 2021 07:47:47 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Felix Kuehling <felix.kuehling@amd.com>
Cc:     Christoph Hellwig <hch@lst.de>, Alex Sierra <alex.sierra@amd.com>,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        rcampbell@nvidia.com, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, jgg@nvidia.com, jglisse@redhat.com
Subject: Re: [PATCH v6 04/13] drm/amdkfd: add SPM support for SVM
Message-ID: <20210817054747.GA4895@lst.de>
References: <20210813063150.2938-1-alex.sierra@amd.com> <20210813063150.2938-5-alex.sierra@amd.com> <20210815091000.GB25067@lst.de> <0ecf3253-5c77-e982-981a-b340ff705838@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ecf3253-5c77-e982-981a-b340ff705838@amd.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Aug 16, 2021 at 02:54:30PM -0400, Felix Kuehling wrote:
> I think you're right. We only need the start and end address from
> lookup_resource and we already know that anyway. It means we can drop
> patch 3 from the series.
> 
> Just to be sure, we'll confirm that the end address determined by our
> driver matches the one from lookup_resource (coming from the system
> address map in the system BIOS). If there were a mismatch, it would
> probably be a bug (in the driver or the BIOS) that we'd need to fix anyway.

Or rather that the driver claimed area is smaller or the same as the
bios range.  No harm (except for potential peformance implications) when
you don't use all of it.

> I don't really see the "mess" you're talking about. Including the above,
> there are only 3 conditional statements in that function that are not
> error-handling related:
> 
>         /* Page migration works on Vega10 or newer */
>         if (kfddev->device_info->asic_family < CHIP_VEGA10)
>                 return -EINVAL;
> ...
>         if (xgmi_connected_to_cpu)
>                 res = lookup_resource(&iomem_resource, adev->gmc.aper_base);
>         else
>                 res = devm_request_free_mem_region(adev->dev, &iomem_resource, size);
> ...
>         pgmap->type = xgmi_connected_to_cpu ?
>                                 MEMORY_DEVICE_GENERIC : MEMORY_DEVICE_PRIVATE;
> 

Plus the devm_release_mem_region error handling that is currently missing.
