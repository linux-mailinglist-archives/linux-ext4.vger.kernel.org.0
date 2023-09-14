Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9332C7A0940
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Sep 2023 17:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240810AbjINP35 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 14 Sep 2023 11:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240953AbjINP34 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 14 Sep 2023 11:29:56 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 856C31FD6
        for <linux-ext4@vger.kernel.org>; Thu, 14 Sep 2023 08:29:52 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1c4194f769fso4666645ad.3
        for <linux-ext4@vger.kernel.org>; Thu, 14 Sep 2023 08:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20230601.gappssmtp.com; s=20230601; t=1694705391; x=1695310191; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4bI7yCilccRoOSkqrtJdKK91naozFQRbYX7MzuxW2tU=;
        b=QhCY95/GT9BG5pcZWFXOxeCvEHv7BigxbIPjZrSknucr9ueal4YEzUVrJU1jHRVvs7
         7vQ1/LQ+ZZRSmkUe4S/H6wX1D78XUN6jMGzzzHMKGTIbEUpN8UX98q5a/M1bVm5G2zH7
         7+CH/zfUYlJwS+ECBTTgQ/X+ibThisxE7s4MQPnQJNIDQ/JTRFpuWxdSqitcym5ZUaLe
         sthhahtN6dgn+/pHdfyxztBmTo3nuHYHCotZd0d2PnKJqKcwCS/p1juxTK0luOw+7KgC
         6hazSIpnBSPu7MorSRyCp53sQIDrvzAaM8hq6sDMd+w36vUWxIPg8/YMaapg8YJr9W/s
         Nn7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694705391; x=1695310191;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4bI7yCilccRoOSkqrtJdKK91naozFQRbYX7MzuxW2tU=;
        b=XWpBEokE7rGbdjVGRw4lZ+svSgUpkGur0OSPBuVZ4oLVSWeHK/cYD8MEmRJxupIhJM
         HTJa3+m/TFrQzdw/BGcaVNU9dwyYrJ3LWSfOgO7OPiv66DeH/2kyaA7eh9Kl1PIxBYxa
         McGxO5S4iDsOp57xeQIWBpaopgOb5qL11CKUiroyoHT74yAn+VjeYr+21HJW0osrFahS
         NUruyzMHFqePA6X0z7iJ+x8cc6WDGHYIPSgPTECsffr8kuYXiOMfu99PdiF/qO+5pWTs
         elwKcVeqYZM/u0mPoh+hMbFXmdBnkFvRzWe6cHJquQF2XAn7kvoxtk6HpT5Imj/8U5YQ
         R0Rw==
X-Gm-Message-State: AOJu0Yz6FB4k2Yur/fg8x69zgeEqNcAsiB9gU5DGDYic1E6cSO0t/vkn
        jt3mTE+Vrxxe5EChQjoes+OIuWCwAyrP8NLIsm4=
X-Google-Smtp-Source: AGHT+IF3Kb/Xb052Fz2G5SCDwye/fWsDr9QQLLuHrTL2ERkCKHhlpIgyId94cqAneTvXDHPLa36cgQ==
X-Received: by 2002:a17:902:c40d:b0:1bc:3944:9391 with SMTP id k13-20020a170902c40d00b001bc39449391mr7167824plk.25.1694705391439;
        Thu, 14 Sep 2023 08:29:51 -0700 (PDT)
Received: from smtpclient.apple (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id d18-20020a170903231200b001bb1f0605b2sm1740860plh.214.2023.09.14.08.29.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Sep 2023 08:29:50 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andreas Dilger <adilger@dilger.ca>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] merge extent blocks when possible
Date:   Thu, 14 Sep 2023 09:29:39 -0600
Message-Id: <C3BE7137-F2FB-485D-84B8-3DB231B0C232@dilger.ca>
References: <3A359E12-81DF-4408-8058-6B08119857D9@whamcloud.com>
Cc:     Alex Zhuravlev <azhuravlev@whamcloud.com>
In-Reply-To: <3A359E12-81DF-4408-8058-6B08119857D9@whamcloud.com>
To:     linux-ext4@vger.kernel.org
X-Mailer: iPhone Mail (20G81)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Jun 19, 2023, at 07:20, Alex Zhuravlev <azhuravlev@whamcloud.com> wrote:
>=20
> =EF=BB=BFHi,
>=20
> Please have a look at the patch attempting to handle the problem with deep=
 extent tree.
> There are cases (rather corner, but still) when a lot of extents are creat=
ed initially, then
> they get merged over time, but there is no way to merge blocks. Here is a s=
imple example:
> a file is written synchronously, all even blocks first, then odd blocks. Fi=
nally you may find
> extents tree like this (data from debugs):
> EXTENTS:
> (ETB0):33796
> (ETB1):33795
> (0-677):2588672-2589349
> (ETB1):2590753
> (678):2589350
> (ETB1):2590720
> (679-1357):2589351-2590029
> (ETB1):2590752
> (1358):2590030
> (ETB1):2590721
> (1359-2037):2590031-2590709
> (ETB1):2590751
> (2038):2590710
> (ETB1):2590722
> (2039-2047):2590711-2590719
> (2048-2717):2592768-2593437
> (ETB1):2590750
> (2718):2593438
> (ETB1):2590723
> (2719-3397):2593439-2594117
> (ETB1):2590749
> (3398):2594118
> (ETB1):2590724
> (3399-4077):2594119-2594797
> (ETB1):2590748
> (4078):2594798
> (ETB1):2590725
> (4079-4757):2594799-2595477
> (ETB1):2590747
> (4758):2595478
> (ETB1):2590726
> =E2=80=A6
> Notice the most of the leave blocks have just a single extent, which doesn=
=E2=80=99t look very optimal.
> With the patch applied (0.6% slower):
> EXTENTS:
> (ETB0):33796
> (ETB1):2590736
> (0-2047):2588672-2590719
> (2048-11999):2592768-2602719
>=20
> Originally the problem was hit with a real application operating on huge d=
atasets and with just
> 27371 extents "inode has invalid extent depth: 6=E2=80=9D problem occurred=
.
> With the patch applied the application succeeded having finally 73637 in 3=
-level tree.
>=20
> Thanks, Alex

We hit some issues with this patch under some heavy usage that have been har=
d to
reproduce in testing, so please hold off any action on this patch.=20

Cheers, Andreas

> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index 35703dce23a3..acb64e1f8018 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -1885,7 +1885,7 @@ static void ext4_ext_try_to_merge_up(handle_t *handl=
e,
>  * This function tries to merge the @ex extent to neighbours in the tree, t=
hen
>  * tries to collapse the extent tree into the inode.
>  */
> -static void ext4_ext_try_to_merge(handle_t *handle,
> +static int ext4_ext_try_to_merge(handle_t *handle,
>                  struct inode *inode,
>                  struct ext4_ext_path *path,
>                  struct ext4_extent *ex)
> @@ -1902,9 +1902,178 @@ static void ext4_ext_try_to_merge(handle_t *handle=
,
>        merge_done =3D ext4_ext_try_to_merge_right(inode, path, ex - 1);
>=20
>    if (!merge_done)
> -        (void) ext4_ext_try_to_merge_right(inode, path, ex);
> +        merge_done =3D ext4_ext_try_to_merge_right(inode, path, ex);
>=20
>    ext4_ext_try_to_merge_up(handle, inode, path);
> +
> +    return merge_done;
> +}
> +
> +/*
> + * This function tries to merge blocks from @path into @npath
> + */
> +static int ext4_ext_merge_blocks(handle_t *handle,
> +                struct inode *inode,
> +                struct ext4_ext_path *path,
> +                struct ext4_ext_path *npath)
> +{
> +    unsigned int depth =3D ext_depth(inode);
> +    int used, nused, free, i, k, err;
> +    ext4_lblk_t next;
> +
> +    if (path[depth].p_hdr =3D=3D npath[depth].p_hdr)
> +        return 0;
> +
> +    used =3D le16_to_cpu(path[depth].p_hdr->eh_entries);
> +    free =3D le16_to_cpu(npath[depth].p_hdr->eh_max) -
> +        le16_to_cpu(npath[depth].p_hdr->eh_entries);
> +    if (free < used)
> +        return 0;
> +
> +    err =3D ext4_ext_get_access(handle, inode, path + depth);
> +    if (err)
> +        return err;
> +    err =3D ext4_ext_get_access(handle, inode, npath + depth);
> +    if (err)
> +        return err;
> +
> +    /* move entries from the current leave to the next one */
> +    nused =3D le16_to_cpu(npath[depth].p_hdr->eh_entries);
> +    memmove(EXT_FIRST_EXTENT(npath[depth].p_hdr) + used,
> +        EXT_FIRST_EXTENT(npath[depth].p_hdr),
> +        nused * sizeof(struct ext4_extent));
> +    memcpy(EXT_FIRST_EXTENT(npath[depth].p_hdr),
> +        EXT_FIRST_EXTENT(path[depth].p_hdr),
> +        used * sizeof(struct ext4_extent));
> +    le16_add_cpu(&npath[depth].p_hdr->eh_entries, used);
> +    le16_add_cpu(&path[depth].p_hdr->eh_entries, -used);
> +    ext4_ext_try_to_merge_right(inode, npath,
> +                    EXT_FIRST_EXTENT(npath[depth].p_hdr));
> +
> +    err =3D ext4_ext_dirty(handle, inode, path + depth);
> +    if (err)
> +        return err;
> +    err =3D ext4_ext_dirty(handle, inode, npath + depth);
> +    if (err)
> +        return err;
> +
> +    /* otherwise the index won't get corrected */
> +    npath[depth].p_ext =3D EXT_FIRST_EXTENT(npath[depth].p_hdr);
> +    err =3D ext4_ext_correct_indexes(handle, inode, npath);
> +    if (err)
> +        return err;
> +
> +    for (i =3D depth - 1; i >=3D 0; i--) {
> +
> +        next =3D ext4_idx_pblock(path[i].p_idx);
> +        ext4_free_blocks(handle, inode, NULL, next, 1,
> +                EXT4_FREE_BLOCKS_METADATA |
> +                EXT4_FREE_BLOCKS_FORGET);
> +        err =3D ext4_ext_get_access(handle, inode, path + i);
> +        if (err)
> +            return err;
> +        le16_add_cpu(&path[i].p_hdr->eh_entries, -1);
> +        if (le16_to_cpu(path[i].p_hdr->eh_entries) =3D=3D 0) {
> +            /* whole index block collapsed, go up */
> +            continue;
> +        }
> +        /* remove index pointer */
> +        used =3D EXT_LAST_INDEX(path[i].p_hdr) - path[i].p_idx + 1;
> +        memmove(path[i].p_idx, path[i].p_idx + 1,
> +            used * sizeof(struct ext4_extent_idx));
> +
> +        err =3D ext4_ext_dirty(handle, inode, path + i);
> +        if (err)
> +            return err;
> +
> +        if (path[i].p_hdr =3D=3D npath[i].p_hdr)
> +            break;
> +
> +        /* try to move index pointers */
> +        used =3D le16_to_cpu(path[i].p_hdr->eh_entries);
> +        free =3D le16_to_cpu(npath[i].p_hdr->eh_max) -
> +            le16_to_cpu(npath[i].p_hdr->eh_entries);
> +        if (used > free)
> +            break;
> +        err =3D ext4_ext_get_access(handle, inode, npath + i);
> +        if (err)
> +            return err;
> +        memmove(EXT_FIRST_INDEX(npath[i].p_hdr) + used,
> +            EXT_FIRST_INDEX(npath[i].p_hdr),
> +            npath[i].p_hdr->eh_entries * sizeof(struct ext4_extent_idx));=

> +        memcpy(EXT_FIRST_INDEX(npath[i].p_hdr), EXT_FIRST_INDEX(path[i].p=
_hdr),
> +            used * sizeof(struct ext4_extent_idx));
> +        le16_add_cpu(&path[i].p_hdr->eh_entries, -used);
> +        le16_add_cpu(&npath[i].p_hdr->eh_entries, used);
> +        err =3D ext4_ext_dirty(handle, inode, path + i);
> +        if (err)
> +            return err;
> +        err =3D ext4_ext_dirty(handle, inode, npath + i);
> +        if (err)
> +            return err;
> +
> +        /* correct index above */
> +        for (k =3D i; k > 0; k--) {
> +            err =3D ext4_ext_get_access(handle, inode, npath + k - 1);
> +            if (err)
> +                return err;
> +            npath[k-1].p_idx->ei_block =3D
> +                EXT_FIRST_INDEX(npath[k].p_hdr)->ei_block;
> +            err =3D ext4_ext_dirty(handle, inode, npath + k - 1);
> +            if (err)
> +                return err;
> +        }
> +    }
> +
> +    /*
> +     * TODO: given we've got two paths, it should be possible to
> +     * collapse those two blocks into the root one in some cases
> +     */
> +    return 1;
> +}
> +
> +static int ext4_ext_try_to_merge_blocks(handle_t *handle,
> +        struct inode *inode,
> +        struct ext4_ext_path *path)
> +{
> +    struct ext4_ext_path *npath =3D NULL;
> +    unsigned int depth =3D ext_depth(inode);
> +    ext4_lblk_t next;
> +    int used, rc =3D 0;
> +
> +    if (depth =3D=3D 0)
> +        return 0;
> +
> +    used =3D le16_to_cpu(path[depth].p_hdr->eh_entries);
> +    /* don't be too agressive as checking space in
> +     * the next block is not free */
> +    if (used > ext4_ext_space_block(inode, 0) / 4)
> +        return 0;
> +
> +    /* try to merge to the next block */
> +    next =3D ext4_ext_next_leaf_block(path);
> +    if (next =3D=3D EXT_MAX_BLOCKS)
> +        return 0;
> +    npath =3D ext4_find_extent(inode, next, NULL, 0);
> +    if (IS_ERR(npath))
> +        return 0;
> +    rc =3D ext4_ext_merge_blocks(handle, inode, path, npath);
> +    ext4_ext_drop_refs(npath);
> +    kfree(npath);
> +    if (rc)
> +        return rc > 0 ? 0 : rc;
> +
> +    /* try to merge with the previous block */
> +    if (EXT_FIRST_EXTENT(path[depth].p_hdr)->ee_block =3D=3D 0)
> +        return 0;
> +    next =3D EXT_FIRST_EXTENT(path[depth].p_hdr)->ee_block - 1;
> +    npath =3D ext4_find_extent(inode, next, NULL, 0);
> +    if (IS_ERR(npath))
> +        return 0;
> +    rc =3D ext4_ext_merge_blocks(handle, inode, npath, path);
> +    ext4_ext_drop_refs(npath);
> +    kfree(npath);
> +    return rc > 0 ? 0 : rc;
> }
>=20
> /*
> @@ -1976,6 +2145,7 @@ int ext4_ext_insert_extent(handle_t *handle, struct i=
node *inode,
>    int depth, len, err;
>    ext4_lblk_t next;
>    int mb_flags =3D 0, unwritten;
> +    int merged =3D 0;
>=20
>    if (gb_flags & EXT4_GET_BLOCKS_DELALLOC_RESERVE)
>        mb_flags |=3D EXT4_MB_DELALLOC_RESERVED;
> @@ -2167,8 +2337,7 @@ int ext4_ext_insert_extent(handle_t *handle, struct i=
node *inode,
> merge:
>    /* try to merge extents */
>    if (!(gb_flags & EXT4_GET_BLOCKS_PRE_IO))
> -        ext4_ext_try_to_merge(handle, inode, path, nearex);
> -
> +        merged =3D ext4_ext_try_to_merge(handle, inode, path, nearex);
>=20
>    /* time to correct all indexes above */
>    err =3D ext4_ext_correct_indexes(handle, inode, path);
> @@ -2176,6 +2345,8 @@ int ext4_ext_insert_extent(handle_t *handle, struct i=
node *inode,
>        goto cleanup;
>=20
>    err =3D ext4_ext_dirty(handle, inode, path + path->p_depth);
> +    if (!err && merged)
> +        err =3D ext4_ext_try_to_merge_blocks(handle, inode, path);
>=20
> cleanup:
>    ext4_free_ext_path(npath);
> @@ -3766,7 +3937,8 @@ static int ext4_convert_unwritten_extents_endio(hand=
le_t *handle,
>    /* note: ext4_ext_correct_indexes() isn't needed here because
>     * borders are not changed
>     */
> -    ext4_ext_try_to_merge(handle, inode, path, ex);
> +    if (ext4_ext_try_to_merge(handle, inode, path, ex))
> +        ext4_ext_try_to_merge_blocks(handle, inode, path);
>=20
>    /* Mark modified extent as dirty */
>    err =3D ext4_ext_dirty(handle, inode, path + path->p_depth);
> @@ -3829,7 +4001,8 @@ convert_initialized_extent(handle_t *handle, struct i=
node *inode,
>    /* note: ext4_ext_correct_indexes() isn't needed here because
>     * borders are not changed
>     */
> -    ext4_ext_try_to_merge(handle, inode, path, ex);
> +    if (ext4_ext_try_to_merge(handle, inode, path, ex))
> +        ext4_ext_try_to_merge_blocks(handle, inode, path);
>=20
>    /* Mark modified extent as dirty */
>    err =3D ext4_ext_dirty(handle, inode, path + path->p_depth);
> diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
> index 18611241f451..7421f2af9cf2 100644
> --- a/fs/jbd2/transaction.c
> +++ b/fs/jbd2/transaction.c
> @@ -513,6 +513,7 @@ handle_t *jbd2__journal_start(journal_t *journal, int n=
blocks, int rsv_blocks,
>        }
>        rsv_handle->h_reserved =3D 1;
>        rsv_handle->h_journal =3D journal;
> +        rsv_handle->h_revoke_credits =3D revoke_records;
>        handle->h_rsv_handle =3D rsv_handle;
>    }
>    handle->h_revoke_credits =3D revoke_records;
>=20
