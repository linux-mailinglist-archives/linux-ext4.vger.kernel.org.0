Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA0CF65CBB3
	for <lists+linux-ext4@lfdr.de>; Wed,  4 Jan 2023 02:57:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233893AbjADB5o (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 3 Jan 2023 20:57:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjADB5n (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 3 Jan 2023 20:57:43 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 978851740C
        for <linux-ext4@vger.kernel.org>; Tue,  3 Jan 2023 17:57:42 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id p2so18487551ljn.7
        for <linux-ext4@vger.kernel.org>; Tue, 03 Jan 2023 17:57:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TLKBUphXfs/UWZdenQBIRYJf0m4RI75UDSLQL1B/F20=;
        b=KTelfnNN/7MymnnCGQBQslfVwxbDJd4c80V4g70R0Px9RHiEZnKnMlGopzmHb/sHkD
         7qOFXZwsVZ2unvCGIGSwxXbcgTFaFm59MaHjMYVuo3YrgjIKmU0ezIhQwoBpGBr25yW6
         /pbMHzg7Ic+WOGK+R0q1ePBsSwbVKsiGce2iQNcKbd8PMMBMNPGpQRN7PIoUzaaB7ccj
         OWh/LTsiw/6vO+HRLH39dAQh/sZQHq2DEwFoG7zHR1vE+b8fUP89xZKQvyQZ1mGciMXJ
         eEahFtDJVCRsgmQaPWgQ4HVzjf9t6zW75QKrz0/8MigMknrKJakTub06FBCfVo1r33HY
         M8ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TLKBUphXfs/UWZdenQBIRYJf0m4RI75UDSLQL1B/F20=;
        b=HTuS49eB3AXoAI22oigLo66x3+8PGZWudSSBp7saTIEPaviYpTz/xIrujttPnW15Q/
         ZArpCaQZ1avB08z7e0SUScdrmQEOKZYFwYRGhVgfco6fbaa4Xpu4WQcHUFPFWigGFpLr
         VoW86fqCDAyyMSIe8MrmeOLMhYfn6SpC8fTuPuPtPYXQsWpIR0g776SR6Cs0JBXeDD0r
         8NVx0tcepRs6jvgiBSSKkKS+vC4/pJ3lnS1bcagjSdSDCwHTL0Hb5ZdGuYiYxF6a3i48
         T6TUsBbgfntt8DG/FgsI2xRUhttfFFhFisYzFbRRUjuLM0ULXn3ZQXs6kZQzV220DsIp
         mjJg==
X-Gm-Message-State: AFqh2kqG4hoW/RGbXllo3Ug2NE853TSjHKDXcLR3q4c/ZhOsG0C37RAT
        dw1qk674ISS/T1KLdpGuQOGUyGR3OlBCErtq/GZH5g==
X-Google-Smtp-Source: AMrXdXtOV1gbwyd4IezCo8uK3Ns0+zwKr+ZVt4Q8/AS6jf5i7PWXBlod+9hH0r3BrhnLx8mBTr/BN0NR0lSB6ueGhiA=
X-Received: by 2002:a2e:a593:0:b0:280:54b:9254 with SMTP id
 m19-20020a2ea593000000b00280054b9254mr74610ljp.165.1672797460849; Tue, 03 Jan
 2023 17:57:40 -0800 (PST)
MIME-Version: 1.0
References: <20221229014502.2322727-1-jun.nie@linaro.org> <Y7R/QKIbYQ2TCP+W@magnolia>
In-Reply-To: <Y7R/QKIbYQ2TCP+W@magnolia>
From:   Jun Nie <jun.nie@linaro.org>
Date:   Wed, 4 Jan 2023 09:58:03 +0800
Message-ID: <CABymUCPCT9KbMQDUTxwf6A+Cg9fWJNkefbMHD7SZD3Fc7FMFHg@mail.gmail.com>
Subject: Re: [PATCH] ext4: reject 1k block fs on the first block of disk
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        tudor.ambarus@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Darrick J. Wong <djwong@kernel.org> =E4=BA=8E2023=E5=B9=B41=E6=9C=884=E6=97=
=A5=E5=91=A8=E4=B8=89 03:17=E5=86=99=E9=81=93=EF=BC=9A
>
> On Thu, Dec 29, 2022 at 09:45:02AM +0800, Jun Nie wrote:
> > For 1k-block filesystems, the filesystem starts at block 1, not block 0=
.
> > If start_fsb is 0, it will be bump up to s_first_data_block. Then
> > ext4_get_group_no_and_offset don't know what to do and return garbage
> > results (blockgroup 2^32-1). The underflow make index
> > exceed es->s_groups_count in ext4_get_group_info() and trigger the BUG_=
ON.
> >
> > Fixes: 4a4956249dac0 ("ext4: fix off-by-one fsmap error on 1k block fil=
esystems")
> > Link: https://syzkaller.appspot.com/bug?id=3D79d5768e9bfe362911ac1a5057=
a36fc6b5c30002
> > Reported-by: syzbot+6be2b977c89f79b6b153@syzkaller.appspotmail.com
> > Signed-off-by: Jun Nie <jun.nie@linaro.org>
> > ---
> >  fs/ext4/fsmap.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/fs/ext4/fsmap.c b/fs/ext4/fsmap.c
> > index 4493ef0c715e..1aef127b0634 100644
> > --- a/fs/ext4/fsmap.c
> > +++ b/fs/ext4/fsmap.c
> > @@ -702,6 +702,12 @@ int ext4_getfsmap(struct super_block *sb, struct e=
xt4_fsmap_head *head,
> >               if (handlers[i].gfd_dev > head->fmh_keys[0].fmr_device)
> >                       memset(&dkeys[0], 0, sizeof(struct ext4_fsmap));
> >
> > +             /*
> > +              * Re-check the range after above limit operation and rej=
ect
> > +              * 1K fs on block 0 as fs should start block 1. */
> > +             if (dkeys[0].fmr_physical =3D=3D0 && dkeys[1].fmr_physica=
l =3D=3D 0)
> > +                     continue;
>
> ...and if this filesystem has 4k blocks, and therefore *does* define a
> block 0?

Yes, this is a real corner case test :-)

>
> --D
>
> > +
> >               info.gfi_dev =3D handlers[i].gfd_dev;
> >               info.gfi_last =3D false;
> >               info.gfi_agno =3D -1;
> > --
> > 2.34.1
> >
