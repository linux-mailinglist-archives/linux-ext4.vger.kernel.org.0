Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCE6F3EE65F
	for <lists+linux-ext4@lfdr.de>; Tue, 17 Aug 2021 07:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234233AbhHQFtf (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 17 Aug 2021 01:49:35 -0400
Received: from verein.lst.de ([213.95.11.211]:57152 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233928AbhHQFtf (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 17 Aug 2021 01:49:35 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 140406736F; Tue, 17 Aug 2021 07:49:01 +0200 (CEST)
Date:   Tue, 17 Aug 2021 07:49:00 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     "Sierra Guiza, Alejandro (Alex)" <alex.sierra@amd.com>
Cc:     Christoph Hellwig <hch@lst.de>, akpm@linux-foundation.org,
        Felix.Kuehling@amd.com, linux-mm@kvack.org, rcampbell@nvidia.com,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        jgg@nvidia.com, jglisse@redhat.com
Subject: Re: [PATCH v6 05/13] drm/amdkfd: generic type as sys mem on
 migration to ram
Message-ID: <20210817054900.GB4895@lst.de>
References: <20210813063150.2938-1-alex.sierra@amd.com> <20210813063150.2938-6-alex.sierra@amd.com> <20210815153825.GB32384@lst.de> <694ea624-9dc7-7a25-78a6-308ee0debaea@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <694ea624-9dc7-7a25-78a6-308ee0debaea@amd.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Aug 16, 2021 at 02:53:18PM -0500, Sierra Guiza, Alejandro (Alex) wrote:
> For above’s condition equal to connected_to_cpu , we’re explicitly 
> migrating from
> device memory to system memory with device generic type. In this type, 
> device PTEs are
> present in CPU page table.
>
> During migrate_vma_collect_pmd walk op at migrate_vma_setup call, there’s 
> a condition
> for present pte that require migrate->flags be set for 
> MIGRATE_VMA_SELECT_SYSTEM.
> Otherwise, the migration for this entry will be ignored.

I think we might need a new SELECT flag here for IOMEM.
