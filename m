Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0C1D78A4FF
	for <lists+linux-ext4@lfdr.de>; Mon, 28 Aug 2023 06:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbjH1Epv (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 28 Aug 2023 00:45:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjH1Epe (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 28 Aug 2023 00:45:34 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6A40124;
        Sun, 27 Aug 2023 21:45:31 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-41215efeb1aso13337001cf.1;
        Sun, 27 Aug 2023 21:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693197931; x=1693802731;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vY27Gke1oB96ajh5AD3dOqqG9jvodybPgSv+D4kaopw=;
        b=kRxUFWrtKlzNUQ3R2NUuLYO3opYHP43mv/UX2YgsVEtyHCt6oGQsh86NBbNqAzhY2Y
         8LHKGHDbnmjW5fx08ocNrnC5ngYcHSj374tWWNhkFW0AnJ3miIvZxZbHEwztulhuH8cm
         vSfF97g7b1UgjXrfg6RgMmnBKf0SNQJfbbF5WjDo1swT1paXJMlDh0bLidjV7WKOzS4s
         V3ArGXbxhariDPm2mMrjhyT+xmiUQNhLRc3OS6gxC+CgH8QlpE15B6TH9ao6D7oOWpzd
         w122+8njOzTtwl0lqTgQvNDJZPMvQ61FfZHmA//poIjkTgoDCMAz1futr0bk5kEvDRLO
         SGxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693197931; x=1693802731;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vY27Gke1oB96ajh5AD3dOqqG9jvodybPgSv+D4kaopw=;
        b=RuICzpOeYMK3SgrwugCRFk6a5w/z0vPZuT67xyONhpy5SOeCXWP2T3yaShWW3iVckr
         xu0y1o3zrRnn1i6EpVDQsoh8nP8feAx0NpLFWaDMMQy1i2YGJdPEbsTViQnpOw37YZ4v
         eYq1lw8vS4o22U9J1D+shKmqfm0Zr1E8jLkCZt13bz5q7U9hRX4IwzHkdFuNacm8prJX
         0527MrWajQlKMPqCfSqf8HC/dgdZsEraQSwchpqAvgGR+3LxQ4LRx3rhsEkqD7x702bC
         WeGxE6IhVzdTAbinhrSFufx1OpML0isrL9mTQB5IU1bWOoPxnfEoYa3Xdxipxqt9g3ak
         nC0Q==
X-Gm-Message-State: AOJu0YysVBvU37K8DM4BdRNd3WJ87Jh6gHcBoIvsO2Bbu7ddnXewszec
        VtHcytwt51n95lgvFYQjzWTO8VVVnmvrHSIvuIg=
X-Google-Smtp-Source: AGHT+IFG+p5mJS39TNQcREMuB5881GGPrKIzdXLGR9e5/ReNLQCLRF/KuOtHZBphA6Z8rcy/8V3/bK/Bt+jU+rCSUBs=
X-Received: by 2002:ac8:5a4d:0:b0:410:aa02:264b with SMTP id
 o13-20020ac85a4d000000b00410aa02264bmr20127255qta.36.1693197930860; Sun, 27
 Aug 2023 21:45:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230803060938.1929759-1-zhangshida@kylinos.cn> <169123801881.1434487.17826581768728323102.b4-ty@mit.edu>
In-Reply-To: <169123801881.1434487.17826581768728323102.b4-ty@mit.edu>
From:   Stephen Zhang <starzhangzsd@gmail.com>
Date:   Mon, 28 Aug 2023 12:44:54 +0800
Message-ID: <CANubcdWP9CC0HZQrbyqBomiy2opkBP1gLhnj6n9-m4sKDOyeig@mail.gmail.com>
Subject: Re: [PATCH v4] ext4: Fix rec_len verify error
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     adilger.kernel@dilger.ca, yi.zhang@huawei.com, djwong@kernel.org,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhangshida@kylinos.cn, stable@kernel.org,
        Andreas Dilger <adilger@dilger.ca>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Theodore Ts'o <tytso@mit.edu> =E4=BA=8E2023=E5=B9=B48=E6=9C=885=E6=97=A5=E5=
=91=A8=E5=85=AD 20:20=E5=86=99=E9=81=93=EF=BC=9A
>
>
> On Thu, 03 Aug 2023 14:09:38 +0800, zhangshida wrote:
> > With the configuration PAGE_SIZE 64k and filesystem blocksize 64k,
> > a problem occurred when more than 13 million files were directly create=
d
> > under a directory:
> >
> > EXT4-fs error (device xx): ext4_dx_csum_set:492: inode #xxxx: comm xxxx=
x: dir seems corrupt?  Run e2fsck -D.
> > EXT4-fs error (device xx): ext4_dx_csum_verify:463: inode #xxxx: comm x=
xxxx: dir seems corrupt?  Run e2fsck -D.
> > EXT4-fs error (device xx): dx_probe:856: inode #xxxx: block 8188: comm =
xxxxx: Directory index failed checksum
> >
> > [...]
>
> Applied, thanks!
>
> [1/1] ext4: Fix rec_len verify error
>       (no commit info)

Hi Ted,

It appears that you might have missed this one in the recent git tree.
The presence of "(no commit info)" may indicate some apply failures.

Best regards,
Shida
>
> Best regards,
> --
> Theodore Ts'o <tytso@mit.edu>
