Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52784352662
	for <lists+linux-ext4@lfdr.de>; Fri,  2 Apr 2021 07:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbhDBFQj (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 2 Apr 2021 01:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbhDBFQj (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 2 Apr 2021 01:16:39 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98843C0613E6
        for <linux-ext4@vger.kernel.org>; Thu,  1 Apr 2021 22:16:38 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id ay2so2061412plb.3
        for <linux-ext4@vger.kernel.org>; Thu, 01 Apr 2021 22:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=Zqq6h4N3vOHLSUEEkis52ryeBpZkCqcmSP1wyixJ+po=;
        b=0YeF61iiZdgMU9gOdGLeZmWKC0MqU2t5oT+TB7hPM5MLVt0DWD9f9PIX0pQa3SxkBK
         hPikozEB0DnBrAC1kRCSXE1b0N0+t+eSn9vU2vdNW3S3LDGpWHEurCMizFN38e0qe+oi
         J64heJlnH0nVdUZKorkPkQidCb+mFiIN+qHVdK6u7XDbx9BL+gMRDhyn18w7ebsG0yJl
         ateL+E1uRMGAtFfDbh5hcinVHvKqXzDBKeAIV8ynW2WiYaygKuwAaFPzPkwXCOTYhwIO
         9pOv/LPHrqH7CXsRcyRZxhfz86nh063v89s4cGi/erh6FylhZEQww31xIrfKsLjZV7zo
         WAMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=Zqq6h4N3vOHLSUEEkis52ryeBpZkCqcmSP1wyixJ+po=;
        b=Iito9/CedJa2rntawBdIU3TBr8000liUvPRZ1qCfdN/uJV090e91kHYJF8i3sZ5Nz/
         +qlPo7eZ8ax88P5ET9nFX/0SXsJRHLFbpQxbQ0PVCotnxPim3U3h3v7EZX6dhImEzau4
         Lj3ihdvOPbhpvgu/vVHMJ4l18hzdUwSBySerceDZd2RVf5s/eG7CQZ31VB32JB4UP5QT
         N9C+XueQf4cYnnQU2uPzAKqyWowERo47+5nPELkousZ2w+GjlN+AMneFAsubIE2NNu4l
         rsXOBBQgU5CFMtARt8VEfu4DSE7Zo4gVeRqWGOYBVRG4rR0oYJHEnJcsGCHFpBn8Vq0l
         myYA==
X-Gm-Message-State: AOAM530LhdWaeuWxnkJiUsua1YdFX1W07NlBpsOysCslFpZZ15Ial6aG
        LTNNpD2Heee5p9c0jYB1K9JHXQ==
X-Google-Smtp-Source: ABdhPJzSSJYmzepIN8Badq2clDYFpyFtzsVDuTYQSy1jKJSI8ZyioBpGLweJjqHU6UTwmMVmL9eHpw==
X-Received: by 2002:a17:90a:b007:: with SMTP id x7mr11715351pjq.27.1617340597945;
        Thu, 01 Apr 2021 22:16:37 -0700 (PDT)
Received: from [192.168.10.175] (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id 138sm6899695pfv.192.2021.04.01.22.16.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Apr 2021 22:16:37 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andreas Dilger <adilger@dilger.ca>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v6 7/7] ext4: make prefetch_block_bitmaps default
Date:   Thu, 1 Apr 2021 23:16:35 -0600
Message-Id: <5815C46F-D210-4545-9610-136F68E93B66@dilger.ca>
References: <20210401172129.189766-8-harshadshirwadkar@gmail.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu
In-Reply-To: <20210401172129.189766-8-harshadshirwadkar@gmail.com>
To:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
X-Mailer: iPhone Mail (18D52)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Apr 1, 2021, at 11:45, Harshad Shirwadkar <harshadshirwadkar@gmail.com> w=
rote:
>=20
> =EF=BB=BFBlock bitmap prefetching is needed for these allocator optimizati=
on
> data structures to get populated and provide better group scanning
> order. So, turn it on bu default. prefetch_block_bitmaps mount option
> is now marked as removed and a new option no_prefetch_block_bitmaps is
> added to disable block bitmap prefetching.

This makes it more difficult to change between an old kernel and a new one
using this option. It would be better to keep prefetch_block_bitmaps to turn=

the option on (not harmful if it is already on), and no_* turn it off.=20

Cheers, Andreas

> Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
> ---
> fs/ext4/ext4.h  |  2 +-
> fs/ext4/super.c | 15 ++++++++-------
> 2 files changed, 9 insertions(+), 8 deletions(-)
>=20
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 9a5afe9d2310..20c757f711e7 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -1227,7 +1227,7 @@ struct ext4_inode_info {
> #define EXT4_MOUNT_JOURNAL_CHECKSUM    0x800000 /* Journal checksums */
> #define EXT4_MOUNT_JOURNAL_ASYNC_COMMIT    0x1000000 /* Journal Async Comm=
it */
> #define EXT4_MOUNT_WARN_ON_ERROR    0x2000000 /* Trigger WARN_ON on error *=
/
> -#define EXT4_MOUNT_PREFETCH_BLOCK_BITMAPS 0x4000000
> +#define EXT4_MOUNT_NO_PREFETCH_BLOCK_BITMAPS 0x4000000
> #define EXT4_MOUNT_DELALLOC        0x8000000 /* Delalloc support */
> #define EXT4_MOUNT_DATA_ERR_ABORT    0x10000000 /* Abort on file data writ=
e */
> #define EXT4_MOUNT_BLOCK_VALIDITY    0x20000000 /* Block validity checking=
 */
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 6116640081c0..cec0fb07916b 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -1687,7 +1687,7 @@ enum {
>    Opt_dioread_nolock, Opt_dioread_lock,
>    Opt_discard, Opt_nodiscard, Opt_init_itable, Opt_noinit_itable,
>    Opt_max_dir_size_kb, Opt_nojournal_checksum, Opt_nombcache,
> -    Opt_prefetch_block_bitmaps, Opt_mb_optimize_scan,
> +    Opt_no_prefetch_block_bitmaps, Opt_mb_optimize_scan,
> #ifdef CONFIG_EXT4_DEBUG
>    Opt_fc_debug_max_replay, Opt_fc_debug_force
> #endif
> @@ -1787,7 +1787,8 @@ static const match_table_t tokens =3D {
>    {Opt_inlinecrypt, "inlinecrypt"},
>    {Opt_nombcache, "nombcache"},
>    {Opt_nombcache, "no_mbcache"},    /* for backward compatibility */
> -    {Opt_prefetch_block_bitmaps, "prefetch_block_bitmaps"},
> +    {Opt_removed, "prefetch_block_bitmaps"},
> +    {Opt_no_prefetch_block_bitmaps, "no_prefetch_block_bitmaps"},
>    {Opt_mb_optimize_scan, "mb_optimize_scan=3D%d"},
>    {Opt_removed, "check=3Dnone"},    /* mount option from ext2/3 */
>    {Opt_removed, "nocheck"},    /* mount option from ext2/3 */
> @@ -2009,7 +2010,7 @@ static const struct mount_opts {
>    {Opt_max_dir_size_kb, 0, MOPT_GTE0},
>    {Opt_test_dummy_encryption, 0, MOPT_STRING},
>    {Opt_nombcache, EXT4_MOUNT_NO_MBCACHE, MOPT_SET},
> -    {Opt_prefetch_block_bitmaps, EXT4_MOUNT_PREFETCH_BLOCK_BITMAPS,
> +    {Opt_no_prefetch_block_bitmaps, EXT4_MOUNT_NO_PREFETCH_BLOCK_BITMAPS,=

>     MOPT_SET},
>    {Opt_mb_optimize_scan, EXT4_MOUNT2_MB_OPTIMIZE_SCAN, MOPT_GTE0},
> #ifdef CONFIG_EXT4_DEBUG
> @@ -3706,11 +3707,11 @@ static struct ext4_li_request *ext4_li_request_new=
(struct super_block *sb,
>=20
>    elr->lr_super =3D sb;
>    elr->lr_first_not_zeroed =3D start;
> -    if (test_opt(sb, PREFETCH_BLOCK_BITMAPS))
> -        elr->lr_mode =3D EXT4_LI_MODE_PREFETCH_BBITMAP;
> -    else {
> +    if (test_opt(sb, NO_PREFETCH_BLOCK_BITMAPS)) {
>        elr->lr_mode =3D EXT4_LI_MODE_ITABLE;
>        elr->lr_next_group =3D start;
> +    } else {
> +        elr->lr_mode =3D EXT4_LI_MODE_PREFETCH_BBITMAP;
>    }
>=20
>    /*
> @@ -3741,7 +3742,7 @@ int ext4_register_li_request(struct super_block *sb,=

>        goto out;
>    }
>=20
> -    if (!test_opt(sb, PREFETCH_BLOCK_BITMAPS) &&
> +    if (test_opt(sb, NO_PREFETCH_BLOCK_BITMAPS) &&
>        (first_not_zeroed =3D=3D ngroups || sb_rdonly(sb) ||
>         !test_opt(sb, INIT_INODE_TABLE)))
>        goto out;
> --=20
> 2.31.0.291.g576ba9dcdaf-goog
>=20
