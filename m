Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E285C58A2A5
	for <lists+linux-ext4@lfdr.de>; Thu,  4 Aug 2022 23:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234319AbiHDVFo (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 4 Aug 2022 17:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230337AbiHDVFo (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 4 Aug 2022 17:05:44 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F2556580E
        for <linux-ext4@vger.kernel.org>; Thu,  4 Aug 2022 14:05:42 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id r186so963826pgr.2
        for <linux-ext4@vger.kernel.org>; Thu, 04 Aug 2022 14:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20210112.gappssmtp.com; s=20210112;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc;
        bh=7rdW2dCqqAUOFx++1v0aWMOXxuTXtIBHw8RZkeoh2ck=;
        b=5EmoicLIVhnfon3Kj0/xxcnPttx9ewi8NJIQG6u7SWP7gcI3qxVJehjHhSxXoVGvP5
         1jnQZVSvx2yY/KLvMWb3PsLlxgrjLh85Qym81oEkX4ZvlVYb0WjQASM3FqjVYrTLfudc
         mOgObmFKjU6xe4oUB0FALqaz2U5XnJXIvLSwS1tptHxUV1ySgOkAE/AYnSwG+iGS5L0v
         1QeYsVeQ0temgpPOYvMxnVJRxS8BSzoI8MHRBjKvjyezW9LFXfT0fXNl3IPVO14vuUC9
         Vmj2BxfVgjH0tEA3nPlHwCI/sxWga/Nb4aAsCe7MUerTcP/RyA+tJcSs2vpSFrsCipB/
         MdOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc;
        bh=7rdW2dCqqAUOFx++1v0aWMOXxuTXtIBHw8RZkeoh2ck=;
        b=ymmWVE0fgI9l4lDcMOpUbiOG9w+rVWdw65N1btqv5YC1N1bH5sUVbR/d6VVA6RtcJJ
         7G24DWzYqYuS6XwMahDE7o94ZI0dXU035ar0BHDsWVc3Y6Lxip9nQYpS8283cVQ2X4cz
         qAhyvSnuoosbD951GlXDtLMvLRFZoainYNGBiTNzbkLLdiQIx45tmOZ68EnmRtzlekyz
         oY2ypIdy7H32dfN7eJEMhe2n3pSgFm3KpP/nn5h5uqRjZ7JAQmCSfbaJKaIju8swcC8k
         zqklFmYFnum6FikC47B/+TC/a0eSd7HFb4DeCcjI530wxZtPp7kBBikROUBmHLGftgAN
         Qr9A==
X-Gm-Message-State: ACgBeo1+vOC6nwVPFtm9G/NOmRov+6y1EQitBIeDRji/s6HabSIQJjnl
        s4HXb2q2xRyvXLId88sVpa3dShNYoE8c9Q==
X-Google-Smtp-Source: AA6agR693ger2TwA89E8rdL+6agdOTqNh2LtkZ9u1JSVHVN8Ni13A79abIOEMqCJUKYPHFMTAcLDZQ==
X-Received: by 2002:a63:9142:0:b0:41b:f217:8b83 with SMTP id l63-20020a639142000000b0041bf2178b83mr3102271pge.478.1659647141797;
        Thu, 04 Aug 2022 14:05:41 -0700 (PDT)
Received: from smtpclient.apple ([2605:8d80:4a0:b08e:2ded:f5df:ec9:df9a])
        by smtp.gmail.com with ESMTPSA id i6-20020a654d06000000b0040df0c9a1aasm320116pgt.14.2022.08.04.14.05.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Aug 2022 14:05:41 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andreas Dilger <adilger@dilger.ca>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] misc: quiet unused variable warnings
Date:   Thu, 4 Aug 2022 15:05:40 -0600
Message-Id: <EEE5AEFC-CF45-47AE-86B3-D45DAB050AE3@dilger.ca>
References: <20220804171511.68460-1-adilger@whamcloud.com>
Cc:     tytso@mit.edu, linux-ext4@vger.kernel.org
In-Reply-To: <20220804171511.68460-1-adilger@whamcloud.com>
To:     Andreas Dilger <adilger@whamcloud.com>
X-Mailer: iPhone Mail (19G71)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Sorry about the duplicate patch, I got an error sending from my one laptop a=
nd thought it didn't go out.=20

Cheers, Andreas

On Aug 4, 2022, at 11:16, Andreas Dilger <adilger@whamcloud.com> wrote:
>=20
> =EF=BB=BFQuiet unreferenced variable warning if jbd_debug() is a no-op.
> Quiet unset variable warning because compiler is dumb.
>=20
> Signed-off-by: Andreas Dilger <adilger@whamcloud.com>
> ---
> e2fsck/journal.c    | 15 +++++++--------
> lib/ext2fs/swapfs.c |  2 +-
> 2 files changed, 8 insertions(+), 9 deletions(-)
>=20
> diff --git a/e2fsck/journal.c b/e2fsck/journal.c
> index 12487e3d..571de83e 100644
> --- a/e2fsck/journal.c
> +++ b/e2fsck/journal.c
> @@ -620,7 +620,6 @@ static inline int tl_to_darg(struct dentry_info_args *=
darg,
>                 struct  ext4_fc_tl *tl, __u8 *val)
> {
>    struct ext4_fc_dentry_info fcd;
> -    int tag =3D le16_to_cpu(tl->fc_tag);
>=20
>    memcpy(&fcd, val, sizeof(fcd));
>=20
> @@ -636,10 +635,10 @@ static inline int tl_to_darg(struct dentry_info_args=
 *darg,
>           darg->dname_len);
>    darg->dname[darg->dname_len] =3D 0;
>    jbd_debug(1, "%s: %s, ino %lu, parent %lu\n",
> -        tag =3D=3D EXT4_FC_TAG_CREAT ? "create" :
> -        (tag =3D=3D EXT4_FC_TAG_LINK ? "link" :
> -        (tag =3D=3D EXT4_FC_TAG_UNLINK ? "unlink" : "error")),
> -        darg->dname, darg->ino, darg->parent_ino);
> +          le16_to_cpu(tl->fc_tag) =3D=3D EXT4_FC_TAG_CREAT ? "create" :
> +          (le16_to_cpu(tl->fc_tag) =3D=3D EXT4_FC_TAG_LINK ? "link" :
> +           (le16_to_cpu(tl->fc_tag) =3D=3D EXT4_FC_TAG_UNLINK ? "unlink" :=

> +            "error")), darg->dname, darg->ino, darg->parent_ino);
>    return 0;
> }
>=20
> @@ -652,11 +651,11 @@ static int ext4_fc_handle_unlink(e2fsck_t ctx, struc=
t ext4_fc_tl *tl, __u8 *val)
>    if (ret)
>        return ret;
>    ext4_fc_flush_extents(ctx, darg.ino);
> -    ret =3D errcode_to_errno(
> -               ext2fs_unlink(ctx->fs, darg.parent_ino,
> -                     darg.dname, darg.ino, 0));
> +    ret =3D errcode_to_errno(ext2fs_unlink(ctx->fs, darg.parent_ino,
> +                         darg.dname, darg.ino, 0));
>    /* It's okay if the above call fails */
>    free(darg.dname);
> +
>    return ret;
> }
>=20
> diff --git a/lib/ext2fs/swapfs.c b/lib/ext2fs/swapfs.c
> index 1006b2d2..cd160b31 100644
> --- a/lib/ext2fs/swapfs.c
> +++ b/lib/ext2fs/swapfs.c
> @@ -244,7 +244,7 @@ void ext2fs_swap_inode_full(ext2_filsys fs, struct ext=
2_inode_large *t,
>                int bufsize)
> {
>    unsigned i, extra_isize, attr_magic;
> -    int has_extents, has_inline_data, islnk, fast_symlink;
> +    int has_extents =3D 0, has_inline_data =3D 0, islnk =3D 0, fast_symli=
nk =3D 0;
>    unsigned int inode_size;
>    __u32 *eaf, *eat;
>=20
> --=20
> 2.25.1
>=20
