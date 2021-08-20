Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A13D03F2644
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Aug 2021 07:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232531AbhHTFFq (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 20 Aug 2021 01:05:46 -0400
Received: from verein.lst.de ([213.95.11.211]:39719 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229457AbhHTFFq (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 20 Aug 2021 01:05:46 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id F19846736F; Fri, 20 Aug 2021 07:05:04 +0200 (CEST)
Date:   Fri, 20 Aug 2021 07:05:04 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Felix Kuehling <felix.kuehling@amd.com>
Cc:     Christoph Hellwig <hch@lst.de>, Alex Sierra <alex.sierra@amd.com>,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        rcampbell@nvidia.com, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, jgg@nvidia.com,
        jglisse@redhat.com, Roger Pau Monne <roger.pau@citrix.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: Re: [PATCH v6 08/13] mm: call pgmap->ops->page_free for
 DEVICE_GENERIC pages
Message-ID: <20210820050504.GB27083@lst.de>
References: <20210813063150.2938-1-alex.sierra@amd.com> <20210813063150.2938-9-alex.sierra@amd.com> <20210815154047.GC32384@lst.de> <7a55366f-bd65-7ab9-be9e-3bfd3aea3ea1@amd.com> <20210817055031.GC4895@lst.de> <e5eb53f9-c52a-52e1-5fa0-bb468c0c9c85@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e5eb53f9-c52a-52e1-5fa0-bb468c0c9c85@amd.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Aug 17, 2021 at 11:44:54AM -0400, Felix Kuehling wrote:
> >> That's a good catch. Existing drivers shouldn't need a page_free
> >> callback if they didn't have one before. That means we need to add a
> >> NULL-pointer check in free_device_page.
> > Also the other state clearing (__ClearPageWaiters/mem_cgroup_uncharge/
> > ->mapping = NULL).
> >
> > In many ways this seems like you want to bring back the DEVICE_PUBLIC
> > pgmap type that was removed a while ago due to the lack of users
> > instead of overloading the generic type.
> 
> I think so. I'm not clear about how DEVICE_PUBLIC differed from what
> DEVICE_GENERIC is today. As I understand it, DEVICE_PUBLIC was removed
> because it was unused and also known to be broken in some ways.
> DEVICE_GENERIC seemed close enough to what we need, other than not being
> supported in the migration helpers.
> 
> Would you see benefit in re-introducing DEVICE_PUBLIC as a distinct
> memory type from DEVICE_GENERIC? What would be the benefits of making
> that distinction?

The old DEVICE_PUBLIC mostly different in that it allowed the page
to be returned from vm_normal_page, which I think was horribly buggy.

But the point is not to bring back these old semantics.  The idea
is to be able to differeniate between your new coherent on-device
memory and the existing DEVICE_GENERIC.  That is call the
code in free_devmap_managed_page that is currently only used
for device private pages also for your new public device pages without
affecting the devdax and xen use cases.
