Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 261226ED46A
	for <lists+linux-ext4@lfdr.de>; Mon, 24 Apr 2023 20:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbjDXScf (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 24 Apr 2023 14:32:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbjDXSce (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 24 Apr 2023 14:32:34 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A297FFA;
        Mon, 24 Apr 2023 11:32:33 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-94f32588c13so679634166b.2;
        Mon, 24 Apr 2023 11:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682361152; x=1684953152;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9j7T0oh2jPBNqIhnL5Zd7ZvIl+BIHbhG56f1IEtAnsk=;
        b=en79UB4wt62yJCnBGb6twRBbCxYLox2y5I6QJ/26Exf8YCoPS+UJxVXjSPGhXeMw+5
         PCOyiBJeFMZb0xc3LljzcK469KyXcIZVSZ6TwsAq2sKK43LLvD+J860OvE/4qEASN9xX
         r/Zso7tM1vb8JPyVXTbOo9LsI/s+N43OXGGYrHSq1vAmUPhIVHIzhqiZTCpaWdlyJess
         gxlpZTDlMaj9Pw/uCNrIdR9sZRl/BBrshqRy9r7v5rxctn5YexeJS9A+97aTpT86tsTI
         Ix6n1yiWGzXyAURdojPl8ycDOrJ7w3HsoO3HD7inQf8ZjoF51r4SNKg2A5XejOE6NYi6
         rOCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682361152; x=1684953152;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9j7T0oh2jPBNqIhnL5Zd7ZvIl+BIHbhG56f1IEtAnsk=;
        b=IMqwCCc15J/4MaDMpsDv/rLxBCs6lipn5Kzksx+BQeKrFTA97MzqQAICQl99dVT7dK
         E+pNB/HAavOARmnBwKop9mfX1tnvpsnBCpZCcPalsiWi8m7dJSjbG8A7z1wSSTKI87cn
         nXleIjUK8UiwlltiqQX7DMz+idH16cajxAv4qQ58AZY9QiTrYniICttG4t8bm2ZH69oc
         M/7+hS6gksGbCS+okjpzUaPhVM3aT4adVcATwloVJ/vdC42yJLf5tCGbSodr+QUojuU9
         pTsWW/7cfovSYzZtym6f7Yuu8oWPPIg/QZi7oRHWl9C+xpZNo2T76sb6zmN3IQFJU6rQ
         zL/g==
X-Gm-Message-State: AAQBX9dUuWPoUSj1+NYzVAAUt3dP0iUzzQQvFuWOokF/6AzvjNhVO0Lu
        cM8WK84W6nNWpiviEOvgV66fjccUVqA6DObf+a9mP/kw
X-Google-Smtp-Source: AKy350ZFCjsGX+dkjKKCmINnLibMTKt32R4FmrvVFWLj1lc0yi/LWbG9mFrKkNky/b82XZMceMaE36nPPWlXCD6MxC4=
X-Received: by 2002:a05:6402:5152:b0:502:2494:b8fc with SMTP id
 n18-20020a056402515200b005022494b8fcmr11096669edd.7.1682361151900; Mon, 24
 Apr 2023 11:32:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230421014750.2315938-1-goldstein.w.n@gmail.com> <20230424162413.hiimozuw44fhht4a@quack3>
In-Reply-To: <20230424162413.hiimozuw44fhht4a@quack3>
From:   Noah Goldstein <goldstein.w.n@gmail.com>
Date:   Mon, 24 Apr 2023 13:32:20 -0500
Message-ID: <CAFUsyf+VXZxy98BRwpZ_ikABHDmmC5xMCWnbRzQQoxfs8SZ54g@mail.gmail.com>
Subject: Re: [PATCH v1] ext4: move `ext4_count_free` to ext4.h so it can be
 easily inlined
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Apr 24, 2023 at 11:24=E2=80=AFAM Jan Kara <jack@suse.cz> wrote:
>
> On Thu 20-04-23 20:47:49, Noah Goldstein wrote:
> > `ext4_count_free` is a one-line helper that is clearly better off
> > being inlined. This saves a handful instructions in `vmlinux` on x86.
> >
> > Instruction estimates use `wc -l` on `objdump`
> > Before: 8539271
> > After : 8539248
> >
> > So saves roughly 20 instructions
> >
> > Signed-off-by: Noah Goldstein <goldstein.w.n@gmail.com>
>
> Looks fine. Feel free to add:
>
> Reviewed-by: Jan Kara <jack@suse.cz>
>
Done, thank you.

>                                                                 Honza
>
> > ---
> >  fs/ext4/bitmap.c | 5 -----
> >  fs/ext4/ext4.h   | 6 +++++-
> >  2 files changed, 5 insertions(+), 6 deletions(-)
> >
> > diff --git a/fs/ext4/bitmap.c b/fs/ext4/bitmap.c
> > index f63e028c638c..c3cd2b878bbd 100644
> > --- a/fs/ext4/bitmap.c
> > +++ b/fs/ext4/bitmap.c
> > @@ -11,11 +11,6 @@
> >  #include <linux/buffer_head.h>
> >  #include "ext4.h"
> >
> > -unsigned int ext4_count_free(char *bitmap, unsigned int numchars)
> > -{
> > -     return numchars * BITS_PER_BYTE - memweight(bitmap, numchars);
> > -}
> > -
> >  int ext4_inode_bitmap_csum_verify(struct super_block *sb, ext4_group_t=
 group,
> >                                 struct ext4_group_desc *gdp,
> >                                 struct buffer_head *bh, int sz)
> > diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> > index 08b29c289da4..6e1d3c175a70 100644
> > --- a/fs/ext4/ext4.h
> > +++ b/fs/ext4/ext4.h
> > @@ -2675,7 +2675,11 @@ struct mmpd_data {
> >  # define NORET_AND   noreturn,
> >
> >  /* bitmap.c */
> > -extern unsigned int ext4_count_free(char *bitmap, unsigned numchars);
> > +static inline unsigned int ext4_count_free(char *bitmap, unsigned int =
numchars)
> > +{
> > +     return numchars * BITS_PER_BYTE - memweight(bitmap, numchars);
> > +}
> > +
> >  void ext4_inode_bitmap_csum_set(struct super_block *sb, ext4_group_t g=
roup,
> >                               struct ext4_group_desc *gdp,
> >                               struct buffer_head *bh, int sz);
> > --
> > 2.34.1
> >
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
