Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE4E1430B63
	for <lists+linux-ext4@lfdr.de>; Sun, 17 Oct 2021 20:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344041AbhJQSXL (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 17 Oct 2021 14:23:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344032AbhJQSXL (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 17 Oct 2021 14:23:11 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E463C06161C
        for <linux-ext4@vger.kernel.org>; Sun, 17 Oct 2021 11:21:01 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id f21so9727119plb.3
        for <linux-ext4@vger.kernel.org>; Sun, 17 Oct 2021 11:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bXbtM9w7wtLoZs3T6qJjqX2Ty4EbqqViT4Y7xCCz9a0=;
        b=2Tgma9fVZq0U5pzB5d+36fugnRWpKAv/vv+rd8TY+x55UKPcedrr3mcNfc9HXBvbun
         uQlo9RXfQ+zSC64+hvaj39yB4RzfudhW8ebr5TZUjs8P6f8o/iY3/E3pBSw+FmZg9r5H
         yrKODUnTdxhNkmkAk/E1YHkypi6Sv3jbpIibkuVlTjnnQeieoFMENC1NLaSK2u4SlvST
         ec4bQfrye0G7/+vvWyyX4A1WiflmgrwjfFh+W2cGmx0+/DneG46gr0nh4gtOHwTEyWHX
         64cN+swwvB62EGxeYvejuxtdCUCu6ZdwbaLZUn9QkYSKwCOSEQt5XvyOcToZImgWm8HS
         LudQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bXbtM9w7wtLoZs3T6qJjqX2Ty4EbqqViT4Y7xCCz9a0=;
        b=4BJRqWaGJO6pETavFZt2SXYVP6Nf5JO36kCT+sQ2YBXmXCEJIaskTWiHD+Mps4/Kb3
         4I3G/QcRkkvAFh3PkF84sV/Ke8kCZ1wsgtVMvQP2HVvR0PrnZeJBWppEosdHr46Gdv3h
         xkwsiW4AN/96DF/UIPVCuam6em+9cH9GfzTYtco64JhVwX8nMSI2zTyw4gAu0Hv0AolV
         buM6hiDnnVlYpOJ7ak1LwB/nUW8R1bsknof+y5Shs+9UXHojRtxSYURG+CEZ7u18VhtB
         K4UlIxydlkvwZEn0X6gyJmFaPuetLydMBA7plDw+F5kflVIlY4z1RTCfXWDsqLFfZ1YC
         3jDQ==
X-Gm-Message-State: AOAM533odCYsUVjoDvTrmPjZ/GtuEjKQk9OKwHnJNgCKlbpZoQmT5JQD
        nShc1nIdk5ATuUnk8vRdqNHJaYjzl+6hjr7b3KSJ2Ae7wr4=
X-Google-Smtp-Source: ABdhPJzU8zZ6l/YLNPvyqrKueTnR9hmDhm8Moze9Nm8sl5P7aCcyYqLsiPIbKOBjjU/+LKabzjZnafwYKZQAKYl1LZI=
X-Received: by 2002:a17:902:8a97:b0:13e:6e77:af59 with SMTP id
 p23-20020a1709028a9700b0013e6e77af59mr22550921plo.4.1634494860987; Sun, 17
 Oct 2021 11:21:00 -0700 (PDT)
MIME-Version: 1.0
References: <20211014153928.16805-1-alex.sierra@amd.com> <20211014153928.16805-3-alex.sierra@amd.com>
 <20211014170634.GV2744544@nvidia.com> <YWh6PL7nvh4DqXCI@casper.infradead.org>
 <CAPcyv4hBdSwdtG6Hnx9mDsRXiPMyhNH=4hDuv8JZ+U+Jj4RUWg@mail.gmail.com>
 <20211014230606.GZ2744544@nvidia.com> <CAPcyv4hC4qxbO46hp=XBpDaVbeh=qdY6TgvacXRprQ55Qwe-Dg@mail.gmail.com>
 <20211016154450.GJ2744544@nvidia.com> <YWsAM3isdPSv2S3E@casper.infradead.org>
In-Reply-To: <YWsAM3isdPSv2S3E@casper.infradead.org>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Sun, 17 Oct 2021 11:20:53 -0700
Message-ID: <CAPcyv4h-KxpwJtrM4VV64J7EPk9JCPeW27jtPXyArarfeo9noA@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] mm: remove extra ZONE_DEVICE struct page refcount
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
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

On Sat, Oct 16, 2021 at 9:39 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Sat, Oct 16, 2021 at 12:44:50PM -0300, Jason Gunthorpe wrote:
> > Assuming changing FSDAX is hard.. How would DAX people feel about just
> > deleting the PUD/PMD support until it can be done with compound pages?
>
> I think there are customers who would find that an unacceptable answer :-)

No, not given the number of end users that ask for help debugging PMD support.
