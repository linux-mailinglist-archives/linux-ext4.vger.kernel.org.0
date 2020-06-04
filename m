Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D387A1EEB2D
	for <lists+linux-ext4@lfdr.de>; Thu,  4 Jun 2020 21:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728809AbgFDTbo (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 4 Jun 2020 15:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbgFDTbn (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 4 Jun 2020 15:31:43 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A308EC08C5C0
        for <linux-ext4@vger.kernel.org>; Thu,  4 Jun 2020 12:31:43 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id b5so3725389pfp.9
        for <linux-ext4@vger.kernel.org>; Thu, 04 Jun 2020 12:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=kHwANpdmUkrTfxwqS86A1kJbf7bf2zHr7UBG62ZQT/w=;
        b=XfE/71riLd3x6A1wPiokNxKOJ2OLJyePMB22AJlzHJ2lkVs5Ara0QCrx0iiBBa28nj
         ScffRJreVbWy/f8fRXWTiWWTDe9jivl/hGeRTZOoYOFSReHaqL/GsyP30UGvRTLS4ZSO
         YxGW7Re4DuTxWZDtpIg7P66qB0tGde/X6QL/pAAGMlUJqm/1RMxyMr8jZmEgOky+oswF
         DuEFwC22y84wNCMEKDUtox7/hE+QDZs6sRR73RfrwlmoWbAuXpCWVNkg+r4aWQZqpbwr
         G6hmh2ohJPpjR88BhdLfmzQvibE2+UqDCBUq5jqDCoPAi2h/kmnfmbt9kOm2k7gHXd8J
         YAPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=kHwANpdmUkrTfxwqS86A1kJbf7bf2zHr7UBG62ZQT/w=;
        b=jl5+61hzPnOCvSV+NKsj+paBP3KHjfZtCvAdZ3HUlb97i+YNQzeeF95GD6Lf00byOA
         9iNl6pXU8VOMESnrj35/eF9W47GbDxcSvK3hRRSdvHdp96143N97LRIlUi6TEZ54OzGK
         gxwww4CnjmNq9ZX01sqpEeGTaRyet8QJwG1/EVdbzJbAkiMvVg+eoe6Yev6yStU9e6Q/
         8I0eNynDzhPjOuDtPDg0MnqF+Nj0VLigG+Fk+CsEwdT8qBlhO1dsT+9ehqlpxsgxtQz7
         HsuLmq8IqMlGo1zdvYLMttLTzfU2ks18t8ThPpc833ePq4qLm4ljnqQPTXwsiMPKWyx9
         8emQ==
X-Gm-Message-State: AOAM530aVWvOPWAQu08PEFD8ESa7M1h+jDG9Z11JFl0zctx2jCwCW9XL
        +in48d8xIZrZncRUxPOLuJPPBmOA65JUFQ==
X-Google-Smtp-Source: ABdhPJw1Q07XlANhMJ09cmattoe+pY8WqA6DISMU6FykDFSrqYlFp4vgUcec8QOPl7G1eYyjSoHWpg==
X-Received: by 2002:a62:6846:: with SMTP id d67mr5953861pfc.167.1591299102797;
        Thu, 04 Jun 2020 12:31:42 -0700 (PDT)
Received: from [192.168.10.175] (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id y6sm5555105pfp.144.2020.06.04.12.31.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jun 2020 12:31:41 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andreas Dilger <adilger@dilger.ca>
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC PATCH] ext2: drop cached block when detecting corruption
Date:   Thu, 4 Jun 2020 13:31:40 -0600
Message-Id: <B50814CC-57FB-4FDE-887B-3608C61AAF22@dilger.ca>
References: <20200603094417.6143-1-cgxu519@mykernel.net>
Cc:     jack@suse.com, linux-ext4@vger.kernel.org
In-Reply-To: <20200603094417.6143-1-cgxu519@mykernel.net>
To:     Chengguang Xu <cgxu519@mykernel.net>
X-Mailer: iPhone Mail (17E262)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Jun 3, 2020, at 03:44, Chengguang Xu <cgxu519@mykernel.net> wrote:
>=20
> =EF=BB=BFCurrently ext2 uses mdcache for deduplication of extended

(typo) this should be "mbcache"


> attribution blocks. However, there is lack of handling for
> corrupted blocks, so newly created EAs may still links to
> corrupted blocks. This patch tries to drop cached block
> when detecting corruption to mitigate the effect.
>=20
> Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
> ---
> fs/ext2/xattr.c | 25 ++++++++++++++++++++++---
> 1 file changed, 22 insertions(+), 3 deletions(-)
>=20
> diff --git a/fs/ext2/xattr.c b/fs/ext2/xattr.c
> index 943cc469f42f..969521e39753 100644
> --- a/fs/ext2/xattr.c
> +++ b/fs/ext2/xattr.c
> @@ -93,6 +93,8 @@ static int ext2_xattr_set2(struct inode *, struct buffer=
_head *,
>               struct ext2_xattr_header *);
>=20
> static int ext2_xattr_cache_insert(struct mb_cache *, struct buffer_head *=
);
> +static void ext2_xattr_cache_remove(struct mb_cache *cache,
> +                    struct buffer_head *bh);
> static struct buffer_head *ext2_xattr_cache_find(struct inode *,
>                         struct ext2_xattr_header *);
> static void ext2_xattr_rehash(struct ext2_xattr_header *,
> @@ -237,8 +239,10 @@ ext2_xattr_get(struct inode *inode, int name_index, c=
onst char *name,
>    entry =3D FIRST_ENTRY(bh);
>    while (!IS_LAST_ENTRY(entry)) {
>        if (!ext2_xattr_entry_valid(entry, end,
> -            inode->i_sb->s_blocksize))
> +            inode->i_sb->s_blocksize)) {
> +            ext2_xattr_cache_remove(ea_block_cache, bh);
>            goto bad_block;
> +        }
>=20
>        not_found =3D ext2_xattr_cmp_entry(name_index, name_len, name,
>                         entry);
> @@ -323,8 +327,10 @@ ext2_xattr_list(struct dentry *dentry, char *buffer, s=
ize_t buffer_size)
>    entry =3D FIRST_ENTRY(bh);
>    while (!IS_LAST_ENTRY(entry)) {
>        if (!ext2_xattr_entry_valid(entry, end,
> -            inode->i_sb->s_blocksize))
> +            inode->i_sb->s_blocksize)) {
> +            ext2_xattr_cache_remove(ea_block_cache, bh);
>            goto bad_block;
> +        }
>        entry =3D EXT2_XATTR_NEXT(entry);
>    }
>    if (ext2_xattr_cache_insert(ea_block_cache, bh))
> @@ -407,6 +413,7 @@ int
> ext2_xattr_set(struct inode *inode, int name_index, const char *name,
>           const void *value, size_t value_len, int flags)
> {
> +    struct mb_cache *ea_block_cache =3D EA_BLOCK_CACHE(inode);
>    struct super_block *sb =3D inode->i_sb;
>    struct buffer_head *bh =3D NULL;
>    struct ext2_xattr_header *header =3D NULL;
> @@ -464,8 +471,11 @@ ext2_xattr_set(struct inode *inode, int name_index, c=
onst char *name,
>         */
>        last =3D FIRST_ENTRY(bh);
>        while (!IS_LAST_ENTRY(last)) {
> -            if (!ext2_xattr_entry_valid(last, end, sb->s_blocksize))
> +            if (!ext2_xattr_entry_valid(last, end,
> +                sb->s_blocksize)) {
> +                ext2_xattr_cache_remove(ea_block_cache, bh);
>                goto bad_block;
> +            }
>            if (last->e_value_size) {
>                size_t offs =3D le16_to_cpu(last->e_value_offs);
>                if (offs < min_offs)
> @@ -881,6 +891,15 @@ ext2_xattr_cache_insert(struct mb_cache *cache, struc=
t buffer_head *bh)
>    return error;
> }
>=20
> +static void
> +ext2_xattr_cache_remove(struct mb_cache *cache, struct buffer_head *bh)
> +{
> +    lock_buffer(bh);
> +    mb_cache_entry_delete(cache, le32_to_cpu(HDR(bh)->h_hash),
> +                  bh->b_blocknr);
> +    unlock_buffer(bh);
> +}
> +
> /*
>  * ext2_xattr_cmp()
>  *
> --=20
> 2.20.1
>=20
>=20
