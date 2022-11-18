Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75F7662F2C0
	for <lists+linux-ext4@lfdr.de>; Fri, 18 Nov 2022 11:40:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240866AbiKRKkG (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 18 Nov 2022 05:40:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbiKRKkF (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 18 Nov 2022 05:40:05 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3A541B9DF
        for <linux-ext4@vger.kernel.org>; Fri, 18 Nov 2022 02:40:03 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id j6so3050296qvn.12
        for <linux-ext4@vger.kernel.org>; Fri, 18 Nov 2022 02:40:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20210112.gappssmtp.com; s=20210112;
        h=to:references:message-id:date:cc:in-reply-to:from:subject
         :mime-version:content-transfer-encoding:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O556mVNRX4Ifzk9s3lUm/9vXrG/c0w3aNWiePQEwobA=;
        b=5qYwQzJ1j91596HcGt3FvjI0TlLrxFlr8aeIYfBbiAqA1EeuTS5u783XKlgSUZxgpM
         hbWFUWIJjuRM9/vh9chYTLslX46CzRY5Bu/dtX1PQ3SLLOtPV5PFGbpRPRv2ZrkmX6LU
         YRxTrL1Mqeryg/sS2gtlw1vXlMF+U3AS7oqaGng189t89DcGFthjpiMpqp4mlP1FWLXU
         /GHhp0Abm795FAlvbxmMzSfVHaGZbf6/etclQ2KOI4m10SsdtbXIJAdMUE+Ocf1lbdJv
         WR32ZMJKc36WBiM/spxRSLvqfIByrQy7tMlxFJUPY2UfcuYs7/ngvtV9kNos0rcIhsed
         LXjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:date:cc:in-reply-to:from:subject
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=O556mVNRX4Ifzk9s3lUm/9vXrG/c0w3aNWiePQEwobA=;
        b=jK7FZAY1WOa4vBiw2e8JYeHpBVlZvsIiXkW4GQJlw0KEzZfkopUl3Ltoqf9nwBn0Cw
         DU7ah4ZWDqX4Z0/DnWKWbulYSXuuwVxclACbQRqYcC/csits1rVoyI7tZy44I92QwtgE
         BlYRWzdWAAO7G4EQY8vyC+wsEHElA0X/ZsiGrtH/ciDt3UAy5oh0qnPr1zZnqP8zqZED
         LvgnomO63E2Nb78/RiU22KX9pPB0ztaJPKwjx90sMdw3v5PoBSz5d8M4n3WkPR4Y5ip8
         e2EycgWqnchNtkdD2PbV+A2zpblNwaY2UL0C8ZcbdWuMFA8EupcCOxlTj/hGCjc3yD+F
         craQ==
X-Gm-Message-State: ANoB5pkcUbuwgXsu4t8iS9aV3QVhoYESGksBERgopXsTOZmGI6sG409q
        t1k3KGAj0e/TKhIf2YqP4i3hAL8svwURwjVB
X-Google-Smtp-Source: AA0mqf5qXCwmUe/HLvXEhEaswTEMShj4ak3MFg3yOPHbpKsh2pXtqqJjysMoIn0D53OvSJ+qYMfESg==
X-Received: by 2002:a05:6214:5d89:b0:4b6:c6ce:f40b with SMTP id mf9-20020a0562145d8900b004b6c6cef40bmr6034245qvb.78.1668768002601;
        Fri, 18 Nov 2022 02:40:02 -0800 (PST)
Received: from smtpclient.apple ([12.184.218.19])
        by smtp.gmail.com with ESMTPSA id bm3-20020a05620a198300b006f474e6a715sm2156270qkb.131.2022.11.18.02.40.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Nov 2022 02:40:02 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (1.0)
Subject: Re: [RFCv1 03/72] blkmap64_ba: Add common helper for bits size calculation
From:   Andreas Dilger <adilger@dilger.ca>
In-Reply-To: <728edcaf0eb7fca7e347183799b5dca743236db0.1667822611.git.ritesh.list@gmail.com>
Cc:     Theodore Ts'o <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Wang Shilong <wshilong@ddn.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>, Li Xi <lixi@ddn.com>
Date:   Fri, 18 Nov 2022 04:40:01 -0600
Message-Id: <83758DE7-4D3D-4AD1-8EC5-5521672072CC@dilger.ca>
References: <728edcaf0eb7fca7e347183799b5dca743236db0.1667822611.git.ritesh.list@gmail.com>
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

On Nov 7, 2022, at 06:22, Ritesh Harjani (IBM) <ritesh.list@gmail.com> wrote=
:
>=20
> =EF=BB=BFJust a quick common helper for bits size calculation.
>=20
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

> ---
> lib/ext2fs/blkmap64_ba.c | 20 +++++++++++++-------
> 1 file changed, 13 insertions(+), 7 deletions(-)
>=20
> diff --git a/lib/ext2fs/blkmap64_ba.c b/lib/ext2fs/blkmap64_ba.c
> index 5d8f1548..4e7007f0 100644
> --- a/lib/ext2fs/blkmap64_ba.c
> +++ b/lib/ext2fs/blkmap64_ba.c
> @@ -40,6 +40,13 @@ struct ext2fs_ba_private_struct {
>=20
> typedef struct ext2fs_ba_private_struct *ext2fs_ba_private;
>=20
> +#define ba_bits_size(start, end) ((((end) - (start)) / 8 + 1))
> +
> +static size_t ba_bitmap_size(ext2fs_generic_bitmap_64 bitmap)
> +{
> +    return (size_t) ba_bits_size(bitmap->start, bitmap->real_end);
> +}
> +
> static errcode_t ba_alloc_private_data (ext2fs_generic_bitmap_64 bitmap)
> {
>   ext2fs_ba_private bp;
> @@ -56,7 +63,7 @@ static errcode_t ba_alloc_private_data (ext2fs_generic_b=
itmap_64 bitmap)
>   if (retval)
>       return retval;
>=20
> -    size =3D (size_t) (((bitmap->real_end - bitmap->start) / 8) + 1);
> +    size =3D ba_bitmap_size(bitmap);
>=20
>   retval =3D ext2fs_get_mem(size, &bp->bitarray);
>   if (retval) {
> @@ -80,7 +87,7 @@ static errcode_t ba_new_bmap(ext2_filsys fs EXT2FS_ATTR(=
(unused)),
>       return retval;
>=20
>   bp =3D (ext2fs_ba_private) bitmap->private;
> -    size =3D (size_t) (((bitmap->real_end - bitmap->start) / 8) + 1);
> +    size =3D ba_bitmap_size(bitmap);
>   memset(bp->bitarray, 0, size);
>=20
>   return 0;
> @@ -115,7 +122,7 @@ static errcode_t ba_copy_bmap(ext2fs_generic_bitmap_64=
 src,
>=20
>   dest_bp =3D (ext2fs_ba_private) dest->private;
>=20
> -    size =3D (size_t) (((src->real_end - src->start) / 8) + 1);
> +    size =3D ba_bitmap_size(src);
>   memcpy (dest_bp->bitarray, src_bp->bitarray, size);
>=20
>   return 0;
> @@ -145,8 +152,8 @@ static errcode_t ba_resize_bmap(ext2fs_generic_bitmap_=
64 bmap,
>       return 0;
>   }
>=20
> -    size =3D ((bmap->real_end - bmap->start) / 8) + 1;
> -    new_size =3D ((new_real_end - bmap->start) / 8) + 1;
> +    size =3D ba_bitmap_size(bmap);
> +    new_size =3D ba_bits_size(new_real_end, bmap->start);
>=20
>   if (size !=3D new_size) {
>       retval =3D ext2fs_resize_mem(size, new_size, &bp->bitarray);
> @@ -306,8 +313,7 @@ static void ba_clear_bmap(ext2fs_generic_bitmap_64 bit=
map)
> {
>   ext2fs_ba_private bp =3D (ext2fs_ba_private) bitmap->private;
>=20
> -    memset(bp->bitarray, 0,
> -           (size_t) (((bitmap->real_end - bitmap->start) / 8) + 1));
> +    memset(bp->bitarray, 0, ba_bitmap_size(bitmap));
> }
>=20
> #ifdef ENABLE_BMAP_STATS
> --=20
> 2.37.3
