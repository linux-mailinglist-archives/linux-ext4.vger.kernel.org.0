Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DDDA703FD5
	for <lists+linux-ext4@lfdr.de>; Mon, 15 May 2023 23:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243697AbjEOVb4 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 15 May 2023 17:31:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243866AbjEOVbz (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 15 May 2023 17:31:55 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E68BAE72F
        for <linux-ext4@vger.kernel.org>; Mon, 15 May 2023 14:31:52 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-50bc3a2d333so20049644a12.0
        for <linux-ext4@vger.kernel.org>; Mon, 15 May 2023 14:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684186311; x=1686778311;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0+97QIKHZALmFiK8g1VXhuSr7RLu+60+zvsYBuHgbGg=;
        b=RJ43ZLZaLLvaXaU48DAqFaUazi1XdW+GzxWfHJT5XeDgDpzKHeu5MNWZny6MxbA0OA
         oPe6ekVWSZF8FhY1pcd7Q9kmUBnfHNdPl772Rvmn/QhYD4qom8AgDkG5qtlBg2wx9KCf
         JWeHWlZSGtpQ2QpjfAEvfhPCxAhtSoUUURhOM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684186311; x=1686778311;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0+97QIKHZALmFiK8g1VXhuSr7RLu+60+zvsYBuHgbGg=;
        b=WKbG7jV+odNrms51StdH0kQ5witRzY1SV1N1NWlMbOL6xb5hIX4EBvrobXFD5DLism
         Evlm9YH99OV6ehUVe1XSbiHe2L7SFyZf0ZN8vj0jKuc8UwbGpp039aKe5QCtiRYmTcmP
         5sfuvhVVvkmMafX3V4UXozCzmO3Ipd3dxd3ijcn/kQm5aVxvHD2FNFfdpkR+evs9gRUT
         drzZNBXUX/DuFU81dEvnBnAHocCCe+OjZvLEt4IMpnuY+rYQiP0g91rcuN2MUSkTkze4
         ylj1Bek/1h9UdYK3KqIjCXdJm8UGMpsV7GMolICx7X8eGK5x9nV/Z1b1BNk0Pma9yrw4
         +MbA==
X-Gm-Message-State: AC+VfDygvPQJy0Qja+nPh4ZHLcNeBnM5XXy8b5arAiv8JE4bH6wZ+qxh
        u+i9LrLvQks7HqWvuv1XZnubM2CzC6k+/hyY1J28kQ==
X-Google-Smtp-Source: ACHHUZ7Hc5oE5ND/9/QiL+Zn8CNn3DUPNRrptIElw6wI0GM9IDTcdOqoMTas5ig/h8ZcZwS+0kIdU23YGzZrwmE+F1M=
X-Received: by 2002:a17:907:728e:b0:96a:e7cc:b8b1 with SMTP id
 dt14-20020a170907728e00b0096ae7ccb8b1mr8614530ejc.56.1684186311425; Mon, 15
 May 2023 14:31:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230420004850.297045-1-sarthakkukreti@chromium.org>
 <20230506062909.74601-1-sarthakkukreti@chromium.org> <20230506062909.74601-6-sarthakkukreti@chromium.org>
 <ZGIoKi7d5bKcMWw4@bfoster>
In-Reply-To: <ZGIoKi7d5bKcMWw4@bfoster>
From:   Sarthak Kukreti <sarthakkukreti@chromium.org>
Date:   Mon, 15 May 2023 14:31:40 -0700
Message-ID: <CAG9=OMMPphcFMeyge_5pa=-j=fNtDBQTK2bQaDwFWhTs3_pJjw@mail.gmail.com>
Subject: Re: [PATCH v6 5/5] loop: Add support for provision requests
To:     Brian Foster <bfoster@redhat.com>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
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
        "Darrick J. Wong" <djwong@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, May 15, 2023 at 5:37=E2=80=AFAM Brian Foster <bfoster@redhat.com> w=
rote:
>
> On Fri, May 05, 2023 at 11:29:09PM -0700, Sarthak Kukreti wrote:
> > Add support for provision requests to loopback devices.
> > Loop devices will configure provision support based on
> > whether the underlying block device/file can support
> > the provision request and upon receiving a provision bio,
> > will map it to the backing device/storage. For loop devices
> > over files, a REQ_OP_PROVISION request will translate to
> > an fallocate mode 0 call on the backing file.
> >
> > Signed-off-by: Sarthak Kukreti <sarthakkukreti@chromium.org>
> > ---
> >  drivers/block/loop.c | 42 ++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 42 insertions(+)
> >
> > diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> > index bc31bb7072a2..13c4b4f8b9c1 100644
> > --- a/drivers/block/loop.c
> > +++ b/drivers/block/loop.c
> > @@ -327,6 +327,24 @@ static int lo_fallocate(struct loop_device *lo, st=
ruct request *rq, loff_t pos,
> >       return ret;
> >  }
> >
> > +static int lo_req_provision(struct loop_device *lo, struct request *rq=
, loff_t pos)
> > +{
> > +     struct file *file =3D lo->lo_backing_file;
> > +     struct request_queue *q =3D lo->lo_queue;
> > +     int ret;
> > +
> > +     if (!q->limits.max_provision_sectors) {
> > +             ret =3D -EOPNOTSUPP;
> > +             goto out;
> > +     }
> > +
> > +     ret =3D file->f_op->fallocate(file, 0, pos, blk_rq_bytes(rq));
> > +     if (unlikely(ret && ret !=3D -EINVAL && ret !=3D -EOPNOTSUPP))
> > +             ret =3D -EIO;
> > + out:
> > +     return ret;
> > +}
> > +
> >  static int lo_req_flush(struct loop_device *lo, struct request *rq)
> >  {
> >       int ret =3D vfs_fsync(lo->lo_backing_file, 0);
> > @@ -488,6 +506,8 @@ static int do_req_filebacked(struct loop_device *lo=
, struct request *rq)
> >                               FALLOC_FL_PUNCH_HOLE);
> >       case REQ_OP_DISCARD:
> >               return lo_fallocate(lo, rq, pos, FALLOC_FL_PUNCH_HOLE);
> > +     case REQ_OP_PROVISION:
> > +             return lo_req_provision(lo, rq, pos);
>
> Hi Sarthak,
>
> The only thing that stands out to me is the separate lo_req_provision()
> helper here. It seems it might be a little cleaner to extend and reuse
> lo_req_fallocate()..? But that's not something I feel strongly about, so
> this all looks pretty good to me either way, FWIW.
>
Fair point, I think that should shorten the patch (and for
correctness, we'd want to add FALLOC_FL_KEEP_SIZE for REQ_OP_PROVISION
too). I'll fix this up in v7.

Best
Sarthak

> Brian
>
> >       case REQ_OP_WRITE:
> >               if (cmd->use_aio)
> >                       return lo_rw_aio(lo, cmd, pos, ITER_SOURCE);
> > @@ -754,6 +774,25 @@ static void loop_sysfs_exit(struct loop_device *lo=
)
> >                                  &loop_attribute_group);
> >  }
> >
> > +static void loop_config_provision(struct loop_device *lo)
> > +{
> > +     struct file *file =3D lo->lo_backing_file;
> > +     struct inode *inode =3D file->f_mapping->host;
> > +
> > +     /*
> > +      * If the backing device is a block device, mirror its provisioni=
ng
> > +      * capability.
> > +      */
> > +     if (S_ISBLK(inode->i_mode)) {
> > +             blk_queue_max_provision_sectors(lo->lo_queue,
> > +                     bdev_max_provision_sectors(I_BDEV(inode)));
> > +     } else if (file->f_op->fallocate) {
> > +             blk_queue_max_provision_sectors(lo->lo_queue, UINT_MAX >>=
 9);
> > +     } else {
> > +             blk_queue_max_provision_sectors(lo->lo_queue, 0);
> > +     }
> > +}
> > +
> >  static void loop_config_discard(struct loop_device *lo)
> >  {
> >       struct file *file =3D lo->lo_backing_file;
> > @@ -1092,6 +1131,7 @@ static int loop_configure(struct loop_device *lo,=
 fmode_t mode,
> >       blk_queue_io_min(lo->lo_queue, bsize);
> >
> >       loop_config_discard(lo);
> > +     loop_config_provision(lo);
> >       loop_update_rotational(lo);
> >       loop_update_dio(lo);
> >       loop_sysfs_init(lo);
> > @@ -1304,6 +1344,7 @@ loop_set_status(struct loop_device *lo, const str=
uct loop_info64 *info)
> >       }
> >
> >       loop_config_discard(lo);
> > +     loop_config_provision(lo);
> >
> >       /* update dio if lo_offset or transfer is changed */
> >       __loop_update_dio(lo, lo->use_dio);
> > @@ -1830,6 +1871,7 @@ static blk_status_t loop_queue_rq(struct blk_mq_h=
w_ctx *hctx,
> >       case REQ_OP_FLUSH:
> >       case REQ_OP_DISCARD:
> >       case REQ_OP_WRITE_ZEROES:
> > +     case REQ_OP_PROVISION:
> >               cmd->use_aio =3D false;
> >               break;
> >       default:
> > --
> > 2.40.1.521.gf1e218fcd8-goog
> >
>
