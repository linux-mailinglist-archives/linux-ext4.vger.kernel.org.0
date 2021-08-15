Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0FEE3EC83E
	for <lists+linux-ext4@lfdr.de>; Sun, 15 Aug 2021 11:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236843AbhHOJKe (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 15 Aug 2021 05:10:34 -0400
Received: from verein.lst.de ([213.95.11.211]:51390 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231194AbhHOJKe (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Sun, 15 Aug 2021 05:10:34 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9DEF66736F; Sun, 15 Aug 2021 11:10:00 +0200 (CEST)
Date:   Sun, 15 Aug 2021 11:10:00 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Alex Sierra <alex.sierra@amd.com>
Cc:     akpm@linux-foundation.org, Felix.Kuehling@amd.com,
        linux-mm@kvack.org, rcampbell@nvidia.com,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        hch@lst.de, jgg@nvidia.com, jglisse@redhat.com
Subject: Re: [PATCH v6 04/13] drm/amdkfd: add SPM support for SVM
Message-ID: <20210815091000.GB25067@lst.de>
References: <20210813063150.2938-1-alex.sierra@amd.com> <20210813063150.2938-5-alex.sierra@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210813063150.2938-5-alex.sierra@amd.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

> @@ -880,17 +881,22 @@ int svm_migrate_init(struct amdgpu_device *adev)
>  	 * should remove reserved size
>  	 */
>  	size = ALIGN(adev->gmc.real_vram_size, 2ULL << 20);
> -	res = devm_request_free_mem_region(adev->dev, &iomem_resource, size);
> +	if (xgmi_connected_to_cpu)
> +		res = lookup_resource(&iomem_resource, adev->gmc.aper_base);
> +	else
> +		res = devm_request_free_mem_region(adev->dev, &iomem_resource, size);
> +

Can you explain what the point of the lookup_resource is here? res->start
is obviously identical to the start value you pass in.  So this is used
as a way to query the length, but I'm pretty sure the driver must
already know that as it inserted the resource itself, right?

On a slightly higher level comment svm_migrate_init is a bit of a mess
with all the if/else already, and with the above addressed will become
a bit more.  I think splitting it into a device private and device
generic case would probably help people finding it to understand the code
much better later on.  Even more so with a useful comment.
