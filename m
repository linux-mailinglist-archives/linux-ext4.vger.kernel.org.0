Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CFF04CDD34
	for <lists+linux-ext4@lfdr.de>; Fri,  4 Mar 2022 20:14:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbiCDTPj (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 4 Mar 2022 14:15:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiCDTPi (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 4 Mar 2022 14:15:38 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D5811F1601;
        Fri,  4 Mar 2022 11:14:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CD5ACB82B66;
        Fri,  4 Mar 2022 19:14:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D197C340EE;
        Fri,  4 Mar 2022 19:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646421280;
        bh=z9QOAPrGETQ++HWZY4bwoQ4oWyQg3KZKh7KMFBI9D3k=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WfZBXhh7cjSx2qbz7lyWNwyYegtc9BVoVASPBl+AYWSzGRgv/lZrbKWP96hd5yKsr
         sywrXu/hIEvE8UpLbSggbSUenfSEL143wXvWyl2AKiKPE5x3PvCVH1llOmPP/UH0F+
         KvDKVIy2mG+ICjhAVP6GhOXjDlGHUBIKLkxTa+JPGfIgQZJkk5YwjG+GdC8RrHfQ/y
         pcqcE1vFzhoU5skSDKZ6APVVNM+SeVRterRiquSWy1mP0jlJQhJY2wVwHxMhjgVsyy
         36EKJ2NOW8UYdHfiHLakr6VypzkBPNalh8bZIqMKevUtnaKAQBaVjXelfkn5GM0ekY
         zVb1qMo7OXvwA==
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-2dbc48104beso102387777b3.5;
        Fri, 04 Mar 2022 11:14:40 -0800 (PST)
X-Gm-Message-State: AOAM532FSOkPnuyEM8uiVMsLj/xL55Jgk2c0T0qLeOILqA8uDKCRcFEB
        RpsJr3qAcjMAJBMEb15gcnyGXLayslYUAKbnz4E=
X-Google-Smtp-Source: ABdhPJz1k+z6CdB1ZzQOzZSIjJIBSsGyOVyzuwjsvPhhdopH3DUGx0z8p5JWInYwnZDE3MO0ZqNgFRCZZrFdU5/nPZ4=
X-Received: by 2002:a81:23ce:0:b0:2dc:b20:cc73 with SMTP id
 j197-20020a8123ce000000b002dc0b20cc73mr51033ywj.130.1646421279615; Fri, 04
 Mar 2022 11:14:39 -0800 (PST)
MIME-Version: 1.0
References: <20220304180105.409765-1-hch@lst.de> <20220304180105.409765-7-hch@lst.de>
In-Reply-To: <20220304180105.409765-7-hch@lst.de>
From:   Song Liu <song@kernel.org>
Date:   Fri, 4 Mar 2022 11:14:28 -0800
X-Gmail-Original-Message-ID: <CAPhsuW4br23hby-nmQsx9=wTn3tgV+OCXh0kMBLQR7Nhc6zdzg@mail.gmail.com>
Message-ID: <CAPhsuW4br23hby-nmQsx9=wTn3tgV+OCXh0kMBLQR7Nhc6zdzg@mail.gmail.com>
Subject: Re: [PATCH 06/10] md-multipath: stop using bio_devname
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, "Theodore Ts'o" <tytso@mit.edu>,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        linux-raid <linux-raid@vger.kernel.org>,
        linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Mar 4, 2022 at 10:01 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Use the %pg format specifier to save on stack consuption and code size.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Song Liu <song@kernel.org>

> ---
>  drivers/md/md-multipath.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/md/md-multipath.c b/drivers/md/md-multipath.c
> index c056a7d707b09..bc38a6133cda3 100644
> --- a/drivers/md/md-multipath.c
> +++ b/drivers/md/md-multipath.c
> @@ -294,7 +294,6 @@ static void multipathd(struct md_thread *thread)
>
>         md_check_recovery(mddev);
>         for (;;) {
> -               char b[BDEVNAME_SIZE];
>                 spin_lock_irqsave(&conf->device_lock, flags);
>                 if (list_empty(head))
>                         break;
> @@ -306,13 +305,13 @@ static void multipathd(struct md_thread *thread)
>                 bio->bi_iter.bi_sector = mp_bh->master_bio->bi_iter.bi_sector;
>
>                 if ((mp_bh->path = multipath_map (conf))<0) {
> -                       pr_err("multipath: %s: unrecoverable IO read error for block %llu\n",
> -                              bio_devname(bio, b),
> +                       pr_err("multipath: %pg: unrecoverable IO read error for block %llu\n",
> +                              bio->bi_bdev,
>                                (unsigned long long)bio->bi_iter.bi_sector);
>                         multipath_end_bh_io(mp_bh, BLK_STS_IOERR);
>                 } else {
> -                       pr_err("multipath: %s: redirecting sector %llu to another IO path\n",
> -                              bio_devname(bio, b),
> +                       pr_err("multipath: %pg: redirecting sector %llu to another IO path\n",
> +                              bio->bi_bdev,
>                                (unsigned long long)bio->bi_iter.bi_sector);
>                         *bio = *(mp_bh->master_bio);
>                         bio->bi_iter.bi_sector +=
> --
> 2.30.2
>
