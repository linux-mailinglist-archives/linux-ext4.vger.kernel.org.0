Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1038562FE40
	for <lists+linux-ext4@lfdr.de>; Fri, 18 Nov 2022 20:47:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235467AbiKRTrn (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 18 Nov 2022 14:47:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235421AbiKRTrk (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 18 Nov 2022 14:47:40 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EACBDEBC
        for <linux-ext4@vger.kernel.org>; Fri, 18 Nov 2022 11:47:38 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id k2-20020a17090a4c8200b002187cce2f92so4019292pjh.2
        for <linux-ext4@vger.kernel.org>; Fri, 18 Nov 2022 11:47:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20210112.gappssmtp.com; s=20210112;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fY8VI+ylBVIv/WSuY512mFoyN+sNLahDRKtAPSNc6R8=;
        b=qsQ/SO+CtABHcH5uzf2RTak+5Gd5n/vD5mKKMOwBvUBelQteOw0/1Koa2XHSf3Ynlx
         grs2WhKE3HlIk4DeV01JBx3TSln9LNj0vraNAhOv3NW9R93AwOG64dSEQtKeub2gextv
         MzihwmYKecEMzv8VLhDzTN7gfvQXy1ics35fCdUsxYZFTd/5CnE8NvP/nVywTzlaxBSv
         pdqw/kD6LXekzF0CzMcibb+miM5/ormjXSv7X+3TkfvITdnHL3EEulmRsITw0RZGKPwV
         sjX0gSi3PyMa3iEh9Z6dojO9PQRrrpOeWkK1RtZhfacxmgLyk8PhPJ5rcynr6HqtKmT2
         5A6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fY8VI+ylBVIv/WSuY512mFoyN+sNLahDRKtAPSNc6R8=;
        b=2GXB3/l2DB4o8NQN5vLHRsx9UbWtFC25tm2Fbfc5rX+4yICPl9MM5WlVO9bkMI175J
         K9A1G9O+yasLoWAhNuq6/BRc+RmIGr5T+D1j+40bAT018ql1rvOvzLg5rTomvks8HmeB
         akNYHAB21Apjs9nwEcPoaIz0xA5wY7ZOxMLVKPyDUNtlHGlXaG6Hjpmfei25Ccwzqr23
         hBBmPji5/8we1wFMKtc/GloNykgIvyGSXF0CjIIcCWcdwr3z2mmX2pBdZbYMde9ROYVH
         UmPEeJ37ZkAUWpVZCx2++UorskZvevdUOClihDgS5jxcd4kvYfQVD0AH1wRiydEGgxMV
         f+Bg==
X-Gm-Message-State: ANoB5pkmR2P6GJOS+kMrP3nflSbnv2RrsYKnenrjf/XnkFe6MOd9zdOG
        NXlb5RXZdfDXE6f/rdn52Fw59A==
X-Google-Smtp-Source: AA0mqf5vvvmFplHxlyVoDSCMathCtL/1zdBsVFy1X01ZAl63uejketnP3AFVZ9s5j3Hw8toQzg0Zmg==
X-Received: by 2002:a17:902:eb86:b0:188:c395:1748 with SMTP id q6-20020a170902eb8600b00188c3951748mr866091plg.155.1668800857826;
        Fri, 18 Nov 2022 11:47:37 -0800 (PST)
Received: from smtpclient.apple ([2605:8d80:4a1:2f85:b9d8:fa96:38c3:8e0f])
        by smtp.gmail.com with ESMTPSA id 23-20020a17090a0a9700b002182cd64b1csm5810366pjw.1.2022.11.18.11.47.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Nov 2022 11:47:37 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andreas Dilger <adilger@dilger.ca>
Mime-Version: 1.0 (1.0)
Subject: Re: [RFCv1 12/72] libext2fs: dupfs: Add fs clone & merge api
Date:   Fri, 18 Nov 2022 12:46:13 -0700
Message-Id: <78178FB1-8B01-4956-BDBE-751251E2D58A@dilger.ca>
References: <e6d1ef1be6dd5a82b223e77d2d6713c1c84aa977.1667822611.git.ritesh.list@gmail.com>
Cc:     Theodore Ts'o <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Wang Shilong <wshilong@ddn.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Li Xi <lixi@ddn.com>,
        Saranya Muruganandam <saranyamohan@google.com>
In-Reply-To: <e6d1ef1be6dd5a82b223e77d2d6713c1c84aa977.1667822611.git.ritesh.list@gmail.com>
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

On Nov 7, 2022, at 05:23, Ritesh Harjani (IBM) <ritesh.list@gmail.com> wrote=
:
>=20
> =EF=BB=BFFrom: Saranya Muruganandam <saranyamohan@google.com>
>=20
> This patch mainly adds "parent" & "clone_flags" member in ext2_filsys stru=
ct
> for enabling multi-threading. Based on what CLONE flags will be passed fro=
m
> the client of libext2fs down to ext2fs_clone_fs(), those structures/bitmap=
s will
> be cloned (thread-aware child copy) and rest will be shared with the paren=
t fs.
>=20
> The same flags will also help to merge those cloned bitmap structures back=
 into
> the parent bitmaps when ext2fs_merge_fs() will be called with childfs stru=
ct.
>=20
> Signed-off-by: Saranya Muruganandam <saranyamohan@google.com>
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> ---
> lib/ext2fs/dupfs.c  | 183 ++++++++++++++++++++++++++++++++++++++++++++
> lib/ext2fs/ext2fs.h |  23 ++++++
> 2 files changed, 206 insertions(+)
>=20
> diff --git a/lib/ext2fs/dupfs.c b/lib/ext2fs/dupfs.c
> index 02721e1a..ecc57cf7 100644
> --- a/lib/ext2fs/dupfs.c
> +++ b/lib/ext2fs/dupfs.c
> @@ -14,8 +14,12 @@
> #if HAVE_UNISTD_H
> #include <unistd.h>
> #endif
> +#if HAVE_PTHREAD_H
> +#include <pthread.h>
> +#endif
> #include <time.h>
> #include <string.h>
> +#include <assert.h>
>=20
> #include "ext2_fs.h"
> #include "ext2fsP.h"
> @@ -120,3 +124,182 @@ errout:
>=20
> }
>=20
> +#ifdef HAVE_PTHREAD
> +errcode_t ext2fs_clone_fs(ext2_filsys fs, ext2_filsys *dest, unsigned int=
 flags)
> +{
> +    errcode_t retval;
> +    ext2_filsys childfs;
> +
> +    EXT2_CHECK_MAGIC(fs, EXT2_ET_MAGIC_EXT2FS_FILSYS);
> +
> +    retval =3D ext2fs_get_mem(sizeof(struct struct_ext2_filsys), &childfs=
);
> +    if (retval)
> +        return retval;
> +
> +    /* make an exact copy implying lists and memory structures are shared=
 */
> +    memcpy(childfs, fs, sizeof(struct struct_ext2_filsys));
> +    childfs->inode_map =3D NULL;
> +    childfs->block_map =3D NULL;
> +    childfs->badblocks =3D NULL;
> +    childfs->dblist =3D NULL;
> +
> +    pthread_mutex_lock(&fs->refcount_mutex);
> +    fs->refcount++;
> +    pthread_mutex_unlock(&fs->refcount_mutex);

The locking her doesn't make sense. Why is the mutex only protecting the "re=
fcount",
and not the rest of the fields in fs?

It would make more sense to hold the mutex over the whole copy process, from=
 up before
the memcpy(), until down after the last structure is cloned. Otherwise, once=
 fs has
been cloned once and given to another thread it would be possible for them t=
o
change these structures.=20

> +    if ((flags & EXT2FS_CLONE_INODE) && fs->inode_map) {
> +        retval =3D ext2fs_copy_bitmap(fs->inode_map, &childfs->inode_map)=
;
> +        if (retval)
> +            return retval;
> +        childfs->inode_map->fs =3D childfs;
> +    }
> +
> +    if ((flags & EXT2FS_CLONE_BLOCK) && fs->block_map) {
> +        retval =3D ext2fs_copy_bitmap(fs->block_map, &childfs->block_map)=
;
> +        if (retval)
> +            return retval;
> +        childfs->block_map->fs =3D childfs;
> +    }
> +
> +    if ((flags & EXT2FS_CLONE_BADBLOCKS) && fs->badblocks) {
> +        retval =3D ext2fs_badblocks_copy(fs->badblocks, &childfs->badbloc=
ks);
> +        if (retval)
> +            return retval;
> +    }
> +
> +    if ((flags & EXT2FS_CLONE_DBLIST) && fs->dblist) {
> +        retval =3D ext2fs_copy_dblist(fs->dblist, &childfs->dblist);
> +        if (retval)
> +            return retval;
> +        childfs->dblist->fs =3D childfs;
> +    }
> +
> +    /* icache when NULL will be rebuilt if needed */
> +    childfs->icache =3D NULL;

This should be up where the other NULL values are set.=20

> +
> +    childfs->clone_flags =3D flags;
> +    childfs->parent =3D fs;
> +    *dest =3D childfs;
> +
> +    return 0;
> +}
> +
> +errcode_t ext2fs_merge_fs(ext2_filsys *thread_fs)
> +{
> +    ext2_filsys fs =3D *thread_fs;
> +    errcode_t retval =3D 0;
> +    ext2_filsys dest =3D fs->parent;
> +    ext2_filsys src =3D fs;
> +    unsigned int flags =3D fs->clone_flags;
> +    struct ext2_inode_cache *icache;
> +    io_channel dest_io;
> +    io_channel dest_image_io;
> +    ext2fs_inode_bitmap inode_map;
> +    ext2fs_block_bitmap block_map;
> +    ext2_badblocks_list badblocks;
> +    ext2_dblist dblist;
> +    void *priv_data;
> +    int fsflags;
> +
> +    pthread_mutex_lock(&fs->refcount_mutex);
> +    fs->refcount--;
> +    assert(fs->refcount >=3D 0);
> +    pthread_mutex_unlock(&fs->refcount_mutex);

Same here. The mutex should be held over the whole copy process.=20

Cheers, Andreas


> +    icache =3D dest->icache;
> +    dest_io =3D dest->io;
> +    dest_image_io =3D dest->image_io;
> +    inode_map =3D dest->inode_map;
> +    block_map =3D dest->block_map;
> +    badblocks =3D dest->badblocks;
> +    dblist =3D dest->dblist;
> +    priv_data =3D dest->priv_data;
> +    fsflags =3D dest->flags;
> +
> +    memcpy(dest, src, sizeof(struct struct_ext2_filsys));
> +
> +    dest->io =3D dest_io;
> +    dest->image_io =3D dest_image_io;
> +    dest->icache =3D icache;
> +    dest->inode_map =3D inode_map;
> +    dest->block_map =3D block_map;
> +    dest->badblocks =3D badblocks;
> +    dest->dblist =3D dblist;
> +    dest->priv_data =3D priv_data;
> +    if (dest->dblist)
> +        dest->dblist->fs =3D dest;
> +    dest->flags =3D src->flags | fsflags;
> +    if (!(src->flags & EXT2_FLAG_VALID) || !(dest->flags & EXT2_FLAG_VALI=
D))
> +        ext2fs_unmark_valid(dest);
> +
> +    if ((flags & EXT2FS_CLONE_INODE) && src->inode_map) {
> +        if (dest->inode_map =3D=3D NULL) {
> +            dest->inode_map =3D src->inode_map;
> +            src->inode_map =3D NULL;
> +        } else {
> +            retval =3D ext2fs_merge_bitmap(src->inode_map, dest->inode_ma=
p, NULL, NULL);
> +            if (retval)
> +                goto out;
> +        }
> +        dest->inode_map->fs =3D dest;
> +    }
> +
> +    if ((flags & EXT2FS_CLONE_BLOCK) && src->block_map) {
> +        if (dest->block_map =3D=3D NULL) {
> +            dest->block_map =3D src->block_map;
> +            src->block_map =3D NULL;
> +        } else {
> +            retval =3D ext2fs_merge_bitmap(src->block_map, dest->block_ma=
p, NULL, NULL);
> +            if (retval)
> +                goto out;
> +        }
> +        dest->block_map->fs =3D dest;
> +    }
> +
> +    if ((flags & EXT2FS_CLONE_BADBLOCKS) && src->badblocks) {
> +        if (dest->badblocks =3D=3D NULL)
> +            retval =3D ext2fs_badblocks_copy(src->badblocks, &dest->badbl=
ocks);
> +        else
> +            retval =3D ext2fs_badblocks_merge(src->badblocks, dest->badbl=
ocks);
> +        if (retval)
> +            goto out;
> +    }
> +
> +    if ((flags & EXT2FS_CLONE_DBLIST) && src->dblist) {
> +        if (dest->dblist =3D=3D NULL) {
> +            dest->dblist =3D src->dblist;
> +            src->dblist =3D NULL;
> +        } else {
> +            retval =3D ext2fs_merge_dblist(src->dblist, dest->dblist);
> +            if (retval)
> +                goto out;
> +        }
> +        dest->dblist->fs =3D dest;
> +    }
> +
> +    if (src->icache) {
> +        ext2fs_free_inode_cache(src->icache);
> +        src->icache =3D NULL;
> +    }
> +
> +out:
> +    if (src->io)
> +        io_channel_close(src->io);
> +
> +    if ((flags & EXT2FS_CLONE_INODE) && src->inode_map)
> +        ext2fs_free_generic_bmap(src->inode_map);
> +    if ((flags & EXT2FS_CLONE_BLOCK) && src->block_map)
> +        ext2fs_free_generic_bmap(src->block_map);
> +    if ((flags & EXT2FS_CLONE_BADBLOCKS) && src->badblocks)
> +        ext2fs_badblocks_list_free(src->badblocks);
> +    if ((flags & EXT2FS_CLONE_DBLIST) && src->dblist) {
> +        ext2fs_free_dblist(src->dblist);
> +        src->dblist =3D NULL;
> +    }
> +
> +    ext2fs_free_mem(&src);
> +    *thread_fs =3D NULL;
> +
> +    return retval;
> +}
> +#endif
> diff --git a/lib/ext2fs/ext2fs.h b/lib/ext2fs/ext2fs.h
> index 139a25fc..b1505f95 100644
> --- a/lib/ext2fs/ext2fs.h
> +++ b/lib/ext2fs/ext2fs.h
> @@ -12,6 +12,10 @@
> #ifndef _EXT2FS_EXT2FS_H
> #define _EXT2FS_EXT2FS_H
>=20
> +#ifdef HAVE_PTHREAD_H
> +#include <pthread.h>
> +#endif
> +
> #ifdef __GNUC__
> #define EXT2FS_ATTR(x) __attribute__(x)
> #else
> @@ -331,6 +335,13 @@ struct struct_ext2_filsys {
>    struct ext2fs_hashmap* block_sha_map;
>=20
>    const struct ext2fs_nls_table *encoding;
> +
> +#ifdef HAVE_PTHREAD
> +    struct struct_ext2_filsys *parent;
> +    size_t refcount;
> +    pthread_mutex_t refcount_mutex;
> +    unsigned int clone_flags;
> +#endif
> };
>=20
> #if EXT2_FLAT_INCLUDES
> @@ -1057,6 +1068,18 @@ extern errcode_t ext2fs_move_blocks(ext2_filsys fs,=

> /* check_desc.c */
> extern errcode_t ext2fs_check_desc(ext2_filsys fs);
>=20
> +#ifdef HAVE_PTHREAD
> +/* flags for ext2fs_clone_fs */
> +#define EXT2FS_CLONE_BLOCK            0x0001
> +#define EXT2FS_CLONE_INODE            0x0002
> +#define EXT2FS_CLONE_BADBLOCKS        0x0004
> +#define EXT2FS_CLONE_DBLIST            0x0008
> +
> +extern errcode_t ext2fs_clone_fs(ext2_filsys fs, ext2_filsys *dest,
> +                                 unsigned int flags);
> +extern errcode_t ext2fs_merge_fs(ext2_filsys *fs);
> +#endif
> +
> /* closefs.c */
> extern errcode_t ext2fs_close(ext2_filsys fs);
> extern errcode_t ext2fs_close2(ext2_filsys fs, int flags);
> --=20
> 2.37.3
>=20
