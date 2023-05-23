Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1234D70DBF7
	for <lists+linux-ext4@lfdr.de>; Tue, 23 May 2023 14:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236530AbjEWMHJ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 23 May 2023 08:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbjEWMHI (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 23 May 2023 08:07:08 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C252D109
        for <linux-ext4@vger.kernel.org>; Tue, 23 May 2023 05:07:06 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-510db954476so1252649a12.0
        for <linux-ext4@vger.kernel.org>; Tue, 23 May 2023 05:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684843618; x=1687435618;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vSSbEcfCTwTKkInK85giu7l+r0E6Z5EtUIfFTQ3q+a0=;
        b=EkCxoj4wVejkTapIHSKQMSIDWaHbnjzHgGU3UBHUZ9IWEP+KBAm5YqdZFxvfDjh+Lr
         YotZzM0Vk1smpMoGPJ0Ky9+Ho6w1ikVX59EAtb0X91IkAC7YCOpXyDlbSo2EDd2J1wUw
         OCsKE6LIxnvWnubx2iV0tbVjOmtgXw2XijdMWjyM6zc98xETw4vl6FKIWsUKYov3nbw6
         VTKRsuGOpsjCpnRJwKzabW0coXn8ZbW0YHC24Dq0h+J3k9TG+T9H+G5vtWoxASv/IBvJ
         +NWLG9SuZHx6YDTYTnmci39Rp/kadcGv4wijpTUk5wrK+fsxsRHq+yiT5PiJFGRj+eRM
         xi3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684843618; x=1687435618;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vSSbEcfCTwTKkInK85giu7l+r0E6Z5EtUIfFTQ3q+a0=;
        b=R8IKRQp2w4bE6UI90sUp4RnKMO7iTGzIWxhIlZdJZ4h2iK2rwrTTNf88tee/w8sn1M
         /Zx4JSAaFmoIt2BA0TTrilFbwebkFz9E3EVsQVmG4EwJMUHBYjbDB0/jNfVB9zxIK9Tb
         f021RPNfQRDo1/d9RSdwhGCrXMr61glal7Q7VECYtoQjqQZf3pszHwAvpesOcFHmSpbo
         o0mlFWyzTOyQS0sWvxjxgSTAo7x17AcegtcQHY7J0iutUEqQlmXPHkflz6U9k/Qu0HSf
         hPyYJziMeeL8zIztH0dZmLy9CYMRDZ2eeyDO8X4fAYdNHglP1Jp3knq74ZcWTuHjeOZx
         uZNA==
X-Gm-Message-State: AC+VfDy5gS7sgrwz5oTJJLoHiCKSGk3ru1ybQXfLy0yuoDvNTPyXcLUb
        WaVE4Sc0x8D0LSIH0XBPwbyiu+0wAJQspU/7+hM=
X-Google-Smtp-Source: ACHHUZ6N60auvTxN9bTXf0SUi61DdpLup+oKWMlxMrb8aZtLGPv3bbl5oBvknD0N+vDgKlHzlYWScrJrHW0IpDLne3s=
X-Received: by 2002:a17:907:1693:b0:96f:9962:be19 with SMTP id
 hc19-20020a170907169300b0096f9962be19mr11877722ejc.31.1684843617844; Tue, 23
 May 2023 05:06:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230510001409.14522-1-sunjunchao2870@gmail.com>
In-Reply-To: <20230510001409.14522-1-sunjunchao2870@gmail.com>
From:   JunChao Sun <sunjunchao2870@gmail.com>
Date:   Tue, 23 May 2023 20:06:44 +0800
Message-ID: <CAHB1NahwmPEm8dT=27y8rQ0ZBBe6HC7jwM4F0XchJhKTZLhkqQ@mail.gmail.com>
Subject: Re: [PATCH v2] ext4: Replace value of xattrs in place
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     jack@suse.cz, linux-ext4@vger.kernel.org
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

Friendly ping...
Could anyone review this patch?

JunChao Sun <sunjunchao2870@gmail.com> =E4=BA=8E2023=E5=B9=B45=E6=9C=8810=
=E6=97=A5=E5=91=A8=E4=B8=89 08:14=E5=86=99=E9=81=93=EF=BC=9A
>
> When replacing the value of an xattr found in an ea_inode, currently
> ext4 will evict the ea_inode that stores the old value, recreate an
> ea_inode, and then write the new value into the new ea_inode.
> This can be optimized by writing the new value into the old
> ea_inode directly.
>
> The logic for replacing value of xattrs without this patch
> is as follows:
> ext4_xattr_set_entry()
>     ->ext4_xattr_inode_iget(&old_ea_inode)
>     ->ext4_xattr_inode_lookup_create(&new_ea_inode)
>     ->ext4_xattr_inode_dec_ref(old_ea_inode)
>     ->iput(old_ea_inode)
>         ->ext4_destroy_inode()
>         ->ext4_evict_inode()
>         ->ext4_free_inode()
>     ->iput(new_ea_inode)
>
> The logic with this patch is:
> ext4_xattr_set_entry()
>     ->ext4_xattr_inode_iget(&old_ea_inode)
>     ->ext4_xattr_inode_write(old_ea_inode, new_value)
>     ->iput(old_ea_inode)
>
> This patch reduces the time it takes to replace xattrs in the ext4.
> Without this patch, replacing the value of an xattr two million times tak=
es
> about 45 seconds on Intel(R) Xeon(R) CPU E5-2620 v3 platform.
> With this patch, the same operation takes only 6 seconds.
>
>   [root@client01 sjc]# ./mount.sh
>   /dev/sdb1 contains a ext4 file system
>       last mounted on /mnt/ext4 on Mon May  8 17:05:38 2023
>   [root@client01 sjc]# touch /mnt/ext4/file1
>   [root@client01 sjc]# gcc test.c
>   [root@client01 sjc]# time ./a.out
>
>   real    0m45.248s
>   user    0m0.513s
>   sys 0m39.231s
>
>   [root@client01 sjc]# ./mount.sh
>   /dev/sdb1 contains a ext4 file system
>       last mounted on /mnt/ext4 on Mon May  8 17:08:20 2023
>   [root@client01 sjc]# touch /mnt/ext4/file1
>   [root@client01 sjc]# time ./a.out
>
>   real    0m5.977s
>   user    0m0.316s
>   sys 0m5.659s
>
> The test.c and mount.sh are in [1].
> This patch passed the tests with xfstests using 'check -g quick'.
>
> [1] https://gist.github.com/sjc2870/c923d7fa627d10ab65d6c305afb02cdb
>
> Signed-off-by: JunChao Sun <sunjunchao2870@gmail.com>
> ---
>
> Changes in v2:
>   - Fix a problem when ref of an ea_inode not equal to 1
>   - Link to v1: https://lore.kernel.org/linux-ext4/20230509011042.11781-1=
-sunjunchao2870@gmail.com/
>
>  fs/ext4/xattr.c | 36 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
>
> diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
> index d57408cbe903..8f03958bfcc6 100644
> --- a/fs/ext4/xattr.c
> +++ b/fs/ext4/xattr.c
> @@ -1713,6 +1713,42 @@ static int ext4_xattr_set_entry(struct ext4_xattr_=
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
> +               if (ext4_xattr_inode_get_ref(old_ea_inode) =3D=3D 1) {
> +                       if (size_diff > 0)
> +                               ret =3D ext4_xattr_inode_alloc_quota(inod=
e, size_diff);
> +                       else if (size_diff < 0)
> +                               ext4_xattr_inode_free_quota(inode, NULL, =
-size_diff);
> +                       if (ret)
> +                               goto out;
> +
> +                       ret =3D ext4_xattr_inode_write(handle, old_ea_ino=
de, i->value, i->value_len);
> +                       if (ret) {
> +                               if (size_diff > 0)
> +                                       ext4_xattr_inode_free_quota(inode=
, NULL, size_diff);
> +                               else if (size_diff < 0)
> +                                       ret =3D ext4_xattr_inode_alloc_qu=
ota(inode, -size_diff);
> +                               goto out;
> +                       }
> +                       here->e_value_size =3D cpu_to_le32(i->value_len);
> +                       new_ea_inode =3D old_ea_inode;
> +                       old_ea_inode =3D NULL;
> +                       goto update_hash;
> +               } else
> +                       iput(old_ea_inode);
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
