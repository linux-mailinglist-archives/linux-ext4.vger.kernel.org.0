Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87E6D3FF2FE
	for <lists+linux-ext4@lfdr.de>; Thu,  2 Sep 2021 20:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346893AbhIBSIj (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 2 Sep 2021 14:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234619AbhIBSIi (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 2 Sep 2021 14:08:38 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 814CEC061757
        for <linux-ext4@vger.kernel.org>; Thu,  2 Sep 2021 11:07:39 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id d5so1938259pjx.2
        for <linux-ext4@vger.kernel.org>; Thu, 02 Sep 2021 11:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vRIjmhyCmvhzoncqRr/4/DZW11FScO6N7+EAyatLST8=;
        b=XMesfIC0+k3N01cWkq/7yrPStcBFfCtU0Xt5gHxmO6bSOqNzOd/s/+OIcyxTtPL0UB
         Zng0Xr0YFco/Xf9QMwJ1lFRNjwY2PQU2HaoU373axgK5j5uox9fzWYNliilkTt2b7635
         V91czhYOVkLyFSSHgMICNRA+1MUJvkWBhBtJCw+K3Pz7KZzwdTemN3cZWwl6TG6/x/VY
         gVXwVoSa8S7795y2jXzfuGxwg/3NV2fxcHJ+poYDNAV/6rPM1QeRY/Xp9i6iTn+hetnE
         jzukgzWZ2XX4nyFUgxq4UKt32X2sBiiT9MgweOPYXEtFj2L1DKwPsQuH2MLeX33munh9
         iWgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vRIjmhyCmvhzoncqRr/4/DZW11FScO6N7+EAyatLST8=;
        b=gr+bNg36U/kKIi6JF19ouaL/jl985ODxYLujtPRm1gF3O5e/EQZYOzYngSsSmhkYxh
         Uy2zvQNiF6tyY0I0eSQzSgx2be5QlK6TZ5gHYLzc9NoWSn8dyc1dFLrEPBo2fAcJmv6u
         6fzQ0W/IQrVp7TljcxWH8PPjR4PLG8rzHsa2zowd0eWyTKAqn051ujM1RauhTCVoGkiL
         PeOiT7bCrfhWrxneAyGwjW1LCxEfTnqS0ExOJQquQlVMwT9UT2u3GLzwEHV42DbIgAxn
         aN6Y7xHdQ85nNj/Inq0NoUUChxRt/dzumy3UW/5QdoMJa17GeNIXpwf98iPfyE1lQlUo
         efmg==
X-Gm-Message-State: AOAM531lBs3na4gMWfNHjM1A2/67mHjpE5iIK5nmYqVHFcWTtUmfYj62
        uPkEs1G2RQoqnoIBNkc76RNdCnGwshfUpEXs2YGwWA==
X-Google-Smtp-Source: ABdhPJzISzTRdHEt3HEJe+ostypx1drj+Ux+3k9nfUpn2fvhtymn5ZGWoVXBoZmcXh6gl6QtltkADP+8aToUdn6EVdg=
X-Received: by 2002:a17:902:e550:b0:137:734f:1d84 with SMTP id
 n16-20020a170902e55000b00137734f1d84mr4046482plf.27.1630606059035; Thu, 02
 Sep 2021 11:07:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210825034828.12927-1-alex.sierra@amd.com> <20210825034828.12927-4-alex.sierra@amd.com>
 <20210825074602.GA29620@lst.de> <c4241eb3-07d2-c85b-0f48-cce4b8369381@amd.com>
 <a9eb2c4a-d8cc-9553-57b7-fd1622679aaa@amd.com> <20210830082800.GA6836@lst.de>
 <e40b3b79-f548-b87b-7a85-f654f25ed8dd@amd.com> <20210901082925.GA21961@lst.de>
 <11d64457-9d61-f82d-6c98-d68762dce85d@amd.com> <20210902081826.GA16283@lst.de>
In-Reply-To: <20210902081826.GA16283@lst.de>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 2 Sep 2021 11:07:28 -0700
Message-ID: <CAPcyv4gCbZikp1k+f3FA5HusSW8gGkpCAxzR70eKEASLcnMCRA@mail.gmail.com>
Subject: Re: [PATCH v1 03/14] mm: add iomem vma selection for memory migration
To:     Christoph Hellwig <hch@lst.de>
Cc:     Felix Kuehling <felix.kuehling@amd.com>,
        "Sierra Guiza, Alejandro (Alex)" <alex.sierra@amd.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Ralph Campbell <rcampbell@nvidia.com>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Sep 2, 2021 at 1:18 AM Christoph Hellwig <hch@lst.de> wrote:
>
> On Wed, Sep 01, 2021 at 11:40:43AM -0400, Felix Kuehling wrote:
> > >>> It looks like I'm totally misunderstanding what you are adding here
> > >>> then.  Why do we need any special treatment at all for memory that
> > >>> has normal struct pages and is part of the direct kernel map?
> > >> The pages are like normal memory for purposes of mapping them in CPU
> > >> page tables and for coherent access from the CPU.
> > > That's the user page tables.  What about the kernel direct map?
> > > If there is a normal kernel struct page backing there really should
> > > be no need for the pgmap.
> >
> > I'm not sure. The physical address ranges are in the UEFI system address
> > map as special-purpose memory. Does Linux create the struct pages and
> > kernel direct map for that without a pgmap call? I didn't see that last
> > time I went digging through that code.
>
> So doing some googling finds a patch from Dan that claims to hand EFI
> special purpose memory to the device dax driver.  But when I try to
> follow the version that got merged it looks it is treated simply as an
> MMIO region to be claimed by drivers, which would not get a struct page.
>
> Dan, did I misunderstand how E820_TYPE_SOFT_RESERVED works?

The original implementation of "soft reserve" support depended on the
combination of the EFI special purpose memory type and the ACPI HMAT
to define the device ranges. The requirement for ACPI HMAT was relaxed
later with commit:

5ccac54f3e12 ACPI: HMAT: attach a device for each soft-reserved range

The expectation is that system software policy can then either use the
device interface, assign a portion of the reservation back to the page
allocator, ignore the reservation altogether. Is this discussion
asking for a way to assign this memory to the GPU driver to manage?
device-dax already knows how to hand off to the page-allocator, seems
reasonable for it to be able to hand-off to another driver.
