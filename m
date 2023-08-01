Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62A9276A6F0
	for <lists+linux-ext4@lfdr.de>; Tue,  1 Aug 2023 04:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229437AbjHAC1d (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 31 Jul 2023 22:27:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbjHAC1d (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 31 Jul 2023 22:27:33 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 524661BEB;
        Mon, 31 Jul 2023 19:27:32 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-40fcc91258fso6159251cf.1;
        Mon, 31 Jul 2023 19:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690856851; x=1691461651;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Rbx5pazMUmrAGWXYLJ8jVUiQPXWQGvpwkvAGqlRbh0=;
        b=h3zOGs2nwMAFflIW+d+RAac8jI3gm3anyQw+AZUM+tFnbQVN6xveU+nCF9wbeOgg8g
         4tihPpj9lHfVDjtsbHuBYBNrapBMrTgKtIprVlcJfMf0aOnVCNgbj15mQbNrGPXunXHu
         NLebQ3SybsZgBr373ypfDFFymz55RazrfenDbV3o2dx88m4hsmv40X8k6Bg2s5E1/WzT
         cbcoAzjwOO+LedfK/KoddJcRHo+wZ8cCHJmLwd8LiaRdSf3wu109gECOQztN+anSVgf7
         0CLlSPAWMNsY2WfsniuD6/vrzvnQx9bKbLBPjd7zvQhcmViK6NfisWeFa/VhPpTPIDzr
         L0bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690856851; x=1691461651;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Rbx5pazMUmrAGWXYLJ8jVUiQPXWQGvpwkvAGqlRbh0=;
        b=ZRoJSxfveM5JGGcUh9d/siKDeMqeln1lWBRjuIWgmerDuAwE3yJ4e0lq82wP7KCOFN
         IWD+mAUd6TxTjNO3pDGmX2zqe2fNVB8BuqnA3PrbgqnJevSxM44Tx711fyVykvq5LVy4
         HqqycXst1MurEuRxkBITZHOm50fjxkDkuTD2ZF9L4CK3NRW5LMeVbe/rQhmuGLagSHJX
         zNAFYrgD/Kv4yHTmQi9Zj6HohRU3vDlsdW35gHmxrDmU5fBrc+D8XTAYOAUv4SNXVcxW
         PLeifeMj/duSqpf8scYiBDhmZm80Q3tp11/1bLp0wD6V2xqSnm9RibFJWOb4sIEByH71
         PDuw==
X-Gm-Message-State: ABy/qLYicTExb3sscgEt0p4b0m30s/M5nkTKZDuQTd4bvsmPV8VptXW6
        EklYHKovXrP31VSK3kcDbMbQcovtjE3CpjwNhv1bQY0b8HE=
X-Google-Smtp-Source: APBJJlGLQ+Ui+4ixTGSUf1KsO8aiWE2TiP6DP67diE/qPfi4ppqInBaGAHwVbcFQfzXaCV1ecUH/q+mLgzAIICHn3LU=
X-Received: by 2002:a05:622a:24b:b0:40d:b896:1f92 with SMTP id
 c11-20020a05622a024b00b0040db8961f92mr7513815qtx.32.1690856851003; Mon, 31
 Jul 2023 19:27:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230731010104.1781335-1-zhangshida@kylinos.cn> <20230731154133.GA11332@frogsfrogsfrogs>
In-Reply-To: <20230731154133.GA11332@frogsfrogsfrogs>
From:   Stephen Zhang <starzhangzsd@gmail.com>
Date:   Tue, 1 Aug 2023 10:26:55 +0800
Message-ID: <CANubcdVMdisPOR=VD4mLyiQru4oPOZ_0oDSZXRYOu6ynTji2vA@mail.gmail.com>
Subject: Re: [PATCH v2] ext4: Fix rec_len verify error
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhangshida@kylinos.cn
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

Darrick J. Wong <djwong@kernel.org> =E4=BA=8E2023=E5=B9=B47=E6=9C=8831=E6=
=97=A5=E5=91=A8=E4=B8=80 23:41=E5=86=99=E9=81=93=EF=BC=9A
>
> On Mon, Jul 31, 2023 at 09:01:04AM +0800, zhangshida wrote:
> > From: Shida Zhang <zhangshida@kylinos.cn>
> >
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
> > When enough files are created, the fake_dirent->reclen will be 0xffff.
> > it doesn't equal to the blocksize 65536, i.e. 0x10000.
> >
> > But it is not the same condition when blocksize equals to 4k.
> > when enough file are created, the fake_dirent->reclen will be 0x1000.
> > it equals to the blocksize 4k, i.e. 0x1000.
> >
> > The problem seems to be related to the limitation of the 16-bit field
> > when the blocksize is set to 64k. To address this, Modify the check so
> > as to handle it properly.
>
> urughghahrhrhr<shudder>
>
> Sorry that I missed that rec_len is an encoded number, not a plain le16
> integer...
>

Yep, that's really a point that is easy to forget...

> > Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
> > ---
> > v1->v2:
> >   Use a better way to check the condition, as suggested by Andreas.
> >
> >  fs/ext4/namei.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
> > index 0caf6c730ce3..fffed95f8531 100644
> > --- a/fs/ext4/namei.c
> > +++ b/fs/ext4/namei.c
> > @@ -445,8 +445,9 @@ static struct dx_countlimit *get_dx_countlimit(stru=
ct inode *inode,
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
> >       else if (le16_to_cpu(dirent->rec_len) =3D=3D 12) {
>
> ...but what about all the other le16_to_cpu(ext4_dir_entry{,_2}.rec_len)
> accesses in this file?  Don't those also need to be converted to
> ext4_rec_len_from_disk calls?
>
> Also,
> Fixes: dbe89444042ab ("ext4: Calculate and verify checksums for htree nod=
es")
>

Thanks for your suggestion, I will try to add all the other conversion
in this file for the next v3.

Cheers,
Shida





> --D
>
> >               dp =3D (struct ext4_dir_entry *)(((void *)dirent) + 12);
> > --
> > 2.27.0
> >
