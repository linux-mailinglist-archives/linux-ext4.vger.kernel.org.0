Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9028C42E632
	for <lists+linux-ext4@lfdr.de>; Fri, 15 Oct 2021 03:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232973AbhJOBjw (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 14 Oct 2021 21:39:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232410AbhJOBjw (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 14 Oct 2021 21:39:52 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC1F9C061753
        for <linux-ext4@vger.kernel.org>; Thu, 14 Oct 2021 18:37:46 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id pf6-20020a17090b1d8600b0019fa884ab85so8226375pjb.5
        for <linux-ext4@vger.kernel.org>; Thu, 14 Oct 2021 18:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Nr8k1aUv3z2OzOm3G6XuPV/NnMghC3CxLAXi8H1jgq0=;
        b=Mq60g49KQfqJSx9Hlnpx1LkISuHFFWCkdhMNhbH31PDqxasC1fBD6r9vXBbknkaWMK
         lChJJPt+7b3pndrbO9E/vbjDaPud20IbnvRAMOogvsJsZT2U7U2B08GDOjq5mJAz//YT
         pUFXQlTk6FHl/Y5XqZwpAwYXkmA/nd/FXzsy+ADUyTODVVWD0me/6KKjEDCOhGFa4tU4
         wSxvbpsQXT+KAhdAkd80WrKMMrzTxWLBZMYNVG9REGY3Ujp+K9XNl6UD/fgSRvtPtXtz
         0QqqOunHYakkVaxUm+vSHdYXntEMMCYCrb+aUsaBUqYAJXyC9rdXR8U+kphiap+Pl4pP
         hPXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Nr8k1aUv3z2OzOm3G6XuPV/NnMghC3CxLAXi8H1jgq0=;
        b=RcuDUjl1Dq5q7TONeTCxX/cb7Tr/cu4vXuakYvCLvW9Jq9PDE4rXdh7eoFCMo5DCAx
         2X2BQfAqzTgVw6w4IWNDXT2245/byPa6LjBjrA0mzisxZKIV5HnFlBuOksqpi2dx/J7O
         YewXuOTYTiJ5p0BynnYUc0hqvze168HjTuN842kyIF45uqsbuXnqRlbMoMzPf2m4yEsv
         UaUZTsZjhxvUAfEMAuWunN16zdsPji3gTLrlDD6hgBkX7YYT2cCkx5JzaG8YdHwkvS0Q
         A80ukKy+uutisXjm4+wK2NDEXSEjpPEn67eFS0DghL2I8Dr6Vm/+XbNzk9qQQiXw+a8z
         EgNg==
X-Gm-Message-State: AOAM531SMdXt8nNaSbIUmrowQEJTrQPRB+tattmLEJpwt0u0d470qWAG
        G9ln2zcQAOg+QnjTIltbwyx6fQrq9EFthA3WytZBaA==
X-Google-Smtp-Source: ABdhPJzJeyDQ3E7K9800YlGpr55I5n0doDZS1y4ODUC2mgk0GCjS+vEI9q19Hu7ebbpj4/v0RR4BsGE6NqO67YdMecY=
X-Received: by 2002:a17:902:ab50:b0:13f:4c70:9322 with SMTP id
 ij16-20020a170902ab5000b0013f4c709322mr8238204plb.89.1634261866111; Thu, 14
 Oct 2021 18:37:46 -0700 (PDT)
MIME-Version: 1.0
References: <20211014153928.16805-1-alex.sierra@amd.com> <20211014153928.16805-3-alex.sierra@amd.com>
 <20211014170634.GV2744544@nvidia.com> <YWh6PL7nvh4DqXCI@casper.infradead.org>
 <CAPcyv4hBdSwdtG6Hnx9mDsRXiPMyhNH=4hDuv8JZ+U+Jj4RUWg@mail.gmail.com> <20211014230606.GZ2744544@nvidia.com>
In-Reply-To: <20211014230606.GZ2744544@nvidia.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 14 Oct 2021 18:37:35 -0700
Message-ID: <CAPcyv4hC4qxbO46hp=XBpDaVbeh=qdY6TgvacXRprQ55Qwe-Dg@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] mm: remove extra ZONE_DEVICE struct page refcount
To:     Jason Gunthorpe <jgg@nvidia.com>
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
        Linux NVDIMM <nvdimm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Oct 14, 2021 at 4:06 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> On Thu, Oct 14, 2021 at 12:01:14PM -0700, Dan Williams wrote:
> > > > Does anyone know why devmap is pte_special anyhow?
> >
> > It does not need to be special as mentioned here:
> >
> > https://lore.kernel.org/all/CAPcyv4iFeVDVPn6uc=aKsyUvkiu3-fK-N16iJVZQ3N8oT00hWA@mail.gmail.com/
>
> I added a remark there
>
> Not special means more to me, it means devmap should do the refcounts
> properly like normal memory pages.
>
> It means vm_normal_page should return !NULL and it means insert_page,
> not insert_pfn should be used to install them in the PTE. VMAs should
> not be MIXED MAP, but normal struct page maps.
>
> I think this change alone would fix all the refcount problems
> everwhere in DAX and devmap.
>
> > The refcount dependencies also go away after this...
> >
> > https://lore.kernel.org/all/161604050866.1463742.7759521510383551055.stgit@dwillia2-desk3.amr.corp.intel.com/
> >
> > ...but you can see that patches 1 and 2 in that series depend on being
> > able to guarantee that all mappings are invalidated when the undelying
> > device that owns the pgmap goes away.
>
> If I have put everything together right this is because of what I
> pointed to here. FS-DAX is installing 0 refcount pages into PTEs and
> expecting that to work sanely.
>
> This means the page map cannot be removed until all the PTEs are fully
> flushed, which buggily doesn't happen because of the missing unplug.
>
> However, this is all because nobody incrd a refcount to represent the
> reference in the PTE and since this ment that 0 refcount pages were
> wrongly stuffed into PTEs then devmap used the refcount == 1 hack to
> unbreak GUP?
>
> So.. Is there some reason why devmap pages are trying so hard to avoid
> sane refcounting???

I wouldn't put it that way. It's more that the original sin of
ZONE_DEVICE that sought to reuse the lru field space, by never having
a zero recount, then got layered upon and calcified in malignant ways.
In the meantime surrounding infrastructure got decrustified. Work like
the 'struct page' cleanup among other things, made it clearer and
clearer over time that the original design choice needed to be fixed.

> If the PTE itself holds the refcount (by not being special) then there
> is no need for the pagemap stuff in GUP. pagemap already waits for
> refs to go to 0 so the missing shootdown during nvdimm unplug will
> cause pagemap to block until the address spaces are invalidated. IMHO
> this is already better than the current buggy situation of allowing
> continued PTE reference to memory that is now removed from the system.
>
> > For that to happen there needs to be communication back to the FS for
> > device-gone / failure events. That work is in progress via this
> > series:
> >
> > https://lore.kernel.org/all/20210924130959.2695749-1-ruansy.fnst@fujitsu.com/
>
> This is fine, but I don't think it should block fixing the mm side -
> the end result here still cannot be 0 ref count pages installed in
> PTEs.
>
> Fixing that does not depend on shootdown during device removal, right?
>
> It requires holding refcounts while pages are installed into address
> spaces - and this lack is a direct cause of making the PTEs all
> special and using insert_pfn and MIXED_MAP.

The MIXED_MAP and insert_pfn were a holdover from page-less DAX, but
now that we have page-available DAX, yes, we can skip the FS
notification and just rely on typical refcounting and hanging until
the FS has a chance to uninstall the PTEs. You're right, the FS
notification is an improvement to the conversion, not a requirement.

However, there still needs to be something in the gup-fast path to
indicate that GUP_LONGTERM is not possible because the PTE represents
a pfn that can not support typical page-cache behavior for truncate
which is to just disconnect the page from the file and keep the page
pinned indefinitely. I think the "no longterm" caveat would be the
only remaining utility of PTE_DEVMAP after the above conversion to use
typical page refcounts throughout DAX.
