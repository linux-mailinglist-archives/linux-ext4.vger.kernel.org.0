Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14AE862F661
	for <lists+linux-ext4@lfdr.de>; Fri, 18 Nov 2022 14:38:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242125AbiKRNiD (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 18 Nov 2022 08:38:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242159AbiKRNhc (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 18 Nov 2022 08:37:32 -0500
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 995EA5FDC
        for <linux-ext4@vger.kernel.org>; Fri, 18 Nov 2022 05:36:12 -0800 (PST)
Received: by mail-oo1-xc36.google.com with SMTP id t15-20020a4a96cf000000b0049f7e18db0dso772378ooi.10
        for <linux-ext4@vger.kernel.org>; Fri, 18 Nov 2022 05:36:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20210112.gappssmtp.com; s=20210112;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dVvnEYgUa7+JKrQCXhZ8FZQGTZceyqYi1JV/5ZAZSO4=;
        b=frBWFiAHZ+TIr/iECABxWYaJvfVKYCo4ldeuJeJL+MMGhLgZvAuHDGX3fTIsnTHTm3
         9lWCrMsYmytLPLd+sg/QAFETiWvOFE1kNfPJYOryWqyVC5ZgZqqwu/27W+7E1J5kboij
         vkYm2uUlmaAyRFW31cDHrnCGSBLRf5L2ErOb9LGpU8eB/k+ybANUTskFQlShKDG2NZAY
         McSqv/LnjE912s9IROVExQHqN902geM8TSVMFbY6HvLVnjsM4R2ZCAFkMlKU8+6P87QK
         btClBvBT0SMPUBHfDAk3y4KoH2y4PPBy3fwNCejtXNIyiIjhppf0FQEN+qXN/8D+BkDg
         Mlmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dVvnEYgUa7+JKrQCXhZ8FZQGTZceyqYi1JV/5ZAZSO4=;
        b=h7QuuZXzSUjdEfHh44EDchlxC59MnswfDc2fEYgzOvf2mMS6k7Q+1HM8GVRlgxBfY6
         CdFy4msZ8LnPitwu02m5hNnx6M0G6MBmzeVig3zblPgUy81xDmWI5hSmpjIOdnuEOQn+
         kdjYvjAUZ8LqlhPsRc+1FoaYioIG5kkR8EmH27xKUjS+y1poZlcOocs83o0xecej0Fxv
         j9r9tuufGQKUg0YFYeBxRxU5LYvZiOe2LkK/UYN1JReI61ip1365Jxre+zy1PPudc1uB
         7IMIkewPXopkKa+vBgGsN+INd1VTxz8xVSd2J47z6R/jNwcFjfOJb33iqbwJXWbtcaCW
         n1KQ==
X-Gm-Message-State: ANoB5pmIyk/ifI6nJTqBcAq2JYFX6NguK4yCAkY5V83+0Wa/G32LQrvX
        g3gX4ynGCMfEb1pjZHivBglhdkJ8bZQVKejd
X-Google-Smtp-Source: AA0mqf7vDta0zJEOG+RfNn6uugF+bcL5aZDgR/zj7/VLB/ThiEcrbEFZF2CQ3HZd4T4fG8Uoaymm2A==
X-Received: by 2002:a4a:c487:0:b0:49b:e47d:5abf with SMTP id f7-20020a4ac487000000b0049be47d5abfmr3454794ooq.47.1668778571493;
        Fri, 18 Nov 2022 05:36:11 -0800 (PST)
Received: from smtpclient.apple ([205.169.26.81])
        by smtp.gmail.com with ESMTPSA id bl17-20020a056808309100b00359f96eeb47sm1398439oib.49.2022.11.18.05.36.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Nov 2022 05:36:10 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andreas Dilger <adilger@dilger.ca>
Mime-Version: 1.0 (1.0)
Subject: Re: [RFCv1 08/72] libext2fs: Add bitmaps merge ops
Date:   Fri, 18 Nov 2022 07:36:10 -0600
Message-Id: <6352B3B2-0B76-4D7A-A377-CEE7AB15E27B@dilger.ca>
References: <e7d44e0d438f26fee254ba005885f8f7eeb56ddb.1667822611.git.ritesh.list@gmail.com>
Cc:     Theodore Ts'o <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Wang Shilong <wshilong@ddn.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>, Li Xi <lixi@ddn.com>
In-Reply-To: <e7d44e0d438f26fee254ba005885f8f7eeb56ddb.1667822611.git.ritesh.list@gmail.com>
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

On Nov 7, 2022, at 06:23, Ritesh Harjani (IBM) <ritesh.list@gmail.com> wrote=
:
>=20
> =EF=BB=BFFrom: Wang Shilong <wshilong@ddn.com>
>=20
> Signed-off-by: Li Xi <lixi@ddn.com>
> Signed-off-by: Wang Shilong <wshilong@ddn.com>
> [Note: splitted rb merge tree logic patch such that we
> seperate out libext2fs changes from e2fsck specific changes]
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

> ---
> lib/ext2fs/bitmaps.c      | 10 ++++++++++
> lib/ext2fs/bmap64.h       |  4 ++++
> lib/ext2fs/ext2fs.h       |  8 ++++++++
> lib/ext2fs/gen_bitmap64.c | 29 +++++++++++++++++++++++++++++
> 4 files changed, 51 insertions(+)
>=20
> diff --git a/lib/ext2fs/bitmaps.c b/lib/ext2fs/bitmaps.c
> index 8bfa24b1..9437331e 100644
> --- a/lib/ext2fs/bitmaps.c
> +++ b/lib/ext2fs/bitmaps.c
> @@ -45,6 +45,16 @@ errcode_t ext2fs_copy_bitmap(ext2fs_generic_bitmap src,=

> {
>    return (ext2fs_copy_generic_bmap(src, dest));
> }
> +
> +errcode_t ext2fs_merge_bitmap(ext2fs_generic_bitmap src,
> +                  ext2fs_generic_bitmap dest,
> +                  ext2fs_generic_bitmap dup,
> +                  ext2fs_generic_bitmap dup_allowed)
> +{
> +    return ext2fs_merge_generic_bmap(src, dest, dup,
> +                     dup_allowed);
> +}
> +
> void ext2fs_set_bitmap_padding(ext2fs_generic_bitmap map)
> {
>    ext2fs_set_generic_bmap_padding(map);
> diff --git a/lib/ext2fs/bmap64.h b/lib/ext2fs/bmap64.h
> index de334548..555193ee 100644
> --- a/lib/ext2fs/bmap64.h
> +++ b/lib/ext2fs/bmap64.h
> @@ -72,6 +72,10 @@ struct ext2_bitmap_ops {
>    void    (*free_bmap)(ext2fs_generic_bitmap_64 bitmap);
>    errcode_t (*copy_bmap)(ext2fs_generic_bitmap_64 src,
>                 ext2fs_generic_bitmap_64 dest);
> +    errcode_t (*merge_bmap)(ext2fs_generic_bitmap_64 src,
> +                ext2fs_generic_bitmap_64 dest,
> +                ext2fs_generic_bitmap_64 dup,
> +                ext2fs_generic_bitmap_64 dup_allowed);
>    errcode_t (*resize_bmap)(ext2fs_generic_bitmap_64 bitmap,
>                   __u64 new_end,
>                   __u64 new_real_end);
> diff --git a/lib/ext2fs/ext2fs.h b/lib/ext2fs/ext2fs.h
> index 443f93d2..54aed5d1 100644
> --- a/lib/ext2fs/ext2fs.h
> +++ b/lib/ext2fs/ext2fs.h
> @@ -870,6 +870,10 @@ extern void ext2fs_free_block_bitmap(ext2fs_block_bit=
map bitmap);
> extern void ext2fs_free_inode_bitmap(ext2fs_inode_bitmap bitmap);
> extern errcode_t ext2fs_copy_bitmap(ext2fs_generic_bitmap src,
>                    ext2fs_generic_bitmap *dest);
> +extern errcode_t ext2fs_merge_bitmap(ext2fs_generic_bitmap src,
> +                  ext2fs_generic_bitmap dest,
> +                  ext2fs_generic_bitmap dup,
> +                  ext2fs_generic_bitmap dup_allowed);
> extern errcode_t ext2fs_allocate_block_bitmap(ext2_filsys fs,
>                          const char *descr,
>                          ext2fs_block_bitmap *ret);
> @@ -1467,6 +1471,10 @@ void ext2fs_set_generic_bmap_padding(ext2fs_generic=
_bitmap bmap);
> errcode_t ext2fs_resize_generic_bmap(ext2fs_generic_bitmap bmap,
>                     __u64 new_end,
>                     __u64 new_real_end);
> +errcode_t ext2fs_merge_generic_bmap(ext2fs_generic_bitmap gen_src,
> +                                    ext2fs_generic_bitmap gen_dest,
> +                    ext2fs_generic_bitmap gen_dup,
> +                    ext2fs_generic_bitmap dup_allowed);
> errcode_t ext2fs_compare_generic_bmap(errcode_t neq,
>                      ext2fs_generic_bitmap bm1,
>                      ext2fs_generic_bitmap bm2);
> diff --git a/lib/ext2fs/gen_bitmap64.c b/lib/ext2fs/gen_bitmap64.c
> index f7710afd..c31f942f 100644
> --- a/lib/ext2fs/gen_bitmap64.c
> +++ b/lib/ext2fs/gen_bitmap64.c
> @@ -346,6 +346,35 @@ errcode_t ext2fs_copy_generic_bmap(ext2fs_generic_bit=
map gen_src,
>    return 0;
> }
>=20
> +errcode_t ext2fs_merge_generic_bmap(ext2fs_generic_bitmap gen_src,
> +                    ext2fs_generic_bitmap gen_dest,
> +                    ext2fs_generic_bitmap gen_dup,
> +                    ext2fs_generic_bitmap gen_dup_allowed)
> +{
> +    ext2fs_generic_bitmap_64 src =3D (ext2fs_generic_bitmap_64)gen_src;
> +    ext2fs_generic_bitmap_64 dest =3D (ext2fs_generic_bitmap_64)gen_dest;=

> +    ext2fs_generic_bitmap_64 dup =3D (ext2fs_generic_bitmap_64)gen_dup;
> +    ext2fs_generic_bitmap_64 dup_allowed =3D (ext2fs_generic_bitmap_64)ge=
n_dup_allowed;
> +
> +    if (!src || !dest)
> +        return EINVAL;
> +
> +    if (!EXT2FS_IS_64_BITMAP(src) || !EXT2FS_IS_64_BITMAP(dest) ||
> +        (dup && !EXT2FS_IS_64_BITMAP(dup)) ||
> +        (dup_allowed && !EXT2FS_IS_64_BITMAP(dup_allowed)))
> +        return EINVAL;
> +
> +    if (src->bitmap_ops !=3D dest->bitmap_ops ||
> +        (dup && src->bitmap_ops !=3D dup->bitmap_ops) ||
> +        (dup_allowed && src->bitmap_ops !=3D dup_allowed->bitmap_ops))
> +        return EINVAL;
> +
> +    if (src->bitmap_ops->merge_bmap =3D=3D NULL)
> +        return EOPNOTSUPP;
> +
> +    return src->bitmap_ops->merge_bmap(src, dest, dup, dup_allowed);
> +}
> +
> errcode_t ext2fs_resize_generic_bmap(ext2fs_generic_bitmap gen_bmap,
>                     __u64 new_end,
>                     __u64 new_real_end)
> --=20
> 2.37.3
>=20
