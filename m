Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0DCF3FEA83
	for <lists+linux-ext4@lfdr.de>; Thu,  2 Sep 2021 10:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244285AbhIBIT3 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 2 Sep 2021 04:19:29 -0400
Received: from verein.lst.de ([213.95.11.211]:50460 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233504AbhIBIT2 (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 2 Sep 2021 04:19:28 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1190E6736F; Thu,  2 Sep 2021 10:18:26 +0200 (CEST)
Date:   Thu, 2 Sep 2021 10:18:26 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Felix Kuehling <felix.kuehling@amd.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        "Sierra Guiza, Alejandro (Alex)" <alex.sierra@amd.com>,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        rcampbell@nvidia.com, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, jgg@nvidia.com,
        jglisse@redhat.com, Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v1 03/14] mm: add iomem vma selection for memory
 migration
Message-ID: <20210902081826.GA16283@lst.de>
References: <20210825034828.12927-1-alex.sierra@amd.com> <20210825034828.12927-4-alex.sierra@amd.com> <20210825074602.GA29620@lst.de> <c4241eb3-07d2-c85b-0f48-cce4b8369381@amd.com> <a9eb2c4a-d8cc-9553-57b7-fd1622679aaa@amd.com> <20210830082800.GA6836@lst.de> <e40b3b79-f548-b87b-7a85-f654f25ed8dd@amd.com> <20210901082925.GA21961@lst.de> <11d64457-9d61-f82d-6c98-d68762dce85d@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11d64457-9d61-f82d-6c98-d68762dce85d@amd.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Sep 01, 2021 at 11:40:43AM -0400, Felix Kuehling wrote:
> >>> It looks like I'm totally misunderstanding what you are adding here
> >>> then.  Why do we need any special treatment at all for memory that
> >>> has normal struct pages and is part of the direct kernel map?
> >> The pages are like normal memory for purposes of mapping them in CPU
> >> page tables and for coherent access from the CPU.
> > That's the user page tables.  What about the kernel direct map?
> > If there is a normal kernel struct page backing there really should
> > be no need for the pgmap.
> 
> I'm not sure. The physical address ranges are in the UEFI system address
> map as special-purpose memory. Does Linux create the struct pages and
> kernel direct map for that without a pgmap call? I didn't see that last
> time I went digging through that code.

So doing some googling finds a patch from Dan that claims to hand EFI
special purpose memory to the device dax driver.  But when I try to
follow the version that got merged it looks it is treated simply as an
MMIO region to be claimed by drivers, which would not get a struct page.

Dan, did I misunderstand how E820_TYPE_SOFT_RESERVED works?

> >> From an application
> >> perspective, we want file-backed and anonymous mappings to be able to
> >> use DEVICE_PUBLIC pages with coherent CPU access. The goal is to
> >> optimize performance for GPU heavy workloads while minimizing the need
> >> to migrate data back-and-forth between system memory and device memory.
> > I don't really understand that part.  file backed pages are always
> > allocated by the file system using the pagecache helpers, that is
> > using the page allocator.  Anonymouns memory also always comes from
> > the page allocator.
> 
> I'm coming at this from my experience with DEVICE_PRIVATE. Both
> anonymous and file-backed pages should be migrateable to DEVICE_PRIVATE
> memory by the migrate_vma_* helpers for more efficient access by our
> GPU. (*) It's part of the basic premise of HMM as I understand it. I
> would expect the same thing to work for DEVICE_PUBLIC memory.

Ok, so you want to migrate to and from them.  Not use DEVICE_PUBLIC
for the actual page cache pages.  That maks a lot more sense.

> I see DEVICE_PUBLIC as an improved version of DEVICE_PRIVATE that allows
> the CPU to map the device memory coherently to minimize the need for
> migrations when CPU and GPU access the same memory concurrently or
> alternatingly. But we're not going as far as putting that memory
> entirely under the management of the Linux memory manager and VM
> subsystem. Our (and HPE's) system architects decided that this memory is
> not suitable to be used like regular NUMA system memory by the Linux
> memory manager.

So yes.  It is a Memory Mapped I/O region, which unlike the PCIe BARs
that people typically deal with is fully cache coherent.  I think this
does make more sense as a description.

But to go back to what start this discussion:  If these are memory
mapped I/O pfn_valid should generally not return true for them.

And as you already pointed out in reply to Alex we need to tighten the
selection criteria one way or another.
