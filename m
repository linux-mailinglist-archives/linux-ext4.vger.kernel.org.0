Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC2A278EFE
	for <lists+linux-ext4@lfdr.de>; Fri, 25 Sep 2020 18:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728353AbgIYQr5 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 25 Sep 2020 12:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727982AbgIYQr5 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 25 Sep 2020 12:47:57 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23DE3C0613D4
        for <linux-ext4@vger.kernel.org>; Fri, 25 Sep 2020 09:47:57 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id v23so3038152ljd.1
        for <linux-ext4@vger.kernel.org>; Fri, 25 Sep 2020 09:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rzPzwRJveHSctwZp3wrT4wsJ+vKh/2WbdUB6RmJgiVQ=;
        b=mVEYFWer0WJ/V7bBTxWewvWswsOXfCvL4L67MAfo71n9MaavrHxr+gH++cMXtE0aCc
         tjiNi8kvFv/h+VZhpRaOEIH4QFJvGTljbwrgnPn2eKNoBqS+R4vlb9jJ/fq1Ivf4sidk
         AMv0GQD4cHBrQczMW5xZ6oBfg/2a6KMKfxVF4iBnkFG9ZA6OievpgshAx1tehNUJOpf/
         LhhyvgYhZuJICk7pnWzPUqH00A89KidWyOpxfGK/awCwLm35sfl0uF+Sqlgx1dmO9TQq
         xP88/mqY+5yYrhRlYUiFgXui98azowaWrX+h/Uhq7Pjj2ZyDWT+cl370XigGl2Q+uKUs
         kwzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rzPzwRJveHSctwZp3wrT4wsJ+vKh/2WbdUB6RmJgiVQ=;
        b=T8JQSvFhOKWpeTUiiWZhQ6sYU5k0KHvKWQXbgBmpem1QoWUHdJIJU3U9OjpSCzEZ6G
         0fB55qm6np46dAy4mkb75E8HCn7pGRO08XiIVurYwaoMM7cLVkTYfQ4UTzQBi+kTxIdD
         kw5W9rwSky4dP4sW+YJteu03xzSSlt33mxk5ckxq0pEfmtjkm6qjKD57w/MsTZq47V5o
         Vo8xaoZdueUeci/oGHIMle5tGphLetBHMXzLxHIDZ4RtqvgiJdZ50w2ob5RFliTX5I/U
         Ix6VVv26RlElCuEi9Q8mCCOQ1QRGg68hXrHBGpaD/sLKsGiey9iZE/l/v48qUuqk98yU
         5aiQ==
X-Gm-Message-State: AOAM533esNOq5S2/RlWy00bh3ve6f6eUJsbQS/usfzCHE7GgPRMlFYML
        4WU4zIx1Ol7lUO5OWU0vWJiM+FsaQdJoTIRFHC+6oA==
X-Google-Smtp-Source: ABdhPJwJx0cGU4uB4elPs7ZF82yVS4VWNXuQL+KAAN+7j7jvra3jAOYCv6pmtiH02Yvg+WFL6sMc1f67KGybV/4BiBs=
X-Received: by 2002:a2e:3511:: with SMTP id z17mr1525178ljz.58.1601052475022;
 Fri, 25 Sep 2020 09:47:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200915073303.GA754106@T590> <20200915224541.GB38283@mit.edu>
 <20200915230941.GA791425@T590> <20200916202026.GC38283@mit.edu>
 <20200917022051.GA1004828@T590> <20200917143012.GF38283@mit.edu>
 <20200924005901.GB1806978@T590> <20200924143345.GD482521@mit.edu>
 <20200925011311.GJ482521@mit.edu> <20200925073145.GC2388140@T590>
 <20200925161918.GD2388140@T590> <CALvZod6QUvmD_3xf0FM4qt=9YT=nwuMV3ZqFayND+dUp9oQUsQ@mail.gmail.com>
In-Reply-To: <CALvZod6QUvmD_3xf0FM4qt=9YT=nwuMV3ZqFayND+dUp9oQUsQ@mail.gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 25 Sep 2020 09:47:43 -0700
Message-ID: <CALvZod4uLs399uGh89RV=QsjOXu0-iFLW8ifgWjC9N6OpRqu-w@mail.gmail.com>
Subject: Re: REGRESSION: 37f4a24c2469: blk-mq: centralise related handling
 into blk_mq_get_driver_tag
To:     Ming Lei <ming.lei@redhat.com>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>, Jens Axboe <axboe@kernel.dk>,
        linux-ext4@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>, Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Sep 25, 2020 at 9:32 AM Shakeel Butt <shakeelb@google.com> wrote:
>
> On Fri, Sep 25, 2020 at 9:19 AM Ming Lei <ming.lei@redhat.com> wrote:
> >
> > On Fri, Sep 25, 2020 at 03:31:45PM +0800, Ming Lei wrote:
> > > On Thu, Sep 24, 2020 at 09:13:11PM -0400, Theodore Y. Ts'o wrote:
> > > > On Thu, Sep 24, 2020 at 10:33:45AM -0400, Theodore Y. Ts'o wrote:
> > > > > HOWEVER, thanks to a hint from a colleague at $WORK, and realizing
> > > > > that one of the stack traces had virtio balloon in the trace, I
> > > > > realized that when I switched the GCE VM type from e1-standard-2 to
> > > > > n1-standard-2 (where e1 VM's are cheaper because they use
> > > > > virtio-balloon to better manage host OS memory utilization), problem
> > > > > has become, much, *much* rarer (and possibly has gone away, although
> > > > > I'm going to want to run a lot more tests before I say that
> > > > > conclusively) on my test setup.  At the very least, using an n1 VM
> > > > > (which doesn't have virtio-balloon enabled in the hypervisor) is
> > > > > enough to unblock ext4 development.
> > > >
> > > > .... and I spoke too soon.  A number of runs using -rc6 are now
> > > > failing even with the n1-standard-2 VM, so virtio-ballon may not be an
> > > > indicator.
> > > >
> > > > This is why debugging this is frustrating; it is very much a heisenbug
> > > > --- although 5.8 seems to work completely reliably, as does commits
> > > > before 37f4a24c2469.  Anything after that point will show random
> > > > failures.  :-(
> > >
> > > It does not make sense to mention 37f4a24c2469, which is reverted in
> > > 4e2f62e566b5. Later the patch in 37f4a24c2469 is fixed and re-commited
> > > as 568f27006577.
> > >
> > > However, I can _not_ reproduce the issue by running the same test on
> > > kernel built from 568f27006577 directly.
> > >
> > > Also you have confirmed that the issue can't be fixed after reverting
> > > 568f27006577 against v5.9-rc4.
> > >
> > > Looks the real issue(slab list corruption) should be introduced between
> > > 568f27006577 and v5.9-rc4.
> >
> > git bisect shows the first bad commit:
> >
> >         [10befea91b61c4e2c2d1df06a2e978d182fcf792] mm: memcg/slab: use a single set of
> >                 kmem_caches for all allocations
> >
> > And I have double checked that the above commit is really the first bad
> > commit for the list corruption issue of 'list_del corruption, ffffe1c241b00408->next
> > is LIST_POISON1 (dead000000000100)', see the detailed stack trace and
> > kernel oops log in the following link:
> >
> >         https://lore.kernel.org/lkml/20200916202026.GC38283@mit.edu/
>
> The failure signature is similar to
> https://lore.kernel.org/lkml/20200901075321.GL4299@shao2-debian/
>
> >
> > And the kernel config is the one(without KASAN) used by Theodore in GCE VM, see
> > the following link:
> >
> >         https://lore.kernel.org/lkml/20200917143012.GF38283@mit.edu/
> >
> > The reproducer is xfstests generic/038. In my setting, test device is virtio-scsi, and
> > scratch device is virtio-blk.

Is it possible to check SLUB as well to confirm that the issue is only
happening on SLAB?
