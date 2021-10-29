Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C60A044002A
	for <lists+linux-ext4@lfdr.de>; Fri, 29 Oct 2021 18:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbhJ2QTQ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 29 Oct 2021 12:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbhJ2QTQ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 29 Oct 2021 12:19:16 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD449C061570
        for <linux-ext4@vger.kernel.org>; Fri, 29 Oct 2021 09:16:47 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id n11-20020a17090a2bcb00b001a1e7a0a6a6so11004987pje.0
        for <linux-ext4@vger.kernel.org>; Fri, 29 Oct 2021 09:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UuiRv/Aqc9KWf66Wmwy2yVHjihLskj+s11srG8q1vD8=;
        b=DDH8LvTf1NbwlDisv+efQao95HUsWm01LKrhjJ2uX5etHAjxnlYc1fVorsh9C2tZeZ
         IZjJyefUE9sV7SNEI3aifqWin72xUpU2BtMndIJi3ywQQBX2XMdIqeYY8510szP8t2sH
         kdBhiAG5maV3WHr8hudaPmgocYD17sC0B0D26/b8Pbwzr3F117FlSlFBx3SQdqHiOhCS
         AzK0mVaRm+n9lGW4xPZYMjIFamXjTmcm5QI7QOVxfQm9omv4teemj/fppXRavbXh1qYb
         2mUwDH8Lkp2dgVW/pz350uqfUJeZ+MOAK0wy10AUYRh1hsJJ2oVH6yHtRzop5uS3RMQt
         86wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UuiRv/Aqc9KWf66Wmwy2yVHjihLskj+s11srG8q1vD8=;
        b=oc19kosH0n8VuecOYn6NSYGQDDI0RmwplzQzmI3QXZ6PfXBg3pNZNrMOkrW9/LCT5E
         wJga4WvCRwTD0IZF/OZit0NlK9z226q2liDfz62OA2lemGz5nNePCxd92FZYHSyiiSzd
         f8zAodyzcgdxmkWSYB88IdXr53vBiEhdBn8+RrhKogpla3Tnn/iu6VWkxqbVBzNW3NU5
         vLIqf6V/EamqyqAqH9wSAIL2lZJFvaTmfQfqiO79CP687YQDMcwJoW1nMwewtQ7Ulu9o
         HQCcEz7KxoUM54RO4cwkiRgUXY3fEWjAul2f3axcgz22+BiruVwOf+TSqpJe4vZGiI7m
         GFXw==
X-Gm-Message-State: AOAM530B5ihu12aQK3vOfrVLiw/9Xla112HiaLp3DaPi22AwIW5KslmI
        6BPyOXMkPq2mav2UcxZnaGYiVt7rS7kEi1qR7NR/qg==
X-Google-Smtp-Source: ABdhPJy6oDDE8Tua+O/7LJsaoOuN022Twl1T27YRaF2rK5Jgwv2I/UmljReJn3ItDXvNR8dsDNU53ltbLhzG+bw6RwY=
X-Received: by 2002:a17:90b:350f:: with SMTP id ls15mr12425415pjb.220.1635524207375;
 Fri, 29 Oct 2021 09:16:47 -0700 (PDT)
MIME-Version: 1.0
References: <20211018044054.1779424-1-hch@lst.de> <CAPcyv4iEt78-XSsKjTWcpy71zaduXyyigTro6f3fmRqqFOG98Q@mail.gmail.com>
 <20211029105139.1194bb7f@canb.auug.org.au> <CAPcyv4g8iEyN5UN1w1xBqQDYSb3HCh7_smsmjt-PiHORRK+X9Q@mail.gmail.com>
 <20211029155524.GE24307@magnolia>
In-Reply-To: <20211029155524.GE24307@magnolia>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 29 Oct 2021 09:16:35 -0700
Message-ID: <CAPcyv4hL7ox5a7L7pBs-uoj_h+9F7E_nBs-qnJKBbJ7PHpWAjw@mail.gmail.com>
Subject: Re: futher decouple DAX from block devices
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Christoph Hellwig <hch@lst.de>,
        Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Ira Weiny <ira.weiny@intel.com>,
        device-mapper development <dm-devel@redhat.com>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-erofs@lists.ozlabs.org,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Oct 29, 2021 at 8:55 AM Darrick J. Wong <djwong@kernel.org> wrote:
>
> On Fri, Oct 29, 2021 at 08:42:29AM -0700, Dan Williams wrote:
> > On Thu, Oct 28, 2021 at 4:52 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > >
> > > Hi Dan,
> > >
> > > On Wed, 27 Oct 2021 13:46:31 -0700 Dan Williams <dan.j.williams@intel.com> wrote:
> > > >
> > > > My merge resolution is here [1]. Christoph, please have a look. The
> > > > rebase and the merge result are both passing my test and I'm now going
> > > > to review the individual patches. However, while I do that and collect
> > > > acks from DM and EROFS folks, I want to give Stephen a heads up that
> > > > this is coming. Primarily I want to see if someone sees a better
> > > > strategy to merge this, please let me know, but if not I plan to walk
> > > > Stephen and Linus through the resolution.
> > >
> > > It doesn't look to bad to me (however it is a bit late in the cycle :-(
> > > ).  Once you are happy, just put it in your tree (some of the conflicts
> > > are against the current -rc3 based version of your tree anyway) and I
> > > will cope with it on Monday.
> >
> > Christoph, Darrick, Shiyang,
> >
> > I'm losing my nerve to try to jam this into v5.16 this late in the
> > cycle.
>
> Always a solid choice to hold off for a little more testing and a little
> less anxiety. :)
>
> I don't usually accept new code patches for iomap after rc4 anyway.
>
> > I do want to get dax+reflink squared away as soon as possible,
> > but that looks like something that needs to build on top of a
> > v5.16-rc1 at this point. If Linus does a -rc8 then maybe it would have
> > enough soak time, but otherwise I want to take the time to collect the
> > acks and queue up some more follow-on cleanups to prepare for
> > block-less-dax.
>
> I think that hwpoison-calls-xfs-rmap patchset is a prerequisite for
> dax+reflink anyway, right?  /me had concluded both were 5.17 things.

Ok, cool, sounds like a plan.
