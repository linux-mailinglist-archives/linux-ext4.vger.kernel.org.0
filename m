Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9323063209E
	for <lists+linux-ext4@lfdr.de>; Mon, 21 Nov 2022 12:30:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbiKULaR (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 21 Nov 2022 06:30:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbiKUL3k (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 21 Nov 2022 06:29:40 -0500
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6C06B97F3
        for <linux-ext4@vger.kernel.org>; Mon, 21 Nov 2022 03:24:34 -0800 (PST)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-398cff43344so60649207b3.0
        for <linux-ext4@vger.kernel.org>; Mon, 21 Nov 2022 03:24:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z0Yxxijw1rGvRh5thj+hdyAsK4hKNzeEn6cA7Ahy6R4=;
        b=HG+D9UeDx4HZ6s3bsFbtXomKMBm/Wsv0I8Gt2SAPNz80qn0WqEBfTEO8M31PajsupY
         2e2I7NaniuTDmzgpj9jtSwvC9pd2QV17kMFnPZm/bS954/kqXxbBe0IizUPf+pnYAuZQ
         4Jebxz2oro59V4Fknt82a0kr7PusZAoySnkYbDNtLWec6n4Lgn4vCFInXEQ0fL5WpgHO
         42Td3zL/3UdQ51/IW9Jp0ogB+rssDwWzqOekV9hUCWPMoXfQjPbsu9P1BBTL84gi1eIO
         SbSCVGmubesPca1HwX69V3LIetUcELmuN3E+UB5C0h0zmZD494Td67Lk7Td3FoXtkRMf
         RMJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z0Yxxijw1rGvRh5thj+hdyAsK4hKNzeEn6cA7Ahy6R4=;
        b=be0wQstMeh7vXigVTpglVdMil2QT03h9LU5XPjjTa1l0aB8V4hvTWj/djv+m/0Mg1K
         8cYKK28kGqL6TitWIe3C6mVmldf96Kiw8vokGc9z891rzOptawumZfGfs6yEQzHQ5Dxw
         qf8BCMZmnHMiWTCl7KPhTBY34Ixr4lnh/2+zC4XmtSU8tWtERbBtDrT8wCDlFlS/VcYY
         7KxNTWslJT4gX7PxKBz/eEFQZdchnGFbkAB7pQw8xmEyFLsqUU4IFZ0dZ7Ayxvf+rC2D
         4Nbepghhr533QQR4fOZ/+3vRafwSnymxsNjkn4eJi1f/bEw3sw0qTCQ+Hhc5P28Awcmm
         U22w==
X-Gm-Message-State: ANoB5pmSb2I+sce42rf2tcRklZa5pV/jgY9oObons89bO4rvdgutX44y
        kstQSsB/NM7+9G3+q9XKMPHXqlb8byWiWSV0HZfjLA==
X-Google-Smtp-Source: AA0mqf6lonTuOQc++bsUBoOIUNs2D/PyEdavPXG4/IVfsvUOai8Ap31tSYnDgK3s6D8683TvgIcwbu86D7SigqsG2s8=
X-Received: by 2002:a81:a18e:0:b0:368:b923:b500 with SMTP id
 y136-20020a81a18e000000b00368b923b500mr873052ywg.10.1669029873914; Mon, 21
 Nov 2022 03:24:33 -0800 (PST)
MIME-Version: 1.0
References: <20221114082935.3007497-1-glider@google.com> <Y3KG9bAo11t84SIg@gmail.com>
In-Reply-To: <Y3KG9bAo11t84SIg@gmail.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Mon, 21 Nov 2022 12:23:57 +0100
Message-ID: <CAG_fn=VaBW3NBULC1JGhJW7hhWBb-h6Me_wecktt0Mgo+m8VeQ@mail.gmail.com>
Subject: Re: [PATCH] fs: ext4: initialize fsdata in pagecache_write()
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        tytso@mit.edu, adilger.kernel@dilger.ca, jaegeuk@kernel.org,
        chao@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org,
        syzbot+9767be679ef5016b6082@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Nov 14, 2022 at 7:20 PM Eric Biggers <ebiggers@kernel.org> wrote:
>
> On Mon, Nov 14, 2022 at 09:29:35AM +0100, Alexander Potapenko wrote:
> > [PATCH] fs: ext4: initialize fsdata in pagecache_write()
> >
> > When aops->write_begin() does not initialize fsdata, KMSAN reports
> > an error passing the latter to aops->write_end().
> >
> > Fix this by unconditionally initializing fsdata.
> >
> > Also speculatively fix similar issues in affs, f2fs, hfs, hfsplus,
> > as suggested by Eric Biggers.
>
> You might have better luck with separate patches for each filesystem, as =
it
> might be hard to get someone to apply this patch otherwise.

Done.
Please disregard this patch.

> If you do go with a single patch, then the subject prefix should be "fs:"=
, not
> "fs: ext4:".
>
> - Eric



--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
