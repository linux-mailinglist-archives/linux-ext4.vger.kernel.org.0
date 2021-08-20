Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0E1B3F279D
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Aug 2021 09:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238406AbhHTHZO (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 20 Aug 2021 03:25:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238617AbhHTHZN (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 20 Aug 2021 03:25:13 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36FAEC061575;
        Fri, 20 Aug 2021 00:24:36 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id d11so18207308eja.8;
        Fri, 20 Aug 2021 00:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=hackIAZ3S1L343gFXtpY/gtSDJbx92UQ+Z1VIutr7Q4=;
        b=g5yqqWSA4TLqINjr1gWlzC3DhuGDPMwW2AAzRfYhxUb7bYXOzF6Ib490yt1JaYTU8T
         wfHDhznvJ+7YGogl+Sr1RkAbH5LSmuosTtBFlIlSDkdHsWxZtrD6kYgUtggf7S8rl9AM
         ka2pLHFhvIHXWAZcVD7XlOPLd2OrUwFosIHlUdvYbrPxmhm+uQJA7Xj2NCNxfY9MYQ5Z
         ZOKMbyArtXZtYfDk1czutDEhL16nNZe5pKW+p53gCX82RVV2iOV2SqswhJh23xq5e3nF
         wU4wK8uBSSbIrY1ConUJzP2LMLH8Fp5TlfbQBZFyqmgyeCGyg0bpWlovZmKfY9073clk
         uSVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=hackIAZ3S1L343gFXtpY/gtSDJbx92UQ+Z1VIutr7Q4=;
        b=mJAyWPZEmX1EOFgXm8QofDAClzFVvgtmL2hd3Sucxtly3YQLpqIrxYxMUI5iv9qqAJ
         wPhiypxRPpryjCB9bC+2+g8pe24PCA3xwHl4fY/DdryrleiUrcHhCmbKkB8a0KcveRWS
         oD+w4qU2YIH0mUclE8OBtkck//lBpFA9Mj2sxSHURQPps09RIUrE6ynaJtfhxG7CBP+s
         ZJO3TT1JchUZfBTRprVmHU3GzXSf+3kkPK9B3HdxA2a4X3ZDnc7fQoivoyUNNNLyFCJb
         maS8q3fsy2aReOtU1wMHz6Odz/DVFLOFMWjPNl0uPUtpX0okoO0maFRlCeMzT7Bo97RV
         LB9A==
X-Gm-Message-State: AOAM532I+CgUOyYzMyHL5I9b4BnIgwiwbJ2t/I7C1Ytx2D3GuIBxHGp8
        oQUzoZKFokmx2vMFbMMq21Zm9cz+GnWsVLNhdxM=
X-Google-Smtp-Source: ABdhPJwyKQMVEx7L/ikxtW82X48PcfARrIBCnNbsdgDsW8gvfmgcYX6kBNSV0Omk/D8TyPfB2pw1wTOxxepwKUL87Yw=
X-Received: by 2002:a17:906:c1c9:: with SMTP id bw9mr20251460ejb.3.1629444274765;
 Fri, 20 Aug 2021 00:24:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210813063150.2938-1-alex.sierra@amd.com> <20210813063150.2938-9-alex.sierra@amd.com>
 <20210815154047.GC32384@lst.de> <7a55366f-bd65-7ab9-be9e-3bfd3aea3ea1@amd.com>
 <20210817055031.GC4895@lst.de> <e5eb53f9-c52a-52e1-5fa0-bb468c0c9c85@amd.com> <20210820050504.GB27083@lst.de>
In-Reply-To: <20210820050504.GB27083@lst.de>
Reply-To: j.glisse@gmail.com
From:   Jerome Glisse <j.glisse@gmail.com>
Date:   Fri, 20 Aug 2021 00:24:22 -0700
Message-ID: <CAH3drwbWPFESOGEOFXQKjkhUPmwDEB3nKwcV=S64FPuTimN_Yw@mail.gmail.com>
Subject: Re: [PATCH v6 08/13] mm: call pgmap->ops->page_free for
 DEVICE_GENERIC pages
To:     Christoph Hellwig <hch@lst.de>
Cc:     Felix Kuehling <felix.kuehling@amd.com>,
        Alex Sierra <alex.sierra@amd.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Ralph Campbell <rcampbell@nvidia.com>,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, jgg@nvidia.com,
        Jerome Glisse <jglisse@redhat.com>,
        Roger Pau Monne <roger.pau@citrix.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Aug 19, 2021 at 10:05 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Tue, Aug 17, 2021 at 11:44:54AM -0400, Felix Kuehling wrote:
> > >> That's a good catch. Existing drivers shouldn't need a page_free
> > >> callback if they didn't have one before. That means we need to add a
> > >> NULL-pointer check in free_device_page.
> > > Also the other state clearing (__ClearPageWaiters/mem_cgroup_uncharge/
> > > ->mapping = NULL).
> > >
> > > In many ways this seems like you want to bring back the DEVICE_PUBLIC
> > > pgmap type that was removed a while ago due to the lack of users
> > > instead of overloading the generic type.
> >
> > I think so. I'm not clear about how DEVICE_PUBLIC differed from what
> > DEVICE_GENERIC is today. As I understand it, DEVICE_PUBLIC was removed
> > because it was unused and also known to be broken in some ways.
> > DEVICE_GENERIC seemed close enough to what we need, other than not being
> > supported in the migration helpers.
> >
> > Would you see benefit in re-introducing DEVICE_PUBLIC as a distinct
> > memory type from DEVICE_GENERIC? What would be the benefits of making
> > that distinction?
>
> The old DEVICE_PUBLIC mostly different in that it allowed the page
> to be returned from vm_normal_page, which I think was horribly buggy.

Why was that buggy ? If I were to do it now, i would return
DEVICE_PUBLIC page from vm_normal_page but i would ban pinning as
pinning is exceptionally wrong for GPU. If you migrate some random
anonymous/file back to your GPU memory and it gets pinned there then
there is no way for the GPU to migrate the page out. Quickly you will
run out of physically contiguous memory and things like big graphic
buffer allocation (anything that needs physically contiguous memory)
will fail. It is less of an issue on some hardware that rely less and
less on physically contiguous memory but i do not think it is
completely gone from all hw.

> But the point is not to bring back these old semantics.  The idea
> is to be able to differeniate between your new coherent on-device
> memory and the existing DEVICE_GENERIC.  That is call the
> code in free_devmap_managed_page that is currently only used
> for device private pages also for your new public device pages without
> affecting the devdax and xen use cases.

Yes, I would rather bring back DEVICE_PUBLIC then try to use
DEVICE_GENERIC, the GENERIC change was done for users that closely
matched DAX semantics and it is not the case here, at least not from
my point of view.

Jerome
