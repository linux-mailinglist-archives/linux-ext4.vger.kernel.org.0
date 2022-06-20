Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 207FA551006
	for <lists+linux-ext4@lfdr.de>; Mon, 20 Jun 2022 08:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238471AbiFTGCM (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 20 Jun 2022 02:02:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238431AbiFTGCL (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 20 Jun 2022 02:02:11 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35B0BDFC2;
        Sun, 19 Jun 2022 23:02:10 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-3178acf2a92so55598557b3.6;
        Sun, 19 Jun 2022 23:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xe3VeJwBL8Ebq+C8acPsdxpGtpDiQ/HFobU5cBrv3WU=;
        b=JGXEQN+I0XIHQ+X5Mcx0dO6wWlI7vTAu58RHk2tfY9oeE1RryAubJGzZLv3yuLijUw
         gydtnS0hDUSBpq9r3SsmFRmxKwivL+qEqqG4AeasEJPgKwGUW5ncwS8hDuaBe1by6iLC
         4shKZoFhI0TDayMYjRURjmXduC89qZioy71wZUHaVlgavAIG9rFEBATExIyE2a7s/Lc/
         gNmY5EcMGCyLhl0+wKhutdbW2QJ5Poc9OGfm3v+PoOows2woHUi1qoC2FO9C8S35db6d
         p9G1eS85wqQTc2cRC0ho7twEyZvjDUtmTk7i+PE8vZwGGFv/J/4SsrlLus365LDRYX6v
         rN2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xe3VeJwBL8Ebq+C8acPsdxpGtpDiQ/HFobU5cBrv3WU=;
        b=IzoV2is+oeE3j+Xh0UWEXTaGsWqRRnJbdQdivUa2V5ESkfaz2ytyOkh1zch3NcEW+g
         WkL5upZHZKJocwauN6d9g9vJbx706B/2ZSuazVJA1UiW2f8bKcZruqy/844/f8UI5iBq
         WI+adIAxHSvEFgWI7CPP8Htd8NZZxhV4ya91qSkPJr+bq86qfoEpUnbH9hmzRNZD7bnX
         Rn6Wk1H73Ic2kRGvY7KzObadwp5lfvXb3z1Y21/RqHGZMZkeay72HEbH370FrRtY7n5I
         OCBlljL/Y1FxgMeASylSsTnX0fXW8wZ5x8rvbHjpDGVMxdqhCc+2yFygZq3T5hQ7P1rs
         otAA==
X-Gm-Message-State: AJIora9N05rSVgrJ4/S6kJDaMNnc7lAXadWkmCpKi7DsV+Ym6ryi5qpa
        qwTqG1QDKgh993HTqMyjHJQrYR/JIvd60Pqchnk=
X-Google-Smtp-Source: AGRyM1tzeukUE0eoUNLmKpkTD0UfGuNi9OAgJD/BPDmnsr6lE4pkLipEhHJgaDKCB2nZwNfM9ZoCJ1FPCdi+Kl69/hM=
X-Received: by 2002:a0d:f8c6:0:b0:2fe:ca9c:f937 with SMTP id
 i189-20020a0df8c6000000b002feca9cf937mr25655114ywf.62.1655704929245; Sun, 19
 Jun 2022 23:02:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220531200041.24904-1-alex.sierra@amd.com> <20220531200041.24904-2-alex.sierra@amd.com>
 <3ac89358-2ce0-7d0d-8b9c-8b0e5cc48945@redhat.com> <02ed2cb7-3ad3-8ffc-6032-04ae1853e234@amd.com>
 <CAFCwf11z5Q+2FPS1yPi6EwQuRqoJg_dLB-rYgtVwP-zQEdqjQQ@mail.gmail.com> <87bkuo898d.fsf@nvdebian.thelocal>
In-Reply-To: <87bkuo898d.fsf@nvdebian.thelocal>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Mon, 20 Jun 2022 09:01:42 +0300
Message-ID: <CAFCwf11Lru4rHJ93gkCTMqfsWZ8Hcug4z=_t7B=G07bo7zsaFw@mail.gmail.com>
Subject: Re: [PATCH v5 01/13] mm: add zone device coherent type memory support
To:     Alistair Popple <apopple@nvidia.com>
Cc:     "Sierra Guiza, Alejandro (Alex)" <alex.sierra@amd.com>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>, rcampbell@nvidia.com,
        Matthew Wilcox <willy@infradead.org>,
        "Kuehling, Felix" <Felix.Kuehling@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        linux-xfs@vger.kernel.org, linux-mm <linux-mm@kvack.org>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-ext4@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Jun 20, 2022 at 3:33 AM Alistair Popple <apopple@nvidia.com> wrote:
>
>
> Oded Gabbay <oded.gabbay@gmail.com> writes:
>
> > On Fri, Jun 17, 2022 at 8:20 PM Sierra Guiza, Alejandro (Alex)
> > <alex.sierra@amd.com> wrote:
> >>
> >>
> >> On 6/17/2022 4:40 AM, David Hildenbrand wrote:
> >> > On 31.05.22 22:00, Alex Sierra wrote:
> >> >> Device memory that is cache coherent from device and CPU point of view.
> >> >> This is used on platforms that have an advanced system bus (like CAPI
> >> >> or CXL). Any page of a process can be migrated to such memory. However,
> >> >> no one should be allowed to pin such memory so that it can always be
> >> >> evicted.
> >> >>
> >> >> Signed-off-by: Alex Sierra <alex.sierra@amd.com>
> >> >> Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>
> >> >> Reviewed-by: Alistair Popple <apopple@nvidia.com>
> >> >> [hch: rebased ontop of the refcount changes,
> >> >>        removed is_dev_private_or_coherent_page]
> >> >> Signed-off-by: Christoph Hellwig <hch@lst.de>
> >> >> ---
> >> >>   include/linux/memremap.h | 19 +++++++++++++++++++
> >> >>   mm/memcontrol.c          |  7 ++++---
> >> >>   mm/memory-failure.c      |  8 ++++++--
> >> >>   mm/memremap.c            | 10 ++++++++++
> >> >>   mm/migrate_device.c      | 16 +++++++---------
> >> >>   mm/rmap.c                |  5 +++--
> >> >>   6 files changed, 49 insertions(+), 16 deletions(-)
> >> >>
> >> >> diff --git a/include/linux/memremap.h b/include/linux/memremap.h
> >> >> index 8af304f6b504..9f752ebed613 100644
> >> >> --- a/include/linux/memremap.h
> >> >> +++ b/include/linux/memremap.h
> >> >> @@ -41,6 +41,13 @@ struct vmem_altmap {
> >> >>    * A more complete discussion of unaddressable memory may be found in
> >> >>    * include/linux/hmm.h and Documentation/vm/hmm.rst.
> >> >>    *
> >> >> + * MEMORY_DEVICE_COHERENT:
> >> >> + * Device memory that is cache coherent from device and CPU point of view. This
> >> >> + * is used on platforms that have an advanced system bus (like CAPI or CXL). A
> >> >> + * driver can hotplug the device memory using ZONE_DEVICE and with that memory
> >> >> + * type. Any page of a process can be migrated to such memory. However no one
> >> > Any page might not be right, I'm pretty sure. ... just thinking about special pages
> >> > like vdso, shared zeropage, ... pinned pages ...
> >>
> >> Hi David,
> >>
> >> Yes, I think you're right. This type does not cover all special pages.
> >> I need to correct that on the cover letter.
> >> Pinned pages are allowed as long as they're not long term pinned.
> >>
> >> Regards,
> >> Alex Sierra
> >
> > What if I want to hotplug this device's coherent memory, but I do
> > *not* want the OS
> > to migrate any page to it ?
> > I want to fully-control what resides on this memory, as I can consider
> > this memory
> > "expensive". i.e. I don't have a lot of it, I want to use it for
> > specific purposes and
> > I don't want the OS to start using it when there is some memory pressure in
> > the system.
>
> This is exactly what MEMORY_DEVICE_COHERENT is for. Device coherent
> pages are only allocated by a device driver and exposed to user-space by
> a driver migrating pages to them with migrate_vma. The OS can't just
> start using them due to memory pressure for example.
>
>  - Alistair
Thanks for the explanation.

I guess the commit message confused me a bit, especially these two sentences:

"Any page of a process can be migrated to such memory. However no one should be
allowed to pin such memory so that it can always be evicted."

I read them as if the OS is free to choose which pages are migrated to
this memory,
and anything is eligible for migration to that memory (and that's why
we also don't
allow it to pin memory there).

If we are not allowed to pin anything there, can the device driver
decide to disable
any option for oversubscription of this memory area ?

Let's assume the user uses this memory area for doing p2p with other
CXL devices.
In that case, I wouldn't want the driver/OS to migrate pages in and
out of that memory...

So either I should let the user pin those pages, or prevent him from
doing (accidently or not)
oversubscription in this memory area.

wdyt ?

>
> > Oded
> >
> >>
> >> >
> >> >> + * should be allowed to pin such memory so that it can always be evicted.
> >> >> + *
> >> >>    * MEMORY_DEVICE_FS_DAX:
> >> >>    * Host memory that has similar access semantics as System RAM i.e. DMA
> >> >>    * coherent and supports page pinning. In support of coordinating page
> >> >> @@ -61,6 +68,7 @@ struct vmem_altmap {
> >> >>   enum memory_type {
> >> >>      /* 0 is reserved to catch uninitialized type fields */
> >> >>      MEMORY_DEVICE_PRIVATE = 1,
> >> >> +    MEMORY_DEVICE_COHERENT,
> >> >>      MEMORY_DEVICE_FS_DAX,
> >> >>      MEMORY_DEVICE_GENERIC,
> >> >>      MEMORY_DEVICE_PCI_P2PDMA,
> >> >> @@ -143,6 +151,17 @@ static inline bool folio_is_device_private(const struct folio *folio)
> >> > In general, this LGTM, and it should be correct with PageAnonExclusive I think.
> >> >
> >> >
> >> > However, where exactly is pinning forbidden?
> >>
> >> Long-term pinning is forbidden since it would interfere with the device
> >> memory manager owning the
> >> device-coherent pages (e.g. evictions in TTM). However, normal pinning
> >> is allowed on this device type.
> >>
> >> Regards,
> >> Alex Sierra
> >>
> >> >
