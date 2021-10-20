Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13C0B435101
	for <lists+linux-ext4@lfdr.de>; Wed, 20 Oct 2021 19:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbhJTRPB (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 20 Oct 2021 13:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbhJTRPA (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 20 Oct 2021 13:15:00 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EEA5C061749
        for <linux-ext4@vger.kernel.org>; Wed, 20 Oct 2021 10:12:46 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id o133so3502937pfg.7
        for <linux-ext4@vger.kernel.org>; Wed, 20 Oct 2021 10:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yh4VNQVbmqEE1XoY0HfdKCiOCUMZEFg9p2e4mySh1ho=;
        b=gXp+nm6KP18UxdU9Hk3ApH1mhWLfoJo59VGT/uI2ErBwWWyik4nmEDpSY+ZrwJRKsD
         1m2G6rHPn7W/JZ+E3tckd4iJSTd6DrCA1haY52Re29y61eWHiifpVeHfZXxxVG0OyAIG
         SNKtPfTbbylxqWGsIA6ibBarKTRo4H14iXLyBREaAXG+H2DN8uhwtgKoCeWK8woL61v/
         h3zf1b5/RLytsJ/EioaqOo91sbl+0/PnLuBJrtfYdYpnEHnps1RtQHpp6zHlZvn6BAf5
         ILV5/M+yMBS3ApNMZ1KgMy5ldAYTELk9W2MzVGpH+zHnvMYELSkCHHRjl7R71WGss/j1
         /9/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yh4VNQVbmqEE1XoY0HfdKCiOCUMZEFg9p2e4mySh1ho=;
        b=HDBV9hNY6X+H+b8MZ2k5eTTg9CV1j/EXEySeGFTYjFBHrozZV3qjlbCgpz7oN2pDaz
         //8s/2ifqUYw/OFbYcINOFx36IufKmswLcvOfYju/m/6jRWtAk+HF7SkTXAFqWbgVTrr
         1Qedm3xqs/JFyPyiWksaKtTADZKpE2+Aq/Ej10RYCwZSmA72Jx/VWLdXzAdt6GXrlu1H
         oqJ6HvpDeySpMnCYmlt9THM7b/ymoHarUsQ0bb8k2oazkuueKUAlOQYLa1HfDbSpjTOM
         r+/jehPVupAfy1/cxhlCR/K/Kn/XvCfkF1Opq+o4HuYGbiSMcd7oclQBtDuaClQIxCng
         eJCA==
X-Gm-Message-State: AOAM532gfOcK7GwXnhFtHQHDPYIXyggQ8t6qlNmoXDTFoy6EcS2nGx35
        bS/bHu4+xbjbcYQ6JctB9Yz0pojcmLWFqRbZ8oFxdg==
X-Google-Smtp-Source: ABdhPJwX0GE82e3GMz46Z+6E2d1Wq5pKde1k4jJ2mpNNK8H935nRo76Hn1Yb+qZii2GkvCfouy2IWMMOT+HKVGAV2+o=
X-Received: by 2002:a63:1e0e:: with SMTP id e14mr388190pge.5.1634749965551;
 Wed, 20 Oct 2021 10:12:45 -0700 (PDT)
MIME-Version: 1.0
References: <YWh6PL7nvh4DqXCI@casper.infradead.org> <CAPcyv4hBdSwdtG6Hnx9mDsRXiPMyhNH=4hDuv8JZ+U+Jj4RUWg@mail.gmail.com>
 <20211014230606.GZ2744544@nvidia.com> <CAPcyv4hC4qxbO46hp=XBpDaVbeh=qdY6TgvacXRprQ55Qwe-Dg@mail.gmail.com>
 <20211016154450.GJ2744544@nvidia.com> <CAPcyv4j0kHREAOG6_07E2foz6e4FP8D72mZXH6ivsiUBu_8c6g@mail.gmail.com>
 <20211018182559.GC3686969@ziepe.ca> <CAPcyv4jvZjeMcKLVuOEQ_gXRd87i3NUX5D=MmsJ++rWafnK-NQ@mail.gmail.com>
 <20211018230614.GF3686969@ziepe.ca> <499043a0-b3d8-7a42-4aee-84b81f5b633f@oracle.com>
 <20211019160136.GH3686969@ziepe.ca> <CAPcyv4gmvxi5tpT+xgxPLMPGZiLqKsft_5PzpMQZ-aCvwpbCvw@mail.gmail.com>
 <a82a1307-938b-eaf1-cf3d-b9dc76215636@oracle.com>
In-Reply-To: <a82a1307-938b-eaf1-cf3d-b9dc76215636@oracle.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 20 Oct 2021 10:12:35 -0700
Message-ID: <CAPcyv4g7+FTNi-vFvx_3qzrosTSET6nPc=ozdxs=p1dm0hBJtg@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] mm: remove extra ZONE_DEVICE struct page refcount
To:     Joao Martins <joao.m.martins@oracle.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Matthew Wilcox <willy@infradead.org>,
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
        David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Oct 20, 2021 at 10:09 AM Joao Martins <joao.m.martins@oracle.com> wrote:
>
> On 10/19/21 20:21, Dan Williams wrote:
> > On Tue, Oct 19, 2021 at 9:02 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >>
> >> On Tue, Oct 19, 2021 at 04:13:34PM +0100, Joao Martins wrote:
> >>> On 10/19/21 00:06, Jason Gunthorpe wrote:
> >>>> On Mon, Oct 18, 2021 at 12:37:30PM -0700, Dan Williams wrote:
> >>>>
> >>>>>> device-dax uses PUD, along with TTM, they are the only places. I'm not
> >>>>>> sure TTM is a real place though.
> >>>>>
> >>>>> I was setting device-dax aside because it can use Joao's changes to
> >>>>> get compound-page support.
> >>>>
> >>>> Ideally, but that ideas in that patch series have been floating around
> >>>> for a long time now..
> >>>>
> >>> The current status of the series misses a Rb on patches 6,7,10,12-14.
> >>> Well, patch 8 too should now drop its tag, considering the latest
> >>> discussion.
> >>>
> >>> If it helps moving things forward I could split my series further into:
> >>>
> >>> 1) the compound page introduction (patches 1-7) of my aforementioned series
> >>> 2) vmemmap deduplication for memory gains (patches 9-14)
> >>> 3) gup improvements (patch 8 and gup-slow improvements)
> >>
> >> I would split it, yes..
> >>
> >> I think we can see a general consensus that making compound_head/etc
> >> work consistently with how THP uses it will provide value and
> >> opportunity for optimization going forward.
> >>
>
> I'll go do that. Meanwhile, I'll wait a couple days for Dan to review the
> dax subsystem patches (6 & 7), or otherwise send them over.
>
> >>> Whats the benefit between preventing longterm at start
> >>> versus only after mounting the filesystem? Or is the intended future purpose
> >>> to pass more context into an holder potential future callback e.g. nack longterm
> >>> pins on a page basis?
> >>
> >> I understood Dan's remark that the device-dax path allows
> >> FOLL_LONGTERM and the FSDAX path does not ?
> >>
> >> Which, IIRC, today is signaled basd on vma properties and in all cases
> >> fast-gup is denied.
> >
> > Yeah, I forgot that 7af75561e171 eliminated any possibility of
> > longterm-gup-fast for device-dax, let's not disturb that status quo.
> >
> I am slightly confused by this comment -- the status quo is what we are
> questioning here -- And we talked about changing that in the past too
> (thread below), that longterm-gup-fast was an oversight that that commit
> was only applicable to fsdax. [Maybe this is just my english confusion]

No, you have it correct. However that "regression" has gone unnoticed,
so unless there is data showing that gup-fast on device-dax is
critical for longterm page pinning workflows I'm ok for longterm to
continue to trigger gup-slow.
