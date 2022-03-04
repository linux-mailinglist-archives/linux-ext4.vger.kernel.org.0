Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0FF4CDD3C
	for <lists+linux-ext4@lfdr.de>; Fri,  4 Mar 2022 20:15:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbiCDTQJ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 4 Mar 2022 14:16:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbiCDTQI (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 4 Mar 2022 14:16:08 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A579E220FF8;
        Fri,  4 Mar 2022 11:15:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 65C0CB82A4D;
        Fri,  4 Mar 2022 19:15:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14805C340F4;
        Fri,  4 Mar 2022 19:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646421309;
        bh=2brRnpBI5uL9EXGyu77bABaF+hmuzCTaJNlfz90L6mk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mz+hl6DuNxuSfuyVRhOoQk4zpRxzdbqx+REc2oCmRtjEHE6NzKCAcgZAlILNqCyWF
         FuVsid4LJS92O9L01HIoRVObyt0n95plMYmGaaV6gFE8ACUgXbofLKdOER9zoFK2qw
         KxuAcYWzm/v3TdbwA+OEYa5NdS1XJ3Bf9+0ayd0kY02o3yrJTyUG/9DYcNCVYqnI+w
         pTDKqDIhofUqq3hUmnaOcZKiEJgITcuRpTkWeXi2wxX3hk/ndPAWXB5F3JWdRTA3tw
         7D4vrYrIEuKD9HgAu3VtL/emy1bi8s30XTx/zjSuyg5qzARUKdxPLdoN+uM0XNhpGJ
         QZ6+65xjX3oXA==
Received: by mail-yb1-f169.google.com with SMTP id f38so18808220ybi.3;
        Fri, 04 Mar 2022 11:15:09 -0800 (PST)
X-Gm-Message-State: AOAM533RUwvjYS/DVSGJEwEQ/GPF21001GFsqMuCoFZHoY2U79sLQgSP
        3iQHwAB5Kf+UjjH6vSAMvI5i/7913LhB3lCQBuY=
X-Google-Smtp-Source: ABdhPJwvYWo5sV9pgpzrhXVlKHtiqoX0cVIwcp9Ep+TOVMH3s6JJg/yAG8Y0iPsWyyQHZEx6/oISXjxOqJ+XQV2leAc=
X-Received: by 2002:a05:6902:1ca:b0:624:e2a1:2856 with SMTP id
 u10-20020a05690201ca00b00624e2a12856mr39674753ybh.389.1646421307924; Fri, 04
 Mar 2022 11:15:07 -0800 (PST)
MIME-Version: 1.0
References: <20220304180105.409765-1-hch@lst.de> <20220304180105.409765-9-hch@lst.de>
In-Reply-To: <20220304180105.409765-9-hch@lst.de>
From:   Song Liu <song@kernel.org>
Date:   Fri, 4 Mar 2022 11:14:57 -0800
X-Gmail-Original-Message-ID: <CAPhsuW5DNs6Kp42VmBi5J4qB8_3orBHhdA82RJuzg7kmQO_2aA@mail.gmail.com>
Message-ID: <CAPhsuW5DNs6Kp42VmBi5J4qB8_3orBHhdA82RJuzg7kmQO_2aA@mail.gmail.com>
Subject: Re: [PATCH 08/10] raid5-ppl: stop using bio_devname
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
>  drivers/md/raid5-ppl.c | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/md/raid5-ppl.c b/drivers/md/raid5-ppl.c
> index 93d9364a930e3..845db0ba7c17f 100644
> --- a/drivers/md/raid5-ppl.c
> +++ b/drivers/md/raid5-ppl.c
> @@ -416,12 +416,10 @@ static void ppl_log_endio(struct bio *bio)
>
>  static void ppl_submit_iounit_bio(struct ppl_io_unit *io, struct bio *bio)
>  {
> -       char b[BDEVNAME_SIZE];
> -
> -       pr_debug("%s: seq: %llu size: %u sector: %llu dev: %s\n",
> +       pr_debug("%s: seq: %llu size: %u sector: %llu dev: %pg\n",
>                  __func__, io->seq, bio->bi_iter.bi_size,
>                  (unsigned long long)bio->bi_iter.bi_sector,
> -                bio_devname(bio, b));
> +                bio->bi_bdev);
>
>         submit_bio(bio);
>  }
> @@ -589,9 +587,8 @@ static void ppl_flush_endio(struct bio *bio)
>         struct ppl_log *log = io->log;
>         struct ppl_conf *ppl_conf = log->ppl_conf;
>         struct r5conf *conf = ppl_conf->mddev->private;
> -       char b[BDEVNAME_SIZE];
>
> -       pr_debug("%s: dev: %s\n", __func__, bio_devname(bio, b));
> +       pr_debug("%s: dev: %pg\n", __func__, bio->bi_bdev);
>
>         if (bio->bi_status) {
>                 struct md_rdev *rdev;
> @@ -634,7 +631,6 @@ static void ppl_do_flush(struct ppl_io_unit *io)
>
>                 if (bdev) {
>                         struct bio *bio;
> -                       char b[BDEVNAME_SIZE];
>
>                         bio = bio_alloc_bioset(bdev, 0, GFP_NOIO,
>                                                REQ_OP_WRITE | REQ_PREFLUSH,
> @@ -642,8 +638,7 @@ static void ppl_do_flush(struct ppl_io_unit *io)
>                         bio->bi_private = io;
>                         bio->bi_end_io = ppl_flush_endio;
>
> -                       pr_debug("%s: dev: %s\n", __func__,
> -                                bio_devname(bio, b));
> +                       pr_debug("%s: dev: %ps\n", __func__, bio->bi_bdev);
>
>                         submit_bio(bio);
>                         flushed_disks++;
> --
> 2.30.2
>
