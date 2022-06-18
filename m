Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF8D9550170
	for <lists+linux-ext4@lfdr.de>; Sat, 18 Jun 2022 02:41:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235768AbiFRAlX (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 17 Jun 2022 20:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234931AbiFRAlW (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 17 Jun 2022 20:41:22 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE6906970B
        for <linux-ext4@vger.kernel.org>; Fri, 17 Jun 2022 17:41:20 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id w20so9143033lfa.11
        for <linux-ext4@vger.kernel.org>; Fri, 17 Jun 2022 17:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cpxDyHMuebn7RKRwDx2h7An8NQGRYc/mr6kw2nTQmGc=;
        b=aAcb59gIeMxg5/S2E55LJZdDWP+Nm4XBv1x7+0ZEJVSQcPuej+U1yxTdfu+jc1dbaz
         D1Yu53+W7JBSsRIUf7dkerpCPC9plQn3VO5rO2fw6nG/xvi0U+GE8jI85FOYbVqjuTEz
         hcgTI6PqgrYHL4YL4If9XjaPnVFokt6C4eD3nyBd4szxF1n3KwsLWMsi38VE0QweMMzB
         cstCu08oO60mmTMoZoGXaUKDhSiQtJxsmnGkMy9jv9XAyzHiIY2HFz3KO2sFGVNE83RS
         BfliyyXWbncmZsO5wXLkIVQAOJhaI3/dolHYLYwr8q6EXmeSVbiMWE1m+8wkcfhc1t7/
         mL2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cpxDyHMuebn7RKRwDx2h7An8NQGRYc/mr6kw2nTQmGc=;
        b=eydaQBTHt0RGmgcDGsu/GU2rYLkDAwPK3RtQnoMteJjTUjad/0khVlKGmKpCcchU5k
         D6svso9hO+tLgpeaDahjT003cBIB2DzHreDbTOCJn8OO0TEMFk3XUL83VHEYjBdD73oK
         PMEm8OeBVGxSurwXrIdUG8t7F0Ls+7oi5HY+/9hzXiv5pA0QQuTIgC9d1xIKN4Zkxp4z
         SQmv16EhWZjPTU5/OTC6zXnRIvljV2Lt4pcaxVyYr5V+87wO08narFjiTO15GArWkwLp
         eo3qGxKYSPlAYU2Jqpt1c23fB91F3TiC7y0N0VEq4gpeczFewu0DzuuRST+7dLBf4ye5
         RvzA==
X-Gm-Message-State: AJIora9yDnXv6fp7nZ2PM4/iuwILdtiqtb4U6M09MuGPThp/f7GMjs4d
        K/Pb4RudmXFw1o7PDwS6sFrvHCurWge/kSzLKdE=
X-Google-Smtp-Source: AGRyM1sdWpy4WC9nYm8F/8DWOrgarQPpPjF88Z3Wmqmbn4MMljcAcMmV+91uKWw8BETKogp9WFWWmiwqetqZJtJ0yj4=
X-Received: by 2002:a19:5f1d:0:b0:478:f072:8dc9 with SMTP id
 t29-20020a195f1d000000b00478f0728dc9mr7161593lfb.440.1655512879092; Fri, 17
 Jun 2022 17:41:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAGQ4T_Jne-bxdP9rMNBzqXw16a4kD4FM=F5VuGgUbczj5WgCLA@mail.gmail.com>
 <Yqz8a0ggTjIU3h7T@mit.edu> <CAGQ4T_J-43q5xszJK8yDTUt14NGjjQACK4Z1RST-ZQkju3xSzQ@mail.gmail.com>
In-Reply-To: <CAGQ4T_J-43q5xszJK8yDTUt14NGjjQACK4Z1RST-ZQkju3xSzQ@mail.gmail.com>
From:   Santosh S <santosh.letterz@gmail.com>
Date:   Fri, 17 Jun 2022 20:41:07 -0400
Message-ID: <CAGQ4T_J0+B=QzVLmNY0MBEWhuCno6=6DLVk1q-oZu_K52mt=4A@mail.gmail.com>
Subject: Re: Overwrite faster than fallocate
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
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

On Fri, Jun 17, 2022 at 7:56 PM Santosh S <santosh.letterz@gmail.com> wrote:
>
>  On Fri, Jun 17, 2022 at 6:13 PM Theodore Ts'o <tytso@mit.edu> wrote:
> >
> > On Fri, Jun 17, 2022 at 12:38:20PM -0400, Santosh S wrote:
> > > Dear ext4 developers,
> > >
> > > This is my test - preallocate a large file (2G) and then do sequential
> > > 4K direct-io writes to that file, with fdatasync after every write.
> > > I am preallocating using fallocate mode 0. I noticed that if the 2G
> > > file is pre-written rather than fallocate'd I get more than twice the
> > > throughput. I could reproduce this with fio. The storage is nvme.
> > > Kernel version is 5.3.18 on Suse.
> > >
> > > Am I doing something wrong or is this difference expected? Any
> > > suggestion to get a better throughput without actually pre-writing the
> > > file.
> >
> > This is, alas, expected.  The reason for this is because when you use
> > fallocate, the extent is marked as uninitialized, so that when you
> > read from the those newly allocated blocks, you don't see previously
> > written data belonging to deleted files.  These files could contain
> > someone else's e-mail, or medical information, etc.  So if we didn't
> > do this, it would be a walking, talking HIPPA or PCI violation.
> >
> > So when you write to an fallocated region, and then call fdatasync(2),
> > we need to update the metadata blocks to clear the uninitialized bit
> > so that when you read from the file after a crash, you actually get
> > the data that was written.  So the fdatasync(2) operation is quite the
> > heavyweight operation, since it requries journal commit because of the
> > required metadata update.  When you do an overwrite, there is no need
> > to force a metadata update and journal update, which is why write(2)
> > plus fdatasync(2) is much lighter weight when you do an overwrite.
> >
> > What enterprise databases (e.g., Oracle Enterprise Database and IBM's
> > Informix DB) tend to do is to use fallocate a chunk of space (say,
> > 16MB or 32MB), because for Legacy Unix OS's, this tends enable some
> > file system's block allocators to be more likely to allocate a
> > contiguous block range, and then immediate write zero's on that 16 or
> > 32MB, plus a fdatasync(2).  This fdatasync(2) would update the extent
> > tree once to make that 16MB or 32MB to be marked initialized to the
> > database's tablespace file, so you only pay the metadata update once,
> > instead of every few dozen kilobytes as you write each database commit
> > into the tablespace file.
> >
> > There is also an old, out of tree patch which enables an fallocate
> > mode called "no hide stale", which marks the extent tree blcoks which
> > are allocated using fallocate(2) as initialized.  This substantially
> > speeds things up, but it is potentially a walking, talking, HIPPA or
> > PCI violation in that revealing previously written data is considered
> > a horrible security violation by most file system developers.
> >
> > If you know, say, that a cluster file system is the only user of the
> > file system, and all data is written encrypted at rest using a
> > per-user key, such that exposing stale data is not a security
> > disaster, the "no hide stale" flag could be "safe" in that highly
> > specialized user case.
> >
> > But that assumes that file system authors can trust application
> > writers not to do something stupid and insecure, and historically,
> > file system authors (possibly with good reason, given bitter past
> > experience) don't trust application writesr to do something which is
> > very easy, and gooses performance, even if it has terrible side
> > effects on either data robustness or data security.
> >
> > Effectively, the no hide stale flag could be considered an "Attractive
> > Nuisance"[1] and so support for this feature has never been accepted
> > into the mainline kernel, and never to any distro kernels, since the
> > distribution companies don't want to be held liable for making an
> > "acctive nuisance" that might enable application authors from shooting
> > themselves in the foot.
> >
> > [1] https://en.wikipedia.org/wiki/Attractive_nuisance_doctrine
> >
> > In any case, the technique of fallocatE(2) plus zero-fill-write plus
> > fdatasync(2) isn't *that* slow, and is only needed when you are first
> > extending the tablespace file.  In the steady state, most database
> > applications tend to be overwriting space, so this isn't an issue.
> >
> > In any case, if you need to get that last 5% or so of performance ---
> > say, if you are are an enterprise database company interested in
> > taking a full page advertisement on the back cover of Business Week
> > Magazine touting how your enterprise database benchmarks are better
> > than the competition --- the simple solution is to use a raw block
> > device.  Of course, most end users want the convenience of the file
> > system, but that's not the point if you are engaging in
> > benchmarketing.   :-)
> >
> > Cheers,
> >
> >                                                 - Ted
>
> Thank you for a comprehensive answer :-)
>
> I have one more question - when I gradually increase the i/o transfer
> size the performance degradation begins to lessen and at 32K it is
> similar to the "overwriting the file" case. I assume this is because
> the metadata update is now spread over 32K of data rather than 4K.
> However, my understanding is that, in my case, an extent should
> represent the max 128MiB of data and so the clearing of the
> uninitialized bit for an extent should happen once every 128MiB, so
> then why is a higher transfer size making a difference?
>

I think I understand. The metadata update cannot just be clearing the
uninitialized bit, but also updating the high water mark telling the
length of the initialized part of the extent.

> Santosh
