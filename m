Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DBA33BA09B
	for <lists+linux-ext4@lfdr.de>; Fri,  2 Jul 2021 14:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232271AbhGBMlS (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 2 Jul 2021 08:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232233AbhGBMlQ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 2 Jul 2021 08:41:16 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F72EC061764
        for <linux-ext4@vger.kernel.org>; Fri,  2 Jul 2021 05:38:43 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id gn32so15948380ejc.2
        for <linux-ext4@vger.kernel.org>; Fri, 02 Jul 2021 05:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TejoEZ6PvhDR6/vKnlCgTBQKFLG9ws1K525Cz+uqRss=;
        b=q+VryZfZlPZSEnfM22oyE1OsMkDXFLAqmpiBkUk4KIQVMvhqdnRnPfoMzd08w9/GVw
         WVBztUsXpOFNtS3JeBQ1ey6GxnWnP2/aR/T2KZiJ6Ja3GW+DkKj+8b1OybetowjhzO0J
         uKFnX1Up/FLl4aaCtxd1XCytVJrI0fxUgWirqajKIN8kaYtQ+S067CIN15z/RoBhT+ha
         gZ2GS1vV/v57wrM2KVO+i6Xmcbe7cZSlY6/Bw4V0zGY8EYHRGroYx5xYGtK+ML7aKzAa
         1sG6DEOCx9j+YIe257IAp8sKsZbIdeEnZQcPG3vy6uWursqKg9xKxON/EXCg6VkePNqv
         QRJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TejoEZ6PvhDR6/vKnlCgTBQKFLG9ws1K525Cz+uqRss=;
        b=eao7QuDh8TvAgsLpB++4aZi53wctRBxH27E8rwrQuqOplkInf06eOB2uMJ7jT3wzjW
         A0VS28XPUROt7qHpMCrBd9pW0SqgPrTwNGumoyOzT0eYUUVjgrNMNQ2x8MoKFXfAT6G8
         +zsb/EHQxGdMKrvjiLJDEuVod1S67SVX1dAD9LVNAZo1ednn7vh1IWOXkVNHGqZ4wTWl
         sm8KyMGUsIw06POkYRK6p/Re1BezTNZc4YbAPx1lw54ZB8Uv9j5sZFlgqS7MxZV4PyTQ
         d8LxPyT6OPKBBGBWcaEjKg2Lsu/JJw0Fpei6bYZvFHodJdM5w8LHBQe8M7XAMArcsFz7
         pbVg==
X-Gm-Message-State: AOAM530hD8V7IN7NnDN5Y6emWuLP0ZVkdf212TYZ1QRaWRYIzxU3HeaP
        uy1XoMdob8cB977xVaQozB5oHmmc1U3g++Om9t1FYQ==
X-Google-Smtp-Source: ABdhPJy2T5F8l8QmzzJ7o24iwSWZG5I9WgE9TfFMy/4Nq1nG7PIA5FfoGfDfCtgp1rNasiTAHaL+DPKH9xoGnEFyIB0=
X-Received: by 2002:a17:906:25db:: with SMTP id n27mr4989541ejb.170.1625229521558;
 Fri, 02 Jul 2021 05:38:41 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYuBvh-H8Vqp58j-coXUD8p1A6h2it_aZdRiYcN2soGNdg@mail.gmail.com>
In-Reply-To: <CA+G9fYuBvh-H8Vqp58j-coXUD8p1A6h2it_aZdRiYcN2soGNdg@mail.gmail.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 2 Jul 2021 18:08:29 +0530
Message-ID: <CA+G9fYszTVESKbiORBj=bvZX3qco474yYhWDV3ccveScqt41YA@mail.gmail.com>
Subject: Re: [mainline] [arm64] Internal error: Oops - percpu_counter_add_batch
To:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        regressions@lists.linux.dev,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-ext4 <linux-ext4@vger.kernel.org>
Cc:     Ritesh Harjani <riteshh@linux.ibm.com>,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Theodore Tso <tytso@mit.edu>, lkft-triage@lists.linaro.org,
        linux-fsdevel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jens Axboe <axboe@kernel.dk>, Zhang Yi <yi.zhang@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, 2 Jul 2021 at 13:54, Naresh Kamboju <naresh.kamboju@linaro.org> wro=
te:
>
> Results from Linaro=E2=80=99s test farm.
> Regression found on arm64 on Linux mainline tree.

Regression found on arm64, arm and i386 on Linux mainline tree.
But x86_64 tests PASS.

>
> The following kernel crash was noticed while running LTP fs_fill test cas=
e on
> arm64 devices Linus ' mainline tree (this is not yet tagged / released).
>
> This regression  / crash is easy to reproduce.
>
> fs_fill.c:53: TINFO: Unlinking mntpoint/thread6/file2
> fs_fill.c:87: TPASS: Got 6 ENOSPC runtime 3847ms
> [ 1140.055715] Unable to handle kernel paging request at virtual
> address ffff76a8a6b59000

ref;
https://lore.kernel.org/regressions/CA+G9fYuBvh-H8Vqp58j-coXUD8p1A6h2it_aZd=
RiYcN2soGNdg@mail.gmail.com/T/#u

- Naresh
