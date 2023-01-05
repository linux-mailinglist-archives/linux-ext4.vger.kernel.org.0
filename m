Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39DAA65EF1A
	for <lists+linux-ext4@lfdr.de>; Thu,  5 Jan 2023 15:46:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233287AbjAEOqC (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 5 Jan 2023 09:46:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233974AbjAEOpy (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 5 Jan 2023 09:45:54 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A513A5017C
        for <linux-ext4@vger.kernel.org>; Thu,  5 Jan 2023 06:45:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672929912;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YbA/NofU1+dEdHrQaFOTbBPTzEi67CbxBxBaGMPpQMk=;
        b=cgMJqHRLDv+NJW3xYSYizdL7vISNj3PM1hxSW6x4iocHDeYxTiNdJgxR7LkRz2w9VEOPN9
        pwLa8VqytI6+VfEA/nYpG4xlNhu6P/YO4+snh8fxfwgZc1GmysgTh6RnGOcp38wfgbJzrZ
        SSL1FO78j7yWgqi3gM18ntd3CC5RU1M=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-338-T2TrvN-6O-KLr1ezASl96w-1; Thu, 05 Jan 2023 09:45:09 -0500
X-MC-Unique: T2TrvN-6O-KLr1ezASl96w-1
Received: by mail-qt1-f199.google.com with SMTP id bb12-20020a05622a1b0c00b003a98dd528f0so13345468qtb.13
        for <linux-ext4@vger.kernel.org>; Thu, 05 Jan 2023 06:45:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YbA/NofU1+dEdHrQaFOTbBPTzEi67CbxBxBaGMPpQMk=;
        b=NwnPO6ZN3uN2powZsA9iGpKofsImE9bN0cTCIZDQre4axVJE5n5s6jl6GdNnTeX3KD
         wOOji0n2Nx/Kx6K7pjUSEsM0rsYO2diVzs6NuC/kuzfSDW6OTZuZNuHeiGsl47Jy41Yi
         VIpCO7fzMrjquMGOGIFpi/PrgXzklBKwAmRPiDrsqwVCB7sAgmvPIAyQ3nnmyq9uOkO7
         tZV8gP2TZD2wubmgWxLdIk3pedSuu/6MJi3Al1sd4BMkyQT+L+Dh6KAd5gSNzQ+jnYzp
         yWsvPv0EOL1FNI/J43Knnp8hFJCD0JboZrmQTgDCmH3nju/FJ3zmbC6W44JJW31YfxcJ
         6m1Q==
X-Gm-Message-State: AFqh2koW2WXR0jzyd45QM3r9oEvhKBFENzMqpPBtR7H5PWzI5vLQcDVG
        LLwHfdk0s+ifHkAbMeMNgLKQ5E9b8cd8rRm/4GR1vqXuMCWnuovvGM5IKyNPFkvdMnykQBqDrXw
        tFt2awWQpBD12LIm9Jnb5Iw==
X-Received: by 2002:ac8:4657:0:b0:3a9:2478:2d70 with SMTP id f23-20020ac84657000000b003a924782d70mr80230727qto.24.1672929908920;
        Thu, 05 Jan 2023 06:45:08 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtrJZcTSAudn8RghxSlOjyqJjB/K2q37f4w3Kj2j8R9LDk3t7bkbLzT5O2ELO+kdO6jtMF8tw==
X-Received: by 2002:ac8:4657:0:b0:3a9:2478:2d70 with SMTP id f23-20020ac84657000000b003a924782d70mr80230699qto.24.1672929908616;
        Thu, 05 Jan 2023 06:45:08 -0800 (PST)
Received: from bfoster (c-24-61-119-116.hsd1.ma.comcast.net. [24.61.119.116])
        by smtp.gmail.com with ESMTPSA id ga27-20020a05622a591b00b0039cd4d87aacsm21718694qtb.15.2023.01.05.06.45.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 06:45:07 -0800 (PST)
Date:   Thu, 5 Jan 2023 09:46:06 -0500
From:   Brian Foster <bfoster@redhat.com>
To:     Sarthak Kukreti <sarthakkukreti@chromium.org>
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
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Bart Van Assche <bvanassche@google.com>,
        Daniil Lunev <dlunev@google.com>
Subject: Re: [PATCH v2 3/7] fs: Introduce FALLOC_FL_PROVISION
Message-ID: <Y7biricgMfXxcQBU@bfoster>
References: <20221229081252.452240-1-sarthakkukreti@chromium.org>
 <20221229081252.452240-4-sarthakkukreti@chromium.org>
 <Y7Wr2uadI+82BB6a@magnolia>
 <CAG9=OMNbeU=Xg5bWvHUSfzRf8vsk6csvcw5BGZeMD5Lo7dfKFQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG9=OMNbeU=Xg5bWvHUSfzRf8vsk6csvcw5BGZeMD5Lo7dfKFQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Jan 04, 2023 at 01:22:06PM -0800, Sarthak Kukreti wrote:
> (Resend; the text flow made the last reply unreadable)
> 
> On Wed, Jan 4, 2023 at 8:39 AM Darrick J. Wong <djwong@kernel.org> wrote:
> >
> > On Thu, Dec 29, 2022 at 12:12:48AM -0800, Sarthak Kukreti wrote:
> > > FALLOC_FL_PROVISION is a new fallocate() allocation mode that
> > > sends a hint to (supported) thinly provisioned block devices to
> > > allocate space for the given range of sectors via REQ_OP_PROVISION.
> > >
> > > The man pages for both fallocate(2) and posix_fallocate(3) describe
> > > the default allocation mode as:
> > >
> > > ```
> > > The default operation (i.e., mode is zero) of fallocate()
> > > allocates the disk space within the range specified by offset and len.
> > > ...
> > > subsequent writes to bytes in the specified range are guaranteed
> > > not to fail because of lack of disk space.
> > > ```
> > >
> > > For thinly provisioned storage constructs (dm-thin, filesystems on sparse
> > > files), the term 'disk space' is overloaded and can either mean the apparent
> > > disk space in the filesystem/thin logical volume or the true disk
> > > space that will be utilized on the underlying non-sparse allocation layer.
> > >
> > > The use of a separate mode allows us to cleanly disambiguate whether fallocate()
> > > causes allocation only at the current layer (default mode) or whether it propagates
> > > allocations to underlying layers (provision mode)
> >
> > Why is it important to make this distinction?  The outcome of fallocate
> > is supposed to be that subsequent writes do not fail with ENOSPC.  In my
> > (fs developer) mind, REQ_OP_PROVISION simply an extra step to be taken
> > after allocating file blocks.
> >
> Some use cases still benefit from keeping the default mode - eg.
> virtual machines running on massive storage pools that don't expect to
> hit the storage limit anytime soon (like most cloud storage
> providers). Essentially, if the 'no ENOSPC' guarantee is maintained
> via other means, then REQ_OP_PROVISION adds latency that isn't needed
> (and cloud storage providers don't need to set aside that extra space
> that may or may not be used).
> 

What's the granularity that needs to be managed at? Do you really need
an fallocate command for this, or would one of the filesystem level
features you've already implemented for ext4 suffice?

I mostly agree with Darrick in that FALLOC_FL_PROVISION stills feels a
bit wonky to me. I can see that there might be some legitimate use cases
for it, but I'm not convinced that it won't just end up being confusing
to many users. At the same time, I think the approach of unconditional
provision on falloc could eventually lead to complaints associated with
the performance impact or similar sorts of confusion. For example,
should an falloc of an already allocated range in the fs send a
provision or not? Should filesystems that don't otherwise support
UNSHARE_RANGE need to support it in order to support an unshare request
to COW'd blocks on an underlying block device?

I wonder if the smart thing to do here is separate out the question of a
new fallocate interface from the mechanism entirely. For example,
implement REQ_OP_PROVISION as you've already done, enable block layer
mode = 0 fallocate support (i.e. without FL_PROVISION, so whether a
request propagates from a loop device will be up to the backing fs),
implement the various fs features to support REQ_OP_PROVISION (i.e.,
mount option, file attr, etc.), then tack on FL_FALLOC + ext4 support at
the end as an RFC/prototype.

Even if we ultimately ended up with FL_PROVISION support, it might
actually make some sense to kick that can down the road a bit regardless
to give fs' a chance to implement basic REQ_OP_PROVISION support, get a
better understanding of how it works in practice, and then perhaps make
more informed decisions on things like sane defaults and/or how best to
expose it via fallocate. Thoughts?

Brian

> > If you *don't* add this API flag and simply bake the REQ_OP_PROVISION
> > call into mode 0 fallocate, then the new functionality can be added (or
> > even backported) to existing kernels and customers can use it
> > immediately.  If you *do*, then you get to wait a few years for
> > developers to add it to their codebases only after enough enterprise
> > distros pick up a new kernel to make it worth their while.
> >
> > > for thinly provisioned filesystems/
> > > block devices. For devices that do not support REQ_OP_PROVISION, both these
> > > allocation modes will be equivalent. Given the performance cost of sending provision
> > > requests to the underlying layers, keeping the default mode as-is allows users to
> > > preserve existing behavior.
> >
> > How expensive is this expected to be?  Is this why you wanted a separate
> > mode flag?
> >
> Yes, the exact latency will depend on the stacked block devices and
> the fragmentation at the allocation layers.
> 
> I did a quick test for benchmarking fallocate() with an:
> A) ext4 filesystem mounted with 'noprovision'
> B) ext4 filesystem mounted with 'provision' on a dm-thin device.
> C) ext4 filesystem mounted with 'provision' on a loop device with a
> sparse backing file on the filesystem in (B).
> 
> I tested file sizes from 512M to 8G, time taken for fallocate() in (A)
> remains expectedly flat at ~0.01-0.02s, but for (B), it scales from
> 0.03-0.4s and for (C) it scales from 0.04s-0.52s (I captured the exact
> time distribution in the cover letter
> https://marc.info/?l=linux-ext4&m=167230113520636&w=2)
> 
> +0.5s for a 8G fallocate doesn't sound a lot but I think fragmentation
> and how the block device is layered can make this worse...
> 
> > --D
> >
> > > Signed-off-by: Sarthak Kukreti <sarthakkukreti@chromium.org>
> > > ---
> > >  block/fops.c                | 15 +++++++++++----
> > >  include/linux/falloc.h      |  3 ++-
> > >  include/uapi/linux/falloc.h |  8 ++++++++
> > >  3 files changed, 21 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/block/fops.c b/block/fops.c
> > > index 50d245e8c913..01bde561e1e2 100644
> > > --- a/block/fops.c
> > > +++ b/block/fops.c
> > > @@ -598,7 +598,8 @@ static ssize_t blkdev_read_iter(struct kiocb *iocb, struct iov_iter *to)
> > >
> > >  #define      BLKDEV_FALLOC_FL_SUPPORTED                                      \
> > >               (FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE |           \
> > > -              FALLOC_FL_ZERO_RANGE | FALLOC_FL_NO_HIDE_STALE)
> > > +              FALLOC_FL_ZERO_RANGE | FALLOC_FL_NO_HIDE_STALE |       \
> > > +              FALLOC_FL_PROVISION)
> > >
> > >  static long blkdev_fallocate(struct file *file, int mode, loff_t start,
> > >                            loff_t len)
> > > @@ -634,9 +635,11 @@ static long blkdev_fallocate(struct file *file, int mode, loff_t start,
> > >       filemap_invalidate_lock(inode->i_mapping);
> > >
> > >       /* Invalidate the page cache, including dirty pages. */
> > > -     error = truncate_bdev_range(bdev, file->f_mode, start, end);
> > > -     if (error)
> > > -             goto fail;
> > > +     if (mode != FALLOC_FL_PROVISION) {
> > > +             error = truncate_bdev_range(bdev, file->f_mode, start, end);
> > > +             if (error)
> > > +                     goto fail;
> > > +     }
> > >
> > >       switch (mode) {
> > >       case FALLOC_FL_ZERO_RANGE:
> > > @@ -654,6 +657,10 @@ static long blkdev_fallocate(struct file *file, int mode, loff_t start,
> > >               error = blkdev_issue_discard(bdev, start >> SECTOR_SHIFT,
> > >                                            len >> SECTOR_SHIFT, GFP_KERNEL);
> > >               break;
> > > +     case FALLOC_FL_PROVISION:
> > > +             error = blkdev_issue_provision(bdev, start >> SECTOR_SHIFT,
> > > +                                            len >> SECTOR_SHIFT, GFP_KERNEL);
> > > +             break;
> > >       default:
> > >               error = -EOPNOTSUPP;
> > >       }
> > > diff --git a/include/linux/falloc.h b/include/linux/falloc.h
> > > index f3f0b97b1675..b9a40a61a59b 100644
> > > --- a/include/linux/falloc.h
> > > +++ b/include/linux/falloc.h
> > > @@ -30,7 +30,8 @@ struct space_resv {
> > >                                        FALLOC_FL_COLLAPSE_RANGE |     \
> > >                                        FALLOC_FL_ZERO_RANGE |         \
> > >                                        FALLOC_FL_INSERT_RANGE |       \
> > > -                                      FALLOC_FL_UNSHARE_RANGE)
> > > +                                      FALLOC_FL_UNSHARE_RANGE |      \
> > > +                                      FALLOC_FL_PROVISION)
> > >
> > >  /* on ia32 l_start is on a 32-bit boundary */
> > >  #if defined(CONFIG_X86_64)
> > > diff --git a/include/uapi/linux/falloc.h b/include/uapi/linux/falloc.h
> > > index 51398fa57f6c..2d323d113eed 100644
> > > --- a/include/uapi/linux/falloc.h
> > > +++ b/include/uapi/linux/falloc.h
> > > @@ -77,4 +77,12 @@
> > >   */
> > >  #define FALLOC_FL_UNSHARE_RANGE              0x40
> > >
> > > +/*
> > > + * FALLOC_FL_PROVISION acts as a hint for thinly provisioned devices to allocate
> > > + * blocks for the range/EOF.
> > > + *
> > > + * FALLOC_FL_PROVISION can only be used with allocate-mode fallocate.
> > > + */
> > > +#define FALLOC_FL_PROVISION          0x80
> > > +
> > >  #endif /* _UAPI_FALLOC_H_ */
> > > --
> > > 2.37.3
> > >
> 

