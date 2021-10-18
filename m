Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 048674327C8
	for <lists+linux-ext4@lfdr.de>; Mon, 18 Oct 2021 21:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232164AbhJRTjt (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 18 Oct 2021 15:39:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231542AbhJRTjt (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 18 Oct 2021 15:39:49 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB20AC06161C
        for <linux-ext4@vger.kernel.org>; Mon, 18 Oct 2021 12:37:37 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id pf6-20020a17090b1d8600b0019fa884ab85so198038pjb.5
        for <linux-ext4@vger.kernel.org>; Mon, 18 Oct 2021 12:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vcN/e9Q2mjWOnFTpFF8+nbpf301tV4lfvmN50Si5mpg=;
        b=38g+XN93W/PLq/Nexn/X8vXGCmM4WtMbeRf9TKHl4Ppsj4GJHBOwMyjyiCz98QBSLr
         o31EN+SyDgOHPAfxftOZxpOxuH0eJaSjfGbKMGZSg9P2ELIaE0VAakmTFBcqJ+aetP6t
         NjAiB5KnHHgXuv6B57ayt4SuV/hQ/UXGrFbevmi9ZnJherSgr4WK/Qe4Yd55rhHZKiQO
         I89WlzsDwvI5meoe80VV7ajAudpXN7A0WxmgFQuh+6HYUuoyP/0TkzoVGDMYzbivgVRG
         y7wjDezrYRE8vnELGW9ksbJQTPsu0kV9r79I12T5ISHLVcQDeo8mAqDDeoyMt+Lcuk3F
         MZJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vcN/e9Q2mjWOnFTpFF8+nbpf301tV4lfvmN50Si5mpg=;
        b=k2hO/Q4yoCgJ+PTze39c+cGv31vEYcS57TDbMDTztXJxiiQwWsqODFUzEHCXuo+prc
         uWCMk4AUjJPTgGsNI56/JPBDyaruu0HHU0jgyQvQd3Ul3KvYn5SrHUgV7BMASYGLPr4p
         xKfhX0mVXQ5KWplvX0lgSH4tHrkQm6XRd+TiJ5wZF0ou+XeEBEyZD9U/BDwiUxKA1h6I
         VK6hWfZYj5ZIew3MHloNt+xDMIbFhL5QpJv6m3mmParO6ufRj+gntN1djlLHQMt/JGl2
         011ZsaV2bx13E2tB0TiaDk9Og0qmDHl4TU58PPTZFkhiSywnXB/KKFcJVrQKpX68v16Q
         Bx4Q==
X-Gm-Message-State: AOAM531a5l7jyUbu5OjQKqV+xTt4trs4N4v35Evubx2ThwLilUKDdxQ2
        xe8jPwtovuLtikknViCvT7J4Hdzdg6HfWjjF13cf3w==
X-Google-Smtp-Source: ABdhPJyFE9yWji3O4oSu/RuiAk4z6lxIzSSSytSMy4gnkcyUbGH1NVDJSqyiMSVcJ4yyecBDh5dF2zDhb6bddsIkbHE=
X-Received: by 2002:a17:90b:350f:: with SMTP id ls15mr1002201pjb.220.1634585857145;
 Mon, 18 Oct 2021 12:37:37 -0700 (PDT)
MIME-Version: 1.0
References: <20211014153928.16805-1-alex.sierra@amd.com> <20211014153928.16805-3-alex.sierra@amd.com>
 <20211014170634.GV2744544@nvidia.com> <YWh6PL7nvh4DqXCI@casper.infradead.org>
 <CAPcyv4hBdSwdtG6Hnx9mDsRXiPMyhNH=4hDuv8JZ+U+Jj4RUWg@mail.gmail.com>
 <20211014230606.GZ2744544@nvidia.com> <CAPcyv4hC4qxbO46hp=XBpDaVbeh=qdY6TgvacXRprQ55Qwe-Dg@mail.gmail.com>
 <20211016154450.GJ2744544@nvidia.com> <CAPcyv4j0kHREAOG6_07E2foz6e4FP8D72mZXH6ivsiUBu_8c6g@mail.gmail.com>
 <20211018182559.GC3686969@ziepe.ca>
In-Reply-To: <20211018182559.GC3686969@ziepe.ca>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 18 Oct 2021 12:37:30 -0700
Message-ID: <CAPcyv4jvZjeMcKLVuOEQ_gXRd87i3NUX5D=MmsJ++rWafnK-NQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] mm: remove extra ZONE_DEVICE struct page refcount
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Alex Sierra <alex.sierra@amd.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kuehling, Felix" <Felix.Kuehling@amd.com>,
        Linux MM <linux-mm@kvack.org>,
        Ralph Campbell <rcampbell@nvidia.com>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, Christoph Hellwig <hch@lst.de>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Alistair Popple <apopple@nvidia.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        David Hildenbrand <david@redhat.com>,
        Joao Martins <joao.m.martins@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Oct 18, 2021 at 11:26 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Sun, Oct 17, 2021 at 11:35:35AM -0700, Dan Williams wrote:
>
> > > DAX is stuffing arrays of 4k pages into the PUD/PMDs. Aligning with
> > > THP would make using normal refconting much simpler. I looked at
> > > teaching the mm core to deal with page arrays - it is certainly
> > > doable, but it is quite inefficient and ugly mm code.
> >
> > THP does not support PUD, and neither does FSDAX, so it's only PMDs we
> > need to worry about.
>
> device-dax uses PUD, along with TTM, they are the only places. I'm not
> sure TTM is a real place though.

I was setting device-dax aside because it can use Joao's changes to
get compound-page support.

>
> > > So, can we fix DAX and TTM - the only uses of PUD/PMDs I could find?
> > >
> > > Joao has a series that does this to device-dax:
> > >
> > > https://lore.kernel.org/all/20210827145819.16471-1-joao.m.martins@oracle.com/
> >
> > That assumes there's never any need to fracture a huge page which
> > FSDAX could not support unless the filesystem was built with 2MB block
> > size.
>
> As I understand things, something like FSDAX post-folio should
> generate maximal compound pages for extents in the page cache that are
> physically contiguous.
>
> A high order folio can be placed in any lower order in the page
> tables, so we never have to fracture it, unless the underlying page
> are moved around - which requires an unmap_mapping_range() cycle..

That would be useful to disconnect the compound-page size from the
page-table-entry installed for the page. However, don't we need
typical compound page fracturing in the near term until folios move
ahead?

>
> > > Assuming changing FSDAX is hard.. How would DAX people feel about just
> > > deleting the PUD/PMD support until it can be done with compound pages?
> >
> > There are end users that would notice the PMD regression, and I think
> > FSDAX PMDs with proper compound page metadata is on the same order of
> > work as fixing the refcount.
>
> Hmm, I don't know.. I sketched out the refcount stuff and the code is
> OK but ugly and will add a conditional to some THP cases

That reminds me that there are several places that do:

pmd_devmap(pmd) || pmd_trans_huge(pmd)

...for the common cases where a THP and DEVMAP page are equivalent,
but there are a few places where those paths are not shared when the
THP path expects that the page came from the page allocator. So while
DEVMAP is not needed in GUP after this conversion, there still needs
to be an audit of when THP needs to be careful of DAX mappings.

> On the other hand, making THP unmap cases a bit slower is probably a
> net win compared to making put_page a bit slower.. Considering unmap
> is already quite heavy.

FSDAX eventually learned how to replace 'struct page' with xarray for
several paths, so "how hard could it be" (/famous last words) to
replace xarray with 'struct page'? I think the end result will be
cleaner, but yes, I expect some dragons in the conversion.

>
> > > 4) Ask what the pgmap owner wants to do:
> > >
> > >     if (head->pgmap->deny_foll_longterm)
> > >           return FAIL
> >
> > The pgmap itself does not know, but the "holder" could specify this
> > policy.
>
> Here I imagine the thing that creates the pgmap would specify the
> policy it wants. In most cases the policy is tightly coupled to what
> the free function in the the provided dev_pagemap_ops does..

The thing that creates the pgmap is the device-driver, and
device-driver does not implement truncate or reclaim. It's not until
the FS mounts that the pgmap needs to start enforcing pin lifetime
guarantees.

>
> > Which is in line with the 'dax_holder_ops' concept being introduced
> > for reverse mapping support. I.e. when the FS claims the dax-device
> > it can specify at that point that it wants to forbid longterm.
>
> Which is a reasonable refinment if we think there are cases where two
> nvdim users would want different things.
>

It's already the case that device-dax does not enforce transient pin lifetimes.

> Anyhow, I'm wondering on a way forward. There are many balls in the
> air, all linked:
>  - Joao's compound page support for device_dax and more
>  - Alex's DEVICE_COHERENT

I have not seen these patches.

/me notices no MAINTAINERS mention for include/linux/memremap.h

>  - The refcount normalization
>  - Removing the pgmap test from GUP
>  - Removing the need for the PUD/PMD/PTE special bit
>  - Removing the need for the PUD/PMD/PTE devmap bit

It's not clear that this anything but pure cleanup once the special
bit can be used for architectures that don't have devmap. Those same
archs presumably don't care about the THP collisions with DAX.

>  - Remove PUD/PMD vma_is_special
>  - folios for fsdax
>  - shootdown for fsdax
>
> Frankly I'm leery to see more ZONE_DEVICE users crop up that depend on
> the current semantics as that will only make it even harder to fix..
>
> I think it would be good to see Joao's compound page support move
> ahead..
>
> So.. Does anyone want to work on finishing this patch series?? I can
> give some guidance on how I think it should work at least

Completing the DAX reflink work is in my near term goals and that
includes "shootdown for fsdax and removing the pgmap test from GUP",
but probably not in the order that "refcount normalization" folks
would prefer.
