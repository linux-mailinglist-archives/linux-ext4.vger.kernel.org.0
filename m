Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B282E62F665
	for <lists+linux-ext4@lfdr.de>; Fri, 18 Nov 2022 14:38:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242224AbiKRNiw (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 18 Nov 2022 08:38:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241913AbiKRNia (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 18 Nov 2022 08:38:30 -0500
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C11291C1A
        for <linux-ext4@vger.kernel.org>; Fri, 18 Nov 2022 05:37:15 -0800 (PST)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-13bd2aea61bso6000096fac.0
        for <linux-ext4@vger.kernel.org>; Fri, 18 Nov 2022 05:37:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20210112.gappssmtp.com; s=20210112;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GBWb7Q2jF9gggScD/vZOvEkx46gLiqyFIEP0hDuxtSw=;
        b=Ez5nBYN3nxW8Sunr30RV5LuypVN7cxQ/x1sM4PiEb8wfwnyTkUzdTUtEXAzkFqvOV8
         NzDkhi1zgcxPlB3nlNfycKJNt5eT5vID9hxn5smcUbNk1MsNisWErXOpw8bDNT1t5r8a
         8rBi7FZf4ZJcaq01sGM1GtygZzVMENomCFId1j1Mra+bTx398Tak3ld/1EEcRR2XBI5J
         75rLAty+Lv4jG4NbOGWJ/DIYz6f3O9RKoFg7DC83+IzTCvq5JF7VZ8x46Ga3k9uCTKXZ
         RmgVC5TxZQktX7moJhlX6Vb7IFFLpXjC0nTCLU7fDZD4g0dTYZ38VDSOjdpWp6/Y2wvc
         Xv0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GBWb7Q2jF9gggScD/vZOvEkx46gLiqyFIEP0hDuxtSw=;
        b=4VlQRCgVIIJn4ClUPJd1zUqmzqMZbzjo6BpeNu9LoF7ii3XmnHvLyZtG15KhimOXJQ
         FMbbIbABCodwNdqIu5zjXHGOvhZ7mmXK9epIW8kEuBIBgOhLmDLwFj8hJj5vipFEjVu4
         X6e490w7M4KWIKwoDQSu405m2tRcF4mEWG+FISnwYSTw0t8o9hODr6lX2NOGJXuTiWtf
         GNSSW7/SR3BvnYTsyYMQcPSjsDZQ6qTPT2vDQ2ITjyurYodGpO5zov2MzVItxyW50wc/
         mes1oPbdbp9SxcXLURKEFXPBnFWc9+1pFxDgE7ymzRk0OnK90rJWEaE6wAnPTqQjSKVN
         k83Q==
X-Gm-Message-State: ANoB5pmRtQn9+YXAOy0EvpD+c1mULpiF/gw6CtS7oUbShIuzl5Rv69MA
        +2Do/0kTD2SPcaFHtL440+EOHXJgWukvWT50
X-Google-Smtp-Source: AA0mqf6GrmvUoA89a7mCL9OwnsQ+W/EQXKJfqAk0l2X3h65ycZhyc3tkbZVAFV6yTO93NrXMviRjOg==
X-Received: by 2002:a05:6870:3b06:b0:13b:5d72:d2c6 with SMTP id gh6-20020a0568703b0600b0013b5d72d2c6mr3927424oab.287.1668778634521;
        Fri, 18 Nov 2022 05:37:14 -0800 (PST)
Received: from smtpclient.apple ([205.169.26.81])
        by smtp.gmail.com with ESMTPSA id fo16-20020a0568709a1000b0011f00b027bdsm1958978oab.45.2022.11.18.05.37.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Nov 2022 05:37:13 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andreas Dilger <adilger@dilger.ca>
Mime-Version: 1.0 (1.0)
Subject: Re: [RFCv1 20/72] libext2fs: avoid too much memory allocation in case fs_num_threads
Date:   Fri, 18 Nov 2022 07:37:13 -0600
Message-Id: <A7D7B449-6BBF-4FAC-81A1-4738BD0271DD@dilger.ca>
References: <5ae4498b906ea4adffcca5546e2c9deba39dd05a.1667822611.git.ritesh.list@gmail.com>
Cc:     Theodore Ts'o <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Wang Shilong <wshilong@ddn.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>, Li Xi <lixi@ddn.com>
In-Reply-To: <5ae4498b906ea4adffcca5546e2c9deba39dd05a.1667822611.git.ritesh.list@gmail.com>
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

On Nov 7, 2022, at 06:24, Ritesh Harjani (IBM) <ritesh.list@gmail.com> wrote=
:
>=20
> =EF=BB=BFFrom: Wang Shilong <wshilong@ddn.com>
>=20
> e2fsck init memory according to filesystem inodes/dir numbers
> recorded in the superblock, this should be aware of filesystem
> number of threads, otherwise, oom can happen.
>=20
> So in case of fs->fs_num_threads, this patch controls the amount of
> memory consumed for running multiple threads in e2fsck.
>=20
> Signed-off-by: Wang Shilong <wshilong@ddn.com>
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

> ---
> lib/ext2fs/dblist.c | 2 ++
> lib/ext2fs/icount.c | 4 ++++
> 2 files changed, 6 insertions(+)
>=20
> diff --git a/lib/ext2fs/dblist.c b/lib/ext2fs/dblist.c
> index 5568b8ec..c19e17bc 100644
> --- a/lib/ext2fs/dblist.c
> +++ b/lib/ext2fs/dblist.c
> @@ -58,6 +58,8 @@ static errcode_t make_dblist(ext2_filsys fs, ext2_ino_t s=
ize,
>        if (retval)
>            goto cleanup;
>        dblist->size =3D (num_dirs * 2) + 12;
> +        if (fs->fs_num_threads)
> +            dblist->size /=3D fs->fs_num_threads;
>    }
>    len =3D (size_t) sizeof(struct ext2_db_entry2) * dblist->size;
>    dblist->count =3D count;
> diff --git a/lib/ext2fs/icount.c b/lib/ext2fs/icount.c
> index 766eccca..48665c7e 100644
> --- a/lib/ext2fs/icount.c
> +++ b/lib/ext2fs/icount.c
> @@ -237,6 +237,8 @@ errcode_t ext2fs_create_icount_tdb(ext2_filsys fs EXT2=
FS_NO_TDB_UNUSED,
>     * value.
>     */
>    num_inodes =3D fs->super->s_inodes_count - fs->super->s_free_inodes_cou=
nt;
> +    if (fs->fs_num_threads)
> +        num_inodes /=3D fs->fs_num_threads;
>=20
>    icount->tdb =3D tdb_open(fn, num_inodes, TDB_NOLOCK | TDB_NOSYNC,
>                   O_RDWR | O_CREAT | O_TRUNC, 0600);
> @@ -288,6 +290,8 @@ errcode_t ext2fs_create_icount2(ext2_filsys fs, int fl=
ags, unsigned int size,
>        if (retval)
>            goto errout;
>        icount->size +=3D fs->super->s_inodes_count / 50;
> +        if (fs->fs_num_threads)
> +            icount->size /=3D fs->fs_num_threads;
>    }
>=20
>    bytes =3D (size_t) (icount->size * sizeof(struct ext2_icount_el));
> --=20
> 2.37.3
>=20
