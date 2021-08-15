Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 859CD3EC9FE
	for <lists+linux-ext4@lfdr.de>; Sun, 15 Aug 2021 17:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238243AbhHOPjB (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 15 Aug 2021 11:39:01 -0400
Received: from verein.lst.de ([213.95.11.211]:51940 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229603AbhHOPi5 (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Sun, 15 Aug 2021 11:38:57 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 38F4867357; Sun, 15 Aug 2021 17:38:26 +0200 (CEST)
Date:   Sun, 15 Aug 2021 17:38:25 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Alex Sierra <alex.sierra@amd.com>
Cc:     akpm@linux-foundation.org, Felix.Kuehling@amd.com,
        linux-mm@kvack.org, rcampbell@nvidia.com,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        hch@lst.de, jgg@nvidia.com, jglisse@redhat.com
Subject: Re: [PATCH v6 05/13] drm/amdkfd: generic type as sys mem on
 migration to ram
Message-ID: <20210815153825.GB32384@lst.de>
References: <20210813063150.2938-1-alex.sierra@amd.com> <20210813063150.2938-6-alex.sierra@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210813063150.2938-6-alex.sierra@amd.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Aug 13, 2021 at 01:31:42AM -0500, Alex Sierra wrote:
>  	migrate.vma = vma;
>  	migrate.start = start;
>  	migrate.end = end;
> -	migrate.flags = MIGRATE_VMA_SELECT_DEVICE_PRIVATE;
>  	migrate.pgmap_owner = SVM_ADEV_PGMAP_OWNER(adev);
>  
> +	if (adev->gmc.xgmi.connected_to_cpu)
> +		migrate.flags = MIGRATE_VMA_SELECT_SYSTEM;
> +	else
> +		migrate.flags = MIGRATE_VMA_SELECT_DEVICE_PRIVATE;

It's been a while since I touched this migrate code, but doesn't this
mean that if the range already contains system memory the migration
now won't do anything? for the connected_to_cpu case?
