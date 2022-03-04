Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A30AB4CDD39
	for <lists+linux-ext4@lfdr.de>; Fri,  4 Mar 2022 20:15:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbiCDTPt (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 4 Mar 2022 14:15:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbiCDTPs (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 4 Mar 2022 14:15:48 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B09F021F9F2;
        Fri,  4 Mar 2022 11:14:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2C7EB61987;
        Fri,  4 Mar 2022 19:14:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87FE4C36AE3;
        Fri,  4 Mar 2022 19:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646421293;
        bh=Cr2zQpALEYc0BloWcMquGCSDsBxEGFfaAzYxN+PfjoE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=X2JOGuU4ffwTvY2rv/SEVDjilGWGO8z/7GSzn1T2vEP33ZQvPsNQGxISxS3LtbHK7
         O5Dw4bBrJQcDxGCkDlMycSqAeXgpfkkStXPJF+l+m7t2hpRm+5D+Ex1DUeyfww9OZo
         /ubv6xPejnFtAW07FYdmw2EUI54FVWv23VHAu/5xJs/FVDhwAGpxje4+Wjf2JB60D9
         3KBQ91vg15BaVGY75a1UuL6HT2kvuaIeCXtvIw6EMS3lQclIeHrnMhLKa+xLHNBsGa
         TneeE7SsZp43VWTRUtnSR0/kQRvRfLL16aE4/yvqTg8UGvgDnHdugR7Ntj27qGdM3d
         zyu4EZK8C/C/Q==
Received: by mail-yb1-f170.google.com with SMTP id g1so18786007ybe.4;
        Fri, 04 Mar 2022 11:14:53 -0800 (PST)
X-Gm-Message-State: AOAM533btCK+NUhYRzYk2Ux8usFHMbHYxC14e0hazDrXJU/82yQ3Qm2s
        jG5g0415ykkxVSC1PtWK+jvqIXF4zrAWnJ/eXsA=
X-Google-Smtp-Source: ABdhPJyJKciwB+H2qT8XuSdHG5g3cocNLmmYPiUlbuTc45K35RAIqHTj7b5fPglxl5qTTPIUQQAAK5EEC3jrs2oPFHs=
X-Received: by 2002:a25:c89:0:b0:61d:a1e8:fd14 with SMTP id
 131-20020a250c89000000b0061da1e8fd14mr38894980ybm.322.1646421292474; Fri, 04
 Mar 2022 11:14:52 -0800 (PST)
MIME-Version: 1.0
References: <20220304180105.409765-1-hch@lst.de> <20220304180105.409765-8-hch@lst.de>
In-Reply-To: <20220304180105.409765-8-hch@lst.de>
From:   Song Liu <song@kernel.org>
Date:   Fri, 4 Mar 2022 11:14:41 -0800
X-Gmail-Original-Message-ID: <CAPhsuW6vmKx6tgsnM9gifW2Szi2cQX4kY77_BRfNwfq9RXniuQ@mail.gmail.com>
Message-ID: <CAPhsuW6vmKx6tgsnM9gifW2Szi2cQX4kY77_BRfNwfq9RXniuQ@mail.gmail.com>
Subject: Re: [PATCH 07/10] raid1: stop using bio_devname
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
>  drivers/md/raid1.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
> index c180c188da574..97574575ad0b4 100644
> --- a/drivers/md/raid1.c
> +++ b/drivers/md/raid1.c
> @@ -2069,15 +2069,14 @@ static int fix_sync_read_error(struct r1bio *r1_bio)
>                 } while (!success && d != r1_bio->read_disk);
>
>                 if (!success) {
> -                       char b[BDEVNAME_SIZE];
>                         int abort = 0;
>                         /* Cannot read from anywhere, this block is lost.
>                          * Record a bad block on each device.  If that doesn't
>                          * work just disable and interrupt the recovery.
>                          * Don't fail devices as that won't really help.
>                          */
> -                       pr_crit_ratelimited("md/raid1:%s: %s: unrecoverable I/O read error for block %llu\n",
> -                                           mdname(mddev), bio_devname(bio, b),
> +                       pr_crit_ratelimited("md/raid1:%s: %pg: unrecoverable I/O read error for block %llu\n",
> +                                           mdname(mddev), bio->bi_bdev,
>                                             (unsigned long long)r1_bio->sector);
>                         for (d = 0; d < conf->raid_disks * 2; d++) {
>                                 rdev = conf->mirrors[d].rdev;
> --
> 2.30.2
>
