Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85F7662F66D
	for <lists+linux-ext4@lfdr.de>; Fri, 18 Nov 2022 14:39:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242138AbiKRNjs (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 18 Nov 2022 08:39:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242215AbiKRNjc (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 18 Nov 2022 08:39:32 -0500
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AE1991512
        for <linux-ext4@vger.kernel.org>; Fri, 18 Nov 2022 05:39:04 -0800 (PST)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-14263779059so5136915fac.1
        for <linux-ext4@vger.kernel.org>; Fri, 18 Nov 2022 05:39:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20210112.gappssmtp.com; s=20210112;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oHchT0yAtg3v/dKyzyInAkWaTTLQ7mN5aFS9ZHrILa0=;
        b=rsg4GX8EMxg37ATbIwE260I4odhWiAqr7O8BPl5flYXwefKJIPlIbxPjksiyOknQAv
         wya9dBPOCTTCT/ZGdGRrqzd+IkXMCndDLYeRpHZpzU3DTyhl/jXJzqj+RXVs1EfldXfU
         XZhp5S5+NjeEbSVCm9VuJNgx9D3uTiM+rsbBteuNZugRahfVvwHeuvkbZGi7Zn1WXamD
         VJEE3qoKqD54ErbjW5P4ItnHnhhmhAE/FId4a3obz4btxvHD80QM1bF7+AEB699kgcjZ
         p4A9oaATI2Mh1xWeUy2Rsd5ZoAfRXw4TYmjUdQe4XQuj5DZnzFqfEiLOhMajYOcHmvfj
         7c5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oHchT0yAtg3v/dKyzyInAkWaTTLQ7mN5aFS9ZHrILa0=;
        b=kfE3CmYMrHCV+MKUVgXh2waq+jt5CLGNPGOB0OjoLejwowukOKWXb3APcuBBXxc8yQ
         s0rMW/Sa3fBBe8M8pfwU16zhYJEYl9NCpd0Bwem6uEvGODX2qFhQFlC9TUQIQ+rlWGaF
         pVxrbkx41+z4YMgccsGVfUzI7n49RXTcZrHjkyiun10IXMnIFm3drNnQuGlamT4/WSdk
         QW5Zcac8tZBFU69kp00RuIhFaPYVlmMFPDWa+DgqPOpSj0EvfmUCgDdW6wamLqsm/8x4
         g1TEzAatiG8+bbJ745/VACJkSjUK9rsA1l2zkuHFW8TsJ6ly9Dhj19RhJV4U6PRjccXR
         9W5A==
X-Gm-Message-State: ANoB5pkmntfHDALZ3Gw4S0h2w7MsRcM/bjX8HHyrvHhfAiBoDNGlBn1h
        G7nxl0UaU66Y+cpeQgd7U9abtUFEPi1Ifwst
X-Google-Smtp-Source: AA0mqf4lmWQED8ZScYlr+JMiux8GyyYuNDAayk5HA7gg+Hzfg1CMqrEAO5gd2fR3taOP6BYwT92e6g==
X-Received: by 2002:a05:6871:4687:b0:13b:1794:2395 with SMTP id ni7-20020a056871468700b0013b17942395mr3895780oab.114.1668778743622;
        Fri, 18 Nov 2022 05:39:03 -0800 (PST)
Received: from smtpclient.apple ([205.169.26.81])
        by smtp.gmail.com with ESMTPSA id s2-20020acadb02000000b00353fe4fb4casm1390397oig.48.2022.11.18.05.39.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Nov 2022 05:39:03 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andreas Dilger <adilger@dilger.ca>
Mime-Version: 1.0 (1.0)
Subject: Re: [RFCv1 09/72] libext2fs: Add flush cleanup API
Date:   Fri, 18 Nov 2022 07:39:02 -0600
Message-Id: <13F6544C-945C-4326-B7F8-11D2B2C4A9FE@dilger.ca>
References: <81451e5fcf02b502164e0e9f049df940b07de715.1667822611.git.ritesh.list@gmail.com>
Cc:     Theodore Ts'o <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Wang Shilong <wshilong@ddn.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>, Li Xi <lixi@ddn.com>
In-Reply-To: <81451e5fcf02b502164e0e9f049df940b07de715.1667822611.git.ritesh.list@gmail.com>
To:     "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
X-Mailer: iPhone Mail (19H12)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,MIME_QP_LONG_LINE,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Nov 7, 2022, at 06:23, Ritesh Harjani (IBM) <ritesh.list@gmail.com> wrote=
:
>=20
> =EF=BB=BFFrom: Li Xi <lixi@ddn.com>
>=20
> Signed-off-by: Li Xi <lixi@ddn.com>
> Signed-off-by: Wang Shilong <wshilong@ddn.com>
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

> ---
> lib/ext2fs/ext2_io.h |  2 ++
> lib/ext2fs/undo_io.c | 19 +++++++++++++++++++
> lib/ext2fs/unix_io.c | 24 +++++++++++++++++++++---
> 3 files changed, 42 insertions(+), 3 deletions(-)
>=20
> diff --git a/lib/ext2fs/ext2_io.h b/lib/ext2fs/ext2_io.h
> index 8fe5b323..8cc355be 100644
> --- a/lib/ext2fs/ext2_io.h
> +++ b/lib/ext2fs/ext2_io.h
> @@ -82,6 +82,7 @@ struct struct_io_manager {
>    errcode_t (*write_blk)(io_channel channel, unsigned long block,
>                   int count, const void *data);
>    errcode_t (*flush)(io_channel channel);
> +    errcode_t (*flush_cleanup)(io_channel channel);
>    errcode_t (*write_byte)(io_channel channel, unsigned long offset,
>                int count, const void *data);
>    errcode_t (*set_option)(io_channel channel, const char *option,
> @@ -116,6 +117,7 @@ struct struct_io_manager {
> #define io_channel_read_blk(c,b,n,d)    ((c)->manager->read_blk((c),b,n,d)=
)
> #define io_channel_write_blk(c,b,n,d)    ((c)->manager->write_blk((c),b,n,=
d))
> #define io_channel_flush(c)        ((c)->manager->flush((c)))
> +#define io_channel_flush_cleanup(c)    ((c)->manager->flush_cleanup((c)))=

> #define io_channel_bumpcount(c)        ((c)->refcount++)
>=20
> /* io_manager.c */
> diff --git a/lib/ext2fs/undo_io.c b/lib/ext2fs/undo_io.c
> index f4a6d526..678ff421 100644
> --- a/lib/ext2fs/undo_io.c
> +++ b/lib/ext2fs/undo_io.c
> @@ -1024,6 +1024,24 @@ static errcode_t undo_flush(io_channel channel)
>    return retval;
> }
>=20
> +/*
> + * Flush data buffers to disk and cleanup the cache.
> + */
> +static errcode_t undo_flush_cleanup(io_channel channel)
> +{
> +    errcode_t    retval =3D 0;
> +    struct undo_private_data *data;
> +
> +    EXT2_CHECK_MAGIC(channel, EXT2_ET_MAGIC_IO_CHANNEL);
> +    data =3D (struct undo_private_data *) channel->private_data;
> +    EXT2_CHECK_MAGIC(data, EXT2_ET_MAGIC_UNIX_IO_CHANNEL);
> +
> +    if (data->real)
> +        retval =3D io_channel_flush_cleanup(data->real);
> +
> +    return retval;
> +}
> +
> static errcode_t undo_set_option(io_channel channel, const char *option,
>                 const char *arg)
> {
> @@ -1095,6 +1113,7 @@ static struct struct_io_manager struct_undo_manager =3D=
 {
>    .read_blk    =3D undo_read_blk,
>    .write_blk    =3D undo_write_blk,
>    .flush        =3D undo_flush,
> +    .flush_cleanup    =3D undo_flush_cleanup,
>    .write_byte    =3D undo_write_byte,
>    .set_option    =3D undo_set_option,
>    .get_stats    =3D undo_get_stats,
> diff --git a/lib/ext2fs/unix_io.c b/lib/ext2fs/unix_io.c
> index 5b894826..8f8118a3 100644
> --- a/lib/ext2fs/unix_io.c
> +++ b/lib/ext2fs/unix_io.c
> @@ -1173,9 +1173,9 @@ static errcode_t unix_write_byte(io_channel channel,=
 unsigned long offset,
> }
>=20
> /*
> - * Flush data buffers to disk.
> + * Flush data buffers to disk and invalidate cache if needed
>  */
> -static errcode_t unix_flush(io_channel channel)
> +static errcode_t _unix_flush(io_channel channel, int invalidate)
> {
>    struct unix_private_data *data;
>    errcode_t retval =3D 0;
> @@ -1185,7 +1185,7 @@ static errcode_t unix_flush(io_channel channel)
>    EXT2_CHECK_MAGIC(data, EXT2_ET_MAGIC_UNIX_IO_CHANNEL);
>=20
> #ifndef NO_IO_CACHE
> -    retval =3D flush_cached_blocks(channel, data, 0);
> +    retval =3D flush_cached_blocks(channel, data, invalidate);
> #endif
> #ifdef HAVE_FSYNC
>    if (!retval && fsync(data->dev) !=3D 0)
> @@ -1194,6 +1194,22 @@ static errcode_t unix_flush(io_channel channel)
>    return retval;
> }
>=20
> +/*
> + * Flush data buffers to disk.
> + */
> +static errcode_t unix_flush(io_channel channel)
> +{
> +    return _unix_flush(channel, 0);
> +}
> +
> +/*
> + * Flush data buffers to disk and invalidate cache.
> + */
> +static errcode_t unix_flush_cleanup(io_channel channel)
> +{
> +    return _unix_flush(channel, 1);
> +}
> +
> static errcode_t unix_set_option(io_channel channel, const char *option,
>                 const char *arg)
> {
> @@ -1383,6 +1399,7 @@ static struct struct_io_manager struct_unix_manager =3D=
 {
>    .discard    =3D unix_discard,
>    .cache_readahead    =3D unix_cache_readahead,
>    .zeroout    =3D unix_zeroout,
> +    .flush_cleanup    =3D unix_flush_cleanup,
> };
>=20
> io_manager unix_io_manager =3D &struct_unix_manager;
> @@ -1404,6 +1421,7 @@ static struct struct_io_manager struct_unixfd_manage=
r =3D {
>    .discard    =3D unix_discard,
>    .cache_readahead    =3D unix_cache_readahead,
>    .zeroout    =3D unix_zeroout,
> +    .flush_cleanup    =3D unix_flush_cleanup,
> };
>=20
> io_manager unixfd_io_manager =3D &struct_unixfd_manager;
> --=20
> 2.37.3
>=20
