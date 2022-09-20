Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D1C25BDA2E
	for <lists+linux-ext4@lfdr.de>; Tue, 20 Sep 2022 04:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbiITCdx (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 19 Sep 2022 22:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiITCdw (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 19 Sep 2022 22:33:52 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A832157896
        for <linux-ext4@vger.kernel.org>; Mon, 19 Sep 2022 19:33:50 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id sb3so2864373ejb.9
        for <linux-ext4@vger.kernel.org>; Mon, 19 Sep 2022 19:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=4WdgOQEnTGB5AD0/3SYqzq4oO226bgoIvmn6I1vr/DE=;
        b=B66Mfs4AndtZMHw0cxrGW2QT2/SRG5s1osj6N3OngZcnx85hUZVIBES+B1K+Ef5VEO
         I4B/iSWs1ss6it+OJ7yy5H7AFUGDRdkrQeaoUPdd5rLx+456n9LX0uLS4Q/V5aDMEDfQ
         jgl8mGOUixXp4MezbRgD7YZXWSGjAQ8Op8BPY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=4WdgOQEnTGB5AD0/3SYqzq4oO226bgoIvmn6I1vr/DE=;
        b=5VBiO0/f6TVV+GMz3AQdHz6BV3M0RCS1zHQn2lyxBObj46UpHncoVJzb+QlDg59qV/
         5ZplD+JHbXkHPzT60gGllstOlL7XeqgkBnHLMYVPKEQ0VnqbcOri1Bsz7rwiOlOtTTtu
         dFmt8MOgR92HZmhsB6vVJFim3zMoeacV+1d0PWpU1MdWcmCNhz0Fh0jqEJXCKBW91rK+
         iwOt7Gvt2gDy/nJoDP3NJTjw1yAgNkLJaDYGs3XuBv6f6RcFYGS1hHk5rsNk0758/3mh
         o9tS5qe94kUe3V1pgqb4FTApJ4Ns6IoiXjZS+9n9hKdSJDL8epSDm1vW8KPvkS8zE6gK
         5wRw==
X-Gm-Message-State: ACrzQf0onLCEPjjx+9r/8ImE/PLrRnOOShxMNd4TqtSAEQ2lzEIE1WS/
        fj3zWXQtiF0iKrL/u+g/k5juo4oczlXU4cpOSE4t+A==
X-Google-Smtp-Source: AMsMyM6oA07pBoPv0NiRcgoDeKipAqKueA2dka5/YzaH22PcO7CPkT4imFruPehqxaOY1hLqLkVMvRcG/EQO9P7eK/0=
X-Received: by 2002:a17:906:9746:b0:781:913d:6cc7 with SMTP id
 o6-20020a170906974600b00781913d6cc7mr3007772ejy.386.1663641229240; Mon, 19
 Sep 2022 19:33:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220915164826.1396245-1-sarthakkukreti@google.com>
 <20220915164826.1396245-4-sarthakkukreti@google.com> <YyQOFTI4CWn041UM@fedora>
In-Reply-To: <YyQOFTI4CWn041UM@fedora>
From:   Sarthak Kukreti <sarthakkukreti@chromium.org>
Date:   Mon, 19 Sep 2022 19:33:37 -0700
Message-ID: <CAG9=OMM4uQiJuu+ChUq-hoiyKMrBOECgz=+xw+=LmcPt2FVwOQ@mail.gmail.com>
Subject: Re: [PATCH RFC 3/8] virtio_blk: Add support for provision requests
To:     Stefan Hajnoczi <stefanha@redhat.com>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Jens Axboe <axboe@kernel.dk>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
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
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Sep 15, 2022 at 10:48 PM Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> On Thu, Sep 15, 2022 at 09:48:21AM -0700, Sarthak Kukreti wrote:
> > From: Sarthak Kukreti <sarthakkukreti@chromium.org>
> >
> > Adds support for provision requests. Provision requests act like
> > the inverse of discards.
> >
> > Signed-off-by: Sarthak Kukreti <sarthakkukreti@chromium.org>
> > ---
> >  drivers/block/virtio_blk.c      | 48 +++++++++++++++++++++++++++++++++
> >  include/uapi/linux/virtio_blk.h |  9 +++++++
> >  2 files changed, 57 insertions(+)
>
> Please send a VIRTIO spec patch too:
> https://github.com/oasis-tcs/virtio-spec#providing-feedback
>
Thanks for the suggestion! Ref:
https://lists.oasis-open.org/archives/virtio-comment/202209/msg00025.html

The patch needs to be amended a bit to account for the diff. in the
spec and the original patch. Will update in the next patch iteration.

Best
Sarthak

> Stefan
>
> >
> > diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> > index 30255fcaf181..eacc2bffe1d1 100644
> > --- a/drivers/block/virtio_blk.c
> > +++ b/drivers/block/virtio_blk.c
> > @@ -178,6 +178,39 @@ static int virtblk_setup_discard_write_zeroes(struct request *req, bool unmap)
> >       return 0;
> >  }
> >
> > +static int virtblk_setup_provision(struct request *req)
> > +{
> > +     unsigned short segments = blk_rq_nr_discard_segments(req);
> > +     unsigned short n = 0;
> > +
> > +     struct virtio_blk_discard_write_zeroes *range;
> > +     struct bio *bio;
> > +     u32 flags = 0;
> > +
> > +     range = kmalloc_array(segments, sizeof(*range), GFP_ATOMIC);
> > +     if (!range)
> > +             return -ENOMEM;
> > +
> > +     __rq_for_each_bio(bio, req) {
> > +             u64 sector = bio->bi_iter.bi_sector;
> > +             u32 num_sectors = bio->bi_iter.bi_size >> SECTOR_SHIFT;
> > +
> > +             range[n].flags = cpu_to_le32(flags);
> > +             range[n].num_sectors = cpu_to_le32(num_sectors);
> > +             range[n].sector = cpu_to_le64(sector);
> > +             n++;
> > +     }
> > +
> > +     WARN_ON_ONCE(n != segments);
> > +
> > +     req->special_vec.bv_page = virt_to_page(range);
> > +     req->special_vec.bv_offset = offset_in_page(range);
> > +     req->special_vec.bv_len = sizeof(*range) * segments;
> > +     req->rq_flags |= RQF_SPECIAL_PAYLOAD;
> > +
> > +     return 0;
> > +}
> > +
> >  static void virtblk_unmap_data(struct request *req, struct virtblk_req *vbr)
> >  {
> >       if (blk_rq_nr_phys_segments(req))
> > @@ -243,6 +276,9 @@ static blk_status_t virtblk_setup_cmd(struct virtio_device *vdev,
> >       case REQ_OP_DRV_IN:
> >               type = VIRTIO_BLK_T_GET_ID;
> >               break;
> > +     case REQ_OP_PROVISION:
> > +             type = VIRTIO_BLK_T_PROVISION;
> > +             break;
> >       default:
> >               WARN_ON_ONCE(1);
> >               return BLK_STS_IOERR;
> > @@ -256,6 +292,11 @@ static blk_status_t virtblk_setup_cmd(struct virtio_device *vdev,
> >                       return BLK_STS_RESOURCE;
> >       }
> >
> > +     if (type == VIRTIO_BLK_T_PROVISION) {
> > +             if (virtblk_setup_provision(req))
> > +                     return BLK_STS_RESOURCE;
> > +     }
> > +
> >       return 0;
> >  }
> >
> > @@ -1075,6 +1116,12 @@ static int virtblk_probe(struct virtio_device *vdev)
> >               blk_queue_max_write_zeroes_sectors(q, v ? v : UINT_MAX);
> >       }
> >
> > +     if (virtio_has_feature(vdev, VIRTIO_BLK_F_PROVISION)) {
> > +             virtio_cread(vdev, struct virtio_blk_config,
> > +                          max_provision_sectors, &v);
> > +             q->limits.max_provision_sectors = v ? v : UINT_MAX;
> > +     }
> > +
> >       virtblk_update_capacity(vblk, false);
> >       virtio_device_ready(vdev);
> >
> > @@ -1177,6 +1224,7 @@ static unsigned int features[] = {
> >       VIRTIO_BLK_F_RO, VIRTIO_BLK_F_BLK_SIZE,
> >       VIRTIO_BLK_F_FLUSH, VIRTIO_BLK_F_TOPOLOGY, VIRTIO_BLK_F_CONFIG_WCE,
> >       VIRTIO_BLK_F_MQ, VIRTIO_BLK_F_DISCARD, VIRTIO_BLK_F_WRITE_ZEROES,
> > +     VIRTIO_BLK_F_PROVISION,
> >  };
> >
> >  static struct virtio_driver virtio_blk = {
> > diff --git a/include/uapi/linux/virtio_blk.h b/include/uapi/linux/virtio_blk.h
> > index d888f013d9ff..184f8cf6d185 100644
> > --- a/include/uapi/linux/virtio_blk.h
> > +++ b/include/uapi/linux/virtio_blk.h
> > @@ -40,6 +40,7 @@
> >  #define VIRTIO_BLK_F_MQ              12      /* support more than one vq */
> >  #define VIRTIO_BLK_F_DISCARD 13      /* DISCARD is supported */
> >  #define VIRTIO_BLK_F_WRITE_ZEROES    14      /* WRITE ZEROES is supported */
> > +#define VIRTIO_BLK_F_PROVISION       15      /* provision is supported */
> >
> >  /* Legacy feature bits */
> >  #ifndef VIRTIO_BLK_NO_LEGACY
> > @@ -120,6 +121,11 @@ struct virtio_blk_config {
> >        */
> >       __u8 write_zeroes_may_unmap;
> >
> > +     /*
> > +      * The maximum number of sectors in a provision request.
> > +      */
> > +     __virtio32 max_provision_sectors;
> > +
> >       __u8 unused1[3];
> >  } __attribute__((packed));
> >
> > @@ -155,6 +161,9 @@ struct virtio_blk_config {
> >  /* Write zeroes command */
> >  #define VIRTIO_BLK_T_WRITE_ZEROES    13
> >
> > +/* Provision command */
> > +#define VIRTIO_BLK_T_PROVISION       14
> > +
> >  #ifndef VIRTIO_BLK_NO_LEGACY
> >  /* Barrier before this op. */
> >  #define VIRTIO_BLK_T_BARRIER 0x80000000
> > --
> > 2.31.0
> >
