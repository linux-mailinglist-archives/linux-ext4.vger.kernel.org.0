Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71474658A6E
	for <lists+linux-ext4@lfdr.de>; Thu, 29 Dec 2022 09:22:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbiL2IWr (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 29 Dec 2022 03:22:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230334AbiL2IWq (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 29 Dec 2022 03:22:46 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7505D11822
        for <linux-ext4@vger.kernel.org>; Thu, 29 Dec 2022 00:22:44 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id b88so18529981edf.6
        for <linux-ext4@vger.kernel.org>; Thu, 29 Dec 2022 00:22:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cdbk6YKET6QEGq9IebYDQMQPZF6j/6rc109njHhKlvI=;
        b=e0zqBtvvlQD2HeN7X7P1SHKwtY1WmNXBewHhrqgYf+Cjes2XV0RT3hygT/cZ9mLgAg
         mK9seVibJbFJISY9ylAm9410ISVQog0mR5lB7brL/TzMXjDdvh0jGSUofBvfksQXdS0N
         Bc48MzAHtkmpJ07DAwIqs27Z+Q8lD/rkRbbfs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cdbk6YKET6QEGq9IebYDQMQPZF6j/6rc109njHhKlvI=;
        b=glsdAikP6pY7a8W7trGevQstvDiEIpGgg2TC/KJbqkmjNrZcz+F4FmZC2JOr/ki4e1
         q2yQC4c5K+EVf3qdTuzO6dNTzj5bYYZnxeQlDLxj7eshuSzdt4CBtAUtRweldbUoPsWP
         S4VUHtw5alcJjNOcdquKbE4HHSpUo1yDLpDhaxoFZ0+/anMRWJPuH/RFwLeUzHVhEnYh
         t5S4wR8DA6dZLiZWAfVlhW1wRmO+nhLrXwlpv2Nl7NqMLfMVN48QSWT1+SCJWDanHxRM
         qYXTNobDtoRdpnCOXbc+41ErkUopueA0pGGK9zcp8l3W5KFhlcKqxc/b26q6SLV8YmOv
         NmNw==
X-Gm-Message-State: AFqh2kpOp7dYSTjBlIn9fF5mUUmiWEJOI3QycOC3Ob2OGecwELJAGAxL
        eTPP3Sj5Mo7KNCDFb1Q2FXAzl39bu8bVUkemmII7rw==
X-Google-Smtp-Source: AMrXdXsQ7w+8O+47UlcrH/eyB1AcY+iw3zi67xHAp19yIp7KZoxSU3hceHOEF+dEFVjlYfKxx8GN7IxiiG1wtM0JlDA=
X-Received: by 2002:a05:6402:1654:b0:47f:e663:1d78 with SMTP id
 s20-20020a056402165400b0047fe6631d78mr1566473edx.237.1672302162986; Thu, 29
 Dec 2022 00:22:42 -0800 (PST)
MIME-Version: 1.0
References: <20220915164826.1396245-1-sarthakkukreti@google.com>
 <20220915164826.1396245-3-sarthakkukreti@google.com> <Yy3BXc9wf4PH6Rby@redhat.com>
In-Reply-To: <Yy3BXc9wf4PH6Rby@redhat.com>
From:   Sarthak Kukreti <sarthakkukreti@chromium.org>
Date:   Thu, 29 Dec 2022 00:22:32 -0800
Message-ID: <CAG9=OMMgtscWZyZYHsY0pp-9we+yxs=88sr_yMb6pfz7e75nyA@mail.gmail.com>
Subject: Re: [PATCH RFC 2/8] dm: Add support for block provisioning
To:     Mike Snitzer <snitzer@redhat.com>
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

On Fri, Sep 23, 2022 at 7:23 AM Mike Snitzer <snitzer@redhat.com> wrote:
>
> On Thu, Sep 15 2022 at 12:48P -0400,
> Sarthak Kukreti <sarthakkukreti@chromium.org> wrote:
>
> > From: Sarthak Kukreti <sarthakkukreti@chromium.org>
> >
> > Add support to dm devices for REQ_OP_PROVISION. The default mode
> > is to pass through the request and dm-thin will utilize it to provision
> > blocks.
> >
> > Signed-off-by: Sarthak Kukreti <sarthakkukreti@chromium.org>
> > ---
> >  drivers/md/dm-crypt.c         |  4 +-
> >  drivers/md/dm-linear.c        |  1 +
> >  drivers/md/dm-table.c         | 17 +++++++
> >  drivers/md/dm-thin.c          | 86 +++++++++++++++++++++++++++++++++--
> >  drivers/md/dm.c               |  4 ++
> >  include/linux/device-mapper.h |  6 +++
> >  6 files changed, 113 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
> > index 159c6806c19b..357f0899cfb6 100644
> > --- a/drivers/md/dm-crypt.c
> > +++ b/drivers/md/dm-crypt.c
> > @@ -3081,6 +3081,8 @@ static int crypt_ctr_optional(struct dm_target *ti, unsigned int argc, char **ar
> >       if (ret)
> >               return ret;
> >
> > +     ti->num_provision_bios = 1;
> > +
> >       while (opt_params--) {
> >               opt_string = dm_shift_arg(&as);
> >               if (!opt_string) {
> > @@ -3384,7 +3386,7 @@ static int crypt_map(struct dm_target *ti, struct bio *bio)
> >        * - for REQ_OP_DISCARD caller must use flush if IO ordering matters
> >        */
> >       if (unlikely(bio->bi_opf & REQ_PREFLUSH ||
> > -         bio_op(bio) == REQ_OP_DISCARD)) {
> > +         bio_op(bio) == REQ_OP_DISCARD || bio_op(bio) == REQ_OP_PROVISION)) {
> >               bio_set_dev(bio, cc->dev->bdev);
> >               if (bio_sectors(bio))
> >                       bio->bi_iter.bi_sector = cc->start +
> > diff --git a/drivers/md/dm-linear.c b/drivers/md/dm-linear.c
> > index 3212ef6aa81b..1aa782149428 100644
> > --- a/drivers/md/dm-linear.c
> > +++ b/drivers/md/dm-linear.c
> > @@ -61,6 +61,7 @@ static int linear_ctr(struct dm_target *ti, unsigned int argc, char **argv)
> >       ti->num_discard_bios = 1;
> >       ti->num_secure_erase_bios = 1;
> >       ti->num_write_zeroes_bios = 1;
> > +     ti->num_provision_bios = 1;
> >       ti->private = lc;
> >       return 0;
> >
> > diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
> > index 332f96b58252..b7f9cb66b7ba 100644
> > --- a/drivers/md/dm-table.c
> > +++ b/drivers/md/dm-table.c
> > @@ -1853,6 +1853,18 @@ static bool dm_table_supports_write_zeroes(struct dm_table *t)
> >       return true;
> >  }
> >
> > +static bool dm_table_supports_provision(struct dm_table *t)
> > +{
> > +     for (unsigned int i = 0; i < t->num_targets; i++) {
> > +             struct dm_target *ti = dm_table_get_target(t, i);
> > +
> > +             if (ti->num_provision_bios)
> > +                     return true;
> > +     }
> > +
> > +     return false;
> > +}
> > +
>
> This needs to go a step further and verify a device in the stack
> actually services REQ_OP_PROVISION.
>
> Please see dm_table_supports_discards(): it iterates all devices in
> the table and checks that support is advertised.
>
> For discard, DM requires that _all_ devices in a table advertise
> support (that is pretty strict and likely could be relaxed to _any_).
>
> You'll need ti->provision_supported (like ->discards_supported) to
> advertise actual support is provided by dm-thinp (even if underlying
> devices don't support it).
>
> And yeah, dm-thinp passdown support for REQ_OP_PROVISION can follow
> later as needed (if there actual HW that would benefit from
> REQ_OP_PROVISION).
>
Done, thanks (the provision support, not the passdown)! I think the
one case where passdown might help is to build images with dm-thinp
already set up on one of the partitions (I have something in the works
for ChromiumOS images to do VM tests with preset state :)). That would
allow us to preallocate space for thin logical volumes inside the
image file.

> Mike
>
