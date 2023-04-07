Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D7CE6DAC8A
	for <lists+linux-ext4@lfdr.de>; Fri,  7 Apr 2023 14:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240681AbjDGMHD (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 7 Apr 2023 08:07:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240678AbjDGMHC (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 7 Apr 2023 08:07:02 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACEBC83CD;
        Fri,  7 Apr 2023 05:07:00 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id jw24so7952197ejc.3;
        Fri, 07 Apr 2023 05:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680869219;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jXlaemFtjtiJ1gAlIOppQhgAX2mfWVMEpWYA0pzSXiQ=;
        b=VAh1GnKoboOmtKqMxwb4BFhiiYVBGgax3HThjASD9ygRQnI3gbhg3ykwtPvFZAAy71
         MxE3Dm5BxPIZiJuQFooYAqGTiDf7sfJuhxuwkzkw8R/htJSK3dNjoDu6RUHRy9WiSDRH
         is9ZzDQv6m/8cbmbNI7FrkH/oZxBvbE2yNW3ukKdnDunPmBcSdA2+TvL6Z/d4/m2yT+O
         eg/Yi94GrcuvOZ5N2EoP4Lx2WenK7rwAEC6F1tKlPxyVjSI3L0mDaOFUrTYX9ehubaKL
         JFTlLVs3wR4S6vW344L7gqZ0eUF2uxm5kx5vDTLGn2qwsXdeoZo4ui5NG7qYnEe4XbDe
         g5WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680869219;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jXlaemFtjtiJ1gAlIOppQhgAX2mfWVMEpWYA0pzSXiQ=;
        b=jT0LcyMRw/evnN5HRJd7LHy1YTouDn7BDB5DN0m1h5jsrs5ILT29Gq+lKPTLTCM/dx
         dpIWzkU4tb9SddLyuf3Ns5dlC/nfxD6XP7PCU2qBn8Uo1mdQdOokIRKy0Nq0jec5J8Hm
         ht8qGwewfevSpc491JHGqDyq+4IQPqDF9Ngh9UwnoBd3s4fhvopjfgPakl72ZG3P2NIO
         GbRQ2bLfSs8Ec6bsUk1QooL2fZ/ORZ1Tqz5sCACONwaSLJMOmM1NpsYFYgVOhg1M0ZvW
         5OXqkEe++lEfY01YRBLr67z8kKonYLGaYMfksHPjYYzLmCXHtrx9Zqcilk9V/+sH979V
         KgHg==
X-Gm-Message-State: AAQBX9fH40aH+fFsvPBdSn1wPPSTONSdRzVsF2VtOCenRyVPSR0i/X28
        FFHy84aDGvkW7my+vLR4iCQw9cz/007TL/mUlExekPes
X-Google-Smtp-Source: AKy350aFttHQw0xSrB5OHnPKtoG+omDJ6tUpsUOYuNQNWEP8xEQDKiiLiUVGo6q/aa/srbI+R89dOuDtNAq/5/JyaGo=
X-Received: by 2002:a17:906:f990:b0:946:a215:74c7 with SMTP id
 li16-20020a170906f99000b00946a21574c7mr991366ejb.12.1680869218692; Fri, 07
 Apr 2023 05:06:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230402013000.73713-1-sunjunchao2870@gmail.com>
In-Reply-To: <20230402013000.73713-1-sunjunchao2870@gmail.com>
From:   JunChao Sun <sunjunchao2870@gmail.com>
Date:   Fri, 7 Apr 2023 20:06:44 +0800
Message-ID: <CAHB1NahWmNX7ADXn0a3SVhz5+4Cdg5neZ9jHpqnERFVC-v0Ftw@mail.gmail.com>
Subject: Re: [PATCH v2] ext4: fix performance issue of xattr when expanding inode
To:     linux-ext4@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     tytso@mit.edu, jun.nie@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Friendly ping...

JunChao Sun <sunjunchao2870@gmail.com> =E4=BA=8E2023=E5=B9=B44=E6=9C=882=E6=
=97=A5=E5=91=A8=E6=97=A5 09:30=E5=86=99=E9=81=93=EF=BC=9A
>
> Currently ext4 will delete ea entry from ibody and recreate ea entry
> which store the same value when expanding inode. The main performance
> issue is caused by the fact that ext4 will destroy and recreate the
> ea inode, and such behavior is redundant.
>
> The patch is a bit ugly, because ext4_xattr_set_entry() contains the
> creating,deleting,replacing of xattr without external intervention,
> this looks good. But the movement of ea entry from ibody to block
> breaks this, so add an argument for ext4_xattr_set_entry() for this
> break, and then ext4_xattr_block_set() will reuse the ea_inode instead
> of recreating an ea_inode which store the same value.
>
> Signed-off-by: JunChao Sun <sunjunchao2870@gmail.com>
> ---
>  fs/ext4/xattr.c | 99 ++++++++++++++++++++++++++++++++++++++++---------
>  1 file changed, 81 insertions(+), 18 deletions(-)
>
> diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
> index 767454d74cd6..439581e630d4 100644
> --- a/fs/ext4/xattr.c
> +++ b/fs/ext4/xattr.c
> @@ -1634,7 +1634,7 @@ static int ext4_xattr_inode_lookup_create(handle_t =
*handle, struct inode *inode,
>  static int ext4_xattr_set_entry(struct ext4_xattr_info *i,
>                                 struct ext4_xattr_search *s,
>                                 handle_t *handle, struct inode *inode,
> -                               bool is_block)
> +                               bool is_block, struct inode *mv_ea_inode)
>  {
>         struct ext4_xattr_entry *last, *next;
>         struct ext4_xattr_entry *here =3D s->here;
> @@ -1727,7 +1727,7 @@ static int ext4_xattr_set_entry(struct ext4_xattr_i=
nfo *i,
>                         goto out;
>                 }
>         }
> -       if (i->value && in_inode) {
> +       if (i->value && in_inode && !mv_ea_inode) {
>                 WARN_ON_ONCE(!i->value_len);
>
>                 ret =3D ext4_xattr_inode_alloc_quota(inode, i->value_len)=
;
> @@ -1819,7 +1819,9 @@ static int ext4_xattr_set_entry(struct ext4_xattr_i=
nfo *i,
>
>         if (i->value) {
>                 /* Insert new value. */
> -               if (in_inode) {
> +               if (in_inode && mv_ea_inode) {
> +                       here->e_value_inum =3D cpu_to_le32(mv_ea_inode->i=
_ino);
> +               } else if (in_inode) {
>                         here->e_value_inum =3D cpu_to_le32(new_ea_inode->=
i_ino);
>                 } else if (i->value_len) {
>                         void *val =3D s->base + min_offs - new_size;
> @@ -1838,7 +1840,7 @@ static int ext4_xattr_set_entry(struct ext4_xattr_i=
nfo *i,
>         }
>
>  update_hash:
> -       if (i->value) {
> +       if (i->value && !mv_ea_inode) {
>                 __le32 hash =3D 0;
>
>                 /* Entry hash calculation. */
> @@ -1922,7 +1924,7 @@ ext4_xattr_block_find(struct inode *inode, struct e=
xt4_xattr_info *i,
>  static int
>  ext4_xattr_block_set(handle_t *handle, struct inode *inode,
>                      struct ext4_xattr_info *i,
> -                    struct ext4_xattr_block_find *bs)
> +                    struct ext4_xattr_block_find *bs, struct inode *mv_e=
a_inode)
>  {
>         struct super_block *sb =3D inode->i_sb;
>         struct buffer_head *new_bh =3D NULL;
> @@ -1972,7 +1974,7 @@ ext4_xattr_block_set(handle_t *handle, struct inode=
 *inode,
>                         }
>                         ea_bdebug(bs->bh, "modifying in-place");
>                         error =3D ext4_xattr_set_entry(i, s, handle, inod=
e,
> -                                                    true /* is_block */)=
;
> +                                                    true /* is_block */,=
 NULL);
>                         ext4_xattr_block_csum_set(inode, bs->bh);
>                         unlock_buffer(bs->bh);
>                         if (error =3D=3D -EFSCORRUPTED)
> @@ -2040,7 +2042,7 @@ ext4_xattr_block_set(handle_t *handle, struct inode=
 *inode,
>                 s->end =3D s->base + sb->s_blocksize;
>         }
>
> -       error =3D ext4_xattr_set_entry(i, s, handle, inode, true /* is_bl=
ock */);
> +       error =3D ext4_xattr_set_entry(i, s, handle, inode, true /* is_bl=
ock */, mv_ea_inode);
>         if (error =3D=3D -EFSCORRUPTED)
>                 goto bad_block;
>         if (error)
> @@ -2286,7 +2288,7 @@ int ext4_xattr_ibody_set(handle_t *handle, struct i=
node *inode,
>         if (!EXT4_INODE_HAS_XATTR_SPACE(inode))
>                 return -ENOSPC;
>
> -       error =3D ext4_xattr_set_entry(i, s, handle, inode, false /* is_b=
lock */);
> +       error =3D ext4_xattr_set_entry(i, s, handle, inode, false /* is_b=
lock */, NULL);
>         if (error)
>                 return error;
>         header =3D IHDR(inode, ext4_raw_inode(&is->iloc));
> @@ -2429,7 +2431,7 @@ ext4_xattr_set_handle(handle_t *handle, struct inod=
e *inode, int name_index,
>                 if (!is.s.not_found)
>                         error =3D ext4_xattr_ibody_set(handle, inode, &i,=
 &is);
>                 else if (!bs.s.not_found)
> -                       error =3D ext4_xattr_block_set(handle, inode, &i,=
 &bs);
> +                       error =3D ext4_xattr_block_set(handle, inode, &i,=
 &bs, NULL);
>         } else {
>                 error =3D 0;
>                 /* Xattr value did not change? Save us some work and bail=
 out */
> @@ -2446,7 +2448,7 @@ ext4_xattr_set_handle(handle_t *handle, struct inod=
e *inode, int name_index,
>                 error =3D ext4_xattr_ibody_set(handle, inode, &i, &is);
>                 if (!error && !bs.s.not_found) {
>                         i.value =3D NULL;
> -                       error =3D ext4_xattr_block_set(handle, inode, &i,=
 &bs);
> +                       error =3D ext4_xattr_block_set(handle, inode, &i,=
 &bs, NULL);
>                 } else if (error =3D=3D -ENOSPC) {
>                         if (EXT4_I(inode)->i_file_acl && !bs.s.base) {
>                                 brelse(bs.bh);
> @@ -2455,7 +2457,7 @@ ext4_xattr_set_handle(handle_t *handle, struct inod=
e *inode, int name_index,
>                                 if (error)
>                                         goto cleanup;
>                         }
> -                       error =3D ext4_xattr_block_set(handle, inode, &i,=
 &bs);
> +                       error =3D ext4_xattr_block_set(handle, inode, &i,=
 &bs, NULL);
>                         if (!error && !is.s.not_found) {
>                                 i.value =3D NULL;
>                                 error =3D ext4_xattr_ibody_set(handle, in=
ode, &i,
> @@ -2615,6 +2617,10 @@ static int ext4_xattr_move_to_block(handle_t *hand=
le, struct inode *inode,
>                 .in_inode =3D !!entry->e_value_inum,
>         };
>         struct ext4_xattr_ibody_header *header =3D IHDR(inode, raw_inode)=
;
> +       struct ext4_xattr_entry *here =3D NULL, *last =3D NULL, *next =3D=
 NULL;
> +       struct inode *old_ea_inode =3D NULL;
> +       size_t name_size =3D EXT4_XATTR_LEN(entry->e_name_len);
> +       size_t min_offs;
>         int error;
>
>         is =3D kzalloc(sizeof(struct ext4_xattr_ibody_find), GFP_NOFS);
> @@ -2660,20 +2666,76 @@ static int ext4_xattr_move_to_block(handle_t *han=
dle, struct inode *inode,
>
>         i.value =3D buffer;
>         i.value_len =3D value_size;
> +       here =3D is->s.here;
> +       last =3D is->s.first;
> +       min_offs =3D is->s.end - is->s.base;
> +       /* Compute min_offs and last entry */
> +       for (; !IS_LAST_ENTRY(last); last =3D next) {
> +               next =3D EXT4_XATTR_NEXT(last);
> +               if ((void *)next >=3D is->s.end) {
> +                       EXT4_ERROR_INODE(inode, "corrupted xattr entries"=
);
> +                       error =3D -EFSCORRUPTED;
> +                       goto out;
> +               }
> +               if (!last->e_value_inum && last->e_value_size) {
> +                       size_t offs =3D le16_to_cpu(last->e_value_offs);
> +
> +                       if (offs < min_offs)
> +                               min_offs =3D offs;
> +               }
> +       }
> +
> +       /* Remove the name in ibody */
> +       last =3D ENTRY((void *)last - name_size);
> +       memmove(here, (void *)here + name_size,
> +               (void *)last - (void *)here + sizeof(__u32));
> +       memset(last, 0, name_size);
> +
> +       /* Get the ea_inode which store the old value */
> +       if (here->e_value_inum) {
> +               error =3D ext4_xattr_inode_iget(inode,
> +                                           le32_to_cpu(here->e_value_inu=
m),
> +                                           le32_to_cpu(here->e_hash),
> +                                           &old_ea_inode);
> +               if (error) {
> +                       old_ea_inode =3D NULL;
> +                       goto out;
> +               }
> +       } else if (here->e_value_size) {
> +               /* Remove the old value in ibody */
> +               void *first_val =3D is->s.base + min_offs;
> +               void *rm_val =3D is->s.base + le16_to_cpu(here->e_value_o=
ffs);
> +               size_t rm_size =3D EXT4_XATTR_SIZE(le32_to_cpu(here->e_va=
lue_size));
> +               size_t offs =3D le16_to_cpu(here->e_value_offs);
> +
> +               memmove(first_val + rm_size, first_val, rm_val - first_va=
l);
> +               memset(first_val, 0, rm_size);
> +               min_offs +=3D rm_size;
> +
> +               /* Adjust all value offsets */
> +               last =3D is->s.first;
> +               while (!IS_LAST_ENTRY(last)) {
> +                       size_t o =3D le16_to_cpu(last->e_value_offs);
> +
> +                       if (!last->e_value_inum &&
> +                           last->e_value_size && o < offs)
> +                               last->e_value_offs =3D cpu_to_le16(o + rm=
_size);
> +                       last =3D EXT4_XATTR_NEXT(last);
> +               }
> +       }
> +
>         error =3D ext4_xattr_block_find(inode, &i, bs);
>         if (error)
>                 goto out;
>
> -       /* Move ea entry from the inode into the block */
> -       error =3D ext4_xattr_block_set(handle, inode, &i, bs);
> +       /*
> +        * Move ea entry from the inode into the block, and do not need t=
o
> +        * recreate an ea_inode that store the same value.
> +        */
> +       error =3D ext4_xattr_block_set(handle, inode, &i, bs, old_ea_inod=
e);
>         if (error)
>                 goto out;
>
> -       /* Remove the chosen entry from the inode */
> -       i.value =3D NULL;
> -       i.value_len =3D 0;
> -       error =3D ext4_xattr_ibody_set(handle, inode, &i, is);
> -
>  out:
>         kfree(b_entry_name);
>         if (entry->e_value_inum && buffer)
> @@ -2684,6 +2746,7 @@ static int ext4_xattr_move_to_block(handle_t *handl=
e, struct inode *inode,
>                 brelse(bs->bh);
>         kfree(is);
>         kfree(bs);
> +       iput(old_ea_inode);
>
>         return error;
>  }
> --
> 2.17.1
>
