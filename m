Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07E20763C24
	for <lists+linux-ext4@lfdr.de>; Wed, 26 Jul 2023 18:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232876AbjGZQPz (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 26 Jul 2023 12:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232744AbjGZQPt (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 26 Jul 2023 12:15:49 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8889D2D6A
        for <linux-ext4@vger.kernel.org>; Wed, 26 Jul 2023 09:15:39 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1bba04b9df3so28093605ad.0
        for <linux-ext4@vger.kernel.org>; Wed, 26 Jul 2023 09:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20221208.gappssmtp.com; s=20221208; t=1690388138; x=1690992938;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=onO9uEGHkzci8Q3HqDarTwi6NVQ5X3moP62GXfbu6bk=;
        b=1nYqa0dULGb6vW3IHTl0gJlD/Wv5L7r4F/RAu6e5hAs7WBTwrr8oXfWC2f4wSk3EA+
         77u7gD50gxYWfW7UUpB12GXyUI78tr0I+DUI200NLSLeAA41kNfAWafwpxxJs6g8+CAt
         nBvSMXG8wmTQZXHDqSuAU1oadx3XW8qkhdx4vqHYao5ev4krMSdcjdVBCxTjjAeK5ry1
         YSAECAzZhBt1rnJ+5v6YucwpcqqIcDjN4wT+lMcK/4RSTL/17owrmtbX1HNRnEQmRSQ1
         drCBgCIvIGa0h5JR8N224zhN2NMcSyC+O2/lKRAbRWv12Pdg2LZZ0A+BQ4ELcbOlrsF0
         9FAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690388138; x=1690992938;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=onO9uEGHkzci8Q3HqDarTwi6NVQ5X3moP62GXfbu6bk=;
        b=RubYVlwdb2bq1Go75l5qYhrECT+p29IKgJUgUu2xLLllQGVY1hxIXWffJqCiZKee90
         IFCt+lOOZlVnOQ2QRWw76Z4mgVHUVYwv38sydpdEsyJ6md238j2SN1Hmjnxvb2urWKjv
         fBowwnRN0RvTg64Jw1ciB+7Ou/bPE3ryx8xEPcs2fb7VIvyXrJyn5Q0aIQRGvVpY3kux
         cBlxDdXXjDC4Hzn1q5isBu6gZU/LHssziKIR19znObxUDjBnTdlIoc5I5M27PuZjXpft
         2kMNTC6fqubQyd5Mv7Pr25oR5j5ushd9CDlzUHpKSRiMnXZ3JGKm22ao3vgp49ewvBpL
         LXzg==
X-Gm-Message-State: ABy/qLbtXgMLKz2R0Nw0lDAuwReytCmrz6UsxZ7dJN9DY8WT1PL//xJO
        xG/PyfKzjKRnJVaj0gPfah7wL1kcavxxdRbyYD0=
X-Google-Smtp-Source: APBJJlHMybV+h8vIEC70P7oTcJ/f2k2Yw1KSiF1vk3WdjRhJmhpy+1f0Yr2ZhMZ0nM8N4Dr0tu8qCA==
X-Received: by 2002:a17:902:7204:b0:1b8:b41a:d4be with SMTP id ba4-20020a170902720400b001b8b41ad4bemr2425586plb.10.1690388138605;
        Wed, 26 Jul 2023 09:15:38 -0700 (PDT)
Received: from smtpclient.apple (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id je7-20020a170903264700b001b8b0ac2258sm13395244plb.174.2023.07.26.09.15.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jul 2023 09:15:37 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andreas Dilger <adilger@dilger.ca>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 1/1] e2fsck: Add percent to files and blocks feature
Date:   Wed, 26 Jul 2023 10:15:26 -0600
Message-Id: <7023297C-8D10-4903-A0E2-7ED8B8BFA043@dilger.ca>
References: <20230423082349.53474-2-megia.oscar@gmail.com>
Cc:     linux-ext4@vger.kernel.org
In-Reply-To: <20230423082349.53474-2-megia.oscar@gmail.com>
To:     =?utf-8?Q?Oscar_Megia_L=C3=B3pez?= <megia.oscar@gmail.com>
X-Mailer: iPhone Mail (20F75)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Apr 23, 2023, at 02:25, Oscar Megia L=C3=B3pez <megia.oscar@gmail.com> wr=
ote:
>=20
> =EF=BB=BFI need percentages to see how disk is occupied.
> Used and maximum are good, but humans work better with percentages.
>=20
> When my linux boots,
> I haven't enough time to remember numbers and calculate.
>=20
> My PC is very fast. I can only see the message for one or two seconds.
>=20
> If also I would see percentages for me would be perfect.
>=20
> I think that this feature is going to be good for everyone.
>=20
> Signed-off-by: Oscar Megia L=C3=B3pez <megia.oscar@gmail.com>
> ---
> e2fsck/unix.c | 25 +++++++++++++++++++++++--
> 1 file changed, 23 insertions(+), 2 deletions(-)
>=20
> diff --git a/e2fsck/unix.c b/e2fsck/unix.c
> index e5b672a2..b820ca8d 100644
> --- a/e2fsck/unix.c
> +++ b/e2fsck/unix.c
> @@ -350,6 +350,8 @@ static void check_if_skip(e2fsck_t ctx)
>    int defer_check_on_battery;
>    int broken_system_clock;
>    time_t lastcheck;
> +    char percent_files[9];
> +    char percent_blocks[9];
>=20
>    if (ctx->flags & E2F_FLAG_PROBLEMS_FIXED)
>        return;
> @@ -442,14 +444,33 @@ static void check_if_skip(e2fsck_t ctx)
>        ext2fs_mark_super_dirty(fs);
>    }
>=20
> +    /* Calculate percentages */
> +    if (fs->super->s_inodes_count > 0) {
> +        snprintf(percent_files, sizeof(percent_files), " (%u%%) ",
> +        ((fs->super->s_inodes_count - fs->super->s_free_inodes_count) * 1=
00) /
> +        fs->super->s_inodes_count);
> +    } else {
> +        snprintf(percent_files, sizeof(percent_files), " ");
> +    }

Instead of snprintf() this could just be initialized at variable declaration=
 time:

        char percent_files[8] =3D "";

That avoids extra runtime overhead and is no less safe. (This is adjusted to=
 compensate
for the format change below.)

> +    if (ext2fs_blocks_count(fs->super) > 0) {
> +        snprintf(percent_blocks, sizeof(percent_blocks), " (%llu%%) ",
> +        (unsigned long long) ((ext2fs_blocks_count(fs->super) -
> +        ext2fs_free_blocks_count(fs->super)) * 100) / ext2fs_blocks_count=
(fs->super));
> +    } else {
> +        snprintf(percent_blocks, sizeof(percent_blocks), " ");
> +    }

This could similarly be set at initialization:

        char percent_blocks[8] =3D "";

>    /* Print the summary message when we're skipping a full check */
> -    log_out(ctx, _("%s: clean, %u/%u files, %llu/%llu blocks"),
> +    log_out(ctx, _("%s: clean, %u/%u%sfiles, %llu/%llu%sblocks"),

This would be more readable if it left one space after each "%s" and then di=
dn't
include the trailing space in each string:

    log_out(ctx, _("%s: clean, %u/%u%s files, %llu/%llu%s blocks"),

Cheers, Andreas

>        ctx->device_name,
>        fs->super->s_inodes_count - fs->super->s_free_inodes_count,
>        fs->super->s_inodes_count,
> +        percent_files,
>        (unsigned long long) ext2fs_blocks_count(fs->super) -
>        ext2fs_free_blocks_count(fs->super),
> -        (unsigned long long) ext2fs_blocks_count(fs->super));
> +        (unsigned long long) ext2fs_blocks_count(fs->super),
> +        percent_blocks);
>    next_check =3D 100000;
>    if (fs->super->s_max_mnt_count > 0) {
>        next_check =3D fs->super->s_max_mnt_count - fs->super->s_mnt_count;=

> --=20
> 2.40.0
>=20
