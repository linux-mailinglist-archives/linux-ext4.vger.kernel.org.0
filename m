Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6045E5CDC
	for <lists+linux-ext4@lfdr.de>; Thu, 22 Sep 2022 10:04:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbiIVIEv (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 22 Sep 2022 04:04:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbiIVIEt (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 22 Sep 2022 04:04:49 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD02A14D1F
        for <linux-ext4@vger.kernel.org>; Thu, 22 Sep 2022 01:04:46 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id hy2so15517010ejc.8
        for <linux-ext4@vger.kernel.org>; Thu, 22 Sep 2022 01:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=bQFLgTcLz9TuLH0amhPimE3+FHgwiRo1jLNErCwcRKI=;
        b=IM2aVBVTrkJYH3pfIZPMyJlT72QqAUw1tL+UQniAlh0tq2VK1yij83nhocGtFr29gg
         QioKbP7UrRVnotT3R6tcEREUzqMKx3e16n+IfUX1D5oC98ihoOnDcTsSXXJmXqQ7jXIq
         WUpSJiKl+tzTr2j+VU7Bnkmqu0jf5X8dcC2SQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=bQFLgTcLz9TuLH0amhPimE3+FHgwiRo1jLNErCwcRKI=;
        b=VlhtNEPYe+Lp9NWOgn0rdb4sKeCLaUEyv89A2bDr0+QuFpLp3ZZnxCyrCB/zLoTB6u
         jN7ZOgcqHFSdQErJzJdUKunbr9Yu4OOW4GcdiNNrY/tOjyOQmFEd+iBQBL/DTtDx4h8A
         m2curdmDeR1MCeuiIu7DTpTMzYGBFQaXsZ1GKIfGV37LDKPqNF2OEG9nqnAKoruYknjR
         4To4L1zj1KonbJ4G7TqCiEwZ4lpzewla3S9Hnn0eYDcqBewdqO4Gv4i9wAlnQactm4gX
         CDcmwNALsz49GNn9R6oznhItU0mzaGn4QQ409ZVFQSI8fZ8KHkbv4uROYIRvR+BENHru
         yS1w==
X-Gm-Message-State: ACrzQf2t3/3kkyqXOQBadf+4B123sKgkvALixZUtOIemfUtcybx5Tfs9
        JrAybmrQKlBXk1iVg/vxVjLj6I3p6Nu1hB2dvY3b6w==
X-Google-Smtp-Source: AMsMyM65W61199SNxMqK09DcJ8Cd+xiA/j5JaId5SNxyXyYW8/axB0uzEetY87KS6GvcJQCtWboffhiIXBtl4fzF85I=
X-Received: by 2002:a17:907:968d:b0:782:66dc:4b89 with SMTP id
 hd13-20020a170907968d00b0078266dc4b89mr466943ejc.386.1663833885268; Thu, 22
 Sep 2022 01:04:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220915164826.1396245-1-sarthakkukreti@google.com>
 <20220915164826.1396245-5-sarthakkukreti@google.com> <YyRkd8YAH1lal8/N@bfoster>
 <CAG9=OMNL1Z3DiO-usdH0k90NDsDkDQ7A7CHc4Nu6MCXKNKjWdw@mail.gmail.com> <YyswI57JH7gcs9+S@bfoster>
In-Reply-To: <YyswI57JH7gcs9+S@bfoster>
From:   Sarthak Kukreti <sarthakkukreti@chromium.org>
Date:   Thu, 22 Sep 2022 01:04:33 -0700
Message-ID: <CAG9=OMPEoShYMx6A+p97-tw4MuLpgOEpy7aFs5CH6wTedptALQ@mail.gmail.com>
Subject: Re: [PATCH RFC 4/8] fs: Introduce FALLOC_FL_PROVISION
To:     Brian Foster <bfoster@redhat.com>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Jens Axboe <axboe@kernel.dk>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Bart Van Assche <bvanassche@google.com>,
        Daniil Lunev <dlunev@google.com>,
        Evan Green <evgreen@google.com>,
        Gwendal Grignou <gwendal@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Sep 21, 2022 at 8:39 AM Brian Foster <bfoster@redhat.com> wrote:
>
> On Fri, Sep 16, 2022 at 02:02:31PM -0700, Sarthak Kukreti wrote:
> > On Fri, Sep 16, 2022 at 4:56 AM Brian Foster <bfoster@redhat.com> wrote:
> > >
> > > On Thu, Sep 15, 2022 at 09:48:22AM -0700, Sarthak Kukreti wrote:
> > > > From: Sarthak Kukreti <sarthakkukreti@chromium.org>
> > > >
> > > > FALLOC_FL_PROVISION is a new fallocate() allocation mode that
> > > > sends a hint to (supported) thinly provisioned block devices to
> > > > allocate space for the given range of sectors via REQ_OP_PROVISION.
> > > >
> > > > Signed-off-by: Sarthak Kukreti <sarthakkukreti@chromium.org>
> > > > ---
> > > >  block/fops.c                | 7 ++++++-
> > > >  include/linux/falloc.h      | 3 ++-
> > > >  include/uapi/linux/falloc.h | 8 ++++++++
> > > >  3 files changed, 16 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/block/fops.c b/block/fops.c
> > > > index b90742595317..a436a7596508 100644
> > > > --- a/block/fops.c
> > > > +++ b/block/fops.c
> > > ...
> > > > @@ -661,6 +662,10 @@ static long blkdev_fallocate(struct file *file, int mode, loff_t start,
> > > >               error = blkdev_issue_discard(bdev, start >> SECTOR_SHIFT,
> > > >                                            len >> SECTOR_SHIFT, GFP_KERNEL);
> > > >               break;
> > > > +     case FALLOC_FL_PROVISION:
> > > > +             error = blkdev_issue_provision(bdev, start >> SECTOR_SHIFT,
> > > > +                                            len >> SECTOR_SHIFT, GFP_KERNEL);
> > > > +             break;
> > > >       default:
> > > >               error = -EOPNOTSUPP;
> > > >       }
> > >
> > > Hi Sarthak,
> > >
> > > Neat mechanism.. I played with something very similar in the past (that
> > > was much more crudely hacked up to target dm-thin) to allow filesystems
> > > to request a thinly provisioned device to allocate blocks and try to do
> > > a better job of avoiding inactivation when overprovisioned.
> > >
> > > One thing I'm a little curious about here.. what's the need for a new
> > > fallocate mode? On a cursory glance, the provision mode looks fairly
> > > analogous to normal (mode == 0) allocation mode with the exception of
> > > sending the request down to the bdev. blkdev_fallocate() already maps
> > > some of the logical falloc modes (i.e. punch hole, zero range) to
> > > sending write sames or discards, etc., and it doesn't currently look
> > > like it supports allocation mode, so could it not map such requests to
> > > the underlying REQ_OP_PROVISION op?
> > >
> > > I guess the difference would be at the filesystem level where we'd
> > > probably need to rely on a mount option or some such to control whether
> > > traditional fallocate issues provision ops (like you've implemented for
> > > ext4) vs. the specific falloc command, but that seems fairly consistent
> > > with historical punch hole/discard behavior too. Hm? You might want to
> > > cc linux-fsdevel in future posts in any event to get some more feedback
> > > on how other filesystems might want to interact with such a thing.
> > >
> > Thanks for the feedback!
> > Argh, I completely forgot that I should add linux-fsdevel. Let me
> > re-send this with linux-fsdevel cc'd
> >
> > There's a slight distinction is that the current filesystem-level
> > controls are usually for default handling, but userspace can still
> > call the relevant functions manually if they need to. For example, for
> > ext4, the 'discard' mount option dictates whether free blocks are
> > discarded, but it doesn't set the policy to allow/disallow userspace
> > from manually punching holes into files even if the mount opt is
> > 'nodiscard'. FALLOC_FL_PROVISION is similar in that regard; it adds a
> > manual mechanism for users to provision the files' extents, that is
> > separate from the filesystems' default handling of provisioning files.
> >
>
> What I'm trying to understand is why not let blkdev_fallocate() issue a
> provision based on the default mode (i.e. mode == 0) of fallocate(),
> which is already defined to mean "perform allocation?" It currently
> issues discards or write zeroes based on variants of
> FALLOC_FL_PUNCH_HOLE without the need for a separate FALLOC_FL_DISCARD
> mode, for example.
>
It's mostly to keep the block device fallocate() semantics in-line and
consistent with the file-specific modes: I added the separate
filesystem fallocate() mode under the assumption that we'd want to
keep the traditional handling for filesystems intact with (mode == 0).
And for block devices, I didn't map the requests to mode == 0 so that
it's less confusing to describe (eg. mode == 0 on block devices will
issue provision; mode == 0 on files will not). It would complicate
loopback devices, for instance; if the loop device is backed by a
file, it would need to use (mode == FALLOC_FL_PROVISION) but if the
loop device is backed by another block device, then the fallocate()
call would need to switch to (mode == 0).

With the separate mode, we can describe the semantics of falllcate()
modes a bit more cleanly, and it is common for both files and block
devices:

1. mode == 0: allocation at the same layer, will not provision on the
underlying device/filesystem (unsupported for block devices).
2. mode == FALLOC_FL_PROVISION, allocation at the layer, will
provision on the underlying device/filesystem.

Block devices don't technically need to use a separate mode, but it
makes it much less confusing if filesystems are already using a
separate mode for provision.

Best
Sarthak

> Brian
>
> > > BTW another thing that might be useful wrt to dm-thin is to support
> > > FALLOC_FL_UNSHARE. I.e., it looks like the previous dm-thin patch only
> > > checks that blocks are allocated, but not whether those blocks are
> > > shared (re: lookup_result.shared). It might be useful to do the COW in
> > > such cases if the caller passes down a REQ_UNSHARE or some such flag.
> > >
> > That's an interesting idea! There's a few more things on the TODO list
> > for this patch series but I think we can follow up with a patch to
> > handle that as well.
> >
> > Sarthak
> >
> > > Brian
> > >
> > > > diff --git a/include/linux/falloc.h b/include/linux/falloc.h
> > > > index f3f0b97b1675..a0e506255b20 100644
> > > > --- a/include/linux/falloc.h
> > > > +++ b/include/linux/falloc.h
> > > > @@ -30,7 +30,8 @@ struct space_resv {
> > > >                                        FALLOC_FL_COLLAPSE_RANGE |     \
> > > >                                        FALLOC_FL_ZERO_RANGE |         \
> > > >                                        FALLOC_FL_INSERT_RANGE |       \
> > > > -                                      FALLOC_FL_UNSHARE_RANGE)
> > > > +                                      FALLOC_FL_UNSHARE_RANGE |                          \
> > > > +                                      FALLOC_FL_PROVISION)
> > > >
> > > >  /* on ia32 l_start is on a 32-bit boundary */
> > > >  #if defined(CONFIG_X86_64)
> > > > diff --git a/include/uapi/linux/falloc.h b/include/uapi/linux/falloc.h
> > > > index 51398fa57f6c..2d323d113eed 100644
> > > > --- a/include/uapi/linux/falloc.h
> > > > +++ b/include/uapi/linux/falloc.h
> > > > @@ -77,4 +77,12 @@
> > > >   */
> > > >  #define FALLOC_FL_UNSHARE_RANGE              0x40
> > > >
> > > > +/*
> > > > + * FALLOC_FL_PROVISION acts as a hint for thinly provisioned devices to allocate
> > > > + * blocks for the range/EOF.
> > > > + *
> > > > + * FALLOC_FL_PROVISION can only be used with allocate-mode fallocate.
> > > > + */
> > > > +#define FALLOC_FL_PROVISION          0x80
> > > > +
> > > >  #endif /* _UAPI_FALLOC_H_ */
> > > > --
> > > > 2.31.0
> > > >
> > >
> >
>
