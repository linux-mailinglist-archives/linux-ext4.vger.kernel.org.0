Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AF063FD567
	for <lists+linux-ext4@lfdr.de>; Wed,  1 Sep 2021 10:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243078AbhIAIaZ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 1 Sep 2021 04:30:25 -0400
Received: from verein.lst.de ([213.95.11.211]:46728 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242943AbhIAIaY (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 1 Sep 2021 04:30:24 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 711DE68AFE; Wed,  1 Sep 2021 10:29:25 +0200 (CEST)
Date:   Wed, 1 Sep 2021 10:29:25 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Felix Kuehling <felix.kuehling@amd.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        "Sierra Guiza, Alejandro (Alex)" <alex.sierra@amd.com>,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        rcampbell@nvidia.com, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, jgg@nvidia.com, jglisse@redhat.com
Subject: Re: [PATCH v1 03/14] mm: add iomem vma selection for memory
 migration
Message-ID: <20210901082925.GA21961@lst.de>
References: <20210825034828.12927-1-alex.sierra@amd.com> <20210825034828.12927-4-alex.sierra@amd.com> <20210825074602.GA29620@lst.de> <c4241eb3-07d2-c85b-0f48-cce4b8369381@amd.com> <a9eb2c4a-d8cc-9553-57b7-fd1622679aaa@amd.com> <20210830082800.GA6836@lst.de> <e40b3b79-f548-b87b-7a85-f654f25ed8dd@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e40b3b79-f548-b87b-7a85-f654f25ed8dd@amd.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Aug 30, 2021 at 01:04:43PM -0400, Felix Kuehling wrote:
> >> driver code is not really involved in updating the CPU mappings. Maybe
> >> it's something we need to do in the migration helpers.
> > It looks like I'm totally misunderstanding what you are adding here
> > then.  Why do we need any special treatment at all for memory that
> > has normal struct pages and is part of the direct kernel map?
> 
> The pages are like normal memory for purposes of mapping them in CPU
> page tables and for coherent access from the CPU.

That's the user page tables.  What about the kernel direct map?
If there is a normal kernel struct page backing there really should
be no need for the pgmap.

> From an application
> perspective, we want file-backed and anonymous mappings to be able to
> use DEVICE_PUBLIC pages with coherent CPU access. The goal is to
> optimize performance for GPU heavy workloads while minimizing the need
> to migrate data back-and-forth between system memory and device memory.

I don't really understand that part.  file backed pages are always
allocated by the file system using the pagecache helpers, that is
using the page allocator.  Anonymouns memory also always comes from
the page allocator.

> The pages are special in two ways:
> 
>  1. The memory is managed not by the Linux buddy allocator, but by the
>     GPU driver's TTM memory manager

Why?

>  2. We want to migrate data in response to GPU page faults and
>     application hints using the migrate_vma helpers

Why? 
