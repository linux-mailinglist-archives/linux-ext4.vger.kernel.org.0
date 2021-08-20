Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FBF23F2611
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Aug 2021 06:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231148AbhHTEky (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 20 Aug 2021 00:40:54 -0400
Received: from verein.lst.de ([213.95.11.211]:39680 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229457AbhHTEkx (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 20 Aug 2021 00:40:53 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 377B36736F; Fri, 20 Aug 2021 06:40:13 +0200 (CEST)
Date:   Fri, 20 Aug 2021 06:40:12 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Felix Kuehling <felix.kuehling@amd.com>
Cc:     "Sierra Guiza, Alejandro (Alex)" <alex.sierra@amd.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, hch@lst.de, jgg@nvidia.com,
        jglisse@redhat.com
Subject: Re: [PATCH v6 02/13] mm: remove extra ZONE_DEVICE struct page
 refcount
Message-ID: <20210820044012.GA26960@lst.de>
References: <20210813063150.2938-1-alex.sierra@amd.com> <20210813063150.2938-3-alex.sierra@amd.com> <7b821150-af18-f786-e419-ec245b8cfb1e@nvidia.com> <393e9815-838d-5fe6-d6ab-bfe7b543fef6@amd.com> <e155ed59-8c3c-4046-e731-f082ee4b10bb@nvidia.com> <600a4c43-271d-df98-d3e0-301af0e8d0fe@amd.com> <40d4a39e-e874-4ba3-e9bc-42015f0383fa@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40d4a39e-e874-4ba3-e9bc-42015f0383fa@amd.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Aug 19, 2021 at 03:59:56PM -0400, Felix Kuehling wrote:
> I got lost trying to understand how DAX counts page references and how
> the PTE_SPECIAL option affects that. Theodore, can you help with this?
> Is there an easy way to test without CONFIG_ARCH_HAS_PTE_SPECIAL on x86,
> or do we need to test on a CPU architecture that doesn't support this
> feature?

I think the right answer is to simplify disallow ZONE_DEVICE pages
if ARCH_HAS_PTE_SPECIAL is not supported.  ARCH_HAS_PTE_SPECIAL is
supported by all modern architecture ports than can make use of
ZONE_DEVICE / dev_pagemap, so we can avoid this pocket of barely
testable code entirely:


diff --git a/mm/Kconfig b/mm/Kconfig
index 40a9bfcd5062e1..2823bbfd1c8c70 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -775,6 +775,7 @@ config ZONE_DMA32
 
 config ZONE_DEVICE
 	bool "Device memory (pmem, HMM, etc...) hotplug support"
+	depends on ARCH_HAS_PTE_SPECIAL
 	depends on MEMORY_HOTPLUG
 	depends on MEMORY_HOTREMOVE
 	depends on SPARSEMEM_VMEMMAP
