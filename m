Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 720B362F671
	for <lists+linux-ext4@lfdr.de>; Fri, 18 Nov 2022 14:40:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235182AbiKRNky (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 18 Nov 2022 08:40:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242115AbiKRNkh (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 18 Nov 2022 08:40:37 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D986FE62
        for <linux-ext4@vger.kernel.org>; Fri, 18 Nov 2022 05:40:36 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id t62so5332891oib.12
        for <linux-ext4@vger.kernel.org>; Fri, 18 Nov 2022 05:40:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20210112.gappssmtp.com; s=20210112;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gfs4Hvhc6PDv9zgalAN6qusgZGl8rFXkaJL8tYQmqWs=;
        b=pdOozgVgwy1cYjIfYjEhscKFksZb0BqlTGt1XgIJlvnO8HRyYHra1dDJcsc4Z/cDww
         aORFEUe7XQzpC5fg5V7VTYLnC7ThEXZ+zcovzRgr1jWMl/o+ZTgjZC8hZ+mUkThffuuG
         VCWEI+k7T9vUtE89ngUjlalxmIHTRA9G0jIfbduTtjK35f3zjkvzsFWPj1BFwhTo/jhV
         JSWLC+6oHbFCfLcKM1MMxhzztmSRF7kXjF3stwglHOq2Mqk/eFSqasqYRQOs8VAwySQP
         DqXLUhU7NjDQDC7RkF5Xv4xn5MMsiZmIxFS4bJ64T6ooAnKY54S3dlOome6s+gR+06nl
         5pnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gfs4Hvhc6PDv9zgalAN6qusgZGl8rFXkaJL8tYQmqWs=;
        b=iR53wztP96VAwZ4sp6uritxgOhgUhli7z22af/uviXuvtLD58Ml+ac5vslN0KtJZu4
         RkVpT/mJbGnSGKaDBlaMwsj1I+AMerpTdtDpJGky2wa0dhE7PfAXSJ4GgzCdTqdFgD4O
         LXC7LbwNKDrgflRnqeO0V/GKDYkRCb+Kdc86j/OtmGMConQTpOxU7I3lbAFKZqUsY4Vh
         ZAWFpDp5pom9WDtYs7UyDvi0qPUKpOTGbKY9v2n13Cf7bm/6SZZpDsaAkYnpB2R+wvvd
         TXwRMON+PTHIvNdJPYKuu5laqAnw/ORwF6OoI6GJcZcmAj5xFDpnTNpBGHaHidtirNHe
         9cOA==
X-Gm-Message-State: ANoB5pktIgZwxDer2BknfA9ZelnIRcmGMiLjxnCZUtHOp+yMUrU0nztr
        RpZBenxpNq+/2VprrplIDv58Sye3XmAr1kY6
X-Google-Smtp-Source: AA0mqf7RLypoJpeLGJDww6uKJXqGbSdxpIBSaFNhnUG3PjnXqq3dPeQQ2F5datw5naAXXwQjwbVi6g==
X-Received: by 2002:aca:1704:0:b0:359:e535:84a2 with SMTP id j4-20020aca1704000000b00359e53584a2mr3526944oii.59.1668778835852;
        Fri, 18 Nov 2022 05:40:35 -0800 (PST)
Received: from smtpclient.apple ([205.169.26.81])
        by smtp.gmail.com with ESMTPSA id e35-20020a05687023a300b0013297705e5dsm1992063oap.28.2022.11.18.05.40.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Nov 2022 05:40:35 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andreas Dilger <adilger@dilger.ca>
Mime-Version: 1.0 (1.0)
Subject: Re: [RFCv1 10/72] libext2fs: merge icounts after thread finishes
Date:   Fri, 18 Nov 2022 07:40:34 -0600
Message-Id: <FF80E002-C71D-437A-86F1-EA4FFB1C486C@dilger.ca>
References: <817a806b1c7ed161cb76da5f163a9aade60c8dfd.1667822611.git.ritesh.list@gmail.com>
Cc:     Theodore Ts'o <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Wang Shilong <wshilong@ddn.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>, Li Xi <lixi@ddn.com>
In-Reply-To: <817a806b1c7ed161cb76da5f163a9aade60c8dfd.1667822611.git.ritesh.list@gmail.com>
To:     "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
X-Mailer: iPhone Mail (19H12)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

MOn Nov 7, 2022, at 06:23, Ritesh Harjani (IBM) <ritesh.list@gmail.com> wrot=
e:
>=20
> =EF=BB=BFFrom: Li Xi <lixi@ddn.com>
>=20
> Merge inode_count and inode_link_info properly after
> threads finish.
>=20
> Signed-off-by: Li Xi <lixi@ddn.com>
> Signed-off-by: Wang Shilong <wshilong@ddn.com>
> [Note: splitted the patch to seperate libext2fs changes from e2fsck]
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

> ---
> lib/ext2fs/ext2fs.h |   1 +
> lib/ext2fs/icount.c | 103 ++++++++++++++++++++++++++++++++++++++++++++
> 2 files changed, 104 insertions(+)
>=20
> diff --git a/lib/ext2fs/ext2fs.h b/lib/ext2fs/ext2fs.h
> index 54aed5d1..139a25fc 100644
> --- a/lib/ext2fs/ext2fs.h
> +++ b/lib/ext2fs/ext2fs.h
> @@ -1546,6 +1546,7 @@ extern errcode_t ext2fs_icount_decrement(ext2_icount=
_t icount, ext2_ino_t ino,
>                     __u16 *ret);
> extern errcode_t ext2fs_icount_store(ext2_icount_t icount, ext2_ino_t ino,=

>                     __u16 count);
> +extern errcode_t ext2fs_icount_merge(ext2_icount_t src, ext2_icount_t des=
t);
> extern ext2_ino_t ext2fs_get_icount_size(ext2_icount_t icount);
> errcode_t ext2fs_icount_validate(ext2_icount_t icount, FILE *);
>=20
> diff --git a/lib/ext2fs/icount.c b/lib/ext2fs/icount.c
> index 888a90b2..766eccca 100644
> --- a/lib/ext2fs/icount.c
> +++ b/lib/ext2fs/icount.c
> @@ -13,6 +13,7 @@
> #if HAVE_UNISTD_H
> #include <unistd.h>
> #endif
> +#include <assert.h>
> #include <string.h>
> #include <stdio.h>
> #include <sys/stat.h>
> @@ -701,6 +702,108 @@ errcode_t ext2fs_icount_store(ext2_icount_t icount, e=
xt2_ino_t ino,
>    return 0;
> }
>=20
> +errcode_t ext2fs_icount_merge_full_map(ext2_icount_t src, ext2_icount_t d=
est)
> +{
> +    /* TODO: add the support for full map */
> +    return EOPNOTSUPP;
> +}
> +
> +errcode_t ext2fs_icount_merge_el(ext2_icount_t src, ext2_icount_t dest)
> +{
> +    int             src_count =3D src->count;
> +    int             dest_count =3D dest->count;
> +    int             size =3D src_count + dest_count;
> +    int             size_entry =3D sizeof(struct ext2_icount_el);
> +    struct ext2_icount_el    *array;
> +    struct ext2_icount_el    *array_ptr;
> +    struct ext2_icount_el    *src_array =3D src->list;
> +    struct ext2_icount_el    *dest_array =3D dest->list;
> +    int             src_index =3D 0;
> +    int             dest_index =3D 0;
> +    errcode_t         retval;
> +
> +    if (src_count =3D=3D 0)
> +        return 0;
> +
> +    retval =3D ext2fs_get_array(size, size_entry, &array);
> +    if (retval)
> +        return retval;
> +
> +    array_ptr =3D array;
> +    /*
> +     * This can be improved by binary search and memcpy, but codes
> +     * would be more complex. And if number of bad blocks is small,
> +     * the optimization won't improve performance a lot.
> +     */
> +    while (src_index < src_count || dest_index < dest_count) {
> +        if (src_index >=3D src_count) {
> +            memcpy(array_ptr, &dest_array[dest_index],
> +                   (dest_count - dest_index) * size_entry);
> +            break;
> +        }
> +        if (dest_index >=3D dest_count) {
> +            memcpy(array_ptr, &src_array[src_index],
> +                   (src_count - src_index) * size_entry);
> +            break;
> +        }
> +        if (src_array[src_index].ino < dest_array[dest_index].ino) {
> +            *array_ptr =3D src_array[src_index];
> +            src_index++;
> +        } else {
> +            assert(src_array[src_index].ino >
> +                   dest_array[dest_index].ino);
> +            *array_ptr =3D dest_array[dest_index];
> +            dest_index++;
> +        }
> +        array_ptr++;
> +    }
> +
> +    ext2fs_free_mem(&dest->list);
> +    dest->list =3D array;
> +    dest->count =3D src_count + dest_count;
> +    dest->size =3D size;
> +    dest->last_lookup =3D NULL;
> +    return 0;
> +}
> +
> +errcode_t ext2fs_icount_merge(ext2_icount_t src, ext2_icount_t dest)
> +{
> +    errcode_t    retval;
> +
> +    if (src->fullmap && !dest->fullmap)
> +        return EINVAL;
> +
> +    if (!src->fullmap && dest->fullmap)
> +        return EINVAL;
> +
> +    if (src->multiple && !dest->multiple)
> +        return EINVAL;
> +
> +    if (!src->multiple && dest->multiple)
> +        return EINVAL;
> +
> +    if (src->fullmap)
> +        return ext2fs_icount_merge_full_map(src, dest);
> +
> +    retval =3D ext2fs_merge_bitmap(src->single, dest->single, NULL,
> +                     NULL);
> +    if (retval)
> +        return retval;
> +
> +    if (src->multiple) {
> +        retval =3D ext2fs_merge_bitmap(src->multiple, dest->multiple,
> +                         NULL, NULL);
> +        if (retval)
> +            return retval;
> +    }
> +
> +    retval =3D ext2fs_icount_merge_el(src, dest);
> +    if (retval)
> +        return retval;
> +
> +    return 0;
> +}
> +
> ext2_ino_t ext2fs_get_icount_size(ext2_icount_t icount)
> {
>    if (!icount || icount->magic !=3D EXT2_ET_MAGIC_ICOUNT)
> --=20
> 2.37.3
>=20
