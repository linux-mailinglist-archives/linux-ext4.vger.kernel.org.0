Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D648702C48
	for <lists+linux-ext4@lfdr.de>; Mon, 15 May 2023 14:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241358AbjEOMG5 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 15 May 2023 08:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241292AbjEOMGz (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 15 May 2023 08:06:55 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AF4B136
        for <linux-ext4@vger.kernel.org>; Mon, 15 May 2023 05:06:54 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-50be17a1eceso23550725a12.2
        for <linux-ext4@vger.kernel.org>; Mon, 15 May 2023 05:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684152413; x=1686744413;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zr9KZGxUJkcomCcIJwuLOskmJyis8iDrLSarXXkxb5U=;
        b=XXEdUzXCUCwi3A2Xr2UHZMvAlerBbza3YyxHaabZT/8vgVamnsG7oXi5iufkdi2SeZ
         uwaub0whUGxQFUV7suqY8Je1AyB4hQxJcuMD634jMcLJVEUTWGeFMv8xhr2/DUWCLqlH
         gGHXjBivXKQcGxpT9qtkGBj/4hSz/Kg5NwPbgP+ha5QyaSYzVix4Gx60C+o3Aq2Sw6n5
         MyOaLTBh7iJLHjYrBfRqTrzIZxhFkksq00TvEaXQZsiGJl4Wj4KfyDe7yVY9PeEtgRvW
         Zwz8aoL529uRFOmj6f1bvp/XJXCpsFgsS+a4tqXdIOmhEfKQ63tAOxByxMsPEwI6jfio
         vPfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684152413; x=1686744413;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zr9KZGxUJkcomCcIJwuLOskmJyis8iDrLSarXXkxb5U=;
        b=NajZxWLTWliOGLWBvjOFlslUSmF3V8ivakJP5g2fNdj4s/4rPbGlLxvmJ151IUs0kA
         ZgjaJspZATpvGulS5En+xJjmyPTVXFoKVQM+358fsPijZO4wIAhvMV/HFMz/G1omtyO5
         c2uzF292MNeqg2p8AwwgwtZhu7uQrEqIrdVmpCd2e0wgqlBB4pv9EFIkyqdnrKv+QTAg
         tjbNgRva9aWI7qh0Oqlj7vuN5ZUluJG0db2KPltOgclcK7GNASZXZSVoHZhkseqYWxDH
         OOvEryp3cZUSQRFuenpundMICpyheOwIWdYDVMcOLbUdNB1biWTgu77EYjhDIHo9G5hZ
         zoGQ==
X-Gm-Message-State: AC+VfDxEUnDUWfjxIllMfrLDLn6+f2C4U4mCh13I3DhV5+Asv8TqXYOL
        VBxLqMirM9rp22V3Xsfe6JCG2fOyNiUHo1f60/Y=
X-Google-Smtp-Source: ACHHUZ6UIMJql3EKCZi3qrkigtKuzJDe+XTtazUiwLTrTOrhwq1tnBvrRx4IH+dPz9u938cIiVPlYulpxEnmmX+TDpI=
X-Received: by 2002:aa7:d641:0:b0:50d:8aaf:7ad9 with SMTP id
 v1-20020aa7d641000000b0050d8aaf7ad9mr23168179edr.12.1684152412834; Mon, 15
 May 2023 05:06:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230428185517.1201-1-sunjunchao2870@gmail.com> <20230502094158.tubal42rp2khprah@quack3>
In-Reply-To: <20230502094158.tubal42rp2khprah@quack3>
From:   JunChao Sun <sunjunchao2870@gmail.com>
Date:   Mon, 15 May 2023 20:06:39 +0800
Message-ID: <CAHB1NagDZjigky_JqwRyURYnt=Nmjuf3eWLFsiUWmRgYSW5Ayw@mail.gmail.com>
Subject: Re: [PATCH] ext4: Optimize memory usage in xattr
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Friendly ping...

Jan Kara <jack@suse.cz> =E4=BA=8E2023=E5=B9=B45=E6=9C=882=E6=97=A5=E5=91=A8=
=E4=BA=8C 17:41=E5=86=99=E9=81=93=EF=BC=9A
>
> On Fri 28-04-23 11:55:17, JunChao Sun wrote:
> > Currently struct ext4_attr_info->in_inode use int, but the
> > value is only 0 or 1, so replace int with bool.
> >
> > Signed-off-by: JunChao Sun <sunjunchao2870@gmail.com>
>
> Looks fine. Feel free to add:
>
> Reviewed-by: Jan Kara <jack@suse.cz>
>
>                                                                 Honza
>
> > ---
> >  fs/ext4/xattr.c | 8 ++++----
> >  fs/ext4/xattr.h | 2 +-
> >  2 files changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
> > index 767454d..d57408c 100644
> > --- a/fs/ext4/xattr.c
> > +++ b/fs/ext4/xattr.c
> > @@ -1639,7 +1639,7 @@ static int ext4_xattr_set_entry(struct ext4_xattr=
_info *i,
> >       struct ext4_xattr_entry *last, *next;
> >       struct ext4_xattr_entry *here =3D s->here;
> >       size_t min_offs =3D s->end - s->base, name_len =3D strlen(i->name=
);
> > -     int in_inode =3D i->in_inode;
> > +     bool in_inode =3D i->in_inode;
> >       struct inode *old_ea_inode =3D NULL;
> >       struct inode *new_ea_inode =3D NULL;
> >       size_t old_size, new_size;
> > @@ -2354,7 +2354,7 @@ static struct buffer_head *ext4_xattr_get_block(s=
truct inode *inode)
> >               .name =3D name,
> >               .value =3D value,
> >               .value_len =3D value_len,
> > -             .in_inode =3D 0,
> > +             .in_inode =3D false,
> >       };
> >       struct ext4_xattr_ibody_find is =3D {
> >               .s =3D { .not_found =3D -ENODATA, },
> > @@ -2441,7 +2441,7 @@ static struct buffer_head *ext4_xattr_get_block(s=
truct inode *inode)
> >               if (ext4_has_feature_ea_inode(inode->i_sb) &&
> >                   (EXT4_XATTR_SIZE(i.value_len) >
> >                       EXT4_XATTR_MIN_LARGE_EA_SIZE(inode->i_sb->s_block=
size)))
> > -                     i.in_inode =3D 1;
> > +                     i.in_inode =3D true;
> >  retry_inode:
> >               error =3D ext4_xattr_ibody_set(handle, inode, &i, &is);
> >               if (!error && !bs.s.not_found) {
> > @@ -2467,7 +2467,7 @@ static struct buffer_head *ext4_xattr_get_block(s=
truct inode *inode)
> >                                */
> >                               if (ext4_has_feature_ea_inode(inode->i_sb=
) &&
> >                                   i.value_len && !i.in_inode) {
> > -                                     i.in_inode =3D 1;
> > +                                     i.in_inode =3D true;
> >                                       goto retry_inode;
> >                               }
> >                       }
> > diff --git a/fs/ext4/xattr.h b/fs/ext4/xattr.h
> > index 824faf0..355d373 100644
> > --- a/fs/ext4/xattr.h
> > +++ b/fs/ext4/xattr.h
> > @@ -113,7 +113,7 @@ struct ext4_xattr_info {
> >       const void *value;
> >       size_t value_len;
> >       int name_index;
> > -     int in_inode;
> > +     bool in_inode;
> >  };
> >
> >  struct ext4_xattr_search {
> > --
> > 1.8.3.1
> >
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
