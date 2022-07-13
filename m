Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9C99572EAD
	for <lists+linux-ext4@lfdr.de>; Wed, 13 Jul 2022 09:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234499AbiGMHDq (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 13 Jul 2022 03:03:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234478AbiGMHDo (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 13 Jul 2022 03:03:44 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAB93222B5
        for <linux-ext4@vger.kernel.org>; Wed, 13 Jul 2022 00:03:42 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id bp15so7955594ejb.6
        for <linux-ext4@vger.kernel.org>; Wed, 13 Jul 2022 00:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0gYYvt1vWIXI8HNMSYfXYBDt+l8mgcRYRjUuxGt2NPY=;
        b=eUO8a1qjrBJuiWZEU95ms0v4NGhQo/R6mzhJN0jU2rcmOAvZOCm6tQTO5Q4hKqZnUL
         geUOthwICiNUBd836aa64R1Yi3PO4S+3JrnUsG7/lBN6blQCZkQdvRz8SYJG77Idkh5Q
         G+vTK9EBX1JQgTUXhm0jqY1sRsWQltfpPJ/Nkuo1Hptetw5RCCA2hU4cePeny5j8nPfc
         MgkOCQ5cPt79WIbZwWEyGciWFbIcp6Nr78DXPhcUDPFodFxN1dE+/5KvRi256xDOJJKZ
         IGoCRENig3iGtwks7i7MDn/ifVeo0LQXlfZLxqj0pHadHjoBYFoZFIrpbYQOwkibk7H5
         rp6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0gYYvt1vWIXI8HNMSYfXYBDt+l8mgcRYRjUuxGt2NPY=;
        b=cydCcP1nd3LkAUgYQvbAkBdiVOqI5T1L7IxA3uxlakAcVQxbUyNre1FgoOWNs4lFlR
         NkiS+upHo0O0IjxulooE8dhO0JNu4Ow/TOxxIkc0jjzWsOLQjRS8MEAn6gIp63nxqrMw
         bqnkb/DP985KEG3Tq4u+VpZv26P3KpswqqPmIW4a2u9rd3TReNAg/QTt3fHBrKg5GnEv
         /8Nfvo7cLVfU9AYzA7WNrA4iPPlMh/JC8M1TBjrx2CqrIudSKiHVTl/EGNNHpiTGseK4
         F7gFSGcKndmQRuT9wiMMC3UzAQ11GpYIWuvHM2NuvIBMLqwzqI6TCn4wbrLIgSA1Y6i7
         9AvA==
X-Gm-Message-State: AJIora9cL6YedG7t6ixpPAlUpDNstn0BepX9tVDuMuGtl7k9N0wHvHYd
        Cdxms5/g/QZU9tMd4u3LrfXPhrkEvJ+QcAq3eWOnKg==
X-Google-Smtp-Source: AGRyM1v6tCbmP3It1PfK7ATbjED1frOwrB/fUUoQmetZ+KCzzdeBWp+khkKlwSMizYudxhMnhwJ7AyxgtQitWHTVyzw=
X-Received: by 2002:a17:906:d54f:b0:726:2c7c:c0f9 with SMTP id
 cr15-20020a170906d54f00b007262c7cc0f9mr1952611ejc.441.1657695821259; Wed, 13
 Jul 2022 00:03:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220713055317.1888500-1-hch@lst.de> <20220713055317.1888500-7-hch@lst.de>
In-Reply-To: <20220713055317.1888500-7-hch@lst.de>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Wed, 13 Jul 2022 09:03:30 +0200
Message-ID: <CAMGffEkbzTKkYY2yt-G8t1nO+y3+2+97=-ZgeUdF+ZE3iZvjng@mail.gmail.com>
Subject: Re: [PATCH 6/9] rnbd-srv: remove the name field from struct rnbd_dev
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        =?UTF-8?Q?Christoph_B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>,
        "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
        Song Liu <song@kernel.org>, "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.com>, Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        linux-block@vger.kernel.org, drbd-dev@lists.linbit.com,
        linux-raid@vger.kernel.org, linux-ext4@vger.kernel.org,
        ocfs2-devel@oss.oracle.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Jul 13, 2022 at 7:53 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Just print the block device name directly using the %pg format specifier.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Jack Wang <jinpu.wang@ionos.com>
Thx!
> ---
>  drivers/block/rnbd/rnbd-srv-dev.c   | 1 -
>  drivers/block/rnbd/rnbd-srv-dev.h   | 1 -
>  drivers/block/rnbd/rnbd-srv-sysfs.c | 5 ++---
>  drivers/block/rnbd/rnbd-srv.c       | 9 ++++-----
>  drivers/block/rnbd/rnbd-srv.h       | 3 +--
>  5 files changed, 7 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/block/rnbd/rnbd-srv-dev.c b/drivers/block/rnbd/rnbd-srv-dev.c
> index c5d0a03911659..c63017f6e4214 100644
> --- a/drivers/block/rnbd/rnbd-srv-dev.c
> +++ b/drivers/block/rnbd/rnbd-srv-dev.c
> @@ -28,7 +28,6 @@ struct rnbd_dev *rnbd_dev_open(const char *path, fmode_t flags)
>                 goto err;
>
>         dev->blk_open_flags = flags;
> -       bdevname(dev->bdev, dev->name);
>
>         return dev;
>
> diff --git a/drivers/block/rnbd/rnbd-srv-dev.h b/drivers/block/rnbd/rnbd-srv-dev.h
> index 4309e52524691..8407d12f70afe 100644
> --- a/drivers/block/rnbd/rnbd-srv-dev.h
> +++ b/drivers/block/rnbd/rnbd-srv-dev.h
> @@ -15,7 +15,6 @@
>  struct rnbd_dev {
>         struct block_device     *bdev;
>         fmode_t                 blk_open_flags;
> -       char                    name[BDEVNAME_SIZE];
>  };
>
>  /**
> diff --git a/drivers/block/rnbd/rnbd-srv-sysfs.c b/drivers/block/rnbd/rnbd-srv-sysfs.c
> index feaa76c5a3423..297a6924ff4e2 100644
> --- a/drivers/block/rnbd/rnbd-srv-sysfs.c
> +++ b/drivers/block/rnbd/rnbd-srv-sysfs.c
> @@ -38,14 +38,13 @@ static struct kobj_type dev_ktype = {
>  };
>
>  int rnbd_srv_create_dev_sysfs(struct rnbd_srv_dev *dev,
> -                              struct block_device *bdev,
> -                              const char *dev_name)
> +                              struct block_device *bdev)
>  {
>         struct kobject *bdev_kobj;
>         int ret;
>
>         ret = kobject_init_and_add(&dev->dev_kobj, &dev_ktype,
> -                                  rnbd_devs_kobj, dev_name);
> +                                  rnbd_devs_kobj, "%pg", bdev);
>         if (ret) {
>                 kobject_put(&dev->dev_kobj);
>                 return ret;
> diff --git a/drivers/block/rnbd/rnbd-srv.c b/drivers/block/rnbd/rnbd-srv.c
> index beaef43a67b9d..0713014bf423f 100644
> --- a/drivers/block/rnbd/rnbd-srv.c
> +++ b/drivers/block/rnbd/rnbd-srv.c
> @@ -419,7 +419,7 @@ static struct rnbd_srv_sess_dev
>         return sess_dev;
>  }
>
> -static struct rnbd_srv_dev *rnbd_srv_init_srv_dev(const char *id)
> +static struct rnbd_srv_dev *rnbd_srv_init_srv_dev(struct block_device *bdev)
>  {
>         struct rnbd_srv_dev *dev;
>
> @@ -427,7 +427,7 @@ static struct rnbd_srv_dev *rnbd_srv_init_srv_dev(const char *id)
>         if (!dev)
>                 return ERR_PTR(-ENOMEM);
>
> -       strscpy(dev->id, id, sizeof(dev->id));
> +       snprintf(dev->id, sizeof(dev->id), "%pg", bdev);
>         kref_init(&dev->kref);
>         INIT_LIST_HEAD(&dev->sess_dev_list);
>         mutex_init(&dev->lock);
> @@ -512,7 +512,7 @@ rnbd_srv_get_or_create_srv_dev(struct rnbd_dev *rnbd_dev,
>         int ret;
>         struct rnbd_srv_dev *new_dev, *dev;
>
> -       new_dev = rnbd_srv_init_srv_dev(rnbd_dev->name);
> +       new_dev = rnbd_srv_init_srv_dev(rnbd_dev->bdev);
>         if (IS_ERR(new_dev))
>                 return new_dev;
>
> @@ -758,8 +758,7 @@ static int process_msg_open(struct rnbd_srv_session *srv_sess,
>          */
>         mutex_lock(&srv_dev->lock);
>         if (!srv_dev->dev_kobj.state_in_sysfs) {
> -               ret = rnbd_srv_create_dev_sysfs(srv_dev, rnbd_dev->bdev,
> -                                                rnbd_dev->name);
> +               ret = rnbd_srv_create_dev_sysfs(srv_dev, rnbd_dev->bdev);
>                 if (ret) {
>                         mutex_unlock(&srv_dev->lock);
>                         rnbd_srv_err(srv_sess_dev,
> diff --git a/drivers/block/rnbd/rnbd-srv.h b/drivers/block/rnbd/rnbd-srv.h
> index be2ae486d407e..6926f9069dc4b 100644
> --- a/drivers/block/rnbd/rnbd-srv.h
> +++ b/drivers/block/rnbd/rnbd-srv.h
> @@ -68,8 +68,7 @@ void rnbd_srv_sess_dev_force_close(struct rnbd_srv_sess_dev *sess_dev,
>  /* rnbd-srv-sysfs.c */
>
>  int rnbd_srv_create_dev_sysfs(struct rnbd_srv_dev *dev,
> -                             struct block_device *bdev,
> -                             const char *dir_name);
> +                             struct block_device *bdev);
>  void rnbd_srv_destroy_dev_sysfs(struct rnbd_srv_dev *dev);
>  int rnbd_srv_create_dev_session_sysfs(struct rnbd_srv_sess_dev *sess_dev);
>  void rnbd_srv_destroy_dev_session_sysfs(struct rnbd_srv_sess_dev *sess_dev);
> --
> 2.30.2
>
