Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2F6876C205
	for <lists+linux-ext4@lfdr.de>; Wed,  2 Aug 2023 03:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbjHBBRp (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 1 Aug 2023 21:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjHBBRo (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 1 Aug 2023 21:17:44 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2265C1FD6;
        Tue,  1 Aug 2023 18:17:43 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-4039a42467fso39542281cf.3;
        Tue, 01 Aug 2023 18:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690939062; x=1691543862;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QQrwIXD5dDDpJmHwDNXT7LmVeplj3HZJ96SaM0Uz30w=;
        b=gIacevkryuRhr3Q5CxOfkxyGZNYAi3A6JsOpy5l5uAjH9gx7w98/vJ3U0yQKEGltai
         nObvQo/CiCnYQmVITE2VKTKBeE5gGfIG6SBipuIGuazuP/j5Ubos5pvC+hUvm56RRoM0
         MYEP+BQQxgmJRw1X7QS+BxHjqMGlJjlWrMLJoFn5B+kaeTjZeeaFqKNi7OLoncAZ+NcF
         +K6hrWMqsiRQKlpMQmLLNT4yA1QOSRDVmPi833OfQFOA8B9f7Jjo65qMMPTlxOJYpygX
         /wYTtY8k+H3WuMXTf7Xlw5Pz+a/hQwiGizemw+DHD9Bvc4ySlQmMq/bpyhcWGjJCsuzB
         B/Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690939062; x=1691543862;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QQrwIXD5dDDpJmHwDNXT7LmVeplj3HZJ96SaM0Uz30w=;
        b=VTTKwzKP0XMIunSSlIVIyGJvYPEJ2okFbCV4lybpPBFYib7060wEkQPR7wkO/wwnnk
         6Kk6SS3n5zipj6DHCDYdU2bNbdUJxHi9UyHCY4psGZKbOcNu176vG/0N3RgkjATv5th7
         ModHI/Ha4f+DB3RmauIhexGM1vLbT3RNvwVznldwsAlvtnvcnnWOIQI1aI0H8MwAhc3L
         qK3Mc7yQhL7DBqKlTm2qtLgEvoGusD6DDkpYwfGOV9qU9Vknm6/TsDD5tWckYUYxD2MU
         3BpzrbV7b6YW+9bN8f8DnqHt7mzjLt/Lkp+M6RNuHUab3OeMeWQq3Je72cmfLHjWLEcH
         NlWQ==
X-Gm-Message-State: ABy/qLaN+DEoGsW6fZPm6JT5lRb9LyCzZ9YYG8jxIc/wMDTHxm0hq8x2
        Qy+85rb+jhQwTDyIgb6T+X2B/n2vGtYKJpW33L0=
X-Google-Smtp-Source: APBJJlFMg0FmHg3iwIk519p5at2sihrjdSJvqExK5yB8wbEh+sb+2A2aCebpYXjFh2HVH594SpOvNJcR4A0bIdEWELk=
X-Received: by 2002:a05:622a:1109:b0:403:1d93:b210 with SMTP id
 e9-20020a05622a110900b004031d93b210mr18963271qty.59.1690939061959; Tue, 01
 Aug 2023 18:17:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230801112337.1856215-1-zhangshida@kylinos.cn> <20230801151828.GB11332@frogsfrogsfrogs>
In-Reply-To: <20230801151828.GB11332@frogsfrogsfrogs>
From:   Stephen Zhang <starzhangzsd@gmail.com>
Date:   Wed, 2 Aug 2023 09:17:05 +0800
Message-ID: <CANubcdX2-T1QpDRmvddL-9bme4ZeFvre4N_nsw=gursx9zSQhg@mail.gmail.com>
Subject: Re: [PATCH v3] ext4: Fix rec_len verify error
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, yi.zhang@huawei.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhangshida@kylinos.cn, stable@kernel.org,
        Andreas Dilger <adilger@dilger.ca>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Darrick J. Wong <djwong@kernel.org> =E4=BA=8E2023=E5=B9=B48=E6=9C=881=E6=97=
=A5=E5=91=A8=E4=BA=8C 23:18=E5=86=99=E9=81=93=EF=BC=9A
>
>
> This is sitll missing some pieces; what about this clause at line 367:
>
>         if (t->det_reserved_zero1 ||
>             le16_to_cpu(t->det_rec_len) !=3D sizeof(struct ext4_dir_entry=
_tail) ||
>             t->det_reserved_zero2 ||
>             t->det_reserved_ft !=3D EXT4_FT_DIR_CSUM)
>                 return NULL;
>

Yeah...

> > @@ -445,13 +445,13 @@ static struct dx_countlimit *get_dx_countlimit(st=
ruct inode *inode,
> >       struct ext4_dir_entry *dp;
> >       struct dx_root_info *root;
> >       int count_offset;
> > +     int blocksize =3D EXT4_BLOCK_SIZE(inode->i_sb);
> >
> > -     if (le16_to_cpu(dirent->rec_len) =3D=3D EXT4_BLOCK_SIZE(inode->i_=
sb))
> > +     if (ext4_rec_len_from_disk(dirent->rec_len, blocksize) =3D=3D blo=
cksize)
> >               count_offset =3D 8;
> > -     else if (le16_to_cpu(dirent->rec_len) =3D=3D 12) {
> > +     else if (ext4_rec_len_from_disk(dirent->rec_len, blocksize) =3D=
=3D 12) {
>
> Why not lift this ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ to a
> local variable?  @dirent doesn't change, right?
>

Will do.

> >               dp =3D (struct ext4_dir_entry *)(((void *)dirent) + 12);
> > -             if (le16_to_cpu(dp->rec_len) !=3D
> > -                 EXT4_BLOCK_SIZE(inode->i_sb) - 12)
> > +             if (ext4_rec_len_from_disk(dp->rec_len, blocksize) !=3D b=
locksize - 12)
> >                       return NULL;
> >               root =3D (struct dx_root_info *)(((void *)dp + 12));
> >               if (root->reserved_zero ||
>
> What about dx_make_map?
>

dx_make_map(
     ....
     map_tail->size =3D le16_to_cpu(de->rec_len);

That might be a questionable one...
map_tail->size is 16 bit, while the key reason we want ext4_rec_len_from_di=
sk
is converting 16-bit rec_len disk form to a in-memory form consisting of li=
ke 17
bits...i.e. 0x10000.

Cheers,
Shida


> Here's all the opencoded access I could find:
>
> $ git grep le16.*rec_len fs/ext4/
> fs/ext4/namei.c:356:                le16_to_cpu(d->rec_len));
> fs/ext4/namei.c:367:        le16_to_cpu(t->det_rec_len) !=3D sizeof(struc=
t ext4_dir_entry_tail) ||
> fs/ext4/namei.c:449:    if (le16_to_cpu(dirent->rec_len) =3D=3D EXT4_BLOC=
K_SIZE(inode->i_sb))
> fs/ext4/namei.c:451:    else if (le16_to_cpu(dirent->rec_len) =3D=3D 12) =
{
> fs/ext4/namei.c:453:            if (le16_to_cpu(dp->rec_len) !=3D
> fs/ext4/namei.c:1338:                   map_tail->size =3D le16_to_cpu(de=
->rec_len);
>
> --D
>
> > --
> > 2.27.0
> >
