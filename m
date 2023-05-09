Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09C1D6FBE4A
	for <lists+linux-ext4@lfdr.de>; Tue,  9 May 2023 06:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbjEIEjY (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 9 May 2023 00:39:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjEIEjK (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 9 May 2023 00:39:10 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A594E59D4
        for <linux-ext4@vger.kernel.org>; Mon,  8 May 2023 21:39:08 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-50bc040c7b8so8312604a12.2
        for <linux-ext4@vger.kernel.org>; Mon, 08 May 2023 21:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683607147; x=1686199147;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dZd/EoUG1Oy6dnThAfawpwd7wGRkAsduuVAoZxEldNA=;
        b=RjNV2RJuz0FBij2ryTQgPNE9cN0wo/zZd9WmkXb5yONOccyXZX61gWyCxFpp95wtmp
         WvYqwFY0+4xYE96Nvdpd33NljnStcTNrIOP4sagdnXir4sfk3N1voaAC7o8kn0iFMUOP
         0/2G3OXOfHJ2vjGhsEq4/6zgSOabvozREEWnfMlNYwprXCEQd3y1rI19Uwb/KxN1P4Qc
         J/pan+ZYuST2EImG6DRJA1jNN3YTZfrd3XK1SPyMGMNVVo/T1iisPfiGaddfe4V/yeWg
         dyqe1qOBjmeiF3SKT5Yg4sTbzypNFVACrVumjZ+EfEmtD56SVZF82vE8nmUF4fo+zLoR
         CufA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683607147; x=1686199147;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dZd/EoUG1Oy6dnThAfawpwd7wGRkAsduuVAoZxEldNA=;
        b=E4uU4PWqRoce1a0lCKJwlpuIQY3Ss2Pyztwnvf7FexQlDqZj9+QKru8M8VMtjyQlS0
         +/XZOshtex95LugBlDgUg90SoD5UYl1mQZUYxSBhmxTAJteW+W2bq1bK+HmusO7PfO2P
         8cyZ5qg5g2yyU8JiTyBTsGAw0V1nT6e8W/dHRhNrO5z8bUWhZ99Li5GC0h+H/mW9LPll
         ZPnBcgKg/ZwZnJHRUCrOvq4WE5yt+UwF5XEltTytQ1ifiGpjtF2Cc8KBXZ/MT/Utabud
         X3dme6xOc7TnVa9IzGUueJPOA/BYuyZWnLsm6inUUY2/mh8+aAOV7XxtC13gBIyP0zrr
         erQg==
X-Gm-Message-State: AC+VfDwP4h1O5SwZqjuoh0ajRgqOsIhnDjr4d18BgoJvdJpw/lmlE2FH
        b2YNlool6k9VKqsuK3/B05PnIYxvIjOMbli0eig=
X-Google-Smtp-Source: ACHHUZ6fuEhGNdzH6D65jjfoa+0Meq2NZmNEI9ZlppP4yqB4GSxy+gaq4+poidR3Qp8xJ540/+5Z0QcswCIbBZUMAAc=
X-Received: by 2002:aa7:cb83:0:b0:506:9f5f:5c9c with SMTP id
 r3-20020aa7cb83000000b005069f5f5c9cmr9830848edt.25.1683607146994; Mon, 08 May
 2023 21:39:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230509011042.11781-1-sunjunchao2870@gmail.com>
In-Reply-To: <20230509011042.11781-1-sunjunchao2870@gmail.com>
From:   JunChao Sun <sunjunchao2870@gmail.com>
Date:   Tue, 9 May 2023 12:38:54 +0800
Message-ID: <CAHB1NajWfFXWuO=Hh6TQiXise+_zp1EunXZML1vWVmqy4OJVbg@mail.gmail.com>
Subject: Re: [PATCH] ext4: Reduce time overhead for replacing xattr values.
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     jack@suse.cz, tahsin@google.com, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

JunChao Sun <sunjunchao2870@gmail.com> =E4=BA=8E2023=E5=B9=B45=E6=9C=889=E6=
=97=A5=E5=91=A8=E4=BA=8C 09:10=E5=86=99=E9=81=93=EF=BC=9A
>
> When replace the value of xattr which found in an ea_inode, currently
> ext4 will evict ea_inode which stores the old value, recreate an
> ea_inode and then write the new value into new ea_inode. This can
> be optimized by writing the new value into old ea_inode directly.
>
> The logic for replacing the value of xattr without this patch
> is as follows:
> ext4_xattr_set_entry()
>   ->ext4_xattr_inode_iget(&old_ea_inode)
>   ->ext4_xattr_inode_lookup_create(&new_ea_inode)
>   ->ext4_xattr_inode_dec_ref(old_ea_inode)
>   ->iput(old_ea_inode)
>       ->ext4_destroy_inode()
>       ->ext4_evict_inode()
>       ->ext4_free_inode()
>   ->iput(new_ea_inode)
>
> The logic with this patch is:
> ext4_xattr_set_entry()
>   ->ext4_xattr_inode_iget(&old_ea_inode)
>   ->ext4_xattr_inode_write(old_ea_inode, new_value)
>   ->iput(old_ea_inode)
>
> This patch reduces the time it takes to replace xattr in ext4.
> Without this patch, replacing the value of xattr two million times takes
> about 45 seconds on Intel(R) Xeon(R) CPU E5-2620 v3 platform.
> With this patch, the same operation takes only 6 seconds.
>
> [root@client01 sjc]# ./mount.sh
> /dev/sdb1 contains a ext4 file system
>     last mounted on /mnt/ext4 on Mon May  8 17:05:38 2023
> [root@client01 sjc]# touch /mnt/ext4/file1
> [root@client01 sjc]# gcc test.c
> [root@client01 sjc]# time ./a.out
>
> real    0m45.248s
> user    0m0.513s
> sys 0m39.231s
>
> [root@client01 sjc]# ./mount.sh
> /dev/sdb1 contains a ext4 file system
>     last mounted on /mnt/ext4 on Mon May  8 17:08:20 2023
> [root@client01 sjc]# touch /mnt/ext4/file1
> [root@client01 sjc]# time ./a.out
>
> real    0m5.977s
> user    0m0.316s
> sys 0m5.659s
>
> The test.c and mount.sh are in [1].
> This patch passed the tests with xfstests using 'check -g quick'.
>
> [1]: https://gist.github.com/sjc2870/c923d7fa627d10ab65d6c305afb02cdb
>
> Signed-off-by: JunChao Sun <sunjunchao2870@gmail.com>
> ---
>  fs/ext4/xattr.c | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
>
> diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
> index d57408cbe903..37f79594ac70 100644
> --- a/fs/ext4/xattr.c
> +++ b/fs/ext4/xattr.c
> @@ -1713,6 +1713,39 @@ static int ext4_xattr_set_entry(struct ext4_xattr_=
info *i,
>                 }
>         }
>
> +       if (!s->not_found && i->value && here->e_value_inum && i->in_inod=
e) {
> +               /* Replace xattr value in ea_inode in place */
> +               int size_diff =3D i->value_len - le32_to_cpu(here->e_valu=
e_size);
> +
> +               ret =3D ext4_xattr_inode_iget(inode,
> +                                               le32_to_cpu(here->e_value=
_inum),
> +                                               le32_to_cpu(here->e_hash)=
,
> +                                               &old_ea_inode);
> +               if (ret) {
> +                       old_ea_inode =3D NULL;
> +                       goto out;
> +               }
>
> > +               if (size_diff > 0)
> > +                       ret =3D ext4_xattr_inode_alloc_quota(inode, siz=
e_diff);
> > +               else if (size_diff < 0)
> > +                       ext4_xattr_inode_free_quota(inode, NULL, -size_=
diff);
> > +               if (ret)
> > +                       goto out;
> > +
> > +               ret =3D ext4_xattr_inode_write(handle, old_ea_inode, i-=
>value, i->value_len);
> > +               if (ret) {
> > +                       if (size_diff > 0)
> > +                               ext4_xattr_inode_free_quota(inode, NULL=
, size_diff);
> > +                       else if (size_diff < 0)
> > +                               ret =3D ext4_xattr_inode_alloc_quota(in=
ode, -size_diff);
> > +                       goto out;
> > +               }
Here might missed a judgment condition: if
(ext4_xattr_inodee_get_ref(old_ea_inode) =3D=3D 1). I will send patch v2
to fix this.

> +               here->e_value_size =3D cpu_to_le32(i->value_len);
> +               new_ea_inode =3D old_ea_inode;
> +               old_ea_inode =3D NULL;
> +               goto update_hash;
> +       }
> +
>         /*
>          * Getting access to old and new ea inodes is subject to failures=
.
>          * Finish that work before doing any modifications to the xattr d=
ata.
> --
> 1.8.3.1
>
