Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC0FA6D1401
	for <lists+linux-ext4@lfdr.de>; Fri, 31 Mar 2023 02:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbjCaA2m (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 30 Mar 2023 20:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjCaA2l (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 30 Mar 2023 20:28:41 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C57CD50E
        for <linux-ext4@vger.kernel.org>; Thu, 30 Mar 2023 17:28:37 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id ek18so83472935edb.6
        for <linux-ext4@vger.kernel.org>; Thu, 30 Mar 2023 17:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1680222516;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=w7dl68YTP8S4RiqY+x5/O4+CnLGy3Xe6lC7eIC5NDDg=;
        b=PhAYbwPy35eETQ0T2sb+4uUQOE4bGTTwv/9/foSuSQdxt4FCC/HShz676Im8BKWf+v
         JWhMbjfmzEBsEVa5qn/yUlL7dT+G/AI5P44sdIAplnJoH1nMdjYfexlR8+YtSXJeX2pV
         8+T5ASy6fIapdmpPERWgDQIyq4aTi0U93oYFo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680222516;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w7dl68YTP8S4RiqY+x5/O4+CnLGy3Xe6lC7eIC5NDDg=;
        b=KH/WDbrepKfWWT8SiXnJGqah4i2cUt72z/V3cXgV3qlwyL6EX/Erf16cgNePzcd5Xp
         MCht6GOxpy8iKjtEEDEW2slqGXkteqdKx9x70Ml3wuF7BAuuQGI2aJkZ8Dv/WnrEDygv
         3GTJZSMpXMurlv9t8+dKwbp5MOlXzByEFT+YJYENYUwUI0H2iDiRSgG0z4qFz6QdsK5M
         D6XrDCga4ZyO0E6L7ohPUwJtmPD3yUcmCK5UkiPO9inDKHTql5HKhq3X5E4aZ6kq0uU5
         XXhn0f1Wdm6sw0AJENtSYNmmzSzmfdwQS3e4FOwqBrjWz5PfZLYClNBOaqzLQYh+ML5T
         nH8g==
X-Gm-Message-State: AAQBX9f68q08HqAcDD7y7bxS/zPtMuVhyRaxaWxROYPaaA7Z9b6BHlAo
        3rdleX3neSYKbGL0nV/iSHMvk6/V6h131wPuKxVQBw==
X-Google-Smtp-Source: AKy350ZIZZwE4fLa4HZv1js37+8o+PrWKNL6H2rNaVFNqrxiQJtozdJH9Zs/S2MKN7ANFXMBy3cE+ohRFiJy6VmDOrg=
X-Received: by 2002:a17:907:a0cd:b0:947:4b15:51e5 with SMTP id
 hw13-20020a170907a0cd00b009474b1551e5mr2382830ejc.2.1680222515827; Thu, 30
 Mar 2023 17:28:35 -0700 (PDT)
MIME-Version: 1.0
References: <20221229081252.452240-1-sarthakkukreti@chromium.org>
 <20221229081252.452240-4-sarthakkukreti@chromium.org> <Y7Wr2uadI+82BB6a@magnolia>
 <CAG9=OMNbeU=Xg5bWvHUSfzRf8vsk6csvcw5BGZeMD5Lo7dfKFQ@mail.gmail.com> <Y7biricgMfXxcQBU@bfoster>
In-Reply-To: <Y7biricgMfXxcQBU@bfoster>
From:   Sarthak Kukreti <sarthakkukreti@chromium.org>
Date:   Thu, 30 Mar 2023 17:28:25 -0700
Message-ID: <CAG9=OMNZYnd=LZSiThL9JDFHBvqSwFQLni2=+VgXdrbx7L1fJA@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] fs: Introduce FALLOC_FL_PROVISION
To:     Brian Foster <bfoster@redhat.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>, sarthakkukreti@google.com,
        dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Bart Van Assche <bvanassche@google.com>,
        Daniil Lunev <dlunev@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Jan 5, 2023 at 6:45 AM Brian Foster <bfoster@redhat.com> wrote:
>
> On Wed, Jan 04, 2023 at 01:22:06PM -0800, Sarthak Kukreti wrote:
> > (Resend; the text flow made the last reply unreadable)
> >
> > On Wed, Jan 4, 2023 at 8:39 AM Darrick J. Wong <djwong@kernel.org> wrote:
> > >
> > > On Thu, Dec 29, 2022 at 12:12:48AM -0800, Sarthak Kukreti wrote:
> > > > FALLOC_FL_PROVISION is a new fallocate() allocation mode that
> > > > sends a hint to (supported) thinly provisioned block devices to
> > > > allocate space for the given range of sectors via REQ_OP_PROVISION.
> > > >
> > > > The man pages for both fallocate(2) and posix_fallocate(3) describe
> > > > the default allocation mode as:
> > > >
> > > > ```
> > > > The default operation (i.e., mode is zero) of fallocate()
> > > > allocates the disk space within the range specified by offset and len.
> > > > ...
> > > > subsequent writes to bytes in the specified range are guaranteed
> > > > not to fail because of lack of disk space.
> > > > ```
> > > >
> > > > For thinly provisioned storage constructs (dm-thin, filesystems on sparse
> > > > files), the term 'disk space' is overloaded and can either mean the apparent
> > > > disk space in the filesystem/thin logical volume or the true disk
> > > > space that will be utilized on the underlying non-sparse allocation layer.
> > > >
> > > > The use of a separate mode allows us to cleanly disambiguate whether fallocate()
> > > > causes allocation only at the current layer (default mode) or whether it propagates
> > > > allocations to underlying layers (provision mode)
> > >
> > > Why is it important to make this distinction?  The outcome of fallocate
> > > is supposed to be that subsequent writes do not fail with ENOSPC.  In my
> > > (fs developer) mind, REQ_OP_PROVISION simply an extra step to be taken
> > > after allocating file blocks.
> > >
> > Some use cases still benefit from keeping the default mode - eg.
> > virtual machines running on massive storage pools that don't expect to
> > hit the storage limit anytime soon (like most cloud storage
> > providers). Essentially, if the 'no ENOSPC' guarantee is maintained
> > via other means, then REQ_OP_PROVISION adds latency that isn't needed
> > (and cloud storage providers don't need to set aside that extra space
> > that may or may not be used).
> >
>
> What's the granularity that needs to be managed at? Do you really need
> an fallocate command for this, or would one of the filesystem level
> features you've already implemented for ext4 suffice?
>
I think I (belatedly) see the point now; the other mechanisms provide
enough flexibility that make a separate FALLOC_FL_PROVISION redundant
and confusing. I'll post the next series without the falloc() flag.

> I mostly agree with Darrick in that FALLOC_FL_PROVISION stills feels a
> bit wonky to me. I can see that there might be some legitimate use cases
> for it, but I'm not convinced that it won't just end up being confusing
> to many users. At the same time, I think the approach of unconditional
> provision on falloc could eventually lead to complaints associated with
> the performance impact or similar sorts of confusion. For example,
> should an falloc of an already allocated range in the fs send a
> provision or not?
>
It boils down to whether a) the underlying device supports
provisioning and b) whether the device is a snapshot. If either is
true, then we'd need to pass down provision requests down to the last
layers of the stack. Filesystems might be able to amortize some of the
performance drop if they maintain a bit that tracks whether the extent
has been provisioned/written to; for such extents, we'd only send a
provision request iff the underlying device is a snapshot device. Or
we could make this a policy that's configurable by a mount option
(added details below).

In the current patch series, I went through the simpler route of just
calling REQ_OP_PROVISION on the first fallocate() call. But as
everyone pointed out on the thread, that doesn't work out as well for
previously allocated ranges..

> [Reflowed] Should filesystems that don't otherwise support
> UNSHARE_RANGE need to support it in order to support an unshare request
> to COW'd blocks on an underlying block device?
>
I think it would make sense to keep the UNSHARE_RANGE handling intact
and delegate the actual provisioning to the filesystem layer. Even if
the filesystem doesn't support unsharing, we could add a separate
mount mode option that will result in the filesystem sending
REQ_OP_PROVISION to the entire file range if fallocate mode==0 is
called.

> I wonder if the smart thing to do here is separate out the question of a
> new fallocate interface from the mechanism entirely. For example,
> implement REQ_OP_PROVISION as you've already done, enable block layer
> mode = 0 fallocate support (i.e. without FL_PROVISION, so whether a
> request propagates from a loop device will be up to the backing fs),
> implement the various fs features to support REQ_OP_PROVISION (i.e.,
> mount option, file attr, etc.), then tack on FL_FALLOC + ext4 support at
> the end as an RFC/prototype.
>
> Even if we ultimately ended up with FL_PROVISION support, it might
> actually make some sense to kick that can down the road a bit regardless
> to give fs' a chance to implement basic REQ_OP_PROVISION support, get a
> better understanding of how it works in practice, and then perhaps make
> more informed decisions on things like sane defaults and/or how best to
> expose it via fallocate. Thoughts?
>
That's fair (and thanks for the thorough feedback!), I'll split the
series and send out the REQ_OP_PROVISION parts shortly. As you,
Darrick and Ted have pointed out, the filesystem patches need a bit
more work.

Best
Sarthak



> Brian
>
> > > If you *don't* add this API flag and simply bake the REQ_OP_PROVISION
> > > call into mode 0 fallocate, then the new functionality can be added (or
> > > even backported) to existing kernels and customers can use it
> > > immediately.  If you *do*, then you get to wait a few years for
> > > developers to add it to their codebases only after enough enterprise
> > > distros pick up a new kernel to make it worth their while.
> > >
> > > > for thinly provisioned filesystems/
> > > > block devices. For devices that do not support REQ_OP_PROVISION, both these
> > > > allocation modes will be equivalent. Given the performance cost of sending provision
> > > > requests to the underlying layers, keeping the default mode as-is allows users to
> > > > preserve existing behavior.
> > >
> > > How expensive is this expected to be?  Is this why you wanted a separate
> > > mode flag?
> > >
> > Yes, the exact latency will depend on the stacked block devices and
> > the fragmentation at the allocation layers.
> >
> > I did a quick test for benchmarking fallocate() with an:
> > A) ext4 filesystem mounted with 'noprovision'
> > B) ext4 filesystem mounted with 'provision' on a dm-thin device.
> > C) ext4 filesystem mounted with 'provision' on a loop device with a
> > sparse backing file on the filesystem in (B).
> >
> > I tested file sizes from 512M to 8G, time taken for fallocate() in (A)
> > remains expectedly flat at ~0.01-0.02s, but for (B), it scales from
> > 0.03-0.4s and for (C) it scales from 0.04s-0.52s (I captured the exact
> > time distribution in the cover letter
> > https://marc.info/?l=linux-ext4&m=167230113520636&w=2)
> >
> > +0.5s for a 8G fallocate doesn't sound a lot but I think fragmentation
> > and how the block device is layered can make this worse...
> >
> > > --D
> > >
> > > > Signed-off-by: Sarthak Kukreti <sarthakkukreti@chromium.org>
> > > > ---
> > > >  block/fops.c                | 15 +++++++++++----
> > > >  include/linux/falloc.h      |  3 ++-
> > > >  include/uapi/linux/falloc.h |  8 ++++++++
> > > >  3 files changed, 21 insertions(+), 5 deletions(-)
> > > >
> > > > diff --git a/block/fops.c b/block/fops.c
> > > > index 50d245e8c913..01bde561e1e2 100644
> > > > --- a/block/fops.c
> > > > +++ b/block/fops.c
> > > > @@ -598,7 +598,8 @@ static ssize_t blkdev_read_iter(struct kiocb *iocb, struct iov_iter *to)
> > > >
> > > >  #define      BLKDEV_FALLOC_FL_SUPPORTED                                      \
> > > >               (FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE |           \
> > > > -              FALLOC_FL_ZERO_RANGE | FALLOC_FL_NO_HIDE_STALE)
> > > > +              FALLOC_FL_ZERO_RANGE | FALLOC_FL_NO_HIDE_STALE |       \
> > > > +              FALLOC_FL_PROVISION)
> > > >
> > > >  static long blkdev_fallocate(struct file *file, int mode, loff_t start,
> > > >                            loff_t len)
> > > > @@ -634,9 +635,11 @@ static long blkdev_fallocate(struct file *file, int mode, loff_t start,
> > > >       filemap_invalidate_lock(inode->i_mapping);
> > > >
> > > >       /* Invalidate the page cache, including dirty pages. */
> > > > -     error = truncate_bdev_range(bdev, file->f_mode, start, end);
> > > > -     if (error)
> > > > -             goto fail;
> > > > +     if (mode != FALLOC_FL_PROVISION) {
> > > > +             error = truncate_bdev_range(bdev, file->f_mode, start, end);
> > > > +             if (error)
> > > > +                     goto fail;
> > > > +     }
> > > >
> > > >       switch (mode) {
> > > >       case FALLOC_FL_ZERO_RANGE:
> > > > @@ -654,6 +657,10 @@ static long blkdev_fallocate(struct file *file, int mode, loff_t start,
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
> > > > diff --git a/include/linux/falloc.h b/include/linux/falloc.h
> > > > index f3f0b97b1675..b9a40a61a59b 100644
> > > > --- a/include/linux/falloc.h
> > > > +++ b/include/linux/falloc.h
> > > > @@ -30,7 +30,8 @@ struct space_resv {
> > > >                                        FALLOC_FL_COLLAPSE_RANGE |     \
> > > >                                        FALLOC_FL_ZERO_RANGE |         \
> > > >                                        FALLOC_FL_INSERT_RANGE |       \
> > > > -                                      FALLOC_FL_UNSHARE_RANGE)
> > > > +                                      FALLOC_FL_UNSHARE_RANGE |      \
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
> > > > 2.37.3
> > > >
> >
>
