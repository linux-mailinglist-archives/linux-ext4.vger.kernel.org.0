Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71BCA5E6B07
	for <lists+linux-ext4@lfdr.de>; Thu, 22 Sep 2022 20:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232670AbiIVSc3 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 22 Sep 2022 14:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232709AbiIVScA (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 22 Sep 2022 14:32:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C33413EA1
        for <linux-ext4@vger.kernel.org>; Thu, 22 Sep 2022 11:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663871382;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=S6tJUCgYaZdA91WGecG3Omdxk6C0Sput3VYlk3b1RhA=;
        b=Gt2JtkcpHh1qeMaekK+43dkXaj9hFWeU7xf2Bw28Yy3A65Jas3m4NO/sRr2xOzxV6xfLV9
        zvhrKYL2x76+d1EVCHUMFFjZ9KzszrimWN2dDM5UVTohK7FCl4kJ7QzALgMdcCaIHouZvk
        fF86+Y6g4rTDVq7Fo8Z5Un4i6mBXSeA=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-400-JjNDQgwINje3amYoJo9_4A-1; Thu, 22 Sep 2022 14:29:41 -0400
X-MC-Unique: JjNDQgwINje3amYoJo9_4A-1
Received: by mail-qk1-f197.google.com with SMTP id w10-20020a05620a444a00b006ce9917ea1fso7241602qkp.16
        for <linux-ext4@vger.kernel.org>; Thu, 22 Sep 2022 11:29:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=S6tJUCgYaZdA91WGecG3Omdxk6C0Sput3VYlk3b1RhA=;
        b=YoafCEOyg/9kTb7sJgm3c6jHRYEzegyb8gde+1ocghv0uZM8Koo9GkLEMfGIAcVS3I
         9D6rgKuxWuSx+ekQlCshTmDCIuWoFqC8987kOkSYVVB/GjpLFsnFTwKx6kV6KVKBAtva
         WBbLuT0HOxcRtmVn6hMRV7SWHHnYDsDVHXMJoK4h0eBfrgdt0cPXCHXL+EmfoA/hMvd6
         B65tXFiovSSn+9gdwMl+XI+DRXrrqZxKH8d7YiQtilAGWD58ptbH0TSSWZmGMafqjZE4
         cx3RqjkNNOVrRM5DAXoMGRWWN4tv5v3M6PO7F6+qqyJvL/y6S1VnMnsapummxvYTmNvs
         9GSw==
X-Gm-Message-State: ACrzQf3ogssAK8gzPSwgZlcMkm700ovE22YiPI0Vvidfhw+iR+uVTLER
        8Ftj9sxIzXkN9I2J/5G0QGJ0G1wC9PU4sbJkvPjIofl2aodfl8CjdB3JVAXu1j+b7Nnu8ci6aTQ
        H9TRvj9lYjaLNNUMMb/2T7Q==
X-Received: by 2002:a05:6214:29e4:b0:4ad:8c96:178b with SMTP id jv4-20020a05621429e400b004ad8c96178bmr1931444qvb.29.1663871380575;
        Thu, 22 Sep 2022 11:29:40 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5RkWlQl2NY4VBbaFM/3H818tEmhHbxLx0HPIsYfjbny4kxcAOERW2vdVGtdqk3/xGNqUrABA==
X-Received: by 2002:a05:6214:29e4:b0:4ad:8c96:178b with SMTP id jv4-20020a05621429e400b004ad8c96178bmr1931418qvb.29.1663871380242;
        Thu, 22 Sep 2022 11:29:40 -0700 (PDT)
Received: from bfoster (c-24-61-119-116.hsd1.ma.comcast.net. [24.61.119.116])
        by smtp.gmail.com with ESMTPSA id n12-20020a05620a294c00b006ce63901d27sm4470061qkp.4.2022.09.22.11.29.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 11:29:39 -0700 (PDT)
Date:   Thu, 22 Sep 2022 14:29:36 -0400
From:   Brian Foster <bfoster@redhat.com>
To:     Sarthak Kukreti <sarthakkukreti@chromium.org>
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
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Bart Van Assche <bvanassche@google.com>,
        Daniil Lunev <dlunev@google.com>,
        Evan Green <evgreen@google.com>,
        Gwendal Grignou <gwendal@google.com>
Subject: Re: [PATCH RFC 4/8] fs: Introduce FALLOC_FL_PROVISION
Message-ID: <YyypkOr3l2lx4Odi@bfoster>
References: <20220915164826.1396245-1-sarthakkukreti@google.com>
 <20220915164826.1396245-5-sarthakkukreti@google.com>
 <YyRkd8YAH1lal8/N@bfoster>
 <CAG9=OMNL1Z3DiO-usdH0k90NDsDkDQ7A7CHc4Nu6MCXKNKjWdw@mail.gmail.com>
 <YyswI57JH7gcs9+S@bfoster>
 <CAG9=OMPEoShYMx6A+p97-tw4MuLpgOEpy7aFs5CH6wTedptALQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG9=OMPEoShYMx6A+p97-tw4MuLpgOEpy7aFs5CH6wTedptALQ@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Sep 22, 2022 at 01:04:33AM -0700, Sarthak Kukreti wrote:
> On Wed, Sep 21, 2022 at 8:39 AM Brian Foster <bfoster@redhat.com> wrote:
> >
> > On Fri, Sep 16, 2022 at 02:02:31PM -0700, Sarthak Kukreti wrote:
> > > On Fri, Sep 16, 2022 at 4:56 AM Brian Foster <bfoster@redhat.com> wrote:
> > > >
> > > > On Thu, Sep 15, 2022 at 09:48:22AM -0700, Sarthak Kukreti wrote:
> > > > > From: Sarthak Kukreti <sarthakkukreti@chromium.org>
> > > > >
> > > > > FALLOC_FL_PROVISION is a new fallocate() allocation mode that
> > > > > sends a hint to (supported) thinly provisioned block devices to
> > > > > allocate space for the given range of sectors via REQ_OP_PROVISION.
> > > > >
> > > > > Signed-off-by: Sarthak Kukreti <sarthakkukreti@chromium.org>
> > > > > ---
> > > > >  block/fops.c                | 7 ++++++-
> > > > >  include/linux/falloc.h      | 3 ++-
> > > > >  include/uapi/linux/falloc.h | 8 ++++++++
> > > > >  3 files changed, 16 insertions(+), 2 deletions(-)
> > > > >
> > > > > diff --git a/block/fops.c b/block/fops.c
> > > > > index b90742595317..a436a7596508 100644
> > > > > --- a/block/fops.c
> > > > > +++ b/block/fops.c
> > > > ...
> > > > > @@ -661,6 +662,10 @@ static long blkdev_fallocate(struct file *file, int mode, loff_t start,
> > > > >               error = blkdev_issue_discard(bdev, start >> SECTOR_SHIFT,
> > > > >                                            len >> SECTOR_SHIFT, GFP_KERNEL);
> > > > >               break;
> > > > > +     case FALLOC_FL_PROVISION:
> > > > > +             error = blkdev_issue_provision(bdev, start >> SECTOR_SHIFT,
> > > > > +                                            len >> SECTOR_SHIFT, GFP_KERNEL);
> > > > > +             break;
> > > > >       default:
> > > > >               error = -EOPNOTSUPP;
> > > > >       }
> > > >
> > > > Hi Sarthak,
> > > >
> > > > Neat mechanism.. I played with something very similar in the past (that
> > > > was much more crudely hacked up to target dm-thin) to allow filesystems
> > > > to request a thinly provisioned device to allocate blocks and try to do
> > > > a better job of avoiding inactivation when overprovisioned.
> > > >
> > > > One thing I'm a little curious about here.. what's the need for a new
> > > > fallocate mode? On a cursory glance, the provision mode looks fairly
> > > > analogous to normal (mode == 0) allocation mode with the exception of
> > > > sending the request down to the bdev. blkdev_fallocate() already maps
> > > > some of the logical falloc modes (i.e. punch hole, zero range) to
> > > > sending write sames or discards, etc., and it doesn't currently look
> > > > like it supports allocation mode, so could it not map such requests to
> > > > the underlying REQ_OP_PROVISION op?
> > > >
> > > > I guess the difference would be at the filesystem level where we'd
> > > > probably need to rely on a mount option or some such to control whether
> > > > traditional fallocate issues provision ops (like you've implemented for
> > > > ext4) vs. the specific falloc command, but that seems fairly consistent
> > > > with historical punch hole/discard behavior too. Hm? You might want to
> > > > cc linux-fsdevel in future posts in any event to get some more feedback
> > > > on how other filesystems might want to interact with such a thing.
> > > >
> > > Thanks for the feedback!
> > > Argh, I completely forgot that I should add linux-fsdevel. Let me
> > > re-send this with linux-fsdevel cc'd
> > >
> > > There's a slight distinction is that the current filesystem-level
> > > controls are usually for default handling, but userspace can still
> > > call the relevant functions manually if they need to. For example, for
> > > ext4, the 'discard' mount option dictates whether free blocks are
> > > discarded, but it doesn't set the policy to allow/disallow userspace
> > > from manually punching holes into files even if the mount opt is
> > > 'nodiscard'. FALLOC_FL_PROVISION is similar in that regard; it adds a
> > > manual mechanism for users to provision the files' extents, that is
> > > separate from the filesystems' default handling of provisioning files.
> > >
> >
> > What I'm trying to understand is why not let blkdev_fallocate() issue a
> > provision based on the default mode (i.e. mode == 0) of fallocate(),
> > which is already defined to mean "perform allocation?" It currently
> > issues discards or write zeroes based on variants of
> > FALLOC_FL_PUNCH_HOLE without the need for a separate FALLOC_FL_DISCARD
> > mode, for example.
> >
> It's mostly to keep the block device fallocate() semantics in-line and
> consistent with the file-specific modes: I added the separate
> filesystem fallocate() mode under the assumption that we'd want to
> keep the traditional handling for filesystems intact with (mode == 0).
> And for block devices, I didn't map the requests to mode == 0 so that
> it's less confusing to describe (eg. mode == 0 on block devices will
> issue provision; mode == 0 on files will not). It would complicate
> loopback devices, for instance; if the loop device is backed by a
> file, it would need to use (mode == FALLOC_FL_PROVISION) but if the
> loop device is backed by another block device, then the fallocate()
> call would need to switch to (mode == 0).
> 

I would expect the loopback scenario for provision to behave similar to
how discards are handled. I.e., loopback receives a provision request
and translates that to fallocate(mode = 0). If the backing device is
block, blkdev_fallocate(mode = 0) translates that to another provision
request.  If the backing device is a file, the associated fallocate
handler allocs/maps, if necessary, and then issues a provision on
allocation, if enabled by the fs.

AFAICT there's no need for FL_PROVISION at all in that scenario. Is
there a functional purpose to FL_PROVISION? Is the intent to try and
guarantee that a provision request propagates down the I/O stack? If so,
what happens if blocks were already preallocated in the backing file (in
the loopback file example)?

BTW, an unrelated thing I noticed is that blkdev_fallocate()
unconditionally calls truncate_bdev_range(), which probably doesn't make
sense for any sort of alloc mode.

> With the separate mode, we can describe the semantics of falllcate()
> modes a bit more cleanly, and it is common for both files and block
> devices:
> 
> 1. mode == 0: allocation at the same layer, will not provision on the
> underlying device/filesystem (unsupported for block devices).
> 2. mode == FALLOC_FL_PROVISION, allocation at the layer, will
> provision on the underlying device/filesystem.
> 

I think I see why you make the distinction, since the block layer
doesn't have a "this layer only" mode, but IMO it's also quite confusing
to say that mode == FL_PROVISION can allocate at the current and
underlying layer(s) but mode == 0 to that underlying layer cannot.

Either way, if you want to propose a new falloc mode/modifier, it
probably warrants a more detailed commit log with more explanation of
the purpose, examples of behavior, perhaps some details on how the mode
might be documented in man pages, etc.

Brian

> Block devices don't technically need to use a separate mode, but it
> makes it much less confusing if filesystems are already using a
> separate mode for provision.
> 
> Best
> Sarthak
> 
> > Brian
> >
> > > > BTW another thing that might be useful wrt to dm-thin is to support
> > > > FALLOC_FL_UNSHARE. I.e., it looks like the previous dm-thin patch only
> > > > checks that blocks are allocated, but not whether those blocks are
> > > > shared (re: lookup_result.shared). It might be useful to do the COW in
> > > > such cases if the caller passes down a REQ_UNSHARE or some such flag.
> > > >
> > > That's an interesting idea! There's a few more things on the TODO list
> > > for this patch series but I think we can follow up with a patch to
> > > handle that as well.
> > >
> > > Sarthak
> > >
> > > > Brian
> > > >
> > > > > diff --git a/include/linux/falloc.h b/include/linux/falloc.h
> > > > > index f3f0b97b1675..a0e506255b20 100644
> > > > > --- a/include/linux/falloc.h
> > > > > +++ b/include/linux/falloc.h
> > > > > @@ -30,7 +30,8 @@ struct space_resv {
> > > > >                                        FALLOC_FL_COLLAPSE_RANGE |     \
> > > > >                                        FALLOC_FL_ZERO_RANGE |         \
> > > > >                                        FALLOC_FL_INSERT_RANGE |       \
> > > > > -                                      FALLOC_FL_UNSHARE_RANGE)
> > > > > +                                      FALLOC_FL_UNSHARE_RANGE |                          \
> > > > > +                                      FALLOC_FL_PROVISION)
> > > > >
> > > > >  /* on ia32 l_start is on a 32-bit boundary */
> > > > >  #if defined(CONFIG_X86_64)
> > > > > diff --git a/include/uapi/linux/falloc.h b/include/uapi/linux/falloc.h
> > > > > index 51398fa57f6c..2d323d113eed 100644
> > > > > --- a/include/uapi/linux/falloc.h
> > > > > +++ b/include/uapi/linux/falloc.h
> > > > > @@ -77,4 +77,12 @@
> > > > >   */
> > > > >  #define FALLOC_FL_UNSHARE_RANGE              0x40
> > > > >
> > > > > +/*
> > > > > + * FALLOC_FL_PROVISION acts as a hint for thinly provisioned devices to allocate
> > > > > + * blocks for the range/EOF.
> > > > > + *
> > > > > + * FALLOC_FL_PROVISION can only be used with allocate-mode fallocate.
> > > > > + */
> > > > > +#define FALLOC_FL_PROVISION          0x80
> > > > > +
> > > > >  #endif /* _UAPI_FALLOC_H_ */
> > > > > --
> > > > > 2.31.0
> > > > >
> > > >
> > >
> >
> 

